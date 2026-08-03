# PROJECT: AI_Podcasts
_Last updated: 2026-08-02_
_Status: Complete_
_Focus readiness: Not applicable_

## Type
Quarto book (multi-chapter document), published

## Objective
A document about making podcasts with NotebookLM: what the tool does, what it
produces, and eleven worked examples across travel, science, and code. The
experiments date from September 2024, when NotebookLM's two-voice audio overview
was new. Errors in the generated audio were deliberately left in.

## Current Status
Complete and live at https://kimbridges-documents.netlify.app/ai_podcasts/
(deployed 2026-08-02, audio confirmed playing by Kim).

Two things happened on 2026-08-02. The source moved off the OneDrive Desktop into
`Projects/AI_Podcasts`, and all ten SoundCloud iframes were replaced with plain
HTML5 `<audio>` elements served from the venue itself. SoundCloud no longer hosts
any Kim audio. The `.wav` masters are on Drive at `Projects/Audio/podcast_masters`.

## Locations
- Source: G:\My Drive\Projects\AI_Podcasts
- Audio (mp3, deployed): G:\My Drive\Projects\AI_Podcasts\audio (10 files, 30 MB)
- Masters (wav/m4a): G:\My Drive\Projects\Audio\podcast_masters (12 files, 361 MB)
- Build output: G:\My Drive\Projects\AI_Podcasts\_output
- Published copy: G:\My Drive\kimbridges-documents\ai_podcasts
- Listing card: G:\My Drive\kimbridges-documents\docs\ai_podcasts.qmd
- GitHub: not yet

## Key Files
- _quarto.yml — book config; `resources: audio/**` carries the mp3s into `_output`
- index.qmd — what a podcast is, how NotebookLM makes one
- Travel.qmd — Napa, Bordeaux (x2), Japan (4 audio)
- Scientific.qmd — species problem, Gould, Miller's seven, Platt, Diamond (5 audio)
- Code.qmd — the long one, 25:36 (1 audio)
- _backup/ — pre-edit .qmd copies and the retired `_publish.yml`

## Deploy chain
kimbridges-documents uses the RESOURCES model, not the parent-render model:
1. `quarto::quarto_render(input = "G:/My Drive/Projects/AI_Podcasts")` → `_output`
2. copy `_output/*` → `kimbridges-documents/ai_podcasts/`
3. `quarto::quarto_render(input = "G:/My Drive/kimbridges-documents")`
4. drag `kimbridges-documents/_site` to Netlify
Step 2 is manual and easy to forget. Editing the .qmd alone changes nothing live.

## Related Projects
- proj_audio.md — the wider audio/TTS thread; masters now live in that project's folder
- proj_kimbridges_documents.md — the venue this publishes into
- proj_kimbridges_collections.md — Gallery Catalog, the other SoundCloud host (also done)

## Next Steps
1. **ISSUU — probed 2026-08-02, and the picture is not what it looked like.** Kim
   deleted the ISSUU account years ago after an abrupt price rise; three of the five
   documents are nonetheless STILL LIVE (`finding_fine_wine`, `bordeaux`,
   `chatgpt_examples`) and two are 404 (`bordeaux_2`, `2023_japan_story`). So the
   Travel.qmd pointers are two already-broken links plus two pointers into content
   that can disappear without notice — a one-way door Kim reasonably believes is
   already shut. **Recover the three live documents before repointing anything.**
   `2023_japan_story` is fixable today: the local PDF exists at
   `Desktop\Podcasts\2023_Japan_Story.pdf` — text-only by design, ~40 pp, the exact
   file fed to NotebookLM — so point Travel.qmd at `viewer.html?pdf=...` now.
   `bordeaux_2` has no known source and is the one real gap. See deferred.md.
2. Delete the Desktop originals once Kim confirms — `Desktop\AI_Podcasts` (source,
   fully copied) and the 12 masters in `Desktop\Podcasts` (byte-verified on Drive).
3. `styles.css` is named in `_quarto.yml` but does not exist. Harmless; Quarto
   ignores it. Remove the line or add the file.

## Collaborators / Dependencies
None.

## Blockers
`bordeaux_2` only — 404 on ISSUU with no local source found. The other four ISSUU items are actionable: `2023_japan_story` has its PDF in hand, and the three live documents can be recovered from ISSUU while they still resolve.

---
## Log

### 2026-08-02
Project file created. Source relocated from `C:\Users\kim\OneDrive\Desktop\
AI_Podcasts` to `Projects/AI_Podcasts` (10 files, byte-verified; `_output`,
`.quarto`, `.Rproj.user`, `.Rhistory` left behind). Ten SoundCloud iframes replaced
with `<audio>` elements; two iframe SHAPES were present (one-line in Travel.qmd,
seven-line in Scientific/Code) and a single block detector produced overlapping
ranges on Travel — caught in a dry run before writing. A tail-slice bug appended an
`NA` line and a stray `</div>` to Scientific.qmd; caught by line-count
reconciliation, see Finding 023.

Dead link fixed at source: Code.qmd L3 pointed at `kim.quarto.pub/r_code/`, now
`https://kimbridges-documents.netlify.app/using_an_llm/` (target verified live
before editing). `_publish.yml`, which declared a Quarto Pub target, retired to
`_backup/`.

Installed into kimbridges-documents: 36 files copied, `ai_podcasts/**` added to
`resources:`, listing card written with a new `Audio` category. Site render took
`_site` from 1005 to 1042 files, 0 removed. Kim deployed and confirmed the audio
plays.
