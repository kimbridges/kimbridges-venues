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

## Measurements Require Categories -- round four, 2026-11-01

_Session opened on MRC; Kim brought new ideas. Speaker marked. MRC is now a formal project (proj_MRC.md); chapter-level_
_working notes live in Projects/MRC/ (e.g. ch06_argument.md). This file keeps trilogy-level capture._

### Kim's ideas

- **CLOTHING SIZES -- "a really easy example" of categories vs measurement.** S-M-L are the basic categories; XS, XL,
  XXL for people outside that range -- fits the magic-number-seven argument. Some people are caught ON THE BOUNDARY
  (usually an S but sometimes an M). Is there any STANDARDIZATION for a particular item, e.g. a t-shirt? Online shops
  commonly give a SIZE GUIDE -- "the translation between measurement and category". HOW MUCH VARIATION IS THERE IN SIZE
  GUIDES? ("You can see where this is headed.")
- Kim does NOT need to be in the figure. But the STORY may relate to TRAVEL TO JAPAN, where the meaning of S is very
  different from the US ("travelers beware!").
- **BESPOKE TAILORING didn't have the category problem -- each person was measured.** Ready-to-wear, Kim guesses,
  changed all that. HOME-SEWN clothing is the same as bespoke. This example might show the DIFFICULTY OF ADOPTING A
  COMMON STANDARD.

### Claude (NOT ruled)

- **Categories are what you need when one thing must fit many.** Bespoke = pure measurement, one garment per body;
  ready-to-wear = categories forced by MASS PRODUCTION. A boundary source: ECONOMY OF SCALE (cf. purpose/economy,
  round three). Possibly a thesis-level line for ch.1 or ch.4.
- **Standards context (web, 2026-11-01):** US -- only VOLUNTARY body-measurement tables (ASTM D6240, men, chest
  34-52); EU -- EN 13402 tried to label by BODY DIMENSIONS with a pictogram (men's chest in 4 cm intervals),
  adoption varied; UK committee warned a mandatory version would hurt its industry. The market kept the letters
  (ch.8 / ch.5). Vanity sizing = the boundary moves, the label stays (ch.6 step 6).
- **Worked example (Kim agreed in principle):** men's/unisex t-shirt size guides, ~20 brands incl. JAPANESE ones;
  chest range per size; record BODY vs GARMENT measurement (two operations, one label -- Bridgman).
- Verify: Japan's JIS men's sizing standard; history of ready-to-wear sizing (military uniforms; US women's
  commercial standard and its withdrawal).

### Kim -- skill acquisition as a set of categories (Bridges & Lau 2006)

- SOURCE (Kim's own paper, attached 2026-11-01): Bridges, K.W. & Y.H. Lau. 2006. The skill acquisition process relative
  to ethnobotanical methods. Ethnobotany Research & Applications 4:115-118 (editorial). Builds on Dreyfus & Dreyfus
  (1986) Mind over Machine: five stages NOVICE, ADVANCED BEGINNER, COMPETENT, PROFICIENT, EXPERT (Fig.1, nested boxes);
  mapped to research activities DATA, ANALYSIS, PROBLEM, HYPOTHESIS, THEORY; a person at a higher level is expected to
  work at the lower levels too. Closing questions include skill MAINTENANCE cost.
- Kim: five categories, each with a CLEAR NAME; the same names are used across a range of applications. A COMBINATION OF
  SKILLS AND BEHAVIORS establishes each category. The names are in a FIXED ORDER. The skills and behaviors measured
  CHANGE FROM CATEGORY TO CATEGORY -- so there is not always a simple linear scale behind the categories. People relate
  the names ALMOST INTUITIVELY to different situations. Once a person has thought through what establishes each
  category, there is a GUIDE ON HOW TO PROGRESS from one to the next (learning how to learn). An important way he
  organizes a lot of things. Self-placement: TRAVEL at Proficient, aspiring to Expert; AI at Competent, aspiring to
  Proficient. "Another way to view what we're examining."

### Claude (NOT ruled)

- An ORDINAL category set with no single measurement underneath -- each rung is tested by different criteria. Stronger
  than Braun-Blanquet (which has a cover axis). Primary home: ch.8 (categories instead of measurements); also ch.7.
- The category tells you how to cross its upper boundary -- a boundary that ELICITS behaviour and teaches (ch.3).
  Echoes the grading 'upward trend' rule (learning how to learn).
- REFLEXIVE: Dreyfus's novice follows explicit rules; the expert acts without consciously applying them -- the same
  path as learning a measurement scale, from explicit boundary rules (size guide, 38.0 C) to the tacit scale (ch.2).
  Learning a scale is itself a progression through these categories.
- Five named levels -- within Miller's range. Maintenance cost (paper's closing question): a category held by a
  person can decay (ch.9, at the scale of one life).
- **RULING (Kim, 2026-11-01):** the skills/behavior categories story is an EXAMPLE TOWARD THE END, not an overarching
  theme ("too abrupt"). Claude's observations on what it tells us are "exactly right". The natural progression of the
  document: show the UBIQUITY of classification and the VARIOUS WAYS IT IS USED.

### Kim -- hat sizes as a counterexample (2026-11-01)

- Kim wonders if HAT SIZES are a counterexample: do you want to be known as having a "big" head, or worse a "small"
  head? Size 8 is pretty NEUTRAL. And most people don't know where that number comes from.

### Claude (NOT ruled)

- US hat size = head circumference (in) / pi -- the DIAMETER of a circle of the same girth (22.25 in -> 7.08 -> 7 1/8;
  checked: divisbyzero.com 2010). Stepped in EIGHTHS of an inch: a measurement, rounded, not ~5-7 broad categories.
- So the counterexample has two parts: (1) a number carries no judgement, a WORD does ("small", "XL") -- the label's
  connotation is part of the category (cf. vanity sizing; prehypertension renamed for being too mild); (2) a
  measurement DISGUISED as a label -- people use 7 1/8 as a category name without knowing it is a measurement.
- Fine steps because a hat must fit closely (little tolerance) -- the required precision is set by the use (ch.6 thesis).
  Stretch caps / 'one size fits most' / S-M-L caps = the category returns where the garment tolerates error.
- Verify: UK hat sizes ~1/8 smaller than US; EU sizes = circumference in cm; origin of the pi convention.

### Gap review (Claude, 2026-11-01) and Kim's choice

- Claude's gap review: ch.10 (the inverse) thinnest -- candidate evidence BUNCHING; public warning scales (hurricane,
  UV, AQI) for ch.3/9; Kim's own fields (Raunkiaer life forms; Ansel Adams Zone System); AGE as fixed boundaries (ch.5);
  machine classification thresholds. Kim: "excellent analysis and a very useful set of examples to work on".
- **Kim: work ch.10 (bunching) FIRST.** Kim's HYPOTHESIS: bunching comes when there is some sort of PENALTY OR REWARD
  for being in a particular category -- marathons: bragging rights / personal gratification; taxes: a true financial
  cost; exam scores: grades and the rewards/penalties of a different grade. Are there data sets to support it?
  -> Bunching worked up 2026-11-01: Projects/MRC/ch10_notes.md, figures/ch10_fig1_bunching (Boston; UK stamp duty).

### Kim -- public warning scales (2026-11-01)

- Public warning scales are probably most important for potentially VIOLENT events -- "that's when we pay attention".
  Places that have such events FREQUENTLY (earthquakes in Japan) are likely to have the most useful scales.
- NAMING IS IMPORTANT. Do people understand the difference between a flood WARNING and a flood WATCH? Which is more
  serious? Names -- and, Kim argues, COLORS -- are important.
- The argument: WE IMPROVE THE CATEGORIES AND THEIR NAMES AS WE BETTER APPRECIATE THE IMPORTANCE. UV index is probably a
  good example: in the 1960s a tan was a positive thing and nobody thought about UV danger; associate UV exposure with
  melanoma and people start to pay attention.

### Checked (web, 2026-11-01) -- Claude

- **JMA seismic intensity (shindo):** 1884 four levels; 1898 seven (0-6); 1949 INTENSITY 7 ADDED after the 1948 Fukui
  earthquake (damage beyond what 6 could describe); 1996 fully INSTRUMENTAL and 5 and 6 each SPLIT into lower/upper after
  Sanriku 1994 and Kobe 1995 exposed wide variation in damage within 5 and 6 -> 10 levels now (0,1,2,3,4,5-,5+,6-,6+,7).
  Strong support for Kim's argument: categories added and split exactly where disasters showed them too coarse --
  and refined where decisions matter most (ch.6 thesis). Also ch.9 (life of a category).
- **UV index:** Environment Canada, launched 27 May 1992 (ozone-depletion concern); WHO/WMO standardized 1994 with
  standard COLORS: 0-2 green low, 3-5 yellow moderate, 6-7 orange high, 8-10 red very high, 11+ violet extreme.
- **Watch / warning / advisory (NWS Hazard Simplification social science):** Warning best understood; Watch and Warning
  sometimes confused; ADVISORY least understood, often confused with Watch. Tested alternatives: "Notice" at watch
  level, "Orange/Red Warning", "Emergency" for the top. No decision reported on that page -- verify current status.
- Further candidates (verify): Saffir-Simpson 2010 redefined to wind only (label kept, definition replaced -- ch.9);
  Category 6 proposal (2024); JMA special warnings (2013); Hawai'i tsunami advisory/watch/warning tiers.

### Kim -- examples from his own fields (2026-11-01)

- **LIFE FORMS.** To a home gardener a simple set (grass, shrub, small tree, big tree) pretty much covers the range. But
  assessing the plants on a complex site, a COMPETENT or PROFICIENT observer is forced to SEE MORE -- that's where
  RAUNKIAER's life forms come in handy. The focus is on a SPECIFIC TRAIT, which differentiates species into about the
  right number of familiar and useful categories. It addresses a need to QUICKLY FOCUS on a specific property; otherwise
  you're left standing and staring, reviewing all the possible sets of categories and wondering what might best apply.
  THE FOCUS REDUCES FRICTION.
- **ZONE SYSTEM.** Kim never used Ansel Adams' Zone System but recognizes its value; it was once widely taught, he
  believes; Adams' photos show its value. Perhaps NEARLY LOST due to automated exposure calculation and the increased
  sensitivity of recording media.
- **PLANT FAMILIES -- "maybe the biggest use of categories in my field."** Sits inside the whole Linnaean hierarchy, but
  for botany grouping by family is a KEY SKILL. Takes categories OUT OF THE MILLER RANGE (7 +/- 2). What it adds: the
  recognition that a category's members SHARE A COMMON SET OF PROPERTIES and that these properties are NOT FOUND IN OTHER
  CATEGORIES.

### Claude (NOT ruled; verify)

