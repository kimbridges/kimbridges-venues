# PROJECT: Deconstructing a Flora
_Last updated: 2026-05-30_
_Status: Complete_
_Focus readiness: Not applicable_

## Type
Quarto multi-chapter document (LLM-assisted botanical research;
deployed to kimbridges-documents)

## Objective
Experiments in using technology — language models in particular —
to assist traditional botanical research activities. The document
demonstrates "deconstructing" a flora: taking the dense, formulaic
prose of a published flora and extracting structured, queryable
data from it with LLM assistance. The worked example is den
Hartog's *Seagrasses of the World* (1970); herbarium label data is
a second strand. The document is explicitly proof-of-concept /
rapid-prototyping in spirit, not a finished research program.

## Current Status
Complete and posted as "Deconstructing a Flora" in the
kimbridges-documents collection (categories: Botany, Research). A
Quarto book at G:\My Drive\Projects\Deconstructing_a_Flora\ with
three chapters (index, Introduction, Seagrass), rendered to both
HTML (`_output/`) and PDF (`_output/Deconstructing-a-Flora.pdf`).
Status is Complete per the posted-on-website rule (2026-05-30); the
proof-of-concept demonstrations could be extended, but that is
optional, not pending work.

Recovered 2026-05-30: this was one of five posted documents that
had no proj_*.md. Kim located the folder and moved it into
G:\My Drive\Projects\ during the status-back-fill session.

## Locations
- Source: G:\My Drive\Projects\Deconstructing_a_Flora (.qmd files)
- Output: G:\My Drive\Projects\Deconstructing_a_Flora\_output
  (HTML site + Deconstructing-a-Flora.pdf)
- Deployed: kimbridges-documents.netlify.app/docs/deconstructing-a-flora
- GitHub: not evident (folder carries `_publish.yml`; check Quarto
  Pub history if a source home is needed)

## Key Files
- _quarto.yml — book config (title "Deconstructing a Flora",
  subtitle "Experiments in Aiding the Research Process")
- index.qmd — preface (proof-of-concept framing)
- Introduction.qmd — introduction chapter
- Seagrass.qmd — the den Hartog *Seagrasses of the World* worked
  example (with a distribution plot)
- Bard_sandbox.qmd, sandbox2.qmd — LLM experimentation scratch files
- herbarium_names.csv, temp/herbarium_data.csv, temp/claude_response.csv,
  temp/habitat_response.txt — herbarium-label extraction data and
  LLM responses
- den_Hartog_230.pdf, den_Hartog_231.pdf, 1970_den_Hartog__Seagrasses_of_the_World 230/231.pdf
  — source flora pages
- herbarium.jpg (cover), herbarium_logo.png (logo)
- Language_Models.Rproj — RStudio project (note the folder/Rproj
  name mismatch; see Next Steps)

## Related Projects
- **LLM_Creates_R** / **LLM-API-R** — the broader LLM-as-research-
  tool family; this is the botany-domain application.
- **labelextractr** (proj_labelextractr.md) — also works on
  herbarium-sheet data; possible shared ground.
- **Jones Collection** (proj_jones_collection.md) — same
  human + AI recovery-of-text methodology in a different domain.

## Next Steps
1. None required — the document is posted and Complete. Optional:
   extend the proof-of-concept demonstrations into a fuller
   treatment.
2. Folder / Rproj / slug naming is inconsistent (folder
   `Deconstructing_a_Flora`, Rproj `Language_Models.Rproj`, posted
   slug `deconstructing-a-flora`). Fold into the folder-rename
   standardization (priorities.md item 6).

## Collaborators / Dependencies
- LLM assistance (the document's subject and method).

## Blockers
None.

---
## Log

### 2026-05-30
Project file created during the status/focus-readiness back-fill
session, as an intake for one of five posted kimbridges-documents
that had no proj_*.md. Kim located the folder and moved it into
G:\My Drive\Projects\Deconstructing_a_Flora\. Filed with the
state observed: a three-chapter Quarto book (den Hartog seagrass
worked example + herbarium-label LLM extraction), rendered to HTML
and PDF, posted live. Marked Status: Complete / Focus readiness:
Not applicable per Kim's rule that a project with a posted entry on
the website is Complete (kept in the Projects folder, no archive).
Naming inconsistency (folder vs Language_Models.Rproj vs posted
slug) noted for the folder-rename standardization in priorities.md.
