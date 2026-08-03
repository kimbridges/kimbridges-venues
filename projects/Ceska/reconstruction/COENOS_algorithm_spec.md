# COENOS (1991) — Algorithm & Format Specification

_Reconstruction working document. Drafted 2026-06-11 from the preserved
Ceska artifacts (`COENOS.EXE`, `HELP.CNS`, the `.REL` inputs, the `*_table`
outputs, and the `.S00` quick-restart files)._

**Purpose.** A precise, implementation-ready description of what the 1991
COENOS program does, so its functionality can be reconstructed in R without
the original Pascal source. This is the specification phase of the Ceska
"lost technology" recovery (see `proj_Ceska.md`).

**Confidence convention.** Each claim is tagged:

- **[DOC]** — stated explicitly in `HELP.CNS`.
- **[OBS]** — inferred from the preserved input/output/`.S00` examples and
  cross-checked across the three datasets (DIEREN, ELLEN, SET1).
- **[OPEN]** — not yet pinned down; must be resolved empirically in the
  validation phase (collected in §8).

---

## 1. What COENOS is

COENOS is an automated **Braun-Blanquet table-sorting** program: it turns a
raw species × relevé matrix into a structured phytosociological table in
which **differential species groups** and the **relevé groups** they
characterise are made visible. It is the computational form of the manual
table-rearrangement a phytosociologist performs by hand. **[DOC/OBS]**

Methodological placement: it shares reciprocal averaging (correspondence
analysis) with TWINSPAN, but it is **not** TWINSPAN. It forms groups by
explicit "inside/outside" frequency rules rather than by polythetic division
on pseudospecies, and cover values play **no** role in grouping. No current R
package reproduces this exact procedure — which is what makes the
reconstruction worth doing. **[OBS]**

The program is interactive (DOS, EGA/VGA, F-key / Alt-key driven, hand-sort
stage with a movable cursor). The reconstruction targets the **batch
computational core** — trim → group → order → tabulate — not the interactive
hand-sort UI, which can be replaced by reordering arguments. **[OBS]**

---

## 2. Input format — the relevé file (`.REL`)

An ordinary ASCII text file; relevés read sequentially. **[DOC]**

```
BILL01                  <- relevé code (header line)
CARE LYNG 5             <- "GENU SPEC <cover>"  (4 + space + 4 + space + 1)
ELEO PALU 2
LILA OCCI +
...
$                       <- end-of-relevé marker, on its own line
BILL02
...
$
$                       <- trailing lone $ closes the file (OBS, DIEREN/ELLEN)
```

Rules:

- A relevé listing **starts with a relevé code**; codes may be any length and
  any alphanumeric characters, but **only the rightmost 6 characters are
  read**. **[DOC]**
- **One species per line**, abbreviated as four letters of genus + four of
  species, followed by a **one-character cover estimate**. **[DOC]**
- Reading is **case-sensitive** (`CARE AQUA` ≠ `CARE aqua`). **[DOC]**
- Species abbreviations **without** a cover estimate are ignored. **[DOC]**
- If a species appears twice in one relevé, the **last** cover value wins.
  **[DOC]**
- End of each relevé is a **`$` on a line by itself**. **[DOC]**
- Lines containing `&&` are comments and ignored. **[DOC]**
- The species name field is effectively 8 characters in two 4-char tokens.
  Note real-data quirks preserved in the examples: a trailing-digit "species"
  token (`SPEC 380` in DIEREN), an `x` inside a genus token (`POAx PRAT`), and
  a `?` inside a species token (`SCIR CER?`). The parser must treat the
  genus+species as an **opaque 8-character key**, not validate it as a Latin
  binomial. **[OBS]**

### 2.1 Cover scales

Two distinct cover vocabularies appear and the reader must accept both:

- **Braun-Blanquet symbolic** (DIEREN, ELLEN): `5 4 3 2 1 + R` (and the help
  text implies any single alphanumeric character is legal). Rank order, high
  to low: `5 > 4 > 3 > 2 > 1 > + > R`. **[OBS]**
- **Numeric** (SET1, the `.DAT` family): integer cover values `1`–`7` observed
  (`OPLE HIRT 7` in Set1_table). Likely a 1–9 numeric / Domin-style scale.
  **[OBS]**

Because cover is **stored for display but not used in grouping** [DOC], the
cover value can be carried as an opaque ordered factor; only its display
ordering matters, not its numeric meaning.

### 2.2 The binary `.DAT` inputs **[OPEN]**

