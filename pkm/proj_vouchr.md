# PROJECT: vouchr
_Last updated: 2026-07-29 (cont.)_
_Status: Active_
_Focus readiness: Ready (v0.1.0 pushed 2026-07-28; the capture side is proven on real hardware, and the
companion book *Voucher Labels* is LIVE at https://kimbridges-documents.netlify.app/vouchr/ as of 2026-07-29. The binding-clearance
comment correction is **committed and pushed** (`9be8f1c`) -- working tree clean, level with origin. Next release
**0.1.1**: the cluster-numbering documentation + `cluster_label` mapping, specified in `deferred.md`.)_
_Tags: (none yet)_

> **Intake note (2026-07-28).** This file was created late. `vouchr` has existed as a
> public GitHub package since 2026-07-02 and was developed inside the `specimen_labels`
> project, which is where its history lives. Every sibling document+package pair in this
> PKM carries two files (checklists/checklistr, lists/listsr, seasonality/seasonalityr,
> Ceska/coenosr), and Mechanism 1 says a project's first artifact is its proj file — so
> the absence here was a genuine gap of exactly the shape the intake protocol exists to
> prevent. Work before 2026-07-28 is logged in `proj_specimen_labels.md`, not repeated here.

## Type
R package (the companion engine to the **specimen_labels** field-capture document;
sibling to whittakerr / listsr / coenosr / seasonalityr / checklistr).

## Objective
Package the field-capture toolkit so the document can be written against
`library(vouchr)` and others can reuse it: printable QR-card decks and
collection-number cards, derivation of fixed site variables from a photograph's GPS
coordinate, empirical discovery of what a discipline's decks should hold, and the
assembler that turns one photograph into a herbarium label plus a field-log row with
no transcription.

## Current Status
**v0.1.0 pushed 2026-07-28** — commit `0ad01e1`, 18 files, +1141/-96. `devtools::document()`,
`test()` and `check()` all run clean on Kim's machine (**0 errors / 0 warnings / 1 note** —
the benign "unable to verify current time"). **LIVE at github.com/kimbridges/vouchr**
(`remotes::install_github("kimbridges/vouchr")`).

**This release is the capture side, rebuilt after printing real cards and handling them.**
The 0.0.0.9000 card maker had two defects that only physical cards could reveal:
- **Sheet alignment.** `gridExtra::marrangeGrob()` divided the page into ten equal
  4.25x2.20 cells; real Avery 5371 cards are 3.5x2.0 inside a 0.75in side margin, so
  content printed up to **0.375in off centre, in OPPOSITE directions per column** — no
  single nudge could have fixed it. Cards now sit in per-card viewports at true positions
  (measured on the rendered PDF at 2.4999 / 5.9999in against a 2.500 / 6.000in spec).
- **Binding clearance.** An observation deck pivots on a left screw post, and the fanned
  stack occludes ~1.5in of the card beneath, clipping a centred QR. **`bind_left`** reserves
  that band; the QR's left edge now sits 1.872in in, **0.372in clear**.

**Verified end to end:** six QR cards in a single phone photo all decode, and assemble into
a herbarium label and a field-log row with no transcription anywhere in the chain.

## Key Files
- `R/make_qr_cards.R` — the sheet geometry (`avery_5371`, `card_centre()`, `clear_zone()`,
  `check_template()`), `make_qr_cards()`, `qr_calibration_sheet()`, and the QR structural
  validator (`validate_qr_engine()` / `check_qr_matrix()`).
- `R/make_number_cards.R` — `make_number_cards()` plus the issued-number ledger
  (`read_ledger()`, `check_ledger()`, internal).
- `R/reader_assembler.R` — `parse_cards()`, `assemble_record()`, `make_label()`,
  `make_log_row()`, `read_capture()`, `read_photo()`, and the decode/EXIF adapters.
- `R/site_extract.R` — the derive engine (terrain, substrate, place from a coordinate).
- `R/deck_discovery.R` — `discover_decks()` and the collector-signature machinery.
- `inst/extdata/QR_field_notes.csv` — an **example** deck (deliberately not a standard).
- `tests/testthat/test-core.R` — 21 tests: geometry, validator, ledger, identity fields,
  deck clustering, assembler projections.
- **25 exported functions**; MIT licensed; roxygen docs complete (26 `.Rd`).

## Design decisions worth keeping
- **`bind_left` and `x_offset`/`y_offset` are kept separate on purpose.** One is a fact
  about the BINDING (where content sits within a card); the other is a fact about the
  PRINTER (where the grid lands on the sheet). Merging them into one "shift" would hide
  both causes.
