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

### Round two, cont. -- 2026-09-22 (evening sitting)

**Title (Kim accepted the suggestion):** ***Spells, Stretches and Snaps*** --
*Reading the Scale Between Weather and Climate*. **Short name: S3** (Kim).
*Baselines, Deviations & Spans* is retired as the title and kept as the heading
for the method chapters (criteria and implementations).

**Operational definitions (Kim).** S3 shows that definitions are operational --
Kim recalled Bridgman, correctly (Percy W. Bridgman, *The Logic of Modern
Physics*, 1927: a concept means the set of operations that measure it). Claude:
taken strictly, five operations = five concepts; "spell" is five ideas sharing one
word. The Part 6 disagreement map makes Bridgman's problem visible -- where the
operations agree the word is safe; where they diverge it covers several concepts.
**Boundary ruling (Kim): S3 introduces or references Bridgman lightly;
*Measurements Require Categories* gives the full treatment.**

**"No concept, no seeing" works at several levels in S3 (Kim).** Kim named two --
the gap between weather and climate, and the five implementations (not all
familiar, hence not seen) -- and noted they are likely related. Claude's framing,
three nested levels:

| Level | Concept | Unseen without it |
|---|---|---|
| Scale | the band between weather and climate | the band itself -- nobody reports it |
| Vocabulary | snap, spell, stretch | episodes as units (and the gaps: no "heat snap") |
| Operation | the five implementations | spells a strict run breaks apart |

The inverse (every concept also blinds) is carried by the Hawai‘i test. The thread
runs through the existing parts rather than adding one: scale -> Part 1,
vocabulary -> Part 4, operations + Bridgman -> Parts 5-6, inverse -> Part 7; a
short opening states the claim. **Visual consequence:** since unfamiliar concepts
go unseen, the figures are how the concept is delivered -- all five
implementations drawn on the same series, side by side.

**Readiness (agreed at the close of the sitting).** S3 has enough to outline:
title, thesis, scale, three worked groups, vocabulary, criteria,
implementations, test, the visual-language requirement, the Bridgman boundary.
Still open, and deliberately left for later because the other documents bear on
them: data choices (station record; vintage and fire data sources), package
boundaries, the verify list. **S3 PAUSED here by Kim** so another document can
be developed and feed back into it.

### ★ FRICTION -- a major component of S3 and of the trilogy (Kim's ruling, 2026-09-22)

Kim: **"We need to add 'friction' as a major component to the S3 document ...
We need to make sure we don't forget it."** It arose in the *Maps with Tiles*
discussion below and applies to all three documents.

The trilogy now has **two spines that feed each other**: a CONCEPTUAL one (no
concept, no seeing) and a PRACTICAL one (friction). Friction keeps a concept
unfamiliar; an unfamiliar concept never earns the effort to lower its friction.
The documents exist to break that loop. (Same theme as the briefing-book method
spine.)

Friction in S3, first pass (Claude, not yet discussed): at the SCALE level,
seasonal summaries are not packaged anywhere -- they must be built from daily
records; at the OPERATION level, anything beyond a strict run takes code most
people do not have (hysteresis, HMM). Remedy: one function per strategy, shared
output, worked examples.

## Maps with Tiles -- round two, 2026-09-22 (evening)

_Title work deferred by Kim ("that can come later")._

**Kim's perspective as an ecologist (vegetation bent).** The familiar maps: a
base (street map or satellite image) with points, sometimes scaled for a value
or coloured for a category; with values, an **isopleth** (contour) map after
interpolating to a grid; a **choropleth** with predefined areas (census units,
political boundaries) coloured by category with a legend. **Vegetation maps are
generally the choropleth type: the ecologist does an "entitation"**, viewing the
area to pick boundaries of relatively homogeneous stands. **What is missing: the
map with CATEGORY data at points, where each point's category extends as far as
it can before meeting an adjacent category's area -- a set of tiles -- showing
each point's "influence."** Kim: we are not familiar with it because of the
computational complexity of drawing the tiles; people do not do it by hand, as
they do the others. **Overlooked** outside geography (and maybe public health):
colleagues would not recognise "Voronoi tessellation" or "Thiessen polygons."
For vegetation it may be the better way to show pattern from samples. **People
find it hard to draw good maps; technical difficulty may also limit conceptual
understanding.** Same shape as S3: familiar methods plus one overlooked one.

**Claude: the five types as a grid** -- rows = where boundaries come from (none /
computed / given / judged); columns = values vs categories at points. Voronoi
fills the "categories + computed" cell: **the categorical counterpart of the
isopleth.** The structure makes the missing type visible (the trilogy's thesis
in a figure).

**Kim's rulings and additions:**
- **"Reproducible", not "objective"** (Kim accepted the correction).
- **Voronoi's real role:** when clear pattern information exists, the expert
  draws good lines; often it does not, **so no lines are drawn and the analysis
  is incomplete.** Drawing a good vegetation map is a considerable barrier.
- **"Friction is a really big idea for this."** If a simple map has high
  friction, nobody considers complex ones (e.g., the arguments over grid
  interpolation). **Mapping was hard; now, not so much -- examples will really
  help** (Kim liked the short R code idea).
- **Knowing there are just a few kinds of maps makes the problem of creating a
  map much simpler.**
- **Decision tree (Kim, 2026-09-22):** attached as a model -- Andrews, Klem,
  Davidson, O'Malley & Rodgers (1981), *A Guide for Selecting Statistical
  Techniques for Analyzing Social Science Data*, 2nd ed., ISR, Univ. of
  Michigan. Map choice can be shown the same way; "for us, it is a much smaller
  decision tree."
