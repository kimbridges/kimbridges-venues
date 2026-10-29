# Priorities
_Created: 2026-05-27_
_Last updated: 2026-10-28 -- rebuilt after PubMaps; every item checked against the files_
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

## ▶ RESUME HERE (2026-10-28)

PubMaps is paused on other people: Will McClatchey's read of the Editor's Guide, and GeoNames' answer on the premium account (Kim emailed them 2026-10-28). It had interrupted Rehearsals, and travel to the mainland and family matters came before that. Nothing below is on a deadline except one item in section 5 (hflip, about February 2027). Every item was checked against the files on 2026-10-28.

### 1. Choose the next Active Focus (Kim)

| # | Item | State | Where |
|---|---|---|---|
| 1.1 | **Rehearsals before the field** | The focus PubMaps interrupted. Capture only; no intake yet. Gallery focus ruled 09-29; Huntington test case done 09-30 ("what a quick look should produce"); 15-item cautions checklist. Next: confirm as focus, choose a practice site, decide simulations first or Exercise A first. | `ideas_rehearsals.md` |
| 1.2 | **The trilogy** (MRC, MWT, S3) | All three outlined 09-23; MRC read first. Next: data sources. MWT cites the Voronoi book. | `ideas_three_documents.md` |
| 1.3 | **icons** | Blocked on photographs (Kim). | `proj_icons.md` |

Claude's suggestion (not ruled): Rehearsals first. It follows directly from the Voronoi book and tessellr while both are fresh, and the trilogy will cite it.

### 2. Waiting on others

| # | Item | Where |
|---|---|---|
| 2.1 | **PubMaps** -- Will's feedback on Part I; GeoNames premium refuses the username (Kim emailed 10-28). Then guide/package updates and Part II (Methods). | `proj_PubMaps.md` |

### 3. Claude can do (worked 2026-10-28)

| # | Item | State | Where |
|---|---|---|---|
| 3.1 | **Two stale PROSE claims about Quarto Pub** -- source: `Projects/plainmaps/index.qmd` L14, `Projects/R_Basics/index.qmd` L11. Draft replacement ("my kimbridges-documents website") given to Kim. Then re-render both books, copy to the venue, deploy. | **closed 10-28** -- deployed, verified live by content | `deferred.md` -> ISSUU (kept item) |
| 3.3 | **Active-status sweep** -- 30 Active. Proposed: checklists, vouchr -> Complete; PKM, Travel -> Standing; coenosr + Ceska -> Kim's call (PDF delivered; package has 2 of the COENOS functions). The other 24 are genuinely unfinished. | **done 10-28** (Kim: coenosr + Ceska Complete). Active 30 -> 24 | `proj_PKM.md` |
| 3.4 | **Repo/clone mismatches** -- 7 -> 2 real. `pkm_health.R` now checks `C:/repos`, matches case-insensitively, reads the repo list authenticated, and carries `CLONE_ACCEPTED` (accessOAI, geContour, milestones, plainmaps, Temperature_Patterns -- each checked file by file against GitHub). **listsr PUBLISHED 2026-10-28** (Kim approved; verified on the server and by `install_github`). Left: **AI_Microscope** (clone still in OneDrive -> housekeeping). | **done** | `proj_listsr.md` |
| 3.5 | **Credential audit** -- 93 Drive folders (photo/media folders and the Projects_Index archives skipped); all five venues CLEAN. 4 hits: a Gemini key in `Projects/AI_Microscope/index.html` (NOT on the live site, GitHub HEAD or the clone); **a different Gemini key in the public history of `kimbridges/ai_microscope` (first commit d0f4e6c, 2026-07-21)**; the revoked 2024 Anthropic key in `LLM_API_R/_backup/`; two old Google Maps keys in `Han/` (2018, 2021). **Checked 2026-10-28:** the AI_Microscope Gemini key is DELETED (it is one key, in both places); the two Han/ Maps keys are STILL VALID -- Kim to delete or restrict. **Claude exposed the `GGMAP_GOOGLE_API_KEY` Maps key (...xUsU) in tool output (Finding 056) -- Kim to replace it. The Gemini key was NOT exposed.** Han keys end nFOE / Pv8k. **16:35: Kim replaced the Maps key and deleted xUsU, nFOE and other unused keys; Pv8k pending his check of its traffic.** **17:20: dead key text redacted from the three files (each re-probed dead first); Pv8k now reports 'expired' to Geocoding -- confirm in Console, then decide on Site_Info.Rmd L97. pkm_secret_scan now knows the 53-char `AQ.` auth-key format (pattern `google_auth`).** **19:07: Kim deleted Pv8k; Site_Info.Rmd L97 redacted. CLOSED -- credential cleanup complete.** 19:10: Site_Info.Rmd L97 now reads the key from .Renviron (`Sys.getenv("GGMAP_GOOGLE_API_KEY")`). Results: `C:/temp/secret_audit_2026-10-28/`. | **closed** | this file |
| 3.6 | CRLF finding -- **already written as Finding 037 (2026-08-19)**; the three stale PKM tasks in `deferred.md` closed. Card gained a 037 row. | **closed** | `pkm_findings.md` |
| 3.7 | **Size budgets** -- `deferred.md` 212 -> 193 KB (settled blocks moved verbatim to `logs/deferred_closed.md`; 46 open items unchanged); `proj_seasonality` 51.6 -> 25.2 and `proj_audio` 47.5 -> 14.0 (logs split, LF kept -- `split_tail()` writes CRLF); card 6.4 -> 6.0 (and its split Rule sentence rejoined). Left: `session_log.md` 421 vs 250 (marked not splittable -- Kim decides) and `proj_Smart_Car` 66 vs 45 (the body, not a log -- condensing it is Kim's call). | **closed 10-28** -- session_log 427 -> 144 KB (pre-09 to the archive's top); proj_Smart_Car 65.9 -> 30.7 (settled sections to its log). Nothing over budget. | health report |
| 3.8 | **Drift** -- all cleared: audio and R_LLM_tests paths corrected; listsr, checklists, sitemaps, vouchr notes added. `pkm_drift()` = 0. | **closed** | health report |


