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

**★★★ THE RESEARCH PHASE IS OVER. THE ARCHITECTURE IS SETTLED AND THE WRITING STARTS NEXT (2026-08-20).**

**TwoRed:** 294 audited fills, odo 4 → **71,283 at the Matson dock**, 2010-07-23 to 2017-05-22. 277 of 294 balance the pump identity; the 13 that fail carry a documented basis. **65 errata**, 4 open. **139 legs across 12 trips** (132 timed), 41,163 mi = 58% of lifetime; **134 fills carry a time and temperature (46%)**; time zones COMPUTED from a 121-city IANA table, never typed.

**Creamsicle:** 173 fills, 86 legs, **with STOPPED TIME** — hence median gross 43.5 vs net 51.0 mph. **Zero southern fills**, which closes one test permanently.

**Twelve of Kim's accounts are collected verbatim and every one has been cross-checked.** All the open questions are answered or explicitly constrained.

**Ready to write:** the safety chapter (first), the origin/anchor Foreword, economy and cost per mile, the shape of a driving day, gross speed by road (stating the means-not-variance limit), the parking constellation. **Not ready:** the temperature effect is **retired**; the Canadian variance test is a NON-RESULT blocked on litre/CAD normalisation; the southern economy signal **cannot be settled at all**; route work partial at a 78% gazetteer join.

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

Independent of both paper and spreadsheet, which is what made them decisive during the months the Fourth Crossing paper was believed lost. **Four things carried forward:** an elegant single-cause hypothesis of mine was refuted by one line of statement (the town was Alpine); **the merged row was a CHIMERA needing a SPLIT, not a relabel** -- which is why it passes the arithmetic test perfectly; **errata key to a ROW, never a LABEL**; and all five ferries are identified. **Postscript 2026-08-19: when the paper turned up, the AMEX-derived gallons and costs matched it exactly -- but the MERCHANT NAMES I had put in the Brand field did not (L62/L63).** Full write-up in `logs/proj_Smart_Car_log.md`.

## ★★ THE AUDIT TOOLKIT — SIX INSTRUMENTS (2026-08-18) — full write-up in the log

**pump identity** (gallons x $/gal = cost) | **economy** (implied MPG) | **geography** (great-circle vs odometer) | **contiguity** (repeated values in adjacent rows) | **price family / same pump** | and the sixth, **Kim's slashed zeros** -- a physical mechanism, so it predicts error DIRECTION and not just fit (Finding 033).

**None is redundant: every major error found has been caught by exactly one of them.** The decisive pairing is contiguity + arithmetic -- where two adjacent rows share a value, **the row that BALANCES is the source and the row that FAILS is the copy**, a determination neither test reaches alone.

**Three standing limits, all learned the hard way.** For the 0/8 class **the scan is not evidence** (the illusion is on the paper). A **high road/straight-line ratio is sometimes a story** -- a navigation error or a routing app on dirt roads, not a defect. And every instrument has a **floor**: a 25-mile detour inside a 210-mile segment is indistinguishable from ordinary routing (Finding 036). Full write-up in `logs/proj_Smart_Car_log.md`.

## ★★ THE CORRECTED DATASET (2026-08-18) — build story in the log

**Building `twored_ingest.R` forced three things a correction LIST could not:** a row **INSERT** (the Big Spring/Alpine chimera needed a SPLIT, not a relabel -- which is exactly why it passes the arithmetic test perfectly); **EXPLICIT** partial-fill flags rather than a threshold recomputed each run; and a **GUARD THAT REFUSES** any correction whose `old_value` misses its row. **A correction that cannot find its row is a BUG, not a no-op.** `logs/proj_Smart_Car_log.md`.

## ★★ FIRST ANALYSIS ON CLEAN DATA — SIX RESULTS (2026-08-18) — detail in the log

Median leg **251 mi**; log distance ~**95%** of odometer miles; lifetime **39.44 MPG**; **leg length is the strongest predictor, +4.61 MPG per 100 mi**; **no degradation in sixteen years**; **$0.0936 per mile**. Temperature was null on leg-endpoint readings and is superseded by the fill-stamped result. `logs/proj_Smart_Car_log.md`.

## ★★ THE WHEELS WERE NEVER ABOUT FUEL — THEY WERE ABOUT SAFETY (Kim, 2026-08-18) — in the log

