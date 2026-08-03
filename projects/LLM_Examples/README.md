# Experiments with LLMs — HELD FOR PUBLICATION
_Staged 2026-08-02. Not yet published. See deferred.md._

## Why this folder exists

This document had **no venue home**. It was live on exactly two platforms, both of
which are ending:

- **ISSUU** — `issuu.com/kimbridges/docs/chatgpt_examples`. Kim deleted this account
  years ago after an abrupt price rise. The document is nonetheless STILL SERVING as of
  2026-08-02, which means it can vanish at any time with no notice.
- **hflip** — `kim.hflip.co/llm_examples.html`. Cancelled 2026-07-31; **stops serving
  around FEBRUARY 2027.** That is the real deadline.

Until 2026-08-02 the only other copies were loose in `C:\Users\kim\Downloads`.

## What is here, and which one is canonical

| file | pages | dated | notes |
|---|---|---|---|
| `LLM_Examples_2024-01-11_130pp_CANONICAL.pdf` | 130 | 2024-01-11 | **most complete — use this one** |
| `LLM_Examples_2024-01-02_113pp.pdf` | 113 | 2024-01-02 | what `inventory_all_projects.md` recorded |
| `Experiments_with_ChatGPT_2023-11-20_77pp.pdf` | 77 | 2023-11-20 | earlier title: *Experiments with ChatGPT*, singular model |
| `LLM_Examples_extract_2024-01-11_7pp.pdf` | 7 | 2024-01-11 | a short extract about GPTs; not the full document |

**Version strings do not distinguish these.** Both the 113 pp and the 130 pp files
carry "Version 4: January 1, 2024" on the cover. The 130 pp file is a revision issued
nine days later whose cover was never updated. **Go by page count, not by the stated
version.** The inventory's "113 pages" is therefore stale, not wrong-at-the-time.

Original filenames before staging: `LLM_Examples (1).pdf`, `LLM_Examples.pdf`,
`ChatGPT_Examples.pdf`, `LLM_Examples_extract.pdf` — all from `Downloads`.

`LLM_Examples_cover.jpg` was rescued from `kimbridges-stories/images/`, where it had
been staged as an orphan cover — a story intake that was started and abandoned. **The
original intent was to publish this on the STORIES site.** Kim decided 2026-08-02 that
it belongs in **documents** instead: it is a compilation of academic-oriented tests, not
a travel narrative.

## What Kim said about it (2026-08-02)

> "It is an important milestone in early LLM development and it sets out a lot of
> academic-oriented tests (most of which are passed very well). This should be an
> addition to the documents set."

## THE SOURCE EXISTS — found 2026-08-03

The PDF's producer string is **`Skia/PDF m122 Google Docs Renderer`**. It was exported
from a Google Doc, and that Doc is still in Kim's Drive:

- **`LLM_Examples`** (Google Doc)
- id `1QHAI5d0GW1aVuXQ4j2By9eLAY4lfZT3kRNslb0aB2HM`
- created 2023-01-05, **last modified 2024-01-12** — one day after the 130 pp export,
  which is consistent with it being the master for the canonical PDF
- https://docs.google.com/document/d/1QHAI5d0GW1aVuXQ4j2By9eLAY4lfZT3kRNslb0aB2HM/edit

**This retires the "no source to convert from" objection.** The earlier framing here --
that a Quarto rebuild meant reconstructing a finished document out of its own PDF -- was
written before the producer string was read. It is wrong, and the three routes below
should be re-weighed against that.

The Doc exports as markdown with the heading levels already correct (`# Writing
Assistance`, `## Dictation`) and an anchored table of contents. Kim's own convention,
stated in the Dictation section, is that **his comments and prompts are BOLD and the LLM
responses are normal font** -- bold survives a markdown export, so the prompt/response
distinction converts rather than being lost.

### Measured shape (from the canonical PDF, 2026-08-03)

| | |
|---|---|
| pages / words | 130 / 39,489 (avg 304 words per page) |
| structure | 13 top-level sections, ~57 subsections; heights 22 and 17 vs body 12 |
| image-only pages | **0** — the lowest-text page still has 12 words |
| embedded image objects | 17 |
| left margins | x=72 (Kim's voice, 988 lines) and x=108 (LLM response, 1523 lines) |

A text-dominant, cleanly-sectioned document. This is close to the best case for a
conversion.

## The open question for the publication task

Kim: *"I'm not sure if its current structure supports the multi-chapter style of the
documents."* Every other item in kimbridges-documents is a rendered Quarto book. Three
routes, re-weighed now that the source is known to exist:

1. **Full Quarto rebuild from the Google Doc** — export to markdown, split the 13
   sections into chapters, fix bold/indent conventions into consistent styling. Now the
   strongest option, not the most expensive one. Gives search, a chapter TOC, and a
   document that can be extended when Kim runs new tests.
2. **Hybrid** — a short Quarto landing chapter wrapping the PDF in `viewer.html`.
   Fastest. Kim chose this on 2026-08-02, *before the source was found*.
3. **PDF-in-viewer only** — publish the PDF as stories and collections do. Faithful, but
   the only non-Quarto item in the documents venue.

### The content-creep question (Kim, 2026-08-03)

*"This 'document' kept getting small additions as I tried new things."* That is visible
in the artifact: 77 pp (Nov 2023, *Experiments with ChatGPT*) -> 113 pp (Jan 2) -> 130 pp
(Jan 11). A rebuild is therefore also a chance to reorganise -- but reorganising is
EDITORIAL work only Kim can drive, and it is separable from the conversion. **Convert
first, reorganise second, as two tasks.** Merging them is how a two-day job becomes a
two-week one.

## Depends on this

`Projects/LLM_Creates_R` → published as `using_an_llm/Resources.qmd` L70 still links to
`issuu.com/kimbridges/docs/chatgpt_examples`. That is the LAST non-historical legacy
link in any venue. It gets repointed when this publishes.
