# The Gallery Project — Collection Plan

## Overview

This collection showcases the evolving capabilities of AI through art-related tasks. Five products trace a creative journey, each building on the previous, each reflecting the AI capabilities available at the time of creation.

The collection page is a single scrolling narrative — not a grid of links. The visitor follows the intellectual thread from the Gallery Catalog through Orbits.

## Page Structure

### Hero Image
- **Knight-Brown Gallery storefront** — full-width, top of page
- Shows the fictional Bleecker Street gallery with catalog artwork displayed in windows
- Sets the tone: this looks real, and that's the point

### Introduction
- Framing text: what the Gallery Project is, the methodology (multi-LLM workflow, human direction, iterative refinement), and the "Point in Time" premise
- Source: introduction.txt (needs copy editing — typos on "humand" and "where/were")

### Five Product Sections (in narrative order)

Each section has:
- A **section image** (visual anchor, specific to that product)
- **Connective narrative** — what led from the previous product to this one
- **Embedded media** — appropriate to the product type

1. **Gallery Catalog** (PDF)
   - The origin story: could AI create gallery-worthy art?
   - Embedded via flipbook PDF viewer (two-page spread)
   - Section image: TBD

2. **Podcast — Audio** (M4A/MP3)
   - What questions did the catalog raise? What's the discussion?
   - Embedded HTML audio player
   - Section image: TBD

3. **Podcast — YouTube** (video)
   - The visual/video version of the podcast discussion
   - Embedded YouTube iframe
   - Section image: TBD (could be a video thumbnail)

4. **Pilk Auction Catalog** (PDF)
   - How did the concept evolve from gallery show to auction house?
   - Embedded via flipbook PDF viewer
   - Section image: TBD

5. **Orbits** (PDF or other format)
   - Where did the project push into new territory?
   - Format/viewer: TBD based on content type
   - Section image: TBD

### Behind the Curtain
- A link (button or styled link) to a separate page or section
- Technical details, historical context, social observations
- Where the "Point in Time" premise comes alive: which models, what they could/couldn't do, what required human intervention, what surprised
- Could be a single comprehensive page or per-product notes
- Placement: either a persistent link in the page header/footer, or small links within each product section

## Design Principles

- **Visually rich**: every section has an image; nothing looks like a directory listing
- **Single page narrative**: the visitor scrolls through the story, not clicks between pages
- **Embedded media**: PDFs in flipbook viewer, audio inline, video inline — visitor stays on page
- **Detail matters**: the gallery image matches artwork to catalog contents, foliage matches the season — this standard applies throughout
- **Fun is a requirement**: both process and product should be enjoyable

## Files and Locations

- Hero image: Knight-Brown gallery storefront (in Gallery folder)
- Introduction text: introduction.txt (in Gallery folder, needs editing)
- PDF products: Gallery Catalog, Pilk Auction, Orbits (locations TBD)
- Audio podcast: M4A file (location TBD)
- YouTube podcast: URL TBD
- Section images: TBD — Kim selecting these

## Technical Notes

- Site will be kimbridges-collections.netlify.app
- Same Quarto website pattern as kimbridges-stories and kimbridges-documents
- PDF viewer (viewer.html) can be reused from kimbridges-stories
- Audio hosting: direct on Netlify (confirmed working)
- Navigation: links back to kimbridges.info and other sites