# Cross-Project Updates — backport list
_Started 2026-07-17. Kim's practice: the **briefing_book** project is deliberately a TEST + DEMONSTRATION bed for
the tools built in earlier projects. When work here advances a capability that belongs in an earlier project, queue
it HERE so the earlier project gets updated. This is the standing list._

## Open backport items (from briefing_book, 2026-07)

1. **specimen_labels / vouchr — promote `site_extract` to a real function.**
   R7 built a working site-extraction (WorldClim 2.1 bioclim + elevatr terrain + Whittaker biome placement) for
   Kīpuka Puaulu. `site_extract` currently exists only as a CONCEPT (Site_Extract.pdf). briefing_book R7 is the
   working prototype -> turn it into `site_extract()` in vouchr/specimen_labels.

2. **checklistr — add `add_iucn()`.**
   R3+R4 found IUCN Red List category is available KEYLESS via GBIF
   (`rgbif::name_usage(key, data="iucnRedListCategory")`). Fold into checklistr as `add_iucn()`, carrying the
   documented nuances: apply protection to NATIVE taxa only; global-vs-local (alien EN != protected; VU natives
   can be locally common, e.g. Metrosideros); NE != safe.

3. **checklistr — fold in `time_tools` (phenology + recency) as R/time.R.**
   Built as `kipuka_puaulu/time_tools.R` (specimen_phenology, specimen_recency, plots). Include the honest 3-tier
   **`locate`** signal (GPS / approx / nominal from coordinate precision + GPS-era) — a general georeferencing-
   quality tool, and the point of the R1/R3+R4 honesty.

4. **whittakerr — a clean "place a site" helper + a label-clipping fix.**
   R7 placed one site on `plot_biomes()`. The built-in `label=` clips when the point is near the right edge
   (had to annotate manually). whittakerr could gain a tidy site-annotation helper and fix the label placement.

5. **checklistr / collector_tools — generalize the R10 lenses.**
   R10 built a herbarium-holdings table (normalize_institution + span + years-since-last) and a collector
   collecting-period timeline. Generalize to `herbarium_holdings()` and `plot_collector_spans()`.

6. **Report system — the R-native field-PDF toolkit is reusable.**
   cairo_pdf + patchwork + tableGrob + strwrap-wrapped footers + the larger type standard. Any project needing
   field-friendly, shareable PDFs can reuse this.

7. **checklists — re-run on the corrected centre.**
   The earlier Kīpuka checklist / collector / phenology / recency numbers used the OLD centre; re-run on the
   corrected loop-trail centre 19.44095 / -155.30295 (224 recs / 100 taxa within 2 km).

## Done
(none yet — items move here when backported.)

