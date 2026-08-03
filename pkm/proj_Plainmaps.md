# PROJECT: Plainmaps
_Last updated: 2026-05-30_
_Status: Complete_
_Focus readiness: Not applicable_

## Type
Quarto multi-chapter document (R mapping; deployed to
kimbridges-documents)

## Objective
Create simple, clean maps with border outlines and add
straightforward overlays — maps suited to publications and
presentations rather than interactive web display. The document
walks through the R packages, themes, border sources, shapefiles,
overlays, choropleths, and international maps needed to produce
publication-quality plain maps.

## Current Status
Complete and posted as "Plainmaps — Simple, clean map creation for
publications and presentations" in the kimbridges-documents
collection (categories: R, Maps, Geography, Data Visualization). A
Quarto book at G:\My Drive\Projects\Plainmaps\ with the chapter set
index, Introduction, Packages, Themes, Borders, International,
Shapefiles, Overlays, Choropleth, Sitemaps; rendered output present
(`_output/`, `Maps_files/`, `Maps.html`). Bundled shapefiles
(Hawaii coastlines, Niihau, a 540 Island_boundaries set, Pacific
Islands / SPREP region). Status is Complete per the
posted-on-website rule (2026-05-30).

Recovered 2026-05-30: one of five posted documents that had no
proj_*.md. Kim located the folder and moved it into
G:\My Drive\Projects\.

## Locations
- Source: G:\My Drive\Projects\Plainmaps (.qmd files)
- Output: G:\My Drive\Projects\Plainmaps\_output, Maps_files/
- Data: hawaii_coastlines/, Niihau/, 540/Island_boundaries,
  Pacific_Islands/sprep-region/ (shapefiles), out.shp / new_niihau.shp
- Deployed: kimbridges-documents.netlify.app/docs/plainmaps
- GitHub: not evident (folder carries `_publish.yml`; Quarto Pub
  history likely)

## Key Files
- _quarto.yml — book config (title "Plainmaps", subtitle "Create
  maps with border outlines and add simple overlays")
- index.qmd, Introduction.qmd, Packages.qmd, Themes.qmd,
  Borders.qmd, International.qmd, Shapefiles.qmd, Overlays.qmd,
  Choropleth.qmd, Sitemaps.qmd — chapters
- Tessellations.qmd, sandbox.qmd — additional / scratch chapters
  (not in the rendered book list)
- hawaii_coastlines/, Niihau/, 540/, Pacific_Islands/ — shapefile
  data sets
- Cover_with_text.jpg (cover), plain_maps_logo.jpg (logo)
- plain_maps.Rproj — RStudio project

## Related Projects
- **sitemaps** (proj_sitemaps.md) — Plainmaps includes a Sitemaps
  chapter; the two share the points-and-labels-on-basemaps theme.
- **gePoints** / **geContour** — other mapping tools in the family.

## Next Steps
1. None required — posted and Complete. Optional: style alignment
   against style_multichapter_doc.md if revisited.
2. Folder vs posted slug (`plainmaps`) reconciliation
   (priorities.md item 6) — already close.

## Collaborators / Dependencies
None.

## Blockers
None.

---
## Log

### 2026-05-30
Project file created during the status/focus-readiness back-fill
session, as an intake for one of five posted kimbridges-documents
that had no proj_*.md. Kim located the folder and moved it into
G:\My Drive\Projects\Plainmaps\. Filed with the observed state: a
~10-chapter Quarto mapping book with bundled Hawaii / Pacific
shapefiles, rendered and posted live. Marked Status: Complete /
Focus readiness: Not applicable per Kim's posted-on-website rule.
Noted the shared Sitemaps chapter as a tie to proj_sitemaps.md.
