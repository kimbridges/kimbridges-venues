# Smart_Car -- project log

## ARCHIVE -- moved out of proj_Smart_Car.md 2026-08-19 to hold the size budget
_Verbatim. Narrative material for the document, plus one superseded status table._

### ★★ THE YUKON RIVER CAMP STORY -- and why the claim is stronger than an anecdote (Kim, 2026-08-18)

**August 17-18, 2013, Dalton Highway.** While Kim was filling the car at Yukon River Camp, the woman
running the small concession in the parking area ran over, excited: **they had never seen a car like
it before.** Kim reads this as confirmation that TwoRed was **the first Smart car to make the Arctic
Circle run.** On the way back the weather turned, and **the highway closed shortly after they were
off it.**

**★ THE INFERENCE IS UNUSUALLY WELL-SUPPORTED FOR A TRAVELLER'S ANECDOTE, AND THE FUEL DATA IS WHY.**
Yukon River Camp is **the only fuel between Fairbanks and Coldfoot** -- which is exactly why the log
shows Kim buying there **twice, northbound (ODO 36,852) and southbound (37,114)**. Anyone driving the
Dalton must stop there. **So the observation post is a CHOKE POINT, and a negative observation at a
choke point is worth far more than the same observation anywhere else** -- she was positioned to have
seen every vehicle that made the run. It remains testimony rather than proof, and should be written
as *the only fuel stop on the road had never seen one*, which is both defensible and stronger-sounding
than a bare claim of primacy.

**★★ AND IT IS THE SECOND INSTANCE OF THE SAME UNDERLYING FACT.** In Alpine, Texas a stranger walked
over because he mistook the Smart for **a specific friend's car**. At Yukon River Camp a stranger ran
over because she had **never seen one at all**. Same cause -- the car was rare -- producing opposite
reactions according to where it was parked. **Two independent strangers approaching the car in two
years is a PATTERN, not a pair of anecdotes**, and it is evidence for the document's thesis that no
fuel statistic can supply: the vehicle was conspicuous in exactly the places the urban-commuter
assumption says it should never have been.

**Margin of safety, from the data:** the Coldfoot round trip was **550 miles over two days** in a car
with roughly a 330-mile range, refuelling at the single station in both directions, and the road shut
behind them. Kim: *there were more adventures.*

### ★★ THE ALPINE STORY -- for the Expeditions chapter (Kim, 2026-08-18)

**February 2012.** Kim had met a faculty member from the university in Alpine, Texas while in Fort
Worth, and drove out to visit him -- a **408-mile straight-line detour** into Big Bend country. The
campus looked deserted. Casting about for the right building, he saw a single person walking toward
the parking lot where he had stopped. The man came over to the car. **He was the very person Kim
had driven there to see -- and he had walked over because he mistook the Smart for a friend's car.**
Two coincidences in one empty car park.

**★ Why it belongs in a document about the CAR and not just the trip:** the coincidence is only
possible because a Smart in Alpine, Texas in 2012 was distinctive enough that a passer-by assumed it
belonged to the one person he knew who drove one. **The car was legible as an individual.** That is
a fact about what it was like to run this vehicle long-distance in that era, and no statistic in the
fuel log carries it.

**★ AND THE STORY DOES ANALYTICAL WORK.** It confirms the route, which turns the missing fill-up
from a suspicion into a certainty: Ft Worth -> Alpine is 475 recorded miles against a ~331-mile tank
range, so **a fill-up exists that was never written down** (errata L18). It also explains why the
row is the messiest in the file -- **the log was written up at the end of a memorably disorienting
day.** Kim's own reading: *that's enough to get me confused.*
**This is the pattern worth repeating: the narrative and the data each explain a gap in the other.**

**Photographs of the cars in interesting places** are a first-class element, not decoration.
They are also the natural join to `Photo_Locations` and `timelinesr`: a geotagged photo and a
geocoded fuel stop are the same kind of record, and the fuel log already supplies a route to
hang them on.

**ICE and EV are kept SEPARATE (Kim, 2026-08-12).** Statistics run across the three gas
cars; Bordeaux is described qualitatively. **A $/mile axis spanning gasoline and electricity
was considered and declined** — it would force a comparison the charging data may not
support. Revisit only if kWh and charging-cost records turn up.

## SCAN COVERAGE AND WHAT IS TRANSCRIBED (2026-08-18)

**Trip logs transcribed -- 67 legs, one CSV per trip in `data/`:**

