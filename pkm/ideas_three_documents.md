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

## S3 -- working outline, round three (DRAFT, Claude, 2026-11-25 evening; for Kim's rulings)

_Supersedes the 2026-09-22 seven-part outline once ruled. Test applied to every chapter: what
does it show at the middle scale that the two ends cannot? [F] = figure already built._

**Prologue -- The weathercast, twice.** Kim's two versions ("start of our rainy season ... four or
five big pulses" vs "rain is forecast for Thursday").

_Part I -- The missing middle_
1. **Two ends and a gap** -- climate averages vs the nightly forecast; prediction pulled the focus
   (telegraph forecasting born to catch snaps; 'First Alert'); the almanac as a middle-scale
   product with a weak method; the 1938 averages revolt; the frog and the measurement interval.
2. **Calendar time and event time** -- time templates; the event year (boundary in the trough);
   periods vs amounts; the wet-weather ladder. [F] rain_periods.
3. **Snaps, spells and stretches** -- three kinds of departure (rate; threshold + duration;
   persistence) and three roles (trigger, load, state); the snap gated by the middle; vocabulary
   gaps (no 'heat snap'); beyond weather (Nvidia, discovery); the three criteria (noise relative
   to the receiver; the sap-flow counterexample; relative vs absolute thresholds).
4. **Definitions become operations** -- the five implementations as theories of the word; the
   disagreement map; Bridgman, lightly.

_Part II -- Reading the middle_
5. **Accumulation** -- degree-days and the Arizona insects (Werner, verify); running sums;
   hardiness zones (an average of snaps); the superbloom (a snap triggered by a stretch).
6. **The living calendar** -- opens with the lupine hillside; DC cherries (sentinel tree; Kim's
   2022 analysis: variability sits early, the 2018 miss, the 2017 frost) [F]; Kyoto's window;
   fireweed's gauge; amplified phenology; migratory land birds and voyaging.
7. **Recorders** -- tree rings; otoliths (daily and annual); Noguchi's wind-shaped trees
   (persistence written in form); gauge vs archive.
8. **This year against the envelope** -- the Mekong displays; the enriched Walter-Lieth diagram
   (Lieth); the neglect of variability; thresholds: San Francisco's small addition [F]; floods as
   resource vs hazard (Angkor); periodic vs aperiodic.
9. **The moving landscape** -- pressure as terrain, the six-day animation, Topeka's barograph,
   rivers of air and the integrative statement, particles aloft and at the surface, where 500 hPa
   is [F x7]; weather has a speed; the 1-2 week row made visible.

_Part III -- Living with the middle_
10. **Forward and backward** -- the groups who work at this scale; the loop; fire (forward:
    stretch grows fuel, spell cures it, snap ignites); vintage (backward: Ashenfelter); farmers,
    water managers, travelers booking cherry trips.
11. **Friction, then and now** -- the IRP transect and keypunch; the map that could not be drawn;
    the 1985 preface; API access; scarcity habits; the Jones recovery; Noguchi's 590 sites.
12. **Frozen categories and rare events** -- stationarity is dead; Zone 7a; the 1% flood and the
    mortgage; memory vs return interval; external memories (hurricane tracks, tsunami stones);
    focusing events; the slow wearing away (sea otters); shifting baselines.
13. **The test: Hawai'i** -- trade-wind persistence (Noguchi); kau and ho'oilo; windward vs
    leeward; percentile spells that do not matter; hurricanes and tsunamis.

**Closing -- An open psychohistory.** Asimov's Foundation; examples plus tools.
**Appendix -- The catalog.** Picture-first; code hidden until asked.

### Gaps the draft exposes (Claude, NOT ruled)

1. **Thirteen chapters is long** (MRC has ten). Candidates to merge: 4 into 3; 13 into the others
   as recurring tests; 7 into 6.
