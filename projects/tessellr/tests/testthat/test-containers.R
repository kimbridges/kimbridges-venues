pts   <- sf::st_as_sf(kipuka_releves, coords = c("easting", "northing"), crs = 32605)
frame <- kipuka_frame()
tiles <- tile_points(pts, frame)

test_that("counts add up and expected counts follow area", {
  set.seed(42)
  recs <- sf::st_sf(geometry = sf::st_sample(frame, 200))
  ct <- count_in_tiles(tiles, recs)
  expect_equal(sum(ct$records), 200)
  expect_equal(sum(ct$expected), 200, tolerance = 1e-9)
  expect_equal(ct$expected / 200, ct$area_ha / sum(ct$area_ha), tolerance = 1e-9)
  expect_true(all(ct$direction %in% c("elevated", "depleted", "as expected")))
  expect_s3_class(attr(ct, "chisq"), "htest")
})

test_that("a pile-up in one tile is flagged as elevated", {
  set.seed(7)
  spread <- sf::st_sf(geometry = sf::st_sample(frame, 60))
  target <- sf::st_buffer(sf::st_centroid(sf::st_geometry(tiles)[11]), 50)
  pile   <- sf::st_sf(geometry = sf::st_sample(target, 40))
  ct <- count_in_tiles(tiles, rbind(spread, pile))
  expect_equal(ct$direction[11], "elevated")
})

test_that("uncertain locations are excluded, not piled up", {
  ## one record at a point's own location: sure with a small error, excluded with a huge one
  one <- pts[8, ]
  expect_equal(count_in_tiles(tiles, one, uncertainty = 10, test = FALSE)$records[8], 1)
  big <- count_in_tiles(tiles, one, uncertainty = 5000, test = FALSE)
  expect_equal(big$records[8], 0)
  expect_equal(big$excluded[8], 1)
})

test_that("counting by category merges tiles first", {
  set.seed(3)
  recs <- sf::st_sf(geometry = sf::st_sample(frame, 100))
  ct <- count_in_tiles(tiles, recs, by = "vegetation", test = FALSE)
  expect_equal(nrow(ct), length(unique(kipuka_releves$vegetation)))
  expect_equal(sum(ct$records), 100)
})

test_that("the frame cuts tiles and records", {
  half <- sf::st_as_sfc(sf::st_bbox(c(xmin = 256666.9, ymin = 2149895.3, xmax = 258266.9, ymax = 2152495.3),
                                    crs = sf::st_crs(32605)))
  set.seed(5)
  recs <- sf::st_sf(geometry = sf::st_sample(frame, 100))
  ct <- count_in_tiles(tiles, recs, frame = half, test = FALSE)
  expect_equal(sum(ct$area_ha), as.numeric(sf::st_area(half)) / 10000, tolerance = 1e-6)
  expect_equal(sum(ct$records), sum(lengths(sf::st_intersects(recs, half)) > 0))
})

test_that("the Chapter 6 herbarium counts are reproduced (local data only)", {
  f <- "G:/My Drive/Projects/Voronoi/data/kipuka_puaulu_specimens.csv"
  skip_on_cran()
  skip_if_not(file.exists(f))
  sp <- utils::read.csv(f, encoding = "UTF-8")
  sp <- sf::st_transform(sf::st_as_sf(sp, coords = c("longitude", "latitude"), crs = 4326), 32605)
  circle <- sf::st_buffer(sf::st_transform(sf::st_sfc(sf::st_point(c(-155.296, 19.437)), crs = 4326), 32605), 2000)
  count_frame <- sf::st_intersection(frame, circle)
  all_ct <- count_in_tiles(tiles, sp, frame = count_frame, test = FALSE)
  expect_equal(sum(all_ct$records), 87)
  expect_equal(all_ct$records[all_ct$releve == "R08"], 17)
  ## rounded coordinates (about 1 km) no longer pile up in R08
  sp$error_m <- ifelse(sp$georeference == "rounded", 1000, 5)
  ## (a stack of ten precise specimens sits 8 m from a tile border, so a 10 m error would exclude them too)
  sure_ct <- count_in_tiles(tiles, sp, frame = count_frame, uncertainty = "error_m", test = FALSE)
  expect_equal(sure_ct$records[sure_ct$releve == "R08"], 0)
  expect_equal(sum(sure_ct$excluded), 25)
})
