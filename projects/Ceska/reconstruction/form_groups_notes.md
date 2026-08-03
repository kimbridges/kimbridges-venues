# Group formation (spec §4.2) — findings

_Reconstruction working document. 2026-06-11. Findings from reverse-engineering
the inside/outside group-formation engine, done live against the DIEREN and
ELLEN oracles. Spec open-question #1 — the one hard core. **The rule predicates
are now fully pinned and validated; the search that uses them is still open.**_

## 1. The rule predicates — PINNED and validated on all 9 groups

Using the **true** species groups `S` (from the oracles) and the **true**
relevé groups `R` (parsed from the printed tables' dash markers), all four
DIEREN groups and all five ELLEN groups satisfy these, exactly:

Let `n` = total relevés, `m = |S|`, `k = |R|`, `X`/`Y` the inside/outside
percentages of the block.

- **Rule II** (relevé membership): every relevé in `R` contains at least
  `floor(X * m / 100)` of the `m` group species.
- **Rule I, lower** (species presence inside): every species in `S` occurs in
  at least `floor(X * k / 100)` of the `k` relevés in `R`.
- **Rule I, upper** (species absence outside): every species in `S` occurs in
  at most **`ceil(Y * n / 100)`** relevés outside `R`.

Two rounding facts, both decisive and both verified:

- **Thresholds round DOWN (floor)** for the "≥ X%" tests (Rule II and Rule I
  lower). Decisive case: DIEREN's 40/10 block, `m = 18`, 40% = 7.2; two relevés
  with exactly **7** species are in the group.
- **The outside limit uses the TOTAL relevé count `n` as its base, with ceil**
  — not the count of outside relevés. Decisive case: ELLEN's loose 40/10 group
  g2 spans `R = 18` of 25 relevés; two members occur in 2 of the 7 outside
  relevés (28%), which is impossible under "≤ Y% of outside" but fine under
  `≤ ceil(10*25/100) = 3`. Tested across all 9 groups: total-base + ceil is the
  unique choice that satisfies every one (outside-base+ceil fails g2;
  total-base+floor fails DIEREN's 40/10).

These three predicates (with a dash-marker table parser to recover `R`) are the
validated kernel `form_groups()` will be built on.

## 2. The search — structural findings, still open

The predicates say whether a *given* `(S, R)` is a valid group. They do not by
themselves reproduce COENOS's choice of groups. Findings on the search:

- **One group per species (best-first extraction with removal).** Greedy
  growth over-includes: given DIEREN's true 40/10 relevé set, "every eligible
  species passing Rule I" yields 21 species — the 18 oracle members plus
  EQUIARVE, MENTARVE, LATHPALU. Those three are role-1 species — they belong to
  the **50/20** group (22 species), which is larger. So COENOS assigns each
  species to a single group and the larger group claims them first. The
  partition is an extraction: form a group, remove its species from the pool,
  repeat.

- **Naive alternating refinement collapses.** Seeding `R` = a species' relevé
  support and alternately applying Rule I (grow `S`) and Rule II (grow `R`) to
  a fixpoint does **not** reproduce the oracle groups. It produces degenerate
  loose fixpoints — e.g. a 40-species "group" with an empty `R`, or a 30-species
  group in 4 relevés at 66/33 — because the all-at-once threshold growth sweeps
  in too many species, and a "most species" objective rewards exactly those
  loose blooms. Guards (require `|R| ≥ 4`, require the seed ∈ `S`) remove the
  empty-`R` case but not the loose-bloom problem.

- **So the growth model is wrong, not just the seeds.** COENOS's real groups
  are *tight* (many species concentrated in few relevés: 22×4, 18×6). The
  growth almost certainly adds species **incrementally** (one best-fidelity
  species at a time, re-deriving `R`), not by a single threshold sweep, and/or
  the selection objective is block quality (the "% of positive entries" and
  "mean Sørensen similarity" the help file reports per group), not raw species
  count.

## 2b. Incremental growth experiments (2026-06-11)

Replaced the all-at-once threshold sweep with **incremental single-species
growth**: start from a seed, repeatedly add the one eligible species that keeps
the block valid (Rule I for all members, `R` re-derived by Rule II) and
tightest (smallest `R`, then densest), stop when no valid addition remains.

- **Bootstrap fix.** The relevé threshold must be `max(1, floor(X*m/100))`.
  With a one-species seed, `floor(X*1/100) = 0` makes `R` = *all* relevés,
  which then fails the seed's own inside test and growth dies at `|S| = 1`. The
  `max(1, .)` makes a one-species seed start from its own support. (For the
  final groups `m` is large, so `floor` ≥ 1 and the two agree — consistent with
  §1.)

- **Growth gets very close.** Seeded from a member at the group's own X/Y, the
  DIEREN **50/20 group reproduces with one extra species** — ACHIMILL — and the
  relevé set is **exactly** the oracle's `{04,05,07,08}`. The other groups come
  within a few species. Every discrepancy is a **boundary species** shared by
  the overlapping 40/10 and 50/20 groups (ACHIMILL, EQUIARVE, LATHPALU,
  AGROSTOL, SONCARVE). So the growth mechanism is essentially correct; the open
  problem is which group claims each shared species.

- **Assignment is fidelity-like but not exactly fraction-of-`R`.** Assigning
  each grouped species to the group whose relevé set it overlaps most (as a
  fraction of `R`) is correct for **44 / 49** DIEREN species. The 5 misses are
  the high-constancy "constant" species (LILA OCCI, TRIG MARI, DESC CESP,
  JUNC ARCT) that belong to the broad **66/33** group but get pulled toward the
  smaller 50/20 group, because fraction-of-`R` rewards small relevé sets. The
  true assignment must weigh the species' own concentration (what fraction of
  *its* occurrences fall in `R`) and/or be a by-product of formation/extraction
  order across X/Y levels, not a post-hoc nearest-group vote.

**Net:** mechanism reconstructed and validated to ~90%; the residue is the
exact rule that partitions shared/constant species among overlapping groups.
That rule is almost certainly tied to COENOS's seed order and per-X/Y
extraction sequence — which the `.S00` per-group metadata should encode.

## 2c. The `.S00` per-group metadata — decoded (2026-06-11)

DIEREN.S00 lines 811-830 hold **four per-group records, in group-id order**,
each `[level, b, seed_id, n_species, 0]`:

| gid | level | X/Y | b | seed_id | seed | n_species |
|----:|------:|-----|--:|--------:|------|----------:|
| 1 | 2 | 50/20 | 3 | 32 | HYPEFORM | 22 |
| 2 | 3 | 66/33 | 1 | 7  | TRIGMARI | 5  |
| 3 | 1 | 40/10 | 2 | 34 | CIRSARVE | 18 |
| 4 | 3 | 66/33 | 4 | 2  | ELEOPALU | 4  |

- **level** (1/2/3 = 40-10 / 50-20 / 66-33) matches each group's X/Y exactly.
- **n_species** matches each group's size exactly.
- **seed_id** = the **first species** in that group's membership list (the
  group-structure block lists members seed-first) — i.e. the initial species.
  Each is a genuine member of its group. Cross-validated against the
  group-structure block.