2. **The worked groups are uneven.** Fire has a template but no figure or data; vintage has
   only the Ashenfelter reference (Kim's two wine stories could help); tree rings moved into
   Recorders.
3. **Chapter 4 has nothing built:** the five implementations have never run on a real record.
4. **Scope is still open:** beyond-weather examples are few (Nvidia, discovery, the otters). The
   outline keeps the environment central with excursions; that needs a ruling.
5. **The forward direction is thin:** fire, water decisions, seasonal forecasting.
6. **Drought and the dry side** are missing (Topeka gives a cold front; nothing for dry spells).
7. **Chapter 12 needs its figures:** the hurricane-track map; chance over a mortgage vs return period.
8. **Personal stories are uneven:** rich in 6, 7, 11; thin in 2, 3, 4, 9 (Kim's paper-chart
   recorders could anchor 9: the barograph he used to read).
9. **Chapter 9 may be too big** for one chapter (seven figures).

### Kim's rulings on the draft (2026-11-25 evening)

- **Merge chapters 3 and 4** and **move them to second place**: snaps, spells and stretches are an
  important theme and belong early.
- **Merge chapter 7 (Recorders) into chapter 6 (The living calendar).**
- **Spread chapter 13 (Hawai'i) through the others** as recurring tests.
- **SCOPE RULED:** be candid -- **the environment is central**, because it is broad in scope
  (planet-wide) and a factor underlying so many other things. Excursions beyond it
  (markets, discovery) remain welcome as examples.
- Next (Kim): he will give stories; then work through the process of getting good graphics.

## S3 -- working outline, round three, REVISED (after Kim's rulings, 2026-11-25 evening)

_Ten chapters in three parts, like MRC. [F] = figure built. [H] = where the Hawai'i test appears._

**Prologue -- The weathercast, twice.**

_Part I -- The missing middle_
1. **Two ends and a gap** -- climate averages vs the nightly forecast; prediction pulled the focus
   (telegraph, 'First Alert'); the almanac and the 1938 revolt; the frog and the measurement
   interval; the guiding principle; scope stated candidly (the environment, planet-wide).
2. **Snaps, spells and stretches** -- three kinds of departure (rate; threshold + duration;
   persistence) and three roles (trigger, load, state); the snap gated by the middle; vocabulary
   gaps; beyond the environment (Nvidia, discovery); the three criteria (noise relative to the
   receiver; sap flow; relative vs absolute thresholds); the five implementations as theories
   of the word and where they disagree; Bridgman, lightly. [H: percentile spells that do not
   matter in a low-amplitude climate]
3. **Calendar time and event time** -- time templates; the event year (boundary in the trough);
   periods vs amounts; the wet-weather ladder. [F] rain_periods. [H: kau and ho'oilo; the
   Makahiki as a year framed by events]

_Part II -- Reading the middle_
4. **Accumulation** -- degree-days and the Arizona insects; running sums; hardiness zones (an
   average of snaps); the superbloom (a snap triggered by a stretch).
5. **The living calendar and its recorders** -- the lupine hillside; DC cherries [F]; Kyoto;
   fireweed (gauge); amplified phenology; land birds and voyaging; then the archives: tree
   rings, otoliths, Noguchi's wind-shaped trees. [H: trade-wind persistence written in crowns]
6. **This year against the envelope** -- the Mekong displays; the enriched Walter-Lieth diagram;
   variability; thresholds: San Francisco's small addition [F]; floods as resource vs hazard
   (Angkor); periodic vs aperiodic. [H: windward vs leeward rainfall envelopes]
7. **The moving landscape** -- pressure as terrain; the six-day animation; Topeka's barograph;
   rivers of air and the integrative statement; particles aloft and at the surface; where
   500 hPa is [F x7]; weather has a speed. [H: the subtropical high over the islands; Kona lows]

_Part III -- Living with the middle_
8. **Forward and backward** -- the groups who work at this scale; the loop; fire (forward);
   vintage (backward); farmers, water managers, travelers.
9. **Friction, then and now** -- the IRP transect and keypunch; the map that could not be drawn;
   the 1985 preface; API access; scarcity habits; Jones; Noguchi's 590 sites.
10. **Frozen categories and rare events** -- stationarity; Zone 7a; the 1% flood and the
    mortgage; memory vs return interval; external memories; focusing events; the sea otters.
    [H: the hurricane-track map; tsunami inundations]

**Closing -- An open psychohistory.** **Appendix -- The catalog** (picture-first; code hidden until asked).

**Gaps still open (from the draft review):** worked groups uneven (fire: no figure; vintage: thin);
chapter 2's implementations never run on a real record; forward direction and drought thin;
chapter 10 needs its figures; personal stories thin in 1-3 and 7; chapter 7 large.

## S3 -- Kim's chapter stories, first drafts (2026-11-25 evening)

_Kim: "This is all pretty rough as I'm quite tired from a long day. Treat the stories as a draft
subject to our (joint) editing." Kept verbatim below (typos included) for the joint edit._

### For chapter 3, Calendar time and event time (Kim, verbatim)

> Working with Dieter Mueller-Dombois meant it was inevitable that I'd be creating climate diagrams.
> This was his way of thinking about the year's weather. He was the project director. I liked the
> climate diagram utility, but found the alignment to the boundaries tied to a twelve month temperate
> calendar. My research was examining seasonality and the visualization was working against me. It
> was imposing a structure that might work elsewhere, but not for my studies in Hawai`i.

### For chapter 2, Snaps, spells and stretches (Kim, verbatim)

> Listen to what people say about the weather. Not so much the daily report. But off-hand remarks.
> That's when people slip in terms like snaps, spells and stretches. Now that I'm listening, I'm
> hearing them more often. To the people who use these words, there is an important meaning. Yet
> these word -- they are really concepts -- seem to lie on the edge or even outside of our more formal
> weather descriptions. Maybe, I asked myself, this is a "folk taxonomy" that persists because of its
> utility. It's not needed for the nightly weather forecast. That has its own rigid format. The snaps,
> spells and stretches seems to come from an earlier time when we took a broader view of weather. And
> maybe, just maybe, the concept extends beyond weather. Maybe it is a fundamental way of thinking
> about time-based phenomena.

- ("Definitions become operations", now part of chapter 2: nothing yet.)

### For chapter 7, The moving landscape (Kim, verbatim)

> If we use images to help us think about things, then limitations in creating images will limit our
> understanding. Black and white images usually convey less information than those rendered in color;
> color can be an added bit of data. I lived in that world that was constrained by technology and by
> the slow acceptance of changes in convention. We simply got used to how data were presented. I was
> actually timid in my asking Claude about weather charts that show the highs and lows. I knew the
> fundamentals. At least I thought I did. When I asked for a 3D visualization, it was clear I was
> wrong. The mew visualization showed me where I'd made a bad assumption. I'm pretty sure that I've
> not been alone in making this conceptual error. For me, seeing the data presented in a new way
> opened a door leading to a number of new ways to examine the way weather moves. To be realistic, it
> would have been difficult for me to do this without today's technology resources. The point is,
> however, that we now have the needed capabilities to better portray complex systems, like weather
> patterns. As in other areas, the enhanced visualization isn't limited to weather. It just serves as
> a good example.

### Claude's notes for the joint edit (NOT ruled)

- **Ch.3:** the climate diagram is both villain here (a temperate twelve-month frame on Hawaiian
  seasonality) and hero in ch.6 (the enriched version shows variability). The two meet if the
  ch.6 diagram starts its year in the trough -- the story sets up the resolution.
- **Ch.2:** 'folk taxonomy' is Kim's own ethnobiology vocabulary, and it links to MRC's
  language chapter (Berlin). The line 'persists because of its utility' could carry the
  chapter's thesis.
- **Ch.7:** an honest account of a corrected misconception; pairs with the integrative statement
  and the histograms. Its middle sentences (technology limits, slow conventions) also echo in
  ch.9's friction story.
- Typos to fix in editing: 'these word' -> 'these words'; 'mew' -> 'new'.

### Kim -- story for chapter 7 (and the Hawai'i test): the planes past the window (2026-11-25, at the close)

- After today's work on air flow, Kim checked the flow over the Hawaiian Islands: "a bit
  'backwards' as it is described locally." A few hours later, planes began landing in the
  opposite direction at HNL -- a flight path very (VERY) close to his apartment window. **Each
  plane that goes by is a reminder of the wind pattern and how it changes.**
- Claude (NOT ruled): planes land into the wind, so the runway in use is a wind instrument read
  by everyone under the flight path -- a snap (the reversal) seen at home. Fits ch.7's Kona-low
  test. Verify: HNL runway configurations under trades vs Kona winds.

## S3 -- Kim's chapter stories, second batch (2026-11-26; drafts for joint editing)

### Kim's ruling -- move the Lieth story near the start

> I'd move the Lieth story close to the start. Those were comments out of the blue. A famous
> person making a statement that was clearly close to his heart. If toward the end of your
> career, you had just a few minutes in which to impart advice to a beginner in your discipline,
> what would you say? That's the way I felt with Lieth's comment. It's the sort of thing you
> don't forget. And he was right, but I only discovered that years later.

### For chapter 1, Two ends and a gap (Kim, verbatim)

> Nancy and I have chased phenological events, and we've been successful more often than not.
> Japan to see the Fall colors in Kyoto (there is a series of travel reports in the stories
> folder about one of those trips). Washington, DC, to see the Cherry Blossoms at the Tidal
> Basin. We missed twice and hit it right on once. Many trips to The Flower Fields in Southern
> California to see the Ranunculus flowering. This produced several stories about these plants.
> The botany has generally come first in this travel; it's not a secondary reason for the trip.
> I've published a bit with phenological observations. Seagrass studies. But I was the data
> analyst, not the field observer.

### For chapter 10, Frozen categories and rare events (Kim, verbatim)

> A colleague from Texas, Mike Huddleston, has family on Kaua`i. They were hit hard by Iniki.
> Like so many families, they had lost power and generators had sold out everywhere in the
> islands. Mike flew in with a generator he brought from Texas. I went with him to Kaua`i. We
> were there toward the end of the first week after the hurricane had passed over the island.
> Mike and I knew a lot of special places where we'd taken students on field trips. We revisited
> many of these to see the aftermath of the storm. The tall pines had been stripped of their
> branches in so many areas. Even now, well after that 1992 event, I can see the pattern in the
> branches of the older trees. It's an historical reminder stored in the vegetation.

> When Nancy and I visit Laupahoehoe, a sparsely settled area north of Hilo, different memories
> surface. For me, it was where I first joined the staff in a Peace Corps training project. A
> positive memory as this was my first "professional" job. For Nancy, the place holds a different
> memory. It was here that a relative was lost to a tsunami in 1946. We travel to Laupahoehoe
> Point to visit the plaque commemorating the event and the lives lost most times we're in the
> area. There aren't many places where this has happened in Hawai`i's recorded history. Not so
> for other places across the Pacific.

> Doak Cox, then the scientist in charge of the Preliminary Catalog of Tsunamis Occurring in the
> Pacific Ocean (1967) asked me to help him by converting the paper version to digital records. I
> spent many evenings going through the hundreds of entries and typing the data into a structured
> file. My recollection is that events were rare in any one location and their occurrence
> overall. The catalog covers the long timespan, starting in 173 AD. This is an example of the
> Darwinian idea that a little number times a big number is always a big number. Over the long
> history of infrequent tsunamis, there have been a lot of events.

### For chapter 8, Forward and backward (Kim, verbatim)

> I don't think you can forget the sight of a burning forest, especially if you are close enough
> to appreciate the immense breadth of the flames as they stretch over the hills and through the
> valleys. I can still picture a past event. I was quite young and living in Southern California.
> I didn't really understand what was happening. But it left me with a strong visual memory. It's
> one that still fills me with fear.

- (Kim: "That's all I have time for right now.")

### Claude's notes for the joint edit (NOT ruled)

- **Lieth near the start:** ch.1 could open with it -- the advice that took years to understand is
  itself a middle-scale lesson (understanding that arrives over a career, not a day).
- **Ch.1 vs ch.5 overlap:** the phenology chases are the ch.1 hook (planning trips means living in
  the middle scale; botany first); ch.5 keeps the detail (sentinel tree, the 2018 miss, fireweed).
- **Iniki's pines** are a recorder (ch.5) and an external memory (ch.10): the storm written in
  branch architecture, like Noguchi's trade winds -- a snap stored by a tree.
- **Laupahoehoe** holds both scales in one place: Kim's first professional job and the 1946
  tsunami -- personal memory vs community memory; the plaque is an external memory.
- **The tsunami catalog** serves ch.10 (rare in any one place, many over the long span) and ch.9
  (friction: evenings of typing a paper catalog into a structured file). The 'little number times
  a big number' line is a strong one for ch.10.
- **The fire memory** gives ch.8's forward direction a felt opening: fear as the memory that
  persists -- an external memory carried inside a person.

### Verify before writing

- 1946 tsunami (April 1; Aleutian source) and Laupahoehoe Point losses; Cox's 1967 catalog
  (publisher, entry count, 173 AD start); the source and wording of the Darwin idea; Iniki
  (Sept 11, 1992) on Kaua'i; Kim's seagrass phenology publications; the Kyoto travel reports and
  Flower Fields stories on kimbridges-stories.

## S3 -- the vintage stories reviewed for chapter 8 (2026-11-26; Claude, at Kim's request)

_Kim's three wine stories on kimbridges-stories (flipbook PDFs read in full text):_
- *Finding Fine Wine* (Napa, 2018-06-24; 70 pp) -- the richest for S3.
- *Bordeaux* (Oct 2019 trip; published 2020-04-12; 136 pp) -- the vintage as identity.
- *Bordeaux 2* (2023-02-01; 88 pp) -- little for S3 (harvested countryside at season's end; rain).

### What the stories already hold (from Kim's text)

- **Napa, Hendry Ranch:** George Hendry -- "we know that weather and tastes change ... A year might be
  hot or cold, wet or dry. Each year is different. You can't predict people's preferences or the
  weather." The Hendry solution: plant many varieties -- "spread your bets." 203 acres, eleven
  varieties, 49 blocks; staggered ripening spreads work across the seasons, so labor is
  year-round. Tastes as a second variable: the film *Sideways* moved buyers from Merlot to Pinot
  Noir; Zinfandel, once dominant, now on 3% of the land.
- **Napa, Palmaz:** the opposite strategy -- aerial imagery twice a week drives irrigation; an
  information system tracks every block and barrel; production deliberately ADDS variability so
  that blending can "smooth out the effects of a wet or dry, hot or cold year." Aim: consistent
  wines, year after year.
- **Bordeaux:** arrived just after the 2019 harvest ("the harvest finished on Friday"; a high
  yield; a lunch for the pickers); tastings by vintage (2012, 2014); a highly rated vintage at a
  restaurant; Mouton Rothschild's eleven vintages, each with an artist's label -- the year as
  identity. The trip itself ran through rain fronts: weather-end snaps beside a middle-scale
  product.

### Claude (NOT ruled): the vintage section of chapter 8 -- three answers to the year

1. **Celebrate it (Bordeaux):** the vintage names the year; quality is judged backward from the
   growing season (Ashenfelter's weather equation as the formal version). The year is the product.
2. **Hedge it (Hendry):** diversify so some varieties succeed whatever the year; staggered
   harvests also steady the labor force. The portfolio answer.
3. **Erase it (Palmaz):** measure intensively and blend the variation away. The year is a
   nuisance to remove.
- All three are responses to the same middle-scale fact ("each year is different"); together
  they fill the vintage worked group with Kim's own fieldwork, in his own published words.
- Beyond the environment: tastes change too (*Sideways*) -- a market stretch beside a weather one.
- Personal hook: Kim was there for the end of the 2019 harvest -- the vintage's boundary, seen.

### Verify before writing

- Ashenfelter's Bordeaux equation (inputs, date); the 2019 Bordeaux vintage's character; Hendry
  and Palmaz figures as of 2018 (from Kim's story; may have changed).

### Kim -- what a vintage is (2026-11-26)

> Traditionally, a vintage is a summary of the weather for a season. The grapes in the vineyard are
> genetically identical (a "variety") and each plant, if growing in the same environment, is
> responding the same way as all the other individual plants. It is this shared response that gives
> the character and sums the key weather events of the season. A characteristic vintage may be
> shared across many of the vineyards in the region. People remember, and pay a premium, for
> special vintages. This is a strong example of the middle time zone.

### Claude (NOT ruled)

- **A vineyard is a field of sentinels.** Clonal vines remove genetic variation, so the response
  reads the weather alone -- the same logic as the cloned-lilac networks and the DC sentinel tree
  (ch.5). The vintage is the summed reading of thousands of identical instruments.
- **The vintage is an accumulation (ch.4) and a recorder (ch.5) in one:** the season's key events
  summed into a product that keeps -- a bottle as an archive of one growing season.
- **Shared across a region:** the vintage is a regional signal, like the envelope's year-in-context
  (ch.6).
- **Remembered and priced:** the premium is a memory with a price, like insurance rates in ch.10 --
  but here the market remembers a good season rather than a disaster.
- Opening line candidate for the vintage section: "a vintage is a summary of the weather for a season."

## S3 visualization: Japan's two fronts (2026-11-26)

Kim (11-26): wants a visualization that integrates the spatial and temporal aspects of Japan's fall foliage (koyo): the north-south axis, yearly media predictions, variability between years and places; culturally important (*The Garden at Nanzen-in Temple*); planted maples on hillsides.

Built (Claude, NOT ruled), from JMA phenological observations (designated sample trees, 1953-2025; 102 stations), in `S3/figures/japan_fronts/`:
- `japan_two_fronts.png`. A: the latitude-date plane; cherry flowering and maple coloring as two fronts, station medians with 10-90% bars, the season between the fronts shaded. B: fronts 1961-1990 vs 1996-2025.
- `japan_maple_stripes.png`. C: station x year anomaly stripes (66 stations, south to north). D: national median anomaly by year.
- `japan_fronts.R` (`jf_get()` downloads and parses any JMA phenology CSV with station coordinates); `jma_phenology_work.rds`.

Results: cherry front moves north ~25 km/day, maple front south ~29 km/day (ginkgo ~39). Year-to-year spread about two weeks at a station. Season between the fronts: ~246 days at 35N, ~180 at 43N. At 36N the cherry front now arrives 5 days earlier and maple 10 days later (15 more days between them). Maple trend +2.7 d/decade, cherry -1.1 (JMA publishes +3.0, -1.3). Latest maple years: 2024, 2020, 2011.

Fit: ch.5 (the living calendar; a national network of sentinel trees, a direct echo of Kim's DC sentinel tree) and ch.6 (this year against the envelope; panel D is the envelope for a nation). The two fronts make 'weather moves at 30 mph' concrete at a slower speed: a front of color moving ~1 mph. Possible extensions (NOT ruled): isochrone map of the front, ginkgo, elevation (koyo descends the mountains).

### Japan front maps (2026-11-26, later)

Kim: 'This is getting at what I'm interested in. Bravo! Let's move forward with the Japan map. That may reveal even more.'

Built (Claude, NOT ruled): `japan_front_maps.png` + `japan_front_maps.R` (any JMA phenomenon; surface = regression on latitude, longitude, elevation + thin-plate spline of residuals, on a 30" DEM). A: cherry front in 10-day bands. B: maple front. C: change in maple date per station, 1996-2025 vs 1961-1990.

What the map adds beyond the latitude plot: the maple front is not a clean north-south line; it follows terrain, coloring the mountains first and descending (3.2 days earlier per 100 m; cherry 1.2 days later per 100 m). The Pacific coastal plains (Tokyo, Kanto) are last for maple and first for cherry; Tokyo blooms in the same band as Fukuoka. Maples turn later at 72 of 77 stations (median +9.5 days). Caveat: stations reach only 612 m; above 1000 m the surface is held, so the mountains are understated.

### Maple front animation (2026-11-26, later)

Kim: 'I can easily picture places I know, such as Kyoto. An animation of the maple front would show the pattern in a very interesting way.'

Built (Claude, NOT ruled): `japan_maple_front.mp4` / `.gif` + `japan_maple_animation.R` (any JMA event). Sep 15 to Dec 31, one frame per day of the 1991-2020 normal, over hillshaded terrain; stages green, turning, peak (JMA's date), fading, bare (stages around the date schematic). It shows the color starting on the Hokkaido and Tohoku peaks, pouring down the mountain flanks into the valleys, and reaching the Kanto plain and the coasts last; Kyoto's basin stays green while the hills around it turn. A moving example of 'the moving landscape' (ch.7) as well as ch.5.

### Cherry front animation (2026-11-26, later)

Kim: 'We really need to do this for the cherry blossoms, too. The animation is really, really interesting.'

Built (Claude, NOT ruled): `japan_cherry_front.mp4` / `.gif`, Mar 1 to Jun 4, same script (`jma_anim_frames(..., event = "cherry")`); stages bare branches, buds, first flowers (JMA's date), full bloom, petal fall, new leaves (schematic around the date). The pair is a mirror: the cherry front climbs north and uphill, warm coasts and cities first (Tokyo with Fukuoka), mountains last; the maple front comes south and downhill, mountains first, warm coasts last. Same terrain, same warmth, opposite directions. Pairs well as one spread in ch.5 (or the moving landscape, ch.7).

### Kim on why the Japan fronts matter (2026-11-26)

Kim (verbatim): 'Absolutely amazing. I think the importance, besides better understanding these events, is that we're working in that middle area. The nightly (news) forecast looks narrowly at what's happening now (back to the role of prediction). This set of two seasonal phenomena integrates events over many weeks, just the sort of thing that fits in the middle area. We've got a powerful addition with this work.'

### Why? Interpretive notes for the text on the Japan fronts (2026-11-26)

Kim: 'We need to make sure your observations of collateral information, like the impact of ocean temperatures, is kept for the text. The graphic causes us to ask "why?" You've provided some of the answer.'

Claude's observations (NOT ruled). [data] = checked in the JMA records this session; [verify] = the explanation is standard but needs a source before it goes in the text.

1. Warm coasts. The Pacific coastal plains (Tokyo-Kanto, the Kii and Shikoku coasts) are among the first to bloom and the last to color. Tokyo's cherry normal (Mar 23) matches Fukuoka's (Mar 22), 900 km southwest; Tokyo's maple (Nov 28) is a month later than Sapporo's (Oct 28). [data] Likely causes: the warm Kuroshio current along the Pacific side, and the urban heat island of the large cities. [verify]
2. Elevation. Each 100 m delays cherry flowering ~1.2 days and brings maple color ~3.2 days earlier (regression on 1991-2020 station normals; stations reach only 612 m). [data] Air cools with height (~0.6 C per 100 m), so spring warmth arrives later and autumn chill earlier up the slope. [verify] This is why the maple front runs downhill and the cherry front uphill: the same terrain, opposite directions.
3. The southern end blooms late. Southernmost Kyushu and the warm islands are later than latitude predicts: Kagoshima Mar 27, Tanegashima Mar 28, Yakushima Mar 25, Hachijo-jima Mar 31, against Fukuoka Mar 22. [data] Explanation: Somei-yoshino needs winter chilling to break bud dormancy; where winters are too mild, chilling is incomplete and flowering is delayed (warm winters can push it later still). [verify; JMA has discussed this] A strong 'why' example: warmer is not always earlier.
4. Two different triggers. Cherry flowering is mainly spring warmth adding up after dormancy (accumulation, ch.4); maple coloring follows autumn cooling (cool nights, shortening days). [verify] So warming moves the two fronts by different amounts: maple +2.7 days/decade later, cherry 1.1 days/decade earlier. [data] The autumn front is the more sensitive indicator.
5. The maples turn later at 72 of 77 stations (1996-2025 vs 1961-1990; median +9.5 days). [data] A national, not regional, signal.
6. Kyoto. The basin is late for maple (normal Dec 6, later than Tokyo's Nov 28) while the surrounding hills turn weeks earlier; in the animation the hills ring the green city. [data] Basin heat and the city likely hold the floor warm. [verify] Fits Kim's Nanzen-in story (temple on the eastern hills).
7. Sea of Japan side. Cherry blooms later on the Sea of Japan side than on the Pacific side at the same latitude (visible in the cherry map). [data, by eye] Likely the heavy winter snow and colder spring on that side. [verify]
8. Hokkaido. North and east Hokkaido observe other cherry species (Ezo-yamazakura, Chishima-zakura), so the front there joins two different trees. [JMA documentation; verify wording]

Correction: in the first draft of `japan_two_fronts.png` the label 'Fukuoka' sat on station 47827, which is Kagoshima. Fixed 2026-11-26; both cities are now labeled.

### Sources for the 'why' notes on the Japan fronts (2026-11-27)

Kim (11-27): do point 3 first, finding the sources. Status per note; numbers refer to the 11-26 'Why?' list.

0. Trends (our +2.7 maple, -1.1 cherry per decade). CONFIRMED. JMA Climate Change Monitoring Report 2023, sec. 2.7: since 1953 cherry flowering earlier by 1.2 days/decade, maple coloring later by 3.0 days/decade, both significant at 99%; JMA attributes this partly to long-term warming (high correlation with mean temperature before each event). https://ds.data.jma.go.jp/cpdinfo/monitor/2023/pdf/ccmr2023_sec2-7.pdf . Newer JMA pages (Climate Change in Japan 2025): 1.3 and 3.0. https://www.data.jma.go.jp/nara/kansoku/seibutsu.html
1. Warm coasts, city heat. SUPPORTED. Urban heat: Met Office attribution study (Christidis et al., Environmental Research Letters 2022): climate change plus urban warming moved Kyoto's full flowering 11 days earlier. https://www.metoffice.gov.uk/about-us/news-and-media/media-centre/weather-and-climate-news/2022/kyoto-cherry-blossom-dates-shifted-by-human-influence . JMA forecaster (Bloomberg/Time 2024): Tokyo's record early date is 'global warming, compounded with urbanization'; Tokyo has warmed 3 C in a century; Tokyo's normal moved from Mar 29 (1961-90) to Mar 24 (1991-2020). https://time.com/6957844/cherry-blossoms-climate-change-peak-bloom-shift . City-scale: Matsumoto and Fukuoka 2003, Geographical Review of Japan 76(1):1-18 (flowering dates follow urban temperature within Kumagaya). Kuroshio: a warm current along the Pacific coast, turning east near 35N (Britannica); influences Kanto's regional climate (Tohoku Univ./Univ. of Hawai'i, Journal of Climate). https://www.britannica.com/place/Kuroshio ; https://www.tohoku.ac.jp/en/press/kuroshio_current_climate_discomfort_tokyo.html . Still to find: a source tying the Kuroshio directly to the phenology dates.
2. Elevation. Our numbers are [data]. The cooling with height is the standard atmosphere lapse rate (6.5 C per km); textbook, no special source needed.
3. The southern end blooms late. STRONGLY SUPPORTED. Katsuki, Kanetani, Kedoin, Fujiwara, Iketani, Miller-Rushing and Primack (2026), 'Impact of warmer winters on the flowering display of Tokyo cherry at its southern range,' International Journal of Biometeorology, doi:10.1007/s00484-026-03185-6: low winter chill delayed flowering in Kagoshima against Kumamoto (1965-2024); below a threshold, buds dropped and flowering was uneven; in 2024 open flowers fell up to 34% in Kagoshima and NONE opened on Yakushima; native southern cherries flowered normally. Miyawaki-Kuwakado, Satake et al. (2024), Plants, People, Planet: Somei-yoshino needs about 61 days below 10.1 C to break dormancy (DAM4 gene model). https://www.eurekalert.org/news-releases/1057976 . JIRCAS, Hachijo-jima 1948-2024: in low-chill years flowering was significantly delayed. https://www.jircas.go.jp/en/program/proc/blog/20250401
4. Two triggers. SUPPORTED. Cherry: two dormancy phases, cold to break endodormancy, then spring heat (Kyushu Univ. 2024, above); weathernews: buds grow from February and open when accumulated daily maximum temperatures reach a set value -- a degree-day mechanism, direct support for ch.4. https://weathernews.jp/news/202404/220185/ . Maple: rule of thumb that Iroha-momiji begins coloring when the daily minimum falls below 8 C and colors quickly below 5 C -- explicitly an index, not a measured threshold (weathernews interview). https://weathernews.jp/news/202410/310205/ . Day length starts senescence in many deciduous trees; temperature modulates (general; source still wanted). Aichi Prefecture: coloring is later when September-November is warm.
5. National signal (72 of 77). [data]; consistent with JMA's trend (note 0).
6. Kyoto. PARTLY REVISED. The basin gives hot summers and cold winters, with cold air draining down the slopes (kyoto.travel) -- this argues AGAINST 'basin heat' as the cause of the late city maples. Revised reading: the hills color early because they are higher and cooler; the city floor is late most likely from urban heat (Kyoto is a large city; Met Office study above shows urban warming there). Still [verify] for the maple case specifically.
7. Sea of Japan side later. WITHDRAWN. Tested 11-27: residuals from lat + lon + elevation show no significant difference between 13 Sea of Japan and 15 Pacific stations (cherry p = 0.31; maple p = 0.12). Published normals agree: Niigata and Sendai both Apr 8. My by-eye reading was wrong.
8. Hokkaido species. CONFIRMED. Somei-yoshino is replaced by Ezo-yamazakura in parts of Hokkaido and by Hikanzakura in the Nansei islands (JMA practice, Kobe City disaster office page). https://www.city.kobe.lg.jp/z/kikikanrishitsu/topikkusu25.html . JMA 2007 forecast table: Ezo-yamazakura at Wakkanai, Rumoi, Asahikawa, Abashiri, Obihiro, Kushiro; Chishima-zakura at Nemuro; Somei-yoshino at Sapporo and Muroran. https://www.jma.go.jp/jma/press/0704/25a/sakura2007_8.pdf
Bonus for the text: JMA defines flowering as the first day 5-6 or more flowers are open on the sample tree, full bloom as about 80% open (Kobe page above). JMA cut its phenology program in 2021 to 6 species and 9 events (Doi et al. 2021, Nature Ecology & Evolution 5:886-887, 'Declining phenology observations by the JMA') -- a friction/external-memory point for ch.5 and ch.9: a 70-year record narrowed.

### The three remaining sources (2026-11-27)

Kim: 'We'll need the three remaining when we write, so it is best to find the sources now.'

A. Kuroshio and the dates. NO DIRECT SOURCE FOUND (English and Japanese searches). What IS sourced: the Kuroshio keeps the Pacific coast warm -- 'east of Japan's Kanto and south, the Kuroshio offshore gives a warm climate; coastal frost is rare (Boso, Suruga Bay, Sagami Bay grow citrus and rapeseed)' (Japanese Wikipedia, 太平洋側気候, https://ja.wikipedia.org/wiki/太平洋側気候); 'an important warming effect upon the south and southeast' coasts (Britannica). Supporting the chain warm coast -> weak chilling -> late bloom: Kagoshima 2020 bloomed Apr 1, later than Sendai, though March was 1.5 C warmer than normal; earlier late years (1957, 1963) had cold Marches (weathernews 2020-04-01, https://weathernews.jp/s/topics/202004/010105/). Fukuoka blooms before warmer Kagoshima because it gets moderate winter chill plus urban heat (Ito Hisanori, Kyushu Univ. emeritus, RKB 2024-03-26, https://rkb.jp/contents/202403/202403260812/). Local counterpoint: across the Okayama Plain, flowering was earliest in the commercial center, then inland, LATEST at the seaward edge (Int. J. Biometeorology, doi:10.1007/s00484-011-0496-4) -- the sea cools spring locally. WRITING RULE: say 'the warm Pacific coast (warmed by the Kuroshio)'; do not claim the current itself sets the dates.
B. Kyoto maple, city vs hills. SUPPORTED. JMA Kyoto Local Meteorological Observatory (2010): maple and ginkgo begin to color when autumn temperature falls below a certain value, so warmer temperatures delay coloring; Kyoto maple normal Dec 1 (1974-2009), trending 2.5 days/decade later. https://www.jma-net.go.jp/kyoto/2_data/publications/doc_others/kyoto-Kaika_Mankai_Henka.pdf . Heat island in the record: since 1953, cherry flowering advanced 2.8 days in small and mid-size cities but 6.1 days in large cities, 7.5 days in Kyoto (Masuda Keiko, Ryukoku Univ., Kyoto Climate Change Prevention Center 2009 report, https://www.kcfca.or.jp/wp-content/uploads/2018/12/sakura_kaede_houkoku2009.pdf ). The famous temples (Tofukuji, Eikando) peak in late November, earlier than the city sample tree (forecast coverage, 2026). [The hills-first pattern in our map matches: the temples sit on the cooler edges, the sample tree in the warm center.]
C. Day length and autumn color. SUPPORTED. Gill et al. 2015, Annals of Botany 116(6):875-888 (meta-analysis, 64 studies): senescence delayed over time; high-latitude sites (50-70N) more sensitive to photoperiod, low-latitude sites (25-49N, i.e., Japan) more sensitive to temperature. https://pubmed.ncbi.nlm.nih.gov/25968905/ . Temperature and photoperiod are the primary climate variables regulating autumn phenology of deciduous trees; for some species temperature dominates (Sci. Reports 2020, doi:10.1038/s41598-020-65704-8). Growth-chamber test: low temperature alone induced senescence in oak under long days; short days alone did not (Quercus mongolica; PubMed 35708584). Implication for the text: in Japan's latitudes, temperature is the main lever -- which is why the maple front tracks the warmth so closely.

### Ch.2 operations: the record, and the move that shows in the data (2026-11-27)

Kim ruled: use Honolulu dry spells for the five implementations. Kim warned: 'The danger is the change in HNL in the early 1960s as the terminal moved to a new location. The data may show this change.'

Station history (NWS Honolulu, https://www.weather.gov/hfo/history): Aug 14, 1940 station established at the airport; Jan 27, 1946 Weather Bureau Airport Station; Oct 11, 1962 all operations moved to the Administration Building; Jan 10, 1974 observing operations moved to the Observatory Annex; Nov 1, 1996 a private contractor took over observing. Hawai'i data book: 'site conditions produced distorted temperature measurements from 1965 to 1971.'

Test (Claude, 11-27): GHCN-D daily PRCP for HNL (USW00022521, 1940-05-14 to 2026-11-22) against four neighbors with years in both periods (Ewa Plantation, Manoa, Kalihi, Palolo); ratio of annual wet days (>= 1 mm) HNL/neighbor by site period. RESULT: KIM WAS RIGHT -- the data show the move. In the Administration Building years (1963-73) HNL logged about 10-11% more wet days relative to Ewa and Manoa than at the first site; after the move to the Annex, about 25% fewer relative to Kalihi and Palolo. From 1974 on the ratio is steady (Palolo 0.211 in 1974-95, 0.209 in 1996-2025). Rain totals shifted less than wet-day counts -- the site change touched the small rains, exactly what decides dry spells.

Also found: trace recording changed -- about 5 traces a year logged in the 1940s, about 150 a year from the 1950s. A dry day must therefore be defined by a threshold (1 mm), not by zero.

Decision (Claude, NOT ruled): build the spell statistics on 1974-01-10 to present (one site, 52 years); show the full record with the site periods marked as a figure or sidebar. Story value: a station move is a change of OPERATION (Bridgman again) -- the same name, HNL, covers three instruments-in-place; fits ch.2 (definitions become operations) and ch.9 (friction: the metadata you need is a web page and an old data-book footnote).

### Ch.2 operations: the five implementations, run (2026-11-27)

Built (Claude, NOT ruled), `S3/figures/dry_spells/`: `dry_spells.R` (ds_strict, ds_gap, ds_hyst, ds_window, ds_hmm; shared output method/start/end/days; ds_all, ds_daymask), `dry_spells_figures.R`, `hnl_station_moves.R`; figures `hnl_dry_spell_disagreement.png` (past 12 months: rain, five rows, agreement band), `hnl_dry_spell_operations.png` (days per year by operation; year-by-year), `hnl_station_moves.png` (sidebar); data `hnl_spells_1974_2026.rds`.

Settings: dry day < 1 mm; minimum 15 days; gap tolerance 2 wet days; hysteresis exits only on a day >= 5 mm; window = centered 31-day total < 10 mm; state model = 2-state HMM on wet/dry (fitted: dry regime P(wet) 0.043, wet regime 0.688; dry regime persists 0.94/day). Record: HNL 1974-01-10 to 2026-11-22 (one site).

RESULTS. 'How many days a year is Honolulu in a dry spell?' -- window 125, strict run 192, hysteresis 247, state model 302, gap tolerance 347 (2.4 to 7.2 spells a year; mean length 27 to 138 days). All five agree on 29% of days; they split on 66%; 5% are in no spell by any. Year to year they mostly agree on WHICH years are dry (median r = 0.68) but not on HOW dry; gap tolerance is the outlier (r 0.27-0.41) because in a place with ~50 wet days a year, forgiving two wet days merges almost the whole year -- a Hawai'i-test finding: a tolerance that suits a wet climate erases the dry season's structure here. Past 12 months: all five agree only in June-July 2026; gap tolerance swallows the Jan-Mar 2026 wet season.

Reading (Claude, NOT ruled): the methods sort into Kim's vocabulary -- strict run, gap tolerance, hysteresis ask 'is this a SPELL?' (threshold + duration); window and state model ask 'is this a STRETCH?' (a regime); a SNAP would be a rate operation (change against recent days), not built here. Bridgman made visible: where the agreement band is dark the word is safe; where pale, 'dry spell' is several concepts.

### For chapter 2: across the street (Kim, verbatim, 2026-11-27)

> I live in a place that has some of the world's steepest rainfall gradients. Looking out the window, I often see rain falling in the distance while where I'm at, it is dry. This makes for nice rainbows but it's also a reminder that my location near the shoreline has near desert-like conditions while the heads of the nearby valleys are lush and green. An early weather lesson I learned soon after moving to Hawai`i was that if it was raining and you didn't have an umbrella, you just needed to cross the street and it would be dry. And that was true, most often, as I walked around the university campus. Rainfall is different here; some comes with trade wind showers and the rest with winter storm that pass as cold fronts. The topography creates rain shadows on one side of the mountains. Together, you have a mix of spatial and temporal heterogeneity. Do the terms I was used to hearing in continental areas apply to where I'm living now?

Claude's response (NOT ruled): the story is the hinge between the folk-taxonomy opening and the operations -- it asks whether the vocabulary travels. Partial answer: the words assume weather that is the same across your neighborhood for days (synoptic, continental). Winter cold fronts and Kona storms behave that way -- spells apply. Trade showers are snaps in SPACE, at the scale of a street. The shoreline dry season is a stretch. So the terms apply on the time axis but need a place qualifier: 'a dry spell where?' Hawaiian answers with place: rains are named for places (cf. MRC ch. on learning the scale; Hanau ka Ua, Hawaiian rain names [verify]). English encodes rain in time; Hawaiian encodes it in place. Proposed figure: the same five operations on HNL vs Manoa (a few km apart) -- does 'dry spell' survive crossing the valley? [verify: 'world's steepest rainfall gradients' -- Rainfall Atlas of Hawai'i, Giambelluca et al. 2013].

### Kim's gradient stories (verbatim, 2026-11-27)

> BTW: my personal reference for the steep gradient is on Kaua`i where I often took field classes. Stretch a line from Waialeale toward Barking Sands; one extreme to another with both ends visible from the road that heads up to the Kalalau Lookout. Another is on the Big Island. I'd have a bunch of students in a van in Hilo where it was raining quite hard. The students were prepared for a wet day walking around in Hawaii Volcanoes National Park. "Never fear" I'd tell them. Predictably, the rain would stop just before we entered the park. That's where the road which headed upslope leveled into a flat plain before going down the other side. Topography gave the students a dry day for their field studies. It also made me look like a wise predictor of the weather.

Claude (NOT ruled): both belong with 'across the street' in ch.2 (or the Hawai'i test spread through chapters). The Hilo story is also a prediction story -- the middle-scale knowledge of place beat the forecast (ch.1 / ch.8). [verify: Waialeale and Kekaha/Barking Sands annual rainfall from the Rainfall Atlas of Hawai'i; the trade-wind inversion as the reason the rain stops near the park's elevation.]

### Across the street, in data: airport vs Manoa (2026-11-27)

Built (Claude, NOT ruled): `S3/figures/dry_spells/hnl_vs_manoa_dry_spells.png` + `hnl_vs_manoa.R` (ds_fig_two, any two stations) + `hnl_manoa_spells_1983_2022.rds`. Same five operations and settings at Honolulu airport (USW00022521, 2 m) and Manoa (USC00516122, 73 m), 12.9 km apart, 1983-2022 (both records nearly complete).

RESULTS: rain 422 vs 1,602 mm/yr; wet days 46 vs 189 a year. Dry-spell days per year, airport vs Manoa: strict run 196 vs 9; gap tolerance 348 vs 129; hysteresis 252 vs 18; window 127 vs 1; state model 305 vs 63. On half the days the airport is dry, Manoa is wet (P = 0.49); when the airport is in a strict-run spell, Manoa is in one on only 4% of those days. All five operations agree on 30% of airport days and on NO Manoa day.

Reading (Claude, NOT ruled) -- the answer to Kim's question: the continental words fit the weather that is SHARED. In the Nov 2021-Oct 2022 strip the big winter storms rain on both gauges, and the mid-winter dry period (Jan-Feb 2022) shows at both -- large-scale, continental-type weather, where 'spell' travels. The trade showers are what differ: they keep Manoa wet while the shore stays dry, at the scale of crossing the street. So 'dry spell' works for synoptic weather and fails for trade-wind weather; in Hawai'i the word needs a place attached. Also: a 15-day minimum suits the airport and almost never triggers in Manoa -- the receiver sets the scale (criterion 1).

### For chapter 6: the El Nino year we prepared (Kim, verbatim, 2026-11-27)

> I wonder if this is a story for Chapter 6. This year is a Super El Nino. For the Pacific where I live, this means an increase in cyclonic activity. In practice, we did more than pay lip service to disaster preparations. Not only did we analyze what we'd actually need for food and water to survive for several weeks, but we bought the supplies. That's a big step for someone living in an apartment. Storage is a real cost, so we scrambled to find places to put our emergency goods. We also spent time monitoring what storms were developing even though they were far away. Checking hurricane tracks against historical patterns was a frequent activity. The hurricane season has just ended. Just yesterday we put away the last of our large containers for storing water. We're beginning to eat our emergency food so we can reclaim storage space. This is the first year we've done all of this.

Facts checked (Claude, 11-27): NOAA/NESDIS wrap-up (Nov 24, 2026): El Nino drove record Pacific activity; this El Nino is among the strongest on record; Hurricanes Lala, Lowell and Nolo brought direct impacts to Hawai'i (damaging winds, destructive waves, catastrophic flooding) https://www.nesdis.noaa.gov/news/2026-hurricane-season-wrap . Combined central and eastern Pacific: most active season on record, ACE 359.5; two major disaster declarations in Hawai'i (phys.org). Lala: first direct hit on Hawai'i Island since 1871; Hawai'i's third-wettest tropical cyclone (Wikipedia, 2026 Pacific hurricane season). NOAA's May outlook gave a 70% chance of an above-normal Central Pacific season (KHON2, 2026-05-31). The season officially ends Nov 30. 'Super El Nino' is not a NOAA term; since Feb 2026 NOAA measures El Nino by the Relative Oceanic Nino Index (RONI); 2026 to October: ONI +2.46 (near the top, vs 2015/16 +2.59), RONI +1.97 (below the big events) (wikifarmer summary of CPC files).

Claude (NOT ruled): fits ch.6 -- the seasonal outlook moved the envelope before the season began, and Kim acted on a STATE (El Nino as a stretch: the load role), not on any one storm (a snap/trigger). Also: ch.8 forward direction (acting on a seasonal outlook; preparation has costs -- storage is friction in an apartment); ch.3 event time (a household year from buying in June to putting away the water containers and eating the food in November); ch.10 rare events and memory ('the first year we've done all of this'; Kim's favorite Hawai'i hurricane-track map was in use all season). Bridgman bonus for ch.2: how strong is this El Nino? Near-record on the ONI, below the big events on the RONI -- the answer depends on the operation. Figure idea: Central Pacific tracks near Hawai'i in El Nino vs other years (IBTrACS), with 2026's tracks against that envelope.

### Hurricane tracks near Hawai'i by ENSO phase (2026-11-27)

Kim: 'Absolutely. We need the hurricane tracks for the two periods.' Built (Claude, NOT ruled): `S3/figures/hurricanes/hawaii_hurricanes_enso.png` + `hawaii_hurricanes.R` (hh_get, hh_fig) + `hawaii_tracks_enso.rds`. IBTrACS v04r01 EP (1971-2025) + last3years (2026, provisional); El Nino season = ONI Aug-Oct >= 0.5 C (14 seasons; 41 others); 'near' = within 500 km of the main islands (Nolo's closest approach was 300.2 km, so 300 km would have missed it).

RESULTS: El Nino seasons 1.8 storms within 500 km per season (0.50 at hurricane strength); other seasons 1.4 (0.34); difference not significant (p = 0.65) -- seasons vary widely (other: 0 to 6; El Nino: 0 to 7, max 2015). 2026: 5 storms within 500 km, 3 at hurricane strength (Lala, Lowell, Nolo) -- ties the most hurricane-strength approaches in a season (3, in 2018). El Nino storms that reached the islands formed farther SOUTH (median 11.6 vs 13.2 N, p = 0.005), not farther west (p = 0.64); approached from the south more often (32% vs 18%) but not significantly (p = 0.25). Iniki (1992) came in a NON-El Nino season (ASO ONI -0.15); Iwa (1982) in an El Nino season.

Reading (Claude, NOT ruled): El Nino is a load, not a trigger -- it raises the odds but a quiet El Nino season and a deadly neutral season both happen (Iniki). That is exactly why Kim's household acted on the state, not the storm: the outlook changes the bet, not the outcome. Ch.6 (this year against the envelope: panel C against A and B), ch.10 (rare events; Iniki and Kim's story with Mike Huddleston), ch.8 (forward decisions under a loaded die). The CPC switch from ONI to RONI (Feb 2026) would reclassify 1977, 1994 and 2018 -- the envelope itself depends on the operation (Bridgman).

### Kim: preparation and the folk terms for the odds (verbatim, 2026-11-27)

> Preparation is an evaluation of the odds. When you hear words like "average," "intense," and "historic" for the weather, you're getting the folk terms for the odds.

Claude (NOT ruled): a second folk vocabulary beside snaps, spells and stretches -- those are folk words for DURATION; 'average', 'unusual', 'intense', 'record', 'historic', 'once in a generation' are folk words for PROBABILITY. Each maps to a position on the envelope (ch.6): average = the middle band; unusual = outside the 10-90% band; record = beyond the observed range; historic = beyond living memory (ch.10, return periods outrun memory). Like the duration words, they are operations without stated operations -- 'historic' since when, measured how (Bridgman). Possible device: a translation table (folk word -> statistical meaning -> where it sits on the envelope), or the envelope figure annotated with the words.

### The envelope labeled with the folk words (2026-11-27)

Kim: 'I'm most curious about labeling the envelope figure.' Built (Claude, NOT ruled): `S3/figures/envelope_folk/hnl_envelope_folk_wy2026.png` + `envelope_folk.R` (ef_prep, ef_fig; any daily rain record) + `hnl_wateryears.rds`. HNL, water years Oct-Sep, 1975-2025 (51 years, one observing site) vs 2025-26.

Folk ladder used (bands of the cumulative envelope, end of year): record dry (below all 51 years) / unusually dry (1 year in 10) / drier than usual (1 in 7) / about average (half of all years) / wetter than usual (1 in 7) / unusually wet (1 in 10) / record wet (beyond all 51 years). Single day: heavy = a typical year's wettest day (73 mm); intense = a 1-in-10-year day (137 mm); record = wettest day in 51 years (201 mm, 2022).

RESULTS: 2025-26 = 727 mm, 5th wettest of 52 -> 'unusually wet'. The year tracked 'about average' until mid-March; one storm sequence (Mar 11-20; Mar 13 = 140 mm, an 'intense' day) moved it to 'wetter than usual' and later 'unusually wet'. The three hurricanes (Lala Aug 16, Lowell Sep 8, Nolo Sep 26, closest approach) added little at the airport -- their rain fell elsewhere. 2026-27 so far (dotted): slightly above median.

Reading (Claude, NOT ruled): a SNAP can relabel a whole year -- the folk word for 2025-26 was decided in ten days of March. And the year's hurricane story and its rain story are different stories at this gauge (place again). The labels make the envelope readable without statistics: each band is a word people already use, with its odds beside it.

### Kim on the labeled envelope, and the tree at Volcano (verbatim, 2026-11-27)

> Wow!!! This is the diagram that I've been after!!! This diagram was the one that I've been thinking about for so long but it has just been in my head, not actually visualized. But what you've created is so much better than my simplified mental view. This adds the probabilities and presents the labels. I'm blown away! This adds a lot to the story. I've uploaded a photo from that peak rainfall event that's very personal. Nancy and I were staying near Volcano Village. The rain came. The wind blew. A huge tree fell in the front yard of the place we were staying, almost crushing our rental car (which was, fortunately, protected by the carport). We lost power for several days.

Photo: `S3/photos/Tree_down_in_Volcano.jpg` (Kim's; no date in the file metadata). Shows a large trunk fallen across the front of a cottage in 'ohi'a and hapu'u tree-fern forest, the car under the carport at right.

Claude (NOT ruled): KIM'S RULING-LEVEL STATEMENT -- the labeled envelope is the diagram he has long had in mind; it becomes a central figure of S3 (ch.6). The photo pairs with panel B's 'intense' day: the statistics say 1-in-10-year day; the photo says what that means on the ground. Also place again: 140 mm at the Honolulu airport, but the damage Kim saw was at Volcano, on another island. Kim confirmed (11-27): the photo is from March 14, 2026 -- the day after the 140 mm 'intense' day at the Honolulu airport (Mar 13), within the Mar 11-20 storm sequence.

### For chapter 10: 'a 100-year event' -- twice in a week (Kim, verbatim, 2026-11-27)

> Here's a question. How should we interpret "it was a 100 year event"? I recall hearing that, in one case in particular, around 1969, for a rainfall event when I was in Irvine, CA. That, in itself, wasn't surprising. It was, indeed, a lot of rain. But I heard the same thing one week later. A 1 in 100 twice in a week? Most curious.

Facts (Claude, 11-27): Southern California, Jan 18-Feb 25, 1969 -- record or near-record floods (USGS Circular 601-B; Waananen 1969, USGS open-file). Rain almost continuous Jan 18-25, flooding Jan 25-26; Orange County declared a disaster area Feb 5; a second system Feb 21-25 (Santa Ana EOP); USGS: three storms in Jan-Feb. NWS: nineteen stations reported totals exceeding the once-in-a-thousand-year storm; half the average annual rain fell Feb 11-20 at 182 stations. USGS: the '100-year flood' = 1-percent annual exceedance probability (AEP), adopted in the 1960s for the National Flood Insurance Program; 26% chance over a 30-year mortgage; each year begins with the same 1% chance; USGS now prefers 'AEP' to 'recurrence interval' to reduce confusion.

Claude's answer (NOT ruled): 'a 100-year event' is the official folk term for 1% a year -- a probability, not a schedule. Twice in a week (or a month) is possible because: (1) storms in one season are not independent -- a wet regime (a stretch) brings storm after storm, and saturated ground makes the second flood bigger from less rain; the 1% assumes independent YEARS, not storms within one winter; (2) each claim is a different operation -- which gauge, which duration (1 day, 3 days, the season), rain or river flow; a 100-year 24-hour rain and a 100-year 7-day total are different events (Bridgman); (3) many gauges -- with hundreds of stations, some station passes its own 1% line in any big storm (1969: 19 stations beyond the 1,000-year storm); (4) the estimate itself moves -- built from short records, it is revised after each big flood. Ch.10 figure (already a gap): chance of at least one 1-in-N event over a span (1 year, 30-year mortgage, a lifetime) vs return period; plus the 1969 Orange County case.

### Ch.10 figure: what 'a 100-year event' means (2026-11-27)

Kim: 'The "100-year event" is a really nice folk term (and concept).' Also: remembering a couple of wet weekends from 1969 is bound to be fuzzy (a month became a week) -- itself a ch.10 point: rare events outrun memory, hence external memory.

Built (Claude, NOT ruled): `S3/figures/return_periods/return_periods.png` + `return_periods.R` (rp_p, rp_fig). A: chance of at least one T-year event over a span (T = 10, 50, 100, 500, 1000): 100-year = 1% in one year, 26% over a 30-year mortgage, 55% in an 80-year lifetime; 50-year = 80% in a lifetime; 1000-year = 8% in a lifetime. B: chance that at least one of M independent gauges passes its own line in a year: 100-year line 17% with 19 gauges, 84% with 182; 1000-year line 2% and 17%. Independence predicts about 1 gauge in 1,000 beyond its 1,000-year line in a year; Jan-Feb 1969 Southern California reported 19 -- big storms reach many gauges at once (gauges, like storms within a season, are not independent).

This closes the ch.10 gap 'chance over a mortgage vs return period'. Opening: Kim's Irvine 1969 story. Pairs with the envelope's 'record' band (beyond all 51 years ~ 1-in-50 a year).

### Verify list, worked (2026-11-27)

1. Kaua'i gradient (Kim's line Waialeale -> Barking Sands). CONFIRMED. Earth@Home (Paleontological Research Institution): Wai'ale'ale 1,143 cm (450 in) a year; Polihale Beach (just north of Barking Sands) 46 cm (18 in); 26 km (16 mi) apart -- about 24 in per mile. https://earthathome.org/hoe/hi/climate/ . WRCC Hawai'i climate narrative: in many places the gradient exceeds 25 in per mile; extreme 118 in per mile along the 2.5-mile line from Hanalei Tunnel to Mt. Wai'ale'ale. https://wrcc-archive.dri.edu/Climate/narrative_hi.php . Rainfall Atlas (2013 online; Giambelluca et al., BAMS doi:10.1175/BAMS-D-11-00228.1): 'one of the most diverse rainfall patterns on earth'; base period 1978-2007; uncertainty maps provided. 1986 Atlas (DLNR R76): Kaua'i from about 500 mm to over 11,000 mm.
2. The Hilo-to-park story: the trade-wind INVERSION IS NOT THE REASON. The inversion sits at about 2,200 m (Rainfall Atlas) and limits trade-wind rain to below about 2,000 m (USGS HVO, Volcano Watch); the park entrance is near 1,200 m. Station data (GHCN-D, Claude 11-27) along the Hilo-Volcano road: Hilo airport (9 m) 3,159 mm/yr; Mountain View (466 m) 4,825; Glenwood #2 (671 m) 5,480 (5,620 in 2000-12); Hawai'i Volcanoes NP HQ (1,210 m) 2,616 (2,497 in 2000-12). Rain peaks on the mid-slope (~600-900 m) and falls by half at the summit plateau -- consistent with 'on most islands the maximum rainfall occurs at 610-910 m' (Earth@Home) and 'on high mountains the maximum rainfall zones are at the mid-slopes' (Rainfall Atlas). Reading: the rain is wrung out on the climb; where the road levels onto the summit plateau the lifting eases, and beyond lies the Ka'u Desert in the lee. Kim's 'flat plain' observation is the right cue (slope makes the rain), not the inversion. Wet days (>= 1 mm): Glenwood 293/yr, NP HQ 224/yr. Caveat: Volcano still gets ~2,500 mm -- a drier day there is relative, and storms (Mar 14, 2026) override it.
3. Hawaiian rain names. CONFIRMED. Collette Leimomi Akana with Kiele Gonzalez, Hanau ka Ua: Hawaiian Rain Names (Kamehameha Publishing, 2015; Samuel M. Kamakau Award, Hawai'i Book of the Year 2017): more than 200 rain names, the fullest record to date, drawn from about 300 Hawaiian-language primary sources (19th-20th c.); names listed with the places they belong to; Hilo has the most rain names, on O'ahu Nu'uanu leads; authors introduce themselves by their home rains and winds (Akana: from Halawa, of the Moae wind and the Wa'ahila rain; Gonzalez: from Kane'ohe, of the 'Apuakea rain and 'Aoa winds -- HPR). Companion: Hanau ka Makani (600+ wind names). Supports the ch.2 point: Hawaiian names rain by PLACE. Sources: ksbe.edu; Hawai'i Public Radio 2016; Hawaii Magazine.

### The Mauna Loa Road: a persistent wet/dry boundary (Kim, verbatim, 2026-11-27)

> The HVNP rain pattern story has an additional twist. The "strip road" (now called the Mauna Loa Road) is the way you drive up to that 7200 ft inversion layer elevation (the road stops at about 7000 ft, just below the tree line). I've been up and down that road many times. Almost never in the rain. Looking toward Hilo from the road, there are almost always clouds. I've long thought the route for the road might be on an ancient Hawaiian trail that was placed where it would be dry, but near enough to where it rained a lot so that provisioning or hunting (e.g., bird catchers) had access. To me, this wet/dry boundary is a relatively persistent feature. Our IRP research project was located along this road. That's where I had my rain and temperature instruments.

Claude (NOT ruled): a boundary in SPACE that persists in TIME -- the trilogy's theme in one road (value, space, time). Ties: ch.2 (place-named rain; across the street, at the scale of a mountain), ch.7 (the moving landscape vs a fixed edge), ch.9 (Kim's IRP rain and temperature instruments along this road -- the friction story told in the same place), MWT (space). Kim's trail hypothesis is his conjecture [verify: is the Mauna Loa Road on or near a traditional route? Known traditional route up Mauna Loa from the south is the 'Ainapo Trail from Kapapala; bird catchers (kia manu) worked the upland forests]. Possible figure: a rainfall profile from Hilo up Highway 11 and then up the Mauna Loa Road, from the Rainfall Atlas grid, with the cloud deck's usual edge and the IRP sites marked. Also: are the IRP climate data published (IBP Island Ecosystems technical reports / Mueller-Dombois et al. 1981)? If so, Kim's own transect data could be plotted.

### Kim's IRP climate records: TR38 transcribed (2026-11-27)

Kim: 'Here is my copy of the IRP climate records. It is a bit marked up. I have a few other similar documents, so most of the original data are available. The Island Ecosystems book has Chapter 9 with lots of analyses I did with the same data. Unfortunately, I don't have a scanned version of the book.'

Source: Bridges and Carey 1974, IBP Island Ecosystems IRP Technical Report 38, 'Climate data for the IBP sites on Mauna Loa, Hawaii' (May 1974; 1973 data; continues TR22 Supplement 1). Contents: climate diagrams, monthly temperature/humidity/saturation deficit, daily temperature and humidity tables (pdf pp. 29-76), cumulative and weekly rain, weekly rain record tables (pp. 91-98), rainfall events, intensities.

Transcribed (Claude): `S3/figures/irp_1973/` -- am_std_1973.csv (weekly standard-gauge rain, 4 sites x 52 weeks), overall_mean_1973.csv (K54, M54), README with checks. Totals (standard gauge): K54 2,176 mm; M54 1,696; M66 1,657; M42 1,391. Checks against the report's own cumulative figures pass (M42, M66 exact; K54 overall mean 1,588 vs ~1,590).

FINDINGS (Claude, NOT ruled): (1) Gauge OVERFLOW in the Nov 19 and 26, 1973 weeks: every Tru-Check reads 152.4 mm (6 in) and every metric gauge 231.0 mm -- capacity; only the standard gauge caught the storm (e.g., M54 694.7 mm in one week). The report's 'overall mean' and its cumulative curves for K54 and M54 therefore understate 1973: K54 1,588 vs 2,176 (standard gauge); M54 925 vs 1,696. An instrument limit decided the measured year -- Bridgman and friction (ch.2, ch.9), told with Kim's own data. (2) One storm made the year: the two November weeks are 47-58% of each site's 1973 total (K54 47%, M42 51%, M66 55%, M54 58%) -- the snap that relabels a year, again (cf. Honolulu March 2026). (3) Replication: 16 gauges at K54 and M54 give within-site spread each week (e.g., K54 week of Mar 5: 74.9 to 173.4 mm) -- across the street, inside one site.

To ask Kim: the site identities and elevations (M42, M54, M66 = Mauna Loa Road at 4,200/5,400/6,600 ft? K54 = ?). Other reports (TR22 Suppl. 1; later years) would extend the series. Chapter 9 of Island Ecosystems (Mueller-Dombois, Bridges & Carson eds., 1981) [verify editors] not scanned.

### IRP rain 1973 to June 1975: three reports transcribed, first figure (2026-11-27)

Kim: 'K54 is the Kilauea Rain Forest site, well away from the main transect. I've uploaded two additional IRP reports for the weather data.' (TR59, 1974 data, April 1975; TR70, Jan-Jun 1975, August 1975.)

Built (Claude, NOT ruled): `S3/figures/irp_1973/irp_weekly_rain_1973_1975.csv` (515 records: site, date, standard gauge, Tru-Check and metric means, 16-gauge mean, source) + README (checks, flags) + `irp_rain_fig.R` + `irp_rain_1973_1975.png`. Checks: all 156 16-gauge rows of 1974-75 satisfy the weighted-mean identity (3 misreads caught and fixed); totals match the reports' cumulative figures for 1973 and 1974.

RESULTS: standard-gauge totals Jan 1973-Jun 1975: K54 5,030 mm, M54 4,763, M42 4,277, M66 4,089. Storms carry the record: Nov 1973 (two weeks), Dec 1974, Jan 1975 (week of Jan 6: M42 439, M54 610, M66 631 mm). Overflow again in Dec 1974 and Jan 1975. Between storms the gauges disagree systematically and in OPPOSITE directions: at M54 the standard gauge caught 27% more than the 16-gauge mean (higher in 91% of non-storm weeks); at K54 9% less (lower in 74%). So neither the standard gauge nor the mean is 'the truth' -- exposure and gauge type are part of the operation. Correction to my earlier note: the standard gauge is the right series for comparing sites (same instrument everywhere, no overflow), not because it is unbiased.

Reading: Kim's own data carry the S3 argument -- the year is made by a few storms (snaps), the total depends on the instrument (Bridgman), and 16 gauges at one site disagree week by week (across the street, inside a site). Chapter 9 friction story: paper charts and keypunching then; 2026: scanned pages, OCR, a self-checking identity, an afternoon.

Still to ask Kim: site elevations (M42/M54/M66 = 4,200/5,400/6,600 ft? and K54's elevation); TR22 Supplement 1 (1971-72) would extend the series backward.

### IRP rain 1971 to June 1975: complete series, years overlaid (2026-11-27)

Kim: 'K54 is at 5,400 feet. I've put in what I believe are the TR22 supplement pages.' (TR22 Supplement 1 = 1971-72 data; TR22SB not yet examined -- looks like daily temperature/humidity tables.)

Built (Claude, NOT ruled): `S3/figures/irp_1973/irp_weekly_rain_1971_1975.csv` (847 records, four reports) + updated README + `irp_years_fig.R` + `irp_rain_1971_1975.png`. Checks: all 364 multi-gauge rows pass the weighted-mean identity (9 misreads caught and fixed in all); annual totals match the reports' own figures for 1972, 1973 and 1974. TR22 S1 annual-rain figure gives the elevations: M42 ~4,200, M54 ~5,250, M66 ~6,700 ft; K54 5,400 ft (Kim). Instrument history: K54/M54 had 2 Tru-Check + 1 standard + 4 metric until Mar 1971, then 11 + 1 + 4; M66 a single Tru-Check until June 1972, then the standard gauge; M42 and M66 began Oct 25, 1971. Printed-date error: M66 '720717' appears twice (corrected, flagged).

RESULTS (calendar years by collection date, standard gauge): K54 1971 2,205 / 1972 1,660 / 1973 2,312 / 1974 1,837; M54 2,210 / 1,476 / 1,720 / 1,718; M42 1972 1,459 / 1973 1,423 / 1974 1,868; M66 1972 1,151 / 1973 1,692 / 1974 1,405. KEY PATTERN: 1973 was the DRIEST year through October at every site, then the November 1973 storm made it the WETTEST year at K54 and M66 and near-wettest at M54 -- the snap that relabels a year, in Kim's own 1970s data (pairs with Honolulu March 2026). The first half of 1975 (Jan 1975 storm) was the wettest start of any year at the three Mauna Loa Road sites. Note: 1973 totals here differ slightly from the TR38-only figures because the week collected Dec 31, 1973 now counts in 1973 and K54's faulty Mar 12, 1973 week uses the gauge mean -- the year boundary is itself a choice (ch.3).

### Kim: the calendar year splits the wet season (verbatim, 2026-11-27)

> Interesting. I find that these charts (with the cumulative rainfall) show the rainfall seasonality. Steep early in the year, mid-year plateau, steep at the end of the year. Re-arranged, The early and late parts of the year would fit together nicely as a steep slope, followed by the drier plateau. When shown starting at January, it almost forces you to see two wet periods (early and late) spanning a relatively dry middle). At least that's my quick view.

Claude (NOT ruled): this is ch.3's event year shown in Kim's own data -- the January start is a template imposed on the season; starting the year at the edge of the dry trough keeps the wet season whole (one steep slope, then the plateau). Same move as the Honolulu envelope (water year Oct-Sep). Pair: the January-start chart and the event-year chart side by side, same data -- the frame changes what you see (Bridgman for time).

### Calendar year vs event year, same IRP rain (2026-11-27)

Built (Claude, NOT ruled): `S3/figures/irp_1973/irp_rain_calendar_vs_eventyear.png` + `irp_eventyear_fig.R`. Event year starts July 1: the driest eight weeks across sites and years run early June to late July (6-9 mm a week vs 69 in January, 95 in November) -- the boundary in the trough (ch.3 ruling).

RESULT AND CORRECTION: in event years, 1972-73 (Jul 1972-Jun 1973) was the DRIEST season at every site (K54 1,416; M42 902; M54 924; M66 818 mm) and 1973-74 (with the Nov 1973 storm) the wettest or near-wettest (K54 2,742; M42 2,046; M54 2,205; M66 1,948). Calendar 1973 -- which I had called 'the driest year through October, then relabeled wettest by one storm' -- was really the second half of the driest season stitched to the first half of the wettest. The calendar frame manufactured a 'wettest year' out of two different seasons. Strong ch.3 example in Kim's own data; also a caution for ch.6 (the envelope's year must be an event year -- as the Honolulu figure already uses Oct-Sep).

### Kim: event years as a theme; Island Ecosystems copy ordered (2026-11-27)

> Even more interesting. Yes, we need to emphasize "event years". This is adding strength to our arguments.

RULING (Kim): emphasize EVENT YEARS in S3 (ch.3 and wherever a year is used -- envelopes, totals, rankings).

> Side Note: I have not scanned Island Ecosystems as it is my only copy (I had two, one was "borrowed" many years ago). I didn't want to tear apart my only copy. You stimulated me to look for a used copy. And I found one! I've ordered it and that copy will get scanned.

Note: when the used copy of Island Ecosystems arrives, scan it; Chapter 9 (Kim's analyses of the IRP climate data) becomes available for S3.

### For chapter 4, accumulation: Butler, Darwin's worms, the trees (Kim, verbatim, 2026-11-27)

> I wonder if the Arizona insect story could have been from George Butler. My memory of the person is very fuzzy. There was a lot going on with many research investigators. What's pretty solid is the story: messy data from traps suddenly made clear by using the degree-days. My favorite "accumulation" story might be the Darwin's worms story. I've mentioned the overview before: "a little number times a big number is always a big number." For me, the implication is that if you make frequent measurements, the change always looks small. A longer sampling interval and you're more likely to notice the change. The numbers are the same (i.e., the long term change is the same) but your perception is different. I think we talked about this with the "frog in the pot" (which you point out is wrong, but commonly believed). I think of this with conservation programs. Planting a couple of trees a year is unnoticed. Doing this for fifty years produced dramatic results. The sampling interval (maybe better as each decade in the case of the example trees) creates the pattern. Does this help?

Verified (Claude, 11-27): GEORGE D. BUTLER JR. fits -- USDA Agricultural Research Service, Phoenix; Butler and Henneberry 1976, 'Temperature-dependent development rate tables for insects associated with cotton in the Southwest' (USDA ARS Western Region); degree-day models for bollworm (Butler 1976), tobacco budworm (Butler and Hamilton), sweetpotato whitefly (Butler and Henneberry 1985, USDA Tech. Bull. 1707). A USDA ARS report on pink bollworm moth emergence in central Arizona (ARS-6, 1984) concluded that 'accumulated heat units may provide a more consistent indication than calendar date of time of emergence' -- the trap story's lesson in print [authorship of ARS-6 to check]. Werner link stays unconfirmed; Butler is the stronger candidate. DARWIN (The Formation of Vegetable Mould through the Action of Worms, 1881, ch. III): broken chalk spread on a field Dec 20, 1842; examined end of Nov 1871 (29 years): 'a line of white nodules could be traced on both sides of the trench, at a depth of 7 inches from the surface'; mould thrown up 'at an average rate of 0.22 inch per year' (2.2 in per ten years); castings about 15 tons per acre per year (estimates 7.56 to 18.12). Origin: Darwin's 1837 Geological Society paper; the idea suggested by Josiah Wedgwood of Maer Hall.

Claude (NOT ruled): Kim's sentence is the chapter's spine -- 'a little number times a big number is always a big number.' Darwin's numbers make it concrete: 0.22 inch a year is about 0.0006 inch a day (invisible); 2.2 inches a decade (noticeable); 7 inches in 29 years (a buried layer). The SAMPLING INTERVAL sets the perception, not the change (ties: frog parable as a just-noticeable-difference problem; MRC boundaries in value). Three-part structure: (1) Butler and the traps -- change the axis (calendar to degree-days) and order appears; (2) Darwin's worms -- change the interval and the change appears; (3) conservation, two trees a year for fifty years -- the decade is the interval that shows the forest. Figure idea: one long record viewed at four intervals (day, month, year, decade) -- the Mauna Loa CO2 record (same mountain as the IRP transect): day-to-day changes look like noise around zero; year-to-year always up; decade-to-decade unmistakable.

### Ch.4 figure: the Mauna Loa CO2 record at four intervals (2026-11-27)

Kim: 'The Mauna Loa CO2 record is likely the most famous and consequential plot ever made. It is a nice tie-in as it sits right above our IRP transect. Yes, please build it.'

Built (Claude, NOT ruled): `S3/figures/accumulation/co2_intervals.png` + `co2_intervals.R` (co2_read, co2_changes, co2_fig) + the three NOAA GML files (daily 1974-2026-11-26, monthly 1958-, annual 1959-2025). A: the Keeling curve. B: changes between consecutive days, months, years, and years ten apart.

RESULTS: day to next day (14,099 pairs): 49% up, 50% DOWN, 1% unchanged; median change 0.00 ppm -- the rise (0.005 ppm a day) is buried in scatter of about 0.56 ppm. Month to next month (823): 63% up, 37% down (the seasonal cycle). Year to next year (66): 100% up, median +1.71 ppm. Decade to next decade (57): 100% up, median +15.6 ppm. Same record, same rise: the interval decides whether you see it. A reader sampling daily would see CO2 fall slightly more often than it rises. Darwin parallel in the caption (0.22 in/yr = 0.0006 in/day; 2.2 in/decade; 7 in in 29 years).

Note (friction, ch.9): NOAA's server refused the first connection from Kim's machine (transient) and is not on the cloud workspace's allowlist; the retry worked.

### For the fire figure: return interval set by accumulation (Kim, verbatim, 2026-11-27)

> The Keeling curve is, indeed, the correct one. Your table as a graphic is an excellent addition. This gets another "wow!". The basis of a fire figure, I believe, is the concept of the "return rate." For a forest fire, the fuel is lost in the fire. It can take years for there to be enough accumulation for a similar file to occur. It's the biological process that extend the return, sometimes beyond a human's memory. Does that make sense?

Sources checked (Claude, 11-27): standard term 'fire return interval' (mean time between fires at a place; return rate is its inverse). LANDFIRE fire regime groups: I and II <= 35-year return interval (low/mixed vs replacement severity); III and IV 35-200 years; V > 200 years (USGS LANDFIRE data dictionary). Hawai'i (USFS Fire Effects Information System, Hawai'i fire regimes): fire records of the past century show a more than 5-fold increase in average area burned and number of fires per year statewide; nonnative fire-adapted grasses and human ignitions are the main contributors; a grass/fire cycle documented in 'ohi'a woodlands (Hughes, Vitousek and Tunison 1991, Ecology 72; Tunison, D'Antonio and Loh 2001, Hawai'i Volcanoes NP). Invasive-dominated grasslands now cover about 25% of the state (USFS RMRS). UH (Trauernicht et al. 2015): the share of Hawai'i burned each year 2005-2011 was comparable to, sometimes above, the western US.

Claude (NOT ruled): Kim's point puts all three S3 terms in one process -- fuel accumulating since the last fire is the STRETCH (state, ch.4 accumulation); a dry spell is the LOAD; the ignition (lightning, a spark) is the SNAP, which only becomes a fire when the middle allows it. The fire resets the accumulation, so the return interval is set by biology (regrowth), not by the weather or the ignition. Long intervals (35-200, 200+ years) outrun a lifetime and written memory (ch.10). Hawai'i twist: nonnative grasses re-accumulate fuel in a year or two, collapsing the return interval from 'beyond memory' to 'every few years' (grass/fire cycle; 5-fold increase). Figure idea: (A) a fuel-accumulation model -- slow forest vs fast grass, random ignitions, fires only above a fuel threshold in a dry spell, each fire resetting the sum; (B) return intervals on a log timeline against human spans (a year, a generation, a lifetime, written records).

### 2026-11-27 -- Fire figure built (figures/fire/fire_return.png)
- Kim: 'I was thinking that a diagram of the process would be the way to show this.' Built as two panels.
- Panel A (model, not data): the same random dry spells (load) and ignitions (snap) fall on native forest (regrowth 0.08/yr) and invasive grass (2.5/yr); fuel accumulates logistically (stretch); a fire = ignition + dry spell + fuel above threshold; the fire resets fuel. Result (300 model years, seed 1973): forest 6 fires, mean return ~54 y; grass 43 fires, mean return ~7 y.
- Panel B: LANDFIRE Fire Regime Groups (<=35, 35-200, >200 y) on a log axis against a year, a generation, a lifetime, written records in Hawai'i (~200 y); Hawai'i native MFRI 12-525 y (LANDFIRE via FEIS); grass/fire cycle arrow (Hughes, Vitousek & Tunison 1991; D'Antonio & Vitousek 1992).
- Claude suggestion, RULED by Kim 2026-11-27 (accepted): the figure shows two kinds of limit. Forest is fuel-limited (dry spells come and go; nothing burns until fuel returns). Grass is weather-limited (fuel is always ready; it burns at the next dry spell -- note the ~20 model years with no dry spell where grass sits full and waits). Ecologists use this fuel-limited vs climate-limited framing (e.g., Krawchuk & Moritz 2011, Ecology) -- verify citation before use. The S3 point: in the forest the biology sets the interval; in grass the weather does, so invasion converts a stretch-controlled system into a snap-controlled one.
- Claude suggestion, RULED by Kim 2026-11-27 (accepted): the forest interval (~54 y) is under a lifetime but over a generation -- each fire is remembered by elders, not by the people who must prepare. Fits the '100-year event' and folk-odds material.
- Kim (verbatim): 'I like the two ideas that are filed in the Ideas File. They make sense. No problem with the dotted lines; the labels are clear. These last two examples (CO2 and fires) are good as they are not specifically "weather." We needed the diversity.'
- Figure accepted as is (dotted lines crossing Panel B labels OK).
### 2026-11-27 -- Rulings: TR22 temperatures dropped; five dry-spell methods accepted
- Kim (verbatim): 'Let's not do the TR22 temperature tables. We are OK with what we got from the IRP study. I particularly like the five dry-spell methods for spells and stretches. Giving definitions a practical computations basis is part of my core belief. You've created a perfect example. I'm really happy with it. That leaves drought and the forward direction. Can you give me a hint as to where this topic should head?'
- RULED: TR22SB temperature tables -- not needed (closed).
- RULED: the spell/stretch mapping of the five dry-spell implementations (ch.2) -- accepted as the worked example of operational definitions.
- Remaining S3 gap: drought and the forward direction.
### 2026-11-27 -- Drought and the forward direction: the live figure (figures/drought_live/hnl_live_wy2027.png)
- Kim (verbatim): 'I think your right with a live figure. I favor HNL, only because I think it might be better in showing the point. I like that forward statement vs judging it backward at the end. After that, let's pick up the "hydro-illogical cycle" theme. First, however, the live figure.'
- Built: A, running departure from the typical (median) year, Oct 1-Apr 30, El Nino vs other wet seasons (1974-75 to 2025-26), strong El Nino seasons drawn, 2026-27 to date; B, wet-season rain (% of median) vs Dec-Feb ONI; C, the loop -- FORWARD call (frozen) and BACKWARD judgment (filled automatically when rerun after Apr 30, 2027).
- Results (data): HNL wet-season median 307 mm. El Nino wet seasons: 13 of 18 below median (median ~70% of normal); strong (ONI >= 1.5): 4 of 5 below; other seasons: 13 of 34 below. ONI ASO 2026 = +2.46 (very strong).
- The call (frozen 2026-11-27 in forward_call_wy2027.rds): below the median; a dry wet season favored, about 3 chances in 4. Standing on Nov 22: 57 mm, right at the typical year.
- Finding: the El Nino median tracks the typical year until New Year, then falls behind (Jan-Apr). November standing says little. The one strong-year exception, 1982-83 (108%), owes much to a single storm on Oct 27, 1982 (75 mm, a quarter of a median season) -- a snap that beat the load. (Hurricane Iwa, Nov 23, 1982, was NOT a big rain day at HNL -- checked.)
- Claude suggestion, NOT ruled: the book performs the loop instead of describing it -- the call is printed now, the judgment in May. Either outcome teaches: right shows the load at work; wrong shows that odds are not outcomes (the 1982-83 lesson).
- To do: rerun live_update() periodically through the winter; final run after Apr 30, 2027. Verify before writing: El Nino -> dry Hawai'i winters literature (e.g., Chu & Chen 2005, J. Climate).
- Next: the 'hydro-illogical cycle' theme (Kim).
### 2026-11-27 -- Kim on the live figure; dashboard idea (later)
- Kim (verbatim): 'I had to look at the diagrams carefully. It was worth the effort. This is not only very informative, but it's a really (!) clever way of presenting the data (i.e., asking for the code to be re-run periodically). It is that "re-run" feature that reinforces almost everything we've been doing. Looking at the middle-area data helps us understand the current situation. Here, that's being done with both the graphic and the code. You get another Bravo! Whew. BTW: this diagram (with the code behind it) would be great on a dashboard (perhaps a project for later). Now, let's look at the hydro-illogical cycle.'
- Call wording accepted as frozen (Kim made no change).
- PARKED (later project): a dashboard version of hnl_live (auto-refresh of live_update()).
### 2026-11-27 -- Hydro-illogical cycle: sources and a first test at HNL
- Source: Don Wilhite (founding director, National Drought Mitigation Center, U. Nebraska-Lincoln); cartoon in use by the 1980s-90s (Drought Network News 11(1), Feb 1999); Wilhite 2014, 'Changing the paradigm for drought management: Can we break the Hydro-illogical Cycle?' Water Resources Impact. Phases: drought -> awareness -> concern -> panic -> rain -> apathy -> drought. Wilhite: droughts are the 'Rodney Dangerfield of natural hazards' (AGU 2011).
- Useful line (S. K. Collins, Society of Ethnobiology blog 'The Hydro-Illogic Cycle'): a long-term climatic pattern (drought) is conflated with a short-term weather pattern (precipitation). In S3 terms: people judge a stretch by a snap.
- Claude test (data, HNL 1975-2026): drought episode = 12-month rain below 70% of median (403 mm) for 90+ days. 'Apathy gap' (operational) = days from the first 1-inch (25.4 mm) day after the drought's low point to the day the 12-month total is back to median. Results: 1977 low 31% -> gap 537 d; 1983-84 99 d; 1998-2002 (low 22%, Nov 1998) first inch Oct 1999, back to median May 2002 -> 936 d; 2003 32 d; 2007-08 433 d; 2010 8 d; 2012-13 280 d; 2025 32 d. (Overlapping episodes 1998/2000 and 2007/2008 to be merged.)
- Claude suggestion, NOT ruled: figure = (A) HNL 12-month rain as % of median with drought episodes, each marked: low point, first inch (concern ends), back to median (deficit ends), the gap as a bar; (B) the cycle redrawn in S3 terms (concern rises with the stretch; apathy returns with the snap); (C) the gaps as a duration ladder. Optional: O'ahu groundwater (USGS wells) lags further still.
### 2026-11-27 -- Hydro-illogical figure built (figures/hydro_illogical/hydro_illogical.png)
- Kim (verbatim): 'We need to build this. I suggest waiting on the groundwater as it is pretty complex. The style you outline appears to be correct, but we'll know better when we see the chart.'
- RULED: groundwater extension deferred (complex).
- Built: A, HNL 12-month rain as % of median 1975-2026, 8 drought episodes (merged), each with low point, first inch, back to median, apathy-gap bar; B, close-up 1998-2002 (stretch above, daily snaps below; gap 936 d = 2.6 y; 4 one-inch days in the gap, including Dec 2001 near 80 mm, and the deficit stayed); C, Wilhite's cycle redrawn in S3 terms (the stretch builds concern; the snap -- one wet day -- ends it; the deficit does not); D, apathy gaps as a ladder against a week, a season, a year, two years.
- Gaps (merged episodes): 1998-02 936 d; 1977-78 537; 2007-09 433; 2012-13 280; 1983-84 99; 2003-04 32; 2025-26 32; 2010 8. Deep droughts tend to have the longest gaps (1983-84 is an exception: low 29%, gap 99 d).
- Link to the live figure: if 2026-27 turns dry, the first heavy rain afterward will end the worry before it ends the deficit -- the forward call and the apathy gap belong in the same chapter.
### 2026-11-27 -- Kim on the hydro-illogical figure; toward writing
- Kim (verbatim): 'Another excellent visualization. HNL did work for this. The interpretive comments (the "hydro-illogical" part) bring culture into the process very nicely. Giving a culture thinking tools has been one of our goals. Are we getting close to starting the writing?'
- Claude assessment, NOT ruled: every chapter has figures and most have Kim's stories; gaps left are small (vintage figure, verify lists, graphics process). Suggest a pilot chapter to set voice and workflow before the rest -- ch.2 (sets the vocabulary every later chapter uses) or ch.4 (stories and figures complete).
### 2026-11-27 -- Tree rings: measuring, not counting
- Kim (verbatim): 'Given the hour, it's best to work on the "Still open" topics. Writing can begin tomorrow. Let's chat about the tree-ring ideas first. This works in temperate areas, but not the tropics (including Hawai`i). That a worthwhile point. Some useful measures are geographically limited (we saw that in the Seasonalityr document, too). Do you think it useful to have a schematic diagram that shows the spacing of annual tree rings so that it shows how weather influences the widths? I don't have the data, but there is likely something available. I suggest this only because many people think of counting the rings, not doing measurements.'
- RULED: writing begins tomorrow (2026-11-28); tonight, the still-open topics.
### 2026-11-27 -- Tree-ring figure built (figures/tree_rings/tree_rings.png)
- Kim (verbatim): 'I installed dplR, so it is ready to use. Yes, let's build the chart. And, I'll add that you've surprised me (again) by finding an interesting source of data and some R code to use it.'
- Data: Schulman Old Tree No. 1, Mesa Verde, CO (Douglas-fir, 35 cores, 1176-1963; ITRDB co021, shipped with dplR; Schulman 1963). Rain: GHCN-D USC00055531 Mesa Verde NP (from 1922); overlap 1923-1963.
- Panels: A, two cores 1900-1963 drawn to measured widths, five narrowest stand years (1902, 1904, 1934, 1951, 1959) linked -- same pattern at different distances (crossdating); B, one core (642143, 760 years) raw widths + growth curve, then the stand index 1240-1963 with Douglass's Great Drought 1276-1299; C, index vs Oct-Jun rain; D, the tropics limit (Kim's point; Hawai'i).
- Findings (data): index vs rain r = 0.27 calendar year, 0.66 water year Oct-Sep, 0.76 Sep-Jul, 0.78 Oct-Jun (n 28-30; months with <25 days excluded) -- the event-year lesson in a tree (ch.3). Core 642143 has 22 locally absent rings (zero width): a ring count comes up 22 years short; crossdating finds them -- the strongest case for measuring over counting.
- Verify before writing: Douglass's Great Drought dates (1276-1299) and his Mesa Verde work (HH-39, 1929); the tropical-rings caveat (some dry-season tropical trees form annual rings).
### 2026-11-27 -- Vintage: Kim's 1972 blind glass; a price chart for three Bordeaux
- Kim (verbatim): 'The tree-ring chart worked out very well. It does, indeed, show some of the "lessons." Ah, just thinking of the vintages takes me back to some interesting past times. People might scoff at the thought of wine having such a unique character that it would be worth a great deal of money. One of my experiences was being served a wine by a friend in 1972. He poured the glass in the kitchen and brought it out without my knowing what it was. At that point, to me it was just "wine." Until I took a sip. I remember the wine's property so well that I would likely recognize it if I were to be given another glass. But that's not likely, as the 1970s price of a bottle was in the hundreds of dollars. My friend had a particularly fine sense of taste, likely at the level of Master Sommelier. He was testing me, of course. I'm not sure if I passed his test. But I certainly enjoyed the wine. Now to a chart. There are "points" printed on lots of labels. I don't really trust those, especially here. I'm thinking of wines (as you might guess) at the high end. Up where people who know are willing to pay for the right bottle. Would there be a correlation between the prices of bottles from a few of the Bordeaux vineyards (Petrus, Chateau Mouton Rothschild, and Chateau Yquem) over a period of years? Would this highlight outstanding vintages?'
### 2026-11-27 -- Petrus vintage figure built (figures/vintage/petrus_vintage.png)
- Kim (verbatim): 'Maybe the request for multiple estates is too complex. I like the Petrus example as they have already identified, by their standard (Bridgeman again), what they call a "on" vintage. How about a chart showing these with some weather to go along as a possible explanation.'
- RULED: one estate (Petrus), not three.
- Data: Liv-ex Petrus brand sheet (April 2025), Market Price EUR/bottle, 2008-2023 (transcribed: petrus_livex_2025.csv); Liv-ex named on-vintages 2005, 2009, 2010, 2015, 2016 (Petrus profile). Weather: GHCN-D FR000007510 Bordeaux-Merignac 1951-2026; Ashenfelter variables (Apr-Sep mean temp, Aug-Sep harvest rain, Oct-Mar winter rain).
- Findings: prices split into two bands with a gap (no vintage EUR 3,050-3,598); on = 2009, 2010, 2015, 2016, 2018, 2020, 2022, 2023. Growing season: on mean 19.5 C vs off 18.6; 7 of 8 on vintages warmer than the 1991-2020 median vs 4 of 8 off. Harvest rain: on 86 mm vs off 110 mm. Exceptions: 2020 on despite a wet harvest (157 mm); 2011 off despite a warm season. Caveats on the chart: 16 vintages, one estate, one station, warming window, youth premium on 2022-23.
- Kim's 1972 blind-glass story pairs with the figure: remove the label and the judgment rests on the wine; the market's on/off split is the same idea at scale.
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
