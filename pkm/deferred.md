# Deferred Work

_Created 2026-07-29. Mechanism 6 of the PKM Operating Protocol — see `pkm_protocol.md`._

Items that are real, that nobody should forget, and that there is no reason to act
on yet. They live here instead of in a project's Next Steps so that a finished
project can stop looking unfinished, and so that Next Steps keeps meaning *the
work in front of us*.

## How this file is used

**The trigger is the mechanism, not the list.** A deferred item is worthless
unless something guarantees it gets read at the moment it becomes cheap to do. So:
**when a session opens a project for real work, it reads that project's section
here first, before touching anything.** Session-start (Mechanism 2) loads the
system; this loads the project. Without that rule this file becomes a write-only
archive, which is worse than no file, because it launders the guilt of not doing
the thing.

**Two kinds of entry, kept apart on purpose.**

- **TASK** — something to do when there is already a reason to touch the project:
  the next revision, the next release, the next render. It waits for an occasion.
- **CONDITIONAL** — not a task at all. It surfaces only if a named thing happens,
  and its whole value is arriving at the bad moment with the answer already
  written. Filed among the tasks it would be buried, and the bad moment is exactly
  when nobody reads a long list.

**Item shape.** What, where, why it was deferred, and who raised it, dated.
Attribution is not bookkeeping: when a colleague asks whether their note landed,
the answer should be *yes, and here it is*.

**Two rules.**

1. An item may be closed as **WON'T DO**, with the reason kept rather than
   deleted. A list that only grows is a list that dies. (The same discipline as
   Findings 001/005/013/015, queued to collapse into one statement instead of
   accumulating four partial ones.)
2. **Deferred must mean "no occasion yet", never "unpleasant."** The hardcoded
   Google key sat as an open item for weeks and that was not for want of an
   occasion. A file like this makes that failure mode easier to commit, so the
   rule is written where it will be read.

**Review points.** Whenever a project's Status changes, and at the end-of-session
checklist (Mechanism 5, item 8). If a project's section here grows long enough to
be unwieldy, split it to `deferred/<name>.md` and leave a pointer — the same growth
path the per-project logs took to `logs/` on 2026-07-28.

---

## specimen_labels / *Voucher Labels*

Published 2026-07-29 at kimbridges-documents.netlify.app/vouchr/.

**TASK — Split the log to `logs/proj_specimen_labels_log.md`.**
`proj_specimen_labels.md` is ~150 KB with its dated log still in-file, while
proj_PKM, whittakerr, AI_Microscope and briefing_book all moved theirs on
2026-07-28 with a `_Log:` pointer. It is the largest proj file in the system and
the one that skipped the split. *Deferred:* Kim's call — "the split comes when
we're actually finished" (2026-07-29). *Occasion:* the next substantive edit to
that file.

**TASK — Tone pass on the three honest-provenance disclosures.**
The bench-run admission in `closing-the-loop.qmd`, the no-permit candidate sites
in `field-log.qmd`, and the derived-versus-checked canopy pair. Each is
individually right and together they are the book's integrity on display; read in
sequence they could start to sound apologetic. The fix, if it reads that way, is
to vary the register — **not** to remove the disclosures. *Raised by Claude,
2026-07-29.* *Occasion:* the next revision, ideally after a colleague read.

**TASK — Confirm or correct the cover-translucency reading.**
`decks.qmd` says the covers are "the same plastic that reads bright on a pale
surface, gone dark against a black one." Measured: RGB(187,46,63) at value 0.73 in
`Tree_card.jpg` against RGB(70,11,5) at 0.27 in `Deck_spread_out.jpg`, same red
hue, comparable exposure. Translucency is the inferred explanation and fits Kim's
own reason for the blank end cards, but he has not confirmed it. *Occasion:* next
revision.

**TASK — "gray for abundance" should probably read "silver."**
`decks.qmd` names the abundance cover grey; it is metallic silver (measured
saturation 0.06–0.08 across three frames). Trivial, and it is the sort of physical
detail this project has already had to correct twice. *Occasion:* next revision.

**TASK — Decide whether `decks/` should carry an Abundance deck.**
The printed kit has one (Dominant / Common / Occasional / Rare); the
`discover_decks()` outputs in `decks/` do not. Resolved for now by making
provenance legible in `decks/README.md` rather than reconciling contents, which is
the right call — the mismatch is the book's own thesis in the filesystem.
*Occasion:* the next `discover_decks()` run.

**TASK — Stale path in `QR_procedures.Rmd`.**
Around line 617 it still reads a key from `P://Hot/Workflow/...`, a drive that no
longer figures anywhere. Harmless to run, confusing to a future reader, and it sits
next to the key handling that was cleaned up on 2026-07-29.

**CONDITIONAL — If a real field collection is ever made with the decks**, replace
the bench-run worked example in `closing-the-loop.qmd` and revisit the
candidate-sites framing in `field-log.qmd`. Both currently carry honest disclosures
that would simply become unnecessary. Note that Hawaii Volcanoes NP collecting
needs a permit, which is why neither exists yet.

---

## vouchr

Live at github.com/kimbridges/vouchr. v0.1.0 plus commit `9be8f1c`.

**TASK — Document the two cluster numberings, and return the mapping.**
`discover_decks()` returns `$clusters` straight from `cutree()` — arbitrary
integers — while the heatmap re-ranks clusters by signature richness
(`R/deck_discovery.R` lines 109–110, "order clusters, richest first"). Both are
labelled "Cluster N" and they disagree for two of the four archetypes, so a user
who reads a label off the figure and then indexes `$profiles` gets a silently wrong
answer. Nothing miscomputes; the defect is that two schemes share one name and
nothing says so. **Additive fix:** one line in the Rd, plus a `cluster_label`
element so the figure and the object can be joined, plus a test asserting they
agree. **Do not renumber `$clusters`** — that changes returned values and would
break existing code and any saved analysis. *Raised by Claude, 2026-07-29.*
*Occasion:* 0.1.1.

**CONDITIONAL — If a deck ever fails to decode with the stack fanned, `bind_left`
is the first number to raise.** Measured clearance on the assembled deck is
**0.127 in** against the actual cover, not the 0.372 in once recorded — that figure
was clearance against the 1.5 in assumption, not against the cover. Left at 1.5 in
deliberately, because widening it costs QR size and the decks decode as they are.
Full measurements in the `R/make_qr_cards.R` header, commit `9be8f1c`.

**CONDITIONAL — If a guide sheet is ever used to place a punch**, note that
`punch_x` and `punch_d` are nominal (0.375 in, 0.25 in). The holes in the built
decks measure **0.788 in** from the card edge and the post heads about 0.39 in.
They drive the guide sheet, not the layout, so the mismatch is harmless in the code
and misleading on paper.

---

**✓ DECIDED AND FIXED 2026-08-18 — Kim: _yes, we should be doing that too. After all, these files are where
data live and that's often our focus._** `csv` and `xlsx` added to `SOURCE_EXT` in `pkm_health.R`.
**Mirror 975 -> 1,191 files; Smart_Car coverage 3 -> 26 of 85.** Verified BY CONTENT inside the mirror: 61
errata rows, 10 trip logs, the 294-row corrected dataset, the source workbook. Pushed and verified.
**The first run ABORTED on a size mismatch:** admitting `xlsx` pulled in Excel's `~$` lock/owner file, which
is locked and copies as 0 bytes. `.is_source()` had a `.~lock.` rule for LibreOffice but no `~$` rule for
Excel, because no Office extension had ever been whitelisted. Excluded; the guard was right to refuse.

**STILL OPEN — the binary tail, and it is a git-LFS question, not a whitelist one.** 38 photographs (168 MB),
17 scan PDFs (7.6 MB), one docx, one pptx. **The scans matter most: they are the only copy of the paper.**
Deliberately NOT decided here -- putting 168 MB of JPEGs into a plain git repo is a different kind of choice.

**STILL OPEN — `pkm_health()` has no COVERAGE check.** It reports orphans (mirrored files with no source) but
never the reverse. That asymmetry is what let this hide for the life of the system. A source-side diff
belongs in the health report whatever the whitelist says.

_Original entry:_ **DECISION NEEDED FROM KIM — THE BACKUP DOES NOT COVER THIS PROJECT'S DATA (2026-08-18).**
`pkm_backup()` keeps a file only if its extension is in `SOURCE_EXT` (`qmd rmd r yml yaml css scss bib py js md`).
**`csv`, `xlsx`, `pdf` and `jpg` are all absent, so 82 of the 85 files in `Projects/Smart_Car` have never been
backed up** -- every errata file, the corrected dataset, all ten trip logs, the source workbook, all 17 scans.
**The scripts were backed up; everything they operate on was not.** Full write-up as **Finding 034**.

**The fix is cheap but it is a SYSTEM-WIDE POLICY CHANGE and therefore Kim's call:** adding `csv` and `xlsx`
to `SOURCE_EXT` in `pkm_health.R` pulls in **182 files / 1.8 MB across all 50 projects**. `pdf` and `jpg` are
a separate question -- Smart_Car alone holds 7.6 MB of scans and 168 MB of photographs, which is a git-LFS
conversation, not a one-line edit.

**Also worth doing whatever Kim decides: `pkm_health()` reports ORPHANS (mirrored files with no source) but
has NO reverse check for source files with no mirror.** That asymmetry is what let this hide. A coverage
check belongs in the health report regardless of which extensions are whitelisted.

**Not urgent in the sense of data loss** -- the files live on Google Drive. What is missing is the VERSIONED
copy, which is where the adjudication history (61 errata, each with a basis and a status) would be
recoverable from if a file were overwritten rather than deleted.

## Smart_Car

### ★★★ SAY EARLY THAT THEY LIVE IN HAWAII (Kim, 2026-08-20)

*If you didn't know that you might wonder why we didn't just drive to my mother's place.* **Load-bearing three times: every dormancy is a FLIGHT home, not an idle car; the ~3,700 excluded Honolulu miles are the only miles driven where they live; and it inverts layer one a second time** — *you don't do much driving in Hawaii (think: downtown Honolulu). Driving on the mainland was something different for us.* **They live in a city and bought a city car to escape city driving.** Recorded as intentions item 6. **Put it beside the safety inversion in the Foreword.**

### ★★★ THE OPENING IS WRITTEN — the anchor at Lake San Marcos (Kim, 2026-08-20)

**Kim's origin story:** a car was needed at Lake San Marcos because visits to his mother were frequent and rentals were adding up; **there was a parking spot at her place**; and the contradiction — a city car with 71,283 mainland miles — resolves through the family dynamic, *two visits separated by the time needed to do some work.*

**★★★ THE RECORD GOES FURTHER THAN *BOTH PURPOSES*.** **22 of the 35 long dormancies are at that one address — 1,333 of 2,147 dormant days (62%), median stay 52 days, longest 184, spanning 2010-07-26 to 2016-08-02 exactly six years.** The car spent more of its life parked there than doing anything else. **AND EVERY COMPLETE TRIP IS A LOOP FROM IT** — eight of thirteen logged trips begin and end at Lake San Marcos, and every complete one from 2011 through the Fourth Crossing does. **The long-distance driving is not a departure from the local-errand purchase; it is structurally hung off it.**

**★★ The economics are visible as a COUNT, not a cost:** a rental must be returned, a car in a parking space need not be, and **22 long dormancies = twenty-two rentals not taken out in six years.** **The saving is in the DORMANCY column.** (A dollar figure needs a sourced rental rate — intentions item 4.)

### ✓✓✓ ANSWERED 2026-08-20 — THE CAR LEFT BECAUSE THE PARKING SPOT DID

Kim: *As my mother neared her 104th year, she could no longer stay in her assisted living facility in LSM. She moved to a more secure facility in August and that place didn't have parking for TwoRed. Parking is a big issue and we've been fortunate that friends and family have helped at critical times.*

**Not a bereavement — a facility's parking policy.** Last anchor fill **2016-08-02**; **Carlsbad holds the car 36 days** (08-17 to 09-22) while a new home is found; the coast run to Oregon follows 09-24 to 09-27. She died in January 2017 with the car already in Eugene, **which is why it was there when the call came. Adjacent facts, separate causes — the writing must keep them so.**

