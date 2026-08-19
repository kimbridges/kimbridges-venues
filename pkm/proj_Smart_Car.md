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

## ★ THREE AUDIT FAMILIES (2026-08-17) — SUPERSEDED, moved to the log

The 2026-08-17 three-family write-up is verbatim in `logs/proj_Smart_Car_log.md`. **It is superseded by THE AUDIT TOOLKIT -- FIVE INSTRUMENTS below**, which is the same idea after two more instruments turned up (contiguity, and price-family/same-pump). Its one durable sub-finding is carried in the toolkit section: **the geographic test found things that are not errors at all -- the five ferries.** And see THE LONG DAYS above for the revision: a high road/straight-line ratio is sometimes a story, not a defect.

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

## ★ THE AMEX STATEMENTS ARE A THIRD INDEPENDENT RECORD (2026-08-18) — detail moved to the log

Full write-up verbatim in `logs/proj_Smart_Car_log.md`. **The card statements are independent of both the paper and the spreadsheet, which is what makes them decisive.** The four things worth carrying forward:

1. **An elegant single-cause hypothesis of mine was REFUTED by one line of Kim's statement** -- the town was    Alpine, not Big Spring. Two independent estimates agreeing within 45 miles, and still wrong.
2. **The merged row was a CHIMERA and needed a SPLIT, not a relabel** -- labels from one stop, all four    numeric fields from another, which is exactly why it passes the arithmetic test perfectly.
3. **Errata key to a ROW, never a LABEL.** `Big Springs, Texas` appears three times and means three    different places.
4. **All five ferries are identified** (Alaska Marine Highway x2, Newfoundland x2, Lake Michigan x1) -- and    the Lake Michigan crossing is now confirmed a second time, in Kim's own hand on the Frostburg-3 sheet.

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

## ★★ THE CARD COVERS THE FLEET; THE LOG COVERS ONE CAR (2026-08-18)

Kim's **AMEX fuel summary for 2015** -- 16 charges. **Eight match the TwoRed log to the cent.
Eight do not, and those eight are the OTHER CARS.** Seven are Hawai`i (six Costco Honolulu, one
Tesoro Hilo); one is a 7-Eleven in **Orlando, Florida**, where TwoRed never was -- almost certainly
a rental. **Every mainland-west charge matches. The card is a FLEET-level record and the fuel log is
a SINGLE-CAR record, and the difference between them is itself data.**

### ★★ The scope boundary appears a FOURTH time -- and this time an outside source proves it

**AMEX 01/10/2015 COSTCO HONOLULU $19.74 matches TwoFer's final logged fill EXACTLY** (1/10/2015,
9:19 AM, Costco, ODO 1,209, 6.93 gal, $19.74). **And then the card keeps going where the log stops:**
six further Hawai`i fuel charges from February to October 2015.

At TwoFer's own logged averages (6.675 gal/fill, 31.3 MPG) those six fills are **roughly 1,254 miles
-- against the 1,209 the log records. The log captures about HALF of 2015 use.** *(ESTIMATE ONLY: the
card gives a count of charges, not gallons or odometers. Do not print this as a measurement.)*

**Why it matters.** The fractal-scope section already showed the same rule at fleet, car and trip
level, inferred each time from the record's own shape. **This is the first time an INDEPENDENT source
has confirmed it**: the log stopping is demonstrably not the car stopping. It is the exact pattern of
TwoRed's 71,181 against ~75,000, now visible in a second car and a second document.
**And it does not complicate the 2x2 role split -- it strengthens it.** Every one of those unlogged
fills is in Honolulu or Hilo. **TwoFer stayed a short-haul car even in the miles nobody wrote down.**

## ★★ THE CORRECTED DATASET EXISTS (2026-08-18)

**`twored_ingest.R`** (in `Projects\Smart_Car`) reads the UNTOUCHED xlsx plus a machine-readable
corrections table and emits **`data/TwoRed_fuel_clean.csv`** -- 294 rows, 16 columns, provenance on
every change. Nothing is edited in place; re-running reproduces it from the sources.

| Test | before | after | with hypotheses |
|---|---|---|---|
| pump identity fails | 15 | **5** | **2** |
| MPG > 60 (non-partial) | 5 | **0** | 0 |
| MPG < 22 (non-partial) | 1 | **0** | 0 |

**Three things the build forced that the errata could not express:** a **ROW INSERT** (the merged
Big Spring/Alpine row -- a whole fill-up was missing, not a wrong field); **EXPLICIT FLAGS** (Woody
Point is 3.74 gal, just over an arbitrary 3.5 threshold, so partial fills now come from the errata
rather than a cutoff); and **A GUARD THAT REFUSES** -- every correction must find the value it claims
to replace. It refused a date correction because the sheet stores Excel serials, and it caught two of
my odometer keys pointing at the wrong rows. **Finding 032 is written into the code:** the script
asserts rows may be ADDED but never silently lost, and prints the count.

