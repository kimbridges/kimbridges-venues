test_that("names are normalised and reduced to their core", {
  expect_equal(pubmaps:::norm_name("Yucat\u00e1n"), "yucatan")
  expect_equal(pubmaps:::core_name("Mt. Kasigau"), "kasigau")
  expect_equal(pubmaps:::core_name("Jeldu District"), "jeldu")
  expect_equal(pubmaps:::core_name("Desa Pelompek"), "pelompek")
})

test_that("name similarity rewards exact and contained names", {
  expect_equal(pubmaps:::name_sim("Kasigau", "Mount Kasigau"), 1)
  expect_equal(pubmaps:::name_sim("Kerinci", "Kerinci Seblat"), 0.8)
  expect_gt(pubmaps:::name_sim("Kiteghe", "Kitege"), 0.75)
  expect_lt(pubmaps:::name_sim("Serampas", "Bangkok"), 0.5)
})

test_that("generic names are recognised", {
  expect_true(pubmaps:::is_generic_name("Ward no. 3"))
  expect_true(pubmaps:::is_generic_name("plot 12"))
  expect_true(pubmaps:::is_generic_name("396 B"))
  expect_true(pubmaps:::is_generic_name("national forest reserve"))
  expect_false(pubmaps:::is_generic_name("Kiteghe"))
})

test_that("haversine distance is right", {
  # one degree of latitude is about 111 km
  expect_equal(pubmaps:::haversine_km(0, 0, 0, 1), 111.19, tolerance = 0.01)
})

test_that("rivers are recognised and reduced to their core name", {
  p <- data.frame(name = c("Brahmaputra River", "Sungai Merangin", "Mt. Kasigau", "Rapti"),
                  role = "natural_feature",
                  gaz_type = c("waterway:river", NA, "T:MT", "H:STM"), stringsAsFactors = FALSE)
  expect_equal(pubmaps:::is_river(p), c(TRUE, TRUE, FALSE, TRUE))
  expect_equal(pubmaps:::river_core("Brahmaputra River"), "brahmaputra")
  expect_equal(pubmaps:::river_core("Sungai Merangin"), "merangin")
  # a tributary is not the river: only an exact core-name match counts
  expect_false(pubmaps:::river_core("Dhauli Ganga") == pubmaps:::river_core("Ganga"))
  expect_equal(pubmaps:::river_core("Alaknanda River"), pubmaps:::river_core("River Alaknanda"))
})

test_that("include = yes keeps a river a line, not a point", {
  p <- data.frame(name = "Brahmaputra River", role = "natural_feature", lon = 95.09, lat = 27.69,
                  match = "partial", flag = "", gaz_type = "waterway:river", include = "yes",
                  stringsAsFactors = FALSE)
  s <- pubmaps:::select_points(p)
  expect_false(s$drawn[1])
})
