# PROJECT: sumo
_Last updated: 2026-05-30_
_Status: Active_
_Focus readiness: Exploring_

## Type
Data analysis (R + Quarto)

## Objective
An analysis of professional sumo wrestling data — tournaments,
wrestlers, stables, bouts, kimarite (winning techniques), rankings,
and tournament records over time. The dataset is rich and
structured; the project explores patterns across the long arc of
sumo competition.

## Current Status
Quarto / RStudio working project at G:\My Drive\Projects\sumo\
with a single primary analysis notebook (`sumo_analysis.qmd`), a
README, and a substantial data directory. Data covers tournaments,
bouts, wrestlers (including an updated copy), stables, rankings,
kimarite, and tournament records in multiple shapes (per-record,
long-form, all-records). Analysis is exploratory; specific
findings have not been documented in the PKM yet.

## Locations
- Source: G:\My Drive\Projects\sumo\sumo_analysis.qmd
- Data: G:\My Drive\Projects\sumo\data and the root rankings.csv
- GitHub: not yet

## Key Files
- README.txt — overview
- sumo_analysis.qmd — primary analysis notebook
- rankings.csv — rankings (root copy)
- data/tournaments.csv — tournament list
- data/bouts.csv — bout-level data
- data/wrestlers.csv, data/wrestlers_updated.csv — wrestler data
- data/stables.csv — stable data
- data/kimarite.csv — winning-technique data
- data/rankings.csv — rankings (data-folder copy)
- data/tournament_records.csv, tournament_records_test.csv,
  tournament_records_all.csv, tournament_records_long.csv —
  tournament-record variants
- sumo.Rproj — RStudio project

## Next Steps
1. Reconcile the duplicate rankings.csv at root vs in data/
   (decide on a single canonical location).
2. Pin down a few concrete analysis questions the dataset is
   suited to answer.
3. Document the variant tournament_records_* files (which is
   canonical, which are derived).
4. Decide whether this becomes a public-facing document (and if
   so, the deployment target) or stays as private analysis.

## Collaborators / Dependencies
None.

## Blockers
None.

---
## Log

### 2026-05-28
Project file created during PKM housekeeping continuation. The
sumo folder was moved from Desktop to G:\My Drive\Projects\sumo on
2026-05-27.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Exploring: exploratory data
analysis; concrete analysis questions need pinning down before
focused work. Part of the collection-wide back-fill; see proj_PKM.md
and session_log.md (2026-05-30).
