# Ideation — Chapter 3, "The Question of Scale"

*Working notes toward the anchor chapter. Not prose. Kim steers before drafting.*

## Status

This is the pivot chapter — the one idea that is Kim's own, and the one that
reorganizes every chapter after it. Everything downstream (completeness,
singletons, even how we read the status disagreements) inherits from the claim
made here. So it is worth getting the framing exactly right before a word of
prose is written.

## The core claim (Kim's, preserve the sense verbatim)

> Collections rarely focus on a single point; they accumulate records from
> surrounding areas. If a collector knows a specimen for the region is already in
> the herbarium, she is unlikely to re-collect it at each sampling location. That
> is a **taxonomic** collecting heritage — one representative per taxon per region —
> not an **ecological** one — sample at every site. This is why a 2 km "checklist"
> is a regional taxonomic accumulation, not a point census. And it is why the
> **map was the key instrument**: the stacking on nominal localities *is* that
> collecting habit made visible.

The whole chapter is the unpacking of that paragraph.

## The intellectual move

Two ways of collecting plants, two different logics:

- **Ecological logic** — sample *sites*. Every plot, every location, gets its own
  collection, because the question is *what grows here, in what abundance*.
  Re-collecting a species you already have is the point: it is a data point.
- **Taxonomic logic** — sample *taxa*. One good sheet per species per region is
  enough, because the question is *what species exist in this flora*. Re-collecting
  a species you already have is redundant effort; a collector who knows BISH holds
  a Kīpuka *Metrosideros* moves on.

The herbarium record is built almost entirely on the second logic. So when we
draw a 2 km circle and call the result a "checklist," we are reading a taxonomic
accumulation as if it were an ecological census. It is not. It is honest about
*which taxa* have been found in the region; it is nearly silent about *where,
how often, how abundant*.

This is not a flaw to apologize for. It is the *nature of the instrument*, and
naming it is what lets a reader trust the checklist for what it is good at and
distrust it for what it is not.

## Why this is the pivot

Name the scale problem here, and later chapters stop being a list of caveats and
become consequences of one idea:

- **Completeness (Ch. 4).** Chao/jackknife estimators assume ecological sampling —
  that a singleton means "rare," seen once by chance. Under taxonomic collecting a
  singleton often means "collected once *on purpose*, because once was enough."
  The 64% singleton fraction is then partly *structural*, not a sign of
  undersampling. Scale explains the singleton inflation.
- **The map.** The map is not decoration; it is the evidence for the claim. If
  collecting were ecological, points would disperse across the landscape. Instead
  they stack on a handful of named localities ("Kīpuka Puaulu," "Kīpuka Ki") —
  the collecting habit, made visible.
- **Two islands (Ch. 9).** The Kīpuka/ʻIliau contrast becomes a contrast of
  *eras and logics*: older nominal-locality stacking vs modern GPS-georeferenced
  dispersal. The data already show this (see below).

## The evidence — the map, and a data problem to solve first

The figure is `map_specimens()` for Kīpuka. **But:** the cached specimen file in
`documentation/data/kipuka_puaulu_specimens_dedup.csv` currently has **no
coordinate columns** — only `year`. The ʻIliau file *does* carry
`decimalLatitude` / `decimalLongitude`, and it is already visibly dispersed:
**35 distinct coordinate pairs out of 62 records.**

So before drafting we need to decide how the map gets into the book:

1. **Re-export Kīpuka specimens *with* coordinates** into `data/`, and render the
   map live in the chapter (leaflet is interactive HTML — fine for a Quarto
   *book*, but will not appear in PDF; a static ggplot/`maptiles` basemap version
   renders everywhere). *Recommended.*
2. **Pre-render a static map PNG** and include it as a figure. Simplest, most
   portable, loses interactivity.
3. **Both** — static figure in the flow, live leaflet as an optional aside.

A second, quieter piece of evidence is a *number*, not a picture: the count of
distinct localities (or distinct coordinate pairs) versus the number of records.
Kīpuka's stacking and ʻIliau's dispersal can be shown as one small table — a
quantitative companion to the map that survives into any output format.

