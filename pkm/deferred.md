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

### ✓✓✓✓ CLOSED 2026-09-01 — the geocoding gap is gone. BOTH CARS AT 100%

Kim supplied a Google Maps API key (already in his `.Renviron` as `GGMAP_GOOGLE_API_KEY`). ⚠ **He asked for "reverse geocode"; the job needed FORWARD geocoding** (reverse is coordinates -> address). Corrected and used the address endpoint.

**116 cities requested, 116 returned, 0 failures.** TwoRed **294/294**, Creamsicle **173/173**, 352 of 352 distinct cities. **`figures/stops_twored.png` and `figures/stops_creamsicle.png` both exist; Creamsicle's has never existed before.**

⛔ **THE API IS CALLED ONCE, IN A SCRATCH RUN.** Results live in `data/geocode_google_2026-09-01.csv` (city_logged, state, city_resolved, lat, lon, location_type, formatted, audit, spelling_corrected, source, retrieved). **`stops_data()` reads that file and never touches the network** -- same rule as `na_states.rds`. ⛔ The key was never echoed and the output file was checked against it before saving.

### ★★★ THE AUDIT IS THE PART TO KEEP — a geocoder is a source like any other

**Every one of the 116 was tested by point-in-polygon against `data/na_states.rds`:** 111 inside the state the log claims, **5 coastal centroids up to 1,825 m outside a 3 km-simplified boundary whose nearest polygon was still correct** (recorded `PASS (coastal)`, not quietly waved through), **0 mismatches.**

★★ **The record already carried a redundant field to check the geocoder against: the state column.** Nothing was accepted on the API's word. ⛔ **Any future external data source gets the same treatment: find the field the record can check it with, and check it.**

### ★★★ 14 FREE GAZETTEER ERRATA — the geocoder is also a spelling checker

Google resolved 14 logged spellings to their real names: **Elroy->Eloy, Quartzite->Quartzsite, Gothensburg->Gothenburg, Alamogaordo->Alamogordo, Amagosa->Amargosa Valley, Anacrtes->Anacortes, Spanish Forks->Spanish Fork, Ft Bragg->Fort Bragg, Ft. Oglethorpe->Fort Oglethorpe, Mt. Vernon->Mount Vernon, Bainbridge Is->Bainbridge Island, Lake Havasu->Lake Havasu City, Big Oak Flat->Groveland-Big Oak Flat, Dekorra.**

**`TwoRed_gazetteer_errata.csv` grew from 8 rows to 22**, each with `basis = "Google Geocoding API, audited by point-in-polygon"` and the formatted address as evidence. ★★★ **Same shape as the scanning experiment in @sec-paper: an instrument brought in for one job audits the data on its way past.** ⚠ These are transcription errors in the fuel log that six other audit instruments never saw, **because none of them tests a place NAME against the world.**

### ⛔ RULING WANTED — where do the two stop maps go?

`figures/stops_twored.png` + `figures/stops_creamsicle.png`. ★★ **The two shapes are completely different**: TwoRed is four transcontinental strings plus the Alaska Highway and the Maritimes; **Creamsicle is a Pacific coast run and two Midwest corridors.** @sec-car-cost said the CAR was a constant, the choropleth said the DRIVER was, **and these say the TRIPS were not.**

**Candidates:** (a) @sec-long-days, where cadence is already the subject and the 300-mile day is argued from tables alone; (b) ch.13 beside the choropleth, as extent-then-cadence; (c) both, one panel each. ⛔ **Not placed in any chapter yet.**

### ✓✓✓✓ SOLVED 2026-09-01 — Google Geocoding API; both cars at 100%. See the CLOSED entry above

Kim asked for the fuel-stop map **for both cars** and noted *"I've never made a Creamsicle map."* ⛔ **TwoRed is built (87.1% of fills placed). Creamsicle is at 39.9% and was NOT shipped**, because a 40% map renders real driving as sparse.

**Everything offline has been tried and measured:**

| source | TwoRed | Creamsicle |
|---|---|---|
| project gazetteer alone | 78.2% | 17.3% |
| + `TwoRed_gazetteer_errata.csv` coords, keyed both ways | **87.1%** | 39.9% |
| + `maps::us.cities` / `canada.cities` / `world.cities` | (included above) | (included above) |
| `geonamescache` (container test) | -- | 3,914 US+CA cities, **2 of 16 sample towns** |

**The unplaced are ordinary small towns**: Nixa MO, Gothenburg NE, Colby KS, Wagon Mound NM, Anamosa IA, Walsenburg CO, Shelbina MO, Questa NM, Firebaugh CA.

★★★ **THE LEAD.** The ch.13 scaffold recorded: *"The Jul-2024 Creamsicle update already carries lat/long -- start there rather than geocoding from scratch."* **That file is not in `data/` and `Creamsicle_fuel_clean.csv` has no coordinate columns.** It is very likely one of the Google-native Creamsicle assets (Finding: the Creamsicle data was never a file). **One question to Kim may deliver all 111.**

⚠ Failing that, the fallback is a bulk gazetteer (GeoNames US.txt/CA.txt) ingested ONCE into `All_gas_stations_csv.csv`. ⛔ **Never from inside a figure function.**

### ✓✓✓ CLOSED 2026-09-01 — PEI is an ELEVENTH province and my substitution hypothesis was wrong

I proposed the PKM had swapped PEI for BC while counting to ten. **Both are real: 10 provinces have a FILL, 11 were REACHED.** Confederation Bridge in, Pictou ferry out, no tank bought on the island. **VISA: Harbour Motel, Murray Harbour PE, 2014-05-27; Bay Ferries booking from Charlottetown.** ⚠ **The ferry charge dates 2014-03-31 and is the BOOKING, not the crossing** -- do not read it as a date of presence.

★ **Method note on my own error:** I had two hypotheses (PEI real, or PEI a slip for BC) and no way to choose, so I asked rather than guessed. **That was right, and the answer was a third option I had not listed: the count was UNDER.** ⛔ *When two hypotheses both explain a discrepancy, the answer is often neither.*

### ★★★ PHOTOGRAPHS NOW IN THE BOOK — and one of them is an ending (2026-09-01)

In `book/images/TwoRed/`:

- **`twored_alberta_last.jpg`** -- ★★★★ TwoRed at the WELCOME TO ALBERTA sign. **Kim: *"the last of the states/provinces. Mission complete!"*** ⛔ **This is a documented COMPLETION and the book currently has no picture of one.** Strong candidate for **ch.14 or the Afterword**, as the counterpart to the Foreword's two cars nose to nose in the Honolulu garage.
- **`twored_florida_signs.jpg`** and **`twored_florida_corner.jpg`** -- ★★★ the intersection and the car at it, **welded by the DEAD END sign visible in both**, a cross-check Kim named himself. ⛔ **Ch.14's Florida sequence: use the PAIR, and say why the pair is stronger than either alone.** Coordinates already on record: 30.983392, -87.571312.
- **`twored_easternmost.jpg`** -- West Quoddy Head, Kim and Nancy, the EASTERNMOST POINT sign. ★ **A HAWAII decal is in the rear window** -- a Hawaii car at the far end of the continent, in one frame.

⚠ The two Florida files are 8.2 MB and 4.6 MB. **Downsample before they go into a rendered book**; `pdftools`/`magick` in the R session, not by hand.

### ★★★ TASK — BUILD THE FUEL-STOP POINT MAP. It shows the one thing a choropleth cannot (2026-09-01)

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

### ✓✓✓ RULED 2026-09-01 — the driving map is about TRAVEL, not transactions

Kim: *"visually, the 'reached, never a fill' is the thing that draws your eye. At first glance, it seems to be the intent of the map. I really don't think that not getting a fill is all that important. How about making the focus as 'Traveled to these places'?"*

**He is right and the fix was structural, not cosmetic.** ⛔ **Whether a state got a fill is an accident of where the tanks ran out.** Rebuilt: two fills, everything reached is filled, no outlines and no labels. **The six no-fill states moved to `@tbl-silent`.** Opening section retitled **Where the cars went**; the honest turn now comes after the figure rather than through it (*"It isn't, however, a picture of the fuel log"*).

★★ **Side effect worth knowing: the rebuild moved British Columbia into the shared class.** On fills the cars shared no Canadian ground; on travel they share BC. **The sentence asserting no shared Canadian ground is gone.**

★★★ **GENERAL RULE FOR THIS BOOK'S FIGURES: the visually dominant element must be the subject.** I encoded the exception in the heaviest ink on the page and it read as the thesis. **Ask of every figure: if a reader saw only the shapes and no words, what would they think it was about?**

### ★★★ THE CARD STATEMENTS ARE A STANDING INSTRUMENT — reach for them FIRST (2026-09-01)

Vermont now has three witnesses: the trip log (Hartland), **an AMEX line (QUECHEE RESTAURANT, Quechee VT, 2014-05-19, $220.63)**, and Kim's account. ★★ *"The card statement caught the dinner because dinner is a thing you stop for. The fuel log caught nothing because fuel was not."*

⚠ **This is the THIRD time the card statements have produced evidence the fuel log could not.** They are independent of the paper sheets, they were kept for someone else's reasons, and **they sample on "you paid for something" rather than "you bought fuel"** -- a far wider trigger. ⛔ **For any remaining question of presence, query the statements before declaring a silence.**

### ✓✓✓ CLOSED 2026-09-01 BY KIM — British Columbia, and it was testimony not geometry

**TwoRed reached BC twice and never filled there.** *"I got off the Alaska Marine Highway in Haines. The only road north goes through (wait for it ....) BC before entering the Yukon Territory. No need to get fuel on that short stretch. For the record, but not something easily verified, I also clipped the corner of BC after crossing the Canadian Plains."*

★ My Alberta-does-not-border-Yukon argument was sound and it was the long way round; **the ferry landfall at Haines was already in @sec-marine-highway and I had not connected it.** ⚠ The second crossing (the plains corner) Kim himself flags as not easily verified -- **carried in ch.13 as his account, not as a derived fact.**

### ⛔ ASK KIM FOR THE FLORIDA PHOTOGRAPH — ch.14 wants it and he has offered (2026-09-01)

Finding 045 established the geotagged **corner** photo (30.983392, -87.571312, 1.07 mi inside FL). **Kim has now found a photo of TWORED ITSELF at that same intersection.** *"I'd dig it out, but that's kinda a lot of work at this hour. But if I need it, I can find it."*

