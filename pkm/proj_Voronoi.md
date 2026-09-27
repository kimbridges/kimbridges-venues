# PROJECT: Voronoi
_Last updated: 2026-09-26_
_Status: Active_
_Focus readiness: Ready_

## Type
Quarto multi-chapter document (methods) + likely companion R package. **Track (Mechanism 1):
venue kimbridges-documents; language R + Quarto.** Package name not yet chosen.

## Objective
A methods document on Voronoi tessellation for category data at points: how to make the tiles,
measure them, read them, and extend them -- written for people who have never met the terms
"Voronoi tessellation" or "Thiessen polygons". Its centrepiece is a new combination of two
little-known technologies: **Voronoi tiles from releves, constrained by canopy height** (the Meta/WRI
1 m GEDI-calibrated canopy map), which gives a reproducible, good-enough first approximation of a
vegetation map from a small number of releves. **Kim's ruling (2026-09-25): finish this document
BEFORE the technology is discussed in the trilogy;** *Maps with Tiles* then cites it.

## Current Status
**KIM'S CONCLUSION (2026-09-26):** plain Voronoi maps aren't good enough; combined with other data (here canopy height) they are.
Reproducibility is part of their value (hand-drawn maps disguised their judgments); mismatches prompt 'why?' and lead to new data.
The study introduces both a methodology and a data source. -> Ch.9 verdict, Ch.10 opening. Full quote in `background/drafting_notes.md`.

**NEW 2026-09-25.** Opened from the MWT work the same session, after a prototype at Kipuka Puaulu
succeeded. Kim: "It shows just what we need; realistic boundaries and an appropriate
classification." Nothing is written yet; the structure starts from Kim's late-night outline
(`Voronoi_thoughts.txt`, captured below) and "restructure and complete" is the task.

**The prototype (2026-09-25).** Window 3.2 x 2.6 km around the kipuka (UTM 5N, 5 m cells). Canopy
height from Meta/WRI quadkey `022300033`, keyless via `/vsicurl` (the July *Voucher Labels* route).
Four structure classes -- open <2 m, low 2-5, woodland 5-10, forest >10 m -- smoothed over 25 m,
patches <0.25 ha merged (`terra::sieve`). 12 releves, **3 per structure class** (random, >=400 m
apart). **STAND-IN categories.** Method, named here **structure-constrained Voronoi**: each cell takes
the category of the nearest releve IN THE SAME STRUCTURE CLASS; a class with no releve stays
unassigned; patches holding no releve are shown faded (extended, not sampled -- 16% of the window).
Result: plain vs constrained disagree on **66%** of the area; the plain Voronoi carried "forest"
across open lava to the window edge, the constrained map follows the kipuka edge, rings it with
woodland and opens the glades inside it. **The expected limit showed:** two forest categories in one
structure class still meet on a straight bisector -- canopy height cannot place a compositional
boundary.

**Caveats to carry into the document.** (1) The stand-in categories partly follow structure, which
flatters the constrained map; real releves are the test. (2) Smoothing can put a releve in a class
different from its own spot (R04 reads 0.2 m, falls in "low"); a real releve records its own
structure. (3) The Meta map is modelled from imagery and calibrated to lidar, not lidar: softer
edges. (4) Structure breaks and smoothing are the author's defaults -- judgments written down, which
is Kim's "reproducible, not objective".

## Kim's outline, as given (2026-09-25, `Voronoi_thoughts.txt` -- "late-at-night musings")
- Mapped areas depend solely on point locations and point categories (plus the outer border).
  Highly dependent on point placement; **precludes applications where external information matters
  (e.g. no crossing rivers)**. Boundaries = what the data say under the assumption that a category
  extends halfway to its nearest neighbours. Plausible: nearest market, nearest school; less clear:
  vegetation samples representing their polygons.
