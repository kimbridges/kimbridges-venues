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

**★★★ BOTH CARS ARE INGESTED, THE TWORED RECORD IS CLOSED AT BOTH ENDS, AND THE ONLY THING BLOCKING THE WRITING IS THE CHAPTER ARCHITECTURE (2026-08-19).**

**TwoRed fuel spine: 294 rows, odometer 4 → 71,283, 2010-07-23 to 2017-05-22, audited.** 277 of 294 balance the pump identity; the 13 that fail carry a documented basis. **65 errata**, 4 open. `twored_ingest.R` emits `TwoRed_fuel_clean.csv` with provenance per row; the source workbook is never edited.

**TwoRed human spine: 139 legs across 12 trips** (132 timed), **41,163 mi = 58% of lifetime**, 174 fuel rows under a leg (59%), **134 fills carrying time and temperature (46%)**. Time zones are COMPUTED from a 121-city IANA table, not stored. **Eleven of Kim's accounts are collected verbatim and every one cross-checks against the log.**

**Creamsicle: 173 fuel rows, 86 legs, ingested 2026-08-19** by `creamsicle_ingest.R`, with stopped time — the instrument TwoRed lacks.

**Ready to write:** economy, cost per mile, degradation; the shape of a driving day; gross speed by road (stating the means-not-variance limit); the stories. **Not ready:** the temperature effect is **retired**; Canadian economy blocked on litres/CAD normalisation; route work partial at a 78% gazetteer join; **states 45 of 49 documented** (provinces confirmed at 10).

## The fleet

_Given by Kim 2026-08-12. This replaces the single-car framing entirely._

| # | Name | Year / model | Power | Status | Data on hand |
|---|---|---|---|---|---|
| 1 | **TwoRed** | 2010 Smart Passion | ICE | **Owned** | Deepest by far — 293 fill-ups, 2010-2017, 52 states/provinces |
| 2 | **Two4Two** / **TwoFer** | Smart Pure | ICE | **Leased** from 2014-03-22; returned | **`TwoFer Gas Log` FOUND 2026-08-16** -- 7 fill-ups, 2014-03-22 (dealer, odo 0) to 2015-01-10, **1,209 miles, every one in Honolulu** |
| 3 | **Creamsicle** | 2016 453 ForTwo "Edition #1", white/orange, 0.9L turbo triple, 89 hp, six-speed | ICE | **Sold** to family 2024-10-20 | **FOUND 2026-08-16 — the second spine, and it is a DRAFT not raw material.** Gas log 2021-09-23 to 2023-09-27 (odo 30,290→51,345, metric BC fill-ups already normalised); trip log 2021-09-23 to 2024-10-20; Jan–Jul 2024 update **with lat/long**; a 9-trip narrative; a packing inventory. **28,697 miles / 1,123 days / 9,845 mi-yr**, 18 states + Canada |
| 4 | **Bordeaux** | 2018 Smart | **Electric** | **Owned** | Not yet inventoried |

**The arc the roster makes visible, which one car could not.** Sixteen years, four cars, three ICE and one electric, spanning purchase, lease, resale and replacement — **and the choice made again three times after the first.** That is the fleet thesis.

**★ THE 75,000-MILE QUESTION IS RESOLVED (Kim, 2026-08-12).** TwoRed is **about 20 miles short of 75,000**; the log's 71,181 is where the *log* stops, not the car. **The charter was right and my reading of it was wrong.** The mainland record now closes at **71,283 at the Matson dock** (below), so the ~3,700 remaining are Honolulu miles. **Cite ~75,000 as Kim's figure, not as derived.**

**Creamsicle's data is the second spine and is now INGESTED (2026-08-19, below).** The project is not one documented car plus three anecdotes, but two well-documented cars bracketing a lease and an EV.

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

## ★★ THE WHEELS WERE NEVER ABOUT FUEL (Kim, 2026-08-18) — full write-up in the log

Smart Madness prescribed WIDE tires after the first crossing because the stock narrow "city" tires let crosswind push the car around at highway speed. **The purpose was handling, not economy.** Before/after, the economy difference is indistinguishable from zero, 95% interval **-3.7% to +4.9%** — the 1-3% penalty theory predicts sits INSIDE it. **The data rules out a LARGE penalty; it cannot detect a modest one.** (I first wrote the stronger claim and withdrew it in the same turn — same failure mode as Finding 032.) For the story: a decision made for one reason, measured on a different axis, where the measurement's job is to say what it COST, not whether it was right.

## ★★★ KIM'S FRAME: TWO LOGS, TWO SUBJECTS (2026-08-18) — now a component of the three layers; full write-up in the log

