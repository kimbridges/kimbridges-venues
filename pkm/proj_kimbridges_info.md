# PROJECT: kimbridges.info
_Last updated: 2026-07-28_
_Status: Standing_
_Focus readiness: Not applicable_

## Type
Website (Netlify) — hub site

## Objective
The central hub connecting all of Kim's technical and creative work.
Five components: Stories, Documents, Collections, Schedule, Following.
Each component links out to its respective Netlify site or contains
local content.

## Current Status
Live on Netlify. Five-component hub with gateway pages linking to
three separate Netlify sites. Schedule and Following pages contain
local content. Landing page features a profile photo.

## Locations
- **Canonical source**: G:\My Drive\kimbridges-info (Drive for
  Desktop in Stream mode; migrated from C: on 2026-05-12 via
  Windows Explorer copy-paste. The earlier 2026-05-10 bash-rsync
  attempt did not propagate to Drive cloud — see Log and
  pkm_findings.md.)
- Netlify: https://kimbridges.info
- Related sites:
  - https://kimbridges-stories.netlify.app
  - https://kimbridges-documents.netlify.app
  - https://kimbridges-collections.netlify.app
  - https://www.kimbridges.com (Squarespace — separate)

## Key Files
- _quarto.yml — navbar with 6 items (Home, Stories, Documents, Collections, Schedule, Following)
- index.qmd — five-component grid landing page with profile photo
- stories.qmd — gateway to kimbridges-stories.netlify.app
- documents.qmd — gateway to kimbridges-documents.netlify.app
- collections.qmd — gateway to kimbridges-collections.netlify.app
- schedule.qmd — local content (planned and past travel)
- following.qmd — local content (sources, people, ideas)
- Kim_with_beer.png — profile photo on landing page
- custom.css — card thumbnails and profile image styling

## Architecture
- Quarto website project (type: website)
- No local resources (PDFs, audio, etc.) — all content on separate sites
- Gateway pages link out with btn-primary buttons
- Schedule and Following are editable local pages
- Cosmo theme, consistent with all other sites
- Navbar right links to kimbridges.com

## Relationship to kimbridges.com
kimbridges.com (Squarespace) is the public identity and creative portfolio.
kimbridges.info is the technical and documentation hub. They are
complementary. kimbridges.info navbar links to kimbridges.com.

## Next Steps
1. Keep Schedule and Following pages current
2. Update gateway page descriptions as content sites grow
3. Consider adding a Projects or Drafts section (private workspace concept)

## Collaborators / Dependencies
Depends on all three content sites being live.

## Blockers
None

---
## Log
### 2026-05-07
Project file created during PKM update session. Hub site built with
five components. Replaced old two-section (Stories & Documents) design.
Profile photo added to landing page. Deployed to Netlify.

### 2026-05-10
Storage migrated from C:\Users\kim\kimbridges-info to
G:\My Drive\kimbridges-info. Greenfield migration — no prior G:
copy at root (audit Section 4 had noted a 2026-04-24 folder; not
present at migration time, likely deleted between then and now).
10 source files copied via rsync (out of 53 total at C:; .quarto/
and _site/ build artifacts plus an empty .Rhistory excluded).
File counts match. Captures following.qmd as edited 2026-05-10
22:04 HST earlier in the same session. Completes the four-folder
kimbridges-* migration set. Migration part of the larger
Mirror→Stream and housekeeping work in proj_PKM.md.

### 2026-05-12 (correction — bash mount discovery and recovery)
The 2026-05-10 migration above did not actually propagate to
Drive cloud. Diagnosed 2026-05-12: bash writes to the
/sessions/upbeat-beautiful-pascal/mnt/My Drive/ path go to a
sandbox-local filesystem that is NOT routed through Drive for
Desktop, so the rsync produced no real Drive uploads. The
"file counts match" verification was sandbox-vs-sandbox, not
sandbox-vs-Drive. Also, the claim "no prior G: copy at root"
was a bash-staleness artifact — an April 2026 Drive folder did
exist (id 14PLdVkHVPZLTAPbDWcIp70LXF4JvZm4j). Recovery 2026-05-12:
Kim renamed the existing Drive folder to kimbridges-info_old via
Windows Explorer, then copy-pasted C:\Users\kim\kimbridges-info
into G:\My Drive\. Verified via Drive MCP that the new folder
and its contents (including following.qmd with preserved
2026-05-10 22:04 modifiedTime) are now in Drive cloud. The
canonical state described in the Locations section is now
accurate. See pkm_findings.md for the durable record of the
bash-mount infrastructure finding.

### 2026-05-28 (deprecated C: copy deleted)
Kim deleted C:\Users\kim\kimbridges-info from the local
filesystem. The C: copy had served as the working location
prior to the 2026-05-12 migration to Drive; the verification
period it was preserved through has long since passed — all
deployments and edits since 2026-05-12 have been G:-sourced,
and the C: copy had not been modified since migration
(confirmed by its pre-2026-05-10 mtimes in the 2026-05-27
Desktop survey). Locations section above updated to retire
the Deprecated line; the G:\My Drive\kimbridges-info_old
backup folder is preserved separately and remains a low-gate
candidate for later deletion. The G: canonical source is
unchanged. See session_log.md 2026-05-28 and priorities.md.

### 2026-05-28 (Backup kimbridges-info_old deleted)
Kim deleted G:\My Drive\kimbridges-info_old later the same
day after a look at the folder showed it was an old version
used to build the website harness; the current
G:\My Drive\kimbridges-info is correct and unchanged. The
Backup line was removed from Locations above. With this and
the prior C: deletion the kimbridges-info Project has no
remaining residual copies; G:\My Drive\kimbridges-info is
the sole source.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Not applicable: a live
hub/gateway site, in use but not a focused-work candidate (only
minor upkeep). Part of the collection-wide back-fill that gave
every proj_*.md the structured header fields; see proj_PKM.md and
session_log.md (2026-05-30) for the scheme, the posted-on-website
Complete rule, and the new Paused status / Tags field.
