# PROJECT: icons
_Last updated: 2026-09-13_
_Status: Active_
_Focus readiness: Ready_

## Type
Content project, data-driven (icon register -> rendered symbols -> stories)

## Objective
Characterize how people think about Hawai‘i through its icons: the compressed
keys under which the world files the place. A **Hawai‘i icon** is an object,
place, sound, word, or practice that a person with no caption resolves to
"Hawai‘i" and to nothing else (the Diamond Head profile, the aloha shirt, the
Arizona Memorial; palm trees fail the second half -- they say "tropics"). The
working notion is something between a metaphone and a metaphor: a lossy,
many-to-one reduction of the place to a few discriminating features, decoded
by a human. Three goals in sequence: (1) identify and classify the
Hawai‘i-unique icons in a register; (2) render each as a visual symbol, built
as a family under one visual grammar so the set discriminates; (3) tell the
story of each -- who made it an icon, when, and for whom. A theme beneath the
project: if you come to Hawai‘i you should encounter each of these. A testable
claim at the center: Hawai‘i likely has the highest density of such icons of
anywhere, because it combines three things that rarely co-occur -- an isolated
indigenous culture whose lexicon English borrowed wholesale, a century of
deliberate place-branding aimed at one large market, and a small bounded area
with a unique landscape and one globally known historical event.

## Current Status
Opened 2026-09-13 as Active Focus (replacing the closed sake_brewery focus).
**Register at 34 rows after the opening session** (20 pass, 12 borderline, 2
deliberate fails kept as boundary cases: Hawaiian pizza, wiki). The test is
scored as two columns: `distinct` (uncaptioned, resolves to Hawai‘i and
nothing else) and `recognized` (outsider / resident / both / few). **Two-axis
classification, as amended by Kim's rulings during the session:**
- **Channel:** visual, auditory, lexical, kinetic, gustatory; olfactory
  provisional (plumeria).
- **Origin:** native_hawaiian; missionary_monarchy (1820-1893); plantation_immigrant
  (one immigrant group's thing); local (the fused post-plantation multi-ethnic
  culture); territorial_tourist; military; natural; external (made elsewhere and
  attributed to or named for Hawai‘i -- the appropriation class).
Outsider set vs resident set kept apart via `recognized`. Track: **R on Kim's
machine**; register and codebook written and read back through the R bridge.

**Emerging findings (session 1).** The borderlines all fail the same way: a
stronger confusable that Hawai‘i once owned and lost (surfboard -> California,
steel guitar -> Nashville, poke bowl -> fast-casual, pineapple -> "tropics",
tiki -> Polynesian pop). The density claim may need restating as *originated
here* vs *still exclusively owned here*, and the gap is the finding.
Outsider/resident pairs on one referent recur (hula girl vs halau, grass skirt
vs pa‘u, tiki vs ki‘i, poi as joke vs Haloa) -- a `pairs_with` column is likely.
`audience` agrees with `recognized` on 33/34 and is redundant. Natural-origin
plants are all borderline (pan-tropical); landforms pass cleanly.

**Risks written in at intake.** Scope: the register will want to grow without
limit -- the caption-free test is the gate; cap the first pass (~40).
Comparators: the density claim is an assertion until measured the same way
elsewhere; the borrowed-word count is the cheap first test. Ownership: much of
the core set is Native Hawaiian and some was commodified by others -- the
origin axis is the project's conscience, not decoration. Rendering: the glyph
family risks kitsch, which is what the tourist-era icons are made of; handle
that tension deliberately.

## Locations
- Source of record: G:\My Drive\Projects\icons (bucket 2) -- created 2026-09-13
- Data: G:\My Drive\Projects\icons\icon_register.csv (34 rows)
- Docs/output: venue undecided (documents vs stories vs collections)
- GitHub: not yet

## Key Files
- icon_register.csv -- one row per icon; 15 columns (id, icon, channel, origin,
  audience, distinct, recognized, confusable, encounter, era, made_by,
  story_lead, symbol_status, notes, added)
- README.md -- the codebook: column definitions, the test, the axis values,
  the gate (no row without a `distinct` judgement; first pass capped ~40)

## Related Projects
- proj_checklists.md / proj_checklistr.md -- the "encounter each one" theme is
  a checklist in the same spirit.
- proj_sake_brewery.md -- the photograph-as-primary-source story method is a
  candidate template for the per-icon stories.

## Next Steps
1. A few more candidate batches; the resident quadrant is thin (5 of 34):
   pidgin, Merrie Monarch, malasadas, paniolo, Hokule‘a, nene are queued.
2. Rulings pending: drop `audience`; add `pairs_with`; confirm `olfactory`.
3. Decide the density metric and comparators; run the borrowed-word count
   first (aloha, hula, lei, ukulele, luau, wiki, kahuna, mahalo, tiki, poi...).
4. Settle the visual grammar for the symbol family, then render Diamond Head
   first (the single-line profile), then the Arizona Memorial span, the
   Kamehameha arm, the plate-lunch tray, the shave-ice cone.

## Collaborators / Dependencies
None.

## Blockers
None.

---
## Log
### 2026-09-13
Project opened. Kim proposed "icon = visual metaphone"; discussion moved the
definition to the referent rather than the glyph (something between metaphone
and metaphor), settled the caption-free "Hawai‘i and nothing else" test, the
two-axis classification (channel x origin), and the outsider/resident split.
Track decision: R on Kim's machine. Intake stub written.
Then `Projects\icons` created through the R bridge, register skeleton + codebook,
and 34 rows argued in batches of three (Kim supplied 21, Claude 13). The
classification broke four times and each break became a Kim-ruled rule:
`external`, `missionary_monarchy`, the `distinct`/`recognized` split (after
loco moco), and `local`. Session closed with Kim taking a break; resume with
more candidates, then symbols.