**Open question for Kim:** does the original Kīpuka pull still have the
coordinate + `coordinateUncertaintyInMeters` fields we added to
`fetch_specimens_gbif`? If so, re-exporting the coordinate-bearing file is a
two-minute job and option 1 is clearly best.

## Proposed section structure

1. **Opening — the map that surprised me.** Kim's own moment: drawing the circle,
   expecting a scatter, seeing a stack. Personal, first-person, short. (This is
   the chapter that most earns a first-person voice — it is his idea.)
2. **`## Two ways to collect a plant.`** The ecological/taxonomic distinction,
   plainly. The heart of the chapter.
3. **`## What the map shows.`** `map_specimens(Kīpuka)`; the nominal-locality
   stacking; the distinct-locality-vs-records number. The claim made visible.
4. **`## Why a 2 km circle is not a plot.`** The consequence: the checklist is a
   *regional taxonomic accumulation*, trustworthy for presence, silent on
   abundance and micro-location.
5. **`## What this governs.`** Forward pointer: singletons, completeness, the
   two-islands contrast — all inherit from here. Sets up Ch. 4.

## Two-readers connection

- The **naïve reader** wanted "the plants of Kīpuka Puaulu" and gets a list that
  quietly answers a slightly different question — *the taxa recorded in the
  region around Kīpuka Puaulu*. This chapter is where that gap is named kindly.
- The **expert reader** already knows collecting is taxonomic; for her the payoff
  is seeing the habit *quantified and mapped* — the stacking made explicit, the
  singleton inflation given a mechanism.

## Honest caveats to keep in view

- Not *all* collecting is purely taxonomic; targeted ecological surveys (the
  1979–80 Kīpuka survey) do sample sites, which is partly why that survey
  dominates the record. The claim is about the *dominant* heritage, not a law.
- Georeferencing is retrospective for old sheets — many "coordinates" are a
  gazetteer lookup of a place name, which *itself manufactures* stacking. Worth
  saying plainly: some of the stack is collecting habit, some is georeferencing
  method. Both point the same way (nominal, not ecological), but they are
  different causes and the chapter should not conflate them.

## Decisions (Kim, 2026-07-08) — locked

1. **Voice — Kim's, first person.** But *not* "I drew the circle" — that collides
   with the dotted 2 km query line already on the map. Use instead: *"within the
   2 km area, I could spot a tighter cluster of points close to the trail map of
   the Kīpuka."* The move: the 2 km circle is the **query boundary**; inside it, a
   tighter cluster hugs the actual Kīpuka/trail — a structure Kim can read because
   he knows the ground, and which *is* the collecting habit made visible.
2. **The map — Option 1, static, street basemap.** Re-export a coordinate-bearing
   Kīpuka specimen file into `data/`; render a **static ggplot** map (not
   interactive leaflet) with a **street/road basemap**. Rationale (Kim): streets
   give an *intuitively understood distance reference*; crater-rim terrain reads as
   noise to anyone who doesn't already know the ground. Static also survives to PDF.
3. **Georeferencing caveat — its own full paragraph.** It is a common, substantive
   point whenever botanists discuss "recovering" old records; it earns a paragraph,
   not a source-note. Keep it distinct from the collecting-heritage claim: two
   different causes, same visual signature.
4. **Scope — ʻIliau stays in Ch. 9.** No dispersal teaser here. This chapter is
   Kīpuka only; the cross-island contrast is reserved for Two Islands.

## Data / build task before drafting

- Re-export Kīpuka specimens **with** `decimalLatitude`, `decimalLongitude`,
  `coordinateUncertaintyInMeters`, `locality` → `data/kipuka_puaulu_specimens_geo.csv`
  (keep the existing dedup file for the non-map chapters).
- Static ggplot map with a street-tile basemap. Prefer `maptiles`
  (OpenStreetMap tiles) → `ggplot` + `geom_spatraster_rgb` (tidyterra), with the
  2 km query circle as a dotted overlay and the specimen points on top. Confirm
  `maptiles` + `tidyterra` are available; if not, fall back to `ggspatial`
  `annotation_map_tile`.
- Companion number (survives any format): distinct localities / distinct
  coordinate pairs vs total records — the stacking as a statistic.
