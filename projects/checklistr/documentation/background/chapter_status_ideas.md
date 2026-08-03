# Ideation — Chapter 7, "Native, or Not?"

*Working notes. Not prose. Kim — the botanist — verifies the biology below. This
is the second and deeper "where experts disagree" chapter: identity (Ch.5) could
be settled by pulling the sheet; nativity often cannot.*

## The grounded numbers (Kīpuka, from the generated checklist)

- Two status sources on each taxon: **GIFT** (global default, `status_gift()`) and
  **Wagner** (the regional authority — *Manual of the Flowering Plants of Hawaiʻi*).
- Where both classify a taxon (111 taxa): **agree 97, disagree 14 → 87% agreement.**
- 49 taxa have no comparison (one source blank) — a coverage/crosswalk gap, caveat.
- `add_status(..., verify_against=)` already writes `status_agree`; the 14 FALSEs are
  saved in `data/status_gift_vs_wagner_disagreements.csv`.

## The core idea

Status is different in kind from every other field in the checklist. A growth form or
a family is (more or less) a property of the plant. **Whether a plant is native is a
*relation* between the plant and the place — and a *judgment* made by an authority.**
The same species is native in one region and introduced in another; and even for one
place, the call can be revised and disputed. So a native/introduced label is never a
fact read off the specimen. It is a claim by whoever classified it.

That makes disagreement between two authorities not an error to be cleaned away but
**the most informative thing the status field produces.** Where GIFT and Wagner agree,
the checklist stands on solid ground. Where they disagree, it has found a taxon that
needs a specialist's eye — and, crucially, the *kind* of disagreement tells you
whether an expert can settle it or whether nobody can (yet).

## The 14 disagreements — TWO kinds (the intellectual payoff) — **Kim to verify**

The 14 are not one phenomenon. My reading is that they split almost evenly into two
fundamentally different situations, and telling them apart is the whole point:

### Kind A — the global source's blind spot (Wagner right; GIFT lacks regional resolution)
Cases where GIFT simply under-resolves Hawaiian endemism. A regional authority knows
these cold; a global database does not. **Heavily ferns.**

| taxon | GIFT | Wagner | note |
|---|---|---|---|
| *Asplenium macraei* | introduced | **E**ndemic | starkest error — an endemic fern called introduced |
| *Cyanea floribunda* | indigenous | **E** | *Cyanea* = iconic Hawaiian endemic radiation |
| *Cibotium glaucum* | indigenous | **E** | hāpuʻu tree fern, endemic |
| *Dryopteris fuscoatra* | indigenous | **E** | endemic fern |
| *Dryopteris hawaiiensis* | indigenous | **E** | the epithet says it — endemic |
| *Alyxia stellata* | **endemic** | I(ndigenous) | reverse: GIFT *over*-calls endemism |
| *Ilex anomala* | **endemic** | I | reverse: GIFT over-endemic |

These are not genuine scientific disputes. Wagner is right; GIFT lacks the resolution.
The lesson: **for endemism, defer to the regional authority.**

### Kind B — a genuine biogeographic debate (nobody can just settle it)
Widespread / pantropical taxa where nativity is *actually contested* — did the lineage
arrive on its own before people, or with/after them? Experts can and do disagree.

| taxon | GIFT | Wagner | note |
|---|---|---|---|
| *Dodonaea viscosa* | introduced | I(ndigenous) | pantropical; genuinely debated antiquity — the flagship |
| *Ipomoea indica* | introduced | I | pantropical morning glory; contested |
| *Persicaria punctata* | introduced | I | widespread; contested |
| *Microlepia speluncae* | introduced | I | pantropical fern |
| *Nephrolepis biserrata* | introduced | I | pantropical fern |
| *Nephrolepis cordifolia* | introduced | I | nativity genuinely debated |
| *Pteris cretica* | introduced | I | cosmopolitan fern |

Here the two sources encode a **real open question**. GIFT sees a species that is
everywhere and guesses "introduced"; Wagner judges the Hawaiian population old enough
to count as indigenous. Pulling the sheet will not resolve it — it is a question of
biogeographic history and interpretation, not identification.

