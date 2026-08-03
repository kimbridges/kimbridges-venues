# PROJECT: whittakerr
_Last updated: 2026-05-30_
_Status: Complete_
_Focus readiness: Not applicable_
_Log: logs/proj_whittakerr_log.md_

## Type
R package + multi-chapter Quarto Document (deployment target:
kimbridges-documents). Hybrid project: the `whittakerr` R
package (installable from GitHub) provides the reusable
functions and bundled data; the Quarto Document demonstrates
their use through example-driven chapters and develops the
conceptual basis for the biome-classification framework.

## Objective
A set of tools and a published reference for examining one or
many sites against the Whittaker biome classification (annual
temperature × annual precipitation → biome polygons). The tool
side produces reusable R functions: biome naming from climate
values, basic Whittaker diagram plotting, climate-data retrieval
from coordinates, and possibly biome-characteristic queries. The
document side organizes the tools as a multi-chapter Quarto
project rendered to HTML and deployed to kimbridges-documents.
The biome classification is conceptually simple, the biome names
match observed vegetation intuitively, and the framework supports
substantive analyses (biome-of-place; biome-shift-under-climate-change;
ecotones; phenological transitions).

## Current Status
The `whittakerr` R package is built, validated, and published
(2026-05-20). It passes R CMD check (0 errors, 0 warnings, 1
benign Google-Drive-timestamp note) and installs from GitHub
via `devtools::install_github("kimbridges/whittakerr")` —
verified end-to-end with a fresh-session round trip. The
package exports eight functions (`name_biome`, `plot_biomes`,
`get_climate`, `map_biomes`, `smooth_biome_map`,
`plot_biome_map`, `biome_composition`, `export_biome_kml`) and
bundles four datasets (`Whittaker_biomes`, `Ricklefs_colors`,
`biome_palettes`, `biome_abbrev`).

Version 0.2.0 was rebuilt, installed, and pushed to GitHub on
2026-05-23. The 0.2.0 release adds the `scenario` argument on
`map_biomes()` for CMIP6 future projections and fixes
`plot_biome_map()`'s category-to-color assignment for maps
that hold only some of the nine biomes. It passes R CMD check
at 0 errors, 0 warnings, 1 benign timestamp note;
`library(whittakerr)` now loads the corrected functions, so
the document's map chapters render with correct colors without
`devtools::load_all()`.

The Quarto Document is complete in draft. Fifteen
chapters are fully drafted: Preface (`index.qmd`), History
(`history.qmd`), What Is a Biome? (`what_is_a_biome.qmd`),
Scale (`scale.qmd`), Getting Started
(`getting_started.qmd`), Retrieving Climate Data
(`retrieving_climate_data.qmd`), Basic Whittaker Diagrams
(`basic_whittaker_diagrams.qmd`), Color: more than
decoration (`color.qmd`), Retrieving Biome Information
(`retrieving_biome_information.qmd`), Roles, Not Rosters
(`biome_characteristics.qmd`), Transitions
(`transitions.qmd`), Build a Map (`build_a_map.qmd`),
Beyond a Map (`beyond_a_map.qmd`), Draped on Topography
(`draped_on_topography.qmd`), and Heuristic Value
(`heuristic_value.qmd`). The document's central
thesis — taking Whittaker's categories from subjective
expert proposal to objective verification using modern
climate data and computing — is established in the Preface.
No chapter remains undrafted. The technical chapters draft
against `library(whittakerr)` as their setup pattern.

The document is now built. A `_quarto.yml` scaffold was
created 2026-05-25 — a Quarto book, fifteen chapters,
title "Whittakerr," subtitle "Putting the Whittaker biome
diagram to work" — and the first full render
(`quarto preview`) produced all fifteen chapters intact,
every figure resolved. The early-chapter illustrations are
in place: the clean Whittaker diagram in the Preface and
the Oahu two-resolution pair in the Scale chapter. The
document was published 2026-05-25 to
https://kimbridges-documents.netlify.app/whittakerr/, the
fourteenth document in the kimbridges-documents collection.

## Locations
- **Package source / project root**: G:\My Drive\Projects\whittakerr\
  (canonical; under G:\My Drive\Projects\ per the storage
  architecture rule in proj_PKM.md). The directory is both an
  R package source and the Quarto Document source; `.Rbuildignore`
  separates the two for the package build.
- **R package code**: `R/` (whittakerr_functions.R,
  get_climate.R, map_biomes.R, export_kml.R, data.R,
  whittakerr-package.R). DESCRIPTION, NAMESPACE, man/ at root.
