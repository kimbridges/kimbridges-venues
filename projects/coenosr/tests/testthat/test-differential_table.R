test_that("differential_table returns the grouped core", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  g <- form_groups(rel)
  d <- differential_table(g)
  expect_s3_class(d, "data.frame")
  expect_identical(names(d)[1:2], c("group", "species"))
  ## only grouped species, only relevés in some group
  n_grouped <- length(unlist(lapply(g, `[[`, "species")))
  expect_equal(nrow(d), n_grouped)
  in_group <- unique(unlist(lapply(g, `[[`, "releves")))
  expect_setequal(setdiff(names(d), c("group", "species")), in_group)
})

test_that("group labels are in sorted group order", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  d <- differential_table(form_groups(rel))
  ## labels look like 'Group N' and appear in contiguous, increasing blocks
  expect_true(all(grepl("^Group ", d$group)))
  expect_false(is.unsorted(match(d$group, unique(d$group))))
})

test_that("include = 'full' returns every species and relevé", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  d <- differential_table(form_groups(rel), include = "full")
  expect_equal(nrow(d), nlevels(rel$species))
  expect_equal(ncol(d) - 2L, nlevels(rel$releve))
  expect_true(all(c("companion", "rare") %in% d$group))
})

test_that("differential_table accepts a coenos_table directly", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  tab <- coenos_table(form_groups(rel))
  expect_identical(differential_table(tab), differential_table(form_groups(rel)))
})

test_that("differential_table rejects bad input", {
  expect_error(differential_table(data.frame(a = 1)), "coenos_table")
})

test_that("coenos_gt builds a gt table when gt is available", {
  skip_if_not_installed("gt")
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  g <- coenos_gt(form_groups(rel), title = "Dieren")
  expect_s3_class(g, "gt_tbl")
})
