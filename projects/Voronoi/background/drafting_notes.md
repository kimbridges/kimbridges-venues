# Drafting notes -- The Map That Never Got Drawn

_Started 2026-09-25 (evening). Working notes for the drafting sessions; the chapter plan of record is in
`Projects_Index/proj_Voronoi.md`._

## Status

| File | Chapter | Status |
|---|---|---|
| index.qmd | Preface | first draft 2026-09-25 |
| where_the_map_stopped.qmd | 1. Where the Map Stopped | first draft 2026-09-25 |
| what_is_a_voronoi_map.qmd | 2. What a Voronoi Map Is | first draft 2026-09-25 (code runs) |
| the_study_area.qmd | 3. The Study Area | first draft 2026-09-26 (code runs) |
| kinds_of_voronoi_maps.qmd | 4. Kinds of Voronoi Maps | first draft 2026-09-26 (code runs) |
| reading_the_cells.qmd | 5. Reading the Cells | first draft 2026-09-26 (code runs) |
| tiles_as_containers.qmd | 6. Tiles as Containers | first draft 2026-09-26 (code runs) |
| weighted_voronoi.qmd | 7. Weighted Voronoi | first draft 2026-09-26 (code runs) |
| adding_what_the_points_dont_know.qmd | 8. Adding What the Points Don't Know | first draft 2026-09-26 (code runs) |
| good_enough.qmd | 9. Good Enough? | first draft 2026-09-26 (code runs; releve curve ~6 min, cached) |
| were_they_useful.qmd | 10. Were They Useful? | first draft 2026-09-26 (code runs) |

Whole book renders clean 2026-09-26 (11 pages). Full render from a background job needs `quarto::quarto_render(input = ".")`; with no input it fails at once.
Point labels (R01-R12) added 2026-09-26 at Kim's request: Ch.2 relevetiles; Ch.3 edgemap, waymap1, waymap2; Ch.5 bandmap; Ch.6 specimenmap (tile labels); Ch.8 canopymap, structuremap, extendedmap; Ch.9 linesmap (Ch.4 namedmap and Ch.8 comparemaps already had them). Backups of the pre-edit qmds in C:/temp/mwt_prototype_2026-09-25/backup_labels_2026-09-26. Full renders: use quiet = FALSE (quiet = TRUE fails from a background job).

## Kim's conclusion for the document (2026-09-26) -- THE ANSWER to 'good enough?'

Kim, verbatim: "Somewhere, we need to record that Voronoi Tessellation maps aren't good enough. But, like so many other things,
we can combine this technology with other data. Then the maps are useful. They are then good enough. Part of their utility is that
they are reproducible, a quality that the hand drawn maps often disguised. Now, where the map doesn't match what we see, we can ask
'why?'. And that may lead us to new data sources. Here, we found that canopy data made a significant difference to our mapping. Many
people are likely unaware of the canopy data resource. But it is, indeed, a useful source of information. As a result, this study has
likely introduced both a methodology and a data source. Both are good."

Kim, 2026-09-26 (for Ch.10): plain Voronoi is sometimes very useful, even essential, when the exact position of boundaries
isn't critical -- a quick map narrows the source of a contaminated food, tests a new school's location. Other times the job is
an archive for future analysis: digital format + metadata for unambiguous interpretation. Voronoi tessellations meet both needs.
-> Ch.10 sections 'When plain is enough', 'Maps as archives' (GeoPackage + metadata demo).

Placement: Ch.9 *Good enough?* ends on the verdict -- plain Voronoi alone: not good enough; combined with other data (canopy height):
good enough; reproducible where hand-drawn maps hid their judgments; mismatches become 'why?' questions that lead to new data.
Ch.10 *Were they useful?* opens from it: the study offers two things, a methodology (structure-constrained Voronoi) and a data
source (the Meta/WRI canopy height map, little known in these fields), then goes field by field.

## Rulings carried into the drafts

- Title: *The Map That Never Got Drawn* (Kim, 2026-09-25). Chapter 1 retitled "Where the Map Stopped" so it doesn't
  repeat the book title.
- Opening (Kim): a simple Voronoi map, then the hand-drawn map, then the question -- left unanswered as tension.
- Organising question: are Voronoi tessellations useful in the research fields I inhabit?
- "I didn't see them", not "nobody used them".
- Reproducible, not objective.
- Arnold & Milne 1984 as a running benchmark.
- Minimum mapping unit for this area: 2 ha (Kim, 2026-09-25) -- for the later chapters.
- Colors: Okabe-Ito, mapped to the five vegetation groups in `veg_colors` (setup chunk, Chapter 2).

## Questions for Kim (also left as `<!-- KIM: -->` comments in the .qmd files)

- ~~Ch.8: R01 / R04-R05~~ ANSWERED 2026-09-26: R04/R05 in the Broomsedge burn, near or inside the koa outplanting area; R01 possibly the 1975 fire near Kipuka Ki (no burn map to confirm). In the text.
1. ~~Chapter 1: decade, article, languages~~ ANSWERED 2026-09-25: the 1984 article (Arnold & Milne) is when Kim became
   aware; the code was FORTRAN "if memory serves", converted toward BASIC.