### ★★★ NEW THEME — PARKING IS THE HIDDEN INFRASTRUCTURE, and the dormancy map is the favour map

**34 of the 35 long dormancies sit inside a network of family, friends and a facility** — San Marcos 11 spells/578 days, Lake San Marcos 7/421, Carlsbad 4/334, then Signal Hill, Barstow, Parker AZ, Yuma, Coos Bay, Brookings and four singles. **Exactly ONE is outside it: Altamont IL, 25 days — the only time in sixteen years he had to BUY the service.** **The car wash is not an odd anecdote; it is the single failure of the parking network.**

**For the Foreword: the enabling condition of sixteen years of cross-country driving was not fuel and not roads — it was people willing to let a car sit.** The fuel log records movement; **the gaps between its rows record hospitality, and they are 86% of the elapsed days.**

### ✓ ANSWERED 2026-08-20 — and my favour map was mostly wrong (Finding 041)

Kim: *the other places are simply hotel/motels we stopped at along the way. They may repeat (like Brookings) as they are convenient stopping points.* **A fill records where fuel was BOUGHT, not where the car came to REST** — the five weeks I gave to Carlsbad were at **Mentone**, at his niece's, ninety miles on.

**THE FOUR REAL HOLDINGS, all named by him, none recoverable from fill locations:**

| place | who |
|---|---|
| **Lake San Marcos / San Marcos** | his mother's assisted living facility — 18 spells, 999 days, the anchor |
| **Mentone CA** | **his niece**, who kept TwoRed the five weeks of Aug–Sept 2016 |
| **Eugene OR** | **a close colleague** (named in the log; ⛔ NOT FOR PUBLICATION) — *a farm with a huge garage. He made space for us.* Visited several times a year |
| **St Louis**, near the airport | a hand car wash with an unused garage — **the only PAID holding in sixteen years**, improvised on sight |

**★★ AND SIGNAL HILL IS SMART MADNESS** — the garage and after-market vendor that equipped and maintained BOTH cars. **7 fills, 2011 to 2017, sitting at the seams of expeditions:** 2012-05-24 is 81 miles into day one of the Frostburg trip; **2013-09-06 is inside the Arctic trip's final leg — the car came off the Dalton and stopped at the shop on the way home.** **The wide-tire decision has an address.**

### ⛔ PRIVACY RULING GIVEN 2026-08-20 — the Eugene colleague is NOT NAMED in Smart_Car

Kim: *I'd rather refer to Will as a colleague rather than name him. I gave you his name as he appears in a lot of our projects.*

**RULE FOR SMART_CAR: the Eugene holding is "a close colleague with a farm and a large garage". No name, and no detail that would identify the farm.** The name stays in the PKM — like Creamsicle's purchase reason — **so a future session knows who is meant and does not ask again. It is NOT FOR PUBLICATION in this document.**

**★★ AND THE PRINCIPLE GENERALISES, which is the useful part.** He is already named in **seven live documents** on `kimbridges-documents` — acknowledgements, citations, academic activities, the AI microscope piece, whittakerr — **and those are untouched.** Naming a colleague as a COLLABORATOR is ordinary and appropriate; **naming him as a LOCATION is not.** **The constraint is not on the name. It is on pairing the name with a private fact — his home, his farm, that a car was stored there.** Do not go editing published scholarly work on the strength of a preference expressed about a memoir.

**Apply the same test to the others:** the **niece at Mentone** — relationship without a name, and no town if he prefers; the **St Louis car wash** — a business, and the story is about the arrangement rather than the firm, so no name is needed. **Ask Kim to confirm those two.**

**★ Deep connections, noted for the PKM rather than the book.** The same colleague appears across **17 PKM files and 7 projects** — AI_Microscope, audio, briefing_book, whittakerr, checklists, kimbridges-stories (Kakaako Birds), collections. **He is a hub in this system, and Smart_Car is the only project where the fact about him is private rather than professional.**

### ⚠ THE WIDE-TIRE INTERVAL CANNOT BE REPRODUCED — do not print it (2026-08-20)

The figure carried since 2026-08-18, **-3.7% to +4.9%**, could not be reproduced from `TwoRed_fuel_clean.csv` under four reasonable specifications: with/without a leg-length control, with/without partial fills, with/without the Alaska rows. **They run from +1.7% [-2.3, +5.6] to +4.5% [-0.2, +9.2].**

**The CLAIM is stable everywhere — the interval straddles zero and the 1-3% theoretical penalty sits inside it — so chapter 2 states the claim and prints no number.** **TASK: re-derive the interval with a WRITTEN specification** (which rows, which controls, which baseline) and record it beside the result, per intentions item 4. **A number that cannot be reproduced is not sourced.**

### ★★ THERE WERE THREE WHEEL STATES, NOT TWO (Kim, 2026-08-20)

*The Smart Madness people had me change the wheels to steel rims. I also bought an extra wheel.* **The 2013 Alaska expedition ran on STEEL RIMS, not the wide alloys** — 21 fuel rows (odometer 34,419-39,820) that every before/after wheel analysis has silently counted as *after*.

**Excluding them moves the before/after coefficient from -1.82 (p=0.058) to -1.47 (p=0.129): weaker, and still indistinguishable from zero. The conclusion survives.** ⚠ **And do NOT read the Alaska rows as evidence about steel rims** — they show +4 to +5 MPG against both other groups, but wheels are perfectly confounded with the entire expedition (roads, temperature, traffic, speeds). **Report the confound; attribute nothing.**

**★ Another layer-2 → layer-3 instance: a story revealed a variable the dataset did not know it had.**

### ★★★ THE SAFETY THESIS — layer one's content, given 2026-08-19

**The preconception is not *it's a city car*, it is IS IT SAFE? — a question with a fear in it, which is why layer 1 can carry a book.** Kim's answer has three parts and only the third is the thesis: the engineering answer (Mercedes, the safety cell) which by his own verdict lands as *maybe, maybe not*; the empirical answer (sixteen years, nothing happened); and **SMALL AND NIMBLE ARE COMPONENTS OF SAFETY**, which INVERTS the preconception rather than rebutting it. Both close calls support it — the Yukon pothole *big enough to eat a big car too* but dodgeable, and the Texas on-ramp (a police car coming up it at speed, no lights; hard right, hard brakes, stopped inches from the guard rail).

**★★ Write this chapter FIRST: it demonstrates the architecture on the project's own central question.** Layer 3 supplies the denominator — **100,999 documented miles across three cars, 467 fill-ups, 225 legs, 45 states, 10 provinces, no crash.** Layer 2 supplies the numerator, and nothing else can: **a crash avoided buys no fuel, ends no leg, and takes under a minute.** **Miles without near-misses are absence of evidence; near-misses without miles are anecdote.**

**★ It also closes the wide-tire loop (open since 2026-08-18):** the only modification was made for HANDLING, handling is the mechanism of the safety claim, and **the economy cost is indistinguishable from zero (-3.7% to +4.9%). The safety modification was free.**

### ⚠ TWO DISCIPLINES ON THE SAFETY CHAPTER — do not skip these

**1. No crash testing — Kim's own caveat.** The record cannot answer a counterfactual. Belongs in the DIFFICULTY strand, stated plainly rather than hedged.

**2. Do not oversell 101,000 crash-free miles.** One prudent driver, mostly interstate, mostly daylight, almost no urban commuting — **a low-exposure profile before the car is considered.** Honest claim: *the miles show the car did not prevent sixteen years of safe driving; the near-misses are where the car actively contributed.*

### TASK — source a per-mile crash rate before any comparison is printed

Intentions item 4 forbids printing an unsourced number. A US police-reported crash rate per 100M vehicle-miles (NHTSA or FHWA) would let the 101,000-mile figure be placed in context. **Until it is sourced and cited, state the exposure and stop.**

### ⛔ STANDING CONSTRAINT — THE TEXAS ON-RAMP LOCATION IS NOT TO BE NARROWED (Kim, 2026-08-20)

*I don't know the freeway on-ramp location in Texas where there was the police car incident. And for personal safety, I wouldn't reveal it either. Near Ft Worth is sufficiently close.*

**The three I-20 candidate legs assembled on 2026-08-19 have been REMOVED from this file.** No session should attempt to localise this incident; no published text may place it more precisely than **near Fort Worth**. **This is a request, not a feasibility question** — it stands whether or not the record could pin it, and the record cannot.

**Alongside the other standing constraints:** Creamsicle's purchase reason is NOT FOR PUBLICATION; no Smart_Car slug, filename, figure, data file or deploy path may take a `bordeaux*` form; the Arctic Circle Challenge is cross-referenced, never re-told.

### ✓✓✓ THE CHAPTER ARCHITECTURE IS SOLVED, 2026-08-19 — this was the blocker

**Kim's THREE LAYERS, given as preliminary thinking and recorded verbatim in the log.** Car = hook and preconception; drives = stories; data = answers, *including questions you didn't know you had*. **The car/human fabric runs THROUGH all three — it is the weave, not a chapter — so TWO LOGS, TWO SUBJECTS is absorbed rather than replaced.** The data layer has two ends and BOTH get written: collection/transcription/cleaning as a narrative with real suspense, and analysis/display at the other.

**Editorial rule that falls out:** an analysis earns the ANALYSIS strand only if it answers a question the drives raised; **results with no story attach to the DIFFICULTY strand instead** (the retired temperature effect, the wide-tire interval straddling zero, the Canadian non-result — all three are the data being honest about what it cannot say).

**NEXT ACTION, and it is now a writing task rather than a design one:** draft the chapter list against the three layers, retire the charter's six-chapter list for good, and sort the existing inventory into the two data strands. **Full development in `logs/proj_Smart_Car_log.md`.**


### ✓ THE SCANS ARE SAFE — Kim, 2026-08-20

*I did a backup of the 22 scans in a place on my machine where they are safe. I think we shouldn't worry about their loss. The backup is in a good place.* **Closed as an urgency.**

**⚠ What is closed and what is not.** The SCANS are protected. **The POLICY is not:** `SOURCE_EXT` still excludes `pdf`, `txt`, `docx` and `pptx`, and the mirror's `.gitignore` still lists `*.pdf`, `*.jpg`, `*.png`, `*.tif`, `*.mp3`, `*.mp4` — **two gates, each blind to the other (Finding 038).** So **authored prose across the PKM remains outside the versioned backup**: `LLM_Creates_R/Preface_text.txt` and `Chapter_13.txt`, `Scripting_Discovery/Research_Introduction.txt` and five `mRNA/Slide_N.txt`, `storylines/full_story.txt`, `Audio/Nike_challenge_canonical.txt`, a dozen `*_guidelines.txt`, plus `Smart_Car/source/Smart_Car.docx` and `Smart_Car_2016.pptx`.

**A manual copy is a second physical copy, not a versioned backup** — it will not track files created after today. **Not urgent, and not Smart_Car's problem any more. Raise it when the PKM itself is the focus**, and remember the precondition: `auth_token.txt` and `How_to_store_and_use_API_keys.txt` sit in the same set, and the mirror pushes to GitHub. **Audit for secrets before any extension is added.**

### TASK — extend the timezone table to Creamsicle's cities and apply Finding 035

`TwoRed_city_timezones.csv` covers 121 cities and none of them are guaranteed to be Creamsicle's. Kim's own sheet carries the note *"Needs adj for time zone changes"* on its Miles/Hour column, so his stored speeds have the same defect Finding 035 found in mine. Do this before any cross-car speed claim is published — the 7.5 mph gap above is computed within-car and is safe, but a TwoRed-vs-Creamsicle speed comparison is not until this runs.

### TASK — normalise TwoRed's Canada2014 units before re-testing the Canadian Plains

Those rows were converted from litres and CAD per row, which inflates residual spread by itself. The rough-road variance test (SD 4.87 n=18 vs 4.73 n=268, p=0.79) is a **NON-RESULT, not a null**, and must not be cited as one. **Creamsicle's three BC rows carry litres/CAD alongside gallons/USD — that is the layout to copy.**

