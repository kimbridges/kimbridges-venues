# PROJECT: MRC -- Measurements Require Categories
_Last updated: 2026-10-30_
_Status: Active_
_Focus readiness: Ready_

## Type
Content project, data-driven: Quarto multi-chapter document (R + Quarto), with worked examples in R.

## Objective
*Measurements Require Categories* argues that every measurement comes with a classification whose categories give
the values meaning -- formal or unspoken, learned mostly tacitly -- and that the central question is WHERE
BOUNDARIES COME FROM. It is the first document of Kim's trilogy ("boundaries in value, space and time"): MRC =
value, *Maps with Tiles* (MWT) = space, *Spells, Stretches and Snaps* (S3) = time. Reading order: MRC first.
Clear exposition, common-sense examples, personal stories, and worked examples with real data.

## Current Status
Formal intake 2026-10-30 (Mechanism 1), after round three of idea capture adopted a 10-chapter outline in
three parts: I What a category does (1 The claim; 2 Learning the scale, incl. language; 3 Two uses); II Where
boundaries come from (4 the backbone; 5 Fixed or contextual; 6 Boundaries and error; 7 Several measurements, one
category; 8 Categories instead of measurements); III Categories over time (9 The life of a category; 10 The
inverse). Rulings: event boundaries stay in MRC (life cycle), not S3; ch.6-8 are valid and need work; ch.9's
location is open; language comes early (ch.2). PUBLISHED 2026-11-06 at https://kimbridges-documents.netlify.app/mrc/ (Preface, ch.1-10, appendix; all approved; Kim's full read-through done).

## Locations
- Code: G:\My Drive\Projects\MRC\R
- Figures: G:\My Drive\Projects\MRC\figures
- Data: G:\My Drive\Projects\MRC\data
- Ideas (trilogy-level capture, the source of record for the argument so far): Projects_Index/ideas_three_documents.md
- Docs/output: kimbridges-documents (planned)
- GitHub: not yet

## Key Files
- Projects/MRC/background/chapter_error_ideas.md (was ch06_argument.md) -- chapter 6 argument (7 steps), adopted 2026-10-30
- ideas_three_documents.md -- trilogy capture; MRC rounds two (2026-09-23) and three (2026-10-30), outline, rulings, verify lists

## Track
R on Kim's machine (ClaudeR bridge): destined for documentation; may draw on whittakerr, bbSynth and
Temperature_Patterns. MRC's figure style is to become the trilogy's shared visual vocabulary.

## Design Decisions
- **Style-guide exceptions for MRC (Kim, 2026-11-04):** "Flexibility is important in this document." MRC's diagrams differ from the other
  documents', so three rules of style_multichapter_doc.md are relaxed here: (1) SIDE-BY-SIDE composition is allowed where the design works
  better (comparisons); (2) SUBJECT COLOURS are allowed where the colours are the content (official AQI/UV/hazard codes, biome palettes),
  Okabe-Ito otherwise, and colour is still never the only channel; (3) SVG is optional (PNG + PDF acceptable).
- **Cover (Kim, 2026-11-04):** all the venue covers are AI-generated images, and Kim inclines to keep that style -- often an AI image built
  on one of his own photographs (Orbits is an example). Candidate concepts on the table: his rainbow + Newton's seven cuts; two thermometers
  (Fairbanks / Honolulu); tape measure turning to colours; martini glass. Kim is thinking about them.
- **US spelling (Kim, 2026-11-04):** "color", not "colour"; regular US spellings throughout (prose, labels, captions).
- **Voice (Kim, 2026-11-04):** "my" for Kim's own stories, "we" for shared analysis -- keep this convention.
- **File locations follow the guide:** chapter notes move to background/chapter_<name>_ideas.md when drafting begins (Kim accepted).

## Related Projects
- Trilogy siblings, still at capture: MWT and S3 (in ideas_three_documents.md; no proj files yet).
- proj_Voronoi.md / proj_tessellr.md -- the Voronoi document MWT cites.
- proj_whittakerr.md (ch.7, several measurements -> one category); proj_bbSynth.md (ch.8, class boundaries);
  proj_Temperature_Patterns.md (Eugene 32 F -- a ch.6 candidate); proj_Smart_Car.md (the fuel-gauge ladder).

## Next Steps
1. PUBLISHED. Remaining minor verify items (JIS S chest, Wansink 2005 -- not used in text, Hong Kong stock colors).
2. Optional later: a human-data check of the ch.2 AI comfort-word finding; the second ch.3 side-by-side figure.
3. Trilogy: MWT and S3 remain at capture.

## Collaborators / Dependencies
None yet.

## Blockers
None.

