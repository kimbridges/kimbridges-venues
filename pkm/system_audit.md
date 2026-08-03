# System Audit — File Locations and Storage
_Created: 2026-05-07_
_Status: In progress_

## Purpose

The PKM and project files have been moved across drives over
multiple sessions, partly in response to access problems with
Cowork mode. This document is the single survey that catalogs
where files actually live, identifies drift between what
proj_*.md files claim and what exists, and forces decisions on
canonical storage.

Output of this audit:
- A consolidated "Locations" picture written into proj_PKM.md
- Updated Locations sections in all affected proj_*.md files
- A short list of consolidation actions Kim needs to take
- An informed baseline for the Phase 2 R script that will check
  drift automatically going forward

This is a one-time task. Once done, the protocol's intake
mechanism keeps locations current for new projects.

---

## 1. Storage Clarification (questions for Kim)

| Question | Status | Answer |
|----------|--------|--------|
| OneDrive vs Google Drive — which is canonical for the PKM? | RESOLVED | Google Drive is canonical. Kim wants to minimize OneDrive. Migration required. |
| Is the D: drive Google Drive mirror still actively syncing? | RESOLVED | Yes, currently mirror. Kim plans to switch Google Drive for Desktop to "Stream" mode after migration to remove the mirror. |
| Where is the `pkm/` git repo cloned? Is it active? | RESOLVED | No PKM git repo. Per Kim (2026-05-08), the PKM lives only on Google Drive; GitHub is for R packages and websites. proj_PKM.md updated. |
| Are there any folders Kim knows are orphaned or moved? | OPEN | _awaiting Kim — surface as audit progresses_ |

### Connector-based access

Google Drive MCP connector confirmed available 2026-05-07. Tools:
search_files, read_file_content, create_file, copy_file,
get_file_metadata, download_file_content, get_file_permissions,
list_recent_files. Notable absences: no update_file, no
delete/trash, no move. Migration must be clean-slate (write to a
fresh folder; old folder retained or renamed by Kim).

This means the connector is the working interface to the canonical
PKM going forward. No local mount or D: drive mirror is needed for
Claude's access.

---

## 2. PKM Files (Projects_Index)

Currently mounted at `C:\Users\kim\OneDrive\Desktop\Projects_Index`.

### What's here (from directory listing, 2026-05-07)

System and reference files:
- pkm_protocol.md (new this session)
- session_log.md (new this session)
- system_audit.md (this file)
- project_index.md
- design_publishing_workflow.md
- inventory_all_projects.md
- kim_association_index.md
- README.md (claimed in proj_PKM.md, not visible in current listing — TO VERIFY)
- template.md

Project files (proj_*.md):
- proj_PKM.md
- proj_jones_collection.md (new this session)
- proj_kimbridges_info.md
- proj_kimbridges_stories.md
- proj_kimbridges_documents.md
- proj_kimbridges_collections.md
- proj_Koch_voronoi.md
- proj_milestones.md
- proj_accessOAI.md
- proj_citations.md
- proj_geContour.md
- proj_gePoints.md
- proj_labelextractr.md
- proj_photobookr.md
- proj_photothumbsr.md
- proj_whittakerr.md

Other content:
- collection_plan_gallery.md (orphan? should this be in kimbridges-collections?)
- stories_inventory.xlsx
- stories_inventory_v2.xlsx (referenced in proj_kimbridges_stories.md)
- update_stories_qmd.py (referenced in proj_kimbridges_stories.md as add_stories.py — name mismatch, TO RECONCILE)
- .Rhistory (empty file — R-related artifact)

### Drift identified

| Item | Claimed in PKM | Actual | Action needed |
|------|---------------|--------|---------------|
| Active project files location | "Google Drive / Projects_Index" (proj_PKM.md) | OneDrive `C:\Users\kim\OneDrive\Desktop\Projects_Index` | Update proj_PKM.md after Kim confirms canonical |
| README.md | listed in proj_PKM.md Key Files | not visible in folder listing | Verify with Kim — does it exist or should it be created? |
| stories_inventory.xlsx vs v2 | only v2 referenced in proj_kimbridges_stories.md | both present | Archive or delete v1 |
| update_stories_qmd.py vs add_stories.py | proj_kimbridges_stories.md says "add_stories.py" | actual filename is "update_stories_qmd.py" | Decide canonical name; rename file or update proj |
| collection_plan_gallery.md | not referenced in any proj_*.md | present in folder | Locate proper home (likely kimbridges-collections), or note as historical |

---

## 3. Project Folders (kimbridges-*)

Each of these is claimed in a proj_*.md; none are currently
mounted in this Cowork session.

