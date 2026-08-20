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

**★★★ THE TWORED RECORD IS CLOSED AT BOTH ENDS AND READY TO WRITE FROM (2026-08-19).**

**Fuel spine: 294 rows, odometer 4 -> 71,283, 2010-07-23 to 2017-05-22, audited.** 277 of 294 balance the pump identity; the 13 that fail carry a documented basis. **65 errata**, 4 literally open. `twored_ingest.R` emits `data/TwoRed_fuel_clean.csv` with provenance per row; the source workbook is never edited.

**Human spine: 139 legs across 12 trips** (132 timed), **41,163 miles = 58% of lifetime**, 174 of 294 fuel rows sitting under a leg (59%), **134 fills carrying a time and temperature (46%)**. Time zones are computed from a 117-city IANA table, not stored. **Ten of Kim's own accounts are collected verbatim and every one has been cross-checked against the log.**

**Ready to write:** economy, cost per mile and degradation; the shape of a driving day; gross speed by road type (stating the means-not-variance limit); the stories. **Not ready:** the temperature effect is **retired** (more data attenuated it); **Creamsicle has never been ingested** -- a whole car, and the largest remaining gap; Canadian economy blocked on litres/CAD normalisation; route work partial at a 78% gazetteer join.

**The one thing actually blocking a start is the CHAPTER ARCHITECTURE**, named as the weak point on 2026-08-16 and still open. Kim's TWO LOGS, TWO SUBJECTS frame is the candidate. **Creamsicle's data was found on 2026-08-16 and remains un-ingested** -- see the log for that story, and `deferred.md` for the task.

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

## ★★★ KIM'S FRAME: TWO LOGS, TWO SUBJECTS (2026-08-18) — full write-up in the log

His words: *the fuel log is more about the CAR'S performance, while the trip log shows the HUMAN performance -- how far and fast can you expect to drive in a day, something I had no idea about until I started doing these drives.*

**This is the strongest organising idea the project has produced and it is the top frame for the chapter architecture.** Four consequences, argued in full in the log:

- **Neither log substitutes for the other.** Fuel records STOPS, trip records LEGS. The odometer is the JOIN, not the topic.
- **It assigns instruments to questions.** Economy, degradation, cost/mile, the wide-tire question — car. Daily range, departure discipline, gross speed — human. Mixing them yields a meaningless average.
- **★ It supplies the missing NARRATIVE thesis.** Kim did not know the answer before he drove it, so the human half is a finding he made about himself by doing the thing. The 3-bar refuelling rule adopted at Deming in 2010 is exactly that: a behaviour changed by a near-miss and visible in the numbers after.
- **It explains the collection history rather than apologising for it.** Trip logging started LATER because **the car's question was the obvious one to ask first; the human question is the one the driving taught him to ask.**

**Now bounded (2026-08-19):** the trip log records what the human ACHIEVED, in MEANS not variance; the stories are the only record of what it COST. And Creamsicle's net-vs-gross gap (below) is the first measurement of the driving-vs-living conflation the frame implies.

## ★★ THE SCAN SWEEP, 2026-08-18 — full write-up in the log

All 15 scans read. The four results that must not be lost:

**1. The wheel change is DATED** -- `NEW WHEELS @ 13510 miles`, Kim's margin, 179 mi before the 2011 departure. **The estimate FLIPS SIGN with specification (+3.6% to -1.8%); that is the finding, not any one number.** The CONDITIONAL in `deferred.md` governs.

**2. ✗ THE TEMPERATURE EFFECT IS RETIRED (2026-08-19).** At n=94 it read **-0.068 MPG/degF, p=0.045**; the Fourth Crossing's 31 fill-stamped temperatures took it to n=125, where it reads **-0.050, p=0.099** and **p=0.17** controlling leg length and era. The coefficient moved TOWARD zero and the significance evaporated — it was noise. The raw hot/cold gap (37.97 vs 39.61) does not survive a control for leg length: **hot fills are on shorter legs.** Write no thermal claim. **Note what this demonstrates: the record is now good enough to RETIRE a result, not just produce one.**