- Life forms: the category set GROWS WITH COMPETENCE (gardener ~4 -> Raunkiaer's classes) -- ties to the Dreyfus example.
  Raunkiaer's single trait is essentially a measurement: where the perennating buds sit relative to the ground in the
  unfavourable season. And the biological spectrum (share of each life form in a flora) turns categories BACK INTO a
  quantity that tracks climate. Friction ties MRC to S3/MWT.
- Zone System: a category scale made dormant by a DEVICE (the meter now makes the judgement) -- ch.9. Contrast with
  round two: devices teach the measurement but not the scale; here the device removes the need for the scale. Verify
  ~11 zones (0-X), one stop apart; Adams & Archer c.1940.
- Families: Miller's own escape routes explain how botanists exceed 7 +/- 2 -- MORE DIMENSIONS (many characters at once)
  and RECODING into a HIERARCHY (chunks). Recognition by gestalt = the expert end of Dreyfus. Molecular phylogenetics
  (APG) redrew families -- now defined by DESCENT, not only shared properties (ch.9). Verify APG IV family count.
- **RULING (Kim, 2026-11-01):** plant FAMILIES go with Dreyfus TOWARD THE END (the expert's kind of category; shows
  classification well beyond slicing a measurement -- completes the ubiquity arc).

### Kim -- AGE (2026-11-01)

- Is there a graphic (like the S-M-L one) showing the AGE TRANSITIONS for societal categories? Maybe also how these have
  CHANGED THROUGH TIME (e.g., retirement age).
- **PERSONAL STORY:** Kim's grandmother decided when she turned 50 that she was an OLD WOMAN -- and in her view an old
  woman wears BLACK CLOTHES. Kim's mother worked very hard to make grandma dress in "pretty colors". The battle lasted
  42 YEARS.
- Built 2026-11-01: figures/ch05_fig_age_thresholds (US thresholds, changes over time; Pew 2009: 'old' begins at 60 for
  18-29s, 68 overall, 74 for 65+). Claude: 'old' is a CARRIED scale that moves with the person (cf. thin blood); the
  grandmother's 50 is a self-assigned category with a dress code -- a category that ELICITS behaviour (ch.3).

---

## Measurements Require Categories -- round five, 2026-11-02

### Kim -- athletic events

- The result of a baseball game is a CATEGORY (win/loss) no matter what the scores -- a score COMPARISON, not magnitude.
  The same for a foot race: first, second and third, independent of the time. The PERFORMANCE OF EACH OF THE WINNERS
  SETS THE CATEGORY LIMIT.
- What generally PERSISTS IN THE RECORD is the CATEGORY value ("player X won Wimbledon Y times"), not the game scores.

### Claude (NOT ruled)

- Extends the COMPARISON boundary source (backbone): the boundary is set by the COMPETITORS themselves and moves every
  event -- the same time wins one race and finishes fourth in another. Rank categories always hold the same number of
  members (one winner, three medals), like a top-10.
- The record keeps the category and DISCARDS the measurement -- history stores categories (ch.9 tie). The inverse: a
  photo-finish margin of 0.01 s and a 10 s margin become the same 'win' (ch.10).

### Machine classification -> THE HIDDEN RUBRIC (Kim, 2026-11-02)

- Claude reviewed gap 1 (AI classifiers: score -> threshold -> category; threshold invisible) and recommended a short
  ch.6 section, no figure. Kim: "I really like the idea of a HIDDEN THRESHOLD"; the spam filter is interesting, but
  wants something more everyday / personal-story oriented. Kim's name for it: THE HIDDEN RUBRIC.
- Claude's candidates (NOT ruled): card declined abroad (a fraud score crossed a hidden line -- travel); the car's
  low-fuel light / tyre-pressure light (a maker's hidden threshold beside Kim's own fuel-gauge ladder); the smoke alarm
  (set sensitive on purpose -- a miss costs lives, so cooking trips it); the camera's auto modes (the device's hidden
  thresholds replaced the photographer's zones -- Zone System link); self-checkout "unexpected item in bagging area";
  and Kim's own undisclosed grading rules -- the hidden rubric seen from the side of the person who set it.
- **Kim likes the SMOKE ALARM.** PERSONAL STORY: in a motel on a trip to a scientific conference, early on the day of the
  meeting, Kim took a long shower while gathering his thoughts; the STEAM tripped the smoke alarm; there was NO WAY TO
  SHUT IT OFF; the frustration nearly ruined his day. (Kim unsure it's as relevant as BURNT TOAST, which most people have
  experienced.)
- **PERSONAL STORY -- "a true hidden rubric": Kim's DRIVING ROAD TEST.** Failed on the first try. Why? No explanation --
  just "try again after some more practice". He's sure the examiner's rubric was sophisticated and covered many
  dimensions of driving. KNOWING THERE WAS A RUBRIC DIDN'T HELP. He practised and passed on the next try.
- Claude (NOT ruled): (1) steam is a category error AT THE SENSOR -- the alarm measures particles/obscuration and cannot
  tell steam from smoke; un-silenceable = the false-alarm cost pushed onto the guest (fixed rule, no context: ch.5).
  Toast as the main example, the motel as a short aside. (2) the road test = many dimensions -> ONE category (pass/fail,
  ch.7) with the category reported and the measurements withheld; it is the COUNTERPOINT to Dreyfus -- a known category
  tells you how to progress, a hidden rubric does not; contrast Kim's own gradebook, which recorded which rule applied.
  Verify: modern DMV score sheets (e.g. California: fail on any 'critical driving error' -- a veto -- or on too many
  errors) -- if so, the rubric became visible over time (ch.9).
- Kim: California DMV has changed a LOT. His road test was NEARLY 70 YEARS AGO; in those days a failure on the first try
  was ALMOST GUARANTEED. (So the modern score sheet is a later development -- ch.9, not his experience.)

### Kim -- ch.7 worked examples (2026-11-02)

- Likes the WHITTAKER diagram. Rather than an error ellipse: find a LOCATION THAT SITS NEAR A BORDER, then compare the
  LONG-TERM AVERAGE rain/temp to the PATTERN OF ANNUAL rain/temp -- shows temporal change, much like taking a patient's
  temperature on successive days guides the medical protocols. The diagram is also pretty, and it is nice to LINK TO
  OTHER DOCUMENTS (whittakerr).
- HEAT INDEX works for him. Honolulu isn't the best location; better to compare places SEASONALLY HOT AND DRY (Phoenix)
  vs HOT AND HUMID (Tokyo?). There might also be a CULTURAL difference (not unlike his "thin blood").
- Built: figures/ch07_fig1_whittaker_years (Denver 32 of 78 years, Eugene 31 of 87, outside their mean's biome; strip of
  years in order). Eugene shift to check: woodland/shrubland 10% of years 1970-99 vs 69% since 2000 (precip 131 -> 91 cm)
  -- verify against official normals / gauge history before use.
- **Kim's REFRAME of the Whittaker diagram:** we are not the species impacted -- it is the BIOTA EXISTING WITHIN THE
  CATEGORY. The plants develop under the LONG-TERM conditions; EXCURSIONS from the mean represent STRESS on the system.
  A site in the MIDDLE of a category likely avoids significant stress; BOUNDARY LOCATIONS might be at HIGHER RISK. The
  two-location diagram is very interesting; the Eugene data (if they hold) give a really interesting, NEW WAY to view the
  data -- especially the STRIP DIAGRAM.
- **Kim on the heat index:** go ahead with the two locations. The COMBINATION OF DIFFERENT MEASURES FOR A SIMILAR GOAL
  (safety warning) is part of the story -- and ANOTHER BRIDGMAN EXAMPLE.
- Built: figures/ch07_fig2_heat_index_wbgt (IEM airport obs, PHX and Tokyo Haneda, Jun-Sep 2021-25, each day's peak
  heat-index hour; ~610 days each). US heat index 'Danger' days: Phoenix 309, Tokyo 162. Japan WBGT (BoM approximation)
  'Danger': Phoenix 415, Tokyo 390 -- the US index ranks Phoenix far worse; WBGT nearly equalizes them (humidity weighted
  more). Worked example: Phoenix 108 F/9% and Tokyo 91 F/60% both heat index 102 ('Extreme caution'); WBGT 30.8 vs 34.2.
  Japan MOE WBGT levels (checked): <21 almost safe, 21-25 caution, 25-28 warning, 28-31 severe warning, >=31 danger.
  VERIFY: BoM formula omits sun and wind -- check against MOE published WBGT for Tokyo; heat-stroke alert thresholds.
- **Kim on the figure:** counter-intuitive given the US concept is a "heat index"; under the US definition Tokyo spends a
  lot of time with NO WORRIES ("below 80"), under the Japanese definition the summer is ALWAYS AT LEAST "CAUTION". Would
  HEAT-STROKE CASES PER CAPITA for the two places help -- or is that obscured by Phoenix's extensive AIR CONDITIONING?
- Claude: overall WBGT nearly equalizes the two (Phoenix 415 vs Tokyo 390 'Danger' days); the worked example is where
  Tokyo comes out worse. Tokyo: 143 of 610 peak hours 'below 80' (US) vs 0 'almost safe' (WBGT). Japan's levels are
  framed as EXERCISE guidance -> purpose sets the boundary. Outcome data (web, 2026-11-02): Maricopa County heat deaths
  602 (2024), 645 (2023) [abc15]; 100+ Phoenix-area deaths where AC was not working or not on [azfamily 2024]; Tokyo July
  2024: 123 heatstroke deaths, 121 found indoors, most not using installed AC (Tokyo Medical Examiner via PA). The counts
  are DIFFERENT OPERATIONS (US deaths 'heat-associated'; Japan counts ambulance transports nationally (FDMA) and deaths by
  medical examiner) -- Bridgman again. The index measures the OUTDOOR AIR; harm depends on where the person is (indoors
  without AC; unsheltered outdoors). Verify populations, full-summer Tokyo deaths, Maricopa unsheltered share.
- **RULING (Kim, 2026-11-02):** the value of heat-death numbers is to show this is a SERIOUS problem, not just one of
  COMFORT. An EXAMPLE OR TWO IN THE TEXT is enough -- no table, no per-capita analysis.

### Kim -- ch.8 unequal categories (2026-11-02)

- His SMART CAR FUEL GAUGE (bars) is an example of unequal categories: he can go a very long way before he's down ONE
  bar; once down to THREE bars they go much faster. He can't quantify this from his own data.
- Wants a chart showing unequal categories for something COMMONLY EXPERIENCED. Are there WEATHER WARNING systems with
  unequal categories? Making the measurement scale LOG values is likely where we'll find something.
- Built: figures/ch08_fig1_unequal_categories. (a) US AQI for PM2.5, 2024 breakpoints (EPA fact sheet, checked): equal
  50-point AQI bands over concentration widths 9, 26, 20, 70, 100 ug/m3 -- equal-looking bars over unequal amounts, the
  fuel gauge's design; the 2024 revision moved Good's upper boundary 12.0 -> 9.0 and Unhealthy's 150.4 -> 125.4 (ch.6
  step 6). (b) Saffir-Simpson widths 22/15/19/27 mph + open (Cat 2 narrowest). Log-scale candidates kept: earthquake
  magnitude, decibels, pH. Verify: fuel gauges deliberately non-linear (claim to check).
- **Kim -- the MARTINI GLASS (V-shaped):** is the height of the drink an interesting example? You drink quite a bit
  before you see a drop in the height; toward the end the level goes down quickly. Is there a story behind that?