His words: *the fuel log is more about the CAR'S performance, while the trip log shows the HUMAN performance -- how far and fast can you expect to drive in a day, something I had no idea about until I started doing these drives.*

**It assigns instruments to questions** — economy, degradation, cost/mile, the wide-tire question are the CAR's; daily range, departure discipline, gross speed are the HUMAN's; **mixing them yields a meaningless average.** Neither log substitutes for the other: fuel records STOPS, trip records LEGS, and **the odometer is the JOIN, not the topic.** It also explains the collection history rather than apologising for it — trip logging started LATER because **the car's question was the obvious one to ask first; the human question is the one the driving taught him to ask.**

**Bounded 2026-08-19:** the trip log records what the human ACHIEVED, in MEANS not variance; **the stories are the only record of what it COST.** Creamsicle's 7.5 mph net-vs-gross gap is the first measurement of the conflation the frame implies. **This is now the FABRIC of the three-layer architecture below, not a rival to it.**

## ★★ THE SCAN SWEEP, 2026-08-18 — full write-up in the log

All 15 scans read (22 on disk). Four results that must not be lost:

**1. The wheel change is DATED** — `NEW WHEELS @ 13510 miles`, Kim's margin, 179 mi before the 2011 departure. **The estimate FLIPS SIGN with specification (+3.6% to -1.8%); that is the finding, not any one number.** The CONDITIONAL in `deferred.md` governs.

**2. ✗ THE TEMPERATURE EFFECT IS RETIRED (2026-08-19).** n=94 gave **-0.068, p=0.045**; 31 more fill-stamped temperatures took it to n=125 and **-0.050, p=0.099**, **p=0.17** with controls. The raw hot/cold gap (37.97 vs 39.61) dies on the same control — **hot fills are on shorter legs.** Write no thermal claim. **The record is now good enough to RETIRE a result.**

**3. The slashed zero produced three more corrections and the control held.** Over 44 rows failing the pump identity: **permitted 8→0 fixes 4; forbidden 0→8 fixes 1**; **six controls fix 0.**

**4. Gross speed separates by ROAD, across 138 legs in 12 trips.** 2011 interstate **47.6** | Frostburg 44.4 | Fourth Crossing 41.4 | Penultimate State 40.3 | Dalton **31.7** | 2017 February 31.1 | US-101 coastal **28.3**. Same car throughout. **But gross speed is a MEAN — see the Dalton return, where the same road one day apart differs by 6 mph.**

## ★★★ THE LONG DAYS — ALL EIGHT COLLECTED, AND EVERY ONE CHECKS OUT (2026-08-19)

**Kim's accounts are verbatim in `logs/proj_Smart_Car_log.md` under COLLECTED STORIES; the full confirmation table is there too.** Chapter source material. The four that changed something here:

| day | leg | mi | what the data independently shows |
|---|---|---|---|
| 2012-05-31 | St Louis → Columbus | 518 | navigator distracted, lost near Urbana IL — **the 09:52 fill is at Champaign, one metro with Urbana**, and it carries slashed-zero typo **L61**. Excess over direct I-70: **108 mi** vs his remembered ~100 |
| 2011-06-26 | Flagstaff → Holbrook | 100 | out **04:30**, in **06:45** — a 100-mi hop existing only to arrive early for his nephew; **70 mi of local driving before the next departure IS the park tour** |
| 2012-06-14 | Billings → Pocatello | 449 | **65.5 mph gross, the fastest day in the record** — fast because Montana has nowhere to stop |
| 2017-01-06 | Brookings → Paso Robles | 562 | racing to his mother, 104. **32 degF, the coldest start in the record**; Paso Robles fill **22:04 at 68,731**, arrival **22:10 at 68,732** — one mile, six minutes |

**The other four — Sydney NS → Edmundston (555, off an overnight ferry, zero odometer miles across the water), El Paso → San Antonio (531, racing for Florida), LSM → St George (492, a half-day Las Vegas visit inside a 31 mph day), Bellingham → Grants Pass (488, Nancy off the red-eye) — all check out and are in the log.**

### ★★★ FLORIDA, AND THE TAIL OF THE DRAGON — full write-up in the log; rules in Finding 036

**I concluded TwoRed never reached Florida. It did.** A few miles into the panhandle, *is this Florida?*, and out. **The log resolves to two events — buying fuel and ending a day — and he did neither there, on purpose.** Road/straight-line **1.23 against a trip median of 1.22**. Invisible.

**And I argued the same leg had no room for the Dragon — 407 logged against ~400 direct. The route was never the direct one.** The fills give the waypoints: **Trussville AL → Madisonville TN**, north through Chattanooga and Knoxville. **Madisonville → Cherokee is 104 mi against ~75 direct**: the Deals Gap route. **The Dragon is in the odometer.**

