pts   <- sf::st_as_sf(kipuka_releves, coords = c("easting", "northing"), crs = 32605)
frame <- kipuka_frame()
tiles <- tile_points(pts, frame)

test_that("a record on a shared border is split between the two tiles", {
  ## the point halfway between R11 and R12 lies on the border of their tiles
  mid <- sf::st_centroid(sf::st_union(sf::st_geometry(pts)[c(11, 12)]))
  rec <- sf::st_sf(geometry = mid)
  ct <- count_in_tiles(tiles, rec, uncertainty = 30, allocation = "proportional", test = FALSE)
  expect_equal(sum(ct$records), 1, tolerance = 1e-6)
  expect_equal(ct$records[11], 0.5, tolerance = 0.02)
  expect_equal(ct$records[12], 0.5, tolerance = 0.02)
  ## the strict rule leaves it out instead
  ex <- count_in_tiles(tiles, rec, uncertainty = 30, test = FALSE)
  expect_equal(sum(ex$records), 0)
  expect_equal(sum(ex$excluded), 1)
})

test_that("records well inside a tile count whole under both rules", {
  rec <- pts[8, ]
  a <- count_in_tiles(tiles, rec, uncertainty = 10, allocation = "proportional", test = FALSE)
  b <- count_in_tiles(tiles, rec, uncertainty = 10, allocation = "exclude", test = FALSE)
  expect_equal(a$records, b$records, tolerance = 1e-6)
  expect_equal(a$records[8], 1, tolerance = 1e-6)
})

test_that("circles reaching past the frame lose the outside share", {
  ## a record near the frame's west edge, with an error that reaches past it
  rec <- sf::st_sf(geometry = sf::st_sfc(sf::st_point(c(256686.9, 2151200)), crs = 32605))
  ct <- count_in_tiles(tiles, rec, uncertainty = 100, allocation = "proportional", test = FALSE)
  expect_lt(sum(ct$records), 1)
  expect_equal(sum(ct$records) + sum(ct$excluded), 1, tolerance = 1e-6)
})

test_that("proportional counts on the Chapter 6 specimens stay between the two extremes", {
  f <- "G:/My Drive/Projects/Voronoi/data/kipuka_puaulu_specimens.csv"
  skip_on_cran()
  skip_if_not(file.exists(f))
  sp <- utils::read.csv(f, encoding = "UTF-8")
  sp <- sf::st_transform(sf::st_as_sf(sp, coords = c("longitude", "latitude"), crs = 4326), 32605)
  circle <- sf::st_buffer(sf::st_transform(sf::st_sfc(sf::st_point(c(-155.296, 19.437)), crs = 4326), 32605), 2000)
  count_frame <- sf::st_intersection(frame, circle)
  sp$error_m <- ifelse(sp$georeference == "rounded", 1000, 10)
  pr <- count_in_tiles(tiles, sp, frame = count_frame, uncertainty = "error_m", allocation = "proportional", test = FALSE)
  ## nothing is lost inside the frame except the parts of circles beyond it
  expect_equal(sum(pr$records) + sum(pr$excluded), 87, tolerance = 1e-6)
  ## R08 keeps only the share of the rounded circles that falls in it
  r08 <- pr$records[pr$releve == "R08"]
  expect_gt(r08, 0)
  expect_lt(r08, 17)
})
