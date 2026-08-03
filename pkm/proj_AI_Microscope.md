# PROJECT: AI Microscope

_Last updated: 2026-07-28_
_Status: Complete_
_Focus readiness: Not applicable_
_Tags: describe_
_Log: logs/proj_AI_Microscope_log.md_

## Type
Content project — documentation of a reconstructed 1989 system
(the "describe" end of the explore→build→describe arc, in the
checklistr mold).

## Objective
Document the **AI Microscope** — a browser-based botanical learning
environment that reconstructs, in modern web technology, the 1989
system Kim co-authored (Itoga, Bridges, Frederick & Uyeda, "The AI
Microscope Learning Environment," *J. Educational Technology
Systems* 18(1):3–14). The reconstruction was designed and tested by
Kim with Gemini doing the coding; the documentation is being
written here, with Claude, to match the house style and consistency
of the other kimbridges-documents publications (checklistr,
vouchr/specimen_labels). The document tells the story of a
pedagogical design that was right in 1989 but trapped by the era's
hardware, and is now realizable because the technical barriers
(storage, the C/Prolog hardware split, canned text) have dissolved.

## Current Status
The working app is **live at https://aimicroscope.netlify.app/**
(runs on a phone; audio requires volume up), deployed from the
GitHub repo (github.com/kimbridges/ai_microscope) via Netlify
continuous deployment. The identification substrate was **fully
rebuilt this session**: it is now **manifest-driven** — a per-slide
`slide_syringa.json` binds each tissue to an exact color and a
derived abundance — with **exact-match** identification on a clean
**categorical mask** (`color_layer_clean.png`), replacing the
original blended, name-derived color anchors. The slide carries
**nine tissues** (cuticle, upper epidermis, palisade, spongy, midrib
ground parenchyma, bundle sheath, phloem, xylem, lower epidermis),
all with lore. A **tissue-map overlay slider** fades the micrograph
against the color map to verify alignment/placement; the dropdown
shows each tissue's **% of the leaf footprint** as a findability
hint; and clicks outside the section return an **"outside"** message
rather than a wrong tissue. The clean mask came from Kim's Photoshop
pass over a Claude-built interim, then a snap-to-palette + solid-fill
pipeline. AI was used at three points originally: OpenAI built the
color map, Gemini wrote the code + generates narration, ElevenLabs
synthesizes the voice ("Rachel"). Venue decision (2026-07-22):
documentation done **here with Claude**, not with Gemini where it was
built — the documentation apparatus (style guide, two-readers
convention, joint byline, Quarto→kimbridges-documents pipeline) all
lives here. Reframed by Kim as an **exploration of the process** of
moving a strong 1989 teaching idea into today's tech (see
`ai_microscope_ideas.md`), not product-building; no game, no grading.
Intended output: one of "our documents," like the checklistr book.

**Feature layer + audit (2026-07-22, later sessions).** On top of the
identification core: a **term explorer** (per-tissue Say-it button on
turbo v2, plain-English gloss, Greek/Latin etymology — pronunciation
as FRICTION, see proj_audio.md); a **top-to-bottom code audit**
(report: `AI_Microscope_audit.md`) whose agreed fixes are deployed —
single-clip **audio management** (newest-wins, no overlap; helps
mobile), a **slide-picker + `slides.json`** index (scaffolded for
future root/stem/other-species slides; one slide now), **calibrated +
aspect-safe magnification** (de-duplicated into one `cropGeometry`
helper), honest relabels ("High-contrast view"), and a11y touches
(ARIA live region, canvas label, no innerHTML). Kim declined dropping
the live Gemini polish (accepts the double AI call). A **launch audio
intro** (welcome/orientation; text in `slides.json`, editable as data,
not code) now greets students.

**Pedagogical spine — the "bookends" model (Kim, 2026-07-22).** The
simulator sits on either side of the real lab: a **preview** (before —
warm up moving the field of view, changing magnification, saying the
names, building Latin/Greek vocabulary, *without* the friction of a
physical microscope → lowers cognitive load for the hands-on lab) and
a **review** (after — revisit in the post-lab mode; things make sense
now and concepts settle → consolidation, where much of the real
learning lands). Two jobs: **remove friction** and **induce review**.
The old beginner/advanced toggle IS this selector — relabeled
**"Before the lab — preview" / "After the lab — review."** This is the
*why* of the tool and a strong spine for the eventual document.

