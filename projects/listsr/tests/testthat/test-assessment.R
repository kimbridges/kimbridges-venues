make_hc <- function() {
  hclust(dissimilarity(data_to_2way(fish_market), what = "site"), method = "average")
}

test_that("recruit_heights is ordered high to low and covers every site", {
  rh <- recruit_heights(make_hc())
  expect_equal(nrow(rh), nrow(fish_market))
  expect_equal(rh$recruit_height, sort(rh$recruit_height, decreasing = TRUE))
})

test_that("assessment_cut returns coherent groups", {
  hc <- make_hc()
  a  <- assessment_cut(hc)
  expect_s3_class(a, "assessment_cut")
  expect_equal(nrow(a$groups), nrow(fish_market))
  expect_equal(a$n_groups, length(unique(a$groups$group)))
})

test_that("the oddball line gives at least as many groups", {
  hc <- make_hc()
  expect_gte(assessment_cut(hc, oddball = TRUE)$n_groups,
             assessment_cut(hc)$n_groups)
})
