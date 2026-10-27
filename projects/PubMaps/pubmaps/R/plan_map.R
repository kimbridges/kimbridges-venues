# ==============================================================================
# plan_map.R -- PubMaps step 3: PLAN
# Code, not the LLM, decides the map's geometry from the located points:
#   which points are drawn, the projection, the main extent (padded, fitted to the
#   page aspect), the inset corner (the one that covers no point or label -- the
#   map is widened to make room if every corner is occupied), the inset's countries
#   and extent (remote territories dropped), and where scale bar and north arrow go.
# ==============================================================================

ROLE_DRAW     <- c("study_site", "sampling_point", "reference_town", "natural_feature")
ROLE_PRIORITY <- c("study_site", "sampling_point", "reference_town", "natural_feature",
                   "protected_area", "administrative_unit", "other", "relative_location")
CORNERS <- c("tr", "tl", "br", "bl")   # preference order when tied

# natural features that a dot can honestly represent (OSM type or GeoNames code);
# ranges, rivers, islands, basins and deserts are context, not points
# Gazetteer types that are a POINT at study-map scale. Widened 2026-10-25 with
# GeoNames: populated places (P:), spots such as homesteads, farms and airstrips
# (S:), small water bodies, and village-level administrative units (ADM3-5,
# e.g. Nepal's VDCs) -- otherwise Chitwan's study villages and the Simpson
# Desert stations and waterholes were held back as "context".
POINT_FEATURE <- paste0("peak|volcano|hill|spring|saddle|pass|cave|waterfall|glacier|rock|",
                        "^T:(MT|PK|VLC|HLL|PASS|CAVE)|^H:(SPNG|FLLS|GLCR|LK|LKI|WTRH|WLL|PND)|",
                        "^P:|^S:|^A:ADM[345]|",
                        "place:(village|hamlet|town|farm|isolated_dwelling|locality)")
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
              ifelse(!p$role %in% ROLE_DRAW & !(p$role %in% c("administrative_unit", "other") & point_like(p)),
                     paste0(p$role, " (context, not a point)"),
              ifelse(p$role == "natural_feature" & !point_like(p),
                     "area or line feature (context, not a point)", "")))))))
  inc <- if (is.null(p$include)) rep("", nrow(p)) else tolower(trimws(ifelse(is.na(p$include), "", p$include)))
  p$reason[inc == "no"] <- "excluded by editor"
  p$reason[inc == "name"] <- "name only (no symbol)"   # 2026-10-25: printed by render_map, never a point
  # include = yes forces a POINT -- except a park/district that is not point-like:
  # that stays for plan_areas(), which then draws it as an area even if it would skip it
  # ...and a river stays a line (plan_rivers()), never a point
  p$reason[inc == "yes" & !is.na(p$lon) & !is_river(p) &
           !(p$role %in% c("protected_area", "administrative_unit") & !point_like(p))] <- ""
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

