# MRC chapter 10 -- The inverse: notes
_Started 2026-11-01._

**Kim's hypothesis (2026-11-01):** bunching comes when there is some sort of PENALTY OR REWARD for being in a particular
category -- marathons: bragging rights / personal gratification; taxes: a true financial cost; exam scores: grades and
the rewards/penalties of a different grade.

**Evidence assembled (fig1, scripts in R/, figures/):**
- (a) Boston Marathon 2001-2014, 268,615 finishers (llimllib/bostonmarathon, GitHub): the minute after each half hour
  holds fewer finishers than the minute before -- 16% fewer at 4:00. Reward = self-set goal (no prize at 4:00).
  Literature: Allen, Dechow, Pope & Wu (2017) Management Science, 9.5 million times; bunching at round numbers
  attributed to effort and planning near the finish, not to explicit rewards (NBER w20343).
- (b) England & Wales house sales 2013 (Land Registry Price Paid, 791,669 standard sales): 17,197 at exactly
  250,000; only 72 at 250,001-252,500. 2013 stamp duty = SLAB: 1% of the whole price to 250,000, 3% above (VERIFY rates).
  Same at 125,000: 13,233 exactly vs 2,451 at 125,001-127,500. Also visible: heaping at every round 5,000.
- Exams (no data in hand): Polish matura 2011 basic Polish -- spike at the pass mark, dip just below; the advanced exam
  (no pass/fail) is smooth (Freakonomics 2011, from a reader's data; secondary). Literature to check: NY Regents
  bunching at 65 (Dee, Dobbie, Jacob & Rockoff 2019).

**Claude (NOT ruled):** three mechanisms behind a bunch -- (1) the MEASURED thing changes (runners speed up);
(2) the TRANSACTION is set to the line (house prices, a negotiated number); (3) the RECORDED value is moved (graders).
Separate from HEAPING (rounding/reporting -- Eugene 32 F, round 5,000 prices). The reward/penalty size predicts the
bunch: a tiny marathon dip vs a near-empty band above 250,000. Note the on-the-line rule again: tax applied ABOVE
250,000, so 250,000 exactly is the safe side (ch.6 step 2).
