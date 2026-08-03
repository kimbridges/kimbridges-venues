## ============================================================================
## make_qr_cards.R  --  Deck-driven QR card maker for specimen field notes
##
## Rewritten 2026-07-28. Two independent defects were found by printing real
## cards and putting them in the hand:
##
## 1. SHEET ALIGNMENT. The previous version laid cards out with
##    gridExtra::marrangeGrob() across the whole 8.5 x 11 page, which makes ten
##    equal 4.25 x 2.20 cells. Avery 5371 cards are 3.5 x 2.0 inside a 0.75in
##    side margin and a 0.5in top margin, so content printed up to 0.375in off
##    centre -- and the error ran in OPPOSITE directions in the two columns, so
##    no single nudge could correct it. Every card now gets its own grid
##    viewport at the true Avery position.
##
## 2. BINDING CLEARANCE. An observation deck is bound on the LEFT through a
##    punched hole on a screw post, and the card pivots on it. A stack of cards
##    fanned on that post occludes roughly the left 1.5in of the card beneath.
##    Content centred in the card is geometrically correct and ergonomically
##    wrong: a centred QR's left edge falls at 1.18in, inside the occluded band,
##    so the code is clipped and will not scan. `bind_left` reserves that band.
##
##    MEASURED ON THE ARTIFACT (2026-07-29). The assembled deck was measured off
##    a photograph, scaled by the card's known 3.5 x 2.0in edges (621.6 px/in,
##    agreeing on both axes to 0.2%):
##      QR right edge   3.013in from the card's left edge (predicted 3.008) - ok
##      cover reaches   1.804in  -> 0.30in PAST the 1.5in `bind_left` reserve
##      QR left edge    1.930in  -> only 0.127in clear of the ACTUAL cover
##      punched hole    0.788in from the card's left edge (`punch_x` says 0.375)
##    The often-quoted "0.37in of clearance" is clearance against the 1.5in
##    ASSUMPTION, not against the cover. The real margin in the hand is about an
##    eighth of an inch. Decks decode at that margin (the measured frame reads
##    `Phenology: No Flowers`), so `bind_left` is deliberately left at 1.5in --
##    widening it costs QR size. If a deck ever fails to decode with the stack
##    fanned, `bind_left` is the first number to raise.
##
##    ★ The rule this adds to validate_qr_engine()'s lesson: a verified number
##    must name what it was measured AGAINST. "0.372in clear" and "0.127in clear"
##    are both true of the same deck; only one of them is about the object.
##
## These are independent. `bind_left` is a fact about the BINDING (where content
## sits within a card); `x_offset` / `y_offset` are a fact about the PRINTER
## (where the whole grid lands on the sheet). Keep them separate.
##
## Dropping gridExtra/readr/tidyr/purrr in favour of base R + grid removed four
## Imports from the package; nothing else here used them.
##
## Print with page scaling OFF ("Actual size" / 100%). Scaling to fit is the
## single most common cause of card drift.
## ============================================================================

#' Avery 5371 business-card sheet geometry
#'
#' Sheet template used by [make_qr_cards()], [make_number_cards()] and
#' [qr_calibration_sheet()]. All values are inches. `pitch_x` / `pitch_y` are
#' centre-to-centre spacing, which equals the card size when labels butt against
#' each other, as they do on this stock.
#'
#' The numbers close exactly, which is the check worth remembering:
#' `0.75 + 3.5 + 3.5 + 0.75 = 8.5` and `0.5 + 5 * 2 + 0.5 = 11`. Equivalent
#' stock: Avery 5371, 8371, 28877.
#'
#' Copy and modify this list for other stock, then pass it as `template`.
#'
#' @format A list with elements `name`, `page_w`, `page_h`, `n_col`, `n_row`,
#'   `card_w`, `card_h`, `margin_left`, `margin_top`, `pitch_x`, `pitch_y`.
#' @export
avery_5371 <- list(
  name        = "Avery 5371 (US Letter, 2 x 5, 3.5in x 2in)",
  page_w      = 8.5,  page_h  = 11,
  n_col       = 2,    n_row   = 5,
  card_w      = 3.5,  card_h  = 2,
  margin_left = 0.75, margin_top = 0.5,
  pitch_x     = 3.5,  pitch_y = 2
)

