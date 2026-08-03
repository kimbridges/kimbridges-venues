# PROJECT: Braun_Blanquet
_Last updated: 2026-05-30_
_Status: Active_
_Focus readiness: Ready_

## Type
Quarto multi-chapter document

## Objective
A Quarto book about the Braun-Blanquet vegetation analysis method:
its conceptual framework, the table-construction and reordering
procedure, the synthetic test cases that illuminate the method's
behavior, its strengths, and its limitations. Demonstrates the
bbstruct and bbSynth R packages as the worked-example toolchain.

## Current Status
Multi-chapter Quarto book at G:\My Drive\Projects\Braun_Blanquet\
with the standard book skeleton: chapters drafted (Conceptual.Rmd,
Data.Rmd, Synthetic.Rmd, Functions.Rmd, Limitations.Rmd,
Interpretation.Rmd), opening and closing material
(intro.qmd, summary.qmd, references.qmd), bibliography
(references.bib), and rendered output (`_book/`). Synthetic test
data is present both in `data/` and `inst/extdata/`, sharing the
12x24 block and gradient examples with bbstruct. A
`make_synthetic_tables.R` script lives at the root.

## Locations
- Source: G:\My Drive\Projects\Braun_Blanquet (.Rmd / .qmd files)
- Data: G:\My Drive\Projects\Braun_Blanquet\data,
  G:\My Drive\Projects\Braun_Blanquet\inst\extdata
- Rendered output: G:\My Drive\Projects\Braun_Blanquet\_book
- Images: cover.png, tab_3.png, gradient_color.png,
  elev_color_table.png, Analytical_Table.png, Analytical_Table2.png
- GitHub: not yet
- Eventual deployment target: kimbridges-documents (TBD; the
  Braun-Blanquet book would join the kimbridges-documents family
  of multi-chapter documents when ready to ship)

## Key Files
- intro.qmd — opening
- Conceptual.Rmd — conceptual framework chapter
- Data.Rmd — data structure chapter
- Synthetic.Rmd — synthetic-test-case chapter (uses bbSynth)
- Functions.Rmd — the bbstruct toolkit chapter (uses bbstruct)
- Interpretation.Rmd — interpretation chapter
- Limitations.Rmd — limitations chapter
- summary.qmd — closing
- references.qmd, references.bib — bibliography
- _book/ — rendered output
- data/synthetic_block_12x24.csv, .._sites.csv, .._species.csv —
  block synthetic data (shared with bbstruct)
- data/synthetic_gradient_12x24.csv, .._species.csv — gradient
  synthetic data (shared with bbstruct)
- data/bb_blocks_raw.csv, bb_blocks_unordered.csv,
  bb_blocks_ordered.csv, gradient.csv — additional data
- inst/extdata/ — package-style external data
- make_synthetic_tables.R — synthetic-table builder script

## Related Projects — Braun-Blanquet Cluster

Four Projects work together around the Braun-Blanquet vegetation
analysis method:

- **bbstruct** — structural analysis tools for Braun-Blanquet
  tables. See `proj_bbstruct.md`.
- **bbSynth** — synthetic-data generator. See `proj_bbSynth.md`.
- **Braun_Blanquet** (this file) — Quarto multi-chapter document
  about the method, demonstrating both packages.
- **Ceska** — historical reference: 1991 COENOS executable and
  example data, the methodology being reconstructed. See
  `proj_Ceska.md`.

The pattern mirrors whittakerr: an R package toolkit plus a Quarto
Document that uses the toolkit as the primary worked example. Here
the toolkit is two packages, not one, with bbSynth feeding the
test data and bbstruct doing the analysis. The Ceska reference
adds a layer: the document explains a methodology that already
existed in 1991, was implemented in compiled Pascal, and is being
recovered in modern R because the source is lost. A natural
chapter would be the historical-and-recovery framing, perhaps as
the document's opening or as a sidebar to the Functions chapter.

## Next Steps
1. Confirm clean Quarto render against the bbstruct and bbSynth
   functions installed as packages (rather than sourced inline).
2. Decide whether the duplicated synthetic CSVs in data/ and
   inst/extdata/ should remain (matching the package convention)
   or whether bbSynth should be the single source of truth.
3. Style review against `style_multichapter_doc.md` (the
   whittakerr-derived style guide) to align chapter conventions.
4. Decide deployment to kimbridges-documents and proceed via the
   documented workflow there.

## Collaborators / Dependencies
- bbstruct (analysis package)
- bbSynth (synthetic-data package)

## Blockers
None.

---
## Log

### 2026-05-28
Project file created during PKM housekeeping continuation. The
Braun_Blanquet folder was moved from Desktop to
G:\My Drive\Projects\Braun_Blanquet on 2026-05-27. Documented as
one of three Projects in the Braun-Blanquet cluster (bbstruct,
bbSynth, Braun_Blanquet). Style alignment with
style_multichapter_doc.md and deployment to kimbridges-documents
queued for later.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Ready: chapters drafted and
rendered; clear next steps (render against the installed bbstruct /
bbSynth packages, style review, deploy). The document half of the
Braun-Blanquet cluster. Part of the collection-wide back-fill; see
proj_PKM.md and session_log.md (2026-05-30).
