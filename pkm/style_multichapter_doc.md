# Style Guide: Multi-Chapter Documents (kimbridges-documents)
_Created: 2026-05-12_
_Status: Active — append-only after significant changes_
_Reference implementation: G:\My Drive\Projects\storylines\_

## Purpose

This file codifies the conventions for building a multi-chapter
Quarto document destined for kimbridges-documents.netlify.app.
Derived from observation of the `storylines` reference
implementation plus Kim's stated preferences (2026-05-12). The
guide is the operating manual for new documents (currently:
whittakerr; planned: others) so that every published Document
shares a consistent look, structure, and workflow without
requiring rediscovery each time.

Update this file when a convention changes or a new one is
adopted from doing real work. Append-only on the substantive
parts; the "Open questions" section can be edited as items
resolve.

---

## 1. Project layout

Source for a Document lives at `G:\My Drive\Projects\<name>\`
(per the storage architecture rule in proj_PKM.md). Required
elements at the project root:

- `_quarto.yml` — book configuration.
- One `.qmd` file per chapter, named for the chapter's topic
  (lowercase or natural casing as the chapter title suggests,
  e.g. `locations.qmd`, `LLM.qmd`).
- `index.qmd` — the Preface. Always first chapter in the book
  list.
- `appendix.qmd` — the Appendix. Always last chapter (if
  present).
- A cover image at the project root, named `<name>_cover_art_text.png`
  (e.g., `storylines_cover_art_text.png`). Used both inside the
  document and as the preview-card image in the kimbridges-
  documents grid.
- A logo image at the project root, named `<name>_logo_art.png`.
  Used as the navbar logo when reading the document.
- `background/` — working notes folder (outlines, drafts,
  research). PKM-wide convention.
- `data/` — datasets used by the document. Source files for
  examples and demonstrations.

Build artifacts (`_output/`, `.quarto/`, `<chapter>_files/`)
appear when Quarto renders. They can be regenerated and need not
travel with the source. Reference build output: `_output/` per
the `output-dir` setting in `_quarto.yml`.

Optional, used in the storylines reference but not strictly
required: scratch qmd files for drafting (e.g., `intro.qmd`,
`summary.qmd`, `sandbox.qmd`) that are NOT listed in the
`chapters` section of `_quarto.yml`. These are working scratchpads
that don't appear in the published book. Convention: keep them at
the project root with descriptive names; do not list them in
`chapters:`.

## 2. _quarto.yml conventions

The canonical shape, with annotation:

```yaml
project:
  type: book
  output-dir: _output

book:
  title: "<Document Title>"
  subtitle: "<One-line tagline>"
  author: "K. W. Bridges"
  date: today
  cover-image: <name>_cover_art_text.png
  chapters:
    - index.qmd
    - chapter1.qmd
    - chapter2.qmd
    - ...
    - appendix.qmd
  navbar:
    logo: <name>_logo_art.png

format:
  html:
    code-fold: true
    code-summary: "Show the code"
    embed-resources: false

editor: visual

toc: true
number-sections: true
number-depth: 2

execute:
  warning: false
  error: false
  message: false
```

Notes on specific settings:

- `project.type: book` — these are Quarto books, not websites.
  Books give you numbered chapter sidebar navigation and an
  unnumbered Preface/Appendix wrapping pattern.
- `output-dir: _output` — local rendered output goes here.
  See Section 7 on deployment.
- `book.date: today` — auto-fills with the render date. If you
  want a fixed publication date, set it explicitly (e.g.,
  `date: "2024-06-10"`).
- `book.cover-image:` — Quarto places this image at the top of
  the Preface automatically when the index.qmd doesn't include
  one inline.
- `format.html.code-fold: true` — R code chunks default to
  hidden, with a "Show the code" link to expand. This is the
  central reading-experience convention: prose is the
  foreground, code is one click away.
- `format.html.code-summary: "Show the code"` — the link text.
- `editor: visual` — Quarto's visual-editing mode default
  (Kim's preference; source view remains available).
- `toc: true` plus `number-sections: true`, `number-depth: 2` —
  table of contents enabled, chapters and second-level sections
  get numbers (1.1, 1.2, etc.); deeper levels stay unnumbered.
- `execute:` block — silent rendering. Warnings, errors, and
  messages from R chunks don't appear in the rendered output.
  This keeps the published document clean.

## 3. Chapter qmd conventions

### Preface (`index.qmd`)

- First line: `# Preface {.unnumbered}` — explicit unnumbered.
- Pure prose. No code. Sets up the document's purpose and
  framing.
- Cover image is placed automatically from `_quarto.yml`'s
  `cover-image` setting; do NOT include another image at the
  top of index.qmd.
- Length: 4–8 paragraphs typical. State what the document is,
  what it teaches, who would benefit, and the rough shape of
  the journey through chapters.

### Regular chapters (`<name>.qmd`)

- First line: `# Chapter Title` (no `{.unnumbered}` — Quarto
  numbers automatically per `_quarto.yml`).
- Brief introductory paragraphs immediately under the chapter
  title (no subsection header). 1–3 paragraphs set context for
  what the chapter does and why.
