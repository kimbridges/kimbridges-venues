## ============================================================================
## make_qr_cards.R  —  Deck-driven QR card maker for specimen field notes
##
## Reads a deck definition (a CSV with one row per card) and writes a PDF of
## printable cards. Each card shows a short value, a QR code that encodes the
## full field text, and the field name below. Prints onto business-card stock
## (Avery 5371, ten cards per US-Letter sheet).
##
## Deck CSV columns:
##   copies  how many of this card to print
##   header  the short value shown large on the card        (e.g. "Tree")
##   footer  the field / deck name shown below the QR       (e.g. "Life Form")
##           leave blank for a comment card (a writable space, no field name)
##   text    the string encoded in the QR code              (e.g. "Life Form: Tree")
##
## The QR encodes the full, self-describing text, so a scan reads finished label
## text directly with no lookup table. The printed value and field name are a
## second, human-readable copy of the same fact: if the QR will not scan, the
## card still reads to the eye.
##
## ---------------------------------------------------------------------------
## TWO SEPARATE GEOMETRY FIXES (2026-07-28)
##
## 1. SHEET ALIGNMENT. The earlier version spread the cards across the whole
##    8.5 x 11 page with gridExtra::marrangeGrob(). That divides the page into
##    ten equal 4.25 x 2.20 cells, which is NOT where the Avery 5371 cards are:
##    the real cards are 3.5 x 2.0 inside a 0.75in side margin and a 0.5in top
##    margin. Content printed up to 0.375in off centre, and the error ran in
##    OPPOSITE directions in the two columns, so no single nudge could fix it.
##    Every card now gets its own viewport at the true Avery position.
##
## 2. BINDING CLEARANCE — the reason the cards did not work in the hand. The
##    deck is bound on the LEFT through a punched hole on a screw post, and the
##    card pivots on it. A stack of cards fanned on that post occludes roughly
##    the left 1.5in of the card underneath. Content centred in the card is
##    geometrically correct and ergonomically wrong: the left edge of a centred
##    QR falls at 1.18in from the card edge, inside the occluded band, so the
##    code is clipped and will not scan.
##
##    `bind_left` reserves that band. All card content is laid out in the clear
##    zone to its right, so the QR is fully exposed with the deck assembled.
##    With the defaults the QR's left edge sits at 1.87in, which is 0.37in
##    beyond the RESERVED BAND. Read that number for what it is: it is
##    clearance against the 1.5in assumption, not against the cover.
##
##    MEASURED ON THE ARTIFACT (2026-07-29, photos/One_deck.jpg, scaled off the
##    card's known 3.5 x 2.0in edges at 621.6 px/in):
##      QR right edge   3.013in from the card's left edge (predicted 3.008) - ok
##      cover reaches   1.804in  -> 0.30in PAST the 1.5in reserve
##      QR left edge    1.930in  -> only 0.127in clear of the actual cover
##      punched hole    0.788in from the card's left edge, 1.016in from the top
##    So the real margin in the hand is ~0.13in, not 0.37in, and the hole sits
##    0.41in further in than `punch_x` below draws it. The deck decodes, but the
##    allowance is a third of what this comment used to imply. `bind_left` was
##    left at 1.5in deliberately (Kim, 2026-07-29): the cards print and read,
##    and widening the band costs QR size. If a deck ever fails to decode with
##    the stack fanned, this is the first number to raise.
##
##    These two are independent. `bind_left` is a fact about the BINDING (where
##    content sits within a card); `x_offset` / `y_offset` are a fact about the
##    PRINTER (where the whole grid lands on the sheet). Keep them separate.
##
## Print with page scaling OFF ("Actual size" / 100%). Scaling to fit is the
## single most common cause of card drift.
## ---------------------------------------------------------------------------
## Dependencies: qrcode, grid (grid ships with R). Nothing else.
## ============================================================================

library(qrcode)   ## qr_code()
library(grid)     ## viewport(), grid.raster(), grid.text(), unit(), gpar()

