# coenosr Quarto story-document — working notes

_Working notes for the coenosr documentation (kimbridges-documents style,
whittakerr-like). Started 2026-06-11. Captures the framing and conceptual spine
before drafting; the proposed chapter outline is at the end._

## Framing / title

- Cover line (Kim's asset): **"coenosr — Traditional 2-way table processing."**
- Working subtitle candidate: *Recovering traditional two-way table processing.*
- Dual purpose: (1) tell the lost-technology recovery story; (2) document the
  `coenosr` package. Story-led, documentation woven in.
- Assets in `Ceska\documentation\`: `coenosr_cover.png` (landing), `coenosr_icon.png`
  (book icon/favicon), `2way_table_image.png` (the SET1 sorted table figure),
  `coenosr_cover_draft.png`.

## Acknowledgments & references (Kim, 2026-06-11) — get the attribution right

- **The method is by Adolf Ceska AND Hans Roemer** (not Ceska alone). Correct
  this everywhere in the document; COENOS implements the **Ceska & Roemer**
  table-sorting method. (NB: the reconstruction notes / spec / proj_Ceska
  written earlier say "Adolf Ceska" — credit **Ceska & Roemer** going forward.)
- **Braun-Blanquet method, English translation / standard reference:**
  Mueller-Dombois, D. & Ellenberg, H. (1974). *Aims and Methods of Vegetation
  Ecology.* John Wiley & Sons. — the route by which Braun-Blanquet
  phytosociology reached the English-speaking world; cite as the foundational
  reference for the two-way-table method.
- **The Ceska & Roemer method (the source of COENOS), verified citation:**
  Ceska, A. & Roemer, H. (1971). *A computer program for identifying
  species-relevé groups in vegetation studies.* Vegetatio 23: 255–277
  (Springer; DOI 10.1007/BF02326664). Explicitly "based upon the principles of
  Braun-Blanquet tablework"; one of the earliest such programs. **Arc to use in
  the document:** the *method* is 1971 (mainframe/card era), COENOS is its 1991
  DOS realization by the same authors. (Later lineage, for context, not needed
  in text: Bruelheide 1994, "Arranging phytosociological tables by species-relevé
  groups," J. Veg. Sci.)
- **Resonance worth noting in the text:** the bundled `ELLEN.REL` example is
  **Ellenberg's own relevé data**, tying the worked example back to the 1974
  source. (Also: Mueller-Dombois recurs in Kim's work — cited in whittakerr.)
- These belong in the Preface (framing/credit), Ch.2 (history — Ceska & Roemer,
  the Braun-Blanquet lineage via Mueller-Dombois & Ellenberg), and a closing
  Acknowledgments / References section.

## Conceptual spine (Kim, 2026-06-11) — the philosophy of the method

These reframe the two-way table from a vegetation technique into a general way
of finding pattern in sparse co-occurrence data. They belong mainly in Ch.1
(concept) and recur in Ch.4 (the method) and Ch.5 (use).

1. **The structure generalises far beyond vegetation.** A two-way table is
   *sites × items*. Vegetation (relevé × species) is the instance we start from,
   but the same structure fits many fields. Kim's examples:
   - **Ethnobotany:** healer × herbal species — compare traditional treatments
     for a given ailment.
   - **Cuisine (Kim's musing):** regional variation compared with **menus as
     "sites"** and dishes/ingredients as the items.
   The relevé vocabulary is local; the method is not. Worth a recurring
   "beyond vegetation" thread, with ethnobotany as a concrete running second
   example.

2. **Sparsity is the defining property — and absence is data.** Unlike most
   datasets (densely packed, few missing values, and "missing" treated as a
   problem to impute or drop), a two-way table is **mostly empty**, and the
   empty cells are **as important as the filled ones**. The data are often
   simple **presence/absence**. The whole activity is **looking for pattern**.

3. **The strange-but-intuitive strategy: set aside the extremes.** This is the
   conceptual justification for the package's trim step (`classify_species()`):
   - Set aside the species so **common** they occur on almost every site —
     they can't distinguish anything.
   - Set aside the species so **rare** they occur on only a few sites at most —
     too little signal.
   - Analyse the **remaining middle** species — the ones most likely to show a
     pattern.
   Kim: this can look strange to someone used to using all the data, but it
   "corresponds to how many people look at finding patterns." **Key point for
   the document: the recovered trim is not preprocessing plumbing — it IS the
   method's point of view.** (Mechanically this is exactly rare `<3` /
   ubiquitous `>= floor(2n/3)` / eligible; conceptually it is "look where
   pattern can live.")

4. **A pattern is several species sharing a distribution.** The differential
   species group: the table reveals pattern because **a set of species show the
   same distribution across the sites**. Interpretation carries the meaning —
   in the ethnobotanical reading, practitioners whose herbal choices coincide
   for many components of a tonic may have **trained at the same schools**;
   shared training produces shared distributions. (Kim's example, illustrative.)

These four points give Ch.1 its universal reach and give the trim and the
differential groups their *meaning* rather than just their mechanics.

## Proposed chapter outline (with Kim's additions integrated)

**Preface.** The cover image; the recovery question (a 1991 program that ran but
whose source was gone — can a method be recovered from what it left behind?);
dual purpose; preservation note.

**1. The two-way table.** The conceptual ground, now *general*: sites × items,
the sparsity property (absence is data; presence/absence), pattern-finding as
the goal, the set-aside-the-extremes strategy, and "a pattern is shared
distribution." Vegetation as the home instance; ethnobotany (healers × herbs)
and the cuisine musing as the reach. Figure: `2way_table_image.png`. A newcomer
from any field should finish this chapter understanding what the table is for.

**2. COENOS, 1991.** History and loss. Adolf Ceska and numerical phytosociology;
what COENOS did; DOS / Turbo Pascal; the lost source. Kim's decades with
Braun-Blanquet tables (first-person).

**3. Reading a dead program.** The decode / detective chapter. Worked examples
as a Rosetta Stone; decoding `.REL` and `.S00`; the `.S00` files holding the
seeds, iteration counts, relevé groups — a message from the author across 35
years; the validation-oracle idea.

**4. The method, recovered.** The algorithm legibly: constancy and the trim
(now framed as the set-aside-extremes *philosophy*, §3 above), the inside/outside
rules with exact rounding, seeded group formation, reciprocal-averaging
ordering, assembling the table.

**5. coenosr in use.** Live, runnable R: install; `read_rel()`; `constancy()`;
`classify_species()` (and here, explicitly, the extremes-aside idea in action);
building toward the sorted table on DIEREN/ELLEN/SET1; examples chosen to teach
the datasets, not just the calls; tested against COENOS's own output.

**6. The limits of recovery.** The two tie-break residuals; the proof they're
absent from the `.S00`; honesty over papering-over.

**7. Why recover lost software.** Closing reflection (Kim's voice): preservation
as respect for the original authors; passing a way of seeing to a new
generation; the last-moment nature; where coenosr goes next.

## Drafting status & resumption (2026-06-11, ~10 PM — paused)

**Build folder:** `G:\My Drive\Projects\Ceska\documentation\`. `_quarto.yml` set
up (book; title "coenosr"; subtitle "Recovering traditional two-way table
processing"; author "K. W. Bridges and Claude (Anthropic)"; cover-image
`coenosr_cover.png`; navbar logo `coenosr_icon.png`; code-fold, silent execute,
toc, number-sections per the style guide).

**Drafted and approved by Kim (read very well; tone "just right"):**

- `index.qmd` — **Preface.** Recovery question; dual purpose; preservation note;
  Ceska & Roemer + Mueller-Dombois & Ellenberg credits; the ELLEN-is-Ellenberg's-
  own-data detail.
- `two_way_table.qmd` — **Ch 1, The Two-Way Table.** The conceptual spine:
  sites × items (vegetation home; ethnobotany + cuisine reach), sparsity /
  absence-as-data, pattern-finding, set-aside-the-extremes, pattern = shared
  distribution. Figure: `2way_table_image.png`.
- `coenos_1991.qmd` — **Ch 2, COENOS, 1991.** Hand-sorting (Braun-Blanquet;
  M-D & E 1974) → Ceska & Roemer 1971 method (Vegetatio 23:255–277) → COENOS
  1991 DOS realization → the loss (run-but-not-read). NB: hand-sorting section
  left impersonal as a home for Kim's first-person material (not yet added).
- `reading_a_dead_program.qmd` — **Ch 3, Reading a Dead Program.** The recovery /
  detective chapter (Kim: "very emotional ... tone just right"): what survived;
  worked examples as a Rosetta Stone; the `.S00` files as the program's own
  notes ("a message across the years"); checking against the original.
- `the_method.qmd` — **Ch 4, The Method, Recovered.** The rules in the open,
  kept readable via the 18-relevé Dieren anchor (Kim approved the "too rare"
  common-then-sharpened approach): constancy; the trim as a rule (<3 rare,
  ≥⌊2n/3⌋=12 ubiquitous, middle = differential); the inside/outside group rule
  at 40/10 50/20 66/33; reciprocal averaging (back-and-forth averaging
  intuition); the assembled table. Exact rounding formulas deliberately held
  back (candidate Appendix material).

**NEXT — Ch 5, "coenosr in use"** (the first live-R chapter). Resumption notes:
- This is the code chapter; Kim wants it "very clear." Follow style guide §3–5:
  setup chunk (load coenosr via `## install_github("kimbridges/coenosr")` comment
  + `library()`), code-fold, `gt()` tables, comments INSIDE chunks (they travel
  when copied), sequential named steps over nested calls, label every chunk,
  label every output, read-and-display-immediately discipline.
