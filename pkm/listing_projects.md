# G:\My Drive\Projects\ — Summary Listing
_Created: 2026-05-28_

## Purpose

A folder-by-folder inventory of `G:\My Drive\Projects\`, built
as the durable verification artifact at the close of the
2026-05-27 / 2026-05-28 housekeeping cycle. One row per folder.
Every folder is now described by exactly one `proj_*.md`.

The listing serves three purposes: (a) inventory the canonical
code-class Projects so any future drift between filesystem and
PKM is detectable, (b) document the cluster relationships at a
glance, (c) provide the input the eventual Phase 2 R
health-check script (proj_PKM.md Next Steps) can drift-check
against.

## Clusters

Three project clusters span multiple Projects in the listing
below:

**Book assembly cluster.** photoPress (earliest attempt;
git-tracked package + Quarto driver chapters), Photo_Book
(working sandbox with examples and older code), photobookr
(intended canonical package). Once a few examples have been
run through photobookr the cluster will simplify; see each
proj_*.md Related Projects section.

**Braun-Blanquet cluster (4 core + 2 satellites).** bbstruct
(structural analysis package), bbSynth (synthetic-data
generator), Braun_Blanquet (Quarto document explaining the
method), Ceska (1991 COENOS executable + relevé data; "lost
technology" reference). Satellites: Community_Analysis
(general two-way-table utilities) and sitemaps (via
R/bb2google.R, which converts Braun-Blanquet data to
Google-Maps geography).

**LLM + R sibling pair (likely; relationship to be
confirmed).** LLM_Creates_R (multi-chapter document) and
R_LLM_tests (Quarto test bed with substantial chapter
overlap).

## Folders (alphabetical)

| Folder | proj_*.md | Type | One-line note |
|---|---|---|---|
| accessOAI | proj_accessOAI.md | R package | OAI-PMH client; on GitHub; may need API update |
| Audio | proj_audio.md | Audio dialog workflow | First-test materials; Gallery audio product in prep |
| bbstruct | proj_bbstruct.md | R package | Braun-Blanquet structural analysis — cluster member |
| bbSynth | proj_bbSynth.md | R package | Synthetic-data generator — cluster member |
| Braun_Blanquet | proj_Braun_Blanquet.md | Quarto multi-chapter document | Method explanation — cluster member |
| Ceska | proj_Ceska.md | Historical reference | 1991 COENOS executable + relevé data — cluster member (lost technology) |
| citations | proj_citations.md | R package | Works; needs restructuring |
| Colors_of_the_Year | proj_Colors_of_the_Year.md | Quarto multi-chapter document | Pantone colors analysis; queued for audio rendering |
| Community_Analysis | proj_Community_Analysis.md | R utility | Two-way-table helpers — Braun-Blanquet satellite |
| discussionsr | proj_discussionsr.md | Research notes (placeholder) | Berlin 1992 reference + notes; direction TBD |
| geContour | proj_geContour.md | R package | On GitHub; nested as geContour/geContour/; needs documentation |
| gePoints | proj_gePoints.md | R package | On GitHub; needs documentation |
| Koch_voronoi | proj_Koch_voronoi.md | R tool | Phase 1 done; Phase 2 pending; folder renamed from Koch_voronoi_pgm 2026-05-27 |
| labelextractr | proj_labelextractr.md | R tool | Code works; needs packaging |
| LLM_Creates_R | proj_LLM_Creates_R.md | Quarto multi-chapter document | Many chapters drafted — sibling pair with R_LLM_tests |
| Photo_Book | proj_Photo_Book.md | R sandbox + example data | Working examples for photobookr — cluster member |
| photobookr | proj_photobookr.md | R package | Intended canonical book-assembly package — cluster member |
| photoPress | proj_photoPress.md | R package + Quarto driver template | Git-tracked; cluster member (older attempt) |
| photothumbsr | proj_photothumbsr.md | R package | Working; needs unbundling |
| Profile_Diagrams | proj_Profile_Diagrams.md | R tool + Quarto document | Vegetation profile diagrams |
| R_Basics | proj_R_Basics.md | Quarto multi-chapter document | Basics reference; deployed to kimbridges-documents/r_basics |
| R_LLM_tests | proj_R_LLM_tests.md | Quarto working examples | Test bed — sibling pair with LLM_Creates_R |
| Scripting_Discovery | proj_Scripting_Discovery.md | R exploration + methodology | Platt + mRNA worked example; finished PDF |
| sitemaps | proj_sitemaps.md | R package + Quarto document | Original document; deployed to kimbridges-documents/sitemaps; format + Google API need updating; Braun-Blanquet satellite |
| storylines | proj_storylines.md | Quarto multi-chapter document | Trip-log narratives; deployed to kimbridges-documents/storylines; predates style guide |
| sumo | proj_sumo.md | Data analysis (R + Quarto) | Sumo tournament data; exploratory |
| Temperature_Patterns | proj_Temperature_Patterns.md | R analysis project | Eugene 32°F case study; local .git repo |
| thinnr | proj_thinnr.md | R package | Photo-thinning utility; early skeleton |
| timelinesr | proj_timelinesr.md | R package + Quarto Document | Photo timelines with GPS; package at root + documentation/ |
| Trip_Log | proj_Trip_Log.md | R tool + travel-photo workflow | Kyoto_1 example; upstream of storylines |
| whittakerr | proj_whittakerr.md | R package + Quarto Document | Package v0.2.0 on GitHub; document published 2026-05-25 |

**Total: 31 folders, 31 proj_*.md files, no gaps.**

## Notes

The R packages span several maturity stages: published/active on
GitHub (accessOAI, geContour, gePoints, whittakerr); modern
package skeleton not yet on GitHub (bbstruct, bbSynth, photoPress,
sitemaps, thinnr, timelinesr); older form (citations, labelextractr,
photobookr, photothumbsr); demo or working sandbox (Photo_Book,
Community_Analysis); and historical reference (Ceska).

The Quarto documents are in various states of style alignment with
`style_multichapter_doc.md`, the whittakerr-derived style guide.
Documents that predate the guide (sitemaps, storylines, possibly
others) will need style review at their next active work pass —
flagged in each proj_*.md Next Steps.

The cluster relationships (book assembly, Braun-Blanquet, LLM+R)
are documented bidirectionally in each member's Related Projects
section and reflected in the Active Focus block of
project_index.md.
