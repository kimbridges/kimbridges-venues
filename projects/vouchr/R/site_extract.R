# site_extract.R  (v2, 2026-06-30; roxygen + dependency guards 2026-07-01)
# -----------------------------------------------------------------------------
# Derive label-useful terrain information from a single coordinate pair.
#
# One (name, lat, lon) in -> a table of derived site variables:
#   elevation, slope, aspect (deg + compass), roughness, local relief
#   (mean/high/low), water-flow direction -- each carrying the DEM SOURCE,
#   its native RESOLUTION, and the ANALYSIS SCALE the terrain was computed at.
#
# WHY v2 (from the DEM head-to-head at Koko Crater, 2026-06-30):
#   * The 2020 method sampled a 3x3 grid over Google's ~76 m DEM and
#     OVER-estimated slope (40 deg vs a true ~31 deg from finer DEMs).
#   * Elevation and aspect proved robust to resolution; slope needs adequate
#     resolution; roughness (TRI) is strongly scale-dependent and is NOT
#     comparable across cell sizes.
#   * Fix: the analysis SCALE is now an explicit parameter in metres,
#     independent of the DEM's native resolution.
#
# The Derive pillar's packages (terra, elevatr, sf, geosphere, httr, jsonlite,
# soilDB) are in Suggests: each entry point checks for them at call time.
# -----------------------------------------------------------------------------

# --- small helpers -----------------------------------------------------------

#' Compass label for a bearing
#'
#' Convert a bearing in degrees (0 = north, increasing clockwise) to a 16-point
#' compass label.
#'
#' @param deg Numeric bearing in degrees. `NA` returns `NA`.
#' @return A character compass label such as `"NNE"`, or `NA` for a missing bearing.
#' @examples
#' deg_to_compass(0)
#' deg_to_compass(201)
#' @export
deg_to_compass <- function(deg) {
  pts <- c("N","NNE","NE","ENE","E","ESE","SE","SSE",
           "S","SSW","SW","WSW","W","WNW","NW","NNW")
  pts[floor(((deg %% 360) + 11.25) / 22.5) %% 16 + 1]
}

# UTM EPSG code for a lon/lat (metric CRS so slope is in real metres).
.utm_epsg <- function(lon, lat) {
  zone <- floor((lon + 180) / 6) + 1
  if (lat >= 0) 32600 + zone else 32700 + zone
}

# terra D8 flow-direction code -> compass label. Sinks / flats / unknown -> NA.
.flowdir_compass <- function(code) {
  m <- c(`1`="E", `2`="SE", `4`="S", `8`="SW",
         `16`="W", `32`="NW", `64`="N", `128`="NE")
  key <- as.character(code)
  if (length(code) != 1 || is.na(code) || !key %in% names(m)) return(NA_character_)
  unname(m[[key]])
}

# --- DEM backend: AWS terrain tiles -> metric SpatRaster ---------------------

.dem_aws <- function(lon, lat, z = 14, aoi_m = 300) {
  if (!requireNamespace("elevatr", quietly = TRUE) ||
      !requireNamespace("sf", quietly = TRUE) ||
      !requireNamespace("terra", quietly = TRUE))
    stop("source = 'aws' needs the 'elevatr', 'sf' and 'terra' packages.")
  d  <- aoi_m / 111320                                   # metres -> ~degrees
  bb <- sf::st_as_sf(data.frame(x = c(lon - d, lon + d),
                                y = c(lat - d, lat + d)),
                     coords = c("x", "y"), crs = 4326)
  r  <- elevatr::get_elev_raster(bb, z = z, clip = "bbox", verbose = FALSE)
  terra::project(terra::rast(r), sprintf("EPSG:%d", .utm_epsg(lon, lat)))
}

# --- main: raster path (source = "aws") --------------------------------------

