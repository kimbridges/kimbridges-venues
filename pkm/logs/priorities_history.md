# Priorities — History

_Split out 2026-08-11. This is the priorities.md that stood from 2026-05-27 to 2026-08-11,
verbatim and unedited below the line. It had drifted eight weeks out of date; the live
file was rebuilt as a working resumption pointer. Nothing here is deleted — the record
of what was true at the time is preserved, per the renames rule in pkm_card.md._

---

# Priorities
_Created: 2026-05-27_
_Last updated: 2026-07-09 (checklistr shipped + closed; added the 2026-07-10 starting list below)_

## Purpose

This file holds the curated ordering of work in front of Kim at
any moment. It is the resumption pointer between sessions —
opened first when a new session needs to pick up where the last
one left off, edited as priorities shift, and pruned as items
complete.

For session-by-session detail see `session_log.md`. For
per-project status see the `proj_*.md` files. For the Active
Focus pointer at any time see `project_index.md`. For the
folder-level inventory built at the close of this cycle, see
`listing_projects.md` and `listing_kimbridges.md`.

## ▶ Next session — starting list (2026-07-10)

Small tidy-ups surfaced 2026-07-09, at the close of the checklistr project (package + document both shipped; Active Focus slot now OPEN). No deadlines; do the light ones first. Big Island trip next week (obon + pueo photography) may interrupt.

**Claude can do:**

1. **Freshen this file (`priorities.md`).** It had drifted (was dated 2026-06-07): item 5 below — "file the five recovered docs" — is DONE (all five `proj_*.md` exist); the "next focus = the stories realm" pointer is long past; and four documents have shipped since (coenosr, lists, seasonalityr, checklistr). Prune the completed items and refresh the pointer.
2. **`inventory_all_projects.md`** — add the recent Netlify documents (checklistr, coenosr, lists, seasonalityr) and confirm the four-sites / Jones Collection note (long-standing item in proj_PKM.md Next Steps).
3. **coenosr → a print-ready PDF** for mailing a copy to **Dr. Ceska**. Needs TinyTeX + a couple of page-layout tweaks (Quarto *book* → single PDF). The meatiest of the small items, but bounded and self-contained.

**Kim's own (security / decisions / deletions — flagged, not Claude's):**

- Rotate + remove the **timelinesr** `documentation/extra_code/auth_token.txt` and the **vouchr** hard-coded Google API key (in the `QR_procedures.Rmd` prototype) before any public push.
- **Braun-Blanquet** duplicate synthetic-CSV cleanup (keep bbSynth as the source of truth) + the **folder-rename** standardization (folder ↔ posted slug ↔ proj name).
- **R_LLM_tests vs LLM_Creates_R** — retire / merge / keep-separate decision.

**Near-term real work (waiting on hardware):**

- **vouchr documentation illustrations** — the key remaining element of that document; blocked on the screw-posts (delivery expected ~2026-07-10/11). When a deck is assembled: photograph the real cards and/or build the diagram figures. Worth doing carefully — the decks are the document's creative heart.

## ⏰ Revisit reminder

**PAUSED 2026-06-23 on a broken-Acrobat blocker: Kaka‘ako Birds book.** Picked
back up 2026-06-23 — Dr. McClatchey's read came in positive (2026-06-15), and
Kim's photo-polish pass is done (placed set 59 → 68 images, all 19 chapters,
tag mismatches resolved, "Ringed Dove" → Spotted Dove fixed). **Assembly test
PASSED:** `build_kakaako_book()` rebuilt cleanly to **125 pp / 938 MB**
uncompressed, no images dropped; manifest active-image counts filled. **Blocked
on:** Kim's Acrobat is broken and won't reinstall, so two steps wait — (1) the
Acrobat compression (≈840 MB → ~9 MB) and (2) Kim's **two-page-spread visual
check** — then (3) deploy to the kimbridges-stories website. **Resume when
Acrobat is back.** Rebuild anytime: edit `Stories/*.md` → `build_kakaako_book()`
(see the Kakaako_Birds `book_manifest.md`). Claude's queued photobookr
enhancements: clickable bookmarks, spread parity-padding, resample/sharpen. See
proj_kimbridges_stories.md 2026-06-23 and book_manifest.md 2026-06-23.