Smart Madness prescribed WIDE tires after the first crossing because the stock narrow "city" tires let crosswind push the car around at highway speed. **The purpose was handling, and handling is the mechanism of the safety thesis.** Before/after, the economy difference is indistinguishable from zero, **95% interval -3.7% to +4.9%** — the 1-3% penalty theory predicts sits INSIDE it. **The data rules out a LARGE penalty; it cannot detect a modest one.**

## ★★ KIM'S FRAME: TWO LOGS, TWO SUBJECTS (2026-08-18) — the FABRIC of the three layers; in the log

*The fuel log is more about the CAR'S performance, while the trip log shows the HUMAN performance -- how far and fast can you expect to drive in a day, something I had no idea about until I started doing these drives.*

**It assigns instruments to questions** — economy, degradation, cost/mile and the wide-tire question are the CAR's; daily range, departure discipline and gross speed are the HUMAN's. Fuel records STOPS, trip records LEGS; **the odometer is the JOIN, not the topic.** **Bounded 2026-08-19:** the trip log records what the human ACHIEVED, in MEANS not variance; **the stories are the only record of what it COST** — and, per Finding 041, **of where the car was allowed to sit.**

## ★★ THE SCAN SWEEP, 2026-08-18 — full write-up in the log

All 15 scans read (22 on disk). Four results that must not be lost:

**1. The wheel change is DATED** — `NEW WHEELS @ 13510 miles`, 179 mi before the 2011 departure. **The estimate FLIPS SIGN with specification (+3.6% to -1.8%); that is the finding, not any one number.**

**2. ✗ THE TEMPERATURE EFFECT IS RETIRED.** n=94 gave -0.068, p=0.045; n=125 gives **-0.050, p=0.099**, **p=0.17** with controls — and **hot fills are on shorter legs.** **The record is now good enough to RETIRE a result.**

**3. The slashed zero produced three more corrections and the control held.** Over 44 rows failing the pump identity: **permitted 8→0 fixes 4; forbidden 0→8 fixes 1; six controls fix 0.**

**4. Gross speed separates by ROAD.** 2011 interstate **47.6** | Frostburg 44.4 | Fourth Crossing 41.4 | Penultimate 40.3 | Dalton **31.7** | US-101 coastal **28.3**. **But it is a MEAN, and it cannot see road CHARACTER at all — see ROAD CHARACTER above.**

## ★★★ THE LONG DAYS — ALL EIGHT COLLECTED, AND EVERY ONE CHECKS OUT (2026-08-19)

**Fourteen of Kim's accounts are verbatim in the log under COLLECTED STORIES, with the full confirmation table.** Four that changed something:

| day | leg | what the data independently shows |
|---|---|---|
| 2012-05-31 | St Louis → Columbus, 518 | lost near Urbana IL — **the 09:52 fill is at Champaign, one metro with Urbana**, carrying slashed-zero typo **L61**. Excess over direct I-70: **108 mi** vs his remembered ~100 |
| 2011-06-26 | Flagstaff → Holbrook, 100 | out **04:30**, in **06:45** — a hop existing only to arrive early for his nephew; **70 mi of local driving before the next departure IS the park tour** |
| 2012-06-14 | Billings → Pocatello, 449 | **65.5 mph gross, the fastest day in the record** — fast because Montana has nowhere to stop |
| 2017-01-06 | Brookings → Paso Robles, 562 | racing to his mother, 104. **32 degF, the coldest start in the record**; fill **22:04 at 68,731**, arrival **22:10 at 68,732** — one mile, six minutes |

**The other four — Sydney NS → Edmundston (555, off an overnight ferry, zero odometer miles across the water), El Paso → San Antonio (531, racing for Florida), LSM → St George (492, a half-day Las Vegas visit inside a 31 mph day), Bellingham → Grants Pass (488, Nancy off the red-eye) — all check out.**

### ★★★ FLORIDA, AND THE TAIL OF THE DRAGON — full write-up in the log; rules in Finding 036

**I concluded TwoRed never reached Florida. It did** — a few miles into the panhandle, *is this Florida?*, and out. **The log resolves to two events, buying fuel and ending a day, and he did neither there, on purpose.** **And I argued the same leg had no room for the Dragon — 407 logged against ~400 direct. The route was never the direct one:** the fills give **Trussville AL → Madisonville TN**, north through Chattanooga and Knoxville, and **Madisonville → Cherokee is 104 mi against ~75 direct** — the Deals Gap route. **The Dragon is in the odometer.**

**Two rules. A record's RESOLUTION sets the floor on what its silences can mean. And a matching TOTAL does not mean a matching ROUTE.**

### ★★★ FIVE THINGS THE STORIES CHANGED, none of which the data could have volunteered