#' Derive site variables from a coordinate
#'
#' From a single `(place, lat, lon)`, derive label-useful terrain variables:
#' elevation, slope, aspect (degrees and compass), roughness, local relief, and
#' water-flow direction. Each result carries the DEM source, its native
#' resolution, and the analysis scale the terrain was computed at.
#'
#' The `"aws"` source (default) uses `elevatr` AWS Terrain Tiles: free, keyless,
#' global, and automatically finer over the US. The `"google"` source is the
#' legacy 2020 3x3 method, kept as a fallback; it needs a billed Google key in
#' the `GGMAP_GOOGLE_API_KEY` environment variable.
#'
#' @param place Character place label for the point (used in output sentences).
#' @param lat,lon Latitude and longitude in decimal degrees (WGS84).
#' @param source DEM source: `"aws"` (default) or `"google"`.
#' @param z AWS terrain-tile zoom (native resolution; z14 ~ 4-10 m).
#' @param analysis_scale_m Analysis scale in metres for slope/aspect/flow; the
#'   DEM is aggregated to this scale before terrain is computed.
#' @param relief_radius_m Radius in metres for roughness (elevation SD) and local relief.
#' @param key Google Elevation API key (only for `source = "google"`); defaults
#'   to the `GGMAP_GOOGLE_API_KEY` environment variable.
#' @return A list with `values` (named list of derived variables), `sentences`
#'   (human-readable label lines), and `dem` (the DEM `SpatRaster` patch).
#' @examples
#' \dontrun{
#' koko <- site_extract("Koko Crater", 21.28164, -157.68687)
#' cat(koko$sentences, sep = "\n")
#' }
#' @export
site_extract <- function(place, lat, lon,
                         source = c("aws", "google"),
                         z = 14, analysis_scale_m = 30, relief_radius_m = 50,
                         key = Sys.getenv("GGMAP_GOOGLE_API_KEY")) {
  source <- match.arg(source)
  lat <- as.numeric(lat); lon <- as.numeric(lon)
  if (source == "google")
    return(.site_extract_google(place, lat, lon, key = key))

  if (!requireNamespace("terra", quietly = TRUE))
    stop("site_extract() needs the 'terra' package (in Suggests).")

  # Fetch a fine DEM patch big enough for the relief radius and a few
  # analysis-scale cells, projected to metres.
  aoi <- max(relief_radius_m * 1.5, analysis_scale_m * 3, 250)
  dem <- .dem_aws(lon, lat, z = z, aoi_m = aoi)
  native_res <- mean(terra::res(dem))

  ptv <- terra::project(
    terra::vect(data.frame(x = lon, y = lat), geom = c("x", "y"),
                crs = "EPSG:4326"), terra::crs(dem))

  # Elevation: at native (finest) resolution.
  elevation <- as.numeric(terra::extract(dem, ptv)[1, 2])

  # Slope / aspect / flow: at the requested analysis scale (aggregate the DEM).
  fact  <- max(1, round(analysis_scale_m / native_res))
  dem_a <- if (fact > 1) terra::aggregate(dem, fact = fact, fun = mean, na.rm = TRUE) else dem
  eff_scale <- mean(terra::res(dem_a))
  slope   <- as.numeric(terra::extract(terra::terrain(dem_a, "slope",  unit = "degrees"), ptv)[1, 2])
  aspect  <- as.numeric(terra::extract(terra::terrain(dem_a, "aspect", unit = "degrees"), ptv)[1, 2])
  fcode   <- as.numeric(terra::extract(terra::terrain(dem_a, "flowdir"), ptv)[1, 2])
  flow    <- .flowdir_compass(fcode)

  # Roughness + local relief: over a fixed radius (metres), from the fine DEM.
  buf  <- terra::buffer(ptv, width = relief_radius_m)
  vals <- terra::extract(dem, buf)[, 2]
  vals <- vals[is.finite(vals)]

  vals_out <- list(
    place            = place, lat = lat, lon = lon,
    source           = "aws (elevatr terrain tiles; 3DEP-blended in US)",
    native_res_m     = round(native_res, 1),
    analysis_scale_m = round(eff_scale, 1),
    relief_radius_m  = relief_radius_m,
    elevation_m      = round(elevation, 1),
    slope_deg        = round(slope, 0),
    aspect_deg       = round(aspect, 0),
    aspect_compass   = deg_to_compass(aspect),
    flow_dir         = flow,
    roughness_sd_m   = round(sd(vals), 1),
    relief_mean_m    = round(mean(vals), 1),
    relief_high_m    = round(max(vals), 1),
    relief_low_m     = round(min(vals), 1)
  )
  list(values = vals_out, sentences = .site_sentences(vals_out), dem = dem)
}

