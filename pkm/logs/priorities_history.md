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