- **Identity cards reserve no binding band.** They live loose in a business-card holder
  because you detach them onto a specimen, so the number sits BESIDE the code and the QR
  runs the full card height — 1.76in square, ~2.4x a deck card's area. This is the
  graceful-degradation floor: the one card that must scan.
- **`determined_by` is a first-class field, not an observation** (Kim, 2026-07-28). An
  observation records what the collector SAW; a determination records WHO ASSERTED the
  identification, carries an authority, and can be revised later without disturbing
  anything observed in the field.
- **Collector aliases over reprinting.** The decks print `"Collected by: ..."`; rather than
  reprint physical cards to match the code, `assemble_record()` accepts every spelling.
- **`validate_qr_engine()` refuses to write a PDF unless the codes are structurally valid**
  — see Finding 020. A placeholder generator once produced convincing, unreadable cards
  that passed every geometric check and were printed, assembled and photographed before
  anyone noticed. A structural check is cheap; a wasted field day is not.
- **Card making needs only `qrcode` + `grid`.** The rewrite dropped `gridExtra`, `readr`,
  `tidyr` and `purrr` — all four were used solely by the old card maker.

## Locations
- Package: `G:\My Drive\Projects\vouchr\` (git repo, default branch `main`).
- GitHub: **https://github.com/kimbridges/vouchr** (public, MIT).
- Working scripts it is kept in step with: `G:\My Drive\Projects\specimen_labels\`
  (`make_qr_cards.R`, `make_number_cards.R`, `reader_assembler.R`, `site_extract.R`,
  `deck_discovery.R`). **These are currently duplicated**; see Next Steps 1.

## Related Projects
> **Naming (decided 2026-07-28).** The package is `vouchr`; the project folder, PKM file and book are
> `specimen_labels`. Unlike every sibling pair (checklists/checklistr, lists/listsr,
> seasonality/seasonalityr) these share no stem. **That is deliberate, not an oversight** — a rename was
> considered and declined, since 68 of 101 references live in archived text that stays verbatim. The
> book's own title is still open and deferred to the read-through; `_quarto.yml`'s `title: "vouchr"` is a
> placeholder. See the "Note on the name" block in `proj_specimen_labels.md`.

- **specimen_labels** — the document + exploration this package serves; its
  `proj_specimen_labels.md` holds the concept, the deck design, and all history before
  2026-07-28.
- **checklistr / whittakerr / listsr / coenosr / seasonalityr** — sibling document+package
  pairs following the same pattern.
- **briefing_book** — the umbrella over the field-botany cluster; vouchr's `site_extract`
  and `deck_discovery` feed its reports.

## Next Steps
1. **Resolve the duplication.** The card makers and reader now exist both in
   `Projects\specimen_labels\` and in the package. Decide which is canonical (the package,
   presumably) and make the project folder consume `library(vouchr)` rather than keep
   parallel copies that can drift.
2. **Documentation reconciliation** — the `specimen_labels` book chapters describe the card
   makers; they must match the upgraded printing (binding clearance is a design finding, not
   just a bug fix).
3. **A vignette**, once the document settles — the package currently has none.
4. **Seed the number ledger** from Kim's historical KWB series; it knows only what it has
   issued itself.
5. Rotate the hardcoded Google key in the old `QR_procedures.Rmd` before any of that
   prototype migrates in.

## Collaborators / Dependencies
Imports: qrcode, grid, grDevices, stats, utils. Suggests (feature-gated at call time):
terra, elevatr, sf, geosphere, httr, jsonlite, reticulate, exiftoolr, soilDB, rgbif,
ggplot2, scales, dplyr, testthat. SystemRequirements: exiftool; Python with
opencv-python + pyzbar via reticulate.

## Blockers
None.

---
## Log

### 2026-07-29 (cont.) -- comment correction committed and pushed; the book is live

The binding-clearance correction is no longer sitting uncommitted. Verified before committing that it was **comments only** -- 23 added lines, none of them code, no removals -- then committed as `9be8f1c` and pushed. Working tree clean, level with origin. The hazard was never functional; it was that a dirty working tree is one stray `git checkout .` from losing a correction to a number that had already misled us once.

The companion document **Voucher Labels** went live the same day at https://kimbridges-documents.netlify.app/vouchr/, with the Appendix documenting all 25 exports (checked mechanically against `NAMESPACE`) and five live worked examples exercising `make_qr_cards`, `site_extract`, `read_photo`, a folder pass and `discover_decks`.

**★ Queued for 0.1.1, and it is a real defect worth stating precisely.** `discover_decks()` returns `$clusters` straight from `cutree()` -- arbitrary integers -- while the heatmap re-ranks clusters by signature richness (`R/deck_discovery.R` L109-110, "order clusters, richest first"). Both are labelled "Cluster N" and they disagree for two of four archetypes, so reading a label off the figure and then indexing `$profiles` gives a silently wrong answer. **Nothing miscomputes** -- the plot ordering is a deliberate and good choice -- the defect is that two schemes share one name and nothing says so, in the flagship function of a book about not trusting plausible-looking results. **Additive fix only:** a line in the Rd, a `cluster_label` element so figure and object can be joined, and a test asserting they agree. **Do not renumber `$clusters`** -- that changes returned values and breaks existing code and saved analyses. Full entry in `deferred.md`.

### 2026-07-29 (the clearance figures corrected against the artifact — comments only)

The `specimen_labels` documentation pass measured the assembled deck instead of trusting the layout, and
the number the package carried in its header comment turned out to describe the wrong thing.

Measured off `One_deck.jpg`, scaled by the card's known 3.5 × 2.0in edges (621.6 px/in, agreeing on both
axes to 0.2 %): the QR's right edge lands at **3.013in** against 3.008in predicted, so the layout is
right. But the cover's occluding edge sits at **1.804in** — **0.30in past the 1.5in `bind_left`
reserve** — and the QR cleared it by **0.127in, not the 0.372in the comment claimed**. The 0.372in was
always clearance against the *assumption*. The punched hole measures **0.788in** from the card edge where
`punch_x` draws 0.375in, and the screw-post heads run ~0.39in against `punch_d`'s 0.25in; those two drive
the guide sheet, not the layout, so they are harmless in the code and misleading on paper.

**No code changed.** `bind_left` deliberately stays at 1.5in (Kim, 2026-07-29): the decks print and
decode at that margin — the measured frame reads `Phenology: No Flowers` — and widening the band costs QR
size. `bind_left` is now named in the header as the first number to raise if a deck ever fails to decode
with the stack fanned.

**★ The rule added, one level past `validate_qr_engine()`'s lesson: a verified number must name what it
was measured AGAINST.** "0.372in clear" and "0.127in clear" are both true of the same deck, and only one
of them is about the object. `validate_qr_engine()` exists because the pipeline could not tell a real
artifact from a plausible-looking one; this is the same failure in a measurement rather than in a code.

Also confirmed while auditing: `inst/extdata/QR_field_notes.csv` is the deck Kim actually printed and
photographed, and every payload decoded from `Example_1.jpg` appears in it. The three deck-discovery
outputs in `specimen_labels/decks/` were never printed. The package ships the right example.

**Uncommitted.** The comment correction is on disk and not yet committed; v0.1.0 is pushed.

### 2026-07-28 (v0.1.0 — the capture side rebuilt and pushed)
Ported the day's rewritten card makers and reader into the package. `make_qr_cards()`
replaced wholesale (true Avery geometry, `bind_left`, printer offsets, guides, header
auto-shrink); `make_number_cards()` + ledger added; `qr_calibration_sheet()` and
`validate_qr_engine()` added; `assemble_record()` gained collector aliases and
first-class `determined_by`. Imports 6 -> 5 with the four heavy deps dropped;
`grDevices`/`stats`/`utils` declared (they had been imported without being declared).
Exports 21 -> 25. Tests 8 -> 21.

**A bug found by writing a test that was expected to pass:** `check_template()` accepted
a 4in card on a 3.5in pitch — neighbouring cards would overlap and print on top of each
other while the sheet-extent check passed happily, since 0.75 + 3.5 + 4 = 8.25 still fits
inside 8.5. Explicit pitch-overlap checks added in both axes.

**Verification split honestly.** The cloud sandbox has no CRAN, so `R CMD check`, roxygen
and testthat ran on Kim's machine (0/0/1). What the sandbox *could* verify, it did: every
file parses; 22 assertions over geometry, validator, ledger and identity fields; and both
PDFs rendered *through the package code* decode at 300 dpi — **16/16 deck codes, 10/10
number codes**. NAMESPACE was hand-written to match roxygen and proved identical to what
`document()` later generated.

**Pushed** as `0ad01e1`, 2026-07-28 19:51 -1000. Confirmed against the remote: all nine
source files byte-identical to what was delivered, all four new `.Rd` present, no stale
arguments left in `man/make_qr_cards.Rd`, all 26 `.Rd` documenting functions that exist,
and no stray PDFs, ledgers or `.Rhistory` in the tree.