**3. The slashed zero produced three more corrections and the control held.** Over the 44 rows failing the pump identity: **permitted 8->0 fixes 4; forbidden 0->8 fixes 1** (already flagged); **six controls fix 0.**

**4. Gross speed separates by ROAD, across 138 legs in 12 trips.** 2011 interstate **47.6** | Frostburg 44.4 | Fourth Crossing 41.4 | Penultimate State 40.3 | Dalton **31.7** | **2017 February 31.1** | 2016 US-101 coastal **28.3**. Same car throughout. **Extreme case: the February 2017 run, 19.6/21.1/21.2 mph on the Highway 1 legs against 41 inland — the road changes the day by a factor of two.** But gross speed is a MEAN; see THE STRESSFUL MILES above.

## ★★★ THE LONG DAYS — ALL EIGHT COLLECTED, AND EVERY ONE CHECKS OUT (2026-08-19)

**Kim's accounts are verbatim in `logs/proj_Smart_Car_log.md` under COLLECTED STORIES.** They are chapter source material; what follows is only what the log CONFIRMED and what it changed.

| day | leg | mi | his reason | what the data independently shows |
|---|---|---|---|---|
| 2012-05-31 | St Louis -> Columbus | 518 | navigator distracted; lost near Urbana IL | **the 09:52 fill is at Champaign IL -- one metro with Urbana.** Excess over direct I-70: **108 mi** vs his remembered ~100 |
| 2011-06-26 | Flagstaff -> Holbrook | 100 | meeting his nephew, a park naturalist | out **04:30**, in **06:45** -- a 100-mi hop existing only to arrive early; **70 mi of local driving before the next departure IS the tour** |
| 2012-06-14 | Billings -> Pocatello | 449 | dull country, nowhere to stay, good freeway | **65.5 mph gross, the fastest day in the record**; sole stop **2.695 gal at Livingston**, already flagged `partial_fill` |
| 2014-05-29 | Sydney NS -> Edmundston | 555 | off the overnight ferry, car already packed | previous leg ends Port aux Basques **46,625**, this one starts Sydney **46,625** -- zero odometer miles; last fill before boarding was a **full 7.12 gal** |
| 2017-01-06 | Brookings -> Paso Robles | 562 | racing to his mother, 104; heavy rain at Santa Rosa | **32 degF at Brookings, the coldest start in 107 legs**; Santa Rosa fill **15:59** is the decision point; Paso Robles fill **22:04 at 68,731**, arrival **22:10 at 68,732** -- one mile, six minutes |
| 2012-05-24 | LSM -> St George | 492 | a long stop with friends in Las Vegas | Las Vegas fill at **18:08**: 375 mi in 12.1 h (**31 mph -- the visit is inside that**), then 117 mi in 2.5 h (**47 mph**) once moving |
| 2014-05-05 | El Paso -> San Antonio | 531 | racing for Florida, the last mainland state, before a meeting in Cherokee NC | **47.6 mph** over featureless road. **He reached Florida** -- a few minutes in the panhandle, invisible to a log that resolves to fill-ups and overnights (below) |
| 2013-08-31 | Bellingham -> Grants Pass | 488 | Nancy flew the red-eye and met him off the Alaska ferry with the reservations already made | the leg before it is **Whittier 38,284 -> Bellingham 38,285, one odometer mile**; the next day is **Grants Pass -> San Francisco, 393 mi**, so she could fly home. Two big days, exactly as told |

### ★★★ FLORIDA, AND THE TAIL OF THE DRAGON — full write-up in the log; the rules in Finding 036

**I concluded from the record that TwoRed never reached Florida. It did.** Kim drove a few miles into the panhandle, asked a passing driver *is this Florida?*, and left. **The log resolves to two events -- buying fuel and ending a day -- and he did neither there, on purpose. The visit is UNRECORDABLE.** The dip hangs off New Orleans -> Atmore (Atmore is ~12 mi from the line); road/straight-line **1.23 against a trip median of 1.22**. Invisible.

