# PROJECT: kimbridges-collections
_Last updated: 2026-07-28_
_Status: Standing_
_Focus readiness: Ready_

## Type
Website (Netlify)

## Objective
A Quarto website for curated multimedia sets where one idea spawns
the next. Each collection combines art, audio, video, and narrative
around a single premise. Collections document AI capabilities at
specific points in time.

## Current Status
Live on Netlify. **Four pages**: three collections (The Gallery
Collection, The Jones Collection, and The Briefing Books) plus
the site-wide methods page **Behind the Curtain**, published
2026-07-26. Behind the Curtain is a methods page, not a
collection, so it sits in the navbar and is deliberately not in
the index grid listing. Site architecture supports additional
collections via the grid listing. See proj_jones_collection.md
and proj_briefing_book.md for those project files.

## Locations
- **Canonical source**: G:\My Drive\kimbridges-collections (Drive
  for Desktop in Stream mode; migrated from C: on 2026-05-12 via
  Windows Explorer copy-paste. The earlier 2026-05-10 bash-rsync
  attempt did not propagate to Drive cloud — see Log and
  pkm_findings.md.)
- Netlify: https://kimbridges-collections.netlify.app
- Hub link: https://kimbridges.info → Collections

## Key Files
- index.qmd — grid listing page pointing to collection .qmd files
- gallery.qmd — The Gallery Collection landing page (single scrolling narrative)
- jones.qmd — The Jones Collection landing page (single scrolling narrative)
- briefing_books.qmd — The Briefing Books landing page (both sites on one page; built to take more)
- behind_the_curtain.qmd — site-wide methods page (navbar only, NOT
  in the index listing); .input-doc panels carry two verbatim inputs
- Behind_the_Curtain/chain_fig.R — builds images/briefing_chain.svg
  (four stages; person solid orange, engine dotted blue)
- custom.css — styles for hero images, section dividers, objective boxes, video, audio, placeholders
- Gallery/pdfs/ — 3 PDFs (Gallery Catalog, Cuisine Art, Orbits)
- Gallery/audio/ — 1 MP3 (Gallery Catalog Review podcast)
- Gallery/images/ — 8 images (section headers, covers, screenshots)
- Gallery/viewer.html — PDF.js flipbook viewer
- Gallery/Gallery_Catalog/ — working source for the Gallery Catalog
  PDF product (artwork files, Claude_discussions/, Video2/, Catalog.pdf)
- Gallery/Tad_Adventures/ — working materials for a Gallery product
  in development around Tad Nakamoto (drafts/, PNG_images/)
- Gallery/Cuisine_Art/ — working source for the Cuisine Art Gallery
  product: Art/ subfolder with the artwork set, Cuisine_Art.indd
  (InDesign source), Cuisine_Art.pdf and Cuisine_Art_with.pdf,
  Text_draft.txt / Text_draft_2.txt, two .m4a audio podcasts
  (The Pilk Collection Hoax and The Pilk Collection: Hidden Recipes),
  Gallery_logo.png, Gallery_curator.png, James Cogsworth.png, Pilk.png
- Jones/pdfs/ — Sea Otter Narrative, Census Map, Gazetteer, SEB Workshop Paper, Jones Story Transcription
- Jones/csv/ — Sea Otter Census Data, Gazetteer (CSV)
- Jones/images/ — section headers, maps, supporting imagery
- Jones/Jones_analysis/ — working materials for ongoing Jones
  analysis (Reports/, Pilot/page_images/ by year, Jones_story/)
- Briefing_Books/pdfs/ — the two bound books plus all 14 individual
  report PDFs under kipuka_puaulu/ and iliau_loop/
- Briefing_Books/images/ — card composite + two site covers
- Briefing_Books/data/ — 4 checklist CSVs (master lists, target
  analysis, rim checklist, specimen records)

## Architecture
- Quarto website project (type: website)
- Grid index page; each collection is a single .qmd file with listing metadata in its YAML
- No intermediate stub pages; index links directly to collection pages
- Collection pages are single scrolling narratives with embedded media:
  PDF flipbook iframes, HTML audio players, YouTube video embeds
- Each section has: section image, narrative text, objective box, embedded media

## Current Collections

### The Gallery Collection
Six products testing AI capabilities from mid-2024 through 2026:
1. Gallery Catalog — AI-generated art for a fictitious NYC gallery (PDF flipbook)
2. Gallery Catalog Review — AI-voiced podcast critiquing the catalog (audio)
3. Gallery Show Review — animated artist characters in video (YouTube embed)
4. Pilk Collection Auction — photographs transformed into fine art (PDF flipbook)
5. Orbits — book-length illustrated narrative (PDF flipbook)
6. Book Signing — placeholder for lip-synced video (under development)

