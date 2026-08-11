# PKM Session Log
_Created: 2026-05-07_

System-wide log of Cowork sessions. One dated entry per session.
For per-project working detail, see session_notes.md inside the
relevant project folder (designed in design_publishing_workflow.md;
not yet implemented).

For protocol governing how this log is used, see pkm_protocol.md
Mechanism 4.

---

## 2026-08-11 -- RESTART AFTER A WEEK AWAY; the resumption pointer rebuilt, two lost stories found, three new documents captured

**Active focus at start:** PKM (2026-08-03 close). **At close:** PKM -- restart complete.
Kim back from the mainland after his brother's heart attack; recovering, moved to rehab.
Deliberately a light session: *talk and capture*.

### The file that could not answer its own question

Eight days of gap, and `priorities.md` -- the designated resumption pointer -- was dated
2026-07-09 with its own first entry reading "freshen this file." Kim chose the restart
over the backlog.

**The diagnosis was not staleness, it was duplication.** The file restated item text that
also lived in `deferred.md`, so pruning anything meant editing two places, so nothing was
pruned. Rebuilt with the missing rule written into it: **`priorities.md` holds the ORDER,
`deferred.md` holds the DETAIL.** One line per item, pointing at the file that carries it.
Superseded file preserved verbatim at `logs/priorities_history.md` -- the same split the
logs took on 2026-07-28.

### Two corrections against the record, both mine

Opening the session I told Kim the April-2024 Anthropic key still needed revoking and the
hflip deadline was looming. **Both wrong.** The key was revoked 2026-08-03 and the two
hflip links were repointed 2026-08-02 -- I read the stale "Next up" line in `proj_PKM.md`
instead of `deferred.md`, which tracks them. The Active Focus block is a summary, not a
tracker; when the two disagree the tracking file wins.

### The orphan covers were not orphans

Kim resolved the three from memory -- `Ranunculus_Impressions` a duplicate, the other two
real but unprocessed, and he expected to have to go looking for the source materials.
**He did not.** A scan of the venues found both already staged under
`kimbridges-stories/underway/`, covers already in `images/`, neither published.

- **Selective_Focus** -- one 2.9 MB PDF, 2026-04-17. Genuinely quick, as Kim predicted.
- **Smart_Car** -- **not a story.** Nine files including a `README.md` project charter
  from 2026-05-08: *TwoRed 75,000 Miles Celebration*, a five-chapter reproducible Quarto
  book arguing from ~300 fill-ups, a time-zone-adjusted crossing log and topographic
  extremes that a Smart car is not an urban-commuter-only vehicle. `sf`, `tidygeocoder`,
  `elevatr`, `gt`. **No `proj_*.md`, no index row** -- an intake gap of the Jones/vouchr
  shape, dormant three months with its next two steps already specified.

Kim's assumption that both would be quick holds for one and not the other, which is the
useful half of the finding.

### ISSUU closed -- and the record was worse than the reality

Kim: every story once on ISSUU has been moved. **Verified rather than accepted.** All four
booklets are published stories with PDF, cover and page. `Travel.qmd` has **zero** ISSUU
mentions -- the four pointers and the L11 prose claim are already gone, so the open item
on the AI_Podcasts index row was stale and is struck.

**And `deferred.md` recorded `bordeaux_2` as "no known source... the one real gap." That
was false** -- `pdfs/Bordeaux_2.pdf`, `images/Bordeaux_2.jpg` and `stories/bordeaux-2.qmd`
all exist and are deployed. **Finding 019 committed again: an absence asserted without
being proved, which the next session would have read as established.** Corrected in place,
superseded text struck rather than deleted.

### The capture -- three documents

Kim's thinking from the flight, and the stated goal of the day: *document the thoughts.*
`ideas_three_documents.md` created. **Working titles:** *Baselines, Deviations & Spans*;
*Maps with Tiles*; *Measurements Require Categories*. Unified by **"you don't see
something unless you have a concept of it."** Prior work (Tom Koch tessellations, Will
McClatchey low-temperature spans) is related but explicitly **not** the basis of either
document.

Offered in response: the three are one claim in three registers -- categories frame WHAT,
tiles frame WHERE, baselines frame HOW MUCH. Five open problems recorded, including a
title collision (*map tiles* means XYZ/slippy-map tiles to any technical reader) and the
discovery-order-versus-exposition-order question.

**Kim's rulings:** three documents (open to further analysis), outlines first, NOT written
at once, reuse the existing packages rather than reinventing.

### ★ The inverse, promoted

The point offered was that Kim's thesis has an equally true and more interesting inverse:
**a concept also makes you see what is not there, and stops you seeing the alternatives** --
lens and blinder in the same act -- and that without it the trilogy reads as an
advertisement for concepts.

**Kim promoted it past the document it was raised for:** *"That's the kind of thread that's
needed in everything we do. It relates, in a vague way, to the way a scientist tries to
disprove things."*

That makes it a candidate for a PKM-level principle sitting beside the absence-claims rule
on the card -- *never assert something is missing without proving it* is the same instinct
applied to evidence; this is it applied to concepts. **Deliberately not acted on
unilaterally** (the card has a hard 6 KB budget). Recorded in `ideas_three_documents.md`
for Kim's decision.

Worth noting the day's own irony: the session committed Finding 019 twice in the record
and corrected both, while capturing a principle about attacking your own claims.

### Housekeeping

Two files written today came back **LF** while every pre-existing PKM file is **CRLF**.
Normalised, with the byte delta verified as exactly one per line (+185 and +136) -- the
check the CRLF hazard note asks for. Edits to the large files went through a read-detect-
write helper that preserves the original ending; backups first at
`C:\temp\pkm_edits_20260811`.

**Files:** `priorities.md` rebuilt; `logs/priorities_history.md` created;
`ideas_three_documents.md` created; `deferred.md`, `project_index.md` and this log updated.


## 2026-08-03 -- EXPERIMENTS WITH LLMS CONVERTED AND PUBLISHED; the last legacy link closed

**Active focus at start:** PKM, legacy cleanup effectively done, *Experiments with LLMs*
next in Kim's order. **At close:** published as the 22nd document; **zero non-historical
legacy links remain in any venue.**

### The metadata field that removed two days of work

The document was recorded as a finished 130 pp PDF with no `.qmd` source, and the
publication routes had been written up on that basis -- Kim chose the hybrid (landing
chapter over a PDF viewer) on 2026-08-02 for exactly that reason.

He then asked to check what a full Quarto rebuild would involve. Measuring the PDF first:
39,489 words over 130 pages, 13 sections and ~57 subsections encoded in font heights,
**zero image-only pages**, and prompt-vs-response separable by left margin (x=72 for
Kim's voice, x=108 for the LLM). All favourable. But the decisive fact was in the file
header: `/Producer` = **`Skia/PDF m122 Google Docs Renderer`**. The Doc was still in his
Drive, modified 2024-01-12, one day after the export.

**Re-asked rather than absorbing it.** Kim had approved hybrid against wrong information;
he switched to the full rebuild and chose to export a copy and leave the Doc untouched as
a dated artifact. Finding 025 -- and rule 3 there is the one worth keeping: when new
evidence overturns a decision the user already made, say so and re-ask.

### The conversion

googledrive needed interactive OAuth, which the bridge cannot do; Kim ran `drive_auth()`
once in the console and the token now caches at `~/.R/gargle-cache` on the C: HOME.
Export to docx, pandoc to markdown with media extraction, split at the 12 H1 boundaries.

Verified against the PDF rather than by inspection: **57 H2 subsections, exactly matching**;
41,543 words vs 39,489 of PDF text; 15 images extracted with all 15 references resolving.
Kim's bold convention -- prompts bold, responses normal -- came through intact (90 bold
spans in the Statistics chapter alone). A PDF reconstruction would have had to infer that
from x-coordinates. **The cheaper path was also the more faithful one.**

Three things dropped, all print-era furniture, all disclosed in the preface: duplicated
title block, repeated cover-art credit, and "Use the Table of Contents to jump to an
example of interest." The text itself was NOT revised. Kim's content creep -- 77 pp
(*Experiments with ChatGPT*, Nov 2023) -> 113 pp -> 130 pp -- is preserved as written,
and reorganisation was deliberately kept as a separate Kim-driven task.

Kim on the result: *"I found myself enjoying a re-read of this material."* Which is the
real test -- a faithful conversion nobody opens would be a lesser outcome.

### Closing the loop

`LLM_Creates_R/Resources.qmd` L84 repointed from ISSUU to `/llm_examples/`, re-rendered,
and reinstalled into `using_an_llm/`. Documents `_site` 1042 -> 1092, **0 removed**; venue
reconciles at 22 folders / 22 resources / 22 cards.

**Legacy links in venue sources: 4 -> 3, and none of the three is a live pointer to a
dying platform.** One historical mention kept by Kim's rule, two stale prose claims.

### The card caught itself

Trimming a new row out of `pkm_card.md` to respect its own 6 KB budget, a `file.info()`
size read immediately after the write reported **4.08 KB against a true 6101 bytes** -- a
2 KB phantom improvement that would have been reported as fact. Caught by reading content
back. That is Finding 020's rule, printed on the card, firing on the edit to the card.
The file was fine at 5.96 KB, under budget.

### Consolidation migration -- pilot delivered

With the legacy-platform work complete, Kim chose the migration that `proj_PKM.md` has
carried since 07-30: **0 of 5 venues was a git repo**, so the source for all 79
published works lived in exactly one place. Same risk shape as the platforms, but with
Kim's own storage -- and worse, because Drive holds the originals rather than copies.

**The plan contradicted the card, and the contradiction was real.** "Init one venue"
puts `.git` on `G:`, which bucket 5 forbids. That rule came from the OneDrive
ai_microscope experience and had never been tested against Drive Stream. Probed it:
`gert` init, two commits, clean status, readable log -- **git operates on `G:` fine.**

But that is not what bucket 5 is about. Operating correctly today is not surviving
Drive's sync lifecycle. **The probe answered a narrower question than the one that
mattered**, and saying so was the useful part; Kim chose the mirror.

**Delivered:** `C:\repos\kimbridges-venues`, one repo mirroring text source only.
Fiction pilot: 51 files -> 6 tracked (12.9 KB), pushed to
github.com/kimbridges/kimbridges-venues, **verified from GitHub's trees API -- 8 blobs,
zero binaries** -- then cloned fresh and compared by CONTENT: all 6 identical. The venues
on Drive were not touched at all.

New in pkm_health.R: `VENUE_MIRROR`, `.venue_tracked()`, `pkm_mirror_venue()`. The
filter lists NAMES and filters BEFORE any stat call, because stat-ing every file across
five Drive Stream venues stalled the bridge for minutes earlier in the session -- the
expensive-synced-read lesson, which had only ever been applied to OneDrive.

**Stated the limit rather than the headline.** The mirror restores hand-authored source;
it does NOT rebuild a complete site. Fiction's source references 4 gitignored assets on
Drive. The inherited phrasing "GitHub must hold everything needed to REBUILD a site"
overstates it, and that is now corrected in proj_PKM.md rather than left to flatter the
result.

### Finding 026 -- the tooling manufactures the mess the PKM exists to prevent

The probe was created in the Drive ROOT instead of `C:\temp`. Cleanup deleted all 16
files and then could not delete one directory: the file-removal function does not take
directories on Windows, and the recursive alternative is blocked by the guard. **19 empty
directories left in Kim's Drive root for him to delete by hand** -- in a system whose
founding complaint was files proliferating. Rule: never create scratch outside bucket 4.

Two smaller ones worth keeping. `gert::git_push(password = tok)` fails with a valid PAT;
`GIT_USERNAME` + `GIT_PASSWORD` in the environment works (unset after; never embed the
token in the remote URL). And the guard scans PROSE -- writing Finding 026 was rejected
on first attempt for quoting the blocked call inside a string.

### The migration, finished — and what it found on the way

Kim ruled that derived output must not be stored. Measuring against that rule reshaped
the job: `kimbridges-documents` reduces to **25 files** -- a listing page and 22 cards --
because its 22 documents are rendered output copied in. **Their source lives in
`Projects/<name>`.** Mirroring venues alone would have backed up the shelf and not the
books. Kim extended the scope; the repo is now `venues/` + `projects/`.

The selection mechanism was also wrong and had to be inverted. `VENUE_GITIGNORE` -- a
blacklist -- missed `_output/`, the output-dir every Quarto book uses, and admitted 2018
files of Jones research data. **A blacklist must anticipate every kind of junk; a
whitelist only has to know what source looks like.** Even then the first whitelist
included `.html` and pulled in 12.5 MB of R Notebook renders and htmlwidget maps sitting
outside any build folder; 61 of 62 `.html` files were derived. Only `viewer.html`
survives, allowlisted by name.

**Note the pilot's blind spot.** Fiction was chosen as the pilot for being smallest, and
smallest meant it exercised least: it uses no `_output/`, no loose `.html`, and holds no
data. It passed while every one of those defects was live.

**Final: 882 files, 5.8 MB, verified from GitHub's trees API** -- 197 venue source, 683
project source across 49 projects, zero binaries, zero data, zero derived.

### The push was refused, and that was the best outcome available

GitHub push protection found a full Anthropic API key in
`Projects/LLM_API_R/Claude_API.qmd`, dated April 2024, commented out with `##` --
which hides it from R, not from a reader. Checked three ways and it was **never
published**: not a chapter of the rendered `r_api` book, absent from the venue folder,
its `_site` copy, and the live document. It had been on disk over two years because
nothing had ever looked.

**That reframes what the backup is for.** Copying files elsewhere is the least of it.
Publishing to a public repo forces every file past a scanner a private disk never
applies. Day one's value was not redundancy -- it was that something finally read the
material adversarially. `pkm_secret_scan()` now runs before every commit with a
`stopifnot`, because relying on GitHub means a private repo or an unknown pattern passes
silently. Finding 027.

### Three silent failures, one shape -- Finding 028

**`gert::git_push()` returned cleanly twice and transferred nothing.** GitHub's ref was
still at the pilot commit. The real error surfaced only under `verbose = TRUE`. Caught
only by checking GitHub's ref rather than the return value -- otherwise the session ends
believing 880 files are safe when 8 are.

**A size read straight after a write reported 4.08 KB against a true 6101 bytes** --
Finding 020 firing on the very file that prints the rule.

**The expensive-synced-read mistake, committed twice in one session.** A five-venue
recursive scan stalled the bridge; it was written up; then `pkm_secret_scan` was built
with no extension filter and aimed at all of `Projects/`, reading every PDF over Drive
Stream until Kim interrupted R. **Writing a lesson down is not the same as having learned
it.** The fix is structural, not memorial: the filter now lives inside the function, so
the next caller cannot repeat it.

The common shape: each failure was silent at the point of use and visible only from
outside -- the remote ref, the file's content, the user's own machine. *Where a tool
reports on its own work, get the answer somewhere the tool does not control.*

### The gap found during cleanup: the PKM was not backing up the PKM

After the migration was declared done, one check remained worth making: was
`Projects_Index` in it? It was not. The venues and 49 projects were on GitHub; the
index that makes them findable was still single-copy on Drive -- `pkm_health.R`, every
`proj_*.md`, 83 KB of findings, the session log and its archive.

Added as `pkm/`: 87 files, 2.0 MB. Repo now carries **969 blobs**. The reasoning is
worth keeping: the venues and projects can be re-read from their own files, but nothing
else records WHY a decision was made, what was tried and rejected, or which mistakes
have already been paid for once. **Backing up the work and not the index leaves a future
reader with the artifacts and no map.**

Kim confirmed the April-2024 Anthropic key is deleted; that conditional is closed.

### The card earned three new triggers, and had to be trimmed to hold them

`pkm_card.md` gained rows for the three failures that would otherwise recur: verify a
push against the REMOTE not the return value (028), run `pkm_secret_scan()` before any
commit (027), and create scratch only in `C:\temp` because the bridge cannot remove
directories (026).

That took it to 6222 bytes against its own 6144 budget, so it was trimmed rather than
allowed to breach: the stale "broken twice this week" heading, a Findings count that
still said 001-021, and a verbose RENAMES example. **5987 bytes** and eight sections
intact. The card enforcing its own rule on itself is the point of having the rule
printed on it.

### The cadence, decided and wired in

Kim did not know the term, which was my fault for using it. Plainly: **the GitHub copy
is a photocopy taken at one moment, and it does not update itself.** Every edit on Drive
makes it one edit staler. A stale backup is worse than an obvious absence -- it reads as
safety right up to the moment it fails.

**Decision: Mechanism 5, item 12.** `pkm_backup()` now runs at every session close
beside `pkm_health()`, and appears on `pkm_card.md`. It refreshes all five venues, every
project and `Projects_Index`; runs `pkm_secret_scan()` as a HARD GATE that refuses to
commit on any match; commits; pushes; and verifies against the SERVER rather than the
return value.

*Why not the alternatives.* A scheduled task needs the machine on and the R server up --
a backup that silently stops running is precisely the failure being guarded against. On
demand depends on remembering, which is what Mechanism 5 exists to replace. Attaching it
to an existing trigger costs nothing and inherits a habit that already holds. Same
principle the card was built on: *the trigger is the mechanism, not the list.*

First live run: 967 files refreshed, 1 changed, committed, pushed, verified in sync.
The card absorbed the extra call and came out at 6001 bytes against its 6144 budget.

**Open at close:** the per-project credential audit of Drive; six repo/clone mismatches
(confirm listsr is not simply PRIVATE); two stale Quarto Pub prose claims; three
unidentified orphan story covers; Desktop originals and the SoundCloud account close
awaiting go-aheads.

---

## 2026-08-02 -- SOUNDCLOUD RETIRED; AI_Podcasts published; the gate caught reading the wrong file

