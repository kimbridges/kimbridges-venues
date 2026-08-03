# specimen_labels -- project log
_Split from proj_specimen_labels.md on 2026-07-30. Verbatim; nothing edited._
_Live project file: `../proj_specimen_labels.md`_

---

## Log

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

**★ THE FUNCTION-REFERENCE APPENDIX IS WRITTEN (2026-07-29 cont. 2).** `appendix.qmd` replaced its stub with a full reference to `vouchr` 0.1.0, built from the roxygen docs rather than from memory, in five groups in use-order: **printing the cards** (`make_qr_cards`, `make_number_cards`, `qr_calibration_sheet`, `validate_qr_engine`, `avery_5371`) · **reading the photograph** (`read_photo`, `decode_qr`, `read_exif`, `parse_cards`) · **deriving the site** (`site_extract`, `site_place`, `site_geology`, `site_soil`, `site_substrate`, `site_hillshade`, `deg_to_compass`) · **assembling the record and its two views** (`assemble_record`, `read_capture`, `make_label`, `make_log_row`) · **discovering the decks** (`fetch_records`, `first_collector`, `signature_features`, `discover_decks`, `signature_heatmap`). **Completeness was checked mechanically, not by eye:** the five groups account for 5+4+7+4+5 = **25**, and a script cross-checked the documented entries against `NAMESPACE` -- nothing missing, nothing duplicated, nothing invented. That check is the point, given the day's other lessons; a reference is exactly the kind of artifact that looks complete while quietly omitting three functions. The prose carries the *reasons* alongside the parameters where a reason exists -- why `bind_left` is kept apart from `x_offset`, why `analysis_scale_m` is a parameter and not a constant, why `ledger` refuses a reissue, why substrate is derived rather than carded, why `determined_by` is lifted out of the observations -- so the appendix reads as a statement of what the system is made of rather than a wall of signatures. Also documented: the two outside tools and the single step each is needed for (Python pyzbar/OpenCV via reticulate for decoding, `exiftool` for EXIF), since R has no maintained QR *decoder*.

**★ THE HARDCODED GOOGLE KEY: ASSESSED, SOURCE CLEANED, PROVIDER ACTION IS KIM'S (2026-07-29 cont. 3).** Kim asked whether the key had actually been exposed or whether rotating is precautionary. Checked rather than assumed. **No evidence of exposure:** the key appears in exactly ONE file (`QR_procedures.Rmd`, twice -- a ggmap `register_google()` call and an Elevation API call, same literal); **it is NOT in the public `vouchr` repo** -- both copies of `site_extract.R` read `Sys.getenv("GGMAP_GOOGLE_API_KEY")` and always have; **`specimen_labels` is not a git repo at all**, so it was never pushed anywhere; **Drive permissions show a single entry -- Kim as owner -- on the file, on `specimen_labels`, and on the parent `Projects` folder**, so no link-sharing and no other principals; the document was **never published** (nothing QR- or label-related among the 19 live documents, and `Site_Extract.pdf` from the same era is image-only with no key text); and a Drive full-text search for the key prefix returns nothing. So **rotating is precautionary on the available evidence.** **★ TWO THINGS THAT MATTER MORE THAN ROTATING.** (1) **Editing the file does NOT remove the key from Google Drive revision history** -- Drive keeps prior versions, so only revoking at the provider actually neutralises the literal. The source edit prevents recurrence; it is not cleanup. (2) **The right action is probably DELETE, not rotate.** Nothing current needs a Google key: `site_extract()` defaults to `source = "aws"`, and Macrostrat, SSURGO and Nominatim are keyless -- the Google path is a legacy fallback, and the book's equity argument IS the keyless stack. Deleting is strictly safer than rotating, and a fresh restricted key takes minutes if the fallback is ever wanted. **The one exposure question no file check can answer** -- whether the key was ever called from somewhere unexpected, or pasted into mail, a screenshot, the retired D: mirror, or the `P://` path still referenced at line 617 -- lives in the Google Cloud console's usage metrics and restriction settings. That is worth a look either way. **DONE HERE:** both literals replaced with `Sys.getenv("GGMAP_GOOGLE_API_KEY")`, CRLF endings preserved, and a comment block added recording why a literal was dangerous even in a private folder -- **the document sets `echo = TRUE` globally and renders to PDF, so any literal in a chunk prints into the rendered output.** That, not the folder's privacy, was the real hazard.

**★ LIVE WORKED EXAMPLES RUN ON KIM'S MACHINE (2026-07-29 cont. 4).** Four of the five chapter placeholders now have real output in `documentation/images/`, each verified by content and not by exit code. **⚠ FIRST, THE NEAR MISS: the INSTALLED `vouchr` was 0.0.0.9000 with 21 exports** -- the build from BEFORE the 07-28 rebuild. Its `make_qr_cards()` was the old `marrangeGrob` version with no `bind_left`, and `validate_qr_engine()` did not exist in it. Running the deck-sheet example against that library would have rendered a perfectly plausible sheet showing **exactly the geometry the chapter says was wrong**, with no guard to stop it. Reinstalled from source -> 0.1.0, 25 exports, `bind_left` present, and `validate_qr_engine()` passes against the real `qrcode` engine. ★ **The rule: a documented version and an installed version are different facts.** Check which one is loaded before trusting any figure it produces -- Finding 020 again, at the library level. **(1) DECK SHEET** (`deck_sheet.png`, plus `deck_sheet_guides.png` showing card outlines, the reserved band and the punch mark -- the better book figure since it makes the binding argument visible). Verified independently: page is 8.5 x 11in, the ten QR centres sit within **0.02in** of the true Avery clear-zone centres (3.19 / 6.69in x; 1.5 to 9.5in y), and **10 of 10 codes decode from the rendered sheet** -- position AND content both measured. **(2) END TO END** on `Example_1.jpg`: **6/6 codes** decode (confirming the 07-28 claim), EXIF read, site derived, record assembled, label and log row produced. `Determined by` lands correctly as a first-class field. **(3) DERIVE** on the project's own Kilauea coordinate (19.435731, -155.336334, taken from `reader_assembler.R`'s example rather than invented): elevation **1344.1 m**, slope **4 deg**, aspect **99 deg (E)**, roughness 1.6 m, native resolution 4.4 m at a 31 m analysis scale; bedrock **Kau Basalt, lava flows, 0-2.588 Ma** (Macrostrat); soil **Andisols, Haa-Keamoku complex** (SSURGO). **This reproduces the 2026-07-01 recorded result exactly and matches `derive.qmd`'s prose word for word** -- "a gentle, east-facing slope, high up, on young basalt, over the ash soils that weather there." Hillshade with the collection point marked saved as `derive_hillshade.png`. **(4) DISCOVER DECKS** from the cached CSV: 1,144 records, 20 collectors at >=10 specimens, 4 clusters. **All four archetypes reproduce**, including the one I first thought had not: cluster 4 is `uehana` = *"Shea Uehana (ORCID...)"*, all 14 records `institutionCode = NEON`, signature templated to **1.00 across the board with `coll_number` 0.00 and `phenology` 0.00** -- precisely the "machine" archetype as described. I reported it missing before checking; the check is what corrected me. Describers (identified_by 0.96, tax_content 0.43), place-recorders (eco_content 0.88, identified_by 0.08 -- self-determined), terse (Dawson at 0.00 on every feature). **Phenology confirmed as the universal gap: 17 of 20 collectors at zero, mean occupancy 3.4%.** Heatmap saved; its first render had the x-axis labels colliding with the title, fixed by moving them to the bottom. **★ THREE DEFECTS FOUND WHILE DOING THIS, worth carrying.** (a) **`discover_decks()` cluster numbering is inconsistent**: the plot re-numbers clusters for display, so `dd$clusters` / `dd$profiles` call the terse group 1 and the machine 4, while the figure labels them 4 and 1 -- the two most distinctive archetypes, swapped. The book is safe because `discovering-decks.qmd` NAMES the archetypes instead of numbering them, but anyone cross-referencing the object against the figure will mislabel them. A vouchr bug. (b) **`metrosideros_US_1985_2026_fulldwc.csv` has 27 columns, not the 161 the GBIF pull returned** -- "fulldwc" is a misnomer; the analysis reproduces for the 12 existing signature features, but adding a feature requires re-pulling. (c) `file.info()$size` immediately after writing to G: reports a stale value (4096 bytes for files that are really 57-227 KB) -- Drive Stream write buffering, which is why every figure here was verified by staging it back and looking at it. **★ THE ONE BLOCKED EXAMPLE, and it is an honesty question, not a technical one.** `Example_1.jpg`'s EXIF puts it at **21.30219, -157.85729 -- Honolulu**, and the derived record reads "Hawaii Capital Historic District, Honolulu County", elevation **2 m**, slope **0 deg**, Makiki clay loam. The pipeline is perfect; the provenance is a bench test on a couch. But `closing-the-loop.qmd` introduces this photograph with *"It was taken in the field"* and `discovering-decks.qmd` ends on *"one photograph on a slope"*. **Not done and not to be done: pairing these real decoded cards with the Kilauea coordinate to make it look like a field collection.** That is the placeholder-QR failure in a new costume -- a plausible artifact that no check would catch. Kim to choose between an honest caption (which would also demonstrate the urban reverse-geocode fix and SSURGO working in a city) and waiting for a real field frame.

**★ ALL FIVE WORKED EXAMPLES NOW LIVE IN THE CHAPTERS (2026-07-29 cont. 5).** Kim ruled on the provenance question: **honest caption, and make a virtue of it.** **`closing-the-loop.qmd`** now names where the frame was actually taken, in the book's own voice -- a bench run at home, on a couch, not a collection -- and says why the honest version is shown: *"I could have quietly swapped in a coordinate from a real ohia forest and the output would have looked more like the argument I have been making, and I would rather show you the honest one, because a system you cannot audit is not a system you should trust."* The chapter then turns the limitation into a demonstration: **the urban record is the one run that exercises the compose-from-reliable-levels reverse-geocode fix**, and SSURGO is as sure of a Honolulu clay loam as of volcanic ash. "The machinery does not know it is indoors." Live chunks for decode -> EXIF -> substrate -> label -> log row, plus `Example_1.jpg` as the input figure. **`discovering-decks.qmd`**: the heatmap in place with a door-caption, plus a short read-the-figure-first paragraph; and its closing line **"one photograph on a slope" -> "a single photograph of a handful of cards"**, since the slope was never in evidence. **`derive.qmd`**: live `site_extract()` + `site_substrate()` on the Kilauea pair, and a hillshade figure whose caption says the relief is subtle *because it is a four-degree slope, not a cliff* -- the figure agreeing with the number rather than flattering it. **`the-workflow.qmd`**: the deck CSV as a table, the guides sheet as the rendered-output figure (chosen over the plain sheet because the grey band makes the binding argument visible), and the folder pass. **★ A FALSE CLAIM CAUGHT BY RUNNING THE CHUNK RATHER THAN TRUSTING THE PROSE.** I wrote that the two frames "agree on all seventeen fields." Verified: there are **sixteen** fields, and they do **not** all agree. Fourteen are identical -- every card value, the coordinate to the last digit (0 m separation), and every derived value; the two that differ are the **file name**, which must, and the **timestamp, by eight seconds**. Corrected to say exactly that, which is a better sentence anyway: *"two independent readings that disagree about nothing that matters."* The near miss is the point -- a plausible round number, written from memory of what the run ought to have produced, one verification away from entering the book. **Third instance today of the same discipline paying off** (stale installed package, wrong measurement reference, invented field count). **Also confirmed:** `decode_qr()` gets **6/6 on BOTH frames**, better than the "5/6 raw, 6/6 with one Otsu pass" recorded on 07-28 -- the packaged reader does the multiple passes internally, so the improvement is the packaging, not the camera. All chunk paths were tested from `documentation/` (Quarto's execute-dir for a book project) and every figure asset resolves. **NOT YET DONE: a full `quarto render`** -- `system2()` is blocked from this bridge, so the chunks were verified individually rather than by rendering the book. Kim should render once before deploying.

**★ FULL BOOK RENDER DONE AND VERIFIED (2026-07-29 cont. 6) -- correcting the "not yet done" note above.** The earlier entry recorded that a full `quarto render` had NOT been run because `system2()` is blocked from the r-studio bridge. **It is done.** `quarto::quarto_render()` works from the bridge (the R package does not trip the system-command restriction), and the whole book built: 13 chapters, quarto CLI 1.8.27. **Verified by inspecting the artifacts, not the timestamps:** title reads **Voucher Labels**; every live chunk's output is present in the HTML (`Phenology: No Flowers`, `Number: KWB 1243`, `Det.: KW Bridges`, the Honolulu locality, Makiki / Inceptisols / Honolulu Volcanics, 1344 m, Kau Basalt, Andisols); both tables rendered; all four figures resolve and ship into `_output/images/` plus a generated `derive_files/` for the live hillshade; and **a sweep of all 13 pages for leaked R errors and warnings comes back clean.** **★ WHY KIM WAS STUCK, worth keeping as a workflow fact:** rendering a book means rendering the **project directory**, not a file -- `quarto::quarto_render("<dir>")`. Rendering a single chapter `.qmd` builds it standalone with no TOC, no cross-references and no site, which is what "doing a file at a time isn't working" was. Root cause: **there is no `.Rproj` anywhere under `specimen_labels`**, so RStudio never offers the Build pane's "Render Book" button. Creating one in `documentation/` would restore the button. **Confirmed harmless:** a book project renders only the files listed under `chapters:`, so the superseded `limits.qmd` stub in the project directory is NOT published -- checked against `_output`, which contains exactly the 13 chapter pages and no `limits.html`. No config change needed. **FOUR PLACEHOLDERS REMAIN**, all in chapters untouched today, and they pass through as HTML comments (invisible to readers, still in the source): `mechanisms.qmd` wants the single-card "Life Form: Tree" scan-returns-plain-text demo and a cards-laid-out-flat shot; `field-log.qmd` wants the collection-points-on-hillshade map and the canopy-physiognomy figure. **The first two are reachable now** (a one-row deck through `make_qr_cards()`; `Example_2.jpg` for the layout, keeping `Example_1` unique to the closing chapter). **The two field-log figures are genuinely blocked** on material that does not exist yet: a day with several real collections, and a canopy image to read.