## Binding hardware defaults (guides only, except bind_left).
## `punch_x` / `punch_d` are NOMINAL: they drive the guide sheet, not the layout.
## The decks built 2026-07-28 measure a hole 0.788in from the card edge and posts
## ~0.39in across, because a hand punch reaches where it reaches. Harmless in the
## code; misleading on a guide sheet, which will not show a collector where their
## own punch lands. See the MEASURED note in the header.
bind_default <- list(bind_left = 1.5, punch_x = 0.375, punch_d = 0.25)

## Centre of card (row i, col j) in grid's native coordinates: x from the left
## edge, y from the BOTTOM edge, both inches.
card_centre <- function(i, j, tmpl, x_offset = 0, y_offset = 0) {
  cx <- tmpl$margin_left + tmpl$card_w / 2 + (j - 1) * tmpl$pitch_x + x_offset
  cy_from_top <- tmpl$margin_top + tmpl$card_h / 2 + (i - 1) * tmpl$pitch_y + y_offset
  list(x = cx, y = tmpl$page_h - cy_from_top)
}

## The printable area right of the binding band: width, and the x of its centre
## measured from the card's left edge.
clear_zone <- function(card_w, bind_left, pad) {
  w <- card_w - bind_left - pad
  if (w <= 0)
    stop(sprintf("bind_left (%.2fin) leaves no room on a %.2fin card.",
                 bind_left, card_w), call. = FALSE)
  list(w = w, cx = bind_left + w / 2)
}

## Catch a mistyped margin or pitch before it costs a sheet of card stock.
check_template <- function(tmpl) {
  used_w <- tmpl$margin_left + (tmpl$n_col - 1) * tmpl$pitch_x + tmpl$card_w
  used_h <- tmpl$margin_top  + (tmpl$n_row - 1) * tmpl$pitch_y + tmpl$card_h
  if (used_w > tmpl$page_w + 1e-9)
    stop(sprintf("Template too wide: needs %.3fin on a %.3fin page.",
                 used_w, tmpl$page_w), call. = FALSE)
  if (used_h > tmpl$page_h + 1e-9)
    stop(sprintf("Template too tall: needs %.3fin on a %.3fin page.",
                 used_h, tmpl$page_h), call. = FALSE)
  ## A card wider or taller than its own pitch means neighbouring cards overlap.
  ## The sheet extent can still fit, so this is invisible to the checks above --
  ## it has to be tested separately or overlapping cards print silently.
  if (tmpl$card_w > tmpl$pitch_x + 1e-9)
    stop(sprintf("Cards overlap: card_w %.3fin exceeds pitch_x %.3fin.",
                 tmpl$card_w, tmpl$pitch_x), call. = FALSE)
  if (tmpl$card_h > tmpl$pitch_y + 1e-9)
    stop(sprintf("Cards overlap: card_h %.3fin exceeds pitch_y %.3fin.",
                 tmpl$card_h, tmpl$pitch_y), call. = FALSE)
  invisible(TRUE)
}

## --- QR structural validation ------------------------------------------------
## Added after a full deck and a sheet of number cards were printed from PDFs
## whose codes came from a PLACEHOLDER qr_code() -- visually convincing,
## completely unreadable. The PDFs rendered, the geometry measured correct, the
## cards printed cleanly, and the failure surfaced only when the finished cards
## were photographed and would not decode.
##
## A QR code has a rigid skeleton, so validity is checkable with no scanner and
## no external tools: three 7x7 finder patterns at top-left, top-right and
## bottom-left; timing patterns alternating along row 6 and column 6 between
## them; and a side length of 21 + 4*(version - 1). Random fill with a
## decorative corner passes none of these.

FINDER <- matrix(c(
  1L,1L,1L,1L,1L,1L,1L,
  1L,0L,0L,0L,0L,0L,1L,
  1L,0L,1L,1L,1L,0L,1L,
  1L,0L,1L,1L,1L,0L,1L,
  1L,0L,1L,1L,1L,0L,1L,
  1L,0L,0L,0L,0L,0L,1L,
  1L,1L,1L,1L,1L,1L,1L), nrow = 7, byrow = TRUE)