# --- legacy path: Google 3x3 (source = "google") -----------------------------

.google_elevation <- function(lat, lon, key = Sys.getenv("GGMAP_GOOGLE_API_KEY")) {
  if (!requireNamespace("httr", quietly = TRUE) ||
      !requireNamespace("jsonlite", quietly = TRUE))
    stop("source = 'google' needs the 'httr' and 'jsonlite' packages.")
  if (!nzchar(key)) stop("source='google' needs a key (GGMAP_GOOGLE_API_KEY).")
  url <- sprintf(
    "https://maps.googleapis.com/maps/api/elevation/json?locations=%s,%s&key=%s",
    format(lat, nsmall = 6), format(lon, nsmall = 6), key)
  resp <- jsonlite::fromJSON(httr::content(httr::GET(url), "text", encoding = "UTF-8"))
  if (resp$status != "OK") stop("Elevation API status: ", resp$status)
  list(elevation = resp$results$elevation, resolution = resp$results$resolution)
}

.site_extract_google <- function(place, lat, lon, spacing = 0.0002,
                                 key = Sys.getenv("GGMAP_GOOGLE_API_KEY")) {
  if (!requireNamespace("terra", quietly = TRUE) ||
      !requireNamespace("geosphere", quietly = TRUE))
    stop("source = 'google' needs the 'terra' and 'geosphere' packages.")
  lat3 <- c(lat - spacing, lat, lat + spacing)   # S, C, N
  lon3 <- c(lon - spacing, lon, lon + spacing)   # W, C, E
  pt_lat <- c(lat3[1],lat3[1],lat3[1], lat3[2],lat3[2],lat3[2], lat3[3],lat3[3],lat3[3])
  pt_lon <- c(lon3[1],lon3[2],lon3[3], lon3[1],lon3[2],lon3[3], lon3[1],lon3[2],lon3[3])
  e <- res <- numeric(9)
  for (i in 1:9) { g <- .google_elevation(pt_lat[i], pt_lon[i], key); e[i] <- g$elevation; res[i] <- g$resolution }

  r <- terra::rast(nrows = 3, ncols = 3, xmin = lon3[1], xmax = lon3[3],
                   ymin = lat3[1], ymax = lat3[3], crs = "EPSG:4326")
  terra::values(r) <- c(e[7],e[8],e[9], e[4],e[5],e[6], e[1],e[2],e[3])
  slope <- terra::values(terra::terrain(r, "slope", unit = "degrees", neighbors = 8))[5]

  dzdx <- ((e[9] + 2*e[6] + e[3]) - (e[7] + 2*e[4] + e[1])) / 8
  dzdy <- ((e[1] + 2*e[2] + e[3]) - (e[7] + 2*e[8] + e[9])) / 8
  raw  <- 57.29578 * atan2(dzdy, -dzdx)
  aspect <- if (raw < 0) 90 - raw else if (raw > 90) 360 - raw + 90 else 90 - raw
  flow <- c("SW","S","SE","W","C","E","NW","N","NE")[which.min(e)]

  vals_out <- list(
    place            = place, lat = lat, lon = lon,
    source           = "google (legacy 3x3)",
    native_res_m     = round(res[5], 0),
    analysis_scale_m = round(geosphere::distGeo(c(lon3[1],lat3[1]), c(lon3[1],lat3[2])), 1),
    relief_radius_m  = round(geosphere::distGeo(c(lon3[1],lat3[1]), c(lon3[3],lat3[1])), 1),
    elevation_m      = round(e[5], 1),
    slope_deg        = round(slope, 0),
    aspect_deg       = round(aspect, 0),
    aspect_compass   = deg_to_compass(aspect),
    flow_dir         = flow,
    roughness_sd_m   = round(sd(e), 1),
    relief_mean_m    = round(mean(e), 1),
    relief_high_m    = round(max(e), 1),
    relief_low_m     = round(min(e), 1)
  )
  list(values = vals_out, sentences = .site_sentences(vals_out), dem = r)
}

