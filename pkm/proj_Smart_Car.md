# PROJECT: Smart_Car
_Last updated: 2026-08-16_
_Status: Active_
_Focus readiness: Ready_
_Tags: intake, data-recovery_

## Type
R + Quarto document (data-driven), with photography

## Objective
A data-driven Quarto document about **sixteen years and four Smart cars**. The original
2026-05-08 charter framed this as one car's road trip -- *TwoRed 75,000 Miles*. Kim
reframed it on 2026-08-12: **the subject is the fleet, not the trip.** Four Smart cars
since 2010, two still owned. The thesis the charter got right and this keeps: a Smart is
assumed to be a short-hop urban commuter, and the record refutes that. The reframing makes
the refutation stronger -- not one exceptional car on one exceptional journey, but a
**sustained sixteen-year choice**, repeated three times after the first.

## Current Status
**★ UNBLOCKED 2026-08-16 -- THE CREAMSICLE DATA IS FOUND, AND IT WAS NEVER A FILE.**
Every earlier search looked on disk for spreadsheets. Creamsicle's records are **Google-native
documents at the root of `G:\My Drive`**, which Drive Stream presents as zero-byte placeholder
stubs: `file.info()` reports 176 bytes for `Final Creamsicle Logs.gsheet` and `readBin` returns
**0**. The ground-truth rule caught the lie; the Google Drive connector read straight through it.
**The generalisable lesson, and the reason this sat blocked for months: a filesystem sweep cannot
see a Google-native document. Search the Drive API by title before concluding data does not exist.**

**The reversal:** TwoRed's Trip Log is 7 rows; **Creamsicle's is the real one** -- dozens of daily
legs, 2021-09-23 to 2024-10-20, with departure/arrival times and cities, Miles, Duration, Stop time,
Adjusted Duration and Miles/Hour already derived. The **average-speeds analysis Kim named is the
readiest in the project, and it lives on the car the PKM had filed as the gap.** Creamsicle also
arrives with a **drafted 9-trip narrative**, not raw material.

Intake completed 2026-08-12. **Development is now Ready.**

_Superseded (2026-08-12):_ **Intake completed; development BLOCKED on Kim's data recovery.** Materials
moved out of `kimbridges-stories/underway/` (where they had been mis-filed as a story
since 2026-05-06) into `Projects/Smart_Car`. No code written yet, by design: the data
cannot support the reframed scope until Kim finds the paperwork on the other three cars.
He will do that in miscellaneous time, not in a focused session, which is why this file
reads Blocked rather than Ready.

**This was the third intake gap of the Jones / vouchr shape** -- real project materials,
a written charter, no `proj_*.md` and no index row, dormant three months.

## The fleet

_Given by Kim 2026-08-12. This replaces the single-car framing entirely._

| # | Name | Year / model | Power | Status | Data on hand |
|---|---|---|---|---|---|
| 1 | **TwoRed** | 2010 Smart Passion | ICE | **Owned** | Deepest by far — 293 fill-ups, 2010-2017, 52 states/provinces |
| 2 | **Two4Two** / **TwoFer** | Smart Pure | ICE | **Leased** from 2014-03-22; returned | **`TwoFer Gas Log` FOUND 2026-08-16** -- 7 fill-ups, 2014-03-22 (dealer, odo 0) to 2015-01-10, **1,209 miles, every one in Honolulu** |
| 3 | **Creamsicle** | 2016 453 ForTwo "Edition #1", white/orange, 0.9L turbo triple, 89 hp, six-speed | ICE | **Sold** to family 2024-10-20 | **FOUND 2026-08-16 — the second spine, and it is a DRAFT not raw material.** Gas log 2021-09-23 to 2023-09-27 (odo 30,290→51,345, metric BC fill-ups already normalised); trip log 2021-09-23 to 2024-10-20; Jan–Jul 2024 update **with lat/long**; a 9-trip narrative; a packing inventory. **28,697 miles / 1,123 days / 9,845 mi-yr**, 18 states + Canada |
| 4 | **Bordeaux** | 2018 Smart | **Electric** | **Owned** | Not yet inventoried |

**The arc the roster makes visible, which one car could not.** Sixteen years, four cars,
three ICE and one electric, spanning purchase, lease, resale and replacement — and the
choice made again three times after the first. That is the fleet thesis.

**★ THE 75,000-MILE QUESTION IS RESOLVED (Kim, 2026-08-12).** TwoRed is **about 20 miles
short of 75,000**. The Gas Log's 71,181 is simply where the *log* stops, not where the *car*
stopped. **The charter's title was right and my reading of it was wrong** — I had the
discrepancy filed as an open question on the strength of the spreadsheet alone. Kim is
updating the fuel logs so the remaining miles are properly filled in. **Until those updates
land, cite ~75,000 as Kim's figure, not as a value derived from the data.**

