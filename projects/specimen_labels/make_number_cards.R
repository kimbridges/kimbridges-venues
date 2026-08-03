## ============================================================================
## make_number_cards.R  —  Collection-number (identity) cards for field capture
##
## The identity card is the key to the whole system: the collection number is
## the stand-in for the bagged specimen and the join between the pressed sheet
## and the photograph. design_notes.md calls it the graceful-degradation floor —
## "the non-negotiable minimum is the number card + the photo". It is the one
## card that must scan when nothing else gets photographed.
##
## Three design decisions follow from that, and from the project's own files:
##
## 1. NO BINDING BAND. design_notes.md: "Identity + free-text = business-card
##    holders. These you *detach* (a number card onto a specimen) ... so a loose
##    holder fits better than a bound stack." Nothing fans over these cards, so
##    the full card width is available — unlike the observation decks, which
##    reserve 1.5in for the screw post (see make_qr_cards.R).
##
## 2. NUMBER BESIDE THE QR, NOT ABOVE IT. On the observation decks the QR is
##    sized by the height of its middle band, so it comes out 1.14in square even
##    though the card is 3.5in wide. Setting the number alongside instead lets
##    the code use the FULL content height: 1.76in square, a 55 % larger code
##    and about 2.4x the area. That is scan distance and damage tolerance on the
##    card that can least afford to fail.
##
## 3. SELF-DESCRIBING PAYLOAD. reader_assembler.R parses every card uniformly as
##    "Field: value", identity cards included, and its parse_cards() regex reads
##    the first colon as the separator. So the QR carries "Number: KWB 1324" and
##    needs no special case in the reader.
##
## SEQUENCE SAFETY. A collection number used twice is a data problem that cannot
## be repaired afterwards — two specimens, one key, and no way to tell which
## photograph belongs to which sheet. Every run therefore appends to a ledger
## CSV and refuses to reissue a number that ledger has already seen.
## ---------------------------------------------------------------------------
## Dependencies: qrcode, grid, and make_qr_cards.R for the shared sheet geometry.
## ============================================================================

source("make_qr_cards.R")   ## avery_5371, card_centre, check_template,
                            ## draw_qr, fit_fontsize, draw_guides

## --- One identity card -------------------------------------------------------
## Collector prefix above the digits on the left, QR filling the height on the
## right. The printed number and the QR are two copies of the same fact: a card
## that will not scan still reads to the eye.
draw_number_card <- function(prefix, digits, text, ecl = "H",
                             card_w = 3.5, card_h = 2, pad = 0.12, gap = 0.10,
                             size_prefix = 15, size_digits = 44) {
  content_w <- card_w - 2 * pad
  qr_side   <- card_h - 2 * pad
  text_w    <- content_w - gap - qr_side
  if (text_w <= 0.3)
    stop(sprintf("No room for the number: %.2fin left beside a %.2fin code.",
                 text_w, qr_side))

  ## the QR, hard against the right edge of the content area
  pushViewport(viewport(x      = unit(pad + text_w + gap + qr_side / 2, "in"),
                        width  = unit(qr_side, "in"),
                        height = unit(qr_side, "in")))
  draw_qr(text, ecl = ecl)
  popViewport()

  ## the human-readable number, filling the space to its left
  size_prefix <- fit_fontsize(prefix, text_w, size_prefix, bold = FALSE)
  size_digits <- fit_fontsize(digits, text_w, size_digits, bold = TRUE)
  pushViewport(viewport(x      = unit(pad + text_w / 2, "in"),
                        width  = unit(text_w, "in"),
                        height = unit(qr_side, "in"),
                        layout = grid.layout(2, 1, heights = unit(c(1, 2), "null"))))
  pushViewport(viewport(layout.pos.row = 1))
  grid.text(prefix, y = unit(0.25, "npc"),
            gp = gpar(fontsize = size_prefix, col = "grey25"))
  popViewport()
  pushViewport(viewport(layout.pos.row = 2))
  grid.text(digits, y = unit(0.62, "npc"),
            gp = gpar(fontsize = size_digits, fontface = "bold"))
  popViewport()
  popViewport()
}

## --- The ledger: which numbers have already been issued ----------------------
## Read, check, append. Kept as plain CSV so it is greppable and diffable, and
## so a number can be traced back to the sheet it was printed on.
read_ledger <- function(path) {
  if (is.null(path) || !file.exists(path))
    return(data.frame(prefix = character(), number = integer(),
                      code = character(), printed = character(),
                      pdf = character(), stringsAsFactors = FALSE))
  utils::read.csv(path, stringsAsFactors = FALSE)
}

