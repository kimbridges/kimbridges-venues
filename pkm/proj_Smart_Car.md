# PROJECT: Smart_Car
_Last updated: 2026-09-01_
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

**★★★ THIRTEEN PIECES DRAFTED. Foreword and chapters 1-12 exist as prose -- about 25,700 words. 16 chapters render, 0 error strings, 0 unresolved cross-references (2026-09-01).** ★ Kim has read and approved ch.3, ch.4 and ch.5; **ch.6 through ch.12 are drafted but unread by him.** Per-chapter detail lives in `session_log.md` (2026-08-31 and 2026-09-01) rather than here. The notes below this line describe ch.4 and earlier and are kept as written.

**`expeditions.qmd`** — ch.4, ~2,530 words, **two tables and no figure**. Seven sections.
**★★ ITS SUBJECT CHANGED ON CONTACT WITH THE MASTER DICTIONARY:** Kim's c.2015 summary names
**14 expeditions**; the trip log holds 13 trips, and **7 of his 14 have NO trip log at all** —
including the first crossing — while Sedona is logged as a fragment. So the chapter is not the
crossings one by one; it is **the trip log was never a record of the trips.** The fractal scope
boundary at a THIRD scale: ch.3 found it inside a trip, the Foreword at the end of the car's life,
ch.4 finds it BETWEEN trips. `data/TwoRed_expeditions.csv` + `book/R/expeditions_data.R`.
**`tbl-expeditions`** (his list against the log) and **`tbl-growth`** (what the record carries, trip
by trip) — **the growth table shows a field being DROPPED: written distance goes to 0% from 2016**,
the one place in sixteen years where Kim can be seen deciding what mattered.
**★★★ AND THE EXTREMES TABLE IS NOW COMPLETE** — see the Mount Evans recovery below.

**`the_anchor.qmd`** — ch.3, ~3,400 words, TWO figures. Seven sections, ordered story → method →
picture → consequence → exception. **`@fig-regimes`** (50 spans, both cars, log-log with iso-rate
diagonals, so a regime is a BAND not a threshold) and, added 2026-08-28, **`@fig-dwell`** —
**where the days went.** 346 fill-to-fill intervals, log x, faceted by car, y a SHARE of each
car's covered days. **TwoRed 78% of its days in stretches of a month or more, Creamsicle 75%;
the driving days are 5% and 7% of the calendar; the middle (2–29 days) is 17% and 18%.**
**★ BOTH CARS HAVE THE SAME SHAPE** — a decade apart, different coasts, different jobs — which
makes the anchor pattern the FLEET's and not TwoRed's. It reproduces the independently-recorded
86% (≥14 days) and Creamsicle's 1,123 covered days exactly, on first run.
**★★ THE FORM CHANGED ON CONTACT WITH THE DATA:** a frequency diagram counting INTERVALS is
swamped by a one-day spike (57% of intervals) and hides the very thing the chapter is about.
Counting DAYS asks the chapter's question instead. `R/dwell_data.R`, `R/fig_dwell.R`.

**`index.qmd`** — Foreword, ~1,150 words: the errand car, the parking spot, **the four cars introduced by name**, Hawaii, the three layers, and the scope boundary as subject. **`small_cars.qmd`** — ch.1, ~720 words: how small, why it's that shape, **TwoFer's whole life covered in four of TwoRed's driving days**, and four decisions over sixteen years. **`is_it_safe.qmd`** — ch.2, ~2,300 words, two figures: *cute* as the opener, the demonstration, **both close calls as one failure**, the 100,999-mile denominator, the wide tires priced rather than judged.

**The manuscript:** Quarto book at `Smart_Car/book/`, 15 chapters, `R/book_setup.R` as the single source of truth with `stopifnot()` row-count guards. **Cross-references verified across all files — no dangling refs, no duplicate ids, image paths resolve.** **Voice rule: contractions.**

**The record.** TwoRed: 294 audited fills, odo 4 → **71,283 at the Matson dock**, 65 errata, 139 legs, time zones COMPUTED. Creamsicle: 173 fills, 86 legs, **with STOPPED TIME**. **Nineteen of Kim's accounts collected verbatim, every one cross-checked. All four unwitnessed states now closed** — three by geometry, Florida by incidental knowledge (Finding 044).

