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

## ★ THE SCOPE BOUNDARY IS FRACTAL (2026-08-17)

The same rule operates at three levels of the data, and at every level the excluded thing is the
same: **city driving.**

| Level | Logged | Not logged |
|---|---|---|
| **Fleet** | TwoRed, Creamsicle | Two4Two/TwoFer, Bordeaux -- the Honolulu cars |
| **Car** | TwoRed while it was doing long trips | the Honolulu years; `TwoRed_fuel_June_2014` IS the last log |
| **Trip** | 15 legs, 4,635 mi (2011 St. Louis Trip) | **465 mi, 9%** -- local driving in St Louis, Moab, Fort Worth |

Kim, 2026-08-17: *we're laser focused on the long drives, not the city stuff.*

**★ CONSEQUENCE, AND IT IS A RULE FOR THE ANALYSIS: these gaps are DEFINITIONAL, NOT MISSING DATA.**
Never impute them, never fill them, never caveat them as incompleteness. **The dataset's absences
encode the thesis** -- a record that omits city miles is the artefact of a person who considered
only long-distance driving worth recording, which is precisely what the document argues a Smart
was used for. A completeness check that flags these has misunderstood the project.

## ★ THREE AUDIT FAMILIES, AND THEY ARE NEARLY DISJOINT (2026-08-17)

**The single most useful methodological result so far.** Two independent tests were run over all
292 TwoRed fill-ups. **They overlap on only 2 rows out of 34.**

| Test | Catches | Blind to |
|---|---|---|
| **Arithmetic** -- `gallons x $/gal = cost` | typed digits in price, gallons, cost | city, state, date, odometer |
| **Economy** -- implied MPG per leg | partial fills; **MISSING rows** (MPG too high) | anything self-consistent |
| **Geographic** -- straight-line vs odometer | wrong city/state, mis-geocodes, **odometer digits** | errors that stay on the route |

**Rule: one test finds one error CLASS. A clean pass on the arithmetic says nothing about the
geography.** 21 arithmetic suspects, 15 geographic, **2 in common, 31 distinct rows needing a scan.**

### ★ The geographic test, and the thing it found that is not an error

If the straight-line distance between consecutive fill-ups **exceeds** the odometer change, the leg
is impossible -- you cannot drive less than the straight line. 15 legs fail. **They fall into three
kinds, and the third is a feature of the record rather than a fault in it:**

- **4 GEOCODE errors, from 2 cities.** **`Deming` is logged as ARIZONA; Deming is in NEW MEXICO**
  (twice, 2010 and 2014). **`Big Springs, Texas`** is mis-placed -- the town is **Big Spring**, no `s`,
  and the gazetteer appears to have taken it to Big Springs, Nebraska (twice, 2010 and 2012).
- **7 ODOMETER suspects** -- straight line exceeds the recorded distance with no other explanation.
  **This is exactly the error class the arithmetic test cannot see.** Needs the scans.
- **★ 4 FERRY LEGS -- NOT ERRORS.** Bellingham WA -> Haines Junction YT (1,018 straight-line miles
  against 160 on the odometer) and Homer AK -> Lakewood WA (1,455 vs 336) are the **Alaska Marine
  Highway**; Sydney Mines NS -> Corner Brook NL and Port aux Basques NL -> Aulac NB are the
  **Newfoundland ferry**. **The car crossed water while the odometer stood still.** The test detected
  both great water crossings of the TwoRed record automatically. **Do not 'correct' these** -- and
  they are worth the document: getting a Smart to Alaska and Newfoundland involved boats.

**A fourth, free test: the JOIN ITSELF.** Matching fill-ups to the gazetteer fails on 47 distinct
locations, one of which is **`Lake San Marcos, Callifornia`** -- a spelling error surfaced with no
test written for it.

## ★ THE ERRATA ARCHITECTURE, AND THE RULE THAT DRIVES IT (2026-08-17)

**Nothing is ever overwritten. Corrections live beside the sources and are applied as a DERIVED
LAYER at read time.** Three files in `data/`:

| File | Holds |
|---|---|
| `TwoRed_log_errata.csv` | 11 corrections to the FUEL LOG, each with basis, evidence and status |
| `TwoRed_gazetteer_errata.csv` | 4 corrections to the COORDINATES -- a different artefact, different fixes |
| `TwoRed_leg_distances.csv` | all 292 legs with `distance_basis` (measured / disputed / unresolved) and `distance_source` |

