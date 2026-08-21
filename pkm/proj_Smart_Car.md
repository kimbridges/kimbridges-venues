# PROJECT: Smart_Car
_Last updated: 2026-08-16_
_Status: Active_
_Focus readiness: Ready_
_Tags: intake, data-recovery_
_Log: logs/proj_Smart_Car_log.md

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

**★★★ THE WRITING HAS STARTED. Two pieces drafted, both awaiting Kim's corrections (2026-08-20).**

**`book/index.qmd` — the Foreword, ~950 words.** The errand car, the parking spot, the two-visits dynamic, **Hawaii**, the three layers named lightly, and the scope boundary as subject rather than omission. **`book/is_it_safe.qmd` — chapter 2, ~2,300 words, two figures.** *Cute* as the opener, the safety-cell demonstration, both close calls unified as **one failure: a trusted pattern that did not hold**, the 100,999-mile denominator, and the wide tires priced rather than judged.

**The manuscript:** Quarto book at `Smart_Car/book/`, 15 chapters, `R/book_setup.R` as the single source of truth with `stopifnot()` row-count guards. **No number reaches a page without coming from an object.**

**The record behind it.** TwoRed: 294 audited fills, odo 4 → **71,283 at the Matson dock**, 65 errata, **139 legs across 12 trips**, 134 fills carrying time and temperature, time zones COMPUTED not stored. Creamsicle: 173 fills, 86 legs, **with STOPPED TIME** (median gross 43.5 vs net 51.0). **Sixteen of Kim's accounts collected verbatim, every one cross-checked.**

**Not ready:** the temperature effect is **retired**; the wide-tire interval is **not printable until re-derived**; the Canadian variance test is a NON-RESULT; the southern economy signal **cannot be settled at all**; route work partial at a 78% gazetteer join.

## The fleet

_Given by Kim 2026-08-12. This replaces the single-car framing entirely._

| # | Name | Year / model | Power | Status | Data on hand |
|---|---|---|---|---|---|
| 1 | **TwoRed** | 2010 Smart Passion | ICE | **Owned** | Deepest by far — 294 fills, 2010-2017, 45 states + 10 provinces, odo 4 → 71,283 |
| 2 | **Two4Two** / **TwoFer** | Smart Pure | ICE | **Leased** 2014-03 to 2015-01, returned | 7 fills, **1,209 miles, every one in Honolulu** |
| 3 | **Creamsicle** | 2016 453 ForTwo "Edition #1", white/orange, 0.9L turbo triple, 89 hp | ICE | **Sold** to family 2024-10-20 | **INGESTED 2026-08-19** — 173 fills, 86 legs, odo 30,290→58,903, **with STOPPED TIME**; 18 states + BC. **Zero southern fills.** |
| 4 | **Bordeaux** | 2018 Smart | **Electric** | **Owned** | Not yet inventoried |

**The arc the roster makes visible, which one car could not.** Sixteen years, four cars, three ICE and one electric, spanning purchase, lease, resale and replacement — **and the choice made again three times after the first.** That is the fleet thesis.

**★ THE 75,000-MILE QUESTION IS RESOLVED (Kim, 2026-08-12).** TwoRed is **about 20 miles short of 75,000**; the log's 71,181 is where the *log* stops, not the car. The mainland record now closes at **71,283 at the Matson dock**, so the ~3,700 remaining are Honolulu miles. **Cite ~75,000 as Kim's figure, not as derived.**

**Creamsicle's purchase reason is in `deferred.md` and is NOT FOR PUBLICATION** (Kim, 2026-08-12). The public chapter says the car was bought to help family and stops there.

**⚠ NAME COLLISION — `Bordeaux`.** The car shares its name with two published stories (`/stories/bordeaux`, `/stories/bordeaux-2`). **Rule: the car keeps its name in prose, but NO Smart_Car output — slug, filename, figure, data file or deploy path — may take a `bordeaux*` form.**

## ★ THE TWO STRUCTURAL RULINGS (Kim, 2026-08-16/17) — full write-ups in the log

**1. The fleet splits 2x2 by DISTANCE ROLE, not powertrain.** Long-distance: TwoRed, Creamsicle. Honolulu short-haul: Two4Two/TwoFer, Bordeaux. This supersedes the charter's ICE/EV axis and is the axis the data actually splits on.

**2. The scope boundary is FRACTAL** -- the same rule (log the long drives, not the city driving) operates at fleet, car and trip level. **So gaps here are DEFINITIONAL, never missing data, and must never be imputed.** Log distance runs ~95% of odometer miles, and that 5% IS the boundary as a number. **It appears one final time at the terminus: the ~3,700 Honolulu miles after shipping.**

## ★ THE ERRATA ARCHITECTURE (2026-08-17) — full write-up in the log

**Corrections live BESIDE the sources as a derived layer; sources are never edited in place.** `data/TwoRed_log_errata.csv` (65 entries, each with a basis and a status) is the correction of record; `twored_ingest.R` applies it. **Two rules that cost something to learn: an errata entry keys to a ROW, never a LABEL** (`Big Springs, Texas` appears three times and means three different places), and **reconstruct DISTANCES, never ODOMETER READINGS.** Full write-up in `logs/proj_Smart_Car_log.md`.

## ★ THE AMEX STATEMENTS ARE A THIRD INDEPENDENT RECORD (2026-08-18) — in the log

Kim scans everything. The AMEX statements and pump receipts recovered three contaminated 2016 rows, and when the paper log turned up months later it **matched them exactly on gallons and cost.** **Three independent records agreeing to the thousandth of a gallon.** The lesson was the search, not the data: it was the wrong KIND of search, not missing data.

## ★★ THE AUDIT TOOLKIT — SIX INSTRUMENTS (2026-08-18) — full write-up in the log