★★ **The second photo is strictly stronger: the first places the CORNER, the second places the CAR at the corner.** ⛔ **Ch.14's Florida sequence should ask for it before drafting** -- it is the closing chapter's best documentary object and it would pair with `@fig-sheet` as the book's second photograph. Target: `images/TwoRed/twored_florida_corner.jpg` (the scaffold already names the slot).

### ✓ SUPERSEDED 2026-09-01 — PEI settled by VISA; see the CLOSED entry above

`logs/proj_Smart_Car_log.md` records the 2026-08 charter check as: *"The provinces are exactly right: Alberta, Manitoba, New Brunswick, Newfoundland, Nova Scotia, Ontario, PEI, Quebec, Saskatchewan, Yukon -- ten, all present."*

**But PEI appears in no fuel row and no trip-log city.** Derived tonight, the ten provinces WITH a fill are **AB BC MB NB NL NS ON QC SK YT** -- which *includes BC* (Creamsicle, Vancouver Island) and *excludes PE*. TwoRed's own nine are AB MB NB NL NS ON QC SK YT.

**Three possibilities:** (a) PEI was settled from a source not yet found; (b) that line silently substituted PEI for BC while counting to ten; (c) Kim drove the Confederation Bridge and no instrument caught it, which would make PEI the eleventh jurisdiction and a province-level twin of the six silent states.

⛔ **NOT resolved and NOT printed either way.** Ch.13 says only that ten provinces have a fill, which is derived and true. **One question to Kim settles it: did TwoRed cross to Prince Edward Island?** He was in NB, NS and NL on that trip, so the bridge is entirely plausible.

### ★★★ STANDING RULE FROM FINDING 052 — findings first, then numbers

**Before drafting any chapter, grep `pkm_findings.md` AND `proj_Smart_Car.md` for its subject. Then re-derive the arithmetic.** ⛔ **Re-derivation is a check on transcription, never a substitute for reading.** Ch.13 contradicted three settled findings in print because I applied Finding 051 without doing this. ★ **Two sources disagreeing about a fact means READ MORE, not derive fresh.**

### ⚠ TASK — a figure the author has not seen is not a delivered figure (2026-09-01)

I rendered both ch.13 maps, inspected them myself, wrote captions for them and described them in a report -- **and never put the PNGs in front of Kim.** He had to ask: *"Now, about the map(s). Where are they?"*

**Rule: every figure goes to Kim as an image in the same turn it is finished.** Verifying it myself satisfies the caption rule (view the PNG before shipping the caption); **it does not satisfy the author.**

### ✓ SUPERSEDED 2026-09-01 — Kim closed this by testimony; see the CLOSED entry above

**TwoRed has no BC fuel fill and no BC city in its trip log.** It does have **Lethbridge AB** and **Destruction Bay YT**. ★★ **Alberta does not border Yukon.** A road journey between them must cross British Columbia or the Northwest Territories, and the Alaska Highway route runs through BC.

**This is exactly @sec-audit's Delaware argument** -- a route that cannot be completed without entering a state the record never names. ⛔ **NOT asserted in ch.13.** The chapter says only that TwoRed *"never once bought fuel in British Columbia, which is its own small puzzle and one I'll leave sitting there."*

**To settle it, one of:** (a) Kim remembers the route; (b) a trip-log leg between AB and YT whose distance rules out the NWT alternative; (c) a scan page naming a BC town. **Worth doing** -- it would make BC a second recovered jurisdiction and strengthen the geography instrument, and Creamsicle's 3 Vancouver Island fills mean the map already shows BC as filled, so nothing printed is wrong either way.

⚠ Note the asymmetry it would create: **the two cars currently share NO Canadian ground at all**, which is printed in ch.13. If TwoRed is placed in BC by inference, that sentence stays true (it is about FILLS) but wants a footnote.

### ⚠⚠⚠ TASK — the Finding 050 sweep must cover R STRING LITERALS, not just prose (2026-09-01)

`SILENT_STATES` in `R/constellations_data.R` shipped **`"...photographed in ch.9"`** and **`"...(ch.10)"`** into a printed table. **Hardcoded chapter numbers, inside code, invisible to any prose sweep, caught only by reading the rendered HTML.**

★★ **This is the second defect class to hide in the same place.** Em dashes did it first, in `fig_cost.R` panel titles. **The standing pre-ship check must now grep `R/` for BOTH**: em dashes, and `ch.N` / `chapter N` / `Chapter N`. Swept 2026-09-01: clean.

### ⛔ DO NOT REINTRODUCE A LIVE `ne_states()` CALL — it hung the R session (2026-09-01)

`rnaturalearth::ne_states()` **blocked the R bridge for several minutes** on what looked like a network fetch; four consecutive `execute_r` calls timed out at 60s before the session came back. The geometry is now **cached at `book/data/na_states.rds`** (137 KB, simplified to a 3 km tolerance, 51 US + 13 CA features, Alaska included, all geometries valid).

**`fig_driving()` reads the RDS and never calls the network.** ⛔ If the map ever needs rebuilding from source, do it in a scratch session and re-cache -- **never inside a figure function that a book render will call.**

### ✓ MEASURED 2026-09-01 — the gazetteer is a TwoRed instrument and does not generalise

| | placed | of |
|---|---|---|
| TwoRed fills, project gazetteer alone | **78.2%** | 294 |
| Creamsicle fills, project gazetteer alone | **17.3%** | 173 |
| TwoRed, + `maps::us.cities` + `canada.cities` | **84.7%** | 294 |
| Creamsicle, + the same | **39.9%** | 173 |

**121 distinct cities remain unplaced.** ★★ **This is why ch.13's driving map is a state-level choropleth rather than a point scatter:** a point map drawn from this would render Creamsicle as sparse because of a gazetteer gap, not because of anything the car did. ⚠ **If a future chapter wants a route or point map, the gazetteer needs extending to Creamsicle first** -- that is the blocking task, not the drawing.

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

### ✓ MEASURED 2026-09-01 — "run the data early" is a RESULT, not advice

Walking the 35 commented legs in date order: **6 of the 7 categories appear in the first TEN comments; all 7 by the 20th, with 15 legs still to come.** ★★ **The structured column Kim wishes he had was derivable from the first ten rows of free text, and he had six more years in which to add it.** Derived in `day_data.R` as `cat_at10` / `cat_all_by` / `cat_total`, so the sentence cannot go stale.

★ **This also generalises past the car**: it is the empirical case for the PKM/briefing_book friction entry already open above. **A free-text field saturates its own category structure fast.** Worth carrying wherever that lesson lands.

### ✓✓✓ CH.12 DRAFTED 2026-09-01 — and the scaffold drifted AGAIN (two more, seven in one day)

**Re-derived before drafting, per the standing rule. Two more wrong:**

| scaffold said | truth |
|---|---|
| median leg 251 mi (TwoRed), 166 (Creamsicle) | **305 (139 legs) and 273.7 (84 timed legs)** |
| log distance ~95% of odometer miles | **median ratio 1.00** |

**Third scaffold running to drift at roughly half its numbers.** Everything printed in ch.12 now derives from `R/day_data.R` at build time, including all six p-values.

**★★★ THE CHAPTER'S RESULT, for anyone re-reading it later:** Creamsicle's free-text `comment` box was optional and unstructured; Kim filled it on **35 of 84 legs by whim**, and those legs hold **73.4% of all stopped time** (p = 2.4e-07). The three-way test is what makes it a finding rather than a curiosity: **same miles (272 vs 276, p = 0.97), different GROSS speed (38.1 vs 49.4, p = 0.002), same NET speed (47.3 vs 51.6, p = 0.36).** Same distance, same driving, and the entire difference is time the car stood still. **62% of the apparent speed gap is not speed.**

### ⚠ OPEN — the ch.12 category grouping is MINE and has never been put to Kim (2026-09-01)

`DAY_CATS` in `R/day_data.R` sorts 35 free-text comments into seven groups, and **a comment naming two things is filed under the FIRST match in the stated order** ("Ferry, Costco" -> the ferry, not an errand). The chapter's table caption says the grouping is mine and invites disagreement, and the figure prints every comment verbatim so a reader can regroup them. **But Kim wrote those comments and has not been asked whether the grouping matches what he meant.** Worth one question when he next reads ch.12. Nothing depends on it: the three-way test does not use the categories at all.

### ⚠ TASK — two figure captions have now been WRONG about their own figure (2026-09-01)

`fig-day`'s caption said "driving on the left, stopped time on the right" and the figure draws them the other way round. Caught only by rendering the PNG and looking at it. **`fig-cost` had a similar miss earlier (a clipped point at 176c).** Both were written from the code rather than from the picture. **Rule: view the PNG before shipping the caption, every figure, no exceptions.** Cheap check, and the code cannot tell you it is wrong.

### ⚠ NOTE — Creamsicle's stopped-time column MISSES stops that the comment column catches (2026-09-01)

`2023-09-24 Campbell River -> Vancouver, 101 mi, 7 h`, comment **"Ferry, park, shop"**, stopped-time cell **zero**. The column designed for the job recorded nothing; the optional one recorded the day. Three other zero-stop commented legs are time-zone notes (*TimeZone +1*, *To Mountain Time*, *Back to Pacific Time*) -- **the comment column doing a second job entirely**, and a class of false positive that announces itself. **Both are in the chapter as the limit of the instrument.** ⛔ Do not "clean" these four rows: they are the evidence.

### ✓ RE-DERIVED 2026-09-01 — three MORE ch.11 scaffold drifts (six in one day)

"Lifetime 39.44 MPG" **reproduces from nothing**: the three defensible figures are mean-of-tanks 39.53, median 39.12, and **total miles / total gallons 39.25**, and the chapter says which it uses and why. Creamsicle median is **40.52**, not 40.59. Wide-tyre interval is **+2.8% [-0.9, +6.5]**, not -3.7 to +4.9. **All computed in `cost_data()` now.**

⚠ **Every remaining scaffold still carries hand-copied numbers.** `a_day_in_a_smart`, `two_constellations` and `what_the_record_cannot_say` have not been re-derived. **Do it as each is drafted; the observed drift rate is roughly half the figures.**

### ⚠ OPEN — Port Angeles is a FOURTH Creamsicle pump-identity failure with no erratum (2026-09-01)