- Claude (NOT ruled): a cone's volume goes as height cubed -- half the drink is gone when the level has fallen only to
  ~79% of its height; at half height only one-eighth remains. We READ HEIGHT, the quantity is VOLUME (Bridgman). It is
  the MECHANISM behind the fuel gauge: a float measures fuel LEVEL, and the tank's shape turns level into volume
  unequally unless the maker compensates. Evidence to verify: Attwood et al. 2012 (PLoS ONE) -- beer drunk faster from
  CURVED glasses, attributed to misjudging the halfway point; bartenders pour more into short wide glasses (2005 BMJ
  study, Wansink -- check status given later retractions of other Wansink work). Possible small figure: volume left vs
  level for a cone and a cylinder.
- Built: figures/ch08_fig2_martini_glass.
- **Kim (close, 2026-11-02):** really likes the examples; the document is becoming much more EVERYDAY EXPERIENCE AND
  COMMON SENSE than he originally imagined.

---

## MRC -- verify pass, 2026-11-03 (rulings)

- Detail in Projects/MRC/verify_list.md. Kim's rulings this session: show CORVALLIS instead of Eugene in ch07_fig1, KEEP a caution paragraph on
  Eugene's 1995 automation (draft in ch07_notes.md); rebuild the WBGT panel from official data (done); SHOW Kim's ITS/MIS OMR form in ch.6.
- Kim: 'thin blood' is a widespread myth of warm places. Claude: the folk label names a real shift in a personal scale with a false mechanism
  (acclimatization, not blood). **Kim: "I like the 'thin blood' observation. Another good point to be included."** (ch.5)
- Kim supplied: the Eugene station history (ASOS from 1 Sep 1995); Ben Finney's crew place on the 1976 voyage (Hawaii Magazine 2017);
  his exam item statistic ('Item Analysis' with reliability).

---

## Measurements Require Categories -- round six, 2026-11-04: NAMING AND COLOURING CATEGORIES

### Kim's ideas

- Wants to START WRITING, following the multi-chapter document style guide -- but first, HOW WE NAME CATEGORIES (some is in the notes).
- Categories are often in ORDER OF CONCERN. Names tend to be SHORT. COLOURS are often associated with the name.
- Colours are generally FUNCTIONALLY REDUNDANT, but colour may carry a more IMMEDIATE and UNIVERSAL signal.
- Sometimes there isn't room for a name: a colour shown just as a SMALL DOT must be the whole message.
- Is there a place to discuss names, and specifically colours? Curious about HISTORICAL PATTERNS or CULTURAL DIFFERENCES.

### Claude (NOT ruled; facts to VERIFY before use)

- Already in hand: watch/warning/advisory (NWS research: colours read more reliably than words; 'Advisory' to be dropped); UV index and AQI
  official colours (WHO/WMO 1994; EPA); Japan WBGT level names; neutral hat-size numbers vs 'small'; 'prehypertension' renamed for sounding
  too mild; the grandmother's black clothes (a colour that signals a category).
- Historical: traffic-light colours inherited from railway signals; early railway 'go' was WHITE, changed to green because white was confused
  with other lights. The US Homeland Security colour-coded alert scheme, 2002-2011, was retired -- the level never dropped below yellow (ch.9).
  Hong Kong typhoon signals numbered 1, 3, 8, 9, 10 -- gaps from history; 'Signal No. 8' is a household phrase.
- Cultural: in China red signals luck and prosperity -- stock prices rising are shown RED, falling GREEN (the reverse of the West). Japan's 'go'
  light is called AO (blue): the word ao spans blue-green, and signals were made bluish-green to fit the word (ties to Berlin & Kay, ch.2).
  Ski runs: North America green circle / blue square / black diamond; Europe green / blue / red / black -- same idea, different colour codes.
- Redundancy has a reason: ~8% of men have red-green colour-vision deficiency, so position (traffic lights in a fixed order), shape (ski
  symbols) and words back up colour. Standards: ISO 3864 safety colours (red danger/prohibition, yellow caution, green safe, blue mandatory).
  Triage tags (green / yellow / red / black) put the order of concern in colour; US fire-danger signs use BLUE for 'moderate'.
- The dot alone: phone AQI dot, map traffic colours, battery icons, device status lights -- the category reduced to its colour.
- Placement candidates: a section of ch.3 (categories that elicit behaviour speak through names and colours), or a short new chapter after ch.3.
- **RULING (Kim, 2026-11-04):** fit NAMES AND COLOURS into CHAPTER 3; split into its own chapter only if it grows too long. Run a
  VERIFICATION pass first. Wants SIDE-BY-SIDE DIAGRAMS to support the graphics-forward style.

---

## S3 -- round three, 2026-11-07 (filed 2026-11-18)

_Captured in a claude.ai chat on 2026-11-07 with Drive read-only; the block was not
applied that day and was filed through the R bridge on 2026-11-18._

### Kim's ideas

- **The degree-day plot** is a tool for S3's middle range, between the weather and
  climate bookends.
- **The Arizona story:** insects in Arizona crop fields complete their life cycles in
  a set number of degree-days. Viewed on that axis, insect collections that looked
  chaotic (species abundances through the crop season) became understandable. Kim
  recalls this as Floyd Werner's work (University of Arizona) -- to be verified.
- **Phenology as an ecological lens.** Helmut Lieth told Kim, in essence, that old
  ecologists become phenologists. To Kim as a young ecologist, that meant it takes
  years of study to see why phenology matters.
- Phenology is hard to study: long timespans and much field time -- unless a
  citizen-science project recruits many volunteers.
- **Visualization matters in phenology:** maps of fall color moving across the US or
  Japan.
- Kim has a graphic or two of Washington, DC cherry blossoms, plus personal stories
  to tell about them.

### Kim's ruling

- S3 uses the standard term **degree-day** (not "day-degree").

### Claude (NOT ruled)

- The Arizona story is S3's thesis in one example: change the time axis from
  calendar days to accumulated heat, and pattern appears.
- Friction: degree-day sums were tedious by hand; now a line of R.
- MRC tie-in: the base temperature is a category boundary (boundaries in value)
  that sets the clock.
- Candidate fourth worked group (crop pests / phenology), beside fire, vintage and
  tree rings.
- Long records for the backward view: Kyoto cherry-blossom dates and the DC
  peak-bloom record; Japan's sakura-zensen and koyo-zensen maps as the classic
  phenology-front graphics.

### Verify before writing

- Werner: Floyd G. Werner (1921-1992), PhD Harvard 1950, University of Arizona from
  1954; his departmental work included parasites of cotton insects (Olson, Psyche
  101, 1994; Fauna of New Zealand 34 contributor notes). **The degree-day link is
  NOT confirmed.**
- Length of the Kyoto record and the start year of the DC peak-bloom record.

## S3 -- round three, cont. 2026-11-18: THE NEGLECTED MIDDLE, BEYOND WEATHER

### Kim's ideas

- **The scale, restated.** Climate is one end: a long-term average (many years) of
  temperature and precipitation. The nightly news weather segment is the other end:
  short-interval data, mostly predictions -- hourly temperature and rain
  probabilities through the next few days. The scales in between are ones people
  generally don't encounter. **That is the realm of the ecologist.**
- **The middle-scale question:** what is this year's precipitation pattern, compared
  with the last few years -- with the wettest and driest years added to set the
  historical boundaries. That analysis and display gives the context, and the
  variability, that reports from the two ends leave out.
- **Mekong River Commission** (a worked example in a neighboring subject): river
  cross-sections marked with the current water level and the extreme levels; and
  the seasonal progression of water levels with reference lines that put the
  current trend in context.
- **A dashboard as a nightly-weather supplement:** the components of weather plus
  analytical derivatives (e.g., drought).
- **The frog in the pot:** the frog checks the water every few seconds; the change
  between readings is too small to notice, so the pattern is never seen. Measure
  every minute and the change is obvious. Daily weather is the same -- day-to-day
  is too short an interval to see a change in pattern (except in extremes); the
  weekly-or-longer pattern, set against previous years, shows it.
- **The goal:** take this into new, very different areas -- places where the middle
  of the time scale has been neglected and where its patterns would give better
  context for understanding. Weather/climate was the starting point; the Mekong is
  a step sideways.

### Claude (NOT ruled)

- **Accumulation is the middle-scale instrument.** Degree-days (11-07), rainfall to
  date, river and reservoir storage are all running sums. Day-to-day differences
  sit below notice; sums integrate them into something visible. The frog reads
  differences; the ecologist reads accumulations.
- **The frog as a threshold problem.** Change per interval falls below a
  just-noticeable difference. A longer interval lifts it over the threshold -- a
  perceptual category boundary, which ties to MRC (boundaries in value). Note: the
  biology is a myth (real frogs leave); use it as a parable and say so.
- **The canonical display:** this year's trace against an envelope (median, the
  record wet and dry years, or percentile bands). The Mekong charts are one form;
  so are flu-season curves plotted against past seasons.
- **Shifting baselines (Pauly)** may be the frog at generational scale: each
  generation takes the state it first saw as normal. A backward-looking chapter
  candidate.
- **Candidate domains for the neglected middle:** public health (flu seasons);
  reef heat stress (NOAA Coral Reef Watch's degree heating weeks -- accumulation
  again); reservoirs and lake levels; fire danger against percentiles;
  household energy or fuel use against previous years; personal health
  measures against one's own baseline; markets (daily ticks vs. the year).
- **Name clash:** the Mekong River Commission's acronym is MRC, the same as
  *Measurements Require Categories*. Spell it out in S3.
- **Scope question for Kim:** S3's subtitle is about the scale between weather and
  climate. Today's goal generalizes past weather. Keep weather/climate as the
  anchor case with other domains as chapters, or retitle around the general
  middle scale?

### Verify before writing

- What the Mekong River Commission's monitoring pages show today (cross-section and
  seasonal hydrograph with reference lines).
- Boiling-frog history (19th-century experiments vs. the modern debunking).
- Shifting baseline syndrome: Pauly 1995 attribution.
- Degree heating weeks: NOAA Coral Reef Watch definition.

### Kim's ruling (2026-11-18, later)

- **Scope: too early to decide.** More thinking first, and a look at potential
  topics besides weather and climate. The subtitle question stays open.

### Kim -- the event year (2026-11-18, later)

- **The start of an event year doesn't always match the solar year.** Probably a
  chapter in itself.

### Claude (NOT ruled)

- Examples: the water year (US, starting in October); the crop year and the wine
  vintage (a Southern Hemisphere vintage straddles two calendar years); the flu
  season; the hurricane season; fire seasons; fiscal and academic years.
- **The principle: put the year's boundary in the trough,** where little happens,
  so a single event isn't cut in two. A wet season split by January 1 becomes two
  half-seasons in two different years -- the boundary manufactures noise.
- That makes the event year a boundary-in-time decision -- the trilogy's
  "boundaries in value, space and time" -- and the time-axis counterpart of
  MRC's chosen category cut points.
- Hawai'i test case (light touch, per the ruling): the two Hawaiian seasons and the
  Makahiki as a year framed by events rather than by the solar calendar.

### Verify before writing

- Water-year definition (USGS, Oct 1-Sep 30); flu-season week convention (CDC);
  Atlantic and Central Pacific hurricane-season dates; Hawaiian season names and
  Makahiki timing.

### Kim -- phenology, travel and spectacle (2026-11-18, evening)

- **DC cherry blossoms (story):** Kim and Nancy worked hard to see them. Flights
  and hotels have to be booked early, and predicting peak bloom was tricky. They
  succeeded on the **third try**.