- Arc: install → `read_rel()` on a bundled dataset → `constancy()` →
  `classify_species()` (here, the set-aside-extremes idea *in action*, paying
  off Ch 1 and Ch 4) → toward the sorted table. Examples chosen to teach the
  datasets, not just the calls. End on the validated-against-COENOS point.
- Note: `form_groups()` / `coenos_table()` are not yet IN the package (the
  group engine + table assembler are validated logic not yet wired as exported
  functions). So Ch 5 can show read_rel + constancy + classify_species live;
  the full sorted-table assembly is shown conceptually / as the package's
  near-term direction, OR we wire the remaining functions first. **Decision for
  next session:** either (a) draft Ch 5 around the shipped functions + describe
  the table assembly, or (b) finish wiring form_groups/coenos_table into the
  package first, then draft Ch 5 fully live. Kim to weigh in.

**Remaining chapters after Ch 5:** Ch 6, The Limits of Recovery (the honest
account of the two tie-break residuals); Ch 7, Why Recover Lost Software
(closing reflection, Kim's voice); plus an Appendix (references — Ceska & Roemer
1971, Mueller-Dombois & Ellenberg 1974; optionally the exact rounding rules).

_Style: follow `Projects_Index\style_multichapter_doc.md`._

## Output-formatting convention (2026-06-12) — df-print + protect package prints

