# Concept: the "80% tool"
_Tag: **80% tool**. Seeded 2026-07-17 from a briefing_book design conversation (Kim + Claude). A concept to BUILD ON
— not now (other things to finish), but not far off. This is the stash._
_Updated 2026-07-26 (Kim + Claude): the UNBOUNDED-OUTPUT property, the ZERO-LATENCY LOOP (a friction argument), the
map-centre worked example, the economics of unbidden observations, and Diamond's dilemma as the expertise condition._
_Updated again 2026-07-26 (Kim supplied the article scan): Diamond citation CONFIRMED and expanded — the informant
THROTTLE mechanism, the Bulmer rocks story, Diamond's own "metaphor for much of modern life" generalization, and the
disanalogy that does the real work (the engine has no competence detector, so the naive user gets MORE, not less)._

## The idea, in one line
An **80% tool** gives you the DATA, not the ANSWER. The code produces the numbers and figures (~80%); the
interpretation — the honest reading, the "what this means and what to do about it" — is the remaining ~20%, and it is
where the value concentrates and is irreducibly COLLABORATIVE.

## The sharper claim (Kim, 2026-07-26): the tool's output no longer BOUNDS what you get
The 2026-07-17 framing above is a STATIC split: code makes numbers, the collaboration makes sentences about them.
Kim's 2026-07-26 statement is stronger and is the part to build on.

A function returns what its author decided it would return. Every guard inside an ordinary tool is a failure mode
somebody ANTICIPATED: `if (any(duplicated(x))) warn()` exists only because a person thought of duplication and wrote
the check. The output space is fixed at authoring time.

Hand that same tool to the AI engine and you get the expected result PLUS observations nobody specified. In one run it
is apparent duplication. In another it is a suspicious gap in the date range. In another it is that the points form a
ring with an empty middle. **WHICH observations appear depends on what the data turned out to be**, so they cannot be
enumerated in advance — which is exactly why they could never have been coded.

This is not "a longer list of checks." It is the removal of the requirement to enumerate the checks at all. That is an
unusual property for a programming tool and it is the crux of the concept.

So the shape is: **expected result → unbidden interpretation → open follow-up.**

## The ZERO-LATENCY LOOP (and why this is a friction argument)
"Every good study should end with a suggestion for the next study." The classic version of that sentence is inert.
Suggested-future-work is the least-acted-on paragraph in scientific writing: by the time it is written the analysis is
frozen, the funding is spent, the data is archived, and the author has moved on. Latency is measured in years and
usually runs to never.

The 80% tool version has **no latency**. The suggestion arrives while the data is still loaded and acting on it costs
one more exchange. The follow-up is not a recommendation to a future reader. It is executable now, by the person who
just saw the anomaly, while the context that makes it meaningful is still in the room.

**This belongs in the FRICTION taxonomy** (proj_briefing_book.md), which so far names attention, cost/logistics,
cognitive/omission, access, and knowledge friction. Add:
- **Follow-up (iteration) friction** — the cost and delay between noticing something and acting on it. Traditionally
  enormous (re-open the analysis, re-run the pipeline, re-acquire the context, or more often: never). Here, ~zero.

Friction is the spine that runs through the whole cluster; the 80% tool is the same argument applied to the analysis
step rather than the field day. Same theme, different stage.

## Worked example — the map centre (the full loop in ONE exchange, day one)
This was previously filed under "human corrections" below. It belongs here instead: it is the cleanest single instance
of the whole mechanism.

1. **The tool did its job.** Pull occurrence records for a coordinate near Kīpuka Puaulu. It returned records.
2. **The unbidden observation.** The records were arranged in a RING with an empty middle. No function checks whether
   points form a donut. Nobody would write that check — until that moment nobody had a reason to. The observation was
   entirely data-dependent.
3. **The expert supplied what only the expert had.** Kim: the loop-trail centre is **19.44095, -155.30295**; the query
   centre was ~850 m off.
4. **Acted on immediately.** Re-pulled at the true centre: **224 records / 100 taxa within 2 km**, versus the
   mis-centred 379/150. This became THE CANONICAL ANCHOR for everything downstream, and a planted forestry-trial
   cluster fell outside the true radius as a bonus cleanup.

Nothing about steps 2-4 was designed. A stand-alone R pipeline would have returned the mis-centred 379 records,
silently, and every report built on them would have been wrong in a way no error message would have surfaced.

### Precondition: cheap graphics (Kim, 2026-07-26)
The donut was noticeable because a MAP GOT MADE. Making a map used to be a chore serious enough that you made one at
the end, to illustrate a conclusion you had already reached. It is now routine enough to make one at the START, as a
look. **If the map is expensive, no map gets made, the ring is never seen, and the 850 m error propagates into every
report.** So near-zero-cost visualization is not a convenience here. It is a PRECONDITION for the unbidden observation:
you cannot notice a spatial anomaly in a table of coordinates. Generalize: the cheaper the look, the more anomalies
are available to be noticed.