2. ~~Same article as Arnold & Milne?~~ ANSWERED: yes, awareness began with the 1984 article.
3. Preface: acknowledgements and the permission note for the 1974 map.

## Kim's notes, 2026-09-25 (night)

- Add "ethnobotany" to the disciplines. **The first readers will be ethnobotanists**, and Kim is considered a worker in
  that discipline. (Preface gains an ethnobotany paragraph; Ch.1's field list; Ch.10 should test it.)
- US spelling: "color", not "colour" (applied throughout, with neighbor and center).
- Johnston et al. 1996 (Pokegama River wetland, Wisconsin): from Kim's files, "probably wasn't too important to me at
  the time." Cited in Ch.1 as evidence the method did reach vegetation mapping; its 52% comparison with airborne-video
  classification is held for Ch.9 (compare our 45-56%). Note: the abstract says 60% -- that is the video
  classification accuracy; the Thiessen-vs-video correspondence in the body is 52%.

## Kim's location story (2026-09-25, night) -- ADDED to Ch.1 'The friction is gone' 2026-09-26

Kim, verbatim: "If you were in the deep vegetation of Kipuka Puaulu, how would you know where you were (in those days
without GPS)? Having to remember to set your barometric altimeter each morning at base station, then trying to find your
location on a topo sheet, was a lot of friction. Even with the best of intentions, locations were pretty inaccurate except
when they were near roads or similar physical structures."

Not yet in the draft. It is the personal version of Johnston's fourth friction and belongs beside it -- and it bears on the
1974 map too: relevé locations of that era were only as good as the altimeter and the topo sheet.

## Kim's notes, 2026-09-26

- Ch.3: "An ahupuaʻa is a great example of a boundary. These were important border lines to the Hawaiian culture. Even today,
  we're marking them in the neighborhoods." (Added to Ch.3.)
- Ch.3: tracing the kipuka from canopy height "is exactly what would have been done manually." (Added to Ch.3.)
- Ch.3: "This is a very important chapter. It is easy to neglect this detail or consign it to a footnote. You've elevated it
  to the right level."
- Ch.4: "excellent. It makes the points without spending too much time. The maps are very supportive. This is exactly
  the style that's needed." -- keep this register for later chapters.
- Ch.7: "Showing 'unusual' or 'unexpected' ways to look at data is part of what we're doing. One message is that data
  exploration has a new tool." Five LA basin gardens are the ones Kim has visited and photographed (photo essays).

## Data added 2026-09-26

- `data/kipuka_puaulu_specimens.csv` -- 164 flowering-plant herbarium specimens with coordinates (GBIF preserved specimens,
  2 km around 19.437 N 155.296 W, accessed 2026-07-05; deduplicated one sheet per gathering) from `Projects/checklists/kipuka_puaulu`
  (specimens + dedup files); georeference 'rounded' = nominal >=~1 km rounding per the R1 place-at-scales analysis (93 rounded,
  71 precise); status from the checklist (21 unmatched = 'unknown').
- Kim's ruling (Ch.6): herbarium records, not invasives, as the counted example -- ties to the checklist / Briefing Books
  study, and 'isn't likely to be what people would think about. That's why it is more important here as the example.'
- `data/kipuka_puaulu_outline.geojson` -- kipuka outline: smoothed canopy height > 8 m (25 m window), 4-connected patch
  containing R11, 20 m buffer out and back in, exterior ring only (glades filled); 94.5 ha. Derived in the R session from the prototype's
  canopy raster (`prototype/prototype_objects.rds`); the full derivation belongs in Ch.8. Points inside: R09, R11, R12.
- `data/la_gardens.csv`, `data/la_land_frame.geojson`, `data/la_tracts_2020.csv` (Ch.7) -- made by `R/make_la_gardens_data.R`:
  acres from Wikipedia; locations from Nominatim (Arboretum from Wikipedia coords); Wikipedia pageviews 2024 (user agent);
  land frame = 5 counties (cb 2020) clipped to -118.75/33.55/-117.45/34.45; 3,207 tract points (P1_001N, point on surface), 13,769,096 people.
  Attendance in the text: Arboretum 572,964 (FY2022-23 annual report); Huntington 1,014,000 (2022, whole institution; Wikipedia).
  The Huntington pageviews are for Huntington_Library (whole institution) -- said so in the text.