**And I argued the same leg had no room for the Tail of the Dragon -- 407 logged against ~400 direct. The route was never the direct one.** The intermediate fills give the waypoints: **Trussville AL (Birmingham) -> Madisonville, east Tennessee** -- north through Chattanooga and Knoxville, not east through Atlanta. **Madisonville -> Cherokee is 104 mi against ~75 direct**: the Deals Gap route. **The Dragon is in the odometer.**

**Two rules out of it. A record's RESOLUTION sets the floor on what its silences can mean. And a matching TOTAL does not mean a matching ROUTE -- the intermediate stops are the only waypoints this record has.**

### ★ ONE DISCREPANCY, UNRESOLVED — the Bellingham departure

Kim remembers meeting Nancy *early afternoon*; the sheet starts the day at **06:49**. **The arithmetic favours the sheet** -- 488 mi from 06:49 is 36.2 mph gross, already slow for I-5 and slower than the next day's 42.8 on the same road, while an early-afternoon start needs ~67 mph gross with no stop. Likely 06:49 is the ferry docking recorded as the start of the day, and the reunion is the missing hours. **A hypothesis about a memory -- ask him.** Detail and the open question in `deferred.md`.

### ★★★ FIVE THINGS THE STORIES CHANGED, none of which the data could have volunteered

**1. Finding 033 got its best corroboration, from an unrelated direction.** The Champaign row is **L61**, one of three slashed-zero cost typos raised the day before. **The typo sits at the stop where he had just discovered he was 100 miles off course and late for dinner.** Kim gave the mechanism on 2026-08-17 -- *record quickly* under pressure -- and here the pressure is documented, at a named stop, by a route that had nothing to do with the audit.

**2. The gap between an arrival odometer and the next departure odometer is not noise -- it is the day off the highway.** 70 miles at Holbrook is a park tour. This is a readable quantity across the whole record and nobody has read it.

**3. Daily distance has a first-order term nobody modelled: WHERE THE BEDS ARE.** The fastest day in sixteen years is fast because Montana has nowhere to stop. Lodging geography sets the length; scenery sets the pace.

**4. A ferry is a LOGISTICS MULTIPLIER, not a hole in the odometer.** It converts a night into progress and hands the next morning a loaded, fuelled car. Read the five ferries as ENABLING the long days after them.

**5. ★★ A LONG ELAPSED TIME IS NOT A SLOW DAY.** LSM -> St George read 31.6 mph and looked like a slog; it was a normal drive with a half-day visit inside it. **Gross speed silently conflates driving with living.** Kim's own note: *this was before I was recording why I took time off during a drive* -- so the STOP column that Creamsicle has is exactly the instrument that would separate them. **Until then, gross mph is a ceiling on driving speed, never a measure of it.**

### ★★ AND CHASING #5 FOUND A BUG IN 16 OF 107 LEGS

Nevada is Pacific and Utah is Mountain, and `tz_shift_hr` was 0 on every leg transcribed after the 2011 file. **Full write-up: Finding 035.** Fixed as a derived layer -- `data/TwoRed_city_timezones.csv` (97 cities -> IANA zones) plus computation in `trip_logs_read.R`, so DST, Arizona and Saskatchewan declining to observe it, Yukon before 2020 and Newfoundland's half hour all fall out for free. **16 legs corrected, up to 6 mph each; trip medians moved 0 to +0.9 and the road ordering is unchanged (pooled 39.7 -> 40.3); Billings -> Pocatello untouched at 65.5, so the fastest day is real.**

**★ Kim's stories have now corrected the analysis four times in two days** -- the road/straight-line audit rule, the time zones, Florida, and the route inference on the Dragon day. **The human spine is not decoration on the analysis. It is an instrument, and so far it is the more accurate one.**

## ★★★ THE FAVOURITE DRIVES (2026-08-19) — full write-up in the log

Kim's list, unprompted: the Rockies; the mountains down to the Oregon coast; **a morning through the West Virginia hills, villages fogged in and chimney smoke rising** -- *I liked this so much, I drove it twice*; and the Dalton, *going where cars weren't intended*. **Accounts verbatim in `logs/proj_Smart_Car_log.md`.** What survives here:

**★ The Dalton return is the slowest long day in the record: 298 mi in 13.2 h, 22.6 mph**, out at 07:52 into 38 degF. Outbound the day before was 28.6. **Gravel is worth six miles an hour.**

**★★★ AND 46 MILES ON THAT ROAD ARE STILL UNEXPLAINED.** Ester -> Coldfoot is **252** odometer miles; Coldfoot -> Ester the next day is **298**. Same road. His drama -- sliding forward on gravel down a very steep section, wondering whether they could climb back out -- belongs NORTH of Coldfoot, toward Atigun Pass. **23 miles up and back is 46. ASK HIM.**

**★★ A routing app can manufacture the geographic test's own signature.** *Memo to self: stay on the main roads.* Excess road miles over the straight line PLUS low economy from rough surface is exactly what the test hunts. **It is not an error; it is a wrong turn a machine recommended.** Third case where a high ratio wants a story rather than an errata entry -- and the 2016 log has now made this one measurable at 42 miles.

## ★★★ THE FOURTH CROSSING LOG IS FOUND (2026-08-19) — full write-up in the log

Nine pages, **25 legs**, scanned the afternoon it was asked for. **The reconstruction HELD: all 29 paper rows balance the pump identity and 25 of 29 are identical to the corrected dataset. The LSM/Blythe/Winslow values derived from AMEX statements and pump receipts match the paper EXACTLY on gallons and cost** -- an independent source, arrived at afterwards, agreeing to the thousandth of a gallon.

**And there is no Phoenix fill**, settling documentarily a hypothesis already withdrawn on three statistical grounds. The four differences are mine: **L62/L63 I had written the AMEX MERCHANT NAME into the Brand field** (`Quick Check West`, `Hallum Store`) where the paper says **Valero** and **Conoco**; L64 a typo; L65 one thousandth of a gallon. **RULE: when a field is filled from a substitute source, record WHICH source -- a merchant string is not a brand.**

**The stuck day is recovered: 2016-05-27 Youngtown AZ -> Monument Valley UT, 362 mi against ~320 direct = 42 miles of detour**, 37.6 mph against the trip median of 41.4. **A new longest day: 2016-06-19 Richmond MO -> Denver, 640 mi, 58.6 mph gross** (previous best 562). **107 degF into St George on 6/21**, the hottest reading in the record. Full write-up in `logs/proj_Smart_Car_log.md`.

## ★★★ THE STRESSFUL MILES ARE INVISIBLE — AND THAT IS A DIFFERENT SILENCE FROM FINDING 036 (2026-08-19)

Kim's two near-misses (verbatim in the log): **a car-sized pothole in the Yukon with no warning flag** -- *that would have been a TwoRed ending event* -- and, entering New Brunswick, **a four-inch level change where the freeway met a bridge**. *Wham! I wondered if the two front wheels had been seriously damaged.* Then the claim that IS testable: *we were plagued by potholes. We often slowed to avoid damage. This meant also looking in the rear view mirror to make sure we wouldn't be hit from the rear. Those miles, which were mostly across the Canadian Plains, were very stressful.*

**Both instruments were pointed at it. Neither sees anything.**

| | Canadian Plains | US Plains | whole record |
|---|---|---|---|
| median gross mph | **44.5** | **45.0** | 40.5 |
| median MPG residual vs the leg-length model | +0.56 (n=4) | +1.39 (n=21) | 0 (SD **4.74**) |

The three Plains legs -- Thunder Bay -> Winnipeg -> Regina -> Lethbridge -- run **44.5, 47.3, 43.1 mph**, which is FASTER than his sixteen-year median, and their economy sits four-fifths of a standard deviation inside the noise. **The stretch he remembers as the most stressful of the whole crossing is, by every number we have, an unremarkable fast run.** And the two near-misses left no trace at all: the New Brunswick bridge is 2014-05-23 Lubec ME -> Moncton NB, **217 mi, 5.35 h, 40.6 mph** -- dead average.

### ★★★ KIM'S CORRECTION INVERTS THE LOGIC — the data does not fail to corroborate him, it IS his mechanism