**pump identity** (gallons × $/gal = cost) | **economy** | **geography** (great-circle vs odometer) | **contiguity** | **price family / same pump** | **Kim's slashed zeros** — a physical mechanism, so it predicts error DIRECTION (Finding 033).

**None is redundant: every major error was caught by exactly one.** The decisive pairing is contiguity + arithmetic — where two adjacent rows share a value, **the row that BALANCES is the source and the row that FAILS is the copy.**

**Three standing limits.** For the 0/8 class **the scan is not evidence**. A **high road/straight-line ratio is sometimes a story**, not a defect. And every instrument has a **floor** (Finding 036). **★ The geography instrument also works in reverse: it RECOVERS what the log never named — Delaware, and probably Rhode Island (Finding 043).**

## ★★ THE CORRECTED DATASET (2026-08-18) — build story in the log

**Building `twored_ingest.R` forced three things a correction LIST could not:** a row **INSERT** (the Big Spring/Alpine chimera needed a SPLIT, not a relabel -- which is exactly why it passes the arithmetic test perfectly); **EXPLICIT** partial-fill flags rather than a threshold recomputed each run; and a **GUARD THAT REFUSES** any correction whose `old_value` misses its row. **A correction that cannot find its row is a BUG, not a no-op.** `logs/proj_Smart_Car_log.md`.

## ★★ FIRST ANALYSIS ON CLEAN DATA — SIX RESULTS (2026-08-18) — detail in the log

Median leg **251 mi**; log distance ~**95%** of odometer miles; lifetime **39.44 MPG**; **leg length is the strongest predictor, +4.61 MPG per 100 mi**; **no degradation in sixteen years**; **$0.0936 per mile**. Temperature is superseded and retired.

## ★★ THE WHEELS WERE NEVER ABOUT FUEL — THEY WERE ABOUT SAFETY — folded into ch.2

Stock narrow tires let a **variable** desert crosswind push the car out of lane; the cost was in the constant correcting, not the force. Smart Madness prescribed wide tires. **Handling is the mechanism of the safety thesis.** The economy difference is indistinguishable from zero under every specification, and the 1-3% theoretical penalty sits inside every interval — **but the interval itself is NOT PRINTABLE until re-derived (see `deferred.md`).**

## ★★ KIM'S FRAME: TWO LOGS, TWO SUBJECTS (2026-08-18) — the FABRIC of the three layers; in the log

*The fuel log is more about the CAR'S performance, while the trip log shows the HUMAN performance -- how far and fast can you expect to drive in a day, something I had no idea about until I started doing these drives.*

**It assigns instruments to questions** — economy, degradation, cost/mile and the wide-tire question are the CAR's; daily range, departure discipline and gross speed are the HUMAN's. Fuel records STOPS, trip records LEGS; **the odometer is the JOIN, not the topic.** **Bounded 2026-08-19:** the trip log records what the human ACHIEVED, in MEANS not variance; **the stories are the only record of what it COST** — and, per Finding 041, **of where the car was allowed to sit.**

## ★★ THE SCAN SWEEP, 2026-08-18 — full write-up in the log

All 15 scans read (22 on disk). Four results that must not be lost:

**1. The wheel change is DATED** — `NEW WHEELS @ 13510 miles`, 179 mi before the 2011 departure. **The estimate FLIPS SIGN with specification; that is the finding, not any one number.** ⚠ **And there were THREE wheel states** — see ch.2 above.

**2. ✗ THE TEMPERATURE EFFECT IS RETIRED.** n=94 gave -0.068, p=0.045; n=125 gives **-0.050, p=0.099**, **p=0.17** with controls — and **hot fills are on shorter legs.** **The record is good enough to RETIRE a result.**

**3. The slashed zero produced three more corrections and the control held.** Of 44 rows failing the pump identity: **permitted 8→0 fixes 4; forbidden 0→8 fixes 1; six controls fix 0.**

**4. Gross speed separates by ROAD.** 2011 interstate **47.6** | Frostburg 44.4 | Fourth Crossing 41.4 | Penultimate 40.3 | Dalton **31.7** | US-101 coastal **28.3**. **But it is a MEAN and cannot see road CHARACTER at all.**

## ★★★ THE LONG DAYS — ALL EIGHT COLLECTED, AND EVERY ONE CHECKS OUT (2026-08-19)

**Seventeen of Kim's accounts are verbatim in the log under COLLECTED STORIES, with the full confirmation table.** Four that changed something:

| day | leg | what the data independently shows |
|---|---|---|
| 2012-05-31 | St Louis → Columbus, 518 | lost near Urbana IL — **the 09:52 fill is at Champaign, one metro with Urbana**, carrying slashed-zero typo **L61**. Excess over direct I-70: **108 mi** |
| 2011-06-26 | Flagstaff → Holbrook, 100 | out **04:30**, in **06:45** — a hop existing only to arrive early for his nephew; **70 mi of local driving before the next departure IS the park tour** |
| 2012-06-14 | Billings → Pocatello, 449 | **65.5 mph gross, the fastest day in the record** — fast because Montana has nowhere to stop |
| 2017-01-06 | Brookings → Paso Robles, 562 | racing to his mother, 104. **32 degF, the coldest start in the record**; fill **22:04 at 68,731**, arrival **22:10 at 68,732** — one mile, six minutes |

**The other four — Sydney NS → Edmundston (555, off an overnight ferry, zero odometer miles across the water), El Paso → San Antonio (531, racing for Florida), LSM → St George (492, a half-day Las Vegas visit inside a 31 mph day), Bellingham → Grants Pass (488, Nancy off the red-eye) — all check out.**

## ★★★ THE FAVOURITE DRIVES (2026-08-19) — full write-up in the log

