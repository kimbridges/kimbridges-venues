# PROJECT: sitemaps
_Last updated: 2026-05-30_
_Status: Active_
_Focus readiness: Ready_
_Tags: update_

## Type
Quarto multi-chapter document (older; needs updating)

## Objective
A document for producing site maps — geographic visualizations
of locations with associated photos, basemap layers, and
supporting data tables. The original document in the
kimbridges-documents family: it predates the later documents
and the current style conventions.

## Current Status
Source moved into G:\My Drive\Projects\sitemaps\ on 2026-05-28
from a prior C:-root location, joining the Projects-based home
that all other multi-chapter documents now use. The document
is deployed (kimbridges-documents/sitemaps/), but the source is
showing its age: the document format predates
`style_multichapter_doc.md` and is inconsistent with the
whittakerr-era conventions; the Google API code in
`R/bb2google.R` needs an update against current Google APIs;
and the folder carries two parallel source trees
(`documentation/` and `sitemaps_website/`) with substantial
overlap (the photo sets in particular are duplicated between
the two `photos/` subfolders). Kim has flagged that the
overlap audit is deferred to a later session.

## Locations
- Source (current canonical): G:\My Drive\Projects\sitemaps
  (documentation/ and sitemaps_website/ — two parallel trees;
  overlap unresolved)
- Rendered output: G:\My Drive\Projects\sitemaps\
  sitemaps_website\ (Quarto site)
- Deployed: G:\My Drive\kimbridges-documents\sitemaps
- GitHub: not yet

## Key Files
- LICENSE
- R/bb2google.R — Braun-Blanquet → Google maps converter; the
  function that gives the document its title and that needs
  updating against current Google APIs
- documentation/Things_to_do.qmd — to-do / working notes
- documentation/Combined_Maps.qmd — combined-maps chapter
- documentation/Data_Tables.qmd — data-tables chapter
- documentation/photos/Apple/, documentation/photos/Huntington/,
  documentation/photos/NatArb2/ — example site photo sets
- sitemaps_website/ — parallel source (and the rendered site
  output) with its own photos/ tree duplicating the one above
- sitemaps_website/styles.css — site styling
- sitemaps_website/.quarto/_freeze/ — Quarto freeze cache

## Related Projects
- **kimbridges-documents** — deployment target (the rendered
  document is live at kimbridges-documents/sitemaps/). See
  `proj_kimbridges_documents.md`.
- **Braun-Blanquet cluster** (bbstruct, bbSynth, Braun_Blanquet,
  Ceska) — indirect tie via `R/bb2google.R`. The function
  converts Braun-Blanquet relevé data into Google-Maps-ready
  geography. When the cluster reconstruction work matures, the
  bb2google.R function may need to be updated to match the
  current bbstruct data shapes.
- **Community_Analysis** (proj_Community_Analysis.md) — another
  Braun-Blanquet companion; possibly related two-way-table
  utilities.

## Next Steps
1. Resolve the documentation/ vs sitemaps_website/ overlap:
   identify which is canonical source and which is rendered or
   duplicated, deduplicate the photo sets, and consolidate to
   a single source tree.
2. Style alignment against `style_multichapter_doc.md` (the
   whittakerr-derived conventions). This document predates the
   style guide and will need substantive editing.
3. Update `R/bb2google.R` against the current Google Maps /
   Geocoding API surface.
4. Once updated, re-render and re-deploy to
   kimbridges-documents/sitemaps/ via the documented Deployment
   Workflow in proj_kimbridges_documents.md.

## Collaborators / Dependencies
- kimbridges-documents (deployment target)
- Google Maps / Geocoding APIs (the function dependency that
  needs updating)
- Braun-Blanquet cluster (via the bb2google.R Braun-Blanquet
  input shape)

## Blockers
None blocking; the Google-API update is the most concrete
piece of work and is not yet scheduled.

---
## Log

### 2026-05-28
Project file created during PKM housekeeping continuation. The
sitemaps folder moved from a C:-root location to
G:\My Drive\Projects\sitemaps on 2026-05-28 as part of the
C:-root cleanup. This is the original document — the first in
the kimbridges-documents family — and shows its age: format
predates `style_multichapter_doc.md`, Google API needs
updating, and the folder holds two parallel source/site trees
(documentation/ and sitemaps_website/) with unresolved overlap.
A future session will audit the overlap and bring the document
in line with current conventions.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Ready, Tag update: the
document is posted/deployed, but it is showing its age — the Google
Maps API code in R/bb2google.R needs updating, plus style alignment
and source-tree dedup. Kim's call (2026-05-30): rather than mark it
Complete like the other posted documents, tag it `update` (new tag
this session) and keep it Active, because the pending work is
functional, not cosmetic. Part of the collection-wide back-fill;
see proj_PKM.md and session_log.md (2026-05-30).