### The Jones Collection
AI-assisted recovery of Robert D. Jones Jr.'s 27-year wildlife
record from Izembek and Aleutian Islands NWRs (1948–1974). Five
deliverables: interactive timeline, sea otter case study (narrative,
data, maps), the Canoe Story, geographic gazetteer, methodology
paper for the SEB AI Workshop. Pipeline: olmOCR-2-7B + AI
contextual interpretation. See proj_jones_collection.md.

### The Briefing Books
Published 2026-07-26. Per-site field briefings for data-driven
specimen collection, from the briefing_book project. Two sites:
Kīpuka Puaulu (HAVO, Hawaiʻi Island; 22 pp; a collect-first site)
and the ʻIliau Loop Trail (Kokeʻe, Kauaʻi; 14 pp; an observe-first
site). Unlike Gallery and Jones, this collection has a UNIFORM
format, so the page documents the format as well as the two
instances. Seven reports per site: place at several scopes, master
list, climate and site, herbaria and collectors, collecting
targets, contested identities, field card. Published as working
prototypes ahead of Dr. McClatchey's critique so other reviewers
can be recruited through the site. The distinguishing claim: the
other collections were stepwise, this one hands orchestration to
the AI engine. See proj_briefing_book.md.

### Behind the Curtain (methods page, not a collection)
Published 2026-07-26. Documents how all three collections were
actually made. Six sections: three divisions of labour; the input
contract (the ʻIliau site_preview.md reproduced verbatim, with
four of its sentences traced into the finished book); the chain;
what it is made of (checklistr as the engine,
vouchr::site_extract, whittakerr + WorldClim, elevatr, Esri
tiles, qpdf) with the standing instruction quoted in full from
Projects/checklists/briefing_book_commission.md; the constraints
that shaped the form; what stays human. 165 lines, LF.

## Writing Style
Short sentences. No em dashes. "Objectives" not "goals." Text was
collaboratively edited section by section. Final text saved in Google
Doc "The Gallery Collection (Edited)."

## Next Steps
1. Complete Book Signing section with lip-synced video (Gallery)
2. ~~Add Behind the Curtain page~~ DONE 2026-07-26
3. Add additional collections as they are developed
4. Kim has several other collections to add (part of file clean-up)
5. Future collections that apply the Jones recovery methodology
   to other historical record sets get their own proj_*.md files
   (intake protocol)

## Collaborators / Dependencies
None

## Blockers
Book Signing awaits lip-sync video capability.

---
## Log
### 2026-05-07
Project file created during PKM update session. Gallery Collection
landing page built as single scrolling narrative with six product
sections. Text collaboratively edited to Kim's style preferences.
Site deployed to Netlify.

### 2026-05-07 (Opus 4.7 — Jones backfill)
Updated to reflect The Jones Collection (published 2026-05-05).
Reorganized "The Gallery Collection" section into a "Current
Collections" section that lists both. Added Jones files to Key
Files. Per Kim, the Jones Collection is finished. See
proj_jones_collection.md for the Jones project file. This update
is part of the PKM Operating Protocol adoption: a project that
existed without a proj file (Jones) was given one, and this
parent project file was updated to reflect the actual state of
the site.

### 2026-05-10
Storage migrated from C:\Users\kim\kimbridges-collections to
G:\My Drive\kimbridges-collections. Greenfield migration — no
prior G: copy. 144 source files copied via rsync (out of 210
total at C:; 66 build-artifact files in .quarto/ and _site/
excluded). File counts match. Both Gallery/ and Jones/ subtrees
intact along with the recipe doc, gallery.qmd, jones.qmd, and
configs. Migration part of the larger Mirror→Stream and
housekeeping work in proj_PKM.md.

### 2026-05-12 (correction — bash mount discovery and recovery)
The 2026-05-10 migration above did not actually propagate to
Drive cloud. Diagnosed 2026-05-12: bash writes via Cowork sandbox
mount path do not route through Drive for Desktop. The "file
counts match" verification was sandbox-vs-sandbox. Genuinely
greenfield in this case (no prior Drive copy at root). Recovery
2026-05-12: Kim copy-pasted C:\Users\kim\kimbridges-collections
into G:\My Drive\ via Windows Explorer. Verified via Drive MCP
that the folder, Collections_Recipe.md, gallery.qmd, jones.qmd,
index.qmd, configs, and both Gallery/ and Jones/ subtrees are
now in Drive cloud (folder created 2026-05-12T07:59:11). The
canonical state described in Locations is now accurate. See
pkm_findings.md.

