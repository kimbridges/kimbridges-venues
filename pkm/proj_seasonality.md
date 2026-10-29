# PROJECT: seasonality

_Last updated: 2026-06-29_
_Status: Complete_
_Focus readiness: Not applicable (PUBLISHED to kimbridges-documents 2026-06-29: https://kimbridges-documents.netlify.app/seasonalityr/)_
_Log: logs/proj_seasonality_log.md_

## Type
R + Quarto (analysis / methodology). Builds on coenosr, lists, and whittakerr.

## Objective
Define a **climate-viewed seasonality** from monthly temperature and rainfall alone,
abstract it into a few **indices**, classify sites into a small set of **seasonality
types**, and **map** their distribution. The arc is the whittakerr move applied to
climate: take an accepted construct (the climate diagram), abstract it, and carry it
all the way to a map — "there are X types of seasonality, and here is where they fall."
**(See "The spine" below for *why* it matters: seasonality as the cue structure for biological
synchronization.)**

## The spine — seasonality as the cue structure for synchronization

**Why this project matters (Kim, 2026-06-18).** A place's seasonality is not merely a climate descriptor;
it is the set of **cues organisms use to synchronize their life cycles** — flowering, migration, breeding.
Timing is under strong selection: an individual out of phase with its population is left out — no mate, no
flock, no pollinator — a steep genetic cost. So organisms key their cycles to environmental signals, and
the signals differ in **dependability**:
- **Daylength (photoperiod)** — astronomically perfect and *identical for every individual at a given
  latitude* (the universal metronome a population can converge on), but weak near the equator, strong
  toward the poles.
- **Temperature** (threshold crossings) — strong, somewhat noisy year to year.
- **Rainfall / soil moisture** (threshold crossings) — the least dependable; often so unreliable it can
  only be a **trigger** (react when it comes), not a **predictor** (set a clock by it).

So a cue's worth ≈ **amplitude × reliability**, and cues come in two kinds: *anticipatory* (daylength,
temperature — forecast the season) and *reactive* (rain in arid lands — respond once it arrives; hence the
opportunistic, calendar-free phenology of deserts).

**This is what our channels and transects have been measuring.** The temperature and rainfall "channels"
are cue types; **channel substitution is cue substitution** (where one fades, life falls back on another).
The aseasonal everwet equatorial core the transects kept finding (Singapore, Kuala Lumpur, Davao) is a
**cue-poor zone** — flat temperature, unseasonal rain, *and* minimal daylength variation — which predicts
exactly the weak, staggered, continuous phenology tropical ecologists observe there. Index trough and
biology are the same fact.

**What the spine adds to the method (next):** an explicit **daylength** channel (free — pure latitude) and
a **reliability / dependability** axis (interannual repeatability) — the latter needing year-by-year data,
since WorldClim gives only the climatological mean and so cannot yet tell a dependable monsoon from a
fickle one. The type scheme should then be read as **cue regimes** — temperature-cued, rainfall-cued,
daylength-cued, cue-poor — not climate boxes.

**The climate-change lever.** Warming shifts temperature and rainfall while **daylength is fixed forever**,
so the cues **decouple**: an organism keyed to photoperiod arrives on the old schedule into a season that
has moved (phenological mismatch). A map of which cues a place offers, and how reliable each is, is a map
of **where mismatch is likely** — where life is keyed to the one signal that cannot move while the others
slide out from under it. The traveler's and naturalist's payoff is the same legibility: a place's cue
profile says what to watch for, and when.