**1. Finding 033's best corroboration, from an unrelated direction.** The Champaign row is **L61**, a slashed-zero cost typo raised the day before — **and it sits at the stop where he had just discovered he was 100 miles off course and late for dinner.**

**2. The gap between an arrival odometer and the next departure is the day OFF the highway.** 70 miles at Holbrook is a park tour; **59 at Hartland is a lawyer's house across the river.** Readable across the whole record and nobody had read it.

**3. Daily distance has a first-order term nobody modelled: WHERE THE BEDS ARE.**

**4. A ferry is a LOGISTICS MULTIPLIER, not a hole in the odometer.**

**5. ★★ A LONG ELAPSED TIME IS NOT A SLOW DAY.** **Gross speed silently conflates driving with living** — Creamsicle's stop column puts the gap at **7.5 mph**, and the Dalton return shows it against the SAME road driven the day before. **Gross mph is a ceiling on driving speed, never a measure of it.**

### ★★ AND CHASING #5 FOUND A BUG IN 16 OF 107 LEGS — Finding 035

Nevada is Pacific and Utah is Mountain, and `tz_shift_hr` was 0 on every leg I transcribed. Fixed as a DERIVED layer — a 121-city IANA table plus computation in `trip_logs_read.R` — so DST, Arizona and Saskatchewan declining it, Yukon before 2020 and Newfoundland's half hour all fall out for free. **16 legs corrected; road ordering unchanged; the fastest day is real.**

**★ Kim's stories have now corrected the analysis SEVEN times** — the road/straight-line rule, the time zones, Florida, the Dragon route, the Penultimate State, the West Virginia landscape-not-road, and the parking map (Finding 041). **The human spine is an instrument, and it is the more accurate one.**

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

## ★★★ THE OPEN QUESTIONS ARE CLOSED (2026-08-19/20) — full working in the log

**1. The 46 Dalton miles are 32 + 14 — Coldfoot → Wiseman.** Two Yukon River Crossing fills split the leg: north of the river 115 out / **147 back (+32)**, south 137 / **151 (+14)**; the Wiseman spur is ~16 road miles, so **out and back is 32, to the mile.** *A matching TOTAL does not mean a matching ROUTE; a SPLIT total localises the discrepancy.* Same leg: **slowest 200+-mile day in sixteen years (22.6 mph against 28.6 over the identical road the day before)**, starting at **38 degF after Coldfoot read 64 the previous evening.**

**2. THE PENULTIMATE STATE IS VERMONT** — *a lawyer who has an office in NH, but lives nearby in Vermont. I drove to his house.* **Exactly the anomaly the record flagged and could not read:** Hartland VT → Lebanon NH, **two nights and 59 odometer miles for an eighteen-mile drive**, across the Connecticut River. **★ TwoRed's state list and KIM'S state list are two different quantities** — hence 45 documented against a challenge counting to 49.

**3. ★★★ DELAWARE IS INVISIBLE AS A LABEL AND PROVABLE AS A ROW.** Colonial Heights VA → Bellmawr NJ reads **264 odometer miles** (great-circle 219); **the only Delaware-free road is ~305, forty more than the odometer permits.** **Key to a ROW, never a LABEL.** Never-appearing states: Florida (Finding 036), Delaware, Rhode Island, South Dakota. **Provinces confirmed at exactly ten.**

**4. ⛔ THE TEXAS ON-RAMP — CLOSED BY REQUEST.** *For personal safety, I wouldn't reveal it either. Near Ft Worth is sufficiently close.* **No session may localise it; no published text may place it more precisely than NEAR FORT WORTH.**

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



## ★★★ ROAD CHARACTER — A TAXONOMY FROM EXPERIENCE, AND A NULL THAT COMPLETES A PAIR (Kim, 2026-08-20)

**He withdrew his own West Virginia answer after checking a map: the two drives were DIFFERENT HIGHWAYS**, sharing *the same type of countryside; rolling, tree-covered hills, a winding highway, small villages tucked in the valleys.* **The memory retained a LANDSCAPE TYPE, not a road** — Finding 039 amended: *when a witness names a specific, test whether the specific stands for a class.*

**New category — TREE TUNNELS:** *very long miles of straight divided highway lined by a dense thicket of trees. Flat. Monotonous.* In the South. The third term is what both are a relief from: *nearly straight freeways lined by commerce, billboards and wall-to-wall housing.* **The project's road taxonomy is built from SPEED; his is built from EXPERIENCE.**

