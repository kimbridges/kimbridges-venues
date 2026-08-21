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

**It assigns instruments to questions** — economy, degradation, cost/mile and the wide-tire question are the CAR's; daily range, departure discipline and gross speed are the HUMAN's; **mixing them yields a meaningless average.** Fuel records STOPS, trip records LEGS; **the odometer is the JOIN, not the topic.** **Bounded 2026-08-19:** the trip log records what the human ACHIEVED, in MEANS not variance; **the stories are the only record of what it COST.**

## ★★ THE SCAN SWEEP, 2026-08-18 — full write-up in the log

All 15 scans read (22 on disk). Four results that must not be lost:

**1. The wheel change is DATED** — `NEW WHEELS @ 13510 miles`, 179 mi before the 2011 departure. **The estimate FLIPS SIGN with specification (+3.6% to -1.8%); that is the finding, not any one number.**

**2. ✗ THE TEMPERATURE EFFECT IS RETIRED.** n=94 gave **-0.068, p=0.045**; n=125 gives **-0.050, p=0.099**, **p=0.17** with controls. The raw hot/cold gap dies on the same control — **hot fills are on shorter legs.** **The record is now good enough to RETIRE a result.**

**3. The slashed zero produced three more corrections and the control held.** Over 44 rows failing the pump identity: **permitted 8→0 fixes 4; forbidden 0→8 fixes 1**; **six controls fix 0.**

**4. Gross speed separates by ROAD, across 138 legs.** 2011 interstate **47.6** | Frostburg 44.4 | Fourth Crossing 41.4 | Penultimate 40.3 | Dalton **31.7** | US-101 coastal **28.3**. **But gross speed is a MEAN, and it cannot see road CHARACTER at all — see ROAD CHARACTER above.**

## ★★★ THE LONG DAYS — ALL EIGHT COLLECTED, AND EVERY ONE CHECKS OUT (2026-08-19)

**Twelve of Kim's accounts are verbatim in the log under COLLECTED STORIES, with the full confirmation table.** Chapter source material. Four that changed something:

| day | leg | what the data independently shows |
|---|---|---|
| 2012-05-31 | St Louis → Columbus, 518 | lost near Urbana IL — **the 09:52 fill is at Champaign, one metro with Urbana**, and it carries slashed-zero typo **L61**. Excess over direct I-70: **108 mi** vs his remembered ~100 |
| 2011-06-26 | Flagstaff → Holbrook, 100 | out **04:30**, in **06:45** — a hop existing only to arrive early for his nephew; **70 mi of local driving before the next departure IS the park tour** |
| 2012-06-14 | Billings → Pocatello, 449 | **65.5 mph gross, the fastest day in the record** — fast because Montana has nowhere to stop |
| 2017-01-06 | Brookings → Paso Robles, 562 | racing to his mother, 104. **32 degF, the coldest start in the record**; fill **22:04 at 68,731**, arrival **22:10 at 68,732** — one mile, six minutes |

**The other four — Sydney NS → Edmundston (555, off an overnight ferry, zero odometer miles across the water), El Paso → San Antonio (531, racing for Florida), LSM → St George (492, a half-day Las Vegas visit inside a 31 mph day), Bellingham → Grants Pass (488, Nancy off the red-eye) — all check out and are in the log.**

### ★★★ FLORIDA, AND THE TAIL OF THE DRAGON — full write-up in the log; rules in Finding 036

**I concluded TwoRed never reached Florida. It did** — a few miles into the panhandle, *is this Florida?*, and out. **The log resolves to two events, buying fuel and ending a day, and he did neither there, on purpose.** **And I argued the same leg had no room for the Dragon — 407 logged against ~400 direct. The route was never the direct one:** the fills give **Trussville AL → Madisonville TN**, north through Chattanooga and Knoxville, and **Madisonville → Cherokee is 104 mi against ~75 direct** — the Deals Gap route. **The Dragon is in the odometer.**

**Two rules. A record's RESOLUTION sets the floor on what its silences can mean. And a matching TOTAL does not mean a matching ROUTE.**

### ★ ONE DISCREPANCY, UNRESOLVED — the Bellingham departure

