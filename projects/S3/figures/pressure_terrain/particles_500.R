# particles_500.R -- particles carried by the 500 hPa wind over its own contours (S3 catalog).
# Kim + Claude, 2026-11-25. Frozen field (one GFS analysis); bilinear winds; fading trails; particles
# respawned by age or when they leave the map. Background (jet shading, contours, coast) is built once
# and redrawn cheaply each frame; ragg device (the Windows png device is very slow with alpha). Output: PNG frames (+ GIF via gifski).
library(terra)

particles_500 <- function(grib, outdir, n = 1500, frames = 90, dt_min = 20, substeps = 2, trail = 14,
                          max_age = 45, seed = 42, width = 1120, height = 640, lat_min = 12) {
  set.seed(seed); dir.create(outdir, showWarnings = FALSE, recursive = TRUE)
  r <- rast(grib); z <- r[["HGT_50000-ISBL"]]
  M <- function(x) as.matrix(x, wide = TRUE)                         # row 1 = north
  U <- M(r[["UGRD_50000-ISBL"]]); V <- M(r[["VGRD_50000-ISBL"]])
  S <- sqrt(M(r[["UGRD_25000-ISBL"]])^2 + M(r[["VGRD_25000-ISBL"]])^2); Z <- M(z)
  e <- as.vector(ext(z)); rs <- res(z)[1]
  lons <- seq(e[["xmin"]] + rs / 2, by = rs, length.out = ncol(Z)); lats <- seq(e[["ymax"]] - rs / 2, by = -rs, length.out = nrow(Z))
  ## background pieces, once
  jet <- colorRampPalette(c("#ffffff", "#e6e1f0", "#c3b8de", "#9283c2", "#5f4a9c"))(60)
  bg <- as.raster(matrix(jet[pmin(pmax(ceiling(S / 95 * 60), 1), 60)], nrow(S)))
  cl <- contourLines(lons, rev(lats), t(Z[nrow(Z):1, ]), levels = seq(4980, 6000, 60))
  land <- crop(vect(rnaturalearth::ne_countries(scale = 50, returnclass = "sf")), ext(z))
  g <- geom(land); key <- paste(g[, "geom"], g[, "part"], g[, "hole"]); brk <- c(TRUE, key[-1] != key[-nrow(g)])
  cx <- unlist(lapply(split(seq_len(nrow(g)), cumsum(brk)), function(i) c(g[i, "x"], NA)))
  cy <- unlist(lapply(split(seq_len(nrow(g)), cumsum(brk)), function(i) c(g[i, "y"], NA)))
  ## fast bilinear lookup
  bil <- function(A, x, y) {
    fx <- (x - lons[1]) / rs + 1; fy <- (lats[1] - y) / rs + 1
    i0 <- pmin(pmax(floor(fx), 1), ncol(A) - 1); j0 <- pmin(pmax(floor(fy), 1), nrow(A) - 1); ax <- fx - i0; ay <- fy - j0
    (1 - ax) * (1 - ay) * A[cbind(j0, i0)] + ax * (1 - ay) * A[cbind(j0, i0 + 1)] +
      (1 - ax) * ay * A[cbind(j0 + 1, i0)] + ax * ay * A[cbind(j0 + 1, i0 + 1)] }
  lon0 <- e[["xmin"]] + 0.5; lon1 <- e[["xmax"]] - 0.5; lat0 <- lat_min; lat1 <- e[["ymax"]] - 0.5
  spawn <- function(k) cbind(runif(k, lon0, lon1), runif(k, lat0, lat1))
  P <- spawn(n); age <- sample(0:max_age, n, replace = TRUE)
  hx <- matrix(P[, 1], n, trail); hy <- matrix(P[, 2], n, trail)
  dt <- dt_min * 60 / substeps; files <- character(frames); asp <- 1 / cos(mean(c(e[["ymin"]], e[["ymax"]])) * pi / 180)
  trail_col <- adjustcolor("#a8452e", alpha.f = 1); alphas <- 1 - (seq_len(trail - 1) - 1) / trail
  for (f in seq_len(frames)) {
    for (s in seq_len(substeps)) {
      u <- bil(U, P[, 1], P[, 2]); v <- bil(V, P[, 1], P[, 2])
      P[, 1] <- P[, 1] + u * dt / (111320 * cos(P[, 2] * pi / 180)); P[, 2] <- P[, 2] + v * dt / 111320 }
    age <- age + 1
    dead <- age > max_age | P[, 1] < lon0 | P[, 1] > lon1 | P[, 2] < lat0 | P[, 2] > lat1
    if (any(dead)) { P[dead, ] <- spawn(sum(dead)); age[dead] <- 0 }
    hx <- cbind(P[, 1], hx[, -trail]); hy <- cbind(P[, 2], hy[, -trail])
    if (any(dead)) { hx[dead, ] <- P[dead, 1]; hy[dead, ] <- P[dead, 2] }
    files[f] <- file.path(outdir, sprintf("p_%03d.png", f))
    ragg::agg_png(files[f], width = width, height = height); par(mar = c(0.3, 0.3, 2.2, 0.3))
    plot.new(); plot.window(xlim = c(e[["xmin"]], e[["xmax"]]), ylim = c(e[["ymin"]], e[["ymax"]]), asp = asp, xaxs = "i", yaxs = "i")
    rasterImage(bg, e[["xmin"]], e[["ymin"]], e[["xmax"]], e[["ymax"]], interpolate = TRUE)
    lines(cx, cy, col = "grey60", lwd = 0.7)
    for (k in seq_along(cl)) lines(cl[[k]]$x, cl[[k]]$y, col = "grey35", lwd = 0.7)
    for (j in 1:(trail - 1)) segments(hx[, j + 1], hy[, j + 1], hx[, j], hy[, j],
                                       col = adjustcolor("#a8452e", alpha.f = alphas[j]), lwd = 1.7 - j * 0.12)
    mtext("Air carried by the 500 hPa wind (about 5.5 km up): it follows the contours. Purple: jet core (250 hPa speed).",
          side = 3, adj = 0, line = 0.6, cex = 1.15)
    dev.off()
  }
  files
}
# f <- particles_500("gfs_20261125_18z_wind.grb2", "particles")
# gifski::gifski(f, "particles_500_20261125_18z.gif", width = 1120, height = 640, delay = 0.08)