## --- Sheet geometry ----------------------------------------------------------
## All values in inches. `pitch` is centre-to-centre spacing, which equals the
## card size when the labels butt against each other (as on the 5371).
## Avery 5371 / 8371 / 28877 (US Letter, 2 x 5, 3.5in x 2in business cards):
##   0.75 + 3.5 + 3.5 + 0.75 = 8.5   and   0.5 + 5 x 2 + 0.5 = 11
avery_5371 <- list(
  name        = "Avery 5371 (US Letter, 2 x 5, 3.5in x 2in)",
  page_w      = 8.5,  page_h  = 11,
  n_col       = 2,    n_row   = 5,
  card_w      = 3.5,  card_h  = 2,
  margin_left = 0.75, margin_top = 0.5,
  pitch_x     = 3.5,  pitch_y = 2
)

## --- Binding hardware --------------------------------------------------------
## bind_left : width of the band on the card's left edge reserved for the screw
##             post and the fanned stack above it. Nothing is printed there.
## punch_x   : centre of the punched hole, from the card's left edge (guides only).
##             NOTE: nominal only. The holes in the decks built 2026-07-28 measure
##             0.788in from the card edge (see the MEASURED note above), because a
##             hand punch reaches where it reaches. This value drives the guide
##             sheet, not the layout, so the mismatch is cosmetic - but the guide
##             will not show you where your own punch lands.
## punch_d   : hole diameter (guides only). The screw-post heads measure ~0.39in.
bind_default <- list(bind_left = 1.5, punch_x = 0.375, punch_d = 0.25)

## --- Where each card sits ----------------------------------------------------
## Returns the centre of card (row i, col j) in grid's native coordinates:
## x from the left edge, y from the BOTTOM edge, both in inches.
card_centre <- function(i, j, tmpl, x_offset = 0, y_offset = 0) {
  cx <- tmpl$margin_left + tmpl$card_w / 2 + (j - 1) * tmpl$pitch_x + x_offset
  cy_from_top <- tmpl$margin_top + tmpl$card_h / 2 + (i - 1) * tmpl$pitch_y + y_offset
  list(x = cx, y = tmpl$page_h - cy_from_top)
}

## --- The clear zone on one card ----------------------------------------------
## The printable area right of the binding band: its width, and the x of its
## centre measured from the card's left edge.
clear_zone <- function(card_w, bind_left, pad) {
  w <- card_w - bind_left - pad
  if (w <= 0)
    stop(sprintf("bind_left (%.2fin) leaves no room on a %.2fin card.", bind_left, card_w))
  list(w = w, cx = bind_left + w / 2)
}

## --- Check the template actually closes --------------------------------------
## Catches a mistyped margin or pitch before it costs a sheet of card stock.
check_template <- function(tmpl) {
  used_w <- tmpl$margin_left + (tmpl$n_col - 1) * tmpl$pitch_x + tmpl$card_w
  used_h <- tmpl$margin_top  + (tmpl$n_row - 1) * tmpl$pitch_y + tmpl$card_h
  if (used_w > tmpl$page_w + 1e-9)
    stop(sprintf("Template too wide: needs %.3fin on a %.3fin page.", used_w, tmpl$page_w))
  if (used_h > tmpl$page_h + 1e-9)
    stop(sprintf("Template too tall: needs %.3fin on a %.3fin page.", used_h, tmpl$page_h))
  invisible(TRUE)
}

## --- Is the QR engine producing real, structurally valid QR codes? -----------
## Added 2026-07-28 after a full deck and a sheet of number cards were printed
## from PDFs whose codes were generated by a PLACEHOLDER qr_code() — visually
## convincing, completely unreadable. Nothing in the pipeline noticed: the PDFs
## rendered, the geometry measured correct, the cards printed cleanly, and the
## failure only surfaced when the finished cards were photographed and would
## not decode.
##
## A QR code has a rigid skeleton, so validity is checkable in pure R with no
## scanner and no external tools:
##   - three 7x7 FINDER patterns, at top-left, top-right and bottom-left
##   - TIMING patterns: row 6 and column 6 alternate dark/light between them
##   - a side length of 21 + 4*(version-1) modules
## Random fill with a decorative corner passes none of these.
##
## This runs once per PDF. If it fails, nothing is written — a hard stop is the
## whole point, because the alternative is a stack of printed cards that look
## perfect and carry nothing.
FINDER <- matrix(c(
  1L,1L,1L,1L,1L,1L,1L,
  1L,0L,0L,0L,0L,0L,1L,
  1L,0L,1L,1L,1L,0L,1L,
  1L,0L,1L,1L,1L,0L,1L,
  1L,0L,1L,1L,1L,0L,1L,
  1L,0L,0L,0L,0L,0L,1L,
  1L,1L,1L,1L,1L,1L,1L), nrow = 7, byrow = TRUE)

