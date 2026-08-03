# PROJECT: seasonalityr
_Last updated: 2026-06-29_
_Status: Complete_
_Focus readiness: Not applicable (v0.0.0.9000 live on GitHub; companion document published 2026-06-29)_

## Type
R package (the companion engine to the **seasonality** document; sibling to
whittakerr / listsr / coenosr).

## Objective
Package the seasonality cue-regime toolkit so the document can be written against
`library(seasonalityr)` and others can reuse it: per-site climate indices, the
**daylength channel**, the **water-balance-gated v2 cue-regime classifier**, and
**regional regime maps** from WorldClim.

## Current Status
**Built and checked 2026-06-24.** `R CMD check` **0 errors / 0 warnings / 1 note**
(the benign "unable to verify current time" timestamp note). **testthat 11/11.**
`devtools::load_all()` clean; the full pipeline runs via the exported functions and
**reproduces the SW desert trio** (Las Vegas/Mojave winter, El Paso/Chihuahuan summer,
Tucson/Sonoran bimodal — all "reactive-rain (arid desert)"). **LIVE on GitHub:**
**github.com/kimbridges/seasonalityr** (`remotes::install_github("kimbridges/seasonalityr")`).

## Key Files
- `R/indices.R` — `get_climate()`, `compute_indices()`, `indices_table()` (+ `SI_FLOOR`).
- `R/channels.R` — `daylength_hours()`, `daylength_channel()`, `add_daylength()`.
- `R/regimes.R` — `classify_v2()`, `regime_palette()`, the thresholds + `REGIME_PAL` (internal).
- `R/maps.R` — `plot_channel()`, `plot_regime_map()`, `compute_regime_grid()`, `regime_map_region()`.
- `R/data.R` + `data/cities.rda` — the 21-site validation set (bundled).
- `tests/testthat/test-cue-regimes.R` — trio reproduction, indices, daylength, palette.
- 12 exported functions; DESCRIPTION/NAMESPACE/man complete; MIT licensed.

## Locations
- `G:\My Drive\Projects\seasonalityr\` (package). Source scripts it was adapted from
  live in `G:\My Drive\Projects\seasonality\` (`seasonality_harness.R`,
  `seasonality_cue_regimes.R`, `seasonality_map.R`).
- WorldClim **not** bundled; retrieved via `geodata` and cached (path is a function
  argument, default `tempdir()`; the dev cache is `Projects/seasonality/wc_cache`).

## Related projects
- **seasonality** — the document this package serves (spine, concept, four regional maps).
- **whittakerr / listsr / coenosr** — sibling document+package pairs; same pattern.

## Next Steps
1. ~~Push to GitHub~~ **DONE 2026-06-24** — live at github.com/kimbridges/seasonalityr.
2. Write the **seasonality** document against `library(seasonalityr)` (see
   `Projects/seasonality/documentation/doc_plan.md`).
3. Future (named as document "future work"): the temperate-oceanic regime, the 25°
   tropical/extratropical seam, the Mediterranean-vs-oceanic split, and the deferred
   reliability/interannual axis.

## Collaborators / Dependencies
geodata, terra, dplyr, tibble, purrr, ggplot2, ggrepel (Imports); testthat (Suggests).

## Blockers
None.

---
## Log
### 2026-06-29 — companion document published; package COMPLETE (v0.0.0.9000)
The **seasonality** book was written entirely against `library(seasonalityr)`, every chunk live-verified, and is
now **published** to kimbridges-documents (https://kimbridges-documents.netlify.app/seasonalityr/). The package
served the document exactly as intended (the whittakerr/listsr/coenosr pattern): `get_climate` + `compute_indices`
+ `indices_table` for the indices, `daylength_*` / `add_daylength` for the daylength channel, `classify_v2` for
the regimes, and `plot_channel` / `plot_regime_map` / `compute_regime_grid` / `regime_map_region` for the figures
and the four regional maps (regenerated through the package for the book, reproducing the validation exactly).
Installed locally during deploy so Quarto's fresh R session could load it. The package's own function reference
is now an appendix in the book. **Status → Complete.** Future versions (named as the document's future work) would
add the temperate-oceanic regime, soften the 25° seam, split Mediterranean-vs-oceanic, and add the
reliability/interannual axis; none is a blocker. See proj_seasonality.md 2026-06-29.

### 2026-06-24 (created — package built and checked)
Adapted the three durable seasonality scripts into an installable package via the
live RStudio (ClaudeR) bridge: `usethis::create_package`, MIT license, deps declared,
roxygen2 docs on all functions, `cities` bundled as data, `devtools::document()`,
testthat (11/11), `devtools::check()` **0/0/1** (benign timestamp note). The Finding
004 shadowing trap bit once (script-era `get_climate` in the global env shadowed the
package's new `path=` signature) — cleared the shadows and the pipeline ran clean
through the package. **Pushed to GitHub** the same day (github.com/kimbridges/seasonalityr)
after repairing a stale `gh` toolchain — see pkm_findings.md Finding 009. See
proj_seasonality.md and session_log.md 2026-06-24.
