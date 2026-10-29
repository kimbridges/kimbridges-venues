# PROJECT: Smart_Car
_Last updated: 2026-09-03_
_Status: Complete_
_Focus readiness: Not applicable_
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

**★★★★★ PUBLISHED 2026-09-03. *Smart Car* is LIVE at https://kimbridges-documents.netlify.app/smart_car/ as the venue's 23rd Document.** Foreword + 14 chapters + Afterword, ~33,300 words, 37 photographs, 16 pages. **0 unresolved cross-references; 276 local `src=` references, 0 missing.** Card categories Data Analysis / Data Visualization / Maps. Kim drag-deployed to the existing Netlify tile and confirmed live.

**The finish, 2026-09-03:** Kim's two reading passes closed (13 caption and prose fixes, the province count relabelled *provinces and territories*, two optional photographs he supplied both placed -- Anchor Point closing one of the three blank corners in ch.4, and the Whittier tunnel train giving §7.4 its first figure). Venue conventions applied: cover `smart_car_cover_art_text.png` and navbar logo at the project root, `styles.css` setting one book-wide base type, `output-dir` back to `_output`. **Photographs web-sized by `R/resize_images.R` at 1800 px / q88: images 178.4 -> 47.1 MB, rendered document 80.1 -> 26.6 MB.** Both `<!-- KIM: -->` comments removed from `small_cars.qmd`; the Bordeaux/dealership note was already in the Afterword, and the four-year-gap question survives only in `deferred.md`.


**★★★★ THE BOOK IS WRITTEN AND KIM HAS READ IT (2026-09-02).** Foreword + 14 chapters + Afterword, ~33,300 words, 16 pieces rendering clean. His verdict: *"Overall, it is very good. I'm pleased with the result... a bit more work will make it excellent."* **★★★★ AUTHORSHIP IS JOINT: `_quarto.yml` lists "K. W. Bridges" and "Claude (Anthropic)"**, per Kim's standing preference for all collaborations. ★★★ **New voice rule: the considered-alternatives cadence** (*"I considered A. Then B. Finally, C."*), applied to the Foreword and approved. **76 captioned photographs are now in `book/images/` and only 17 are placed.** ⚠ A ghost `_output` directory blocks the normal render; build in `C:/temp` (Finding 054). Per-chapter detail lives in `session_log.md`. The notes below describe ch.4 and earlier and are kept as written.

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

## Settled working sections -- moved to the log 2026-10-28
_17 sections (former lines 89-267) moved VERBATIM to the top of `logs/proj_Smart_Car_log.md`. The book they fed was published 2026-09-03. Headings, for search:_

