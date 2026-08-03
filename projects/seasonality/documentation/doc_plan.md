# Seasonality — documentation & package plan
_Created 2026-06-24. The deliverable plan agreed this session._

## Decision (Kim, 2026-06-24)
- **Deliverable: a Quarto document + a companion R package** (the whittakerr / listsr /
  coenosr pattern). Document published to **kimbridges-documents**; package installable
  from GitHub.
- **Document the current state.** The open refinements (below) are written up honestly as
  named future work, in keeping with the project's "reproducible constructs, not proofs"
  ethic — not blockers to publishing.
- **Order of build:** package first (the document is written against `library(...)`), then
  the chapters, then render + deploy — exactly the whittakerr sequence.

## Framing note — the voyage (Kim, 2026-06-24; held for later)
_Kim's words, kept verbatim — the intended spirit of the document. Like the whale-call
story, this is first-person framing material; revisit it when drafting the Preface and the
honest-limits close._

> What's being documented is an adventure, true to the spirit of exploration. We could have
> pushed on to a destination; a fine-tuned model of seasonality. But remember that much of
> the fun is in the voyage. We've provided the vehicle (R code) and results interesting
> enough that we both see it's likely there is a destination just over the horizon. Can you
> complete the voyage?

Reading: the document is a **voyage, not a destination** — it honestly presents an
exploration that works and points past its own edge (the "destination just over the horizon"
= the fine-tuned model: the temperate-oceanic regime closed, the seam softened, and above all
the **reliability/interannual axis** that turns cue *availability* into cue *dependability*).
The vehicle is the R code (now the `seasonalityr` package); the invitation to "complete the
voyage" is the document's forward-looking close. This pairs with whittakerr's "Heuristic
Value" ending — value present from the start, realized by carrying the construct all the way
to a map.

## Companion package
- **Proposed name: `seasonalityr`** (noun+`r`, matching whittakerr/listsr/coenosr). *Kim's
  call — easily changed (alternatives: `cueregimes`, `seasoncues`).*
- **Source already written and durable** in `Projects/seasonality/`:
  - `seasonality_harness.R` — `get_climate()`, `indices_table()`, `compute_indices()`,
    the index set (Tamp, SI, cool_frac, bimod, totP, m_mean), the 21-site validation `cities`.
  - `seasonality_cue_regimes.R` — the daylength channel (`daylength_hours`, `add_daylength`),
    the v2 classifier (`rain_mode`, `classify_v2`), `REGIME_PAL`, `plot_regime_map` (scatter).
  - `seasonality_map.R` — `compute_regime_grid()`, `regime_map_region()` (the regional maps).
- **Packaging tasks:** roxygen2 docs on each function; DESCRIPTION/NAMESPACE; bundle the
  21-site `cities` as package data; WorldClim **not** bundled (retrieved via geodata, cached) —
  document the retrieval; testthat (the desert trio reproduces: Mojave winter / Chihuahuan
  summer / Sonoran bimodal; classifier labels stable); `R CMD check` clean; push to GitHub.
  (Mind Finding 004: `.RData` shadowing; Finding 006/007: ClaudeR install via async.)

## Document outline (whittakerr/lists style; running example = the SW desert trio)
1. **Preface — "needs to know."** The spine: seasonality as the **cue structure for
   biological synchronization**; cue worth ≈ amplitude × reliability; anticipatory vs
   reactive cues. Open on **Kim's Alaska whale-call story** (verbatim). The mission: make
   the timing of the living world legible.
2. **The climate diagram and the moisture curve.** Walter–Lieth base; the monthly state
   sequence; quantify it as `m = P − 2T`. Why this is *not* a two-way table (phase/sequence
   carry the seasonality; the desert trio shares composition, differs in phase).
3. **Three channels.** Temperature, rainfall, and the **daylength** channel (free, from
   latitude; ~0 at equator → poleward). Channels are cue types; channel substitution = cue
   substitution. The everwet equatorial core as the **cue-poor zone**.
