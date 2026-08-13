# Priorities
_Created: 2026-05-27_
_Last updated: 2026-08-12 — Selective Focus published; item 1.1 closed_
_Log: logs/priorities_history.md_

## Purpose

The curated ORDER of work in front of Kim right now. Opened first when a
session needs to pick up where the last one left off.

**The rule this file lost, now written down: `priorities.md` holds the ORDER,
`deferred.md` holds the DETAIL.** The old file duplicated item text, so every
item had to be pruned in two places and neither got done — it sat eight weeks
stale while its own first entry read "freshen this file." One line per item
here, pointing at the file that carries it. If an entry needs a paragraph, the
paragraph belongs in `deferred.md` or the `proj_*.md`.

Active Focus pointer: `project_index.md`. Session detail: `session_log.md`.
Real-but-not-now: `deferred.md`. Session rules: `pkm_card.md`, then
`pkm_protocol.md`.

---

## ▶ RESUME HERE (2026-08-11)

Kim returned 2026-08-11 from a week on the mainland (family — brother's heart
attack, now recovering in rehab). Last working session was 2026-08-03. Nothing
below is on a deadline.

### 1. ★ HIGH PRIORITY — the unprocessed stories

Kim's call, 2026-08-11. **Both sets of source material were already in the
PKM** — no search needed. Located under `kimbridges-stories/underway/`, with
cover images already staged in `images/`. **1.1 published 2026-08-12; only
Smart_Car remains, and it is not a story.**

| # | Item | State |
|---|---|---|
| 1.1 | **Selective_Focus** — ~~`underway/Selective_Focus/`~~ | **✔ PUBLISHED 2026-08-12** as *Selective Focus with Focus Stacking* (`/stories/selective-focus-with-focus-stacking.html`). Kim revised it to **v2** first — equipment section rebuilt around his current lens collection. 35 pp. Rendered and staged; awaiting his Netlify drag. |
| 1.2 | **Smart_Car** — `underway/Smart_car/`, nine files. | **NOT quick — this is a project, not a story.** See below. |

**Smart_Car is mis-scoped as a story and needs re-filing.** `README.md`
(2026-05-08) is a full project charter: *TwoRed 75,000 Miles Celebration*, a
data-rich reproducible **Quarto book**, five chapters, R with `dplyr`/`sf`/
`tidygeocoder`/`elevatr`/`gt`/`ggplot2`. Thesis: refute the assumption that a
Smart car is an urban-commuter-only vehicle, using ~300 fill-ups, the 4th
Crossing time-zone-adjusted log, and topographic extremes (Mount Evans, Death
Valley). Assets present: `Smart_Car.docx` (10.5 MB), `Smart_Car.pptx` (2016),
`TwoRed_fuel_June_2014.xlsx`, `2016 Fourth Crossing Analysis.xlsx`,
`Smart_Car.pdf` (the master dictionary), two photographs.

It has **no `proj_*.md` and no index row** — an intake gap of the same shape as
Jones and vouchr. Charter written 2026-05-08, dormant since. Its two "next
immediate steps" are already specified: the ingestion script that assigns an
`Expedition_ID` to every fill-up, and the Chapter 1 geocoded constellation map.

**Ranunculus_Impressions — CLOSED 2026-08-11 (Kim): a duplicate.** The real
stories are live as `ranunculus-at-flower-fields` and
`ranunculus-asiaticus-variability`. `images/Ranunculus_Impressions.jpg` is a
stray cover; delete it or leave it, but it is not a missing story.

### 2. Claude can do

