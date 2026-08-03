# checklistr

Regional plant checklists and collecting analytics from herbarium records.

`checklistr` builds a picture of a collecting location from GBIF preserved-specimen
(herbarium) records: **who** collected there and **when**, how the flora
**accumulated** and how completely it has been sampled, where duplicate specimens
carry **conflicting determinations**, and the **native/alien composition** of each
collector's work. It runs for any point-and-radius and taxon, so the floras of
different places can be compared.

Herbarium data is opportunistic. Rather than hiding the messiness, `checklistr`
surfaces it — institutional duplication (e.g. Bishop Museum records databased under
both `BISH` and `BPBM`), determination conflicts between duplicate sheets, and
digitization gaps.

## Install

```r
# install.packages("remotes")
remotes::install_github("kimbridges/checklistr")
```

## A worked example — Kīpuka Puaulu, Hawai‘i Volcanoes NP

```r
library(checklistr)

raw <- fetch_specimens_gbif(lon = -155.296, lat = 19.437, r_km = 2,
                            taxon = "Tracheophyta", rank = "phylum") |>
       add_primary_collector()

detect_det_conflicts(raw)                       # sheets with two determinations — run BEFORE dedup

sp <- dedup_specimens(raw, level = "institution")   # fix BISH/BPBM double-entry early

collector_profile(sp)                          # who collected, how much, when
plot_collector_activity(sp, place = "Kīpuka Puaulu")

richness_estimate(sp)                          # observed richness + completeness
plot_species_discovery(sp, place = "Kīpuka Puaulu")
plot_accumulation(sp, place = "Kīpuka Puaulu")

# native/alien composition needs a checklist with a `status` column:
sp2 <- add_checklist_status(sp, "kipuka_puaulu_checklist.csv")
plot_collector_composition(sp2, place = "Kīpuka Puaulu")
collector_contributions(sp2)
```

## Function overview

| step | functions |
|------|-----------|
| fetch | `fetch_specimens_gbif()`, `circle_wkt()` |
| collectors | `primary_collector()`, `add_primary_collector()` |
| dedup | `dedup_specimens()`, `normalize_institution()`, `clean_record_number()` |
| conflicts | `detect_det_conflicts()` |
| collector/date | `collector_profile()`, `plot_collecting_history()`, `plot_collector_activity()` |
| accumulation | `species_discovery()`, `richness_estimate()`, `plot_species_discovery()`, `plot_accumulation()` |
| composition | `add_checklist_status()`, `plot_collector_composition()`, `collector_contributions()` |

## Two honest caveats

- **Completeness estimators run high on herbarium data.** Botanists deliberately
  collect ~one sheet per taxon, which inflates singletons and inflates Chao1/Chao2.
  Trust the direction (is the curve still climbing?), not the exact number.
- **This measures the GBIF record, not the flora.** Published floras and local
  research herbaria hold records not in GBIF, so a low completeness score partly
  reflects a digitization gap — useful evidence for prioritising digitization.

Developed collaboratively by Kim Bridges and Claude.
