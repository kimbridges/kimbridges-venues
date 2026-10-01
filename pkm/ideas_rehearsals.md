# Idea capture -- rehearsals before the field

_Captured 2026-09-27 (evening), at the close of the day tessellr 0.1.0 and *The Map That Never Got Drawn* were finished. Discussion between Kim and Claude._

_Status: CAPTURE ONLY -- now the Active Focus (2026-09-29); formal Mechanism 1 intake (venue / track, `proj_*.md`, index row) NOT done yet. Grown 2026-09-29 with Kim's focus ruling, five example ideas, draft text on AI and borders, a 15-item cautions checklist; evening: choropleth vs tessellation, chapter title 'the least information, the most color', vocabulary, street-map overlay (Skyline), sprinklers vs traps, points and their service areas, SCALE as a theme._

## ★ FOCUS OF THE COMPANION DOCUMENT (Kim's ruling, 2026-09-29)

- **"Training before the trip"** is the key to the focus.
- Training has two parts: **having the concepts**, and **actually being able to use them**.
- The training is, in part, **a gallery of examples**. "An example has value when it tells us what we will learn from the way it is portraying the data."
- It changes the focus **from "I can make this kind of map" to "from this kind of map, I can learn ..."**
- **"What we can't learn is also needed."**

_Claude's proposal for a gallery entry (not yet ruled):_ 1. the question in plain words; 2. the data and where the points and the border come from; 3. the map; 4. **From this map you can learn** (2-4 statements, each checked against the map); 5. **From this map you cannot learn** (2-4, each with what WOULD tell you); 6. the cautions that apply (numbers from the checklist); 7. try it yourself (the tessellr lines, and how to swap in your own place).

_Worked sketch -- drought tiles from rain gauges:_ **can learn** which gauges' areas are in drought this month; how much of the island each drought class covers, as the tiles define it; how coverage changed as gauges closed (tile sizes then vs now). **Cannot learn** where the drought edge really runs (halfway lines ignore mountains -- needs terrain-constrained tiles or the gridded maps); whether then-vs-now is climate or network (needs the same gauges in both periods); anything between gauges in a tile the size of a mountainside. Cautions 9, 10, 11.

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

## Example idea: campsites in a purchased forest (Kim, 2026-09-29)

_Recorded as an idea for an example; nothing to build yet (Kim)._

- **Setting:** you have bought a square patch of forest -- a fairly dense stand of conifers -- and want to cut clearings for camping. The square is the purchased plot, so the frame is a real boundary, not a convenience.
- **What campers want:** not too close to each other; more trees around the site is more desirable; larger areas are preferred.
- **Who controls what:** site placement is under the user's control; the tree distribution is generated (random, clustered, etc.).
- **What to look at:** place sites, then examine the statistics -- area per site, trees per area, and so on.
- **Why it fits:** a plausible real-world problem that sits neatly inside a square.

_Claude's notes (not ruled):_ it sits between rung 1 and rung 2 -- the trees are simulated (known truth) but the decisions are the reader's, so it teaches judgment rather than detection. Maps onto tessellr directly: sites -> `tile_points()` in the square; `tile_measures()` for area, nearest border (how close is the neighbor), shared border; trees -> `count_in_tiles()` for trees per site against area-expected; `tile_pattern()` to show whether the site layout is even. Natural comparisons: the same sites under random vs clustered trees; a grid layout vs sites chosen by the reader; moving one site and watching its neighbors' areas change.

## Draft text: can AI help find borders? (2026-09-29 -- Kim: "EXACTLY what we're after", a key chapter)

_Kim's question: points and borders are the basis of everything; can AI help find borders? Example: the border of the urban core of Honolulu. Manual tracing is a friction point, and quick tests need borders fast. Claude's reply, kept as draft text:_

