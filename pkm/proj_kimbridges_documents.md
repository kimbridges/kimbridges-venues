# PROJECT: kimbridges-documents
_Last updated: 2026-08-03_
_Status: Standing_
_Focus readiness: Ready_

## Type
Website (Netlify)

## Objective
A Quarto website hosting rendered HTML documents covering R programming,
geographic analysis, cartography, and research methods. Each document is
a self-contained reference with its own folder of pre-rendered HTML.

## Current Status
Live on Netlify. **22 document folders**, the latest **llm_examples ("Experiments with LLMs", published
2026-08-03)**; ai_podcasts was 2026-08-02, vouchr 2026-07-29, ai_microscope 2026-07-25, checklistr 2026-07-09, lists 2026-06-16, coenosr 2026-06-15. Grid listing
page with category filtering. Document landing page concept designed but not yet implemented. The
site is now about 393 MB of resources, which makes a full render overrun the 60-second R-bridge
timeout - it still completes (pkm_findings.md Finding 017).

## Locations
- **Canonical source**: G:\My Drive\kimbridges-documents (Drive for
  Desktop in Stream mode; migrated from C: on 2026-05-12 via
  Windows Explorer copy-paste. The earlier 2026-05-10 bash-rsync
  attempt did not propagate to Drive cloud — see Log and
  pkm_findings.md.)
- Netlify: https://kimbridges-documents.netlify.app
- Hub link: https://kimbridges.info → Documents

Note (per system_audit.md Section 9): kimbridges-documents is
primarily the *deployment target* for R package documentation —
.qmd source for R packages lives in their GitHub repos, renders
to HTML, and the rendered HTML is what lives here. The 14
document subfolders combine R package docs (gePoints, r_api,
r_basics) with standalone content (citations, colors, flora,
milestones, pedigree, photolocations, plainmaps, sitemaps,
storylines, using_an_llm, docs).

