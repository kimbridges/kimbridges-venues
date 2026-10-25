# ==============================================================================
# locate_places.R -- PubMaps step 2: LOCATE
# Give every extracted place a position, and say where each position came from.
#   coord_source: text | nominatim | geonames | none
#   match:        stated | exact | partial | suggestion (wrong feature kind; not placed) | none
#   flag:         ""  | far (well away from the rest of the study) | relative
# Positions stated in the manuscript are never overridden.
# The gazetteer is a backend: Nominatim (OpenStreetMap) now, GeoNames when the
# account answers. Both return the same candidate table.
# ==============================================================================

suppressPackageStartupMessages({
  library(httr2)
  library(countrycode)
})

PUBMAPS_UA <- "PubMaps/0.1 (kimbridges.com; study-site maps for journal editors)"

# ------------------------------------------------------------------------------
# Small helpers
# ------------------------------------------------------------------------------
norm_name <- function(x) {
  x <- tolower(iconv(x, from = "UTF-8", to = "ASCII//TRANSLIT", sub = ""))
  x[is.na(x)] <- ""
  x <- gsub("[^a-z0-9 ]", " ", x)
  gsub("\\s+", " ", trimws(x))
}

GENERIC_WORDS <- c("village", "villages", "settlement", "town", "city", "area",
                   "district", "subdistrict", "sub district", "province",
                   "municipality", "county", "region", "complex", "site", "the")

core_name <- function(x) {
  x <- norm_name(x)
  x <- gsub("^(mt|mount|mtn) ", "", x)
  for (w in GENERIC_WORDS) x <- gsub(paste0("\\b", w, "\\b"), "", x)
  gsub("\\s+", " ", trimws(x))
}

# query variants, most specific first
name_variants <- function(x) {
  v <- c(x, sub("^Mt\\.? ", "Mount ", x), core_name(x))
  unique(v[nzchar(v)])
}

name_sim <- function(q, cand) {
  a <- core_name(q); b <- core_name(cand)
  if (!nzchar(a) || !nzchar(b)) return(0)
  if (a == b) return(1)
  if (grepl(paste0("\\b", a, "\\b"), b) || grepl(paste0("\\b", b, "\\b"), a)) return(0.8)
  1 - adist(a, b)[1, 1] / max(nchar(a), nchar(b))
}

haversine_km <- function(lon1, lat1, lon2, lat2) {
  r <- pi / 180
  d <- sin((lat2 - lat1) * r / 2)^2 +
       cos(lat1 * r) * cos(lat2 * r) * sin((lon2 - lon1) * r / 2)^2
  2 * 6371 * asin(pmin(1, sqrt(d)))
}

# ------------------------------------------------------------------------------
# Role -> acceptable gazetteer feature kinds (a common vocabulary)
#   populated | protected | natural | water | admin | any
# ------------------------------------------------------------------------------
ROLE_KINDS <- list(
  study_site          = c("populated"),
  reference_town      = c("populated"),
  sampling_point      = c("populated", "natural", "water", "protected", "other"),
  protected_area      = c("protected"),
  natural_feature     = c("natural", "water"),
  administrative_unit = c("admin"),
  other               = c("populated", "natural", "water", "protected", "admin", "other")
)

# acceptable stand-ins, placed but marked partial: a town represented by the
# municipality or district of the same name (the gazetteer sometimes returns only that)
ROLE_FALLBACK <- list(study_site = "admin", reference_town = "admin")

osm_kind <- function(category, type) {
  ifelse(category == "place" & type %in% c("island", "islet", "archipelago"), "natural",
  ifelse(category == "place", "populated",
  ifelse(category == "boundary" & type %in% c("protected_area", "national_park"), "protected",
  ifelse(category == "leisure" & type %in% c("nature_reserve", "park"), "protected",
  ifelse(category == "boundary" & type == "administrative", "admin",
  ifelse(category == "natural" & type %in% c("water", "spring", "wetland", "bay"), "water",
  ifelse(category %in% c("waterway", "water"), "water",
  ifelse(category == "natural", "natural", "other"))))))))
}