### 2026-05-28 (working subfolders added under Gallery and Jones)
Three working-material folders moved from Desktop to the
collection subtrees during the 2026-05-27 housekeeping
consolidation, reflecting the standing decision that
working source for collection products lives inside the
respective collection folder rather than in a separate
Projects/ location. Gallery/Gallery_Catalog/ holds the
working source for the existing Gallery Catalog product
(artwork files, Claude_discussions/, Video2/, Catalog.pdf).
Gallery/Tad_Adventures/ holds working materials for a new
Gallery product in development around Tad Nakamoto
(drafts/, PNG_images/). Jones/Jones_analysis/ holds working
materials for ongoing Jones analysis (Reports/, Pilot/ with
per-year page_images/, Jones_story/) — Kim flagged in the
2026-05-27 session that this should have lived under Jones/
already; it does now. The Key Files list above is updated
to reflect the three new subfolders. The collection
narrative pages (gallery.qmd, jones.qmd) are unaffected;
this is source consolidation, not deployment change. See
session_log.md 2026-05-27 for the consolidation context.

### 2026-05-28 (Cuisine_Art moved into Gallery)
A fourth working-subfolder added during the same housekeeping
sweep. Gallery/Cuisine_Art/ holds the working source for the
Cuisine Art Gallery product: artwork under Art/, the InDesign
source `Cuisine_Art.indd`, two finished PDFs (Cuisine_Art.pdf
and Cuisine_Art_with.pdf), draft text files, two .m4a podcast
audio pieces (The Pilk Collection Hoax and The Pilk Collection:
Hidden Recipes), plus the Gallery_logo, Gallery_curator,
James Cogsworth, and Pilk supporting images. This makes
Cuisine Art an active Gallery product alongside the existing
Gallery Catalog (product 1 in the gallery.qmd narrative) —
the narrative list of products may need a future edit to
include Cuisine Art if/when it ships.

### 2026-05-28 (deprecated C: copy deleted)
Kim deleted C:\Users\kim\kimbridges-collections from the local
filesystem. The C: copy had served as the working location
prior to the 2026-05-12 migration to Drive; the verification
period it was preserved through has long since passed — all
deployments since 2026-05-12 have been G:-sourced, and the
C: copy had not been modified since migration (confirmed by
its pre-2026-05-10 mtimes in the 2026-05-27 Desktop survey).
Locations section above updated to retire the Deprecated line.
The G: canonical source is unchanged; this is record-keeping
catching up to a redundancy removal. See session_log.md
2026-05-28 and priorities.md.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Ready: live; new collections
can be added (only the Book Signing item is blocked, on lip-sync
video capability). Part of the collection-wide back-fill; see
proj_PKM.md and session_log.md (2026-05-30) for the scheme.

### 2026-07-26 (third collection added: The Briefing Books)
`briefing_books.qmd` created and wired in. index.qmd listing gains
briefing_books.qmd; _quarto.yml resources list gains
Briefing_Books/pdfs/**, images/** and data/** (unregistered asset
paths are not copied into _site, so this line is what makes the
downloads resolve). Assets staged under Briefing_Books/. Kim's
decision: publish the individual report PDFs alongside the bound
books, so a reader can take one facet without the whole book.
Full-resolution sheet scans kept as-is (the R5 report runs ~19 MB)
because the scans ARE the evidence for the determination conflicts;
downsampling would undercut the report's purpose. Route for writes
into this folder is unchanged and worth repeating: G:\My Drive\
kimbridges-collections is NOT a connected folder, so files go
SendUserFile -> device_commit_files into Projects_Index as a
_staging_* file -> file.copy into place via the R bridge -> verify
bytes -> remove the staging file.

### 2026-07-26 (fourth page: Behind the Curtain, the site-wide methods page)
`behind_the_curtain.qmd` created (165 lines, 15700 bytes, LF).
Navbar entry added in _quarto.yml along with the
Behind_the_Curtain/images/** resources glob; the anchor had to be
re-grepped between the two appends because the first insertion
shifted the index. index.qmd deliberately NOT touched: this is a
methods page, not a collection, so it does not belong in the
grid. custom.css gained a .input-doc rule (93 to 115 lines) for
the two verbatim input panels. Kim's three corrections applied,
plus one self-caught: once the standing instruction was
published, the claim that the engine received a coordinate "and
nothing else" stopped being true. Two decisions from Kim: publish
the standing instruction with no reproducibility-gap admission,
and leave the verbatim panel verbatim (so his own "Kipuka"
shorthand stays, against the naming rule, because it is a
quotation). Verified structurally rather than visually: the
Chrome bridge rejects file:// URLs, so div balance, fence counts,
h2/h3 counts and panel counts stood in for looking at it.
Deployed from a DATED staging folder, C:\temp\_site_20260726 (98
files, 112.1 MB, byte-verified), because the R bridge blocks
recursive deletes and reusing C:\temp\_site would have carried
stale files along.
