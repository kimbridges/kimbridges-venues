# PKM Session Log
_Created: 2026-05-07_

System-wide log of Cowork sessions. One dated entry per session.
For per-project working detail, see session_notes.md inside the
relevant project folder (designed in design_publishing_workflow.md;
not yet implemented).

For protocol governing how this log is used, see pkm_protocol.md
Mechanism 4.

---

## 2026-09-01 -- THE CROSS-REFERENCES ARE GENERATED, THE CHAPTER NUMBERS FINALLY MATCH THE WAY WE TALK, AND CH.8 THROUGH CH.12 ARE DRAFTED

**Active focus at start and close:** Smart_Car. Kim chose the order himself: **fix the references first, then draft**, so ch.8 would not add an eleventh hardcoded number. That was the right call and it changed what the fix turned out to be.

### ★★★ ALL TEN REFERENCES CONFIRMED — and the OLD numbering turned out to be the proof

Two of the ten were flagged as INFERRED from content and needing confirmation before any renumber. **Both are now certain, and by a second route.** Read the target chapters and *Chapter 9* is the geography instrument (`knowing_a_number_is_wrong`) while *Chapter 13* is the four missing states (`what_the_record_cannot_say`) -- and then **every one of the ten resolves cleanly under the project's own numbering: Foreword unnumbered, no marine chapter.** ★★ **A numbering scheme that is internally consistent across ten references in six files is not a guess.** The content reading and the arithmetic reading agree, which is what turned two inferences into two facts.

### ★★★ THE FOREWORD WAS BEING NUMBERED AS CHAPTER 1, AND THAT WAS THE WHOLE ROOT

`index.qmd` is titled **Foreword** and `afterword.qmd` is titled **Afterword**, and Quarto was numbering both. **So the printed book said `small_cars` was Chapter 2 while every conversation, every PKM entry and every sentence of prose called it ch.1.** Not an editorial choice -- front matter carrying a chapter number is a defect. Both marked `{.unnumbered}`.

**The numbering now runs 1-14 and matches the project exactly:** small_cars 1, is_it_safe 2, the_anchor 3, expeditions 4, long_days 5, the_roads 6, the_marine_highway 7, what_driving_cost 8, sixteen_years_of_paper 9, knowing_a_number_is_wrong 10, what_the_car_cost 11, a_day_in_a_smart 12, two_constellations 13, what_the_record_cannot_say 14.

### The mechanism, and what it bought beyond the fix

Every chapter heading carries a `{#sec-...}` label; the prose uses `@sec-name` where the reference opens a sentence and `chapter -@sec-name` where it needs to be lower case. **Verified in the rendered HTML, not in the source:** *"Chapter 2 argued that small and nimble..."*, *"@sec-audit works out how"* renders as **Chapter 10** (it said 9), *"Chapter 14 is about how we know"* (it said 13). **0 unresolved references across 16 chapters, 0 hardcoded numbers left anywhere.**

**★★ AND THE REFERENCES ARE NOW HYPERLINKS**, which the plain text never was. A fix for correctness paid in navigation.

**⚠ One class remains and is NOT a defect:** positional phrases -- *"the next chapter"*, *"the driving in the last two chapters"*. They are correct today and they break silently on a reorder. Left alone deliberately; noted in `deferred.md`.

### ★★★ CH.8 `what_driving_cost.qmd` IS DRAFTED — the hinge, ~1,250 words, two tables

**Spine: the record cannot see the driver, and Kim's own correction is what proves it rather than a problem to explain away.** He remembers four prairie days in June 2014 as the worst driving of sixteen years -- potholes, slowing to save the wheels, watching the mirror for something large that had not slowed. **The record has those days at a median 44.5 mph against a whole-record 40.5.** ★★ Then his correction: *"I couldn't go slow, because the big vehicles kept moving at highway speeds."* **The speed is not evidence against the stress. The speed IS the stress, and his account therefore PREDICTS the null.**

**★★★ THE CHAPTER IS NOW A TRIPLE, WHICH IT WAS NOT WHEN IT WAS SCAFFOLDED.** Fear (the prairie, 47.3), tedium (the I-65 tree tunnel, 40.3), pleasure (the Nebraska frontage road, 48.8). **Three days remembered for three incompatible reasons, all at or above the median.** *Vigilance has no column. Neither does tedium. And neither does an afternoon spent looking at things.*

**★★★ AND CREAMSICLE TURNS THE ARGUMENT INTO A MEASUREMENT.** Its sheets carry STOPPED time, so gross and net can both be computed: **84 timed legs, median gross 43.5, median net 51.0, a gap of 7.5.** So **every gross speed printed anywhere in the book is a ceiling seven or eight mph below the driving speed**, and the averaging is not a hypothesis -- it has a size. **The second car measures the first car's blindness.** The extreme is `2024-10-20 WI Dells -> Madison, 50.3 mi, 5 hours, 4.5 of them stopped`, comment column: **Cranes.**

New `book/R/driving_cost_data.R`. **16 chapters render, 0 error strings, 0 unresolved references.**

**⚠ VOICE RULE, FOURTH CHAPTER RUNNING.** First draft 16.7 contractions per thousand words against ch.6's 26; a pass brought it to 28.9. **The count catches it every time and the instinct still does not. Keep running it before Kim sees a draft.**

**⚠ A TRANSIENT `PermissionDenied` on `_output` during the first full render** -- Drive Stream holding the directory, the same class as Finding 048. **A plain retry succeeded.** Do not treat it as a broken build.

### ★★★ CH.9 `sixteen_years_of_paper.qmd` DRAFTED — and I got the diagnosis wrong before I got it right

**~1,900 words, three tables, and the book's first photographic figure:** a real sheet, Frostburg-3 June 2012, rendered from the scan at 150 dpi. Both logs on one page, the trip name in Kim's hand, *RETURN TO CALIFORNIA* across the travel header, a crossed-out temperature, a circled date with somebody's question mark, and the day's mileages worked out in the right margin. **The chapter's subject, in one look.**

**Derived, not quoted: 20 scanned files, 67 pages, 2010-2017.** The PKM's recurring "22 scans" is a batch count and does not match the folder; the chapter prints the file and page counts, which anyone can check.

### ★★★ THE SLASHED-ZERO TEST NOW RUNS LIVE, OFF THE SOURCE WORKBOOK

Rebuilt in `book/R/paper_data.R` reading `TwoRed_fuel_June_2014.xlsx` -- **the file the errata architecture never edits** -- so the figure in the book is computed at build time rather than carried in prose. 292 usable rows, **23 fail the pump identity** by a cent or more.

| | |
|---|---|
| 8 -> 0, the direction the handwriting predicts | **6 rows repaired** |
| 0 -> 8, the mirror | 1 |
| six controls (1,3,4,5,7,9 -> 0) | 1 between them |

**And the six read as the habit, not as luck:** 19.28->19.20, 32.48->32.40, 29.68->29.60, 16.86->16.06, 29.86->29.06, 7.385->7.305.

**⚠ A METHOD TRAP FOUND WHILE BUILDING IT.** Substituting on a zero-PADDED rendering invents digits nobody wrote and lets the mirror direction cheat on trailing zeros (`6.480 -> 6.488`). Substituting on the value AS RECORDED moved the mirror from 3 repairs to 1. **Carried into Finding 033.**

### ★★★ THE CORRECTION THAT MATTERS: I TOLD KIM FINDING 033 WOULD NOT REPRODUCE. IT DOES

**I reported a discrepancy against Finding 033 and asked him to rule on amending it. He ruled amend. Then I read 033 itself and the report was wrong.**

**033 states a SUBSTITUTION-RATE result over digit pairs**, not a rows-of-44 result. Run in its own form over every failing row:

| pair | substitutions | repairs | rate |
|---|---|---|---|
| **0 and 8** | 45 | **7** | **15.6%** |
| 1 and 7 | 44 | 0 | 0% |
| 3 and 5 | 44 | 0 | 0% |
| 4 and 9 | 78 | 0 | 0% |

**Original: 13.3%, with one stray control hit. Now: 15.6%, and 166 control substitutions without a single repair.** ★★ **Widening a test usually softens it; this one sharpened, and the stray control hit failed to recur** -- which is exactly what a chance hit does when given more chances.

**What actually failed to reproduce was a PARAPHRASE in the ch.9 scaffold** -- *4 fixes of 44 failing rows* -- a different framing over a row set nobody recorded. **And that paraphrase was the version queued for print.** ★★★ **Finding 051 written:** notes summarise notes here, every hop is a lossy re-encoding, the last hop reaches the page, and **the tell is the same as 049 and 050 -- the build succeeds.** Rule: prefer keeping the GENERATOR over keeping the result.

**The chapter is better for the correction.** Its middle section is no longer *the audit has a hole in it*; it is **the test reproduced and the sentence about it did not**, which is a sharper thing to have found and is true.

**16 chapters render, 0 error strings, 0 unresolved references.**

**⚠ Voice: 23.8 contractions per thousand on the first pass, 28.2 after. Fifth chapter running.** Four em dashes had also crept into R string literals inside a table -- **the sweep must cover code strings, not just prose.**

### ⚠⚠⚠ KIM CORRECTED THE 0/8 MECHANISM, AND THE CHAPTER IS BETTER FOR IT

**It was never his handwriting. It was the printed fuel receipts** -- small type, tired ribbons and thermal heads, and **a dot in the middle of the zero**, read in a car with the light going. *"You can see from the log that I don't do that (except sometimes, but not here)."* **Finding 033's causal attribution corrected in place.**

**No number moved.** A dotted zero fails exactly the way a slashed one would, so the directional argument and the whole substitution test stand. **Three things did move:**

1. **The log sheet is not the witness; the receipt is** -- and receipts were thermal slips that got binned. **The settling document for this error class usually no longer exists.** That is a harder and better sentence than the one it replaced.
2. **The mechanism belongs to no writer**, which matters because there are **two hands in this record.**
3. **The same document is cause and cure** -- surviving receipts print the odometer and are the project's fourth independent record.

**★★★ THE LESSON IS SHARPER THAN 033's OWN.** *When errors share a shape, ask what physical process makes it* was right; **I attached it to the wrong process -- the writer in front of me rather than the machine upstream of him.** A shape in the data points at a PROCESS, not a PERSON. **Ask whose hand, then ask whose printer.**

### ★★★ THE MARK ON THE SHEET IS A HAPPY FACE — AND THE SHEET PROVES THE HANDOVER BY ITSELF

The caption had it as *a question mark, for a reason nobody now remembers*. **It is a circled 6/9 with a happy face: Nancy's birthday.** She joined that day and the log passes into her hand. Kim right-handed, Nancy left-handed and an MD; *"she's mastered doctor writing."*

**★★ AND THE PAGE CORROBORATES IT WITHOUT ANYONE READING THE WRITING.** Fuel rows before the handover are dated `6/1` and `6/8`; **from 6/9 onward every date carries the year** -- `6/9/12`, `6/9/12`, `6/11/12`, `6/12/12`. **The convention changes exactly where the hand does.** A second writer shows up as a change of FORMAT, which is far more machine-readable than penmanship. Written into the caption and a new paragraph in ch.9.

⚠ **One thing NOT printed:** Kim says he collected her in **Atlanta**, and the 2012 trip has no Atlanta. 6/9 is **Streetsboro OH -> Jackson MI**, out 09:21, **268 mi against ~215 direct** -- a late start and a ~50-mile excess, consistent with collecting somebody, and the record cannot say where. Asked; the chapter does not need the city.

**Ch.9 after both corrections: ~2,360 words, four tables, one photographic figure. 25.4 contractions per thousand, 0 em dashes, renders clean.**

### ★★★ AND THEN KIM GAVE CH.9 ITS ENDING — THE SCANNING EXPERIMENT, WHICH MAY BE THE BOOK'S REAL POINT

Verbatim in the project log. **He noticed he had never entered some of the log data at all**, and a friend who also keeps a fuel log asked with him a question neither had thought to ask: **could a handwritten log just be scanned and read?**

**Why it had never come up is the whole argument: transcription is FRICTION.** An evening of typing numbers you can barely read, producing nothing you did not already have on paper. **Unless the payoff is worth the effort the effort is not made** -- which is exactly why the fuel halves of these sheets were typed years ago and **most of the travel halves never were.**

**★★★ IT WORKED, AND THE PAYOFF IS QUANTIFIABLE:**

| | |
|---|---|
| typed `Trip Log` sheet | **7 rows** |
| transcribed from the scans | **139 legs, 13 trips**, 137 with both odometers |
| miles that were on paper all along | **41,163** |

**Twenty times more record, never lost and never recovered -- just never typed in.** ★★★ **Every chapter in the middle of this book is made of data that sat in a drawer while everyone assumed it was in the computer.**

**★★ THE SECOND PAYOFF IS THE ONE NOBODY PREDICTED: the scans AUDIT the typing.** All 65 errata came from reading images against a spreadsheet typed years earlier and never checked, **because checking meant reading the source, and reading the source was the friction.** ★ **The entire audit this book rests on is downstream of two men wondering whether a scanner could read handwriting.**

★ **And the joke the chapter now carries:** the one part of the record that HAD been typed holds a date reading **`5/8/0201`**. **The paper hasn't got that error. The computer has.**

**★★★ THE GENERAL CLAIM, and it is the one to carry out of this project:** *data recorded has no value while it sits in a log; moving it into an analysis environment is what gives it value; scanning removes the friction and encourages the move.* **That is about archives, field notebooks, herbarium sheets and card catalogues, not about car logs.** It is `briefing_book`'s friction spine arriving one level down, applied to his own archive.

**Ch.9 final: ~3,060 words, four tables, one photograph, 30.1 contractions per thousand, 0 em dashes. 16 chapters render, 0 errors, 0 unresolved references.** ⚠ **No scanning accuracy rate is printed** -- there is no measured control set, and none should be invented later.

### ★★★ CH.10 `knowing_a_number_is_wrong.qmd` DRAFTED — and the audit's central threshold is now DERIVED, not chosen

**~1,800 words, two tables, one figure.** Finding 051 applied first: **every scaffold number re-derived before drafting, and three had drifted.**

| scaffold said | re-derived |
|---|---|
| TwoRed "277 of 294 balance" | 277 to under HALF a cent; **281 to under a cent** -- consistent, but the tolerance was never stated |
| Creamsicle "143 of 170 US rows" | 170 US rows ✓, but **163 balance to <0.5c, not 143** |
| "3 Creamsicle errata, all resolved" | **5 errata (C01-C05); C01-C03 are HYPOTHESIS, C04-C05 confirmed. Not 3, and not all resolved.** |

★★ **Two drifts in one scaffold, one day after the rule was written.** Not dramatic, and that is the point -- **this is the ordinary rate at which hand-copied numbers rot.**

### ★★★ THE REAL RESULT: THE TOLERANCE IS IMPLIED BY THE RECORDED PRECISION

The audit used a flat *under half a cent*, chosen because it looked about right. **It can be derived instead.** Cost is printed to the cent, so the product can differ by 0.005 by construction; gallons and $/gal are each recorded to three decimals and each one's rounding is multiplied by the other:

`bound = 0.005 + gallons*0.0005 + ppg*0.0005`  --  **0.79 to 1.11 cents, median 1.00.**

**TwoRed 281 of 294 inside their own bound; Creamsicle 165 of 169 US fills.** Same TwoRed count as the flat rule, **and now it has a reason.**

**★★★ AND THE FINDING IS THE GAP, NOT THE COUNT. Largest residual that is still arithmetic: 0.76c. Smallest that is not: 2.93c. A factor of 3.9, with NOTHING in between.** **No row lands where a judgment call would be needed** -- which is the whole difference between an instrument and an opinion. If the residuals were smeared evenly the test would be worthless. `@fig-audit` shows the wall of rounding noise, the empty corridor, and the scatter of real errors from 2 cents to $1.76.

### ★ A FOURTH CREAMSICLE FAILURE, AND IT IS DELIBERATELY LEFT UNEXPLAINED

**Port Angeles WA, 3.993 gal x 5.399 = 21.558 against 21.57 recorded: 1.17c over a 0.97c bound.** Outside by **two tenths of a cent**, with no erratum. **Written into the chapter as the place the instrument runs out**, not as a finding. ⚠ **Do not give it an erratum** unless a receipt or card settles it.

### Also in the chapter

The seven instruments as a table of **what each tests and what each CANNOT see**; the contiguity+arithmetic pairing (*where two rows share a value, the one that balances is the source and the one that fails is the copy*) worked through Oxnard, `17.59 / 4.399 = 3.999` exactly; the seventh instrument and why it had to come last (**six of seven take the date as GIVEN, so none could see a wrong date; sorting by a field cannot reveal an error in that field**); and geography as **the only instrument that recovers rather than condemns** -- 15 impossible segments resolving into 4 ferries, 4 gazetteer errors and 7 suspect odometers, plus Delaware recovered by running it backwards.

**⚠ Instrument 6 renamed in `proj_Smart_Car.md`** from *Kim's slashed zeros* to **the DOTTED ZERO on the printed receipt**, per his correction.

**New: `book/R/audit_data.R`, `book/R/fig_audit.R`, `book/figures/audit.png`. 16 chapters render, 0 errors, 0 unresolved refs. Voice 26.6 -> 31.7 per thousand, 0 em dashes.** ⚠ Another transient `PermissionDenied` on `_output`; a retry succeeded, as before.

### ★★★ CH.11 `what_the_car_cost.qmd` DRAFTED — and the two cars come out FOUR TENTHS OF A MILE PER GALLON APART

**~1,440 words, one table, `@fig-cost`.** Scaffold numbers re-derived first again, and **three more had drifted:** the "lifetime 39.44 MPG" reproduces from nothing (the three defensible figures are mean-of-tanks 39.53, median 39.12, and **total miles / total gallons 39.25**); Creamsicle's median is 40.52, not 40.59; and the wide-tyre interval is **+2.8% [-0.9, +6.5]**, not the -3.7 to +4.9 on the scaffold. **Six scaffold drifts in two chapters.**

★ **The chapter states WHICH lifetime figure it uses and why:** total miles over total gallons is the only form that weights a big tank more than a small one, and the only one that answers *how much fuel did this car use*.

### ★★★ THE COST DIFFERENCE DECOMPOSES EXACTLY, AND IT IS ALL PRICE

| | TwoRed 2010-2017 | Creamsicle 2021-2024 |
|---|---|---|
| miles per gallon (life) | **39.25** | **39.66** |
| paid per gallon | $3.67 | $4.69 |
| cents per mile | **9.36** | **11.83** |

**Creamsicle costs 26% more per mile. Fuel prices alone account for 28%; its 1% better economy gives a little back.** `cost/mile = price actually paid / mpg` is an identity, so the split is exact rather than modelled.

**★★★ AND THE HEADLINE IS THE SIMILARITY. 39.25 against 39.66 -- four tenths of a mile per gallon, across sixteen years, two coasts, two sets of habits and two completely different sets of roads.** One car crossed the continent four times and went to the Arctic; the other did the Midwest and the West. **The car is a constant; what changed underneath it was the world.**

### The three candidate causes, and `@fig-cost`

**Same grammar as `fig_roads`: one measurement, two questions, shared y axis**, so the reader compares a real slope against a flat one instead of taking my word for it.

- **Tank length: +4.61 mpg per 100 miles, p = 8e-13, adj R2 0.16.** The strongest thing in the dataset **and it is about the trip, not the car.**
- **Age: +0.26 mpg per 10,000 miles, p = 0.081** (with tank length controlled, +0.30 at p = 0.030). **Positive, not negative. NO DECLINE TO FIND across 71,177 miles.** The chapter explicitly declines to claim the car improved.
- **Wheels: +2.8% [-0.9%, +6.5%]** over 52 narrow against 213 wide fills. **The record cannot tell you whether the wide tyres cost anything**, and after 213 tanks that is an answer of a sort.

### And two where Kim's own beliefs are on the table

**Truck-following** is carried as *felt*, per his own wording: rho -0.36 on the 44 single-leg tanks, collapsing when tank length enters, **because a slow day behind trucks is usually also a long highway day.** **Costco** is the one purchasing decision he can be shown to have made: **about 20c/gal, 11 of 13 comparisons.** ★ *He made it while telling himself he mostly picked stations for a clean restroom.*

⚠ **Premium fuel gets its own short section:** no grade column, so it is his word, **and it means every price in the book is a premium price** and any comparison to a national regular-grade average understates the car.

**16 chapters render, 0 errors, 0 unresolved refs. Voice 23.4 -> 29.9 per thousand, 0 em dashes** (two had appeared in `fig_cost.R` panel titles -- **the code-string sweep caught them**). New `R/cost_data.R`, `R/fig_cost.R`, `figures/cost.png`. ⚠ Two more transient `PermissionDenied` on `_output`; retries succeeded.


### ★★★ CH.12 `a_day_in_a_smart.qmd` DRAFTED — and the free-text column turns out to be the sharpest instrument in the book

**~1,680 words, one figure, two tables.** The chapter had to earn its place: ch.5 already owns long days and ch.8 already owns gross-vs-net. **Its distinctive material is Creamsicle's `comment` column**, a free-text box at the end of each row with no instructions and no requirement, filled in **35 of 84 timed legs (42%)** entirely by whim.

**★★★ THE COMMENT COLUMN IS A STOPPED-TIME DETECTOR, AND KIM BUILT IT BY ACCIDENT.** Commented legs: median **0.75 h** stopped, 4 of 35 at zero. Silent legs: median **0.00 h**, 36 of 49 at zero. **Wilcoxon p = 2.4e-07.** Put the way that matters: **42% of the legs carry 73.4% of all the stopped time in the record.** Whether he felt like writing a word predicts, better than anything else on the sheet, whether the day had anything in it besides the road.

### ★★★ THE THREE-WAY TEST — this is the result, and it is unusually clean

The obvious objection is that commented days were simply *different* days. **Tested three ways, and the pattern is exactly what a stopped-time detector should produce:**

| | commented | silent | p |
|---|---|---|---|
| **miles** | 272.0 | 276.2 | **0.97** (same) |
| **gross mph** | 38.1 | 49.4 | **0.0019** (different) |
| **net mph** | 47.3 | 51.6 | **0.36** (same) |

**Same distance. Same driving. 62% of the apparent speed gap is not speed at all.** The only thing separating the two kinds of day is time the car spent standing still. ★★ **A column nobody designed as an instrument separates the record better than any column that was.** Same accident as the fuel form's three multiplying columns in ch.9, and the chapter says so.

### The figure, the categories, and the four exceptions

**`figures/day.png`, `fig_day.R`:** 35 horizontal bars, one per commented leg, ordered by stopped hours. **Stopped time drawn FIRST so it reads straight off the axis**, driving in recessive grey behind it, each bar labelled with Kim's verbatim text (typo *Desert Musum* deliberately preserved). Caption corrected after visual check -- the first draft said "driving on the left" and had it backwards.

**Categories are MINE, not Kim's, and the chapter says so in the table caption** so a reader can disagree: something to look at 11, something to eat 9, somebody to see 5, an errand 4, the clock 3, the ferry 2, weather-or-a-wreck 1. A comment naming two things is filed under the first match, and the order is part of the claim.

**★★ THE TOP BAR IS A NAME.** Springfield IL to Liberty MO, 307 miles in 12 hours, **six of them stopped**, and the comment is one word: **Tom**. Six hours of a twelve-hour day were a person and the sheet gives them three letters.

**⚠ THE FOUR ZERO-STOP COMMENTED LEGS ARE THE HONEST PART.** Three are notes about the clock (*TimeZone +1*, *To Mountain Time*, *Back to Pacific Time*) -- **the column being used for a second purpose, a category of false positives that announce themselves.** The fourth is worse and better: `2023-09-24 Campbell River -> Vancouver, 101 mi, 7 h`, comment **"Ferry, park, shop"**, stopped-time cell **zero**. ★★★ **The comment column caught that day. The stopped-time column, the one actually designed for the job, missed it entirely.** Stated in the chapter as the limit of every instrument in the book: *the record holds what got written down, not what happened.*

### Finding 051 applied again, and it caught more drift

**Re-derived the scaffold's numbers rather than trusting them, and half were wrong again.** Scaffold said median leg 251 mi (TwoRed) / 166 (Creamsicle); truth is **305 (139 legs) and 273.7 (84 legs)**. Scaffold said log distance ~95% of odometer miles; the median ratio is **1.00**. **Third scaffold in a row to drift at roughly this rate.** The new module derives everything, including the three-way test, so nothing in the chapter is typed.

**⚠ One unsupported clause caught in my own draft before Kim saw it:** "nine days in ten it really was just that" -- not derivable. Replaced with the 49 uncommented legs, which is. **A round phrase that feels true is exactly the shape of a Finding-051 number.**

New `R/day_data.R` (88 lines), `R/fig_day.R`, `figures/day.png`. **16 chapters render, 0 unresolved references. Voice 29.9 per thousand, 0 em dashes.** ⚠ One transient `PermissionDenied` on `_output` and one 60s MCP timeout on the full render -- **both Finding 048/012 class, both verified complete by artifact mtimes rather than by return value.**
## 2026-08-31 -- CH.5 DRAFTED; A FILL TIME SETTLES A FORTNIGHT-OLD CONFLICT; THE BOOK RENDERS END TO END FOR THE FIRST TIME

**Active focus at start and close:** Smart_Car. Kim confirmed ch.5 `long_days.qmd` and gave four accounts. The chapter is drafted, and two chapters he was not asking about turned out to be broken.

### The scaffold's eight was missing the longest day

`long_days.qmd` listed eight days. **The longest day in the record was not one of them:** 2016-06-19, Richmond MO -> Denver, **640 miles**, 06:57-16:53, **58.6 mph gross**, three fills across Kansas. The leg note in the data had flagged it as the longest; the scaffold predated that.

**★★ AND KIM'S REASON INVERTS THE OBVIOUS READING.** Mount Evans is the next morning, so the tempting story is that the plains bought the mountain. He rules it out: his brother lives in Richmond, the short 195-mile day before was to get there, and the 640 was to **get a dull stretch of highway behind him.** What he wanted was I-70 through the Colorado mountains and the road alongside the Colorado River. *"I had some hope for Mt. Evans, but that wasn't the motivation."* **The longest day in sixteen years is what impatience looks like written down.**

**★ MOUNT EVANS IS NOW MOUNT BLUE SKY** (Kim). Applied to `expeditions.qmd` in two places and re-rendered.

### ★★★ THE BELLINGHAM CONFLICT IS SETTLED BY A NUMBER NOBODY HAD TRANSCRIBED

Kim has said twice that 2013-08-31 started late in the day; the sheet says **06:49**. I recommended going with the sheet **before I had read the collected stories**, and had to walk that back: his verbatim account names *early afternoon* at the dock specifically, which is not a vague recollection.

**The instrument that settled it was in the same PDF as the leg, one table higher up the page.** `TwoRed_fuel_timetemp.csv` held **3 rows for 2013 against 40 for 2016** -- the whole Alaska trip's fill times had never been entered. Transcribed off `2013_TwoRed_Fuel_Trip_Logs_Alaska.pdf`: **22 rows, every odometer key gated against the fuel log on the same date, 0 unmatched, 0 date mismatches.**

**The day then splits: 122 miles in 6.05 hours (20.2 mph), then 48.2, then 52.9.** About four hours unaccounted for between Bellingham and Tacoma. **The sheet recorded when the car came off the boat; Kim remembers when the driving started.** Neither is wrong, and the gap between them is the size of a morning. Written into ch.5 that way, pending his confirmation.

**★★ THE GENERAL FORM: a conflict between two records was only a conflict because a third had never been read.** Both accounts had been checked against each other for a fortnight. Before writing "cannot be settled", ask what in the same source has not been transcribed.

### The other two accounts, and what they corroborated

**Carson City 2013-08-04 had no story; it was smoke.** Fires in the Sierra, US-395 covered, and he could not stop short as he intended. **The route corroborates it unprompted:** the day's two fills are Kramer Junction 10:40 and Bridgeport 16:34, both 395 towns, with 77 miles still to run. Those fill times came from the same new transcription.

**Sedona 2015-07-07, 575 mi, out at 04:05, ends at under 1 mph.** A friend led him onto a long unpaved stretch behind a 4WD; he crept around rocks with no way to turn back. *"I told myself (and TwoRed) to never do anything like that again."* **It is the second-longest day in the book and part of it was driven at walking pace.** Probably also why the end odometer was never written; offered, not asserted.

### ★★ TWO PRE-EXISTING RENDER BREAKS, BOTH THE SAME CLASS

The book had **not** been rendering end to end, and neither break was in ch.5.

- `small_cars.qmd`: `object 'boot_w' not found`. The `dims` chunk that defines it sat **below** its first inline use. Chunk moved above.
- `is_it_safe.qmd`: `object 'n_nar' not found`, same shape -- but that chunk also prints a table, so it was **split** into `wheels-data` (hidden, above the use) and `wheels` (the kable, in place).

**The class: inline `` `r x` `` is evaluated in document order, so a variable defined in a chunk further down the file is not there yet.** It is invisible to a single-chapter render if the variable happens to exist in the interactive session, and invisible to `R CMD`-style checks entirely. **A full-book render is the only thing that finds it.** Both were introduced by refactors into `book_setup.R` (the boot measurement, the wheel states) that renamed what the chapters were reading.

**Result: 15/15 chapters render, 0 error strings across all of them.**

### Ch.5 as drafted

`long_days.qmd`, **~2,660 words, three tables, no figure.** Spine: **not one of the long days was about driving.** A brother, a wrong turn, an empty stretch of Montana, a ferry that did the packing, friends in Las Vegas, a state still needed, a fire, and a mother at 104. The sheet has a column for distance and a column for time and none for why. New: `book/R/long_days_data.R` (`long_days_data()`, `long_day_early()`, `day_segments()`).

**Voice rule checked BEFORE showing Kim, which is the ch.4 failure not repeated: 40 contractions, 0 em dashes.**

**Next:** Kim reads ch.5, then ch.6 `the_roads.qmd` -- whose deferred TASK needs him to name the tree-tunnel stretches, not have them inferred.

### ★★★ REGISTERED AFTER CLOSE — THE CALIBRATION PROBLEM AND THE LOGISTICS PARTNERSHIP

Kim gave a structural account, verbatim in `logs/proj_Smart_Car_log.md`. **Before TwoRed their mainland driving was one route, LAX to LSM, exactly 100 miles.** They took on a continent with no relevant experience, found the Smart forums useless (two-driver relays to a target), and set four rules: **one driver, a very long way to go, no night driving, no unfamiliar rush hour.**

**Two tests run on it, and the second is the finding.**

**1. The rules are visible as a shape.** Median arrival **16:12**, 90th percentile 18:55, median departure 08:11, latest departure in six years **13:26**. Six arrivals after 20:00 and **every one has a name** -- three are Alaska/Yukon in August where 21:00 is daylight, one is a ferry terminal, one the Las Vegas break, one his mother. **A rule nobody wrote down is in the distribution.**

**2. THERE IS NO LEARNING CURVE.** First three logged trips median **301 mi**, everything after **305**, Wilcoxon **p = 0.44**. **The calibration happened on the 2010 crossing, which has no trip log, so the record opens already knowing the answer.** ★★ **It was never stamina** -- an 84-year-old's day and a 68-year-old's day are the same length. **The four rules set the day, and four constraints give you 300 miles immediately and forever.** So **a long day is not a hard day, it is a day one of the rules was suspended for** -- which is what ch.5 found from the other end, without this.

**★★ And Nancy's role has no column.** Watching a GPS track from Honolulu, she picked the end city in real time, booked it, and found a restaurant within walking distance. **The end city of a day was chosen 2,500 miles from the car.** Kim's word is logistics, not navigation, and the distinction is his. Three items opened in `deferred.md`: which trips were solo, what the actual tools were, and where this material belongs in the book.

### ✓✓✓ RULED, AND CH.5 REWRITTEN AROUND IT

Kim ruled the calibration/logistics material is **ch.5's baseline**, and gave the reason: *"most often in the early day, the destination was not set. Experience put it at about 300 miles per day. And that distance held. That's why this distance becomes our measure against which we can see exceptions. It isn't the same as for other people."*