# --- shared: human-readable sentences ----------------------------------------

.site_sentences <- function(v) c(
  sprintf("The elevation of %s is %s m.", v$place, v$elevation_m),
  sprintf("Source: %s; native resolution %s m; terrain computed at a %s m analysis scale.",
          v$source, v$native_res_m, v$analysis_scale_m),
  sprintf("The slope is %s degrees.", v$slope_deg),
  sprintf("The aspect of the slope is %s degrees (%s).", v$aspect_deg, v$aspect_compass),
  sprintf("Roughness (elevation SD within %s m) is %s m.", v$relief_radius_m, v$roughness_sd_m),
  sprintf("Local relief within %s m: mean %s m, high %s m, low %s m.",
          v$relief_radius_m, v$relief_mean_m, v$relief_high_m, v$relief_low_m),
  sprintf("The water-flow direction from the centre is %s.", v$flow_dir)
)

# --- figures -----------------------------------------------------------------

#' Hillshade of a site DEM patch
#'
#' Plot a hillshade of the DEM patch returned by [site_extract()] with the
#' collection point marked. Intended for the `"aws"` source (a real DEM); the
#' legacy `"google"` 3x3 grid is too coarse to shade usefully.
#'
#' @param x A list returned by [site_extract()].
#' @param ... Further arguments passed to [terra::plot()].
#' @return Called for its plotting side effect; returns `NULL` invisibly.
#' @export
site_hillshade <- function(x, ...) {
  if (!requireNamespace("terra", quietly = TRUE))
    stop("site_hillshade() needs the 'terra' package.")
  r <- x$dem
  hs <- terra::shade(terra::terrain(r, "slope",  unit = "radians"),
                     terra::terrain(r, "aspect", unit = "radians"),
                     angle = 40, direction = 270)
  terra::plot(hs, col = grey(0:100/100), legend = FALSE,
              main = sprintf("%s  (%s m cells)", x$values$place, x$values$native_res_m), ...)
  pt <- terra::project(terra::vect(data.frame(x = x$values$lon, y = x$values$lat),
                       geom = c("x","y"), crs = "EPSG:4326"), terra::crs(r))
  terra::points(pt, pch = 21, bg = "red", cex = 1.6)
  invisible(NULL)
}

# --- substrate derive: geology (Macrostrat) + soil (SSURGO / SoilGrids) -------
# Kept as standalone functions rather than folded into site_extract()'s main
# call, because these web services are slower and optional. All are keyless.
# Design note (2026-07-01): SoilGrids' live REST is slow / rate-limited / 503-
# prone, so for pipelines prefer batching or caching over per-specimen calls.