## Current Active Focus

The Status / Focus-readiness back-fill (2026-05-30) is complete:
every proj_*.md now carries the structured fields, the template
gained a Paused status and a Tags field, and the five lost posted
documents were recovered and filed. **Next session's focus, set
2026-05-30: the stories realm.** Kim is moving from
Projects/documents into stories (kimbridges-stories/underway) and
wants the story-writing workflow to become collaborative.

Agreed in principle (to design first thing next session, then
exercise on a real story):
- No file-per-story; a single lightweight stories index keyed to
  the pipeline stage (structure set → photos placed → text
  drafting → front matter → rendered → deployed).
- Per-story working-notes / ideation file inside each
  underway/<story>/ folder — the stories analog of whittakerr's
  background/ folder. (A broader "ideas with no home" store is a
  separate, harder problem, kept apart for now.)
- Collaborative workflow on photobookr: Kim takes the photos; the
  folder/file structure (the EXIF-chapter-name convention) and the
  text are built together in Cowork, not text-alone in Google Docs.
- Bonus: real stories through photobookr double as the
  book-assembly cluster's pending parity test.

The remaining items below are real but non-blocking.

## Remaining open items (not blocking, no due date)

### Project-level decisions waiting on Kim

1. **R_LLM_tests vs LLM_Creates_R.** Substantial chapter
   overlap; working hypothesis is that R_LLM_tests is the
   experimental sandbox and LLM_Creates_R is the polished
   document. Decide whether the sandbox should be retired,
   merged, or kept separate. Documented in both proj_*.md.

2. **photoPress / photobookr / Photo_Book cluster
   consolidation.** Once a few examples have been run through
   photobookr to validate parity with Photo_Book, the cluster
   simplifies (photobookr as engine, Photo_Book as example
   data only, photoPress reviewed for remaining ideas — in
   particular the Quarto driver chapters and the
   package-level documentation pattern — then archived).
   Captured across all three proj_*.md.

3. **Braun-Blanquet cluster synthetic-data reconciliation.**
   The synthetic-block / synthetic-gradient CSVs appear in
   bbSynth, bbstruct, and Braun_Blanquet folders. Keep
   bbSynth as the generator of truth and remove the
   duplicates from the other two locations. Small task.

4. **timelinesr `documentation/extra_code/auth_token.txt`
   cleanup before any public push.** Capture and rotate the
   token if it is still active; remove the file from the
   working tree.

### Deferred filing (source-side gap for kimbridges-documents)

5. **Five kimbridges-documents entries have no project file
   at all.** Refined 2026-05-30 during the status back-fill,
   correcting the earlier seven-item list: **Deconstructing a
   Flora** (flora), **Pedigree Diagrams** (pedigree), **Photo
   Locations** (photolocations), **Plainmaps** (plainmaps),
   and **LLM-API-R** (r_api / llm-api-r — a newer tool, NOT
   accessOAI, which is an early separate R tool). The two
   dropped from the old list do have project files, under
   differently-named folders: colors → Colors_of_the_Year,
   using_an_llm → LLM_Creates_R. The deployed HTML at
   kimbridges-documents/<name>/ is authoritative; the source
   for each missing one presumably lives in a GitHub repo, an
   older filesystem location, or Quarto Pub history.
   **Progress 2026-05-30 — all five recovered.** Kim located
   every one and moved them into G:\My Drive\Projects\:
   **Deconstructing a Flora**, **Pedigree Diagrams**,
   **Plainmaps**, **Photo Locations** (at Photo_Locations —
   extracted from timelinesr, where its code had been
   embedded), and **LLM-API-R** (at LLM_API_R — it had been
   hidden inside something else). Folders recovered; each still
   needs a proj_*.md (intake). Filing each is a separate intake
   exercise — not blocking, but now unblocked by the recovery.

   **Finding (2026-05-30):** Extracting Photo Locations from
   timelinesr showed that **timelinesr needs proper
   documentation of its own** — the package was carrying an
   example document inside it rather than standing on its own
   docs. Add this to proj_timelinesr.md Next Steps when the
   status back-fill writes that file.

