# PROJECT: Ceska
_Last updated: 2026-07-26_
_Status: Active_
_Focus readiness: Ready_

## Type
Historical-software reconstruction (1991 vintage)

## Objective
Reconstruct the vegetation analysis methodology embodied in the
1991 COENOS program — a compiled Pascal tool for Braun-Blanquet
style numerical phytosociology, associated with the work of
Adolf Ceska. The 1991 code still runs (or did, on its native
platform) but its source is lost or unavailable, and the
methodology it operates can no longer be inspected by reading
the code. The project's purpose is to recover the methodology
in modern R — using the bbstruct, bbSynth, and Braun_Blanquet
projects as the reconstruction toolkit — so that what COENOS
did can be done again, this time legibly.

This is a "lost technology" recovery effort. The artifacts are
preserved here as the historical reference; the modern
implementation lives in the rest of the Braun-Blanquet cluster.

## Current Status
**Active reconstruction begun 2026-06-11** (Kim's chosen Active Focus).
The 1991 COENOS resources were read and decoded end to end —
`HELP.CNS`, the `.REL` inputs, the `*_table` outputs, and the `.S00`
quick-restart files (DIEREN, ELLEN, SET1) — and a precise
implementation-ready **algorithm & format specification** was written:
`G:\My Drive\Projects\Ceska\reconstruction\COENOS_algorithm_spec.md`.
Every claim in the spec is tagged [DOC] (stated in HELP.CNS), [OBS]
(inferred and cross-checked across the three datasets), or [OPEN] (to
resolve empirically in the validation phase).

Two findings from the spec work: (1) the `.S00` files are a
**machine-readable validation oracle** — they store COENOS's complete
solved state, not just the printed table; the trailing relevé-ordering
vector in DIEREN.S00 was confirmed identical to the printed column
order, and each species carries a constancy plus a role code (positive
= differential-group member, -2/-1 = ubiquitous companion, -3 =
low-constancy). (2) Everything except the iterative group-growth loop
(spec §4.2 — seed-and-grow until Rules I & II hold) is documented or
standard; that loop is the single hard reverse-engineering target, and
DIEREN's known groups are the case to crack it against.

The working folder at G:\My Drive\Projects\Ceska\ still preserves the
historical artifacts (the executable + Data/); the reconstruction now
lives in the new `reconstruction/` subfolder there. The faithful
COENOS port is framed as the **validation backbone** for the
Braun-Blanquet cluster (bbstruct/bbSynth/Braun_Blanquet) rather than
being folded into it.

## Locations
- Historical code: G:\My Drive\Projects\Ceska\1991_Coenos_code
- Example data: G:\My Drive\Projects\Ceska\Data
- GitHub: not yet (and unclear whether the 1991 binary should
  be pushed publicly even if it could be — preservation may be
  better handled inside the PKM than in a public repo)

## Key Files
- 1991_Coenos_code/COENOS.EXE — the 1991 compiled Pascal
  executable (the "lost technology" itself)
- Data/ELLEN.REL — Ellenberg relevé set in COENOS format
- Data/DIEREN.REL — Dieren relevé set in COENOS format
- Data/SET1.DAT, Data/Set2.dat, Data/Set3.dat — additional
  example datasets
- Data/ELLEN.S00, Data/DIEREN.S00, Data/SET1.S00 — state /
  session / intermediate files from COENOS runs
- Data/HELP.CNS — COENOS help file
- Data/Ellen_table, Data/Dieren_table, Data/Set1_table — table
  outputs produced by COENOS on the example data
- reconstruction/COENOS_algorithm_spec.md — the
  implementation-ready algorithm & format specification (2026-06-11);
  the foundation document for the R reconstruction

## Related Projects — Braun-Blanquet Cluster

The Braun-Blanquet cluster:

- **Ceska** (this file) — 1991 COENOS code and example data;
  the historical reference whose methodology is being
  reconstructed.
- **coenosr** (proj_coenosr.md, new 2026-06-11) — the **faithful R
  reconstruction** of COENOS implementing this project's spec; the
  validation backbone. `read_rel()` shipped and validated against the
  decoded `.S00` oracles. This is where the reconstruction code now lives.
- **bbstruct** — modern R package for structural analysis of
  Braun-Blanquet tables. The active reconstruction lives here
  and in bbSynth. See `proj_bbstruct.md`.
- **bbSynth** — synthetic-data generator producing the test
  cases the reconstruction is validated against. See
  `proj_bbSynth.md`.
- **Braun_Blanquet** — Quarto multi-chapter document explaining
  the method and demonstrating the modern toolkit. See
  `proj_Braun_Blanquet.md`.

The Ceska artifacts are the ground truth: when bbstruct produces
a table on one of the example .REL datasets, the test is whether
the result matches what COENOS produced (preserved in the
`*_table` outputs). When it does, that piece of the methodology
has been recovered.

## Next Steps
_Spec phase complete 2026-06-11. Remaining work, in rough order
(full [OPEN] list is in spec §8):_

1. ~~Fully decode `DIEREN.S00`.~~ **DONE 2026-06-11.** Per-species
   role codes, the four group-membership lists (with internal order),
   and the relevé display-order vector decoded and verified. Outputs in
   `reconstruction/`: `DIEREN_S00_format.md` (format), `dieren_s00_species.csv`
   (per-species oracle), `decode_check.py` (cross-check, all pass). Resolved
   two spec open-questions (body/footnote boundary = constancy < 3; the
   `.S00` role-code semantics). **ELLEN.S00 + SET1.S00 also decoded
   2026-06-11** — three validation oracles now in hand; resolved two more
   open-questions (the ⌊2n/3⌋ super-companion ceiling; multiple groups per
   level). See `ELLEN_SET1_S00_decode.md` and `{ellen,set1}_s00_species.csv`.
2. Build `read_rel()` in R — parse `.REL` to a tidy long table
   (relevé, 8-char species key, cover), handling both cover scales
   and the real-data quirks (SPEC 380, POAx, SCIR CER?).
3. Reverse-engineer the group-growth loop (spec §4.2) against
   DIEREN's known groups — the algorithm's hard core.
4. Implement reciprocal-averaging ordering (spec §5) and tune to
   reproduce the DIEREN/ELLEN orderings.
5. Assemble the `*_table` output layout (spec §6) and stand up the
   validation harness diffing against the three `.S00`/`*_table`
   ground-truth pairs.
6. Decode the binary `.DAT` format (SET1/2/3) — deferred; `.REL`
   is sufficient to validate the full algorithm first.
7. Reproduce/record the emulator runtime (almost certainly DOSBox;
   DIEREN.S00 is timestamped 29 Apr 2026, so it still runs) to
   generate fresh validation cases on demand.
8. Document the 1991 methodology and the recovery process in the
   Braun_Blanquet Quarto document.

## Collaborators / Dependencies
- bbstruct (the modern reconstruction)
- bbSynth (the validation-data generator)
- Braun_Blanquet (the explanatory document)

## Blockers
None. The reconstruction work proceeds in the sibling Projects;
this folder is the reference.

---
## Log

### 2026-07-26 — A print edition, for Adolf
The recovery went out to the man whose method it is. Adolf Ceska has not been answering
email or checking Facebook, so Kim asked for a **paper edition** of the coenosr document
to post to him. Built from the published site (technique in proj_coenosr.md): **47 pages,
US Letter, full-bleed cover, contents with real page numbers, every web address spelled
out in full so it stays usable on paper.** Kim trial-printed it and confirmed the layout
preserves the intent; he writes the covering note himself.

Kim's reason for it is the part to remember: "it shows that we try to respect people who
have made contributions and to do this in a way that they can accept what we give them."
The 1991 method was Adolf Ceska and Hans Roemer's work. Recovering it was the technical
act; putting it in Adolf's hands in a form he can receive is what makes the recovery
complete.

### 2026-06-15 (cont. 6) (PUBLISHED — the recovery is delivered end to end)
The coenosr document is **live** at https://kimbridges-documents.netlify.app/coenosr/ (fifteenth
document in the collection), and the coenosr package's updated toy data is pushed to GitHub. Deploy
hit one nesting gotcha (the render got copied as `coenosr/_output/` → 404 + missing cover); fixed by
flattening the folder and re-rendering the site, and the trap is recorded in
proj_kimbridges_documents.md. **The project's stated objective is met:** the 1991 COENOS method is
recovered (faithful R engine on GitHub) and made legible again (the companion book, published). Kim:
"such a good achievement for both of us." Optional leftovers only: the Ch 9 first-person enrichment.