> The urban core of Honolulu has no single right border; it's a definition waiting to be chosen. That makes it the Chapter 3 lesson again, with a city in place of a kīpuka. AI can help in three ways, and the third matters most.
>
> **1. Finding borders someone has already drawn.** Several official ones exist, each with its own idea of "core": the Census "Urban Honolulu" place (large, running roughly from the airport area to the east end of the island); the City's Primary Urban Center planning area (Kahala to Pearl City); smaller districts such as the Kakaʻako redevelopment district, or Downtown and Chinatown zoning. These can be fetched in minutes (census through `tigris`; the others from the City's open GIS portal or OpenStreetMap). Comparing them shows how much the answer depends on who drew the line.
>
> **2. Deriving a border from a rule and public data.** This is `trace_patch()` with a different map. Kīpuka Puaulu was "smoothed canopy height over 8 m, connected to a seed point". The urban core could be "building coverage over X% within 250 m, connected to Downtown", or tall buildings, or pavement. Building footprints with heights, and land-cover maps of pavement and roofs, are public and cover Oʻahu. Such a border is reproducible and says what it assumes, which is the book's argument.
>
> **3. Doing the work that makes it a quick test.** Hand tracing is slow, and it hides judgment the way the 1974 map did. An AI assistant takes the friction out: it finds the data, writes the rule, runs it, and redraws at a new threshold in seconds. You still make the call ("that's not the core, move the line"). You just no longer need the pen.
>
> What to avoid: having AI draw the line from general knowledge ("the core is Downtown, Kakaʻako, Ala Moana and Waikīkī") or from reading an air photo. It would look authoritative, but **it's a hand-drawn map in disguise**, with the rules unstated.
>
> Points to go inside, once there's a border: Skyline rail stations, as service areas by walking distance, like Snow's pump line; parks or schools, as containers counting people from census blocks, like Chapter 7; the City's street-tree inventory, if it's public, for a species-mix exercise at home.

- Kim (aside): a Skyline station is being built one block from his window -- the walking-distance example is literally close to home. Candidate opening.
- Proposed quick test (not yet run): three borders on one map -- census place, planning area, one traced from building density -- with the area of each and which Skyline stations fall inside.

## Idea: botanical gardens as test cases (Kim, 2026-09-29)

- Kim and Nancy have visited many botanical gardens worldwide. A garden usually has a **map divided into units**, and a visit produces **cell-phone photos -- georeferenced images showing vegetation structure at a point**.
- Kim: "It sort of looks like releves, the M-D/Fosberg map and Kipuka Puaulu."

_Claude's notes (not ruled):_ the parallel is exact -- photos = releves (location + what grows there), garden map = the 1974 map (units drawn by someone else, with unstated rules), canopy height map = structure. **The data may already exist:** past visits in Kim's photo archive carry GPS in EXIF, so the practice site needs no trip. Built-in lessons: photos cluster along paths ("fooled by effort" for real); phone GPS error under canopy (5-20 m) against small garden units (the Ch.6 pile-up rule); a photo shows what's in front of the camera, not at the point (EXIF heading helps); photo-taking is preferential sampling, like the 1974 releves placed on mapped units. Friction to solve: georeferencing the garden's map (control points on paths/buildings matched to OSM or imagery -- AI can propose them, the reader checks).

## Idea: rainfall and drought (Kim, 2026-09-29)

- Kim: Voronoi tessellations are associated with rainfall data (Thiessen 1911). Tie climate -- drought in particular -- to areas as a category, or a series of categories showing different dimensions of the phenomenon. Historical vs current as another dimension. "Could be quite a powerful demonstration."

