# rivers_of_air.R -- does the wind flow along the contours? Aloft yes; at the surface it crosses toward the lows.
# S3 / trilogy catalog. Kim + Claude, 2026-11-25. Input: one GFS 0.25-degree analysis with UGRD/VGRD at 250 mb,
# 500 mb and 10 m above ground, HGT 500 mb and PRMSL (see the NOMADS filter in pressure_terrain.R; add UGRD, VGRD,
# lev_250_mb and lev_10_m_above_ground).
# Angle method: the contour (geostrophic) direction from the height or pressure gradient (ug = -dZ/dy, vg = dZ/dx,
# low on the left in the northern hemisphere); signed angle from it to the actual wind; + = turned toward low pressure.
library(terra)

roa_angles <- function(fld, u, v, minw, minlat = 22) {
  M <- function(x) as.matrix(x, wide = TRUE); lat <- yFromRow(fld, 1:nrow(fld))
  dy <- res(fld)[2] * 111320; dx <- dy * cos(lat * pi / 180); m <- M(fld); n <- ncol(m); k <- nrow(m)
  gx <- gy <- m * NA
  gx[, 2:(n - 1)] <- (m[, 3:n] - m[, 1:(n - 2)]) / (2 * dx); gy[2:(k - 1), ] <- (m[1:(k - 2), ] - m[3:k, ]) / (2 * dy)
  U <- M(u); V <- M(v); ug <- -gy; vg <- gx
  a <- atan2(ug * V - vg * U, ug * U + vg * V) * 180 / pi; latm <- matrix(lat, nrow(U), ncol(U))
  a[latm > minlat & sqrt(U^2 + V^2) > minw & !is.na(a)]
}

roa_arrows <- function(u, v, step = 12, k, col, lwd = 0.8, minw = 0) {
  xy <- crds(u); x0 <- xmin(u) + res(u)[1] / 2; y0 <- ymin(u) + res(u)[2] / 2
  sel <- which((round((xy[, 1] - x0) / res(u)[1]) %% step == 0) & (round((xy[, 2] - y0) / res(u)[2]) %% step == 0))
  U <- values(u)[sel, 1]; V <- values(v)[sel, 1]; p <- xy[sel, ]; ok <- sqrt(U^2 + V^2) > minw
  p <- p[ok, , drop = FALSE]; U <- U[ok]; V <- V[ok]; cl <- cos(p[, 2] * pi / 180)
  arrows(p[, 1], p[, 2], p[, 1] + U * k / cl, p[, 2] + V * k, length = 0.04, col = col, lwd = lwd)
}
# The four-panel figure (maps A and B, histograms C and D) was drawn with these two functions on
# gfs_20261125_18z_wind.grb2: aloft median |angle| 7 deg (87% within 20 deg); surface median +20 deg toward low pressure.