**★ THE ADJUDICATION RULE, and it came from Kim's own GMaps checks: A ROAD DISTANCE CAN NEVER BE
SHORTER THAN THE STRAIGHT LINE. So when GMaps comes in BELOW the great-circle, the COORDINATE (or
the city name behind it) is wrong -- not the odometer.** That one test says which END to fix, and
it is automatable. Applied to Kim's four checks, ratios of 0.61 / 0.75 / 0.69 -- all physically
impossible -- became **1.21 / 1.08 / 1.18** once the real towns were used. **In three of four cases
the odometer had been right all along.**

**★ THE LINE THAT MUST NOT BE CROSSED: reconstruct DISTANCES, never ODOMETER READINGS.** A distance
is an estimate and can be labelled one. An odometer value is a claim about what the car said, and
inventing one propagates a false measurement into the MPG of the fills on either side. Where the
reading was never written (Waynesburg PA, 2010-11-07) the odometer stays **blank** and the distance
carries GMaps 227 as `reconstructed`. Kim, 2026-08-17: *documenting the procedure rather than
inventing data.*

**GMaps is a DATED INSTRUMENT** -- recorded as `gmaps_2026`, because 2026 roads are not 2010 roads.
Same discipline as the temperature and trip-log-onset rulings.

**Impossible legs 15 -> 10 after corrections; 4 of those are the ferries, so 6 are genuinely open.**
Big Spring TX improved from ratio 0.37 to 0.83 -- still impossible, so it has graduated from
geocoding artefact to real odometer suspect.

**★ THE DEFENSIBLE HEADLINE, reproducible from the file rather than asserted:**
**69,689 miles across 285 measured legs. 1,488 miles (2.1%) sit in disputed legs and are excluded.
97.9% of the logged distance rests on undisputed odometer readings.** This tightens as scans arrive.

## ★ THE AMEX STATEMENTS ARE A THIRD INDEPENDENT RECORD (2026-08-18)

Kim kept scans of the old credit-card statements. **BRAND and COST are the invariants** -- they
anchor a row to a real transaction, so where the log's CITY is wrong the statement names the town.
**Four cities corrected this way, every one confirmed independently by geography:**

| Logged | Actually | Ratio before -> after |
|---|---|---|
| Austinburg, OH (Sunoco $22.46) | **Waterloo, NY** | 0.65 -> 1.17 |
| Warren, OH (Flying J $17.74) | **Austinburg, OH** | 6.34 -> 1.08 |
| Matfield Green, KS ($21.59) | **Lenexa, KS** | 0.88 -> 1.25, and inbound 2.30 -> 1.15 |
| Big Springs, TX / Fina ($23.57) | **Alpine, TX / Stripes** | 1.95 & 0.83 -> 1.17 & 1.13 |

### ★★ A HYPOTHESIS OF MINE WAS REFUTED, AND THE REFUTATION IS THE LESSON

I proposed that ONE bad odometer reading at 'Big Springs' explained both its anomalies -- an
impossible 76.2 MPG on the way in and an impossible geometry on the way out. It was elegant: too
high inflates the inbound leg and shortens the outbound one, and two independent estimates of the
corrected value agreed to within 45 miles. **It was also wrong.** The town was **Alpine**, 183 miles
away, and the odometer had been right all along.

**The row held TWO UNRELATED FAULTS: a mislabelled city AND a missing fill-up.** The geographic fix
resolves the first and leaves the second untouched -- 475 mi on 6.237 gal is still 76.2 MPG.
**Rule: parsimony is a preference, not evidence. Two tests firing on one row may be finding two
faults, and collapsing them into one story is how a plausible answer replaces a true one.** This is
the sharpest form of the disjoint-audit-families result: **two errors, adjacent columns, one row.**

### ★★ TWO MORE OF MY OWN CORRECTIONS WERE CORRECTED (2026-08-18)

