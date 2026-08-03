test_that("coenos_table returns a sorted wide table", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  tab <- coenos_table(form_groups(rel))
  expect_s3_class(tab, "coenos_table")
  expect_equal(nrow(tab), nlevels(rel$species))
  expect_equal(ncol(tab) - 1L, nlevels(rel$releve))
  expect_identical(names(tab)[1], "species")
})

test_that("every species and relevé appears exactly once", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  tab <- coenos_table(form_groups(rel))
  expect_setequal(tab$species, levels(rel$species))
  expect_setequal(names(tab)[-1], levels(rel$releve))
})

test_that("the block label covers every species row", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  tab <- coenos_table(form_groups(rel))
  expect_equal(length(attr(tab, "block")), nrow(tab))
  expect_true(all(c("companion", "rare") %in% attr(tab, "block")))
})

test_that("signature-less relevés are placed last", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  g <- form_groups(rel)
  tab <- coenos_table(g)
  in_group <- unique(unlist(lapply(g, `[[`, "releves")))
  ord <- attr(tab, "releve_order")
  empties <- setdiff(levels(rel$releve), in_group)
  if (length(empties) > 0) {
    tail_n <- utils::tail(ord, length(empties))
    expect_setequal(tail_n, empties)
  }
})

test_that("presence mode marks cells with x", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  tab <- coenos_table(form_groups(rel), cover = FALSE)
  vals <- unique(unlist(tab[-1]))
  expect_setequal(vals, c("x", ""))
})

test_that("reflect reverses the relevé order relative to default", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  g <- form_groups(rel)
  a <- attr(coenos_table(g, reflect = FALSE), "releve_order")
  b <- attr(coenos_table(g, reflect = TRUE), "releve_order")
  expect_false(identical(a, b))
})

test_that("coenos_table rejects non-coenos_groups input", {
  expect_error(coenos_table(list()), "coenos_groups")
})