gn_kind <- function(fcl) {
  c(P = "populated", A = "admin", H = "water", T = "natural", V = "natural",
    L = "protected", S = "other", R = "other", U = "other")[fcl]
}

# ------------------------------------------------------------------------------
# Backend: Nominatim (OpenStreetMap). One request per second, cached on disk.
# ------------------------------------------------------------------------------
nominatim_search <- function(q, cc = NULL, cache_dir = NULL) {
  key <- paste0("osm_", gsub("[^A-Za-z0-9]", "_", paste(q, paste(cc, collapse = "-"))))
  cf <- if (!is.null(cache_dir)) file.path(cache_dir, paste0(key, ".rds"))
  if (!is.null(cf) && file.exists(cf)) return(readRDS(cf))
  Sys.sleep(1.1)
  req <- request("https://nominatim.openstreetmap.org/search") |>
    req_user_agent(PUBMAPS_UA) |>
    req_url_query(q = q, format = "jsonv2", limit = 10, addressdetails = 1,
                  namedetails = 1) |>
    req_retry(max_tries = 3) |>
    req_error(is_error = function(r) FALSE)
  if (length(cc)) req <- req_url_query(req, countrycodes = paste(tolower(cc), collapse = ","))
  resp <- req_perform(req)
  out <- if (resp_status(resp) != 200) NULL else {
    j <- resp_body_json(resp)
    if (!length(j)) NULL else do.call(rbind, lapply(j, function(g) {
      alt <- unlist(g$namedetails)
      data.frame(
        cand_name = if (nzchar(g$name %||% "")) g$name else sub(",.*", "", g$display_name),
        alt_names = paste(alt, collapse = " | "),
        lon = as.numeric(g$lon), lat = as.numeric(g$lat),
        kind = osm_kind(g$category, g$type),
        ftype = paste0(g$category, ":", g$type),
        admin1 = g$address$state %||% g$address$region %||% NA_character_,
        cc = toupper(g$address$country_code %||% NA_character_),
        gaz_id = paste0("osm:", g$osm_type, "/", g$osm_id),
        importance = as.numeric(g$importance %||% 0),
        backend = "nominatim", stringsAsFactors = FALSE)
    }))
  }
  if (!is.null(cf)) saveRDS(out, cf)
  out
}

# ------------------------------------------------------------------------------
# Backend: GeoNames (premium host by default). Same output columns.
# ------------------------------------------------------------------------------
geonames_search <- function(q, cc = NULL, cache_dir = NULL,
                            host = Sys.getenv("GEONAMES_HOST", "https://secure.geonames.net"),
                            user = Sys.getenv("GEONAMES_USERNAME", "kimbridges"),
                            token = Sys.getenv("GEONAMES_TOKEN")) {
  key <- paste0("gn_", gsub("[^A-Za-z0-9]", "_", paste(q, paste(cc, collapse = "-"))))
  cf <- if (!is.null(cache_dir)) file.path(cache_dir, paste0(key, ".rds"))
  if (!is.null(cf) && file.exists(cf)) return(readRDS(cf))
  req <- request(paste0(host, "/searchJSON")) |>
    req_url_query(q = q, maxRows = 15, style = "FULL", username = user) |>
    req_error(is_error = function(r) FALSE)
  if (nzchar(token)) req <- req_url_query(req, token = token)
  if (length(cc)) req <- req_url_query(req, country = cc, .multi = "explode")
  j <- resp_body_json(req_perform(req))
  if (!is.null(j$status)) stop("GeoNames: ", j$status$message)
  out <- if (!length(j$geonames)) NULL else do.call(rbind, lapply(j$geonames, function(g) {
    alt <- vapply(g$alternateNames %||% list(), function(a) a$name %||% "", "")
    data.frame(
      cand_name = g$name, alt_names = paste(unique(c(g$toponymName, alt)), collapse = " | "),
      lon = as.numeric(g$lng), lat = as.numeric(g$lat),
      kind = unname(gn_kind(g$fcl %||% "U")), ftype = paste0(g$fcl, ":", g$fcode),
      admin1 = g$adminName1 %||% NA_character_, cc = g$countryCode %||% NA_character_,
      gaz_id = paste0("gn:", g$geonameId),
      importance = as.numeric(g$score %||% 0) / 100,
      backend = "geonames", stringsAsFactors = FALSE)
  }))
  if (!is.null(cf)) saveRDS(out, cf)
  out
}