**Documentation — BOOK ASSEMBLED (2026-07-25).** The document the
project exists to produce is written and now renders as a Quarto book:
**"Preview & Review"** (subtitle *Rebuilding the AI Microscope*) —
Preface + nine chapters + an **Appendix** ("How it's built"), in
`documentation/`, checklistr multichapter house style, first-person Kim
voice, joint byline K. W. Bridges and Claude, → kimbridges-documents.
Kim has done his voice edits; the Appendix was drafted 2026-07-25.
Two design points surfaced during drafting and are carried in the
prose: the **touch-in / audio-out asymmetry is a PRIVACY choice**
(earbud output is private; voice input goes public unless the student
is isolated, re-introducing the very friction the tool removes — Ch.8,
an honest open problem) and **"the art of teaching is knowing what not
to teach"** (Kim's students Mick Crawley & Mark Westoby; the
boat/subtraction metaphor — kim_association_index Theme 13; Ch.9).
**Seven screenshot figures** are placed with numbered captions
(interface, a wrong answer handled, the tissue map, the 65% overlay,
the term card, the review stage, the splash); the captions carry the
argument, so by Kim's decision the prose contains **no `@fig-`
cross-references**. A **cover image** (`ai_microscope_cover_art_text.png`
— a phone in hand showing the leaf section, title set in the art) and a
250×250 **logo** sit in the project root and in `figures/`.
`_quarto.yml` is written and the book **renders clean end-to-end**. A
**callout at the top of the Preface** links the live simulator.
Remaining: the data figures, an optional image downsize, and the
deploy. Full detail in the 2026-07-24 and 2026-07-25 log entries.

