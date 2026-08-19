# Smart_Car -- project log
_Split from proj_Smart_Car.md on 2026-08-18. Verbatim; nothing edited._
_Live project file: `../proj_Smart_Car.md`_

---

## Log
### 2026-08-17 (the paper trip logs; the fractal scope boundary; a fuel-log audit)

**Kim scanned a set of 2011 field sheets and asked whether I could read them. I can.** Four pages,
handwritten, fuel log above and trip log below. **The trip half had never been typed** -- which is
the exact gap that made TwoRed's Trip Log "7 rows, a fragment not a dataset" on 2026-08-12.

**Transcribed: 15 legs, 4,635 driving miles, odometer 13,689 -> 18,789.** Written to
`data/TwoRed_2011_StLouis_trip_log.csv`.

**★ The odometer is a free QC gate, and it works.** 12 of 14 written distances match the odometer
delta within 2.5 mi. Of the two that did not: 7/05 read as 298.7 against an odometer delta of 289
-- **re-read as 289.7, and the odometer corrected my transcription**; 7/04 remains 392.1 written
against 397, unresolved and flagged in the file rather than smoothed. **This matters for scale:
every leg self-checks, so bulk transcription of the remaining sheets is trustworthy rather than
OCR-and-hope.**

**★ THE FUEL AUDIT, and the finding is the DISTINCTION not the fixes.** Testing whether
`gallons x $/gal` reproduces the recorded cost failed on 4 of 23 rows in the 2011 window. **The paper
splits them into two kinds:** 6/23 San Marcos ($/gal typed **3.000**, paper says **3.999**) and 6/25
Ash Fork (gallons typed **7.624**, paper says **7.264**, which reproduces the cost exactly, and the
paper itself shows the total struck and corrected) are **TRANSCRIPTION errors the scans repair**.
6/25 Ludlow and 7/02 Spring TX are **inconsistent on the paper too -- FIELD errors that predate the
spreadsheet** and can only be settled from a receipt, or left flagged. **The scans do not merely add
data; they let a transcription error be told apart from a field error.** Neither fix applied yet --
editing Kim's data file is his call.

**★ KIM: THE SCOPE BOUNDARY IS FRACTAL.** The 4,635 logged miles against 5,100 odometer miles is
city driving, and *we're laser focused on the long drives, not the city stuff*. **The same rule
appears at fleet, car and trip level, excluding the same thing each time -- so the gaps are
DEFINITIONAL, not missing.** See the section above; it is now an analysis rule.

**KIM: a complete set of TwoRed trip logs likely exists.** If so, TwoRed stops being a fuel spine
with a 7-row fragment and becomes a **true parallel spine to Creamsicle**.

**KIM: temperature recording was DROPPED** -- not worth the effort against everything else happening
at departure and arrival. **So temperature is a BOUNDED EARLY SUBSET of the TwoRed record, not a
column that runs through it.** Scope any thermal analysis to the years that carry it; establish the
cut-off from the sheets as they arrive rather than assuming one.

**⚠ METHOD TRAP for the TwoRed-vs-Creamsicle comparison.** Creamsicle's `Miles/Hour` is computed
**after** subtracting a `Stop` column; the TwoRed paper sheets have no stop column, so their mph is
**gross**. Verified on Creamsicle's Nixa->Kansas City leg. **Compared naively, Creamsicle wins by
construction.** Use Creamsicle's raw `Duration` for any speed comparison.

### 2026-08-16 (Kim's rulings, second half of session)

