# Publishing Workflow: Structural Design
_Created: 2026-04-06_

## Purpose

This document captures the architectural decisions and procedural design
for managing Kim's full body of published work. It covers project types,
publishing platforms, website roles, folder conventions, and the
automation cascade that connects them.

This is a living reference. It will be updated as the system is
implemented and refined.

---

## Two Types of Projects

All current and future work falls into one of two categories:

### Tool Projects
R packages and functions shared with collaborators.

Lifecycle: develop functions → package for R → push to GitHub →
write Quarto documentation → publish docs → list on kimbridges.info

Completion criteria: GitHub repo exists, Quarto documentation published,
entry on kimbridges.info/documents with links to both.

Examples: milestones, plainmaps, sitemaps, geContour, gePoints,
timelinesr, photoPress, accessOAI, tinypedigree

### Exploration Projects
AI capability demonstrations, photo essays, analytical narratives,
travel stories. These document the state of the art or present
integrated word-and-image content.

Lifecycle: create content → produce deliverables (PDF, video, audio,
Quarto site) → publish to appropriate platform → list on appropriate
website

Completion criteria: varies by project, but always ends with publication
and a website listing that makes the work discoverable.

Sub-categories:
- AI explorations (Gallery Catalog, AI Podcasts, Colors of the Year)
- Photo/travel essays (magazine stories, Exposure stories)
- Research narratives (Bloedel Reserve analyses, Deconstructing a Flora)

---

## Publishing Platforms

Seven platforms currently in use, each serving a distinct function:

| Platform | URL | Purpose | Technology |
|----------|-----|---------|------------|
| GitHub | github.com/kimbridges | R package source code | Git |
| Netlify | kimbridges.info | Hub site — central index | Quarto |
| Netlify | kimbridges-stories.netlify.app | 50 PDF stories with flipbook viewer | Quarto |
| Netlify | kimbridges-documents.netlify.app | 13 rendered HTML documents | Quarto |
| Netlify | kimbridges-collections.netlify.app | Curated multimedia sets | Quarto |
| Quarto Pub | kim.quarto.pub | Legacy R tool docs + AI explorations | Quarto |
| YouTube | youtube.com/channel/UCY... | Video content | YouTube |

Legacy platforms (still referenced but not primary):
- hflip (kim.hflip.co) — page-flip PDF viewing, replaced by self-hosted PDF.js viewer
- Exposure (kimbridges.exposure.co) — short photo essays, future unclear
- ISSUU — replaced by hflip, then by self-hosted viewer

Note: The self-hosted PDF.js flipbook viewer is now live on
kimbridges-stories and kimbridges-collections. The hflip goal
from earlier planning has been achieved.

---

## Two Websites and Their Roles

### kimbridges.com (Squarespace)
Public identity and creative portfolio.

Audience: broad — friends, colleagues, general public.
Content: photography, travel, stories (magazine + Exposure), video,
DNA Music, research/teaching history.
Question it answers: "Who is Kim Bridges and what does he create?"

Design direction: make more static. Reduce the maintenance burden by
removing the rotating gallery or updating it infrequently. Keep the
stable sections (Research & Teaching, Travel, DNA Music) as the
backbone. The Stories page remains as the catalog of creative work
but does not need frequent structural updates.

Update frequency: occasional. New creative stories added as completed.

### kimbridges.info (Quarto on Netlify)
Central hub connecting all technical and creative work.

Audience: specific — collaborators, R users, people following AI work.
Content: five components — Stories, Documents, Collections, Schedule, Following.
Question it answers: "What has Kim built, and where do I find it?"

Architecture (as of May 2026): kimbridges.info is a lightweight hub.
It does not host content directly. Three gateway pages link out to
separate Netlify sites (stories, documents, collections). Two local
pages (schedule, following) hold editable content. A profile photo
appears on the landing page.

The three content sites are:
- kimbridges-stories.netlify.app — 50 PDF stories with flipbook viewer
- kimbridges-documents.netlify.app — 13 rendered HTML documents
- kimbridges-collections.netlify.app — curated multimedia sets (Gallery Collection)

Update frequency: gateway pages rarely change. Schedule and Following
are updated as needed. Content updates happen on the individual sites.

