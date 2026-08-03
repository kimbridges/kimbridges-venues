# PROJECT: checklistr
_Last updated: 2026-07-16_
_Status: Complete_
_Focus readiness: Not applicable_
_Tags: (none)_

**COMPLETE & PUBLISHED (2026-07-09).** Both deliverables shipped. The **package** is live on GitHub (github.com/kimbridges/checklistr; R CMD check 0/0/1, tests green, 26 exported fns), and the companion Quarto **book "A Checklist Is an Argument"** — jointly bylined *K. W. Bridges and Claude (Anthropic)* — is live at **https://kimbridges-documents.netlify.app/checklistr/** (Preface + 10 chapters + appendix; 11/11 render; live figures, two island street-basemap maps, cover + navbar logo). Closed per the posted-on-website Complete rule. Full session narrative in `session_log.md` (2026-07-09).

## Type
R package (companion engine to the `checklists` exploration)

## Objective
Package the tested tools from the `checklists` exploration into a reusable R
package so the flora and collecting history of any location can be examined and
compared. Given a point + radius (or polygon) and a taxon, `checklistr` pulls GBIF
preserved-specimen (herbarium) records and runs them through: collector
consolidation, herbarium **dedup** (BISH/BPBM = one Bishop Museum), **determination-
conflict** detection, and four analytical lenses — collector/date profiles, species
accumulation + inventory completeness, and collector×taxa composition/contributions.
Philosophy: herbarium data is opportunistic, so the package **surfaces** duplication,
determination conflicts, and digitization gaps rather than hiding them. Follows the
explore→package arc (lists→listsr, seasonality→seasonalityr, Ceska→coenosr).