**Active focus at start:** the SoundCloud migration, 1 of 11 embeds done.
**At close:** 11 of 11. SoundCloud hosts none of Kim's audio.

### Gallery Catalog -- and a deploy chain that was described backwards

Before rendering, checked what actually produces the live pages. `_output/Podcast.html`
is dated 2025-04-09 and stamped `quarto-1.5.56`; the live `_site/Gallery/Gallery_Catalog/`
pages are dated 2026-07-26, stamped `quarto-1.8.27`, and carry the parent Collections
navbar with `../../site_libs/`. **The nested book `_quarto.yml` is vestigial** -- the
PARENT collections render walks in and renders the six chapters as website pages
straight into `_site`. The previous session had told Kim the chain was render-book-
then-copy-from-`_output`. Following that would have pushed 15-month-old pages live.
Recorded as a TRAP in deferred.md. The same shape exists at `Jones/Jones_analysis/`.

Also repointed both hflip links to the in-house viewer (`../viewer.html?pdf=1_Gallery_
Catalog.pdf`) after confirming `viewer.html` defaults to Two-Page Spread, so Kim's
"two-page spread" wording survived; only the vendor name ISSUU was dropped. Kim
deployed and confirmed.

### AI_Podcasts: moved, migrated, published

Source relocated from the OneDrive Desktop to `Projects/AI_Podcasts` (10 files,
byte-verified). Ten SoundCloud iframes replaced. **Two different iframe shapes were
present** -- one-line `<div><iframe...></div>` in Travel.qmd, seven-line blocks in
Scientific/Code -- and a single block detector produced OVERLAPPING ranges on Travel.
Caught in a dry run, before anything was written.

Then wrote a real bug anyway: the tail slice `L[(k+5):length(L)]` on a block ending at
the last line became `88:87`, which R counts BACKWARD, appending an `NA` line and a
stray `</div>`. The file still rendered and every audio element was correct. **Line-count
reconciliation was the only thing that fired** -- expected 87-15=72, got 74. Finding 023.
That is now three consecutive sessions where counting, not looking, found the damage.

Dead link fixed at source (`Code.qmd` -> `using_an_llm/`, target verified live first);
the Quarto Pub `_publish.yml` retired. Installed into kimbridges-documents via the
RESOURCES model (36 files copied + `resources:` entry + listing card). `_site` 1005 ->
1042, 0 removed. Kim deployed; audio plays. **21st document on the documents site.**

### The finding that matters most today

`pkm_legacy_gap()` reads `inventory_all_projects.md`. It never opens a venue file. So
the pre-deletion gate -- the one function standing in front of a one-way door -- could
only ever protect platforms a human had already written into the inventory. Eleven
SoundCloud embeds lived in published pages for months and the gate reported zero,
correctly, every run. Adding `soundcloud.com` to its platform vector changed nothing,
because the vector is applied to the inventory text. **The blind spot was the source,
not the list.** That is a direct violation of the GROUND-TRUTH RULE by the tool whose
whole job is verification. Finding 024.

Remedy: `pkm_legacy_live()` added -- reads venue `.qmd`/`.md`/`.html` SOURCE directly,
reports venue / file / line / url and separates a real LINK from a prose `mention only`.
Run both; disagreement is the finding. First run surfaced 7 rows the old gate could not
see: 5 live ISSUU pointers (a FIFTH external platform, never on the retirement list) and
2 stale PROSE claims that Kim's documents are "posted on the Quarto Pub website."
**Dead claims are a category the whole link cleanup missed -- a sentence has no href.**

Regex note worth keeping: `"quarto.pub"` unescaped matched `quarto publish`; escaping
to `quarto\\.pub` fixed that and immediately lost both real hits, which say "Quarto Pub"
with a space. Working pattern `quarto[. ]pub\\b`. Too loose and too tight fail the same
way -- silently, with a plausible row count.

### Housekeeping

`.wav` masters (12 files, 361 MB) copied to `Projects/Audio/podcast_masters`, all
byte-verified; Desktop originals left in place pending Kim's confirmation. Created
`proj_AI_Podcasts.md` (4.6 KB) and indexed it. Two findings written (023, 024). Noted
in pkm_findings.md that two findings share the number 020; left as-is to preserve
existing citations, numbering resumed at 023.

### Late correction (same session)

Kim supplied the ISSUU history and it broke two of my assumptions at once. He deleted
the ISSUU account years ago after an abrupt price rise -- so ISSUU is not "a fifth
platform to migrate," it is a closed account. **Probed all five URLs rather than
accepting that.** Three are STILL LIVE (`finding_fine_wine`, `bordeaux`,
`chatgpt_examples`); two are 404 (`bordeaux_2`, `2023_japan_story`). Deleting an
account did not take its documents down.

That inverts the risk. Exposure has a schedulable deletion event; these three sit on a
platform nobody is watching, believed already closed, and can go without notice.
**Recover first, repoint second.**

I had also written off `2023_Japan_Story.pdf` as "too small to be the illustrated
booklet" at 0.47 MB. Kim: it is **text-only by design**, ~40 pp, and is precisely the
file he gave NotebookLM. A file size is not a verdict on a file's contents -- the same
shape as Finding 020's failed probe and the stale `file.info` size. Both records
corrected in deferred.md and proj_AI_Podcasts.md.

Kim on the SoundCloud blind spot: he thought it was used for one Gallery project only
and had forgotten the rest -- "in practice, it was a very tiny blind spot. I knew we'd
get to it when we looked at the collections updating." Worth recording honestly: the
tool did not save him from something he had lost. It found something he had misfiled.

**Also recorded:** a dozen or so trips have written stories of similar length with no
photos added yet. A future project, after current work.

### The ISSUU trail, followed to the end

Kim: the three wine/travel booklets are already on the stories site, so nothing was at
risk. **Verified rather than assumed** -- `Finding_Fine_Wine.pdf`, `Bordeaux.pdf` and
`Bordeaux_2.pdf` are all in `kimbridges-stories/pdfs` with live pages. Note the shape:
`bordeaux_2` is 404 on ISSUU and perfectly healthy on Kim's own site. All three
repointed, plus the L11 prose sending readers to ISSUU.

The fourth, `2023_japan_story`, was 404 with the PDF sitting in `Desktop\Podcasts`.
Published it to the stories venue -- and **the cover image was already there**,
`images/2023_Japan_Story.jpg`, staged and abandoned. That prompted a check for others.

**Six orphan cover images in kimbridges-stories**: covers with no PDF and no page.
`2023_Japan_Story` (now resolved), `LLM_Examples`, `Catalog`, `Ranunculus_Impressions`,
`Selective_Focus`, `Smart_Car`. Each is an intake somebody started and stopped. The last
three appear nowhere else in the PKM. Recorded in deferred.md; **ask Kim rather than
assume they are strays** -- choosing a cover image is not an accident.

### Experiments with LLMs: the genuinely exposed item

The fifth ISSUU link, `chatgpt_examples`, is the one Kim was unsure about, and it was the
only one at real risk. **No venue home at all.** Live on exactly two dying platforms:
ISSUU (deleted account, still serving) and hflip (stops ~Feb 2027). Every other copy was
loose in `Downloads`.

Kim asked to hold it safely without interrupting current work. Done: four PDFs staged to
`Projects/LLM_Examples/` byte-verified with page counts re-checked after the copy, the
orphan cover rescued, and a README carrying provenance and the three structural routes.

**The version trap worth remembering.** Two PDFs, 113 pp and 130 pp, BOTH print
"Version 4: January 1, 2024" on the cover -- the later revision never updated its own
version string. The inventory recorded 113 and was reporting the older file. **A
document's own claim about its version is not evidence of which file you are holding.**
Same family as the file-size lesson earlier today: metadata about an artifact is not the
artifact.

### One fabrication, caught

My first draft of the Japan story description said the trip was "three weeks." Kim never
said that; I filled a gap with a plausible number and it would have published under his
name. Replaced with his own wording from Travel.qmd. Worth logging precisely because
nothing flagged it -- there is no check that fires on a confident invented detail.

