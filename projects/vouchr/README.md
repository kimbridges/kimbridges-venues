# vouchr

**One field photo of QR-coded cards → a herbarium label + a field-log row, with no transcription.**

`vouchr` is a field-capture toolkit for botanical collecting. Photograph a specimen
with a small deck of QR-coded cards at the moment of collection, and one act yields
two co-equal products that cannot disagree — because they are two views of the same
record: a **herbarium specimen label** and an **archivable field-log row**.

The design rests on a *derive-vs-observe* partition. Fixed environmental variables
(elevation, slope, aspect, roughness, drainage, bedrock, soil, place) are **derived**
from the photograph's GPS coordinate using open, keyless data sources — never carded,
so they never compete for attention in the field. Only the things that must be
**observed at the plant** (phenology, phenotype, community, disturbance) ride on the
QR cards. Which cards a discipline actually needs can itself be *discovered* from
aggregated herbarium records.

## The four pieces

- **Capture** — `make_qr_cards()` turns a deck CSV into a printable PDF of QR cards,
  and `make_number_cards()` builds the collection-number identity cards. Both lay out
  at true `avery_5371` positions; `qr_calibration_sheet()` proves the alignment on plain
  paper before you spend card stock.
- **Derive** — `site_extract()`, `site_substrate()`, `site_place()` compute fixed
  site variables from a coordinate.
- **Discover** — `discover_decks()` finds candidate deck archetypes from herbarium
  records (the deliverable is the *method*, not a fixed deck list).
- **Assemble** — `read_capture()` / `read_photo()` turn cards + coordinate + time
  into one record, then project the label and the log row.


## Printing cards that actually work

Two things are easy to get wrong, and both cost a print run to discover.

**Alignment.** Cards are placed at true Avery 5371 positions (3.5 × 2 in inside a
0.75 in side margin), not spread evenly across the page. Print at **100% / "Actual
size"** — scaling to fit is the commonest cause of drift. If your printer has a feed
offset, measure it with `qr_calibration_sheet()` and cancel it with `x_offset` /
`y_offset`. Those are printer facts; keep them separate from `bind_left`, which is a
fact about the binding.

**Binding clearance.** An observation deck pivots on a screw post through a punched
hole, and a stack of cards fanned on that post hides roughly the left 1.5 in of the
card beneath — clipping a centred QR so it will not scan. `bind_left` (default 1.5)
reserves that band. Identity cards are the exception: they live loose in a
business-card holder because you detach them onto a specimen, so `make_number_cards()`
uses the full card width and sets the number beside the code, which lets the QR run
the full card height (1.76 in square, ~2.4× the area of a deck card's code). It is the
one card that must scan when nothing else gets photographed.

**Before you print,** `make_qr_cards()` and `make_number_cards()` call
`validate_qr_engine()`, which checks the QR skeleton — three finder patterns, timing
rows, a legal module count — and refuses to write a file if it fails. This exists
because a placeholder QR generator once produced convincing, unreadable cards that
passed every geometric check and were printed, assembled and photographed before
anyone noticed. A structural check is cheap; a wasted field day is not.

**Collection numbers.** `make_number_cards()` records every issued number in a ledger
CSV and refuses to reissue one. A collection number used twice cannot be repaired
afterwards: two specimens, one key, and no way to tell which photograph belongs to
which sheet.

```r
deck <- system.file("extdata", "QR_field_notes.csv", package = "vouchr")
qr_calibration_sheet("calibration.pdf")            # check on plain paper first
make_qr_cards(deck, "field_notes_cards.pdf")       # observation decks
make_number_cards("KWB_1243.pdf", prefix = "KWB", start = 1243, n = 10)
```

An example deck ships with the package as `inst/extdata/QR_field_notes.csv`. It is an
*example*, not a standard — which cards a collection needs depends on its purpose.


## Install

```r
# install.packages("remotes")
remotes::install_github("kimbridges/vouchr")
```

Only the card-making dependencies are required. The Derive, Discover, and
photo-reading features rely on `Suggests` packages (terra, elevatr, sf, rgbif,
ggplot2, reticulate, exiftoolr, soilDB, …); each function checks for what it needs
at call time. Photo decoding additionally needs the external `exiftool` and Python
`opencv-python` + `pyzbar` (via `reticulate`). The legacy Google DEM source needs a
billed key in `GGMAP_GOOGLE_API_KEY`; the default `"aws"` source is free and keyless.

## Quick example

```r
library(vouchr)

# cards + coordinate + time -> record, label, and log row
cap <- read_capture(
  c("Number: KWB 1324", "Collectors: K.W. Bridges",
    "Life Form: Tree", "Phenology: Flowering", "Flower Color: Red"),
  lat = 19.435731, lon = -155.336334, datetime = "2026-07-01 10:15",
  place = "Kilauea, Hawaii Island", derive = FALSE)

cat(cap$label)
str(cap$log_row)

# combine a trip's log rows (observed fields vary per specimen)
# log <- dplyr::bind_rows(row1, row2, row3)
```

## Status

Version 0.1.0 (working name; may be renamed).

The capture side has now been exercised end to end on real hardware: decks printed on
Avery 5371, punched and mounted on screw posts, photographed with a phone, and decoded
— **six QR cards in a single frame, all read**, then assembled into a herbarium label
and a field-log row with no transcription anywhere in the chain.

## License

MIT © 2026 Kim Bridges
