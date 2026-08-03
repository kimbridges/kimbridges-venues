test_that("bb_metrics returns expected fields", {
  x <- matrix(c(1,0, 0,1), nrow = 2)
  rownames(x) <- c("Sp1", "Sp2")
  colnames(x) <- c("S1", "S2")
  bb <- list(x = x, species = rownames(x), sites = colnames(x), meta = list())
  class(bb) <- "bb_tbl"

  met <- bb_metrics(bb)
  expect_true(is.list(met))
  expect_true(all(c("contrast", "adjacent_col_smoothness", "density_nonzero") %in% names(met)))
})
