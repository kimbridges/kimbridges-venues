# Chapter 6 — "Derive, Don't Card" — ideation notes

_Started 2026-07-02. Companion to `design_notes.md`. Per `style_multichapter_doc.md` Section 9._

## Status
**DRAFTED + COMMITTED (2026-07-02).** Prose written, reacted to ("reads very smoothly"), committed to
`derive.qmd`, renders clean. Carries a **WORKED-EXAMPLE placeholder** (HTML comment) for the live
`library(vouchr)` run to be wired in a technical pass. Voice held to `kim_association_index.md`.

## Terminology decision (Kim, 2026-07-02) — document-wide
Use **"coordinate pair"** as the primary term (a single "coordinate" is really one number; the pair reads
right and echoes the "single pair of numbers" motif), varied with **"coordinates"** and **"the pair"** to
avoid repetition. Applied across `mechanics.qmd`, `capture-once.qmd`, `decks.qmd`, and this chapter. (Label
field lists that already said "coordinates" left as is.) Carry this convention forward in later chapters.

## Placement
Chapter 6, after "The Decks." Makes good on Ch. 5's "That half we don't card. We derive it." Hands to Ch. 7:
"which decks... The answer isn't an opinion. It's already written in the record."

## Threads
1. **The bold claim + the worked example.** Everything the landscape fixes is recoverable from the coordinate
   pair alone. Concrete: a Kīlauea ʻōhiʻa coordinate → elevation, slope + aspect, roughness, drainage, place,
   rock, soil ("a gentle, east-facing slope... on young basalt, over ash soils"). **Live example to wire:**
   `site_extract()` → gt table; `site_hillshade()` → DEM patch with the point.
2. **Why it's legitimate.** These are public, surveyed facts; the old instrument kit was "a portable and
   worse copy of records that already existed" (reprises the 1970s-kit thread). "The instruments didn't
   measure anything the world hadn't already measured better."
3. **Attention-friction payoff.** Fixed things don't change between slope and desk, so deriving them keeps
   scarce field attention for the plant. "The derive step and the decks are the same idea from two sides."
4. **★ The honesty — scale + source (Kim's Theme 9, instrument+scale).** A derived value carries its lineage
   (source, resolution, analysis scale). The slope example: coarse vs close-in changes the answer; roughness
   is scale-dependent. "A derived value without its scale and source is a rumor." (Kim: scale is really
   important and it shows here — he noted he didn't need to remind me.)
5. **The ceiling — limits.** Canopy DSM−DTM detects forest but saturates over tall closed canopy (reported 8 m
   for a ~20 m stand); a detector, not a measure; use a purpose-built layer. "A derived value has to carry its
   limits as plainly as it carries its number."
6. **Verification (brief).** We knew the ceiling because we checked against a control (grassland ~0) and a
   known-tall stand. "A value you can't test against something you already know isn't verified, it's just
   output." Best test sites are judgeable two ways (standing + published record).
7. **Works backwards.** Any georeferenced specimen can be enriched from the coordinates it already holds; the
   georeferenced backlog gains value. "It reaches back and pays the old ones forward." (Ties to the intro's
   records-outlive-us theme.)
8. **Close → Ch. 7.** Fixed half fills itself; the open question is which decks, and it's "already written in
   the record."

## Key formulations to preserve verbatim
- "Give the software a coordinate pair, and it hands back the site."
- "The instruments didn't measure anything the world hadn't already measured better."
- "A derived value without its scale and source is a rumor."
- "A derived value has to carry its limits as plainly as it carries its number."
- "It reaches back and pays the old ones forward."
- "The answer isn't an opinion. It's already written in the record."

## Open questions
- Wire the live worked example (site_extract + site_hillshade on the Kīlauea coordinate pair) in a technical
  pass, and confirm the qualitative description matches the real figures.

## Next session — resumption checklist
1. Draft Chapter 7, "Discovering the Decks" — the methodology (the real deliverable). Live example:
   `discover_decks()` on Metrosideros → the signature heatmap. Rich `design_notes.md` material (archetypes,
   two-taxa validation, the crowd-source framing, "peering over the experts' shoulders" Andes anecdote).
