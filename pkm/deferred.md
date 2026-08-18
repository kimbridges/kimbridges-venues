# Deferred Work

_Created 2026-07-29. Mechanism 6 of the PKM Operating Protocol — see `pkm_protocol.md`._

Items that are real, that nobody should forget, and that there is no reason to act
on yet. They live here instead of in a project's Next Steps so that a finished
project can stop looking unfinished, and so that Next Steps keeps meaning *the
work in front of us*.

## How this file is used

**The trigger is the mechanism, not the list.** A deferred item is worthless
unless something guarantees it gets read at the moment it becomes cheap to do. So:
**when a session opens a project for real work, it reads that project's section
here first, before touching anything.** Session-start (Mechanism 2) loads the
system; this loads the project. Without that rule this file becomes a write-only
archive, which is worse than no file, because it launders the guilt of not doing
the thing.

**Two kinds of entry, kept apart on purpose.**

- **TASK** — something to do when there is already a reason to touch the project:
  the next revision, the next release, the next render. It waits for an occasion.
- **CONDITIONAL** — not a task at all. It surfaces only if a named thing happens,
  and its whole value is arriving at the bad moment with the answer already
  written. Filed among the tasks it would be buried, and the bad moment is exactly
  when nobody reads a long list.

**Item shape.** What, where, why it was deferred, and who raised it, dated.
Attribution is not bookkeeping: when a colleague asks whether their note landed,
the answer should be *yes, and here it is*.

**Two rules.**

1. An item may be closed as **WON'T DO**, with the reason kept rather than
   deleted. A list that only grows is a list that dies. (The same discipline as
   Findings 001/005/013/015, queued to collapse into one statement instead of
   accumulating four partial ones.)
2. **Deferred must mean "no occasion yet", never "unpleasant."** The hardcoded
   Google key sat as an open item for weeks and that was not for want of an
   occasion. A file like this makes that failure mode easier to commit, so the
   rule is written where it will be read.

**Review points.** Whenever a project's Status changes, and at the end-of-session
checklist (Mechanism 5, item 8). If a project's section here grows long enough to
be unwieldy, split it to `deferred/<name>.md` and leave a pointer — the same growth
path the per-project logs took to `logs/` on 2026-07-28.

---

## specimen_labels / *Voucher Labels*

Published 2026-07-29 at kimbridges-documents.netlify.app/vouchr/.

**TASK — Split the log to `logs/proj_specimen_labels_log.md`.**
`proj_specimen_labels.md` is ~150 KB with its dated log still in-file, while
proj_PKM, whittakerr, AI_Microscope and briefing_book all moved theirs on
2026-07-28 with a `_Log:` pointer. It is the largest proj file in the system and
the one that skipped the split. *Deferred:* Kim's call — "the split comes when
we're actually finished" (2026-07-29). *Occasion:* the next substantive edit to
that file.

**TASK — Tone pass on the three honest-provenance disclosures.**
The bench-run admission in `closing-the-loop.qmd`, the no-permit candidate sites
in `field-log.qmd`, and the derived-versus-checked canopy pair. Each is
individually right and together they are the book's integrity on display; read in
sequence they could start to sound apologetic. The fix, if it reads that way, is
to vary the register — **not** to remove the disclosures. *Raised by Claude,
2026-07-29.* *Occasion:* the next revision, ideally after a colleague read.

**TASK — Confirm or correct the cover-translucency reading.**
`decks.qmd` says the covers are "the same plastic that reads bright on a pale
surface, gone dark against a black one." Measured: RGB(187,46,63) at value 0.73 in
`Tree_card.jpg` against RGB(70,11,5) at 0.27 in `Deck_spread_out.jpg`, same red
hue, comparable exposure. Translucency is the inferred explanation and fits Kim's
own reason for the blank end cards, but he has not confirmed it. *Occasion:* next
revision.

**TASK — "gray for abundance" should probably read "silver."**
`decks.qmd` names the abundance cover grey; it is metallic silver (measured
saturation 0.06–0.08 across three frames). Trivial, and it is the sort of physical
detail this project has already had to correct twice. *Occasion:* next revision.

**TASK — Decide whether `decks/` should carry an Abundance deck.**
The printed kit has one (Dominant / Common / Occasional / Rare); the
`discover_decks()` outputs in `decks/` do not. Resolved for now by making
provenance legible in `decks/README.md` rather than reconciling contents, which is
the right call — the mismatch is the book's own thesis in the filesystem.
*Occasion:* the next `discover_decks()` run.

**TASK — Stale path in `QR_procedures.Rmd`.**
Around line 617 it still reads a key from `P://Hot/Workflow/...`, a drive that no
longer figures anywhere. Harmless to run, confusing to a future reader, and it sits
next to the key handling that was cleaned up on 2026-07-29.

**CONDITIONAL — If a real field collection is ever made with the decks**, replace
the bench-run worked example in `closing-the-loop.qmd` and revisit the
candidate-sites framing in `field-log.qmd`. Both currently carry honest disclosures
that would simply become unnecessary. Note that Hawaii Volcanoes NP collecting
needs a permit, which is why neither exists yet.

---

## vouchr

Live at github.com/kimbridges/vouchr. v0.1.0 plus commit `9be8f1c`.

**TASK — Document the two cluster numberings, and return the mapping.**
`discover_decks()` returns `$clusters` straight from `cutree()` — arbitrary
integers — while the heatmap re-ranks clusters by signature richness
(`R/deck_discovery.R` lines 109–110, "order clusters, richest first"). Both are
labelled "Cluster N" and they disagree for two of the four archetypes, so a user
who reads a label off the figure and then indexes `$profiles` gets a silently wrong
answer. Nothing miscomputes; the defect is that two schemes share one name and
nothing says so. **Additive fix:** one line in the Rd, plus a `cluster_label`
element so the figure and the object can be joined, plus a test asserting they
agree. **Do not renumber `$clusters`** — that changes returned values and would
break existing code and any saved analysis. *Raised by Claude, 2026-07-29.*
*Occasion:* 0.1.1.

