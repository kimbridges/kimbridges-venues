# PROJECT: photobookr
_Last updated: 2026-06-06_
_Status: Active_
_Focus readiness: Ready_
_Tags: redesign_

**Direction change (2026-06-06):** photobookr was **rebuilt to fit the new
collaborative narrative document structure** proven by the Kakaako_Birds book —
NOT the old "one self-contained block per bird" model it was written for.
**DONE + INSTALLED 2026-06-06** (see the second 2026-06-06 log entry): three
edits, verified, first full photo book built (98 pp). Near-term focus now: the
**clickable-chapter-bookmarks** enhancement.

## Type
R package (intended canonical book-assembly implementation)

## Objective
Create PDF books from a folder of photos (with EXIF data) plus a
text file with Markdown headers that link photos and text. The
package is the cleaned-up version of the working code that lives
in Photo_Book; it is intended as the canonical implementation
once example parity is confirmed.

## Current Status
R package skeleton in place at G:\My Drive\Projects\photobookr\
with DESCRIPTION, NAMESPACE, README.md, R/ (clean package source),
and documentation/ (demo / reference R scripts). The R/ source
includes setup.R, utils.R, markdown_to_chapters.R, build_map.R,
image_pages.R, build_book.R, and metadata.R. The documentation/
folder holds a parallel set of working scripts that overlap with
Photo_Book's R scripts at root — these are the demo / reference
versions kept alongside the package source.

The "multiple versions exist and need reconciliation" condition
flagged in 2026-04-14 is now scoped: the reconciliation is
between photobookr/R/ (package source), photobookr/documentation/
(demo scripts), and G:\My Drive\Projects\Photo_Book\ (the
sandbox). The book-assembly cluster note below names the path
forward.

## Locations
- Code: G:\My Drive\Projects\photobookr\R
- Demos: G:\My Drive\Projects\photobookr\documentation
- Sandbox: G:\My Drive\Projects\Photo_Book (separate Project; see
  proj_Photo_Book.md)
- Predecessor: G:\My Drive\Projects\photoPress (separate Project;
  see proj_photoPress.md)
- GitHub: not yet

## Key Files
- DESCRIPTION, NAMESPACE — R package skeleton
- README.md — package overview
- R/setup.R — package setup
- R/utils.R — shared helpers
- R/markdown_to_chapters.R — Markdown parsing
- R/build_map.R — map generation
- R/image_pages.R — image-page layout
- R/build_book.R — book assembly driver
- R/metadata.R — EXIF / metadata handling
- documentation/ — demo and reference scripts (overlap with
  Photo_Book's working code)

## Related Projects — Book Assembly Cluster

Three related Projects represent stages of an evolving effort to
automate the assembly of illustrated PDF books from photo folders
plus text:

- **photoPress** — earliest attempt; retained for ideas worth
  revisiting. See `proj_photoPress.md`.
- **Photo_Book** — working sandbox with multiple example runs
  (Statue, Flower, Garden); mixes implementation code (some older
  versions) with example data. See `proj_Photo_Book.md`.
- **photobookr** (this file) — the cleaned-up package version,
  intended canonical implementation.

Once a few examples have been run through photobookr to validate
parity with Photo_Book, the cluster simplifies: photobookr as the
engine, Photo_Book reduced to example data, photoPress retired
or its remaining ideas merged. Kim has flagged the book-assembly
work as a near-term focus area (2026-05-28).

## Next Steps
1. Run a few of Photo_Book's example chapters (Statue, Flower)
   through `library(photobookr)` and confirm parity of output
   with the existing finished PDFs.
2. Reconcile differences between photobookr/R/, photobookr/
   documentation/, and Photo_Book's root R scripts — keep the
   canonical version, retire the rest.
3. Review photoPress for any ideas worth carrying forward.
4. Begin user-facing documentation (README expansion, function-
   level help, a getting-started vignette).
5. Once stable, push to GitHub.

## Collaborators / Dependencies
None.

## Blockers
None active. The version-reconciliation work flagged in 2026-04-14
is now scoped via the cluster note above and proceeds against the
sandbox in Photo_Book.

---
## Log
### 2026-04-14
Project file cleaned up and standardized. Noted version
reconciliation as the critical first step.

### 2026-05-28
Project file updated during PKM housekeeping continuation. Two
sibling Projects in the book-assembly cluster were filed
(photoPress and Photo_Book) and Kim's framing of the cluster was
captured here in the new "Related Projects" section. The
version-reconciliation problem flagged in 2026-04-14 now has a
concrete path forward: run a few Photo_Book examples through
photobookr, confirm parity, then simplify. Folder structure
(R/, documentation/, alongside the sibling Photo_Book sandbox)
inspected and documented in Key Files. No code changes this
session — PKM-only.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Ready: clear next step (run
Photo_Book examples through library(photobookr) to confirm parity);
Kim flagged the book-assembly cluster as a near-term focus. Part of
the collection-wide back-fill; see proj_PKM.md and session_log.md
(2026-05-30).

### 2026-06-06 (first real-world exercise on Kakaako_Birds → REDESIGN mandate)
photobookr was driven for the first time against a real, full book — the
**Kakaako_Birds** manuscript (19 narrative chapters + preface, in
kimbridges-stories/underway/) — in Kim's live RStudio session via ClaudeR.
Findings:
- **All deps present and working** (exiftoolr+exiftool, magick, pdftools,
  rmarkdown, tinytex/xelatex, pandoc).
- **EXIF model confirmed:** images carry a Caption-Abstract (display caption)
  and an **Event** tag (chapter assignment); `build_book` matches Event ==
  story-PDF stem, case-insensitive (`eq_ci`). The Kakaako_Birds image set (59
  photos) is fully Event-tagged and covers all 19 chapters.
- **Structural incompatibility found.** `parse_book_markdown` treats **every
  `##` header as a separate chapter** (the old one-block-per-bird, field-guide-
  card model) and builds **lowercase-underscore slugs** (`cattle_egret`). The
  new book uses `#` for the chapter (bird) and `##` for thematic *subsections*,
  with space/title-case Event tags ("Cattle Egret"). So `markdown_to_chapters`
  + `build_book` cannot assemble the new structure as-is.

**DECISION (Kim): rebuild photobookr to fit the new structure.** The strategic
reason matters and should anchor the redesign: photobookr was built when Kim
expected to write every chapter **solo**, as self-contained one-block birds.
Collaborative writing (with Claude) has proved markedly better, and that is now
the standing method. So the tool is to be **restructured to fit the proven
collaborative narrative style**, not the reverse — the writing method leads, the
software follows. Concretely the rebuilt package should:
- treat a level-1 `#` heading as a **chapter** (one bird) and level-2 `##`
  headings as **subsections** within it (not as separate chapters);
- match **Event tags to the chapter `#` title** (case-insensitive; tolerate
  hyphen/space), placing each chapter's Event-matched images (with their
  Caption-Abstract captions, and `_2W` two-page-spread handling) within the
  chapter;