**Creamsicle's data is the second spine.** Kim has substantial records from driving it
across the country several times — enough, in his words, to complement TwoRed rather than
merely supplement it. **This changes the shape of the project:** it is not one documented car
plus three anecdotes, but two well-documented cars bracketing a lease and an EV.

**Creamsicle's purchase reason is recorded in `deferred.md` and is NOT FOR PUBLICATION**
(Kim, 2026-08-12). It concerns a family member's medical history. The public chapter says
the car was bought to help family; the reason stays in the PKM so a future session
understands why a fourth Smart appeared, and stops there.

**⚠ NAME COLLISION — `Bordeaux`.** The car shares its name with two published stories,
`/stories/bordeaux` and `/stories/bordeaux-2` (the wine booklets). **Rule adopted
2026-08-12: the car keeps its name in prose, but NO Smart_Car output — slug, filename,
figure, data file or deploy path — may take a `bordeaux*` form.** Costs nothing now and
prevents a future render from shadowing a live story. Folder/slug/name drift is already a
known root cause here — see `priorities.md` item 3.5.

## ★ THE FLEET SPLITS 2x2 -- BY DISTANCE ROLE, NOT POWERTRAIN (Kim, 2026-08-16)

**This supersedes the 2026-08-12 axis of "three ICE + one electric".** The organising split is
what each car was FOR:

| Role | Cars |
|---|---|
| **Long-distance** -- the document's subject | **TwoRed**, **Creamsicle** |
| **Honolulu short-haul** -- deliberately minor | **Two4Two / TwoFer**, **Bordeaux** (electric) |

**Why this is better than the powertrain axis:** it cuts across it (one Honolulu car is ICE, the
other electric) and it matches how the data was actually GENERATED -- Kim logged fuel while a car
was doing long trips and stopped when it wasn't.

**★ It also makes the thesis more honest, and therefore stronger.** "A Smart is not an urban
commuter" was never quite true -- **two of the four were exactly that.** The defensible claim is
that the SAME owner ran the SAME marque both ways for sixteen years, and only the long-distance
half was worth logging. **The Honolulu pair is not filler; it is the control that makes the
contrast measurable instead of asserted.**

## Intended analysis

_Kim, 2026-08-12._ Statistics with graphics, on:

- **Fuel costs** — per fill, per mile, over time and across the price swings of 2010-2017.
- **Daily driving distances** — what a day in a Smart actually looks like, against the
  urban-commuter assumption the whole document exists to refute.
- **Average speeds** — the Fourth Crossing file already carries time-zone-corrected
  `activity_time` and `miles_per_hour`, so this is the readiest analysis in the set.

**★ THE PHOTO LAYER EXISTS AND IT JOINS (2026-08-16).** Kim downloaded the Creamsicle photo set
into `images/Creamsicle/`. **38 files, 35 with GPS, 37 with timestamps, spanning 2021-09-23 to
2024-10-22** -- the full ownership and two days past it. Six Pixel models plus a Surface Duo; the
only two without coordinates are the oldest, from the pickup week.

**The join is clean because of a detail worth stating: `DateTimeOriginal` is recorded in LOCAL
time with `OffsetTimeOriginal` carrying the zone, and the logs record local clock times too.** So
photos join to fuel stops and trip legs on date + local time with **no timezone reconstruction** --
the very correction `2016_Fourth_Crossing_Analysis.xlsx` had to build a dedicated column for.

**It validates on the first record.** Earliest photo **2021-09-23 11:42**; first fill-up in the log
**2021-09-23 11:45, Nixa MO.** Three minutes -- the car at the dealership, minutes before its first
tank.

**Coverage: 8 of 9 trips.** T1 2, T2 **0**, WI caregiving 2, T3 3, T4 2, T5 9, T6 6, T7 4, T8 2,
T9 4, after-delivery 2, plus one staging shot at Torrance 2024-10-05, two days before T9 departs.
**T2 (LA->Madison, Oct 2021) is the blank** -- the solo run Kim describes as pushing his daily
limits. **NOT an absence claim:** the photos may be elsewhere or may never have been taken.

**Photographs of the cars in interesting places** are a first-class element, not decoration.
They are also the natural join to `Photo_Locations` and `timelinesr`: a geotagged photo and a
geocoded fuel stop are the same kind of record, and the fuel log already supplies a route to
hang them on.

**ICE and EV are kept SEPARATE (Kim, 2026-08-12).** Statistics run across the three gas
cars; Bordeaux is described qualitatively. **A $/mile axis spanning gasoline and electricity
was considered and declined** — it would force a comparison the charging data may not
support. Revisit only if kWh and charging-cost records turn up.

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

