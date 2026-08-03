# PROJECT: seasonality

_Last updated: 2026-06-29_
_Status: Complete_
_Focus readiness: Not applicable (PUBLISHED to kimbridges-documents 2026-06-29: https://kimbridges-documents.netlify.app/seasonalityr/)_

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

### 2026-06-29 — PUBLISHED & LIVE; project COMPLETE
Shipped. Wired Kim's hand-built cover + logo into `_quarto.yml`, installed `seasonalityr` locally (so Quarto's
fresh R session can `library()` it), and ran a **full `quarto render`** of the book via ClaudeR — clean on the
first pass: all 10 pages, every generated figure, the four embedded maps, the cover in the Preface and the logo
in the navbar, no chunk errors. **Deployed to kimbridges-documents** per style guide §7: copied `_output` →
`kimbridges-documents/seasonalityr/`, added the listing stub `docs/seasonalityr.qmd` (categories Ecology/R/Climate,
cover-card), registered `seasonalityr/**` in the site `_quarto.yml` resources, re-rendered the documents site,
and Kim pushed `_site` to Netlify (existing site). **Verified live and perfect** at
**https://kimbridges-documents.netlify.app/seasonalityr/**. Per the PKM "posted-on-website = Complete" rule, the
project is **Complete**. The companion package `seasonalityr` is live on GitHub; its proj file also marked
Complete. Open refinements (temperate-oceanic regime, 25° seam, Med-vs-oceanic split, reliability axis,
phase-threshold polish) are named honestly in the book's closing chapter as the route to a future version, not
blockers. A model run of the collaborative method end to end: resume note → seven-chapter illustrated Quarto book
+ companion package → live, in a few focused sessions, draft-then-react throughout, every chunk verified in
Kim's live RStudio, the PKM carrying state across it all. Kim: "It looks perfect on the website. Cheers all
around!" Operational note for future renders captured in pkm_findings.md (ClaudeR `quarto_render` times out the
MCP request but completes in-session; verify via the filesystem).

### 2026-06-28 (cont. 4) — function-reference appendix done; book content-complete; session close
Wrote the **function-reference appendix** (`function_reference.qmd`): all 12 exported `seasonalityr` functions
plus the `cities` data, grouped by workflow stage (retrieve → indices → daylength → classify → plot/map →
data), each with its **exact signature pulled live** from the loaded package, a one-line purpose, and its
parameters. Flagged the one gotcha (`plot_regime_map()` is a channel-space scatter, not a geographic map).
**The book is now content-complete:** Preface + Ch.1–7 + the WorldClim-retrieval appendix + the function
reference, every code path live-verified in RStudio (ClaudeR).

**Remaining to ship (tomorrow):** (1) **cover + logo art** — Kim is building `seasonalityr_cover_art_text.png`
and `seasonalityr_logo_art.png` by hand (the lines wait commented in `_quarto.yml`; uncomment once the files
exist); (2) **full Quarto render** to catch any cross-chapter issues; (3) **deploy to kimbridges-documents**
(listing stub + resources line + Netlify drag-drop, per style guide §7). Kim's close: "another excellent day…
a most interesting story… still a little overwhelmed by it." Session ended here for the night; **Active Focus
stays seasonality**, nothing left mid-edit. See session_log.md 2026-06-28 (cont. 3).

### 2026-06-28 (cont. 3) — Ch.6 + Ch.7 drafted: the FULL BOOK DRAFT is complete (live-verified)
The voyage reached its end. Two more chapters drafted, both verified live in RStudio (ClaudeR).

**Transect decision (Kim):** the four exploratory transects were essential to *building* the framework but are
largely redundant in the body now that the channel scatter (Ch.3) and the maps (Ch.6) carry the argument.
**Kept** the west-coast transect in Ch.3; **moved the other three** (Japan→Taiwan, SE-Asia, East Africa) to a
"try these yourself" reader exercise in Ch.7. Recorded in `documentation/doc_plan.md`.