Kim's note: chunk outputs ending in raw "R-style" console dumps read as
unpolished and copy poorly. Decision: format the *generic* outputs, preserve the
*package's own* print methods.

- **`df-print: kable`** set globally in `_quarto.yml` (format: html). Every plain
  data-frame / tibble output now renders as a labelled kable table, no per-chunk
  code. Add **`#| tbl-cap: "..."`** to the headline results for a numbered caption.
- **Protect package print methods.** `coenos_rel` and `coenos_table` *inherit*
  data.frame, so df-print would hijack them and dump raw rows. Wrap those in
  **`print()`** (e.g. `print(tab)`, `print(head(rel))`) to keep their designed
  summaries. `coenos_groups` does NOT inherit data.frame, so it auto-prints its
  own method safely — leave it bare.
- **Rule for future chapters:** any `coenos_rel`/`coenos_table` shown at a chunk
  end must be wrapped in `print()`; plain data frames are left bare (df-print
  formats them) and get a `tbl-cap` if they're a result worth labelling.
- Applied as the pattern in Ch 6 (constancy/classify/differential-core captioned;
  `print(tab)`) and Ch 5 (`print(head(rel))`). Ch 1-4 have no live R of this kind.
  Kim rendered Ch 6 (2026-06-12): "very clean now ... that is what we need."

## Toy dataset redesigned for a clean result (2026-06-12)

Kim asked whether the simple_10x15 toy actually sorts into groups (so a first-time
tester gets an interesting answer). The OLD hand-made data formed only one weak
5-species group. **Redesigned** to two clear five-species communities + 3
ubiquitous staples (L, C, P) + 2 rare items (U, Y); `form_groups()` default
(50/20) returns **2 groups of 5** that sort into a crisp diagonal. Kim chose the
crisp version (over adding realistic noise).

