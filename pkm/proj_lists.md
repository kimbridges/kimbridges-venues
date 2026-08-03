# PROJECT: lists
_Last updated: 2026-06-16_
_Status: Complete_
_Focus readiness: Not applicable_

## Type
R + Quarto document — a stand-alone, hands-on demonstration / methodology piece.

## Objective
A short, hands-on document that gives non-specialists a conceptual model and a low-friction
workflow for analysing the **lists** they already make (markets × produce, gardens × vegetables,
plots × trees, …) — so that list data stops "sitting frozen, unused." The deeper reframing
(Kim, 2026-06-15): the document is really about **careful experimental design** as the thing that
turns a list into real value. The same workflow is shown on **two different problems**, examined
identically, so the reader sees a transferable recipe rather than a domain trick. **Stand-alone**
(no `coenosr` dependency, by design — Kim keeps dependencies strict).

## Concept / spine
Low-friction ragged data entry — one line per site, `"Site, item, item, …"`, variable length,
comma-separated — the same format that later became `coenosr`'s `read_lists()`. (This 2022 "lists"
experiment is the conceptual ancestor of coenosr's input layer.) Workflow as named steps:
read the list → confirm (item list) → frequency scans (items per site, sites per item) → two-way
table (binary presence/absence) → dendrograms (cluster species; cluster sites) → **assessment-line
interpretation** → groups → link to metadata. The dendrogram is Kim's "other tool" (named in coenosr
Ch 8: the similarity/clustering path he reached for before two-way tables).

## The methodology core — assessment lines (from *Island Ecosystems*; Mueller-Dombois, Bridges & Carson)
Cutting a dendrogram to define groups, anchored by **experimental design with replicate (paired) sites**:

- Include predefined replicate sites — usually pairs — declared a priori to be the **same category**.
  These pairs are the ruler; they **control within-site variability by design**.