- First code chunk is the **setup chunk**: load libraries,
  install custom packages (commented out — leave the
  install_github call as a `## install_github(...)` comment for
  reference), initialize defaults, and read in any baseinfo
  needed for the chapter. The setup chunk is REPEATED in each
  code-using chapter so that any chapter can be opened and run
  independently. See Section 4 for the setup-chunk template.
- After setup, content is organized into sub-sections with
  `## Sub-section Title`. Each sub-section is one logical
  unit: brief intro paragraph, then a code chunk that does the
  work, then any narrative around the output.
- Code chunks are labeled: `#| label: <descriptive_name>` as
  the first line inside each chunk. Labels should be unique
  within a chapter and descriptive enough to find in the
  rendered output.

### Appendix (`appendix.qmd`)

- First line: `# Appendix {.unnumbered}` — explicit unnumbered.
- Used for: references, supporting tables, technical notes
  that don't belong in the main flow, or "if you want to go
  deeper" material.
- **When the document accompanies an R package, include a
  function-reference appendix as a standard part of the
  documentation.** List every exported function with its
  signature, a one-line purpose, and its parameters — pulled
  from the package help and grouped by workflow stage. Rationale
  (Kim, 2026-06-15): this information only appears once the
  package is loaded, but much of the audience reads the document
  without ever loading it, so the appendix is the overview they
  would otherwise miss. First done in the coenosr document
  (`function_reference.qmd`); treat it as expected for any future
  package-documenting book.

## 4. R code conventions

### Setup-chunk template

Every chapter that uses R should begin with a setup chunk
following this pattern (verbatim from storylines/locations.qmd):

```r
#| label: setup<chapterhint>
#| message: false

## --- Standard packages ---

## load GitHub-hosted packages
library(devtools)
## many useful functions
library(tidyverse)
## graphics functions
library(ggplot2)
## data crunching functions
library(dplyr)
## time functions
library(lubridate)
## formatted tables
library(gt)

## --- Specialized packages ---

## <one-line description>
library(<package>)

## --- Packages from github/kimbridges ---

## install once with: install_github("kimbridges/<package>")
library(<package>)

## --- Options and defaults ---

## suppress read_csv() column-type messages (see Section 5)
options(readr.show_col_types = FALSE)
<other defaults>

## --- Baseinfo (originates in <originating chapter>) ---

## shared paths and source citations
baseinfo <- read.table("baseinfo.txt")
source   <- baseinfo$source
folder   <- baseinfo$folder
```

Conventions inside the setup chunk:

- Comments use `##` (two hashes), placed on their own line
  immediately before the code they describe. See "Comment
  placement" below.
- Comment-header dividers organize sections within the chunk.
- The `#| message: false` chunk option suppresses the
  package-masking notices that `library()` calls emit (the
  "following objects are masked" lines). When the book's
  `_quarto.yml` carries a global `execute: message: false`,
  the per-chunk option is redundant but harmless; until the
  `_quarto.yml` exists, set it on each setup chunk.
- The custom-package install line stays in the file as a
  `## install_github(...)` COMMENT (not executable). It's
  reference material for the reader. The actual `library(...)`
  call IS executable.
- `baseinfo.txt` is read from the chapter's working directory.
  See Section 5 on data input.

### Comment placement

Place comments on their own line, immediately before the code
line or code section they describe. Do not use trailing
comments at the ends of code lines, and do not rely on the
chapter prose alone to carry the explanation.

The reason is portability. A reader who finds an example
useful will copy the code chunk into their own work. The
chapter's surrounding prose does not travel with the copy;
comments inside the chunk do. Code that carries its own
explanation stays useful after it leaves the document. Data
input in particular — the place analysis errors most often
begin — benefits from each step naming its own purpose.

This supersedes the trailing-aligned comment style in the
setup-chunk template above as originally captured (from
storylines, before this convention was settled).

### Code clarity for occasional R users

The audience for these documents is occasional R users, not
R specialists. Two habits keep example code readable for
them:

- **Prefer sequential steps over nested calls.** A nested
  expression such as `bind_cols(a, select(b, x, y))` reads
  cleanly to an experienced user and poorly to an occasional
  one. Break it into named steps, each doing one thing, each
  with its own comment.
- **Name intermediate results.** A short, descriptive name
  for each step's output makes the data flow visible and
  gives the reader a concrete object to inspect. The
  intermediate names also document the pipeline.
- **Parenthesize arithmetic where precedence could be
  doubted.** Even when R's operator precedence makes the
  expression correct as written, wrap a sub-term in
  parentheses to remove any doubt: write
  `round(prec - (2 * tavg), 2)`, not
  `round(prec - 2 * tavg, 2)`. Clarity outranks brevity, and
  the reader should never have to recall a precedence rule to
  trust the line. (Kim's standing rule, from years of spotting
  student coding errors.)

### Code chunk labels

Every chunk takes `#| label: <name>` as the first directive.
Naming pattern: short, descriptive, unique within the chapter.
Examples from storylines: `setuploc`, `calcdist`, `milestones`.
Use lowercase, no spaces, no underscores beyond what aids
readability.

### Output: label what the reader sees

