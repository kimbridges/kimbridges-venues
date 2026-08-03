# Herbarium label-field survey — working notes (Track B)
_Started 2026-06-30. Casual/harvestable material for the specimen_labels document. Not final prose._

## Purpose
Find out **which label fields collectors actually fill**, empirically, to steer the QR-card
deck design. Reasoning: Darwin Core fixes *what fields can exist*; the open question is
*field occupancy* — which are populated in real records, and which traditional fields have
quietly gone redundant.

## The accessible databases (the good find)
All the major sources share one vocabulary — **Darwin Core (dwc.tdwg.org)** — so "what fields
exist" is standardized. Three tiers of access:
- **Aggregators:** GBIF (~1B+ records, API + bulk DwC downloads with citable DOI), iDigBio
  (US, images + data), Atlas of Living Australia.
- **Symbiota consortium portals** (herbarium-native, expose the full transcription field set):
  SEINet, SERNEC, Consortium of Bryophyte Herbaria, Consortium of Lichen Herbaria, CCH2.
- **Institutional catalogues:** Kew, NY (C.V. Starr Virtual Herbarium), Harvard, Tropicos (MO), Paris.

This clears the stumbling point from a few years ago: the data are open, standardized, and bulk-downloadable.

## Test case: genus *Metrosideros*, PreservedSpecimen
GBIF taxonKey 3185258. Population = **18,895** preserved-specimen records
(NZ 5,998 · US/Hawaii 5,044 · New Caledonia 2,385 · French Polynesia 1,329 · + Pacific tail).
Reconnaissance sample this session: **n = 182**, spread across the result set, country-representative
(NZ 74, US 53, NC 15, PF 9, …). Data + occupancy saved alongside this note.

## Field occupancy (n=182)
- **Near-universal spine (>90%):** scientificName / genus / family, specificEpithet (95%),
  collector `recordedBy` (98%), eventDate/year (100%), catalogNumber (97%), institutionCode (95%).
  = *what, who, when, and the specimen's identity.*
- **Middle band (40–80%):** collectionCode 80%, coordinates 73%, stateProvince 58%, locality 54%,
  verbatimLocality 51%, habitat 48%, identifiedBy 47%, collector number 46%, elevation 42–45%.
- **Sparse tail (<25%):** occurrenceRemarks 25%, county 20%, coordinateUncertainty 14%,
  fieldNotes 12%, typeStatus 9%, **reproductiveCondition (phenology) 3%**; sex/lifeStage/establishmentMeans ~0%.