## qr_code() may or may not return the 4-module quiet zone; strip any all-white
## border so the checks can assume the code starts at [1, 1].
trim_quiet_zone <- function(m) {
  keep_r <- which(apply(m, 1, any)); keep_c <- which(apply(m, 2, any))
  if (!length(keep_r) || !length(keep_c)) return(m)
  m[min(keep_r):max(keep_r), min(keep_c):max(keep_c), drop = FALSE]
}

## Structural check on a module matrix. Split out from validate_qr_engine() so
## it can be tested directly with a hand-made bad matrix, with no QR engine
## involved. Returns NULL if valid, else a one-line reason.
check_qr_matrix <- function(m) {
  m <- trim_quiet_zone(ifelse(as.matrix(m), 1L, 0L))
  n <- nrow(m)
  if (n != ncol(m))
    return(sprintf("matrix is %dx%d, not square.", n, ncol(m)))
  if (n < 21 || (n - 21) %% 4)
    return(sprintf("side is %d modules; QR sizes are 21, 25, 29, ...", n))
  corners <- list("top-left"    = m[1:7, 1:7],
                  "top-right"   = m[1:7, (n - 6):n],
                  "bottom-left" = m[(n - 6):n, 1:7])
  bad <- names(corners)[!vapply(corners, function(x) all(x == FINDER), logical(1))]
  if (length(bad))
    return(sprintf("missing or malformed finder pattern at %s (a real QR has all three).",
                   paste(bad, collapse = ", ")))
  expect <- rep(c(1L, 0L), length.out = n - 16)
  if (!identical(as.integer(m[7, 9:(n - 8)]), expect) ||
      !identical(as.integer(m[9:(n - 8), 7]), expect))
    return("timing pattern is wrong (row/column 6 must alternate dark/light).")
  NULL
}

#' Check that the QR engine produces structurally valid codes
#'
#' Generates one code and verifies its skeleton: three finder patterns, correct
#' timing rows, and a legal module count. Called by [make_qr_cards()] and
#' [make_number_cards()] before anything is written, so a bad engine produces an
#' error rather than a stack of printed cards that look perfect and carry
#' nothing.
#'
#' This exists because exactly that happened: a placeholder `qr_code()` produced
#' convincing, unreadable cards that passed every geometric check and were
#' printed, assembled and photographed before the failure was noticed.
#'
#' @param sample_text Text to encode for the probe.
#' @param ecl QR error-correction level: `"L"`, `"M"`, `"Q"` or `"H"`.
#' @return `TRUE`, invisibly, if the engine is sound; otherwise an error.
#' @examples
#' \dontrun{
#' validate_qr_engine()
#' }
#' @export
validate_qr_engine <- function(sample_text = "Number: KWB 1", ecl = "H") {
  m <- tryCatch(qr_code(sample_text, ecl = ecl),
                error = function(e)
                  stop("qr_code() failed: ", conditionMessage(e), call. = FALSE))
  why <- check_qr_matrix(m)
  if (!is.null(why))
    stop(sprintf(paste0(
      "The QR engine is not producing valid QR codes: %s\n",
      "  Nothing has been written. Do NOT print.\n",
      "  Check that the real CRAN 'qrcode' package is attached:\n",
      "    packageVersion(\"qrcode\")\n",
      "  (A stub or shadowed qr_code() will render convincing, unreadable cards.)"),
      why), call. = FALSE)
  invisible(TRUE)
}

## --- Drawing helpers ---------------------------------------------------------

## One QR code drawn as a crisp square in the current viewport. interpolate =
## FALSE keeps the modules hard-edged; a blurred QR is a QR that will not scan.
draw_qr <- function(text, ecl = "H") {
  modules <- qr_code(text, ecl = ecl)
  grid.raster(as.raster(ifelse(modules, "black", "white")),
              interpolate = FALSE,
              width = unit(1, "snpc"), height = unit(1, "snpc"))
}

