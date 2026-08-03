test_that("primary_collector handles the common formats", {
  expect_equal(primary_collector("Cuddihy, L.W."), "Cuddihy")
  expect_equal(primary_collector("Cuddihy, L.W.; State ESP team"), "Cuddihy")
  expect_equal(primary_collector("Cuddihy, L.W. Davis, J.; Anderson, S."), "Cuddihy")
  expect_equal(primary_collector("Joseph Rock"), "Rock")
  expect_equal(primary_collector("O. Degener"), "Degener")
  expect_equal(primary_collector("C. Van Riper"), "Van Riper")
  expect_equal(primary_collector("E. O. Guerrant, Jr."), "Guerrant")   # suffix, not surname
  expect_true(is.na(primary_collector(NA_character_)))
  expect_true(is.na(primary_collector("")))
})

test_that("add_primary_collector adds a collector column", {
  df <- data.frame(recordedBy = c("Rock, J.", "O. Degener"), stringsAsFactors = FALSE)
  out <- add_primary_collector(df)
  expect_equal(out$collector, c("Rock", "Degener"))
})