## Current Status
**Scaffolded, documented, checked, and tested in one session (2026-07-05), live in
RStudio.** `R CMD check` = **0 errors / 0 warnings / 1 note** (the note is only the
environment's "unable to verify current time"). testthat: **24 tests pass**. 18
exported functions across 7 modules; roxygen docs + man pages + NAMESPACE generated;
MIT, joint authorship. `pkgload::load_all()` runs the full Kīpuka Puaulu pipeline end
to end. **Not yet:** the checklist *build* itself (facet → accepted-species checklist
with status) is NOT in the package yet — that step is still the hand-normalized
`build_checklist.py` in `checklists`; generalizing it (GBIF-backbone/WCVP synonym
resolution + a status lookup) is the main remaining piece. GitHub push pending (Kim).
**Validated on a second site (2026-07-05):** ran clean on ʻIliau Loop Trail, Kauaʻi — a dry, mainland-
herbaria-dominated, modern-collector flora that contrasts sharply with Kīpuka Puaulu (see proj_checklists.md
cont. 6). First real proof the tools generalize across locations.

## Locations
- Code: G:\My Drive\Projects\checklistr\  (R/, man/, tests/, DESCRIPTION, NAMESPACE)
- GitHub: **LIVE — https://github.com/kimbridges/checklistr** (pushed 2026-07-08; `remotes::install_github("kimbridges/checklistr")`)

## Key Files
- R/fetch.R — `fetch_specimens_gbif()`, `circle_wkt()`
- R/collectors.R — `primary_collector()`, `add_primary_collector()`
- R/dedup.R — `dedup_specimens()`, `normalize_institution()`, `clean_record_number()`
- R/conflicts.R — `detect_det_conflicts()` (run on RAW records, before dedup)
- R/profile.R — `collector_profile()`, `plot_collecting_history()`, `plot_collector_activity()`
- R/accumulation.R — `species_discovery()`, `richness_estimate()`, `plot_species_discovery()`, `plot_accumulation()`
- R/composition.R — `add_checklist_status()`, `plot_collector_composition()`, `collector_contributions()`
- R/map.R — `map_specimens()` (specimen-locality map; optional hillshade basemap via elevatr/terra, in Suggests)
- R/build.R — `build_checklist()` (raw records → accepted-species checklist: names via GBIF backbone, dedup, det_conflict, + genus-only rows)
- R/lifeform.R — `gift_growthform()` (download/cache GIFT trait 1.2.1) + `add_lifeform()` (fern/graminoid/tree/shrub/herb, with source tracking)
- R/status.R — `add_status()` (pluggable overlay + `verify_against=`/`status_agree` disagreement flag) + `status_gift()` (GIFT-derived global default) + `crosswalk_gbif()` (resolve a source's names to the GBIF backbone)
- R/checklistr-package.R (imports), R/globals.R (NSE globals)
- tests/testthat/ — pure-function tests (collectors, dedup, conflicts, circle_wkt)

## Related Projects
Extracted from **checklists** (proj_checklists.md) — the exploration and the first
worked site (Kīpuka Puaulu), which remains the demonstrator/validation. Sibling in the
field-botany domain: **specimen_labels / vouchr** (proj_specimen_labels.md); the
collector-consolidation idea is shared with vouchr's `label_survey`.

## Next Steps
**Engine feature-complete, checked (0/0/1), and LIVE on GitHub (2026-07-08).** The coding + GitHub business is
behind us. **NEXT = the Quarto document.**
1. ~~`add_status()` + `status_gift()` + crosswalk + disagreement flag + GitHub~~ — **ALL DONE (2026-07-06 →
   2026-07-08).** `verify_against=`/`status_agree`, `crosswalk_gbif()`, cache fix, R CMD check 0/0/1, pushed to
   github.com/kimbridges/checklistr.
2. ~~Explore contrasting locations~~ — STARTED: ʻIliau Loop, Kauaʻi (add more when useful).
3. **Quarto document** — the next focus. Framing (Kim): the casual-question → package → two-site-contrast
   story; the honest-data-caveats angle; digitization-gap motivation; and the spine **"conflict = where experts
   disagree"** (det_conflict + status_agree as a map of contested botanical knowledge). Two Kim quotes captured
   in session_log 2026-07-06 for the motivation. Follows the arc (lists→doc, seasonality→book).
5. **Selectable map basemaps** (Kim's request, 2026-07-06): the hillshade is hard to orient to real
   features — add a `basemap =` choice (streets / trails / topo / satellite / hillshade) so collection
   points can be checked against highways and trails. Candidates: `maptiles` (static ggplot: OpenStreetMap,
   OpenTopoMap, Esri.WorldImagery) or a `leaflet` interactive variant (installed; OSM roads, OpenTopoMap
   trails/contours, Esri satellite, Thunderforest.Outdoors trails). Good honesty cross-check on the nominal
   georeferencing.

## Collaborators / Dependencies
Data: GBIF (rgbif). Estimators: vegan. Taxonomy/status references: Wagner, Herbst &
Sohmer; Palmer.

## Blockers
None.

---
## Log
### 2026-07-05 (intake — package scaffolded from the checklists tools)
After building and validating the specimen-level tools live on Kīpuka Puaulu (see
proj_checklists.md cont. 1–5), Kim's call: "we have a good set of basic tools — start the
scaffolding," so that exploring other locations for contrast becomes a one-liner. Scaffolded
**checklistr** at G:\My Drive\Projects\checklistr: DESCRIPTION/LICENSE/README, 7 R/ modules
with roxygen, package doc + globals, testthat suite. Developed live in RStudio via the
r-studio/ClaudeR bridge (roxygenise → load_all → check → test). The smoke test caught a real
usage ordering point (`detect_det_conflicts` must run BEFORE `dedup_specimens`, since dedup
removes the duplicate rows carrying the conflicting dets — documented). A test caught a tidiness
bug (`vapply` attaching input strings as names to the `collector` column → `USE.NAMES=FALSE`).
Cleared a non-ASCII warning (curly apostrophe in a regex → `’` escape) and import/global
notes. Final: **0/0/1, 24 tests pass**. Intake protocol exercised: this file created; Active R
Projects row added; Active Focus pointer + session_log updated. Sibling of checklists.

### 2026-07-06 — map lens added (`map_specimens()`)
Added the specimen-locality **map** (Kim's suggestion). Added `coordinateUncertaintyInMeters` to the fetch;
new `R/map.R::map_specimens()` — distinct localities sized by stacked-record count, coloured by median year,
over an optional **hillshade** (elevatr + terra, both in Suggests, gated by `requireNamespace` + `tryCatch` so
the package stays light and works without them). Honest by design: caption reports records → distinct-points,
the top-stacked point, and stated coordinate uncertainty. **Finding — georeferencing style is itself a
signal:** Kīpuka Puaulu = **379 records → 63 points, top point 58** (heavy nominal gazetteer stacking, old
survey era; ~1.25 km median stated uncertainty, only 22% report it); ʻIliau Loop = **66 → 36 points, top 8**
(dispersed, precise, modern GPS-era collecting). Figures `kipuka_puaulu/fig_specimen_map.png`,
`iliau_loop/fig_specimen_map_iliau.png`. `load_all()` + testthat 24/24 green; **full `R CMD check` re-run
pending** (the check overran the RStudio-bridge timeout this session — not a package problem). Next (still):
the checklist build with lifeform.

### 2026-07-06 — THE KEYSTONE: `build_checklist()` + lifeform (checklist can now be GENERATED)
The missing piece is done — a checklist can be *generated* for any site, no hand-normalization.
**Name resolution:** GBIF's own backbone (`species` field) already collapses synonyms + infraspecifics to
accepted species, so no WCVP re-resolution needed — 379 Kīpuka records → 150 accepted species (exact match
to the hand-built list). `build_checklist(raw)` detects conflicts on raw, dedups (institution) for honest
counts, groups to accepted species (+ genus-only rows), flags `det_conflict` — all automatic (conflicts are
now in GBIF-accepted space, so no hand-mapping). **Lifeform:** Kim chose **GIFT**; installed 1.3.3. Growth
form = trait 1.2.1 (herb/shrub/tree, 166,974 spp.), pulled once via a **background async job** and cached to
`data-raw/gift_growthform.rds` (the sync pull kept blocking the console + dropping the ClaudeR bridge — a full
RStudio restart fixed it; async is the lesson). `add_lifeform()` → controlled vocab **fern / graminoid / tree
/ shrub / herb**: ferns (by class) and graminoids (Poaceae/Cyperaceae/…) from the clade; the rest from GIFT
species, else **genus modal** fallback; `lifeform_source` records how each was derived. **100% coverage** on
both sites (Kīpuka 77 gift-species / 19 gift-genus / 54 clade). **Ecological signal already:** the dry ʻIliau
flora has fewer ferns (14% vs 20%) and more herbs than the mesic kīpuka. Generated checklists saved:
`kipuka_puaulu_checklist_generated.csv`, `iliau_loop_checklist_generated.csv`. GIFT added to Suggests;
testthat 24/24 green; 23 exported fns. **Remaining:** native/alien **status** is the last field — regional,
needs an authority (Hawai‘i: Wagner/Palmer or a Bishop Museum list); currently pluggable/blank for new sites.
Full R CMD check still to be re-run (bridge timeout).

### 2026-07-06 (cont.) — `add_status()` mechanism (native/alien as a regional overlay)
Design discussion with Kim first: status is a **species×place relation**, not a species property, so baking a
Hawai‘i table into the engine would make it parochial. Agreed approach: a **general pluggable mechanism** +
(intended) a coarse global native/introduced default; the fine Hawaiian categories (E/I/Pol/Nat/Cult) are a
**regional overlay** from an authority. Built `add_status(checklist, source)` where `source` is a
data.frame(accepted_name, status) or a function — dependency-free, messages the match rate. **Proven** by
overlaying the curated Hawai‘i statuses onto the *generated* Kīpuka checklist: **85% matched**; the 15% miss
are **GBIF-backbone vs Wagner accepted-name differences** (e.g. *Sadleria pallida* vs *rigida*, *Ceodes
brunoniana* vs *Pisonia*, *Leptecophylla* vs *Styphelia tameiameiae*, *Odontosoria* vs *Sphenomeris*) — a key
documentation point for the Quarto doc and an argument for a synonym-aware crosswalk. The **generated checklist
now carries every field**: accepted_name, family, class, n_records, rank, det_conflict, lifeform,
lifeform_source, status (`kipuka_puaulu_checklist_generated.csv`). **Blocker found:** the intended POWO API
default is **Cloudflare-blocked** (403 challenge on direct calls); the global default will come from GIFT
(async) or offline rWCVPdata next. testthat 24/24; 24 exported fns. Kim flagged (rightly) that the whole
status question needs careful documentation in the Quarto doc.

### 2026-07-06 (cont. 2) — GIFT global status default + the verification payoff
Kim chose to build the global default now, framing it as "a story in itself... moving targets... we want to
verify existing data and add data where there are gaps — gaps in collections AND in our understanding of
species histories and evolutionary relationships. The tools give new access to centuries of both collections
and botanical insight." (Keep for the Quarto doc's motivation.) **POWO API is Cloudflare-blocked, so used
GIFT** (installed). Found Hawai‘i via `GIFT_regions()` (entity 1043/10694); its lists via `GIFT_lists()`:
**all-flora list 12927 (native flag) + endemic list 16075**. Pulled both via a background async job (cached
to `data-raw/`). Built **`status_gift(all_list_ID, endemic_list_ID, cache_dir)`** → endemic / indigenous /
introduced (2,440 Hawaiian spp.; 880 endemics). Also built a **synonym crosswalk** via
`rgbif::name_backbone_checklist()` (helps ~partially: 85→88% — residual is GBIF's OWN occurrence-vs-backbone
name skew, e.g. *Ceodes* vs *Pisonia brunoniana* — itself a finding). **THE PAYOFF — GIFT vs the curated
Wagner authority on the Kīpuka checklist: 97/111 agree (87%); the 14 disagreements are interpretable and
cluster into two failure modes of the global source** — (a) it **under-calls fern endemism** (*Cyanea
floribunda*, *Cibotium glaucum*, *Dryopteris fuscoatra/hawaiiensis*, *Asplenium macraei* = endemic per Wagner,
not per GIFT) and (b) it **mis-flags pantropical natives as introduced** (*Dodonaea viscosa*, *Persicaria
punctata*, *Pteris cretica*, *Nephrolepis biserrata/cordifolia*, *Ipomoea indica* = indigenous per Wagner).
This is the project thesis made concrete: the global default gets ~87% and the disagreements *point a
specialist at exactly the taxa that need a regional eye*. Saved `kipuka_puaulu_checklist_generated.csv` (now
with gift_status + wagner_status + status_agree) and `status_gift_vs_wagner_disagreements.csv`. testthat 24/24;
25 exported fns. Remaining: fold a disagreement-flag into add_status; firm up the crosswalk; R CMD check re-run.

### 2026-07-08 — refinements cleared + LIVE on GitHub (coding done)
Kim back (with a cold); goal = clear the small refinements + GitHub, then move to the Quarto doc. All done:
- **Disagreement flag folded into `add_status()`**: new `verify_against=` (a second status source) + `normalize=`
  (default coarsens any vocabulary to native/introduced) → adds `status_check` + **`status_agree`**, so the
  "where experts disagree" taxa are a first-class output. Verified: *Dodonaea* (Wagner indigenous vs GIFT
  introduced) flags FALSE; true agreements stay TRUE. New test-status.R (2 tests).
- **`crosswalk_gbif()`** added — resolves a status source's names to the GBIF backbone via
  `name_backbone_checklist()` so it joins a `build_checklist()` output more completely (imperfect; GBIF's own
  occurrence-vs-matcher skew remains, documented).
- **`status_gift()` cache fix**: copied the cached GIFT lists to the `gift_list_<id>.rds` names it expects →
  reads cache instantly instead of re-downloading.
- **Full `R CMD check` re-run (as a background async job — the reliable way past the bridge timeout): 0 errors /
  0 warnings / 1 note** (only the benign clock note). Fixed en route: a roxygen mis-attachment (internal
  `status_native` sat between add_status's doc block and the fn → moved above it) and `.Rbuildignore`d `data-raw`.
- **Pushed to GitHub — https://github.com/kimbridges/checklistr** (public, matching the other packages; via
  gert + gh with Kim's configured PAT; `data-raw/` git-ignored so the large GIFT caches stay out of the repo).
  51 files, initial commit, README/R/man/tests all on the remote. **26 exported fns, tests + check green.**
The engine is now feature-complete, checked, and public. **Next: the Quarto document** (coding + GitHub behind us).

### 2026-07-08 (cont.) — Quarto document started: "A Checklist Is an Argument"
Agreed the spine, title, and home. Title **"A Checklist Is an Argument"**; conceptual-base-dominant register
(like whittakerr); lives in `checklistr/documentation/`, publishes to kimbridges-documents. Read the house
style guide (style_multichapter_doc.md) and will follow it (Quarto book, code-fold, repeated setup chunk,
gt tables, one-figure-per-width stacked, function-reference appendix, ideation-file-per-conceptual-chapter).
**Kim added the intellectual core (Ch. 3 "The question of scale"):** a herbarium is a *taxonomic* accumulation
over a region, not an *ecological* census of a point — collectors gather one representative per taxon per
region, not at every site — which is why the singletons pile up, why the estimators' assumptions break, and
why the map is the key instrument (nominal-locality stacking = that collecting habit made visible). Created
`documentation/doc_plan.md` (spine, 9-chapter scaffold + appendix, figure/data manifest, Kim's framing quotes),
`documentation/_quarto.yml` (book config), and a drafted **Preface** (`index.qmd`) — states the thesis, the two
conflict flavors, and the scale point. Awaiting Kim's reaction to the Preface before scaffolding the chapter
stubs + ideation files. Chapters: the-question / collectors / scale / completeness / conflict / lifeform /
status / two-islands / limits (+ appendix).
**Preface APPROVED (2026-07-08).** After the first draft, Kim gave the document its **origin story**, now the
Preface opening: decades of walking the Kīpuka Puaulu loop; once taught students the name of nearly every plant
on the trail (in a single walk); visits less now and memory of some names has faded — so he reached for a
checklist and found there's no easy way to get one for a *particular* place. That question is where the project
began — and not just for Kīpuka: for other familiar places, and unvisited ones. Rewrote the Preface to open on
the trail; added the **"two readers" theme** (the list serves both the one who knows the flora and needs a
reminder, and the one who doesn't and must be told what's solid vs contested) and "refresh what we've forgotten"
in the close. Kim approved with one word-change ("by the end of a *walk*"). Story + theme captured in
`doc_plan.md`. **RESUME (doc drafting):** scaffold the 9 chapter stubs (so it renders) + `appendix.qmd`; copy
cached data into `documentation/data/`; open ideation files for the conceptual chapters (scale, conflict,
status); then draft chapter-by-chapter (Preface → Ch.1 → Ch.3 scale as anchors), Kim reviewing each.

### 2026-07-16 (pointer — new dated-record lenses built in the `checklists` exploration; candidates to fold in)
The reopened `checklists` focus added a **time & phenology layer** (`kipuka_puaulu/time_tools.R`): `specimen_phenology()`
(collection-month distributions + a collecting-calendar confound diagnostic) and `specimen_recency()` (first/last year,
span, native/alien first-detection curves). Built + verified live; not yet packaged. **Candidate to fold into checklistr**
as a new module (`R/time.R`), the same explore-then-package path collector_tools -> the package took. See proj_checklists.md
2026-07-16 for findings.