# ---- surface companion: particles carried by the 10 m wind over sea-level isobars ---------------
# Surface winds are slower, so each frame covers 60 min of flow (3x the 500 hPa version).
particles_10m <- function(grib, outdir, n = 1500, frames = 120, dt_min = 60, substeps = 3, trail = 14,
                          max_age = 45, seed = 42, width = 1120, height = 640, lat_min = 12,
                          highs = NULL, lows = NULL) {
  set.seed(seed); dir.create(outdir, showWarnings = FALSE, recursive = TRUE)
  r <- rast(grib); p <- r[["PRMSL_0-MSL"]] / 100
  M <- function(x) as.matrix(x, wide = TRUE)
  U <- M(r[["UGRD_10-HTGL"]]); V <- M(r[["VGRD_10-HTGL"]]); S <- sqrt(U^2 + V^2); Pm <- M(p)
  e <- as.vector(ext(p)); rs <- res(p)[1]
  lons <- seq(e[["xmin"]] + rs / 2, by = rs, length.out = ncol(Pm)); lats <- seq(e[["ymax"]] - rs / 2, by = -rs, length.out = nrow(Pm))
  pal <- colorRampPalette(c("#ffffff", "#e3edf5", "#bcd3e6", "#8fb3d3"))(40)
  cl <- contourLines(lons, rev(lats), t(Pm[nrow(Pm):1, ]), levels = seq(960, 1048, 4))
  land <- crop(vect(rnaturalearth::ne_countries(scale = 50, returnclass = "sf")), ext(p))
  lm <- M(rasterize(land, p, field = 1, background = 0)) == 1           # land cells, baked into the background
  bcol <- pal[pmin(pmax(ceiling(S / 20 * 40), 1), 40)]; rgbm <- col2rgb(bcol)
  rgbm[, lm] <- round(rgbm[, lm] * 0.88)                               # land a shade darker
  bg <- as.raster(matrix(rgb(rgbm[1, ], rgbm[2, ], rgbm[3, ], maxColorValue = 255), nrow(S)))
  g <- geom(land); key <- paste(g[, "geom"], g[, "part"], g[, "hole"]); brk <- c(TRUE, key[-1] != key[-nrow(g)])
  idx <- split(seq_len(nrow(g)), cumsum(brk))
  cx <- unlist(lapply(idx, function(i) c(g[i, "x"], NA))); cy <- unlist(lapply(idx, function(i) c(g[i, "y"], NA)))
  bil <- function(A, x, y) {
    fx <- (x - lons[1]) / rs + 1; fy <- (lats[1] - y) / rs + 1
    i0 <- pmin(pmax(floor(fx), 1), ncol(A) - 1); j0 <- pmin(pmax(floor(fy), 1), nrow(A) - 1); ax <- fx - i0; ay <- fy - j0
    (1 - ax) * (1 - ay) * A[cbind(j0, i0)] + ax * (1 - ay) * A[cbind(j0, i0 + 1)] +
      (1 - ax) * ay * A[cbind(j0 + 1, i0)] + ax * ay * A[cbind(j0 + 1, i0 + 1)] }
  lon0 <- e[["xmin"]] + 0.5; lon1 <- e[["xmax"]] - 0.5; lat0 <- lat_min; lat1 <- e[["ymax"]] - 0.5
  spawn <- function(k) cbind(runif(k, lon0, lon1), runif(k, lat0, lat1))
  P <- spawn(n); age <- sample(0:max_age, n, replace = TRUE)
  hx <- matrix(P[, 1], n, trail); hy <- matrix(P[, 2], n, trail)
  dt <- dt_min * 60 / substeps; files <- character(frames); asp <- 1 / cos(mean(c(e[["ymin"]], e[["ymax"]])) * pi / 180)
  alphas <- 1 - (seq_len(trail - 1) - 1) / trail
  for (fr in seq_len(frames)) {
    for (s in seq_len(substeps)) {
      u <- bil(U, P[, 1], P[, 2]); v <- bil(V, P[, 1], P[, 2])
      P[, 1] <- P[, 1] + u * dt / (111320 * cos(P[, 2] * pi / 180)); P[, 2] <- P[, 2] + v * dt / 111320 }
    age <- age + 1
    dead <- age > max_age | P[, 1] < lon0 | P[, 1] > lon1 | P[, 2] < lat0 | P[, 2] > lat1
    if (any(dead)) { P[dead, ] <- spawn(sum(dead)); age[dead] <- 0 }
    hx <- cbind(P[, 1], hx[, -trail]); hy <- cbind(P[, 2], hy[, -trail])
    if (any(dead)) { hx[dead, ] <- P[dead, 1]; hy[dead, ] <- P[dead, 2] }
    files[fr] <- file.path(outdir, sprintf("s_%03d.png", fr))
    ragg::agg_png(files[fr], width = width, height = height); par(mar = c(0.3, 0.3, 2.2, 0.3))
    plot.new(); plot.window(xlim = c(e[["xmin"]], e[["xmax"]]), ylim = c(e[["ymin"]], e[["ymax"]]), asp = asp, xaxs = "i", yaxs = "i")
    rasterImage(bg, e[["xmin"]], e[["ymin"]], e[["xmax"]], e[["ymax"]], interpolate = TRUE)
    lines(cx, cy, col = "grey55", lwd = 0.7)
    for (k in seq_along(cl)) lines(cl[[k]]$x, cl[[k]]$y, col = "grey30", lwd = 0.7)
    for (j in 1:(trail - 1)) segments(hx[, j + 1], hy[, j + 1], hx[, j], hy[, j],
                                       col = adjustcolor("#1f4e79", alpha.f = alphas[j]), lwd = 1.7 - j * 0.12)
    if (!is.null(highs)) text(highs$lon, highs$lat, "H", col = "#1f4e79", cex = 2, font = 2)
    if (!is.null(lows)) text(lows$lon, lows$lat, "L", col = "#8b1e1e", cex = 2, font = 2)
    mtext("Air carried by the 10 m wind: friction turns it across the isobars, spiraling into the lows. Blue shade: wind speed.",
          side = 3, adj = 0, line = 0.6, cex = 1.15)
    dev.off()
  }
  files
}
# s <- particles_10m("gfs_20261125_18z_wind.grb2", "particles_10m",
#        highs = data.frame(lon = c(-73.25, -111.25, -177.75), lat = c(44.75, 42.25, 39)),
#        lows  = data.frame(lon = c(-138.75, -144.6), lat = c(47.5, 57.75)))
