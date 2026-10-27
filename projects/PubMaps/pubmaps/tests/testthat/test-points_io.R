# a small located table, as locate_places() would return it
fixture <- function() {
  p <- data.frame(
    name = c("Kiteghe", "Mt. Kasigau", "Taita Hills", "Voi"),
    role = c("study_site", "natural_feature", "natural_feature", "reference_town"),
    country = "Kenya", lon = c(38.6486, 38.655, NA, 38.556), lat = c(-3.7843, -3.83, NA, -3.396),
    coord_source = c("geonames", "nominatim", "none", "geonames"),
    match = c("partial", "exact", "none", "exact"), flag = "",
    gaz_name = c("Kitege", "Kasigau", NA, "Voi"), gaz_type = c("P:PPL", "T:MT", NA, "P:PPLA2"),
    gaz_id = NA_character_, gaz_lon = c(38.6486, 38.655, NA, 38.556), gaz_lat = c(-3.7843, -3.83, NA, -3.396),
    page = c(3L, 2L, 2L, 4L), evidence = "text", stringsAsFactors = FALSE)
  attr(p, "study") <- list(study_countries = list("Kenya"), study_area_summary = "Mt. Kasigau, Kenya.")
  p
}

test_that("points.csv round-trips, and editor columns are honoured", {
  d <- tempfile("pm_"); dir.create(d)
  p <- fixture()
  pubmaps:::write_points_csv(p, d)
  csv <- utils::read.csv(file.path(d, "points.csv"), stringsAsFactors = FALSE)
  expect_true(all(c("id", "include", "label", "label_pos", "label_lon", "label_lat", "lon", "lat") %in% names(csv)))
  csv$include[4] <- "name"
  csv$label_pos[2] <- "ne"
  csv$lon[3] <- 38.4; csv$lat[3] <- -3.4
  utils::write.csv(csv, file.path(d, "points.csv"), row.names = FALSE, na = "")
  r <- pubmaps:::read_points_csv(d)
  expect_equal(r$include[4], "name")
  expect_equal(r$label_pos[2], "NE")
  expect_equal(r$coord_source[3], "editor")
  expect_equal(r$match[3], "editor")
  expect_equal(r$lon[1], 38.6486)          # untouched rows keep their gazetteer position
  expect_equal(attr(r, "study")$study_area_summary, "Mt. Kasigau, Kenya.")
})

test_that("include and role decide what is drawn", {
  p <- fixture()
  p$include <- c("", "", "", "no")
  s <- pubmaps:::select_points(p)
  expect_true(s$drawn[1])
  expect_true(s$drawn[2])                  # a mountain is a point (T:MT)
  expect_equal(s$reason[3], "not located (context)")
  expect_equal(s$reason[4], "excluded by editor")
  p$include[4] <- "name"
  expect_equal(pubmaps:::select_points(p)$reason[4], "name only (no symbol)")
})

test_that("settings follow option, then environment variable, then default", {
  old <- options(pubmaps.review = NULL); on.exit(options(old))
  withenv <- Sys.getenv("PUBMAPS_REVIEW")
  Sys.setenv(PUBMAPS_REVIEW = "")
  expect_equal(pubmaps_review_dir(), "review")
  Sys.setenv(PUBMAPS_REVIEW = "C:/x")
  expect_equal(pubmaps_review_dir(), "C:/x")
  options(pubmaps.review = "C:/y")
  expect_equal(pubmaps_review_dir(), "C:/y")
  Sys.setenv(PUBMAPS_REVIEW = withenv)
})

test_that("a study with fieldwork points is framed by its points, not by areas", {
  s <- pubmaps:::select_points(fixture())
  expect_null(pubmaps:::area_frame(s))     # returns before any outline lookup
})

test_that("the symbol key describes exactly what was drawn", {
  layers <- list(roles = c(study_site = 5, reference_town = 1), parks = "Kerinci Seblat NP",
                 districts = c("Merangin", "Kerinci"), rivers = "Brahmaputra River",
                 states = TRUE, countries = "Indonesia")
  k <- pubmaps:::symbol_key(layers)
  expect_match(k, "^Orange circles, study sites; dark blue square, town;")
  expect_match(k, "pale green shading, Kerinci Seblat NP")
  expect_match(k, "district boundaries \\(Merangin and Kerinci\\)")
  expect_match(k, "blue line, Brahmaputra River")
  expect_match(k, "Inset: location of the map area \\(orange box\\) in Indonesia\\.$")
  one <- list(roles = c(study_site = 1), parks = character(), districts = character(),
              rivers = character(), states = FALSE, countries = "Kenya")
  expect_equal(pubmaps:::symbol_key(one, inset_small = TRUE),
               "Orange circle, study site. Inset: location of the map area (orange dot) in Kenya.")
})