**Ch.6 "Mapping the Regimes — the Payoff."** The four regional maps **regenerated through the package**
(`regime_map_region()` / `compute_regime_grid()`, not the old script) and saved to `documentation/images/`
(`map_NA/EU/Asia/AusNZ.png`) — the package reproduces them exactly (NA = 29,262 cells, identical structure).
Each map foregrounds a different part of the framework: NA (desert block + hyper-arid cores + Pacific
Mediterranean + Mexican monsoon flip; trio cities land in the orange block), NW Europe (the daylength-maritime
Atlantic seaboard = the clearest payoff of the daylength channel; Almería desert), East/SE Asia (the everwet
**cue-poor core** as one connected zone = the spine's keystone; the 25° monsoon split; the Gobi; Japan as
temperature channel), Australia/NZ (the concentric continent with the **Darwin→Adelaide transect drawn**;
NZ South Island + Tasmania maritime; the **temperate-oceanic GAP shown honestly in grey**). Maps generated once
and embedded (each classifies tens of thousands of cells); the `regime_map_region()` recipe is shown. Kim:
"really impressive… it tells you how to think about it."

**Ch.7 "Limits and the Frontier" (the honest close).** Four moves: (1) the **near edges** (the temperate-oceanic
gap as a missing regime; the hard 25° seam; the Mediterranean-vs-oceanic lump; the Mojave phase knob);
(2) the **missing axis = reliability** — we measured amplitude everywhere, never dependability, because WorldClim
is a climatological mean; the real frontier needs year-by-year data (CRU TS / ERA5 / CHELSA) to complete the
spine's amplitude × reliability; (3) the **climate-change lever** — daylength is fixed while temperature and rain
move, so cues decouple → phenological mismatch; the cue map becomes a map of *where mismatch is likely*; returns
to the whale call; (4) **the invitation** — the verified **Japan→Taiwan transect recipe** (eval:false) plus the
SE-Asia and East-Africa transects as coordinate sets, and `regime_map_region()` for the reader's own region.
Closes in Kim's first-person voice, bookending the Preface's whale-call: "I think this book is my long answer…
Can you complete the voyage?" No fabricated schematic (avoided the synthetic-mockup trap per Kim's principle).

**STATUS: full draft complete** — Preface + Ch.1–7 + WorldClim appendix, all live-verified. **RESUME / remaining
to finish the book:** (1) the **function-reference appendix** (`function_reference.qmd` still a stub — the
per-function `seasonalityr` table the style guide expects); (2) **cover + logo art** (`seasonalityr_cover_art_text.png`,
`seasonalityr_logo_art.png`; currently commented out in `_quarto.yml`); (3) a **full Quarto render** to catch
cross-chapter issues, then **deploy to kimbridges-documents** (per style guide §7). Suggested next: the
function-reference appendix, then a render.

### 2026-06-28 (cont. 2) — Ch.3, Ch.4, Ch.5 drafted and live-verified; appendix + style refinements
Four more chapters' worth of work, all developed and verified live in RStudio (ClaudeR session "default") against
`devtools::load_all` of the local package + cached WorldClim. Bundled small CSVs keep renders light
(`documentation/data/`: `cities_indices.csv` = the 21-city indices + lat/lon, `westcoast_transect.csv`,
`temperate_reference_monthly.csv`). One shared visual language across the four cue figures (rain-phase color,
temperature-seasonality size), per Kim's consistency preference.