**Two rules. A record's RESOLUTION sets the floor on what its silences can mean. And a matching TOTAL does not mean a matching ROUTE.**

### ★ ONE DISCREPANCY, UNRESOLVED — the Bellingham departure

Kim remembers meeting Nancy *early afternoon*; the sheet starts the day at **06:49**. **The arithmetic favours the sheet** — 488 mi from 06:49 is already 36.2 mph gross, while an early-afternoon start needs ~67 with no stop. Likely 06:49 is the ferry docking recorded as the day's start. **Ask him.** Detail in `deferred.md`.

### ★★★ FIVE THINGS THE STORIES CHANGED, none of which the data could have volunteered

**1. Finding 033 got its best corroboration, from an unrelated direction.** The Champaign row is **L61**, one of three slashed-zero cost typos raised the day before. **The typo sits at the stop where he had just discovered he was 100 miles off course and late for dinner.** Kim gave the mechanism — *record quickly* under pressure — blind to this route.

**2. The gap between an arrival odometer and the next departure odometer is the day OFF the highway.** 70 miles at Holbrook is a park tour. **Readable across the whole record and nobody has read it.**

**3. Daily distance has a first-order term nobody modelled: WHERE THE BEDS ARE.** Lodging geography sets the length; scenery sets the pace.

**4. A ferry is a LOGISTICS MULTIPLIER, not a hole in the odometer.** It converts a night into progress and hands the next morning a loaded, fuelled car.

**5. ★★ A LONG ELAPSED TIME IS NOT A SLOW DAY.** LSM → St George read 31.6 mph and was a normal drive with a half-day Las Vegas visit inside it. **Gross speed silently conflates driving with living**, and both later measurements agree: Creamsicle's stop column puts the gap at **7.5 mph**, and the Dalton return shows it against the SAME road driven the day before. **Gross mph is a ceiling on driving speed, never a measure of it.**

## ★★★ THE FAVOURITE DRIVES (2026-08-19) — full write-up in the log

Kim's list, unprompted: the Rockies; the mountains down to the Oregon coast; **a morning through the West Virginia hills, villages fogged in and chimney smoke rising** — *I liked this so much, I drove it twice* (**settled: I-64 Charleston→Beckley, 2010 and 2016** — above); and the Dalton, *going where cars weren't intended*. Accounts verbatim in the log.

**★ The Dalton return is the slowest long day in the record: 298 mi in 13.2 h, 22.6 mph**, out at 07:52 into 38 degF, against 28.6 outbound the day before. **The 46-mile gap is now closed — Wiseman, above.**

**★★ A routing app can manufacture the geographic test's own signature.** *Memo to self: stay on the main roads.* Excess road miles over the straight line PLUS low economy from a rough surface is exactly what the test hunts. **It is not an error; it is a wrong turn a machine recommended** — measurable at 42 miles in the 2016 log. Third case where a high ratio wants a story rather than an errata entry.

## ★★★ THE FOURTH CROSSING LOG IS FOUND (2026-08-19) — full write-up in the log

Nine pages, **25 legs**, scanned the afternoon it was asked for. **The reconstruction HELD: all 29 paper rows balance the pump identity and 25 of 29 are identical to the corrected dataset. The LSM/Blythe/Winslow values derived from AMEX statements and pump receipts match the paper EXACTLY on gallons and cost** -- an independent source, arrived at afterwards, agreeing to the thousandth of a gallon.

**And there is no Phoenix fill**, settling documentarily a hypothesis already withdrawn on three statistical grounds. The four differences are mine: **L62/L63 I had written the AMEX MERCHANT NAME into the Brand field** (`Quick Check West`, `Hallum Store`) where the paper says **Valero** and **Conoco**; L64 a typo; L65 one thousandth of a gallon. **RULE: when a field is filled from a substitute source, record WHICH source -- a merchant string is not a brand.**

**The stuck day is recovered: 2016-05-27 Youngtown AZ -> Monument Valley UT, 362 mi against ~320 direct = 42 miles of detour**, 37.6 mph against the trip median of 41.4. **A new longest day: 2016-06-19 Richmond MO -> Denver, 640 mi, 58.6 mph gross** (previous best 562). **107 degF into St George on 6/21**, the hottest reading in the record. Full write-up in `logs/proj_Smart_Car_log.md`.

## ★★★ THE STRESSFUL MILES ARE INVISIBLE — AND THAT IS A DIFFERENT SILENCE FROM FINDING 036 (2026-08-19)

