# Briefing book — the commission block

_Written 2026-07-26. This is the paragraph to hand Claude to start a new site.
It replaces nothing: there is no stored driver script for the briefing books.
The two existing books were built conversationally, report by report, and the
code was written in the session rather than saved as a runnable pipeline.
This block is what makes the rebuild fast and consistent instead of improvised._

---

## The block (edit the bracketed parts, paste the preview at the end)

Build a briefing book for **[SITE NAME]**, centre **[lat] / [lon]**, on the
Kīpuka Puaulu and ʻIliau Loop Trail model.

Occurrence layer: `checklistr` — `fetch_specimens_gbif`, `dedup_specimens`,
`add_lifeform`, `add_status` / `status_gift`, `detect_det_conflicts`,
`map_specimens`, `plot_collector_activity`, `plot_species_discovery`,
`collector_profile`, `richness_estimate`. Terrain and substrate: `vouchr::site_extract`.
Climate: `whittakerr` against WorldClim. Per-record elevation: `elevatr`.
Conservation status: IUCN via GBIF, plus GIFT for growth form.

Every basemap uses **Esri topo tiles**. OSM tiles return blank at these sites.

Emit the reports that this site actually warrants, from the catalog in
`proj_briefing_book.md`. Both existing books carry R1 (the place at several
scopes), R2 (the annotated checklist), R3+R4 (targets), R5 (contested
identities), R7 (climate and site factors), R10 (collecting history), and the
one-page field card. Bind with `qpdf`.

House standard, non-negotiable. Type in ggplot size units: report title 6.4
bold, section and figure titles 5.6 to 6.0, subtitle 3.4, body and notes 3.3 to
3.5 with `strwrap` at width 100 to 104 and `clip = "off"`, tables base 11 to 12,
figure axis text 11 to 13, axis titles 17 to 19. Footer text is wrapped, never
broken by hand. Okabe-Ito palette (blue #0072B2, orange #E69F00, grey #666666).
Nothing is ever carried by colour alone. One figure per page width, stacked,
never side by side.

Honesty rules that override any cleaner-looking output. Staleness is a gap in
collecting effort, not evidence of rarity. Coordinate precision is not
locatability, so every target gets one of three tiers: relocatable, search the
vicinity, or general area only. The record is not the flora, so each master list
carries a note on what is probably present but unrecorded.

Naming: **Kīpuka Puaulu** is never shortened to "Kīpuka." Preserve every ʻokina
and macron.

Working files go in `G:/My Drive/Projects/checklists/[site_slug]/`.

**My site preview follows. It directs the analysis. Adapt the reports to it
rather than filling a template with it.**

[paste site_preview.md here]

---

## What this block does not do

It does not make the build reproducible. Nothing here can be sourced. The block
is a directive, not a program, and the report code gets rewritten each time it
is used. Two consequences worth knowing before relying on it:

- The output will not be byte-identical to a previous run of the same site.
- If a number in an existing book is ever questioned, there is no script to
  re-run. The `.rds` files in each site folder are the only surviving state.

The durable fix is a real driver in `checklistr` that takes a centre, a radius
and a preview file and emits the report set. That is the "fold into checklistr"
item already recorded in `proj_briefing_book.md`. Until it exists, this block is
the closest thing to a build procedure.

## Preview capture

The preview is the one genuine input, so capturing it deserves the same care as
the build. The existing `checklists/iliau_loop/site_preview.md` was written up
from Kim's spoken observations during the session, not pasted from anything he
had written. The original wording was not kept. For future sites, write the
preview first, in Kim's own words, and save it before any build starts.
