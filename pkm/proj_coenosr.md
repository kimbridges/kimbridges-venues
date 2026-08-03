# PROJECT: coenosr
_Last updated: 2026-07-26_
_Status: Active_
_Focus readiness: Ready_

## Type
R package (faithful historical-software reconstruction)

## Objective
A faithful reconstruction in R of the 1991 COENOS Braun-Blanquet
table-sorting method (see proj_Ceska.md). COENOS sorts a raw
species-by-relevé table into a structured two-way table of differential
species groups, forming groups by inside/outside frequency rules and
ordering them by reciprocal averaging. The original Pascal source is lost;
coenosr recovers the method legibly and **verifiably**, developed against
tables the original program produced. Intended as a distributable package
useful to others, not only as an internal test — and as the **validation
backbone** of the Braun-Blanquet cluster.

## Current Status
**Created and scaffolded 2026-06-11.** Proper R package at
`G:\My Drive\Projects\coenosr`, MIT licensed, building clean
(`devtools::check()` → 0 errors, 0 warnings, 1 benign "unable to verify
current time" note). First function shipped and validated:

- `read_rel()` — parse a COENOS `.REL` relevé file into a tidy long table
  (relevé / species / cover), implementing every documented parse rule
  (6-char relevé codes, 4+4 species key, first-non-blank cover, dup-last-wins,
  ignore no-cover lines, `&&` comments, both cover scales).
- `constancy()` — per-species occurrence counts.
- `print.coenos_rel()` — summary print method.
- `classify_species()` — the trim step: splits species into rare (`<3`),
  eligible, and ubiquitous (`>= floor(2n/3)`); reproduces the oracle role
  classes exactly (DIEREN + ELLEN, 0 mismatches).

**Validation is against the real program's output**, not assertions: the
testthat suite (22 expectations, all passing) checks `read_rel()` against the
decoded `.S00` ground-truth oracles. On DIEREN (18 relevés, 116 species, 356
occurrences) and ELLEN (25, 93, 784) every per-relevé species count and every
per-species constancy matches the oracle exactly, plus synthetic unit tests
for each parse rule. Done live in Kim's RStudio via the r-studio/ClaudeR
bridge (R 4.3.3).

## Locations
- Package: `G:\My Drive\Projects\coenosr` (code-heavy → under Projects\, per
  the storage architecture rule)
- Bundled data: `inst/extdata/` — `DIEREN.REL`, `ELLEN.REL`, and the three
  oracle CSVs (`dieren_s00_species.csv`, `ellen_s00_species.csv`,
  `set1_s00_species.csv`)
- Reconstruction reference docs live in `Projects\Ceska\reconstruction\`
  (spec + `.S00` decode); coenosr is the implementation of that spec.
- GitHub: **LIVE at https://github.com/kimbridges/coenosr** (pushed 2026-06-11).
  Initial commit `5d62b27` on branch `main`, 24 files, local==remote verified.
  Install: `remotes::install_github("kimbridges/coenosr")`. The push bypassed
  the `gh` package (incompatible with the installed `curl` — `gh` can't find
  `curl_modify_url`); used `gert` (libgit2) with the stored gitcreds PAT, after
  Kim created the empty repo on github.com by hand. Future pushes: RStudio Git
  pane (Commit / Push) or `gert::git_push()`.

## Key Files
- `R/read_rel.R` — `read_rel()`, `constancy()`, `print.coenos_rel()`
- `R/coenosr-package.R` — package-level docs
- `tests/testthat/test-read_rel.R` — oracle + parse-rule tests
- `DESCRIPTION`, `NAMESPACE`, `LICENSE` (MIT), `README.md`
- `inst/extdata/` — example data + validation oracles

## Roadmap (the reconstruction, in order)
1. **Done:** `read_rel()` + `constancy()`.
2. **Done:** `classify_species()` — the trim step (rare `<3` / eligible /
   ubiquitous `>= floor(2n/3)`); reproduces the oracle role classes exactly on
   DIEREN + ELLEN.
3. **`form_groups()`** — the inside/outside frequency engine (spec §4.2); the
   hard core. **Rule predicates PINNED 2026-06-11** and validated on all 9
   oracle groups (see `Ceska\reconstruction\form_groups_notes.md`): Rule II and
   Rule I-lower use `floor(X··/100)`; Rule I-upper is `<= ceil(Y*n/100)` with
   **n = total relevés** (not the outside count). True relevé groups recovered
   by a dash-marker table parser. **The search is still open:** one-group-per-
   species (best-first extraction with removal) explains the over-inclusion,
   but naive alternating refinement collapses to degenerate loose fixpoints, so
   COENOS's growth is incremental/tight, not a threshold sweep. **Incremental
   growth tested 2026-06-11 — mechanism ~90% reconstructed:** with a
   `max(1, floor(X*m/100))` relevé-set bootstrap, tight single-species growth
   reproduces the DIEREN 50/20 group up to one shared species (and its relevé
   set exactly); fidelity-based assignment is right for 44/49 species. The
   residue is the exact partition of shared/constant species across overlapping
   groups (the 5 misses are 66/33 constant species). **Per-group metadata
   decoded 2026-06-11** (`.S00` lines 811-830): each group's record is
   `[level, iterations, seed_id, n_species]` — recovering every group's seed
   species, X/Y level, and size, and confirming that a clean alternating
   refinement from those seeds reproduces the relevé groups EXACTLY and the
   species groups up to a few shared species. Remaining open (well-bounded last
   mile): the exact tight-growth rule (COENOS admits slightly fewer species than
   "all Rule-I-valid" — likely a similarity/density bound) and the extraction
   order. Static assignment metrics (fraction-of-R, concentration, phi fidelity)
   plateau at ~44-45/49 — the partition is procedural, not a static vote.
   **Cover/RA bulk decoded 2026-06-11** (`.S00` lines 831-1541): it is the
   stored **cover matrix** (`+`/`R` symbol counts match `DIEREN.REL` exactly),
   NOT the formation block-stats — so the exact tie-break criterion is **not in
   the preserved artifacts**, and behavioural inference floors at ~45/49 (the
   residue is ~4 genuinely between-community species; e.g. EQUIARVE vs ACHIMILL
   qualify for the same two groups but split opposite ways). **Conclusion: the
   COENOS group-formation _method_ is recovered** — trim -> seeded alternating
   refinement at three X/Y levels (relevé groups exact, converges in the decoded
   iteration counts) -> RA ordering. The only residual is the lost binary's
   tie-break for ambiguous species (an implementation detail, not a method
   component). NOT yet in the package (pending the RA ordering component + a
   ship decision). Full detail in
   `Ceska\reconstruction\form_groups_notes.md`.
4. **Reciprocal-averaging ordering** (spec §5). **Relevé ordering SOLVED
   2026-06-11** (see `Ceska\reconstruction\ordering_notes.md`): RA on the
   species-group × relevé-**type** asterisk table (a relevé's type = the set of
   groups whose R it's in) reproduces the `.S00` relevé vectors **exactly on
   both DIEREN and ELLEN** — order by (axis-1, axis-2 tie-break, then relevé
   number; empties last). The only non-determinism is the axis **sign**
   (reflection), inherent to CA; candidate convention: tightest-level extreme
   group leads. **Species ordering analysed 2026-06-11 — recovered at the method
   level:** grouped species in group order, **within each group by decreasing
   constancy** (verified monotone for all 4 DIEREN groups), then companions and
   footnote by decreasing constancy. The equal-constancy **micro tie-break** is
   a fine residual (not reproduced by id, mean relevé-rank, or in-block count) —
   same character as the group-membership residual, a hand-sort/internal detail
   not cleanly recoverable. Net: relevé ordering **exact** (up to reflection),
   species ordering **method-exact** with a bounded tie-break residual.
   Remaining (engineering): assemble `order_table()` / `coenos_table()` on top of
   `form_groups()` and wire into the package. Depends on the group structure.
5. **`coenos_table()`** — assemble and print the sorted two-way table (spec §6).
6. Decode the binary `.DAT` format to add SET1/2/3 as full `.REL`-level cases.
7. Vignette + GitHub release.

## Related Projects — Braun-Blanquet Cluster
- **Ceska** (proj_Ceska.md) — the 1991 COENOS artifacts + the decoded spec and
  `.S00` oracles; the ground truth coenosr reconstructs and validates against.
- **bbstruct / bbSynth / Braun_Blanquet** — the modern toolkit. coenosr is the
  *faithful* port (1991 behavior reproduced exactly); bbstruct is the modern
  redesign. Deliberately separate: coenosr can serve as bbstruct's validation
  backbone rather than being folded into it.

## Collaborators / Dependencies
- Base R only (no imports). Suggests: testthat.
- Depends on the Ceska reconstruction spec + oracles for its targets.

## Blockers
None. (The R bridge was down 2026-07-26 — RStudio addin not running — but the print edition did not need it.)

---
## Log

### 2026-07-26 — PRINT EDITION built for Adolf Ceska; the courtesy closes the loop
Kim's purpose, stated plainly: **send Adolf Ceska a copy**. Adolf has not been answering
email or checking Facebook, so the document had to travel as **paper**. That one
constraint set every decision. Kim chose, via AskUserQuestion: match the published
website rather than re-typeset it (be faithful to what he approved), **print and post**
rather than email, and **no cover note** (he writes that himself).

**Built entirely in the cloud sandbox from the live site.** The R bridge was down this
session (RStudio addin not running) and `G:\My Drive\Projects\coenosr` is not a connected
folder, so the Quarto/LaTeX route was unavailable. Fetching the twelve published pages
needed nothing from Kim's machine, which turned the outage into a non-event. Worth
remembering as a **pattern: a published Quarto site is itself a sufficient source for a
print edition.**

**Result: 47 pages, US Letter, `coenosr_print_edition.pdf` (1.38 MB).** Full-bleed cover,
title page + colophon, a **contents page with real page numbers**, then 44 numbered body
pages, Preface through References. Kim trial-printed it: "the pages work and the layout
preserves the intent."

**Three techniques worth keeping.** (1) *Real page numbers* came from a **two-pass
render**: print the body once with a hidden 1px white `@@MARKslug@@` token at each chapter
opening, read back with pypdf which printed page each token landed on, inject those
numbers into the contents page, render the front matter, merge. Rendering front and body
separately also solves *no page number on the front matter* — book convention, numbering
starts at 1 on the Preface. (2) *Paper cannot be clicked*, so external links keep their
words and gain the address in monospace alongside; internal anchors become plain text.
Only three external links exist in the whole document. (3) *Print fidelity of type*: the
site's `system-ui` resolves to DejaVu Sans in a Linux container, wide and clunky;
overriding to Liberation Sans (Arial metrics) puts the printed page much closer to what
Kim sees in Segoe UI.

**Three defects caught by LOOKING, not by exit codes** (Finding 016 again, and it keeps
earning its place). All 47 pages were rasterized and read as contact sheets. The cover
printed **inset** with white margins because it sat inside the front matter and inherited
its 20 mm margin — fixed by splitting it onto its own zero-margin page with a 2px
overscan and merging cover + front + body. Quarto's **code-fold** blocks printed
**collapsed**, silently hiding the code behind "Show the code" — fixed by forcing every
`<details>` open and hiding the summary; the body grew 40 → 44 pages, which is the measure
of how much would have been lost. Subtlest of the three: one long R line was **clipped at
the right edge** because Quarto sets `overflow: auto` on `div.sourceCode`, which scrolls
on screen and truncates on paper. Fixed with `pre-wrap` on the code spans, then
**verified mechanically** — a pixel scan of the right margin band across all 46 text
pages returned zero ink.

**Why this matters beyond the PDF** (Kim's framing, kept as a principle): the work
respects the people who made the contribution, and it delivers in a form **they** can
accept. Adolf and Hans Roemer's method was recovered; sending Adolf something he can
hold, needing no email, no browser and no account, is the courtesy that completes the
recovery. A deliverable is not delivered until it reaches the person in the form that
person can receive.

### 2026-06-12 (cont.) — group-formation ENGINE cracked via the literature; form_groups() + coenos_table() shipped
The standing blocker — the automatic group-formation search bloomed under every
seed-and-grow scheme — is **resolved by switching search strategies**, found in
the published record (Kim's lead: check Mueller-Dombois & Ellenberg).
**Bruelheide & Flintrop (1994)** *J. Veg. Sci.* 5:311-316 supplies a
deterministic **density-masking** search: start from the whole table, repeatedly
mask the lowest-density species/relevé until a dense block remains — it cannot
bloom (it only ever *removes*; the bloom came from Rule I rescanning the whole
eligible pool). The paper confirms COENOS = inside density threshold **+ outside
criterion** (our Rule I-high), which Bruelheide drops; M-D&E confirm the
"successive alternation of rules I and II" and — key for the framing — call
COENOS's own output "a **fairly close approximation** of the hand-derived
original." Approximation is intrinsic to the lineage.

**Shipped (local; NOT yet pushed — awaiting Kim's go-ahead):**
`R/form_groups.R` (`form_groups()` -> `coenos_groups`, masking + outside
criterion; print method) and `R/coenos_table.R` (`coenos_table()` -> sorted
two-way table via asterisk-RA ordering — CA by SVD in `.coenos_ca()`, species by
group + decreasing constancy, empties last; print method). 22 new tests
(`test-form_groups.R`, `test-coenos_table.R`). **testthat 83/83; check 0/0/1.**

**Display functions added (Kim's "big observation" on Ch6):** the detailed
table-wrangling in the chapter belonged in the package. Added `R/differential_table.R`
with `differential_table()` (base R -> display-ready data frame: grouped species,
their relevés, a group label; `include="core"`/`"full"`) and `coenos_gt()` (thin
wrapper -> formatted `gt` table; **gt added to Suggests**, shortens relevé headers).
`coenos_table()` now carries a `groups` attribute so the display can recover the
core. Ch6's heavy chunk is now two lines (`differential_table()` + `coenos_gt()`).
testthat **95/95**; check 0/0/1.

**Fidelity (quantified, honest):** strong/dense groups recover **exactly**
(DIEREN g4 4/4, SET1 g1 4/4); subtle differential groups approximately (DIEREN
g1 18/22; ELLEN Jaccard 0.12-0.43); one SET1 group missed — the recovery
degrades precisely where COENOS's lost tie-break/seed-order mattered. **Decision
(Kim, AskUserQuestion): "Ship the engine, document the seam."** Roadmap items
3-5 now **DONE at the method level** (search strategy resolved; the tie-break
residual is the documented seam, not a missing component). Next: Chapter 6
(full pipeline) + Chapter 7 (the seam); then Kim commits + pushes the two new
R files and tests.

### 2026-06-12 (input readers added: read_lists() + read_2way())
Exploring flexible data input for the documentation surfaced two new package
functions, now shipped. **`read_lists()`** reads the ragged "site, then its
species" form (field/dictation-natural; auto-detects Braun-Blanquet covers).
**`read_2way()`** reads the wide species-by-sites matrix (1/0 or covers;
`transpose` option). Both use a shared internal `new_coenos_rel()` constructor
so all three readers (with `read_rel()`) return identical `coenos_rel` objects.
Added roxygen docs + 21 tests (testthat 58/58; `devtools::check()` 0/0/1) and
bundled a 15-species x 10-site demonstration set in three shapes
(`simple_10x15_{simplified,input,cover}.txt`) in inst/extdata. Package docs
(NEWS, package help, DESCRIPTION) updated; **attribution corrected to Ceska &
Roemer**. Committed and **pushed to GitHub 2026-06-12** (`e5006a8c` live;
local==remote verified). Push note: `gh` is still broken (now a `check_string`
dependency error); use `gert::git_push("origin", repo=base)` with the **default
credential lookup** (NOT an explicit `password=`, which fails HTTPS auth). Also: regenerated the inconsistent wide example from the
canonical ragged file (the two hand-made versions had drifted — a built-in
argument for "one source, generate the views"). Confirmed the gt() names-table
trick (italic binomial + roman author in one cell via `fmt_markdown`). See
session_log.md 2026-06-12 and `Ceska\documentation\doc_notes.md`.

### 2026-06-11 (evening — Quarto story-document begun; Preface + 4 chapters drafted)
Began the multi-chapter Quarto story-document for coenosr (kimbridges-documents
style), authored in `Ceska\documentation\` (assets + `doc_notes.md` + `_quarto.yml`
there). Outline = Preface + 7 chapters; conceptual spine enriched by Kim (two-way
tables generalise beyond vegetation — sites × items, ethnobotany/cuisine; sparsity
& absence-as-data; **set aside the extremes** = the meaning of the trim; pattern =
shared distribution). Attribution corrected to **Ceska & Roemer**; history grounded
to Ceska & Roemer 1971 (Vegetatio 23:255–277) and Mueller-Dombois & Ellenberg 1974.
Drafted and approved by Kim: Preface, Ch1 The Two-Way Table, Ch2 COENOS 1991, Ch3
Reading a Dead Program, Ch4 The Method Recovered. Paused ~10 PM. **Next: Ch5
"coenosr in use" (live R).** One decision pending (in doc_notes "Drafting status &
resumption"): draft Ch5 around the shipped functions (read_rel/constancy/
classify_species) and describe table assembly, OR wire `form_groups()` +
`coenos_table()` into the package first. See session_log.md 2026-06-11 (evening).

### 2026-06-11 (SET1 tested; .DAT resolved; package validated on 3 datasets; GitHub-ready)
Tested the pipeline on SET1 (Kim's ask). Finding: **`SET1.DAT` is not binary** —
it is a relevé file in `.REL` format with CRLF line endings and the numeric
(1-7) cover scale, so `read_rel()` reads it directly (63 relevés, 43 species, 0
constancy mismatches vs the oracle) and `classify_species()` is exact (12 rare =
footnote, 3 ubiquitous = the dominant trees). Resolves spec open-question #7.
Bundled `SET1.DAT` in `inst/extdata` and added a `read_rel` test for it — the
reader is now validated on **all three** datasets (testthat 37/37, check 0/0/1).
Group-formation refinement on SET1, by contrast, drifts (g2's seed doesn't even
survive its own group) — SET1 is forest data dominated by 3 super-companions
with only 2 marginal 4-species groups, so the known growth-residual dominates
when differential structure is this weak. Documentation pass: added `NEWS.md`;
README updated (3 datasets), DESCRIPTION notes the classification step. Package
is clean and **GitHub-ready** (build 0/0/1, .gitignore/.Rbuildignore set,
DESCRIPTION URL points at kimbridges/coenosr). Push deferred to Kim: the R
bridge blocks shell git and gh/curl is broken in-session, and repo creation is
his account action — he'll push from RStudio as with whittakerr.

### 2026-06-11 (package created; read_rel shipped and validated)
Decision (Kim): build a proper, distributable R package — "a useful candidate
for other people and not just a test for us." Settled via AskUserQuestion:
name **coenosr** (his -r convention, honoring COENOS); **standalone**, the
validation backbone of the BB cluster (not folded into bbstruct); **MIT**
license. Scaffolded the full package at `G:\My Drive\Projects\coenosr` and
implemented `read_rel()` + `constancy()` + a print method. Developed and
validated live in Kim's RStudio (r-studio/ClaudeR bridge, R 4.3.3): the
testthat suite passes 22/22, with `read_rel()` reproducing the DIEREN and
ELLEN ground truth exactly (every relevé count and species constancy) and
synthetic tests covering each parse rule. `devtools::check()` clean (0/0/1,
the note benign). Example data + the three oracle CSVs bundled in
`inst/extdata`. Next: trim/classify, then the `form_groups()` engine. See
session_log.md 2026-06-11 and proj_Ceska.md.

### 2026-06-11 (classify_species shipped; form_groups scouted)
Added `classify_species()` (the trim step) — reproduces the oracle role
classes exactly on DIEREN and ELLEN (rare/eligible/ubiquitous, 0 mismatches),
using the decoded `floor(2n/3)` ceiling and `<3` floor. testthat now 30/30;
`devtools::check()` still 0/0/1. Began scouting `form_groups()` (spec §4.2):
established that **Rule II thresholds round down** (`count >= floor(X*m/100)`),
which reproduces the tight relevé groups exactly (e.g. DIEREN's 40/10 block of
6 relevés, where two relevés sit right on the 7.2 boundary with 7 species). But
the loose, large relevé groups show that `S` and `R` are a **joint fixpoint of
the iterative search**, not derivable one-shot from `S` — confirming this is
the genuine research core (spec open-question #1). Findings in
`Ceska\reconstruction\form_groups_notes.md`; next step is to extract the true
relevé groups from the printed-table dash markers, then reverse-engineer the
seed-and-grow loop. `form_groups()` intentionally NOT yet written into the
package — the validated rule predicates (with floor rounding) are its kernel.