## Reserving the binding band narrows the printable zone from 3.26in to 1.88in,
## which is not wide enough for every label a deck may already carry ("Abundant
## Flowers" runs about 2.0in at 18pt). Text width scales linearly with point
## size, so one measurement gives the size that fits. Shrinking beats wrapping:
## the header band is only 0.34in tall, so a second line would have to drop to
## ~10pt, while a single line needs a few per cent. `safety` covers the gap
## between R's text metrics and what the printer rasterises -- measured glyph
## runs came out ~3% wider than grobWidth reported, enough to nick the band.
fit_fontsize <- function(label, max_w, size, bold = FALSE, min_size = 8,
                         safety = 0.96) {
  if (is.na(label) || !nzchar(label)) return(size)
  max_w <- max_w * safety
  w <- convertWidth(grobWidth(textGrob(
         label, gp = gpar(fontsize = size,
                          fontface = if (bold) "bold" else "plain"))),
       "in", valueOnly = TRUE)
  if (w <= max_w) return(size)
  max(min_size, floor(size * max_w / w * 10) / 10)
}

## One deck card: value on top, QR in the middle, field name below -- all within
## the clear zone right of the binding band. A comment card (blank footer)
## leaves that band empty as a writing space.
draw_card <- function(header, footer, text, ecl = "H",
                      card_w = 3.5, bind_left = 1.5, pad = 0.12,
                      size_header = 18, size_footer = 10) {
  zone <- clear_zone(card_w, bind_left, pad)
  size_header <- fit_fontsize(header, zone$w, size_header, bold = TRUE)
  size_footer <- fit_fontsize(footer, zone$w, size_footer)

  pushViewport(viewport(x      = unit(zone$cx, "in"),
                        width  = unit(zone$w, "in"),
                        height = unit(1, "npc") - unit(2 * pad, "in"),
                        layout = grid.layout(3, 1,
                                             heights = unit(c(1.2, 4, 1), "null"))))
  pushViewport(viewport(layout.pos.row = 1))
  if (!is.na(header) && nzchar(header))
    grid.text(header, gp = gpar(fontsize = size_header, fontface = "bold"))
  popViewport()
  pushViewport(viewport(layout.pos.row = 2))
  draw_qr(text, ecl = ecl)
  popViewport()
  pushViewport(viewport(layout.pos.row = 3))
  if (!is.na(footer) && nzchar(footer))
    grid.text(footer, gp = gpar(fontsize = size_footer))
  popViewport()
  popViewport()
}

## Card outline, shaded binding band, punch hole and content crosshair. Binding
## hardware is drawn only where there is a binding: identity cards run with
## bind_left = 0 and a post hole through them would mislead and collide with the
## printed number.
draw_guides <- function(card_w = 3.5, bind_left = 1.5, pad = 0.12,
                        bind = bind_default) {
  zone <- clear_zone(card_w, bind_left, pad)
  grid.rect(gp = gpar(col = "grey60", fill = NA, lty = "dashed", lwd = 0.5))
  if (bind_left > 0) {
    grid.rect(x = unit(bind_left / 2, "in"), width = unit(bind_left, "in"),
              gp = gpar(col = NA, fill = "grey92"))
    grid.segments(unit(bind_left, "in"), unit(0, "npc"),
                  unit(bind_left, "in"), unit(1, "npc"),
                  gp = gpar(col = "grey55", lty = "dotted", lwd = 0.6))
    grid.circle(x = unit(bind$punch_x, "in"), r = unit(bind$punch_d / 2, "in"),
                gp = gpar(col = "grey45", fill = NA, lwd = 0.6))
    for (d in c(-1, 1)) {
      grid.segments(unit(bind$punch_x, "in"), unit(0.5, "npc"),
                    unit(bind$punch_x + d * 0.16, "in"), unit(0.5, "npc"),
                    gp = gpar(col = "grey45", lwd = 0.6))
      grid.segments(unit(bind$punch_x, "in"), unit(0.5, "npc"),
                    unit(bind$punch_x, "in"),
                    unit(0.5, "npc") + unit(d * 0.16, "in"),
                    gp = gpar(col = "grey45", lwd = 0.6))
    }
  }
  grid.segments(unit(zone$cx, "in"), unit(0.5, "npc") - unit(0.1, "in"),
                unit(zone$cx, "in"), unit(0.5, "npc") + unit(0.1, "in"),
                gp = gpar(col = "grey60", lwd = 0.5))
  grid.segments(unit(zone$cx - 0.1, "in"), unit(0.5, "npc"),
                unit(zone$cx + 0.1, "in"), unit(0.5, "npc"),
                gp = gpar(col = "grey60", lwd = 0.5))
}