Kim remembers meeting Nancy *early afternoon*; the sheet starts the day at **06:49**. **The arithmetic favours the sheet** — 488 mi from 06:49 is already 36.2 mph gross, while an early-afternoon start needs ~67 with no stop. Likely 06:49 is the ferry docking recorded as the day's start. **Ask him.** Detail in `deferred.md`.

### ★★★ FIVE THINGS THE STORIES CHANGED, none of which the data could have volunteered

**1. Finding 033's best corroboration, from an unrelated direction.** The Champaign row is **L61**, a slashed-zero cost typo raised the day before — **and it sits at the stop where he had just discovered he was 100 miles off course and late for dinner.** Kim gave the *record quickly under pressure* mechanism blind to this route.

**2. The gap between an arrival odometer and the next departure is the day OFF the highway.** 70 miles at Holbrook is a park tour; **59 at Hartland is a lawyer's house across the river.** Readable across the whole record and nobody had read it.

**3. Daily distance has a first-order term nobody modelled: WHERE THE BEDS ARE.** Lodging geography sets the length; scenery sets the pace.

**4. A ferry is a LOGISTICS MULTIPLIER, not a hole in the odometer.** It converts a night into progress and hands the next morning a loaded, fuelled car.

**5. ★★ A LONG ELAPSED TIME IS NOT A SLOW DAY.** **Gross speed silently conflates driving with living**, and both later measurements agree: Creamsicle's stop column puts the gap at **7.5 mph**, and the Dalton return shows it against the SAME road driven the day before. **Gross mph is a ceiling on driving speed, never a measure of it.**

## ★★★ THE FAVOURITE DRIVES (2026-08-19) — full write-up in the log

Kim's list, unprompted: the Rockies; the mountains down to the Oregon coast; **a morning through the West Virginia hills, villages fogged in and chimney smoke rising** — *I liked this so much, I drove it twice* (**see ROAD CHARACTER: two different highways, one country**); and the Dalton, *going where cars weren't intended*.

**★★ A routing app can manufacture the geographic test's own signature.** *Memo to self: stay on the main roads.* Excess road miles PLUS low economy from a rough surface is exactly what the test hunts. **It is not an error; it is a wrong turn a machine recommended** — measurable at 42 miles in the 2016 log. Third case where a high ratio wants a story rather than an errata entry.

## ★★★ THE FOURTH CROSSING LOG IS FOUND (2026-08-19) — full write-up in the log

Nine pages, **25 legs**. **The reconstruction HELD: all 29 paper rows balance the pump identity, 25 of 29 are identical to the corrected dataset, and the LSM/Blythe/Winslow values derived from AMEX statements match the paper EXACTLY** — an independent source, arrived at afterwards, agreeing to the thousandth of a gallon. **There is no Phoenix fill**, settling a hypothesis already withdrawn on three statistical grounds.

**Three of the four differences are mine.** L62/L63: **I had written the AMEX MERCHANT NAME into the Brand field** (`Quick Check West`, `Hallum Store`) where the paper says **Valero** and **Conoco**. **RULE: when a field is filled from a substitute source, record WHICH source — a merchant string is not a brand.**

**Recovered:** the stuck day, 2016-05-27 Youngtown → Monument Valley, **362 mi against ~320 direct = 42 miles of detour**. **A new longest day: 2016-06-19 Richmond MO → Denver, 640 mi at 58.6 mph.** **107 degF into St George on 6/21, the hottest reading in the record.**

## ★★★ THE STRESSFUL MILES ARE INVISIBLE — A DIFFERENT SILENCE FROM FINDING 036 (2026-08-19)

Kim's testable claim: *we were plagued by potholes. We often slowed to avoid damage... Those miles, which were mostly across the Canadian Plains, were very stressful.* **Both instruments were pointed at it. Neither sees anything.** Canadian Plains median gross **44.5 mph** against US Plains **45.0** and a whole-record **40.5**; MPG residuals +0.56 (n=4) against a record SD of **4.74**. The three Plains legs run **44.5, 47.3, 43.1** — FASTER than his sixteen-year median.