- **Package data**: `data/` now contains ONLY the package
  `.rda` files (Whittaker_biomes.rda, Ricklefs_colors.rda).
  Source CSVs and the build script moved to `data-raw/`
  2026-05-20. The botanical-gardens CSV moved to
  `inst/extdata/`.
- **Background materials**: G:\My Drive\Projects\whittakerr\background\
  (working notes, outlines, chapter ideation files).
- **Chapter sources**: chapter `.qmd` files at the project
  root (index.qmd, history.qmd, what_is_a_biome.qmd,
  scale.qmd; more to come). `_quarto.yml` not yet created.
- **WorldClim / GADM caches**: `cache/` (moved out of `data/`
  2026-05-20; the function defaults point here; excluded from
  git and the package build).
- **Documentation deployed** (planned): G:\My Drive\kimbridges-documents\whittakerr\
  (rendered HTML, deployed to kimbridges-documents.netlify.app).
- **GitHub**: https://github.com/kimbridges/whittakerr — the R
  package, pushed 2026-05-20. Installable via
  `devtools::install_github("kimbridges/whittakerr")`.

## Key Files
- Whittakerr_stuff.Rmd — current single-file source with the
  `name_biome` and `plot_biomes` functions plus inline tests.
  To be unbundled into chapter-level qmd files as the Document
  is drafted.
- background/Whittakerr Notes.md — Kim's outline of the Document:
  seven proposed chapters plus example-driven demonstrations
  plus a style note ("similar to other Documents"). The
  authoritative scope statement for the project.
- data/Bot_Garden_Geocode_CSV.csv — geocoded list of botanical
  gardens (Name, Sponsor, City, State, Area, ZIP, USDA
  Hardiness Zone, address, lon, lat). Source data for the
  Botanical Gardens example in the document.
- Whittakerr_climate.Rmd — `get_climate()` function plus test
  chunks and a California Botanical Gardens smoke test. Returns
  annual mean T and annual precipitation at one or more
  coordinates from WorldClim v2.1; supports historical and
  CMIP6 future scenarios under one signature. Created
  2026-05-13. To be unbundled into the Retrieving Climate Data
  chapter when the documentation scaffold exists.
- background/chapter_what_is_a_biome_ideas.md — ideation notes
  for a new conceptual chapter ("What Is a Biome?", provisional
  title) intended for Chapter 2 placement. Five threads
  developed, key quotes preserved verbatim, resumption
  checklist included. Created 2026-05-13.
- data/build_biome_data.R — one-time bootstrap script that
  downloads the Whittaker biome polygon .rda files from the
  plotbiomes GitHub repo and writes them as project-local
  CSVs (`data/whittaker_biomes.csv` and
  `data/ricklefs_colors.csv`). Created 2026-05-14 to remove
  the fragile plotbiomes → mapview dependency chain. Run once
  via `source("data/build_biome_data.R")`; idempotent on
  rerun.
- data/whittaker_biomes.csv — 775-row table of Whittaker
  biome polygon vertices (temp_c, precp_cm, biome_id, biome).
  Vendored from plotbiomes. The durable project-local source
  for `Whittakerr_stuff.Rmd`.
- data/ricklefs_colors.csv — 9-row biome/color table
  (biome, color hex code). Vendored from plotbiomes; colors
  originally extracted from the Ricklefs 2008 PostScript.
  Loaded as a named character vector in
  `Whittakerr_stuff.Rmd`.
- data/SOURCES.md — provenance and attribution for the
  vendored data files. Records the citation block for
  Ștefan & Levin 2018 (plotbiomes) and Ricklefs 2008
  (underlying scientific source), the digitization protocol,
  and the project's attribution commitment for future
  documentation. Created 2026-05-14.
- R/whittakerr_functions.R — canonical source for
  `name_biome()` and `plot_biomes()`. Both Rmds source this
  file rather than defining the functions inline. Created
  2026-05-14 to close a cross-notebook workflow seam (climate
  Rmd was failing on `plot_biomes()` because the function was
  defined in stuff.Rmd's chunks, which hadn't been run).
  Toward the eventual R-package structure.
- R/map_biomes.R — canonical source for `map_biomes()` and
  `plot_biome_map()`. Geographic biome mapping over a region
  polygon: fetch climate at chosen resolution (global at
  res >= 2.5; tile at 30 arcsec), crop and mask to region,
  apply `name_biome()` per cell, return a list with the
  classified raster + polygon + biome lookup. First concrete
  instance of `chapter_mapping_ideas.md` Thread 3
  (tessellation maps as foundation). Created 2026-05-16.
