grid <- terra::rast(nrows = 50, ncols = 50, xmin = 0, xmax = 500, ymin = 0, ymax = 500, crs = "EPSG:32605")
xy <- terra::xyFromCell(grid, seq_len(terra::ncell(grid)))

test_that("identical maps agree completely", {
  ref <- terra::setValues(grid, ifelse(xy[, 1] < 250, 1, 2))
  a <- map_agreement(ref, ref)
  expect_equal(a$area_agreement, 1)
  expect_equal(a$boundary_found, 1)
  expect_equal(a$boundary_on_reference, 1)
})

test_that("a shifted boundary is found only within the tolerance", {
  ref <- terra::setValues(grid, ifelse(xy[, 1] < 250, 1, 2))
  map <- terra::setValues(grid, ifelse(xy[, 1] < 330, 1, 2))
  expect_equal(map_agreement(map, ref, tolerance = 25)$boundary_found, 0)
  expect_equal(map_agreement(map, ref, tolerance = 100)$boundary_found, 1)
  expect_equal(map_agreement(map, ref)$area_agreement, 1 - (80 / 500), tolerance = 1e-9)
})

test_that("categorical maps are compared by label, not by number", {
  ref <- terra::setValues(grid, ifelse(xy[, 1] < 250, 1, 2))
  levels(ref) <- data.frame(id = 1:2, v = c("forest", "grass"))
  map <- terra::setValues(grid, ifelse(xy[, 1] < 250, 2, 1))
  levels(map) <- data.frame(id = 1:2, v = c("grass", "forest"))
  expect_equal(map_agreement(map, ref)$area_agreement, 1)
})

test_that("the Chapter 9 agreement numbers are reproduced (local data only)", {
  d <- "G:/My Drive/Projects/Voronoi/data"
  skip_on_cran()
  skip_if_not(file.exists(file.path(d, "mdf1974_classes.tif")))
  pts <- sf::st_as_sf(kipuka_releves, coords = c("easting", "northing"), crs = 32605)
  cls <- structure_classes(terra::rast(file.path(d, "kipuka_puaulu_canopy_height.tif")))
  mdf <- terra::rast(file.path(d, "mdf1974_classes.tif"))
  names_1974 <- utils::read.csv(file.path(d, "mdf1974_classes.csv"), encoding = "UTF-8")
  levels(mdf) <- data.frame(id = names_1974$class_id, vegetation = names_1974$vegetation)
  plain <- map_agreement(constrained_voronoi(pts, "vegetation", cls, constrained = FALSE)$type, mdf)
  con   <- map_agreement(constrained_voronoi(pts, "vegetation", cls)$type, mdf)
  expect_equal(round(100 * c(plain$area_agreement, plain$boundary_found)), c(45, 17))
  expect_equal(round(100 * c(con$area_agreement, con$boundary_found, con$boundary_on_reference)), c(56, 58, 54))
  expect_equal(round(c(con$map_boundary_km, con$reference_boundary_km)), c(107, 51))
})