`SET1.DAT`, `Set2.dat`, `Set3.dat` are **not** ASCII (Read rejects them as
binary). Set1_table is their decoded output, so the data exists in a packed
form. Decoding the `.DAT` layout is deferred to the validation phase; the
text `.REL` format above is the primary input target and is sufficient to
reconstruct and validate the full algorithm on DIEREN and ELLEN.

---

## 3. The constancy concept and the two thresholds

**Constancy** of a species = the number (or %) of relevés in the data set in
which it occurs. **[DOC]**

Two different cutoffs operate at two different stages — do not conflate them:

1. **Group-formation eligibility [DOC, §.302].** Species are **excluded from
   group testing** if their constancy is **> 66%** (too ubiquitous to be
   diagnostic) **or** they occur in **fewer than 3 relevés** (too rare to
   define a group).
2. **Table-display threshold [DOC, §.305].** Species with **fewer than four
   occurrences** are "not usually included in the table" and are instead
   listed in the **low-constancy footnote**. **[OBS]** In the examples the
   footnote collects species occurring in **1 or 2** relevés; species with 3
   occurrences appear in the body. The exact body/footnote boundary (≤2 vs <4)
   must be confirmed empirically — see §8. **[OPEN]**

A special display mode: if **no groups are formed**, the raw table is shown
with **all** species ordered by **decreasing constancy**, and low-constancy
species are then included. **[DOC, §.305]**

---

## 4. Group formation — the core algorithm

This is the novel, must-reproduce-faithfully part.

### 4.1 The inside/outside percentage rules **[DOC, §.302]**

Each candidate **species group** is paired with a **relevé group**. Two
tunable percentages govern membership — an **inside** percentage `X` and an
**outside** percentage `Y`:

- **Rule I (species test).** Every species in the species group must occur in
  **at least `X`%** of the relevés that form the corresponding relevé group,
  **and in no more than `Y`%** of the relevés **outside** that relevé group.
- **Rule II (relevé test).** Every relevé in the relevé group must contain
  **at least `X`%** of the species that form the corresponding species group.

Cover values are **not** used here. **[DOC]**

The three default `X/Y` pairs are **40/10, 50/20, 66/33**; the user may set
custom pairs. **[DOC, §.302]** These three labels appear verbatim as the
group-block headers in every output table. **[OBS]**

### 4.2 Iterative group building **[DOC, §.301/§.303]**

- Groups are grown **iteratively from an initial species**; the help text
  refers to "no. of iterations needed for group formation" as a reported
  per-group statistic. **[DOC]** The precise seed-selection and growth/refine
  loop (how the initial species is chosen, how members are added/removed until
  Rules I & II hold for all members) is the central **[OPEN]** to reverse-
  engineer from the data.
- For each seed, **groups are formed under all three `X/Y` combinations** and
  presented together; they share the same initial species. **[DOC, §.301]**
- **Automatic selection [DOC, §.303]:** the "best" group is the one with the
  **largest number of species**. **Groups with fewer than 4 species are not
  considered.** Ties / criteria beyond max-species are unspecified — **[OPEN]**.
- Manual mode lets the operator pick group 1/2/3, skip (0), switch to auto
  (5), or stop forming groups and go to ordination (7). The reconstruction
  replaces this with automatic selection by default, with hooks to override.
  **[OBS]**
- **Maximum 60 groups; only the first 16** are carried into relevé grouping
  and reciprocal averaging. **[DOC, §.301]**

### 4.3 Per-group reported statistics **[DOC, §.301]**

For each formed group COENOS reports: iterations to form (lower = better),
number of species, number of relevés, **block size**, **% positive entries**
in the block, and the **mean relevé similarity within the block** (Sørensen
coefficient). The reconstruction should compute these both as validation
checks and as the basis for "best group" selection. **[DOC]**

Sørensen similarity between two relevés = `2c / (a + b)`, where `a`, `b` are
the species counts of each relevé and `c` the shared count. (Cover-independent,
consistent with grouping using presence/absence.) **[OBS]**

---

## 5. Ordering — reciprocal averaging **[DOC, §.601]**

After groups are formed, COENOS builds a **simplified table of species groups
× relevé types** and runs **reciprocal averaging (RA)** on it — classic
correspondence-analysis iteration: assign scores to rows, derive column scores
as weighted averages, re-derive row scores, iterate to convergence, then order
rows and columns by their first-axis scores. The result is the **"asterisk
table."** **[DOC]**

- RA operates on the **reduced** table (groups, not individual species), then
  the full species/relevé orderings are induced from the group ordering. **[OBS]**
- Convergence criterion, normalisation, and tie handling are **[OPEN]**;
  standard RA (e.g. Hill 1973) is the reconstruction starting point, to be
  tuned until the example orderings reproduce.
