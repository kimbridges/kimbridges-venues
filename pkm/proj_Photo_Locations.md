# PROJECT: Photo Locations
_Last updated: 2026-05-30_
_Status: Complete_
_Focus readiness: Not applicable_

## Type
Quarto document + R workflow (geotagging; deployed to
kimbridges-documents). Extracted 2026-05-30 from the timelinesr
package, where it had been embedded.

## Objective
Use location data captured by an Android phone to add GPS
coordinates to photos taken with a camera that has no GPS (e.g.,
Sony bodies). Android phones log location periodically at adequate
resolution to mark photo sites, but that data lives on the phone,
not in the off-phone camera's images. The workflow moves the phone
log into the photos, producing camera images whose EXIF data
carries the latitude and longitude of each shot. The hard part is
the JSON log structure; the software does that heavy lifting so the
user has a straightforward geotagging workflow. A Leaflet timeline
visualization (Timelines JSON) accompanies the worked example.

## Current Status
Complete and posted as "Photo Locations — Moving cellphone location
logs to photo EXIF data" in the kimbridges-documents collection
(categories: Maps, Data Grubbing, Photos). A Quarto book at
G:\My Drive\Projects\Photo_Locations\ with chapters index,
Conceptual, Workflow, Observations, Time; rendered to HTML
(`_output/`). Status is Complete per the posted-on-website rule
(2026-05-30).

**Provenance / important relationship.** This document was
*embedded inside the timelinesr package*. On 2026-05-30 Kim
extracted its code into the new folder
G:\My Drive\Projects\Photo_Locations\. The chapter set, the
`timelinesr_cover.png` / `timelinesr_logo.png` art, and the
Leaflet timeline machinery show that this content had been serving
as timelinesr's de-facto documentation. The extraction surfaced a
real finding: **timelinesr needs proper documentation of its own**,
since it had been carrying an application document rather than
standing on its own docs (see proj_timelinesr.md Next Steps and
priorities.md, 2026-05-30).

## Locations
- Source: G:\My Drive\Projects\Photo_Locations (.qmd files)
- Output: G:\My Drive\Projects\Photo_Locations\_output
- Data: gps_update.csv, Timelines/AlaMoana.json, History.json,
  Timeline.json, Photos/ (example camera images),
  Sony_GPS_CS1KA.jpg (the GPS-logger reference image)
- extra_code/: run_timelinesr.R, _quarto.yml, _publish.yml,
  auth_token.txt (**sensitive — see Blockers/Next Steps**)
- Deployed: kimbridges-documents.netlify.app/docs/photolocations
- GitHub: not evident

## Key Files
- _quarto.yml — book config (title "Photo Locations", subtitle
  "Moving cellphone location logs to photo EXIF data")
- index.qmd — preface (the why; Gemini-collaboration acknowledgement)
- Conceptual.qmd, Workflow.qmd, Observations.qmd, Time.qmd — chapters
- gps_update.csv — example phone GPS log
- Timelines/*.json — Leaflet timeline definitions
- Photos/ — example camera images to be geotagged
- extra_code/run_timelinesr.R — driver script
- extra_code/auth_token.txt — leftover token; remove/rotate before
  any public push

## Related Projects
- **timelinesr** (proj_timelinesr.md) — the source package this was
  extracted from; its own documentation is now the open item.
- **storylines** / **Trip_Log** — adjacent travel-photo workflows.

## Next Steps
1. None required for the posted document — it is Complete.
2. **Clean `extra_code/auth_token.txt`** before this folder is ever
   pushed publicly (capture/rotate if still active, then remove).
   Same class of issue flagged for timelinesr.
3. Resolve the timelinesr relationship: decide whether Photo
   Locations and timelinesr's own (to-be-written) documentation
   share material or stay separate.
4. Folder vs posted slug (`photolocations`) reconciliation
   (priorities.md item 6).

## Collaborators / Dependencies
- Google Gemini 3 Pro — the software (especially the JSON handling)
  was developed in collaboration with Gemini, per the index
  acknowledgement.

## Blockers
None blocking. The `auth_token.txt` cleanup is a pre-push hygiene
item, not a blocker on the posted document.

---
## Log

### 2026-05-30
Project file created during the status/focus-readiness back-fill
session, as an intake for one of five posted kimbridges-documents
that had no proj_*.md. This was the most informative of the five
recoveries: Kim found that "Photo Locations" had been embedded
inside the timelinesr package and extracted its code to the new
folder G:\My Drive\Projects\Photo_Locations\. The extraction
exposed that timelinesr lacks documentation of its own — captured
here, in proj_timelinesr.md Next Steps, and in priorities.md.
Filed with the observed state (five-chapter Quarto book, Leaflet
timeline, Gemini-assisted geotagging workflow, rendered and posted
live). Marked Status: Complete / Focus readiness: Not applicable
per Kim's posted-on-website rule. Flagged the leftover
extra_code/auth_token.txt for pre-push cleanup.