`3.993 x 5.399 = 21.558` against **21.57** recorded: **1.17c over its 0.97c bound.** Outside by two tenths of a cent. **Ch.10 prints it as the place the instrument runs out, not as an error.** ⚠ **Do not raise an erratum unless a card or receipt settles it** -- an instrument used past its floor manufactures findings.

### ✓ RE-DERIVED 2026-09-01 — three ch.10 scaffold numbers had drifted (Finding 051 working as intended)

TwoRed "277 of 294" is the **under-half-a-cent** count (281 under a cent) and never stated its tolerance. Creamsicle "143 of 170" is really **163 of 169**. "3 Creamsicle errata, all resolved" is really **5, of which C01-C03 remain HYPOTHESIS.** **All corrected in the chapter, which computes them.** ★ **One day after the rule was written, and this is the ordinary rate. Keep re-deriving.**

### ★★★ CARRY THE FRICTION LESSON OUT OF SMART_CAR (opened 2026-09-01)

Kim's scanning result -- *data has no value while it sits in a log; moving it into an analysis environment is what gives it value; scanning removes the friction* -- **is a claim about archives generally, and Kim's own PKM is full of paper-era material.** It also sits directly on `briefing_book`'s friction spine. **Raise it when the PKM or briefing_book is the focus, not while Smart_Car is.** ⚠ **Do not print a scanning accuracy rate anywhere** -- there is no measured control set.

### ⚠ TASK — the "22 scans" figure is wrong wherever it appears (2026-09-01)

The folder holds **20 PDFs, 67 pages**, derived at build time by `paper_data()`. **"22 scans" is a batch count** from the delivery sessions and it recurs across `proj_Smart_Car.md`, the log and older focus blocks. **Ch.9 prints the derived numbers.** Not urgent; fix the PKM occurrences the next time that file is touched, and **do not fix them by hand in the book -- the book computes them.**

### ✓✓✓ CLOSED 2026-09-01 — Finding 033 re-run, confirmed, and SHARPENED

Live in `book/R/paper_data.R` off the source workbook: **0/8 repairs at 15.6% against 0% for three control pairs over 166 substitutions.** Original was 13.3% with one stray control hit that did not recur. ⚠ **Two things to carry:** substitute on the value AS RECORDED, never a zero-padded rendering (the mirror direction drops from 3 repairs to 1); and the mirror still repairs one row (Deming 20.05->20.85), so **the finding is the asymmetry, never an individual row.**

### ★★★ STANDING RULE FROM FINDING 051 — keep the generator, not the result

A number that has been summarised once is a **claim** about a number. **Before any figure is printed, run the thing that produced it.** The ch.9 scaffold's *4 of 44* was a faithful-at-the-time paraphrase that became unrecoverable, and it was the version queued for print. **Applies to every remaining scaffold in this book** -- each one carries figures copied out of the log by hand. **Occasion: when each chapter is drafted, re-derive its scaffold numbers rather than trusting them.**

### ✓✓✓ CLOSED 2026-09-01 — HOW the cross-reference fix went, and the one part left open

**Both references flagged as inferred are now certain, by a second route.** Reading the target chapters gives *Chapter 9* = `knowing_a_number_is_wrong` and *Chapter 13* = `what_the_record_cannot_say` -- **and then all ten resolve cleanly under the project's own scheme.** ★★ **Ten references across six files agreeing on one scheme is not a guess**, and that is what promoted two inferences to two facts. **Nobody needs to re-derive this.**

**★★★ THE ROOT: `index.qmd` (Foreword) and `afterword.qmd` (Afterword) were being NUMBERED.** Both are now `{.unnumbered}`, and **the printed numbering runs 1-14 exactly as the project has always spoken it.** The old prose was never wrong about which chapter it meant; **the renderer and the project simply disagreed about whether front matter is a chapter, and nobody had settled it.** That question is now settled in the files themselves.

**Mechanism:** `{#sec-...}` on every heading; `@sec-name` at a sentence start, `chapter -@sec-name` mid-sentence. Verified in the rendered HTML, 0 unresolved across 16 chapters, 0 hardcoded numbers anywhere.

### ⚠ STILL OPEN, DELIBERATELY — positional chapter phrases

*"the next chapter"*, *"the driving in the last two chapters"*, *"a later car in this fleet"*. **All correct today; all break silently on a reorder**, and none of them can be generated the way a number can. **Not worth converting** -- the prose would get worse. **The rule instead: any reorder of `_quarto.yml` means re-reading these four lines.** They live in `small_cars.qmd` (2), `the_marine_highway.qmd` (1) and `the_roads.qmd` (1).

### ✓✓✓ CH.8 DRAFTED 2026-09-01 — and it became a TRIPLE

The scaffold had two cases (prairie stress, tree-tunnel tedium). **The Nebraska frontage road made it three, and the third is the one that lands**, because pleasure is the least expected thing for a record to be blind to. ★★ **Creamsicle's stopped-time column turned the whole argument from an assertion into a measurement** -- 84 legs, gross 43.5 vs net 51.0, **a 7.5 mph gap that sizes exactly what a two-point log averages away.** ⚠ **The `net_mph` on the Cranes row is 100.6 and is an artifact** of quarter-hour stop rounding on a 50-mile day; **the chapter cites the stopped hours and the gross figure, never that net.** Do not print it.

### TASK — SPLIT `proj_Smart_Car.md` (57.2 KB against a 45 KB budget)

`pkm_health()` has flagged it splittable for several sessions and it grew again on 2026-08-31. **The tail is the natural cut:** roughly thirty dated `## ★★★` sections from 2026-08-16 onward are narrative-of-the-work, not living status, and most already say *full write-up in the log*. **Use `split_tail()` from `pkm_health.R`** -- snapshot-first, losslessness verified, restores on failure, and `dry_run = TRUE` by default.

**Occasion: the next session that opens Smart_Car and is not mid-chapter.** Do it before the file crosses 60 KB.

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

### ✓✓✓ RULED 2026-08-31 — the fuel-economy account splits FOUR WAYS, and two of the four are done

- **Design argument** (boxy, pushes wind, economy was never the priority; safety / small spaces / gear were) -> **`small_cars.qmd`, WRITTEN** as a new section *What it was designed to be good at*, placed before *Why a Smart*. Ends on the line the later chapters need: **every fuel figure in the book comes from a car optimised for something else.**
- **Truck-following** -- a safety choice he also read as an economy choice, plus the flip side (80 mph Texas limits, and not wanting them) -> **`is_it_safe.qmd`, WRITTEN** as *Following the trucks*, before *Attention is a component of safety too*. **References the cost chapter BY NAME, not by number** (see the task above).
- **The Nebraska frontage road** -> `what_driving_cost.qmd` scaffold, with the dated day and both caveats.
- **Costco, premium fuel, station choice, and the speed signal** -> `what_the_car_cost.qmd` scaffold.

### ⛔ CLOSED BY RULING 2026-08-31 — do NOT compute the Whittier tunnel track gauge

Kim wondered, in the tunnel, whether a narrower-than-average wheelbase would sit right relative to the rails. **I offered to check it against `twored_manual` (front track 50.5 in, rear 54.5) and he declined.** **The fear is the fact.** Answering it thirteen years later replaces his experience with arithmetic, and he never claimed it was a problem. **Do not re-derive this, and do not let a later chapter about the car's dimensions pick it up.**

### TASK — the ferry water distances are KIM'S, not the record's

~1,300 mi Whittier to Bellingham, "a bit over 1,000" Bellingham to Skagway. **Nothing in the fuel or trip log measures water**, which is the chapter's whole point, so these are attributed to him in the text and must stay that way. **If a sourced figure is ever wanted, AMHS publishes route mileages** -- but check whether adding one improves the chapter or just makes it look more precise than the argument needs.

### ✓ SOURCED 2026-08-31 — the cross-gulf route is being retired

Alaska DOT's AMHS route page: *"During the proposed winter 2026/27 schedule AMHS will not be traveling to Yakutat or scheduling 'cross gulf' routes."* **That corroborates Kim from the operator.** ⚠ **His separate claim of a single run in 2026 is NOT sourced** and is written in the chapter as his count. Leave it that way unless he produces a source.

### ✓✓✓ CH.6 DRAFTED 2026-08-31 — and two things about it are worth carrying forward

**1. The group definitions are now IN CODE, not in a log entry.** `ROADS_SOUTH` / `ROADS_APPAL` in `book/R/roads_data.R` reproduce the 2026-08-20 figures exactly (40.3 / 38.0 / p = 0.42). **They had never been written down anywhere** -- the numbers had been quoted for eleven days with no recoverable rule behind them. **Check the other quoted splits for the same gap** before any of them is printed: the Canadian Plains variance test and the ~3 MPG southern deficit both name group sizes and neither names its rule.

**2. `fig_roads()` sets a pattern the remaining figures should follow.** Two questions, ONE shared axis, so the null is visible rather than argued. And **one hue on purpose** where the point is that two things cannot be told apart -- colouring them differently would assert the distinction the figure exists to deny. Worth applying to any later figure about a non-result.

### TASK — the third road term has been described but never placed

*"Nearly straight freeways lined by commerce, billboards and wall-to-wall housing"* -- the thing both the tree tunnel and the rolling hills are a relief from. **It is in the taxonomy and it is not in ch.6**, because Kim has never attached it to a place or a day. Ask only if he raises it; the chapter stands without it and the one-example rule argues against adding a third.

### ✓✓✓ RULED 2026-08-31 — CH.6's SPINE, AND IT IS NOT A TAXONOMY CHAPTER

Kim: *"The architects of the Interstate system brought a kind of uniformity: excellent highways. That was very important. Nature gives these highways character. It's equally important."*

**Two layers, both required.** The engineered layer is uniform by design and the uniformity is the achievement -- and it is what made a 300-mile day possible at all, which is how ch.6 attaches to ch.5's baseline. The natural layer is what the engineering cannot flatten.

**The argument is FOR VARIETY, not against a road** (*"if you've seen one, you've seen them all"*), which is Theme 10 arriving from a new direction. **⛔ NO BLAME: Alabama is not at fault and the text must not imply it** -- *"that's just their combination of vegetation and topography."* Scaffold rebuilt in `book/the_roads.qmd`; nothing is blocking a draft.

### ✓✓✓ RULED 2026-08-31 — the calibration/logistics material is CH.5's BASELINE

Kim: *"the best way to treat this is using the story to establish a baseline for Chapter 5... most often in the early day, the destination was not set. Experience put it at about 300 miles per day. And that distance held. That's why this distance becomes our measure against which we can see exceptions. It isn't the same as for other people. Their constraints are different."*