### 2026-06-15 (cont. 5) (deploy prep; render/push/drag are Kim's manual steps)
Kim called the document done and asked to deploy to kimbridges-documents + push coenosr to GitHub.
**Constraint found:** the r-studio bridge cannot run system commands ("security restriction"), and
bash→G: doesn't propagate — so `quarto render`, `git push`, and the Netlify drag must run in Kim's
terminal/dashboard. Prepared the file-based scaffolding in `kimbridges-documents`: listing stub
`docs/coenosr.qmd` (categories Ecology/R/Methods; cover `../coenosr/coenosr_cover.png`) and
`coenosr/**` added to `_quarto.yml` resources (alphabetical, after citations). Handed Kim the ordered
run-list (render doc → copy `_output` into `kimbridges-documents/coenosr/` → render site → Netlify
drag onto the EXISTING site tile's Deploys) and the coenosr push commands (commit the 3
`inst/extdata/simple_10x15_*`). A fresh render is required first — many files changed since Kim's last
render. Awaiting Kim's manual steps. See proj_kimbridges_documents.md Deployment Workflow.

### 2026-06-15 (cont. 4) (read-through fixes round 2 + package bundle synced)
Kim's "few small things": (1) unified terminology on **eligible** (early Ch 1 bridge to the tradition's
"differential"; Ch 4/Ch 8 aligned, Ch 8 "essential"→"eligible"; "differential" kept for formed
groups); (2) added a **.REL structure example** to Ch 5; (3) added a **function-reference appendix**
(`function_reference.qmd`) listing all nine exported functions with signatures + parameters. Synced the
coenosr package's bundled `simple_10x15_*` to the modified toy — `devtools::test()` green (97 pass),
no test edits needed. Remaining: reinstall + GitHub push of coenosr (offered). `getting_data_in.qmd`
had reverted via the RStudio visual editor; re-applied its edits. See session_log.md 2026-06-15
(cont. 5) and doc_notes.md.