- The interactive hand-sort stage (move groups, rerun RA via F1, delete/insert
  groups) is **out of scope** for the batch core but its *result* — the final
  ordering — is what the `*_table` and `.S00` files record.

---

## 6. Output format — the printed/saved table (`*_table`)

A fixed-width ASCII table (same format whether printed or saved). **[DOC, §.503]**
Layout, confirmed identically across DIEREN, ELLEN, SET1 **[OBS]**:

1. **Column header block.** Relevé codes printed **vertically**, one character
   per row, across the top — in the **final RA-sorted relevé order**. (DIEREN
   columns read `BILL 06 11 13 14 16 15 04 05 07 08 09 10 12 01 03 02 17 18`.)
2. **Differential species groups**, top to bottom, each preceded by its
   **`X/Y` label** (`40/10`, `50/20`, `66/33`) and bracketed by **dashed
   marker rows** above and below. Within a group, the **member relevés** are
   flagged by dashes positioned over their columns. Species within a group are
   listed together; each cell shows the species' **cover value** in that
   relevé (blank if absent). A dataset can contain **several groups at the same
   `X/Y` level** (ELLEN has two distinct 40/10 blocks). **[OBS]**
3. **A blank line, then the high-constancy companion species** (the >66%
   ubiquitous ones excluded from grouping), ordered by **decreasing
   constancy**. (DIEREN: POTE PACI, PLAN LANC, … ELLEN: ARRH ELAT, DACT GLOM,
   GALI MOLU, POA PRAT, …) **[OBS]**
4. **Remaining body species** (in groups' "leftover" order / decreasing
   constancy) below that. **[OBS]**
5. **`Species with low constancy:` footnote** — the sub-threshold species,
   each listed with its occurrences as `CODE (RELEVÉ: cover, RELEVÉ: cover)`.
   **[DOC, §.305 / OBS]**

The **group marker character** (default `-`) and whether the `X/Y`
percentages print are user options. **[DOC, §.XXX]**

---

## 7. The `.S00` quick-restart file — a validation oracle **[OBS]**

The `.Snm` files (renamed `-------.S00` for the canonical kept variant) store
the **complete solved state** for instant reload. **[DOC, §.702]** This makes
`DIEREN.S00` / `ELLEN.S00` / `SET1.S00` **machine-readable ground truth** —
far stronger than diffing the printed table. Partial decode of `DIEREN.S00`:

- **Line 1:** source file name(s); **line 2:** save date & time. **[DOC]**
- **Header integers:** `18` (relevés), `116` (species), then sizing/counters
  (`125, 4, 4, 7`) and a boolean. **[OBS]**
- **Per-relevé block:** relevé code + 4 integers. The **first integer = the
  relevé's species count** (verified: BILL01→10, BILL02→9, BILL03→7,
  BILL04→44, all match the `.REL`). The remaining three encode
  position/grouping state. **[OBS]**
- **Per-species block:** 8-char species key + integers including its
  **constancy** and a **role code**: positive values mark differential-group
  membership; `-1`/`-2` mark high-constancy companions (e.g. `POTEPACI … -2`,
  the ubiquitous one); `-3` marks low-constancy/excluded species (the footnote
  set). Exact code semantics to be finished in validation. **[OBS/OPEN]**
- **Threshold list:** `40 10 50 20 66 33` appears verbatim. **[OBS]**
- **Trailing ordering vectors:** the **final relevé order** appears as an
  explicit index list at the end (`6 11 13 14 16 15 4 5 7 8 9 10 12 1 3 2 17
  18`) — **identical to the printed column order**, confirming the `.S00`
  encodes the exact solution. A species-ordering vector is likewise present.
  **[OBS]**

**Reconstruction leverage:** decode `.S00` fully and validation becomes exact
set/vector comparison — species role codes, group memberships, and both
orderings — rather than visual table matching.

**→ Done for DIEREN (2026-06-11).** The full per-species role codes, the four
group-membership lists with internal order, and the relevé display-order
vector are decoded and verified in `DIEREN_S00_format.md`; the per-species
oracle is `dieren_s00_species.csv`; the cross-check is `decode_check.py`. Next
apply the same decode to `ELLEN.S00` and `SET1.S00`.

---

## 8. Open questions for the validation phase

Collected `[OPEN]` items, in rough priority order:

