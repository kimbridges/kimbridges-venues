# PROJECT: bbSynth
_Last updated: 2026-05-30_
_Status: Active_
_Focus readiness: Ready_

## Type
R package

## Objective
Generate synthetic Braun-Blanquet datasets for testing and
demonstration. Produces synthetic blocks and synthetic gradients
with controlled structure so the bbstruct analysis tools (and the
Braun_Blanquet Quarto book's worked examples) can run against
known ground truth.

## Current Status
Small R package skeleton in place at G:\My Drive\Projects\bbSynth\
with DESCRIPTION, NAMESPACE, R/, and man/. Three R source files
plus the two corresponding .Rd files. Companion to bbstruct.

## Locations
- Code: G:\My Drive\Projects\bbSynth\R
- GitHub: not yet

## Key Files
- DESCRIPTION, NAMESPACE — R package skeleton
- R/bb_synth_blocks.R — synthetic block generator
- R/bb_synth_gradient.R — synthetic gradient generator
- R/bb_synth_helpers.R — shared helpers
- man/bb_synth_blocks.Rd — block-generator function help
- man/bb_synth_gradient.Rd — gradient-generator function help
- bbSynth.Rproj

## Related Projects — Braun-Blanquet Cluster

Four Projects work together around the Braun-Blanquet vegetation
analysis method:

- **bbstruct** — structural analysis tools for Braun-Blanquet
  tables. See `proj_bbstruct.md`.
- **bbSynth** (this file) — synthetic-data generator that creates
  the test datasets bbstruct exercises and the Braun_Blanquet
  Quarto book uses as worked examples.
- **Braun_Blanquet** — Quarto multi-chapter document about the
  Braun-Blanquet method, demonstrating both packages. See
  `proj_Braun_Blanquet.md`.
- **Ceska** — historical reference: 1991 COENOS executable and
  example data, the methodology being reconstructed. See
  `proj_Ceska.md`.

The synthetic datasets generated here (e.g.,
`synthetic_block_12x24`, `synthetic_gradient_12x24`) appear both
in bbstruct's `inst/extdata/` and `data/` and in
Braun_Blanquet's `data/` and `inst/extdata/`. Reconciling these
copies — keeping bbSynth as the generator of truth — is a small
cluster-level housekeeping item for later. The synthetic data
complements the historical Ellenberg, Dieren, and SET1/2/3
datasets preserved in Ceska — synthetic data exercises
controlled-structure cases, the Ceska data exercises real-world
relevé sets with known COENOS outputs.

## Next Steps
1. Confirm R CMD check passes cleanly.
2. Document the synthetic-data design choices (block size,
   gradient steepness, noise model) in the man pages or a
   short vignette.
3. Decide on a GitHub home and push.
4. Reconcile the duplicated synthetic CSVs across bbSynth,
   bbstruct, and Braun_Blanquet — bbSynth should be the source.

## Collaborators / Dependencies
- bbstruct (sibling package, consumer of the generated data)

## Blockers
None.

---
## Log

### 2026-05-28
Project file created during PKM housekeeping continuation. The
bbSynth folder was moved from Desktop to
G:\My Drive\Projects\bbSynth on 2026-05-27 as part of the broader
Desktop consolidation. Documented as one of three Projects in the
Braun-Blanquet cluster (bbstruct, bbSynth, Braun_Blanquet).

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Ready: small package skeleton;
clear next steps (confirm R CMD check, document the synthetic-data
design, choose a GitHub home). The synthetic-data generator half of
the Braun-Blanquet cluster. Part of the collection-wide back-fill;
see proj_PKM.md and session_log.md (2026-05-30).