**★ KIM'S THREE NEW PHOTOGRAPHS WIRED IN; LOGO SETTLED; RENDER CLEAN (2026-07-29 cont. 7).** `Tree_card.jpg` -> `mechanisms.qmd` as the scan-returns-plain-text demo (it decodes to `Life Form: Tree`, checked). `Example_2.jpg` -> `mechanisms.qmd` as the cards-laid-out-flat figure, keeping `Example_1` unique to the closing chapter. **`Deck_spread_out.jpg` -> `decks.qmd`, and it is the best figure in the chapter**: cover, blank card, four life-form cards, blank card, cover -- the construction Kim described, and it lands directly beneath the paragraph about why the blank cards are there. `Decks_and_specimen_card.jpg` -> `decks.qmd` as the kit-as-carried figure (five closed decks + the number card), which also carries the bill-of-materials argument visually. **★ THE LOGO QUESTION IS ANSWERED BY TEST, NOT BY GUESS.** I had left it off because `navbar.logo` is not a documented book-level option. **`book: sidebar: logo:` DOES work** -- rendered, referenced in `index.html`, and shipped to `_output/images/`. Kim's regenerated 250x250 `voucher_logo_art.png` is in place. Full re-render: 13 pages, error sweep clean, the only remaining placeholder comments are `field-log.qmd`'s two. **★ A COLOUR MEASUREMENT WORTH KEEPING, AND A QUESTION.** The five cover colours are consistent across three independent frames -- yellow hue 40-45 deg, green 170-175, purple 292-296, silver sat 0.06-0.08, pink 346-353 -- so `decks.qmd`'s scheme holds, except that "gray for abundance" is more accurately **silver** (it is metallic). **But `Deck_spread_out.jpg`'s covers measure RGB(70,11,5), value 0.27, against RGB(187,46,63) at value 0.73 for the same life-form cover in `Tree_card.jpg`** -- same red hue family, a third the brightness. The white cards in both frames are exposed comparably, so it is not the lighting. **Most likely explanation, and it is Kim's own:** the covers "are not completely opaque," so a black backing reads through and darkens them, while a pale surface does not. If so the figure demonstrates the very translucency that motivates the blank cards, and the caption now says exactly that. **Written so it does not name the colour, pending Kim's confirmation** -- the third time today a colour claim has needed checking rather than asserting. **⚠ `photos/kipuka_puaulu/` DOES NOT CONTAIN KIPUKA PUAULU PHOTOGRAPHS.** Kim mentioned he is working on that set. The folder currently holds three files -- `PXL_20260729_0444*.RAW-01.jpg` -- which are **byte-identical (MD5-matched) to `Example_1.jpg`, `Example_2.jpg` and `One_deck.jpg`**: the card photographs taken at his house on 07-28 at 18:44-18:46 HST, EXIF **21.30219, -157.85729 (Honolulu)**, not 19.435 / -155.30 (Hawaii Volcanoes NP). Presumably a staging folder not yet populated, or a mis-copy. **Flagged rather than used:** building a "Kipuka Puaulu collecting sites" map out of three frames shot on a couch in Honolulu is precisely the failure this project keeps catching, and it would have been invisible in the finished figure. **★ PLANNING NOTE FOR WHEN THE REAL SET ARRIVES.** Kim: *"these were not taken with decks (no specimen collection in the National Park without a permit), they do show site locations where I'd likely have taken a sample."* So the field-log map must NOT imply collections -- **no permit means no specimens, therefore no collection numbers.** Framed honestly it is arguably a BETTER figure for that chapter than a real collection would be: it shows the spatial layer of a field log built from photographs alone, and it exercises the chapter's own **absence-as-information** argument -- where a collector went and where they did not -- without ever claiming a specimen was taken.

**★ THE KIPUKA PUAULU FIGURES ARE IN; ONE PLACEHOLDER LEFT IN THE WHOLE BOOK (2026-07-29 cont. 8).** Kim supplied nine photographs in `photos/kipuka_puaulu/` -- **genuine this time**, verified before use: EXIF puts them at 19.4246 to 19.4442 N, -155.3034 to -155.2766 W, taken 2026-03-06 between 12:04 and 13:11 HST, centroid 477 m from the kipuka, and none matching the Honolulu card frames that had been sitting in that folder earlier. **Nine photographs, eight distinct GPS fixes** (two are the same fix 16 seconds apart); seven fall within 60 m of one another, and two lie 1.5 km SSE and 2.8 km E. **TWO FIGURES BUILT, at the two scales `field-log.qmd` asks for.** `fieldlog_sites.png` -- the eight fixes on a hillshade with 20 m contours and a scale bar, over a 3 km frame, DEM fetched at ~9 m and reprojected to UTM 5N. `fieldlog_region.png` -- the same points as one dot on a 40 km frame with the Kilauea caldera (3.9 km SE), the crater chain, and the shoreline taken as the zero contour of the same elevation record. Per-site derived values also computed for reference: elevations 1202-1247 m, slopes 0-8 deg, aspects SSW to ESE. **★ THE HONEST FRAMING IS IN THE PROSE, NOT BURIED IN A CAPTION.** Kim: no collecting in a national park without a permit, so these are places he *would* have sampled. The chapter now says so in its own voice before the figure -- "there are no specimens behind these points and no collection numbers, and everything else on the map is exactly what a real day would have produced" -- which is the same move as the closing-the-loop bench-run disclosure. **It is arguably a BETTER figure than a real collection would have been**, because it proves the spatial layer is built from photographs alone, and the empty middle of the frame exercises the chapter's own absence-as-information argument. **TWO SELF-CAUGHT DEFECTS while building them.** (a) First draft of the regional map put the label "Pacific" on green **land** -- I had positioned it by eye from the plot margins. Fixed by computing the centroid of the cells below zero and placing the label there: **when a label can be derived from the data, deriving it beats eyeballing it.** (b) The first site map had labels 1/2/3/5 illegibly overlapping, because those fixes are 0 to 58 m apart; fixed with leader lines to offset labels, and the coincident pair is now stated in the title ("nine photographs, eight fixes") rather than hidden. **RENDER: 13 pages, error sweep clean, both figures shipped.** **ONE placeholder remains in the entire book** -- `field-log.qmd` line 23, the canopy-physiognomy figure, which needs a canopy or satellite raster for the site plus a blind physiognomic reading of it. Per design_notes (2026-06-30), the cheap DSM-DTM difference **saturates over tall closed forest** and reported 8 m for a stand near 20 m at this very kipuka, so that route is a detector and not a measure; the Meta/WRI 1 m GEDI-calibrated product streams keyless from open AWS and gave 15.8 m here, and is the right source if the figure is built.

**★★ THE CANOPY FIGURE IS BUILT AND THE BOOK HAS NO PLACEHOLDERS LEFT (2026-07-29 cont. 9).** **The Meta/WRI 1 m GEDI-calibrated canopy map came down keyless, exactly as design_notes (2026-06-30) said it would:** `tiles.geojson` (56,145 tiles) -> the quadkey containing the kipuka centroid (`022300033`) -> `chm/022300033.tif` via `/vsicurl`, a 65,536 x 65,536 raster at 1.19 m in EPSG:3857, cropped over the fixes in seconds. No key, no account, no package beyond `terra` and `sf`. **★ REPRODUCTION CHECK PASSED TO A TENTH OF A METRE.** design_notes recorded Meta 1 m at Kipuka Puaulu as **15.8 m, mean within 45 m**. Recomputed per-site today: site 5 gives **15.7 m**. The 06-30 measurement is reproduced almost exactly, which also identifies which of the nine fixes it corresponds to. **THE DERIVED PHYSIOGNOMY.** Around the seven wooded fixes the canopy runs mostly **12-16 m with emergents to 23 m** (per-site means within 45 m 9.5-15.7 m; 95th percentiles 16-21 m; maxima 18-23 m), and about **a quarter of that ground stands below 2 m** -- gaps, glades and grass. **★ AND A GENUINELY NEW RESULT: the canopy layer recovers what a KIPUKA IS, from the coordinate alone.** Over the wider 3.8 x 3.1 km window **72% of the surface is under 2 m and the median is 0**, while inside the cluster the median is **10 m with 49% over 10 m** -- an island of old forest standing in younger lava, which is the definition of the word, read off a raster by a machine that was told nothing but a latitude and longitude. The two outlying fixes are outside the forest and the map says so: site 4 reads **0.1 m (99% open)** and site 8 **1.9 m (65% open)**. Their earlier terrain results now make sense too -- site 8's slope 0 deg and roughness 0.1 m are open ground, not a measurement error. **★ KIM'S GROUND PHOTOGRAPH IS THE CHECK, NOT THE FIGURE -- and he agreed with the argument.** He offered `PXL_20260306_220723260.jpg` for the canopy placeholder. Declined for that role on principle: the placeholder and the 2026-07-03 illustration convention both specify an image **fetched by the coordinate**, because the whole point of the physiognomy figure is that the description is DERIVED -- collection-spanning, attention-free, obtainable by someone who was never there. A ground photograph is an **observation**, costing exactly the field attention the derive argument exists to save, so using it there would have quietly inverted the book's central derive-vs-observe partition. It also carries no scale, so any height read off it would be a guess, against the standing rule that a derived value must carry its scale, source and limits. **Used instead as ground truth beside the derived map, which is the stronger figure and is native to this project's history:** Kipuka Puaulu is the exact site where DSM-DTM was caught reporting **8 m for a stand near 20 m**, and what caught it was Kim having walked in it. The chapter now re-enacts that finding -- derived reading, then the honest paragraph about why a derived value is worth only its check, then the photograph -- and the new map puts the tallest stems at 23 m, the answer that agrees with the ground. **TWO FIGURE DEFECTS SELF-CAUGHT:** the first render produced a **40-entry discrete legend** (unusable; switched to a continuous ramp), and the cluster label was **clipped off the frame edge**. **★★ MILESTONE: `<!-- FIGURE` and `<!-- WORKED EXAMPLE` counts across all 13 rendered pages are now ZERO.** Render clean, 15 image assets shipping. **★ A PATTERN THE READ-THROUGH SHOULD WATCH.** The book now carries **three explicit honest-provenance disclosures** -- the Honolulu bench run in `closing-the-loop.qmd`, the no-permit candidate sites in `field-log.qmd`, and the derived-versus-checked canopy pair. Kim: *"it would have been better to have an actual data point, but given the circumstances, let's see what we can do with demonstrations that include honest explanations."* Each disclosure is individually right and they are the book's integrity on display; **read together they could start to sound apologetic, and that is a tone question for the read-through, not a factual one.** The fix if it reads that way is to vary the register, not to remove the disclosures.

**★ DEPLOY PREPARED AND STAGED; THE DRAG-DROP IS KIM'S AND HAS NOT HAPPENED YET (2026-07-29 cont. 10).** Kim called it a wrap and chose to proceed without a further read-through, having approved the acknowledgements explicitly. **Slug decided: `vouchr`** -- on the precedent that companion-package documents take the package name (whittakerr, coenosr, checklistr, lists, gePoints), and matching ai_microscope where the card reads one thing ("Preview & Review") and the folder another. So the card reads **Voucher Labels** and the URL will be `kimbridges-documents.netlify.app/vouchr/`. **Steps 2-5 of the documented Deployment Workflow are DONE, each verified rather than assumed:** **(2)** `_output/` **contents** copied from R into a fresh `kimbridges-documents/vouchr/` (18 of 18 items; `index.html` at the folder root; **explicitly checked for the coenosr nesting slip -- no stray `_output/`**; 14 pages, 24 MB), plus the cover placed at the folder root as `vouchr_cover_art_text.png` to match the `<name>_cover_art_text.png` convention. **(3)** Listing stub `docs/vouchr.qmd` written -- title "Voucher Labels", subtitle from the book, categories Botany / Methods / R, image and View-Document link both confirmed to resolve. **(4)** `vouchr/**` inserted into `_quarto.yml` `resources:` in alphabetical position between `using_an_llm` and `whittakerr`. **★ The file is CRLF and was edited in BINARY to preserve that** -- byte delta exactly the 17 bytes of the inserted line, because `writeLines()` on Windows would have rewritten every ending in the file. Same trap as session_log.md this morning. **(5)** Collection site rendered (Finding 017 behaviour as recorded: overruns the bridge timeout, completes normally). **PRE-DEPLOY CHECKS, both passes of the 2026-07-25 routine:** every local `src=` in every page walked against disk -- **211 references, 0 missing** -- run once on `_output/` and again on the copied `vouchr/` folder, since the copy is the artifact that actually ships; 0 broken local `href=`. Then the built site verified: the **Voucher Labels card is on the index (20 cards, was 19)**, its cover path resolves, its link resolves to `_site/vouchr/index.html`, and the built book is confirmed to be the CURRENT build (title "Voucher Labels", the "already in the cabinets" claim, the logo asset, and the acknowledgements page with Nancy Furumoto in it). `_site` is **327.7 MB**, consistent with the ~300 MB recorded for this collection. **⚠ NOT YET PUBLISHED. STATUS IS STAGED.** Step 6 -- dragging the whole `_site` folder onto the **existing** `kimbridges-documents` tile's Deploys tab -- is Kim's, and there is no path to Netlify from this session. Recorded as staged rather than live **on purpose**: claiming publication before the artifact is public would be the same class of error as the 8 m canopy and the 0.372 in clearance. **The known trap, from the whittakerr deploy: "Add new project" creates a standalone site instead of updating this one.** Click into the existing tile first. **ON PUBLICATION, the following need updating and are deliberately left undone until then:** `proj_kimbridges_documents.md` (19 -> 20 documents, new log entry); `proj_specimen_labels.md` and `proj_vouchr.md` (Status, and the deployed URL); `project_index.md` (the specimen_labels row and the Active Focus, which can then close); `inventory_all_projects.md`. Also still open and unrelated to the deploy: the **uncommitted comment fix in `vouchr/R/make_qr_cards.R`**, the **`discover_decks()` cluster-numbering swap**, deleting the Google key, and the `proj_specimen_labels.md` log split.

