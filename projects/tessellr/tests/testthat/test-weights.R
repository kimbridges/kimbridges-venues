square <- sf::st_as_sfc(sf::st_bbox(c(xmin = 0, ymin = 0, xmax = 4000, ymax = 4000), crs = sf::st_crs(32605)))
two <- function(w, x = c(1000, 3000)) sf::st_as_sf(data.frame(name = c("a", "b"), x = x, y = c(2000, 2000), w = w),
                                                    coords = c("x", "y"), crs = 32605)

test_that("equal weights split the frame at the halfway line", {
  a <- weighted_areas(two(c(1, 1)), "w", square, cell = 50)
  expect_equal(nrow(a), 2)
  expect_equal(a$area_km2, c(8, 8), tolerance = 0.01)
  expect_equal(sum(a$area_km2), 16, tolerance = 1e-6)
})

test_that("a weaker site gets a circle of the size geometry predicts", {
  ## weights 2 and 1, sites 1 km apart: the weaker site's area is a disk (inside the frame)
  a <- weighted_areas(two(c(2, 1), x = c(500, 1500)), "w", square, cell = 20)
  d <- 1000; w1 <- 2; w2 <- 1
  radius <- (w1 * w2 * d) / (w1^2 - w2^2)
  expect_equal(a$area_km2[a$name == "b"], pi * radius^2 / 1e6, tolerance = 0.03)
  expect_gt(a$area_km2[a$name == "a"], a$area_km2[a$name == "b"])
})

test_that("weights can be given as numbers, and must be positive", {
  a <- weighted_areas(two(c(1, 1)), c(3, 1), square, cell = 100)
  expect_equal(a$weight, c(3, 1))
  expect_error(weighted_areas(two(c(1, 1)), c(1, 0), square), "positive")
})

test_that("the Chapter 7 gardens are reproduced (local data only)", {
  d <- "G:/My Drive/Projects/Voronoi/data"
  skip_on_cran()
  skip_if_not(file.exists(file.path(d, "la_gardens.csv")))
  gardens <- utils::read.csv(file.path(d, "la_gardens.csv"), encoding = "UTF-8")
  sites <- sf::st_transform(sf::st_as_sf(gardens, coords = c("longitude", "latitude"), crs = 4326), 32611)
  land <- sf::st_transform(sf::st_read(file.path(d, "la_land_frame.geojson"), quiet = TRUE), 32611)
  tracts <- utils::read.csv(file.path(d, "la_tracts_2020.csv"))
  tp <- sf::st_transform(sf::st_as_sf(tracts, coords = c("longitude", "latitude"), crs = 4326), 32611)
  people <- function(areas) {
    j <- sf::st_join(tp, areas["garden"])
    tapply(j$population, factor(j$garden, levels = gardens$garden), sum, na.rm = TRUE)
  }
  plain <- people(weighted_areas(sites, 1, land))
  size  <- people(weighted_areas(sites, "acres", land))
  ## the document's numbers, from assigning each tract directly (the grid adds a little edge noise)
  expect_equal(as.numeric(plain), c(1107462, 3332960, 2098389, 4066748, 3163537), tolerance = 0.03)
  expect_equal(as.numeric(size),  c(4067252, 4719821, 1541175, 1812094, 1628754), tolerance = 0.03)
})
