# PROJECT: Temperature_Patterns
_Last updated: 2026-05-30_
_Status: Active_
_Focus readiness: Ready_

## Type
R analysis project (with git tracking)

## Objective
Analysis of temperature patterns from acquired climate data, with
emphasis on specific patterns of interest (e.g., the Eugene,
Oregon 32°F threshold appears in the rendered output filename
`report_Eugene_OR_32F.html`). The R/ folder structures the work
into clean stages: data acquisition, core analysis, statistics,
and visualization, driven by a top-level `run_analysis.R`.

## Current Status
Working R project at G:\My Drive\Projects\Temperature_Patterns\ with
a .git/ directory (this Project is under git tracking, unlike most
of the other newly filed Projects). R/ source organized into five
files (run_analysis.R, analysis_core.R, statistics.R, visualization.R,
data_acquisition.R). Output present: `report_Eugene_OR_32F.html`
and the corresponding `analysis_report.Rmd` source.

## Locations
- Code: G:\My Drive\Projects\Temperature_Patterns\R
- Output: G:\My Drive\Projects\Temperature_Patterns
  (report_Eugene_OR_32F.html)
- Source notebook: G:\My Drive\Projects\Temperature_Patterns
  (analysis_report.Rmd)
- Git: local repo present (.git/ at folder root)
- GitHub: not yet (no remote configured at folder move; verify)

## Key Files
- R/run_analysis.R — top-level driver
- R/analysis_core.R — core analysis routines
- R/statistics.R — statistical methods
- R/visualization.R — plotting and figures
- R/data_acquisition.R — data retrieval
- analysis_report.Rmd — analysis notebook
- report_Eugene_OR_32F.html — rendered output (Eugene, OR 32°F
  case study)
- Temperature_Patterns.Rproj — RStudio project
- .gitignore — git ignore rules
- .git/ — local git repository

## Next Steps
1. Confirm whether the .git/ folder has a GitHub remote
   configured, and if not, decide on a home and push.
2. Document the analysis pipeline: what data sources feed
   run_analysis.R, what the output shows.
3. Extend the analysis to additional locations / thresholds
   beyond Eugene 32°F if the framework supports it.

## Collaborators / Dependencies
None.

## Blockers
None.

---
## Log

### 2026-05-28
Project file created during PKM housekeeping continuation. The
Temperature_Patterns folder was moved from Desktop to
G:\My Drive\Projects\Temperature_Patterns on 2026-05-27. Notable
that this Project already has a local .git repository — among the
newly filed Projects, this and a couple of others are under git
tracking already.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Ready: git-tracked, with a
finished Eugene 32°F report; clear next steps (confirm the GitHub
remote, document the pipeline, extend to more locations). Part of
the collection-wide back-fill; see proj_PKM.md and session_log.md
(2026-05-30).
