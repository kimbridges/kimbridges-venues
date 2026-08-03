# briefing_book -- project log
_Split from proj_briefing_book.md on 2026-07-28. Verbatim; nothing edited._
_Live project file: `../proj_briefing_book.md`_

---

## Log
### 2026-07-16 (intake -- briefing_book opened as the umbrella project + Active Focus)
Grew out of the reopened `checklists` focus: time & phenology layer -> conflict-sheet online scans ->
a design conversation that reframed the work. Kim named the activity **briefing_book**; focus =
DATA-DRIVEN SPECIMEN COLLECTION. Primary deliverable = a READ-BEFORE document, structured as a per-site
COLLECTION of PDF reports (not one document) -- the PDF choice deliberate (field-friendly, shareable,
reduces baggage, a concrete gift to colleagues; a friction + reciprocity choice). Kim confirmed the
TWO-FACING structure (optimize new + strengthen past), liked the FRICTION handling, and endorsed
starting with Kipuka Puaulu. Design detail in checklists\briefing_book_ideas.md. Intake protocol
exercised: this file created; Active R Projects row added; Active Focus pointer switched to
briefing_book; session_log updated. Nothing built yet -- next is to prototype one Kipuka report.


### 2026-07-16 (R1 prototyped — 'The Place at Several Scopes', Kīpuka Puaulu)
First report built + verified live in RStudio. **Form decision:** the RStudio/ClaudeR bridge BLOCKS shell/system
commands, so Quarto/LaTeX rendering is unavailable through it -- adopted an **R-native report form** (ggplot2 +
patchwork + `cairo_pdf`): a single field-friendly page, fast, reproducible, parameterizable, no LaTeX. This is the
briefing_book report template going forward. Output: `kipuka_puaulu/R1_place_at_scales.pdf` (+ `_preview.png`); figures
`fig_r1_scope_map.png` (Esri satellite basemap + nested rings 0.5/1/1.5/2 km + points sized by stacked-record count,
coloured nominal-vs-GPS) and `fig_r1_scope_accumulation.png` (cumulative taxa vs radius, split native/alien).
**CORRECTED SITE CENTRE (Kim):** the kīpuka loop-trail centre = **19.44095, -155.30295**; the earlier query centre
(19.437, -155.296) was ~850 m off (it made records appear to ring an empty middle). Re-pulled at the true centre:
**224 records / 100 taxa within 2 km** (vs the mis-centred 379/150 — the extra ~155 records were >2 km away). THIS IS
NOW THE CANONICAL ANCHOR; the earlier checklist + time-lens numbers used the old centre and should be re-run on the true
centre when convenient.
**Findings (R1):** scope is a choice — the list roughly DOUBLES from the s.s. core (<=500 m = 57 taxa, 73% native) to
s.l. (2 km = 100 taxa, 69% native); the outer halo is the matrix (and the old mis-centred pull's planted forestry-trial
cluster fell outside the true 2 km, a bonus cleanup). **Georeferencing limits the fine scale:** 39% of records sit on
coarse gazetteer coordinates (whole-arcminute DMS rounding is the main artifact — 19.433333 = 19°26'), and ~30% of taxa
(47/158 in the old pull) cannot be placed below ~1 km -- so a true s.s. kīpuka flora needs re-georeferencing from the
labels, exactly a 'strengthen-past-collections' task. **RESUME:** Kim reacts to the R1 PDF (basemap choice — satellite
vs topo/trails; symbolism; center now correct); then polish + decide the next report. Later: package the R1 analysis
into a report-emitter function.

### 2026-07-16 (R1 cont.) — legend-symbol bug fixed + Kim's ground-truth validation of the map
Fixed a defect (size-legend 'records at point' showed numbers but no bubble symbols — shape-21 keys had no fixed fill;
added `override.aes=list(shape=21, fill='grey45')`). R1 PDF regenerated. **Kim validated the map against decades of
local knowledge — it reads true, and even taught him something:**
- The western cluster (in the s.l. halo) is **Kīpuka Kī** — a NEIGHBOURING kīpuka, researcher-visited (not tourist),
  and less protected during the grazing era, so it holds FEWER species. => concrete proof of the sensu-lato point: the
  2 km circle sweeps in a second named place with its own (grazing-thinned) flora. Worth labelling on the map + noting
  in the report's honest reading (the halo is not diffuse 'matrix' here — it is partly another kīpuka).
- An area to the **north, beyond the loop trail**, is a 'hidden' spot botanists like to prowl. **COLLECTING LEAD** (Kim:
  'got to remember to go there next time') — exactly the kind of thing a briefing_book targets/findability report should
  surface. Bank it.
- The stack right at the **entrance trail** is simple place-name stacking — understandable, doesn't reduce data utility.
Kim: 'getting better and better.' **Next:** offer to annotate Kīpuka Kī / entrance / the northern area on the map; then
decide polish vs the next report.

### 2026-07-16 (R1 FINALISED as the prototype/template)
Added the kīpuka labels (Puaulu at centre; **Kīpuka Kī** marked at 19.44213, -155.31878, ~1.67 km W, in the halo —
Kim's coordinate) and worked the grazing-thinned-neighbour point into the report's honest reading ('the halo annexes a
SECOND kīpuka'). R1 'The Place at Several Scopes' now stands as the completed first report AND the house-style template
for the collection: R-native single page (ggplot2+patchwork+cairo_pdf), header / satellite scope-map / accumulation +
scope-table + honest-reading. Files: `kipuka_puaulu/R1_place_at_scales.pdf` (+ preview), `fig_r1_scope_map.png`,
`fig_r1_scope_accumulation.png`. **Next: Kim picks the second report** (R3+R4 targets is the natural follow — the
prospective heart; R5 contested-IDs is fastest given today's scans; R7 climate/site via site_extract). Also queued:
package the R1 analysis into a report-emitter fn; re-run earlier lenses on the corrected centre.

### 2026-07-16 (R3+R4 built — 'Collecting Targets', with a reusable conservation layer)
Second report, on the corrected-centre data (224 recs / 100 taxa). Built the target table (recency + status +
findability [has a GPS-precise record?] + collector-dependence). **R3+R4 immediately surfaced a design problem →
Kim's call: add a CONSERVATION-STATUS layer** so the report never points collecting at protected taxa. **New reusable
capability: IUCN Red List category via GBIF, KEYLESS** — `rgbif::name_usage(key, data='iucnRedListCategory')` (no IUCN
API key needed; verified Hibiscadelphus giffardianus=CR, Cibotium glaucum=NE, Achillea=LC). Pulled for all 100 taxa
(2 CR, 2 EN, 10 VU, 2 NT, 24 LC, 60 NE). **Two global-vs-local nuances handled (both important, botanically):**
(1) apply protection to NATIVE taxa only — an alien's global IUCN status is irrelevant locally (Pyracantha koidzumii =
EN globally but an invasive WEED here); (2) VU/NT is 'caution/verify', not a hard bar — Metrosideros polymorpha is
global-VU (rapid-ʻōhiʻa-death) yet the most abundant tree in the kīpuka. **Responsible buckets:** protected-hard
(native CR/EN → observe & report: 2x Hibiscadelphus, Melicope cinerea); protected-caution (native VU/NT: 11, incl.
ʻōhiʻa); high-value collect (native, non-protected, stale — 31, the stale ferns etc.); easy-wins (findable common
singletons — 16). **Honest caveat baked in:** staleness = collecting-EFFORT gap, not rarity (Cibotium glaucum reads
'last 1971' but is abundant → EASY not urgent); IUCN coverage incomplete (NE != safe). Hero viz `fig_r34_highvalue.png`
(stale-target timeline, endemic/indigenous, findable/nominal). Report `R34_collecting_targets.pdf` (+ preview), table
`r34_targets.rds`. **The conservation layer is a candidate to fold into checklistr** (`add_iucn()` via GBIF). **Two
reports now done (R1, R3+R4); the form + the honest/responsible pattern are proven.** RESUME: Kim reacts; then next
report (R5 contested-IDs is fastest; R7 climate via site_extract) or package the report-emitter.

### 2026-07-16 (R3+R4 revised → MULTI-PAGE + family/lifeform hints; house-style principle)
Kim's preference: **single pages are nice but multi-page is fine** — give crowded panels their own page (the Protected
panel was truncated; Easy wins too). And **carry as many hints as possible next to each species name — family +
lifeform especially — most important where the flora is unfamiliar.** Adopted as a briefing_book HOUSE-STYLE PRINCIPLE
(applies to all reports). Rebuilt R34 as a 4-page PDF: (1) overview = hero timeline + how-to-read; (2) high-value
collect (all 31, with family+lifeform+status+last+yrs+n+findable); (3) easy wins (16); (4) protected = CR/EN trio +
VU/NT caution, each with family+lifeform+IUCN. family+lifeform join from the generated checklist (100% after patching
4). Multi-page via `cairo_pdf(onefile=TRUE)` printing patchwork pages + tableGrob tables (left-aligned). Files:
R34_collecting_targets.pdf (4pp), R34_p2/p4_preview.png. **Note for R1 + future reports:** revisit to add the same
hint-richness. Two reports proven; house style now = multi-page OK, hint-rich, honest, conservation-aware.

### 2026-07-16 (R3+R4 fix — honest 'locate' tier replaces the misleading 'findable' flag; footer fixed)
Kim caught two things on R34 page 2: (1) the footer note was clipped (fixed: wrapped + more height); (2) the 'find'
column was WRONG — it stamped 'Y' (GPS-precise) on taxa last collected in 1929, but GPS didn't exist then, so a
precise-looking coordinate on an old sheet is a RETROACTIVE georeference, not a field fix. **Principle (durable, honest-
data): coordinate precision != locatability; fine decimals on a pre-GPS specimen are someone's later best guess.**
Replaced the binary flag with a 3-tier **`locate`**: GPS (a GPS-era [>=1990] fine-coordinate field fix — relocatable),
approx (fine coords but pre-GPS — search the vicinity), nominal (coarse gazetteer — general area). Among the 31 high-
value targets: 8 GPS / 19 approx / 4 nominal — i.e. the STALEST targets are mostly only 'approx' (never GPS-fixed),
an honest planning warning. Hero timeline now shapes points by locate tier (GPS filled / approx hollow / nominal x).
R34 PDF regenerated. Good example of the collaborator (Kim) catching a false-precision trap.

### 2026-07-16 (technical rule — footer text must be WRAPPED, not manually broken)
Kim flagged footers repeatedly getting CHOPPED. Cause: long single lines (~150 chars) exceed the panel width and
ggplot CLIPS them at the panel edge (they don't auto-wrap; ggtext isn't installed). **Rule for all briefing_book
reports: wrap note/footer text with `strwrap(txt, width=~112)` -> paste(collapse='\n'), render left-aligned with
`coord_cartesian(clip='off')`, and VERIFY the render (don't just regenerate).** Baked into the `noteblk()` helper.
R34 footers on pages 1/2/4 re-verified clean.

### 2026-07-16 (R5 built — 'Contested Identities', with EMBEDDED sheet scans)
Third report, the retrospective/reciprocity half. 5 pages: (1) overview — the BISH/BPBM double-entry mechanism (one
Bishop Museum, one physical sheet cataloged twice, sometimes with different names -> a phantom taxon), a scope note, the
counts, and reciprocity framing; + a table of all 8 conflicts classified (4 benign spelling/synonymy/revision, 3 REAL,
1 REVIEW). (2-5) one RESOLUTION CARD per real/review sheet — the actual herbarium SCAN EMBEDDED (rasterGrob via magick)
beside the two determinations + families, THE DECIDER (diagnostic character from conflict_diagnostics.md), supporting
characters, provenance, and the scan URL. **Scope decision (honest, ties to R1):** R5 uses records ATTRIBUTED to the
locality, NOT a strict 2 km radius — re-detecting on the true-centre pull found only 2 of the 8 conflicts in-scope
because the coarse nominal georeferencing scatters the other sheets >2 km out; fixing determinations is about the
LABELS, so a tight radius would wrongly exclude them. **Reciprocity:** each resolution should be reported back to
Bishop. Files: R5_contested_identities.pdf (5pp), R5_p1/card1_preview.png. Reuses today's scans + diagnostics. Footers
wrapped (strwrap) + verified. **Three reports now done (R1, R3+R4, R5) — prospective + retrospective both proven.**
Next: R7 climate/site (site_extract) OR package the report-emitter + settle a per-site briefing_book manifest.

### 2026-07-16 (R10 built — 'Herbaria & Collectors'; + TYPE-SIZE house-style bump)
Kim's insight: **a field trip is also a HERBARIUM VISIT — arrive informed and the curator tells you more.** Built R10
(2 pages): (1) a HERBARIUM HOLDINGS table (institution-normalized, BISH/BPBM=Bishop) — records, %, taxa, span, YEARS
SINCE LAST submission; (2) the COLLECTOR timeline (27 collectors with >1 record; active spans, sized by contribution) +
an era note. **Findings that make the point:** BISH holds the most (69, 31%) but its digitized record STOPS at 1980; NY
stops 1989; only HAW (Univ. Hawai‘i) is still submitting (through 2024); many herbaria are single-year 'pulses' (one
monographer's visit); Rock's 1911 material is at Te Papa (NMNZ), NY, Paris (MNHN). **What's LEFT OFF matters too:** the
HAVO Research Herbarium + published floras aren't in GBIF (ask the curator). Reciprocity: offer your resolutions back.
Files: R10_herbaria_collectors.pdf, fig_r10_collectors.png. **TYPE SIZE (Kim, house-style): bump base fonts across ALL
reports — readability beats extra white space.** Applied in R10 (title 18-19, body ~3.3, table base ~9-10); RETROFIT
R1 / R3+R4 / R5 to match on a polish pass. **Four reports now done: R1, R3+R4, R5, R10.** Next: R7 (site_extract) or
package the report-emitter + per-site manifest.

### 2026-07-16 (SESSION CLOSE — a big, good day: FOUR prototype reports)
Day's arc: reopened checklists -> time & phenology layer -> conflict-sheet online scans (Kim: 'amazing'/'killer app')
-> design conversation -> briefing_book locked as the umbrella project -> built FOUR Kīpuka Puaulu reports, settling the
form + house style:
  • R1 Place at Several Scopes — nested-radii satellite map; sensu lato/stricto; georeferencing honesty; Kīpuka Kī
    labelled (Kim's ground truth); CORRECTED site centre 19.44095/-155.30295.
  • R3+R4 Collecting Targets — easy wins + high-value; reusable IUCN-via-GBIF conservation layer (native-only;
    global-vs-local nuances); honest staleness!=rarity + 3-tier 'locate'; multi-page + family/lifeform hints.
  • R5 Contested Identities — BISH/BPBM det-conflicts; embedded sheet scans + diagnostic deciders; reciprocity->Bishop.
  • R10 Herbaria & Collectors — holdings table (spans + who-stopped) + collector timeline; the herbarium-visit companion.
House style settled: multi-page OK, hint-rich (family+lifeform), honest, conservation-aware, embedded evidence, wrapped
footers, LARGER type. **Real-trip validation:** Kim had a HAVO trip booked THIS week (tickets/hotel/car), postponed by
two weeks' illness (now recovering) — so R10 + the targets reports directly serve the actual field+herbarium visit he'll
reschedule; the briefing_book's prospective purpose is validated by a concrete imminent trip.
**RESUME (Kim's return):** (a) R7 Climate & Site Factors via vouchr's site_extract; (b) retrofit larger type to
R1/R3+R4/R5; (c) package the report-emitter + a per-site briefing_book manifest (the generalization). Queued: re-run
phenology/recency on the corrected centre; fold add_iucn + time_tools into checklistr. All reports in kipuka_puaulu/.
Focus readiness: Ready.

### 2026-07-17 (R7 built — 'Climate & Site Factors'; reuses whittakerr + WorldClim)
Resumed (session restarted; RStudio session + all objects persisted). Built R7 (2 pages). `site_extract` turned out to
be a documented concept (Site_Extract.pdf in specimen_labels), not a live fn — so built the extraction directly.
**Reused whittakerr's cached WorldClim 2.1 bioclim tile** (tile_25_wc2.1_30s_bio) — no re-download. Values (2 km site):
MAT 16.2°C, warmest/coldest month 23.0/9.3, annual range 13.7, **temp seasonality bio4=134 (very low — the Hawaiian
aseasonal signature)**; MAP 1679 mm (168 cm), wettest/driest month 296/28, precip CV 62. Elevation via elevatr: centre
1229 m, 2 km range 1083–1508 m, slope 4.4° SE. **Hero = the Whittaker diagram (whittakerr::plot_biomes) with Kīpuka
Puaulu plotted** — it lands at the temperate-seasonal / tropical-seasonal boundary; name_biome() = 'Temperate seasonal
forest'. **This is the whittakerr anomaly made concrete:** a tropical, montane, aseasonal Hawaiian forest earns a
TEMPERATE label because the global scheme reads only temp+precip (bio4 is the tell) — a lovely cross-project link.
Substrate note (qualitative): a kīpuka = older weathered forested island ringed by younger bare Mauna Loa lava. Honest
caveat: WorldClim ~1 km is coarse for Hawaii's steep gradients (Rainfall Atlas / Giambelluca ~250 m finer). Files:
R7_climate_site.pdf, fig_r7_whittaker.png, r7_site.rds. **FIVE reports now: R1, R3+R4, R5, R7, R10.** Queued: retrofit
larger type on R1/R3+R4/R5; package the report-emitter + per-site manifest; re-run phenology/recency on corrected centre.

### 2026-07-17 (R7 polish + TYPE STANDARD codified + cross-project update list started)
Fixed R7 page-1 header overlap (title row now sits above a separate subtitle+site-info row — big title no longer
collides with the right-aligned site info). Bumped R7 page-2 type to the readable standard. **TYPE STANDARD (codified,
ggplot size units): report title 6.4 bold; section/figure title 5.6–6.0; subtitle 3.4; body/notes 3.3–3.5 (strwrap
width ~100–104, clip='off'); tables base 11–12; figure axis text 11–13, titles 17–19.** Retrofit R1/R3+R4/R5 to this.
**Kim's cross-project practice adopted:** briefing_book is a TEST + DEMO bed for earlier tools; capability advances get
queued in the new `cross_project_updates.md` (Projects_Index) for backport — seeded with 7 items (site_extract->vouchr;
add_iucn/time_tools/R10-lenses->checklistr; whittakerr site helper; report toolkit; re-run checklists on corrected
centre). R7 files refreshed.

### 2026-07-17 (FIELD CARD built — the carry-in-field register; closes the two-register design)
Distilled the reports into a single-page **Field Card** (Field_Card_Kipuka_Puaulu.pdf): top FINDABLE collecting
targets (from R3+R4, locate GPS/approx prioritized — 8 high-value + 6 easy wins, with family/lifeform/last/locate);
the 3 CR/EN DO-NOT-COLLECT endemics (R5) in a red box; SITE facts + centre coord + climate (R7); HERBARIUM-visit notes
(R10: Bishop biggest but stopped 1980, HAW active; offer resolutions back); and field REMINDERS (staleness!=rarity;
collect fertile + a duplicate to un-singleton; GPS each point; 'approx'=search vicinity; listed=observe only). Larger
type standard, print-friendly, shareable. **This closes the two-register design tension** (read-before reports +
carry-in-field card) named at the project's start. **The Kīpuka Puaulu set is now complete for a real trip:** 5 reports
(R1, R3+R4, R5, R7, R10) + the Field Card. Queued still: retrofit type on R1/R3+R4/R5; bind the set into one briefing
book (cover+TOC); package the report-emitter; the cross_project_updates backports.

### 2026-07-17 (SESSION CLOSE — second briefing_book session)
Built R7 (Climate & Site Factors — Whittaker placement via whittakerr, WorldClim + elevatr) and the FIELD CARD (the
carry-in-field register that closes the two-register design). Fixed R7's header overlap, bumped R7 page-2 type, and
**codified the TYPE STANDARD**. Adopted Kim's cross-project practice — `cross_project_updates.md` started as the backport
list (briefing_book is a test + demo bed for the earlier tools; 7 items seeded). **Kīpuka Puaulu set is now complete for
a real trip:** 5 reports (R1, R3+R4, R5, R7, R10) + the Field Card, all in `Projects\checklists\kipuka_puaulu\`.
**RESUME (tomorrow):** (1) UPDATE — retrofit the larger type standard onto R1 / R3+R4 / R5; (2) BIND this site's
briefing book — a cover + table of contents, reports + field card assembled into ONE PDF (the 'collection' made whole);
(3) then TRY ANOTHER SITE — ʻIliau Loop Trail is the natural next (dry, modern-collector contrast to the mesic kīpuka;
Kim flagged a highway/street basemap for it). Also queued: package the report-emitter + per-site manifest; work the
cross_project backports. Focus readiness: Ready.

### 2026-07-17 (cont.) — CLEANUP: R1/R3+R4/R5 retrofitted to the larger type standard (+ Finding 013)
Session-start scare: the device staging bridge served STALE PKM copies (project_index read 07-09, proj_briefing_book
07-16). The R bridge confirmed all files fully current — a Drive Stream lag, NOT data loss. Logged as **pkm_findings.md
Finding 013** (trust the R bridge for G: ground truth; never rewrite PKM from a staged copy). Then the type retrofit:
rebuilt **R1, R3+R4, R5** at the codified standard (tables base 11–12, notes 3.3–3.5, fixed headers). **R1 → 2 PAGES**
(map + reading / accumulation + scope-table + georeferencing detail) per Kim — fixes the earlier truncation and leaves
room to annotate a printed copy (Kim: spreading out helps a researcher write on it during last-minute prep). R3+R4 →
4 pages (larger; the 31-row high-value table fits one page at base 11). R5 → 5 pages (larger overview + card text;
scans still embedded). Rebuilt from saved figures + r34_targets.rds in a fresh R session (no recompute). **All five
reports now share one type standard.** Remaining leftovers: bind the site briefing book (cover+TOC); re-run
phenology/recency on the corrected centre; the cross_project backports; optional tidy of intermediate files.

### 2026-07-17 (cont. 3) — Kīpuka Puaulu briefing book BOUND + standardized COVER-MAP concept
Bound the site's set into one **18-page PDF: Briefing_Book_Kipuka_Puaulu.pdf** (cover + contents + R1 + R7 + R10 +
R3+R4 + R5 + field card), via `qpdf::pdf_combine` from the individual report PDFs. **Reading order:** R1 (place) →
R7 (setting) → R10 (provenance / herbarium visit) → R3+R4 (targets) → R5 (curation) → Field Card.
**Standardized COVER (Kim's design decision — generalizes to every site):** NOT a photo (many sites are unvisited, no
photo available) but a **context/location ROAD MAP** framing the site + the town where you lodge & eat + a large
landmark, at a scale that shows all three. For Kīpuka Puaulu: Kīpuka Puaulu (red diamond) + Volcano Village + Kīlauea
Caldera on an **Esri World Topographic** base (roads, park, terrain, place names) — colorful, informative, reusable.
**Tile note:** OpenStreetMap tiles returned blank via maptiles; **Esri providers work reliably — use Esri** (WorldTopoMap
for context, WorldStreetMap for a plain road map, WorldImagery for satellite). Cover page = title + context map + facts
strip; contents page lists the 6 reports. Figure: fig_cover_context.png; front matter `_frontmatter.pdf`. **This makes
the 'collection of PDFs' whole.** Bears on the report-emitter: cover-map + bind is part of the per-site pipeline.
**Kīpuka Puaulu briefing book is DONE.** Next: Kim's plan for the ʻIliau site.

### 2026-07-17 (cont. 4) — METHOD: preview observations as a front-and-center INPUT (starting the ʻIliau site)
Kim brought the collector's REASON-FOR-GOING front and center before any build, framing it as preview observations
that should DIRECT the briefing (not just correct it mid-course). **Method refinement (the 'direction' complement to
the 80%-tool 'correction'):** each site's briefing begins with a captured preview — significance, access, known
hazards, target species, cultural notes — which shapes the cover significance, the analytical adaptations, and the
target emphasis. For ʻIliau (preview in `checklists/iliau_loop/site_preview.md`): the standout adaptation is an
**ELEVATION DISCRIMINATOR** (rim loop-trail vs canyon-floor records) that the site's steep terrain demands — Kīpuka
never needed it; a hard-to-find trailhead also predicts a worse georeferencing story. Significance = ʻiliau (Wilkesia,
silversword alliance, Kauaʻi endemic, scarce) + site-distinctive species + old planted tī. **Plan:** same Kīpuka spine
(cover → R1[+elevation] → R7 → R10 → R3+R4[foreground ʻiliau + distinctive taxa] → R5 → field card → bind), streamlined
by the model. Also queued: fold this 'preview input' idea into concept_80pct_tool.md (the human's 'why go' as a start).

### 2026-07-17 (cont. 5) — SECOND SITE: ʻIliau Loop briefing book BOUND (12 pp) — streamlined but genuinely adapted
Built the ʻIliau Loop Trail briefing book on the Kīpuka model, fast, but ADAPTED by the preview (proof the preview-as-
direction method works): **Briefing_Book_Iliau_Loop.pdf** (cover + contents + R1 + R7 + R10 + R3+R4 + R5 + field card).
Centre 22.05176/-159.65935 (Kim). Adaptations that made it *this site's* book:
- **R1 = a VERTICAL site.** The ELEVATION DISCRIMINATOR (rim >=700 m vs canyon-floor) — Kim's preview insight — showed
  **21 of 65 records (31%) are canyon-floor** (near in plan, 400+ m below in fact); the true rim site = 44 recs / 28
  taxa. Elevation, not radius, defines the site. Worse georeferencing than Kīpuka, for the reason Kim named (a trailhead
  invisible at highway speed, ~no parking).
- **R3+R4 REFRAMED observe-first.** The conservation layer (IUCN via GBIF) revealed the site is a HOTSPOT OF ENDANGERED
  ENDEMICS: **6 of 28 rim taxa are native CR/EN — including the ʻiliau itself (Wilkesia gymnoxiphium, EN, silversword
  alliance)**. Kim: 'treasure house — take photographs — focus must be OBSERVE & REPORT.' So the report leads with
  photograph-&-report (do not collect); a thin collectable set follows (distinctive stale natives — the 1909 clubmosses).
- **Distinctive-taxa** via an 8 km Kokeʻe/Waimea regional pool (347 taxa): Melicope haupuensis (CR), Solanum sandwicense
  (CR), etc. — endemic + regionally scarce = the 'here and nowhere near' draw.
- **R7:** warmer/drier (17.9 °C / 1331 mm) canyon rim; same Whittaker anomaly. **R10:** modern, MAINLAND-herbaria record
  (US, CAS active to 2025) — opposite of Kīpuka's Bishop-1980. **R5:** 0 conflicts — a 'clean record' note explaining
  WHY (no Bishop double-entry), an informative contrast.
- **Cover:** context road map (Waimea town + Waimea Canyon Lookout + the trailhead, Esri topo).
**METHOD VALIDATED across two sites:** the preview (direction) drove real analytical adaptations a template-fill would
have missed. The report-emitter is now grounded in two worked, genuinely different sites (Kīpuka mesic/collect vs ʻIliau
canyon-rim/observe). Data: iliau_loop/iliau_targets.rds + iliau_base.rds. **TWO briefing books complete.**

### 2026-07-17 (cont. 6) — ʻIliau refinements (Kim review): NEW report R2 Master List; naming rule; voucher label; a Santalum gap
Kim's review produced several 'get it right' fixes, all applied to the ʻIliau book (now 14 pp):
- **NEW REPORT — R2 'The Rim Checklist (Master List)'.** The target tables summed to 21, but there are 28 rim taxa (7
  were 'present, not a target' and shown nowhere). R2 lists ALL 28 (family/lifeform/status/IUCN/last/role) and
  reconciles the count. **Adopt R2 into the catalog for every site**, placed after R1. Reading order now: R1, R2, R7,
  R10, R3+R4, R5, field card.
- **'Known here but not in the record' (on R2).** Kim flagged **Santalum (ʻiliahi/sandalwood)** — he believes it's on
  the trail; the record has 0 site vouchers but 8 in the 8 km regional pool. Acacia koa similarly (0 site / 12 regional).
  Flagged as collection/digitization GAPS; **Santalum = a high-value voucher target that would fill a real gap.** A
  beautiful 'record != flora' case surfaced by ground truth — and a reason the master list earns its place.
- **NAMING RULE (Kim):** never abbreviate **Kīpuka Puaulu** to 'Kīpuka' (like New York -> never 'New'). ('the kīpuka' as
  the landform noun is fine; the place name is always full.) Fixed across R1/R7/R10 text.
- **R1 map fixes:** the top legend/subtitle was cropped -> fixed; and it now states **each point is a herbarium VOUCHER
  SPECIMEN location** (obvious to us, not to a new reader).
Re-bound as **Briefing_Book_Iliau_Loop_v2.pdf** (the original was file-locked / open in a viewer). **TODO (both-book
consistency):** apply the SAME two changes to the Kīpuka Puaulu book — the naming pass ('Kīpuka'->'Kīpuka Puaulu') and
add an R2 master list (100 taxa) — then re-bind it too.

### 2026-07-17 (SESSION CLOSE — two briefing books; ʻIliau refined; KP update queued)
Big day: TWO complete briefing books. Kīpuka Puaulu (18 pp, bound). ʻIliau Loop Trail (14 pp, bound) — built streamlined
on the model but genuinely adapted by Kim's preview (vertical-site elevation discriminator; observe-first for the
endangered ʻiliau + endemics; modern clean record). Then Kim's review added **R2 'Master List'** as a permanent catalog
report, a naming rule (Kīpuka Puaulu, never 'Kīpuka'), the voucher-specimen map clarification, and a real Santalum
collection-gap finding. ʻIliau canonical file is the updated 14-pp book (v2 promoted, v1 was file-locked mid-session).

**★ STARTING TASK FOR NEXT SESSION — the KĪPUKA PUAULU UPDATE (bring it to parity with ʻIliau):**
1. **Naming pass:** replace place-name 'Kīpuka' with 'Kīpuka Puaulu' throughout the KP report text (R1/R3+R4/R5/R7/R10/
   field card / cover / contents). Keep 'the kīpuka' where it means the landform noun.
2. **Add R2 'The Checklist (Master List)':** all ~100 KP vascular taxa (family/lifeform/status/IUCN/last/role), placed
   after R1. Reconcile counts. Ask Kim if he knows any 'present-but-unrecorded' taxa for a KP gap note (as Santalum was
   for ʻIliau).
3. **R1 voucher clarification:** state that each map point is a herbarium voucher-specimen location (as now done for ʻIliau).
4. **Re-bind** Briefing_Book_Kipuka_Puaulu.pdf with R2 in order; update the contents page.
Data is all on disk (r34_targets.rds etc.); rebuild from saved figures + rds (no recompute). Focus readiness: Ready.

### 2026-07-17 (cont. 7) — Kīpuka Puaulu brought to parity; 'present but unrecorded' becomes a standing R2 element
Updated the Kīpuka Puaulu book to match ʻIliau (re-bound, now **22 pp**): added **R2 'The Checklist (Master List)'**
(all 100 taxa, 3 table pp + a note pp), the R1 voucher-specimen clarification, and the naming fix (R10 'published Kīpuka
Puaulu floras'; the rest already used 'the kīpuka' landform / full name correctly).
**'PRESENT BUT UNRECORDED' is now a standing element of R2 for every site — Kim's GUARD against skipping dominant
species that cover a large range** (they get skipped BECAUSE they're everywhere). Method (an 80%-tool pattern): compare
the 2 km site record to an 8 km regional pool; regionally-common taxa absent/thin at the site are CANDIDATES; the
botanist adjudicates which are genuinely present vs ecologically absent. Kim's TAXONOMY OF WHY THINGS GET SKIPPED (the
note's structure): too-dominant-to-bother · off-trail in wetter patches · small/common/looked-past · on-the-edges-
passed-by · conspicuous-only-in-flower · plausible-but-unconfirmed. **Standout:** Dicranopteris linearis (uluhe) — the
blanket ground fern — 0 site vouchers vs 23 regional (the exemplar); Acacia koa present-but-thin (4); Santalum absent
at BOTH sites (0 site / 8–10 regional). **Both briefing books now complete with the full model** (cover + contents +
R1 + R2 + R7 + R10 + R3+R4 + R5 + field card). Report catalog updated: **R2 = the master list, always with a
present-but-unrecorded note.**

## PROJECT STATUS — 2026-07-17 (ON HOLD pending Dr. McClatchey's critique; then fold into checklistr)
**Where we are.** briefing_book — the umbrella for DATA-DRIVEN SPECIMEN COLLECTION — has TWO complete, bound,
field-ready briefing books for two genuinely different sites, proving the model travels:
  • **Kīpuka Puaulu** (HAVO, Hawaiʻi Island) — mesic montane forest kīpuka; a COLLECT-first site. 22 pp.
    `Projects\checklists\kipuka_puaulu\Briefing_Book_Kipuka_Puaulu.pdf`
  • **ʻIliau Loop Trail** (Kokeʻe/Waimea Canyon, Kauaʻi) — canyon-rim; an OBSERVE-first site (endangered endemics,
    incl. the ʻiliau). 14 pp. `Projects\checklists\iliau_loop\Briefing_Book_Iliau_Loop.pdf`

**The model (per-site set):** cover (standardized context road-map: site + lodging town + landmark, Esri topo) +
contents + **R1** Place (nested-radii OR — at ʻIliau — an elevation discriminator; georeferencing honesty; each point =
a voucher specimen) + **R2** The Master List (all taxa + a 'present but unrecorded' guard) + **R7** Climate & Site
(WorldClim + Whittaker placement) + **R10** Herbaria & Collectors (holdings + timeline; the herbarium-visit) + **R3+R4**
Targets (easy wins / high-value / protected — conservation-aware, IUCN-via-GBIF) + **R5** Contested Identities (det-
conflicts + scans) + **Field Card** (the carry-in-field register). Built R-native (ggplot2 + patchwork + cairo_pdf +
qpdf), codified type standard.

**Method spine (what makes it more than a template):** PREVIEW-as-direction (the collector's reason-for-going shapes
the analysis up front — e.g. ʻIliau's elevation discriminator, the observe-first ethic); the **80%-TOOL** pattern (the
tools give data, the collaboration gives the answer — data proposes, the botanist adjudicates); HONEST-DATA throughout
(staleness != rarity; detection != arrival; locate tier; the record != the flora); CONSERVATION-aware (never target the
endangered); the **present-but-unrecorded GUARD** (dominant species get skipped BECAUSE they're everywhere — uluhe the
exemplar); RECIPROCITY (report resolutions/sightings back). Concept note: `concept_80pct_tool.md`.

**HOLD (2026-07-17):** Kim shows both books to **Dr. Will McClatchey** (Sunday) for critique — the right person to
stress-test this. Project PAUSED until that feedback. Focus readiness: Blocked (awaiting review).
**NEXT (next week, after feedback):** fold the new pieces into **checklistr** (backport list in `cross_project_updates.md`)
— R2/master-list, the elevation discriminator, the regional present-but-unrecorded check, add_iucn, time_tools, the
cover-map + bind pipeline, and eventually a report-emitter. Also queued: re-run KP earlier lenses on the corrected
centre; develop the 80%-tool concept. McClatchey's critique will re-prioritise this list.
## 2026-07-26 (PUBLISHED to kimbridges.info as a Collection; R1 page-2 correction; Diamond citation CONFIRMED)
**The hold is lifted.** Dr. McClatchey's critique has not arrived (he is busy; Kim talks with him Sundays). Kim's
call: waiting longer costs more than it buys. Both books go out as **working prototypes**, which lets Kim recruit
OTHER reviewers through the website. Consistent with his standing position that prototypes should go out for review
before polish. Focus readiness moved off Blocked.

**Form: a COLLECTION, not a Document.** Third collection on `kimbridges-collections`, after Gallery and Jones.
Title **"The Briefing Books"**. One page, `briefing_books.qmd`, holding both sites and built to take more without a
rewrite -- the series structure is the point, since new sites are expected. Kim's correction during drafting: unlike
Gallery and Jones, these books DO have a uniform format, so the intro had to carry the format itself, not just the
two instances. Published contents: the two bound books, ALL fourteen individual report PDFs (so a reader can take
one facet without the whole book), the four checklist CSVs, and the Field Cards inline as iframes.

**The thread Kim wanted stated (the reason this collection is different).** The other projects were STEPWISE: Kim
directed each stage. The briefing books hand ORCHESTRATION to the engine. From geographic coordinates plus a
paragraph about the site -- often personal, the collector's reason for going -- the engine runs the whole chain to
an assembled document. Orchestrating a series of steps is a different skill demonstration than doing any one of
them well, and it belongs in the record of what the latest AI can do.

**R1 page-2 correction (Kīpuka Puaulu).** The page-2 caption still carried a pre-correction figure: "the nine
nominal points hold 52% of all records." That number came from `r1_points.rds`, which is the MIS-CENTRED pull
(stored `dist_m` differs from true-centre haversine by up to 851.2 m; three of its nine coarse points sit
2224-2321 m from the true centre). Verified first that the MAP itself is sound -- rasterized page 1 and looked at
it; rings centred on the loop-trail centre, Kīpuka Kī west where it belongs, no far-east cluster. Then swept every
surviving `.rds` and `.csv` under `checklists` for one reproducing the table's 224 records at 2 km. **None does**
(r1_points 193, r34_targets 207, the specimens CSV 107). The corrected coordinate table was never saved, so no
corrected COUNT of nominal points can be honestly asserted, and inventing one would repeat the exact error being
fixed. The fix exploits an identity: the nominal points ARE the coarse-coordinate points, so page 1's already-
verified "39% of records sit on coarse gazetteer coordinates" describes the same quantity. New line 2: "the
nominal points hold 39% of all records." Count dropped, one number now stated on both pages, nothing unverifiable
introduced.

**How the correction was made (technique worth keeping).** No R1 build script exists, so the report could not be
re-rendered. First attempt was a `qpdf::pdf_overlay_stamp` patch (white rect + redrawn line at a solved 9.67 pt,
`#404040`, x=40.48). It looked perfect and was WRONG: the old text survives in the text layer, so copy, search,
screen readers and any AI ingesting the PDF would still return "52%". Discarded. The real fix edits the content
stream: the caption turned out to be plain ASCII in a single `Tj` under a subset ArialMT, so the string was
replaced in place with `pikepdf`, keeping the original font and metrics. Page 1 verified pixel-identical
(md5 of the raster) and page 2 verified by rendering and LOOKING (finding 016). Book re-bound to 22 pp and both
files pushed to the collections asset tree. **Lesson: a visual fix that leaves the old text underneath is not a
fix.**

**Diamond citation CONFIRMED.** Kim supplied a scan. Jared Diamond, "The Ethnobiologist's Dilemma," *Natural
History* 6/89 (June 1989), pp. 26, 28, 30. The article gave more than the paraphrase did: informants deliberately
THROTTLE output on perceived competence (the Bulmer rocks story), which sharpens the 80%-tool analogy by way of its
DISANALOGY -- the engine has no competence detector, so the naive user gets MORE, not less. Full treatment in
`concept_80pct_tool.md`.

**Known, not blocking.** The page-2 scope table's "224 records" cannot be reproduced from any surviving file. No
text in the report states the map's record total, so the discrepancy is invisible to a reader, and the 100-taxa
figure is corroborated three ways. Worth resolving when R1 is eventually rebuilt from a saved coordinate table.

## 2026-07-26 (later) -- THE COMMISSION BLOCK written, and FINDING 018 (the preview was never captured verbatim)

Kim asked the blunt question while reviewing the *Behind the Curtain* page: with the document projects there is
a code sequence, so **is there a paragraph he could hand to Claude that would produce a new briefing book?**
There is no stored driver script. The answer is `Projects\checklists\briefing_book_commission.md` (3922 bytes),
written this session. It names the packages and functions, the report set (R1, R2, R3+R4, R5, R7, R10 and the
field card), the qpdf binding, the full codified type standard, the Okabe-Ito rules, the three honesty rules
(staleness is not rarity; coordinate precision is not locatability, in three tiers; the record is not the
flora), the naming rule, and it ends with `[paste site_preview.md here]`. Kim then asked for it to go ON the
public page, and it is there in full.

**Kim's assumption about the toolchain was wrong, and was corrected to his face.** He thought vouchr was the
main briefing-book package. It is not. **`checklistr` is the engine** -- 26 exports covering build_checklist,
fetch_specimens_gbif, dedup_specimens, crosswalk_gbif, detect_det_conflicts, richness_estimate,
species_discovery, the plot_* family, map_specimens, status_gift, gift_growthform and the collector functions.
Its DESCRIPTION lists Kim Bridges and "Claude (Anthropic; collaborative development)" as joint authors.
**vouchr** contributes `site_extract` and the terrain/substrate helpers for R7 only. **whittakerr** + WorldClim
place the biome, **elevatr** supplies per-record elevation (that is what made the rim vs canyon-floor split
possible), Esri topo tiles do every basemap because OSM returns blank at these sites, **qpdf** binds. This was
traced from the packages on disk, not from memory, which is why it is trustworthy.

**FINDING 018 -- the source utterance is gone.** Kim asked whether his initial spoken comment on the ʻIliau
Loop Trail had been preserved, since that is the statement the working file came from. Every `.md` in
Projects_Index and the whole `checklists` tree was searched. It has not been preserved.
`checklists\iliau_loop\site_preview.md` is a session write-up and says so in its own header ("Captured
2026-07-17 from Kim's preview observations"); line 334 above paraphrases the same material a second time; and
the session log has a gap across exactly that date range. The published input-contract section therefore shows
a faithful reconstruction, not the original words. Told to Kim directly rather than papered over. Full entry in
pkm_findings.md.

**Standing rule from here.** For any new site, **write the preview FIRST, in Kim's own words, and save it to**
`checklists\<site>\site_preview.md` **before any build starts.** If it is spoken, transcribe it, mark it as a
transcription, and have him correct it while the session is still live. This rule is now written into the
commission block under "Preview capture".

**Project status unchanged: still ON HOLD pending Dr. McClatchey's critique.** Kim went from this session
straight to a conversation with him. The natural sequel, once the critique lands, is the **checklistr driver**
that takes a centre, a radius and a preview file and emits the report set -- the code form of the block above.

### 2026-07-28 (reclassified Complete; log split out)
Status **Active/Ready -> Complete/Not applicable**. The Briefing Books published
2026-07-25 to kimbridges-collections. Dr. McClatchey's critique is pending but,
per the rule stated this session, a pending review does not hold a deployed project
Active. The checklistr driver remains a live idea and belongs to checklistr, not
here. Log tail split to this file.