# ------------------------------------------------------------------------------
# Candidates for one place: try name variants until something comes back
# ------------------------------------------------------------------------------
place_candidates <- function(name, cc, backends, cache_dir) {
  for (b in backends) {
    f <- switch(b, nominatim = nominatim_search, geonames = geonames_search)
    for (v in name_variants(name)) {
      cand <- tryCatch(f(v, cc, cache_dir), error = function(e) {
        message(b, " failed for '", v, "': ", conditionMessage(e)); NULL })
      if (!is.null(cand) && nrow(cand)) { cand$query <- v; return(cand) }
    }
  }
  NULL
}

score_candidates <- function(cand, name, role, admin1) {
  cand$sim <- vapply(seq_len(nrow(cand)), function(i) {
    max(name_sim(name, cand$cand_name[i]),
        if (nzchar(cand$alt_names[i]))
          max(vapply(strsplit(cand$alt_names[i], " | ", fixed = TRUE)[[1]],
                     function(a) name_sim(name, a), 0)) else 0)
  }, 0)
  cand$role_ok <- cand$kind %in% (ROLE_KINDS[[role]] %||% ROLE_KINDS$other)
  cand$role_fallback <- !cand$role_ok & cand$kind %in% (ROLE_FALLBACK[[role]] %||% character())
  cand$admin_ok <- if (is.na(admin1) || !nzchar(admin1)) NA else
    vapply(cand$admin1, function(a) !is.na(a) &&
             (grepl(core_name(admin1), core_name(a), fixed = TRUE) ||
              grepl(core_name(a), core_name(admin1), fixed = TRUE)), TRUE)
  cand$score <- 2 * cand$sim + cand$role_ok + 0.5 * cand$role_fallback + 0.5 * isTRUE_vec(cand$admin_ok) +
                0.2 * cand$importance
  cand[order(-cand$score), ]
}
isTRUE_vec <- function(x) !is.na(x) & x

# names that identify nothing without their parent unit ("Ward no. 3", "Plot 12",
# "396 B"): never sent to a gazetteer -- they go to the author-query list
GENERIC_NAME <- paste0("^(ward|plot|site|transect|quadrat|block|station|village|camp|",
                       "zone|sector|area|stand|grid)\\s*(no\\.?|number|#)?\\s*",
                       "[0-9ivx]+[a-z]?$|^[0-9]+\\s*[a-z]?$")
# ...and descriptions with no capitalised word ("national forest reserve") are not names
is_generic_name <- function(x) grepl(GENERIC_NAME, trimws(tolower(x)), perl = TRUE) |
  !grepl("[[:upper:]]", x)

