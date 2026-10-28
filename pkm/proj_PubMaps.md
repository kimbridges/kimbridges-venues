# PROJECT: PubMaps
_Last updated: 2026-10-24_
_Status: Active_
_Focus readiness: Ready_
_Tags: ACTIVE FOCUS since 2026-10-24_

## Type
R tool (LLM-assisted) + planned Quarto methods document; companion package likely

## Objective
An EDITOR'S TOOL for publication-style study-site maps: a detailed site map with an
integrated locator inset, drawn from the text paragraph that describes the sampling
locations. Pipeline: paragraph -> LLM -> YAML config -> R (sf/ggplot2/rnaturalearth/
patchwork) -> PDF for the paper. Intended operator (Kim, 2026-10-24): a journal editor, or one
person in a research lab who knows the tool and makes maps for the team. NOT aimed at
paper authors -- they make only a few maps in a career, and R-skilled authors are the
exception.

## Current Status
Working prototype, intake 2026-10-24. Origin: a visit with Will McClatchey, who as a journal
editor for many years had to redraw authors' maps; the question was whether AI could
help. Gemini wrote the R code; the code calls the OpenAI API (gpt-4o-mini) to turn the
paragraph into YAML. A ten-case test suite (7 published paragraphs + 3 synthetic stress
tests) renders vector and relief PDF pairs. Cosmetic faults (e.g. the inset covering a
label) have been fixed adequately by sending the PDF back to OpenAI with the specific
problem. Documentation started in `test_suite/Test_Cases.qmd` (case 1 filled; code
chunks are `###` placeholders).

**Finding at intake (2026-10-24): the LLM INVENTS site coordinates** when the text names a
place without giving its position -- which is most of the time. Evidence: Yucatan puts
Peto and Tzucacab WEST of Oxkutzcab (both are east; Peto off ~40 km); Kasigau's five
"ring" villages are a 0.05-degree diagonal staircase labelled Market Town; Sumatra's two
villages are round-number guesses and the three named market towns were dropped. The
PDF-feedback loop cannot catch this, because a wrong location looks like a right one.

**Rulings (Kim, 2026-10-24):** editor's tool (see Objective); gpt-4o-mini is retired as the
engine (outdated); PubMaps joins the system as a module of the MAPPING family --
"mapping has many facets".

## Locations
- Code/data: G:\My Drive\Projects\PubMaps (bucket 2; moved from the Drive root 2026-10-24,
  88 files, verified by count and content through the R bridge)
- Test suite: PubMaps\test_suite\ (inputs/ .txt, configs/ .yaml, outputs/ PDFs)
- Source papers: era_old\, era_recent\, econ_bot_recent\ (journal PDFs)
- GitHub: not yet
- Track: R on Kim's machine (feeds the mapping family and a published document)

## Key Files
- pubmap_tools.r -- the engine: clean_geo_text(), auto_utm_crs(), query_llm_yaml(),
  generate_publication_map(), generate_map_pair()
