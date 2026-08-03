# PROJECT: checklists
_Last updated: 2026-07-16_
_Status: Active_
_Focus readiness: Ready_
<!-- 2026-07-09: COMPLETE — the exploration delivered the checklistr package (GitHub) AND the document "A Checklist Is an Argument" (live at kimbridges-documents.netlify.app/checklistr/). Posted-on-website Complete rule; see proj_checklistr.md + session_log.md 2026-07-09. -->
_Tags: (none)_

## Type
R exploration → methodology (+ likely future R package + Quarto document)

## Objective
A reusable capability for building **regional plant checklists from herbarium
records**. Given a place (point + radius, or a polygon), pull preserved-specimen
(herbarium) records from aggregators — GBIF first, iDigBio and institutional
portals later — normalize the messy verbatim determinations to accepted species,
collapse synonyms and infraspecific names, assign Hawaiian (or regional)
biogeographic status, and emit a clean, auditable checklist for field studies.
The method is meant to generalize across sites; each site lives in its own
subfolder. Kīpuka Puaulu (Hawai‘i Volcanoes NP) is the first worked example.
This mirrors the arc of earlier projects (lists→listsr, seasonality→seasonalityr,
Ceska→coenosr): explore the method, then package the engine and describe it.

## Current Status
First worked site complete in draft. From a GBIF query (preserved specimens,
Plantae, 2 km around 19.437 N / 155.296 W, accessed 2026-07-05; 385 records) the
build produced **157 vascular taxa** (150 species + 7 genus-level) + 4 mosses:
**85 native** (49 endemic, 36 indigenous), 57 naturalized, 12 planted/cultivated,
3 uncertain. Bishop Museum (BISH/BPBM) supplied 224 of 385 specimens. The build
is reproducible (`build_checklist.py`) and self-checking (`verify.py` confirms the
cleaned list captures every raw GBIF name with correct summed counts — 0 missing,
0 mismatch, reconciles to all 385 records). Data quality is on-target: the endemic
*Hibiscadelphus giffardianus*, whose type locality IS Kīpuka Puaulu, is present.

Since the 2026-07-05 checklist build, a **specimen-level analysis layer** was built and
verified live in RStudio (r-studio/ClaudeR bridge, R 4.3.3, rgbif) — see Log entries
"(cont.)" and "(cont. 2)". `collector_tools.R` now fetches flowering-plant specimens for
any place/taxon, consolidates messy collector strings, and produces **collector-profile**
and **collecting-timeline** lenses; a **`dedup_specimens()`** tool handles herbarium
duplication early in the chain (institution level = the BISH/BPBM same-museum artifact;
gathering level = duplicate sheets of one event). Dedup mattered: raw 249 → 167 flowering-
plant specimens, with BISH/BPBM double-entry nearly doubling some collector counts
(Cuddihy 99 → 50). Still open: taxonomy/status in the checklist is a hand-normalization
awaiting Kim's spot-check; an 8-specimen determination-conflict flag (BISH vs BPBM IDs on
one sheet) needs carrying into the checklist layer; the toolkit is not yet generalized
into a package.

## Locations
- Code: G:\My Drive\Projects\checklists\  (per-site subfolders)
- Data: G:\My Drive\Projects\checklists\kipuka_puaulu\  (3 CSVs + provenance scripts)
- Docs/output: (none yet; a Quarto write-up is a candidate later)
- GitHub: not yet

## Key Files
- kipuka_puaulu\kipuka_puaulu_checklist.csv — cleaned checklist, one row per accepted taxon
- kipuka_puaulu\kipuka_puaulu_gbif_rawnames.csv — raw GBIF interpreted names + counts (audit trail; 194 names, 385 records)
- kipuka_puaulu\kipuka_puaulu_bryophytes.csv — the 4 moss records (GBIF Plantae includes bryophytes)
- kipuka_puaulu\build_checklist.py — reproducible normalization + build
- kipuka_puaulu\verify.py — reconciliation check (raw names ↔ cleaned list)
- kipuka_puaulu\load_checklist.R — dplyr/ggplot starting point
- kipuka_puaulu\README.md — query parameters, method, and caveats
- kipuka_puaulu\collector_tools.R — reusable specimen-level toolkit: fetch_specimens_gbif, primary_collector, **dedup_specimens** (+ normalize_institution, clean_record_number), collector_profile, plot_collecting_history, plot_collector_activity; built + verified live in RStudio
- kipuka_puaulu\kipuka_puaulu_specimens.csv — 247 flowering-plant specimen records, RAW (pre-dedup; raw + consolidated collector)
- kipuka_puaulu\kipuka_puaulu_specimens_dedup.csv — the same records after institution-level dedup (167 rows) — the honest baseline for analysis
- kipuka_puaulu\kipuka_puaulu_collectors.csv — collector profile table (pre-dedup)
- kipuka_puaulu\fig_collecting_history.png, fig_collector_activity.png — first (RAW-count) figures — the ones Kim forwarded to McClatchey; superseded
- kipuka_puaulu\fig_collecting_history_dedup.png, fig_collector_activity_dedup.png — **honest, BISH/BPBM-deduplicated figures (use these)**

