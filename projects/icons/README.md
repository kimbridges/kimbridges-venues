# icons -- register codebook
_Created 2026-09-13_

One row per icon in `icon_register.csv`. A Hawai‘i icon is an object, place, sound,
word, or practice that a person with NO caption resolves to "Hawai‘i" and to nothing else.

| column | values / meaning |
|---|---|
| id | stable key `ic001`... never reused |
| icon | short name |
| channel | visual, auditory, lexical, kinetic, gustatory, olfactory (PROVISIONAL 2026-09-13: plumeria) |
| origin | native_hawaiian, missionary_monarchy (1820-1893), plantation_immigrant (a specific immigrant group's thing), local (adopted 2026-09-13: the fused post-plantation multi-ethnic culture), territorial_tourist, military, natural, external (made elsewhere and attributed to or named for Hawai‘i; the appropriation class) |
| distinct | pass, borderline, fail -- uncaptioned, resolves to Hawai‘i and NOTHING ELSE (the distinctiveness half; split from caption_test 2026-09-13 after loco moco) |
| recognized | outsider, resident, both, few -- who actually knows it (the recognition half). Loco moco: distinct=pass, recognized=few |
| pairs_with | id(s) of the outsider/resident counterpart on the SAME referent (hula <-> Merrie Monarch; wa'a <-> Hokule'a; grass skirt <-> hula), or a note when the counterpart is not yet a row. Added 2026-09-13. |
| confusable | the nearest thing it could be mistaken for (palm tree -> 'tropics') |
| encounter | where or how a visitor meets it |
| era | approx. date it BECAME an icon, not when the thing originated |
| made_by | who made it an icon, and for whom |
| story_lead | one-line hook for the story |
| symbol_status | none, sketched, drafted, final |
| notes | free text; borderline arguments go here or in the proj log |
| added | date the row was added |

Gate: no row without a `distinct` judgement. First pass capped ~40.

Housekeeping 2026-09-13: `audience` dropped (agreed with `recognized` on 39/40; loco moco was the split and `recognized=few` carries it). `pairs_with` added. `olfactory` stays provisional until a row uses it.
First pass reached the 40-row cap 
2026-09-13
.

## photo_log.csv (added 2026-09-13)

One row per icon; the SHOT LIST. Images for this project come from Kim's own photographs (so a visitor can say
"I can take that picture, too"). Two visual tiers: **posters** (flat poster-style illustration generated from the
photograph via the OpenAI API, driven from R; register columns build the prompt and `confusable` is the do-not clause)
and **glyphs** (vector symbols under one grammar, drawn as SVG).

| column | values / meaning |
|---|---|
| photo_status | have, candidate, need, not_photographable |
| photo_file | filename under photos/ |
| subject | the composition that makes the icon resolve (stand-in subject for lexical/auditory icons) |
| where_when | where and when to shoot if a trip is needed |
| poster_status | none, generated, approved |
| glyph_status | none, sketched, drafted, final |

Folders: photos/ (source photographs), posters/ (generated), glyphs/ (SVG).
Shot list = `subset(photo_log, photo_status == "need")`.
