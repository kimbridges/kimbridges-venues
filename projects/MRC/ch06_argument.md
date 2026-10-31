# MRC chapter 6 -- Boundaries and error: the argument
_Adopted by Kim 2026-10-30 ("I like the flow of the arguments"); examples good for now; Kim will think of more between sessions._

**Thesis: the required accuracy of a measurement is set by its categories, not by its instrument.**
"How accurate must it be?" has no answer until you know where the boundaries are.

1. **Error is harmless in the middle, decisive at the edge.** 36.8 vs 37.0 C changes nothing; 37.9 vs 38.1 changes
   the diagnosis. What matters is error RELATIVE TO THE DISTANCE TO THE NEAREST BOUNDARY. Fig: the misclassification curve.
2. **Every boundary needs a rule for the value exactly on it.** >= 38.0 or > 38.0; a display of 38.0 covers
   37.95-38.05; the fuel gauge's 8 bars hide where each bar ends.
3. **When error is large relative to category width, institutions invent a BUFFER CATEGORY** -- guard bands,
   "elevated" BP, prediabetes, retest-before-deciding. A buffer category is error made visible.
4. **Cost places the boundary.** Cover plants at a 35 F forecast, not 32; the one-bar rule moves on a remote
   Interstate; warnings trade false alarms against misses. Fig: unequal costs slide the best threshold.
5. **Re-measurement and the boundary's ghost.** Averaging shrinks error, but anyone selected BECAUSE they crossed a
   boundary drifts back on recheck (regression to the mean) -- an artifact the boundary creates; why rules demand
   a second reading.
6. **Boundaries move while measurements stand still.** 2017 BP guideline. Data: NHANES.
7. **People are tuned to boundaries too.** Categorical perception (Russian blues); the flip side -- differences
   WITHIN a category go unnoticed (37.2 and 37.6 "both normal") -- hands off to ch.10.

**Ruling (Kim):** ch.6 covers a BOUNDARY VALUE shifting within a living category; ch.9 covers a category whose
ROLE changes.

**Worked examples, proposed order:** (1) misclassification curve; (2) cost moves the boundary; (3) NHANES 2017 BP;
(4) Eugene 32 F (Temperature_Patterns). Thresholds used in figures are ILLUSTRATIVE until verified.

**CHART RULE (Kim, 2026-10-30; applies to the whole trilogy):** when possible, include an INTERPRETATION NOTE that works
one example on the chart. For a new type of chart, the reader must be TAUGHT HOW TO READ IT.

**Figures built 2026-10-30** (scripts in R/, PNG 300 dpi + PDF in figures/):
- fig1 misclassification curve -- reading note: true 37.8 C, +/-0.2 C thermometer -> 16% of readings say 'fever'.
- fig2 cost moves the threshold -- reading note: a miss 5x worse -> call fever at 37.81 C. Key: cost moves the line ONLY because of error.
- fig3 BP reclassification, NHANES 2017-2018 (n = 5,232 adults, weighted, measured BP only): hypertension 19% (JNC7) -> 39% (2017);
  34% of adults changed label with no change in reading; 20% prehypertension -> stage 1. Bands run STRAIGHT across: the
  boundaries are nested, so nothing moves but the names. (Published figures incl. treated: 31.9% -> 45.6%.)
- fig4 Eugene frost, REAL data (GHCN-Daily USW00024221, Eugene Airport; cold seasons 1995/96-2024/25, 30 winters):
  (a) 5% of cold-season nights sit EXACTLY on 32 F -- the on-the-line rule (<= 32 vs < 32) changes frost nights from
  39 to 50 a winter (step 2 with real data); (b) moving the threshold 32 -> 33 F moves the last spring frost a median
  3.5 days, but 58 days in 2025 -- a boundary in TIME hypersensitive to a boundary in VALUE (bridge to S3).
  Curiosity to check: the count jumps at 32 F (31: 235 nights, 32: 334, 33: 339) -- observer heaping, or physics
  (latent heat holding surfaces near freezing)? If physical, nature makes the boundary 'sticky'.
- Data: Temperature_Patterns ran on SYNTHETIC data by default; fig4 uses the real station file, now in MRC/data.

**PERSONAL STORY (Kim, 2026-10-30) -- step 4, cost places the boundary:** freezing nights are burned into his childhood
memories. He grew up in Southern California surrounded by orange groves. On a night predicted to freeze, growers ran
SMUDGE POTS to moderate the temperature and save the crop, leaving a layer of black on everything -- a messy smudge that
took effort to remove. It didn't happen often in his area. Predictions mattered: running the protection had a real cost;
failure likely a much higher one. Kim: perhaps another link to the cost / measurement-error discussion.

Claude's additions (NOT ruled; verify): (1) the false-alarm cost was partly paid by NEIGHBOURS (the soot on Kim's house),
not only the grower -- who bears which error helps set the boundary; (2) crop damage depends on how cold AND for how long
-- a value-and-duration boundary (ch.7); (3) California's frost-warning service broadcast nightly forecasts to growers;
(4) smudge pots were later restricted for air pollution and replaced by wind machines -- a protection practice with a
lifespan (ch.9).