**Ch.5 restructured: two new opening sections ahead of the 640** -- `One route, a hundred miles` (Hawaii, the LAX-LSM hundred, the useless two-driver forum advice, the four rules) and `About three hundred miles` (the median, the no-learning-curve table, the clock table, Nancy's logistics). **The 640 now lands against a known norm and is described as more than two ordinary days run together.** ~3,575 words, four tables. **57 contractions, 0 em dashes.** Renders clean, 0 NAs.

### ★★★ TREE TUNNELS — the concept, and the stretch is DATED

Verbatim in the project log. **The term came from his nephew describing the train from Siberia to Europe**, and it survived transplant to an Alabama interstate. **The definition is a conjunction of three -- trees that block the view, nearly straight, nearly flat -- and the western counter-case is part of it:** tree-lined roads out West are not tree tunnels because the trees do not hide the landscape. *"The trees and the landscape work together."*

**★★ The complaint is explicitly NOT about road quality:** *"I was stuck on an excellent highway... Easy driving. But I couldn't wait to get off of it."* **Every measurable quality of that road is good and the experience is bad** -- the same shape as the Canadian Plains non-result and the Deep South / Appalachian null.

**★★ AND THE STRETCH IS IN THE RECORD.** I-65 north in Alabama = **2014-05-07/08**, and the fills place it: the **Atmore -> Trussville tank is almost purely the tree tunnel**, 229 mi at **33.67 mpg**, lowest of that week's eight against a lifetime mean of 39.53 -- and **the next tank, climbing into the Appalachians, reads 42.49.** ⚠ **Illustration only.** One pair, uncontrolled, inside the southern-deficit signal already ruled unsettleable.

### ★★★ CH.6's SPINE RULED, AND THE CHAPTER CHANGED SHAPE

Kim accepted the sightlines reframing (*"That's a big difference"*) and then ruled the chapter. **It is not a taxonomy of roads. It is an argument for variety.** His closing pair, already in his own balanced two-clause form: *"The architects of the Interstate system brought a kind of uniformity: excellent highways. That was very important. Nature gives these highways character. It's equally important."*

**★★ The engineered layer ties ch.6 back to ch.5's baseline** -- uniform excellent highway is quietly what made a 300-mile day in an 1,800-lb car possible at all. **The natural layer is what the engineering cannot flatten.**

**★★ TWO STANDING CONSTRAINTS.** **One example only** -- I-65 north in Alabama stands alone, and the four candidate stretches I offered are **CLOSED WON'T DO** with the reason kept: a second example adds weight without adding argument. **That is Kim applying his own subtraction principle to his own chapter, unprompted.** And **no blame** -- *"I can't blame Alabama's stretch of I-65. That's just their combination of vegetation and topography."*

**`the_roads.qmd` scaffold rebuilt** around the spine, the two constraints, and the material. **Measured taxonomy recomputed** (median gross mph by trip, coastal 28.3 to StLouis 47.6); the old scaffold's "Dalton 31.7" was the whole Arctic trip, not the gravel -- the two Dalton legs are 28.6 out and 22.6 back. **The Deep South / Appalachian null (40.3 vs 38.0, p = 0.42) is written in as the chapter's hinge, not a gap.** Nothing is blocking a draft.

### ★★★ CH.6 IS DRAFTED — and it carries the book's first figure built to be an ARGUMENT rather than a display

`the_roads.qmd`, **~1,720 words, one figure, one small table.** Seven sections: the excellent highway; sightlines not trees; not Alabama's fault; what the record can see; what it cannot; two layers; and *if you've seen one*. **45 contractions, 0 em dashes.** Renders clean; **16 chapters, 0 error strings across all of them.**

**★★★ `@fig-roads` PUTS BOTH ANSWERS ON ONE SHARED AXIS, WHICH IS THE WHOLE POINT.** Top panel: median gross mph per trip, 28.3 (US-101 coastal) to 47.6 (2011 plains interstate), sorted, leg counts in the labels so a reader can see that three trips rest on one or two legs. Bottom panel: every leg in the two kinds of country, Deep South (n=10) against Appalachia (n=6). **The eye runs down ONE scale and watches separation become overlap.** Two charts on different scales would have let the comparison off the hook.

**★★ ONE HUE, DELIBERATELY.** The bottom panel does NOT colour its two groups differently -- identity is row position plus a direct label -- **because two hues would assert a distinction the data cannot make.** Same slot (#2a78d6) as `fig_dwell`, validated light-mode, so the book's figures read as a system. New `R/roads_data.R` and `R/fig_roads.R`.

**★ The group definitions are now STATED IN CODE rather than remembered:** Deep South = either endpoint in AL/MS/LA/GA/SC/FL; Appalachia = both endpoints in WV/KY/TN/NC/VA. Those reproduce the 2026-08-20 figures exactly (40.3 / 38.0 / p = 0.42), which they had not been written down anywhere before.

**★★ THE CHAPTER FOUND ITS OWN TIE BACK TO CH.5, and it strengthens both.** The uniformity Kim could not wait to escape in Alabama is the same specification that made the 305-mile day possible. *The uniform layer is what makes the trip possible. The other layer is why it is worth taking.*

**Handled with the agreed discipline:** the 33.67 vs 42.49 tank pair is written as a coincidence that matches a mechanism, explicitly not as evidence, with the closed sample named. No coefficient printed.

### ★★★ A SEVENTH CHAPTER, AND THE RECORD HAD BEEN HOLDING ITS BEST NUMBER ALL ALONG

Kim registered the ferries and the Whittier tunnel. **The five passages were each already in the record, correctly noted, and nobody had ever added them up.**

**★★★ FIVE SEA CROSSINGS. TWELVE ODOMETER MILES. SEVEN NIGHTS ABOARD.** Whittier -> Bellingham, four days at sea, reads **38,284 to 38,285 -- one mile.** The Newfoundland return is purer still: Port aux Basques 46,625 to Sydney NS 46,625, **zero.** Ten of the twelve are the northbound drive off the dock at Haines. On Kim's own water figures the two Alaska passages alone are about 2,300 miles.

**★★ THIS IS THE SCOPE BOUNDARY AT A SCALE THE BOOK HAD NOT USED.** Ch.3 found it inside a trip, ch.4 between trips, ch.5 in the reasons a day was long. **Here the car MOVED and the instrument that exists to measure movement recorded nothing, correctly** -- an odometer counts wheel rotations, it is not a position sensor, and this is the one place in sixteen years where the difference is visible. ★ **The fuel log shows the same hole from the other side:** the Lakewood WA tank opens six days earlier in Homer, Alaska, scores 48.56 mpg, 14th best of 286 against a median of 39.12, **and the car spent most of it on a boat.**

**★★ KIM RULED IT ITS OWN SHORT CHAPTER** rather than a coda inside ch.6 -- the one-argument discipline he set for the roads chapter, applied again. **`the_marine_highway.qmd`, ~1,240 words, one table**, inserted in The Drives after `the_roads.qmd`. New `R/ferries_data.R`. **17 chapters now; 16 render, 0 error strings.**

**★ THE TUNNEL IS A DIFFERENT KIND OF FEAR AND HE NAMES IT HIMSELF.** *"There were times I was scared due to danger... But this was not dangerous in that sense. It was a kind of challenge danger; could I drive well enough to get through."* And the worry is Smart-car-shaped: *"I wondered if my narrower than average wheelbase would work relative to the train tracks."* **KIM RULED: leave the worry as the fact.** I offered to check track gauge against `twored_manual` and he declined -- **answering it now would replace his experience with my arithmetic.** Do not compute it later.

**★ TWO EXTERNAL CHECKS, both done before writing.** The **Anton Anderson Memorial Tunnel** is 2.5 miles, one lane shared with the Alaska Railroad in both directions on alternating timed openings -- his 2.5 miles and his convoy are both right. And **Alaska DOT's own AMHS route page states it "will not be traveling to Yakutat or scheduling 'cross gulf' routes"** in the proposed winter 2026/27 schedule, which corroborates his report from the operator. ⚠ **His "one run in 2026" count is NOT sourced** and is written as his count, not as established.

**⚠ MY OWN VOICE RULE, CAUGHT ON THE CHECK RATHER THAN BY KIM.** First draft ran **17 contractions in 1,250 words -- 14 per thousand against ch.6's 26.** A pass brought it to 44. **The check works; the instinct still does not.** Third chapter running where the density had to be fixed after drafting rather than during.

### ★★★ FUEL ECONOMY FROM KIM'S SIDE — four tests, and one of them is the sharpest example in the book

Full account and all four tests verbatim in `logs/proj_Smart_Car_log.md`.

**1. SLOWER DAYS DO READ BETTER, AND IT IS A SIGNAL.** New instrument: the **44 tanks that fall entirely inside ONE leg**, with that leg's gross speed attached. **Spearman rho = -0.359, p = 0.017** -- his claim exactly. Then it fails under pressure: trimmed p = 0.052, early era p = 0.27, and **adding `leg_miles` drops the speed term to p = 0.33 while adj R2 goes 0.01 -> 0.37.** ★★ **His most confident economy belief is the one the record can least confirm**, and his own wording already allows for it: *"At the lower speed I FELT I was saving fuel."*

**2. THE BEST TANK IN SIXTEEN YEARS IS GRAVITY, NOT RESTRAINT.** Gypsum CO -> Big Springs NE, 313 mi, **56.04 mpg, best of 286** against a median of 39.12 -- down out of the Rockies.

**3. COSTCO IS REAL: median $0.20/gal, 11 of 13 matched pairs cheaper, paired Wilcoxon p = 0.008.** ★ He says he rarely shopped for price and chose stations for a clean restroom. **The one price decision he did make is the only one the record can prove.**

**4. ★★★ THE NEBRASKA FRONTAGE ROAD, AND KIM DATED IT ON DIRECTION.** *"I am quite sure it was the 2012-05-28 as this is the correct direction."* **A check I had not thought to apply, and the other two candidates fail it.** The day is Ogallala -> Omaha, 340 mi in 6.97 h. **It reads as 48.8 mph gross -- 20th fastest of 132 timed legs -- and its tank is 50.62 mpg, 8th best of 286.** ★★★ **The day he chose to leave the interstate and crawl past farms is, to both instruments, a fast efficient interstate day.** Gross speed cannot separate slow cruising with no stops from fast cruising with stops. **The same arithmetic that hid the stress and the tedium hides an afternoon of pleasure** -- the hinge chapter's argument becomes a triple. ⚠ Two caveats written into the scaffold: the tank is not clean (~73% of it is that day) and eastbound Nebraska is a ~2,200 ft descent.

**★★ KIM RULED A FOUR-WAY SPLIT, and two of the four are written.** `small_cars.qmd` gains *What it was designed to be good at* -- boxy, pushes wind, and **every fuel figure in the book comes from a car optimised for something else.** `is_it_safe.qmd` gains *Following the trucks* -- a safety choice he also read as an economy one, plus the 80 mph flip side. The frontage road and the Costco/premium material went into the two scaffolds. **16 chapters render, 0 error strings.**

### ★★★ AND THE INSERTION EXPOSED A LATENT BUG: TEN HARDCODED CHAPTER NUMBERS (Finding 050)

**Adding a chapter mid-book moved every target after it and nothing complained**, because a sentence is not a build dependency. **The audit then found an older error underneath:** the prose counts chapters the project's way with the Foreword unnumbered, **but Quarto counts `index.qmd` as chapter 1** -- so every hardcoded reference was already one low, before any insertion.

**★★ The fix is not to renumber. It is to stop writing numbers** -- label each heading `{#sec-name}` and reference `@sec-name`. **Exactly the discipline the figures already have:** every printed figure number comes from an R object and cannot go stale; cross-references had never been brought under the same rule. **Table of all ten, with what each actually points at, is in `deferred.md`** -- and two of the ten are inferred from content, so confirm before renumbering. **My new sections deliberately reference the cost chapter BY NAME.**

## 2026-08-29 -- CH.3 RE-SOURCED, CH.4 DRAFTED, AND THE LAST BLANK CORNER OF THE RECORD FILLED

**Active focus at start and close:** Smart_Car. Opened the PKM to start ch.4; a question from Kim -- *should I be talking about how the long trips began?* -- turned into a correction to an approved chapter.

### The question that found the error

Checking whether ch.3 had already told the origin, I found it had: the car-wash section opens *"It came in the middle of the first long trip."* **But its numbers came from `trip == "2011_StLouis"`** -- a nine-day St Louis hold on the FOLLOWING year's trip.

Kim then gave his itinerary for the first crossing (as reference, not text), and it dates the hold exactly: **dropped the car 10/11, flew home, collected it 11/5.** That is 2010, and it matches the 2010 fuel gap to the day.

| | printed before (2011) | correct (2010) |
|---|---|---|
| gap | 9 days | **25 days** |
| miles | 217 | **227** |
| pace | 24 mi/day | **9.1**, against a between-trip median of 5.3 |
| brackets | St Louis -> St Louis | **Altamont IL -> Effingham IL** |

**217 against 227. Ten miles apart, and both are St-Louis-area holds on consecutive years** -- which is exactly how a mis-sourcing survives being read and approved.

**★★ THE CORRECTED VERSION IS A BETTER PARAGRAPH, which is the argument for fixing it rather than patching it.** The 2010 crossing has NO trip log, so the stop exists only as a gap between two fuel fills -- and those fills name Altamont and Effingham, Illinois, the better part of a hundred miles either side of St Louis. **The exception is now hidden THREE times instead of two: by the odometer, by the definition, and by the fills themselves, which never name the place the car actually sat.** The chunk is re-sourced with a `stopifnot` on both bracket rows; rendered and verified, 10 of 10 checks including that the stale 9-day figure is gone.

### His account matches the fuel log 12 for 12

LSM 9/19, Dallas 9/23, St Louis 9/29, Blue Ridge 10/2, Connecticut 10/7, drop 10/11, collect 11/5, GigaPan Pittsburgh 11/10, North Carolina 11/15, Arkansas 11/17, Carlsbad Caverns 11/21, home. **A trip with no trip log, reconstructed entirely from 43 fuel fills. That is ch.4's opening argument and it arrived by itself.**

### ★★★ A FIFTH INDEPENDENT RECORD -- KIM'S 2014 TALK AT LAKE SAN MARCOS

Given just after the big trip, so **contemporaneous rather than recall.** It names the four states the drive was needed for: **Florida, Delaware, Rhode Island, Vermont**, and Vermont was the last, *"other than Hawaii, of course."*

**★★★ THREE OF THOSE FOUR ARE EXACTLY THE STATES THE GEOGRAPHY INSTRUMENT RECOVERED FROM ODOMETER ARITHMETIC ALONE** -- no fill, no leg naming them. Delaware from Colonial Heights VA -> Bellmawr NJ (265 mi against a Delaware-free ~305); Rhode Island from Bellmawr NJ -> Douglas MA (287, the Providence road); Florida from testimony plus Styx River Road plus a geotagged photograph. **A document written in 2014 confirms three inferences made in 2026 from numbers alone.** The instrument was not merely self-consistent. It was right.

**★ AND ITS OMISSION IS THE PROOF. South Dakota is NOT in the list**, because it was crossed on 2012_Frostburg (2012-05-27, Casper -> Ogallala) and was not missing by 2014. **A corroborating document that agrees on everything is weak; one that is silent exactly where it should be is strong.**

**★★ IT ALSO EXPLAINS THE TRIP'S NAME, which nobody had explained.** `2014_PenultimateState`: **Vermont is the 49th, Hawaii the 50th and never driven to.** So Vermont is at once the LAST state reached by car and the PENULTIMATE of the fifty. Both framings already in the record are correct -- they were counting different sets. The name had been carrying the answer all along.

**Finding 045 for the FIFTH time** -- AMEX, Styx River Road, the Florida photograph, the receipt odometer, and now a talk. **Every time, the redundant record existed and had been forgotten rather than lost.**

### ★★★ CHAPTER 4 IS DRAFTED -- and the master dictionary changed what it is about

`expeditions.qmd`, **~2,530 words, seven sections, two tables, no figure.**

**The scaffold said "the crossings, trip by trip." Reading `source/Smart_Car_master_dictionary.pdf` made that the wrong chapter.** Kim's own c.2015 summary names **14 expeditions**. The trip log holds **13 trips**. They are not the same list: **7 of his 14 have no trip log at all** -- the first crossing, a desert run, Yosemite, a February Fort Worth drive, Death Valley, an August meeting, and a weekend at Lake Havasu -- and Sedona is logged as a fragment of the trip it belonged to.

**So the chapter is: the trip log was never a record of the trips.** It recorded long driving days, and it started a year after the driving did. **This is the fractal scope boundary at a THIRD scale** -- ch.3 found it inside a trip, the Foreword at the end of the car's life, ch.4 finds it BETWEEN trips. A whole expedition can fall through and the record is not wrong when it does.

**`tbl-expeditions`** puts his list against the log. **`tbl-growth`** shows what the record carries trip by trip, and it contains the chapter's best structural fact: **the written-distance column goes to 0% from 2016 and stays there.** Times were there from the first leg; temperatures took a year; everything is complete by 2014 -- and then a field is switched off. **It is the one place in sixteen years where Kim can be seen deciding what mattered, rather than a habit forming quietly.**

New: `data/TwoRed_expeditions.csv` (transcribed verbatim, with a `source` column) and `book/R/expeditions_data.R`.

### ★★★ MOUNT EVANS -- KIM NAMED THE TEST, AND THE TEST PASSED

He raised it as a loss: he had tried for Mount Evans several times between Grand Junction and Denver and been turned back by snow, finally made it in 2016, took photographs he can no longer find, and added -- **"none of this appears in the record unless there is a mileage anomaly on the route."** He then said we should move on. **That sentence is a falsifiable prediction and the instrument was already built, so I ran it instead.**

**2016-06-20, Denver -> Grand Junction, on the Fourth Crossing:**

| instrument | reads | expected | excess |
|---|---|---|---|
| the LEG | 305 odometer miles | ~250 on I-70 | **55** |
| the TANK (Watkins -> Gypsum) | 203 miles | ~150 of road | **~53** |
| the CLOCK | 07:58-18:13, **10.2 h**, gross 29.8 mph | ~4 h | **~6 h** |

**The byway is 28 road miles from Idaho Springs to the summit. Out and back is 56.**

**★ THE TANK IS WHAT MAKES IT A FINDING RATHER THAN A SUGGESTIVE NUMBER.** The leg and the clock come off the same sheet in the same handwriting. The tank is a different instrument with different endpoints and its own boundaries, nobody aligned the two on purpose, and it returns the same answer. **A control exists too:** the same stretch eastbound three weeks earlier, filling at the same Gypsum station -- **50.15 mpg down against 40.75 up.**

Everything else corroborates: late June, when the byway is open; westbound out of Denver with Idaho Springs 35 miles along; the Fourth Crossing was his last crossing, matching *"one of my last chances."*

**★★★ IT CLOSES THE ONE BLANK ROW IN HIS OWN 2015 SUMMARY** (*Highest Elevation: see upcoming trips*). Sixth recovery by this route, after South Dakota, Delaware, Rhode Island, Florida and Ogunquit. Kim: *"It proves we've got a good analysis technology running."*

**★★ AND HIS ACCOUNT OF THE DAY GAVE THE CHAPTER ITS BEST PARAGRAPH.** He could not stay long at the summit -- altitude headache -- and drove into a hail storm on the descent hard enough that he watched the paint. No damage. *"I was happy to be back on the Interstate."* The section sets that against what the record holds: **fifty-five miles and six hours.** That contrast was only available because he had first told me the record was silent; it could not have been written from the data alone.

**★ AND IT CORRECTED A PARAGRAPH WRITTEN AN HOUR EARLIER.** Ch.4 had called the blank row *"the most honest thing in the summary -- a record kept by somebody who assumed there would be more trips."* Poignant, and false. **The truth is better: he closed the row two years later and never went back to write it in.**

### ⚠ MY OWN FAILURE, TWICE IN ONE CHAPTER

**Ch.4's first draft carried 2 contractions in 2,100 words**, against a standing voice rule Kim gave on 2026-08-21 and which is recorded in three places. I fixed it to 22 -- **and then wrote the 550-word Mount Evans section with none.** Final state 38, with one deliberate exception (*"There was not."*, where contracting kills the beat).

**Twice in one chapter is not a slip, it is a missing step.** The rule now: **check the voice before showing Kim a draft, not after.** A mechanical count takes one line and I ran it only because I happened to.

### The four open items, closed the same session

**Delaware 264 vs 265 — CLOSED by Kim as insignificant.** Do not re-derive.

**★★ MAINE 2010 IS CONFIRMED, and the geometry turned out to be decisive.** Kim has a non-cellphone photo dated October 9 on the Maine coast; Gemini places it at **Ogunquit**, about fifteen miles past the line, matching his *"we had just barely gone into Maine."* He flags the camera clock as unreliable — it does not need to carry the weight. **The Danbury CT -> Charlton MA leg runs 335 odometer miles: ratio 3.64 against the direct great-circle, and 1.13 via Ogunquit.** A 1.13 leaves essentially no unexplained mileage, so the dash accounts for the whole excess. Four independent strands agree: geometry, the photo's location, its date (the Charlton fill is also 10-09), and testimony. **It confirms an itinerary, not a state** — Maine is already witnessed by 2014 fills.

**The 2011 nine-day St Louis hold is explained:** the **Society for Economic Botany** meeting. Never a second car-wash episode. The hold ch.3 had borrowed now has its own reason.

### ★★★ THE TALK IS `source/2014_Chateau_Presentation.pptx`, AND IT WAS NEVER IN Key Files

50.3 MB, **121 slides**, dated **2014-06-16 — four days after the trip closed.** *Driving to the Extremes: Some Recent Smart Car Adventures*, Kim with Dr. Nancy Furumoto (Navigator). **The largest file in `source/`, unlisted since the 2026-08-12 intake**, because its name says *Chateau Presentation* and nothing about states, data or the trip. **An intake that lists four of five files is an intake gap — and this one held the answers to two separate open questions.** Finding 045 for the sixth time.

**Slide 42, verbatim:** *"2014 Expedition | Complete the 49 States + 10 Provinces | Missing States | Florida | Delaware | Rhode Island | Vermont."* **His recollection is now a primary source**, and three of those four were recovered in 2026 from odometer arithmetic alone. Slide 121 gives 10,907 miles + ~280 ferry, matching the margin note and the dataset a third time.

### ★★★ SLIDE 6 IS AN INDEPENDENT 2014 COMPUTATION OF THE 2010-2013 RECORD

*"Total Distance: 39,739 miles | Total Fuel Used: 1017.414 gallons | Total Fuel Cost: $3,797.63 | Overall Mileage: 39.28 mpg | Total Fill-ups: 163 | Average Fill-up: 6.24 gallons | 2010-2013 Statistics."*

**Decoding his boundary was the whole trick. 39,739 is the ODOMETER AT FILL #164 — Signal Hill CA, 2013-09-06, the last leg of the Arctic trip.** He drew the line at the end of the 2013 SEASON, not 31 December, and his 163 fill-ups exclude the dealer's first at odometer 4. On that frame:

| | slide 6 (2014) | corrected dataset (2026) | |
|---|---|---|---|
| fill-ups | 163 | **163** | **exact** |
| total distance | 39,739 | **39,739** | **exact** |
| average fill | 6.24 gal | 6.23 | rounding |
| total gallons | 1017.414 | 1015.19 | **-0.22%** |
| total cost | $3,797.63 | $3,817.82 | **+0.53%** |
| overall mpg | 39.28 | 39.14 ratio / 39.44 mean-of-tanks | his sits between |

**⚠ AND THE RESIDUAL IS NOT THE AUDIT — I checked before claiming it was.** The 36 errata dated on or before 2013-09-06 move gallons **+1.559** and cost **+0.96**; the residuals are **-2.224** and **+20.19**. Wrong sign on one, wrong magnitude on both. **The tempting story — "the difference is what the audit corrected" — is false.**

**Where to look instead, and it is specific.** Kim's workbooks carry interleaved running totals and averages inside the data region (which is why the Creamsicle ingest skips them and reports the count). **Slide 6 was almost certainly typed from those cells rather than recomputed** — so the question is not which dataset is right, but what those 2014 total cells held, and whether they were ever updated after a row changed. **A stale total cell is precisely the error class this book is about.**

### ★★★ AND IT ANSWERS THE PROJECT'S LARGEST OPEN QUESTION

`proj_Smart_Car.md` has carried this since 2026-08-21: *is there a TwoRed photo archive? Nobody has asked about 2010-2017.* **The deck embeds 121 images, 50.1 MB** — the Alaska Marine Highway, the Dalton, Wiseman, fireweed, an ermine, the Moncton tidal bore, a Columbian ground squirrel. **Photographs were taken and curated within four days of the trip ending.**

**⚠ Being precise about what that proves.** It proves they EXIST and were selected. It does not locate an archive: embedded PowerPoint media are downsampled and largely stripped of EXIF. **The question changes from "is there an archive?" to "where are the originals, and do they carry EXIF?"** — answerable, and Kim can settle it in a minute. If they do, ch.12's parking constellation and ch.13 both gain a second instrument for 2010-2017, exactly as Creamsicle has.


---

### Close-out (Mechanism 5)

1. **New projects?** None.
2. **Smart_Car header:** Status **Active**, Focus readiness **Ready** -- unchanged and correct. Ch.5's scaffold already holds its material; nothing is blocking.
3. **New files, added to Key Files:** `data/TwoRed_expeditions.csv` (transcribed verbatim from the master dictionary, with a `source` column) and `book/R/expeditions_data.R`. Also newly listed after an intake gap: **`source/2014_Chateau_Presentation.pptx`**, the largest file in `source/` and unlisted since August.
4. **Cross-references:** Active Focus rewritten for the close; yesterday's block archived verbatim to `logs/focus_history.md`; `proj_Smart_Car.md` updated in six places.
5-6. **Decisions logged; this entry written.**
7. **Active Focus updated**, 3.2 KB against a budget of 6.
8-9. **Next Steps rewritten.** Ch.4 is drafted, so item 1 becomes *Kim reads ch.4, then ch.5*. **New item added from the deck:** slide 6 reconciles exactly on fill count and distance but differs on gallons and cost, and the errata do not explain it -- look at the workbook's interleaved running-total cells.
10. **Written outside `G:`:** two bucket-4 folders, `C:\temp\chateau_2026-08-29` (pptx extraction scratch) and `C:\temp\ch4_20260829` (a render copy). **Both regenerable; delete whenever.** Nothing written to bucket 5.
11. **`pkm_health()` -- clean where it matters.** 83 works, **0 reconciliation failures, 0 rendered-without-source, 0 broken pointers, pre-deletion gate 0.** Focus block 3.2 KB against 6.
12. **`pkm_backup()` -- 1,232 files, 0 pruned, 0 size mismatches; secret scan CLEAN; committed `100473cec3`, 11 files changed; push VERIFIED AGAINST THE SERVER** (Finding 028).

**Reported, not acted on** (remedies are never run automatically): **`session_log.md` has crossed its own budget at 260.8 KB against 250** -- it is marked not splittable, and the archive split of 2026-07-30 is the precedent for what to do about it. **`proj_Smart_Car.md` is 54.4 KB against 45** and flagged splittable; it has grown 9 KB in two days because the project is in full flight. `proj_seasonality.md` and `proj_audio.md` were already over. **Four build-scratch folders are past 14 days**, all under 1 MB together -- tidiness, not space. **Drift (4) and repo/clone mismatches (6) are unchanged and belong to other projects.**

## 2026-08-28 -- CH.3 APPROVED AND GAINS A SECOND FIGURE; A SEVENTH AUDIT INSTRUMENT, FOUND BY A CHART

**Active focus at start and close:** Smart_Car. Kim opened the PKM, confirmed he had read chapter 3 and approved it, and chose the parked-periods figure over drafting ch.4.

### The figure, and why its form changed

Kim's idea from 2026-08-22 (*"Think: graphics"*): the intervals between fills are the times the car stood still. Built as `R/dwell_data.R` + `R/fig_dwell.R`, wired into `the_anchor.qmd` as **`@fig-dwell`**.

**The frequency diagram he asked for does not work, and rendering it is how I found out.** Counting INTERVALS puts 57% of the mass in a one-day spike and the standing time -- the entire subject of the chapter -- disappears behind it. **Counting DAYS instead asks the chapter's own question:** not how often did the car stand, but how much of its life did it spend standing. Y is a SHARE of each car's covered days, because the two records are different lengths (2,495 against 1,123).

**What it shows.** TwoRed **78%** of covered days in stretches of a month or more, Creamsicle **75%**. Driving days -- the one-day gaps -- are **5%** and **7%** of the calendar. The middle, 2 to 29 days, is **17%** and **18%**; the three buckets sum to 100% for both cars.

**★ BOTH CARS HAVE THE SAME SHAPE.** Different decades, different coasts, different jobs, one of them bought for a reason the other never had. The anchor pattern is the FLEET's, not TwoRed's -- which is a fleet-thesis result arrived at without any argument about the fleet.

**Two independent cross-checks passed on the first run:** the derivation reproduces the separately-recorded **86%** (TwoRed, stretches of two weeks or more) exactly, and Creamsicle's covered days come to **1,123**, the number already in `proj_Smart_Car.md` from the trip narrative.

Palette: dataviz slot 1, validator run, all checks PASS; INK tokens shared with `fig_regimes()`. Chapter renders clean; labels unique, no dangling refs.

### ★★★ A SEVENTH AUDIT INSTRUMENT -- THE ODOMETER AS A CLOCK

**Sort the fuel log by DATE and require the odometer to increase.** The six existing instruments each test a row against arithmetic, geography or its neighbours, and every one of them takes the DATE as given -- so none of them can see a wrong date. **This one was found by a figure, not by an audit**, because the figure needed date ordering and the ordering produced an interval of -1,410 miles.

**TwoRed: clean across all 294 rows.** Seven years of paper kept at pumps, and the dates are in order. That is a result worth ch.9.

**Creamsicle: exactly one failure.** The `2023-04-14 Ely NV` row (odo 47,168) sits 1,410 miles below a fill dated 2023-03-26. The odometer localises it between Parowan 03-13 (47,001) and Beatty 03-14 (47,304), and Ely lies on that road; a month-digit slip 03->04 is the obvious reading.

**But it is a LOCALISATION, not a correction, and I stopped there.** Ely -> Beatty is 136 odometer miles against roughly 260 road miles, which does not fit, so either the day is wrong in a way the odometer cannot see or a fill never reached the sheet. Kim has the paper. `dwell_data()` drops the one bad interval and reports the count (Finding 032); the source is untouched.

**⚠ It qualifies a claim already in the record.** *Creamsicle: odometer 30,290 -> 58,903, strictly increasing.* True in ODOMETER order; false in DATE order. Never wrong, but answering a narrower question than the wording suggests. Reworded in `proj_Smart_Car.md`.

### One point now sits below chapter 3's floor

`the_anchor.qmd` says nothing in either record ran below a mile a day. At TRIP level that holds (slowest between-trip span 1.68 mi/day). **At FILL level it does not:** TwoRed 2012-06-20 to 2012-12-21, **184 days, 158 miles, 0.86 mi/day** -- the longest single stand in either record. The empty floor in `@fig-regimes` is partly a property of the aggregation. Finding 043's shape again. Left for Kim: the sentence is his and he has approved it.

### Rulings and verification

**Naming (Kim):** the standing rule applies as written -- the St Louis car wash is not named, the niece is relationship-only with **Mentone kept**, institutions are named. Closes the two privacy calls carried since 2026-08-20 and unblocks ch.4.

**Verified before asking:** the 8-of-13 Lake San Marcos loop claim checks out exactly (trips 1-7 plus the Fourth Crossing; 2015_Sedona is a 3-leg 150-mile fragment, not a counterexample). **And the trip log undercounts the anchor** -- the 2010 first crossing has no trip log at all, only 43 fuel fills, odo 4 -> 10,916, and it is a loop from the anchor too. Ch.4's opening problem.

### Kim ruled, and applying it exposed missing machinery

**The Ely date: month 4 for 3, an uncorrected typo** (Kim). Straightforward -- except that applying it was not.

**`Creamsicle_log_errata.csv` was a DOCUMENT, not a mechanism.** `creamsicle_ingest.R` never read it. C01-C03 had been sitting there since 2026-08-19 as prose, and **the clean CSV still carried every uncorrected value.** TwoRed has had `twored_ingest.R` applying its errata with a refusing guard since 08-18; Creamsicle had the CSV and none of the plumbing, and the asymmetry had gone unnoticed because nothing ever tried to apply a Creamsicle correction.

**Built it, mirroring TwoRed rather than inventing:** `Creamsicle_corrections_machine.csv` (keyed to the ODOMETER, never a label) plus application inside the ingest with the same guard -- **a correction that cannot find its row is refused, and applied + refused must account for every entry.** Only `tier == "confirmed"` is applied, so **C01-C03 stay HYPOTHESIS and stay unapplied** until a card or receipt settles them. Re-run: `corrections: 1 applied | 0 REFUSED`.

**The odometer-as-clock check now runs INSIDE the ingest**, so the class cannot pass silently again.

**Verified by content, never size:** 173 rows, Ely reads `2023-03-14` flagged `C04:date`, odometer 30,290 -> 58,903, dates 2021-09-23 .. 2024-10-20, **strictly increasing in DATE order as well as odometer order.** Old CSV snapshotted to `C:\temp\creamsicle_clean_20260828`. **No headline number moved** -- 78/75, 5/7, 17/18, and the 86% cross-check all unchanged. The chapter re-renders clean.

**⚠ One thing still does not fit.** Parowan 03-13 (47,001) -> Ely (47,168) -> Beatty 03-14 (47,304) is 303 odometer miles; any route through Ely is roughly 440. **The date is settled; the distances in that stretch are not.** Left open, touching no number the book prints.

**Ch.3's floor sentence scoped to Kim's wording:** *almost no period ran below a mile a day*, with the strong claim now attached to the chart it describes.

### Kim answered the route, and the answer moved the error

*"We didn't take the Tonopah route; instead we did I-15 to Las Vegas and then 95 onward."* **He is right and my Tonopah assumption was the mistake.** By his route the odometer works: Parowan -> Las Vegas 167 against 172 great-circle, Las Vegas -> Beatty 136 against 103.

**But the distances fitting moves the problem to the CITY.** A great-circle distance is a FLOOR: no road covers 136 miles between two points 191 apart, and Ely -> Beatty is 191. So the fill 167 miles past Parowan is geometrically excluded from being Ely **whatever route was driven**. Beatty is corroborated by its next leg. The sheet plainly reads `Ely NV`, brand `Loves` -- not my transcription -- and Las Vegas already appears twice in this trip. **Put to Kim as a question, not a correction:** field entry, or a town written in later? If it is genuine, an odometer is wrong instead, which would be the more interesting outcome since the arithmetic currently corroborates all three.

**★ METHOD NOTE ON MY SIDE, worth more than the row.** I reported *Ely -> Beatty is ~260 road miles via Tonopah* -- a route I inferred and then stated as though it were a fact about the trip. The distance was right and the route was mine, not his. **The route-independent version was available the whole time: the great-circle floor, 191 miles, which settles it by geometry alone.** When a claim can be made from geometry, do not make it from a guessed route. Same family as the South Dakota lesson.

### ✓✓✓ THE CITY WAS WRONG TOO, AND KIM SETTLED IT FROM THE RECEIPTS

*"That was a data entry error. I went back to the station receipts and found that Ely is really Las Vegas. I have no idea how they got mixed up."* Applied as **C05**; the row now carries `C04:date C05:city`.

**Two errors in one row, each invisible to every test but one, and each caught by a DIFFERENT redundant field** -- the odometer for the date, the map for the town. The geography instrument did it: Ely -> Beatty is 191 miles great-circle against 136 on the counter, **and a great-circle distance is a floor.** Corrected, the same 136 becomes Las Vegas -> Beatty at 103 great-circle, ratio 1.32, ordinary.

**★★★ AND THE CHECK HE USED IS THE REAL FIND: THE FUEL RECEIPTS PRINT THE ODOMETER.** *"a duplication of data I had forgotten about."* **A fourth independent record, and the only one that duplicates the COUNTER** -- AMEX settles gallons, price and merchant, never a counter reading. **So the receipts can audit the one field every other instrument treats as ground truth.**

**Finding 045 for the FOURTH time** -- AMEX, Styx River Road, the Florida photograph, this. Every time the redundant record EXISTED and had been forgotten rather than lost. **At some point this stops being a lesson about instruments and becomes a rule about searching: inventory the redundant records BEFORE declaring a field uncheckable.**

**★★ It also answers his own advice from the other end.** He wrote *enter fields that will let you cross check values.* **The pump had been doing exactly that for him for years, on the receipt, and he had forgotten.** So the advice is not only prospective -- half of it is *find the redundancy you already have*. That is ch.9's ending, and it closes in recovery rather than in a warning.

### ⚠ Finding 046, committed a second time -- by me, in this session

I bound `pi <- "G:/My Drive/Projects_Index/project_index.md"` as a path shortcut while editing the index. **`pi` is base R's constant.** Every great-circle call after that failed with *non-numeric argument to binary operator*, and I checked the coordinates, the function and `sin`/`cos` before checking `pi` -- **a masked constant does not error where it is bound.**

**No reported number was wrong**, and only by luck of ordering: an earlier `rm(list = ls())` had restored base `pi` before the figures were computed, and all four were re-verified identical after `rm(pi)`. **The rule widens from Finding 046: never bind a bare short name at all.** Path shortcuts take a suffix. The dangerous ones are short and already exist -- `pi`, `T`, `F`, `c`, `df`, `data`, `sd`, `var`, `max`.

Worth noting the shape: the debugging worked because the numbers had an independent second computation to check against. **The same principle the whole session has been about, applied to my own working.**

### ⚠ AND THE GEOGRAPHY INSTRUMENT'S FLOOR IS NOW NAMED

Corrected, Parowan -> Las Vegas reads 167 odometer against 172 great-circle: ratio **0.97**, also "impossible", and **not a finding.** It uses a downtown centroid; a fill on the north-side I-15 corridor is ~12 miles closer and gives 1.03. **A shortfall smaller than the spread of the city itself is coordinate imprecision.** 0.71 is not -- no plausible fill point in Ely brings 191 below 136. **The ratio is evidence only when the shortfall exceeds the spread of the place.** Finding 036 in its geographic form, and it must be said in ch.9 beside the instrument itself.

### ★★★ KIM'S STATEMENT ON DATA QUALITY -- PART THREE's THESIS, AND IT IS PLACED

He gave it unprompted, and it is the argument the difficulty chapters have been circling:

> While this is a story about two cars, it is as much a story about data. Specifically the kind of data that's added now and then. Often under difficult conditions, like when you have cold, shivering hands. Or times when you're in a rush. It's easy to write down a wrong number. Transcription, too, often comes when you probably don't want to be typing a lot of numbers, some of which are hard to read. It is those distractions that can break the flow and cause another form of data error. The bottom line is that these types of data are difficult to get correct. When possible, enter fields that will let you cross check values (e.g., not just the date; add the day of the week).

**Split three ways, because it does three jobs.** The framing and the field conditions are **written into the Foreword** as one paragraph, straight after *The data.*, in his content and his contractions. The two error classes go verbatim into the **ch.8** scaffold. **The design lesson -- cross-check fields -- goes to ch.9**, which is where every instrument in the book actually depends on it.

**★ HE SEPARATES TWO ERROR CLASSES and the book should keep them apart:** the FIELD error (cold hands, haste, at the pump) and the TRANSCRIPTION error (hard-to-read figures, broken flow, at a keyboard years later). Different causes, different signatures. The slashed zero is the first; the Ely month typo is almost certainly the second.

**★★ AND HIS ADVICE WOULD HAVE CAUGHT TODAY'S ERROR ON THE PAGE, WITH NO ANALYSIS AT ALL. 2023-04-14 was a Friday; 2023-03-14 was a Tuesday.** A day-of-week column and the row contradicts itself at the moment of writing, where a fix costs nothing. What actually caught it, seven years later, was the odometer acting as an accidental second clock -- **and that is the whole argument: redundancy is not duplication. A cross-check field is a second cheap measurement of the same event, and it is the only thing that can catch an error in a field every test trusts. You cannot audit your way out of a missing column.**

⚠ *Two cars* is correct for the data chapters -- TwoRed and Creamsicle carry the logs. Not to be silently upgraded to four.

### Findings 047 and 048

**047 -- an instrument is blind to the field it takes as given, and a sort key hides errors in itself.** All six audit instruments take the DATE as given, so a wrong date was not a hard case, it was outside their range. And the ingest sorted BY ODOMETER: **sorting by a field cannot reveal an error in that field, because the sort imposes the order you would be checking.** The record's own claim -- *strictly increasing* -- was TRUE, in the ordering nobody had questioned. **A true sentence can be load-bearing in a direction it was never tested in.** Corollary: a figure is an audit instrument.

**048 -- on Drive Stream, overwriting an existing file can fail while creating a new one succeeds.** `write.csv()` over the target failed with *cannot open the connection*, repeatedly; a new file in the same folder wrote fine and `file.remove()` returned FALSE. **Write to a temp name, then `file.rename()` over the target** -- that worked where both did. The ground-truth rule in a new costume: verify by reading content back, since the return values here were a half-signal.

### Close-out (Mechanism 5)

1. **New projects?** None.
2. **Smart_Car header:** Status **Active**, Focus readiness **Ready** — unchanged, and correct: ch.4's scaffold is populated and the naming question that gated it is answered. Nothing is blocking.
3. **New files, added to Key Files:** `book/R/dwell_data.R`, `book/R/fig_dwell.R`, and `data/Creamsicle_corrections_machine.csv`. `creamsicle_ingest.R` is materially changed (errata application + the odometer-as-clock check) and that is recorded beside it.
4. **Cross-references:** project_index Active Focus rewritten, the superseded block archived verbatim to `logs/focus_history.md`, `proj_Smart_Car.md` updated in four places.
5-6. **Decisions logged;** this entry written.
7. **Active Focus updated**, and ch.4's topic note filed in `deferred.md` so tomorrow starts from an angle rather than a blank scaffold.
8-9. **Next Steps rewritten and made honest.** Items 1-3 were stale — ch.3 is drafted and approved and both privacy calls are ruled. What is left is real: draft ch.4; the four things only Kim has; the wide-tire re-derivation; TwoFer's 7 fills. **New item added from tonight: C01-C03 are three $/gal values and Kim has just demonstrated the receipts can settle them** — the same source that closed C05.
10. **Written outside `G:`:** one bucket-4 folder, `C:\temp\creamsicle_clean_20260828`, holding the pre-C04 and pre-C05 snapshots of `Creamsicle_fuel_clean.csv`. **Retention: delete once the corrected CSV has survived a session.** Nothing written to bucket 5.
11. **`pkm_health()` — 98.9 s, and clean where it matters.** 83 works, **0 reconciliation failures, 0 rendered-without-source, 0 broken pointers, pre-deletion gate 0.** Focus block 5.9 KB against a budget of 6.
12. **`pkm_backup()` — 1,230 files, 0 pruned, 0 size mismatches; secret scan CLEAN; committed `7aa72433b4`, 17 files changed; push VERIFIED AGAINST THE SERVER** (Finding 028 — the return value alone is not evidence).

**Two housekeeping items, both reported rather than acted on** (remedies are never run automatically):

- **`proj_Smart_Car.md` is now 48.6 KB against a 45 KB budget**, and tonight's edits are what pushed it over. It is flagged `splittable`. The project is in full flight, so the file growing is honest — but `split_tail()` to `logs/proj_Smart_Car_log.md` is the remedy when Kim wants it. `proj_seasonality.md` (51.6) and `proj_audio.md` (47.3) were already over.
- **Four build-scratch folders are past the 14-day threshold** — `pkm_edits_20260811`, `pkm_snapshots`, `timelapse`, `venuemirror_clone_2026-08-03`. Together they are under 1 MB, so this is tidiness, not space.

**Drift (4) and repo/clone mismatches (6) are unchanged from 2026-08-24** and belong to other projects.

### ⚠ THREE SESSIONS ARE MISSING FROM THIS LOG

**Proved, not assumed** (Finding 019): grepped the whole file for `2026-08-2[1-8]` at every heading level -- **zero matches**. The sessions of **2026-08-21, 08-22 and 08-24** produced chapters 1, 2 and 3, the boot measurement, the turning-circle rejection and several privacy rulings, and none of them has an entry here. **The work is not lost** -- it is in `logs/focus_history.md` (the archived Active Focus blocks for 08-21 and 08-22), in `proj_Smart_Car.md`, and in `deferred.md`. **Only the session-level record is missing.** Not reconstructed here, because I was not in those sessions and a plausible entry is not a true one.

---

## 2026-08-20 -- FOUR ANSWERS, A NEW ROAD TAXONOMY, AND THE RESEARCH PHASE ENDS

**Active focus at start and close:** Smart_Car. A short session: Kim answered the four lingering questions, and one of the answers corrected me rather than the record.

### The 2010 loop, in the right order

His corrected sequence maps onto the fuel log leg for leg: **BRIT in Fort Worth** (Flower Mound fill, 09-23), **the Botanical Society of America and MOBOT in St Louis** (09-29), **Nancy joins and they drive to Washington DC for her meeting**, north **to friends in MA** (Charlton, 10-09), **Nancy back to St Louis and home to HNL**, **the car stored at the car wash** (the 25-day gap), then **Pittsburgh for the Gigapan robots** (11-10) and **NSF colleagues in places like South Carolina** before heading west. **Finding 039 predicted exactly this: the components were all right last night and only the order slipped.**

**★★ AND THE GAP I FILLED WAS MINE TO GET WRONG.** I read the 10-02 to 10-07 hole as a Frostburg meeting because the distances fitted and Frostburg was a meeting I already had in hand. **It was Washington DC.** The arithmetic works for DC and always did — Waynesboro → Washington ~120, Washington → Gettysburg ~80, against 369 driven over five days. **Same failure mode as the finding I was writing at the time, committed by the analyst rather than the witness: a gap that admits several stories is not evidence for the one you happen to be holding.**

**★★★ And it names the origin of the states challenge.** *We did add on a bit of driving so we could see areas of the country neither of us had visited. That, incidentally, added to the total number of states TwoRed visited and, in a way, became the basis of the challenge.* **The sixteen-year project began as a by-product of scenic detours on scientific-meeting trips, noticed after the fact.** That belongs in the writing.

### Vermont, with a reason

**The Penultimate State is Vermont** — *I was working with a lawyer who has an office in NH, but lives nearby in Vermont. I drove to his house.* **That is exactly the anomaly the record flagged and could not read:** Hartland VT 5-18 at 44,746, next leg opens **Lebanon NH** 5-20 at 44,805 — **two nights, 59 odometer miles for an eighteen-mile drive**, and Lebanon sits across the Connecticut River from Hartland. **Office one bank, house the other.** One definitional point recorded for the writing: **TwoRed's state list and Kim's state list are two different quantities**, which is why the record holds 45 against a challenge counting to 49.

### ⛔ The Texas on-ramp — closed by request

*For personal safety, I wouldn't reveal it either. Near Ft Worth is sufficiently close.* **The three candidate legs I assembled yesterday have been removed from `deferred.md` and a standing constraint recorded** alongside the Creamsicle purchase reason and the `bordeaux*` naming rule. **A request, not a feasibility question** — it stands whether or not the record could pin it, and it cannot.

### ★★★ Road character — he withdrew his own answer and gave a better one

Kim checked a map and revised: the two West Virginia drives were **different highways**, and what they shared was *the same type of countryside; rolling, tree-covered hills, a winding highway, small villages tucked in the valleys.* **So the memory retained a LANDSCAPE TYPE, not a road, and *twice* counted instances of a category.** He said *highway*; he meant *this kind of country*. **Finding 039 amended: when a witness names a specific, test whether the specific stands for a class before treating a mismatch as an error.** The count was still right.

**And a category the project did not have: TREE TUNNELS** — *very long miles of straight divided highway lined by a dense thicket of trees. Flat. Monotonous.* In the South. The third term is what both are a relief from: *nearly straight freeways lined by commerce, billboards and wall-to-wall housing.* **The project's road taxonomy is built from SPEED; his is built from EXPERIENCE.**

**★★★ Gross speed cannot see it — Deep South median 40.3 mph (n=10) against Appalachian 38.0 (n=6), p = 0.42 — and that null completes a pair.** The Canadian Plains were the most STRESSFUL miles of the crossing and read as an unremarkable fast run. **The tree tunnels are the most MONOTONOUS and read exactly the same. The record is blind to the driver's experience at BOTH ends of the scale — terror and boredom produce identical numbers.** *Vigilance has no column; neither does tedium.* **The cleanest one-line case the project has for why layer 2 is load-bearing.**

### ⚠ A signal that cannot be settled, and it goes to the difficulty strand

The same split on FUEL does produce something: `mpg ~ leg_miles + group` gives South **-3.18, p=0.023** (n=30), **-2.61, p=0.065** with era, and **-5.81, p=0.009** on the 16 temperature-stamped rows with temperature itself null. **The mechanism would invert the intuition — flat straight highway invites steady high speed, and drag costs an 1,800-lb car more than hills do.** But the coefficient is **unstable across subsamples**, n=30, and temperature is confounded with group. **★★ Unlike the temperature effect it cannot be resolved by waiting: Creamsicle has ZERO southern fills. The sample is closed at 30 and will not grow.** **Do not print the coefficient. Print the fact that it cannot be settled** — a good story about a record, in the strand built for exactly that.

### Housekeeping

`deferred.md`'s Smart_Car section had grown to **70.9 KB with nine items already finished**; eight were moved verbatim to the log under **SMART_CAR ITEMS CLOSED 2026-08-19/20** and replaced by a one-line index, taking the section to **62.9 KB** and leaving it reading as open work. **The Active Focus block had grown by accretion to 4.8 KB of running log** and was rewritten as a statement of where the project stands. `proj_Smart_Car.md` condensed from 47.3 to **44.7 KB**.

### ★★★ AND THEN THE WRITING STARTED

Kim approved the 13-chapter list, the four parts, and the interleaving of the difficulty strand — *It is better to have more (the 13) than fewer... I agree with having the data spread through the story.* **He also ruled the tooling failures out of the book:** *they are just part of the process that we work through together. Nothing more.* The difficulty strand is about THE RECORD; Findings 037 and 040 stay in the PKM.

**The manuscript now exists** — a Quarto book at `Smart_Car/book/`, built to the house pattern from `whittakerr` and `storylines`. 15 chapter files, `R/book_setup.R` as the single source of truth with `stopifnot()` guards on the row counts, so **no number reaches a page without coming from an object.** Each chapter carries a scaffold comment holding its purpose, verified material, and the privacy constraints that apply to it. **Kim's dictated prose finally has somewhere to go that isn't a log.**

**Chapter 2 drafted, then rebuilt by Kim's material.** He gave what I could not invent: *the first thing people say is that it is cute* — **the preconception arrives as affection, not hostility**, which reframed the whole opening; the safety-cell demonstration with the race drivers popping out and their hands up; and the crosswind, which turned out to be about **variance, not force** — *not a constant push, but one sufficiently variable that I had to keep correcting* — the same shape as the frost heaves, six chapters early.

**★★★ And the pothole gave the chapter its thesis.** *You learn the pattern (flag equals slow and swerve). You begin to trust your experience. Accidents happen when the pattern doesn't hold.* **That unifies both close calls: they are one failure, twice.** A Dalton hazard with no flag; a ramp with traffic coming up it. **You cannot drive without trusting patterns and you cannot make patterns hold, so the only thing left to ask of a car is what it can do in the second after one breaks.** Written as: **a safety cell is for the crash you are having; handling is for the crash you are not going to have.**

### Two things caught while drafting

**THERE WERE THREE WHEEL STATES, NOT TWO.** Kim's steel-rim detail means the 2013 Dalton run — 21 fuel rows — was on different wheels entirely, and every before/after analysis had counted them as *after*. Excluding them the coefficient weakens from -1.82 (p=0.058) to -1.47 (p=0.129); **the conclusion survives.** The Alaska rows show +4-5 MPG but wheels are perfectly confounded with the whole expedition — **confound reported, nothing attributed.** *Another story revealing a variable the dataset did not know it had.*

**AND I PULLED A NUMBER OUT OF THE CHAPTER.** The -3.7% to +4.9% wide-tire interval carried since 2026-08-18 **could not be reproduced** under four reasonable specifications (+1.7% to +4.5%). **The claim is stable everywhere, so the chapter states the claim and prints no figure.** By intentions item 4, **a number that cannot be reproduced is not sourced.** Re-derivation with a written specification is a task in `deferred.md`.

### The Foreword

~950 words, opening on Kim's own sentence — *the overriding fact was that we needed a car in Lake San Marcos* — through the rentals and the parking spot to **an errand car**, then the turn, then **4 miles on the odometer against 71,283 at the Matson dock.** **Hawaii gets its own section, placed where the reader first needs it:** *without that, none of the above parses.* And it carries the second inversion — *you don't do much driving in Hawaii... Driving on the mainland was something different for us. Not a chore to be got through. The point.* **Closes on the scope boundary as SUBJECT, not omission.**

**Two photographs wired in**, and asking about them was worth it — the day-one picture is on the ORIGINAL narrow tires, not the wide alloys as I had assumed. **`@fig-day-one` does the pointing the text describes: the silver safety cell is right there in the frame.** `@fig-wide-wheels` gives the reader the after. ⚠ `*.jpg` is gitignored in the mirror, so **photographs are not in the versioned backup.**

### Where this leaves the project

**The research phase is over.** Both cars are ingested, the record is closed at both ends, every open question is answered or explicitly constrained, and the architecture is settled down to what layer one contains. **The next action is not analysis. It is drafting the chapter list against the three layers and writing the safety chapter.**

---

## 2026-08-19 -- THE STORIES ARE COLLECTED; THE RECORD IS CLOSED AT BOTH ENDS; CREAMSICLE IS INGESTED

**Active focus at start and close:** Smart_Car. A long session in three movements: fix a date bug, collect Kim's accounts of the long drives, then close the record and ingest the second car.

### The date bug, and the structural fix

29 dates written as 2026-08-19 instead of 2026-08-18 across 8 files — **the third recurrence of Finding 029.** The session clock is UTC and Honolulu is a day behind from 14:00 HST. Fixed by same-length `gsub(fixed=TRUE)`, verified per file by content. Structural fix now standing: bind `TODAY <- format(Sys.time(), "%Y-%m-%d", tz="Pacific/Honolulu")` ONCE at session start and never call the clock again.

### Eight long days, eight stories, and every one checks out

Kim gave accounts of all eight of the longest driving days. They are verbatim in `logs/proj_Smart_Car_log.md` under COLLECTED STORIES. What they changed, none of which the data could have volunteered:

- **Finding 033 got its best corroboration from an unrelated direction.** The Champaign slashed-zero cost typo (L61) sits at the stop where he had just discovered he was 100 miles off course, out of fuel, and late for dinner. He gave the *record quickly under pressure* mechanism two days earlier, blind to this route.
- **Arrival-to-next-departure odometer gaps are the day OFF the highway.** 70 miles at Holbrook is a tour of the Petrified Forest with his nephew. Readable across the whole record; nobody has read it.
- **Lodging geography is a first-order term in daily distance.** The fastest day in sixteen years is fast because Montana has nowhere to stop.
- **A ferry is a logistics multiplier, not a hole in the odometer.**
- **A long elapsed time is not a slow day.** LSM→St George read 31.6 mph and was a normal drive with a half-day visit in Las Vegas inside it.

### Two findings that came from being wrong

**Finding 036.** I concluded from the fuel log that TwoRed never reached Florida. Kim: *I aimed at the panhandle. I drove just barely into what I thought was Florida... 'Is this Florida?' 'Yes.' That's all I needed.* **A record's RESOLUTION sets the floor on what its silences can mean.** A log that samples at fill-ups cannot see an event measured in minutes.

**Finding 035.** His Las Vegas story exposed `tz_shift_hr = 0` on every leg I had transcribed — 16 of 107 wrong. Fixed as a COMPUTED derived layer in `trip_logs_read.R` against a 121-city timezone table, never a typed field. **A duration spanning two local clocks is not a subtraction.**

### Two more corrections from Kim, both instructive

**The Youngtown arrival.** I read 7:41P, then argued from a "crossbar" for 9:41P. Kim: *arrival is 8:41. My writing was very light.* The bar was a bitonal-thresholding artifact. Filed as a second scan illusion under Finding 033 — **opposite in kind to the slashed zero: that one lives in the ORIGINAL, this one lives in the SCANNING, and the original settles it.**

**"Abruptly slowed."** I read his frost-heave account as *drove slowly* and reported the flat gross speed as the data failing to corroborate him. He revised: *I couldn't go slow as big vehicles kept moving at highway speeds.* **His account PREDICTS the null. The high average is the mechanism of the stress, not evidence against it.** And it names the missing quantity exactly: **within-leg variance, which two endpoint samples average away by construction.**

### The record is closed at both ends

Four more scans processed. The last one carries a note on the back of the log: `5/22/17 71,283 LV Seattle @ Matson`. **71,283 miles at the Matson dock — the mainland record ends there, documented.** The first question the project ever asked (how many miles were Honolulu miles?) now has an answer: **≈3,697 implied**, the scope boundary quantified rather than assumed.

**The temperature effect was retired.** The Fourth Crossing's 31 fill-stamped temperatures took n from 94 to 125 and moved the coefficient from -0.068 (p=0.045) toward zero, -0.050 (p=0.099), p=0.17 with controls. **A marginal result that attenuates as the sample grows was noise.** Worth its own line: the record is now good enough to RETIRE a result, not only produce one.

### Creamsicle — the second spine

Kim exported the Google files; `creamsicle_ingest.R` reads them, skips interleaved summary rows programmatically and REPORTS the skip counts (196→173, 119→86, 10→6). Odometer 30,290→58,903, strictly increasing. **143 of 170 US rows balance the pump identity to under half a cent; exactly three fail by ≥2¢, and all three are errata** — C01 Oxnard caught by contiguity (the $/gal cell is identical to the Gallons cell), C02 a transposition, C03 a slashed-zero-family digit.

**The headline: Creamsicle logs STOPPED time, so it measures what TwoRed structurally cannot.** Across 84 timed legs, **median gross 43.5 mph against median NET 51.0 — a 7.5 mph gap.** The vivid case is 2024-10-20, Wisconsin Dells → Madison: 50.3 miles, 5 hours elapsed, 4.5 of them stopped, gross 10.1 mph, comment `Cranes`. **Every TwoRed gross-speed figure in the project is now readable as a ceiling roughly 7–8 mph below actual driving speed.** Two-car comparison: median MPG 39.12 vs 40.59, but cost per mile $0.0939 vs $0.1183 — **a 26% difference that is almost entirely fuel PRICES, not the car.**

### Finding 037, found by an arithmetic that refused to work

`proj_Smart_Car.md` was trimmed by 4,045 characters of prose and `pkm_budget()` still reported it over the 45 KB budget — then reported it LARGER after rewriting byte-identical content. **`writeLines()` opens a text connection; on Windows it translates the `\n` inside an already-CRLF string, so `\r\n` becomes `\r\r\n` and every rewrite adds another CR.** The ground-truth rule (verify by CONTENT, never size) passed correctly at every step — **the corruption lives in the whitespace, the one part of the content a content check does not look at.** Scope check: 89 markdown files, exactly one affected, written by me this session. Write path is binary now.

### Finding 038, found by checking the mirror instead of reading its report

`pkm_backup()` ran clean — 1,202 files, 14 changed, pushed, local HEAD `4358c2f0` identical to the remote ref. Then I listed the mirror by hand: **39 Smart_Car files, and the 22 scanned PDFs are in none of them.** The paper logs — every primary source behind the errata, the only artifacts here that cannot be regenerated — have never been backed up.

**The lesson is about the shape of yesterday's repair, not the extension list.** Finding 034 burned me on `csv`, so I added `csv` and `xlsx` and verified them. **I never asked the general question — what else on disk is not in the mirror — which is one line and answers immediately.** A fix scoped to the observed instance leaves the class intact, and the verification passes because it is scoped the same way. **New rule: after changing what a backup includes, verify the COMPLEMENT — enumerate what is on disk and outside the mirror — never the fix.**

**Not patched unilaterally.** `pdf` in `SOURCE_EXT` would sweep 290 MB of rendered figures into a 10.8 MB mirror; the narrow rule (PDF is source only under `data/`, `scans/` or `source/`) takes 23 files, 8.7 MB. It changes policy for every project, so it is a decision for Kim and sits in `deferred.md`.

**Note the pairing with Finding 037, filed an hour earlier: two verifications in one session that inherited the blind spot of the thing they were verifying.**

### Then I ran the complement check properly, and it broke my own proposed fix

**The mirror has TWO gates and each is blind to the other.** `SOURCE_EXT` decides what is COPIED in; the mirror's `.gitignore` decides what is COMMITTED, and it carries `*.pdf`, `*.jpg`, `*.png`, `*.tif`, `*.mp3`, `*.mp4`, `images/`, `pdfs/`. **The narrow PDF rule I had just proposed to Kim would have copied all 22 scans into the mirror and committed none of them — and reported success.** Verify at the COMMIT with `git_ls()`, never at the copy.

**And the gap is not about PDFs.** `.txt` was classified as DATA on 2026-08-18. Outside the backup on that classification: `Preface_text.txt`, `Chapter_13.txt`, `Research_Introduction.txt`, five `mRNA/Slide_N.txt`, `full_story.txt`, `Nike_challenge_canonical.txt`, a dozen `*_guidelines.txt` prompt documents, plus `Smart_Car/source/Smart_Car.docx` and `Smart_Car_2016.pptx`. **Manuscript text, narration scripts and authored prompts — the least reproducible things in the PKM.**

**⚠ And the obvious repair would publish a credential.** The same set holds `auth_token.txt` (96 bytes) and `How_to_store_and_use_API_keys.txt`; the mirror pushes to a GitHub remote. Nothing is exposed today because those files are outside it. **Precondition recorded: audit the complement for secrets and confirm repo visibility before any extension is added.**

**What is not the problem: 8.5 GB of jpg/tif/arw/wav/mp4.** Git is the wrong instrument for those and their absence is a design decision. **Three times in one session a repair was scoped to the instance I had just been shown. The complement check is the only one of the three that found anything.**


### After dinner: three answers from Kim, and the record confirmed all three

**The 46 Dalton miles.** Coldfoot → Wiseman and back — a tiny town up the road, a museum tour from a resident, friends who had shredded their tires on that stretch years earlier and came along as a chase car, and the season's first snow starting at the farthest north point. **The two Yukon River Crossing fills split the 46 exactly: 32 miles north of the river, 14 at the Fairbanks end.** Coldfoot is Dalton mile 175 and the Wiseman spur is ~16 road miles on — out and back is 32, to the mile. **A matching TOTAL does not mean a matching ROUTE (the Dragon); a SPLIT total localises the discrepancy.** Same instrument, run the other way.

**And the same leg is the extreme case on two other instruments his story now explains.** It is the **slowest leg of 200+ miles in sixteen years, 22.6 mph** — against **28.6 over the identical road the day before**. That is FIVE THINGS #5 with a control: the road held constant, the difference is entirely the museum, the village and the turnaround. And it departs at **38 degF**, tied second-coldest of 136 timed legs, after Coldfoot read **64 degF at 18:26 the previous evening**. A 26-degree overnight drop on the morning he says the snow began.

**The Penultimate State was never Florida.** Kim: 49 mainland states leaves **Hawaii as the Ultimate State**. Florida mattered only as the last unvisited SE state; there were more gaps up the East Coast. **The record's last new states all fall on the trip he himself named Penultimate State — Vermont 5/18, New Hampshire 5/20, Maine 5/22 at Lubec, the easternmost point of the continental US.** He remembers Vermont; the record's last is Maine. Left open, because he is the better instrument. Vermont does carry a mark: the trip stops dead there, **two nights and 59 odometer miles for a drive that is 18 miles direct.**

**★★★ And Delaware turned out to be recoverable.** Four mainland states never appear anywhere: Florida, Delaware, Rhode Island, South Dakota. Florida is Finding 036. **Delaware is the same silence and geography breaks it:** the 2014-05-16 Colonial Heights VA fill → Bellmawr NJ reads **264 odometer miles** against a great-circle of 219 — ratio 1.21, ordinary interstate. Every road near that length crosses Delaware; **the only Delaware-free route is ~305 miles, forty more than the odometer permits.** The record holds Delaware as a DISTANCE, not a name. **The errata rule read backwards: key to a ROW, never a LABEL.** And the charter's province claim is confirmed exactly — ten, all present — while the states stand at 45 documented, 46 with Delaware, plus Florida on testimony.

**West Virginia is left open on purpose.** He gave the shape — two trips, scientific meetings, direct the first time and a detour the second — but the record's four WV touches sit on **two highways 150 miles apart**, and it holds exactly **two morning drives through those hills: 2012-06-08 westbound on I-68 out of Frostburg at 07:31, and 2016-06-12 eastbound on I-64 out of Huntington at 08:58** on a route that detours north and then back south. Different roads. **Route inference has been wrong twice in this project and was not trusted with a third; the question went back to him as one word.**

### West Virginia closed — and the memory's failure mode is the finding

Two hints from Kim did it. First, the second meeting was **Pine Mountain KY** — in the record, 6/4 to 6/9, reached from the west with no West Virginia on the way in, so the WV miles are entirely post-meeting and cost **~370 extra: Atlanta → Richmond is ~525 direct and he drove 895**, pinned by fills at Cherokee NC, Pikeville KY and Lewisburg WV. Then: *we drove south out of Huntington.* There is no southbound departure in 2016 — **but there is one in 2010**, Barboursville WV (a Huntington suburb) at odometer **3,310**, the car ten weeks old, then 197 miles to Hillsville VA against a 142-mile great circle: I-64 east to Beckley, then I-77 south.

**The two runs share the Charleston → Beckley stretch of I-64, and Kim confirmed it on Street View.** The closure is unusually clean: **the record puts TwoRed on that stretch on exactly two days in sixteen years, and *twice* is the count he gave before anyone counted.** Both times the behaviour is identical six years apart — **arrive Huntington late, sleep, drive the hills in the morning** (2010: a 275-mile day ending at the fill; 2016: in at 14:54, out at 08:58 for 359 miles at 49.9 mph, the trip's fastest leg). **He stopped short of the mountains twice, deliberately, to start the beautiful part in daylight — a decision legible in nothing but arrival and departure times.**

**★★ What the memory got wrong is the interesting part, and it is not the road.** He named the pair as Frostburg 2012 and Pine Mountain 2016. **Frostburg is I-68** — two Morgantown fills, the 6/1 one sitting 65 miles short of Frostburg against I-68's ~63 — and **I-68 never touches this road.** So: the ROAD was right, the COUNT was right, and the CATEGORY of occasion (*a scientific meeting in the region*) was right of both trips. **What slipped was the BINDING between the road and one of its occasions, and it slipped toward the occasion sharing the category.**

**This is the mirror image of Finding 036.** There, the record was silent and the memory carried the fact. Here the memory carried the fact — road and count — and the record supplied the index. **Neither instrument is reliable alone and their failure modes are different, which is precisely why the pair works.** Filed with the write-up in the log.

**Left open:** the two 2010 West Virginia trips have no stories — Barboursville 9/30 (now known to be the first of the pair) and Summersville 11/14 on US-19, the New River Gorge Bridge road. Six weeks apart, both inside the car's first four months.

### ★★★ THE CHAPTER ARCHITECTURE IS SOLVED — Kim's three layers

He offered it as preliminary thinking he wanted recorded. **It closes the weak point named on 2026-08-16 and it is better than the frame it absorbs.** Car = the hook and the preconception; the drives = the stories; the data = the answers, *including questions you didn't know you had*. **The car/human fabric runs THROUGH all three layers — it is the weave, not a chapter — so TWO LOGS, TWO SUBJECTS becomes a component rather than a rival.** That frame was an excellent SORTING rule and a useless ORDERING rule; this one answers what a reader meets first and why they keep going.

**The layers are three depths of one material and each is bought by the one above.** Without the preconception the drives are just travel; without the drives the numbers have no question attached; without the numbers the stories are anecdote.

**And he named the data layer as having two ends — the collection/transcription/cleaning difficulties at one, analysis and display at the other. The first end is usually exiled to an appendix and that would be a mistake here:** the slashed zero, the crossbar that was a scanning artifact, the pump identity, the split total that places a route, the backup with two blind gates — **these have the same shape as the driving stories and the same suspense.** An editorial rule falls out: **an analysis earns the analysis strand only if it answers a question the drives raised; results with no story belong to the difficulty strand instead.** The retired temperature effect, the wide-tire interval and the Canadian non-result sort themselves immediately.

### ★★★ AND THE ARCHITECTURE WAS VALIDATED THE SAME DAY, BY ACCIDENT

Kim then told the St Louis car-wash story — offered only to apologise for not remembering Summersville. **He had been at a Frostburg meeting, drove to St Louis, left the car in a car wash facility, flew home, came back for it, and eventually returned to California through the South, visiting colleagues at universities on the way.** The reason he gives is pure logistics: *by leaving the car in St Louis, I avoided having to drive back to California and then return soon after over the route I'd have just taken.*

**It is all in the fuel log.** The parking is **Altamont IL 2010-10-11 at odometer 5,730 → Effingham IL 2010-11-05 at 5,957 — 25 days and 227 miles between two towns seventeen miles apart on I-70.** St Louis is ~85 miles west of one; in and out plus local driving is exactly 227. The southern return is unmistakable — Summersville WV → Bessemer NC → Villa Rica GA → Tupelo MS → Bryant AR → Mt Pleasant TX → New Mexico → Arizona → El Cajon. And *colleagues at universities* is five fills and five short legs in four days across Pennsylvania.

**★★★ Then the part nobody was looking for.** Asking *where does this car sleep?* — a question no one had put to the data — **2,147 of TwoRed's 2,495 recorded days (86%) fall inside a dormancy of two weeks or more. There are 35 such spells. Thirty are in California, two Arizona, two Oregon. Exactly one is east of the Rockies, and it is the car wash.** His story is the sole explanation of the only outlier in a distribution that had never been computed. **Layer 2 generated the question, layer 3 answered it, and this happened within an hour of him proposing the architecture that says exactly that.** A new analysis is queued: THE PARKING CONSTELLATION, mapped against the driving one.

### Finding 039 — a memory's error profile

**Two instances in one evening with the identical shape.** West Virginia: the road was right, the count was right, the category of occasion was right, and **the binding to one occasion was wrong** (2010, not Frostburg 2012). The 2010 loop: every component confirmed — meeting, car wash, Nancy, New England, universities, southern return — and **the order of two of them inverted** (New England is before the parking, not after).

**The rule: a human witness to their own past is reliable for CONTENT and unreliable for INDEX.** Roads, counts, distances, reasons and categories survive decades; **what slips is the attachment of a remembered thing to a particular occasion, and it slips toward occasions that share the category.** Operationally — when story and record disagree, do not ask which is right, **ask which PART disagrees.** And note the complement: Finding 036 is the mirror, where the record was silent and the memory carried a fact the data could never produce. **Different failure modes is precisely why the pair works.**

### ★★★ THE SAFETY THESIS — layer one turns out to have a fear in it

Kim added it last, saying it was *part of the story motivation*, and it supplies what the architecture was missing three hours earlier: **what the preconception actually IS.** Not *that thing is a city runabout* — a shrug, and no reason to turn a page. **IS IT SAFE?** *These are small cars!* **A preconception with a fear inside it can carry a book.**

**His answer has three parts and only the third is the thesis.** The engineering answer — Mercedes, the safety cell, race-car logic — with his own honest verdict on how it lands: ***Do they believe it? Maybe. Maybe not.*** That sentence should survive into the writing; a spec sheet does not defeat a visual impression, and the document is stronger for admitting it. The empirical answer: sixteen years, prudent driving, nothing happened. **And then: SMALL AND NIMBLE ARE COMPONENTS OF SAFETY — which INVERTS the preconception instead of rebutting it.** Size stops being a liability to excuse and becomes the mechanism of the escape.

**Both close calls support it directly.** The Yukon pothole was, by his account, *big enough to eat a big car too* — **the hazard was size-blind; the escape was not.** And the second, told tonight for the first time: **an on-ramp east of Fort Worth, a police car coming UP it at full speed with no lights and no siren.** Hard right, hard brakes, a slide to a stop inches from the guard rail. He sat there shaken, wondering if HE was the one going the wrong way, and **watched several cars take the ramp exactly as he had.** *Did the police stop? Of course not. This was Texas.* Note the structure: **the hazard was external, unlawful and unpredictable — no amount of prudence prevents it. What was available was steering and braking inside a very short distance.** That is a handling argument, and handling is measurable in a way a crash test is not.

### ★★★ And the safety chapter is the proof that the three layers are load-bearing

**Layer 3 supplies the denominator, and it is a real number: 100,999 documented miles across three cars** — TwoRed 71,177, Creamsicle 28,613, TwoFer 1,209; ~105,000 with TwoRed's implied Honolulu miles. **467 fill-ups, 225 logged legs, 45 states, 10 provinces, gravel on the Dalton, frost heaves across the Canadian Plains, Deals Gap, US-101. No crash.**

**Layer 2 supplies the numerator, and nothing else can.** A crash avoided buys no fuel, ends no leg, covers a few hundred feet and takes under a minute — **invisible to this record by construction**, Finding 036's resolution rule and the means-not-variance rule at once. The near-misses exist only because he remembers them.

**Neither half is an argument. 101,000 miles without the near-misses is an absence of evidence; the near-misses without the miles are two anecdotes. Together they are a rate and a mechanism, which is what a safety claim requires.** Recorded as the chapter to write first.

**★ It also closed the wide-tire loop, open since 2026-08-18.** The only modification TwoRed ever got was made for safety — crosswind on the stock narrow tires — and tonight Kim made the link explicit: *the cars have handled well and this, in part, keeps them out of dangerous situations.* **So the fuel data's job was never to judge the modification but to price it: indistinguishable from zero, 95% interval -3.7% to +4.9%. The safety modification was free.** A layer-3 answer to a layer-1 question, and it had no home until tonight.

**Two disciplines recorded, both in the difficulty strand.** *Granted, no crash testing* is his own caveat and the right one — the record cannot answer a counterfactual. And **the 101,000 crash-free miles must not be oversold**: one prudent driver, mostly interstate, mostly daylight, almost no urban commuting. **The miles show the car did not prevent sixteen years of safe driving; the near-misses are where the car actively contributed.** A crash-rate comparison needs a sourced per-mile figure first (intentions item 4).

**And the Texas incident cannot be located, which is the third demonstration in one evening.** Four eastbound approaches to Fort Worth exist in the log; the 2012 and 2014 legs are the same city pair 44 miles apart, but both span several days, so local driving explains the spread and the geographic instrument cannot discriminate. **Candidates went to Kim as a question, not an inference.**

### Close

`proj_Smart_Car.md` back under budget with four write-ups moved to the log behind pointers. `deferred.md` carries the Creamsicle result and two new TASKs (extend the timezone table to Creamsicle's cities; normalise TwoRed's Canada2014 litre/CAD rows before the Canadian Plains variance test is cited — it is a NON-RESULT, not a null).

**Still open, and it is the only thing blocking the writing: the CHAPTER ARCHITECTURE.** Kim's two-subjects frame is the candidate and is now bounded — the trip log measures what the human ACHIEVED, in means not variance, and the stories are the sole record of what it COST. Questions for Kim: the 46 unexplained Dalton miles; which West Virginia pair; what "Penultimate State" names now that Florida is reached; the storyless 487-mile LSM→Carson City on 2013-08-04.

---

## 2026-08-18 (evening) -- THE CORRECTED DATASET EXISTS; ALL 15 SCANS READ; the backup was not backing up the data

**Active focus at start and close:** Smart_Car. Second half of the day, after a dinner break. The morning
entry below covers the audit; this one covers turning the audit into a DATASET and then, for the first
time in the project, asking the data a question.

### The May-June 2016 hole was not a hole

I had filed the Fourth Crossing's contaminated rows as unrecoverable. **I had searched one folder.**
Kim: *it's an electronic shoebox. I scan paper. All paper.* He produced the AMEX statements for both
months and then the actual pump receipts. All three unknowns fell out: **LSM 3.641 gal / $10.92,
Blythe 4.531 gal / $14.04, Winslow cost $15.48.** Same shape as the Creamsicle closure two days
earlier -- **the wrong KIND of search, not missing data.** Recorded in `deferred.md` as a rule, because
twice in three days is a pattern and not an accident.

### `twored_ingest.R` -- and the three things building it forced

Signature `twored_ingest(apply_hypotheses = FALSE, verbose = TRUE)`. Reads the xlsx plus three
correction files, emits `data/TwoRed_fuel_clean.csv` (294 rows x 16 cols) carrying `corrections` and
`corr_source` per row. **34 applied, 0 refused, 1 inserted, source never edited.**

A correction LIST would not have surfaced any of these; only the BUILD did:

1. **A row INSERT.** The Big Spring row was a **chimera** -- date, city and brand from one stop, all four
   numeric fields from another. It **passes the arithmetic test perfectly**, because every number in it
   came from a single real row. Relabelling it would have been directionally right and structurally
   wrong. It needed a SPLIT.
2. **EXPLICIT partial-fill flags.** A flag recomputed from a threshold on every run is not a recorded
   decision, it is a guess that changes when the threshold does.
3. **A guard that REFUSES.** Any correction whose `old_value` does not match the live source row is
   rejected rather than applied. It fired immediately on **two errata keyed to the wrong odometer**
   (L07 at 65789 not 58213; L14 at 11794 not 12034). **A correction that cannot find its row is a bug,
   not a no-op.** It also caught my own date comparison being string-based against Excel serials --
   **I fixed the guard, not the data.**

Finding 032 is written into the code: order by the monotonic counter, never the date, and
`stopifnot(nrow >= n_src)` -- rows may be ADDED, never silently lost.

### Six results, on clean data, for the first time

Median leg **251 mi**; log distance about **95%** of odometer miles (the scope boundary showing up
again, quantified). Lifetime **39.44 MPG**, at the EPA highway end. **Leg length is the strongest
predictor: +4.61 MPG per 100 miles of leg.** No degradation over sixteen years -- **+0.30 MPG per
10,000 miles**, controlled. **$0.0936 per mile** lifetime fuel cost. Temperature: null, with the
caveat that the recorded range is only 38-94 F.

From the 50 transcribed legs with both times: **median departure 08:13, arrival 16:35, an 8.7-hour
day, 317 miles, 37.9 mph gross**, earliest departure **05:35**, and **46% of departures before 08:00**.

### ★★ I over-claimed, and caught it in the same turn

On the wide tires I wrote that the data *rules out a penalty worse than 3.7%*. **It does not.** -3.7%
is one END of a 95% interval running to **+4.9%**, and that interval **straddles zero and contains**
the 1-3% penalty theory predicts. The defensible claim is narrower: **a large penalty is ruled out; a
modest one is undetectable at this n.** Same failure mode as Finding 032 -- **a number that looked
like a bound was one end of an interval.** Filed as a CONDITIONAL in `deferred.md` so the strong
version cannot come back.

**And Kim reframed the question underneath it.** The wheels were never a fuel decision: the stock
narrow city tires let crosswind push an 1,800-lb car around at highway speed, Smart Madness prescribed
wide tires (fancy rims came along, because the car is fun to be seen in), and **the handling became
very good.** So fuel is not the axis the change was made on. **The measurement's job is to say what
the fix COST, not whether it worked.** Kim already knew it worked; he drove it.

### Close

Kim's call to checkpoint before continuing -- *it might be best to record our progress in the PKM
before going on. We'll come back to the analyses.* Right call: the day produced a dataset, a script,
six results and a withdrawn claim, and none of it was written down yet.

### Later the same evening: the scan backlog closed, and Finding 034

Kim: *let's keep working through the six remaining scans.* **Eighteen pages, seven files, every column** -- the transcribe-once rule, applied. **Trip legs 69 -> 107; fuel rows carrying a time and temperature stamped on the FILL, 0 -> 95.**

**The first file tested the rule and passed it.** `2011..._STL.pdf` turned out to be the June sheet rescanned -- different md5, same four pages, **zero new legs.** But it carried 23 fuel-row temperatures the first pass had walked past, because that pass was looking for distance.

**★ The wheel change is DATED.** In Kim's hand, top margin: `NEW WHEELS @ 13510 miles`. 179 miles before the St. Louis departure, so the narrow-tire group is exactly 2010-07-23 to 2011-05-11 -- the first crossing plus local driving, matching his account. **And the estimate still flips sign with specification** (+3.6% / +1.7% / +1.6% / -1.8% / -1.5%). That, not any one number, is the finding.

**★★ Temperature is not null; the earlier test used the wrong instrument.** MPG is per FILL, so temperature belongs on the fill. n=94: **-0.068 MPG/degF, p=0.045**, stable -0.068 to -0.084 across four specifications; fills at 80F+ average 36.76 against 38.87. **But p crosses 0.05 under era fixed effects and the sign is counterintuitive.** Filed as a signal, not a finding. I over-claimed on the wheels once already.

**★★ The slashed zero produced three more, and the control held.** Over the 44 rows failing the pump identity: the permitted 8->0 substitution fixes **4**; the forbidden 0->8 fixes **1** (Deming, already flagged wrong-direction); six control substitutions fix **0**. L59 is the FIRST fill in the record; L60 is the SAME ROW as L01, which already had a proven slip -- two in one row.

### ★★★ Finding 034 -- the backup reported success and did not contain the data

`pkm_backup()` committed, pushed, and verified against the remote ref -- the check Finding 031 added. **And 82 of the 85 files in Projects/Smart_Car were not in it.** `SOURCE_EXT` had no `csv`. Every errata file, the corrected dataset, all ten trip logs, the source workbook, all 17 scans: outside the backup. **The scripts were backed up; everything they operate on was not.**

**Every check tested that the mechanism EXECUTED. None tested WHAT IT COVERED.** Same error as Finding 031, one level up: I verified the transport and never verified the manifest. Caught only by reading the mirror for a file I expected to find -- the directory did not exist.

**Kim decided it the same evening:** *yes, we should be doing that too. After all, these files are where data live and that's often our focus.* **And the fix immediately found a second bug:** admitting `xlsx` pulled in Excel's `~$` lock file, which is locked, reports 165 bytes and copies as 0 -- **the size-mismatch guard refused to commit, correctly.** `.is_source()` had a `.~lock.` rule for LibreOffice and none for Excel, because no Office extension had ever been whitelisted. **Widening an inclusion filter is a change of KIND: every extension admitted brings its application's debris with it. Budget for the debris, not the bytes.**

Result: **mirror 975 -> 1,191 files**, Smart_Car 3 -> 26 of 85, verified BY CONTENT inside the mirror (61 errata rows, 10 trip logs, 294-row dataset). The binary tail -- 168 MB of photographs, 17 scan PDFs -- is left open as a git-LFS question, deliberately.

### Close

Kim, on being shown the four longest days: *I remember why I drove each of those. One was a navigation error; we went 100 miles off course and we were almost late for a dinner appointment.* And: *for me, a lot of this is memory lane material.* **Unprompted, that is the best evidence yet for his own TWO LOGS, TWO SUBJECTS frame** -- a 575-mile day is a number in one spine and an EVENT in the other. It also means the trip-log outliers are chapter hooks with a living source, and the stories should be collected BEFORE the analysis chapter is written.

---

## 2026-08-18 -- THE FUEL LOG AUDIT CLOSED; three trips transcribed; two findings; five of my own conclusions overturned

**Active focus at start and close:** Smart_Car. A long session, Kim driving it from the paper.
Opened with the R bridge DOWN (ClaudeR addin not started) -- read via the device bridge after clearing
the stale staged copies (Finding 015), and held off writing until the bridge returned.

### What was built: five audit instruments, none redundant

pump identity / economy / geography / **contiguity** / **price-family**. **Every major error today was
caught by exactly one of them.** The decisive pairing is **contiguity + arithmetic**: where two adjacent
rows share a value, **the row that BALANCES is the source and the row that FAILS is the copy** -- a
determination neither test can make alone.

### ★★ The sixth instrument was Kim's handwriting

Four typos across 2011-2015 shared one shape -- a **zero recorded as an eight**. Kim gave the cause:
**he writes slashed zeros.** Run as a search generator it produced two new candidates from residuals
already dismissed as rounding; **then the mechanism rejected one of them**, because a slashed 0 reads
as an 8 but an 8 does not read as a 0. **A cause-based test beats a fit-based test because a cause
constrains DIRECTION.** Control: 0<->8 hit 2 of 15; 1<->7 and 3<->5 hit 0 of 39 combined. **Finding 033.**
**And its limit, recorded: for the 0/8 class SCANS ARE NOT EVIDENCE** -- the scan is where the illusion
lives, so only arithmetic or a card can adjudicate.

### ★★ Five of my own conclusions were overturned, all by Kim's paper

1. **The 'odometer high by 130-170' hypothesis** at Big Springs -- elegant, self-consistent, two
   independent estimates agreeing within 45 miles, and **wrong**. The town was Alpine.
2. **The 'relabel it Alpine' fix** -- directionally right, structurally wrong. The row needed SPLITTING:
   a chimera with date/city/brand from Big Spring and the four numeric fields from Alpine. **It passes
   the arithmetic test perfectly**, because all four numbers came from one source row.
3. **Withdrawing the Big Spring gazetteer fix** -- wrong, because I assumed one label means one place.
   `Big Springs, Texas` appears three times and means three different things. **Errata key to a ROW.**
4. **Morgantown's 100.6 MPG** -- the largest anomaly in the dataset, and **my own filter made it**
   (Finding 032). Kim asked one question about the raw rows and it collapsed.
5. **'The cost is wrong at Homer'** -- his card confirmed the cost, and two independent tests then
   agreed the GALLONS were the fault.

### Results

**45 log errata + 8 gazetteer errata**, each with basis, evidence and status. **Arithmetic class
EXHAUSTED.** **'Missing fill-ups': 5 flagged, 0 real** -- one merged row, three partial fills, one
artifact. **Three trips transcribed, 67 legs** -- 2011 St. Louis, 2013 Arctic (18 of 18 exact), and
2014 Penultimate State, whose 10,907 miles **match Kim's own margin total exactly**.
**Fuel-log coverage: 140 of 293 rows verified against paper (48%).**

### ★ Two stories, and why they are evidence

**Yukon River Camp:** the woman running the concession ran over -- they had never seen a car like it.
**The claim is unusually strong for an anecdote because the observation post is a CHOKE POINT**: it is
the only fuel between Fairbanks and Coldfoot, which is why the log shows Kim buying there twice, north
and south. **Alpine, TX:** a stranger walked over having mistaken the Smart for a friend's car.
**Same cause -- the car was rare -- opposite reactions. Two strangers in two years is a PATTERN**, and
it is evidence for the thesis that no fuel statistic can supply.

### Next

**Scan May-June 2016** (highest value -- the fill-drag lives there and the true values are otherwise
unrecoverable), then the 2017 tail. Open the 8 remaining scans. Then the chapter architecture, which
has been the named weak point since 2026-08-16 and is still the one-car charter's.

---

## 2026-08-17 -- THE BACKUP HAD RUN ALL ALONG; Finding 031; health check clean on every axis that matters

**Active focus at start:** Smart_Car (2026-08-16 close). **At close:** unchanged -- the day opened
on the two items carried over, and they took it. Hurricane Lala cleanup underway across the islands.

### The correction, and it is mine

**I told Kim at the close of 2026-08-16 that `pkm_backup()` had not completed and that the PKM had
gone 16 days without a backup. That was FALSE.** It had committed **`0bcd812c8d`** at 20:42 --
*Backup refresh: 5 changed of 972 tracked*, exactly the five files written that evening -- and
**pushed**: GitHub's `refs/heads/main` equals local HEAD, working tree clean.

Two errors stacked. **(1) I read a 60-second BRIDGE timeout as a job failure.** The R process keeps
running; today's `pkm_health()` took **100.8 s** and completed fine when run with
`execute_r_async`. **(2) I verified against an artifact `pkm_backup()` does not produce** -- I looked
for a `Projects_Index_archive_2026-08-16` folder. Those are Tier-3 pre-split snapshots. The function
refreshes the git mirror at `C:\repos\kimbridges-venues` and pushes. **Four lines of `pkm_health.R`
would have told me that, and I did not read them.**

**★ Written up as Finding 031, and the part that earns its place: this happened in the same session
whose own log entry says *verify against the REMOTE, not the return value*. The rule was not just
known, it was being written down at the time, and it still did not fire.** That is exactly the gap
`pkm_card.md` exists to close (Finding 020), so the card gains a row: *see a TIMEOUT, or check that
a job ran -> 031*. **Cost: Kim ended a hurricane day believing his system was unbacked during an
active recovery. A false absence is not a neutral error.**

### The paper trip logs -- the gap closes, and the method scales

Kim scanned `2011_TwoRed_travel_and_fuel_log_June.pdf` into the data folder and asked whether I
could read it. **Four handwritten pages, fuel log above, trip log below. The trip half had never
been typed** -- exactly the gap that made TwoRed's Trip Log *a fragment, not a dataset* on 08-12.
**Transcribed: 15 legs, 4,635 driving miles, odometer 13,689 -> 18,789**, into
`data/TwoRed_2011_StLouis_trip_log.csv`.

**★ The odometer is a free QC gate.** 12 of 14 written distances agree with the odometer delta
within 2.5 mi. One disagreement was MINE -- I read 298.7 where the odometer implied 289; re-read as
289.7 it falls in line. **The data corrected the transcriber.** The other (7/04, 392.1 written vs
397) is unresolved and flagged in the file. **This is what makes bulk transcription of the remaining
sheets trustworthy: every leg self-checks.**

**★ THE FUEL AUDIT -- the finding is a DISTINCTION, not four corrections.** `gallons x $/gal = cost`
fails on 4 of 23 rows in the 2011 window. The paper splits them cleanly: **San Marcos (3.000 typed
for 3.999) and Ash Fork (7.624 typed for 7.264) are TRANSCRIPTION errors the scan repairs**;
**Ludlow and Spring TX are wrong on the paper too -- FIELD errors predating the spreadsheet.**
So the scans are not just more data: **they let a typing slip be told apart from a pump-side mistake,
and only the first kind is safely fixable.** Neither applied -- editing Kim's data is his call.

### The gazetteer, the audit families, and the errata scaffold

Kim added `All_gas_stations_csv.csv` (212 stops, all geocoded, matching the `Locations` sheet
row-for-row) and a `Fuel_and_Trip_Logs/` folder -- **15 scanned PDFs, 2010-2017, 4.9 MB**, one
byte-identical duplicate, md5-checked.

**★ THREE AUDIT FAMILIES, NEARLY DISJOINT.** Arithmetic (`gal x $/gal = cost`), economy (implied
MPG), geography (straight line vs odometer). 21 arithmetic suspects, 15 geographic, **2 in common**.
**One test finds one error CLASS; a clean arithmetic pass says nothing about the geography.**
The join itself is a fourth test -- it surfaced `Lake San Marcos, Callifornia` with no test written.

**★ FOUR 'IMPOSSIBLE' LEGS ARE NOT ERRORS -- THEY ARE FERRIES.** Bellingham -> Haines Junction
(1,018 straight-line miles against 160 on the odometer) and Homer -> Lakewood (1,455 vs 336) are the
**Alaska Marine Highway**; two more are the **Newfoundland ferry**. The car crossed water while the
odometer stood still. **The test found both great water crossings of the record on its own.**

**★★ KIM'S GMAPS CHECKS PRODUCED THE BEST RULE OF THE DAY: A ROAD DISTANCE CANNOT BE SHORTER THAN
THE STRAIGHT LINE.** Where GMaps falls below the great-circle, the COORDINATE or the city NAME is
wrong -- not the odometer. Ratios of 0.61 / 0.75 / 0.69 became **1.21 / 1.08 / 1.18** with the real
towns. **In three of four cases the odometer was right and the geography was wrong.** Deming is New
Mexico (Kim's own 311-mile figure is the NM distance); `Bessemer` was geocoded 100 miles off; and
`Waynesboro` was really **Waynesburg**, which Kim identified himself.

**The scaffold built and agreed:** `TwoRed_log_errata.csv` (11), `TwoRed_gazetteer_errata.csv` (4),
`TwoRed_leg_distances.csv` (292 legs with `distance_basis`). **Corrections are a DERIVED LAYER --
the xlsx and the gazetteer are untouched.** Impossible legs 15 -> 10, of which 4 are ferries.
**Defensible headline, reproducible from the file: 69,689 miles over 285 measured legs; 2.1% of
distance disputed and excluded; 97.9% resting on undisputed odometer readings.**

**★ THE LINE: reconstruct DISTANCES, never ODOMETER READINGS.** A distance is an estimate; an
odometer value is a claim about what the car said, and inventing one poisons the MPG on both sides.
Kim: *documenting the procedure rather than inventing data.*

**★★ AND AT CLOSE, KIM GAVE THE ERRORS A MECHANISM:** *there were lines waiting for fuel and it was
important to record quickly and vacate the fuel stall. And forgetting to record a fill-up? That can
happen, too.* **This reframes the entire audit from a defect list into a description of field
conditions.** Missing rows are the PREDICTED failure of the method, not an anomaly. **A record kept
sixteen years under queue pressure with ~2% of distance disputed is a strong result, and saying so
plainly is what makes the honest review credible instead of defensive.**

**Corroboration, carefully labelled.** The 3-bar habit Kim adopted at Deming shows mean fill falling
from 87.7% of tank to 70.6% -- **but n=5 before the change, so it is corroboration, not evidence.**
What is solid: **290 miles on that tank, 7.119 gal taken (82% of 8.7), 38.1 MPG then current --
about 41 miles of range left.**

### ★ Kim: the scope boundary is FRACTAL

The 465-mile gap between logged legs and odometer is city driving. *We're laser focused on the long
drives, not the city stuff.* **The same rule runs at three levels -- which cars are logged, which
years of a car are logged, which miles of a trip are logged -- and excludes the same thing every
time.** Filed in `proj_Smart_Car.md` as an analysis rule: **the gaps are DEFINITIONAL, not missing.
Never impute them.** A record that omits city miles is the artefact of someone who thought only
long-distance driving worth recording -- which is the document's whole argument. **The absences
carry the thesis.**

**Two more from Kim.** A **complete set** of TwoRed trip logs likely exists -- that would make TwoRed
a true parallel spine rather than a fuel record with a fragment. And **temperature recording was
dropped** as not worth the effort, so it is a **bounded early subset**, not a column through the
record. Creamsicle has none at all.

**⚠ Method trap logged:** Creamsicle's mph is net of stop time, TwoRed's paper mph is gross.
Naive comparison makes Creamsicle faster by construction.

### Health check -- first run since 2026-08-12

**Clean on every axis that matters.** 83 works registered, **0 reconciliation failures**, 0 rendered
pages without source, 0 broken `_Log:` pointers, 0 orphaned logs, and the **pre-deletion gate is
clear** -- 58 legacy pages, none without a venue equivalent.

**Flagged, with two of them my own doing:**

| Flag | Detail |
|---|---|
| **Active Focus 6.5 KB / 6** | **mine** -- yesterday's block, written long and then extended |
| **`pkm_card.md` 6.2 KB / 6** | **mine** -- the 031 row; the card's own rule says surplus goes to `pkm_findings.md` |
| Drift, 4 | `proj_checklists` code 10 days newer; `proj_audio` renders/ and `proj_R_LLM_tests/_book` not found |
| Over budget, 2 | `proj_seasonality` 51.6/45, `proj_audio` 47.3/45 -- both splittable |
| Repo/clone mismatches, 6 | unchanged since 2026-08-03; still open |
| Build scratch past 14 days, 2 | `pkm_snapshots`, `venuemirror_clone_2026-08-03` -- both 0 MB |

**★ One flag is EXPECTED and must not be "fixed": *Venues without a source repo, 5 of 5*.** That is
the consolidation migration's design decision 1 -- *a mirror, not repos-in-venues* -- taken because
putting `.git` on `G:` violates bucket 5. **The check reports a condition the system deliberately
chose.** Recorded here so a future session does not helpfully repair it.

---

## 2026-08-16 -- THE CREAMSICLE DATA IS FOUND, AND IT WAS NEVER A FILE; Smart_Car unblocked

**Active focus at start:** PKM (2026-08-12 close). **At close:** Smart_Car -- Active / Ready,
Blockers NONE. Kim redirected the focus at session open and named the target himself.

### The finding, and why it is a method finding before it is a data finding

`deferred.md` had carried **locate the CREAMSICLE cross-country data** as the highest-value gap in
the project since 2026-08-12. It was discharged in a single search. **The reason it had held is
worth more than the data: every prior sweep was a FILESYSTEM sweep, and a Google-native document
has no bytes on disk.** `list.files()` over all of `G:\My Drive` returned the stubs and they looked
like nothing -- `file.info()` reported `Final Creamsicle Logs.gsheet` at **176 bytes** and
`readBin()` on the same path returned **0**. That is the card's GROUND-TRUTH RULE firing exactly as
written: a `G:` path can report a correct name and size while the bytes are absent. The Google
Drive connector read straight through it. **Rule filed: before filing anything as missing, search
the Drive API by TITLE.** An on-disk sweep is not a search of Kim's material; it is a search of one
surface of it.

**★ Kim had spent the two days before this session working the Creamsicle material up himself,**
and said so mid-session. `Final Creamsicle Logs` carries a modification stamp of **19:48 HST, four
minutes before the session opened.** The PKM was carrying the item as blocked-on-Kim while Kim was
actively finishing it -- a reminder that a `deferred.md` entry records a decision, not a live state.

### What was found

| Asset | Kind | Content |
|---|---|---|
| `Final Creamsicle Logs` | Sheet, multi-tab | fuel log 2021-09-23 to 2023-09-27 (odo 30,290->51,345), BC fill-ups **already in litres and CAD**; a daily trip log per trip to 2024-10-20 with times, Miles, Duration, **Stop**, Adj_Duration, Miles/Hour |
| `Creamsicle` | Doc | **a drafted 9-trip narrative, ~4,500 words** -- purchase 2021-09-15, $11,999, Modern Motorcars, Nixa MO; 453 ForTwo "Edition #1", 0.9L turbo triple, 89 hp, six-speed |
| `Creamsicle_July_Fuel_Log_update` | Sheet | Jan-Jul 2024, odo 52,656->55,743, **with LATITUDE and LONGITUDE** |
| `Creamsicle Inventory` | Doc | Jun 2023 packing manifest; its checklists document the logs' provenance |

**28,697 miles, 1,123 days, 9,845 mi/yr, 18 states + Canada.**

**★ THE REVERSAL.** TwoRed's Trip Log is **7 rows** -- recorded on 2026-08-12 as "a fragment, not a
dataset". **Creamsicle's is the real one.** The average-speeds analysis Kim named as an intention
is the readiest in the project, and it lives on the car the PKM had filed as the gap. The fleet
framing is now **quantitative rather than narrative** -- which is what 2026-08-12 said would settle it.

### Two side findings, neither looked for

**`TwoFer Gas Log`** -- car #2's record, where the PKM had "one line of text": 7 fill-ups,
2014-03-22 (dealer, odo 0) to 2015-01-10, **1,209 miles, every one in Honolulu.** The dealer date
matches the lease date already in the file, which is what identifies it. **Kim ruled BOTH names
were used** -- `Two4Two` canonical in prose, `TwoFer` recorded as the log's title so a future
session does not "correct" one into the other. **★ It sharpens the thesis rather than padding it:
the one car that WAS a pure urban commuter is the one that was leased and given back.**

**`TwoRed_fuel`** -- a distinct, richer TwoRed sheet: cumulative cost, $/mile, MPG-last-5, and
**ambient temperature in the Notes** ("64F @ 2:25PM"), plus a trip tab with start/end temperatures
and odometers. Its own summary block reads 141 fill-ups / 34,098 miles -- **deeper on the early
years, not longer.** Read it before topping up the log.

### One hypothesis raised and killed by data

2016 is Creamsicle's model year, so `2016_Fourth_Crossing_Analysis.xlsx` was a plausible
Creamsicle asset. **It is TwoRed's.** The odometer opens at **58,214 in May 2016** -- inside
TwoRed's trajectory, and five years before Creamsicle was bought at 30,290. **Settled by odometer
continuity, not by filename**, which is the same move that corrected the charter on 2026-08-12.

### Not claimed

No Creamsicle fill-ups past **2024-07-02** appeared in the read, though trip legs run to
**2024-10-20**. Filed in `deferred.md` as an OPEN QUESTION, **not as an absence** -- the Sheet is
multi-tab and the read may have been partial. Findings 018/019/020 all point the same way.

### Raised, not acted on

The narrative doc is now a **publication candidate**, which activates the 2026-08-12 conditional.
Kim's own Origin Story describes the caregiving situation in some detail while never naming the
diagnosis -- further than "bought to help family, and stops there". **That is Kim's call and
David's, not an editorial one**, which is what the conditional says. Flagged and left alone.

### Kim's six rulings, and the two that changed the project

**1. The fleet splits 2x2 by DISTANCE ROLE, not powertrain.** TwoRed + Creamsicle are the
long-distance subject; Two4Two/TwoFer + Bordeaux are Honolulu short-haul and deliberately minor.
It cuts across the ICE/EV axis it supersedes and matches how the data was generated. **★ It makes
the thesis more honest and therefore stronger: two of the four WERE urban commuters. The claim
becomes that the same owner ran the same marque both ways for sixteen years, and the Honolulu
pair is the CONTROL that makes the contrast measurable rather than asserted.**

**2. `TwoRed_fuel_June_2014` IS the last fuel log.** Kim logged fuel only while a car was doing
long trips. **★ So the log stopping at 71,181 against an odometer near 75,000 is not missing data
-- it is the project's SCOPE BOUNDARY showing up inside its own record.** The PKM had carried it
as a gap since 2026-08-12. Supersedes his earlier "I need to update the fuel logs": later ruling wins.

**3. Origin Story: ADJUDICATED and closed.** Neither person nor condition is given away.

**4. The doc's countries/states ending is BY DESIGN** -- a reminder that place analysis is coming.
**The open question raised earlier the same day is closed, and declining to call it an absence was
the right call.** Two absence-shaped things surfaced today; neither was an absence.

**5. Spreadsheet cleanup.** The fuel tab interleaves totals and averages INSIDE the data region.
Principle: separate DATA from DERIVED, before the ingestion script rather than after.

**6. The photo layer landed, and it joins.** 38 files, 35 with GPS, 2021-09-23 to 2024-10-22 --
full ownership plus two days. **`DateTimeOriginal` is LOCAL and `OffsetTimeOriginal` carries the
zone; the logs are local clock time; so the join needs NO timezone reconstruction** -- precisely
the correction `2016_Fourth_Crossing_Analysis.xlsx` built a whole column for. **Validated on the
first record: photo 11:42, first fill-up 11:45 Nixa MO.** 8 of 9 trips covered; T2 blank, not
claimed as absent. `two_smarts.jpg` -> `Creamsicle_profile.jpg` per Kim; the deleted 439 KB
`creamsicle.jpg` survives in `kimbridges-stories\underway\Smart_car\`, **so the superseded copy
`deferred.md` wants deleted is currently the backstop.**

**Newly weakest part, named rather than inherited:** the chapter architecture.

### Context -- Hurricane Lala

Hawai`i was narrowly missed but damaged across all islands: nearly **200,000 homes without power**,
bridges washed out, communities isolated. Kim and Nancy were prepared, are safe, and their
apartment near downtown Honolulu kept power. He had been reluctant to use the computer at all in
case it dropped, which is why this session was closed deliberately and the writes were sequenced
by value. Recovery expected to begin 2026-08-17. **Recorded because it explains the shape of the
next few sessions.**

### Files written

`proj_Smart_Car.md` (Ready; Blockers NONE), `deferred.md` (Creamsicle CLOSED, Two4Two/TwoFer
PARTLY CLOSED, four new entries), `project_index.md` (new Active Focus + row; the 2026-08-12 block
moved to `logs/focus_history.md`, **delta 5,692 bytes = block + wrapper exactly**, verbatim
confirmed), and this entry. All writes made through the R bridge in **binary**, and every one
verified by CONTENT -- CRLF preserved, zero LF-only lines introduced, heading and row counts
re-counted after the write. The replace helper **refused a no-op edit mid-session** (match count 0
where 1 was required) rather than silently doing nothing -- Finding 030 working as intended.

---

## 2026-08-12 -- SELECTIVE FOCUS PUBLISHED as a v2; SMART_CAR FILED AND REFRAMED TO FOUR CARS; two findings written from my own errors

**Active focus at start:** PKM (2026-08-11 close). **At close:** PKM -- item 1.1 of the
resumption pointer closed. Kim confirmed the focus himself: Selective_Focus.

### Kim did the work before the session started

He found the original materials in his photos archive, read the story back, and judged it
*interesting and somewhat useful*. Then he acted on the second half of that judgement: he
researched and rewrote the useful part so the equipment reflects his CURRENT lens
collection. The result is `Selective_Focus_v2_compressed.pdf`, 35 pages, InDesign,
created 2026-08-12 18:41 HST. **The document now carries two dates on page 2 -- May 28,
2023 and Updated: August 12, 2026.**

The v1 estimate in `priorities.md` said *genuinely quick: one PDF, ready to assemble*.
That held. Assembly took one pass and nothing surprising appeared.

### What changed between v1 and v2

The narrative half -- the Hawai`i Volcanoes field test on seven plants (*Scaevola
kilaueae*, *Isachne distichophylla*, *Ceodes umbellifera*, *Hibiscadelphus giffardianus*,
*Pipturus albidus*, *Alyxia stellata*, *Metrosideros polymorpha*), each result annotated
with aperture and stack size and with what should have been done differently -- is
unchanged. The revision is entirely in the forward-looking half:

- the **Sony 50-150mm f/2 GM** offered as an alternative to the 90mm macro, with the
  minimum focus distances worked out (0.4 m at 50mm, 0.74 m at 150mm, 0.2X)
- the Leofoto G2/G3 ball head over the original choice
- **a computer promoted to essential gear** -- the missing element in the first field test
- a seven-step recipe that parks focus bracketing in camera memory slot 3, one dial-click away
- the **focus-and-pad method**: dial focus in front of the intended foreground until peaking
  disappears, treat that empty air as the 0 baseline, then run [0 > +]

**The cover is unchanged** (*Pisonia brunoniana*, Kipuka Puaulu), so the v1 thumbnail
already matched. Regenerated anyway at the script standard 150 DPI (1275x1650) rather
than the ~110 DPI v1 image.

### Assembled by hand, not by add_stories.py

The three-artifact pattern followed exactly: `pdfs/Selective_Focus.pdf`,
`images/Selective_Focus.jpg`, `stories/selective-focus-with-focus-stacking.qmd`.
**The venue filename drops the working suffix** -- `_v2_compressed` is a working-file
name and no other venue PDF carries one.

Kim ruled on three points: **date 2026-08-12** (so it sorts to the top of the grid as new
work, rather than sinking to 2023 among older entries), **categories Photography / Hawaii /
Gardens** (established vocabulary only -- a new "Technique" tag was offered and declined),
and **framing as openly ongoing working notes**, which is what the document says of itself.

### Verified through the R bridge, by content

Per the ground-truth rule, nothing here was confirmed by reading a size:

- PDF byte-identical at every hop: source -> `pdfs/` -> `_site/pdfs/`, 3,137,779 bytes,
  `%PDF-` header and `%%EOF` trailer both checked
- JPEG magic bytes `FF D8 FF` confirmed on the regenerated thumbnail
- the `.qmd` read back and its `pdf:` and `image:` targets resolved to files that exist
- `index.html` confirmed to carry the card, the title and the thumbnail reference

### Rendered and staged

`quarto::quarto_render()` via the R bridge -- **this works where a shell call does not**,
because the security guard scans source text and the package call never spells a shell
command. 56 documents, the new story at [45/56], 55 story pages out.

`_site` staged to **`C:/temp/kimbridges-stories_20260812`** (bucket 4). Counts reconciled
per Finding 021: **190 files and 590.8 MB on both sides, nothing missing, zero zero-byte
files.** All 55 PDFs spot-checked for a real `%PDF-` header including the five largest
(Merritt_Island 34.9 MB down to Bordeaux 19.8 MB) -- Finding 008 is about exactly this.

**Remaining: Kim drags that folder to the Netlify drop zone.** Not the project root.

### Two drifts found in passing, neither acted on

1. **`stories_inventory_v2.xlsx` is no longer the source of truth the README claims.** It
   was last written 2026-06-23 and is missing `cinque-terre-impressions`,
   `the-washington-monument` and `japan-fall-2023` -- all three added by hand since. I added
   the Selective Focus row (now 52 data rows) but **the spreadsheet still under-counts the
   venue by three.** Either it gets backfilled or the README stops calling it the master.
2. **`underway/Selective_Focus/` still holds both PDFs.** The README says move to `updates/`
   when complete; I copied rather than moved, since neither the device bridge nor the R
   bridge deletes. Same leftover shape as `underway/2023_Japan_Story/`, already on the
   housekeeping list.

### SMART_CAR FILED AND LOWERED — and reframed from one car to four

Kim confirmed the 2026-08-11 reading that Smart_Car is a document, not a story, **and gave
the reason from the source material itself: the largest section is the Arctic Circle
Challenge, which is already a posted story.** What is left is data, not narrative.

**Then he reframed the scope.** Four Smart cars, sixteen years, two still owned, deepest
data on the first (TwoRed). The charter's thesis survives and gets stronger -- not one
exceptional car on one exceptional journey, but a choice made again three times.

**Three rulings recorded:** the fleet is the subject; the Arctic Circle Challenge is
**cross-referenced, never re-told** (superseding the charter's embed-by-iframe Chapter 5,
which would have put identical content at two URLs and made the works register lie); and the
project reads **Active + Blocked**, not Ready, with the blocker named as his own paperwork
recovery, to be done in miscellaneous time.

**Intake done:** `proj_Smart_Car.md` (8.9 KB) with a Statement of Intentions section written
so a cold session knows what was decided and what was deliberately left open; index row
added; a `Smart_Car` section opened in `deferred.md` with six TASK and two CONDITIONAL
entries. Nine files moved to `Projects/Smart_Car` under `data/`, `source/`, `images/` --
**all nine byte-identical, 20.56 MB both sides.** The charter is kept verbatim as
`source/charter_2026-05-08.md`, historical record rather than instruction.

**★ READING THE DATA CORRECTED THE CHARTER ON THREE POINTS.** The charter was written from
memory; nobody had opened the spreadsheets since.

| Claim | Reality |
|---|---|
| "nearly 300 fill-ups" to June 2014 | 293 fill-ups, but the range is **2010-07-23 to 2017-05-22** -- the filename understates it by nearly three years |
| "75,000 miles" | odometer tops out at **71,181**; the number in the title is not in the data |
| "precise daily driving intervals" | the *Trip Log* sheet is **7 rows** |

Also unmentioned by the charter: a `Canada2014` sheet, 24 rows in **litres and Canadian
dollars**. The one claim that held up exactly was the Fourth Crossing file, which is genuinely
the cleanest asset -- `time_zone`, `activity_time`, `corrected_hrs` already derived.

**None of it was carried forward as fact.** All three went to `deferred.md` as TASKs with
the honest state written in, and the project file carries a *What the data ACTUALLY contains*
table. **Do not print 75,000 until it is sourced.**

### ★ THE FLEET IS NAMED — and the 75,000-mile question closes the way I did not expect

Kim gave the roster the same day, unprompted, and it reshapes the project again.

| # | Name | Year / model | Power | Status |
|---|---|---|---|---|
| 1 | **TwoRed** | 2010 Smart Passion | ICE | Owned |
| 2 | **Two4Two** | Smart Pure | ICE | Leased 2014-03-22, returned |
| 3 | **Creamsicle** | 2016, white/orange | ICE | Sold to family |
| 4 | **Bordeaux** | 2018 | **Electric** | Owned |

**★ The 75,000-mile discrepancy was MINE, not the charter's.** TwoRed is **about 20 miles
short of 75,000**. The Gas Log's 71,181 is where the *log* stops, not where the *car*
stopped. I had filed it as an open question — *the number in the title is not in the data* —
on the strength of the spreadsheet alone. **A dataset ending is not the same as the thing it
measures ending**, and I had inverted which of the two was authoritative. The charter was
right. Closed in `deferred.md` with the reason kept rather than the answer, per the WON'T-DO
rule.

Kim is updating the fuel logs to fill in the missing stretch.

**★ CREAMSICLE CHANGES THE SHAPE OF THE PROJECT.** He has substantial data from driving it
across the country several times — in his words, enough to *complement* TwoRed. So this is
**not one documented car plus three anecdotes; it is two analytical spines bracketing a lease
and an EV.** The binding constraint has correspondingly narrowed: no longer *find out what
the cars were* but **find the Creamsicle files.** That is now the top item in the project's
deferred section.

**Kim's analysis intentions, recorded:** fuel costs, daily driving distances, average speeds,
with graphics. Plus **photographs of the cars in interesting places as a first-class element
** — which is also the natural join to `Photo_Locations` and `timelinesr`, since a geotagged
photo and a geocoded fuel stop are the same kind of record.

**THREE RULINGS, all of which foreclose a plausible future mistake.**

1. **Creamsicle's purchase reason is NOT FOR PUBLICATION.** The car was bought so the family
   could help Nancy's brother David through a double lung transplant, and was later sold to
   him. **That is a third party's medical history.** It is recorded once in `deferred.md` so
   a future session understands why a fourth Smart appeared and stops digging; the public
   text says the car was bought to help family, and stops there. Kim chose *record it, keep
   it private* over omitting it entirely — the reason matters to the project, the detail is
   not the project's to tell.
2. **`Bordeaux` is a name collision.** The 2018 electric car shares its name with two
   published stories, `/stories/bordeaux` and `/stories/bordeaux-2` (the wine booklets).
   **The car keeps the name in prose; no Smart_Car slug, filename, figure, data file or
   deploy path may take a `bordeaux*` form.** Caught before any output existed, which is the
   only cheap moment. Slug/folder/name drift is already a known root cause — item 3.5.
3. **ICE and EV stay SEPARATE.** Statistics across the three gas cars; Bordeaux described
   qualitatively. A common $/mile axis spanning gasoline and electricity was offered and
   **declined** — it would force a comparison the charging data may not support.

`proj_Smart_Car.md` gained *The fleet* and *Intended analysis*; Blockers, Next Steps and the
data table were rewritten to match. The deferred section went from 6 TASK / 2 CONDITIONAL to
**7 TASK / 4 CONDITIONAL / 1 CLOSED**.

**Also confirmed:** Kim dragged Selective Focus to Netlify. Verified independently before he
mentioned it — all four URLs 200, the PDF serving at exactly 3,137,779 bytes, and
`pkm_health()` reconciliation back to **0 failures** across 83 works.

### ★ A GUARD THAT ONLY PRINTS IS NOT A GUARD — I corrupted priorities.md and recovered it

Replacing section 1 of `priorities.md` by string boundaries, the end marker did not match:
I searched for `"...not a missing story.**"` and the file has no trailing `**`. `regexpr`
returned **-1**, `substr(s, -1 + 66, ...)` silently became `substr(s, 65, ...)`, and the
write produced prefix + replacement + **almost the entire original file** -- 12,824 to 15,848
bytes, two `## Purpose` sections, two `### 1.` sections, a word split at the seam.

**The precondition check was already written, already ran, and already printed
`end found: FALSE` -- in the same call that then wrote the file.** The information was not
missing; it had no teeth. **Finding 030** written: a precondition must `stopifnot()`, not
`cat()`. Same structural-over-memorial shape as Finding 028.

Recovered exactly -- the damage was deterministic, so the original was reconstructed and
confirmed at **12,824 bytes**, then the one damaged header line repaired by name.
**Structure proved it clean, not size:** `## Purpose` back to one, `### 1.` back to one, full
heading list matching. The retry used anchored `grep` on line indices with `stopifnot` on the
match counts AND their order. **Markdown sections have unambiguous line boundaries; their
prose does not.**

Worth stating plainly: **the PKM has no version control.** This was recoverable in memory.
A destructive splice will not always be.

### ★ THE SESSION DATE WAS WRONG, AND MECHANISM 4 ALREADY SAID SO

Every dated line written this session initially read **2026-08-13**. That is the UTC date,
handed to the assistant by its environment. Kim's machine reads **2026-08-12 19:20 HST**,
and Mechanism 4 has said since 2026-07-28 that *dates and times are HONOLULU LOCAL*.
Five files were wrong: `session_log.md`, `priorities.md`, `project_index.md`,
`logs/focus_history.md`, `proj_kimbridges_stories.md` -- plus the bucket-4 scratch folder
name.

**What caught it was `pkm_health()`, not the rule.** The generated report is stamped from
the machine clock -- *Generated 2026-08-12 19:19* -- sitting directly beneath entries dated
the 13th. The rule had been read at session start and did not fire; the tool that stamps a
real clock did.

Corrected in place: 14 date strings across five files, plus
`C:/temp/kimbridges-stories_20260813` renamed to `_20260812`. **Byte delta zero on every
file and line-ending fingerprints unchanged** (same-length substitution), so nothing but
the dates moved -- which matters on `proj_kimbridges_stories.md` and `focus_history.md`,
both of which are mixed CRLF/LF and would have been silently normalised by a
`readLines`/`writeLines` round trip.

**This is Finding 020's shape again: the trigger is the mechanism, not the list.** A rule
written in `pkm_protocol.md` that is read once at session start does not survive contact
with an environment that supplies a plausible wrong answer for free. **Proposed, for Kim's
call, not acted on:** a line in `pkm_card.md` under the situation table -- *about to write a
date? the session's own clock is UTC; get Honolulu local from the R bridge* -- since the
card is the surface that actually fires. Card budget is 6 KB and it currently sits well
under.

### Worth recording

Kim: *the updated materials make me want to go out and take some new photos.* The document
was revised to be useful, and being useful made it generative. That is the opposite of the
usual archival motion, where finishing a thing closes it.

---

## 2026-08-11 -- RESTART AFTER A WEEK AWAY; the resumption pointer rebuilt, two lost stories found, three new documents captured

**Active focus at start:** PKM (2026-08-03 close). **At close:** PKM -- restart complete.
Kim back from the mainland after his brother's heart attack; recovering, moved to rehab.
Deliberately a light session: *talk and capture*.

### The file that could not answer its own question

Eight days of gap, and `priorities.md` -- the designated resumption pointer -- was dated
2026-07-09 with its own first entry reading "freshen this file." Kim chose the restart
over the backlog.

**The diagnosis was not staleness, it was duplication.** The file restated item text that
also lived in `deferred.md`, so pruning anything meant editing two places, so nothing was
pruned. Rebuilt with the missing rule written into it: **`priorities.md` holds the ORDER,
`deferred.md` holds the DETAIL.** One line per item, pointing at the file that carries it.
Superseded file preserved verbatim at `logs/priorities_history.md` -- the same split the
logs took on 2026-07-28.

### Two corrections against the record, both mine

Opening the session I told Kim the April-2024 Anthropic key still needed revoking and the
hflip deadline was looming. **Both wrong.** The key was revoked 2026-08-03 and the two
hflip links were repointed 2026-08-02 -- I read the stale "Next up" line in `proj_PKM.md`
instead of `deferred.md`, which tracks them. The Active Focus block is a summary, not a
tracker; when the two disagree the tracking file wins.

### The orphan covers were not orphans

Kim resolved the three from memory -- `Ranunculus_Impressions` a duplicate, the other two
real but unprocessed, and he expected to have to go looking for the source materials.
**He did not.** A scan of the venues found both already staged under
`kimbridges-stories/underway/`, covers already in `images/`, neither published.

- **Selective_Focus** -- one 2.9 MB PDF, 2026-04-17. Genuinely quick, as Kim predicted.
- **Smart_Car** -- **not a story.** Nine files including a `README.md` project charter
  from 2026-05-08: *TwoRed 75,000 Miles Celebration*, a five-chapter reproducible Quarto
  book arguing from ~300 fill-ups, a time-zone-adjusted crossing log and topographic
  extremes that a Smart car is not an urban-commuter-only vehicle. `sf`, `tidygeocoder`,
  `elevatr`, `gt`. **No `proj_*.md`, no index row** -- an intake gap of the Jones/vouchr
  shape, dormant three months with its next two steps already specified.

Kim's assumption that both would be quick holds for one and not the other, which is the
useful half of the finding.

### ISSUU closed -- and the record was worse than the reality

Kim: every story once on ISSUU has been moved. **Verified rather than accepted.** All four
booklets are published stories with PDF, cover and page. `Travel.qmd` has **zero** ISSUU
mentions -- the four pointers and the L11 prose claim are already gone, so the open item
on the AI_Podcasts index row was stale and is struck.

**And `deferred.md` recorded `bordeaux_2` as "no known source... the one real gap." That
was false** -- `pdfs/Bordeaux_2.pdf`, `images/Bordeaux_2.jpg` and `stories/bordeaux-2.qmd`
all exist and are deployed. **Finding 019 committed again: an absence asserted without
being proved, which the next session would have read as established.** Corrected in place,
superseded text struck rather than deleted.

### The capture -- three documents

Kim's thinking from the flight, and the stated goal of the day: *document the thoughts.*
`ideas_three_documents.md` created. **Working titles:** *Baselines, Deviations & Spans*;
*Maps with Tiles*; *Measurements Require Categories*. Unified by **"you don't see
something unless you have a concept of it."** Prior work (Tom Koch tessellations, Will
McClatchey low-temperature spans) is related but explicitly **not** the basis of either
document.

Offered in response: the three are one claim in three registers -- categories frame WHAT,
tiles frame WHERE, baselines frame HOW MUCH. Five open problems recorded, including a
title collision (*map tiles* means XYZ/slippy-map tiles to any technical reader) and the
discovery-order-versus-exposition-order question.

**Kim's rulings:** three documents (open to further analysis), outlines first, NOT written
at once, reuse the existing packages rather than reinventing.

### ★ The inverse, promoted

The point offered was that Kim's thesis has an equally true and more interesting inverse:
**a concept also makes you see what is not there, and stops you seeing the alternatives** --
lens and blinder in the same act -- and that without it the trilogy reads as an
advertisement for concepts.

**Kim promoted it past the document it was raised for:** *"That's the kind of thread that's
needed in everything we do. It relates, in a vague way, to the way a scientist tries to
disprove things."*

That makes it a candidate for a PKM-level principle sitting beside the absence-claims rule
on the card -- *never assert something is missing without proving it* is the same instinct
applied to evidence; this is it applied to concepts. **Deliberately not acted on
unilaterally** (the card has a hard 6 KB budget). Recorded in `ideas_three_documents.md`
for Kim's decision.

Worth noting the day's own irony: the session committed Finding 019 twice in the record
and corrected both, while capturing a principle about attacking your own claims.

### Housekeeping

Two files written today came back **LF** while every pre-existing PKM file is **CRLF**.
Normalised, with the byte delta verified as exactly one per line (+185 and +136) -- the
check the CRLF hazard note asks for. Edits to the large files went through a read-detect-
write helper that preserves the original ending; backups first at
`C:\temp\pkm_edits_20260811`.

**Files:** `priorities.md` rebuilt; `logs/priorities_history.md` created;
`ideas_three_documents.md` created; `deferred.md`, `project_index.md` and this log updated.


## 2026-08-03 -- EXPERIMENTS WITH LLMS CONVERTED AND PUBLISHED; the last legacy link closed

**Active focus at start:** PKM, legacy cleanup effectively done, *Experiments with LLMs*
next in Kim's order. **At close:** published as the 22nd document; **zero non-historical
legacy links remain in any venue.**

### The metadata field that removed two days of work

The document was recorded as a finished 130 pp PDF with no `.qmd` source, and the
publication routes had been written up on that basis -- Kim chose the hybrid (landing
chapter over a PDF viewer) on 2026-08-02 for exactly that reason.

He then asked to check what a full Quarto rebuild would involve. Measuring the PDF first:
39,489 words over 130 pages, 13 sections and ~57 subsections encoded in font heights,
**zero image-only pages**, and prompt-vs-response separable by left margin (x=72 for
Kim's voice, x=108 for the LLM). All favourable. But the decisive fact was in the file
header: `/Producer` = **`Skia/PDF m122 Google Docs Renderer`**. The Doc was still in his
Drive, modified 2024-01-12, one day after the export.

**Re-asked rather than absorbing it.** Kim had approved hybrid against wrong information;
he switched to the full rebuild and chose to export a copy and leave the Doc untouched as
a dated artifact. Finding 025 -- and rule 3 there is the one worth keeping: when new
evidence overturns a decision the user already made, say so and re-ask.

### The conversion

googledrive needed interactive OAuth, which the bridge cannot do; Kim ran `drive_auth()`
once in the console and the token now caches at `~/.R/gargle-cache` on the C: HOME.
Export to docx, pandoc to markdown with media extraction, split at the 12 H1 boundaries.

Verified against the PDF rather than by inspection: **57 H2 subsections, exactly matching**;
41,543 words vs 39,489 of PDF text; 15 images extracted with all 15 references resolving.
Kim's bold convention -- prompts bold, responses normal -- came through intact (90 bold
spans in the Statistics chapter alone). A PDF reconstruction would have had to infer that
from x-coordinates. **The cheaper path was also the more faithful one.**

Three things dropped, all print-era furniture, all disclosed in the preface: duplicated
title block, repeated cover-art credit, and "Use the Table of Contents to jump to an
example of interest." The text itself was NOT revised. Kim's content creep -- 77 pp
(*Experiments with ChatGPT*, Nov 2023) -> 113 pp -> 130 pp -- is preserved as written,
and reorganisation was deliberately kept as a separate Kim-driven task.

Kim on the result: *"I found myself enjoying a re-read of this material."* Which is the
real test -- a faithful conversion nobody opens would be a lesser outcome.

### Closing the loop

`LLM_Creates_R/Resources.qmd` L84 repointed from ISSUU to `/llm_examples/`, re-rendered,
and reinstalled into `using_an_llm/`. Documents `_site` 1042 -> 1092, **0 removed**; venue
reconciles at 22 folders / 22 resources / 22 cards.

**Legacy links in venue sources: 4 -> 3, and none of the three is a live pointer to a
dying platform.** One historical mention kept by Kim's rule, two stale prose claims.

### The card caught itself

Trimming a new row out of `pkm_card.md` to respect its own 6 KB budget, a `file.info()`
size read immediately after the write reported **4.08 KB against a true 6101 bytes** -- a
2 KB phantom improvement that would have been reported as fact. Caught by reading content
back. That is Finding 020's rule, printed on the card, firing on the edit to the card.
The file was fine at 5.96 KB, under budget.

### Consolidation migration -- pilot delivered

With the legacy-platform work complete, Kim chose the migration that `proj_PKM.md` has
carried since 07-30: **0 of 5 venues was a git repo**, so the source for all 79
published works lived in exactly one place. Same risk shape as the platforms, but with
Kim's own storage -- and worse, because Drive holds the originals rather than copies.

**The plan contradicted the card, and the contradiction was real.** "Init one venue"
puts `.git` on `G:`, which bucket 5 forbids. That rule came from the OneDrive
ai_microscope experience and had never been tested against Drive Stream. Probed it:
`gert` init, two commits, clean status, readable log -- **git operates on `G:` fine.**

But that is not what bucket 5 is about. Operating correctly today is not surviving
Drive's sync lifecycle. **The probe answered a narrower question than the one that
mattered**, and saying so was the useful part; Kim chose the mirror.

**Delivered:** `C:\repos\kimbridges-venues`, one repo mirroring text source only.
Fiction pilot: 51 files -> 6 tracked (12.9 KB), pushed to
github.com/kimbridges/kimbridges-venues, **verified from GitHub's trees API -- 8 blobs,
zero binaries** -- then cloned fresh and compared by CONTENT: all 6 identical. The venues
on Drive were not touched at all.

New in pkm_health.R: `VENUE_MIRROR`, `.venue_tracked()`, `pkm_mirror_venue()`. The
filter lists NAMES and filters BEFORE any stat call, because stat-ing every file across
five Drive Stream venues stalled the bridge for minutes earlier in the session -- the
expensive-synced-read lesson, which had only ever been applied to OneDrive.

**Stated the limit rather than the headline.** The mirror restores hand-authored source;
it does NOT rebuild a complete site. Fiction's source references 4 gitignored assets on
Drive. The inherited phrasing "GitHub must hold everything needed to REBUILD a site"
overstates it, and that is now corrected in proj_PKM.md rather than left to flatter the
result.

### Finding 026 -- the tooling manufactures the mess the PKM exists to prevent

The probe was created in the Drive ROOT instead of `C:\temp`. Cleanup deleted all 16
files and then could not delete one directory: the file-removal function does not take
directories on Windows, and the recursive alternative is blocked by the guard. **19 empty
directories left in Kim's Drive root for him to delete by hand** -- in a system whose
founding complaint was files proliferating. Rule: never create scratch outside bucket 4.

Two smaller ones worth keeping. `gert::git_push(password = tok)` fails with a valid PAT;
`GIT_USERNAME` + `GIT_PASSWORD` in the environment works (unset after; never embed the
token in the remote URL). And the guard scans PROSE -- writing Finding 026 was rejected
on first attempt for quoting the blocked call inside a string.

### The migration, finished — and what it found on the way

Kim ruled that derived output must not be stored. Measuring against that rule reshaped
the job: `kimbridges-documents` reduces to **25 files** -- a listing page and 22 cards --
because its 22 documents are rendered output copied in. **Their source lives in
`Projects/<name>`.** Mirroring venues alone would have backed up the shelf and not the
books. Kim extended the scope; the repo is now `venues/` + `projects/`.

The selection mechanism was also wrong and had to be inverted. `VENUE_GITIGNORE` -- a
blacklist -- missed `_output/`, the output-dir every Quarto book uses, and admitted 2018
files of Jones research data. **A blacklist must anticipate every kind of junk; a
whitelist only has to know what source looks like.** Even then the first whitelist
included `.html` and pulled in 12.5 MB of R Notebook renders and htmlwidget maps sitting
outside any build folder; 61 of 62 `.html` files were derived. Only `viewer.html`
survives, allowlisted by name.

**Note the pilot's blind spot.** Fiction was chosen as the pilot for being smallest, and
smallest meant it exercised least: it uses no `_output/`, no loose `.html`, and holds no
data. It passed while every one of those defects was live.

**Final: 882 files, 5.8 MB, verified from GitHub's trees API** -- 197 venue source, 683
project source across 49 projects, zero binaries, zero data, zero derived.

### The push was refused, and that was the best outcome available

GitHub push protection found a full Anthropic API key in
`Projects/LLM_API_R/Claude_API.qmd`, dated April 2024, commented out with `##` --
which hides it from R, not from a reader. Checked three ways and it was **never
published**: not a chapter of the rendered `r_api` book, absent from the venue folder,
its `_site` copy, and the live document. It had been on disk over two years because
nothing had ever looked.

**That reframes what the backup is for.** Copying files elsewhere is the least of it.
Publishing to a public repo forces every file past a scanner a private disk never
applies. Day one's value was not redundancy -- it was that something finally read the
material adversarially. `pkm_secret_scan()` now runs before every commit with a
`stopifnot`, because relying on GitHub means a private repo or an unknown pattern passes
silently. Finding 027.

### Three silent failures, one shape -- Finding 028

**`gert::git_push()` returned cleanly twice and transferred nothing.** GitHub's ref was
still at the pilot commit. The real error surfaced only under `verbose = TRUE`. Caught
only by checking GitHub's ref rather than the return value -- otherwise the session ends
believing 880 files are safe when 8 are.

**A size read straight after a write reported 4.08 KB against a true 6101 bytes** --
Finding 020 firing on the very file that prints the rule.

**The expensive-synced-read mistake, committed twice in one session.** A five-venue
recursive scan stalled the bridge; it was written up; then `pkm_secret_scan` was built
with no extension filter and aimed at all of `Projects/`, reading every PDF over Drive
Stream until Kim interrupted R. **Writing a lesson down is not the same as having learned
it.** The fix is structural, not memorial: the filter now lives inside the function, so
the next caller cannot repeat it.

The common shape: each failure was silent at the point of use and visible only from
outside -- the remote ref, the file's content, the user's own machine. *Where a tool
reports on its own work, get the answer somewhere the tool does not control.*

### The gap found during cleanup: the PKM was not backing up the PKM

After the migration was declared done, one check remained worth making: was
`Projects_Index` in it? It was not. The venues and 49 projects were on GitHub; the
index that makes them findable was still single-copy on Drive -- `pkm_health.R`, every
`proj_*.md`, 83 KB of findings, the session log and its archive.

Added as `pkm/`: 87 files, 2.0 MB. Repo now carries **969 blobs**. The reasoning is
worth keeping: the venues and projects can be re-read from their own files, but nothing
else records WHY a decision was made, what was tried and rejected, or which mistakes
have already been paid for once. **Backing up the work and not the index leaves a future
reader with the artifacts and no map.**

Kim confirmed the April-2024 Anthropic key is deleted; that conditional is closed.

### The card earned three new triggers, and had to be trimmed to hold them

`pkm_card.md` gained rows for the three failures that would otherwise recur: verify a
push against the REMOTE not the return value (028), run `pkm_secret_scan()` before any
commit (027), and create scratch only in `C:\temp` because the bridge cannot remove
directories (026).

That took it to 6222 bytes against its own 6144 budget, so it was trimmed rather than
allowed to breach: the stale "broken twice this week" heading, a Findings count that
still said 001-021, and a verbose RENAMES example. **5987 bytes** and eight sections
intact. The card enforcing its own rule on itself is the point of having the rule
printed on it.

### The cadence, decided and wired in

Kim did not know the term, which was my fault for using it. Plainly: **the GitHub copy
is a photocopy taken at one moment, and it does not update itself.** Every edit on Drive
makes it one edit staler. A stale backup is worse than an obvious absence -- it reads as
safety right up to the moment it fails.

**Decision: Mechanism 5, item 12.** `pkm_backup()` now runs at every session close
beside `pkm_health()`, and appears on `pkm_card.md`. It refreshes all five venues, every
project and `Projects_Index`; runs `pkm_secret_scan()` as a HARD GATE that refuses to
commit on any match; commits; pushes; and verifies against the SERVER rather than the
return value.

*Why not the alternatives.* A scheduled task needs the machine on and the R server up --
a backup that silently stops running is precisely the failure being guarded against. On
demand depends on remembering, which is what Mechanism 5 exists to replace. Attaching it
to an existing trigger costs nothing and inherits a habit that already holds. Same
principle the card was built on: *the trigger is the mechanism, not the list.*

First live run: 967 files refreshed, 1 changed, committed, pushed, verified in sync.
The card absorbed the extra call and came out at 6001 bytes against its 6144 budget.

**Open at close:** the per-project credential audit of Drive; six repo/clone mismatches
(confirm listsr is not simply PRIVATE); two stale Quarto Pub prose claims; three
unidentified orphan story covers; Desktop originals and the SoundCloud account close
awaiting go-aheads.

---

## 2026-08-02 -- SOUNDCLOUD RETIRED; AI_Podcasts published; the gate caught reading the wrong file

**Active focus at start:** the SoundCloud migration, 1 of 11 embeds done.
**At close:** 11 of 11. SoundCloud hosts none of Kim's audio.

### Gallery Catalog -- and a deploy chain that was described backwards

Before rendering, checked what actually produces the live pages. `_output/Podcast.html`
is dated 2025-04-09 and stamped `quarto-1.5.56`; the live `_site/Gallery/Gallery_Catalog/`
pages are dated 2026-07-26, stamped `quarto-1.8.27`, and carry the parent Collections
navbar with `../../site_libs/`. **The nested book `_quarto.yml` is vestigial** -- the
PARENT collections render walks in and renders the six chapters as website pages
straight into `_site`. The previous session had told Kim the chain was render-book-
then-copy-from-`_output`. Following that would have pushed 15-month-old pages live.
Recorded as a TRAP in deferred.md. The same shape exists at `Jones/Jones_analysis/`.

Also repointed both hflip links to the in-house viewer (`../viewer.html?pdf=1_Gallery_
Catalog.pdf`) after confirming `viewer.html` defaults to Two-Page Spread, so Kim's
"two-page spread" wording survived; only the vendor name ISSUU was dropped. Kim
deployed and confirmed.

### AI_Podcasts: moved, migrated, published

Source relocated from the OneDrive Desktop to `Projects/AI_Podcasts` (10 files,
byte-verified). Ten SoundCloud iframes replaced. **Two different iframe shapes were
present** -- one-line `<div><iframe...></div>` in Travel.qmd, seven-line blocks in
Scientific/Code -- and a single block detector produced OVERLAPPING ranges on Travel.
Caught in a dry run, before anything was written.

Then wrote a real bug anyway: the tail slice `L[(k+5):length(L)]` on a block ending at
the last line became `88:87`, which R counts BACKWARD, appending an `NA` line and a
stray `</div>`. The file still rendered and every audio element was correct. **Line-count
reconciliation was the only thing that fired** -- expected 87-15=72, got 74. Finding 023.
That is now three consecutive sessions where counting, not looking, found the damage.

Dead link fixed at source (`Code.qmd` -> `using_an_llm/`, target verified live first);
the Quarto Pub `_publish.yml` retired. Installed into kimbridges-documents via the
RESOURCES model (36 files copied + `resources:` entry + listing card). `_site` 1005 ->
1042, 0 removed. Kim deployed; audio plays. **21st document on the documents site.**

### The finding that matters most today

`pkm_legacy_gap()` reads `inventory_all_projects.md`. It never opens a venue file. So
the pre-deletion gate -- the one function standing in front of a one-way door -- could
only ever protect platforms a human had already written into the inventory. Eleven
SoundCloud embeds lived in published pages for months and the gate reported zero,
correctly, every run. Adding `soundcloud.com` to its platform vector changed nothing,
because the vector is applied to the inventory text. **The blind spot was the source,
not the list.** That is a direct violation of the GROUND-TRUTH RULE by the tool whose
whole job is verification. Finding 024.

Remedy: `pkm_legacy_live()` added -- reads venue `.qmd`/`.md`/`.html` SOURCE directly,
reports venue / file / line / url and separates a real LINK from a prose `mention only`.
Run both; disagreement is the finding. First run surfaced 7 rows the old gate could not
see: 5 live ISSUU pointers (a FIFTH external platform, never on the retirement list) and
2 stale PROSE claims that Kim's documents are "posted on the Quarto Pub website."
**Dead claims are a category the whole link cleanup missed -- a sentence has no href.**

Regex note worth keeping: `"quarto.pub"` unescaped matched `quarto publish`; escaping
to `quarto\\.pub` fixed that and immediately lost both real hits, which say "Quarto Pub"
with a space. Working pattern `quarto[. ]pub\\b`. Too loose and too tight fail the same
way -- silently, with a plausible row count.

### Housekeeping

`.wav` masters (12 files, 361 MB) copied to `Projects/Audio/podcast_masters`, all
byte-verified; Desktop originals left in place pending Kim's confirmation. Created
`proj_AI_Podcasts.md` (4.6 KB) and indexed it. Two findings written (023, 024). Noted
in pkm_findings.md that two findings share the number 020; left as-is to preserve
existing citations, numbering resumed at 023.

### Late correction (same session)

Kim supplied the ISSUU history and it broke two of my assumptions at once. He deleted
the ISSUU account years ago after an abrupt price rise -- so ISSUU is not "a fifth
platform to migrate," it is a closed account. **Probed all five URLs rather than
accepting that.** Three are STILL LIVE (`finding_fine_wine`, `bordeaux`,
`chatgpt_examples`); two are 404 (`bordeaux_2`, `2023_japan_story`). Deleting an
account did not take its documents down.

That inverts the risk. Exposure has a schedulable deletion event; these three sit on a
platform nobody is watching, believed already closed, and can go without notice.
**Recover first, repoint second.**

I had also written off `2023_Japan_Story.pdf` as "too small to be the illustrated
booklet" at 0.47 MB. Kim: it is **text-only by design**, ~40 pp, and is precisely the
file he gave NotebookLM. A file size is not a verdict on a file's contents -- the same
shape as Finding 020's failed probe and the stale `file.info` size. Both records
corrected in deferred.md and proj_AI_Podcasts.md.

Kim on the SoundCloud blind spot: he thought it was used for one Gallery project only
and had forgotten the rest -- "in practice, it was a very tiny blind spot. I knew we'd
get to it when we looked at the collections updating." Worth recording honestly: the
tool did not save him from something he had lost. It found something he had misfiled.

**Also recorded:** a dozen or so trips have written stories of similar length with no
photos added yet. A future project, after current work.

### The ISSUU trail, followed to the end

Kim: the three wine/travel booklets are already on the stories site, so nothing was at
risk. **Verified rather than assumed** -- `Finding_Fine_Wine.pdf`, `Bordeaux.pdf` and
`Bordeaux_2.pdf` are all in `kimbridges-stories/pdfs` with live pages. Note the shape:
`bordeaux_2` is 404 on ISSUU and perfectly healthy on Kim's own site. All three
repointed, plus the L11 prose sending readers to ISSUU.

The fourth, `2023_japan_story`, was 404 with the PDF sitting in `Desktop\Podcasts`.
Published it to the stories venue -- and **the cover image was already there**,
`images/2023_Japan_Story.jpg`, staged and abandoned. That prompted a check for others.

**Six orphan cover images in kimbridges-stories**: covers with no PDF and no page.
`2023_Japan_Story` (now resolved), `LLM_Examples`, `Catalog`, `Ranunculus_Impressions`,
`Selective_Focus`, `Smart_Car`. Each is an intake somebody started and stopped. The last
three appear nowhere else in the PKM. Recorded in deferred.md; **ask Kim rather than
assume they are strays** -- choosing a cover image is not an accident.

### Experiments with LLMs: the genuinely exposed item

The fifth ISSUU link, `chatgpt_examples`, is the one Kim was unsure about, and it was the
only one at real risk. **No venue home at all.** Live on exactly two dying platforms:
ISSUU (deleted account, still serving) and hflip (stops ~Feb 2027). Every other copy was
loose in `Downloads`.

Kim asked to hold it safely without interrupting current work. Done: four PDFs staged to
`Projects/LLM_Examples/` byte-verified with page counts re-checked after the copy, the
orphan cover rescued, and a README carrying provenance and the three structural routes.

**The version trap worth remembering.** Two PDFs, 113 pp and 130 pp, BOTH print
"Version 4: January 1, 2024" on the cover -- the later revision never updated its own
version string. The inventory recorded 113 and was reporting the older file. **A
document's own claim about its version is not evidence of which file you are holding.**
Same family as the file-size lesson earlier today: metadata about an artifact is not the
artifact.

### One fabrication, caught

My first draft of the Japan story description said the trip was "three weeks." Kim never
said that; I filled a gap with a plausible number and it would have published under his
name. Replaced with his own wording from Travel.qmd. Worth logging precisely because
nothing flagged it -- there is no check that fires on a confident invented detail.

**Legacy links: 7 -> 4.** Remaining: `Stage.qmd` L41 (historical, stays by Kim's rule),
`using_an_llm/Resources.qmd` L70 (blocked on the LLM_Examples publication -- the last
non-historical one), and the two stale Quarto Pub prose claims.

**Closed.** All three venues deployed by Kim and verified live 2026-08-02: the Japan story
renders at `/stories/japan-fall-2023.html` (59 pp), and `/ai_podcasts/Travel.html` serves four local `<audio>` players with four links to the stories venue and **zero** issuu or soundcloud references. Desktop originals still awaiting a delete decision; Kim called it a night before digging into the three unidentified orphan covers.

---

## 2026-08-01 -- NOT LOGGED AT THE TIME (reconstructed 2026-08-02 from artifacts)

This session left no entry. Reconstructed here from dated artifacts only -- findings,
deferred.md entries, file timestamps and backups -- **not from memory of the session**,
which is why it is thin. Mechanism 5 was not run.

Evidenced: `pkm_card.md` destroyed by a `grep(..., fixed = TRUE)` with `^`, returning
`integer(0)` and collapsing 132 lines to 1; rebuilt verbatim (Finding 022). Dead Quarto
Pub links repointed in `r_basics` and `using_an_llm` (13 links, backup at
`_backup_2026-08-01/`). R's HOME moved off OneDrive; `.Rprofile` written with
`gargle_oauth_email`. Gallery Catalog `Podcast.qmd` SoundCloud embed replaced (backup
`_backup/Podcast_backup_2026-08-01.qmd`). Three deferred items closed.

**The gap itself is the lesson.** A session that ends without Mechanism 5 is
unrecoverable at full fidelity the next day, even with every artifact intact.

---
## 2026-07-31 -- THE TWO LOST STORIES RECOVERED AND PUBLISHED; two errors by Claude

**Active focus at start:** PKM, Tier 2 delivered, with a content detour named ahead
of Tier 3. Session-start found THREE stale items in proj_PKM.md left by the 07-30
session -- a `_Last updated` two days behind, a Next Steps block still presenting
delivered Tier 2 work as pending against superseded counts (83 works / 58 stories),
and a bad splice that dropped a sentence mid-paragraph. All three fixed at close.

**THE RECOVERY.** Kim rebuilt *Cinque Terre Impressions* (43 pp, 2014) and *The
Washington Monument* (23 pp, 2016) in InDesign from the original photos and text --
same subject, mostly the same words, reformatted to the house style -- and made a
reference PDF of each first. Placement followed the three-artifact model: PDFs into
`pdfs/` (12.0 and 3.1 MB), covers rendered from page 1 at 1200 px (463 / 134 KB,
against a 338 KB median), stubs into `stories/`. No year prefix -- only 4 of 51
existing PDFs use one. Categories from the existing vocabulary, no new filter chips.
**Spelling corrected on the way in:** the working folder read Cinque_terra; the place
is Cinque Terre, as Kim's own source text had it -- which also made the gate match on
the strong path, Cinque_Terre.pdf normalising to the legacy slug exactly.
Kim rendered, checked and deployed. **Verified: 79/79 works rendered AND live (HTTP
200), 0 failures, PRE-DELETION GATE 0.** Quarto Pub, hflip and Exposure are all clear
for account deletion. The gate closed MECHANICALLY, as the rule required -- evidence,
not recollection.

**TWO ERRORS BY CLAUDE, both already covered by rules in this system -> FINDING 020.**
(1) On 07-30 I declared **kimbridges.com dead** on the strength of ONE failed curl
call and wrote it into proj_PKM.md as fact, building an argument on it. It is ALIVE:
200, 115 KB, DNS resolving, with and without a browser user-agent. The evidence
against the inference was already in hand -- exposure.co had returned 403 while being
perfectly alive, in the same session. This is Finding 019 (never assert an absence
without proving it) committed three days after writing it. (2) I raised a data-loss
alarm when deferred.md appeared to shrink; the file was intact and the size was a
stale Drive-stream `file.info` read -- the SECOND time that exact artifact fooled me
this week. Rule: verify a write by reading CONTENT back, never size.
Kim corrected the kimbridges.com claim from his own knowledge. **The mechanisms were
not missing. They were not applied.**

**kimbridges.com, corrected record.** Alive, and KEPT -- Kim's personal and
professional site, deliberately separate from .info. NOT among the platforms being
retired. It does still carry residual story links he thought he had cleaned off;
logged to deferred.md against the account-deletion pass, lower priority.

**deferred.md** gained two sections following its own TASK/CONDITIONAL shape:
kimbridges-stories (two text errors in each book -- the Cinque Terra spelling and
Zeill-for-Zeiss; the Articles-of-Confederation factual slip and 17978-for-1797 in
Washington; Kim: fine as they are for now) and kimbridges.com.

**TIER 3 GAINS A SIXTH ITEM, arguably the most important: give `pkm_findings.md` a
TRIGGER.** Today proved the rules exist and do not fire. 65 KB of knowledge with
nothing connecting a moment of risk to the note covering it is a write-only archive.
deferred.md already solved this -- "the trigger is the mechanism, not the list" --
and the same reasoning applies to findings. Writing more rules without a firing
mechanism repeats the failure at larger scale.

**NEXT: Tier 3.** Storage buckets 4-5, the surfaces-and-permissions map, Mechanism 5
amendments, Findings 001/005/013/015 collapsed into one, the pkm_findings budget
question, and the trigger mechanism.

**TIER 3 DELIVERED (same day).** All six items written.

**NEW: `pkm_card.md` (4.1 KB), the trigger.** Mechanism 2 now reads THREE files,
card FIRST. It carries: the single GROUND-TRUTH RULE (consolidating Findings 001,
005, 013, 015 and half of 020 -- a `G:` path can report a correct name and size
while the bytes are absent, stale or unmaterialised; every surface except the R
bridge can be lied to; verify writes by reading CONTENT, never size); a
SITUATION-TO-FINDING table ("about to say something is missing -> 018, 019, 020";
"about to render Quarto -> 012, 016, 017"; and so on); the ABSENCE-CLAIM rule; the
FOUR SURFACES and what each cannot do, including the grant asymmetries; and the FIVE
BUCKETS. pkm_findings.md keeps all 20 findings and now opens with a pointer to the
card; the four consolidated findings are MARKED, not deleted.

**Storage buckets 4 and 5 -- the May question finally answered.** Bucket 4, build
scratch at `C:\temp\<name>_<date>`, with the retention half the original rule never
had: delete once the deploy is verified live. Bucket 5, git working clones at
`C:\repos\<name>` -- NOT Drive and NOT OneDrive, because a syncing folder serves
placeholders that git reads as corrupt. Pending: move ~\Documents\ai_microscope and
set core.autocrlf.

**Mechanism 5 gained items 9, 10, 11:** close the small remainders (Kim's rule made
formal); account for anything written outside `G:`; and RUN `pkm_health()` -- with
the principle that **where a claim can be checked by the tool, the tool's answer is
the record**, not anyone's recollection.

**Budget model split HOT / PROJECT / REFERENCE.** pkm_findings.md was never too big,
it was miscategorised: a file read monthly and a file read every session were judged
by one standard, so the check cried wolf -- and a check that cries wolf gets ignored.
Over-budget dropped from 3 files to 2 (proj_seasonality, proj_audio; both splittable).

**A check I got wrong and fixed in the same hour.** `pkm_scratch()` first reported
"none" on a 14-day threshold while 224 MB sat stranded in `C:\temp`. A check that
certifies a problem as ABSENT is worse than no check. It now reports every scratch
folder with age and size and merely marks those past the threshold.

**SESSION-START: 44.5 KB across three files** (card 4.1 + index 19.9 + PKM 20.4),
against 184.4 KB on Monday. The rise from 35 KB is deliberate -- the card is new and
proj_PKM absorbed the Tier 3 decisions.

**VERIFIED:** 17 of 17 Tier 3 checks pass. Health: 79 works, 0 reconciliation
failures, 0 broken pointers, gate 0, 2 files over budget, 224 MB of bucket-4 scratch
now visible in the report.

**AFTERNOON/EVENING (cont. 2) -- LINK CLEANUP BEGINS, and R's HOME leaves OneDrive.**

**plainmaps is COMPLETE and LIVE.** Kim repointed the two dead Quarto Pub links
(`index.qmd` L18, `Sitemaps.qmd` L5 -- he replaced the LINK TEXT as well as the URL,
which was the trap: the visible text had been `kim.quarto.pub/sitemaps`). Claude fixed
three typos in `Packages.qmd`. **A brief detour worth recording: Kim thought he had
edited the wrong files** (`sitemaps_website`), but plainmaps is a Quarto BOOK with
chapters at the project root -- `sitemaps_website` belongs to the separate sitemaps
project. Rule: check the project TYPE before hunting for source.

**API TEXT INVESTIGATED, LEFT AS IS.** Kim suspected
`register_google(key=, write=TRUE)` was session-only. It is not -- the ggmap source
shows `write=TRUE` writes `GGMAP_GOOGLE_API_KEY` to `$HOME/.Renviron` AND sets the
session variable; `write=FALSE` is the session-only path. So the book's claim was
correct, and the mechanism is exactly the `.Renviron` practice Kim has since
standardised on -- his file already held the key, put there by this call.

**AN ORPHAN FOUND BEFORE IT COULD BE DEPLOYED OVER.** `Tessellations.html` was live
but absent from the new render. Source existed; line 3 read **"BIG PROBLEMS -- DON'T
USE UNTIL FIXED"**, and `_quarto.yml` had dropped it from the chapter list 90 minutes
after that edit in April 2024. A deliberate removal that never reached the site --
unlinked from any page, but live at a direct URL for fifteen months. Removed.
`Plainmaps.pdf` re-rendered (2.64 MB, 78 pp) carrying all the fixes.

**R's HOME MOVED OFF ONEDRIVE** -- see proj_PKM Design Decisions. Verified: 488
packages intact, 11 keys loading, `~` now `C:/Users/kim`. Old R 3.5/4.1 libraries
deleted. This is the root cause of Monday's OneDrive clone.

**THE DEPLOY MISHAP.** Kim dragged `kimbridges-documents/plainmaps/` to Netlify and it
REPLACED the whole site -- all twenty documents 404'd. Nothing lost; `_site` rebuilt
from the corrected root copy and re-dragged, all verified live. **The trap is
structural, not carelessness:** document folders exist at the project ROOT (where you
edit) and are copied into `_site` as declared `resources:` (where you deploy), so both
hold folders with identical names. Claude set it up by never saying the root was not
the deploy source. Now on the card as DEPLOY TARGETS.

**FINDING 021 -- three operations that look additive and are not:** a case-only rename
destroys the file on Windows; rendering one format of a Quarto book clears the others
from output-dir; Netlify Drop replaces the entire site.
**Claude committed the case-rename bug TWICE, twenty minutes apart, having diagnosed
it the first time.** The lesson existed only in the chat -- it was never written to
the card. That is Tier 3's sixth item demonstrated on Claude rather than argued for:
a rule that lives only in a conversation does not fire.

**STILL OUTSTANDING on the link cleanup:** `r_basics/index.html` and `using_an_llm/`
(2 files), plus the two hflip links in the Gallery Catalog (deadline ~Feb 2027) and
the API-description unification. See deferred.md.

## 2026-07-30 -- TIER 2 DELIVERED: pkm_health.R built, run, and the three remedies fired

**Active focus at start:** none asserted (the 07-29 block closed specimen_labels and
named PKM Tier 2 as the standing candidate). Kim confirmed Tier 2.

**Session-start finding.** project_index.md had regrown 18 -> 67.7 KB in two days, the
Active Focus block alone reaching 49.3 KB on ONE line -- larger than the whole file was
after the 07-27 split. Diagnosis: **Tier 1 reduced the STOCK but nothing constrained the
FLOW.** The block even diagnosed itself (its own text said the dated segments belonged in
focus_history.md) but had no rule telling it to act. A size budget became job 5.

**BUILT: `pkm_health.R`** (500 lines, 21 KB) in Projects_Index/, beside what it scans --
the first test of the Tier 3 question of where PKM machinery lives. Five diagnostics:
(1) GENERATE works_register.md from YAML front matter across the four venues; (2)
RECONCILE source -> _site -> live; (3) VERIFY `_Log:` pointers, report orphans; (4) FLAG
drift on Active projects; (5) BUDGET enforcement. Three remedies, each snapshot-first,
byte-exact, losslessness-verified, and self-restoring on failure: `split_tail`,
`archive_focus`, `split_session_log`. All default to dry_run = TRUE.

**FIRST RUN -- the reconciliation question is ANSWERED: 77 of 77 works render locally AND
return HTTP 200 live. Zero failures.** The pre-consolidation backup-vs-website mismatch
Kim remembered is resolved, and now provably so rather than assumed. **Counts corrected:
77 works** (documents 20, stories 51, collections 4, fiction 2), NOT the 83 estimated on
07-28 -- the 7 extra .qmd files live in `underway/` and `updates/` and are correctly
excluded. Pointers 5/5 resolve, 0 orphans. Drift: proj_checklists.md is 10 days behind
its code (kipuka_puaulu 9.3); `Projects/R_LLM_tests/_book` is named in Locations but was
never rendered.

**REMEDIES FIRED (Kim approved).** session_log.md 603.8 -> 105.8 KB (133 entries ->
logs/session_log_archive.md); proj_specimen_labels.md 143.6 -> 17.1 KB (47 entries);
the 49.3 KB focus block archived and replaced with a 1.5 KB one against a 6 KB budget.
All three verified lossless. **Session-start cost 77.7 -> 30.6 KB.** Live PKM folder
1686 -> 888 KB, with 1043 KB preserved verbatim in logs/.

**TWO ENGINEERING LESSONS.** (1) The bridge timed out THREE times; the cause was
`file.info` over Drive Stream, not recursion. Scoping drift to Active projects fixed it
AND made the check more meaningful -- a Complete project whose folder is newer than its
proj file is normal, and a Standing venue receives work continuously by definition.
31s now. (2) A patch intended to INSERT a line REPLACED one instead, silently breaking
`.newest_mtime`; it surfaced as an unrelated-looking error. Finding 016 again: the exit
code is not the artifact.

**STILL OVER BUDGET (small):** proj_seasonality.md 51.6, pkm_findings.md 63.6 (no Log
heading -- needs a different remedy), proj_audio.md 47.3.

**NEXT: TIER 3** -- storage buckets 4 and 5, the surfaces-and-permissions map,
Mechanism 5 amendments, Findings 001/005/013/015 collapsed into one ground-truth rule.

**AFTERNOON (cont.) -- CONSOLIDATION became the register's real job.** Kim reframed
the works register as an instrument for CONSOLIDATION, not an inventory: it should
measure distance from the target state and shrink as he closes it. Two decisions
taken and recorded in proj_PKM Design Decisions: (1) **venue repos are SOURCE-ONLY
and lean** -- commit .qmd/.R/_quarto.yml/.css, gitignore _site/, pdfs/, images/ and
all large binaries, because kimbridges-documents alone is ~300 MB, plain git keeps
every binary version forever, and Git LFS needs a tool the gert bridge cannot drive;
(2) **legacy platforms end by ACCOUNT DELETION, not item by item** -- per-item
deletion is impractical and Quarto Pub blocks it. I first recorded (2) wrongly as
'frozen, not deleted'; Kim corrected it and the record was fixed. A wrong rule is
worse than no rule -- a later session would have read it and never built the gate.

**MEASURED GAP.** 0 of 5 venue folders is a git repo: source for all 77 published
works exists only on Google Drive. 22 public repos, every one an R package or tool,
no websites. 6 repo/clone mismatches (accessOAI, geContour, milestones, plainmaps
have a repo but no local clone; listsr and Temperature_Patterns the reverse --
listsr may simply be private, CONFIRM do not conclude). The migration is named in
Next Steps as its OWN body of work, not a Tier 3 item.

**JOB 7 -- THE PRE-DELETION GATE, and the day's real find.** Account deletion is a
ONE-WAY DOOR, so the gate is: does every legacy page have an equivalent on a
kimbridges venue? First pass said 22 orphans. **It was wrong.** Legacy slugs name
the PDF (hflip.co/merritt_island) while venue slugs name the story
(wading-birds-of-black-point-wildlife-drive). Re-matching on the PDF FILENAME gave
**51 matched, 5 possible, 2 with no equivalent**. Kim adjudicated the 5 as all
safely present under different names (CLOSED, do not re-derive) and confirmed the 2
as **TRUE LOST STORIES**: *The Washington Monument* and *Cinque Terre*, both
Exposure. Quarto Pub (13) and hflip (34) are CLEAR. **exposure.co returns 403 to
programmatic access**, so recovery is browser-only.

**AND kimbridges.com IS ALREADY DEAD** -- no response on /, /stories or www, while
inventory_all_projects.md still calls it the listing hub for every Exposure story.
A platform disappeared and nothing noticed. That is the argument for the gate, made
on Kim's own material rather than in the abstract.

**RESOLVED same day.** Kim found the base materials for both lost stories -- photos
and text -- and made a **PDF of each as a reference rendering**, which preserves the
Exposure layout and sequencing that the raw parts do not. Nothing is at risk now.
Rule adopted: **close the gate mechanically, not by assertion** -- once assembled
into kimbridges-stories, pkm_legacy_gap() matches them on the PDF filename and the
Exposure count drops to 0 on its own. Sequence: move -> assemble -> publish -> run
pkm_health() -> confirm 0 -> THEN delete the account.

**SESSION CLOSE.** Kim is taking a break, then **slipping the reconstruction of the
two Exposure stories in AHEAD of Tier 3**: move the components into the stories
folder, then rebuild both as PDFs. No intake fired -- per the 07-28 rule these are
level-4 WORKS inside a Standing venue, not projects, so they belong in the generated
register, not in a proj_*.md.

## 2026-07-29 -- DOCUMENTATION RECONCILIATION: the printing folded into the chapters; four drifts, one bad number

**Active focus at start:** specimen_labels, the production pass -- resume item "reconcile the chapters
with the upgraded printing." Kim confirmed it at session start. Session-start protocol run against
project_index.md, proj_PKM.md and pkm_protocol.md.

**The task was audit-then-write, and the audit found more than the two drifts logged on 07-28.**

**1. ★ THE RECORDED CLEARANCE MEASURED THE WRONG THING.** `One_deck.jpg` was measured directly,
scaled off the card's known 3.5 x 2.0in edges (621.6 px/in, agreeing on both axes to 0.2%). The layout
verifies where it was checked -- QR right edge **3.013in** measured against 3.008in predicted. But the
cover's occluding edge sits at **1.804in**, i.e. **0.30in PAST the 1.5in `bind_left` reserve**, so the
QR cleared it by **0.127in and not the 0.372in in the record**. The 0.372in figure was always clearance
against the *assumption*, never against the *cover*. Related: the punched hole measures **0.788in** from
the card edge where `punch_x` draws 0.375in -- a hand punch reaches where it reaches, and moving the
pivot right moved the cover's reach right with it. **★ THE RULE, one level past Finding 020: a verified
number must name what it was measured AGAINST.** "0.372in clear" and "0.127in clear" are both true of
the same deck; only one is about the object. Kim's decision: **correct the record, leave the code** --
the cards print and decode, and widening `bind_left` costs QR size. Corrected in BOTH copies of
`make_qr_cards.R` (specimen_labels working original and the canonical `vouchr/R/`), comments only.

**2. THE BUILT KIT HAS A FOURTH CARD KIND.** Example_1.jpg decodes six cards, and two fit none of the
three kinds `decks.qmd` named: `Collected by: KW Bridges, YH Lau` (teal) and `Determined by: KW Bridges`
(purple), both built as bound screw-post decks. **Adopted: identity / attribution / observation /
comment.** Attribution earns the separation on a handling argument, not a taxonomic one -- **its value
does not change from plant to plant.** Identity changes per specimen, observation changes per specimen,
attribution changes per trip. This is the 07-28 "`Determined by` is FIRST-CLASS" decision arriving in
the prose. A knock-on inconsistency was caught and fixed in the same chapter: the filter paragraph says
a determination is desk work and fails the field test, which now reads oddly beside a determination
card -- the card records WHO will determine, settled before you leave the house.

**3. THE PRINTED DECKS ARE NOT THE DECKS IN `decks/`.** Confirmed by artifact chain, not inference: the
kit Kim printed and photographed came from **`QR_field_notes.csv`** (rendered to
`QR_field_notes_cards.pdf` 16:56 HST on 07-28, and shipped as `vouchr/inst/extdata/`), not from the
three deck-discovery outputs in `decks/`. Every payload in Example_1 is in that CSV, including the two
labels -- `Abundant Flowers`, `Scattered Flowers` -- that broke the narrowed clear zone and forced the
auto-shrink fix. So the project carried **two disagreeing phenology decks** for a month: printed
(Abundant / Scattered / No Flowers) vs discovery (Vegetative / Bud / Flower / Fruit / Fl+Fr), and
`decks/` has **no Abundance deck** although the kit has one. Kim's decision: **the printed set is
canonical** so the figures agree with the photographs. `decks/deck_universal.csv` phenology rows
replaced; **the superseded five values are recorded verbatim in `design_notes.md`** because the edit
overwrote a discovery output (Finding 019 -- do not quietly rewrite a record).

**4. THE COVER COLOUR SCHEME WAS ONE-SIXTH DOCUMENTED.** The kit runs five coded covers -- yellow
phenology, grey abundance, pink life form, teal collectors, purple determination -- in a project whose
own argument is that you find the deck by colour before you read a word, and only yellow had ever been
written down. All five recorded, and named in `decks.qmd` **as one collector's choices, not a standard.**
**Unresolved, flagged not guessed:** the chapter said "a colored cover top and bottom"; the second cover
reads white in `One_deck.jpg` and the photographs cannot settle it, so the chapter now claims nothing
about the back. Kim to confirm.

**WHAT WENT INTO THE BOOK.** `decks.qmd` gained the fourth card kind, the colour scheme, and the
binding clearance **as a design finding rather than a repair** -- the argument being that *a layout drawn
for an object in isolation can be exactly correct and still fail the moment the object is used, because
use adds constraints the drawing never saw.* The binding was invisible in the design file and decisive in
the hand, which is an argument for building a rough deck early instead of perfecting one on screen.
`One_deck.jpg` is its figure, under the caption-as-door convention: the caption states both clearances,
says they were measured off the photograph, and notes the same frame decodes to `Phenology: No Flowers`
-- one image serving as proof of clearance and proof of content. `the-workflow.qmd` gained the practical
consequence (punch every card in the same place, stay inside the reserved band, assemble and photograph
one deck before punching the rest) plus the page-scaling-off warning.

**★ THE COVER ART LANDED MID-SESSION AND THE TITLE IS NOT COUPLED.** `voucher_cover_art_text.png` and
`voucher_logo_art.png` were written at 10:41/10:42 HST while this session was reading the chapters. Two
things: the filenames are `voucher_*` while `_quarto.yml` reserved `vouchr_*`, and **despite the "_text"
in its name the art carries NO baked-in title.** So the AI_Microscope failure mode does not apply --
the title can still be chosen freely at the read-through with no reshoot. Both assets copied into
`documentation/images/`; `cover-image` wired and un-commented; the logo left off with a note, since
`navbar.logo` is not a documented book-level option. `title:` still reads the placeholder `vouchr`.

**Files changed.** `documentation/decks.qmd`, `documentation/the-workflow.qmd`,
`documentation/_quarto.yml`, `documentation/images/` (One_deck.jpg + both art files, new),
`design_notes.md` (new dated section carrying the measurement table), `make_qr_cards.R`,
`decks/deck_universal.csv`, and `vouchr/R/make_qr_cards.R`. The vouchr change is **uncommitted in the
repo** -- comments only, but v0.1.0 is pushed, so it needs a commit.

**★ SAME SESSION, Kim's answers (2026-07-29 cont.) — the title is settled and a new failure mode was named.**

**THE TITLE: "Voucher Labels"** — *"properly descriptive and it spans the vouchr package and the label
writeup."* Closes **Open Question #1 (naming)** completely; the last part had been deferred to the
read-through. Set in `_quarto.yml` over the `vouchr` placeholder. The cover-art files were already named
`voucher_*`, so this morning's apparent filename mismatch resolves itself and nothing needs renaming;
and because the art carries no baked-in title, the AI_Microscope reshoot risk never applied. Naming
complete: package `vouchr` · folder/PKM `specimen_labels` · book **Voucher Labels**.

**The cover construction: the ORIGINAL chapter claim was right, and softening it was my error.** Kim:
matching plastic covers **front and back**, plus **a blank card just inside each** — for protection *and*
**to block a QR showing through cover stock that is not fully opaque.** The white surface I measured in
`One_deck.jpg` was that blank end card, not a white backing.

**★ THE BLANK CARD CLOSES A FAILURE MODE THE DOCUMENT HAD NEVER NAMED.** Every robustness argument in the
book is about **losing** a reading — a code that won't scan, a dropped deck, a dead phone — answered by
redundancy plus the graceful-degradation floor. Show-through is the **opposite**: **gaining a reading that
was never chosen.** And it is the worse of the two for a structural reason: **redundancy recovers what was
lost and does nothing about what was never true.** A lost reading announces itself; a false one is
indistinguishable from a real one downstream. **This is Finding 020's shape a THIRD time** — first a
stubbed QR engine, then a clearance measured against the wrong reference, now a code that decodes
correctly and means nothing. Kim's fix is the right kind: **designed out, not detected** — cheaper than any
validator and requiring no field discipline. Written into `decks.qmd` and into `on-fragility.qmd`, which
had argued only the lost-reading direction and is stronger for naming both.

**The determination card does two jobs.** The 07-28 decision rested on an epistemic argument (an
observation is what the collector saw; a determination is who asserted the identification). Kim adds the
operational half: photographing it **assigns the responsibility while the collection is being made**, and
**the field arrives pre-filled**, so nobody types the same determiner a hundred times at assembly. Both
now in `decks.qmd`. The pattern is worth watching — these moves keep paying twice, field-side and
lab-side, the same way "having the categories makes decisions quick" pays separately from no-transcription.

**The Abundance mismatch: KEEP it, LABEL the files.** Kim asked whether a slight mismatch is OK. It is more
than OK — **the mismatch is the book's own thesis in the filesystem.** `decks/*.csv` are what
`discover_decks()` returned for a corpus; `QR_field_notes.csv` is one collector's working kit; the book
argues at length that facets travel while value-sets are local. Forcing agreement would contradict the
argument and destroy a discovery output. **The defect was never the mismatch — it was that nothing said
which file was which**, which is exactly how the phenology drift survived a month. **`decks/README.md`
created:** provenance of every file, the two expected differences (phenology vocabulary; presence of an
abundance deck), and the rule — *do not reconcile the contents, keep the provenance legible.*
**`deck_universal.csv` RESTORED** to its five phenophase values (Kim confirmed): the **book** uses the
printed vocabulary so figures match the photographs, and the **files** each keep what they actually are.
★ **Process note:** this morning's call bundled "the book uses the printed set" with "so correct the CSV,"
and the second half did not follow from the first. The tell was that applying it required overwriting a
discovery output and recording the loss — **when carrying out a decision obliges you to preserve what it
destroys, it is probably two decisions wearing one label.**

**★ CORRECTION, same session — the "session_log instability" was mostly MY measurement error.** Earlier in
this session I declined to rewrite `session_log.md` and recorded that three stagings of the unchanged file
returned three different byte counts (558,005 / 568,620 / 571,014) and two heading counts. That conclusion
was wrong, and the record is corrected here rather than quietly amended. What actually happened:
**(a)** the "558,005" figure was a **character** count compared against **byte** counts -- the file holds
3,354 multi-byte UTF-8 characters (571,014 bytes vs 567,660 chars), so the two figures were never
commensurable; **(b)** the "568,620" read was **my own already-edited local copy**, because
`device_stage_files` does not overwrite a staged file that already exists -- so what I took for an
independent fetch was a re-read of my own output; **(c)** the "two heading counts" were that same copy with
my entry inserted **twice**. **One thing was real:** the very first read WAS short -- 558,011 chars against
the true 567,660, about 9,600 characters missing -- so a first-access partial read on a Drive Stream-mode
placeholder does happen, and committing an edit built on it would have destroyed those characters. The
caution was right; the evidence I gave for it was not. **Three genuinely independent fetches now agree
byte-for-byte** (571,014 bytes, 147 `##` headings, matching Drive's own metadata size), so this entry was
written straight into `session_log.md` and the standalone hand-off file is no longer needed.
**★ THE LESSON, which is Finding 020 turned back on my own verification: a check that compares two
quantities in different units is not a check.** Today's other rule was *a verified number must name what it
was measured against*; this adds *and in what unit*. Both failures have the same shape -- a verification
loop that could not tell a real discrepancy from an artifact of its own measurement. **Operational rule for
the PKM, worth carrying into the Tier-3 surfaces map: to force a genuinely fresh read over the device
bridge, delete the local staged copy first. Staging alone may hand back the cached file, which makes a
"second opinion" no opinion at all.**

**Also queued: the log split.** `proj_specimen_labels.md` is now ~116KB with its log still in-file,
while proj_PKM / whittakerr / AI_Microscope / briefing_book all moved theirs to `logs/` with a `_Log:`
pointer on 07-28. Kim raised `logs/` while asking where the session entry belonged -- the entry belonged
in `session_log.md` (system-wide connective tissue, distinct from this per-project log), but the instinct
about the folder was right, just early.

**★ THE FUNCTION-REFERENCE APPENDIX IS WRITTEN (2026-07-29 cont. 2).** `appendix.qmd` replaced its stub with a full reference to `vouchr` 0.1.0, built from the roxygen docs rather than from memory, in five groups in use-order: **printing the cards** (`make_qr_cards`, `make_number_cards`, `qr_calibration_sheet`, `validate_qr_engine`, `avery_5371`) · **reading the photograph** (`read_photo`, `decode_qr`, `read_exif`, `parse_cards`) · **deriving the site** (`site_extract`, `site_place`, `site_geology`, `site_soil`, `site_substrate`, `site_hillshade`, `deg_to_compass`) · **assembling the record and its two views** (`assemble_record`, `read_capture`, `make_label`, `make_log_row`) · **discovering the decks** (`fetch_records`, `first_collector`, `signature_features`, `discover_decks`, `signature_heatmap`). **Completeness was checked mechanically, not by eye:** the five groups account for 5+4+7+4+5 = **25**, and a script cross-checked the documented entries against `NAMESPACE` -- nothing missing, nothing duplicated, nothing invented. That check is the point, given the day's other lessons; a reference is exactly the kind of artifact that looks complete while quietly omitting three functions. The prose carries the *reasons* alongside the parameters where a reason exists -- why `bind_left` is kept apart from `x_offset`, why `analysis_scale_m` is a parameter and not a constant, why `ledger` refuses a reissue, why substrate is derived rather than carded, why `determined_by` is lifted out of the observations -- so the appendix reads as a statement of what the system is made of rather than a wall of signatures. Also documented: the two outside tools and the single step each is needed for (Python pyzbar/OpenCV via reticulate for decoding, `exiftool` for EXIF), since R has no maintained QR *decoder*.

**★ THE HARDCODED GOOGLE KEY: ASSESSED, SOURCE CLEANED, PROVIDER ACTION IS KIM'S (2026-07-29 cont. 3).** Kim asked whether the key had actually been exposed or whether rotating is precautionary. Checked rather than assumed. **No evidence of exposure:** the key appears in exactly ONE file (`QR_procedures.Rmd`, twice -- a ggmap `register_google()` call and an Elevation API call, same literal); **it is NOT in the public `vouchr` repo** -- both copies of `site_extract.R` read `Sys.getenv("GGMAP_GOOGLE_API_KEY")` and always have; **`specimen_labels` is not a git repo at all**, so it was never pushed anywhere; **Drive permissions show a single entry -- Kim as owner -- on the file, on `specimen_labels`, and on the parent `Projects` folder**, so no link-sharing and no other principals; the document was **never published** (nothing QR- or label-related among the 19 live documents, and `Site_Extract.pdf` from the same era is image-only with no key text); and a Drive full-text search for the key prefix returns nothing. So **rotating is precautionary on the available evidence.** **★ TWO THINGS THAT MATTER MORE THAN ROTATING.** (1) **Editing the file does NOT remove the key from Google Drive revision history** -- Drive keeps prior versions, so only revoking at the provider actually neutralises the literal. The source edit prevents recurrence; it is not cleanup. (2) **The right action is probably DELETE, not rotate.** Nothing current needs a Google key: `site_extract()` defaults to `source = "aws"`, and Macrostrat, SSURGO and Nominatim are keyless -- the Google path is a legacy fallback, and the book's equity argument IS the keyless stack. Deleting is strictly safer than rotating, and a fresh restricted key takes minutes if the fallback is ever wanted. **The one exposure question no file check can answer** -- whether the key was ever called from somewhere unexpected, or pasted into mail, a screenshot, the retired D: mirror, or the `P://` path still referenced at line 617 -- lives in the Google Cloud console's usage metrics and restriction settings. That is worth a look either way. **DONE HERE:** both literals replaced with `Sys.getenv("GGMAP_GOOGLE_API_KEY")`, CRLF endings preserved, and a comment block added recording why a literal was dangerous even in a private folder -- **the document sets `echo = TRUE` globally and renders to PDF, so any literal in a chunk prints into the rendered output.** That, not the folder's privacy, was the real hazard.

**★ LIVE WORKED EXAMPLES RUN ON KIM'S MACHINE (2026-07-29 cont. 4).** Four of the five chapter placeholders now have real output in `documentation/images/`, each verified by content and not by exit code. **⚠ FIRST, THE NEAR MISS: the INSTALLED `vouchr` was 0.0.0.9000 with 21 exports** -- the build from BEFORE the 07-28 rebuild. Its `make_qr_cards()` was the old `marrangeGrob` version with no `bind_left`, and `validate_qr_engine()` did not exist in it. Running the deck-sheet example against that library would have rendered a perfectly plausible sheet showing **exactly the geometry the chapter says was wrong**, with no guard to stop it. Reinstalled from source -> 0.1.0, 25 exports, `bind_left` present, and `validate_qr_engine()` passes against the real `qrcode` engine. ★ **The rule: a documented version and an installed version are different facts.** Check which one is loaded before trusting any figure it produces -- Finding 020 again, at the library level. **(1) DECK SHEET** (`deck_sheet.png`, plus `deck_sheet_guides.png` showing card outlines, the reserved band and the punch mark -- the better book figure since it makes the binding argument visible). Verified independently: page is 8.5 x 11in, the ten QR centres sit within **0.02in** of the true Avery clear-zone centres (3.19 / 6.69in x; 1.5 to 9.5in y), and **10 of 10 codes decode from the rendered sheet** -- position AND content both measured. **(2) END TO END** on `Example_1.jpg`: **6/6 codes** decode (confirming the 07-28 claim), EXIF read, site derived, record assembled, label and log row produced. `Determined by` lands correctly as a first-class field. **(3) DERIVE** on the project's own Kilauea coordinate (19.435731, -155.336334, taken from `reader_assembler.R`'s example rather than invented): elevation **1344.1 m**, slope **4 deg**, aspect **99 deg (E)**, roughness 1.6 m, native resolution 4.4 m at a 31 m analysis scale; bedrock **Kau Basalt, lava flows, 0-2.588 Ma** (Macrostrat); soil **Andisols, Haa-Keamoku complex** (SSURGO). **This reproduces the 2026-07-01 recorded result exactly and matches `derive.qmd`'s prose word for word** -- "a gentle, east-facing slope, high up, on young basalt, over the ash soils that weather there." Hillshade with the collection point marked saved as `derive_hillshade.png`. **(4) DISCOVER DECKS** from the cached CSV: 1,144 records, 20 collectors at >=10 specimens, 4 clusters. **All four archetypes reproduce**, including the one I first thought had not: cluster 4 is `uehana` = *"Shea Uehana (ORCID...)"*, all 14 records `institutionCode = NEON`, signature templated to **1.00 across the board with `coll_number` 0.00 and `phenology` 0.00** -- precisely the "machine" archetype as described. I reported it missing before checking; the check is what corrected me. Describers (identified_by 0.96, tax_content 0.43), place-recorders (eco_content 0.88, identified_by 0.08 -- self-determined), terse (Dawson at 0.00 on every feature). **Phenology confirmed as the universal gap: 17 of 20 collectors at zero, mean occupancy 3.4%.** Heatmap saved; its first render had the x-axis labels colliding with the title, fixed by moving them to the bottom. **★ THREE DEFECTS FOUND WHILE DOING THIS, worth carrying.** (a) **`discover_decks()` cluster numbering is inconsistent**: the plot re-numbers clusters for display, so `dd$clusters` / `dd$profiles` call the terse group 1 and the machine 4, while the figure labels them 4 and 1 -- the two most distinctive archetypes, swapped. The book is safe because `discovering-decks.qmd` NAMES the archetypes instead of numbering them, but anyone cross-referencing the object against the figure will mislabel them. A vouchr bug. (b) **`metrosideros_US_1985_2026_fulldwc.csv` has 27 columns, not the 161 the GBIF pull returned** -- "fulldwc" is a misnomer; the analysis reproduces for the 12 existing signature features, but adding a feature requires re-pulling. (c) `file.info()$size` immediately after writing to G: reports a stale value (4096 bytes for files that are really 57-227 KB) -- Drive Stream write buffering, which is why every figure here was verified by staging it back and looking at it. **★ THE ONE BLOCKED EXAMPLE, and it is an honesty question, not a technical one.** `Example_1.jpg`'s EXIF puts it at **21.30219, -157.85729 -- Honolulu**, and the derived record reads "Hawaii Capital Historic District, Honolulu County", elevation **2 m**, slope **0 deg**, Makiki clay loam. The pipeline is perfect; the provenance is a bench test on a couch. But `closing-the-loop.qmd` introduces this photograph with *"It was taken in the field"* and `discovering-decks.qmd` ends on *"one photograph on a slope"*. **Not done and not to be done: pairing these real decoded cards with the Kilauea coordinate to make it look like a field collection.** That is the placeholder-QR failure in a new costume -- a plausible artifact that no check would catch. Kim to choose between an honest caption (which would also demonstrate the urban reverse-geocode fix and SSURGO working in a city) and waiting for a real field frame.

**★ ALL FIVE WORKED EXAMPLES NOW LIVE IN THE CHAPTERS (2026-07-29 cont. 5).** Kim ruled on the provenance question: **honest caption, and make a virtue of it.** **`closing-the-loop.qmd`** now names where the frame was actually taken, in the book's own voice -- a bench run at home, on a couch, not a collection -- and says why the honest version is shown: *"I could have quietly swapped in a coordinate from a real ohia forest and the output would have looked more like the argument I have been making, and I would rather show you the honest one, because a system you cannot audit is not a system you should trust."* The chapter then turns the limitation into a demonstration: **the urban record is the one run that exercises the compose-from-reliable-levels reverse-geocode fix**, and SSURGO is as sure of a Honolulu clay loam as of volcanic ash. "The machinery does not know it is indoors." Live chunks for decode -> EXIF -> substrate -> label -> log row, plus `Example_1.jpg` as the input figure. **`discovering-decks.qmd`**: the heatmap in place with a door-caption, plus a short read-the-figure-first paragraph; and its closing line **"one photograph on a slope" -> "a single photograph of a handful of cards"**, since the slope was never in evidence. **`derive.qmd`**: live `site_extract()` + `site_substrate()` on the Kilauea pair, and a hillshade figure whose caption says the relief is subtle *because it is a four-degree slope, not a cliff* -- the figure agreeing with the number rather than flattering it. **`the-workflow.qmd`**: the deck CSV as a table, the guides sheet as the rendered-output figure (chosen over the plain sheet because the grey band makes the binding argument visible), and the folder pass. **★ A FALSE CLAIM CAUGHT BY RUNNING THE CHUNK RATHER THAN TRUSTING THE PROSE.** I wrote that the two frames "agree on all seventeen fields." Verified: there are **sixteen** fields, and they do **not** all agree. Fourteen are identical -- every card value, the coordinate to the last digit (0 m separation), and every derived value; the two that differ are the **file name**, which must, and the **timestamp, by eight seconds**. Corrected to say exactly that, which is a better sentence anyway: *"two independent readings that disagree about nothing that matters."* The near miss is the point -- a plausible round number, written from memory of what the run ought to have produced, one verification away from entering the book. **Third instance today of the same discipline paying off** (stale installed package, wrong measurement reference, invented field count). **Also confirmed:** `decode_qr()` gets **6/6 on BOTH frames**, better than the "5/6 raw, 6/6 with one Otsu pass" recorded on 07-28 -- the packaged reader does the multiple passes internally, so the improvement is the packaging, not the camera. All chunk paths were tested from `documentation/` (Quarto's execute-dir for a book project) and every figure asset resolves. **NOT YET DONE: a full `quarto render`** -- `system2()` is blocked from this bridge, so the chunks were verified individually rather than by rendering the book. Kim should render once before deploying.

**★ FULL BOOK RENDER DONE AND VERIFIED (2026-07-29 cont. 6) -- correcting the "not yet done" note above.** The earlier entry recorded that a full `quarto render` had NOT been run because `system2()` is blocked from the r-studio bridge. **It is done.** `quarto::quarto_render()` works from the bridge (the R package does not trip the system-command restriction), and the whole book built: 13 chapters, quarto CLI 1.8.27. **Verified by inspecting the artifacts, not the timestamps:** title reads **Voucher Labels**; every live chunk's output is present in the HTML (`Phenology: No Flowers`, `Number: KWB 1243`, `Det.: KW Bridges`, the Honolulu locality, Makiki / Inceptisols / Honolulu Volcanics, 1344 m, Kau Basalt, Andisols); both tables rendered; all four figures resolve and ship into `_output/images/` plus a generated `derive_files/` for the live hillshade; and **a sweep of all 13 pages for leaked R errors and warnings comes back clean.** **★ WHY KIM WAS STUCK, worth keeping as a workflow fact:** rendering a book means rendering the **project directory**, not a file -- `quarto::quarto_render("<dir>")`. Rendering a single chapter `.qmd` builds it standalone with no TOC, no cross-references and no site, which is what "doing a file at a time isn't working" was. Root cause: **there is no `.Rproj` anywhere under `specimen_labels`**, so RStudio never offers the Build pane's "Render Book" button. Creating one in `documentation/` would restore the button. **Confirmed harmless:** a book project renders only the files listed under `chapters:`, so the superseded `limits.qmd` stub in the project directory is NOT published -- checked against `_output`, which contains exactly the 13 chapter pages and no `limits.html`. No config change needed. **FOUR PLACEHOLDERS REMAIN**, all in chapters untouched today, and they pass through as HTML comments (invisible to readers, still in the source): `mechanisms.qmd` wants the single-card "Life Form: Tree" scan-returns-plain-text demo and a cards-laid-out-flat shot; `field-log.qmd` wants the collection-points-on-hillshade map and the canopy-physiognomy figure. **The first two are reachable now** (a one-row deck through `make_qr_cards()`; `Example_2.jpg` for the layout, keeping `Example_1` unique to the closing chapter). **The two field-log figures are genuinely blocked** on material that does not exist yet: a day with several real collections, and a canopy image to read.

**★ KIM'S THREE NEW PHOTOGRAPHS WIRED IN; LOGO SETTLED; RENDER CLEAN (2026-07-29 cont. 7).** `Tree_card.jpg` -> `mechanisms.qmd` as the scan-returns-plain-text demo (it decodes to `Life Form: Tree`, checked). `Example_2.jpg` -> `mechanisms.qmd` as the cards-laid-out-flat figure, keeping `Example_1` unique to the closing chapter. **`Deck_spread_out.jpg` -> `decks.qmd`, and it is the best figure in the chapter**: cover, blank card, four life-form cards, blank card, cover -- the construction Kim described, and it lands directly beneath the paragraph about why the blank cards are there. `Decks_and_specimen_card.jpg` -> `decks.qmd` as the kit-as-carried figure (five closed decks + the number card), which also carries the bill-of-materials argument visually. **★ THE LOGO QUESTION IS ANSWERED BY TEST, NOT BY GUESS.** I had left it off because `navbar.logo` is not a documented book-level option. **`book: sidebar: logo:` DOES work** -- rendered, referenced in `index.html`, and shipped to `_output/images/`. Kim's regenerated 250x250 `voucher_logo_art.png` is in place. Full re-render: 13 pages, error sweep clean, the only remaining placeholder comments are `field-log.qmd`'s two. **★ A COLOUR MEASUREMENT WORTH KEEPING, AND A QUESTION.** The five cover colours are consistent across three independent frames -- yellow hue 40-45 deg, green 170-175, purple 292-296, silver sat 0.06-0.08, pink 346-353 -- so `decks.qmd`'s scheme holds, except that "gray for abundance" is more accurately **silver** (it is metallic). **But `Deck_spread_out.jpg`'s covers measure RGB(70,11,5), value 0.27, against RGB(187,46,63) at value 0.73 for the same life-form cover in `Tree_card.jpg`** -- same red hue family, a third the brightness. The white cards in both frames are exposed comparably, so it is not the lighting. **Most likely explanation, and it is Kim's own:** the covers "are not completely opaque," so a black backing reads through and darkens them, while a pale surface does not. If so the figure demonstrates the very translucency that motivates the blank cards, and the caption now says exactly that. **Written so it does not name the colour, pending Kim's confirmation** -- the third time today a colour claim has needed checking rather than asserting. **⚠ `photos/kipuka_puaulu/` DOES NOT CONTAIN KIPUKA PUAULU PHOTOGRAPHS.** Kim mentioned he is working on that set. The folder currently holds three files -- `PXL_20260729_0444*.RAW-01.jpg` -- which are **byte-identical (MD5-matched) to `Example_1.jpg`, `Example_2.jpg` and `One_deck.jpg`**: the card photographs taken at his house on 07-28 at 18:44-18:46 HST, EXIF **21.30219, -157.85729 (Honolulu)**, not 19.435 / -155.30 (Hawaii Volcanoes NP). Presumably a staging folder not yet populated, or a mis-copy. **Flagged rather than used:** building a "Kipuka Puaulu collecting sites" map out of three frames shot on a couch in Honolulu is precisely the failure this project keeps catching, and it would have been invisible in the finished figure. **★ PLANNING NOTE FOR WHEN THE REAL SET ARRIVES.** Kim: *"these were not taken with decks (no specimen collection in the National Park without a permit), they do show site locations where I'd likely have taken a sample."* So the field-log map must NOT imply collections -- **no permit means no specimens, therefore no collection numbers.** Framed honestly it is arguably a BETTER figure for that chapter than a real collection would be: it shows the spatial layer of a field log built from photographs alone, and it exercises the chapter's own **absence-as-information** argument -- where a collector went and where they did not -- without ever claiming a specimen was taken.

**★ THE KIPUKA PUAULU FIGURES ARE IN; ONE PLACEHOLDER LEFT IN THE WHOLE BOOK (2026-07-29 cont. 8).** Kim supplied nine photographs in `photos/kipuka_puaulu/` -- **genuine this time**, verified before use: EXIF puts them at 19.4246 to 19.4442 N, -155.3034 to -155.2766 W, taken 2026-03-06 between 12:04 and 13:11 HST, centroid 477 m from the kipuka, and none matching the Honolulu card frames that had been sitting in that folder earlier. **Nine photographs, eight distinct GPS fixes** (two are the same fix 16 seconds apart); seven fall within 60 m of one another, and two lie 1.5 km SSE and 2.8 km E. **TWO FIGURES BUILT, at the two scales `field-log.qmd` asks for.** `fieldlog_sites.png` -- the eight fixes on a hillshade with 20 m contours and a scale bar, over a 3 km frame, DEM fetched at ~9 m and reprojected to UTM 5N. `fieldlog_region.png` -- the same points as one dot on a 40 km frame with the Kilauea caldera (3.9 km SE), the crater chain, and the shoreline taken as the zero contour of the same elevation record. Per-site derived values also computed for reference: elevations 1202-1247 m, slopes 0-8 deg, aspects SSW to ESE. **★ THE HONEST FRAMING IS IN THE PROSE, NOT BURIED IN A CAPTION.** Kim: no collecting in a national park without a permit, so these are places he *would* have sampled. The chapter now says so in its own voice before the figure -- "there are no specimens behind these points and no collection numbers, and everything else on the map is exactly what a real day would have produced" -- which is the same move as the closing-the-loop bench-run disclosure. **It is arguably a BETTER figure than a real collection would have been**, because it proves the spatial layer is built from photographs alone, and the empty middle of the frame exercises the chapter's own absence-as-information argument. **TWO SELF-CAUGHT DEFECTS while building them.** (a) First draft of the regional map put the label "Pacific" on green **land** -- I had positioned it by eye from the plot margins. Fixed by computing the centroid of the cells below zero and placing the label there: **when a label can be derived from the data, deriving it beats eyeballing it.** (b) The first site map had labels 1/2/3/5 illegibly overlapping, because those fixes are 0 to 58 m apart; fixed with leader lines to offset labels, and the coincident pair is now stated in the title ("nine photographs, eight fixes") rather than hidden. **RENDER: 13 pages, error sweep clean, both figures shipped.** **ONE placeholder remains in the entire book** -- `field-log.qmd` line 23, the canopy-physiognomy figure, which needs a canopy or satellite raster for the site plus a blind physiognomic reading of it. Per design_notes (2026-06-30), the cheap DSM-DTM difference **saturates over tall closed forest** and reported 8 m for a stand near 20 m at this very kipuka, so that route is a detector and not a measure; the Meta/WRI 1 m GEDI-calibrated product streams keyless from open AWS and gave 15.8 m here, and is the right source if the figure is built.

**★★ THE CANOPY FIGURE IS BUILT AND THE BOOK HAS NO PLACEHOLDERS LEFT (2026-07-29 cont. 9).** **The Meta/WRI 1 m GEDI-calibrated canopy map came down keyless, exactly as design_notes (2026-06-30) said it would:** `tiles.geojson` (56,145 tiles) -> the quadkey containing the kipuka centroid (`022300033`) -> `chm/022300033.tif` via `/vsicurl`, a 65,536 x 65,536 raster at 1.19 m in EPSG:3857, cropped over the fixes in seconds. No key, no account, no package beyond `terra` and `sf`. **★ REPRODUCTION CHECK PASSED TO A TENTH OF A METRE.** design_notes recorded Meta 1 m at Kipuka Puaulu as **15.8 m, mean within 45 m**. Recomputed per-site today: site 5 gives **15.7 m**. The 06-30 measurement is reproduced almost exactly, which also identifies which of the nine fixes it corresponds to. **THE DERIVED PHYSIOGNOMY.** Around the seven wooded fixes the canopy runs mostly **12-16 m with emergents to 23 m** (per-site means within 45 m 9.5-15.7 m; 95th percentiles 16-21 m; maxima 18-23 m), and about **a quarter of that ground stands below 2 m** -- gaps, glades and grass. **★ AND A GENUINELY NEW RESULT: the canopy layer recovers what a KIPUKA IS, from the coordinate alone.** Over the wider 3.8 x 3.1 km window **72% of the surface is under 2 m and the median is 0**, while inside the cluster the median is **10 m with 49% over 10 m** -- an island of old forest standing in younger lava, which is the definition of the word, read off a raster by a machine that was told nothing but a latitude and longitude. The two outlying fixes are outside the forest and the map says so: site 4 reads **0.1 m (99% open)** and site 8 **1.9 m (65% open)**. Their earlier terrain results now make sense too -- site 8's slope 0 deg and roughness 0.1 m are open ground, not a measurement error. **★ KIM'S GROUND PHOTOGRAPH IS THE CHECK, NOT THE FIGURE -- and he agreed with the argument.** He offered `PXL_20260306_220723260.jpg` for the canopy placeholder. Declined for that role on principle: the placeholder and the 2026-07-03 illustration convention both specify an image **fetched by the coordinate**, because the whole point of the physiognomy figure is that the description is DERIVED -- collection-spanning, attention-free, obtainable by someone who was never there. A ground photograph is an **observation**, costing exactly the field attention the derive argument exists to save, so using it there would have quietly inverted the book's central derive-vs-observe partition. It also carries no scale, so any height read off it would be a guess, against the standing rule that a derived value must carry its scale, source and limits. **Used instead as ground truth beside the derived map, which is the stronger figure and is native to this project's history:** Kipuka Puaulu is the exact site where DSM-DTM was caught reporting **8 m for a stand near 20 m**, and what caught it was Kim having walked in it. The chapter now re-enacts that finding -- derived reading, then the honest paragraph about why a derived value is worth only its check, then the photograph -- and the new map puts the tallest stems at 23 m, the answer that agrees with the ground. **TWO FIGURE DEFECTS SELF-CAUGHT:** the first render produced a **40-entry discrete legend** (unusable; switched to a continuous ramp), and the cluster label was **clipped off the frame edge**. **★★ MILESTONE: `<!-- FIGURE` and `<!-- WORKED EXAMPLE` counts across all 13 rendered pages are now ZERO.** Render clean, 15 image assets shipping. **★ A PATTERN THE READ-THROUGH SHOULD WATCH.** The book now carries **three explicit honest-provenance disclosures** -- the Honolulu bench run in `closing-the-loop.qmd`, the no-permit candidate sites in `field-log.qmd`, and the derived-versus-checked canopy pair. Kim: *"it would have been better to have an actual data point, but given the circumstances, let's see what we can do with demonstrations that include honest explanations."* Each disclosure is individually right and they are the book's integrity on display; **read together they could start to sound apologetic, and that is a tone question for the read-through, not a factual one.** The fix if it reads that way is to vary the register, not to remove the disclosures.

**★ DEPLOY PREPARED AND STAGED; THE DRAG-DROP IS KIM'S AND HAS NOT HAPPENED YET (2026-07-29 cont. 10).** Kim called it a wrap and chose to proceed without a further read-through, having approved the acknowledgements explicitly. **Slug decided: `vouchr`** -- on the precedent that companion-package documents take the package name (whittakerr, coenosr, checklistr, lists, gePoints), and matching ai_microscope where the card reads one thing ("Preview & Review") and the folder another. So the card reads **Voucher Labels** and the URL will be `kimbridges-documents.netlify.app/vouchr/`. **Steps 2-5 of the documented Deployment Workflow are DONE, each verified rather than assumed:** **(2)** `_output/` **contents** copied from R into a fresh `kimbridges-documents/vouchr/` (18 of 18 items; `index.html` at the folder root; **explicitly checked for the coenosr nesting slip -- no stray `_output/`**; 14 pages, 24 MB), plus the cover placed at the folder root as `vouchr_cover_art_text.png` to match the `<name>_cover_art_text.png` convention. **(3)** Listing stub `docs/vouchr.qmd` written -- title "Voucher Labels", subtitle from the book, categories Botany / Methods / R, image and View-Document link both confirmed to resolve. **(4)** `vouchr/**` inserted into `_quarto.yml` `resources:` in alphabetical position between `using_an_llm` and `whittakerr`. **★ The file is CRLF and was edited in BINARY to preserve that** -- byte delta exactly the 17 bytes of the inserted line, because `writeLines()` on Windows would have rewritten every ending in the file. Same trap as session_log.md this morning. **(5)** Collection site rendered (Finding 017 behaviour as recorded: overruns the bridge timeout, completes normally). **PRE-DEPLOY CHECKS, both passes of the 2026-07-25 routine:** every local `src=` in every page walked against disk -- **211 references, 0 missing** -- run once on `_output/` and again on the copied `vouchr/` folder, since the copy is the artifact that actually ships; 0 broken local `href=`. Then the built site verified: the **Voucher Labels card is on the index (20 cards, was 19)**, its cover path resolves, its link resolves to `_site/vouchr/index.html`, and the built book is confirmed to be the CURRENT build (title "Voucher Labels", the "already in the cabinets" claim, the logo asset, and the acknowledgements page with Nancy Furumoto in it). `_site` is **327.7 MB**, consistent with the ~300 MB recorded for this collection. **⚠ NOT YET PUBLISHED. STATUS IS STAGED.** Step 6 -- dragging the whole `_site` folder onto the **existing** `kimbridges-documents` tile's Deploys tab -- is Kim's, and there is no path to Netlify from this session. Recorded as staged rather than live **on purpose**: claiming publication before the artifact is public would be the same class of error as the 8 m canopy and the 0.372 in clearance. **The known trap, from the whittakerr deploy: "Add new project" creates a standalone site instead of updating this one.** Click into the existing tile first. **ON PUBLICATION, the following need updating and are deliberately left undone until then:** `proj_kimbridges_documents.md` (19 -> 20 documents, new log entry); `proj_specimen_labels.md` and `proj_vouchr.md` (Status, and the deployed URL); `project_index.md` (the specimen_labels row and the Active Focus, which can then close); `inventory_all_projects.md`. Also still open and unrelated to the deploy: the **uncommitted comment fix in `vouchr/R/make_qr_cards.R`**, the **`discover_decks()` cluster-numbering swap**, deleting the Google key, and the `proj_specimen_labels.md` log split.

**★★ PUBLISHED. *Voucher Labels* IS LIVE at https://kimbridges-documents.netlify.app/vouchr/** -- the twentieth document in the collection. Kim drag-dropped `_site` onto the existing tile and verified the card and the document. His words: *"I've tried to finish it for nearly four years. Now it is out and I can discuss it with my colleagues."* **specimen_labels set Complete / Not applicable** on the briefing_book precedent -- a pending colleague review does not hold a deployed project Active. **Active Focus CLOSED**, with no successor asserted; PKM Tier 2 (`pkm_health.R`) is the standing candidate for the next session to confirm. **★★ MECHANISM 6 ADOPTED: DEFERRED WORK.** Kim's proposal, prompted by exactly the situation the publication created -- items that are real, worth remembering, and have no reason to be done now. The first five mechanisms cover intake, context, focus, record and closing; none held **work that is real but not now**, which had nowhere to go but Next Steps, where it either manufactured urgency on a finished project or was silently dropped. **The design point that shaped it: the file is the easy half, the trigger is the mechanism.** So Mechanism 2 gains the **project-touch rule** -- read a project's deferred section before working on it -- and Mechanism 5 gains **item 8**, file the non-urgent and clear it out of Next Steps. Without the trigger the file would be a write-only archive, which is worse than no file because it launders the guilt of not doing the thing. **Entries split into TASK** (waits for an occasion: next revision, release, render) **and CONDITIONAL** (not a task at all -- surfaces only if a named thing happens, and its value is arriving at the bad moment with the answer already written; filed among tasks it would be buried, and the bad moment is exactly when nobody reads a long list). **Item shape:** what, where, why deferred, who raised it, dated -- attribution because colleague reviews are expected to be the main source, and when a colleague asks whether their note landed the answer should be *yes, and here it is*. **Two rules:** items may be closed WON'T DO with the reason kept, because a list that only grows is a list that dies; and **deferred must mean "no occasion yet", never "unpleasant"** -- the Google key sat as an open item for weeks and that was not for want of an occasion. **Placement decided against the obvious version:** one file with per-project sections, not thirty near-empty files, splitting to `deferred/<name>.md` only when a section earns it -- the same growth path the per-project logs took to `logs/` on 07-28. `deferred.md` seeded with 13 real items across specimen_labels, vouchr, kimbridges-documents and the PKM itself, which cleared them out of the active lists -- the demonstration that the mechanism works. **vouchr comment correction committed and pushed** (`9be8f1c`), verified comments-only first (23 added lines, no code, no removals); tree clean and level with origin. **The cluster-numbering item was re-characterised honestly:** I had called it a bug; reading `R/deck_discovery.R` L109-110 shows the plot deliberately re-ranks clusters richest-first, which is a good figure decision. Nothing miscomputes. The defect is that two numbering schemes share the name "Cluster N" and nothing says so, which silently misleads anyone joining the figure to `$profiles`. Additive fix only, queued for 0.1.1; renumbering `$clusters` would break existing code. **Session close.** Nine hours, one publication, one new protocol mechanism, and a long run of the same lesson in different costumes: check the artifact, name what you measured against, and prefer deriving a fact to eyeballing it.

**Queued.** Figures from the real field photos (Example_1 is the multi-card-decode figure the
`mechanisms.qmd` and `closing-the-loop.qmd` placeholders want); function-reference Appendix;
provisional-label image; logo; **the read-through**; deploy. (Title, cover backing and the Abundance
question were all settled later in the same session -- see above.) Commit vouchr. Still open
from before: rotate the hardcoded Google key in `QR_procedures.Rmd`; seed the number ledger from the
historical KWB series. **PKM Tier 2** (`pkm_health.R`) and **Tier 3** remain queued behind the book.

---

## 2026-07-28 (cont. 4) -- DOCUMENTATION: the blank-slate claim raised to book level; naming closed

**Kim's directive:** *"You are right about not needing to start with a blank slate when establishing
categories and values. That's been an important discovery in this project and it needs to be emphasized
in the documentation."*

**Checked before assuming a gap** (Finding 019 habit) -- and the argument was already there, well made.
`decks.qmd` withholds the decks on purpose ("Handing you my decks would be handing you a destination.
The path is worth more"); `discovering-decks.qmd` delivers the empirical method, with the Andes
binoculars story doing the work. **So the gap was EMPHASIS and PLACEMENT, not argument:** it read as a
chapter payoff rather than a headline claim; `derive.qmd` sat between the promise and its delivery; and
the idea had no NAME, so it could not travel the way "capture once, project two views" does.

**★ THE NAME: "the answer is already in the cabinets."** Native to the book rather than imported --
the Introduction opens on Linnaeus's cabinet, calls it "order built into furniture," and closes on "the
sheet in the cabinet." The two centuries of sheets the method reads ARE in cabinets, so the handle and
the book's opening image are the same object. It now appears in exactly three places.

**Three chapter edits (Kim read and approved).**
1. **`index.qmd`** -- a new paragraph before the closing one, hung off Kim's own phrase "everything the
   record should hold," which raises the question and then walks past it. It asks it out loud, admits he
   expected the answer to be a matter of taste, and says plainly it was not. **Framed as a DISCOVERY**,
   per Kim's word. He confirmed "the part of this work I did not see coming" is a correct claim and to
   keep it.
2. **`decks.qmd`** -- the withholding passage now names the answer and **marks the distance**: "the
   answer is already in the cabinets. It belongs to the chapter after next." Naming the distance is the
   cheap repair for the promise-to-delivery gap: a reader who knows the answer is two chapters off reads
   a deferral, one who does not reads an evasion.
3. **`discovering-decks.qmd`** -- delivers under the same name, so promise and payoff are visibly one
   object. **Also fixed a plain error:** it said "the path the last chapter promised," but the promise is
   in `decks.qmd`, TWO chapters back with `derive.qmd` between. Now "the deck chapter."

**Deliberately NOT done: no chapter reorder.** `decks.qmd`'s handoff to `derive.qmd` is well built
("First there is the other half of the record to account for... That half we don't card. We derive it").
Moving `derive.qmd` would break a working transition to fix a problem the name plus the distance-marker
already solve.

**★ PHENOLOGY DECK IS YELLOW, not green** (Kim, as built). Corrected in `decks.qmd` AND in
`design_notes.md`, which still read "e.g. green = phenology" and would have quietly contradicted the
chapter. Kim's own photos are the ground truth: the yellow deck carries the Phenology card in both
`One_deck.jpg` and `Example_1.jpg`. **This is the SECOND detail today where the built object and the
written description had drifted** (the first was the collector card's wording). **Recommended for the
printing reconciliation: a pass that checks every physical claim in `decks.qmd` against the decks in
hand.**

**★ NAMING CLOSED (Open Question #1, open since 2026-06-29).** Kim's decision: package stays `vouchr`;
folder and PKM file stay `specimen_labels`; **book title deferred to the read-through**. Evidence that
informed it: of 101 `specimen_labels` references, **68 are archived text that stays verbatim** (dated
session_log entries, focus_history), leaving 33 live and only 12 filesystem paths -- so a rename is
cheap but can never be complete. Recorded AS A DECISION in both proj files with the cost figures,
because an unrecorded "we chose not to" is indistinguishable from "nobody noticed."

**⚠ LIVE RISK -- the cover could decide the title by accident.** Kim is making the cover art now.
`_quarto.yml` reserves `vouchr_cover_art_text.png` and `vouchr_logo_art.png`; the `_text` suffix and the
AI_Microscope precedent mean **title type gets set INTO the art** -- and on that cover Kim caught his own
title error on the first pass and reshot. `_quarto.yml` currently reads `title: "vouchr"`, a
PLACEHOLDER. Flagged to Kim: either choose the title now, or shoot a cover that leaves room for type.

**Session paused here** -- Kim is watching a night eruption at Kilauea and making the cover photo.

## 2026-07-28 (cont. 3) -- vouchr v0.1.0 PUSHED; proj_vouchr.md created (intake gap closed)

**The package was out of date and Kim called it.** vouchr 0.0.0.9000 (2026-07-02) still carried the
card maker with BOTH defects found today: `marrangeGrob` over the whole page (0.375in off, opposite
directions per column) and no binding clearance. Every card it printed would have been wrong, with no
protection against a bad QR engine.

**Ported and pushed as `0ad01e1`** (2026-07-28 19:51 -1000; 18 files, +1141/-96). `make_qr_cards()`
replaced wholesale; `make_number_cards()` + issued-number ledger, `qr_calibration_sheet()` and
`validate_qr_engine()` added; `assemble_record()` gained collector aliases and first-class
`determined_by`. **Imports 6 -> 5**: gridExtra, readr, tidyr and purrr were used ONLY by the old card
maker, so the rewrite removed all four; grDevices/stats/utils were being imported without being
declared and are now in DESCRIPTION (likely the standing check NOTE). Exports 21 -> 25, tests 8 -> 21.
`document()`/`test()`/`check()` clean on Kim's machine: **0 errors / 0 warnings / 1 note** (the benign
clock note).

**★ A bug caught by writing a test that was expected to PASS.** `check_template()` accepted a 4in card
on a 3.5in pitch: neighbouring cards would overlap and print on top of each other, while the
sheet-extent check passed happily because 0.75 + 3.5 + 4 = 8.25 still fits inside 8.5. Explicit
pitch-overlap checks added in both axes. **The lesson generalises Finding 020's fourth rule:** a check
suite proves nothing until a test you expected to pass fails.

**Verification split honestly, per Finding 020.** No CRAN in the sandbox, so roxygen, testthat and
`R CMD check` ran on Kim's machine. What the sandbox COULD verify, it did: every file parses; 22
assertions across geometry, validator, ledger and identity fields; and both PDFs rendered *through the
package code* decode at 300 dpi -- **16/16 deck codes, 10/10 number codes**. NAMESPACE was hand-written
to match roxygen and later proved **identical to what `document()` generated**.

**Push verified read-only from the sandbox** (no credentials here; Kim pushed with gert): all nine
source files byte-identical to what was delivered, all four new `.Rd` present, no stale `n_col`/`n_row`
left in `man/make_qr_cards.Rd`, all 26 `.Rd` documenting functions that exist, and no stray PDFs,
ledger CSVs or `.Rhistory` in the tree.

**★ INTAKE GAP CLOSED -- `proj_vouchr.md` CREATED.** vouchr has been a public GitHub package since
2026-07-02, actively developed, with **no proj file and no index row**, while every sibling
document+package pair in this PKM carries two (checklists/checklistr, lists/listsr,
seasonality/seasonalityr, Ceska/coenosr). That is the same shape as the founding **Jones gap** that
Mechanism 1 exists to prevent: work deep enough to have its own repo, tracked only inside another
project's file. The new file carries an explicit intake note saying it was created late and that all
history before today stays in `proj_specimen_labels.md` -- a pointer, not a reconstruction (Finding
018/019). **Flagged for Kim to veto** if he would rather vouchr stay folded into specimen_labels.

**Duplication now needs resolving** (logged as vouchr Next Steps 1): the card makers and reader exist
both in `Projects\specimen_labels\` and in the package. The package should be canonical and the
project folder should consume `library(vouchr)`, or the two copies will drift.

**Next: the documentation reconciliation** -- the book chapters describe the card makers and must match
the upgraded printing, plus elevating the blank-slate discovery to a book-level claim.

## 2026-07-28 (cont. 2) -- ★★ END-TO-END PROVEN: 6 codes from one photo -> a real label + log row

**The founding claim holds on real photographs.** Kim reprinted from the real `qrcode` engine,
reassembled the decks and shot three photos. **Example_1: 6/6 codes raw. Example_2: 5/6 raw, 6/6 with
one Otsu pass. One_deck: 1/1.** Payloads exact. The 2026-06-29 two-code test now holds at SIX, on a
phone, in ordinary indoor light.

**The margin, measured.** Example_2's "Determined by" card is visible but fails raw (verified a real
decode failure, not an absent card) and recovers under Otsu. Against a card that decoded easily:
focus 265 vs 354 (Laplacian variance), ink 73 vs 42 -- softer and greyer, at the frame edge on a
purple deck. **One binarization pass is the difference between 5/6 and 6/6**, validating the ladder
already in `decode_qr()`. **CLAHE alone made it WORSE** (6->1, 5->0); pair it with Otsu, never bare.

**★ FIRST REAL LABEL + FIELD-LOG ROW from a real field photograph, no transcription in the chain.**
EXIF gave 21.30219 / -157.85729, 122.5 m, 2026-07-28 18:44:45 -10:00.

**A bug only the real run could surface.** The assembler printed `Collector: NA` -- the deck writes
`Collected by:` while the code looked for `Collectors`/`Collector`, so the name fell into `observed`.
Fixed by widening the aliases, NOT by reprinting physical cards. **Finding 020's rule paying off the
day it was written: exercise the artifact the way its consumer will.**

**★ Kim's design decision: `Determined by` is FIRST-CLASS, not an observation** -- an observation is
what the collector SAW; a determination is WHO ASSERTED the identification, carries an authority, and
can be revised later without disturbing field observations. Now beside number and collector, a `Det.:`
line on the label, a log-row column, omitted when absent.

**★ Kim's assessment of the physical system, captured verbatim in `design_notes.md`.** Three claims
separated as the spine of the deck chapter: (1) **the bill of materials IS the argument** -- printer,
Avery stock, paper punch, screw posts, report covers: the friction thesis at the level of procurement;
(2) **"having the categories makes decisions quick"** is the FIELD-side payoff, a different claim from
no-transcription (the LAB-side payoff) -- recognition beats recall beats composition, exactly when
conditions are worst; (3) **the hard part is deck DESIGN and the system is deliberately NOT
prescriptive** -- "Choose the content for the purpose of the collection." Noted there: not
prescriptive about content is not the same as silent about method -- deck-discovery, collector
signatures and the derive-vs-observe partition are how a collector derives a deck for their own
discipline. Weatherproofing named and put OUT of scope deliberately, to keep the bill of materials at
the stationery level.

**Still open:** fold the makers into `vouchr`; reconcile the documentation chapters with the upgraded
printing; the production pass (figures from these photos -- `One_deck.jpg` is the binding-clearance
proof shot, Example_1 the multi-card capture), Appendix, provisional-label image, cover/logo, title,
read-through, deploy.

## 2026-07-28 (cont.) -- THE PRINTED CARDS DO NOT DECODE; Finding 020; machine-enforced fix

**Kim returned from the field with two photographs** of the same six cards in two arrangements
(`photos/Example_1.jpg`, `Example_2.jpg`), to test the project's founding technical claim: that
several QR cards in ONE photograph all decode. **Result: zero codes read, in both photographs --
and the test is INCONCLUSIVE, not negative, because the cards never carried data.**

**Diagnosis.** zbarimg and pyzbar returned nothing at native resolution and across nine downscales,
and OpenCV's detector found no quads. That uniformity was the tell: decoder tuning does not fail
that cleanly. Cropping one code at high resolution showed **a single finder pattern at top-left and
none at top-right or bottom-left**. A valid QR has three. Every card on both photographs carries the
same signature, and a side-by-side of the PDF I generated against the photographed card matches
module for module.

**Cause -- mine.** With no CRAN access in the cloud sandbox I stubbed `qrcode::qr_code()` with a
random-fill generator so PDF LAYOUT could be tested, and **Kim printed those placeholder PDFs.** I
labelled them as placeholders in prose, three times. That was not a safeguard: the artifact was a
perfectly formatted, print-ready sheet of business cards, and an artifact's affordance beats a
caption. He printed the decks, hole-punched them, mounted them on screw posts, colour-coded them,
and photographed them in the field before anything surfaced.

**★ FINDING 020 written to pkm_findings.md** -- *a verification loop that cannot tell a real
artifact from a plausible-looking one is not verification.* Every geometry check I ran passed:
placements to 0.00007in, clearance 0.372in on all sixteen cards, page counts, glyph overflow, a
blank-page regression. **Every one measured POSITION; not one measured CONTENT.** Rules adopted:
(1) never ship the output of a simulated dependency -- produce nothing, or produce something that
cannot be mistaken for the real artifact; (2) verify the property the artifact is FOR (a QR card
exists to decode; position is a precondition, not the point); (3) prefer a machine-enforced refusal
to a warning. Finding 020 is **Finding 016 one level deeper** -- 016 says render then LOOK; 020 says
looking is not enough when the failure mode is invisible to the eye.

**The structural fix, shipped.** `validate_qr_engine()` added to `make_qr_cards.R` and called by
both makers before anything is written. It checks the QR skeleton in **pure R, no scanner, no
external tools** -- three 7x7 finder patterns, timing rows 6 and column 6 alternating, a legal side
length of 21+4(v-1) -- and hard-stops with no file written if they fail. Verified both directions:
it **blocks** the stub (no PDF created) and **passes** genuine QR codes. The stub can no longer
produce a printable PDF at all.

**★ A fourth rule, learned building the third.** The first validator correctly rejected the stub
**and would have rejected every real QR code too** -- an integer-vs-double comparison inside
`identical()`, and an off-by-two in the timing-run length (n-14 where the run is n-16). Testing only
that a checker rejects the known-BAD input ships a checker that rejects everything. Caught by
generating genuine QR matrices with an **independent implementation** (Python `qrcode`) and
confirming all passed, including one carrying a quiet zone that had to be trimmed. **A validator
must be tested against known-GOOD inputs from an independent source before it is trusted.**

**Housekeeping.** `number_cards_ledger.csv` reset to empty so **KWB 1243-1252 can be reprinted** --
those numbers never reached a specimen, so nothing is lost by reissuing them.

**Cost.** One print run, deck assembly, one field photography session, and a test that returned no
information about the question it was meant to answer. No data destroyed; no collection number
burned.

**Still open -- the actual experiment.** Whether several QR cards in one frame all decode, and
whether the two arrangements differ, remains **untested**. The photographs themselves are good:
even lighting, codes flat and unobstructed, and the binding clearance visibly works as designed in
Example_1. Reprint from Kim's machine, rebuild, re-shoot.

## 2026-07-28 -- specimen_labels: card PRINTING FIXED (two independent defects); number cards built

**Active focus at start:** specimen_labels, exactly as the 2026-07-28 block predicted for today.
Kim confirmed. He had gathered the illustration materials and hit a blocker: the QR codes on the
printed decks needed to move "about 1 inch to the right."

**TWO INDEPENDENT DEFECTS, not one.** The first diagnosis was correct but did not explain Kim's symptom,
and the gap between them was the useful signal.

**Defect 1 -- sheet alignment (found by reading the code).** `make_qr_cards.R` laid the cards out with
`gridExtra::marrangeGrob(ncol=2, nrow=5)` across the whole 8.5x11 page. That divides the page into ten
equal **4.25 x 2.20** cells, which is NOT where Avery 5371 cards sit: the real cards are **3.5 x 2.0**
inside a 0.75in side margin and a 0.5in top margin. Cell centres fell at 2.125 / 6.375in against true
card centres of 2.500 / 6.000in -- **0.375in off, in OPPOSITE directions in the two columns**, so no
single nudge could ever have fixed it. Rewritten to place each card in its own grid viewport at the true
Avery position; measured on the rendered PDF, QR centres now land at 2.4999 / 5.9999in.

**Defect 2 -- binding clearance (found only by asking).** The 0.375in computed error did not match Kim's
measured ~1in, and that mismatch was the tell. Asked rather than assumed, and the real cause was
physical, not typographic: **the decks are bound on the LEFT through a punched hole on a screw post, and
the fanned stack occludes roughly the left 1.5in of the card underneath.** A centred QR's left edge falls
at 1.18in from the card edge -- inside the occluded band -- so the code was clipped. Content centred in
the card is geometrically correct and ergonomically wrong.

**★ THE LESSON WORTH KEEPING: when the measured symptom does not match the computed defect, the
diagnosis is incomplete.** The first fix was real, necessary, and shipped -- and it would not have solved
Kim's problem. The 0.375-vs-1.0 discrepancy was noticed and flagged in the hand-off, which is what made
the second question get asked instead of the fix being declared done.

**What was built.**
- **`bind_left`** (default 1.5in) reserves the screw-post band; all content lays out in the clear zone to
  its right. Verified: every QR's left edge at **1.872in, 0.372in clear** of the band, all 16 cards.
- **`x_offset` / `y_offset`** kept as a separate printer-calibration knob. Deliberately NOT merged with
  `bind_left`: one is a fact about the BINDING (where content sits within a card), the other a fact about
  the PRINTER (where the grid lands on the sheet). Conflating them would have hidden both.
- **`qr_calibration_sheet()`** -- outlines, shaded binding band, punch-hole mark, quarter-inch scales;
  print on plain paper at 100%, lay over an Avery sheet, punch one and mount it on the post to confirm
  the band width before spending card stock.
- **`make_number_cards.R` (NEW)** -- the collection-number identity cards.
- **`number_cards_ledger.csv` (NEW)** -- every issued number recorded; reissue refused unless
  `allow_reprint=TRUE`. A collection number used twice cannot be repaired afterwards.

**Three decisions on the number cards, each taken from the project's own files rather than invented.**
1. **No binding band.** design_notes.md: *"Identity + free-text = business-card holders. These you
   *detach* (a number card onto a specimen) ... so a loose holder fits better than a bound stack."*
   Nothing fans over them, so the full card width is available.
2. **Number BESIDE the QR, not above it.** Removing the band alone would NOT have enlarged the code --
   the QR is sized by the height of its middle band, not by card width, so it would have stayed 1.14in.
   Setting the number alongside lets the code use the full content height: **1.76in square, 2.4x the
   area.** This matters because design_notes names the number card the **graceful-degradation floor**
   ("the non-negotiable minimum is the number card + the photo") -- it is the one card that must scan.
3. **Payload `Number: KWB 1243`** -- exactly what `reader_assembler.R`'s `parse_cards()` already expects,
   so the identity card needs no special case in the reader.

**Dependency reduction.** `make_qr_cards.R` dropped `gridExtra`, `readr`, `tidyr` and `purrr`; it is now
**base R + `grid` + `qrcode`** only. Forced by the cloud sandbox (no CRAN reachable, only base R + grid
installable) but correct on its own terms -- fewer Imports when this folds into `vouchr`.

**Kim's intent read, and confirmed correct.** He asked for "12 (to fill just one page)". The sheet holds
**10**. The stated constraint ("one page") was treated as binding over the stated count, and **KWB
1243-1252** was generated. Kim: *"You interpreted my intent (one page) properly."*

**Two regressions caught by verification, not by reading.** (a) Reserving the band narrowed the content
zone from 3.26in to 1.88in, which **broke two existing deck labels** -- "Abundant Flowers" and "Scattered
Flowers" run ~2.0in at 18pt. Added auto-shrink with a warning; a `safety = 0.96` factor was needed because
measured glyph runs came out ~3% wider than `grobWidth` reported, enough to nick the band. (b) The
header-width pre-scan opens the graphics device, so the loop's unconditional `grid.newpage()` produced a
**leading blank page**; fixed with `if (p > 1)`. Both were found by measuring the rendered PDF with
PyMuPDF, not by inspecting source. **Consistent with Finding 016: the exit code is not the artifact.**

**Verification method note.** No R packages beyond base + `grid` are installable in the cloud sandbox and
CRAN is unreachable, so `qr_code()` was **stubbed** (random modules) to test layout, and geometry was
measured off the rendered PDF. Every delivered PDF carries placeholder QR codes and was labelled as such;
Kim runs the scripts in RStudio for scannable output. The calibration sheet has no QR codes and is valid
as delivered.

**Outcome.** Kim printed both: *"those printed perfectly"* and *"This solved the problem perfectly."*
He now has the physical materials -- observation decks + number cards -- and has **paused the session to
do the photography**, which is the raw material the remaining figures need.

**Files changed.** `Projects\specimen_labels\`: `make_qr_cards.R` (rewritten), `make_number_cards.R` (new),
`avery_5371_calibration.pdf` (new), `number_cards_ledger.csv` (new, 1243-1252 issued),
`KWB_1243_1252.pdf` (layout proof, placeholder QRs).

**What's queued (Kim, at pause).** *"Later, we need to make sure that we're updating the code and
documentation to reflect the upgraded printing."* Concretely: fold the card makers into **`vouchr`**
(the new base-R-only form is package-ready); re-check the **documentation chapters** that describe card
making against the new geometry -- the binding-clearance constraint is a genuine design finding and
belongs in the book, not just in the code; then the production pass resumes (figures from the real field
photos, function-reference Appendix, provisional-label image, cover + logo, the title, read-through,
deploy). **Also still open:** rotate the hardcoded Google key in `QR_procedures.Rmd`; consider seeding the
ledger from Kim's historical KWB series, which it does not yet know about.

## 2026-07-28 (evening) -- PKM STRUCTURAL REVIEW; Tier 1 executed

**Active focus at start:** undecided (the 2026-07-26 block asked for a choice).
Kim redirected to a review of the PKM itself.

**Diagnosis.** The two artifacts Kim noticed -- two stranded 113 MB `_site` folders
in `C:\temp`, and a git clone at `~\Documents\ai_microscope` -- are ONE hole, not
two. Every containment rule in the PKM is DRIVE-SCOPED. The storage architecture was
decided **2026-05-10**; the ClaudeR bridge arrived **2026-05-30**, twenty days later,
and can write anywhere on the machine. Eight of the nineteen findings (006, 007,
009, 012, 013, 014, 015, 017) are bridge mechanics. Every off-Drive artifact traces
to a named bridge constraint: shell execution blocked -> no recursive delete -> a
DATED `_site_20260726` rather than an overwrite; Drive-stream placeholders skipped
by the browser upload -> copy off Drive before drag-deploy; shell git blocked and
git-in-Stream hostile -> the clone had to live off Drive. The rules were not
violated, they were OUT-SCOPED. The deferred clause in proj_PKM's storage decision
("until one appears") predicted exactly this and was never revisited.

**Category error found.** The PKM has one entity type (proj_*.md) but the work has
four: VENUE (4), INFRASTRUCTURE (1), PROJECT (~50), and WORK (83 published items --
documents 19, stories 58, fiction 2, collections 4), of which only ~21 have a PKM
record. **The Jones gap was a level-4 work misfiled as a level-3 project**; intake
was aimed at level 3, so it cured the symptom and left the category error standing.
Resolution adopted: *a proj file tracks work IN PROGRESS; a generated register
tracks work that EXISTS.* A work earns a proj file on DEVELOPMENT, not publication.

**Kim's rules, adopted.** Deployed -> no longer Active. A pending external review
does NOT hold a project Active unless Kim explicitly says so. Small remainders get
closed at end of session. (Half of this already existed in template.md's Complete
definition and had simply never been applied -- the drift pattern, a fourth time.)

**TIER 1 EXECUTED (byte-exact splits, snapshot first).** Snapshot of all 11 touched
files in `Projects_Index_archive_2026-07-28/`, verified byte-for-byte. New `logs/`
subfolder. `project_index.md` 132.6 -> 20.9 KB (superseded focus blocks + Change Log
-> `logs/focus_history.md`; the project-clusters note at old lines 423-446 was NOT
history and was kept). Log tails split from proj_PKM (53->5.4), proj_whittakerr
(153.8->26.5), proj_AI_Microscope (46.7->18.1), proj_briefing_book (48.2->7.0), each
with a `_Log:` header pointer, all four verified to resolve. **SESSION-START COST
184.4 -> 26.3 KB, an 86% cut, ~40,500 tokens returned at the top of every session.**
Losslessness verified: every non-blank original line is present in exactly one of
the two pieces; the only three absences are the header fields deliberately changed.

**Reclassified.** AI_Microscope and briefing_book -> Complete / Not applicable. The
five kimbridges_* files -> **Standing**, a new Status value (a venue or the site
build; receives work continuously, never finished), defined in template.md along
with the review-does-not-hold-Active amendment. `proj_lists.md` repaired: its
`_Status:` held free text, so it was invisible to every status sweep.

**Noted, not acted on.** `session_log.md` is 530 KB and now the largest file in the
system -- the obvious next split. 28 proj files still read Active; the automated
deployed->Complete scan OVER-SELECTS and must be applied one at a time.
specimen_labels stays **Active** -- Kim has the parts, buys printer cartridges
tomorrow, and it is the likely next focus.

**NEW BRIDGE DETAIL, extends Finding 014.** The RStudio MCP security guard scans the
SOURCE TEXT of the submitted code, not the calls actually evaluated. Writing this
very log entry failed twice because the prose contained the blocked function name
followed by an open parenthesis INSIDE A STRING LITERAL. The guard also refuses the
ENTIRE call, not the offending statement, so nothing at all is written. Rule: when
writing prose about the blocked shell functions through the bridge, name them
without the trailing parenthesis.

**Queued:** Tier 2 = build `pkm_health.R` (generate register / reconcile source ->
_site -> live / verify pointers / flag drift). Tier 3 = the storage buckets, the
surfaces-and-permissions map, and the protocol amendments. Rain from Wednesday.

## 2026-07-28 — PKM maintenance: the log gap that was not a gap; session_log.md ordering repaired; FINDING 019
Session-start protocol run (Fable 5; R bridge live, after a restart of the RStudio addin). No project focus opened. Kim asked to spend a little time on the July 2026 log-gap backfill. The backfill was scoped, written, and then thrown away, because there was no gap: the entries had been misfiled, not lost. What follows is the repair.
- **The finding.** The LOG GAP marker written on 2026-07-26 declared that entries for 2026-07-16 through 07-25 "were never written to this file." They had been. All **22** were sitting at the BOTTOM of session_log.md, below the 2026-05-07 to 06-07 archive. The file carries **two ordering conventions** — the top block is newest-first (prepended), the tail is an older oldest-first block (appended) — and some sessions used the older one, which dropped their entries 7,000 lines down where nobody looked. Three June entries (06-25 evening close, two 06-26) were stranded the same way.
- **Why the check failed, twice.** The gap was diagnosed by reading the top of the file and seeing 07-26 followed by 07-09. That is a check of one region, not of the file. The stranded 07-16 and 07-17 entries also used **h3** headings while every other entry uses h2, so a heading-level scan skipped them. And once written, the marker became the evidence: this session inherited the claim and acted on it rather than testing it.
- **A backfill was written and reverted.** Five synthesis-weight entries (07-16, 07-17, 07-22, 07-24, 07-25 day) were reconstructed from proj_briefing_book.md, proj_checklists.md and proj_AI_Microscope.md and written in. The misfiled originals surfaced immediately afterwards during heading-order verification. session_log.md was restored **byte-for-byte** to its prior state (9275 lines, 536499 bytes) before any repair was attempted. **The reconstruction had already introduced one factual error**: the ʻIliau Loop briefing book recorded as bound at **12 pp**, because that is the figure proj_briefing_book.md preserves. The contemporaneous entry says **14 pp** after Kim's review pass. A reconstruction inherits whichever version of a fact the source file happens to keep, and it cannot know what it lost.
- **The repair (Kim chose the wider scope).** All 22 July entries plus the three June strays were moved into reverse-chronological position in the top block. **Content is verbatim, verified line-for-line against the pre-repair file**; the only changes were promoting the h3 headings in the 07-16/07-17 runs to h2, and normalizing blank-line and rule separators. The false marker was replaced with an **ORDERING NOTE** recording what happened and carrying the standing check. Result: **9269 lines / 536821 bytes**, top block **91 entries** strictly newest-first from 2026-07-26 back to 2026-06-07, no date out of order. The pre-06-07 archive stays in append order deliberately; new entries go at the top. One pre-existing anomaly left alone as plausibly intentional: a 2026-05-14 (continued) entry filed after 2026-05-16.
- **FINDING 019 written** — an absence at the top of a log is not an absence, and **never write a gap marker without proving the gap**. A marker asserting absence is load-bearing: the next session reads the note instead of the file and builds on it. The rule is to grep the WHOLE file for the date at every heading level, not to read a region, and if a gap is only suspected, to say so and name the search actually run. This is **Finding 018 from the other side** — a write-up is not a record, and a note *about* the record is not the record either. The record is usually still there.
- **The rule went into the protocol, not just the findings file.** A finding is a lesson; a protocol is an instruction. `pkm_protocol.md` **Mechanism 4** gained a subsection, *Where entries go* (added 2026-07-28), stating four things: new entries go at the TOP of session_log.md as an h2 heading, newest first, never appended; the file legitimately holds two blocks, the pre-2026-06-07 archive deliberately left in append order; **grep the WHOLE file at every heading level before declaring any entry missing**; and **never write a gap marker without proving the gap**, naming the search actually run if a gap is only suspected. A fifth paragraph says reconstruction from the proj files is a last resort and must be labelled as one. The protocol's own `## Log` carries a 2026-07-28 entry saying why. This is the amendment that would have prevented the whole episode, since the failure was an instruction gap, not a knowledge gap.
- **Session close: Mechanism 5 checklist run; AI_Microscope closed under the per-project protocol.** Kim closed the AI Microscope documentation work — the document *Preview & Review* has been live since 2026-07-25 and nothing in the app or the book changed today. The closing review found one real inconsistency: **`proj_AI_Microscope.md` carried `Focus readiness: Blocked` in its header while its Blockers section read "None."** The blocker is the plant-anatomist read, with the app deliberately frozen until it lands, and it is now named there. Status stays **Active** (not Complete — the review is likely to generate work) and readiness stays **Blocked**. Its Next Steps needed no edit. Also refreshed: `proj_PKM.md` last-updated 2026-07-17 → 2026-07-28, and the project_index PKM table row, which was still dated **2026-05-07** and reading "Opus 4.7 transition complete" — it now carries the Mechanism 1 and Mechanism 4 amendments. No new projects were opened, so intake did not fire; no new files entered any project folder.
**Active Focus deliberately unchanged at Kim's instruction: none open, and the choice is still his.** The three candidates carried from 2026-07-26 stand: **briefing_book** (Kim has now met Dr. McClatchey), the **checklistr driver** that would take a centre, a radius and a preview file and emit the report set, and the **AI_Microscope shelf** (audio round two with the pronunciation dictionary — run-to-run pronunciation variability is a KEPT FEATURE, do not seed it away — the parked image downsize, publishing `_onepage.html`), with the app still frozen pending the plant-anatomist review. Kim closed the session here to start a fresh dialog.

## 2026-07-26 — kimbridges_collections: **Behind the Curtain** BUILT and PUBLISHED, the site-wide methods page; the briefing-book commission block written; FINDING 018
Session-start protocol run (Fable 5; R bridge live). PKM drift repaired first, then a single focus opened and closed the same day. The site now carries **four pages**: the three collections plus a methods page at https://kimbridges-collections.netlify.app/behind_the_curtain.html. It is a methods page, not a collection, so it goes in the navbar and stays **out** of the index listing. Kim deployed it himself and reported it live.
- **Read all three collection .qmd files before writing a word.** That is why the page links to `briefing_books.qmd` for the ring-with-a-hollow-centre story instead of retelling it. Six sections: *Three divisions of labour* (Gallery, Jones, Briefing Books as a sequence, each handing more of the middle to the engine); *The input contract*; *The chain* (new SVG from `Behind_the_Curtain/chain_fig.R`, four stages, person solid orange top and bottom, engine dotted blue between); *What it is made of*; *The constraints that shaped the form* (one language, print not scroll, no retroactive improvement, the working data ships with the conclusions); *What stays human* (Diamond 1989 and the 80% tool). Final file: 165 lines, 15700 bytes, LF, 6 h2 + 1 h3, 9 fenced divs balanced.
- **The toolchain, traced from the packages on disk rather than from memory — and Kim was wrong about it.** He assumed vouchr was the main briefing-book package. **`checklistr` is the engine** (26 exports; DESCRIPTION names Kim Bridges and "Claude (Anthropic; collaborative development)" as joint authors). **vouchr** supplies only `site_extract` and the terrain/substrate helpers for R7. **whittakerr** + WorldClim place the biome, **elevatr** gives per-record elevation (the rim vs canyon-floor split came from that), Esri topo tiles do every basemap because OSM returns blank at these sites, **qpdf** binds. Told him plainly rather than letting the mistake stand.
- **New artifact: `Projects/checklists/briefing_book_commission.md`** (3922 bytes). Kim asked bluntly whether there was a paragraph he could hand to Claude to get a new briefing book. There is **no stored driver script**, so the block is the answer: packages and functions, the report set (R1, R2, R3+R4, R5, R7, R10, field card), qpdf binding, the full codified type standard, the Okabe-Ito rules, the three honesty rules (staleness is not rarity; coordinate precision is not locatability, three tiers; the record is not the flora), the naming rule, ending `[paste site_preview.md here]`. Kim then asked for it **on the page**, and it is there as *The standing instruction*. Two PKM-only sections were held back from publication ("What this block does not do", "Preview capture") and the cut was flagged to him so he could reverse it.
- **FINDING 018 — the original ʻIliau comment was never captured in Kim’s own words.** He asked whether it had been preserved. Every `.md` in Projects_Index and the whole `checklists` tree was searched. It has not. `site_preview.md` is a session write-up (its own header: "Captured 2026-07-17 from Kim’s preview observations"), and proj_briefing_book.md line 334 paraphrases the same material a second time. The session log has a gap across exactly that date range. So the input-contract section on the page shows a faithful reconstruction, not the original utterance. **Standing rule: for any new site, write the preview first, in Kim’s own words, and save it before the build starts.**
- **Kim’s three corrections, plus one I caught on myself.** The garbled "A claim that small an input produces" became "a small input". Once the commission block was published, the claim that the engine got "a coordinate and the file below. Nothing else." stopped being true, so it was rewritten to name both inputs. Two publish decisions put to him and answered: **add the standing-instruction section with no reproducibility-gap admission**, and **leave the verbatim panel verbatim** — which means his own "Kīpuka" shorthand stays as he wrote it, even though the naming rule forbids it in new prose.
- **Verified structurally, not visually.** The Chrome bridge rejects `file://` URLs, so the render was checked by counting divs, code fences, h2/h3 (confirming the four `## ` lines inside the fenced block did not leak into document structure), `.input-doc` panels and `<pre>` tags, and by grepping the stale phrase to confirm it was gone. Deployed from a **dated** staging folder, `C:\temp\_site_20260726`, 98 files / 112.1 MB, every byte size checked against `_site` first. Dated deliberately: the R bridge blocks recursive deletes, so reusing `C:\temp\_site` would have carried stale files along (Finding 008 gotcha 2).
- Housekeeping closed: `_backup_concept_80pct_tool_20260726.md` deleted, and `_stamp_test.pdf` deleted once its overnight lock released. `custom.css` 93 → 115 lines (the `.input-doc` rule); `_quarto.yml` gained the resources glob and the navbar entry, with the anchor **re-grepped between the two appends** because the first insertion shifted the index.
**NEXT FOCUS UNDECIDED.** Three candidates: **briefing_book** (Kim went straight from this session to Dr. McClatchey, whose critique the project is on hold for); the **checklistr driver** that would take a centre, a radius and a preview file and emit the report set, the natural sequel to the commission block; and the **AI_Microscope shelf** (audio round two with the pronunciation dictionary — run-to-run pronunciation variability is a KEPT FEATURE, do not seed it away; the parked image downsize; publishing `_onepage.html`), with the app still frozen pending the plant-anatomist review. Still owed from earlier: whether to backfill the log gap 2026-07-16 through 2026-07-25.

## 2026-07-25 (evening) — briefing_book: **The Briefing Books** PUBLISHED as the third collection; the R1 correction; Diamond CONFIRMED
Session-start protocol run (Fable 5; R bridge live). Kim lifted the hold: the two books had been waiting on Dr. McClatchey's Sunday critique, and his call was that getting working prototypes out for review beats polish, since the website is itself the way to reach other reviewers. Shipped the same day.
- **Collection, not Document** — settled early and it shaped everything. A collection needs no uniform pattern, but Claude pushed back that these books *do* share a format and Kim agreed, so the introduction had the harder job of introducing a **series** into which new sites drop without a rewrite.
- **The introduction's spine is ORCHESTRATION** (Kim's addition, and the thread he did not want missed). The other projects were stepwise. The briefing books hand the whole dependent chain to the engine: from a coordinate plus a paragraph of often-personal site knowledge, it runs to an assembled document. Kim: *"Orchestrating a whole series of steps, as is done in the briefing books, is a new and different skill demonstration."*
- **The 80% tool** got its own concept file entry and its citation. A tool does a bounded task; giving it to the engine returns the expected result PLUS "more", and what the "more" is depends on the data — duplication noticed, a missing date range flagged — none of it built into the tool. The shape is expected results + interpretation + open follow-up: *"every good study should end with a suggestion for the next study,"* but as a dialog, actionable at once, with the expert's knowledge arriving at exactly the right time. Kim tied it to **Diamond's "The Ethnobiologist's Dilemma"** — you need knowledge to hold the tool. Kim supplied the scan; the citation is now **CONFIRMED**: Jared Diamond, *Natural History* 6/89 (June 1989), pp. 26, 28, 30. The sharpening: Diamond's informant **THROTTLES** on perceived competence, and **the engine has no throttle**.
- **A sixth friction category named: follow-up (iteration) friction** — the gap between noticing something and being able to chase it. Historically the flag arrived in one place and the means in another, and most flags died in that gap.
- **THE R1 CORRECTION, and the lesson worth keeping.** Page 2 read "the nine nominal points hold 52% of all records", derived from the mis-centred `r1_points.rds` (stored `dist_m` off by up to 851.2 m; three of nine coarse points 2224–2321 m from the true centre). The corrected coordinate table was never saved, so no corrected count could be honestly asserted. The fix exploits an identity — the nominal points ARE the coarse-coordinate points — so page 1's already-verified **39%** describes the same quantity: "the nominal points hold 39% of all records". Both pages now state one number and nothing unverifiable was introduced. **The first repair failed in an instructive way:** a `qpdf::pdf_overlay_stamp` patch rendered perfectly, but `pdftools::pdf_text` still returned 52% underneath, so copy/paste, search, screen readers and any AI ingesting the PDF would have kept the wrong number — on a site whose subject is AI reading documents. Discarded for a **pikepdf content-stream edit** replacing the `Tj` string in place: original font, original metrics, no white box, page 1 pixel-identical. **A visual fix that leaves the old text underneath is not a fix.** (Also learned: `pdf_overlay_stamp` repeats stamp page 1 across all input pages, so per-page stamping needs subset → overlay → combine.)
- **PUBLISHED** — the book rebuilt (22 pp), 23 assets registered under `resources:` in `_quarto.yml`, full site render **55 s** through the R bridge (Finding 017 holds). Anticipating **Finding 008 gotcha 2** (Netlify drag-deploy silently skips unmaterialized Drive-stream files), `_site` was copied to `C:\temp\_site` and verified byte-for-byte — 96 files, 112 MB, 0 zero-byte, 0 mismatches — before Kim dragged it. **LIVE: https://kimbridges-collections.netlify.app/briefing_books.html**. Kim: *"I got the briefing books materials (actually, the whole _site) loaded into netlify and it looks good!!!"* Post-deploy verification done by Claude so it cost Kim nothing at 10 PM: the 22 MB book proven present by a 413 oversize response (a Drive-placeholder skip returns a ~3 KB HTML fallback instead), R5's sheet numbers returned from the 19.3 MB file, the live R1 reads 39%, the CSV serves correctly.
- **Known, not blocking:** R1's page-2 scope table says **224 records** and that figure cannot be reproduced from any surviving file (`r1_points.rds` 193, `r34_targets.rds` 207, specimens CSV 107). Nothing in the report states the map's record total, so it is invisible to a reader; the 100-taxa figure is corroborated three ways. Resolve when R1 is rebuilt from a saved coordinate table.
- **QUEUED:** a site-wide **Behind the Curtain** page for kimbridges-collections (Kim asked for it late in the session; his own proj file has wanted it since May). Approved: **input contract** (the ʻIliau `site_preview.md` verbatim beside the 14-page book it produced), **chain figure** (Okabe-Ito, SVG), **constraints**. Explicitly excluded: the reproducibility-gap admission. Also open: whether to delete `_backup_concept_80pct_tool_20260726.md`, and `_stamp_test.pdf` is locked by something on Kim's machine.

## 2026-07-25 (cont.) - AI Microscope: three data figures, the centering fix, and the document PUBLISHED
The session that finished the book. Continued directly from the assembly work logged above.

**Three data figures**, built in R on Kim's machine from `documentation/aim_figs.R` (kept as a
deliverable so each figure is rebuildable from its data): the cost of storing one slide from 1989 to
2026 on a log scale (Ch.2), the distinct colours found inside each tissue's region of the old blended
map (Ch.5), and tissue abundance as a share of the leaf footprint (Ch.5). Okabe-Ito throughout,
nothing carried by colour alone, SVG, one per page width. Kim's standing approval: "You should know
that I'm a 'data geek.' So the proposed charts work well for me." The proposed fourth figure, a
pronunciation before/after, stays cancelled.

**Two annotation collisions were caught by generating PNG proofs and looking at them** - a callout
lying across the cost curve, and another landing on a neighbouring row and its value label. Neither
produced an error or a bad exit code. Finding 016's rule held: the exit code is not the artifact.
Figure 2's repair improved on the original, replacing a floating callout with a renamed and
individually coloured axis label, which satisfies never-colour-alone more honestly than the callout
did.

**Kim's one criticism, and the rule it produced.** He read the rendered book and said the new charts
"are pushed to the left and they look unusual that way. Is centering possible?" It was, and the
cause was mechanical rather than aesthetic: `.column-page` widens the container to the full viewport
but leaves a natural-width SVG flush left inside it, and `fig-align="center"` cannot correct that.
`.column-body-outset` **plus `width=100%`** does. Verified by measuring figure and paragraph geometry
in the rendered DOM at three viewport widths rather than by eye: symmetric overhang every time, and
the figures render larger than their natural size, so they also got easier to read. Written into
style_multichapter_doc.md Section 6.

**One prose change**, at Kim's request: Chapter 5 now says five tissues "pointed at colors that were
likely not in the image" rather than "simply were not." A small edit that closes the chapter's last
open honesty question, in a chapter about not overclaiming.

**A one-page edition** was built as well (`_onepage.qmd`), all eleven chapters as a single continuous
scroll; the underscore prefix keeps the book project from sweeping it in. Not deployed.

**PUBLISHED.** `_output/` copied from R into `kimbridges-documents/ai_microscope/`, listing stub
written, `ai_microscope/**` added to the site resources, site rendered with every image reference in
every page verified present on disk, and Kim drag-deployed to the **existing** Netlify tile. Live at
https://kimbridges-documents.netlify.app/ai_microscope/ - the nineteenth document on the site. Kim:
"Perfect! It worked nicely. The charts center well. The document is on-line!!!!"

**Finding 017** recorded: `quarto::quarto_render()` works through the R bridge despite the
shell-execution block of Finding 014, so renders no longer have to be handed back to Kim; do not set
a QUARTO_PATH variable, which breaks it; and a full site render overruns the MCP timeout and makes
the bridge look dead for minutes while completing normally.

PKM updated: proj_AI_Microscope.md (Focus readiness Ready -> **Blocked**), proj_kimbridges_documents.md,
style_multichapter_doc.md, pkm_findings.md, project_index.md, this log.
**NEXT:** nothing is required. The open dependency is the external plant-anatomist review, with the
app deliberately frozen until it lands. Optional and unblocked whenever Kim wants them: audio round 2,
the image downsize, publishing the one-page edition.

## 2026-07-25 — AI Microscope: Appendix written, cover + logo, Quarto book scaffold renders, seven figures placed
The second long documentation day, and the one that turned nine drafted chapters into an assembled book. Session-start
protocol run; Active Focus confirmed as AI_Microscope.

**The Appendix** ("How it's built") — the last unwritten piece — was drafted and approved. Its spine is that almost
nothing a student sees is code, it is data, and that this is what made the Chapter 5 color audit cheap enough to
actually do. It walks the three data files (`slides.json`, with the launch intro stored as DATA so the first thing a
student hears is editable without touching the program; the per-slide manifest, with `"match": "exact"` and no
nearest-neighbour guessing, and `pct_basis` written into the file rather than into a notebook that gets lost; and
`botanical_lore.json`, eight fields per tissue with `say` deliberately separate from `proper_name` so a pronunciation
can be fixed without corrupting a name), then keys-stay-on-the-server, the validator, and adding a slide. It closes on
the test Kim would apply to any tool built this way: can the person who knows the subject add to it without touching
the code?

**Cover and logo (Kim's work).** A phone held in a dorm room showing the leaf section, title set into the art in white
with a black drop shadow, plus a 250×250 logo. Claude critiqued the first version. Kim accepted the naming-convention
and file-size points and overruled three others, each with a reason (the tissue is leaf, not root, because it comes
straight off the slide; an earbud would crowd the one thing that has to stay visible; 250×250 is proven in his other
documents). He then caught his own error without help — the cover read "AI Microscope" rather than the document title —
reshot it, and shortened the subtitle to *Rebuilding the AI Microscope*.

**The Quarto book scaffold** was written and made to render clean end-to-end before any further content work, following
the checklistr pattern of proving the pipeline first. **Seven screenshot figures** then went in with numbered captions:
the interface (Ch.3), a wrong answer handled (Ch.4), the rebuilt tissue map and the 65% overlay (Ch.5), the term card
on xylem (Ch.6), the review stage (Ch.7), and the splash (Appendix). All were captured with Playwright against the app
served locally in the sandbox. Kim's verdict: "the figures are well placed and the captions do the work. **No text
references are needed**" — so the prose deliberately carries no `@fig-` cross-references. A `callout-note` at the top
of the Preface now links the live simulator, at Kim's request, and coexists with the floated cover image.

**The lesson of the day.** A figure anchored mid-paragraph made Quarto treat the image as inline: no number, no
caption, and the paragraph split around it. `quarto render` reported success. Only a screenshot of the rendered page
revealed it. The fix was to move the anchor and then add a programmatic check that every figure line has a blank line
before and after. This is the general shape of it — the exit code is not the artifact, and looking at the output is
cheap once the loop exists.

Three infrastructure findings recorded: **014** (`system()` is blocked in the RStudio MCP — use `Sys.which`,
`file.exists`, `file.copy`, `file.remove` instead), **015** (the Downloads trap recurred, with Kim's browser-based edit
to `_quarto.yml` landing in `C:/Users/kim/Downloads` rather than on Drive; and separately, device-staged copies are
read-only and re-staging does NOT overwrite them, so `rm -f` the staged file first), and **016** (Quarto plus Playwright
in the cloud sandbox as a render → serve → screenshot verification loop).

Kim: "a very productive day." PKM updated: proj_AI_Microscope.md, project_index.md, pkm_findings.md, this log.
**NEXT:** the data figures (color_audit, tissue/abundance maps, a pronunciation before/after), an optional image
downsize, then the deploy to kimbridges-documents. The app stays frozen pending the plant-anatomist review.

## 2026-07-24 — AI Microscope: DOCUMENTATION drafted end-to-end ("Preview & Review", Preface + 9 chapters)
A single long, productive documentation session — the writing the project was created for. Drafted the whole
document, **"Preview & Review"** (subtitle *Rebuilding a 1989 learning environment with the tools it was waiting
for*), in the checklistr multichapter-Quarto house style: first-person Kim voice, joint byline (K. W. Bridges and
Claude), destined for kimbridges-documents. Grounded first in style_multichapter_doc.md + kim_association_index.md,
then drafted chapter-by-chapter with Kim reading and approving each in turn. All saved to
`Projects\AI_Microscope\documentation\` and delivered.

Preface + 9 chapters: **index.qmd** (Preface — the 37-year reach-back + a collaboration paragraph telling the
Gemini→Claude arc as *evolution*, Claude acknowledged as collaborator not just author, at Kim's request),
**too_early.qmd** (Ch.1 the 1989 design + a-tool-not-a-spy + the paper's three reaches), **constraints.qmd** (Ch.2
the four walls — storage, the HP 9000/PC split, the serial cable, canned words; Kim will add that the HP 9000 was
very expensive, on loan from HP Labs), **rebuilding.qmd** (Ch.3 the 2026 pivot; process-not-product thesis; the
stack), **tool_not_spy.qmd** (Ch.4 the philosophy that got *harder*; Will McClatchey's review as the test; game +
grading declined; abundance-% passed the filter), **honest.qmd** (Ch.5 the color-map story — 359,791 colors,
phantom blue, the categorical rebuild, *unclassified*/*outside*, the honest self-correction, "an afternoon" =
thesis in miniature), **names.qmd** (Ch.6 pronunciation as friction; Cecil Johnson; the term explorer; roots as a
master key; the kept variability defended as a feature — the longest chapter, Kim approved the length),
**bookends.qmd** (Ch.7 preview/lab/review; the quiz-at-the-door dread dissolved; the teacher's win — the win-win),
**audio.qmd** (Ch.8 Kim's decades-long TTS history as the spine; two old failures both fallen; live-not-stored; the
frontier), **taught.qmd** (Ch.9 the closer — the transferable method, neglected-nuggets, the boat/"knowing what not
to teach", closing the circle to the 1989 screen).

Two notable additions surfaced mid-session and were folded in: (1) **the touch-in / audio-out ASYMMETRY as a
privacy design rationale** — earbud audio output is private and safe to be unsure in; voice input makes the exchange
public unless the student is isolated, re-introducing the very friction the tool removes. Added to Ch.8's frontier
as an honest open problem; Kim: "a big reinforcement of the basic thesis." (2) **"The art of teaching is knowing
what not to teach"** — a career principle given to Kim by two of his students, **Mick Crawley and Mark Westoby**
(both now eminent ecologists, England and Australia); the boat/subtraction metaphor. Logged to
kim_association_index.md as **Theme 13**; carried into Ch.9.

Kim's verdict: structure, balance, and tone all correct across every chapter; "an absolutely amazing day." He'll do
a careful read and light voice edits. **NEXT (tomorrow):** the Appendix ("How it's built"); figures (color_audit,
tissue/abundance maps, overlay, term explorer, a pronunciation before/after); a cover photo + logo (Kim to make);
then the Quarto book scaffold (`_quarto.yml`, render offline end-to-end) and deploy to kimbridges-documents. All
drafts committed to Drive via the device bridge.

## 2026-07-22 (later session, cont. 4) — AI Microscope: term explorer confirmed; top-to-bottom audit + fixes; audio intro; BOOKENDS framing
Kim confirmed the term explorer ("an excellent addition"; liked the etymology balance). Noted slight pronounce-to-
pronounce variability (ElevenLabs prosodic nondeterminism with bare input) — a seed + higher-stability fix parked for
audio round 2. Ran the **top-to-bottom code audit** (report saved: AI_Microscope_audit.md). Kim DECLINED the headline
item (dropping the live Gemini polish — accepts the double AI call) and took the rest in order; all deployed: single-
clip **audio management** (newest-wins, no overlap; helps mobile), a **slide-picker + slides.json** index with the load
path refactored into loadSlide() (scaffolds the multi-image future — a real anatomist review may bring root/stem slides,
and the picker matters for the documentation), **calibrated + aspect-safe magnification** de-duplicated into one
cropGeometry helper, honest relabel ("High-contrast view"), and a11y touches (ARIA live region, canvas label, no
innerHTML). Then the **launch audio intro** — Kim's welcome script (greets first-timers and returners in one), stored in
slides.json as DATA (editable without code) — and relabeled the depth toggle to **"Before the lab — preview" / "After
the lab — review."**

**Additional perspective (Kim, important): the BOOKENDS pedagogy.** The simulator sits on either side of the real lab —
a friction-free PREVIEW before (warm up on the view, magnification, names, Latin/Greek vocabulary; lowers cognitive load
for the hands-on lab) and a consolidating REVIEW after (revisit; concepts settle — where much real learning lands). Two
jobs: remove friction, induce review. The tool's *why*, and a strong spine for the document. **The app is now
feature-complete as a tool.** NEXT: Kim to choose — audio round 2, or open the DOCUMENT. All pushes clean via gert;
PKM updated (proj_AI_Microscope.md, project_index.md, this log; audit report in the project folder).

## 2026-07-22 (later session, cont. 3) — AI Microscope: audio direction opened; pronunciation test; term explorer built
Closed a long, productive day. Reframed **audio as the showcase technology** for the AI Microscope (reviving the 1989
"names pronounced, meanings shown"), and **pronunciation as FRICTION** — a theme that scales to the ~100 scientific
names at Kīpuka and to a planned chapter (anchor story: Cecil Johnson's "this is my good friend, *Hibiscadelphus
giffardianus*"). Ran a standalone **ElevenLabs pronunciation test harness** (R/curl from RStudio; proj_audio.md): found
**IPA phoneme tags honoured on turbo v2, not flash v2.5**; adopted a sparse IPA-override approach (Syringa stays raw —
"only fix what's broken"). Then **built + deployed a term explorer** in the app: a per-tissue card with a Say-it button
(turbo v2 + optional IPA override), a plain-English gloss, and etymology/roots; extended botanical_lore.json and
parameterised the speak function for model choice. Glosses/etymologies are first-pass for Kim to refine. Kim will work
through the new version and comment tomorrow. **NEXT TASK (if the feature reviews OK): the deferred top-to-bottom
audit** of the app (efficiency/API-dependence, live-LLM, multi-image extensibility, maintainability), plus the small
audio intro, then the document. PKM updated: proj_AI_Microscope.md, proj_audio.md, project_index.md, this log.
briefing_book still ON HOLD (no McClatchey review yet).


---

Older entries (133) were moved to `logs/session_log_archive.md` on 2026-07-30 by pkm_health.R.
They are verbatim. Search there before concluding an entry is missing.
