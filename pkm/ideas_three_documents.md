# Idea capture — the three-document trilogy

_Captured 2026-08-11, first session after Kim's return. Kim's thinking from the
mainland trip, "first round of flight thoughts."_

_Status: CAPTURE ONLY. Formal Mechanism 1 intake — venue / language track,
`proj_*.md`, index rows — deliberately NOT done yet._

**Note on where this file sits.** `deferred.md` records that a broader "ideas
with no home" store is "a separate, harder problem, kept apart for now." This is
a single-topic capture note, not a claim to have solved that problem. If a
general ideas store is later designed, this folds into it.

---

## Kim's outline, as given

Three new documents, tightly to somewhat interrelated, to be **developed in
parallel**. Working titles:

1. **Baselines, Deviations & Spans**
2. **Maps with Tiles**
3. **Measurements Require Categories**

**The overriding philosophical point:** *you don't see something unless you have
a concept of it.*

**Provenance, and its limits — Kim is explicit that neither prior body of work is
the basis of the new document:**

- **Maps with Tiles** ← linked to the **tessellation work with Tom Koch**, but
  not built on it.
- **Baselines…** ← materials developed for **Will McClatchey** on the span and
  frequency of low temperatures, relating to the "Spans" section only.

**Origin of the Baselines document:** a visceral reaction to nightly-news weather
reporting. Weather is presented without climate context. *What's missing is
context* — and that absence is what points at the third document.

**Consequences Kim names:** because tessellations are unfamiliar to most people,
and because the climate/weather visualizations will be new to many, the documents
need **clear expositions and a lot of common-sense examples**. R packages will be
built.

---

## Claude's response, 2026-08-11

Recorded because the framing may be useful later, not because it is settled.

### The unification

Not three applications of one philosophy — **one claim in three registers.** *A
number without its frame is not information.* Categories frame **what**, tiles
frame **where**, baselines frame **how much**. A complete decomposition rather
than an assortment.

### Engines that may already exist — check before scoping

- **`seasonalityr`** (built 2026-06-24) is most of the machinery behind
  *Baselines*: indices, daylength channel, v2 cue-regime classifier, four
  validated regional maps. Extend rather than rebuild.
- **`Koch_voronoi`**, **`plainmaps`**, **`sitemaps`** cover part of *Tiles*.
- **`bbstruct` / `bbSynth` / `coenosr` / `checklistr`** are the instrumentation
  for *Categories*.

### Strongest version of each, and the trap

**Baselines, Deviations & Spans.** Trap: the TV-weather critique is crowded
ground. What is Kim's own is the three-way decomposition, and especially
**span** — *the news reports extrema; organisms respond to durations.* A frost
is not "it hit 30°F," it is "below freezing for seven hours." Degree-hours below
threshold, not the nightly low. Botanically grounded; the McClatchey link.
Second sharp point: **the baseline itself moves** — the 30-year normal is
re-based each decade, so warming partly hides inside the redefinition of
"normal."

**Maps with Tiles.** Trap: a math-appreciation piece about attractive tilings.
Strong version: **every map that shades by area has already chosen a
tessellation, and the choice changes the answer** — the Modifiable Areal Unit
Problem, Kim's own discipline, with gerrymandering as the example readers
already have intuitions about. Voronoi as the contrast: a tessellation generated
*by* the data rather than imposed on it. Thiessen polygons for rain-gauge
catchments; area-per-plant in competition studies.

**Measurements Require Categories.** Most philosophically exposed, so it needs
the most instrumented example — and Kim owns the best one available.
**Braun-Blanquet cover-abundance classes are a category system imposed on a
continuum**; the classes are neither equal-width nor cleanly ordinal; every
downstream analysis inherits the choice. COENOS is reconstructed, the oracles
decoded, and `bbSynth` can show what different class boundaries do to identical
vegetation. Plus species concepts — lumpers and splitters counting one plot and
getting different numbers — where `checklistr` already handles determination
conflicts.

### Open problems raised, not resolved

