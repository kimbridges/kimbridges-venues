# PROJECT: Audio
_Last updated: 2026-07-22_
_Status: Active_
_Focus readiness: Ready_

## Type
Audio workflow (text-to-speech dialog crafting; future R API tooling;
future real-time agent exploration)

## Objective

A practice and toolkit for collaborative authoring of multi-voice
audio dialog, and more broadly for audio-based interaction with AI
systems. The core workflow pairs Claude as a stepwise text
collaborator with ElevenLabs Studio as the rendering and
voice-tuning environment. The project exists because Kim's earlier
Gallery Catalog audio pieces established that section-by-section
human–AI dialog crafting produces substantially better results than
end-to-end auto-generation tools like NotebookLM. The "practice"
half of this project develops repeatable craft conventions; the
"toolkit" half anticipates R-based API integration for batch or
scripted operations.

## Current Status

**Reactivated 2026-06-03; the R/API rendering path is now operational.**
The paused trigger (awaiting maturing TTS) is effectively met: ElevenLabs
now exposes a Text-to-Dialogue endpoint on the Eleven v3 model, and Claude
drives it directly from Kim's live RStudio session via the ClaudeR MCP
(see pkm_findings.md Finding 006). An R harness was built from scratch
(`elevenlabs_dialogue.R`) and the first dialog (Tad/Miko) was rendered
end-to-end in one session. This is a workflow-architecture change: rendering
can now happen autonomously through the API from R, in addition to the
Studio path. Studio remains the right tool for hands-on voice-control
tuning and A/B comparison; the R/API path is for fast, scripted iteration
where Claude renders without per-step human involvement.

Workflow architecture defined and agreed: Claude crafts dialog text
section by section; Kim renders in ElevenLabs Studio where voice
selection, voice control tuning (stability, similarity boost, style,
speaker boost), A/B voice comparison, and re-render iteration all
live natively. ElevenLabs Agents MCP extension wired up correctly
(voice catalog returns ~50 voices including custom workspace
voices); reserved for future real-time conversational-agent work,
not used for batch dialog rendering. ElevenLabs Player MCP
extension has a config-substitution bug (literal
`${user_config.output_dir}` reaches mkdir; output-directory field
never substitutes); reported via thumbs-down 2026-05-10. The Player
path is moot regardless: its MCP surface does not expose voice
controls, so ElevenLabs Studio is the correct rendering target.

A working folder is now in place at G:\My Drive\Projects\Audio with
first-test materials (Story_background.txt, First_test.txt,
First_test.pdf, First_test_json.txt, Eleven_tinytest.txt) — Kim is
preparing an example dialog for an eventual Gallery Collection
product. Color of the Year remains queued as a separate example.
R API integration anticipated but not yet started.

## Locations
- Working materials: G:\My Drive\Projects\Audio (preparation,
  drafts, test files, JSON exports — the working area for audio
  dialog development)
- Code: G:\My Drive\Projects\Audio\elevenlabs_dialogue.R — the R
  harness for the ElevenLabs Text-to-Dialogue endpoint (built
  2026-06-03; uses the curl + jsonlite packages directly, not httr2)
- Renders: G:\My Drive\Projects\Audio\renders\ — rendered MP3 output
  (first_test_part01–03.mp3 from the 2026-06-03 session)
- Data: dialog scripts and renderings live in
  G:\My Drive\Projects\Audio during development; finished audio
  products are placed inside the relevant kimbridges-collections
  subfolder (the Gallery Catalog precedent)
- Docs/output: rendered audio currently published as part of
  kimbridges-collections (Gallery Catalog)
- GitHub: not yet

## Key Files
- proj_audio.md — this file
- G:\My Drive\Projects\Audio\Story_background.txt — narrative
  context for the in-development dialog
- G:\My Drive\Projects\Audio\First_test.txt — first dialog draft
- G:\My Drive\Projects\Audio\First_test.pdf — first dialog as a
  rendered PDF
- G:\My Drive\Projects\Audio\First_test_json.txt — JSON export
  of the first dialog
- G:\My Drive\Projects\Audio\Eleven_tinytest.txt — ElevenLabs
  rendering smoke test material (now obsolete: its
  `[speaker=X voice=Y]` + `(cue)` notation is not the v3 format)
- G:\My Drive\Projects\Audio\First_test_canonical.txt — the first
  dialog rewritten into the adopted canonical format (2026-06-03)
- G:\My Drive\Projects\Audio\elevenlabs_dialogue.R — the R API harness
  (cast-file loading + WAV assembly added 2026-06-03)
- G:\My Drive\Projects\Audio\voice_catalog.tsv — reference list of all 48
  voices (voice_id, name, category)
- G:\My Drive\Projects\Audio\Nike_challenge\ — second test: the story
  (Nike_challenge.txt), the canonical dialog (Nike_challenge_canonical.txt),
  the cast file (Nike_challenge.cast — current cast: NIKE = Ellen
  `BIvP0GN1cAtSRTxNHnWS`, JONES = Jane `RILOU7YmBhvwJGDGjNmP`), and renders\
  (the 2026-06-07 casting A/B set: nike_full_ellen_para, nike_full_smith,
  nike_full_johndoe, nike_full_jane — the **kept** pairing is nike_full_jane.wav)
- G:\My Drive\Projects\Audio\Nike_challenge\Nike_story.md — **the written short
  story "My Name Is Nike"** (8 chapters; 2026-06-13) — the Nike_challenge material
  developed into a literary short story (close third person, two-year arc); a
  written-prose, not-TTS, deliverable
- G:\My Drive\Projects\Audio\Nike_challenge\illustrations\ — **photoreal story
  illustrations** generated via the OpenAI image API (gpt-image-1) from the live R
  session, started 2026-06-24 (see the 2026-06-24 log): camu-camu revelation,
  Jones's office, the satellite call. Kim's edited starter portrait of Nike is the
  reference image for her likeness. **Growing illustration set** — current inventory + chapter coverage in
  the **2026-06-25 log entry** (mirror/Ch.1, lab keying/Ch.3, expedition/Ch.3, office/Ch.4-8, yellow
  birds/Ch.5, Samoa desk/Ch.6, satellite FINAL/Ch.7). Capability recorded in pkm_findings.md Finding 010.
  Only gap left: Ch.2 (McClatchey & Liu). Scratch/intermediate files deletable. Active Focus stays
  seasonality (side thread).
