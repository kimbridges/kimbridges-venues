# Ideation — Chapter 4, "How Complete Is It?"

*Working notes. Not prose. Kim steers before drafting. The scale chapter set up
the singleton problem; this chapter is where it comes due.*

## The grounded numbers (Kīpuka, from the generated checklist)

- **160 taxa**, of which **105 are singletons (66%)** and **27 doubletons (17%)**.
- Records-per-taxon: median **1**, 95th percentile **4**, max **9**. The flora is
  abundance-poor by construction.
- **Naive Chao1** (bias-corrected, singletons/doubletons): **≈355 species →
  "45% complete"**, i.e. it claims ~195 species are still unseen.
- Singletons by growth form: graminoids **83%**, shrubs 70%, herb 68%, fern 64%,
  **trees 53%** (the showy, dominant, best-collected group is least singleton-heavy).

## The problem in one sentence

A standard richness estimator, applied to this checklist, says the flora of one of
the best-botanized forests in Hawaiʻi is **less than half known**. That is almost
certainly false — and *why* it is false is the entire chapter.

## Why the naive reading is seductive — and wrong

Chao1 and its relatives were built for **ecological sampling**: catch individuals
in quadrats or traps, and a species seen **once** is evidence of rarity — a glimpse
of a long tail of species you have not yet caught. Many singletons ⇒ big unseen
tail ⇒ extrapolate richness upward. The math is sound *when the assumption holds*.

Here the assumption does not hold. Under **taxonomic collecting** (Chapter 3), a
singleton usually means a species collected **once on purpose** — one good sheet
was enough, so no one pressed a second. The 66% singleton fraction is therefore
largely a **fingerprint of the collecting mode**, not a signal of rarity. Feed it
to Chao1 and the estimator dutifully manufactures ~195 phantom species. The
number is real arithmetic on unreal assumptions.

**The reframe (the payoff):** an abundance estimator run on herbarium data does
not measure the *flora*. It measures the *botanist* — the collecting behaviour
that generated the records. Read that way, "45% complete" is not a richness
prediction; it is a **diagnostic that the collecting was taxonomic**. The estimator
is most useful here as a mirror held up to the data-generating process.

*(Methodological aside worth one honest line: `n_records` is not abundance at all —
it is collection frequency, driven by effort and taxonomic habit. So even the input
to Chao1 is a category error. Incidence-based estimators across collecting events
[Chao2] are a little more defensible, but inherit the same taxonomic-collecting
distortion. The point is not "use a better estimator"; it is "the data are not the
kind these tools assume.")*

## The second signal — and the tension that drives the chapter

There is a different way to ask "how complete?": not from abundance, but from
**time**. When was each species *first* collected here? If the flora were still
being discovered, new species would keep appearing; if it is largely known, the
discovery curve should flatten.

The dated records (86 of the 160 taxa carry a year) show exactly that shape:
- a trickle from **1911** onward,
- an enormous jump in the **1979–80 survey** (≈48 species first-collected then —
  most of the known flora, in one episode),
- then a slow tail: only **~20%** of dated species are new since 1985, **~5%**
  since 2005.

So the two signals **contradict each other**:
- **Chao1 (abundance):** "45% complete — the flora is half-unknown."
- **Discovery curve (time):** "the flora is mostly known; one survey did the work;
  little new in decades."

That contradiction *is* the chapter. It is not a problem to hide — it is the most
honest thing the data can show. The resolution: the abundance estimator's
assumptions are violated, so its pessimism is an artifact; the time-based curve,
read against the known collecting history, is the more trustworthy completeness
signal. Completeness here is better answered by **"has discovery saturated?"** than
by **"how many singletons are there?"**

## Honest caveats — both directions

1. **Some singletons are genuinely rare.** The reframe must not claim *every*
   singleton is a collecting artifact; a few are truly seldom-seen plants. The
   claim is about the *dominant* cause of the 66%, not a universal law.
2. **The digitization gap (GBIF ≠ the flora).** Neither signal sees a species that
   was collected but never digitized into GBIF, or never collected at all. The
   discovery curve can flatten simply because collecting *stopped*, not because the
   flora was exhausted. "Complete relative to the digitized record" ≠ "complete
   relative to the forest."
3. **Undated records.** 74 of 160 taxa lack a year, so the time curve is built on
   a partial set. Worth stating plainly; it caps how hard we lean on the curve.

## Proposed section structure

1. **Opening — the seductive number.** State it flat: a respected estimator says
   this famous forest is 45% known. Let the reader feel the wrongness.
2. **`## The discovery curve.`** The time signal first — cumulative species by year;
   the 1979–80 spike; the flattening tail. Figure: species-discovery /
   accumulation (`species_discovery` / `plot_species_discovery`).
3. **`## What the estimators say.`** Chao1 → 355 / 45%. Present it fairly, at full
   strength, before dismantling it.
4. **`## Why the two disagree.`** The scale lens applied: taxonomic collecting
   inflates singletons; the estimator's ecological assumption breaks; the number
   measures the collecting, not the flora. The reframe.
5. **`## What completeness can mean here.`** Discovery-saturation as the honest
   answer; the digitization-gap ceiling; how to read a checklist's completeness
   without over-trusting either number.

## Two-readers connection

- **Naïve reader:** wants a single "% complete." The chapter's kindest service is
  to show why the tidy number lies, and give a better question in its place.
- **Expert reader:** knows Chao1's assumptions; the payoff is seeing the herbarium
  singleton-inflation *quantified* and named as a diagnostic — and the two-signal
  contradiction laid out cleanly.

## Figures / data

- `data/kipuka_puaulu_specimens_dedup.csv` (has `species`, `year`) → discovery curve.
- `data/kipuka_puaulu_checklist_generated.csv` (has `n_records`) → singleton
  fraction, Chao1.
- Reuse `checklistr::species_discovery` / `richness_estimate` /
  `plot_species_discovery` if their output matches; otherwise inline.

## Questions for Kim before I draft

1. **Order.** Lead with the discovery curve (time signal, my draft plan) and *then*
   spring the Chao1 contradiction? Or lead with the seductive Chao1 number and use
   the discovery curve to overturn it? Both work; the second is more dramatic.
2. **How hard to hit the estimator.** Do we fully retire Chao1 for herbarium data
   ("wrong tool, category error"), or keep it as an explicit *diagnostic of
   collecting mode* — my preferred, more generous and more useful framing?
3. **The `n_records`-is-not-abundance aside.** One honest line in the flow, or a
   fuller methodological box? It is a real point but could derail the narrative.
4. **Estimator scope.** Chao1 only, or also show an incidence estimator (Chao2 /
   jackknife) to make the "even the better tool inherits the problem" point — at
   the cost of more machinery on the page?
