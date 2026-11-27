# japan_front_maps.R -- maps of Japan's phenological fronts (S3, ch.5 and ch.6). Kim + Claude, 2026-11-26.
# Input: d, the station-year table from jf_get() in japan_fronts.R (stn, event, year, doy, LAT, LON, ELEV.M.).
# Surface = lm(doy ~ LAT + LON + ELEV.M.) + thin-plate spline (fields::Tps) of residuals, predicted on WorldClim 30" DEM
# (geodata::elevation_30s, aggregated to ~3.3 km), elevation capped at emax (stations reach only 612 m).
library(terra); library(sf); library(ggplot2); library(patchwork)
jfm_crs <- "+proj=lcc +lat_1=33 +lat_2=43 +lat_0=38 +lon_0=137 +datum=WGS84 +units=m"
jfm_dem <- function(path = tempdir(), e = ext(128.5, 146.2, 30.8, 45.8), fact = 4)
  aggregate(crop(geodata::elevation_30s("JPN", path = path), e), fact, mean, na.rm = TRUE)
jfm_normals <- function(d, y0 = 1991, y1 = 2020) aggregate(doy ~ stn + event + LAT + LON + ELEV.M., d[d$LAT > 30 & d$year >= y0 & d$year <= y1, ], median)
jfm_surface <- function(z, dem, emax = 1000) {
  f <- lm(doy ~ LAT + LON + ELEV.M., z); tp <- fields::Tps(cbind(z$LON, z$LAT), resid(f))
  xy <- crds(dem, na.rm = TRUE); el <- pmax(pmin(values(dem, na.rm = TRUE)[, 1], emax), 0)
  r <- dem; r[!is.na(r)] <- predict(f, data.frame(LAT = xy[, 2], LON = xy[, 1], ELEV.M. = el)) + predict(tp, xy)[, 1]; names(r) <- "doy"
  attr(r, "fit") <- f; r }