- **No suitable vegetation map in hand**; Kim will try to find one (needed for
  the overlay example: plots with coordinates + an expert-drawn map of the same
  site).

**Claude's proposals (not ruled):** two versions of the tile map -- RAW (tile
size
shows sampling density and extrapolation, i.e., its own uncertainty) and
DISSOLVED (the category pattern); Voronoi's assumptions (boundaries halfway and
straight, nothing between points counts, edge clipping) -- each method shows and
hides; Braun-Blanquet link (preferentially placed releves re-encode the expert's
entitation -- feeds *Measurements Require Categories*); the barrier moved from
computation to concept (`sf::st_voronoi`, `deldir`); **overlay the Voronoi map on
the expert map where one exists -- agreement = support, disagreement = the
expert saw something between samples, or sampling is thin -- the same device as
S3's disagreement map, possibly trilogy-wide**; good defaults end the
interpolation arguments; **a spell is a one-dimensional tile** (shared visual
element with S3); history to check with Tom Koch -- Thiessen 1911; Snow's
equal-walking-distance line around the Broad Street pump.

**Draft map decision tree (Claude, end of the evening sitting; not yet discussed):**

```
What is at your points?
+- Location only ---------------------------------> Dot map
+- A VALUE (a measurement)
|   +- Where do boundaries come from?
|       +- Given (census units, counties) --------> Choropleth (values)
|       +- None; show each point -----------------> Proportional symbols
|       +- Computed; a continuous surface --------> Isopleth (interpolate + contour)
+- A CATEGORY (a class)
    +- Where do boundaries come from?
        +- Given ---------------------------------> Choropleth (categories)
        +- Judged; pattern visible in the field --> Expert vegetation map (entitation)
        +- Computed; pattern not visible ---------> VORONOI TILES (raw -> dissolved)
```

Two questions, seven outcomes. Voronoi lands where no other method answers; if
the expert branch also applies, it leads on to the overlay. Each terminal box to
carry what Andrews's boxes carry: a one-line description, a few lines of R, and
where to learn more. **Andrews parallels:** empty terminal boxes = "no known
technique" (our empty cell); Appendix B, programs that compute each statistic
(friction reduction, 1981); Appendix C, "new or rarely used techniques" (the
overlooked method). His root question -- scale of measurement -- is the subject
of *Measurements Require Categories*.

## Measurements Require Categories -- round two, 2026-09-23

_Speaker marked throughout: Kim's statements and rulings vs Claude's proposals._

### Kim's foundational ideas (as given)

1. **Every measurement comes with a classification system.** The categories give
   the values meaning; a measurement alone has little value.