---

## Standard Project Folder Structure

Each project lives in one folder on Google Drive, mapped one-to-one
to a proj_*.md file in the PKM system.

```
proj_[name]/
  R/                  — source functions (tool projects)
  data/               — test/example data
  quarto/             — documentation source (.qmd files, _quarto.yml)
  output/             — generated reports, PDFs, images
  notes/              — scratch work, decisions, dead ends
  session_notes.md    — structured log of working sessions (see below)
  banner.png          — required visual for kimbridges.info listing
```

For exploration projects, the R/ folder may be absent or replaced
by content-specific folders (images/, audio/, video/).

The quarto/ subfolder is critical: this is where the .qmd source
files live. These files should also be committed to the GitHub repo
(in a docs/ or quarto/ folder) for version control and reproducibility.

---

## The Automation Cascade

The goal: a single action at a project milestone triggers updates
that propagate through the system.

### Trigger
A project reaches a milestone (e.g., pushed to GitHub, Quarto docs
published). The proj_*.md file in the PKM is updated with new status
and log entry.

### Step 1: PKM Update
The proj_*.md file is the source of truth. It records:
- Current status
- Links to GitHub repo, published documentation, website listing
- Banner image filename
- Date of last update

### Step 2: Generate kimbridges.info/documents page
An R script reads all proj_*.md files from Projects_Index/.
It filters for projects that have published documentation or GitHub
repos. It generates the documents.qmd file for kimbridges.info,
organized by category (AI-related, Research-related, Tool documentation).
Each entry includes: title, description, banner image, and links.

The script enforces completeness: if a project has a GitHub repo but
no documentation link, or no banner image, it flags the gap.

### Step 3: Generate summary for kimbridges.com
A simpler output — a markdown or HTML fragment listing recent
additions. This can be manually pasted into Squarespace or,
eventually, pulled automatically.

### Implementation language
R is the natural choice. The script would use packages already
familiar: readLines or readr for file reading, string processing
for parsing the markdown headers, and cat/writeLines for output.

### Not yet implemented
This cascade is designed but not built. The immediate priority is
completing the inventory and organizing project folders. The
automation script is a Phase 2 deliverable.

---

## Session Notes: Capturing Conversations for Documentation

### The Problem
Working sessions between Kim and Claude produce the raw material for
documentation — rationale, design decisions, edge cases, and working
examples. But this material is trapped in unstructured conversation
transcripts, disconnected from the project. By the time code is
complete, the documentation must be reconstructed from memory.

### The Solution
Each project folder contains a `session_notes.md` file. At natural
breakpoints during a session (or at session end), a structured entry
is written. These entries accumulate into a documentation-ready log
that maps directly onto Quarto document chapters.

### Session Notes Entry Structure

```
### Session: [date]
#### Topic: [short description of what was worked on]

**Motivating problem:** What real-world situation prompted this work?
This is the origin story — often the seed of the best example.

**Discussion:** Condensed summary of approaches considered, trade-offs
discussed, and why the chosen path was selected. Not a transcript;
a distillation.

**Decision:** The specific technical choice made.

**Example produced:**
[Complete, runnable code example with realistic data. Includes the
setup, the function call, and the expected output or visualization.
Always self-contained — a reader should be able to copy and run it.]

**Example data source:** [URL, file reference, or description of
where the example data comes from. Captured here so it isn't lost.]

**Documentation target:** Which chapter or section of the eventual
Quarto document this material feeds into. Explicit mapping from
session work to published output.

**Assets created:** Any files produced during the session that should
be preserved — plots, test data files, intermediate outputs.
```

### Why This Works
The session notes serve three functions simultaneously:

1. They are a development log (what was done and why).
2. They are a documentation outline (material pre-sorted by chapter).
3. They are an example library (working code ready to drop into .qmd).

When documentation time arrives, the task shifts from "write the docs"
to "assemble and edit the docs from existing material."

### Examples as First-Class Citizens
The motivating problem that launches a project is itself the first
example. It should be captured in the very first session notes entry,
before any code is written. This inverts the usual sequence — examples
are not an afterthought added during documentation but artifacts
collected from the beginning.