### ✓ CLOSED 2026-08-19/20 — full entries archived in `logs/proj_Smart_Car_log.md`

Eight items finished and moved out so this file reads as OPEN work. Each is verbatim in the log under **SMART_CAR ITEMS CLOSED 2026-08-19/20**:

- **Creamsicle is ingested** — 173 fuel rows, 86 legs, the 7.5 mph net-vs-gross gap.
- **The record is closed at both ends** — 71,283 at the Matson dock; ~3,697 implied Honolulu miles.
- **Three more scans** — mostly redundant, and the redundancy paid twice.
- **The 46 Dalton miles** — Coldfoot → Wiseman; the two Yukon River Crossing fills split it 32 / 14.
- **The Penultimate State is Vermont** — the lawyer with an office in NH and a house across the river.
- **West Virginia** — I-64 Charleston to Beckley, driven twice; **superseded 2026-08-20, see ROAD CHARACTER below: different highways, one country.**
- **The 2010 loop has its story** — and it explained the only dormancy east of the Rockies.
- **Delaware recovered by geography** — 264 odometer miles against a 305-mile Delaware-free alternative.

### ★★★ ROAD CHARACTER — a new taxonomy from Kim, 2026-08-20, and a new analysis

He withdrew the West Virginia "same highway" claim himself after checking a map: **different highways, one country** — *rolling, tree-covered hills, a winding highway, small villages tucked in the valleys.* **And he added a category the project did not have: TREE TUNNELS — very long straight divided highway walled by dense trees. Flat. Monotonous. In the South.** The third term is the one both are a relief from: *nearly straight freeways lined by commerce, billboards and wall-to-wall housing.*

**★★ The project's existing road taxonomy is built from SPEED; this one is built from EXPERIENCE. They are different axes and both are needed.** Gross speed does not separate them — **Deep South median 40.3 mph (n=10) vs Appalachian 38.0 (n=6), p = 0.42** — and **that null completes a pair with the Canadian Plains: the most STRESSFUL miles and the most MONOTONOUS miles both read as unremarkable fast runs. The record is blind to the driver's experience at BOTH ends of the scale.** *Vigilance has no column; neither does tedium.*

**TASK — classify legs by Kim's categories and use them in the writing.** The categories are his and they are chapter material even where they are not measurable. Ask him to name the tree-tunnel stretches he remembers; do not infer them.

### ⚠ SIGNAL, NOT A FINDING — a ~3 MPG southern economy deficit that CANNOT be settled

`mpg ~ leg_miles + group`: South **-3.18, p=0.023** (n=30). With era: **-2.61, p=0.065**. On the 16 rows carrying a fill-stamped temperature: **-5.81, p=0.009**, with temperature itself null (**+0.108, p=0.39**). **Plausible mechanism is the inverse of the intuition — flat straight divided highway invites steady high speed, and drag costs an 1,800-lb car more than hills do.**

**Three reasons it is a signal:** the coefficient is **unstable across subsamples** (-2.6 to -5.8), **n=30**, and temperature is **confounded with group** (median 87.5 degF vs 76.5). **★★ And unlike the temperature effect it cannot be resolved by waiting: Creamsicle has ZERO fills in any southern state** — its routes are California↔Wisconsin and the West. **The sample is closed at 30 and will not grow.**

**Belongs to the DIFFICULTY strand by the editorial rule. Do not print the coefficient. Print the fact that it cannot be settled.**

### ★★★ READINESS ASSESSMENT, 2026-08-19 — Kim asked whether the record is complete enough to start writing

**Answer: YES for four chapters, NO for three, and the strongest argument for starting is that the record
just RETIRED a result.**

**State of the two spines.**
- **Fuel log: COMPLETE AND AUDITED.** 294 rows, odometer 4 to 71,181, 2010-07-23 to 2017-05-22. **277 of
  294 balance the pump identity**; the 13 that fail by 2c or more each carry a documented basis. Errata 65:
  38 settled, 6 hypothesis, and only **4 literally OPEN** -- the rest are bookkeeping states.
- **Trip log: 132 legs, 126 timed, 39,883 miles = 56% of lifetime miles**, and **57% of fuel rows sit under
  a leg.** The uncovered stretches are 2010-07 to 2011-03 (46 fills), 2014-07 to 2016-05 (27), and the
  2016-07 to 2017-05 tail (14). **★ The early gap is DEFINITIONAL, not missing** -- Kim ruled 2026-08-17
  that trip logging began later and must never be backfilled.
- **Fill-stamped time and temperature: 127 of 294 (43%).**
- **Gazetteer join: 78.2%**, 55 distinct locations unmatched.

**READY TO WRITE NOW.** (1) Economy, cost per mile and degradation over sixteen years -- fuel log alone.
(2) The shape of a driving day -- 126 timed legs. (3) Gross speed by road type -- 11 trips, **stating the
means-not-variance limit**. (4) The stories -- ten collected, every one cross-checked against the log.

**NOT READY.** (1) **Temperature vs economy -- RETIRED, do not write it.** (2) **TwoRed vs Creamsicle --
BLOCKED: Creamsicle has never been ingested.** That is a whole car and it is the largest remaining gap in
the project. (3) **Canadian economy -- BLOCKED on litres/CAD normalisation.** (4) Route and geography --
PARTIAL at 78% join.

**★★★ THE ARGUMENT FOR STARTING NOW, AND IT IS NOT IMPATIENCE.** The Fourth Crossing added 31 fill-stamped
temperatures and **the thermal effect went from -0.068 MPG/degF at p=0.045 to -0.050 at p=0.099, and p=0.17
with era fixed effects.** More data moved the coefficient toward zero and dissolved the significance.
**That is exactly what should happen to a marginal result, and it means the pipeline works.** A record that
can retire its own findings is a record you can write from.

**★★ AND WRITING IS THE BEST GAP-DETECTOR AVAILABLE.** Every gap listed above was found by trying to answer
a question -- the wheels needed a dated cut, the temperature test needed the right unit of observation, the
speed comparison needed time zones. **None was found by taking inventory.** Collecting more data before
writing optimises for the gaps we already know about, which are by definition the ones that matter least.

**RECOMMENDED FIRST MOVE: the chapter architecture**, which has been the named weak point since 2026-08-16
and is now the only thing blocking a start. **Kim's TWO LOGS, TWO SUBJECTS frame is the candidate**, with
its boundary attached: the trip log measures what the human ACHIEVED, it records MEANS and not VARIANCE, and
the stories are the sole record of what the driving COST. **Settle the architecture and the rest is
drafting.**


_Section opened 2026-08-12 when the project was filed; the fleet roster and Kim's
analysis intentions were added the same day. Everything here is BLOCKED on the first two
items._

**✓ CLOSED 2026-08-16 — locate the CREAMSICLE cross-country data. FOUND.** It is Google-native
(`Final Creamsicle Logs` Sheet, multi-tab: fuel + a daily trip log per trip; `Creamsicle` Doc, the
9-trip narrative; `Creamsicle_July_Fuel_Log_update` with lat/long; `Creamsicle Inventory`).
**Kept per the WON'T-DO rule for the REASON, not the answer: a filesystem sweep cannot see a
Google-native document.** `G:` reported the stub at 176 bytes and `readBin` returned 0. The task
sat open for months because every search was the wrong KIND of search, not because the data was
hard to find. **Before filing anything as missing, search the Drive API by title.**
**★ Kim had spent the two days before 2026-08-16 working this material up himself.**

_Superseded:_ **TASK — locate the CREAMSICLE cross-country data.** Kim, 2026-08-12. **The highest-value
gap in the project.** Creamsicle (2016 Smart, white/orange) was driven across the country
several times and Kim says he has substantial data on it. Finding those files turns this from
one documented car plus three anecdotes into **two analytical spines**. Until then the fleet
framing is narrative rather than quantitative. Unscheduled by his choice.

**✓ CLOSED 2026-08-16 — top up the TwoRed fuel log to ~75,000. NOT A GAP; A SCOPE BOUNDARY.**
Kim: `TwoRed_fuel_June_2014` **IS** the last fuel log. He logged fuel while the car was used
primarily for long trips; Honolulu trips are all short, the receipts exist, and they add nothing
to a document about long-trip performance. **Kept per the WON'T-DO rule for the reason: the log
stopping at 71,181 while the car reached ~75,000 is the project's own scope showing up in its
record.** Cite *log miles* and *odometer miles* as distinct quantities; do not reconcile them.
**This supersedes his 2026-08-12 phrasing ("I need to update the fuel logs") -- later ruling wins.**

_Superseded:_ **TASK — top up the TwoRed fuel log to ~75,000.** Kim, 2026-08-12, his own framing:
*I need to update the fuel logs so that things are properly filled in.* The Gas Log stops at
71,181; the car went to about 20 miles short of 75,000. The missing stretch is real driving
with no records entered.

**✓ PARTLY CLOSED 2026-08-16 — Two4Two/TwoFer HAS a record.** `TwoFer Gas Log` (Sheet):
7 fill-ups, 2014-03-22 (dealer, odo 0) to 2015-01-10, **1,209 miles, every one in Honolulu.**
**Naming ruled by Kim 2026-08-16: BOTH were used — `Two4Two` is canonical in prose, `TwoFer` is
the log's title. Recorded so a future session does not "correct" one into the other.**
**★ Worth keeping: this does not pad the fleet thesis, it sharpens it — the one car that WAS a
pure urban commuter is the one that was leased and given back.** Bordeaux remains uninventoried.

_Superseded:_ **TASK — whatever exists for Two4Two and Bordeaux.** Lower value, recorded so it is not
mistaken for an oversight. Two4Two was a **lease from 2014-03-22** (Smart Pure, ICE) and was
short; Bordeaux (2018, electric) is deliberately outside the statistics by Kim's ruling of
2026-08-12. Neither is expected to carry much.

**✓ CLOSED 2026-08-12 — the 71,181 vs 75,000 question.** Kim: TwoRed is **about 20 miles
short of 75,000**. The log stopped before the car did; the charter's title was right and the
open question rested on the spreadsheet alone. **Kept per the WON'T-DO rule for the reason,
not the answer: a dataset ending is not the same as the thing it measures ending.**

**★★ KIM 2026-08-17 — THE ERRORS HAVE A MECHANISM, AND IT IS NOT CARELESSNESS.** His words at
close: *there were lines waiting for fuel and it was important to record quickly and vacate the
fuel stall. And forgetting to record a fill-up? That can happen, too.* **This converts the whole
audit from a list of defects into a description of FIELD CONDITIONS.** Consequences that should
shape the write-up rather than sit in a footnote:
- **Category B (missing fill-ups, detected as impossibly high MPG) is EXPECTED, not anomalous.**
  A forgotten entry under queue pressure is the predicted failure of this collection method.
- **Digit slips cluster where haste does.** A number written standing at a pump with cars waiting
  is a different measurement instrument from one written at a desk.
- **Say so in the document.** A record kept for sixteen years under those conditions with ~2% of
  distance disputed is a STRONG result. **Stating the mechanism is what makes the honest review
  credible rather than defensive** -- Kim: *if there are data problems, it is fully understandable.*

**★ TASK — the 3-bar rule as a testable behaviour change.** Kim adopted a habit at Deming on
2010-09-20 after nearly running dry: refill at 3 of 8 bars, never below 2. **Mean fill fell from
87.7% of tank (n=5) to 70.6% (n=286).** **n=5 is FAR too small for a claim -- this is corroboration,
not evidence, and must be labelled as such.** Retest properly once more early data exists.
**★ What IS solid and belongs in the document, fully sourced: he ran 290 miles on that tank, took
7.119 gal (82% of 8.7), and at his then-current 38.1 MPG had roughly 41 MILES OF RANGE LEFT.**

**TASK — Charlton MA -> Austinburg OH remains UNRESOLVED.** GMaps 365 falls BELOW the 457 straight
line, which is impossible, and both coordinates check out. Kim is re-checking the endpoints. **Do
not resolve this by picking whichever number looks nicest.**