| # | Item | Where |
|---|---|---|
| 2.1 | **Two stale PROSE claims about Quarto Pub.** `plainmaps/index.html` L233, `r_basics/index.html` L214. Sentences, not links — no audit will ever flag them. Fix at source, re-render. Kim's wording, so Kim's call on replacement text. | `deferred.md` → Legacy platform links |
| 2.2 | **Three dead Quarto Pub links still outstanding.** `r_basics/index.html`, `using_an_llm/Plainmaps.html`, `using_an_llm/Resources.html`. Source = `Projects/R_Basics` and `Projects/LLM_Creates_R`. Unify the API-use descriptions in the same pass — same files, one render cycle. | `deferred.md` → Legacy platform links |
| 2.3 | **Six repo/clone mismatches** (open since 2026-07-30). Confirm `listsr` is not simply PRIVATE before concluding it is missing. | `deferred.md` → Consolidation |
| 2.4 | **Credential audit of the rest of Drive.** Run `pkm_secret_scan()` per-project in batches — unfiltered it hung the bridge. `.Renviron` is not a finding. | `deferred.md` → Consolidation |
| 2.5 | **Three findings to write:** the CRLF hazard, the device-bridge staging hazard, and collapsing 001/005/013/015 into the one ground-truth rule. | `deferred.md` → PKM |
| 2.6 | **`coenosr` → print-ready PDF for Dr. Ceska.** Carried since 2026-07-09, never started. Needs TinyTeX plus page-layout tweaks. Bounded and self-contained. | `proj_coenosr.md` |
| 2.7 | **The Active-status sweep.** 28 `proj_*.md` still read Active. Apply the deployed→Complete rule one at a time — the automated scan OVER-SELECTS. | `proj_PKM.md` |
| 2.8 | **Prune the closed ISSUU / Exposure / SoundCloud blocks out of `deferred.md`.** They are the bulk of that file and all three are now settled. Keep the reasons, per the WON'T-DO rule; drop the working detail. | `deferred.md` |

### 3. Kim's own — decisions, not memory

The memory items are all resolved as of 2026-08-11.

| # | Item |
|---|---|
| 3.1 | **SoundCloud — one check before deleting the account.** Compare the SoundCloud track list against the local files. Migration is complete; the residual risk is a track uploaded and never embedded, which nothing here can see. |
| 3.2 | **Exposure — confirm the gate mechanically, then delete.** Both lost stories were published 2026-07-31. Run `pkm_health()`, confirm Exposure gaps = 0, then delete. Do not close it by assertion. |
| 3.3 | **`R_LLM_tests` vs `LLM_Creates_R`** — retire, merge, or keep separate. Open since May. |
| 3.4 | **Braun-Blanquet duplicate synthetic CSVs** — keep bbSynth as the source of truth, remove the copies in bbstruct and Braun_Blanquet. |
| 3.5 | **Folder-rename standardization** — folder name ↔ posted slug ↔ proj name. Root cause of several recurring tangles. |
| 3.6 | **Editorial reorganisation of *Experiments with LLMs*,** plus a possible 2026 afterword. Only Kim can judge which early tests to group or retire. |

### 4. Housekeeping loose ends

