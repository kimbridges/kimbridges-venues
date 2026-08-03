# ELLEN.S00 and SET1.S00 — decode notes + cross-dataset findings

_Reconstruction working document. Drafted 2026-06-11. Extends
`DIEREN_S00_format.md` to the two remaining example datasets, confirming the
format is general and refining one rule. All checks below pass
programmatically (`ellen_check.py`, `set1_check.py`)._

The `.S00` layout decoded for DIEREN holds **unchanged** for ELLEN and SET1.
Both decode cleanly and both reproduce their printed tables. We now have three
independent validation oracles:

| dataset | relevés | species | groups | grouped | companions (−1/−2) | footnote (−3) |
|---------|--------:|--------:|-------:|--------:|-------------------:|--------------:|
| DIEREN | 18 | 116 | 4 | 49 | 2 / 1 | 64 |
| ELLEN  | 25 | 93  | 5 | 35 | 16 / 17 | 25 |
| SET1   | 63 | 43  | 2 | 8  | 20 / 3 | 12 |

In every case: the per-species role codes reproduce the independently-stored
group-membership lists exactly; the role/constancy partition sums to the
species total; and the count of low-constancy (−3) species equals the printed
"Species with low constancy" footnote count exactly (64 / 25 / 12).

Per-species oracles: `dieren_s00_species.csv`, `ellen_s00_species.csv`,
`set1_s00_species.csv`.

---

## 1. What generalised cleanly

- **Header.** Same shape. The 4th header value = **number of groups**
  (DIEREN 4, ELLEN 5, SET1 2 — all confirmed).
- **Per-relevé records.** First integer = species count in the relevé
  (confirmed). For SET1 the 2nd integer is mostly 0; n2/n3/n4 remain
  partial, not needed for validation.
- **Per-species records** `[constancy, c2_index, role_code, 0]`. Constancy and
  role code confirmed on all three; c4 = 0 throughout (no hand edits).
- **Role code.** Same scheme: positive = group id; −1 companion; −2
  super-companion; −3 low-constancy/footnote.
- **Group structure block.** Same `−(group id)` bracketed lists, groups in
  display order, members in display order.
- **Threshold list** `40 10 50 20 66 33` present in all three.
- **Relevé display-order vector** at the file tail — verified identical to the
  printed column order for ELLEN (`6 7 25 21 22 13 14 5 8 …`) and SET1
  (`10 12 22 28 29 47 4 18 38 1 2 3 …`).

---

## 2. What the extra datasets pinned down

### 2.1 Super-companion threshold (was spec §8 #3, the −1/−2 split) — RESOLVED

A species is a **super-companion (role −2)** — excluded from group formation
for being too ubiquitous — **iff its constancy ≥ ⌊2n/3⌋**, where _n_ is the
number of relevés. Ordinary **companions (role −1)** are the ungrouped species
with constancy between 3 and ⌊2n/3⌋−1. Verified on all three:

| dataset | n | ⌊2n/3⌋ | min constancy of −2 | max constancy of −1 |
|---------|--:|-------:|--------------------:|--------------------:|
| DIEREN | 18 | 12 | 13 | 9 |
| ELLEN  | 25 | 16 | 16 | 15 |
| SET1   | 63 | 42 | 49 | 38 |

This is sharper than `HELP.CNS`'s prose "constancy higher than 66%". The exact
cut is the **integer** ⌊2n/3⌋: for ELLEN that is 16, so a species in 16 of 25
relevés (64%) is already excluded — which a literal ">66%" reading would have
kept. The rule to implement is the integer floor, not the percentage.
(`⌊2n/3⌋` fits all three; `round(2n/3)` and `⌈2n/3⌉` also fit DIEREN/SET1 but
**not** ELLEN, where round(16.67)=17 > 16 — so **floor** is the correct form.)

### 2.2 Multiple groups at one X/Y level — confirmed and characterised

ELLEN forms **five** groups but only at **two** levels: four at 40/10
(groups 1, 2, 4, 5) and one at 50/20 (group 3). SET1 forms **two** groups,
**both** at 40/10. So a single X/Y level routinely yields several distinct
species groups, each its own block in the table. The group id is formation
order; the level is recorded per group (read here from the printed table —
the `group_level` column in the CSVs). This removes any doubt that "one block
per level" — the engine must support N groups per level. (Note: across all
three datasets, **40/10 is by far the most productive level**; 66/33 produced
groups only in DIEREN.)

### 2.3 Delimiter/role-code collision is only apparent

In SET1 the group ids are 1 and 2, so the group-block delimiters are −1 and
−2 — the same integers used as companion role codes in the species block.
There is no real ambiguity: the two live in different file sections (species
records vs. the group-structure block). The decoder keys on section, not on
the bare value. Worth noting for the reader so the collision isn't mistaken
for a bug.

---

## 3. Dataset notes worth carrying forward

- **SET1 is the stress case for the engine.** 63 Hawaiian-forest relevés
  (PAH plots) with very high mutual similarity: three dominant species
  (OPLE HIRT 61/63, MICR STRI 59/63, RUBU ROSI 49/63) are super-companions,
  and only two small 4-species groups form. A correct engine must produce
  *few* groups here, not force structure that isn't there.
- **SET1 uses the numeric cover scale** (1–7) and comes from the binary
  `SET1.DAT`; its `.S00` nonetheless decodes identically. The cover values in
  the `[G]` redisplay block are integers rather than B-B symbols — consistent
  with spec §2.1.
- **ELLEN exercises the multi-group-per-level path** and the companion-heavy
  case (33 of 93 species are companions), making it the best test of the
  companion ordering (decreasing constancy) and the ⌊2n/3⌋ cut.

---

## 4. Net effect on the reconstruction

Three independent, machine-checkable oracles now exist, spanning small/large
species counts, symbolic/numeric covers, and 2–5 groups across 1–3 levels.
The validation harness can check, per dataset:

1. relevé species counts and per-species constancy (`read_rel()`),
2. each species' role via the ⌊2n/3⌋ + <3 rules (trim/classify),
3. group memberships and levels (`form_groups()`),
4. relevé ordering and within-group ordering (reciprocal averaging).

Spec open-questions now resolved: #2 (body/footnote = constancy <3), #3 (the
−1/−2 super-companion cut = ⌊2n/3⌋), #5 (multiple groups per level —
characterised), #6 (`.S00` semantics). Still open and now the critical path:
#1 the group-growth loop, #4 the RA specifics.