# how much of each corner an area-framed study's outlines cover, in the same units as
# corner_conflicts() (panel fractions), so the inset avoids the study's own districts
area_corner_cover <- function(geom_ll, bb, crs, frac) {
  g <- st_transform(geom_ll, crs)
  W <- bb[3] - bb[1]; H <- bb[4] - bb[2]
  sapply(CORNERS, function(cn) {
    cb <- corner_box(cn, frac)
    box <- st_as_sfc(st_bbox(c(xmin = bb[1] + cb[1] * W, ymin = bb[2] + cb[2] * H,
                               xmax = bb[1] + cb[3] * W, ymax = bb[2] + cb[4] * H), crs = crs))
    a <- suppressWarnings(suppressMessages(st_intersection(g, box)))
    if (!length(a) || all(st_is_empty(a))) 0 else
      sum(as.numeric(st_area(a))) / as.numeric(st_area(box)) * frac[1] * frac[2]
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
# Area-framed studies (2026-10-26). When nothing but districts and parks is located
# -- "the study sites were Majuli district and Dibrugarh district" -- points cannot
# set the frame. The outlines of the study's own districts and parks do: state,
# province and country outlines (OSM place_rank <= 8) are left out unless the
# editor sets include = yes. Returns the union of the outlines (lon/lat), or NULL
# when the study has points to frame it, or no outline is found.
# ------------------------------------------------------------------------------
area_frame <- function(sel) {
  if (any(sel$drawn & !sel$role %in% AREA_ROLES)) return(NULL)
  inc <- if (is.null(sel$include)) rep("", nrow(sel)) else tolower(trimws(ifelse(is.na(sel$include), "", sel$include)))
  ai <- which(sel$role %in% AREA_ROLES & !inc %in% c("no", "name") & !sel$flag %in% "far" &
              (!is.na(sel$lon) | !is.na(sel$gaz_lon)))
  outl <- list()
  for (i in ai) {
    po <- find_outline(sel, i)
    if (!is.null(po) && (is.na(po$place_rank) || po$place_rank > 8 || inc[i] == "yes"))
      outl[[length(outl) + 1]] <- st_geometry(po)
  }
  if (!length(outl)) return(NULL)
  st_union(do.call(c, outl))
}

# ------------------------------------------------------------------------------
# PLAN
# ------------------------------------------------------------------------------
#' Plan the map's geometry
#'
#' Decides, by fixed rules, which places are drawn, the projection, the frame,
#' the inset corner and countries, where the north arrow and scale bar go, and
#' which parks and districts are drawn as areas. Nothing here is decided by the
#' language model.
#'
#' @param points Output of [locate_places()], or the editor's table as read
#'   back from `points.csv`.
#' @param page_mm Page size in millimetres (width, height).
#' @param margin_mm Space for axis labels and legend (width, height).
#' @param pad Margin around the points, as a share of the larger span.
#' @param min_span_km The frame is never narrower than this.
#' @param inset_frac Inset size as a share of the panel (width, height).
#' @param label_mm Label text height used when checking corners.
#' @param areas Look up and plan park and district outlines.
#' @return An object of class `pubmap_plan`.
#' @export
plan_map <- function(points, page_mm = c(170, 130), margin_mm = c(14, 10),
                     pad = 0.12, min_span_km = 8, inset_frac = c(0.32, 0.40),
                     label_mm = 3, areas = TRUE) {
  sel <- select_points(points)
  frame_geom <- if (areas) area_frame(sel) else NULL
  if (!is.null(frame_geom)) {
    # area-framed study: its districts and parks are drawn as areas, not as points
    inc0 <- if (is.null(sel$include)) rep("", nrow(sel)) else tolower(trimws(ifelse(is.na(sel$include), "", sel$include)))
    sel$drawn[sel$role %in% AREA_ROLES & inc0 != "yes"] <- FALSE
  }
  d <- sel[sel$drawn, ]
  if (!nrow(d) && is.null(frame_geom)) stop("No located points or study areas to draw.")
  if (nrow(d) < 3 && is.null(frame_geom))
    warning(sprintf(paste("Only %d point(s) located -- too few for a useful map;",
                          "resolve the author queries first."), nrow(d)), call. = FALSE)
  pts_ll <- suppressWarnings(st_as_sf(d, coords = c("lon", "lat"), crs = 4326, remove = FALSE))
  lon_all <- d$lon; lat_all <- d$lat
  if (!is.null(frame_geom)) {
    fb <- st_bbox(frame_geom); lon_all <- c(lon_all, fb[c(1, 3)]); lat_all <- c(lat_all, fb[c(2, 4)])
  }
  crs <- choose_crs(lon_all, lat_all)
  xy <- if (nrow(d)) st_coordinates(st_transform(pts_ll, crs)) else matrix(numeric(0), 0, 2)
  xy_frame <- xy
  if (!is.null(frame_geom)) {
    pb <- st_bbox(st_transform(frame_geom, crs))
    xy_frame <- rbind(xy, matrix(unname(pb), 2, byrow = TRUE))
  }
  panel_mm <- page_mm - margin_mm
  aspect <- panel_mm[1] / panel_mm[2]

  bb <- c(min(xy_frame[, 1]), min(xy_frame[, 2]), max(xy_frame[, 1]), max(xy_frame[, 2]))
  span <- max(bb[3] - bb[1], bb[4] - bb[2], min_span_km * 1000)
  cx <- mean(bb[c(1, 3)]); cy <- mean(bb[c(2, 4)])
  w <- max(bb[3] - bb[1], min_span_km * 1000); h <- max(bb[4] - bb[2], min_span_km * 1000)
  bb <- c(cx - w / 2, cy - h / 2, cx + w / 2, cy + h / 2)
  bb <- bb + c(-1, -1, 1, 1) * pad * max(w, h)
  bb <- fit_aspect(bb, aspect)

  # name-only labels (include = name) must also stay clear of the inset
  xy_c <- xy; nm_c <- d$name
  incl <- if (is.null(sel$include)) rep("", nrow(sel)) else tolower(trimws(ifelse(is.na(sel$include), "", sel$include)))
  nmo <- sel[incl == "name", , drop = FALSE]
  if (nrow(nmo)) {
    pick <- function(a, b, c) ifelse(!is.na(a), a, ifelse(!is.na(b), b, c))
    lx <- if (is.null(nmo$label_lon)) NA else nmo$label_lon; ly <- if (is.null(nmo$label_lat)) NA else nmo$label_lat
    nx <- pick(lx, nmo$lon, nmo$gaz_lon); ny <- pick(ly, nmo$lat, nmo$gaz_lat)
    ok <- !is.na(nx) & !is.na(ny)
    if (any(ok)) {
      nxy <- st_coordinates(st_transform(st_as_sf(data.frame(x = nx[ok], y = ny[ok]), coords = c("x", "y"), crs = 4326), crs))
      xy_c <- rbind(xy, nxy); nm_c <- c(d$name, toupper(nmo$name[ok]))
    }
  }
  conflicts <- function(bb) {
    cf <- corner_conflicts(xy_c, nm_c, bb, panel_mm, inset_frac, label_mm)
    if (!is.null(frame_geom)) cf <- cf + area_corner_cover(frame_geom, bb, crs, inset_frac)
    cf
  }
  cf <- conflicts(bb)
  widened <- FALSE
  if (min(cf) > 0) {                       # every corner occupied: make room
    best <- CORNERS[which.min(cf)]
    W <- bb[3] - bb[1]; extra <- W * inset_frac[1] / (1 - inset_frac[1])
    if (grepl("l", best)) bb[1] <- bb[1] - extra else bb[3] <- bb[3] + extra
    bb <- fit_aspect(bb, aspect); widened <- TRUE
    cf <- conflicts(bb)
  }
  inset_corner <- CORNERS[which.min(cf)]
  free <- setdiff(CORNERS, inset_corner)
  north <- intersect(c("tl", "tr"), free)[1]
  scale <- intersect(c("bl", "br"), free)[1]

  inset_aspect <- (inset_frac[1] * panel_mm[1]) / (inset_frac[2] * panel_mm[2])
  ins <- plan_inset(if (nrow(d)) pts_ll else
                      st_sf(geometry = suppressWarnings(st_centroid(frame_geom))), inset_aspect)

  ext_ll <- st_bbox(st_transform(st_as_sfc(st_bbox(setNames(bb, c("xmin", "ymin", "xmax", "ymax")),
                                                     crs = crs)), 4326))
  ar <- if (areas) plan_areas(sel, bb, crs) else list(points = sel, areas = NULL, areas_ll = NULL)
  rv <- if (areas) plan_rivers(ar$points, bb, crs, unname(ext_ll)) else
    list(points = ar$points, rivers = NULL, rivers_ll = NULL)
  outlines <- Filter(Negate(is.null), list(ar$areas_ll, rv$rivers_ll))   # for the review page
  structure(list(
    points = rv$points, areas = ar$areas, rivers = rv$rivers,
    areas_ll = if (length(outlines)) do.call(rbind, outlines),
    crs = crs, bbox = unname(bb), extent_lonlat = unname(ext_ll),
    page_mm = page_mm, panel_mm = panel_mm, inset_frac = inset_frac,
    inset_corner = inset_corner, corner_conflicts = round(cf * 1e4) / 1e4,
    widened_for_inset = widened, framed_by_areas = !is.null(frame_geom),
    north_arrow = north, scale_bar = scale,
    inset = ins, study = attr(points, "study")), class = "pubmap_plan")
}

#' @export
print.pubmap_plan <- function(x, ...) {
  d <- x$points
  cat("PubMaps plan:", sum(d$drawn), "points drawn of", nrow(d), "\n")
  cat("  projection:", if (!is.na(x$crs$epsg)) paste0("EPSG:", x$crs$epsg) else "LAEA", "\n")
  cat(sprintf("  extent: %.3f..%.3f E, %.3f..%.3f N (%.0f x %.0f km)\n",
              x$extent_lonlat[1], x$extent_lonlat[3], x$extent_lonlat[2], x$extent_lonlat[4],
              (x$bbox[3] - x$bbox[1]) / 1000, (x$bbox[4] - x$bbox[2]) / 1000))
  if (isTRUE(x$framed_by_areas)) cat("  frame: set by the study's districts and parks (no fieldwork points)\n")
  cat("  inset:", x$inset_corner, if (x$widened_for_inset) "(map widened to make room)",
      "| countries:", paste(x$inset$countries, collapse = ", "),
      if (x$inset$parts_dropped) sprintf("| %d remote parts dropped", x$inset$parts_dropped), "\n")
  cat("  north arrow:", x$north_arrow, "| scale bar:", x$scale_bar, "\n")
  if (!is.null(x$areas)) cat("  areas:", paste(x$areas$name, collapse = "; "), "\n")
  if (!is.null(x$rivers)) cat("  rivers:", paste(x$rivers$name, collapse = "; "), "\n")
  r <- table(d$reason[!d$drawn]); if (length(r)) { cat("  not drawn:\n"); print(r) }
  invisible(x)
}