**The deep point:** the flag surfaces both kinds identically (`status_agree = FALSE`),
but they are epistemically different — **Kind A is a resolvable data limitation; Kind B
is a frontier of knowledge.** Distinguishing them is exactly the specialist's job, and
that is the chapter's payoff and the fullest expression of the book's spine ("conflict =
where experts disagree").

**Embedded questions for Kim:** (a) Does the A/B split hold, and are all 14 assigned to
the right side? (b) Are the ferns really the fault line I think they are — spore
dispersal → naturally huge ranges → a global source can't tell a native Hawaiian fern
from an introduced one, *and* Hawaiian fern endemism is globally under-recognized? (c)
Is *Dodonaea* the right flagship, or would *Asplenium macraei* (the starkest GIFT
error) open better? (d) *Nephrolepis cordifolia* and *Microlepia* — Kind A or Kind B in
your judgment? I put them in B but am unsure.

## Why the global source stumbles (the mechanism, once verified)

- **Ferns.** Wind-borne spores give ferns naturally enormous ranges, so "found on many
  continents" — a global source's main cue for "native vs introduced" — fails for them.
  And Hawaiian fern endemism is under-catalogued globally. Result: native/endemic ferns
  get read as introduced. (5 of 7 in Kind A, and much of Kind B, are ferns.)
- **Pantropical flowering plants.** A cosmopolitan weed-shaped species (*Dodonaea*,
  *Ipomoea*, *Persicaria*) looks introduced to a global classifier even where it is an
  old natural colonist.

## Why it matters — the reframe

The disagreement flag is the **product, not a defect.** Running a global default against
a regional authority does not give you a cleaner status column; it gives you a **map of
where global knowledge and regional knowledge diverge** — i.e. exactly the taxa where a
checklist must defer to local expertise, and (for Kind B) the taxa where the science
itself is unsettled. 87% of the time the two agree and you can move on; the 14% is where
the interesting botany lives. This is the payoff of building status as a *relation with a
verifiable authority overlay* rather than baking one answer into the package.

## The bigger idea — aggregation as a knowledge engine (Kim, 2026-07-09) — the chapter's capstone

There is a fundamental point beneath all of this, easy to overlook. **Consolidating
herbaria into very inclusive databases (GBIF, GIFT) produces resources that were never
available to a traditional standalone herbarium.** Our original goal was modest — get a
checklist. But the *analysis* those aggregated resources enable can go **beyond the list
of species to sharpen our knowledge of the species themselves.** A highlighted area of
conflict (a status disagreement) is not a defect in the data; it is **where an
interesting problem lives** — a research question the aggregate has surfaced that no
single collection could have.

This closes a virtuous loop with real institutional stakes:
- The aggregated database, by surfacing these problems, **gains value beyond access** —
  it becomes an instrument for generating new botanical knowledge.
- That added value **should garner increased support** for the aggregation effort.
- And it reframes the ask to **specialty herbaria** (e.g. the **National Tropical
  Botanical Garden** — whose Kauaʻi collections, via Ken Wood, are exactly what let us
  build the ʻIliau checklist in Ch.9): contributing your collection to GBIF is **not
  merely providing an alternative means of access. It is a step in learning more about
  your own collection — and about everyone else's.** Your sheets, set beside the global
  aggregate, get their disagreements surfaced too; you learn where your holdings sit at
  the frontier.

This lifts the whole book's arc: Ch.1 framed aggregation as **access** (reaching
specimens across oceans, closures, danger); this chapter's capstone reframes aggregation
as **knowledge production**. The checklist was the entry point; the conflicts are where
the aggregate starts doing science. It also adds a **third audience** to the "two
readers" — the *contributing institutions*, for whom the argument is: feed the aggregate,
and it feeds your understanding back.

**Placement:** land this as the Status chapter's closing elevation (section 6, below),
AND echo it in the **Limits/Frontier** chapter as part of the book's larger hope. Keep
it grounded — the NTBG/ʻIliau link makes it concrete, not preachy. (Also captured in
`background/source_stories.md`.)

## Contrast with Chapter 5 (the spine tightens)
- **Identity conflict (Ch.5):** the herbarium vs itself; *resolvable* — pull the sheet,
  ask a specialist, one name wins.
- **Status conflict (Ch.7):** authority vs authority; Kind A resolvable (defer to the
  region), **Kind B often not** — it is a live question in biogeography. The book moves
  from a disagreement you can settle to one you sometimes cannot. That escalation is the
  point of putting status last among the conceptual chapters.

## Honest caveats
- **Wagner is an authority, not ground truth.** Best available regional treatment, but
  itself revisable. The chapter should let it win *by default* (regional + specialist)
  without pretending it is oracle-truth.
- **Small n (14) and 49 NA.** Argue from kind, not count; name the coverage gap (a
  species with no Wagner or no GIFT status yields no comparison).
- **Endemic vs indigenous (the Alyxia/Ilex reverse cases)** is a finer, partly
  definitional edge — treat briefly, don't overweight.

## Proposed section structure
1. **Opening — a plant two authorities can't agree is native.** *Dodonaea* (or
   *Asplenium macraei*). Unlike last chapter, you cannot pull the sheet.
2. **`## Status is a judgment, not a fact.`** Relation × place + authority; why status
   differs in kind from every other field.
3. **`## A global default against a regional authority.`** GIFT vs Wagner; 87% agree;
   the `add_status`/`status_agree` mechanism. (Live table of the agreement split.)
4. **`## Fourteen disagreements, two kinds.`** The table, grouped A (blind spot) / B
   (genuine debate). The centerpiece.
5. **`## Why the global source stumbles.`** Ferns + pantropical natives.
6. **`## The disagreement is the product.`** The reframe; resolvable vs frontier; the
   flag points the specialist exactly where to look; bridge to Limits.

## Figures / data
- `data/kipuka_puaulu_checklist_generated.csv` (gift_status, wagner_status, status_agree).
- `data/status_gift_vs_wagner_disagreements.csv` (the 14) → the annotated A/B `gt` table.
- Possible small figure: agreement bar (agree 97 / disagree 14 / no-comparison 49), or a
  stacked native/introduced/endemic composition. Decide when drafting.

## Questions for Kim before I draft
1. **Verify the A/B classification** of all 14 (and the embedded (b)–(d) above). Your
   call — the botany is yours.
2. **Anchor example:** *Dodonaea* (genuine debate — subtle) vs *Asplenium macraei*
   (starkest GIFT error — dramatic) to open?
3. **Framing balance:** how much weight on Kind B (the genuine-frontier story, my lean
   for the emotional core) vs Kind A (the cleaner QA story)?
4. **Wagner's standing:** "the regional authority, still revisable" — agreed as the
   framing, rather than treating it as truth?
