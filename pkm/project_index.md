# Projects Index
_Last updated: 2026-08-20_

> **History split out 2026-07-28.** The superseded Active Focus blocks and the full
> dated Change Log now live in `logs/focus_history.md`, verbatim and unedited.
> This file carries the current focus, the structural notes, and the listings only.

**Active Focus (2026-08-28, close): "Smart_Car" -- CH.3 IS READ AND APPROVED, AND IT GAINED A SECOND FIGURE.**

**Kim read chapter 3 and approved it.** Four pieces stand: Foreword, ch.1, ch.2, ch.3 -- about 9,000 words.

**★★★ `@fig-dwell` IS IN -- WHERE THE DAYS WENT.** Kim's "Think: graphics" idea, built: 346 fill-to-fill intervals, both cars, log x, faceted, y a SHARE of each car's covered days. **TwoRed 78% of its days in stretches of a month or more, Creamsicle 75%; driving days are 5% and 7% of the calendar; the middle (2-29 d) is 17% and 18%.** **BOTH CARS HAVE THE SAME SHAPE**, a decade apart on different coasts, so the anchor pattern is the FLEET's, not TwoRed's. Reproduced the recorded 86% and Creamsicle's 1,123 covered days exactly, first run. `R/dwell_data.R`, `R/fig_dwell.R`.

**★★ THE FORM CHANGED ON CONTACT WITH THE DATA, and that was the work.** A frequency diagram counting INTERVALS is swamped by a one-day spike (57% of them) and hides the standing time entirely. **Counting DAYS asks the chapter's own question:** not how often did the car stand, but how much of its life did it spend standing.

**★★★ A SEVENTH AUDIT INSTRUMENT, AND A FIGURE FOUND IT: THE ODOMETER AS A CLOCK.** Sort by date, require the odometer to increase. The other six all take the DATE as GIVEN, so a wrong date was OUTSIDE the toolkit's range entirely -- and the ingest sorted BY ODOMETER, which is exactly what hid it. **Sorting by a field cannot reveal an error in that field (Finding 047).** **TwoRed is CLEAN across all 294 rows.** Creamsicle failed once -- Ely NV dated `2023-04-14`, 1,410 mi below a fill dated 2023-03-26. **★ KIM RULED IT: month 4 for 3, an uncorrected typo. APPLIED as C04 and the data now carries it.**

**★★ THE ERRATA MACHINERY DID NOT EXIST FOR CREAMSICLE, AND NOW IT DOES.** `Creamsicle_log_errata.csv` was a DOCUMENT, not a mechanism -- the ingest never read it, so C01-C03 sat as prose while the clean CSV carried the uncorrected values. Mirrored TwoRed: **`Creamsicle_corrections_machine.csv`** keyed to the ODOMETER + application in `creamsicle_ingest.R` with the refusing guard, **and the odometer-as-clock check now runs inside the ingest.** Only `confirmed` applies; **C01-C03 stay HYPOTHESIS and unapplied.** Verified by content: 173 rows, both corrections flagged, increasing in BOTH orderings. **No headline number moved.** **✓✓✓ THE ROW HELD TWO ERRORS AND BOTH ARE NOW CLOSED: the date (C04) and the CITY -- `Ely` is really `LAS VEGAS` (C05), from the station receipts.** My Tonopah route was MY inference stated as fact; the geometry settled it either way -- **Ely→Beatty is 191 mi great-circle against 136 on the counter, and great-circle is a FLOOR.** **Each error was caught by a different redundant field** -- the odometer for the date, the map for the town.

**NAMING RULING (Kim, 2026-08-28):** standing rule as written -- the St Louis car wash is NOT named, the niece is relationship-only with **Mentone kept**, institutions (BRIT, MOBOT, BSA, Smart Madness, Matson) are named. **Closes the two privacy calls carried since 08-20.**