#' Bedrock geology at a point (Macrostrat)
#'
#' Query the keyless, global Macrostrat API for the bedrock unit, lithology, and
#' age range at a coordinate.
#'
#' @param lat,lon Latitude and longitude in decimal degrees (WGS84).
#' @return A list with `unit`, `lithology`, `age_ma`, and `source`. Fields are
#'   `NA` when no data is available or the query fails.
#' @export
site_geology <- function(lat, lon) {
  if (!requireNamespace("httr", quietly = TRUE) ||
      !requireNamespace("jsonlite", quietly = TRUE))
    stop("site_geology() needs the 'httr' and 'jsonlite' packages.")
  u <- sprintf("https://macrostrat.org/api/v2/geologic_units/map?lat=%f&lng=%f", lat, lon)
  d <- tryCatch(jsonlite::fromJSON(httr::content(httr::GET(u, httr::timeout(30)),
                 "text", encoding = "UTF-8"))$success$data, error = function(e) NULL)
  if (is.null(d) || !length(d))
    return(list(unit = NA, lithology = NA, age_ma = NA, source = "Macrostrat"))
  lith <- toString(unique(unlist(lapply(d$lith,
            function(x) if (is.data.frame(x)) x$name else x))))
  t_lo <- suppressWarnings(min(d$t_age, na.rm = TRUE))
  b_hi <- suppressWarnings(max(d$b_age, na.rm = TRUE))
  age  <- if (is.finite(t_lo) && is.finite(b_hi)) sprintf("%g-%g", t_lo, b_hi) else NA
  list(unit      = toString(d$name),
       lithology = lith,
       age_ma    = age,
       source    = "Macrostrat")
}