He revised his own words the moment he saw the table: *I should have said "abruptly slowed, then quickly speeded up". The problem was that I couldn't go slow as big vehicles kept moving at highway speeds. Hence the rear view mirror checks.*

I had treated *no speed effect* as the record failing his memory. **His account PREDICTS no speed effect.** He was not free to drive slowly — trucks closing behind him at highway speed — so the average had to stay up. **The high gross speed is not evidence against the stress; it is the mechanism OF it.**

**★★★ IT NAMES THE MISSING QUANTITY PRECISELY: WITHIN-LEG SPEED VARIANCE.** Brake for a hole, accelerate back to seventy, check the mirror, repeat. **A trip log samples the day TWICE — departure and arrival. Everything between is averaged away BY CONSTRUCTION.** So the sharper statement: **the log records MEANS and cannot record VARIANCE, and the cost lived entirely in the variance.**

**I did look**, since his correction points at economy rather than speed. Canadian 2014 residual **SD 4.87 (n=18)** vs US **4.73 (n=268)**, F-test **p = 0.79**. But those rows were converted from LITRES and CAD and **unit-normalising that sheet is still OPEN** — per-row conversion inflates spread by itself. **A non-result, not a null.**

### ★★★ WHY THIS IS NOT FINDING 036 — full write-up in the log

**036 was about events that generated NO observation.** These miles generated a FULL set — distance, time, fuel, temperature, both endpoints — and every one is normal. The record is not silent; it is answering a different question at a resolution that cannot reach the answer.

**★★★ BOTH LOGS MEASURE OUTPUT. NEITHER MEASURES COST TO THE DRIVER. Vigilance has no column.** A driver can buy an ordinary 44 mph day at an extraordinary price and the log records the 44. **Consequence for the document:** the stories are not colour around the data — they are the sole record of an entire dimension the data cannot reach.

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

### Two narrative set-pieces moved to the log 2026-08-18

**THE YUKON RIVER CAMP STORY** and **THE ALPINE STORY** now live verbatim in `logs/proj_Smart_Car_log.md` under ARCHIVE, together with the superseded scan-coverage table. Both are for the Expeditions chapter and neither is working state. Moved to hold the 45 KB budget.

## What the data ACTUALLY contains -- moved to the log 2026-08-18

The 2026-08-12 intake audit (charter claims vs what the files hold: 293 fill-ups not "nearly 300", range to 2017-05-22 not June 2014, 52 State values not "49 states and 10 provinces") is verbatim in `logs/proj_Smart_Car_log.md`. Its conclusions are all carried forward above or in `deferred.md`.

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
- `data/leased_smart.txt` — one line. **Superseded as car #2's record by the `TwoFer Gas Log` Sheet.**
- **`data/2011_TwoRed_travel_and_fuel_log_June.pdf` — NEW 2026-08-17.** Kim's scanned field sheets,
  4 pages, 380 KB. Top half fuel log, bottom half trip log; the fuel half was typed up years ago,
  **the trip half never was.** This is the 2011 St. Louis Trip.
- **`data/TwoRed_2011_StLouis_trip_log.csv` — NEW 2026-08-17, transcribed from the scans.** 15 legs,
  2011-06-24 to 07-19, Lake San Marcos -> St Louis -> Lake San Marcos. Carries start/end time, city and
  **temperature at BOTH ends**, odometer at both ends, the written distance, the odometer delta, the
  timezone shift, elapsed hours and **GROSS** mph, plus per-row notes on every uncertain reading.
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

## ★ CHAPTER ARCHITECTURE — the weakest part, still open (named 2026-08-16)

The one-car charter's chapter list is verbatim in `logs/proj_Smart_Car_log.md`, superseded. **The candidate replacement is Kim's TWO LOGS, TWO SUBJECTS frame above** -- now with a boundary attached: the trip log measures what the human ACHIEVED, the log records MEANS and not VARIANCE, and **the stories are the only record of what the driving COST.** Redesign is an open task in `deferred.md`.

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

The dated log for this project lives in `logs/proj_Smart_Car_log.md`. Verbatim and unedited.
New entries go there, not here. (Split 2026-08-18 by pkm_health.R)