| Folder | Claimed Contents (per proj file) | Audit Status |
|--------|-----------------------------------|--------------|
| `C:\Users\kim\kimbridges-info` | _quarto.yml, index.qmd, 6 page .qmd files, Kim_with_beer.png, custom.css | MIGRATED 2026-05-12 to G:\My Drive\kimbridges-info via Windows Explorer copy-paste; April-era Drive folder renamed by Kim to kimbridges-info_old (preserved). The 2026-05-10 bash-rsync attempt did not propagate — see pkm_findings.md. |
| `C:\Users\kim\kimbridges-stories` | index.qmd, stories/*.qmd, pdfs/*.pdf, images/*.png, viewer.html, add_stories.py, stories_inventory_v2.xlsx, README.md | MIGRATED 2026-05-12 to G:\My Drive\kimbridges-stories via Windows Explorer copy-paste; April-era Drive folder renamed by Kim to kimbridges-stories_stale_2026-05-12 (preserved). The 2026-05-10 bash-rsync rename/replace did not propagate. |
| `C:\Users\kim\kimbridges-documents` | index.qmd, docs/*.qmd, _quarto.yml, custom.css, 13 document subfolders | MIGRATED 2026-05-12 to G:\My Drive\kimbridges-documents via Windows Explorer copy-paste; greenfield (no prior Drive folder). The 2026-05-10 bash-rsync attempt did not propagate. |
| `C:\Users\kim\kimbridges-collections` | index.qmd, gallery.qmd, jones.qmd, custom.css, Gallery/ subtree, Jones/ subtree | MIGRATED 2026-05-12 to G:\My Drive\kimbridges-collections via Windows Explorer copy-paste; greenfield. The 2026-05-10 bash-rsync attempt did not propagate. |

When mounted, audit each for: claimed files present, unexpected
files (orphans), any files in wrong subfolder.

---

## 4. Cross-Drive Status

### C: drive
Primary local working drive per proj_PKM.md.
- `C:\Users\kim\OneDrive\Desktop\Projects_Index` — confirmed (PKM)
- `C:\Users\kim\kimbridges-*` — claimed in proj files; not yet verified

### D: drive
proj_PKM.md says "D:\ (Google Drive mirror)".
proj_kimbridges_stories.md says "Google Drive mirror: D:\kimbridges-stories".
Status of D: drive sync — OPEN. Awaiting Kim.

### Google Drive
Per Kim (2026-05-07): canonical going forward. The PKM should
live here.

Current state of Google Drive Projects_Index folder
(ID: 14jzYpXyzfL0vZ0uBI-MHpmnu7CMKElyY):
- Contains 14 files, all dated April 6–10
- This is a frozen-in-time snapshot from when Kim moved working
  copy to OneDrive
- Files present: project_index.md (1.6KB Apr 6 — original draft);
  proj_milestones.md, proj_Koch_voronoi.md, proj_geContour.md,
  proj_gePoints.md, proj_photothumbsr.md, proj_photobookr.md,
  proj_labelextractr.md, proj_whittakerr.md, proj_accessOAI.md,
  proj_citations.md, proj_milestones_bars.md (a stub draft —
  superseded by proj_milestones.md), template.md, .Rhistory.
- 11+ files missing relative to OneDrive: proj_PKM.md,
  proj_kimbridges_*.md (4), proj_jones_collection.md,
  design_publishing_workflow.md, inventory_all_projects.md,
  kim_association_index.md, pkm_protocol.md, session_log.md,
  system_audit.md (this file), collection_plan_gallery.md,
  stories_inventory*.xlsx, update_stories_qmd.py.

Migration needed: push current OneDrive content to Google Drive
in a fresh Projects_Index folder. Kim renames the existing
April-frozen folder to Projects_Index_archive_2026-04 to preserve.

Other Google Drive folders observed (not yet audited):
- kimbridges-stories (created 2026-04-28, recent activity)
- kimbridges-info (created 2026-04-24)
- kimbridges_personal (2023 — likely unrelated)
- Profile-KimBridges (2020 — likely unrelated)
- (no kimbridges-collections or kimbridges-documents observed yet)

### OneDrive
Currently the working location for the PKM, but slated for
deprecation. Path: `C:\Users\kim\OneDrive\Desktop\Projects_Index`.
Contains 25 files (current state) — the canonical content until
the migration completes. After migration, Kim deletes the
OneDrive copy.

---

## 5. Git Repository Status

proj_PKM.md says: "Git repo: cloned into Cowork session as pkm/".
Current Cowork session folder (Projects_Index) contains no .git
folder. So either:
- The git repo exists somewhere else on Kim's machine, or
- The repo was cloned in an earlier session and is no longer in
  use, or
- The PKM is no longer git-tracked and proj_PKM.md is stale.

OPEN — awaiting Kim.

---

## 6. Orphan Files and Folders

(Files or folders not represented in any proj_*.md, or that
appear to belong elsewhere.)

| Item | Where | Notes |
|------|-------|-------|
| collection_plan_gallery.md | Projects_Index | Likely belongs in kimbridges-collections; check date and content |
| stories_inventory.xlsx (v1) | Projects_Index | Older version; v2 is current per proj_kimbridges_stories.md |

(More to be added as audit proceeds.)

---

## 7. Findings and Decisions

- **Canonical storage is Google Drive** (Kim, 2026-05-07).
  OneDrive is deprecated for PKM. The D: drive mirror is in
  current use but slated for retirement once migration is done
  (Google Drive for Desktop will switch to "Stream" mode).
- **Google Drive MCP connector** is the primary access mechanism
  for Claude. No local mount or mirror is required.
- **Connector limitations**: read + create only; no update/delete.
  Migration must be clean-slate. Live editing of existing Drive
  files is not yet supported via connector — workaround pending.
- **Google Drive Projects_Index was frozen** at April 10 state.
  All work since lived only on OneDrive. Migration completed
  2026-05-08 02:11 UTC; old folder renamed to
  Projects_Index_archive_2026-04 (preserved); new Projects_Index
  contains all 29 current files; verified by file count, name
  match, and content sampling.
- **proj_milestones_bars.md** in archive folder is an early stub
  superseded by proj_milestones.md. No reconciliation needed.
- **Bash mount staleness**: the bash sandbox sees a cached view
  of the OneDrive folder that may lag behind the actual file
  state. The Read/Write/Edit tools see the current state. For
  any size-or-content verification, trust the file tools — not
  `ls -la` or `wc -c` from bash. (Lesson learned during 2026-05-07
  migration verification: a phantom 703-byte size discrepancy was
  bash showing a stale snapshot from earlier in the session.
  Re-confirmed 2026-05-10 on two separate folders within the same
  session: bash ls of G:\My Drive\kimbridges-stories returned
  "empty" while the folder actually had hundreds of files; bash ls
  of G:\My Drive\Projects returned only "gePoints" while the folder
  actually held many populated project subfolders (citations,
  discussionsr, milestones_bars, photothumbsr, etc.). Kim caught
  both. Glob via the file tools showed the real state in each case.
  Rule going forward: never trust bash for directory listings on
  Drive Stream mounts; use Glob.)
- **Storage architecture rule (2026-05-10)**: Website projects
  live at `G:\My Drive\kimbridges-*` (Drive root); code-heavy
  projects live under `G:\My Drive\Projects\<name>`; the PKM lives
  under `G:\My Drive\Projects_Index\`. Deciding factor is product
  format (PDF/HTML output vs .qmd/.R source). This matches the
  Website Projects vs Active R Projects categorical split already
  present in project_index.md. Decision captured durably in
  proj_PKM.md Design Decisions.
- **Bash mount does not write to Drive (2026-05-12)**: This is the
  deeper finding behind the bash-staleness symptom above. Cowork
  provides two different mount paths for Drive content. The file
  tools (Read/Write/Edit/Grep/Glob) use the real `G:\My Drive\...`
  path and route through Drive for Desktop, so their writes
  propagate to Drive cloud. The bash tool uses a different path
  (`/sessions/<id>/mnt/My Drive/...`) that is sandbox-local and
  does NOT route through Drive for Desktop. Bash mkdir, rsync, cp,
  and similar write operations land in the sandbox and never
  reach Drive. Source-vs-destination file-count comparisons done
  in bash are sandbox-vs-sandbox and therefore cannot detect
  this. Discovered 2026-05-12 when the prior day's bash-based
  migrations of kimbridges-documents, kimbridges-collections,
  and kimbridges-info (plus the kimbridges-stories rename) were
  found to be invisible to Drive cloud and to the file tools.
  Recovery was via Windows Explorer copy-paste, which goes
  through Drive for Desktop and propagates correctly. Full
  record in pkm_findings.md. Operating rule going forward: use
  the file tools or Drive MCP for any write to G: that needs to
  reach Drive cloud; do not trust bash for such writes; bash is
  fine for computation and for reading files whose state is
  already real on Drive.

## 8. Consolidation Actions for Kim

1. ~~Rename existing Google Drive `Projects_Index` folder to
   `Projects_Index_archive_2026-04`~~ DONE 2026-05-08.
2. ~~Create fresh Google Drive `Projects_Index` folder~~ DONE.
3. ~~Migrate files from OneDrive to new Google Drive folder
   (Option A — manual file-manager copy)~~ DONE.
4. ~~Verify completeness~~ DONE — 29 files match.
5. **NEXT**: Update `proj_PKM.md` Locations section to reflect
   Google Drive canonical, OneDrive deprecated. Files modified
   after the migration (proj_PKM.md, system_audit.md, possibly
   session_log.md) will need to be re-copied from OneDrive to
   Google Drive at end of session.
6. **PENDING**: After verification period, delete OneDrive
   `Projects_Index` folder.
7. **PENDING**: Switch Google Drive for Desktop from "Mirror"
   to "Stream" mode (removes D: drive mirror).
8. **OPEN QUESTION**: Where is the `pkm/` git repo, and is it
   still active? Update proj_PKM.md to match.

## 9. Audit of Project Source Folders (kimbridges-*)

Pending. Each folder needs to be inspected against its proj_*.md
claimed contents. Approach: Kim mounts (or shares via connector
search) one folder at a time; Claude verifies and notes
discrepancies. Folders to check:
- C:\Users\kim\kimbridges-info  (or Google Drive equivalent)
- C:\Users\kim\kimbridges-stories
- C:\Users\kim\kimbridges-documents
- C:\Users\kim\kimbridges-collections

Note: Google Drive search showed kimbridges-stories and
kimbridges-info folders exist on Drive (created Apr 24–28).
Whether these are mirrors of the local folders or separate
copies is open. The audit will resolve this.

### Special case: kimbridges-documents

Per Kim (2026-05-08), the documents site is primarily the
*deployment target* for R package documentation, not the source
of truth. The pattern (per design_publishing_workflow.md
"Quarto Source File Policy", now being implemented):
- R package code lives in the package's GitHub repo
- The package repo also contains a `quarto/` (or `docs/`)
  subfolder with the .qmd documentation source
- The .qmd renders to HTML
- The rendered HTML is what lives on kimbridges-documents.netlify.app

Implication for the audit: kimbridges-documents needs a listing
check (does each package have its entry?) and a deployment check
(does the published HTML match the latest qmd source from the
package repo?). It does NOT need a content audit — there is no
authoritative content stored locally that we'd compare against.

Implication for R package proj_*.md files (proj_geContour,
proj_gePoints, proj_photobookr, etc.): each should note its
qmd-docs subfolder location (within its GitHub repo) and its
published listing on kimbridges-documents. Update these when
we work through the R package audit.

### Migration status (2026-05-12 — corrected)

The original 2026-05-10 entry here claimed all four kimbridges-*
folders had been migrated. They had not — the bash rsync
operations stayed sandbox-local (see Section 7 "Bash mount does
not write to Drive"). On 2026-05-12 the migrations were redone
correctly via Windows Explorer copy-paste through Drive for
Desktop:

- kimbridges-info: copied to G:\My Drive\kimbridges-info
  (2026-05-12T07:55). Kim renamed the existing April Drive
  folder to kimbridges-info_old (preserved).
- kimbridges-collections: copied to G:\My Drive\kimbridges-collections
  (2026-05-12T07:59). Greenfield.
- kimbridges-documents: copied to G:\My Drive\kimbridges-documents
  (2026-05-12T08:00). Greenfield.
- kimbridges-stories: Kim renamed the existing April Drive folder
  to kimbridges-stories_stale_2026-05-12, then copied to
  G:\My Drive\kimbridges-stories (2026-05-12T08:05).

All verified via Drive MCP. Original C: copies preserved pending
deployment verification — to be deleted after the next successful
Netlify deploy from G: (a single deploy closes the gate for all
four). Also pending cleanup after verification: the two _old /
_stale_2026-05-12 backup folders, and the build artifacts
(.quarto/, _site/) that came along with the Windows Explorer
copies.

---

## Log

### 2026-05-07
Audit document created. Pre-populated with locations referenced
across existing proj_*.md files. Drift identified within
Projects_Index folder (PKM location, README, file names,
orphan files). Awaiting Kim's storage clarification before the
audit can resolve.

### 2026-05-07 (later — storage resolved)
Kim confirmed Google Drive canonical and slated OneDrive for
deprecation. Google Drive MCP connector verified available.
Surveyed Google Drive: existing Projects_Index folder is frozen
at April 6–10 state with 14 files; OneDrive (25 files) is
canonical until migration. Read proj_milestones_bars.md on Drive
— confirmed as superseded stub. Migration plan documented in
Section 8. Open: pkm/ git repo location.