Kim's list, unprompted: the Rockies; the mountains down to the Oregon coast; **a morning through the West Virginia hills, villages fogged in and chimney smoke rising** — *I liked this so much, I drove it twice* (**see ROAD CHARACTER: two different highways, one country**); and the Dalton, *going where cars weren't intended*.

**★★ A routing app can manufacture the geographic test's own signature.** *Memo to self: stay on the main roads.* Excess road miles PLUS low economy from a rough surface is exactly what the test hunts. **It is not an error; it is a wrong turn a machine recommended** — measurable at 42 miles in the 2016 log. Third case where a high ratio wants a story rather than an errata entry.

## ★★★ THE FOURTH CROSSING LOG IS FOUND (2026-08-19) — full write-up in the log

**The reconstruction HELD: all 29 paper rows balance the pump identity, 25 of 29 match the corrected dataset, and the AMEX-derived values match the paper EXACTLY** — an independent source agreeing to the thousandth of a gallon. **There is no Phoenix fill.** Three of the four differences are mine: L62/L63, **I had written the AMEX MERCHANT NAME into the Brand field** where the paper says Valero and Conoco. **RULE: when a field is filled from a substitute source, record WHICH source — a merchant string is not a brand.** **Recovered:** the stuck day (2016-05-27, **42 miles of detour**); **a new longest day, 2016-06-19 Richmond MO → Denver, 640 mi at 58.6 mph**; **107 degF into St George, the hottest reading in the record.**

## ★★★ THE STRESSFUL MILES ARE INVISIBLE — A DIFFERENT SILENCE FROM FINDING 036 (2026-08-19)

Kim's testable claim: *we were plagued by potholes. We often slowed to avoid damage... Those miles, which were mostly across the Canadian Plains, were very stressful.* **Both instruments were pointed at it. Neither sees anything.** Canadian Plains median gross **44.5 mph** against US Plains 45.0 and a whole-record 40.5 — **FASTER than his sixteen-year median.**

**★★★ HIS CORRECTION INVERTS THE LOGIC.** *I couldn't go slow as big vehicles kept moving at highway speeds. Hence the rear view mirror checks.* **His account PREDICTS no speed effect** — he was not free to drive slowly, so the average had to stay up. **The high gross speed is not evidence against the stress; it is the mechanism OF it.** And it names the missing quantity: **within-leg VARIANCE. A trip log samples the day TWICE — everything between is averaged away BY CONSTRUCTION.** *(The Canadian variance test is a NON-RESULT, not a null: those rows are converted from litres and CAD and unit-normalising is still OPEN.)*

**★★★ WHY THIS IS NOT FINDING 036.** 036 was about events that generated NO observation. These miles generated a FULL set and every one is normal. **BOTH LOGS MEASURE OUTPUT. NEITHER MEASURES COST TO THE DRIVER. Vigilance has no column** — and per ROAD CHARACTER, **neither does tedium.** **The stories are the sole record of a dimension the data cannot reach.**

## ★★ TWO RELOCATIONS, AND THE LAST YEAR'S SHAPE (2026-08-19) — full write-up in the log

A page filed as a duplicate carried an annotation its twin did not show: **`Relocation  1141 miles`**. **September 2016 was not a tour; it was the one-way relocation of TwoRed to a close colleague's farm in Eugene** — which is why the car was there when the January 2017 call came. **February 2017 is a SECOND relocation** (Mentone → Long Beach → Eugene), after which the car sits until 20 May. **The last year's shape: the car stops touring, starts commuting between two homes, then ships.**

**★ METHOD: two scans of the same page are not the same evidence.** A marginal annotation can be lost to cropping, threshold or the fold. **Diff a duplicate rather than discarding it.**

## ★★★ THE END OF THE MAINLAND RECORD: 71,283 AT THE MATSON DOCK (2026-08-19)

On the BACK of the last fuel sheet, circled: **`5/22/17  71,283  LV Seattle @ Matson`**. No travel log because *we got on a plane and left TwoRed at the dock for shipping.* Last mainland miles **Toledo WA 71,181 → Seattle 71,283 = 102**, against ~100 road miles; both readings documented.

**This closes the first question the project ever asked.** The charter said ~75,000, the log stopped at 71,181, and the gap looked like missing data. **Mainland 71,283; Kim's figure ~74,980; implied Honolulu miles ~3,697.** **The gap was never missing data — it is the scope boundary, quantified at the terminus.**

**★★ Two anomalies at the end that are NOT economy readings.** The final two fills read **52.4 and 93.0 MPG** on **4.333 and 2.496 gallons against a lifetime mean of 6.24.** **A vehicle handed to Matson must arrive with a low tank** — a tank managed DOWN for shipping, not a measurement of the car. **★ General rule: the first and last rows of any record are the least trustworthy, because they are taken while the measuring itself is being started or stopped.** The first fill carries a slashed-zero error (L59); the last two are shipping artifacts. **Trim the ends before quoting an extreme.**

## ★★★ THE OPEN QUESTIONS ARE CLOSED (2026-08-19/21) — full working in the log

**1. The 46 Dalton miles are 32 + 14 — Coldfoot → Wiseman.** Two Yukon River Crossing fills split the leg: north of the river 115 out / **147 back (+32)**; the Wiseman spur is ~16 road miles, so **out and back is 32, to the mile.** *A matching TOTAL does not mean a matching ROUTE; a SPLIT total localises the discrepancy.*

**2. THE PENULTIMATE STATE IS VERMONT** — *a lawyer who has an office in NH, but lives nearby in Vermont. I drove to his house.* **Exactly the anomaly the record flagged and could not read:** Hartland VT → Lebanon NH, **two nights and 59 odometer miles for an eighteen-mile drive**, across the Connecticut River.

