# PROJECT: specimen_labels

_Last updated: 2026-07-29_
_Status: Complete_
_Focus readiness: Not applicable (**PUBLISHED 2026-07-29** at https://kimbridges-documents.netlify.app/vouchr/ -- the book is out and the
package is public. Per the briefing_book precedent, a pending colleague review does not hold a deployed project
Active. All remaining work is non-urgent or conditional and lives in `deferred.md` under Mechanism 6.)_
_Tags: (none yet)_
_Log: logs/proj_specimen_labels_log.md

> **Note on the name.** "specimen_labels" is the folder name and undersells the project. What this
> actually is, is a **field-capture system with two co-equal products** (the herbarium label *and* the
> field log). A broader name is wanted — to be chosen (the package, in the whittakerr/seasonalityr
> pattern, will need a `*r` name).
>
> **DECIDED 2026-07-28 (Kim) — both halves deliberately left as they are.** The package half settled as
> **`vouchr`**; the folder, the PKM file and the book title do NOT match it, and that mismatch is now a
> recorded choice rather than an oversight. **Folder/PKM name stays `specimen_labels`** — a rename would
> touch 33 live references and 12 filesystem paths, and could never be complete anyway: 68 of the 101
> references sit in archived `session_log.md` entries and `logs/focus_history.md`, which stay verbatim.
> The cross-links carry the load instead (Locations below names the repo; `proj_vouchr.md` points back).
> **Book title deferred to the read-through** — titles settle last. Note for whoever writes it: every
> sibling pair shares a stem (checklists/checklistr, lists/listsr) and gives the BOOK its own title
> rather than the package's — `checklistr`'s book is *A Checklist Is an Argument*. `_quarto.yml`
> currently reads `title: "vouchr"`, which is a placeholder, not a decision.

## Type
R exploration → intended R package + Quarto document (the whittakerr / listsr / coenosr / seasonalityr
pattern). Domain: botanical specimen collection / herbarium workflow / field data capture. Currently a
2020 prototype (a multi-chunk R Markdown toolbox) plus a demonstration image.