**★ KIM'S RULING 2026-08-17 — TRIP LOGGING STARTED LATER THAN FUEL LOGGING. DO NOT BACKFILL.**
His words: he *didn't do trip logging right at the start; that got added later*, he could probably
reconstruct approximations, but **better to treat it as a limitation of the data collection that we
improved as we went along.** **So: establish the ONSET DATE of trip logging from the scans and
record it; treat pre-onset trips as FUEL-ONLY; never estimate a leg that was not written down.**
**★ Analytical consequence, and it must be stated wherever early and late trips are compared: the
INSTRUMENT changed over the record, not just the car.** An early trip with no legs is not a quieter
trip. And Creamsicle's logging is the MATURE form of the method -- so TwoRed-early vs Creamsicle
differences are partly method, not behaviour. This is the same shape as the temperature ruling.

**TASK — fix the gazetteer, not the fuel log, for two mis-geocodes.** `All_gas_stations_csv.csv`
(212 stops, all with coordinates; matches the `Locations` sheet row-for-row). **`Deming` is recorded
as ARIZONA in the fuel log and is in NEW MEXICO** -- that one IS a fuel-log error. **`Big Springs,
Texas` is really `Big Spring` (no s)** and appears to have geocoded to Nebraska -- that one is a
gazetteer error. **Decide per case which side is wrong before editing either.**

**TASK — raise the gazetteer join rate above 81.5%.** 47 distinct locations unmatched. At least one
is a plain misspelling in the fuel log (`Lake San Marcos, Callifornia`). Others are simply absent
from the 212. **The join failure list is itself a typo detector -- work it before geocoding anything new.**

**TASK — 15 scanned logs inventoried 2026-08-17** in `data/Fuel_and_Trip_Logs/`, 4.9 MB, 2010-2017.
**One duplicate:** `2011_TwoRed_travel_and_fuel_log_June.pdf` is byte-identical in `data/` and in the
subfolder (md5-checked); the `proj` Key Files entry points at the `data/` copy. **Watch:**
`2011_TwoRed_fuel_and_trip_log_STL.pdf` is a DIFFERENT document by md5 but the June sheets are headed
*2011 St. Louis Trip* -- **check for repeated legs before merging them.** **✓ `2016_TwoRed_fuel_missing_page.pdf` OPENED 2026-08-19: no gap. Three fuel rows (57,610 / 57,877 / 58,094, Dec 2015 - Apr 2016) all already in the dataset and matching to the cent; its DAILY TRAVEL table is BLANK. Yield: three new fill times and temperatures.**

**★ STATE OF THE ERRATA, 2026-08-18 close: 58 entries (L01-L58)** in `data/TwoRed_log_errata.csv`, 8 in
`TwoRed_gazetteer_errata.csv`. **The arithmetic class is EXHAUSTED** -- nine typos proven, three rows
contaminated by a single May-2016 fill-drag, one coincidence cleared, all residuals above 2c resolved.
**The 'missing fill-up' class ended at FIVE FLAGGED, ZERO REAL** -- one merged row, three partial
fills, and one artifact my own filter created (Finding 032).

**★★ TASK — SCAN THE MISSING PERIODS. Highest-value remaining data task.** 153 of 293 fuel rows have
no verified paper. **✓ MAY-JUNE 2016 CLOSED 2026-08-18 — RECOVERED, NOT LOST.** Kim's AMEX statements plus the actual
pump receipts (`2016_Fouth_Crossing_Fuel_Receipts.pdf`) settled all three: **LSM 3.641 gal / $10.92,
Blythe 4.531 gal / $14.04, Winslow cost $15.48.** **The lesson is mine and it is kept: I filed the period
as unrecoverable after searching ONE folder.** Kim: *it's an electronic shoebox. I scan paper. All paper.*
**Search the whole archive before declaring anything missing** -- the same shape as the Creamsicle closure,
where the wrong KIND of search, not the data, was the problem.

_Original:_ **Priority: MAY-JUNE 2016** (the Fourth Crossing) -- the fill-drag contamination
lives there and the true LSM/Blythe gallons and costs are unrecoverable without it. Then the 2017
Feb-May tail. Kim to check the box while the papers are out.

**✓ 2016 FALL-WINTER TRANSCRIBED 2026-08-18 — both pages, EVERY column.** Outputs: `data/TwoRed_2016_FallWinter_trip_log.csv` (4 legs) and `data/TwoRed_fuel_timetemp.csv` (9 fuel rows). **All 9 fuel rows matched the clean dataset on date, city, brand, price and gallons** -- the sheet is sound. **QC passed on four independent axes:** odometer chain contiguous across all 4 legs; all 4 fuel stops fall INSIDE their leg and on the leg's own date; every leg distance is road-plausible; every pump identity balances.

**★★ THE FUEL TABLE ON THE PAPER FORM HAS ITS OWN `Time` AND `Temp` COLUMNS.** This matters more than the trip-log temperatures do: **MPG is computed per FILL, so a temperature stamped on the fill is the right instrument for an economy-vs-temperature test. A leg-endpoint temperature is not** -- it belongs to a different unit of analysis. Any thermal claim should be built on the fuel-row temperatures.

**★★ CHECK THE LIVE `TwoRed_fuel` SHEET BEFORE TRANSCRIBING ONE MORE TEMPERATURE.** The existing deferred entry below records that its Notes column already carries strings like `64F @ 2:25PM` and that its summary block reads **141 fill-ups**. **If that holds, roughly half the temperature data is ALREADY DIGITISED and the scan-transcription campaign is largely unnecessary.** Same shape as Creamsicle and as May-June 2016: **check whether the data already exists in another form before paying to re-create it.** Do this FIRST.

**TASK — the trip-log CSVs drifted into TWO INCOMPATIBLE SCHEMAS and nobody noticed.** 2011 and 2016 use `start_time/start_temp_F/start_odo/start_city`; 2013 and 2014 use `start/tempA/odoA/from`. A naive rbind **errors out**, which is the lucky case -- a silent partial match would have been worse. Normalised by `Projects/Smart_Car/trip_logs_read.R`, which maps both to one canonical schema and computes `raw_hours / elapsed_hours / gross_mph / odo_miles` on read. **It does not edit the CSVs.** **Decide later whether to rewrite the two B-schema files or keep the reader as the compatibility layer.**
**It immediately paid: pooled legs with usable times went from 50 to 69**, because 2013/2014 had times all along and the earlier count simply could not see them.

**✓ ALL 15 SCANS READ 2026-08-18. THE SCAN BACKLOG IS CLOSED.** 18 pages, 7 files, every column taken.
Trip legs **69 -> 107**; fuel rows with a time and temperature stamped on the FILL **0 -> 95** (32%).
New CSVs in `data/`: `TwoRed_2012_Frostburg_trip_log.csv` (18), `..._2012_MayArizona_...` (7),
`..._2015_Sedona_...` (3), `..._2017_January_...` (3), `..._2011_NorCalRoadtrip_...` (6),
`..._2013-4_LAExpedition_...` (1), plus `TwoRed_fuel_timetemp.csv` (95 rows).

**✓ THE 2011 STL OVERLAP QUESTION IS ANSWERED: PURE DUPLICATE, ZERO NEW LEGS.** Different md5, same four
pages rescanned. **But re-opening it returned 23 fuel-row temperatures that the first pass walked past** because it was looking for distance. **The transcribe-once rule proved itself on the first file it touched.**

**★★★ THE WHEEL CHANGE IS DATED: `NEW WHEELS @ 13510 miles`, in Kim's hand on the 2011 STL sheet.** The
before/after cut is no longer an assumption. 179 miles before the St. Louis departure; the narrow-tire group
is exactly 2010-07-23 to 2011-05-11. **The estimate still flips sign with specification (+3.6% to -1.8%)** --
see the CONDITIONAL above, which still governs.

**★★ TASK — CONFIRM L59/L60/L61 FROM AMEX. Three new slashed-zero cost corrections.** L59 San Marcos
2010-11-29 19.28->19.20 (**the first fill in the record**); L60 San Marcos 2011-06-23 32.48->32.40 (**the same
row as L01** -- two slips in one row); L61 Champaign 2012-05-31 29.68->29.60. **Control run over the 44 rows
that fail the pump identity: the permitted 8->0 substitution fixes 4; the forbidden 0->8 fixes 1 (Deming,
already flagged wrong-direction); six control substitutions fix ZERO.** Errata now 61 entries.

**★★ TASK — the TEMPERATURE result needs a bigger n before it is a claim.** With temperature measured ON THE
FILL (n=94): **-0.068 MPG per degF controlling leg length, p=0.045**; fills at 80F+ average 36.76 MPG against
38.87 below. **But p crosses 0.05 under era fixed effects, and the sign is counterintuitive** (warm air is
thinner and should help). Likely mechanism is **A/C load on a 1.0-litre engine -- INFERRED, not measured**, and
indistinguishable in this data from hot-weather routes being different routes. **Do not write this as a
finding yet.** The live `TwoRed_fuel` Sheet's Notes column may hold ~141 more fill temperatures -- that is the
cheapest route to the n that would settle it. **Harvest it before transcribing anything else.**

**TASK — decide the fate of the two-schema trip-log CSVs.** `trip_logs_read.R` normalises A (2011/2016/2012/
2015/2017) and B (2013/2014) on read. Either rewrite the two B files or keep the reader as the permanent
compatibility layer. **Not urgent; do not let it drift into a third schema.**

**TASK — six legs of the 2011 N. California Roadtrip are RECONSTRUCTED, not transcribed.** That trip has no
table -- only circled margin stamps. Four of its six end-odometers are the NEXT MORNING's departure reading,
so they may include evening local driving. **Flagged in the `note` column of every affected row. Kim's own
running trip-mile totals in the margin act as a checksum and they all reconcile** (443.1 / 847.8 / 949.8 /
1189.9 / 1494.4 / 1801.5 total, against 13,461 - 11,660 = 1,801). **They also caught one of my misreadings**
-- Healdsburg is 12,850, not the 13,850 I first wrote.

**✓ CLOSED 2026-08-18 — NO SCANS REMAIN UNOPENED.** *(The count itself had drifted: I wrote 8 -> 7 when the fall-winter file ARRIVED and 7 -> 6 when it was transcribed. Arrival is not transcription; the count was decremented twice for one event. Actual folder holds 15 scans, 4 trips transcribed.)* (`2016 fall-winter` arrived 2026-08-18 as
`2016_TwoRed_trip_log_fall-winter.pdf` and is NOT yet transcribed.) 2011 STL (also settles whether it overlaps the June sheet --
different md5, same trip name, so check for repeated legs BEFORE merging), 2011 fuel log,
2012 Frostburg, 2012 May Arizona, 2013-4 LA Expedition, 2015 Sedona, 2016 fall-winter, 2017 January.

**TASK — confirm 3 open items from a card or receipt, NOT from a scan.**
- **L42 Coarse Gold** gallons 7.385 -> 7.305. **A scan cannot settle this** (0/8 illusion); arithmetic favours 7.305.
- **L44 Big Spring odometer**: Kim's typing says 22,945, the scan looks like 22,954. Neither test separates them.
- **✓ L11 / L38 RESOLVED 2026-08-18 from the pump receipts.** True gallons and costs for LSM 5/25/16, Blythe 5/26/16, Winslow 5/27/16.

**✓ DONE 2026-08-18 — `Projects/Smart_Car/twored_ingest.R` applies the errata as a DERIVED LAYER.**
Reads the xlsx + `TwoRed_corrections_machine.csv` + `TwoRed_inserts.csv` + `TwoRed_flags.csv` and emits
`data/TwoRed_fuel_clean.csv` (294 rows x 16 cols) with `corrections` and `corr_source` provenance columns.
**34 applied, 0 refused, 1 row inserted (Big Spring @ 22945).** The source workbook is never edited.
**Kept for the reason, not the answer: BUILDING it forced three things a correction LIST could not.**
(1) A row **INSERT**, because the Alpine/Big Spring row was a chimera and needed splitting, not relabelling.
(2) **EXPLICIT** partial-fill flags, because a derived flag recomputed each run is not a decision, it is a guess.
(3) A **GUARD that REFUSES** any correction whose `old_value` does not match the source row -- it immediately
caught two errata keyed to the WRONG odometer (L07, L14). A correction that cannot find its row is a bug,
not a no-op. **Finding 032 is written into the code**: order by the monotonic counter, never the date, and
`stopifnot(nrow >= n_src)` -- rows may be added, never silently lost.