_Claude's notes (not ruled):_
- **Origin story:** Thiessen's polygons were invented for exactly this (averaging rain gauges); the book already cites him. The rehearsal returns the method to its home ground.
- **Categories, several dimensions from one set of tiles:** per-gauge drought class for a month (e.g. SPI normal / moderate / severe / extreme); duration (months in drought); frequency over decades; trend. Same tiles, several maps -- Kim's 'series of categories'.
- **Historical vs current has TWO changes in it:** the climate, and the gauge network. At least 2,354 stations have operated in Hawaii since 1838; 398 were active in early 2017. HC&S alone ran 100+ gauges in central Maui (1931-2016) and stopped when sugar ended (Sci. Data 2018, 'Compilation of climate data from heterogeneous networks across the Hawaiian Islands'; authors to confirm). As gauges close, tiles grow: some of 'then vs now' is the network, not the rain. `tile_measures()` shows it directly. Strongest lesson in this example.
- **Where plain Voronoi fails in Hawaii:** rainfall changes over a few km with elevation and windward/leeward exposure; a Hilo gauge's tile reaching up Mauna Kea is plainly wrong. Same move as Ch.8: constrain the tiles by what the points don't know (elevation band, exposure) -- rainfall's 'canopy structure'.
- **The expert map exists:** the Rainfall Atlas of Hawaii and the monthly gridded maps 1920-present (Frazier et al. 2016; Lucas et al. 2022; UH Hawaii Climate Data Portal) play the part of the 1974 map; `map_agreement()` applies.
- **A hand-drawn map, openly:** the US Drought Monitor (covers Hawaii) is drawn weekly by expert authors blending indicators and local reports -- judgment acknowledged rather than disguised. Worth a side-by-side with a rule-based tile map. (Check its methods page before writing.)
- **As a rehearsal:** pure desk work, public data, no trip; teaches network change, thresholds-as-judgments, and when the method is out of its depth.

## Kim's notes (2026-09-29): data coverage, and supplement vs replace

- **Coverage (Kim):** in the past Kim looked at the distribution of METAR stations when trying to predict the climate of a study site some distance away. "Using tiles to show the extent of data coverage is what I needed when I did that before."
  - _Claude:_ a tile map of stations is a coverage map. Drop the study site in: which station's tile holds it, how far to that station, how far to the tile's farthest border (the worst case in that tile), and how different the second-nearest is. Caution: the nearest station can be the wrong station (elevation, exposure) -- distance is not similarity.
