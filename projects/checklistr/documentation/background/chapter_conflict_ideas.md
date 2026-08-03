# Ideation — Chapter 5, "The Same Specimen, Two Names"

*Working notes. Not prose. Kim steers — and, being the botanist, verifies the
determinations below. This is the first of the two "where experts disagree"
chapters (identity here; nativity in Ch. 7).*

## The core idea

A *determination conflict* is the herbarium contradicting **itself**. The very same
physical sheet is entered into the database twice, and the two entries carry two
different species names. Read naively, the checklist then reports two species where
one plant was pressed — a **phantom taxon**. The conflict is not between two
specimens; it is a single specimen at odds with its own record.

## Why the same sheet appears twice (the BISH/BPBM point)

Every one of these conflicts is a **Bishop Museum** specimen entered under **two
institution codes** — `BISH` and `BPBM` — which are the same herbarium (Bernice
Pauahi Bishop Museum). GBIF receives the sheet from two data streams, so the same
catalog number, same collector, same collection number, same year appear twice.
The two database entries were determined at different moments, by different hands —
and so they sometimes disagree. This is why the conflict is only visible **before
deduplication**: collapse the duplicates and the disagreement collapses with them.
You have to look at the double-entries to see the herbarium argue with itself.
*(This connects back to the dedup chapter's institutional double-entry.)*

## The data — 8 conflicts, one collecting episode

`detect_det_conflicts()` on the raw records finds **8 conflicted sheets** (16 rows).
Nearly all are from the **1979–80 Cuddihy/Anderson survey** — the same effort that
dominates the discovery curve. And they cluster in the **weedy / introduced** flora,
not the native trees: the charismatic natives were determined confidently; the
naturalized weeds, harder and less glamorous to key out, are where the record
wavers. (Worth stating as an observation — conflict concentrates where attention
and confidence were lowest.)

## The typology (the intellectual payoff) — **Kim to verify each call**

The 8 conflicts are not one phenomenon. They sort into four kinds, and each says
something different about how far to trust a name. My proposed classification:

| # | Sheet (coll./no.) | The two names | My reading |
|---|---|---|---|
| 1 | Cuddihy 456 | *Hypochaeris* / *Hypochoeris radicata* | **Spelling** — orthographic variant of one genus; same species. |
| 2 | Anderson 405 | *Carya illinoinensis* / *illinoensis* | **Spelling** — `illinoensis` is a misspelling of the pecan; same species. |
| 3 | Cuddihy 560 | *Cardamine flexuosa* / *occulta* | **Revision** — *C. occulta* segregated from Asian "*flexuosa*"; two eras of determination. |
| 4 | Cuddihy 491 | *Cerastium holosteoides* / *glomeratum* | **Congeneric disagreement** — two distinct mouse-ear chickweeds; a real "which one?" call. |
| 5 | Cuddihy 82 | *Pyracantha koidzumii* / *angustifolia* | **Congeneric disagreement** — two firethorns (cultivated ornamentals). |
| 6 | Cuddihy 544 | *Eriocapitella hupehensis* / *japonica* | **Congeneric disagreement / revision** — Japanese-anemone complex. |
| 7 | Cuddihy 611 | *Corylus cornuta* / *americana* | **Congeneric disagreement** — two hazelnuts (both odd for Hawaiʻi — see note). |
| 8 | Cuddihy 561 | *Ludwigia palustris* / *Leptopetalum biflorum* | **Gross error** — different **families** (Onagraceae vs Rubiaceae); a transcription/catalog error, not a determination. |

Four kinds, four different lessons:
- **Spelling variants** (1, 2): not disagreements at all — noise the name-resolver
  should ideally absorb. They inflate nothing real; they test the plumbing.
- **Taxonomic revision** (3, maybe 6): the science genuinely moved between the two
  determinations. Both names were "right" in their day. This is the honest,
  interesting case — the record preserving a change in knowledge.
- **Congeneric disagreement** (4, 5, 7): two experts (or two moments) made
  different species calls within a genus. A true, unresolved identity question.
- **Gross error** (8): the record is simply broken — two different families on one
  sheet. Not nuance; a mistake worth catching.

**Questions embedded here for Kim:** (a) Do these four readings hold? (b) Item 7
(*Corylus* — hazelnuts) and item 5 (*Pyracantha*) look like cultivated/planted
material rather than wild flora — is that your read, and does it matter for the
story? (c) Item 8 — happy to feature the Ludwigia/Leptopetalum family-level
mismatch as the "error" exemplar, or is it too freakish / possibly a data artifact
you'd rather I re-check against GBIF first?

## Why it matters — two payoffs

1. **Practical:** each unresolved conflict can seed a **phantom taxon**, quietly
   inflating the checklist's count. The flag `det_conflict` marks these so a reader
   knows which names to hold at arm's length. Ties back to completeness: some of the
   "richness" is disagreement, not diversity.
2. **Conceptual:** this is disagreement about **identity** — the first, more
   tractable flavor of "where the experts disagree." It sets up Chapter 7, where the
   disagreement is about **nativity**, and far less resolvable. Identity conflicts
   can often be adjudicated; native-status conflicts frequently cannot.

## Honest caveats

- **Small n.** Eight conflicts is a modest haul; the chapter argues from *kind*, not
  quantity. The point is the taxonomy of disagreement, not its frequency.
- **The flag marks the sheet, not the truth.** `det_conflict` says "this identity was
  contested," not "this is the right name." It is an invitation to an expert, not a
  verdict.
- **Spelling variants shouldn't really count.** Honest to admit that 2 of the 8 are
  orthographic and a better resolver would dissolve them — which itself shows the
  method's seams.

## Proposed section structure

1. **Opening — a plant that is two plants.** One sheet, one collection number, two
   names in the database. The checklist believes in a species that a second look
   dissolves.
2. **`## Why the herbarium holds the same sheet twice.`** BISH/BPBM; the
   double-entry; why the conflict is visible only before dedup. Short.
3. **`## Eight arguments the record is having with itself.`** The table, annotated by
   kind. The centerpiece.
4. **`## Four kinds of disagreement.`** Spelling / revision / congeneric / error —
   what each means for trust. The payoff.
5. **`## Phantoms in the count.`** The practical consequence (inflation, the flag)
   and the bridge to status: identity here, nativity next.

## Figures / data

- `checklistr::detect_det_conflicts()` on the **raw** specimen file (not the dedup
  file — must be raw, or the conflicts vanish). Source for the chapter:
  `G:/My Drive/Projects/checklists/kipuka_puaulu/kipuka_puaulu_specimens.csv`
  (has BISH/BPBM double-entries). Need to copy a raw file into `documentation/data/`
  for the chapter to render — **build task before drafting.**
- The 8-row (paired) conflict table → annotated `gt` table (the centerpiece).
- `det_conflict` column already in `kipuka_puaulu_checklist_generated.csv`.

## Build task before drafting

Copy/derive a raw (pre-dedup) Kīpuka specimen file with the BISH/BPBM double-entries
into `documentation/data/` (e.g. `kipuka_puaulu_specimens_raw.csv`) so
`detect_det_conflicts()` can run live in the chapter. Confirm the function's output
columns match what the table needs.

## Questions for Kim before I draft

1. **Verify the four-way classification** above (and the three embedded botanical
   questions). This is the expert-in-the-loop moment — your calls, not mine.
2. **Emphasis:** star the *typology of disagreement* (my lean — it is the idea), or
   the *phantom-taxon inflation* (the practical hook)? I would open with the phantom
   to hook, then spend the chapter on the typology.
3. **The weed-cluster observation** — worth making (conflict concentrates in the
   introduced/less-charismatic flora), or over-reading 8 cases?