## Related Projects
Sibling in the field-botany domain: **specimen_labels / vouchr**
(proj_specimen_labels.md) — the field-capture system whose `label_survey` work
already pulls GBIF `PreservedSpecimen` records via `rgbif` and reasons about
Darwin Core field occupancy. checklists is the "what's here" complement to
vouchr's "capture what I'm holding": the same herbarium-record substrate,
opposite ends of the collecting workflow. Also thematically adjacent:
Deconstructing_a_Flora (LLM-assisted botany).

## Next Steps
**RESUME HERE (2026-07-05 pause):** the checklist + the specimen-level collector/date layer
(with dedup) are built and verified live in RStudio; Kim is on a possibly-long break. To
resume, `source("G:/My Drive/Projects/checklists/kipuka_puaulu/collector_tools.R")` and run
the worked example at the bottom of that file (fetch -> add_primary_collector -> dedup_specimens).
Concrete next actions, roughly in order:
1. ~~Carry the determination-conflict flag into the checklist~~ — **DONE 2026-07-05 (cont. 3):**
   `det_conflict`/`det_conflict_note` columns added; 7 taxa flagged (5 doubtful, 2 review). Remaining
   sub-task, needs the physical Bishop sheets: resolve which name is right in each of the 3 real pairs
   (*Ludwigia*/*Hedyotis*, the two *Corylus*, the two *Pyracantha*).
2. ~~Species-accumulation + collector×taxa lenses~~ — **DONE 2026-07-05 (cont. 4 & 5):** discovery curve +
   Chao1/Chao2/jackknife completeness; collector composition-by-origin + breadth/uniqueness. All four
   specimen-level lenses now built. (Toolkit: `species_discovery`, `richness_estimate`, `plot_accumulation`,
   `add_checklist_status`, `plot_collector_composition`, `collector_contributions`.)
3. Kim spot-checks the checklist status/taxonomy calls (the `?`-flagged names + the *Castanea
   dentata* planting-vs-mislabel question).
4. **Generalize the toolkit toward a `checklistr` package** — fold in the collector-consolidation
   shared with vouchr's `label_survey`; a `checklist_from_gbif(geometry, ...)` with GBIF-backbone/WCVP
   synonym resolution + a Hawai‘i status table; keep dedup early in the chain.
5. Optional: a tight 500 m core-only run to contrast with the 2 km version; specimen mapping from
   the coordinates already pulled.

## Collaborators / Dependencies
Data: GBIF (later iDigBio, Bishop Museum portal). Taxonomy/status references:
Wagner, Herbst & Sohmer (Manual of the Flowering Plants of Hawai‘i); Palmer
(Hawai‘i's Ferns and Fern Allies).

## Blockers
None.

---
## Log
### 2026-07-05 (intake — new project opened; first worked site: Kīpuka Puaulu)
Opened in a session running on **Opus 4.8**. (Correction, 2026-07-05: an earlier
draft of this entry stated this was the planned Fable 5 trial flagged in proj_PKM.md
2026-07-02. That was my error — Kim caught it; this session is Opus 4.8 and the Fable 5
trial has not yet occurred.) Kim asked for a plant checklist of the Kīpuka Puaulu region, HAVO,
ideally from herbarium records. Built it from GBIF preserved-specimen records
(2 km radius; 385 records → 157 vascular taxa + 4 mosses; 85 native). The result
was strong enough — and the "good checklist for field studies" need general enough —
that Kim decided to log it as a new PKM project and make it the Active Focus,
framed as a **general capability** (herbarium records → regional checklist), with
Kīpuka Puaulu as the first worked site. Intake protocol exercised: this file
created, Active R Projects row added, Active Focus pointer switched to checklists,
Change Log + session_log entries added. Deliverables written to
G:\My Drive\Projects\checklists\kipuka_puaulu\ (file tools, not bash, per Finding 001).
Kim also enabled the R server (r-studio/ClaudeR bridge) this session — noted for the
generalization/live-verification steps ahead. Verification built in: `verify.py`
reconciles the cleaned list against the raw GBIF facet exactly (0 missing / 0 mismatch),
and Kim's local knowledge of the kīpuka is the second, stronger check still to run.

### 2026-07-05 (cont.) — specimen-level lenses: collectors & dates (live in RStudio, Opus 4.8)
First deepening pass, done live in Kim's RStudio via the r-studio/ClaudeR bridge (R 4.3.3,
rgbif). Kim's direction: with specimen-level data available, examine the flowering-plant
records by **collector** and **date** — and build these as **general tools**, not a one-off.
Pulled preserved-specimen **angiosperm** records (class Magnoliopsida, resolved via
`name_backbone`, not hardcoded) within the same 2 km circle → **~247–250 records** (GBIF
paging jitter around a count of 249), 1911–2024, collector 97% / year 99% complete; Bishop
Museum (BISH+BPBM) = 166 of them. Built + verified a reusable toolkit **`collector_tools.R`**:
`fetch_specimens_gbif()` (any place/taxon), `primary_collector()` (consolidates messy
recordedBy strings — "Surname, Init" vs "Given Surname", co-collector teams, "State ESP team"
annotations, name particles — **59 raw strings → 28 primary collectors**), `collector_profile()`,
and two plot lenses `plot_collecting_history()` + `plot_collector_activity()`. **Findings:**
the collecting history splits into three eras — a sparse **discovery era** (Rock 1911→,
Forbes 1915, Degener from 1929, Fosberg 1951, Carlquist 1966; taxonomic botanists), a
**1979–80 survey blitz** (HAVO Endangered Species Program team — Cuddihy 99 specimens/39 taxa,
Davis, Anderson, Clarke, Kubo), and a **scattered modern era** (Sykes, Van Riper, Long, Kiehn
into the 2010s). This mirrors the collector-archetype split from specimen_labels' deck-discovery
work. **Verification (task-case-selection principle):** Rock confirmed at the kīpuka in 1911
(a *Psychotria hawaiiensis* now at Te Papa/NMNZ); Rock's famous 1911 *Hibiscadelphus giffardianus*
type is NOT in this georeferenced pull (earliest *H. giffardianus* here is Degener 1930) — not
overclaimed. **Bonus cross-check:** Baker (1975) collected both *H. giffardianus* AND
*H. hualalaiensis* here, independently supporting the checklist's note that the Hualālai species
was outplanted at Puaulu. **Data nuance found:** BISH and BPBM are both Bishop Museum, so the same
physical specimen can appear under both codes (Rock's 1916 *Metrosideros* did) — counts are
slightly inflated; a **dedup step** (on catalogNumber/recordNumber + collector + year) is the
next refinement. New files: `collector_tools.R`, `kipuka_puaulu_specimens.csv`,
`kipuka_puaulu_collectors.csv`, `fig_collecting_history.png`, `fig_collector_activity.png`
(all saved directly from the live RStudio session to the project folder). **Next candidates:**
dedup pass; species-accumulation + collector×taxa lenses; then generalize the toolkit toward a
`checklistr` package (fold in the collector-consolidation shared with vouchr's label_survey).

### 2026-07-05 (cont. 2) — dedup as an explicit, early tool (Kim's call; he works the Bishop lot)
Kim flagged dedup as a tool in its own right, to sit **early** in the analysis chain (he'll be using
the Bishop Museum collection). Investigated the duplication structure empirically before designing:
two distinct levels. **(A) Same-museum artifact** — **BISH and BPBM are both Bishop Museum**, and
Bishop records are systematically double-entered under both codes: **82 BISH+BPBM pairs share a
catalogNumber** (confirmed same specimen — same collector/year/recordNumber). 8 of those pairs carry
**different determinations** across the two entries (mostly spelling — *Hypochoeris*/*Hypochaeris*,
*illinoensis*/*illinoinensis* — but a few real, e.g. one sheet is *Ludwigia palustris* to BISH and
*Hedyotis biflora* to BPBM); they're one physical sheet with conflicting IDs → a flag for the
**checklist** layer, not two specimens. **(B) Gathering** — true duplicate SHEETS of one collection
event distributed across herbaria, keyed by collector + **recordNumber** (88% complete; needed cleaning
— "Collector Number: 561" vs "561", leading zeros). Built **`dedup_specimens(df, level=)`** +
`normalize_institution()` + `clean_record_number()` into `collector_tools.R`, and added `recordNumber`
to the fetch. **Impact (flowering plants):** raw **249 → 167** (institution) **→ 149** (gathering);
BISH/BPBM double-entry alone was inflating totals ~⅓ and **nearly doubling Cuddihy (99 → 50 specimens)**.
Taxa 96 → 88 (the raw over-count came partly from the 8 determination conflicts). **Recommendation
adopted:** institution-level dedup is the mandatory early baseline (pure artifact, no info lost);
gathering-level is an opt-in when counting events vs sheets. **Important:** the first figures (which Kim
forwarded to Will McClatchey) used the inflated raw counts — regenerated honest versions
`fig_collector_activity_dedup.png` / `fig_collecting_history_dedup.png` (same three-era story, correctly
scaled) + `kipuka_puaulu_specimens_dedup.csv`. Next: carry the determination-conflict flag into the
checklist layer; then species-accumulation + collector×taxa lenses; then generalize toward `checklistr`.

### 2026-07-05 (cont. 3, after a break) — determination-conflict flag carried into the checklist
Formal PKM session-start run (re-read project_index.md + proj_PKM.md; Active Focus = checklists; both
files consistent). Then executed the flagged next step, live in RStudio. Added a general tool
**`detect_det_conflicts()`** to `collector_tools.R` (finds single physical sheets carrying >1 distinct
species determination). Across **all 385 Plantae** preserved specimens in the 2 km circle it found the
**8 same-sheet BISH-vs-BPBM conflicts** (all from Cuddihy/Anderson 1979–80). Classified them by mapping
each side to its checklist accepted taxon (hand-verified — GBIF genus reassignments hide some: *Eriocapitella*
= *Anemone*, *Leptopetalum* = *Hedyotis*): **4 benign** (both sides collapse to one accepted taxon —
*Hypochoeris*/*Hypochaeris*, *Cardamine occulta*/*flexuosa*, *Carya* spelling, *Eriocapitella hupehensis*/
*japonica*) and **3 real** (two genuinely different taxa on one sheet): *Ludwigia palustris* vs *Hedyotis
biflora* (sheet 656953), *Corylus cornuta* vs *C. americana* (668168), *Pyracantha koidzumii* vs
*P. angustifolia* (770507); plus *Cerastium fontanum* vs *C. glomeratum* (656108, the alt not otherwise in
the flora). Since the facet-based checklist counted the two sides of each real conflict as **separate taxa**,
one of each pair is likely a **phantom**. Added **`det_conflict` + `det_conflict_note`** columns to
`kipuka_puaulu_checklist.csv`: **7 taxa flagged** — 5 `doubtful` (sole support is a contested sheet:
*Hedyotis biflora*, *Ludwigia palustris*, *Corylus americana*, *Corylus cornuta*, *Pyracantha angustifolia*)
and 2 `review` (present, one sheet contested: *Cerastium fontanum*, *Pyracantha koidzumii*). Audit trail
`kipuka_puaulu_det_conflicts.csv`; README updated. Which name is right in each real pair needs sheet-level
examination of the Bishop specimens — a task for Kim / the physical collection, not resolvable from GBIF.
(One gotcha handled: a `readr` round-trip wrote empty cells as literal "NA"; repaired, 0 stray NA cells.)
**Focus readiness stays Ready.** Next: species-accumulation + collector×taxa lenses; then generalize toward
`checklistr` (with dedup + conflict detection built into the pipeline).