**Context: Hurricane Lala.** Hawai`i was narrowly missed but damaged across all islands -- nearly
**200,000 homes without power**, bridges washed out, communities isolated. Kim and Nancy are safe
and their Honolulu apartment kept power; he had been reluctant to use the computer at all in case
it dropped. **Recorded because it explains the shape of the next few sessions, not as colour.**
Recovery expected to begin 2026-08-17.

**1. The fleet splits 2x2 by DISTANCE ROLE** -- see the section above. Supersedes the ICE/EV axis.

**2. `TwoRed_fuel_June_2014` IS the last fuel log for TwoRed.** Kim: he logged fuel while the car
was used primarily for long trips; Honolulu trips are all short, and the receipts exist but add
nothing to a document about long-trip performance. **★ This dissolves what the PKM had filed as a
gap: the log stopping at 71,181 while the car reached ~75,000 is not missing data, it is the
project's SCOPE BOUNDARY showing up in its own record.** Consequence for the document: cite *log
miles* and *odometer miles* as two different quantities and say why they differ, rather than
reconciling them.

**3. The Origin Story confidentiality question is ADJUDICATED -- Kim is content with the text as
it stands.** He gives away neither the person nor the condition, which he judges within the spirit
of the 2026-08-12 conditional. **Closed. Do not re-raise; do not re-derive the detail.**

**4. The `Creamsicle` doc ending is BY DESIGN, not truncation.** The countries/states list is a
summary reminder that place analysis is coming; the actual places live in the trip log. **The
open question raised earlier today is closed -- and refusing to call it an absence was correct.**

**5. The spreadsheet needs a cleanup.** Kim's own account: calculations were put "here and there"
to feed figures into the story. Filed as a TASK.

**6. The photo layer.** See Intended analysis.

### 2026-08-16 (the Creamsicle data found; project unblocked)

**Focus chosen by Kim at session open.** The block was discharged in one search, and the reason it
had held for months is worth more than the data: **every prior sweep was a filesystem sweep, and a
Google-native document has no bytes on disk.** `G:` reported `Final Creamsicle Logs.gsheet` at 176
bytes; `readBin` returned 0. The card's ground-truth rule predicted exactly this.

**Found:** `Final Creamsicle Logs` (gas log + the project's first real trip log), the `Creamsicle`
narrative doc (9 trips, drafted), `Creamsicle_July_Fuel_Log_update` (with lat/long), and
`Creamsicle Inventory`. **28,697 miles, 1,123 days, 9,845 mi/yr, 18 states + Canada.**

**Two side findings.** `TwoFer Gas Log` is car #2's record -- 7 fill-ups, 1,209 miles, **all
Honolulu** -- which the PKM had as "one line of text". Kim ruled both names were used: Two4Two
canonical in prose, TwoFer recorded as the log's title so a future session does not "correct" it.
**★ It also sharpens the thesis rather than padding it: the one car that WAS a pure urban commuter
is the one that was leased and given back.** And `TwoRed_fuel` is a second, richer TwoRed sheet
carrying ambient temperature in its Notes.

**One hypothesis raised and killed by data.** 2016 is Creamsicle's model year, so
`2016_Fourth_Crossing_Analysis.xlsx` looked like it might be Creamsicle's. It is **TwoRed's** --
odometer opens at 58,214 in May 2016, five years before Creamsicle was bought at 30,290.

**Not claimed:** no Creamsicle fill-ups past 2024-07-02 appeared in the read, though trip legs run
to 2024-10-20. Filed as an open question, not as an absence (Findings 018/019/020).

Set **Active / Ready** at Kim's direction.
### 2026-08-12 (intake gap closed; reframed from one car to four; focus lowered)

Filed as a project after the 2026-08-11 session identified it as a document mis-scoped as
a story. **Kim confirmed that reading and went further:** the largest section of the source
material is the Arctic Circle Challenge, which is already a posted story -- so the
remaining substance is the data, not the narrative.

**The reframing is his:** four Smart cars, not one. Two still owned. Deepest data on the
first, TwoRed.

Materials copied to `Projects/Smart_Car` under `data/`, `source/`, `images/`. Nine files,
**all nine verified byte-identical**, 20.56 MB both sides.

**Reading the data rather than the charter changed three claims** -- the Gas Log runs to
2017 not June 2014, the odometer tops out at 71,181 not 75,000, and the Trip Log is 7 rows
rather than a dataset. Recorded above rather than carried forward as fact.

Set **Active + Blocked** at Kim's direction so it leaves the active worklist while staying
findable, with the blocker named as his own data recovery.
