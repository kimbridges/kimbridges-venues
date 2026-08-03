# PROJECT: Pedigree diagrams
_Last updated: 2026-05-30_
_Status: Complete_
_Focus readiness: Not applicable_

## Type
R tool + Quarto document (git-tracked; deployed to
kimbridges-documents)

## Objective
Wrappers and worked examples that make it simple to build small
pedigree, kinship, and lineage diagrams in R. The tool side wraps
the underlying diagram code; the document side demonstrates the
range of options (colors, symbol shapes, segment styling) on real
family examples.

## Current Status
Complete and posted as "Pedigree Diagrams" in the
kimbridges-documents collection (categories: R, Data Analysis). A
git-tracked Quarto project at G:\My Drive\Projects\Pedigree_diagrams\
with a configured GitHub remote. Two worked examples: Furumoto
(small diagrams of an extended family's relationships) and
Kinship_Visualization (the broader discussion showing the
available variation). Rendered output present (`_output/`,
`Kinship_Visualization_files/`, `figures/`). Status is Complete
per the posted-on-website rule (2026-05-30).

Recovered 2026-05-30: one of five posted documents that had no
proj_*.md. Kim located the folder and moved it into
G:\My Drive\Projects\.

## Locations
- Code / source: G:\My Drive\Projects\Pedigree_diagrams
- Output: G:\My Drive\Projects\Pedigree_diagrams\_output and
  Kinship_Visualization_files/, figures/
- Local git: G:\My Drive\Projects\Pedigree_diagrams\.git
- GitHub: https://github.com/kimbridges/Pedigree_diagrams
  (origin/main configured)
- Deployed: kimbridges-documents.netlify.app/docs/pedigree-diagrams

## Key Files
- README.md — overview ("mostly wrappers... to build small
  pedigree diagrams"; names the two examples)
- Furumoto.Rmd — the extended-family worked example
- Kinship_Visualization.qmd — the broader options walkthrough
  (colors, symbol shapes, segments, shading)
- figures/, Kinship_Visualization_files/ — rendered figures
- cover_ped_art.png (cover), logo_ped_art.png (logo)
- Pedigree_diagrams.Rproj — RStudio project

## Related Projects
None tightly coupled. A standalone R-visualization document; sits
alongside the other kimbridges-documents R tools.

## Next Steps
1. None required — posted and Complete. The git remote already
   exists, so the source is preserved on GitHub.
2. Confirm folder name vs posted slug (`pedigree-diagrams`) in the
   folder-rename standardization (priorities.md item 6).

## Collaborators / Dependencies
None.

## Blockers
None.

---
## Log

### 2026-05-30
Project file created during the status/focus-readiness back-fill
session, as an intake for one of five posted kimbridges-documents
that had no proj_*.md. Kim located the folder and moved it into
G:\My Drive\Projects\Pedigree_diagrams\. Filed with the observed
state: a git-tracked Quarto project (remote
github.com/kimbridges/Pedigree_diagrams) with two worked examples
(Furumoto, Kinship_Visualization), rendered and posted live.
Marked Status: Complete / Focus readiness: Not applicable per
Kim's posted-on-website rule. Among the recovered five, this one is
the most cleanly preserved — it already has a GitHub remote.