Kim's two near-misses (verbatim in the log): **a car-sized pothole in the Yukon with no warning flag** — *that would have been a TwoRed ending event* — and, entering New Brunswick, **a four-inch level change where the freeway met a bridge.** Then the claim that IS testable: *we were plagued by potholes. We often slowed to avoid damage... Those miles, which were mostly across the Canadian Plains, were very stressful.*

**Both instruments were pointed at it. Neither sees anything.** Canadian Plains median gross **44.5 mph** against US Plains **45.0** and a whole-record **40.5**; MPG residuals +0.56 (n=4) against a record SD of **4.74**. The three Plains legs run **44.5, 47.3, 43.1** — FASTER than his sixteen-year median. **The stretch he remembers as the most stressful of the crossing is, by every number we have, an unremarkable fast run.** The New Brunswick bridge leg is dead average too: 217 mi, 5.35 h, **40.6 mph**.

### ★★★ KIM'S CORRECTION INVERTS THE LOGIC — the data does not fail to corroborate him, it IS his mechanism

He revised his own words the moment he saw the table: *I should have said "abruptly slowed, then quickly speeded up". The problem was that I couldn't go slow as big vehicles kept moving at highway speeds. Hence the rear view mirror checks.*

I had treated *no speed effect* as the record failing his memory. **His account PREDICTS no speed effect.** He was not free to drive slowly — trucks closing behind him at highway speed — so the average had to stay up. **The high gross speed is not evidence against the stress; it is the mechanism OF it.**

**★★★ IT NAMES THE MISSING QUANTITY PRECISELY: WITHIN-LEG SPEED VARIANCE.** Brake for a hole, accelerate back to seventy, check the mirror, repeat. **A trip log samples the day TWICE — departure and arrival. Everything between is averaged away BY CONSTRUCTION.** So the sharper statement: **the log records MEANS and cannot record VARIANCE, and the cost lived entirely in the variance.**

**I did look**, since his correction points at economy rather than speed. Canadian 2014 residual **SD 4.87 (n=18)** vs US **4.73 (n=268)**, F-test **p = 0.79**. But those rows were converted from LITRES and CAD and **unit-normalising that sheet is still OPEN** — per-row conversion inflates spread by itself. **A non-result, not a null.**

### ★★★ WHY THIS IS NOT FINDING 036 — full write-up in the log

**036 was about events that generated NO observation.** These miles generated a FULL set — distance, time, fuel, temperature, both endpoints — and every one is normal. The record is not silent; it answers a different question at a resolution that cannot reach the answer. **★★★ BOTH LOGS MEASURE OUTPUT. NEITHER MEASURES COST TO THE DRIVER. Vigilance has no column.** A driver can buy an ordinary 44 mph day at an extraordinary price and the log records the 44. **So the stories are not colour around the data — they are the sole record of a dimension the data cannot reach.**

## ★★ TWO RELOCATIONS, AND THE LAST YEAR'S SHAPE (2026-08-19) — full write-up in the log

A page I had filed as a duplicate carried an annotation its twin did not show: **`Relocation  1141 miles`**, matching the 2016 fall-winter legs exactly (66,645 -> 67,786). **September 2016 was not a tour; it was the one-way relocation of TwoRed to Oregon** -- which is why the car was in Eugene when the January 2017 call came. **February 2017 is a SECOND relocation** (6 new legs), after which the car sits until 20 May. **The last year's shape: the car stops touring and starts commuting between two homes, then ships.**

**★ METHOD: two scans of the same page are not the same evidence.** A marginal annotation can be lost to cropping, threshold or the fold. **Diff a duplicate rather than discarding it** -- this one yielded a trip name, a verified total, and the frame for the final chapter.

## ★★★ THE END OF THE MAINLAND RECORD IS DOCUMENTED: 71,283 AT THE MATSON DOCK (2026-08-19)

Kim scanned `2017_TwoRed_last_mainland_fuel.pdf`. Its DAILY TRAVEL table is blank, and he explained why: *there is no travel log. We got on a plane and left TwoRed at the dock for shipping.* **On the BACK of the sheet, circled: `5/22/17  71,283  LV Seattle @ Matson`.**

**So the record does not end at 71,181. It ends at 71,283, in Seattle, at a shipping terminal.** The last mainland miles are **Toledo WA 71,181 (fuelled 10:09) -> Seattle 71,283 = 102 miles**, and Toledo to the Seattle waterfront is about 100 road miles. **Both odometer readings are documented; nothing is reconstructed.** Filed as `data/TwoRed_2017_LastMainlandMiles_trip_log.csv` with no arrival time, because none was ever written.

### ★★★ AND THIS CLOSES THE FIRST QUESTION THE PROJECT EVER ASKED