#' Build a printable QR-card deck from a deck CSV
#'
#' Read a deck definition (one row per card) and write a multi-page PDF of
#' printable cards laid out at true Avery 5371 positions. Each card shows a short
#' value, a QR code encoding the full self-describing field text, and the field
#' name below -- so a scan reads finished label text with no lookup table, and
#' the card still reads to the eye if the QR will not scan.
#'
#' The deck CSV has columns: `copies` (how many of the card to print), `header`
#' (short value shown large, e.g. `"Tree"`), `footer` (field/deck name below the
#' QR, e.g. `"Life Form"`; blank for a writable comment card), and `text` (the
#' string encoded in the QR, e.g. `"Life Form: Tree"`). An example deck ships
#' with the package: `system.file("extdata", "QR_field_notes.csv", package = "vouchr")`.
#'
#' Content is placed in the clear zone right of `bind_left`, which reserves the
#' band occluded by a stack of cards fanned on the screw post. Headers too wide
#' for that zone are shrunk to fit, with a warning naming them.
#'
#' Print with page scaling off ("Actual size" / 100%).
#'
#' @param deck_csv Path to the deck CSV.
#' @param pdf_file Output PDF path.
#' @param ecl QR error-correction level: `"L"`, `"M"`, `"Q"`, or `"H"` (default,
#'   ~30%, the most robust for field-handled cards).
#' @param template Sheet geometry; see [avery_5371].
#' @param bind_left Width in inches of the band reserved on each card's left edge
#'   for the screw post and the fanned stack above it. Nothing is printed there.
#'   Use `0` for cards that are not bound.
#' @param x_offset,y_offset Shift the entire card grid, in inches, positive =
#'   right and down. For cancelling a printer's feed offset measured from
#'   [qr_calibration_sheet()]; not for layout.
#' @param guides Draw card outlines, the binding band and a punch mark alongside
#'   the cards.
#' @param pad Inner margin in inches between card edge and content.
#' @return The `pdf_file` path, invisibly.
#' @seealso [qr_calibration_sheet()] to check alignment before printing on stock;
#'   [make_number_cards()] for collection-number cards.
#' @examples
#' \dontrun{
#' deck <- system.file("extdata", "QR_field_notes.csv", package = "vouchr")
#' make_qr_cards(deck, "QR_field_notes_cards.pdf")
#' }
#' @export
make_qr_cards <- function(deck_csv, pdf_file, ecl = "H",
                          template = avery_5371,
                          bind_left = 1.5,
                          x_offset = 0, y_offset = 0,
                          guides = FALSE, pad = 0.12) {

  validate_qr_engine(ecl = ecl)   ## hard stop before anything is written
  check_template(template)
  zone <- clear_zone(template$card_w, bind_left, pad)

  deck <- utils::read.csv(deck_csv, stringsAsFactors = FALSE,
                          colClasses = "character")
  need <- c("copies", "header", "footer", "text")
  if (!all(need %in% names(deck)))
    stop("Deck CSV needs columns: ", paste(need, collapse = ", "), call. = FALSE)

  copies <- as.integer(deck$copies)
  copies[is.na(copies)] <- 1L
  cards <- deck[rep(seq_len(nrow(deck)), copies), , drop = FALSE]
  if (nrow(cards) == 0L) stop("Deck is empty after applying `copies`.", call. = FALSE)

  per_page <- template$n_col * template$n_row
  n_pages  <- ceiling(nrow(cards) / per_page)

  pdf(pdf_file, width = template$page_w, height = template$page_h)
  on.exit(dev.off(), add = TRUE)

  ## Warn about labels the clear zone forces smaller -- a silent shrink would let
  ## a deck drift out of visual step without anyone noticing.
  shrunk <- unique(deck$header[vapply(deck$header,
              function(h) fit_fontsize(h, zone$w, 18, bold = TRUE) < 18,
              logical(1))])
  if (length(shrunk))
    warning("Headers too wide for the clear zone, shrunk to fit: ",
            paste(shrunk, collapse = ", "),
            ". Consider shorter wording for visual consistency.", call. = FALSE)

  for (p in seq_len(n_pages)) {
    ## Measuring the headers above already opened page 1; an unconditional
    ## newpage() here would leave it blank in the PDF.
    if (p > 1) grid.newpage()
    idx <- seq((p - 1) * per_page + 1, min(p * per_page, nrow(cards)))
    for (k in seq_along(idx)) {
      slot <- k - 1L
      i <- slot %/% template$n_col + 1L
      j <- slot %%  template$n_col + 1L
      ctr <- card_centre(i, j, template, x_offset, y_offset)
      pushViewport(viewport(x      = unit(ctr$x, "in"),
                            y      = unit(ctr$y, "in"),
                            width  = unit(template$card_w, "in"),
                            height = unit(template$card_h, "in")))
      if (guides) draw_guides(template$card_w, bind_left, pad)
      row <- cards[idx[k], ]
      draw_card(row$header, row$footer, row$text, ecl = ecl,
                card_w = template$card_w, bind_left = bind_left, pad = pad)
      popViewport()
    }
  }

  qr_side <- min(zone$w, (template$card_h - 2 * pad) * 4 / 6.2)
  message(sprintf(
    "%d cards on %d page(s) -> %s\n  QR %.3fin square, left edge %.3fin from card edge (%.3fin clear of the %.2fin binding band)",
    nrow(cards), n_pages, pdf_file, qr_side,
    zone$cx - qr_side / 2, zone$cx - qr_side / 2 - bind_left, bind_left))
  invisible(pdf_file)
}

