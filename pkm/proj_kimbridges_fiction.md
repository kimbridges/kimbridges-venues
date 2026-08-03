# PROJECT: kimbridges-fiction
_Last updated: 2026-07-28_
_Status: Standing_
_Focus readiness: Ready_

## Type
Website (Netlify) — new fifth content site

## Objective
A dedicated front door for Kim's **fiction**, distinct from the non-fiction
kimbridges-stories. Long-form imagined work presented as illustrated flipbooks,
built through human–AI collaboration. Seeded 2026-06-26 with two pieces:
**"My Name Is Nike"** (illustrated short story, 25 pp) and **"Orbits"**
(novel-length, 183 pp, cross-posted from the Collections Gallery).

## Current Status
**LIVE 2026-06-26 at https://kimbridges-fiction.netlify.app** — the fifth content
site is up, with two pieces published as illustrated flipbooks: **My Name Is Nike**
(25 pp, ~0.6 MB compressed) and **Orbits** (183 pp). The hub (kimbridges.info) was
re-rendered and redeployed, so the **Fiction front door is live** too: a landing-grid
card (Stories · Fiction · Documents · Collections), a navbar item, and the
`fiction.qmd` gateway. The site is a faithful clone of the kimbridges-stories
mechanism (Quarto website + the PDF.js flipbook `viewer.html`); add a piece via the
same workflow (PDF in pdfs/, thumbnail in images/, stub in works/, render, deploy).

## Locations
- **Canonical source (the site)**: G:\My Drive\kimbridges-fiction
- Netlify: https://kimbridges-fiction.netlify.app  *(live 2026-06-26)*
- Hub link: https://kimbridges.info → Fiction (fiction.qmd gateway)
- **Per-piece source of record (the site only cross-posts finished PDFs; it does
  not own the source):**
  - *My Name Is Nike* → G:\My Drive\Projects\Audio\Nike_challenge\ (story `Nike_story.md`,
    `illustrations/`, the build in the Cowork outputs; the story was born there as the
    Nike_challenge TTS test, so its history lives with proj_audio.md).
  - *Orbits* → G:\My Drive\kimbridges-collections\Gallery\Tad_Adventures\ (part of the
    Gallery "AI capabilities over time" collection).
- **Future native-fiction** (pieces conceived as fiction, not as a side-effect of
  another project) should live under **kimbridges-fiction\underway\<name>\**, mirroring
  the kimbridges-stories\underway\ convention. *(Convention proposed 2026-06-26; create
  on first new piece.)*

## Key Files
- _quarto.yml — Quarto website config (title "Kim Bridges — Fiction"; renders index.qmd + works/*.qmd; resources pdfs/** + viewer.html)
- index.qmd — grid listing page over `works/`
- works/*.qmd — one stub per piece (YAML: title, subtitle, date, categories, image, pdf; body = blurb + Pages + viewer iframe)
  - works/my-name-is-nike.qmd
  - works/orbits.qmd
- viewer.html — PDF.js two-page-spread flipbook (parameterized via ?pdf=), cloned from kimbridges-stories
- custom.css — card-thumbnail styling (contain, no crop)
- pdfs/*.pdf — My_Name_Is_Nike.pdf (19.2 MB), Orbits.pdf (15.9 MB)
- images/*.{jpg,png} — card thumbnails (My_Name_Is_Nike.jpg = the stark NIKE portrait; Orbits.png = the Orbits cover)

## Architecture
- Quarto website (type: website), cosmo theme — consistent with the other four sites
- Grid listing over `works/`; each card links to its stub page, which embeds the
  flipbook viewer in an iframe (`../viewer.html?pdf=FILE.pdf`)
- PDFs served from pdfs/ at site root (viewer builds path `pdfs/` + filename)
- Same mechanism as kimbridges-stories — add a piece = drop the PDF in pdfs/, a
  thumbnail in images/, a stub in works/, then render + deploy

## Workflow: Adding a new fiction piece
1. Place the PDF in pdfs/ and a cover thumbnail in images/
2. Create works/<slug>.qmd (copy an existing stub; set title/subtitle/date/categories/image/pdf, blurb, Pages, iframe)
3. `quarto render`
4. Drag _site/ onto the kimbridges-fiction Netlify site's Deploys tab

## Deploy / handoff (first publish — Kim's steps)
1. **Render the fiction site:** in G:\My Drive\kimbridges-fiction, run `quarto render` (→ _site/).
2. **Create the Netlify site:** in the Netlify dashboard, add a new site named **kimbridges-fiction**, then drag the **contents of _site/** onto its Deploys tab. (Per Finding 008 / the documents-site gotcha: deploy the contents of _site, not the folder; and make sure the two PDFs are materialized — not Drive-stream placeholders — before dragging.)
3. **Re-render + redeploy the hub:** in G:\My Drive\kimbridges-info, `quarto render`, then drag its _site contents to the existing kimbridges.info Netlify site so the Fiction front door goes live.

## Collaborators / Dependencies
Depends on the hub (kimbridges-info) for the front door; cross-posts Orbits from kimbridges-collections.

## Blockers
None (first render + Netlify site creation are Kim-side steps).

---
## Log
### 2026-06-26 (site built in draft; the flagged "Fiction" category becomes real)
Acted on the idea flagged 2026-06-25 (project_index.md): a distinct Fiction
front door. Kim chose a **standalone site** (over a section of stories/hub) and
**the illustrated PDF as-is** as the presentation. Built the site as a faithful
clone of the kimbridges-stories flipbook mechanism and seeded it with **"My Name
Is Nike"** (this week's illustrated build, 25 pp; Tom Koch's text review: "a hell
of a fine tale") and **"Orbits"** (the 183-pp Gallery novel, cross-posted from
Collections). Hub updated with a Fiction gateway (fiction.qmd), a navbar item,
and a fourth content card on the landing grid. Source complete on Drive; first
render + Netlify site creation are the remaining Kim-side steps (no Quarto in the
Cowork sandbox). See session_log.md 2026-06-26 and proj_audio.md (the Nike build).

### 2026-06-26 (LIVE — deployed; Netlify AI-onboarding gotcha; Nike PDF compressed)
Kim rendered both sites and deployed. The site is **live at
kimbridges-fiction.netlify.app** with both pieces, and the hub's Fiction front door
is live. Three notes: (1) **Netlify's "Add new project" now routes a typed description
into an AI agent builder** (Agent Runners — it literally spun up a Claude Code session
that generated a placeholder site) — see **pkm_findings.md Finding 011**; the bypass is
**app.netlify.com/drop** or the existing-site **Deploys** dropzone. (2) The Nike PDF in
the site's pdfs/ was still the 19 MB copy; compressed to **0.61 MB** via Ghostscript in
the sandbox (`-dPDFSETTINGS=/ebook`, images downsampled to 150 dpi — the fine two-column
Ch.5 journal text stays legible) and placed in the **source** pdfs/ so it's durable across
re-renders. (3) Clarified a stale caution: for Netlify **drag-and-drop**, dropping the
`_site` *folder* is fine (Netlify uses its contents as root); the "contents, not the
folder" rule was Finding 008's *file-copy* nesting case, not drag-and-drop.