On 2026-08-12 the charter said **~75,000 miles**, the fuel log stopped at **71,181**, and the gap looked like missing data. Kim ruled the same day that the car went *about 20 miles short of 75,000*. With the terminus documented:

| | miles |
|---|---|
| mainland record, Julyary 2010 to 22 May 2017 | **71,283** |
| Kim's lifetime figure (~75,000 less 20) | ~74,980 |
| **implied Honolulu miles, after shipping** | **~3,697** |

**The ~3,700-mile gap was never missing data. It is the scope boundary, appearing one last time and now quantified at the terminus.** The log records long-distance driving; it stops when the long-distance driving stops. **The car crossed the Pacific and kept going for another 3,700 miles that this record is not about, by design.**

### ★★ TWO ANOMALIES AT THE END THAT ARE NOT ECONOMY READINGS

The final two fills read **52.4 and 93.0 MPG** -- the second the highest number in the entire record. Both are small: **4.333 and 2.496 gallons against a lifetime mean of 6.24** (72% of tank). **A vehicle handed to Matson must arrive with a low tank.** These are not measurements of the car; **they are a tank being managed DOWN for shipping**, and the implied MPG is an artifact of dividing a normal distance by a deliberately small fill.

**★ General rule for the write-up: the first and last rows of any record are the least trustworthy, because they are the ones taken while the measuring itself was being started or stopped.** The first fill in this log carries a slashed-zero cost error (L59); the last two are shipping artifacts. **Trim the ends before quoting an extreme.**


## ★★★ FOUR ANSWERS FROM KIM (2026-08-19) — full working in the log

**1. The 46 Dalton miles are 32 + 14, and only the 32 is the Dalton.** Coldfoot → Wiseman and back, the museum, the season's first snow. **TwoRed fuelled at Yukon River Crossing in BOTH directions, and that fix splits the leg:** north of the river 115 out / **147 back (+32)**; south of it 137 / **151 (+14)**. Coldfoot is Dalton mile 175, the Wiseman spur ~16 road miles on — **out and back is 32, to the mile.** *A matching TOTAL does not mean a matching ROUTE; a SPLIT total localises the discrepancy.*

**★★ The same leg is the extreme case on two other instruments his story now explains.** It is the **slowest leg of 200+ miles in sixteen years — 298 mi in 13.18 h, 22.6 mph** — against **28.6 over the identical road the day before**: the road held constant, so the difference IS the museum and the turnaround. **FIVE THINGS #5 with a control.** And it starts at **38 degF**, tied second-coldest of 136 timed legs, after Coldfoot read **64 degF at 18:26 the previous evening** — a 26-degree overnight drop at the farthest north point the car ever reached, on the morning the snow began.

**2. The Penultimate State was never Florida.** Kim's ruling: 49 mainland states leaves **Hawaii as the Ultimate State**, so the penultimate is the 49th reached; Florida mattered only as the last unvisited SE state. **The record's last new states all fall on the 2014 trip he named Penultimate State: Vermont 5/18, New Hampshire 5/20, Maine 5/22 at Lubec — the easternmost point of the continental US.** He remembers Vermont; the record's last is Maine. **Unresolved; his is the better instrument.** Vermont carries a mark the others lack — the trip stops dead there, **two nights and 59 odometer miles for a drive that is 18 miles direct.**

**★★★ 3. DELAWARE IS INVISIBLE AS A LABEL AND PROVABLE AS A ROW.** Four mainland states never appear: Florida, Delaware, Rhode Island, South Dakota. Florida is Finding 036; **Delaware is the same silence, and geography breaks it.** 2014-05-16, the Colonial Heights VA fill → Bellmawr NJ reads **264 odometer miles** (great-circle 219, ratio 1.21). Every route near that length crosses Delaware; **the only Delaware-free road is ~305 miles, 40 more than the odometer permits.** The record holds Delaware as a DISTANCE, not a name — **key to a ROW, never a LABEL.**

**Charter claim settled: provinces are exactly ten, all present.** States: **45 documented, 46 with Delaware, plus Florida on testimony; Rhode Island and South Dakota have neither.**

**★★★ 4. WEST VIRGINIA IS SETTLED: I-64, CHARLESTON TO BECKLEY — AND HE DROVE IT EXACTLY TWICE.** Confirmed by Kim on Street View, 2026-08-19. **The record puts TwoRed on that stretch on exactly two days in sixteen years, 2010-10-01 and 2016-06-12 — the number he remembered.**

