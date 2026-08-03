# PROJECT: LLM_Examples
_Last updated: 2026-08-03_
_Status: Complete_
_Focus readiness: Not applicable_

## Type
Quarto book (converted from Google Docs), published

## Objective
*Experiments with LLMs — Early tests on the utility of Large Language Models.* A record
of systematic LLM testing begun January 2023, covering writing assistance, statistics,
data grubbing, academic activities, travel, lyrics, poems, image processing and GPTs.
Kim, 2026-08-02: *"an important milestone in early LLM development... it sets out a lot
of academic-oriented tests (most of which are passed very well)."*

## Current Status
Complete and live at https://kimbridges-documents.netlify.app/llm_examples/ as the 22nd
document (deployed 2026-08-03).

Until 2026-08-02 this document had **no venue home at all** — it existed only on ISSUU
(account deleted years ago, still serving) and hflip (cancelled, ends ~Feb 2027), with
loose PDFs in `Downloads`. It was the single most exposed item in the system.

## The conversion

**The PDF's producer string was `Skia/PDF m122 Google Docs Renderer`.** Reading it
located the live Google Doc source and turned a reconstruction job into a conversion:

- Source Doc: `LLM_Examples`, id `1QHAI5d0GW1aVuXQ4j2By9eLAY4lfZT3kRNslb0aB2HM`,
  created 2023-01-05, last modified 2024-01-12 — **left untouched by Kim's decision**
- Exported to `.docx` via googledrive, converted with pandoc, split at the 12 H1 sections
- Verified: 57 H2 subsections matched the PDF exactly; 41,543 words vs 39,489 of PDF
  text; all 15 images extracted and every reference resolves
- **Kim's bold convention survived** — prompts and comments bold, LLM responses normal —
  which a PDF reconstruction would have lost

Dropped in conversion, all print-era furniture and all disclosed in the preface: the
duplicated title block, a repeated cover-art credit, and "Use the Table of Contents to
jump to an example of interest" (this edition has a live sidebar).

**The text was NOT revised or reorganised.** Kim's content creep — 77 pp (Nov 2023,
titled *Experiments with ChatGPT*) → 113 pp (Jan 2) → 130 pp (Jan 11) — is preserved as
written. Reorganising is editorial work only Kim can drive and was deliberately kept as
a separate, unscheduled task.

## Locations
- Source (book): G:\My Drive\Projects\LLM_Examples
- Google Doc master: docs.google.com/document/d/1QHAI5d0GW1aVuXQ4j2By9eLAY4lfZT3kRNslb0aB2HM
- Exported working copy: Projects\LLM_Examples\source (docx + md + media)
- PDFs of record: Projects\LLM_Examples\pdfs (4 versions, canonical = 130 pp)
- Build output: Projects\LLM_Examples\_output
- Published copy: G:\My Drive\kimbridges-documents\llm_examples
- Listing card: kimbridges-documents\docs\llm_examples.qmd
- GitHub: not yet

## Key Files
- _quarto.yml — book config, 12 chapters plus preface
- index.qmd — preface; carries the "About this edition" note
- 01..12_*.qmd — the twelve sections, filenames derived from the H1 headings
- README.md — provenance, version trap, and the routes considered

## Related Projects
- proj_LLM_Creates_R.md — its `Resources.qmd` held the last legacy link, repointed here
- proj_kimbridges_documents.md — the venue
- proj_AI_Podcasts.md — the other document rescued off a dying platform this week

## Next Steps
1. **Editorial reorganisation (unscheduled, Kim-driven).** The document accreted over a
   year. A pass could group or retire the weaker early tests — but only Kim can judge
   which those are.
2. Consider a 2026 afterword. The preface says these tests "now seem relatively
   unsophisticated"; that was written in Jan 2024 about Jan 2023 work, and is even more
   true now. The historical value grows with the gap.
3. hflip and ISSUU copies can now be abandoned without loss.

## Collaborators / Dependencies
None.

## Blockers
None.

---
## Log

### 2026-08-03
Converted and published. Kim chose the full Quarto rebuild over the hybrid route he had
picked the previous day — that earlier choice was made before the Google Doc source was
found, and the README records the correction rather than overwriting it. Kim also chose
to export a copy and leave the Doc untouched, treating it as a dated 2024 artifact.

googledrive needed an interactive OAuth grant, which the R bridge cannot do; Kim ran
`drive_auth()` in the RStudio console once. Token now cached at `~/.R/gargle-cache`
(on the C: HOME, not OneDrive) and persists for future sessions.

Kim on reading the result: *"I found myself enjoying a re-read of this material."*