**✓ CH.3\'s FLOOR SENTENCE IS SCOPED (Kim).** *Almost no period ran below a mile a day*, and the strong claim is now scoped to the chart it describes. The fill-level exception is TwoRed 2012-06-20 to 12-21: 184 days, 158 miles, **0.86 mi/day**. Argument untouched -- that is still not a car sitting still.


**★★★ KIM'S STATEMENT ON DATA QUALITY IS PART THREE's THESIS, AND IT IS PLACED.** *"While this is a story about two cars, it is as much a story about data... cold, shivering hands... it's easy to write down a wrong number... enter fields that will let you cross check values (e.g., not just the date; add the day of the week)."* Split three ways: **the framing + field conditions are WRITTEN into the Foreword** (one paragraph, after *The data.*); the two error classes go verbatim to the **ch.8** scaffold; **the design lesson to ch.9**, which now carries a worked example found the same hour. **★★ HIS OWN ADVICE WOULD HAVE CAUGHT TODAY'S ERROR ON THE PAGE: 2023-04-14 was a Friday, 2023-03-14 a Tuesday.** The odometer caught it only because it happens to be a redundant second clock. **Redundancy is not duplication -- you cannot audit your way out of a missing column.** ⚠ *Two cars* is right for the data chapters; do not upgrade it to four.

**★★★ THE FUEL RECEIPTS PRINT THE ODOMETER -- A FOURTH INDEPENDENT RECORD, AND KIM HAD FORGOTTEN IT.** *"a duplication of data I had forgotten about."* It is the ONLY record that duplicates the COUNTER (AMEX settles gallons, price and merchant, never a counter reading), **so it can audit the one field every other instrument treats as ground truth.** **Finding 045 for the FOURTH time** -- AMEX, Styx River Road, the Florida photograph, this -- and every time the redundant record EXISTED and had been forgotten rather than lost. **Rule: inventory the redundant records before declaring a field uncheckable.** ★★ It also answers his own advice from the other end: *enter fields that let you cross check* -- **the pump had been doing it for him for years.** That is ch.9's ending.

**⚠ TWO HOUSEKEEPING NOTES, both written up in full elsewhere.** **Finding 046 committed a second time** -- I bound `pi` as a path shortcut and every great-circle call then failed three steps from the cause; earlier figures re-verified identical, **no reported number was wrong**. **The rule widens: never bind a bare short name.** And **the geography instrument's FLOOR is now named** (pkm_findings 047, `deferred.md`): Parowan→Las Vegas reads 0.97, also "impossible", and is a centroid artifact, not a finding -- **a shortfall smaller than the spread of the city itself is coordinate imprecision.** 0.71 is not.
**NEXT: ch.4 `expeditions.qmd`** -- scaffold is populated and the naming question that gated it is now answered. **⚠ Its first subject, the 2010 crossing, has NO trip log** (the 139 legs begin May 2011); it is readable only through 43 fuel fills, odo 4 -> 10,916. **Also open for Kim: the March 2023 paper for the Ely fill.**
<!-- /active-focus -->

**Project clusters worth seeing as units.** Three Active R
Projects work together as the **book assembly cluster**:
photoPress (older attempt), Photo_Book (working sandbox),
photobookr (intended canonical package). Four more work
together as the **Braun-Blanquet cluster**: bbstruct
(structural analysis package), bbSynth (synthetic-data
generator), Braun_Blanquet (Quarto document demonstrating
both), and Ceska (1991 COENOS compiled Pascal executable
plus example data — the historical reference whose
methodology is being reconstructed in the other three; a
"lost technology" recovery effort). Two satellites of the
Braun-Blanquet cluster: Community_Analysis (two-way-table
utility functions, possibly to fold into bbstruct) and
sitemaps (whose `R/bb2google.R` converts Braun-Blanquet
relevé data to Google-Maps format). Two more are likely
siblings: LLM_Creates_R (document) and R_LLM_tests (test bed)
— relationship to be confirmed. Each clustered project's
proj_*.md carries a Related Projects section pointing at the
siblings.