**CONDITIONAL — If a deck ever fails to decode with the stack fanned, `bind_left`
is the first number to raise.** Measured clearance on the assembled deck is
**0.127 in** against the actual cover, not the 0.372 in once recorded — that figure
was clearance against the 1.5 in assumption, not against the cover. Left at 1.5 in
deliberately, because widening it costs QR size and the decks decode as they are.
Full measurements in the `R/make_qr_cards.R` header, commit `9be8f1c`.

**CONDITIONAL — If a guide sheet is ever used to place a punch**, note that
`punch_x` and `punch_d` are nominal (0.375 in, 0.25 in). The holes in the built
decks measure **0.788 in** from the card edge and the post heads about 0.39 in.
They drive the guide sheet, not the layout, so the mismatch is harmless in the code
and misleading on paper.

---

## Smart_Car

_Section opened 2026-08-12 when the project was filed; the fleet roster and Kim's
analysis intentions were added the same day. Everything here is BLOCKED on the first two
items._

**✓ CLOSED 2026-08-16 — locate the CREAMSICLE cross-country data. FOUND.** It is Google-native
(`Final Creamsicle Logs` Sheet, multi-tab: fuel + a daily trip log per trip; `Creamsicle` Doc, the
9-trip narrative; `Creamsicle_July_Fuel_Log_update` with lat/long; `Creamsicle Inventory`).
**Kept per the WON'T-DO rule for the REASON, not the answer: a filesystem sweep cannot see a
Google-native document.** `G:` reported the stub at 176 bytes and `readBin` returned 0. The task
sat open for months because every search was the wrong KIND of search, not because the data was
hard to find. **Before filing anything as missing, search the Drive API by title.**
**★ Kim had spent the two days before 2026-08-16 working this material up himself.**

_Superseded:_ **TASK — locate the CREAMSICLE cross-country data.** Kim, 2026-08-12. **The highest-value
gap in the project.** Creamsicle (2016 Smart, white/orange) was driven across the country
several times and Kim says he has substantial data on it. Finding those files turns this from
one documented car plus three anecdotes into **two analytical spines**. Until then the fleet
framing is narrative rather than quantitative. Unscheduled by his choice.

**✓ CLOSED 2026-08-16 — top up the TwoRed fuel log to ~75,000. NOT A GAP; A SCOPE BOUNDARY.**
Kim: `TwoRed_fuel_June_2014` **IS** the last fuel log. He logged fuel while the car was used
primarily for long trips; Honolulu trips are all short, the receipts exist, and they add nothing
to a document about long-trip performance. **Kept per the WON'T-DO rule for the reason: the log
stopping at 71,181 while the car reached ~75,000 is the project's own scope showing up in its
record.** Cite *log miles* and *odometer miles* as distinct quantities; do not reconcile them.
**This supersedes his 2026-08-12 phrasing ("I need to update the fuel logs") -- later ruling wins.**

_Superseded:_ **TASK — top up the TwoRed fuel log to ~75,000.** Kim, 2026-08-12, his own framing:
*I need to update the fuel logs so that things are properly filled in.* The Gas Log stops at
71,181; the car went to about 20 miles short of 75,000. The missing stretch is real driving
with no records entered.

**✓ PARTLY CLOSED 2026-08-16 — Two4Two/TwoFer HAS a record.** `TwoFer Gas Log` (Sheet):
7 fill-ups, 2014-03-22 (dealer, odo 0) to 2015-01-10, **1,209 miles, every one in Honolulu.**
**Naming ruled by Kim 2026-08-16: BOTH were used — `Two4Two` is canonical in prose, `TwoFer` is
the log's title. Recorded so a future session does not "correct" one into the other.**
**★ Worth keeping: this does not pad the fleet thesis, it sharpens it — the one car that WAS a
pure urban commuter is the one that was leased and given back.** Bordeaux remains uninventoried.

_Superseded:_ **TASK — whatever exists for Two4Two and Bordeaux.** Lower value, recorded so it is not
mistaken for an oversight. Two4Two was a **lease from 2014-03-22** (Smart Pure, ICE) and was
short; Bordeaux (2018, electric) is deliberately outside the statistics by Kim's ruling of
2026-08-12. Neither is expected to carry much.

**✓ CLOSED 2026-08-12 — the 71,181 vs 75,000 question.** Kim: TwoRed is **about 20 miles
short of 75,000**. The log stopped before the car did; the charter's title was right and the
open question rested on the spreadsheet alone. **Kept per the WON'T-DO rule for the reason,
not the answer: a dataset ending is not the same as the thing it measures ending.**

**★★ KIM 2026-08-17 — THE ERRORS HAVE A MECHANISM, AND IT IS NOT CARELESSNESS.** His words at
close: *there were lines waiting for fuel and it was important to record quickly and vacate the
fuel stall. And forgetting to record a fill-up? That can happen, too.* **This converts the whole
audit from a list of defects into a description of FIELD CONDITIONS.** Consequences that should
shape the write-up rather than sit in a footnote:
- **Category B (missing fill-ups, detected as impossibly high MPG) is EXPECTED, not anomalous.**
  A forgotten entry under queue pressure is the predicted failure of this collection method.
- **Digit slips cluster where haste does.** A number written standing at a pump with cars waiting
  is a different measurement instrument from one written at a desk.
- **Say so in the document.** A record kept for sixteen years under those conditions with ~2% of
  distance disputed is a STRONG result. **Stating the mechanism is what makes the honest review
  credible rather than defensive** -- Kim: *if there are data problems, it is fully understandable.*