_Original entry:_ **TASK — apply the errata as a DERIVED LAYER in the ingestion script.** 45 entries now exist and only
TWO have been written into the xlsx. **That is deliberate** -- the errata file is the correction of
record. The ingestion must read xlsx + errata and emit corrected values with provenance, never edit
the source.

**★ TASK — transcribe the REST of the TwoRed paper trip logs.** Kim, 2026-08-17: he likely has a
**complete set**. The 2011 St. Louis Trip is done (`data/TwoRed_2011_StLouis_trip_log.csv`, 15 legs).
**This is the highest-value open item in the project** -- it converts TwoRed from a fuel spine with a
7-row trip fragment into a true parallel spine to Creamsicle, which is what makes the comparison real.
**Method proven and cheap: the odometer delta cross-checks every written distance**, so errors surface
automatically (it already corrected one of my own readings). Workflow: Kim scans -> transcribe ->
odometer QC -> one CSV per trip -> flag, never silently smooth, anything that fails.

**✓ DONE 2026-08-17 — two PROVEN transcription errors fixed in `TwoRed_fuel_June_2014.xlsx`,
on Kim's instruction, snapshot first.** Method kept because it generalises: the workbook has **175
formula cells** and four sheets with drawings, so rewriting it with a package risked losing structure.
Instead the `.xlsx` was **unzipped, two `<v>` values edited in `sheet1.xml`, and re-zipped**
(`zip::zip`, `mode = "mirror"` -- `cherry-pick` FLATTENS paths and produces a file Excel cannot open,
and `list.files()` omits `_rels/.rels` unless `all.files = TRUE`; both bit me once each).
**Verified by a cell-by-cell diff of all four sheets against the snapshot: exactly 2 differences,
the two intended.** Dimensions preserved (296x20, 212x5, 7x10, 24x13); the arithmetic audit re-run
on the live file now fails only the 2 field errors. Snapshot at
`C:\temp\smartcar_fuelfix_20260817\` (bucket 4 -- delete once Kim is satisfied).
**File is smaller (56,263 vs 58,588 bytes) purely from recompression; content verified cell-wise.**

_Superseded:_ **TASK — fix two PROVEN transcription errors.** Not applied: editing
Kim's data file is his call. **2011-06-23 San Marcos: `$/gal` reads 3.000, paper says 3.999** (8.101 x
3.999 = 32.40 against the 32.48 recorded; 8.101 x 3.000 = 24.30, impossible). **2011-06-25 Ash Fork:
`Gallons` reads 7.624, paper says 7.264** (7.264 x 4.199 = 30.50 exactly, the recorded cost). Both are
digit-level slips made while typing, and both change derived MPG for that fill.

**TASK — two FIELD errors that the paper does NOT resolve.** 2011-06-25 Ludlow (6.319 x 4.599 = 29.06
vs 29.86 recorded) and 2011-07-02 Spring TX (7.889 x 3.679 = 29.02 vs 26.88 recorded). **Wrong on the
paper too, so they predate the spreadsheet.** Settle from a receipt (`2011` scans may exist) or leave
flagged. **Do not 'correct' them by back-solving -- that invents a number.**

**★ TASK — run the arithmetic audit across the WHOLE fuel log, not just 2011.** The `gallons x $/gal
= cost` test found 4 bad rows in a 23-row window. **293 fill-ups have never been checked this way.**
Cheap, and it partitions into transcription vs field errors wherever a scan exists.

**⚠ CONDITIONAL — before ANY TwoRed-vs-Creamsicle speed comparison.** Creamsicle's `Miles/Hour` is
computed after subtracting `Stop` time; the TwoRed paper sheets have **no stop column**, so TwoRed mph
is GROSS. **Naive comparison makes Creamsicle faster by construction.** Use Creamsicle's raw
`Duration`. Verified against its Nixa->Kansas City leg (209.4 mi / 3.00 adj hrs = 69.8).

**★★ RULE ADOPTED 2026-08-18 — TRANSCRIBE ONCE, COMPLETELY.** Every re-read of a scan costs a FULL
pass: finding the file, orienting the page, decoding Kim's hand, cross-checking the odometer. The
marginal cost of capturing a second column during that pass is near zero; the cost of coming back
for it is the whole pass again. **So no scan is opened for one field.** When a sheet is opened,
capture EVERY column present, even columns no analysis has been named for yet.

**✓ FOUR OF THE LONG-DAY STORIES COLLECTED 2026-08-19 — and all four check out against the log.**
Written up in `proj_Smart_Car.md`. **The navigation error is 2012-05-31 St Louis -> Columbus**: the friend
he made navigator was the executive director of the society's support organisation, they talked instead of
navigating, and the 09:52 fill at **Champaign, Illinois** -- one metro with Urbana -- is the recorded moment
of discovery. **Excess over the direct I-70 route: 108 miles, against the ~100 he remembered.** Dinner late,
outside, fireflies. **★★ And that Champaign row is L61**, one of the three slashed-zero cost typos raised
the day before -- **the typo sits at the stop where he had just found out he was lost and late.**

**★ TASK — ASK KIM ABOUT THE 04:05 DEPARTURE OF 2015-07-07.** He attached the nephew-at-Holbrook story to it,
but the data pins that to the **04:30** start of 2011-06-26 (Flagstaff -> Holbrook, 100 mi, arriving 06:45),
and the **70 miles of local driving between the Holbrook arrival and the next morning's departure IS the
park tour**. So the earliest start in sixteen years -- the 575-mile Carlsbad -> Sedona day routed the long
way through Palo Verde and Seligman -- **still has no explanation.** Also confirm the park: he said
"Petroglyphs NP"; the park at Holbrook is **Petrified Forest NP** (which holds the Newspaper Rock
petroglyphs). **Ask; do not silently correct a memory.**

**★★ RULE REVISED — a high road/straight-line ratio is sometimes a STORY, not a defect.** The St Louis day
inflates road distance by 26% with **no error in the data at all**. The geographic test assumes road >=
straight line and treats a high ratio as suspect. **Check the trip log for a reason before opening an errata
entry.** This is the first case where the human spine has corrected an audit instrument.

**✓ SIX OF EIGHT LONG-DAY STORIES COLLECTED 2026-08-19.** Verbatim in `logs/proj_Smart_Car_log.md` under 
COLLECTED STORIES; corroboration and consequences in `proj_Smart_Car.md`. **Every one checked out.**
**★ 2017-01-06 Brookings -> Paso Robles (562 mi) is the drive to his mother**, then 104, who was failing; 
red-eye from Honolulu, car collected in Eugene mid-day, then as far as exhaustion allowed. **He reached San 
Marcos and had time with her before she passed.** Handle this material with care in the document; it is the 
emotional centre of the January 2017 trip and it is not a performance anecdote.

**✓ ALL EIGHT LONG-DAY STORIES COLLECTED 2026-08-19.** Verbatim in `logs/proj_Smart_Car_log.md`.
**2014-05-05 El Paso -> San Antonio** was the run at **Florida, the last of the 49 mainland states** -- the
southern Texas routing exists for it. **2013-08-31 Bellingham -> Grants Pass** is Nancy surprising him off
the Alaska ferry, red-eye from Honolulu plus the train, with reservations already made; the next day
**Grants Pass -> San Francisco, 393 mi**, so she could fly home. Two big days, both in the log.

**✓ ANSWERED 2026-08-19 — HE REACHED FLORIDA, AND MY INFERENCE THAT HE HADN'T WAS WRONG (Finding 036).**
He aimed at the panhandle, drove a few miles in, stopped at a neighbourhood intersection, asked a passing
driver *is this Florida?*, was told yes, and left. **Minutes.** **The log resolves to two events -- buying
fuel and ending a day -- and he did neither there, deliberately. The visit is UNRECORDABLE, not merely
unrecorded.** The dip hangs off New Orleans -> Atmore (Atmore AL is ~12 mi from the line at Century FL and
is a fuel stop on the right day); road/straight-line **1.23 against a trip median of 1.22** -- invisible.
**Kept for the reason: I proved a statement about FILL-UPS and asserted one about a JOURNEY.**

**★★ TASK — so what does the trip name PENULTIMATE STATE mean?** Florida was reached, so it is not the
missing 49th. **Ask Kim** -- it may name the second-to-last state acquired on that trip rather than the
last, or it may be his name for something else entirely. **Do not guess it into the document.**

**✓ THE TAIL OF THE DRAGON is in the odometer (2026-08-19).** Kim's next goal after Florida, *on the way to
my meeting*. US-129 at Deals Gap. **My earlier reasoning -- 407 logged vs ~400 direct, so no room for a
detour -- was worthless: the route was never the direct one.** Fuel stops give the waypoints: Montgomery ->
**Trussville AL (Birmingham)** -> **Madisonville, east Tennessee** -> Cherokee. North through Chattanooga
and Knoxville, not east through Atlanta. **Madisonville -> Cherokee is 104 mi against ~75 direct** -- the
Deals Gap route. **RULE: a matching TOTAL does not mean a matching ROUTE; check the intermediate fuel stops
before inferring a route from its endpoints.**

**✓ CORRECTED BY KIM 2026-08-19 — the Holbrook park is PETRIFIED FOREST NP, not "Petroglyphs NP".** His own
correction, applied to his account in the log with the correction itself recorded. **Note the data had
already pointed there:** 70 miles of local driving at Holbrook matches the Petrified Forest park road, and
Petroglyph National Monument is in Albuquerque, 300 miles east. **The instruments agreed before he did.**

**★ TASK — one DISCREPANCY to put to Kim: the Bellingham departure.** He remembers meeting Nancy *early
afternoon*; the sheet starts the day at **06:49**. The arithmetic favours the sheet -- 488 mi from 06:49 is
36.2 mph gross, already slow for I-5 and slower than the next day's 42.8 on the same road, while an
early-afternoon start would need ~67 mph gross with no stop. **Likely 06:49 is the ferry docking recorded as
the start of the day, and the reunion is the missing hours** -- which is what makes the day slow. **A
hypothesis about a memory. Ask.** The 2013 sheets carry no fill times to settle it.

**TASK — 2013-08-04 LSM -> Carson City (487 mi) has no story yet.** Ninth-longest; not asked about.

**✓ TWO NEAR-MISS STORIES collected 2026-08-19** (verbatim in the log): **a car-sized pothole in the Yukon
with no warning flag** -- *that would have been a TwoRed ending event* -- and **a four-inch level change
where the New Brunswick freeway met a bridge** (2014-05-23 Lubec ME -> Moncton NB, 217 mi, 40.6 mph).

**★★★ THE TEST CAME BACK NULL, AND KIM'S OWN CORRECTION EXPLAINED WHY.** He first said they *often slowed*;
the Canadian Plains legs run **44.5 mph median against 45.0 for the US Plains and 40.5 record-wide**, and the
economy residual is inside the noise. **Then he corrected himself: _abruptly slowed, then quickly speeded up.
The problem was that I couldn't go slow as big vehicles kept moving at highway speeds. Hence the rear view
mirror checks._** **So the high average is not evidence against the stress -- it IS the mechanism of it.**
He was not free to crawl.

**★★★ AND IT NAMES THE MISSING QUANTITY: WITHIN-LEG SPEED VARIANCE.** A trip log samples the day TWICE.
**Everything between departure and arrival is averaged away by construction**, and no quantity derived from
two endpoint readings can see variance. **The sharper rule: the log records MEANS and cannot record
VARIANCE, and the cost lived entirely in the variance.**

**Economy was the right place to look and it is unusable.** Canadian 2014 residual SD 4.87 (n=18) vs US 4.73
(n=268), F-test p=0.79 -- **but those rows were converted from LITRES and CAD and unit-normalising that
sheet is STILL OPEN.** A per-row conversion inflates spread on its own. **Recorded as a NON-RESULT, not a
null. Re-run it after the Canada2014 units are normalised.**

**✓ THE FAVOURITE DRIVES, collected 2026-08-19** (verbatim in the log): the Rockies; the mountains down to
the Oregon coast; **a morning through the West Virginia hills, villages fogged in and chimney smoke rising**
-- *I liked this so much, I drove it twice*; and the Dalton, *going where cars weren't intended*.
**Confirmed: Morgantown WV is a fill on 2012-06-01 at 12:33 and again on 2012-06-08 at 08:58** -- the
morning pass is the one he means, and its leg runs **33.9 mph gross against 45.5 outbound**. A drive being
savoured shows up as slowness.

**★★★ TASK — ASK KIM: 46 UNEXPLAINED MILES ON THE DALTON.** Ester -> Coldfoot is **252** odometer miles;
Coldfoot -> Ester next day is **298**. Same road. His drama -- the car sliding forward on gravel down a very
steep section, wondering whether they could climb back out -- belongs **north of Coldfoot**, toward Atigun
Pass. **23 miles up and back is 46.** Did he push north on the morning of 18 August before turning round?
**If so the odometer holds the drama and nothing else in the record mentions it.**

**✓✓ THE FOURTH CROSSING LOG IS FOUND — Kim scanned it 2026-08-19, the day it was asked for.**
`2016_Fourth_Crossing_Log.pdf`, 9 pages. **Trip legs 107 -> 132; fuel rows with time+temp 99 -> 127 (43%);
fuel rows under a trip log 140 -> 169 (57%); temperature observations 146 -> 382, range 32-107 degF.**
New file: `data/TwoRed_2016_FourthCrossing_trip_log.csv` (25 legs). 18 cities added to the timezone table.

**★★★ THE RECONSTRUCTION HELD.** All 29 paper rows balance the pump identity (max residual half a cent) and
**25 of 29 are identical to the corrected dataset.** The L11/L38 values derived from AMEX statements and
pump receipts **match the paper EXACTLY on gallons and cost.** An independent source, arrived at afterwards,
agreeing to the thousandth of a gallon.

**✓ AND THERE IS NO PHOENIX FILL.** The 5/25-5/27 fuel table reads LSM -> Blythe -> Winslow with nothing
between. **The hypothesis I raised and withdrew on three statistical grounds is now settled documentarily.**

**New errata L62-L65, all mine.** **L62 Blythe and L63 Winslow: I had written the AMEX MERCHANT NAME into
the Brand field** (`Quick Check West`, `Hallum Store`) because the card was the only source; the paper says
**Valero** and **Conoco**. L64 `Hy-Vse` -> `Hy-Vee`. L65 Cherokee gallons 6.002 -> 6.003 (both satisfy the
pump identity; the PAPER is the source). **RULE: when a field is filled from a substitute source, record
WHICH source -- a merchant string is not a brand.**

**✓ THE STUCK DAY IS RECOVERED.** 2016-05-27, **Youngtown AZ (a Phoenix suburb, where he overnighted) ->
Monument Valley UT**: out 06:40 in 72 degF, in 17:17, **362 odometer miles against ~320 direct = 42 miles of
detour**, and **37.6 mph gross against the trip's own median of 41.4.** Both the excess and the slowness are
what the dirt-road episode should look like. **Invisible yesterday because the unit of observation was the
fill-up; visible today because the unit changed.**

**★★ A NEW LONGEST DAY, BY EIGHTY MILES: 2016-06-19 Richmond MO -> Denver, 640 mi**, 06:57 to 16:53,
10.93 h tz-corrected, **58.6 mph gross**, with three fills en route each independently running 57-60 mph.
Previous longest 562. **Also 107 degF into St George on 6/21 -- the hottest reading in the record.**

**★ TASK — TWO THINGS TO PUT TO KIM.** (1) **✓ RESOLVED 2026-08-19 BY KIM: the Youngtown arrival is 8:41P; his writing was very light.**
I read 7:41P, then argued from a crossbar-like mark for 9:41P. **The mark was a bitonal-thresholding artifact
of faint ink, not an overwrite -- see the second-illusion note under Finding 033.** The day is now 345 mi in
8.05 h = **42.9 mph**, sitting on the record median of 40.5, and the Blythe->Youngtown half is 56.5 mph.
**Time zone was never the cause: Arizona does not observe DST, so in May it matches California.** (2) **West Virginia
twice now has TWO candidate pairs:** the 2012 Morgantown pair on I-68, or **the 2016 pair -- Huntington WV
-> Richmond VA on 6/12 and Richmond -> Morehead City NC on 6/13, both I-64 through the Greenbrier hills on
consecutive days.** The 2016 pair fits *I drove it twice* better: same road, out and back, one day apart.

**✓ THE STUCK-IN-ARIZONA CORRIDOR IS IDENTIFIED (2026-08-19), and the episode is invisible.** Google Maps
onto dirt roads across tribal land; stuck in powdery soil; freed by two men in a truck. **Route: 2016-05-27/28,
Winslow AZ 58,746 -> Monticello UT 59,013, 267 mi north through the Navajo Nation past Monument Valley**;
Phoenix is on the leg before (Blythe -> Winslow, 331 mi). **This is the Fourth Crossing -- the ONE stretch
with no trip-log sheet** -- so no times, no note. **Finding 036 again.**

**✗ WITHDRAWN 2026-08-19 — I RAISED THIS AND THEN REFUTED IT MYSELF. Kept for the reason, not the answer.**
The flag was an unrecorded fill on the 331-mile Blythe -> Winslow leg, prompted by its 52.2 MPG. **Three
tests, and all three point the other way.**
1. **The whole Fourth Crossing runs +3.25 MPG above the record-wide leg-length model** (residual SD 4.74),
   so Winslow's +8.7 is unremarkable INSIDE that trip. Long fast legs raise economy; that is what this is.
2. **The tank maths is self-consistent.** Winslow took 6.346 gal = **73% of the 8.7-gal tank**, against a
   record-wide mean fill of **72%**. He arrived with about 27% left -- exactly the 3-bar habit.
3. **★ The decisive one.** If a Phoenix fill were missing, the 6.346 gal would cover only Phoenix -> Winslow
   (~185 mi), implying **29.2 MPG on open interstate**. Only 2% of full fills sit that low, **and every one
   of them is a SHORT CITY leg (131-196 mi), never a 185-mile highway run.** The missing-fill hypothesis
   requires a worse anomaly than the one it was invented to explain.

**The lesson: a high value inside a run of high values is not an outlier, it is the run.** I compared one
leg with the RECORD when I should have compared it with its TRIP first. And 331 mi is the 96th percentile
of leg length -- unusual, but seven legs exceed it and the record's longest is 369.

**Still worth ONE cheap confirmation, from the scan rather than the AMEX:** if Kim's Fourth Crossing sheet
exists, its fuel table simply shows whether a Phoenix row is there. **Do not spend an AMEX search on this.**

**★★ RULE — a routing app can manufacture the geographic test's own signature.** *Memo to self: stay on the
main roads.* Excess road miles over the straight line PLUS low economy from rough surface is exactly what
the test hunts. **It is not an error; it is a wrong turn a machine recommended.** Third case where a high
ratio wants a story, not an errata entry.

**★★ TASK — READ THE ODOMETER GAPS. A new readable quantity, across the whole record.** The difference 
between an arrival odometer and the NEXT MORNING's departure odometer is the day off the highway. At 
Holbrook it is **70 miles = a Petrified Forest tour**. **Nobody has ever read this column and it exists 
for every consecutive pair of legs.** Cheap, and it maps where he actually spent his days.

**★★ TASK — MODEL DAILY DISTANCE WITH A LODGING TERM.** Kim on the fastest day in sixteen years: *there 
aren't many places to stay between the two cities, other than truck stop motels.* **Accommodation density 
is a first-order term in daily distance and no model has it.** Same for the ferries: a night crossing 
hands the next morning a loaded, fuelled car -- **read the five ferries as ENABLING the long days after 
them, not as holes in the odometer.**

**✓ FIXED 2026-08-19 — TIME ZONES WERE WRONG ON 16 OF 107 LEGS.** Kim records LOCAL clock time at both 
ends, so any leg crossing a zone had an elapsed time wrong by the offset, and **nothing in the data flagged 
it**. Only the 2011 file ever carried the correction by hand; every file transcribed since had 
`tz_shift_hr = 0` throughout. **Fixed as a DERIVED LAYER:** `data/TwoRed_city_timezones.csv` (97 endpoint 
cities -> IANA zones, 15 annotated where the state is misleading) and `trip_logs_read.R` computes the shift. 
**DST, Arizona and Saskatchewan not observing it, Yukon in 2013 and Newfoundland's half hour all fall out 
for free.** Effect: up to 6 mph per leg; **trip medians moved 0 to +0.9 and the road ordering is unchanged**; 
pooled 39.7 -> 40.3. **Billings -> Pocatello untouched at 65.5 -- the fastest day is real.**

**★★ RULE — GROSS MPH IS A CEILING ON DRIVING SPEED, NEVER A MEASURE OF IT.** LSM -> St George read 31.6 
mph and looked like a slog; it was a normal drive with a half-day visit to friends inside it. **Gross speed 
conflates driving with living.** Kim: *this was before I was recording why I took time off during a drive.* 
**This SHARPENS the Creamsicle conditional below rather than replacing it:** Creamsicle's `Stop` column is 
exactly the instrument that separates the two, and TwoRed has none. **Never present a TwoRed gross figure 
as a driving speed, even on its own.**

**★★ TASK — the trip logs carry FIVE things beyond distance, and only distance has been taken.**
Inventory, so a future session does not rediscover this:
1. **TEMPERATURE at departure and arrival** -- the field Kim named. Bounded early subset (see below).
2. **START and FINISH TIMES** -- these are what make the average-speed analysis possible at all.
   50 legs transcribed so far give median departure 08:13, arrival 16:35, an 8.7-hour day, 317 median
   miles, **37.9 mph gross**, earliest departure 05:35, and **46% of departures before 08:00**.
   ⚠ GROSS, not net -- the CONDITIONAL on Creamsicle comparison below governs any use of this.
3. **CITY PAIRS** -- route, which the fuel log structurally cannot give. **The fuel log records STOPS;
   the trip log records LEGS.** They are different objects and neither substitutes for the other.
4. **OVERNIGHT LOCATIONS** -- the map, and the only source for where a day actually ended.
5. **AN INDEPENDENT ODOMETER READING** per leg -- a second, non-fuel check on the odometer chain,
   which is the spine every derived distance hangs from.

**★★ TASK — transcribe TEMPERATURE from the scans ALREADY READ.** Roughly **140 of 294 fuel rows**
sit under paper that carries a temperature never typed in. **This is the cheapest open data task in
the project** -- the scans are already located, already oriented, already decoded. Do it in the same
pass as the remaining trip-log columns, per the rule above. **Bound the claim by the recording
cut-off, not by the data's convenience.**

**⚠ CONDITIONAL — if anyone is about to write that the wide tires cost N% in fuel.** They may not.
The measured before/after difference has a 95% interval of **-3.7% to +4.9%**, which STRADDLES ZERO
and CONTAINS the 1-3% penalty theory predicts. **The only defensible claim is: a large penalty is
ruled out; a modest one is undetectable at this sample size.** I wrote the stronger version once
and withdrew it in the same turn. **And the wheels were bought for HANDLING, not economy** (Kim,
2026-08-18: narrow city tires let crosswind push the car around; Smart Madness prescribed wide
tires; handling became very good). Measuring them on fuel answers what the fix COST, not whether
it worked.

**TASK — establish when TwoRed temperature recording STOPPED.** Kim, 2026-08-17: it was dropped as
not worth the effort at departure and arrival. **Temperature is therefore a bounded early subset, not
a column running through the record.** Determine the cut-off from the sheets as they arrive; do not
assume one, and do not scope a thermal analysis beyond it. Creamsicle has no temperature at all.

**★★★ CREAMSICLE READ IN FULL 2026-08-19 (via the Drive connector) — here is what is actually in it.**
Three Google-native files at the DRIVE ROOT (`0ANiURP1SB7tSUk9PVA`), so **inside no project folder and
outside the versioned backup** -- Finding 034's last uncovered corner.
- `Final Creamsicle Logs` (Sheet, 30.8 KB, modified 2026-08-17) -- **~110 fuel rows 2021-09-23 to
  2023-09-27** and **~70 trip legs 2021-09-23 to 2024-10-20**.
- `Creamsicle` (Doc, 13.3 KB, modified 2026-08-17) -- the 9-trip narrative.
- `Creamsicle_July_Fuel_Log_update` (Sheet, 1.7 KB) -- **19 rows, CLEAN, and it carries LATITUDE and
  LONGITUDE**, odometer 52,656 -> 55,743.

**Kim's own summary block: start 30,290 (2021-09-23), final 58,987 (2024-10-20), TOTAL 28,697 miles,
1,123 days, 3.08 years, 9,845 miles/year.**

**★★★ CREAMSICLE'S TRIP LOG HAS THE COLUMN TWORED LACKS: `Stop`, plus `Adj_Duration` and `Miles/Hour`.**
**That is the instrument that separates DRIVING from LIVING** -- the exact quantity named as missing when
TwoRed's Las Vegas day read 31.6 mph. **And it has a `Comment` column of REASONS**: *Stopped at Tom's
house*, *Founders Grove*, *Accident delay, hail, rain*, *Hike to slot canyon*, *Monterey Bay Aquarium*,
*Cranes*. **Creamsicle records WHY a day was slow. TwoRed never did.**

**★★ AND FINDING 035 APPLIES TO CREAMSICLE TOO -- KIM ALREADY KNEW.** A cell in the 2021 tab reads *Needs
adj for time zone changes*, and 2023-03-14 St George UT -> Lone Pine CA computes to **76.9 mph** with the
note *Back to Pacific Time*. **His `Miles/Hour` is NOT zone-corrected.** `trip_logs_read.R` already solves
this from the city table; extend the table rather than repairing his sheet.

**★★ THE CANADA UNIT PROBLEM IS ALREADY SOLVED HERE.** BC rows carry `Liters`, `CAD/L` and `CAD` ALONGSIDE
gallons and dollars -- unlike TwoRed's Canada2014 sheet. **Use Creamsicle's layout as the model when
normalising TwoRed's.**

**THE MESS IS REAL BUT MECHANICAL:** `total` / `average` / `min` rows are interleaved INSIDE the data region
between trip segments, and the header row repeats. **A naive read ingests summaries as fill-ups.**

**TASK — clean up `Final Creamsicle Logs`.** Kim, 2026-08-16, his own account: calculations were
put "here and there" so figures could go into the story. Concretely, the fuel tab **interleaves
per-trip totals and averages INSIDE the data region**, so a naive read ingests summary rows as
fill-ups. **The cleanup principle: separate DATA from DERIVED** — raw rows in one tab, computed
summaries generated in R. Do this before the ingestion script, not after.

**★ DO NOT HAND-CLEAN IT.** Those summary rows are Kim's own work and belong in the source. **Sources are
never edited in place; the ingestion skips them programmatically** -- the same architecture as TwoRed.
Hand-cleaning destroys the ability to prove what the source said.

**★★ EXPORT REQUEST, and the reason is BACKUP, not readability.** I can already read all three through the
Drive connector. What they lack is a backed-up copy inside the project. **Ask Kim for: the two Sheets as
.xlsx and the Doc as .md** (NOT .docx -- `docx` is not in `SOURCE_EXT` and would not be mirrored; `md` and
`xlsx` both are), into `Projects/Smart_Car/data/`, with a DATE in each filename. **The Google files remain
the live source of record; the export is a dated snapshot and will drift.** xlsx also beats the connector's
text rendering, which returns `Adj_Duration` as HTML `<span type="duration">` markup in some tabs and plain
text in others -- fragile to parse.

**TASK — build the photo-to-log join.** `images/Creamsicle/` holds 37 geotagged, timestamped
photos. **`DateTimeOriginal` is LOCAL with `OffsetTimeOriginal` carrying the zone, and the logs
are in local clock time — so the join needs no timezone reconstruction.** Validated on the first
record: photo 11:42, first fill-up 11:45 Nixa MO, 2021-09-23. Natural home is `Photo_Locations` /
`timelinesr` per the standing reuse rule.

**TASK — the T2 photo blank.** No photos for LA->Madison, Oct 2021 (the solo run Kim describes as
pushing his daily limits). **NOT an absence claim** — they may be elsewhere or never taken. Ask
Kim before writing that trip without illustration.

**TASK — redesign the chapter architecture.** The one in `proj_Smart_Car.md` was written for one
car and one trip and is now the weakest part of the project. Candidates: the 2x2 role split as the
top frame; the two long-distance cars as parallel spines rather than primary-plus-supplements.

**TASK — settle the Trip 9 fill-up records.** The Creamsicle trip log carries legs through
**2024-10-20** (the delivery run to Wisconsin), but no fill-ups past **2024-07-02** appeared in
the 2026-08-16 read. **This is NOT an absence claim** — the sheet has multiple tabs and the read
may have been partial. Open the Sheet tab by tab before concluding either way (Findings 018-020).

**TASK — check `TwoRed_fuel` (the live Sheet) before topping up the TwoRed log.** It is a
DIFFERENT and richer record than the exported `TwoRed_fuel_June_2014.xlsx`: cumulative cost,
$/mile, MPG-last-5, and **ambient temperature in the Notes** ("64F @ 2:25PM"), plus a trip tab
with start/end temperatures and odometers. Its own summary block reads 141 fill-ups / 34,098
miles, so it looks DEEPER on the early years rather than LONGER. Read it before writing ingestion.

**TASK — read `Projects\Photo_Mapping\Fuel_Analysis.Rmd` (2022) before writing new code.** It
predates this project and was written against the fuel data. Kim's standing reuse rule applies.

**✓ CLOSED 2026-08-16 — ADJUDICATED BY KIM.** He is content with the Origin Story as written:
it gives away neither the person nor the condition, which he judges within the spirit of
confidentiality. **Do not re-raise this and do not re-derive the detail.** The 2026-08-12
conditional stands for any FUTURE text; this specific draft is cleared.

_Superseded (raised same day):_ **★ CONDITIONAL — the Creamsicle narrative doc is now a PUBLICATION CANDIDATE, so the
not-for-publication line needs Kim's eye, not mine.** The Origin Story describes the caregiving
situation in some detail — two full-time helpers for several months, a clean environment, strict
dietary rules — while never naming the diagnosis. That is further than "bought to help family,
and stops there", and it is **Kim's own drafting**, so it is an editorial call for him and David,
exactly as the 2026-08-12 conditional says. Raised 2026-08-16; NOT acted on.

**TASK — rename `TwoRed_fuel_June_2014.xlsx`.** The Gas Log inside runs to **2017-05-22**,
nearly three years past the date in the filename. Deferred rather than done: renaming a data
file is a forward-pointer change and Kim should confirm the name, not inherit one from me.

**TASK — normalise the State column before claiming any count.** 52 distinct values across
293 fill-ups, against the charter's "49 states and 10 provinces". Some are provinces, and the
`Canada2014` sheet is separate again. One pass with a lookup table when the ingestion script
is written.

**TASK — unit-normalise the Canada2014 sheet.** 24 rows in litres and Canadian dollars, in a
file otherwise in gallons and US dollars. The charter did not mention this sheet at all.

**TASK — remove the superseded copy at `kimbridges-stories/underway/Smart_car/`.** Kim's
hand: neither the device bridge nor the R bridge deletes. Only after he is satisfied the
`Projects/Smart_Car` copy is good. Nine files, 20.6 MB, verified byte-identical on the copy.

**★ CONDITIONAL — BEFORE ANY CREAMSICLE CHAPTER GOES PUBLIC.** Kim, 2026-08-12:
**the reason that car was bought is NOT FOR PUBLICATION.** It was purchased so the family
could help Nancy's brother David through a **double lung transplant**; the car was later sold
to David. That is a third party's medical history. It is recorded here, once, so a future
session understands why a fourth Smart appeared and does not go digging for the reason.
**The public text says the car was bought to help family, and stops there.** Do not
paraphrase toward the detail and do not use it as a chapter hook. If it ever goes in, that is
Kim and David's decision together, not an editorial one.

**CONDITIONAL — if any Smart_Car output is about to be named `bordeaux`.** **NO.** Two
published stories already hold `/stories/bordeaux` and `/stories/bordeaux-2` (the wine
booklets). Rule adopted 2026-08-12: the car keeps its name in PROSE, but no slug,
filename, figure, data file or deploy path may take a `bordeaux*` form. A deploy that
shadowed a live story is exactly the failure this prevents, and folder/slug/name drift is
already a known root cause — `priorities.md` item 3.5.

**CONDITIONAL — if anyone proposes embedding the Arctic Circle Challenge as a chapter.** The
answer is already decided: NO. Kim ruled 2026-08-12 that it is cross-referenced, never
re-told. It is a published story (77 pp) at `/stories/the-arctic-circle-challenge.html`;
embedding it would put identical content at two URLs and make the generated works register
misreport what is published where. The charter's Chapter 5 said to embed it by iframe —
**that charter is the likely source of the proposal, and it is superseded.** Use its DATA in
the analysis chapters; link the narrative.

**CONDITIONAL — if the Creamsicle data never turns up.** The fallback is the one-car scope,
which the existing data DOES support: 293 fill-ups, 2010-2017, 52 states/provinces, and a
clean Fourth Crossing subset. **This is a real document either way** — the fleet framing
raises the ceiling, it does not gate the floor. Worth knowing before anyone concludes the
project is dead for want of paperwork.

---

## kimbridges-documents

**TASK — Check `inventory_of_sources.txt` at the site root.**
It was not read during the 2026-07-29 vouchr deploy and may not list the new
document. *Occasion:* the next deploy to this collection.

---

## PKM

**TASK — Add a finding for the CRLF hazard.**
`writeLines()` on Windows rewrites every line ending in a file. Edit CRLF files in
binary and verify the byte delta equals the intended insertion. This bit twice on
2026-07-29 — once caught before committing `session_log.md`, once anticipated when
inserting into `kimbridges-documents/_quarto.yml` (delta exactly 17 bytes).

**TASK — Add a finding for the device-bridge staging hazard.**
To force a genuinely fresh read, delete the local staged copy first; staging alone
may hand back the cached file, which makes a "second opinion" no opinion at all.
And a character count is not a byte count — comparing the two produced a false
report of file instability on 2026-07-29.

**TASK — Collapse Findings 001/005/013/015** into one statement of the
ground-truth rule instead of four partial ones. Already carried in Tier 3.

**TASK — `pkm_backup()` undercounts the tracked total in its commit message.**
Observed 2026-08-11: the message read `Backup refresh: 8 changed of 969 tracked` while
`git_ls()` reported **971** tracked files. The count is taken BEFORE new files are staged,
so it undercounts by exactly the number of additions. Nothing is lost — both new files
(`ideas_three_documents.md`, `logs/priorities_history.md`) were verified present in
`C:/repos/kimbridges-venues/pkm/`. **The hazard is interpretive:** a future session
comparing the message against an expected count would conclude a file had not been backed
up, and that is an absence claim built on a stale number — the shape of Finding 019, and
the reason Finding 028 says verify against the server rather than the report. Fix: count
after staging. *Raised by Claude, 2026-08-11.* *Occasion:* the next edit to pkm_health.R.

---

## kimbridges-stories

Two recovered Exposure stories published 2026-07-31: *Cinque Terre Impressions*
(43 pp) and *The Washington Monument* (23 pp). Both rebuilt in InDesign from the
original photos and text.

**DONE 2026-07-31 — Two errors in the *Cinque Terre Impressions* book.** Both corrected in InDesign and re-exported; verified absent from the staged PDF. Kept here per the rule that closed items keep their reason rather than being deleted.
(1) The Corniglia section reads "Unlike the other Cinque **Terra** villages" — the
place is Cinque **Terre**, spelled correctly everywhere else in the book and in the
title. (2) The travelling-light section describes "a **Zeill** full-frame equivalent
of 28-100 mm lens" — the QX100 carries a **Zeiss** lens. Both are in the InDesign
source, so fixing them means a re-export and re-deploy. *Raised by Claude,
2026-07-31; Kim: "OK the way they are for now."* *Occasion:* any future reason to
reopen `underway/Cinque_Terre/Cinque_Terre.indd` (folder and all files renamed 2026-07-31; the old `Cinque_terra` spelling is gone from the working material).

**DONE 2026-07-31 — Two errors in *The Washington Monument* book.** Both corrected; the Articles-of-Confederation sentence was rewritten (Washington presided in near-silence, and that silence was the instrument of his influence), with an earlier sentence dropped to make room. Verified absent from the staged PDF.
Not requested, logged because they are real. (1) FACTUAL: "Washington argued for a
strong federal government. It was partly due to his influence that the **Articles of
Confederation were ratified**." The 1787 Convention produced the **Constitution**;
the Articles (1781) were what it replaced. (2) "Retirement from the government came
in March, **17978**" — 1797. *Raised by Claude, 2026-07-31.* *Occasion:* same as
above — the next reason to reopen the InDesign file.

---

## kimbridges.com

Kim's personal and professional site, deliberately kept SEPARATE from
kimbridges.info. **It is alive and is being KEPT** — not one of the platforms being
retired. It has no `proj_*.md`; whether it should is an open question, deliberately
not answered here.

**DONE 2026-07-31 — Remove the residual story links.** Kim deleted the remaining "stories" link. Verified same day by fetching kimbridges.com: no reference to quarto.pub, exposure.co or hflip.co anywhere in the page. Kept per the rule that closed items keep their reason.
Kim believed the stories had been cleaned off .com; some links remain. This belongs
with the retirement of the unnecessary sites (Quarto Pub, hflip, Exposure) because
it is the same sweep — making sure no page points at content that is about to move
or disappear. The stories site's own navbar also links to www.kimbridges.com, so the
two sites cross-reference each other. *Raised by Kim, 2026-07-31.* *Occasion:* the
account-deletion pass.

**TASK — General updating of the site.** Kim: "needs some updating, but that's a
lower priority." *Raised by Kim, 2026-07-31.*

---

## Legacy platform links inside the LIVE venues

**Kim unsubscribed from Quarto Pub and Exposure on 2026-07-31.** Verified same day:
`kim.quarto.pub` has **NO DNS A RECORD** while `quartopub.com` resolves and returns
200 — the subdomain is gone, the platform is not, so the failure is proved rather
than inferred (the discipline of Finding 020). Exposure returns 403 to programmatic
clients as it always has, so its state cannot be read from outside. **hflip remains
subscribed and live** (200).

**PARTLY DONE 2026-07-31 — Repoint the dead Quarto Pub links inside published documents.** **plainmaps is COMPLETE** (both links repointed, three typos fixed, Tessellations orphan removed, PDF re-rendered 78 pp, deployed and verified live). **STILL OUTSTANDING: `r_basics/index.html` and `using_an_llm/` (2 files)** -- source for those is `Projects/R_Basics` and `Projects/LLM_Creates_R`.
These are being served to readers right now. All of them have a kimbridges-documents
equivalent already live, so the fix is mechanical:

| File (in kimbridges-documents) | Dead link | Should point to |
|---|---|---|
| ~~`plainmaps/index.html`~~ DONE | | |
| ~~`plainmaps/Sitemaps.html`~~ DONE | | |
| `r_basics/index.html` | kim.quarto.pub/sitemaps | /sitemaps/ |
| `using_an_llm/Plainmaps.html` | kim.quarto.pub/plainmaps/ , kim.quarto.pub/ | /plainmaps/ , the docs index |
| `using_an_llm/Resources.html` | kim.quarto.pub , kim.quarto.pub/storylines/ | the docs index , /storylines/ |

Fix at SOURCE and re-render, not in the rendered `.html`. Source exists for
`Projects/plainmaps` and `Projects/R_Basics`; **no source folder was found for
`using_an_llm`** — **FOUND 2026-07-31: the source is `Projects/LLM_Creates_R`; the project publishes under a different name. Recorded in proj_LLM_Creates_R.md.** (Original note: locate it before editing, or the fix will be lost on the next
render. *Raised by Claude, 2026-07-31.*

**DONE 2026-08-02 — Two hflip links in the Gallery Catalog.** Both repointed to the
in-house PDF viewer that `gallery.qmd` already uses:
`../viewer.html?pdf=1_Gallery_Catalog.pdf` (`Gallery/viewer.html` defaults to
Two-Page Spread and loads from `pdfs/`, so the "two-page spread" description still
holds — only the vendor name "ISSUU" was dropped, since that was Heyzine's renderer).
Edited at SOURCE (`index.qmd` L27, `Stage.qmd` L5), re-rendered, verified in `_site`.
Backups in `Gallery_Catalog/_backup/*_backup_2026-08-02.qmd`.
**STILL OPEN:** `Gallery_Catalog/_publish.yml` declares
`url: https://kim.quarto.pub/gallery-catalog` — obsolete config, harmless but
misleading.

**DONE 2026-08-02 — Two `kim.quarto.pub/ai-podcasts/` links in the Gallery Catalog.**
Condition met the same day: AI_Podcasts went live at
`https://kimbridges-documents.netlify.app/ai_podcasts/` (verified live before editing,
not after). Both repointed at SOURCE, collections re-rendered, `_site` 98 -> 98 files.
**kimbridges-collections now contains ZERO quarto.pub / hflip / SoundCloud / Exposure
links** — verified across every `.html` in `_site`. Awaiting Kim's drag.

**TRAP — `Gallery/Gallery_Catalog/_output/` is stale and is NOT the deploy source.**
Proved 2026-08-02: `_output/Podcast.html` is dated 2025-04-09 and stamped
`quarto-1.5.56`, while the live `_site/Gallery/Gallery_Catalog/*.html` is dated
2026-07-26 and stamped `quarto-1.8.27` with the parent Collections navbar and
`../../site_libs/`. The nested book `_quarto.yml` (`type: book`, `output-dir: _output`)
is vestigial — the PARENT collections website render walks into the folder and renders
the six chapters as ordinary website pages straight into `_site`. **Deploy chain is:
edit the .qmd → `quarto::quarto_render(input = "G:/My Drive/kimbridges-collections")`
→ drag `_site`.** There is NO copy step from `_output`; copying from it would push
15-month-old pages. Same shape applies to `Jones/Jones_analysis/_quarto.yml`.
*Raised by Claude, 2026-08-02.*

**Note.** Kim already knows about pointers on kimbridges.com and will handle those
separately (see the kimbridges.com section). THESE are different: they are inside
his own published venues, and he had not been told about them.

**TASK — Unify the API-use descriptions while doing the repointing.**
Raised by Kim, 2026-07-31: the descriptions of API use are likely inconsistent
across the documents that discuss it, and the link-repointing pass touches those same
files. Doing both at once avoids a second render-and-deploy cycle. Candidates:
`using_an_llm` (= Projects/LLM_Creates_R), `r_api` / proj_LLM_API_R, proj_accessOAI,
and the AI_Microscope appendix, which describes keys-on-the-server. *Occasion:* the
link-repointing pass. **Kim's standing instruction: these links get CORRECTED, not
ignored.**

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

## Orphan cover images in kimbridges-stories — found 2026-08-02

`images/*.jpg` with no matching `pdfs/*.pdf` and no story page. Each is an intake that
was started and abandoned. Found only because `2023_Japan_Story.jpg` turned out to be
already staged when that story was published.

| cover | status |
|---|---|
| ~~`2023_Japan_Story`~~ | **RESOLVED 2026-08-02** — published as `japan-fall-2023` |
| `LLM_Examples` | rescued to `Projects/LLM_Examples/`; going to documents instead |
| `Catalog` | presumably the Gallery Catalog, which lives in collections — likely a stray |
| ~~`Ranunculus_Impressions`~~ | **CLOSED 2026-08-11 (Kim) -- a DUPLICATE.** The real stories are live as `ranunculus-at-flower-fields` and `ranunculus-asiaticus-variability`. Stray cover; not a missing story. |
| `Selective_Focus` | **SOURCE FOUND 2026-08-11 -- `underway/Selective_Focus/Selective_Focus.pdf`** (2.9 MB, 2026-04-17), cover already in `images/`. Unpublished. **HIGH PRIORITY (Kim).** Genuinely quick. |
| `Smart_Car` | **SOURCE FOUND 2026-08-11 -- and it is NOT a story.** `underway/Smart_car/` holds nine files incl. a full project charter (`README.md`, 2026-05-08): *TwoRed 75,000 Miles Celebration*, a five-chapter reproducible Quarto book. **HIGH PRIORITY (Kim), but needs re-filing as a PROJECT** -- no `proj_*.md`, no index row. |

The last three are the interesting ones: a cover image means Kim once had a story in
mind and got far enough to choose the picture. Ask him what they were before assuming
they are strays. *Raised by Claude, 2026-08-02.*

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

## Consolidation migration — DELIVERED 2026-08-03

**github.com/kimbridges/kimbridges-venues**: 882 files (197 venue source, 683 project
source across 49 projects), verified from GitHub's trees API. See proj_PKM.md and
Findings 027/028.

**DONE 2026-08-03 — the refresh cadence is settled: Mechanism 5, item 12.**
`pkm_backup()` refreshes all five venues, every project and `Projects_Index`, runs
`pkm_secret_scan()` as a hard gate, commits, pushes, and verifies against the SERVER
rather than the return value. It now runs at every session close beside `pkm_health()`,
and is on `pkm_card.md`. Kim can also run it alone at any time; it is safe when nothing
has changed and says so.

*Why this answer:* the alternatives were a scheduled task (needs the machine on and the
R server up — a backup that silently stops running is the exact failure being guarded
against) or on-demand (depends on remembering, which is what Mechanism 5 exists to
replace). Attaching it to an existing trigger costs nothing and inherits a habit that
already holds.

**TASK — six repo/clone mismatches** (open since 2026-07-30). accessOAI, geContour,
milestones and plainmaps have a public GitHub repo but no local clone; listsr and
Temperature_Patterns have a local clone but no public repo. **Confirm listsr is not
simply PRIVATE before concluding it is missing** — Finding 019.

**TASK — audit the rest of Drive for credentials.** `pkm_secret_scan()` covers the
mirror (source extensions only). It has NOT been run across all of `Projects/` — the
first attempt without an extension filter hung the bridge and Kim had to interrupt R.
Now filtered, but still slow over Drive Stream, so run it per-project in batches rather
than all at once. `.Renviron` legitimately holds keys and is not a finding.

**CLOSED 2026-08-03 — the Anthropic key is revoked.** Kim deleted the April-2024
`sk-ant-` key found in `Projects/LLM_API_R/Claude_API.qmd`. It was never published,
so exposure was limited to his own disk, and it is now dead regardless. Source is
clean; `pkm_secret_scan()` gates every commit; original at `LLM_API_R/_backup/`.

**DONE 2026-08-03 — the PKM itself is now mirrored.** `Projects_Index` was NOT in the
first migration: the venues and project source went to GitHub, but not the index that
makes them findable. Added as `pkm/` — 87 files, 2.0 MB, including `pkm_health.R`,
every `proj_*.md`, `pkm_findings.md`, the session log and its archive. Repo now carries
**969 blobs**. The artifacts could be re-read from their own files; nothing else records
why a decision was made or which mistakes have already been paid for once.