6. **Rename project folders to match their posted document
   names.** The mismatch between source folder names and the
   posted document slugs is the root of the confusion in
   item 5 (Colors_of_the_Year ↔ colors / colors-of-the-year;
   LLM_Creates_R ↔ using_an_llm; R_Basics ↔ r-basics; and the
   accessOAI ↔ llm-api-r tangle). Standardize so each
   project's folder name, its posted document slug, and its
   proj_*.md name agree, removing the unnecessary confusion.
   Surfaced by Kim 2026-05-30.

## Done — the 2026-05-27 / 2026-05-28 housekeeping cycle

A long list kept here as evidence the recent housekeeping
work happened. Full prose detail in session_log.md
entries for 2026-05-27 and 2026-05-28 (and the closing
addendum).

**Physical consolidation (2026-05-27).** ~24 Desktop folders
moved into G: canonical locations (15 to Projects/, 6 to
kimbridges-stories\underway\, 3 to kimbridges-collections\),
8 deleted as duplicates or empty, Koch_voronoi_pgm renamed
to Koch_voronoi.

**PKM catch-up (2026-05-28 morning).** Finding 005 written
up in pkm_findings.md; Tom Koch / Cranes row removed; 16 new
proj_*.md files for the consolidated Desktop projects;
proj_photobookr.md updated with the cluster cross-reference;
project_index.md final pass.

**Afternoon moves and additions (2026-05-28).** milestones_bars
documentation migrated into Projects_Archive; Cuisine_Art
moved into Gallery; Audio working folder populated; Ceska
added (Braun-Blanquet cluster expanded to four members);
photoPress consolidation via the C:\RProjects discovery
(cleaner git-tracked package now at G:\Projects\photoPress);
Community_Analysis and sitemaps added (Braun-Blanquet
satellites); six C: deletions (four C:\Users\kim\kimbridges-*,
the third stories copy on OneDrive Desktop, and the
deprecated PKM home on OneDrive Desktop).

**Closing pass (2026-05-28 evening).** kimbridges-info_old
backup deleted; PDF_archive reviewed and retired (two PDFs
preserved as new underway/ entries, four deleted); stub
proj_*.md files created for discussionsr and storylines (the
two Projects/ folders that the inventory pass surfaced as
gaps); summary listings built (listing_projects.md and
listing_kimbridges.md).

**Cumulative.** 33 proj_*.md files created or substantially
rewritten across the two days; four project clusters made
explicit; the "Projects Referenced but Not Yet Filed"
backlog from April retired in full; ten C: deletions
including the deprecated PKM home and all four
C:\Users\kim\kimbridges-* working copies plus C:\RProjects;
Finding 005 captured.

## Held queues (longer horizon)

These remain in the PKM but are not in the housekeeping
path:

- **PKM deep review** of eight queued whittakerr-derived
  meta-observations (proj_PKM.md log entries 2026-05-15
  through 2026-05-23). Its own session. The accelerating
  rate of meta-observations through the whittakerr work
  was itself one of the observations.
- **inventory_all_projects.md update** with the four
  Netlify sites and the Jones Collection (proj_PKM.md
  Next Steps).
- **Phase 2 R script for PKM health checks** (proj_PKM.md
  Next Steps). The two summary listings created in this
  cycle are the natural inventory the health-check script
  can drift-check against.
- **style_guide.md and R_style_guide.md** as stable
  references (proj_PKM.md Next Steps).
- **Style alignment** of older Quarto documents
  (sitemaps, storylines, Colors_of_the_Year, R_Basics,
  LLM_Creates_R, and likely Braun_Blanquet) against the
  whittakerr-derived `style_multichapter_doc.md`. Each
  document's proj_*.md Next Steps already calls this out.

---

_Superseded 2026-10-28. The priorities.md that stood from 2026-08-11 (last edited 2026-09-27), verbatim and unedited below the line. Its RESUME block dated from Kim's August return; PubMaps (10-24 to 10-27) and Rehearsals (09-29) had happened since. Rebuilt the same day from a check of each item against the files._

---

# Priorities
_Created: 2026-05-27_
_Last updated: 2026-09-27 (evening) -- Voronoi document + tessellr COMPLETE_
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

### 1. ✓ CLOSED — the two unprocessed stories

**Both resolved 2026-08-12. Kept as the record, not as work.**