**★ TASK — the 3-bar rule as a testable behaviour change.** Kim adopted a habit at Deming on
2010-09-20 after nearly running dry: refill at 3 of 8 bars, never below 2. **Mean fill fell from
87.7% of tank (n=5) to 70.6% (n=286).** **n=5 is FAR too small for a claim -- this is corroboration,
not evidence, and must be labelled as such.** Retest properly once more early data exists.
**★ What IS solid and belongs in the document, fully sourced: he ran 290 miles on that tank, took
7.119 gal (82% of 8.7), and at his then-current 38.1 MPG had roughly 41 MILES OF RANGE LEFT.**

**TASK — Charlton MA -> Austinburg OH remains UNRESOLVED.** GMaps 365 falls BELOW the 457 straight
line, which is impossible, and both coordinates check out. Kim is re-checking the endpoints. **Do
not resolve this by picking whichever number looks nicest.**

**★ KIM'S RULING 2026-08-17 — TRIP LOGGING STARTED LATER THAN FUEL LOGGING. DO NOT BACKFILL.**
His words: he *didn't do trip logging right at the start; that got added later*, he could probably
reconstruct approximations, but **better to treat it as a limitation of the data collection that we
improved as we went along.** **So: establish the ONSET DATE of trip logging from the scans and
record it; treat pre-onset trips as FUEL-ONLY; never estimate a leg that was not written down.**
**★ Analytical consequence, and it must be stated wherever early and late trips are compared: the
INSTRUMENT changed over the record, not just the car.** An early trip with no legs is not a quieter
trip. And Creamsicle's logging is the MATURE form of the method -- so TwoRed-early vs Creamsicle
differences are partly method, not behaviour. This is the same shape as the temperature ruling.

**TASK — fix the gazetteer, not the fuel log, for two mis-geocodes.** `All_gas_stations_csv.csv`
(212 stops, all with coordinates; matches the `Locations` sheet row-for-row). **`Deming` is recorded
as ARIZONA in the fuel log and is in NEW MEXICO** -- that one IS a fuel-log error. **`Big Springs,
Texas` is really `Big Spring` (no s)** and appears to have geocoded to Nebraska -- that one is a
gazetteer error. **Decide per case which side is wrong before editing either.**

**TASK — raise the gazetteer join rate above 81.5%.** 47 distinct locations unmatched. At least one
is a plain misspelling in the fuel log (`Lake San Marcos, Callifornia`). Others are simply absent
from the 212. **The join failure list is itself a typo detector -- work it before geocoding anything new.**

**TASK — 15 scanned logs inventoried 2026-08-17** in `data/Fuel_and_Trip_Logs/`, 4.9 MB, 2010-2017.
**One duplicate:** `2011_TwoRed_travel_and_fuel_log_June.pdf` is byte-identical in `data/` and in the
subfolder (md5-checked); the `proj` Key Files entry points at the `data/` copy. **Watch:**
`2011_TwoRed_fuel_and_trip_log_STL.pdf` is a DIFFERENT document by md5 but the June sheets are headed
*2011 St. Louis Trip* -- **check for repeated legs before merging them.** Also note
`2016_TwoRed_fuel_missing_page.pdf`, which Kim named himself and which may close a category-B gap.

**★ TASK — transcribe the REST of the TwoRed paper trip logs.** Kim, 2026-08-17: he likely has a
**complete set**. The 2011 St. Louis Trip is done (`data/TwoRed_2011_StLouis_trip_log.csv`, 15 legs).
**This is the highest-value open item in the project** -- it converts TwoRed from a fuel spine with a
7-row trip fragment into a true parallel spine to Creamsicle, which is what makes the comparison real.
**Method proven and cheap: the odometer delta cross-checks every written distance**, so errors surface
automatically (it already corrected one of my own readings). Workflow: Kim scans -> transcribe ->
odometer QC -> one CSV per trip -> flag, never silently smooth, anything that fails.