check_ledger <- function(path, prefix, numbers, allow_reprint = FALSE) {
  led <- read_ledger(path)
  if (nrow(led) == 0) return(invisible(TRUE))
  clash <- intersect(numbers, led$number[led$prefix == prefix])
  if (length(clash) && !allow_reprint)
    stop(sprintf(paste0("These %s numbers were already issued: %s.\n",
                        "  Ledger: %s\n",
                        "  Reissuing a collection number cannot be undone once both cards are in the field.\n",
                        "  Pick a later start, or pass allow_reprint = TRUE if you know a sheet was lost."),
                 prefix, paste(range(clash), collapse = "-"), path), call. = FALSE)
  if (length(clash))
    warning(sprintf("REPRINTING already-issued %s numbers: %s",
                    prefix, paste(range(clash), collapse = "-")), call. = FALSE)
  invisible(TRUE)
}

## --- Build a run of number cards ---------------------------------------------
## prefix        collector code, e.g. "KWB"
## start, n      first collection number, and how many cards
## pad_digits    0 for "1324"; 5 for "01324" (zero-padded, sorts as text)
## ledger        CSV of issued numbers; NULL disables the check (not advised)
make_number_cards <- function(pdf_file, prefix = "KWB", start, n, ecl = "H",
                              template = avery_5371,
                              x_offset = 0, y_offset = 0,
                              guides = FALSE, pad = 0.12, gap = 0.10,
                              pad_digits = 0,
                              ledger = "number_cards_ledger.csv",
                              allow_reprint = FALSE) {

  validate_qr_engine(ecl = ecl)   ## hard stop before anything is written
  check_template(template)
  if (n < 1) stop("n must be at least 1.")
  numbers <- seq.int(start, length.out = n)
  check_ledger(ledger, prefix, numbers, allow_reprint)

  digits <- if (pad_digits > 0)
    formatC(numbers, width = pad_digits, flag = "0") else as.character(numbers)
  codes  <- paste(prefix, digits)
  texts  <- paste0("Number: ", codes)

  per_page <- template$n_col * template$n_row
  n_pages  <- ceiling(n / per_page)

  pdf(pdf_file, width = template$page_w, height = template$page_h)
  on.exit(dev.off(), add = TRUE)

  ## Measuring the widest label opens page 1, so the loop below skips its own
  ## newpage() on the first pass (an unconditional one would leave it blank).
  widest <- digits[which.max(nchar(digits))]
  invisible(fit_fontsize(widest, 1, 44, bold = TRUE))

  for (p in seq_len(n_pages)) {
    if (p > 1) grid.newpage()
    idx <- seq((p - 1) * per_page + 1, min(p * per_page, n))
    for (k in seq_along(idx)) {
      slot <- k - 1L
      i <- slot %/% template$n_col + 1L
      j <- slot %%  template$n_col + 1L
      ctr <- card_centre(i, j, template, x_offset, y_offset)
      pushViewport(viewport(x      = unit(ctr$x, "in"),
                            y      = unit(ctr$y, "in"),
                            width  = unit(template$card_w, "in"),
                            height = unit(template$card_h, "in")))
      ## bind_left = 0: these cards are not bound, so nothing is reserved
      if (guides) draw_guides(template$card_w, bind_left = 0, pad = pad)
      draw_number_card(prefix, digits[idx[k]], texts[idx[k]], ecl = ecl,
                       card_w = template$card_w, card_h = template$card_h,
                       pad = pad, gap = gap)
      popViewport()
    }
  }

  ## record the run
  if (!is.null(ledger)) {
    entry <- data.frame(prefix = prefix, number = numbers, code = codes,
                        printed = format(Sys.Date()), pdf = basename(pdf_file),
                        stringsAsFactors = FALSE)
    led <- rbind(read_ledger(ledger), entry)
    utils::write.csv(led, ledger, row.names = FALSE)
  }

  qr_side <- template$card_h - 2 * pad
  message(sprintf(
    "%s %s to %s — %d cards on %d sheet(s) -> %s\n  QR %.2fin square (vs %.2fin on the bound decks)\n  ledger: %s",
    prefix, digits[1], digits[n], n, n_pages, pdf_file, qr_side, 1.135,
    if (is.null(ledger)) "not recorded" else ledger))
  invisible(list(pdf = pdf_file, numbers = numbers, codes = codes))
}

## --- Example usage (run manually) --------------------------------------------
## Fifty cards continuing a KWB series at 1325:
##   make_number_cards("KWB_1325_1374.pdf", prefix = "KWB", start = 1325, n = 50)
##
## The ledger then refuses an overlapping run:
##   make_number_cards("oops.pdf", start = 1300, n = 50)   ## error, 1325-1349 issued
##
## Zero-padded variant, if you prefer "KWB 01325":
##   make_number_cards("KWB_padded.pdf", start = 1325, n = 50, pad_digits = 5)
##
## Same printer calibration as the decks, if yours needs one:
##   make_number_cards("KWB.pdf", start = 1325, n = 50, x_offset = 0.06)