**★★★ Gross speed cannot see it — Deep South median 40.3 mph (n=10) vs Appalachian 38.0 (n=6), p = 0.42 — and that null COMPLETES A PAIR.** The Canadian Plains were the most STRESSFUL miles and read as an unremarkable fast run. **Tree tunnels are the most MONOTONOUS and read exactly the same. The record is blind to the driver's experience at BOTH ends of the scale — terror and boredom produce identical numbers.** *Vigilance has no column; neither does tedium.* **The cleanest one-line case for why layer 2 is load-bearing.**

**⚠ A SIGNAL THAT CANNOT BE SETTLED.** `mpg ~ leg_miles + group`: South **-3.18, p=0.023** (n=30); with era **-2.61, p=0.065**; on 16 temperature-stamped rows **-5.81, p=0.009** with temperature null. **Mechanism would invert the intuition — flat straight highway invites steady high speed, and drag costs an 1,800-lb car more than hills do.** But the coefficient is **unstable across subsamples**, n=30, and temperature is confounded with group. **★★ Creamsicle has ZERO southern fills, so the sample is closed at 30 and will not grow.** **DIFFICULTY strand. Do not print the coefficient; print the fact that it cannot be settled.**

## ★★★ THE OPENING IS WRITTEN — THE ANCHOR, THE PARKING, AND HAWAII (Kim, 2026-08-20) — full working in the log

**Kim's origin story:** a car was needed at Lake San Marcos because visits to his mother were frequent and rentals were adding up; **there was a parking spot at her place**; and the contradiction — a city car with 71,283 mainland miles — resolves through the family dynamic, *two visits separated by the time needed to do some work.*

**★★★ THE RECORD SAYS MORE THAN *BOTH PURPOSES*. EVERY COMPLETE TRIP IS A LOOP FROM THAT PARKING SPACE.** Eight of thirteen logged trips begin and end at Lake San Marcos, and **every complete one from 2011 through the Fourth Crossing does** — the Arctic Circle run, the crossing that reached Florida and the Dragon, the fourth crossing. **The long-distance driving is not a departure from the local-errand purchase; it is structurally hung off it.** The anchor holds **18 dormancies and 999 days**, 2010-07-26 to 2016-08-02. **86% of the record's elapsed days sit inside a dormancy of two weeks or more.**

**★★★ THE CAR LEFT BECAUSE THE PARKING SPOT DID.** *She could no longer stay in her assisted living facility... She moved to a more secure facility in August and that place didn't have parking for TwoRed.* Last anchor fill **2016-08-02**; his **niece at Mentone** holds the car five weeks; the coast run to Oregon follows on 09-24. **She died in January 2017 with the car already in Eugene — which is why it was there when the call came. Adjacent facts, separate causes; keep them so.**

**⚠ I BUILT A FAVOUR MAP FROM THE DORMANCY LOCATIONS AND IT WAS MOSTLY WRONG — FINDING 041.** *The other places are simply hotel/motels we stopped at along the way.* **A fill records where fuel was BOUGHT, not where the car came to REST.** Same class as *a matching TOTAL does not mean a matching ROUTE*: **a fuel row is a TRANSACTION, not a STATE.** **What survives: the durations, the anchor (confirmed by Kim independently), and SIGNAL HILL = SMART MADNESS** — 7 fills 2011-2017 at the seams of expeditions; the 2013-09-06 one falls inside the Arctic trip's last leg, **so the car came off the Dalton and stopped at the shop on the way home. The wide-tire decision has an address.**

**★★ THE THEME STANDS ON TESTIMONY, NOT ON MY MAP.** Four holdings: **his mother's facility, his niece at Mentone, a close colleague's farm with a huge garage in Eugene (⛔ not named), and the St Louis car wash near the airport** — improvised on sight from an unused garage, **the only PAID holding in sixteen years.** **Where a car is allowed to sit is exactly what a fuel log cannot hold; only the witness can name it.** Layer 3 built a map, layer 2 corrected it, and **the correction says the map cannot be built from data at all.**

**★★★ AND THEY LIVE IN HAWAII — SAY IT EARLY (intentions item 6).** **Every dormancy is a FLIGHT home**, not an idle car; **the ~3,700 excluded Honolulu miles are the only miles driven where they live**; and it **inverts layer one a second time** — *you don't do much driving in Hawaii (think: downtown Honolulu). Driving on the mainland was something different for us.* **They live in a city and bought a city car to escape city driving.** Put it beside the safety inversion.