**✓ DONE 2026-08-17 — two PROVEN transcription errors fixed in `TwoRed_fuel_June_2014.xlsx`,
on Kim's instruction, snapshot first.** Method kept because it generalises: the workbook has **175
formula cells** and four sheets with drawings, so rewriting it with a package risked losing structure.
Instead the `.xlsx` was **unzipped, two `<v>` values edited in `sheet1.xml`, and re-zipped**
(`zip::zip`, `mode = "mirror"` -- `cherry-pick` FLATTENS paths and produces a file Excel cannot open,
and `list.files()` omits `_rels/.rels` unless `all.files = TRUE`; both bit me once each).
**Verified by a cell-by-cell diff of all four sheets against the snapshot: exactly 2 differences,
the two intended.** Dimensions preserved (296x20, 212x5, 7x10, 24x13); the arithmetic audit re-run
on the live file now fails only the 2 field errors. Snapshot at
`C:\temp\smartcar_fuelfix_20260817\` (bucket 4 -- delete once Kim is satisfied).
**File is smaller (56,263 vs 58,588 bytes) purely from recompression; content verified cell-wise.**

_Superseded:_ **TASK — fix two PROVEN transcription errors.** Not applied: editing
Kim's data file is his call. **2011-06-23 San Marcos: `$/gal` reads 3.000, paper says 3.999** (8.101 x
3.999 = 32.40 against the 32.48 recorded; 8.101 x 3.000 = 24.30, impossible). **2011-06-25 Ash Fork:
`Gallons` reads 7.624, paper says 7.264** (7.264 x 4.199 = 30.50 exactly, the recorded cost). Both are
digit-level slips made while typing, and both change derived MPG for that fill.

**TASK — two FIELD errors that the paper does NOT resolve.** 2011-06-25 Ludlow (6.319 x 4.599 = 29.06
vs 29.86 recorded) and 2011-07-02 Spring TX (7.889 x 3.679 = 29.02 vs 26.88 recorded). **Wrong on the
paper too, so they predate the spreadsheet.** Settle from a receipt (`2011` scans may exist) or leave
flagged. **Do not 'correct' them by back-solving -- that invents a number.**

**★ TASK — run the arithmetic audit across the WHOLE fuel log, not just 2011.** The `gallons x $/gal
= cost` test found 4 bad rows in a 23-row window. **293 fill-ups have never been checked this way.**
Cheap, and it partitions into transcription vs field errors wherever a scan exists.

**⚠ CONDITIONAL — before ANY TwoRed-vs-Creamsicle speed comparison.** Creamsicle's `Miles/Hour` is
computed after subtracting `Stop` time; the TwoRed paper sheets have **no stop column**, so TwoRed mph
is GROSS. **Naive comparison makes Creamsicle faster by construction.** Use Creamsicle's raw
`Duration`. Verified against its Nixa->Kansas City leg (209.4 mi / 3.00 adj hrs = 69.8).

**TASK — establish when TwoRed temperature recording STOPPED.** Kim, 2026-08-17: it was dropped as
not worth the effort at departure and arrival. **Temperature is therefore a bounded early subset, not
a column running through the record.** Determine the cut-off from the sheets as they arrive; do not
assume one, and do not scope a thermal analysis beyond it. Creamsicle has no temperature at all.

**TASK — clean up `Final Creamsicle Logs`.** Kim, 2026-08-16, his own account: calculations were
put "here and there" so figures could go into the story. Concretely, the fuel tab **interleaves
per-trip totals and averages INSIDE the data region**, so a naive read ingests summary rows as
fill-ups. **The cleanup principle: separate DATA from DERIVED** — raw rows in one tab, computed
summaries generated in R. Do this before the ingestion script, not after.

**TASK — build the photo-to-log join.** `images/Creamsicle/` holds 37 geotagged, timestamped
photos. **`DateTimeOriginal` is LOCAL with `OffsetTimeOriginal` carrying the zone, and the logs
are in local clock time — so the join needs no timezone reconstruction.** Validated on the first
record: photo 11:42, first fill-up 11:45 Nixa MO, 2021-09-23. Natural home is `Photo_Locations` /
`timelinesr` per the standing reuse rule.

**TASK — the T2 photo blank.** No photos for LA->Madison, Oct 2021 (the solo run Kim describes as
pushing his daily limits). **NOT an absence claim** — they may be elsewhere or never taken. Ask
Kim before writing that trip without illustration.

**TASK — redesign the chapter architecture.** The one in `proj_Smart_Car.md` was written for one
car and one trip and is now the weakest part of the project. Candidates: the 2x2 role split as the
top frame; the two long-distance cars as parallel spines rather than primary-plus-supplements.

**TASK — settle the Trip 9 fill-up records.** The Creamsicle trip log carries legs through
**2024-10-20** (the delivery run to Wisconsin), but no fill-ups past **2024-07-02** appeared in
the 2026-08-16 read. **This is NOT an absence claim** — the sheet has multiple tabs and the read
may have been partial. Open the Sheet tab by tab before concluding either way (Findings 018-020).

**TASK — check `TwoRed_fuel` (the live Sheet) before topping up the TwoRed log.** It is a
DIFFERENT and richer record than the exported `TwoRed_fuel_June_2014.xlsx`: cumulative cost,
$/mile, MPG-last-5, and **ambient temperature in the Notes** ("64F @ 2:25PM"), plus a trip tab
with start/end temperatures and odometers. Its own summary block reads 141 fill-ups / 34,098
miles, so it looks DEEPER on the early years rather than LONGER. Read it before writing ingestion.

**TASK — read `Projects\Photo_Mapping\Fuel_Analysis.Rmd` (2022) before writing new code.** It
predates this project and was written against the fuel data. Kim's standing reuse rule applies.

**✓ CLOSED 2026-08-16 — ADJUDICATED BY KIM.** He is content with the Origin Story as written:
it gives away neither the person nor the condition, which he judges within the spirit of
confidentiality. **Do not re-raise this and do not re-derive the detail.** The 2026-08-12
conditional stands for any FUTURE text; this specific draft is cleared.

_Superseded (raised same day):_ **★ CONDITIONAL — the Creamsicle narrative doc is now a PUBLICATION CANDIDATE, so the
not-for-publication line needs Kim's eye, not mine.** The Origin Story describes the caregiving
situation in some detail — two full-time helpers for several months, a clean environment, strict
dietary rules — while never naming the diagnosis. That is further than "bought to help family,
and stops there", and it is **Kim's own drafting**, so it is an editorial call for him and David,
exactly as the 2026-08-12 conditional says. Raised 2026-08-16; NOT acted on.

**TASK — rename `TwoRed_fuel_June_2014.xlsx`.** The Gas Log inside runs to **2017-05-22**,
nearly three years past the date in the filename. Deferred rather than done: renaming a data
file is a forward-pointer change and Kim should confirm the name, not inherit one from me.

**TASK — normalise the State column before claiming any count.** 52 distinct values across
293 fill-ups, against the charter's "49 states and 10 provinces". Some are provinces, and the
`Canada2014` sheet is separate again. One pass with a lookup table when the ingestion script
is written.

**TASK — unit-normalise the Canada2014 sheet.** 24 rows in litres and Canadian dollars, in a
file otherwise in gallons and US dollars. The charter did not mention this sheet at all.

**TASK — remove the superseded copy at `kimbridges-stories/underway/Smart_car/`.** Kim's
hand: neither the device bridge nor the R bridge deletes. Only after he is satisfied the
`Projects/Smart_Car` copy is good. Nine files, 20.6 MB, verified byte-identical on the copy.

**★ CONDITIONAL — BEFORE ANY CREAMSICLE CHAPTER GOES PUBLIC.** Kim, 2026-08-12:
**the reason that car was bought is NOT FOR PUBLICATION.** It was purchased so the family
could help Nancy's brother David through a **double lung transplant**; the car was later sold
to David. That is a third party's medical history. It is recorded here, once, so a future
session understands why a fourth Smart appeared and does not go digging for the reason.
**The public text says the car was bought to help family, and stops there.** Do not
paraphrase toward the detail and do not use it as a chapter hook. If it ever goes in, that is
Kim and David's decision together, not an editorial one.

**CONDITIONAL — if any Smart_Car output is about to be named `bordeaux`.** **NO.** Two
published stories already hold `/stories/bordeaux` and `/stories/bordeaux-2` (the wine
booklets). Rule adopted 2026-08-12: the car keeps its name in PROSE, but no slug,
filename, figure, data file or deploy path may take a `bordeaux*` form. A deploy that
shadowed a live story is exactly the failure this prevents, and folder/slug/name drift is
already a known root cause — `priorities.md` item 3.5.

**CONDITIONAL — if anyone proposes embedding the Arctic Circle Challenge as a chapter.** The
answer is already decided: NO. Kim ruled 2026-08-12 that it is cross-referenced, never
re-told. It is a published story (77 pp) at `/stories/the-arctic-circle-challenge.html`;
embedding it would put identical content at two URLs and make the generated works register
misreport what is published where. The charter's Chapter 5 said to embed it by iframe —
**that charter is the likely source of the proposal, and it is superseded.** Use its DATA in
the analysis chapters; link the narrative.

**CONDITIONAL — if the Creamsicle data never turns up.** The fallback is the one-car scope,
which the existing data DOES support: 293 fill-ups, 2010-2017, 52 states/provinces, and a
clean Fourth Crossing subset. **This is a real document either way** — the fleet framing
raises the ceiling, it does not gate the floor. Worth knowing before anyone concludes the
project is dead for want of paperwork.

---

## kimbridges-documents

**TASK — Check `inventory_of_sources.txt` at the site root.**
It was not read during the 2026-07-29 vouchr deploy and may not list the new
document. *Occasion:* the next deploy to this collection.

---

## PKM

**TASK — Add a finding for the CRLF hazard.**
`writeLines()` on Windows rewrites every line ending in a file. Edit CRLF files in
binary and verify the byte delta equals the intended insertion. This bit twice on
2026-07-29 — once caught before committing `session_log.md`, once anticipated when
inserting into `kimbridges-documents/_quarto.yml` (delta exactly 17 bytes).

**TASK — Add a finding for the device-bridge staging hazard.**
To force a genuinely fresh read, delete the local staged copy first; staging alone
may hand back the cached file, which makes a "second opinion" no opinion at all.
And a character count is not a byte count — comparing the two produced a false
report of file instability on 2026-07-29.

**TASK — Collapse Findings 001/005/013/015** into one statement of the
ground-truth rule instead of four partial ones. Already carried in Tier 3.

**TASK — `pkm_backup()` undercounts the tracked total in its commit message.**
Observed 2026-08-11: the message read `Backup refresh: 8 changed of 969 tracked` while
`git_ls()` reported **971** tracked files. The count is taken BEFORE new files are staged,
so it undercounts by exactly the number of additions. Nothing is lost — both new files
(`ideas_three_documents.md`, `logs/priorities_history.md`) were verified present in
`C:/repos/kimbridges-venues/pkm/`. **The hazard is interpretive:** a future session
comparing the message against an expected count would conclude a file had not been backed
up, and that is an absence claim built on a stale number — the shape of Finding 019, and
the reason Finding 028 says verify against the server rather than the report. Fix: count
after staging. *Raised by Claude, 2026-08-11.* *Occasion:* the next edit to pkm_health.R.

---

## kimbridges-stories

Two recovered Exposure stories published 2026-07-31: *Cinque Terre Impressions*
(43 pp) and *The Washington Monument* (23 pp). Both rebuilt in InDesign from the
original photos and text.

**DONE 2026-07-31 — Two errors in the *Cinque Terre Impressions* book.** Both corrected in InDesign and re-exported; verified absent from the staged PDF. Kept here per the rule that closed items keep their reason rather than being deleted.
(1) The Corniglia section reads "Unlike the other Cinque **Terra** villages" — the
place is Cinque **Terre**, spelled correctly everywhere else in the book and in the
title. (2) The travelling-light section describes "a **Zeill** full-frame equivalent
of 28-100 mm lens" — the QX100 carries a **Zeiss** lens. Both are in the InDesign
source, so fixing them means a re-export and re-deploy. *Raised by Claude,
2026-07-31; Kim: "OK the way they are for now."* *Occasion:* any future reason to
reopen `underway/Cinque_Terre/Cinque_Terre.indd` (folder and all files renamed 2026-07-31; the old `Cinque_terra` spelling is gone from the working material).

**DONE 2026-07-31 — Two errors in *The Washington Monument* book.** Both corrected; the Articles-of-Confederation sentence was rewritten (Washington presided in near-silence, and that silence was the instrument of his influence), with an earlier sentence dropped to make room. Verified absent from the staged PDF.
Not requested, logged because they are real. (1) FACTUAL: "Washington argued for a
strong federal government. It was partly due to his influence that the **Articles of
Confederation were ratified**." The 1787 Convention produced the **Constitution**;
the Articles (1781) were what it replaced. (2) "Retirement from the government came
in March, **17978**" — 1797. *Raised by Claude, 2026-07-31.* *Occasion:* same as
above — the next reason to reopen the InDesign file.

---

## kimbridges.com

Kim's personal and professional site, deliberately kept SEPARATE from
kimbridges.info. **It is alive and is being KEPT** — not one of the platforms being
retired. It has no `proj_*.md`; whether it should is an open question, deliberately
not answered here.

**DONE 2026-07-31 — Remove the residual story links.** Kim deleted the remaining "stories" link. Verified same day by fetching kimbridges.com: no reference to quarto.pub, exposure.co or hflip.co anywhere in the page. Kept per the rule that closed items keep their reason.
Kim believed the stories had been cleaned off .com; some links remain. This belongs
with the retirement of the unnecessary sites (Quarto Pub, hflip, Exposure) because
it is the same sweep — making sure no page points at content that is about to move
or disappear. The stories site's own navbar also links to www.kimbridges.com, so the
two sites cross-reference each other. *Raised by Kim, 2026-07-31.* *Occasion:* the
account-deletion pass.

**TASK — General updating of the site.** Kim: "needs some updating, but that's a
lower priority." *Raised by Kim, 2026-07-31.*

---

## Legacy platform links inside the LIVE venues

**Kim unsubscribed from Quarto Pub and Exposure on 2026-07-31.** Verified same day:
`kim.quarto.pub` has **NO DNS A RECORD** while `quartopub.com` resolves and returns
200 — the subdomain is gone, the platform is not, so the failure is proved rather
than inferred (the discipline of Finding 020). Exposure returns 403 to programmatic
clients as it always has, so its state cannot be read from outside. **hflip remains
subscribed and live** (200).

**PARTLY DONE 2026-07-31 — Repoint the dead Quarto Pub links inside published documents.** **plainmaps is COMPLETE** (both links repointed, three typos fixed, Tessellations orphan removed, PDF re-rendered 78 pp, deployed and verified live). **STILL OUTSTANDING: `r_basics/index.html` and `using_an_llm/` (2 files)** -- source for those is `Projects/R_Basics` and `Projects/LLM_Creates_R`.
These are being served to readers right now. All of them have a kimbridges-documents
equivalent already live, so the fix is mechanical:

| File (in kimbridges-documents) | Dead link | Should point to |
|---|---|---|
| ~~`plainmaps/index.html`~~ DONE | | |
| ~~`plainmaps/Sitemaps.html`~~ DONE | | |
| `r_basics/index.html` | kim.quarto.pub/sitemaps | /sitemaps/ |
| `using_an_llm/Plainmaps.html` | kim.quarto.pub/plainmaps/ , kim.quarto.pub/ | /plainmaps/ , the docs index |
| `using_an_llm/Resources.html` | kim.quarto.pub , kim.quarto.pub/storylines/ | the docs index , /storylines/ |

Fix at SOURCE and re-render, not in the rendered `.html`. Source exists for
`Projects/plainmaps` and `Projects/R_Basics`; **no source folder was found for
`using_an_llm`** — **FOUND 2026-07-31: the source is `Projects/LLM_Creates_R`; the project publishes under a different name. Recorded in proj_LLM_Creates_R.md.** (Original note: locate it before editing, or the fix will be lost on the next
render. *Raised by Claude, 2026-07-31.*

**DONE 2026-08-02 — Two hflip links in the Gallery Catalog.** Both repointed to the
in-house PDF viewer that `gallery.qmd` already uses:
`../viewer.html?pdf=1_Gallery_Catalog.pdf` (`Gallery/viewer.html` defaults to
Two-Page Spread and loads from `pdfs/`, so the "two-page spread" description still
holds — only the vendor name "ISSUU" was dropped, since that was Heyzine's renderer).
Edited at SOURCE (`index.qmd` L27, `Stage.qmd` L5), re-rendered, verified in `_site`.
Backups in `Gallery_Catalog/_backup/*_backup_2026-08-02.qmd`.
**STILL OPEN:** `Gallery_Catalog/_publish.yml` declares
`url: https://kim.quarto.pub/gallery-catalog` — obsolete config, harmless but
misleading.

**DONE 2026-08-02 — Two `kim.quarto.pub/ai-podcasts/` links in the Gallery Catalog.**
Condition met the same day: AI_Podcasts went live at
`https://kimbridges-documents.netlify.app/ai_podcasts/` (verified live before editing,
not after). Both repointed at SOURCE, collections re-rendered, `_site` 98 -> 98 files.
**kimbridges-collections now contains ZERO quarto.pub / hflip / SoundCloud / Exposure
links** — verified across every `.html` in `_site`. Awaiting Kim's drag.

**TRAP — `Gallery/Gallery_Catalog/_output/` is stale and is NOT the deploy source.**
Proved 2026-08-02: `_output/Podcast.html` is dated 2025-04-09 and stamped
`quarto-1.5.56`, while the live `_site/Gallery/Gallery_Catalog/*.html` is dated
2026-07-26 and stamped `quarto-1.8.27` with the parent Collections navbar and
`../../site_libs/`. The nested book `_quarto.yml` (`type: book`, `output-dir: _output`)
is vestigial — the PARENT collections website render walks into the folder and renders
the six chapters as ordinary website pages straight into `_site`. **Deploy chain is:
edit the .qmd → `quarto::quarto_render(input = "G:/My Drive/kimbridges-collections")`
→ drag `_site`.** There is NO copy step from `_output`; copying from it would push
15-month-old pages. Same shape applies to `Jones/Jones_analysis/_quarto.yml`.
*Raised by Claude, 2026-08-02.*

**Note.** Kim already knows about pointers on kimbridges.com and will handle those
separately (see the kimbridges.com section). THESE are different: they are inside
his own published venues, and he had not been told about them.

**TASK — Unify the API-use descriptions while doing the repointing.**
Raised by Kim, 2026-07-31: the descriptions of API use are likely inconsistent
across the documents that discuss it, and the link-repointing pass touches those same
files. Doing both at once avoids a second render-and-deploy cycle. Candidates:
`using_an_llm` (= Projects/LLM_Creates_R), `r_api` / proj_LLM_API_R, proj_accessOAI,
and the AI_Microscope appendix, which describes keys-on-the-server. *Occasion:* the
link-repointing pass. **Kim's standing instruction: these links get CORRECTED, not
ignored.**

## ISSUU -- CLOSED 2026-08-11. Retained as record; see the closure note below.

**CLOSED 2026-08-11 (Kim).** Every story once on ISSUU has been moved to the current
site. VERIFIED, not accepted: all four booklets are published stories with PDF, cover
and page in place -- `finding-fine-wine`, `bordeaux`, `bordeaux-2`, `japan-fall-2023`.
`Projects/AI_Podcasts/Travel.qmd` contains **ZERO** mentions of ISSUU, so the four
pointers AND the L11 prose claim are already gone. Nothing is at risk on that platform
and nothing points at it. The recovery, repointing and prose tasks are all closed.
The detail below is kept per the WON'T-DO rule -- reasons preserved, not deleted.

**Corrected 2026-08-02 (same day) after probing all five URLs.** The section below
originally recorded two guesses as fact. Both were wrong; Kim supplied the history and
the probes supplied the state.

**What Kim reported.** ISSUU abruptly and greatly raised its prices. He shut the site
down very quickly and deleted the account, moving to hflip. That is why ISSUU appears
in `design_publishing_workflow.md` as already-replaced.

**What the URLs actually return (probed 2026-08-02):**

| slug | in | state |
|---|---|---|
| `finding_fine_wine` | AI_Podcasts/Travel.qmd | **LIVE** — "Finding Fine Wine: A 2018 trip to the Napa Valley" |
| `bordeaux` | AI_Podcasts/Travel.qmd | **LIVE** — "Bordeaux: A Travel Photo Essay", Bridges & Furumoto, Oct 2019 |
| `chatgpt_examples` | LLM_Creates_R/Resources.qmd | **LIVE** — "Experiments with LLMs" v4, Jan 2024 |
| `bordeaux_2` | AI_Podcasts/Travel.qmd | **404** |
| `2023_japan_story` | AI_Podcasts/Travel.qmd | **404** |

**Two consequences, and they pull in opposite directions.**

1. Two links are ALREADY BROKEN and are being served to readers now. Not a future
   risk — a present defect.
2. Three documents are still public on a platform Kim believes he closed. **That is
   worse than the Exposure situation, not better.** Exposure has a known deletion
   event we can schedule around. These three can vanish whenever ISSUU reconciles a
   deleted account, with no notice and no one watching. Recover them FIRST.

**Correction to the record.** This section previously said `Desktop\Podcasts\
2023_Japan_Story.pdf` was "too small to be the illustrated booklet" at 0.47 MB. Wrong.
Kim: the 2023 Japan story is **text-only by design** — about 40 pages, no photos ever
added — and it is the exact file he fed to NotebookLM, which is why it sits in the
podcast folder. **It is the artifact, not a fragment of one.** The lesson is the
familiar one in a new costume: a file size is not a verdict on a file's contents.

**READY NOW — `2023_japan_story`.** Dead link, local PDF in hand. Copy
`2023_Japan_Story.pdf` into a venue `pdfs/` folder and point Travel.qmd at
`viewer.html?pdf=2023_Japan_Story.pdf`, the pattern already working in
kimbridges-collections. No blocker.

**NEXT — the three live ones.** Recover before repointing. The InDesign sources exist;
Kim notes the 2023 Japan one is filed with the **photo archive for that trip**, not with
the writing — so the others are likely filed the same way, by trip rather than by
project. Ask Kim per document rather than searching blind.

**CORRECTED 2026-08-11 -- `bordeaux_2` DOES have a source and is PUBLISHED.** The claim below was wrong. `kimbridges-stories/pdfs/Bordeaux_2.pdf` and `images/Bordeaux_2.jpg` are present and deployed to `_site`, and `stories/bordeaux-2.qmd` exists. An absence was asserted without being proved -- Finding 019 again. Superseded text kept: ~~
one real gap. It is the second Bordeaux podcast's companion document.~~

**Prose to fix in the same pass:** Travel.qmd L11 tells readers the booklets "are
available on an ISSUU website." False for two of them today and false for all of them
once migrated. Same category as the stale Quarto Pub claims below — a sentence has no
href, so no link audit will ever flag it.

**FUTURE PROJECT (Kim, 2026-08-02).** There are **a dozen or so trips** where the story
is written to roughly the length of the 2023 Japan story but the photos were never added.
Kim: "Attending to these will become part of our activities after the other things get
done." Not scheduled. Recorded so it is not rediscovered as a surprise.

**TASK — Two stale PROSE claims about Quarto Pub.** Not links; sentences.
`kimbridges-documents/plainmaps/index.html` L233: "Posting these materials on the Quarto
Pub website provides easy access to the code." `r_basics/index.html` L214: "Posting this
book on the Quarto Pub website means that I have easy access to the code." Both are now
false — the platform does not resolve. **A link audit cannot find these: a sentence has
no href.** Fix at source (`Projects/plainmaps`, `Projects/R_Basics`) and re-render.
Kim's wording, so Kim's call on the replacement text. *Raised by Claude, 2026-08-02;
found by the new `pkm_legacy_live()`, see Finding 024.*

**DONE 2026-08-02 — SoundCloud migration.** All eleven embeds replaced with HTML5
`<audio>` served from the venues: 1 in the Gallery Catalog (2026-08-01), 10 in
AI_Podcasts (2026-08-02). `.wav` masters copied to `Projects/Audio/podcast_masters`
(12 files, 361 MB, byte-verified). **SoundCloud now hosts none of Kim's audio.**
Desktop originals still in place pending Kim's go-ahead to delete.

## Experiments with LLMs — DONE 2026-08-03, published

Safe-held 2026-08-02, converted and published 2026-08-03 as the 22nd document at
`/llm_examples/`. See **proj_LLM_Examples.md**. The structural question was resolved by
evidence rather than by choosing among the three routes: the PDF's producer string
(`Skia/PDF m122 Google Docs Renderer`) led to the live Google Doc, so there was a source
to convert and the "rebuild means reconstructing from the PDF" objection evaporated.

**This closed the last non-historical legacy link in any venue.** `LLM_Creates_R`'s
`Resources.qmd` L84 now points at `/llm_examples/` instead of ISSUU.

**Still open, deliberately:** editorial reorganisation of the accreted content. Kim's
own framing — *"This 'document' kept getting small additions as I tried new things"* —
and only Kim can judge which early tests to group or retire. Also worth considering: a
2026 afterword, since the preface's "these now seem relatively unsophisticated" was
written in Jan 2024 about Jan 2023 work.

**Reusable lesson.** *Read the producer string before deciding a document has no source.*
Every PDF records the tool that made it. Two days of assumed reconstruction work
disappeared into a single metadata field that had been sitting in the file the whole
time. Added to the situation table in pkm_card.md.

## Orphan cover images in kimbridges-stories — found 2026-08-02

`images/*.jpg` with no matching `pdfs/*.pdf` and no story page. Each is an intake that
was started and abandoned. Found only because `2023_Japan_Story.jpg` turned out to be
already staged when that story was published.

| cover | status |
|---|---|
| ~~`2023_Japan_Story`~~ | **RESOLVED 2026-08-02** — published as `japan-fall-2023` |
| `LLM_Examples` | rescued to `Projects/LLM_Examples/`; going to documents instead |
| `Catalog` | presumably the Gallery Catalog, which lives in collections — likely a stray |
| ~~`Ranunculus_Impressions`~~ | **CLOSED 2026-08-11 (Kim) -- a DUPLICATE.** The real stories are live as `ranunculus-at-flower-fields` and `ranunculus-asiaticus-variability`. Stray cover; not a missing story. |
| `Selective_Focus` | **SOURCE FOUND 2026-08-11 -- `underway/Selective_Focus/Selective_Focus.pdf`** (2.9 MB, 2026-04-17), cover already in `images/`. Unpublished. **HIGH PRIORITY (Kim).** Genuinely quick. |
| `Smart_Car` | **SOURCE FOUND 2026-08-11 -- and it is NOT a story.** `underway/Smart_car/` holds nine files incl. a full project charter (`README.md`, 2026-05-08): *TwoRed 75,000 Miles Celebration*, a five-chapter reproducible Quarto book. **HIGH PRIORITY (Kim), but needs re-filing as a PROJECT** -- no `proj_*.md`, no index row. |

The last three are the interesting ones: a cover image means Kim once had a story in
mind and got far enough to choose the picture. Ask him what they were before assuming
they are strays. *Raised by Claude, 2026-08-02.*

## SoundCloud — CLEARED for account deletion 2026-08-02, with one check first

**All eleven embeds are migrated.** Nothing in any venue references SoundCloud; verified
by `pkm_legacy_live()` across every venue source and by reading the deployed HTML. The
local set is complete: 10 mp3 in `Projects/AI_Podcasts/audio`, 1 in
`kimbridges-collections/Gallery/audio`, and 12 `.wav`/`.m4a` masters in
`Projects/Audio/podcast_masters` (byte-verified).

**BEFORE CLICKING DELETE — the one check the PKM cannot do for Kim.** Deletion is a
one-way door, and this system can only see what the VENUES reference. If a track was
uploaded to SoundCloud and never embedded anywhere, nothing here knows it exists.
**Open the SoundCloud track list and compare it against the local files** before
deleting the account. Two known local files are already unembedded --
`Gallery_Catalog_2.mp3` and `NotebookLM_review.mp3` (the three-voice discussion of
NotebookLM; Kim, 2026-08-02: worth keeping, not needed on a page) -- which proves the
category is real: audio can exist outside the venue graph.

This is the same discipline applied to Exposure and ISSUU. It cost nothing there and it
costs nothing here. *Raised by Claude, 2026-08-02.*

## Consolidation migration — DELIVERED 2026-08-03

**github.com/kimbridges/kimbridges-venues**: 882 files (197 venue source, 683 project
source across 49 projects), verified from GitHub's trees API. See proj_PKM.md and
Findings 027/028.

**DONE 2026-08-03 — the refresh cadence is settled: Mechanism 5, item 12.**
`pkm_backup()` refreshes all five venues, every project and `Projects_Index`, runs
`pkm_secret_scan()` as a hard gate, commits, pushes, and verifies against the SERVER
rather than the return value. It now runs at every session close beside `pkm_health()`,
and is on `pkm_card.md`. Kim can also run it alone at any time; it is safe when nothing
has changed and says so.

*Why this answer:* the alternatives were a scheduled task (needs the machine on and the
R server up — a backup that silently stops running is the exact failure being guarded
against) or on-demand (depends on remembering, which is what Mechanism 5 exists to
replace). Attaching it to an existing trigger costs nothing and inherits a habit that
already holds.

**TASK — six repo/clone mismatches** (open since 2026-07-30). accessOAI, geContour,
milestones and plainmaps have a public GitHub repo but no local clone; listsr and
Temperature_Patterns have a local clone but no public repo. **Confirm listsr is not
simply PRIVATE before concluding it is missing** — Finding 019.

**TASK — audit the rest of Drive for credentials.** `pkm_secret_scan()` covers the
mirror (source extensions only). It has NOT been run across all of `Projects/` — the
first attempt without an extension filter hung the bridge and Kim had to interrupt R.
Now filtered, but still slow over Drive Stream, so run it per-project in batches rather
than all at once. `.Renviron` legitimately holds keys and is not a finding.

**CLOSED 2026-08-03 — the Anthropic key is revoked.** Kim deleted the April-2024
`sk-ant-` key found in `Projects/LLM_API_R/Claude_API.qmd`. It was never published,
so exposure was limited to his own disk, and it is now dead regardless. Source is
clean; `pkm_secret_scan()` gates every commit; original at `LLM_API_R/_backup/`.

**DONE 2026-08-03 — the PKM itself is now mirrored.** `Projects_Index` was NOT in the
first migration: the venues and project source went to GitHub, but not the index that
makes them findable. Added as `pkm/` — 87 files, 2.0 MB, including `pkm_health.R`,
every `proj_*.md`, `pkm_findings.md`, the session log and its archive. Repo now carries
**969 blobs**. The artifacts could be re-read from their own files; nothing else records
why a decision was made or which mistakes have already been paid for once.
