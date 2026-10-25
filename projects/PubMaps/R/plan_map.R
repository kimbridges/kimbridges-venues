# ==============================================================================
# plan_map.R -- PubMaps step 3: PLAN
# Code, not the LLM, decides the map's geometry from the located points:
#   which points are drawn, the projection, the main extent (padded, fitted to the
#   page aspect), the inset corner (the one that covers no point or label -- the
#   map is widened to make room if every corner is occupied), the inset's countries
#   and extent (remote territories dropped), and where scale bar and north arrow go.
# Needs locate_places.R (core_name, haversine_km).
# ==============================================================================

suppressPackageStartupMessages({
  library(sf)
  library(rnaturalearth)
})

ROLE_DRAW     <- c("study_site", "sampling_point", "reference_town", "natural_feature")
ROLE_PRIORITY <- c("study_site", "sampling_point", "reference_town", "natural_feature",
                   "protected_area", "administrative_unit", "other", "relative_location")
CORNERS <- c("tr", "tl", "br", "bl")   # preference order when tied

# natural features that a dot can honestly represent (OSM type or GeoNames code);
# ranges, rivers, islands, basins and deserts are context, not points
POINT_FEATURE <- paste0("peak|volcano|hill|spring|saddle|pass|cave|waterfall|glacier|rock|",
                        "^T:(MT|PK|VLC|HLL|PASS|CAVE)|^H:(SPNG|FLLS|GLCR)")
point_like <- function(p) p$match %in% "stated" |
  (!is.na(p$gaz_type) & grepl(POINT_FEATURE, p$gaz_type, ignore.case = TRUE))

# ------------------------------------------------------------------------------
# Which points go on the map, and why the others do not
# ------------------------------------------------------------------------------
select_points <- function(points, dedupe_km = 5) {
  p <- points
  p$drawn <- FALSE
  p$reason <- ifelse(p$flag %in% "generic", "generic name (author query)",
              ifelse(p$role == "relative_location", "relative location (author query)",
              ifelse(is.na(p$lon) & p$role %in% c("study_site", "sampling_point", "reference_town"),
                     "not located (author query)",
              ifelse(is.na(p$lon), "not located (context)",
              ifelse(p$flag %in% "far", "far from the study (check)",
              ifelse(!p$role %in% ROLE_DRAW, paste0(p$role, " (context, not a point)"),
              ifelse(p$role == "natural_feature" & !point_like(p),
                     "area or line feature (context, not a point)", "")))))))
  inc <- if (is.null(p$include)) rep("", nrow(p)) else tolower(trimws(ifelse(is.na(p$include), "", p$include)))
  p$reason[inc == "no"] <- "excluded by editor"
  p$reason[inc == "yes" & !is.na(p$lon)] <- ""
  ok <- which(p$reason == "")
  ok <- ok[order(match(p$role[ok], ROLE_PRIORITY))]
  key <- core_name(p$name)
  kept <- integer()
  for (i in ok) {
    dup <- kept[key[kept] == key[i] &
                haversine_km(p$lon[kept], p$lat[kept], p$lon[i], p$lat[i]) < dedupe_km]
    if (length(dup) && inc[i] != "yes") p$reason[i] <- paste0("duplicate of '", p$name[dup[1]], "'")
    else kept <- c(kept, i)
  }
  p$drawn[kept] <- TRUE
  p
}

# ------------------------------------------------------------------------------
# Projection: UTM for compact studies, Lambert azimuthal equal-area otherwise
# ------------------------------------------------------------------------------
choose_crs <- function(lon, lat) {
  lon0 <- mean(range(lon)); lat0 <- mean(range(lat))
  if (diff(range(lon)) <= 5) {
    zone <- floor((lon0 + 180) / 6) + 1
    st_crs(if (lat0 >= 0) 32600 + zone else 32700 + zone)
  } else {
    st_crs(sprintf("+proj=laea +lat_0=%.4f +lon_0=%.4f +datum=WGS84 +units=m", lat0, lon0))
  }
}

