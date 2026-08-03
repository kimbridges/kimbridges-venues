# Validation of read_rel() against the decoded COENOS ground-truth oracles.
# The oracle CSVs carry each species' constancy exactly as the original 1991
# program recorded it in its .S00 restart files, so an exact match of parsed
# constancy is a strong correctness check on the reader.

oracle_constancy <- function(csv) {
  o <- utils::read.csv(system.file("extdata", csv, package = "coenosr"),
                       stringsAsFactors = FALSE)
  stats::setNames(o$constancy, trimws(o$species))
}

check_against_oracle <- function(rel_file, csv, n_releve, n_species) {
  rel <- read_rel(system.file("extdata", rel_file, package = "coenosr"))
  expect_s3_class(rel, "coenos_rel")
  expect_identical(nlevels(rel$releve), n_releve)
  expect_identical(nlevels(rel$species), n_species)

  got <- constancy(rel)
  got_v <- stats::setNames(got$constancy, trimws(got$species))
  exp_v <- oracle_constancy(csv)

  # same species set, same constancy for every species
  expect_setequal(names(got_v), names(exp_v))
  expect_equal(got_v[names(exp_v)], exp_v[names(exp_v)], ignore_attr = TRUE)

  # total occurrences equal the sum of constancies
  expect_identical(nrow(rel), sum(exp_v))
}

test_that("read_rel reproduces the DIEREN ground truth", {
  check_against_oracle("DIEREN.REL", "dieren_s00_species.csv",
                       n_releve = 18L, n_species = 116L)
})

test_that("read_rel reproduces the ELLEN ground truth", {
  check_against_oracle("ELLEN.REL", "ellen_s00_species.csv",
                       n_releve = 25L, n_species = 93L)
})

test_that("read_rel reads SET1.DAT (CRLF line endings, numeric cover scale)", {
  check_against_oracle("SET1.DAT", "set1_s00_species.csv",
                       n_releve = 63L, n_species = 43L)
  # SET1 uses a numeric cover scale (1-7); confirm a high numeric cover survives
  s <- read_rel(system.file("extdata", "SET1.DAT", package = "coenosr"))
  expect_true(any(s$cover %in% as.character(4:7)))
})

test_that("specific cover values are read correctly", {
  d <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
  expect_identical(d$cover[d$releve == "BILL01" & d$species == "CARELYNG"], "5")
  expect_identical(d$cover[d$releve == "BILL04" & d$species == "POTEPACI"], "3")
  # the symbolic '+' and 'R' covers survive verbatim
  expect_true("+" %in% d$cover)
  expect_true("R" %in% d$cover)
})

test_that("parsing rules hold on a synthetic file", {
  tmp <- tempfile(fileext = ".rel")
  on.exit(unlink(tmp))
  writeLines(c(
    "PLOT_A",
    "CARE LYNG 5",
    "ELEO PALU 2",
    "CARE LYNG 1",          # duplicate: last cover (1) must win
    "BARE NAME",            # no cover estimate: must be ignored
    "&& a comment line",    # comment: must be ignored
    "POA  PRAT +",          # three-letter genus -> key 'POA PRAT'
    "$",
    "longcode_PLOTB",       # only rightmost six chars kept -> '_PLOTB'
    "SCIR ACUT 3",
    "$", ""
  ), tmp)

  s <- read_rel(tmp)
  expect_setequal(levels(s$releve), c("PLOT_A", "_PLOTB"))
  expect_identical(s$cover[s$releve == "PLOT_A" & s$species == "CARELYNG"], "1")
  expect_false("BARENAME" %in% levels(s$species))
  expect_true("POA PRAT" %in% levels(s$species))
  expect_identical(sum(s$releve == "PLOT_A"), 3L)  # CARE, ELEO, POA
})

test_that("read_rel errors on a missing file", {
  expect_error(read_rel(tempfile(fileext = ".rel")), "File not found")
})