jfm_figure <- function(d, dem, file, emax = 1000) {
  nm <- jfm_normals(d); S <- lapply(split(nm, nm$event)[c("cherry", "maple")], jfm_surface, dem = dem, emax = emax)
  el <- round(100 * sapply(S, function(r) coef(attr(r, "fit"))[["ELEV.M."]]), 1)
  demp <- project(dem, jfm_crs, res = 4000); prj <- function(r) { p <- project(r, demp); p[is.na(demp)] <- NA; p }
  land <- st_as_sf(as.polygons(!is.na(demp) * 1, dissolve = TRUE)); land <- land[land[[1]] == 1, ]
  hi <- st_as_sf(as.polygons(classify(demp, cbind(c(-Inf, emax), c(emax, Inf), c(NA, 1))), dissolve = TRUE))
  st <- st_transform(st_as_sf(unique(nm[, c("stn", "LON", "LAT")]), coords = c("LON", "LAT"), crs = 4326), jfm_crs)
  cty <- st_transform(st_as_sf(data.frame(city = c("Sapporo", "Tokyo", "Kyoto", "Fukuoka"), LON = c(141.35, 139.69, 135.77, 130.40), LAT = c(43.06, 35.69, 35.01, 33.59)), coords = c("LON", "LAT"), crs = 4326), jfm_crs)
  cxy <- cbind(st_drop_geometry(cty), st_coordinates(cty))
  md <- function(y0, y1) aggregate(doy ~ stn + LON + LAT, d[d$LAT > 30 & d$event == "maple" & d$year >= y0 & d$year <= y1, ], median)
  sh <- merge(md(1961, 1990), md(1996, 2025), by = c("stn", "LON", "LAT")); sh$shift <- sh$doy.y - sh$doy.x
  sh <- st_transform(st_as_sf(sh, coords = c("LON", "LAT"), crs = 4326), jfm_crs)
  dd <- function(doy) format(as.Date("2021-01-01") + doy - 1, "%b %d")
  th <- theme_void(base_size = 13) + theme(plot.title = element_text(face = "bold"), plot.subtitle = element_text(color = "grey35", size = 10),
    legend.position = "inside", legend.position.inside = c(0.02, 0.97), legend.justification = c(0, 1), legend.key.size = unit(0.45, "cm"), legend.text = element_text(size = 9.5))
  cities <- list(geom_point(data = cxy, aes(X, Y), shape = 21, size = 2.2, fill = "white", color = "black"),
    geom_label(data = cxy, aes(X, Y, label = city), nudge_x = 60000, hjust = 0, size = 3.3, label.size = 0, fill = scales::alpha("white", 0.75), label.padding = unit(0.1, "lines")))
  mapfront <- function(r, brks, pal, title, sub) {
    df <- as.data.frame(r, xy = TRUE, na.rm = TRUE); names(df)[3] <- "doy"
    df$bin <- cut(df$doy, brks, labels = paste(dd(head(brks, -1)), "-", dd(tail(brks, -1) - 1)), include.lowest = TRUE)
    ggplot() + geom_raster(data = df, aes(x, y, fill = bin)) + geom_contour(data = df, aes(x, y, z = doy), breaks = brks, color = "white", linewidth = 0.18, alpha = 0.8) +
      geom_sf(data = hi, fill = "grey45", color = NA, alpha = 0.5) + geom_sf(data = land, fill = NA, color = "grey30", linewidth = 0.2) +
      geom_sf(data = st, size = 0.5, color = "black") + cities +
      scale_fill_manual(values = grDevices::colorRampPalette(pal)(length(brks) - 1), drop = FALSE, name = NULL) +
      coord_sf(expand = FALSE, datum = NA) + labs(title = title, subtitle = sub, x = NULL, y = NULL) + th }
  pC <- mapfront(prj(S$cherry), seq(80, 150, 10), c("#7a1f45", "#c24f7d", "#eba3bf", "#fbe9f0"), "A.  The cherry front moves north", "When the cherries bloom (1991-2020 normal), in 10-day bands")
  pM <- mapfront(prj(S$maple), seq(260, 360, 10), c("#6b0f0a", "#b23a1e", "#e07b2a", "#f2c14e", "#f8ecc2"), "B.  The maple front moves south and downhill", "When the maple leaves turn (1991-2020 normal), in 10-day bands")
  pS <- ggplot() + geom_sf(data = land, fill = "grey93", color = "grey55", linewidth = 0.2) +
    geom_sf(data = sh, aes(fill = shift), shape = 21, color = "grey30", stroke = 0.2, size = 3) +
    scale_fill_gradient2(low = "#2c5c8f", mid = "#f2efe6", high = "#b23a1e", midpoint = 0, limits = c(-25, 25), oob = scales::squish, name = "days later") +
    coord_sf(expand = FALSE, datum = NA) + labs(title = "C.  The maples turn later almost everywhere", subtitle = sprintf("Change in station median, 1996-2025 vs 1961-1990 (median +%.1f days)", median(sh$shift))) + th
  cap <- paste0("Data: Japan Meteorological Agency phenological observations (designated sample trees), stations north of 30\u00B0N. Surface: regression on latitude, longitude and elevation plus a thin-plate spline of the residuals.\n",
    sprintf("Each 100 m of elevation delays cherry flowering %.1f days and brings maple color %.1f days earlier. ", el[1], -el[2]),
    sprintf("Grey: terrain above %d m, beyond the stations (highest %.0f m); the surface is held at its %d m value there, and the mountains color earlier still.", emax, max(nm$ELEV.M.), emax))
  fig <- (pC | pM | pS) + plot_annotation(caption = cap, theme = theme(plot.caption = element_text(size = 9.5, color = "grey40", hjust = 0)))
  ragg::agg_png(file, width = 18, height = 8.2, units = "in", res = 110, background = "white"); print(fig); dev.off()
  invisible(list(shift = sh, elev_days_per_100m = el)) }
# Example (2026-11-26):
# d <- readRDS("jma_phenology_work.rds")$d; dem <- jfm_dem("C:/temp/s3_koyo_20261126")
# jfm_figure(d, dem, "japan_front_maps.png")
