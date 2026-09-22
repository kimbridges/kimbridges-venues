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

## Round two -- 2026-09-22 (Baselines, Deviations & Spans only)

_First session after a nine-day break (family priorities). Icons paused the same
day, awaiting photographs. Documents 2 and 3 not yet revisited. Speaker marked
throughout: Kim's statements and rulings vs Claude's proposals._

### Kim's reframe: the scale this document is about

Kim: people interested in rainfall, temperature and related measurements focus on
either **weather** (daily or weekly; current measurements or short-term
predictions) or **climate** (the long-term average of the short-term data;
climate predictions exist, but at decades or longer). **This document is about
what lies in between** -- more than a day or two, likely a good part of the year.
It is the scale a **farmer** uses to plan the year's crops and the scale a **wine
connoisseur** uses to choose a vintage. We have terms that express patterns at
this scale.

Claude's additions (proposals, not rulings):
- Weather is experienced, climate is computed; the in-between scale is the one
  people **remember** ("the winter of '78", "a late spring", "a good vintage").
- Forecasters call roughly two weeks to a season **subseasonal-to-seasonal
  (S2S)**, a recognized weak spot in prediction. Kim's scale reaches further, to
  the character of a whole season or year.
- The unit of analysis becomes the **season**; snaps, spells and stretches are
  its building blocks. **Timing** relative to the organism's calendar is a new
  axis (frost at budbreak vs in dormancy). A season's signature = *which*
  episodes, *how long*, and *when*.
- The title now names a method: **baseline** = the expected seasonal curve (not a
  single mean); **deviations** = departures from it; **spans** = the episodes.

### Kim's starting vocabulary: spells, stretches and snaps

Kim: these terms are commonly used for weather periods; what is interesting is
coming up with definitions of them. **The endpoints can be defined, but what
goes on in between (the "noise") is ambiguous.**

Formal definitions -- Claude's proposal; **Kim: "They give us a strong baseline
for the discussion."**

| Term | Defined by | Implied baseline | Example |
|---|---|---|---|
| Snap | rate of change: abrupt onset, short | the last few days | a 15F overnight drop |
| Spell | departure past a threshold for a minimum duration | the climate normal | 15 days under 1 mm of rain |
| Stretch | persistence alone; neutral, often pleasant | the run itself | "a stretch of fine weather" |

Snap = deviation from recent days; spell = deviation from the baseline;
stretch = span. Everyday speech made the distinction and never wrote it down.

### The three points -- criteria between definition and implementation