- (planned) additional dialog scripts as more examples come online

## Working Conventions

These are the operating preferences crystallized from the
2026-05-10 session. They live here so they survive across sessions
and govern future audio work without needing rediscovery.

### How dialog is built

Multi-voice is the default. Projects typically involve two or three
speakers — commonly two critics or interlocutors plus an occasional
third voice (narrator, moderator, or quoted material).

Dialog is crafted, not auto-generated. Section by section,
human–AI collaboration. End-to-end pipelines have been tried and
produced output that was "interesting but misleading." The
stepwise approach restores the joints where corrections and
refinements happen.

Logical units of conversation are the working unit. A section is
drafted, reviewed, refined, and only then does the next begin. The
same unit-of-work principle governs TTS rendering — render in
chunks aligned with logical units, not as a monolith.

### What matters in the dialog text

Conversational rhythm is critical. The voices must not feel
interchangeable. They differ in pacing, sentence length, hesitation
patterns, and how they enter and exit each other's lines. Symmetry
is a failure mode.

Emotion belongs in the script. ElevenLabs v3 supports inline audio
tags such as `[thoughtful]`, `[laughs softly]`, `[contemplative
pause]`, `[excited]`, `[whispers]`. Emotional cues are embedded
where they belong rather than left for the engine to guess.

Persona consistency. Each speaker has a viewpoint, vocabulary, and
conversational stance that holds across sections. Distinct angles
(e.g., formalist vs. conceptual, contrarian vs. consensus-seeking)
help.

### What matters in the rendering

Voice selection must match the intent of the discussion. Voice is
not interchangeable with voice. Comparison and testing happens
inside ElevenLabs Studio where the candidate voices, settings, and
previews are all available together.

Voice controls (stability, similarity boost, style, speaker boost)
are part of the craft. Tuned in Studio per voice per project, not
assumed.

### Canonical handoff format (adopted 2026-06-03)

Verified against the current ElevenLabs Text-to-Dialogue (Eleven v3)
spec. The key structural fact: **the speaker is the per-turn `voice_id`,
not anything inside the text.** The API takes an `inputs[]` array of
`{text, voice_id}` pairs. So `MIKO:` / `<MIKO>` / `[speaker=MIKO ...]`
are all script conventions for us; none are sent to the engine.

The adopted script format is a plain-text file, one turn per line:

    SPEAKER: spoken text with optional [delivery] tags

Rules:
- **Square-bracket tags carry delivery only** — emotion/manner
  (`[mocking]`, `[coldly]`), and they are natural-language instructions,
  not an enum. They go inline where the delivery changes.
- **Pauses become punctuation** — an ellipsis for hesitation/trailing,
  a trailing dash for a cut-off line, with `[jumping in]` on the
  interrupting line.
- **Structural beats live in the script layer, not the sent text** — a
  line that is only a bracketed token (e.g. `[silence]`, `[BREAK]`) is
  dropped from what is sent and used as a chunk seam. (The old
  `[shocked pause, then cold]` mixed all three: it became `[coldly]`
  plus an ellipsis.)
- SPEAKER → `voice_id` is a separate named mapping applied at send time.

Hard limits: Eleven v3 only; keep total of all `inputs[].text` ≤ 2,000
characters per request. Longer dialogs are chunked at turn boundaries,
preferring the structural-beat seams so an edit never falls mid-exchange;
each chunk is one API request and the parts play in sequence. Output is
nondeterministic — pass a `seed` for reproducible reads (so a *different*
delivery comes from changing the text/tags, not from re-rolling).

Resolved (2026-06-03, second test): `el_assemble_wav()` renders the
chunks as PCM and splices them into one WAV with real silence inserted at
each structural-beat seam and a silent tail — so a `[silence]` beat is now
audible, and a dialog no longer ends abruptly. PCM is used so the splice is
sample-accurate and needs no audio package (no av/tuneR/ffmpeg). Output is
16-bit mono WAV at the requested sample rate, falling back from 44.1 kHz to
24 kHz if the account tier doesn't allow 44.1 kHz PCM.

Cast-as-file (2026-06-03): voices are specified in a `*.cast` file beside
the script — lines of `SPEAKER = voice name or voice_id` — resolved against
`voice_catalog.tsv` (the full 48-voice reference, written by
`el_list_voices()`). Trying a different voice is an edit-and-re-render, not
an interactive choice. Use the full catalogue name when a short one is
ambiguous (e.g. there are two "Brian" voices). A bare voice_id is accepted
even when it is not in the local catalogue — voices chosen from the broader
ElevenLabs **V3 voice collection** (where Kim's verified Nike/Jones picks
came from, 2026-06-03) are used by pasting their voice_id straight into the
cast file.

### Tool architecture

Claude crafts the text; ElevenLabs Studio renders. Clean separation
of concerns. The dialog file is the handoff artifact. Studio is
where voice assignment, voice control tuning, A/B comparison, and
re-render iteration live.

The Agents MCP app is reserved for future real-time voice
interaction with AI (a separate workflow from dialog rendering).

## Next Steps
1. **DONE (2026-06-07) — asynchronous rendering proven.** The
   fire-and-poll pattern now runs through ClaudeR's `execute_r_async` /
   `get_async_result`: `el_assemble_wav()` runs in a background R
   process (both API renders in one job), the main session stays
   responsive, and the multi-minute render no longer overruns the Cowork
   tool window (Finding 007 resolved in practice). Four consecutive
   recasts rendered cleanly this way (~2–2.5 min each). Remaining
   hardening: fold the async call into a harness wrapper so it isn't
   hand-assembled each session.
