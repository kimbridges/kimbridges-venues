# PROJECT: bbstruct
_Last updated: 2026-05-30_
_Status: Active_
_Focus readiness: Ready_

## Type
R package

## Objective
Structural analysis tools for Braun-Blanquet vegetation tables.
Provides functions for reading and validating block data, reordering
blocks by site and species groupings, computing structural metrics,
and rendering Braun-Blanquet tables using gt for publication-quality
output. One of two R packages in the Braun-Blanquet cluster; the
companion package bbSynth generates the synthetic test datasets
this package operates on.

## Current Status
R package skeleton in place at G:\My Drive\Projects\bbstruct\ with
DESCRIPTION, NAMESPACE, R/, man/, data/, inst/extdata/, tests/, and
vignettes/. Functions cover the validation, group-finding, metrics,
reordering, and gt-rendering work; one vignette
(`v01-walkthrough-blocks.Rmd`) walks through the typical workflow.
Bundled example data (`bb_ex`, `bb_blocks_unordered_A.csv`,
`inst/extdata/example_block.csv`) provides ready-to-run inputs.

## Locations
- Code: G:\My Drive\Projects\bbstruct\R
- Data: G:\My Drive\Projects\bbstruct\data,
  G:\My Drive\Projects\bbstruct\inst\extdata
- Tests: G:\My Drive\Projects\bbstruct\tests\testthat
- Vignettes: G:\My Drive\Projects\bbstruct\vignettes
- GitHub: not yet

## Key Files
- DESCRIPTION, NAMESPACE — R package skeleton
- R/aaa-package.R — package boilerplate
- R/blocks.R — block construction
- R/groups-sites.R, R/groups-species.R — group-finding
- R/bb_reorder_blind.R, R/bb_reorder_pca.R, R/reorder-core.R —
  reordering algorithms
- R/metrics.R, R/bb_metrics_tbl.R, R/bb_metrics_gt.R —
  structural metrics
- R/bb_gt.R, R/bb_gt_color.R, R/bb_gt_color_layer.R,
  R/bb_gt_with_site_attribute.R, R/bb_gt_table.R, R/render-gt.R —
  gt rendering
- R/io-read.R, R/validate.R — I/O and validation
- R/bb_from_raw_data.R — raw-data entry point
- R/data-bb_ex.R, data/bb_ex.rda — bundled example dataset
- inst/extdata/example_block.csv — example block data
- data/bb_blocks_unordered_A.csv — additional example data
- tests/testthat/test-validate.R, test-metrics.R — unit tests
- vignettes/v01-walkthrough-blocks.Rmd — workflow walkthrough
- bbstruct.Rproj, LICENSE

## Related Projects — Braun-Blanquet Cluster

Four Projects work together around the Braun-Blanquet vegetation
analysis method:

- **bbstruct** (this file) — structural analysis tools for
  Braun-Blanquet tables (reorder, metrics, gt rendering). The
  active reconstruction of the historical Ceska methodology.
- **bbSynth** — synthetic-data generator that creates the test
  datasets bbstruct exercises. See `proj_bbSynth.md`.
- **Braun_Blanquet** — Quarto multi-chapter document about the
  Braun-Blanquet method, demonstrating both packages. See
  `proj_Braun_Blanquet.md`.
- **Ceska** — historical reference: the 1991 COENOS compiled
  Pascal executable plus example data, preserved as ground
  truth for the reconstruction work happening in bbstruct.
  When bbstruct produces a table on one of the Ceska example
  datasets, the test of correctness is matching the table
  COENOS produced. See `proj_Ceska.md`.

The pattern mirrors whittakerr: R package(s) plus a Quarto
Document that uses them as the primary worked example. The
additional Ceska reference makes the cluster a reconstruction
effort rather than a from-scratch toolkit — the methodology
existed in 1991, was implemented in compiled Pascal, and is
being recovered in modern R because the source is lost.

## Next Steps
1. Confirm R CMD check passes cleanly.
2. Expand vignette coverage (currently one walkthrough) to cover
   the metrics and gt-rendering paths.
3. Decide on a GitHub home and push.
4. Cross-reference with the Braun_Blanquet Quarto book so the
   document's worked examples use `library(bbstruct)`.

## Collaborators / Dependencies
- bbSynth (sibling package, generates synthetic test data)
- gt (Posit) — table rendering

## Blockers
None.

---
## Log

### 2026-05-28
Project file created during PKM housekeeping continuation. The
bbstruct folder was moved from Desktop to
G:\My Drive\Projects\bbstruct on 2026-05-27 as part of the broader
Desktop consolidation. The Braun-Blanquet cluster (bbstruct,
bbSynth, Braun_Blanquet) is documented as a unit; bbstruct is the
structural-analysis half, bbSynth is the synthetic-data half, and
the Braun_Blanquet Quarto book is the document that explains and
demonstrates both.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Ready: full package skeleton
with tests and a vignette; clear next steps (confirm R CMD check,
expand vignette coverage, choose a GitHub home). The active
reconstruction half of the Braun-Blanquet cluster. Part of the
collection-wide back-fill; see proj_PKM.md and session_log.md
(2026-05-30).
