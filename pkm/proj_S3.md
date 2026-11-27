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
3. Open gaps: fire and vintage worked groups (ch.8); ch.2's five implementations on a real record; drought and the
   forward direction; ch.10's figures (Hawai'i hurricane-track map; chance over a mortgage vs return period).
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