# ------------------------------------------------------------------------------
# LOCATE: extracted places -> points table
# ------------------------------------------------------------------------------
locate_places <- function(places, study = attr(places, "study"),
                          backends = c("nominatim"), cache_dir = NULL,
                          far_km = NULL) {
  if (!is.null(cache_dir)) dir.create(cache_dir, showWarnings = FALSE, recursive = TRUE)
  cc_study <- suppressWarnings(countrycode(unlist(study$study_countries),
                                           "country.name", "iso2c"))
  cc_study <- unique(cc_study[!is.na(cc_study)])
  n <- nrow(places)
  places$lon <- places$stated_lon; places$lat <- places$stated_lat
  places$coord_source <- ifelse(!is.na(places$lon), "text", NA)
  places$match <- ifelse(!is.na(places$lon), "stated", NA)
  places[, c("gaz_name", "gaz_type", "gaz_id", "gaz_admin1")] <- NA_character_
  places$gaz_lon <- NA_real_; places$gaz_lat <- NA_real_
  places$n_candidates <- NA_integer_
  cands <- vector("list", n)

  # pass 1: gather and score candidates
  for (i in seq_len(n)) {
    if (places$match[i] %in% "stated" || places$role[i] == "relative_location" ||
        is_generic_name(places$name[i])) next
    cc <- suppressWarnings(countrycode(places$country[i], "country.name", "iso2c"))
    cc <- if (!is.na(cc)) cc else cc_study
    cand <- place_candidates(places$name[i], cc, backends, cache_dir)
    if (is.null(cand)) next
    cands[[i]] <- score_candidates(cand, places$name[i], places$role[i], places$admin1[i])
  }

  # anchor: stated positions first, else confident pass-1 picks
  good <- function(c) !is.null(c) && c$sim[1] >= 0.95 && c$role_ok[1]
  ax <- c(places$lon[!is.na(places$lon)],
          unlist(lapply(cands, function(c) if (good(c)) c$lon[1])))
  ay <- c(places$lat[!is.na(places$lat)],
          unlist(lapply(cands, function(c) if (good(c)) c$lat[1])))
  anchor <- if (length(ax)) c(median(ax), median(ay)) else NULL

  # pass 2: among near-equal candidates, prefer the one nearest the anchor
  for (i in seq_len(n)) {
    cd <- cands[[i]]; if (is.null(cd)) next
    if (!is.null(anchor)) {
      cd$km <- haversine_km(anchor[1], anchor[2], cd$lon, cd$lat)
      top <- cd[cd$score >= cd$score[1] - 0.25, ]
      cd <- rbind(top[order(top$km), ], cd[!cd$gaz_id %in% top$gaz_id, ])
    }
    b <- cd[1, ]
    # wrong kind of feature (e.g. a highway offered for a mountain): show it to the
    # editor as a suggestion, but do not put it on the map
    placed <- b$role_ok || b$role_fallback
    places$match[i] <- if (!placed) "suggestion" else
                       if (b$role_ok && b$sim >= 0.95) "exact" else "partial"
    places$coord_source[i] <- b$backend
    if (placed) { places$lon[i] <- b$lon; places$lat[i] <- b$lat }
    places$gaz_name[i] <- b$cand_name; places$gaz_type[i] <- b$ftype
    places$gaz_id[i] <- b$gaz_id; places$gaz_admin1[i] <- b$admin1
    places$gaz_lon[i] <- b$lon; places$gaz_lat[i] <- b$lat
    places$n_candidates[i] <- nrow(cd)
  }
  places$coord_source[is.na(places$coord_source) | is.na(places$lon)] <- "none"
  places$match[is.na(places$match)] <- "none"

  # distance from the study's centre; flag the strays
  places$km_from_centre <- if (is.null(anchor)) NA else
    round(haversine_km(anchor[1], anchor[2], places$lon, places$lat), 1)
  d <- places$km_from_centre[places$match %in% c("stated", "exact")]
  lim <- far_km %||% max(50, 3 * median(d, na.rm = TRUE))
  places$flag <- ifelse(is_generic_name(places$name), "generic",
                 ifelse(places$role == "relative_location", "relative",
                 ifelse(!is.na(places$km_from_centre) & places$km_from_centre > lim &
                          !places$role %in% c("administrative_unit", "protected_area"),
                        "far", "")))
  attr(places, "study") <- study
  attr(places, "anchor") <- anchor
  attr(places, "far_km") <- lim
  places
}
