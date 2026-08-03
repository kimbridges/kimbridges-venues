# Chapter 8 — "Closing the Loop" — ideation notes

_Started 2026-07-02. Companion to `design_notes.md`. Per `style_multichapter_doc.md` Section 9._

## Status
**DRAFTED + COMMITTED (2026-07-02).** Prose written, reacted to ("a strong chapter"), committed to
`closing-the-loop.qmd`, renders clean. Two changes from the reacted draft: (1) the **label reframed as data**
(Kim); (2) the **graceful-degradation beat removed** and handed to the new fragility chapter. Carries a
worked-example placeholder (`read_photo`) and a figure placeholder (label record + log row). Voice held to
`kim_association_index.md`.

## Placement
Chapter 8, the demonstration. Gathers all prior threads and runs one real photograph end to end (Kim: "ties a
lot of things together"). Hands to Ch. 9 (Purpose): "what it is for, and who it is for."

## Threads
1. **Gather the pieces.** Names each prior piece, then "put a single real photograph in at one end."
2. **The input.** One photo of the laid-out cards; the coordinate pair + time in the file. "One picture."
3. **Decode the messy reality.** Field photos aren't clean scans; no single reader gets them all, so the
   software pools several decoders + preprocessings. "The trick isn't a cleverer reader. It's refusing to
   trust just one." **Live:** `read_photo()`.
4. **EXIF + derive → one record.** "assembles itself, from a photograph, with no one typing."
5. **★ The two views (label reframed as DATA — Kim).** The label is held in the record as data; a
   well-established herbarium takes it as a **Darwin Core file** and prints on its own archival paper; a
   herbarium not set up for that renders a **provisional label**. The log gains a row. "One photograph in, a
   labelled record and a log row out." (Full label bifurcation → the new Workflow chapter.)
6. **No transcription (friction paid).** "The friction we set out to remove wasn't reduced. It was designed
   out."
7. **Close → Purpose.** "The loop is closed... The machine works. What remains is to say plainly what it is
   for, and who it is for."

## Moved out (to the fragility chapter)
The reacted draft had a graceful-degradation paragraph (card fails → others still decode; GPS doesn't lock →
keep the rest; identity held twice over). **Removed from Ch. 8** and handed to the new fragility chapter
("How It Holds Up"), which develops it with the operational habits (read the printed text, two photographers,
chimp it, carry two sets) and the friction tie.

## Key formulations to preserve verbatim
- "The trick isn't a cleverer reader. It's refusing to trust just one."
- "assembles itself, from a photograph, with no one typing."
- "The friction we set out to remove wasn't reduced. It was designed out."
- "One photograph in, a labelled record and a log row out."

## Next session — resumption checklist
1. Draft Chapter 9, "Purpose" (data equity), then Ch. 10 "The Workflow," Ch. 11 "How It Holds Up", Ch. 12
   "Limits and the Frontier."
2. Wire the live `read_photo` worked example + the label/log figure in the technical pass.