2. **Test a completely different dialog** — Kim's next goal (deferred
   ~2 weeks; reminder set for 2026-06-21). The Nike_challenge casting is
   settled for now; the next experiment is a fresh dialog, not another
   voice swap on this one.
3. **Three-voice dialog** — Kim's queued experiment: a third
   speaker (narrator / moderator / quoted voice) to test multi-voice
   beyond the two-hander.
4. Apply the workflow to a real piece — Color of the Year (queued), or
   develop Tad/Miko or Nike toward a Gallery Collection product. (Audio
   work resumes after some neglected projects and the stories realm.)
5. Decide where finished dialog scripts and rendered audio live —
   keep within kimbridges-collections, or a dedicated audio location.
6. Optional, for production fidelity: a 44.1 kHz assembled final
   (MP3-part stitching with an audio lib, or an ElevenLabs tier bump to
   unlock 44.1 kHz PCM).
7. Harden the harness as patterns settle: per-turn voice settings
   (stability/style), voice presets per project, batch re-rendering,
   maybe a small package.
8. (Long-term) Explore the Agents MCP app for real-time audio
   interaction with AI as a separate thread.

## Collaborators / Dependencies
- ElevenLabs (vendor) — service dependency
- Claude — text collaboration partner
- (Historical reference: NotebookLM auto-generation — not an
  active dependency, but informs the case for the stepwise approach)

## Blockers
None active. The Player extension bug is reported but not blocking
— ElevenLabs Studio is the correct rendering path regardless.

## Past Projects (Reference)

Gallery Catalog collection — two audio pieces, three voices each,
mostly two-art-critic discussions, crafted stepwise with AI
assistance. Published on kimbridges-collections. Reference for tone
and structure.

---
## Log

### 2026-06-25 (cont.) — illustrated PDF assembled; Ch.5 "Jones paper" plate; Ch.8 trophy-case closer; FINAL re-render DONE
- **Illustrated story PDF built.** Merged `Nike_story.md` + the chapter plates into a print-ready PDF via a
  new pipeline: **R stages the images + story into the shared Cowork `outputs` folder** (the bridge between
  R/G: and the sandbox), then **pandoc + xelatex** render it in the sandbox (pandoc / xelatex / pdflatex /
  libreoffice are all available there). First full draft = **25 pp**: cover (stark NIKE portrait + title) +
  8 chapters with images at their beats. `My_Name_Is_Nike_illustrated.pdf` in the Nike folder (a draft on the
  then-current images; the FINAL re-render is pending the Ch.8 decision below). *Reusable capability — a
  candidate pkm_findings entry: illustrated-document assembly via the R→outputs→pandoc/xelatex bridge.*
- **Ch.5 "Jones paper" plate (the artifact approach).** Rather than a standalone Ch.5 image, built a **mock
  journal page**: Kim's two scientific bird sketches (`bird_1/2_sketch.jpg`) as Figures 1 & 2, plus a
  Jones-voiced excerpt — a **"Wild-Harvested Plants"** methods section (snowball / chain-referral informants
  to saturation; free-listing in the vernacular with the people's own categories; villager-collected vouchers
  verified at the herbarium and carried back for confirmation) and the **"Naming and the Transmission of
  Knowledge"** passage carrying the dramatic irony (two yellow-bird names, *Sirpi* and *Tankáru*, reported as
  a "happy coincidence," met with "the smile a people keep for a question that does not need answering").
  Two-column LaTeX, running head **"Journal of Anthropological Ethnobiology 12(2)"** (deliberately fictional,
  to avoid a real journal), tight spacing, full columns, on one page; a **drop shadow** was added via magick
  so it reads as a physical sheet. Saved: `illustrations/ch5_jones_paper.png` (book plate, with shadow),
  `_flat.png`, `.pdf`, and the durable LaTeX source `jones_paper.tex`. Kim: "excellent… really supports the story."
- **Final book re-render DONE (2026-06-25, later).** Ch.8 resolved: Kim built **`Nike_athletics.jpg`** — Nike
  at a hallway **trophy display case**, catching her reflection in the glass (the story's literal closing
  beat). It replaces the rejected lamplit empty-office image. The thematic payoff lands: she reads *victory*
  (Nike) on her own forehead while surrounded by championship cups/medals — and it **closes a frame** with the
  Ch.1 hotel mirror (mirror → another kind of mirror). Placed as a **closing plate at the very end of Ch.8**
  (after the final McClatchey line, 0.95 width), not as a chapter-lead, so the book ends on the image.
  Final chapter→image mapping: Ch1 mirror v2 · Ch2 McClatchey+Liu lightened v2 · Ch3 expedition→lab-keying→
  berry-tray · Ch4 Nike-in-Jones-office · Ch5 Jones-paper plate · Ch6 Samoa desk v3 · Ch7 satellite FINAL ·
  **Ch8 trophy-case reflection (closer)**. Re-rendered **25 pp**, `My_Name_Is_Nike_illustrated.pdf` refreshed
  in the Nike folder. Build artifacts in `outputs/nike_build/` (`build.py`, `assembled.md`). **Illustrated
  book MILESTONE complete.** Active Focus stays **seasonality** (side thread).

### 2026-06-25 (Nike illustrations EXPANDED — Kim's hand-built scenes; chapter coverage mapped)
Resumed the parked thread. Kim built a run of new scenes himself with Photoshop + **Gemini** + his tools
(AI drafts, Kim finishes — Finding 010; note he now uses multiple engines, not only OpenAI). New keepers in
`Nike_challenge/illustrations/`, mapped to chapters:
- **`Nike_in_mirror_v2.jpg`** — **Ch.1**, the foxed hotel-mirror discovery ("NIKE in blunt blue capitals
  just below the hairline"): grimy peeling bathroom, cracked glass, *"Wi-Fi Gratis"* (Spanish → South
  America), wet hair, dawning bewilderment. **VERIFIED correct** (2026-06-25) — the name IS properly
  mirror-reversed in the glass; Claude's earlier "reverse it" worry was a misread. No change needed.