- keep the `Stories/<species>.md` files as the source of truth (our convention),
  and a stage-keyed manifest for order.
A **low-risk interim path** (if a full package rework is deferred): a thin
wrapper that renders each `Stories/<species>.md` to an Event-named PDF
(`NN_<Event>.pdf`, stem = Event) and then calls the existing `build_book`. Full
detail + options in `kimbridges-stories/underway/Kakaako_Birds/book_manifest.md`
("Build / assembly notes", 2026-06-06).

A text-only `Kakaako_Birds_draft.pdf` (23 pp, no photos) was produced this
session via pandoc+xelatex as an interim full-book draft. The
image-integrated build waits on this redesign + Kim's Event-tag normalization.
Status Active / Ready; the redesign is the next concrete task. See
session_log.md 2026-06-06.

### 2026-06-06 (rebuild done; first photo-integrated book built; enhancement queue from Kim's review)
The three redesign edits were made (load_all-tested, originals backed up in
`R/_backup_*`): (1) `parse_book_markdown` splits on level-1 `#` (chapters),
keeping `##` as subsections; (2) `render_section_pdf` renders via **xelatex**
(+ `mainfont: Cambria`) so Hawaiian diacriticals work; (3) `eq_ci` now matches
Event↔chapter **punctuation-insensitively** (so `cattle_egret` matches "Cattle
Egret"). With these, the full **Kakaako_Birds book built end-to-end** — 98-pp
PDF, cover + 20 chapters + 59 Event-matched photos + `_2W` spreads. Build notes
(local-temp + async pattern; the add-in blocks Claude-issued deletions) are in
the Kakaako_Birds `book_manifest.md`.

**Rebuild executed + installed (2026-06-06, second session).** The three edits
above were applied to `R/markdown_to_chapters.R` and `R/utils.R`, `devtools::install`ed,
and verified in a fresh process (`#`-split → 2 sections from a 2-`#` test;
`eq_ci("cattle_egret","Cattle Egret")` TRUE). First full photo book built:
`Kakaako_Birds_Book.pdf` (98 pp). A project-level one-call wrapper,
`build_kakaako_book.R` (in the Kakaako_Birds folder), re-assembles the manuscript
from `Stories/*.md` and runs `markdown_to_chapters` (17 pt) + `build_book`,
working on a LOCAL temp disk. **Future tidy-up:** promote that folder-assembly +
one-call build into photobookr proper (e.g., a `build_from_stories()` that takes
a Stories/ folder of per-chapter `.md` files). Build/process notes: render
locally (not the G: stream drive) and run long builds as background async — a
synchronous build on G: blocks the ClaudeR add-in; the add-in also blocks
Claude-issued file deletions (Finding 006). Image size handled by Kim's Acrobat
pass (840 MB → 9.2 MB).

**Enhancement queue (from Kim's 2026-06-06 book review):**
- **Chapter bookmarks (clickable PDF outline)** — IMPLEMENT NEXT. Preferred over
  a printed page-number index (better on phones, no page-number bookkeeping; the
  current render-then-merge design drops page numbers). Needs a PDF-outline
  back-end (ghostscript / pdftk / `xmpdf`); verify availability first.
- **Two-page-spread parity padding** — FUTURE. Auto-insert a blank page before a
  `_2W` spread so its halves land on a facing pair. Convention to fix: cover
  alone on the right, then 2–3, 4–5… pairs (spread starts on an even page). For
  now Kim handles parity manually by slipping in a filler photo.
- **Image resample + sharpen (size reduction)** — FUTURE. Embed photos at full
  resolution now → very large files (~840 MB for Kakaako_Birds). Add an option
  to resample each image to a max dimension (~2000 px / ~150–200 dpi at page
  size) with a light unsharp pass (Lanczos resize softens; re-sharpen restores
  crispness) and ~85% JPEG. Equivalent in effect to Kim's Acrobat "Reduce File
  Size" (which downsamples + recompresses), done upstream. For now Kim runs his
  proven Acrobat compression on the final PDF.
- **Font size:** handled via the existing `body_size` param (17 pt for the next
  build — no code change). Note the allowed set is 10/11/12/14/17/20; add 16 to
  the extended sizes only if Kim later wants it.