- **Kyoto fall color (story):** easier -- they hit the peak on the **first try**.
- These are among the few phenological events widely shown in the news cycle.
- **The sentinel.** In DC a single "sentinel" tree is observed and the bloom stages
  are extrapolated from it. The sentinel organism is interesting and may be
  critical to some phenological studies.
- **Amplified phenology.** Organizations, and businesses, amplify phenology by
  massing a single species so its flowering covers a large area or draws crowds --
  a cultural phenomenon. The Ranunculus at The Flower Fields (near San Diego) and
  Keukenhof (The Netherlands): bucket-list experiences Kim and Nancy have enjoyed
  more than once.
- **First flower memory (story):** family picnic drives in the mountains above San
  Bernardino, California. Rounding a corner on a remote mountain road, a hillside
  covered with lupine. Dad stopped the car; everyone got out; everyone was very
  excited.

### Claude (NOT ruled)

- **The title is in the trips.** A cherry peak lasts days -- a *snap*. Kyoto's fall
  color holds for weeks -- a *stretch*. A narrow window against the same forecast
  error explains three tries versus one.
- **Travelers live the missing middle.** Bookings are made months ahead on
  climate-like knowledge; the date is set by weeks of weather (degree-days again).
- **Sentinel as a sampling choice:** one individual stands for the population, a
  kind of type specimen for time. Cloned lilac networks are the engineered
  version -- removing genetic variation so the sentinel reads only the weather.
- **Amplified phenology runs two ways:** massing spectacle in space (fields, gardens)
  and engineering the season in time (staggered planting, varieties chosen to
  stretch the bloom). Public phenology: hanami, koyo, leaf-peeping, superblooms,
  bloom forecasts as news.
- **Structural pair:** the lupine hillside is chance -- the bloom you stumble on --
  against the planned trip, the bloom you forecast. Possible chapter opening.

### Verify before writing

- NPS name and siting of the DC indicator ("sentinel") tree; its bloom-stage
  definitions and the peak-bloom criterion.
- Cloned lilac phenology networks (origin, US network history).
- The Flower Fields (Carlsbad) and Keukenhof: season length and how it is managed.

### Kim's ruling (2026-11-18, evening)

- **The lupine hillside opens the phenology chapter.** Kim was about 5 years old;
  he can still picture the field, especially the color of the flowers.

### Kim -- fireweed, the living calendar (2026-11-18, evening)

- **Story:** Kim and Nancy spotted their first fireweed just after leaving the
  airport in Valdez. Their hosts, Peter and Carla, told them the folk reading: it
  blooms from the bottom of the spike upward, and when the top flowers open, summer
  is nearly over. They were on their way to Peter and Carla's boat in the Valdez
  harbor -- named *Fireweed*.
- Kim has driven around Alaska quite a bit. Fireweed is a beautiful roadside plant
  and, indeed, **a living calendar for the season.**
- **Unlike the turning of fall leaves, fireweed shows seasonal time over a long
  period.**
- Photographs exist: the TwoRed 2013 Alaska deck includes fireweed (see
  `proj_Smart_Car` / `deferred.md`).

### Claude (NOT ruled)

- **A third kind of phenological signal.** The cherry peak is an event (a snap);
  fall color is a window (a stretch); fireweed is a **gauge** -- a continuous
  readout of how far the season has run. The spike is a progress bar.
- **Fireweed is a running sum drawn by a plant** -- the same idea as the degree-day
  accumulation, displayed on a stem. A candidate bridge between the phenology
  chapter and the accumulation spine.
- The chapter could run lupine (chance) -> cherry blossoms (forecast event) -> Kyoto
  (window) -> fireweed (gauge).

### Verify before writing

- Fireweed's bottom-up (acropetal) flowering and the Alaskan folk saying's usual
  wording.

### Kim -- annual rings, otoliths, and organisms as recorders (2026-11-18, evening)

- Does the annual ring fit somewhere? If it does, otoliths belong too.
- **Story -- first "biology job":** a seasonal aide for California Fish and Game (as
  it was then called), collecting and preparing otoliths and fish scales. It lasted
  nine months: a short break from school to find out whether he liked biology
  enough to make it a profession.
- **Possible theme:** organisms work in cycles, and sometimes they record the
  details of the cycles (e.g., the widths of tree rings).

### Claude (NOT ruled)

- Tree rings are already one of S3's three worked groups (ruling, 2026-09-22); the
  otolith joins them rather than opening a new slot.
- **Gauge vs. archive.** Fireweed shows this season live, then forgets it. Rings,
  otoliths and scales keep every season. Phenology reads the present; the
  recorders give the backward perspective S3 wanted.
- **One structure, two scales:** otoliths carry daily increments (in young fish) as
  well as annual rings -- the snap and the year in one bone.
- Other biological recorders: coral growth bands, mollusk shells (sclerochronology),
  tooth cementum. The recorded width is itself an accumulation -- a season's growth
  summed and laid down.

### Verify before writing

- Daily otolith increments (Pannella, Science 1971); otolith and scale annuli in age
  determination; the agency's name at the time of Kim's job.

### Kim -- USDA hardiness zones (2026-11-18, evening)

- **Ruling: hardiness zones must be in S3.**
- A measure people know about but may not fully understand. To many it is just a
  number on a nursery plant label, matched to a value someone said would be safe
  to buy.
- Prior work: whittakerr (2026-05-14 side thought on hardiness zones and the agency
  model; queued Hardiness-vs-Whittaker example on the gardens CSV) and
  Temperature_Patterns notes (zones from WorldClim BIO6; California zone shifts).

### Kim -- desert superblooms (2026-11-18, evening)

- Somewhat parallel to eastern US fall color: the spectacular flower blooms of the
  Southwest deserts.
- **Not easily predicted in either time or space.**
- When they are reported, huge crowds head out to see them -- traffic and parking
  problems.

### Claude (NOT ruled)

- **Hardiness: an average of snaps.** A zone is built from each year's single
  coldest night, averaged over climate-length periods. The plant lives or dies by
  one night, not by the average.
- The label number is an MRC-style category from one measurement; the zone map's
  boundaries move between USDA editions (boundaries in time). The scale is silent
  on heat, rain and how long the cold lasts.
- **Superbloom: a snap triggered by a stretch.** The bloom lasts weeks; whether it
  happens depends on the season's accumulated rain, and the seed bank waits through
  dry years for it -- three scales in one event.
- **Natural vs. planted spectacle:** The Flower Fields and Keukenhof are engineered
  to be predictable; the desert is not. Unpredictability plus instant reporting is
  what produces the crowd surge. Pairs with the lupine (the bloom found by chance).

### Verify before writing

- USDA zone definition: averaging period of the current map, 10-degree F zones with
  5-degree a/b halves, edition years.
- Superbloom germination triggers (fall/winter rain thresholds); a documented crowd
  episode (e.g., Walker Canyon, Lake Elsinore, 2019).

### Kim -- migratory land birds and voyaging (2026-11-18, evening)

- **A phenological event with a profound cultural response.** Living on a Pacific
  island long ago, you notice that all the individuals of one kind of bird -- land
  birds, not seabirds -- suddenly leave, and months later all come back.
- That strongly hints there is someplace similar, far enough away that you can't
  see it. It might inspire a voyage to look for it -- and **the birds also give the
  direction.**
- **It took both** the birds and a population living in a non-contiguous land area.

### Claude (NOT ruled)

- **There is a published precursor.** Harold Gatty (*The Raft Book*, 1943; *Nature Is
  Your Guide*, 1958) proposed that Polynesian voyaging followed seasonal bird
  migrations: the long-tailed cuckoo (a land bird) to New Zealand, the Pacific
  golden plover (kolea) north from Tahiti to Hawai'i. David Lewis (*We, the
  Navigators*, 1972) discussed it. Te Ara (Irwin) notes Maori tradition of
  following migrating birds; others call the cuckoo link controversial. Kim's
  version adds the reasoning from the islander's side: synchrony + absence +
  return = a place; the flight line = a bearing.
- **A middle-scale inference.** One departure proves nothing; years of watching the
  same birds leave and return make it a pattern worth a voyage.
- **Why land birds matter:** islands hold few land-bird species, so a whole species
  vanishing at once is conspicuous -- and land birds can't rest on the sea.
- **Hawai'i as test case (light touch):** kolea leave Hawai'i each spring flying
  north toward Alaska, yet no voyage followed them there -- the hint is necessary,
  not sufficient.

### Verify before writing

- Gatty's exact claims and dates; Lewis 1972 treatment; the current scholarly view
  (contested). Kolea arrival and departure months in Hawai'i.

### Kim -- a ladder of wet-weather timescales (2026-11-18, evening)

_Source: a table Kim got from Gemini (AI output, unverified), reformatted._

| Typical duration | Meteorological / broadcast term | Underlying scale and driver |
|---|---|---|
| 10-45 minutes | Passing shower | Microscale/mesoscale: a single convective cumulus cell moving with the wind |
| 1-12 hours | Period of rain / frontal passage | Mesoscale/synoptic: a single frontal rainband or stratiform shield |
| 2-7 days | Rain spell / rainy stretch | Synoptic: a slow-moving trough, stalled front, or short run of disturbances |
| 1-2 weeks | Unsettled pattern / storm train / blocking pattern | Planetary (Rossby wave): jet-stream lock, cut-off low, Rex/Omega block, atmospheric-river parade |
| 2-6 weeks | Subseasonal wet regime / AR family | Subseasonal: MJO wet phase or a persistent wave-train anomaly |
| 2-6 months | Rainy season / monsoon / ENSO regime | Seasonal: annual migration of the jet stream, or El Nino/La Nina coupling |

### Claude (NOT ruled)

- **The table uses S3's own words:** "spell" and "stretch" sit at 2-7 days. The
  vocabulary for the middle exists; it just isn't in the nightly broadcast.
- **The bottom three rows are S3's missing middle** (a week to a season).
  Meteorology has its own name for this band -- "subseasonal to seasonal" (S2S) --
  and treats it as the hardest range to forecast: too long for the weather's
  initial state to matter, too short for the slow ocean signals to dominate. The
  forecasters' gap and the public's gap are the same gap.
- **A ladder is an MRC object:** duration categories with boundaries (45 minutes,
  12 hours, a week). Parallel ladders could be built for dry spells and for
  temperature (the cold *snap*). Possibly one graphic per variable, tying S3's
  title to real scales.

### Verify before writing

- Check every row against a standard source (AMS Glossary of Meteorology, WMO).
  AI-generated durations and term assignments need confirmation.
- The WMO S2S Prediction Project and the "predictability gap/desert" framing.

### Kim -- a year diagram of durations (2026-11-18, evening)

- **Idea:** a diagram plotting the duration of each type of wet pattern (the ladder
  above), lined up across a year.
- Critical assumptions would be required, but formal definitions probably exist
  to help.
- **Such a diagram shows the periods of precipitation, whereas we usually show the
  amounts.** Somewhat different goals.

### Claude (NOT ruled)

- **One parameter builds every row.** Hydrology defines a storm event by a minimum
  inter-event time (IETD): dry gaps shorter than it are merged into one event.
  Apply the same hourly record with a growing gap tolerance (an hour, a day, a
  week, a month) and each row of the ladder falls out. The diagram is a
  hierarchical clustering of wet hours in time -- a dendrogram laid on a calendar.