**Both times the behaviour is identical six years apart: arrive Huntington late, sleep, drive the hills in the morning.** 2010: **Barboursville** (a Huntington suburb) closes a 275-mile day at odometer **3,310**, the car ten weeks old; next morning 197 miles to Hillsville VA — I-64 east through Charleston to Beckley, then **I-77 south** (197 against a 142-mile great circle). 2016: in at **14:54**, out at **08:58**, 359 miles to Richmond at 49.9 mph, the **Lewisburg** fill splitting it **155 + 204** against I-64's markers of ~161 and ~205.

**The pair he named was the wrong pair, and that is the interesting part.** The second meeting was **Pine Mountain KY** (6/4–6/9), reached from the west with no WV on the way in — **the WV miles are entirely post-meeting, and cost ~370 extra: Atlanta → Richmond is ~525 direct, he drove 895.** But the FIRST time was **2010, not Frostburg 2012** — Frostburg is I-68, pinned by two Morgantown fills, and I-68 never touches this road. **The memory kept the highway and the count and swapped an occasion.** Five WV fills, three highways; neither 2010 trip has a story attached.

## ★★★ CREAMSICLE IS INGESTED — THE SECOND SPINE EXISTS (2026-08-19)

Kim exported the Google-native files into the project. `creamsicle_ingest.R` reads the workbook and emits `Creamsicle_fuel_clean.csv` (**173 rows**) and `Creamsicle_trip_clean.csv` (**86 legs**). Same architecture as TwoRed: **the source is never edited**, the interleaved total/average rows are skipped programmatically, and **the skip counts are reported** (196 -> 173, 119 -> 86, 10 -> 6) per Finding 032.

**It arrived clean.** Odometer **30,290 -> 58,903, strictly increasing, no duplicates.** Pump identity: **143 of 170 US rows balance to under half a cent; exactly THREE fail by 2c or more.** My recomputed MPG matches Kim's own column to **0.005**. The three BC rows carry litres and CAD alongside gallons and dollars -- **the unit problem TwoRed still has is already solved here.**

**The three errata, and all three resolve exactly** (`Creamsicle_log_errata.csv`): **C01 Oxnard** $/gal 4.399 -> 3.999 -- **the cell is IDENTICAL to the Gallons cell**, a copy into the wrong column, caught by the contiguity instrument; **C02 Miranda** 6.095 -> 6.059, a 59/95 transposition; **C03 Hays** 3.499 -> 3.449. **Three errors in 173 rows.**

### ★★★ AND IT MEASURES THE THING TWORED CANNOT

Creamsicle's trip log has a **`Stop`** column and a **`Comment`** column. 54 legs carry a stop; 35 carry a reason. **So the gap between driving and living can be measured directly, for the first time in this project:**

| across 84 timed legs | |
|---|---|
| median GROSS mph (elapsed) | **43.5** |
| median NET mph (driving only) | **51.0** |
| **the gap** | **7.5 mph** |

**The clearest single case: 2024-10-20, WI Dells -> Madison. 50.3 miles, 5 hours elapsed, 4.5 of them stopped. Gross 10.1 mph. Comment: `Cranes`.** Gross speed called it the slowest leg in the file; he was watching sandhill cranes. The other big gaps are `C. Caverns NP`, `White Sands`, `Desert Musum`, `Monterey Bay Aquarium, Pelican Photos`, and twice simply `Tom`.

**★★★ THIS CALIBRATES THE TWORED NUMBERS.** I have been reporting TwoRed gross speeds with the standing caveat that they conflate driving with living and that nothing could size the bias. **Creamsicle sizes it: about 7.5 mph at the median.** That is a CALIBRATION, not a correction -- different car, different years, different trips -- but it is the first empirical handle on how much TwoRed's 40.5 understates his driving. **Report TwoRed gross speeds as a floor, and cite Creamsicle for the scale of the gap.**

### The two cars, side by side

| | TwoRed 2010-2017 | Creamsicle 2021-2024 |
|---|---|---|
| fuel rows | 286 | 172 |
| odometer span | 4 - 71,181 | 30,290 - 58,903 |
| **median MPG** | **39.12** | **40.59** |
| median leg | 251 mi | 166 mi |
| **cost per mile** | **$0.0939** | **$0.1183** |
| trip legs | 139 | 86 |
| median gross mph | 40.5 | 43.5 |
| median NET mph | *no Stop column* | **51.0** |

**★ The cost-per-mile difference is 26%, and almost none of it is the car** -- 39.1 against 40.6 MPG. **It is the price of fuel between 2010-2017 and 2021-2024.** That comparison is one of the strongest things the two-car structure can deliver, and it needs no modelling at all.

**★ And the median leg is 85 miles shorter.** Creamsicle stops more often. Whether that is the driver at 84 rather than 78, a different touring style, or simply more scenery per mile on those routes is **an open question, not a finding.**

