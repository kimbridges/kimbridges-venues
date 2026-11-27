# japan_maple_animation.R -- phenological fronts sweeping across Japan, maple (autumn) or cherry (spring) (S3, ch.5, ch.7).
# Kim + Claude, 2026-11-26. Needs japan_front_maps.R (jfm_dem, jfm_normals, jfm_surface, jfm_crs).
# Each land cell gets its normal (1991-2020) date from the JMA observations; a frame colors each cell by days since that date.
# Only the observed date is data; the stages before and after it are schematic.
library(terra); library(sf)
jma_stages <- list(
  maple  = list(k = c(-15, -6, 0, 8, 22, 40), cols = c("#4f7d3a", "#c9a23a", "#e0662a", "#a8261a", "#6e4a2e", "#a39a8c"),
                key = c(green = "#4f7d3a", turning = "#c9a23a", `peak color` = "#a8261a", fading = "#6e4a2e", bare = "#a39a8c"),
                shade = 0.45, days = 258:365, title = "The maple front", what = "Japanese maple leaf coloring", accent = "#a8261a"),
  cherry = list(k = c(-15, -7, 0, 6, 12, 20, 40), cols = c("#8a7f74", "#b0838f", "#f0609a", "#ff9ec6", "#ead2a6", "#9cc069", "#5f8f45"), shade = 0.30,
                key = c(`bare branches` = "#8a7f74", buds = "#a9858c", `first flowers` = "#f0609a", `full bloom` = "#ff9ec6", `petal fall` = "#ead2a6", `new leaves` = "#7fa957"),
                days = 60:155, title = "The cherry front", what = "cherry flowering (Somei-yoshino; other species in Hokkaido's north and east)", accent = "#c2457a"))
jma_stage_pal <- function(st, lo = -15, hi = 40) {
  t <- lo:hi; m <- sapply(1:3, function(i) approx(st$k, col2rgb(st$cols)[i, ], t, rule = 2)$y); list(t = t, rgb = m / 255) }
