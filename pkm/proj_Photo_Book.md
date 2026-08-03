# PROJECT: Photo_Book
_Last updated: 2026-05-30_
_Status: Active_
_Focus readiness: Ready_

## Type
R working demo with example data (sandbox for photobookr)

## Objective
A working sandbox for the photo-book assembly workflow. Holds both
implementation code (multiple versions, some older than the
photobookr equivalents) and example datasets the package's
intended use case can be tested against. Functions as the
practical proving ground for photobookr.

## Current Status
Working demonstrator. Multiple completed example runs:
`Stories/01_statue.pdf` and `Stories/02_flower.pdf` are finished
chapters; `Garden.Rmd` is a third in-progress chapter;
`Kyoto_Cover.pdf` and `proof_sheet.pdf` are book-front-matter
proofs. The R scripts at root (`make_map.R`, `csv_to_metadata.R`,
`gt_mods.R`, `photo_image_function.R`, `spread_pdf.R`,
`photo_book_main_integrated.R`, `parse_book_markdown.R`,
`render_section_pdf.R`, `markdown_to_chapters.R`,
`metadata_to_csv.R`) overlap substantially with photobookr's
`documentation/` set — some of these are older versions and need
reconciliation. A small constellation of size/format test files
(`markdown_test.qmd`, `minimal_test.Rmd`, `test_size.Rmd`,
`test_14pt.Rmd`, `test_20pt.Rmd`) document past sizing
experiments.

## Locations
- Code: G:\My Drive\Projects\Photo_Book (R scripts at root)
- Data: G:\My Drive\Projects\Photo_Book\Keepers (original photos +
  processed copies), G:\My Drive\Projects\Photo_Book\KML
  (Statue.kml, Flower.kml)
- Docs/output: G:\My Drive\Projects\Photo_Book\Stories (finished
  chapter PDFs), Kyoto_Cover.pdf, proof_sheet.pdf,
  proof_sheet.html, statue_chapter.pdf
- GitHub: not yet

## Key Files
- Photo_Book.Rproj — RStudio project
- R scripts at root (~10 files) — implementation; overlaps with
  photobookr/documentation/
- Garden.Rmd — in-progress chapter
- Stories/01_statue.pdf, Stories/02_flower.pdf — finished example
  chapters
- Keepers/ — original and processed photos used by the examples
- KML/Statue.kml, KML/Flower.kml — geographic anchors for the
  chapters
- config.csv, metadata.csv, used_images.csv — example data inputs
- Kyoto_Cover.pdf, proof_sheet.pdf — front-matter proofs
- markdown_test.qmd, minimal_test.Rmd, test_size.Rmd,
  test_14pt.Rmd, test_20pt.Rmd — sizing experiments
- Test_Event_Map.html — map viewer test
- temp_render_27664.tex/.log/.Rmd — transient render artifacts

## Related Projects — Book Assembly Cluster

Three related Projects represent stages of an evolving effort to
automate the assembly of illustrated PDF books from photo folders
plus text:

- **photoPress** — earliest attempt; retained for ideas worth
  revisiting. See `proj_photoPress.md`.
- **Photo_Book** (this file) — working sandbox with multiple
  example runs; mixes implementation code (some older versions)
  with example data.
- **photobookr** — the cleaned-up package version, intended
  canonical implementation. See `proj_photobookr.md`.

Once a few examples have been run through photobookr to validate
parity with Photo_Book, the cluster simplifies: photobookr as the
engine, Photo_Book reduced to example data, photoPress retired or
its remaining ideas merged.

## Next Steps
1. Run the Statue and Flower examples through photobookr (using
   `library(photobookr)` rather than the Photo_Book R scripts)
   and confirm parity of output.
2. Once parity is confirmed, simplify Photo_Book by removing the
   old R scripts and keeping only the example data (Keepers/,
   KML/, config.csv, metadata.csv) plus the finished Stories/
   PDFs as ground truth.
3. Reconcile or retire the sizing test files (markdown_test,
   minimal_test, test_size, test_14pt, test_20pt) — they served
   past investigations and may be safe to delete once their
   findings are captured.

## Collaborators / Dependencies
- photobookr (the package this sandbox demonstrates)

## Blockers
None.

---
## Log

### 2026-05-28
Project file created during PKM housekeeping continuation. The
Photo_Book folder was moved from Desktop to
G:\My Drive\Projects\Photo_Book on 2026-05-27 as part of the
broader Desktop consolidation; it had been a working area for
photo-book examples for some time. During the 2026-05-28 PKM
catch-up Kim named the book-assembly cluster explicitly: photoPress
(earlier attempt), Photo_Book (sandbox with code + data), and
photobookr (the package version). The cluster's near-term aim is
to run a few examples through photobookr, validate parity, then
simplify this Project to example data only.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Ready: the sandbox for the
photobookr parity run; clear next step, tied to the near-term
book-assembly focus. Part of the collection-wide back-fill; see
proj_PKM.md and session_log.md (2026-05-30).
