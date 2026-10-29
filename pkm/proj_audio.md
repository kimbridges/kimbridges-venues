# PROJECT: Audio
_Last updated: 2026-07-22_
_Status: Active_
_Focus readiness: Ready_
_Log: logs/proj_audio_log.md_

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
- Renders: G:\My Drive\Projects\Audio\First_test\renders\ — rendered MP3 output
  (first_test_part01–03.mp3 from the 2026-06-03 session). _Corrected 2026-10-28: the folder
  is G:\My Drive\Projects\Audio\First_test\renders\ -- it sits inside First_test\, not at
  the Audio root (health-check drift)._
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

The dated log for this project lives in `logs/proj_audio_log.md`. Verbatim and unedited.
New entries go there, not here. (Split 2026-10-28.)