| # | Item | Outcome |
|---|---|---|
| 1.1 | **Selective_Focus** | **✓ PUBLISHED 2026-08-12** as *Selective Focus with Focus Stacking* (`/stories/selective-focus-with-focus-stacking.html`). Kim revised it to **v2** first — equipment section rebuilt around his current lens collection. 35 pp. Rendered and staged; awaiting his Netlify drag. |
| 1.2 | **Smart_Car** | **✓ FILED AS A PROJECT 2026-08-12**, not a story — and reframed. `proj_Smart_Car.md` + index row + 20.6 MB moved to `Projects\Smart_Car` (bucket 2). Set **Active + Blocked**. |

**Smart_Car: Kim reframed it 2026-08-12 from one car to FOUR.** Sixteen years of Smart
ownership, two still owned, deepest data on the first (TwoRed). The thesis is unchanged and
stronger — not one exceptional car on one exceptional journey, but a sustained choice made
again three times.

**Why it left the priority list instead of topping it.** The largest section of the source
material is the Arctic Circle Challenge, **already a posted story** — so what remains is data,
not narrative, and three of the four cars have no machine-readable data at all yet. Kim will
recover it from paperwork in miscellaneous time. **Blocked, findable, and honest about why** is
a better state than sitting at the top of a list nobody can act on.

**Reading the data rather than the charter corrected three of its claims** — the Gas Log runs
2010-2017 not to June 2014, the odometer tops out at **71,181 not 75,000**, and the Trip Log is
7 rows not a dataset. Filed in `deferred.md` → Smart_Car rather than carried forward as fact.

**Ranunculus_Impressions — CLOSED 2026-08-11 (Kim): a duplicate.** The real stories are live as
`ranunculus-at-flower-fields` and `ranunculus-asiaticus-variability`.
`images/Ranunculus_Impressions.jpg` is a stray cover; not a missing story.

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

**Round two BEGAN 2026-09-22 (Baselines only)** and the trilogy is now the Active Focus; icons paused awaiting photographs. *Baselines* reframed around the scale between weather and climate; worked groups fire / vintage / tree rings; Hawai‘i a test case, not the setting; a shared visual language to tie the three documents together. Detail: `ideas_three_documents.md` → Round two. **Evening 2026-09-22:** S3 titled and paused, ready to outline; friction made a trilogy spine; *Maps with Tiles* round two underway.

**2026-09-23: all three outlined** -- MRC (8 chapters; backbone "where do boundaries come from"), MWT (11 chapters; the counting frame; the continuum as counterexample), S3 (7 parts). **Unifying statement ruled: boundaries in value, space and time; MRC read first.** Writing ruling: load the documents with personal stories. Next: data sources. Detail: `ideas_three_documents.md`.

**2026-09-25: FOCUS MOVED to a separate Voronoi methods document (`proj_Voronoi.md`, NEW), to be finished BEFORE the trilogy discusses the technology** (Kim's ruling). Opened from MWT's data-source question; structure-constrained Voronoi (releves + canopy height) prototyped at Kipuka Puaulu and accepted. MWT keeps the concept and one worked example. Detail: `proj_Voronoi.md`; `ideas_three_documents.md` (2026-09-25).

**2026-09-25 (close):** the 1974 Mueller-Dombois & Fosberg map digitised and overlaid; MMU tested and ruled 2 ha; the book *The Map That Never Got Drawn* started (Preface + Ch.1-2). Next: Kim's read, then Ch.3. Detail: `proj_Voronoi.md`.

**2026-09-26 (close):** *The Map That Never Got Drawn* -- Ch.3-10 drafted; whole book renders. Next: cover/logo (Kim), appendix, verify list, acknowledgements, read-through. Detail: `proj_Voronoi.md`.

**2026-09-27:** *The Map That Never Got Drawn* PUBLISHED at kimbridges-documents (`/voronoi/`), verified live. NEXT PROJECT: the companion package **tessellr** (Kim's name) -- Kim to weigh next steps at the next session. Detail: `proj_Voronoi.md`.

**2026-09-27 (evening):** tessellr 0.1.0 released on GitHub; the book's Appendix documents it. **Both projects COMPLETE (Kim).** Open notes: 1974-map permission (Kim), citation checks (Kim). Next focus: Kim's choice.

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