## Evidence (the briefing_book day, 2026-07-16/17)
The functions produced: month distributions, first/last years, an IUCN code, a Whittaker label. The value was in the
reading of them:
- month histogram  ->  "a collecting calendar, not a flowering calendar"
- first-detection year  ->  "detection != arrival; that's the 1980 survey, not an invasion"
- IUCN 'EN' on Pyracantha  ->  "irrelevant; an alien weed here" (global vs local)
- 'Temperate seasonal forest'  ->  "the whittakerr anomaly" (a tropical, montane, aseasonal site)
- staleness rank  ->  "Cibotium is abundant; staleness = a collecting gap, NOT rarity"
And the sharpest readings were the HUMAN's corrections: a 1929 sheet can't carry a GPS fix (-> the 'locate' tier); the
western cluster is Kīpuka Kī; a stale endemic and a stale weed mean opposite things (don't target the endangered one).

## The economics (why a mediocre hit rate is still worth having)
The property that produces the useful unbidden observation produces the confident WRONG one at exactly the same
fluency. `findable = Y` stamped on a 1929 sheet was not a tool failure. It was the engine volunteering an
interpretation that was plausible, well-formed, and false. Kim caught it because GPS did not exist in 1929.

So the honest statement of the method is NOT "the engine notices things." It is:

> The cost of surfacing a candidate observation has collapsed to roughly zero. That makes an unremarkable precision
> rate worth having — **provided someone competent evaluates each one.** The precision did not improve. The economics
> changed.

Consequence: adjudication is not a quality-control step bolted on afterward. It is the condition under which the
output means anything at all. An unbidden observation is a PROPOSAL WITH NO RELIABILITY GUARANTEE ATTACHED. Its value
comes entirely from being cheap to generate and fast for an expert to evaluate.

## Diamond's dilemma — expertise is a VALIDITY CONDITION, not a benefit (Kim, 2026-07-26)
Kim's parallel: **Jared Diamond, "The Ethnobiologist's Dilemma," _Natural History_ 6/89 (June 1989), pp. 26, 28, 30.**
Part of his "Nature's Infinite Book" column. Standfirst: _"How do we open the pages of walking encyclopedias, be they
New Guinea tribesmen or car mechanics?"_ **CITATION CONFIRMED 2026-07-26** — Kim supplied a scan of the article; the
earlier CONFIRM flag is cleared and Kim's recollection (Natural History, 1989, vol. 6) was exact. The essay opens on
Diamond's car mechanic and closes on the Kalam, which is why the "walking encyclopedia" framing generalizes so easily.

Diamond's paradox, in his own words: _"You have to know almost as much about the local birds as the tribesman you're
interviewing if you're to succeed in learning his names for birds."_ Without that knowledge you cannot ask the right
follow-up, cannot tell a real distinction from an artifact of the question, and cannot detect when you have been
misunderstood. Knowledge is a precondition for eliciting knowledge.

The 80% tool has the same structure. You need the expertise to hold the tool properly. The engine's unbidden
observations are only usable by someone who can tell the real ones from the plausible-and-false ones, and that
someone must know the domain before the session starts.

### The mechanism Diamond actually names: the informant THROTTLES on perceived competence
This is the part worth having the article for, and it is stronger than the paraphrase this note carried before. The
failure is not merely that the naive interviewer misunderstands the answer. It is that **the informant deliberately
gives less.** Diamond: _"your informants will perceive correctly that you can't grasp all the complexities of their
knowledge, so they'll tell you only as much as they think you can understand"_ and _"hunters are likely to give you
oversimplified information, or no information at all, if they sense that you yourself don't know much about the
subject."_

The Bulmer rocks story is the clean demonstration. Ralph Bulmer spent years with the Kalam, co-authored _Birds of My
Kalam Country_ with the Kalam naturalist Ian Saem Majnep, and recorded Kalam names for 137 of the 140 bird species
Western ornithologists found in the area. He asked about rocks and was told the Kalam did not classify them. He
returned with a geologist friend, who had a long classification by texture, colour, locality, hardness and use inside
an hour. Bulmer, to his Kalam friends: _"How could you lie to me?"_ Their answer: _"When you asked us about birds and
plants, we saw that you knew a lot about them, and that you could understand what we told you. When you began asking
us about rocks, it was obvious you didn't know anything about them. Why should we waste our time telling you something
you couldn't possibly understand?"_

Diamond generalizes it himself, in the last line of the essay: _"To them that already understand, more knowledge will
be freely given. To the rest of us dolts, it's a struggle."_ He is explicitly offering the dilemma as **"a metaphor for
much of modern life,"** which is licence for exactly the transfer Kim is making.

His stated remedy is also the collaboration framing, arrived at independently: _"The second-best alternative is for
ethnobiologists to collaborate with biologists who already have that competence."_ Compare the reframe section below.

**The failure mode is invisible from inside — in both cases.** A naive ethnobiologist does not know the interview
data is thin or garbage. A naive tool user does not know `findable = Y` is wrong. Nothing in the output announces it.

### The disanalogy is where the sharpening comes from: THE ENGINE HAS NO THROTTLE
Diamond's informants run a competence detector and reduce their output when it trips. That is a safety mechanism,
however unwelcome — a thin answer is at least visibly thin, and Bulmer noticed the gap eventually.

**The AI engine has no such detector, and no such throttle.** It answers a naive question at the same length,
confidence and typographic polish as an expert one. So the asymmetry:
- Diamond's under-qualified interviewer gets LESS. The dominant failure is OMISSION, and the informant's withholding
  is, perversely, a form of quality control.
- The under-qualified 80%-tool user gets MORE — a great deal of confident, fluent, well-formatted material. The
  dominant failure is COMMISSION, and it does not look like failure.

_Qualifier, so the contrast is not overdrawn: Diamond documents commission too. The picture method produced
confidently wrong names — his guides supplied `belamar` for a frigatebird when they meant `pitikole`, the willie
wagtail; of 275 bird names elicited from Aguaruna Jívaro informants, fewer than half were judged valid. So the two
cases differ in which failure DOMINATES, not in which failures are possible._

The volume of confident output went up; the ability to filter it did not, and the informant-side brake that Diamond
describes does not exist here at all. So the cost of missing expertise is HIGHER than in Diamond's case, not lower.
"You need knowledge to use it successfully" is the mild statement. The sharp one: without the knowledge you are worse
off than with no tool, because you now have plausible answers instead of an honest blank.

### Open tension (do not resolve yet): the teaching case
If expertise is the validity condition, then handing these tools to STUDENTS is precisely the case where they fail
worst — and students are exactly who a "how to work this way" piece would be aimed at (see To build on, below).
Bears on the AI_Microscope thread too, which is a teaching tool by design. Unresolved. Worth its own thinking:
possibly the answer is scaffolds that make the adjudication step visible and required rather than optional.

## The reframe (the part to build on)
Not "tools for the R user to apply" (which assumes human = operator, reading = a write-up afterward) but **instruments
for the COLLABORATION to use**: the AI wields the tools and drafts the first-pass interpretation; the human supplies the
ground truth and judgment the AI structurally lacks. The **collaboration qualifier is load-bearing** — the value came
from the friction between AI-draft and human-correction, not from either alone. Left to run autonomously the AI would
have shipped 'findable = yes' on a 90-year-old sheet and a target list pointing at an endangered species.

## Already designed for this (unnamed until now)
checklistr's philosophy — SURFACE duplication, determination conflicts, and digitization gaps rather than hide them
(det_conflict, status_agree, the map that shows nominal stacking) — is already "tools built for interpretation": their
job is to hand the collaboration the things that need a reading. Kim built the model before naming it.

## Design consequence (bears on the report-emitter)
The CODE generalizes to any site; the READING does not (fully). Kīpuka Kī, the Whittaker anomaly, the conservation
nuances were all local and all required the human. So the report-emitter should be a **scaffold the collaboration
fills, not a push-button**: ~80% assembles itself, the last mile is irreducibly collaborative. That is the shape of the
thing, not a limitation to engineer away.

Added 2026-07-26: the emitter should also be built so the LOOK IS CHEAP at every stage (see the cheap-graphics
precondition). Anomalies you cannot see, you cannot adjudicate.

## Naming
Closer to a METHOD than a tool (cf. whittakerr's "document method"). A tool extends the hand; a method extends the
reasoning. Working framings: "interpreted instrument", "instrumented method". The functions are the vocabulary, the
collaboration is the sentence, the reading is the meaning.

## To build on (later)
- Does the 80/20 split hold beyond herbarium data? Test the concept on other tool families (seasonalityr, coenosr, ...).
- Design the report-emitter as an explicit scaffold-for-collaboration (interpretation checkpoints per site).
- Connect to the queued whittakerr-era meta-observations (collaborative development; AI drafts / human finishes; route
  each task to whoever does it well). This may be the clearest single statement of that whole thread.
- Possible artifact: a short, honest account of "how to work this way," aimed at researchers/students (flagged
  2026-06-24 as a future piece). NOTE the teaching tension above — that piece has to address it, not skip it.
- ~~CONFIRM the Diamond citation~~ **DONE 2026-07-26.** Kim supplied the scan. Full citation now in the Diamond
  section above and safe to use in published work.
- **Follow the throttle disanalogy.** Diamond's informants withhold from the under-qualified; the engine does not.
  If the informant's brake really is a form of quality control, the question for the teaching case below is whether a
  scaffold can SIMULATE that brake — an engine that gives less, or gives it more tentatively, when the user has not
  demonstrated competence. Probably unwelcome to build and probably the honest thing to want.
- **Collect more instances of the unbidden observation** as they happen, with the same 4-step anatomy used for the map
  centre. Two or three more worked examples turn this from an argument into evidence. Candidates already in the
  record: the 39% coarse-gazetteer / whole-arcminute DMS rounding artifact; uluhe absent at the site but 23 records
  regionally (-> the present-but-unrecorded guard); ʻIliau's 31% canyon-floor records (-> the elevation discriminator).
- Test whether the 80/20 ratio is even the right description. An alternative reading: the code does the part that is
  SPECIFIABLE IN ADVANCE, and what remains is not 20% of the labor but the fraction that DETERMINES WHETHER THE RESULT
  IS ANY GOOD. Disproportionately load-bearing, and the percentage may be a misleading way to say it.