- Whittakerr_map.Rmd — notebook demonstrating `map_biomes()`
  on Oahu. Setup, GADM-based Oahu polygon fetch with
  bounding-box crop (Honolulu County legally includes the
  NW Hawaiian Islands, so the crop is required), smoke test
  at 2.5' resolution, the real run at 30 arcsec. Includes
  notes on expected biome assignments (windward Koolau wet,
  leeward south shore dry) and limitations. Created
  2026-05-16.
- background/chapter_3d_overlay_ideas.md — ideation file for
  the promoted 3D Overlay chapter (working title "Biomes on
  the Earth"). Created 2026-05-17 by promotion from
  `chapter_mapping_ideas.md` Thread 6. Carries the
  orographic-verification rationale that lifts the 3D
  overlay from rendering option to structural verification
  step; the mismatches-as-discovery thread (added 2026-05-17
  continued — fire and other ecosystem-level factors as the
  level-below-biome explanation for apparent classification
  failures); the cartography-lineage third leg (digital →
  immersive 3D); KML implementation paths; worked example
  catalog with verification surfaces for each candidate
  region.
- R/export_kml.R — canonical source for `export_biome_kml()`
  and helpers (`hex_to_kml_color`, `escape_xml`,
  `biome_style_id`, `geometry_to_kml`). Writes a biome_map
  to a KML file with per-biome Style elements, vector
  polygons, altitudeMode clampToGround, and tessellate=1 so
  Google Earth drapes the polygons over terrain. Created
  2026-05-17 (continued). Vector path only at this stage;
  raster GroundOverlay alternative deferred per the
  extension queue in `Whittakerr_3d.Rmd`.
- Whittakerr_3d.Rmd — notebook demonstrating
  `export_biome_kml()` on Oregon. Pipeline: fetch Oregon
  polygon via GADM level 1, run `map_biomes()` at 2.5'
  resolution (cache should already be populated from
  earlier Oregon work), smooth via `smooth_biome_map()`,
  export to `data/oregon_biomes.kml`. Includes instructions
  for opening in Google Earth, what to look for in the
  orographic-verification view (Cascades crest, Coast
  Range, Klamath, high desert), and a discussion of
  mismatches-as-discovery cases worth investigating
  (ponderosa fire ecology, riparian gallery forests,
  serpentine endemics). Created 2026-05-17 (continued).

## Document Structure (per background/Whittakerr Notes.md)

### Chapter Status

| # | Chapter | Status | Source / Notes |
|---|---------|--------|----------------|
| 1 | History of Biome Identification | drafted (2026-05-12) | Pure prose. Six sections: intro, Robert Whittaker (with personal observation), The Five Kingdoms (with 1969 talk recollection), Two Views of Biomes (biome map + Whittaker diagram distinguished), Classification as Art, Product versus Process. References images/Vegetation_no_legend.png. File: history.qmd. |
| 2 | Getting Started | drafted (2026-05-20) | `getting_started.qmd`. Short verification chapter: install whittakerr from GitHub, load it, two smoke tests (`name_biome`, `plot_biomes`), the setup-chunk pattern, the cm units convention. Sitemaps API setup dropped (Sitemaps is not a whittakerr dependency). |
| 3 | Retrieving Climate Data | drafted (2026-05-21) | `retrieving_climate_data.qmd`. Complete: intro, the WorldClim background section, the setup chunk, and five worked examples — Honolulu single-point; three Pacific-coast cities; a finer-resolution 30-arcsecond comparison on leeward Oahu; a CMIP6 future-scenario projection of the three cities; and the 65 California botanical gardens read from the bundled CSV via `system.file()`. The future-climate section carries a short GCM/SSP/period explanation with citations (Eyring et al. 2016; Riahi et al. 2017; IPCC AR6 WG1 2021). Code verified chunk by chunk on 2026-05-21, the 30-second tile retrieval confirmed at 8.1 MB; full Quarto render still to come. |
| 4 | Basic Whittaker Diagrams | drafted (2026-05-21) | `basic_whittaker_diagrams.qmd`. Demonstrates `plot_biomes()`: the bare diagram, one point (Honolulu), several points (the three Pacific-coast cities), labels and the `source` caption, and the California gardens as the larger example. Brief colors note with a forward reference to the Colors chapter. Closes on the bundled `Whittaker_biomes` and `Ricklefs_colors` data, answering the plot-data-extraction open question: both are exported datasets, so the diagram is not a black box. |
| 5 | Retrieving Biome Information | drafted (2026-05-22) | `retrieving_biome_information.qmd`. Point retrieval with `name_biome()` (Honolulu; the three Pacific-coast cities); `biome_composition()` used to give a retrieved point its regional context (Bend in Oregon); closes on the distance-to-boundary limitation as the gateway to Transitions. Reworked per Kim: all library calls in the setup chunk, `gt()` tables establishing data-frame structure before use, the Oregon map guarded with `exists()` so the chapter stands alone. |
| 6 | Roles, Not Rosters | drafted (2026-05-22) | `biome_characteristics.qmd`. Retitled from the placeholder "Biome Characteristics". Opens on the James MacMahon IBP Desert Biome small-mammal story (functional groups; the predicted animal); functional structure as a biome's defining characteristic; convergent evolution; humans as biome inhabitants. Ideation: `background/chapter_biome_characteristics_ideas.md`. |
| 7 | Transitions | drafted (2026-05-22) | `transitions.qmd`. Discussion chapter: the biome boundary as a zone, the ecotone in space and the climate shift in time. Historical-vs-future Oregon maps; the rare-species side note. |
| — | Preface (index.qmd) | drafted (2026-05-18) | Six paragraphs, ~580 words. Establishes the document's central thesis: using modern climate data (WorldClim) and modern visualization tools to take Whittaker's categories from subjective expert proposal to objective verification. Names the two historical roadblocks (climate-data sparsity, manual cartography); carries Kim's first-person witness from IBP Desert Biome era on weather-station costs; notes the history-of-science pattern (tools from outside the discipline enabling discovery). |
| — | What Is a Biome? | drafted (2026-05-18) | `background/chapter_what_is_a_biome_ideas.md` was the source. Full draft at `what_is_a_biome.qmd`, ~2,440 words, six sections: opening (ecology + diagram as bridge to eons of evolution), What a category does (categories as priors; rain-forest worked example), Why nine biomes? (bias-variance tradeoff + display constraint), Why two axes? (descriptor space dimensionality), Function, not identity (the spine — life forms over taxonomy, Amazon/Congo/Borneo convergence), The axes everyone knows (lived experience + the gradient-ecologist closing). |
| — | Scale: the unstated dimension | drafted (2026-05-18) | `background/chapter_scale_ideas.md` was the source. Full draft at `scale.qmd`, ~2,830 words, seven sections plus the cartographic-vs-ecological vocabulary table: opening (scale as unstated dimension), The three scales (spatial / temporal / organizational), The diagram's three answers (Whittaker's specific scale choices), Oahu at two resolutions (the canonical worked case — 2.5' averages dry pockets away; 30 arcsec reveals them), Naming the rank (taxonomy parallel), Words instead of ratios (cartographic-vs-ecological vocabulary, with sidebar table), A career across scales (Goodall biographical material — PhD advisor; biome → ecosystem migration as scale-awareness-through-practice), Making scale explicit (closing prescription). The chapter resolves its own title in the closing line. |
| — | Scale | ideation only | `background/chapter_scale_ideas.md`. Resolution choice IS finding-visibility choice — operationalized by the Oahu canonical example (dry pockets average away at 2.5'; appear at 30 arcsec). |
| — | Color: more than decoration | drafted (2026-05-22) | `color.qmd`. Standalone chapter after Basic Whittaker Diagrams. Spine: the informative-versus-useful tension in palette design. Conceptual half: the tension, the iconic Ricklefs palette, where it fails. Demonstrative half: the candidate-palettes comparison (ricklefs, cvd, grayscale, stacked full-width); the resolution as a second channel (the `biome_abbrev` key table and the labeled ricklefs diagram); the maps-complication section (the Oregon map under the custom palette), closing as a gateway to the Mapping chapter. Toolkit: `biome_palettes`, `biome_abbrev`, and `biome_labels` on both plotting functions. See `background/chapter_colors_palettes_ideas.md` Thread 1. |
| — | Build a Map | drafted (2026-05-22) | `build_a_map.qmd`. First chapter of the split Mapping material (the single "Mapping Biomes" chapter was split in two on 2026-05-22). Mapping as the document's destination; the pre-digital cartography setting (Kim's UHM witness); the `map_biomes()` pipeline on Oahu at 30 arcsec; the "Outside Whittaker range" honesty point; a second worked example (Venezuela at 2.5') as how to map a place of one's own, with a `geodata::country_codes()` reference. |
| — | Beyond a Map | drafted (2026-05-23) | `beyond_a_map.qmd`. Second chapter of the split, built on Kenya. Five sections: on-ramp and setup; Anchors (points and labels as anchors, two-color city/preserve overlay); Measuring the map (`biome_composition()`, region-oriented); Smoothing the edges (`smooth_biome_map()`, grid vs vector — Kenya country smooths well, Mount Kenya at 30 arcsec shows the single-cell circle artifact); An argument, not a fact (methodological close — a biome map as argument, hands off to Biomes on the Earth). Thread 5 (boundary representation) dropped — never built. Ideation: `background/chapter_mapping_ideas.md`. |
| — | Draped on Topography | drafted (2026-05-24) | `draped_on_topography.qmd`. The 3D-overlay chapter, built on Kenya. Seven blocks: the opening (Kim's drive into the Great Rift Valley); Setup; A map that should fit the terrain (the orographic-verification idea); Draping the map (`export_biome_kml()`, plus a downloadable Kenya KML); Reading the draped map (Mount Kenya and the Rift, from Kim's Google Earth renders); Where the map and the Earth disagree (mismatches as discovery, the Maasai Mara, falsifiability); Back to the ground (the close — cartography lineage, the document's arc). Working title set 2026-05-24, replacing "Biomes on the Earth". Ideation: `background/chapter_3d_overlay_ideas.md`. |
| — | Heuristic Value | drafted (2026-05-24) | `heuristic_value.qmd`. The document's closing chapter — reflective prose, no code (the only chapter without a code chunk). An opening and four sections: the opening (heuristic value defined; the Whittaker diagram's value long only potential, locked by sparse climate data and hand cartography); From assent to use (the unlocking — data, computation, the toolkit; potential becomes realized; the document's discoveries; naming as the engine); The lines are ours (the warning kept brief — a classification is scaffolding, not the building); What it leads to next (the in-between as frontier — the bird-photographers' "three places," the Solomon Islands inversion, naming the ecotones); The close (a realized heuristic keeps leading; the document ends pointing past its own edge). Title "Heuristic Value" (Kim, 2026-05-24). Spine: the distinction between the diagram's potential and realized heuristic value, recorded as Thread 7 in `background/chapter_concluding_ideas.md`. With it drafted, the document is complete in draft. |

Numbering note: the 1–7 rows reflect the original outline
positions from `background/Whittakerr Notes.md`. The five "—"
rows are chapters that emerged from ideation during the
2026-05-13 through 2026-05-17 sessions. Final renumbering
will happen when the documentation scaffold (`_quarto.yml`
and chapter qmd files) is created. Proposed full sequence
(Colors moved adjacent to Basic Whittaker Diagrams
2026-05-21): History → What Is a Biome? → Scale → Getting
Started → Retrieving Climate Data → Basic Whittaker Diagrams
→ Color → Retrieving Biome Information → Roles, Not Rosters
→ Transitions → Build a Map → Beyond a Map → Draped on
Topography → Heuristic Value.

### Example-Driven Demonstrations (per the outline)

- **Botanical Gardens**: range of biomes occupied by a set of
  gardens (e.g., California); shifts under climate change;
  comparative susceptibility. Data ready: Bot_Garden_Geocode_CSV.csv.
- **Comparing distant places**: Southern California vs South
  Africa; Japan vs Washington. Tests cross-continental biome
  matching.
- **Biomes shown on maps**: color-coded biomes as dots on a
  map; longitudinal gradients (Japan, Europe). The Sitemaps
  package would be the tool here.

## Architecture (intended)
- Quarto website project (type: book or website, TBD in template
  survey) with chapter files in a documentation/ subfolder.
- Rendered HTML deployed to G:\My Drive\kimbridges-documents\whittakerr\
  and served by kimbridges-documents.netlify.app.
- Listing stub in kimbridges-documents/docs/whittakerr.qmd (to be
  created per the kimbridges-documents pattern).
- Style: "similar to the other Documents" — to be codified in
  style_multichapter_doc.md after the template survey (task #15).

## Next Steps
1. Survey one existing kimbridges-documents multi-chapter item
   (storylines is Kim's chosen template — task #15) to extract
   the implicit conventions.
2. Draft `style_multichapter_doc.md` in Projects_Index from the
   survey plus Kim's preferences. This becomes the reference for
   all future multi-chapter documents.
3. Create `Projects/whittakerr/documentation/` with the chapter
   scaffold (qmds, _quarto.yml, custom.css per the style guide).
4. Draft the History chapter first (pure prose, no code
   dependencies, foundational for downstream chapters — task #16).
5. Unbundle the two existing functions from Whittakerr_stuff.Rmd
   into the Basic Whittaker Diagrams and Retrieving Biome
   Information chapters.
6. Build the missing pieces: climate data retrieval,
   biome-characteristic queries, the transitions discussion.
7. Develop the three example demonstrations, starting with the
   Botanical Gardens example using the staged CSV.
8. Render, deploy to kimbridges-documents, update the
   kimbridges-documents listing stub.
9. Decide whether the climate-data retrieval and/or the diagram
   data extraction become separate tool projects with their own
   proj_*.md entries.
10. Refactor `Whittakerr_stuff.Rmd` to source its function
    definitions from `R/whittakerr_functions.R` rather than
    defining them inline. The inline copies are currently
    redundant duplicates and a drift hazard. Could either be
    replaced with a single `source("R/whittakerr_functions.R")`
    call, or converted to display-only (`{r eval=FALSE}`)
    chunks that show the function source for teaching while
    not redefining the runtime versions. Queued 2026-05-14.
11. Generate and save chapter figures that aren't yet on
    disk. Two specifically noted during 2026-05-18 chapter
    drafting:
    - **Clean Whittaker diagram** for the Preface. Produced
      by `plot_biomes()` called with no point arguments.
      Save as `images/whittaker_diagram_clean.png` or similar.
    - **Oahu side-by-side comparison** for the Scale
      chapter's "Oahu at two resolutions" section. Two
      panels: biome map at 2.5-minute resolution (essentially
      uniform across the island) and at 30-arcsecond resolution
      (subtropical desert pockets at Kaena Point and the
      Waianae lee). Produced by `map_biomes()` + `plot_biome_map()`
      at the two resolutions. The maps were generated during
      the 2026-05-16 mapping work but not persisted; needs
      a regeneration + save cycle. Save as
      `images/oahu_2.5min_vs_30arcsec.png` or similar.
    Both figures are produced by code that already exists.
    This is a capture-and-save task, not a development task.
    Queued 2026-05-18.
12. [COMPLETED 2026-05-20] Package whittakerr as an
    installable R package, GitHub-hosted at
    `kimbridges/whittakerr`. Done: DESCRIPTION and NAMESPACE
    created; all function header comments converted to
    roxygen2; `Whittaker_biomes` and `Ricklefs_colors`
    bundled as package data; `data-raw/build_biome_data.R`
    is the maintainer rebuild script; package passes R CMD
    check (0 errors, 0 warnings, 1 benign note); pushed to
    GitHub; `install_github("kimbridges/whittakerr")`
    verified via fresh-session round trip. See the 2026-05-20
    log entry below for the full sequence.
13. Add per-point styling capability to `plot_biomes()`:
    `point_color`, `point_size`, possibly `point_shape` as
    optional vector arguments (one value per point, parallel
    to `mean_temp_c` and `total_ppt_cm`). Useful for figures
    that distinguish gardens by size-encoded population,
    species count, or biome assignment. Noted from the
    2026-05-18 Sitemaps review — Sitemaps uses optional
    table columns extensively for styling control. For
    whittakerr the simpler vector-argument approach is
    appropriate; the table-column approach would over-
    engineer for the project's needs. Queued 2026-05-18.

## Collaborators / Dependencies
- ElevenLabs / external services: none for now.
- Climate-data service: the 2.5-minute coordinate-based service
  referenced in the outline (e.g., WorldClim) — to be confirmed
  during Chapter 3 drafting.
- R packages: `sp`, `tidyverse`, `ggplot2`, `geodata`, `terra`
  — per `Whittakerr_stuff.Rmd` and `Whittakerr_climate.Rmd`.
  The `plotbiomes` package was removed as a dependency on
  2026-05-14 after upstream mapview install failures on
  Windows R 4.3; the biome polygon data and Ricklefs colors
  are now vendored as project-local CSVs (see
  `data/build_biome_data.R` and the data CSVs above). The
  Sitemaps package is mentioned for the planned maps
  demonstration.

## Blockers
None active. The original blocker note ("Simply fell off the
radar. This is an old R routine that needs rediscovery and
assessment.") is resolved: the project is back on the radar,
the assessment is done, and the path forward is the Document
build above.


---
## Log

The dated log for this project was split out on 2026-07-28 and now lives in
`logs/proj_whittakerr_log.md`. It is verbatim and unedited. New entries go there.