**Not ready:** the temperature effect is **retired**; the wide-tire interval is **not printable until re-derived**; the Canadian variance test is a NON-RESULT; the southern economy signal **cannot be settled**; route work partial at a 78% gazetteer join; **TwoFer is still not ingested.**


**2026-08-31 — SEVEN PIECES STAND (Foreword + ch.1-ch.7, ~17,000 words) AND THE BOOK RENDERS END TO END FOR THE FIRST TIME.** Ch.5 `long_days.qmd` and ch.6 `the_roads.qmd` drafted; **a new ch.7 `the_marine_highway.qmd`**; new sections written into ch.1 and ch.2. **16 chapters render, 0 error strings.** Status and Focus readiness UNCHANGED (Active / Ready).

**Six accounts collected from Kim and four rulings taken, all verbatim in the log:** the calibration baseline and the logistics partnership; tree tunnels; ch.6's two-layer spine; the ferries and the Whittier tunnel; and fuel economy from his side. **Four analyses came out of them** — no learning curve in the day length (p = 0.44); five sea passages totalling **twelve odometer miles**; Costco worth **$0.20/gal** (paired Wilcoxon p = 0.008); and the slow-driving economy claim as a **signal that does not survive `leg_miles`**.

**Two infrastructure findings.** **049** — two chapters had silently stopped rendering because inline `r` read variables defined in chunks lower in the file; after touching `book_setup.R`, render the whole book. **050** — **ten hardcoded chapter numbers are wrong**, half from inserting ch.7 and half from an older mismatch between the project's numbering and Quarto's. **The fix is to stop writing numbers** (`{#sec-name}` / `@sec-name`). Table in `deferred.md`.

⚠ **This file is 55.7 KB against a 45 KB budget and `pkm_health()` marks it splittable.** The 2026-08-31 material was kept deliberately short for that reason; **a split is the next housekeeping job on this project.**
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

## ★ THE AMEX STATEMENTS ARE A THIRD INDEPENDENT RECORD (2026-08-18) — AND THE RECEIPTS ARE A FOURTH (2026-08-28)

Kim scans everything. The AMEX statements and pump receipts recovered three contaminated 2016 rows, and when the paper log turned up months later it **matched them exactly on gallons and cost.** **Three independent records agreeing to the thousandth of a gallon.** The lesson was the search, not the data: it was the wrong KIND of search, not missing data.

**★★★ FOURTH RECORD, 2026-08-28 (Kim): THE FUEL RECEIPTS PRINT THE ODOMETER.** *"a duplication of

**★★★ FIFTH RECORD, 2026-08-29: KIM'S 2014 TALK AT LAKE SAN MARCOS.** Given just after the big trip, so
**contemporaneous rather than recall.** It names the four states the drive was needed for — Florida,
Delaware, Rhode Island, Vermont. **THREE OF THOSE ARE EXACTLY THE STATES THE GEOGRAPHY INSTRUMENT
RECOVERED FROM ODOMETER ARITHMETIC ALONE** (no fill, no leg naming them). A 2014 document confirms three
inferences made in 2026 from numbers. **And its OMISSION is the proof it is reliable: South Dakota is not
in the list, because it was crossed in 2012** — the talk is silent exactly where it should be.
**Finding 045 for the fifth time.** ⚠ Delaware's leg recomputes to **265** miles, not the 264 printed here
— reconcile before ch.4 prints it. **TASK: file the talk in `source/`; it is a document, not a memory.**
data I had forgotten about."* He used it to settle the Ely/Las Vegas city error. **This is the only
record that duplicates the COUNTER** — AMEX can settle gallons, price and merchant, never a counter
reading — **so it can audit the one field every other instrument treats as ground truth.**
**Finding 045 for the fourth time** (AMEX, Styx River Road, the Florida photograph, this): every
time the redundant record existed and had been FORGOTTEN rather than lost. **Rule: inventory the
redundant records before declaring a field uncheckable.**