These chunks belong to a formal document, not a set of
working notes that happen to show how code runs. Every value
the reader sees should carry a label or context that says
what it is. A proficient R user reads a raw value fine; a
beginner meets an unlabeled number with "what just popped
out?"

A bare scalar is the common offender: a chunk ending in
`nrow(ca_gardens)` prints `65` with nothing to say it is a
count of gardens. Two fixes, both acceptable:

- Fold the value into the prose as an inline-R expression, so
  the number reads inside a sentence. Best for a single
  number that motivates the surrounding text.
- Label it in the output: a `gt()` table (its column names
  are the labels), a captioned line, or a named result shown
  with others. Best for structured or multiple values.

Displayed tibbles and `gt()` tables already satisfy the rule:
their column names are the labels. It bites on bare scalars.

### Output: tables

Use the `gt` package for displayed tables. Pattern:

```r
gt(table_name)
```

For tables with a source citation:

```r
gt(data) |>
   tab_source_note(source_note = source)
```

The `source` variable typically comes from `baseinfo$source`.

For columns whose units are not carried in the column name,
add a unit footnote with `tab_footnote()`, targeting the
column label. This is the same instinct as the source note: a
table should declare its units, and a teaching document
should model that habit. Columns whose names already encode
the unit (`mat_c`, `map_cm`) need no footnote; descriptive
names without a unit (`temp_historical`, `precip_future`) do.

```r
gt(data) |>
  tab_footnote(
    footnote  = "Degrees Celsius.",
    locations = cells_column_labels(columns = c(temp_historical, temp_future))
  ) |>
  tab_footnote(
    footnote  = "Centimeters.",
    locations = cells_column_labels(columns = c(precip_historical, precip_future))
  ) |>
  tab_source_note(source_note = source)
```

This lengthens the chunk, which is an accepted tradeoff: the
table becomes self-describing, and the reader gets a worked
reference for the pattern.

### Output: figures

Standard `ggplot2` output, or domain-specific output from
custom packages (e.g., `milestones()` for bar timelines).
The Whittaker diagram (`plot_biomes()`) and the biome map
(`plot_biome_map()`) are the document's two main figure
types.

**One figure per page width, stacked, never side by side.**
Each figure fills the full width of the page. When a chapter
needs to compare several figures, for instance the same
diagram or map under different palettes, the figures are
stacked vertically, one above the next, each at full width.
They are not arranged in a side-by-side row or grid.

Three reasons. A side-by-side figure's legend is routinely
overlaid or crowded by the adjacent figure; at full width
the legend has room. The documents are not space-constrained,
so there is no reason to compress figures to save vertical
space. And the stacked arrangement reads well on a narrow
device such as a phone, where a side-by-side pair would
shrink each figure past legibility.

In practice: do not use side-by-side composition for the
document's figures (`patchwork`'s `+` row form,
`gridExtra::grid.arrange` with multiple columns, or Quarto's
`layout-ncol` greater than 1). Build a multi-panel
comparison as a sequence of full-width figures, or as a
single vertical stack (`patchwork` with
`plot_layout(ncol = 1)`).

## 5. Data input conventions

**Strong preference: read data from CSV-style files; avoid
dataframes constructed inline in code.**

Inline dataframes are acceptable only for very small (~3–5 row)
demonstration cases where the reader needs to see the literal
data. For anything larger, the data lives in `data/` (or another
named subfolder) and is read via `read.table()`, `read.csv()`,
or `readr` functions.

Pattern observed in storylines (file-path-via-baseinfo):

```r
file_location <- paste0(files_folder, "/photo_info.txt")
data <- read.table(file = file_location)
```

This pattern works for chapters that share file paths via
`baseinfo.txt`. For self-contained chapters (or chapters with
their own data), reading directly from the project's `data/`
folder is fine:

```r
gardens <- read.csv("data/Bot_Garden_Geocode_CSV.csv")
```

### Inline demonstration data: table style over loose vectors

When constructing inline demonstration data — small tables that
exist literally in the chapter source for teaching purposes —
use the **table style** (a single multi-column structure) rather
than parallel vectors. Two equivalent forms work:

Preferred (inline CSV via `readr::read_csv()`):

```r
b_table <- read_csv(file =
   "site, temp, ppt
    A,     5,   100
    B,    12,   210
    C,    14,   167",
   show_col_types = FALSE)
```

Acceptable (`tibble()` with named columns):

```r
b_table <- tibble(
  site = c("A", "B", "C"),
  temp = c(5, 12, 14),
  ppt  = c(100, 210, 167)
)
```

Both produce a usable data object in one expression. The
`read_csv` inline form is preferred because it matches the
spreadsheet mental model most readers come from — rows are
observations, columns are variables, alignment is visual and
structural.

**Avoid** parallel loose vectors as the data carrier:

```r
# Avoid this style in teaching examples:
site <- c("A", "B", "C")
temp <- c(5, 12, 14)
ppt  <- c(100, 210, 167)
```

Parallel vectors rely on positional alignment across separate
objects. Adding or removing an observation requires three
coordinated edits, and silent off-by-one errors are easy. The
audience for these documents — occasional R users coming from
spreadsheets — does not have years of intuition about vector
alignment, and asking them to develop it during a teaching
example is a tax the document doesn't need to charge.

