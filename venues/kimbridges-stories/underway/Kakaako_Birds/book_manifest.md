# Kaka‘ako Birds — Book Manifest

This file is the control sheet for the book. It is the single place that
records **what species are in the book, in what order, and in what state.**
photobookr (or a thin pre-step) reads the species order from here; the
narrative prose lives in `Stories/<species>.md`, the working notes live in
`background/<species>_notes.md`, and the photos live in `Images/`, joined to
the text by their EXIF identifier.

Because this book is an *ongoing* project — new photos, new species, better
images swapped for older ones, growing text — nothing here is meant to be
final. Edit freely; the dated log at the bottom keeps the history.

## ▶ HOW TO REBUILD THE BOOK (the simple way)

Edit the chapter files in `Stories/*.md` (the source of truth), then in RStudio:

```r
source("G:/My Drive/kimbridges-stories/underway/Kakaako_Birds/build_kakaako_book.R")
build_kakaako_book()        # re-assembles from Stories/*.md, renders at 17 pt, builds the PDF
```

`build_kakaako_book()` ALWAYS re-assembles the manuscript from the current
`Stories/*.md` first, so your edits are never stale. Output:
`Kakaako_Birds_Book.pdf` in this folder (then run your Acrobat compression to
shrink it ~90×). It runs a few minutes; that's normal. Requires the rebuilt
`photobookr` (installed 2026-06-06).

## Build / assembly notes (2026-06-06)

**STATUS 2026-06-06 (updated):** photobookr **rebuilt + installed + verified**
(splits on `#`; xelatex for Hawaiian glyphs; punctuation-insensitive Event
match). First full photo book built: **`Kakaako_Birds_Book.pdf`, 98 pp**, cover
+ 20 chapters + 59 Event-matched photos + `_2W` spreads. Acrobat compression:
840 MB → **9.2 MB**. One-call build via `build_kakaako_book.R` (see above), which
folds re-assembly into the build. Build on a LOCAL disk + background async (the
G: stream drive is slow and a synchronous build blocks the ClaudeR add-in); the
add-in also blocks Claude-issued file deletions (Finding 006).


**Text draft produced (no photos yet):**
- `Kakaako_Birds_manuscript.md` — preface + 19 chapters in locked order, with
  YAML front-matter and `[V:]` tags stripped (assembled in R from the
  `Stories/*.md` files by `order`). 12,896 words.
- `Kakaako_Birds_draft.pdf` — 23-page text PDF (title page, TOC, Hawaiian
  diacriticals OK), rendered via pandoc + xelatex (Cambria). No images yet.

**Images / EXIF (verified in R, 2026-06-06):** `Images/` holds **59 photos**,
all carrying an EXIF **Caption-Abstract** (the display caption) and an EXIF
**Event** tag (the chapter assignment). Every one of the 19 chapters has ≥1
image. photobookr matches images to chapters by **Event == chapter stem**,
case-insensitive (`eq_ci`).

**Three Event↔title mismatches to normalize before an image build:**
- Event **"Rock Pigeon"** (2 imgs) vs chapter title **"Rock Dove"**.
- Event **"Pacific Golden Plover"** (5 imgs, no hyphen) vs **"Pacific Golden-Plover"**.
- Event **"Hawaiian Duck"** (2) vs **"Hawaiian duck"** (1) — case only; `eq_ci`
  handles it, but tidy up. Decision pending Kim: normalize the Event tags (via
  `metadata_to_csv` → edit → `csv_to_metadata`, which backs up) to match the
  chapter titles, OR adjust titles. Recommend normalizing tags, keeping Kim's
  titles.