**★★★ SIXTH GEOMETRIC RECOVERY, 2026-08-29 — MOUNT EVANS, and Kim named the test himself.**
*"None of this appears in the record unless there is a mileage anomaly on the route."* There is.
**2016-06-20 Denver → Grand Junction: the LEG reads 305 against ~250 on I-70 (excess 55); the TANK
(Watkins → Gypsum) reads 203 against ~150 (excess ~53); the CLOCK reads 10.2 h for a 4 h drive.**
The byway is 28 miles each way — **56 out and back.** Control: the same stretch eastbound three weeks
earlier, same station, **50.15 mpg down against 40.75 up.** **This closes the one blank row in his own
2015 summary** (*Highest Elevation: see upcoming trips*). Photographs lost; the odometer kept it.
## ★★ THE AUDIT TOOLKIT — SEVEN INSTRUMENTS (2026-08-18; seventh added 2026-08-28) — full write-up in the log

**pump identity** (gallons × $/gal = cost) | **economy** | **geography** (great-circle vs odometer) | **contiguity** | **price family / same pump** | **the DOTTED ZERO on the printed receipt** -- a physical mechanism, so it predicts error DIRECTION (Finding 033). ⚠ **Renamed 2026-09-01: Kim corrected the cause. It was never his slashed handwriting; it was small, faint receipt print with a dot in the zero, read in poor light.**

**None is redundant: every major error was caught by exactly one.** The decisive pairing is contiguity + arithmetic — where two adjacent rows share a value, **the row that BALANCES is the source and the row that FAILS is the copy.**

**★ SEVENTH, added 2026-08-28 — THE ODOMETER AS A CLOCK.** Sort by DATE and require the odometer
to increase. The other six take the date as GIVEN and test the row against arithmetic, geography or
its neighbours, so **none of them can see a wrong date.** **TwoRed is CLEAN across all 294 rows.**
Creamsicle fails **exactly once** — the Ely NV row dated `2023-04-14` sits 1,410 miles below a fill
dated 2023-03-26 — and the odometer localises it between Parowan 03-13 and Beatty 03-14 without
settling the day. **Found by a FIGURE, not by an audit**, because the figure needed date ordering.
**Kim ruled BOTH errors in that row, 2026-08-28.** The date was a month typo (**C04**, 4->3); **and the CITY was wrong too — `Ely` is really `Las Vegas` (C05), settled FROM THE STATION RECEIPTS.** Caught by geography: Ely→Beatty is 191 mi great-circle against 136 on the counter, and a great-circle distance is a FLOOR. **Two errors in one row, each caught by a different redundant field.** Applied via a new `Creamsicle_corrections_machine.csv` + errata application in `creamsicle_ingest.R` (mirroring TwoRed; hypotheses C01-C03 stay unapplied), and **the odometer-as-clock check now runs inside the ingest.**

**Three standing limits.** For the 0/8 class **the scan is not evidence**. A **high road/straight-line ratio is sometimes a story**, not a defect. And every instrument has a **floor** (Finding 036). **★ The geography instrument also works in reverse: it RECOVERS what the log never named — Delaware, and probably Rhode Island (Finding 043).**

## ★★ THE CORRECTED DATASET (2026-08-18) — build story in the log

**Building `twored_ingest.R` forced three things a correction LIST could not:** a row **INSERT** (the Big Spring/Alpine chimera needed a SPLIT, not a relabel -- which is exactly why it passes the arithmetic test perfectly); **EXPLICIT** partial-fill flags rather than a threshold recomputed each run; and a **GUARD THAT REFUSES** any correction whose `old_value` misses its row. **A correction that cannot find its row is a BUG, not a no-op.** `logs/proj_Smart_Car_log.md`.

## ★★ FIRST ANALYSIS ON CLEAN DATA — SIX RESULTS (2026-08-18) — detail in the log

Median leg **251 mi**; log distance ~**95%** of odometer miles; lifetime **39.44 MPG**; **leg length is the strongest predictor, +4.61 MPG per 100 mi**; **no degradation in sixteen years**; **$0.0936 per mile**. Temperature is superseded and retired.

## ★★ THE WHEELS WERE NEVER ABOUT FUEL — THEY WERE ABOUT SAFETY — folded into ch.2

Stock narrow tires let a **variable** desert crosswind push the car out of lane; **the cost was in the constant correcting, not the force.** Smart Madness prescribed wide tires. **Handling is the mechanism of the safety thesis.** Economy difference indistinguishable from zero under every specification — **but the interval is NOT PRINTABLE until re-derived.** ⚠ **THREE wheel states, not two:** the 2013 Dalton run was on steel rims (21 rows); the conclusion survives, the confound is reported, nothing attributed.

