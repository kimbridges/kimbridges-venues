voronoi_data <- "G:/My Drive/Projects/Voronoi/data"
pts <- sf::st_as_sf(kipuka_releves, coords = c("easting", "northing"), crs = 32605)

test_that("the quadkey for Kipuka Puaulu is the tile used in the document", {
  expect_equal(tessellr:::quadkey(-155.296, 19.437, 9), "022300033")
  keys <- tessellr:::quadkeys_for(kipuka_frame())
  expect_true("022300033" %in% keys)
})

test_that("structure_classes smooths, classifies and applies the mapping unit", {
  r <- terra::rast(nrows = 60, ncols = 60, xmin = 0, xmax = 300, ymin = 0, ymax = 300, crs = "EPSG:32605")
  xy <- terra::xyFromCell(r, seq_len(terra::ncell(r)))
  terra::values(r) <- ifelse(xy[, 1] < 150, 0.5, 12)
  ## a lone tall tree on the open side (the transition band, 4 cells wide, is smaller than 1 ha)
  r[terra::cellFromXY(r, cbind(50, 50))] <- 20
  cls <- structure_classes(r, smooth = 25, mmu_ha = 1)
  v <- terra::values(cls)[, 1]
  expect_setequal(unique(stats::na.omit(v)), c(1, 4))
  expect_equal(unname(terra::values(cls)[terra::cellFromXY(cls, cbind(50, 50)), 1]), 1)
  expect_equal(terra::cats(cls)[[1]][[2]], c("open", "low", "woodland", "forest"))
  expect_error(structure_classes(r, breaks = c(2, 5), labels = c("a", "b")), "one more")
})

test_that("trace_patch outlines a round stand and fills its glade", {
  r <- terra::rast(nrows = 100, ncols = 100, xmin = 0, xmax = 500, ymin = 0, ymax = 500, crs = "EPSG:32605")
  xy <- terra::xyFromCell(r, seq_len(terra::ncell(r)))
  d <- sqrt((xy[, 1] - 250)^2 + (xy[, 2] - 250)^2)
  terra::values(r) <- ifelse(d < 150 & d > 30, 15, 1)
  p <- trace_patch(r, c(350, 250))
  expect_equal(p$area_ha, pi * 150^2 / 10000, tolerance = 0.05)
  expect_error(trace_patch(r, c(10, 10)), "not in canopy")
})

test_that("constrained_voronoi keeps each label inside its own kind of canopy", {
  r <- terra::rast(nrows = 40, ncols = 40, xmin = 0, xmax = 400, ymin = 0, ymax = 400, crs = "EPSG:32605")
  xy <- terra::xyFromCell(r, seq_len(terra::ncell(r)))
  terra::values(r) <- ifelse(xy[, 2] > 200, 2, 1)
  p4 <- sf::st_as_sf(data.frame(x = c(100, 300, 100, 300), y = c(100, 100, 300, 300), veg = c("A", "B", "C", "D")),
                     coords = c("x", "y"), crs = 32605)
  ## a point in the lower half, near the class border
  p5 <- rbind(p4, sf::st_as_sf(data.frame(x = 200, y = 190, veg = "E"), coords = c("x", "y"), crs = 32605))
  con <- constrained_voronoi(p5, "veg", r, mmu_ha = 0)
  lab <- terra::extract(con$type, cbind(200, 215))[1, 1]
  ## the cell just above the border is nearest to E, but E is in the other class
  expect_false(as.character(lab) == "E")
  plain <- constrained_voronoi(p5, "veg", r, constrained = FALSE)
  expect_equal(as.character(terra::extract(plain$type, cbind(200, 215))[1, 1]), "E")
  expect_true(all(terra::values(plain$sampled) == 1))
})

test_that("the Chapter 8 kipuka outline and maps are reproduced (local data only)", {
  f <- file.path(voronoi_data, "kipuka_puaulu_canopy_height.tif")
  skip_on_cran()
  skip_if_not(file.exists(f))
  canopy <- terra::rast(f)
  ## the outline: 94.5 ha
  outline <- trace_patch(canopy, pts[11, ])
  expect_equal(round(outline$area_ha, 1), 94.5)
  ## the point classes: R06 joins the open lava at a 2 ha unit
  cls <- structure_classes(canopy)
  pc <- terra::extract(cls, terra::vect(pts), raw = TRUE, ID = FALSE)[, 1]
  expect_equal(pc, c(1, 1, 1, 2, 2, 1, 3, 3, 3, 4, 4, 4))
  ## plain and constrained maps disagree on about half the area
  plain <- constrained_voronoi(pts, "vegetation", cls, constrained = FALSE)
  con   <- constrained_voronoi(pts, "vegetation", cls)
  differ <- mean(terra::values(plain$type)[, 1] != terra::values(con$type)[, 1], na.rm = TRUE)
  expect_equal(round(100 * differ), 51)
  expect_equal(round(100 * mean(terra::values(con$sampled)[, 1] == 0)), 11)
})

test_that("get_canopy_height reads the Meta/WRI map for a frame (online)", {
  skip_on_cran()
  skip_if_offline()
  small <- sf::st_as_sfc(sf::st_bbox(c(xmin = 257801.9, ymin = 2151195.3, xmax = 258301.9, ymax = 2151595.3), crs = sf::st_crs(32605)))
  ch <- get_canopy_height(small)
  expect_s4_class(ch, "SpatRaster")
  expect_equal(terra::res(ch), c(5, 5))
  f <- file.path(voronoi_data, "kipuka_puaulu_canopy_height.tif")
  skip_if_not(file.exists(f))
  ref <- terra::crop(terra::rast(f), terra::ext(ch))
  expect_lt(max(abs(terra::values(ch)[, 1] - terra::values(ref)[, 1]), na.rm = TRUE), 0.2)
})