**Written 2026-08-31 as two new opening sections** (`One route, a hundred miles` / `About three hundred miles`) ahead of the 640, which now lands against a known norm. **The framing is his and it is the statistical one:** the median is the measure, the long days are the variance, and **the measure is personal** -- five constraints produce 305 miles, and the two-driver crossings in the Smart forums had different constraints and a different number. **Closes the "where does it go" question. Do not re-open.**

### ✓✓ ANSWERED 2026-08-31 — TREE TUNNELS: the concept, and ONE stretch named

The TASK asked him to name them rather than have them inferred. **He named I-65 northbound in Alabama, and it is dated: 2014-05-07/08, Penultimate State.** Verbatim account and the fill-level placement are in `logs/proj_Smart_Car_log.md`.

**The definition is a conjunction of three:** trees that block the view, nearly straight, nearly flat. **The western counter-case is part of the definition** -- tree-lined roads out West are not tree tunnels because the trees do not hide the landscape.

**✓ CLOSED WON'T DO 2026-08-31 — no other stretches will be named.** Kim: *"Naming the other places doesn't do any service."* **One example, and it is I-65 north in Alabama.** The candidates the record could offer (Port Allen->Memphis, Atlanta->Murfreesboro, Charleston->Atlanta, Montgomery->Birmingham) are declined, not unresolved. **Reason kept: a second example adds weight without adding argument** -- Kim applying his own subtraction principle to his own chapter. **Do not re-open or re-derive the list.**

### ⚠ ILLUSTRATION, NOT EVIDENCE — the tree-tunnel tank reads 33.67 mpg

Atmore -> Trussville, 229 mi, **33.67 mpg**, the lowest of that week's eight fills against a lifetime mean of 39.53; the next tank, climbing into the Appalachians, reads **42.49**. **One pair, uncontrolled, and it sits inside the southern-deficit signal already ruled unsettleable** (sample closed at 30; Creamsicle has zero southern fills). **Usable only as a coincidence in the record that matches the hypothesised mechanism -- never as support for it.**

### ★★★ TASK — WHICH TRIPS WERE SOLO? (opened 2026-08-31)

Kim's calibration/logistics account says *much of the driving was solo, with Kim in the car and Nancy back in Honolulu*, and that later *Nancy was always on-board*. **The record has no column for who was in the car.** With that one fact per trip, several questions open at once and none of them can be asked without it:

- does the day get longer or shorter when she is aboard?
- do arrival times move? (the remote arrangement had to leave margin for a booking; the in-car one did not)
- the 2013 Bellingham day is the transition case in miniature -- she flew in for part of a trip.

**Ask for the trip-level answer only** (solo / both), not day-level. Occasion: before ch.7 or any chapter that turns on the day length.

### ★★ TASK — what were the actual tools of the logistics arrangement? (opened 2026-08-31)

The person-tracking and the same-day booking are period-specific and the record names none of it. **Ask Kim; do not infer a product name.** He is precise about this class of thing and the answer dates the practice.

### ✓ CLOSED 2026-08-31 — ruled ch.5's BASELINE; see the RULED entry above. (Marker fixed 2026-09-01.)

It answers **why the trip log exists**, which ch.4 asserted (*a record of the long driving days*) without a cause, and it supplies ch.5's missing baseline (*we did not know how far we could drive in a day*). **It also does not fit either**, because Nancy's role runs across the whole book and the car/human fabric is the weave, not a chapter. Candidates: a new short chapter in **The Drives** before `long_days.qmd`; an opening section of ch.5; or split -- baseline into ch.5, logistics into the part-opening. **Kim decides.**

### ✓✓✓ CLOSED 2026-08-31 — BOTH OPEN ITEMS IN THE CH.5 SCAFFOLD

**The Bellingham departure.** Settled by the day's own fill times, transcribed this session (see below). Written into ch.5 as *the sheet recorded the roll-off, Kim remembers the driving, and the gap between them is the morning*. ⚠ **Kim has not confirmed that reading yet** — if he rejects it, the fallback is to print the sheet's figures and say the memory disagrees.
**The 2013-08-04 LSM → Carson City day.** It was smoke on US-395; account collected verbatim, and the two fills (Kramer Junction, Bridgeport) corroborate the route unprompted.

### TASK — the fill times for the other trips are still untranscribed

`TwoRed_fuel_timetemp.csv` now carries **156 rows against 294 fuel rows**. The Alaska trip went in this session (22 rows, `2013_TwoRed_Fuel_Trip_Logs_Alaska.pdf`, every odometer key gated against the fuel log on the same date). **The gap is no longer invisible, and it has already paid once:** a fortnight-old conflict was only a conflict because these had never been read.

**Occasion: before writing any chapter that turns on WHEN inside a day.** Known thin years from the coverage table: 2010 (2), 2013 (25, now), 2014 (1). **2014 is the Penultimate State expedition and is the richest trip in the book on every other field** — one row of fill times is almost certainly a transcription gap rather than a blank sheet. Check `2014_TwoRed_US_Canada_Expedition_Travel_Fuel_Log.pdf` first.

**Two transcription notes carried from the Alaska pass**, kept because they are label drift, not errors: the scan reads *Lakewood / Bridgeport* where the clean CSV has Lakewood, and *Rice Hill Oregon* where it has Oakland (the same freeway exit). One time cell is genuinely unreadable — odometer 38,948, overwritten — and was left blank rather than guessed.

### ⚠ CLASS FOUND 2026-08-31 — the book was not rendering, and it was not the chapter being written

Two chapters halted the render on variables defined in chunks **below** their first inline use (`boot_w` in `small_cars.qmd`, `n_nar` in `is_it_safe.qmd`). Both fixed; **Finding 049** carries the general rule. **Standing consequence for this project: after touching `book/R/book_setup.R`, render the whole book.** The chapter that breaks will not be the file that changed.

### ★★★ IS THERE A TWORED PHOTO ARCHIVE? — the largest open question in the project (2026-08-21)

**Creamsicle has 37 geotagged, timestamped photographs that join to its logs on date + local time with NO timezone reconstruction.** Today Kim produced a **geotagged photograph of the Florida corner** — a visit the fuel log structurally cannot see. **Nobody has ever asked whether the TwoRed years have an equivalent archive.**

**Why it matters more than it sounds.** A photo archive samples on a completely different trigger from a fuel log — **not *I bought fuel* or *the day ended*, but *this is worth looking at*.** That is the exact complement of what the fuel log records, and it is where every silence in this project lives. **It would bear directly on ch.12 (the constellations) and on most of ch.13.**

**ASK KIM: is there a photo set for 2010-2017, and does it carry GPS?**

### ✓✓✓ FLORIDA IS PHOTOGRAPHED, 2026-08-21 — and Finding 045 falls out of it

**30.983392, -87.571312 — N Pineville Rd × Rease Seales Rd, 1.15 miles inside Florida, 5.4 miles from the Atmore fill.** A DEAD END sign and a farm mailbox, checkable against Street View. **The whole visit is ~11 miles hung off a fuel stop, and the New Orleans → Atmore segment already carried 210 odometer miles against ~195 direct.** Three kinds of evidence now agree: testimony (unfalsifiable), incidental knowledge (falsifiable, survives), **and a photograph (documentary).**

**★★★ FINDING 045 — A SILENCE BELONGS TO AN INSTRUMENT, NOT TO THE PAST.** Finding 036 was right that the fuel log cannot see this. **It does not license *therefore unrecordable*, which is what I wrote.** *When a record cannot reach an event, the next question is not "is it lost" but "what ELSE was running at the time?"* **Three times now — AMEX, Styx River Road, this photograph — and each time I had already called the gap unreachable.**

**⚠ KIM TO PLACE THE FILE:** `Smart_Car/images/TwoRed/twored_florida_corner.jpg`, and I'll copy it into `book/images/TwoRed/` and wire the figure into ch.13.

### ✓✓✓ THE OWNERSHIP DOCUMENTS ARE READ — EVERY DATE SOURCED (2026-08-21)

Kim gathered purchase/lease/sale paperwork into `data/<car>/`. **Read and written to `data/fleet_ownership.csv`, loaded by `book_setup.R` — no ownership date in the book is typed.**

| car | acquired | ended |
|---|---|---|
| **TwoRed** | **2010-07-23**, odometer **4**, San Diego, NEW | **still owned**, Honolulu |
| **TwoFer** | **2014-03-22**, odometer 25, **36-month lease** | **2017-03-22** |
| **Creamsicle** | **2021-09-15**, **USED** (2016 model), Modern Motorcars | **2024-10-20** |
| **Bordeaux** | **2019-04-01**, 2018 model, leased then bought out | **still owned** |

**★★ TWO DATES CORRECTED, both Finding 039 in shape.** Kim said Creamsicle was bought in **2018**; the DocuSign envelope is timestamped **2021-09-15** and the first fill follows eight days later at Nixa MO. **Content right — used, a 2016 model — index wrong by three years.** And **my own** *ten-month lease* was wrong: the agreement says 36 months. **I had read the last logged fill as the end of the lease. Finding 041: a fuel row is a TRANSACTION, not a STATE. Kim's *fill-in until we brought TwoRed to Hawaii* was exact — the lease ended 61 days before TwoRed left Seattle.**

### ★★★ A FOUR-YEAR GAP WITH NO MAINLAND CAR — ASK KIM

**Last mainland mile 2017-05-22; Creamsicle bought 2021-09-15. Four years and four months.** **This changes what Creamsicle IS: not TwoRed's replacement (TwoRed was never replaced) but the RESUMPTION of mainland driving after a pause** — and it starts in Missouri because the Lake San Marcos anchor was long gone. **The pandemic covers part of the gap but that is an assumption. Ask: what happened in those four years, and why buy again in 2021?**

### ⚠ PRIVACY — THE OWNERSHIP DOCUMENTS CANNOT BE FIGURES WITHOUT REDACTION

- **The Matson shipping receipt is SOURCE ONLY -- Kim's ruling 2026-08-21.** Not a figure, not an excerpt, not redacted-and-used. It carries the VIN, the CA plate, his legal name, his hawaii.edu address, and a named Matson agent with direct contact. Its FACTS are book material and already in `fleet_residency.csv`: SEA->HON, voyage 377, dropped 2017-05-22, estimated availability 2017-06-09, 18 days at sea. The DOCUMENT is not.
- **`Creamsicle_profile.jpg` is 533x400.** Too small to crop for print. Do not build a figure on it.

