## ============================================================================
## make_number_cards.R  --  Collection-number (identity) cards
##
## The identity card is the key to the whole system: the collection number is the
## stand-in for the bagged specimen and the join between the pressed sheet and
## the photograph. It is the graceful-degradation floor -- the non-negotiable
## minimum is the number card plus the photo -- so it is the one card that must
## scan when nothing else gets photographed.
##
## Three design decisions follow from that:
##
## 1. NO BINDING BAND. Identity cards live loose in a business-card holder
##    because you DETACH them onto a specimen; nothing fans over them, so the
##    full card width is available. (Observation decks reserve 1.5in for the
##    screw post -- see make_qr_cards.R.)
##
## 2. NUMBER BESIDE THE QR, NOT ABOVE IT. On a deck card the QR is sized by the
##    height of its middle band, so it comes out 1.14in square even on a 3.5in
##    card. Setting the number alongside lets the code use the FULL content
##    height: 1.76in square, about 2.4x the area. That is scan distance and
##    damage tolerance on the card that can least afford to fail.
##
## 3. SELF-DESCRIBING PAYLOAD. The QR carries "Number: KWB 1243", parsed by
##    parse_cards() exactly like every other card, so the reader needs no special
##    case for identity.
##
## SEQUENCE SAFETY. A collection number used twice cannot be repaired afterwards
## -- two specimens, one key, and no way to tell which photograph belongs to
## which sheet. Every run appends to a ledger CSV and refuses to reissue a number
## that ledger has already seen.
## ============================================================================

## One identity card: collector prefix above the digits on the left, QR filling
## the height on the right. Printed number and QR are two copies of one fact.
draw_number_card <- function(prefix, digits, text, ecl = "H",
                             card_w = 3.5, card_h = 2, pad = 0.12, gap = 0.10,
                             size_prefix = 15, size_digits = 44) {
  content_w <- card_w - 2 * pad
  qr_side   <- card_h - 2 * pad
  text_w    <- content_w - gap - qr_side
  if (text_w <= 0.3)
    stop(sprintf("No room for the number: %.2fin left beside a %.2fin code.",
                 text_w, qr_side), call. = FALSE)

  pushViewport(viewport(x      = unit(pad + text_w + gap + qr_side / 2, "in"),
                        width  = unit(qr_side, "in"),
                        height = unit(qr_side, "in")))
  draw_qr(text, ecl = ecl)
  popViewport()

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

## The ledger: which numbers have already been issued. Plain CSV so it is
## greppable and diffable, and so a number can be traced to the sheet it was
## printed on. `number` is written unquoted (numeric) -- quoting it would make
## the clash test compare integers against strings and silently stop working.
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
  clash <- intersect(numbers, as.integer(led$number[led$prefix == prefix]))
  if (length(clash) && !allow_reprint)
    stop(sprintf(paste0(
      "These %s numbers were already issued: %s.\n",
      "  Ledger: %s\n",
      "  Reissuing a collection number cannot be undone once both cards are in the field.\n",
      "  Pick a later start, or pass allow_reprint = TRUE if you know a sheet was lost."),
      prefix, paste(range(clash), collapse = "-"), path), call. = FALSE)
  if (length(clash))
    warning(sprintf("REPRINTING already-issued %s numbers: %s",
                    prefix, paste(range(clash), collapse = "-")), call. = FALSE)
  invisible(TRUE)
}

#' Build a run of collection-number (identity) cards
#'
#' Write a PDF of numbered identity cards at true Avery 5371 positions, each
#' carrying a QR encoding `"Number: <prefix> <n>"` and the same number printed
#' large beside it. The QR uses the full card height -- about 2.4x the area of a
#' deck card's code -- because this is the one card that must scan.
#'
#' Unlike observation decks, identity cards reserve no binding band: they live
#' loose in a business-card holder because you detach them onto a specimen.
#'
#' Every run appends the issued numbers to `ledger` and refuses to reissue a
#' number already recorded there. A collection number used twice cannot be
#' repaired afterwards.
#'
#' @param pdf_file Output PDF path.
#' @param prefix Collector code, e.g. `"KWB"`.
#' @param start First collection number in the run.
#' @param n How many cards to print.
#' @param ecl QR error-correction level: `"L"`, `"M"`, `"Q"` or `"H"` (default).
#' @param template Sheet geometry; see [avery_5371].
#' @param x_offset,y_offset Shift the entire grid, in inches, positive = right and
#'   down, to cancel a printer feed offset measured from [qr_calibration_sheet()].
#' @param guides Draw card outlines alongside the cards.
#' @param pad Inner margin in inches between card edge and content.
#' @param gap Gap in inches between the printed number and the QR.
#' @param pad_digits Zero-pad the number to this width; `0` (default) for
#'   `"1243"`, `5` for `"01243"` (which sorts correctly as text).
#' @param ledger Path to the issued-number CSV; `NULL` disables the check, which
#'   is not advised.
#' @param allow_reprint Reissue numbers the ledger has already seen, with a
#'   warning. For a sheet known to be lost or spoiled.
#' @return Invisibly, a list with `pdf`, `numbers` and `codes`.
#' @seealso [make_qr_cards()] for observation decks; [qr_calibration_sheet()].
#' @examples
#' \dontrun{
#' make_number_cards("KWB_1243_1252.pdf", prefix = "KWB", start = 1243, n = 10)
#' }
#' @export
make_number_cards <- function(pdf_file, prefix = "KWB", start, n, ecl = "H",
                              template = avery_5371,
                              x_offset = 0, y_offset = 0,
                              guides = FALSE, pad = 0.12, gap = 0.10,
                              pad_digits = 0,
                              ledger = "number_cards_ledger.csv",
                              allow_reprint = FALSE) {

  validate_qr_engine(ecl = ecl)   ## hard stop before anything is written
  check_template(template)
  if (n < 1) stop("n must be at least 1.", call. = FALSE)
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

  ## Measuring the widest label opens page 1, so the loop skips its own
  ## newpage() on the first pass; an unconditional one would leave it blank.
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
      if (guides) draw_guides(template$card_w, bind_left = 0, pad = pad)
      draw_number_card(prefix, digits[idx[k]], texts[idx[k]], ecl = ecl,
                       card_w = template$card_w, card_h = template$card_h,
                       pad = pad, gap = gap)
      popViewport()
    }
  }

  if (!is.null(ledger)) {
    entry <- data.frame(prefix = prefix, number = numbers, code = codes,
                        printed = format(Sys.Date()), pdf = basename(pdf_file),
                        stringsAsFactors = FALSE)
    utils::write.csv(rbind(read_ledger(ledger), entry), ledger, row.names = FALSE)
  }

  message(sprintf(
    "%s %s to %s -- %d cards on %d sheet(s) -> %s\n  QR %.2fin square\n  ledger: %s",
    prefix, digits[1], digits[n], n, n_pages, pdf_file,
    template$card_h - 2 * pad,
    if (is.null(ledger)) "not recorded" else ledger))
  invisible(list(pdf = pdf_file, numbers = numbers, codes = codes))
}
