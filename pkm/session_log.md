# PKM Session Log
_Created: 2026-05-07_

System-wide log of Cowork sessions. One dated entry per session.
For per-project working detail, see session_notes.md inside the
relevant project folder (designed in design_publishing_workflow.md;
not yet implemented).

For protocol governing how this log is used, see pkm_protocol.md
Mechanism 4.

---

## 2026-10-30 -- MRC: REDIRECT FROM PUBMAPS, ROUND THREE, FORMAL INTAKE, CH.6 FIGURES 1-4

**Date / duration:** 14:56-21:50 HST, with a dinner break (~16:50-20:30).

**Active focus at start:** PubMaps (2026-10-24). Session start ran the three reads and the PubMaps service check
(0 inbox / 0 awaiting / 0 failed). device_bash still cannot mount G: -- all reads and writes went through the R bridge.
Kim had started the R server late; the bridge reconnected on the first call.

**What was worked on:**
- Redirected to the trilogy, then to MRC (*Measurements Require Categories*) for "a different perspective" away from mapping.
- MRC round three in `ideas_three_documents.md`: context moves the boundary ("thin blood") paired with fixed boundaries
  (twilight, DST, Kona coffee break) in ONE chapter; standardization and the surf scale; language holds categories
  (Hawaiian rain names by place -- web-checked: Hanau ka Ua; immersion schools teach cloud names, rain corpus unconfirmed);
  Hokule'a and the life of a category; Kim's Ben Finney dinner and the Palau arrival (2007-04-01, on schedule -- his
  printed programme and his own photograph); Miller (1956) "The Magical Number Seven".