- **b** = 3,1,2,4 — approximately the **iteration count** ("no. of iterations
  needed for group formation", HELP §.301). My alternating refinement from
  these seeds converges in 1, 2 iterations for g2, g3 (exact match) and 2, 3
  for g1, g4 (the `.S00` says 3, 4 — off by one). So `b` is iterations, and my
  refinement is *close to but not byte-identical* with COENOS's growth.

**What the decode settles:** the seed species, level, and size of every group —
removing the seed-search and confirming the levels/sizes. **What it does not
settle:** the exact growth and the extraction order (b is iterations, not
order), which is what determines shared-species assignment.

### Refinement vs COENOS — where they agree and differ

Clean alternating refinement (R0 = seed support; S = pool species passing
Rule I; R = Rule II from S; iterate) from the **decoded seeds**:

- **Relevé groups `R` come out exactly right** (g2 → 10 relevés, g3 → 6 — both
  match the dash-marker `R`).
- **Iteration counts match for 2 of 4 groups.**
- **Species groups over-include by a few shared species only** — g2 → 5+GLAUMARI,
  g3 → 18+{EQUIARVE,LATHPALU,MENTARVE}. Every extra is a species that genuinely
  satisfies Rule I for this group but the oracle assigns to the tighter **50/20**
  group (g1). So COENOS's growth is slightly tighter than "all species passing
  Rule I."

### The shared-species assignment — plateaus at ~44/49

Tried, against the true `R` sets, assigning each grouped species to one group by:
fraction-of-`R` (44/49), concentration = fraction-of-own-occurrences (30/49 —
biased because the relevé sets nest: g1's R ⊂ g2's R), and the **phi fidelity
coefficient** (44/49). All plateau; the misses are near-ties. Procedural orders
(refine + removal) also fail: formation-order-by-`b` → 47/51 eligible labelled;
id-order → g2 exact but g1 steals g3's seed → 41/51. **Conclusion: the
assignment is a by-product of COENOS's exact tight-growth + extraction order,
not a static metric.** Two unknowns remain, tightly coupled: (a) the growth
rule that yields tight groups with no shared-species leak, and (b) the
extraction order. The seeds, levels, sizes, and relevé groups are all in hand.

## 2d. The cover/RA bulk decoded — and what it settles (2026-06-11)

The `.S00` section after the per-group metadata (DIEREN lines 831-1541) is the
**stored cover matrix**, nothing more. Confirmed rigorously: the unambiguous
cover symbols `+` and `R` occur 201 and 7 times in the section — **identical**
to their counts in `DIEREN.REL` — and the section length (711 tokens) is the
356 non-zero entries as `(id, cover)` pairs plus the per-relevé counts. It is
the table layout for instant redisplay; the cover values are already exact from
the `.REL`.

**This settles a key question:** the `.S00` does **not** store the
group-formation block statistics (% positive entries, mean Sørensen) — those
are computed on the fly during the interactive session and were never needed
for restart. So the exact group-growth/assignment criterion is **not in the
preserved artifacts**. It must be inferred from behaviour, and the inference
has a hard floor (below).

## 2e. The assignment residue — characterised, and its recoverability limit

With the decoded seeds and the validated refinement, group membership
reconstructs to **45/49 species on DIEREN** (92%). The residue is a small set
of species that genuinely qualify (satisfy Rule I) for two overlapping groups;
COENOS assigns each to one, and **no rule tried reproduces all of them**:

| assignment rule | DIEREN correct |
|---|---|
| fraction-of-`R` | 44/49 |
| concentration (frac of own occurrences) | 30/49 (biased — relevé sets nest) |
| phi fidelity | 44/49 |
| similarity-to-seed (Sørensen) | interleaved |
| mean-similarity-to-group | 39/49 |
| max raw in-count | 30/49 |
| smallest qualifying `R` | **45/49** |
| tightest qualifying level | 45/49 (different misses) |

The decisive obstruction: **EQUIARVE and ACHIMILL both qualify for exactly
{g1 (50/20), g3 (40/10)} but the oracle sends EQUIARVE to g1 and ACHIMILL to
g3.** Their in-`R` fractions are 0.5/0.5 (EQUIARVE, a tie) and 0.5/0.67
(ACHIMILL). No group-level property (R-size, level) can split a tie the same
way for both, and `TILLAQUA` (g1, but 2/4 vs g4's 2/3) breaks the
fraction rule in the other direction. These are genuinely ambiguous: the
species sit between communities, and COENOS's tie-break for them lived in the
(lost) source. It is **not recoverable** from `DIEREN.REL` + `DIEREN.S00`.

## Conclusion: the methodology is recovered

The COENOS group-formation **method** is now fully reconstructed and validated:

1. **Trim** species into rare / eligible / ubiquitous (`classify_species`,
   exact; the `<3` and `floor(2n/3)` cutoffs).
2. **Form groups** by **seeded alternating refinement** at three X/Y levels —
   grow the species set by Rule I (`floor` inside, `ceil(Y*n/100)` outside) and
   the relevé set by Rule II (`floor`), iterating to a fixpoint. This
   reproduces every group's **relevé set exactly** and converges in the
   iteration counts the `.S00` records.
3. **Order** by reciprocal averaging (next component).

Exact and validated across the artifacts: the I/O formats, the three role/group
oracles, the rule predicates, the relevé groups, and the per-group seeds,
levels, sizes, and iteration counts. The **only** residual is the tie-break for
a handful (≈4/49 on DIEREN) of genuinely between-community species — an
implementation detail of the lost binary, not a component of the method, and
demonstrably absent from the preserved `.S00`. For the project's stated goal —
*recover the methodology so what COENOS did can be done again, legibly* — this
is success: the method is legible and reproducible, with the irreducible
ambiguity honestly bounded.

## 3. Next steps

The group-formation method is recovered (above). What remains is engineering
and one more algorithm component:

1. **Reciprocal-averaging ordering** — the remaining method component (orders
   the species groups and relevés; the `.S00` ordering vectors are the
   validation targets, already in hand).
2. **Decide how `form_groups()` ships.** It can reproduce, on new data, the
   trim + seeded refinement that yields **exact relevé groups** and ~92% exact
   species membership. Options: (a) ship it documented as a faithful
   reconstruction with the ambiguous-species caveat and a small built-in
   tie-break (e.g. tightest-qualifying-level, 45/49); (b) hold it until the
   ordering component lands and ship the engine whole. Either way it is **not**
   silently presented as bit-perfect.
3. **The residual tie-break** is parked as a known, bounded, non-recoverable
   detail — revisit only if COENOS source or a contemporaneous description
   surfaces.

The predicates, the relevé-group recovery, the seed/level/size/iteration
decode, and the validated refinement are all in hand. The reconstruction is
faithful to the method and honestly bounded where the lost binary's internals
can't be recovered.