### 2026-07-05 (cont. 4) — species-accumulation & completeness (Kim: "everyone will want this")
Built two accumulation lenses on the deduped vascular flora (Tracheophyta, 2 km, institution-deduped =
**268 specimens, 150 distinct species — matches the checklist species count exactly**, a good cross-check).
Added to `collector_tools.R`: `species_discovery()`, `richness_estimate()`, `plot_species_discovery()`,
`plot_accumulation()`. **Discovery curve** (cumulative taxa by year first collected): slow to ~1970 (~35
taxa; Rock/Forbes/Degener/Fosberg/Carlquist added the canopy dominants), a near-vertical **1979–80 jump**
(the HAVO survey added ~75 taxa at once, to ~112), then a steady climb to **147 by ~2009 — no plateau**.
**Completeness:** **64% of taxa are singletons** (96/150), and the sample-based curve is still rising
steeply at 100 collecting events. Estimators (via `vegan`): Chao1 313 (48% complete), incidence Chao2 462
(32%), jackknife-1 256 (59%) — a wide, unstable band that unanimously says the record is far from complete.
**Two honesty caveats built into the tool + reported:** (1) herbarium collecting is deliberate (~one sheet
per taxon), which inflates singletons → these estimators tend to OVER-estimate; trust the direction not the
digits. (2) GBIF holds only DIGITIZED specimens — the published Kīpuka Puaulu floras (Fagerlund & Mitchell
1944 etc.) and the HAVO Research Herbarium hold more — so this measures completeness *of the GBIF record*,
i.e. a rapid "how well is this site documented online" flag, which is exactly the general, transmissible
value Kim sees. Figures `fig_species_discovery.png`, `fig_species_accumulation.png`. Next: the collector×taxa
lens, then fold everything into `checklistr`.