**photobookr structural gap (the real blocker for the image build):**
photobookr's `parse_book_markdown` treats **every `##` header as a separate
chapter** (one text block per bird — the old field-guide-card model) and builds
**lowercase-underscore slugs** (`cattle_egret`) for the chapter PDFs. Our new
narrative chapters use `#` for the bird and `##` for thematic *subsections*, and
the Event tags are space/title-case ("Cattle Egret"). So `markdown_to_chapters`
+ `build_book` do **not** fit the new structure as-is. Options for the
image-integrated build (Kim's package call):
  1. Extend photobookr to treat `#` as chapters and `##` as subsections, and to
     match Event tags to the chapter `#` heading (not the underscore slug); or
  2. a thin wrapper that renders each `Stories/<species>.md` chapter to a PDF
     named `NN_<Event>.pdf` (stem = Event tag) and then calls `build_book`; or
  3. move to a Quarto book that places each chapter's Event-matched images with
     their Caption-Abstract captions.
Recommended next session: option 2 (a wrapper) is the least invasive route to a
photo-integrated PDF and keeps our `Stories/*.md` as the source of truth.

All deps confirmed present in Kim's R: photobookr, exiftoolr (+exiftool),
magick, pdftools, rmarkdown, tinytex/xelatex, pandoc.

## Status vocabulary
- **stub** — placeholder facts only (the old PDF cards)
- **drafted** — narrative written, awaiting Kim's review
- **reviewed** — Kim has read and approved the prose
- **(blank)** — species identified but no story yet

## Verification roll-up
Per-claim tags live inline in each story (`[V: Kim]`, `[V: lit]`,
`[V: lead]`). This column is a quick read of whether a story still carries
any **unverified leads** that must be resolved before publication.

## Species

| # | Species | Scientific name | Story status | Active images | Unverified leads? | Notes |
|---|---------|-----------------|--------------|---------------|-------------------|-------|
| 1 | Cattle Egret | *Bubulcus ibis* | drafted | 4 | none | mower + prawn-pond adaptation story; the book's opening hook |
| 2 | Red Junglefowl / Moa | *Gallus gallus* | drafted | 3 | none | "we call it a chicken" → **moa**; deepest roots — Polynesian canoe animal ~1,000 yrs ago; voyager/founding-stock frame; moa+hurricane-escape hybrid; first-immigrants' bird (bookend to the White Tern) |
| 3 | Rock Dove | *Columba livia* | drafted | 3 | 1 (white-flock cause, soft) | the disliked bird, treated fairly; ~1796; feeding-law + human-mirror; white-flock memory + plumage-genetics; lawn vs scavenger |
| 4 | House Sparrow | *Passer domesticus* | drafted | 5 | none | the tiny thief; deepest human-commensal (~10 Kya, beak reshaped); 1871; fed-pigeon vs stealing-sparrow contrast; ID pair w/ House Finch |
| 5 | House Finch | *Haemorhous mexicanus* | drafted | 2 | none | the ID-skill / becoming-a-birder chapter; ~1870 (papaya bird, manu ʻai mīkana); finch-vs-sparrow field marks (streaked vs plain breast); pairs w/ House Sparrow (adjacent); advances the thesis |
| 6 | Red-vented Bulbul | *Pycnonotus cafer* | drafted | 4 | none | friend/foe omnivore; mid-1950s cage escape; IUCN-100 + HI Injurious list; even-handedness capstone |
| 7 | Common Mynah | *Acridotheres tristis* | drafted | 3 | 1 (mynah purpose) | territory + "wrong species" / talking thread; opens the singers/newcomers |
| 8 | Red-crested Cardinal | *Paroaria coronata* | drafted | 3 | none | the bird that looks back; **Hui Manu payoff (color)** (~1928); "missing color" + Waikiki Aquarium first sighting; the unmissable "gateway bird" |
| 9 | White-rumped Shama | *Copsychus malabaricus* | drafted | 2 | none | rare here (dense-shade; Kamehameha-statue banyan); heard before seen; supreme song; **Hui Manu payoff #2 (song)** — brought 1940; curious mutual-regard close (Hui Manu pair w/ cardinal) |
| 10 | Saffron Finch | *Sicalis flaveola* | drafted | 7 | 1 (no-Hawaiian-name lead) | newcomer / colonization-in-progress; Kim 2002-list anchor; cage-trade origin (Pu‘u Wa‘a Wa‘a) |
| 11 | Common Waxbill | *Estrilda astrild* | drafted | 4 | none | the bandit mask; 1970s cage-bird escape; stalk-bending + leapfrog flock; skittish; "most common bird" corrected (quelea) → resolves the vanished-worry |
| 12 | Java Sparrow | *Lonchura oryzivora* | drafted | 2 | none | the "best-dressed" unmistakable seed-eater; uncut-lawn flocks; brought for beauty (cage trade, 1960s); cost-of-beauty irony (Endangered at home) = mirror of the koloa |
| 13 | Zebra Dove | *Geopelia striata* | drafted | 2 | none | overlooked-because-everywhere ground dove; 1922; brave forager, male aggression; the merbuk "background singer" turn; ID pair w/ spotted dove |
| 14 | Spotted Dove | *Spilopelia chinensis* | drafted | 4 | none | the loner that sometimes "guards" the seed-eaters; pre-1855 food bird; macro-only spot complexity + tetrachromacy ("always more to see"); ID pair w/ zebra dove |
| 15 | Black-crowned Night Heron | *Nycticorax nycticorax* (‘auku‘u) | drafted | 5 | none | NATIVE (HI's only native heron); tidal-fish-trap "urban café" at the Ala Moana canal; native-that-adapts-to-urban-infrastructure (opens the native section) |
| 16 | Ruddy Turnstone | *Arenaria interpres* (‘akekeke) | drafted | 3 | none | NATIVE migratory; overlooked on Ala Moana sand → secretly an Arctic globe-traveler (solo juvenile migration); stone-turning forage; "native by returning"; pairs w/ kōlea |
| 17 | Pacific Golden-Plover | *Pluvialis fulva* (kōlea) | drafted | 5 | 1 (proverb diacriticals, soft) | NATIVE migratory; territorial "lawn shark"; 21-yr site fidelity → named & befriended; the ʻōlelo noʻeau ambivalence; navigator's-highway tie to the moa; native-section centerpiece |
| 18 | Hawaiian Duck / Koloa | *Anas wyvilliana* (koloa maoli) | drafted | 3 (purity caveat) | none | **ENDEMIC + endangered** — the only "found nowhere else" bird; canal/Capitol/Zoo habitat; the hybridization "fracture" (mallard genetic dilution; O‘ahu mostly hybrids); native near-finale |
| 19 | White Tern | *Gygis alba* (manu-o-Kū) | drafted | 4 | none | the native SEABIRD FINALE; Honolulu's official bird (2007); master of flight; no-nest egg on a bare branch; 1961 urban onset; protected (Hui Manu-o-Kū ribbons); closes the native section |

_"Active images" = count of Images/ files whose EXIF identifier ties them to
this species' text blocks. The `Images/Extra/` folder is the bench for
alternates not currently placed. To be filled once we read the EXIF headers._

## Candidate species — saved for an UPDATE (Kim, 2026-06-05)
_The five species Kim has flagged for a future update. They will slip into the
reading order at their natural (thread-based) homes — see Proposed reading
order below. This is the first real exercise of the living-document design._

| Species | Scientific name | Status here | Native? | Natural home in the order |
|---------|-----------------|-------------|---------|---------------------------|
| ~~Black-crowned Night Heron~~ | *Nycticorax nycticorax* (‘auku‘u) | **DRAFTED 2026-06-05 → row 16** | NATIVE (indigenous) | moved into the species table; native section |
| ~~Pacific Golden-Plover~~ | *Pluvialis fulva* (kōlea) | **DRAFTED 2026-06-05 → row 15** | NATIVE (migratory) | moved into the species table; native-section centerpiece; pairs w/ turnstone |
| ~~Ruddy Turnstone~~ | *Arenaria interpres* (‘akekeke) | **DRAFTED 2026-06-05 → row 14** | NATIVE (migratory) | moved into the species table; native section, paired with the kōlea |
| ~~Hawaiian Duck / Koloa~~ | *Anas wyvilliana* | **DRAFTED 2026-06-05 → row 17** | NATIVE — ENDEMIC, endangered | moved into the species table; native near-finale; the clearest "fracture" |
| ~~Red Junglefowl / Moa~~ | *Gallus gallus* | **DRAFTED 2026-06-05 → row 13** | introduced (Polynesian-era) | moved into the species table; deep-roots/first-immigrant framing may argue for an early slot — decide in reorder |
| ~~Java Sparrow~~ | *Lonchura oryzivora* | **DRAFTED 2026-06-05 → row 18** | introduced (cage trade) | moved into the species table; cage-trade seed-eater cluster |
| ~~White-rumped Shama~~ | *Copsychus malabaricus* | **DRAFTED 2026-06-05 → row 19** | introduced (Hui Manu 1940) | moved into the species table; singers cluster; Hui Manu payoff #2 |

**Candidate list is now EMPTY — the set is complete at 19 species.**

_Excluded 2026-06-05 (Kim): **Red-whiskered Bulbul** — not seen in the area,
not its habitat. **Northern Cardinal** — another of the "unseen"/overlooked
birds; dropped to keep focus. Do not re-propose either; neither is referenced
in the book or the order._

**Framing impact (updated 2026-06-05):** with the night heron, kōlea, ruddy
turnstone, and koloa added, the natives number **five** (with the White Tern) —
so the book is NOT "introduced + 1 native." It is a set of urban birds, **~15
introduced + ~5 native** (≈20 total — Kim's "nearly two dozen"), and the natives
form a genuine **native closing section**, not a lone coda. This strengthens the
immigration/native synthesis (see front_matter_notes.md): introduced birds
mirror the people who came; the natives mirror the place. The White Tern finale
line "the only one that was never a stranger" must be reworked when the natives
join (white tern = the native seabird that nests downtown; the koloa, an
endangered endemic, is a strong "fracture" near-finale). Update `white_tern.md`
and `front_matter_notes.md` at that time. Native status of all four to be
formally verified when drafted (all well-known Hawaiian natives; koloa is
endemic).

## Proposed thread-based reading order (for Kim's reaction — NOT yet executed)

Kim's note: the drafting order (1–12 below as built) was mostly photo order; a
logical, thread-based order is better, and house sparrow + house finch in
particular should be adjacent. Proposed order, grouped by the threads that
emerged:

**Opening — the adaptation hook**
1. Cattle Egret — the bird that adapted to us; sets the theme.

**Living off us — the commensals and the fair eye**
2. Rock Dove / Pigeon — the disliked bird; "treat all birds the same."
   _(+ Red Junglefowl / moa near here — feral domestic; the first-immigrants/Polynesian angle.)_
3. House Sparrow — the tiny thief; deep commensal.
4. House Finch — the ID partner; *becoming a birder*. (3 & 4 adjacent ✓)
5. Red-vented Bulbul — friend/foe; the even-handedness capstone.

**The colorful newcomers — singers, the Hui Manu, the cage trade, watched invasions**
6. Common Mynah — the talker / territory. _(+ White-rumped Shama here — the singers cluster; the supreme voice.)_
7. Red-crested Cardinal — Hui Manu payoff (color). _(Northern Cardinal dropped; the Hui Manu pair is now cardinal=color + shama=song.)_
8. Saffron Finch — cage trade; colonization-in-progress; watched invasion.
9. Common Waxbill — cage trade; the "most common bird" correction; watched invasion.
   _(+ Java Sparrow near here — cage-trade seed-eater.)_

**The ground doves**
10. Zebra Dove — overlooked; the merbuk singer.
11. Spotted Dove — the loner; "always more to see." (10 & 11 adjacent ✓)

**The natives — the closing section (the ties to the place)**
   _New native cluster (order within TBD with Kim): ‘auku‘u (night heron),
   kōlea (golden-plover) + ‘akekeke (ruddy turnstone) as the migratory-shorebird
   pair, and koloa (Hawaiian duck) — the endemic, endangered "fracture" story
   (mallard hybridization) — a strong near-finale._
12. White Tern — the finale; the native that nests downtown; the inversion.

_With the additions the book runs ~20 species (~15 introduced + ~5 native).
The introduced set mirrors the immigrants who carried them; the native closing
section mirrors the place itself (front_matter_notes.md synthesis)._

Note: executing this reorder means (a) renumbering the `order:` field in each
story's front-matter, and (b) **updating the in-chapter cross-references** that
assume position — e.g. "the pigeon two chapters back" (house sparrow, waxbill),
"the next chapter / the last chapter" (the doves), "this whole book has been…".
Best done as ONE clean pass once the order is approved (and ideally coordinated
with how the natives are handled), not piecemeal. Cross-references to check:
house_sparrow, common_waxbill, house_finch, zebra_dove, spotted_dove,
red_vented_bulbul, white_tern.

---
## Log
### 2026-06-23 (PUBLISHED — live on the Stories site)
"The Birds Around Kaka‘ako" is **live** at kimbridges-stories.netlify.app. The
compressed 10.14 MB book (125 pp) was published as `pdfs/Kakaako_Birds.pdf` with
thumbnail `images/Kakaako_Birds.jpg` and story page
`stories/the-birds-around-kakaako.qmd`. Two deploy gotchas (quarto rendering
`underway/`; the Netlify drag skipping the not-yet-materialized PDF) were resolved
— see proj_kimbridges_stories.md 2026-06-23 and pkm_findings.md Finding 008. The
book is **done**; future species/photos still slot in via the living-document
design, rebuild with `build_kakaako_book()`, recompress, redeploy.

### 2026-06-23 (later — rerendered with swapped photos; verified; Acrobat back)
Kim resumed the same day after replacing/editing several photos (better versions,
same Event tags). EXIF re-read live: still **68 placed images**, all 19 chapters
covered, every Event matches a chapter title, no stray tags, no missing Events —
so the per-chapter image counts are unchanged from the morning entry (the swaps
kept the same tags and counts). `build_kakaako_book()` rerun (async, local-disk
staging) → **`Kakaako_Birds_Book.pdf`, 125 pp, 938.6 MB**, identical structure to
the morning build with the new image content embedded. **Verified** by rendering a
sample of pages (cover, several chapter-text pages, full-page photo pages, the
White Tern finale): typography and Hawaiian diacriticals clean, photos embedded
correctly, captions present, nothing dropped. Spread parity is structurally
unchanged from the morning PASS (same pagination), so no spread regression.
**Acrobat is working again** → proceeding to the compression pass (≈938 MB → ~9 MB)
and then the Stories-site deploy. (A throwaway `_check/` preview folder was left in
the book folder — the add-in blocks Claude-issued deletes; safe to remove, not used
by builds or deploy.)

### 2026-06-23 (assembly test rebuilt; image counts filled; paused on Acrobat)
Resumed from the 2026-06-07 park. Kim had already done the photo-polish work:
the placed set grew 59 → **68 images**, all 19 chapters covered, and the three
2026-06-06 Event↔title mismatches are resolved (Rock Dove, Pacific Golden-Plover,
Hawaiian Duck all correct; only a stray "Rock Pigeon" remains on the Extra/
bench, which builds ignore). Kim also caught and fixed a stray **"Ringed Dove"**
Event tag (renamed to its correct **Spotted Dove**) and one minor text edit.
`New/` and `Extra/` are working/bench folders — the build uses root `Images/`
only. **Assembly test PASSED:** `build_kakaako_book()` rebuilt cleanly to
**`Kakaako_Birds_Book.pdf`, 125 pp, 938 MB** uncompressed (up from 115 pp / 59
photos — the nine added photos account for the growth); every Event tag matched
a chapter, no images dropped. The `_tbd_` **active-image counts in the Species
table are now filled** from the EXIF read (Saffron Finch 7; night heron / house
sparrow / golden-plover 5; cattle egret / waxbill / red-vented bulbul / white
tern 4; six at 3; rest at 2; total 68). **PAUSED:** Kim's Acrobat is broken (and
blocking its own reinstall), so the compression step (≈840 MB → ~9 MB last time)
and the **two-page-spread visual check** are deferred until Acrobat is back.
Then: compress → verify spreads → deploy to the Stories site.

### 2026-06-04
Manifest created as part of the stories-realm restructuring. Replaces the
implicit `01_`, `02_` filename ordering of the old PDF stories with an
explicit order column that survives mid-book insertions. Cattle Egret moved
from stub (PDF card) to drafted (narrative markdown). Common Mynah and
Saffron Finch still stubs pending conversion.

### 2026-06-04 (evening — nine chapters drafted)
Nine species now drafted (rows 1–9): Cattle Egret, Common Mynah, Saffron
Finch, Rock Dove, House Sparrow, Red-crested Cardinal, Common Waxbill, House
Finch, Red-vented Bulbul — each verified, each with a Kim-observed anchor, the
old PDF stubs (Cattle Egret, Common Mynah, Saffron Finch) all superseded by
markdown. Candidate list added (red-whiskered bulbul + others). Still `_tbd_`
on every row: the **active-image counts** — fill these when the images' EXIF
identifiers are read (via ClaudeR / live R session; bash sandbox can't see the
image folders — Finding 005). ~3 more species with images remain for next
session, then front matter + assembly. Unverified-leads roll-up across the
book: 2 soft leads only (saffron finch "no Hawaiian name"; rock dove white-
flock cause) — both phrased cautiously in-draft, neither blocking.