- **Supplement, not replace (Kim, a reflection -- possibly the document's through-line):** "There was a time, years ago, that all we had were traditionally-created vegetation maps. Then we got satellite images, and people said that spectral analysis was the replacement technology. I was skeptical as the proper determination of the vegetation at a site needed both the canopy and below-canopy plants. Satellites just saw the canopy. A lot of effort went into spectral analysis. Some of it was very valuable, of course. But it didn't really replace the releve data. With the canopy height data, we're supplementing the releve data, not trying to replace it. And that supplement is, in many ways, more useful for our mapping than the spectral data. I think particularly about how maps based on spectral data often have way too many small units. They are, in my view, failing to scale properly. That's why I was really excited to see the power of canopy height."
  - _Claude:_ (1) This is the 2026-09-25 reframe stated as history: an expert map has two inputs, releves for categories and imagery for boundaries. (2) Our own run showed the scaling problem too: the constrained map drew 137 km of boundary vs the expert's 51 km until smoothing + a 2 ha MMU -- scale is a choice the map must state. (3) Why height scales better than spectral values (hypothesis): height is a structural quantity, fairly steady within a stand and stepping at stand edges; spectral values vary crown by crown with species, shadow, sun angle and season, so pixel-level classification speckles. (4) The same pattern applies to AI: announced as a replacement, most useful as a supplement that removes friction (finding data, running rules) while the judgment and the releve stay with the person. A rehearsal is how you find out which a new technology is -- Ch.10's question, asked before the trip.

## Idea: a tessellation is not a choropleth (Kim, 2026-09-29)

- Kim: someone may confuse a choropleth map with a tessellation. Both use boundaries, but in very different ways; the ID assignments are very different too. A superficial viewing of a tessellation might confuse a viewer more familiar with choropleth maps. Is an example that emphasizes the difference useful?

_Claude's notes (not ruled):_

| | Choropleth | Tessellation |
|---|---|---|
| What comes first | the boundaries (counties, tracts) | the points |
| Where boundaries come from | given, drawn for other purposes | computed from the points (halfway lines) |
| Whose ID a polygon carries | the unit's (a FIPS code) | the point's (a gauge, a releve) |
| What the color claims | a summary of everything inside the unit | the value measured at one spot, extended by assumption |
| Add or move data | boundaries stay put | neighboring boundaries move |
| A big polygon means | a big unit (often rural, few people) | sparse sampling -- where we know the LEAST |

- **The sharpest trap:** in both maps big polygons pull the eye. In a choropleth that is a known distortion (big empty counties); in a tessellation it is worse -- the largest tiles carry the least information and the most color.
- **Visual cues that tell them apart:** straight edges meeting three at a time; one point inside each polygon; edges that are perpendicular bisectors of point pairs. Remedy: always draw the points; say "value at the point" in the legend; consider fading tiles by size or by distance to the point.
- **Where they meet:** tiles used as containers (Ch.6) ARE a choropleth with computed boundaries -- counts summarized over the tile. Same polygons, two different claims, depending on whether the color comes from the point or from what's inside.
- **A gallery pair:** the same rain gauges shown both ways -- (a) district mean rainfall as a choropleth; (b) Thiessen tiles colored by each gauge. Same data, same palette, different claims. Exercise: hide the points and ask which is which; then reveal the cues. Can learn / cannot learn written for each.
- **Trilogy:** MWT ch.2 (the familiar maps, each with its boundary source) -- choropleth = given boundaries, tessellation = computed; MRC backbone (where boundaries come from).

## Kim's notes (2026-09-29, evening): a chapter title, descriptive discipline, and a street-map overlay

- **Chapter title candidate (Kim):** a form of "the least information and the most color".
- **Descriptive discipline (Kim):** use terms consistently -- e.g. "value at the point" every time. _Claude: start a short vocabulary for the document and hold to it:_ **tile** (never zone / region / district, which suggest a unit); **point** or the thing it is (gauge, releve, station); **value at the point** (never "the tile's value" unless it was counted inside the tile); **frame** (the study-area border); **computed boundary** vs **given boundary**; **counted in the tile** for container use.
- **A street-map overlay demonstration (Kim):** use the tessellation as an overlay on a familiar map, such as a simplified street map. "People need to get oriented and street maps are a familiar tool."
  - _Claude:_ tiles as outlines (or a very light fill) so the streets stay readable; points drawn and labeled; a simplified base -- coastline, main roads, a few landmarks (OpenStreetMap, attribution required).
  - The overlay makes the reader a checker: "my house is in this station's tile, but I'd walk to that one" -- truth known because you know the place (rung 2).
  - It also exposes the limit at once: straight halfway lines cut across blocks, freeways and streams that no one walks across -- the step to walking distance (Snow's line, Ch.7 travel time).
  - Natural first case: Skyline stations over a simplified Honolulu street map, one block from Kim's window.

## Idea: lawn sprinklers, all equal (Kim, 2026-09-29 evening) -- and color

- **Color (Kim):** the overlay brings in the choice of colors -- a topic Kim is very interested in. To be treated deliberately, not as decoration.
- **Skyline (Kim):** agrees the stations make the right points; he has not seen such a map.
- **Sprinklers (Kim):** "something very mundane" -- the locations of lawn sprinklers, all assumed equal. Is that interesting?

_Claude's notes (not ruled):_ yes, because the tile model and the physics disagree in instructive ways.
- **What the tiles get right: the gaps.** The corners of the tiles (Voronoi vertices) are the places farthest from every sprinkler -- where a dry spot appears first. The farthest-border distance in `tile_measures()` is each sprinkler's worst-covered spot; compare it with the throw radius and the dry spots are predicted. (The 'largest empty circle' problem.)
- **What the tiles get wrong: overlap.** A tile gives each place to exactly one source; a sprinkler throws a circle, and good irrigation design spaces heads so each throws to the next ('head-to-head'), so most ground gets water from two or more. The tile is a claim of exclusive service that the water does not honor.
- **An assumption made visible:** if each sprinkler's water is spread over its own tile, small tiles are over-watered and large ones dry -- wrong physics, but it shows what the halfway rule implies.
- **The truth is measurable at home:** a catch-can test (cups on a grid, run the system, measure) or simply the brown patches in August. Rung 2 with a real experiment in one's own yard.
- **Unequal heads** (different nozzles / radii) lead to weighted tiles (Ch.7).
- **A color lesson:** with all sprinklers equal, the tile colors carry no data -- they only separate neighbors (a map-coloring problem; four colors always suffice). Color should be quiet here, and it should be obvious that it means nothing. Contrast with maps where color IS the value at the point.

## Kim's notes (2026-09-29 evening): points and their service areas; SCALE as a theme

- **Sprinklers = insect traps in reverse (Kim).** Color can show the areas receiving relatively more or less water. "It's not a great model but it shows that you can do first approximation work quickly."
- **The general idea: points and their service areas (Kim).** Seeing sprinklers beside traps, people should see the similarity and develop a sense of a general application. "Then, when we do counting in service areas, the user will be half way there conceptually."
- **Scale might be a theme (Kim):** lawns are small; insect collections larger; pharmacy or market service areas large.

_Claude's notes (not ruled):_
- **Sprinkler color, computed:** equal output spread over each tile -> relative water = mean tile area / tile area. One sequential palette, low to high; the smallest tiles are the wettest.
- **Two directions, one tile:** SOURCES that send something out (sprinklers, pharmacies, markets, stations) and COLLECTORS that take something in (traps, rain gauges, releves as samples). Same geometry; the tile is a service area for a source and a catchment for a collector. Vocabulary to settle.
- **A scale ladder as the gallery's spine:** lawn (meters) -> garden (hundreds of meters) -> kipuka / trapping grid (kilometers) -> city, Skyline and pharmacies (tens of km) -> island rainfall (100 km). The same operation at each rung.
- **What changes with scale** (so the cautions move with it): location error that ruins a lawn map is irrelevant for pharmacies (caution 3); straight-line distance is fine on a lawn, wrong in a city (streets) and on an island (terrain) (cautions 10, 13); what 'the value at the point' means stretches as tiles grow (caution 15).
- **Trilogy:** scale is already S3's opening reframe (the scale between weather and climate); here it is spatial -- a candidate thread across all three.

**Kim's ruling (2026-09-29, close): scale runs through everything** -- a theme of the companion document (and a candidate thread for the trilogy). Kim will start gathering materials (e.g. garden maps) so the ideas can be tried.

## TEST CASE 1: The Huntington, from Kim's photo archive (2026-09-30)

- **Kim's materials:** the Huntington visitor map (construction-detours edition, June 2026, PDF) and a folder of 38 photos from several visits (2018-2025; phones Pixel 2 XL to Pixel 10 Pro XL, one iPhone, one Sony). Kim: a mixed set covering much of the garden; "I'm not sure all of this will work, but put these in as a test case." The photo title tells generally which part of the garden was photographed.
- **What the archive holds:** GPS in all 38 (two downloaded copies keep GPS but lost their dates); compass heading in 30; a title (EXIF Description) in 31, 7 untitled. All 38 fall inside the OSM boundary of the Huntington (84.6 ha).
- **Reference map found:** OpenStreetMap has the boundary and 22 named units (Japanese, Chinese, Australian, Subtropical, Palm, Jungle, Rose, Herb Garden, ...) -- but NOT the Desert Garden or the Lily Ponds. The visitor map names them but is pictorial, not to scale.
- **First map** (`huntington_tiles_v1.png`): photos as points, plain tiles trimmed to the boundary, colored by Claude's grouping of Kim's 17 titles into 8 garden areas + untitled.
- **What it shows at once:** (1) **the least information, the most color** -- tiles range 0.33 to 14.5 ha (44x); two Mausoleum photos and the Entrance photos color the whole north (parking, nonpublic land) red. (2) The frame is a choice -- the OSM boundary includes parking and nonpublic land (Ch.3). (3) Effort -- 8 Japanese Garden and 7 Desert Garden photos vs 1 Chinese Garden photo that claims the whole northwest. (4) Untitled photos leave gray holes -- unknown is a category. (5) Label vs place: one 'Japan' photo (Sony, Dec 2019) falls inside the OSM Chinese Garden; 'Australia Lawn' and 'Conservatory' photos sit outside their OSM polygons (taken from beside them, or a camera that borrowed a phone's GPS).
- **Kim on the first map:** "This actually does quite well. Better than I expected. This is what a 'quick look' should produce." Areas properly located; the two best-photographed areas (Japanese, Desert) come out well; "Mostly, I know where I'd take more photos to improve the resolution"; shows the more-color, less-information relationship well.
- **Photos only, no map (Kim's question):** frame = tessellr's default box around the photos (58.1 ha) vs the OSM garden boundary (84.6 ha). Overlap 54.1 ha; the box leaves out 30.5 ha of garden (the north, the west edges) and takes in 4 ha of street (east). **Inside the overlap every tile is identical -- the frame only cuts.** 21 of 38 tiles keep their area exactly; the 17 edge tiles change. Largest tile falls from 14.5 to 5.5 ha (range 44x -> 17x), so the photos-only map LOOKS more even -- because the samples drew their own frame (circular: a frame of convenience flatters the sampling). Shares shift with the edges: Other 39% -> 28%, Chinese 10% -> 4%, Desert 8% -> 17% (its east tiles run into the street). Lost without the map: orientation (paths, units) and any check of label vs place. Figure: `huntington_photos_only_v3.png`.

- **Kim on the photos-only comparison:** "Well, that was worth doing. It doesn't address the same concerns as the vegetation map boundaries, but that's OK." (The garden test is about frames, effort and labels; boundary placement between units is the Kipuka question.)
- **Working files:** `C:/temp/rehearsals_huntington_2026-09-30/` (photo table CSV, OSM extract, objects RDS, figure) -- scratch until the project has a home on G:.

_Trilogy links (2026-09-29): each idea above is mapped to the trilogy's documents and spines in `ideas_three_documents.md`, section 'Rehearsals ideas that argue for the trilogy'._

## Cautions checklist (running; Kim: "a checklist of things where you need to be careful")

_Collected from the examples so far; each item names where it shows up._

1. **Effort looks like signal** -- records pile up on trails, paths, famous plants (iNaturalist in parks; garden photos). ['fooled by effort'; Ch.6]
2. **Nothing there can still look like something** -- random points flag tiles too; calibrate with simulations. ['nothing there']
3. **Location error vs tile size** -- phone GPS 5-20 m under canopy; garden beds can be smaller. [Ch.6 pile-up rule; gardens]
4. **The frame is a choice** -- the urban core has several official borders; a purchased square is a real one. [Ch.3; Honolulu; campsites]
5. **A border drawn from general knowledge or by eye is a hand-drawn map in disguise** -- state the rule. [AI borders]
6. **What the camera sees is not what is at the point** -- photos look outward; use heading. [gardens]
7. **Preferential sampling** -- photos, 1974 releves placed within mapped units. [gardens; Ch.9]
8. **Someone else's map has unstated rules** -- garden unit maps, brochure maps not to scale; georeference and check. [gardens; Ch.9]
9. **The network changes, not only the phenomenon** -- closed gauges enlarge tiles; separate network change from real change. [rainfall]
10. **The points don't know the terrain** -- orographic rainfall, canopy structure; constrain the tiles. [rainfall; Ch.8]
11. **Thresholds are judgments** -- drought classes, canopy breaks, building-density cut-offs; write them down. [rainfall; Ch.8; urban core]
12. **A reference map is dated, not an answer key** -- disagreement can be change. [Ch.9; rainfall atlas]
13. **The nearest station can be the wrong station** -- distance is not similarity; check elevation and exposure. [METAR coverage; rainfall]
14. **Scale is a choice the map must state** -- pixel classifications over-split; smoothing and an MMU set the scale. [spectral maps; Ch.8-9 MMU]
15. **A tile is not a unit** -- its color is one point's value, not a summary of the area, and the biggest tiles are where you know least. [choropleth vs tessellation]

## Proposed form

- A short companion document, working title **"Rehearsals before the field"**: the simulations and the practice exercises together, each exercise written so a reader can repeat it with their own park. The Kipuka book is the method; this is the training.
- Simulation helpers go into tessellr (a 0.2.0).
- Shared authorship: K. W. Bridges and Claude (Anthropic).

## Next session (proposed, Kim to confirm)

1. Decide whether this becomes the new Active Focus (vs the trilogy).
2. Choose Kim's practice site (check canopy + available garden map + GBIF records for the candidates).
3. Decide the order: simulations first, or Exercise A at the chosen site first.
