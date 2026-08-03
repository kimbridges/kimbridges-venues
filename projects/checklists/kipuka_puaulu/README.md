# Kīpuka Puaulu plant checklist — from herbarium records

**Area:** Kīpuka Puaulu ("Bird Park"), Hawai‘i Volcanoes National Park, Mauna Loa,
Hawai‘i Island. Query center 19.437° N, 155.296° W, **2 km radius**.

**Source:** GBIF occurrence API, **preserved specimens only** (herbarium records).
Filter: `taxonKey=6` (Plantae), `basisOfRecord=PRESERVED_SPECIMEN`,
`geoDistance=19.437,-155.296,2km`. Accessed **2026-07-05**.

**Totals:** 385 specimen records → **157 vascular taxa** (150 species + 7 genus-level)
+ 4 mosses. Native = **85** (49 endemic, 36 indigenous); 57 naturalized; 12 planted/cultivated; 3 uncertain.

**Contributing herbaria (by specimen count):** BPBM/BISH Bishop Museum 224, NY 38,
USU 13, CHR 12, NMNZ 12, AK 10, HAW 10, WTU 10, ASU 8, US/ASC 7 each, K/RSA 6 each, others.

## Files
- `kipuka_puaulu_checklist.csv` — cleaned checklist, one row per accepted taxon.
- `kipuka_puaulu_bryophytes.csv` — the 4 moss records (GBIF Plantae includes bryophytes).
- `kipuka_puaulu_gbif_rawnames.csv` — every raw GBIF interpreted name + specimen count,
  unmodified. Full audit trail; reconciles exactly (194 names, 385 records).
- `build_checklist.py`, `verify.py` — reproducible build + a check that the cleaned
  list captures every raw name with correct summed counts (passes: 0 missing, 0 mismatch).
- `load_checklist.R` — quick dplyr/ggplot starting point for analysis.
- `collector_tools.R` — specimen-level toolkit (fetch, collector consolidation, dedup,
  collector/date lenses, determination-conflict detection); built live in RStudio.
- `kipuka_puaulu_specimens.csv` / `kipuka_puaulu_specimens_dedup.csv` — flowering-plant
  specimen records (raw / after BISH-BPBM dedup).
- `kipuka_puaulu_collectors.csv` — collector-profile table.
- `kipuka_puaulu_det_conflicts.csv` — audit of the 8 same-sheet determination conflicts.
- `fig_collector_activity_dedup.png`, `fig_collecting_history_dedup.png` — the honest
  (deduplicated) collector/date figures.

## Columns (checklist)
`accepted_name, family, common_name, status, rank, n_records, notes, det_conflict, det_conflict_note, verbatim_names`
- **status:** E=endemic, I=indigenous, Pol=Polynesian intro, Nat=naturalized,
  Cult=cultivated/planted (not naturalized), ?=uncertain.
- **n_records:** herbarium specimens, summing all synonyms/infraspecific names collapsed
  into that accepted taxon (listed in `verbatim_names`).
- **det_conflict / det_conflict_note:** flags taxa whose occurrence depends on a
  specimen that carries *two different determinations* (see below). `doubtful` = the
  taxon's only specimen is the contested side of a conflict; `review` = present, but a
  supporting sheet is alternately determined. Blank = no conflict. Added 2026-07-05 from a
  specimen-level analysis (`collector_tools.R::detect_det_conflicts`); audit in
  `kipuka_puaulu_det_conflicts.csv`.

## Method & caveats
- Synonyms and infraspecific names were collapsed to accepted species and their specimen
  counts summed (e.g. *Racosperma koa* → *Acacia koa*; 6 *Metrosideros* names → *M. polymorpha*;
  *Straussia hillebrandii* → *Psychotria hawaiiensis*). Every collapse is documented in `verbatim_names`.
- **Status assignments** follow Wagner, Herbst & Sohmer (*Manual of the Flowering Plants of
  Hawai‘i*) and Palmer (*Hawai‘i's Ferns and Fern Allies*) conventions — assigned by taxon,
  not re-verified against each specimen. Please spot-check.
- **Planted/cultivated flag (Cult):** a cluster of temperate forestry/horticultural trial
  species (coast redwood, cypresses, pines, China-fir, pecan, walnut, hazelnuts, American
  chestnut) appears within 2 km — legacy plantings near the kīpuka, not wild populations.
  *Castanea dentata* especially warrants a specimen check (planting vs. mislabel).
- **2 km radius** is generous and will include some specimens from adjacent forest/roadside,
  not the kīpuka core. Tighten the `geoDistance` for a stricter core-only list.
- GBIF georeferencing and determinations vary in quality; a few names are of doubtful
  application at this site (flagged `?` with notes), e.g. *Dicranopteris pectinata*
  (almost certainly native *D. linearis*, uluhe), *Asplenium furcatum*, *Hedyotis biflora*.
- **Determination conflicts (`det_conflict`).** Because BISH and BPBM are both Bishop
  Museum, some single sheets are databased under both codes with *different* IDs. Eight
  such sheets exist here (all from the 1979–80 survey); four are benign (spelling/genus
  variants that collapse to one accepted taxon — *Hypochoeris*/*Hypochaeris*,
  *Eriocapitella*=*Anemone*, etc.), but **three put two genuinely different taxa on one
  sheet**: *Ludwigia palustris* vs *Hedyotis biflora* (656953), *Corylus cornuta* vs
  *C. americana* (668168), and *Pyracantha koidzumii* vs *P. angustifolia* (770507). For
  each such pair the two names appeared as *separate* taxa in the facet-based checklist, so
  one of each pair is likely a phantom. Five taxa whose only support is a contested sheet
  are flagged `doubtful`; two present taxa with an additional contested sheet are `review`.
  Resolving each pair (which name is right) needs sheet-level examination — a task for the
  Bishop specimens themselves.