# expand a box (xmin, ymin, xmax, ymax) to a given width/height ratio
fit_aspect <- function(bb, aspect) {
  w <- bb[3] - bb[1]; h <- bb[4] - bb[2]
  if (w / h < aspect) { d <- (h * aspect - w) / 2; bb[1] <- bb[1] - d; bb[3] <- bb[3] + d }
  else                { d <- (w / aspect - h) / 2; bb[2] <- bb[2] - d; bb[4] <- bb[4] + d }
  bb
}

corner_box <- function(corner, frac) {          # in panel fractions 0..1
  x <- if (grepl("l", corner)) c(0, frac[1]) else c(1 - frac[1], 1)
  y <- if (grepl("b", corner)) c(0, frac[2]) else c(1 - frac[2], 1)
  c(x[1], y[1], x[2], y[2])
}

overlap <- function(a, b) max(0, min(a[3], b[3]) - max(a[1], b[1])) *
                          max(0, min(a[4], b[4]) - max(a[2], b[2]))

# points and label boxes as panel fractions, then how much each corner covers
corner_conflicts <- function(xy, labels, bb, panel_mm, frac, label_mm = 3) {
  fx <- (xy[, 1] - bb[1]) / (bb[3] - bb[1]); fy <- (xy[, 2] - bb[2]) / (bb[4] - bb[2])
  cw <- 0.55 * label_mm / panel_mm[1]; lh <- 1.4 * label_mm / panel_mm[2]
  pr <- 2 / panel_mm                      # 2 mm around each point
  boxes <- lapply(seq_along(fx), function(i) list(
    c(fx[i] - pr[1], fy[i] - pr[2], fx[i] + pr[1], fy[i] + pr[2]),
    c(fx[i] - nchar(labels[i]) * cw / 2, fy[i] + pr[2],
      fx[i] + nchar(labels[i]) * cw / 2, fy[i] + pr[2] + lh)))
  sapply(CORNERS, function(cn) {
    cb <- corner_box(cn, frac)
    sum(vapply(boxes, function(b) overlap(cb, b[[1]]) + overlap(cb, b[[2]]), 0))
  })
}

# ------------------------------------------------------------------------------
# Inset: the countries holding the points, remote territories dropped
# ------------------------------------------------------------------------------
plan_inset <- function(pts_ll, aspect) {
  world <- ne_countries(scale = 50, returnclass = "sf")
  idx <- unique(st_nearest_feature(pts_ll, world))
  ctry <- world[idx, ]
  centre <- st_centroid(st_union(pts_ll))
  parts <- suppressWarnings(st_cast(st_make_valid(st_geometry(ctry)), "POLYGON"))
  parts <- st_sf(geometry = parts)
  area <- as.numeric(st_area(parts)); big <- which.max(area)
  reach <- max(as.numeric(st_distance(centre, st_cast(parts[big, ], "POINT"))))
  d <- as.numeric(st_distance(centre, parts))
  keep <- parts[d <= max(1.5e6, 1.5 * reach), ]
  c0 <- st_coordinates(centre)
  crs_i <- st_crs(sprintf("+proj=laea +lat_0=%.3f +lon_0=%.3f +datum=WGS84 +units=m",
                          c0[2], c0[1]))
  bb <- st_bbox(st_transform(keep, crs_i))
  pad <- 0.08 * max(bb[3] - bb[1], bb[4] - bb[2])
  bb <- fit_aspect(c(bb[1] - pad, bb[2] - pad, bb[3] + pad, bb[4] + pad), aspect)
  list(countries = ctry$name, iso_a2 = ctry$iso_a2, crs = crs_i, bbox = unname(bb),
       parts_dropped = nrow(parts) - nrow(keep))
}

