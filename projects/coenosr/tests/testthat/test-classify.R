# classify_species() must reproduce the constancy classes COENOS recorded.
# The oracle role codes map to status as: -3 -> rare, -2 -> ubiquitous,
# everything else (a group id, or -1 companion) -> eligible.

oracle_status <- function(csv) {
  o <- utils::read.csv(system.file("extdata", csv, package = "coenosr"),
                       stringsAsFactors = FALSE)
  o$status <- ifelse(o$role_code == -3, "rare",
              ifelse(o$role_code == -2, "ubiquitous", "eligible"))
  stats::setNames(o$status, trimws(o$species))
}

check_status <- function(rel_file, csv, ceiling) {
  rel <- read_rel(system.file("extdata", rel_file, package = "coenosr"))
  cl  <- classify_species(rel)
  expect_identical(attr(cl, "ceiling"), ceiling)

  got <- stats::setNames(as.character(cl$status), trimws(as.character(cl$species)))
  exp <- oracle_status(csv)
  expect_setequal(names(got), names(exp))
  expect_equal(got[names(exp)], exp[names(exp)], ignore_attr = TRUE)
}

test_that("classify_species reproduces the DIEREN constancy classes", {
  check_status("DIEREN.REL", "dieren_s00_species.csv", ceiling = 12L)  # floor(2*18/3)
})

test_that("classify_species reproduces the ELLEN constancy classes", {
  check_status("ELLEN.REL", "ellen_s00_species.csv", ceiling = 16L)    # floor(2*25/3)
})

test_that("the ceiling is the integer floor(2n/3), not a rounded percentage", {
  # ELLEN: n = 25, floor(2*25/3) = 16, so a species in 16/25 (64%) is ubiquitous
  rel <- read_rel(system.file("extdata", "ELLEN.REL", package = "coenosr"))
  cl  <- classify_species(rel)
  expect_identical(cl$status[trimws(as.character(cl$species)) == "HELIPUBE"],
                   factor("ubiquitous", levels = c("eligible", "ubiquitous", "rare")))
  # a species in 15/25 (60%) is still eligible
  expect_identical(cl$status[trimws(as.character(cl$species)) == "CREPBIEN"],
                   factor("eligible", levels = c("eligible", "ubiquitous", "rare")))
})