#' Print an alignment and clearance calibration sheet
#'
#' Card outlines, the shaded binding band, the punch-hole mark and a labelled
#' quarter-inch scale through the clear zone, with no QR codes. Print on plain
#' paper at 100% scale and lay it over a blank label sheet: the outlines should
#' sit on the die cuts. Read off any drift and pass its negative as `x_offset` /
#' `y_offset` to the card makers. Punch one and mount it on the post to confirm
#' `bind_left` is wide enough before spending card stock.
#'
#' @param pdf_file Output PDF path.
#' @param template Sheet geometry; see [avery_5371].
#' @param bind_left Width in inches of the reserved binding band to draw.
#' @param x_offset,y_offset Shift the grid, in inches, positive = right and down.
#' @param pad Inner margin in inches between card edge and content.
#' @return The `pdf_file` path, invisibly.
#' @examples
#' \dontrun{
#' qr_calibration_sheet("avery_5371_calibration.pdf")
#' }
#' @export
qr_calibration_sheet <- function(pdf_file = "avery_5371_calibration.pdf",
                                 template = avery_5371,
                                 bind_left = 1.5,
                                 x_offset = 0, y_offset = 0, pad = 0.12) {
  check_template(template)
  zone <- clear_zone(template$card_w, bind_left, pad)

  pdf(pdf_file, width = template$page_w, height = template$page_h)
  on.exit(dev.off(), add = TRUE)
  grid.newpage()

  for (i in seq_len(template$n_row)) for (j in seq_len(template$n_col)) {
    ctr <- card_centre(i, j, template, x_offset, y_offset)
    pushViewport(viewport(x = unit(ctr$x, "in"), y = unit(ctr$y, "in"),
                          width  = unit(template$card_w, "in"),
                          height = unit(template$card_h, "in")))
    draw_guides(template$card_w, bind_left, pad)
    for (d in seq(-0.75, 0.75, by = 0.25)) {
      len <- if (d == round(d)) 0.10 else 0.05
      grid.segments(unit(zone$cx + d, "in"), unit(0.5, "npc"),
                    unit(zone$cx + d, "in"), unit(0.5, "npc") + unit(len, "in"),
                    gp = gpar(col = "grey40", lwd = 0.5))
      if (d == round(d) && d != 0)
        grid.text(sprintf("%+d", as.integer(d)),
                  x = unit(zone$cx + d, "in"),
                  y = unit(0.5, "npc") + unit(0.16, "in"),
                  gp = gpar(fontsize = 6, col = "grey40"))
    }
    grid.text(sprintf("r%d c%d", i, j), x = unit(zone$cx, "in"),
              y = unit(0.5, "npc") - unit(0.22, "in"),
              gp = gpar(fontsize = 7, col = "grey40"))
    popViewport()
  }

  grid.text(sprintf("%s  |  binding band %.2fin  |  offset %+.3fin x, %+.3fin y  |  print at 100%%, no scaling",
                    template$name, bind_left, x_offset, y_offset),
            y = unit(0.22, "in"), gp = gpar(fontsize = 7, col = "grey40"))
  invisible(pdf_file)
}