**Security — RESOLVED 2026-07-22.** The original deployment had two
API keys hardcoded in cleartext in `index.html`. Fixed by moving the
keys off the client entirely: two Netlify serverless functions
(`narrate` = Gemini, `speak` = ElevenLabs) now hold the keys in
Netlify environment variables and proxy the calls, so the browser
never sees a key. Both keys rotated (new values in Netlify env vars
+ Kim's `.Renviron`); Google key has a dollar cap; ElevenLabs plan-
capped; functions carry an optional `ALLOWED_HOST` origin check.
Verified live: page source is clean, audio works. Same class of
issue as the old `QR_procedures.Rmd` key in specimen_labels — now
closed structurally, not just patched.

**PUBLISHED 2026-07-25.** The document is **live** at
https://kimbridges-documents.netlify.app/ai_microscope/ - the nineteenth
document on the site. Preface + 9 chapters + Appendix, seven screenshot
figures and **three data figures**, cover and logo, a simulator link in
the Preface. Kim: "It worked nicely. The charts center well. The document
is on-line!!!!" The app itself remains **frozen** pending the
plant-anatomist review, which is the project's only open dependency.

## Locations
- Code / app: `G:\My Drive\Projects\AI_Microscope\`
  (root = clean working copy; `microscope_deploy\` = the copy
  pushed to Netlify)
- Live site: https://aimicroscope.netlify.app/
- Working notes: Google Doc "AI Microscope Doc Working Notes"
  (id 1cbsQqV7fZvXF5KY1CI5aFU-VfvJGRy3hoNQ2cRHi8dk) — the notes
  sent to Prof. Stephen Itoga with the demo link, plus Kim's
  account of where the AI was used.
- Design commentary: Google Doc "AI Microscope Revisited"
  (id 1eEd-5jIPg7pUy6tBSTEgGQyYpJSayIEkuGtmCAPnxGg) — Gemini's
  1989-vs-2026 reaction, metaphor-by-metaphor.
- Source paper: 1989_Itoga_etal_The_AI_Microscope_Learning_
  Environment.pdf (uploaded to session 2026-07-22).
- Docs/output: not yet (Quarto scaffold TBD, → kimbridges-documents)
- GitHub: https://github.com/kimbridges/ai_microscope (single
  source of truth; Netlify now builds from it via continuous
  deployment — push → auto-deploy)

## Key Files
- `index.html` — the whole app (HTML/CSS/JS, single file, ~23 KB):
  splash screen; tissue-type dropdown (the "investigation
  objective"); 4x/10x/40x magnification turret; standard vs
  "wall density profile" view; beginner/advanced depth mode;
  crosshair navigation over a 6528×3680 master image; nearest-
  color-anchor tissue sampling; Gemini "tone polish" of the
  narration; ElevenLabs streaming TTS.
- `botanical_lore.json` — the deterministic, anti-hallucination
  narrative repository: 12 color-anchored tissue types, each with
  proper_name, engineering analog, intro explanation, and
  beginner/advanced narration text.
- `leaf_section.jpg` — the master leaf cross-section (4.3 MB;
  from a Wikipedia micrograph).
- `color_layer.png` — the tissue-ID color mask (2.2 MB; built by
  OpenAI from the micrograph); 12 color anchors define the layers.
- `netlify.toml` — publish root + functions dir config.
- `netlify/functions/narrate.js` — Gemini proxy (key server-side).
- `netlify/functions/speak.js` — ElevenLabs TTS proxy (key
  server-side; returns base64 audio/mpeg).
- `scripts/validate_lore.mjs` — validates `botanical_lore.json`:
  parses, checks required fields non-empty, and cross-checks that
  every dropdown learning target has a lore entry (structural
  anchors without lore are warnings, not failures). Runs locally
  and in CI. Tested against real + broken inputs 2026-07-22.
- `.github/workflows/validate.yml` — GitHub Action running the
  validator on every push touching the lore or the app.
- (legacy, inert on Netlify: `app.py`, `requirements.txt`,
  `color_key.csv`, `trivial_test.mp3` — the earlier Streamlit build.)
- `documentation/` — the Quarto book source, and the single source
  of truth for the document: `_quarto.yml` (book type, output-dir
  `_output`, cover-image, navbar logo, code-fold, numbered to depth
  2), `index.qmd` (Preface), the nine chapter .qmd files,
  `appendix.qmd`, `doc_plan.md`, and `figures/`.
- `documentation/figures/` — `aim_1_splash.png` through
  `aim_7_not_quite.png` (app screenshots, 1520×2840, captured with
  Playwright against the app served locally), plus
  `ai_microscope_cover_art_text.png` (850×1000) and
  `ai_microscope_logo_art.png` (250×250). The cover and logo are
  also copied to the project root, as the style guide requires.
- `documentation/aim_figs.R` - the script that builds all three DATA
  figures from their source data. Kept as a deliverable, not scratch:
  Okabe-Ito constants, one shared `base_theme`, and three `ggsave()`
  calls to SVG. Rerun it and the figures rebuild.
- `documentation/figures/aim_8_storage_cost.svg` - cost to store one
  slide, 1989-2026, log scale (Ch.2).
- `documentation/figures/aim_9_color_smear.svg` - distinct colours
  inside each tissue's region of the old blended map (Ch.5).
- `documentation/figures/aim_10_abundance.svg` - percent of the leaf
  footprint per tissue, from `slide_syringa.json` (Ch.5).
- `documentation/_onepage.qmd` / `_onepage.html` - all eleven chapters
  as one continuous scroll, for reading straight through. The
  underscore prefix keeps the Quarto BOOK project from sweeping it in.
  NOT deployed.
- Published copy: `kimbridges-documents/ai_microscope/` (the rendered
  `_output/` contents) plus the listing stub
  `kimbridges-documents/docs/ai-microscope.qmd`.

## Architecture (1989 → 2026 mapping)
The document's spine. Same fundamental structure both eras: a color
map beneath the image encodes tissue identity. What changed:
- **Storage** — 1989: one *Syringa* slide = 1.25 MB, a curriculum-
  scale problem. 2026: multi-MB images stream trivially.
- **The hardware split** — 1989: C simulation on an HP 9000
  workstation, Prolog tutor on a PC, joined over a serial port.
  2026: one browser, HTML/CSS/JS.
- **The cards / voiced names** — 1989: X-Window 3×5 card stacks +
  voiced scientific names. 2026: `botanical_lore.json` +
  ElevenLabs voice; Gemini adapts tone on the fly.
- **"A tool, not a spy"** — the 1989 ethic (unobtrusive support,
  no probing/grading, student in control) carries straight over;
  worth foregrounding against today's telemetry-heavy edtech.
- **New in 2026** — Socratic goal-selection (pick a target tissue,
  get correct/"not quite" feedback), engineering analogies
  (palisade = "solar panel array," xylem = "high-pressure plumbing
  main"), depth toggle.

## Related Projects
- **checklistr** (proj_checklistr.md) — the documentation MODEL:
  same explore/build→describe arc, same multichapter Quarto →
  kimbridges-documents deploy, same joint byline. The consistency
  Kim wants is consistency with this.
- **audio** (proj_audio.md) — Kim's standing TTS / audio-AI
  interest; the AI Microscope's ElevenLabs voice layer is a
  concrete instance and a natural cross-link.
- **briefing_book** (proj_briefing_book.md) — the current Active
  Focus, on hold pending Dr. McClatchey's Sunday critique; this
  project is the deliberate side-thread taken up during that hold.

## Will McClatchey review + design decisions (2026-07-22)
Dr. Will McClatchey reviewed the working simulation — positive
overall, with suggestions. Decisions taken:
- **Multiple leaf images — ACCEPTED.** Show the same functional
  architecture (palisade, spongy, xylem, …) across different
  species; deepens the "why structure matters" point. Drives the
  code toward a per-slide data structure (tissue + color +
  abundance live with the slide; lore stays shared).
- **Make it a game — REJECTED.** A game would be judged as a game;
  the point is that it is *not* one. The 1989 ethic (a supportive
  tool — "a calculator/dictionary, not a spy") is the identity to
  protect.
- **Grading / quizzing — REJECTED.** Quizzing is stress-inducing
  and turns a supportive tool into a surveillance one — opposite
  of the goal.
- **Goal restated (Kim):** make students interested in *why* leaf
  anatomy matters (not learning for its own sake) and give them a
  supportive environment that optimizes their time.
- **New feature (Kim): % abundance in the tissue dropdown** — so a
  student knows whether a type is easy (abundant) or hard (rare) to
  find; an abundance/location *hint*, not a test. Computable only
  from a categorical mask, so it is the same work as the fix below.

## Next Steps
1. ~~Identification recode.~~ **DONE** (nine tissues, exact-match, %,
   overlay, "outside", full lore).
2. ~~Term explorer + top-to-bottom audit.~~ **DONE + deployed** — audit
   report `AI_Microscope_audit.md`; agreed fixes shipped (audio
   management, slide-picker/`slides.json`, calibrated aspect-safe
   crop geometry, honest relabels, a11y). Gemini polish kept (Kim's
   call). Launch audio intro + "Before/After the lab" toggle shipped.
3. **The document — WRITTEN + ASSEMBLED 2026-07-25 (see the logs).**
   "Preview & Review" = Preface + 9 chapters + Appendix; seven
   screenshot figures placed with numbered captions; cover + logo in;
   `_quarto.yml` renders clean end-to-end; a simulator link callout
   at the top of the Preface. **Remaining:**
   - ~~Data figures.~~ **DONE 2026-07-25** - three built in R on Kim's
     machine (`documentation/aim_figs.R`, kept as a deliverable): storage
     cost per slide 1989-2026 (Ch.2), colours found where there should
     have been one (Ch.5), tissue abundance (Ch.5). Okabe-Ito, SVG, never
     colour alone, one per page width, stacked. The planned pronunciation
     before/after figure was **cancelled by Kim**; do not revive it.
   - ~~Optional image downsize.~~ **Parked; not needed for launch** - the
     seven screenshots are about 12 MB and display at roughly 340 px, but
     the documents site is already about 300 MB, so this moves nothing.
     Offer again only if load time becomes a real concern.
   - ~~Deploy to kimbridges-documents.~~ **DONE 2026-07-25 - LIVE.**
     Folder `ai_microscope/`, listing stub `docs/ai-microscope.qmd`
     (title "Preview & Review", categories AI / Botany / Design),
     `ai_microscope/**` in the site resources; Kim drag-deployed to the
     EXISTING tile (Finding 011 respected).
   - **`_onepage.html` is NOT deployed** - it lives in `documentation/`,
     not in `_output/`. It is a single continuous build of all eleven
     chapters for reading straight through. Publish it alongside the book
     only if Kim asks.
   - **External review** — the plant-anatomist read. The app is
     feature-complete and deliberately **frozen** until it comes
     back, so the document can describe a stable thing.
   - **Audio round 2** stays optional/parked: pronunciation
     dictionary, CMU vs IPA, Cambridge UK/US. NOTE: the run-to-run
     pronunciation variability is now a **KEPT FEATURE** (it
     dramatises the friction) — do NOT seed it away.
4. Content refinements anytime (via the commit loop, no code): the
   glosses/etymologies, the intro wording (in `slides.json`), a per-
   term IPA override if a name grates. Future: a real second slide
   (root/stem from the anatomist review) exercises the slide-picker;
   re-examine cuticle placement (can appear in open gas-exchange
   spaces); optional canvas keyboard-navigation (a11y).

## Collaborators / Dependencies
- Kim W. Bridges — design, testing, direction (1989 co-author).
- Gemini — the reconstruction's build partner (stays on the build
  if the app evolves; not the documentation venue).
- Prof. Stephen Y. Itoga (UH Mānoa) — 1989 lead author; recipient
  of the demo. Lawrence Frederick, Richard I. Uyeda — 1989 co-authors.

## Blockers
- **External review -- the plant-anatomist read.** The app is
  deliberately frozen until it arrives, so the published document
  describes a stable thing. This is what the header's Focus
  readiness: Blocked refers to.
- Cleared 2026-07-22: the exposed-keys blocker (both keys moved
  server-side into Netlify functions and rotated).


---
## Log

The dated log for this project was split out on 2026-07-28 and now lives in
`logs/proj_AI_Microscope_log.md`. It is verbatim and unedited. New entries go there.