Key design choice: the two communities are **interleaved across alternating
sites** (community A in odd sites 1,3,5,7; B in even 2,4,6,8). So the *raw* table
looks like a scattered checkerboard (preserving Ch 5's "unsorted scatter" point),
but `coenos_table()` regroups the columns into the clean diagonal. Market story
intact: two kinds of market, each with its signature produce, plus the staples
everyone sells.

Regenerated all three formats from one source, in BOTH `documentation/data/` and
the package `inst/extdata/` (so the bundled demo matches): `simple_10x15_simplified.txt`
(presence ragged, the canonical source), `_input.txt` (wide 1/0), `_cover.txt`
(ragged + Braun-Blanquet covers, set.seed(42) weighted by role). 69 occurrences.
Updated Ch 5's two literal snippets (first 3 ragged lines; the site-1 cover line).
Package: added a test that the bundled toy yields 2 five-species groups; fixed the
input-reader test count (75 -> 69). testthat 97/97; check 0/0/1.

**Uncommitted in the package** (await Kim's go-ahead): the 3 `inst/extdata/simple_10x15_*`
files, `tests/testthat/test-form_groups.R`, `tests/testthat/test-input-readers.R`.
[RESOLVED 2026-06-12: committed + pushed as `478a1a4` (functions) and `c9fc6df`
(toy data). Package fully up to date.]

## Chapter 7 reframed + drafted (2026-06-12) — "A Clear Point of View"

Kim's reframe (and new title, his pick): lead NOT with "limits" but with
**purpose** — coenosr finds patterns from a distinct, clear point of view;
patterns can be clear / messy / non-existent / in between; the grouping is **not a
statistical black box** but **simple rules you can do by hand** (as M-D&E's book
shows). The lost tie-break then lands as a small, honest footnote, not a failure.
Kim on the opening: "It works, very powerfully." File `a_clear_point_of_view.qmd`,
added to `_quarto.yml` after coenosr_in_use. Sections: opening (purpose/beauty) ->
"Held against the program" (live fidelity check vs the DIEREN `.S00` oracle: a gt
table — 18/22, 11/18, small group whole) -> "What did not survive" (the ambiguous-
species tie-break + equal-constancy micro-order; proven absent from the artifacts)
-> "The honesty of an open method" (two visible layers of approximation: hand ->
COENOS "fairly close approximation" -> coenosr; ends "The program died; the idea
did not."). All chunks verified to run. **Ends on a strong positive note.**

## Chapter 8 + references drafted (2026-06-12) — book structurally complete

**Ch 8 "A Place in the Toolkit"** (`a_place_in_the_toolkit.qmd`, Kim's title). Kim's
idea: a data analyst builds a personal toolkit that evolves with technology and
theory, but a few **reliable old standbys** earn a permanent place and are often
overlooked. coenosr is one. Sections: the toolkit/old-standby opening; **"A tool found, and lost" — Kim's
first-person story, now woven in (2026-06-12)**: trained in statistics, two-way
table didn't fit his models until similarity/dendrograms (first tool); by chance
shared a lab with **Dieter Mueller-Dombois** (the M-D of the cited book!) testing
community-distribution hypotheses; Dieter handed him COENOS to run (punched cards
— phrased "years before the DOS version these pages followed" to reconcile with
Ch2's COENOS=1991-DOS; FLAG for Kim); turned to other interests; two-way tables
returned but COENOS was lost; "could explain but not show. Now I can." The
Mueller-Dombois connection ties the personal story to the document's lineage.
Then "The newest tools, the oldest method" — Kim's explicit ask:
**celebrate the joint human-AI recovery AND the co-authorship** ("This is a joint
project, all the way" + "authorship, too!!!"). Names Claude as second author, the
real division of labor, AI-for-science as a hopeful use. Closes: "The program
died. The idea did not. Now it has a place again." No code chunks (reflective).

**References appendix** (`references.qmd`, under `appendices:` in _quarto.yml):
Braun-Blanquet 1932 (verified via web), Ceska & Roemer 1971, Mueller-Dombois &
Ellenberg 1974, Bruelheide & Flintrop 1994, R Core Team, and the coenosr package
(Bridges & Claude 2026).

**Book is now structurally complete:** Preface + 8 chapters + references. Outline
fully realized. REMAINING: (1) Kim adds his personal material to the Ch 8 slot;
(2) Kim renders the full book and reads Ch 6/7/8 in place; (3) optional polish from
the "few coding details" Kim mentioned wanting to revisit; (4) deploy to
kimbridges-documents.netlify.app (manual Netlify workflow).

## Data-input strategies & a new input chapter (2026-06-12)

Kim redirected Ch 5 toward **data input**. The COENOS `.REL` reader is for
legacy files almost no one has; real users need a way to bring their own
*site × item* data in (the Ch 1 generalisation: vegetation, ethnobotany,
cuisine). Explored and settled, with working prototypes in Kim's R session.

**Three input doors, one internal form (`coenos_rel`):**

- `read_rel()` — legacy COENOS `.REL` (already shipped).
- `read_2way()` — the **wide matrix** form (species rows × site columns; cells
  = cover, or 1/0). Name chosen by Kim (avoids the `read.table()` collision and
  names the structure). Default orientation species-rows; transpose option.
- `read_lists()` — the **ragged "site, then its species"** form, the
  field/dictation-natural input and a close cousin of `.REL`. **Auto-detects
  cover values** (Kim wants the auto behaviour): within each comma-separated
  entry, a trailing token that matches a cover symbol (Braun-Blanquet `+ R` or a
  digit) is the cover; otherwise the entry is a species marked present.

**Post-input confirm = explicit `pivot_wider()` + `gt()`** (style-guide
read-then-display discipline). Kim's call: keep the pivot **explicit** in the
chapter (do NOT ship a pivot helper) — it's "a nice surprise" for traditional
readers and for the rectangular-data crowd. The confirm view doubles as the
*unsorted* two-way table (the scatter, before coenosr sorts it).

**The gt() names-table trick (embed as a hint).** To show a species **code +
italic binomial + roman author** in one cell: build the cell as markdown
`paste0("*", binomial, "* ", author)`, then `gt() |> fmt_markdown(columns = ...)`.
Verified: renders `<em>binomial</em> author` — binomial italic, author roman, same
cell. Demonstrated with confident Linnaean names (Dactylis glomerata L., etc.).

**Example files (canonical = the ragged form), in `Ceska\documentation\data\`:**
- `simple_10x15_simplified.txt` — **canonical** ragged P/A (15 species × 10 sites).
- `simple_10x15_input.txt` — wide 1/0, **regenerated from canonical** (the two
  hand-made versions had drifted 3 cells — M/V at site 5 vs 7, U at site 10 — a
  perfect in-document argument for "one source, generate the views"). Now exact.
- `simple_10x15_cover.txt` — **fourth example**, ragged WITH Braun-Blanquet
  covers (e.g. `1, G 4, L 4, M +, ...`), reads through `read_lists()` intact.
- `simple_10x15_table.txt` — Kim's ASCII X-table (figure candidate); to be
  regenerated from canonical for consistency, or superseded by the gt() view.
- Trim on this data (n=10 -> ubiquitous >= floor(2n/3) = 6, rare < 3): ubiquitous
  **L (10), C (8), P (9)**; eligible **G M R A F S K V B H** (the two communities, all
  constancy 4); rare **U (1), Y (1)**. Small enough to read every species' fate.
  [Corrected 2026-06-15 — the earlier line ("ubiquitous L C P A H; eligible F S K G M R V;
  rare U Y B") predated the 2026-06-12 data redesign and was wrong against the current
  simple_10x15; verified against the data file and used to build the constancy-strip figure.]

**Chapter slotting (proposed):** the input material is strong enough to be its
own chapter — make **Ch 5 = "Getting your data in"** (the three readers + gt
confirm + the names-table trick + the abbreviation/binomial example), and push
the analysis (constancy, classify_species, grouping, the sorted table) to **Ch 6
"coenosr in use."** Renumber Limits -> Ch 7, Why Recover -> Ch 8. (Confirm with
Kim.)

**DONE (2026-06-12):** `read_lists()` + `read_2way()` wired into the package —
exported, roxygen-documented, shared `new_coenos_rel()` constructor, 21 new
tests (58/58 total, check 0/0/1), the three `simple_10x15` files bundled in
inst/extdata. Package docs updated; attribution corrected to Ceska & Roemer.
Committed and **pushed to GitHub 2026-06-12** (`e5006a8c`; local==remote
verified).

**Binomial example = PRODUCE (Kim's choice, 2026-06-12).** 15 produce items
(matching the 15-species example) as the "species", with verified binomials +
authorities (GBIF / World Flora Online). Saved `data/produce_names.csv`. This
reframes the whole simple_10x15 example as **market data** (10 markets x 15
produce; presence = "this market sells it") — a third generalisation alongside
ethnobotany and cuisine. The gt() italic/roman trick confirmed on all 15,
including the hard citations: *Malus domestica* (Suckow) Borkh.; *Citrus limon*
(L.) Osbeck; *Citrullus lanatus* (Thunb.) Matsum. & Nakai. Teaching aside:
broccoli/cabbage/cauliflower all = *Brassica oleracea* L. (distinct market
items, one biological species) — operational vs biological "species".

Verified produce names: apple *Malus domestica* (Suckow) Borkh. · broccoli /
cabbage / cauliflower *Brassica oleracea* L. · chard *Beta vulgaris* L. · lemon
*Citrus limon* (L.) Osbeck · lettuce *Lactuca sativa* L. · lime *Citrus
aurantiifolia* (Christm.) Swingle · orange *Citrus sinensis* (L.) Osbeck · peach
*Prunus persica* (L.) Batsch · pear *Pyrus communis* L. · potato *Solanum
tuberosum* L. · pumpkin *Cucurbita pepo* L. · tomato *Solanum lycopersicum* L. ·
watermelon *Citrullus lanatus* (Thunb.) Matsum. & Nakai.

**Settled (2026-06-12):** produce is used ONLY for the abbreviation + full-name
illustration, NOT to relabel the running data (the single-letter codes stay —
they're short so the table fits the page). Shortened to a **7-row** representative
set in `data/produce_names.csv` (cols: common, genus, species, variety, author,
naive_code, code): apple, broccoli, cabbage, cauliflower, lemon, potato,
watermelon. It demonstrates two things at once — (1) the gt() italic/roman trick
across a range of authorities (L.; (Suckow) Borkh.; (L.) Osbeck; (Thunb.) Matsum.
& Nakai); (2) **choosing abbreviations**: four-genus + four-species gives unique
codes for most (MALUDOME, CITRLIMO, SOLATUBE, CITRLANA) but **collides on the
three Brassica oleracea** (all -> BRASOLER); the fix is genus4 + variety4
(BRASITAL, BRASCAPI, BRASBOTR). All verified in R.

**NEXT:** draft Ch 5 "Getting your data in" — all pieces ready: the three readers
on the simple_10x15 data; the explicit pivot_wider + gt() confirm view; the
abbreviation/full-name craft (produce, the gt trick + the 4+4 collision fix).
Proposed renumbering: Ch 5 = data input, Ch 6 = coenosr in use (analysis),
Ch 7 = Limits, Ch 8 = Why Recover (confirm with Kim).

## Infographic program (2026-06-14) — weave figures into the chapters

Kim's proposal: add **infographics into the document**, shown in the context of the
story rather than as a standalone poster — several of them, each serving a different
purpose, breaking up text and supporting multiple learning modalities. This reflects a
strong, identity-level preference of Kim's for illustrating documents, especially the
technical ones (now recorded as `kim_association_index.md` Master Theme 12; conventions
in `style_multichapter_doc.md` §6).

**Design constraints Kim set:** one consistent visual language across the set; sparing
text; color used but **readable and colorblind-inclusive** (no red/green or pink/blue).

**Anchor figure DONE — `figures/coenos_sort.svg`** (the scatter-to-diagonal sort). Built
from the real `simple_10x15` market data (10 markets × 15 produce, 69 records). Left
panel "as recorded" (alphabetical rows → scattered checkerboard); arrow labeled
`coenos_table()`; right panel "after sorting" (two clean differential-group blocks, with
Group 1 / Group 2 brackets). **Visual language established here** (inherit for the rest):
- Okabe-Ito **blue `#0072B2`** = Group 1, **orange `#E69F00`** = Group 2 (CVD-safe,
  grayscale-separable); **gray `#7d7d78`** = ubiquitous "sold everywhere"; **open ring** =
  rare (shape as a second channel, not color alone).
- Faint grid so **absence stays visible** (the Ch 1 "absence is data" point).
- Sparing text: panel labels, function-name on the arrow, 4-item legend, single-letter
  row codes (so a row can be traced across the sort).
- SVG generated by a Python script from the real data; save via the file tool (bash→G:
  doesn't surface, Finding 005).

Kim's verdict: "exactly the sort of diagram that's needed ... really clear ... color
choice works well and it isn't culturally biased ... just the right amount of text."

**Candidate figures still to build (one job each), same visual language:**
1. **Sparsity / "absence is data"** (Ch 1) — a mostly-empty sites × items grid.
2. **Set-aside-the-extremes** (Ch 1 or 4) — a constancy strip: rare tail + ubiquitous
   head greyed out, eligible middle lit.
3. **Recovery timeline** (Ch 2/3) — 1971 method → 1991 DOS COENOS → source lost → 2026 R.
4. **The `.S00` message across the years** (Ch 3) — stored seeds + iteration counts
   annotated as the authors' own notes.
5. **Honesty layers** (Ch 7) — hand-sort → COENOS "fairly close approximation" → coenosr.

**NEXT (infographics):** after Kim's read of the anchor, build the constancy strip
(set-aside-the-extremes) and the recovery timeline next, in the same language. Then place
the figures into the relevant chapter `.qmd` files via `images/`/`figures/` relative paths.

## Infographic set COMPLETE in draft (2026-06-15) — six figures, one visual language

All six planned figures are built and saved as SVG in `documentation/figures/` (verified on
Drive). Generated from the real data where data applies; saved via the file tool (bash→G: does
not propagate — Finding 001/005; learned again this session when the prior bash-written
`coenos_trim.svg` was absent on resume and had to be re-saved with Write).

| File | Chapter | Job | Notes |
|------|---------|-----|-------|
| `coenos_sort.svg` | 6 (anchor) | scatter → diagonal sort | real simple_10x15; blue/orange groups, gray ubiquitous, ring rare |
| `coenos_trim.svg` | 1 or 4 | set-aside-the-extremes | constancy axis; eligible middle green; correct trim (L/C/P ubiq, U/Y rare, 10 eligible @ c=4) |
| `coenos_timeline.svg` | 2/3 | recovery 1971→1991→lost→2026 | to-scale (lost stretch dominates); green recovery node; refrain line REMOVED (saved for the ending) |
| `coenos_sparsity.svg` | 1 | "absence is data" | illustrative sparse grid, **portrait** (items=rows, sites=cols, ~81% empty); axis titles on left+bottom; one empty-cell callout |
| `coenos_s00_message.svg` | 3 | the authors' notes in the file | REAL DIEREN group-2 record, decoded **value-by-value** (level 66/33 · 1 pass · seed sp.7 · size 5) + member list with seed=first member in green |

**Revised 2026-06-15 (Kim's review):** sparsity figure was re-oriented to **portrait with items
on the left axis and sites on the bottom** (it had been landscape with floating top/bottom labels —
read as rotated 90° vs the other figures). The `.S00` figure was rebuilt as a **value-by-value
decoder** (each integer → its meaning) after the whole-row labels read as backwards (the shared
numbers 5 and 7 were ambiguous); the seed (7) is now green in both the recipe and as the first
member, and the 5 members are boxed.

## Closing-chapter sketch (2026-06-15) — "What's Next": the groups as the unit that re-attaches knowledge

_Sketch only — shape to react to (per Kim), not drafted prose. Built from Kim's `What_is_Next.txt`
intake + the 2026-06-15 grouping discussion. Kim: "this section will require care."_

**Spine (one sentence).** The two-way table strips your knowledge down to names and presences in
order to find structure; the groups are where the knowledge comes back — a group is a new unit of
analysis, a join key for everything you set aside. Every product you then build on the groups (a
map, an index, a diversity number) inherits their constructed-ness: it is an argument, not a fact.
This is the recurring theme in its strongest form, now governing a whole family of derived products
at once.

**Title candidates (Kim picks):** "What the Groups Are For" (rec.) · "Putting the Groups to Work" ·
"From Groups to Knowledge" · Kim's "What's Next".

**Placement (Kim's call):** proposed as a new chapter AFTER Ch 7 "A Clear Point of View" (it extends
that chapter's argument-not-fact theme outward onto the products) and BEFORE the personal close
"A Place in the Toolkit" → new chapter = Ch 8, personal close → Ch 9. Manage overlap with Ch 7: let
Ch 7 *establish* "the grouping is an argument"; this chapter *applies* it to maps and indices, it
does not re-argue it.

**Section spine:**

1. **Opening — subtract, then re-attach.** The table was deliberately impoverished (names +
   presence) so structure could show. The groups give the knowledge back. A group is a unit that did
   not exist in the raw data; it is the join key for ancillary information.

2. **Ancillary information — putting back what you set aside.** You know more than the table holds:
   species carry life form (etc.); sites carry location, elevation, substrate. Groups let you join
   that knowledge to a group and summarize over it.
   - Worked example (headline): **the map.** Site groups carry coordinates → they map as regions;
     species groups name/diagnose those regions. Tessellation interpolates between sparse relevés,
     the step historically infeasible by hand (air photos the rare workaround). Latency: the map was
     always implied; it waited on computation, not insight. Ties to Kim's own `sitemaps`
     (`bb2google.R`), `Koch_voronoi`, and `whittakerr` ("Beyond a Map"). Candidate figure: a small
     multi-group tessellated map.

3. **Row and column manipulations — summaries that respect the groups.**
   - Rows: sums = **constancy** (already used to build the groups). Basis for indices; in
     ethnobotany, constancy ≈ relative frequency of citation, and **fidelity** is the bridge word
     (a species faithful to an association ↔ faithful to a use category).
   - The sharpening idea (Kim's): compute an index on the **essential species only** (the
     discriminating middle), because the trim is the method's own *reusable* verdict on signal vs
     noise. Test for any index: **does it want to discriminate, or to total?** Discriminating /
     fidelity-type → essential species; magnitude / "usefulness where ubiquity counts" → all species.
   - Columns: sums = species number = **richness**; richness ≠ **diversity** (name the common
     confusion). With abundances, per-site diversity; **essential-species diversity** is a
     *different, honestly-named* statistic ("how varied is the diagnostic signal," not "how diverse
     is the site"). Needs the cover/quantity case.

4. **Close — every product inherits the argument.** The groups are drawn, not found, so the map is an
   argument, and so is the index, and so is the essential-species diversity, because "essential" is
   defined by the classification, which is defined by the data. Consequence stated honestly: you can
   reason *within* the argument transparently, but you cannot use these group-derived statistics to
   *validate* the groups (circularity). End pointing outward: the recovered method is not an endpoint
   but the grouping link that makes a pipeline — raw relevés → reproducible groups → maps and indices
   — every step carrying the same inspectable point of view.

**Care points (Kim flagged "requires care"):** (a) keep the site-group vs species-group roles precise
in the map section; (b) state richness ≠ diversity correctly; (c) verify the ethnobotany
index/fidelity claims before drafting (don't overclaim names); (d) state the circularity caveat
precisely — group-derived products reason *within* the argument, they do not test it.

**Open for Kim:** title; placement/renumbering; whether to add the tessellated-map figure and/or an
essential-species-index worked example; depth of the richness/diversity material.

**DECISIONS (2026-06-15, Kim):**
- **Title locked: "The Reason for Groups."** **Placement locked:** new chapter right after Ch 7
  "A Clear Point of View," before the personal close (renumber: this = Ch 8; "A Place in the Toolkit"
  = Ch 9).
- **Section-2 worked example → an ancillary-information TABLE** (site × {site-group + ancillary
  attributes}), on the running examples: produce farms (location, region, size, organic?) or herbal
  practitioners (location, training school, years). Show the group as the join key, then summarize an
  ancillary attribute by group. The map becomes an optional addition/extension, not the primary
  example.
- **Section-4 title** (was placeholder "The close"): proposed **"Reasoning Within the Argument"**
  (uses the phrase Kim flagged); alternates "An Argument You Can Inspect," "Reproducible, Not Proven."
  Kim to pick.
- **Keystone (Kim):** reproducibility is the point. The payoff is that a method which *began as
  people's intuition about grouping* is now reproducible and inspectable — the move from intuition to
  objective, reproducible method (the whittakerr-era "subjective → objective" arc; Theme 3,
  objectivity as an ethical stance). Quote Kim wants foregrounded: "You cannot use these downstream
  statistics to validate the groups, because they are conditioned on the groups, but you can use them
  to reason within the argument, transparently, so the next person can inspect it."
- **Refinement to weave in (internal vs external data).** Statistics *derived from* the groups
  (constancy-indices, essential-species diversity) are conditioned on the grouping → they cannot
  validate it (circular). But **independent external ancillary data** (substrate, elevation, a
  practitioner's training school) was NOT used to build the table, so when site-groups align with it
  that IS genuine external corroboration. This unifies §2 and §4: §2's ancillary join is the
  legitimate external check; §4's caution is specifically about group-derived (internal) products.
  The full scientific loop: groups are a reproducible argument, inspectable internally and testable
  against independent data. (The ancillary TABLE worked example is the natural place to show this —
  e.g., site-groups lining up with region/substrate or with training school.)

**DRAFTED 2026-06-15 — `the_reason_for_groups.qmd`** (wired into `_quarto.yml` after
`a_clear_point_of_view.qmd`, before `a_place_in_the_toolkit.qmd`). Four sections as agreed:
opening (subtract, then re-attach) · "Putting back what you set aside" (ancillary TABLE on the
markets + the by-group geography summary showing external corroboration; map left as an invitation) ·
"Summing the rows and columns" (constancy/fidelity → ethnobotany; the essential-species "discriminate
or total" sharpening; richness ≠ diversity with the essential-richness table) · "Reproducible, Not
Proven" (internal vs external; the reproducibility keystone). New data file
`data/market_info.csv` (district/elevation/stalls; Uplands≈388 m vs Harbor≈11 m, so the produce
groups align with geography never fed in). Written in the established chapter voice.
**R-wiring follow-ups for the live render in Kim's session (ClaudeR):** (1) the market→group vector
and (2) the `essential` species vector are spelled out literally so the chapter renders standalone —
replace both with live `coenos_table()` / `classify_species()` pulls once we confirm the API in Kim's
RStudio. Tables use `df-print: kable` + `tbl-cap` (no `coenos_*` print objects here). **Awaits Kim's
read + a live render.**

## Figures placed into chapters (2026-06-15) — book figure-complete

All six SVGs inserted via `![caption](figures/…svg)`, each matched to the chapter whose dataset and
argument it fits (dataset-consistency was the deciding factor):
- `coenos_sparsity.svg` → Ch 1 `two_way_table.qmd`, end of "Mostly empty" (generic items×sites).
- `coenos_timeline.svg` → Ch 2 `coenos_1991.qmd`, after the opening (the 1971→2026 arc).
- `coenos_s00_message.svg` → Ch 3 `reading_a_dead_program.qmd`, in "The program's own notes" (DIEREN).
- `coenos_sort.svg` → Ch 5 `getting_data_in.qmd`, after the unsorted confirm table (markets).
- `coenos_honesty.svg` → Ch 7 `a_clear_point_of_view.qmd`, in "The honesty of an open method".
- `coenos_trim.svg` → Ch 8 `the_reason_for_groups.qmd`, beside the essential-species discussion.

Placement notes: the **trim** figure was kept OUT of Ch 4 (Dieren, n=18, two-thirds = 12) because it
is the markets (n=10, ≥6); it landed in Ch 8 where the markets + "essential species" framing match it
numerically and verbally. The **sort** anchor went to Ch 5 (markets) not Ch 6 (Dieren), so no dataset
mixes inside a chapter. Spelling unified to British "Harbour" in `market_info.csv` to match house
style; offered Kim a global flip to American. Kim's minor standing comment: the toy produce groups are
deliberately crisp (his 2026-06-12 choice), which hides real messiness — left as is; a noisier variant
is a future option. **Book is now figure-complete; Kim to re-render the whole document.**

## Ch 8 worked example wired to live coenosr (2026-06-15) — verified in Kim's RStudio (ClaudeR)

The two literals in `the_reason_for_groups.qmd` are gone; the chapter now practises what it preaches.
Verified live against Kim's R session (port 8787):
- **essential species** ← `classify_species(rel) |> filter(status == "eligible") |> pull(species)`
  (`status` ∈ rare / eligible / ubiquitous). Returns G M R A F S K V B H.
- **market → group** ← `form_groups(rel)`: a `coenos_groups` list, each element `$species` + `$releves`;
  labelled A, B, … in returned order, markets in neither marked "—". Returns A = {1,3,5,7},
  B = {2,4,6,8}. (Group order is deterministic; the prose ties hills/harbour to specific markets, not
  to the A/B label, so it is robust to any relabel.)
- **richness** ← `count()` of items per market (total) and of essential-only items (essential).
All outputs reproduce the drafted numbers exactly (grouped markets 8/5, market 5 is 7/5, the two
staple-only markets 3/0; geography A = Uplands ≈ 388 m, B = Harbour ≈ 11 m). Chapter is render-ready
and fully reproducible.

## Read-through fixes round 1 (2026-06-15) — Kim's three bigger catches

Kim read the whole rendered book ("overall wonderful") and flagged three substantive issues; all
three fixed, verified in his R session.

1. **Grow vs shrink inconsistency.** §4.3 (the_method) said groups are *grown* from a seed; Ch 6 says
   `coenosr` *shrinks* (Bruelheide-Flintrop density-block). Rewrote §4.3 to describe the shrinking
   search, with one honest sentence that COENOS itself grew from seeds (which is why its `.S00` records
   a seed, per the Ch 3 figure) but the recovered engine reaches the same groups by shrinking. Now
   consistent across Ch 3 / 4 / 6 and ties to the Ch 7 honesty theme.

2. **Toy tables looked "sorted."** In §5.2 the ragged excerpt showed three 8-species lines while the
   prose said line lengths differ. Root: the toy was too uniform up front. Fixed by (3).

3. **Very slight data modification (Kim's "add one, take one").** Verified in R then applied to ALL
   THREE on-disk formats in `documentation/data/` (simplified / input / cover, kept mutually
   consistent, still 69 occurrences): **removed F from market 1; added R to market 2.** Result
   (form_groups): two clean five-species groups still recover (markets {1,3,5,7} and {2,4,6,8}); F→
   constancy 3, R→5, so the eligible middle now spreads across 3–5; essential richness now varies
   (market 1 = 4, market 2 = 6, others 5, staple-only 0); the §5.2 excerpt now reads 7, 9, 8. The
   live Ch 5 / Ch 8 tables auto-update on render. Regenerated **`coenos_sort.svg`** (now a believable
   near-diagonal: R's stray mark in market 2, F's gap in market 1) and **`coenos_trim.svg`** (eligible
   spread across 3/4/5). Prose updated: §5.2 excerpt, the Ch 5 cover-format literal (F dropped from
   market 1), and the Ch 8 "full five of its community" sentence (now acknowledges 4 / 5 / 6).

**FOLLOW-UP (flagged, not yet done):** the **coenosr package's bundled `simple_10x15_*`** in
`inst/extdata` (and the `test-form_groups` expectations) still hold the OLD clean toy. The package
tests don't break (still two 5-species groups; 69 occurrences), but the package demo data now differs
from the book. Sync the package (`G:\My Drive\Projects\coenosr`) + re-push to GitHub when convenient.

**Still pending:** Kim's "few small things" (the minor read-through items, to come).

## Read-through fixes round 2 (2026-06-15) — the "few small things"

1. **Terminology unified on "eligible."** Added an early bridge in Ch 1: the Braun-Blanquet tradition's
   **differential species** and our **eligible** species name the same middle band; we mostly say
   *eligible*. Ch 4 middle-band "differential" → "eligible"; Ch 8 "essential" → "eligible" (variable,
   the `eligible richness` column, tbl-cap, prose). "Differential" is now reserved for the formed
   output (differential groups / differential table), matching Ch 6. classify_species's status levels
   (rare / eligible / ubiquitous) are the canonical names.
2. **.REL structure example** added to Ch 5 "COENOS files": the BILL01 relevé excerpt (name line,
   `code cover` lines, `$` terminator) plus a note that the reader can load any file in full with
   `read_rel()` (the book shows only each file's opening).
3. **Function-reference appendix** — new `function_reference.qmd` (in `_quarto.yml` appendices, before
   references). All nine exported functions with signature, one-line purpose, and parameter notes,
   pulled accurately from the package help; grouped reading / analysis / display.

**Package bundle synced:** `inst/extdata/simple_10x15_{simplified,input,cover}.txt` updated to the
modified toy (remove F from market 1, add R to market 2). **`devtools::test()` green — FAIL 0 / PASS
97**; no test edits were needed (still 10 sites, 15 species, 69 occurrences, two five-species groups).
**Remaining package step:** reinstall + `git push` the coenosr repo to GitHub (offered; not yet done).

Note: `getting_data_in.qmd` had rolled back to its pre-edit state (RStudio visual editor overwrote it
when open); re-applied the §5.2 excerpt, the cover-format literal, and the new .REL example. If that
file is open in RStudio, close/refresh it so it doesn't overwrite these again.
| `coenos_honesty.svg` | 7 | chain of approximations | hand → COENOS → coenosr; lost tie-break as an honest footnote |

**Shared visual language (established, Kim-approved):** Okabe-Ito palette — **blue `#0072B2`** /
**orange `#E69F00`** = the two differential groups; **gray** = ubiquitous; **open ring** = rare
(shape, not color alone); **green `#009E73`** = a positive state — "eligible/kept" in the trim,
"recovered/alive" for coenosr in the timeline and honesty figures. Flat, sparing text, faint grid
so absence stays visible, white figure card. CVD-safe and grayscale-separable throughout.
Conventions live in `Projects_Index\style_multichapter_doc.md` §6.

**Kim's reactions (2026-06-15):** anchor "exactly the sort of diagram that's needed"; trim — likes
the green, "goes well on the light green background"; timeline — "simple but effective," spacing
"shows the differences nicely," drop the refrain (save for the end). Also corrected the stale trim
line in the data-input section above.

**NEXT:** place each figure into its chapter `.qmd` via a relative `figures/...` path with a
caption; render the book; then the still-open items (full read-through, Ch8/Ch2 first-person
enrichment, the few coding details, Netlify deploy).
