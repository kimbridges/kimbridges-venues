test_that("normalize_institution folds BPBM to BISH", {
  expect_equal(normalize_institution(c("BISH", "BPBM", "NY")), c("BISH", "BISH", "NY"))
})

test_that("clean_record_number extracts the core number", {
  expect_equal(clean_record_number("Collector Number: 561"), "561")
  expect_equal(clean_record_number("082"), "82")
  expect_true(is.na(clean_record_number("s.n.")))
  expect_true(is.na(clean_record_number(NA_character_)))
})

test_that("circle_wkt returns a closed polygon", {
  w <- circle_wkt(-155.296, 19.437, 2, n = 12)
  expect_true(startsWith(w, "POLYGON(("))
  expect_true(endsWith(w, "))"))
})

# a tiny fixture: one BISH/BPBM duplicate pair + one other record
fixture <- function(sp2 = "Aus bus") tibble::tibble(
  institutionCode = c("BISH", "BPBM", "NY"),
  catalogNumber   = c("100", "100", "200"),
  species         = c("Aus bus", sp2, "Xus yus"),
  recordedBy      = c("Rock, J.", "Rock, J.", "Smith, A."),
  collector       = c("Rock", "Rock", "Smith"),
  recordNumber    = c("5", "5", "9"),
  year            = c(1916, 1916, 1950),
  eventDate       = c("1916", "1916", "1950")
)

test_that("institution dedup collapses a BISH/BPBM pair", {
  out <- dedup_specimens(fixture(), "institution", verbose = FALSE)
  expect_equal(nrow(out), 2)                          # pair -> 1, plus the NY record
  expect_true("institution" %in% names(out))
  expect_equal(sort(out$institution), c("BISH", "NY"))
})

test_that("detect_det_conflicts finds same-sheet disagreements", {
  expect_equal(nrow(detect_det_conflicts(fixture("Aus bus"))), 0)   # pair agrees
  cf <- detect_det_conflicts(fixture("Aus cus"))                    # pair disagrees
  expect_equal(nrow(cf), 1)
  expect_equal(cf$catalogNumber, "100")
  expect_equal(cf$n_dets, 2)
})