**★★ PUBLISHED 2026-07-29. *Voucher Labels* IS LIVE at https://kimbridges-documents.netlify.app/vouchr/** -- the twentieth document in the collection. Kim drag-dropped `_site` onto the existing tile and verified the card and the document. **Four years to finish, in his words, and out in a day's work from a set of decks that printed wrong.** **STATUS SET TO COMPLETE / NOT APPLICABLE**, following the briefing_book precedent set 2026-07-28: *a pending review no longer holds a deployed project Active.* Colleague discussion is now expected and welcome, and it does not make the project unfinished. Everything left is either genuinely non-urgent or conditional, and **all of it moved to `deferred.md` (Mechanism 6, adopted today)** rather than left in Next Steps -- the log split, the tone pass on the three provenance disclosures, the cover-translucency confirmation, grey-vs-silver, the Abundance-deck question, the stale `P://` path, and the conditional about replacing the bench-run example if a real permitted collection ever happens. `inventory_all_projects.md` deliberately NOT updated: proj_PKM records that item as SUPERSEDED by the generated works register (Tier 2). **What shipped:** 14 pages, 24 MB, zero placeholders, error sweep clean; five live worked examples (`make_qr_cards` deck sheet, `site_extract` + hillshade, `read_photo` end to end, the folder pass, `discover_decks`); eleven figures, of which the QR geometry, the canopy reading and both maps were each verified against something independent of what produced them; a full function-reference Appendix covering all 25 exports, checked mechanically against NAMESPACE; and an Acknowledgements page. **Title settled as *Voucher Labels*, closing Open Question #1** (package `vouchr` / folder `specimen_labels` / book *Voucher Labels*). **The day's durable lessons, all of them the same shape:** a verified number must name what it was measured AGAINST, and in what unit; a documented version and an installed version are different facts; a layout drawn for an object in isolation can be correct and still fail in use; when carrying out a decision obliges you to preserve what it destroys, it is two decisions wearing one label; and when a label can be derived from the data, deriving it beats eyeballing it. Every one of them was found by checking rather than by reasoning.

### 2026-07-29 (documentation reconciled with the printing — four drifts, one number that measured the wrong thing)

Kim confirmed the resume item at session start: reconcile the chapters with the upgraded printing.
The audit came first, and it found more than the two drifts logged on 07-28.

**★ The recorded clearance measured the wrong thing.** `One_deck.jpg` was measured directly, scaled
off the card's known 3.5 × 2.0in edges (621.6 px/in, agreeing on both axes to 0.2 %). The layout
verifies where it was checked — QR right edge **3.013in** against 3.008in predicted. But the cover's
occluding edge sits at **1.804in**, **0.30in past the 1.5in `bind_left` reserve**, so the QR cleared it
by **0.127in, not the 0.372in in the record**. The 0.372in figure was always clearance against the
*assumption*, never against the *cover*. The punched hole measures **0.788in** from the card edge where
`punch_x` draws 0.375in — a hand punch reaches where it reaches, and moving the pivot right moved the
cover's reach right with it. **★ The rule, one level past Finding 020: a verified number must name what
it was measured AGAINST.** "0.372in clear" and "0.127in clear" are both true of the same deck; only one
is about the object. Kim's decision: correct the record, leave the code — the cards print and decode, and
widening `bind_left` costs QR size. Corrected in both copies of `make_qr_cards.R` (this folder's working
original and the canonical `vouchr/R/`), comments only.

**A fourth card kind: attribution.** Example_1 decodes six cards and two fit none of the three kinds
`decks.qmd` named — `Collected by: KW Bridges, YH Lau` (teal) and `Determined by: KW Bridges` (purple),
both built as bound screw-post decks. Adopted: **identity / attribution / observation / comment**.
Attribution earns the separation on a handling argument, not a taxonomic one: **its value does not change
from plant to plant** — you set it once in the morning and photograph the same card beside every specimen
all day. Identity changes per specimen, observation changes per specimen, attribution changes per trip.
This is the 07-28 "`Determined by` is FIRST-CLASS" decision arriving in the prose. A knock-on
inconsistency was caught in the same chapter and fixed: the filter paragraph says a determination is desk
work and fails the field test, which reads oddly beside a determination card — the card records WHO will
determine, and that is settled before you leave the house.

**The printed decks are not the decks in `decks/`.** Confirmed by artifact chain, not inference: the kit
Kim printed and photographed came from **`QR_field_notes.csv`** (rendered to `QR_field_notes_cards.pdf`
at 16:56 HST on 07-28, and shipped as `vouchr/inst/extdata/`), not from the three deck-discovery outputs
in `decks/`. Every payload in Example_1 is in that CSV, including the two labels — `Abundant Flowers`,
`Scattered Flowers` — that broke the narrowed clear zone and forced the auto-shrink fix. So the project
carried **two disagreeing phenology decks** for a month, and `decks/` has **no Abundance deck** although
the kit has one. Kim's decision: the printed set is canonical, so the figures agree with the photographs.
`decks/deck_universal.csv` phenology rows replaced; **the superseded five values are recorded verbatim in
`design_notes.md`**, because the edit overwrote a discovery output (Finding 019 — do not quietly rewrite a
record). Still open: whether `decks/` should carry the Abundance deck, and whether the discovery outputs
and the working printed deck should be one file or two clearly-labelled ones — they are two files with
nothing saying which is which, which is how this drift survived a month.

**The cover colour scheme was one-sixth documented.** The kit runs five coded covers — yellow phenology,
grey abundance, pink life form, teal collectors, purple determination — in a project whose own argument is
that you find the deck by colour before you read a word, and only yellow had ever been written down. All
five recorded, and named in `decks.qmd` as one collector's choices, not a standard. **Unresolved, flagged
not guessed:** the chapter said "a colored cover top and bottom"; the second cover reads white in
`One_deck.jpg` and the photographs cannot settle it, so the chapter now claims nothing about the back.

**What went into the book.** `decks.qmd` gained the fourth card kind, the colour scheme, and the binding
clearance **as a design finding rather than a repair** — the argument being that *a layout drawn for an
object in isolation can be exactly correct and still fail the moment the object is used, because use adds
constraints the drawing never saw.* The binding was invisible in the design file and decisive in the hand,
which is an argument for building a rough deck early instead of perfecting one on screen. `One_deck.jpg`
is its figure under the caption-as-door convention: the caption states both clearances, says they were
measured off the photograph, and notes the same frame decodes to `Phenology: No Flowers` — one image
serving as proof of clearance and proof of content. `the-workflow.qmd` gained the practical consequence
(punch every card in the same place, stay inside the reserved band, assemble and photograph one deck
before punching the rest) and the page-scaling-off warning.

**★ The cover art landed mid-session, and the title is not coupled to it.** `voucher_cover_art_text.png`
and `voucher_logo_art.png` were written at 10:41/10:42 HST while this session was reading the chapters.
The filenames are `voucher_*` where `_quarto.yml` had reserved `vouchr_*`, and **despite the "_text" in
its name the art carries no baked-in title** — so the AI_Microscope failure mode does not apply and the
title can still be chosen freely at the read-through with no reshoot. Both assets copied into
`documentation/images/`; `cover-image` wired and un-commented; the logo left off with a note, since
`navbar.logo` is not a documented book-level option. `title:` still reads the placeholder `vouchr`.

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

### 2026-07-28 (cont. 4 — documentation: "the answer is already in the cabinets")

**Kim:** *"That's been an important discovery in this project and it needs to be emphasized in the
documentation."* Checked first — the argument already existed and was well made in `decks.qmd` and
`discovering-decks.qmd`. **The gap was emphasis and placement, not argument.**

**★ Named it: "the answer is already in the cabinets."** Native to the book — the Introduction opens on
Linnaeus's cabinet ("order built into furniture") and closes on "the sheet in the cabinet," and the
sheets the method reads are literally in cabinets. Now in exactly three places.

**Three edits, read and approved by Kim.** `index.qmd` gains a paragraph before the closing one, hung off
his own phrase "everything the record should hold" — asking the question out loud, admitting he expected
the answer to be taste, and saying it wasn't. **Framed as a DISCOVERY** ("the part of this work I did not
see coming" — Kim confirmed the claim is correct and to keep it). `decks.qmd` names the answer and
**marks the distance** ("It belongs to the chapter after next"), which is the cheap repair for the
promise-to-delivery gap. `discovering-decks.qmd` delivers under the same name, and **a plain error was
fixed**: it credited "the last chapter" when the promise is in `decks.qmd`, two chapters back.

**No chapter reorder** — `decks.qmd`'s handoff into `derive.qmd` is well built and the name plus the
distance-marker already solve the gap.

**★ Phenology deck is YELLOW, not green.** Fixed in `decks.qmd` and in `design_notes.md`, which still
said "e.g. green = phenology." Kim's photos are ground truth (`One_deck.jpg`, `Example_1.jpg`).
**Second drift today between the built object and the written description** — the first was the collector
card's wording. **For the printing reconciliation: audit every physical claim in `decks.qmd` against the
decks in hand.**

**★ Open Question #1 CLOSED** (open since 2026-06-29). Package `vouchr`, folder/PKM `specimen_labels`,
book title deferred to the read-through. See the Note on the name at the top for the reasoning and costs.

**⚠ Live risk:** Kim is shooting the cover now. `_quarto.yml` reserves `vouchr_cover_art_text.png` — the
`_text` suffix plus the AI_Microscope precedent means title type gets set into the art, which would
decide a title that is deliberately still open. `title: "vouchr"` in `_quarto.yml` is a placeholder.

### 2026-07-28 (cont. 3 — vouchr v0.1.0 pushed; the package catches up with the project)

The working scripts here were ported into **`vouchr`** and pushed as **`0ad01e1`** (18 files,
+1141/−96), so the package no longer prints mis-aligned cards. `make_qr_cards()` replaced
wholesale; `make_number_cards()` + issued-number ledger, `qr_calibration_sheet()` and
`validate_qr_engine()` added; `assemble_record()` gained collector aliases and first-class
`determined_by`. **Imports 6 → 5** (gridExtra/readr/tidyr/purrr belonged to the old card maker
alone); exports 21 → 25; tests 8 → 21; `check()` 0/0/1 on Kim's machine. Both PDFs rendered
*through package code* decode 16/16 and 10/10.

**A bug caught by a test expected to PASS:** `check_template()` accepted a 4in card on a 3.5in
pitch — cards would overlap and print on top of each other while the sheet-extent check passed,
since 0.75 + 3.5 + 4 = 8.25 fits inside 8.5. Pitch-overlap checks added in both axes.

**★ `proj_vouchr.md` created — an intake gap of the Jones shape.** vouchr has been a public
package since 2026-07-02 with no proj file and no index row, while every sibling
document+package pair carries two (checklists/checklistr, lists/listsr, seasonality/seasonalityr,
Ceska/coenosr). Its history before today stays HERE; the new file points back rather than
reconstructing.

**Duplication to resolve:** `make_qr_cards.R`, `make_number_cards.R` and `reader_assembler.R`
now exist both in this folder and in the package. The package should be canonical and this
folder should consume `library(vouchr)`, or the copies will drift. Logged as vouchr Next Steps 1.

### 2026-07-28 (cont. 2 — ★★ THE SYSTEM WORKS END TO END: 6 codes from one photo → a real label + log row)

**★ THE FOUNDING CLAIM IS CONFIRMED ON REAL PHOTOGRAPHS.** Kim reprinted from the real `qrcode`
engine, reassembled the decks, and shot three photos. Decoded with the reader's own preprocessing
ladder:

| photo | cards in frame | raw zbarimg | with ladder |
|---|---|---|---|
| Example_1.jpg | 6 | **6** | 6 |
| Example_2.jpg | 6 | 5 | **6** |
| One_deck.jpg | 1 | **1** | 1 |

Payloads returned exactly (`Collected by: KW Bridges, YH Lau`, `Life Form: Shrub`, `Phenology: No
Flowers`, `Number: KWB 1243`, …). **Multiple QR cards in ONE frame all decode** — the 2026-06-29
two-code test now holds at six, on a phone, in ordinary indoor light.

**The near-miss, and the margin it reveals.** In Example_2 the "Determined by" card is plainly
visible but did NOT decode raw — verified a genuine decode failure, not an absent card. It recovers
under **Otsu thresholding**. Measured against a card that decoded easily: focus (Laplacian variance)
**265 vs 354**, ink density **73 vs 42**. Slightly softer, slightly greyer, at the frame edge on a
purple deck. **One binarization pass is the difference between 5/6 and 6/6** — which validates
`decode_qr()`'s existing ladder design. Caution logged: **CLAHE alone made things WORSE** (6→1 and
5→0); keep it paired with Otsu, never bare.

**`One_deck.jpg` is the proof shot for the binding fix** — deck closed on the screw post, one card
swung out, its QR entirely clear of the occluded band, decoded first try.

**★ FIRST REAL LABEL AND FIELD-LOG ROW, from a real field photograph, with no transcription
anywhere in the chain.** EXIF supplied `21.30219, -157.85729`, `122.5 m`, `2026-07-28 18:44:45
-10:00`.

**An integration bug the photographs alone could not have shown.** Running `assemble_record()` on
the real decoded strings printed **`Collector: NA`**: the deck CSV writes **`Collected by: …`**
while the assembler looked only for `Collectors` / `Collector`, so the collector name fell through
into `observed`. **Fixed by widening the alias list, NOT by reprinting cards** — the decks are
physical and already made, and "Collected by" is the better label wording. Legacy spellings still
resolve. *This is Finding 020's rule paying off immediately: exercise the artifact the way its
consumer will.*

**★ DESIGN DECISION (Kim): "Determined by" is a FIRST-CLASS field, not an observation.** An
observation card records what the collector SAW; a determination records WHO ASSERTED the
identification — it carries an authority and can be revised by a later worker without disturbing
anything observed in the field. `determined_by` now sits beside collection number and collector in
the record, appears as a `Det.:` line on the label, and is a column in the log row; the line is
omitted when no determiner card is present. Aliases: `Determined by / Determined By / Determiner /
Det by / Det`.

**★ KIM'S ASSESSMENT OF THE PHYSICAL SYSTEM — captured verbatim in `design_notes.md`** ("The system
proved in the hand"). Three claims separated there as the spine of the deck chapter: (1) **the bill
of materials IS the argument** — printer, Avery business-card stock, a paper punch, screw posts,
plastic report covers, i.e. the friction thesis at the level of procurement; (2) **"having the
categories makes decisions quick"** is the *field-side* payoff and is a DIFFERENT claim from
no-transcription, which is the *lab-side* payoff — recognition beats recall beats composition,
exactly when conditions are worst; (3) **the hard part is deck design, and the system is
deliberately NOT prescriptive** — "Choose the content for the purpose of the collection." Noted
there as well: not prescriptive about content ≠ silent about method, since deck-discovery, the
collector-signature analysis and the derive-vs-observe partition are precisely how a collector
derives a deck for their own discipline. **Weatherproofing named and put out of scope** on purpose,
to keep the bill of materials at the stationery level.

### 2026-07-28 (cont. — ✗ THE PRINTED CARDS DO NOT DECODE; they carried placeholder codes; Finding 020)