### 2026-06-15 (cont. 3) (read-through fixes round 1)
Kim read the whole book ("overall wonderful") and flagged three bigger issues; all fixed, verified in
R. (1) Rewrote §4.3 from grow-from-seed to the shrinking density-block search coenosr actually uses,
with an honest sentence that COENOS grew from seeds (the `.S00` seed) but the recovered engine shrinks
to the same groups — consistent with Ch 3/6/7. (2)+(3) Applied a slight toy-data modification (remove F
from market 1, add R to market 2) across all three `simple_10x15` formats — still 69 occurrences, two
clean 5-species groups; eligible now spreads constancy 3–5, essential richness varies. Regenerated
`coenos_sort.svg` and `coenos_trim.svg`; updated Ch 5/Ch 8 prose. Follow-up: sync the coenosr package's
bundled toy + test (no breakage; demo data now differs from book) and re-push. Kim's "few small things"
pending; re-render after. See session_log.md 2026-06-15 (cont. 4) and doc_notes.md.

### 2026-06-15 (cont. 2) (figures placed — book figure-complete)
All six infographics inserted into their chapters, matched to each chapter's dataset/argument:
sparsity→Ch1, timeline→Ch2, .S00→Ch3, sort→Ch5 (markets), honesty→Ch7, trim→Ch8 (markets, beside the
essential-species text). Trim kept out of Ch4 (Dieren n=18 vs the figure's n=10) to avoid a threshold
mismatch; sort placed in Ch5 not the Dieren Ch6 so no dataset mixes within a chapter. "Harbour"
spelling unified to house style. Book is figure-complete; Kim to re-render. Mapping/rationale in
`doc_notes.md`; see session_log.md 2026-06-15 (cont. 2).

### 2026-06-15 (cont.) (new chapter drafted — "The Reason for Groups")
A conceptual conversation about grouping (Kim's queued topic) became a new closing chapter,
**`the_reason_for_groups.qmd`**, placed after "A Clear Point of View" (renumbers the personal close
to Ch 9). It develops what the groups are *for*: the table is stripped down to find structure, the
groups are where ancillary knowledge re-attaches (worked ancillary TABLE on the markets, whose
produce groups line up with district/elevation never fed in — external corroboration); row/column
sums (constancy/fidelity, the essential-species "discriminate or total" sharpening, richness ≠
diversity); and the keystone "Reproducible, Not Proven" — group-derived statistics can't validate the
groups (circular), but independent external data can corroborate them; a method that began as
intuition is now reproducible and inspectable. New data `data/market_info.csv`. Awaits Kim's read +
live render (ClaudeR), where literal group/essential vectors get wired to live coenosr calls. See
session_log.md 2026-06-15 (cont.) and `Ceska\documentation\doc_notes.md`.

### 2026-06-15 (infographic set completed — six figures)
Built the five remaining infographics for the coenosr story-document, completing the
set of six, all in the established visual language and saved as SVG in
`Ceska\documentation\figures\` (verified on Drive): `coenos_trim` (set-aside-the-extremes),
`coenos_timeline` (1971→1991→lost→2026, to-scale), `coenos_sparsity` ("absence is data"),
`coenos_s00_message` (the decoded `.S00` as the authors' notes — real DIEREN group-2 record),
`coenos_honesty` (hand→COENOS→coenosr, lost tie-break as an honest footnote). Green `#009E73`
adopted as the set's "positive state" (eligible/kept; recovered/alive). Timeline refrain removed
(saved for the ending). Corrected a stale trim line in doc_notes vs the current data. On resume,
re-saved the prior bash-written `coenos_trim.svg` via the Write tool (Finding 001/005). Next:
place figures into the chapter `.qmd`s and render. See session_log.md 2026-06-15 and
`Ceska\documentation\doc_notes.md`.

### 2026-06-14 (Ceska resumed as Active Focus; infographic program begun)
Kim resumed Ceska as the Active Focus and proposed adding **infographics woven into the
coenosr story-document** — several figures, each one job, supporting multiple learning
modalities (reflects Kim's identity-level preference for illustrating technical documents;
recorded as `kim_association_index.md` Master Theme 12; conventions in
`style_multichapter_doc.md` §6). Built the **anchor figure**: the scatter-to-diagonal sort,
generated as SVG from the real `simple_10x15` market data — "as recorded" (scattered) →
`coenos_table()` → "after sorting" (two clean differential-group blocks). Okabe-Ito
blue/orange (CVD-safe), gray for ubiquitous, open rings for rare (shape as a second channel),
faint grid (absence stays visible). Saved `Ceska\documentation\figures\coenos_sort.svg`. Kim:
"exactly the sort of diagram that's needed ... really clear." Visual language now established
for the rest of the set; candidates queued (constancy strip, recovery timeline, `.S00`
message, honesty layers) in `doc_notes.md`. See session_log.md 2026-06-14.

### 2026-06-11 (COENOS methodology recovered — the project's core goal met)
The 1991 COENOS group-formation **method** is reconstructed and validated
against the preserved artifacts (work in the coenosr package; see
proj_coenosr.md and `reconstruction/form_groups_notes.md`). The method: trim
species (rare `<3` / eligible / ubiquitous `>= floor(2n/3)`) -> form
differential groups by **seeded alternating refinement** at three X/Y levels
(grow species by Rule I, relevé set by Rule II, to a fixpoint; rounding pinned:
floor inside, `ceil(Y*n/100)` outside on a total-n base) -> order by reciprocal
averaging. The `.S00` per-group metadata (decoded: level, seed species,
iteration count, size) confirms it — refinement from the decoded seeds
reproduces every group's **relevé set exactly** and converges in the recorded
iteration counts. The cover/RA bulk of the `.S00` was decoded and shown to be
the stored cover matrix only (not formation statistics), which means COENOS's
exact tie-break for ~4 genuinely between-community species per dataset is **not
recoverable** from the preserved files — an implementation detail of the lost
binary, not a component of the method. Per proj_Ceska's stated objective
("recover the methodology... so what COENOS did can be done again, legibly"),
this is the goal met, with the irreducible ambiguity honestly bounded. The
Objective's "lost technology recovery" is substantially achieved; remaining is
engineering (the RA ordering component + shipping form_groups in coenosr).

### 2026-06-11 (ELLEN.S00 + SET1.S00 decoded — three validation oracles now)
Applied the DIEREN.S00 decode to the other two restart files; the format
holds unchanged and both reproduce their printed tables. Three independent
oracles now exist, spanning the useful range: DIEREN (18 rel, 116 spp, 4
groups), ELLEN (25, 93, 5 groups at two levels), SET1 (63, 43, 2 groups,
numeric cover scale, from the binary SET1.DAT). For each, the per-species
role codes reproduce the independently-stored group-membership lists exactly,
the partition sums to the species total, and the −3 count equals the printed
footnote count exactly (64/25/12) — Python cross-checks pass all assertions.
**Two more spec open-questions resolved.** (a) The grouping-eligibility
ceiling is the **integer ⌊2n/3⌋** — constancy ≥ ⌊2n/3⌋ → excluded as a
super-companion (role −2); verified at n=18/25/63. This is floor, not a clean
">66%" (ELLEN excludes a 16/25 = 64% species), which sharpens HELP.CNS.
(b) **Multiple groups per X/Y level** confirmed and characterised (ELLEN: 4
groups at 40/10 + 1 at 50/20; SET1: 2 at 40/10; 40/10 is the most productive
level everywhere). Deliverables in `reconstruction/`: `ELLEN_SET1_S00_decode.md`,
`ellen_s00_species.csv`, `set1_s00_species.csv`, `ellen_check.py`,
`set1_check.py`. Remaining open + now the critical path: the group-growth loop
(spec §4.2) and the RA specifics (§5). Next: build `read_rel()` against the
three oracles. See session_log.md 2026-06-11.

### 2026-06-11 (DIEREN.S00 fully decoded — validation oracle in hand)
Decoded the COENOS quick-restart format from DIEREN.S00, cross-checked
against Dieren_table and DIEREN.REL. Fully decoded and verified: the
per-species **role code** (positive = differential-group id; −1 companion;
−2 super-companion >66% constancy; −3 low-constancy → footnote), the
per-species **constancy**, the four **group-membership lists** (bracketed
by −(group id), members in display order), and the **relevé display-order
vector** (identical to the printed column order). Verification was
redundant by design (meta-obs #7): the role codes from one region of the
file independently reproduce the group-membership lists from another, the
partition sums to 116, and the low-constancy count (64) equals the printed
footnote count exactly — a Python cross-check passes all assertions.
Resolved two spec open-questions: the body/footnote boundary is
**constancy < 3** (not the "< 4" the HELP prose implies), and the `.S00`
role-code semantics. Deliverables in `reconstruction/`: `DIEREN_S00_format.md`,
`dieren_s00_species.csv` (the per-species validation oracle), `decode_check.py`.
The cover/RA bulk of the `.S00` was left undecoded (not needed — covers come
from the `.REL`). Next: same decode on ELLEN.S00 + SET1.S00, then `read_rel()`.
See session_log.md 2026-06-11.

### 2026-06-11 (reconstruction begun — promoted to Active Focus; spec written)
Kim turned to Ceska as a new project and chose it as the Active Focus.
Approach decided collaboratively: **spec first** (of four offered options).
Claude read and decoded the full resource set — `COENOS.EXE` context,
`HELP.CNS`, the `.REL` inputs, the `*_table` outputs, and the `.S00`
restart files — across all three example datasets (DIEREN, ELLEN, SET1),
and wrote `reconstruction/COENOS_algorithm_spec.md`: data formats, the
two constancy thresholds, the inside/outside group-formation rules, the
reciprocal-averaging ordering, and the output layout, every claim tagged
[DOC]/[OBS]/[OPEN]. Status changed Reference → Active, Focus readiness
Not applicable → Ready. Key findings: the `.S00` files are a
machine-readable validation oracle (confirmed the DIEREN relevé-ordering
vector matches the printed column order); and the iterative group-growth
loop (spec §4.2) is the one hard reverse-engineering target, everything
else being documented or standard. Kim's note on reading the spec: years
of hands-on Braun-Blanquet two-way-table work made seeing the procedural
notes laid out "very refreshing." Next: fully decode DIEREN.S00, then
build `read_rel()`. See project_index.md Active Focus and session_log.md
2026-06-11.

### 2026-05-28
Project file created during PKM housekeeping continuation. The
Ceska folder was moved into G:\My Drive\Projects\Ceska on
2026-05-28 — a 1991 COENOS compiled-Pascal executable plus
example data (Ellenberg, Dieren, SET1/2/3 relevé sets in
COENOS's input and output formats). Kim framed the project as a
"lost technology" reconstruction: COENOS still runs but its
source is unavailable, so the methodology must be recovered by
reading what the code does and reimplementing it in the modern
Braun-Blanquet cluster (bbstruct, bbSynth, Braun_Blanquet).
The Ceska artifacts are the ground truth against which the
reconstruction is validated.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Reference, Focus readiness Not applicable: the 1991
COENOS executable plus example data, preserved as historical
ground truth; not under development by design (the reconstruction
happens in the sibling cluster projects). This is the canonical
Reference example named in template.md. Part of the collection-wide
back-fill; see proj_PKM.md and session_log.md (2026-05-30).