### 4. Kim's own -- decisions

| # | Item |
|---|---|
| 4.3 | **`R_LLM_tests` vs `LLM_Creates_R`** -- retire, merge, or keep separate. Open since May. |
| 4.4 | **Braun-Blanquet duplicate synthetic CSVs** -- keep bbSynth as the source of truth. |
| 4.5 | **Folder-rename standardization** -- folder name / posted slug / proj name. |
| 4.6 | **Editorial reorganisation of *Experiments with LLMs*,** plus a possible 2026 afterword. |
| 4.7 | **From PubMaps (deferred):** ~~uninstall R 4.3.3 / Rtools43~~ (done 10-28, with R 4.2.1; ~8.6 GB freed); ~~Gemini key~~ (working 2026-10-28); delete `PubMaps/_archive`. |

### 5. Housekeeping

- **hflip ends about February 2027.** Two links in kimbridges-collections source (`Gallery/Gallery_Catalog/index.qmd`, `Stage.qmd`) point at `kim.hflip.co/gallery_catalog.html` and die with the account. The one dated item here. (`proj_PKM.md`)
- **`C:/temp` scratch:** delete once Kim agrees -- `voronoi_build_2026-09-27b`, `voronoi_build_2026-10-27`, the five `pubmaps*` folders, `pkm_close_2026-09-26` / `-09-27`, `tessellr_staging` (tessellr is on GitHub). **KEEP `rehearsals_huntington_2026-09-30` -- the only copy of the Rehearsals working files; move it to G: at intake.** (`C:/temp/_site` and `_site_20260726` are already gone.)
- ~~`ai_microscope` clone in OneDrive~~ -- **re-cloned to `C:/repos/ai_microscope` 2026-10-28** (666c245, autocrlf set, contents matched). Kim to delete the old `OneDrive/Documents/ai_microscope` folder (the bridge cannot).
- **`C:/Quarto/storylines`** -- an obsolete June-2024 copy (published to the closed Quarto Pub); nothing unique worth keeping, no unsaved buffers. Kim to delete `C:/Quarto` (checked 2026-10-28).
- `Gallery_Catalog/_publish.yml` still declares `kim.quarto.pub`. Harmless, misleading.
- Verify the kimbridges-collections `_site` drag of 2026-08-02 -- still unconfirmed.
- `kimbridges-documents/inventory_of_sources.txt` still present -- check whether it is published.
- `kimbridges-stories/underway/2023_Japan_Story/` still present (published 2026-08-02). `underway/Selective_Focus/` is gone.

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
- **PubMaps Part II (Methods)** -- after Will's input.
- **tessellr 0.2.0** -- simulation helpers, if Rehearsals goes ahead.


---

## Closed since 2026-09-27

Kept short; the evidence is in `session_log.md`. Earlier closed lists are in `logs/priorities_history.md`.

- **Voronoi citations** closed 2026-09-29; **1974 map permission** received 2026-10-27 (PCSU credit added, book rebuilt, deployed and verified live).
- **PubMaps** -- `pubmaps` 0.2.0 public at github.com/kimbridges/pubmaps; *PubMaps: Study-site maps for journal editors* Part I live at kimbridges-documents/pubmaps/ (2026-10-27).
- **Every document cover now carries its name** -- checklistr, lists, PubMaps (10-27); nine more plus Sitemaps and gePoints (10-28). All verified live.
- **Dead Quarto Pub links** -- none remain in kimbridges-documents (checked 2026-10-28).
- **The ground-truth rule** replaced Findings 001/005/013/015 in `pkm_card.md`.
- **Kim, 2026-10-28:** SoundCloud account DELETED; Exposure account CLOSED (both lost Exposure stories were published 2026-07-31); the `coenosr` print-ready PDF made and MAILED to Dr. Ceska.
- `C:/temp/_site` and `_site_20260726` deleted; `underway/Selective_Focus/` cleared.
