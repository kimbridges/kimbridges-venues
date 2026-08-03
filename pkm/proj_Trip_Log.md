# PROJECT: Trip_Log
_Last updated: 2026-05-30_
_Status: Active_
_Focus readiness: Exploring_

## Type
R tool + travel-photo workflow (storylines-like)

## Objective
A trip-log workflow that organizes travel photos with metadata
into a per-day structure suitable for narrative assembly. Closely
related in intent to the storylines Project (which produces the
finished trip-log narratives as Quarto pages), but kept separate
because the underlying workflows differ.

## Current Status
Working folder at G:\My Drive\Projects\Trip_Log\ with a Kyoto_1
subfolder containing a substantial set of travel photos and
per-image metadata JSON files. The Kyoto_1 subfolder is the
primary example; the wider workflow tooling is not yet packaged.

## Locations
- Working materials: G:\My Drive\Projects\Trip_Log\Kyoto_1
- GitHub: not yet

## Key Files
- Kyoto_1/ — Kyoto trip photo set with EXIF/metadata JSON files
- Kyoto_1/metadata.json — trip metadata
- Kyoto_1/*.JPG, *.jpg — photos
- Kyoto_1/*.json — per-image supplemental metadata

## Related Projects
- **storylines** (G:\My Drive\Projects\storylines) — the
  finished-narrative side of trip logs; produces the Quarto
  pages and PDFs. Trip_Log is the upstream organizing /
  preparation workflow; storylines consumes prepared photo
  sets and writes the narrative.

## Next Steps
1. Catalog the working pattern: how photos enter, how metadata
   gets attached, how the per-day organization is produced.
2. Decide whether Trip_Log should become a small R package that
   feeds storylines, or stay as a workflow folder.
3. Add additional trip subfolders (beyond Kyoto_1) as more
   trips are processed.

## Collaborators / Dependencies
- storylines (downstream Project)

## Blockers
None.

---
## Log

### 2026-05-28
Project file created during PKM housekeeping continuation. The
Trip_Log folder was moved from Desktop to
G:\My Drive\Projects\Trip_Log on 2026-05-27. Was on the
"Projects Referenced but Not Yet Filed" list before today's
filing (as "Trip Log / Storylines"). Filed as its own Project
distinct from storylines per Kim's 2026-05-27 decision that
they are separate workflows for now.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Exploring: the Kyoto_1 example
is in place; deciding whether Trip_Log becomes a small R package
feeding storylines or stays a workflow folder — pre-direction. Part
of the collection-wide back-fill; see proj_PKM.md and session_log.md
(2026-05-30).
