# Voronoi document -- expert-map check at Kipuka Puaulu (2026-09-25)
# Requires the prototype objects (run prototype/canopy_voronoi_prototype_v1.R first):
#   chm5 (canopy height, 5 m, UTM 5N), cls (structure classes 1-4), rel (12 releves)
# Expert map: Mueller-Dombois & Fosberg 1974, sheets 12-13, digitised by expert_map/mdf_georef.py
#   and coded by expert_map/mdf_codes.py -> mdf1974_classes_ohd.asc (Old Hawaiian Datum lon/lat).
library(terra); library(sf); library(ggplot2); library(tidyterra); library(patchwork)
E <- "G:/My Drive/Projects/Voronoi/expert_map/"

mcls <- c("Kipuka forest", "Koa-ohia forest", "Ohia forest", "Ohia scrub / low forest",
          "Grass mix / savanna", "Open lava / ash", "Modified / other")
mdf <- rast(paste0(E, "mdf1974_classes_ohd.asc")); set.crs(mdf, "EPSG:4135")   # Old Hawaiian
reg <- rast(paste0(E, "mdf1974_regions_ohd.asc")); set.crs(reg, "EPSG:4135")
mdf_u <- project(mdf, chm5, method = "near")            # PROJ applies OHD -> WGS 84 (~285 m E, ~345 m S)
reg_u <- project(reg, chm5, method = "near")

xy <- xyFromCell(chm5, 1:ncell(chm5)); cv <- values(cls)[, 1]
mv <- values(mdf_u)[, 1]; mv[values(reg_u)[, 1] == 900003] <- NA   # Kipuka Ki: outline open in the scan, left uncoded
ok <- !is.na(mv)

nn_assign <- function(px, py, lab, pst, cv, xy, constrained) {
  best <- rep(Inf, nrow(xy)); out <- rep(NA_integer_, nrow(xy))
  for (i in seq_along(px)) {
    d <- (xy[, 1] - px[i])^2 + (xy[, 2] - py[i])^2
    if (constrained) d[cv != pst[i]] <- Inf
    w <- d < best; best[w] <- d[w]; out[w] <- lab[i]
  }
  out
}
agree <- function(p) mean(!is.na(p[ok]) & p[ok] == mv[ok])

# --- the 12 prototype releves, relabelled with the 1974 class at each point -------
rel$mdf <- extract(mdf_u, vect(rel))[, 2]; rc <- st_coordinates(rel)
pl12 <- nn_assign(rc[, 1], rc[, 2], rel$mdf, rel$cls, cv, xy, FALSE)
co12 <- nn_assign(rc[, 1], rc[, 2], rel$mdf, rel$cls, cv, xy, TRUE)
c(plain = agree(pl12), constrained = agree(co12))     # 2026-09-25: 0.446 / 0.555

# --- boundary agreement -------------------------------------------------------------
edge <- function(v) boundaries(setValues(rast(chm5), v), classes = TRUE, directions = 4)
dE <- distance(classify(edge(mv), cbind(0, NA)))
recall50 <- function(v) { dP <- distance(classify(edge(v), cbind(0, NA)))
  b <- values(edge(mv))[, 1] == 1; mean(values(dP)[, 1][b] <= 50, na.rm = TRUE) }
c(plain = recall50(pl12), constrained = recall50(co12))  # 0.17 / 0.70 of expert boundary within 50 m

# --- releve-number curve: 6..192 releves, 20 draws, random vs stratified ------------
set.seed(20260925); res <- list()
for (n in c(6, 12, 24, 48, 96, 192)) for (r in 1:20) for (design in c("random", "stratified")) {
  idx <- if (design == "random") sample(which(ok), n) else
    unlist(lapply(1:4, function(k) { w <- which(cv == k & ok); w[sample.int(length(w), ceiling(n / 4))] }))[1:n]
  px <- xy[idx, 1]; py <- xy[idx, 2]; lab <- mv[idx]; pst <- cv[idx]
  maj <- sapply(1:4, function(k) { l <- lab[pst == k]; if (length(l)) as.integer(names(which.max(table(l)))) else NA })
  res[[length(res) + 1]] <- data.frame(n = n, rep = r, design = design,
    plain = agree(nn_assign(px, py, lab, pst, cv, xy, FALSE)),
    constrained = agree(nn_assign(px, py, lab, pst, cv, xy, TRUE)),
    structure_only = agree(maj[cv]))
}
curve <- do.call(rbind, res)
aggregate(cbind(plain, constrained, structure_only) ~ n + design, curve, median)
# NOTE: the 2026-09-25 run used all cells (incl. the 1.4% uncoded Kipuka Ki box) and sampled from them;
# re-running this script excludes that box, so medians may differ in the second decimal.
