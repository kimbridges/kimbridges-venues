# G:\My Drive\kimbridges-* — Summary Listing
_Created: 2026-05-28_

## Purpose

Top-level inventory of the four kimbridges-* website folders at
the root of `G:\My Drive\`, built as the durable verification
artifact at the close of the 2026-05-27 / 2026-05-28
housekeeping cycle. Each folder corresponds to one Netlify site
and is described by one `proj_*.md`. The listing complements
`listing_projects.md`, which inventories `G:\My Drive\Projects\`.

## kimbridges-info

The hub site connecting all of Kim's technical and creative
work — five components, navbar to Stories, Documents,
Collections, Schedule, Following.

- **proj_*.md:** proj_kimbridges_info.md
- **Live:** https://kimbridges.info
- **Source:** G:\My Drive\kimbridges-info
- **Top-level contents:** index.qmd plus four gateway .qmd
  files (stories, documents, collections, schedule, following),
  _quarto.yml, custom.css, Kim_with_beer.png (profile photo),
  10 source files total.
- **No residuals.** Both the C: copy (deleted 2026-05-28) and
  the kimbridges-info_old backup (also deleted 2026-05-28) are
  gone; this G: folder is now the sole source.

## kimbridges-stories

The Quarto website hosting illustrated PDF stories.

- **proj_*.md:** proj_kimbridges_stories.md
- **Live:** https://kimbridges-stories.netlify.app
- **Source:** G:\My Drive\kimbridges-stories
- **Top-level subfolders:**
  - `pdfs/` — 50 deployed story PDFs (canonical)
  - `pdfs/thumbs/` — generated thumbnails (older path; current
    workflow uses `images/`)
  - `stories/` — listing stubs (one .qmd per story)
  - `images/` — current thumbnails (150 DPI from PDF first pages)
  - `underway/` — 10 in-progress stories, each its own subfolder
    (plus a couple of legacy loose-file entries):
    - `2023_Japan_Story/`
    - `Cranes/` (filed 2026-05-27)
    - `Kakaako_Birds/` (filed 2026-05-27)
    - `Kakaako_Buildings/` (filed 2026-05-27)
    - `Kauai_Birds/` (filed 2026-05-27)
    - `LLM_Examples/` (filed 2026-05-28 from PDF_archive)
    - `Photo_Book_workingnotes/` (filed 2026-05-27)
    - `San_Juan_Island/` (filed 2026-05-27)
    - `Selective_Focus/` (filed 2026-05-28 from PDF_archive)
    - `Smart_car/` (older entry)
  - `_site/`, `_quarto.yml`, `add_stories.py`,
    `stories_inventory_v2.xlsx`, `README.md`
- **Workflow:** `add_stories.py` promotes an `underway/<name>/`
  story to deployed (`pdfs/` plus the listing stub).
- **Residual:** G:\My Drive\kimbridges-stories_stale_2026-05-12
  (historical backup from the 2026-05-12 recovery; preserved in
  the Locations block of proj_kimbridges_stories.md).

## kimbridges-documents

The Quarto website hosting rendered HTML documents.

- **proj_*.md:** proj_kimbridges_documents.md
- **Live:** https://kimbridges-documents.netlify.app
- **Source:** G:\My Drive\kimbridges-documents
- **Top-level layout:** `index.qmd` (grid listing), `_quarto.yml`,
  `custom.css`, `docs/` (one stub .qmd per document), plus 14
  document subfolders.
- **The 14 document subfolders, mapped to source where known:**
  - `citations/` — source at G:\Projects\citations (proj_citations.md)
  - `colors/` — source not in PKM
  - `flora/` — source not in PKM
  - `gePoints/` — source at G:\Projects\gePoints (proj_gePoints.md);
    R-package documentation pattern
  - `milestones/` — source at G:\Projects_Archive\milestones
    (proj_milestones.md)
  - `pedigree/` — source not in PKM
  - `photolocations/` — source not in PKM
  - `plainmaps/` — source not in PKM
  - `r_api/` — source not in PKM
  - `r_basics/` — source at G:\Projects\R_Basics (proj_R_Basics.md)
  - `sitemaps/` — source at G:\Projects\sitemaps (proj_sitemaps.md)
  - `storylines/` — source at G:\Projects\storylines (proj_storylines.md)
  - `using_an_llm/` — source not in PKM
  - `whittakerr/` — source at G:\Projects\whittakerr
    (proj_whittakerr.md); published 2026-05-25
- **Known gap (post-cycle).** Seven document subfolders have no
  source-side `proj_*.md`: colors, flora, pedigree, photolocations,
  plainmaps, r_api, using_an_llm. Source for each presumably exists
  somewhere (GitHub repo, Quarto Pub history, or older filesystem
  location), but is not currently tracked in this PKM. Filing is
  deferred as a separate task; the deployed HTML is the
  authoritative artifact in the meantime.
- **Deployment workflow:** documented end-to-end in
  proj_kimbridges_documents.md.

## kimbridges-collections

The Quarto website hosting curated multimedia collections.

- **proj_*.md:** proj_kimbridges_collections.md
- **Live:** https://kimbridges-collections.netlify.app
- **Source:** G:\My Drive\kimbridges-collections
- **Top-level layout:** `index.qmd`, `gallery.qmd`, `jones.qmd`,
  `_quarto.yml`, `custom.css`, plus two collection subtrees.
- **Gallery/ subtree (the Gallery Collection):**
  - Deployed assets: pdfs/, audio/, images/, viewer.html (PDF.js
    flipbook)
  - Working subfolders for the six gallery products:
    - `Gallery_Catalog/` (filed 2026-05-27) — working source for
      product 1 (Gallery Catalog PDF flipbook)
    - `Tad_Adventures/` (filed 2026-05-27) — working materials
      for a Gallery product in development around Tad Nakamoto
    - `Cuisine_Art/` (filed 2026-05-28) — working source for
      the Cuisine Art product (artwork, InDesign, finished PDFs,
      two Pilk-Collection .m4a podcast pieces)
- **Jones/ subtree (the Jones Collection):**
  - Annotated_Editions/, Sea_Otter/, Canoe_Story/, Gazetteer/,
    Methodology/, Original_Scans/, images/, pdfs/
  - `Jones_analysis/` (filed 2026-05-27) — working materials for
    ongoing Jones analysis (Reports/, Pilot/ with per-year
    page_images/, Jones_story/)
- See proj_jones_collection.md for the Jones-specific Project.

## Cross-references between the families

Three patterns connect the families and are worth keeping in
view:

- **Source vs deployed split for documents.** The kimbridges-
  documents site is the *deployment target*; the source for each
  document lives in `G:\My Drive\Projects\<name>\` (current
  pattern) or in a GitHub repo (older R-package pattern). The
  source ↔ deployment mapping is recorded in the kimbridges-
  documents listing above.
- **Story development convention.** Stories under development
  live at `kimbridges-stories\underway\<story_name>\`, one
  folder per story. Documented in proj_kimbridges_stories.md.
- **Collection working source convention.** Working source for
  collection products lives inside each collection subfolder
  (e.g., `Gallery/Gallery_Catalog/`), not in `Projects/`.
  Documented implicitly via the Key Files section of
  proj_kimbridges_collections.md.

## State at the close of the housekeeping cycle (2026-05-28)

All four kimbridges-* folders have a current proj_*.md. All four
C:\Users\kim\kimbridges-* copies are deleted. The
kimbridges-info_old backup is deleted. The
kimbridges-stories_stale_2026-05-12 historical backup is
preserved. The kimbridges-documents source-side gap (seven
unmapped document subfolders) is noted above as deferred.
