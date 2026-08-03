# PROJECT: briefing_book
_Last updated: 2026-07-28_
_Status: Complete_
_Focus readiness: Not applicable_
_Tags: umbrella_
_Log: logs/proj_briefing_book_log.md_

## Type
Program + per-site PDF report collection (organizes the field-botany cluster)

## Objective
A data-driven foundation for specimen collection that faces two directions at once:
**optimize NEW collections** (where to go, what's cheap to grab, what's worth the trip, where to
find it) and **strengthen PAST collections** (resample ambiguous-locality specimens, resolve
contested determinations, dedup, and REPATRIATE corrected/enriched data to the institutions and
places the collections came from). The product is a **briefing_book**: per site, an assembled
COLLECTION of facet-reports as **PDFs** (not one monolithic document). Unifying method = FRICTION
reduction across the whole collection lifecycle (before / during / after the field day). Unifying
ethic = RECIPROCITY: respect for prior collecting effort and giving data back to its source.

## Why a collection of PDFs (Kim, 2026-07-16)
Printed pages go into the field well (no device, no battery, annotate by hand). They are also
trivially SHAREABLE with colleagues -- hand them out before leaving and you reduce your baggage AND
give people a concrete artifact from the expedition. So "PDF" is itself a friction choice
(sharing/logistics friction) and it serves the reciprocity ethic (something to give).

## The two-facing structure (the core purpose)
- PROSPECTIVE (optimize the next collection): targets, easy wins, findability, decks, site
  background, scope/maps.
- RETROSPECTIVE (strengthen what exists): resample ambiguous localities; resolve det-conflicts (now
  DESK-resolvable via online BISH scans -- see proj_checklists.md 2026-07-16); collapse double-
  entries; fill digitization gaps; and REPATRIATE the corrected data to Bishop / NTBG / HAVO / place.
Most collecting tools face only forward; the backward-facing half is where the respect-for-past-
effort ethic lives.

## The friction taxonomy (the method-spine -- "friction runs through everything")
- Attention friction -- the crowded field moment (vouchr; derive fixed data in post).
- Cost / logistics friction -- hundreds of $/day; maximize value per field day; PDFs to carry & share.
- Cognitive / omission friction -- forgetting the EASY tasks (Gawande checklist logic).
- Access friction -- reaching specimens at all (Kim's Kolkata herbarium story; online scans dissolve it).
- Knowledge friction -- contested names, synonymy, status disagreement.
- Follow-up (iteration) friction -- the gap between noticing something and being able to chase it. Named
  2026-07-26 out of the 80%-tool work: the engine flags the anomaly AND holds the means to pursue it, in the same
  exchange, while the context is still loaded. Historically the flag arrived in one place (a reviewer, a table) and
  the means in another (a rebuilt script, next week), and most flags died in that gap.
Staged assault on all of these: before / during / after a collection.

## The report catalog (modular; a site gets the applicable subset)
UNIVERSAL (any site):
  R1 The place at several scopes -- nested-radii map (kipuka-core / 500 m / 2 km), rich symbolism.
  R2 The scope-aware checklist -- occurrence baseline by radius, annotated (status, lifeform).
  R3 Easy wins -- singletons + stale-but-common (cheap, high record value; "grab while you pass").
  R4 High-value targets -- stale natives/endemics; collector-dependent taxa.
  R5 Contested identities -- det-conflict sheets + diagnostics + scans (a fresh collection resolves).
  R6 Findability & honest limits -- real coords vs nominal stacks; staleness != rarity; no "when".
CONDITIONAL (site-dependent):
  R7 Climate & site factors -- the vouchr `site_extract` derive engine (terrain, climate, substrate).
  R8 Recommended decks -- vouchr `deck_discovery` against the site's own collector community.
  R9 Data-repatriation packet -- corrected records / resolved conflicts / dedup, formatted to hand back.
  R10 Collecting history -- who collected here, when, in what eras (respects prior effort).
The distilled FIELD CARD is the prospective reports' tail -- one more item in the collection, possibly
emitted as a vouchr card deck.

## Objective function (declare the goal, re-rank)
No universal weighting for targets. Declare the goal and re-rank: (a) complete/harden the digital
record; (b) fresh endemic material (DNA/phenology); (c) resolve contested IDs; (d) rediscovery of
possibly-lost taxa.

## This is the umbrella of the field-botany cluster
briefing_book is not a new sibling -- it is the PARENT that makes the existing siblings one body of
work: checklists/checklistr (what's here), specimen_labels/vouchr (capture what you hold),
site_extract (derive fixed context), deck_discovery (what to record), + the 2026-07-16 time/scope
lenses. "Data-driven specimen collection, before and after the field day, friction-reduced and
reciprocal" is the parent.

## Generalization arc
Kipuka Puaulu first, as a concrete proof: build one report, then the set. Then generalize to a
companion capability that emits a briefing_book for ANY site (`briefing_report_*()` + a per-site
manifest declaring which reports apply). Explore -> package, as with the rest.

## Locations
- Ideation: G:\My Drive\Projects\checklists\briefing_book_ideas.md (the design conversation)
- **The commission block**: G:\My Drive\Projects\checklists\briefing_book_commission.md -- the standing
  instruction that produces a new briefing book. There is NO stored driver script; this is what stands in for
  one. Published verbatim on kimbridges-collections/behind_the_curtain.html as "The standing instruction".
- Site data + tools: G:\My Drive\Projects\checklists\kipuka_puaulu\ (checklist, time_tools.R,
  conflict_diagnostics.md, scans\, figures) -- the first site's substrate already exists.
- Reports/output: (none yet) -- likely a new Projects\briefing_book\ or under kimbridges-collections.
- GitHub: not yet.

## Related Projects
Parent of / built on: checklists, checklistr, specimen_labels/vouchr (site_extract, deck_discovery).
Thematically: the "knowledge engine" + reciprocity themes from the checklistr book "A Checklist Is an
Argument".

## Next Steps
1. START: Kipuka Puaulu. Prototype ONE report first as proof of form + value (Kim to pick; candidates:
   R1 scope-map foundation, or R3+R4 targets as the most novel "data-driven collection").
2. Settle report layout / house style for a field-usable, shareable PDF.
3. Then assemble the Kipuka set; then generalize toward a report-emitter for any site.

## Collaborators / Dependencies
Data: GBIF (rgbif; scans via institution image links), vegan, GIFT. Institutions for repatriation:
Bishop Museum (BISH/BPBM), NTBG, HAVO. Taxonomy/status: Wagner et al.; Palmer.

## Blockers
None.


---
## Log

The dated log for this project was split out on 2026-07-28 and now lives in
`logs/proj_briefing_book_log.md`. It is verbatim and unedited. New entries go there.