2. **The scale is always there, formal or not.** A physician applies body
   temperature to an agreed scale ("normal", "ill", "very sick", "emergency" --
   not the doctor's terms, but the idea); the nightly weathercast applies a
   looser, unspoken one.
3. **The unit-switch test.** Give someone the forecast in unfamiliar units (C for
   F) and they pause to convert before the number means anything -- unless they
   grew up with those units.
4. **Learning the scale is part of education**, often not explicit -- exposure
   and experience.
5. **Switching units has friction, often a lot.**
6. **A new device teaches how to measure, rarely the scale**, though the two are
   inseparable -- partly because one measurement can have several scales by
   purpose (medical diagnosis vs outdoor comfort).
7. **Accuracy matters near a boundary.** Mid-category, error hardly matters; near
   a border we employ statistics to decide which category a value falls in.

**Round two, cont. (Kim):**
- **Scales can DESCRIBE without a decision** -- Colorado's 14,000 ft peaks; the
  tree line. Eliciting behaviour is one use, not the only one (Kim likes the
  behaviour thread).
- **Comparison supplies a scale when the absolute value has none** -- runs
  scored judged against the opponent's; the behaviour is "Team A won"; the
  comparison is itself categorised ("squeaked by", "clobbered").
- **External models set categories** (e.g. a theoretical limit).
- **History sets categories** (most HR in a season; top-10 fastest 100 yards) --
  boundaries move over time for membership.
- **Personalisation.** Kim's Smart Car gauge (8 bars): 3 bars = look for the
  favourite brand; 2 = any brand; 1 = AC off, slow down, look carefully. Others
  differ -- urban drivers with frequent stations vs Kim on remote Interstate.
- **Several measurements combine into one category** -- Whittaker diagram,
  temperature + humidity comfort index, soil categories from three measurements.
  **Kim: make this a chapter.**
- **Categories are not always the same size (not linear), and can be "lumpy"** --
  different characteristics in different categories (Braun-Blanquet mixes cover
  and abundance).

### Kim's rulings

- **BACKBONE: "where do boundaries come from"** (Kim: "I really like" it).
- **All of Claude's points below are correct and belong in the argument** (Kim).
- **Chapters 7 and 8 belong** -- "strong additions".
- **Working title KEPT: *Measurements Require Categories*** -- descriptive.
- **Examples added as we go.**

### Claude's proposals (accepted as part of the argument unless marked)

- Point 6 is Bridgman from the user's side: the device gives the operation, not
  the meaning. Full Bridgman treatment lives here.
- Behavioural scales are indexed by decisions -- boundaries mark where you act
  differently; different purposes, different boundaries.
- Required precision varies along the scale, peaking at boundaries (a figure).
  Metrology formalises this as guard bands / decision rules.
- Boundaries move while measurements stand still (2017 US blood-pressure
  guideline) -- S3's re-based normal in another register.
- Institutions publish the category, not the number: UV index, AQI colours,
  fire-danger ratings, Saffir-Simpson.
- Spectrum of binding: value vs unspoken scale -> value vs formal scale ->
  category recorded instead of value (Braun-Blanquet, Beaufort, texture by feel,
  the gauge's 8 bars).
- The inverse: "normal" is a population scale; a patient a degree above their
  own normal is still "normal" -- S3's baseline problem; the counterexample.
- Convention categories are unit-bound: "fourteener" exists only in feet
  (~4,267 m); the Alps' 4000ers are a different set.
- Rank categories behave like S3's percentile spells: a top-10 always has ten.
- The gauge categorises twice: hardware bins to 8 bars; the person lays
  behaviour on the bars. The cost of being wrong places the boundaries.
- Combining measurements: PARTITION the joint space (Whittaker, soil triangle)
  vs COLLAPSE to an index then categorise (heat index, wind chill). A partitioned
  measurement space is a tile map -- Whittaker's biome lines are judged, like the
  expert vegetation map; could be computed (Voronoi in climate space) with
  `whittakerr`. With two inputs the error is an ellipse; at class junctions one
  reading can fall in several classes. Soil fractions sum to 100%: three
  measurements, two degrees of freedom.

**Backbone table (draft):**

| Source of boundary | Example |
|---|---|
| Nature | tree line, freezing point |
| Convention | 14,000 ft |
| Agreement | fever, hypertension |
| Comparison | runs vs the opponent's |
| Model | theoretical limit; heat index |
| History / rank | season HR record, top-10 |
| Person | the fuel-gauge ladder |

Crossed with use: DESCRIBE vs ELICIT BEHAVIOUR.

### Working outline -- Measurements Require Categories (after round two)

1. **The claim** -- every measurement has a classification; temperature as the
   running example; the unit-switch test.
2. **Learning the scale** -- tacit, experience; devices teach the operation, not
   the scale (Bridgman, full treatment); unit friction.
3. **Two uses** -- describe vs elicit behaviour.
4. **Where boundaries come from** (the backbone).
5. **Boundaries and error** -- precision near boundaries; statistics to assign;
   cost of error sets the boundary; boundaries move.
6. **Several measurements, one category** -- partition vs collapse; Whittaker as
   a tile map in climate space; the error ellipse.
7. **Categories instead of measurements** -- Braun-Blanquet, Beaufort, texture by
   feel, gauge bars; unequal and "lumpy" categories; `bbSynth` shows what class
   boundaries do to identical vegetation.
8. **The inverse** -- categories blind as well as reveal; the personal baseline
   hidden inside "normal". The counterexample chapter.

**Still open:** worked examples with data for chapters 5-7.

### Verify before writing

- 38.0 C fever threshold; 2017 AHA/ACC hypertension change (130/80 from 140/90).
- Metrology guard bands (ILAC G8, JCGM 106).
- Beaufort scale history; Alps 4000ers count (82, UIAA list).
- NWS heat index categories; Steadman's heat index model.
- USDA soil texture classes (12); Braun-Blanquet class definitions (r, +, 1-5).

## The trilogy as a set -- 2026-09-23

### Kim's rulings

- **UNIFYING STATEMENT: "boundaries in value, space and time."** *Measurements
  Require Categories* = value; *Maps with Tiles* = space; S3 = time. (Sharpens the
  2026-08-11 what / where / how-much framing.)
- **Reading order: *Measurements Require Categories* FIRST** in the series. Open
  problem 2 (exposition order) is therefore settled; format (three documents) stood
  already.
- ***Maps with Tiles* kept as the working title; short name MWT.** Candidate later
  title: ***The Missing Map*** -- parallel to S3's missing scale between weather and
  climate.

### Claude's observations (accepted with the unifying statement)

- The MRC backbone ("where do boundaries come from") contains MWT's four boundary
  sources (none / given / judged / computed); S3's "endpoints definable, middle
  ambiguous" is the same question in time.
- The TILE runs through all three: a spell is a one-dimensional tile (a DISSOLVED
  one); the Whittaker diagram is a tile map in climate space. The central element
  of the shared visual language.
- Judged vs computed boundaries in all three; disagreement-as-finding in all three
  (one figure style could serve the trilogy).

### Writing ruling -- personal stories (Kim, 2026-09-23, at the close)

Kim: **load the trilogy documents with personal stories** -- "We've done this with
many other documents. I'd like to keep doing it here." Applies to all three. In
hand already: the coconut-palm count on the islets of Ailinginae Atoll (optional
opening for MWT ch.9) and the fuel-gauge ladder on remote Interstate legs (MRC).
More to gather as writing begins.
## MWT -- round two, cont. 2026-09-23

### Kim's rulings

- **Chapter outline accepted** (below).
- **Counterexample = the CONTINUUM** (Kim: "does work"). Vegetation often changes
  gradually; tiles draw sharp lines through ecotones -- Gleason vs Clements; the
  same move MRC criticises in Braun-Blanquet classes.
- **The counting frame (the Koch method) is its own chapter.** Tiles generated
  from one dataset, items counted within them from another. Kim: a vegetation map
  with Voronoi tiles as units, then counting occurrences of a species or of
  diseased plants within each unit to enhance the description of the vegetation;
  "counting within units could be a very common application." **The point: the
  items counted are located INDEPENDENTLY of the area mapping.**
- **Example: neutral -- invasives or diseased plants.** Not coconut palms (Kim's
  memory of counting them on the islets of Ailinginae Atoll; available as an
  optional opening anecdote for the chapter, not required).

### Raw vs dissolved tiles (Claude's elaboration; Kim: "all of that makes sense")

- RAW: one tile per sample, coloured by its category; all boundaries drawn. Shows
  the EVIDENCE: tile size is the inverse of sampling density; large tiles =
  extrapolation; edge tiles sized by the study-area clip, not the data.
- DISSOLVED: adjacent same-category tiles merged; only category-change boundaries
  remain -- the vegetation-map look, comparable to the expert map. Shows the
  PATTERN; hides evidence (one-sample patch looks as solid as a thirty-sample one).
- Each dissolved boundary is the halfway line between two disagreeing samples, so
  its positional uncertainty is ~half their spacing -- LOCAL and COMPUTABLE. Figure:
  boundaries drawn as bands of that width. Links to MRC ch.5 (error matters at
  boundaries); here the tiles say how much.
- A spell is a dissolved 1-D tile (S3 link). Code is a few lines of `sf`.

### Counting frame -- consequences (Claude; Kim: "all of that makes sense")

- In the MWT grid it is the VALUE + COMPUTED-boundary cell (a choropleth whose
  units come from data) -- it fills another cell, it does not compete with the
  missing map. Tiles do two jobs: extend a category, or serve as a container.
- Counts need a denominator (density, or observed vs area-expected -- the
  epidemiological move).
- Raw vs dissolved changes the counts: MAUP in miniature (links ch.6).
- Independence can fail: plots placed BECAUSE the item was there (preferential
  sampling; MRC link).
- Counted items can carry their own category (healthy / diseased).
- Sources of counted locations: GPS, aerial/drone imagery, herbarium records
  (`checklistr`), iNaturalist.
- Koch caution: credit the collaboration; do not depend on Tom's data or timing
  (Phase 2 paused). The vegetation version is Kim's own (e.g. herbarium specimens
  per relevé tile = collecting effort by vegetation type).

### Working outline -- Maps with Tiles (MWT), after round two

1. **Only a few kinds of maps** -- the type grid (boundary source x values /
   categories); the empty cell made visible.
2. **The familiar maps** -- dot, proportional symbol, choropleth, isopleth; each
   with its boundary source (MRC backbone link).
3. **The ecologist's map** -- entitation; good lines when pattern is visible, no
   lines when it is not.
4. **The missing map** -- Voronoi tiles from category points; Thiessen 1911,
   Snow's line (check with Tom Koch); reproducible, not objective.
5. **Friction** -- mapping was hard, now not; short R code; good defaults.
6. **Reading the tiles** -- raw vs dissolved; boundary uncertainty; assumptions
   (halfway, straight, nothing between points, edge clipping / study area).
7. **Choosing a map** -- the Andrews-style decision tree.
8. **The overlay** -- tiles over the expert map; agreement / disagreement;
   preferential releves (MRC link).
9. **Tiles as containers** -- the counting frame; invasives / diseased plants.
10. **The inverse** -- the continuum; ecotones; Gleason vs Clements.
11. **Tiles beyond maps** (optional) -- spell as 1-D tile; Whittaker as climate-
    space tiles.

**Still open:** a worked site with plots + an expert vegetation map (Kim
searching); an invasive / disease point dataset for ch.9.

## MWT and the Voronoi document -- 2026-09-25

### Kim's reframe: a fair comparison needs boundary data

A Voronoi map uses only category data at points. An expert vegetation map starts the same way (releve
points -> categories) but its BOUNDARIES come from extra information -- once the air photo, now the
satellite view. **Comparing the two is not fair: one used more data, specifically about boundaries.**
Kim's question: can a small set of Voronoi sites plus **canopy height** -- in important ways equivalent
to seeing vegetation-zone changes on imagery -- get closer to a professionally drawn map? His aims:
**"the enemy of good is better"** -- a new, reproducible technique giving a good first approximation;
few people know canopy-height data exist; it may cut the number of releves needed (releves are
expensive = friction); **getting a map and judging whether it is "good enough" is a research strategy.**

### The prototype -- Kipuka Puaulu (accepted by Kim)

Structure-constrained Voronoi: canopy height (Meta/WRI 1 m) -> four structure classes -> each cell takes
the category of the nearest releve in the SAME class. 12 releves, 3 per class, stand-in categories.
Plain vs constrained disagree on 66% of the area. Kim: "realistic boundaries and an appropriate
classification"; "two relatively unknown technologies ... combine into something that's very
informative." Detail, caveats and code: `proj_Voronoi.md`; `Projects\Voronoi\prototype\`.

### Claude's points (discussed; the design choices Kim took up)

- Three ways to combine: segment-then-label; cost-distance (geodesic) Voronoi; nearest releve in
  position + structure space. The prototype is the simplest variant of the first two.
- Canopy height sees STRUCTURE, not composition: it finds forest / shrub / open and stand-age edges,
  misses boundaries where species change at similar height; and it draws edges that are not type
  boundaries (treefall gaps) -- hence smoothing and a minimum mapping unit.
- Releve heights could set the structure breaks, so the data decide which height change is a
  category change.
- Test design: plain Voronoi / Voronoi + canopy / expert map; **agreement vs number of releves, with
  and without canopy height** is the figure that answers "fewer releves".
- Patches with no releve are flagged, not guessed: the map also says where the next releve goes.

### ★ Kim's ruling -- a SEPARATE Voronoi document, finished first

The Voronoi technology gets its own methods document (`proj_Voronoi.md`), **completed before the
technology is discussed in the trilogy.** Consequences for MWT:
- MWT keeps the CONCEPT -- only a few kinds of maps; the missing map; boundary sources -- and cites the
  Voronoi document for mechanics.
- **One worked example stays in MWT: Kipuka Puaulu, in ch.8 (the overlay), as argument** -- a fair
  computed map must borrow boundary information too. This refines ch.8: the comparison is plain
  Voronoi / Voronoi + canopy / expert map.
- Ch.5 (friction, R code), ch.6 (reading the tiles), ch.9 (tiles as containers) and ch.11 (tiles
  beyond maps) shrink to summary + reference; their substance moves to the Voronoi document.
- **The MWT type grid gains a cell:** categories at points + boundaries COMPUTED FROM A CONTINUOUS
  SURFACE -- entitation made reproducible. The decision tree's "Computed; pattern not visible" branch
  may split on whether an auxiliary surface exists.
- Kim's outline for the new document (use cases; per-cell statistics; weighted Voronoi; "once
  partitioned, ask") is recorded in `proj_Voronoi.md`; its line on the limit (no outside information,
  e.g. rivers) is answered by the Kipuka Puaulu result.