## Statement of intentions

Written 2026-08-12 so that a session opening this file cold knows what was decided and
what was deliberately left open.

**1. The document is about four cars.** TwoRed carries the deep quantitative spine because
that is where the data is. The other three carry what a single car cannot show:
replacement decisions, changing models, and the fact that the choice was made again.

**2. The Arctic Circle Challenge is CROSS-REFERENCED, never re-told.** It is already a
published story at `/stories/the-arctic-circle-challenge.html` (77 pp). The document links
to it and uses only its **data** -- fuel stops, temperatures, elevations -- inside the
analysis chapters. The 2026-05-08 charter's Chapter 5, which embedded the whole narrative
by iframe, is **superseded**: it would have put the same content at two URLs and made the
works register lie about what is published where.

**3. Reuse the existing packages.** This is Kim's standing rule for new documents
(2026-08-11) and it applies here: `timelinesr` and `Trip_Log` for the temporal spine,
`plainmaps` / `sf` / `tidygeocoder` for the geography, `Photo_Locations` for the
geotagging workflow. Write a new package only if something genuinely has no home.

**4. No number gets printed until it is sourced.** The 75,000-mile title claim is the
live example. The charter asserted it, this file could not confirm it, and the honest
state is *unresolved*. Same for the state and province counts.

**5. Production is staged, not simultaneous.** Data recovery first, then the ingestion
script, then the maps, then prose. The chapter architecture below is inherited from the
charter and is provisional -- it was written for one car.

## Locations
- Code: `G:\My Drive\Projects\Smart_Car` (bucket 2 -- code-as-source)
- **★ GOOGLE-NATIVE DATA, root of `G:\My Drive` (found 2026-08-16).** NOT reachable by any
  filesystem read -- `G:` shows zero-byte stubs. Read via the Google Drive connector by title.
  | Title | Kind | Holds |
  |---|---|---|
  | `Final Creamsicle Logs` | Sheet | gas log 2021-09→2023-09 (odo 30,290→51,345) + trip log 2021-09→2024-10 + summary |
  | `Creamsicle` | Doc | the 9-trip narrative, ~4,500 words, per-trip distances |
  | `Creamsicle_July_Fuel_Log_update` | Sheet | Jan–Jul 2024, odo 52,656→55,743, **lat/long** |
  | `Creamsicle Inventory` | Doc | Jun 2023 packing manifest + departure/arrival checklists |
  | `TwoFer Gas Log` | Sheet | car #2: 7 fill-ups, 2014-03→2015-01, 1,209 mi, all Honolulu |
  | `TwoRed_fuel` | Sheet | richer early TwoRed record: cumulative cost, $/mile, MPG-last-5, **ambient temperature in Notes** |
  | `TwoRed_fuel_June_2014` | Sheet | live original of the exported `.xlsx` |
  | `Travel/2016 Fourth Crossing Analysis` | Sheet | live original; `Travel/4th Crossing Fuel Stops` is a **My Map** |
- **Fuel receipt scans:** `CS_Fuel_Receipts_2021.pdf` (5.7 MB) and `2022_fuel_receipts_Jan-Feb.pdf`
  (6.5 MB) on Drive -- the primary sources behind the Creamsicle log's first two trips.
- **Existing analysis code:** `G:\My Drive\Projects\Photo_Mapping\Fuel_Analysis.Rmd` (2022).
  Predates this project and was written against the fuel data; read before writing new ingestion.