- The gap tolerance is the critical assumption -- and an MRC-style boundary choice.
- Formal anchors to check: the IETD literature; ETCCDI indices for consecutive wet
  and dry days (CWD, CDD).
- Periods and amounts can share the figure: duration rows above, daily amounts
  below, bars shaded by event total.
- Kin to a wavelet scalogram (variance by period through time), but categorical
  and readable without the mathematics.
- Sketch with synthetic data made 2026-11-18 (illustration only); a real-data
  version needs an hourly gauge record.

### Kim's ruling (2026-11-18, evening)

- **Keep the duration diagram** and feed it data from different places. It gives a
  visualization for what is otherwise a formal table; it fits the spirit of the
  trilogy.
- Tool saved: `Projects/S3/figures/rain_periods/rain_periods.R` (base R;
  `rp_events()`, `rain_periods_plot()`, `rp_ladder`, `rp_synthetic_year()`), with the
  synthetic demo `rain_periods_synthetic.png`. Input: hourly time + amount.

## S3 -- round four, 2026-11-21: TIME TEMPLATES AND THE VISUALIZATION OF VARIABILITY

### Kim's ideas

- **Time templates.** Civilization, with celestial mechanics, has imprinted time
  units on us: 24 hours in a day, 7 days in a week. These units shape how we think
  about and represent time-based activities and phenomena.
- **The alternative:** things begin when they begin and end when they end, without
  being fitted into our time templates.
- **Rain seasons:** we report annual rainfall -- fitting parts of a cycle into a
  system whose boundaries were set for a different purpose. Our time units are
  applied, perhaps, to too many things. Handy for searching for correlations, but
  it distorts the underlying reality.
- **Soil moisture** is a seasonal pattern with its own beginning and end; it does
  not recognize that the calendar moved from December to January.