## Intended analysis

_Kim, 2026-08-12._ Statistics with graphics, on:

- **Fuel costs** — per fill, per mile, over time and across the price swings of 2010-2017.
- **Daily driving distances** — what a day in a Smart actually looks like, against the
  urban-commuter assumption the whole document exists to refute.
- **Average speeds** — the Fourth Crossing file already carries time-zone-corrected
  `activity_time` and `miles_per_hour`, so this is the readiest analysis in the set.

**★ THE PHOTO LAYER EXISTS AND IT JOINS (2026-08-16).** The Creamsicle photo set in `images/Creamsicle/`: **38 files, 35 with GPS, 37 with timestamps, 2021-09-23 to 2024-10-22** — the full ownership and two days past it.

**The join is clean because `DateTimeOriginal` is LOCAL time with `OffsetTimeOriginal` carrying the zone, and the logs record local clock times too.** So photos join to fuel stops and legs on date + local time with **no timezone reconstruction** — the very correction the Fourth Crossing sheet had to build a column for. **It validates on the first record:** earliest photo **2021-09-23 11:42**, first fill **11:45 at Nixa MO** — the car at the dealership, minutes before its first tank.

**Coverage: 8 of 9 trips**, plus a staging shot at Torrance two days before T9 departs. **T2 (LA→Madison, Oct 2021) is the blank** — the solo run Kim describes as pushing his daily limits. **NOT an absence claim.**

**★★ A FOURTH ANALYSIS (2026-08-19): THE PARKING CONSTELLATION.** Where the car SLEEPS is a second geography the record has always held — **86% of elapsed days are dormancy; 34 of the 35 long spells are in CA, AZ or OR.** Map it against the driving constellation.

### Two narrative set-pieces moved to the log 2026-08-18

