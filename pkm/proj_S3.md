# PROJECT: S3 -- Spells, Stretches and Snaps
_Last updated: 2026-11-26_
_Status: Active_
_Focus readiness: Ready_

## Type
Content project, data-driven: Quarto multi-chapter document (R + Quarto), with worked examples and reusable R tools.

## Objective
*Spells, Stretches and Snaps* is about the scale between weather and climate -- the middle of the time spectrum,
neglected between the nightly forecast and the long-term average, yet the scale at which we understand, through
context, what happens at the two ends. It is the third document of Kim's trilogy ("boundaries in value, space and
time"): MRC = value (published 2026-11-06), *Maps with Tiles* (MWT) = space, S3 = time. The environment is central
(planet-wide and underlying so much else), with excursions beyond it. Series style: examples plus tools -- "This is
what I found; now you can find your own examples using the tools provided." Personal stories throughout.

## Current Status
Formal intake 2026-11-26 (Mechanism 1), after five rounds of idea capture (2026-09-22 to 2026-11-25) and a
round-three outline drafted, ruled and revised on 2026-11-25: Prologue (the weathercast, twice); I The missing
middle (1 Two ends and a gap; 2 Snaps, spells and stretches; 3 Calendar time and event time); II Reading the middle
(4 Accumulation; 5 The living calendar and its recorders; 6 This year against the envelope; 7 The moving landscape);
III Living with the middle (8 Forward and backward; 9 Friction, then and now; 10 Frozen categories and rare events);
Closing (an open psychohistory -- Asimov's Foundation); Appendix (a picture-first catalog, code hidden until asked).
The Hawai'i test runs through the chapters. About fifteen figures and tools are already built (see Key Files).
Kim has given first-draft stories for ch.2, ch.3 and ch.7. Next: more stories, then the process of getting good
graphics.

## Locations
- Code and figures: G:\My Drive\Projects\S3\figures\ (one subfolder per figure family)
- Ideas (the source of record for the argument so far): Projects_Index/ideas_three_documents.md
- Docs/output: kimbridges-documents (planned)
- GitHub: not yet

## Key Files
- figures/rain_periods/rain_periods.R -- periods of rain at a ladder of gap tolerances (ch.3)
- figures/cherry_blossom/ -- Kim's 2022 DC cherry-blossom Rmd + 4 plots; NOTES.md lists code issues (ch.5)
- figures/thresholds/sf_small_addition.R -- tide-gauge threshold view, any NOAA station (ch.6)
- figures/pressure_terrain/pressure_terrain.R -- pressure as terrain: SLP, 500 hPa, animation frames (ch.7)
- figures/pressure_terrain/topeka_barograph.R -- a station's view of the moving landscape (ch.7)
- figures/pressure_terrain/rivers_of_air.R -- wind vs contour direction; the angle histograms (ch.7)
- figures/pressure_terrain/particles_500.R -- particles aloft and at 10 m (ch.7)
- figures/pressure_terrain/where_is_500hpa.R -- making 500 hPa relatable (ch.7)
- figures/japan_fronts/japan_fronts.R -- JMA phenology: cherry and maple fronts, anomaly stripes; two PNGs (ch.5, ch.6)
- figures/japan_fronts/japan_front_maps.R -- maps of the fronts on terrain + change map (ch.5, ch.6)
- figures/japan_fronts/japan_maple_animation.R -- maple and cherry front animations (event = "maple" or "cherry"), MP4 + GIF (ch.5, ch.7)
- figures/dry_spells/dry_spells.R -- five implementations of 'dry spell' (one function each) + figures + station-move test; HNL 1974-2026; hnl_vs_manoa.R, airport vs Manoa 1983-2022 (ch.2)
- figures/hurricanes/hawaii_hurricanes.R -- tracks near Hawai'i, El Nino vs other seasons, 2026 against both (ch.6, ch.10)
- figures/envelope_folk/envelope_folk.R -- this year against the envelope, bands labeled with the folk words for the odds; HNL water year 2025-26 (ch.6)
- figures/return_periods/return_periods.R -- what 'a 100-year event' means over a span and across many gauges (ch.10)
- figures/irp_1973/ -- Kim's IRP weekly rain Jan 1971-Jun 1975 (TR22 S1, TR38, TR59, TR70); irp_years_fig.R, transcribed and checked; K54 Kilauea Rain Forest + M42/M54/M66 Mauna Loa Road; irp_rain_fig.R (ch.9, ch.2)
- figures/irp_1973/irp_eventyear_fig.R -- calendar year vs event year (July start), same IRP rain (ch.3)
- figures/accumulation/co2_intervals.R -- Mauna Loa CO2 at four sampling intervals; 'a little number times a big number' (ch.4)
- figures/fire/fire_return.R -- fire return interval as accumulation: fire_sim() model (same weather, forest vs grass regrowth), fire_fig(); LANDFIRE regimes vs human spans (ch.4/ch.10)
- figures/drought_live/hnl_live.R -- LIVE figure, HNL wet season 2026-27: live_update() refreshes GHCN-D + ONI and redraws; forward call FROZEN in forward_call_wy2027.rds (made 2026-11-27); judge after Apr 30, 2027 (ch.8 forward/backward; drought)
- figures/hydro_illogical/hydro_illogical.R -- the hydro-illogical cycle measured: hi_daily(), hi_episodes() (drought = 12-mo rain < 70% of median 90+ days; apathy gap = first 1-inch day after the low -> back to median), hi_fig(); HNL 1975-2026 (ch.8/ch.10)
- figures/tree_rings/tree_rings.R -- measuring rings, not counting: tr_prep(), tr_fig(); Schulman Old Tree No. 1, Mesa Verde (dplR co021) vs Mesa Verde NP gauge; cores to measured widths, crossdating, locally absent rings, index vs Oct-Jun rain; tropics limit (ch.5/ch.3)
- figures/vintage/petrus_vintage.R -- the market's operation: Petrus on/off vintages (Liv-ex prices 2008-2023, petrus_livex_2025.csv) with Bordeaux-Merignac weather (GHCN-D FR000007510, Ashenfelter variables); pv_read(), pv_weather(), pv_fig() (ch.8 backward)

## Related Projects
- proj_MRC.md -- trilogy document 1 (value); published; its chart rule and visual vocabulary carry over
- MWT (Maps with Tiles) -- trilogy document 2 (space); at capture, no proj file yet
- proj_Voronoi.md / proj_tessellr.md -- the tile method MWT cites
- proj_seasonality.md, proj_whittakerr.md, proj_Temperature_Patterns.md -- prior R work S3 may draw on

## Track
R on Kim's machine (ClaudeR bridge): destined for documentation; builds on the R ecosystem; rayshader, ragg and
gifski installed for the S3 figures (2026-11-25). Venue: kimbridges-documents.

## Design Decisions
- **Guiding principle (Kim, 2026-11-21):** keep the focus on the middle; every example must show what the meso
  scale adds that the two ends cannot.
- **Scope (Kim, 2026-11-25):** the environment is central; excursions (markets, discovery) welcome as examples.
- **Hawai'i is a test, not the setting (2026-09-22),** spread through the chapters (2026-11-25).
- **Friction is a recurring motif (2026-11-21):** what we did was OK; now it can be smoother.
- **Series style (2026-11-25):** examples plus tools; scripts accept any station or region.
- **Catalog (2026-11-25):** picture-first, code hidden until asked (Kim's 1985 strategy adapted to longer R code).
- **Chart rule (trilogy, from MRC):** a new kind of chart must teach the reader how to read it.
- **Kept verbatim:** the integrative statement on surface vs upper-air flow (2026-11-25).

## Next Steps
1. Kim gives more chapter stories. Have drafts for ch.1 (phenology chases; Lieth to move near the start), ch.2, ch.3,
   ch.7 (incl. HNL runway), ch.8 (childhood fire), ch.10 (Iniki's pines; Laupahoehoe 1946; Cox's tsunami catalog).
   Still thin: ch.2's operations, ch.4, ch.6. Vintage side of ch.8 now drawn from Kim's three wine stories
   (2026-11-26: celebrate / hedge / erase the year -- Bordeaux, Hendry, Palmaz).
2. Work through the process of getting good graphics (Kim).
3. Open gaps (updated 2026-11-27): CLOSED -- ch.2's five implementations (ruled accepted), drought and the forward direction
   (live figure + hydro-illogical), fire (ch.4/ch.8), ch.10 figures. vintage figure DONE (Petrus, 2026-11-27); tree-ring group DONE (2026-11-27). STILL OPEN --
   rerun hnl_live periodically to Apr 30, 2027.
4. Verify lists in ideas_three_documents.md.

## Collaborators / Dependencies
Kim (author); Claude (joint authorship on all collaborations, per standing rule). Data: NOAA GFS (NOMADS), NOAA
CO-OPS, ASOS via Iowa Environmental Mesonet, NPS cherry-blossom records.

## Blockers
None.

---
## Log
### 2026-11-26
Formal intake (Mechanism 1). File created from the ruled round-three outline and the build record of
2026-11-18 to 11-25; index row added; Active Focus updated.