**3. ★★★ THE STATE COUNT IS 49 AND 10, ON KIM'S TESTIMONY (2026-08-21) — and my framing was wrong.** *Some states, like Florida, didn't have a fuel stop or a stop at night. So they aren't in the data... Take my word for it.* **I had been writing that TwoRed's list and Kim's list were two different quantities. They are one quantity and a log that witnesses 45 of it.** **Finding 043: a count DERIVED from a record inherits the record's resolution, silently, because the count looks like an ordinary number.** **The four unwitnessed states are three kinds of silence:** **Delaware** recoverable by geometry (264 odometer miles where the only Delaware-free road is ~305); **Rhode Island** strongly indicated (the Douglas MA fill sits on MA-146, the Providence road; 287 mi fits the coastal route at ~285 against ~265 inland); **Florida** unrecoverable by the log (Finding 036) — but **★★★ STYX RIVER ROAD (Finding 044): incidental knowledge is evidence of PRESENCE, and unlike *is this Florida?* it is FALSIFIABLE.** A fact the witness had no reason to want; its uselessness certifies it; **South Dakota** — **RECOVERED 2026-08-21.** Kim drove north from Nebraska on a rural road for the sole purpose of crossing the line, met a **convoy of storm chasers** coming the other way, crossed, and turned around. The record holds it: 2012-05-27, **Douglas WY → Bridgeport NE reads 255 odometer miles against ~175 direct, ratio 1.83 — the most indirect stretch in sixteen years** — on the northern road through **Chadron NE, twelve miles from the border.** ⚠ **My earlier *no leg has room for it* was wrong: the arithmetic was right and the HYPOTHESIS was wrong — I had assumed visiting a state meant going somewhere IN it. A negative result is only as strong as the hypothesis it tested.** **Provinces confirmed at exactly ten by the record itself.**

**4. ⛔ THE TEXAS ON-RAMP — CLOSED BY REQUEST.** **No session may localise it; no published text may place it more precisely than NEAR FORT WORTH.**

## ★★★ CREAMSICLE IS INGESTED — THE SECOND SPINE EXISTS (2026-08-19)

`creamsicle_ingest.R` reads the exported workbook and emits `Creamsicle_fuel_clean.csv` (**173 rows**) and `Creamsicle_trip_clean.csv` (**86 legs**). Same architecture as TwoRed: **the source is never edited**, interleaved total/average rows are skipped programmatically, and **the skip counts are reported** (196→173, 119→86, 10→6) per Finding 032.

**It arrived clean.** Odometer **30,290 → 58,903, strictly increasing.** Pump identity: **143 of 170 US rows balance to under half a cent; exactly THREE fail by 2c or more**, and all three resolve — **C01 Oxnard** $/gal 4.399→3.999, **the cell IDENTICAL to the Gallons cell**, caught by contiguity; **C02 Miranda** a 59/95 transposition; **C03 Hays** 3.499→3.449. My recomputed MPG matches Kim's own column to **0.005**. **The three BC rows carry litres and CAD alongside gallons — the unit problem TwoRed still has is already solved here.**

### ★★★ AND IT MEASURES THE THING TWORED CANNOT

**Creamsicle's trip log records STOPPED time.** Across 84 timed legs:

| | |
|---|---|
| median GROSS mph | **43.5** |
| median NET mph | **51.0** |
| **the gap** | **7.5 mph** |

**That is the first empirical size for the driving-vs-living conflation named in FIVE THINGS #5**, and it makes every TwoRed gross speed readable as a **ceiling roughly 7-8 mph below actual driving speed.** The vivid case: **2024-10-20, Wisconsin Dells → Madison, 50.3 miles, 5 hours elapsed, 4.5 of them stopped, gross 10.1 mph, comment `Cranes`.**

### The two cars, side by side

| | TwoRed | Creamsicle |
|---|---|---|
| median MPG | 39.12 | 40.59 |
| **cost per mile** | **$0.0939** | **$0.1183** |
| median leg | 251 mi | 166 mi |

**The 26% cost-per-mile difference is almost entirely FUEL PRICES, not the car** — 2010-2017 against 2021-2024. **Do not write it as a car comparison.**

## Intended analysis

_Kim, 2026-08-12._ Statistics with graphics, on:

- **Fuel costs** — per fill, per mile, over time, across the 2010-2017 price swings.
- **Daily driving distances** — what a day in a Smart actually looks like, against the urban-commuter assumption the document exists to refute.
- **Average speeds** — the Fourth Crossing file already carries time-zone-corrected `activity_time` and `miles_per_hour`.
- **★★ THE PARKING CONSTELLATION (added 2026-08-19)** — where the car SLEEPS is a second geography the record has always held: **86% of elapsed days are dormancy; 34 of the 35 long spells are CA/AZ/OR.** Map it against the driving constellation.

**★ THE PHOTO LAYER EXISTS AND IT JOINS (2026-08-16).** `images/Creamsicle/`: **38 files, 35 with GPS, 37 with timestamps, 2021-09-23 to 2024-10-22.** **The join is clean because `DateTimeOriginal` is LOCAL time with `OffsetTimeOriginal` carrying the zone, and the logs record local clock times too** — so photos join on date + local time with **no timezone reconstruction**. **It validates on the first record:** earliest photo **11:42**, first fill **11:45 at Nixa MO** — the car at the dealership, minutes before its first tank. **Coverage 8 of 9 trips**; T2 (LA→Madison, Oct 2021) is the blank — **not an absence claim.**

## What the data ACTUALLY contains -- moved to the log 2026-08-18

The 2026-08-12 intake audit (charter claims vs what the files hold: 293 fill-ups not "nearly 300", range to 2017-05-22 not June 2014, 52 State values not "49 states and 10 provinces") is verbatim in `logs/proj_Smart_Car_log.md`. Its conclusions are all carried forward above or in `deferred.md`.

## Statement of intentions