**The two survivors are honest ones:** Deming (arithmetic wants 20.85 but the slashed-zero DIRECTION
is wrong, so it is flagged not applied) and Haines Junction -- **not a typo but a UNITS design flaw
my own L32 fix created**: a USD cost against a CAD-derived price. That row needs a CURRENCY column.

## ★★ FIRST ANALYSIS ON CLEAN DATA -- SIX RESULTS (2026-08-18)

**1. THE URBAN-COMMUTER CLAIM IS REFUTED, AND THE NUMBER SURVIVES THE OBVIOUS OBJECTION.**
**Median distance between fill-ups: 251 miles**; 5th percentile 159; **87% of logged miles in legs
of 200+.** The objection -- *he only logged long trips* -- fails on arithmetic: the log spans **71,177
miles of a car that reached ~75,000, so ~95% of the odometer is in the sample.** It is not a
subsample, it is nearly the population.

**2. AN INDEPENDENT CHECK AGREES.** Lifetime **39.44 MPG**, at the HIGHWAY end of the 2010 Fortwo's
own 33/41 EPA range -- what a car averaging 251 miles between stops should show, and not a commuter.

**3. LEG LENGTH DOMINATES ECONOMY: +4.61 MPG per 100 extra miles between fills** (p<0.0001).
The city-vs-highway penalty, measured from Kim's own tank rather than quoted from a manufacturer.

**4. THE CAR DID NOT DEGRADE.** Controlling for route mix, MPG **ROSE +0.30 per 10,000 miles**
(p=0.030) -- about **+2 MPG across its life.** Not the expected direction over 71,000 miles.

**5. FUEL COST.** $6,663 total, **$0.0936 per mile lifetime**, yearly range $0.069-$0.108. Price paid
peaked 4.199 (2013), bottomed 2.769 (2017) -- a 34% fall tracking the real 2014-15 collapse.

**6. NO TEMPERATURE EFFECT DETECTED -- and the reason is actionable.** +0.20 MPG per 10F, p=0.75,
n=58, over a range of only **38-94F**. The large cold-weather penalty lives near freezing.
**The data to test it is on the paper and was never transcribed** (see deferred.md).

## ★★ THE WHEELS WERE NEVER ABOUT FUEL (Kim, 2026-08-18)

The first crossing ran on the stock narrow "city" tires. On open highway the car was blown around by crosswind and the handling was difficult. Smart Madness -- Kim's mechanics -- prescribed WIDE tires; fancy rims came along with them, because this is a car that is fun to drive and fun to be seen in. It worked. Handling became very good.

**The purpose was handling, not economy.** That reframes what the fuel data can say. Wider tires carry a real theoretical cost -- more rolling resistance, more frontal area -- usually put at 1-3%. So the question the data answers is not "did the wheels help?" (they did, on the axis they were bought for) but "what did that help cost?"

**Answer, stated honestly:** before/after the change, the difference in economy is not distinguishable from zero, with a 95% interval of **-3.7% to +4.9%**. The theoretically expected 1-3% penalty sits INSIDE that interval. So the correct claim is the narrow one:

> The data rules out a LARGE fuel penalty from the wide tires. It is too small a sample to detect the modest penalty theory predicts. Absence of a detected effect is not absence of an effect.

I first wrote the stronger version ("rules out a penalty worse than 3.7%") and had to withdraw it in the same turn. Logged because it is the same failure mode as Finding 032: a number that looked like a bound was actually one end of an interval that straddles zero.

**For the story:** this is a clean example of the document's recurring shape -- a decision made for one reason (safety and pleasure in a crosswind at 70 mph in a 1,800-lb car), then measured on a different axis (fuel), and the measurement's job is to say what the decision cost, not whether it was right. Kim already knew it was right; he drove it.

## ★★★ KIM'S FRAME: TWO LOGS, TWO SUBJECTS (2026-08-18)

His words: *the fuel log is more about the CAR'S performance, while the trip log shows the HUMAN performance -- how far and fast can you expect to drive in a day, something I had no idea about until I started doing these drives.*

**This is the strongest organising idea the project has produced, and it should be the top frame of the chapter architecture** -- which has been the named weak point since 2026-08-16 precisely because it was inherited from a one-car charter and had no thesis under it.

**Why it is more than a nice phrasing:**

