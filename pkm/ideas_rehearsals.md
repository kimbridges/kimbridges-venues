# Idea capture -- rehearsals before the field

_Captured 2026-09-27 (evening), at the close of the day tessellr 0.1.0 and *The Map That Never Got Drawn* were finished. Discussion between Kim and Claude._

_Status: CAPTURE ONLY. Formal Mechanism 1 intake -- venue / language track, `proj_*.md`, index row -- deliberately NOT done yet. Kim: "I think we're on to something good." Return to it next session._

## Where it came from

- **Koch_voronoi `phase1_report.pdf`** (Feb 2026, "Sensitivity Testing with Simulated Data"): six simulated runs, one seed each (674), Poisson test per cell + chi-squared. Purpose: people "don't meet reality unprepared."
- **Chapter 10 of the Voronoi book** ("Were they useful?"): learning to recognize when a technique such as Voronoi tessellation is useful.
- **Kim's field-cost point:** field sites are often far away and expensive to reach. Try the technique first, "just as you'd practice with a new digital camera." Finding an appropriate test location is the friction; understanding the technology before a real application "could have an immense payoff."

## The ladder (three rungs)

1. **Simulation -- truth known because you built it.** Learn what "nothing there" and "fooled by effort" look like.
2. **Practice site -- truth known because you know the place.** A botanical garden or large public park. When the map looks odd you can tell whether the map or the method is wrong (as Kim's knowledge of Kipuka Puaulu did the checking in the book).
3. **Field site -- truth is what you went to find.** Tools, choices and traps are already familiar.

## Simulations (extending Phase 1)

- Repeat each scenario many times (not one seed): hit rate and false-alarm rate.
- **"Nothing there"** calibration -- random points only; how often tiles get flagged anyway. *Kim likes this one.*
- **"Fooled by effort"** -- records piling up along trails / near access, read as richness. *Kim likes this one.*
- Other "ways reality fools you" candidates: rounded locations; a source sitting on a tile boundary; scale mismatch; wrong labels or real change.
- Proposed form: `simulate_*` helpers added to tessellr; start with the outbreak-source family (Koch).

## What makes a good practice site (lowers the friction)

- A mix of canopy (lawns, groves, shrub beds) so structure classes have something to separate.
- A published map of collections or zones -- plays the part of the 1974 map.
- Public observations (iNaturalist via GBIF) for the counting exercises.
- Roughly 20-200 ha: walkable in an afternoon.
- The Meta/WRI canopy map is global, so any candidate can be judged from home before choosing.
- O'ahu candidates to check: Ho'omaluhia, Foster Botanical Garden; Kapi'olani Park as a mostly-open contrast.

## Five exercises (an hour to an afternoon each)

- **A. At the desk (Ch. 3, 8).** Frame the park, `get_canopy_height()`, `structure_classes()`, decide where 12 points would go; compare the canopy map with what you know of the place.
- **B. A walk (Ch. 2, 8, 9).** Visit the points with a phone: location, category, reported GPS accuracy. Plain vs `constrained_voronoi()`; `map_agreement()` against the garden's own map. Rehearses releve placement, GPS precision, labels that disagree with canopy.
- **C. Counting and being fooled (Ch. 6 + simulation).** The park's iNaturalist records in `count_in_tiles()`; expect hotspots on paths / visitor center = effort, not richness. Then the same number of random points, many times: how often tiles are flagged when nothing is there.
- **D. Service areas (Ch. 7).** Entrances, parking lots or nearby gardens as sites; `weighted_areas()` with different weights.
- **E. Change (Ch. 8, 9).** Canopy map vs an older garden map or air photo; turn disagreements into "why?" questions.

**The extra payoff:** Exercise A works anywhere, so before a long trip run it on the actual field site -- see its structure, place the releves, estimate how many are needed. Learn the camera at home, then scout the location.

## Proposed form

- A short companion document, working title **"Rehearsals before the field"**: the simulations and the practice exercises together, each exercise written so a reader can repeat it with their own park. The Kipuka book is the method; this is the training.
- Simulation helpers go into tessellr (a 0.2.0).
- Shared authorship: K. W. Bridges and Claude (Anthropic).

## Next session (proposed, Kim to confirm)

1. Decide whether this becomes the new Active Focus (vs the trilogy).
2. Choose Kim's practice site (check canopy + available garden map + GBIF records for the candidates).
3. Decide the order: simulations first, or Exercise A at the chosen site first.
