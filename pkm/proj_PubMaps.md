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