As development proceeds, additional examples emerge naturally:
edge cases that were tested, alternative data sources that were
tried, collaborator use cases that were discussed. Each gets captured
in session notes with its data source and documentation target.

By project completion, the example library is already built.

### Relationship to PKM Project Files
The proj_*.md file tracks project status and milestones.
The session_notes.md file tracks the working detail.
They are complementary: the PKM file tells you where a project
stands; the session notes tell you how it got there and provide
the material to document it.

---

## Quarto Document Template

### Standard _quarto.yml
A template _quarto.yml file is maintained in Projects_Index/ (or a
templates/ subfolder) and copied into each new project's quarto/
folder. This enforces visual and structural consistency across the
entire document collection.

The template specifies: project type (book), output format (html),
theme, author, table of contents settings, code display options
(code-fold, code-copy), and any shared CSS or formatting preferences.

The specific settings should be derived from the existing published
documents on kim.quarto.pub to ensure continuity with the established
collection.

### Standard Chapter Structure
Based on the pattern observed across existing documents (Plainmaps,
Gallery Catalog, Milestones, Sitemaps, etc.):

1. Preface — why this exists, what problem it solves, who it is for.
   Sourced from: first session notes entry (motivating problem).

2. Introduction / Setup — packages required, installation, data
   preparation. Sourced from: early session notes on environment.

3. Topic chapters (one per major feature or capability) — each built
   around one or more code examples with explanatory text. Sourced
   from: session notes entries with matching documentation targets.

4. Closing / Next Steps — what the reader can now do, where to go
   for more. Sourced from: project status and roadmap in proj_*.md.

Each chapter follows the pattern: context (why you need this),
code chunk (how to do it), output (what you get), interpretation
(what it means). This mirrors the session notes structure directly.

---

## Quarto Source File Policy

Going forward, Quarto source files (.qmd, _quarto.yml, supporting
images and data) are stored in two places:

1. The project folder on Google Drive (quarto/ subfolder) — working copy
2. The GitHub repo (docs/ or quarto/ folder) — version-controlled copy

This ensures reproducibility and backup. Existing projects that lack
this structure should be retrofitted as folders are organized.

---

## Website Update: kimbridges.info/documents

The Document Links page should be reorganized into these sections:

### R Tool Documentation
Each entry: package name, one-line description, banner image,
link to Quarto docs, link to GitHub repo.

### AI Explorations
Each entry: project name, one-line description, banner image,
link to Quarto docs or other published form.

### Standalone Documents
For documents that don't map to a GitHub repo (e.g., R Programming:
Basics Made Simple, Citations).

This page becomes the single authoritative index of Kim's technical
and analytical output.

---

## Open Questions

1. ~~Should the page-flip PDF stories eventually move to kimbridges.info?~~
   RESOLVED: Stories are on kimbridges-stories.netlify.app with self-hosted viewer.
2. What is the future of the Exposure.co stories? Are they stable,
   or should they be migrated?
3. bridges.kim is listed on kimbridges.info — what is its current
   role and should it be consolidated?
4. ~~Self-hosted page-flip: is this a near-term goal or a someday/maybe?~~
   RESOLVED: Self-hosted PDF.js flipbook viewer is live on stories and collections sites.

---

## Log

### 2026-04-06
Document created from design session. Captures two-project-type model,
two-website strategy, folder conventions, automation cascade concept,
and Quarto source file policy. Inventory document created separately
as inventory_all_projects.md.

### 2026-04-08
Added Session Notes specification — structured capture of working
session content for documentation pipeline. Added examples-as-first-
class-citizens principle: the motivating problem is the first example,
captured before code is written. Added Quarto document template
section covering standard _quarto.yml and chapter structure derived
from existing published documents. Updated folder structure to
include session_notes.md.

### 2026-05-07
Major update to reflect implemented architecture. Netlify is now the
primary hosting platform with four sites: kimbridges.info (hub),
kimbridges-stories, kimbridges-documents, kimbridges-collections.
Self-hosted PDF.js flipbook viewer replaces hflip. Updated platform
table, website roles section. Resolved two open questions (PDF story
hosting, self-hosted page-flip). hflip, Exposure, and ISSUU moved
to legacy status.