---
## Log
### 2026-10-30
Intake. Kim redirected from PubMaps to MRC for "a different perspective"; round three captured context vs fixed
boundaries, language, Hokule'a and the life of a category; outline adopted; Kim chose the short folder name MRC.
Folders created: R/, figures/, data/. Active Focus moved here; index row added.
Chapter 6 argument walked through and ADOPTED (7 steps; thesis: required accuracy is set by the categories,
not the instrument). Ruling: ch.6 = a boundary VALUE shifting within a living category; ch.9 = a category's ROLE
changing. Examples good for now; Kim to think of more between sessions. Started worked example 1.
Figures 1-3 of ch.6 built (misclassification curve; cost moves the threshold; NHANES 2017-2018 BP
reclassification, 19% -> 39% hypertensive on measured BP alone). Kim's CHART RULE adopted for the trilogy: include an
interpretation note that works one example; teach the reader how to read a new chart type. Next: fig4, Eugene 32 F.
Kim raised Miller (1956), "The Magical Number Seven" -- in a way the STARTING POINT of his thinking about categories
(the contrast between measurement and categories). Mapping to chapters in ideas_three_documents.md. Session paused for dinner.
Evening: RULING -- Miller (1956) OPENS the document as its personal origin (first fascination: the NUMBER of
categories; the measurement-category link came later). Started ch.6 fig4 (Eugene 32 F).
Fig4 built from real Eugene GHCN-Daily data: 5% of winter nights sit exactly on 32 F (rule for the line moves
frost nights 39 -> 50 a winter); last frost moves a median 3.5 days for 32 -> 33 F, 58 days in 2025. Chapter 6's
four planned figures are done.
### 2026-11-01
Round four opened (ideas file): clothing sizes (bespoke vs ready-to-wear; Japan S); Bridges & Lau 2006 skill levels --
RULING: an example toward the END; the document's progression is the UBIQUITY of classification and its various uses.
Compiled size guides (data/size_guides_tshirts.csv: 195 rows, 22 brand charts with data + JIS, EN 13402-3) and drew
figures/ch05_fig_size_guides (draft). Caveats: Uniqlo Japan source is a 2015 dress-shirt chart; JIS copy is secondary.
Hat sizes captured (counterexample: neutral number, a measurement disguised as a label). Gap review; Kim chose ch.10
BUNCHING first, with his hypothesis (penalty or reward attached to a category). Built ch10_fig1_bunching from real
data (Boston Marathon 2001-14; UK Price Paid 2013); notes in Projects/MRC/ch10_notes.md. Raw pp-2013.csv in C:/temp.
Warning scales checked (JMA shindo 1949/1996, UV index 1992/1994, NWS watch/warning research); Kim's own-field examples
(life forms, Zone System, plant families -> families placed with Dreyfus toward the end). AGE: Kim's grandmother story;
drew figures/ch05_fig_age_thresholds (data/us_age_thresholds.csv; Pew 2009 'old' by respondent age). Draft.
### 2026-11-02
Round five (ideas file): athletics (win/loss by comparison; the record keeps the category); the HIDDEN RUBRIC (Kim's
name) -- smoke alarm (toast; Kim's motel steam story), Kim's road test ~70 years ago. Ch.7: figures/ch07_fig1_whittaker_years
(Denver and Eugene year by year on whittakerr's diagram; GHCN-Daily, data/GHCND_*). Next: heat index Phoenix vs Tokyo.
Kim reframed Whittaker (the biota's stress at boundary sites). Built figures/ch07_fig2_heat_index_wbgt (Phoenix vs
Tokyo; US heat index vs Japan WBGT -- a Bridgman example; data/iem_hourly_PHX_RJTT_JunSep_2021_2025.csv).
Heat-death numbers: RULING -- one or two examples in the text only. Built figures/ch08_fig1_unequal_categories (AQI PM2.5
2024 breakpoints; Saffir-Simpson) after Kim's fuel-gauge example of unequal bars.
Kim's martini-glass idea -> figures/ch08_fig2_martini_glass (volume ~ height cubed; half height = 1/8 left; the
mechanism behind the fuel gauge's unequal bars).
### 2026-11-03
VERIFY pass: Projects/MRC/verify_list.md consolidates all items; two research helpers checked ~33 text facts (results
B1, B2). Data checks: Eugene precip shift = instrumental (vs Salem, Corvallis) -> RULING: Corvallis replaces Eugene in ch07_fig1; keep a
caution paragraph (draft in ch07_notes.md). WBGT approximation ran ~3 C high vs MOE measured data -> ch07_fig2 panel b rebuilt from official
WBGT (data/moe_wbgt_tokyo44132_JunSep_2021_2025.csv).
Ch.2 AI-elicitation worked example built: figures/ch02_fig1_llm_scales (24 cities x 3 models x 3). Finding: 'cold' tracks climate ~1:1,
'hot' ~0.3:1; the span of the words tracks the seasonal range (r = 0.96) -- the vocabulary stretches to fit. Notes: Projects/MRC/ch02_notes.md.
### 2026-11-04
Round six opened: NAMES AND COLOURS of categories -> ch.3 (RULING; split if too long); verification research running.
Style-guide exceptions adopted for MRC (side-by-side, subject colours, SVG optional); notes to move to background/ at drafting.
DRAFTING BEGUN: Quarto book scaffold (_quarto.yml, index.qmd + 10 chapter stubs + appendix.qmd); chapter notes moved to background/
chapter_<name>_ideas.md (learning, two_uses, error, several, inverse); Preface drafted (Miller opening). US spelling rule adopted.
Preface APPROVED by Kim ("I really like the draft... Excellent start"); 'hospital thresholds' -> 'medical guidelines' (doctor-oriented, not
institution-oriented). Part division and trilogy paragraph approved. Next: chapter 1, The Claim.
Ch.1 'The Claim' drafted and APPROVED ("It really works. The figure is perfect" -- ch01_fig1_same_number, 38 on seven scales, sets up
the whole document). Kim's edits applied: Honolulu -> SINGAPORE visitor to Chicago (different units, so conversion is needed); 'a scale' ->
'a butcher's scale' (device vs set of categories).
Ch.2 'Learning the Scale' drafted; Kim: rain story 'just the right length' -- cautionary, because the names are COMPOUND (rain + place): look
closely at the names before deciding how many categories are in use (sentence added). Next: ch.3 Two Uses + names and colors.
Ch.3 'Two Uses: Describe and Act' drafted (~1,700 words) with figures/ch03_fig1_color_ladders (nine scales by order of concern; panel b
simulated deuteranopia). Book renders clean (index + ch.1-3).
Ch.3 APPROVED ("Another excellent chapter... catching the spirit of what I've been thinking about for so many years"). Voice convention ruled.
### 2026-11-05
Index trimmed under budget (How-it-opened paragraph -> logs/focus_history.md). FOUR CHAPTERS DRAFTED AND APPROVED:
Ch.4 Where Boundaries Come From (fig ch04_fig1_boundary_sources: nine sources x describe/act; Purpose/economy and Human capacity drafted in
as sources; EVENT left to ch.9; Holdridge as the model example, Whittaker as judged; Boston 2011/2012 winners from published times -- the
boston rds elite times do NOT match published results, fine for ch.10 bunching only). Kim: 'shows a lot of depth'.
Ch.5 Fixed or Contextual (new fig ch05_fig_twilight, computed civil-twilight duration vs the 30-minute headlight law; size guides; age
thresholds). Kim's edits: 'relocation'; ARNOLD KISHI (friend; family Kona coffee farm; picked as a child) added -- Kim says he'll be OK with
it; nightly-newscast surf confusion added (Kim is not a surfer). 'Thin blood' widely used in Hawai'i (confirmed with Nancy).
Ch.6 Boundaries and Error (~2,500 words; figs 1-4 + new ch06_fig5_omr_form, contact details covered). BORDERLINE RULING (Kim): show the
three reasons by name (bad day; learning how to learn; not giving up), NO mechanics; make clear it is only a very thin rounding band;
x.5 rounding is biased/odd-even arbitrary; the context was fixed by rule, not by knowing the student. Non-disclosure to students OK ('very
tiny'); admitting bad questions is the big disclosure. 28-day story kept as is. Kim: 'amazing'; final section 'took my breath away'.
Ch.7 Several Measurements, One Category: Kim's fixes applied -- new ch07_fig0_whittaker_soil (both diagrams shown whole, labeled, with
worked examples), Denver/Phoenix as filled black dots, biome names on the year figure, 'stripe', 'the Whittaker diagram'.
Figure notes: double hyphens replaced in ch06/ch07 scripts; age figure says 'My grandmother'.
### 2026-11-05 (evening)
Kim: KEEP BMI; the ecological-stress reading is his ('My own reading is ecological'). COVER chosen: Kim's AI-generated rusty pressure gauge
(0-100 with NORMAL / CAUTION / WARNING / DANGER bands; uneven, off-round boundaries kept on purpose -- 'something known behind the scenes';
needle half-hiding WARNING kept -- shows the value of color). 2550x3300 (ratio 1.29, letter); logo 1024x1024; both in the project root;
render confirms. Ch.8 Categories Instead of Measurements drafted and APPROVED (new fig ch08_fig0_braun_blanquet); Dreyfus + families at
its end ('exactly right'); co-author is HAN LAU (Y. H. Lau; 'everyone calls him Han'; OK to name); life forms in Kim's 'I'.
Ch.9 The Life of a Category drafted and approved ('strong'); new fig ch09_fig1_shindo; Kim's Palau photo + schedule added
(sources/Hokulea_arrives_in_Palau.jpg, sources/2007Hokulea-palau.pdf -> figures/ch09_fig2/3) as a side-by-side figure.
Ch.10 The Inverse drafted (bunching fig; Clements/Gleason; questions-to-ask table closing the book). ALL TEN CHAPTERS DRAFTED.
### 2026-11-06
Kim read ch.10 ('great'; final words bring it full circle); Regents paragraph kept as is. SUBTITLE RULED: 'Boundaries in value' (all trilogy members
are 'boundaries' based). APPENDIX drafted (data files, figure scripts, asking the machines, credits, 30 sources, software); Mueller-Dombois &
Ellenberg 1974 confirmed. Cross-reference pass: 48 links checked, one fixed (ch.10 'Near its end, Chapter 6'); 'tile map' wording OK (Kim).
Kim's full read-through: 'reads well... balance... remarkable coverage'. PUBLISHED to kimbridges-documents as /mrc/ (see proj_kimbridges_documents.md
2026-11-06); verified live. Kim: 'I've wanted to do this document... for decades.'