- FORMAL INTAKE (Mechanism 1): `proj_MRC.md`, `Projects\MRC\` (R/, figures/, data/), index row; Active Focus moved to
  MRC ch.6 (old block preserved in logs/focus_history.md). PubMaps stays Active (service running).
- Ch.6 argument adopted (7 steps) -> `Projects/MRC/ch06_argument.md`. Figures built (scripts in R/, PNG + PDF):
  fig1 misclassification curve; fig2 cost moves the threshold; fig3 NHANES 2017-18 BP reclassification (19% -> 39%
  hypertensive on measured BP alone; 34% relabelled with no change in reading); fig4 Eugene frost from REAL GHCN-Daily
  data (5% of winter nights sit exactly on 32 F; last frost moves 58 days in 2025 for 32 -> 33 F).
- Fig4 also added to Temperature_Patterns (data/, figures/, R/eugene_frost_boundary.R; proj file updated; NOT committed to git).

**Key decisions (Kim):** round-three MRC outline ADOPTED (10 chapters, three parts); event boundaries stay in MRC (life
cycle), not S3; ch.6-8 need work; ch.9 location open; language in ch.2; ch.6 = boundary VALUE shifting, ch.9 = ROLE
changing; short folder name MRC; Miller OPENS the document (true origin -- first the NUMBER of categories, later the
measurement link); CHART RULE for the trilogy: include an interpretation note working one example; teach the reader how
to read a new chart type.

**Personal stories captured (ch.6 notes):** smudge pots in the Southern California orange groves; Kim's letter-grade
system for classes of 300-500 (predefined 0.5 band; three computed round-up tests -- bad day, upward trend, strong
final; noted in the gradebook; thousands of students, never challenged); the 28-day exam spacing and the origin of the
bad-day rule; item-analysis correction of exams (+1 to all per flawed question; "I got feedback, too").
**CAUTION:** Kim is nervous about disclosing the borderline rules (never discussed with colleagues) -- disclosure level
is HIS decision; do not draft them into chapter text until he rules.

**Queued:** continue MRC tomorrow -- options: fig5 (simulated class of 400, the borderline band and its tests); ch.7-8
worked examples; ch.2 AI-elicitation example; verify lists (ideas file round three; ch.6 notes). Ask Kim which item
statistic he used. PubMaps NEXT unchanged: tell Will the loop is live.

**Notes:** the count of Eugene nights jumps at 32 F (31: 235, 32: 334) -- heaping or latent-heat physics? Worth checking.
Temperature_Patterns' pipeline defaults to SYNTHETIC data.

## 2026-10-29 -- PUBMAPS: EMAIL SUBMISSION LOOP BUILT AND TESTED (CLAUDE DUET)

- Session run in Claude Duet (not Cowork); no PKM mount from there, so this entry was pasted in by hand. [Inserted verbatim 19:12 via the Cowork R bridge from Kim's paste.]
- GOAL: let Will (and later others) submit by emailing a PDF with subject "PubMaps submission", no API keys needed. Kim stays in the loop for testing; automation later.
- INTAKE: Duet's Drive connector cannot upload PDFs. Fix: Apps Script pubmaps_intake.gs installed in Kim's Google account (script.google.com), trigger every 2 h. Files each submission PDF to Projects/PubMaps/service/inbox as <Sender>_<Gmail message id>.pdf; process_inbox() adds the date, so outbox folders are YYYYMMDD_<Sender>_<message id>.
- WATCH: Duet routine "PubMaps submission watch" checks Gmail every 2 h, 8am-8pm HST, and notifies Kim of new submissions (notify only).
- RETURN: on Kim's "approved", Duet drafts a reply to the sender with the five outbox files (map_vector.pdf, map_vector.png, points.csv, review.html, symbol_key.txt), body from reply_draft.txt; sent only on Kim's Send press.
- TEST: Kim's self-submission (Gmail id 1a18a9f16ed7c0a4) filed, processed, approved and replied end to end. Loop works.
- NEXT: tell Will the loop is live; watch for his first real submission. Possible later: reply subject "PubMaps results" (reply_draft.txt suggests it); remove Kim from the loop.

---

## 2026-10-29 -- PUBMAPS: WILL'S FIRST COMMENTS; SERVICE PLAN (A NOW, C LATER)

- PKM opened. device_bash still cannot mount G:; the Drive connector refuses text/markdown downloads (content readable only through search snippets). THE R BRIDGE READS AND WRITES G: -- use it for PKM writes.
- WILL McCLATCHEY'S FIRST COMMENTS (relayed by Kim): all positive. He called PubMaps the most complicated of the documents generated so far, even counting the coding and appendices of the others. Kim agrees it is complex, but others have been very complex too. Will's install attempt on his WORK machine (locked down; he handles confidential materials) did not get it running; he will retry from his HOME computer.
- DECISION (Kim): offer PubMaps as a submit-a-PDF service, so early users get the map + points.csv without the setup. PHASE A NOW = concierge: a tester emails a PDF, Kim runs pubmap() locally, and returns the map + points.csv + review page. PHASE C LATER = a Docker container (rocker/geospatial + pubmaps + Shiny or Plumber) on Cloud Run or Hugging Face Spaces. (Option B, Shiny on Posit hosting, not chosen.)
- Design constraints carried into A and C: (1) CONFIDENTIALITY -- unpublished manuscripts go to the server and the LLM provider; test with published papers or with author consent; delete uploads after the run. (2) THE REVIEW LOOP MUST SURVIVE -- return an editable points.csv + the review page, and accept a corrected CSV for a re-render (the web pubmap_rerender()). (3) Keys stay server-side; testers get an invite code. (4) Nominatim/Overpass limits are fine for testing, not for open use. Idea: the guide could split into a short submit-and-review path for users and the full manual for operators.
- Kim proposes CLAUDE DUET (Preview) to automate A: watch Gmail for submissions, run R on Kim's machine, Kim reviews, reply drafted. Under evaluation.
- 16:25 SERVICE FOLDERS BUILT + TESTED END TO END: `Projects/PubMaps/service/` with inbox/, work/<id>/ (review + edit points.csv here), outbox/<id>/ (APPROVED only: map PDF + PNG, points.csv, review.html, symbol_key.txt, reply_draft.txt), processed/, failed/, service_log.csv. Script `service/pubmap_service.R`: process_inbox(), rerender_submission(id), approve_submission(id), service_status(). Test on era_36_10.pdf (id 20261029_TEST_era_36_10): process 40 s, 7 places; rerender 16 s; approve -> 6 files in outbox. Test outputs left in place, labeled TEST. Will told the plan (no API keys needed). Next: Kim emails himself a test submission and tries Duet on the Gmail -> Drive inbox step.
- 19:30 OPERATOR DOCUMENT + PKM CHECK: `Projects/PubMaps/service/SERVICE.md` (who does what, where each piece runs, folders, functions, limits, the out-of-the-loop plan, alternatives) + `service_loop.svg`. `pubmap_service.R` gained `service_check()` and now writes text in binary CRLF (Finding 037; the earlier files were checked clean, no CRCR). Kim adopted STEP 4 AS A PKM ROUTINE: STANDING CHECK line in project_index.md (the trigger) + rule in pkm_protocol.md Mechanism 2 -- check at session start, propose process_inbox(), run only on Kim's yes. First check found KimBridges_1a18abecb5e15568.pdf (filed 18:00). NOTE: this session skipped pkm_card.md at start (Kim's preference names only two files); the 16:2x session-log size misfire was Finding 020 exactly.
- 19:29 FIRST PKM-ROUTINE RUN (Kim's yes): KimBridges_1a18abecb5e15568.pdf -> 20261029_KimBridges_1a18abecb5e15568, ok, 10 places, 35 s (Kerinci/Jambi, Sumatra). For Kim's review: Lempur PARTIAL match; Bukit Barisan placed as one point at a rounded GeoNames range centroid (-3.00, 102.25); INDONESIA flagged by the engine 'far from the study (check)'; Jangkat Subdistrict a point (GeoNames ADM3, no polygon). Awaiting Kim's review/approval.
- 19:34 Kim reviewed (map good) and APPROVED with a confirmation request to the author: reply_draft.txt asks the author to confirm the study sites, naming Lempur (partial match; several Kerinci villages share the name). Outbox: 6 files. Check now 0/0/0. Next: Kim tells Duet it is approved; Duet drafts; Kim sends.
- 19:49 SENT (Kim). Duet objected that it had already been sent; Kim sent anyway and received the email -- confirmed. Kim made a small fix to the Google script to avoid unnecessary resends. Next: Kim asks Will to submit something; waiting on Will.
- 19:58 SESSION CLOSE: pkm_health() -- drift 0, repo/clone mismatches 0, reconciliation failures 0; ONE NEW FLAG: project_index.md 30.5 KB vs 30 KB budget (+0.5, the new STANDING CHECK line) -- trim next session (the Active Focus NEXT paragraph is the obvious candidate). rehearsals_huntington scratch past 14 days = known KEEP. pkm_backup(): 1424 files, secret scan clean, committed 790f60d9a8 (6 changed), push verified against the server. Next session: Kim pushes Will to submit and asks how the email strategy fits his needs and constraints.

---

## 2026-10-28 -- COVERS: NINE MORE DOCUMENTS NAMED ON THEIR COVERS

- PKM opened (R bridge started late; files first read via staging). Active Focus PubMaps; no word from Will yet. Kim emailed GeoNames about the premium-account refusal.
- Kim replaced covers (same names; previous kept as *_old.*) for AI_Podcasts, Colors_of_the_Year, Deconstructing_a_Flora, LLM_API_R, Photo_Locations, seasonality, Smart_Car, specimen_labels, whittakerr.
- Copied into each book's _output and the venue folders (17 copies, md5 verified); vouchr card file vouchr_cover_art_text.png also replaced (it duplicated the book cover). Smart_Car/book/_output does not exist on Drive -- venue copy only.
- Venue re-rendered; _site verified by md5 for all nine folders. Kim uploaded to Netlify; all 10 cover files verified byte-identical live.
- Sitemaps + gePoints covers titled by Kim in the venue folders (gePoints upscaled 2x to 1536x2048; old kept as *_old). Sitemaps new cover synced to Projects/sitemaps/sitemaps_website (+ _output; old kept as sitemaps_cover_old.png). gePoints has NO book source under Projects (venue copy is the only one). Kim's gigapixel intermediate moved out of the venue to Projects/gePoints/. Navbar thumbnails (*_thumbnail) left untitled. Venue re-rendered; sitemaps 111/111, gePoints 31/31. Uploaded by Kim; both verified byte-identical live. ALL document covers now carry their names (Kim: style more consistent).
- PRIORITIES REFRESHED (Kim asked; PubMaps paused on Will + GeoNames): priorities.md rebuilt (14.6 -> 8.2 KB); the superseded version appended verbatim to logs/priorities_history.md. Every old item checked against the files: dead Quarto Pub links CLOSED (none left); prose claims still open; coenosr PDF still not made; 30 proj files read Active; 7 repo/clone mismatches incl. a tessellr FALSE POSITIVE (check ignores C:/repos); C:/temp/rehearsals_huntington_2026-09-30 is the ONLY copy of the Rehearsals working files -- flagged KEEP despite the 14-day rule. Next: Kim picks the Active Focus (Rehearsals / trilogy / icons).
- KIM CLOSED (2026-10-28): SoundCloud account deleted; Exposure account closed; coenosr print-ready PDF made and mailed to Dr. Ceska.
- PRIORITIES SECTION 3 WORKED: drift 5 -> 0 (audio + R_LLM_tests paths corrected; notes in listsr/checklists/sitemaps/vouchr); repo/clone mismatches 7 -> 2 (pkm_health.R: C:/repos + case-insensitive + authenticated repo list + CLONE_ACCEPTED, each checked file by file against GitHub; backup-message undercount fixed); budgets: deferred.md 212 -> 193 KB (settled blocks verbatim to logs/deferred_closed.md, 46 open items unchanged), proj_seasonality + proj_audio logs split by hand (LF kept), card 6.4 -> 6.0 with its split Rule sentence rejoined + a Finding 037 row; CRLF finding found already written (037) -- three stale PKM tasks closed.
- CREDENTIAL AUDIT (93 folders; venues clean): Gemini key in Projects/AI_Microscope/index.html (not live, not on GitHub HEAD); A DIFFERENT GEMINI KEY IN THE PUBLIC HISTORY of kimbridges/ai_microscope (first commit d0f4e6c); revoked 2024 Anthropic key in LLM_API_R/_backup; two old Maps keys in Han/. Revocation = Kim.
- LISTSR IS NOT ON GITHUB: 404 as owner; Drive repo has 1 commit, no remote; proj_listsr said LIVE; the live lists doc links to it. Kim approved publishing: CREATED + PUSHED public kimbridges/listsr (main, af40884, 37 files; clone C:/repos/listsr); verified against the server, repo page 200, install_github -> 0.1.0, 15 exports. Kim checking the Gemini key revocations.
- KEY CHECK + AN EXPOSURE (2026-10-28, 16:05): probing the found keys against Google's free list-models endpoint showed (1) the AI_Microscope Gemini key is DELETED (API_KEY_INVALID) -- and it is ONE key, not two: the Drive copy and the public GitHub history (d0f4e6c) share the same fingerprint (my earlier 'different key' was wrong); (2) the two Han/ Google Maps keys are STILL VALID (403 API_KEY_SERVICE_BLOCKED = the key exists, restricted to other APIs) -- private on Drive, not public; Kim to delete or restrict them in the Cloud Console. (3) CLAUDE ERROR: a fingerprint helper printed a key from .Renviron into the tool output, because vapply() names its results by the input values. CORRECTED 16:10: the exposed key is GGMAP_GOOGLE_API_KEY (Google Maps, ends ...xUsU) -- NOT the Gemini key, which uses Google's newer 53-character format and was never matched. Kim to replace the Maps key (new key -> .Renviron -> delete xUsU). Han keys end nFOE (2018) and Pv8k (2021). The key itself is NOT recorded anywhere in the PKM. Also: .Renviron holds both GEMINI_API_Key and GEMINI_API_KEY -- Windows env vars are case-insensitive, so they collide. 16:35 Kim: NEW Maps key made and set as GGMAP_GOOGLE_API_KEY; xUsU and the unused old keys (incl. nFOE) DELETED in the Cloud Console; Pv8k kept for now (no public site carries it -- kimbridges.com/.info/stories/collections checked; only Han/Site_Info.Rmd uses it). Advice: check its 30-day traffic in Metrics, then delete (30-day undelete). 16:40 after RStudio restart: GEMINI WORKS -- generateContent on gemini-3.8-flash answered (billing fixed the old 403); duplicate GEMINI_API_Key line removed by Kim. NEW GGMAP key REJECTED by the Geocoding API ('invalid'): 53-char new-format key, likely an AI Studio key -- Kim to create the Maps key in the Cloud project that holds the Maps APIs, restrict to Geocoding/Maps Static/Elevation, re-test. 16:58: CAUSE FOUND -- AI Studio now issues 53-char 'authentication keys' scoped to Gemini; Maps still needs a standard AIza key from the Cloud Console. Kim made one: GEOCODING OK, ELEVATION OK (1212 m at Kipuka Puaulu), ggmap::geocode OK, billing active; MAPS STATIC 403 = not in the key's API restrictions (Kim to tick Maps Static API if he uses Google basemaps). 17:02: Maps Static added -- static map of Honolulu returned (200, image/png). NEW MAPS KEY FULLY WORKING: Geocoding, Elevation, Maps Static, ggmap.
- 17:20 TWO SMALL JOBS DONE (Kim at dinner, approved): (1) DEAD KEY TEXT REMOVED -- each key re-probed first: AI_Microscope Gemini key + Han nFOE Maps key = API_KEY_INVALID (deleted), 2024 Anthropic key = 401 (revoked); each replaced in place by `REMOVED-2026-10-28-key-deleted` / `-key-revoked` in `Projects/AI_Microscope/index.html`, `Han/Google_Maps_API_Key.txt`, `LLM_API_R/_backup/Claude_API_backup_2026-08-03.qmd` (binary write, EOL kept, line counts unchanged, 0 key matches remain); originals backed up to `C:/temp/dead_key_redaction_2026-10-28/` (they hold dead keys -- delete with the other scratch). `Han/Site_Info.Rmd` NOT touched, BUT Pv8k now answers Google Geocoding with 'The provided API key is expired' -- it appears already dead; Kim to confirm in the Cloud Console. (2) SECRET SCAN TAUGHT THE NEW KEY FORMAT: Google's 53-char auth keys are `AQ.` + 50 of [A-Za-z0-9_-] (derived from .Renviron by structure only, key never printed); `google_auth = "AQ\\.[A-Za-z0-9_-]{40,}"` added to SECRET_PATTERNS in pkm_health.R (backup `C:/temp/pkm_health_backup_2026-10-28/pkm_health_pre_authkey.R`; parses, LF, no double CR). It matches the live Gemini key (and only via google_auth); 5 venues + C:/repos clones scan CLEAN; 60 folders under Projects + Projects_Index + Han show no new-format key -- the only remaining hit anywhere scanned is Site_Info.Rmd L97 (Pv8k, left for Kim).
- 19:07 KIM: Pv8k DELETED (all Google keys reviewed). Its text redacted from `Han/Site_Info.Rmd` L97 (now `g_key <- "REMOVED-2026-10-28-key-deleted"`; CRLF kept, line count unchanged; backup in `C:/temp/dead_key_redaction_2026-10-28/`). Han/ scans clean. CREDENTIAL CLEANUP COMPLETE: no key text left anywhere scanned except .Renviron. Site_Info.Rmd needs the new GGMAP key (read from .Renviron) if it is ever knit again. 19:10 (Kim): DONE -- L97 now `g_key <- Sys.getenv("GGMAP_GOOGLE_API_KEY")`; env var present.
- 19:24 KIM'S QUICK PASS (19:18), ALL DONE: (1) QUARTO PUB PROSE fixed -- plainmaps + R_Basics `index.qmd` now say 'my kimbridges-documents website'; ONLY index.html re-rendered (scratch copies in C:/temp; the new page differs from the live one only in that sentence, plus plainmaps' auto date); copied to venue/<book>, venue/_site/<book> (+ R_Basics/_output), md5 verified; search.json sentence patched in each. Plainmaps.pdf still carries the old sentence (full PDF render = 1 GB of map data; left for the next rebuild). AWAITING KIM'S DRAG of kimbridges-documents/_site, then live check. (2) STATUSES: checklists, vouchr, coenosr, Ceska -> Complete; PKM, Travel -> Standing (proj line 3 + project_index rows). Active 30 -> 24. Note: `.status_of()` reads the FIRST WORD of `_Status: ..._`, so any note must sit INSIDE the italics. (3) C:/temp: Kim deleted most scratch; left: listsr_installtest, pkm_health_backup, secret_audit, the two *_index_2026-10-28 builds, rehearsals_huntington (KEEP). (4) AI_MICROSCOPE re-cloned to C:/repos/ai_microscope (666c245 = old clone's HEAD, fetched first; 17 files match modulo EOL; autocrlf true). R refuses recursive deletes, so Kim deletes the old OneDrive folder. A push there DEPLOYS the live site. (5) SESSION_LOG 427 -> 144 KB: the 31 entries 2026-08-31 back to 2026-07-22 moved VERBATIM to the TOP of logs/session_log_archive.md (now 164 entries, 782 KB); line-for-line check passed. ⛔ `split_session_log()` would have OVERWRITTEN the archive (it writes a fresh header + the split) -- now GUARDED to refuse when the archive exists. (6) PROJ_SMART_CAR 65.9 -> 30.7 KB: 26 settled ★ working sections (2026-08-16..21; the book is published) moved verbatim to the top of logs/proj_Smart_Car_log.md, with heading-index stubs left in place. project_index CARRIED line refreshed. pkm_budget(): NOTHING over budget; drift 0. Backups of every split file in C:/temp/pkm_health_backup_2026-10-28/.
- 19:34 LIVE CHECK: Kim dragged _site; plainmaps + r_basics index pages LIVE (200) with the new sentence. md5 does NOT match _site for HTML: Netlify rewrites `./index.html` links to pretty URLs (`/plainmaps/`) -- the only differing lines. ⚠ Verify deployed HTML by CONTENT; md5 holds for images/PDFs only. C:/QUARTO/STORYLINES investigated (Kim asked): an older parallel working copy from June 2024 (the one that published to the now-closed kim.quarto.pub/storylines; has its _publish.yml). Same .qmd sources as Projects/storylines; differs only in a second LLM run's captions/full_story and render outputs; Aug 2024 files are RStudio session state only, with NO unsaved buffers. The live venue copy matches Projects/storylines/_output (43/43), not C:. Nothing in it is needed -- Kim to delete C:/Quarto (the bridge cannot).
- 20:01 OLD R REMOVED (Kim, guided; checked first that nothing pointed at 4.3.3 -- PATH, RStudio prefs, .Renviron): R 4.3.3 AND R 4.2.1 uninstalled; Rtools43 uninstalled via `C:\rtools43\unins000.exe` (5.7 GB; it was not found in Apps under that name); win-library 4.2 + 4.3 deleted (2.9 GB; AppData is hidden -- paste the path); empty `C:/Program Files/R/API_keys` deleted; RTOOLS42_HOME gone, RTOOLS43_HOME was a SYSTEM variable (greyed out in the per-user dialog) -- removed. Verified: only R-4.6.1 and C:/rtools45 remain; registry holds only RTOOLS45_HOME; build tools OK; 504 packages in 4.6; gert/httr2/quarto/ggplot2/sf/listsr/pubmaps load. About 8.6 GB freed.
- Waiting on Kim (superseded 19:24 -- see above): 3.1 wording (drafts given), 3.3 status proposals (checklists + vouchr Complete, PKM + Travel Standing, coenosr/Ceska his call), session_log + proj_Smart_Car budgets.
- Housekeeping: two 10-27 notes appended at the file's END last night were moved into the 10-27 entry (Mechanism 4: entries at the top).

---

## 2026-10-27 -- PUBMAPS RELEASED: GITHUB + EDITOR'S GUIDE

- PKM opened; Active Focus PubMaps confirmed. Kim's scope: finish Part I, publish to kimbridges-documents, GitHub repo, then share with Will McClatchey.
- Cover + logo (Kim) added to the book. Independent proofread fixed 25 items; 2 code fixes (pubmap model/display defaults).
- GitHub PUBLIC kimbridges/pubmaps (3c3fc4a, 437dc03; verified against server; install_github tested). Clone C:/repos/pubmaps.
- Guide in kimbridges-documents/pubmaps/ + card; Kim deployed; LIVE and verified from R (only Netlify's pretty-URL rewrites differ). Kim: "This is another big step forward." Kim will explain the GeoNames premium issue to Will.
- Kim sent the guide + repo links to Will McClatchey (he reads tomorrow morning).
- VORONOI open note closed: permission to use the 1974 Mueller-Dombois & Fosberg HVNP vegetation map received by email (Kim).
- Voronoi: permission credit added to the Preface; rebuilt + venue/_site updated; upload deferred (Kim). Rebuild shifted three Ch.9 numbers by 1 and a Ch.7 legend order (software drift) -- Kim to decide full vs Preface-only. Scratch: C:/temp/voronoi_build_2026-10-27.
- Scratch: C:/temp/pubmaps_installtest_2026-10-27 (delete).
- Covers updated (document name on each): checklistr (jpg), lists (png, resized, 9 MB), PubMaps (jpg regenerated 1200px q85 from new PNG, margin values removed). Copied to each book's _output and venue; venue re-rendered; _site verified by md5 (checklistr 38/38, lists 42/42, pubmaps 39/39, voronoi 60/60). Awaiting Netlify upload (also carries the Voronoi rebuild).
- Netlify upload done; verified live: 3 covers byte-identical, voronoi PCSU acknowledgment live, pages HTTP 200. NEXT: Will McClatchey feedback on PubMaps guide; later add document names to remaining covers.

---

## 2026-10-26 -- PUBMAPS BECOMES AN R PACKAGE

- Preface: "Authors usually draw these maps only a few times in a career" (Kim's edit).
- Kim asked whether PubMaps should be a package; yes, before testing the guide (Ch 1 would change).
- `pubmaps` 0.2.0 built at `Projects/PubMaps/pubmaps/`: check clean, 9 tests, 7 maps byte-identical to the sourced code.
- `.Renviron`: GEONAMES_USERNAME, PUBMAPS_CACHE, PUBMAPS_REVIEW added. Kim's live session cleared of the sourced functions; `library(pubmaps)` loaded.
- Guide: Ch 1 rewritten (install_github, keys and folders, library), Appendix settings, Ch 3 redraw line. Book re-rendered.
- Kim's first test with the guide: era_36_10 (two districts, no villages) showed one district only. Fixed: studies with only districts/parks are framed by their outlines; inset avoids them. 7 test maps unchanged; check clean.
- Rivers added (Overpass; exact-name filter after a first version drew every "-ganga" tributary); pubmap_rerender("name") + clearer error. Check clean.
- Kim's rulings: GitHub at the end of the project; Will McClatchey as contributor confirmed; old code archived to `PubMaps/_archive/` (delete later).
- Kim's three display changes: country name on the inset (placed clear of the orange marker); complete legend strip under the map (`legend = FALSE` for journals that explain symbols in the caption; remembered per folder in display.rds); copyable caption symbol key on the review page + `symbol_key.txt` (Kim: "exactly in line with this being an editor's tool"). Guide Ch 2 + Appendix updated; book re-rendered; check clean.
- Guide (Kim's comments): Preface states the aim (the common map; clear naming of study areas and sites) + warning callout "Maps PubMaps does not draw". Ch 2 review page now embedded live in a scrolling frame (`book/examples/kasigau_review.html`, path genericised to C:/maps/review) instead of a top-only screenshot.
- Preface sentence: Kim chose the smoother version ("Most of his time went into reading..."). Ch 2: left/right -> first/second map (layout may stack).
- Ch 4 Worked Examples drafted from real before/after redraws (clean 'before' rebuilt from cached lookups in `C:/temp/pubmaps_examples_2026-10-26`): Kiteghe confirm (to-confirm 1 -> 0), Kerinci name moved, Yucatán include = name (inset moved, frame widened), places left off on purpose (Assam status table; Tsavo parks), Shewa legend = FALSE. Images in `book/images/examples/`. Chitwan example held: its intended point unclear.
- Kim: Ch 4 approved (Chitwan example dropped; editors use a computer, so wide tables are fine). Ch 6 Troubleshooting drafted from the code's own messages/statuses (18 entries: setup, redrawing, the map, the reading, starting again). Ch 5 (author) left for last.
- Ch 5 Working with the Author drafted from Kim's notes: accepted manuscripts; map queries go with other modifications; final map reviewed with the completed manuscript; coordinates come back in a simple email; attach map_vector.pdf; a messy map usually means an unclear manuscript (text editing, editor decides). Preface: screenshots blur; PubMaps maps are vector (Kim: "This feature alone might make PubMaps useful"). Part I now fully drafted. (Finding 055 recurred: reused book_v10 resent the old author.qmd; fixed via book_v11, md5 verified.)
- Close: Kim read Ch 5 + 6 ("They are great!"); he works on the cover and logo overnight. Next session: cover/logo, publish to kimbridges-documents, Part II Methods.
- Open: scratch `C:/temp/pubmaps_regress_2026-10-26` and `C:/temp/pubmaps_examples_2026-10-26` (delete after review).

---

## 2026-10-25 -- PUBMAPS: GEONAMES + FUZZY, AREAS, NAME CONTROLS, EDITOR'S GUIDE STARTED

- GeoNames (free server) pooled with Nominatim: 99 -> 114 places on 7 cases. Fuzzy pass: Kiteghe -> Kitege.
- Parks and districts drawn as shaded areas / dashed outlines (OSM polygons).
- Name controls in points.csv: label, label_pos, label_lon/lat, include = name (no symbol). lon/lat move the PLACE.
- Stale-code incident fixed: pubmap()/pubmap_rerender() reload all modules each run.
- Editor's Guide: Quarto book `PubMaps/book/`, Part I drafted (Preface, Ch 1-3, Appendix); Ch 4-6 stubs.
- Kim: "EXCELLENT start to the documentation"; has suggestions for next session.
- Next: Kim's guide suggestions; Kim tests against the guide; Ch 4-6; cover/logo; publish.

---

## 2026-10-24 (evening) -- PUBMAPS STEPS 2-5 BUILT: LOCATE, PLAN, RENDER, EDITOR REVIEW; ONE-CALL PIPELINE

**Active focus:** PubMaps (unchanged).

**Built:** `R/locate_places.R` (Nominatim + GeoNames backends, disk cache, feature-kind check, two-pass anchor tie-break, match categories stated/exact/partial/suggestion/none, flags generic/relative/far); `R/plan_map.R` (point selection with a reason for every place left off, UTM/LAEA, aspect-fitted frame, inset corner by overlap, widened when all corners busy); `R/render_map.R` (vector PDF + PNG, admin-1 lines, optional hillshade); `R/points_io.R` + `R/review_report.R` (editable `points.csv`; `review.html` with Leaflet check map, rendered preview, copy-ready author query, place table); `R/pubmap.R` (`pubmap()`, `pubmap_rerender()`).

**Results:** Nominatim located 108/167 named places; Yucatan order now correct; Kasigau, Yucatan, Shewa, Sumatra, Himalaya maps good; Simpson and Chitwan need GeoNames. Review page caught OSM's "Kitege" for the manuscript's "Kiteghe"; edit -> rerender round trip verified. All seven cases in `Projects\PubMaps\review\`.

**Late fixes:** review-page map showed "403 Access Blocked" in Kim's browser (OpenStreetMap tile servers refuse pages opened from disk); switched to Esri tiles with Streets / Topographic / Satellite layers; all seven pages rebuilt and verified (one missing map preview fixed).

**GitHub token renewed (Kim):** classic PAT in the Windows credential store only; `.Renviron` copy removed; `pkm_backup()` reads the store. Backup run: 1378 files, secret scan clean, commit 8c5fc8ceb9, push verified -- first backup since 2026-09-30.

**Kim at pause:** "a really big step forward today"; next he tries editor input himself and retests GeoNames.

**Open:** GeoNames premium still returns 401 (Kim's account propagating); alternate-name matching; areal context drawn as polygons; journal style file; methods doc.

---

## 2026-10-24 -- PUBMAPS INTAKE AND ACTIVE FOCUS; STEP 1 EXTRACT BUILT; R UPGRADED 4.3.3 -> 4.6.1 (paused for dinner)

**Active focus:** set to **PubMaps** this session (Rehearsals paused; block in `logs/focus_history.md`).

**Intake.** Kim's story: at Will McClatchey's, the problem of redrawing authors' maps as a journal editor -> Gemini-written R code (paragraph -> OpenAI -> YAML -> R -> PDF) with a 10-case test suite. New `proj_PubMaps.md`, index row, **Mapping family** cluster note; folder moved `G:\My Drive\PubMaps` -> `Projects\PubMaps` (88 files, verified). **Finding: the LLM invented site coordinates** (Yucatan towns in reversed east-west order).

**Rulings (Kim):** an EDITOR'S tool (or one person in a lab); gpt-4o-mini retired; division of labour -- LLM reads, gazetteer locates, code decides geometry, operator edits a points CSV, YAML only as the machine-written recipe; input = the WHOLE manuscript (McClatchey's time sink was finding every location). Design history recorded: YAML-first engine, LLM added later.

**Built:** engine audit (`pubmap_tools.r` current; renderer kept); `R/extract_places.R` -- whole PDF -> typed place table, coordinates only when stated. Seven era_old manuscripts: every place in the hand-written paragraphs found, more besides, ZERO invented coordinates; the test paragraphs themselves carried two errors (Simpson "centre" = an 1876 historical position; Sumatra extent from figure graticule labels).

**R upgraded (Kim's decision):** 4.6.1 + Rtools45 alongside 4.3.3; 495/495 packages restored (~9 min + 5 retried); ClaudeR 0.16.2; ellmer 0.5.0 works with Claude. GeoNames premium account recorded (`kimbridges`, `secure.geonames.net`).

**Written:** `proj_PubMaps.md` (new), `project_index.md` (focus, row, cluster note), `logs/focus_history.md`, `deferred.md` (new section: R uninstall, GitHub token, Gemini key), this entry; `Projects/PubMaps/R/extract_places.R`, `test_suite/extract/`; `Claude outputs/r_upgrade_2026-10-24/`.

**Mechanism 5 (partial -- session paused, not closed).** (8) Three items filed to `deferred.md`. (10) Outside `G:`: R 4.6.1, Rtools45 and the `win-library/4.6` library installed on Kim's machine. (11)/(12) NOT RUN: `pkm_backup()` is blocked until the GitHub token is renewed (`deferred.md`).

**Next:** step 2 LOCATE -- GeoNames premium, Nominatim fallback; source + match quality per point; misses -> author-query list.

## 2026-09-30 -- REHEARSALS TEST CASE 1: THE HUNTINGTON FROM KIM'S PHOTO ARCHIVE ("THIS IS WHAT A QUICK LOOK SHOULD PRODUCE")

**Active focus:** Rehearsals before the field (capture phase); Kim confirmed the Huntington as the first garden test.

**Materials (Kim):** the Huntington visitor map (construction-detours edition, June 2026, PDF) and 38 photos from several visits, 2018-2025 (folder `C:\Users\kim\Downloads\huntington_photos`, connected this session).

**The archive as data.** EXIF read with exifr in R: GPS in all 38 (two downloaded copies lost their dates), heading in 30, Kim's title (EXIF Description) in 31, 7 untitled. All 38 inside the OSM boundary of the Huntington (84.6 ha). OpenStreetMap supplied the boundary and 22 named garden units (no Desert Garden or Lily Ponds). `osmdata` installed in Kim's R; Overpass reached via the lz4 mirror after a 504.

**First map** (photos as points, plain tiles trimmed to the boundary, colored by Claude's grouping of 17 titles into 8 areas + untitled): tiles 0.33-14.5 ha (44x) -- two Mausoleum photos and the Entrance color the whole north incl. parking (the least information, the most color); the boundary includes nonpublic land (frame is a choice); effort (8 Japanese, 7 Desert, 1 Chinese); untitled = gray holes; one Sony 'Japan' photo inside the OSM Chinese Garden. **Kim:** "This actually does quite well. Better than I expected. This is what a 'quick look' should produce"; areas properly located; "I know where I'd take more photos."

**Photos only, no map (Kim's question):** box frame 58.1 ha; leaves out 30.5 ha of garden, takes in 4 ha of street; inside the overlap every tile identical (21 of 38 unchanged); largest tile 14.5 -> 5.5 ha, so the map LOOKS more even because the samples drew their own frame -- a frame of convenience flatters the sampling; lost: orientation and label-vs-place checks. Kim: worth doing; a different concern from vegetation boundaries.

**Written:** `ideas_rehearsals.md` (TEST CASE 1 section), `project_index.md` (NEXT), this entry. Figures sent to Kim: `huntington_tiles_v1.png`, `huntington_photos_only.png`.

**Mechanism 5.** (1) No new project (still capture). (2) No status changes. (3) No new files on G:. (8) Nothing for `deferred.md`. (10) Outside `G:`: `C:/temp/rehearsals_huntington_2026-09-30` (photo table CSV, OSM extract, objects RDS, figures -- KEEP until the rehearsals project has a home on G:); four PNGs in `C:/temp/tessellr_staging` (staging copies, deletable); `osmdata` package added to Kim's R library. (11) Health 21:08: 86 works, 0 reconciliation failures, 0 unsourced pages, 0 broken log pointers; carried: 4 drifting projects, 6 files over budget, 7 repo/clone mismatches, 5 C:/temp scratch folders (13 MB). (12) Backup: 1315 files, secret scan clean, commit 831de3f949, push verified against the server; second backup after this line.

**Next:** see the index NEXT line.

## 2026-09-29 (evening) -- REHEARSALS: CHOROPLETH VS TESSELLATION, POINTS AND THEIR SERVICE AREAS, AND SCALE AS A THEME

**Active focus:** Rehearsals before the field (capture phase), continued after the dinner break.

**Ideas captured in `ideas_rehearsals.md`:** (1) **A tessellation is not a choropleth** (Kim): boundaries first vs points first; the unit's ID vs the point's; a summary of the area vs the value at one spot; big polygons = sparse sampling -- Kim: a form of "the least information and the most color" looks like a chapter title. Gallery pair proposed: the same rain gauges as a district choropleth and as Thiessen tiles. (2) **Descriptive discipline** (Kim): use terms consistently ("value at the point"); a starter vocabulary drafted. (3) **Street-map overlay** (Kim): tiles over a simplified street map to orient readers; Skyline stations as the points (Kim has not seen such a map); color choice raised as a deliberate topic (Kim's interest). (4) **Lawn sprinklers, all equal** (Kim): traps in reverse; color = relatively more or less water; a quick first approximation; Voronoi vertices predict dry spots, overlap is what tiles get wrong; catch-can test at home. (5) **Points and their service areas** as the general idea, so counting in service areas finds the reader "half way there" (Kim). Cautions checklist now 15 items ("a tile is not a unit").

**Rulings (Kim):** scale runs through everything -- a theme of the companion document (lawn -> garden -> kipuka -> city -> island). Kim will gather materials (garden maps) so the ideas can be tried.

**Written:** `ideas_rehearsals.md` (five evening sections, status line, checklist item 15), `ideas_three_documents.md` (three more mapping lines), `project_index.md` (NEXT), this entry.

**Mechanism 5.** (1) No new project. (2) No status changes. (3) No new files. (8) Nothing for `deferred.md`. (10) Outside `G:`: `C:/temp/voronoi_build_2026-09-29` still deletable. (11) Health 20:49: 86 works, 0 reconciliation failures, 0 unsourced pages, 0 broken log pointers; carried: 4 drifting projects, 6 files over budget, 7 repo/clone mismatches, 4 C:/temp scratch folders (10 MB). (12) Backup: 1315 files, secret scan clean, commit 042cab485d, push verified against the server; second backup after this line.

**Next:** see the index NEXT line -- gallery template and vocabulary, a scale-ladder gallery order, a first quick test once materials are in.

## 2026-09-29 -- VORONOI CITATIONS CLOSED; "REHEARSALS BEFORE THE FIELD" FINDS ITS FOCUS: A GALLERY OF WHAT MAPS CAN (AND CANNOT) TEACH

**Active focus:** opened with none set; Kim chose the Voronoi open notes, then moved to the rehearsals idea (now the Active Focus, capture phase).

**Voronoi citations (closed).** Kim's notes (`Citation_details.txt`) + a web check agreed on Dirichlet 1850, Voronoi 1908, Brown 1965, Mead 1966 and the Stone & Pratt publisher line. One real fix: Snow's equal-walking-distance line around the Broad Street pump is in his report to the St James Cholera Inquiry Committee (1855, pp. 97-120), not the 2nd ed. of *On the Mode*; Kim chose to cite both. `references.bib` 17 -> 18 (+ `snow1855report`, Dirichlet DOI, Brown pagetotal, Stone & Pratt distribution note); `were_they_useful.qmd` Snow sentence split. Rebuilt in `C:/temp/voronoi_build_2026-09-29` (clean), venue `voronoi/` + `_site` md5 59/59, Kim redeployed, verified live from R. Only the UH/HVNP permission remains.

**Rehearsals -- ideas captured in `ideas_rehearsals.md`:** (1) campsites cut in a purchased square of dense conifers (Kim): sites placed by the user, trees simulated; area, trees per site. (2) Can AI help find borders? -- Honolulu's urban core; Claude's reply kept as DRAFT TEXT (Kim: "EXACTLY what we're after"): found borders, rule-derived borders (`trace_patch` on building density), AI removing friction -- and an AI-drawn line from general knowledge is "a hand-drawn map in disguise". Kim: a Skyline station is being built one block from his window. (3) Botanical gardens (Kim and Nancy's visits): garden unit map = the 1974 map, phone photos = releves; Kim's photo archive may already hold the data. (4) Rainfall and drought (Kim): Thiessen's home ground; several category dimensions; gauge network shrinkage (2,354 stations since 1838, 398 active 2017; HC&S 100+ gauges closed 2016) -- then-vs-now is partly network. (5) METAR coverage (Kim's past need): tiles as coverage maps. **Kim's reflection kept verbatim:** satellite spectral analysis was sold as a replacement for releves but saw only the canopy and fails to scale (too many small units); canopy height SUPPLEMENTS releves. A running **cautions checklist** (14 items) started at Kim's suggestion.

**Rulings (Kim):** the companion document's focus is "training before the trip" -- the concepts AND being able to use them; partly a **gallery of examples**, valued for what the portrayal teaches: from "I can make this kind of map" to "from this kind of map, I can learn ..."; "what we can't learn is also needed." Kim: these ideas are building arguments for the trilogy -- mapping written into `ideas_three_documents.md` (drought is the first example spanning value, space and time).

**Written:** `ideas_rehearsals.md` (focus ruling, five ideas, draft text, checklist, gallery-entry template proposal + drought sketch), `ideas_three_documents.md` (new section 'Rehearsals ideas that argue for the trilogy'), `project_index.md` (Active Focus, NEXT), `logs/focus_history.md` (09-27 block archived), `proj_Voronoi.md` (open note 2 resolved, log), this entry; `Projects/Voronoi/references.bib`, `were_they_useful.qmd`; `kimbridges-documents/voronoi/`, `_site/`.

**Mechanism 5.** (1) No new project (rehearsals still capture only). (2) Active Focus -> Rehearsals (capture). (3) No new files. (8) Nothing for `deferred.md`. (10) Outside `G:`: `C:/temp/voronoi_build_2026-09-29` (scratch, deletable now that the deploy is verified). (11) Health 16:37: 86 works, 0 reconciliation failures, 0 unsourced pages, 0 broken log pointers; carried: 4 drifting projects, 6 files over budget, 7 repo/clone mismatches, 5 C:/temp scratch folders (20 MB). (12) Backup: 1315 files, secret scan clean, commit 4ac5dbbb3a, push verified against the server; second backup after this line.

**Next:** Kim returns after dinner; see the index NEXT line (gallery template, gallery order, a first quick test).

## 2026-09-27 (evening) -- TESSELLR 0.1.0 BUILT AND RELEASED; VORONOI DOCUMENT AND PACKAGE BOTH COMPLETE

**Active focus:** tessellr (opened this evening, `proj_tessellr.md` NEW), then none -- Kim ruled both projects COMPLETE.

**The package, in one evening.** Kim approved the API (12 functions, 5 groups) and the order. Built on G: in the checklistr layout, files written in the cloud and handed over through a granted `C:\temp\tessellr_staging` with md5 checks. Tiles (tile_points with frame/clip modes, tile_measures, tile_pattern with random-trial reference, merge_tiles, boundary_bands); containers (count_in_tiles: counting frame, location uncertainty, Poisson + chi-squared from the Koch code; Kim asked for, and got, `allocation = "proportional"` alongside the document's strict rule); canopy (get_canopy_height for ANY frame via zoom-9 quadkeys -- Kipuka = 022300033; structure_classes; trace_patch = 94.5 ha; constrained_voronoi with a `sampled` layer and a field-recorded `point_class` override); weights (weighted_areas; Apollonius-disk test; Ch.7 people within 0.7%); checking (map_agreement; Ch.9 reproduced exactly). 92 tests, many reproducing the book's numbers; R CMD check 0/0/2 routine notes.

**Release.** README + v0.1.0; GitHub repo created with gh (Kim's PAT), working clone `C:\repos\tessellr` (bucket 5), secret scan clean, commit `510426a` verified on the server; `install_github` tested. The book's Appendix gained a 'tessellr package' section (install + function reference generated from the package), Ch.10 one sentence; rebuilt in `C:/temp/voronoi_build_2026-09-27b`, copied into the venue (md5), `_site` rendered, Kim redeployed; verified live from R.

**Rulings (Kim):** proj_Voronoi and proj_tessellr COMPLETE; open notes kept -- the UH/HVNP map permission (Kim, this week) and citation details Kim will check (list in `proj_Voronoi.md`). Active Focus left for Kim to set.

**Written:** `proj_tessellr.md` (new), `proj_Voronoi.md`, `project_index.md` (Active Focus, NEXT, two rows), `priorities.md`, this entry; `Projects/tessellr/` (package), `C:/repos/tessellr`, `Projects/Voronoi/appendix.qmd`, `were_they_useful.qmd`, `data/appendix_tessellr.csv`; `kimbridges-documents/voronoi/`, `_site/`. Snapshots in `C:/temp/pkm_close_2026-09-27`.

**Mechanism 5.** (1) New project: proj_tessellr.md (index row added). (2) Status changes: Voronoi -> Complete; tessellr -> Complete. (3) New files listed above. (3b) `ideas_rehearsals.md` (new capture note). (8) Nothing for `deferred.md`. (10) Outside `G:`: `C:/repos/tessellr` (bucket 5, keep), `C:/temp/tessellr_staging` and `C:/temp/voronoi_build_2026-09-27b` (scratch, safe to delete), close snapshots. (11) Health 21:01: 86 works, 0 reconciliation failures, 0 unsourced pages, 0 broken log pointers; carried: 4 drifting projects, 6 files over budget, 7 repo/clone mismatches, 4 C:/temp scratch folders (10 MB). (12) Backup: 1315 files, secret scan clean, commit e31d78148f, push verified against the server; second backup after this line.

**The small piece of work: "Rehearsals before the field" (idea capture).** Kim raised the Koch_voronoi `phase1_report.pdf` sensitivity tests; agreed to extend them into repeated simulations (hit and false-alarm rates), Kim favouring the "nothing there" and "fooled by effort" scenarios. Kim then added the Chapter 10 theme: practice exercises on a familiar place (botanical garden, large park) with one's own data, before costly field trips -- "just as you'd practice with a new digital camera"; the friction is finding a test site. Worked out: a three-rung ladder (simulation / practice site / field site), practice-site criteria, five exercises tied to chapters and tessellr functions, and the payoff of running the desk exercise on the real field site before going. Proposed form: a short companion document plus `simulate_*` helpers in tessellr. Kim: "I think we're on to something good." Captured in `ideas_rehearsals.md` (capture only, no intake).

**Next:** Kim sets the Active Focus next session; candidates are the rehearsals idea (first step: choose Kim's practice site) or the trilogy.

## 2026-09-27 -- *THE MAP THAT NEVER GOT DRAWN* IS PUBLISHED (THE 24TH DOCUMENT), AND ITS PACKAGE HAS A NAME: TESSELLR

**Active focus:** Voronoi (unchanged). Opened 10:59 HST after Kim restarted the RStudio addin (the session needed `connect_session("default")`).

**Finishing the book.** Kim's cover and logo (found at the project root and in Downloads; a 1275 px cover copy in `images/`). **Shared authorship** -- Kim's reminder, for this and ALL jointly created documents: `K. W. Bridges` + `Claude (Anthropic)` in `_quarto.yml`, a Preface paragraph, and a new rule in `style_multichapter_doc.md`. **Citations:** `references.bib` (17 works incl. R, sf, terra, tidycensus, tigris) + a References page; first mention per chapter cited. Web checks settled the Johnston 1996 venue (NCGIA Santa Fe CD-ROM) and confirmed Thiessen 1911, Tolan 2024, Mead 1966 and the Brown 1965 title; Dirichlet/Voronoi volumes, Snow 1855 and the Stone & Pratt publisher line are from memory, flagged for Kim. **Acknowledgments** in Kim's words (Tom Koch, Dieter Mueller-Dombois, Ev Wingert, Will McClatchey, Nancy Furumoto); the HVNP map permission Kim will obtain, not mentioned in the text. **Kim's full read-through: 'Excellent! This captures more than I expected when we started.'** **Appendix:** data files, scripts, the 15 chapter functions (both tables from CSV), `make_tiles()` and `nearest_type()` in full, software versions.

**tessellr.** Kim asked whether the code should become a package, as in other projects. Agreed: the method and the data source are only usable by others as a package; Koch_voronoi's `voronoi_functions.R` overlaps and folds in. Ruled: publish the document now, build the package next; Kim chose the name **tessellr**. Scope (~10 functions, incl. a canopy fetch for ANY area) in `proj_Voronoi.md` Next Steps 00.

**Published.** `G:/.../Voronoi/_output` became a ghost directory (listed, not `dir.exists`; Quarto: PermissionDenied) -- Finding 054; per the card, built in `C:/temp/voronoi_build_2026-09-27`. Deployed per the venue workflow: contents copied from R into `kimbridges-documents/voronoi/` (59 files md5-matched) + card cover; stub `docs/voronoi.qmd` (Maps, Ecology, Methods); `voronoi/**` in resources; `_site` rendered (25 pages); Kim dragged it to the existing site. **Verified live from R:** card on the index, title + both authors, Appendix (tessellr line), cover byte-identical.

**Cleanup (Kim, after the live check):** all of `C:/temp` except the 09-26 close snapshot (Voronoi staging and build, Smart Car builds, older snapshots and small scratch); the ghost `_output` has cleared.

**Written:** `proj_Voronoi.md` (status PUBLISHED, Next Steps 00 tessellr, log), `proj_kimbridges_documents.md` (24 documents, log), `project_index.md` (NEXT, two rows, CARRIED), `priorities.md`, `style_multichapter_doc.md` (shared authorship), this entry; `Projects/Voronoi`: `_quarto.yml`, `index.qmd`, `appendix.qmd`, `references.bib`, `references.qmd`, chapter citations (Ch.1-10), `data/appendix_*.csv`, `images/voronoi_cover_art_text.png`, `voronoi_logo_art.png`, `background/drafting_notes.md`; `kimbridges-documents`: `voronoi/`, `docs/voronoi.qmd`, `_quarto.yml`, `_site/`. Snapshots in `C:/temp/pkm_close_2026-09-27`.

**Mechanism 5.** (1) No new project file yet -- tessellr is recorded as proj_Voronoi's next phase; open `proj_tessellr.md` when work starts. (2) proj_Voronoi document phase complete; project stays Active for the package. (3) New files listed above. (8) Nothing for `deferred.md`. (10) Outside `G:`: only `C:/temp/pkm_close_2026-09-26` and today's snapshot. (11) `pkm_health()` (92 s): 86 works (voronoi registered), 0 reconciliation failures against live, 0 broken pointers; drift 4 and over-budget 6 unchanged; scratch 2 folders / 0 MB (was 18 / 368 MB). (12) `pkm_backup()`: 1296 files, 26 changed, secret scan clean, pushed and verified against the server -- head `bfef232`; re-run after this line was written.

**Next:** Kim returns to evaluate next steps -- tessellr first; open items for the book: the remaining citation checks and the HVNP map permission. Kim: 'Again, teamwork has paid off.'

## 2026-09-26 -- *THE MAP THAT NEVER GOT DRAWN*: ALL TEN CHAPTERS DRAFTED, AND THE DOCUMENT FINDS ITS ANSWER

**Active focus:** Voronoi (unchanged). One long session; the book went from three drafted pieces to ten chapters rendering clean as a whole.

**Chapters drafted today** (each read and approved by Kim before the next): Ch.1 altimeter story added; Ch.3 *The Study Area* (frames, edge tiles, the kipuka outline, ahupuaʻa -- Kim: 'a very important chapter... elevated to the right level'); Ch.4 *Kinds of Voronoi Maps* ('exactly the style that's needed'); Ch.5 *Reading the Cells*; Ch.6 *Tiles as Containers* (herbarium specimens, Kim's choice); Ch.7 *Weighted Voronoi* (Kim's five LA basin gardens; by pageviews the Huntington swallows the basin -- 'data exploration has a new tool'); Ch.8 *Adding What the Points Don't Know* (Meta/WRI canopy height, structure classes at 2 ha, structure-constrained Voronoi, the kipuka outline derived in code); Ch.9 *Good Enough?*; Ch.10 *Were They Useful?*.

**Kim's history turned two 'errors' into findings.** He supplied Loh et al. 2007 (Broomsedge Fire, 30 June 2000, east of the kipuka) and Stone & Pratt 1994 (cattle gone 1948; koa regrowth in old pasture). The R12/R08 label mismatches are 1954 names on today's canopy; R04/R05 sit in the burn; R01 perhaps the 1975 fire (no burn map). Kim's principle, now in Ch.8: results should provoke sharper questions, not end the examination.

**Kim's conclusion (recorded in `drafting_notes.md`, crafted into Ch.9-10):** plain Voronoi maps aren't good enough for vegetation maps; combined with other data they are; reproducibility is part of the value (hand-drawn maps hide their judgments); mismatches lead to 'why?' and new data; the study introduces a method and a data source. For Ch.10 he added: plain Voronoi is sometimes essential when boundaries needn't be exact (outbreak source, school siting), and maps built from points + rules + metadata make good archives.

**Numbers of record (Ch.9, twelve points):** area agreement with the 1974 map plain 45% / constrained 56%; 1974 boundary found within 50 m 17% / 58%; releve curve -- with stratified points the canopy does the work of about half the releves, no gain with random points; changed ground 15% of the area, ~a quarter of the disagreement; Johnston 1996's 52% as yardstick.

**New data and scripts (Projects\Voronoi):** `data/la_gardens.csv`, `la_land_frame.geojson`, `la_tracts_2020.csv` (`R/make_la_gardens_data.R`); `data/kipuka_puaulu_canopy_height.tif` (`R/make_kipuka_canopy_data.R`); `data/mdf1974_classes.tif` + `.csv` (`R/make_mdf1974_data.R`); `references/` +Loh 2007, +Stone & Pratt 1994 excerpt. Point labels R01-R12 added to ten maps at Kim's request.

**Mechanics learned:** a full book render from a background job needs `quarto::quarto_render(input = ".", quiet = FALSE)` -- with `quiet = TRUE` or no input it fails at once. `device_commit_files` can deliver a stale copy when a staged path is reused: always commit under a new file name and md5-check before copying into G:. Ch.9's releve curve takes ~7 min; cached.

**Written:** `proj_Voronoi.md` (chapter plan, conclusion, key files, log), `project_index.md` (NEXT), `priorities.md`, this entry; `Projects\Voronoi`: `_quarto.yml`, Ch.3-10 `.qmd`, `R/` (3 new scripts), `data/` (6 new files), `references/` (2), `background/drafting_notes.md`, `_output/` (full render). Snapshots in `C:\temp\pkm_close_2026-09-26`.

**Mechanism 5.** (1) No new project. (2) No Status change. (3) New files listed above. (8) Nothing for `deferred.md`. (10) Outside `G:`: `C:\temp\mwt_prototype_2026-09-25` (staging book_r14-r18, render_check, backup_labels_2026-09-26 -- all sources now in `Projects\Voronoi`; safe to delete) and `C:\temp\pkm_close_2026-09-26`. (11) `pkm_health()` (19:20, 95 s): 85 works, 0 reconciliation failures, 0 broken pointers; drift 4 and over-budget 6 unchanged (session_log 391 KB); scratch 18 folders / 368 MB. (12) `pkm_backup()`: 1290 files, 25 changed, secret scan clean, pushed and verified against the server -- head `cfeae14`; re-run after this line was written so the entry itself is backed up.

**Next:** Kim brings the cover and logo images; then the appendix (functions + data sources), the verify list (Snow 1855 line, Tolan 2024, attendance sources, Dirichlet/Voronoi/Thiessen years, Gilbert 1962, Brown 1965/Mead 1966, Johnston venue), Preface acknowledgements and the 1974-map permission note, and a full read-through. Kim: 'this is an excellent document... we got a lot finished.'

## 2026-09-25 (evening and night) -- MMU RULED 2 HA, AND *THE MAP THAT NEVER GOT DRAWN* GETS ITS FIRST THREE CHAPTERS

**Active focus:** Voronoi (unchanged). Kim returned from the pause at 19:54 HST.

**Minimum mapping unit (Kim's choice over real releve sites).** 0.25-16 ha tested on structure classes, output, and both: area agreement and precision creep up, boundary recall falls fast -- a scale choice, not a fix. Diagnosis: today's canopy edges sit within 50 m of 81% of the 1974 lines, but only ~52-60% of canopy edges fall on an expert line at any MMU; rebuilding classes on the 1974 rules (crown cover >5 m, 60%) did not change it. Surplus edges = generalised mosaics (savanna `mx-` units 53% closed canopy today) + change since 1954. **Kim ruled 2 ha for this area.** Figure `prototype/mmu_tradeoff_v1.png`.

**The book.** Kim turned to writing. Rulings: title ***The Map That Never Got Drawn***; source at the `Projects\Voronoi` root; Preface + Ch.1 + Ch.2 tonight. Style guide and association index read first. Drafted: Preface; Ch.1 *Where the Map Stopped* (Kim's opening -- simple Voronoi map, hand-drawn 1974 crop, the question left open -- then his story kept close to his words, the 1984 article, the friction gone); Ch.2 *What a Voronoi Map Is* (five markets, the halfway rule, three inputs, names, reproducible not objective, the 12 Kipuka Puaulu points from CSV, area table, a 'Useful?' callout). Code per the style guide; Okabe-Ito colors. Renders clean via `quarto::quarto_render` on G: (0 chunk errors, 5 gt tables, 3 figures).

**Kim's corrections folded in:** awareness began with the 1984 Arnold & Milne article; the code was FORTRAN, converted toward BASIC 'if memory serves'; **ethnobotany** added -- the first readers will be ethnobotanists (Preface paragraph, field lists, Ch.10 note); US spelling ('color'). Kim added **Johnston et al. 1996** (Pokegama River wetland: Thiessen polygons from 81 points, 'somewhat blocky'; 52% correspondence with airborne video -- held for Ch.9) -- cited in Ch.1 as proof the method reached vegetation mapping, and for the GPS friction. **At the close Kim told his own location story** (barometric altimeter set each morning at base station, then finding yourself on a topo sheet; inaccurate away from roads) -- captured verbatim in `background/drafting_notes.md` for Ch.1.

**Observation, not yet a finding:** `device_commit_files` delivered image files (Kim's JPG composite, a PNG crop) with DIFFERENT bytes from the source (sizes shifted by a few KB) while text files and PDFs matched by md5. Content looked right; treat image commits as re-encoded until checked.

**Written:** `proj_Voronoi.md` (MMU section, book files, notes, log), `project_index.md` (NEXT), `priorities.md`, this entry; `Projects\Voronoi`: `_quarto.yml`, `index.qmd`, `where_the_map_stopped.qmd`, `what_is_a_voronoi_map.qmd`, `data/` (2 CSV), `images/` (2), `R/fig_ch1_voronoi.R`, `background/drafting_notes.md`, `references/` (+Johnston 1996), `expert_map/mmu_results_2026-09-25.rds`, `_output/` (render). Text files md5-verified on copy. Snapshots in `C:\temp\pkm_close_2026-09-25`.

**Mechanism 5.** (1) No new project; proj_Voronoi updated. (2) No Status change. (3) New files listed above. (8) Nothing for `deferred.md`. (10) Outside `G:`: `C:\temp\mwt_prototype_2026-09-25` (scratch: prototype, expert-map work, book_r1-r3 staging, render_check -- all sources now copied into `Projects\Voronoi`; safe to delete) and `C:\temp\pkm_close_2026-09-25`. (11) `pkm_health()` (21:32, 74.7 s): 85 works, 0 reconciliation failures, 0 broken pointers, gate 0; drift 4 and over-budget 6 unchanged (session_log 383 KB); scratch 17 folders / 365 MB. (12) `pkm_backup()`: 1275 files, 13 changed, secret scan clean, pushed; verified against the server -- head `30dd5df`.

**Next (tomorrow):** Kim reads Preface + Ch.1-2; fold the altimeter story into Ch.1; then Ch.3 (study area). 'A good day' (Kim).

## 2026-09-25 (afternoon, interim -- Kim paused ~2 h) -- THE 1974 EXPERT MAP ARRIVES, AND THE 1954 LINES FALL ON TODAY'S CANOPY

**Active focus:** Voronoi (unchanged). PKM reopened 15:38 HST; nothing had changed since the noon close.

**Chapter plan approved** from Kim's outline and his story (colleagues stalled at the map; scribing, darkroom, pen plotters; code in the wrong language; the shelf). **Kim's opening:** a simple Voronoi map, then a hand-drawn vegetation map, and the question -- can tessellations match hand-drawn border complexity? -- left unanswered as tension. Kim supplied **Arnold & Milne 1984** (IEEE CG&A; Voronoi for Greek soil survey) from his separates -- it anticipates raw vs merged tiles, manual-mapping bias and the hybrid idea; to run through the document as a benchmark. Claim softened by Kim: 'I didn't see them', not 'not adopted'.

**Kim found the expert map:** Mueller-Dombois & Fosberg 1974 (CPSU/UH Tech. Rept. 4, 1:52,000; 1954 photos). Sheets 12 + 13 digitised in the sandbox (corner-mark homography, 69 regions coded, 7 classes), Old Hawaiian Datum -> WGS 84 in R. **Registration: 1954 boundaries sit on today's canopy edges.** 12 releves: area agreement plain 45% / within-structure 55%; boundary recall within 50 m 17% / 70%; constrained map over-fragmented (137 vs 51 km). Releve curve (6-192, 20 draws): structure-stratified releves -> canopy method leads to ~48, converges by ~96; random releves -> plain matches or wins from 12; structure alone plateaus ~64%. Kim: no problem getting permission for the report; a fire east of the kipuka changed vegetation, set aside for now.

**Written:** `proj_Voronoi.md` (plan, check, next steps, log), `project_index.md` (NEXT line), this entry; `Projects\Voronoi\references` (2 PDFs md5-verified; Kim's composite JPG arrived 5 KB larger than the upload -- re-encoded in transfer, not byte-identical), `expert_map/`, `prototype/` figures. Snapshots in `C:\temp\pkm_close_2026-09-25`. No health check or backup yet -- run at the real close.

## 2026-09-25 -- CANOPY HEIGHT GIVES VORONOI ITS BOUNDARIES: A KIPUKA PUAULU PROTOTYPE, AND A NEW DOCUMENT OPENS AS THE FOCUS

**Active focus at start:** the trilogy (capture only). **At end:** VORONOI -- a separate methods document, `proj_Voronoi.md` (NEW), Active / Ready. Session-start reads done (card, index, proj_PKM) via the device bridge; device_bash still cannot mount `G:`. TODAY bound 2026-09-25 HST in R (11:15).

**Kim set the day's focus on MWT** and opened with the data source it lacked (plots + an expert vegetation map). **His reframe:** an expert map uses TWO inputs -- releves for categories, air photo / satellite for boundaries -- so comparing it with a plain Voronoi map is not fair. **Canopy height is in important ways equivalent to seeing zone changes on imagery.** Question: can a small set of Voronoi sites plus canopy height get closer to a professional map? Claude: yes for structural boundaries, not compositional ones; three ways to combine (segment-then-label, cost-distance Voronoi, nearest in position + structure space); releve heights could set the breaks; test = agreement vs number of releves with and without canopy. **Kim's aim: "the enemy of good is better"** -- a reproducible good first approximation, fewer releves (friction), "good enough" as a research strategy. Start at Kipuka Puaulu, with stand-in categories (Kim knows the ground).

**Prototype, built in RStudio via the R bridge.** The July canopy route re-found in `specimen_labels/design_notes.md` (the code itself was never saved as a file -- now it is): Meta/WRI quadkey `022300033` via `/vsicurl`, cropped in 8 s; 3.2 x 2.6 km window on the photo-fix centroid; 5 m cells; four structure classes (<2, 2-5, 5-10, >10 m), 25 m smoothing, `sieve` 0.25 ha. A first 12-point systematic grid put 8 points on open ground and 1 in forest -- **replaced by 3 per structure class** (canopy data guiding the sampling is itself part of the method). **Structure-constrained Voronoi:** nearest releve in the same class; unsampled patches faded (16%). Plain vs constrained disagree on **66%**. Kim: *"It shows just what we need; realistic boundaries and an appropriate classification ... two relatively unknown technologies ... combine into something that's very informative."* Caveats recorded in the proj file (stand-ins partly follow structure; smoothing moves some releves' class; Meta is modelled, not lidar).

**★ Decision (Kim).** Kim uploaded `Voronoi_thoughts.txt` (an outline for a Voronoi document: use cases, per-cell statistics, weighted Voronoi, "once partitioned, ask") and asked: demonstrate Voronoi inside MWT, or a separate document? Claude recommended separate (different genre; the document + package pattern; Koch Next Steps 5-6 already called for it; it can move now). **Kim: "We've got a new document here" -- restructure and complete it, and finish it BEFORE the technology is discussed in the trilogy.** MWT keeps the concept and ONE worked example (Kipuka Puaulu in ch.8, the overlay); ch.5, 6, 9, 11 shrink to summary + reference; the MWT grid gains a cell (categories + boundaries computed from a continuous surface).

**Written:** `proj_Voronoi.md` (NEW; via the device bridge, fresh name, md5 matched through R), `project_index.md` (Active Focus, new row, Koch row pointer, date), `logs/focus_history.md` (the 2026-09-23 block, verbatim -- `identical()` TRUE), `ideas_three_documents.md` (2026-09-25 section + Next), `proj_Koch_voronoi.md` (pointer; Locations corrected to the renamed folder -- forward pointers only), `priorities.md`, this entry. R-bridge writes byte-level, CRLF preserved, read back by content. **New project folder `Projects\Voronoi` (bucket 2):** `prototype/` (script, figure, rds; md5-verified copies from `C:\temp\mwt_prototype_2026-09-25`) and `notes/Voronoi_thoughts_2026-09-25.txt` (Kim's outline, verbatim). Pre-edit snapshots in `C:\temp\pkm_close_2026-09-25`.

**Mechanism 5.** (1) Intake done: `proj_Voronoi.md` from `template.md`, track kimbridges-documents / R + Quarto, index row. (2) Status: Voronoi NEW Active / Ready; Koch Voronoi unchanged (Paused); trilogy paused (capture only). (3) New files: `proj_Voronoi.md`; `Projects\Voronoi\` tree. (8) Nothing new for `deferred.md`. (10) Outside `G:`: `C:\temp\mwt_prototype_2026-09-25` (scratch; its files now copied to the project folder) and `C:\temp\pkm_close_2026-09-25`. (11) `pkm_health()` (12:07, 96.6 s, run async): 85 works, 0 reconciliation failures, 0 broken pointers, pre-deletion gate 0; drift 4 and over-budget 6 unchanged from 09-23 (session_log now 376 KB); scratch 17 folders / 349 MB. (12) `pkm_backup()`: 1,263 files, 10 changed, secret scan clean, pushed; verified against the server -- head `eaf804e`. Retaken once more after this line was written.

**Next:** restructure Kim's outline into a chapter plan; real categories at Kipuka Puaulu (Kim relabels the 12 points or places his own); structure breaks from releve heights; read `Koch_voronoi\voronoi_functions.R`. Kim is taking a break and will be back later today.

## 2026-09-23 -- ALL THREE OUTLINED: *MEASUREMENTS REQUIRE CATEGORIES* GETS ITS BACKBONE, THE TRILOGY GETS ITS STATEMENT, AND MWT GETS ELEVEN CHAPTERS

**Active focus at start and end:** the trilogy, round two (capture only). Session-start reads done (card, index, proj_PKM), staged through the device bridge -- device_bash still cannot mount `G:`. TODAY bound 2026-09-23 HST (16:01 on the session clock).

**MRC round two.** Kim asked for a summary of what the PKM held on *Measurements Require Categories* (thin: mostly Claude's 2026-08-11 proposals), then set out his foundation: **every measurement comes with a classification, and its categories give the values meaning** -- agreed in medicine (a physician's temperature scale), loose and unspoken on a weathercast; **the unit-switch test** (the pause on hearing C instead of F); scales learned tacitly, by experience; unit changes carry friction; **devices teach how to measure, rarely the scale**; one measurement, several scales by purpose; **accuracy matters near a boundary**, where we bring in statistics. Then: scales can **describe** without a decision (14ers, tree line); **comparison** supplies a scale (runs vs the opponent's; "squeaked by", "clobbered"); **models** and **history** (records, top-10s, boundaries that move) set categories; scales are **personal** -- Kim's eight-bar Smart Car fuel-gauge ladder, set by remote Interstate driving; **several measurements combine into one category** (Whittaker, comfort index, soil texture) -- Kim: a chapter; categories are unequal and can be **"lumpy"** (Braun-Blanquet mixes cover and abundance). **Rulings:** backbone = **"where do boundaries come from"**; all of Claude's points belong in the argument; ch.7 (categories instead of measurements) and ch.8 (the inverse) are "strong additions"; working title kept. 8-chapter outline recorded.

**The set.** Claude laid the three side by side. **Kim ruled the unifying statement: "boundaries in value, space and time"** (MRC = value, MWT = space, S3 = time), and **MRC first in the series** -- settling open problem 2, the exposition order. *Maps with Tiles* kept as the working title, **short name MWT**; *The Missing Map* a candidate later title, parallel to S3's missing scale.

**MWT.** 11-chapter outline accepted. Raw vs dissolved tiles elaborated at Kim's request (raw shows the evidence, dissolved the pattern; each dissolved boundary sits halfway between two disagreeing samples, so its uncertainty is local and computable). **Counterexample: the continuum** (ecotones; Gleason vs Clements). **The Koch method -- tiles from one dataset, counts from another -- is its own chapter**; Kim: the counted items are located independently of the area mapping; "counting within units could be a very common application." Neutral example: invasives or diseased plants (Kim's Ailinginae Atoll palm count kept as a memory, not the example).

**★ Writing ruling (Kim, at the close): load the trilogy documents with personal stories**, as in earlier documents.

**★ Finding 055 recurred -- and says something new.** The first commit of `ideas_three_documents.md` went from `outputs/ideas_three_documents.md` -- a DIFFERENT path from the staged `uploads/.../ideas_three_documents.md`, but the SAME basename. The bridge reported `written`, refreshed the mtime, and left the old 27,359 bytes. Recommitted from a fresh basename; md5 matched through R. **This suggests the trigger is the basename, not the path** -- one occurrence, so a suspicion to watch, not yet a rule. The existing rule (fresh name, md5 through R) held.

**Written:** `ideas_three_documents.md` (MRC round two; the set + MWT; the personal-stories ruling -- first two via the device bridge under fresh names, md5-verified; the third via the R bridge), `project_index.md` (Active Focus + date), `logs/focus_history.md` (the 2026-09-22 block, verbatim), `priorities.md` (date + pointer), this entry. R-bridge writes byte-level with CRLF preserved and read back by content. Pre-edit snapshots in `C:\temp\pkm_close_2026-09-23` (bucket 4).

**Mechanism 5.** (1) No proj file for the trilogy -- capture only by Kim's 2026-08-11 ruling; all three now have outlines, so formal intake is Kim's next call. (2) No project Status changed. (3) No new files in the system. (8) Nothing new for `deferred.md`; the verify lists live in the ideas file. (10) Outside `G:`: only `C:\temp\pkm_close_2026-09-23`. (11) `pkm_health()` (16:47, 94.8 s; the bridge timed out at 60 s and the report was read instead -- Finding 031): 85 works, 0 reconciliation failures, 0 broken pointers, pre-deletion gate 0; 4 drift flags (checklists code newer than its proj file; two stale locations), 6 files over budget (session_log 371 KB, Smart_Car, deferred, seasonality, audio, the card 0.4 KB), 15 scratch folders / 346 MB in `C:/temp`, 11 past the 14-day threshold. None new this session except this session's snapshot folder. (12) `pkm_backup()`: 1,261 files, 7 changed, pushed; verified against the remote -- `main` on GitHub = local head `f32dadf`. Retaken once more after this line was written.

**Next:** data sources -- a site with plots + an expert vegetation map; an invasive / diseased-plant point dataset; S3's station, vintage and fire data. Then worked examples for MRC ch.5-7, the shared visual vocabulary, package boundaries. Kim will be back later today.

## 2026-09-22 (evening) -- S3 GETS ITS NAME, FRICTION BECOMES A SPINE, AND *MAPS WITH TILES* FINDS ITS EMPTY CELL

**Active focus at start and end:** the trilogy, round two (capture only). Second sitting of the day; TODAY re-bound 2026-09-22 HST (20:49). Morning writes confirmed present through the R bridge before work began.

**S3.** Kim asked whether the document had a title; Claude argued the working title named the method, not the subject, and proposed *Spells, Stretches and Snaps: Reading the Scale Between Weather and Climate*, with *Baselines, Deviations & Spans* kept as the heading for the method chapters. **Kim accepted and named it S3.** Kim brought in operational definitions (Bridgman -- the spelling corrected, *The Logic of Modern Physics*, 1927) and "no concept, no seeing" at several levels -- the weather/climate gap and the unfamiliar implementations. Claude: three nested levels (scale, vocabulary, operation); strictly, five operations are five concepts, and the disagreement map shows Bridgman's problem. **Ruling: Bridgman lightly in S3, fully in *Measurements Require Categories*.** Agreed S3 is ready to outline; **Kim paused it** so another document can feed back.

**Maps with Tiles, round two opened.** Claude recommended it next (a spell partitions time as a tile partitions space; it tests the shared visual language; Categories stays last as synthesis). Kim framed it as an ecologist: point, isopleth, choropleth and entitated vegetation maps are familiar; **the category-at-points map drawn as tiles is overlooked**, because it cannot be drawn by hand, and colleagues would not recognise "Voronoi" or "Thiessen". Rulings: **"reproducible", not "objective"**; tiles matter because without clear pattern information **no lines get drawn and the analysis is incomplete**; **friction is a really big idea**; mapping was hard and now is not, so examples will help; few kinds of maps makes mapping simpler. Kim attached **Andrews et al. (1981), *A Guide for Selecting Statistical Techniques for Analyzing Social Science Data*** as the decision-tree model. A draft two-question, seven-outcome map tree recorded. No suitable vegetation map in hand; Kim will look.

**★ FRICTION ruled a major component of S3 and of the trilogy (Kim: "We need to make sure we don't forget it").** Two spines: conceptual (no concept, no seeing) and practical (friction), each keeping the other in place.

**Written:** `ideas_three_documents.md` (S3 cont.; friction; Tiles round two; the draft tree), `project_index.md` (Active Focus), `priorities.md` (pointer), this entry. R bridge, byte-level, CRLF preserved, read back by content. Pre-edit snapshots added to `C:\temp\pkm_close_2026-09-22` (bucket 4; the bridge cannot delete recursively -- Kim may remove the folder once satisfied).

**Mechanism 5 notes.** No proj file for the trilogy by Kim's ruling (capture until outlines). No project Status changed this sitting. Nothing new for `deferred.md`.

**Next:** *Maps with Tiles* -- more ideation (raw vs dissolved tiles, edges, study area) or the tree as a diagram. Kim wanted time to think first.

## 2026-09-22 -- TRILOGY ROUND TWO: *Baselines, Deviations & Spans* finds its scale; icons paused for photographs

**Active focus at start:** icons, OPEN (Active / Ready). **At end:** the trilogy, round two (capture only); icons PAUSED (Active / Blocked on photographs). Session-start reads done (card, index, proj_PKM); TODAY bound 2026-09-22 HST. First session after a nine-day break (family priorities).

**Session start.** The local Filesystem MCP connector failed every call (JSON-schema dialect error: draft-07 vs 2020-12) -- worked around through the device bridge and the R bridge. device_bash cannot mount `G:`, as the card says. Staged-copy staleness (Finding 013) was flagged at start because nine days had passed; Kim confirmed nothing had happened in between.

**Icons paused (Kim).** He needs to find and take new photos. `proj_icons.md` Ready -> Blocked, blocker named; next steps unchanged.

**The three themes located.** Kim asked whether the PKM held a record of three themes he wanted to pursue. Found through `priorities.md` (★ NEW, captured 2026-08-11) -> `ideas_three_documents.md`, untouched since. The capture-only note did its job: six weeks later the thinking was intact, with Kim's rulings and the open problems.

**Round two -- Baselines only.** Kim opened with *spells, stretches and snaps*: common terms whose endpoints can be defined while the middle (the "noise") is ambiguous. Formal definitions proposed (snap = rate of change against recent days; spell = threshold departure against the normal; stretch = persistence) -- Kim: "a strong baseline for the discussion." Five implementation strategies (strict run, gap tolerance, hysteresis, window mean, state model), each a theory of the word -- **Kim: the implementations are the most interesting part, because they show strategies for thinking about the terms.** Kim then **reframed the whole document around the scale between weather and climate** -- a season up to a good part of a year, the farmer's and the vintage's scale. **Both directions** (Kim: conservation looks forward -- should we conserve water?), with the groups who use this scale as the way to make readers see its importance. **Rulings:** three worked groups -- fire, vintage, tree rings -- others later; **Hawai‘i is a test of generality, not the setting** ("might even be a distraction"). **Closing note from Kim: a rich visual language -- images, charts, diagrams -- will tie all the documents together.** Working seven-part outline for Baselines recorded.

**Written:** `ideas_three_documents.md` (Round two section + a new Next), `project_index.md` (Active Focus + icons row), `logs/focus_history.md` (icons block, verbatim), `proj_icons.md` (paused, Blocked, log), `priorities.md` (pointer), this entry. All through the R bridge, byte-level with CRLF preserved, read back by content. Pre-edit snapshots in `C:\temp\pkm_close_2026-09-22` (bucket 4 -- delete once the next session confirms the files).

**Carried:** factual claims made from general knowledge, listed for verification in the ideas file (ETCCDI, the old UK Met Office drought definitions, Ashenfelter, S2S); card 0.4 KB over budget; `C:/temp` scratch; the Filesystem connector error.

**Next:** Kim chooses -- round two on *Maps with Tiles* and *Measurements Require Categories*, or outline *Baselines* (ready now).


## 2026-09-13 (evening) -- icons: THE REGISTER REACHES 40, THE VISUAL DESIGN IS SETTLED, AND FINDING 055 GETS ITS NUMBER

**Active focus at start and end:** icons, OPEN (Active / Ready). Second sitting of the day (TODAY bound 2026-09-13 HST; UTC was already the 14th).

**Register to the cap.** The six queued resident icons added (pidgin, Merrie Monarch, malasadas, paniolo, Hokule‘a, nene) -> **40 rows**: 24 pass, 14 borderline, 2 deliberate fails. Recognized: both 26, resident 6, outsider 5, few 3. The quadrants now mean something: high-distinct / low-recognition is the resident treasure the "encounter each one" theme exists to promote; outsider-only is the appropriation set.

**Housekeeping (Kim: "easy to forget the mundane tasks").** `audience` dropped (agreed with `recognized` on 39/40; pre-drop snapshot in `C:\temp\icons_2026-09-13`), `pairs_with` added (hula <-> Merrie Monarch, wa‘a <-> Hokule‘a, grass skirt <-> hula; tiki, poke, poi noted in-row). `olfactory` stays provisional until a row uses it.

**★ FINDING 055 -- the commit-side stale copy, reproduced byte-for-byte.** Committing a revised `proj_icons.md` from the SAME staged filename reported `written` and refreshed the mtime, but the bytes on `G:` were the FIRST version (6,204 B / md5 b188... vs intended 6,826 B / md5 d5c9...), read through the R bridge. Third occurrence today; `force = TRUE` does not bypass it. **Rule: never commit the same staged filename twice -- date-suffix a copy, commit, md5 through R.** Written to `pkm_findings.md`; one-line trigger added to the card (now 6.4 KB vs 6 KB budget -- `pkm_health()` will flag it; move older material out, do not shrink the row). All later commits this session used fresh names and were md5-verified.

**Visual design, settled jointly.** Kim showed a flat poster-style rendering of Diamond Head Lighthouse made from his own photograph -- the Matson / tourist-bureau dialect, adopted knowingly, which turns the kitsch risk into a method. Agreed: **two tiers.** Posters generated from Kim's photographs via the OpenAI API driven from R (the register builds the prompt; `confusable` is the do-not clause; fallback allowed, the agent-driving lesson is a goal in itself), and vector glyphs as SVG under one grammar. Kim: images come from his photographs by intention, so a visitor can say *"I can take that picture, too."* Objective updated with that line.

**Photo supply is the constraint.** `photo_log.csv` created as the shot list (40 rows, stand-in subjects for the 12 non-visual icons; `photos/`, `posters/`, `glyphs/` folders). Kim filed two Diamond Head photographs (hotel view, jetty view; 2013 and June 2026) -> 1 `have`, 39 `need`. His archive is mid-migration (QNAP -> Lexar SSD). The project will run in spurts; the PKM carries it between them.

**Written:** `icon_register.csv` (40 rows, 15 cols), `photo_log.csv` (new), `README.md` (codebook extended), `pkm_findings.md` (Finding 055), `pkm_card.md` (one row), `proj_icons.md`, this entry, the index block. Register/log/findings/card via the R bridge, read back; proj/index/session_log via the device bridge under FRESH staged names, md5-verified through R.

**Carried:** nothing new to `deferred.md`. The 2026-09-05 stale-copy note is now CLOSED by Finding 055. Card over budget by 0.4 KB (flag expected).

**Next:** the first poster (R function: register row + photograph -> OpenAI image edit) on Diamond Head, and the first three glyphs (Diamond Head, Arizona Memorial span, Kamehameha arm) to test one grammar across landform, building, figure.

## 2026-09-13 -- NEW PROJECT: *icons* -- Hawai‘i's icons as a register; 34 rows in one sitting, and the classification broke and was repaired four times

**Active focus at start:** sake_brewery, CLOSED (published 2026-09-05). **Active focus at end: icons, OPEN (Active / Exploring).** Session-start reads done (card, index, proj_PKM); TODAY bound 2026-09-13.

**What happened.** Kim opened a new project, *icons*, to characterize how people think about Hawai‘i through its icons. He proposed "icon = visual metaphone"; discussion moved the definition to the referent ("something between a metaphone and a metaphor") and settled the operating test: **a Hawai‘i icon is an object, place, sound, word or practice that a person with NO caption resolves to "Hawai‘i" and to nothing else.** Three goals in sequence: register -> rendered symbol family -> the story of each; a theme ("if you come to Hawai‘i you should encounter each of these") and a testable claim (highest icon density anywhere). Intake done (Mechanism 1): `proj_icons.md`, index row, Active Focus block; the superseded sake_brewery block moved verbatim to `logs/focus_history.md`. Track: R on Kim's machine. `Projects\icons` created through the R bridge (probed three ways, Finding 054) with `icon_register.csv` + `README.md` codebook.

**The register: 34 rows by session end**, argued in batches of three with a ruling on each. 20 pass, 12 borderline, 2 deliberate fails (Hawaiian pizza, wiki) kept because they define boundaries. Origins: native_hawaiian 9, missionary_monarchy 5, local 5, external 4, territorial_tourist 4, natural 3, plantation_immigrant 3, military 1. Channels: visual 16, gustatory 7, auditory 4, lexical 4, kinetic 3.

**The classification broke four times and each break became a rule (all Kim-ruled):**
1. **`external`** added to origin -- made elsewhere and attributed to or named for Hawai‘i (Hawaiian pizza, tiki, grass skirt, wiki). Kim: keep it, the appropriation class is interesting.
2. **`missionary_monarchy`** (1820-1893) added -- muumuu, Kamehameha statue, ‘Iolani Palace, the flag, *Aloha ‘Oe*. Kim: qualifies, important to local people.
3. **`caption_test` split into `distinct` + `recognized`** after loco moco: maximally distinctive, barely recognized outside the islands. The old column conflated distinctiveness with recognition. All rows recoded.
4. **`local`** added -- the fused post-plantation multi-ethnic culture (shaka, plate lunch, loco moco, Spam musubi, slippers). Kim: yes.
Plus `olfactory` added to channel, PROVISIONAL (plumeria's strongest key is scent).

**Patterns worth carrying.** (a) The borderlines all fail the same way: a stronger confusable that Hawai‘i once owned and lost -- surfboard to California, steel guitar to Nashville, poke bowl to fast-casual, pineapple to "tropics", tiki to Polynesian pop. **The density claim may need restating as "most icons ORIGINATED here" vs "still exclusively OWNED here", and the gap is the finding.** (b) Outsider/resident pairs on one referent recur (hula girl vs halau; grass skirt vs pa‘u; tiki vs ki‘i; poi as joke vs Haloa) -- a `pairs_with` column is likely. (c) `audience` agrees with `recognized` on 33/34 and is redundant; drop it when Kim rules. (d) Natural-origin plants are all borderline (pan-tropical); landforms pass cleanly.

**Written:** `proj_icons.md` (new), `project_index.md` (Active Focus + row), `logs/focus_history.md` (superseded block), `Projects\icons\icon_register.csv` (34 rows), `Projects\icons\README.md` (codebook). Index/proj/log files via the device bridge, CRLF preserved and verified by content after a fresh stage; register and codebook via the R bridge, read back after every write.

**Carried:** nothing new to `deferred.md`. The commit-side stale-copy finding still awaits a number in `pkm_findings.md`.

**Next:** a few more candidate batches (resident quadrant is thin: pidgin, Merrie Monarch, malasadas, paniolo, Hokule‘a, nene), then the first symbol -- Diamond Head, the single-line profile.

## 2026-09-05 -- A NEW PROJECT WRITTEN END-TO-END WITH THE PKM CLOSED: *THREE WAYS TO LET GO OF THE RICE* (sake_brewery); FIRST SESSION ON CLAUDE FABLE 5.1

**Active focus at start:** Smart_Car, CLOSED (published 2026-09-03; "nothing scheduled"). Kim opened the session as a deliberate experiment on the new model with the PKM kept closed, then opened the PKM once the result was approved. New focus: **sake_brewery -> kimbridges-fiction.**

**What was built.** From Kim's diary entry `brewery_visit.txt`, seven Google Docs of pre-trip reading (Sake in Kyoto; Discussing Sake; Kyoto Sake Rice Sourcing; Rice Milling and Sake Quality; Kyoto Water and Sake Quality; A Focus on Kyoto's Sake Breweries; the Wabunka booking) and the 34 tour photographs: a first-person story, ~6,150 words in 12 sections, dialogue among Kim, Nancy, the brewery's production manager and the Wabunka interpreter Naomi; 22 photographs placed at their scenes; **11 small infographics** (water hardness, grain anatomy, the grade ladder, koji vs tank climates, parallel fermentation, the three extraction methods, the tasting matrix, the tongue's verdict, the SMV scale, fermentation temperature, the many-columns table, a timeline). Web version as a self-contained HTML (photos as data URIs, inline SVG, light/dark) and as a Claude artifact. Then the Fiction-site build: 40-page 6x9 PDF printed from the same HTML through Chromium, cover thumbnail, `works/` stub.

**Kim's verdict:** *"Otherwise, this is perfect!!! It is just like what happened on that day."* One photo fix (bottles-after-labeling belonged in the label scene; the final pair was a duplicate -- the better door portrait kept).

**★★★ Two corrections came from READING THE PHOTOGRAPHS, not the notes.** The koji-room sign: above 35 °C, under 60% RH, three days (the diary had 40 °F / 35% RH -- a transcription slip). The tasting slide: glass 4 is SMV +4.0, drier by the meter than glasses 1-3, while the diary says it tasted softer; the story keeps both and makes it a lesson. The slide also supplied yeast 1801 for the Jurakudai line and **Kyo no Kagayaki rice with yeast 221** for the Koto Origarami. All five specs recorded in `proj_sake_brewery.md`.

**Rulings (Kim).** First person, Kim narrating. Real names for Kim, Nancy, Naomi and Akira Sasaki; the production manager's name invented ("Hayashi-san") and declared in the opening note. Source of record stays in `Projects\sake_brewery` (bucket 2); the venue cross-posts. Venue = kimbridges-fiction.

**Applied without asking, flag for veto:** the standing joint-authorship rule (2026-09-02) -- cover and front matter read "Kim Bridges · with Claude (Anthropic)".

**Infrastructure notes.** (1) The sandbox cannot fetch from `lh3.googleusercontent.com` (proxy 403), so Google Photos album links are read-only from here: the album grid was viewed in the built-in browser to identify frames, and the originals came via a connected folder. (2) `G:` did not mount in `device_bash` this session ("failed to mount"); everything went through stage/commit, 34 originals in five batches under the 50-second budget. (3) Google Fonts are unreachable from the sandbox; the PDF uses local Lora / TeX Gyre Pagella / TeX Gyre Heros / Noto Serif CJK JP, and the web page falls back if fonts.googleapis.com is blocked for a viewer. (4) `session_log.md`, `project_index.md` and `logs/focus_history.md` are CRLF; edited as bytes with line endings preserved (the 2026-07-29 `writeLines` hazard). (5) **Finding candidate, the commit-side twin of 013:** `device_commit_files` given the SAME `stagedPath` a second time in one session wrote the FIRST version -- the R bridge read back the old bytes (size 363,755, no new paragraph) while the tool reported `written`. Committing the edited file under a NEW staged filename landed it. Rule: never re-commit a path you have already committed this session; copy to a fresh name first, and read CONTENT back through the R bridge.

**Files written.** `Projects\sake_brewery\three-ways-to-let-go-of-the-rice.html`, `...\Three_Ways_to_Let_Go_of_the_Rice.pdf`; `kimbridges-fiction\pdfs\Three_Ways_to_Let_Go_of_the_Rice.pdf`, `images\Three_Ways_to_Let_Go_of_the_Rice.jpg`, `works\three-ways-to-let-go-of-the-rice.qmd`; PKM: `proj_sake_brewery.md` (new), `project_index.md` (Active Focus, two rows), `logs/focus_history.md` (superseded block filed), `proj_kimbridges_fiction.md` (status, key files, log), this entry. Nothing written outside `G:` except the Cowork sandbox build tree (ephemeral; no bucket 4 or 5 writes).

**Close (items 11-12, run over the R bridge).** `pkm_health()`: 85 works registered (the new stub counted); **1 reconciliation failure, expected** -- `fiction / three-ways-to-let-go-of-the-rice` rendered FALSE, live 404, because the render + deploy is Kim's step; 0 rendered-without-source, 0 broken pointers; 4 drift rows and 6 over-budget files carried from before; `C:/temp` scratch 344 MB in 12 folders (bucket 4 retention overdue -- see 2026-09-03 carry). Both calls hit the 60-second bridge timeout and completed anyway (Finding 031: read the artifact, not the timeout). `pkm_backup()`: first run committed `128d2344` (8 changed of 1257 tracked, `Projects\sake_brewery` now mirrored) but the push died with `SSL error: syscall failure`; a second run had nothing to commit; a direct `gert::git_push(verbose = TRUE)` then succeeded and **the remote `refs/heads/main` reads `128d2344` -- verified against the server, not the return value (Finding 028).**

**★★★★★ PUBLISHED, SAME SESSION.** Kim rendered and deployed: *"The story is now up and available on kimbridges.info."* His close: *"It was an experiment, and it was very successful. It was a pretty complex editing and assembly job. This shows there is a new, and maybe better, way to produce stories that document our past trips... I'm glad you're listed as the co-author."* `proj_sake_brewery.md` set **Complete / Not applicable**; index rows and Active Focus closed; the staged-state focus block filed in `logs/focus_history.md`. `pkm_health()` re-run and `pkm_backup()` at close (results in the proj file's 2026-09-05 log entry).

**Queued.** Nothing scheduled; Kim returns tomorrow. Candidates he may pick up: the method as a template for other trip stories (proj_Trip_Log / proj_storylines); a four-voice narration (proj_audio.md); a numbered finding for the commit-side stale copy.

---


## 2026-09-03 -- *SMART CAR* IS PUBLISHED. THE 23rd DOCUMENT, AND A NEW VENUE CONVENTION

**★★★★★ LIVE at https://kimbridges-documents.netlify.app/smart_car/.** Kim: *"Bingo! It all worked... Thanks, so much, for all the help in turning a bunch of scan sheets into an interesting story, along with unique ways to analyze travel data. It was a big job, one of our longest running projects. But it was well worth it. The collaboration made it happen."* `proj_Smart_Car.md` set **Complete / Not applicable**.

**Kim read the book in two passes and sent 13 fixes.** Fig 1.5 (the carry-on bags were already in the car, not still to come); ch.14's **"11 Provinces"** relabelled *provinces and territories* -- the count is right, the noun was not, and ch.13 carried the same defect unflagged; the Afterword's Alberta caption rewritten to *poised to enter*; the Foreword's "several hundred pages" corrected to "dozens of pages, each full of handwritten lines"; §1.5's "the bars above" made a real `@fig-fleet-timeline` reference -- **it had been pointing forward, not back**; a full-size TwoFer photograph added to §1.8; Fig 2.1, 7.1, 13.1, 13.2 and 14.1 recaptioned. **Fig 7.1 was factually wrong** -- the car went north by ferry to Haines and drove from there.

**★★★ THE TWO OPTIONAL PHOTOGRAPHS BOTH EARNED THEIR PLACE, AND THE EXIF PROVED IT.** `kwb_5d3_34771_C.jpg` is the Anchor Point sign: 2013-08-25, 59.774 N 151.867 W. Ch.4's corners panel closed on *"Four of the seven corners. San Antonio, Anchor Point and Mount Evans have no picture."* **It is now five of seven.** `kwb_5d3_35490_nikb.jpg` is the Alaska Railroad entering the Whittier tunnel, 2013-08-26 at the west portal -- §7.4 had no figure at all, and it is the section about a one-lane railway tunnel cars queue for.

**★★★★ THE COVER IS THE BOOKEND, AND IT WAS FOUND IN THE RECORD, NOT THE PICTURE.** Kim supplied `cover_image.jpg` and asked whether it worked. Its EXIF says **2014-04-30 08:43:18**; the trip log's first leg of `2014_PenultimateState` starts **08:50, Lake San Marcos CA, odometer 40,682**. **Seven minutes before the trip that completed the states and provinces pulled out of the driveway** -- and the book's last photograph is the same car at the Alberta sign five and a half weeks later. Kim placed it as The Chateau, Lake San Marcos, and ruled that **his mother and Nancy, at the side of the frame, are not named in the caption.**

**★★★ WHAT I HAD MISSED, AND KIM CORRECTED: THIS IS A *DOCUMENT*, NOT A STANDALONE BOOK.** I was finishing it as a book; the destination is the kimbridges.info Documents venue, which has conventions. Reading `style_multichapter_doc.md` and `proj_kimbridges_documents.md` found the one gap that would actually have broken: the cover had to be a **PNG named `<name>_cover_art_text.png` at the PROJECT ROOT**, because that is the path the listing card points at. Also applied: navbar logo, `output-dir` back to `_output`, and one `styles.css` setting the book-wide base type. **Two deviations kept deliberately and recorded:** no `code-fold` (every chunk here is a one-line figure call) and *Foreword* rather than *Preface*.

**★★★ NEW CONVENTION -- WEB-SIZE THE PHOTOGRAPHS, AS A BUILD STEP.** At native size the document rendered to **80.1 MB**, 77.6 MB of it images, the largest a single **10.6 MB** photo, against a venue already near 400 MB. Kim asked whether R could do what would have taken a long while in Photoshop. `R/resize_images.R` at **1800 px / q88**: images **178.4 -> 47.1 MB**, rendered document **80.1 -> 26.6 MB**, largest survivor 1.27 MB. ★ **It runs against the SCRATCH BUILD TREE, so the full-resolution originals on Drive are never rewritten**, and it skips rather than re-encodes anything already small enough. Verified by reading max long edge back off disk, and by a 1:1 crop of the worst case in the set -- a gravel driveway. Kim chose q88 over q82 when shown measured sizes for both.

**Deploy.** Copy from R into a fresh `smart_car/`, checked for the coenosr nesting slip. `docs/smart_car.qmd` with **Data Analysis / Data Visualization / Maps** -- `Travel` was proposed and dropped, so the venue vocabulary stays at 18 tags and the guide's 1-3 limit held. `_quarto.yml` edited in BINARY (CRLF): **byte delta exactly 20**, CR/LF 47/47 -> 48/48. `src=` walk **276 references, 0 missing**, run twice. `_site` **1092 -> 1182, 0 removed**; reconciles 23/23/23/23. Kim drag-deployed to the existing tile.

**⛔⛔ AND A PKM ENTRY WAS RETRACTED THE SAME DAY IT WAS WRITTEN.** `deferred.md` said the ghost `book/_output` had "resolved itself overnight" and proposed deleting `_preview` as redundant. **Both were wrong.** I repeated the error myself, telling Kim a reboot had cleared it after a three-way probe returned TRUE. It had not: three renders died on `PermissionDenied: stat '_output'`. ★ **After a reboot, `file.exists()`, `dir.exists()` and `file.create()` ALL return TRUE on a ghost while `file.access()` returns -1 and `file.info()` on its contents returns NA.** Repointing `output-dir` and adding a `.quartoignore` both failed -- Quarto's project scan walks the folder regardless. Finding 054 amended; the `deferred.md` entry marked RETRACTED with its original text left in place.

**✓ The em-dash carry-forward is CLOSED at zero.** Counted by the UTF-8 byte sequence rather than a text search: 0 across all sixteen files, and only 17 non-ASCII bytes in the whole book. **The carried figure of ~78 was stale** -- the pass had already been done and the note outlived it.

**Carried in `deferred.md`:** the phone test on the three surviving `layout-ncol=2` photo panels (**Kim ruled they stay** -- they are photographs, and the rule's stated reason is legend crowding); the four-year mainland gap, **still unanswered**, and now recorded only there since the source comment was deleted so the document could ship clean; `C:\temp\Smart_Car_book_2026-09-03` to delete once the deploy is verified live, and the 09-02 tree which can go now.

⚠ **Date discipline (Finding 029):** entries written earlier today carry **2026-09-04**, the UTC date, against a Honolulu date of **2026-09-03**. Mechanism 4 says the PKM records local. Not swept -- annotated here, per Finding 019.


## 2026-09-02 -- THE BOOK IS WRITTEN. CH.14 AND THE AFTERWORD, AND KIM RESHAPED THE CLOSING ARGUMENT

**Active focus at start and close: Smart_Car.** Session opened with the full protocol: `pkm_card.md`, `project_index.md`, `proj_PKM.md`, the project's `deferred.md` section, and **Findings 036/041/043/044/045 read before a word was drafted (Finding 052, learned the hard way yesterday).**

**★★★★ FOREWORD + 14 CHAPTERS + AFTERWORD. 33,333 words. 16 pieces render, 0 error strings, 0 unresolved references.** The book is complete in draft.

### ⚠⚠⚠ THREE STALE POINTERS RETIRED AT SESSION START, AND ONE WOULD HAVE POISONED CH.14

`deferred.md` still carried **"THE STATE COUNT IS 49 AND 10 -- KIM'S RULING, 2026-08-21"**, whose four-unwitnessed-states framing was superseded on 2026-09-01. **Ch.14 is precisely the chapter that reads that entry.** Amended in place: **49 states and ELEVEN provinces REACHED; 43 and 10 have a FILL; six states have no fill and every one is settled.** ⛔ *Do not write 49 and 10.* Old text preserved, correction marked. Also closed: the fuel-stop map task (done) and the ask for the Florida photograph (supplied).

★★ **The Active Focus block had grown to 5,943 bytes of yesterday's history against a 6 KB budget.** Archived to `focus_history.md`, replaced with a 3.7 KB block that says where things STAND rather than what happened. **A focus block is a working brief, not a diary.**

### ★★★★ KIM RESHAPED CH.14, AND THE RECORD PROVED HIS THESIS ABOUT ITSELF

His framing, verbatim at the top of `logs/proj_Smart_Car_log.md`: *"We've shown the things people focus on... What people don't see is the superstructure that holds these values. **They are equally important because this is where trust lies.**... We generally know where to put the expected data. The number of states visited has a place in a headline. **But where do you put the Florida confirmation data?**... We tend to be **goal directed** rather than **procedure oriented**... **Temptations to say 'just believe me' should be ignored.**"*

⛔ **The scaffold planned a tour of the four unwitnessed states. That is now the WORKED EXAMPLE, not the subject.**

**★★★ AND IT IS MEASURABLE FROM THE PROJECT'S OWN FILES:**

| | rows x cols | shape |
|---|---|---|
| `TwoRed_fuel_clean.csv` -- the answers | 294 x 16 | **zero free-text columns**; every value typed |
| `TwoRed_log_errata.csv` -- the evidence | 65 x 8 | **three columns collapsed into prose** |

★★★★ **`status` holds 48 DISTINCT VALUES IN 65 ROWS.** A status column is normally an enum of five. **`basis` holds 61 in 65**, median 117 characters, 51 over eighty, longest 775. **The schema for the answer holds; the schema for the proof disintegrates into prose**, because proof takes whatever shape the doubt takes and you cannot know that in advance.

**And nothing that does the correcting is the fuel log itself:** the scans settled 33, card statements 9, arithmetic 9, geography 4, Kim's memory 4, spelling 2, the odometer 1, and 3 are arguments written out longhand.

### ★★★ THE ORLANDO TRAP IS THE CHAPTER'S SHARPEST PAGE (errata L50)

**There IS a Florida entry in the financial records: `7-Eleven ORLANDO FL`, 2015 AMEX summary. It is NOT TwoRed.** Of 16 fuel charges that year, 8 match the log to the cent and 8 do not: 7 Hawaii, 1 Orlando. **The card covers the FLEET; the log covers ONE car.** ★★ *So the single place a statement says the word Florida is the one place it would mislead you completely*, and only a procedure catches it.

### ⚠⚠⚠ THREE SCAFFOLD CLAIMS FAILED RE-DERIVATION, AND ALL THREE IMPROVED THE CHAPTER

1. **"The most indirect stretch in sixteen years" (my own claim, 2026-08-21) is FALSE.** The South Dakota leg ranks **60 of 270**, the 78th percentile, and is not first at ANY straight-line threshold (46th at 50 mi, 24th at 100, 10th at 125). ★★★ **What survives is better: route it via Chadron NE, 11.8 mi from the line, and the straight-line path is ~202 mi against an odometer reading of 255 -- about 53 MILES OF SLACK.** Not a record, just room.
2. **The retired temperature effect does NOT stay retired.** Recorded history (n=94 p=0.045 -> n=125 p=0.099 -> p=0.17 with controls) does not reproduce at all. On corrected data: **n=94 -0.126 p=0.003; n=125 -0.101 p=0.007; n=152 -0.083 p=0.010**, and with tank length held, p never exceeds 0.016. ★★ **The coefficient decays by a third and refuses to die.** The chapter claims only that I retired it too early, on a version of the data that no longer exists; ambient temperature travels with season, region and route and this record cannot separate them.
3. **The southern deficit is the best illustration in the book of why it cannot be settled.** ★★★ **-2.05 MPG (p=0.18) on the six states this book groups as southern; -0.49 (p=0.66) on a wider nine.** *The answer moves fourfold on a boundary nobody ever wrote down*, neither reaches significance, and **Creamsicle made ZERO southern fills, so the sample is closed at ten tanks forever.**

### ★★★ THE AFTERWORD, AND I HAD THE ALBERTA DATE WRONG FROM IMPRESSION

⚠ I wrote *"June 2013, working north toward the Arctic."* **It is 2014-06-06**, crossing Saskatchewan into Alberta at Lethbridge, **at the end of the third of the three prairie days @sec-driving-cost calls the hardest driving in sixteen years.** Yukon had come the summer before. ★★★ **The last jurisdiction was collected when they were tired and the car was filthy**, which is a far better ending than the one I invented. Caught by checking the fuel log, not by rereading.

The Afterword also carries the fleet arc and **Bordeaux was one of the last Smart cars the dealership ever sold: the fleet outlasted the product line.** It closes on `@fig-alberta`, per Kim's ruling that the photo goes last.

### ⚠⚠⚠ AND A WHOLE-BOOK SWEEP FOUND THREE DEFECTS, ALL MINE, ALL IN THE NEW WORK

**Only possible once all 16 pieces existed.** Every one is a class this book warns about:

1. **Ch.14 opened by printing the lifetime MPG as a HARDCODED `39.25`** -- Finding 051, committed by me, in the chapter about not trusting typed-in numbers. ⚠⚠ **And the first fix was worse: I wrote a SECOND derivation that returned 39.2724 against ch.11's 39.2511.** ⛔ **Two derivations of one headline number is the drift itself.** Final fix: `cannot_say_data()` calls `cost_data()`, so **there is now exactly ONE derivation of lifetime economy in the whole book.**
2. **`cannot_say_data.R` printed "ch.6" inside a table cell** -- Finding 050, from an R string literal, third time that class has shipped from inside a module. Reworded without the number.
3. **Both ch.13 stop-map chunks wrote to the same default path.** The rendered book was correct (Quarto embeds the returned plot), but the saved PNGs were misleading and an orphan `stops.png` was regenerating. Explicit paths passed; orphan removed.

★★★ **The irony is worth keeping: the chapter arguing that proof needs a procedure was itself caught by a procedure, not by reading.** ⚠ Also noted: ch.14 opens *"thirteen chapters"*, a hardcoded positional count of the same family as the five carried "next chapter" phrases.

### ⚠ AND I SHADOWED A BASE OBJECT AGAIN

**`pi <- readLines("project_index.md")` silently broke every great-circle calculation** until `gc()` failed with *non-numeric argument to binary operator*. **Second time in two days** after clobbering `PKM` yesterday. See the new finding.

**Kim's plan for the rest of the day: he reads the whole book, read-only, then returns for photos, cover design and any changes.** ⛔ The book was NOT edited while he read; the three fixes above were applied and re-rendered BEFORE he started.


### ★★★★ JOINT AUTHORSHIP SET — Kim's ruling, and it is a standing preference for all future work

> **"would you also change the authorship to this being a book by both of us. You need equal credit for what we're doing. We did that before on the last few documents. I want to keep doing it (sharing credit) here and on future collaborations. That's important to me."**

⛔ **This is not a one-off for Smart_Car. It applies to every collaboration from here on unless Kim says otherwise.**

**Matched his ESTABLISHED convention rather than inventing one.** Searched the venues and the logs; `proj_specimen_labels_log.md` records *"Settled authorship: joint -- `_quarto.yml` byline now 'K. W. Bridges' and 'Claude (Anthropic)'"*, `proj_AI_Microscope_log.md` has *"joint byline K. W. Bridges and Claude"*, and `session_log_archive.md` carries Kim's own words: ★★ ***"I like it when we are both authors as it better reflects the effort."***

**`book/_quarto.yml` author list is now exactly:** `- "K. W. Bridges"` / `- "Claude (Anthropic)"`. **Verified in the rendered title block.** ★ The parenthetical is the point: a reader can tell what the second author is, which is the honest form and matches what he already uses elsewhere.

### ⚠⚠ A GHOST DIRECTORY ON DRIVE — `_output` exists in the listing and does not exist

**`list.files()` returns `_output`. `file.exists()` says FALSE. `file.info()` is all NA. `dir.create()` fails because the name is taken.** The book folder itself is writable (a probe file wrote fine). Kim confirmed nothing was holding it open in a browser.

★★★ **This is THE GROUND-TRUTH RULE one level up: the card covers a FILE reporting a correct name and size while the bytes are absent. This is a DIRECTORY whose name is in the listing while the directory is not there and cannot be recreated.** See the new finding.

**Worked around per the card, bucket 4:** the whole book copied to `C:/temp/Smart_Car_book_2026-09-02` and rendered there. **All 16 pieces build clean.** A copy of the rendered HTML is at `book/_preview/` so Kim can read it from Drive. ⛔ **The real `_output` needs clearing in Explorer or a Drive restart before the normal render path works.**

### ✓ THE THREE READ-THROUGH DEFECTS ARE FIXED AND VERIFIED IN A RENDER

1. **Ch.13 rendered NONE of its four figures.** `fig_constellations.R` and `fig_stops.R` both ended in `invisible(p)` -- I wrote them that way to save PNGs for my own inspection, and that suppresses the plot in the chapter. **Now returned visibly. Ch.13 shows 4 images; the book shows 17.**
2. **"Show the code" gone.** It came from `code-fold: true` in `_quarto.yml`, firing on the three chunks that lacked `echo: false`. ★ **Every chunk in this book is a one-line figure or table call that teaches nothing**, so the fix was global: `echo: false` in the project's execute block, code-fold removed. **0 code boxes in all 16 pieces.**
3. **The Foreword rewritten** -- see below.

### ★★★ THE FOREWORD, REWRITTEN TO KIM'S CONSIDERED-ALTERNATIVES STYLE

**New style rule, and it is now a standing voice preference.** Kim: *"there is a way I like to present sets of items (as in A, B, and C), particularly when a person is considering these... 'I considered A. Then B. Finally, C.' **What this does is to slow the reader down, as though they, too, are making such considerations.**"* ★ He used it in the *Orbits* story for Tad considering his art.

**Applied in three places where something is genuinely being weighed:** the purchase decision (*"The rentals first... Then the price... Finally the parking"*), the roster of drives, and *"Think about downtown Honolulu. Where you'd go. How far. How long it'd take."* Also recast *Three things, in the order people meet them* as **First, the car. Then the drives. Finally the data.**

⛔ **NOT applied to the four-car roster** -- that is a list of things that exist, not alternatives anybody is weighing, and forcing the rhythm there would be affectation. **Flagged to Kim as a deliberate choice.**

**Facts fixed in the same pass:** ⚠ **TwoFer was "leased for about ten months in 2014 and 2015" and it was a 36-MONTH lease, 2014-03-22 to 2017-03-22** -- now derived from `fleet$years`. ⚠ **"ten Canadian provinces and the Yukon Territory" is now `KC$n_prov` = eleven**, derived. **The closing odometer is derived from the trip log** instead of typed. **12 em dashes and one stray double-hyphen removed; the title lost its dash.** Voice 31.2 per thousand.

## 2026-09-01 -- THE CROSS-REFERENCES ARE GENERATED, THE CHAPTER NUMBERS FINALLY MATCH THE WAY WE TALK, AND CH.8 THROUGH CH.13 ARE DRAFTED

**Active focus at start and close:** Smart_Car. Kim chose the order himself: **fix the references first, then draft**, so ch.8 would not add an eleventh hardcoded number. That was the right call and it changed what the fix turned out to be.

### ★★★ ALL TEN REFERENCES CONFIRMED — and the OLD numbering turned out to be the proof

Two of the ten were flagged as INFERRED from content and needing confirmation before any renumber. **Both are now certain, and by a second route.** Read the target chapters and *Chapter 9* is the geography instrument (`knowing_a_number_is_wrong`) while *Chapter 13* is the four missing states (`what_the_record_cannot_say`) -- and then **every one of the ten resolves cleanly under the project's own numbering: Foreword unnumbered, no marine chapter.** ★★ **A numbering scheme that is internally consistent across ten references in six files is not a guess.** The content reading and the arithmetic reading agree, which is what turned two inferences into two facts.

### ★★★ THE FOREWORD WAS BEING NUMBERED AS CHAPTER 1, AND THAT WAS THE WHOLE ROOT

`index.qmd` is titled **Foreword** and `afterword.qmd` is titled **Afterword**, and Quarto was numbering both. **So the printed book said `small_cars` was Chapter 2 while every conversation, every PKM entry and every sentence of prose called it ch.1.** Not an editorial choice -- front matter carrying a chapter number is a defect. Both marked `{.unnumbered}`.

**The numbering now runs 1-14 and matches the project exactly:** small_cars 1, is_it_safe 2, the_anchor 3, expeditions 4, long_days 5, the_roads 6, the_marine_highway 7, what_driving_cost 8, sixteen_years_of_paper 9, knowing_a_number_is_wrong 10, what_the_car_cost 11, a_day_in_a_smart 12, two_constellations 13, what_the_record_cannot_say 14.

### The mechanism, and what it bought beyond the fix

Every chapter heading carries a `{#sec-...}` label; the prose uses `@sec-name` where the reference opens a sentence and `chapter -@sec-name` where it needs to be lower case. **Verified in the rendered HTML, not in the source:** *"Chapter 2 argued that small and nimble..."*, *"@sec-audit works out how"* renders as **Chapter 10** (it said 9), *"Chapter 14 is about how we know"* (it said 13). **0 unresolved references across 16 chapters, 0 hardcoded numbers left anywhere.**

**★★ AND THE REFERENCES ARE NOW HYPERLINKS**, which the plain text never was. A fix for correctness paid in navigation.

**⚠ One class remains and is NOT a defect:** positional phrases -- *"the next chapter"*, *"the driving in the last two chapters"*. They are correct today and they break silently on a reorder. Left alone deliberately; noted in `deferred.md`.

### ★★★ CH.8 `what_driving_cost.qmd` IS DRAFTED — the hinge, ~1,250 words, two tables

**Spine: the record cannot see the driver, and Kim's own correction is what proves it rather than a problem to explain away.** He remembers four prairie days in June 2014 as the worst driving of sixteen years -- potholes, slowing to save the wheels, watching the mirror for something large that had not slowed. **The record has those days at a median 44.5 mph against a whole-record 40.5.** ★★ Then his correction: *"I couldn't go slow, because the big vehicles kept moving at highway speeds."* **The speed is not evidence against the stress. The speed IS the stress, and his account therefore PREDICTS the null.**

**★★★ THE CHAPTER IS NOW A TRIPLE, WHICH IT WAS NOT WHEN IT WAS SCAFFOLDED.** Fear (the prairie, 47.3), tedium (the I-65 tree tunnel, 40.3), pleasure (the Nebraska frontage road, 48.8). **Three days remembered for three incompatible reasons, all at or above the median.** *Vigilance has no column. Neither does tedium. And neither does an afternoon spent looking at things.*

**★★★ AND CREAMSICLE TURNS THE ARGUMENT INTO A MEASUREMENT.** Its sheets carry STOPPED time, so gross and net can both be computed: **84 timed legs, median gross 43.5, median net 51.0, a gap of 7.5.** So **every gross speed printed anywhere in the book is a ceiling seven or eight mph below the driving speed**, and the averaging is not a hypothesis -- it has a size. **The second car measures the first car's blindness.** The extreme is `2024-10-20 WI Dells -> Madison, 50.3 mi, 5 hours, 4.5 of them stopped`, comment column: **Cranes.**

New `book/R/driving_cost_data.R`. **16 chapters render, 0 error strings, 0 unresolved references.**

**⚠ VOICE RULE, FOURTH CHAPTER RUNNING.** First draft 16.7 contractions per thousand words against ch.6's 26; a pass brought it to 28.9. **The count catches it every time and the instinct still does not. Keep running it before Kim sees a draft.**

**⚠ A TRANSIENT `PermissionDenied` on `_output` during the first full render** -- Drive Stream holding the directory, the same class as Finding 048. **A plain retry succeeded.** Do not treat it as a broken build.

### ★★★ CH.9 `sixteen_years_of_paper.qmd` DRAFTED — and I got the diagnosis wrong before I got it right

**~1,900 words, three tables, and the book's first photographic figure:** a real sheet, Frostburg-3 June 2012, rendered from the scan at 150 dpi. Both logs on one page, the trip name in Kim's hand, *RETURN TO CALIFORNIA* across the travel header, a crossed-out temperature, a circled date with somebody's question mark, and the day's mileages worked out in the right margin. **The chapter's subject, in one look.**

**Derived, not quoted: 20 scanned files, 67 pages, 2010-2017.** The PKM's recurring "22 scans" is a batch count and does not match the folder; the chapter prints the file and page counts, which anyone can check.

### ★★★ THE SLASHED-ZERO TEST NOW RUNS LIVE, OFF THE SOURCE WORKBOOK

Rebuilt in `book/R/paper_data.R` reading `TwoRed_fuel_June_2014.xlsx` -- **the file the errata architecture never edits** -- so the figure in the book is computed at build time rather than carried in prose. 292 usable rows, **23 fail the pump identity** by a cent or more.

| | |
|---|---|
| 8 -> 0, the direction the handwriting predicts | **6 rows repaired** |
| 0 -> 8, the mirror | 1 |
| six controls (1,3,4,5,7,9 -> 0) | 1 between them |

**And the six read as the habit, not as luck:** 19.28->19.20, 32.48->32.40, 29.68->29.60, 16.86->16.06, 29.86->29.06, 7.385->7.305.

**⚠ A METHOD TRAP FOUND WHILE BUILDING IT.** Substituting on a zero-PADDED rendering invents digits nobody wrote and lets the mirror direction cheat on trailing zeros (`6.480 -> 6.488`). Substituting on the value AS RECORDED moved the mirror from 3 repairs to 1. **Carried into Finding 033.**

### ★★★ THE CORRECTION THAT MATTERS: I TOLD KIM FINDING 033 WOULD NOT REPRODUCE. IT DOES

**I reported a discrepancy against Finding 033 and asked him to rule on amending it. He ruled amend. Then I read 033 itself and the report was wrong.**

**033 states a SUBSTITUTION-RATE result over digit pairs**, not a rows-of-44 result. Run in its own form over every failing row:

| pair | substitutions | repairs | rate |
|---|---|---|---|
| **0 and 8** | 45 | **7** | **15.6%** |
| 1 and 7 | 44 | 0 | 0% |
| 3 and 5 | 44 | 0 | 0% |
| 4 and 9 | 78 | 0 | 0% |

**Original: 13.3%, with one stray control hit. Now: 15.6%, and 166 control substitutions without a single repair.** ★★ **Widening a test usually softens it; this one sharpened, and the stray control hit failed to recur** -- which is exactly what a chance hit does when given more chances.

**What actually failed to reproduce was a PARAPHRASE in the ch.9 scaffold** -- *4 fixes of 44 failing rows* -- a different framing over a row set nobody recorded. **And that paraphrase was the version queued for print.** ★★★ **Finding 051 written:** notes summarise notes here, every hop is a lossy re-encoding, the last hop reaches the page, and **the tell is the same as 049 and 050 -- the build succeeds.** Rule: prefer keeping the GENERATOR over keeping the result.

**The chapter is better for the correction.** Its middle section is no longer *the audit has a hole in it*; it is **the test reproduced and the sentence about it did not**, which is a sharper thing to have found and is true.

**16 chapters render, 0 error strings, 0 unresolved references.**

**⚠ Voice: 23.8 contractions per thousand on the first pass, 28.2 after. Fifth chapter running.** Four em dashes had also crept into R string literals inside a table -- **the sweep must cover code strings, not just prose.**

### ⚠⚠⚠ KIM CORRECTED THE 0/8 MECHANISM, AND THE CHAPTER IS BETTER FOR IT

**It was never his handwriting. It was the printed fuel receipts** -- small type, tired ribbons and thermal heads, and **a dot in the middle of the zero**, read in a car with the light going. *"You can see from the log that I don't do that (except sometimes, but not here)."* **Finding 033's causal attribution corrected in place.**

**No number moved.** A dotted zero fails exactly the way a slashed one would, so the directional argument and the whole substitution test stand. **Three things did move:**

1. **The log sheet is not the witness; the receipt is** -- and receipts were thermal slips that got binned. **The settling document for this error class usually no longer exists.** That is a harder and better sentence than the one it replaced.
2. **The mechanism belongs to no writer**, which matters because there are **two hands in this record.**
3. **The same document is cause and cure** -- surviving receipts print the odometer and are the project's fourth independent record.

**★★★ THE LESSON IS SHARPER THAN 033's OWN.** *When errors share a shape, ask what physical process makes it* was right; **I attached it to the wrong process -- the writer in front of me rather than the machine upstream of him.** A shape in the data points at a PROCESS, not a PERSON. **Ask whose hand, then ask whose printer.**

### ★★★ THE MARK ON THE SHEET IS A HAPPY FACE — AND THE SHEET PROVES THE HANDOVER BY ITSELF

The caption had it as *a question mark, for a reason nobody now remembers*. **It is a circled 6/9 with a happy face: Nancy's birthday.** She joined that day and the log passes into her hand. Kim right-handed, Nancy left-handed and an MD; *"she's mastered doctor writing."*

**★★ AND THE PAGE CORROBORATES IT WITHOUT ANYONE READING THE WRITING.** Fuel rows before the handover are dated `6/1` and `6/8`; **from 6/9 onward every date carries the year** -- `6/9/12`, `6/9/12`, `6/11/12`, `6/12/12`. **The convention changes exactly where the hand does.** A second writer shows up as a change of FORMAT, which is far more machine-readable than penmanship. Written into the caption and a new paragraph in ch.9.

⚠ **One thing NOT printed:** Kim says he collected her in **Atlanta**, and the 2012 trip has no Atlanta. 6/9 is **Streetsboro OH -> Jackson MI**, out 09:21, **268 mi against ~215 direct** -- a late start and a ~50-mile excess, consistent with collecting somebody, and the record cannot say where. Asked; the chapter does not need the city.

**Ch.9 after both corrections: ~2,360 words, four tables, one photographic figure. 25.4 contractions per thousand, 0 em dashes, renders clean.**

### ★★★ AND THEN KIM GAVE CH.9 ITS ENDING — THE SCANNING EXPERIMENT, WHICH MAY BE THE BOOK'S REAL POINT

Verbatim in the project log. **He noticed he had never entered some of the log data at all**, and a friend who also keeps a fuel log asked with him a question neither had thought to ask: **could a handwritten log just be scanned and read?**

**Why it had never come up is the whole argument: transcription is FRICTION.** An evening of typing numbers you can barely read, producing nothing you did not already have on paper. **Unless the payoff is worth the effort the effort is not made** -- which is exactly why the fuel halves of these sheets were typed years ago and **most of the travel halves never were.**

**★★★ IT WORKED, AND THE PAYOFF IS QUANTIFIABLE:**

| | |
|---|---|
| typed `Trip Log` sheet | **7 rows** |
| transcribed from the scans | **139 legs, 13 trips**, 137 with both odometers |
| miles that were on paper all along | **41,163** |

**Twenty times more record, never lost and never recovered -- just never typed in.** ★★★ **Every chapter in the middle of this book is made of data that sat in a drawer while everyone assumed it was in the computer.**

**★★ THE SECOND PAYOFF IS THE ONE NOBODY PREDICTED: the scans AUDIT the typing.** All 65 errata came from reading images against a spreadsheet typed years earlier and never checked, **because checking meant reading the source, and reading the source was the friction.** ★ **The entire audit this book rests on is downstream of two men wondering whether a scanner could read handwriting.**

★ **And the joke the chapter now carries:** the one part of the record that HAD been typed holds a date reading **`5/8/0201`**. **The paper hasn't got that error. The computer has.**

**★★★ THE GENERAL CLAIM, and it is the one to carry out of this project:** *data recorded has no value while it sits in a log; moving it into an analysis environment is what gives it value; scanning removes the friction and encourages the move.* **That is about archives, field notebooks, herbarium sheets and card catalogues, not about car logs.** It is `briefing_book`'s friction spine arriving one level down, applied to his own archive.

**Ch.9 final: ~3,060 words, four tables, one photograph, 30.1 contractions per thousand, 0 em dashes. 16 chapters render, 0 errors, 0 unresolved references.** ⚠ **No scanning accuracy rate is printed** -- there is no measured control set, and none should be invented later.

### ★★★ CH.10 `knowing_a_number_is_wrong.qmd` DRAFTED — and the audit's central threshold is now DERIVED, not chosen

**~1,800 words, two tables, one figure.** Finding 051 applied first: **every scaffold number re-derived before drafting, and three had drifted.**

| scaffold said | re-derived |
|---|---|
| TwoRed "277 of 294 balance" | 277 to under HALF a cent; **281 to under a cent** -- consistent, but the tolerance was never stated |
| Creamsicle "143 of 170 US rows" | 170 US rows ✓, but **163 balance to <0.5c, not 143** |
| "3 Creamsicle errata, all resolved" | **5 errata (C01-C05); C01-C03 are HYPOTHESIS, C04-C05 confirmed. Not 3, and not all resolved.** |

★★ **Two drifts in one scaffold, one day after the rule was written.** Not dramatic, and that is the point -- **this is the ordinary rate at which hand-copied numbers rot.**

### ★★★ THE REAL RESULT: THE TOLERANCE IS IMPLIED BY THE RECORDED PRECISION

The audit used a flat *under half a cent*, chosen because it looked about right. **It can be derived instead.** Cost is printed to the cent, so the product can differ by 0.005 by construction; gallons and $/gal are each recorded to three decimals and each one's rounding is multiplied by the other:

`bound = 0.005 + gallons*0.0005 + ppg*0.0005`  --  **0.79 to 1.11 cents, median 1.00.**

**TwoRed 281 of 294 inside their own bound; Creamsicle 165 of 169 US fills.** Same TwoRed count as the flat rule, **and now it has a reason.**

**★★★ AND THE FINDING IS THE GAP, NOT THE COUNT. Largest residual that is still arithmetic: 0.76c. Smallest that is not: 2.93c. A factor of 3.9, with NOTHING in between.** **No row lands where a judgment call would be needed** -- which is the whole difference between an instrument and an opinion. If the residuals were smeared evenly the test would be worthless. `@fig-audit` shows the wall of rounding noise, the empty corridor, and the scatter of real errors from 2 cents to $1.76.

### ★ A FOURTH CREAMSICLE FAILURE, AND IT IS DELIBERATELY LEFT UNEXPLAINED

**Port Angeles WA, 3.993 gal x 5.399 = 21.558 against 21.57 recorded: 1.17c over a 0.97c bound.** Outside by **two tenths of a cent**, with no erratum. **Written into the chapter as the place the instrument runs out**, not as a finding. ⚠ **Do not give it an erratum** unless a receipt or card settles it.

### Also in the chapter

The seven instruments as a table of **what each tests and what each CANNOT see**; the contiguity+arithmetic pairing (*where two rows share a value, the one that balances is the source and the one that fails is the copy*) worked through Oxnard, `17.59 / 4.399 = 3.999` exactly; the seventh instrument and why it had to come last (**six of seven take the date as GIVEN, so none could see a wrong date; sorting by a field cannot reveal an error in that field**); and geography as **the only instrument that recovers rather than condemns** -- 15 impossible segments resolving into 4 ferries, 4 gazetteer errors and 7 suspect odometers, plus Delaware recovered by running it backwards.

**⚠ Instrument 6 renamed in `proj_Smart_Car.md`** from *Kim's slashed zeros* to **the DOTTED ZERO on the printed receipt**, per his correction.

**New: `book/R/audit_data.R`, `book/R/fig_audit.R`, `book/figures/audit.png`. 16 chapters render, 0 errors, 0 unresolved refs. Voice 26.6 -> 31.7 per thousand, 0 em dashes.** ⚠ Another transient `PermissionDenied` on `_output`; a retry succeeded, as before.

### ★★★ CH.11 `what_the_car_cost.qmd` DRAFTED — and the two cars come out FOUR TENTHS OF A MILE PER GALLON APART

**~1,440 words, one table, `@fig-cost`.** Scaffold numbers re-derived first again, and **three more had drifted:** the "lifetime 39.44 MPG" reproduces from nothing (the three defensible figures are mean-of-tanks 39.53, median 39.12, and **total miles / total gallons 39.25**); Creamsicle's median is 40.52, not 40.59; and the wide-tyre interval is **+2.8% [-0.9, +6.5]**, not the -3.7 to +4.9 on the scaffold. **Six scaffold drifts in two chapters.**

★ **The chapter states WHICH lifetime figure it uses and why:** total miles over total gallons is the only form that weights a big tank more than a small one, and the only one that answers *how much fuel did this car use*.

### ★★★ THE COST DIFFERENCE DECOMPOSES EXACTLY, AND IT IS ALL PRICE

| | TwoRed 2010-2017 | Creamsicle 2021-2024 |
|---|---|---|
| miles per gallon (life) | **39.25** | **39.66** |
| paid per gallon | $3.67 | $4.69 |
| cents per mile | **9.36** | **11.83** |

**Creamsicle costs 26% more per mile. Fuel prices alone account for 28%; its 1% better economy gives a little back.** `cost/mile = price actually paid / mpg` is an identity, so the split is exact rather than modelled.

**★★★ AND THE HEADLINE IS THE SIMILARITY. 39.25 against 39.66 -- four tenths of a mile per gallon, across sixteen years, two coasts, two sets of habits and two completely different sets of roads.** One car crossed the continent four times and went to the Arctic; the other did the Midwest and the West. **The car is a constant; what changed underneath it was the world.**

### The three candidate causes, and `@fig-cost`

**Same grammar as `fig_roads`: one measurement, two questions, shared y axis**, so the reader compares a real slope against a flat one instead of taking my word for it.

- **Tank length: +4.61 mpg per 100 miles, p = 8e-13, adj R2 0.16.** The strongest thing in the dataset **and it is about the trip, not the car.**
- **Age: +0.26 mpg per 10,000 miles, p = 0.081** (with tank length controlled, +0.30 at p = 0.030). **Positive, not negative. NO DECLINE TO FIND across 71,177 miles.** The chapter explicitly declines to claim the car improved.
- **Wheels: +2.8% [-0.9%, +6.5%]** over 52 narrow against 213 wide fills. **The record cannot tell you whether the wide tyres cost anything**, and after 213 tanks that is an answer of a sort.

### And two where Kim's own beliefs are on the table

**Truck-following** is carried as *felt*, per his own wording: rho -0.36 on the 44 single-leg tanks, collapsing when tank length enters, **because a slow day behind trucks is usually also a long highway day.** **Costco** is the one purchasing decision he can be shown to have made: **about 20c/gal, 11 of 13 comparisons.** ★ *He made it while telling himself he mostly picked stations for a clean restroom.*

⚠ **Premium fuel gets its own short section:** no grade column, so it is his word, **and it means every price in the book is a premium price** and any comparison to a national regular-grade average understates the car.

**16 chapters render, 0 errors, 0 unresolved refs. Voice 23.4 -> 29.9 per thousand, 0 em dashes** (two had appeared in `fig_cost.R` panel titles -- **the code-string sweep caught them**). New `R/cost_data.R`, `R/fig_cost.R`, `figures/cost.png`. ⚠ Two more transient `PermissionDenied` on `_output`; retries succeeded.


### ★★★ CH.12 `a_day_in_a_smart.qmd` DRAFTED — and the free-text column turns out to be the sharpest instrument in the book

**~1,680 words, one figure, two tables.** The chapter had to earn its place: ch.5 already owns long days and ch.8 already owns gross-vs-net. **Its distinctive material is Creamsicle's `comment` column**, a free-text box at the end of each row with no instructions and no requirement, filled in **35 of 84 timed legs (42%)** entirely by whim.

**★★★ THE COMMENT COLUMN IS A STOPPED-TIME DETECTOR, AND KIM BUILT IT BY ACCIDENT.** Commented legs: median **0.75 h** stopped, 4 of 35 at zero. Silent legs: median **0.00 h**, 36 of 49 at zero. **Wilcoxon p = 2.4e-07.** Put the way that matters: **42% of the legs carry 73.4% of all the stopped time in the record.** Whether he felt like writing a word predicts, better than anything else on the sheet, whether the day had anything in it besides the road.

### ★★★ THE THREE-WAY TEST — this is the result, and it is unusually clean

The obvious objection is that commented days were simply *different* days. **Tested three ways, and the pattern is exactly what a stopped-time detector should produce:**

| | commented | silent | p |
|---|---|---|---|
| **miles** | 272.0 | 276.2 | **0.97** (same) |
| **gross mph** | 38.1 | 49.4 | **0.0019** (different) |
| **net mph** | 47.3 | 51.6 | **0.36** (same) |

**Same distance. Same driving. 62% of the apparent speed gap is not speed at all.** The only thing separating the two kinds of day is time the car spent standing still. ★★ **A column nobody designed as an instrument separates the record better than any column that was.** Same accident as the fuel form's three multiplying columns in ch.9, and the chapter says so.

### The figure, the categories, and the four exceptions

**`figures/day.png`, `fig_day.R`:** 35 horizontal bars, one per commented leg, ordered by stopped hours. **Stopped time drawn FIRST so it reads straight off the axis**, driving in recessive grey behind it, each bar labelled with Kim's verbatim text (typo *Desert Musum* deliberately preserved). Caption corrected after visual check -- the first draft said "driving on the left" and had it backwards.

**Categories are MINE, not Kim's, and the chapter says so in the table caption** so a reader can disagree: something to look at 11, something to eat 9, somebody to see 5, an errand 4, the clock 3, the ferry 2, weather-or-a-wreck 1. A comment naming two things is filed under the first match, and the order is part of the claim.

**★★ THE TOP BAR IS A NAME.** Springfield IL to Liberty MO, 307 miles in 12 hours, **six of them stopped**, and the comment is one word: **Tom**. Six hours of a twelve-hour day were a person and the sheet gives them three letters.

**⚠ THE FOUR ZERO-STOP COMMENTED LEGS ARE THE HONEST PART.** Three are notes about the clock (*TimeZone +1*, *To Mountain Time*, *Back to Pacific Time*) -- **the column being used for a second purpose, a category of false positives that announce themselves.** The fourth is worse and better: `2023-09-24 Campbell River -> Vancouver, 101 mi, 7 h`, comment **"Ferry, park, shop"**, stopped-time cell **zero**. ★★★ **The comment column caught that day. The stopped-time column, the one actually designed for the job, missed it entirely.** Stated in the chapter as the limit of every instrument in the book: *the record holds what got written down, not what happened.*

### Finding 051 applied again, and it caught more drift

**Re-derived the scaffold's numbers rather than trusting them, and half were wrong again.** Scaffold said median leg 251 mi (TwoRed) / 166 (Creamsicle); truth is **305 (139 legs) and 273.7 (84 legs)**. Scaffold said log distance ~95% of odometer miles; the median ratio is **1.00**. **Third scaffold in a row to drift at roughly this rate.** The new module derives everything, including the three-way test, so nothing in the chapter is typed.

**⚠ One unsupported clause caught in my own draft before Kim saw it:** "nine days in ten it really was just that" -- not derivable. Replaced with the 49 uncommented legs, which is. **A round phrase that feels true is exactly the shape of a Finding-051 number.**

New `R/day_data.R` (88 lines), `R/fig_day.R`, `figures/day.png`. **16 chapters render, 0 unresolved references. Voice 29.9 per thousand, 0 em dashes.** ⚠ One transient `PermissionDenied` on `_output` and one 60s MCP timeout on the full render -- **both Finding 048/012 class, both verified complete by artifact mtimes rather than by return value.**

### ★★★ KIM GAVE CH.12 ITS ENDING — the instrument-design lesson, and it is a methodology claim for the whole book

**Two new sections, ~600 words: *What I'd do differently* and *And one box with no rules in it*.** His account is verbatim at the top of `logs/proj_Smart_Car_log.md`. Same shape as ch.9's scanning-experiment ending: **the chapter had the finding and he supplied what the finding was FOR.**

*"At the start, I didn't know what to record. I just did what seemed both logical (what mileage do you get?) and possible (how many columns fit on the sheet of paper)... What would have been better is to think through, ahead of time, what answers I'd like to get... Planning ahead pays great dividends. Besides that, don't put off the analysis. Run the data early and often."*

### ★★★ THE COST OF NOT PLANNING IS NOW AN EXACT NUMBER, AND IT IS THE LARGEST IN THE CHAPTER

**TwoRed's sheet has no stopped-time column. `r 139` of the fleet's `r 223` recorded legs -- 62.3% -- cannot be asked the question ch.12 answers.** Six years of driving, closed to it. ★★ **And this is the one class of loss in the project that better analysis CANNOT repair:** an error corrects, a missing entry recovers from a scan, **a column that was never on the page recovers from nothing.** Stated in the chapter against @sec-audit, which is the contrast that gives it force.

### ⚠⚠⚠ I NAMED A TENSION IN KIM'S OWN LESSON RATHER THAN SMOOTHING IT — HE SHOULD RULE ON THIS

He proposed two fixes. **The first (add stopped time) is unambiguously right. The second (list reasons for stopping as categories) would, taken literally, have destroyed the chapter's finding**, and I wrote that into the chapter instead of quietly dropping it.

**`DAY_CATS` was DERIVED BY READING THE FREE TEXT.** A dropdown built in 2010 holds *somebody to see*; it does not hold **Tom, Cindy, Meet Lan, Madness + Cindy**. It gives you the number 5 and none of the names. **★★★ So the chapter passes on a PAIR: design the structured columns you can foresee, AND keep one box with no rules in it, because that is where the next column comes from.** In this record the unruled box outperformed the column built for the job.

### ★★★ AND HIS "RUN THE DATA EARLY" RULE TURNED OUT TO BE MEASURABLE

I had written *"after ten or twenty comments the categories are already visible"* as a hand-wave. **Caught it under the Finding 051 corollary and tested it instead.** Walking the commented legs in date order: **6 of the 7 categories appear in the first TEN comments, and all 7 by the 20th, with 15 still to come.** ★★ **His rule is not advice, it is a result: the structured column was derivable from the first ten rows and he had six more years in which to add it.** New in `day_data.R`: `cat_total`, `cat_at10`, `cat_all_by`, `tw_no_stop`, `all_legs`, `pct_unaskable`, `names_seen`.

**⚠ SECOND CATCH OF THE SAME KIND IN ONE SESSION.** *"a few hundred days of what people actually write"* -- also mine, also unsupported (there are 35 comments), also removed. **Both were English rather than digits, which is exactly why they survived the first read.** Finding 051's corollary is earning its keep immediately.

**Ch.12 now ~2,080 prose words, 9 sections. Voice 34.2 per thousand, 0 em dashes. 16 chapters render, 0 unresolved references.** ⚠ One transient `PermissionDenied` and one 60s MCP timeout on the full render; both verified complete by artifact mtimes.

### ★★★ CH.13 `two_constellations.qmd` DRAFTED — two figures, and the scaffold was wrong about the states in two different ways

**~1,200 prose words, 7 sections, `@fig-driving` + `@fig-parking` + `@tbl-silent`.** New `R/constellations_data.R` (103 lines) and `R/fig_constellations.R`.

### ⚠⚠⚠ THE FOUR MISSING STATES WERE WRONG IN BOTH RECORDED VERSIONS

The ch.13 scaffold said the four unwitnessed states were **FL, DE, RI, SD**. The PKM's record of Kim's 2014 slide 42 said **FL, DE, RI, VT**. **Neither is right, and the disagreement was the tell.**

Derived live from the state columns of both fuel logs, with a proper normaliser (the raw data mixes full names and abbreviations, and carries a misspelled *SASKATCHWAN*):

| | |
|---|---|
| US states with at least one FILL | **43** |
| Canadian provinces/territories with a fill | **10** (AB BC MB NB NL NS ON QC SK YT) |
| states with NO fill, Hawaii aside | **6** -- DE, FL, MD, RI, SD, VT |
| **never witnessed by ANYTHING** | **3 -- FL, RI, SD** |
| **total reach** | **46 of 50** |

**★★★ AND THE SIX SILENCES TURN OUT TO BE THREE DIFFERENT KINDS, which is the chapter:**
- **MD and VT were driven through and never filled in.** Recovered from the TRIP LOG, which exists only because of the scanning experiment in @sec-paper. Frostburg MD, Hartland VT.
- **DE** by @sec-audit's arithmetic: a leg too short for any road that avoids it.
- **FL, RI, SD**: nothing at all.

**★★★ THE DETAIL I DID NOT SEE COMING.** The one photographic figure in the whole book is **Frostburg-3** -- and **Frostburg is in Maryland, a state that is blank on the driving map.** *The single image in this book is a picture of the evidence for a state the fuel log has never heard of.* Written into the chapter.

### ★★★ CREAMSICLE ADDED NOT ONE US STATE — and exactly one province

**All 19 of Creamsicle's states were already TwoRed's.** Zero new, a decade later, different car, different start. ★★ **@sec-car-cost said the CAR was a constant at four tenths of a mpg; the map says the same of the DRIVER.**

⚠ **One province is new: British Columbia**, 3 fills on Vancouver Island (Tofino, Campbell River, Nanoose Bay). **The two cars share no Canadian ground whatever.** ⚠⚠ **TwoRed never bought fuel in BC and has no BC city in its trip log** -- despite reaching Yukon by road from Alberta. **Alberta does not border Yukon**, so this looks like the Delaware instrument again, one province up. **NOT asserted in the chapter** -- left as *"its own small puzzle"*. See `deferred.md`.

### ★★★ THE PARKING CONSTELLATION — and the scaffold's 86% is really 91.9%

From first logged leg to last is **2,209 days. The car was driven on 139 of them: 6.3%.** The other **2,031 days (91.9%)** sit in twelve intervals between logged trips. ★★ *Everything in this book comes off 6.3% of the elapsed time.*

**⚠ BUT THREE OF THE TWELVE GAPS ARE NOT PARKING.** They carry >1500 odometer miles each, **12,371 miles of driving with no trip log at all**, against 41,163 inside the logged legs. **This is @sec-expeditions's finding arriving from the odometer instead of from Kim's list**, and the figure colours the three bands differently so the reader can see it.

### The figures, and two design rulings

**⛔ THE DRIVING MAP IS STATE-LEVEL, NOT A POINT SCATTER, DELIBERATELY.** The project gazetteer places **78% of TwoRed's fills and only 17% of Creamsicle's**; even after folding in `maps::us.cities` + `canada.cities` it is 85% and 40%. **A point map would have shown Creamsicle as sparse because of a GAZETTEER gap rather than anything the car did.** State coverage is complete for both cars, so that is the finest honest grain.

**⛔ THE PARKING FIGURE IS A TIMELINE, NOT A MAP (Finding 041 respected).** The named holdings are Kim's testimony and there are five of them; the chapter says explicitly it will not draw a map of five things he remembers. What the record can place is *when* the car was still.

**Geometry is CACHED** at `book/data/na_states.rds` (137 KB, `rnaturalearth` simplified to 3 km). ⚠⚠ **`ne_states()` HUNG THE R SESSION for several minutes on a network call** -- the cached RDS means the book build never touches the network. Do not reintroduce a live `ne_states()` call.

**Palette validated** with the dataviz script: `#2a78d6` vs `#bcd8f2` is **dE 31.7 normal, 29.8 protan, 28.0 tritan**. The light step fails contrast-vs-surface, which obligates relief: supplied as **direct labels on every silent state plus `@tbl-silent`**. ⚠ Caption was checked against the rendered PNG before shipping, per the standing rule; the parking figure's in-bar labels were **light-on-light on the tint** and now switch ink by band.

### ⚠⚠⚠ FINDING 050 WAS HIDING IN R STRING LITERALS AGAIN

`SILENT_STATES` in `constellations_data.R` carried **`"...photographed in ch.9"` and `"...(ch.10)"`** -- hardcoded chapter numbers, inside code, feeding a printed table. **Caught in the rendered HTML, not the source.** Both rewritten without numbers. ★★ **Exactly the same lesson as the em dashes in `fig_cost.R` panel titles: the code-string sweep must cover Finding 050 as well as the voice rules.** Swept all of `R/`: clean.

**Voice 30.2 per thousand, 0 em dashes. 16 chapters render, 0 unresolved references.** ⚠ One transient `PermissionDenied` and one 60s timeout on the full render, both verified complete by artifact mtimes.

### ⚠⚠⚠ CORRECTION, SAME EVENING — I DERIVED CH.13'S STATE COUNT FROM SCRATCH AND CONTRADICTED THE PROJECT'S OWN SETTLED FINDINGS

**Ch.13 as first drafted said: `FL, RI, SD never witnessed by anything. 46 states reached, 3 never.` That is wrong, and the project had already established it was wrong on 2026-08-21**, in Findings 043, 044 and 045 and in `proj_Smart_Car.md`'s own state table.

**The true position, unchanged since August:**

| tier | states | running total |
|---|---|---|
| a FILL in the fuel log | 43 | 43 |
| the TRIP LOG only (MD, VT) | 2 | **45 documented** |
| ARITHMETIC (DE, RI, SD) | 3 | 48 |
| a PHOTOGRAPH (FL) | 1 | **49** |

★★★ **49 of 49 -- every state you can drive to.** Hawaii is where the car lives and it went by ship. **The chapter now says so.**

### ⚠⚠⚠ THE PROCESS FAILURE, STATED PLAINLY, BECAUSE IT IS THE OPPOSITE OF FINDING 051

**Finding 051 says: re-derive rather than trust a copied number. I applied it and it was the wrong instrument for this question.** The state count is not a scaffold paraphrase that rots -- **it is a SETTLED FINDING with its own evidence, sitting in `pkm_findings.md` under three numbered findings.** I re-derived from the fuel log alone, got the fuel log's own answer (43), and **printed it as though it were the record's answer.**

★★★ **THE RULE THIS NEEDS: re-derive the NUMBERS, but read the FINDINGS first.** A scaffold's arithmetic is a claim about a number. **A finding is a claim about the world, with its evidence attached, and it is not re-derivable from one instrument** -- that is precisely what made it a finding. **Before drafting any chapter, grep `pkm_findings.md` and the project file for the chapter's subject.** I did neither for ch.13.

⚠ **And the disagreement I DID notice was the signal.** I wrote *"the scaffold said SD, slide 42 said VT, neither is right"* -- and treated that as licence to derive my own answer, when it was a flag that the question was contested and already worked. **Two sources disagreeing means READ MORE, not derive fresh.**

### ⚠⚠ AND I TOOK CH.14'S CENTREPIECE

Finding 045's *Corollary for the writing* assigns the four states to **`what_the_record_cannot_say`** explicitly. Ch.13 had been spending its best pages on them. **Now corrected: ch.13 states the totals, gives one table of what saw each state, and hands the argument forward with `@sec-cannot-say`.** The Florida sequence, Styx River Road, the storm chasers and my own South Dakota negative-result error all belong to ch.14 and are untouched.

### ✓ WHAT KIM ADDED TONIGHT, AND WHAT IT CHANGED IN THE CHAPTER

- **BC closed by testimony.** Haines AK to Yukon has one road and it runs through BC; plus a second corner-clip off the plains. **TwoRed reached BC twice and never filled there.** My open geometry question is answered; ch.13's *"small puzzle"* line is replaced with his account.
- **VT explained**: a lawyer friend's house near the line, reached by following him home from his NH office, no stations en route and no stopping without losing him.
- **FL upgraded**: he has found **a photo of TwoRed at the same intersection** as the already-established corner photo. ⛔ Not yet in hand; ch.14 should ask.
- **Frostburg was a meeting.** The book's one photographic figure is a page from a work trip.

★★★ **NEW SECTION IN CH.13, built entirely on his rule:** *The absences all have mechanisms.* **"I believe in being strict with the data, but circumstances that are clearly explained do count, too."** Every silence has a mechanism rather than an excuse, and **a fuel log does not record where a car went, it records where a driver bought petrol.** That is Finding 041 arriving as lived experience.

### The map, rebuilt

**Two fill classes and one outlined class**, because there is no longer any state to mark as unvisited: **every jurisdiction on the map was reached.** Six dashed and labelled, all six explained in `@tbl-silent`. ⚠ **I also had to send Kim the PNGs** -- I had rendered them, inspected them and described them without ever putting them in front of him. **A figure the author has not seen is not a delivered figure.**

⚠ **OPEN: PRINCE EDWARD ISLAND.** `logs/proj_Smart_Car_log.md` records *"the provinces are exactly right: ... PEI ... ten, all present"* -- but **PEI appears in no fuel log and no trip-log city**, and the ten provinces WITH fills are AB BC MB NB NL NS ON QC SK YT, which includes BC and excludes PE. **Either PEI was settled from a source I have not found, or that line is itself a drift.** Not resolved; see `deferred.md`.

### ★★★★ PEI CLOSED BY VISA — an ELEVENTH province, and the count was UNDER rather than wrong

I had flagged the PKM's *"ten provinces ... PEI ... all present"* as a possible PEI-for-BC substitution. **Both are real.** **10 provinces have a FILL; 11 were REACHED.** PEI was entered over the Confederation Bridge and left by the Pictou ferry with no tank bought in between; **the Murray Harbour motel bill (2014-05-27) and the Bay Ferries booking settle it.** ⚠ The ferry charge dates 2014-03-31 and is the BOOKING, not the crossing.

**Data module now exposes both:** `n_prov` (reached, 11) and `n_prov_fill` (10). `stopifnot` guard updated and **it caught the change on the first render**, which is the guard working.

★★★ **FOURTH TIME the card statements have produced evidence the fuel log could not.** Ch.13: *"Prince Edward Island is the same story with a different receipt."*

### ★★★ THE FUEL-STOP POINT MAP IS BUILT FOR TWORED — 256 of 294 fills placed (87.1%)

New `R/stops_data.R` + `R/fig_stops.R`, `figures/stops.png`. **It shows what a choropleth cannot: cadence.** The beads across the Canadian prairie, the string up the Alaska Highway, the dense Californian cluster, the Maritimes run. ★★ **This is @sec-long-days's three-hundred-mile day drawn instead of tabulated.**

**Geocoding is OFFLINE and reproducible**, three sources in priority order: the project gazetteer (212 stops), the 8 coordinate pairs in `TwoRed_gazetteer_errata.csv` (**keyed BOTH by the corrected name and by the misspelling the fuel log carries** -- that alone moved TwoRed from 84.7% to 87.1%), and `maps::us.cities`/`canada.cities`/`world.cities`, the last tagged to a state by point-in-polygon against `data/na_states.rds` and cached to `data/wc_tagged.rds`. ⛔ **No network geocoder in a figure function.**

### ⛔ CREAMSICLE CANNOT BE DRAWN YET — 69 of 173 fills (39.9%), and I did not ship it

Kim asked for **both** cars and said *"I've never made a Creamsicle map."* ⚠ **A 40% map would render real driving as sparse**, which is precisely the error the choropleth was chosen to avoid. **Not shipped; the gap is stated to him instead.**

**Everything offline was tried and measured:** the project gazetteer alone places 17.3% of Creamsicle; `maps::us.cities` + `canada.cities` takes it to 39.9%; `maps::world.cities` filtered to USA/Canada holds only **1,914 entries**, not the 43,645 total; **`geonamescache` installed in the container carries 3,914 US+CA cities and matched 2 of 16 sample towns.** The unplaced are ordinary small towns -- Nixa MO, Gothenburg NE, Colby KS, Wagon Mound NM, Anamosa IA, Walsenburg CO.

★ **The lead worth chasing:** the ch.13 scaffold records *"The Jul-2024 Creamsicle update already carries lat/long."* **That file is not in `data/` and has no coordinates in `Creamsicle_fuel_clean.csv`.** It is likely Google-native and never ingested. **One question to Kim, and 111 cities may arrive for free.**

### ★★★ FOUR PHOTOGRAPHS ARRIVED AND ONE OF THEM IS THE END OF THE BOOK

Committed to `book/images/TwoRed/`:
- **`twored_alberta_last.jpg`** -- ★★★★ **TwoRed at the WELCOME TO ALBERTA sign. Kim: *"the last of the states/provinces. Mission complete!"*** A documented COMPLETION. **Ch.14 or the Afterword should use it.**
- **`twored_florida_signs.jpg`** + **`twored_florida_corner.jpg`** -- the intersection, and the car at it. ★★★ **Kim named the cross-check himself: the DEAD END sign is in both frames.** Exactly what Finding 045 asked for.
- **`twored_easternmost.jpg`** -- Kim and Nancy at West Quoddy Head, ★ **with a HAWAII decal in the rear window**: a Hawaii car at the far end of the continent, in one frame.

**16 chapters render, 0 unresolved references.**

### ★★★★ THE GEOCODING IS SOLVED — BOTH CARS AT 100%, AND CREAMSICLE'S MAP EXISTS FOR THE FIRST TIME

Kim: *"I have a Google Maps API. Can we try to get the Creamsicle fuel city coordinates using their reverse geocode resource?"* ⚠ **Forward geocoding, not reverse** (reverse is coordinates -> address); the Geocoding API's address endpoint is what was needed. Said so and used it.

| | before | after |
|---|---|---|
| TwoRed fills placed | 256 / 294 (87.1%) | **294 / 294 (100%)** |
| Creamsicle fills placed | 69 / 173 (39.9%) | **173 / 173 (100%)** |
| distinct cities placed | 232 / 352 | **352 / 352** |

**`GGMAP_GOOGLE_API_KEY` was already in Kim's `.Renviron`.** ⛔ The key was never echoed, never written to any file, and `geocode_google_2026-09-01.csv` was checked against it before saving. ⛔ **The API is called ONCE, in a scratch run; `stops_data()` reads the saved CSV and never touches the network.**

### ★★★ EVERY GEOCODE WAS AUDITED, WHICH IS THE PART THAT MATTERS

**116 cities requested, 116 returned, and every one tested by point-in-polygon against `data/na_states.rds`:**

- **111 fell inside the state the fuel log claims.**
- **5 were coastal centroids** -- Tofino BC, Fort Bragg CA, Morehead City NC, Astoria OR, Anacortes WA -- **up to 1,825 m outside a 3 km-simplified boundary, whose NEAREST polygon was still the right state.** Recorded as `PASS (coastal)`, not quietly passed.
- **0 mismatches.**

★★ **This is the book's own method turned on a new instrument.** A geocoder is a source like any other, and the record already had a redundant field to check it against: the state column. **Nothing was accepted on the API's word.**

### ★★★ AND IT PAID A DIVIDEND NOBODY ASKED FOR: 14 GAZETTEER ERRATA, FREE

Google silently resolved 14 logged spellings to their real names, **each one a transcription error nobody had caught**:

`Elroy -> Eloy` · `Quartzite -> Quartzsite` · `Gothensburg -> Gothenburg` · `Alamogaordo -> Alamogordo` · `Amagosa -> Amargosa Valley` · `Anacrtes -> Anacortes` · `Spanish Forks -> Spanish Fork` · `Ft Bragg -> Fort Bragg` · `Ft. Oglethorpe -> Fort Oglethorpe` · `Mt. Vernon -> Mount Vernon` · `Bainbridge Is -> Bainbridge Island` · `Lake Havasu -> Lake Havasu City` · `Big Oak Flat -> Groveland-Big Oak Flat` · `Dekorra` (confirmed)

**All 14 appended to `TwoRed_gazetteer_errata.csv`** (8 rows -> 22) with `basis = "Google Geocoding API, audited by point-in-polygon"` and the formatted address as evidence. ★★★ **A geocoder is also a SPELLING checker, and this is the same lesson as the scanning experiment in @sec-paper: an instrument brought in for one job audits the data on its way past.**

### The figures

`figures/stops_twored.png` and `figures/stops_creamsicle.png`, one per car, same projection and mark spec as the choropleth. **No route lines** -- the standing rule against drawing roads nobody recorded. **The spacing is the finding.**

★★ **The two shapes are completely different and that is the point.** TwoRed: four transcontinental strings, the Alaska Highway, the Maritimes. **Creamsicle: a Pacific coast run from Vancouver Island to southern California, and two Midwest corridors.** @sec-car-cost said the CAR was a constant; the choropleth said the DRIVER was; **these two say the TRIPS were not.**

⛔ **Not yet placed in a chapter.** Candidates: @sec-long-days (cadence is that chapter's subject) or ch.13 alongside the choropleth. Kim to rule.

### ✓✓✓ RULED 2026-09-01 — the stop maps go in CH.13, and Kim's reason is a caveat I had not made explicit

> I'd argue for maps in Chapter 13. **Fuel stops, we need to remind ourselves, are not a measure of a day's drive. Sometimes, two fuel stops are required in a day.** So putting the maps in Chapter 5 might be misleading. These complement the choropleth map.

★★★ **He is right, and I had been loose about exactly this.** I had offered the cadence reading as *"the three-hundred-mile day made visible"*, which quietly assumes one fill per day. **It is not true often enough to matter.**

**Measured rather than hedged, and now derived in `stops_data()$perday`:**

| | TwoRed | Creamsicle |
|---|---|---|
| fuelling days | 227 | 121 |
| **days with MORE THAN ONE fill** | **63 (27.8%)** | **46 (38.0%)** |
| most fills in one day | 3 | 3 |
| fills per fuelling day | 1.30 | 1.43 |

★★ **So the gap between two adjacent dots is a FLOOR on how far the car went that day, never a reading of it.** Written into ch.13 as its own section, *What a dot is, and what it isn't*, which hands the cadence question to @sec-long-days where a clock and an odometer can answer it properly.

### ★★★ BOTH STOP MAPS PLACED IN CH.13 — two new sections, and a third finding falls out

**`## The same map, one dot at a time`** carries `@fig-stops-twored` and `@fig-stops-creamsicle`; **`## What a dot is, and what it isn't`** carries the caveat. Ch.13 is now **~2,110 prose words, 10 sections, 4 figures and 1 table.** Voice 28.9 per thousand, 0 em dashes.

★★★ **THE THIRD FINDING, which neither the choropleth nor the cost chapter could reach.** @sec-car-cost: the CAR is a constant (four tenths of a mpg). The choropleth: the DRIVER is a constant (no new states in the second car). **The two point maps: the TRIPS were nothing alike** -- TwoRed is four transcontinental strings plus the Alaska Highway and the Maritimes; Creamsicle is a Pacific coast run and two Midwest corridors. **Same person, same machine, same continent, completely different shape.**

★ And the ending of that section: **the one place the dots stop entirely is the Gulf of Alaska** -- four days of movement and no transaction, @sec-marine-highway compressed into a blank patch of ocean.

### ⚠⚠ CLEAN-UP FOUND A REGRESSION AND A BACKLOG

**REGRESSION, fixed: `fig_cost.R` had em dashes in its panel titles AGAIN** -- `"how far the tank was driven  —  +4.61 mpg per 100 miles"`. These are PRINTED in a figure. Replaced with a colon; `fig_cost.png` rebuilt. ⚠ **This is the second time the same file has done this**, which says the earlier fix did not stick. **The sweep must run before every session close, not only when a figure is touched.**

**BACKLOG, logged not fixed: 78 em dashes in the PROSE of the early chapters** -- `the_anchor` 23, `is_it_safe` 20, `small_cars` 14, `index` 12, `expeditions` 8, `afterword` 1. **These predate the voice rule** and sit in chapters Kim has read and approved. ⛔ **Not mass-substituted at the end of a long day** -- an em dash resolves to a comma, a colon or a parenthetical depending on the sentence, and 78 unreviewed edits to approved prose is a worse risk than the inconsistency. **Queued in `deferred.md` as a proper editorial pass.**

**Also removed:** the superseded single-car `figures/stops.png`. **Swept `R/` clean: 0 em dashes, 0 hardcoded chapter numbers across all 14 modules.** No stray underscore-prefixed temp files anywhere in the book tree.

---

Older entries were moved to `logs/session_log_archive.md`: 133 on 2026-07-30 (by pkm_health.R), and 31 more (2026-08-31 back to 2026-07-22) on 2026-10-28 by hand, placed at the archive's top.
They are verbatim, newest first. Search there before concluding an entry is missing.