### 2026-07-05 (cont. 5) — collector × taxa lens (composition + overlaps)
Built the last planned lens. Added to `collector_tools.R`: `add_checklist_status()` (tags each specimen
with its checklist accepted taxon + status by matching scientificName to the checklist's verbatim names,
ASCII-folded — **100% match**, the inverse of how the facet checklist was built), `plot_collector_composition()`,
and `collector_contributions()`. **Fixed a real `primary_collector` bug** found here: "E. O. Guerrant, Jr."
parsed the suffix "Jr" as the surname → added generational-suffix stripping (Jr/Sr/II/III/IV). **Findings:**
(1) *Composition by origin* — specialist/early botanists skew strongly native (Degener 90%, Baker/Thorne/
Dawson/Islam ~100%), while the **1979–80 HAVO survey captured the invaded state** (Cuddihy 33% native,
Clarke 20%) and **Anderson is almost entirely *Cultivated*** — the collector of the planted forestry trials.
A clean quantitative echo of the collector-archetype idea from specimen_labels' deck-discovery work.
(2) *Overlaps* — **119 of ~150 taxa (79%) were collected by just one collector**; only *Metrosideros
polymorpha* was taken by 6. The record is thin and dependent: **Cuddihy uniquely contributed ~42 taxa**
(near the y=x line — almost everything Cuddihy collected, no one else did), so a large slice of the flora
rests on that single 1980 campaign — reinforcing the accumulation/completeness story (fragile, undercollected).
Figures `fig_collector_composition.png`, `fig_collector_contributions.png`. **All four specimen-level lenses
now built** (collector-profile, collecting-timeline, species-accumulation, collector×taxa) + dedup + conflict
detection. **Next: generalize into `checklistr`.**

