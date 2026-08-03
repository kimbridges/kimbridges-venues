# PROJECT: Community_Analysis
_Last updated: 2026-05-30_
_Status: Active_
_Focus readiness: Exploring_

## Type
R functions (utility; small but focused)

## Objective
A collection of R functions for working with two-way community
tables — sites by species (or any similar two-way structure).
Companion to the Braun-Blanquet cluster: where bbstruct provides
the publication-oriented analysis pipeline, Community_Analysis
holds general-purpose helpers that may eventually feed into
bbstruct, into the Ceska methodology reconstruction, or stay as
a small utility kit alongside the cluster.

## Current Status
Single-file folder at G:\My Drive\Projects\Community_Analysis\
holding `lists_functions.R`. Brought into the PKM 2026-05-28 as
part of the C:-root cleanup. Function inventory and decisions
about where (if anywhere) the functions belong inside the
Braun-Blanquet cluster are deferred to a later session.

## Locations
- Code: G:\My Drive\Projects\Community_Analysis
- GitHub: not yet

## Key Files
- lists_functions.R — collection of two-way-table helpers

## Related Projects — Braun-Blanquet Companion

Not a primary member of the Braun-Blanquet cluster (which has
four members: bbstruct, bbSynth, Braun_Blanquet, Ceska — see
those proj_*.md files). Community_Analysis is a small
satellite: general-purpose two-way-table functions that the
cluster work may absorb. Decision to fold these helpers into
bbstruct (or leave them standalone) is deferred until the
cluster's reconstruction work reaches the point of needing
them.

## Next Steps
1. Catalog the functions in `lists_functions.R` and identify
   which (if any) duplicate bbstruct routines.
2. Decide each function's home: merge into bbstruct, leave in
   Community_Analysis as a separate utility, or retire if
   superseded.
3. If retained as standalone, develop into a small R package;
   otherwise retire after migration.

## Collaborators / Dependencies
- bbstruct (likely consumer of any retained functions)

## Blockers
None.

---
## Log

### 2026-05-28
Project file created during PKM housekeeping continuation. The
Community_Analysis folder was placed at
G:\My Drive\Projects\Community_Analysis\ on 2026-05-28 as part
of the C:-root cleanup. Kim's framing: this is another tie to
the Braun-Blanquet work — the functions handle basic two-way
tables.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Exploring: a single-file
utility kit whose placement decisions (fold into bbstruct or keep
standalone) are deferred — pre-direction. Part of the
collection-wide back-fill; see proj_PKM.md and session_log.md
(2026-05-30).
