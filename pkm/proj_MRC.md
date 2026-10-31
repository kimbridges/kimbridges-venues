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
location is open; language comes early (ch.2). Work begins on CHAPTER 6, Boundaries and error.

## Locations
- Code: G:\My Drive\Projects\MRC\R
- Figures: G:\My Drive\Projects\MRC\figures
- Data: G:\My Drive\Projects\MRC\data
- Ideas (trilogy-level capture, the source of record for the argument so far): Projects_Index/ideas_three_documents.md
- Docs/output: kimbridges-documents (planned)
- GitHub: not yet

## Key Files
- Projects/MRC/ch06_argument.md -- chapter 6 argument (7 steps), adopted 2026-10-30
- ideas_three_documents.md -- trilogy capture; MRC rounds two (2026-09-23) and three (2026-10-30), outline, rulings, verify lists

## Track
R on Kim's machine (ClaudeR bridge): destined for documentation; may draw on whittakerr, bbSynth and
Temperature_Patterns. MRC's figure style is to become the trilogy's shared visual vocabulary.

## Related Projects
- Trilogy siblings, still at capture: MWT and S3 (in ideas_three_documents.md; no proj files yet).
- proj_Voronoi.md / proj_tessellr.md -- the Voronoi document MWT cites.
- proj_whittakerr.md (ch.7, several measurements -> one category); proj_bbSynth.md (ch.8, class boundaries);
  proj_Temperature_Patterns.md (Eugene 32 F -- a ch.6 candidate); proj_Smart_Car.md (the fuel-gauge ladder).

## Next Steps
1. Chapter 6 worked examples, proposed order: (1) misclassification curve at 38.0 C (simulation -- the chapter's
   central figure); (2) cost moves the boundary; (3) NHANES, the 2017 blood-pressure reclassification; (4) Eugene
   32 F. Kim chooses the start.
2. Chapters 7-8: worked examples with data.
3. Ch.2: the AI-elicitation worked example (comfort-word boundaries by city vs climate; NWS local criteria).
4. Work the verify lists in ideas_three_documents.md before production writing.

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
