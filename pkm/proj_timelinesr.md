# PROJECT: timelinesr
_Last updated: 2026-05-30_
_Status: Active_
_Focus readiness: Ready_

## Type
R package + Quarto Document

## Objective
An R package for producing illustrated timelines from photo sets
with GPS / time metadata, paired with a Quarto document that
explains the conceptual model and demonstrates the workflow. The
timelines combine temporal sequence with geographic context using
Leaflet for interactive maps; the package handles the data shaping
and rendering, the document walks through how it works.

## Current Status
R package skeleton at G:\My Drive\Projects\timelinesr\ (root) with
a `documentation/` subfolder holding the Quarto book. The
documentation chapters are drafted: index, Conceptual, Functions,
Workflow, Observations, Time. Rendered output exists under
`documentation/_output/` with HTML chapters plus the Leaflet,
htmlwidgets, jQuery, Proj4, and Bootstrap support libraries
bundled. Examples include Sony GPS CS1KA reference imagery, a
gps_update.csv data file, JSON timeline definitions (AlaMoana,
History, Timeline), and a Photos folder.

A `_publish.yml` and `auth_token.txt` exist under
`documentation/extra_code/`, suggesting the document was at some
point set up for Quarto Publish or similar — verify and clean
sensitive material (the auth_token.txt should not be committed
anywhere public).

## Locations
- Package code: G:\My Drive\Projects\timelinesr (R/, DESCRIPTION,
  NAMESPACE at root)
- Document source: G:\My Drive\Projects\timelinesr\documentation
  (.qmd files)
- Document output: G:\My Drive\Projects\timelinesr\documentation\
  _output
- Document data: G:\My Drive\Projects\timelinesr\documentation\
  Timelines (JSON), Photos/, gps_update.csv
- GitHub: not yet (existing project_index.md entry said "on
  GitHub with documentation" — verify current state)

## Key Files
- DESCRIPTION, NAMESPACE — R package skeleton (root)
- (Package source under R/ — verify after the folder consolidation)
- documentation/_quarto.yml — Quarto book configuration
- documentation/index.qmd — opening
- documentation/Conceptual.qmd — conceptual framework
- documentation/Functions.qmd — package functions reference
- documentation/Workflow.qmd — end-to-end workflow chapter
- documentation/Observations.qmd — observations / notes
- documentation/Time.qmd — time-handling chapter
- documentation/Timelines/AlaMoana.json,
  documentation/Timelines/History.json,
  documentation/Timelines/Timeline.json — example timeline data
- documentation/Photos/ — example photos
- documentation/gps_update.csv — GPS data
- documentation/Sony_GPS_CS1KA.jpg — camera/GPS reference image
- documentation/cover.png, timelinesr_cover.png,
  timelinesr_logo.png, ChatGPT_timelinesr_cover.png — cover art

## Next Steps
1. Verify the package R/ source at root; the 2026-05-27 move
   combined the prior `timelinesr_pkg` (root) and
   `timelinesr_doc` (documentation/) folders.
2. Confirm GitHub remote status; if a repo exists, point Locations
   at it; if not, decide on a home and push.
3. Clean the `documentation/extra_code/auth_token.txt` before
   any deployment.
4. Style review against `style_multichapter_doc.md`.
5. Decide deployment to kimbridges-documents and proceed via the
   documented workflow there.
6. **Write timelinesr's own documentation.** Surfaced 2026-05-30
   when the "Photo Locations" document (an application example) was
   extracted out of the package into Projects\Photo_Locations\. The
   package now lacks a document of its own that explains the package
   itself; this is the gap to fill.

## Collaborators / Dependencies
None.

## Blockers
None.

---
## Log

### 2026-05-28
Project file created during PKM housekeeping continuation. The
timelinesr folder was assembled on 2026-05-27 from the prior
Desktop folders `timelinesr_pkg` and `timelinesr_doc`: pkg content
at the new root, doc content under documentation/ (matching the
photobookr pattern). Was on the "Projects Referenced but Not Yet
Filed" list before today's filing.

### 2026-05-30 (Status / Focus-readiness back-fill; documentation finding)
Status set to Active, Focus readiness Ready: package plus a
drafted/rendered Quarto doc; clear next steps. **Finding
(2026-05-30):** the posted "Photo Locations" document was extracted
from this package (now proj_Photo_Locations.md), which revealed that
timelinesr had been carrying an application document instead of
standing on its own docs — so **timelinesr needs proper documentation
of its own** (added to Next Steps). The auth_token.txt cleanup noted
earlier also still applies. Part of the collection-wide back-fill;
see proj_PKM.md, session_log.md, and priorities.md (2026-05-30).