- As we visualize data, **we need to consider the boundary issue.** (Kim: "I know
  I'm not stating this quite right.")
- **Variability is generally neglected in visualization.** Its importance showed
  when we plotted annual values on Whittaker diagrams (whittakerr). A theme that
  needs more work.
- **An enriched climate diagram:** the classical climate diagram with the lines for
  mean monthly temperature and precipitation, plus an indication of variability --
  maybe, like the Mekong River Commission charts, lines for extreme years, the
  long-term average, and the current year. **It's the context that's too often
  missing.**

### Claude (NOT ruled)

- **Two kinds of time.** Calendar time is a template laid on everything (hours,
  weeks, months, years). Event time is set by the phenomenon itself (a rain spell,
  a wet season, a soil-moisture recharge). This generalizes the 11-18 event-year
  idea from "where does the year start" to "should the template be used at all."
- **The template's virtue is also its cost:** shared bins make different series
  comparable (correlation), but each bin cuts through events. Monthly means smear
  a wet season's onset across two months; a calendar total splits one season in
  two. Possible phrase: "templates are for comparison, events are for
  understanding."
- **rain_periods already works in event time:** its bars start and stop with the
  rain, not the calendar. The tool is a demonstration of Kim's alternative.
- **The classical climate diagram is the Walter-Lieth diagram** (Walter & Lieth,
  *Klimadiagramm-Weltatlas*, 1960s) -- Helmut Lieth's own, which ties to Kim's
  "old ecologists become phenologists" story. Enriching it with variability
  would be a direct homage.
- **What the enriched diagram could show:** mean temperature and precipitation
  lines (as now); a band per month for the interannual spread (e.g., 10th-90th
  percentiles); the wettest and driest years as thin lines; the current year as a
  bold trace. Same envelope grammar as the Mekong charts and the 11-18 "this year
  against an envelope" display.
- **Combine the two ideas:** an event-time climate diagram whose year starts in the
  trough (e.g., the water year) rather than in January.
- Prior work to reuse: whittakerr (annual values plotted on Whittaker biomes
  showed the spread); the seasonality / seasonalityr work.

### Verify before writing

- Walter-Lieth diagram conventions (scales: 10 C = 20 mm; humid/arid shading; the
  >100 mm compression) and the atlas citation and dates.
- Existing R implementations (e.g., climatol::diagwl) to build on.

### Kim -- the weathercast in event time (2026-11-21)

- Kim confirmed the round-four reading above. Ruling: **record only for now; no
  prototype** of the enriched climate diagram yet.
- **The nightly report Kim imagines** (his wording):

  > "That cold front that moves in on Thursday should be the start of our rainy
  > season. We usually get four or five big pulses like we're expecting to start
  > on Thursday. We'll keep track of them as the season progresses."

  instead of

  > "Rain is forecast for Thursday and it may last a few days."

### Claude (NOT ruled)

- What changes: the forecast is placed **inside a season** (event time, not the
  calendar); it carries a **norm** ("usually four or five"); and it starts a
  **running count** ("we'll keep track") -- accumulation again. Same rain, now with
  context.
- The "big pulses" are the rain_periods rows at multi-day tolerance; the
  season-to-date count is what the nightly-weather supplement dashboard would
  show.
- Strong candidate for S3's opening or closing passage -- the whole argument in
  two sentences.

## ★ THEN AND NOW: DATA ACCESS -- Kim, 2026-11-21 ("pretty big for me"; arose from our work together)

### Kim's story and argument

- **Early 1970s, International Biological Program (IBP), Island Ecosystems
  Integrated Research Program (IRP).** Kim's job: oversee weather data collection
  and processing.
- A transect of weather stations, each with a rainfall collector and a paper-chart
  temperature recorder. **Each week** a field assistant drove the transect,
  measured the water depth in each rain gauge and replaced the recorder paper.
- Back at the university, an assistant read the **hourly temperatures** off the
  charts and keypunched them so the weather log could be printed. Simple analyses;
  data printed as reports.
- Using the data for any other purpose was hard, especially without the deck of
  cards. **Data were expensive (sometimes difficult) to collect, cumbersome to
  organize, and generally hard to use.**
- **What has changed is digital access, particularly API access. This is
  revolutionary.**
- The problem: most people in Kim's research arena still think of their
  relationship to data as it was in the past.
- In other documents we drew critical insight because we had access. The types of
  data have been astounding (who knew there was canopy height data?), and the
  spatial resolution equally amazing. With easy access we can look at things very
  differently -- yet we keep our previous analysis and visualization tools.
- **There were no shortcuts to getting data in the past. Now we have different
  access. We need to use it.**

### Claude (NOT ruled)

- **This is FRICTION (ruled a major S3/trilogy component, 2026-09-22) at first
  hand:** Kim ran the high-friction pipeline himself -- gauge, chart, keypunch,
  printout.
- **The collection method imposed a time template.** The weekly gauge read summed
  each week's rain into one number: the rain periods were never recorded. The
  rain_periods diagram (11-18) was literally impossible with IRP rainfall data;
  hourly temperature survived only because a person read every hour off the
  chart. Ties to round four: the template came from the field schedule, not the
  phenomenon.
- **Scarcity habits vs. abundance.** Old methods were designed to economize scarce
  data (summaries, monthly means, one station per zone). With abundance the
  bottleneck moves from getting data to having the concept to look for -- the
  trilogy's founding point ("you don't see something unless you have a concept
  of it").
- **Evidence already in hand:** Voronoi/tessellr (Meta/WRI canopy height),
  checklists (GBIF), PubMaps (Nominatim), Smart Car (logs); a then/now table could
  list each with its pre-API cost.
- **Possible worked example:** an IRP transect station then (weekly totals, hourly
  chart temperatures) against modern data for the same place now.
- **Placement is open:** an S3 chapter on friction, a preface for the whole
  trilogy, or a document of its own.

### Verify before writing

- IRP name, dates and leadership (Mueller-Dombois; the 1981 *Island Ecosystems*
  volume); the transect's location and station count; whether IRP weather reports
  or card decks survive.

### Kim's ruling -- placement (2026-11-21)

- **Then-and-now data access goes in S3 as a FRICTION CHAPTER.**
- **Friction is reintroduced periodically** -- Kim likes it as a recurring motif. It
  is a kind way of saying that what we did in the past was OK; we can just make
  things "smoother" now if we are willing to change.
- Cross-reference: `deferred.md` > Smart_Car > "CARRY THE FRICTION LESSON OUT OF
  SMART_CAR" (2026-09-01).
- **Kim (2026-11-21): the Bob Jones work is a PRIME EXAMPLE of friction** -- hard-won
  older data, recovered and made usable (Jones Collection; Alaska revival with Peter
  McRoy pending, see `deferred.md`).

## ★ S3 GUIDING PRINCIPLE -- KEEP THE FOCUS ON THE MIDDLE (Kim, 2026-11-21)

- **Kim's statement:** as these ideas develop, we must not lose the focus on the
  **middle range** of the time scale. We often focus on the macro (long-term) and
  micro (short-term) ends and forget that **the meso (middle-term) scale is how we
  understand, through context, what is happening at the ends.** "At least that's
  been my focus."
- Claude (NOT ruled): a working test for every candidate example -- *what does it
  show at the meso scale that the two ends cannot?* Examples that live only at an
  end get cut or reframed.

### Kim -- the slow wearing away of an economic base (2026-11-21)

- Prompted by a story Kim saw: killing off the sea otters made Alaska much less
  valuable to Russia before the 1867 sale.
- Ruling: **the slow wearing away of an economic base is a good example**,
  especially if it can be tied to other work in progress. **A strong theme in
  conservation in general.**
- Claude (NOT ruled): the meso view is the decade-by-decade decline of the otter
  harvest -- the context that explains both the snap (the 1867 sale) and the
  macro story (empire). The frog in the pot at the scale of a state; kin to
  shifting baselines. Possible tie-ins: the Jones / Alaska work; fisheries (Kim's
  otolith job).
- Verify: Russian-American Company otter-harvest records over time; the weight
  historians give otter depletion among the reasons for the sale; the $7.2 million
  price.

## S3 -- overview and gap review, 2026-11-21 (Claude, at Kim's request; NOT ruled)

**In hand.** Sept (rounds one-two): title, thesis (no concept, no seeing), the scale,
snap/spell/stretch, three criteria, five implementations, three worked groups (fire,
vintage, tree rings), Hawai'i test, friction, Bridgman boundary, visual-language
requirement. Nov (rounds three-four): accumulation (degree-days); phenology
(lupine / cherry / Kyoto / fireweed = chance / event / window / gauge); recorders
(rings, otoliths); hardiness zones; superblooms; event year; calendar vs event time;
the envelope display and an enriched Walter-Lieth diagram; the weathercast passage;
the then-and-now friction chapter; the guiding principle; one working tool
(rain_periods).

**Gaps, in priority order:**

1. **No outline holds the November material.** The 2026-09-22 seven-part outline is
   built on spell definitions and algorithms; phenology, recorders, event time, the
   envelope display and the friction chapter have no slots. A round-three outline
   is the next structural step.
2. **Scope is untested.** The goal is "very different areas," but every worked
   example is still weather, climate or biology. Candidate domains (flu seasons,
   reefs, markets, personal health) are Claude's lists; none chosen. A cheap test:
   one domain with data already in hand (e.g., the Smart Car fuel logs, which carry
   ambient temperature).
3. **The guiding principle needs applying.** Several new examples sit at an end:
   hardiness zone (an average of snaps), superbloom (a snap), the 1867 sale. Each
   must show what the meso view adds. And no worked analysis yet shows HOW the
   middle explains an end event -- the weathercast passage states it; an analysis
   should demonstrate it.
4. **Vocabulary vs ladder conflict.** Sept defined a spell by threshold + minimum
   duration; the Gemini ladder defines it by duration alone (2-7 days); rain_periods
   uses gap tolerance only (one of the five implementations). These need
   reconciling.
5. **No real data yet.** Fire, vintage and tree-ring data sources unchosen since
   September; rain_periods never fed a real record; the five implementations never
   run. Verify lists long.
6. **Lopsided coverage.** Rain dominates; temperature (snap, heat wave), the dry side
   (drought, dry spell) and the FORWARD direction (decisions: water, fire,
   forecasting at S2S range) are thin. November material is mostly backward-looking.
7. **Display forms uncatalogued.** Envelope, duration ladder, accumulation curve,
   gauge, enriched climate diagram: a small set, perhaps chosen by a decision tree
   like MWT's map-choice tree.

Not a gap: personal stories (now plentiful; the two live wine stories on
kimbridges-stories may serve the vintage group).

## S3 -- back to the three terms: balancing snap, spell and stretch (2026-11-21)

### Kim

- Before the November material: return to what started S3 -- snap, spell and
  stretch. **Our view of the three must be balanced in the discussion.**
- How do we define a snap, and what are its implications? **Kim sees a snap as a
  potential trigger event -- something that changes behavior.**
- Question: are these key concepts that help define the importance of the middle
  range?

### Claude (NOT ruled)

- **Three roles:** stretch = the STATE (sets the background, readies the system);
  spell = the LOAD (a sustained departure whose effect accumulates -- a dose);
  snap = the TRIGGER (an abrupt change that crosses a threshold and changes state
  or behavior). Stretch sets the stage, spell loads it, snap releases it.
- **Snap defined:** by RATE of change, not by level or length; short; measured
  against the last few days (the 2026-09-22 table). Implication: a response --
  leaves drop, birds move, people turn on heaters, a fire starts.
- **The key move: whether a snap triggers anything is decided by the middle
  range.** The same frost is harmless in dormancy and ruinous after budbreak (set
  by spring degree-days). The same lightning does nothing after a wet stretch and
  starts a fire after a drying spell. The first big storm germinates a superbloom
  only after the right season. **The snap lives at the weather end; its
  consequence is set at the meso scale.** This is the mechanism the guiding
  principle asked for (gap 3 of the overview).
- **Fire is already the template:** wet stretch grows fuel, dry spell cures it, a
  wind or lightning snap ignites it (the SEQUENCE ruling, 2026-09-22).
- **Perception is tuned to snaps.** Organisms and people are snap detectors; slow
  change without a snap goes unnoticed. The frog in the pot is the case of no
  snap. That is one reason the middle range is neglected.
- **Helps reconcile the spell conflict (gap 4):** the three terms name KINDS of
  departure (rate, threshold-plus-duration, persistence); the Gemini ladder names
  DURATIONS. Two axes, not rival definitions -- a snap is defined by rate, so it
  is orthogonal to the ladder.
- **Balance gap:** snap is the least developed of the three; its vocabulary is
  mostly cold ("cold snap"; no "heat snap"); rain and wind have their own words
  (cloudburst, squall, gust).

### Kim -- snaps beyond biology (2026-11-21)

- **An economic snap:** Jensen Huang's resignation as Nvidia CEO (news, 2026-11-12)
  and the drop in the company's market value. **Snaps are not just biology.**
- **Discoveries are kinds of snaps.**

### Claude (NOT ruled)

- **The Nvidia day shows all three terms at once** (web, 2026-11-21): shares fell
  about 10% premarket and as much as 14% early, then recovered to about 4% down by
  midday (the snap, with a partial rebound). Before it, the stock had fallen as
  much as 19% since the previous Friday (a spell) and about 27% over six months (a
  stretch). The size of the snap only makes sense against that run-up -- the
  middle explaining the end again.
- **Discovery as snap:** an abrupt change in knowledge that triggers new behavior.
  Its effect also depends on readiness: Mendel's 1866 paper drew little response
  for about 35 years; rediscovered in 1900, it triggered genetics (a snap without
  a primed state, then a snap after a long stretch). Kuhn's pattern may map onto
  the three terms: normal science (stretch), accumulating anomalies (spell),
  revolution (snap). Kim's own: finding there is canopy height data.

### Verify before writing

- Nvidia figures (premarket, intraday low, close on 2026-11-12; the prior-week and
  six-month declines). Mendel publication and rediscovery dates; the Kuhn mapping
  as an analogy, not a claim about Kuhn.

## S3 -- round five, 2026-11-25: PREDICTION PULLED THE FOCUS FROM THE MIDDLE

### Kim (speculation, his word)

- The nightly-news weather section is not very old; its emphasis is prediction
  ("tomorrow, expect a high of 87"). One local channel calls it **"First Alert
  Weather"** -- concerned with upcoming big events: **triggers**, in our terms.
- The story Kim remembers: we didn't know where weather came from until the
  **telegraph**. Communication drives forecasting; satellites (with computational
  models) lifted it to a higher level.
- Did we once depend on the **Farmer's Almanac** before shifting to daily
  predictions? If so, was that a kind of middle system?
- **Kim's point: our prediction-oriented capabilities (not just in weather) have
  pulled the focus away from what we once did with middle-system examinations.**

### Checked (web, 2026-11-25) -- Claude

- Joseph Henry (Smithsonian) realized in 1847 that US storms generally move west
  to east; by 1849 telegraph companies carried weather reports to the Smithsonian
  free, from about 150 volunteer observers; a daily weather map from 1856. In 1870
  forecasting passed to the Army Signal Service, whose original purpose was storm
  warnings for the Atlantic and Gulf coasts and the Great Lakes. (Smithsonian
  Archives; Britannica; historyofinformation.com.)
- The Old Farmer's Almanac: published continuously since 1792 (Robert B. Thomas),
  with long-range forecasts from a secret formula; the rival Farmers' Almanac since
  1818 with 16-month forecasts. Independent checks find little skill (Farmers'
  Almanac about 50%; a Walsh and Allen study of 60 monthly OFA forecasts at 32 US
  stations); the almanacs claim about 80%.
- **1938: the Old Farmer's Almanac dropped its forecasts and printed temperature
  and precipitation averages instead. The public outcry was so strong it
  destroyed the editor's reputation** (Roger Scaife).

### Claude (NOT ruled)

- **Forecasting was born to catch snaps.** The telegraph let news of a storm outrun
  the storm; the first federal service existed to issue storm warnings. "First
  Alert" is the same lineage: a snap detector, matching the 11-21 point that
  perception is tuned to snaps.
- **The almanac was a middle-scale product with a weak method.** Its time frame was
  the season and the year -- planting charts, frost, the coming winter -- but its
  forecasts had little skill. When skillful prediction arrived, it arrived at the
  short end, and public attention followed the skill.
- **The 1938 episode is a gem for S3:** readers rejected averages (the climate end)
  and wanted a forecast. Neither end gave them the middle -- "what kind of season
  is this turning out to be?" -- which is the question the almanac pretended to
  answer.
- **The middle didn't vanish; it went to specialists:** crop and weather bulletins
  for farmers, drought monitors, water managers, seasonal outlooks that are issued
  but not broadcast. The public channel kept the snaps.
- Kim's "not just weather" may generalize: markets (daily ticks), health
  (alerts), news itself -- prediction and alerting crowd out reading the season.

### Verify before writing

- FitzRoy (UK, 1861) and the word "forecast"; Cleveland Abbe's 1869 Cincinnati
  forecasts; the Walsh and Allen citation and result; Scaife dates (appointed 1936,
  1938 edition); USDA Weekly Weather and Crop Bulletin start date; NOAA CPC
  30/90-day outlooks as the modern seasonal product.

### Kim -- weather has a speed (2026-11-25)

- Kim read that weather moves across the continent at about 30 mph (unverified):
  "an interesting concept: weather has a speed." Filed with the telegraph history.
- Claude (NOT ruled): mid-latitude systems typically move east at roughly 20-30
  mph, faster in winter; at 30 mph a system crosses the US in about four days --
  spell length. The telegraph worked because the news outran the storm.
- Verify: typical speeds of US frontal systems by season.

### Kim -- memory, and the Hawai'i hurricane map (2026-11-25)

- **Memory is another time-based thing: we forget events that occur
  infrequently.**
- One of Kim's favorite diagrams: **the map of the historical record of
  hurricanes approaching Hawai'i.**
- Claude (NOT ruled): human memory has its own time window; events rarer than it
  fall out of awareness between occurrences (kin to shifting baselines). The
  hurricane-track map is an EXTERNAL MEMORY: it collapses decades of rare snaps
  into one picture -- an accumulation display in space. The envelope's record-year
  lines play the same role in time. A reproducible version could be drawn in R
  from the NOAA HURDAT2 / IBTrACS central Pacific tracks.
- Verify: source and design of the map Kim means; Hawai'i landfalls and near
  misses (e.g., Iniki 1992).

### Kim -- the DC cherry-blossom analysis (2022), shared 2026-11-25

- Kim's own R Markdown (`cherry_blossom.Rmd`, 2022-03-09) and four plots: NPS
  phase dates for the Tidal Basin Yoshino cherries, 2004-2021; phases drawn as
  stacked bars per year in days from a Feb 15 anchor, plus phase-length bar,
  box and dot plots.
- **Kim: having a sentinel tree was a key to setting the dates year after year.**
- Filed 2026-11-25 at `Projects/S3/figures/cherry_blossom/` (Rmd + four plots,
  byte-identical to Kim's upload; `NOTES.md` lists the known code issues).
  Kim: "I did the charts quite quickly. Haste makes waste (or, rather, bad code)."

### Claude on the cherry analysis (NOT ruled; numbers computed from Kim's table)

- **Kim's plot 1 is already the S3 display grammar:** phases as bars on an
  anchored time axis, years stacked -- the same form as rain_periods, and it shows
  between-year variability directly (the round-four theme, done in 2022).
- **The variability sits early.** Green buds last 4-21 days (median 8.5); florets
  visible 1-11; extension 1-7 (median 2); peduncle 1-14; puffy white 2-8 (median
  4). Puffy white to peak is 2-8 days, mostly 2-5. Once puffy white is reached the
  rest runs nearly on a clock; the uncertainty is all in the early, weather-
  sensitive phase. That is why peak can only be called a few days ahead.
- **Kim's 2018 miss is in the data:** trip Mar 31-Apr 1; peak Apr 5. That year had
  the longest florets-visible phase (11 days) and an 18-day green-bud phase --
  development stalled early.
- **2017 is the snap-as-trigger case:** Kim's table flags frost; peduncle
  elongation ran 14 days (the outlier). A freeze stage-gated by development --
  the 11-21 framing in Kim's own data.
- **Peak dates span three weeks** (Mar 20, 2012 and 2020, to Apr 10, 2014 and
  2015); start-to-peak 17-39 days (median 27).
- **The sentinel is an operational definition** (Bridgman; MRC): the same tree and
  the same stage criteria every year make the series comparable.
- Code notes for any reuse: plot2 uses `phase_levels`/`phase_limits` before they
  are defined; `fun.y` is deprecated (now `fun`); the 2010 row lacks its trailing
  comma; one output is named `cheery_plot3.png`. Data could be extended
  2022-2026 from NPS.

### Verify before writing

- NPS indicator-tree practice (location, how far ahead of the general bloom) and
  the stage definitions; the March 2017 freeze and its effect on the bloom; the
  2022-2026 bloom dates.

### Kim -- visualization friction and the paper that was never written (2026-11-25)

- Not long ago most science communication went through journals. Early in Kim's
  career, graphics were discouraged (production costs among the reasons); a chart
  had to be black and white, with gray scales done by screen patterns or stripes.
  Creating visualizations was a big problem.
- **Story:** Kim abandoned an interesting paper because he could not create a map
  showing the plant distribution. A lot of field effort and cost -- a hard-to-reach
  international site -- was wasted because of a technical limitation.
- **This may have limited creative thinking, since visualizations often give us
  insight.**

### Claude (NOT ruled)

- Belongs in the S3 friction chapter beside the IRP weather story: friction in
  COLLECTING (gauges, keypunch) and friction in SHOWING (the map that could not be
  drawn). Two costs, the second less often told.
- **Friction shaped thinking, not only output:** if a figure cannot be drawn, nobody
  looks for what it would show. That is the trilogy's founding point (no concept,
  no seeing) with the visualization as the concept's carrier. Cheap plotting
  arrived with Tukey-style exploratory graphics; journals moved to color online.
- Resonance: Kim's Voronoi document is titled *The Map That Never Got Drawn* (2026-09-27).
  Ask Kim whether this paper's map is the one behind the title.

### Verify before writing

- Kim: the site, the plants, the decade, and whether the data survive (a candidate
  to finally draw the map now). Tukey, *Exploratory Data Analysis* (1977).

### Kim -- answers, and the 1985 chart book (2026-11-25)

- The abandoned paper's map is **not** the map behind *The Map That Never Got
  Drawn* -- "a very different kind of map."
- **The data are gone:** the trip was years before scanners; all data from that
  trip are lost. (So it cannot be redrawn; it stays a friction story.)
- **This is definitely inside the "you don't see it" theme.** Kim hopes the
  trilogy presents **novel (or rarely used) visualizations.**
- **Kim's book:** K. W. Bridges and Sam Kim, *Scientific Chart Design: Computer-
  generated charts using TELL-A-GRAF* (Honolulu, January 1985; 94 pp, scanned PDF
  uploaded 2026-11-25). Kim's teaching strategy: **find the visualization of what
  you want, then see the code that creates that specific visualization.** "That
  was quite successful."

### Claude on the 1985 book (NOT ruled; read from the scan)

- Structure: a picture-first table of contents (chart types shown as small
  drawings); numbered examples, each a figure beside its exact TELL-A-GRAF
  specification, the central lines in bold; deliberately simple test data ("Why
  bother entering a lot of data if you aren't sure that it is going to work?").
- **The preface is a friction-chapter quotation:** "While automation has invaded
  the rest of the laboratory, illustrating remains a manual process. This is
  changing." And the prediction that computer charting "will gain quick acceptance
  in the scientist's office and take its place beside the wordprocessor." Kim
  stood at the moment the drawing friction began to fall -- the same friction that
  cost him the abandoned paper.
- **The 1985 method is the answer to overview gap 7** (display forms
  uncatalogued): a picture-first catalog of S3's displays -- envelope, duration
  ladder (rain_periods), accumulation curve, gauge, phase bars (cherry), enriched
  climate diagram -- each shown first, with its R code beside it. Could serve the
  whole trilogy (shared visual language) as an appendix or companion gallery: Kim's
  1985 strategy, reborn in R, for visualizations that are novel or rarely used.
- Personal-story value: a 1985 book by Kim on the very subject (with a designer
  co-author from UH Art).

### Kim's ruling -- the picture-first catalog (2026-11-25)

- **Keep the catalog idea for now.** The style already in use -- every chart made
  with code, the code shown when a button is pressed -- is a very similar strategy.
  The 1985 book worked because TELL-A-GRAF code was brief; R code can be much
  longer, so **hidden-until-asked** suits it better.

### Kim -- pressure as terrain (2026-11-25)

- On the overview weather map, the H and L areas and the fronts are abstract lines
  over a base map. Kim pictures **high pressure as a "mountain" of air and low
  pressure as a "valley"**, and wants to visualize the 3D structure of the
  atmosphere for a more interesting view of the pattern. Limitations expected.
  Unsure whether it fits the current work.

### Claude (NOT ruled)

- **Forecasters already think this way aloft:** upper-air charts map the height of
  a pressure surface (e.g., 500 hPa) -- literally its topography -- and the
  features have terrain names: ridge, trough, col, cut-off low.
- **The instructive limitation:** air does not roll downhill. On the large scale
  it flows ALONG the contours (geostrophic balance; clockwise around highs in the
  northern hemisphere). Only near the ground does friction let it spiral out of
  highs and into lows, where it rises -- clouds and rain. A terrain view makes
  that surprise visible.
- **Fronts are not terrain;** they are boundaries between air masses (temperature,
  humidity) and tend to lie in pressure troughs. Drape temperature as color over
  the pressure terrain and fronts appear as sharp color edges in the valleys.
  Trilogy tie: a front is a boundary in space between categories (air masses) --
  MWT's subject; the surface map is a judged-boundary tile map.
- **Scale:** heavy vertical exaggeration needed, as in relief maps.
- **S3 tie -- the moving landscape:** the terrain drifts east ("weather has a
  speed"). A barograph trace at one station is a transect across a moving
  landscape; a front passage is crossing a valley -- a snap. Animated over a week,
  the map shows spells and stretches as terrain that lingers.
- Feasible in R: gridded sea-level pressure or 500 hPa heights (GFS, ERA5) +
  rayshader (3D relief) or plotly surfaces. A candidate entry for the catalog of
  novel visualizations.

### Verify before writing

- Typical 500 hPa height range; geostrophic flow and surface friction angle;
  data access route (NOAA NOMADS / ERA5 via an R package).

### Prototype built (2026-11-25) -- Kim: "I think we should try it!"

- Kim: the air-flows-along-contours point corrected a misunderstanding he held.
- `Projects/S3/figures/pressure_terrain/`: `pressure_terrain.R` (pt_get_gfs, pt_smooth,
  pt_scene, pt_render; terra + rayshader), the GFS 2026-11-25 18Z grib, a 3D render
  and a 2D draft. rayshader installed on Kim's machine for this.
- Reads well: the Gulf of Alaska low (975 hPa) as a basin, the 1042 hPa high over the
  Northeast as a hill, a ridge across the continent. Limits seen: sea-level pressure
  over the Rockies is extrapolated and noisy (smoothed); isobar overlay faint;
  warm colors dominate. Next ideas: a 500 hPa height version (the forecasters'
  terrain, no mountain artifacts); an animation over several days (the moving
  landscape); a station barograph as a transect across it.
- **500 hPa version built the same day** (Kim: "VERY promising"):
  `z500_terrain_20261125_18z.png`, `pt_scene500()` in the script. The jet stream's
  waves read as terrain: a deep trough over the Gulf of Alaska (522 dam), a closed low
  over the central US (556 dam, a crater near Kansas), a ridge between them, and the
  subtropical high (588 dam) right over Hawai'i. The surface slopes down from the warm
  south to the cold north -- the polar 'bowl'. No mountain artifacts. Still to fix:
  contour overlay not visible; fine-grained shading speckle on the southern plateau.
- S3 note (Claude, NOT ruled): these waves are the ladder's 1-2 week row (Rossby
  waves, blocking, cut-off lows) made visible.
- **The moving landscape, built the same day** (Kim: "really, really interesting"):
  25 GFS analyses, 2026-11-19 18Z to 11-25 18Z every 6 h, rendered with a fixed
  floor (496 dam), color range and camera; `z500_animation_nov19-25/` holds the
  frames, a GIF (2.8 MB) and an MP4. A trough near the West Coast on Nov 19 moves
  inland and east over the following days; by Nov 25 it has closed off over the
  central US while a new trough deepens over the Gulf of Alaska. Weather's speed,
  seen. Frame renderer saved as `pt_frame500()` in `pressure_terrain.R`.
- **The Topeka barograph, built the same day** (Kim chose Kansas): `topeka_barograph_nov19-25.png`
  + `topeka_barograph.R` + CSVs. A: GFS 500 hPa height at Topeka; B: observed hourly
  sea-level pressure (KTOP, ASOS via Iowa Environmental Mesonet) with GFS points --
  the model tracks the observations closely; C: observed temperature.
- What it shows (Claude, NOT ruled): a two-day pressure fall to 1008.5 hPa (Sat Nov 21,
  late morning HST); that evening temperature drops from about 19 to 7 C in a few
  hours and pressure climbs about 25 hPa over two days -- a cold front: a SNAP sitting
  on a SPELL. Then a cold stretch near 0 C. Panel C holds three scales at once: the
  daily cycle, the frontal step, the multi-day cooling. Panels A and B disagree on
  Wed Nov 25: the closed low is overhead aloft (556 dam) while surface pressure is
  high (about 1030 hPa) -- cold, dense air at the surface under a low aloft. The 3D
  structure Kim wanted to see, read from one station.
- **Rivers of air, built the same day** (Kim: the along-the-contours flow corrected his
  mental model; "how can we show this?"): `rivers_of_air_20261125_18z.png` +
  `rivers_of_air.R`. A: 500 hPa contours, 500 hPa wind arrows, jet core shaded by 250 hPa
  speed (max 93 m/s). B: sea-level isobars and 10 m wind. C/D: the angle between wind and
  contour direction at every grid point north of 22N -- aloft median 7 deg off the
  contours (87% within 20 deg); at the surface median +20 deg, turned toward low pressure.
- Claude (NOT ruled): Kim's old model (air flows downhill from high to low) is partly
  right near the ground, where friction slows the wind and lets it drift toward the lows
  -- and that inflow is what makes air rise and rain in lows. A candidate catalog entry
  and an S3 personal story: the misconception corrected, and how a picture did it.

### ★ Kim's ruling -- save this integrative statement (2026-11-25)

- Kim: "a powerful integrative view" -- to be kept, verbatim (Claude's wording, adopted by Kim):

  > "It's what happens in the lowest kilometer or so, where friction slows the wind and lets it
  > drift downhill toward the lows. That inflow matters: air converging into a low has to go up,
  > and rising air makes clouds and rain. Higher up, friction is gone, and the air circles the
  > terrain instead of descending it."

- Context: answers Kim's prior mental model (air flows downhill from high to low pressure) --
  true near the ground, not aloft.
- **Kim: the angle histograms (panels C and D) are a key visualization.**
- Next (Kim): particles drifting along the 500 hPa contours.
- **Built the same day:** `particles_500_20261125_18z.gif` (120 frames, about 40 h of flow,
  1,500 particles, frozen 18Z field) + `particles_500.R`. Streaks follow the contours, race
  through the jet core, and circle the closed low over Kansas. Speed lesson: the Windows png
  device took about 35 s per frame with semi-transparent trails; ragg::agg_png took 0.4 s.
- Possible next: particles on the moving (6-day) field; the same particles at 10 m to show
  the inflow into lows (the integrative statement as motion).
- **Surface companion built the same day** (Kim asked): `particles_10m_20261125_18z.gif`
  (`particles_10m()` in `particles_500.R`; 60 min of flow per frame, 3x the 500 hPa
  version). Air spirals into the Gulf of Alaska low and out of the highs; streaks converge
  along a curving line southwest of the low -- the cold front, where air from two
  directions meets. The integrative statement, in motion.
- **"Where is 500 hPa?" built the same day** (Kim: make 500 hPa something people relate to):
  `where_is_500hpa.png` + `where_is_500hpa.R`. Standard atmosphere: 500 hPa about 5,570 m
  (18,000 ft) -- half of all the air below; 850 hPa 1,460 m (16% below); 250 hPa 10,360 m,
  the jet level (75% below). Landmarks: Haleakala, Mauna Kea (about 600 hPa; 41% of the
  air beneath), Kilimanjaro, Denali, Everest (69%), airliner cruise; plus today's band of
  the real 500 hPa surface (5,064-5,924 m) -- the terrain in the animation.

### Kim -- a small addition, a large impact (2026-11-25)

- Waves are battering the West Coast today (Kim's report): tides, El Nino and weather
  working together for record wave impacts -- "as though there is just a bit of height
  added to the usual pattern that's making the difference."
- **How to visualize it?** "Sort of the inverse of using log values to keep high peak
  values from dominating a chart. Now we need to show that a small addition to the
  average (pattern) has a large impact."

### Claude (NOT ruled)

- **It is a threshold problem.** Impact begins at a boundary (flood stage, the top of a
  seawall, the dune toe); what matters is the part above it. A few percent added to the
  water level can multiply the hours and volume above the line. Three displays:
  1. **The tip view:** the tide curve with the threshold drawn in; only the part above it
     filled. Panels with and without the addition show the tip growing out of
     proportion.
  2. **The exceedance curve:** impact (hours above threshold) against the size of the
     addition -- steep, which is the inverse-of-log point made explicit.
  3. **The shifted distribution:** a small shift of the whole distribution multiplies
     the frequency beyond a fixed threshold (the familiar climate-extremes figure).
- **The three terms again:** El Nino raises sea level for months (a STRETCH, the middle
  scale -- the "bit of height"); a storm sequence adds surge and swell (a SPELL); high
  tide at the storm peak is the SNAP. Stretch = state, spell = load, snap = trigger.
- MRC tie: the threshold is a category boundary; accuracy matters most near it.
- Data route: NOAA CO-OPS tide gauges (observed vs predicted water level, flood
  thresholds) via its API from R.

### Kim -- thresholds, rivers, and the cultural view of floods (2026-11-25)

- **San Francisco** is the perfect example (city streets flooded, in the news). Fits the
  middle area of interest: **crossing the threshold can have a huge impact.**
- Coasts see the tides; **inland, rivers are the analog.**
- **A cultural perspective is needed:** our society sees floods as bad; **earlier societies
  depended on the annual floods.** Kim wrote about this in his story *Wandering in Angkor*.
  Many examples of river floods bringing nutrients to delta areas.
- **Periodic vs aperiodic:** some big events, like floods, are fairly periodic; others,
  like tsunami inundations, are aperiodic and seen on very long time scales.

### Claude (NOT ruled)

- The same threshold, two meanings: the flood pulse as resource (Nile basin irrigation,
  the Mekong's reversal into the Tonle Sap that fed Angkor) vs the flood as hazard. The
  value judgment sits in the category boundary, not the water (MRC).
- Periodic thresholds are learned (a society builds around the annual pulse); aperiodic
  ones are forgotten between events (the 11-25 memory idea) -- tsunami stones in Japan as
  an external memory.

### Verify before writing

- *Wandering in Angkor* on kimbridges-stories (what Kim wrote); Tonle Sap flow reversal;
  Japanese tsunami stones.

### Built (2026-11-25): San Francisco, a small addition and a large impact

- `Projects/S3/figures/thresholds/`: `sf_small_addition_nov18-25.png`, `sf_small_addition.R`
  (`sa_get()`, `sa_plot()`; any NOAA CO-OPS station), and the week's data as CSV.
- NOAA station 9414290, Nov 18-25, MHHW datum. Thresholds: NWS minor flood 0.37 m, NOAA
  minor 0.57 m; station record 0.86 m on Jan 27, 1983 (an El Nino winter).
- The predicted tide alone (a king tide building through the week) peaks at 0.36 m: 0.3 h
  above the NWS line. The observed water ran a median +0.35 m above prediction (the
  non-tidal residual: raised sea level, surge, wind, runoff): 14.9 h above the NWS line,
  6 h above NOAA's; peak 0.73 m on Mon Nov 24. Panel C: hours above the line vs height
  added -- flat until the tips reach the line, then steep.
- Caveat for the text: a tide gauge records still-water level in the bay; the record
  wave impacts on the open coast add wave run-up on top.

### ★ Kim's ruling -- the series style: examples plus tools (2026-11-25)

- The San Francisco visualizations and storyline work well, and the code can analyze
  other areas. **That is the style Kim intended for the series:** "you get examples here,
  now use these in your own situation" -- or, "This is what I found; now you can find
  your own examples using the tools provided." (Applies to the whole trilogy.)

### Kim -- Noguchi 1979: wind recorded in tree shapes (2026-11-25)

- Y. Noguchi (1979) Deformation of trees in Hawaii and its relation to wind. *Journal
  of Ecology* 67: 611-628 (PDF uploaded 2026-11-25). Kim has always thought it creative.
- Kim: it shows that **persistent trends are recorded in the vegetation.** We usually think
  of these as water- or temperature-related; Yasuo, then a graduate student (now
  Professor Emeritus Noguchi), showed that **wind impacts can be scaled by the
  deformation of a variety of species.**

### Claude on the paper (NOT ruled; read from the PDF)

- 1,045 isolated trees at 590 sites on O'ahu and Maui, 60 dicot species; deformation
  graded by crown asymmetry and slant within four crown classes (umbrella, cone, flag,
  Casuarina); direction by compass. Species calibration: Casuarina, Prosopis, Cassia,
  Tabebuia more wind-resistant (+1 grade), Ficus benjamina more sensitive (-1).
  Consistency within a site: 82% of mixed-species trees within +/-5 degrees of the site's
  median direction. Result: flow-line and deformation-grade maps for both islands,
  agreeing broadly with instrument-based maps.
- **The key sentence for S3:** discrepancies with instrument maps were "probably
  attributable to the differences in the periods of time represented" -- the instrument
  maps covered 15 tradewind days (1963) or a few weeks; the trees integrate years. A
  tree's crown is a long-period average of the wind: a recorder like a tree ring, but of
  persistence rather than seasons -- the middle-to-long scale written in shape.
- **Trilogy-wide:** MRC -- an ordinal grade scale, calibrated across species (the same
  wind read on instruments of different sensitivity). MWT -- category data at points
  turned into isolines and flow lines (the map from points). Friction -- 590 sites by
  road and trail with a clinometer and compass, before gridded wind data existed.
- Possible then-and-now: Noguchi's tree-derived flow lines vs a modern high-resolution
  wind climatology for O'ahu and Maui.

### Verify before writing

- The modern source for a Hawai'i wind climatology (resolution, period); Noguchi's later
  career and title as Kim gives it.

## S3 -- the coarse end: frozen categories, rare events, and waking up (Kim, 2026-11-25)

### Kim

- For a long time we treated a location's climate as a constant (long-term sense): if
  you live in Zone 7a you stay in 7a unless you move. With climate change we hold on to
  the broad category but are unsure of the future.
- **What we are seeing, Kim believes, is a change in the frequency of extreme events.**
  Who would have expected the high tides in SF? The events often impact how the
  ecosystem functions.
- Back to the historical hurricane patterns for Hawai'i, and tsunami inundations: **how
  do we record these in ways that alert people to the rare but consequential events?**
- New interest in forest-fire protection; coastal cities re-evaluating shoreline
  development; flood zones driving home-insurance rates.
- **It seems we need significant events (e.g., the Los Angeles fires) to wake up the
  population -- and then it might be too late. Is there a theme here?**

### Claude (NOT ruled)

- **Theme: the categories assume the world holds still.** Zone 7a, the 100-year flood
  line, the flood-zone tile on an insurance map all rest on a stationary distribution
  ("Stationarity is dead" -- Milly et al. 2008, *Science*). When the distribution
  shifts, the category label stays while the tails move -- and change shows first in
  the tails (the shifted-distribution panel; SF this week).
- **Rare events outrun memory.** A 1%-per-year event has about a 26% chance in a
  30-year mortgage, yet most residents never see one; memory fades between events
  (Kim's memory idea, 11-25). The middle scale fails here because the events are rarer
  than human attention.
- **External memories carry what people forget:** the Hawai'i hurricane-track map,
  tsunami stones, high-water marks on buildings -- and insurance rates, a memory with
  a price attached that works between events.
- **Waking up:** policy follows 'focusing events' (Birkland); drought has the
  'hydro-illogical cycle' (concern, then apathy when rain returns). The snap that wakes
  people comes after the stretch that set it up -- stretch = state, spell = load, snap
  = trigger, applied to society.
- **Trilogy-wide:** MRC (moving category boundaries -- the zone map redrawn); MWT (flood
  zones are tile maps); S3 (frequency of extremes, return intervals, memory).
- Candidate closing chapter for S3: the forward direction made urgent.
- Displays: chance over a lifetime or mortgage vs return period; memory span vs return
  interval; an external-memory map (Hawai'i hurricane tracks, tsunami run-ups).

### Verify before writing

- Milly et al. 2008 citation; Birkland 'focusing events'; NDMC 'hydro-illogical
  cycle'; USDA zone map editions and shifts; 1 - 0.99^30 = 0.26.

### Kim -- Asimov's Foundation as the image (2026-11-25)

- Kim imagines all this in Asimov's trilogy: a mathematical model holding the equations
  that state the probabilities of the events discussed, and a few scientists who
  understand and guard the model to protect future generations.

### Claude (NOT ruled)

- Psychohistory predicts only for large numbers, never individuals -- like a return
  period: the frequency, not the year. Seldon Crises are snaps the plan expects in
  kind but not in detail.
- **Seldon's Time Vault** -- recorded messages that open at each crisis -- is an external
  memory timed to the event: a tsunami stone with a schedule.
- **The Mule** is the non-stationary shock the equations could not hold: the plan assumed
  the distribution would stay put ("stationarity is dead").
- **A tension worth using:** Asimov's guardians (the Second Foundation) kept the model
  secret. Kim's series does the opposite -- examples plus tools, so readers can run the
  probabilities themselves. An open psychohistory.
- Possible epigraph or closing image for S3 (and a nod to one trilogy from another).
- Verify: Foundation (1951), Foundation and Empire (1952), Second Foundation (1953);
  details of the Time Vault and the Mule.

### Kim's rulings at the close (2026-11-25)

- **Keep the Asimov/Foundation image as a CLOSING IDEA for S3.** ("Fun? Yes!")
- **Current data as method:** Kim particularly likes that this week's data showed
  fundamental ways to look at current data -- "a reminder that there are important
  things happening all the time."

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
