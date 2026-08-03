test_that("parse_cards splits self-describing text", {
  x <- parse_cards(c("Life Form: Tree", "Phenology: Flowering"))
  expect_equal(x[["Life Form"]], "Tree")
  expect_equal(x[["Phenology"]], "Flowering")
})
test_that("deg_to_compass maps bearings", {
  expect_equal(deg_to_compass(0), "N")
  expect_equal(deg_to_compass(90), "E")
  expect_equal(deg_to_compass(201), "SSW")
})
test_that("first_collector extracts the primary surname", {
  expect_equal(tolower(first_collector("Wood, K.R.")), "wood")
  expect_equal(tolower(first_collector("K. R. Wood, J. Lau & M. Wood")), "wood")
})
test_that("read_capture assembles a label + one log row (no derive)", {
  cap <- read_capture(c("Number: KWB 1", "Collectors: X", "Life Form: Tree"),
                      19.4, -155.3, "2026-01-01", derive = FALSE)
  expect_true(grepl("KWB 1", cap$label))
  expect_equal(nrow(cap$log_row), 1L)
})

test_that("assemble_record falls back to a collector-code identity card", {
  rec <- assemble_record(c("KWB: 1239", "Life Form: Tree"),
                         19.4, -155.3, derive = FALSE)
  expect_equal(rec$collection_number, "KWB 1239")
  expect_equal(rec$collectors, "KWB")
  expect_false("KWB" %in% names(rec$observed))
})

test_that("make_log_row is one row and keeps observed field names verbatim", {
  cap <- read_capture(c("Number: KWB 2", "Collectors: Y", "Life Form: Shrub"),
                      19.4, -155.3, "2026-01-02", derive = FALSE)
  lr <- cap$log_row
  expect_equal(nrow(lr), 1L)
  expect_true("Life Form" %in% names(lr))
  expect_equal(lr[["Life Form"]], "Shrub")
})

test_that("discover_decks clusters supplied records with no network", {
  mk <- function(name, n, hab, repro) data.frame(
    recordedBy            = rep(name, n),
    habitat               = if (hab) "wet forest with dominant ohia" else NA_character_,
    reproductiveCondition = if (repro) "flowering" else NA_character_,
    stringsAsFactors = FALSE)
  d <- rbind(mk("Alpha, A.",   12, TRUE,  TRUE),
             mk("Bravo, B.",   12, TRUE,  FALSE),
             mk("Charlie, C.", 12, FALSE, TRUE),
             mk("Delta, D.",   12, FALSE, FALSE))
  res <- discover_decks(data = d, k = 4, min_records = 10, plot = FALSE)
  expect_equal(res$n, 48L)
  expect_equal(nrow(res$signatures), 4L)
  expect_equal(length(res$profiles), 4L)
})

test_that("make_qr_cards writes a non-empty PDF", {
  csv <- tempfile(fileext = ".csv")
  pdf <- tempfile(fileext = ".pdf")
  utils::write.csv(data.frame(
    copies = c(1, 1),
    header = c("Tree", "Flowering"),
    footer = c("Life Form", "Phenology"),
    text   = c("Life Form: Tree", "Phenology: Flowering"),
    stringsAsFactors = FALSE), csv, row.names = FALSE)
  make_qr_cards(csv, pdf)
  expect_true(file.exists(pdf))
  expect_gt(file.info(pdf)$size, 0)
})

# --- sheet geometry ----------------------------------------------------------
test_that("avery_5371 closes exactly on a US Letter page", {
  g <- avery_5371
  expect_equal(g$margin_left * 2 + g$card_w * g$n_col, g$page_w)
  expect_equal(g$margin_top  * 2 + g$card_h * g$n_row, g$page_h)
})

test_that("card_centre puts cards at true Avery positions, not page thirds", {
  g <- avery_5371
  # column centres are 2.5 and 6.0 in from the left; the old full-page layout
  # put them at 2.125 and 6.375, which is the 0.375in bug this replaced.
  expect_equal(vouchr:::card_centre(1, 1, g)$x, 2.5)
  expect_equal(vouchr:::card_centre(1, 2, g)$x, 6.0)
  # y is measured from the bottom: row 1 centre is 1.5in from the top.
  expect_equal(vouchr:::card_centre(1, 1, g)$y, g$page_h - 1.5)
  expect_equal(vouchr:::card_centre(5, 1, g)$y, g$page_h - 9.5)
})

test_that("the clear zone keeps content off the binding band", {
  z <- vouchr:::clear_zone(3.5, 1.5, 0.12)
  expect_equal(z$w, 1.88)
  expect_equal(z$cx, 2.44)
  # a 1.135in QR centred in that zone clears the 1.5in band
  expect_gt(z$cx - 1.135 / 2, 1.5)
  expect_error(vouchr:::clear_zone(3.5, 3.5, 0.12), "no room")
})

