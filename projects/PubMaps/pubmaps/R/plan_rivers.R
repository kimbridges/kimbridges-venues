# ==============================================================================
# plan_rivers.R -- PubMaps: rivers named in the manuscript, drawn as lines
# (added 2026-10-26). Nominatim returns only single stretches of a big river, so
# the line comes from the OpenStreetMap Overpass service: every waterway way
# whose name matches, inside the map frame. Drawn beneath the points, labelled
# along the river. The frame is never enlarged for a river.
# Editor control: include = "no" hides a river; include = "name" prints the
# name only.
# ==============================================================================

RIVER_TYPE <- "^waterway:(river|stream|canal)|^H:(STM|STMI|STMX|CNL)"
RIVER_NAME <- "\\b(river|rio|sungai|nadi|creek|khola|wadi)\\b"
OVERPASS <- "https://overpass-api.de/api/interpreter"   # slow on a first query (~30 s); answers are cached

rivers_cache <- function() file.path(pubmaps_cache_dir(), "rivers")

is_river <- function(p) {
  gt <- if (is.null(p$gaz_type)) rep(NA_character_, nrow(p)) else p$gaz_type
  p$role %in% "natural_feature" &
    ((!is.na(gt) & grepl(RIVER_TYPE, gt)) | grepl(RIVER_NAME, p$name, ignore.case = TRUE))
}

# "Brahmaputra River" -> "brahmaputra"; "Sungai Merangin" -> "merangin"
river_core <- function(x) {
  x <- norm_name(x)
  for (w in c("river", "rio", "sungai", "nadi", "stream", "creek", "khola", "wadi", "the", "r"))
    x <- gsub(paste0("\\b", w, "\\b"), "", x)
  gsub("\\s+", " ", trimws(x))
}

# all stretches of a named river inside a lon/lat box, as one sfc (EPSG:4326);
# NULL when none is found; an error when no Overpass server answers (not cached,
# so a later redraw tries again)
overpass_river <- function(name, ext_ll, cache_dir = rivers_cache()) {
  core <- river_core(name)
  if (!nzchar(core)) return(NULL)
  dir.create(cache_dir, showWarnings = FALSE, recursive = TRUE)
  key <- paste0("river3_", gsub("[^a-z0-9]", "_", core), "_",
                gsub("[^0-9]", "_", paste(round(ext_ll, 2), collapse = "_")))
  cf <- file.path(cache_dir, paste0(key, ".rds"))
  if (file.exists(cf)) return(readRDS(cf))
  bb <- sprintf("%.4f,%.4f,%.4f,%.4f", ext_ll[2], ext_ll[1], ext_ll[4], ext_ll[3])
  # whole words only: "Ganga" must not match "Dhauliganga" or "Rishiganga"
  rx <- paste0("^(.*[ -])?", gsub(" ", "[ -]", core), "([ -].*)?$")
  ql <- sprintf(paste0('[out:json][timeout:60];(',
                       'way["waterway"~"^(river|canal)$"]["name"~"%s",i](%s);',
                       'way["waterway"~"^(river|canal)$"]["name:en"~"%s",i](%s););out geom;'),
                rx, bb, rx, bb)
  for (u in OVERPASS) {
    r <- tryCatch(request(u) |> req_body_form(data = ql) |> req_user_agent(PUBMAPS_UA) |>
                    req_timeout(120) |>
                    # Overpass answers 429/504 when busy: wait and try again (up to ~2 min)
                    req_retry(max_tries = 5, is_transient = function(r) resp_status(r) %in% c(429, 502, 503, 504),
                              backoff = function(i) 10 * i) |>
                    req_error(is_error = function(r) FALSE) |> req_perform(),
                  error = function(e) NULL)
    if (is.null(r) || resp_status(r) != 200 || !grepl("json", resp_content_type(r))) next
    el <- resp_body_json(r)$elements
    # keep only stretches whose own name IS this river ("Ganga", "Ganga River"),
    # not tributaries that contain the word ("Dhauli Ganga", "Rishi Ganga")
    same <- function(w) any(vapply(c(w$tags$name %||% "", w$tags$`name:en` %||% ""),
                                   function(n) nzchar(n) && river_core(n) == core, TRUE))
    el <- Filter(same, el)
    ls <- lapply(el, function(w) {
      g <- w$geometry
      if (length(g) < 2) return(NULL)
      st_linestring(cbind(vapply(g, function(p) as.numeric(p$lon), 0),
                          vapply(g, function(p) as.numeric(p$lat), 0)))
    })
    ls <- Filter(Negate(is.null), ls)
    out <- if (length(ls)) st_union(st_sfc(ls, crs = 4326))
    saveRDS(out, cf)
    return(out)
  }
  stop("no Overpass server answered")
}

# a label point for a river: the middle of its longest stretch inside the map
river_label_point <- function(g) {
  parts <- suppressWarnings(st_cast(st_sfc(g), "LINESTRING"))
  best <- parts[which.max(as.numeric(st_length(parts)))]
  st_coordinates(st_line_sample(best, sample = 0.5))[1, 1:2]
}

plan_rivers <- function(sel, bb, crs, ext_ll) {
  inc <- if (is.null(sel$include)) rep("", nrow(sel)) else
    tolower(trimws(ifelse(is.na(sel$include), "", sel$include)))
  cand <- which(is_river(sel) & !sel$drawn & !inc %in% c("no", "name"))
  if (!length(cand)) return(list(points = sel, rivers = NULL, rivers_ll = NULL))
  frame <- st_as_sfc(st_bbox(setNames(bb, c("xmin", "ymin", "xmax", "ymax")), crs = crs))
  keep <- list(); full <- list(); seen <- character()
  for (i in cand) {
    # the editor's label is the name looked up, so a spelling can be corrected there
    lab <- if (!is.null(sel$label) && !is.na(sel$label[i]) && nzchar(sel$label[i])) sel$label[i] else sel$name[i]
    core <- river_core(lab)
    if (core %in% names(seen)) { sel$reason[i] <- paste0("same river as '", seen[[core]], "'"); next }
    g <- tryCatch(overpass_river(lab, ext_ll), error = function(e) "unreached")
    if (identical(g, "unreached")) {
      sel$reason[i] <- "river: map server not reachable (redraw later)"; next
    }
    gm <- if (is.null(g)) NULL else
      suppressWarnings(suppressMessages(st_intersection(st_transform(g, crs), frame)))
    if (!is.null(gm) && length(gm))
      gm <- tryCatch(suppressWarnings(st_collection_extract(gm, "LINESTRING")), error = function(e) gm)
    if (is.null(gm) || !length(gm) || all(st_is_empty(gm))) {
      sel$reason[i] <- "river not found within the map"; next
    }
    keep[[length(keep) + 1]] <- st_sf(name = lab, role = "river",
                                      label_pos = sel$label_pos[i] %||% "",
                                      label_lon = sel$label_lon[i] %||% NA_real_,
                                      label_lat = sel$label_lat[i] %||% NA_real_,
                                      geometry = st_union(gm))
    full[[length(full) + 1]] <- st_sf(name = lab, role = "river", geometry = g)
    sel$reason[i] <- "drawn as river"
    seen[[core]] <- sel$name[i]
  }
  list(points = sel,
       rivers = if (length(keep)) do.call(rbind, keep),
       rivers_ll = if (length(full)) do.call(rbind, full))
}
