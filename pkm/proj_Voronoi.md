# PROJECT: Voronoi
_Last updated: 2026-09-25_
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
1. Restructure Kim's outline into a chapter plan (Kim to rule).
2. Real categories at Kipuka Puaulu: Kim relabels the 12 points or places his own; re-run.
3. Decide the structure breaks from releve heights rather than fixed defaults.
4. Read `Koch_voronoi\voronoi_functions.R`; decide what carries into a package.
5. An expert vegetation map for an overlay check (still sought).

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