**PERSONAL STORY (Kim, 2026-10-30) -- numerical scores to LETTER GRADES:** "now so obvious I should have thought of it
earlier." Very big classes; he had to work out the letter-grade assignment very carefully. CRITERION: if ever challenged
in court, he could show the SAME STANDARD was applied to every student. Hard for borderline cases -- literally those
where ROUNDING ERRORS were involved. He developed criteria that could be COMPUTED to handle the "close to the line"
cases. Grades mattered greatly to the students. The system was used for THOUSANDS of students over the years; nobody
ever challenged a result.

Claude's mapping (NOT ruled): steps 2 (the on-the-line rule) and 3 (a computed rule for the borderline band, in place of
a buffer category); ch.5 FIXED vs contextual -- fixed and computable buys defensibility, the enforceability side of the
trade-off; echoes MWT's "reproducible rather than objective"; letter grades A-F are ~5 categories (Miller range).
ANSWERED (Kim, 2026-10-30): score = five exams, equal weight. BORDERLINE PREDEFINED (e.g. within 0.5 below the cutoff).
To be rounded up to the cutoff, a student had to pass ONE of three tests:
  1. only one very low score in the set (everyone can have a bad day);
  2. an upward trend in the scores (the student was learning how to learn);
  3. a final exam much higher than the previous exams (it is important not to give up).
The gradebook CALCULATED each measure and, if one applied, NOTED WHICH was used to round up. Classes of 300-500 students.

Claude (NOT ruled): the mean sets the category everywhere EXCEPT the band; inside the band, the SHAPE of the same five
scores decides (outlier, slope, final jump) -- a second feature of the same measurements (ch.7 tie). Each test encodes a
VALUE (bad day, learning, persistence). Rounds UP only -- the cost asymmetry of step 4, applied by rule. The predefined
0.5 band is a guard band set in advance (step 3); the gradebook note is an audit trail (reproducible, defensible).
Candidate figure: a simulated class of 400 -- the band, and which students each test rounds up.

**Kim, cont. (2026-10-30):** students did NOT know the borderline rules -- they would have argued they qualified, mostly
by trying to EXPAND THE BORDERLINE ZONE; with that many students and little time to grade, that would have been very
difficult. Other measures showed he was being as fair as possible, so not disclosing this one wasn't an issue.
**CAUTION (Kim):** he is a little nervous about writing up the borderline rules -- he never discussed them with his
colleagues. DISCLOSURE LEVEL IS KIM'S DECISION; do not draft the full rule set into chapter text until he rules.
**Origin of the "bad day" rule (Kim):** in his first year teaching a large class, a female student told him "you do know
that you're scheduling your exams 28 days apart." He changed the exam schedule and instituted the "bad day" rule.

Claude (NOT ruled): (1) the 28-day story is SYSTEMATIC error -- the measurement schedule itself, not chance, put the same
students at a disadvantage on every exam; the fix had two parts: change the measurement (schedule) AND add a boundary
rule. (2) Undisclosed rules: a published boundary rule elicits behaviour at the boundary, including NEGOTIATING THE BAND
-- a ch.3 point from the other side; transparency vs gaming is a trade-off (cf. unpublished enforcement tolerances).

**Kim, cont. -- correcting the EXAM itself (2026-10-30):** grade cutoffs PRE-ESTABLISHED (e.g. >= 90% for an A); all exams
multiple choice. If a student asked for clarification of a question during the exam, he noted which question. Scoring
included a statistical item analysis showing whether each question was statistically OK (he forgets the test). Any
question that needed an explanation (by at least TWO students) or failed the statistical test: ONE POINT ADDED to every
student's score. The question was NOT invalidated -- a student with the correct answer got TWO points. Announced to the
class: "I made some mistakes on the questions and I've given everyone credit to cover this mistake." Top students often
ran 110%. Everyone felt he was fair; never a complaint about his exams. Kim: "In a way, I was trying to remove error from
the measurement value (the exam score)."

Claude (NOT ruled): (1) THE MIRROR OF FIG 3 -- there the boundary moved and the readings stood still; here the READINGS
moved and the boundaries stood still. Arithmetically, adding a point to everyone = lowering every cutoff by a point;
socially they differ: "I made a mistake on the test" keeps the published standard intact. (2) Not invalidating the
item protects those who answered correctly despite the flaw -- fairness in ORDER as well as at the cutoffs. (3) A flawed
question is itself a category with a computed boundary (>= 2 queries OR fails the item test). (4) Disclosure pattern:
the INSTRUMENT'S error was announced; the BOUNDARY RULE was kept private (gaming). (5) Proposal: run the grading story
through ch.6 as one case -- fixed cutoffs; correcting the instrument; the band; the bad day as systematic error.
Verify: the item statistic Kim likely used (point-biserial / discrimination index -- ask, don't assume).

**Kim, cont.:** a side effect -- admitting to a few "bad" questions made him work very hard to minimise their number.
"Students get feedback on their exam performance with a score. In my case, I got feedback, too."
Claude (NOT ruled): the correction rule measured the MEASURER -- the count of flawed questions was the instructor's own
score, and the public admission made it a boundary that elicited behaviour in the person who set it (ch.3). Each exam
measured the students and, through the item analysis, the instrument; the instrument's error fell over time.
