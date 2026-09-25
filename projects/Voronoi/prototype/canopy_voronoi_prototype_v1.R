# Maps with Tiles -- prototype v1: Voronoi within canopy-structure class
# Kipuka Puaulu, 2026-09-25. Categories are STAND-INS for testing the method.
library(terra); library(sf); library(exifr)
library(ggplot2); library(tidyterra); library(patchwork)

# --- window: 3.2 x 2.6 km around the kipuka photo fixes (UTM 5N) ---------------
ph  <- list.files("G:/My Drive/Projects/specimen_labels", pattern = "\\.jpe?g$",
                  recursive = TRUE, full.names = TRUE, ignore.case = TRUE)
ph  <- ph[grepl("kipuka_puaulu", ph)]
ex  <- read_exif(ph, tags = c("GPSLatitude", "GPSLongitude"))
fix <- st_as_sf(data.frame(lon = ex$GPSLongitude, lat = ex$GPSLatitude),
                coords = c("lon", "lat"), crs = 4326)
cc  <- unname(st_coordinates(st_transform(st_centroid(st_union(fix[c(1:3, 5:7, 9), ])), 32605)))
xmn <- cc[1] - 1600; xmx <- cc[1] + 1600; ymn <- cc[2] - 1300; ymx <- cc[2] + 1300
win_poly <- st_as_sfc(st_bbox(c(xmin = xmn, ymin = ymn, xmax = xmx, ymax = ymx), crs = st_crs(32605)))

# --- canopy height: Meta/WRI 1 m, keyless via /vsicurl --------------------------
u <- "/vsicurl/https://dataforgood-fb-data.s3.amazonaws.com/forests/v1/alsgedi_global_v6_float/chm/022300033.tif"
chm1 <- crop(rast(u), ext(vect(st_transform(st_buffer(win_poly, 50), 3857))))
chm5 <- project(chm1, rast(ext(xmn, xmx, ymn, ymx), resolution = 5, crs = "EPSG:32605"),
                method = "average"); names(chm5) <- "height"

# --- structure classes: smooth 25 m, classify, merge patches < 0.25 ha ---------
sm  <- focal(chm5, w = matrix(1, 5, 5) / 25, na.rm = TRUE)
cls <- classify(sm, cbind(c(-Inf, 2, 5, 10), c(2, 5, 10, Inf), 1:4))
cls <- sieve(cls, threshold = 100, directions = 8)
cv  <- values(cls)[, 1]

# --- stand-in releves: 3 per structure class, >= 400 m apart, 150 m inset ------
set.seed(20260925)
cand <- as.data.frame(spatSample(crop(cls, ext(xmn + 150, xmx - 150, ymn + 150, ymx - 150)),
                                 4000, method = "random", xy = TRUE, na.rm = TRUE))
names(cand)[3] <- "cls"; cand$cls <- as.integer(cand$cls)
rs <- do.call(rbind, lapply(1:4, function(k) {
  ck <- cand[cand$cls == k, ]; ch <- ck[0, ]
  for (i in seq_len(nrow(ck))) {
    if (nrow(ch) == 3) break
    d <- if (nrow(ch)) sqrt((ch$x - ck$x[i])^2 + (ch$y - ck$y[i])^2) else Inf
    if (all(d > 400)) ch <- rbind(ch, ck[i, ])
  }
  ch
}))
rel <- st_as_sf(rs, coords = c("x", "y"), crs = 32605)
rel <- rel[order(rel$cls, -st_coordinates(rel)[, 2]), ]
rel$id <- sprintf("R%02d", seq_len(nrow(rel)))
cats <- c("Open lava / grass", "ʻŌhiʻa scrub", "ʻŌhiʻa woodland", "Forest A (kīpuka)", "Forest B (north)")
rel$category <- c(rep(cats[1], 3), rep(cats[2], 3), rep(cats[3], 3), cats[5], cats[4], cats[4])  # STAND-INS
rel$cat_id <- match(rel$category, cats)

# --- the two maps ----------------------------------------------------------------
Dm <- values(rast(lapply(seq_len(nrow(rel)), function(i) distance(chm5, vect(rel[i, ])))))
plain_i <- max.col(-Dm, ties.method = "first")
Dc <- Dm; Dc[outer(cv, rel$cls, "!=")] <- Inf          # only releves of the same structure class
con_i <- max.col(-Dc, ties.method = "first")
con_i[!is.finite(Dc[cbind(seq_along(con_i), con_i)])] <- NA   # class with no releve -> unassigned
plain  <- setValues(rast(chm5), rel$cat_id[plain_i])
constr <- setValues(rast(chm5), rel$cat_id[con_i])

# --- extended vs sampled: patches of a class that hold no releve ------------------
cls_i <- setValues(rast(chm5), cv); pid <- rast(chm5); pid[] <- NA; off <- 0
for (k in 1:4) {
  pk <- patches(ifel(cls_i == k, 1, NA), directions = 8)
  pid <- cover(pid, pk + off); off <- off + global(pk, "max", na.rm = TRUE)[1, 1]
}
sampled <- ifel(pid %in% unique(extract(pid, vect(rel))[, 2]), 1, 0)
# (figure code: see session; ggplot + tidyterra + patchwork, saved as prototype_v2.png)