## ★★ KIM'S FRAME: TWO LOGS, TWO SUBJECTS (2026-08-18) — the FABRIC of the three layers

*The fuel log is more about the CAR'S performance, while the trip log shows the HUMAN performance -- how far and fast can you expect to drive in a day, something I had no idea about until I started doing these drives.*

**Economy, degradation, cost/mile and the wide-tire question are the CAR's; daily range, departure discipline and gross speed are the HUMAN's.** Fuel records STOPS, trip records LEGS; **the odometer is the JOIN, not the topic.** **Bounded:** the trip log records what the human ACHIEVED, in MEANS not variance; **the stories are the only record of what it COST** — and, per Finding 041, of where the car was allowed to sit.

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

## ★★★ THE OPEN QUESTIONS ARE ALL CLOSED (2026-08-19/21) — full working in the log

**1. The 46 Dalton miles are 32 + 14 — Coldfoot → Wiseman.** Two Yukon River Crossing fills split the leg (115 out / **147 back**); the Wiseman spur is ~16 road miles, so **out and back is 32, to the mile.** *A matching TOTAL doesn't mean a matching ROUTE; a SPLIT total localises the discrepancy.*

**2. THE PENULTIMATE STATE IS VERMONT** — a lawyer with an office in NH and a house across the river. **Exactly the anomaly the record flagged and couldn't read:** Hartland VT → Lebanon NH, **two nights and 59 odometer miles for an eighteen-mile drive.** **★★★ CORROBORATED 2026-08-29 BY KIM'S 2014 TALK AT LSM** (contemporaneous, given just after the trip): the drive was needed for **four** missing states — **Florida, Delaware, Rhode Island, Vermont — and Vermont was the LAST.** ★ It also explains the trip's NAME: **Vermont is the 49th, Hawaii the 50th and never driven to**, so Vermont is at once the last state reached by car and the penultimate of the fifty. Both framings in this file are right; they count different sets.

**3. ★★★ THE STATE COUNT IS 49 AND 10, ON KIM'S TESTIMONY — and my framing was wrong (Finding 043).** I had written that TwoRed's list and Kim's list were two different quantities. **They're one quantity and a log that witnesses 45 of it.** A count DERIVED from a record inherits the record's resolution, silently, because the count looks like an ordinary number.

**★★ ALL FOUR UNWITNESSED STATES ARE NOW CLOSED, by four different routes:**

| state | how |
|---|---|
| **Delaware** | geometry — 264 odometer miles where the only Delaware-free road is ~305 |
| **Rhode Island** | geometry — the Douglas MA fill sits on MA-146, the Providence road; 287 mi fits the coastal route |
| **South Dakota** | geometry — **255 miles against ~175 direct, ratio 1.83, the most indirect stretch in sixteen years**, on the northern road through Chadron NE, twelve miles from the line. A deliberate dash to cross the border, with **a storm-chaser convoy coming the other way** |
| **Florida** | **PHOTOGRAPHED.** Three kinds of evidence: testimony (unfalsifiable), **Styx River Road** — incidental knowledge, falsifiable, survives (Finding 044) — and **a geotagged photograph at 30.983392, -87.571312: 1.15 miles inside the state, 5.4 from the Atmore fill.** The whole visit is ~11 miles hung off a fuel stop, and the New Orleans → Atmore segment already carried 210 miles against ~195 direct |

**⚠ My *no leg has room for South Dakota* was wrong: the arithmetic was right and the HYPOTHESIS was wrong** — I assumed visiting a state meant going somewhere IN it. **A negative result is only as strong as the hypothesis it tested.**

**4. ⛔ THE TEXAS ON-RAMP — CLOSED BY REQUEST.** **Never placed more precisely than NEAR FORT WORTH.**

## ★★★ CREAMSICLE IS INGESTED — THE SECOND SPINE EXISTS (2026-08-19)

`creamsicle_ingest.R` reads the exported workbook and emits `Creamsicle_fuel_clean.csv` (**173 rows**) and `Creamsicle_trip_clean.csv` (**86 legs**). Same architecture as TwoRed: **the source is never edited**, interleaved total/average rows are skipped programmatically, and **the skip counts are reported** (196→173, 119→86, 10→6) per Finding 032.