# ------------------------------------------------------------------------------
# PLAN
# ------------------------------------------------------------------------------
plan_map <- function(points, page_mm = c(170, 130), margin_mm = c(14, 10),
                     pad = 0.12, min_span_km = 8, inset_frac = c(0.32, 0.40),
                     label_mm = 3) {
  sel <- select_points(points)
  d <- sel[sel$drawn, ]
  if (!nrow(d)) stop("No located points to draw.")
  if (nrow(d) < 3) warning(sprintf(paste("Only %d point(s) located -- too few for a useful map;",
                                         "resolve the author queries first."), nrow(d)), call. = FALSE)
  pts_ll <- st_as_sf(d, coords = c("lon", "lat"), crs = 4326, remove = FALSE)
  crs <- choose_crs(d$lon, d$lat)
  xy <- st_coordinates(st_transform(pts_ll, crs))
  panel_mm <- page_mm - margin_mm
  aspect <- panel_mm[1] / panel_mm[2]

  bb <- c(min(xy[, 1]), min(xy[, 2]), max(xy[, 1]), max(xy[, 2]))
  span <- max(bb[3] - bb[1], bb[4] - bb[2], min_span_km * 1000)
  cx <- mean(bb[c(1, 3)]); cy <- mean(bb[c(2, 4)])
  w <- max(bb[3] - bb[1], min_span_km * 1000); h <- max(bb[4] - bb[2], min_span_km * 1000)
  bb <- c(cx - w / 2, cy - h / 2, cx + w / 2, cy + h / 2)
  bb <- bb + c(-1, -1, 1, 1) * pad * max(w, h)
  bb <- fit_aspect(bb, aspect)

  cf <- corner_conflicts(xy, d$name, bb, panel_mm, inset_frac, label_mm)
  widened <- FALSE
  if (min(cf) > 0) {                       # every corner occupied: make room
    best <- CORNERS[which.min(cf)]
    W <- bb[3] - bb[1]; extra <- W * inset_frac[1] / (1 - inset_frac[1])
    if (grepl("l", best)) bb[1] <- bb[1] - extra else bb[3] <- bb[3] + extra
    bb <- fit_aspect(bb, aspect); widened <- TRUE
    cf <- corner_conflicts(xy, d$name, bb, panel_mm, inset_frac, label_mm)
  }
  inset_corner <- CORNERS[which.min(cf)]
  free <- setdiff(CORNERS, inset_corner)
  north <- intersect(c("tl", "tr"), free)[1]
  scale <- intersect(c("bl", "br"), free)[1]

  inset_aspect <- (inset_frac[1] * panel_mm[1]) / (inset_frac[2] * panel_mm[2])
  ins <- plan_inset(pts_ll, inset_aspect)

  ext_ll <- st_bbox(st_transform(st_as_sfc(st_bbox(setNames(bb, c("xmin", "ymin", "xmax", "ymax")),
                                                     crs = crs)), 4326))
  structure(list(
    points = sel, crs = crs, bbox = unname(bb), extent_lonlat = unname(ext_ll),
    page_mm = page_mm, panel_mm = panel_mm, inset_frac = inset_frac,
    inset_corner = inset_corner, corner_conflicts = round(cf * 1e4) / 1e4,
    widened_for_inset = widened, north_arrow = north, scale_bar = scale,
    inset = ins, study = attr(points, "study")), class = "pubmap_plan")
}

print.pubmap_plan <- function(x, ...) {
  d <- x$points
  cat("PubMaps plan:", sum(d$drawn), "points drawn of", nrow(d), "\n")
  cat("  projection:", if (!is.na(x$crs$epsg)) paste0("EPSG:", x$crs$epsg) else "LAEA", "\n")
  cat(sprintf("  extent: %.3f..%.3f E, %.3f..%.3f N (%.0f x %.0f km)\n",
              x$extent_lonlat[1], x$extent_lonlat[3], x$extent_lonlat[2], x$extent_lonlat[4],
              (x$bbox[3] - x$bbox[1]) / 1000, (x$bbox[4] - x$bbox[2]) / 1000))
  cat("  inset:", x$inset_corner, if (x$widened_for_inset) "(map widened to make room)",
      "| countries:", paste(x$inset$countries, collapse = ", "),
      if (x$inset$parts_dropped) sprintf("| %d remote parts dropped", x$inset$parts_dropped), "\n")
  cat("  north arrow:", x$north_arrow, "| scale bar:", x$scale_bar, "\n")
  r <- table(d$reason[!d$drawn]); if (length(r)) { cat("  not drawn:\n"); print(r) }
  invisible(x)
}
