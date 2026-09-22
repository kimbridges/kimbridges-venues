# PROJECT: icons
_Last updated: 2026-09-22_
_Status: Active_
_Focus readiness: Blocked_

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
project: if you come to Hawai‘i you should encounter each of these -- and
because every image in the work is made from one of Kim's own photographs, a
visitor can look at any of them and say "I can take that picture, too." The
encounter list is a checklist a person can carry with a camera. A testable
claim at the center: Hawai‘i likely has the highest density of such icons of
anywhere, because it combines three things that rarely co-occur -- an isolated
indigenous culture whose lexicon English borrowed wholesale, a century of
deliberate place-branding aimed at one large market, and a small bounded area
with a unique landscape and one globally known historical event.

## Current Status
**PAUSED 2026-09-22 (Kim).** Active Focus moved to the trilogy
(`ideas_three_documents.md`). Icons waits on photographs: Kim needs to find and
take new ones. Focus readiness Ready -> Blocked. Next Steps below are unchanged
and resume as written.

Opened 2026-09-13 as Active Focus (replacing the closed sake_brewery focus).
**Register at 40 rows -- the first-pass cap -- as of 2026-09-13** (24 pass, 14
borderline, 2 deliberate fails kept as boundary cases: Hawaiian pizza, wiki).
Housekeeping done the same day: `audience` dropped, `pairs_with` added.
**Visual design settled (evening 2026-09-13), joint decision:** two tiers.
(1) **Posters** -- flat, simplified poster-style illustrations in the lineage of
the 1930s-50s Matson / tourist-bureau posters (the dialect the icon-makers used,
adopted knowingly), generated from Kim's photographs via the OpenAI API driven
from R; the register builds the prompt (`icon`, `encounter`, `story_lead`) and
`confusable` is the do-not clause; fallback allowed, the learning about driving
another agent from R is itself a goal. (2) **Glyphs** -- vector symbols under one
grammar, drawn as SVG so stroke, grid and palette are shared across the set.
**Photo supply is the constraint:** `photo_log.csv` is the shot list (40 rows; 1
`have` -- Diamond Head, two perspectives, 2013 and June 2026 -- 39 `need`).
Kim's archive is mid-migration (QNAP -> Lexar SSD). Work proceeds in spurts. The test is
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
Natural-origin plants are all borderline (pan-tropical); landforms pass cleanly.
**The quadrants mean something:** high-distinct / low-recognition is the resident
treasure (pidgin, Merrie Monarch, loco moco, slack key, nene) -- the set the
"encounter each one" theme exists to promote; outsider-only is the appropriation
set (mai tai, pineapple, tiki, grass skirt, wiki).

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
- Data: G:\My Drive\Projects\icons\icon_register.csv (40 rows)
- Docs/output: venue undecided (documents vs stories vs collections)
- GitHub: not yet

## Key Files
- icon_register.csv -- one row per icon; 15 columns (id, icon, channel, origin,
  distinct, recognized, pairs_with, confusable, encounter, era, made_by,
  story_lead, symbol_status, notes, added)
- README.md -- the codebook: column definitions, the test, the axis values,
  the gate (no row without a `distinct` judgement; first pass capped ~40)
- photo_log.csv -- the SHOT LIST: one row per icon; photo_status (have /
  candidate / need / not_photographable), photo_file, subject (stand-in
  subjects set for the 12 non-visual icons), where_when, poster_status,
  glyph_status
- photos/ (Kim's source photographs), posters/ (generated), glyphs/ (SVG)

## Related Projects
- proj_checklists.md / proj_checklistr.md -- the "encounter each one" theme is
  a checklist in the same spirit.
- proj_sake_brewery.md -- the photograph-as-primary-source story method is a
  candidate template for the per-icon stories.

## Next Steps
1. **First poster:** an R function taking a register row + a photograph ->
   OpenAI image edit in the poster style; run on Diamond Head from
   `photos/diamondhead_*.jpg`. Review against `confusable`.
2. **First glyphs:** Diamond Head, the Arizona Memorial span, the Kamehameha
   arm as SVG, to test whether one grammar holds across landform, building
   and figure.
3. Keep `photo_log.csv` current; shoot from the `need` rows in spurts.
4. Decide the density metric and comparators; borrowed-word count first.
5. Second-pass candidates wait (ki'i, 'ohi'a lehua, Waimea Canyon, Na Pali,
   the conch, the falsetto). `olfactory` provisional until a row uses it.

## Collaborators / Dependencies
None.

## Blockers
**Photographs** (since 2026-09-22): 39 of 40 icons are `need` in `photo_log.csv`.
Kim to find them in the archive (mid-migration QNAP -> Lexar SSD) or shoot new.

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
Second sitting (same HST day): the six queued resident icons added (pidgin,
Merrie Monarch, malasadas, paniolo, Hokule'a, nene) -> 40 rows, the cap.
Housekeeping: `audience` dropped (39/40 agreement with `recognized`; snapshot
in C:\temp\icons_2026-09-13), `pairs_with` added with the four explicit pairs.
Evening: Kim showed a flat poster-style rendering of Diamond Head Lighthouse
made from his own photograph and proposed the OpenAI API (driven from R) for
image generation; agreed as a joint design: posters generated from Kim's
photographs + vector glyphs. Finding 055 written (commit-side stale copy, now
reproduced byte-for-byte) and a card row added. `photo_log.csv` created as the
shot list with photos/, posters/, glyphs/ folders; two Diamond Head photographs
filed. Objective updated with the visitor angle. Next: first poster + first
three glyphs.
### 2026-09-22
Paused by Kim after a nine-day break (family priorities): he needs to find
and take new photos. Focus readiness Ready -> Blocked; blocker named in Blockers.
No project work this session; Next Steps unchanged. Active Focus moved to the
trilogy (round two of `ideas_three_documents.md`).