## Key Files
- index.qmd — grid listing page pointing to docs/*.qmd
- docs/*.qmd — one stub per document with YAML metadata and [View Document] button
- _quarto.yml — resources pointing to all 13 document folders
- custom.css — card thumbnail styling

## Architecture
- Quarto website project (type: website)
- Grid listing with category filtering and sort controls
- Each document is a pre-rendered HTML folder (not re-rendered by Quarto)
- Stub .qmd files in docs/ provide card metadata and link to the folder
- Document folders: citations, coenosr, colors, flora, gePoints, lists, milestones,
  pedigree, photolocations, plainmaps, r_api, r_basics, sitemaps,
  storylines, using_an_llm, whittakerr

## Deployment Workflow

The procedure for adding (or updating) a document in this
collection. Documented 2026-05-25 after working through it
end-to-end with whittakerr.

**Per-document setup (one-time, when a new document is first
added):**

1. **Render the document.** From the document's source
   project (e.g., `G:\My Drive\Projects\<name>\`), open a
   Terminal and run `quarto render`. The book is written to
   `_output/`.
2. **Place the rendered output in the collection.** Copy the
   contents of `_output/` into
   `G:\My Drive\kimbridges-documents\<name>\` via Windows
   Explorer. **Copy the *contents*, not the `_output` folder
   itself** — a common slip nests everything under
   `<name>/_output/`, which yields a 404 when the card is
   clicked and a missing card image (the link expects
   `<name>/index.html` and `<name>/<cover>.png` at the folder
   root). Caught with coenosr, 2026-06-15. **Cleaner alternative
   (used for lists, 2026-06-16 — Kim: "a very clean procedure
   now"):** do the copy from **R**, which both avoids the
   nesting slip and sidesteps the bash-mount non-propagation
   (Finding 001/005). Into a freshly created `<name>/` folder:
   `file.copy(list.files("G:/My Drive/Projects/<name>/_output",
   full.names = TRUE), "G:/My Drive/kimbridges-documents/<name>",
   recursive = TRUE, overwrite = TRUE)` — lands the *contents*
   directly. (Note: `unlink(recursive=TRUE)` to pre-clean is
   blocked by the R bridge's delete guard, so only use this for a
   new folder, or clear an existing one in Explorer first.)
3. **Add the listing stub.** Create
   `G:\My Drive\kimbridges-documents\docs\<name>.qmd` with
   the YAML metadata (title, subtitle, categories, `image:`
   pointing to `../<name>/<name>_cover_art_text.png`) and a
   `[View Document](../<name>/){.btn .btn-primary}` link.
   Match an existing stub (e.g., `docs/storylines.qmd`) for
   format.
4. **Update `_quarto.yml`.** Add `<name>/**` to the
   `resources:` list in
   `G:\My Drive\kimbridges-documents\_quarto.yml`, in
   alphabetical position.

**Build and push (every deploy, new or update):**

5. **Render the documents site.** From a Terminal in
   `G:\My Drive\kimbridges-documents\`, run `quarto render`.
   The site is written to `_site/`, with the new card on the
   index and the document subfolder in place.
6. **Push to Netlify.** In the Netlify dashboard, find the
   **existing** `kimbridges-documents` site tile and click
   it. Inside that site's view, go to the **Deploys** tab.
   There is a drag-and-drop area for manual deploys; drag
   the `_site` folder (the whole folder, not its contents)
   onto it. Netlify uploads, processes, and publishes —
   typically within a minute.

**Critical distinction — "Add new project" vs "update
existing project".** Clicking "Add new project" in the
Netlify dashboard creates a *new* standalone site, not an
update to the existing one. To update kimbridges-documents
you must click into the existing `kimbridges-documents`
site tile first, then go to its Deploys page. The
whittakerr deploy on 2026-05-25 caught this — a standalone
`whittakerr.netlify.app` was created inadvertently and then
deleted before the correct update-existing path was used.

**Verify.** Reload
`https://kimbridges-documents.netlify.app/` (hard refresh
if needed). The new card should appear on the documents
index, and clicking it should open the document.

## Document Landing Page Concept (Designed, Not Built)
Each document can have an overview/ subfolder with optional slots:
infographics (PNG), podcast (M4A/MP3), summary (PDF). The colors
document has a prototype with two infographics and a podcast.

## Next Steps
1. Implement document landing page template
2. Add remaining documents from Quarto Pub inventory
3. Create workflow for adding new documents

## Collaborators / Dependencies
None

## Blockers
None

---
## Log
### 2026-05-07
Project file created during PKM update session. Site is live with
13 documents. Landing page concept designed with colors/ as prototype
(two infographics and a podcast in colors/overview/).

### 2026-05-10
Storage migrated from C:\Users\kim\kimbridges-documents to
G:\My Drive\kimbridges-documents. Greenfield migration — no
prior G: copy to reconcile. 712 source files copied via rsync
(out of 1497 total at C:; 785 build-artifact files in .quarto/
and _site/ excluded, plus Windows shell symlinks My Music / My
Pictures / My Videos). File counts match. The on-disk count
of 14 document subfolders (including docs/ which holds stub
.qmd files) is consistent with the project_index.md "13 documents"
description if docs/ is counted as the index layer rather than
a document. Migration part of the larger Mirror→Stream and
housekeeping work in proj_PKM.md.

### 2026-05-12 (correction — bash mount discovery and recovery)
The 2026-05-10 migration above did not actually propagate to
Drive cloud. Diagnosed 2026-05-12: bash writes via Cowork sandbox
mount path do not route through Drive for Desktop. The "file
counts match" verification was sandbox-vs-sandbox. Greenfield
status confirmed (no prior Drive copy at root). Recovery
2026-05-12: Kim copy-pasted C:\Users\kim\kimbridges-documents
into G:\My Drive\ via Windows Explorer. Verified via Drive MCP
that the folder is now in Drive cloud (created
2026-05-12T08:00:45) and all 14 document subfolders are
propagating (colors, _site, docs, .quarto, milestones,
using_an_llm, gePoints, sitemaps, storylines, photolocations
visible on first page; citations, flora, pedigree, plainmaps,
r_api, r_basics on subsequent pages). The canonical state
described in Locations is now accurate. See pkm_findings.md.

### 2026-05-25
Whittakerr published — the fourteenth document in the
collection, deployed at
https://kimbridges-documents.netlify.app/whittakerr/. The
deploy mechanism (long flagged as an open question in
`style_multichapter_doc.md`) was worked through end-to-end
in the same session and is now documented in the new
Deployment Workflow section above. Key lesson worth
remembering: in the Netlify dashboard, "Add new project"
creates a new standalone site rather than updating the
existing one; updates require clicking into the existing
site tile's Deploys tab first. The whittakerr publication
also closes the substantial 2026-05-12 → 2026-05-25 work
run on the whittakerr project (see proj_whittakerr.md).

### 2026-05-28 (deprecated C: copy deleted)
Kim deleted C:\Users\kim\kimbridges-documents from the local
filesystem. The C: copy had served as the working location
prior to the 2026-05-12 migration to Drive; the verification
period it was preserved through has long since passed — the
2026-05-25 whittakerr publication alone confirmed the
G:-sourced deployment chain end-to-end, and the C: copy had
not been modified since migration (confirmed by its
pre-2026-05-10 mtimes in the 2026-05-27 Desktop survey).
Locations section above updated to retire the Deprecated
line. The G: canonical source is unchanged. See
session_log.md 2026-05-28 and priorities.md.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Ready: live, with concrete
queued work (landing-page template, additional documents). Part of
the collection-wide back-fill; see proj_PKM.md and session_log.md
(2026-05-30) for the scheme.

### 2026-06-15 (coenosr published — fifteenth document)
**coenosr** is live at https://kimbridges-documents.netlify.app/coenosr/ — the fifteenth
document. Listing stub `docs/coenosr.qmd` (categories Ecology/R/Methods) and `coenosr/**`
in `_quarto.yml` resources added by Claude; Kim rendered the doc and the site and drag-deployed.
One deploy gotcha caught and added to the Deployment Workflow above: the first copy nested the
render under `coenosr/_output/` (copy the *contents* of `_output/`, not the folder), which gave a
404 + missing card image until the folder was flattened and the site re-rendered. With coenosr, the
Ceska/COENOS "lost technology" recovery is fully delivered: faithful R package on GitHub +
companion book live.

### 2026-06-16 (lists published — sixteenth document)
**lists** is live at https://kimbridges-documents.netlify.app/lists/ — the sixteenth document.
Listing stub `docs/lists.qmd` (categories Ecology/R/Methods, Nakamura-Fish cover) and `lists/**`
in `_quarto.yml` resources added by Claude; the render copy was done **from R** (`file.copy` of the
`_output/` contents into a fresh `lists/`), which avoided the coenosr nesting gotcha entirely — Kim:
"It went very smoothly!!! This is a very clean procedure now." Kim rendered the site and drag-deployed
to the existing tile. lists has a companion R package, **listsr**, live on GitHub (proj_listsr.md).
The Deployment Workflow above gains the R-copy alternative to step 2.

### 2026-07-25 (ai_microscope published - nineteenth document)
**Preview & Review** (*Rebuilding the AI Microscope*) is live at
https://kimbridges-documents.netlify.app/ai_microscope/ - the nineteenth document. Listing stub
`docs/ai-microscope.qmd` (title "Preview & Review", categories AI / Botany / Design, cover
`ai_microscope_cover_art_text.png`) and `ai_microscope/**` in `_quarto.yml` resources added by
Claude; the copy was done from R (`file.copy` of the `_output/` contents into a fresh
`ai_microscope/`), the lists-session procedure, which again avoided the coenosr nesting gotcha. Two
additions to the routine worth keeping: (1) before rendering the site, walk every `src=` in every
page of the new folder and confirm the file exists on disk - cheap, and it catches a broken copy
before the deploy rather than after; (2) `quarto::quarto_render()` now runs the SITE render from the
R bridge directly, which overruns the MCP timeout and makes the bridge look dead for a couple of
minutes but completes normally (Finding 017). Kim drag-deployed to the existing tile.
Companion project: proj_AI_Microscope.md.

### 2026-07-29 (vouchr published - twentieth document)
**Voucher Labels** is live at https://kimbridges-documents.netlify.app/vouchr/ - the twentieth document, and the
companion to the `vouchr` package. Slug chosen as `vouchr` on the precedent that
companion-package documents take the package name (whittakerr, coenosr, checklistr, lists,
gePoints), and matching ai_microscope where the card title and the folder name differ. Listing
stub `docs/vouchr.qmd` (title "Voucher Labels", categories Botany / Methods / R, cover
`vouchr_cover_art_text.png`) and `vouchr/**` in `_quarto.yml` resources added by Claude; the
copy was done from R into a fresh folder, the lists-session procedure, and explicitly checked
for the coenosr nesting slip. Kim drag-deployed to the existing tile and verified.

**One addition to the routine worth keeping: `_quarto.yml` in this collection is CRLF.**
Editing it with `writeLines()` from R on Windows would rewrite every line ending in the file.
It was edited in binary instead and the byte delta confirmed as exactly the 17 bytes of the
inserted line. The same trap had already been caught earlier the same day in `session_log.md`.

**Also worth keeping:** the pre-deploy `src=` walk was run twice - once on the document's
`_output/` and again on the copied `vouchr/` folder, since the copy is the artifact that
actually ships. 211 local references, none missing, on both passes.

Companion projects: proj_specimen_labels.md, proj_vouchr.md.

---

### 2026-08-02 -- ai_podcasts added; the site crossed 373 MB

Twenty-first document. Followed the five-step workflow above; the render again overran
the 60-second bridge timeout and again completed (Finding 017) -- two polls were needed.
Reconciled `_site` 1005 -> 1042 files, **0 removed**, which is the check that matters:
the resources model copies whole folders, so a mistake here shows up as deletions.

**New category `Audio`** on the listing page, its first member.

The document brought 31 MB of mp3 with it. Every venue page that used to embed
SoundCloud now serves its own audio, so the site's size is going to keep growing in
whole-megabyte steps rather than kilobytes. Netlify Drop uploads scale with that.

See proj_AI_Podcasts.md.

---

### 2026-08-03 -- llm_examples added; the venue's first converted-from-Google-Docs book

Twenty-second document. `_site` 1042 -> 1092, **0 removed**; reconciles at 22 folders /
22 resources / 22 cards. Two folders changed in one pass: `llm_examples` new, and
`using_an_llm` reinstalled after its source was re-rendered to repoint the last ISSUU
link. **That link was the final non-historical legacy pointer in any venue.**

Worth noting for the venue's conventions: every other document here began life as Quarto.
This one began as a Google Doc and was converted. The route -- `drive_download(type =
"docx")` -> pandoc -> split at H1 -- is reusable, and Kim has other Docs. See
proj_LLM_Examples.md and Finding 025.

Size note: the venue has gone 342 -> 373 -> 393 MB in three days. Netlify Drop uploads
scale with that, and self-hosted media is why.