**The origin (Kim's story, kept verbatim — the formative anecdote).**
> Many years ago, long before we were generally aware of climate change — and we certainly weren't talking
> about it — I got a phone call. Out of the blue. From someone I didn't know, whose name I don't remember.
> The call was from Alaska; I'm in Hawai'i. "The whales came back two days early." That was the message.
> "Why are you telling me this?" I answered, truly confused. "Because you need to know that," was the
> reply. That was the end of the conversation. That exchange, to a large extent, changed my outlook.

A living calendar moved by two days, passed stranger to stranger as news that simply had to travel. That
is the document's mission in miniature: to make the timing of the living world legible enough that a
person feels its shifts — and "needs to know."

## Concept (conversation of 2026-06-18 — to be revisited)

### The base: the Walter-Lieth climate diagram
Each month is classed by precipitation against twice the temperature, on the classic
1°C : 2mm scaling: **arid/drought** (P < 2T), **humid** (P > 2T), and the **perhumid**
band of "excess" rainfall (the compressed-scale region above ~100 mm). A site is a
**cyclic sequence of twelve monthly states**, and its seasonality is the annual pattern
those states trace. The **cold/frost** state is deliberately **skipped for now**
(rain + temperature only) — Kim's instinct that near the tropics rainfall is the better
seasonal marker; it may rejoin for temperate/northern sites.

### Why this is not a two-way table
**Phase and sequence carry the seasonality.** Mojave and Chihuahuan have nearly the same
category *composition* (humid + drought) but in opposite *phase*; a presence/absence
table (site × state) would call them identical. The information that defines seasonality
is *when* the states occur and *in what order*, not *which* occur. This is the lists
lesson — "the distance is a choice" — taken to the case where the obvious distance
(Jaccard on states) discards exactly the signal of interest.

### The central design move: quantify the diagram as a moisture curve
Take the diagram's core monthly fact, the gap **m = P − 2T**, as a single number per
month → a continuous **twelve-month cyclic moisture curve**: positive where humid,
negative where in drought, with the perhumid cap at the top. The diagram stays the base
(the states read straight back off the curve), but it becomes a signal we can abstract.

### The abstraction: harmonics of the curve (agreed starting point)
A twelve-month cyclic curve has a compact, classical abstraction — its harmonics:
- **1st-harmonic phase** = *when* the moist season peaks (Mojave winter vs Chihuahuan summer).
- **2nd-harmonic strength** = whether there are *two* peaks (Sonoran's bimodal rains).
- **mean** of the curve = overall wet/dry.
- **amplitude** = how seasonal at all (vs a flat, aseasonal climate).
~Four numbers, each of which **maps as a surface**. This is the candidate minimal index set.

### Key insight to revisit
All three reference deserts are **mostly drought** categorically (few or no genuinely
humid months); counting states alone would call them alike. What separates them is the
**phase/timing** of the wet season, which lives in the continuous curve, not the category
tally. → abstract the curve, don't just count states. (This is also the desert-specific
restatement of "not a two-way table.")

### The through-line
Seasonality types are reproducible **constructs, not proofs** (coenosr/lists). Their
number and boundaries can be set by a **stated rule** — the lists **assessment-line**
machinery, now applied in *index space* rather than on presence/absence. The geographic
payoff (mapping the types and the indices) is the **whittakerr** extension.

### What the first prototyping round established (2026-06-18, illustrative data)
Three quick Python-sandbox builds (representative hand-entered normals, **not** WorldClim) tested the
concept and reshaped it:
1. **The moisture curve's *phase* is temperature-locked.** For hot deserts, `m = P − 2T` peaks in
   winter regardless of when the rain falls (the 2T term dominates), so m-phase does **not** detect the
   wet season. The three deserts separate instead by **rainfall harmonics** — the 1st-harmonic phase
   (winter vs summer) plus the A2/A1 **bimodality** ratio (Sonoran). → Refinement: the seasonality
   *type* is carried by **decomposed temperature-seasonality and rainfall-seasonality** indices, not the
   combined m; keep **m as the aridity / water-balance overlay** (the desert-severity story).
2. **The warm world fans out; the cold world collapses.** In a (temperature-seasonality ×
   rainfall-seasonality) space, temperate/continental sites cluster at low rainfall-seasonality — one
   rainfall family, differing mainly in temperature amplitude — while tropical/subtropical sites spread
   across many rainfall regimes. This confirms Kim's hypothesis that types proliferate toward the
   equator / mid-latitudes.
3. **Counting the types** (Ward clustering of four indices — temperature amplitude, rainfall SI,
   warm-half rain fraction, gated bimodality — cut at k = 6 over ~18 archetypal sites): six interpretable
   types emerged — everwet equatorial; monsoon/savanna; **bimodal double-rain** (Nairobi + Tucson,
   united purely on rainfall signature despite opposite temperature regimes); cool-season rain;
   cold-continental summer-rain; and a **temperate catch-all** (the collapse made visible). Richness:
   the warm half (Tamp < 8 °C) spanned **5** types across 10 sites; the cold half (Tamp ≥ 8) only **3**
   across 8 — the hypothesis, quantified (illustratively).
Fixes applied along the way: **gate** timing/modality below a rainfall-SI floor (≈ 0.40) — an aseasonal
site has no reliable "season" (otherwise the bimodality ratio blew up on near-uniform Atlanta); and make
timing **hemisphere-proof** by measuring the fraction of rain falling in the **warm half-year** rather
than a calendar phase.

### The channel refinement (2026-06-18, prototyping round 2)
A second round (adding a **cool-season-rain** timing feature and a continental "both" probe, Beijing)
turned the two-axis picture into a near-typology that carries Kim's channel intuition directly.

**Seasonality is experienced through a *channel*** (Kim's insight): in a place with low *rainfall*
seasonality you feel the year through *temperature*; where *temperature* seasonality is low you feel it
through *rainfall*; and it is rare to get both. The data **refine** the "rare to get both": the high–high
corner is **not** empty (Beijing, Ulaanbaatar, Fairbanks sit there), but those are **continental
summer-rain** sites where rain falls *in phase* with the warmth — one reinforced warm-wet season, not two
independent ones. The genuinely empty corner is **two *independent* (anti-phase) seasonalities** (cold
winters + winter rain + hot dry summers). Sharpened law: **two independent seasonal cycles are rare; when
both amplitudes are high it is usually because rain and warmth coincide and fuse into a single pulse.**

**Emerging typology — magnitude + channel + phase:**
- **Neither / aseasonal** — everwet equatorial (Singapore, Manaus), near the origin.
- **Rainfall channel only** — tropical wet–dry (Mumbai, Niamey, Darwin, Nairobi): flat T, sharp rains.
- **Temperature channel only** — temperate maritime/continental (London, Moscow, Chicago, Bergen, Atlanta).
- **Both, in-phase / reinforced** — continental summer-rain (Beijing, Ulaanbaatar, Fairbanks).
- **Both, anti-phase / independent** — the rare-to-empty corner; the **Mediterranean** (LA, Rome) is its
  nearest real approach (moderate T swing, cool-season rain).

**Two new gates established:**
- **Rain phase is meaningful only where the temperature channel is sun-driven.** The cool-season-rain
  feature (fraction of rain in the 6 coldest months) cleanly splits Mediterranean (LA 0.93, Rome 0.62)
  from continental (Beijing 0.09) in the extratropics — but **inverts in the deep tropics**, where the
  coolest months are the *cloudy wet season*, not winter (Niamey scored 0.61 "cool-season" though it is a
  summer monsoon). → gate the phase feature on temperature seasonality, or use a solar/calendar reference
  in the tropics.
- **Aridity gates the rainfall channel.** SI is a *relative* measure, so a hyper-arid site fakes
  seasonality on almost no rain (Cairo: SI 1.01 on 25 mm/yr). Total rainfall — or the moisture overlay m —
  must gate whether rainfall seasonality is real. (This is where **m finally earns its keep**.)

### Real-data validation and the first transects (2026-06-18, round 3)
The **WorldClim harness** is built (`seasonality_harness.R`): `geodata` WorldClim 2.1 (10′, cached) →
point-extract by lat/lon → the indices in R. **Validation passed** — real data reproduce the desert trio
(Las Vegas/Mojave winter, cool_frac 0.58; El Paso/Chihuahuan summer, 0.26; Tucson/Sonoran **bimodal**,
bimod 1.17) and the whole channel picture; the hand-typed normals were not misleading. Two transects:
- **West coast (Vancouver → Acapulco, + Mazatlán):** rainfall seasonality climbs N→S (0.44 → 1.04); the
  rain phase stays **winter** (Mediterranean; cool_frac peaks 0.93 at LA) the length of the US/Baja coast,
  then **flips hard to summer** (monsoon) — Mazatlán is already 0.11, so the flip sits in the 23–32°N Baja
  gap (~28–30°N, southern limit of the Pacific winter storm track). The Pacific NW (SI 0.44–0.52) fills
  the **mid-rainfall band** that was the point of the suite.
- **Japan → southern Taiwan (the monsoon mirror):** **summer** rain (cool_frac ~0.30) the length of Japan;
  Sapporo is the temperature-channel north; Naha/Taipei are near-aseasonal-wet (SI ~0.21, kept wet in
  winter by the NE monsoon); Kaohsiung spikes to a sharp summer monsoon (SI 0.92, cool_frac 0.09) — a tight
  N–S split inside Taiwan itself.

**Headline finding:** at the same ~34°N, Los Angeles reads cool_frac 0.93 (winter/Mediterranean) while
Osaka/Tokyo read ~0.31 (summer/monsoon) — the classic **west-coast vs east-coast subtropical asymmetry**,
captured by a single index. The channel + phase framing holds on real data.

### Two more transects — regime structure and the cross-equator flip (2026-06-18, round 4)
Kim's reading of the transects: seasonality is not a smooth gradient but a set of **regimes** — long
stable stretches punctuated by abrupt **breaks** — and the two channels **substitute** (temperature hands
the job to rainfall as you move). Two transects tested it.
- **E–W near-equatorial strip (South Asia → SE Asia):** temperature held flat (Tamp 0.5–3.9°C), so the
  rainfall channel acts alone — and the stable-then-break structure **still appears**: strongly-seasonal
  monsoon (Mumbai, Bangkok) drops into an **aseasonal equatorial trough** (Kuala Lumpur SI 0.23, Singapore
  0.16), climbs back to monsoon (Ho Chi Minh, Manila), drops again at Davao (0.13). Plus a near-orderly
  march of the rain-peak month (Jul → Aug–Sep → Oct–Nov → Nov–Dec) and a clean **hemisphere break** at
  Jakarta (boreal-summer fraction 0.30, wet in the austral summer). → the regime structure is **intrinsic
  to the rainfall field**, not an artifact of crossing latitude.
- **N–S East Africa (Cairo → Johannesburg, crosses the equator):** the **boreal-summer rain fraction
  flips** from ~1.0 (Khartoum/Addis, N-hemisphere monsoon) through the equatorial middle to ~0 (Lusaka
  0.03, Harare 0.06; austral-summer rain); **bimodality humps on the equator** (Nairobi 1.47, Dar es
  Salaam 0.95 — the double rains); and **Cairo** is the aridity caution (SI 0.87 on 26 mm/yr — a mirage,
  only total rainfall distinguishes it from a real season). All three gates — aridity, bimodality,
  calendar phase — demonstrated in one transect, with the **equator as the grandest break**.
**Methodological note:** for the tropics / cross-equator work the timing measure was switched to a
**solar/calendar reference** (rain in the boreal summer half) instead of the temperature-based cool-season
fraction, which inverts in the cloudy tropics — open-question #12 resolved in practice.

## Reference / validation set
US Southwest deserts: **Mojave** (winter rain), **Sonoran** (bimodal: summer + winter
rain), **Chihuahuan** (summer rain). Textbook-distinct and verifiable by Kim's direct
knowledge *and* the literature — a strong verification surface (cf. the PKM
"verification as test-case-selection" principle). **Plan:** anchor on the trio first
(confirm the indices reproduce them as distinct, Sonoran sitting between as the bimodal
case), **then open it up** — let the data say how many seasonality types exist more
broadly, and map them. Trio = verifiable footing; global types = the discovery.

## Methods considered (and fit)
- **Runs** — number of seasons (unimodal vs bimodal); separates Sonoran, but phase-blind
  (Mojave ≈ Chihuahuan).
- **Circular / phase statistics** — *when* the wet season falls; separates Mojave from
  Chihuahuan. (Runs + phase together already separate all three → a compact signature may
  go a long way.)
- **Markov / transitions** — abruptness of change (monsoon onset vs gradual), but twelve
  months is thin for a *fitted* chain → treat transitions descriptively, not as an
  estimated model.
- **Cyclic sequence distance** — keeps the full ordered pattern; routes the grouping back
  through a dendrogram + assessment lines (the lists path) with an order-aware distance.

**Leaning (2026-06-18):** the **moisture-curve + harmonics** abstraction as the index
source; grouping into types via the lists machinery in index space.

## Data
**whittakerr already retrieves WorldClim monthly temperature + precipitation** for any
point or region — the input pipeline is largely built. Strong synergy; seasonality may
lean on or sit beside whittakerr.

## Open questions to revisit (Kim: "important points we may need to revisit")
1. Indices from the **continuous moisture curve / harmonics** (current lean) vs closer to
   the **literal diagram states** (dry-season length, humid-season phase, number of
   alternations). Harmonics chosen as the starting point; keep the state reading as the
   interpretive layer.
2. Are the categorical states **too coarse for arid sites** (the all-drought problem)?
   Argues for the continuous curve.
3. **Thresholds** (P = 2T; perhumid ~100 mm) — fixed/classical vs calibrated. The 2:1 rule
   is a convention; revisit if it distorts.
4. **Cold/frost state** deferred — may need to rejoin for temperate/northern sites.
5. **How many types** — set by an assessment-line rule (preferred, reproducible) vs imposed.
6. **Discover vs test** — anchor on the trio (test), then discover the global set.
7. **Deliverable shape** — likely a whittakerr/lists-style Quarto document, possibly a
   small package, with the SW deserts as the running verifiable example. Not yet committed.
8. **The combined moisture curve m is the wrong basis for *timing*** (its phase is temperature-locked) —
   decompose into temperature-seasonality + rainfall-seasonality for the type; keep m for aridity.
   (Established in the first prototyping round, 2026-06-18.)
9. **Reframe (Kim's lead, 2026-06-18):** ask how **type-richness varies across the climate space**
   (e.g., along the temperature-amplitude axis) rather than fixing one global number of types — the cold
   world wants ~2 types, the warm world ~5–6, so a single global *k* is the wrong instrument. Possibly
   let a stated rule (assessment-line flavor) set the count, perhaps regionally. **This reframe may be
   the project's real thesis.**
10. **Timing feature needs refining around a "cool-season rain" measure** — the blunt warmest-six split
    mis-sorted Rome away from LA/Cairo, splitting the Mediterranean type.
11. **Bimodality must be gated** on rainfall seasonality (done in the prototype) — carry forward.
12. **Phase gate (round 2; RESOLVED round 4):** rain-phase-vs-temperature is meaningful only where
    temperature seasonality is sun-driven; in the deep tropics the temperature minimum is the *cloudy wet
    season*, so the cool-season feature inverts (Niamey). **Resolution:** use a **solar/calendar phase**
    (rain in the boreal summer half) in the tropics / across the equator — validated on the SE-Asia strip
    and the cross-equator Africa transect (reads the hemisphere flip directly). Keep the temperature-based
    cool-season fraction for the extratropics where it cleanly marks Mediterranean vs continental.
13. **Aridity gate (round 2):** total rainfall (or m) must gate the rainfall channel — SI is relative and
    fakes seasonality in hyper-arid places (Cairo, 25 mm/yr at SI 1.01).
14. **Candidate frame (round 2):** seasonality = *magnitude* + *channel* (temperature / rainfall /
    both-reinforced / neither) + *phase* (where temperature-seasonal). "Two **independent** seasonalities
    are rare" is the structural claim to test on real (gridded) data.

## Locations
- Project folder: `G:\My Drive\Projects\seasonality\` (**created 2026-06-18**). Holds
  `seasonality_harness.R` (the WorldClim + indices harness), **`seasonality_cue_regimes.R`** (the
  daylength channel + the v2 cue-regime classifier + REGIME_PAL, added 2026-06-24), **`seasonality_map.R`**
  (the regional regime-map pipeline: `compute_regime_grid()` / `regime_map_region()`, added 2026-06-24),
  `wc_cache/` (cached WorldClim 2.1 10′ rasters), and the figures
  (`channel_real.png`, `westcoast_transect.png`, `japan_taiwan_transect.png`,
  `rainfall_channel_space.png`, `rainfall_waterbalance_space.png`, `cue_regime_map_v2.png`,
  **`cue_regime_map_NA.png`**, **`cue_regime_map_EU.png`**, **`cue_regime_map_Asia.png`**,
  **`cue_regime_map_AusNZ.png`** — the four regional regime maps so far).

## Related projects
- **whittakerr** — the data pipeline (WorldClim monthly temp+precip) and the
  "extend an accepted construct all the way to a map" template.
- **lists / listsr** — grouping as reproducible constructs; the assessment-line rule for
  the number of groups; the "distance is a choice" lesson (here the obvious distance fails).
- **coenosr** — the grouping through-line's origin (the two-way table this deliberately is *not*).

## Roadmap (tentative; pre-numbers)
1. Concept locked (this file).
2. First numbers: build the monthly moisture curve `m = P − 2T` for the three deserts from
   WorldClim normals; eyeball the curves; confirm the trio is visibly distinct.
3. Compute the candidate indices (mean, amplitude, 1st-harmonic phase, 2nd-harmonic
   strength); confirm they separate the trio.
4. Extend to many sites; cluster into types; set the number by an assessment-line rule;
   check the trio lands in the right types.
5. Map the types (and the indices as surfaces).
6. Decide the deliverable (document ± package).

**Position (2026-06-18, after round 3):** concept explored in the Python sandbox (illustrative data) →
the **WorldClim harness is now built and validated on real data** (`seasonality_harness.R`), with two
real transects in (west coast, Japan→Taiwan) and the west/east-coast asymmetry confirmed. **Next:** **four real transects now in** (west
coast, Japan→Taiwan, SE-Asia E–W strip, East Africa cross-equator) — all confirming the regime-structure
+ channel-substitution reading. Figures in the project folder (`westcoast_transect.png`,
`japan_taiwan_transect.png`, `seasia_transect.png`, `africa_transect.png`). **Next: move to
classification** (the type scheme + the map — step 4–5, with the reframed "type-richness across the space"
view, and a per-zone choice of phase measure: cool-season for the extratropics, solar/calendar for the
tropics). The early Python sandbox scripts remain ephemeral; the durable R harness supersedes them.

**RESUME HERE (next session): begin the DOCUMENTATION phase.** The analysis is mature: daylength channel,
v2 graded (m-gated) classifier, and **four validated regional maps** (NA, NW Europe, East/SE Asia,
Australia/NZ) — all reproducing established climate geography as cue structure. **Decision (2026-06-24):**
build a **Quarto document + companion R package** (the whittakerr/listsr/coenosr pattern), **documenting the
current state**, with the open refinements named as honest future work. **Full plan in
`documentation/doc_plan.md`** — package `seasonalityr` (scaffold from the three durable `.R` files: harness,
cue_regimes, map), a ~7-chapter document (spine → diagram/moisture curve → three channels → water-balance
aridity → cue regimes [desert trio worked example] → the four maps → limits & the deferred reliability axis
+ climate-change lever), and a figure manifest (existing figures already mapped to chapters). **Package DONE 2026-06-24:**
the companion package **`seasonalityr`** is built and checked (`R CMD check` 0/0/1, testthat 11/11,
reproduces the desert trio) — see `proj_seasonalityr.md`. `seasonalityr` is now **LIVE on GitHub** (github.com/kimbridges/seasonalityr,
`remotes::install_github("kimbridges/seasonalityr")`). **Start next session with:** draft the document
against `library(seasonalityr)` — Preface + Ch.1 against the spine and the **voyage framing** Kim added
(documentation/doc_plan.md, "the voyage, not the destination"). Open refinements tracked in doc_plan.md
(temperate-oceanic gap; 25° seam; Med-vs-oceanic; reliability axis; phase polish).

## Collaborators / Dependencies
whittakerr (data + template); WorldClim; base R plus, likely, the lists/listsr toolkit for
the grouping step.

## Blockers
None (pre-implementation by choice — concept first).


---
## Log

The dated log for this project lives in `logs/proj_seasonality_log.md`. Verbatim and unedited.
New entries go there, not here. (Split 2026-10-28.)