**1. The row was MERGED, not mislabelled.** Kim's paper log, confirmed against AMEX, has THREE
fill-ups where the sheet has two. The survivor is a **chimera**: `date / city / brand` from the
**Big Spring** row, `$per gal / odometer / gallons / cost` from the **Alpine** row -- an eye
tracking across a paper log and dropping a line partway over. **My 'relabel it Alpine' fix was
directionally right and structurally wrong; the row needed SPLITTING.**

**★ AND IT PASSES THE ARITHMETIC TEST PERFECTLY** -- 6.237 x 3.779 = 23.57 exactly -- **because all
four numeric fields came from ONE source row, so the pump identity survived the merge.** **A
collapsed row can be flawlessly self-consistent. That is the arithmetic test's blind spot, and only
the economy and geography tests saw it.** Restored, the three legs give ratios 0.96 / 1.31 / 1.13
and MPG 35.4 / 38.6 / 36.3 -- all normal.

**2. ERRATA MUST BE KEYED TO A ROW, NOT TO A LABEL.** I withdrew a gazetteer fix on 2026-08-18
believing the 2012 row proved `Big Springs, Texas` was never a real stop. **That withdrawal was
wrong.** The label appears in three rows and means three different things:

| Row | Truth |
|---|---|
| 2010-11-21 | **Big Spring, TX** -- a spelling slip; genuinely mis-geocoded to Nebraska |
| 2012-02-06 | **Big Spring TX + Alpine TX** -- two fill-ups merged into one row |
| 2016-05-30 | **Big Springs, NEBRASKA** -- a real, different town; no error at all |

**One logged label, three resolutions. A correction scoped to a NAME will silently mis-apply to
every other row carrying that name.** The gazetteer entry is reinstated with row-level scope.

### ★ ALL FIVE FERRIES ARE NOW IDENTIFIED

Every geographically impossible leg in seven years is now explained or is a boat. **The remaining
five ARE the boats:** Alaska Marine Highway twice (Bellingham->Haines Junction, 1,018 SL / 160 odo;
Homer->Lakewood, 1,455 / 336), Newfoundland twice, and **Lake Michigan** (Jackson MI -> Madison WI,
260 / 239 -- the Muskegon-Milwaukee crossing, identified by Kim). **A data-quality test built to
find typing errors located every water crossing of the record instead.**

## ★★ THE AUDIT TOOLKIT -- FIVE INSTRUMENTS, NONE REDUNDANT (2026-08-18)

| # | Test | Catches | Blind to |
|---|---|---|---|
| 1 | **pump identity** `gallons x price = cost` | typed digits in the money/volume fields | anything self-consistent -- including a MERGED row |
| 2 | **economy** implied MPG between fills | missing rows, partial fills | rows that balance |
| 3 | **geography** straight line vs odometer | wrong city/state, mis-geocodes, odometer digits | errors that stay on the route |
| 4 | **contiguity** repeated values in neighbouring rows | spreadsheet FILL-DRAG (correlated, not independent) | isolated typos |
| 5 | **price family / same pump** | prices out of regional, seasonal or per-seller family | volumes and odometers |

**Every major error found on 2026-08-18 was caught by exactly ONE of these, and several needed TWO
to be pinned down.** The decisive combination proved to be **contiguity + arithmetic**: when two
adjacent rows share a value, **the row that BALANCES is the source and the row that FAILS is the copy.**
Neither reaches that alone -- contiguity cannot tell contamination from coincidence, and arithmetic
cannot say where a bad value came from.

**★ A SIXTH INSTRUMENT, WHICH IS KIM'S HANDWRITING.** Four typos across 2011-2015 shared one shape:
a ZERO recorded as an EIGHT. Kim named the cause -- **he writes slashed zeros**, and a slashed 0 scans
as an 8. Run as a search generator it found two further candidates from residuals previously dismissed
as rounding; **then the mechanism REJECTED one of them**, because the error is DIRECTIONAL. Control:
0<->8 scored 2 hits in 15 substitutions; 1<->7 scored 0 in 19; 3<->5 scored 0 in 20. **Finding 033.**

**⚠ ITS LIMIT: for the 0/8 class, SCANS ARE NOT EVIDENCE.** Coarse Gold appears to read 7.385; a
7.305 written with a slashed zero looks identical. **The scan is where the illusion lives**, so only
arithmetic, a card or a receipt can adjudicate. Recorded because it would have been easy to 'confirm'
the wrong value by looking harder.

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