## qr_code() may or may not return the 4-module quiet zone; strip any all-white
## border so the checks below can assume the code starts at [1, 1].
trim_quiet_zone <- function(m) {
  keep_r <- which(apply(m, 1, any)); keep_c <- which(apply(m, 2, any))
  if (!length(keep_r) || !length(keep_c)) return(m)
  m[min(keep_r):max(keep_r), min(keep_c):max(keep_c), drop = FALSE]
}

validate_qr_engine <- function(sample_text = "Number: KWB 1", ecl = "H") {
  m <- tryCatch(qr_code(sample_text, ecl = ecl),
                error = function(e) stop("qr_code() failed: ", conditionMessage(e),
                                         call. = FALSE))
  m <- trim_quiet_zone(ifelse(as.matrix(m), 1L, 0L))
  n <- nrow(m)

  fail <- function(why) stop(sprintf(paste0(
    "The QR engine is not producing valid QR codes: %s\n",
    "  Nothing has been written. Do NOT print.\n",
    "  Check that the real CRAN `qrcode` package is attached:\n",
    "    packageDescription(\"qrcode\")$Package; packageVersion(\"qrcode\")\n",
    "  (A stub or shadowed qr_code() will render convincing, unreadable cards.)"),
    why), call. = FALSE)

  if (n != ncol(m))            fail(sprintf("matrix is %dx%d, not square.", n, ncol(m)))
  if (n < 21 || (n - 21) %% 4) fail(sprintf("side is %d modules; QR sizes are 21, 25, 29, ...", n))

  corners <- list("top-left"     = m[1:7, 1:7],
                  "top-right"    = m[1:7, (n - 6):n],
                  "bottom-left"  = m[(n - 6):n, 1:7])
  bad <- names(corners)[!vapply(corners, function(x) all(x == FINDER), logical(1))]
  if (length(bad))
    fail(sprintf("missing or malformed finder pattern at %s (a real QR has all three).",
                 paste(bad, collapse = ", ")))

  ## timing patterns: row 6 and column 6, alternating and starting dark
  expect <- rep(c(1L, 0L), length.out = n - 16)
  if (!identical(as.integer(m[7, 9:(n - 8)]), expect) ||
      !identical(as.integer(m[9:(n - 8), 7]), expect))
    fail("timing pattern is wrong (row/column 6 must alternate dark/light).")

  invisible(TRUE)
}

## --- One QR code, drawn as a crisp square in the current viewport ------------
## qr_code() returns a logical matrix, TRUE for the dark modules; map that
## straight to black and white. interpolate = FALSE keeps the modules hard-edged
## (a blurred QR is a QR that will not scan). "snpc" makes it square.
draw_qr <- function(text, ecl = "H") {
  modules <- qr_code(text, ecl = ecl)
  grid.raster(as.raster(ifelse(modules, "black", "white")),
              interpolate = FALSE,
              width = unit(1, "snpc"), height = unit(1, "snpc"))
}

## --- Fit a label to the available width --------------------------------------
## Reserving the binding band narrows the printable zone from 3.26in to 1.88in,
## which is not wide enough for every label already in the decks ("Abundant
## Flowers" and "Scattered Flowers" both run about 2.0in at 18pt). Text width
## scales linearly with point size, so one measurement gives the exact size that
## fits. Shrinking beats wrapping here: the header band is only 0.34in tall, so
## a second line would have to drop to ~10pt, while a single line needs only a
## few per cent off. Returns the size to use, floored at `min_size`.
## `safety` guards the difference between R's text metrics and what the printer
## actually rasterises — measured glyph runs came out ~3 % wider than grobWidth
## reported, enough to nick the binding band at the fitted size.
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