**Vectors are still the right form at function call sites.**
Once a table exists, pull its columns out via `$` to pass to
functions that take vector arguments:

```r
plot_biomes(mean_temp_c  = b_table$temp,
            total_ppt_mm = b_table$ppt,
            label        = b_table$site)
```

The division of labor: tables for authoring inline data;
vectors at function-call sites. The two coexist naturally in
the workflow; the table is the input form and vectors are the
computation form.

### read_csv options for cleaner output

By default, `readr::read_csv()` prints a column-type message
each time it reads data. For published documents this is
clutter. The standard option to suppress it:

```r
b_table <- read_csv(file = "...",
                    show_col_types = FALSE)
```

For chapters with many reads, set the option globally once at
the start of the setup chunk:

```r
options(readr.show_col_types = FALSE)
```

If auto-detection produces the wrong column type (e.g., a
numeric column gets read as character because one value
contains a stray text character), specify types explicitly:

```r
b_table <- read_csv(file = "...",
                    col_types = cols(site = col_character(),
                                     temp = col_double(),
                                     ppt  = col_double()),
                    show_col_types = FALSE)
```

Note that `readr` returns character columns (not factors) by
default — the historical `stringsAsFactors = FALSE` issue of
base R's `read.csv()` doesn't apply.

### Confirming data after input: gt() + source note

After reading data, **display it immediately**. Visual
confirmation that the data is what you expect is essential, and
the discipline of showing it should be modeled in every
example. The standard pattern:

```r
b_table <- read_csv(file = "...",
                    show_col_types = FALSE)
b_table |> gt()
```

For tables with a known data origin (a publication, a project
data file, a synthetic dataset), add a source note via the
`gt::tab_source_note()` function:

```r
b_table |>
  gt() |>
  tab_source_note(source_note = source)
```

where `source` typically comes from `baseinfo$source` (see
baseinfo.txt below).

Section 4 (R code conventions, "Output: tables") covers the
same pattern from the code-conventions side. The point in
this section is the data-input-side discipline: read it,
display it, cite its source, immediately. Modeling this
discipline in example after example makes it routine for the
reader to do the same in their own work. A document whose
examples consistently show data-read → data-display →
source-cite trains its readers in habits that survive past
the document.

### baseinfo.txt

A small shared-configuration file at the project root. Contains
paths and source citations that all chapters need:

- `source` — citation/source text for the document's data.
- `folder`, `thumbs_folder`, `files_folder` — relative paths to
  data and asset subfolders.

The originating chapter (typically chapter 1 — `photos.qmd` in
storylines) creates baseinfo.txt; subsequent chapters read it.
This decouples chapters from hard-coded paths and lets the entire
document be rebased by changing one file.

baseinfo.txt is NOT required for every document — only documents
that share configuration across chapters. A document with no
shared state can skip it.

## 6. Image conventions

Three image categories with three storage conventions:

- **Cover image** — `<name>_cover_art_text.png` at the project
  root. Used by Quarto as the auto-placed image at the top of
  the Preface (via `cover-image:` in _quarto.yml). Also used as
  the preview image in the kimbridges-documents grid listing
  card. The same image serves both purposes — do not maintain
  duplicate copies.
- **Logo image** — `<name>_logo_art.png` at the project root.
  Appears as the navbar logo when reading the document.
- **Content images** — anything used inside a chapter
  (reference figures, diagrams, photos) lives in an
  `images/` subfolder at the project root. Referenced from
  chapter qmds via relative path: `images/<filename>.png`.
  Name files descriptively (e.g.,
  `Vegetation_no_legend.png`, `whittaker_diagram_example.png`).

Naming for cover and logo: `<name>_<cover_art_text|logo_art>.png`.
Lowercase, underscored, .png. The naming uniformity matters
because the listing stub in kimbridges-documents/docs/ references
the cover image by relative path.

Content image naming has no enforced convention beyond
descriptiveness; the file's purpose should be obvious from the
name without opening it.

If a chapter has its own substantial image set (photo series,
multi-figure exhibit), use a chapter-specific subfolder
(e.g., `photos/day_03/` in the storylines reference) instead of
piling everything into `images/`. Use `images/` for cross-chapter
content images.

### Attribution for external images