jma_anim_frames <- function(d, dem, outdir, event = "maple", days = jma_stages[[event]]$days, emax = 1000, px = 1000,
                            cities = data.frame(city = c("Sapporo", "Sendai", "Tokyo", "Kyoto", "Fukuoka"),
                                                LON = c(141.35, 140.87, 139.69, 135.77, 130.40), LAT = c(43.06, 38.27, 35.69, 35.01, 33.59))) {
  st <- jma_stages[[event]]; dir.create(outdir, showWarnings = FALSE, recursive = TRUE)
  nm <- jfm_normals(d); r <- jfm_surface(nm[nm$event == event, ], dem, emax)
  demp <- project(dem, jfm_crs, res = 4000); rp <- project(r, demp); rp[is.na(demp)] <- NA
  sl <- terrain(demp, "slope", unit = "radians"); as_ <- terrain(demp, "aspect", unit = "radians")
  hs <- shade(sl, as_, angle = 40, direction = 315); hs <- (hs - global(hs, "min", na.rm = TRUE)[[1]]) / diff(unlist(global(hs, range, na.rm = TRUE)))
  shv <- (1 - st$shade) + st$shade * as.matrix(hs, wide = TRUE); shv[is.na(shv)] <- 0.8; dv <- as.matrix(rp, wide = TRUE); land <- !is.na(dv)
  land_sf <- st_as_sf(as.polygons(!is.na(demp) * 1, dissolve = TRUE)); land_sf <- land_sf[land_sf[[1]] == 1, ]
  cx <- st_coordinates(st_transform(st_as_sf(cities, coords = c("LON", "LAT"), crs = 4326), jfm_crs))
  e <- as.vector(ext(demp)); asp <- (e[["ymax"]] - e[["ymin"]]) / (e[["xmax"]] - e[["xmin"]]); h <- round(px * asp / 2) * 2
  P <- jma_stage_pal(st); sea <- col2rgb("#e9eef2")[, 1] / 255; files <- character()
  u <- function(fx, fy) c(e[["xmin"]] + fx * (e[["xmax"]] - e[["xmin"]]), e[["ymin"]] + fy * (e[["ymax"]] - e[["ymin"]]))
  for (k in seq_along(days)) {
    idx <- pmin(pmax(round(days[k] - dv), -15), 40) + 16
    img <- array(rep(sea, each = length(dv)), c(nrow(dv), ncol(dv), 3))
    for (i in 1:3) { ch <- img[, , i]; ch[land] <- P$rgb[idx[land], i] * shv[land]; img[, , i] <- ch }
    f <- file.path(outdir, sprintf("f%03d.png", k)); files[k] <- f
    ragg::agg_png(f, width = px, height = h, res = 110, background = "#e9eef2")
    par(mar = c(0, 0, 0, 0)); plot.new(); plot.window(e[1:2], e[3:4], xaxs = "i", yaxs = "i", asp = 1)
    rasterImage(as.raster(img), e[["xmin"]], e[["ymin"]], e[["xmax"]], e[["ymax"]], interpolate = FALSE)
    plot(st_geometry(land_sf), add = TRUE, border = "grey25", lwd = 0.5)
    points(cx, pch = 21, bg = "white", cex = 1.1); text(cx[, 1] + 45000, cx[, 2], cities$city, adj = 0, cex = 0.9, font = 2, col = "grey10")
    dte <- as.Date("2021-01-01") + days[k] - 1
    p1 <- u(0.03, 0.95); text(p1[1], p1[2], st$title, adj = c(0, 1), cex = 1.7, font = 2, col = "grey10")
    p2 <- u(0.03, 0.895); text(p2[1], p2[2], format(dte, "%B %d"), adj = c(0, 1), cex = 2.3, font = 2, col = st$accent)
    p3 <- u(0.03, 0.81); text(p3[1], p3[2], "Normal timing, 1991-2020", adj = c(0, 1), cex = 0.95, col = "grey30")
    dy <- e[["ymax"]] - e[["ymin"]]
    for (j in seq_along(st$key)) { q <- u(0.03, 0.76 - 0.035 * j); rect(q[1], q[2], q[1] + 40000, q[2] + 0.025 * dy, col = st$key[j], border = NA); text(q[1] + 55000, q[2] + 0.0125 * dy, names(st$key)[j], adj = 0, cex = 0.9) }
    a <- u(0.55, 0.06); b <- u(0.97, 0.06); segments(a[1], a[2], b[1], b[2], lwd = 3, col = "grey60")
    m1 <- as.integer(format(as.Date("2021-01-01") + range(days) - 1, "%m")); for (m in (m1[1] + 1):m1[2]) {
      mx <- a[1] + (b[1] - a[1]) * (as.numeric(as.Date(sprintf("2021-%02d-01", m)) - as.Date("2021-01-01")) + 1 - days[1]) / diff(range(days))
      segments(mx, a[2] - 15000, mx, a[2] + 15000, col = "grey40"); text(mx, a[2] - 45000, month.abb[m], cex = 0.85, col = "grey30") }
    px_ <- a[1] + (b[1] - a[1]) * (days[k] - days[1]) / diff(range(days)); points(px_, a[2], pch = 21, bg = st$accent, cex = 1.8)
    cpt <- u(0.03, 0.015); text(cpt[1], cpt[2], paste0("Data: Japan Meteorological Agency phenology, ", st$what, ". Stages around the observed date are schematic."), adj = c(0, 0), cex = 0.62, col = "grey35")
    dev.off() }
  invisible(files) }
jma_anim_write <- function(files, gif, mp4 = NULL, fps = 8, hold = 16) {
  wh <- dim(png::readPNG(files[1]))[2:1]; fr <- c(files, rep(tail(files, 1), hold))
  gifski::gifski(fr, gif, width = wh[1], height = wh[2], delay = 1 / fps, progress = FALSE)
  if (!is.null(mp4)) av::av_encode_video(fr, mp4, framerate = fps, verbose = FALSE) }
# Example: source("japan_front_maps.R"); source("japan_maple_animation.R")
# d <- readRDS("jma_phenology_work.rds")$d; dem <- jfm_dem("C:/temp/s3_koyo_20261126")
# f <- jma_anim_frames(d, dem, "C:/temp/frames_cherry", event = "cherry"); jma_anim_write(f, "japan_cherry_front.gif", "japan_cherry_front.mp4")
