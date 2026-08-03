# Determination-conflict diagnostics — Kīpuka Puaulu
_Captured 2026-07-16. A durable record of the species-separating characters for the
same-sheet BISH-vs-BPBM determination conflicts, plus the online-scan access that now
lets these be examined at the desk. Botanical determination is Kim's call; this file
holds the diagnostics + links so nothing is lost. We will return to this._

## The capability (why this matters)
BISH & BPBM are one museum (Bishop); the same physical sheet was catalogued twice under
two institution codes, sometimes with DIFFERENT determinations. GBIF carries the BISH
digitization's SCAN (the BPBM double-entry record has no image). So a conflict once flagged
"needs the physical Bishop sheets" is now a desk check against the scan. This is the
"aggregation gives new access to centuries of collections" thesis in action — and a killer
application to examine further: diagnostic characters + online scans = remote conflict
resolution.

Scans downloaded to `kipuka_puaulu/scans/` (webp + jpg). Links in `conflict_sheet_scans.csv`.
Resolution note: 3 sheets are 768x1152 web derivatives (good for gross/macro characters,
marginal for fine detail or label text); Pyracantha (770507) is full-res 3840x5760. Full-res
for the others would come from the Bishop Museum portal.

## The 3 real conflicts + 1 review case

### 656953 — Ludwigia palustris (BISH) vs Hedyotis / Leptopetalum biflorum (BPBM)  [GROSS]
Different FAMILIES, so one is a mis-entry.
- Decider: interpetiolar stipules. Present = Rubiaceae (Hedyotis/Leptopetalum biflorum);
  absent = Onagraceae (Ludwigia palustris). This is a family-level, unmistakable character.
- Supporting: Ludwigia palustris = marsh purslane, reddish wetland stems, 4-merous flowers,
  inferior ovary -> 4-locular capsule, no stipules. Hedyotis biflora = sprawling Rubiaceae
  herb, opposite leaves WITH interpetiolar stipules, small 4-merous flowers, capsule.
- Res note: 768px is plenty for this family-level call.

### 668168 — Corylus cornuta (BISH) vs C. americana (BPBM)  [CONGENERIC]
Both cultivated hazelnuts (planted / forestry-trial context near the kīpuka; neither native).
- Decider: the fruit involucre (husk), if present on the sheet. C. cornuta ("beaked") =
  husk prolonged into a long tubular beak enclosing the nut; C. americana = husk short, open,
  of two broad ragged bracts scarcely longer than the nut, not beaked.
- Supporting: C. americana has glandular-bristly petioles/young twigs.

### 770507 — Pyracantha koidzumii (BISH) vs P. angustifolia (BPBM)  [CONGENERIC]
Both ornamental firethorns. (Full-res scan available.)
- Decider: leaf underside indumentum + margin/apex. P. angustifolia = leaves narrowly
  oblong, margin entire, apex rounded, densely GREY-TOMENTOSE beneath. P. koidzumii = leaves
  larger/oblanceolate, apex often notched (emarginate), glabrous or nearly so beneath.

### 656108 — Cerastium fontanum/holosteoides (BISH) vs C. glomeratum (BPBM)  [REVIEW]
Both weedy mouse-ear chickweeds; possibly genuinely ambiguous or a mixed/young collection.
- Decider: inflorescence density + sepal-hair projection + habit. C. glomeratum = annual,
  flowers in DENSE compact terminal glomerules, densely glandular-sticky, sepal hairs projecting
  BEYOND the sepal tips, bracts wholly herbaceous. C. fontanum = perennial (mat-forming, sterile
  shoots), cyme laxer at maturity, sepal hairs NOT overtopping the tip, upper bracts with narrow
  scarious margins.

## Status
Awaiting Kim's determination from the scans. Once resolved, update the checklist:
the doubtful/review det_conflict flags in kipuka_puaulu_checklist.csv can be settled and
the phantom taxa (one of each real pair) removed with a provenance note.

