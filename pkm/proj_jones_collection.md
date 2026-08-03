# PROJECT: The Jones Collection
_Last updated: 2026-05-30_
_Status: Complete_
_Focus readiness: Not applicable_

## Type
Collection (AI-assisted historical recovery) — published

## Objective
Recover the wildlife observations of Robert D. Jones Jr. ("Sea
Otter Jones"), Refuge Manager at Izembek NWR and Aleutian
Islands NWR from 1948 to 1974, from 38 narrative reports
(~1,300 pages) that existed only as degraded typewritten scans.
Use a vision-language OCR model (olmOCR-2-7B) combined with AI
contextual interpretation to produce structured, navigable
products — data, maps, narratives, interactive tools — that make
Jones' observations available for contemporary research.

The collection serves a second purpose: demonstrate that this
recovery methodology is replicable for other historical field
records, particularly within ethnobiology.

## Current Status
Complete and live. Published 2026-05-05 at
https://kimbridges-collections.netlify.app/jones.html.
Per Kim (2026-05-07): the collection is finished. Kim plans to
write the AI session organizer at the International Society for
Ethnobotany and point him at this collection as a workshop
reference.

## Locations
- Live site: https://kimbridges-collections.netlify.app/jones.html
- Hub link: https://kimbridges.info → Collections → Jones
- Working copy: C:\Users\Kim\kimbridges-collections (within the
  collections site project)
- Source materials and intermediate files: location not yet
  recorded in PKM — to be confirmed if work resumes

## Key Files
Collection page assets (within kimbridges-collections):
- jones.qmd — the collection landing page
- Jones/pdfs/ — Sea Otter Narrative, Census Map, Gazetteer (PDF),
  SEB Workshop Paper, Jones Story Transcription, Canoe Story
- Jones/csv/ — Sea Otter Census Data, Gazetteer (CSV)
- Jones/images/ — section headers, maps, supporting imagery
- Interactive timeline and interactive map (HTML/JS embedded
  in jones.qmd)

## Architecture
Single scrolling narrative on jones.qmd, following the same
pattern as gallery.qmd:
- Hero section with title, subtitle, categories (AI / Science /
  Ethnobiology), publication date
- Methodology section
- Collection Overview
- Section per major component (Interactive Timeline, Sea Otter
  Case Study, Canoe Story, Geographic Gazetteer, Methodology
  Paper)
- Closing "For Future Researchers" section
- Embedded media: PDF flipbook iframes, interactive timeline,
  interactive map, downloadable CSVs and PDFs
- Direct quotes from Jones interspersed in italics

## Components

### Interactive Timeline (1948–1974)
Filterable categories: sea otters, wildlife, environmental
events, management actions, historical context. A navigable
chronological framework — effectively a table of contents to 27
years of field observations.

### Sea Otter Case Study
The proof of concept for the entire collection. Jones documented
the species' recovery from near-extinction with a depth of
observation that is, in retrospect, irreplaceable.
- Sea Otter Narrative (PDF) — Jones' own words across 8 thematic
  sections
- Sea Otter Census Data (CSV) — 52 curated observation records
- Census Map (PDF) — static version of the interactive map
- Interactive map plotting observation locations across the
  Aleutian chain, Attu to the Alaska Peninsula

### The Canoe Story
A separate narrative recovered from an 18-page typescript:
Jones' account of an 8-day, 265-mile canoe trip down the
Missouri River from Mobridge to Chamberlain, South Dakota.
Predates Alaska years; reveals the naturalist and writer behind
the science. Validates the OCR pipeline's generalizability
beyond government wildlife records.
- Jones Story Transcription (PDF)

### Geographic Gazetteer
875 raw place-name references reduced to 210 curated locations
through AI-assisted deduplication. The pipeline recognizes that
Iseabek, Isombok, Isenbok, and 18 other variants all refer to
Izembek Bay. Each entry includes feature type, region, mention
count, year ranges, and OCR variant spellings preserved as audit
trail.
- Gazetteer (PDF) — 210 locations, formatted for reference
- Gazetteer (CSV) — machine-readable with all fields

### Methodology Paper
Prepared for the International Society for Ethnobotany AI
Workshop. Documents the recovery pipeline in sufficient detail
for replication with other historical document collections.
- SEB Workshop Paper (PDF)

## Methodology
Recovery pipeline combines olmOCR-2-7B (vision-language model)
with AI-assisted contextual interpretation. Raw OCR extracts
text from degraded scans; AI understands it — correcting
errors, resolving variant spellings, reassembling data tables
broken across pages, distinguishing census counts from casual
sightings.

Human-AI collaboration throughout. Human directs the questions,
validates outputs, provides domain expertise. AI processes the
volume, maintains consistency across 1,300 pages, surfaces
patterns that manual review would miss.

## What the Collection Does Not Cover
The collection is deliberately unfinished. It demonstrates what
AI-assisted recovery can accomplish; it does not exhaust what
Jones' reports contain. Outstanding material:
- 71 other species await the same treatment as the sea otter
- Environmental observations, weather records, and management
  decisions that could yield additional structured datasets
- Geographic gazetteer is a framework, not an exhaustive
  treatment

These are presented in the collection as opportunities for
future researchers, not as gaps in the published work.

## Connection to Kim's Other Work
- Connects to the association index theme of "the shelf list
  problem": chaos that yields to structure once the right tool
  appears
- Connects to "latency of good ideas": Jones' observations sat
  waiting for OCR good enough to read them
- Connects to "instrument and scale as inseparable": the
  gazetteer reconciliation is exactly that — variant spellings
  resolved through contextual category assignment
- Connects to ethnobiology / Deconstructing a Flora work in
  inventory_all_projects.md
- Demonstrates the AI-assisted research methodology that Kim
  has been developing across multiple projects

## Next Steps
Per Kim, the Jones Collection itself is finished. Adjacent work
that may follow:
1. Write to the AI session organizer at the International
   Society for Ethnobotany pointing at this collection as a
   workshop reference (Kim's task).
2. The methodology generalizes — future projects may apply the
   same pipeline to other historical record sets. Track these as
   separate projects when they emerge.
3. If any of the 71 other species become a priority, that work
   would warrant its own proj_*.md.

## Collaborators / Dependencies
None. Work was Kim + AI throughout.

## Blockers
None. Project complete.

---
## Log
### 2026-05-07
File created retroactively as part of the PKM Operating Protocol
adoption. The collection itself was developed across earlier
sessions (Opus 4.6 era) and published 2026-05-05, but the proj
file was not created at intake — exactly the gap the new
protocol is designed to prevent. This file serves both as the
Jones Collection's PKM record and as the first exercise of the
intake protocol applied retrospectively. Future projects will
have their proj_*.md files created at the start of work, not
weeks after deployment.

### 2026-05-30 (Status / Focus-readiness back-fill)
Status set to Complete, Focus readiness Not applicable: finished
and published 2026-05-05. Under the posted-on-website rule a
published deliverable is Complete. Part of the collection-wide
back-fill; see proj_PKM.md and session_log.md (2026-05-30).