_Written 2026-08-12; item 6 added 2026-08-20._

**1. The document is about four cars.** TwoRed carries the deep quantitative spine; the others carry what one car cannot show.

**2. The Arctic Circle Challenge is CROSS-REFERENCED, never re-told.** Already published (77 pp). Use only its **data**. The charter's Chapter 5 is superseded.

**3. Reuse the existing packages** (Kim's standing rule): `timelinesr`, `Trip_Log`, `plainmaps`/`sf`/`tidygeocoder`, `Photo_Locations`.

**4. No number gets printed until it is sourced.** The province count is now confirmed (10); the state count is not (45 documented of 49). **A crash-rate or rental-rate comparison needs a cited figure first.**

**5. Production is staged.** Data recovery, ingestion, maps, prose. **The architecture is settled; the writing has begun.**

**6. ★ ESTABLISH EARLY THAT THEY LIVE IN HAWAII.** Kim, 2026-08-20: *if you didn't know that you might wonder why we didn't just drive to my mother's place.* **It explains the dormancies (every gap is a flight), the scope boundary (the ~3,700 excluded Honolulu miles), and the second layer-one inversion — they live in a city and bought a city car to escape city driving.**

**7. ⚠ PRIVACY — standing constraints.** Creamsicle's purchase reason is NOT FOR PUBLICATION. The Texas on-ramp is never narrowed beyond *near Fort Worth*. No `bordeaux*` slug or filename. **⛔ The Eugene holding is *a close colleague* — NOT NAMED (Kim, 2026-08-20; the name is in the log for continuity only).**

**★ The principle behind that ruling, because it governs the whole parking chapter:** the same colleague is named in **seven live documents** on `kimbridges-documents` and those stand. **Naming someone as a COLLABORATOR is ordinary; naming them as a LOCATION is not. The constraint is on pairing a name with a private fact — a home, a farm, that a car was kept there.** Apply it to the niece at Mentone and the St Louis business too, and get Kim's confirmation on each.

## Locations
- Code + manuscript: `G:\My Drive\Projects\Smart_Car` (bucket 2). **`book/` is the Quarto book** — `_quarto.yml`, 15 chapter `.qmd`s, `R/book_setup.R`, `figures/`, output-dir `_output`. `data/`, `source/`, `images/` alongside.
- **★ GOOGLE-NATIVE DATA, root of `G:\My Drive`.** NOT reachable by filesystem read — `G:` shows zero-byte stubs. Read via the Google Drive connector BY TITLE. Full inventory in the log. The three Creamsicle files are exported and ingested; **still live-only: `TwoRed_fuel`** (richer early record, **~141 more fill temperatures in Notes**), `TwoFer Gas Log`, `Creamsicle Inventory`, `Travel/2016 Fourth Crossing Analysis`.
- **Fuel receipt scans on Drive:** `CS_Fuel_Receipts_2021.pdf`, `2022_fuel_receipts_Jan-Feb.pdf` — Creamsicle's first two trips.
- **Existing analysis code:** `Projects\Photo_Mapping\Fuel_Analysis.Rmd` (2022); read before writing new ingestion.
- **Deploy target: `kimbridges-documents`.** Drag the folder named in `output-dir` (`_output`), never the project root — Netlify Drop REPLACES the whole site.
- **Superseded:** `G:\My Drive\kimbridges-stories\underway\Smart_car\` — the original mis-filing. **Do not delete: it is the backstop for `creamsicle.jpg`.**

## Key Files
- `data/TwoRed_fuel_June_2014.xlsx` — 4 sheets: Gas Log (293 fills), Locations (212), Trip Log (7), Canada2014 (24, **metric — normalisation OPEN**). The foundational dataset.
- `data/2016_Fourth_Crossing_Analysis.xlsx` — 35 rows, time-zone-corrected activity time. The cleanest asset.
- **`data/Fuel_and_Trip_Logs/*.pdf` — 22 scans, 2010-2017, Kim's paper field sheets.** Primary source behind all 65 errata. **Not in the mirror — Finding 038.**
- **13 trip-log CSVs, 139 legs** (132 timed), each carrying time, city and temperature at BOTH ends, both odometers, written distance, odometer delta, timezone shift, elapsed hours, gross mph, and per-row notes.
- `data/TwoRed_fuel_clean.csv` (294), `TwoRed_log_errata.csv` (65), `TwoRed_fuel_timetemp.csv` (134), `TwoRed_city_timezones.csv` (121 cities).
- **Creamsicle:** `Creamsicle_fuel_clean.csv` (173), `Creamsicle_trip_clean.csv` (86), `Creamsicle_log_errata.csv` (3); built by `creamsicle_ingest.R`.
- `source/` — `Smart_Car_master_dictionary.pdf` (expedition names, dates, targets); `Smart_Car.docx` (10.3 MB, largest section is the already-published Arctic Circle Challenge — **a quarry, not a draft**); `Smart_Car_2016.pptx`; `charter_2026-05-08.md`, kept verbatim, superseded on scope and Chapter 5.
- `images/Creamsicle/` — 37 geotagged trip photos + `Creamsicle_profile.jpg`. **Backstop for the deleted `creamsicle.jpg`: a copy survives at `kimbridges-stories\underway\Smart_car\` — do not delete that folder without checking.**

## Related Projects
- `proj_Trip_Log.md` — the travel-photo + trip workflow; upstream.
- `proj_timelinesr.md` — timeline package, for the sixteen-year spine.
- `proj_Photo_Locations.md` — geotagging workflow.
- `proj_Plainmaps.md` — R mapping.
- `proj_kimbridges_stories.md` — holds the published Arctic Circle Challenge.



## ★★★ ROAD CHARACTER — A TAXONOMY FROM EXPERIENCE (Kim, 2026-08-20) — ch.6 material

He withdrew his own West Virginia answer after checking a map: **different highways, one country** — *rolling, tree-covered hills, a winding highway, small villages tucked in the valleys.* **The memory retained a LANDSCAPE TYPE, not a road** (Finding 039 amended). **New category — TREE TUNNELS:** *straight divided highway lined by a dense thicket of trees. Flat. Monotonous.* In the South. Both are a relief from *nearly straight freeways lined by commerce, billboards and wall-to-wall housing.*

**★★★ Gross speed cannot see it — Deep South 40.3 mph (n=10) vs Appalachian 38.0 (n=6), p=0.42 — and that null COMPLETES A PAIR** with the Canadian Plains. **The most STRESSFUL miles and the most MONOTONOUS miles both read as unremarkable fast runs. The record is blind to the driver's experience at BOTH ends of the scale.** *Vigilance has no column; neither does tedium.*

**⚠ A SIGNAL THAT CANNOT BE SETTLED.** South **-3.18, p=0.023** (n=30); **-2.61, p=0.065** with era; **-5.81** on 16 temperature-stamped rows with temperature null. **Unstable across subsamples, and Creamsicle has ZERO southern fills — the sample is closed at 30.** **DIFFICULTY strand; print the fact that it cannot be settled, not the coefficient.**

## ★★★ THE ANCHOR, THE PARKING, AND HAWAII (Kim, 2026-08-20) — now DRAFTED as the Foreword

**★★★ EVERY COMPLETE TRIP IS A LOOP FROM ONE PARKING SPACE.** Eight of thirteen logged trips begin and end at Lake San Marcos, and **every complete one from 2011 through the Fourth Crossing does** — including the Arctic run. The anchor: **18 dormancies, 2010-07-26 to 2016-08-02**, and **86% of the record's elapsed days sit inside a dormancy of two weeks or more.** **The long-distance driving is not a departure from the errand purchase; it is structurally hung off it.**

**THE CAR LEFT BECAUSE THE PARKING SPOT DID.** *She moved to a more secure facility in August and that place didn't have parking for TwoRed.* Last anchor fill **2016-08-02**; his **niece at Mentone** holds the car five weeks; the coast run to Oregon follows. **She died in January 2017 with the car already in Eugene. Adjacent facts, separate causes.**

**⚠ FINDING 041 — my favour map from dormancy locations was mostly wrong.** *The other places are simply hotel/motels we stopped at along the way.* **A fill records where fuel was BOUGHT, not where the car came to REST** — a fuel row is a **TRANSACTION, not a STATE.** **What survives:** the durations; the anchor (confirmed by Kim independently); and **SIGNAL HILL = SMART MADNESS**, 7 fills 2011-2017 at the seams of expeditions — **the 2013-09-06 one is inside the Arctic trip's last leg, so the car came off the Dalton and went to the shop on the way home.**

**The four holdings, all named by Kim, none recoverable from the data:** his mother's facility; his niece at Mentone; **a close colleague's farm with a huge garage in Eugene (⛔ NOT NAMED)**; and the **St Louis car wash near the airport — the only PAID holding in sixteen years**, improvised on sight.

**★★★ AND THEY LIVE IN HAWAII (intentions item 6).** **Every dormancy is a FLIGHT home**; the **~3,700 excluded Honolulu miles are the only miles driven where they live**; and it **inverts layer one a second time** — **they live in a city and bought a city car to escape city driving.**

## ★★★ THE SAFETY QUESTION IS LAYER ONE'S ACTUAL CONTENT (Kim, 2026-08-19) — now DRAFTED as ch.2

**The preconception is not *it's a city car*. It is a question with a fear in it: IS IT SAFE?** — and it arrives as **affection**, not hostility: people say *I like your car* first and worry second. Kim's answer has three parts and only the third is the thesis: the engineering answer (Mercedes, the safety cell, *see the silver part?*, the race drivers with their hands up) which by his own verdict lands as **maybe, maybe not**; the empirical answer; and **SMALL AND NIMBLE ARE COMPONENTS OF SAFETY**, which INVERTS the preconception rather than rebutting it.

**★★★ AND BOTH CLOSE CALLS ARE ONE FAILURE: A TRUSTED PATTERN THAT DID NOT HOLD.** *You learn the pattern. You begin to trust your experience. Accidents happen when the pattern doesn't hold.* The Dalton hazard with no flag; the ramp with traffic coming up it. **You cannot drive without trusting patterns and you cannot make patterns hold, so the only thing left to ask of a car is what it can do in the second after one breaks.** **A safety cell is for the crash you are having; handling is for the crash you are not going to have.**

**Layer 3 has the denominator: 100,999 documented miles across three cars**, 467 fills, 225 legs, 45 states, 10 provinces, no crash. **Layer 2 has the numerator — a crash avoided buys no fuel and ends no leg.** **Miles without near-misses are absence of evidence; near-misses without miles are anecdote.**

**★ The wide tires close the loop:** bought for control in a variable crosswind — **the difficulty was the VARIANCE, not the force** — so the fuel data's job was to PRICE the safety modification, not judge it. **The interval is currently NOT PRINTABLE (see `deferred.md`); the claim stands under every specification.**

**⚠ Disciplines held in the draft:** *granted, no crash testing* — the record cannot answer a counterfactual; and **101,000 crash-free miles are not oversold** — one prudent driver, mostly interstate, mostly daylight. **The miles show the car did not prevent sixteen years of safe driving; the near-misses are where the car actively contributed.**

## ★★★ CHAPTER ARCHITECTURE — SOLVED. KIM'S THREE LAYERS (2026-08-19) — full development in the log

*The Smart Cars are the "hook"... The two aspects of performance, car and human, is the fabric... The data become the real issue. The complexities and difficulties in the process of data collection, transcription, and cleaning on one end. At the other end, the opportunities for interesting, and perhaps unique, ways to analyze and display the results... People see the unusual cars (and have preconceived notions). The drives make interesting stories. The data give satisfying answers to questions, even those you didn't know you had.*

**TWO LOGS, TWO SUBJECTS was an excellent SORTING rule and a useless ORDERING rule.** Three layers says what a reader meets first and why they keep going, and the two compose: **the car/human fabric runs THROUGH all three. It is the weave, not a chapter.**

**★ Three DEPTHS of one material, each bought by the one above.** Without the preconception the drives are travel; without the drives the numbers have no question; without the numbers the stories are anecdote.

**★★ *Questions you didn't know you had* is load-bearing, and proven:** *what does a day OFF the highway look like?* — **70 miles at Holbrook, 59 at Hartland.** *How much of a speed is living?* — **7.5 mph.** *Can a record hold a state it never names?* — **Delaware.** *Where does a car sleep?* — **86% of elapsed days, and the answer was a parking spot at his mother's.**

**★ EDITORIAL RULE:** an analysis earns the ANALYSIS strand only if it answers a question the drives raised. **Results with no story belong to the DIFFICULTY strand** — the retired temperature effect, the wide-tire interval straddling zero, the Canadian non-result, the unsettleable southern signal. **All are the data being honest about what it cannot say.**

**The three layers are the three instruments — preconception, memory, record — and they fail differently:** the record is silent where its resolution cannot reach (036); **the memory keeps content and loses index, and keeps CLASSES while naming specifics (039); and a fuel row is a TRANSACTION, not a STATE (041).** The preconception is simply wrong, which is the point of the book. **The reading structure and the working structure are the same structure. Say so in the Foreword.**

## ★★★ THE CHAPTER LIST IS APPROVED AND THE MANUSCRIPT EXISTS (2026-08-20)

**Kim approved the 13-chapter design, the four parts, and the interleaving of the difficulty strand** — *It is better to have more (the 13) than fewer... I agree with having the data spread through the story.* **The charter's six-chapter list is retired.** Full draft and rationale in the log.

**FOREWORD** Why there was a car at all — the parking spot, and **Hawaii, early**. | **PART ONE, THE CAR:** 1. *These are small cars!* · **2. Is it safe? ← write first.** | **PART TWO, THE DRIVES:** 3. The anchor · 4. The expeditions · 5. The long days · 6. The roads · **7. What the driving cost ← the hinge.** | **PART THREE, THE DATA (both ends interleaved):** 8. Sixteen years of paper *(diff)* · 9. How you know a number is wrong *(diff)* · 10. What the car cost *(anal)* · 11. What a day in a Smart actually looks like *(anal)* · 12. The two constellations *(anal)* · **13. What the record cannot say *(diff, closing argument)*.** | **AFTERWORD** The choice made again.

**★★ THE STRUCTURAL ARGUMENT KIM ACCEPTED: the difficulty chapters EARN the analysis chapters.** A reader cannot believe *$0.0939 per mile* until they know how the cost column was audited. **Audit before economy and the number is credible; audit after and it reads as a defence.**

**⛔ RULED OUT BY KIM (2026-08-20): the PKM's own tooling failures are NOT book material.** *They are just part of the process that we work through together. Nothing more.* **The difficulty strand is about THE RECORD — Kim's handwriting, the paper, the reconstruction, the resolution limits.** Findings 037/040 stay in `pkm_findings.md` and never enter the manuscript.

### ★ THE MANUSCRIPT SKELETON EXISTS — `G:\My Drive\Projects\Smart_Car\book\`

Quarto **book**, `output-dir: _output`, matching the house pattern (`whittakerr`, `storylines`): `code-fold: true`, `editor: visual`, numbered sections to depth 2, warnings/messages off. **15 `.qmd` files, one per chapter plus front and back matter, all listed in `_quarto.yml` and all present — verified both ways.**

**`R/book_setup.R` is the single source of truth**, sourced by a `setup` chunk at the top of every chapter. It reads only the CORRECTED datasets (294 TwoRed fills, 139 legs, 173 + 86 Creamsicle), computes timezones as a derived layer via `trip_logs_read.R`, and ends with **`stopifnot()` guards on the row counts — so any number printed in the book comes from the objects, never typed.** It also sets a shared `theme_smartcar()`, **a starting point rather than a decision**, so the figures read as one system.

**Each chapter file carries a SCAFFOLD comment** — purpose, the verified material and Kim's quotes on hand, and the open items and privacy constraints that apply to that chapter. **Delete each block as its chapter is written.** No blank pages.

**★ KIM WANTS GRAPHICS AND PHOTOS.** *When we get to the data, I'm expecting we'll be doing some interesting graphics. At some point, we'll want to slip in some pictures, too.* `figures/` created; `images/Creamsicle/` holds 37 geotagged, timestamped photos that **join to the logs on date + local time with no timezone reconstruction.** **The photo layer is chapter 12's material and needs a TwoRed equivalent — ask Kim what exists.**

## ★★★ CHAPTER 1 IS DRAFTED (2026-08-21) — `book/small_cars.qmd`, ~720 words

**Its job had to be redefined**, because the Foreword now names the four cars and ch.2 owns the safety-cell demonstration. **Chapter 1 is about the OBJECT: how small, why it's that shape, and the fleet as four decisions rather than one.**

**★★ THE CHAPTER'S NUMBER, and it is a good one.** **TwoFer went 1,209 miles in its entire ten-month life, all of it in Honolulu. TwoRed's median driving day was 305 miles.** So **TwoRed covered TwoFer's whole existence in about four days of driving.** Same manufacturer, near enough the same car — **the difference isn't in the machine, it's in what was asked of it.** That is layer one's argument in one comparison, and it uses the leased car, which had looked like the fleet's least interesting member.

**The shape argument:** most small cars are ordinary cars made smaller; a Smart isn't. **Mercedes started from the steel cell and built outward, so the cell IS the structure and the coloured panels aren't** — which is why the proportions look wrong to an eye trained on normal cars, and why the panels are a different colour. **They aren't pretending to be structural, so they don't have to match.**

**Four cars, four decisions, each with more information than the last** — buy 2010 (a price list and a parking space, nobody had crossed a continent in one yet), lease 2014, replace 2016 (*by then we knew exactly what we were buying, because TwoRed had already been to the Arctic Circle and back*), electric 2018. **One car you like is taste; four chosen again over sixteen years with a continent's evidence in between is a judgement.**

**Figure handling changed:** `@fig-day-one` is now DEFINED in ch.1 (the reader meets the car, with Kim beside it for scale) and **referenced** from ch.2 for the silver band. Cross-references verified across all 15 files — **no dangling refs, no duplicate ids, both image paths resolve.**

**⚠ FOUR GAPS MARKED, and ch.1 needs more from Kim than ch.2 did** — it is a chapter about living with the object, and the record holds almost none of that. See Next Steps.

## ★★★ FOREWORD AND CH.2 — KIM'S FIRST PASS DONE (2026-08-21)

**Approved:** the voice; **the three layers stay in the Foreword** (*people can see what's ahead*); **chapter 2's story order stays** (denominator before the close calls).

**★ VOICE RULE, STANDING: use contractions.** *I like to use conjunctions (e.g., "I'll") more than you've put into the document. I think it makes it more casual, which is part of this document's flavor.* **36 applied across the two drafts; apply from the first sentence in every future chapter.**

**★★ ADDED AT KIM'S REQUEST — `## The four of them`**, a short Foreword section introducing the cars by name and character, because **they are the main players and the Foreword never named them.** TwoRed (2010 Passion, red and silver, the crossings, the deep record); **Two4Two/TwoFer** (leased ten months, **1,209 miles, never left Honolulu** — the car that shows what a Smart looks like used the way everyone assumes); **Creamsicle** (2016, white and orange, bought to help family and sold to family, **and its logs record stopped time**); **Bordeaux** (2018, electric, the one in the driveway now). Closes on the fleet thesis: **we kept choosing the same kind of car, three more times after the first.**

**Foreword now ~1,150 words. Chapter 2 unchanged in structure**, with the state figure corrected to 49 and a forward pointer to ch.13.

## ★★★ CHAPTER 2 IS DRAFTED (2026-08-20) — `book/is_it_safe.qmd`, ~2,300 words

**Kim's material closed every gap and gave the chapter its thesis** — see THE SAFETY QUESTION above for the argument. Three things worth keeping here:

**The reaction was period-specific and faded.** *By the time we were driving Creamsicle, Smart cars were relatively common.* Nobody crossed a forecourt. **The book should admit the hook belongs to a particular decade rather than pretend the car is still startling.**

**There were THREE wheel states, not two** (Kim, 2026-08-20): stock narrow, wide alloy, **and STEEL RIMS for the 2013 Dalton run** — 21 fuel rows every before/after analysis had counted as *after*. Excluding them the coefficient weakens from -1.82 (p=0.058) to -1.47 (p=0.129); **the conclusion survives.** ⚠ **The Alaska rows are NOT evidence about steel rims** — wheels are perfectly confounded with the whole expedition.

**Figures wired:** `@fig-day-one` (the day it arrived, on the original narrow tires, **with the silver safety cell visible** — the photo does the pointing the text describes) and `@fig-wide-wheels` (after Smart Madness; visibly wider). **Book images live in `book/images/`** so Quarto copies them into the output; the canonical archive stays in `Smart_Car/images/`. ⚠ **`*.jpg` is in the mirror's `.gitignore`, so photographs are NOT in the versioned backup** — Kim's own copies are the record.

## Next Steps
1. **★★★ KIM — CHAPTER 1 NEEDS FIVE THINGS ONLY HE HAS.** (a) **The physical experience** — getting in and out, two people and a week's luggage, headroom, and the early automated-manual gearbox with its famous pause. (b) **Why a Smart specifically** in 2010; there were other small cars. (c) **Why lease TwoFer at all** in 2014, and what that settled. (d) **BORDEAUX IS A BLANK** — year, character, and how electric changes the calculation. (e) **Does he still have TwoRed?** The fleet table says owned.
2. **KIM:** the Yukon pothole in his own words — the last thin patch in ch.2. Also the tree-tunnel stretches, and the remaining privacy calls (the niece at Mentone; the St Louis business). **The Eugene colleague is ruled NOT NAMED.**
3. **THEN ch.3, `the_anchor.qmd`** — the most material of any undrafted chapter, and the Foreword already sets it up.
4. **TASK before any figure is printed:** re-derive the wide-tire interval with a WRITTEN specification. **A number that cannot be reproduced is not sourced.**
5. **SMALL TASK:** TwoFer's 1,209 miles is a TYPED constant in ch.1 and ch.2 (commented as such). **The `TwoFer Gas Log` Sheet is live-only and never ingested** — 7 fills would take ten minutes and put the last car in the corrected dataset.
6. **DEFERRED UNTIL A CHAPTER ASKS.** Canada2014 units, Creamsicle's timezone table, `Expedition_ID`, the constellation maps, the ~141 extra fill temperatures in the live `TwoRed_fuel` Sheet.
7. **⚠ `*.jpg` is gitignored in the mirror** — photographs are not in the versioned backup.

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

The dated log for this project lives in `logs/proj_Smart_Car_log.md`. Verbatim and unedited.
New entries go there, not here. (Split 2026-08-18 by pkm_health.R)
