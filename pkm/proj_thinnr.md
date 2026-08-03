# PROJECT: thinnr
_Last updated: 2026-05-30_
_Status: Active_
_Focus readiness: Exploring_

## Type
R package

## Objective
A photo-thinning utility: identify subsets of photos worth keeping
from a larger shoot. Uses EXIF metadata to detect burst sequences,
panorama candidates, and other patterns that make some photos
redundant or higher-value than their neighbors. Intended for
post-shoot triage workflows where a day's shoot produces thousands
of photos and the goal is to surface the keepers without manually
reviewing every frame.

## Current Status
Early R package skeleton at G:\My Drive\Projects\thinnr\ with
DESCRIPTION, NAMESPACE, R/extract.R, scripts/explore.R, and a
small set of bundled example data (`exif_extract.csv`, `shots.csv`,
`shots_with_bursts.csv`). Three illustration PNGs at root
(`sample_burst_sequence_details.png`,
`candidate_panorama_sequences.png`, `potential_ground_shots.png`)
suggest the visualization output the package produces. Function
scaffolding present; depth of implementation TBD.

## Locations
- Code: G:\My Drive\Projects\thinnr\R
- Data: G:\My Drive\Projects\thinnr\data
- Scripts: G:\My Drive\Projects\thinnr\scripts
- GitHub: not yet

## Key Files
- DESCRIPTION, NAMESPACE — R package skeleton
- R/extract.R — extraction logic
- scripts/explore.R — exploratory work
- data/exif_extract.csv — EXIF extraction sample
- data/shots.csv — shot-level data
- data/shots_with_bursts.csv — burst-annotated shots
- man/hello.Rd — placeholder help page
- sample_burst_sequence_details.png — burst-detection illustration
- candidate_panorama_sequences.png — panorama-detection illustration
- potential_ground_shots.png — ground-shot illustration
- thinnr.Rproj

## Next Steps
1. Catalog the existing R functions and decide which are
   production-ready vs. exploratory.
2. Develop the package interface (exported functions, help pages).
3. Add a vignette walking through a thinning workflow on a
   sample shoot.
4. Decide on a GitHub home and push.

## Collaborators / Dependencies
None.

## Blockers
None.

---
## Log

### 2026-05-28
Project file created during PKM housekeeping continuation. The
thinnr folder was moved from Desktop to G:\My Drive\Projects\thinnr
on 2026-05-27.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Exploring: an early package
skeleton with function scaffolding; depth of implementation is TBD,
so it needs cataloging and interface decisions before focused work.
Part of the collection-wide back-fill; see proj_PKM.md and
session_log.md (2026-05-30).
