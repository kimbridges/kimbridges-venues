# Document plan — "A Checklist Is an Argument"

_Created: 2026-07-08_
_Home: G:\My Drive\Projects\checklistr\documentation\ (per style_multichapter_doc.md §1)_
_Publishes to: kimbridges-documents.netlify.app/checklistr/_

## Title & framing
- **Title:** A Checklist Is an Argument
- **Subtitle (working):** Reconstructing a flora from herbarium records — and reading its uncertainties
- **Author field (_quarto.yml):** "K. W. Bridges" (per style guide); collaboration with Claude
  acknowledged in the Preface (joint-authorship theme, cf. coenosr/seasonalityr). — Kim to confirm.
- **Register:** **conceptual-base-dominant** (style guide §9), like whittakerr. The argument — that a
  checklist is a reconstruction, not a fact — is the point; the `checklistr` how-to rides along. Tone
  declarative and honest, short sentences, plain language.
- **Companion package:** checklistr (LIVE: github.com/kimbridges/checklistr). Chapters run
  `library(checklistr)`; a function-reference appendix is standard (style guide §3).

## The spine (thesis)
A checklist looks like a list of facts. It is really a **reconstruction** assembled from preserved
specimens — every field a claim with a provenance and an uncertainty. `checklistr` surfaces those
rather than hiding them. The through-line: **conflict marks where experts disagree**, and it comes in
two flavors the document separates —
1. the record disagreeing with **itself** (one Bishop sheet, two determinations), and
2. the authorities disagreeing with **each other** (GIFT vs Wagner on native status).
Both are treated as *data*, not noise.

## Origin story (Kim, 2026-07-08 — now the Preface opening)
Kim has walked the Kīpuka Puaulu loop trail for decades; for years he brought students and taught them the
name of nearly every plant along the trail. Visits are infrequent now, he is not teaching the names, and his
memory of some has faded. Walking the loop recently he found himself reaching for a **checklist** — one quick
scan and the forgotten name pops off the page. But *where do you get a checklist for a particular place* — not
a whole-island field guide, but a list for this trail? No easy answer, not for Kīpuka Puaulu, not for other
familiar places, not for places he hasn't yet visited. **That question is where the project began.** This is
the human motivation that the abstract "casual question" stood in for; the Preface now opens with it.