- **`Gemini_Generated_Image_35labh35labh35la.jpg`** — **Ch.3**, the teaching-lab **camu-camu keying
  exercise**: a pressed *Myrciaria dubia* voucher (Loreto, Peru), a bowl of red berries, a stereo scope, and
  a botanically **accurate** Myrtaceae dichotomous key. Makes concrete the plant she'd keyed and forgotten.
- **`Nike_ready_to_go.jpg`** (+ `refs/Nike_read_to_go_v2.jpg`) — **Ch.3**, **expedition departure**, two
  versions: v1 wider (campus + students she's leaving — preferred for story), v2 tighter portrait.
- **`Nike_in_Jone_office.jpg`** — **Ch.4/8**, Nike in the department beside the **two-yellow-birds painting**
  (the trust-code hanging in plain sight, undecoded). *Issue:* its bright/cool lighting doesn't match the
  warm lamp-lit empty office — so instead of reconciling them, **compromise: a tight desk-closeup still life
  of the *Coming of Age in Samoa* book + scattered papers** (also fills the Ch.6 gap). [in progress]
- **`ch4_jones_office_v3.png`** — refined empty office, lamp-lit framed **yellow bird** (the birds image
  repurposed as the office painting; supersedes v2).

- **`ch6_samoa_desk_v2.png`** — **Ch.6**, a **bright, well-lit** desk close-up of the real *Coming of Age in
  Samoa* dust jacket (Margaret Mead; the red/yellow boy-girl-silhouette cover) among papers, pen, glasses.
  Built by **editing from Kim's actual cover image** (`samoa.jpg`) so the jacket stays faithful — the
  faithful-cover + bright-office fix for the first attempt (`ch6_samoa_desk_stilllife.png`, too dark,
  superseded). Minor: the small blurb text on the cover is slightly soft. The Samoa warning McClatchey hands her.

- **`ch2_mcclatchey_liu_office.png`** — **Ch.2**, the "From Tattoo to PhD Program" beat: a well-lit
  scholarly ethnobotany office, **McClatchey seen from behind** at a desk laid with pressed herbarium
  specimens, **Andrea Liu** (Asian-American medical anthropologist) leaning in the open doorway facing him —
  the "popped in and stayed" moment. His back hides the recorder (Kim's framing). No specific faces needed →
  trap-free.

**Illustrated chapter coverage: COMPLETE — all 8 chapters now have an illustration.** Ch.1 (mirror) · Ch.2
(McClatchey + Liu) · Ch.3 (berry tray + lab keying + expedition) · Ch.4/8 (Jones's office) · Ch.5 (two
yellow birds) · Ch.6 (Samoa desk) · Ch.7 (satellite FINAL). **No open TODOs** (mirror verified correct;
Samoa desk done bright with the real cover). Optional polish remains Kim's call (e.g., a coffee-stain over
the Samoa cover's soft blurb text; small Wacom touches on the birds; the Ch.2 lighting tweak; final pick of
the two expedition versions). **The illustration thread is essentially COMPLETE** — all 8 chapters covered.
Scratch/intermediate files in the folder remain deletable. Active Focus stays **seasonality** (this is a
side thread).

**Forward idea (Kim, 2026-06-25) — a new "Fiction" web category.** "My Name Is Nike" is **fiction**, unlike
the kimbridges-stories content (non-fiction travel/photo narratives). Kim proposes a **new web category
called Fiction** to give fictional work its own home — "Nike," and the earlier story **"Orbits"** (currently
"hidden" inside Collections), would live there, **cross-posted, not moved** ("it would live both places").
Rationale: fiction deserves a real front door rather than being buried, and a dedicated home may **encourage
writing more fiction.** To develop (flagged in project_index.md); not yet scoped — new site vs a section of
an existing site, and the relationship to kimbridges-stories / -collections. A natural next step once "Nike"
(now written + illustrated) is ready to publish.

### 2026-06-24 (later — OpenAI image-drafting capability ESTABLISHED; Nike illustrations PARKED with 4 keepers)
The illustration side-thread resolved into a durable new capability and a clean stopping point. **New
capability (fully recorded in pkm_findings.md Finding 010):** Claude drafts images via **OpenAI
`gpt-image-1`** from the live R session (httr2; text-to-image `/v1/images/generations` and image-edit
`/v1/images/edits`, incl. multi-image references; async; `openssl::base64_decode`). Kim: "a big step
forward… we'll probably use quite often — we can now tap OpenAI to do some of our image drafting."
**The hard-won rule (Finding 010):** OpenAI is excellent for *atmosphere, place, objects, light, symbol*;
**unreliable for a specific face (it reinterprets — Nike's eyes went brown) and for reproducing a specific
supplied pattern (defaulted to dot clusters, not Kim's bar-and-dash diagrams).** Those go to the **human**:
Kim composites the exact face and draws the exact patterns in **Photoshop / Wacom tablet** — his retouching
is a first-class contribution, not a fallback. **AI drafts; Kim finishes.**

**Four keeper illustrations** for "My Name Is Nike" (in `Nike_challenge/illustrations/`):
- `ch3_camu_camu_revelation.png` — the berry tray (Ch.3 pivot). OpenAI, kept as-is.
- `ch4_jones_office_v2.png` — Jones's lamplit office + framed yellow bird (Ch.4/8). OpenAI, kept.
- `ch5_two_yellow_birds_v2.png` — two *distinct* yellow species on a branch (Ch.5 trust-code). OpenAI;
  Kim adding small Wacom touches to further separate the two species.
- `ch7_satellite_call_FINAL.png` — the satellite call (Ch.7). **Kim's Photoshop finish:** real Nike
  portrait placed on the laptop screen + each elder's bar/dash forehead tattoo drawn by hand. The image
  that defeated ~12 generative passes, done cleanly by hand in minutes — the proof of the Finding 010 rule.

**PARKED — RESUME to finish illustrating the story.** Remaining trap-free scene candidates (no face/pattern
fidelity needed, play to the engine's strengths): the **starlit trail** (Ch.3, figure from behind under
stars), the **river arrival** (Ch.3, dugout canoe / village), the **camu-camu shrub** in the floodplain,
the **"Coming of Age in Samoa" still life** (Ch.6), and the **wall of selves** (Ch.1, her apartment of
Amazon self-photos). Scratch files from the rabbit hole (everything in `illustrations/` starting with `_`,
plus intermediates `ch7_v3…`/`ch7_v4…`/`ch7_scene_v5`/`ch7_v6_final`/`ch7_satellite_call_elders` v1–v3) are
deletable; Kim to clear. Active Focus stays **seasonality** (this was a side trip); return here to finish
the Nike illustrations.

### 2026-06-24 (FROZEN mid-thread — illustrating "My Name Is Nike" with OpenAI images; resume this evening)
A side-thought thread (Kim's, during a break from seasonality): add **photoreal illustrations** to the
short story, generated via **OpenAI image API calls** from the live RStudio session — the image cousin of
the ElevenLabs audio harness. **Paused mid-thread to get a sensitive image right; resume this evening.**

**Capability proven (new).** `gpt-image-1` driven from R via **httr2** (now current — curl/httr2 were
updated during the seasonalityr GitHub push). Two endpoints, both run **async** (Finding 007), b64 decoded
with `openssl::base64_decode` then `writeBin`:
- **Text-to-image** — `POST https://api.openai.com/v1/images/generations`, JSON body
  `{model:"gpt-image-1", prompt, size:"1536x1024", quality:"high", n:1}`,
  `req_auth_bearer_token(Sys.getenv("OPENAI_API_KEY"))`; image at `body$data[[1]]$b64_json`.
- **Image-to-image / edit (iteration)** — `POST /v1/images/edits`, **multipart**:
  `req_body_multipart(model="gpt-image-1", image=curl::form_file(src), prompt, size, quality)`. This is the
  revise-the-image-like-a-paragraph workflow — feed the prior PNG back in and change only what's asked.
- Cost ~pennies/image. **Billing:** the account hit its hard limit on the first call; Kim funded it, then
  generation worked. Key is in `.Renviron` (`OPENAI_API_KEY`).

**Aesthetic / character.** Match Kim's **starter portrait** of Nike (a young blonde woman, blue "NIKE"
lettered on her forehead, stark dark low-key night photo). He **edited that portrait to remove the facial
damage** (cleaner, story-consistent) — it is the **reference image for Nike's likeness**. House look across
the set: warm/dark, photoreal, low-key, cinematic, 35mm.

**Images made so far** (in `G:\My Drive\Projects\Audio\Nike_challenge\illustrations\`):
- `ch3_camu_camu_revelation.png` — **DONE / Kim likes it.** Hands holding a tray of ordinary camu-camu
  berries in smoky cookhouse light (the Ch.3 pivot, "the bottom went out of the afternoon").
- `ch4_jones_office.png` (v1) → `ch4_jones_office_v2.png` — **DONE.** Jones's office: full shelves, desk
  drifted with offprints, afternoon light through a jalousie window; v2 added a **side table with a lit
  lamp** illuminating a **framed yellow tropical bird** (the yellow-names plant), plus a **desk chair**.
- `ch7_satellite_call_elders.png` (v1) → `ch7_satellite_call_elders_v2.png` — Ch.7 satellite call: Héctor
  by a glowing laptop, **Amazonian elders** in firelight, **respectful documentary realism, NOT a "witch
  doctor" caricature** (Kim's explicit direction). v2 strengthened the elders' **abstract geometric forehead
  tattoos** (clearly visible now; patterns, not letters — the marking theme made visual) and put **Nike on
  the laptop screen**.

**RESUME HERE (this evening).** The **Nike-on-screen image is "all wrong"** (Kim) — this is the sensitive
one to get right; Kim "knows how to fix it." Most likely fix: use his **edited reference portrait** of Nike
via the **image-edit endpoint** (pass her photo as the reference) so her likeness/hair/dress are correct
and consistent — neat hair, student-appropriate, keeping the NIKE forehead mark; she had been described in
text only, which drifted. Then continue the set. **Queued:** the **two yellow birds** (Ch.5, the hidden
code) as a standalone image; **formalize a small reusable `nike_image()` harness** (text-to-image +
image-edit, async) so each scene/tweak is a one-liner — the analog of `elevenlabs_dialogue.R`; decide the
final illustration set and where the illustrated story will live. Sensitivity note to carry: the elders are
rendered with dignity (no stereotype); Nike's brand vs the elders' illegible marks is the intended visual
rhyme. Active Focus stays **seasonality** — this is a side thread (like the audio and the written story
before it).

### 2026-06-15 (Dr. McClatchey's response to "My Name Is Nike" — early, and warm)
The review reminder set for 2026-06-27 was answered ahead of time, and positively. Dr. McClatchey's
reaction, in his words: *"ok, so, where do I begin. this is really well written. Thank you. I feel
more than a little guilty about many students NOT accepted on the basis of their goofy application
letters that WE mocked…."* The story did more than please as prose: it made an experienced admissions
reader reconsider real students judged on superficial first impressions — exactly the premise (a name
misread onto a forehead) turned back on the reader. Strong external validation of the written-word
pivot. The story can now move from "complete in draft, awaiting review" toward a home (Audio vs the
kimbridges-stories realm — Kim's call) and, like the coenosr document, possible posting. The 2026-06-27
reminder is effectively fulfilled. Lessons-learned capture (test-becomes-a-story; the
audio→written-word pivot; the efficiency of the written word) still queued.

### 2026-06-13 (Nike_challenge becomes a written short story — "My Name Is Nike," 8 chapters)
Kim parked Ceska for a session and returned to Nike_challenge with a surprise. Dr.
McClatchey, asked to review the rendered audio, said nothing about the audio —
which, read as "it sounded normal," is the strongest possible sign the TTS
**emotion test passed** — and instead asked for *the next chapter of the story.*
The test had become a story.

Decision: write it, and pointedly **as a written short story, not a TTS script.**
The audio capability is proven; the interest now is the efficiency of the written
word (Kim's reference point: the "Orbits" writing experience).

Built by reconciling three assets — the rendered audio office-confrontation (the
bargain), the "Nike and the Miracle Plant" PDF (origin + camu-camu), and a new Kim
storyline (a yellow-name research design). Eight chapters, close third person /
past tense, drafted chapter-by-chapter in the draft-then-react loop, over a
**two-year** provisional-PhD arc:
1. The Name on My Forehead — the voicemail; "Nike" = a shirt brand misread onto her forehead.
2. From Tattoo to PhD Program — McClatchey + Liu admit her provisionally; McClatchey underlines "Jones."
3. The Miracle Plant — camu-camu; the first humbling (midpoint pivot): "the miracle was learning to ask a better question."
4. The Blow-Up — humility curdles into over-correction → she attacks Jones → he turns the grievance into the bargain.
5. Yellow Names — the hidden trust-color naming code; Jones's own two yellow-bird names; "marked, not careless."
6. Designing the Test — the 3-step sequential design; Mead/Freeman; the access paradox.
7. The Reckoning — reciprocity + consent; the tattoo she *kept* becomes her credential of trust.
8. How Scientists Write Research Proposals — Jones owns his filtered data, invites her to co-design a methods course; "Nike" = victory, earned.

Independent verification pass (subagent): research design defensible, cause-vs-marker
and small-N caveats correct, Mead/Freeman accurate and left undecided, camu-camu
(*Myrciaria dubia*) botany correct, character + timeline continuity clean after a
two-year-clock fix. Kim across the session: "my eyes are wet… an interesting and
likely useful story… the collaboration was wonderful."

**Location:** `G:\My Drive\Projects\Audio\Nike_challenge\Nike_story.md` — kept here
for now; revisit (Audio vs kimbridges-stories realm) after review. **Review reminder
set for 2026-06-27** (~2 wks) to fold in Dr. McClatchey's reactions. **Queued for
next session startup (Kim):** capture the *lessons learned* — likely PKM-level
meta-observations (a test becoming a story; the audio→written-word pivot; the
efficiency of the written word).

### 2026-06-07 (voice-casting pass on Nike_challenge; async rendering proven; a female professor chosen)
A short, productive session run entirely through the live R/API path. Kim
iterated the Dr. Jones voice on the existing Nike_challenge dialog by editing
only the `.cast` file between renders; Claude re-rendered each via the harness
in Kim's RStudio session. Nike stayed on **Ellen** (Serious, Direct) throughout
— a fixed reference Kim is very happy with.

- **The casting search.** Four male candidates for Dr. Jones were tried in
  sequence and assembled to full WAVs for A/B: the prior pick, then **Smith**
  (Mellow/Bassy — "a better combination"), then **John Doe – Deep**, none quite
  landing. Kim then made the conceptual jump: drop the male professor and cast
  an **older female** voice. Final pick — **Dr. Jones = Jane** (Professional
  Audiobook Reader, voice_id `RILOU7YmBhvwJGDGjNmP`), Nike = Ellen
  (`BIvP0GN1cAtSRTxNHnWS`). Kim's verdict: **"the best of all the pairings. Not
  perfect, but very close. This is the one we'll keep for now."** Renders left
  in `Nike_challenge/renders/` for comparison: `nike_full_smith.wav`,
  `nike_full_johndoe.wav`, `nike_full_jane.wav` (plus the earlier
  `nike_full_ellen_para.wav`). The cast file holds Jane in the JONES slot.
- **Casting observation worth carrying (Kim).** Ellen "works very well," and
  across the whole search the female voices were consistently easier to
  understand than the male ones — Kim is happy with a female professor and
  suspects female voices may simply be more intelligible on this engine. A
  candidate casting heuristic for future dialogs, not yet a rule: when clarity
  matters more than a specific timbre, start from female voices. (Watch the
  same-gender-pair risk — two female voices must still stay distinct; here
  Ellen-vs-Jane held the heat-vs-control contrast.)
- **Async rendering proven (Finding 007 resolved in practice).** Every render
  this session ran as a background job via ClaudeR's `execute_r_async` /
  `get_async_result`: `el_assemble_wav()` (two API renders + PCM splice) ran in
  a separate R process while the main session stayed live, completing in
  ~2–2.5 min with no tool-window overrun. This is the fix the project's Next
  Steps called for, now demonstrated four times over. Output remains 24 kHz
  mono (account PCM-tier ceiling), fine for voice comparison.
- **Close.** Kim: "good progress at just the right time." Casting settled for
  now; the next goal is to **test a completely different dialog**, deferred
  ~2 weeks (reminder set for 2026-06-21). Meanwhile Kim gets Dr. McClatchey's
  reaction.

### 2026-06-03 (evening — recast verified; point demonstrated)
Kim explored the ElevenLabs **V3 voice collection** (broader than the
48-voice account catalogue in voice_catalog.tsv), chose new voices for both
characters, and entered their **voice_ids directly** into Nike_challenge.cast.
He also made small sharpening edits to the dialog (more ellipsis pauses,
tightened lines). Re-rendered via the cast-as-file + WAV-assembly path.

- **Harness fix:** `el_resolve_voice()` now passes through any 20-character
  alphanumeric voice_id even when it isn't in the local catalogue — the
  catalogue is a convenience, not an allowlist. Needed because Kim's V3
  picks weren't in the account snapshot.
- **Verdict (Kim):** "Works very well. Nike is particularly good. Jones is
  acceptable — no longer flat." For a true production run he'd search voices
  further, but the **point is demonstrated: we can produce natural-sounding,
  emotional dialog.** He credited the voices and the dialog sharpening, and
  named the working pattern — "the original dialog was very good; I just did
  some sharpening; it's how we work together."
- **Tier note:** PCM at 44.1 kHz needs a higher ElevenLabs tier than this
  account; the WAV-assembly path falls back to 24 kHz (fine for voice; the
  account snapshot's MP3 path still renders at 44.1 kHz). A 44.1 kHz assembled
  final would mean MP3-part stitching (needs an audio lib for silence) or a
  tier bump — deferred.
- **Rendering reality (sharpens Finding 007):** this dialog is ~4 minutes of
  audio; a single render now overruns the Cowork tool window, so each render
  "times out" while completing in R. The reliable pattern used today: fire the
  render, poll for the result object, then assemble locally (no network). The
  real fix is **asynchronous rendering** (ClaudeR's async tools) — queued for
  the harness.
- **Still queued:** a three-voice dialog (narrator/third speaker) — Kim's
  noted next experiment for the engine, after some neglected projects and
  stories are done.

### 2026-06-03 (afternoon — second test; cast-as-file and WAV assembly added)
After a break, Kim returned with a new story (Nike_challenge) and asked for
a second test of the engine and the workflow. The session both stressed the
craft (a harder emotional shape) and matured the harness (two system
features) in response to Kim's feedback.

- **The dialog.** Nike (provisional PhD student, NIKE tattooed on her
  forehead, contemptuous of Western science as colonial) vs. Dr. Jones
  (the professor she shouted down in lecture, now meeting her in his
  office). Chosen as a *contrast* to the first test: an asymmetric
  power dynamic and a heat-vs-control register — Nike's sharp interruptions
  against Jones's longer measured lines — to test whether the engine can do
  restrained authority as well as hot emotion. Arc: the **hard bargain**,
  refined at Kim's direction so Jones resolves it by challenging Nike to
  *demonstrate her own view by doing a modern, ethical research program on
  the topic* — turning her grievance into a falsifiable proposal that also
  clears her provisional status. Drafted directly in canonical format
  (28 turns, 3,621 chars), chunked at the `[silence]` pivot into two parts.
- **Cast:** Nike = Nichalia Schwartz, Dr. Jones = Brian. Seed 42.
- **Kim's verdict.** "Passes the test." Emotion came through, Nike
  especially; Dr. Jones read a bit flat — Kim attributes it to the voice
  choice (Brian), which is exactly what the new cast-as-file workflow is
  for. Queued: try a weightier Jones voice next session.
- **Two system features added in response to Kim's feedback:**
  1. **Cast-as-file.** Voices now specified in a `*.cast` file beside the
     script (`SPEAKER = name-or-voice_id`), resolved against a written
     `voice_catalog.tsv` (all 48 voices). Trying voices is now edit +
     re-render, not an interactive prompt. (`el_load_cast`,
     `el_resolve_voice`, `el_read_catalog`.)
  2. **WAV assembly with real silence.** `el_assemble_wav()` renders chunks
     as PCM and splices them into one WAV with real silence at each seam and
     a 1-second tail — fixing the abrupt end Kim noted and making `[silence]`
     audible at last. Done in PCM (sample-accurate, no audio package).
     ClaudeR blocks Claude-run `system()`, so an in-process route (PCM +
     hand-written WAV header) was the way, not ffmpeg. `nike_full.wav` is the
     first assembled output.
- **Finding 007 captured.** Long R calls that bundle two API renders exceed
  the Cowork tool window and can drop the ClaudeR bridge (happened twice
  today); the work still completes in R, so verify the output rather than
  re-running. Rule: one network render per `execute_r` call. `el_assemble_wav`
  is the function that trips this and is queued for the split-render refactor.

### 2026-06-03 (reactivated; R/API rendering path operational; first dialog rendered)
Audio moved from Paused back to Active. Kim chose it as the day's focus;
the session reviewed the first-test materials, then built the rendering
path that the project had only anticipated.

What happened, in order:
- **Spec check.** Verified the current ElevenLabs Text-to-Dialogue (Eleven
  v3) input spec from the official docs. Key facts: speaker = per-turn
  `voice_id` (never in the text); delivery tags are natural-language in
  square brackets, inline; ≤ 2,000 chars total per request; nondeterministic
  (use `seed`). This retired two of the three notations in the working
  folder (the `<MIKO>` XML and the `[speaker=X voice=Y]`+`(cue)` forms).
- **Canonical format adopted.** `SPEAKER: [delivery] text`; tags carry
  delivery only; pauses → punctuation; bracket-only lines are structural
  beats/seams dropped from the sent text. Recorded in Working Conventions.
  The old `[shocked pause, then cold]` (emotion + pause + beat in one tag)
  was the worked example of the fix.
- **R harness built from scratch.** `elevenlabs_dialogue.R` in the Audio
  folder. Originally written with httr2, but the live session's curl
  (6.2.2) was older than httr2 1.2.2 needs (≥ 6.4.0) and updating curl
  needs compilation Kim avoids — so the harness was rewritten on the
  `curl` + `jsonlite` packages directly. Functions: `el_list_voices`,
  `el_parse_script`, `el_chunk_turns`, `el_render_dialogue`,
  `el_render_script`. Connect/timeout opts set after an initial SSL
  timeout.
- **First render.** The Tad/Miko dialog (`First_test_canonical.txt`)
  rendered end-to-end via the API, driven by Claude in Kim's live RStudio
  session through ClaudeR. Cast: Tad = Junichi (the one Japanese male
  voice in the catalogue), Miko = Laura (Enthusiast, Quirky Attitude).
  The 2,898-char dialog was chunked into three parts split at two dramatic
  seams — the strategy pivot after "In New York" (`[BREAK]`) and the
  climactic `[silence]` before "Then why are you here?" — yielding
  994 / 1,841 / 63-char parts (renders/first_test_part01–03.mp3).
- **Kim's verdict.** "Fantastic" — the emotions of both characters came
  through; the first seam worked well; the second is slightly rough only
  because the final part is so short (a per-dialog artifact, not a concern;
  an editor pass would smooth it). Flagged the speed gain from Claude
  driving the R/ElevenLabs interaction directly.

First substantive use of the ClaudeR live-execution interface (Finding 006)
on real project work, and a concrete instance of the PKM's "interface that
should not be static" — shared-file memory extended to shared live
computation. The first audible artifact of the audio project.

### 2026-05-10
Project file created. Intake protocol fired during PKM Operating
Protocol exercise. Audio-dialog workflow defined and conventions
crystallized after a session that began with an attempted TTS
smoke test, surfaced the Player extension config-substitution bug,
verified the Agents extension separately, and refined the actual
target workflow (Claude crafts text + ElevenLabs Studio renders).
Working notes drafted earlier in session migrated into this file's
Working Conventions section. Active Focus remains on housekeeping
audit; this audio work is a deliberate side thread. Color of the
Year queued as first real exercise of the workflow.

### 2026-05-28 (Audio working folder populated)
A working folder is now in place at G:\My Drive\Projects\Audio
with first-test materials: Story_background.txt (the narrative
context), First_test.txt (the first dialog draft), First_test.pdf
(rendered PDF view of the first draft), First_test_json.txt (JSON
export, likely for an ElevenLabs Studio import path), and
Eleven_tinytest.txt (a rendering smoke test). Kim's framing: this
is preparation for an eventual Gallery Collection audio product;
Color of the Year remains queued as a separate example.
Locations and Key Files sections updated. The Desktop\Audio
folder that was empty and deleted on 2026-05-27 is unrelated to
the new working folder — that earlier folder held no content.
See session_log.md 2026-05-28 and priorities.md.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Paused, Focus readiness Not applicable: early-stage
and deliberately suspended awaiting maturing TTS capability (Kim,
2026-05-30) — a named trigger, hence Paused (the new status this
session) rather than Dormant. The workflow is defined and a working
folder is in place; Color of the Year remains queued for when work
resumes. Part of the collection-wide back-fill; see proj_PKM.md and
session_log.md (2026-05-30).

### 2026-06-26 — "My Name Is Nike" PUBLISHED (fiction site)
The illustrated story is live at **kimbridges-fiction.netlify.app** (the new fifth content site; see proj_kimbridges_fiction.md). Tom Koch's review of the text: "It's a hell of a fine tale." **Source of record stays here** in Nike_challenge (`Nike_story.md`, `illustrations/`); the fiction site only cross-posts the finished, compressed PDF (0.61 MB). Final illustrated build = 25 pp with the Ch.5 Jones-paper plate and the Ch.8 trophy-case reflection closer.

### 2026-07-22 — Pronunciation-as-FRICTION thread opened (feeds AI Microscope + the name-heavy botany work)
Working on the AI Microscope (proj_AI_Microscope.md), Kim reframed **pronunciation as a form of FRICTION** — the same
lens as the briefing books — one that scales far past a dozen leaf-anatomy terms to the ~100 scientific names at a site
like Kīpuka Puaulu, and to any name-heavy field or medical vocabulary. The AI Microscope "pronunciation trigger" is
really a small **term explorer**: how to say it (audio + a friendly respelling), what its roots mean (etymology — e.g.
xylem <- Gk *xýlon* "wood"; shared roots like *-enchyma* unlock parenchyma / collenchyma / sclerenchyma at once), a
plain-English gloss, and the definition. IPA/CMU are **developer-side** fields (a hidden column in a botanical_lore-style
table) that tell ElevenLabs how to say the term — the student never sees them. Decision: **no pre-rendered audio cache**
— stay with live ElevenLabs generation (responsiveness is good; a file library would fight the clean edit->commit->deploy
loop; on-device TTS is close). Correctness therefore rides each live request via the pronunciation data, which re-raises
whether Flash v2.5 (the live model) honours phoneme tags.

**Anchor story (Kim — a keeper for the chapter):** his instructor **Cecil Johnson** taught him to learn a scientific name
by introducing it like a friend — *"This is my good friend, Hibiscadelphus giffardianus."* Social reframing dissolves the
fear of saying the name; it worked, and Kim still challenges people to say *Hibiscadelphus giffardianus*.

**Planned deliverable:** a **chapter on pronunciation friction** (in the AI Microscope doc and/or a broader piece serving
all the name work) — the friction framing, live-vs-stored-audio trade, IPA vs CMU (docs: CMU more predictable), the
Cambridge UK/US split, etymology-as-comprehension, and the operational point that there *is* a place defining how a term
is said.

**NEXT (this session): a standalone ElevenLabs test harness** — outside the AI Microscope, run via R/curl from Kim's
RStudio using ELEVENLABS_API_KEY (.Renviron). Matrix: terms (sclerenchyma, Syringa, parenchyma, *Hibiscadelphus
giffardianus*) x methods (raw / IPA phoneme tag / plain respelling) x models (eleven_flash_v2_5 vs eleven_turbo_v2);
outputs = labeled mp3s + an HTML listening panel; Kim judges by ear. Round 2 = pronunciation dictionary (alias + phoneme
rules), CMU, UK/US variants.

### 2026-07-22 (cont.) — Pronunciation test RESULT: turbo v2 honours IPA; sparse-override approach adopted
Ran the harness (24 clips, 0 failures; outputs in ~/pronunciation_test/ with listen.html). Kim's verdict by ear:
- **IPA phoneme tags work on `eleven_turbo_v2`; unreliable on `eleven_flash_v2_5`** (fails some of the time) — confirms
  the ElevenLabs doc limitation empirically. => generate pronunciation-controlled audio with **turbo v2**.
- **Approach adopted: a SPARSE IPA OVERRIDE table** — only terms the model mispronounces get an entry; well-said terms
  stay raw. Syringa: Kim prefers the **raw** turbo-v2 rendering (a 5-way variant A/B on turbo v2 confirmed it), so it
  stays OFF the list — the worked example of "only fix what's broken."
- Harness is reusable (curl + jsonlite from RStudio, ELEVENLABS_API_KEY). Round 2 when wanted: uploaded **pronunciation
  dictionary** (server-side overrides), **CMU** vs IPA, Cambridge **UK/US** variants. Integration into the AI Microscope
  term-explorer comes later. **pkm_findings candidate:** which ElevenLabs models honour phoneme/IPA tags (turbo v2 yes,
  flash v2.5 no).
