# PROJECT: Milestones & Bar-Timelines
_Last updated: 2026-05-28_
_Status: Complete_
_Focus readiness: Not applicable_

## Type
R package

## Objective
A table-driven way to create various timeline visualizations. One function
uses markers to indicate when events occur; the other builds bar-timelines
that show the duration of events as horizontal spans. Useful for any
time-structured dataset.

## Current Status
Completed 2023. Fully documented with examples. Canonical home is
G:\My Drive\Projects\milestones\, holding both the R package
skeleton at root and the documentation/ subfolder (the latter
migrated in on 2026-05-28 when the short-lived Projects\milestones_bars\
folder was retired). Status is Complete; no further development
planned.

## Locations
- Code: G:\My Drive\Projects\milestones (R/, DESCRIPTION, NAMESPACE,
  etc. — the R package skeleton at the project root)
- Docs/source: G:\My Drive\Projects\milestones\documentation
  (.qmd files: index, Introduction, Bar-timelines, Functions; plus
  Functions.R, cover_time_art.png, logo_time_art.png; rendered
  output under _output/)
- Documentation (published): https://kim.quarto.pub/milestones--bar-timelines/
- GitHub: https://github.com/kimbridges/milestones

## Key Files
- (Package source) — see Projects_Archive\milestones\R\ and the
  GitHub repository.
- documentation/index.qmd — documentation entry point
- documentation/Introduction.qmd — introduction chapter
- documentation/Bar-timelines.qmd — bar-timelines chapter
- documentation/Functions.qmd — functions reference
- documentation/Functions.R — backing R for the functions chapter
- documentation/cover_time_art.png, logo_time_art.png — cover/logo
- documentation/_output/ — rendered HTML output

## Next Steps
1. Check if the documentation matches current code, refreshed under
   the new archive location.
2. No active development planned. Project remains archived.

## Collaborators / Dependencies
None.

## Blockers
None. Project is essentially complete; low priority for further work.

---
## Log

### 2026-04-05
Project file created. Archived — completed 2023.

### 2026-04-14
Merged proj_milestones.md and proj_milestones_bars.md into single file.
Added next steps for documentation review.

### 2026-05-28 (documentation migrated into archive; redundant Projects copy deleted)
During the 2026-05-27 housekeeping survey a separate folder
G:\My Drive\Projects\milestones_bars\ was found with a
documentation/ Quarto subfolder (index.qmd, Introduction.qmd,
Bar-timelines.qmd, Functions.qmd, Functions.R, plus rendered
output and cover/logo art) that did not exist under the archive
location. The 2026-05-28 follow-up: Kim moved documentation/ into
G:\My Drive\Projects_Archive\milestones\documentation\ via
Windows Explorer; then deleted the rest of
G:\My Drive\Projects\milestones_bars\ after confirming its
remaining R package skeleton was redundant with the archive's.
Locations and Key Files sections of this file updated to point
at the new canonical paths. See session_log.md 2026-05-28 and
priorities.md.

### 2026-05-28 (Projects_Archive retired; folder moved back to Projects/; Status/Focus readiness fields adopted)
Following a strategy chat about whether Projects_Archive earned
its keep, the archive was retired. Kim moved
G:\My Drive\Projects_Archive\milestones\ back into
G:\My Drive\Projects\milestones\ (carrying the documentation/
subfolder along) and deleted the now-empty Projects_Archive folder.
The rationale: with only one project in it, the archive was
structural debt — a special-case second location that complicated
more than it simplified. Going forward, completion is signaled by
the new `Status: Complete` header field rather than by folder
location. milestones is the first proj_*.md to carry the new
Status and Focus readiness fields (Complete / Not applicable
respectively); template.md was updated in the same session and
pkm_protocol.md Mechanism 5 was sharpened to require an end-of-
session review of these fields for every project touched. Locations
and Current Status above updated to reflect the move back.
