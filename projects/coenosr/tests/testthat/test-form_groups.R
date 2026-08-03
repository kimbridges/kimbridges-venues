test_that("form_groups returns a coenos_groups object", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  g <- form_groups(rel)
  expect_s3_class(g, "coenos_groups")
  expect_gt(length(g), 0)
})

test_that("every group meets the size thresholds", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  g <- form_groups(rel, min_species = 4L, min_releves = 2L)
  for (grp in g) {
    expect_gte(length(grp$species), 4L)
    expect_gte(length(grp$releves), 2L)
  }
})

test_that("groups do not share species (blocks are eliminated)", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  g <- form_groups(rel)
  all_sp <- unlist(lapply(g, `[[`, "species"))
  expect_equal(length(all_sp), length(unique(all_sp)))
})

test_that("group species are eligible, never ubiquitous or rare", {
  rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  cl <- classify_species(rel)
  elig <- as.character(cl$species[cl$status == "eligible"])
  g <- form_groups(rel)
  expect_true(all(unlist(lapply(g, `[[`, "species")) %in% elig))
})

test_that("the masking search is deterministic", {
  rel <- read_rel(system.file("extdata", "ELLEN.REL", package = "coenosr"))
  expect_identical(form_groups(rel), form_groups(rel))
})

test_that("a strong, well-separated group is recovered exactly", {
  # SET1 oracle group 1 is a clean dense block; the engine reproduces it 4/4.
  rel <- read_rel(system.file("extdata", "SET1.DAT", package = "coenosr"))
  g <- form_groups(rel, x = 0.40, y = 0.10)
  target <- c("HEDITERM", "PISOUMBE", "POUTSAND", "SIDARHOM")
  hit <- vapply(g, function(grp) setequal(grp$species, target), logical(1))
  expect_true(any(hit))
})

test_that("the bundled toy dataset sorts into two clean five-species groups", {
  # the simple_10x15 demo is designed to give a clear two-community result
  rel <- read_lists(system.file("extdata", "simple_10x15_simplified.txt",
                                package = "coenosr"))
  g <- form_groups(rel)
  expect_length(g, 2)
  expect_true(all(vapply(g, function(z) length(z$species) == 5L, logical(1))))
})

test_that("form_groups rejects non-coenos_rel input", {
  expect_error(form_groups(data.frame(a = 1)), "coenos_rel")
})