- `C:\temp\_site` + `_site_20260726` — 226 MB, both regenerable, past the 14-day bucket-4 retention.
- `ai_microscope` clone: set `core.autocrlf`, decide its permanent home (bucket 5, `C:\repos\`).
- `Gallery_Catalog/_publish.yml` still declares an obsolete `kim.quarto.pub` URL. Harmless, misleading.
- Verify the kimbridges-collections `_site` drag actually happened — it was "awaiting Kim's drag" on 2026-08-02 and no later entry confirms it.
- `kimbridges-documents/inventory_of_sources.txt` — check on the next deploy to that venue.
- `underway/2023_Japan_Story/` is a leftover working folder; that story published 2026-08-02 as `japan-fall-2023`.

---

## ★ NEW — captured 2026-08-11

Kim used the travel time to think about new projects. Captured on arrival;
formal Mechanism 1 intake (venue / language track, `proj_*.md`, index row) is a
separate exercise when he is rested.

**Three interrelated documents, to be developed in parallel.** Working titles:
*Baselines, Deviations & Spans*; *Maps with Tiles*; *Measurements Require
Categories*. Unifying claim: **you don't see something unless you have a concept
of it.**

**Detail: `ideas_three_documents.md`** — Kim's outline as given, plus five open
problems (the "Maps with Tiles" title collision with web map tiles; discovery
order vs exposition order, which decides three-documents-or-one-book; the
counterexample chapter the trilogy needs; package boundaries before parallel
writing; parallel ideation but staged production).

**Kim's rulings 2026-08-11:** three documents (open to further analysis), outlines first, NOT written all at once, reuse the existing packages. **★ He also promoted the INVERSE** -- that a concept makes you see what is not there and stops you seeing alternatives -- from a chapter idea to a general working principle, linking it to falsification. Candidate for `pkm_findings.md` or the card; his call, not acted on. Round two of his thinking pending, then outlines, then formal intake.

---

## Longer horizon — real, not scheduled

- **The dozen or so trips with stories written but photos never added.** Kim,
  2026-08-02: "Attending to these will become part of our activities after the
  other things get done." Recorded so it is not rediscovered as a surprise.
- **`vouchr` 0.1.1** — the `discover_decks()` cluster-numbering mapping.
- **`specimen_labels` log split** to `logs/` — the largest proj file in the
  system and the only one that skipped the 2026-07-28 split. Kim's call: the
  split comes when that project is actually finished.
- **Style alignment** of the older Quarto documents (sitemaps, storylines,
  Colors_of_the_Year, R_Basics, LLM_Creates_R, likely Braun_Blanquet) against
  `style_multichapter_doc.md`.
- **`style_guide.md` / `R_style_guide.md`** as stable references.
- **PKM deep review** of the eight queued whittakerr-derived meta-observations
  (proj_PKM log, 2026-05-15 → 05-23). Its own session.
- **photoPress / photobookr / Photo_Book cluster consolidation** — once enough
  examples have run through photobookr to prove parity with Photo_Book.

---

## Closed 2026-08-12

**Selective_Focus — PUBLISHED**, and not as the file that was sitting there.
Kim found the original materials in his photos archive, judged the story
*interesting and somewhat useful*, and rewrote the useful half: the equipment
section now reflects his current lens collection (Sony 50-150mm f/2 GM against
the 90mm macro), plus a computer promoted to essential field gear, a seven-step
camera setup in memory slot 3, and the focus-and-pad method for placing near
focus. Published from `Selective_Focus_v2_compressed.pdf`; the venue copy drops
the working suffix. Dated 2026-08-12 so it sorts as new work.

**Two drifts found in passing, both still open.** `stories_inventory_v2.xlsx`
is stale — last written 2026-06-23, missing three stories added by hand since,
so the README's claim that it is the source of truth is no longer accurate.
And `underway/Selective_Focus/` still holds both PDFs; neither bridge deletes.

---

## Closed 2026-08-11

**ISSUU — CLOSED ENTIRELY.** Kim: every story once on ISSUU has been moved to
the current site. **Verified rather than accepted**, and the evidence is
stronger than the record was:

- All four booklets are published stories with PDF, cover and page in place —
  `finding-fine-wine`, `bordeaux`, `bordeaux-2`, `japan-fall-2023`.
- **`bordeaux_2` was recorded in `deferred.md` as "no known source, the one
  real gap." That is wrong.** `pdfs/Bordeaux_2.pdf` and
  `images/Bordeaux_2.jpg` are present and deployed to `_site`.
- **`Projects/AI_Podcasts/Travel.qmd` contains ZERO mentions of ISSUU** — the
  four pointers and the "available on an ISSUU website" prose claim are already
  gone. The open item in `project_index.md`'s AI_Podcasts row is stale and
  should be struck at the next index edit.

Nothing is at risk on that platform and nothing points at it. The recovery
task, the repointing task and the prose fix are all closed.

---

## Closed since this file was last curated (2026-07-09)

Kept short; the evidence is in `session_log.md`.

- **The whole legacy-platform cleanup.** Quarto Pub, Exposure and hflip all
  cancelled 2026-07-31; SoundCloud migration complete 2026-08-02; the last
  non-historical legacy link closed 2026-08-03.
- **Both lost Exposure stories recovered and published** 2026-07-31 — *Cinque
  Terre Impressions* (43 pp) and *The Washington Monument* (23 pp).
- **The consolidation migration delivered** 2026-08-03 —
  github.com/kimbridges/kimbridges-venues, 969 blobs including the PKM itself.
  The source for all 79 published works no longer exists in exactly one place.
- **The April-2024 Anthropic API key revoked** 2026-08-03; `pkm_secret_scan()`
  now gates every commit.
- **Three documents published** — *Voucher Labels* (07-29), *AI Podcasts*
  (08-02), *Experiments with LLMs* (08-03). Twenty-two documents live.
- **`pkm_health.R` delivered** 2026-07-30 — this is the "Phase 2 R script"
  that sat in the held queue since May.
- **`works_register.md`** supersedes the old "update `inventory_all_projects.md`"
  item, which is closed rather than carried.
- **Kaka'ako Birds** published 2026-06-23 — the Acrobat blocker that headed
  this file since June is long resolved.
- **vouchr documentation illustrations** — done; the decks were printed and
  photographed 2026-07-28.
- **The five recovered documents** all filed with `proj_*.md`.
