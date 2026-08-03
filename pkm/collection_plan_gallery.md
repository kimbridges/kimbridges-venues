# The Gallery Project — Collection Plan

## Overview

This collection showcases the evolving capabilities of AI through art-related tasks. Six products (with a seventh in development) trace a creative journey, each building on the previous, each reflecting the AI capabilities available at the time of creation.

The collection page is a single scrolling narrative — not a grid of links. The visitor follows the intellectual thread from the Gallery Catalog through Orbits and beyond.

**Source document**: "The Gallery Collection" Google Doc contains the current draft text for all sections. This needs serious editing before transitioning to a real webpage, but the structure and content are substantially complete.

## Page Structure

### Hero Image
- **Knight-Brown Gallery storefront** — full-width, top of page
- Shows the fictional Bleecker Street gallery with catalog artwork displayed in windows
- Artwork in the windows matches pieces from the catalog; street tree foliage matches the fall show date
- Sets the tone: this looks real, and that's the point

### Introduction
- Framing text: what the Gallery Project is, the methodology (multi-LLM, human-directed, iterative), and the "Point in Time" premise
- Key points: multiple AI engines used for different tasks (Gemini for artwork, Claude for storylines, ChatGPT for critique), human editing of all output, Photoshop/Wacom finishing
- Source: Google Doc introduction sections (needs copy editing)

### Six Product Sections (in narrative order)

Each section has:
- A **section image** (visual anchor, specific to that product — some newly created for this page)
- **Connective narrative** — what led from the previous product to this one
- **Embedded media** — appropriate to the product type

1. **Gallery Catalog** (PDF)
   - The origin story: could AI create "acceptable" art judged by the standard of a traditional gallery?
   - The fictitious Knight-Brown Gallery on Bleecker Street, NYC — researched down to a precise location
   - Five fictional artists with AI-generated portraits, bios, and artwork spanning multiple styles
   - Each piece began with a text prompt, went through 3-4 iterative rounds, then Photoshop finishing (gyotaku took hours of handwork)
   - Goal: art you'd hang on your wall, not "astronaut riding a unicorn"
   - Assembled in InDesign as a realistic gallery catalog
   - Embedded via flipbook PDF viewer (two-page spread)
   - Section image: TBD

2. **Gallery Catalog Review — Audio Podcast** (M4A/MP3)
   - Innovation: three-person narrated discussion (not the standard NotebookLM two-person format)
   - Premise: two art critics review the Gallery Catalog and give opinions
   - Dialog created stepwise with LLM, same iterative approach as the artwork
   - AI-generated voices (another capability test)
   - Goal: realistic interview that accurately comments on image-rich source material
   - Embedded HTML audio player
   - Section image: TBD

3. **Gallery Show Review — Video Podcast** (YouTube)
   - Same approach as audio podcast, but enriched with artist information — as though reviewers attended the show and met the artists
   - Animated characters from still images (no dialog sync — not possible with available software at the time)
   - Video and audio segments composed for YouTube presentation
   - Goal: create animated characters from still images while retaining individual appearance
   - Embedded YouTube iframe
   - Section image: TBD

4. **Pilk Collection Auction** (PDF)
   - The gallery becomes venue for a new story: eccentric art collector Professor H. H. Pilk
   - Collection of old still life paintings with a twist — food as prepared dishes, not raw ingredients
   - Extends the AI art challenge into a different genre and narrative frame
   - Embedded via flipbook PDF viewer
   - Section image: TBD

5. **Orbits** (PDF — book format)
   - Pushes the project into long-form: a complete book
   - New territory in both narrative scope and AI capabilities
   - Format/viewer: flipbook PDF viewer
   - Section image: TBD

6. **Book Signing** (video — PLACEHOLDER, in development)
   - Will use video with lip sync (capability not yet ready when earlier products were made)
   - Demonstrates the "Point in Time" premise — new capabilities enable new products
   - Not yet produced; placeholder in the collection plan

### Behind the Curtain
- A link (button or styled link) to a separate page
- Technical details, historical context, social observations
- The "Gallery Catalog Process" Google Doc is existing source material for this
- Topics: which AI models were used, what worked/failed, ethical questions (fake artists? AI acknowledgment? modifying AI originals?), the emotional experience of becoming attached to fictional artists
- Where the "Point in Time" premise comes alive: specific capabilities and limitations at each stage
- Could be a single comprehensive page or per-product expandable sections

## Design Principles

- **Visually rich**: every section has an image; nothing looks like a directory listing
- **Single page narrative**: the visitor scrolls through the story, not clicks between pages
- **Embedded media**: PDFs in flipbook viewer, audio inline, video inline — visitor stays on page
- **Detail matters**: the gallery image matches artwork to catalog contents, foliage matches the season — this standard applies throughout
- **Fun is a requirement**: both process and product should be enjoyable
- **Section images**: some newly created specifically for this page, often composited from existing materials

## Building the Landing Page

The Google Doc "The Gallery Collection" is structured with sections that map directly to the landing page layout. The transition workflow:

1. **Edit the text** in the Google Doc until it's publication-ready
2. **Finalize section images** — one per product section
3. **Gather media files** — PDFs, audio, YouTube URL
4. **Convert to Quarto** — the Google Doc sections become the .qmd page content with embedded media
5. **Build and deploy** to kimbridges-collections.netlify.app

The Google Doc format works well as the drafting environment. When the text is ready, the conversion to a Quarto page is mechanical — the structure is already defined.

## Files and Locations

- Hero image: Knight-Brown gallery storefront (in Gallery folder)
- Draft text: "The Gallery Collection" Google Doc
- Behind the Curtain source: "Gallery Catalog Process" Google Doc
- Gallery invite video: Gallery_invite.mp4 (Google Drive)
- PDF products: Gallery Catalog, Pilk Auction, Orbits (locations TBD)
- Audio podcast: M4A file (location TBD)
- YouTube podcast: URL TBD
- Section images: TBD — Kim selecting/creating these

## Technical Notes

- Site will be kimbridges-collections.netlify.app
- Same Quarto website pattern as kimbridges-stories and kimbridges-documents
- PDF viewer (viewer.html) can be reused from kimbridges-stories
- Audio hosting: direct on Netlify (confirmed working)
- Video: YouTube embed (iframe) for podcast; direct hosting TBD for Book Signing
- Navigation: links back to kimbridges.info and other sites