**Kim placed these as the transition** from the formal definitions to the
implementation alternatives:
1. **Noise is relative to the receiver.** Whether one cool day breaks a spell
   depends on the organism's response time; biology sets the gap tolerance, not
   statistics. (Kim's instrument-and-scale theme.)
2. **The sap-flow counterexample.** For maples the freeze-thaw alternation IS the
   signal (the Temperature Periodicity work); a definition that smooths it as
   noise loses the thing that makes sap run. Lens and blinder -- open problem 3.
3. **Relative thresholds manufacture spells everywhere.** Percentile definitions
   give every climate about the same number of "heat waves"; absolute thresholds
   give the biologically meaningful ones. The baseline choice decides whether a
   place has spells at all.

### Implementations -- the most interesting part (Kim)

Kim: **it is how we implement these definitions that is most interesting, as the
implementations show strategies for thinking about the terms themselves.**

Claude: each algorithm is a theory of the word.

| Algorithm | What it claims a spell is |
|---|---|
| Strict run | a uniform condition; any break ends it |
| Gap tolerance (k days) | something that survives interruptions, up to a limit |
| Hysteresis (enter strict, exit lax) | harder to start than to keep going |
| Window mean | a regime, not a sequence of days |
| State model (HMM) | a hidden condition the weather only partly reveals |

Proposed demonstration: run all five on one station record and map where they
disagree -- the disagreement is the finding (the checklistr logic: conflict marks
where the concept is unsettled). Package core: one function per strategy, one
shared output format.

### Two directions, and the groups who use this scale (Kim)

Kim: **it is important to look both directions.** Forward, e.g. conservation --
should we conserve water? Backward -- judging what the season was. **Use the
groups who view this period from the two perspectives as a way to make people
see the importance of this stretch of time.**

Claude's first-pass roster: forward -- water managers, fire agencies, farmers and
ranchers, utilities and public health; backward -- vintners and connoisseurs,
insurers and disaster programs, ecologists, dendrochronologists. Observations:
the directions form a **loop** (the backward judgment becomes next year's forward
baseline); and **nobody reports this scale to the public** -- the news gives
weather, assessments give climate. That is the missing context of Kim's original
TV-weather reaction.

**Kim's ruling: three worked groups first; others brought in once the main
arguments are made.**
- **Fire** (forward; SEQUENCE -- a wet period grows fine fuel, a dry one cures it)
- **Vintage** (backward; TIMING -- Ashenfelter's Bordeaux equation as prior art)
- **Tree rings** (the organism's own record -- one ring, one season)

### Hawai‘i: a test case, not the setting (Kim's ruling)

Kim: he lives and works in Hawai‘i, but it need not be the focus and **might be a
distraction if it gets too much emphasis.** He sees it as **a counterexample, or
a test of whether the principles are general, even for outliers like Hawai‘i.**

Consequences (agreed): the fire case is made in Mediterranean climates
(California, southern Europe, Australia). Hawai‘i gets a closing test chapter --
small temperature amplitude, so rain and wind carry the season (the kau /
ho‘oilo calendar); windward and leeward seasons miles apart; percentile
thresholds inventing spells that do not matter biologically. This also supplies
the counterexample chapter open problem 3 asked for.

### ★ Visual language -- Kim's note, 2026-09-22

Kim: *"I hope we can illustrate what we're creating with a rich set of images,
charts and diagrams. The visual language is going to be important and it will
help tie all the documents together."*

This makes visual language a **trilogy-level requirement**, not per-document
decoration. It strengthens open problem 4's proposal of one shared grammar
package: a single visual vocabulary (baseline, deviation, span, cell) that a
reader learns once and carries across all three documents.

### Working outline -- Baselines, Deviations & Spans (after round two)

1. **The scale** -- between weather and climate; remembered and decided at;
   reported by nobody.
2. **Two directions** -- forward and backward, joined in a loop.
3. **Three worked groups** -- fire, vintage, tree rings.
4. **The vocabulary** -- snap, spell, stretch, each with its implied baseline.
5. **The criteria** -- receiver response time; noise vs signal; relative vs
   absolute thresholds.
6. **The implementations** -- five strategies as theories, and where they disagree.
7. **The test** -- Hawai‘i as the outlier.

### Open problems after round two

1. Title collision (*Maps with Tiles*) -- not revisited.
2. Exposition order -- not revisited; format (three documents) stands.
3. Counterexample -- **answered for Baselines**: the sap-flow case and the Hawai‘i
   test chapter.
4. Package boundaries -- sharpened: the Baselines engine core is the five
   strategies with a common output; the visual-language note adds weight to a
   shared grammar package.
5. Parallel ideation, staged production -- holds.

### Verify before writing -- stated in conversation from general knowledge, not checked

- ETCCDI warm-spell duration index: at least 6 consecutive days above the 90th percentile.
- Historical UK Met Office definitions: absolute drought (15 consecutive days,
  none above 0.2 mm), partial drought (29 days, mean at or below 0.2 mm), dry
  spell (15 consecutive days, none reaching 1.0 mm).
- Ashenfelter's Bordeaux equation: inputs and date.
- The S2S terminology and its stated range.

## Next

Round two continues with *Maps with Tiles* and *Measurements Require
Categories*. **Baselines is ready to outline now** -- Kim was offered outline vs
continuing round two and closed the session before choosing. Then formal intake
if the shape holds. Do not start production writing from this file.
