# deferred.md -- closed blocks
_Moved out of `deferred.md` on 2026-10-28, verbatim and unedited, to bring it under its 200 KB budget. Each block is marked with its original line range. Only blocks with no open TASK or CONDITIONAL were moved; a one-line pointer stays in `deferred.md` for each._

---

<!-- from deferred.md lines 209-222 -->
### ✓✓✓ DONE 2026-09-04 — THE PHOTOGRAPHS ARE PLACED. 31 added, 37 in the book

**Kim's rulings (2026-09-04): ~30 photographs, name the location whenever EXIF supplies one, and the four cars go in the Foreword as ONE four-up figure.** All three applied. **The book now renders 48 `<img>` elements: 37 photographs and 11 generated figures.**

**Where they went:** Foreword 4 (the four-car figure) · `small_cars` 5 · `is_it_safe` 2 · `the_anchor` 4 · `expeditions` 5 (a four-up of the extremes corners, plus White Sands) · `long_days` 2 · `the_roads` 2 · `the_marine_highway` 1 · `a_day_in_a_smart` 2 (the bird days) · `two_constellations` 2 (the BC fills) · `what_the_car_cost` 1 · `afterword` 1.

★★★★ **THE EXTREMES TABLE IS NOW PHOTOGRAPHED, and one of the four came out of a coordinate.** `twored_easternmost.jpg` had NO caption. Its GPS reads 44.815 N, 66.951 W; opened, it is West Quoddy Head light with Kim and Nancy holding a sign reading THE EASTERNMOST POINT IN THE USA. **That is the ch.4 table's `Easternmost, US` row, photographed.** ⚠ **Four of the seven corners have a picture. San Antonio, Anchor Point and Mount Evans do not**, and the Mount Evans photographs are the ones Kim took and cannot find.

★★ **Badwater came out of a coordinate too.** `Creamsicle/PXL_20230316_185639739.jpg`, captioned only *"Creamsicle in Death Valley"*, reads 36.230 N, 116.767 W. **That is the `Lowest` row.**

⚠ **`IMG_4169_D.jpg` was NOT placed.** It is a second, wider frame of the same Florida corner already in ch.14, taken in the same minute from the same spot. **Two frames of one scene is not two pieces of evidence.** ⛔ Do not add it later thinking it is new.

⚠ **Discard the GPS on `twored_florida_signs.jpg`** — it is 0,0. ⚠ `TwoFer/2014_TwoFer_newly_in_garage.jpg` still carries the corrupt `base64:EvgPOwE=` caption. **Ten files have no caption at all and thirteen carry the 2026:08 scan stamp; date those from the filename year, never from EXIF.**


<!-- from deferred.md lines 251-269 -->
### ⛔ RETRACTED 2026-09-03 — the ghost `_output` did NOT clear. The entry below is WRONG.

⛔⛔ **RETRACTED the same day, 2026-09-03 (evening). EVERY CLAIM BELOW IS WRONG.** The ghost did not clear, `dir.create()` succeeding was not evidence that it had, and no full render ever ran from `G:`. Three renders that evening died on `PermissionDenied: stat '_output'`, and two attempted workarounds -- repointing `output-dir`, and a `.quartoignore` -- both failed because Quarto's project scan walks the folder regardless. **See the 2026-09-03 AMENDMENT to Finding 054 for the probe set that does not lie (`file.access()`, and `file.info()` on the contents).**

⛔ **`book/_preview` was NOT redundant and must NOT be deleted** -- it is the reading copy Kim uses, and with `_output` unusable on `G:` it is the only rendered copy there. The build tree is `C:\temp\Smart_Car_book_2026-09-03` (bucket 4, delete once the Netlify deploy is verified live).

★ **The lesson is the one this file exists to prevent:** an absence -- or in this case a presence -- written into the PKM becomes load-bearing, and the next session reads the note instead of re-checking. It cost three failed renders before I probed rather than trusted.


`book/_output` is in `list.files()`, `file.exists()` is FALSE, `dir.create()` refuses. **See Finding 054.** ⛔ **Cannot be repaired from R** -- there is nothing for `unlink` to act on and the bridge cannot recursively delete. **Kim needs to remove it in Explorer, or restart Drive.**

**`dir.create("_output")` now succeeds and a full project render writes all 16 pages.** The name had vanished from `list.files()` as well, so Drive reconciled the entry on its own without Kim doing anything in Explorer.