- ★ THE TWO STRUCTURAL RULINGS (Kim, 2026-08-16/17) — full write-ups in the log
- ★ THE ERRATA ARCHITECTURE (2026-08-17) — full write-up in the log
- ★ THE AMEX STATEMENTS ARE A THIRD INDEPENDENT RECORD (2026-08-18) — AND THE RECEIPTS ARE A FOURTH (2026-08-28)
- ★★ THE AUDIT TOOLKIT — SEVEN INSTRUMENTS (2026-08-18; seventh added 2026-08-28) — full write-up in the log
- ★★ THE CORRECTED DATASET (2026-08-18) — build story in the log
- ★★ FIRST ANALYSIS ON CLEAN DATA — SIX RESULTS (2026-08-18) — detail in the log
- ★★ THE WHEELS WERE NEVER ABOUT FUEL — THEY WERE ABOUT SAFETY — folded into ch.2
- ★★ KIM'S FRAME: TWO LOGS, TWO SUBJECTS (2026-08-18) — the FABRIC of the three layers
- ★★ THE SCAN SWEEP, 2026-08-18 — full write-up in the log
- ★★★ THE LONG DAYS — ALL EIGHT COLLECTED, AND EVERY ONE CHECKS OUT (2026-08-19)
- ★★★ THE FAVOURITE DRIVES (2026-08-19) — full write-up in the log
- ★★★ THE FOURTH CROSSING LOG IS FOUND (2026-08-19) — full write-up in the log
- ★★★ THE STRESSFUL MILES ARE INVISIBLE — A DIFFERENT SILENCE FROM FINDING 036 (2026-08-19)
- ★★ TWO RELOCATIONS, AND THE LAST YEAR'S SHAPE (2026-08-19) — full write-up in the log
- ★★★ THE END OF THE MAINLAND RECORD: 71,283 AT THE MATSON DOCK (2026-08-19)
- ★★★ THE OPEN QUESTIONS ARE ALL CLOSED (2026-08-19/21) — full working in the log
- ★★★ CREAMSICLE IS INGESTED — THE SECOND SPINE EXISTS (2026-08-19)

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
- **`book/R/day_data.R` + `book/R/fig_day.R` -- NEW 2026-09-01.** Ch.12. Built on **Creamsicle's optional free-text `comment` column**, which turns out to be a stopped-time detector: 35 of 84 legs carry a comment and hold 73.4% of all stopped time. Reports the three-way test (miles p = 0.97, gross mph p = 0.002, net mph p = 0.36) so nothing is typed. `DAY_CATS` **states the grouping rule in code** and files a two-part comment under the FIRST match in the stated order. `@fig-day` at `book/figures/day.png`. ⚠ The grouping is mine, not Kim's, and has not been put to him -- see `deferred.md`. **Extended after Kim's instrument-design lesson (2026-09-01):** `tw_no_stop` / `all_legs` / `pct_unaskable` (**139 of 223 legs, 62.3%, can never be asked** -- TwoRed's sheet has no stopped-time column), `names_seen` (the names a category list would lose), and `cat_at10` / `cat_all_by` / `cat_total` (**6 of 7 categories visible in the first ten comments, all 7 by the 20th** -- which turns *run the data early* into a result).
- **`book/R/constellations_data.R` + `book/R/fig_constellations.R` -- NEW 2026-09-01.** Ch.13. `norm_state()` (the raw data mixes full names with abbreviations and carries a misspelled *SASKATCHWAN*), `SILENT_STATES` (**the disposition of every state the fuel log never saw, recording HOW each is known**), the state/province coverage counts, and the twelve between-trip intervals from `TwoRed_on_station.csv`. ⛔ **The driving map is a STATE-LEVEL choropleth on purpose** -- the gazetteer places 78% of TwoRed's fills and 17% of Creamsicle's, so a point map would misreport a gazetteer gap as a fact about the car. ⛔ **The parking figure is a TIMELINE, not a map (Finding 041).** ⚠ **REBUILT 2026-09-01 on Kim's ruling: the map is about TRAVEL, not transactions.** `fig_driving()` fills every jurisdiction either car REACHED (fills, plus the six silent states, plus BC) in two classes and outlines nothing. **The no-fill distinction lives in `@tbl-silent` only.**
- **`book/R/cannot_say_data.R` -- NEW 2026-09-02.** Ch.14. Measures the SHAPE of the two kinds of table (answers vs evidence), classifies what settled each of the 65 errata, re-derives the four states' geometry from the completed geocode, and re-runs the temperature and southern-deficit tests. ⛔ **Takes lifetime economy from `cost_data()`, never recomputing it: there is exactly ONE derivation of that figure in the book** (a second one, added by mistake, returned 39.2724 against ch.11's 39.2511). ⚠ Its `SILENT_STATES` table is the ch.13 source of truth for how each no-fill state is known.
- **`book/R/stops_data.R` + `book/R/fig_stops.R` -- NEW 2026-09-01.** The fuel-stop POINT map: what a choropleth cannot show, which is **cadence**. Geocoding is offline and reproducible from three sources -- the project gazetteer, the 8 coordinate pairs in `TwoRed_gazetteer_errata.csv` (**keyed both by the corrected name AND by the misspelling the fuel log carries**, worth +2.4 points on its own), and `maps::` city tables with `world.cities` tagged to a state by point-in-polygon against `data/na_states.rds` (cached at `data/wc_tagged.rds`). ⛔ **No network geocoder in a figure function.** **Coverage: BOTH CARS 100%, 467/467 fills (2026-09-01).** The last 116 cities came from the **Google Geocoding API**, run once with Kim's key and saved to `data/geocode_google_2026-09-01.csv`; ⛔ `stops_data()` reads that file and never calls the network. **Every result audited by point-in-polygon: 111 inside the logged state, 5 coastal within 1.8 km, 0 mismatches.** ★★ It also yielded **14 gazetteer errata** (errata file 8 -> 22 rows). **Both maps are placed in ch.13 (Kim's ruling 2026-09-01), with `perday` carrying the caveat that a DOT IS NOT A DAY: 27.8% of TwoRed's fuelling days and 38.0% of Creamsicle's have more than one fill.**
- **`book/data/na_states.rds` -- NEW 2026-09-01.** Cached North America state/province geometry (137 KB, `rnaturalearth` simplified to 3 km, 51 US + 13 CA, Alaska included). ⛔ **`ne_states()` HUNG THE R BRIDGE for several minutes on a network call.** `fig_driving()` reads this file and must never call the network at build time. ⚠ Also `data/wc_tagged.rds` -- `maps::world.cities` for USA/Canada with a state assigned by point-in-polygon. Regenerate only in a scratch session.
- **`book/images/TwoRed/log_sheet_frostburg3.png` — NEW 2026-09-01.** Page 3 of `2012_TwoRed_Frostburg_Trip_Log.pdf` at 150 dpi, the book's first photographic figure. Regenerate with `pdftools::pdf_convert()`; do not edit.
- **Every chapter heading now carries a `{#sec-...}` label and `index.qmd` / `afterword.qmd` are `{.unnumbered}` (2026-09-01).** Chapter cross-references are generated, not typed — see Finding 050 and `deferred.md`.
- `source/` — **★★★ `2014_Chateau_Presentation.pptx` (50.3 MB, 121 slides, dated 2014-06-16, four days after the trip closed) — A PRIMARY SOURCE, added to this list 2026-08-29 after sitting unlisted since intake.** *Driving to the Extremes*, given at Lake San Marcos. **Slide 42 names the four missing states (Florida, Delaware, Rhode Island, Vermont) in writing; slide 6 is an independent 2010-2013 computation; slide 121 gives the 10,907-mile total; and 121 embedded photographs answer the TwoRed-photo question.** Also: `Smart_Car_master_dictionary.pdf` (expedition names, dates, targets); `Smart_Car.docx` (10.3 MB, largest section is the already-published Arctic Circle Challenge — **a quarry, not a draft**); `Smart_Car_2016.pptx`; `charter_2026-05-08.md`, kept verbatim, superseded on scope and Chapter 5.
- `images/Creamsicle/` — 37 geotagged trip photos + `Creamsicle_profile.jpg`. **Backstop for the deleted `creamsicle.jpg`: a copy survives at `kimbridges-stories\underway\Smart_car\` — do not delete that folder without checking.** ⚠ **SUPERSEDED 2026-09-02: `book/images/` now holds 76 CAPTIONED photographs of all four cars** (TwoRed 27, Creamsicle 35, Bordeaux 7, TwoFer 7), 66 with Kim's own IPTC/XMP captions and 40 geotagged. **Full inventory at the top of `logs/proj_Smart_Car_log.md`.**

## Related Projects
- `proj_Trip_Log.md` — the travel-photo + trip workflow; upstream.
- `proj_timelinesr.md` — timeline package, for the sixteen-year spine.
- `proj_Photo_Locations.md` — geotagging workflow.
- `proj_Plainmaps.md` — R mapping.
- `proj_kimbridges_stories.md` — holds the published Arctic Circle Challenge.



## Settled working sections -- moved to the log 2026-10-28
_9 sections (former lines 348-464) moved VERBATIM to the top of `logs/proj_Smart_Car_log.md`. The book they fed was published 2026-09-03. Headings, for search:_

- ★★★ ROAD CHARACTER — A TAXONOMY FROM EXPERIENCE (Kim, 2026-08-20) — ch.6 material
- ★★★ THE ANCHOR, THE PARKING, AND HAWAII (Kim, 2026-08-20) — now DRAFTED as the Foreword
- ★★★ THE SAFETY QUESTION — LAYER ONE'S CONTENT, DRAFTED AS ch.2
- ★★★ CHAPTER ARCHITECTURE — KIM'S THREE LAYERS (2026-08-19) — full development in the log
- ★★★ THE CHAPTER LIST AND THE MANUSCRIPT (2026-08-20) — full draft in the log
- ★★★ FINDING 045 — A SILENCE BELONGS TO AN INSTRUMENT, NOT TO THE PAST (2026-08-21)
- ★★★ CHAPTER 1 IS DRAFTED (2026-08-21) — `book/small_cars.qmd`, ~720 words
- ★★★ FOREWORD AND CH.2 — KIM'S FIRST PASS DONE (2026-08-21)
- ★★★ CHAPTER 2 IS DRAFTED (2026-08-20) — `book/is_it_safe.qmd`, ~2,300 words

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