- `data/kipuka_puaulu_canopy_height.tif` (Ch.8) -- made by `R/make_kipuka_canopy_data.R`: Meta/WRI 1 m canopy height, tile
  022300033 via /vsicurl, averaged to 5 m on the study-area grid, rounded to 0.1 m (matches the prototype's chm5 within 0.1 m).
  Ch.8 re-derives the kipuka outline from it (94.5 ha; differs from the stored outline by 0.03 ha).
- Ch.8 settings: smooth 25 m; breaks 2/5/10 m; MMU 2 ha (Kim's ruling 2026-09-25) on the classes AND on the output map.
  Result: plain vs constrained differ on 51% of the area; 141 structure patches; 11% of the area in patches with no point.
  Two labels contradict today's canopy: R01 (1974 koa-ohia forest; 0.7 m) and R12 (1974 grass and savanna; 11.6 m).
- Ch.6 wording fixed 2026-09-26: R12 is 'in what the 1974 map shows as one of its grassy openings' (today ~12 m canopy).
- `data/mdf1974_classes.tif` + `data/mdf1974_classes.csv` (Ch.9) -- made by `R/make_mdf1974_data.R` from expert_map/*.asc: 1974 classes
  on the 5 m study grid (OHD -> WGS 84 by PROJ); Kipuka Ki region (900003) masked, 4,645 cells. Five classes occur in the window.
- Ch.9 results (twelve points, Ch.8 settings): area agreement plain 45% / constrained 56%; 1974 boundary found within 50 m 17% / 58%;
  constrained draws ~107 km vs the 1974 map's ~51 km, 54% of it on a 1974 line. Changed ground (1974 forest on open today, or grass/savanna
  under woodland/forest) = 15% of the area, ~23% of the disagreement; constrained agreement 60% on stable ground, 33% on changed.
  Releve curve (seed 20260926, 20 tries): stratified 12 pts constrained 66% vs plain 53%; random: no gain, plain >= from ~24.
  The book's twelve points are a below-average draw (56% vs median 66%). Johnston 1996: 52% 'good correspondence', ~60% accuracy.
- Kim's history for Ch.8 (2026-09-26): Loh et al. 2007 (PCSU Tech. Rept. 147, Broomsedge Fire, 30 June 2000, 1,008 ac east of the
  kipuka, within 50 m of the Kipuka Puaulu SEA; koa reformed canopy in pastures abandoned after cattle left) and Stone & Pratt 1994
  (cattle to 1948, goats fenced 1970s, pigs mid-1980s, 1975 fire above Kipuka Ki). Both in references/. Kim visits the burn yearly:
  'the regrowth has been quite amazing'. Kim: 'significant change between 1974 and the present, much of which is visible in the areas
  surrounding the kipuka.' Ch.8 now reads the R12/R08 mismatches as 1954 names on today's canopy. CARRY INTO CH.9: the 1974
  comparison measures change as well as method.
- Kim's principle (2026-09-26): 'Data examination should not be the endpoint for a dynamic system. Like any good science, results
  should provoke new questions. Here, we have a chance to sharpen the questions.' Ch.8 now ends its label section with four
  sharpened questions (1975 burn at R01; pasture in today's outline; Broomsedge regrowth rate; which points need new releves).

## Verify before publishing
- Ch.10: John Snow 1855 -- the dotted line of equal distance 'by the nearest road' from the Broad Street pump and the surrounding
  pumps (Cholera Inquiry Committee report / 2nd ed. of On the Mode of Communication of Cholera); confirm wording and source.
- Ch.10: KIM comment -- optional sentence on Kim's epidemiological clustering work with Tom Koch.
- Ch.8: canopy height source -- Tolan et al. 2024, Remote Sensing of Environment 300:113888 (Meta/WRI); release year and
  image dates for this tile. Arnold & Milne paraphrases (topographic features overwrite the mosaic; surveyor polygons for
  hilly soils; Holmes' plastic merge) checked against the PDF 2026-09-26.
- Ch.5: random-points reference for the coefficient of variation of tile area. The text reports our own trials (20
  sets of 150 random points: 0.43-0.63); the textbook value (~0.53, Gilbert 1962) is not cited yet.
- Ch.5: plant-competition use of tiles as 'area potentially available' (Brown 1965; Mead 1966) -- stated without citation;
  confirm and cite, or soften.
- Ch.7: attendance figures -- Arboretum 572,964 (Los Angeles Arboretum Foundation 2022-2023 annual report) and
  Huntington 1,014,000 (2022, via Wikipedia); confirm against primary sources and cite. Garden acreages (Wikipedia) likewise.

- Dirichlet 1850, Voronoi 1908, Thiessen 1911 (Monthly Weather Review) -- names and years as stated in Chapter 2.
- Arnold & Milne figures (656 points, 1,969 edges, 54 polygons, 14 types; 50-200 m; ~5,000 points; Benson 1302;
  Grinnell; Green & Sibson via Titcombe) -- checked against the PDF 2026-09-25.
- 1974 map facts (Fosberg indoors from 1954 photos; Mueller-Dombois field check 1965; Nakata transfer) -- checked
  against the report 2026-09-25.

## Figures

- `images/ch1_voronoi_kipuka.png` -- made by `R/fig_ch1_voronoi.R` from `data/` (same steps as Chapter 2).
- `images/ch1_mdf1974_kipuka.png` -- crop of Kim's sheet-12 composite (overlay + topographic base), 904 x 638 px.
