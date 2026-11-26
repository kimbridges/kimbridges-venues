# pressure_terrain.R -- sea-level pressure drawn as terrain (highs = hills, lows = basins)
# S3 / trilogy catalog prototype. Kim + Claude, 2026-11-25.
# Data: NOAA GFS 0.25-degree analysis (f000) via the NOMADS grib filter.
# Height = smoothed sea-level pressure; color = 850 hPa temperature; isobars and coastlines draped.
# Needs: terra, sf, rnaturalearth, rayshader (+ rgl). Opens an rgl window while rendering.
# Caveats: vertical exaggeration is arbitrary; sea-level pressure over high terrain is an
# extrapolation (noisy over the Rockies) -- hence the Gaussian smoothing.

library(terra); library(sf); library(rayshader); sf_use_s2(FALSE)

pt_get_gfs <- function(day, cyc, dir = tempdir(),
                       box = c(top = 65, left = 180, right = 310, bottom = 10)) {
  q <- paste0("https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?dir=%2Fgfs.", day, "%2F", cyc, "%2Fatmos",
              "&file=gfs.t", cyc, "z.pgrb2.0p25.f000",
              "&var_PRMSL=on&var_HGT=on&var_TMP=on&lev_mean_sea_level=on&lev_500_mb=on&lev_850_mb=on",
              "&subregion=&toplat=", box[["top"]], "&leftlon=", box[["left"]],
              "&rightlon=", box[["right"]], "&bottomlat=", box[["bottom"]])
  out <- file.path(dir, paste0("gfs_", day, "_", cyc, "z.grb2"))
  curl::curl_download(q, out, handle = curl::new_handle(timeout = 120)); out
}

pt_smooth <- function(x, sigma = 0.75) {           # Gaussian smoothing, edge-normalized
  g <- focalMat(x, sigma, type = "Gauss"); one <- x * 0 + 1
  focal(x, g, fun = "sum", na.rm = TRUE) / focal(one, g, fun = "sum", na.rm = TRUE)
}

pt_scene <- function(grib, base = 970, trange = c(-30, 25)) {
  r <- rast(grib); slp <- pt_smooth(r[["PRMSL_0-MSL"]] / 100); t850 <- r[["TMP_85000-ISBL"]]
  elev <- raster_to_matrix(slp - base); tmat <- pmin(pmax(raster_to_matrix(t850), trange[1]), trange[2])
  pal <- colorRampPalette(c("#2c5c8f", "#7fa7c9", "#e9e4d4", "#d9a27c", "#a8452e"))(256)
  e <- ext(slp); v <- as.vector(e)
  bb <- st_bbox(c(xmin = v[["xmin"]], ymin = v[["ymin"]], xmax = v[["xmax"]], ymax = v[["ymax"]]), crs = st_crs(4326))
  coast <- st_cast(st_geometry(st_crop(rnaturalearth::ne_countries(scale = 50, returnclass = "sf"), bb)), "MULTILINESTRING")
  img <- height_shade(tmat, texture = pal, range = trange) |>
    add_shadow(lamb_shade(elev, zscale = 0.05), 0.35) |>
    add_overlay(generate_contour_overlay(elev, levels = seq(960, 1060, 4) - base, color = "black", linewidth = 0.6), alphalayer = 0.35) |>
    add_overlay(generate_line_overlay(coast, extent = e, heightmap = elev, color = "grey10", linewidth = 1.2))
  list(img = img, elev = elev, ext = e)
}

pt_render <- function(sc, labels = NULL, file = "pressure_terrain.png", zscale = 0.7,
                      theta = -18, phi = 40, zoom = 0.7) {
  plot_3d(sc$img, sc$elev, zscale = zscale, solid = TRUE, soliddepth = -5, solidcolor = "grey55",
          shadow = FALSE, windowsize = c(1600, 1000), theta = theta, phi = phi, zoom = zoom,
          fov = 35, background = "white")
  if (!is.null(labels)) for (k in seq_len(nrow(labels)))
    render_label(sc$elev, lat = labels$lat[k], long = labels$lon[k], extent = sc$ext, zscale = zscale,
                 text = labels$txt[k], altitude = 25, textsize = 1.6, linewidth = 2,
                 textcolor = "black", linecolor = "grey20")
  Sys.sleep(1); render_snapshot(file); rgl::close3d(); invisible(file)
}