4. **Aridity is not rainfall total.** The water-balance gate `m`: the two diagnostic charts
   (`rainfall_channel_space.png`, `rainfall_waterbalance_space.png`) — raw total mislumps hot
   deserts with cold-dry continental; `m` separates them. Deserts as **reactive** (trigger)
   rain, not predictive.
5. **The cue regimes.** The v2 typology (hyper-arid / reactive-rain / rainfall-cued /
   Mediterranean / reinforced / temperature-cued / daylength-maritime / cue-poor). The
   **SW desert trio as the worked, verified example** — same regime, phase-distinct.
6. **Mapping the regimes — the payoff.** The four regional maps, each surfacing a different
   part of the framework: **North America** (the desert block + hyper-arid cores + Pacific
   Mediterranean), **NW Europe** (the daylength-maritime oceanic seaboard; Almería desert),
   **East/SE Asia** (the everwet cue-poor core; the monsoon split; the Gobi; Japan as the
   temperature channel), **Australia/NZ** (the concentric continent + the Darwin→Adelaide
   transect; NZ/Tasmania maritime).
7. **Limits and the frontier (honest close).** The **temperate-oceanic / mild gap**
   (SE Australia, NZ North Island — a missing regime); the **25° tropical/extratropical
   seam** (soften / make climatic); the Mediterranean-vs-oceanic split. Then the **deferred
   reliability / interannual axis** (needs CRU TS / ERA5 / CHELSA) and the **climate-change
   lever**: warming moves temperature & rain while **daylength is fixed** → cue **decoupling /
   phenological mismatch**; the map becomes a map of where mismatch is likely.

## Figure manifest (what we already have)
| Figure file | Chapter |
|---|---|
| (new) daylength-vs-latitude | 3 |
| channel_real.png; westcoast / japan_taiwan / seasia / africa transects | 3–4 |
| rainfall_channel_space.png; rainfall_waterbalance_space.png | 4 |
| cue_regime_map_v2.png (3-channel scatter) | 5 |
| cue_regime_map_NA.png | 6 |
| cue_regime_map_EU.png | 6 |
| cue_regime_map_Asia.png | 6 |
| cue_regime_map_AusNZ.png (with the Darwin→Adelaide transect) | 6 |

All maps already carry **labeled city anchors** (Kim's preference) — keep on every figure.

## Decision (2026-06-28) — the transects become a reader exercise
The four exploratory transects (west coast, Japan→Taiwan, SE Asia, East Africa) were essential in *building*
the framework, but in the body they are largely redundant now that the channel scatter (Ch.3) and the maps
(Ch.6) carry the argument. **Kept:** the **west-coast transect** in Ch.3 as the one worked "channel
substitution across space" example. **Dropped from the body:** the other three. **Moved to the close (Ch.7):**
a "try some transects yourself" invitation that names these as examples (Japan→Taiwan monsoon mirror; SE-Asia
equatorial trough; East Africa cross-equator flip) — fits the "can you complete the voyage?" framing.

## Open refinements (named in the document as future work; tracked here)
1. **Temperate-oceanic / mild regime** — close the "mixed/other" gap (moderate Tamp,
   year-round rain, sub-threshold daylength at lower mid-latitudes).
2. **Soften the 25° tropical/extratropical seam** — climatic criterion instead of a hard
   latitude line (cosmetic on the maps but worth doing).
3. **Mediterranean vs oceanic split** of the winter-rain cue (summer-drought intensity).
4. **Reliability / interannual axis** — the deferred second axis; needs year-by-year data.
5. Phase-threshold polish (Las Vegas winter at cool_frac 0.58; Mediterranean phase label).

## Next session
Start the package (`seasonalityr` scaffold from the three .R files), or begin the Preface +
Chapter 1 prose against the spine — Kim's call on which end to start.
