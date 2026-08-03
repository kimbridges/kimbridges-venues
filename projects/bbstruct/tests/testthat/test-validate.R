test_that("bb_validate rejects missing names", {
  x <- matrix(1, nrow = 2, ncol = 2)
  bb <- list(x = x, species = NULL, sites = NULL, meta = list())
  class(bb) <- "bb_tbl"
  expect_error(bb_validate(bb))
})