- **It explains why neither log substitutes for the other.** The fuel log records STOPS; the trip   log records LEGS. They are not two views of one thing, they are measurements of two different   subjects that happen to share an odometer. The odometer is the JOIN, not the topic.
- **It tells us which instrument answers which question.** Economy, degradation, cost per mile,   the wide-tire question -- car. Daily range, departure discipline, gross speed, the length of a   driving day -- human. **Mixing them is how you get a meaningless average.**
- **It makes the temperature decision obvious.** Temperature stamped on a FILL belongs to the car's   question; temperature at a leg endpoint belongs to the human's. Same word, two instruments.
- **★ It supplies the missing NARRATIVE thesis.** Kim did not know the answer before he drove it.   So the human half is not a summary statistic -- it is a **finding he made about himself by doing   the thing**, sixteen years of it, and the data is the record of the learning. The 3-bar refuelling   rule adopted at Deming in 2010 is exactly this: a behaviour CHANGED by a near-miss, and visible   in the numbers afterwards.
- **And it explains the collection history rather than apologising for it.** Trip logging started   LATER than fuel logging (Kim's ruling, 2026-08-17). Of course it did: **the car's question was   the obvious one to ask first. The human question is the one the driving itself taught him to ask.**

**First evidence that the human axis is measuring something real:** across 69 legs, median gross speed separates by ROAD, not by car -- 2011 interstate **47.6 mph**, 2014 mixed **39.7**, 2013 Dalton Highway **30.9**, 2016 US-101 coastal **28.3**. The car was the same car throughout.

## ★★ THE SCAN SWEEP, 2026-08-18 — full write-up in the log; the four results kept here

All 15 scans read: 18 pages, 7 files, every column. **Trip legs 69 -> 107** (101 with usable times); **fuel rows with a time and temperature stamped ON THE FILL 0 -> 95** (32%). The 2011 St. Louis file was a pure duplicate -- zero new legs -- but re-opening it returned 23 fuel-row temperatures the first pass had walked past. **Detail in `logs/proj_Smart_Car_log.md`.** What must not be lost:

**1. The wheel change is DATED: `NEW WHEELS @ 13510 miles`, Kim's margin, 179 mi before the 2011 departure.** So the narrow-tire group is exactly 2010-07-23 to 2011-05-11. **The estimate FLIPS SIGN with specification** -- raw +1.7%, +leg length +3.6%, +odometer trend +1.6%, local +/-12,000 mi -1.8%, +temperature -1.5%. **That is the finding. Not any one of those numbers.** The CONDITIONAL in `deferred.md` governs.

**2. Temperature is not null once measured ON THE FILL** (the earlier test used leg endpoints, the wrong unit). n=94: **-0.068 MPG/degF, p=0.045**, stable -0.068 to -0.084 across four specifications; fills at 80 degF+ average **36.76** against **38.87**. **A SIGNAL, NOT A FINDING** -- p crosses 0.05 under era fixed effects, and the counterintuitive sign points at A/C load, which is inferred and not measured.

**3. The slashed zero produced three more corrections and the control held.** Over the 44 rows failing the pump identity, a single-digit substitution in the cost: **permitted 8->0 fixes 4; forbidden 0->8 fixes 1** (Deming, already flagged wrong-direction); **six control substitutions fix 0.** New L59-L61; errata at 61.

**4. Gross speed separates by ROAD, across 107 legs.** 2011 interstate **47.6** | 2012 Frostburg 43.5 | 2017 January 41.2 | 2011 N. California 40.6 | 2014 Penultimate State 39.7 | 2015 Sedona 39.0 | 2012 May Arizona 36.9 | 2013-4 LA 34.6 | 2013 Dalton Highway **30.9** | 2016 US-101 coastal **28.3**. Same car throughout. **And see THE LONG DAYS above: the tails are set by lodging geography and ferry timetables, not by the road alone.**

## ★★★ THE LONG DAYS — SIX OF EIGHT COLLECTED, AND EVERY ONE CHECKS OUT (2026-08-19)

**Kim's accounts are verbatim in `logs/proj_Smart_Car_log.md` under COLLECTED STORIES.** They are chapter source material; what follows is only what the log CONFIRMED and what it changed.

| day | leg | mi | his reason | what the data independently shows |
|---|---|---|---|---|
| 2012-05-31 | St Louis -> Columbus | 518 | navigator distracted; lost near Urbana IL | **the 09:52 fill is at Champaign IL -- one metro with Urbana.** Excess over direct I-70: **108 mi** vs his remembered ~100 |
| 2011-06-26 | Flagstaff -> Holbrook | 100 | meeting his nephew, a park naturalist | out **04:30**, in **06:45** -- a 100-mi hop existing only to arrive early; **70 mi of local driving before the next departure IS the tour** |
| 2012-06-14 | Billings -> Pocatello | 449 | dull country, nowhere to stay, good freeway | **65.5 mph gross, the fastest day in the record**; sole stop **2.695 gal at Livingston**, already flagged `partial_fill` |
| 2014-05-29 | Sydney NS -> Edmundston | 555 | off the overnight ferry, car already packed | previous leg ends Port aux Basques **46,625**, this one starts Sydney **46,625** -- zero odometer miles; last fill before boarding was a **full 7.12 gal** |
| 2017-01-06 | Brookings -> Paso Robles | 562 | racing to his mother, 104; heavy rain at Santa Rosa | **32 degF at Brookings, the coldest start in 107 legs**; Santa Rosa fill **15:59** is the decision point; Paso Robles fill **22:04 at 68,731**, arrival **22:10 at 68,732** -- one mile, six minutes |
| 2012-05-24 | LSM -> St George | 492 | a long stop with friends in Las Vegas | Las Vegas fill at **18:08**: 375 mi in 12.1 h (**31 mph -- the visit is inside that**), then 117 mi in 2.5 h (**47 mph**) once moving |

### ★★★ FIVE THINGS THE STORIES CHANGED, none of which the data could have volunteered

**1. Finding 033 got its best corroboration, from an unrelated direction.** The Champaign row is **L61**, one of three slashed-zero cost typos raised the day before. **The typo sits at the stop where he had just discovered he was 100 miles off course and late for dinner.** Kim gave the mechanism on 2026-08-17 -- *record quickly* under pressure -- and here the pressure is documented, at a named stop, by a route that had nothing to do with the audit.

**2. The gap between an arrival odometer and the next departure odometer is not noise -- it is the day off the highway.** 70 miles at Holbrook is a park tour. This is a readable quantity across the whole record and nobody has read it.

**3. Daily distance has a first-order term nobody modelled: WHERE THE BEDS ARE.** The fastest day in sixteen years is fast because Montana has nowhere to stop. Lodging geography sets the length; scenery sets the pace.

**4. A ferry is a LOGISTICS MULTIPLIER, not a hole in the odometer.** It converts a night into progress and hands the next morning a loaded, fuelled car. Read the five ferries as ENABLING the long days after them.

**5. ★★ A LONG ELAPSED TIME IS NOT A SLOW DAY.** LSM -> St George read 31.6 mph and looked like a slog; it was a normal drive with a half-day visit inside it. **Gross speed silently conflates driving with living.** Kim's own note: *this was before I was recording why I took time off during a drive* -- so the STOP column that Creamsicle has is exactly the instrument that would separate them. **Until then, gross mph is a ceiling on driving speed, never a measure of it.**

### ★★ AND CHASING #5 FOUND A BUG IN 16 OF 107 LEGS

Asking why that day looked slow exposed it: **Nevada is Pacific and Utah is Mountain, and `tz_shift_hr` was 0 on every leg I transcribed.** Kim records LOCAL clock time at both ends, so any leg crossing a zone has a raw elapsed time wrong by the offset -- **and nothing in the data flags it.** Only the 2011 file ever carried the correction by hand.

**Fixed as a DERIVED LAYER, not as 107 hand-entered numbers:** `data/TwoRed_city_timezones.csv` maps 97 endpoint cities to IANA zones and `trip_logs_read.R` computes the shift per leg. **DST, Arizona's and Saskatchewan's no-DST rules, Yukon in 2013 and Newfoundland's half hour all fall out for free** -- none of which a hand-entered integer would have survived. Fifteen cities carry a note saying why they are not what their state implies (El Paso is Mountain; Lewiston ID is Pacific; Bismarck is Central and western North Dakota is not).

**Effect: 16 legs corrected, up to 6 mph each.** St George -> LSM 60.9 -> **53.0**; Ogallala -> Omaha 42.7 -> **48.8**; St Louis -> Columbus 41.0 -> **44.5**. **The headline survived** -- trip medians moved 0 to +0.9 mph and the road ordering is unchanged; pooled median 39.7 -> **40.3**. **Billings -> Pocatello is untouched at 65.5** (both ends Mountain), so the fastest day is real.

**★ Twice in one session, a story he told corrected the data.** First the audit rule on road/straight-line ratios; now the time zones. **The human spine is not decoration on the analysis. It is an instrument.**

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

## ★ THE CHAPTER ARCHITECTURE IS NOW THE WEAKEST PART (2026-08-16)

Stated plainly so a future session does not inherit it by default. The project now has a
quantitative spine on two cars, a drafted narrative on one, a photo layer that joins to both, and
a defined minor role for the Honolulu pair. **The architecture below has none of that in view --
it was written for one car and one trip.** Redesign it before writing prose. Live candidates: the
2x2 role split as the top-level frame, and the two long-distance cars as parallel spines rather
than one primary plus supplements.

## Chapter architecture -- SUPERSEDED, moved to the log 2026-08-18

The one-car charter's chapter list is verbatim in `logs/proj_Smart_Car_log.md`. It is superseded, and the redesign is an open task in `deferred.md`. **Kim's TWO LOGS, TWO SUBJECTS frame above is the candidate replacement top-level structure.**

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