1. **Title collision: "Maps with Tiles."** *Map tiles* are XYZ / slippy-map
   raster and vector tiles served from a tile server. A technical reader will
   expect a web-cartography how-to. The content is tessellation, partition and
   areal units; the title should say so.

2. **Order: discovery vs exposition.** Kim's listed order is the DISCOVERY order
   — weather led to categories. Logical priority runs the other way: categories
   are prior to partitions, which are prior to baselines. But abstraction has to
   be earned pedagogically, which argues for Categories LAST, as synthesis.
   These pull against each other and do not resolve by preference. **The answer
   determines whether this is three documents or one book in three parts** —
   the largest structural question on the table, deliberately left open.

3. **The trilogy needs its own counterexample, or it is an advertisement.**
   "You don't see it unless you have a concept of it" is true; the inverse is
   equally true and more interesting — **a concept also makes you see what is
   not there, and stops you seeing the alternatives.** Braun-Blanquet classes
   make cover legible and simultaneously stop you noticing the continuum. Lens
   and blinder in the same act. A critical reader looks for this chapter first.
   Pointer: Bowker & Star, *Sorting Things Out*.

4. **Package boundaries must be decided BEFORE parallel writing.** Three
   parallel documents will generate three packages with overlapping utilities.
   The photoPress / photobookr / Photo_Book consolidation has been open since
   May for exactly this reason. Proposal to consider: **one shared grammar
   package plus three thin domain packages** — the reader then learns a single
   visual vocabulary (baseline, deviation, span, cell) that transfers across all
   three documents. That binds the trilogy harder than cross-references do.

5. **Parallel ideation, staged production.** The cross-pollination is real and
   cheap now; develop all three outlines together. Writing three simultaneously
   is the failure mode — 28 `proj_*.md` currently read Active, and the
   fully-specified Smart_Car charter has been dormant since 2026-05-08.

---

## Kim's rulings, 2026-08-11

Given at the close of the capture session, in response to the points above.

1. **THREE DOCUMENTS, not one book** — though Kim is explicitly **open to
   analysing this further**. Open problem 2 is therefore narrowed, not closed:
   the format is decided, the exposition order is not.

2. **Outlines first, and NOT all three written at once.** Confirms the
   parallel-ideation / staged-production split. Kim: *"I don't want to get
   ahead of myself on projects."*

3. **Reuse the existing packages; do not reinvent.** Kim: there are a lot of
   useful tools in the existing packages and they will be used. Open problem 4
   (package boundaries) is still live, but the default is now extension of
   `seasonalityr`, the Voronoi/mapping code and the Braun-Blanquet cluster.

4. **Today's goal was documentation of thinking, not project initiation.**
   Kim: *"That's one of the deep values of the PKM, in my view."* Recorded
   because it names what this file is FOR, and guards the next session against
   reading a capture note as a mandate.

## ★ THE INVERSE — promoted by Kim to a general working principle

**This is the most consequential item in this file, and it is Kim's ruling,
not a suggestion in passing.**

The point raised was that *"you don't see something unless you have a concept
of it"* has an equally true and more interesting inverse: **a concept also
makes you see what is not there, and stops you seeing the alternatives.** A
category system is lens and blinder in the same act.

Kim's response, 2026-08-11: *"That's the kind of thread that's needed in
everything we do. It relates, in a vague way, to the way a scientist tries to
disprove things."*

**So this is not a chapter idea for one document.** Kim has connected it to
falsification — the discipline of attacking one's own claim rather than
accumulating support for it. That makes it a candidate for a PKM-level
principle rather than a trilogy-level one, sitting naturally beside the
absence-claims rule on `pkm_card.md`: *never assert something is missing
without proving it* is the same instinct applied to evidence, and this is it
applied to concepts.

**Deliberately NOT acted on unilaterally.** Whether it belongs in
`pkm_findings.md`, on the card, or stays here as a documents-level thread is
Kim's call, and the card carries a hard 6 KB budget. Raised here so the next
session finds it. *Raised by Claude, elevated by Kim, 2026-08-11.*

---

## Next

Round two of Kim's thinking, then outlines, then formal intake if the shape
holds. Do not start production writing from this file.