**★★★ HIS CORRECTION INVERTS THE LOGIC.** *I should have said "abruptly slowed, then quickly speeded up". The problem was that I couldn't go slow as big vehicles kept moving at highway speeds. Hence the rear view mirror checks.* **His account PREDICTS no speed effect** — he was not free to drive slowly, so the average had to stay up. **The high gross speed is not evidence against the stress; it is the mechanism OF it.** And it names the missing quantity: **within-leg VARIANCE. A trip log samples the day TWICE — everything between is averaged away BY CONSTRUCTION.** *(The Canadian variance test is a NON-RESULT, not a null: those rows are converted from litres and CAD and unit-normalising is still OPEN.)*

**★★★ WHY THIS IS NOT FINDING 036.** 036 was about events that generated NO observation. These miles generated a FULL set and every one is normal. **BOTH LOGS MEASURE OUTPUT. NEITHER MEASURES COST TO THE DRIVER. Vigilance has no column** — and, per ROAD CHARACTER above, **neither does tedium.** A driver can buy an ordinary 44 mph day at an extraordinary price and the log records the 44. **The stories are the sole record of a dimension the data cannot reach.**

## ★★ TWO RELOCATIONS, AND THE LAST YEAR'S SHAPE (2026-08-19) — full write-up in the log

A page filed as a duplicate carried an annotation its twin did not show: **`Relocation  1141 miles`**, matching the 2016 fall-winter legs exactly. **September 2016 was not a tour; it was the one-way relocation of TwoRed to Oregon** — which is why the car was in Eugene when the January 2017 call came. **February 2017 is a SECOND relocation**, after which the car sits until 20 May. **The last year's shape: the car stops touring, starts commuting between two homes, then ships.** **See THE ANCHOR above — this is also where the Lake San Marcos loop breaks for good.**

**★ METHOD: two scans of the same page are not the same evidence.** A marginal annotation can be lost to cropping, threshold or the fold. **Diff a duplicate rather than discarding it.**

## ★★★ THE END OF THE MAINLAND RECORD: 71,283 AT THE MATSON DOCK (2026-08-19)

On the BACK of the last fuel sheet, circled: **`5/22/17  71,283  LV Seattle @ Matson`**. No travel log because *we got on a plane and left TwoRed at the dock for shipping.* Last mainland miles **Toledo WA 71,181 → Seattle 71,283 = 102**, against ~100 road miles; both readings documented.

**This closes the first question the project ever asked.** The charter said ~75,000, the log stopped at 71,181, and the gap looked like missing data. **Mainland 71,283; Kim's figure ~74,980; implied Honolulu miles ~3,697.** **The gap was never missing data — it is the scope boundary, quantified at the terminus.**

**★★ Two anomalies at the end that are NOT economy readings.** The final two fills read **52.4 and 93.0 MPG** on **4.333 and 2.496 gallons against a lifetime mean of 6.24.** **A vehicle handed to Matson must arrive with a low tank** — a tank managed DOWN for shipping, not a measurement of the car. **★ General rule: the first and last rows of any record are the least trustworthy, because they are taken while the measuring itself is being started or stopped.** The first fill carries a slashed-zero error (L59); the last two are shipping artifacts. **Trim the ends before quoting an extreme.**

## ★★★ THE OPEN QUESTIONS ARE CLOSED (2026-08-19/20) — full working in the log

**1. The 46 Dalton miles are 32 + 14 — Coldfoot → Wiseman.** The two Yukon River Crossing fills split the leg: north of the river 115 out / **147 back (+32)**, south 137 / **151 (+14)**; the Wiseman spur is ~16 road miles from Coldfoot, so **out and back is 32, to the mile.** *A matching TOTAL does not mean a matching ROUTE; a SPLIT total localises the discrepancy.* The same leg is the **slowest 200+-mile day in sixteen years (22.6 mph against 28.6 over the identical road the day before)**, starting at **38 degF after Coldfoot read 64 the previous evening**.

**2. THE PENULTIMATE STATE IS VERMONT (Kim, 2026-08-20)** — *a lawyer who has an office in NH, but lives nearby in Vermont. I drove to his house.* **Exactly the anomaly the record flagged and could not read:** Hartland VT → Lebanon NH, **two nights and 59 odometer miles for an eighteen-mile drive**, across the Connecticut River. **★ Definitional point: TwoRed's state list and KIM'S state list are two different quantities** — which is why the record holds 45 against a challenge counting to 49.

