# coenosr 0.0.0.9000

First functions of the COENOS reconstruction:

* `read_rel()` reads a COENOS relevé file into a tidy long table. Handles the
  documented parsing rules (6-character relevé codes, the 4+4 species key kept
  opaque, first-non-blank cover, duplicate-last-wins, `&&` comments,
  case-sensitivity) and both cover scales. Reads the bundled `DIEREN.REL`,
  `ELLEN.REL`, and `SET1.DAT` (CRLF, numeric covers).
* `read_lists()` reads the ragged "site, then its species" form (one line per
  site, variable length) — the natural field/dictation input. Auto-detects
  cover values, so the same function reads presence/absence and cover data.
* `read_2way()` reads the wide species-by-sites matrix form (1/0 or covers),
  with a `transpose` option. All three readers return the same `coenos_rel`
  object, so the rest of the workflow is identical regardless of input.
* `constancy()` returns per-species occurrence counts.
* `classify_species()` performs the COENOS trim step, splitting species into
  `rare` (constancy < 3), `eligible`, and `ubiquitous` (constancy >= floor(2n/3)).
* `print.coenos_rel()` summary method.
* `form_groups()` forms differential species groups: the density-block search of
  Bruelheide & Flintrop (1994) with the outside criterion of Ceska & Roemer
  (1971). Deterministic; returns a `coenos_groups` object.
* `coenos_table()` assembles the sorted two-way table — species by group,
  relevés ordered by reciprocal averaging, ungrouped species below.
* `differential_table()` extracts the display-ready differential core as a plain
  data frame; `coenos_gt()` renders it as a formatted `gt` table in one call.

Validation: `read_rel()` and `classify_species()` are checked against decoded
`.S00` ground-truth oracles for all three bundled datasets (exact matches).
`form_groups()` reproduces COENOS's strong, well-separated groups exactly and
its subtler differential groups approximately; the residual is the program's
unpublished tie-break, documented rather than papered over.