Between them they carry **a home street address and apartment number**, a mainland mailing address, **two driver's licence numbers**, a Mercedes-Benz Financial **account number**, **four VINs**, an email address, Nancy's full legal name, and signatures. **Kim is already using photographs as figures, so this is live.** Redact before any document is reproduced.

### ★ TwoFer's lifetime mileage is BOUNDED, not known

The lease allowed **22,500 miles over 36 months** and the Lease End Statement charges **$0.00 excess wear and no excess mileage** — only the flat $395 turn-in fee. **So TwoFer went well under 22,500 in three years.** **The 1,209-mile figure covers seven fills, March 2014 to January 2015, and is NOT a lifetime total** — ch.1 has been corrected to say so.

### ★★★ STYX RIVER ROAD — A NEW KIND OF EVIDENCE, 2026-08-21 (Finding 044)

Kim, unprompted: *I have a friend who lives in Alaska on Styx River Road. There is only one other road in the US with this name. I remember seeing it (Huh? Another one???) in Alabama, just after leaving Florida... How would I have known that except by a visit?*

**This is stronger than the testimony it supplements, for four reasons.** The fact is **USELESS** — nobody memorises a county road name to win an argument twelve years later, and its irrelevance is the guarantee. It is **FALSIFIABLE**, where *I asked a stranger "Is this Florida?"* is not — it is a claim about the WORLD, checkable, and it survives. It has a **documented encoding mechanism**: a collision with a friend's Alaska address, and surprise as the hook. And it is **CONTENT, not INDEX** (Finding 039) — a proper noun, which is the register this witness has never got wrong.

**The route agrees.** 2014-05-07, the **New Orleans → Atmore** fill segment reads **210 miles against ~195 direct**, ratio **1.23** against a trip median of 1.22 — invisible, as Finding 036 requires. **Atmore is nine miles from the line, and the road runs through Baldwin County AL, where the Styx flows into the Perdido — and the Perdido IS the Alabama-Florida boundary.**

**★ THE GENERAL RULE, worth using again: when a record cannot reach an event, ask the witness not WHAT HAPPENED but WHAT THEY LEARNED THERE.** Testimony about the event is unfalsifiable; incidental knowledge acquired at it is checkable. **Look for facts the witness had no reason to want.**

**All four unwitnessed states now have an account. Three by geometry; Florida by incidental knowledge.** ✓ **CLOSED.**

### ★★★ THE STATE COUNT IS 49 AND 10 — KIM'S RULING, 2026-08-21 (Finding 043)

*Take my word for it: TwoRed did, indeed, go to the 49 mainland states and the 10 Canadian provinces.* **Some states had no fill and no overnight, so they are not in the data.** **My framing — *TwoRed's list and Kim's list are two different quantities* — was WRONG and has been corrected in four files.** There is one number, 49, and a log that witnesses 45 of it.

**Write 49 in the text. Where the log's own count matters, say *the log witnesses 45*, never *45 states*.** The four unwitnessed states are **three kinds of silence** and are ch.13's best example: **Delaware** recoverable by geometry; **Rhode Island** strongly indicated (Douglas MA sits on MA-146, the Providence road); **Florida** testimony only; **South Dakota** with no leg in the record having room for it.

### ✓✓✓ SOUTH DAKOTA ANSWERED AND CORROBORATED, 2026-08-21

Kim: *I believe I was in Nebraska when I told myself to do the trip north just to get SD and return... a convoy of storm chaser vehicles coming the other way... I drove just far enough to cross the state line into SD, then turned around and left.*

**The record has it. 2012-05-27, Casper → Ogallala, 408 miles, and the two intermediate fills put ALL the slack in one segment: Douglas WY → Bridgeport NE, 255 odometer miles against ~175 direct — ratio 1.83, the most indirect stretch in the whole audit.** The northern road runs US-20 east to **Chadron NE, twelve miles from the line.** Date, region, road type and eighty unexplained miles all agree.

**⚠ AND MY NEGATIVE RESULT WAS WRONG (Finding 043, amended).** *No leg has room for it* assumed visiting South Dakota meant going somewhere IN South Dakota. **His goal was the LINE.** The honest statement was *no leg has room for the trip I imagined.* **All four unwitnessed states now have an account and three of the four are corroborated by geometry; only Florida rests on testimony alone, which is exactly what Finding 036 predicts.**

### ★ OPTIONAL — a third independent record for the South Dakota dash

Storm chasers on the High Plains on **2012-05-27** would appear in NOAA/SPC storm reports for that date. **If it checks out it is a third independent record**, the way the AMEX statements were. **Needs a SOURCED citation before anything is printed (intentions item 4) — ask Kim whether the book wants that level of forensics.**

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

**RESOLVED 2026-08-24, Kim: "No names for niece or St Louis carwash."** The niece appears as *my niece* with the town kept (Mentone is where the driveway was, and it carries no identifying weight on its own); the car wash appears as a business, never by name. **This settles the general form:** in this book people appear by relationship -- his mother, his niece, a colleague, Nancy's cousin, Nancy's brother -- and small private businesses appear by what they are. The standing rule from 2026-08-22 stands and is now complete: **institutions with a public face may be named (Matson, Madness Autoworks, Costco); individuals and small private firms may not.**

**★ Deep connections, noted for the PKM rather than the book.** The same colleague appears across **17 PKM files and 7 projects** — AI_Microscope, audio, briefing_book, whittakerr, checklists, kimbridges-stories (Kakaako Birds), collections. **He is a hub in this system, and Smart_Car is the only project where the fact about him is private rather than professional.**

### ⚠ THE WIDE-TIRE INTERVAL CANNOT BE REPRODUCED — do not print it (2026-08-20)

The figure carried since 2026-08-18, **-3.7% to +4.9%**, could not be reproduced from `TwoRed_fuel_clean.csv` under four reasonable specifications: with/without a leg-length control, with/without partial fills, with/without the Alaska rows. **They run from +1.7% [-2.3, +5.6] to +4.5% [-0.2, +9.2].**

**RESOLVED 2026-08-22. The interval is not printed and never will be.** Kim chose to make the instability itself the finding; the chapter now prints all four specifications and says why they disagree. The specification lives in the `wheels` chunk of `is_it_safe.qmd`, so the numbers are whatever the render produces -- **the reproducibility problem is dissolved, not solved.** A large effect is still ruled out; nothing beyond that is claimed.

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

## OPEN FOR KIM -- opened 2026-08-21

- ~~Is the nose-to-tail parking still current?~~ **ANSWERED 2026-08-22: side by side**, and nose
  to nose they would fit one space. Foreword and chapter 1 both corrected. Original note: `2021_Bordeaux_and_TwoRed_in_one_space.jpg`
  shows the two cars end to end in one stall (2 x 8 ft 10 in = 17 ft 8 in). His 2026-08-20
  message says they "sit side by side" now, and `2026_Bordeaux_with_TwoRed.jpg` looks different.
  Chapter 1 currently says nose to tail. **Confirm which arrangement is present-tense.**
- **No sourced dimensions for Creamsicle or Bordeaux.** The Matson manifest covers TwoRed only
  (451). Creamsicle is a 453 and a different size. Needs a document before any number is printed.
- **Photo shoot 2026-08-22:** TwoRed and Bordeaux, front-right three-quarter, building garage.
  Match angle, framing and scale to `2014_TwoFer_University_Ave.jpg` and
  `PXL_20241021_173419870`, which are the two archive frames the plate will use.
- **Chapter 13 owes the leg-floor argument.** A leg is a tankful; town driving is absorbed,
  not recorded; urban economy and the gearbox penalty are unmeasurable by this instrument.
- **Still wanted from Kim:** why a Smart specifically in 2010; Bordeaux's character; the
  tree-tunnel stretches by name; the Bordeaux "last ones the dealership sold" detail for the
  Afterword.


- ~~Boot figures: provenance unconfirmed.~~ **CLOSED -- retired and replaced by measurement.** OLD: `boot_dim` in `book_setup.R` (27.5 x 39.5-41 x
  21-23 in; 7.8 / 12 cu ft) came from Kim 2026-08-22 as a paste. **Which car -- TwoRed (451) or
  Creamsicle (453)? Measured, or from a published spec?** Chapter 1 prints them. Confirm.
- ~~Chapter 2 exposure table lists three cars.~~ **DONE 2026-08-22:** TwoFer's row dropped on
  Kim's instruction. Two rows, total 99,790, matching the prose, `stopifnot` guard passing.
- **The 2021 photo shows the two cars nose to TAIL** (both facing the same way), not nose to
  nose. Irrelevant to the text as now written, but the caption must match if it ever becomes a figure.

- ~~Confirm the manual quotes width across the mirrors.~~ **CLOSED 2026-08-22:** the manual
  footnotes the figure as measured with the mirrors folded out. Chapter 1 now cites the footnote
  rather than inferring from the arithmetic.
- ~~Turning circle 28.7 ft belongs in chapter 2.~~ **REJECTED 2026-08-22 by Kim, with a reason
  worth keeping: "When you use this tight radius, you're going very, very slowly (think: parking
  lot)." A turning circle is exercised at parking speeds and the chapter is about highway
  hazards, so it does not bear on the argument.** Generalise: **a specification earns its place
  only if it operates in the situation under discussion.** Track front 50.5 / rear 54.5 remains
  unused and is probably subject to the same test.
- ~~Boot: Kim measures.~~ **DONE 2026-08-24.** 41 x 27 x 24 in, measured, depth to the driver's
  seat. Volumes dropped entirely on his reasoning: fill it and you cannot see out the back, so the
  mirror is the constraint, not cubic feet.

- ~~The tire invoice is not in `data/TwoRed/`.~~ **FILED 2026-08-22.** 4 pages, 2.6 MB,
  verified through the R bridge alongside the purchase and shipping documents.
- ~~Front tire pressure ambiguous.~~ **CLOSED 2026-08-22: it went TO 36 psi** (Kim), which he
  notes is high for a Smart. Higher pressure lowers rolling resistance -- a third reason the X-Ice
  interval cannot be read as a tire-size effect.
- **Signal Hill fills = shop visits.** Seven in the log. Worth testing whether the 2011 pair
  (18,933 / 20,345) date any other modification.