| Trip | Legs | Miles | Agreement with the written distances |
|---|---|---|---|
| 2011 St. Louis | 15 | 4,635 | 12 of 14 within 2.5 mi |
| 2013 Arctic | 18 | 5,401 logged (Kim's 5,470 counts from the first fuel stop) | **18 of 18** |
| 2014 Penultimate State | 32 | **10,907 -- Kim's own margin total, EXACT** | 31 of 32 |

**Fuel-log scan coverage: 140 of 293 rows (48%) now have verified paper behind them.**
6 of 14 distinct scans opened; **8 remain unopened**: 2011 STL, 2011 fuel log, 2012 Frostburg,
2012 May Arizona, 2013-4 LA Expedition, 2015 Sedona, 2016 fall-winter, 2017 January.

**★ TWO PERIODS MAY HAVE NO SHEET AT ALL, and one of them matters:**
- **2016 May-Dec, 39 rows** -- the only remaining 2016 file is *fall-winter*. **This is exactly where
  the fill-drag contamination sits**, so if no May-2016 sheet exists the AMEX is the only route to the
  true LSM and Blythe gallons and costs.
- **2017 Jan-May, 13 rows** -- the only 2017 file is *January*, against a run ending 2017-05-22.


---

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

## Chapter architecture (PROVISIONAL — inherited from the one-car charter)
1. **Foreword** — origin (Paris to the US mainland) and the urban-myth thesis.
2. **The Canvas** — the geocoded constellation of every recorded fuel stop.
3. **The Expeditions** — fill-ups classified into trips via the master dictionary.
4. **The 4th Crossing** — daily friction: temperature against mileage, true average speed.
5. **The Extremes** — highest (Mount Evans), lowest (Death Valley), furthest.
6. **The Fleet** — NEW, and the reframing's payload: four cars, sixteen years.

Old Chapter 5 (Arctic Circle embedded) is deleted; see intentions item 2.



## What the data ACTUALLY contains

Read directly rather than taken from the charter, 2026-08-12. **Three of the charter's
claims do not survive contact with the files, and one filename actively misleads.**

| Asset | Charter said | What is actually there |
|---|---|---|
| `TwoRed_fuel_June_2014.xlsx`, sheet *Gas Log* | "nearly 300 fill-ups" | **293 fill-ups, and the range is 2010-07-23 to 2017-05-22** -- nearly three years past what the filename claims. **Rename deferred until Kim confirms.** |
| same, odometer | "75,000 miles" | Tops out at 71,181 in the file. **RESOLVED 2026-08-12 by Kim: TwoRed is ~20 miles short of 75,000** -- the log stops before the car did. The charter was right; my open question rested on the spreadsheet alone. Kim is filling in the remaining miles. |
| same, *State* column | "49 states and 10 provinces" | **52 distinct values.** California 96 fill-ups, then Arizona 24, Texas 21. Needs normalising before any count is claimed. |
| same, sheet *Trip Log* | "precise daily driving intervals" | **7 rows.** This is a fragment, not a dataset. |
| same, sheet *Canada2014* | not mentioned | **24 rows in litres and Canadian dollars.** A unit-normalisation job the charter did not anticipate. |
| `2016_Fourth_Crossing_Analysis.xlsx` | "a highly refined subset" | **Accurate -- and it is TwoRED, not Creamsicle. RULED 2026-08-16 by odometer, against the tempting coincidence that 2016 is Creamsicle's model year:** the file opens at **58,214 in May 2016**, inside TwoRed's trajectory and five years before Creamsicle was bought at 30,290. Carries `am_temp` / `pm_temp` as well. 35 rows, with `time_zone`, `raw_hours`, `activity_time`, `corrected_hrs`, `miles_per_hour` already derived. The best-prepared asset in the set. |
| `Smart_Car_master_dictionary.pdf` | expedition names and date ranges | Present, 2.0 MB. Not yet parsed. |

**SUPERSEDED 2026-08-16 -- the sentence below was written when the on-disk sweep was the only
search that had been run. Creamsicle and Two4Two/TwoFer both have machine-readable records; they
are Google-native and therefore invisible to a filesystem sweep. Bordeaux remains uninventoried.**

_Superseded:_ **The other three cars are now NAMED and DATED (see The fleet above), but only Two4Two has
a machine-readable record** -- `leased_smart.txt`, one line. **Creamsicle is the important
gap:** Kim has substantial cross-country data for it, and finding those files is what turns
this from a one-car document into a two-spine one. Bordeaux is not yet inventoried.


