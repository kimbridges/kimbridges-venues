# Drafting notes -- The Map That Never Got Drawn

_Started 2026-09-25 (evening). Working notes for the drafting sessions; the chapter plan of record is in
`Projects_Index/proj_Voronoi.md`._

## Status

| File | Chapter | Status |
|---|---|---|
| index.qmd | Preface | first draft 2026-09-25 |
| where_the_map_stopped.qmd | 1. Where the Map Stopped | first draft 2026-09-25 |
| what_is_a_voronoi_map.qmd | 2. What a Voronoi Map Is | first draft 2026-09-25 (code runs) |
| -- | 3. The study area | not started |

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

## Kim's location story (2026-09-25, night) -- for Ch.1 'The friction is gone', near the Johnston GPS passage

Kim, verbatim: "If you were in the deep vegetation of Kipuka Puaulu, how would you know where you were (in those days
without GPS)? Having to remember to set your barometric altimeter each morning at base station, then trying to find your
location on a topo sheet, was a lot of friction. Even with the best of intentions, locations were pretty inaccurate except
when they were near roads or similar physical structures."

Not yet in the draft. It is the personal version of Johnston's fourth friction and belongs beside it -- and it bears on the
1974 map too: relevé locations of that era were only as good as the altimeter and the topo sheet.

## Verify before publishing

- Dirichlet 1850, Voronoi 1908, Thiessen 1911 (Monthly Weather Review) -- names and years as stated in Chapter 2.
- Arnold & Milne figures (656 points, 1,969 edges, 54 polygons, 14 types; 50-200 m; ~5,000 points; Benson 1302;
  Grinnell; Green & Sibson via Titcombe) -- checked against the PDF 2026-09-25.
- 1974 map facts (Fosberg indoors from 1954 photos; Mueller-Dombois field check 1965; Nakata transfer) -- checked
  against the report 2026-09-25.

## Figures

- `images/ch1_voronoi_kipuka.png` -- made by `R/fig_ch1_voronoi.R` from `data/` (same steps as Chapter 2).
- `images/ch1_mdf1974_kipuka.png` -- crop of Kim's sheet-12 composite (overlay + topographic base), 904 x 638 px.