- ~~Name the mechanic?~~ **RULED 2026-08-22, Kim: no. "We don't need to put Art's name in."**
  The shop is named; no individual is. Chapter 2 already complies -- no change needed. Treat this
  as standing: **the businesses may be named, the people who work in them may not.**
- **Chapter 3 echo:** "the people who knew the car" and the parking chapter are the same argument.
  Make the connection deliberate when chapter 3 is written.

## TOMORROW -- opened 2026-08-22

- ~~**★ FREQUENCY DIAGRAM OF PARKED PERIODS (Kim's idea, "Think: graphics").** The intervals
  between fills are the times the car stood still, and they are the chapter-3 thesis made
  visible. **There are enough points:** TwoRed 42 intervals of a week or more,
  Creamsicle 19. Distribution is heavily right-skewed (median 1  d, mean 11 d) -- so **log scale, or split at the natural break between
  "between legs of a trip" and "parked at a home port".** Both cars on the same axis; the
  contrast between their two characters is the point. **Read `dataviz` before writing chart code.**
  Caveat to carry into the caption: an interval is bounded by *fills*, so it measures time between
  drinks, not time asleep.~~
  **DONE 2026-08-28 -- `@fig-dwell` in `the_anchor.qmd`.** `R/dwell_data.R` + `R/fig_dwell.R`;
  346 intervals, both cars, log x-axis, faceted by car.
  **★ THE FORM CHANGED ON CONTACT WITH THE DATA, and that was the whole job.** A frequency
  diagram -- counting INTERVALS -- is dominated by a spike at one day (57% of all intervals),
  and the standing time is invisible behind it. Rendered it, looked at it, and it did not say
  the thing. **Counting DAYS instead of INTERVALS asks the chapter's own question:** not how
  often did the car stand, but how much of its life did it spend standing. Y is a SHARE of each
  car's covered days, because the two records are different lengths (TwoRed ~2,495 days,
  Creamsicle ~1,123).
  **What it shows:** TwoRed **78%** of covered days in stretches of a month or more, Creamsicle
  **75%**; one-day gaps -- the driving -- are **5%** and **7%** of the calendar; the middle
  (2-29 days) is **17%** and **18%**. **Both cars have the SAME SHAPE**, a decade apart on
  different coasts doing different jobs, which makes the pattern the fleet's and not TwoRed's.
  **It reproduces the independently-recorded 86% figure exactly** (TwoRed, >= 14 days), and
  Creamsicle's covered days come to 1,123 -- the number already in `proj_Smart_Car.md`. Two
  independent cross-checks passed on first run.
  Palette: dataviz slot 1 (#2a78d6), validator run, all checks PASS; INK tokens shared with
  `fig_regimes()` so the two figures read as a system.

## OPEN FOR KIM -- opened 2026-08-28

### ★★★ A SEVENTH AUDIT INSTRUMENT: THE ODOMETER AS A CLOCK

**Sort the fuel log by DATE and require the odometer to increase.** The six instruments all
test a row against arithmetic, geography or its neighbours; **not one of them tests whether the
DATES are in order**, because every one of them takes the date as given. Building `@fig-dwell`
needed date ordering, which is the only reason this surfaced -- **a figure found it, not an audit.**

**TwoRed: CLEAN.** 294 rows, seven years, zero backward steps. That is a real result about a
paper record kept at pumps for sixteen years, and it is worth saying in ch.9.

**Creamsicle: EXACTLY ONE FAILURE, and it is isolated.**

| | |
|---|---|
| row | `2023-04-14  09:00  Ely NV  odo 47,168  3.777 gal  44.21 mpg` |
| why it cannot be right | it sits **1,410 miles BELOW** a fill dated 2023-03-26 (Torrance, 48,578) |
| where the odometer puts it | between **Parowan UT 03-13 14:00 (47,001)** and **Beatty NV 03-14 11:00 (47,304)** |
| geography | Ely lies on the road between them; Parowan -> Ely is ~167-180 road mi against **167 odometer mi** |
| most likely | a **month-digit slip, 03 -> 04**. The March 2023 loop is otherwise continuous at 1-2 day gaps |

**✓✓✓ RULED BY KIM 2026-08-28: the month should be 3, not 4. An uncorrected typo.** Applied as
**C04** and the correction now reaches the data.

**What that took, because the machinery was not there.** `Creamsicle_log_errata.csv` was a
DOCUMENT, not a mechanism -- `creamsicle_ingest.R` never read it, so C01-C03 had sat as prose
while the clean CSV still carried the uncorrected values. Mirrored TwoRed's architecture:
**`Creamsicle_corrections_machine.csv`** (keyed to the ODOMETER, never a label) + application in
the ingest **with the same guard -- a correction that cannot find its row is refused, and the
applied/refused counts must account for every entry.** Only `tier == "confirmed"` is applied;
**C01-C03 stay HYPOTHESIS and stay unapplied** until a card or receipt settles them.

**The odometer-as-clock check is now IN the ingest**, so this class cannot pass silently again.
Re-run reports `corrections: 1 applied | 0 REFUSED` and `odometer-as-clock: clean`.

**Verified by content, not size:** 173 rows, Ely reads 2023-03-14 flagged `C04:date`, odometer
30,290 -> 58,903, dates 2021-09-23 .. 2024-10-20, **and the odometer is now strictly increasing in
DATE order as well as odometer order.** Old clean CSV snapshotted to `C:\temp\creamsicle_clean_20260828`.
**No headline number moved** -- 78/75, 5/7, 17/18 all unchanged, which is the reassuring outcome.

**✓ THE DISTANCE PUZZLE IS ANSWERED BY KIM, 2026-08-28 — AND THE ANSWER MOVES THE ERROR.**
*"We didn't take the Tonopah route; instead we did I-15 to Las Vegas and then 95 onward."*
**He is right, and my Tonopah assumption was the mistake.** By his route the odometer works:

| leg | odometer | great-circle | fits? |
|---|---|---|---|
| Parowan -> Las Vegas (I-15) | 167 | 172 | yes, to the width of a coordinate |
| Las Vegas -> Beatty (US-95) | 136 | 103 | yes |
| ~~Parowan -> Ely~~ | 167 | 148 | also fits |
| **Ely -> Beatty** | **136** | **191** | **NO — and cannot** |

**✓✓✓ CLOSED 2026-08-28 BY KIM, FROM THE STATION RECEIPTS. "Ely" is really "LAS VEGAS" — a data
entry error.** *"I have no idea how they got mixed up."* Applied as **C05** (`city`, Ely -> Las Vegas;
state NV unchanged). **The row now carries two corrections, C04:date and C05:city.**

**★★★ AND THE CHECK HE USED IS THE REAL FIND: THE FUEL RECEIPTS CARRY THE ODOMETER.**
*"a duplication of data I had forgotten about."* **This is a FOURTH independent record** — after the
paper log, the AMEX statements and the scans — **and it is the only one that duplicates the ODOMETER.**
The AMEX statements can settle gallons, price and merchant; they cannot settle a counter reading.
**So the receipts can audit the one field every other instrument treats as ground truth.**

**★ Finding 045 for the FOURTH time** — *when a record cannot reach something, ask what ELSE was
running at the time.* AMEX, Styx River Road, the Florida photograph, and now the receipt odometer.
**Every time, the answer existed and had been forgotten rather than lost.** At some point this stops
being a lesson about instruments and becomes a rule about searching: **inventory the redundant
records BEFORE declaring a field uncheckable.**

**★★ AND IT ANSWERS THE QUESTION HIS OWN ADVICE RAISED, from the other end.** He wrote: *enter
fields that will let you cross check values.* **The pump had been doing exactly that for him for
years, on the receipt, and he had forgotten.** The advice is not only prospective — part of it is
*find the redundancy you already have.* Strong ch.9 material, and a better ending than the advice alone.

### THE GEOGRAPHY INSTRUMENT, AND WHERE ITS FLOOR IS

The city error was caught by great-circle vs odometer, and this is its **third mode**: it detects
(errata), it RECOVERS what the log never named (Delaware, Rhode Island — Finding 043), and now it
**CORRECTS a place the log named wrongly.**

| leg | odometer | great-circle | ratio | reading |
|---|---|---|---|---|
| Ely -> Beatty (as logged) | 136 | 191 | **0.71** | **impossible — a great-circle distance is a FLOOR** |
| Las Vegas -> Beatty (corrected) | 136 | 103 | 1.32 | normal |
| Parowan -> Las Vegas (corrected) | 167 | 172 | 0.97 | **centroid artifact, NOT a finding** |

**⚠ THE 0.97 IS THE INSTRUMENT'S FLOOR SHOWING, and it must not be reported as an anomaly.** It uses
a downtown centroid; a fill on the north-side I-15 corridor is ~12 miles closer and gives 162 gc,
ratio 1.03. **A ratio slightly below 1 in a big metro is coordinate imprecision.** 0.71 is not —
no plausible fill point anywhere in Ely brings 191 below 136. **Rule: the ratio is only evidence
when the shortfall exceeds the spread of the place itself.** This is Finding 036 (every instrument
has a floor) in its geographic form.

**★★ WHY THIS ROW MATTERS OUT OF PROPORTION TO ITS SIZE.** It carries a date error caught only by a
redundant odometer, and a probable city error caught only by redundant geography. **Two errors, two
different cross-check fields, one row.** It is Kim's own 2026-08-28 advice demonstrated on his own
data, and it is now the worked example in the ch.9 scaffold.

**★ AND A METHOD NOTE ON MY SIDE.** I reported the anomaly as *Ely -> Beatty is ~260 road miles via
Tonopah* — a route I inferred and stated as if it were a fact about the trip. The distance was right
and **the route was mine, not his.** The honest version of that sentence was always available: the
GREAT-CIRCLE floor, 191 miles, which is route-independent and settles the question by itself. **When
a claim can be made from geometry, do not make it from a guessed route** (compare the South Dakota
lesson: a negative result is only as strong as the hypothesis it tested).

**★ THE GENERAL LESSON IS Finding 047:** the six instruments all take the DATE as given, so a wrong
date was outside the toolkit's range entirely -- and the ingest sorted BY ODOMETER, which is exactly
what hid it. **Sorting by a field cannot reveal an error in that field.** Found by a FIGURE.


### ✓ ch.3 -- THE FLOOR SENTENCE IS SCOPED (Kim, 2026-08-28)

The chapter said nothing in either record ran below a mile a day. True at TRIP level (slowest
between-trip span 1.68 mi/day); false at FILL level -- TwoRed 2012-06-20 to 12-21, **184 days,
158 miles, 0.86 mi/day**, the longest single stand in either record. **The empty floor in
`@fig-regimes` is partly a property of the aggregation, not only of the cars** (Finding 043's shape).

**Kim's wording, applied:** *almost no period ran below a mile a day.* The chapter now reads
"in two cars and twenty years of calendar, almost no period ran below a mile a day, and not one of
them was the car sitting still. The slowest span **on this chart** still ran at `r low` miles a day"
-- so the strong claim is scoped to the figure it describes, and the general claim is hedged where
the finer instrument disagrees. "It has no points in it" -> "It is all but empty". **The argument is
untouched:** 0.86 mi/day is still not a car sitting still, which was always the point.

### ✓ NAMING RULING (Kim, 2026-08-28) -- the standing rule applies as written

Asked before drafting ch.4, whose 2010 loop contains both cases. **Closes the two remaining
privacy calls carried since 2026-08-20.**

- **The St Louis car wash: NOT NAMED.** A small private firm. Describe it -- *a hand car wash
  near the airport* -- and stop. (It remains the only paid holding in sixteen years.)
- **The niece at Mentone: relationship only, no name. Mentone STAYS.** Kim declined the tighter
  option that would have dropped the town too.
- **Institutions with a public face ARE named:** BRIT in Fort Worth, MOBOT and the BSA in
  St Louis, Smart Madness at Signal Hill, Matson.
- Consistent with the 2026-08-22 mechanic ruling (*the businesses may be named, the people who
  work in them may not*) and with the Eugene colleague staying unnamed.

**Nothing in ch.3 needs changing** -- it already says *my niece ... at her house in Mentone* and
names no business.

### ★★★ KIM'S STATEMENT ON DATA QUALITY, 2026-08-28 — PART THREE's THESIS, IN HIS WORDS

> While this is a story about two cars, it is as much a story about data. Specifically the kind of
> data that's added now and then. Often under difficult conditions, like when you have cold,
> shivering hands. Or times when you're in a rush. It's easy to write down a wrong number.
> Transcription, too, often comes when you probably don't want to be typing a lot of numbers, some
> of which are hard to read. It is those distractions that can break the flow and cause another form
> of data error. The bottom line is that these types of data are difficult to get correct. When
> possible, enter fields that will let you cross check values (e.g., not just the date; add the day
> of the week).

**PLACED 2026-08-28, in three pieces, because it does three jobs:**

| piece | where | status |
|---|---|---|
| the framing + the field conditions | **Foreword**, `index.qmd`, straight after "**The data.**" | **WRITTEN** — one paragraph, his content, his contractions |
| the two error classes in full | **ch.8** `sixteen_years_of_paper.qmd` scaffold | verbatim, awaiting the draft |
| **the design lesson** — cross-check fields | **ch.9** `knowing_a_number_is_wrong.qmd` scaffold | verbatim, with a worked example |

**★ HE SEPARATES TWO ERROR CLASSES AND THE BOOK SHOULD KEEP THEM SEPARATE:** the FIELD error (cold
hands, haste, at the pump) and the TRANSCRIPTION error (hard-to-read figures, a broken flow, at a
keyboard, years later). Different causes, different signatures, different remedies. The slashed zero
is a field error; the Ely month typo is almost certainly a transcription error.

**★★ THE LAST SENTENCE IS THE BOOK'S ONE PIECE OF ACTIONABLE ADVICE, and today handed it a worked
example.** The Ely date error was invisible to all six audit instruments, because every one of them
takes the date as given (Finding 047). What caught it was a REDUNDANT FIELD the log happens to
carry — the odometer, acting as a second clock. **And Kim's own suggestion would have caught it on
the page, with no analysis at all: 2023-04-14 was a Friday, 2023-03-14 a Tuesday.** A day-of-week
column and the row contradicts itself at the moment of writing, where a fix is cheapest.

**The argument that makes: redundancy is not duplication.** A cross-check field is a second cheap
measurement of the same event, and it is the only thing that can catch an error in a field every
test trusts. **You cannot audit your way out of a missing column.**

**⚠ "Two cars" is correct for the data chapters** — TwoRed and Creamsicle carry the logs. Do not
silently upgrade the quote to four.

**OPEN — worth asking Kim:** is the advice retrospective or prospective? If he would design the
sheet again today, what else earns a column? (Day of week is one; a second is the pump's own
receipt number, which would make the AMEX cross-check automatic rather than heroic.)

### ★★★ CH.4 `expeditions.qmd` — THE TOPIC NOTE FOR TOMORROW (written 2026-08-28)

The scaffold already holds the material. This is the ANGLE, found while checking the 8-of-13 claim.

**★ THE FIRST CROSSING HAS NO TRIP LOG.** `twored_legs` holds 139 legs and they begin **2011-05-06**.
The 2010 crossing — the one that started everything — exists only as **43 fuel fills, odometer 4 to
10,916**, out through Texas and back through Arizona, a loop from the anchor before there was a
word for the anchor. **The chapter's first subject is its least measured one.**

**★★ AND THAT IS THE CHAPTER'S SHAPE, NOT A GAP IN IT.** The trip log begins in the middle of the
thing it records, because **the instrument was invented partway through the sixteen years it
measures.** Kim's own account of that trip says the states challenge was a BY-PRODUCT — *"We did add
on a bit of driving so we could see areas of the country neither of us had visited... and, in a way,
became the basis of the challenge."* **So the record and the purpose were both discovered in
motion.** Chapter 4 can be the story of a practice forming: 2010 has fuel only; by 2011 there are
legs; by 2014 there are times, temperatures and two odometers.

**★ IT IS THE OPERATIONAL-DEFINITION SPINE AGAIN, at trip scale.** *A term is defined by how it is
measured* — and here the measuring itself starts late, so what "a trip" is only becomes answerable
partway through. Ch.1 plants the thread, ch.3 uses it, **ch.4 shows it being built.**

**Order it by the record's own growth, not by the calendar alone:** 2010 (fuel only) -> 2011 (legs
appear) -> 2012 Frostburg, carrying the South Dakota dash -> 2013 Arctic (**cross-referenced, never
re-told**) -> 2014 Penultimate State, the fullest record and the Vermont set piece -> 2016 Fourth
Crossing, the last loop from the anchor -> the endgame, which ch.3 has already set up.

**Naming, settled 2026-08-28:** institutions named (BRIT, MOBOT, BSA, Smart Madness, Matson); the
St Louis car wash described but NOT named; the niece by relationship only, Mentone kept.
**Write 49 states and 10 provinces** — the log witnesses 45 and undercounts; it does not disagree.

### ★★★ A FIFTH INDEPENDENT RECORD: KIM'S 2014 TALK AT LSM (found 2026-08-29)

Given to people at Lake San Marcos **just after the big trip**, so it is CONTEMPORANEOUS, not recall.
**It names the four states the drive was needed for: Florida, Delaware, Rhode Island, Vermont — and
Vermont was the last, "other than Hawaii, of course."**

**★★★ WHY THIS IS THE BEST CORROBORATION THE PROJECT HAS HAD.** Three of those four are exactly the
states the geography instrument RECOVERED from odometer arithmetic, with no fill and no trip-log
entry naming them. **A document written in 2014 confirms three inferences made in 2026 from numbers
alone.** The instrument was not merely self-consistent; it was right.

| state | how the record holds it | the talk |
|---|---|---|
| **Florida** | no fill, no leg. Recovered by testimony + Styx River Road + a geotagged photograph (Findings 044/045) | ✓ named as missing |
| **Delaware** | no fill, no leg. Recovered by geometry — **Colonial Heights VA -> Bellmawr NJ, 265 odometer miles** against a Delaware-free alternative of ~305 | ✓ named as missing |
| **Rhode Island** | no fill, no leg. Recovered by geometry — **Bellmawr NJ -> Douglas MA, 287 miles**, the Providence road | ✓ named as missing |
| **Vermont** | **trip log only** (Leominster MA -> Hartland VT, then Lebanon NH out). No fuel fill in the state | ✓ named, and named LAST |

**★ AND THE ONE IT LEAVES OUT IS THE PROOF IT IS RELIABLE. South Dakota is NOT in the talk's list**,
and the record says why: it was crossed on **2012_Frostburg, 2012-05-27 Casper -> Ogallala** — two
years earlier, so it was not missing by 2014. **The talk's silence about South Dakota is correct.**
A corroborating document that agrees on everything is weak; one that disagrees exactly where it
should is strong.

**★★ IT ALSO EXPLAINS THE TRIP'S NAME, which nobody had explained.** `2014_PenultimateState`:
**Vermont is the 49th. Hawaii is the 50th and was never driven to.** So Vermont is simultaneously
the LAST state reached by car and the PENULTIMATE state of the fifty. Both framings in the record
are right; they were counting different sets. **The name was carrying the answer the whole time.**

**⚠ ONE FIGURE TO RECONCILE.** The record prints Delaware's leg as **264** miles; recomputed from the
corrected fuel log it is **265** (44,279 - 44,014). One mile, but *no number gets printed until it is
sourced* — fix the record to 265 or find the basis for 264 before ch.4 prints either.

**TASK — the talk is a DOCUMENT and should be filed like one.** Where is it (slides, notes, a PDF)?
It belongs in `source/` with the charter and the master dictionary. **Finding 045 for the FIFTH
time** — AMEX, Styx River Road, the Florida photograph, the receipt odometer, and now a talk. Every
single time the redundant record EXISTED and had been forgotten rather than lost.

### ✓✓✓ FOUR CLEANUPS, KIM 2026-08-29

**1. DELAWARE 264 vs 265 — CLOSED. Kim: insignificant, drop it as a concern.** Do not re-derive.

**2. ✓✓✓ MAINE 2010 IS CONFIRMED — and the geometry is decisive.** Kim has a **non-cellphone photo
dated October 9** on the Maine coast; Gemini identifies it as **Ogunquit**, and he confirms *"we had
just barely gone into Maine"* — Ogunquit is about fifteen miles past the state line. **⚠ He notes the
camera clock is off, so the date is soft.** It does not need to carry the weight:

| Danbury CT -> Charlton MA, 2010 | odometer | great-circle | ratio |
|---|---|---|---|
| direct | 335 | 92 | **3.64 — absurd** |
| **via Ogunquit ME** | 335 | 298 | **1.13 — an ordinary drive** |

**A ratio of 3.64 collapses to 1.13 the moment Ogunquit is inserted, and 1.13 leaves essentially no
unexplained mileage.** The dash accounts for the whole excess. **Four strands agree** — the geometry,
the photo's location, the photo's date (the Charlton fill is also 10-09), and his testimony.
**This does NOT change the state count:** Maine is already witnessed by fills in 2014 (Yarmouth,
Calais). It confirms an ITINERARY, not a state. Safe for ch.4.

**3. ✓ THE 2011 NINE-DAY ST LOUIS HOLD IS EXPLAINED.** Kim attended the **Society for Economic
Botany** meeting there. It was never a second car-wash episode — it is a conference, and the car sat
at a hotel. The hold ch.3 had borrowed for the car-wash story now has its own reason.

**4. ★★★ THE TALK IS FOUND, READ, AND IT IS A PRIMARY SOURCE.**
`source/2014_Chateau_Presentation.pptx` — **50.3 MB, 121 slides, dated 2014-06-16, four days after
the trip ended.** *"Driving to the Extremes — Some Recent Smart Car Adventures. 2014 Expedition:
Complete the 49 States + 10 Provinces. Professor Kim Bridges with Dr. Nancy Furumoto (Navigator)."*

**⚠ IT WAS NEVER IN `Key Files`.** The largest file in `source/` sat unlisted since the 2026-08-12
intake, because its name says *Chateau Presentation* and nothing about states, data or the trip.
**An intake that lists four of five files is an intake gap, and this one held the answer to two
separate open questions.** Finding 045 for the SIXTH time.

#### ★★★ SLIDE 42 IS THE MISSING-STATES LIST, IN WRITING, IN 2014

> 2014 Expedition | Complete the 49 States + 10 Provinces | **Missing States | Florida | Delaware |
> Rhode Island | Vermont**

**Kim's recollection is now a PRIMARY SOURCE.** Three of those four were recovered in 2026 from
odometer arithmetic alone, and a document written in 2014 names them. **South Dakota is absent, as it
must be** — crossed in 2012. Slide 121 gives **10,907 miles + ~280 ferry** for the 2014 expedition,
matching the margin note and the corrected dataset a third time.

#### ★★★ SLIDE 6 IS AN INDEPENDENT 2014 COMPUTATION OF THE WHOLE 2010-2013 RECORD

> Total Distance: 39,739 miles | Total Fuel Used: 1017.414 gallons | Total Fuel Cost: $3,797.63 |
> Overall Mileage: 39.28 mpg | Best 5 tank average: 47.10 mpg | Total Fill-ups: 163 | Average
> Fill-up: 6.24 gallons | Average Distance per tank: 245.28 miles | **2010-2013 Statistics**

**★ HIS BOUNDARY DECODED: 39,739 is the ODOMETER AT FILL #164 — Signal Hill CA, 2013-09-06, the last
leg of the Arctic trip.** He drew the line at the end of the 2013 SEASON, not at 31 December; and his
163 fill-ups are the fills AFTER the dealer's first at odometer 4. Once that frame is applied:

| | slide 6, 2014 | corrected dataset, 2026 | |
|---|---|---|---|
| fill-ups | 163 | **163** | **exact** |
| total distance | 39,739 | **39,739** | **exact** |
| average fill | 6.24 gal | 6.23 gal | rounding |
| total gallons | 1017.414 | 1015.19 | **-0.22%** |
| total cost | $3,797.63 | $3,817.82 | **+0.53%** |
| overall mpg | 39.28 | 39.14 ratio / 39.44 mean-of-tanks | his sits between |

**⚠ AND THE RESIDUAL IS NOT THE ERRATA — DO NOT CLAIM IT IS.** The 36 errata dated on or before
2013-09-06 move gallons by **+1.559** and cost by **+0.96**; the residuals are **-2.224** and
**+20.19**. Wrong sign on one, wrong magnitude on both. **The audit is not the explanation.**

**TASK — where to look next, and it is a specific place.** Kim's workbooks carry interleaved running
totals and averages inside the data region (this is why `creamsicle_ingest.R` skips them and reports
the count). **Slide 6 was almost certainly typed from those cells, not recomputed.** So the question
is not *which dataset is right* but *what did the 2014 total cells contain* — and whether they were
ever updated after a row changed. **A stale total cell is exactly the error class the book is about.**

#### ★★★ AND IT ANSWERS THE PROJECT'S LARGEST OPEN QUESTION: YES, THERE ARE TWORED PHOTOGRAPHS

`proj_Smart_Car.md` has carried this since 2026-08-21: *"IS THERE A TWORED PHOTO ARCHIVE? Creamsicle
has 37 geotagged photos... Nobody has asked about 2010-2017."* **The deck holds 121 embedded images,
50.1 MB, 118 JPEG and 3 PNG** — Alaska Marine Highway, the Dalton, Wiseman, fireweed, an ermine, the
Moncton tidal bore, a Columbian ground squirrel. **Photographs from the 2013 and 2014 expeditions
existed and were curated within days of the trip.**

**⚠ BE PRECISE ABOUT WHAT THIS PROVES.** It proves the photographs were TAKEN and SELECTED. It does
**not** locate an archive, and embedded PowerPoint media are downsampled copies stripped of most EXIF.
**The question changes from "is there an archive?" to "where are the originals, and do they carry
EXIF?"** — which is answerable, and which Kim can settle in a minute. If they do, ch.12's parking
constellation and ch.13 both gain a second instrument for 2010-2017, exactly as Creamsicle has.

**TASK: extract the 121 images and their embedded dates as a first pass** (`C:\temp\chateau_2026-08-29`),
and ask Kim where the originals live.

#### ✓ ANSWERED BY KIM, 2026-08-29 — THE PHOTOS ARE MANY, BUT THEY ARE NOT A LOCATION INSTRUMENT

*"There are quite a few photos. But the EXIF data are sparse because these were cameras without GPS.
No locations recorded (mostly Sony bad)."*

**⚠ THIS RETIRES THE HOPE I ATTACHED TO IT THE SAME DAY.** I wrote that if the originals carried EXIF,
ch.12 and ch.13 would gain a second instrument for 2010-2017 *exactly as Creamsicle has*. **They do
not, and the comparison was wrong.** Creamsicle's 37 photos join to its logs on date + local time
**with coordinates**; TwoRed's carry no coordinates at all. **The two photo layers are different
instruments, not the same instrument at two dates.**

**★★ WHAT THE TWORED PHOTOS CAN STILL DO, and the Maine case is the proof and the template.** A
photograph without a geotag is not evidence of nothing — it is evidence that requires someone to
IDENTIFY WHAT IS IN IT. Ogunquit was established by looking at a coastline, and it held because
**geometry independently demanded a Maine dash on that leg** (ratio 3.64 direct, 1.13 via Ogunquit).
**So the method for 2010-2017 is: visual identification, then arithmetic corroboration.** One alone
is an anecdote; together they close a question.

**★ AND THAT IS A CH.13 PARAGRAPH, not a disappointment.** The instruments do not simply get better
over time — they change KIND. The 2010 photograph needs a human (or a vision model) to say where it
is; the 2021 photograph says so itself. **Same act, same photographer, same purpose, and a completely
different evidentiary status, decided by a chip.**

**DEFERRED — TASK, until a chapter asks.** Kim: *"I can fish for a few things, but that's likely to
wait until we need them."* **Agreed, and the trigger is specific:** fish only when a chapter has a
question a photograph could settle — a named place with no fill, or a day the logs cannot resolve.
Do not inventory the archive speculatively. **Timestamps, where present, are the useful field; they
join to the logs the way Creamsicle's do, minus the geography.**

### ★★★ MOUNT EVANS RECOVERED FROM THE RECORD, 2026-08-29 — THE LAST BLANK CORNER

Kim, drafting ch.4: *"I had tried to get there on several trips between Grand Junction and Denver,
but those early attempts failed because the road was closed due to snow. I finally did it, I believe
in 2016... I took a few photos, but, alas, I can't find them.* **And none of this appears in the
record unless there is a mileage anomaly on the route.*** **He named the test, and the test passes.**

**2016-06-20, Denver -> Grand Junction, on the Fourth Crossing.** Three independent measures, none of
which names the mountain:

| instrument | reads | vs expected | excess |
|---|---|---|---|
| the LEG | 305 odometer miles | ~250 on I-70 | **55** |
| the TANK (Watkins -> Gypsum) | 203 miles | ~150 of road | **~53** |
| the CLOCK | 07:58 to 18:13, **10.2 h**, gross 29.8 mph | ~4 h on the interstate | **~6 h** |

**The Mount Evans byway is 28 road miles from Idaho Springs to the summit. Out and back is 56.**

**★ THE TANK IS THE STRONGEST PART.** It is a different instrument with different endpoints and its
own boundaries; nobody aligned it with the leg, and it returns the same answer. **A control exists
too:** the same stretch eastbound three weeks earlier, filling at the same Gypsum station —
**50.15 mpg down, 40.75 mpg up.**

**Corroborating detail, all of it independent:** late June, when the byway is open; westbound out of
Denver with Idaho Springs 35 miles along; the Fourth Crossing was his last crossing, matching *"one
of my last chances."*

**★★ KIM'S ACCOUNT OF THE DAY (2026-08-29), now in ch.4:** he couldn't stay long at the summit — the
altitude gave him a headache — and drove into a hail storm on the descent hard enough that he watched
the paint. No damage. *"I was happy to be back on the Interstate."*

**★★★ THIS CLOSES THE ONE BLANK ROW IN HIS OWN 2015 SUMMARY** (*Highest Elevation: see upcoming
trips*). The extremes table in ch.4 now has all six corners, and the last one was recovered from an
odometer a decade after the photographs were lost.

**★ AND IT CHANGES A PARAGRAPH I HAD ALREADY WRITTEN.** Ch.4 called the blank row *"the most honest
thing in the summary — a record kept by somebody who assumed there would be more trips."* **That
reading was wrong and the true one is better:** he closed the row two years later and never went back
to write it in. The summary is not an unfinished ambition; it is a record that stopped being updated
before the ambition was finished off. Rewritten.

**METHOD NOTE.** Same class as South Dakota, Delaware, Rhode Island and Ogunquit — geometry plus time
plus testimony, with no fill and no photograph at the place itself. **Sixth recovery by this route.**
Kim: *"It proves we've got a good analysis technology running."*
