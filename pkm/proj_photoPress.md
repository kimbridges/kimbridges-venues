# PROJECT: photoPress
_Last updated: 2026-05-30_
_Status: Active_
_Focus readiness: Exploring_

## Type
R package + Quarto driver template (git-tracked; older book-assembly attempt)

## Objective
An earlier attempt to automate the assembly of illustrated PDF
books from a folder of photos plus a markdown description.
Predecessor to Photo_Book and photobookr in the book-assembly
cluster. Retained because: (a) it is the only cluster member
under git tracking with a working remote, (b) its package
structure is closer to a publishable package than Photo_Book's
script-at-root layout, and (c) its Quarto driver chapters
(PhotoBook, Photos, Cover, Stories, Order) capture a template
pattern for using the package that has not yet been adopted in
photobookr.

## Current Status
R package skeleton at G:\My Drive\Projects\photoPress\ with
DESCRIPTION, NAMESPACE, LICENSE, LICENSE.md, .Rbuildignore,
.gitignore, package-level documentation (`R/photoPress-package.R`
+ `man/photoPress-package.Rd`), five source files in R/, and
their corresponding man pages. A working .git repository with a
configured remote sits alongside (origin/main present). Five
Quarto chapters sit at the package root acting as a driver
template — `PhotoBook.qmd` (master), plus `Cover.qmd`,
`Photos.qmd`, `Stories.qmd`, and `Order.qmd`.

The folder consolidates the former C:\RProjects\photoPress\
content; the prior G:\Projects\photoPress\ (older package
skeleton plus a working bird-stories example) was deleted on
2026-05-28 because the bird-stories content was already
preserved in `kimbridges-stories\underway\Photo_Book_workingnotes\`
and `kimbridges-stories\underway\Kakaako_Birds\`.

## Locations
- Code: G:\My Drive\Projects\photoPress\R
- Driver template: G:\My Drive\Projects\photoPress\ (the five
  .qmd files at the root)
- Local git: G:\My Drive\Projects\photoPress\.git
- GitHub: configured as origin remote (verify URL via
  `.git/config` when the package work resumes)

## Key Files
- DESCRIPTION, NAMESPACE — R package skeleton
- LICENSE, LICENSE.md — license files (present here but not in
  photobookr — a small artifact to migrate when the cluster
  consolidates)
- R/photoPress-package.R + man/photoPress-package.Rd —
  package-level documentation
- R/create-book.R + man/create_book.Rd — book assembly driver
- R/create-map.R + man/create_map.Rd — map generation
- R/utils-image-page.R — image-page helpers
- R/hello.R + man/hello.Rd — package boilerplate
- PhotoBook.qmd — master Quarto driver chapter
- Cover.qmd — cover chapter
- Photos.qmd — photos chapter
- Stories.qmd — stories chapter
- Order.qmd — ordering chapter
- photoPress.Rproj — RStudio project
- .gitignore, .Rbuildignore — exclusion rules

## Related Projects — Book Assembly Cluster

Three related Projects represent stages of an evolving effort
to automate the assembly of illustrated PDF books from photo
folders plus text:

- **photoPress** (this file) — earliest attempt; git-tracked
  R package + Quarto driver template. Retained for ideas
  worth revisiting and for the LICENSE files and chapter
  structure that the cluster will want.
- **Photo_Book** — working sandbox with multiple example runs
  (Statue, Flower, Garden); mixes implementation code (some
  older versions) with example data. See `proj_Photo_Book.md`.
- **photobookr** — the cleaned-up package version, intended
  canonical implementation. See `proj_photobookr.md`.

Once a few examples have been run through photobookr to
validate parity with Photo_Book, the cluster simplifies:
photobookr as the engine, Photo_Book reduced to example data,
photoPress reviewed for any remaining ideas to merge (the
Quarto driver template pattern, the LICENSE files, the
package-level documentation pattern) before being archived.

## Next Steps
1. Kim's review of the photoPress code and ideas worth carrying
   forward to photobookr (in progress 2026-05-28).
2. Inspect `R/photoPress-package.R` to capture the
   package-level documentation pattern; photobookr does not
   yet have an equivalent.
3. Inspect the five .qmd driver chapters (PhotoBook, Cover,
   Photos, Stories, Order) for the assembly pattern; this is
   a template for using a book-assembly package that
   photobookr could adopt.
4. Verify the GitHub remote URL recorded in `.git/config` is
   the correct destination if anything needs to be pushed.
5. Decide on archival placement once the cluster consolidates
   (likely Projects_Archive when the work is fully merged
   into photobookr).

## Collaborators / Dependencies
None.

## Blockers
None. Active review by Kim 2026-05-28.

---
## Log

### 2026-05-28 (initial PKM filing — bird-stories example)
Project file created during PKM housekeeping continuation. The
photoPress folder existed at G:\My Drive\Projects\photoPress\
before the 2026-05-27 consolidation but had no proj_*.md. Filed
on 2026-05-28 with the state observed at the time: R package
skeleton plus a working bird-story example (three finished
PDFs in `bird_stories/` plus supporting `bird_photos/` and
`bird_test.qmd`). Kim flagged that the bird-stories content
appeared duplicated against the underway story folders and
that photoPress itself was worth keeping for its ideas.

### 2026-05-28 (consolidation — RProjects copy replaces G: version)
Kim located a more developed photoPress at C:\RProjects\photoPress
(git-tracked, with package-level documentation, LICENSE files,
and five Quarto driver chapters: PhotoBook, Cover, Photos,
Stories, Order). Verified that the bird-stories content from
the prior G:\Projects\photoPress folder was already preserved
in kimbridges-stories\underway\Photo_Book_workingnotes\
(finished bird-story PDFs) and kimbridges-stories\underway\
Kakaako_Birds\ (the bird photos). Kim deleted the prior G:\
photoPress, moved the C:\RProjects\photoPress into
G:\My Drive\Projects\photoPress, and deleted the rest of
C:\RProjects (which held only a 2025 GitHub token text file
and a built tar.gz; nothing else of value). This file
substantially rewritten to reflect the new contents and the
cleaner package-plus-template structure that is now in place.
Re-classified: photoPress is the cluster's most git-disciplined
member and carries a Quarto driver template pattern worth
extracting.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Active, Focus readiness Exploring: under Kim's review
to decide which ideas (Quarto driver template, package-level docs,
LICENSE files) carry forward to photobookr before the cluster
consolidates. Part of the collection-wide back-fill; see proj_PKM.md
and session_log.md (2026-05-30).
