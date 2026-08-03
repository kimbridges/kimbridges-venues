# PROJECT: listsr

_Last updated: 2026-06-16_
_Status: Active_
_Focus readiness: Ready_

## Type
R package (the companion engine to the `lists` document; the dendrogram /
assessment-line path).

## Objective
Turn the ragged, everyday lists people already keep — sites and the items found
at each (market stalls × seafood, months × produce, plots × plants) — into
**reproducible groups**. `listsr` runs one short, legible workflow: read a
ragged list → look at it → lay it flat into a binary two-way table → measure it
(Jaccard) → draw the dendrogram (optionally coloured by external metadata) →
cut it into groups by a stated rule. Its distinctive contribution is the
**assessment-line method** (`recruit_heights()` + `assessment_cut()`): the *most
variable site sets the cut*, with an oddball variant — Kim's method from *Island
Ecosystems* (Mueller-Dombois), now in code. The recurring through-line:
groups are reproducible **constructs, not proofs**; the value is reproducibility
+ honesty + the ability to link metadata.

## Current Status
**Created 2026-06-16.** Proper R package at `G:\My Drive\Projects\listsr`, MIT
licensed. **15 exported functions** with roxygen docs + runnable examples; a
`print.assessment_cut` S3 method; **2 bundled datasets**. `devtools::document()`
generates a clean NAMESPACE + 18 help pages; **testthat 19/19 pass** (0 warnings),
verified live via the r-studio/ClaudeR bridge. **`devtools::install()` and
`devtools::check()` run by Kim 2026-06-16 — both OK.** **Pushed to GitHub:
https://github.com/kimbridges/listsr** (Kim, 2026-06-16). Install:
`remotes::install_github("kimbridges/listsr")`.

## Locations
- Package: `G:\My Drive\Projects\listsr` (code-heavy → under Projects\, per the
  storage architecture rule).
- Companion document: `G:\My Drive\Projects\lists` (the `lists` Quarto book; the
  package was extracted from its `lists_functions_clean.R`).
- GitHub: **LIVE at https://github.com/kimbridges/listsr** (Kim pushed + checked
  2026-06-16). Future pushes: RStudio Git pane, or `usethis`/`gert`.

## Key Files
- `R/read.R` — `read_lists()`, `to_long()`, `item_list()`, `data_to_2way()`
- `R/explore.R` — `item_freq_plot()`, `site_freq_plot()`, `two_way_plot()`
- `R/similarity.R` — `dissimilarity()` (Jaccard), `dissimilarity_plot()`
- `R/dendrogram.R` — `dendro_theme()`, `dendrogram_plot()`, `make_dendrogram()`,
  `dendrogram_meta_plot()` (leaves coloured by external metadata)
- `R/assessment.R` — `recruit_heights()`, `assessment_cut()`, `print.assessment_cut()`
- `R/data.R` — dataset docs; `R/listsr-package.R` — package doc + globalVariables
- `tests/testthat/` — test-read, test-similarity, test-assessment (19 tests)
- `DESCRIPTION`, `NAMESPACE`, `LICENSE` (MIT), `README.md`
- `data/` — `fish_market` (the toy), `madison_produce` (214-row produce list)
- `inst/extdata/madison_market.csv` — raw produce CSV

## Relationship to other projects
- **lists** (proj_lists.md) — the document `listsr` powers. The chapters
  currently `source("lists_functions_clean.R")`; **next step is to wire them to
  `library(listsr)`** now that the package is installed (the script and package
  are identical in behaviour).
- **coenosr** (proj_coenosr.md) — shared lineage. coenosr's `read_lists()` reads
  releve **files** and sorts a two-way table (the COENOS Braun-Blanquet path);
  listsr's `read_lists()` reads ragged **text** and takes the **dendrogram**
  path. Because the readers genuinely diverged (file vs text), listsr is
  **standalone** (its own text reader), with the lineage noted in the README —
  not a hard dependency on coenosr. (Decision 2026-06-16.)

## Roadmap
1. **Done:** scaffold, roxygen docs, bundled data, testthat (19/19), document,
   install, check, GitHub push.
2. **Next:** wire the `lists` document chapters to `library(listsr)` and point
   the function-reference appendix at the package (proj_lists task #29).
3. A vignette + `NEWS.md` — but **reframed (Kim, 2026-06-16):** a vignette should *point readers to the
   published `lists` document* that already walks the workflow, not duplicate it. (Open question worth
   revisiting: how package vignettes should route people to the companion documents in general.)
4. Optional: a pkgdown site; a generalised metadata-overlay for items as well as
   sites; reflect on whether the assessment-line method deserves a short methods
   write-up of its own.

## Collaborators / Dependencies
- Imports: dplyr, tidyr, tibble, forcats, ggplot2, ggdendro, rlang, tidyselect,
  stats, utils. Suggests: gt, testthat. Depends: R (>= 4.1) for the native pipe.

## Blockers
None.

---
## Log

### 2026-06-16 (created, tested, pushed)
Born from the `lists` document. Kim's call (AskUserQuestion): **package the
method** (the assessment-line cut + the list→tree pipeline) and **generalise the
cut into a clean function**. First generalised `assessment_cut(hc, oddball)` in
the document's script and verified it reproduces both Madison lines (4 groups;
5 with May set aside), then wired it into the assessment-lines chapter.
Discovered `coenosr::read_lists()` reads files while the lists reader takes
inline text — so built listsr **standalone** with its own text reader, lineage
noted (not a coenosr dependency). Scaffolded the full package (DESCRIPTION, MIT
LICENSE, package doc with a `globalVariables` net for the ported `aes()` bare
names, README), ported all functions into `R/` with roxygen, bundled
`fish_market` + `madison_produce` and the raw CSV, and added a testthat suite.
`document()` → clean NAMESPACE + 18 man pages; `load_all()` smoke test exercises
the full pipeline + `assessment_cut()` on both datasets; **testthat 19/19, 0
warnings**. Kim ran `devtools::install()` + `devtools::check()` (both OK) and
**pushed to github.com/kimbridges/listsr**. Name confirmed: `listsr` (the -r
convention, parallel to coenosr). See session_log.md 2026-06-16.