### 2026-07-05 (cont. 6) — checklistr scaffolded; first contrast site (ʻIliau Loop, Kauaʻi)
Packaged the tools into the **checklistr** R package (own project — see proj_checklistr.md; R CMD check
0/0/1, 24 tests). Then ran the first **contrast location** to validate the package on a genuinely different
site: **ʻIliau Loop Trail, Kauaʻi** (22.05169, -159.65996; dry leeward Waimea Canyon country). Output in
`Projects\checklists\iliau_loop\`. The contrast is stark and exactly the point: **ʻIliau** — 62 deduped
specimens, 37 taxa, **1895–2025**, dominant herbarium **US (Smithsonian)** with CAS/NY (specimens dispersed
to mainland institutions, so Bishop is minor and there are **0 determination conflicts**), top collector
**Ken Wood 2011–2022** (modern NTBG era), earliest = **Heller 1895** (a *Rumex acetosella* — an alien already
present). Its discovery curve is a slow 130-year accretion with a recent Wood uptick — vs **Kīpuka Puaulu**'s
Bishop-held, single-1980-survey vertical jump (268 specimens, 150 taxa, dom BISH, 8 conflicts). Both ~65%
singletons (the universal herbarium signature), both still climbing (undercollected). Combined discovery-curve
figure `fig_discovery_iliau_vs_kipuka.png`. checklistr validated on a real second site; the per-site subfolder
convention extends cleanly (`iliau_loop\`). Next: more contrast sites and/or generalize the checklist *build*.

### 2026-07-16 (REOPENED as Active Focus — expansion begins: a TIME & PHENOLOGY layer over dated records)
Kim reopened the (published) checklist work to expand it with new aspects, and chose the **time & phenology layer** first.
Built live in RStudio (r-studio/ClaudeR, R 4.3.3, `library(checklistr)`). Two new lenses over dated preserved-specimen
records, saved as **`kipuka_puaulu/time_tools.R`** (companion to collector_tools.R; deps dplyr/tidyr/ggplot2, circular
stats computed inline — no `circular` dep). Verified on the canonical Kipuka pull (`fetch_specimens_gbif` Tracheophyta,
2 km -> 379 raw -> 268 institution-deduped, 150 species — matches the checklist).

**1. `specimen_phenology()` + `plot_phenology()`** — collection-month distributions with an HONEST collecting-calendar
confound diagnostic. Finding: the aggregate month signal is a *calendar of visits, not of flowering*. The 1979-80 survey
(42% of records) collected in Jan/Aug/Sep/Oct and NOTHING in Mar/Apr, while every other year peaks in Mar/Apr — two
disjoint collecting seasons. Calendar concentration r=0.10 (spread); 63% singletons; only **4 taxa** have >=5 dated
records, and even those are campaign-dominated (*Melicope pseudoanisata* 'peak' = 83% one year). So per-taxon phenology is
NOT extractable here — the tool reports that and shows the collecting calendar instead (rose `fig_phenology_calendar.png`).
The tool is general: at a well-collected site/taxon it returns real circular phenology stats (mean month, concentration).

**2. `specimen_recency()` + `plot_arrival_curve()` + `plot_recency_segments()`** — per-taxon first/last year, span,
years_since_last; joins `wagner_status` (87% match) so first-DETECTION curves read by origin. Key honest finding:
**first detection != arrival.** 76% of alien first-detections (34/45) fall in the single 1979-80 survey; only 2 aliens
appear before 1979 — the weeds weren't absent, just uncollected until the systematic survey. Native/alien median first-year
nearly identical (1979.5 / 1980). Earliest record = **Rock 1911 *Psychotria hawaiiensis*** (native) — matches the prior
verification note. A 'possible loss' list surfaced: 8 native taxa (mostly discovery-era single-record ferns — *Pellaea
ternifolia*, *Elaphoglossum* x2, *Asplenium macraei*, *Peperomia tetraphylla*...) last collected before 1950, honestly
framed as 'not re-collected' given the thin campaign-driven record — i.e. re-survey targets, not confirmed extirpations.
Figures `fig_arrival_curve.png`, `fig_recency_segments.png`.

**Next candidates (Kim to steer):** fold `time_tools` into checklistr (as collector_tools became the package); run the
time/recency lenses on ʻIliau (dry, modern-collector — the Heller-1895-alien counterexample) for a two-site contrast; or
move to another expansion aspect (iDigBio 2nd aggregator; conservation status + selectable basemaps; third gradient site).

### 2026-07-16 (cont.) — the 3 real determination conflicts are RESOLVABLE from online scans (BISH sheets imaged)
Follow-on from the phenology work: checked whether GBIF carries herbarium-sheet SCANS. It does (as institution-hosted
image links, not GBIF-hosted): **210 of 385 records in the Kipuka circle (55%) are imaged, led by BISH = 106**. Crucially,
**all 3 real determination-conflict sheets — plus the Cerastium review case — have BISH scans**, so the conflicts Kim
flagged 2026-07-05 as 'needs the physical Bishop sheets' can now be examined WITHOUT handling the specimens:
  * 656953  Ludwigia palustris (BISH) vs Hedyotis/Leptopetalum biflorum (BPBM)  [gross: Onagraceae vs Rubiaceae]  BISH 5956572100  BISH1134728.webp
  * 668168  Corylus cornuta (BISH) vs C. americana (BPBM)  [congeneric]  BISH 5956242005  BISH1154305.webp
  * 770507  Pyracantha koidzumii (BISH) vs P. angustifolia (BPBM)  [congeneric]  BISH 5956554270  BISH1018164.webp
  * 656108  Cerastium fontanum/holosteoides (BISH) vs C. glomeratum (BPBM)  [review]  BISH 5956481103  BISH1140620.webp
Links saved to `kipuka_puaulu/conflict_sheet_scans.csv` (occurrence pages + direct image URLs). Botanical determination
is Kim's call (route specialist judgment to the human). This is the 'AI gives new access to centuries of collections'
thesis in action: a previously physical-only task became a desk check. NOTE: the BPBM double-entry records carry no
image; only the BISH digitization holds the scan (consistent with BISH/BPBM = one Bishop Museum, one physical sheet).

### 2026-07-16 (cont. 2) — scans downloaded + diagnostics captured durably (Kim: "amazing" / "killer application")
Pulled the 4 conflict-sheet scans into `kipuka_puaulu/scans/` (webp+jpg) via the R server (download.file on Kim's
machine). Resolution varies: 3 are 768x1152 web derivatives (fine for gross/macro characters, marginal for fine detail
or label text), Pyracantha 770507 is full-res 3840x5760; full-res for the rest would come from the Bishop Museum portal.
**The species-separating diagnostic characters are saved durably to `kipuka_puaulu/conflict_diagnostics.md`** (per pair:
the deciding character — Ludwigia/Hedyotis = interpetiolar stipules (family-level); Corylus = fruit-involucre beak;
Pyracantha = leaf-underside indumentum; Cerastium = inflorescence density + sepal-hair projection). Kim flagged BOTH the
diagnostics and the online-scan access as important capabilities to examine in greater detail later ("diagnostic
characters + online scans = remote conflict resolution"). Determination itself is Kim's call; once made, settle the
det_conflict flags + drop the phantom taxa with a provenance note.

### 2026-07-16 (cont. 3) — DESIGN CONVERSATION: procedural checklist + nested-radii scope (PAUSED, awaiting Kim)
A conceptual discussion (no code) opened a new door. Two linked ideas, fully captured in
`checklists/briefing_book_ideas.md`:
(1) SPATIAL scope as *sensu lato / sensu stricto* — the 2 km circle is 'Kīpuka s.l.'; the kīpuka proper is 's.s.'
Kim's call: NESTED RADII (kīpuka-core / 500 m / 2 km) + rich map symbolism, not a hand-drawn polygon (a kīpuka is an
unusual site). The s.l./s.s. difference is diagnostic (halo = matrix/planted-trials/weeds) but partly defeated by
nominal-locality georeferencing — so it tests the coordinates as much as the flora.
(2) A PROCEDURAL checklist (vs our OCCURRENCE checklist) = a 'briefing book' — a MEMORY PROSTHESIS for an expensive
field day (Gawande omission-error logic; vouchr attention-friction as the pre-field complement). 6-chapter architecture
drafted: place-at-scales / scope-aware checklist / easy wins (singletons = cheap, not rare) / high-value targets (stale
natives+endemics, collector-dependent) / contested IDs (det-conflict sheets + diagnostics) / findability + honest limits.
Two registers (read-before DOC + one-page FIELD CARD, the card possibly a vouchr deck). Honest caveat baked in:
staleness = collecting-EFFORT gap, NOT rarity. Objective-function: declare the goal, re-rank. Generalization arc:
Kīpuka doc now -> general `checklistr` `briefing_book()`/`field_targets()` later.
**RESUME:** Kim returns with (a) which register is primary (read-before book vs field card) and (b) his broader thoughts
on the two concepts; then design/build. Focus readiness: Ready. Nothing built yet — this is the plan.

### 2026-07-16 (cont. 4) — CORRECTED site centre (affects all Kīpuka analyses)
While building briefing_book R1, Kim gave the true kīpuka loop-trail centre **19.44095, -155.30295**; the centre used
since 2026-07-05 (19.437, -155.296) was ~850 m off. True-2km pull = **224 records / 100 taxa** (the old 379/150 swept
in ~155 records that are >2 km from the real centre). The checklist, collector/date, phenology and recency numbers all
used the old centre -- correct but for a slightly mis-placed, over-broad circle. Re-run on the true centre when
convenient. See proj_briefing_book.md 2026-07-16.