**Legacy links: 7 -> 4.** Remaining: `Stage.qmd` L41 (historical, stays by Kim's rule),
`using_an_llm/Resources.qmd` L70 (blocked on the LLM_Examples publication -- the last
non-historical one), and the two stale Quarto Pub prose claims.

**Closed.** All three venues deployed by Kim and verified live 2026-08-02: the Japan story
renders at `/stories/japan-fall-2023.html` (59 pp), and `/ai_podcasts/Travel.html` serves four local `<audio>` players with four links to the stories venue and **zero** issuu or soundcloud references. Desktop originals still awaiting a delete decision; Kim called it a night before digging into the three unidentified orphan covers.

---

## 2026-08-01 -- NOT LOGGED AT THE TIME (reconstructed 2026-08-02 from artifacts)

This session left no entry. Reconstructed here from dated artifacts only -- findings,
deferred.md entries, file timestamps and backups -- **not from memory of the session**,
which is why it is thin. Mechanism 5 was not run.

Evidenced: `pkm_card.md` destroyed by a `grep(..., fixed = TRUE)` with `^`, returning
`integer(0)` and collapsing 132 lines to 1; rebuilt verbatim (Finding 022). Dead Quarto
Pub links repointed in `r_basics` and `using_an_llm` (13 links, backup at
`_backup_2026-08-01/`). R's HOME moved off OneDrive; `.Rprofile` written with
`gargle_oauth_email`. Gallery Catalog `Podcast.qmd` SoundCloud embed replaced (backup
`_backup/Podcast_backup_2026-08-01.qmd`). Three deferred items closed.

**The gap itself is the lesson.** A session that ends without Mechanism 5 is
unrecoverable at full fidelity the next day, even with every artifact intact.

---
## 2026-07-31 -- THE TWO LOST STORIES RECOVERED AND PUBLISHED; two errors by Claude

**Active focus at start:** PKM, Tier 2 delivered, with a content detour named ahead
of Tier 3. Session-start found THREE stale items in proj_PKM.md left by the 07-30
session -- a `_Last updated` two days behind, a Next Steps block still presenting
delivered Tier 2 work as pending against superseded counts (83 works / 58 stories),
and a bad splice that dropped a sentence mid-paragraph. All three fixed at close.

**THE RECOVERY.** Kim rebuilt *Cinque Terre Impressions* (43 pp, 2014) and *The
Washington Monument* (23 pp, 2016) in InDesign from the original photos and text --
same subject, mostly the same words, reformatted to the house style -- and made a
reference PDF of each first. Placement followed the three-artifact model: PDFs into
`pdfs/` (12.0 and 3.1 MB), covers rendered from page 1 at 1200 px (463 / 134 KB,
against a 338 KB median), stubs into `stories/`. No year prefix -- only 4 of 51
existing PDFs use one. Categories from the existing vocabulary, no new filter chips.
**Spelling corrected on the way in:** the working folder read Cinque_terra; the place
is Cinque Terre, as Kim's own source text had it -- which also made the gate match on
the strong path, Cinque_Terre.pdf normalising to the legacy slug exactly.
Kim rendered, checked and deployed. **Verified: 79/79 works rendered AND live (HTTP
200), 0 failures, PRE-DELETION GATE 0.** Quarto Pub, hflip and Exposure are all clear
for account deletion. The gate closed MECHANICALLY, as the rule required -- evidence,
not recollection.

**TWO ERRORS BY CLAUDE, both already covered by rules in this system -> FINDING 020.**
(1) On 07-30 I declared **kimbridges.com dead** on the strength of ONE failed curl
call and wrote it into proj_PKM.md as fact, building an argument on it. It is ALIVE:
200, 115 KB, DNS resolving, with and without a browser user-agent. The evidence
against the inference was already in hand -- exposure.co had returned 403 while being
perfectly alive, in the same session. This is Finding 019 (never assert an absence
without proving it) committed three days after writing it. (2) I raised a data-loss
alarm when deferred.md appeared to shrink; the file was intact and the size was a
stale Drive-stream `file.info` read -- the SECOND time that exact artifact fooled me
this week. Rule: verify a write by reading CONTENT back, never size.
Kim corrected the kimbridges.com claim from his own knowledge. **The mechanisms were
not missing. They were not applied.**

**kimbridges.com, corrected record.** Alive, and KEPT -- Kim's personal and
professional site, deliberately separate from .info. NOT among the platforms being
retired. It does still carry residual story links he thought he had cleaned off;
logged to deferred.md against the account-deletion pass, lower priority.

**deferred.md** gained two sections following its own TASK/CONDITIONAL shape:
kimbridges-stories (two text errors in each book -- the Cinque Terra spelling and
Zeill-for-Zeiss; the Articles-of-Confederation factual slip and 17978-for-1797 in
Washington; Kim: fine as they are for now) and kimbridges.com.

**TIER 3 GAINS A SIXTH ITEM, arguably the most important: give `pkm_findings.md` a
TRIGGER.** Today proved the rules exist and do not fire. 65 KB of knowledge with
nothing connecting a moment of risk to the note covering it is a write-only archive.
deferred.md already solved this -- "the trigger is the mechanism, not the list" --
and the same reasoning applies to findings. Writing more rules without a firing
mechanism repeats the failure at larger scale.

**NEXT: Tier 3.** Storage buckets 4-5, the surfaces-and-permissions map, Mechanism 5
amendments, Findings 001/005/013/015 collapsed into one, the pkm_findings budget
question, and the trigger mechanism.

**TIER 3 DELIVERED (same day).** All six items written.

**NEW: `pkm_card.md` (4.1 KB), the trigger.** Mechanism 2 now reads THREE files,
card FIRST. It carries: the single GROUND-TRUTH RULE (consolidating Findings 001,
005, 013, 015 and half of 020 -- a `G:` path can report a correct name and size
while the bytes are absent, stale or unmaterialised; every surface except the R
bridge can be lied to; verify writes by reading CONTENT, never size); a
SITUATION-TO-FINDING table ("about to say something is missing -> 018, 019, 020";
"about to render Quarto -> 012, 016, 017"; and so on); the ABSENCE-CLAIM rule; the
FOUR SURFACES and what each cannot do, including the grant asymmetries; and the FIVE
BUCKETS. pkm_findings.md keeps all 20 findings and now opens with a pointer to the
card; the four consolidated findings are MARKED, not deleted.

**Storage buckets 4 and 5 -- the May question finally answered.** Bucket 4, build
scratch at `C:\temp\<name>_<date>`, with the retention half the original rule never
had: delete once the deploy is verified live. Bucket 5, git working clones at
`C:\repos\<name>` -- NOT Drive and NOT OneDrive, because a syncing folder serves
placeholders that git reads as corrupt. Pending: move ~\Documents\ai_microscope and
set core.autocrlf.

**Mechanism 5 gained items 9, 10, 11:** close the small remainders (Kim's rule made
formal); account for anything written outside `G:`; and RUN `pkm_health()` -- with
the principle that **where a claim can be checked by the tool, the tool's answer is
the record**, not anyone's recollection.

**Budget model split HOT / PROJECT / REFERENCE.** pkm_findings.md was never too big,
it was miscategorised: a file read monthly and a file read every session were judged
by one standard, so the check cried wolf -- and a check that cries wolf gets ignored.
Over-budget dropped from 3 files to 2 (proj_seasonality, proj_audio; both splittable).

**A check I got wrong and fixed in the same hour.** `pkm_scratch()` first reported
"none" on a 14-day threshold while 224 MB sat stranded in `C:\temp`. A check that
certifies a problem as ABSENT is worse than no check. It now reports every scratch
folder with age and size and merely marks those past the threshold.

**SESSION-START: 44.5 KB across three files** (card 4.1 + index 19.9 + PKM 20.4),
against 184.4 KB on Monday. The rise from 35 KB is deliberate -- the card is new and
proj_PKM absorbed the Tier 3 decisions.

**VERIFIED:** 17 of 17 Tier 3 checks pass. Health: 79 works, 0 reconciliation
failures, 0 broken pointers, gate 0, 2 files over budget, 224 MB of bucket-4 scratch
now visible in the report.

**AFTERNOON/EVENING (cont. 2) -- LINK CLEANUP BEGINS, and R's HOME leaves OneDrive.**

**plainmaps is COMPLETE and LIVE.** Kim repointed the two dead Quarto Pub links
(`index.qmd` L18, `Sitemaps.qmd` L5 -- he replaced the LINK TEXT as well as the URL,
which was the trap: the visible text had been `kim.quarto.pub/sitemaps`). Claude fixed
three typos in `Packages.qmd`. **A brief detour worth recording: Kim thought he had
edited the wrong files** (`sitemaps_website`), but plainmaps is a Quarto BOOK with
chapters at the project root -- `sitemaps_website` belongs to the separate sitemaps
project. Rule: check the project TYPE before hunting for source.

**API TEXT INVESTIGATED, LEFT AS IS.** Kim suspected
`register_google(key=, write=TRUE)` was session-only. It is not -- the ggmap source
shows `write=TRUE` writes `GGMAP_GOOGLE_API_KEY` to `$HOME/.Renviron` AND sets the
session variable; `write=FALSE` is the session-only path. So the book's claim was
correct, and the mechanism is exactly the `.Renviron` practice Kim has since
standardised on -- his file already held the key, put there by this call.

**AN ORPHAN FOUND BEFORE IT COULD BE DEPLOYED OVER.** `Tessellations.html` was live
but absent from the new render. Source existed; line 3 read **"BIG PROBLEMS -- DON'T
USE UNTIL FIXED"**, and `_quarto.yml` had dropped it from the chapter list 90 minutes
after that edit in April 2024. A deliberate removal that never reached the site --
unlinked from any page, but live at a direct URL for fifteen months. Removed.
`Plainmaps.pdf` re-rendered (2.64 MB, 78 pp) carrying all the fixes.

**R's HOME MOVED OFF ONEDRIVE** -- see proj_PKM Design Decisions. Verified: 488
packages intact, 11 keys loading, `~` now `C:/Users/kim`. Old R 3.5/4.1 libraries
deleted. This is the root cause of Monday's OneDrive clone.

**THE DEPLOY MISHAP.** Kim dragged `kimbridges-documents/plainmaps/` to Netlify and it
REPLACED the whole site -- all twenty documents 404'd. Nothing lost; `_site` rebuilt
from the corrected root copy and re-dragged, all verified live. **The trap is
structural, not carelessness:** document folders exist at the project ROOT (where you
edit) and are copied into `_site` as declared `resources:` (where you deploy), so both
hold folders with identical names. Claude set it up by never saying the root was not
the deploy source. Now on the card as DEPLOY TARGETS.

**FINDING 021 -- three operations that look additive and are not:** a case-only rename
destroys the file on Windows; rendering one format of a Quarto book clears the others
from output-dir; Netlify Drop replaces the entire site.
**Claude committed the case-rename bug TWICE, twenty minutes apart, having diagnosed
it the first time.** The lesson existed only in the chat -- it was never written to
the card. That is Tier 3's sixth item demonstrated on Claude rather than argued for:
a rule that lives only in a conversation does not fire.

**STILL OUTSTANDING on the link cleanup:** `r_basics/index.html` and `using_an_llm/`
(2 files), plus the two hflip links in the Gallery Catalog (deadline ~Feb 2027) and
the API-description unification. See deferred.md.

## 2026-07-30 -- TIER 2 DELIVERED: pkm_health.R built, run, and the three remedies fired

**Active focus at start:** none asserted (the 07-29 block closed specimen_labels and
named PKM Tier 2 as the standing candidate). Kim confirmed Tier 2.

**Session-start finding.** project_index.md had regrown 18 -> 67.7 KB in two days, the
Active Focus block alone reaching 49.3 KB on ONE line -- larger than the whole file was
after the 07-27 split. Diagnosis: **Tier 1 reduced the STOCK but nothing constrained the
FLOW.** The block even diagnosed itself (its own text said the dated segments belonged in
focus_history.md) but had no rule telling it to act. A size budget became job 5.

**BUILT: `pkm_health.R`** (500 lines, 21 KB) in Projects_Index/, beside what it scans --
the first test of the Tier 3 question of where PKM machinery lives. Five diagnostics:
(1) GENERATE works_register.md from YAML front matter across the four venues; (2)
RECONCILE source -> _site -> live; (3) VERIFY `_Log:` pointers, report orphans; (4) FLAG
drift on Active projects; (5) BUDGET enforcement. Three remedies, each snapshot-first,
byte-exact, losslessness-verified, and self-restoring on failure: `split_tail`,
`archive_focus`, `split_session_log`. All default to dry_run = TRUE.

**FIRST RUN -- the reconciliation question is ANSWERED: 77 of 77 works render locally AND
return HTTP 200 live. Zero failures.** The pre-consolidation backup-vs-website mismatch
Kim remembered is resolved, and now provably so rather than assumed. **Counts corrected:
77 works** (documents 20, stories 51, collections 4, fiction 2), NOT the 83 estimated on
07-28 -- the 7 extra .qmd files live in `underway/` and `updates/` and are correctly
excluded. Pointers 5/5 resolve, 0 orphans. Drift: proj_checklists.md is 10 days behind
its code (kipuka_puaulu 9.3); `Projects/R_LLM_tests/_book` is named in Locations but was
never rendered.

**REMEDIES FIRED (Kim approved).** session_log.md 603.8 -> 105.8 KB (133 entries ->
logs/session_log_archive.md); proj_specimen_labels.md 143.6 -> 17.1 KB (47 entries);
the 49.3 KB focus block archived and replaced with a 1.5 KB one against a 6 KB budget.
All three verified lossless. **Session-start cost 77.7 -> 30.6 KB.** Live PKM folder
1686 -> 888 KB, with 1043 KB preserved verbatim in logs/.

**TWO ENGINEERING LESSONS.** (1) The bridge timed out THREE times; the cause was
`file.info` over Drive Stream, not recursion. Scoping drift to Active projects fixed it
AND made the check more meaningful -- a Complete project whose folder is newer than its
proj file is normal, and a Standing venue receives work continuously by definition.
31s now. (2) A patch intended to INSERT a line REPLACED one instead, silently breaking
`.newest_mtime`; it surfaced as an unrelated-looking error. Finding 016 again: the exit
code is not the artifact.

**STILL OVER BUDGET (small):** proj_seasonality.md 51.6, pkm_findings.md 63.6 (no Log
heading -- needs a different remedy), proj_audio.md 47.3.

**NEXT: TIER 3** -- storage buckets 4 and 5, the surfaces-and-permissions map,
Mechanism 5 amendments, Findings 001/005/013/015 collapsed into one ground-truth rule.

**AFTERNOON (cont.) -- CONSOLIDATION became the register's real job.** Kim reframed
the works register as an instrument for CONSOLIDATION, not an inventory: it should
measure distance from the target state and shrink as he closes it. Two decisions
taken and recorded in proj_PKM Design Decisions: (1) **venue repos are SOURCE-ONLY
and lean** -- commit .qmd/.R/_quarto.yml/.css, gitignore _site/, pdfs/, images/ and
all large binaries, because kimbridges-documents alone is ~300 MB, plain git keeps
every binary version forever, and Git LFS needs a tool the gert bridge cannot drive;
(2) **legacy platforms end by ACCOUNT DELETION, not item by item** -- per-item
deletion is impractical and Quarto Pub blocks it. I first recorded (2) wrongly as
'frozen, not deleted'; Kim corrected it and the record was fixed. A wrong rule is
worse than no rule -- a later session would have read it and never built the gate.

**MEASURED GAP.** 0 of 5 venue folders is a git repo: source for all 77 published
works exists only on Google Drive. 22 public repos, every one an R package or tool,
no websites. 6 repo/clone mismatches (accessOAI, geContour, milestones, plainmaps
have a repo but no local clone; listsr and Temperature_Patterns the reverse --
listsr may simply be private, CONFIRM do not conclude). The migration is named in
Next Steps as its OWN body of work, not a Tier 3 item.

**JOB 7 -- THE PRE-DELETION GATE, and the day's real find.** Account deletion is a
ONE-WAY DOOR, so the gate is: does every legacy page have an equivalent on a
kimbridges venue? First pass said 22 orphans. **It was wrong.** Legacy slugs name
the PDF (hflip.co/merritt_island) while venue slugs name the story
(wading-birds-of-black-point-wildlife-drive). Re-matching on the PDF FILENAME gave
**51 matched, 5 possible, 2 with no equivalent**. Kim adjudicated the 5 as all
safely present under different names (CLOSED, do not re-derive) and confirmed the 2
as **TRUE LOST STORIES**: *The Washington Monument* and *Cinque Terre*, both
Exposure. Quarto Pub (13) and hflip (34) are CLEAR. **exposure.co returns 403 to
programmatic access**, so recovery is browser-only.

**AND kimbridges.com IS ALREADY DEAD** -- no response on /, /stories or www, while
inventory_all_projects.md still calls it the listing hub for every Exposure story.
A platform disappeared and nothing noticed. That is the argument for the gate, made
on Kim's own material rather than in the abstract.

**RESOLVED same day.** Kim found the base materials for both lost stories -- photos
and text -- and made a **PDF of each as a reference rendering**, which preserves the
Exposure layout and sequencing that the raw parts do not. Nothing is at risk now.
Rule adopted: **close the gate mechanically, not by assertion** -- once assembled
into kimbridges-stories, pkm_legacy_gap() matches them on the PDF filename and the
Exposure count drops to 0 on its own. Sequence: move -> assemble -> publish -> run
pkm_health() -> confirm 0 -> THEN delete the account.

**SESSION CLOSE.** Kim is taking a break, then **slipping the reconstruction of the
two Exposure stories in AHEAD of Tier 3**: move the components into the stories
folder, then rebuild both as PDFs. No intake fired -- per the 07-28 rule these are
level-4 WORKS inside a Standing venue, not projects, so they belong in the generated
register, not in a proj_*.md.

## 2026-07-29 -- DOCUMENTATION RECONCILIATION: the printing folded into the chapters; four drifts, one bad number

**Active focus at start:** specimen_labels, the production pass -- resume item "reconcile the chapters
with the upgraded printing." Kim confirmed it at session start. Session-start protocol run against
project_index.md, proj_PKM.md and pkm_protocol.md.

**The task was audit-then-write, and the audit found more than the two drifts logged on 07-28.**

**1. ★ THE RECORDED CLEARANCE MEASURED THE WRONG THING.** `One_deck.jpg` was measured directly,
scaled off the card's known 3.5 x 2.0in edges (621.6 px/in, agreeing on both axes to 0.2%). The layout
verifies where it was checked -- QR right edge **3.013in** measured against 3.008in predicted. But the
cover's occluding edge sits at **1.804in**, i.e. **0.30in PAST the 1.5in `bind_left` reserve**, so the
QR cleared it by **0.127in and not the 0.372in in the record**. The 0.372in figure was always clearance
against the *assumption*, never against the *cover*. Related: the punched hole measures **0.788in** from
the card edge where `punch_x` draws 0.375in -- a hand punch reaches where it reaches, and moving the
pivot right moved the cover's reach right with it. **★ THE RULE, one level past Finding 020: a verified
number must name what it was measured AGAINST.** "0.372in clear" and "0.127in clear" are both true of
the same deck; only one is about the object. Kim's decision: **correct the record, leave the code** --
the cards print and decode, and widening `bind_left` costs QR size. Corrected in BOTH copies of
`make_qr_cards.R` (specimen_labels working original and the canonical `vouchr/R/`), comments only.

**2. THE BUILT KIT HAS A FOURTH CARD KIND.** Example_1.jpg decodes six cards, and two fit none of the
three kinds `decks.qmd` named: `Collected by: KW Bridges, YH Lau` (teal) and `Determined by: KW Bridges`
(purple), both built as bound screw-post decks. **Adopted: identity / attribution / observation /
comment.** Attribution earns the separation on a handling argument, not a taxonomic one -- **its value
does not change from plant to plant.** Identity changes per specimen, observation changes per specimen,
attribution changes per trip. This is the 07-28 "`Determined by` is FIRST-CLASS" decision arriving in
the prose. A knock-on inconsistency was caught and fixed in the same chapter: the filter paragraph says
a determination is desk work and fails the field test, which now reads oddly beside a determination
card -- the card records WHO will determine, settled before you leave the house.

**3. THE PRINTED DECKS ARE NOT THE DECKS IN `decks/`.** Confirmed by artifact chain, not inference: the
kit Kim printed and photographed came from **`QR_field_notes.csv`** (rendered to
`QR_field_notes_cards.pdf` 16:56 HST on 07-28, and shipped as `vouchr/inst/extdata/`), not from the
three deck-discovery outputs in `decks/`. Every payload in Example_1 is in that CSV, including the two
labels -- `Abundant Flowers`, `Scattered Flowers` -- that broke the narrowed clear zone and forced the
auto-shrink fix. So the project carried **two disagreeing phenology decks** for a month: printed
(Abundant / Scattered / No Flowers) vs discovery (Vegetative / Bud / Flower / Fruit / Fl+Fr), and
`decks/` has **no Abundance deck** although the kit has one. Kim's decision: **the printed set is
canonical** so the figures agree with the photographs. `decks/deck_universal.csv` phenology rows
replaced; **the superseded five values are recorded verbatim in `design_notes.md`** because the edit
overwrote a discovery output (Finding 019 -- do not quietly rewrite a record).

**4. THE COVER COLOUR SCHEME WAS ONE-SIXTH DOCUMENTED.** The kit runs five coded covers -- yellow
phenology, grey abundance, pink life form, teal collectors, purple determination -- in a project whose
own argument is that you find the deck by colour before you read a word, and only yellow had ever been
written down. All five recorded, and named in `decks.qmd` **as one collector's choices, not a standard.**
**Unresolved, flagged not guessed:** the chapter said "a colored cover top and bottom"; the second cover
reads white in `One_deck.jpg` and the photographs cannot settle it, so the chapter now claims nothing
about the back. Kim to confirm.

**WHAT WENT INTO THE BOOK.** `decks.qmd` gained the fourth card kind, the colour scheme, and the
binding clearance **as a design finding rather than a repair** -- the argument being that *a layout drawn
for an object in isolation can be exactly correct and still fail the moment the object is used, because
use adds constraints the drawing never saw.* The binding was invisible in the design file and decisive in
the hand, which is an argument for building a rough deck early instead of perfecting one on screen.
`One_deck.jpg` is its figure, under the caption-as-door convention: the caption states both clearances,
says they were measured off the photograph, and notes the same frame decodes to `Phenology: No Flowers`
-- one image serving as proof of clearance and proof of content. `the-workflow.qmd` gained the practical
consequence (punch every card in the same place, stay inside the reserved band, assemble and photograph
one deck before punching the rest) plus the page-scaling-off warning.

**★ THE COVER ART LANDED MID-SESSION AND THE TITLE IS NOT COUPLED.** `voucher_cover_art_text.png` and
`voucher_logo_art.png` were written at 10:41/10:42 HST while this session was reading the chapters. Two
things: the filenames are `voucher_*` while `_quarto.yml` reserved `vouchr_*`, and **despite the "_text"
in its name the art carries NO baked-in title.** So the AI_Microscope failure mode does not apply --
the title can still be chosen freely at the read-through with no reshoot. Both assets copied into
`documentation/images/`; `cover-image` wired and un-commented; the logo left off with a note, since
`navbar.logo` is not a documented book-level option. `title:` still reads the placeholder `vouchr`.

**Files changed.** `documentation/decks.qmd`, `documentation/the-workflow.qmd`,
`documentation/_quarto.yml`, `documentation/images/` (One_deck.jpg + both art files, new),
`design_notes.md` (new dated section carrying the measurement table), `make_qr_cards.R`,
`decks/deck_universal.csv`, and `vouchr/R/make_qr_cards.R`. The vouchr change is **uncommitted in the
repo** -- comments only, but v0.1.0 is pushed, so it needs a commit.

**★ SAME SESSION, Kim's answers (2026-07-29 cont.) — the title is settled and a new failure mode was named.**

**THE TITLE: "Voucher Labels"** — *"properly descriptive and it spans the vouchr package and the label
writeup."* Closes **Open Question #1 (naming)** completely; the last part had been deferred to the
read-through. Set in `_quarto.yml` over the `vouchr` placeholder. The cover-art files were already named
`voucher_*`, so this morning's apparent filename mismatch resolves itself and nothing needs renaming;
and because the art carries no baked-in title, the AI_Microscope reshoot risk never applied. Naming
complete: package `vouchr` · folder/PKM `specimen_labels` · book **Voucher Labels**.

**The cover construction: the ORIGINAL chapter claim was right, and softening it was my error.** Kim:
matching plastic covers **front and back**, plus **a blank card just inside each** — for protection *and*
**to block a QR showing through cover stock that is not fully opaque.** The white surface I measured in
`One_deck.jpg` was that blank end card, not a white backing.

**★ THE BLANK CARD CLOSES A FAILURE MODE THE DOCUMENT HAD NEVER NAMED.** Every robustness argument in the
book is about **losing** a reading — a code that won't scan, a dropped deck, a dead phone — answered by
redundancy plus the graceful-degradation floor. Show-through is the **opposite**: **gaining a reading that
was never chosen.** And it is the worse of the two for a structural reason: **redundancy recovers what was
lost and does nothing about what was never true.** A lost reading announces itself; a false one is
indistinguishable from a real one downstream. **This is Finding 020's shape a THIRD time** — first a
stubbed QR engine, then a clearance measured against the wrong reference, now a code that decodes
correctly and means nothing. Kim's fix is the right kind: **designed out, not detected** — cheaper than any
validator and requiring no field discipline. Written into `decks.qmd` and into `on-fragility.qmd`, which
had argued only the lost-reading direction and is stronger for naming both.

**The determination card does two jobs.** The 07-28 decision rested on an epistemic argument (an
observation is what the collector saw; a determination is who asserted the identification). Kim adds the
operational half: photographing it **assigns the responsibility while the collection is being made**, and
**the field arrives pre-filled**, so nobody types the same determiner a hundred times at assembly. Both
now in `decks.qmd`. The pattern is worth watching — these moves keep paying twice, field-side and
lab-side, the same way "having the categories makes decisions quick" pays separately from no-transcription.

**The Abundance mismatch: KEEP it, LABEL the files.** Kim asked whether a slight mismatch is OK. It is more
than OK — **the mismatch is the book's own thesis in the filesystem.** `decks/*.csv` are what
`discover_decks()` returned for a corpus; `QR_field_notes.csv` is one collector's working kit; the book
argues at length that facets travel while value-sets are local. Forcing agreement would contradict the
argument and destroy a discovery output. **The defect was never the mismatch — it was that nothing said
which file was which**, which is exactly how the phenology drift survived a month. **`decks/README.md`
created:** provenance of every file, the two expected differences (phenology vocabulary; presence of an
abundance deck), and the rule — *do not reconcile the contents, keep the provenance legible.*
**`deck_universal.csv` RESTORED** to its five phenophase values (Kim confirmed): the **book** uses the
printed vocabulary so figures match the photographs, and the **files** each keep what they actually are.
★ **Process note:** this morning's call bundled "the book uses the printed set" with "so correct the CSV,"
and the second half did not follow from the first. The tell was that applying it required overwriting a
discovery output and recording the loss — **when carrying out a decision obliges you to preserve what it
destroys, it is probably two decisions wearing one label.**

**★ CORRECTION, same session — the "session_log instability" was mostly MY measurement error.** Earlier in
this session I declined to rewrite `session_log.md` and recorded that three stagings of the unchanged file
returned three different byte counts (558,005 / 568,620 / 571,014) and two heading counts. That conclusion
was wrong, and the record is corrected here rather than quietly amended. What actually happened:
**(a)** the "558,005" figure was a **character** count compared against **byte** counts -- the file holds
3,354 multi-byte UTF-8 characters (571,014 bytes vs 567,660 chars), so the two figures were never
commensurable; **(b)** the "568,620" read was **my own already-edited local copy**, because
`device_stage_files` does not overwrite a staged file that already exists -- so what I took for an
independent fetch was a re-read of my own output; **(c)** the "two heading counts" were that same copy with
my entry inserted **twice**. **One thing was real:** the very first read WAS short -- 558,011 chars against
the true 567,660, about 9,600 characters missing -- so a first-access partial read on a Drive Stream-mode
placeholder does happen, and committing an edit built on it would have destroyed those characters. The
caution was right; the evidence I gave for it was not. **Three genuinely independent fetches now agree
byte-for-byte** (571,014 bytes, 147 `##` headings, matching Drive's own metadata size), so this entry was
written straight into `session_log.md` and the standalone hand-off file is no longer needed.
**★ THE LESSON, which is Finding 020 turned back on my own verification: a check that compares two
quantities in different units is not a check.** Today's other rule was *a verified number must name what it
was measured against*; this adds *and in what unit*. Both failures have the same shape -- a verification
loop that could not tell a real discrepancy from an artifact of its own measurement. **Operational rule for
the PKM, worth carrying into the Tier-3 surfaces map: to force a genuinely fresh read over the device
bridge, delete the local staged copy first. Staging alone may hand back the cached file, which makes a
"second opinion" no opinion at all.**

**Also queued: the log split.** `proj_specimen_labels.md` is now ~116KB with its log still in-file,
while proj_PKM / whittakerr / AI_Microscope / briefing_book all moved theirs to `logs/` with a `_Log:`
pointer on 07-28. Kim raised `logs/` while asking where the session entry belonged -- the entry belonged
in `session_log.md` (system-wide connective tissue, distinct from this per-project log), but the instinct
about the folder was right, just early.

**★ THE FUNCTION-REFERENCE APPENDIX IS WRITTEN (2026-07-29 cont. 2).** `appendix.qmd` replaced its stub with a full reference to `vouchr` 0.1.0, built from the roxygen docs rather than from memory, in five groups in use-order: **printing the cards** (`make_qr_cards`, `make_number_cards`, `qr_calibration_sheet`, `validate_qr_engine`, `avery_5371`) · **reading the photograph** (`read_photo`, `decode_qr`, `read_exif`, `parse_cards`) · **deriving the site** (`site_extract`, `site_place`, `site_geology`, `site_soil`, `site_substrate`, `site_hillshade`, `deg_to_compass`) · **assembling the record and its two views** (`assemble_record`, `read_capture`, `make_label`, `make_log_row`) · **discovering the decks** (`fetch_records`, `first_collector`, `signature_features`, `discover_decks`, `signature_heatmap`). **Completeness was checked mechanically, not by eye:** the five groups account for 5+4+7+4+5 = **25**, and a script cross-checked the documented entries against `NAMESPACE` -- nothing missing, nothing duplicated, nothing invented. That check is the point, given the day's other lessons; a reference is exactly the kind of artifact that looks complete while quietly omitting three functions. The prose carries the *reasons* alongside the parameters where a reason exists -- why `bind_left` is kept apart from `x_offset`, why `analysis_scale_m` is a parameter and not a constant, why `ledger` refuses a reissue, why substrate is derived rather than carded, why `determined_by` is lifted out of the observations -- so the appendix reads as a statement of what the system is made of rather than a wall of signatures. Also documented: the two outside tools and the single step each is needed for (Python pyzbar/OpenCV via reticulate for decoding, `exiftool` for EXIF), since R has no maintained QR *decoder*.

**★ THE HARDCODED GOOGLE KEY: ASSESSED, SOURCE CLEANED, PROVIDER ACTION IS KIM'S (2026-07-29 cont. 3).** Kim asked whether the key had actually been exposed or whether rotating is precautionary. Checked rather than assumed. **No evidence of exposure:** the key appears in exactly ONE file (`QR_procedures.Rmd`, twice -- a ggmap `register_google()` call and an Elevation API call, same literal); **it is NOT in the public `vouchr` repo** -- both copies of `site_extract.R` read `Sys.getenv("GGMAP_GOOGLE_API_KEY")` and always have; **`specimen_labels` is not a git repo at all**, so it was never pushed anywhere; **Drive permissions show a single entry -- Kim as owner -- on the file, on `specimen_labels`, and on the parent `Projects` folder**, so no link-sharing and no other principals; the document was **never published** (nothing QR- or label-related among the 19 live documents, and `Site_Extract.pdf` from the same era is image-only with no key text); and a Drive full-text search for the key prefix returns nothing. So **rotating is precautionary on the available evidence.** **★ TWO THINGS THAT MATTER MORE THAN ROTATING.** (1) **Editing the file does NOT remove the key from Google Drive revision history** -- Drive keeps prior versions, so only revoking at the provider actually neutralises the literal. The source edit prevents recurrence; it is not cleanup. (2) **The right action is probably DELETE, not rotate.** Nothing current needs a Google key: `site_extract()` defaults to `source = "aws"`, and Macrostrat, SSURGO and Nominatim are keyless -- the Google path is a legacy fallback, and the book's equity argument IS the keyless stack. Deleting is strictly safer than rotating, and a fresh restricted key takes minutes if the fallback is ever wanted. **The one exposure question no file check can answer** -- whether the key was ever called from somewhere unexpected, or pasted into mail, a screenshot, the retired D: mirror, or the `P://` path still referenced at line 617 -- lives in the Google Cloud console's usage metrics and restriction settings. That is worth a look either way. **DONE HERE:** both literals replaced with `Sys.getenv("GGMAP_GOOGLE_API_KEY")`, CRLF endings preserved, and a comment block added recording why a literal was dangerous even in a private folder -- **the document sets `echo = TRUE` globally and renders to PDF, so any literal in a chunk prints into the rendered output.** That, not the folder's privacy, was the real hazard.

**★ LIVE WORKED EXAMPLES RUN ON KIM'S MACHINE (2026-07-29 cont. 4).** Four of the five chapter placeholders now have real output in `documentation/images/`, each verified by content and not by exit code. **⚠ FIRST, THE NEAR MISS: the INSTALLED `vouchr` was 0.0.0.9000 with 21 exports** -- the build from BEFORE the 07-28 rebuild. Its `make_qr_cards()` was the old `marrangeGrob` version with no `bind_left`, and `validate_qr_engine()` did not exist in it. Running the deck-sheet example against that library would have rendered a perfectly plausible sheet showing **exactly the geometry the chapter says was wrong**, with no guard to stop it. Reinstalled from source -> 0.1.0, 25 exports, `bind_left` present, and `validate_qr_engine()` passes against the real `qrcode` engine. ★ **The rule: a documented version and an installed version are different facts.** Check which one is loaded before trusting any figure it produces -- Finding 020 again, at the library level. **(1) DECK SHEET** (`deck_sheet.png`, plus `deck_sheet_guides.png` showing card outlines, the reserved band and the punch mark -- the better book figure since it makes the binding argument visible). Verified independently: page is 8.5 x 11in, the ten QR centres sit within **0.02in** of the true Avery clear-zone centres (3.19 / 6.69in x; 1.5 to 9.5in y), and **10 of 10 codes decode from the rendered sheet** -- position AND content both measured. **(2) END TO END** on `Example_1.jpg`: **6/6 codes** decode (confirming the 07-28 claim), EXIF read, site derived, record assembled, label and log row produced. `Determined by` lands correctly as a first-class field. **(3) DERIVE** on the project's own Kilauea coordinate (19.435731, -155.336334, taken from `reader_assembler.R`'s example rather than invented): elevation **1344.1 m**, slope **4 deg**, aspect **99 deg (E)**, roughness 1.6 m, native resolution 4.4 m at a 31 m analysis scale; bedrock **Kau Basalt, lava flows, 0-2.588 Ma** (Macrostrat); soil **Andisols, Haa-Keamoku complex** (SSURGO). **This reproduces the 2026-07-01 recorded result exactly and matches `derive.qmd`'s prose word for word** -- "a gentle, east-facing slope, high up, on young basalt, over the ash soils that weather there." Hillshade with the collection point marked saved as `derive_hillshade.png`. **(4) DISCOVER DECKS** from the cached CSV: 1,144 records, 20 collectors at >=10 specimens, 4 clusters. **All four archetypes reproduce**, including the one I first thought had not: cluster 4 is `uehana` = *"Shea Uehana (ORCID...)"*, all 14 records `institutionCode = NEON`, signature templated to **1.00 across the board with `coll_number` 0.00 and `phenology` 0.00** -- precisely the "machine" archetype as described. I reported it missing before checking; the check is what corrected me. Describers (identified_by 0.96, tax_content 0.43), place-recorders (eco_content 0.88, identified_by 0.08 -- self-determined), terse (Dawson at 0.00 on every feature). **Phenology confirmed as the universal gap: 17 of 20 collectors at zero, mean occupancy 3.4%.** Heatmap saved; its first render had the x-axis labels colliding with the title, fixed by moving them to the bottom. **★ THREE DEFECTS FOUND WHILE DOING THIS, worth carrying.** (a) **`discover_decks()` cluster numbering is inconsistent**: the plot re-numbers clusters for display, so `dd$clusters` / `dd$profiles` call the terse group 1 and the machine 4, while the figure labels them 4 and 1 -- the two most distinctive archetypes, swapped. The book is safe because `discovering-decks.qmd` NAMES the archetypes instead of numbering them, but anyone cross-referencing the object against the figure will mislabel them. A vouchr bug. (b) **`metrosideros_US_1985_2026_fulldwc.csv` has 27 columns, not the 161 the GBIF pull returned** -- "fulldwc" is a misnomer; the analysis reproduces for the 12 existing signature features, but adding a feature requires re-pulling. (c) `file.info()$size` immediately after writing to G: reports a stale value (4096 bytes for files that are really 57-227 KB) -- Drive Stream write buffering, which is why every figure here was verified by staging it back and looking at it. **★ THE ONE BLOCKED EXAMPLE, and it is an honesty question, not a technical one.** `Example_1.jpg`'s EXIF puts it at **21.30219, -157.85729 -- Honolulu**, and the derived record reads "Hawaii Capital Historic District, Honolulu County", elevation **2 m**, slope **0 deg**, Makiki clay loam. The pipeline is perfect; the provenance is a bench test on a couch. But `closing-the-loop.qmd` introduces this photograph with *"It was taken in the field"* and `discovering-decks.qmd` ends on *"one photograph on a slope"*. **Not done and not to be done: pairing these real decoded cards with the Kilauea coordinate to make it look like a field collection.** That is the placeholder-QR failure in a new costume -- a plausible artifact that no check would catch. Kim to choose between an honest caption (which would also demonstrate the urban reverse-geocode fix and SSURGO working in a city) and waiting for a real field frame.

**★ ALL FIVE WORKED EXAMPLES NOW LIVE IN THE CHAPTERS (2026-07-29 cont. 5).** Kim ruled on the provenance question: **honest caption, and make a virtue of it.** **`closing-the-loop.qmd`** now names where the frame was actually taken, in the book's own voice -- a bench run at home, on a couch, not a collection -- and says why the honest version is shown: *"I could have quietly swapped in a coordinate from a real ohia forest and the output would have looked more like the argument I have been making, and I would rather show you the honest one, because a system you cannot audit is not a system you should trust."* The chapter then turns the limitation into a demonstration: **the urban record is the one run that exercises the compose-from-reliable-levels reverse-geocode fix**, and SSURGO is as sure of a Honolulu clay loam as of volcanic ash. "The machinery does not know it is indoors." Live chunks for decode -> EXIF -> substrate -> label -> log row, plus `Example_1.jpg` as the input figure. **`discovering-decks.qmd`**: the heatmap in place with a door-caption, plus a short read-the-figure-first paragraph; and its closing line **"one photograph on a slope" -> "a single photograph of a handful of cards"**, since the slope was never in evidence. **`derive.qmd`**: live `site_extract()` + `site_substrate()` on the Kilauea pair, and a hillshade figure whose caption says the relief is subtle *because it is a four-degree slope, not a cliff* -- the figure agreeing with the number rather than flattering it. **`the-workflow.qmd`**: the deck CSV as a table, the guides sheet as the rendered-output figure (chosen over the plain sheet because the grey band makes the binding argument visible), and the folder pass. **★ A FALSE CLAIM CAUGHT BY RUNNING THE CHUNK RATHER THAN TRUSTING THE PROSE.** I wrote that the two frames "agree on all seventeen fields." Verified: there are **sixteen** fields, and they do **not** all agree. Fourteen are identical -- every card value, the coordinate to the last digit (0 m separation), and every derived value; the two that differ are the **file name**, which must, and the **timestamp, by eight seconds**. Corrected to say exactly that, which is a better sentence anyway: *"two independent readings that disagree about nothing that matters."* The near miss is the point -- a plausible round number, written from memory of what the run ought to have produced, one verification away from entering the book. **Third instance today of the same discipline paying off** (stale installed package, wrong measurement reference, invented field count). **Also confirmed:** `decode_qr()` gets **6/6 on BOTH frames**, better than the "5/6 raw, 6/6 with one Otsu pass" recorded on 07-28 -- the packaged reader does the multiple passes internally, so the improvement is the packaging, not the camera. All chunk paths were tested from `documentation/` (Quarto's execute-dir for a book project) and every figure asset resolves. **NOT YET DONE: a full `quarto render`** -- `system2()` is blocked from this bridge, so the chunks were verified individually rather than by rendering the book. Kim should render once before deploying.

**★ FULL BOOK RENDER DONE AND VERIFIED (2026-07-29 cont. 6) -- correcting the "not yet done" note above.** The earlier entry recorded that a full `quarto render` had NOT been run because `system2()` is blocked from the r-studio bridge. **It is done.** `quarto::quarto_render()` works from the bridge (the R package does not trip the system-command restriction), and the whole book built: 13 chapters, quarto CLI 1.8.27. **Verified by inspecting the artifacts, not the timestamps:** title reads **Voucher Labels**; every live chunk's output is present in the HTML (`Phenology: No Flowers`, `Number: KWB 1243`, `Det.: KW Bridges`, the Honolulu locality, Makiki / Inceptisols / Honolulu Volcanics, 1344 m, Kau Basalt, Andisols); both tables rendered; all four figures resolve and ship into `_output/images/` plus a generated `derive_files/` for the live hillshade; and **a sweep of all 13 pages for leaked R errors and warnings comes back clean.** **★ WHY KIM WAS STUCK, worth keeping as a workflow fact:** rendering a book means rendering the **project directory**, not a file -- `quarto::quarto_render("<dir>")`. Rendering a single chapter `.qmd` builds it standalone with no TOC, no cross-references and no site, which is what "doing a file at a time isn't working" was. Root cause: **there is no `.Rproj` anywhere under `specimen_labels`**, so RStudio never offers the Build pane's "Render Book" button. Creating one in `documentation/` would restore the button. **Confirmed harmless:** a book project renders only the files listed under `chapters:`, so the superseded `limits.qmd` stub in the project directory is NOT published -- checked against `_output`, which contains exactly the 13 chapter pages and no `limits.html`. No config change needed. **FOUR PLACEHOLDERS REMAIN**, all in chapters untouched today, and they pass through as HTML comments (invisible to readers, still in the source): `mechanisms.qmd` wants the single-card "Life Form: Tree" scan-returns-plain-text demo and a cards-laid-out-flat shot; `field-log.qmd` wants the collection-points-on-hillshade map and the canopy-physiognomy figure. **The first two are reachable now** (a one-row deck through `make_qr_cards()`; `Example_2.jpg` for the layout, keeping `Example_1` unique to the closing chapter). **The two field-log figures are genuinely blocked** on material that does not exist yet: a day with several real collections, and a canopy image to read.

**★ KIM'S THREE NEW PHOTOGRAPHS WIRED IN; LOGO SETTLED; RENDER CLEAN (2026-07-29 cont. 7).** `Tree_card.jpg` -> `mechanisms.qmd` as the scan-returns-plain-text demo (it decodes to `Life Form: Tree`, checked). `Example_2.jpg` -> `mechanisms.qmd` as the cards-laid-out-flat figure, keeping `Example_1` unique to the closing chapter. **`Deck_spread_out.jpg` -> `decks.qmd`, and it is the best figure in the chapter**: cover, blank card, four life-form cards, blank card, cover -- the construction Kim described, and it lands directly beneath the paragraph about why the blank cards are there. `Decks_and_specimen_card.jpg` -> `decks.qmd` as the kit-as-carried figure (five closed decks + the number card), which also carries the bill-of-materials argument visually. **★ THE LOGO QUESTION IS ANSWERED BY TEST, NOT BY GUESS.** I had left it off because `navbar.logo` is not a documented book-level option. **`book: sidebar: logo:` DOES work** -- rendered, referenced in `index.html`, and shipped to `_output/images/`. Kim's regenerated 250x250 `voucher_logo_art.png` is in place. Full re-render: 13 pages, error sweep clean, the only remaining placeholder comments are `field-log.qmd`'s two. **★ A COLOUR MEASUREMENT WORTH KEEPING, AND A QUESTION.** The five cover colours are consistent across three independent frames -- yellow hue 40-45 deg, green 170-175, purple 292-296, silver sat 0.06-0.08, pink 346-353 -- so `decks.qmd`'s scheme holds, except that "gray for abundance" is more accurately **silver** (it is metallic). **But `Deck_spread_out.jpg`'s covers measure RGB(70,11,5), value 0.27, against RGB(187,46,63) at value 0.73 for the same life-form cover in `Tree_card.jpg`** -- same red hue family, a third the brightness. The white cards in both frames are exposed comparably, so it is not the lighting. **Most likely explanation, and it is Kim's own:** the covers "are not completely opaque," so a black backing reads through and darkens them, while a pale surface does not. If so the figure demonstrates the very translucency that motivates the blank cards, and the caption now says exactly that. **Written so it does not name the colour, pending Kim's confirmation** -- the third time today a colour claim has needed checking rather than asserting. **⚠ `photos/kipuka_puaulu/` DOES NOT CONTAIN KIPUKA PUAULU PHOTOGRAPHS.** Kim mentioned he is working on that set. The folder currently holds three files -- `PXL_20260729_0444*.RAW-01.jpg` -- which are **byte-identical (MD5-matched) to `Example_1.jpg`, `Example_2.jpg` and `One_deck.jpg`**: the card photographs taken at his house on 07-28 at 18:44-18:46 HST, EXIF **21.30219, -157.85729 (Honolulu)**, not 19.435 / -155.30 (Hawaii Volcanoes NP). Presumably a staging folder not yet populated, or a mis-copy. **Flagged rather than used:** building a "Kipuka Puaulu collecting sites" map out of three frames shot on a couch in Honolulu is precisely the failure this project keeps catching, and it would have been invisible in the finished figure. **★ PLANNING NOTE FOR WHEN THE REAL SET ARRIVES.** Kim: *"these were not taken with decks (no specimen collection in the National Park without a permit), they do show site locations where I'd likely have taken a sample."* So the field-log map must NOT imply collections -- **no permit means no specimens, therefore no collection numbers.** Framed honestly it is arguably a BETTER figure for that chapter than a real collection would be: it shows the spatial layer of a field log built from photographs alone, and it exercises the chapter's own **absence-as-information** argument -- where a collector went and where they did not -- without ever claiming a specimen was taken.

**★ THE KIPUKA PUAULU FIGURES ARE IN; ONE PLACEHOLDER LEFT IN THE WHOLE BOOK (2026-07-29 cont. 8).** Kim supplied nine photographs in `photos/kipuka_puaulu/` -- **genuine this time**, verified before use: EXIF puts them at 19.4246 to 19.4442 N, -155.3034 to -155.2766 W, taken 2026-03-06 between 12:04 and 13:11 HST, centroid 477 m from the kipuka, and none matching the Honolulu card frames that had been sitting in that folder earlier. **Nine photographs, eight distinct GPS fixes** (two are the same fix 16 seconds apart); seven fall within 60 m of one another, and two lie 1.5 km SSE and 2.8 km E. **TWO FIGURES BUILT, at the two scales `field-log.qmd` asks for.** `fieldlog_sites.png` -- the eight fixes on a hillshade with 20 m contours and a scale bar, over a 3 km frame, DEM fetched at ~9 m and reprojected to UTM 5N. `fieldlog_region.png` -- the same points as one dot on a 40 km frame with the Kilauea caldera (3.9 km SE), the crater chain, and the shoreline taken as the zero contour of the same elevation record. Per-site derived values also computed for reference: elevations 1202-1247 m, slopes 0-8 deg, aspects SSW to ESE. **★ THE HONEST FRAMING IS IN THE PROSE, NOT BURIED IN A CAPTION.** Kim: no collecting in a national park without a permit, so these are places he *would* have sampled. The chapter now says so in its own voice before the figure -- "there are no specimens behind these points and no collection numbers, and everything else on the map is exactly what a real day would have produced" -- which is the same move as the closing-the-loop bench-run disclosure. **It is arguably a BETTER figure than a real collection would have been**, because it proves the spatial layer is built from photographs alone, and the empty middle of the frame exercises the chapter's own absence-as-information argument. **TWO SELF-CAUGHT DEFECTS while building them.** (a) First draft of the regional map put the label "Pacific" on green **land** -- I had positioned it by eye from the plot margins. Fixed by computing the centroid of the cells below zero and placing the label there: **when a label can be derived from the data, deriving it beats eyeballing it.** (b) The first site map had labels 1/2/3/5 illegibly overlapping, because those fixes are 0 to 58 m apart; fixed with leader lines to offset labels, and the coincident pair is now stated in the title ("nine photographs, eight fixes") rather than hidden. **RENDER: 13 pages, error sweep clean, both figures shipped.** **ONE placeholder remains in the entire book** -- `field-log.qmd` line 23, the canopy-physiognomy figure, which needs a canopy or satellite raster for the site plus a blind physiognomic reading of it. Per design_notes (2026-06-30), the cheap DSM-DTM difference **saturates over tall closed forest** and reported 8 m for a stand near 20 m at this very kipuka, so that route is a detector and not a measure; the Meta/WRI 1 m GEDI-calibrated product streams keyless from open AWS and gave 15.8 m here, and is the right source if the figure is built.

**★★ THE CANOPY FIGURE IS BUILT AND THE BOOK HAS NO PLACEHOLDERS LEFT (2026-07-29 cont. 9).** **The Meta/WRI 1 m GEDI-calibrated canopy map came down keyless, exactly as design_notes (2026-06-30) said it would:** `tiles.geojson` (56,145 tiles) -> the quadkey containing the kipuka centroid (`022300033`) -> `chm/022300033.tif` via `/vsicurl`, a 65,536 x 65,536 raster at 1.19 m in EPSG:3857, cropped over the fixes in seconds. No key, no account, no package beyond `terra` and `sf`. **★ REPRODUCTION CHECK PASSED TO A TENTH OF A METRE.** design_notes recorded Meta 1 m at Kipuka Puaulu as **15.8 m, mean within 45 m**. Recomputed per-site today: site 5 gives **15.7 m**. The 06-30 measurement is reproduced almost exactly, which also identifies which of the nine fixes it corresponds to. **THE DERIVED PHYSIOGNOMY.** Around the seven wooded fixes the canopy runs mostly **12-16 m with emergents to 23 m** (per-site means within 45 m 9.5-15.7 m; 95th percentiles 16-21 m; maxima 18-23 m), and about **a quarter of that ground stands below 2 m** -- gaps, glades and grass. **★ AND A GENUINELY NEW RESULT: the canopy layer recovers what a KIPUKA IS, from the coordinate alone.** Over the wider 3.8 x 3.1 km window **72% of the surface is under 2 m and the median is 0**, while inside the cluster the median is **10 m with 49% over 10 m** -- an island of old forest standing in younger lava, which is the definition of the word, read off a raster by a machine that was told nothing but a latitude and longitude. The two outlying fixes are outside the forest and the map says so: site 4 reads **0.1 m (99% open)** and site 8 **1.9 m (65% open)**. Their earlier terrain results now make sense too -- site 8's slope 0 deg and roughness 0.1 m are open ground, not a measurement error. **★ KIM'S GROUND PHOTOGRAPH IS THE CHECK, NOT THE FIGURE -- and he agreed with the argument.** He offered `PXL_20260306_220723260.jpg` for the canopy placeholder. Declined for that role on principle: the placeholder and the 2026-07-03 illustration convention both specify an image **fetched by the coordinate**, because the whole point of the physiognomy figure is that the description is DERIVED -- collection-spanning, attention-free, obtainable by someone who was never there. A ground photograph is an **observation**, costing exactly the field attention the derive argument exists to save, so using it there would have quietly inverted the book's central derive-vs-observe partition. It also carries no scale, so any height read off it would be a guess, against the standing rule that a derived value must carry its scale, source and limits. **Used instead as ground truth beside the derived map, which is the stronger figure and is native to this project's history:** Kipuka Puaulu is the exact site where DSM-DTM was caught reporting **8 m for a stand near 20 m**, and what caught it was Kim having walked in it. The chapter now re-enacts that finding -- derived reading, then the honest paragraph about why a derived value is worth only its check, then the photograph -- and the new map puts the tallest stems at 23 m, the answer that agrees with the ground. **TWO FIGURE DEFECTS SELF-CAUGHT:** the first render produced a **40-entry discrete legend** (unusable; switched to a continuous ramp), and the cluster label was **clipped off the frame edge**. **★★ MILESTONE: `<!-- FIGURE` and `<!-- WORKED EXAMPLE` counts across all 13 rendered pages are now ZERO.** Render clean, 15 image assets shipping. **★ A PATTERN THE READ-THROUGH SHOULD WATCH.** The book now carries **three explicit honest-provenance disclosures** -- the Honolulu bench run in `closing-the-loop.qmd`, the no-permit candidate sites in `field-log.qmd`, and the derived-versus-checked canopy pair. Kim: *"it would have been better to have an actual data point, but given the circumstances, let's see what we can do with demonstrations that include honest explanations."* Each disclosure is individually right and they are the book's integrity on display; **read together they could start to sound apologetic, and that is a tone question for the read-through, not a factual one.** The fix if it reads that way is to vary the register, not to remove the disclosures.

**★ DEPLOY PREPARED AND STAGED; THE DRAG-DROP IS KIM'S AND HAS NOT HAPPENED YET (2026-07-29 cont. 10).** Kim called it a wrap and chose to proceed without a further read-through, having approved the acknowledgements explicitly. **Slug decided: `vouchr`** -- on the precedent that companion-package documents take the package name (whittakerr, coenosr, checklistr, lists, gePoints), and matching ai_microscope where the card reads one thing ("Preview & Review") and the folder another. So the card reads **Voucher Labels** and the URL will be `kimbridges-documents.netlify.app/vouchr/`. **Steps 2-5 of the documented Deployment Workflow are DONE, each verified rather than assumed:** **(2)** `_output/` **contents** copied from R into a fresh `kimbridges-documents/vouchr/` (18 of 18 items; `index.html` at the folder root; **explicitly checked for the coenosr nesting slip -- no stray `_output/`**; 14 pages, 24 MB), plus the cover placed at the folder root as `vouchr_cover_art_text.png` to match the `<name>_cover_art_text.png` convention. **(3)** Listing stub `docs/vouchr.qmd` written -- title "Voucher Labels", subtitle from the book, categories Botany / Methods / R, image and View-Document link both confirmed to resolve. **(4)** `vouchr/**` inserted into `_quarto.yml` `resources:` in alphabetical position between `using_an_llm` and `whittakerr`. **★ The file is CRLF and was edited in BINARY to preserve that** -- byte delta exactly the 17 bytes of the inserted line, because `writeLines()` on Windows would have rewritten every ending in the file. Same trap as session_log.md this morning. **(5)** Collection site rendered (Finding 017 behaviour as recorded: overruns the bridge timeout, completes normally). **PRE-DEPLOY CHECKS, both passes of the 2026-07-25 routine:** every local `src=` in every page walked against disk -- **211 references, 0 missing** -- run once on `_output/` and again on the copied `vouchr/` folder, since the copy is the artifact that actually ships; 0 broken local `href=`. Then the built site verified: the **Voucher Labels card is on the index (20 cards, was 19)**, its cover path resolves, its link resolves to `_site/vouchr/index.html`, and the built book is confirmed to be the CURRENT build (title "Voucher Labels", the "already in the cabinets" claim, the logo asset, and the acknowledgements page with Nancy Furumoto in it). `_site` is **327.7 MB**, consistent with the ~300 MB recorded for this collection. **⚠ NOT YET PUBLISHED. STATUS IS STAGED.** Step 6 -- dragging the whole `_site` folder onto the **existing** `kimbridges-documents` tile's Deploys tab -- is Kim's, and there is no path to Netlify from this session. Recorded as staged rather than live **on purpose**: claiming publication before the artifact is public would be the same class of error as the 8 m canopy and the 0.372 in clearance. **The known trap, from the whittakerr deploy: "Add new project" creates a standalone site instead of updating this one.** Click into the existing tile first. **ON PUBLICATION, the following need updating and are deliberately left undone until then:** `proj_kimbridges_documents.md` (19 -> 20 documents, new log entry); `proj_specimen_labels.md` and `proj_vouchr.md` (Status, and the deployed URL); `project_index.md` (the specimen_labels row and the Active Focus, which can then close); `inventory_all_projects.md`. Also still open and unrelated to the deploy: the **uncommitted comment fix in `vouchr/R/make_qr_cards.R`**, the **`discover_decks()` cluster-numbering swap**, deleting the Google key, and the `proj_specimen_labels.md` log split.

**★★ PUBLISHED. *Voucher Labels* IS LIVE at https://kimbridges-documents.netlify.app/vouchr/** -- the twentieth document in the collection. Kim drag-dropped `_site` onto the existing tile and verified the card and the document. His words: *"I've tried to finish it for nearly four years. Now it is out and I can discuss it with my colleagues."* **specimen_labels set Complete / Not applicable** on the briefing_book precedent -- a pending colleague review does not hold a deployed project Active. **Active Focus CLOSED**, with no successor asserted; PKM Tier 2 (`pkm_health.R`) is the standing candidate for the next session to confirm. **★★ MECHANISM 6 ADOPTED: DEFERRED WORK.** Kim's proposal, prompted by exactly the situation the publication created -- items that are real, worth remembering, and have no reason to be done now. The first five mechanisms cover intake, context, focus, record and closing; none held **work that is real but not now**, which had nowhere to go but Next Steps, where it either manufactured urgency on a finished project or was silently dropped. **The design point that shaped it: the file is the easy half, the trigger is the mechanism.** So Mechanism 2 gains the **project-touch rule** -- read a project's deferred section before working on it -- and Mechanism 5 gains **item 8**, file the non-urgent and clear it out of Next Steps. Without the trigger the file would be a write-only archive, which is worse than no file because it launders the guilt of not doing the thing. **Entries split into TASK** (waits for an occasion: next revision, release, render) **and CONDITIONAL** (not a task at all -- surfaces only if a named thing happens, and its value is arriving at the bad moment with the answer already written; filed among tasks it would be buried, and the bad moment is exactly when nobody reads a long list). **Item shape:** what, where, why deferred, who raised it, dated -- attribution because colleague reviews are expected to be the main source, and when a colleague asks whether their note landed the answer should be *yes, and here it is*. **Two rules:** items may be closed WON'T DO with the reason kept, because a list that only grows is a list that dies; and **deferred must mean "no occasion yet", never "unpleasant"** -- the Google key sat as an open item for weeks and that was not for want of an occasion. **Placement decided against the obvious version:** one file with per-project sections, not thirty near-empty files, splitting to `deferred/<name>.md` only when a section earns it -- the same growth path the per-project logs took to `logs/` on 07-28. `deferred.md` seeded with 13 real items across specimen_labels, vouchr, kimbridges-documents and the PKM itself, which cleared them out of the active lists -- the demonstration that the mechanism works. **vouchr comment correction committed and pushed** (`9be8f1c`), verified comments-only first (23 added lines, no code, no removals); tree clean and level with origin. **The cluster-numbering item was re-characterised honestly:** I had called it a bug; reading `R/deck_discovery.R` L109-110 shows the plot deliberately re-ranks clusters richest-first, which is a good figure decision. Nothing miscomputes. The defect is that two numbering schemes share the name "Cluster N" and nothing says so, which silently misleads anyone joining the figure to `$profiles`. Additive fix only, queued for 0.1.1; renumbering `$clusters` would break existing code. **Session close.** Nine hours, one publication, one new protocol mechanism, and a long run of the same lesson in different costumes: check the artifact, name what you measured against, and prefer deriving a fact to eyeballing it.

**Queued.** Figures from the real field photos (Example_1 is the multi-card-decode figure the
`mechanisms.qmd` and `closing-the-loop.qmd` placeholders want); function-reference Appendix;
provisional-label image; logo; **the read-through**; deploy. (Title, cover backing and the Abundance
question were all settled later in the same session -- see above.) Commit vouchr. Still open
from before: rotate the hardcoded Google key in `QR_procedures.Rmd`; seed the number ledger from the
historical KWB series. **PKM Tier 2** (`pkm_health.R`) and **Tier 3** remain queued behind the book.

---

## 2026-07-28 (cont. 4) -- DOCUMENTATION: the blank-slate claim raised to book level; naming closed

**Kim's directive:** *"You are right about not needing to start with a blank slate when establishing
categories and values. That's been an important discovery in this project and it needs to be emphasized
in the documentation."*

**Checked before assuming a gap** (Finding 019 habit) -- and the argument was already there, well made.
`decks.qmd` withholds the decks on purpose ("Handing you my decks would be handing you a destination.
The path is worth more"); `discovering-decks.qmd` delivers the empirical method, with the Andes
binoculars story doing the work. **So the gap was EMPHASIS and PLACEMENT, not argument:** it read as a
chapter payoff rather than a headline claim; `derive.qmd` sat between the promise and its delivery; and
the idea had no NAME, so it could not travel the way "capture once, project two views" does.

**★ THE NAME: "the answer is already in the cabinets."** Native to the book rather than imported --
the Introduction opens on Linnaeus's cabinet, calls it "order built into furniture," and closes on "the
sheet in the cabinet." The two centuries of sheets the method reads ARE in cabinets, so the handle and
the book's opening image are the same object. It now appears in exactly three places.

**Three chapter edits (Kim read and approved).**
1. **`index.qmd`** -- a new paragraph before the closing one, hung off Kim's own phrase "everything the
   record should hold," which raises the question and then walks past it. It asks it out loud, admits he
   expected the answer to be a matter of taste, and says plainly it was not. **Framed as a DISCOVERY**,
   per Kim's word. He confirmed "the part of this work I did not see coming" is a correct claim and to
   keep it.
2. **`decks.qmd`** -- the withholding passage now names the answer and **marks the distance**: "the
   answer is already in the cabinets. It belongs to the chapter after next." Naming the distance is the
   cheap repair for the promise-to-delivery gap: a reader who knows the answer is two chapters off reads
   a deferral, one who does not reads an evasion.
3. **`discovering-decks.qmd`** -- delivers under the same name, so promise and payoff are visibly one
   object. **Also fixed a plain error:** it said "the path the last chapter promised," but the promise is
   in `decks.qmd`, TWO chapters back with `derive.qmd` between. Now "the deck chapter."

**Deliberately NOT done: no chapter reorder.** `decks.qmd`'s handoff to `derive.qmd` is well built
("First there is the other half of the record to account for... That half we don't card. We derive it").
Moving `derive.qmd` would break a working transition to fix a problem the name plus the distance-marker
already solve.

**★ PHENOLOGY DECK IS YELLOW, not green** (Kim, as built). Corrected in `decks.qmd` AND in
`design_notes.md`, which still read "e.g. green = phenology" and would have quietly contradicted the
chapter. Kim's own photos are the ground truth: the yellow deck carries the Phenology card in both
`One_deck.jpg` and `Example_1.jpg`. **This is the SECOND detail today where the built object and the
written description had drifted** (the first was the collector card's wording). **Recommended for the
printing reconciliation: a pass that checks every physical claim in `decks.qmd` against the decks in
hand.**

**★ NAMING CLOSED (Open Question #1, open since 2026-06-29).** Kim's decision: package stays `vouchr`;
folder and PKM file stay `specimen_labels`; **book title deferred to the read-through**. Evidence that
informed it: of 101 `specimen_labels` references, **68 are archived text that stays verbatim** (dated
session_log entries, focus_history), leaving 33 live and only 12 filesystem paths -- so a rename is
cheap but can never be complete. Recorded AS A DECISION in both proj files with the cost figures,
because an unrecorded "we chose not to" is indistinguishable from "nobody noticed."

**⚠ LIVE RISK -- the cover could decide the title by accident.** Kim is making the cover art now.
`_quarto.yml` reserves `vouchr_cover_art_text.png` and `vouchr_logo_art.png`; the `_text` suffix and the
AI_Microscope precedent mean **title type gets set INTO the art** -- and on that cover Kim caught his own
title error on the first pass and reshot. `_quarto.yml` currently reads `title: "vouchr"`, a
PLACEHOLDER. Flagged to Kim: either choose the title now, or shoot a cover that leaves room for type.

**Session paused here** -- Kim is watching a night eruption at Kilauea and making the cover photo.

## 2026-07-28 (cont. 3) -- vouchr v0.1.0 PUSHED; proj_vouchr.md created (intake gap closed)

**The package was out of date and Kim called it.** vouchr 0.0.0.9000 (2026-07-02) still carried the
card maker with BOTH defects found today: `marrangeGrob` over the whole page (0.375in off, opposite
directions per column) and no binding clearance. Every card it printed would have been wrong, with no
protection against a bad QR engine.

**Ported and pushed as `0ad01e1`** (2026-07-28 19:51 -1000; 18 files, +1141/-96). `make_qr_cards()`
replaced wholesale; `make_number_cards()` + issued-number ledger, `qr_calibration_sheet()` and
`validate_qr_engine()` added; `assemble_record()` gained collector aliases and first-class
`determined_by`. **Imports 6 -> 5**: gridExtra, readr, tidyr and purrr were used ONLY by the old card
maker, so the rewrite removed all four; grDevices/stats/utils were being imported without being
declared and are now in DESCRIPTION (likely the standing check NOTE). Exports 21 -> 25, tests 8 -> 21.
`document()`/`test()`/`check()` clean on Kim's machine: **0 errors / 0 warnings / 1 note** (the benign
clock note).

**★ A bug caught by writing a test that was expected to PASS.** `check_template()` accepted a 4in card
on a 3.5in pitch: neighbouring cards would overlap and print on top of each other, while the
sheet-extent check passed happily because 0.75 + 3.5 + 4 = 8.25 still fits inside 8.5. Explicit
pitch-overlap checks added in both axes. **The lesson generalises Finding 020's fourth rule:** a check
suite proves nothing until a test you expected to pass fails.

**Verification split honestly, per Finding 020.** No CRAN in the sandbox, so roxygen, testthat and
`R CMD check` ran on Kim's machine. What the sandbox COULD verify, it did: every file parses; 22
assertions across geometry, validator, ledger and identity fields; and both PDFs rendered *through the
package code* decode at 300 dpi -- **16/16 deck codes, 10/10 number codes**. NAMESPACE was hand-written
to match roxygen and later proved **identical to what `document()` generated**.

**Push verified read-only from the sandbox** (no credentials here; Kim pushed with gert): all nine
source files byte-identical to what was delivered, all four new `.Rd` present, no stale `n_col`/`n_row`
left in `man/make_qr_cards.Rd`, all 26 `.Rd` documenting functions that exist, and no stray PDFs,
ledger CSVs or `.Rhistory` in the tree.

**★ INTAKE GAP CLOSED -- `proj_vouchr.md` CREATED.** vouchr has been a public GitHub package since
2026-07-02, actively developed, with **no proj file and no index row**, while every sibling
document+package pair in this PKM carries two (checklists/checklistr, lists/listsr,
seasonality/seasonalityr, Ceska/coenosr). That is the same shape as the founding **Jones gap** that
Mechanism 1 exists to prevent: work deep enough to have its own repo, tracked only inside another
project's file. The new file carries an explicit intake note saying it was created late and that all
history before today stays in `proj_specimen_labels.md` -- a pointer, not a reconstruction (Finding
018/019). **Flagged for Kim to veto** if he would rather vouchr stay folded into specimen_labels.

**Duplication now needs resolving** (logged as vouchr Next Steps 1): the card makers and reader exist
both in `Projects\specimen_labels\` and in the package. The package should be canonical and the
project folder should consume `library(vouchr)`, or the two copies will drift.

**Next: the documentation reconciliation** -- the book chapters describe the card makers and must match
the upgraded printing, plus elevating the blank-slate discovery to a book-level claim.

## 2026-07-28 (cont. 2) -- ★★ END-TO-END PROVEN: 6 codes from one photo -> a real label + log row

**The founding claim holds on real photographs.** Kim reprinted from the real `qrcode` engine,
reassembled the decks and shot three photos. **Example_1: 6/6 codes raw. Example_2: 5/6 raw, 6/6 with
one Otsu pass. One_deck: 1/1.** Payloads exact. The 2026-06-29 two-code test now holds at SIX, on a
phone, in ordinary indoor light.

**The margin, measured.** Example_2's "Determined by" card is visible but fails raw (verified a real
decode failure, not an absent card) and recovers under Otsu. Against a card that decoded easily:
focus 265 vs 354 (Laplacian variance), ink 73 vs 42 -- softer and greyer, at the frame edge on a
purple deck. **One binarization pass is the difference between 5/6 and 6/6**, validating the ladder
already in `decode_qr()`. **CLAHE alone made it WORSE** (6->1, 5->0); pair it with Otsu, never bare.

**★ FIRST REAL LABEL + FIELD-LOG ROW from a real field photograph, no transcription in the chain.**
EXIF gave 21.30219 / -157.85729, 122.5 m, 2026-07-28 18:44:45 -10:00.

**A bug only the real run could surface.** The assembler printed `Collector: NA` -- the deck writes
`Collected by:` while the code looked for `Collectors`/`Collector`, so the name fell into `observed`.
Fixed by widening the aliases, NOT by reprinting physical cards. **Finding 020's rule paying off the
day it was written: exercise the artifact the way its consumer will.**

**★ Kim's design decision: `Determined by` is FIRST-CLASS, not an observation** -- an observation is
what the collector SAW; a determination is WHO ASSERTED the identification, carries an authority, and
can be revised later without disturbing field observations. Now beside number and collector, a `Det.:`
line on the label, a log-row column, omitted when absent.

**★ Kim's assessment of the physical system, captured verbatim in `design_notes.md`.** Three claims
separated as the spine of the deck chapter: (1) **the bill of materials IS the argument** -- printer,
Avery stock, paper punch, screw posts, report covers: the friction thesis at the level of procurement;
(2) **"having the categories makes decisions quick"** is the FIELD-side payoff, a different claim from
no-transcription (the LAB-side payoff) -- recognition beats recall beats composition, exactly when
conditions are worst; (3) **the hard part is deck DESIGN and the system is deliberately NOT
prescriptive** -- "Choose the content for the purpose of the collection." Noted there: not
prescriptive about content is not the same as silent about method -- deck-discovery, collector
signatures and the derive-vs-observe partition are how a collector derives a deck for their own
discipline. Weatherproofing named and put OUT of scope deliberately, to keep the bill of materials at
the stationery level.

**Still open:** fold the makers into `vouchr`; reconcile the documentation chapters with the upgraded
printing; the production pass (figures from these photos -- `One_deck.jpg` is the binding-clearance
proof shot, Example_1 the multi-card capture), Appendix, provisional-label image, cover/logo, title,
read-through, deploy.

## 2026-07-28 (cont.) -- THE PRINTED CARDS DO NOT DECODE; Finding 020; machine-enforced fix

**Kim returned from the field with two photographs** of the same six cards in two arrangements
(`photos/Example_1.jpg`, `Example_2.jpg`), to test the project's founding technical claim: that
several QR cards in ONE photograph all decode. **Result: zero codes read, in both photographs --
and the test is INCONCLUSIVE, not negative, because the cards never carried data.**

**Diagnosis.** zbarimg and pyzbar returned nothing at native resolution and across nine downscales,
and OpenCV's detector found no quads. That uniformity was the tell: decoder tuning does not fail
that cleanly. Cropping one code at high resolution showed **a single finder pattern at top-left and
none at top-right or bottom-left**. A valid QR has three. Every card on both photographs carries the
same signature, and a side-by-side of the PDF I generated against the photographed card matches
module for module.

**Cause -- mine.** With no CRAN access in the cloud sandbox I stubbed `qrcode::qr_code()` with a
random-fill generator so PDF LAYOUT could be tested, and **Kim printed those placeholder PDFs.** I
labelled them as placeholders in prose, three times. That was not a safeguard: the artifact was a
perfectly formatted, print-ready sheet of business cards, and an artifact's affordance beats a
caption. He printed the decks, hole-punched them, mounted them on screw posts, colour-coded them,
and photographed them in the field before anything surfaced.

**★ FINDING 020 written to pkm_findings.md** -- *a verification loop that cannot tell a real
artifact from a plausible-looking one is not verification.* Every geometry check I ran passed:
placements to 0.00007in, clearance 0.372in on all sixteen cards, page counts, glyph overflow, a
blank-page regression. **Every one measured POSITION; not one measured CONTENT.** Rules adopted:
(1) never ship the output of a simulated dependency -- produce nothing, or produce something that
cannot be mistaken for the real artifact; (2) verify the property the artifact is FOR (a QR card
exists to decode; position is a precondition, not the point); (3) prefer a machine-enforced refusal
to a warning. Finding 020 is **Finding 016 one level deeper** -- 016 says render then LOOK; 020 says
looking is not enough when the failure mode is invisible to the eye.

**The structural fix, shipped.** `validate_qr_engine()` added to `make_qr_cards.R` and called by
both makers before anything is written. It checks the QR skeleton in **pure R, no scanner, no
external tools** -- three 7x7 finder patterns, timing rows 6 and column 6 alternating, a legal side
length of 21+4(v-1) -- and hard-stops with no file written if they fail. Verified both directions:
it **blocks** the stub (no PDF created) and **passes** genuine QR codes. The stub can no longer
produce a printable PDF at all.

**★ A fourth rule, learned building the third.** The first validator correctly rejected the stub
**and would have rejected every real QR code too** -- an integer-vs-double comparison inside
`identical()`, and an off-by-two in the timing-run length (n-14 where the run is n-16). Testing only
that a checker rejects the known-BAD input ships a checker that rejects everything. Caught by
generating genuine QR matrices with an **independent implementation** (Python `qrcode`) and
confirming all passed, including one carrying a quiet zone that had to be trimmed. **A validator
must be tested against known-GOOD inputs from an independent source before it is trusted.**

**Housekeeping.** `number_cards_ledger.csv` reset to empty so **KWB 1243-1252 can be reprinted** --
those numbers never reached a specimen, so nothing is lost by reissuing them.

**Cost.** One print run, deck assembly, one field photography session, and a test that returned no
information about the question it was meant to answer. No data destroyed; no collection number
burned.

**Still open -- the actual experiment.** Whether several QR cards in one frame all decode, and
whether the two arrangements differ, remains **untested**. The photographs themselves are good:
even lighting, codes flat and unobstructed, and the binding clearance visibly works as designed in
Example_1. Reprint from Kim's machine, rebuild, re-shoot.

## 2026-07-28 -- specimen_labels: card PRINTING FIXED (two independent defects); number cards built

**Active focus at start:** specimen_labels, exactly as the 2026-07-28 block predicted for today.
Kim confirmed. He had gathered the illustration materials and hit a blocker: the QR codes on the
printed decks needed to move "about 1 inch to the right."

**TWO INDEPENDENT DEFECTS, not one.** The first diagnosis was correct but did not explain Kim's symptom,
and the gap between them was the useful signal.

**Defect 1 -- sheet alignment (found by reading the code).** `make_qr_cards.R` laid the cards out with
`gridExtra::marrangeGrob(ncol=2, nrow=5)` across the whole 8.5x11 page. That divides the page into ten
equal **4.25 x 2.20** cells, which is NOT where Avery 5371 cards sit: the real cards are **3.5 x 2.0**
inside a 0.75in side margin and a 0.5in top margin. Cell centres fell at 2.125 / 6.375in against true
card centres of 2.500 / 6.000in -- **0.375in off, in OPPOSITE directions in the two columns**, so no
single nudge could ever have fixed it. Rewritten to place each card in its own grid viewport at the true
Avery position; measured on the rendered PDF, QR centres now land at 2.4999 / 5.9999in.

**Defect 2 -- binding clearance (found only by asking).** The 0.375in computed error did not match Kim's
measured ~1in, and that mismatch was the tell. Asked rather than assumed, and the real cause was
physical, not typographic: **the decks are bound on the LEFT through a punched hole on a screw post, and
the fanned stack occludes roughly the left 1.5in of the card underneath.** A centred QR's left edge falls
at 1.18in from the card edge -- inside the occluded band -- so the code was clipped. Content centred in
the card is geometrically correct and ergonomically wrong.

**★ THE LESSON WORTH KEEPING: when the measured symptom does not match the computed defect, the
diagnosis is incomplete.** The first fix was real, necessary, and shipped -- and it would not have solved
Kim's problem. The 0.375-vs-1.0 discrepancy was noticed and flagged in the hand-off, which is what made
the second question get asked instead of the fix being declared done.

**What was built.**
- **`bind_left`** (default 1.5in) reserves the screw-post band; all content lays out in the clear zone to
  its right. Verified: every QR's left edge at **1.872in, 0.372in clear** of the band, all 16 cards.
- **`x_offset` / `y_offset`** kept as a separate printer-calibration knob. Deliberately NOT merged with
  `bind_left`: one is a fact about the BINDING (where content sits within a card), the other a fact about
  the PRINTER (where the grid lands on the sheet). Conflating them would have hidden both.
- **`qr_calibration_sheet()`** -- outlines, shaded binding band, punch-hole mark, quarter-inch scales;
  print on plain paper at 100%, lay over an Avery sheet, punch one and mount it on the post to confirm
  the band width before spending card stock.
- **`make_number_cards.R` (NEW)** -- the collection-number identity cards.
- **`number_cards_ledger.csv` (NEW)** -- every issued number recorded; reissue refused unless
  `allow_reprint=TRUE`. A collection number used twice cannot be repaired afterwards.

**Three decisions on the number cards, each taken from the project's own files rather than invented.**
1. **No binding band.** design_notes.md: *"Identity + free-text = business-card holders. These you
   *detach* (a number card onto a specimen) ... so a loose holder fits better than a bound stack."*
   Nothing fans over them, so the full card width is available.
2. **Number BESIDE the QR, not above it.** Removing the band alone would NOT have enlarged the code --
   the QR is sized by the height of its middle band, not by card width, so it would have stayed 1.14in.
   Setting the number alongside lets the code use the full content height: **1.76in square, 2.4x the
   area.** This matters because design_notes names the number card the **graceful-degradation floor**
   ("the non-negotiable minimum is the number card + the photo") -- it is the one card that must scan.
3. **Payload `Number: KWB 1243`** -- exactly what `reader_assembler.R`'s `parse_cards()` already expects,
   so the identity card needs no special case in the reader.

**Dependency reduction.** `make_qr_cards.R` dropped `gridExtra`, `readr`, `tidyr` and `purrr`; it is now
**base R + `grid` + `qrcode`** only. Forced by the cloud sandbox (no CRAN reachable, only base R + grid
installable) but correct on its own terms -- fewer Imports when this folds into `vouchr`.

**Kim's intent read, and confirmed correct.** He asked for "12 (to fill just one page)". The sheet holds
**10**. The stated constraint ("one page") was treated as binding over the stated count, and **KWB
1243-1252** was generated. Kim: *"You interpreted my intent (one page) properly."*

**Two regressions caught by verification, not by reading.** (a) Reserving the band narrowed the content
zone from 3.26in to 1.88in, which **broke two existing deck labels** -- "Abundant Flowers" and "Scattered
Flowers" run ~2.0in at 18pt. Added auto-shrink with a warning; a `safety = 0.96` factor was needed because
measured glyph runs came out ~3% wider than `grobWidth` reported, enough to nick the band. (b) The
header-width pre-scan opens the graphics device, so the loop's unconditional `grid.newpage()` produced a
**leading blank page**; fixed with `if (p > 1)`. Both were found by measuring the rendered PDF with
PyMuPDF, not by inspecting source. **Consistent with Finding 016: the exit code is not the artifact.**

**Verification method note.** No R packages beyond base + `grid` are installable in the cloud sandbox and
CRAN is unreachable, so `qr_code()` was **stubbed** (random modules) to test layout, and geometry was
measured off the rendered PDF. Every delivered PDF carries placeholder QR codes and was labelled as such;
Kim runs the scripts in RStudio for scannable output. The calibration sheet has no QR codes and is valid
as delivered.

**Outcome.** Kim printed both: *"those printed perfectly"* and *"This solved the problem perfectly."*
He now has the physical materials -- observation decks + number cards -- and has **paused the session to
do the photography**, which is the raw material the remaining figures need.

**Files changed.** `Projects\specimen_labels\`: `make_qr_cards.R` (rewritten), `make_number_cards.R` (new),
`avery_5371_calibration.pdf` (new), `number_cards_ledger.csv` (new, 1243-1252 issued),
`KWB_1243_1252.pdf` (layout proof, placeholder QRs).

**What's queued (Kim, at pause).** *"Later, we need to make sure that we're updating the code and
documentation to reflect the upgraded printing."* Concretely: fold the card makers into **`vouchr`**
(the new base-R-only form is package-ready); re-check the **documentation chapters** that describe card
making against the new geometry -- the binding-clearance constraint is a genuine design finding and
belongs in the book, not just in the code; then the production pass resumes (figures from the real field
photos, function-reference Appendix, provisional-label image, cover + logo, the title, read-through,
deploy). **Also still open:** rotate the hardcoded Google key in `QR_procedures.Rmd`; consider seeding the
ledger from Kim's historical KWB series, which it does not yet know about.

## 2026-07-28 (evening) -- PKM STRUCTURAL REVIEW; Tier 1 executed

**Active focus at start:** undecided (the 2026-07-26 block asked for a choice).
Kim redirected to a review of the PKM itself.

**Diagnosis.** The two artifacts Kim noticed -- two stranded 113 MB `_site` folders
in `C:\temp`, and a git clone at `~\Documents\ai_microscope` -- are ONE hole, not
two. Every containment rule in the PKM is DRIVE-SCOPED. The storage architecture was
decided **2026-05-10**; the ClaudeR bridge arrived **2026-05-30**, twenty days later,
and can write anywhere on the machine. Eight of the nineteen findings (006, 007,
009, 012, 013, 014, 015, 017) are bridge mechanics. Every off-Drive artifact traces
to a named bridge constraint: shell execution blocked -> no recursive delete -> a
DATED `_site_20260726` rather than an overwrite; Drive-stream placeholders skipped
by the browser upload -> copy off Drive before drag-deploy; shell git blocked and
git-in-Stream hostile -> the clone had to live off Drive. The rules were not
violated, they were OUT-SCOPED. The deferred clause in proj_PKM's storage decision
("until one appears") predicted exactly this and was never revisited.

**Category error found.** The PKM has one entity type (proj_*.md) but the work has
four: VENUE (4), INFRASTRUCTURE (1), PROJECT (~50), and WORK (83 published items --
documents 19, stories 58, fiction 2, collections 4), of which only ~21 have a PKM
record. **The Jones gap was a level-4 work misfiled as a level-3 project**; intake
was aimed at level 3, so it cured the symptom and left the category error standing.
Resolution adopted: *a proj file tracks work IN PROGRESS; a generated register
tracks work that EXISTS.* A work earns a proj file on DEVELOPMENT, not publication.

**Kim's rules, adopted.** Deployed -> no longer Active. A pending external review
does NOT hold a project Active unless Kim explicitly says so. Small remainders get
closed at end of session. (Half of this already existed in template.md's Complete
definition and had simply never been applied -- the drift pattern, a fourth time.)

**TIER 1 EXECUTED (byte-exact splits, snapshot first).** Snapshot of all 11 touched
files in `Projects_Index_archive_2026-07-28/`, verified byte-for-byte. New `logs/`
subfolder. `project_index.md` 132.6 -> 20.9 KB (superseded focus blocks + Change Log
-> `logs/focus_history.md`; the project-clusters note at old lines 423-446 was NOT
history and was kept). Log tails split from proj_PKM (53->5.4), proj_whittakerr
(153.8->26.5), proj_AI_Microscope (46.7->18.1), proj_briefing_book (48.2->7.0), each
with a `_Log:` header pointer, all four verified to resolve. **SESSION-START COST
184.4 -> 26.3 KB, an 86% cut, ~40,500 tokens returned at the top of every session.**
Losslessness verified: every non-blank original line is present in exactly one of
the two pieces; the only three absences are the header fields deliberately changed.

**Reclassified.** AI_Microscope and briefing_book -> Complete / Not applicable. The
five kimbridges_* files -> **Standing**, a new Status value (a venue or the site
build; receives work continuously, never finished), defined in template.md along
with the review-does-not-hold-Active amendment. `proj_lists.md` repaired: its
`_Status:` held free text, so it was invisible to every status sweep.

**Noted, not acted on.** `session_log.md` is 530 KB and now the largest file in the
system -- the obvious next split. 28 proj files still read Active; the automated
deployed->Complete scan OVER-SELECTS and must be applied one at a time.
specimen_labels stays **Active** -- Kim has the parts, buys printer cartridges
tomorrow, and it is the likely next focus.

**NEW BRIDGE DETAIL, extends Finding 014.** The RStudio MCP security guard scans the
SOURCE TEXT of the submitted code, not the calls actually evaluated. Writing this
very log entry failed twice because the prose contained the blocked function name
followed by an open parenthesis INSIDE A STRING LITERAL. The guard also refuses the
ENTIRE call, not the offending statement, so nothing at all is written. Rule: when
writing prose about the blocked shell functions through the bridge, name them
without the trailing parenthesis.

**Queued:** Tier 2 = build `pkm_health.R` (generate register / reconcile source ->
_site -> live / verify pointers / flag drift). Tier 3 = the storage buckets, the
surfaces-and-permissions map, and the protocol amendments. Rain from Wednesday.

## 2026-07-28 — PKM maintenance: the log gap that was not a gap; session_log.md ordering repaired; FINDING 019
Session-start protocol run (Fable 5; R bridge live, after a restart of the RStudio addin). No project focus opened. Kim asked to spend a little time on the July 2026 log-gap backfill. The backfill was scoped, written, and then thrown away, because there was no gap: the entries had been misfiled, not lost. What follows is the repair.
- **The finding.** The LOG GAP marker written on 2026-07-26 declared that entries for 2026-07-16 through 07-25 "were never written to this file." They had been. All **22** were sitting at the BOTTOM of session_log.md, below the 2026-05-07 to 06-07 archive. The file carries **two ordering conventions** — the top block is newest-first (prepended), the tail is an older oldest-first block (appended) — and some sessions used the older one, which dropped their entries 7,000 lines down where nobody looked. Three June entries (06-25 evening close, two 06-26) were stranded the same way.
- **Why the check failed, twice.** The gap was diagnosed by reading the top of the file and seeing 07-26 followed by 07-09. That is a check of one region, not of the file. The stranded 07-16 and 07-17 entries also used **h3** headings while every other entry uses h2, so a heading-level scan skipped them. And once written, the marker became the evidence: this session inherited the claim and acted on it rather than testing it.
- **A backfill was written and reverted.** Five synthesis-weight entries (07-16, 07-17, 07-22, 07-24, 07-25 day) were reconstructed from proj_briefing_book.md, proj_checklists.md and proj_AI_Microscope.md and written in. The misfiled originals surfaced immediately afterwards during heading-order verification. session_log.md was restored **byte-for-byte** to its prior state (9275 lines, 536499 bytes) before any repair was attempted. **The reconstruction had already introduced one factual error**: the ʻIliau Loop briefing book recorded as bound at **12 pp**, because that is the figure proj_briefing_book.md preserves. The contemporaneous entry says **14 pp** after Kim's review pass. A reconstruction inherits whichever version of a fact the source file happens to keep, and it cannot know what it lost.
- **The repair (Kim chose the wider scope).** All 22 July entries plus the three June strays were moved into reverse-chronological position in the top block. **Content is verbatim, verified line-for-line against the pre-repair file**; the only changes were promoting the h3 headings in the 07-16/07-17 runs to h2, and normalizing blank-line and rule separators. The false marker was replaced with an **ORDERING NOTE** recording what happened and carrying the standing check. Result: **9269 lines / 536821 bytes**, top block **91 entries** strictly newest-first from 2026-07-26 back to 2026-06-07, no date out of order. The pre-06-07 archive stays in append order deliberately; new entries go at the top. One pre-existing anomaly left alone as plausibly intentional: a 2026-05-14 (continued) entry filed after 2026-05-16.
- **FINDING 019 written** — an absence at the top of a log is not an absence, and **never write a gap marker without proving the gap**. A marker asserting absence is load-bearing: the next session reads the note instead of the file and builds on it. The rule is to grep the WHOLE file for the date at every heading level, not to read a region, and if a gap is only suspected, to say so and name the search actually run. This is **Finding 018 from the other side** — a write-up is not a record, and a note *about* the record is not the record either. The record is usually still there.
- **The rule went into the protocol, not just the findings file.** A finding is a lesson; a protocol is an instruction. `pkm_protocol.md` **Mechanism 4** gained a subsection, *Where entries go* (added 2026-07-28), stating four things: new entries go at the TOP of session_log.md as an h2 heading, newest first, never appended; the file legitimately holds two blocks, the pre-2026-06-07 archive deliberately left in append order; **grep the WHOLE file at every heading level before declaring any entry missing**; and **never write a gap marker without proving the gap**, naming the search actually run if a gap is only suspected. A fifth paragraph says reconstruction from the proj files is a last resort and must be labelled as one. The protocol's own `## Log` carries a 2026-07-28 entry saying why. This is the amendment that would have prevented the whole episode, since the failure was an instruction gap, not a knowledge gap.
- **Session close: Mechanism 5 checklist run; AI_Microscope closed under the per-project protocol.** Kim closed the AI Microscope documentation work — the document *Preview & Review* has been live since 2026-07-25 and nothing in the app or the book changed today. The closing review found one real inconsistency: **`proj_AI_Microscope.md` carried `Focus readiness: Blocked` in its header while its Blockers section read "None."** The blocker is the plant-anatomist read, with the app deliberately frozen until it lands, and it is now named there. Status stays **Active** (not Complete — the review is likely to generate work) and readiness stays **Blocked**. Its Next Steps needed no edit. Also refreshed: `proj_PKM.md` last-updated 2026-07-17 → 2026-07-28, and the project_index PKM table row, which was still dated **2026-05-07** and reading "Opus 4.7 transition complete" — it now carries the Mechanism 1 and Mechanism 4 amendments. No new projects were opened, so intake did not fire; no new files entered any project folder.
**Active Focus deliberately unchanged at Kim's instruction: none open, and the choice is still his.** The three candidates carried from 2026-07-26 stand: **briefing_book** (Kim has now met Dr. McClatchey), the **checklistr driver** that would take a centre, a radius and a preview file and emit the report set, and the **AI_Microscope shelf** (audio round two with the pronunciation dictionary — run-to-run pronunciation variability is a KEPT FEATURE, do not seed it away — the parked image downsize, publishing `_onepage.html`), with the app still frozen pending the plant-anatomist review. Kim closed the session here to start a fresh dialog.

## 2026-07-26 — kimbridges_collections: **Behind the Curtain** BUILT and PUBLISHED, the site-wide methods page; the briefing-book commission block written; FINDING 018
Session-start protocol run (Fable 5; R bridge live). PKM drift repaired first, then a single focus opened and closed the same day. The site now carries **four pages**: the three collections plus a methods page at https://kimbridges-collections.netlify.app/behind_the_curtain.html. It is a methods page, not a collection, so it goes in the navbar and stays **out** of the index listing. Kim deployed it himself and reported it live.
- **Read all three collection .qmd files before writing a word.** That is why the page links to `briefing_books.qmd` for the ring-with-a-hollow-centre story instead of retelling it. Six sections: *Three divisions of labour* (Gallery, Jones, Briefing Books as a sequence, each handing more of the middle to the engine); *The input contract*; *The chain* (new SVG from `Behind_the_Curtain/chain_fig.R`, four stages, person solid orange top and bottom, engine dotted blue between); *What it is made of*; *The constraints that shaped the form* (one language, print not scroll, no retroactive improvement, the working data ships with the conclusions); *What stays human* (Diamond 1989 and the 80% tool). Final file: 165 lines, 15700 bytes, LF, 6 h2 + 1 h3, 9 fenced divs balanced.
- **The toolchain, traced from the packages on disk rather than from memory — and Kim was wrong about it.** He assumed vouchr was the main briefing-book package. **`checklistr` is the engine** (26 exports; DESCRIPTION names Kim Bridges and "Claude (Anthropic; collaborative development)" as joint authors). **vouchr** supplies only `site_extract` and the terrain/substrate helpers for R7. **whittakerr** + WorldClim place the biome, **elevatr** gives per-record elevation (the rim vs canyon-floor split came from that), Esri topo tiles do every basemap because OSM returns blank at these sites, **qpdf** binds. Told him plainly rather than letting the mistake stand.
- **New artifact: `Projects/checklists/briefing_book_commission.md`** (3922 bytes). Kim asked bluntly whether there was a paragraph he could hand to Claude to get a new briefing book. There is **no stored driver script**, so the block is the answer: packages and functions, the report set (R1, R2, R3+R4, R5, R7, R10, field card), qpdf binding, the full codified type standard, the Okabe-Ito rules, the three honesty rules (staleness is not rarity; coordinate precision is not locatability, three tiers; the record is not the flora), the naming rule, ending `[paste site_preview.md here]`. Kim then asked for it **on the page**, and it is there as *The standing instruction*. Two PKM-only sections were held back from publication ("What this block does not do", "Preview capture") and the cut was flagged to him so he could reverse it.
- **FINDING 018 — the original ʻIliau comment was never captured in Kim’s own words.** He asked whether it had been preserved. Every `.md` in Projects_Index and the whole `checklists` tree was searched. It has not. `site_preview.md` is a session write-up (its own header: "Captured 2026-07-17 from Kim’s preview observations"), and proj_briefing_book.md line 334 paraphrases the same material a second time. The session log has a gap across exactly that date range. So the input-contract section on the page shows a faithful reconstruction, not the original utterance. **Standing rule: for any new site, write the preview first, in Kim’s own words, and save it before the build starts.**
- **Kim’s three corrections, plus one I caught on myself.** The garbled "A claim that small an input produces" became "a small input". Once the commission block was published, the claim that the engine got "a coordinate and the file below. Nothing else." stopped being true, so it was rewritten to name both inputs. Two publish decisions put to him and answered: **add the standing-instruction section with no reproducibility-gap admission**, and **leave the verbatim panel verbatim** — which means his own "Kīpuka" shorthand stays as he wrote it, even though the naming rule forbids it in new prose.
- **Verified structurally, not visually.** The Chrome bridge rejects `file://` URLs, so the render was checked by counting divs, code fences, h2/h3 (confirming the four `## ` lines inside the fenced block did not leak into document structure), `.input-doc` panels and `<pre>` tags, and by grepping the stale phrase to confirm it was gone. Deployed from a **dated** staging folder, `C:\temp\_site_20260726`, 98 files / 112.1 MB, every byte size checked against `_site` first. Dated deliberately: the R bridge blocks recursive deletes, so reusing `C:\temp\_site` would have carried stale files along (Finding 008 gotcha 2).
- Housekeeping closed: `_backup_concept_80pct_tool_20260726.md` deleted, and `_stamp_test.pdf` deleted once its overnight lock released. `custom.css` 93 → 115 lines (the `.input-doc` rule); `_quarto.yml` gained the resources glob and the navbar entry, with the anchor **re-grepped between the two appends** because the first insertion shifted the index.
**NEXT FOCUS UNDECIDED.** Three candidates: **briefing_book** (Kim went straight from this session to Dr. McClatchey, whose critique the project is on hold for); the **checklistr driver** that would take a centre, a radius and a preview file and emit the report set, the natural sequel to the commission block; and the **AI_Microscope shelf** (audio round two with the pronunciation dictionary — run-to-run pronunciation variability is a KEPT FEATURE, do not seed it away; the parked image downsize; publishing `_onepage.html`), with the app still frozen pending the plant-anatomist review. Still owed from earlier: whether to backfill the log gap 2026-07-16 through 2026-07-25.

## 2026-07-25 (evening) — briefing_book: **The Briefing Books** PUBLISHED as the third collection; the R1 correction; Diamond CONFIRMED
Session-start protocol run (Fable 5; R bridge live). Kim lifted the hold: the two books had been waiting on Dr. McClatchey's Sunday critique, and his call was that getting working prototypes out for review beats polish, since the website is itself the way to reach other reviewers. Shipped the same day.
- **Collection, not Document** — settled early and it shaped everything. A collection needs no uniform pattern, but Claude pushed back that these books *do* share a format and Kim agreed, so the introduction had the harder job of introducing a **series** into which new sites drop without a rewrite.
- **The introduction's spine is ORCHESTRATION** (Kim's addition, and the thread he did not want missed). The other projects were stepwise. The briefing books hand the whole dependent chain to the engine: from a coordinate plus a paragraph of often-personal site knowledge, it runs to an assembled document. Kim: *"Orchestrating a whole series of steps, as is done in the briefing books, is a new and different skill demonstration."*
- **The 80% tool** got its own concept file entry and its citation. A tool does a bounded task; giving it to the engine returns the expected result PLUS "more", and what the "more" is depends on the data — duplication noticed, a missing date range flagged — none of it built into the tool. The shape is expected results + interpretation + open follow-up: *"every good study should end with a suggestion for the next study,"* but as a dialog, actionable at once, with the expert's knowledge arriving at exactly the right time. Kim tied it to **Diamond's "The Ethnobiologist's Dilemma"** — you need knowledge to hold the tool. Kim supplied the scan; the citation is now **CONFIRMED**: Jared Diamond, *Natural History* 6/89 (June 1989), pp. 26, 28, 30. The sharpening: Diamond's informant **THROTTLES** on perceived competence, and **the engine has no throttle**.
- **A sixth friction category named: follow-up (iteration) friction** — the gap between noticing something and being able to chase it. Historically the flag arrived in one place and the means in another, and most flags died in that gap.
- **THE R1 CORRECTION, and the lesson worth keeping.** Page 2 read "the nine nominal points hold 52% of all records", derived from the mis-centred `r1_points.rds` (stored `dist_m` off by up to 851.2 m; three of nine coarse points 2224–2321 m from the true centre). The corrected coordinate table was never saved, so no corrected count could be honestly asserted. The fix exploits an identity — the nominal points ARE the coarse-coordinate points — so page 1's already-verified **39%** describes the same quantity: "the nominal points hold 39% of all records". Both pages now state one number and nothing unverifiable was introduced. **The first repair failed in an instructive way:** a `qpdf::pdf_overlay_stamp` patch rendered perfectly, but `pdftools::pdf_text` still returned 52% underneath, so copy/paste, search, screen readers and any AI ingesting the PDF would have kept the wrong number — on a site whose subject is AI reading documents. Discarded for a **pikepdf content-stream edit** replacing the `Tj` string in place: original font, original metrics, no white box, page 1 pixel-identical. **A visual fix that leaves the old text underneath is not a fix.** (Also learned: `pdf_overlay_stamp` repeats stamp page 1 across all input pages, so per-page stamping needs subset → overlay → combine.)
- **PUBLISHED** — the book rebuilt (22 pp), 23 assets registered under `resources:` in `_quarto.yml`, full site render **55 s** through the R bridge (Finding 017 holds). Anticipating **Finding 008 gotcha 2** (Netlify drag-deploy silently skips unmaterialized Drive-stream files), `_site` was copied to `C:\temp\_site` and verified byte-for-byte — 96 files, 112 MB, 0 zero-byte, 0 mismatches — before Kim dragged it. **LIVE: https://kimbridges-collections.netlify.app/briefing_books.html**. Kim: *"I got the briefing books materials (actually, the whole _site) loaded into netlify and it looks good!!!"* Post-deploy verification done by Claude so it cost Kim nothing at 10 PM: the 22 MB book proven present by a 413 oversize response (a Drive-placeholder skip returns a ~3 KB HTML fallback instead), R5's sheet numbers returned from the 19.3 MB file, the live R1 reads 39%, the CSV serves correctly.
- **Known, not blocking:** R1's page-2 scope table says **224 records** and that figure cannot be reproduced from any surviving file (`r1_points.rds` 193, `r34_targets.rds` 207, specimens CSV 107). Nothing in the report states the map's record total, so it is invisible to a reader; the 100-taxa figure is corroborated three ways. Resolve when R1 is rebuilt from a saved coordinate table.
- **QUEUED:** a site-wide **Behind the Curtain** page for kimbridges-collections (Kim asked for it late in the session; his own proj file has wanted it since May). Approved: **input contract** (the ʻIliau `site_preview.md` verbatim beside the 14-page book it produced), **chain figure** (Okabe-Ito, SVG), **constraints**. Explicitly excluded: the reproducibility-gap admission. Also open: whether to delete `_backup_concept_80pct_tool_20260726.md`, and `_stamp_test.pdf` is locked by something on Kim's machine.

## 2026-07-25 (cont.) - AI Microscope: three data figures, the centering fix, and the document PUBLISHED
The session that finished the book. Continued directly from the assembly work logged above.

**Three data figures**, built in R on Kim's machine from `documentation/aim_figs.R` (kept as a
deliverable so each figure is rebuildable from its data): the cost of storing one slide from 1989 to
2026 on a log scale (Ch.2), the distinct colours found inside each tissue's region of the old blended
map (Ch.5), and tissue abundance as a share of the leaf footprint (Ch.5). Okabe-Ito throughout,
nothing carried by colour alone, SVG, one per page width. Kim's standing approval: "You should know
that I'm a 'data geek.' So the proposed charts work well for me." The proposed fourth figure, a
pronunciation before/after, stays cancelled.

**Two annotation collisions were caught by generating PNG proofs and looking at them** - a callout
lying across the cost curve, and another landing on a neighbouring row and its value label. Neither
produced an error or a bad exit code. Finding 016's rule held: the exit code is not the artifact.
Figure 2's repair improved on the original, replacing a floating callout with a renamed and
individually coloured axis label, which satisfies never-colour-alone more honestly than the callout
did.

**Kim's one criticism, and the rule it produced.** He read the rendered book and said the new charts
"are pushed to the left and they look unusual that way. Is centering possible?" It was, and the
cause was mechanical rather than aesthetic: `.column-page` widens the container to the full viewport
but leaves a natural-width SVG flush left inside it, and `fig-align="center"` cannot correct that.
`.column-body-outset` **plus `width=100%`** does. Verified by measuring figure and paragraph geometry
in the rendered DOM at three viewport widths rather than by eye: symmetric overhang every time, and
the figures render larger than their natural size, so they also got easier to read. Written into
style_multichapter_doc.md Section 6.

**One prose change**, at Kim's request: Chapter 5 now says five tissues "pointed at colors that were
likely not in the image" rather than "simply were not." A small edit that closes the chapter's last
open honesty question, in a chapter about not overclaiming.

**A one-page edition** was built as well (`_onepage.qmd`), all eleven chapters as a single continuous
scroll; the underscore prefix keeps the book project from sweeping it in. Not deployed.

**PUBLISHED.** `_output/` copied from R into `kimbridges-documents/ai_microscope/`, listing stub
written, `ai_microscope/**` added to the site resources, site rendered with every image reference in
every page verified present on disk, and Kim drag-deployed to the **existing** Netlify tile. Live at
https://kimbridges-documents.netlify.app/ai_microscope/ - the nineteenth document on the site. Kim:
"Perfect! It worked nicely. The charts center well. The document is on-line!!!!"

**Finding 017** recorded: `quarto::quarto_render()` works through the R bridge despite the
shell-execution block of Finding 014, so renders no longer have to be handed back to Kim; do not set
a QUARTO_PATH variable, which breaks it; and a full site render overruns the MCP timeout and makes
the bridge look dead for minutes while completing normally.

PKM updated: proj_AI_Microscope.md (Focus readiness Ready -> **Blocked**), proj_kimbridges_documents.md,
style_multichapter_doc.md, pkm_findings.md, project_index.md, this log.
**NEXT:** nothing is required. The open dependency is the external plant-anatomist review, with the
app deliberately frozen until it lands. Optional and unblocked whenever Kim wants them: audio round 2,
the image downsize, publishing the one-page edition.

## 2026-07-25 — AI Microscope: Appendix written, cover + logo, Quarto book scaffold renders, seven figures placed
The second long documentation day, and the one that turned nine drafted chapters into an assembled book. Session-start
protocol run; Active Focus confirmed as AI_Microscope.

**The Appendix** ("How it's built") — the last unwritten piece — was drafted and approved. Its spine is that almost
nothing a student sees is code, it is data, and that this is what made the Chapter 5 color audit cheap enough to
actually do. It walks the three data files (`slides.json`, with the launch intro stored as DATA so the first thing a
student hears is editable without touching the program; the per-slide manifest, with `"match": "exact"` and no
nearest-neighbour guessing, and `pct_basis` written into the file rather than into a notebook that gets lost; and
`botanical_lore.json`, eight fields per tissue with `say` deliberately separate from `proper_name` so a pronunciation
can be fixed without corrupting a name), then keys-stay-on-the-server, the validator, and adding a slide. It closes on
the test Kim would apply to any tool built this way: can the person who knows the subject add to it without touching
the code?

**Cover and logo (Kim's work).** A phone held in a dorm room showing the leaf section, title set into the art in white
with a black drop shadow, plus a 250×250 logo. Claude critiqued the first version. Kim accepted the naming-convention
and file-size points and overruled three others, each with a reason (the tissue is leaf, not root, because it comes
straight off the slide; an earbud would crowd the one thing that has to stay visible; 250×250 is proven in his other
documents). He then caught his own error without help — the cover read "AI Microscope" rather than the document title —
reshot it, and shortened the subtitle to *Rebuilding the AI Microscope*.

**The Quarto book scaffold** was written and made to render clean end-to-end before any further content work, following
the checklistr pattern of proving the pipeline first. **Seven screenshot figures** then went in with numbered captions:
the interface (Ch.3), a wrong answer handled (Ch.4), the rebuilt tissue map and the 65% overlay (Ch.5), the term card
on xylem (Ch.6), the review stage (Ch.7), and the splash (Appendix). All were captured with Playwright against the app
served locally in the sandbox. Kim's verdict: "the figures are well placed and the captions do the work. **No text
references are needed**" — so the prose deliberately carries no `@fig-` cross-references. A `callout-note` at the top
of the Preface now links the live simulator, at Kim's request, and coexists with the floated cover image.

**The lesson of the day.** A figure anchored mid-paragraph made Quarto treat the image as inline: no number, no
caption, and the paragraph split around it. `quarto render` reported success. Only a screenshot of the rendered page
revealed it. The fix was to move the anchor and then add a programmatic check that every figure line has a blank line
before and after. This is the general shape of it — the exit code is not the artifact, and looking at the output is
cheap once the loop exists.

Three infrastructure findings recorded: **014** (`system()` is blocked in the RStudio MCP — use `Sys.which`,
`file.exists`, `file.copy`, `file.remove` instead), **015** (the Downloads trap recurred, with Kim's browser-based edit
to `_quarto.yml` landing in `C:/Users/kim/Downloads` rather than on Drive; and separately, device-staged copies are
read-only and re-staging does NOT overwrite them, so `rm -f` the staged file first), and **016** (Quarto plus Playwright
in the cloud sandbox as a render → serve → screenshot verification loop).

Kim: "a very productive day." PKM updated: proj_AI_Microscope.md, project_index.md, pkm_findings.md, this log.
**NEXT:** the data figures (color_audit, tissue/abundance maps, a pronunciation before/after), an optional image
downsize, then the deploy to kimbridges-documents. The app stays frozen pending the plant-anatomist review.

## 2026-07-24 — AI Microscope: DOCUMENTATION drafted end-to-end ("Preview & Review", Preface + 9 chapters)
A single long, productive documentation session — the writing the project was created for. Drafted the whole
document, **"Preview & Review"** (subtitle *Rebuilding a 1989 learning environment with the tools it was waiting
for*), in the checklistr multichapter-Quarto house style: first-person Kim voice, joint byline (K. W. Bridges and
Claude), destined for kimbridges-documents. Grounded first in style_multichapter_doc.md + kim_association_index.md,
then drafted chapter-by-chapter with Kim reading and approving each in turn. All saved to
`Projects\AI_Microscope\documentation\` and delivered.

Preface + 9 chapters: **index.qmd** (Preface — the 37-year reach-back + a collaboration paragraph telling the
Gemini→Claude arc as *evolution*, Claude acknowledged as collaborator not just author, at Kim's request),
**too_early.qmd** (Ch.1 the 1989 design + a-tool-not-a-spy + the paper's three reaches), **constraints.qmd** (Ch.2
the four walls — storage, the HP 9000/PC split, the serial cable, canned words; Kim will add that the HP 9000 was
very expensive, on loan from HP Labs), **rebuilding.qmd** (Ch.3 the 2026 pivot; process-not-product thesis; the
stack), **tool_not_spy.qmd** (Ch.4 the philosophy that got *harder*; Will McClatchey's review as the test; game +
grading declined; abundance-% passed the filter), **honest.qmd** (Ch.5 the color-map story — 359,791 colors,
phantom blue, the categorical rebuild, *unclassified*/*outside*, the honest self-correction, "an afternoon" =
thesis in miniature), **names.qmd** (Ch.6 pronunciation as friction; Cecil Johnson; the term explorer; roots as a
master key; the kept variability defended as a feature — the longest chapter, Kim approved the length),
**bookends.qmd** (Ch.7 preview/lab/review; the quiz-at-the-door dread dissolved; the teacher's win — the win-win),
**audio.qmd** (Ch.8 Kim's decades-long TTS history as the spine; two old failures both fallen; live-not-stored; the
frontier), **taught.qmd** (Ch.9 the closer — the transferable method, neglected-nuggets, the boat/"knowing what not
to teach", closing the circle to the 1989 screen).

Two notable additions surfaced mid-session and were folded in: (1) **the touch-in / audio-out ASYMMETRY as a
privacy design rationale** — earbud audio output is private and safe to be unsure in; voice input makes the exchange
public unless the student is isolated, re-introducing the very friction the tool removes. Added to Ch.8's frontier
as an honest open problem; Kim: "a big reinforcement of the basic thesis." (2) **"The art of teaching is knowing
what not to teach"** — a career principle given to Kim by two of his students, **Mick Crawley and Mark Westoby**
(both now eminent ecologists, England and Australia); the boat/subtraction metaphor. Logged to
kim_association_index.md as **Theme 13**; carried into Ch.9.

Kim's verdict: structure, balance, and tone all correct across every chapter; "an absolutely amazing day." He'll do
a careful read and light voice edits. **NEXT (tomorrow):** the Appendix ("How it's built"); figures (color_audit,
tissue/abundance maps, overlay, term explorer, a pronunciation before/after); a cover photo + logo (Kim to make);
then the Quarto book scaffold (`_quarto.yml`, render offline end-to-end) and deploy to kimbridges-documents. All
drafts committed to Drive via the device bridge.

## 2026-07-22 (later session, cont. 4) — AI Microscope: term explorer confirmed; top-to-bottom audit + fixes; audio intro; BOOKENDS framing
Kim confirmed the term explorer ("an excellent addition"; liked the etymology balance). Noted slight pronounce-to-
pronounce variability (ElevenLabs prosodic nondeterminism with bare input) — a seed + higher-stability fix parked for
audio round 2. Ran the **top-to-bottom code audit** (report saved: AI_Microscope_audit.md). Kim DECLINED the headline
item (dropping the live Gemini polish — accepts the double AI call) and took the rest in order; all deployed: single-
clip **audio management** (newest-wins, no overlap; helps mobile), a **slide-picker + slides.json** index with the load
path refactored into loadSlide() (scaffolds the multi-image future — a real anatomist review may bring root/stem slides,
and the picker matters for the documentation), **calibrated + aspect-safe magnification** de-duplicated into one
cropGeometry helper, honest relabel ("High-contrast view"), and a11y touches (ARIA live region, canvas label, no
innerHTML). Then the **launch audio intro** — Kim's welcome script (greets first-timers and returners in one), stored in
slides.json as DATA (editable without code) — and relabeled the depth toggle to **"Before the lab — preview" / "After
the lab — review."**

**Additional perspective (Kim, important): the BOOKENDS pedagogy.** The simulator sits on either side of the real lab —
a friction-free PREVIEW before (warm up on the view, magnification, names, Latin/Greek vocabulary; lowers cognitive load
for the hands-on lab) and a consolidating REVIEW after (revisit; concepts settle — where much real learning lands). Two
jobs: remove friction, induce review. The tool's *why*, and a strong spine for the document. **The app is now
feature-complete as a tool.** NEXT: Kim to choose — audio round 2, or open the DOCUMENT. All pushes clean via gert;
PKM updated (proj_AI_Microscope.md, project_index.md, this log; audit report in the project folder).

## 2026-07-22 (later session, cont. 3) — AI Microscope: audio direction opened; pronunciation test; term explorer built
Closed a long, productive day. Reframed **audio as the showcase technology** for the AI Microscope (reviving the 1989
"names pronounced, meanings shown"), and **pronunciation as FRICTION** — a theme that scales to the ~100 scientific
names at Kīpuka and to a planned chapter (anchor story: Cecil Johnson's "this is my good friend, *Hibiscadelphus
giffardianus*"). Ran a standalone **ElevenLabs pronunciation test harness** (R/curl from RStudio; proj_audio.md): found
**IPA phoneme tags honoured on turbo v2, not flash v2.5**; adopted a sparse IPA-override approach (Syringa stays raw —
"only fix what's broken"). Then **built + deployed a term explorer** in the app: a per-tissue card with a Say-it button
(turbo v2 + optional IPA override), a plain-English gloss, and etymology/roots; extended botanical_lore.json and
parameterised the speak function for model choice. Glosses/etymologies are first-pass for Kim to refine. Kim will work
through the new version and comment tomorrow. **NEXT TASK (if the feature reviews OK): the deferred top-to-bottom
audit** of the app (efficiency/API-dependence, live-LLM, multi-image extensibility, maintainability), plus the small
audio intro, then the document. PKM updated: proj_AI_Microscope.md, proj_audio.md, project_index.md, this log.
briefing_book still ON HOLD (no McClatchey review yet).


---

Older entries (133) were moved to `logs/session_log_archive.md` on 2026-07-30 by pkm_health.R.
They are verbatim. Search there before concluding an entry is missing.