1. **Group-growth loop — RESOLVED to the method level (2026-06-11)**; see
   `form_groups_notes.md`. The method: per-group **seeded alternating
   refinement** at three X/Y levels — grow `S` by Rule I, grow `R` by Rule II,
   iterate to a fixpoint. Rounding pinned (Rule II / Rule I-low `floor`; Rule
   I-high `ceil(Y*n/100)`, total-n base). The `.S00` per-group metadata gives
   each group's seed, level, size, and iteration count; the refinement from the
   decoded seeds reproduces every **relevé group exactly** and converges in the
   recorded iterations. The **only** residual is the tie-break that assigns ~4
   genuinely between-community species among overlapping groups — and the
   cover/RA bulk decode showed the `.S00` stores only the cover matrix, so that
   tie-break is **not recoverable** from the preserved artifacts (it lived in
   the lost source). Behavioural inference floors at ~45/49. Treated as a
   bounded, non-recoverable implementation detail, not a method gap.
2. ~~**Body vs footnote boundary.**~~ **RESOLVED 2026-06-11** (DIEREN.S00
   decode): the split is **constancy < 3 → footnote**, ≥ 3 → body. The
   `HELP.CNS` "< four occurrences" prose is looser than the program's actual
   behaviour. See `DIEREN_S00_format.md` §4.2.
3. ~~**"Best group" tie-breaking / the −1/−2 companion split.**~~
   **PARTLY RESOLVED 2026-06-11** (ELLEN+SET1 decode): the grouping-eligibility
   **ceiling is the integer ⌊2n/3⌋** — a species with constancy ≥ ⌊2n/3⌋ is
   excluded from grouping (role −2 super-companion); verified across n =
   18/25/63. Note this is **floor**, not "> 66%": ELLEN excludes a 16/25 (64%)
   species. Still open: tie-breaking *among candidate groups* beyond
   max-species. See `ELLEN_SET1_S00_decode.md` §2.1.
4. ~~**RA specifics.**~~ **RESOLVED for the relevé ordering 2026-06-11**
   (`ordering_notes.md`): RA = correspondence analysis on the species-group ×
   relevé-**type** asterisk table; order relevés by (axis-1, axis-2 tie-break,
   relevé number), empties last. Reproduces the DIEREN and ELLEN `.S00` relevé
   vectors exactly. Axis **sign** is the one convention (CA is sign-arbitrary —
   reflected table is identical; candidate rule: tightest-level extreme group
   leads). Species ordering (analogous) still to do.
5. ~~**Multiple groups per `X/Y` level.**~~ **RESOLVED 2026-06-11**: confirmed
   and characterised — ELLEN forms 4 groups at 40/10 + 1 at 50/20; SET1 forms
   2 groups both at 40/10. The engine must support N groups per level; the
   group id is formation order and the level is recorded per group. 40/10 is
   by far the most productive level across all three datasets. See
   `ELLEN_SET1_S00_decode.md` §2.2.
6. ~~**`.S00` role-code semantics.**~~ **RESOLVED 2026-06-11**: per-species
   role code fully decoded (positive = group id; −1 companion; −2
   super-companion >66%; −3 low-constancy/footnote), group-membership lists
   and the relevé display-order vector decoded and verified. Remaining `.S00`
   undecoded fields (the cover/RA bulk, the c2 index, header counters 125/7)
   are not needed for validation. See `DIEREN_S00_format.md`.
7. ~~**Binary `.DAT` format.**~~ **RESOLVED 2026-06-11:** `SET1.DAT` is not
   binary — it is a relevé file in the same format as `.REL`, with CRLF line
   endings and the numeric (1-7) cover scale. `read_rel()` reads it directly
   (63 relevés, 43 species, 0 constancy mismatches vs the oracle). Bundled in
   the package and covered by tests. Presumably `Set2.dat`/`Set3.dat` are the
   same format.
8. **Reproduce the runtime** — record the emulator (DOSBox is the near-certain
   identity given the DOS/EGA/Alt-key profile; the `DIEREN.S00` timestamp of
   29 Apr 2026 confirms it still runs) so fresh COENOS runs can generate
   unlimited new validation cases.

---

## 9. Reconstruction shape (for reference)

A natural R decomposition, each piece independently testable against the
oracle:

1. `read_rel()` — parse `.REL` → tidy long table (relevé, species key, cover).
2. `read_coenos_table()` / `read_s00()` — load the ground-truth outputs as
   structured objects for comparison.
3. `constancy()` + trimming — the two thresholds of §3.
4. `form_groups()` — the §4 inside/outside engine (the hard core).
5. `reciprocal_averaging()` — §5 ordering.
6. `coenos_table()` — assemble and print the §6 layout.
7. A validation harness diffing (4)/(5) against the `.S00` vectors and the
   `*_table` text for DIEREN, ELLEN, SET1.

This mirrors the bbstruct cluster's intent: a faithful COENOS port becomes the
**validation backbone** for the modern Braun-Blanquet tools, rather than being
folded into them.