**Theme it unlocks — the two readers / practical-aid-vs-argument tension:** on the trail you want the checklist
*simple* (a name to jog memory); but an honest checklist can't fake certainty it lacks. So the list serves two
readers at once — the one who knows the flora and needs only a reminder, and the one who doesn't and deserves
to be told which entries are solid and which are contested. The document holds this tension throughout. (Also
broadens the "hope": verify what we know, **refresh what we've forgotten**, and see where knowledge runs out.)

## Kim's framings to preserve verbatim (for the Preface / close)
- *"The tools give new access to centuries of both collections and botanical insight; we verify existing
  data and expose gaps — gaps in collections AND in our understanding of species histories and
  evolutionary relationships."*
- *"The places there is conflict are those well-known areas where experts disagree."*
- **Scale / taxonomic-collecting heritage (2026-07-08, Kim — the intellectual core of Ch. 3):**
  Collections rarely focus on a single point; they accumulate records from surrounding areas. If a
  collector knows a specimen for the region is already in the herbarium, she is unlikely to re-collect it
  at each sampling location. That is a **taxonomic** collecting heritage (one representative per taxon per
  region), not an **ecological** one (sample at every site). This is why a 2 km "checklist" is a regional
  taxonomic accumulation, not a point census — and why the **map was the key instrument**: the stacking
  on nominal localities *is* that collecting habit made visible.

## Chapters (the working scaffold — style guide §9)
Preface (`index.qmd`, prose) — the casual question; the reframe; the thesis; the shape of the journey.

1. **The casual question** (`the-question.qmd`) — "can you list the plants of Kīpuka Puaulu from
   herbarium records?" → a checklist is a *taxonomic reconstruction at a regional scale*, not a point
   census. Introduces the site + `fetch_specimens_gbif` / `build_checklist`. Seeds scale.
2. **Who collected it, and when** (`collectors.qmd`) — collector/date lenses; the three eras; the
   1979–80 survey dependency (79% single-collector). Figure: collector activity + discovery-by-collector.
3. **The question of scale** (`scale.qmd`) — **the pivot chapter.** The map; nominal-locality stacking;
   "one per taxon per region" as taxonomic (not ecological) heritage; why this governs everything after.
   Figure: `map_specimens` (Kīpuka). CONCEPTUAL — needs an ideation file.
4. **How complete is it?** (`completeness.qmd`) — accumulation, 64% singletons, Chao/estimators — now
   sharpened by scale: the estimators assume ecological sampling; taxonomic collecting inflates
   singletons structurally. Caveats: herbarium inflation; GBIF ≠ the flora (digitization gap).
5. **The same specimen, two names** (`conflict.qmd`) — determination conflicts; det_conflict; phantom
   taxa. *Conflict flavor one.* CONCEPTUAL — ideation file.
6. **What grows there** (`lifeform.qmd`) — lifeform as the organizing field (trees vs herbaceous); the
   fern-vs-mesic ecological signal; GIFT + clade fallback; the "typical habit" honesty.
7. **Native, or not?** (`status.qmd`) — status as a species×place relation; `add_status` + `status_gift`;
   the GIFT-vs-Wagner verification; the 14 disagreements. *Conflict flavor two — the climax.* CONCEPTUAL.
8. **Two islands** (`two-islands.qmd`) — Kīpuka vs ʻIliau contrast; the georeferencing-*style* difference
   reads as different collecting behavior/era. Shows the tool generalizes. Figure: combined discovery curve.
9. **Limits and the frontier** (`limits.qmd`) — the honest close: taxonomy is a moving target; status is
   coarse; the crosswalk is lossy; run-your-own-site invitation; the larger point (Kim quote 1).

Appendix (`appendix.qmd`) — function reference for `checklistr`, grouped by workflow stage.

## Figure / data manifest (mostly already built)
Data (copy cached CSVs into `documentation/data/` so chapters render fast without live GBIF pulls; SHOW
the generating `checklistr` code, code-folded):
- `kipuka_puaulu_checklist_generated.csv` (name/family/class/n_records/det_conflict/lifeform/status +
  gift/wagner + status_agree) — Projects\checklists\kipuka_puaulu\
- `kipuka_puaulu_specimens_dedup.csv`, `status_gift_vs_wagner_disagreements.csv`
- `iliau_loop_checklist_generated.csv`, `iliau_loop_specimens_dedup.csv`
Figures already rendered (regenerate live where cheap; else pull PNGs into `images/`):
- collector activity + collecting history (dedup); species discovery + sample accumulation; collector
  composition + contributions; specimen maps (both sites); combined discovery curve.

## Conventions (from style_multichapter_doc.md)
- Quarto **book**; `_quarto.yml` per §2 (code-fold, silent execute, toc, number-depth 2).
- Each code chapter: 1–3 intro paragraphs → repeated **setup chunk** (`library(checklistr)` +
  tidyverse/gt/ggplot2; `## install_github("kimbridges/checklistr")` comment) → `##` subsections with
  labeled chunks. Comments on their own line; sequential named steps; parenthesize arithmetic.
- `gt` tables with source notes; **one figure per width, stacked**; Okabe-Ito for any built infographics.
- Cover `checklistr_cover_art_text.png` + logo `checklistr_logo_art.png` (TBD).

## Next steps
1. Kim reacts to this plan + the drafted Preface (`index.qmd`).
2. Scaffold: `_quarto.yml`, chapter stub `.qmd`s (title + intro placeholder + setup chunk), `appendix.qmd`.
3. Ideation files (`background/chapter_<name>_ideas.md`) for the conceptual chapters: scale, conflict,
   status (and maybe the completeness caveats).
4. Copy cached data into `documentation/data/`.
5. Draft chapter-by-chapter (Kim reviews each), Preface → Ch.1 → Ch.3 (scale) as the anchors first.
6. Cover/logo art; deploy to kimbridges-documents (style guide §7).