# Soil: SSURGO (USDA, detailed) inside US coverage; SoilGrids (global 250 m) as
# fallback. source = "auto" tries SSURGO first, then SoilGrids.
.soil_ssurgo <- function(lat, lon) {
  if (!requireNamespace("soilDB", quietly = TRUE) ||
      !requireNamespace("sf", quietly = TRUE)) return(NULL)
  pt <- sf::st_as_sf(data.frame(x = lon, y = lat), coords = c("x", "y"), crs = 4326)
  mu <- tryCatch(soilDB::SDA_spatialQuery(pt, what = "mukey"), error = function(e) NULL)
  if (is.null(mu) || nrow(mu) == 0) return(NULL)
  q <- sprintf("SELECT TOP 1 m.muname, c.compname, c.comppct_r, c.taxorder, c.taxsubgrp, c.drainagecl
                FROM mapunit m INNER JOIN component c ON m.mukey = c.mukey
                WHERE m.mukey IN (%s) ORDER BY c.comppct_r DESC", paste(mu$mukey, collapse = ","))
  r <- tryCatch(soilDB::SDA_query(q), error = function(e) NULL)
  if (is.null(r) || nrow(r) == 0) return(NULL)
  list(map_unit = r$muname[1], component = r$compname[1], order = r$taxorder[1],
       subgroup = r$taxsubgrp[1], drainage = r$drainagecl[1], source = "SSURGO (USDA)")
}
.soil_soilgrids <- function(lat, lon) {
  if (!requireNamespace("httr", quietly = TRUE) ||
      !requireNamespace("jsonlite", quietly = TRUE)) return(NULL)
  u <- sprintf("https://rest.isric.org/soilgrids/v2.0/classification/query?lon=%f&lat=%f&number_classes=3", lon, lat)
  r <- tryCatch(httr::GET(u, httr::timeout(45)), error = function(e) NULL)
  if (is.null(r) || httr::status_code(r) != 200) return(NULL)
  j <- jsonlite::fromJSON(httr::content(r, "text", encoding = "UTF-8"))
  list(wrb_class = j$wrb_class_name, order = j$wrb_class_name,
       probabilities = j$wrb_class_probability, source = "SoilGrids (ISRIC 250 m)")
}

#' Soil classification at a point
#'
#' Return a soil classification for a coordinate. `source = "auto"` tries SSURGO
#' (detailed, USDA) first and falls back to SoilGrids (global, 250 m).
#'
#' @param lat,lon Latitude and longitude in decimal degrees (WGS84).
#' @param source One of `"auto"` (default), `"ssurgo"`, or `"soilgrids"`.
#' @return A list describing the soil (fields depend on the source), including
#'   `order` and `source`.
#' @export
site_soil <- function(lat, lon, source = c("auto", "ssurgo", "soilgrids")) {
  source <- match.arg(source)
  if (source %in% c("auto", "ssurgo")) {
    s <- .soil_ssurgo(lat, lon)
    if (!is.null(s)) return(s)
    if (source == "ssurgo") return(list(order = NA, source = "SSURGO (no coverage here)"))
  }
  s <- .soil_soilgrids(lat, lon)
  if (is.null(s)) list(order = NA, source = "soil query failed") else s
}

#' Substrate (geology + soil) with label sentences
#'
#' Combine [site_geology()] and [site_soil()] into both substrate layers plus
#' ready-to-use label sentences.
#'
#' @param lat,lon Latitude and longitude in decimal degrees (WGS84).
#' @param soil_source Passed to [site_soil()]; one of `"auto"`, `"ssurgo"`, `"soilgrids"`.
#' @return A list with `geology`, `soil`, and `sentences`.
#' @export
site_substrate <- function(lat, lon, soil_source = "auto") {
  g <- site_geology(lat, lon); s <- site_soil(lat, lon, soil_source)
  comp <- if (!is.null(s$component)) s$component else if (!is.null(s$wrb_class)) s$wrb_class else "n/a"
  sentences <- c(
    sprintf("Bedrock: %s (%s; %s Ma).", g$lithology, g$unit, g$age_ma),
    sprintf("Soil: %s%s [%s].",
            if (!is.null(s$order) && !is.na(s$order)) paste0(s$order, " - ") else "",
            comp, s$source))
  list(geology = g, soil = s, sentences = sentences)
}

# --- place name (reverse geocode) --------------------------------------------

#' Place name from a coordinate (reverse geocode)
#'
#' Reverse-geocode a coordinate to a human-readable place string using
#' OpenStreetMap Nominatim (free, keyless). The name is composed from the
#' reliable administrative levels only; OSM's erratic `city` field and the
#' postcode are deliberately skipped. The coordinate remains the authoritative
#' locality -- the place name is a convenience.
#'
#' Nominatim's usage policy limits requests to about one per second, so batch or
#' cache for bulk work.
#'
#' @param lat,lon Latitude and longitude in decimal degrees (WGS84).
#' @param zoom Nominatim address detail level (higher = finer).
#' @return A comma-separated place string, or `NA` if the lookup fails.
#' @export
site_place <- function(lat, lon, zoom = 16) {
  if (!requireNamespace("httr", quietly = TRUE) ||
      !requireNamespace("jsonlite", quietly = TRUE))
    stop("site_place() needs the 'httr' and 'jsonlite' packages.")
  u <- sprintf("https://nominatim.openstreetmap.org/reverse?lat=%f&lon=%f&format=jsonv2&zoom=%d&addressdetails=1",
               lat, lon, zoom)
  r <- tryCatch(httr::GET(u, httr::add_headers(`User-Agent` = "vouchr/0.0.0.9000 (kim.bridges@gmail.com)"),
                          httr::timeout(20)), error = function(e) NULL)
  if (is.null(r) || httr::status_code(r) != 200) return(NA_character_)
  a <- jsonlite::fromJSON(httr::content(r, "text", encoding = "UTF-8"))$address
  if (is.null(a)) return(NA_character_)
  pick <- function(keys) { for (k in keys) if (!is.null(a[[k]]) && nzchar(a[[k]])) return(a[[k]]); NA_character_ }
  # Compose from the RELIABLE administrative levels only (see @description).
  parts <- c(pick(c("neighbourhood", "quarter", "suburb", "hamlet", "village")),
             pick(c("island")),
             pick(c("county", "city_district")),
             pick(c("state")),
             pick(c("country")))
  parts <- parts[!is.na(parts)]
  if (!length(parts)) return(NA_character_)
  paste(unique(parts), collapse = ", ")
}