**It arrived clean.** Odometer **30,290 → 58,903, strictly increasing — and, since 2026-08-28, in DATE order too.** It failed that second test exactly once (the Ely row, a month typo Kim ruled on and C04 now corrects); **the two orderings are not the same claim**, and only the first had ever been checked. Pump identity: **143 of 170 US rows balance to under half a cent; exactly THREE fail by 2c or more**, and all three resolve — **C01 Oxnard** $/gal 4.399→3.999, **the cell IDENTICAL to the Gallons cell**, caught by contiguity; **C02 Miranda** a 59/95 transposition; **C03 Hays** 3.499→3.449. My recomputed MPG matches Kim's own column to **0.005**. **The three BC rows carry litres and CAD alongside gallons — the unit problem TwoRed still has is already solved here.** **⚠ "Resolve" means an arithmetic hypothesis was found, NOT that the data carries the fix: C01-C03 are `tier = hypothesis` in `Creamsicle_corrections_machine.csv` and are deliberately NOT applied. The clean CSV still holds the logged $/gal for those three rows until a card or receipt settles them.**

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
- `data/TwoRed_fuel_clean.csv` (294), `TwoRed_log_errata.csv` (65), `TwoRed_fuel_timetemp.csv` (**156 as of 2026-08-31** -- the whole Alaska trip transcribed from `2013_TwoRed_Fuel_Trip_Logs_Alaska.pdf`, 22 rows, every odometer key gated against the fuel log on the same date), `TwoRed_city_timezones.csv` (121 cities).
- **Creamsicle:** `Creamsicle_fuel_clean.csv` (173), `Creamsicle_trip_clean.csv` (86), `Creamsicle_log_errata.csv` (the human-readable record) and — **NEW 2026-08-28** — **`Creamsicle_corrections_machine.csv`** (C01-C05; the file `creamsicle_ingest.R` actually applies, keyed to the ODOMETER, `tier` gating what is applied). `creamsicle_ingest.R` now **applies errata with a refusing guard and runs the odometer-as-clock check.**
- **`book/R/dwell_data.R` + `book/R/fig_dwell.R` — NEW 2026-08-28.** The `@fig-dwell` pair: fill-to-fill intervals for both cars, and the time-weighted figure built from them. `dwell_data()` reports its own skip counts in `attr(, "same_day")` and `attr(, "backward")`.
- **`data/TwoRed_expeditions.csv` — NEW 2026-08-29.** Kim's own list of 14 named expeditions, transcribed VERBATIM from `source/Smart_Car_master_dictionary.pdf` with a `source` column recording where each field came from. **7 of the 14 have no trip log**; the join is what ch.4 is built on.
- **`book/R/expeditions_data.R` — NEW 2026-08-29.** Joins Kim's list to the trip log and computes the record-growth table (which fields each trip carries, as a share of its legs) plus the 2010 fuel-only figures for a crossing with no trip log.
- **`book/the_marine_highway.qmd` — NEW CHAPTER 2026-08-31.** The five sea passages. Added to `_quarto.yml` in The Drives after `the_roads.qmd`, which **renumbered every chapter after it — see Finding 050 and `deferred.md`.**
- **`book/R/long_days_data.R` — NEW 2026-08-31.** `long_days_data()` (every leg of 450 mi or more, distance from the odometer with a written-figure fallback), `long_day_early()`, `day_segments()` (within-day fill-to-fill segments, with a timezone argument), `day_shape()` (the ordinary day: median leg, arrival and departure clock, and the no-learning-curve test).
- **`book/R/roads_data.R` + `book/R/fig_roads.R` — NEW 2026-08-31.** `@fig-roads`, and **`ROADS_SOUTH` / `ROADS_APPAL` now STATE the group rule in code** — it had been quoted for eleven days with nothing written down. Also `roads_tanks()` (the I-65 tank pair) and `roads_dalton()`. Figure at `book/figures/roads.png`.
- **`book/R/ferries_data.R` — NEW 2026-08-31.** The five sea passages and `ferry_tank()`. **Water distances are Kim's and are marked as his; nothing in the record measures them.**
- **`book/R/driving_cost_data.R` — NEW 2026-09-01.** The hinge chapter: the three prairie legs, the three-days-one-shape table, and **Creamsicle's gross-vs-net gap (84 legs, 43.5 vs 51.0)** — the measurement that sizes what a two-point trip log averages away. ⚠ The `net_mph` on the Cranes row is an artifact of quarter-hour rounding; never printed.
- **`book/R/paper_data.R` — NEW 2026-09-01.** Ch.9. Counts the scans (20 files, 67 pages), buckets the 65 errata, and **runs the slashed-zero test LIVE off the source workbook** in both its forms (rows repaired, and Finding 033's substitution rate). ⚠ Substitutes on values AS RECORDED; a zero-padded rendering invents digits and inflates the mirror direction.
- **`book/R/audit_data.R` + `book/R/fig_audit.R` — NEW 2026-09-01.** Ch.10. **The pump-identity tolerance is DERIVED** (`0.005 + gallons*0.0005 + ppg*0.0005`), replacing the flat half-cent. `@fig-audit` shows the wall of rounding noise, the empty corridor and the real errors.
- **`book/R/cost_data.R` + `book/R/fig_cost.R` — NEW 2026-09-01.** Ch.11. Lifetime economy as total miles / total gallons; the cost-per-mile decomposition as an identity; tank length, age and wheels. `@fig-cost` is two questions on one y axis.
- **`book/R/day_data.R` + `book/R/fig_day.R` -- NEW 2026-09-01.** Ch.12. Built on **Creamsicle's optional free-text `comment` column**, which turns out to be a stopped-time detector: 35 of 84 legs carry a comment and hold 73.4% of all stopped time. Reports the three-way test (miles p = 0.97, gross mph p = 0.002, net mph p = 0.36) so nothing is typed. `DAY_CATS` **states the grouping rule in code** and files a two-part comment under the FIRST match in the stated order. `@fig-day` at `book/figures/day.png`. ⚠ The grouping is mine, not Kim's, and has not been put to him -- see `deferred.md`.
- **`book/images/TwoRed/log_sheet_frostburg3.png` — NEW 2026-09-01.** Page 3 of `2012_TwoRed_Frostburg_Trip_Log.pdf` at 150 dpi, the book's first photographic figure. Regenerate with `pdftools::pdf_convert()`; do not edit.
- **Every chapter heading now carries a `{#sec-...}` label and `index.qmd` / `afterword.qmd` are `{.unnumbered}` (2026-09-01).** Chapter cross-references are generated, not typed — see Finding 050 and `deferred.md`.
- `source/` — **★★★ `2014_Chateau_Presentation.pptx` (50.3 MB, 121 slides, dated 2014-06-16, four days after the trip closed) — A PRIMARY SOURCE, added to this list 2026-08-29 after sitting unlisted since intake.** *Driving to the Extremes*, given at Lake San Marcos. **Slide 42 names the four missing states (Florida, Delaware, Rhode Island, Vermont) in writing; slide 6 is an independent 2010-2013 computation; slide 121 gives the 10,907-mile total; and 121 embedded photographs answer the TwoRed-photo question.** Also: `Smart_Car_master_dictionary.pdf` (expedition names, dates, targets); `Smart_Car.docx` (10.3 MB, largest section is the already-published Arctic Circle Challenge — **a quarry, not a draft**); `Smart_Car_2016.pptx`; `charter_2026-05-08.md`, kept verbatim, superseded on scope and Chapter 5.
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

## ★★★ THE SAFETY QUESTION — LAYER ONE'S CONTENT, DRAFTED AS ch.2

**The preconception isn't *it's a city car*. It's a question with a fear in it: IS IT SAFE?** — and it arrives as **affection**: people say *I like your car* first and worry second. Three parts, and only the third is the thesis: the engineering answer (*see the silver part?*, the race drivers with their hands up) which by his own verdict lands as **maybe, maybe not**; the empirical answer; and **SMALL AND NIMBLE ARE COMPONENTS OF SAFETY**, which INVERTS the preconception rather than rebutting it.

**★★★ BOTH CLOSE CALLS ARE ONE FAILURE: A TRUSTED PATTERN THAT DIDN'T HOLD.** *You learn the pattern. You begin to trust your experience. Accidents happen when the pattern doesn't hold.* **You can't make patterns hold, so the only thing left to ask of a car is what it can do in the second after one breaks. A safety cell is for the crash you're having; handling is for the crash you aren't going to have.**

**Layer 3 has the denominator: 100,999 documented miles across three cars**, 467 fills, 225 legs, **49 states and 10 provinces** (the log witnesses 45 — Finding 043), no crash. **Layer 2 has the numerator — a crash avoided buys no fuel and ends no leg.** **Miles without near-misses are absence of evidence; near-misses without miles are anecdote.**

**⚠ Disciplines held in the draft:** *granted, no crash testing*; and **101,000 crash-free miles are not oversold** — one prudent driver, mostly interstate, mostly daylight. **The miles show the car didn't prevent sixteen years of safe driving; the near-misses are where the car actively contributed.** **The wide-tire interval is NOT PRINTABLE until re-derived.**

## ★★★ CHAPTER ARCHITECTURE — KIM'S THREE LAYERS (2026-08-19) — full development in the log

*The Smart Cars are the "hook"... The two aspects of performance, car and human, is the fabric... The data become the real issue... People see the unusual cars (and have preconceived notions). The drives make interesting stories. The data give satisfying answers to questions, even those you didn't know you had.*

**TWO LOGS, TWO SUBJECTS was a fine SORTING rule and a useless ORDERING rule.** Three layers says what a reader meets first and why they keep going, and the two compose: **the car/human fabric runs THROUGH all three. It's the weave, not a chapter.** **Three DEPTHS of one material, each bought by the one above** — without the preconception the drives are travel; without the drives the numbers have no question; without the numbers the stories are anecdote.

**★★ *Questions you didn't know you had*, proven:** *what does a day OFF the highway look like?* — **70 miles at Holbrook, 59 at Hartland.** *How much of a speed is living?* — **7.5 mph.** *Can a record hold a state it never names?* — **Delaware, Rhode Island, South Dakota.** *Where does a car sleep?* — **86% of elapsed days.**

**★ EDITORIAL RULE:** an analysis earns the ANALYSIS strand only if it answers a question the drives raised. **Results with no story belong to the DIFFICULTY strand** — the retired temperature effect, the wide-tire interval, the Canadian non-result, the unsettleable southern signal.

**The three layers are the three instruments — preconception, memory, record — and they fail differently:** the record is silent where its resolution can't reach (036), **and that silence belongs to the instrument, not to the past (045)**; the memory keeps content and loses index (039), and keeps CLASSES while naming specifics; **a fuel row is a TRANSACTION, not a STATE (041)**; and **a derived count inherits the record's resolution (043)**. The preconception is simply wrong, which is the point of the book. **The reading structure and the working structure are the same structure. Say so in the Foreword.**

## ★★★ THE CHAPTER LIST AND THE MANUSCRIPT (2026-08-20) — full draft in the log

**13 chapters, four parts, front and back matter. Kim approved the design and the interleaving.** FOREWORD | **PART ONE, THE CAR:** 1. *These are small cars!* · 2. Is it safe? | **PART TWO, THE DRIVES:** 3. The anchor · 4. The expeditions · 5. The long days · 6. The roads · **7. What the driving cost — the hinge** | **PART THREE, THE DATA, both ends interleaved:** 8. Sixteen years of paper *(diff)* · 9. How you know a number is wrong *(diff)* · 10. What the car cost · 11. What a day in a Smart looks like · 12. The two constellations · **13. What the record cannot say** | **AFTERWORD.**

**★★ THE ARGUMENT KIM ACCEPTED: the difficulty chapters EARN the analysis chapters.** A reader can't believe *$0.0939 per mile* until they know how the cost column was audited. **⛔ And the PKM's own tooling failures are OUT of the book.**

**The manuscript:** Quarto book at `Smart_Car/book/`, house pattern, **`R/book_setup.R` as the single source of truth** with `stopifnot()` row-count guards — **no number reaches a page without coming from an object.** Each undrafted chapter carries a scaffold comment holding purpose, verified material and privacy constraints. **Cross-references verified: no dangling refs, no duplicate ids, image paths resolve.**

## ★★★ FINDING 045 — A SILENCE BELONGS TO AN INSTRUMENT, NOT TO THE PAST (2026-08-21)

**Kim produced a geotagged photograph of the Florida corner.** Finding 036 said the fuel log's resolution cannot reach that visit. **It was right.** What it does not license is the sentence I then wrote repeatedly — **that the visit was UNRECORDABLE.** It was unrecordable **by that log.** He was carrying a second instrument the whole time, sampling on a different trigger: **not *I bought fuel* or *the day ended*, but *this is worth looking at*** — the exact trigger a state-line dash satisfies and a fill-up does not.

**A quantifier slip.** *This record cannot hold X* is a claim about a record; *X is not recorded* is a claim about the world. **I let the first license the second**, and the gap between them is every other instrument that happened to be running. **Rule: when a record cannot reach an event, the next question is not *is it lost* but *what ELSE was running at the time?*** **Three times now — AMEX, Styx River Road, this photograph — and each time I had already called the gap unreachable.**

**★★ AND IT IMPROVES CHAPTER 13 RATHER THAN DAMAGING IT.** The chapter is no longer *here is what the record cannot say* but ***here is what THIS record cannot say, and here is how we found out anyway*** — which ends in recovery instead of a shrug.

**★★★ THE QUESTION IT OPENS, and it may be the largest one left: IS THERE A TWORED PHOTO ARCHIVE?** Creamsicle has 37 geotagged, timestamped photos that join to its logs with no timezone reconstruction. **Nobody has asked about 2010-2017.** A photo archive samples exactly where a fuel log cannot — **the complement, not a duplicate** — and would bear on ch.12 and most of ch.13.

**✓✓✓ ANSWERED 2026-08-29 — YES, THERE ARE MANY; BUT THEY ARE NOT A LOCATION INSTRUMENT.**
`2014_Chateau_Presentation.pptx` embeds **121 images, 50.1 MB** from the 2013 and 2014 expeditions —
the Alaska Marine Highway, the Dalton, Wiseman, fireweed, an ermine, the Moncton tidal bore — so
photographs were taken and curated within four days of the trip ending. **Kim confirms the wider
archive exists.**

**⚠ BUT THE EXIF IS SPARSE AND CARRIES NO GPS** (Kim: *"these were cameras without GPS. No locations
recorded"*). **This is NOT the Creamsicle situation and must not be described as it.** Creamsicle's 37
photos join on date + local time **with coordinates**; TwoRed's carry none. **Two different
instruments, not one instrument at two dates.**

**★★ WHAT THEY CAN DO — the Ogunquit case is the template.** A photograph with no geotag is evidence
that must be IDENTIFIED before it is evidence. Maine 2010 was settled by recognising a coastline and
then finding that **the geometry independently demanded the dash** (Danbury→Charlton, ratio 3.64
direct against 1.13 via Ogunquit). **Method: visual identification, then arithmetic corroboration.**

**★ CH.13 MATERIAL.** The instruments did not merely improve; they changed KIND. The 2010 photograph
needs a human to say where it is; the 2021 photograph says so itself. Same photographer, same act,
different evidentiary status, decided by a chip.

**DEFERRED with a specific trigger:** fish the archive only when a chapter has a question a photograph
could settle. Do not inventory it speculatively. Timestamps are the useful field.

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
1. **★★★ KIM READS CH.4** (drafted 2026-08-29, ~2,530 words, two tables). Then **ch.5 `long_days.qmd`** — its scaffold already lists all eight long days with the material collected.
2. **KIM — still only he has these:** the Yukon pothole in his own words (the last thin patch in ch.2); the tree-tunnel stretches by name; Bordeaux's character and the "last ones the dealership sold" detail for the Afterword.
3. **TASK before any figure is printed:** re-derive the wide-tire interval with a WRITTEN specification. **A number that cannot be reproduced is not sourced.**
4. **SMALL TASK:** TwoFer's 1,209 miles is still a TYPED constant in ch.1 and ch.2. The `TwoFer Gas Log` Sheet is live-only and never ingested — 7 fills, ten minutes.
5. **OPEN, low cost:** C01-C03 are still `hypothesis` and unapplied. The station receipts settle them — the same source that closed C05.
6. **★ NEW, from the 2014 deck:** slide 6's 2010-2013 totals reconcile EXACTLY on fill count (163) and distance (39,739) but differ by -0.22% on gallons and +0.53% on cost, **and the errata do not explain it.** Look at the interleaved running-total cells in the source workbook, which slide 6 was probably typed from.
7. **Everything else lives in `deferred.md`** — Canada2014 units, Creamsicle's timezone table, `Expedition_ID`, the constellation maps, the ~141 extra fill temperatures, the photo archive (deferred with a trigger), and the open questions for Kim.
8. **⚠ `*.jpg` is gitignored in the mirror** — photographs are not in the versioned backup.

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