- R/new_engine.R -- later engine variant (same function set, no LLM call)
- llm_txt_to_yaml.R -- standalone paragraph -> YAML call (OpenAI, gpt-4o-mini)
- llm_instructions.txt -- fuller system prompt / YAML schema + cartographic rules
- dual_runner.R (root and R/) -- batch: every configs/*.yaml -> vector + relief PDFs
- R/test_harness.r, generalized.R, llm_version.R -- variants, roles not yet sorted
- test_suite/Test_Cases.qmd -- the documentation start

## Engine Audit (2026-10-24)
- **pubmap_tools.r is current** (10-17 21:27). R/new_engine.R = the same file minus
  query_llm_yaml() (function bodies identical but for two message strings).
  generalized.R (10-15) is the older engine. The three query_llm_yaml() copies
  (pubmap_tools, llm_version, llm_txt_to_yaml) all differ; all to be replaced.
  The two dual_runner.R copies are identical.
- **Keep:** generate_publication_map(), the renderer (~250 lines: Natural Earth land +
  country, UTM-at-centre projection, optional elevatr hillshade, ggrepel labels, scale
  bar, north arrow, patchwork inset).
- **Already code-decided:** the inset corner -- the renderer IGNORES the LLM's
  inset_corner and takes the quadrant with fewest POINTS (labels not counted, which is
  why an inset can still cover a label).
- **Defects to carry into the rebuild:** subdivision_name accepted but never drawn;
  site types hard-wired to Study Site / Market Town (anything else unstyled); extent
  = LLM bbox UNION points, so a bad LLM bbox inflates the map; Natural Earth medium
  scale too coarse for small islands; inset = whole-country bbox (explodes for
  countries with remote territories); first country match only (tri-national case);
  fixed 170 x 130 mm output.
- **Available on Kim's machine:** OpenAI, Anthropic and Gemini keys; tidygeocoder,
  pdftools, rnaturalearthhires, geodata, osmdata, leaflet, shiny. NOT installed: ellmer.
  No GeoNames username.

## Step 1 EXTRACT -- built and tested (2026-10-24)
- **Code:** `R/extract_places.R` -- `extract_places(pdf, provider, model)`: whole PDF,
  page-tagged -> typed place table (name, role, country, admin1, stated_lat/lon,
  coord_text, elevation_m, page, evidence). Roles: study_site, sampling_point,
  reference_town, protected_area, natural_feature, administrative_unit,
  relative_location, other. Coordinates ONLY when the manuscript states them.
- **Results:** `test_suite/extract/<case>__openai.csv` (+ `_study.rds`). Seven era_old
  manuscripts, OpenAI gpt-6.1-sol, 18-30 s each, 16-39 places each. Every place in the
  seven hand-written paragraphs was found (the three Simpson "misses" were a matching
  artefact: found as Pulchera, Wongitta, Alnagata / Cunja Spring complex). Plus places
  the paragraphs lacked (Kasigau: Ndomokonyi, Siriri River, Mwarashua).
- **Zero invented coordinates.** Three stated, all correct and correctly attributed
  (Mt. Kasigau; Ginchi and Shikute, the two ends of the Shewa road corridor).
- **The test paragraphs carry errors the extractor avoided:** the Simpson paragraph's
  "centered near -23 19 S, 138 16 E" is Hodgkinson's 1876 position east of Twin Hills in
  the historical section, not the study area; the Sumatra extent (1.5-3.5 S, 101-102 E)
  comes from the graticule labels of the authors' own map figure, not the text.
- **Open:** bare table codes (Simpson "396 B" ...) still listed as sampling points --
  tighten the rule; figure text (graticule labels) is a legitimate extent source, to be
  captured and labelled `source: figure`.
- **Environment -- R UPGRADED 2026-10-24 (Kim):** R 4.3.3 -> **4.6.1**, Rtools43 -> Rtools45,
  installed ALONGSIDE 4.3.3 (not yet uninstalled). All **495** packages restored to
  `win-library/4.6` in ~9 min (467 CRAN binaries, 3 Bioconductor, 14 GitHub, Kim's 11
  from `Projects/<name>`); inventory + script in `Projects_Index/Claude outputs/
  r_upgrade_2026-10-24/`. ClaudeR 0.2.0 -> 0.16.2. **ellmer 0.5.0** now works with Claude
  (chat_anthropic, structured output). Kasigau re-run on claude-sonnet-5-5: 13 s,
  16 places, Tsavo East / West named correctly, plot descriptions -> relative_location.
  **Both stored GitHub tokens are dead** (GITHUB_TOKEN in .Renviron and the git
  credential store): installs went round them via archive zips; renew before the next
  mirror push. **Pending:** uninstall R 4.3.3 + Rtools43 once confirmed (Kim). Gemini
  key still refused by Google (403).
- **GeoNames:** Kim has a PREMIUM account -- username `kimbridges`, server
  `https://secure.geonames.net` (.net, not .org). Optional `token` parameter and IP
  allow-list on his account page, not set. Primary gazetteer; Nominatim as fallback.

## Step 2 LOCATE -- built; Nominatim baseline run; GeoNames pending (2026-10-24)
- **Code:** `R/locate_places.R` -- `locate_places(places, study, backends, cache_dir)`.
  Backends share one candidate table: `nominatim` (working) and `geonames` (premium
  host, username kimbridges; optional GEONAMES_TOKEN / GEONAMES_HOST env vars).
  Candidates scored on name similarity, feature kind vs role, admin1 agreement and
  importance; near-ties broken by distance to an anchor (stated coordinates first,
  else confident exact matches). Every point carries `coord_source` (text |
  nominatim | geonames | none) and `match`: stated | exact | partial (includes a town
  represented by its same-named municipality) | suggestion (wrong feature kind, e.g. a
  highway offered for a mountain -- NOT placed, shown to the editor) | none.
  `flag` = far (beyond max(50 km, 3 x median distance)) or relative.
- **Results (Nominatim only):** `test_suite/locate/<case>__nominatim.csv`; 108 of 167
  named places placed (65%). Weak where OSM is thin: Chitwan 6/20 placed, Kasigau 7/14,
  Shewa 8/15. **Yucatan now correct:** Peto -88.92 and Tzucacab -89.05 both EAST of
  Oxkutzcab -89.42 (the old pipeline had them reversed).
- **Blind test** (stated coordinates hidden): Nominatim matched Mt. Kasigau to the
  Mwatate-Kasigau-Maungu highway (13.4 km off -- now a non-placed suggestion) and has
  NO entry for Ginchi or Shikute. That is the case for GeoNames.
- **GeoNames:** still 401 ("valid username") on premium and free hosts at ~20:00;
  Kim finished account setup 19:51 and GeoNames warns changes take minutes to
  propagate. Rerun the blind test and all seven cases with backends =
  c("geonames","nominatim") once it answers.
- **Open:** extractor duplicates municipality + town of the same name (Yucatan) --
  merge rule needed; far-flag tuning for Simpson (7 far).

## Steps 3 PLAN + 5 RENDER -- built; first gallery (2026-10-24)
- **Code:** `R/plan_map.R` -- `plan_map(points)`: chooses drawn points (dedupes a town
  and its same-named municipality; natural features only if point-like -- peak,
  spring, pass, glacier, waterfall -- or stated; ranges, rivers, islands, basins are
  context), projection (UTM <= 5 deg wide, else LAEA), extent fitted to the page
  aspect with a minimum span, inset corner = the corner covering no point or label
  (map WIDENED to make room if all four are occupied), inset countries by nearest
  country to the points, remote territories dropped, north arrow and scale bar in
  free corners; warns when fewer than 3 points. `R/render_map.R` -- draws exactly
  the plan (adapted from generate_publication_map): Natural Earth 10 m below 6 deg,
  admin-1 lines, role symbols + legend, ggrepel labels, graticule, inset as a box or,
  when tiny, a dot. Vector PDF + PNG (relief option kept).
- **locate rule added:** generic names ("Ward no. 3", "396 B") are never geocoded --
  they go to the author queries (Chitwan's wards had been matched to POKHARA wards).
- **Gallery:** `test_suite/maps_v2/` (+ `contact_sheet.png`; preview copies on Kim's
  Desktop `pubmaps_preview/`). Good: Kasigau (ring around the mountain, inset widened
  to an empty corner), Yucatan (correct order), Shewa (stated corridor ends), Sumatra
  (81 km frame), Himalaya (13 sites). NOT useful yet: Simpson, Chitwan -- one point
  each, because OSM lacks their places; GeoNames is the fix.
- **Next:** GeoNames rerun when the account answers; areal context (park, district
  polygons) drawn instead of dropped; step 4 REVIEW report (points by source +
  author-query list + editable points.csv); journal style file.

## Step 4 REVIEW + the whole pipeline -- built and run (2026-10-24)
- **One call:** `source("R/pubmap.R"); pubmap("paper.pdf")` -> folder `review/<stem>/`
  with `map_vector.pdf/.png`, `points.csv`, `review.html`, `recipe.yaml`, `plan.rds`.
  Edit `points.csv`, then `pubmap_rerender(dir)`. Code: `R/pubmap.R`, `R/points_io.R`,
  `R/review_report.R` (+ extract / locate / plan / render).
- **review.html:** Leaflet map (OSM tiles) with every place coloured by source
  (stated / editor / exact / partial / suggestion -- hollow, not placed / not located),
  the planned frame dashed, the rendered map beside it, counts, a copy-ready AUTHOR
  QUERY, the full place table with page + evidence, and correction instructions.
- **points.csv (the editor's file):** include (blank / yes / no), label, lon, lat, note;
  typed coordinates become source "editor"; a row with blank id adds a place.
- **Author query rules:** asks only for named study sites, sampling points and towns
  not located (+ generic names); plot descriptions grouped into ONE request for GPS
  positions; rivers, ranges, parks never queried; partial / suggestion matches listed
  "to confirm". Names with no capital letter are descriptions and never geocoded
  (killed a "national forest reserve" -> Boni National Reserve, 400 km away, match).
- **Round trip tested (scratch copy):** review map showed OSM labels the village
  "Kitege" (manuscript: "Kiteghe" -- why it was missed); coordinates typed into
  points.csv, Tsavo West excluded; re-render put Kiteghe on the map (source editor),
  frame and inset re-planned. Real review folders: `review/pub_0*`.
- **Map tiles (fixed same evening):** OpenStreetMap's tile servers return "403 Access Blocked"
  to pages opened from disk (no referrer); CARTO now wants an API key. review.html uses
  Esri tiles (no key) with a layer switch: Streets / Topographic / Satellite + labels,
  plus a metric scale bar. All seven review pages rebuilt.
- **Practical note:** close a case's PDF before `pubmap_rerender()` -- an open PDF blocks
  `cairo_pdf` from overwriting it.
- **Open:** fuzzy / alternate-name gazetteer search (GeoNames has alternate names --
  would catch Kitege/Kiteghe); draw parks and districts as areas; journal style file.

## Related Projects
Mapping family: **Plainmaps** (proj_Plainmaps.md, plain publication maps -- the closest
sibling), **sitemaps** (proj_sitemaps.md), **gePoints** / **geContour**, **Voronoi** +
**tessellr** (proj_Voronoi.md, proj_tessellr.md), and the Rehearsals gallery
(ideas_rehearsals.md), where PubMaps is an "I can make this kind of map" entry.

## Next Steps
1. DESIGN REVIEW. Settle the division of labour: what the operator edits, what code
   decides (bbox, inset corner, projection are geometry, not language), what the LLM
   does (read text: names, roles, stated coordinates). Decide YAML's place.
2. Coordinate provenance: LLM extracts names, roles and only coordinates STATED in the
   text; a gazetteer (GeoNames / OSM Nominatim / Wikidata) resolves the rest; every
   point carries `source: text | gazetteer | estimate`; unresolved names are flagged.
3. Operator review step: the editor confirms or corrects points before rendering.
4. Replace gpt-4o-mini: provider-swappable call (e.g. ellmer) with structured output
   instead of parsing YAML out of text; the model becomes a test variable.
5. Sort the duplicate engines into one; then the methods document, the test suite as
   its gallery (paragraph -> YAML -> map -> right / wrong / why).

## Design History
- [Kim, 2026-10-24] The first engine read only a YAML file and expected the user to write
  it. Kim found that too difficult and proposed having an LLM write the YAML -- so the
  design is pieced together and worth reviewing. Kim sees value in a file the operator
  can edit to add a location or two, but the rigor needed for valid YAML is a likely
  friction point.
- [Kim, 2026-10-24] DIVISION OF LABOUR ADOPTED: LLM reads (names, roles, stated
  coordinates, admin units) via structured output; gazetteer locates; code decides
  geometry (extent, aspect, projection, inset corner); operator edits a points CSV.
  YAML stays only as the machine-written map recipe (+ optional small override file).
- [Kim, 2026-10-24] INPUT = THE WHOLE MANUSCRIPT. McClatchey: one of his big time sinks as an
  editor was reading each manuscript to find every location for the map. Feeding the
  full manuscript (not a hand-picked paragraph) removes that task.

## Collaborators / Dependencies
Will McClatchey (origin; editor's perspective). OPENAI_API_KEY in .Renviron.

## Blockers
None.

---
## Log
### 2026-10-24
Intake. Kim told the origin story, attached Test_Cases.html, and asked where to go
next. Session read the code and test suite and found the invented-coordinates problem
(Current Status). Kim ruled: editor's tool, retire gpt-4o-mini, file as a mapping-family
module.

### 2026-10-24 (later)
Folder moved to Projects\PubMaps. PubMaps made the ACTIVE FOCUS (Rehearsals paused).
Kim supplied the design history (YAML-first, LLM added later); design review is step 1.

### 2026-10-24 (evening)
Step 1 EXTRACT built (`R/extract_places.R`) and run on the seven published test
manuscripts; results above. ellmer 0.1.1 installed after a blocked first attempt
(an RStudio prompt; Kim cleared it).

### 2026-10-24 (night)
Step 2 LOCATE (Nominatim; GeoNames still refusing the username after Kim's setup at
19:51 -- propagation), steps 3 PLAN and 5 RENDER built; seven-map gallery reviewed.

### 2026-10-24 (late)
Step 4 REVIEW built (review.html, editable points.csv, author query, rerender);
pipeline wrapper pubmap(); all seven cases in review/; edit round trip verified.

### 2026-10-24 (pause)
Map tiles switched to Esri (OSM 403 from file:// pages); all review pages rebuilt and checked.
Kim (pausing): "a really big step forward today"; next he will try editor input himself
(coordinates in points.csv, as an author would supply), and retest GeoNames tomorrow.

### 2026-10-25 (morning)
- **GeoNames:** free server (http://api.geonames.org) answers for `kimbridges`; premium servers still refuse the
  username (viewAccount: "provide a valid username for the GeoNames Premium Web Service") -- account-side, Kim to check
  subscription / token / IP allow-list. Default host now the free server; `GEONAMES_HOST` switches to premium.
- **Fix:** `place_candidates()` now pools candidates from ALL gazetteers (first-to-answer used to win; GeoNames then
  displaced better Nominatim matches). Local admin words (desa, kecamatan, kabupaten, gampong, woreda, awraja, zone) ignored in name matching.
- **Result (7 cases):** located 99 -> 114 with no regressions; Chitwan 4 -> 12 (study VDCs Kaule, Jutpani, Siddi,
  Dahakhani; Gairibari, Supar), Simpson +3 (Pulchera, Wongitta), Yucatan +3. Kiteghe still missed (needs fuzzy/alternate-name search).
- **Selection rule widened:** gazetteer POINT types now include populated places, spots (homesteads, farms, airstrips),
  small water bodies and village-level admin units (ADM3-5); `administrative_unit` / `other` places of those types are drawn
  (as "Other place"). Simpson now shows its stations and waterholes; Chitwan its six study villages. Default backends: geonames + nominatim.
- All seven review folders rebuilt (points.csv regenerated; no editor edits existed).
- **Kim's editor test (11:47):** typed Kiteghe's coordinates and include = yes into points.csv, reran -- "worked great";
  the review page's correction instructions "especially helpful".
- **Fuzzy place-name matching (pass 3 of `locate_places()`):** for places still unfound, GeoNames fuzzy search
  (fuzzy = 0.7) inside a box around the study; accept only name similarity >= 0.75, right feature kind, and within
  max(30 km, 2 x median distance of the study's sites/towns). Marked partial + flag "spelling"; the author query
  says "spelled differently in the gazetteer". Result on 7 cases: exactly one hit, Kiteghe -> Kitege (4 km), no false matches.
  Lessons: GeoNames `isNameRequired=true` silently disables fuzzy; a radius built from country/province centroids let in
  Serampas -> Serampok (541 km) and Ghamshali -> Ghansali (wrong village) -- radius now from point places only.

### 2026-10-25 (afternoon) -- areas
- **New `R/plan_areas.R`:** parks/reserves (protected_area) and districts (administrative_unit) drawn as AREAS.
  Outline from OSM via Nominatim (`polygon_geojson`; lookup by OSM id, else name, else core name), only of the right
  class (boundary:administrative / protected_area / national_park / leisure:nature_reserve), within 100 km of the
  gazetteer position; clipped to the frame (the frame is still set by the points). Parks: pale green fill;
  districts: dashed grey outline; italic labels. Cached in `cache/areas/`.
- **Skipped (status in points.csv):** provinces/states (place_rank <= 8; the state lines already show them), areas
  covering > 90% of the frame, slivers (< 2% of frame and < 25% of the area inside), same name as a drawn point
  (Yucatan municipalities = towns); areas < 0.3% of the frame become points. include = no hides; include = yes forces.
- **Review page:** full outlines on the Leaflet map (green fill / dashed), tooltip "(area)".
- **Result:** Sumatra -- Kerinci Seblat NP + Merangin, Kerinci; Simpson -- Simpson Desert NP; Himalaya -- six districts;
  Shewa -- West Shewa, Jeldu. Lesson: Nominatim's first hit for "Chitwan District" was a BUILDING (District
  Development Office) -- hence the class filter. Windows writeLines saves CRLF: normalise before string edits.
- **Name placement (2026-10-25, after Kim's test):** Kim moved names by editing lon/lat -- that moves the PLACE,
  so the frame was re-planned ("often completely changed the map"). New points.csv columns move only the NAME:
  `label_pos` (N NE E SE S SW W NW | none) and `label_lon`/`label_lat` (exact spot; points get a leader line).
  Area names now join the automatic (repelled) placement with point names. Kim's four coordinate edits
  (Kerinci Seblat NP, Kerinci; Ethiopia, Jeldu district) restored to gazetteer positions and his chosen spots
  kept as label_lon/label_lat. Review-page instructions updated.
- **Stale-code incident:** pub_01/03/07 rerendered from Kim's console with PubMaps code loaded before the label
  change -> old points.csv format, label columns lost (not Excel). Fix: `pubmap()`/`pubmap_rerender()` now call
  `pubmaps_load()` (re-source all modules) every run. Lost name positions for Kerinci Seblat, Kerinci, Jeldu re-applied.
- **Name only:** `include = name` prints the name with no symbol (regions in capitals, italic grey), e.g. YUCATAN.
  Name-only labels count when choosing the inset corner (Yucatan centre was under the inset).
- **Editor's Guide (2026-10-25, evening):** Kim: one book, two parts, tight focus. Quarto book at
  `PubMaps/book/` (documents-series style): Part I Editor's Guide -- Preface, 1 Getting Started, 2 The Review Folder,
  3 Correcting the Map, Appendix (status/match tables, functions, env vars) drafted; 4 Worked Examples,
  5 Working with the Author, 6 Troubleshooting are stubs. Part II Methods later. Renders to `book/_output/`.
  Code fix while writing: `include = yes` on a park/district now draws the AREA (was forcing a point).
  Kim will use the guide for final testing.
- **R package (2026-10-26, Kim: "let's move this to a package"):** `pubmaps` 0.2.0 at `Projects/PubMaps/pubmaps/`
  (subfolder; book, review, cache stay siblings). Code separated from data: cache = option `pubmaps.cache` >
  env `PUBMAPS_CACHE` > `tools::R_user_dir`; review folders = `pubmaps.review` > `PUBMAPS_REVIEW` > `review` in wd.
  GeoNames no longer defaults to Kim's username -- skipped with a message if `GEONAMES_USERNAME` unset.
  ellmer types built at call time; explicit importFrom; `pubmaps_load()`/`pubmaps.home` retired (the package fixes
  the stale-code incident). Exports: pubmap, pubmap_rerender, extract_places, locate_places, plan_map, render_map,
  pubmaps_cache_dir, pubmaps_review_dir. 9 tests. `devtools::check()` 0 E / 0 W / 1 N (rnaturalearthdata/hires
  imported for data only). Regression: 7 cases rerendered in `C:/temp/pubmaps_regress_2026-10-26` old vs new --
  points.csv identical, drawn counts, areas, bbox, inset and PNG md5 all identical. Will McClatchey listed as ctb in
  DESCRIPTION -- Kim confirmed ("that was his role"). GitHub: deferred to the end of the project (Kim); use the
  local install meanwhile. Old code archived to `PubMaps/_archive/` (`R_sourced_2026-10-26/`, 11 files;
  `engines_2026-10-17/`, 6 pre-pipeline scripts incl. pubmap_tools.r) -- Kim: delete later.
- **Area-framed studies (2026-10-26, Kim's test of era_36_10, Borah et al., Dibrugarh + Majuli districts, Assam):**
  the paper names no villages; the study sites ARE two districts. Old behaviour: Majuli (GeoNames A:ADM3) drawn as a
  point, frame = 8 km minimum around it, Dibrugarh 'area outside the map frame'. Rule added: when no drawn point is
  anything but a district/park, `area_frame()` unions the study's district/park outlines (OSM place_rank > 8;
  states/countries excluded unless include = yes) and they set the frame; districts drawn as areas, not points;
  the inset corner also avoids the outlines (`area_corner_cover()`). Result: 187 x 144 km, both districts outlined,
  inset top-left. The 7 test maps byte-identical (rule does not trigger: Simpson has stations). Guide Ch 2 updated.
- **Rivers (2026-10-26, Kim: "adding rivers will likely be very useful, given the kinds of studies this cohort studies"):**
  new `plan_rivers.R`. Nominatim returns only single stretches of big rivers, so lines come from the OSM Overpass
  API (overpass-api.de; ~30 s per first query, cached in `cache/rivers`, retries on 429/5xx). Query: waterway
  river|canal, whole-word name match inside the frame; then KEEP ONLY ways whose core name equals the river's
  ("Dhauli Ganga" is not "Ganga" -- the first version drew every tributary). Lookup uses the editor's `label`, so a
  spelling can be fixed there. Drawn blue (#5b8db8) under points/district outlines, labelled at the middle of the
  longest stretch. include = yes no longer turns a river into a point. Statuses: drawn as river / river not found
  within the map / map server not reachable (redraw later) / same river as. Results: Brahmaputra (era_36_10),
  Alaknanda + Bhagirathi + Ganga (Himalaya), Mulligan (Simpson); not in OSM by name: Siriri (Kasigau), Ome
  (Shewa), Serampas (Sumatra). Other 5 test maps byte-identical. Bhagirathi label falls under
  the inset -- Kim 2026-10-26: no issue, leave it. Also: `pubmap_rerender()` now takes just the manuscript name (with or
  without .pdf) and its error names the review folder -- Kim had typed the guide's example path + .pdf.
- **Display options (2026-10-26, Kim: "Small, but important, changes"):** (1) inset shows the country name in
  capitals, placed on a grid inside the country at the spot nearest its centre whose text box clears the orange
  marker; `inset_label = FALSE` turns it off. (2) The ggplot legend is replaced by a full legend strip under the
  map (patchwork, mm layout, wraps to rows; lists every symbol, line and area drawn); `legend = FALSE` for journals
  that explain symbols in the caption. Both are arguments of `pubmap()` and `pubmap_rerender()` and are remembered
  per review folder (`display.rds`; NULL keeps the last choice). (3) Symbol key as caption prose (e.g. "Orange
  circles, study sites; ...; Inset: location of the map area (orange box) in India.") written to `symbol_key.txt`
  and shown on the review page with a Copy button -- Kim: "something the editor can copy and include with the
  manuscript. This is exactly in line with this being an editor's tool." Guide Ch 2 + Appendix updated.
- **Editor's Guide Part I fully drafted (2026-10-26 evening).** Preface: aim (the common map; manuscripts must name
  study areas and sites clearly), warning callout "Maps PubMaps does not draw" (plot layouts, sampling grids, data-
  coloured maps, multi-panel distant regions, author GIS layers), and the VECTOR point (Kim: many current maps are
  screenshots -> fuzzy; "This feature alone might make PubMaps useful to an editor"). Ch 2: Kasigau review page
  embedded live (`book/examples/kasigau_review.html`, scrolling iframe); maps described as first/second, not left/
  right. Ch 4 Worked Examples from real before/after redraws: Kiteghe confirm, Kerinci label move, Yucatan
  include = name, places left off on purpose (Assam status table, Tsavo parks), Shewa legend = FALSE (Chitwan dropped,
  Kim). Ch 5 Working with the Author (Kim): used on ACCEPTED manuscripts; map queries go with the other requested
  changes; author replies with coordinates in a simple email; attach map_vector.pdf; a messy map usually means an
  unclear manuscript -> text editing, editor decides; PubMaps removes friction. Ch 6 Troubleshooting (18 entries
  from the code's own messages). Kim: editors work on a computer, not a phone (wide tables OK).
- **2026-10-27 RELEASE (Kim: "complete Part I, publish to kimbridges-documents and do the GitHub repo", then share with Will McClatchey for input).**
  Cover + logo (Kim's images, `PubMaps_cover.png` 2550x3300, `PubMaps_logo.png` 1024 sq) in the book: web cover
  `images/pubmaps_cover.jpg` (1200 px), navbar logo `pubmaps_logo.png` (400 px), favicon. Independent proofread (fresh
  agent, guide vs code) found 16 factual + 4 consistency + 5 wording items; all fixed. Two were CODE fixes: pubmap()
  `model = NULL` now maps to the provider default (OpenAI gpt-6.1-sol, Anthropic claude-sonnet-5-5) -- before, provider
  = "anthropic" alone sent the OpenAI model name; and `legend`/`inset_label` default NULL so re-running pubmap() keeps
  the folder's display choice. Doc facts learned: retyping an unchanged lon/lat is not an edit (confirm = type it
  rounded to 4 dp); a new non-site row needs include = yes; area outside frame can't be forced. GitHub: PUBLIC
  https://github.com/kimbridges/pubmaps, clone `C:/repos/pubmaps`, commits 3c3fc4a (0.2.0) + 437dc03 (defaults),
  pushes verified against the server; install_github from the live repo installs 0.2.0 (8 exports). Check 0/0/1 note.
  Venue: `kimbridges-documents/pubmaps/` (39 files md5-matched to book `_output`), card `docs/pubmaps.qmd`
  (Maps, R, AI), `pubmaps/**` in resources; venue rendered to `_site` (25 cards; `_site/pubmaps` 39/39 md5). Awaiting
  Kim's Netlify drag of `_site`. Open: GEONAMES_HOST premium advice in Ch 1 (Kim's premium login still refused).
- **PUBLISHED 2026-10-27:** the Editor's Guide is live at https://kimbridges-documents.netlify.app/pubmaps/ (Kim's
  Netlify drag; card live on the listing). Verified from R: pages 200, cover/logo/review-page byte-identical to `_site`; HTML
  differs only by Netlify's pretty-URL link rewriting (`./index.html` -> `/pubmaps/`), and the proofread fixes are live.
  Kim will handle the GeoNames premium question with Will. Next: Kim shares with Will McClatchey; Part II Methods later.
