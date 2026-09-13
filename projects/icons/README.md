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
| audience | outsider, resident, both -- which set carries it |
| distinct | pass, borderline, fail -- uncaptioned, resolves to Hawai‘i and NOTHING ELSE (the distinctiveness half; split from caption_test 2026-09-13 after loco moco) |
| recognized | outsider, resident, both, few -- who actually knows it (the recognition half). Loco moco: distinct=pass, recognized=few |
| confusable | the nearest thing it could be mistaken for (palm tree -> 'tropics') |
| encounter | where or how a visitor meets it |
| era | approx. date it BECAME an icon, not when the thing originated |
| made_by | who made it an icon, and for whom |
| story_lead | one-line hook for the story |
| symbol_status | none, sketched, drafted, final |
| notes | free text; borderline arguments go here or in the proj log |
| added | date the row was added |

Gate: no row without a `distinct` judgement. First pass capped ~40.