## --- One card, drawn inside its own viewport ---------------------------------
## Value on top, QR in the middle, field name below — all within the clear zone
## right of the binding band. A comment card (blank footer) leaves that band
## empty as a writing space.
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

## --- Guides: card outline, binding band, punch hole, content crosshair -------
## Drawn on request so clearance and alignment can be proved on plain paper
## before spending card stock. Hold the printed sheet over a blank Avery sheet
## against a window: the outlines should sit on the die cuts.
draw_guides <- function(card_w = 3.5, bind_left = 1.5, pad = 0.12,
                        bind = bind_default) {
  zone <- clear_zone(card_w, bind_left, pad)
  grey <- gpar(col = "grey60", fill = NA, lty = "dashed", lwd = 0.5)

  grid.rect(gp = grey)                                   ## the card itself

  ## Binding hardware only where there is a binding. Identity cards run with
  ## bind_left = 0 (loose in a holder), and drawing a post hole through them
  ## would both mislead and collide with the printed number.
  if (bind_left > 0) {
    grid.rect(x = unit(bind_left / 2, "in"),             ## reserved band
              width = unit(bind_left, "in"),
              gp = gpar(col = NA, fill = "grey92"))
    grid.segments(unit(bind_left, "in"), unit(0, "npc"), ## band boundary
                  unit(bind_left, "in"), unit(1, "npc"),
                  gp = gpar(col = "grey55", lty = "dotted", lwd = 0.6))
    grid.circle(x = unit(bind$punch_x, "in"),            ## punched hole
                r = unit(bind$punch_d / 2, "in"),
                gp = gpar(col = "grey45", fill = NA, lwd = 0.6))
    for (d in c(-1, 1)) {                                ## punch crosshair
      grid.segments(unit(bind$punch_x, "in"), unit(0.5, "npc"),
                    unit(bind$punch_x + d * 0.16, "in"), unit(0.5, "npc"),
                    gp = gpar(col = "grey45", lwd = 0.6))
      grid.segments(unit(bind$punch_x, "in"), unit(0.5, "npc"),
                    unit(bind$punch_x, "in"), unit(0.5, "npc") + unit(d * 0.16, "in"),
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

## --- Build a whole deck and write the PDF ------------------------------------
## ecl is the QR error-correction level ("L", "M", "Q", "H"); "H" (~30 %) is the
## most robust, which suits cards that are handled and photographed in the field.
##
## bind_left          reserves the screw-post band on each card's left edge.
## x_offset/y_offset  shift the ENTIRE grid on the sheet, in inches, positive =
##                    right and down. Use these only to cancel a printer's feed
##                    offset measured from a guide sheet.
make_qr_cards <- function(deck_csv, pdf_file, ecl = "H",
                          template = avery_5371,
                          bind_left = bind_default$bind_left,
                          x_offset = 0, y_offset = 0,
                          guides = FALSE, pad = 0.12) {

  validate_qr_engine(ecl = ecl)   ## hard stop before anything is written
  check_template(template)
  zone <- clear_zone(template$card_w, bind_left, pad)

  deck <- utils::read.csv(deck_csv, stringsAsFactors = FALSE,
                          colClasses = "character")
  need <- c("copies", "header", "footer", "text")
  if (!all(need %in% names(deck)))
    stop("Deck CSV needs columns: ", paste(need, collapse = ", "))

  ## repeat each card `copies` times
  copies <- as.integer(deck$copies)
  copies[is.na(copies)] <- 1L
  cards <- deck[rep(seq_len(nrow(deck)), copies), , drop = FALSE]
  if (nrow(cards) == 0L) stop("Deck is empty after applying `copies`.")

  per_page <- template$n_col * template$n_row
  n_pages  <- ceiling(nrow(cards) / per_page)

  pdf(pdf_file, width = template$page_w, height = template$page_h)
  on.exit(dev.off(), add = TRUE)

  ## Warn about labels the clear zone forces smaller — a silent shrink would
  ## let a deck drift out of visual step without anyone noticing.
  shrunk <- unique(deck$header[vapply(deck$header,
              function(h) fit_fontsize(h, zone$w, 18, bold = TRUE) < 18,
              logical(1))])
  if (length(shrunk))
    warning("Headers too wide for the clear zone, shrunk to fit: ",
            paste(shrunk, collapse = ", "),
            ". Consider shorter wording for visual consistency.", call. = FALSE)

  for (p in seq_len(n_pages)) {
    ## Not on the first pass: measuring the headers above already opened page 1,
    ## and an unconditional newpage() here would leave it blank in the PDF.
    if (p > 1) grid.newpage()
    idx <- seq((p - 1) * per_page + 1, min(p * per_page, nrow(cards)))
    for (k in seq_along(idx)) {
      slot <- k - 1L
      i <- slot %/% template$n_col + 1L   ## row, top to bottom
      j <- slot %%  template$n_col + 1L   ## column, left to right
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

  ## The QR is square and sized by the middle band, so its width is the smaller
  ## of the zone width and that band's height; report where its left edge lands.
  qr_side <- min(zone$w, (template$card_h - 2 * pad) * 4 / 6.2)
  message(sprintf(
    "%d cards on %d page(s) -> %s\n  QR %.3fin square, left edge %.3fin from card edge (%.3fin clear of the %.2fin binding band)%s",
    nrow(cards), n_pages, pdf_file, qr_side,
    zone$cx - qr_side / 2, zone$cx - qr_side / 2 - bind_left, bind_left,
    if (x_offset || y_offset)
      sprintf("\n  printer offset %+.3fin x, %+.3fin y", x_offset, y_offset) else ""))
  invisible(pdf_file)
}

## --- Calibration sheet -------------------------------------------------------
## Prints card outlines, the shaded binding band, the punch-hole mark and a
## labelled quarter-inch scale through the clear zone, with no QR codes. Print
## on plain paper at 100 % scale, lay it over an Avery sheet, and read off how
## far the grid has drifted; feed the negative of that as x_offset / y_offset.
## Punch one sheet and mount it on the post to confirm the band is wide enough.
qr_calibration_sheet <- function(pdf_file = "avery_5371_calibration.pdf",
                                 template = avery_5371,
                                 bind_left = bind_default$bind_left,
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

    ## quarter-inch ticks either side of the clear-zone centre
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
    grid.text(sprintf("r%d c%d", i, j),
              x = unit(zone$cx, "in"),
              y = unit(0.5, "npc") - unit(0.22, "in"),
              gp = gpar(fontsize = 7, col = "grey40"))
    popViewport()
  }

  grid.text(sprintf("%s  |  binding band %.2fin  |  offset %+.3fin x, %+.3fin y  |  print at 100%%, no scaling",
                    template$name, bind_left, x_offset, y_offset),
            y = unit(0.22, "in"), gp = gpar(fontsize = 7, col = "grey40"))
  invisible(pdf_file)
}

## --- Example usage (run manually) --------------------------------------------
## 1. Prove clearance and alignment on plain paper first, then punch one and
##    mount it on the post:
##      qr_calibration_sheet("avery_5371_calibration.pdf")
##
## 2. Normal run (binding band defaults to 1.5in):
##      make_qr_cards(deck_csv = "QR_field_notes.csv",
##                    pdf_file = "QR_field_notes_cards.pdf")
##
## 3. If the fanned stack covers more or less than 1.5in, say the label:
##      make_qr_cards("QR_field_notes.csv", "QR_field_notes_cards.pdf",
##                    bind_left = 1.65)
##
## 4. If the grid prints, say, 0.06in left of the die cuts, cancel it:
##      make_qr_cards("QR_field_notes.csv", "QR_field_notes_cards.pdf",
##                    x_offset = 0.06)
##
## Add guides = TRUE to any run to print the outlines alongside the cards.
