# PROJECT: labelextractr
_Last updated: 2026-05-30_
_Status: Active_
_Focus readiness: Ready_
_Tags: finishing_

## Type
R package

## Objective
Extract and visualize the specimen locations from herbarium sheets.

## Current Status
The code seems to work, but there is no progress toward a package
or documentation. Everything is bundled in a single .Rmd file.

## Locations
- Code: Projects/labelextractr
- Data: To be identified
- Docs/output: Projects/labelextractr/documentation
- Documentation: Not yet
- GitHub: Not yet

## Key Files
- label-processing.Rmd — does everything (needs unbundling)

## Next Steps
1. Extract the functions and build R files
2. Extract the descriptions and start building the documentation
3. Upgrade with an OCR engine

## Collaborators / Dependencies
None

## Blockers
Will need several extensive sets of herbarium sheet images for
testing. Not yet acquired.

---
## Log
### 2026-04-14
Project file cleaned up and standardized. Fixed missing section
header for Current Status.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Ready, Tag finishing:
mostly-complete code bundled in a single .Rmd; the remaining work
is packaging to the standard structure — the same quick-win
category as photothumbsr (Kim, 2026-05-30). The herbarium-image
acquisition for an OCR upgrade is a separate, later enhancement,
not a blocker on packaging. Part of the collection-wide back-fill;
see proj_PKM.md and session_log.md (2026-05-30).