**3. ★★★ DELAWARE IS INVISIBLE AS A LABEL AND PROVABLE AS A ROW.** Four mainland states never appear: Florida, Delaware, Rhode Island, South Dakota. Florida is Finding 036; **Delaware is the same silence and geometry breaks it** — Colonial Heights VA → Bellmawr NJ reads **264 odometer miles** (great-circle 219), and **the only Delaware-free road is ~305, forty more than the odometer permits.** **Key to a ROW, never a LABEL.** Charter claim settled: **provinces are exactly ten.**

**4. ⛔ THE TEXAS ON-RAMP — CLOSED BY REQUEST.** *For personal safety, I wouldn't reveal it either. Near Ft Worth is sufficiently close.* **No session may attempt to localise it; no published text may place it more precisely than NEAR FORT WORTH.** Candidates removed from `deferred.md`. **A request, not a feasibility question.**

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

Written 2026-08-12 so a session opening this file cold knows what was decided and what was left open.

**1. The document is about four cars.** TwoRed carries the deep quantitative spine; the others carry what one car cannot show — replacement decisions, changing models, and the fact that the choice was made again.

**2. The Arctic Circle Challenge is CROSS-REFERENCED, never re-told.** Already published at `/stories/the-arctic-circle-challenge.html` (77 pp). Use only its **data** inside the analysis chapters. The charter's Chapter 5, which embedded the narrative by iframe, is **superseded** — it would have put the same content at two URLs and made the works register lie.