**Appendix refinement (Kim's catch):** the WorldClim appendix's first example now teaches **user-supplied site
tables** (build a 4-column table by hand: Honolulu + Reykjavik, neither in the package; shown with `gt()`),
before reusing the bundled trio. **Style convention added:** parenthesize arithmetic where precedence could be
doubted (`round(prec - (2 * tavg), 2)`) — Kim's standing rule from a dissertation-era missing-parenthesis that
cost ~5 ten-hour days; recorded in `style_multichapter_doc.md` §4 and `kim_association_index.md` Theme 11.

**Ch.3 "Three Channels"** — the daylength channel introduced (`daylength_hours`/`daylength_channel`/
`add_daylength`) with a new two-panel figure (photoperiod cycle + amplitude-vs-latitude); London as the proof
it's its own channel (mild Tamp, big daylamp). The `plot_channel()` scatter on the 21 cities reads as channel
substitution (LA-vs-Tokyo asymmetry). The **west-coast transect** rebuilt clean (Mediterranean→monsoon flip in
the Baja gap = "regimes with breaks"). Closes on the **cue-poor zone** (Singapore/Manaus) as the keystone.

**Ch.4 "Aridity Is Not Rainfall Total"** — Kim's favorite so far ("a real problem solved only by looking hard
at the data… a data-analysis voyage"). The SI **mirage** (Cairo SI 0.87 on 26 mm), the rainfall-**total trap**
(Ulaanbaatar 282 mm vs Tucson 318 mm — twins by total, opposite worlds), and the **water-balance recast**
(`m = mean(P−2T)`): two diagnostic figures rebuilt clean, Ulaanbaatar/Fairbanks cross to water-sufficient where
they belong. Closes on **reactive vs predictive rain** = the classifier's gate (ties to Ch.1).

**Ch.5 "The Cue Regimes"** — `classify_v2()` walked as a readable 3-step rule (gate rainfall on the water
balance → read temperature + daylength strength → combine), framed as **reproducible constructs, not proofs**
(Kim's categories theme). 21 cities grouped into **9 regimes**, recovering known climate types as cue structure.
**Desert trio = one regime ("reactive-rain (arid desert)"), three phases** (Chihuahuan summer 0.26 / Sonoran
bimodal 1.17 / Mojave winter-leaning 0.58). Handled the **Mojave boundary case honestly**: cool_frac 0.58 just
under the 0.60 winter cutoff → rule labels it "mixed"; written as a virtue and flagged as Ch.7 future work
("phase-threshold polish"). Figure = `plot_regime_map()` (three channels in one scatter).

**RESUME: Chapter 6 — Mapping the Regimes** (the payoff): the four regional maps via
`compute_regime_grid()` / `regime_map_region()` (NA, NW Europe, East/SE Asia, Australia/NZ;
`cue_regime_map_NA/EU/Asia/AusNZ.png`), with labeled city anchors. **Open thread:** the 3 other transects
(Japan→Taiwan, SE Asia, East Africa) aren't yet placed — candidates for Ch.6 (breaks as map edges) or a sidebar.

### 2026-06-28 (cont.) — Ch.2 refinements: a temperate baseline diagram + the Helmut Lieth story
Two Kim-led improvements to the Walter-Lieth section of Ch.2. (1) **A temperate reference diagram added
before the desert one.** Kim's point: a reader can't feel how extreme a desert diagram is without first
seeing a "normal" two-season site. Added **Rome** (temperate, annual P 760 mm, clear wet winter + a 3-month
summer drought) as the baseline, then Tucson as the inversion (mostly deficit, two wet slivers = bimodal).
The desert now carries the argument by contrast. Code refactored into a small reusable `walter_lieth()`
helper called twice; Rome's normals bundled as `documentation/data/temperate_reference_monthly.csv`. Both
diagrams live-verified.

(2) **Kim's Helmut Lieth anecdote, woven into the chapter as first-person material (kept verbatim here).**
Kim sat with Helmut Lieth (of *Walter-Lieth*) in the Salt Lake City airport, the two of them waiting out a
delay; Lieth a very senior ecologist, Kim just starting out. Lieth's parting words of wisdom:
> Every ecologist eventually becomes a phenologist.
Kim: "I guess he was right, as here we are, doing phenology." This lands the whole document's thesis
(seasonality = the phenological cue structure) in a single remembered line, and credits a namesake of the
diagram personally. Placed as a short first-person aside in the diagram section. A clean instance of the PKM
principle that first-person material is the highest-value content and surfaces through drafting (it arrived
as a reaction to the chapter, not before). Companion to the whale-call origin story above.

### 2026-06-28 — documentation phase begins: Preface + Ch.1 + Ch.2 drafted and live-verified
Started the **Quarto book** in `documentation/`. Scaffolded `_quarto.yml` (book, conceptual-base-dominant,
authors K. W. Bridges + Claude) and the full chapter skeleton: Preface, 7 chapters, a WorldClim appendix, and
the function-reference appendix, with stubs so it renders end to end. **Structural call:** the **spine** gets
its **own Chapter 1** ("What Seasonality Is For"), not folded into the Preface; the climate diagram shifts to
Ch.2. **Preface + Ch.1 drafted and approved** by Kim ("very strong... my tone is clearly in the writing") —
whale-call story verbatim, the cue-structure turn, voyage framing; Ch.1 carries amplitude x reliability,
anticipatory vs reactive cues, channel substitution, the cue-poor zone, the decoupling lever. No em dashes.

**Ch.2 ("The Climate Diagram and the Moisture Curve")** drafted **against `library(seasonalityr)`, verified
live in RStudio** (ClaudeR session "default", `devtools::load_all` of the local pkg, real cached WorldClim).
Numbers reproduce the validation exactly (Las Vegas cool_frac 0.58 / El Paso 0.26 / Tucson bimod 1.17). Two
full-width figures: the moisture-curve trio comparison and **our own modern Walter-Lieth diagram** for Tucson
(ggplot, 2:1 rule, **no `climatol` dependency**; `diagwl()` credited in text) — realizing Kim's original wish
for a modern climate diagram. Teaches "not a two-way table": near-identical by composition (0/1/2 wet months),
separable by phase. Trio monthly normals bundled as `documentation/data/desert_trio_monthly.csv`; **WorldClim
retrieval given its own appendix** ("Retrieving WorldClim Data": `get_climate`, caching, resolution,
`tmin`/`tmax` for a future frost line, the CSV recipe). Paused for Kim's read-through. **RESUME: Chapter 3 —
the three channels** (temperature, rainfall, daylength; transect figures), against `daylength_hours()` /
`add_daylength()`. See session_log.md 2026-06-28.

### 2026-06-24 — daylength channel + v2 cue-regime classifier + the FIRST regional map
Big step: the classification became real and got its first map. (1) **Daylength channel** added
(`seasonality_cue_regimes.R`): `daylamp` = half the annual photoperiod range, a pure function of latitude
(~0 at the equator → 8.9 h at Fairbanks). It diverges from temperature exactly where it should — maritime
high-lat (London/Bergen: big daylamp, ocean-damped Tamp) — which is what makes it its own channel.
(2) **v1 classifier** built, then its hard aridity gate (250 mm) was found to erase the desert trio's rain
signal and split the Mediterranean. Two diagnostic charts (`rainfall_channel_space.png`,
`rainfall_waterbalance_space.png`) showed the fix: **aridity is rainfall relative to evaporative demand
(the water balance m = mean(P−2T)), not raw total** — raw total wrongly lumps hot deserts with cold-dry
continental (Ulaanbaatar/Fairbanks, low total but m>0). (3) **v2 graded classifier** (m-gated rainfall:
hyper-arid / reactive / predictive / aseasonal; Mediterranean from winter-rain phase; phase carried as its
own attribute). On the 21 validation sites it reunites the desert trio under "reactive-rain (arid desert)"
with phase distinguishing them (Mojave winter / Chihuahuan summer / Sonoran bimodal), unifies LA+Rome as
Mediterranean, quarantines Cairo as hyper-arid, and gives London/Bergen their own "daylength-cued
(maritime)" regime. Nine regimes; `cue_regime_map_v2.png` shows all three channels in one scatter.
(4) **First regional MAP** (`seasonality_map.R` → `cue_regime_map_NA.png`, western North America, 29,262
land cells): the regimes form **coherent spatial zones** — a contiguous reactive-rain desert block (trio
cities land in it; hyper-arid cores at Death Valley / lower Colorado / Baja), a clean Mediterranean Pacific
strip, continental interior, and the Mexican-monsoon flip to tropical wet-dry. The transect "breaks" appear
as crisp spatial edges. Construct validated spatially, not just point-wise. Kim: "a really big step
forward." Honest nuances logged: the winter-rain band runs up the Pacific NW coast (shares the cue but is
oceanic, not Mediterranean — a candidate Med-vs-oceanic split); the "reinforced" class is broad; maritime
barely shows at NA latitudes (→ the European map). See session_log.md 2026-06-24.

### 2026-06-24 (cont.) — two more regional maps: NW Europe and East/SE Asia
Stayed regional (Kim's call), labeled-city anchors on every map (Kim finds them very useful).
**NW Europe & high latitudes** (`cue_regime_map_EU.png`): the framework reproduces Europe's Köppen zones
unsupervised — **daylength-cued maritime** (yellow) traces the whole oceanic Atlantic seaboard (Iceland,
Ireland, Britain, Norway coast, NW Iberia: Reykjavik/Bergen/Dublin/Edinburgh/London), and it's there
*because* the ocean damps temperature while the photoperiod swing stays large — the clearest proof the
daylength channel was worth adding. **Temperature-cued continental** fills the interior (Moscow/Warsaw/
Berlin/Stockholm); **winter-rain Mediterranean** wraps the whole basin (Madrid/Lisbon/Rome/Athens); and the
classifier even caught **reactive-rain desert in SE Spain (Almería, Europe's only true desert)** at 10′.
**East & SE Asia** (`cue_regime_map_Asia.png`, equator→Mongolia — Kim's pick to extend the Japan–Taiwan
transect south and pull in the continental interior): the spine's **keystone validated** — the **everwet
equatorial cue-poor core** (gray) maps as a coherent zone over the Maritime Continent (Borneo/Sumatra/Malaya/
New Guinea, Singapore in it), the place where none of the three cues carries signal (predicted weak tropical
synchrony). The Asian monsoon splits into **reinforced thermal+summer-rain** (China/Korea mainland) vs
**tropical wet-dry** south of ~25°N (Indochina/Philippines/Hong Kong/Taipei); the **Gobi** appears as
hyper-arid cores ringed by reactive-rain desert; **Japan reads temperature-cued** (rain too spread to be
predictive — the original transect finding in full spatial context); and the **cross-equator flip** shows on
Java. Three continents now, all reproducing established climate geography while reframing it as cue structure.
Kim: "an excellent demonstration." See session_log.md 2026-06-24.

### 2026-06-24 (cont. 2) — Australia/NZ map (Kim's trip region) + a regime GAP found
Fourth regional map (`cue_regime_map_AusNZ.png`), Kim's pick (he + Nancy travel there in ~18 months,
incl. a Darwin→Adelaide drive). The **Darwin → Alice Springs → Adelaide transect** is drawn on the map and
crosses the concentric continent cleanly: tropical wet-dry monsoon (Darwin) → reactive-rain arid centre
(Alice Springs) → winter-rain Mediterranean (Adelaide). Validates: monsoon north, vast arid interior,
Mediterranean SW (Perth) + south (Adelaide), and **NZ South Island + Tasmania as daylength-cued maritime**
(the southern-hemisphere oceanic analog of Britain). **Two findings for the refinement/documentation list:**
(1) a real **regime GAP** — a large "mixed/other" swath through SE Australia (Sydney/Melbourne) and NZ North
Island (Auckland/Wellington): mild **temperate-oceanic** climates (moderate Tamp, year-round rain, daylength
amplitude too small at 33–37°S to trip the maritime threshold) fall through every branch. Needs a new
"temperate-oceanic / mild" regime (this is the early prototype's "temperate catch-all" resurfacing, exposed
because the southern mid-latitudes are mild at lower latitude than Europe's oceanic zone). (2) a **cosmetic
seam** at 25°S in the arid interior = the hard TROPIC_LAT cutoff showing through; the tropical/extratropical
split should be softened or made climatic, not a hard latitude line. **Next: move to documentation** (Kim's
call) — likely a whittakerr/lists-style Quarto document (± a small package from the harness/classifier/map
code), with the SW-desert trio as the running verified example and the four regional maps as the payoff.

### 2026-06-18 (cont. 4) — two more transects: regime structure + the cross-equator flip
Kim's reading crystallised: the transects show seasonality as **regimes** (stable stretches + abrupt
breaks) with the channels **substituting** (temperature → rainfall as you move). Two tests. **SE-Asia E–W
strip** (South Asia → SE Asia, near-equatorial): with temperature held flat, the rainfall channel alone
still shows stable-then-break — seasonal monsoon → aseasonal equatorial trough (KL/Singapore) → monsoon
→ aseasonal (Davao), a rain-peak-month march, and a hemisphere break at Jakarta. So the regime structure
is **intrinsic to rainfall**, not a latitude artifact. **East Africa N–S** (Cairo → Johannesburg, crosses
the equator): boreal-summer rain fraction flips ~1.0 (Khartoum/Addis monsoon) → ~0 (Lusaka/Harare austral
summer); bimodality humps on the equator (Nairobi 1.47, Dar 0.95); Cairo is the aridity mirage (SI 0.87 on
26 mm). All three gates (aridity, bimodality, calendar phase) shown at once; the **equator is the grandest
break**. Methodological: switched to a **solar/calendar phase** for the tropics/cross-equator (resolves
open-question #12). Four real transects now in. Kim: "a big step forward." **Next: classification + the
map.** See session_log.md 2026-06-18.

### 2026-06-18 (cont. 3) — the WorldClim harness, validated on real data; first two transects
Moved from illustrative hand-data to **real WorldClim**. Built `seasonality_harness.R` (in the new
project folder `G:\My Drive\Projects\seasonality\`): `geodata::worldclim_global` (tavg+prec, 10′, cached
in `wc_cache/`) → `terra::extract` by lat/lon → the ported indices (Tamp, SI, cool_frac, gated bimod,
totP, m). ClaudeR bridge needed starting (Finding 006 ritual) — done by Kim. **Validation passed:** real
data reproduce the desert trio (Mojave winter cool_frac 0.58 / Chihuahuan summer 0.26 / Sonoran bimodal
bimod 1.17) and the whole channel picture — the hand-typed normals weren't misleading. **Transect 1**
(Vancouver→Acapulco, +Mazatlán): rainfall seasonality climbs N→S; rain phase stays **winter** the length
of the US/Baja coast (Mediterranean, cool_frac→0.93 at LA) then flips hard to **summer** (monsoon) —
Mazatlán already 0.11, so the flip is in the 23–32°N Baja gap (~28–30°N); the Pacific NW fills the
mid-rainfall band. **Transect 2** (Sapporo→Kaohsiung): the **monsoon mirror** — summer rain (cool_frac
~0.30) the length of Japan, Sapporo the temperature-channel north, Naha/Taipei near-aseasonal-wet (winter
NE-monsoon), Kaohsiung a sharp summer monsoon (SI 0.92) — a tight N–S split within Taiwan. **Headline:**
same ~34°N, LA cool_frac 0.93 (winter) vs Osaka/Tokyo ~0.31 (summer) — the west-coast/east-coast
subtropical asymmetry captured by one index. Outputs durable in the project folder. **Next (after Kim's
break):** a few more regional suites, then **classification + mapping.** See session_log.md 2026-06-18.

### 2026-06-18 (cont. 2) — the channel refinement (prototyping round 2)
Kim's lead: in low-rainfall-seasonality places you experience the year through **temperature**, in
low-temperature-seasonality places through **rainfall**, and it is **rare to get both**. Built a
cool-season-rain feature (rain in the 6 coldest months / total) and added Beijing as a continental "both"
probe. Findings: (1) the high–high "both" corner is populated only by **continental summer-rain**
(Beijing, Ulaanbaatar, Fairbanks) where rain is *in phase* with warmth — one reinforced pulse, not two
seasons; the truly empty corner is **two independent (anti-phase) seasonalities**. So the law sharpens to
"two *independent* seasonal cycles are rare." (2) A clean **channel typology** falls out: neither
(everwet) / rainfall-only (tropical wet-dry) / temperature-only (temperate) / both-in-phase (continental
summer-rain) / the rare anti-phase both (Mediterranean is the nearest approach). (3) Two gates: the
cool-season **phase** feature works in the extratropics but **inverts in the deep tropics** (coolest
months = cloudy monsoon, e.g. Niamey 0.61) → gate phase on temperature seasonality; and **aridity** must
gate the rainfall channel (Cairo fakes SI 1.01 on 25 mm/yr) — where the moisture overlay m finally earns
its place. Frame forming: seasonality = magnitude + channel + (where T-seasonal) phase. Still illustrative
hand data; WorldClim ahead. Kim asked to log; "this feels like a real conceptual waypoint." See
session_log.md 2026-06-18.

### 2026-06-18 (cont.) — first prototyping round (Python sandbox, illustrative data)
Approach agreed: **rapid prototyping in the Python sandbox** (throwaway builds, accept failures), R kept
clean for the eventual real build. Three builds. (1) Three SW deserts, moisture curve `m = P − 2T` +
harmonics → the deserts separate, but by **rainfall** harmonics (phase + bimodality), **not** by m's
phase, which is temperature-locked to winter for all hot deserts. So *type* = decomposed
temperature-seasonality + rainfall-seasonality; **m demoted to the aridity overlay**. (2) ~13 global
archetypes in a (temperature-seasonality × rainfall-SI) space → the **warm world fans out, the cold world
collapses** (Kim's hypothesis, visible). Surfaced failures: the bimodality ratio blows up on near-uniform
rain (Atlanta), peak-month is meaningless when flat, hemisphere unhandled. (3) Fixes — **gate**
timing/modality below a rainfall-SI floor (≈0.40); **hemisphere-proof** timing via the warm-half rain
fraction; ~18 sites; **Ward clustering** of four indices cut at k=6 → six interpretable types (everwet
equatorial / monsoon-savanna / bimodal double-rain [Nairobi + Tucson] / cool-season rain /
cold-continental summer-rain / temperate catch-all). **Richness count: warm half 5 types / cold half 3** —
the hypothesis quantified (illustratively). Three wrinkles became the next-step fork, which Kim flagged as
"particularly good": (a) **reframe** from "how many types globally" to **how type-richness *varies* across
the climate space** — a single global *k* is the wrong instrument (cold wants ~2, warm ~5–6); likely the
project's real thesis; (b) rebuild the **timing** feature around a cool-season-rain measure (the
Mediterranean split — Rome vs LA/Cairo); (c) let a **rule** set the type count, possibly regionally
(assessment-line flavor). All numbers from representative hand-entered normals — **WorldClim still to
replace them**. Kim paused here to think; "there is clearly something here." See session_log.md 2026-06-18.

### 2026-06-18 (project opened — concept conversation captured)
New Active Focus, opened the day after lists shipped. Kim's idea: a climate-viewed
seasonality from monthly temperature + rainfall, grounded in the **Walter-Lieth climate
diagram**, abstracted to **indices**, classified into **types**, and **mapped** — the
whittakerr "extend an accepted construct to a map" move, with shades of whittakerr's data
too. Agreed starting abstraction: quantify the diagram as a monthly **moisture curve**
(`m = P − 2T`) and read its **harmonics** (1st-harmonic phase = wet-season timing;
2nd-harmonic strength = bimodality; plus mean and amplitude). Key insight that shaped the
approach: the SW desert trio (Mojave/Sonoran/Chihuahuan) is mostly drought categorically —
what separates them is the *phase* of the wet season, which is why this is not a two-way
table and why the continuous curve beats state-counting. Cold/frost state deferred
(rain + temp only). Trio = verification anchor; global types = discovery. **No numbers
yet, by Kim's call — concept first.** See session_log.md 2026-06-18.