_Still open for MWT:_ an expert vegetation map for the overlay; an invasive / disease point dataset.

## Rehearsals ideas that argue for the trilogy (2026-09-29)

_Kim: "I'm wondering if we're building arguments for the trilogy." Claude's mapping, not yet ruled. Source notes: `ideas_rehearsals.md`._

- **AI and borders** -> MRC backbone (where do boundaries come from) and MWT ch.1-2 (boundary sources none / given / judged / computed). AI makes computed boundaries cheap (FRICTION spine) and can pass a judged boundary off as computed: "a hand-drawn map in disguise". Honolulu's several official urban-core borders = one place, several boundary sources.
- **Drought** -> ALL THREE, the first example to span the unifying statement: value (drought classes; "history sets categories" -- drought is defined against the historical record; several measurements -> one category, MRC ch.6), space (Thiessen tiles, MWT ch.4), time (a drought IS a spell, S3). Candidate running example for the trilogy.
- **Gauge network change** -> MWT ch.6 (tiles show coverage; tiles grow as gauges close), S3 (a changing network breaks a baseline), MRC ch.8 (the inverse: "normal" computed from a network that changed).
- **METAR coverage (Kim)** -> MWT ch.6: tile area and farthest border as the reach of the data; the nearest station can be the wrong one (MRC: distance is not similarity).
- **Supplement, not replace; spectral maps fail to scale (Kim)** -> MWT ch.3 (the ecologist's map, entitation) and ch.8 (overlay); CONCEPT spine: the satellite's categories see only the canopy -- the inverse (a concept blinds as well as reveals); scale as a stated choice (MRC ch.5).
- **Botanical gardens (Kim)** -> MWT ch.8 (the garden's unit map as the expert map); preferential sampling (MRC link already in the MWT outline); personal stories (Kim and Nancy's garden visits) per the 2026-09-23 writing ruling.
- **Campsites in a purchased forest (Kim)** -> MWT ch.6 and ch.9 (reading tiles; trees counted in tiles); points placed by judgment.
- **Skyline station a block from Kim's window** -> personal story; walking-distance tiles (Snow's line, MWT ch.4).
- **The cautions checklist** -> THE INVERSE / falsification principle in practice: each item is a way to attack one's own map before trusting it.
- **Choropleth vs tessellation (Kim, evening)** -> MWT ch.2 (the familiar maps and their boundary sources: given vs computed) and ch.6 (reading the tiles); candidate chapter title "the least information, the most color"; tiles as containers = a choropleth with computed boundaries (MWT ch.9).
- **Points and their service areas; sprinklers vs traps (Kim)** -> MWT ch.1 (one operation, many uses) and ch.9 (counting in service areas -- the reader arrives "half way there").
- **SCALE runs through everything (Kim's ruling, close)** -> S3 already opens on scale in time; the rehearsals add scale in space (lawn -> garden -> kipuka -> city -> island). Candidate thread for the trilogy beside the two spines (concept, friction).

## Measurements Require Categories -- round three, 2026-10-30

_Kim redirected from PubMaps to MRC: time away from the mapping work, "a different perspective". Speaker marked._

### Kim's ideas and rulings

- **Took up approach 3 (AI and tacit scales) and reframed it as CONTEXT.** There is a generally held view of a
  boundary, but context (Honolulu vs Fairbanks) shifts it. The terms for outside air temperature differ sharply
  between the two.
- **"Thin blood."** People from Hawai‘i say they have "thin blood" when they complain of cool temperatures on
  mainland trips. We retain our personal temperature/comfort scale, and it likely differs from the local people's.
- **THE OPPOSITE: fixed boundaries.** Boundaries can be fixed, e.g. by statute, even where a flexible (contextual)
  approach might be better. **Twilight**: a rigidly defined category with different impacts from far north to far south.
- **RULING: fixed and contextual boundaries are PAIRED IN ONE CHAPTER.**
- **On the examples:** these are more interesting examples that people will understand; in some cases (the far
  north) readers may not be aware how important the context is.
- **Kona coffee school year.** On the Big Island the school year (session vs break) was defined differently from
  the other islands: the break was shifted to the coffee harvest because students were needed to pick. Compare the
  temperature season that defines the school year in temperate areas.

### Claude's proposals (NOT yet ruled unless marked)

- **The label is fixed, the number moves.** "Cold" is ~60 F in Honolulu and far below zero in Fairbanks; the word
  marks the same category in both places. The cleanest statement yet of the MRC claim.
- **Two scales meet.** A local forecast is written for the local scale; the visitor applies a home scale. Counterpart
  to the unit-switch test: the traveller can convert the units but not the scale.
- **The carried scale has inertia -- S3 inside a person.** A comfort boundary behaves like a running baseline of the
  climate one has lived in; it shifts after a move, slowly. Links MRC to S3 through a person, not a chart.
- **A fixed boundary is always fixed in SOME variable; choosing the variable decides where context returns.**
  Civil twilight is fixed in sun angle (6 deg) and its DURATION varies with latitude; statutes (headlights, hunting
  hours) fix it in CLOCK time ("30 minutes after sunset"), a mid-latitude proxy for dark enough. The two fixed
  definitions disagree in the far north. Kona follows the same pattern: the break fixed by HARVEST, not by heat.
- **Daylight saving time** -- a fixed clock rule whose benefit depends on latitude; Hawai‘i opted out. Hawai‘i as
  test case, per the S3 ruling.
- **The trade-off.** Fixed buys uniformity, enforceability, comparability and low friction of APPLICATION; the cost is
  poor fit at the extremes. Contextual buys fit; the cost is the friction of KNOWING the context and lost
  comparability. Hybrid: speed limits (fixed numbers, posted by context). Fixed: 0.08 BAC, age 18, 38.0 C fever.
- **Chapter title candidate:** "Fixed or contextual: who chooses the boundary, and in which variable." Proposed
  placement after ch.4 (where boundaries come from) -- PLACEMENT NOT YET RULED.
- **Worked example for approach 3:** LLM-elicited boundaries for comfort words (cold / chilly / pleasant / warm /
  hot) in 20-30 cities, plotted against each city's climate; checked against NWS local criteria as an independent
  source; Kim's carried scale as the testable outlier. The AI as an INSTRUMENT for eliciting tacit scales, not an
  authority. All R, no maps.
- **Possible backbone addition:** PURPOSE / ECONOMY as a boundary source (the harvest sets the school break).

### Kim, cont. -- surf height, conformity, language

- **Surf height** is an interesting example, and one that CHANGED in Kim's lifetime (through external influences?).
- **Conformity** -- "probably a soft way of saying standardization" -- may be a theme the surf case raises.
- **How a language holds the categories.** Much folk mythology about one language having X words for Y where
  another has only Z. Kim believes WIND is an example in Hawaiian. His thought: a language may be either a
  BARRIER to category creation or an AID to more (and better understood) categories.

### Claude, cont. (NOT yet ruled)

- **Surf is a change of OPERATION, not of category -- Bridgman again.** The Hawaiian scale and face height measure
  different parts of the same wave; the switch moved the number, not the wave. Old-timers keep the Hawaiian
  number: the carried scale again. Pressure for the switch likely came from a global audience (forecast sites,
  visitors) and SAFETY -- a visitor hearing a Hawaiian-scale number underestimates the wave.
- **Standardization belongs in the fixed-or-contextual chapter** as the force that pushes boundaries and units
  toward fixed: who pushes (state, commerce, safety, a global audience) and what is lost (local fit, identity).
- **Hawaiian winds and rains are named BY PLACE** -- the language builds context into the category itself, the
  opposite of standardization. A named rain is not "light rain" but the rain of a particular valley.
- **The folk myth has a name:** the "Eskimo words for snow" story (Boas -> Whorf -> Pullum's debunking). The
  defensible version: vocabulary follows NEED and EXPERTISE (skiers, surfers, meteorologists, Braun-Blanquet);
  language STORES and TRANSMITS categories rather than permitting or forbidding perception.
- **Evidence that language moves a boundary:** categorical perception -- Russian speakers discriminate blues faster
  across their light/dark-blue word boundary. A boundary in language is measurable at the boundary, which ties to
  ch.5 (precision matters near a boundary).
- **Ethnobiology as the counterweight:** Berlin's work suggests folk taxonomies converge across languages at the
  generic level -- NATURE constrains the categories. Kim's discussionsr notes hold a Berlin 1992 reference.
- **Barrier AND aid:** aid -- a word makes a distinction shareable and learnable (ch.2) and stores local
  environmental knowledge; loss of a language is loss of categories (the inverse: no concept, not seen).
  Barrier -- an imposed vocabulary (standardization again) can overwrite a finer local one.
- **Placement candidate:** language as the carrier of scales fits ch.2 (learning the scale).

### Kim, cont. -- immersion schools and rain names

- Kim asked whether the Hawaiian immersion (Kaiapuni) schools are saving the Hawaiian rain terms; if so, it
  strengthens "when a language is lost, the categories are lost too". Kim: it should be possible to check.

### Checked (web, 2026-10-30) -- Claude

- **Hanau ka Ua: Hawaiian Rain Names** (Akana with Gonzalez, Kamehameha Publishing 2015/16): 200+ rain names,
  recovered over ~11 years from ~300 Hawaiian-language primary sources (newspapers, chants, songs, proverbs).
  Names are tied to PLACES; Hilo has the most, Nu'uanu leads on O'ahu. Companion wind book (600+ names) was in
  production in 2016 -- current status not checked. Akana met the names through hula chant, not daily speech.
- **Immersion schools:** a Big Island immersion school teaches second graders cloud names (ao 'opua) and their
  rain-forecasting meaning; Kulaniakea (preschool) teaches cloud names. NO direct evidence found yet that
  Kaiapuni curricula teach the rain-name corpus specifically. Next check: Hale Kuamo'o (UH Hilo curriculum centre)
  or Kamehameha Publishing.
- **Refines the claim (proposal):** the names left LIVING USE but survived DORMANT in the written record, and
  were revived by scholarship and education. Loss of a language removes the people who can APPLY place-bound
  categories; a written archive can keep the categories but not the seeing. Recovery needs both text and a
  person in the place.

### Kim, cont. -- wayfinding and Hokule'a

- Reading the ocean was LOST in Hawai'i until a master navigator was brought from elsewhere in the Pacific where
  long-distance sailing was still practised. Hokule'a's voyage, which depended on that skill, contributed to the
  start of the revitalisation of Hawaiian culture. To Kim this speaks of the VALUE of the categories: in some
  areas they may be the BASIS of the culture. Kim asked whether that overstates it.

### Claude's answer (proposal, NOT ruled)

- Slightly overstated as a general claim; defensible in a narrower form: in PRACTICAL-KNOWLEDGE domains
  (wayfinding, rain, planting) the categories ARE the competence -- lose them and the skill goes, not just words.
  Culture also rests on practice, relationships, values and institutions.
- The case supports "categories need a practitioner": the revival came through a PERSON who could apply them
  (Mau Piailug), not from an archive -- the same point as the rain names.
- The categories were TRANSFERRED (Carolinian, Micronesian) and ADAPTED, not retrieved: the Hawaiian star compass
  (Nainoa Thompson) was rebuilt from Mau's teaching plus study. Categories can travel between cultures -- the
  carried scale at a cultural level.
- The 1976 voyage worked as a TEST (against the accidental-drift view of Pacific settlement): categories proved
  by use. Ties to THE INVERSE / falsification principle.
- The navigator's horizon is a categorised space (star houses, named swells) -- noted, not pursued (Kim is
  taking a break from mapping).
- Candidate placement: ch.8 (the inverse -- loss of categories) or a closing chapter on what categories are worth.

### Kim, cont. -- personal stories; event boundaries; category lifespans

- **PERSONAL STORY:** Kim had dinner with Ben Finney, one of the voyagers on the first trip, soon after his
  return, and got a very detailed account of the voyage. Much later Kim was in Palau when Hokule'a arrived there
  for the first time and saw the community's excitement first hand -- "the emotions were pretty profound."
- **Historical events as category boundaries** -- temporal categories on a bigger scale (pre- and post-Hokule'a).
  System changes, beyond the scope of the specific event, occur at a point that is widely recognised.
- **Categories may have a finite LIFESPAN.** The category may remain in the historical record while its ROLE is
  lost or replaced.

### Claude, cont. (NOT yet ruled)

- **An event boundary is a sharp marker agreed for a gradual change** -- the renaissance was underway before 1976;
  the voyage became the recognised point. Same pattern as twilight's clock-time proxy: a boundary fixed on a
  convenient variable (an event) standing for a fuzzy one (a system state). Usually assigned in RETROSPECT.
  Mirror of S3's "endpoints definable, middle ambiguous". Other cases: 1778 contact, BC/AD, wars, pandemics.
- **The formal version: geology's "golden spike"** -- a committee procedure for choosing a point marker for a
  system change; the Anthropocene proposal was, as far as Claude knows, REJECTED (2024). A boundary refused.
- **Three fates of a category** (life cycle): (a) RETIRED, role gone, name kept in the record (Kona coffee
  vacation); (b) LABEL KEPT, DEFINITION REPLACED (Beaufort numbers redefined from sail carried to wind speed;
  horsepower); (c) DORMANT, then REVIVED (rain names, wayfinding). Taxonomic synonymy is (a) in Kim's own field.
  Possible chapter: "the life of a category" -- gathers today's material.
- **EVIDENCE (Kim's kept document):** printed programme "Hokule'a and Alingano Maisu -- Schedule of Events", Palau,
  planned for arrival SUNDAY 1 APRIL 2007 (five days; Hokule'a with navigator Nainoa Thompson; Alingano Maisu with
  master navigator Sesario Sewralur); welcome with shell horn, chants, Paramount High Chief Ibedul and President
  Remengesau; "Historical Voyage Presentation" by Thompson; possible departure for Yap and Japan "as determined by
  Master Navigator". Kim: arrived ON SCHEDULE. Kim has his own photographs of the arrival (voyaging canoe in the Rock Islands
  with a Palauan war-canoe escort and crowd on the dock) -- candidate figure.
- **The programme is itself an example (Claude):** its note says Day #1 begins on the DAY OF ARRIVAL, and the
  schedule shifts if navigation delays it. The days are categories bounded by an EVENT, not by the calendar --
  and departure is set by the navigator's reading, not the clock. Event-defined vs clock-defined time, on one page.

### Working outline -- MRC (after round three) -- ADOPTED by Kim 2026-10-30 ("this outline works well")

_Part I -- What a category does_
1. **The claim** -- temperature; the unit-switch test.
2. **Learning the scale** -- tacit; Bridgman; LANGUAGE as the carrier (place-named rains, the snow myth,
   categorical perception, Berlin); the AI-elicitation worked example.
3. **Two uses** -- describe vs elicit behaviour.

_Part II -- Where boundaries come from_
4. **Where boundaries come from** -- the backbone table; candidate new sources PURPOSE/ECONOMY and EVENT (not ruled).
5. **Fixed or contextual** -- thin blood; twilight; DST; Kona coffee break; standardization and the surf scale.
   Organising question: fixed in WHICH variable?
6. **Boundaries and error.**
7. **Several measurements, one category.**
8. **Categories instead of measurements.**

_Part III -- Categories over time_
9. **The life of a category** -- retired / redefined / dormant-then-revived; rain names, wayfinding, Hokule'a;
   event boundaries (the Palau programme, the golden spike).
10. **The inverse** -- categories blind as well as reveal.

**Kim's rulings on the open questions:**
- **S3 overlap:** event boundaries STAY IN MRC as part of a category's life cycle.
- **Balance:** ch.6-8 are still valid and important; they need work.
- **Ch.9:** liked, but may be in the wrong LOCATION -- not a concern now.
- **Language early:** ch.2 is OK.
- **NEXT FOCUS: chapter 6 (Boundaries and error).**
- **CHART RULE (trilogy visual vocabulary):** when possible, include an interpretation note working one example
  on the chart; a new type of chart must teach the reader how to read it.
- **SOURCE suggested by Kim (2026-10-30, parting note): Miller (1956) "The Magical Number Seven, Plus or Minus Two",**
  Psychological Review 63:81-97 (psychclassics.yorku.ca/Miller/). Claude's mapping (NOT ruled):
  - Span of absolute judgment: unidimensional judgments carry ~2.6 bits (mean of studies) = about 6.5 categories,
    range ~3-15. A HUMAN-CAPACITY limit on how many categories a learned scale can hold -- a boundary source for the
    backbone (ch.4); why informal scales have few classes (BP 4, gauge 8 bars, Braun-Blanquet ~7). Ch.2 and ch.8.
  - Confusions begin near capacity = errors between ADJACENT categories -- ch.6's error-at-the-boundary in the
    perceiver rather than the instrument.
  - More dimensions raise capacity at a decreasing rate (crude judgments of several things at once) -- ch.7.
  - Relative judgment beats absolute -- the COMPARISON boundary source (runs vs the opponent).
  - Recoding/chunking; Miller calls linguistic recoding the "lifeblood" of thought -- language as AID (ch.2).
  - Miller ends suspecting the many sevens are coincidence -- a caution against reading pattern into categories (ch.10).
  - **Kim (origin story):** Miller's paper was, in a way, the STARTING POINT of his thinking about categories -- it showed
    him the contrast between measurement and categories.
  - **RULING (Kim, 2026-10-30 evening): Miller OPENS the document** -- it is the true origin, and recent documents
    consistently start with a personal event. At the time, the NUMBER of categories was what fascinated him; only
    later did he make the link between measurement and categories.

### Verify before writing

- Acclimatization physiology; "thin blood" as Hawai‘i folk usage.
- Civil-twilight duration by latitude; the ~60.5 N threshold for all-night civil twilight.
- State headlight statutes ("30 minutes after sunset"); hunting-hours rules; 14 CFR 1.1 definition of night.
- Hawai‘i's DST exemption (Uniform Time Act 1966; Hawai‘i's opt-out).
- NWS local criteria for wind-chill and heat advisories; any shift from national thresholds to local ones.
- Kona "coffee vacation": years in force, scope (Kona district vs all Big Island schools), months.
- Origin of the temperate summer break (agrarian story vs heat / standardisation -- contested).
- Hawaiian surf scale definition; when and why NWS Honolulu (and forecast sites) moved to face height.
- Hawaiian wind names (Wind Gourd of La
‘
amaomao, Nakuina); rain-name compilation (Akana & Gonzalez 2015).
- Boas 1911; Pullum 1989 "The Great Eskimo Vocabulary Hoax".
- Winawer et al. 2007 (Russian blues); Berlin & Kay 1969; Berlin 1992 (ethnobiological classification).
- Mau Piailug (Satawal); 1976 Hokule'a voyage to Tahiti; Polynesian Voyaging Society 1973; Nainoa Thompson's
- Ben Finney's role on the 1976 voyage; Palau arrival -- ANSWERED by Kim's kept programme (below).
- Beaufort scale's original sail-based definitions and the change to wind speed; Anthropocene GSSP vote (2024).
  star compass; Andrew Sharp's drift thesis (1956); Hokule'a's role in the Hawaiian Renaissance (timing).

---

## Next

**2026-10-30: focus returned to the trilogy -- MRC round three (above).** Context moves the boundary
("thin blood") paired with fixed boundaries (twilight, DST, Kona coffee break) in ONE chapter. Open: the
chapter's placement; the LLM-elicitation worked example; the new verify list.
**Later the same day: round-three outline ADOPTED (10 chapters, three parts); NEXT = chapter 6, Boundaries and error.**

_Next as of 2026-09-25, kept as history:_

**2026-09-25: focus moved to the Voronoi document (`proj_Voronoi.md`), to be finished BEFORE the
trilogy discusses the technology.** The trilogy stays at capture; MWT's changes are recorded in the
2026-09-25 section above. Carried as before: sites and datasets; worked examples for MRC ch.5-7;
package boundaries and the shared visual vocabulary; the verify lists. Do not start production
writing from this file.

_Next as of 2026-09-23, kept as history:_

All three documents have first-round working outlines (2026-09-23): MRC (8 chapters),
MWT (11 chapters), S3 (7 parts); unifying statement ruled (boundaries in value, space
and time); reading order MRC first. Carried: sites and datasets (plots + expert map;
invasive / disease points; S3 station, vintage and fire data); worked examples for MRC
ch.5-7; package boundaries and the shared visual vocabulary; the verify lists. Then
formal intake if the shape holds. Do not start production writing from this file.

_Next as of earlier 2026-09-23, kept as history:_ All three documents now have a first-round working outline (2026-09-23): S3 (7 parts),
*Maps with Tiles* (map-type grid + draft decision tree), *Measurements Require
Categories* (8 chapters, backbone = where boundaries come from). **Next: look at the
whole set together** (Kim, 2026-09-23). Carried: Tiles title; a site with plots + an
expert vegetation map (Kim searching); worked examples for MRC chapters 5-7; package
boundaries; the verify lists. Do not start production writing from this file.

_Previous Next (2026-09-22), kept as history:_ Round two is UNDERWAY on *Maps with Tiles* (2026-09-22 evening); then
*Measurements Require Categories*. **Tiles resumes with a choice Kim left open:**
more ideation (raw vs dissolved tiles, edge effects, what counts as the study
area) or render the decision tree as a proper diagram. Kim wanted time to think
first. Open: a site with plots + an expert vegetation map (Kim searching). **S3 is ready to outline** and paused by Kim (2026-09-22 evening) so
another document can feed back into it. Then formal intake
if the shape holds. Do not start production writing from this file.
