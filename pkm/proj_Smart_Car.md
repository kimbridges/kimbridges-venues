# PROJECT: Smart_Car
_Last updated: 2026-08-12_
_Status: Active_
_Focus readiness: Blocked_
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
**Intake completed 2026-08-12; development BLOCKED on Kim's data recovery.** Materials
moved out of `kimbridges-stories/underway/` (where they had been mis-filed as a story
since 2026-05-06) into `Projects/Smart_Car`. No code written yet, by design: the data
cannot support the reframed scope until Kim finds the paperwork on the other three cars.
He will do that in miscellaneous time, not in a focused session, which is why this file
reads Blocked rather than Ready.

**This was the third intake gap of the Jones / vouchr shape** -- real project materials,
a written charter, no `proj_*.md` and no index row, dormant three months.

## What the data ACTUALLY contains

Read directly rather than taken from the charter, 2026-08-12. **Three of the charter's
claims do not survive contact with the files, and one filename actively misleads.**

| Asset | Charter said | What is actually there |
|---|---|---|
| `TwoRed_fuel_June_2014.xlsx`, sheet *Gas Log* | "nearly 300 fill-ups" | **293 fill-ups, and the range is 2010-07-23 to 2017-05-22** -- nearly three years past what the filename claims. **Rename deferred until Kim confirms.** |
| same, odometer | "75,000 miles" | **Tops out at 71,181.** The 75,000 figure is not in this file. Either the car ran on past the last fill-up, or the title is an approximation. **Unresolved -- do not print 75,000 until it is sourced.** |
| same, *State* column | "49 states and 10 provinces" | **52 distinct values.** California 96 fill-ups, then Arizona 24, Texas 21. Needs normalising before any count is claimed. |
| same, sheet *Trip Log* | "precise daily driving intervals" | **7 rows.** This is a fragment, not a dataset. |
| same, sheet *Canada2014* | not mentioned | **24 rows in litres and Canadian dollars.** A unit-normalisation job the charter did not anticipate. |
| `2016_Fourth_Crossing_Analysis.xlsx` | "a highly refined subset" | **Accurate.** 35 rows, with `time_zone`, `raw_hours`, `activity_time`, `corrected_hrs`, `miles_per_hour` already derived. The best-prepared asset in the set. |
| `Smart_Car_master_dictionary.pdf` | expedition names and date ranges | Present, 2.0 MB. Not yet parsed. |

**The other three cars have no data files at all yet** -- only `leased_smart.txt` (one
line: *March 22, 2014: Leased Two4Two (Smart Pure)*) and two photographs. That gap is the
blocker, and it is the whole of the blocker.

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
- `images/two_smarts.jpg`, `images/creamsicle.jpg` — the current two, and one earlier car.

## Related Projects
- `proj_Trip_Log.md` — the travel-photo + trip workflow; upstream.
- `proj_timelinesr.md` — timeline package, for the sixteen-year spine.
- `proj_Photo_Locations.md` — geotagging workflow.
- `proj_Plainmaps.md` — R mapping.
- `proj_kimbridges_stories.md` — holds the published Arctic Circle Challenge.

## Chapter architecture (PROVISIONAL — inherited from the one-car charter)
1. **Foreword** — origin (Paris to the US mainland) and the urban-myth thesis.
2. **The Canvas** — the geocoded constellation of every recorded fuel stop.
3. **The Expeditions** — fill-ups classified into trips via the master dictionary.
4. **The 4th Crossing** — daily friction: temperature against mileage, true average speed.
5. **The Extremes** — highest (Mount Evans), lowest (Death Valley), furthest.
6. **The Fleet** — NEW, and the reframing's payload: four cars, sixteen years.

Old Chapter 5 (Arctic Circle embedded) is deleted; see intentions item 2.

## Next Steps
1. **KIM, unscheduled:** find the paperwork and data for the other three cars. Everything
   else waits on this. Detail in `deferred.md`.
2. Confirm or correct the 71,181 vs 75,000 discrepancy at source.
3. Then: the ingestion script assigning an `Expedition_ID` to every fill-up.
4. Then: the Chapter 2 geocoded constellation map.

## Collaborators / Dependencies
None.

## Blockers
**Data for cars 2-4 does not exist in machine-readable form yet.** Kim is recovering it
from paperwork in miscellaneous time. Until then the fleet framing cannot be written, and
only the TwoRed chapters are technically possible.

---
## Log
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
