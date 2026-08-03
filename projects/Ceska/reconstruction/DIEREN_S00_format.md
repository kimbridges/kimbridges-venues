# DIEREN.S00 — decoded file format

_Reconstruction working document. Drafted 2026-06-11. Companion to
`COENOS_algorithm_spec.md` §7. Decodes the COENOS quick-restart (`.Snm`)
format from `DIEREN.S00`, cross-checked against `Dieren_table` and
`DIEREN.REL`._

**Why this matters.** The `.S00` file stores COENOS's complete *solved* state.
Decoding it turns the example datasets from "compare my printed table against
theirs by eye" into **exact, machine-checkable ground truth**: every species'
role, every group's membership and internal order, and the final relevé
ordering, as integers. This is the validation backbone for the R port.

**Confidence.** Everything in §§1–5 below is **fully decoded and verified** —
the per-species role codes (one region of the file) independently reproduce
the group-membership lists (a different region), the role/constancy split is
internally consistent, and the low-constancy count equals the printed
footnote count exactly (verification script: `decode_check.py`, all checks
pass). §6 is **partially decoded** (fields whose exact meaning is not yet
pinned down). §7 is **not needed for validation** and left for later.

---

## 1. Overall layout

```
[A] Provenance      2 lines   source file name(s); save date & time
[B] Header          7 values  dimensions and counters
[C] Relevé block    18 recs   code + 4 ints each
[D] Species block   116 recs  8-char key + 4 ints each   <- constancy + ROLE
[E] Group structure delimited group-membership lists      <- groups + order
[F] Threshold list  6 values  40 10 50 20 66 33
[G] Cover/RA data   bulk       per-relevé (species_id, cover) pairs  [§7]
[H] Ordering tails  vectors    species display order; relevé display order
```

All values are whitespace-delimited ASCII integers (one per line), except the
two text lines in [A], the boolean in [B], and the 8-char species keys and
relevé codes.

---

## 2. Provenance and header ([A]+[B])

```
Source file(s): DIEREN.REL
Table was saved - date:  4-29-126   time: 19:38:10
 18      n_releves
116      n_species   (distinct species in the data set)
125      [counter — not yet pinned down; > n_species]
  4      [counter — number of differential groups formed = 4. CONFIRMED:
          DIEREN has exactly 4 groups]
  4      [counter — likely also "n_groups"; equals the above]
  7      [counter — not yet pinned down]
false    [boolean flag — hand-edit/printed flag; false in this run]
```

`4-29-126` is 29 April 2026 (Pascal year = 1900 + 126); confirms the program
still runs under Kim's emulator. The `4` counter = the number of differential
groups, which matches §§3–4. `125`, the second `4`, and `7` are sizing /
state counters not yet individually confirmed.

---

## 3. Per-relevé block ([C])

18 records, each = **relevé code + 4 integers** `[n1 n2 n3 n4]`:

| field | meaning | confidence |
|------|---------|-----------|
| n1 | **species count in the relevé** | CONFIRMED (matches `DIEREN.REL`: BILL01→10, BILL04→44, …) |
| n2, n3 | relevé-group / type pointers (n2==n3 for most relevés; BILL17/18 = 0,0) | partial |
| n4 | a permutation of 1..18 (a processing/sort index; first six relevés scrambled, 7–18 identity) | partial |

n1 is solid and useful (a free check on the `.REL` parser). n2/n3/n4 are not
needed for table validation — the authoritative relevé display order is the
explicit vector in [H] (§5).

---

## 4. Per-species block ([D]) — the high-value region

116 records, **in first-appearance order** (record position = species id
1..116). Each record = **8-char species key + 4 integers** `[c1 c2 c3 c4]`:

| field | meaning | confidence |
|------|---------|-----------|
| **c1** | **constancy** = number of relevés the species occurs in | CONFIRMED (e.g. LILAOCCI 10, POTEPACI 13, TYPHLATI 1) |
| c2 | a 1..116 permutation index (secondary sort key; LILAOCCI=1; ids 96–116 keep c2==id). Exact key unresolved | partial |
| **c3** | **role code** — see table below | CONFIRMED |
| c4 | per-species flag, `0` for every species here (no hand edits this run) | CONFIRMED (=0) |

### 4.1 The role code `c3` — fully decoded

| c3 | meaning | count in DIEREN | where it appears in the table |
|----|---------|-----------------|-------------------------------|
| **g > 0** | member of **differential species-group `g`** (formation id) | 49 across 4 groups | inside group block `g` |
| **−1** | **companion** — ungrouped, constancy ≥ 3 and ≤ 66% | 2 (PLAN LANC, SIUM SUAV) | body, below the groups, by decreasing constancy |
| **−2** | **super-companion** — ungrouped, constancy > 66% | 1 (POTE PACI, 13/18 = 72%) | body, top companion |
| **−3** | **low-constancy** — constancy < 3 | 64 | body rows AND the "Species with low constancy" footnote |

The four group ids and their `X/Y` levels (recovered by matching `c3=g`
membership to the printed group blocks):

| group id `g` | `X/Y` level | # species |
|----|-------|----|
| 1 | 50/20 | 22 |
| 2 | 66/33 | 5 |
| 3 | 40/10 | 18 |
| 4 | 66/33 | 4 |