- **Analysis -- statistics per polygon:** area inside border, border length, max and min distance to
  border, number of neighbours, border length shared with neighbours; **pattern analysis** (uniform
  cells; variable cells = aggregation; large cells = sampling gaps / disturbance openings).
  Overlays: metadata to help interpretation.
- **Mapping categories.** Analysis area unbound (a square) or bounded (a polygon). One category,
  divide the area (monitoring traps). Each site a category (school, market districts, climate
  zones). Some sites share a category, merge where adjacent (dominant species, store chains,
  agricultural fields / ahupua'a). Points inside polygons (public health: sources and cases;
  invasives inside vegetation types). Weighted Voronoi (botanical-garden service areas by
  attendance; attractiveness; capacity).
- **Once partitioned, ask:** which is the nearest source? how much space does each source command?
  what do the cell patterns tell us?

## Claude's notes on structure (2026-09-25, not yet ruled)
- Kim's use-case list (one category / each site / shared + dissolve / points in polygons / weighted)
  works as a SPINE.
- Per-cell statistics are DIAGNOSTICS: large cells = sampling gaps makes MWT's "raw tiles" idea
  measurable.
- **Arc:** the outline's line 3 states the limit (no outside information); the Kipuka Puaulu result
  overcomes it (canopy structure is the outside information). State the limit early, resolve it
  late.
- Friction: a few lines of `sf` / `terra`; show the code.

## Chapter plan (Kim approved the structure, 2026-09-25 afternoon)
Organising question (Kim): **are Voronoi tessellations useful in the research fields I inhabit?** Each chapter
tests part of it; ch.10 answers. Arnold & Milne (1984) run through as a benchmark: what they did, or could not, then.
1. **The map that never got drawn.** OPENING (Kim's design): a simple Voronoi map, then a hand-drawn vegetation
   map; pose -- can Voronoi tessellations make maps with the border complexity of hand-drawn vegetation maps? --
   and leave it UNANSWERED, as tension to carry the reader. Then Kim's story (colleagues' fieldwork stalling at
   the map; scribing, ruby scribes, darkroom and large-format camera; pen plotters; an article with code in the
   wrong language; the shelf; a usable implementation years later) and the Arnold & Milne reprint from his
   separates library. Simple map = plain Voronoi of Kipuka Puaulu; hand-drawn map = the 1974 map (permission:
   Kim says no problem getting it).
2. **What a Voronoi map is.** Points + categories + border; halfway; markets / schools vs releves. Arnold & Milne:
   the soil cartographer's 'sphere of influence' IS a Voronoi tessellation at dense sampling.
3. **The study area.** Bounded / unbounded; edge cells.
4. **Kinds of Voronoi maps.** Kim's taxonomy; raw vs merged (Arnold & Milne's Fig. 8-10 did this in 1984).
5. **Reading the cells.** Per-cell statistics; patterns; boundary uncertainty ~ half the spacing.
6. **Tiles as containers.** Counting frame (Koch; invasives; herbarium specimens).
7. **Weighted Voronoi.** DRAFTED 2026-09-26 with Kim's five LA basin gardens: plain / by acres / by Wikipedia pageviews; census tracts as containers; attendance check; travel time as the bridge to ch.8.
8. **Adding what the points don't know.** DRAFTED 2026-09-26: Meta/WRI canopy height; 4 structure classes (25 m smoothing, 2/5/10 m, 2 ha MMU); outline traced; structure-constrained Voronoi; label-vs-canopy check; limits. Credit
   Arnold & Milne for the hybrid IDEA (clip to towns/rivers; merge surveyor polygons with tiles).