When an image comes from an outside source (Wikipedia, photo
archives, others' published work), credit the creator and source
in the figure caption itself:

```markdown
![Caption text. Image by <Creator> via <Source>.](images/<filename>.png)
```

The whittakerr History chapter uses this pattern for the biome
map: `Image by Ville Koistinen via Wikipedia.` Keep attribution
brief; the goal is to credit the source within the visible
caption rather than burying it in a separate references list.
For images that require more detailed license terms or longer
provenance notes, add a longer attribution in the Appendix and
keep the caption concise.

For images you create or generate yourself (including
AI-generated composites), no attribution is required in the
caption. If the construction is interesting enough to mention
(as with the whittakerr cover, which combines an old Whittaker
photo with a diagram rendered from the document's own R code),
that's a sentence worth including somewhere — probably in the
Preface or as a Foreword note rather than in the caption.

### Infographics and data figures (2026-06-14)

Adopted from the coenosr document's infographic program, and reflecting Kim's
identity-level preference for illustrating documents — especially the technical ones
(see `kim_association_index.md` Master Theme 12). Technical documents should be
illustrated, not merely explained: a diagram lets a reader grasp a pattern at a glance
and then explore the detail, and it breaks the monotony of unbroken text.

Conventions for a document's figure set:

- **One job per figure, woven into the chapter** at the point of need — not one
  overloaded standalone poster. Several small figures across the document, each making
  a single point, beat one that tries to carry everything.
- **A consistent visual language across the whole set** — one palette, one cell/element
  style, one set of conventions — so the figures read as a system, not a gallery. A new
  figure inherits the established language.
- **Sparing text.** Panel labels, a short legend, axis/row keys, and at most a one-line
  caption inside the figure. Explanation lives in the surrounding prose, not in the image.
- **Color: readable and colorblind-inclusive, required.** Use the **Okabe-Ito**
  categorical palette (blue `#0072B2`, orange `#E69F00`, plus neutral gray for
  structural/ubiquitous elements). CVD-safe across all three deficiency types and
  separable in grayscale. **Never** culturally loaded or CVD-unsafe pairs (red/green,
  pink/blue). Color encodes meaning; keep to 2–3 hues.
- **Never rely on color alone.** Pair color with a second channel — shape (e.g. open
  rings for a "rare" category), position, or pattern — so the encoding survives any color
  vision deficiency.
- **Build figures as SVG**, generated from the real data by a small script where possible
  (the figure then *is* the result, not a mockup), so it drops into Quarto, scales without
  blur, and is rebuildable. Save under the project's `figures/` (or `images/`) subfolder.
- **Save via the file tool, not the bash sandbox** — bash writes to G: do not reliably
  surface to Drive/the file tools (pkm_findings.md Finding 005).

**Figure width and centering in Quarto (2026-07-25).** A data figure sized as a
standalone SVG is wider than the body text column, so it needs an outset class. Use
`.column-body-outset` **together with `width=100%`**:

    ![Caption ...](figures/name.svg){#fig-name width=100% fig-align="center" .column-body-outset}

`.column-page` is the wrong tool for this. It widens the *container* to the full viewport
but leaves a natural-width image flush LEFT inside it, and `fig-align="center"` does not
correct that, so the figure reads as pushed to the side. With `.column-body-outset` plus
`width=100%` the figure fills the outset column, overhangs the text column symmetrically
(about 75 px each side at 1280-1680 px viewports), and renders larger than its natural
size, so axis text gains legibility. Verify by measuring the rendered DOM, not by eye.

Reference implementation: `Ceska\documentation\figures\coenos_sort.svg` (the
scatter-to-diagonal sort).

## 7. Deployment (kimbridges-documents listing stub)

A two-step pattern:

**Step 1: Build the document.** Render the Quarto book from
`G:\My Drive\Projects\<name>\`. Quarto produces rendered HTML
in the `_output/` subfolder (per `output-dir: _output` in
_quarto.yml).

**Step 2: Deploy the rendered HTML** to
`G:\My Drive\kimbridges-documents\<name>\`. The actual deploy
mechanism is currently a manual copy (see Open Questions
below — this should be documented or scripted). The
kimbridges-documents Netlify deploy then serves the new content.

**Step 3: Add the listing stub.** Create
`G:\My Drive\kimbridges-documents\docs\<name>.qmd` following
this pattern (storylines example):

```yaml
---
title: "<Document Title>"
subtitle: "<One-line tagline (same as book subtitle)>"
categories: ["<Tag1>", "<Tag2>"]
image: ../<name>/<name>_cover_art_text.png
---

[View Document](../<name>/){.btn .btn-primary}
```

The `categories` array drives the filter UI on the documents
index page. Use 1–3 tags per document; prefer existing tags
over inventing new ones.

The body is just a one-line button linking to the document
folder. Quarto's listing feature in kimbridges-documents/index.qmd
picks up the YAML automatically and renders the card.

**Step 4: Update the kimbridges-documents `_quarto.yml`
resources list** if you're adding a new document folder. The
resources line should include `<name>/**` so Quarto includes
the deployed folder when it renders the documents site.

**Step 5: Push to Netlify.** Render the documents site from
`G:\My Drive\kimbridges-documents\` (`quarto render`, output
to `_site/`). Then, in the Netlify dashboard, click the
**existing** `kimbridges-documents` site tile and drag the
`_site` folder (the whole folder) onto its Deploys-tab drop
area. Do not click "Add new project" — that creates a new
standalone site rather than updating the existing one.
Verify at `https://kimbridges-documents.netlify.app/`. The
full procedure, including the listing-stub template and the
critical "Add new" vs. "update existing" distinction, lives
in `proj_kimbridges_documents.md` Deployment Workflow.

## 8. Style notes (writing voice)

For voice and tone, defer to `kim_association_index.md` (the
writing style reference). Key high-level reminders:

- Short sentences are preferred. Long compound sentences become
  hard to read.
- Plain language over jargon. Define technical terms when first
  introduced.
- Each chapter sets context in its opening paragraphs (1–3
  paragraphs) before diving into the code.
- Examples are example-driven and real-situation-based where
  possible. Synthetic data is fine for first demonstrations,
  but show real-world examples once the basics are established.
- A "production" version of the code will look different from
  the document version. The document teaches and demonstrates;
  it does not have to be the polished delivery vehicle.

## 9. Document method: chapters as the working scaffold

Documents and stories are different genres and want different
working methods. A story has one spine and every chapter
advances it; iteration happens on the spine itself. A
document has multiple related but distinct facets and each
chapter explores one of them; iteration happens on each
facet independently. The two genres want different starting
discipline.

**For documents: identify the chapters early.** The chapter
list is the working scaffold against which all subsequent
thinking gets organized. Without an early chapter list,
ideation has nowhere to land and either piles into one
undifferentiated note or scatters across the project. With
an early chapter list, each facet has its own home and
thinking on one chapter doesn't bleed into thinking on
another.

**Use an ideation file per chapter.** The pattern emerged
during the whittakerr project (2026-05-13 through 2026-05-15)
and has consolidated into a working convention. Each
substantial chapter gets its own
`background/chapter_<name>_ideas.md` file. The ideation
file holds the chapter's developing argument, key quotes
or formulations to preserve verbatim, a provisional
structure, open questions specific to that chapter, and a
resumption checklist for the eventual drafting session.

**The workflow sequence:**

1. Identify the chapters at document start. Even rough
   names and one-line descriptions are enough. The list
   will evolve, but starting with a list is what matters.
2. Create an ideation file for each chapter that needs
   substantive thinking before drafting. Not every chapter
   needs one — purely technical chapters (Getting Started,
   Setup) may not. Conceptual or argument-driven chapters
   always do.
3. Let ideas land in the relevant chapter's ideation file
   as they arise. Cross-references between ideation files
   are encouraged when threads span chapters.
4. When ready to draft, work from the ideation file's
   structure and verbatim formulations. The ideation file
   may be retired or archived after drafting if the
   chapter has fully absorbed its content.

**What goes in an ideation file (template):**

- **Status** — drafted / ideation complete / drafting in
  progress / etc.
- **Placement** — where this chapter sits in the document
  sequence, and why.
- **Threads** — the substantive sub-arguments, numbered and
  named. Each thread is a paragraph or two developing one
  facet of the chapter's content.
- **Key formulations to preserve verbatim** — exact
  phrasings worth carrying forward without paraphrase.
- **Provisional structure** — opening / middle / closing
  turn shape of the chapter.
- **Open questions** — specific to this chapter, distinct
  from project-wide open questions.
- **Next session — resumption checklist** — the concrete
  steps to start the next drafting work block without
  re-reading the whole file.

**Reference implementations (whittakerr).** Three ideation
files in `G:\My Drive\Projects\whittakerr\background\`
exemplify the pattern: `chapter_what_is_a_biome_ideas.md`
(conceptual chapter on categorization), `chapter_colors_palettes_ideas.md`
(visualization chapter on palette design), and the
implicit mapping chapter described across multiple threads
in `design_classification_to_mapping.md`. The format above
is the consolidated template from these three files.

**Note on story-mode work.** For stories (linear narrative
documents like trip logs, photo essays, single-arc
treatments), the ideation-file-per-chapter pattern is
overkill. Stories want a single evolving outline plus a
sense of where the spine is going next. The PKM should
support both modes; the chapter-ideation pattern is
specifically a document-mode tool.

**Sub-distinction within document-mode: user-guide-dominant
vs conceptual-base-dominant.** Documents in the
kimbridges-documents family vary in their balance between
practical instruction and conceptual material. Two
sub-genres recurred:

- **User-guide-dominant.** The Document is mostly about how
  to do the thing. Conceptual material is light; the
  weight is in the worked examples and the code. Reference:
  Sitemaps (kimbridges-documents/sitemaps/) — the
  conceptual base is brief and the chapters work through
  many concrete map-making cases. The tone is informal and
  practical ("Yes, this is a bit of a pain to establish").
- **Conceptual-base-dominant.** The Document is mostly
  about the thinking the tool implements. The user guide
  is relatively modest; the weight is in chapters that
  explain why the framework is what it is. Reference:
  whittakerr — half the chapters develop conceptual
  arguments (History, What Is a Biome?, Scale) before the
  technical chapters appear. The tone is more declarative
  and rigorous ("Identity is what a thing is; function is
  what it does").

A Document's balance is a structural choice made early. It
shapes the chapter list, the proportion of prose to code,
and the voice. Naming the choice when starting a new
Document lets the author commit to a register consistent
with the choice. Mixed Documents (substantial conceptual
material AND substantial user-guide material) are possible
but require deliberate management of the tonal shifts
between conceptual chapters and technical chapters; the
register pivot should be conscious rather than accidental.

Observed 2026-05-18 during the whittakerr chapter drafting
review of Sitemaps. The recognition came from Kim
articulating that "Sitemaps is mostly a user guide. There's
not much of a conceptual base. Here, in whittakerr, the
conceptual base is the issue. The 'user guide' is
relatively modest. As a result, the tone of the two
documents is different."

## 10. Open questions

These are conventions that aren't yet settled or that the
storylines reference doesn't fully resolve. As they get answered,
either update this guide or note the answer here.

**Deployment automation.** Resolved 2026-05-25 (manual,
documented). The end-to-end procedure — Windows Explorer
copy from `_output/` to the collection, Quarto render of the
documents site, Netlify drag-drop deploy onto the existing
`kimbridges-documents` site (not "Add new project") — is
documented in `proj_kimbridges_documents.md` Deployment
Workflow and summarized in Section 7 above. Automation (a
render-and-deploy script) remains a future improvement.

**Source preservation.** Before 2026-05-12, the storylines
source qmds existed only on Kim's desktop and were not on Drive.
Resolved 2026-05-12 by copying to
`G:\My Drive\Projects\storylines\`. Going forward, all document
sources live under `G:\My Drive\Projects\<name>\` from the start
— no desktop-only origin.

**Categories vocabulary.** The `categories` field on each
listing stub drives the filter UI. There's no controlled
vocabulary yet. Consider compiling the current set of in-use
categories and either adopting them as canonical or curating
them.

**Scratch qmd files.** storylines has `intro.qmd`, `summary.qmd`,
`references.qmd`, `sandbox.qmd` at its root that are not in the
`chapters` list. These are draft/scratch. Convention: keep them
at the project root, name them descriptively, do not list them
in `_quarto.yml` chapters. Worth tracking which scratch files
exist per project in the project's proj_*.md Key Files section
(or its Background section if more appropriate).

**Baseinfo origination.** `baseinfo.txt` is created by an
"originating chapter" in storylines (chapter 1 — photos.qmd).
For documents whose chapters don't have a natural origin
chapter, baseinfo.txt can be authored manually and checked in
to the project, or the convention can be skipped entirely.

## 11. Application to whittakerr (the immediate test case)

Specific decisions for whittakerr based on this guide:

- Project root: `G:\My Drive\Projects\whittakerr\` (already in
  place).
- Subfolders: `background/` (already in place with Whittakerr
  Notes.md), `data/` (already in place with
  Bot_Garden_Geocode_CSV.csv).
- _quarto.yml: configure as a book per Section 2 template;
  title "Whittakerr"; subtitle TBD; chapters list per
  proj_whittakerr.md Chapter Status section.
- Cover image: TBD (`whittakerr_cover_art_text.png` to be
  created). A Whittaker biome diagram itself would make a fine
  cover.
- Logo image: TBD (`whittakerr_logo_art.png`).
- Setup chunk: load plotbiomes (from github/valentinitnelav,
  not from CRAN — needs `## install_github(...)` comment),
  sp, tidyverse, ggplot2. Probably no baseinfo.txt needed —
  whittakerr chapters are largely self-contained.
- Data input: `data/Bot_Garden_Geocode_CSV.csv` already ready
  for the Botanical Gardens example. Pattern is
  `read.csv("data/Bot_Garden_Geocode_CSV.csv")`.
- Listing stub: `kimbridges-documents/docs/whittakerr.qmd`
  with title "Whittakerr", subtitle, categories (e.g.,
  ["Ecology", "R", "Climate"]), image pointing to the cover.
- _quarto.yml resources line: add `whittakerr/**` to
  kimbridges-documents/_quarto.yml when ready to deploy.

The History chapter (first to be drafted, per task #16) is
pure prose. It follows Section 3's "Regular chapters" pattern
with no code chunk: just `# History of Biome Identification`
as the H1 followed by introductory paragraphs and `## Section`
subsections as the content develops.

---

## Log

### 2026-06-28 (Section 4 — explicit-parentheses arithmetic convention)
Added an eighth code-clarity habit to Section 4's "Code clarity for
occasional R users": parenthesize a sub-term in any arithmetic
expression where operator precedence could be doubted, even when the
unparenthesized form is correct (`round(prec - (2 * tavg), 2)` over
`round(prec - 2 * tavg, 2)`). Kim's standing rule, surfaced while
reviewing the seasonality WorldClim appendix; rooted in years of
spotting student coding errors, and a direct instance of his
readability-as-discipline hallmark (kim_association_index.md Master
Theme 11). Applied in `seasonality/documentation/appendix_worldclim.qmd`.

### 2026-05-12
Style guide created from the storylines reference implementation
and Kim's stated preferences. Source observation:
G:\My Drive\Projects\storylines\ (copied from Kim's desktop in
this session, per the storage architecture rule). Initial scope
covers project layout, _quarto.yml conventions, chapter qmd
patterns (Preface / regular / Appendix), R code conventions
(setup chunk, code-fold, gt tables), data input preferences,
image conventions, deployment workflow, and a section applying
the guide to the whittakerr build that follows.

### 2026-05-15
New Section 9, "Document method: chapters as the working
scaffold," added at Kim's prompt. Codifies the document-vs-story
distinction (documents are multi-faceted explorations; stories
are linear), the consequence (for documents, identify chapters
early — they become the working scaffold), and the
ideation-file-per-chapter pattern that emerged from real use
in the whittakerr project across three days of working
sessions. Includes a workflow sequence, a template for what
goes in an ideation file, and a note that story-mode work
doesn't need this pattern. Reference implementations cited:
the three whittakerr chapter-ideation files in
`background/`. Previous Sections 9 and 10 renumbered to 10
and 11. Kim's framing of the prompt: documents differ from
stories because documents involve several to many related
facets of exploration; emphasis on identifying chapters when
starting a new document is the right consequence.

### 2026-05-15 (later — Section 5 expansion)
Section 5 (Data input conventions) expanded with three new
subsections codifying Kim's existing practice on inline
demonstration data: (a) table style over loose vectors —
preferred forms (`read_csv` inline string and `tibble()`),
what to avoid (parallel loose vectors), and the rationale
(observation-level integrity, spreadsheet mental model,
audience-appropriate for occasional R users); (b) `read_csv`
options for cleaner output — `show_col_types = FALSE` as the
primary option, the global `options(readr.show_col_types =
FALSE)` form for chapters with many reads, explicit
`col_types = cols(...)` for type-misdetection cases, plus a
note that readr returns character (not factors) by default;
(c) Confirming data after input — the `gt()` discipline of
displaying every read immediately, with source notes via
`gt::tab_source_note()`. Section 5 now models the full
read-and-confirm discipline that Kim wants reinforced in
every chapter. Section 4's existing source-note pattern
cross-referenced. Kim's framing: showing this discipline in
example after example makes it routine for readers to do
the same in their own work.

### 2026-05-20 (Section 4 — code-style conventions settled)
Section 4 (R code conventions) revised at the start of the
whittakerr technical-chapter drafting, when Kim settled
four code-style preferences. (a) Comment placement: comments
go on their own line, immediately before the code they
describe — not trailing the line, not left only to the
chapter prose. Rationale: a reader copies the code chunk,
not the prose, so the explanation must live inside the
chunk. This supersedes the trailing-aligned setup-chunk
comment style originally captured from storylines; the
setup-chunk template in Section 4 was rewritten to the new
style. (b) Message suppression: `#| message: false` on
setup chunks suppresses the `library()` masking notices,
pending the global `execute: message: false` the
`_quarto.yml` will carry. (c) `options(readr.show_col_types
= FALSE)` belongs in the setup chunk rather than as a
per-call argument (cross-references the existing Section 5
note). (d) New subsection "Code clarity for occasional R
users": prefer sequential named steps over nested calls,
because the audience is occasional R users. Kim's framing:
better to settle code conventions at the start of the
code-heavy chapters than to retrofit them later.

### 2026-05-21 (Section 4 — gt unit footnotes; output-labeling discipline)
Two conventions added while drafting the whittakerr
Retrieving Climate Data chapter.

A fifth convention, gt unit footnotes. When a displayed
column carries a measurement whose unit is not part of the
column name, add a `tab_footnote()` on the column label
giving the unit. Kim's framing: it is the same good-practice
instinct as the source note, and modeling it in the document
gives readers a worked reference for the pattern. Columns
whose names already encode the unit (`mat_c`, `map_cm`) are
exempt; descriptive, unit-free names (`temp_historical`,
`precip_future`) are the case it addresses. Recorded in
Section 4, "Output: tables". Longer chunks are an accepted
cost. First applied to the `cities-future-comparison` chunk.

A sixth convention, output-labeling discipline. These
chapters are a formal document, not working notes, so every
value the reader sees must be labeled or contextualized — no
bare scalar prints. Kim's example: a chunk ending in `nrow()`
drops an unexplained `65`. Fix: fold a single motivating
number into the prose as inline R; label structured output
in a `gt()` table or a captioned line. Recorded as the
Section 4 subsection "Output: label what the reader sees".
First applied by removing the bare `nrow(ca_gardens)` from
the `gardens-california` chunk and moving the count into the
prose.

### 2026-05-25 (Section 7 — deployment workflow resolved)
Section 7 (Deployment) gained Step 5, which documents the
Netlify push: render the documents site, drag-drop `_site/`
onto the existing `kimbridges-documents` site's Deploys tab,
not "Add new project." Section 10's Open Question on
Deployment automation is updated to resolved (manual,
documented). The full step-by-step procedure lives in
`proj_kimbridges_documents.md` Deployment Workflow; Section
7 carries a summary plus the "Add new" vs. "update existing"
distinction that caught us on the whittakerr publication
this same session. Captured immediately after the
whittakerr deploy went live so the workflow is recorded
while still fresh.

### 2026-05-22 (Section 4 — figure layout convention)
A seventh convention added to Section 4, "Output: figures".
Document figures are placed one per page width and stacked
vertically; they are never set side by side. Kim's framing:
a side-by-side figure's legend is often overlaid by the
adjacent figure, the documents have no need to save space,
and the stacked, full-width arrangement reads well on a
narrow device such as a phone. Applies to the Whittaker
diagram and, later, the biome map. The immediate effect is
on the Color chapter's multi-palette comparison figure,
which becomes a vertical stack of full-width panels rather
than a side-by-side grid.

### 2026-07-25 (Section 6 - figure width and centering)
Added the `.column-body-outset` + `width=100%` rule for data figures, learned on the AI
Microscope document. Kim's report was that the new charts "are pushed to the left and they
look unusual that way." The cause was `.column-page`, which widens the container but not
the image. Diagnosed by measuring figure and paragraph geometry in the rendered page at
three viewport widths rather than eyeballing it.