**Kim's test, and the honest result.** He photographed the assembled decks in two arrangements
(`photos/Example_1.jpg`, `Example_2.jpg`) to test the project's founding technical claim — that
several QR cards in **one** photograph all decode. **Zero codes read in both.** The test is
**INCONCLUSIVE, not negative**: the cards never carried data.

**Cause.** With no CRAN access in the cloud sandbox, Claude stubbed `qrcode::qr_code()` with a
random-fill generator so PDF *layout* could be tested, and **Kim printed those placeholder PDFs**.
Every code on both photographs shows **one finder pattern at top-left and none at top-right or
bottom-left**; a real QR has three. The generated PDF and the photographed card match module for
module. The files were labelled as placeholders in prose, three times — which is not a safeguard
when the artifact itself is a perfectly formatted, print-ready sheet of business cards.

**What this cost:** a print run, deck assembly (punching, posts, colour coding), and a field
session. **What it did not cost:** any data, or any collection number — none reached a specimen.

**★ Finding 020** (pkm_findings.md): *a verification loop that cannot tell a real artifact from a
plausible-looking one is not verification.* Every geometry check passed — placements to 0.00007in,
0.372in binding clearance on all sixteen cards, page counts, glyph overflow. **All measured
POSITION; none measured CONTENT.** A QR card exists to decode; position is a precondition, not the
point.

**The structural fix (shipped).** `validate_qr_engine()` in `make_qr_cards.R`, called by both makers
before anything is written: three 7×7 finder patterns, timing row/column 6 alternating, a legal side
length of 21+4(v−1) — **pure R, no scanner, no external tools**, so it runs on Kim's machine too.
Hard-stops with nothing written on failure. Verified it **blocks** the stub and **passes** genuine
QR codes.

**A second lesson, from building the first.** The initial validator rejected the stub *and would
have rejected every real code* (an integer-vs-double `identical()` comparison; an off-by-two in the
timing run). Caught only by testing against genuine QR matrices from an **independent
implementation**. **A validator must be proved against known-GOOD inputs, not just known-bad ones.**

**Housekeeping:** `number_cards_ledger.csv` reset to empty so **KWB 1243–1252 can be reprinted**.

**★ THE EXPERIMENT IS STILL OPEN.** Multi-code-in-one-frame decoding, and whether the two
arrangements differ, remain untested. The photographs are good — even lighting, codes flat and
unobstructed, and the binding clearance visibly works as designed in Example_1. Reprint from real
`qrcode`, rebuild, re-shoot.

### 2026-07-28 (★ THE CARDS PRINT — two independent defects fixed; number cards built)

**Kim's report:** the QR codes on the printed decks needed to move "about 1 inch to the right." That turned
out to be **two separate problems**, and the distance between them is the part worth remembering.

**Defect 1 — sheet alignment.** `make_qr_cards.R` used `gridExtra::marrangeGrob(ncol=2, nrow=5)` over the
whole page, which makes ten equal **4.25 × 2.20** cells. Avery 5371 cards are **3.5 × 2.0** inside a 0.75in
side margin. Cell centres 2.125 / 6.375in vs true card centres 2.500 / 6.000in — **0.375in off, in
opposite directions per column**, so one uniform nudge could never have corrected it. Rewritten so each
card gets its own viewport at the true position; measured on the rendered PDF at 2.4999 / 5.9999in.

**Defect 2 — binding clearance.** 0.375in did not match Kim's measured ~1in. **That mismatch was the
signal.** Asked instead of assuming, and the cause was physical: the decks pivot on a **left screw post**,
and the fanned stack occludes ~1.5in of the card beneath. A centred QR's left edge sits at 1.18in — inside
the occluded band. Centred content is geometrically right and ergonomically wrong. New **`bind_left`**
(default 1.5in) reserves the band; QR left edge now **1.872in, 0.372in clear**, verified on all 16 cards.

**★ Durable lesson: when the measured symptom does not match the computed defect, the diagnosis is
incomplete.** Fix 1 was real and shipped, and would not have solved the problem. Flagging the
0.375-vs-1.0 gap in the hand-off is what produced the right second question.

**Kept deliberately separate:** `bind_left` is a fact about the **binding**; `x_offset`/`y_offset` are a
fact about the **printer**. Merging them into one "shift" would hide both causes.

**`make_number_cards.R` — new.** Three decisions, all read out of this project's own files:
- **No binding band** — design_notes: *"Identity + free-text = business-card holders. These you *detach*
  … so a loose holder fits better than a bound stack."*
- **Number beside the QR, not above.** Removing the band alone would not have enlarged the code (the QR is
  sized by its middle band's *height*, not card width — it would have stayed 1.14in). Alongside, it runs
  the full content height: **1.76in square, 2.4× the area.** design_notes calls the number card the
  **graceful-degradation floor** — "the non-negotiable minimum is the number card + the photo" — so it is
  precisely the card that should carry the largest, most robust code.
- **Payload `Number: KWB 1243`**, matching `reader_assembler.R`'s `parse_cards()` with no special case.

**`number_cards_ledger.csv` — new.** Records every issued number and refuses a reissue. A collection number
used twice is unrepairable: two specimens, one key, no way to tell which photograph belongs to which sheet.

**Dependency reduction.** `make_qr_cards.R` no longer needs `gridExtra`, `readr`, `tidyr` or `purrr` —
**base R + `grid` + `qrcode`** only. Forced by the sandbox (no CRAN), but right regardless: fewer Imports
for `vouchr`.

**Two regressions caught by measuring the output, not reading the source.** The narrower zone **broke two
existing deck labels** ("Abundant Flowers", "Scattered Flowers", ~2.0in at 18pt) — auto-shrink added, with
a `safety = 0.96` factor because rendered glyphs ran ~3% wider than `grobWidth` reported. And the
header-width pre-scan opens the device, so an unconditional `grid.newpage()` left a **blank leading page**.
Both found with PyMuPDF against the rendered PDF. *The exit code is not the artifact* (cf. Finding 016).

**Printed and confirmed.** Kim: *"This solved the problem perfectly"* and, on the number cards, *"those
printed perfectly."* **KWB 1243–1252** issued (he asked for "12 to fill just one page"; the sheet holds 10,
and the one-page intent was treated as the binding constraint — confirmed correct).

**Session paused here — Kim is doing the field photography**, which supplies the raw material for the
remaining figures. ★ On resume: fold both makers into `vouchr`; reconcile the documentation with the
upgraded printing; then the production pass.