- **Strict assessment line:** the lowest cut that keeps every predefined pair intact; its position is
  set by the **least-similar predefined pair** (the worst known-same pair defines the bound of "the
  same"). Often too strict — may recover only the pairs you already declared.
- **Loose assessment line:** raised until no predefined pair stands alone — every cluster it defines
  must contain **at least two** of the known pairs. This is where real **between-site** grouping appears.
- The lines are **reproducible constructs, not proofs** — anyone with the same design redraws them
  identically; the resulting groups can then be **linked to metadata**. Same honest stance as coenosr's
  "Reproducible, Not Proven" and whittakerr's "a map is an argument" — the recurring through-line of
  Kim's work: we draw the boundary; the value is reproducibility and honesty, not proof of natural kinds.
- Within/between variability framing (general, not strictly statistical): replicate pairs fix the
  within; the loose line characterises the between. Kim: "Most people don't think about paired sites."
  The document plants that seed.

## Design decisions (2026-06-15)
- **Stand-alone**, no coenosr dependency; carries its own small function set, like the 2022 original.
- **Running example: the fish-market toy** (decided 2026-06-15). Fish stalls × fish/shellfish types —
  a small, intuitive list with natural clusters (shellfish stalls 1–3 vs finfish stalls 4–6, plus a
  mixed Stall7 that lands ambiguously — good honest material). Designed so one stall lists six items,
  to exercise the generalised reader. Carries the foundation chapters. The 7-stall ragged data string +
  the verified two-way table are in `lists_functions_clean.R`'s session run (session_log 2026-06-15).
- **The assessment-line dataset (later): backyard gardens across a community, tagged by cultural
  identity** (SE Asian, Nordic, Italian, …) in one climate zone — "how do different groups exploit the
  same climate?" This is *built* for the method: cultural identity = predefined categories, replicate
  gardens within a culture = the replicate pairs that anchor the lines, and culture + climate = the
  metadata to hang on the groups. **Kim to gather/define this richer dataset; the assessment-line
  chapters wait on it.**
- Terminology: the cleaned code uses **"item"** (vs the 2022 "species") for generality across markets,
  gardens, fish, etc. **OPEN — Kim to confirm item vs species.**
- Each dataset must be **designed with predefined replicate pairs** (e.g. ~3–4 categories × 2 replicate
  sites + the items) or the assessment lines have nothing to anchor to. The replicate-pair design is
  the substance; the clustering is easy.
- Honesty option: choose the two datasets so one clusters crisply and the other is messier — teaches
  the reader to *read* a dendrogram (pattern clear / messy / absent), echoing coenosr Ch 7.
- "Neat, not too long," code-fold, the workflow shown as legible named steps.

## Chapter spine (2026-06-15, Kim-affirmed — "matches mine exactly")
1. **Preface** — the frozen-data problem and the missing conceptual model.
2. **Getting the data in** — ragged entry, `read_lists`, confirm; the low-friction argument.
3. **A first look** — frequency scans; quick, in-the-field, not frozen.
4. **The two-way table** — the hinge; presence/absence is enough.
5. **Dendrograms** — what they show, how to read one, the caution about "finding" clusters.
6. **The choices that shape a tree** — the linkage chapter, framed as **two** choices (distance +
   linkage). Different choices give different trees from identical data → the "reproducible construct,
   not proof" stance; also explains why the 2022 item tree (complete linkage) and site tree (single)
   looked different.
7. **Linking metadata** — the coenosr "Reason for Groups" echo: attach external attributes to clusters
   read from the tree (or a plain `cutree`), noting that the *principled* grouping is the assessment-line
   method, deferred. (Metadata first shows *why* you want groups; assessment lines later make the
   grouping reproducible.) **Fish-toy metadata (Kim, 2026-06-15):** owner culture by surname —
   **Japanese → the finfish stalls, Filipino → the shellfish stalls, Hawaiian → the mixed stall** —
   plus a **locally-caught vs imported** field. Owner culture is external to the fish list, so the
   clusters can be *corroborated* by it (the external-evidence move). **Cod** — revised 2026-06-15 to
   appear at only Stall4 (dropped from Stall5 at Kim's suggestion; within-stall item order also
   randomised, which leaves the analysis identical) — is a natural **"imported"** flag, a clean lone
   item that stands apart from the two main groups. Data change re-verified live: both dendrograms keep
   their shape.
8. **(later) Assessment lines** — strict/loose, replicate-pair design, on the backyard-gardens data.

## Materials we have
- **`lists_2022_original.qmd`** (preserved in this project folder) — Kim's 2022 source: ragged entry,
  `read_lists` / `species_list` / `species_freq_plot` / `site_freq_plot` / `data_to_2way` /
  `species_dendrogram` / `site_dendrogram`, on a 5-farm vegetable-garden toy. Does **not** yet include
  the assessment-line interpretation — that is the genuinely new content.
- `lists.pdf` — the rendered 2022 output, **password-protected** (Claude could not open it). Kim to
  provide an unlocked copy if the rendered figures are needed.
- **`lists_functions.R`** — now gathered into the project folder. The 2022 functions: `read_lists`
  (`read.table` on the comma text → wide `Site` + `spp1..N`), `species_list`, `species_freq_plot`,
  `site_freq_plot`, `data_to_2way` (→ binary species×sites), `species_dendrogram` (binary distance,
  default/complete linkage) and `site_dendrogram` (transpose, binary distance, **single** linkage, with
  NaN guards). Robustness notes for the stand-alone rebuild: several functions **hard-code
  `cols = c(spp1,spp2,spp3,spp4,spp5)`** (assumes ≤5 items per site — generalise to all `spp*` columns);
  the two dendrograms use **different linkage** (complete vs single — standardise); the dendrogram
  functions read `data_source` and `dendro_theme` as **globals** (pass them in). `dendro_theme` is
  defined in the qmd. None of this is the new content — the **assessment-line** functions are.
- **`lists_functions_clean.R`** — the rebuilt, generalised functions (verified live on the fish toy
  2026-06-15): `read_lists` (whitespace-stripped, any number of items), `to_long`, `item_list`,
  `data_to_2way`, and one unified `make_dendrogram(what = "item"/"site", dist_method, linkage)` with
  distance + linkage as explicit arguments + `dendro_theme`. Frequency-plot functions
  (`item_freq_plot`, `site_freq_plot`) now rebuilt + verified live and in the file (Ch 3). Also `two_way_plot` (presence/absence
  tile picture) added + verified live. Built so far: Preface, Ch 2 (getting data in), Ch 3 (a first
  look), Ch 4 (the two-way table — gt grid + tile picture), Ch 5 (measuring similarity — dissimilarity
  matrix + heatmap). **Functions split (2026-06-15):** `make_dendrogram` refactored into
  `dissimilarity()` + `dendrogram_plot()` (plus `dissimilarity_plot()` heatmap), so the matrix is a
  visible step (`make_dendrogram` kept as a one-call wrapper). **Spine re-split** (per Kim): Ch 5 =
  Measuring similarity, Ch 6 = The dendrogram; the old Ch 6–8 (choices/linkage, metadata, assessment
  lines) shift to 7–9. **Built so far (by name):** Preface, Getting the data in, A first
  look, The two-way table, Measuring similarity, **The dendrogram** (both stall + item trees from
  `dendrogram_plot`, how to read a tree, the honest cluster caution, and the two-choices preview).
  Rendered numbering: the Preface is unnumbered, so those five chapters are Ch 1–5; the next chapter
  will render as Ch 6. **The choices that shape a tree — DONE** (`choices.qmd`): distance (Jaccard,
  the quiet choice) + linkage (the loud one); a four-panel patchwork of the stall tree under
  single/complete/average/ward shows the grouping is robust but the ruler is not (Ward runs on its
  own scale; the items' fine structure does reshuffle). Working test stated: trust what survives a
  change of choices. Closes pointing to the metadata + assessment-line chapters.
  **Kim's dendrogram story (early-1970s software *told* to make two groups, then read as if the
  groups were found) — OFFERED to weave into the book in his voice; awaiting his go-ahead and
  preferred home (fits "The procedure, not the picture" here, or the assessment-line chapter).**
  **Linking metadata — DONE** (`metadata.qmd`): stall communities corroborate the tree (cut into three,
  the groups *are* the three heritages); Cod the lone imported item cuts across; new helper
  `dendrogram_meta_plot()`. **Assessment lines — DONE** (`assessment_lines.qmd`), on Kim's **real Madison,
  WI produce data** (the gardens idea was dropped in favour of this): months as sites, fresh/storage as
  metadata; the **most-variable-site cut** (`recruit_heights()` + `assessment_cut()`) gives four
  data-seasons (line A) or five (line B, May the oddball); fresh/storage gradient confirms; an "order is
  not similarity" rotation note added. **Function-reference appendix** + **source acknowledgment**
  (thespruceeats.com) in. **Engine extracted into the `listsr` package** (proj_listsr.md) — installed,
  checked, pushed to github.com/kimbridges/listsr. **Spine COMPLETE in draft** (Preface + 9 chapters +
  appendix). **Next:** wire chapters from `source("lists_functions_clean.R")` to `library(listsr)`
  (task #29); then full render + read-through + deploy to kimbridges-documents. (Kim's early-1970s
  dendrogram story — dropped 2026-06-16, Kim: "doesn't add anything.")
  **PUBLISHED 2026-06-16** — chapters wired to `library(listsr)`; Kim's careful read-through passed
  ("the arguments hold; the balance is just right"); fixed the only snag (two metadata-chapter previews
  + the dendrogram caution that still described the old paired-replicate design → the most-variable-site
  rule); cover (Nakamura Fish, Stall #6) + navbar logo added, both authors credited. **LIVE at
  https://kimbridges-documents.netlify.app/lists/** — the sixteenth document. Deploy used the new
  R-`file.copy` of `_output/` contents (no nesting; "a very clean procedure now"). Companion package
  **listsr** also live on GitHub. The lists project is delivered end to end (document + package).
  Optional, for later (Kim, 2026-06-16): a listsr vignette — **reframed** to point readers to the
  published `lists` document rather than duplicate it. **Dropped:** the early-1970s dendrogram story
  ("doesn't add anything") and a navbar-logo crop (the logo fits as is).

## Locations
- Project folder: `G:\My Drive\Projects\lists\` (code/document home, per the storage architecture).
- Published-document home: **TBD** — likely a sibling in kimbridges-documents (the clustering
  counterpart to coenosr), but not decided.

## Next Steps
1. **Design the two example datasets around their replicate pairs** (the substance — everything hangs
   off this).
2. Gather/rebuild the workflow functions stand-alone (read / confirm / frequency / two-way /
   dendrogram), and **add the assessment-line functions** (strict + loose cut driven by the predefined
   pairs) — the new code.
3. Draft the document: the workflow run twice + the assessment-line interpretation + the
   experimental-design framing + the honest "constructs, link to metadata" close.
4. Decide the home and (later) deploy.

## Collaborators / Dependencies
None (stand-alone by design). Conceptual kin: `coenosr` (the two-way-sorting path) and `whittakerr`
(the map-as-argument theme).

## Blockers
None.

---
## Log

### 2026-06-15 (project opened)
Grew out of a coenosr reflection: the simple **use of lists** hidden inside the recovery story. Kim's
framing — we constantly make lists (he photographs entire markets) and the data then sits frozen,
unused, for lack of a conceptual model of "what next" and because data-entry friction kills it.
coenosr showed one path (two-way sorting → differential groups); the **dendrogram** is the other.
Decided: a stand-alone, neat, hands-on demonstration running the same workflow on two different
problems. Kim then added the key methodology from *Island Ecosystems*: **assessment lines** anchored
by **replicate-pair experimental design** (strict line = the bound of "same," set by the least-similar
known pair; loose line = clusters each holding ≥2 known pairs; within/between variability; constructs
not proofs; groups link to metadata) — which **reframes** the piece from "what to do with data" into
"careful experimental design is what gets real value from data." Materials preserved (the 2022
`lists.qmd` → `lists_2022_original.qmd`); the rendered PDF is password-protected; the functions live at
`C://My_Functions/lists/lists_functions.R`. Active R Projects row added to project_index.md; Active
Focus updated. See session_log.md 2026-06-15.

### 2026-06-15 (cont.) (way forward agreed; code cleaned + verified live; datasets decided)
Kim's plan (which "matches mine exactly"): build the working pipeline as chapters, make the **linkage
varieties their own chapter**, then a **metadata** chapter (coenosr echo); the **assessment-line**
chapters come later, on richer data. Decisions: **running example = the fish-market toy** (stalls ×
fish/shellfish; two clean clusters + a mixed ambiguous stall; one 6-item stall to test the generalised
reader); **the assessment-line dataset = backyard gardens by cultural identity** in one climate zone
(Kim's idea — predefined categories + replicate gardens + culture/climate metadata; Kim to gather).
Rebuilt the 2022 functions generalised + verified live in Kim's R session (`lists_functions_clean.R`):
6-item stall handled, whitespace stripped, one `make_dendrogram` with explicit distance + linkage;
both fish dendrograms produced and read correctly (finfish vs shellfish; Stall7 ambiguous). 8-chapter
spine recorded above. Open: item vs species naming. Next: build Chapters 2–5 on the fish toy. See
session_log.md 2026-06-15.

### 2026-07-28 (header field repaired)
`_Status:` held free text ("PUBLISHED 2026-06-16 (live at ...)") instead of a
vocabulary value, so this project was invisible to every status sweep. Set to
**Complete / Not applicable** per the published-is-Complete default. The URL is
already recorded in Locations and Current Status.
