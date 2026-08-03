# read_lists() (ragged form) and read_2way() (wide form) must land in the same
# coenos_rel and agree with each other on the bundled 15-species x 10-site data.

test_that("read_lists reads the ragged form", {
  rel <- read_lists(system.file("extdata", "simple_10x15_simplified.txt",
                                package = "coenosr"))
  expect_s3_class(rel, "coenos_rel")
  expect_identical(nlevels(rel$releve), 10L)
  expect_identical(nlevels(rel$species), 15L)
  expect_identical(nrow(rel), 69L)
})

test_that("read_2way reads the wide form and agrees with read_lists", {
  rl <- read_lists(system.file("extdata", "simple_10x15_simplified.txt",
                               package = "coenosr"))
  rt <- read_2way(system.file("extdata", "simple_10x15_input.txt",
                              package = "coenosr"))
  expect_s3_class(rt, "coenos_rel")
  expect_identical(nlevels(rt$releve), 10L)
  expect_identical(nlevels(rt$species), 15L)
  key <- function(x) sort(paste(x$releve, x$species))
  expect_identical(key(rt), key(rl))          # same presences
})

test_that("read_lists auto-detects cover values", {
  rc <- read_lists(system.file("extdata", "simple_10x15_cover.txt",
                               package = "coenosr"))
  rl <- read_lists(system.file("extdata", "simple_10x15_simplified.txt",
                               package = "coenosr"))
  key <- function(x) sort(paste(x$releve, x$species))
  expect_identical(key(rc), key(rl))          # same presences as the P/A version
  expect_true(all(rc$cover %in% c("+", "1", "2", "3", "4", "5")))
  expect_true(any(rc$cover %in% c("+", "2", "3", "4", "5")))  # not all the default
})

test_that("read_lists parses presence, covers, and multi-word names", {
  tmp <- tempfile(fileext = ".txt"); on.exit(unlink(tmp))
  writeLines(c("siteA, G, L 3, Carex lyngbyei 5, Bare name",
               "siteB, G 2, L"), tmp)
  s <- read_lists(tmp)
  expect_identical(s$cover[s$releve == "siteA" & s$species == "G"], "1")   # presence default
  expect_identical(s$cover[s$releve == "siteA" & s$species == "L"], "3")   # cover detected
  expect_identical(s$cover[s$releve == "siteA" & s$species == "Carex lyngbyei"], "5")
  expect_true("Bare name" %in% levels(s$species))                          # multi-word, no cover
  expect_identical(s$cover[s$releve == "siteA" & s$species == "Bare name"], "1")
})

test_that("read_2way handles transpose", {
  tmp <- tempfile(fileext = ".csv"); on.exit(unlink(tmp))
  writeLines(c("site,Aa,Bb,Cc", "s1,1,0,1", "s2,0,1,0"), tmp)  # sites in rows
  s <- read_2way(tmp, transpose = TRUE)
  expect_setequal(levels(s$releve), c("s1", "s2"))
  expect_setequal(levels(s$species), c("Aa", "Bb", "Cc"))
  expect_identical(nrow(s), 3L)                                # s1: Aa,Cc ; s2: Bb
})

test_that("the input readers error on a missing file", {
  expect_error(read_lists(tempfile(fileext = ".txt")), "File not found")
  expect_error(read_2way(tempfile(fileext = ".csv")),  "File not found")
})
