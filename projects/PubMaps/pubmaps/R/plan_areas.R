# ==============================================================================
# plan_areas.R -- PubMaps: parks, reserves and districts drawn as AREAS
# (added 2026-10-25). Outlines come from OpenStreetMap through Nominatim
# (polygon_geojson), are clipped to the planned frame, and are drawn beneath the
# points: protected areas as a pale fill, districts as a dashed outline.
# The frame is set by the points -- an area never enlarges the map -- EXCEPT in a
# study with no located points other than its districts and parks (2026-10-26):
# then the areas' outlines set the frame (see plan_map()).
# A district that covers (almost) the whole frame is not drawn: it would only
# tint everything, and the map's legend/caption already names it.
# Editor control: include = "no" in points.csv hides an area.
# ==============================================================================

AREA_ROLES <- c("protected_area", "administrative_unit")
AREA_COVER_MAX <- 0.90     # skip an area covering more than this share of the frame
AREA_NEAR_KM   <- 100      # polygon must lie this close to the gazetteer position
AREA_SLIVER    <- c(0.02, 0.25)  # skip if < 2% of the frame AND < 25% of the area is inside
# which OSM feature classes count as the outline of each role (Nominatim category:type)
AREA_CLASS <- list(administrative_unit = "^boundary:(administrative|political)",
                   protected_area = "^boundary:(protected_area|national_park)|^leisure:nature_reserve")

areas_cache <- function() file.path(pubmaps_cache_dir(), "areas")

# osm:relation/123 -> R123 ; osm:way/45 -> W45 (nodes have no outline)
osm_lookup_id <- function(gaz_id) {
  if (is.na(gaz_id) || !grepl("^osm:(relation|way)/", gaz_id)) return(NULL)
  t <- sub("^osm:(relation|way)/.*", "\\1", gaz_id)
  paste0(if (t == "relation") "R" else "W", sub(".*/", "", gaz_id))
}

geojson_to_sf <- function(g) {
  tf <- tempfile(fileext = ".geojson"); on.exit(unlink(tf))
  writeLines(jsonlite::toJSON(list(type = "Feature", properties = list(), geometry = g),
                              auto_unbox = TRUE, digits = NA), tf)
  suppressWarnings(st_make_valid(st_read(tf, quiet = TRUE)))
}

# one polygon for a place, or NULL; cached on disk (including "nothing found")
nominatim_polygon <- function(name, cc = NULL, near = NULL, osm_id = NULL, role = NULL,
                              cache_dir = areas_cache()) {
  dir.create(cache_dir, showWarnings = FALSE, recursive = TRUE)
  key <- paste0("poly_", gsub("[^A-Za-z0-9]", "_",
                              paste(osm_id %||% name, paste(cc, collapse = "-"), role %||% "")))
  cf <- file.path(cache_dir, paste0(key, ".rds"))
  if (file.exists(cf)) return(readRDS(cf))
  Sys.sleep(1.1)
  req <- if (!is.null(osm_id))
    request("https://nominatim.openstreetmap.org/lookup") |>
      req_url_query(osm_ids = osm_id) else
    request("https://nominatim.openstreetmap.org/search") |>
      req_url_query(q = name, limit = 8,
                    countrycodes = if (length(cc)) paste(tolower(cc), collapse = ",") else NULL)
  req <- req |> req_user_agent(PUBMAPS_UA) |>
    req_url_query(format = "jsonv2", polygon_geojson = 1, polygon_threshold = 0.0005) |>
    req_retry(max_tries = 3) |> req_error(is_error = function(r) FALSE)
  resp <- req_perform(req)
  out <- NULL
  if (resp_status(resp) == 200) {
    j <- Filter(function(g) !is.null(g$geojson) &&
                  g$geojson$type %in% c("Polygon", "MultiPolygon"), resp_body_json(resp))
    if (length(j)) {
      polys <- lapply(j, function(g) {
        s <- tryCatch(geojson_to_sf(g$geojson), error = function(e) NULL)
        if (is.null(s)) return(NULL)
        s$osm <- paste0(g$osm_type, "/", g$osm_id); s$osm_name <- g$name %||% ""
        s$osm_type_desc <- paste0(g$category, ":", g$type)
        s$place_rank <- as.integer(g$place_rank %||% NA)
        s[, c("osm", "osm_name", "osm_type_desc", "place_rank")]
      })
      polys <- do.call(rbind, Filter(Negate(is.null), polys))
      if (!is.null(polys) && nrow(polys) && !is.null(role) && !is.null(AREA_CLASS[[role]]))
        polys <- polys[grepl(AREA_CLASS[[role]], polys$osm_type_desc), ]
      if (!is.null(polys) && nrow(polys)) {
        if (!is.null(near) && all(!is.na(near))) {
          pt <- st_sfc(st_point(near), crs = 4326)
          km <- as.numeric(suppressMessages(st_distance(polys, pt))) / 1000
          polys <- polys[km <= AREA_NEAR_KM, ]
          km <- km[km <= AREA_NEAR_KM]
          if (nrow(polys)) polys <- polys[order(km), ]
        }
        if (nrow(polys)) out <- polys[1, ]
      }
    }
  }
  saveRDS(out, cf)
  out
}

