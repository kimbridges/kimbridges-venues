# PROJECT: tessellr
_Last updated: 2026-09-27_
_Status: Complete_
_Focus readiness: Not applicable_
_Tags: R package, companion to a published document_

## Type
R package (companion to the Quarto document *The Map That Never Got Drawn*, published 2026-09-27 at kimbridges-documents/voronoi/).

## Objective
Give other people the tools the Voronoi document developed: tiles trimmed to a frame, per-tile measures, counts inside tiles (with the location-precision rule and Koch-style Poisson tests), weighted service areas, a canopy-height fetch for ANY area (Meta/WRI global 1 m map), structure classes, structure-constrained Voronoi, outline tracing, and area/boundary agreement between maps. Kim's rationale (2026-09-27): packages are how we actually give other people access to the tools we develop.

## Current Status
**COMPLETE 2026-09-27 (Kim).** v0.1.0 public at https://github.com/kimbridges/tessellr, installable with `remotes::install_github("kimbridges/tessellr")`; 12 functions + `kipuka_frame()` + `kipuka_releves`; 92 tests; R CMD check 0 errors / 0 warnings / 2 routine notes. Documented in the book's Appendix (function reference). Future versions: open a new Active phase here.

Opened 2026-09-27 (evening). Kim approved the API (12 functions in 5 groups) and the build order: tiles, containers, canopy, weights, checking. **Tiles group DONE:** tile_points (frame, clip 'all'/'inside'), tile_measures, tile_pattern (CV vs random trials in the same frame), merge_tiles, boundary_bands; plus data `kipuka_releves` and `kipuka_frame()`. testthat: 26 expectations green, reproducing the document's numbers (10 of 12 edge tiles, 12 -> 6 patches, 15 boundaries +/-170-629 m).

## Locations
- Code: `G:\My Drive\Projects\tessellr` (package root, checklistr layout)
- Source of the methods: `G:\My Drive\Projects\Voronoi` (chapter code, data, `R/make_*` scripts)
- Folded-in code: `G:\My Drive\Projects\Koch_voronoi\voronoi_functions.R` (compute_voronoi, assign_to_cells, compute_cell_statistics -- Poisson per cell + chi-squared)
- GitHub: **LIVE -- https://github.com/kimbridges/tessellr** (public; `remotes::install_github("kimbridges/tessellr")`); git working clone `C:\repos\tessellr` (bucket 5), copied from G: with md5 match

## Key Files
- DESCRIPTION, LICENSE(.md), .Rbuildignore, tests/testthat.R -- skeleton
- R/tiles.R -- the tiles group; R/data.R -- kipuka_releves docs + kipuka_frame(); R/tessellr-package.R
- tests/testthat/test-tiles.R -- checks against the document's numbers
- R/containers.R -- count_in_tiles()
- tests/testthat/test-containers.R
- tests/testthat/test-allocation.R -- the proportional rule
- R/canopy.R -- canopy group
- tests/testthat/test-canopy.R -- incl. local-only Ch.8 replication and an online fetch test
- R/weights.R, R/checking.R -- the last two groups
- tests/testthat/test-weights.R, test-checking.R
- Staging for files written in the cloud: C:\temp\tessellr_staging (granted to the session; md5-checked before copying into G:)

## Related Projects
- [proj_Voronoi.md](proj_Voronoi.md) -- the document; its Appendix says the package is in preparation, and gets a function reference when tessellr ships.
- [proj_Koch_voronoi.md](proj_Koch_voronoi.md) -- Tom Koch's epidemiological Voronoi tool; its functions fold in here.
- Trilogy: *Maps with Tiles* will call tessellr instead of repeating the mechanics.

## Next Steps
1. ~~Kim's OK on the API~~ DONE; ~~tiles group~~ DONE.
2. Tiles group + tests; then containers, weights, canopy, checking.
3. roxygen, load_all, testthat, R CMD check (async job past the bridge timeout).
4. Replace the document Appendix's function table with a function reference; GitHub.

## Collaborators / Dependencies
Claude (co-author). Tom Koch (origin of the counting/testing code). Meta/WRI canopy map (keyless S3 over /vsicurl).

## Blockers
None.

---
## Log
### 2026-09-27
Opened. Name `tessellr` ruled by Kim. Skeleton written in the checklistr layout.
Tiles group written, roxygen docs generated, 26 tests green. Deviation from the proposed signatures: boundary_bands(tiles, by, frame) -- tiles record their point's coordinates, so no separate `points` argument is needed.
**Containers group DONE:** count_in_tiles(tiles, records, frame, uncertainty, by, test) -- counting frame, location-uncertainty rule (a record counts only if its uncertainty circle stays inside its tile; otherwise reported as `excluded`), counts by category, Poisson test per tile with Holm adjustment + chi-squared (simulated when small), from the Koch_voronoi code. Tests 43 green, incl. a local-only replication of Ch.6 (87 specimens in the frame; R08 17 -> 0 once rounded coordinates carry 1 km uncertainty). Found en route: a stack of ten 'precise' specimens sits 8 m from a tile border -- the uncertainty rule would drop them at 10 m.
Kim asked for the proportional case now: count_in_tiles(allocation = c('exclude','proportional')). Proportional shares each uncertain record among the tiles its circle overlaps (fractional counts; circle parts beyond the frame reported in `excluded`; tests on rounded counts). Tests 55 green (new test-allocation.R). Ch.6 specimens, R08: all 17 / exclude 0 / proportional 3.6.
**Canopy group DONE:** get_canopy_height(frame, resolution) -- zoom-9 quadkeys covering ANY frame, reads only the overlapping part of each Meta/WRI tile over /vsicurl, merges, averages to the frame's grid (Kipuka quadkey = 022300033, as in the document; online test matches the document's canopy file within 0.2 m); structure_classes(canopy, breaks, labels, smooth, mmu_ha); trace_patch(canopy, seed, height = 8) -- reproduces the 94.5 ha kipuka; constrained_voronoi(points, type, classes, constrained, point_class, mmu_ha) -- two layers `type` + `sampled`; reproduces Ch.8 (point classes, 51% plain/constrained disagreement, 11% unsampled). A field-recorded class can override the map via `point_class` (the document's 'that record should win'). Tests 73 green.
**Weights + checking groups DONE -- all 12 functions written.** weighted_areas(sites, weights, frame, cell) -- distance/weight on a grid (touches = TRUE so no coastal tract is lost), polygons per site; test: the weaker site's area is the Apollonius disk, and Ch.7 people per garden within 0.7% (plain and by acres). map_agreement(map, reference, tolerance = 50) -- compares by label for categorical rasters; reproduces Ch.9 exactly (plain 45% / 17%; constrained 56% / 58% / 54%; 107 vs 51 km). Tests 92 green.
**v0.1.0 RELEASED 2026-09-27.** README (install, first map, function table, authors incl. Tom Koch credit); DESCRIPTION 0.1.0 + URL/BugReports; README example run end to end (canopy fetch 10 s). GitHub repo created with gh (Kim's PAT), clone at C:/repos/tessellr (36 files, md5-matched to G:, secret scan clean), commit 510426a pushed and VERIFIED against the server; `install_github` from the live repo installs 0.1.0 with 13 exports and runs. Document Appendix now has a 'tessellr package' section (install + function reference from `data/appendix_tessellr.csv`, generated from the package's formals and Rd titles); Ch.10 points to it; site rebuilt for Kim's Netlify drag.
Kim ruled COMPLETE 2026-09-27 after confirming the live Appendix reference.