**3. Reuse the existing packages** (Kim's standing rule, 2026-08-11): `timelinesr` and `Trip_Log` for the temporal spine, `plainmaps`/`sf`/`tidygeocoder` for geography, `Photo_Locations` for geotagging. New package only if something has no home.

**4. No number gets printed until it is sourced.** The 75,000-mile claim was the live example; **the province count is now confirmed (10) and the state count is not (45 documented of 49).**

**5. Production is staged, not simultaneous.** Data recovery, then ingestion, then maps, then prose. **The chapter architecture below is provisional and is now the only thing blocking the writing.**

## Locations
- Code: `G:\My Drive\Projects\Smart_Car` (bucket 2 -- code-as-source); `data`, `source`, `images` beneath it
- **★ GOOGLE-NATIVE DATA, root of `G:\My Drive` (found 2026-08-16).** NOT reachable by any filesystem read -- `G:` shows zero-byte stubs. Read via the Google Drive connector BY TITLE. **Full inventory of the eight Sheets/Docs is in the log.** The three Creamsicle files have since been exported and ingested (2026-08-19); still live-only: **`TwoRed_fuel`** (richer early record, **ambient temperature in Notes**, ~141 more fill temps), `TwoFer Gas Log`, `Creamsicle Inventory`, `Travel/2016 Fourth Crossing Analysis`.
- **Fuel receipt scans on Drive:** `CS_Fuel_Receipts_2021.pdf` (5.7 MB), `2022_fuel_receipts_Jan-Feb.pdf` (6.5 MB) -- primary sources behind Creamsicle's first two trips.
- **Existing analysis code:** `G:\My Drive\Projects\Photo_Mapping\Fuel_Analysis.Rmd` (2022), written against the fuel data; read before writing new ingestion.
- Docs/output: not yet; destination is kimbridges-documents. GitHub: not yet.
- **Superseded:** `G:\My Drive\kimbridges-stories\underway\Smart_car\` -- the original mis-filing. Copies still there; neither bridge deletes, so removal is Kim's.

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

**He withdrew his own West Virginia answer after checking a map: the two drives were DIFFERENT HIGHWAYS**, and what they shared was *the same type of countryside; rolling, tree-covered hills, a winding highway, small villages tucked in the valleys.* **So the memory retained a LANDSCAPE TYPE, not a road — and *twice* counted instances of a category.** He said *highway*; he meant *this kind of country*. **Finding 039 amended: when a witness names a specific, test whether the specific stands for a class.**

**And a category the project did not have — TREE TUNNELS:** *very long (miles and miles) of straight divided highway lined by a dense thicket of trees. Flat. Monotonous. Where are these found? In the South.* The third term is what both are a relief from: *nearly straight freeways lined by commerce, billboards and wall-to-wall housing.*

**★★ The project's road taxonomy is built from SPEED; his is built from EXPERIENCE. Different axes, both needed.** Gross speed does not separate them — **Deep South median 40.3 mph (n=10) against Appalachian 38.0 (n=6), p = 0.42.**

**★★★ AND THAT NULL COMPLETES A PAIR WITH THE CANADIAN PLAINS.** Those were the most STRESSFUL miles of the crossing and read as an unremarkable fast run. **Tree tunnels are the most MONOTONOUS and read exactly the same way. The record is blind to the driver's experience at BOTH ends of the scale — terror and boredom produce identical numbers.** *Vigilance has no column; neither does tedium.* **This is the cleanest one-line case the project has for why layer 2 is load-bearing.**

**⚠ A SIGNAL IN THE ECONOMY THAT CANNOT BE SETTLED.** `mpg ~ leg_miles + group` gives South **-3.18, p=0.023** (n=30); with era **-2.61, p=0.065**; on the 16 temperature-stamped rows **-5.81, p=0.009** with temperature itself null. **Mechanism would be the inverse of the intuition — flat straight highway invites steady high speed, and drag costs an 1,800-lb car more than hills do.** But the coefficient is **unstable across subsamples**, n=30, and temperature is confounded with group. **★★ And it cannot be resolved by waiting: Creamsicle has ZERO southern fills. The sample is closed at 30.** **DIFFICULTY strand, not analysis. Do not print the coefficient; print the fact that it cannot be settled.**


## ★★★ THE OPENING IS WRITTEN, AND THE ANCHOR IS THE FOREWORD'S SPINE (Kim, 2026-08-20) — full working in the log

**Kim's origin story:** a car was needed at Lake San Marcos because visits to his mother were frequent and rentals were adding up; **there was a parking spot at her place**; and the apparent contradiction — a city car with 71,283 mainland miles on it — resolves through the family dynamic. ***We'd visit for a few days and then go off to a meeting... We'd drive back and visit again. Two visits separated by the time needed to do some work. The car served both purposes.*** Verbatim in the log.

**★★★ THE RECORD SAYS SOMETHING STRONGER THAN *BOTH PURPOSES*.** **22 of the 35 long dormancies are at that one address — 1,333 of 2,147 dormant days, 62%, median stay 52 days, longest 184, spanning 2010-07-26 to 2016-08-02 exactly six years.** **The car spent more of its life parked there than doing anything else, including driving.**

**AND EVERY COMPLETE TRIP IS A LOOP FROM IT.** Eight of thirteen logged trips begin and end at Lake San Marcos, and **every complete one from 2011 through the Fourth Crossing is a round trip from that parking space** — the Arctic Circle run, the crossing that reached Florida and the Dragon, the fourth crossing. **The long-distance driving is not a departure from the local-errand purchase; it is structurally hung off it. There was never a choice between the two uses, because every long drive began and ended in the same parking spot.**

**★★ The economics are visible as a COUNT, not a cost.** A rental must be returned; a car in a parking space need not be. **22 long dormancies = the car left and collected twenty-two times in six years — twenty-two rentals not taken out.** **The saving is in the DORMANCY column, which is the one nobody thinks to read.** (A dollar figure needs a sourced rental rate — intentions item 4.)

**★★★ AND PARKING IS THE HIDDEN INFRASTRUCTURE — Kim, 2026-08-20, answering why the car left.** *She could no longer stay in her assisted living facility in LSM. She moved to a more secure facility in August and that place didn't have parking for TwoRed. Parking is a big issue and we've been fortunate that friends and family have helped at critical times.* **The car did not leave California because she died. It left because the parking spot did.** Last anchor fill **2016-08-02**; **Carlsbad holds it for 36 days** while a new home is found; the coast run to Oregon follows on 09-24. **Six years of anchorage end inside a fortnight, on a facility's parking policy.** She died in January 2017 with the car already in Eugene — **which is why it was there when the call came. The two facts are adjacent and separate; keep them so.**

**★★★ THE DORMANCY MAP *IS* THE FAVOUR MAP.** **Thirty-four of the thirty-five long dormancies sit inside the network of family, friends and a facility** (San Marcos 11 spells / 578 days, Lake San Marcos 7 / 421, Carlsbad 4 / 334, then Signal Hill, Barstow, Parker, Yuma, Coos Bay, Brookings and four singles). **Exactly one is outside it — Altamont IL, 25 days — and it is the only time in sixteen years he had to BUY the service.** Two thousand miles from anyone who could hold the car, the substitute for a favour was a commercial car wash. **The car wash is not an odd anecdote; it is the single failure of the parking network.**

**★ For the Foreword: the hidden infrastructure of sixteen years of cross-country driving in a small car was not fuel and not roads — it was people willing to let a car sit.** The fuel log records movement; **the gaps between its rows record hospitality, and they are 86% of the elapsed days.** ⚠ **Do not publish the dormancy table until Kim annotates whose driveway each town was, and rules on naming private individuals** — as with the Texas on-ramp.

**★ For the Foreword: this is layer-3 material arriving in service of layer 1.** The preconception is *that car is for errands.* The origin story answers *yes — that is exactly why we bought it.* **Then the record shows the errand car's parking space is the origin of every expedition in the book. The document does not argue the reader out of the preconception; it agrees with it and shows where it leads.**

## ★★★ THE SAFETY QUESTION IS LAYER ONE'S ACTUAL CONTENT (Kim, 2026-08-19) — full development in the log

**The preconception is not *that thing is a city car*. It is a question with a fear in it: IS IT SAFE?** *These are small cars!* **A shrug gives a reader no reason to turn the page; a fear does.** Kim's answer has three parts and only the third is the thesis:

1. **The engineering answer** — Mercedes, the safety cell, race-car logic. **His own verdict on how it lands: *Do they believe it? Maybe. Maybe not.*** Keep that sentence; a spec sheet does not defeat a visual impression, and the document is stronger for admitting it.
2. **The empirical answer** — sixteen years of prudent driving, nothing happened.
3. **★★★ THE THESIS: SMALL AND NIMBLE ARE COMPONENTS OF SAFETY.** It **INVERTS** the preconception rather than rebutting it — size stops being a liability to excuse and becomes the mechanism of the escape. **The Yukon pothole** was *big enough to eat a big car too*: **the hazard was size-blind, the escape was not.** **The Texas on-ramp** — a police car coming UP it at full speed, no lights, no siren; hard right, hard brakes, a stop inches from the guard rail. **The hazard was external, unlawful and unpredictable: no prudence prevents it, and what was available was steering and braking in a very short distance.** That is a handling argument, and handling is measurable in a way a crash test is not.

**★★★ THE SAFETY CHAPTER IS THE PROOF THAT THE LAYERS ARE LOAD-BEARING — write it first.** **Layer 3 has the denominator: 100,999 documented miles across three cars** (TwoRed 71,177 + Creamsicle 28,613 + TwoFer 1,209; ~105,000 with the Honolulu miles), **467 fills, 225 legs, 45 states, 10 provinces, Dalton gravel, Canadian frost heaves, Deals Gap, US-101 — no crash.** **Layer 2 has the numerator, and nothing else can: a crash avoided buys no fuel, ends no leg, and takes under a minute.** **Miles without near-misses are absence of evidence; near-misses without miles are anecdote.**

**★ IT ALSO CLOSES THE WIDE-TIRE LOOP.** The only modification TwoRed ever got was made for handling — *the cars have handled well and this, in part, keeps them out of dangerous situations* — so the fuel data's job was to PRICE it, not judge it: **indistinguishable from zero, 95% interval -3.7% to +4.9%. The safety modification was free.**

**⚠ TWO DISCIPLINES, both in the DIFFICULTY strand.** *Granted, no crash testing* is Kim's own caveat — **the record cannot answer a counterfactual**, and saying so plainly beats hedging. And **101,000 crash-free miles must not be oversold**: one prudent driver, mostly interstate, mostly daylight, almost no urban commuting. **The miles show the car did not prevent sixteen years of safe driving; the near-misses are where the car actively contributed.** A crash-rate comparison needs a SOURCED per-mile figure first.

## ★★★ CHAPTER ARCHITECTURE — SOLVED. KIM'S THREE LAYERS (2026-08-19) — full development in the log

**His words, recorded as given:** *The Smart Cars are the "hook"... The two aspects of performance, car and human, is the fabric... The data become the real issue. The complexities and difficulties in the process of data collection, transcription, and cleaning on one end. At the other end, the opportunities for interesting, and perhaps unique, ways to analyze and display the results... People see the unusual cars (and have preconceived notions). The drives make interesting stories. The data give satisfying answers to questions, even those you didn't know you had.*

**This closes the weak point named 2026-08-16 and does what TWO LOGS, TWO SUBJECTS could not.** That frame said which instrument answers which question — an excellent SORTING rule and a useless ORDERING rule. **Three layers says what a reader meets first and why they keep going, and the two compose: the car/human fabric runs THROUGH all three. It is the weave, not a chapter.**

**★ Three DEPTHS of one material, each bought by the one above.** The preconception makes the drives surprising; the drives make a reader want the numbers; the numbers answer questions the stories raised. **Remove any layer and the one below loses its force** — without the preconception the drives are travel, without the drives the numbers have no question, without the numbers the stories are anecdote.

**★★ *Questions you didn't know you had* is load-bearing, and already proven:** *what does a day OFF the highway look like?* — **70 miles at Holbrook**. *How much of a speed is living rather than driving?* — **7.5 mph**. *Can a record hold a state it never names?* — **Delaware**. *Where does a car sleep?* — **86% of elapsed days are dormancy; 34 of the 35 long spells are CA/AZ/OR, and the 35th is the St Louis car wash.**

**★★★ AND THE ARCHITECTURE WAS VALIDATED THE DAY IT WAS PROPOSED.** Kim told the car-wash story to apologise for not remembering Summersville. **It turned out to be the sole explanation of the only outlier in a distribution nobody had computed** — Altamont IL 2010-10-11 to 11-05, 25 days, 227 miles between two fills seventeen miles apart. **Layer 2 generated the question; layer 3 answered it; neither could alone.**

**★★ THE DIFFICULTY END IS A THIRD NARRATIVE, NOT A METHODS APPENDIX.** Same shape as the driving stories — problem, mechanism, resolution. **The slashed zero that predicts the DIRECTION of an error. The crossbar that was a scanning artifact. The pump identity. The split total that places a route. The backup with two blind gates.** Write them; do not bury them.

**★ EDITORIAL RULE, testable today:** an analysis earns the ANALYSIS strand only if it answers a question the drives raised. **Results with no story belong to the DIFFICULTY strand** — the retired temperature effect, the wide-tire interval straddling zero, the Canadian non-result, and now **the unsettleable southern economy signal.** All are the data being honest about what it cannot say.

**The three layers are the three instruments — preconception, memory, record — and they fail differently:** the record is silent where its resolution cannot reach (036); the memory keeps content and loses index, and keeps CLASSES while naming specifics (039); the preconception is simply wrong, which is the point of the book. **The reading structure and the working structure are the same structure. Say so in the Foreword.**

## Next Steps
1. **★★★ DRAFT THE CHAPTER LIST against the three layers, and WRITE THE SAFETY CHAPTER FIRST.** It demonstrates the architecture on the project's own central question. Retire the charter's six-chapter list for good; sort the existing inventory into the ANALYSIS and DIFFICULTY strands.
2. **KIM:** name the tree-tunnel stretches he remembers (do not infer them); and whatever exists for Bordeaux.
3. **KIM:** rule on what the backup should carry (Finding 038) — 22 scans and the authored `.txt`/`.docx`/`.pptx` files are outside the mirror, and the `.gitignore` must change in step with `SOURCE_EXT`.
4. **KIM, unscheduled:** update the TwoRed fuel logs for the last miles to ~75,000. **Check `TwoRed_fuel` (the live Sheet) first** — richer than the exported `.xlsx`, with ~141 more fill temperatures.
5. **OPEN:** Creamsicle trip legs run to 2024-10-20 but fills stop at 2024-07-02. **Not an absence claim** — the read may have been truncated.
6. Then: `Expedition_ID` on every fill across BOTH documented cars (read `Fuel_Analysis.Rmd` first); **the parking constellation** and the driving constellation (the Jul-2024 Creamsicle update carries lat/long); and Kim's three analyses — fuel costs, daily distances, average speeds.

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