# the outline for row i of the points table: by OSM id, then by name, then by core name
find_outline <- function(sel, i) {
  cc <- suppressWarnings(countrycode(sel$country[i], "country.name", "iso2c"))
  near <- c(sel$gaz_lon[i] %||% NA, sel$gaz_lat[i] %||% NA)
  if (any(is.na(near))) near <- c(sel$lon[i], sel$lat[i])
  ccx <- if (length(cc) && !is.na(cc)) cc
  look <- function(nm, id = NULL) tryCatch(nominatim_polygon(nm, ccx, near = near, osm_id = id,
                                                             role = sel$role[i]), error = function(e) NULL)
  poly <- look(sel$name[i], osm_lookup_id(sel$gaz_id[i]))
  # the gazetteer hit may be a node or a building: search by name, then by core name
  if (is.null(poly) && !is.null(osm_lookup_id(sel$gaz_id[i]))) poly <- look(sel$name[i])
  cn <- tools::toTitleCase(core_name(sel$name[i]))
  if (is.null(poly) && nzchar(cn) && tolower(cn) != tolower(sel$name[i])) poly <- look(cn)
  poly
}

# decide which areas to draw; returns updated points + clipped areas (map CRS)
# + full outlines (lon/lat) for the review page
plan_areas <- function(sel, bb, crs) {
  inc <- if (is.null(sel$include)) rep("", nrow(sel)) else
    tolower(trimws(ifelse(is.na(sel$include), "", sel$include)))
  sel$area_drawn <- FALSE
  cand <- which(sel$role %in% AREA_ROLES & !sel$drawn & !inc %in% c("no", "name") &
                (!is.na(sel$lon) | !is.na(sel$gaz_lon)))
  if (!length(cand)) return(list(points = sel, areas = NULL, areas_ll = NULL))
  frame <- st_as_sfc(st_bbox(setNames(bb, c("xmin", "ymin", "xmax", "ymax")), crs = crs))
  frame_area <- as.numeric(st_area(frame))
  keep <- list(); full <- list()
  for (i in cand) {
    poly <- find_outline(sel, i)
    if (!is.null(poly) && !is.na(poly$place_rank) && poly$place_rank <= 8 &&
        sel$role[i] == "administrative_unit" && inc[i] != "yes") {
      sel$reason[i] <- "province/state (shown by the state boundaries)"; next
    }
    if (any(sel$drawn & core_name(sel$name) == core_name(sel$name[i])) && inc[i] != "yes") {
      sel$reason[i] <- "same place is drawn as a point"; next
    }
    if (is.null(poly)) { sel$reason[i] <- paste(sel$reason[i], "-- no outline found"); next }
    pm <- suppressWarnings(suppressMessages(st_intersection(st_transform(st_geometry(poly), crs), frame)))
    if (!length(pm) || all(st_is_empty(pm))) { sel$reason[i] <- "area outside the map frame"; next }
    share <- sum(as.numeric(st_area(pm))) / frame_area
    if (share > AREA_COVER_MAX && inc[i] != "yes") {
      sel$reason[i] <- "area covers the whole map (context)"; next
    }
    if (share < 0.003) {   # too small to read as an area at this scale: draw a point instead
      sel$drawn[i] <- !is.na(sel$lon[i]); sel$reason[i] <- if (sel$drawn[i]) "" else "area too small"; next
    }
    inside <- sum(as.numeric(st_area(pm))) / as.numeric(st_area(st_transform(st_geometry(poly), crs)))[1]
    if (share < AREA_SLIVER[1] && inside < AREA_SLIVER[2] && inc[i] != "yes") {
      sel$reason[i] <- "only a sliver inside the map (context)"; next
    }
    lab <- if (!is.null(sel$label) && !is.na(sel$label[i]) && nzchar(sel$label[i])) sel$label[i] else sel$name[i]
    keep[[length(keep) + 1]] <- st_sf(name = lab, role = sel$role[i], share = round(share, 3),
                                      label_pos = sel$label_pos[i] %||% "",
                                      label_lon = sel$label_lon[i] %||% NA_real_,
                                      label_lat = sel$label_lat[i] %||% NA_real_,
                                      geometry = st_union(pm))
    full[[length(full) + 1]] <- st_sf(name = lab, role = sel$role[i],
                                      geometry = st_simplify(st_geometry(poly), dTolerance = 50))
    sel$area_drawn[i] <- TRUE
    sel$reason[i] <- "drawn as area"
  }
  list(points = sel,
       areas = if (length(keep)) do.call(rbind, keep),
       areas_ll = if (length(full)) do.call(rbind, full))
}