9. **Good enough?** DRAFTED 2026-09-26: 1974 map as data; area vs boundary agreement; releve curve (random vs stratified); change vs method; Johnston's 52%; verdict from Kim's conclusion.
10. **Were they useful?** DRAFTED 2026-09-26 (plain is enough when boundaries aren't critical; archives with metadata; field by field; method + data source). Field by field (incl. **ethnobotany** -- Kim: the first readers will be ethnobotanists); where the friction went. Careful claim: shown in soils in 1984,
    published in a graphics journal, not seen in vegetation mapping -- 'I didn't see them', not 'nobody used them'.
Appendix: functions + data sources (-> package).

## The expert-map check (2026-09-25 afternoon)
**Source:** Mueller-Dombois & Fosberg 1974, *Vegetation Map of Hawaii Volcanoes National Park (at 1:52,000)*,
CPSU/UH Tech. Rept. 4. Drawn by Fosberg indoors from 1954 air photos (1:12,000), field-checked by Mueller-Dombois
1965, ~20% by photo-pattern matching alone, boundaries hand-transferred by T. Nakata. Units are dominance types;
**scrub/forest split at ~5 m, open/closed at ~60% crown cover -- canopy measures.** Kipuka Puaulu = type 8
`AcSaM(ad)` ('Kipuka Ki and Puaulu forests'). Report: 162 releves 'located on the basis of the mapped vegetation
units' (preferential; squares 19, 20, 38, 39, 62 near the kipuka). Report notice restricts open-literature use
without UH/NPS Unit permission -- Kim: no problem getting it.
**Method:** vegetation overlays of sheets 12 + 13 (Kipuka Puaulu sits on the seam) extracted from the PDF at
native resolution (~4.4 m/px); homography from the four corner marks (7.5' x 3.75' sheets); polygons = regions
between lines, text holes merged; 69 regions coded by symbol and grouped into 7 classes; Old Hawaiian Datum ->
WGS 84 by PROJ (~285 m E, ~345 m S). Kipuka Ki's outline is open in the scan -- left uncoded (1.4% of window).
**Registration: the 1954 boundaries sit on today's canopy edges** (kipuka ring, the small southern kipuka).
**Results (window 3.2 x 2.6 km):**
- 1974 class vs today's structure: Kipuka forest 62% in the >10 m class (median 11.4 m); scrub 91% open today.
- 12 prototype releves relabelled with the 1974 class: plain Voronoi 45% agreement, within-structure 55%.
- **Boundary recall: 70% of the expert boundary lies within 50 m of a within-structure boundary vs 17% for
  plain Voronoi.** But the constrained map draws 137 km of boundary vs the expert's 51 km -- too fragmented;
  a minimum mapping unit nearer the expert's is the obvious next knob.
- **Releve-number curve** (6-192 releves, 20 draws): with releves STRATIFIED by canopy structure, the
  constrained map leads through ~48 releves (6: 59% vs 47%; 24: 66% vs 60%) and the two converge by ~96.
  With RANDOM releves plain Voronoi matches or beats it from 12 up. Structure alone plateaus at ~64%.
  Reading: canopy structure pays most when releves are few and placed by structure -- the 'fewer releves'
  claim holds in that regime, not in general. Some of the gap is 70 years of change (e.g. the fire east of
  the kipuka) and floristic splits inside one structure class; Kim: early check on the technology, not now.

## Minimum mapping unit (2026-09-25 evening; Kim chose this over real releve sites)
Tested MMU 0.25-16 ha (terra::sieve) on the structure classes (A), on the output map (B), and both; 12 releves
with 1974 classes. The expert map's own class patches: smallest interior ~1.8 ha, median ~11 ha.
- **A+B at 2 ha:** 107 km of boundary, 56% area agreement, 58% of the expert boundary recovered within 50 m, 54%
  of drawn boundary on an expert line. **At 8 ha:** 58 km, 60%, 35%, 56%. **At 16 ha:** 52 km (= expert's 51),
  61%, 32%, 57%. Area agreement and precision creep up; recall falls fast. **MMU is a scale choice, not a fix.**
- **Why:** today's canopy edges (4 classes, 0.25 ha) lie within 50 m of **81%** of the expert's lines -- the
  expert's boundaries are largely structural -- but only **~52-60%** of canopy edges lie on an expert line, at
  ANY MMU. Recasting the classes as the 1974 rules (crown cover of >5 m trees in a 25 m radius; open/closed at
  60%) does not change that (recall 0.80, precision 0.47 at 0.25 ha). The surplus edges are the expert's
  generalised mosaics (savanna `mx-` units are 53% closed canopy today) and change since 1954 -- not speckle.
- Candidate default for the document: ~2 ha, stated as the map's scale, with the trade-off figure shown.

## Locations
- Code: G:\My Drive\Projects\Voronoi (bucket 2) -- `prototype/` holds the first script
- Data: none stored; canopy height streamed on demand (Meta/WRI, AWS `dataforgood-fb-data`)
- Docs/output: not yet
- GitHub: not yet

## Key Files
- prototype/canopy_voronoi_prototype_v1.R -- the structure-constrained Voronoi prototype, reproducible end to end
- prototype/kipuka_puaulu_prototype_v2.png -- three panels: canopy height / plain Voronoi / within structure class
- prototype/prototype_objects.rds -- rasters and releves from the run (terra objects wrapped)
- notes/Voronoi_thoughts_2026-09-25.txt -- Kim's outline, verbatim as uploaded
- references/ -- Arnold & Milne 1984; Mueller-Dombois & Fosberg 1974; Johnston et al. 1996 (Pokegama wetland: Thiessen polygons from 81 points vs airborne video, 52% correspondence -- held for Ch.9); Kim's sheet-12 composite
- expert_map/ -- digitised 1974 map (asc grids, region codes CSV), georef + coding scripts (Python), expert_overlay_v1.R, releve_curve_2026-09-25.rds
- prototype/expert_overlay_v1.png, prototype/releve_curve_v1.png -- the check's two figures
- prototype/mmu_tradeoff_v1.png; expert_map/mmu_results_2026-09-25.rds -- the MMU test
- **The book (Quarto, project root):** `_quarto.yml`, `index.qmd` (Preface), `where_the_map_stopped.qmd` (Ch.1),
  `what_is_a_voronoi_map.qmd` (Ch.2), `the_study_area.qmd` (Ch.3), `kinds_of_voronoi_maps.qmd` (Ch.4), `reading_the_cells.qmd` (Ch.5), `tiles_as_containers.qmd` (Ch.6), `weighted_voronoi.qmd` (Ch.7), `adding_what_the_points_dont_know.qmd` (Ch.8), `good_enough.qmd` (Ch.9), `were_they_useful.qmd` (Ch.10); `data/mdf1974_classes.tif` + `.csv` (Ch.9, made by `R/make_mdf1974_data.R`); `data/kipuka_puaulu_canopy_height.tif` (Ch.8, made by `R/make_kipuka_canopy_data.R`); `data/la_gardens.csv`, `data/la_land_frame.geojson`, `data/la_tracts_2020.csv` (Ch.7, made by `R/make_la_gardens_data.R`); `data/kipuka_puaulu_releves.csv`, `data/kipuka_puaulu_study_area.csv`, `data/kipuka_puaulu_outline.geojson` (canopy > 8 m, 94.5 ha);
  `images/` (Ch.1 figures); `R/fig_ch1_voronoi.R`; `background/drafting_notes.md` (status, rulings, KIM questions, verify list).
  Renders clean to `_output/` (0 chunk errors, 5 gt tables, 3 figures).

## Related Projects
- **Maps with Tiles (MWT)** -- trilogy document, capture only (`ideas_three_documents.md`). MWT
  keeps the concept (the missing map) and ONE worked Voronoi example, Kipuka Puaulu, used as
  argument in its overlay chapter; the mechanics live here. See the 2026-09-25 section of the ideas
  file.
- **proj_Koch_voronoi.md** -- Paused (Tom Koch, epidemiology, Phase 1 simulated). Its Next Steps 5-6
  (test on ecology / vegetation data; general documentation across domains) are taken up HERE.
  Koch's work becomes one domain, credited as a collaboration; this project does NOT wait on his
  data or timing. Existing code: `Projects\Koch_voronoi\voronoi_functions.R`.
- **specimen_labels / vouchr** -- source of the canopy route and the Kipuka Puaulu photo fixes.
- **checklists / checklistr** -- herbarium points; a candidate counting-frame dataset.

## Next Steps
0. **BOOK (2026-09-26 close):** all ten chapters drafted. Remaining: cover + logo (Kim's images), appendix (functions + data sources), verify list in `background/drafting_notes.md`, Preface acknowledgements + 1974-map permission, read-through. Items 1-5 below predate the book.
1. ~~Minimum mapping unit~~ DONE 2026-09-25 evening (scale choice, not a fix). Next knob: mosaic/texture classes that match the expert's `mx-` units, or accept and explain.
2. Boundary metrics in the releve-number curve, not only area agreement.
3. Real releve locations: the report's numbered sites; categories from their own records (Newell 1968?), not the map.
4. Read `Koch_voronoi\voronoi_functions.R`; decide what carries into a package.
5. Chapter 1 draft: the two maps and the open question; then Kim's story.

## Collaborators / Dependencies
Tom Koch (credit for the epidemiological Voronoi work; not a dependency).

## Blockers
None.

---
## Log
### 2026-09-25
Project opened. Prototype built and accepted at Kipuka Puaulu; Kim ruled a separate Voronoi document,
finished before the trilogy discusses the technology. Set as Active Focus. Session detail:
`session_log.md` 2026-09-25.
### 2026-09-25 (afternoon)
Chapter plan approved (opening with the unanswered question, Kim's design). Arnold & Milne 1984 filed as the
running benchmark. Kim found the 1974 Mueller-Dombois & Fosberg map; digitised and georeferenced; first overlay
and releve-number curve run. Detail in the section 'The expert-map check'.
### 2026-09-25 (evening)
MMU test run at Kim's choice; result: trade-off, not a fix; the expert's lines sit on canopy edges (81%) but
half the canopy edges are generalised or changed since 1954. Figure: prototype/mmu_tradeoff_v1.png.
### 2026-09-25 (night)
Kim accepted the 2 ha MMU for this area and turned to the document. Title ruled: *The Map That Never Got Drawn*;
source at the project root. Preface, Ch.1 (Where the Map Stopped) and Ch.2 (What a Voronoi Map Is) drafted and
rendered; three KIM questions left as HTML comments (decade/article/languages; same article as Arnold & Milne?;
acknowledgements and permission note).
Kim's notes (night): awareness began with the 1984 article; code FORTRAN -> BASIC 'if memory serves'; add ethnobotany
(first readers are ethnobotanists); US spelling ('color'). Johnston et al. 1996 added from Kim's files and cited in Ch.1.
### 2026-09-26
Altimeter story added to Ch.1 (beside Johnston's GPS passage). Ch.3 *The Study Area* drafted and rendering clean:
frame of convenience vs meaningful boundary; edge tiles (10 of 12 touch the frame; enlarging it 500 m changes 9, all
edge tiles); the kipuka outline (canopy > 8 m) and two ways to map it -- tessellate all then clip (outside points claim
~21%) vs inside points only.
Ch.3 revised with Kim's notes (ahupuaʻa still being marked in neighborhoods; canopy tracing = what was once done by hand);
Kim: the study-area chapter is 'very important... You've elevated it to the right level.' Ch.4 *Kinds of Voronoi Maps* drafted:
one tile per point (traps; largest tile ~7x smallest), named districts, shared categories merged (12 tiles -> 6 patches, 2
resting on one sample), raw vs merged with tile edges drawn over patches, merging at a coarser level (Arnold & Milne's
'criteria other than equality').
Kim on Ch.4: 'exactly the style that's needed' (brief, maps carry the points). Ch.5 *Reading the Cells* drafted: six per-tile
measures from Kim's outline (area, border, nearest/farthest, neighbors, shared border) with Arnold & Milne's spacing audit;
pattern via CV of interior tile area (even 0.07 / random 0.46 / clustered 1.46; 20 random trials 0.43-0.63); boundary
uncertainty bands of half the sample spacing (15 boundaries, +/-170 to 629 m; 59% of the window within a band).
Ch.6 *Tiles as Containers* drafted with herbarium specimens (Kim's choice; ties to checklists/Briefing Books): counting frame =
window inside the 2 km query circle (85%); 87 specimens, 25 rounded; tile R08 17 -> 0 without rounded coordinates (the pile-up rule:
location error must be small against the tile); by type, kipuka forest 2.6x area-expected, ohia forest/scrub ~0; grass-and-savanna
tops the list because R12's tile covers the kipuka's south end -- 'the label on the container is wrong', pointing to Ch.8.
Ch.7 *Weighted Voronoi* drafted -- a break from the kipuka, with Kim's five LA basin gardens (Arboretum, Descanso, Huntington,
South Coast, California Botanic Garden; his photo-essay gardens). One rule (distance / weight) on a 500 m land grid, three weights:
equal, acres, 2024 Wikipedia pageviews. 2020 tracts (3,207; 13.8 M people) as containers. Unexpected results kept as the point
(Kim: 'data exploration has a new tool'): by acres the strongest garden (Descanso) reappears along the coast past the Arboretum;
by pageviews the Huntington (article = whole institution, ~7x the next) takes 13.5 M of 13.8 M. Attendance check: Arboretum 0.52,
Huntington 0.48 visits per resident of the plain service area. Attendance and acreage sources added to the verify list.
Kim on Ch.7: works as is, frame edge fine, no changes. Ch.8 *Adding What the Points Don't Know* drafted: Arnold & Milne's
overwrite/surveyor-polygon idea as precedent; Meta/WRI canopy saved as data (5 m, script); Fosberg's own rules were canopy measures;
structure classes at 2 ha MMU; kipuka outline re-derived in the chapter (94.5 ha); structure-constrained map differs from plain on 51%
of the area. Honest findings kept: R01 and R12 labels contradict today's canopy (R12 spreads 'grass' in tall forest; KIM question on what
happened there); same-class halfway lines remain (NW open lava R01/R02; R11/R12 in the kipuka); R08 labels the NE woodland belt grass;
11% of area in unsampled patches, shown faded. Ch.6 R12 wording corrected ('what the 1974 map shows as').
Kim supplied history (Loh et al. 2007 Broomsedge Fire; Stone & Pratt 1994 grazing) -- now in references/ and in Ch.8: the R12/R08
mismatches are 1954 names on today's canopy (koa regrowth after cattle; fire recovery east). R01 still open. Ch.9 must treat the 1974
comparison as change + method, not method alone.
Kim answered the Ch.8 questions (R04/R05 in the Broomsedge burn near the koa outplanting; R01 maybe the 1975 fire) and set a principle:
results should provoke sharper questions, not end the examination. Ch.8 now closes its label section with four such questions.
Ch.9 *Good Enough?* drafted (Kim: craft the ideas, not his words): the 1974 map as a dated benchmark, not an answer key; plain vs
constrained: area 45 -> 56%, 1974 boundary found 17 -> 58%; releve curve: canopy does the work of ~half the releves when few and stratified,
no gain with random points; change (15% of area) explains ~a quarter of the disagreement; Johnston's 52% as yardstick. Verdict: alone not
good enough; combined with other data it is; reproducible where hand-drawn maps hid their judgments; mismatches lead to 'why?' and new data.
Ch.10 *Were They Useful?* drafted from Kim's notes: plain Voronoi is sometimes essential when boundaries needn't be exact (outbreak source,
new school, Snow's 1855 pump line); when boundaries matter, add data that knows where edges are; maps as archives (points + rules +
metadata in a GeoPackage, rebuilt any time -- contrast the 1974 map's digitizing); field-by-field table; two take-aways: method + data source.
All ten chapters now drafted.
