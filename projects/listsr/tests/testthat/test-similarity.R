test_that("Jaccard dissimilarity is 0 for identical lists and lies in [0,1]", {
  tw <- data_to_2way(read_lists("S1, a, b\nS2, a, b\nS3, c, d"))
  m  <- as.matrix(dissimilarity(tw, what = "site"))
  expect_equal(unname(m["S1", "S2"]), 0)        # identical lists
  expect_equal(unname(m["S1", "S3"]), 1)        # nothing in common
  expect_true(all(m >= 0 & m <= 1))
})