# 500 hPa height surface as terrain (decametres above its own minimum); color = 500 hPa temperature.
# Contours every 6 dam, as on forecasters' upper-air charts. No smoothing needed.
pt_scene500 <- function(grib, trange = c(-42, -8)) {
  r <- rast(grib); z <- r[["HGT_50000-ISBL"]]; t5 <- r[["TMP_50000-ISBL"]]
  zmin <- floor(unlist(global(z, "min", na.rm = TRUE)) / 10)
  elev <- raster_to_matrix(z / 10 - zmin); tmat <- pmin(pmax(raster_to_matrix(t5), trange[1]), trange[2])
  pal <- colorRampPalette(c("#2c5c8f", "#7fa7c9", "#e9e4d4", "#d9a27c", "#a8452e"))(256)
  e <- ext(z); v <- as.vector(e)
  bb <- st_bbox(c(xmin = v[["xmin"]], ymin = v[["ymin"]], xmax = v[["xmax"]], ymax = v[["ymax"]]), crs = st_crs(4326))
  coast <- st_cast(st_geometry(st_crop(rnaturalearth::ne_countries(scale = 50, returnclass = "sf"), bb)), "MULTILINESTRING")
  img <- height_shade(tmat, texture = pal, range = trange) |>
    add_shadow(lamb_shade(elev, zscale = 0.05), 0.4) |>
    add_overlay(generate_contour_overlay(elev, levels = seq(480, 600, 6) - zmin, color = "black", linewidth = 0.9), alphalayer = 0.55) |>
    add_overlay(generate_line_overlay(coast, extent = e, heightmap = elev, color = "grey10", linewidth = 1.2))
  list(img = img, elev = elev, ext = e)   # note: a SpatExtent does not survive saveRDS; rebuild with ext(rast(grib))
}
# sc5 <- pt_scene500(g)
# lab5 <- data.frame(lon = c(-145.1, -96.25, -155.5), lat = c(51.75, 39.5, 19.25),
#                    txt = c("Trough (522 dam)", "Closed low (556 dam)", "Subtropical high (588 dam)"))
# pt_render(sc5, lab5, "z500_terrain_20261125_18z.png", zscale = 1.5, theta = -12, phi = 42, zoom = 0.66)


# ---- the moving landscape: one frame per GFS analysis, fixed floor/colors/camera ----------
# files: sorted grib paths (e.g., from pt_get_gfs over several days); zmin_dam: common floor
# (floor of the smallest 500 hPa height across all files, in dam). Returns the PNG path.
pt_frame500 <- function(file, out, ext_ref, coast, zmin_dam, trange = c(-42, -8)) {
  r <- rast(file); z <- r[["HGT_50000-ISBL"]]; t5 <- r[["TMP_50000-ISBL"]]
  elev <- raster_to_matrix(z / 10 - zmin_dam); tmat <- pmin(pmax(raster_to_matrix(t5), trange[1]), trange[2])
  pal <- colorRampPalette(c("#2c5c8f", "#7fa7c9", "#e9e4d4", "#d9a27c", "#a8452e"))(256)
  img <- height_shade(tmat, texture = pal, range = trange) |>
    add_shadow(lamb_shade(elev, zscale = 0.05), 0.4) |>
    add_overlay(generate_contour_overlay(elev, levels = seq(480, 600, 6) - zmin_dam, color = "black", linewidth = 1.6), alphalayer = 0.8) |>
    add_overlay(generate_line_overlay(coast, extent = ext_ref, heightmap = elev, color = "grey10", linewidth = 1.2))
  hst <- format(time(z) - 10 * 3600, "%a %b %d, %I %p HST", tz = "UTC")
  plot_3d(img, elev, zscale = 1.5, solid = TRUE, soliddepth = -3, solidcolor = "grey60", shadow = FALSE,
          windowsize = c(1400, 876), theta = -12, phi = 42, zoom = 0.66, fov = 35, background = "white")
  render_snapshot(out, title_text = paste0("500 hPa surface as terrain   |   ", hst), title_size = 28,
                  title_color = "grey15", title_bar_color = "white", title_bar_alpha = 1)
  rgl::close3d(); out
}
# Assemble: gifski::gifski(pngs, "anim.gif", width = 1000, height = 625, delay = 0.45)
#           av::av_encode_video(pngs, "anim.mp4", framerate = 1/0.45)   # even frame height needed
# (2026-11-25 run: 25 frames, Nov 19 18Z - Nov 25 18Z, zmin_dam = 496.)

# ---- example: 2026-11-25 18Z -------------------------------------------------
# g  <- pt_get_gfs("20261125", "18")
# sc <- pt_scene(g)
# lab <- data.frame(lon = c(-138.75, -144.75, -73.25, -111.25, -177.0),
#                   lat = c(47.5, 57.75, 44.75, 42.25, 39.0),
#                   txt = c("L 975", "L 983", "H 1042", "H 1033", "H 1033"))
# pt_render(sc, lab, "pressure_terrain_20261125_18z.png")