### 2026-07-03 (cont. 3 — ★ MILESTONE: Chapter 12 "The Field Log" committed — all 12 chapters drafted)
**Chapter 12, "The Field Log," the finale, committed** to `field-log.qmd` (renders clean). Kim: "completes
the story arc well… I really like ending in Sweden." Label = security (settled, automatic); field log = the
genuinely new thing (context we now hold for the first time). Threads: context wants to be *seen* (the day's
collections on the derived **hillshade**); **scale** (slope → region → familiar features); **absence as data**
("a real absence vs an empty space on a map"); the **doors** (canopy **physiognomy**, biome, seasonality +
weather, specimen scan) — "None of these is required. Each is a door"; the **challenge** ("not to hand you a
field log but to ask you for one"); **the circle closes to Linnaeus** ("I began in a small room in Sweden…
The writing table and the cabinet have become a phone and an open map. The habit of mind is the same"), echoing
the Introduction's last line. **Ends on a question** (Kim, voyage tradition): **"What will you make of them?"**
**New figure convention (Kim): "caption as door"** — figures explained only in their caption, stating the
result AND how it was obtained (method-pointer), to motivate the reader to hunt the methodology (canonical: the
canopy physiognomy figure, "from an AI vision query"). Recorded in `design_notes.md` + `chapter_field_log_ideas.md`.

**★ ALL 12 CHAPTERS NOW DRAFTED + COMMITTED** (Intro + 2–12); book renders clean, no narrative stubs left.
**Remaining to finish the book (the technical / production pass):** (1) wire the **live worked examples +
figures** (`site_extract`/`site_hillshade`, `discover_decks` heatmap, `read_photo`, `make_qr_cards` + folder
batch, the Field Log maps incl. the canopy-physiognomy door); (2) the **function-reference Appendix** (still a
stub); (3) a **provisional-label image**; (4) **cover + logo art**; (5) the **document title / name**; (6) a
full read-through; then deploy to kimbridges-documents.

### 2026-07-03 (cont. 2 — Ch. 2/3 reconciled to bag-last; Chapter 11 "On Fragility" committed)
Applied the confirmed **bag-last reconciliation**: Ch. 2 dropped "and bag it"; Ch. 3 now "the plant is set
down and out of your hands," the identity card "will become the specimen's tag," cards laid "close to the
plant," + a tie-then-bag closing line; Ch. 10 "coordinate pair is the whole point" (terminology). Renders
clean. **Chapter 11, "On Fragility," committed** to `on-fragility.qmd` (Kim: "a really, really good chapter…
comes at the right place"; **title settled "On Fragility"**). Answers the "isn't it fragile?" worry: the card
prints the fact **three ways** (a failed scan costs a minute, not a specimen); cheap stacked redundancies
(chimp, 2nd phone, two card sets); the **floor** (number + photo = identity; "never left with nothing"); the
**friction tie** ("fragility and friction… the same thing seen twice"); and **extensibility = a kind of
robustness** (Kim's new idea — special needs like a neighboring-species roll call are met by photographing
several scenes, same act, no new friction). Ideation: `chapter_on_fragility_ideas.md`. **★ Next (now): draft
Chapter 12, "The Field Log," the finale.** Eleven chapters drafted; one remains.

### 2026-07-03 (cont. — Chapter 10 "The Workflow" drafted + committed; field procedure settled)
**Chapter 10, "The Workflow," committed** to `the-workflow.qmd` (renders clean) — the first **user-guide**
chapter, three `##` subsections (Before the field / In the field / At the desk). **Field procedure settled
(Kim's exact sequence, SINGLE identity card):** collect + assess → lay out cards (**identity card first**,
then rotate the decks) → **one photo, close to the plant** (the photo's spot is what the GPS records) →
**chimp** + **optional 2nd photographer** (steps here; reasoning → Ch. 11) → **tie** the identity card to the
specimen → **bag last**. The identity card is one card, **photographed then tied on as the tag**. Before-field:
separate cards + **punch a hole** (ties an ID card / spindles a deck); decks evolve (cards added/retired), not
fixed for years. Desk: folder → batch → **Darwin Core file** + provisional labels + the records as the
**"starting material for the field log"** (not a finished log). Ideation: `chapter_workflow_ideas.md`.
**★ Pending: reconcile Ch. 2 & Ch. 3 to the new BAG-LAST order** (they say bagged-before-recording) — specific
light edits proposed to Kim, apply on confirm. **★ Next: Chapter 11, "How It Holds Up."** Ten chapters drafted
(Intro + 2–10); two remain.

### 2026-07-03 (Chapter 9 "Purpose" drafted + committed)
**Chapter 9, "Purpose," drafted → reacted → committed** to `data-equity.qmd` (renders clean). The ethical
high point, developing the founding **data-equity** motivation banked in `design_notes.md`: a scene of joint
international fieldwork where the host country waits for labels that come "late, or in pieces, or never";
named plainly as **colonial** but with the cause turned to **structure/friction, not malice**; the right
standard (a complete, curation-ready copy stays local before anyone leaves) was blocked by, "of all things,
the labels"; **two levelers** — same capture tech (a phone, "the same in every hand") and same metadata (open
data / Darwin Core, no paywall), which **pays off the "free/keyless" seed** from Ch. 3 & Ch. 6 ("which looked
like a technical preference earlier in the book, was this all along"); the architecture keeps the record local
**by default**, and deck-discovery shares expertise, not just tools; personal close (purpose-found-after-
capability; "a small repayment on a large debt") landing on **sharing-is-completion** → "The rest of this book
is about making it real." **Kim: "came in at the correct level. No blame... a good chapter, not an easy one,
located in the right place. It does set us up for the workflow."** Ideation:
`documentation/background/chapter_purpose_ideas.md` (notes the `data-equity.qmd` filename vs "Purpose" title).
**★ Next: Chapter 10, "The Workflow."** Nine chapters drafted (Intro + 2–9); three remain (Workflow, How It
Holds Up, The Field Log) + the technical pass.

### 2026-07-02 (cont. 18 — session close; clean resume point for the remaining chapters)
Added Kim's **physiognomic forest description** to the Field Log's set of context ideas (read blind from the
canopy raster: height / closure / structure, no species needed — "that description blew me away. Really.").
Title of the finale confirmed: **"The Field Log."** Then a deliberate **session close** (after 9 PM, big day).

**State at close.** The book (`specimen_labels\documentation\`) renders clean at 13 files. **Drafted +
committed:** Introduction + Chapters 2–8, each with a `background/chapter_*_ideas.md` ideation file.
**Structure settled** to the finale (12 chapters + appendix): Intro · Field-Capture System · Mechanisms & the
Integrator · Capture Once · The Decks · Derive, Don't Card · Discovering the Decks · Closing the Loop ·
**Purpose** · **The Workflow** · **How It Holds Up** · **The Field Log** · Appendix. (Last four are stubs.)

**Resume plan (in order), for full alert attention (Kim):**
1. **Ch. 9 Purpose** (data equity) — motivation already banked in `design_notes.md`.
2. **Ch. 10 The Workflow** — print decks (`make_qr_cards`) → field routine → photos-in-a-folder → batch →
   Darwin Core file + optional provisional labels (the runnable user-guide portion).
3. **Ch. 11 How It Holds Up** (fragility) — read the printed text; two photographers; chimp it; carry two
   sets; friction tie (fewer things watched → watched better).
4. **Ch. 12 The Field Log** (finale challenge) — context made visual; the ideas in `design_notes.md`.
**Then a technical pass:** wire the live worked examples (`site_extract`/`site_hillshade` in Derive;
`discover_decks` heatmap in Discovering; `read_photo` in Closing the Loop; deck-printing + batch in Workflow;
the Field Log visualizations). **Also pending:** a provisional-label image; **cover + logo art**; the
**document title / project name** (still the "vouchr" placeholder — Open Question #1).

### 2026-07-02 (cont. 17 — The Field Log becomes the CLOSING CHALLENGE chapter; the circle closes)
Kim's "big perspective item": the **field log is the elephant in the room**. The label is easy to picture
(all text; we'll show a provisional-label image). The field log is **context — spatial and temporal, hence
visual** — and it's been under-shown. Reframe: the **label is security** (non-negotiable, now automatic); the
**field log is the new thing** ("we literally have data that weren't previously available"). Decision: make
it the **book's finale, a challenge** — *how should a contemporary field botanist build a field log?* — a
digital record kept **adjacent to the specimens** that lets us and **future researchers visualize what was
done**. **Folded the former "Limits and the Frontier" into it** (it *is* the frontier; honest limits already
spoken where they arise). **The circle closes:** the Intro opens on the field log going *missing*; the book
ends on it *reborn* as the frontier. Ideas banked (suggestive, not exhaustive; "start with what we have"):
collections on the **hillshade**; **scale** (local → familiar features); **where you sampled and where you
did NOT** — absence as information ("didn't sample that valley → now I know why the species wasn't found");
**specimen scans at pressing** (visual record + dropped-tag redundancy); **biome** (whittakerr);
**seasonality cues + past-year weather** (seasonalityr); collection ordered in time. It's where the ecosystem
converges (site_extract / whittakerr / seasonalityr) — the most visual chapter. **Structure wired:**
`field-log.qmd` created (rich brief), `limits.qmd` dropped from the book list, `_quarto.yml` reordered, renders
clean (13 files). Tail: Purpose · The Workflow · How It Holds Up · **The Field Log** · Appendix. Vision in
`design_notes.md`. **★ Open: title for the finale; whether to draft it now (fresh) or continue in order with
Ch. 9 "Purpose."**

### 2026-07-02 (cont. 16 — Chapter 8 committed; label reframed as DATA; two new chapters added)
**Chapter 8, "Closing the Loop," committed** to `closing-the-loop.qmd` (Kim: "a strong chapter") — the whole
system on one real photograph (decode-union → EXIF → derive → one record → label + log). Two structural
decisions from Kim this session:
**(1) The label is DATA first (accuracy fix).** Established herbaria print their own labels on archival paper;
what they want is the **Darwin Core data file**, not a printed label. So the label projection is the
specimen's **Darwin Core record**; a **provisional printed label** is the fallback for those who can't print
their own (a regional school / under-resourced herbarium — the **equity** theme in the plumbing). Makes both
products symmetric (two DwC data views) and closes a loop (the schema we *mine* in Ch. 7 is the schema we
*emit*). Applied as a light touch to **Ch. 4 and Ch. 8**; full treatment goes in the Workflow chapter.
**(2) Two new chapters.** **"The Workflow"** (after Purpose): the practical adopt-it arc — print decks →
field routine → photos-into-a-folder → batch → Darwin Core file + optional provisional labels (the
user-guide/runnable-code portion). **A short fragility chapter** near the end (working title **"How It Holds
Up"**): answers the "isn't it fragile?" worry — card won't scan → read the printed text; two photographers =
redundancy; **chimp it**; carry two card sets; tied back to friction (fewer things watched → watched better).
Absorbs the parked multi-phone redundancy note; the graceful-degradation beat was moved out of Ch. 8 into it.
**Revised order (11 ch + appendix):** … 8 Closing the Loop · 9 Purpose · 10 The Workflow · 11 How It Holds Up
· 12 Limits & the Frontier · Appendix (fragility-vs-Limits order to confirm). Stubs + `_quarto.yml` updated,
book renders clean (13 files). Ideation: `chapter_closing_the_loop_ideas.md`; decisions in `design_notes.md`.
**Kim has "one other big perspective item" coming.** ★ Next: that item, then Chapter 9 "Purpose."

### 2026-07-02 (cont. 15 — Chapter 7 "Discovering the Decks" committed; the real deliverable)
**Chapter 7, "Discovering the Decks," drafted → reacted ("good flow") → committed** to
`discovering-decks.qmd` (renders clean). The methodology chapter: the decks a field needs are "already
written in that field's own record"; the crowd-source insight (millions of small expert choices, digitized,
readable); **Kim's Andes-binoculars first-person anchor** (the world's **best-known** ornithologists;
looking through each expert's glass = reading which observations each expert chose); the plain procedure
(pull → consolidate collectors → field-signature → cluster); clusters = discipline decks, universal gaps =
cross-cutting; worked example **Metrosideros → four archetypes** + phenology the universal gap; **validated
on kudzu** (different archetypes → "it hands back your community's answer"); path-not-destination payoff
("deck design... a matter of measurement"). Closes holding both halves → Ch. 8. **Reader signal (Kim): "the
reader will want to know how to do it"** — to be satisfied by the live worked examples (`discover_decks`
heatmap here; `read_photo` next), the installable package, and the function-reference appendix. Ideation
file: `documentation/background/chapter_discovering_decks_ideas.md`. **★ Next: Chapter 8, "Closing the Loop"**
(the whole system on one real photo; Kim: "ties a lot of things together"). Seven chapters drafted (Intro +
2–7).

### 2026-07-02 (cont. 14 — Chapter 6 "Derive, Don't Card" committed; "coordinate pair" adopted document-wide)
**Chapter 6, "Derive, Don't Card," drafted → reacted ("reads very smoothly") → committed** to `derive.qmd`
(renders clean). The fixed half of the record recovered from the coordinate pair alone: a Kīlauea ʻōhiʻa
example (elevation/slope/aspect/roughness/drainage/place/rock/soil, none field-noted); why it's legitimate
(public surveyed facts; the old kit was "a portable and worse copy"); the attention-friction payoff;
**★ the honesty pair** — scale + source ("a derived value without its scale and source is a rumor") and the
**canopy ceiling** ("carry its limits as plainly as its number"), with the verification note (control +
known site); and **works-backwards** legacy enrichment ("pays the old ones forward"). Closes to Ch. 7: "which
decks... already written in the record." Carries a **live-worked-example placeholder** (`site_extract` +
`site_hillshade` on the Kīlauea coordinate pair) to wire in a technical pass. **Terminology decision (Kim),
document-wide:** use **"coordinate pair"** (varied with "coordinates"/"the pair"), not singular "coordinate";
**swept across `mechanics.qmd`, `capture-once.qmd`, `decks.qmd`, `derive.qmd`** and noted for future chapters.
Ideation file: `documentation/background/chapter_derive_ideas.md`. **★ Next: Chapter 7, "Discovering the
Decks"** (the methodology — the real deliverable; live example = `discover_decks` heatmap). Six chapters
drafted (Intro + 2–6).

### 2026-07-02 (cont. 13 — Chapter 5 "The Decks" drafted + committed; built as a story of discovery)
**Chapter 5, "The Decks," drafted → reacted → committed** to `decks.qmd` (renders clean). The creative heart,
written around Kim's standing principle **set a path, don't hand the destination** (his reminder this
session). Threads: a deck is a question and its cards the allowed answers; **the filter** (a field earns a
deck only if observed AND categorical AND decided-in-the-field — walks the examples so the reader learns to
decide, not to copy a list); the **three families** (identity / observation / comment-card escape hatch); a
deck = **facet (travels) + value-set (local)** — "you inherit the questions, you write the answers for where
you work"; **physical handling** (screw-post stacks, color covers, one-card-at-a-time affordance enforces
mutual exclusivity; vest pocket); **why a deck beats memory** (the checklist under fatigue; recognition over
recall). Closes path-not-destination: "I haven't given you the decks... on purpose," planting Ch. 7 (find
your own from the record) and handing to Ch. 6 ("That half we don't card. We derive it"). Kim: "Just exactly
right. It's a story of discovery." Ideation file: `documentation/background/chapter_decks_ideas.md`. **★ Next:
Chapter 6, "Derive, Don't Card"** — will carry a **live worked example against `library(vouchr)`** (coordinate
→ gt table of derived values + hillshade figure), wired in RStudio in a technical pass. Five chapters drafted
(Intro + 2–5).

### 2026-07-02 (cont. 12 — Chapter 4 drafted + committed; the architectural heart)
**Chapter 4, "Capture Once, Project Two Views," drafted → reacted → committed** to `capture-once.qmd`
(renders clean). Opens on the **return state** (Kim's note): two matched collections home from the field —
**collected specimens, each tagged**, and **photographs, one per tag**, joined by the number. The reading
waits for the desk ("dry, warm, and unhurried... because the photograph kept everything"). One photo →
decode + EXIF + derive → **one record** = the single source of truth; the **label** and the **log row** are
two projections of it. **The honesty payoff** (Kim liked it): two views of one record "can never disagree,"
retiring the copy-drift of the old separate-label-and-log world — "Two views, one truth." Closes on "capture
once, project two views... The record is built. Now we furnish it." **Accuracy fix (Kim):** at return it's a
**collected** specimen, not "pressed" (pressing comes later) — corrected in Ch. 4 **and** back-applied to
Ch. 2. Banked two Kim notes in `design_notes.md`: the return-state inventory, and **cheap redundant capture**
(several people photograph the cards on different phones = a clean backup; flagged for the graceful-
degradation / Limits material, "not Ch. 4"). Chapter ideation file:
`documentation/background/chapter_capture_once_ideas.md`. **★ Next: Chapter 5, "The Decks"** (the creative
heart). Four chapters now drafted (Intro + 2–4); rich `design_notes.md` material ready for Ch. 5.

### 2026-07-02 (cont. 11 — Chapter 3 drafted + committed; a key simplification: photograph the CARDS, not the specimen)
**Chapter 3, "The Mechanisms, and the Integrator," drafted → reacted → committed** to `mechanics.qmd`
(renders clean). It hands the integrator job from the collector to the phone: the photograph is the record,
GPS + clock stamp place/time for free, the fixed-by variables are looked up later from the coordinate (derive
kept light; Ch. 6 opens it), and the **QR code is finally revealed** — reframed as "a way of printing text a
camera reads back," not a link you scan (naive scan shows "Life Form: Tree"). Closes on "the integrator was
you; now it's the phone." Two Kim reactions applied: (1) "You photograph **it**" risked reading as "the
plant" → "**Not the plant, the choice itself**"; (2) **★ the big one — you don't photograph the specimen at
all.** The plant is already **bagged**; you photograph a set of **cards laid flat and well lit**, one bearing
the **collection number**, which is the **stand-in** for the specimen (the Ch. 2 ID-tag thread). Removes
framing friction ("nothing wet, drippy, sticky, pokey"), improves decode reliability, and matches what we
actually tested (cards on a table, no plant). **This corrected the project spine one-liner** — fixed in
`design_notes.md` (+ a full refinement note), `proj_specimen_labels.md` (Objective), and this index's Active
Focus; the older "photograph the specimen *with* cards" phrasing is superseded. Chapter ideation file:
`documentation/background/chapter_mechanisms_ideas.md`. Two demo figures flagged (single card; a card set) as
placeholders. **★ Next: Chapter 4, "Capture Once, Project Two Views."**

### 2026-07-02 (cont. 10 — joint authorship set; Chapter 2 drafted, committed, rendering)
Settled **authorship: joint** — `_quarto.yml` byline now "K. W. Bridges" and "Claude (Anthropic)".
**Chapter 2, "The Field-Capture System," drafted → reacted → committed** to `field-capture-system.qmd`
(book re-renders clean, 11/11). It makes the Introduction's friction thesis lived and concrete (the personal
register pays off here) and turns it into the book's constructive question. Kim's reaction edits, all applied:
capture yields **three things not two** — the **specimen, the label, the log** — bound by the specimen's
**ID tag** (the linking key, planted early for Ch. 4/5); deleted the "plant wilting in your other hand"
(the plant is already bagged before recording); the app has **"built-in categories"** (previews our decks).
Kept "**the integrator was you**" (Kim: "places the responsibility exactly where it should land"; it's the
plant for Ch. 3's phone-as-integrator) and stated the **"fixed by where you stand / judged from what you
see"** division here (Kim: doesn't spoil Ch. 6). Chapter ideation file created + updated:
`documentation/background/chapter_field_capture_system_ideas.md` (threads, verbatim formulations, decisions).
**★ Next: Chapter 3, "The Mechanisms, and the Integrator"** (phone takes over integration; the QR code
finally steps forward). Placeholders still open: title/name, cover + logo art.

### 2026-07-02 (cont. 9 — Quarto scaffold built + the Introduction drafted and rendering)
Set up the book scaffold at **`Projects\specimen_labels\documentation\`** (seasonality pattern, per
`style_multichapter_doc.md`): `_quarto.yml` (book type, code-fold, silent execute; cover/logo commented
pending assets), the 10-part chapter list as stubs (each an H1 + a one-line scope note = the working
outline), plus a **function-reference `appendix.qmd`** (expected for a package-documenting book). **The
Introduction is drafted and committed as `index.qmd`** — the approved first-person opening (Linnaeus' room,
the caught breath, "how do you properly respect what was done here?", tradition → identification-vs-indicator
→ lost log → friction → system thesis), with the **Linnaeus photo** placed as a captioned figure (honest
caption: furniture thought his, arrangement unknown). Copied `Linnaeus_office.jpg` → `documentation/images/`.
**Whole book renders clean** (`quarto::quarto_render`, 11/11 files, `_output/index.html`). Voice held to
`kim_association_index.md` (no em dashes; contractions; concrete-before-abstract; balanced closers) — Kim's
verdict on the Introduction: *"very happy… the right way to begin… it IS the whale story."* Personal-anchor
principle banked: the first-person register set at the open **echoes** at the friction points later (design
notes). **★ Next: draft Chapter 2, "The Field-Capture System."** Open placeholders: the **document title /
project name** (still deferred — `_quarto.yml` uses working title "vouchr" + a placeholder subtitle); the
**cover + logo art**; author line (currently "K. W. Bridges" — revisit joint authorship). Detail in
`design_notes.md`.

### 2026-07-02 (cont. 8 — the document's framing found: system thinking is the key; the deep-tradition opening)
First working session on the **package-then-describe document**. No prose yet — a framing conversation that
substantially *reframed the whole exercise*. All detail written into `design_notes.md` (two new sections +
an opening-decision note). The moves:

**The thesis — the solution isn't technology, it's a system.** The introduction shares **two problems bound
by one thread, friction**: the **lost field log** (the mechanism-level failure) and **data inequity** (the
stakes). Sharper correction (Kim): **QR isn't even the "key" — it's just a good mechanism; the key is
*system thinking*.** So the document is, underneath, a worked demonstration of system thinking with specimen
labels as the vehicle; every pillar is the same systems move (capture-once = one source of truth; derive =
don't capture what you can compute; discover = let the data reveal structure; redundancy = graceful
degradation). **QR is pushed *out of the introduction*, revealed much later where the decks create a need
for it** (resolves the old "QR must open the document" note — the why-QR demos move with it).

**The mechanisms are a SET, each matched to a friction; the cell phone is the INTEGRATOR (Kim).** Camera →
the friction of making a record at all; GPS → georeferencing; QR → transcription; **API/open data** →
attention + equipment friction (fixed variables derived, not observed/carried) *and* the equity lever (open
+ keyless = same metadata for all); **phone** → reconciliation friction (camera+GPS+clock fire in one act →
one record). The **1970s field kit = the *disintegrated* "before"** (altimeter/clinometer/compass/map,
human as hand-integrator); the phone collapses it to one act. Banked Kim's **write-in-the-rain-notebook**
anecdote (broken pencils, knife, illegible hand-held writing — the camera retires the whole cluster) and an
**"alternatives fall short"** passage (dictation, drop-down apps each fix a *point*, not the *span* — the
systems argument against every single-tool fix).

**The deep tradition + the expanding role (Kim) — and the opening decision.** The document **opens on the
historical record**: collecting/pressing/labeling traces to the **origins of botanical science, one of the
first sciences**, crowd-sourced for centuries; a record made now may **outlive us by hundreds of years and
answer questions we can't imagine** (old sheets already mined for DNA, phenology, pollution, climate — so
capture context richly now). The engine of the argument: the **identification → indicator** arc — early
labels were sparse because *naming* was the job (plants as medicine/food/materials); now plants are
**indicators** (climate + more), and an indicator's value lives in its **context** — so the **lost field
notebook is a *recent* problem, created by the expanded role**, not a timeless complaint. Kim's epistemic
line: **the voucher label is where data first land; the field notes are the context** — which is *why* the
two products are co-equal (label anchors, notes interpret). **Opening image = Kim's own photo of Linnaeus'
summer-home office** (writing table + herbarium case, "the tools of his day") — also a quiet thesis plant:
**Linnaeus' revolution was a *system* (binomial naming), not a technology.**

**Working skeleton (10 parts) set:** 1 Introduction (tradition + friction + system-thinking thesis) · 2 The
field-capture system (two products; friction concrete; → decks) · 3 The mechanisms + integrator (QR
revealed here) · 4 Capture once, project two views · 5 The decks · 6 Derive, don't card · 7 Discovering the
decks · 8 Closing the loop (reader/assembler) · 9 Purpose / data equity · 10 Limits & frontier. **★ NEXT
(on resume): draft the Introduction prose** for Kim to react to. **Flagged for draft-time verification:**
herbarium history (Ghini ~1540s, Linnaeus), concrete "unimagined use" cases; and **locate the Linnaeus
photo file** for the figure manifest.

### 2026-07-02 (cont. 7 — `vouchr` pushed to GitHub)
Created and pushed the repo: **https://github.com/kimbridges/vouchr** (public, `main`, issues enabled),
via `gert` + `gh` using the gitcreds `kimbridges` PAT (the same credential Kim's other packages use). One
clean commit of all 37 files (sources, roxygen `man/`, generated NAMESPACE, tests, README, LICENSE).
Installable now with `remotes::install_github("kimbridges/vouchr")`. **The `vouchr` package thread is
complete.** **★ Next: the single package-then-describe document** (the whittakerr/seasonalityr pattern),
with the lost-field-log + data-equity story as the spine. Other pending unchanged: re-add map figures,
why-QR demos, card-value refinement, legacy-enrichment batch #20.

### 2026-07-02 (cont. 6 — the roxygen docs pass + a full review pass: `vouchr` now R CMD check-clean)
Did the focused docs pass cont. 5 set up, folding in a **weakness-review pass** Kim asked for first. Review
(read every module + metadata) surfaced, in priority order: no man pages + **`testthat` missing from
DESCRIPTION**; vestigial `exists()` guards in `assemble_record` (always true inside a namespace); a very
**heavy all-required dependency chain**; `.flowdir_compass` **errors on flat/sink cells** (code 0/NA →
subscript out of bounds); `make_log_row` produces **ragged, name-mangled rows** that won't stack; the
**deck-discovery core had zero tests**; and a stub README + stale "specimen-labels" User-Agent. No hardcoded
secrets — the old Google key is properly externalized to `GGMAP_GOOGLE_API_KEY` (the 2020-prototype worry is
resolved in the package).

**Kim's two calls this pass:** (1) log stays **wide** — keep one column per observed field, preserve names
verbatim (`check.names = FALSE`), document combining a trip with `dplyr::bind_rows()`; (2) **slim the
install** — only the card-making deps (`qrcode`, `grid`, `gridExtra`, `readr`, `tidyr`, `purrr`) stay in
`Imports`; the Derive/Discover/photo stack (terra, elevatr, sf, geosphere, httr, jsonlite, reticulate,
exiftoolr, soilDB, rgbif, ggplot2, scales, dplyr) moved to **`Suggests`**, each function `requireNamespace`-
guarding its deps at call time and calling `rgbif::`/`ggplot2::` qualified.

**Done + verified live in RStudio (ClaudeR):** roxygen on **all 21 exported functions** + a package-level
`R/vouchr-package.R`; **`.flowdir_compass` returns `NA`** on flat/sink; `site_geology` no longer emits `Inf`
for missing ages; `exists()` guards removed; README rewritten to a real front page; Nominatim User-Agent →
`vouchr` + contact; `URL`/`BugReports` = `github.com/kimbridges/vouchr`; `.Rbuildignore` added;
`Config/testthat/edition: 3`. **Tests expanded** (deck-discovery on an in-memory fixture, no network;
`make_qr_cards` writes a real PDF; log-row schema; collector-code identity fallback) — **all pass**.
**GOTCHA confirmed (cont. 5's warning):** `roxygenise()` would NOT overwrite the hand-written NAMESPACE
(roxygen refuses one lacking its "generated by" header) — the fix, *after* tags existed, was to delete
NAMESPACE and re-run; it regenerated cleanly (21 exports, imports limited to the required packages) plus
**22 man pages**. **`devtools::check()` → 0 errors / 0 warnings / 1 note**, and the lone note is
environmental (can't reach a time server to verify the clock). **★ Remaining:** create the GitHub repo
`kimbridges/vouchr` + push (seasonalityr pattern), then the single **package-then-describe** document. Other
pending unchanged: re-add map figures, why-QR demos, card-value refinement, legacy-enrichment batch (#20).

### 2026-07-02 (cont. 5 — second pass: `vouchr` functionally clean + tested)
Cleaned the package. **Import/usage audit** (`codetools::checkUsagePackage`): **no missing imports** — the only
flags were NSE column names (`uncount` `copies`; ggplot aes `feature/lab/frac/txt`), silenced with `R/globals.R`
(`utils::globalVariables(...)`). Folded all **non-ASCII -> ASCII** in the package R sources (**0 remaining**; the
pretty UTF-8 originals in `specimen_labels/` are untouched). Added a proper **MIT `LICENSE.md`**. Added
**`tests/`** (testthat: `parse_cards`, `deg_to_compass`, `first_collector`, `read_capture` no-derive) — **all
pass**. `pkgload::load_all()` clean. So `vouchr` is **functionally clean, tested, loadable**. **Remaining for a
full R CMD check-clean (a focused docs pass): roxygen doc comments -> man pages** for the exported functions (the
one outstanding check WARNING). **GOTCHA:** do NOT run `roxygen2::roxygenise()` until `@export`/doc tags are added
to every function — it would overwrite the hand-written NAMESPACE. Then GitHub (seasonalityr pattern), then the
document.

### 2026-07-02 (cont. 4 — first-pass R package `vouchr` built + loads)
Packaged the toolset (Kim's calls: package name **`vouchr`**; all deps **required**). Scaffolded
`G:\My Drive\Projects\vouchr\` via his R session: **DESCRIPTION** (Imports: terra, elevatr, sf, geosphere, httr,
jsonlite, reticulate, exiftoolr, soilDB, qrcode, grid, gridExtra, readr, tidyr, purrr, ggplot2, scales, rgbif,
dplyr; SystemRequirements: exiftool + Python opencv-python/pyzbar via reticulate), **NAMESPACE** (public exports +
imports of the unqualified-use packages), **LICENSE**, **README.md**, and **`R/`** = the four modules
(`site_extract`, `deck_discovery`, `make_qr_cards`, `reader_assembler`) with top-level `library()` calls stripped.
**`pkgload::load_all()` succeeds** and the core logic runs under the namespace (`read_capture()` → a label).
First-pass package is **loadable**. Remaining (second pass): roxygen doc comments → man pages; exercise the
network functions under the package to confirm every NAMESPACE import; a few tests; fill the LICENSE text; then
GitHub (the seasonalityr pattern). **Name:** `vouchr` is the package name; the proj file / project can adopt it
when Kim decides (project name was otherwise deferred).

### 2026-07-02 (cont. 3 — the founding motivation captured: data equity / decolonizing field collaboration)
Kim shared the project's **founding purpose**, for an appendix (and likely the opening). In joint international
fieldwork, a complete copy of primary data — **including labeled voucher specimens** — should stay in the **host
country**, curation-ready. The "*I'll send the labels once I've transcribed them at home*" habit is inadequate and
wrong; the alternative (stay in-country until labels are done) is expensive. Kim named the pattern plainly: such
studies have often been **colonial**, a **power + technology mismatch** between local hosts and foreign visitors —
and *seeing this was the original idea for the project*, a wish to **level the playing field**. The levelers: now
everyone has the **same capture tech (a phone)** and, via **open-access data** (GBIF/Darwin Core + our free/keyless
derive stack), the **same metadata**. So our deliberate avoidance of paid APIs is the **equity commitment in
technical form**. The architecture operationalizes it: **label + log made on-site, before leaving → complete data
stays local by default**; and deck-discovery lets a local team derive *its own* decks (expertise shared, not just
tools). A "purpose-found-after-capability" moment — *a small payback to his overseas collaborators*. Full text in
`design_notes.md` (motivation/appendix).

### 2026-07-02 (cont. 2 — urban reverse-geocode fixed; decoder decision settled)
Kim caught reverse-geocode errors (wrong `city` "East Honolulu"; ZIP 96850). Diagnosis: OSM's `city` + postcode
are **erratic in dense urban areas** (ZIP even zoom-dependent — wrong at 14, correct 96813 at 16); neighbourhood/
suburb, county, state, country are reliable. **Fixed `site_place()`**: query zoom 16, compose the locality from
the reliable levels only (skip `city` + postcode). Verified: photo → "Hawaii Capital Historic District, Honolulu
County, Hawaii, United States" (correct); Kīlauea → "Hawaiʻi County, Hawaii" (graceful rural fallback); Georgia →
"Jackson County, Georgia." Principle reaffirmed: **coordinates are the authoritative locality**, the name is
convenience — so an imperfect urban admin label is cosmetic, not integrity. **Decoder decision SETTLED:** Kim
confirmed ZBar isn't on CRAN → keep **reticulate + pyzbar (+ OpenCV, unioned)** as the packaging choice for
decode (exiftool already a system exe; all else R). See `design_notes.md`.

### 2026-07-02 (cont. — free reverse-geocode for `place`; card-format + decode-engine decisions)
Filled the `place` gap Kim noted: wired **`site_place()`** (OSM Nominatim — **free, keyless**) into the reader;
the test photo now yields *"Locality: Kaka‘ako, East Honolulu, Honolulu County, Hawaii"* — **no paid Google API**
(consistent with the free derive stack; Nominatim ~1 req/s → batch/cache for bulk / legacy enrichment). **Decision
(Kim): identity card gets a `Number:` header** so all cards share the self-describing `Field: value` format
(reader keeps a legacy fallback for old `KWB:` tags). **Decode-engine note:** R has no native QR decoder; the
current union of pyzbar + OpenCV via reticulate got 4/4 (each alone ~1); the alternative is the `zbarimg` CLI via
`system2()` (R-native but needs ZBar installed) — a packaging trade-off to settle. Fun: the photo was taken on
Kim's 39th floor — the 2 m elevation is the *ground* coordinate (GPS gives position, not altitude), an edge-case
reminder that the derive assumes on-the-ground collection. See `design_notes.md`.

### 2026-07-02 (reader/assembler LAST MILE wired + field-tested on a real photo — full loop demonstrated)
Kim supplied a real phone photo (`photos/PXL_20260702_052036838.jpg`) of four prototype cards on a table. Wired
both input adapters and ran the whole pipeline. **`read_exif()`** (exiftoolr → GPS 21.3022, −157.8573 + datetime)
works cleanly. **`decode_qr()`** (reticulate): real photos (rotated codes, busy wood-grain) defeat any *single*
decoder — cv2 got 1/4, pyzbar 1/4, pyzbar+preprocessing 3/4; the **UNION** of pyzbar (grayscale/Otsu/adaptive/
upscale) + OpenCV's multi-detector got **all 4**. Installed `opencv-python` + `pyzbar` into the r-reticulate venv.
Taught the assembler the **`KWB: 1239` identity-tag** format (→ number "KWB 1239", collector "KWB"). Ran
`read_photo()` end-to-end: **photo → decode (4 cards) + EXIF → derive → a herbarium LABEL + a field-LOG row,
fully automatic, no transcription** (derived elevation 2 m / slope 1° / aspect S; Honolulu Volcanics basalt /
Inceptisols). **The entire system now runs end-to-end from a real photograph — the loop is closed and
demonstrated.** Task #22 complete. Decode lesson: pool multiple decoders + preprocessings, don't rely on one;
graceful-degradation floor (cards read to the eye) held. Remaining polish: reverse-geocode a place name; package
the decode-union as a helper. Next: packaging.

### 2026-07-01 (cont. 7 — reader/assembler core BUILT + verified: the loop is closed)
Built **`reader_assembler.R`** — the second half of "capture once, project two views." `parse_cards()`
(self-describing "Field: value", identity cards included), `assemble_record()` (cards + coordinate + time → ONE
record, pulling the *fixed* variables from the coordinate via `site_extract` + `site_substrate`), and two
projectors `make_label()` (per-specimen herbarium label) + `make_log_row()` (per-trip log row), with a
`read_capture()` convenience. **Verified live:** 5 synthetic Kīlauea ʻōhiʻa cards + coordinate →️ a complete
label (collector/no.; locality; coords; **derived** elevation 1344 m / slope 4° / aspect E; **derived** substrate
basalt + **Andisols**; observed Life Form: Tree / Phenology: Flowering / Flower Color: Red; date) AND a matching
field-log row — both projected from the one record (cannot disagree). The collector's cards supplied only the
observation fields; all spatial context came from the coordinate — the derive-vs-observe split, operational.
**The system is now assembled end-to-end** (Capture → Derive → assemble → two products). **Stubbed (last mile):**
input adapters `decode_qr()` (ZBar) + `read_exif()` (exiftool) — pending a real field photo + those tools. Per the
plan (assemble first, document after), we are at "system assembled." Task #21 core complete.

### 2026-07-01 (cont. 6 — big-picture step-back: decisions + start the reader/assembler)
Stepped back. **Project identity:** has outgrown "specimen_labels" — it is a rethinking of *field-data capture
around the friction thesis*, with three built pillars (**Capture** = QR decks; **Derive** = `site_extract`
terrain/canopy/geology/soil; **Discover** = `deck_discovery`) and one missing keystone, the **reader/assembler**.
**Kim's decisions:** (1) **name deferred** (but "specimen_labels" is wrong); (2) **deliverable = package-then-
describe** (the whittakerr/seasonalityr pattern — enough complex code that a package makes the approach usable),
kept as a **single, complex document**; (3) **priority = close the loop by building the reader/assembler** —
documentation comes *after* the whole system is assembled (the running notes suffice to write it). Also banked a
cognitive aside for the document: **choose-from-a-list beats think-it-up** (recognition over recall) — a second
reason decks work, beyond the checklist argument. **Now building the reader/assembler.**

### 2026-07-01 (cont. 5 — substrate derive BUILT into site_extract; then stepping back to the big picture)
Wired the substrate derive into `site_extract.R`: **`site_geology()`** (Macrostrat bedrock), **`site_soil()`**
(SSURGO in US / SoilGrids global fallback; `source="auto"`), and **`site_substrate()`** (both, with label-ready
sentences). Kept standalone (not inside `site_extract()`'s main call) since the services are slower/optional; all
keyless. Verified live: Kīlauea → "lava flows; basalt … Kau Basalt; 0–2.6 Ma / **Andisols** – Haa [SSURGO]";
Koko → "vent deposits; basaltic … Honolulu Volcanics; 0.01–0.13 Ma / **Entisols** – Rock land [SSURGO]" — both
correct + label-ready. **Task #19 complete.** Next: a big-picture step-back (what the project has become; the
missing reader/assembler; deliverable shape; the name).

### 2026-07-01 (cont. 4 — substrate-derive sources validated: Macrostrat bedrock + SSURGO/SoilGrids soil)
Explored the geology/soil derive (how developed the databases are), tested at Kīlauea / Georgia / Koko.
**Bedrock — Macrostrat** (global, keyless, fast): correct + region-appropriate — Kīlauea *Kau Basalt/lava flows*,
Georgia *gneiss/schist/amphibolite* (Piedmont). **Soil — SSURGO** (USDA, US, via `soilDB` SDA): sharp + robust,
and it **corrected SoilGrids** — Kīlauea = **Andisols** (SoilGrids had guessed Cambisols), Georgia = Gwinnett clay
loam / **Ultisols** ("eroded" — the disturbed land kudzu invades), Koko = Rock land / **Entisols**. **SoilGrids**
(global 250 m ML, REST) works but slow / rate-limited / 503-prone / coarse on young volcanic — global fallback
only. Principle (mirrors 3DEP-over-Google): detailed regional source (SSURGO) inside coverage, global fallback
(Macrostrat/SoilGrids) elsewhere; substrate is fully derivable. Reliability lesson: batch/cache, don't hit live
REST per specimen. **Also logged (Kim): retroactive enhancement of legacy collections** — the same derive applies
to any coordinate-bearing specimen, so the georeferenced backlog can be batch-enriched (task #20). Remaining for
task #19: wire `site_geology()` + `site_soil()` into `site_extract`. Full write-up in `design_notes.md`.

### 2026-07-01 (cont. 3 — two-taxa stress test; concrete deck files; "discovering decks" complete for now)
Sharpened the content split (broad `morphology` flag → **`tax_content`** = floral/indument/variety/measurement vs
**`eco_content`** = community/cover/moisture/disturbance); the disciplines then separate cleanly (taxonomic ②
distinguished by *determination*, ecological ③ by *eco_content*). Wrote **concrete deck files** in the
`make_qr_cards.R` format — `decks/deck_universal.csv` (Phenology + Habitat, cross-cutting), `deck_taxonomist.csv`
(Life Form / Flower Color / Indument / Size Class), `deck_ecologist.csv` (Substrate / Cover / Moisture /
Disturbance / Associated-spp) — and rendered `deck_taxonomist_proof.pdf` as the documentation example. **Key
division of labour:** the data chose the *categories* (facets); the card *values* are starter drafts, Kim's to
refine (the creative heart).

**Two-taxa stress test (Metrosideros + kudzu on one trip — does the ecologist deck hold?).** Its **facets
generalize** (Cover/Moisture/Disturbance/Associated-spp describe the *site*, species-agnostic → the deck is
collection-spanning), but its **value-sets are local**: lava-substrate terms 4% *Metrosideros* / **0% kudzu**
(Hawaii-specific values fail on the mainland), roadside/disturbed terms 2% / **25%** (kudzu wants
roadside/old-field). So a deck has **two layers — facet (generalizes) + value-set (local)**. Resolution: the
facet whose values break (**substrate**) is exactly the one to **derive** from a geology/soil map, not card —
sharpening the card-vs-derive rule (region-local value-sets → derive). **Reminder queued: build the geology/soil
derive (a `site_extract` extension).** **"Discovering decks" thread complete for now** — method + validation +
concrete decks + stress test done; remaining = value refinement (Kim), kudzu variety signal (widen window),
substrate-derive. Full write-up in `design_notes.md`.

### 2026-07-01 (cont. 2 — method VALIDATED on a second, contrasting taxon: Pueraria montana / kudzu)
Ran `discover_decks()` on kudzu (US PreservedSpecimen 1985–2026, **n = 911**, taxonKey 2977636) as the contrast —
**different archetypes**, which is the proof the deliverable is a *method*, not a *Metrosideros* one-off. Vs
*Metrosideros*: (a) the **taxonomic-describer archetype VANISHES** — `type_status` = 0 for all, `identified_by`
near-zero (a weed isn't sent for determination or typified); (b) a **georeferencing/monitoring signature APPEARS**
(Ebinger / **Mehrhoff** [ran the Invasive Plant Atlas of New England] / Sullivan; `coordinateUncertainty` 80–84%);
(c) **phenology SHIFTS** from universal-zero to recorded by several (Diamond 73%, Mehrhoff 65% — matters for a
management target); records **sparser** overall (fast invasive-weed vouchering). So native taxonomic tree →
describers + ecological place-recorders + machine; invasive weed → fast-vouchers + habitat/phenology ecologists +
coordinate-precise monitoring/conservation. Same method, different community, **different decks**. Caveat: the
variety/species taxonomic interest isn't prominent in this ≥1985/≥10 slice (few specialists; older material /
morphometrics off-label) — surfaceable by widening the window. Both heatmaps saved to `label_survey/`; write-up in
`design_notes.md`. **Method validation complete.** Next: discuss direction (Kim).

### 2026-07-01 (cont. — methodology formalized; two friction anecdotes banked; pausing for lunch)
Formalized the deck-discovery method as **`deck_discovery.R`** — `discover_decks()` runs the whole pipeline in one
call (pull → consolidate `recordedBy` to a primary collector → field-signatures → Ward cluster → per-cluster deck
profiles + a faceted heatmap; accepts a `taxonKey` to pull or a pre-pulled `data=` frame). **Validated:** on the
*Metrosideros* data it reproduces the four archetypes (terse / taxonomic describers / ecological place-recorders /
NEON-machine). Saved a document-ready figure `label_survey/collector_signatures_heatmap.png`. Banked **two friction
anecdotes** in `design_notes.md` for the document: the **161-column voucher spreadsheet** (the same 161 Darwin Core
fields our pull returned — the current system asks the *human to be the database*; the card method *inverts* it)
and the **1970s field kit** (altimeter/clinometer/compass/map = `site_extract()`; adds **equipment/access
friction** — "check the gear out of the stockroom before Friday"). **Next (Kim deciding over the break): a second,
contrasting taxon** to validate the method — one he has ground-truth for, chosen so the archetypes come out
*different* (candidates: a mainland agency/plot-collected genus; another Hawaiian group; a horticultural genus).
Nothing mid-edit; pausing.

### 2026-07-01 (collector-signature decks → the deck-DISCOVERY METHODOLOGY, the real deliverable)
Ran the designated next move. **`rgbif`** full-Darwin-Core pull: US *Metrosideros* PreservedSpecimen 1985–2026,
**n = 1,144** (saved `label_survey/metrosideros_US_1985_2026_fulldwc.csv`). Consolidated 413 raw `recordedBy`
strings → 126 primary collectors; **20 with ≥10 records (74% of data)**. Computed each collector's **field-
signature** (occupancy of habitat/remarks/morphology/substrate/associates/phenology/elevation/determination/
type/number + content flags) and **clustered** (ward.D2; heatmap). **Four archetypes recovered from data alone:**
① **describers/taxonomic** (morphology + determination + type + elevation — Takeuchi, Stemmermann, Stacy,
Johansen, Oppenheimer…); ② **place-recorders/ecological** (habitat + substrate + associates + own numbers,
self-determined — Wood [202], Walsh, Wolkis, Ramp…); ③ **terse** (Dawson — *the Metrosideros monographer, tersest
of all*; Percy [psyllids] logs habitat, no plant morphology); ④ **machine/NEON** (templated 100%, no number, no
phenology). **Phenology near-zero across ALL archetypes → a cross-cutting deck.**

**The reframe (Kim — the key point):** the deliverable is **a methodology for *discovering* what decks are
needed**, not a prescribed deck set. Procedure: scope a Darwin Core pull (taxon/region/recent decades) →
consolidate to primary collector → compute field-signatures → cluster → each cluster's characteristic fields = a
**discipline deck-profile**; cross-cutting gaps = universal decks. General, reusable, self-updating,
*transmissible*; turns deck design from opinion into measurement and legitimizes the vocabularies. Answers the
old "how many decks / what's on each?" question **structurally** (a procedure, not a number). Also banked Kim's
**crowd-source framing** (herbaria = the first crowd-sourced science; the aggregated corpus is what the method
mines; the process's "sameness" is what makes it minable) as document-opening material. Full write-up in
`design_notes.md`. **Next:** formalize the methodology (a small reusable function) + sketch the taxonomist vs
ecologist deck profiles from the clusters.

### 2026-06-30 (cont. 5 — design synthesis: physiognomy + three axes for every variable)
A conceptual step Kim flagged as a **major addition**. Reading the canopy raster *blind* (no species) yields a
**physiognomic description** — the *structural* half of a habitat description (height class, closure/cover,
vertical heterogeneity, gappiness), quantifiable and **derivable from the coordinate** — which directly attacks
the poorly-recorded "habitat" field. Kim's framing named two distinctions we'd been conflating, giving **three
orthogonal axes** that now organize every candidate variable: (1) **derive vs observe**; (2) **per-specimen vs
collection-spanning** *(new)* — variables that describe the whole *site / collecting event* (physiognomy, site
terrain, the expedition narrative) apply to every specimen and live at the field-log level, stamped onto each
label as needed; (3) **label-summary vs field-note-detail** *(new)* — one datum, two renderings at two
granularities (compact token on the label; full detail in the field notes), i.e. "capture once, project two
views" applied to a *derived* variable. Canopy physiognomy is the worked example: derived · collection-spanning ·
label-summary + field-note-detail. The canopy-tree **species** narrative is its observe-side companion
(expedition narrative, part of sampling strategy) — deferred. Full write-up in `design_notes.md`.

### 2026-06-30 (cont. 4 — canopy cross-check: dedicated GEDI layer confirms the ceiling)
Cross-checked the three Kīlauea sites against the **Meta/WRI 1 m GEDI-calibrated canopy map**, streamed
**keyless** from the public AWS bucket via GDAL `/vsicurl` (`dataforgood-fb-data/forests/v1/alsgedi_global_v6_float/`:
`tiles.geojson` → quadkey → `chm/{quadkey}.tif`; no OT key, no extra package — the ETH 10 m host turned out to be
a landing-page app, not a browsable COG store, and `forestdata` isn't on CRAN, so this was the working route).
Result (mean within 45 m): **grassland 0.0 m** (agrees with DSM−DTM 0.6), **ʻōhiʻa edge 4.3 m** (agrees, low-mid),
**Kīpuka Puaulu 15.8 m** — vs the DSM−DTM's saturated **8.0 m**. The 1 m map resolves individual ʻōhiʻa/koa
crowns + gaps. **Ceiling confirmed:** cheap DSM−DTM = a *detector*; the purpose-built GEDI product = the
*measure*. Decision recorded in design_notes: if canopy height ever becomes a derived label field, use the Meta
1 m (or ETH 10 m) GEDI product, which streams keyless from open AWS — fits the derive-from-coordinates model.

### 2026-06-30 (cont. 3 — canopy from coordinates: it works, with a ceiling)
Tested whether canopy height is derivable from a coordinate: **DSM (surface / canopy-top) − DTM (bare earth) =
canopy height**, which extends the derive-vs-observe partition into **vegetation structure** — a *habitat*
descriptor, on the fixed/derivable side (canopy changes slowly → post-processable, attention-sparing, and speaks
to the "habitat" field the *Metrosideros* dump showed is recorded so unevenly). Set up the **OpenTopography key**
(`OPENTOPO_KEY` in `.Renviron`; unlocks elevatr's `alos`/`cop30`/`fabdem` sources).

Method: **ALOS AW3D30 (DSM) − AWS/3DEP (bare earth)**, mean within 45 m, with a **grassland control**. Three
Kīlauea sites (Kim's — local ground truth): **grassland 0.6 m** (control passes → DEM offset negligible, method
sound), **mid-height ʻōhiʻa forest 7.5 m** (matches; CHM map shows the fence-line edge even at 30 m), **Kīpuka
Puaulu, tall mixed ʻōhiʻa–koa, 8.0 m** — **wrong**: that stand is ~20 m; the method **saturates over tall closed
canopy**. So the cheap DSM−DTM difference is a good canopy *detector* (open vs forested, mid-height ok) but not a
tall-canopy *measure* — likely because 30 m ALOS smooths crowns and dense Hawaiian forest has no true lidar
bare-earth (the "DTM" is partly a surface, so the difference collapses). **For a trustworthy canopy value, use a
GEDI-derived product (ETH 10 m / Meta 1 m).** Verification lesson: Kim's ground truth caught the ceiling — the
disagreement *is* the finding; a derived datum must carry its **limits**, not just scale + source. Full write-up
in `design_notes.md`. **Next (offered):** cross-check Kīpuka against a 10 m GEDI canopy layer to confirm the ceiling.

### 2026-06-30 (cont. 2 — DEM source switch (site_extract v2) + a second kind of friction)
Rebuilt the derive engine as **`site_extract.R` v2** after a live DEM head-to-head. **Comparison
findings (Koko Crater; Google 76 m 3×3 vs elevatr AWS/3DEP at 4.5–17.8 m):** elevation and aspect are
**robust** to resolution (~147 m, SSW everywhere); the 2020 3×3 method **overestimated slope** (40° vs a
true ~31° that the finer DEMs converge on); and **roughness/TRI is scale-dependent** (9.7 → 2.2 as cells
shrink) — so it is *not comparable* across cell sizes.

**Redesign.** The **analysis scale is now an explicit parameter in metres**, independent of DEM resolution:
fetch a fine DEM, aggregate to a stated scale (default 30 m) for slope/aspect/flow, and measure roughness as
elevation-SD within a stated radius. Every value carries **source + native resolution + analysis scale** — the
honesty flag generalized. **Source switch:** `source="aws"` default (elevatr AWS terrain tiles — free, no key,
global, auto-fine over the US via 3DEP/lidar) with `source="google"` legacy 3×3 kept as fallback. Bare TRI
dropped in favour of scale-explicit roughness. **Verified live:** Koko 28°@31 m vs legacy 40° (same SSW aspect);
Fuji works globally (3.7 m native, aspect 181° S — matches Kim's own "south-facing" annotation). Added
`site_hillshade()`. Design lesson for the document: *a derived datum must state the scale + source it was
derived at, or it isn't trustworthy.* (v2 dropped v1's two Google static-map figures — **re-adding them is a
separate task**, at Kim's direction.)

**Conceptual addition — a second kind of friction (Kim, 2026-06-30).** Beyond *transcription friction* (the
spine), Kim named **attention friction**: in the field, slope / drainage / roughness / aspect are important but
routinely overlooked in classical notetaking because attention is finite and the collecting moment is crowded —
"so much is going on, you forget." Since these are **fixed** (a spot's elevation/slope/aspect don't change),
consigning them to a **post-processing** derive step loses nothing and **protects scarce field attention for the
ephemeral, observation-only data** (phenology, plant state, associated species). This is the derive-vs-observe
partition seen from the friction side, and it is prime document material. Written up in `design_notes.md`.
**Next:** re-add the map figures (separate task); Kim has "a few interesting things to look at."

### 2026-06-30 (cont. — Site_Extract resurrected: the "derive" engine cleaned + verified live)
Acted on the derive-vs-observe partition by building its **derive half**. Kim confirmed the terrain code lived
in `QR_procedures.Rmd` and pointed to a **`literature\`** folder he added (5 PDFs: baRcodeR, Darwin Core quick
reference, two herbarium-voucher prep guides, a use-of-specimens chapter — queued for the label-content work).

**Extracted + cleaned → `Projects\specimen_labels\site_extract.R`.** The terrain logic was spread across five
prototype chunks with dead code ("THIS IS NOT USED", "Doesn't Like KEY"), a duplicated aspect block, `raster`,
and a **Google API key hardcoded in three places**. Refactored into one function: `raster`→**`terra`**, key read
from **env var**, dead code gone, `cimir` dependency dropped (own compass fn). Math kept **unchanged** so it
reproduces the reference; added `site_contour()` (Fig 3), `site_maps()` (Figs 1–2), and a **`site_report()`**
wrapper so **one call reproduces the whole Site_Extract.pdf**.

**Verified live in RStudio (ClaudeR).** Key was under `GGMAP_GOOGLE_API_KEY` (Elevation API enabled). Koko Crater
reproduced Site_Extract.pdf **exactly** — elevation 147.2 m, slope 40°, aspect 201° SSW, TRI 9.7, mean 147.4,
high/low 162.9/132.1, flow SW, DEM res 76 m — and all four figures regenerated. **Verification earned its keep
twice:** (a) it caught that I'd measured the full 3×3 span (44 m) instead of the point spacing, and confirmed the
**prototype's N-S/E-W label swap** — both fixed (now 22.1 m N-S × 20.8 m E-W); (b) a second site, **Mt Fuji**,
returned aspect **181° (S)**, matching Kim's own "south-facing slope" annotation — independent ground-truth, not
just self-consistency. The DEM-resolution field travels with each result (76 m Koko, 153 m Fuji) — a built-in
honesty flag and the hook for step (b).

**This resolves the terrain-scope open question in practice:** `site_extract.R` *is* the derive engine; its
relation to gePoints/geContour still to settle. **Next (Kim's order):** step **(b)** — swap the DEM source
(USGS 3DEP ~10 m / HI lidar 1 m) so the 22 m grid is genuinely resolved — then the shrunk deck list. See
session_log.md 2026-06-30 (cont.).

### 2026-06-30 (Track B: herbarium-label-field survey — occupancy data + the derive-vs-observe partition)
Ran the **Track B** survey Kim chose from the pending threads: *which label fields do collectors actually fill?*
Findings and data saved to **`Projects\specimen_labels\label_survey\`** (`label_field_survey_notes.md` +
three CSVs).

**The accessible-database find (clears a stumbling point from a few years ago).** All the major herbarium data
sources share one vocabulary — **Darwin Core** — so *what fields exist* is standardized and the corpus is openly
bulk-downloadable. Three tiers: aggregators (**GBIF**, iDigBio, ALA), **Symbiota** consortium portals (SEINet,
SERNEC, bryophyte/lichen portals — herbarium-native, full transcription fields), and institutional catalogues
(Kew, NY, Harvard, Tropicos). The open question is not the schema but **field occupancy**.

**The measurement.** GBIF genus *Metrosideros*, PreservedSpecimen: **18,895 records** (NZ 32% · US/Hawaii 27% ·
New Caledonia · French Polynesia · Pacific). Pulled a country-representative **reconnaissance sample (n=182)**
and computed per-field fill rates. **Spine (>90%):** scientificName/genus/family, collector, date,
catalogNumber, institutionCode. **Middle (40–80%):** coordinates 73%, locality 54%, verbatimLocality 51%,
habitat 48%, elevation ~45%, identifiedBy 47%, collector-number 46%. **Sparse (<25%):** occurrenceRemarks 25%,
**phenology (reproductiveCondition) 3%**; sex/lifeStage ≈ 0%. (Caveat: GBIF interprets dates/coords, so those
overstate the literal label; n=182 is ±~7%. Full-scale rerun = `rgbif::occ_download()`.)

**Design results, in order of importance.**
- **Geography needs no cards.** GPS + reverse-geocoding yields the whole place-name hierarchy; derive it at
  assembly. (Kim's sharpening of the redundancy point: once you have coordinates, Google returns the named
  levels — so *keep* place names on the label but don't *card* them.)
- **Phenology is the corpus-wide gap (3%).** The observation decks add genuinely new structured data rather than
  duplicating what herbaria hold — the strongest argument *for* the decks.
- **`habitat` is a catch-all** (n=87): community ~45%, landform ~39%, substrate/geology ~32%, associated spp
  ~21%, moisture ~15%, disturbance ~11%, **~18% not-habitat noise** (place names, insect notes leaking in), and
  **~24% a jammed `Field: value` template** (NZ herbaria reinventing structure inside a free-text box — evidence
  collectors *want* controlled fields). So habitat **decomposes**: physiographic facets → derive; biotic facets
  (community, associated spp, disturbance) → cards/free-text.

**The big reframe — the derive-vs-observe partition (from Kim's `Site_Extract.pdf`).** Kim added a terrain
extraction he computes from **name + lat/long alone** (Koko Crater): elevation + local relief, **slope 40°**,
**aspect 201° SSW**, **Terrain Roughness Index 9.7**, **drainage direction SW**, DEM footprint, plus location/site
maps and a slope contour. These are the *same* variables collectors hand-scribble into `habitat`/`verbatimElevation`.
So every label field splits in two: **(1) derivable from coordinates + reference layers** — place hierarchy, the
whole physiographic set, geology/soil, climate (the `seasonalityr` engine) → **compute, never card**; **(2) not
derivable, must be observed at the plant** — phenology + phenotype, associated community, disturbance, human
metadata → **the only thing the decks carry**. *Derive everything the landscape already encodes; card only what a
human at the plant must judge.* Corroboration inside Kim's own dump: the **NEON** records auto-populate
`slope aspect / slope gradient / soil type order` — the field is already doing this. This also resolves Open
Question #3 (terrain scope): `Site_Extract` **is** the derive engine.

**Nothing left mid-edit. Active Focus stays specimen_labels (Exploring).** Resume threads: draft the **shrunk
deck list** (observe-only column), locate the **`Site_Extract` code**, the why-QR demos, the reader/assembler,
and the full-scale `rgbif` rerun. See `label_survey\label_field_survey_notes.md` + session_log.md 2026-06-30.

### 2026-06-29 (cont. 3 — session close: physical-handling design, deck-count framing, the "why QR" hurdle)
Closed the day with three more design discussions, all captured in `design_notes.md`. (1) **Physical handling
design** (Kim's, long-wrestled, now resolved): observation decks as **screw-post stacks with color-coded covers**
— rotate one card into view; the affordance *enforces* "one value per field"; color = field identity read before
reading + a friction reducer. Identity + free-text ride in **business-card holders** (you detach a number card /
write a comment). The kit fits a **vest pocket**. Form matches the data semantics, family by family. (2) **How
many observation decks** — reframed via a filter: a field earns a deck only if it is an *observation* AND
*categorical* AND *chosen in the field*. Most label fields fail it (date/lat-long/elevation = auto from the photo;
determination/family = desk; habitat/prose = comment), leaving a small set (~3–6): life form, abundance,
phenology + discipline-dependent maybes. To settle empirically: the **Track B herbarium-label survey** (pending
Kim's call — run it vs. use his references). (3) **The "why QR?" conceptual hurdle** — most people think QR = a
link you scan; we hold *text*, *redundantly*, and *photograph* it (passive batch capture, not interactive scan).
Must be the document's **opening** move, demonstrated (scan-this-get-text; one-photo-many-codes; two-workflow
diagram). Nice vindication: our self-describing encoding makes even a naive phone-scan sensible ("Life Form:
Tree"). **Nothing mid-edit; Active Focus stays specimen_labels (Exploring).** Resume threads: label survey,
why-QR demos, target-species deck, reader/assembler. See `design_notes.md` + session_log.md 2026-06-29.

### 2026-06-29 (cont. 2 — method + design principles: interleave, friction, the three families)
Agreed to **interleave code and writing** for this project (informally), because the design is still being
*discovered* — describing the work is a design instrument here, not just a record (unlike the settled-construct
code-then-docs projects). Started an informal running narrative, **`design_notes.md`**, in the project folder
(thinking-writing tight against code; polished doc lags). Two design commitments captured there. (1) **The friction
trade is the honest center:** we remove a large, delayed, data-losing friction (transcription) but add a small
immediate one (card handling) — so **simplicity is the survival condition**, and the design must hold a
**graceful-degradation floor** (number card + photo secures identity/location/date; category decks are optional
enrichment; the comment card is the fallback). Card risks (dirt, drops, blow-away, fumbling) get situation-
dependent fixes (few decks; ring-bound + tethered; laminated; redundancy covers dirt; one-photo-many-cards).
(2) **Three deck families, agreed:** identity/determination (number, target species), observation (life form,
abundance, phenology), free-text (comment = the universal fallback). Kim's note: target species is a special
*identity* deck where `copies` handles repeat collection. See design_notes.md and session_log.md 2026-06-29.

### 2026-06-29 (cont. — encoding scheme settled; deck-driven maker built)
Second working block on the project. Kim supplied two more files: **`QR_label_maker.qmd`** (his modernized
collector-ID maker — already on the current `qr_code()` API) and **`QR_field_notes.csv`** (a test deck). The CSV
**revealed the encoding scheme he had actually built**: the QR carries the **full self-describing text**
(`Life Form: Tree`), no codebook — which neatly resolves the short-token-vs-codebook debate (the phrases are short
enough to encode in full *and* run high error correction; a codebook is only needed for long values). Named two
design principles worth keeping: **graceful-degradation redundancy** (the card's header+footer+QR are three copies
of one fact, mirroring the photo's printed-number/QR/EXIF layers — data survives partial failure), and the
**comment card** as the open-text escape (a writable, photographed card that waits for transcription) that
completes coverage alongside the closed-vocabulary decks. The starter decks (Life Form, Abundance, Phenology,
Collectors, Determiner) are already standard herbarium fields, so Track A and Track B (design vs survey) meet.
**Built the clean deck-driven maker `make_qr_cards.R`** (three small functions; no temp-PNG litter; `ecl="H"`;
comment cards handled; 2×5 cards/page → multi-page PDF) and ran it live to produce `QR_field_notes_cards.pdf`
(16 cards, 2 pages). Installed `qrcode` 0.3.0 (absent from this R). Fixed the "Occassional" typo. **Next:** precise
Avery-5371 alignment; generalize the ID maker into the same deck format; then the **reader/assembler** side
(scan a photo → decode all cards + EXIF → emit a label and a log row); and a deck-content survey of herbarium
practice. See session_log.md 2026-06-29.

### 2026-06-29 (project opened — concept conversation captured)
New exploration Kim brought the day after the seasonality book shipped. He'd dropped a 2020 prototype
(`QR_procedures.Rmd`) and a demo image into a new `specimen_labels` folder and asked to look at the code and
discuss where to head. The conversation (captured in full in **The spine** above) established: the spine is
**specimen collection**, the enemy is the **label/field-log production delay that loses data**, and the
strategy is **photograph QR cards at the collection site** so one small act captures everything. The
pivotal clarifications were Kim's: (a) the supplemental cards are **controlled-vocabulary decks, modular by
discipline** (systematist vs ecologist), turning free-text chores into "put the right card in the shot";
(b) the **field log is co-equal with the label** — a systematically lost artifact this system rescues; and
(c) the **two-QR demo image was a test** that a reader can extract **each** code from one photo — **it can**
— which is precisely what makes the multi-card decks possible. Agreed the creative heart is **designing the
decks** (plus the small encoding scheme), with a real secondary design element in the **collector card**
(attachment + uniqueness friction; pre-printed beats field label-makers; QR + human-readable number as
redundancy/verification). Architecture named: **capture once, project two views** (label = one record; log =
all records). Scope still **Exploring** — name, deck design, and terrain boundary are open. No building yet;
Kim took a break after capture. See session_log.md 2026-06-29.