**THE YUKON RIVER CAMP STORY** and **THE ALPINE STORY** live verbatim in the log under ARCHIVE, with the superseded scan-coverage table. Both are for the Expeditions chapter; neither is working state.

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
- `data/TwoRed_fuel_June_2014.xlsx` — 4 sheets: Gas Log (293 fill-ups, 2010-2017), Locations (212), Trip Log (7), Canada2014 (24, **metric — normalisation still OPEN**). The foundational dataset.
- `data/2016_Fourth_Crossing_Analysis.xlsx` — 35 rows, time-zone-corrected activity time. The cleanest asset.
- **`data/Fuel_and_Trip_Logs/*.pdf` — 22 scans, 2010-2017, Kim's paper field sheets.** Top half fuel, bottom half trip; the fuel halves were typed up years ago, **most trip halves never were.** Primary source behind all 65 errata rows. **Not in the mirror — see Finding 038.**
- **13 trip-log CSVs, 139 legs** (132 timed), transcribed from those scans; each carries time, city and temperature at BOTH ends, both odometers, written distance, odometer delta, timezone shift, elapsed hours and gross mph, plus per-row notes on every uncertain reading.
- `data/TwoRed_fuel_clean.csv` (294), `TwoRed_log_errata.csv` (65), `TwoRed_fuel_timetemp.csv` (134), `TwoRed_city_timezones.csv` (121 cities).
- **Creamsicle:** `Creamsicle_fuel_clean.csv` (173), `Creamsicle_trip_clean.csv` (86), `Creamsicle_log_errata.csv` (3); sources `2024_Creamsicle_*.xlsx` + `.md`; built by `creamsicle_ingest.R`.
- `source/Smart_Car_master_dictionary.pdf` — expedition names, dates, geographic targets.
- `source/Smart_Car.docx` — 10.3 MB. Largest section is the Arctic Circle Challenge, already published; **a quarry, not a draft.** `source/Smart_Car_2016.pptx` — 2016 presentation. `source/charter_2026-05-08.md` — the original charter, kept verbatim, superseded by this file on scope and Chapter 5.
- `images/Creamsicle/` — 37 geotagged trip photos plus `Creamsicle_profile.jpg` (was `two_smarts.jpg`, ruled by Kim 2026-08-16). **Backstop for the deleted 439 KB `creamsicle.jpg`: a copy survives at `kimbridges-stories\underway\Smart_car\` — do not delete that folder without checking.**

## Related Projects
- `proj_Trip_Log.md` — the travel-photo + trip workflow; upstream.
- `proj_timelinesr.md` — timeline package, for the sixteen-year spine.
- `proj_Photo_Locations.md` — geotagging workflow.
- `proj_Plainmaps.md` — R mapping.
- `proj_kimbridges_stories.md` — holds the published Arctic Circle Challenge.

## ★★★ CHAPTER ARCHITECTURE — SOLVED. KIM'S THREE LAYERS (2026-08-19) — full development in the log

**His words, preliminary and recorded as given:** *The Smart Cars are the "hook" for the story. An overriding theme. The two aspects of performance, car and human, is the fabric for the story. The data become the real issue. The complexities and difficulties in the process of data collection, transcription, and cleaning on one end. At the other end, the opportunities for interesting, and perhaps unique, ways to analyze and display the results. This makes, in my mind, three layers. People see the unusual cars (and have preconceived notions). The drives make interesting stories. The data give satisfying answers to questions, even those you didn't know you had.*

**This closes the weak point named on 2026-08-16, and it does what TWO LOGS, TWO SUBJECTS could not.** That frame said which instrument answers which question. **It never said what ORDER to put things in, or why a reader keeps going.** Three layers answers both, and the two frames compose rather than compete: **the car/human fabric runs THROUGH all three layers; it is the weave, not a chapter.**

**★ The layers are three DEPTHS of one material, not three sections — and each one's payoff is bought by the one above it.** The preconception (*that tiny car can't have done that*) is what makes the drives surprising. The drives are what make a reader want the numbers. **The numbers then answer questions the stories raised** — which is why *questions you didn't know you had* is the load-bearing phrase, not a flourish.

**★★ AND THIS SESSION IS THE PROOF OF CONCEPT.** Nobody asked what a day off the highway looks like in an odometer — **70 miles at Holbrook** is a park tour with a nephew. Nobody asked how much of a gross speed is living rather than driving — **Creamsicle says 7.5 mph**. Nobody asked whether a record can contain a state it never names — **Delaware, by 264 miles against a 305-mile alternative.** Every one of those is a layer-3 answer to a layer-2 question that was never posed.

**★★ THE DATA-DIFFICULTY END IS A THIRD NARRATIVE, NOT A METHODS APPENDIX.** Kim named it as one END of the data layer and it has the same shape as the driving stories — a problem, a mechanism, a resolution. **The slashed zero that predicts the DIRECTION of an error. The crossbar that was a scanning artifact and not a correction. The pump identity. The intermediate fill that places a route a total cannot.** These carry suspense; they should be written, not buried.

**★★★ AND THE ARCHITECTURE WAS VALIDATED THE DAY IT WAS PROPOSED.** Kim told the St Louis car-wash story to apologise for not remembering Summersville. **It turned out to be the sole explanation of the only outlier in a distribution nobody had computed.** Asking *where does this car sleep?* — **TwoRed's log spans 2,495 days and 2,147 of them (86%) fall inside a dormancy of two weeks or more; there are 35 such spells and 34 are in California, Arizona or Oregon.** The single exception east of the Rockies is **Altamont IL, 2010-10-11 to 11-05, 25 days, 227 miles between two fills seventeen miles apart** — a car driven into St Louis, left three and a half weeks, and collected. **Layer 2 generated the question; layer 3 answered it; neither could alone.**

**★ EDITORIAL RULE THAT FALLS OUT OF IT, and it is testable today:** an analysis earns its place in layer 3 only if it answers a question layer 2 raised. **Results with no story to attach to are not failures — they belong to the DIFFICULTY strand instead.** The retired temperature effect, the wide-tire interval that straddles zero, and the Canadian non-result are exactly this: **the data being honest about what it cannot say**, which is a story about the record, not about a drive.

## Next Steps
1. **★ THE CHAPTER ARCHITECTURE.** The only thing blocking the writing. Kim's TWO LOGS, TWO SUBJECTS frame is the candidate, now bounded (achieved vs cost).
2. **KIM:** answer the West Virginia road question (I-68 or I-64), and rule on Vermont vs Maine as the Penultimate State.
3. **KIM, unscheduled:** update the TwoRed fuel logs for the last miles to ~75,000. **Check `TwoRed_fuel` (the live Sheet) first** — a different and richer record than the exported `.xlsx`, with ~141 more fill temperatures.
4. **KIM:** rule on what the backup should carry (Finding 038, `deferred.md`) — and whatever exists for Bordeaux, deliberately outside the statistics.
5. **OPEN:** Creamsicle trip legs run to **2024-10-20** but fills stop at **2024-07-02**. Trip 9 may have fuel records elsewhere or none. **Not an absence claim** — the read may have been truncated.
6. Then: `Expedition_ID` on every fill-up across BOTH documented cars (read `Fuel_Analysis.Rmd` first); the geocoded constellation map (**the Jul-2024 Creamsicle update already carries lat/long**); and Kim's three analyses — fuel costs, daily distances, average speeds.

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
