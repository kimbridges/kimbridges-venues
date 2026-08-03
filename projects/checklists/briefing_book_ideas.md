# Briefing book / procedural checklist — ideation
_Started 2026-07-16 (design conversation; PAUSED awaiting Kim's thoughts on return). An

_ELEVATED 2026-07-16 (evening): this activity is now its own PKM project — see `proj_briefing_book.md` (umbrella for data-driven specimen collection). Kim confirmed the two-facing structure, primary deliverable = a per-site COLLECTION of PDF reports (field-friendly + shareable + reciprocal), Kīpuka Puaulu first. This file remains the design-conversation detail._
offshoot of the reopened `checklists` focus (time & phenology layer -> conflict-sheet scan
access -> this). Two linked concepts + a chapter architecture. Nothing built yet; this is the
plan, captured so it isn't lost._

## The core reframe: procedural checklist vs occurrence checklist
An OCCURRENCE checklist answers "what is here" (our published document, "A Checklist Is an
Argument"). A PROCEDURAL checklist answers "what should I DO while I'm here, and what will I
forget." The second question governs the value of an expensive field day (Kīpuka Puaulu =
hundreds of $/day: airfare, rental car, hotel), and it is underserved precisely because the
EASY, obvious tasks are the ones omitted under cognitive load. This is Gawande checklist logic
(surgery/aviation: competent people omit easy steps, not hard ones), and it is the pre-field
complement to vouchr's ATTENTION FRICTION (the crowded field moment overspends attention;
vouchr derives fixed data in post so field attention is preserved -- the briefing book
pre-loads reminders so field attention is free for the plant in front of you).
=> The briefing book is a MEMORY PROSTHESIS for a field day, not a species list dressed up.
Each chapter = a class of thing you'd otherwise forget.

## Part 1 — spatial scope as sensu lato / sensu stricto (Kim's concept)
Transpose the botanical s.l./s.s. idea from taxon circumscription to SPATIAL scope. The 2 km
circle is "Kīpuka Puaulu sensu lato" -- a pragmatic radius, not an ecological boundary; it
swallows the surrounding matrix (roadside/residential weeds; the Anderson forestry-trial
plantings: redwood, cypress, pines, pecan, walnut). "Sensu stricto" = the kīpuka proper (a
real, mappable feature -- a forest island in younger lava).
KIM'S CALL (2026-07-16): NESTED RADII is the more conservative approach (vs a hand-drawn
polygon), because a kīpuka is an unusual collection site; explore several radii + MAPPING with
rich map symbolism. So: kīpuka-core / 500 m / 2 km reported together, showing at which scope
each taxon enters. Payoffs + caveats:
- The s.l./s.s. DIFFERENCE is diagnostic: taxa appearing only in the s.l. halo are the matrix
  (planted trials, weeds). Contracting scope ~ separating "flora OF the kīpuka" from "things
  collected NEAR it" -- a different, often better question, not just a shorter list.
- HONEST OBSTACLE: many records are pinned to a single nominal "Kīpuka Puaulu" gazetteer point
  (the georeferencing-stacking finding from the book). A tight scope trusts precision the data
  lacks, so contracting drops some records that truly belong, only because coords are nominal.
  => the s.l./s.s. contrast is partly a test of the georeferencing, not only the flora (very
  "a checklist is an argument": the boundary is part of the claim, and the data fights back).
- Handle via nested scopes + a per-taxon "scope membership" (core vs halo vs
  dropped-only-due-to-imprecision, flagged separately).

## Part 2 — the briefing book / collecting guide (chapter architecture)
Each chapter = a class of forgettable thing. First cut (built only on what we already have):
1. THE PLACE, AT SEVERAL SCOPES. Nested-radii map, rich symbolism (core / 500 m / 2 km);
   orients collecting geography. Part 1 as the opening.
2. THE BASELINE CHECKLIST, SCOPE-AWARE. Our occurrence list, refined by radius + annotated
   (status, lifeform) -- the reference layer the rest acts on ("known to be here, at what scope").
3. EASY WINS. Singletons + stale-but-common taxa: low effort, high record value, forgotten
   because unexciting. "Cheap -- grab them while you pass." (Singletons are NOT necessarily
   rare; likely EASY to collect -- you just need the reminder that they're cost-effective.)
4. HIGH-VALUE TARGETS. Stale natives/endemics (persistence checks; fresh DNA/phenology
   material); taxa the record leans on one collector / the 1980 campaign for. Kept SEPARATE
   from ch.3 so "easy" and "important" don't conflate.
5. CONTESTED IDENTITIES. The det-conflict sheets + their diagnostics (see
   conflict_diagnostics.md) -- a fresh clean collection dissolves a phantom pair on the spot.
6. FINDABILITY + HONEST LIMITS. Which targets have real coords (go straight there) vs nominal
   stacks (go hunt); + what the record CAN'T tell you (no flowering-month guidance; staleness =
   thin collecting, NOT rarity). The caveats travel into the field, not a methods section.

## Two registers (a real tension)
A briefing book has two registers that conflict: the DISCURSIVE document you read the night
before, vs the ONE-PAGE ranked FIELD CARD you actually carry (you cannot read a book while
collecting -- attention friction again). Proposal: the book ENDS in the distilled field sheet;
that sheet is where this rejoins vouchr -- the target sheet could be emitted as a vouchr CARD DECK.

## The honest caveat (build it in from the start)
At an undercollected, campaign-driven site, "not collected since 1930" = "nobody has been here
with a press since 1930," NOT "rare/gone." Staleness is a COLLECTING-EFFORT signal, not a
rarity/extinction-risk signal. Fine for maximizing field-day value (that IS finding where the
record is thinnest), but the list must never be read as a conservation/rarity ranking -- a
stale weed and a stale endemic have equally thin records for different reasons. STATUS
weighting is what separates "worth a voucher to complete the record" from "worth a trip
because endemic."

## Objective function (different goals -> different rankings)
No single universal weighting. The tool should let you DECLARE the goal and re-rank:
(a) complete/harden the digital record (all singletons + stale, any status);
(b) fresh endemic material for DNA/phenology (stale natives/endemics up);
(c) resolve contested IDs (det-conflict sheets + kin);
(d) rediscovery of possibly-lost taxa.
FINDABILITY (staleness + real georeferencing precision) is the JOIN between Part 1 (space) and
Part 2 (time): a stale taxon known only as a nominal stack is a poor target -- you don't know
where to look. Phenology would be the third leg (WHEN to go) but the herbarium can't supply it
here, so the briefing honestly gives WHAT + roughly WHERE, not WHEN.

## Generalization question (the project's recurring arc)
Kīpuka-specific document, or a general `checklistr` capability that emits a briefing book for
ANY site (e.g. `briefing_book()` / `field_targets()`)? The arc (explore -> package) says the
general tool is the destination; the Kīpuka book is how we DISCOVER what the chapters should be.

## OPEN — Kim to answer on return (2026-07-16 pause)
1. WHICH REGISTER is primary: the read-before DOCUMENT (the argument), with the field card as
   its distilled tail -- OR is the FIELD CARD the real deliverable and the book its
   justification? (Changes which end we build toward first.)
2. Kim's broader thoughts on the two concepts (mulling them over the break).