**★ For the Foreword:** the preconception is *that car is for errands.* The origin story answers *yes — exactly why we bought it.* **Then the record shows the errand car's parking space is the origin of every expedition in the book**, and that the enabling condition was never fuel or roads but **people willing to let a car sit.**

## ★★★ THE SAFETY QUESTION IS LAYER ONE'S ACTUAL CONTENT (Kim, 2026-08-19) — full development in the log

**The preconception is not *that thing is a city car*. It is a question with a fear in it: IS IT SAFE?** *These are small cars!* **A shrug gives a reader no reason to turn the page; a fear does.** Kim's answer has three parts and only the third is the thesis:

1. **The engineering answer** — Mercedes, the safety cell, race-car logic. **His own verdict on how it lands: *Do they believe it? Maybe. Maybe not.*** Keep that sentence; a spec sheet does not defeat a visual impression, and the document is stronger for admitting it.
2. **The empirical answer** — sixteen years of prudent driving, nothing happened.
3. **★★★ THE THESIS: SMALL AND NIMBLE ARE COMPONENTS OF SAFETY.** It **INVERTS** the preconception rather than rebutting it — size stops being a liability to excuse and becomes the mechanism of the escape. **The Yukon pothole** was *big enough to eat a big car too*: **the hazard was size-blind, the escape was not.** **The Texas on-ramp** — a police car coming UP it at full speed, no lights, no siren; hard right, hard brakes, a stop inches from the guard rail. **The hazard was external, unlawful and unpredictable: no prudence prevents it, and what was available was steering and braking in a very short distance.** That is a handling argument, and handling is measurable in a way a crash test is not.

**★★★ THE SAFETY CHAPTER IS THE PROOF THAT THE LAYERS ARE LOAD-BEARING — write it first.** **Layer 3 has the denominator: 100,999 documented miles across three cars** (TwoRed 71,177 + Creamsicle 28,613 + TwoFer 1,209; ~105,000 with the Honolulu miles), **467 fills, 225 legs, 45 states, 10 provinces, Dalton gravel, Canadian frost heaves, Deals Gap, US-101 — no crash.** **Layer 2 has the numerator, and nothing else can: a crash avoided buys no fuel, ends no leg, and takes under a minute.** **Miles without near-misses are absence of evidence; near-misses without miles are anecdote.**

**★ IT ALSO CLOSES THE WIDE-TIRE LOOP.** The only modification TwoRed ever got was made for handling — *the cars have handled well and this, in part, keeps them out of dangerous situations* — so the fuel data's job was to PRICE it, not judge it: **indistinguishable from zero, 95% interval -3.7% to +4.9%. The safety modification was free.**

**⚠ TWO DISCIPLINES, both in the DIFFICULTY strand.** *Granted, no crash testing* is Kim's own caveat — **the record cannot answer a counterfactual**, and saying so plainly beats hedging. And **101,000 crash-free miles must not be oversold**: one prudent driver, mostly interstate, mostly daylight, almost no urban commuting. **The miles show the car did not prevent sixteen years of safe driving; the near-misses are where the car actively contributed.** A crash-rate comparison needs a SOURCED per-mile figure first.

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

## Next Steps
1. **★★★ KIM: correct the chapter list above.** Then **write the SAFETY chapter (ch.2) first** — it demonstrates the architecture on the project's own central question. Foreword material is already being dictated and is in the log.
2. **BUILD THE MANUSCRIPT SKELETON.** There is no draft file yet — dictated prose is currently landing in `logs/proj_Smart_Car_log.md`, which is working state, not a manuscript. **A Quarto book in `G:\My Drive\Projects\Smart_Car`, one file per chapter, destination `kimbridges-documents`.**
3. **KIM:** confirm the remaining privacy calls — the niece at Mentone (relationship without a name? town or not?) and the St Louis business. **The Eugene colleague is ruled: NOT NAMED.**
4. **KIM:** name the tree-tunnel stretches he remembers (do not infer them); and whatever exists for Bordeaux.
5. **DEFERRED UNTIL A CHAPTER ASKS.** Canada2014 unit normalisation, Creamsicle's timezone table, `Expedition_ID` across both cars, the constellation maps, the ~141 extra fill temperatures in the live `TwoRed_fuel` Sheet. **By the editorial rule, an analysis earns its place by answering a question the drives raised — none of these has a chapter asking yet.**
6. **OPEN, not urgent:** Creamsicle trip legs run to 2024-10-20 but fills stop at 2024-07-02. **Not an absence claim.**

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