★★ **Worth keeping for Finding 054: a ghost directory entry can clear on its own with time.** ⛔ That does NOT make it a transient lock -- it refused `dir.create()` for a full working session, which is the test that separates it from Finding 048. **The right response is still to build in `C:\temp` and carry on, not to wait.**

⚠ `book/_preview/` and `C:/temp/Smart_Car_book_2026-09-02/` are now redundant scratch copies. **Delete `_preview` once Kim confirms he is reading from `_output` again.**

**Until then:** build in `C:/temp/Smart_Car_book_2026-09-02` and copy the rendered HTML to `book/_preview/`. ⚠ **`_preview/` is a scratch copy, not a source** -- delete it once the real `_output` works, and never edit a `.qmd` there.


<!-- from deferred.md lines 270-284 -->
### ✓✓✓ DONE 2026-09-04 — the dead SCAFFOLD block is OUT of `the_anchor.qmd`

**Lines 227-263 of ch.3 were an HTML comment headed `SCAFFOLD -- still to write`, sitting inside a chapter finished on 2026-08-28/29.** Every item in it had already landed in the prose. **Deleted 2026-09-04 at Kim's direction** (*"Move to deferred.md, as you prefer"*). ★ **No scaffold now remains in any of the 16 pieces.**

**Six things in that block were NOT scaffold. They are carried here so they survive the deletion:**

- ⛔ **STANDING — the Eugene colleague is NOT NAMED.** "a close colleague" (Kim, 2026-08-20). See the PRIVACY RULING entry further down this section.
- ⛔ **STANDING RULE (Kim, 2026-08-22): institutions are nameable, individuals are not.**
- ★★★ **THE THESIS (Kim, 2026-08-22):** *"Having a car at the right location was the point of having the car. It wasn't that we wanted to drive. The drives were an additional feature."* **This is ch.3's spine and it is quoted nowhere else in the PKM.**
- ⚠ **STILL UNCONFIRMED:** whether the niece at Mentone should be named or given a town, and whether the St Louis car-wash business is named. **The chapter as written names neither the person nor the business**, which is what the standing rule requires. Ask only if Kim raises it.
- ⚠ **ADJACENT FACTS, SEPARATE CAUSES:** his mother died January 2017 with the car already in Oregon. ⛔ **Do not let the bereavement do work the parking policy did.** The chapter keeps them apart and must continue to.
- ★ **ON STATION vs STANDING BY:** the pace separates Wisconsin (18.3 mi/day) from everything else, but NOT TwoRed-on-station (2.6) from Creamsicle-standing-by (3.2). **The record sees when the job changed, never why**, and ch.3 says so in those words.

★ **Also settled by this block's own contents:** 8 of 13 logged trips begin AND end at Lake San Marcos, and every complete one from 2011 through the Fourth Crossing does, the Arctic run included. **That is in the prose of ch.3 and ch.4 already.**


<!-- from deferred.md lines 407-429 -->
### ✓✓✓✓ DONE 2026-09-01 — the fuel-stop point map is BUILT for both cars, and placed in ch.13

**Superseded by the geocoding solution** (Google Maps key, both cars at 100%, 467/467 fills) and by Kim's ruling that the maps belong in ch.13, not ch.5. ⚠ The coverage table below is the BEFORE state, kept as the record of why the task existed.

Kim attached his own Google-style point map of fuel stops (**he flags it as likely incomplete**) and named exactly what it does that ch.13's figure does not: *"what my map shows is what that '300 mile' run looks like, especially across Canada."*

★★★ **A choropleth shows EXTENT. A point map shows CADENCE.** Across the Canadian plains his dots are strung out at roughly even intervals, and **that spacing is @sec-long-days's three-hundred-mile day made visible without a single number.** The book currently argues the 300-mile day from tables; this would let a reader see it.

⛔ **BLOCKED ON THE GAZETTEER, and this is the reason to unblock it.** Placement rates measured 2026-09-01:

| | placed | of |
|---|---|---|
| TwoRed, project gazetteer alone | 78.2% | 294 |
| TwoRed, + `maps::us.cities` + `canada.cities` | **84.7%** | 294 |
| Creamsicle, project gazetteer alone | 17.3% | 173 |
| Creamsicle, + the same | **39.9%** | 173 |

**121 distinct cities unplaced.** A point map drawn today would render real driving as sparse, which is the same error class the choropleth was chosen to avoid.