## Objective
Capture specimen-collection data **by photograph, at the moment of collection**, using QR-coded cards, so
that **one small field act** (photograph a few cards, keyed by the specimen's collection number, with the specimen already bagged) does essentially all the
work and yields **two co-equal products with no transcription**: (1) the **herbarium specimen label**
(per specimen, bound for the sheet) and (2) an **archivable field log / collection record** (per trip).
The category data is encoded on **modular, discipline-specific decks of QR cards** — the controlled
vocabularies are the project's creative heart.

## The spine (concept conversation, 2026-06-29)

**The problem it attacks.** Botanists love to collect, but turning field notes into specimen labels is
**often delayed by months or years, and data are lost in the gap**. In the field, capturing everything
one would like is hard — time is short and conditions are poor. Separately, the **field log** itself is
systematically lost: herbaria hold beautifully labeled sheets but, asked "do you have the field log for
these?", too often return a blank stare. We *train* students to "take good notes," yet the notes die in
notebooks because **transcribing scribbles is friction high enough to defeat the intent** (Kim: if a
finished field log is easy to produce he donates it to the herbarium library; if it means transcribing
scribbles, he won't). The lost log is a **structural** failure, not a motivation failure — fix the
structure and the log survives by default.

**The strategy.** A durable QR card carrying a **unique collector ID + number** (a single field, e.g.
`KWB01324`), printed on **business-card stock** (Avery 5371), hole-punched, strung, and **attached to the
specimen**. The collector then **photographs the specimen together with the card(s)** using a cell phone.
The **photograph is the field record**: the cell phone stamps **GPS + time** into EXIF, so the specimen is
georeferenced and dated with zero hand-entry.

**The supplemental decks (the creative heart).** Beyond the collection-number card, a collector carries
**additional decks of QR cards that are controlled vocabularies** — e.g. a card per **phenological state**,
a card per **size class**, etc. You lay down the ones that apply and **photograph them together** with the
specimen and the ID card. Each card is a **clean categorical datum** with no handwriting and no ambiguity.
The decks are **modular by discipline**: a systematist's set differs from an ecologist's set; you carry the
decks relevant to your work. "Record the phenology" becomes "put the flowering card in the shot." This is
objectivity-by-method made physical, and an instrument-and-scale move (each deck is a categorical
framework; photographing a card is assigning a category).

**The technical validation that unlocks the decks (Kim, 2026-06-29).** The reason the demo image
(`img_with_two_QR.jpg`) carries **two** QR codes was to test whether a QR reader could extract **each of
them from a single photograph**. **The answer is yes.** That result is the key to the supplemental-deck
idea: because multiple codes in one frame all decode, a single photo can carry the ID card plus several
category cards at once.

**Two co-equal products.** (1) The **specimen label** is the per-specimen view, bound for the herbarium
sheet. (2) The **field log** is the per-trip view — what was collected, where, when, in what order, under
what conditions — and it is **co-equal**, not a nice-to-have. The current "write the label up later"
workflow throws the log away; this system preserves it. (Provenance — the chain from the act of collecting
to the sheet — is exactly what herbaria lack for much material, and the field is digitizing and
georeferencing hard right now, so an archivable field log is timely, not merely convenient.)

**The architecture: capture once, project two views.** One photograph → **one structured record**:
`{ collection_number, [category codes], lat, lon, datetime, derived: place / elevation / terrain, photo
filename }`. The **label** is the view of a single record; the **log** is the view of all records ordered
in time and space. Both products are just queries over the same captured table, so they **can never
disagree** — a built-in honesty.

**Verification, at the cheapest moment.** Each card already prints the **human-readable number above the
QR** — a redundant representation that is field-readable without a scanner *and* a built-in check (two
representations of the same fact that must agree). With widespread cell coverage, the system could
**show the decoded label content in the field**, so a card that didn't decode, a GPS that didn't lock, or
a forgotten category card is caught at the specimen (seconds to fix) rather than at home (a return trip).
This moves a little of the "reader" out of the lab and into the field; worth designing toward even if it
lands later.

## What exists now
- **`QR_procedures.Rmd`** (2020, prototype) — a "run one chunk at a time" toolbox, not a linear document.
  Capabilities: *QR-Collector* (collector-ID label PDFs for business-card stock); *QR-Species* (per-species
  sheets with a species-name QR + Family/code/common-names/stature/distribution from `Checklist.csv`);
  *Image-File-Listing*; *Photo-EXIF* (GPS + datetime + reverse-geocode to place name); *Elevation / Slope /
  Aspect* (a 3×3 Google-elevation grid → slope, aspect, TRI, flow direction, site-info table); *Mapping*
  (Google satellite/hybrid static maps); *QR-Scan* (ZBar `zbarimg`) + *XML-Decode* (parse ZBar XML →
  filename + code).
- **`img_with_two_QR.jpg`** — demo: two QR codes overlaid on a (wet, tree-lined, Tokyo-looking) avenue,
  labeled "Owner / text" and "Manual URL / web" — the early experiment in *what to encode* and the
  two-codes-in-one-photo test that validated the deck idea.

### Built / added this session (2026-06-29)
- **`QR_label_maker.qmd`** (Kim's, added this session) — the **modernized collector-ID maker**: already uses the
  current `qrcode` API (`plot(qr_code(code, ecl="M"))`), supersedes the old *QR-Collector* chunk. The "needs
  modernizing" caveat is really about `QR_procedures.Rmd` only.
- **`QR_field_notes.csv`** (Kim's test deck, added + cleaned this session) — the **deck-definition format**:
  columns `copies, header, footer, text`. Each row is a card; the QR payload is the **full self-describing
  text** (`Life Form: Tree`), `header` is the short value shown large, `footer` is the field name. Decks present:
  Collectors, Determined by, **Life Form** (Tree/Shrub/Herb/Epiphyte), **Abundance** (Dominant/Common/Occasional/
  Rare), **Phenology** (flowering states), and **Comment** (1/2/3 — the free-text escape: a writable card,
  blank footer, photographed and transcribed later). Fixed one typo ("Occassional"→"Occasional").
- **`make_qr_cards.R`** (built this session, clean rewrite) — the **deck-driven maker**. Three small functions:
  `qr_grob()` (QR → crisp square raster, no temp-PNG litter), `card_grob()` (value / QR / field; comment cards
  get a blank writing space), `make_qr_cards()` (read deck CSV → repeat by `copies` → 2×5 cards per page →
  multi-page PDF). Error correction **`ecl="H"`** (~30%, robust for field-handled cards). Verified live in
  RStudio; produced **`QR_field_notes_cards.pdf`** (16 cards, 2 pages). Required installing **`qrcode` 0.3.0**
  into Kim's R 4.3.3 (it wasn't on this machine's library path — why the prototype wouldn't run here).

**Encoding scheme — settled (by Kim's own prototype, confirmed this session).** The QR carries
**`<Field>: <value>`** as readable text, so a scan yields finished label text with **no codebook**. The phrases
are short enough (~15–30 chars) to encode in full *and* still run high error correction, so the short-token +
lookup-table machinery is **only** needed if a deck's values get long. The card itself is a redundancy: **header +
footer + QR are three copies of the same fact**, so a card that won't scan still reads "Tree / Life Form" to the
eye — the same graceful-degradation principle as the collection photo's three independent layers (printed number,
QR, EXIF location). Each `<Field>:` prefix also namespaces the codes so the reader can sort an ID card from
category cards in one photo.

### Known issues with the prototype (before any sharing)
- **SECURITY: a Google Maps API key is hard-coded in plaintext (two places).** Must be **rotated and moved
  to an env var / key file** before this goes near GitHub.
- **Five years of dependency drift**: `qrcode` has a new API, `raster` → `terra`, `ggmap` / Google Static
  Maps changed. Will not run end-to-end today without a modernization pass.
- **Mixed concerns + dead code**: label-making, EXIF, terrain, and scanning are bundled; several abandoned
  sections ("THIS IS NOT USED", "Doesn't Like KEY") and duplicated aspect calcs.

## Locations
- Code + assets: `G:\My Drive\Projects\specimen_labels\` — `QR_procedures.Rmd` (2020 prototype),
  `make_qr_cards.R` + `QR_field_notes.csv` (deck maker; **rewritten 2026-07-28** to true Avery 5371
  geometry + `bind_left` binding clearance; base R + `grid` + `qrcode` only),
  **`make_number_cards.R`** (identity/collection-number cards, new 2026-07-28),
  **`number_cards_ledger.csv`** (issued-number guard), `avery_5371_calibration.pdf` (alignment +
  clearance proof sheet), `KWB_1243_1252.pdf`, **`site_extract.R`** (cleaned/verified terrain "derive"
  engine), `Site_Extract.pdf` (its reference output), `img_with_two_QR.jpg`, `design_notes.md`,
  `label_survey\` (Track B data + notes), and **`literature\`** (5 reference PDFs).
- GitHub: **`vouchr` LIVE at https://github.com/kimbridges/vouchr** (public, default branch `main`; pushed 2026-07-02). Install: `remotes::install_github("kimbridges/vouchr")`.

## Related Projects
- **timelinesr / Photo Locations** — the field log is a structured cousin of the trip-log / photo-location
  work (georeferenced, time-ordered, annotated). Lean on this rather than rebuild.
- **gePoints / geContour** — the terrain/elevation/slope sub-system overlaps; decide whether terrain is
  in-scope enrichment or factored out to existing tools.
- **whittakerr / listsr / coenosr / seasonalityr** — the package + Quarto-document deliverable pattern this
  would likely follow.

## Open Questions
1. ~~**Project name** — "specimen_labels" undersells it; a system name + a `*r` package name are wanted.~~
   **RESOLVED 2026-07-28:** package = `vouchr` (published); folder/PKM name stays `specimen_labels` by
   decision; **book title deferred to the read-through** (production-pass item 5). See the Note on the
   name above for the reasoning and the cost figures.
2. **The decks (the heart)** — which disciplines/decks first; what categories each holds; the **encoding /
   namespacing scheme** so one photo's codes are unambiguous (e.g. `ID:KWB01324` vs `PHEN:flowering` vs
   `SIZE:...`). Small but load-bearing.
3. **Terrain scope** — RESOLVED in principle (2026-06-30): terrain is **derived, not carded**. Kim's
   `Site_Extract` already computes elevation / relief / slope / aspect / TRI / drainage from name + lat-long;
   it is the "derive" engine of the derive-vs-observe partition (see 2026-06-30 log). Remaining: locate that
   code and settle its relation to gePoints/geContour.
4. **In-field vs lab split** — how much decoding/verification runs on the phone in the field.
5. **The record schema** — the one structured record per photo that both products are views of.
6. **Deliverable shape** — package + Quarto document (likely), with the lost-field-log story as the spine.

## Next Steps
1. **★ Collector-signature decks (the next analytical move)** — derive the deck archetypes empirically by
   grouping real records by collector (+ location) and clustering their field fill-signatures, on a
   full-Darwin-Core `rgbif` pull **limited to ~the last 40 years** (catches ecological studies without
   being swamped by older taxonomic collecting). The empirical answer to "how many decks / what's on each."
   See design_notes "Open / next" and the 2026-06-30 cont. 5 log. *(Future, out of scope: date as its own
   axis — how recorded data-types transitioned through the decades.)*
2. **Re-add the two map figures** (locality + satellite) to `site_extract.R` — separate task.
3. **Shrunk deck list** — the observe-only column from the derive-vs-observe partition.
4. **Reader / assembler** — photo → decode all cards + read EXIF → one label row + one field-log row.
5. Still open from the prototype: rotate the **hardcoded Google key in `QR_procedures.Rmd`** before it
   touches GitHub; ~~precise **Avery-5371** alignment for the card maker~~ **DONE 2026-07-28** (true card
   geometry + a printer-calibration offset + a proof sheet; cards printed correctly); a minimal
   end-to-end demo.
6. **★ NEW (2026-07-28, Kim's stated next task) — reconcile code and documentation with the upgraded
   printing.** Fold `make_qr_cards.R` + `make_number_cards.R` into **`vouchr`** (now base R + `grid` +
   `qrcode` only, so they are package-ready), and re-read the documentation chapters that describe card
   making: the **binding-clearance constraint is a design finding**, not just a bug fix — a physical
   affordance (the screw post) reaching back into the layout — and the book's "caption as door"
   convention gives it somewhere to go.
7. **Seed the number ledger** from the historical KWB series. `number_cards_ledger.csv` currently knows
   only 1243–1252 and would not catch a clash with anything collected earlier.

8. **★ DOCUMENTATION DIRECTIVE (Kim, 2026-07-28) — elevate "you do not start from a blank slate" to a
   BOOK-level claim.** Kim calls it "an important discovery in this project." Checked first: the argument
   already exists and is well made — `decks.qmd` withholds the decks on purpose ("Handing you my decks
   would be handing you a destination. The path is worth more"), and `discovering-decks.qmd` delivers the
   empirical method. **The gap is emphasis and placement, not argument:** it reads as a chapter payoff
   rather than a headline claim; two chapters (`derive.qmd`) separate the promise from its delivery; and
   the idea has no NAME, so it cannot travel the way "capture once, project two views" does. Actions:
   surface it in `index.qmd` beside no-transcription and the co-equal field log; name it and use the name
   in both chapters; consider reordering or strengthening the forward pointer; and frame it as a
   DISCOVERY — it was not obvious at the outset that "what should the cards say?" had a non-arbitrary,
   empirically recoverable answer. **Why it matters:** the non-prescriptive stance is the system's
   greatest strength AND its greatest adoption risk, and an answer that arrives two chapters late does
   not answer the objection. Full directive in `design_notes.md`.

## Collaborators / Dependencies
None yet. (Herbaria are the eventual audience / beneficiaries.) External: ZBar, exiftool, a maps/elevation
API.

## Blockers
None (pre-direction by choice — concept first, then decide scope).


---
## Log

The dated log for this project lives in `logs/proj_specimen_labels_log.md`. Verbatim and unedited.
New entries go there, not here. (Split 2026-07-30 by pkm_health.R)
