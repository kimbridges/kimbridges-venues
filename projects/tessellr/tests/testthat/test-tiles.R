## the twelve Kipuka Puaulu points and their frame, as in the document
pts   <- sf::st_as_sf(kipuka_releves, coords = c("easting", "northing"), crs = 32605)
frame <- kipuka_frame()
tiles <- tile_points(pts, frame)

test_that("tile_points makes one tile per point, in order, filling the frame", {
  expect_s3_class(tiles, "sf")
  expect_equal(nrow(tiles), 12)
  expect_equal(tiles$releve, kipuka_releves$releve)
  expect_equal(sum(tiles$area_m2), as.numeric(sf::st_area(frame)), tolerance = 1e-6)
  ## every tile holds its own point
  inside <- sf::st_within(pts, tiles, sparse = FALSE)
  expect_true(all(diag(inside)))
})

test_that("tile_points refuses longitude/latitude and duplicate points", {
  expect_error(tile_points(sf::st_transform(pts, 4326)), "longitude and latitude")
  expect_error(tile_points(rbind(pts, pts[1, ]), frame), "share a location")
})

test_that("tile_points makes its own frame when none is given", {
  t2 <- tile_points(pts)
  expect_equal(nrow(t2), 12)
})

test_that("clip modes behave as in Chapter 3", {
  ## a boundary around the middle of the frame
  clip <- sf::st_buffer(sf::st_centroid(frame), 700)
  all_pts <- tile_points(pts, frame, clip = clip, clip_mode = "all")
  inside  <- tile_points(pts, frame, clip = clip, clip_mode = "inside")
  expect_equal(sum(all_pts$area_m2), as.numeric(sf::st_area(clip)), tolerance = 1e-6)
  expect_equal(sum(inside$area_m2), as.numeric(sf::st_area(clip)), tolerance = 1e-6)
  ## only points inside the boundary get tiles in "inside" mode
  n_in <- sum(lengths(sf::st_intersects(pts, clip)) > 0)
  expect_equal(nrow(inside), n_in)
  expect_gte(nrow(all_pts), n_in)
})

test_that("tile_measures matches the document: 10 of 12 tiles touch the frame", {
  m <- tile_measures(tiles, frame)
  expect_equal(nrow(m), 12)
  expect_equal(sum(m$edge), 10)
  expect_true(all(m$nearest_m <= m$farthest_m))
  expect_true(all(m$shared_pct <= 100 + 1e-9))
  expect_equal(sum(m$area_ha), as.numeric(sf::st_area(frame)) / 10000, tolerance = 1e-6)
})

test_that("merge_tiles matches the document: 12 tiles become 6 patches", {
  p <- merge_tiles(tiles, "vegetation")
  expect_equal(nrow(p), 6)
  expect_equal(sum(p$points), 12)
  expect_equal(sum(p$area_ha), as.numeric(sf::st_area(frame)) / 10000, tolerance = 1e-6)
})

test_that("boundary_bands matches the document: 15 boundaries", {
  b <- boundary_bands(tiles, "vegetation", frame)
  expect_equal(nrow(b$edges), 15)
  expect_true(all(b$edges$side_a != b$edges$side_b))
  expect_equal(b$edges$plus_minus_m, b$edges$spacing_m / 2)
  expect_equal(round(range(b$edges$plus_minus_m)), c(170, 629))
})

test_that("tile_pattern reads an even grid as more even than random", {
  g <- expand.grid(x = seq(256800, 259700, length.out = 12), y = seq(2150000, 2152400, length.out = 10))
  gp <- sf::st_as_sf(g, coords = c("x", "y"), crs = 32605)
  res <- tile_pattern(tile_points(gp, frame), frame, trials = 5, seed = 1)
  expect_equal(res$reading, "more even than random")
  expect_lt(res$cv, res$random_low)
})