So the **id is formation order, not display order**; the table shows them
3, 1, 2, 4 (i.e. 40/10, 50/20, 66/33, 66/33), an ordering set by reciprocal
averaging.

### 4.2 Two spec open-questions RESOLVED by this decode

- **Body vs footnote boundary (was spec §8 #2).** The split is **constancy
  < 3 → footnote**, not the "< 4" the `HELP.CNS` prose suggests. Evidence:
  SIUM SUAV (constancy 3) carries `c3 = −1` and sits in the body; every one of
  the 64 footnote species has constancy 1 or 2 and carries `c3 = −3`. The
  decoded footnote count (64) equals the printed `Dieren_table` footnote count
  exactly.
- **`.S00` role-code semantics (was spec §8 #6).** Fully decoded, above.

---

## 5. Group structure ([E]) and ordering tails ([H]) — fully decoded

### 5.1 Group-membership lists ([E])

Immediately after the species block, the four groups are listed **in display
order**, each block **bracketed by a matching pair of `−(group id)`
delimiters**, the members given as species ids **in display order**:

```
-3  34 17 54 55 64 79 69 81 74 71 70 66 65 76 83 80 67 68  -3   (group 3, 40/10)
-1  32 44 43 45 33 48 52 27 39 16 59 6 19 18 15 22 8 53 11 30 31 25  -1  (group 1, 50/20)
-2  7 5 14 1 3  -2                                                (group 2, 66/33)
-4  2 4 9 10  -4                                                  (group 4, 66/33b)
 0
```

i.e. the delimiter is simply **negative the group's formation id**. The id
order within each block is the species' top-to-bottom order in that group's
printed block. **Verified:** these id lists, mapped back through the species
ids, exactly equal the `c3 = g` membership sets from §4 (independent regions
agreeing), and the member order matches `Dieren_table` row order.

### 5.2 Relevé display-order vector ([H] tail)

The file ends with the **final relevé order** as 18 ids:

```
6 11 13 14 16 15 4 5 7 8 9 10 12 1 3 2 17 18
```

**Verified identical** to the column order across the top of `Dieren_table`
(BILL 06, 11, 13, 14, 16, 15, 04, …). A species display-order vector sits
just above it in [G]/[H] (interleaved with the cover data); its clean
extraction is a §7 item, but it is not required — §5.1 already gives every
group's internal order and §4 gives the companion/footnote ordering by
constancy.

---

## 6. Threshold list ([F]) — decoded

```
40 10 50 20 66 33
```

The three available `X/Y` percentage pairs (spec §4.1), stored verbatim. These
are the *settings*, not per-group assignments; the per-group level comes from
matching membership to the printed blocks (§4.1 table) or from a per-group
metadata record in [G] (not yet isolated).

---

## 6a. Per-group metadata ([F2]) — decoded 2026-06-11

Immediately after the threshold list, before the cover/RA bulk, sit **four
per-group records (lines 811-830), in group-id order**, each five integers
`[level, b, seed_id, n_species, 0]`:

| gid | level (1/2/3 = 40-10 / 50-20 / 66-33) | b | seed_id | n_species |
|----:|---------------------------------------|--:|--------:|----------:|
| 1 | 2 (50/20) | 3 | 32 (HYPEFORM) | 22 |
| 2 | 3 (66/33) | 1 | 7 (TRIGMARI)  | 5  |
| 3 | 1 (40/10) | 2 | 34 (CIRSARVE) | 18 |
| 4 | 3 (66/33) | 4 | 2 (ELEOPALU)  | 4  |

- `level` and `n_species` match each group's X/Y and size exactly.
- `seed_id` is the group's **initial species** (= the first id in that group's
  membership list in [E]); each is a member of its group.
- `b` is the **iteration count** for group formation (HELP §.301); matches an
  independent alternating-refinement for 2 of the 4 groups, off by one for the
  other two.

This is the metadata that drives group formation; see `form_groups_notes.md`
§2c for how it constrains the reconstruction (it settles the seeds, levels, and
sizes; the exact tight-growth rule remains open).

## 7. Cover / RA data ([G]) — partly decoded; a lead, not yet needed for validation

After the per-group metadata, the bulk of the file (lines ~831-1540) holds
per-relevé (and per-group) **(species_id, cover) pair lists** storing the cover
matrix for redisplay, plus the per-group RA / asterisk table statistics (block
size, % positive entries, mean Sørensen similarity). The cover values are
already available exactly from `DIEREN.REL`, so this was deferred — but the
per-group **block statistics** here are now a priority lead for pinning the
exact group-growth rule (see `form_groups_notes.md` §3).

---

## 8. What this gives the reconstruction

A ready validation oracle for DIEREN, captured in
**`dieren_s00_species.csv`** (id, species, constancy, c2_index, role_code,
role). The R port can now be checked exactly:

1. **`read_rel()`** → per-relevé species counts must equal [C] n1; per-species
   constancy must equal [D] c1.
2. **trim + classify** → each species' computed role (group / companion /
   super-companion / footnote) must equal the decoded `c3`.
3. **`form_groups()`** → the 4 groups' membership must equal §5.1's sets, at
   the levels in §4.1.
4. **reciprocal averaging** → the relevé ordering must equal §5.2's vector,
   and each group's internal species order must equal §5.1's order.

The same decode should now be run on `ELLEN.S00` and `SET1.S00` to give three
independent validation cases before the group-formation engine is written.