## Design principles this produces
1. **Geography needs no cards.** A GPS fix at collection + reverse geocoding yields the whole
   place-name hierarchy (country → state → county → locality). So the decks carry *no* place-name
   cards; geography is derived at assembly time. (Kim's point, 2026-06-30.)
2. **Locality vs coordinates: complementary, not redundant — in the legacy corpus.** Cross-tab:
   both 35% · coords-only 38% · text-only 20% · neither 7%. Dropping either blinds you on 20–38%
   of records. BUT this is an artifact of retrospective, patchy digitization. **Capture-once
   (GPS + optional free-text locality at source) records both simultaneously and dissolves the
   debate.** Good opening move for the document.
3. **Phenology is the corpus-wide gap (3%).** Reproductive condition / life stage almost never
   captured in structured form. So an **observation deck (phenology) adds genuinely new structured
   data** rather than duplicating what herbaria already hold — the strongest argument for the decks.

## The habitat field (the one whose content isn't obvious)
87 habitat entries, 73 unique. It is a **catch-all free-text bucket** mixing several genres:
- community / vegetation type ~45% ("dry ʻōhiʻa forest", "Rimu forest with Weinmannia")
- landform / topographic position ~39% (ridge, gully, cliff, valley, streambank)
- substrate / geology ~32% (ʻaʻā, pāhoehoe, basalt, clay loam, limestone, sandstone)
- associated species named ~21%
- moisture regime ~15% (dry / wet / bog / rainforest)
- disturbance / land-use ~11% (cut-over, logged, secondary, seral)
- **non-habitat noise ~18%** — place names ("Koolau", "Volcano"), garden provenance
  ("Mediterranean Garden"), and insect-feeding notes leaking in from arthropod-on-host records.
- **jammed structured template ~24%** — several NZ datasets push "Habitat modification: … Land use:
  … Landform: … Geology: … Aspect: … Slope: …" into the single habitat string.

**Reading:** habitat is where everything unstructured goes *because there is nowhere else to put it.*
That NZ herbaria already jam a `Field: value` template into it is direct evidence that collectors
*want* structure here. Design implication — habitat **decomposes**: some facets are cardable with
controlled vocabularies (moisture regime; substrate/geology; landform; disturbance/land-use), while
associated-species lists and true narrative stay free-text (the interleaved writing / free-text card).
Maps cleanly onto the three deck families (identity / observation / free-text).

## The derive-vs-observe partition (Site_Extract, 2026-06-30)
Kim added `Site_Extract.pdf` — a terrain-extraction he computed from **a site name + lat/long alone**
(Koko Crater). It returns: elevation (147.2 m) with local mean/high/low (147.4 / 162.9 / 132.1 m →
relief); **slope 40°**; **aspect 201° SSW**; **Terrain Roughness Index 9.7**; **water-flow direction SW**;
DEM resolution + grid footprint; plus a location map, a 9-point site grid, and a slope contour diagram.

These are the **same variables collectors hand-scribble into `habitat` / `verbatimElevation`** in the
Metrosideros dump (landform ~39%, substrate ~32%, elevation ~45%), inconsistently and at low fill —
including the NZ template that writes `Aspect: W. Slope: Undulating` by hand. They were manually
recording what the Earth already encodes.

**Principle (generalizes the place-name insight): partition every label field into two classes.**
1. **Derivable from coordinates + reference layers — compute, never card, zero friction:** place-name
   hierarchy (reverse geocode); the physiographic set from Site_Extract (elevation, relief, slope,
   aspect, roughness, landform, drainage); geology/soil-order from map layers; climate from WorldClim
   (the `seasonalityr` engine).
2. **Not derivable — must be observed at the instant of collection — this is all the decks carry:**
   phenology (the 3% gap) and phenotype (habit, height, flower colour, glabrous/pubescent), associated
   species / community, disturbance / land-use, and human metadata (collector, number).

*Derive everything the landscape already encodes; card only what a human at the plant must judge.* This
moves the "habitat" catch-all's physiographic half into the computed column, leaving only the biotic
half as cards + free-text, and shrinks the decks to their irreducible core.

**Corroboration in Kim's own data:** the NEON records auto-populated
`evergreenForest; slope aspect: 240.3; slope gradient: 4.92; soil type order: Histosols` — NEON already
computes terrain from coordinates and writes it to the label. The field is moving this way.

**Resolves an open project question:** the "terrain-scope boundary vs gePoints/geContour." Site_Extract
*is* the derive-half engine; it already exists in Kim's code (to be located).

## Caveats
n=182 is reconnaissance (±~7%). GBIF *interprets* some fields (dates → year/eventDate = 100%;
parses coordinates), so those overstate what is literally on the label — the `verbatim*` and
free-text fields are the honest label signal. Fill-rate ≠ data quality.

## Next steps
- Full authoritative pull via `rgbif::occ_download()` (Kim's credentials) → rerun occupancy exactly,
  no truncation; slice Hawaii-only vs NZ vs New Caledonia.
- Draft controlled vocabularies for the cardable habitat facets (moisture / substrate / landform / disturbance).
- Fold these principles into design_notes.md when the document spine firms up.

## Files (this folder)
- `metrosideros_sample_labelfields.csv` — the 182-record sample, curated DwC label columns.
- `metrosideros_habitat_values.csv` — habitat strings (with country), for the vocabulary work.
- `metrosideros_field_occupancy.csv` — the fill-rate table above.