test_that("check_template rejects bad geometry", {
  expect_true(vouchr:::check_template(avery_5371))
  # overruns the sheet
  expect_error(vouchr:::check_template(
    utils::modifyList(avery_5371, list(margin_left = 2))), "too wide")
  # fits the sheet but the cards overlap each other -- invisible to an extent
  # check, since 0.75 + 3.5 + 4 = 8.25 is still under 8.5
  expect_error(vouchr:::check_template(
    utils::modifyList(avery_5371, list(card_w = 4))), "overlap")
  expect_error(vouchr:::check_template(
    utils::modifyList(avery_5371, list(card_h = 2.5))), "overlap")
})

# --- QR structural validation ------------------------------------------------
test_that("check_qr_matrix accepts a real code and rejects a plausible fake", {
  # a real code, straight from the engine
  expect_null(vouchr:::check_qr_matrix(qrcode::qr_code("Number: KWB 1", ecl = "H")))

  # the failure that motivated this: random fill with ONE decorative finder.
  # It looks like a QR to the eye and photographs convincingly.
  set.seed(1)
  fake <- matrix(sample(c(TRUE, FALSE), 33 * 33, replace = TRUE), 33, 33)
  fake[1:7, 1:7] <- TRUE; fake[2:6, 2:6] <- FALSE; fake[3:5, 3:5] <- TRUE
  expect_match(vouchr:::check_qr_matrix(fake), "finder pattern")

  # a legal QR size is not enough on its own
  expect_match(vouchr:::check_qr_matrix(matrix(FALSE, 24, 24)), "21, 25, 29")
})

test_that("validate_qr_engine passes with the real qrcode package", {
  expect_true(validate_qr_engine())
})

# --- number cards and the sequence ledger ------------------------------------
test_that("make_number_cards writes a PDF and records the run", {
  pdf <- tempfile(fileext = ".pdf")
  led <- tempfile(fileext = ".csv")
  res <- make_number_cards(pdf, prefix = "KWB", start = 1, n = 3, ledger = led)
  expect_equal(res$numbers, 1:3)
  expect_equal(res$codes, c("KWB 1", "KWB 2", "KWB 3"))
  expect_gt(file.info(pdf)$size, 0)
  expect_equal(nrow(vouchr:::read_ledger(led)), 3L)
})

test_that("the ledger refuses to reissue a collection number", {
  led <- tempfile(fileext = ".csv")
  make_number_cards(tempfile(fileext = ".pdf"), start = 10, n = 5, ledger = led)
  expect_error(
    make_number_cards(tempfile(fileext = ".pdf"), start = 12, n = 5, ledger = led),
    "already issued")
  # an explicit reprint is allowed, but warns
  expect_warning(
    make_number_cards(tempfile(fileext = ".pdf"), start = 12, n = 2,
                      ledger = led, allow_reprint = TRUE),
    "REPRINTING")
})

test_that("pad_digits zero-pads the printed number", {
  led <- tempfile(fileext = ".csv")
  res <- make_number_cards(tempfile(fileext = ".pdf"), start = 7, n = 1,
                           pad_digits = 5, ledger = led)
  expect_equal(res$codes, "KWB 00007")
})

# --- identity fields ---------------------------------------------------------
test_that("the collector is read from any spelling a deck may carry", {
  for (v in c("Collectors: A B", "Collector: A B", "Collected by: A B")) {
    rec <- assemble_record(c("Number: KWB 1", v), 19.4, -155.3, derive = FALSE)
    expect_equal(rec$collectors, "A B")
    expect_length(rec$observed, 0L)
  }
})

test_that("determined_by is first-class, not an observation", {
  rec <- assemble_record(c("Number: KWB 1", "Determined by: K W Bridges",
                           "Life Form: Tree"), 19.4, -155.3, derive = FALSE)
  expect_equal(rec$determined_by, "K W Bridges")
  expect_equal(names(rec$observed), "Life Form")
  expect_match(make_label(rec), "Det\\.: K W Bridges")
  expect_equal(make_log_row(rec)$determined_by, "K W Bridges")
})

test_that("the label omits the Det. line when no determiner card is present", {
  rec <- assemble_record(c("Number: KWB 1", "Life Form: Tree"),
                         19.4, -155.3, derive = FALSE)
  expect_true(is.na(rec$determined_by))
  expect_false(grepl("Det\\.:", make_label(rec)))
})

test_that("the example deck ships and has the documented columns", {
  f <- system.file("extdata", "QR_field_notes.csv", package = "vouchr")
  skip_if(f == "", "example deck not installed")
  d <- utils::read.csv(f, stringsAsFactors = FALSE)
  expect_true(all(c("copies", "header", "footer", "text") %in% names(d)))
  expect_true(all(grepl(":", d$text)))
})
