# Reciprocal-averaging ordering (spec §5) — first findings

_Reconstruction working document. 2026-06-11. First crack at the
reciprocal-averaging (RA) ordering component, against the DIEREN `.S00`
relevé-order vector. The relevé ordering is **group-structured**, not plain
correspondence analysis._

## Target

The `.S00` relevé display order for DIEREN is
`6 11 13 14 16 15 | 4 5 7 8 9 10 12 | 1 3 2 | 17 18`. Read against the group
structure, it is the relevés arranged by **which species group characterizes
them**: the first run is the 40/10 group's relevé set, then the 50/20 / 66/33
runs, with the two near-empty relevés (BILL17, 18) at the end. So the ordering
is induced from the group structure, then RA orders the groups/relevés within.

## What does NOT reproduce it

- **Plain correspondence analysis (first axis) on the full 116×18 incidence
  matrix.** Order only weakly matches (Spearman ≈ 0.56 after orienting). The
  raw CA axis is pulled by overall species richness, not the differential-group
  structure.
- **CA first axis on the simplified 4×18 (species-group × relevé) table.**
  Closer in spirit but still wrong (BILL17/18 land mid-order rather than at the
  end; several relevés transposed).

## What HELP says (the construction to implement)

`HELP.CNS` §.601: *"An asterisk table represents the results of reciprocal
averaging performed on a simplified table of species **groups** and relevé
**types**."* Two reductions before RA:

1. Species are collapsed to **species groups** (rows = the differential groups).
2. Relevés are collapsed to **relevé types** — relevés sharing the same group
   signature (which groups' membership rules they meet) become one type.

RA then runs on this small groups × types table; the axis orders the groups and
the types, and the full relevé/species order is induced from that (ungrouped /
near-empty relevés to the ends; companions by decreasing constancy; low-constancy
species to the footnote).

## SOLVED for the relevé ordering (2026-06-11)

The relevé ordering is **reproduced exactly on both DIEREN and ELLEN** by RA on
the species-group × relevé-type asterisk table. The algorithm:

1. **Asterisk table.** Each relevé's *type* is its **group signature** — the set
   of differential groups whose relevé-set `R` it belongs to. Rows = species
   groups, columns = the distinct types, cell = 1 if the group is in the type.
2. **RA = correspondence analysis** on that table. Take the first two axes.
3. **Order relevés** by their type's `(axis-1 score, axis-2 score)`, then by
   relevé number within a type; empty-signature relevés (in no group) go last.

Exact matches: DIEREN (18 relevés) and ELLEN (25 relevés, 5 groups, 10 types)
both reproduce their `.S00` relevé vectors to the position. Two details that
mattered: relevés of the same type sort by **ascending relevé number**, and the
**axis-2 score breaks axis-1 ties** (e.g. ELLEN's g3/g5 groups tie on axis 1 and
separate on axis 2).

### The one convention: axis sign (reflection)

The axis-1 **sign** that matches COENOS differs by dataset (DIEREN −, ELLEN +).
This is inherent: correspondence-analysis axes are defined only up to sign, so a
*reflected* table is phytosociologically identical. COENOS made a specific
display choice; a candidate deterministic rule that fits both is **orient so the
tightest-level (smallest-X) group at an axis-1 extreme leads** (DIEREN: the
40/10 pole g3 first; ELLEN: the 40/10 pole g4 first). For the package, compute
the ordering and expose the orientation as a convention (with a `reflect`
option), noting any table can be reflected to match a reference.

## Species ordering — method recovered, micro tie-break residual (2026-06-11)

The species display order has a clear, recovered structure:

1. **Grouped species** come first, in **group order** (the same RA order as the
   relevés). Within each group, species are ordered by **decreasing constancy**
   — verified monotone for all four DIEREN groups (g3: 7 7 6 6 4×5 3×8; g1:
   7 7 7 6 6 6 5×11 4 4 4 3 3; g2: 10 10 10 9 9; g4: 4 4 3 3).
2. **Ungrouped species** (companions then footnote) follow, also by
   **decreasing constancy** — the `.S00` ungrouped vector runs 13, 9, 3, 2,
   2, … down to the 1s.

**The micro residual:** the order *among equal-constancy species within a
group* is not reproduced by the obvious deterministic keys. Tested on group1's
eleven constancy-5 species: not ascending id, not mean relevé-rank (the RA
gradient), not in-block constancy (occurrences within the group's own relevé
set). This is the same character of residual as the group-membership tie-break
(§2e) — a fine ordering detail that lived in COENOS's internal reciprocal
averaging / hand-sort and is not cleanly recoverable from the artifacts.

So the species ordering is **recovered at the method level** (RA group order +
decreasing constancy), with the equal-constancy micro-ordering as a bounded
residual.

## Net: the ordering component

- **Relevé ordering: exact** (up to the CA reflection convention).
- **Species ordering: method-exact** (group order + decreasing constancy);
  equal-constancy tie-break is a fine residual.
- Both depend on the group structure (the relevé-sets `R`), so in the package
  they run on group-formation output; validated here against the oracle `R`
  sets and `.S00` vectors, isolating the ordering logic.

### Package step (future)

Implement `order_table()` (group order via asterisk-RA; relevé order exact;
species order by group + decreasing constancy with a documented tie-break) and
`coenos_table()` to assemble the sorted two-way table; wire on top of
`form_groups()`; validate against the `.S00` vectors. Expose the axis
orientation as a `reflect` convention.