**The work:** extend `All_gas_stations_csv.csv` to cover Creamsicle's cities and TwoRed's remaining 45. ⚠ Offline sources only (`maps::world.cities` has 43,645 entries but no state field, so it needs disambiguating against the known state). ⛔ **Do NOT call a network geocoder from a figure function** -- see the `ne_states()` entry.

★ **Candidate homes for the figure:** @sec-long-days as a second panel (cadence is that chapter's subject), or ch.13 alongside the choropleth. **Kim's own map complements rather than replaces the choropleth; the book can carry both ideas.**


<!-- from deferred.md lines 513-534 -->
### ✓✓✓ RULED 2026-09-01 — Kim endorsed the pair-lesson, and then broke my category scheme himself

**RULING (verbatim): _"You are completely right about not making the categories ahead of time. I appreciate your insight into this. And I like your explanation. This section belongs where you put it. The integration with the earlier text is apparent."_**

**So: the pair-framing is HIS, the sections stay in ch.12, and question 2 (move to the Afterword) is closed.** ★★★ **And he answered question 3 by volunteering all three identities -- which proved `DAY_CATS` has an error in it.** *Madness* is **Madness Autoworks, his mechanics of fourteen years**, not a person. See `logs/proj_Smart_Car_log.md` (top entry).

⚠ **STILL OPEN, and it is now the only open part:** `@tbl-day` still counts that row as *somebody to see* (5). The chapter names the error in prose instead of recoding. **Ruling wanted: leave it, or add a category for the car itself and reprint the table as 4 + 1?**

He gave ch.12 its ending: *"think through, ahead of time, what answers I'd like to get... Stopped time would have been a logical addition to the trip log. Reasons for stopping, listed as categories, would have emerged with a small amount of reflection."*

**The first proposal is unambiguously right and the chapter says so.** ⚠ **The second, taken literally, would have destroyed the chapter's own finding**, and rather than quietly dropping that half I wrote the tension into the chapter as section *And one box with no rules in it*.

**The argument:** `DAY_CATS` was **derived by reading the free text**. Nobody could have written the list in 2010. A dropdown holds *somebody to see*; it does not hold **Tom, Cindy, Meet Lan, Madness + Cindy** -- it gives you the number 5 and none of the names. **So the chapter passes on a PAIR:** design the structured columns you can foresee, **and keep one box with no rules in it, because that is where the next column comes from.**

**Kim should rule on three things:**

1. **Is the pair-framing his view, or mine put in his mouth?** The chapter is in first person. If he thinks a well-designed dropdown plus an "other" field would have done the job, the section is wrong and should be cut or rewritten.
2. **Does the lesson belong in ch.12 at all, or in the Afterword?** He said the methodology is *"a reason for writing down"* for other people's benefit, which reads afterword-ish. It currently ends ch.12 because that is where it is earned. **Moving it is a two-minute edit; both sections are self-contained.**
3. **"Madness + Cindy"** is printed as one of the names a category list would lose. **I do not know whether Madness is a person, a place or an event.** Harmless as a verbatim quotation, but he may want it out of that particular sentence.

⛔ **Do not treat this as settled while it sits here.** Nothing else in the chapter depends on it: the three-way test does not use the categories.


<!-- from deferred.md lines 618-642 -->
### ✓✓✓ CLOSED 2026-09-01 — the ten cross-references are now GENERATED, and the root was the Foreword

**Two errors stacked.** (a) The prose numbers chapters the PROJECT's way, Foreword unnumbered, so `small_cars` is "ch.1" -- but **Quarto counts `index.qmd` as chapter 1**, so it renders as 2. **Every hardcoded reference was already one low.** (b) Inserting `the_marine_highway.qmd` moved every target after position 7 by one more.

**The ten, with what each actually points at:**

| file | line | prints | means | renders as |
|---|---|---|---|---|
| small_cars.qmd | ~30 | chapter 2 | is_it_safe | **3** |
| the_anchor.qmd | ~222 | Chapter 2 | is_it_safe | **3** |
| expeditions.qmd | 59, 104, 196 | chapter 3 | the_anchor | **4** |
| expeditions.qmd | 134 | Chapter 9 | sixteen_years_of_paper (probable) | **10** |
| expeditions.qmd | 144 | Chapter 13 | what_the_record_cannot_say | **15** |
| is_it_safe.qmd | 73 | chapter 13 | what_the_record_cannot_say | **15** |
| knowing_a_number_is_wrong.qmd | 13 | chapter 10 | scaffold text | -- |
| what_the_car_cost.qmd | 13 | chapters 8 | scaffold text | -- |

⚠ **The two `expeditions.qmd` forward references (9 and 13) are INFERRED from content, not certain.** Confirm each against the chapter it means before renumbering; a wrong renumber is worse than the current state.

**★★ THE FIX IS NOT TO RENUMBER. It is to stop writing numbers.** Label every chapter heading `# Title {#sec-name}` and reference `@sec-name`; Quarto then generates "Chapter N" and it moves when the book does. **Same discipline the figures already have** -- every printed figure number comes from an R object and cannot go stale. **Finding 050.**

**Also settle, in writing: does the Foreword count as a chapter?** Quarto says yes, the project says no, and the whole class of error grows out of that never having been decided. **`number-sections` or an unnumbered preface will settle it; pick one.**

**Occasion: before any chapter is shown to a reader outside the project.** Not urgent for drafting.


<!-- from deferred.md lines 1757-1838 -->
## ISSUU -- CLOSED 2026-08-11. Retained as record; see the closure note below.

**CLOSED 2026-08-11 (Kim).** Every story once on ISSUU has been moved to the current
site. VERIFIED, not accepted: all four booklets are published stories with PDF, cover
and page in place -- `finding-fine-wine`, `bordeaux`, `bordeaux-2`, `japan-fall-2023`.
`Projects/AI_Podcasts/Travel.qmd` contains **ZERO** mentions of ISSUU, so the four
pointers AND the L11 prose claim are already gone. Nothing is at risk on that platform
and nothing points at it. The recovery, repointing and prose tasks are all closed.
The detail below is kept per the WON'T-DO rule -- reasons preserved, not deleted.

**Corrected 2026-08-02 (same day) after probing all five URLs.** The section below
originally recorded two guesses as fact. Both were wrong; Kim supplied the history and
the probes supplied the state.

**What Kim reported.** ISSUU abruptly and greatly raised its prices. He shut the site
down very quickly and deleted the account, moving to hflip. That is why ISSUU appears
in `design_publishing_workflow.md` as already-replaced.

**What the URLs actually return (probed 2026-08-02):**

| slug | in | state |
|---|---|---|
| `finding_fine_wine` | AI_Podcasts/Travel.qmd | **LIVE** — "Finding Fine Wine: A 2018 trip to the Napa Valley" |
| `bordeaux` | AI_Podcasts/Travel.qmd | **LIVE** — "Bordeaux: A Travel Photo Essay", Bridges & Furumoto, Oct 2019 |
| `chatgpt_examples` | LLM_Creates_R/Resources.qmd | **LIVE** — "Experiments with LLMs" v4, Jan 2024 |
| `bordeaux_2` | AI_Podcasts/Travel.qmd | **404** |
| `2023_japan_story` | AI_Podcasts/Travel.qmd | **404** |

**Two consequences, and they pull in opposite directions.**

1. Two links are ALREADY BROKEN and are being served to readers now. Not a future
   risk — a present defect.
2. Three documents are still public on a platform Kim believes he closed. **That is
   worse than the Exposure situation, not better.** Exposure has a known deletion
   event we can schedule around. These three can vanish whenever ISSUU reconciles a
   deleted account, with no notice and no one watching. Recover them FIRST.

**Correction to the record.** This section previously said `Desktop\Podcasts\
2023_Japan_Story.pdf` was "too small to be the illustrated booklet" at 0.47 MB. Wrong.
Kim: the 2023 Japan story is **text-only by design** — about 40 pages, no photos ever
added — and it is the exact file he fed to NotebookLM, which is why it sits in the
podcast folder. **It is the artifact, not a fragment of one.** The lesson is the
familiar one in a new costume: a file size is not a verdict on a file's contents.

**READY NOW — `2023_japan_story`.** Dead link, local PDF in hand. Copy
`2023_Japan_Story.pdf` into a venue `pdfs/` folder and point Travel.qmd at
`viewer.html?pdf=2023_Japan_Story.pdf`, the pattern already working in
kimbridges-collections. No blocker.

**NEXT — the three live ones.** Recover before repointing. The InDesign sources exist;
Kim notes the 2023 Japan one is filed with the **photo archive for that trip**, not with
the writing — so the others are likely filed the same way, by trip rather than by
project. Ask Kim per document rather than searching blind.

**CORRECTED 2026-08-11 -- `bordeaux_2` DOES have a source and is PUBLISHED.** The claim below was wrong. `kimbridges-stories/pdfs/Bordeaux_2.pdf` and `images/Bordeaux_2.jpg` are present and deployed to `_site`, and `stories/bordeaux-2.qmd` exists. An absence was asserted without being proved -- Finding 019 again. Superseded text kept: ~~
one real gap. It is the second Bordeaux podcast's companion document.~~

**Prose to fix in the same pass:** Travel.qmd L11 tells readers the booklets "are
available on an ISSUU website." False for two of them today and false for all of them
once migrated. Same category as the stale Quarto Pub claims below — a sentence has no
href, so no link audit will ever flag it.

**FUTURE PROJECT (Kim, 2026-08-02).** There are **a dozen or so trips** where the story
is written to roughly the length of the 2023 Japan story but the photos were never added.
Kim: "Attending to these will become part of our activities after the other things get
done." Not scheduled. Recorded so it is not rediscovered as a surprise.

**TASK — Two stale PROSE claims about Quarto Pub.** Not links; sentences.
`kimbridges-documents/plainmaps/index.html` L233: "Posting these materials on the Quarto
Pub website provides easy access to the code." `r_basics/index.html` L214: "Posting this
book on the Quarto Pub website means that I have easy access to the code." Both are now
false — the platform does not resolve. **A link audit cannot find these: a sentence has
no href.** Fix at source (`Projects/plainmaps`, `Projects/R_Basics`) and re-render.
Kim's wording, so Kim's call on the replacement text. *Raised by Claude, 2026-08-02;
found by the new `pkm_legacy_live()`, see Finding 024.*

**DONE 2026-08-02 — SoundCloud migration.** All eleven embeds replaced with HTML5
`<audio>` served from the venues: 1 in the Gallery Catalog (2026-08-01), 10 in
AI_Podcasts (2026-08-02). `.wav` masters copied to `Projects/Audio/podcast_masters`
(12 files, 361 MB, byte-verified). **SoundCloud now hosts none of Kim's audio.**
Desktop originals still in place pending Kim's go-ahead to delete.


<!-- from deferred.md lines 1839-1860 -->
## Experiments with LLMs — DONE 2026-08-03, published

Safe-held 2026-08-02, converted and published 2026-08-03 as the 22nd document at
`/llm_examples/`. See **proj_LLM_Examples.md**. The structural question was resolved by
evidence rather than by choosing among the three routes: the PDF's producer string
(`Skia/PDF m122 Google Docs Renderer`) led to the live Google Doc, so there was a source
to convert and the "rebuild means reconstructing from the PDF" objection evaporated.

**This closed the last non-historical legacy link in any venue.** `LLM_Creates_R`'s
`Resources.qmd` L84 now points at `/llm_examples/` instead of ISSUU.

**Still open, deliberately:** editorial reorganisation of the accreted content. Kim's
own framing — *"This 'document' kept getting small additions as I tried new things"* —
and only Kim can judge which early tests to group or retire. Also worth considering: a
2026 afterword, since the preface's "these now seem relatively unsophisticated" was
written in Jan 2024 about Jan 2023 work.

**Reusable lesson.** *Read the producer string before deciding a document has no source.*
Every PDF records the tool that made it. Two days of assumed reconstruction work
disappeared into a single metadata field that had been sitting in the file the whole
time. Added to the situation table in pkm_card.md.


<!-- from deferred.md lines 1880-1899 -->
## SoundCloud — CLEARED for account deletion 2026-08-02, with one check first

**All eleven embeds are migrated.** Nothing in any venue references SoundCloud; verified
by `pkm_legacy_live()` across every venue source and by reading the deployed HTML. The
local set is complete: 10 mp3 in `Projects/AI_Podcasts/audio`, 1 in
`kimbridges-collections/Gallery/audio`, and 12 `.wav`/`.m4a` masters in
`Projects/Audio/podcast_masters` (byte-verified).

**BEFORE CLICKING DELETE — the one check the PKM cannot do for Kim.** Deletion is a
one-way door, and this system can only see what the VENUES reference. If a track was
uploaded to SoundCloud and never embedded anywhere, nothing here knows it exists.
**Open the SoundCloud track list and compare it against the local files** before
deleting the account. Two known local files are already unembedded --
`Gallery_Catalog_2.mp3` and `NotebookLM_review.mp3` (the three-voice discussion of
NotebookLM; Kim, 2026-08-02: worth keeping, not needed on a page) -- which proves the
category is real: audio can exist outside the venue graph.

This is the same discipline applied to Exposure and ISSUU. It cost nothing there and it
costs nothing here. *Raised by Claude, 2026-08-02.*