- Data: `G:\My Drive\Projects\Smart_Car\data`
- Source docs: `G:\My Drive\Projects\Smart_Car\source`
- Images: `G:\My Drive\Projects\Smart_Car\images`
- Docs/output: not yet; destination is kimbridges-documents
- GitHub: not yet
- **Superseded:** `G:\My Drive\kimbridges-stories\underway\Smart_car\` -- the original
  mis-filing. Copies still there; neither bridge deletes, so removal is Kim's.

## Key Files
- `data/TwoRed_fuel_June_2014.xlsx` — 4 sheets: Gas Log (293 fill-ups, 2010-2017),
  Locations (212), Trip Log (7), Canada2014 (24, metric). The foundational dataset.
- `data/2016_Fourth_Crossing_Analysis.xlsx` — 35 rows, time-zone-corrected activity time.
  The cleanest asset.
- `data/leased_smart.txt` — one line, the only record of car #2 so far.
- `source/Smart_Car_master_dictionary.pdf` — expedition names, dates, geographic targets.
- `source/Smart_Car.docx` — 10.3 MB. Largest section is the Arctic Circle Challenge,
  which is already published; treat as a quarry, not a draft.
- `source/Smart_Car_2016.pptx` — 2016 presentation.
- `source/charter_2026-05-08.md` — the original charter. **Kept verbatim as the historical
  record; superseded by this file on scope and on Chapter 5.**
- `images/Creamsicle/` — **NEW 2026-08-16.** 37 geotagged/timestamped trip photos plus
  `Creamsicle_profile.jpg`. **RULED by Kim: `two_smarts.jpg` BECAME `Creamsicle_profile.jpg`**
  (55,999 bytes), and the 439 KB `creamsicle.jpg` was deleted as a near duplicate. The old caption
  in this file -- *the current two, and one earlier car* -- was therefore wrong about what
  `two_smarts.jpg` showed; corrected here rather than carried forward.
  **Backstop, if the deleted file is ever wanted:** a 439 KB `creamsicle.jpg` survives at
  `kimbridges-stories\underway\Smart_car\` -- the superseded copy `deferred.md` has queued for
  deletion is currently serving as the backup. Do not delete that folder without checking.

## Related Projects
- `proj_Trip_Log.md` — the travel-photo + trip workflow; upstream.
- `proj_timelinesr.md` — timeline package, for the sixteen-year spine.
- `proj_Photo_Locations.md` — geotagging workflow.
- `proj_Plainmaps.md` — R mapping.
- `proj_kimbridges_stories.md` — holds the published Arctic Circle Challenge.

## ★ THE CHAPTER ARCHITECTURE IS NOW THE WEAKEST PART (2026-08-16)

Stated plainly so a future session does not inherit it by default. The project now has a
quantitative spine on two cars, a drafted narrative on one, a photo layer that joins to both, and
a defined minor role for the Honolulu pair. **The architecture below has none of that in view --
it was written for one car and one trip.** Redesign it before writing prose. Live candidates: the
2x2 role split as the top-level frame, and the two long-distance cars as parallel spines rather
than one primary plus supplements.

## Chapter architecture (PROVISIONAL — inherited from the one-car charter)
1. **Foreword** — origin (Paris to the US mainland) and the urban-myth thesis.
2. **The Canvas** — the geocoded constellation of every recorded fuel stop.
3. **The Expeditions** — fill-ups classified into trips via the master dictionary.
4. **The 4th Crossing** — daily friction: temperature against mileage, true average speed.
5. **The Extremes** — highest (Mount Evans), lowest (Death Valley), furthest.
6. **The Fleet** — NEW, and the reframing's payload: four cars, sixteen years.

Old Chapter 5 (Arctic Circle embedded) is deleted; see intentions item 2.

## Next Steps
1. **✓ DONE 2026-08-16 -- the Creamsicle data is found.** See Current Status.
2. **✓ DONE 2026-08-16 -- Two4Two/TwoFer has a machine-readable record.** `TwoFer Gas Log`.
3. **KIM, unscheduled:** update the TwoRed fuel logs so the last miles to ~75,000 are
   properly filled in. He named this himself. **Check `TwoRed_fuel` (the live Sheet) first** --
   it is a different and richer record than the exported `.xlsx`.
4. **OPEN QUESTION:** the Creamsicle trip log carries legs through **2024-10-20**, but no
   fill-ups past **2024-07-02** appeared in what was read. Trip 9 (the delivery run) may have
   fuel records elsewhere, or may genuinely have none. **This is not an absence claim** -- the
   sheet read may have been truncated. Verify before relying on it either way.
5. **KIM, unscheduled:** whatever exists for Bordeaux. Deliberately outside the statistics.
6. Then: the ingestion script assigning an `Expedition_ID` to every fill-up, across BOTH
   documented cars. Read `Fuel_Analysis.Rmd` first.
7. Then: the geocoded constellation map -- **the Jul-2024 update already carries lat/long**,
   so start there rather than geocoding from scratch -- and the three analyses Kim named.
4. Then: the ingestion script assigning an `Expedition_ID` to every fill-up, across BOTH
   documented cars rather than TwoRed alone.
5. Then: the geocoded constellation map, and the three analyses Kim named -- fuel costs,
   daily distances, average speeds.

## Collaborators / Dependencies
None.

## Blockers
**NONE as of 2026-08-16.** The binding constraint named on 2026-08-12 -- find the Creamsicle
files -- is discharged. Remaining gaps (Trip 9 fill-ups, the TwoRed top-up, Bordeaux) are
ordinary next steps, not blockers.

_Superseded 2026-08-12:_ **The fleet is now fully identified; the DATA for it is not yet gathered.** The binding
constraint has narrowed from "find out what the cars were" to **"find the Creamsicle
files"** -- Kim has them, they are substantial, and they are what makes the fleet framing
analytically real rather than narrative. Plus the TwoRed log top-up. Both unscheduled, by
his choice, in miscellaneous time.

---
## Log
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