For session protocol, see pkm_protocol.md.
For storage and audit detail, see system_audit.md.
For session-by-session detail, see session_log.md.
For the current ordered priority list, see priorities.md.
For work that is real but not now, see deferred.md (Mechanism 6).

## Website Projects

| File | Name | Type | Status | Last Updated |
|------|------|------|--------|--------------|
| proj_kimbridges_info.md | kimbridges.info | Website (hub) | Live on Netlify; 5-component hub | 2026-05-07 |
| proj_kimbridges_stories.md | kimbridges-stories | Website (Netlify) | Live; **55 stories** (verified 2026-08-12 as rendered pages in `_site/stories/`; the row read 51 and was stale); ***Selective Focus with Focus Stacking* PUBLISHED 2026-08-12 as a v2 revision — the equipment half rewritten for a changed lens collection. Earlier: Kaka‘ako Birds ("The Birds Around Kaka‘ako") PUBLISHED to the Stories site 2026-06-23 — the collaborative photo-book shipped (parked 2026-06-07 → unparked on McClatchey's read → live)** | 2026-08-12 |
| proj_kimbridges_documents.md | kimbridges-documents | Website (Netlify) | Live; **20 documents** — *Voucher Labels* PUBLISHED 2026-07-29 as the twentieth (`/vouchr/`); landing page concept designed | 2026-07-29 |
| proj_kimbridges_fiction.md | kimbridges-fiction | Website (Netlify) | **LIVE 2026-06-26** at kimbridges-fiction.netlify.app — fifth content site, the fiction front door (illustrated flipbooks). Two pieces: "My Name Is Nike" (25 pp, ~0.6 MB) + "Orbits" (183 pp). Hub front door (card + navbar + gateway) live | 2026-06-26 |
| proj_kimbridges_collections.md | kimbridges-collections | Website (Netlify) | Live; **four pages** — three collections (Gallery, Jones, **The Briefing Books**) plus the site-wide methods page **Behind the Curtain** (PUBLISHED 2026-07-26 at /behind_the_curtain.html; navbar only, not in the index listing). Active Focus opened and **CLOSED 2026-07-26** | 2026-07-26 |
| proj_jones_collection.md | The Jones Collection | Collection | Complete and live (published 2026-05-05) | 2026-05-07 |

_**Fiction web category — LIVE 2026-06-26 (standalone site).**_ The flagged idea shipped: a new fifth content
site **kimbridges-fiction** (proj_kimbridges_fiction.md), live at kimbridges-fiction.netlify.app, cloning the
stories flipbook mechanism, with **"My Name Is Nike"** (illustrated, 25 pp, ~0.6 MB compressed) and **"Orbits"**
(183 pp, cross-posted from Collections, not moved). Hub (kimbridges.info) carries the live Fiction front door
(gateway + navbar + landing card). **Storage note:** the site cross-posts finished PDFs; each piece's source of
record stays in its originating project (Nike → Audio; Orbits → Collections/Gallery); future native-fiction goes
under kimbridges-fiction\underway\. See proj_kimbridges_fiction.md and session_log.md 2026-06-26.

## Active R Projects

| File | Name | Type | Status | Last Updated |
|------|------|------|--------|--------------|
| proj_photobookr.md | photobookr | R package | Canonical book-assembly package; **REDESIGN mandate 2026-06-06** — rebuild to fit the new `#`-chapter/`##`-subsection narrative structure (first exercised on Kakaako_Birds) | 2026-06-06 |
| proj_Photo_Book.md | Photo_Book | R working demo + example data | Working sandbox for photobookr; cluster member | 2026-05-28 |
| proj_photoPress.md | photoPress | R package (older attempt) | Retained for ideas; Kim reviewing 2026-05-28; cluster member | 2026-05-28 |
| proj_photothumbsr.md | photothumbsr | R package | Working; needs unbundling | 2026-04-14 |
| proj_geContour.md | geContour | R package | On GitHub; needs documentation | 2026-04-14 |
| proj_gePoints.md | gePoints | R package | On GitHub; needs documentation | 2026-04-14 |
| proj_labelextractr.md | labelextractr | R package | Code works; needs packaging | 2026-04-14 |
| proj_whittakerr.md | whittakerr | R package + Quarto Document | Package 0.2.0 on GitHub; document published 2026-05-25 at kimbridges-documents.netlify.app/whittakerr/ | 2026-05-25 |
| proj_accessOAI.md | accessOAI | R package | On GitHub; may need API update | 2026-04-14 |
| proj_citations.md | Citations | R package | Works; needs restructuring | 2026-04-14 |
| proj_Koch_voronoi.md | Koch Voronoi Analysis | R tool | Phase 1 done; Phase 2 pending; folder renamed from Koch_voronoi_pgm 2026-05-27 | 2026-04-05 |
| proj_audio.md | Audio | Audio workflow | Active; R/ElevenLabs harness via ClaudeR; Nike_challenge casting settled (Nike=Ellen, Dr. Jones=Jane); async rendering proven. **2026-06-13: Nike_challenge developed into a written short story, "My Name Is Nike" (8 chapters, complete draft) — a deliberate written-prose, not-TTS, pivot; review reminder 2026-06-27.** | 2026-06-13 |
| proj_bbstruct.md | bbstruct | R package | Skeleton + R/, man/, tests/, vignette; Braun-Blanquet cluster | 2026-05-28 |
| proj_bbSynth.md | bbSynth | R package | Synthetic-data generator; Braun-Blanquet cluster | 2026-05-28 |
| proj_Braun_Blanquet.md | Braun_Blanquet | Quarto multi-chapter document | Chapters drafted; demonstrates bbstruct + bbSynth | 2026-05-28 |
| proj_Ceska.md | Ceska | Historical-software reconstruction (1991 COENOS) | **ACTIVE FOCUS (2026-06-11)** — COENOS revival; spec + all three `.S00` oracles decoded. The reconstruction now lives in the coenosr package. Ground truth / validation backbone for the Braun-Blanquet cluster | 2026-06-11 |
| proj_coenosr.md | coenosr | R package (faithful COENOS reconstruction) | **NEW 2026-06-11** — standalone, MIT, at Projects\coenosr; `read_rel()` + `constancy()` shipped, validated live vs the oracles (testthat 22/22, check 0/0/1). Braun-Blanquet cluster; the faithful port / validation backbone | 2026-06-11 |
| proj_lists.md | lists | R + Quarto document (demonstration / methodology) | **PUBLISHED 2026-06-16** — LIVE at kimbridges-documents.netlify.app/lists/ (9 chapters + appendix; fish toy + Madison produce); wired to `library(listsr)`; companion package shipped | 2026-06-16 |
| proj_listsr.md | listsr | R package | **NEW 2026-06-16** — companion engine to the `lists` doc; list→tree pipeline + the assessment-line method (`recruit_heights()`, `assessment_cut()`); MIT, at Projects\listsr; testthat 19/19, check OK; LIVE at github.com/kimbridges/listsr | 2026-06-16 |
| proj_seasonality.md | seasonality | R + Quarto (analysis / methodology) | **2026-06-24:** daylength channel + v2 cue-regime classifier built; **four validated regional maps** (NA, NW Europe, East/SE Asia, Australia/NZ); now in the **documentation phase** (doc + companion package, plan in `documentation/doc_plan.md`). SW desert trio = validation anchor | 2026-06-24 |
| proj_seasonalityr.md | seasonalityr | R package | **NEW 2026-06-24** — companion engine to the `seasonality` doc: indices + daylength channel + v2 cue-regime classifier + regional maps. Built via ClaudeR; `R CMD check` 0/0/1, testthat 11/11, reproduces the desert trio. **LIVE at github.com/kimbridges/seasonalityr** | 2026-06-24 |
| proj_specimen_labels.md | specimen_labels | R exploration → pkg + Quarto doc | **PUBLISHED 2026-07-29 / Complete / Not applicable** — field-capture system for botanical collecting: QR cards photographed at the collection site → **two co-equal products** (herbarium label + archivable field log), no transcription; category data on **modular discipline decks** (the creative heart). All 12 documentation chapters drafted. **2026-07-28: THE CARDS PRINT** — sheet alignment rebuilt to true Avery 5371 geometry, and **`bind_left`** added for the screw-post binding band that was clipping the QR; **`make_number_cards.R`** + **`number_cards_ledger.csv`** new (KWB 1243–1252 issued). Kim is photographing now. **2026-07-29: DOCUMENTATION RECONCILED** — binding clearance written in as a design finding (`One_deck.jpg` its figure); audit found four drifts, incl. a clearance figure measured against the wrong thing (real margin 0.127in, not 0.372in), a fourth card kind (attribution), printed decks sourced from `QR_field_notes.csv` not `decks/`, and an undocumented five-colour scheme. Cover art in hand and the title is NOT coupled to it. ★ Resume: the production pass — figures from the real photos, Appendix, provisional label, **★★ LIVE at https://kimbridges-documents.netlify.app/vouchr/** as *Voucher Labels* — 14 pages, 11 figures, five live worked examples, a 25-function Appendix and an Acknowledgements page; zero placeholders. Title settled, closing Open Question #1. Remaining items are non-urgent or conditional and live in `deferred.md` (Mechanism 6) | 2026-07-29 |
| proj_vouchr.md | vouchr | R package (companion engine) | **NEW FILE 2026-07-28 (intake gap closed) / Active / Ready** — the field-capture engine behind `specimen_labels`: QR-card decks + collection-number cards, derive-from-coordinate, deck discovery, and the photo→label+log assembler. **v0.1.0 PUSHED 2026-07-28** (`0ad01e1`) — capture side rebuilt after printing real cards: true Avery 5371 geometry, `bind_left` binding clearance, `make_number_cards()` + issued-number ledger, `validate_qr_engine()`, `determined_by` promoted. Imports 6→5 (gridExtra/readr/tidyr/purrr dropped); exports 21→25; tests 8→21; check 0/0/1. LIVE at github.com/kimbridges/vouchr. Comment correction **committed and pushed 2026-07-29** (`9be8f1c`); tree clean. Companion book *Voucher Labels* LIVE at https://kimbridges-documents.netlify.app/vouchr/. Next: 0.1.1, the `discover_decks()` cluster-numbering mapping (see `deferred.md`) | 2026-07-29 |
| proj_checklists.md | checklists | R exploration → methodology (+ likely pkg + doc) | **NEW 2026-07-05 (Active Focus / Ready)** — regional plant checklists from herbarium records (GBIF preserved specimens → normalize → accepted-species checklist for field studies). First worked site **Kīpuka Puaulu (HAVO)**: 385 records → 157 vascular taxa + 4 mosses, 85 native; reproducible build + `verify.py` (0 missing/0 mismatch). Plus a live-in-RStudio **specimen-level layer** (`collector_tools.R`): collector/date lenses + `dedup_specimens()` (BISH/BPBM = Bishop Museum; raw 249→167 flowering-plant specimens, Cuddihy 99→50). Sibling of specimen_labels/vouchr. Files in `Projects\checklists\` | 2026-07-05 |
| proj_checklistr.md | checklistr | R package | **NEW 2026-07-05** — companion engine to `checklists`: GBIF herbarium records → collector consolidation, dedup (BISH/BPBM), determination-conflict detection, and four lenses (collector/date, species-accumulation/completeness, collector×taxa). 18 exported fns; built live in RStudio; **R CMD check 0/0/1, testthat 24/24**. At `Projects\checklistr`. GitHub push pending. The checklist *build* itself not yet folded in (still `build_checklist.py`) | 2026-07-05 |
| proj_briefing_book.md | briefing_book | Program + per-site PDF report collection (umbrella) | **PUBLISHED 2026-07-25** — **The Briefing Books** LIVE at kimbridges-collections.netlify.app/briefing_books.html (Kīpuka Puaulu 22 pp + ʻIliau Loop Trail 14 pp, facet reports, checklist CSVs); McClatchey hold lifted; set **Complete / Not applicable 2026-07-28** -- a pending review no longer holds a deployed project Active. Opened 2026-07-16 as the umbrella for the field-botany cluster: DATA-DRIVEN SPECIMEN COLLECTION. A per-site COLLECTION of PDF facet-reports that faces two ways — **optimize NEW collections** (targets, easy wins, findability, decks, maps) and **strengthen PAST ones** (resample ambiguous localities, resolve det-conflicts via online scans, dedup, **repatriate** data to source institutions). Method-spine = FRICTION reduction (attention/cost/omission/access/knowledge); ethic = RECIPROCITY. Parent of checklists/checklistr + specimen_labels/vouchr (site_extract, deck_discovery). Kīpuka Puaulu first. Framing in proj_briefing_book.md; design in `checklists\briefing_book_ideas.md` | 2026-07-25 |
| proj_AI_Microscope.md | AI_Microscope | Web app (rebuild of the 1989 AI Microscope) + Quarto document | **NEW 2026-07-22; PUBLISHED 2026-07-25** — Kim's 1989 learning environment (Itoga, Bridges, Frederick & Uyeda) rebuilt as a browser app, live at aimicroscope.netlify.app (keys server-side in Netlify functions; GitHub CD at kimbridges/ai_microscope). Nine tissues, manifest-driven exact-match identification, term explorer with Say-it audio. The document *Preview & Review* (Preface + 9 chapters + Appendix) is LIVE at kimbridges-documents.netlify.app/ai_microscope/. **Complete / Not applicable 2026-07-28** — app frozen pending the plant-anatomist review | 2026-07-25 |
| proj_Community_Analysis.md | Community_Analysis | R functions (utility) | Two-way table helpers; Braun-Blanquet companion (not a cluster member) | 2026-05-28 |
| proj_sitemaps.md | sitemaps | Quarto multi-chapter document | Deployed to kimbridges-documents/sitemaps; format and Google API need updating | 2026-05-28 |
| proj_storylines.md | storylines | Quarto multi-chapter document | Deployed to kimbridges-documents/storylines; trip-log narratives; predates style guide | 2026-05-28 |
| proj_discussionsr.md | discussionsr | Research notes (placeholder) | Berlin 1992 reference + background_notes.txt; direction TBD | 2026-05-28 |
| proj_thinnr.md | thinnr | R package | Early skeleton; photo-thinning utility | 2026-05-28 |
| proj_Profile_Diagrams.md | Profile_Diagrams | R tool + Quarto document | Working; vegetation profile diagrams | 2026-05-28 |
| proj_Colors_of_the_Year.md | Colors_of_the_Year | Quarto multi-chapter document | Six chapters drafted; queued for audio rendering | 2026-05-28 |
| proj_LLM_Creates_R.md | LLM_Creates_R | Quarto multi-chapter document | Many chapters drafted; relationship to R_LLM_tests TBC | 2026-05-28 |
| proj_R_LLM_tests.md | R_LLM_tests | Quarto working examples | Test bed; likely sibling to LLM_Creates_R | 2026-05-28 |
| proj_sumo.md | sumo | Data analysis (R + Quarto) | Sumo tournament data; exploratory | 2026-05-28 |
| proj_Temperature_Patterns.md | Temperature_Patterns | R analysis project | Eugene 32°F case study; local git repo | 2026-05-28 |
| proj_R_Basics.md | R_Basics | Quarto multi-chapter document | Basics reference; chapters drafted | 2026-05-28 |
| proj_Trip_Log.md | Trip_Log | R tool + travel-photo workflow | Kyoto_1 example; upstream of storylines | 2026-05-28 |
| proj_Scripting_Discovery.md | Scripting_Discovery | R exploration + methodology | Platt + mRNA example; finished PDF present | 2026-05-28 |
| proj_timelinesr.md | timelinesr | R package + Quarto Document | Pkg + doc assembled 2026-05-27; needs its own documentation (Photo Locations extracted 2026-05-30) | 2026-05-30 |
| proj_Deconstructing_a_Flora.md | Deconstructing a Flora | Quarto document (LLM-assisted botany) | Complete; posted on kimbridges-documents; recovered + filed 2026-05-30 | 2026-05-30 |
| proj_Pedigree_diagrams.md | Pedigree diagrams | R tool + Quarto document (git-tracked) | Complete; posted; recovered + filed 2026-05-30 | 2026-05-30 |
| proj_Photo_Locations.md | Photo Locations | Quarto document + R geotagging workflow | Complete; posted; extracted from timelinesr; filed 2026-05-30 | 2026-05-30 |
| proj_Plainmaps.md | Plainmaps | Quarto document (R mapping) | Complete; posted; recovered + filed 2026-05-30 | 2026-05-30 |
| proj_AI_Podcasts.md | AI_Podcasts | Quarto multi-chapter document | **PUBLISHED 2026-08-02** to kimbridges-documents/ai_podcasts as the 21st document; eleven NotebookLM audio experiments. Source moved off the OneDrive Desktop the same day. **All audio now self-hosted — SoundCloud carries none of Kim's audio.** ~~Open: four ISSUU pointers in Travel.qmd~~ **CLOSED 2026-08-11 -- Travel.qmd contains zero ISSUU mentions; all four booklets are published stories.** | 2026-08-02 |
| proj_LLM_Examples.md | LLM_Examples | Quarto book (converted from Google Docs) | **PUBLISHED 2026-08-03** as the 22nd document (`/llm_examples/`). *Experiments with LLMs*, 130 pp / 12 chapters, converted from the live Google Doc found via the PDF's producer string. Had NO venue home before this -- it existed only on ISSUU and hflip. **Closing it removed the last non-historical legacy link in the system.** Open: editorial reorganisation, Kim-driven, unscheduled. | 2026-08-03 |
| proj_Smart_Car.md | Smart_Car | R + Quarto document (data-driven) | **Active / Ready. 2026-08-18: THE FUEL-LOG AUDIT IS CLOSED** -- 45 log errata + 8 gazetteer errata, arithmetic class exhausted, and the **'missing fill-up' class ended 5 flagged / 0 real** (one merged row, three partial fills, one artifact my own filter made -- Finding 032). **Five audit instruments, none redundant**, plus a sixth that is Kim's slashed zeros (Finding 033), whose DIRECTIONALITY rejected one of my own candidates. **Three trips transcribed, 67 legs**; the 2014 Penultimate State total of **10,907 mi matches Kim's margin note exactly**. Coverage 140/293 rows (48%); 8 scans unopened; **May-Jun 2016 may have no sheet at all and that is where the contamination sits.** Earlier: **UNBLOCKED 2026-08-16. THE CREAMSICLE DATA IS FOUND, AND IT WAS NEVER A FILE:** it is Google-native (`Final Creamsicle Logs` multi-tab Sheet, the `Creamsicle` 9-trip narrative Doc, a Jul-2024 update **with lat/long**, and a packing inventory), so every prior FILESYSTEM sweep was structurally incapable of seeing it -- `G:` showed a 176-byte stub, `readBin` returned 0. **28,697 mi / 1,123 days / 9,845 mi-yr / 18 states + Canada.** ★ **TwoRed's Trip Log is 7 rows; Creamsicle's is the real one**, so the fleet framing is now quantitative. Also found: `TwoFer Gas Log` = car #2 (7 fill-ups, 1,209 mi, **all Honolulu** -- the leased car is the ONLY true urban commuter), and a richer `TwoRed_fuel` sheet carrying ambient temperature. `2016_Fourth_Crossing_Analysis.xlsx` ruled **TwoRed, not Creamsicle**, by odometer (58,214 in May 2016). Open: Trip 9 fill-ups. Earlier: **NEW FILE 2026-08-12 (intake gap closed)** — the third gap of the Jones/vouchr shape: a written charter (2026-05-08), 20.6 MB of materials, no proj file and no index row, dormant three months while mis-filed as a *story* under `kimbridges-stories/underway/`. **Kim reframed it 2026-08-12 from one car to FOUR** — sixteen years of Smart ownership, two still owned, deepest data on the first (TwoRed). Thesis unchanged and strengthened: a Smart is assumed to be an urban commuter, and a sustained sixteen-year record refutes it. **The Arctic Circle Challenge is cross-referenced, NOT re-told** — it is already a published story, so the charter's embed-by-iframe Chapter 5 is superseded. Materials moved to `Projects\Smart_Car` (bucket 2), nine files byte-identical. **Reading the data rather than the charter corrected three claims:** the Gas Log runs 2010-2017 not to June 2014, the odometer tops out at **71,181 not 75,000**, and the Trip Log is 7 rows not a dataset. **Fleet named same day:** TwoRed (2010 Passion), Two4Two (Smart Pure, leased 2014-03-22), Creamsicle (2016, sold to family), **Bordeaux (2018, ELECTRIC)**. The 75,000 question CLOSED -- TwoRed is ~20 mi short; **the log stopped, not the car**, and the charter was right. **BLOCKED on locating the CREAMSICLE cross-country data**, a second analytical spine rather than a footnote. Rulings: Creamsicle's purchase reason NOT FOR PUBLICATION; no output may take a `bordeaux*` slug (two live wine stories hold it); ICE and EV kept separate. See `deferred.md` | 2026-08-12 |
| proj_LLM_API_R.md | LLM-API-R | Quarto document (R + LLM API) | Complete; posted; .qmd source still to be located; filed 2026-05-30 | 2026-05-30 |

## System Projects

| File | Name | Type | Status | Last Updated |
|------|------|------|--------|--------------|
| proj_PKM.md | PKM System | System | Active / Ready; Operating Protocol adopted 2026-05-07, **now SIX mechanisms — Mechanism 6 (Deferred Work) adopted 2026-07-29** with `deferred.md`, the project-touch rule in Mechanism 2 and item 8 in Mechanism 5. **Mechanism 1** gained a track decision (venue / language) 2026-07-17. **Mechanism 4 amended 2026-07-28 -- "Where entries go":** session_log.md entries go at the TOP as h2, newest first, never appended; the file legitimately holds two blocks (the pre-2026-06-07 archive stays in append order); grep the WHOLE file at every heading level before declaring an entry missing; never write a gap marker without proving the gap (Finding 019) | 2026-07-28 |
| proj_Travel.md | Travel System | Standalone system (pointer) | Active; created 2026-06-10 at G:\My Drive\Travel; two trips filed (Big Island 7/2026 Booked, Australia/NZ 2027 Planning) | 2026-06-10 |

## Dormant Projects

_None currently. (The papers row was removed 2026-05-30 — no
proj_papers.md ever existed.)_

## Completed / Archived Projects

Note (2026-05-28): With the new Status header field in proj_*.md,
completion is signaled per-project rather than by folder location
or by index-section placement. This section is now a derived view
of projects whose proj_*.md carries `Status: Complete`. The
section may be retired entirely once the Status field is rolled
out across all proj_*.md and the derived list is generated by
tooling.

| File | Name | Type | Completed | Folder |
|------|------|------|-----------|--------|
| proj_milestones.md | Milestones & Bar-Timelines | R package | 2023 | G:\Projects\milestones (moved back from Projects_Archive 2026-05-28) |

Note (2026-05-30): the proj_zundert_2025.md row was removed — no
such file existed; Zundert 2025 will return later as a story. With
the Status field now carried by every proj_*.md, the full set of
Complete projects is best read from the files themselves; see the
2026-05-30 Change Log entry for the current Complete list.

---
