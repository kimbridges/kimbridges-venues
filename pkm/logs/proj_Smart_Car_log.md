## ★★★ TWO CORRECTIONS FROM KIM, 2026-09-01 — the 0/8 mechanism, and the mark on the sheet

### ⚠⚠⚠ IT WAS NEVER HIS HANDWRITING. IT WAS THE RECEIPTS.

> It wasn't me slashing zeros. You can see from the log that I don't do that (except sometimes, but not here). It was the printed fuel receipts that had a combination of small print, sometimes little ink, and a dot in the middle of the zero. These were hard to read, especially when there wasn't much light in the car. It was in entering or checking those receipts that errors were introduced due to the "is it 0 or 8?" situation.

**Finding 033 attributed the cause to Kim's slashed zeros and that attribution is now corrected in place.** The DIRECTIONAL argument survives untouched -- a **dotted** zero fails exactly the way a slashed one would -- and no number in the test changes. **Three consequences do:**

1. **The log sheet is not the witness; the receipt is** -- and receipts are thermal slips that were mostly binned. **For this error class the settling document usually no longer exists.**
2. **The mechanism does not belong to a writer**, which matters because **there are two hands in this record** (see below). A handwriting explanation would have to account for the error rate not tracking the writer. A receipt explanation never had to.
3. **The same document is cause and cure** -- the surviving receipts print the odometer and are the project's FOURTH independent record.

**★★★ AND THE LESSON IS SHARPER THAN THE ONE 033 RECORDED.** *When errors share a shape, ask what physical process makes that shape* was right; **I then attached it to the wrong process -- the writer in front of me, rather than the machine upstream of him.** A shape in the data points at a PROCESS, not at a PERSON, and the process may belong to somebody who never heard of this project. **Ask whose hand, then ask whose printer.**

⚠ His slashed-zero habit is real but occasional (*"except sometimes, but not here"*). **Do not reintroduce it as a general explanation.**

### ★★★ THE MARK ON THE SHEET IS A HAPPY FACE, AND THE HAND CHANGES THERE

The ch.9 figure caption had it as *a question mark, for a reason nobody now remembers.* Kim:

> There is also a happy-face icon beside it (hence it looks like a question mark). Why? It's Nancy's birthday (June 9). I picked her up in Atlanta and we spent the next few days traveling together. Just a coincidence that her coming aboard happened on her birthday. The writing in the log changed that day; it goes from mine to Nancy's hand. It is perhaps worth noting that our writing is quite different. I'm right-handed; Nancy writes with her left hand. And she's mastered "doctor writing" as she is an MD.

**★★ AND THE SHEET CORROBORATES THE HANDOVER WITHOUT ANYONE READING THE WRITING.** On `2012_TwoRed_Frostburg_Trip_Log.pdf` p.3 the fuel rows before 6/9 are dated **`6/1`** and **`6/8`**; from the 6/9 row onward every date carries the year -- **`6/9/12`, `6/9/12`, `6/11/12`, `6/12/12`.** **The convention changes exactly where Kim says the hand does.** A second writer is visible as a change of FORMAT, not only of penmanship, which is a far more machine-readable signature than handwriting.

**★ TWO HANDS IS A STANDING FACT ABOUT THIS RECORD** and belongs anywhere the book reasons from handwriting. Written into ch.9.

### ⚠ ONE THING NOT PRINTED: THE PICKUP CITY

Kim says **Atlanta**. **The 2012 Frostburg trip has no Atlanta leg or fill** -- 6/9 runs **Streetsboro OH -> Jackson MI**, out at 09:21, **268 odometer miles against roughly 215 by the direct road**. The late start and the ~50-mile excess are consistent with a detour to collect somebody, and the record cannot name where. **Atlanta GA appears in the record only on the 2016 Fourth Crossing.** Likely a conflation of trips. **Asked; not written into the chapter, which does not need the city.**

---

## ★★★ FUEL ECONOMY FROM KIM'S SIDE — 2026-08-31, verbatim, with four tests run on it

> Smart cars weren't designed for the kind of fuel economy you get when you have an aerodynamic body. They're boxy. They push the wind instead of slipping through it. I knew that when I bought TwoRed. I'd get economy as it is a small car with a small engine. But highway economy wasn't the design priority. Safety: yes. Fit in small spaces: yes. Carry ample gear: yes.
>
> Once out on the highway, I had choices. I could keep up with the usual car traffic or I could follow the trucks. Slower speed. And the added safety of them providing a protective barrier traveling ahead of me. I wasn't in a hurry most of the time, so I feel into the habit of following trucks. Not always. Sometimes they were just too slow. At the lower speed I felt I was saving fuel.
>
> There were a few times I got off the Interstate just to go slower. Once, I spent hours driving on the road that runs alongside the Interstate as it runs through Nebraska. My speed dropped to about 50 MPH for that period. I enjoyed the change as I could better appreciate the farming community by seeing closer.
>
> There is sort of a flip side to this. I recall a few places, such as Texas, where the posted speed limit was 80 MPH. 75 MPH was common in rural areas. Smart cars can go that fast. Whether I want to is a different matter. The high speeds made me want to avoid these highways. I'm not in that big a rush and it is certainly not the way to achieve economy.
>
> It might be worth noting that Smart cars use premium (higher octane) fuel. There were only a few places that couldn't be found. Other than getting fuel at Costco (obviously less expensive), I often chose the station for the amenities, such as a clean restroom or good food. I rarely shopped around for the lowest price, other than avoiding some obvious stations that were located in places where they could charge higher prices. We often stopped outside of the town centers to get gas.

### ★★★ TEST 1 — SLOWER DAYS DO READ BETTER, AND IT IS A SIGNAL, NOT A FINDING

**The instrument had to be built first.** A tank and a leg do not line up, so I took only the **44 tanks that fall entirely inside a single leg** and attached that leg's gross speed to them.

| test | result |
|---|---|
| Spearman, gross mph vs mpg, n = 44 | **rho = -0.359, p = 0.017** |
| `lm(mpg ~ leg_mph)` | -0.158 mpg per mph, **p = 0.21** |
| `lm(mpg ~ leg_mph + leg_miles)` | -0.098, **p = 0.33**, adj R2 jumps 0.01 -> **0.37** |
| trimmed 5/95, n = 38 | rho = -0.317, **p = 0.052** |
| early era (odo < 40k) n = 21 / late n = 23 | p = 0.27 / p = 0.057 |

**The direction is his, every time. The significance is not stable.** ★★ **And the reason is the same instrument problem ch.6 is built on: gross speed is not cruising speed** -- it contains every stop -- so a day of truck-following and a day of long breaks look alike. **`leg_miles` carries most of what the model can explain** (adj R2 0.01 -> 0.37) and it eats the speed term when both are in.

**★★★ SO KIM'S MOST CONFIDENT ECONOMY BELIEF IS THE ONE THE RECORD CAN LEAST CONFIRM, and his own wording already allows for it:** *"At the lower speed I felt I was saving fuel."* **He said felt.** Write it that way. Belongs to the DIFFICULTY strand by the editorial rule; **do not print a coefficient.**

### ★★★ TEST 2 — THE BEST TANK IN SIXTEEN YEARS IS GRAVITY, NOT RESTRAINT

**Gypsum CO -> Big Springs NE, 313 mi, 56.04 mpg, best of 286 full fills** against a median of 39.12. That is **down out of the Rockies and out across the high plains.** The second-best Nebraska tank, **York NE at 50.62 over 337 mi**, is the Ogallala -> Omaha day -- also eastbound, also downhill, and at **48.8 mph gross it is one of the FASTER days in the record.**

**★★ Two of the three best tanks on that corridor are fast descents.** A chapter that argues slow driving saves fuel has to survive that, and the honest form is to put it in rather than route around it. ★ *Gypsum is the same station as the Mount Evans control in ch.4* -- the record keeps re-using its own landmarks.

### ★★★ TEST 3 — COSTCO IS REAL, MEASURABLE, AND WORTH ABOUT 20 CENTS

20 Costco fills of 294. Matching each against the median price of every non-Costco fill within **21 days either side**:

**Median discount $0.20/gal. Eleven of thirteen comparable pairs cheaper. Paired Wilcoxon p = 0.008.** Biggest gap Ft. Oglethorpe GA at -$0.45; the two that go the other way are Carlsbad 2015 (+0.15) and a pair of California fills in Feb 2017.

**★★ THE IRONY IS THE POINT AND IT IS KIND RATHER THAN SHARP.** He says he rarely shopped for price and chose stations for a clean restroom or good food. **The one price decision he did make is the only one the record can prove he made**, and it is worth twenty cents a gallon across sixteen years.

### ★★★ TEST 4 — THE FRONTAGE ROAD IS DATED, AND IT READS AS ONE OF THE FASTEST DAYS IN THE RECORD

**Kim dated it 2026-08-31: 2012-05-28, Ogallala -> Omaha.** *"I am quite sure it was the 2012-05-28 as this is the correct direction and it matches what I remember. I didn't do the whole drive on the side, just part of it."* He chose it on DIRECTION, which is a check I had not thought to apply and which the other two candidates fail.

**Now look at what the day reads as.**

| | |
|---|---|
| the leg | Ogallala NE -> Omaha NE, 340 mi, 06:50 to 14:48, 6.97 h |
| gross speed | **48.8 mph -- 20th fastest of 132 timed legs**, against a record median of 40.45 |
| the tank | York NE, 337 mi, **50.62 mpg -- 8th best of 286**, against a median of 39.12 |

**★★★ THE DAY HE DELIBERATELY SPENT PART OF AT 50 MPH ON A SIDE ROAD IS, TO BOTH INSTRUMENTS, A FAST EFFICIENT INTERSTATE DAY.** Top-sixth for speed, top-3% for economy. **Nothing in either number is wrong and nothing in either number is true**, and this is the sharpest single example the book has of the hinge chapter's argument.

**★★ THE MECHANISM IS WORTH SPELLING OUT, because it is the same one twice.** Gross speed cannot distinguish *slow cruising with almost no stops* from *fast cruising with stops* -- a 6.97-hour day covering 340 miles is a day that barely stopped, and the frontage-road hours are averaged into the interstate either side of them. **The same averaging that hid the Canadian Plains stress and the tree-tunnel tedium hides an afternoon of pleasure.**

**⚠ TWO HONEST CAVEATS AND THE CHAPTER SHOULD CARRY BOTH.** The tank is **not clean** -- it opens at Bridgeport NE (27,228), before the leg starts at 27,320, so about 73% of the 337 miles are this day. And **eastbound across Nebraska is roughly a 2,200 ft descent**, Ogallala to Omaha, which is doing some of the work in that 50.62. **The economy is not evidence of the slow driving; it is another thing the record cannot separate.**

**★ AND IT PAIRS WITH TEST 2.** The best tank in the record is a descent, the eighth-best is a descent, and the day inside the eighth-best is the one day he chose to go slowly. **Three explanations, one number, and the record cannot rank them.**

### ⚠ NOT TESTABLE FROM THE RECORD

- **Premium fuel.** The log has no grade column, so the octane requirement is his statement and stays attributed. It does mean every price in this book is a PREMIUM price and any comparison to national averages must say so.
- **Avoiding the 80 mph highways.** A route not taken leaves nothing behind. His statement stands on its own.
- **Stations outside town centres, chosen for a restroom.** No coordinates on the fills.

### ★★ WHERE THIS MATERIAL GOES — it does NOT belong to one chapter

`what_driving_cost.qmd` (ch.8, the hinge) is about **what the driving cost the DRIVER**, not money -- the name misleads. The money and economy chapter is `what_the_car_cost.qmd` in Part Three. This account splits at least three ways: the **design argument** (boxy, pushes wind, and economy was never the priority) sits with `small_cars.qmd`; **truck-following** is a SAFETY choice read as an economy choice and touches `is_it_safe.qmd`; **the frontage road** is hinge material; **Costco, premium and station choice** are `what_the_car_cost.qmd`. **Kim to rule.**

---

## ★★★ THE FERRIES, AND THE WHITTIER TUNNEL — Kim, 2026-08-31, verbatim

> TwoRed went on a number of ferry rides. I suppose for most people, that's not a big deal. There are a lot of short car-ferry rides. But consider the Whittier to Bellingham route: about 1,300 miles. Perhaps the longest on the continent. Even Bellingham to Skagway is a bit over 1,000 miles. An overnight ferry from Newfoundland was a long ride, too. The Alaska system is called the Marine Highway. It obviously has a character of its own.
>
> An observation that I don't know where it fits: to get to Whittier (the port for the Alaska Marine Highway) you drive through a long (about 2.5 mile) railroad tunnel. That was scary! There's no instructions on how to drive and I wondered if my narrower than average wheelbase would work relative to the train tracks. It's dark. Water drips. You need to keep up your speed as you are part of a convoy as you go through. And, for a first-timer, you don't actually know how long it is. There were times I was scared due to danger (car eating hole, police car heading at me). But this was not dangerous in that sense. It was a kind of challenge danger; could I drive well enough to get through.
>
> By the way, that ferry route is largely discontinued now. There was just one run in 2026 and it was the only one in a period of several years. TwoRed had what is now a rare experience.

### ★★★ FIVE SEA PASSAGES. TWELVE ODOMETER MILES. SEVEN NIGHTS ABOARD.

The record already held every one of these and nobody had added them up. `book/R/ferries_data.R` now does.

| passage | date | odometer in | out | **miles** | nights |

### ✓ APPROVED 2026-08-31, with a reader-model note worth keeping

Kim on the finished chapter: *"That made a really nice transition. I particularly like that it puts the Alaska driving into a better perspective. **I don't think most people know about the Marine Highway.** The idea to have this a separate chapter is very good."*

**★★ THAT SECOND SENTENCE IS AN EDITORIAL CONSTRAINT, not a compliment.** It says the chapter is addressed to a reader who **does not know the system exists**, which is why the explanatory register earns its place here and would be over-explaining anywhere else in the book. **Do not trim the "they call it a highway" section for length in a later pass** -- it is doing the work Kim is naming.

**★ And note what it did structurally, which was not the reason for writing it.** It was made a separate chapter to protect ch.6's single argument. **The side effect Kim values most is that it re-scales the Alaska trip** -- the Arctic expedition now reads as a drive with an ocean voyage inside it rather than as a very long drive. **Splitting for one reason gave a benefit of a different kind**, which is worth remembering the next time the one-argument rule argues for a split.
|---|---|---|---|---|---|
| Lake Michigan, Ludington -> Milwaukee | 2012-06-10 | -- | -- | **0** | 0 |
| Alaska Marine Highway north, Bellingham -> Haines | 2013-08-09 | 35,979 | 35,989 | **10** | 3 |
| Alaska Marine Highway south, Whittier -> Bellingham | 2013-08-27 | 38,284 | 38,285 | **1** | 4 |
| Newfoundland out, North Sydney -> Port aux Basques | 2014-05-25 | 46,036 | 46,037 | **1** | 0 |
| Newfoundland back, Port aux Basques -> Sydney NS | 2014-05-28 | 46,625 | 46,625 | **0** | 0 |

**★★★ THE CAR CROSSED THOUSANDS OF MILES OF WATER AND THE ODOMETER RECORDED TWELVE**, and ten of the twelve are the drive off one dock and onto another. **On Kim's own figures the two Alaska passages alone are about 2,300 miles.** Those are HIS numbers, not the record's -- nothing in the fuel or trip log measures water, which is exactly the point.

**★★ THIS IS THE SCOPE BOUNDARY AT A SCALE THE BOOK HAS NOT USED YET.** Ch.3 found it inside a trip, ch.4 between trips, the Foreword at the car's end, ch.5 in the reasons a day was long. **Here the car MOVED -- for days, hundreds of miles at a time -- and the instrument that exists to measure movement recorded nothing**, because it measures wheel rotation and the wheels were not turning. **The odometer is not a position sensor and this is the one place in sixteen years where the difference is visible.**

**★ AND THE FUEL LOG SHOWS THE SAME THING FROM THE OTHER SIDE.** The Bellingham fill after the southbound crossing carries `leg_miles` 336 -- a tank that begins in Homer, Alaska and ends near Tacoma, Washington, with a Gulf of Alaska in the middle that cost no fuel at all. **The best fuel economy in the record would be a crossing, if a crossing were a leg.**

### ★★ THE ROUTE IS BEING RETIRED, AND THE OFFICIAL SOURCE AGREES WITH KIM

Kim reports the cross-gulf route is largely discontinued, with one run in 2026 and none for several years before it. **Checked against the Alaska DOT's own AMHS route page, which states: *"During the proposed winter 2026/27 schedule AMHS will not be traveling to Yakutat or scheduling 'cross gulf' routes."*** That corroborates the direction of his claim from the operator itself.

**⚠ WHAT IS NOT SOURCED: the specific "one run in 2026" count.** Kim's figure, and the AMHS page does not carry it. **Write the sourced sentence (the operator is not scheduling cross-gulf) and attribute the single-run count to him**, or leave the count out. Do not print it as established.

**★ Kim's framing is the one to keep: *TwoRed had what is now a rare experience.*** A 2013 crossing that would be difficult or impossible to repeat. **That is a fact the record could never have produced on its own and it dates the whole expedition.**

### ★★★ THE WHITTIER TUNNEL — and it is a DIFFERENT KIND OF FEAR, which is why it belongs

**Verified externally:** the **Anton Anderson Memorial Tunnel**, **2.5 miles**, the longest highway tunnel in North America and a combined vehicle-railroad bore. **One lane, shared by cars and trains travelling in both directions**, so traffic runs in alternating timed openings -- to Whittier on the half hour, from Whittier on the hour. Kim's 2.5 miles and his convoy are both right.

**★★ HE DRAWS THE DISTINCTION HIMSELF AND IT IS THE BEST SENTENCE IN THE ACCOUNT.** *"There were times I was scared due to danger (car eating hole, police car heading at me). But this was not dangerous in that sense. It was a kind of challenge danger; could I drive well enough to get through."* **Two categories of fear, and the record cannot hold either one** -- which is ch.6's argument arriving in a place ch.6 never looked.

**★★ AND THE WORRY IS SPECIFIC TO THIS CAR: *"I wondered if my narrower than average wheelbase would work relative to the train tracks."*** That is a **Smart-car-shaped anxiety**, unavailable to any other vehicle in the tunnel that day, and it belongs to the book's thesis rather than to a travel anecdote. Ch.1 already measures the car; **the track gauge is the one place where being small is a question rather than an advantage.**

**⚠ DO NOT ASSERT WHETHER THE WHEELBASE WAS ACTUALLY A PROBLEM.** He does not say it was; he says he wondered. **The fear is the fact.** Standard gauge is 56.5 in and `twored_manual` gives a front track of 50.5 and rear of 54.5, but a comparison would be MY analysis of a worry he raised, not his account, and it would answer a question the chapter is better off leaving as he left it. **Offer it to him; do not write it.**

---

## ★★★ CH.6's SPINE, RULED BY KIM 2026-08-31 — TWO LAYERS: ENGINEERED UNIFORMITY, NATURAL CHARACTER

> You're right about it not being about the trees. It's the sightlines. That's a big difference. Naming the other places doesn't do any service. I can't blame Alabama's stretch of I-65. That's just their combination of vegetation and topography. What's critical is that driving in a variety of places gives you completely different experiences. Some are better than others. Those differences make the country interesting. If you don't get out and around, you might fall into the "if you've seen one, you've seen them all" mentality. The architects of Interstate system brought a kind of uniformity: excellent highways. That was very important. Nature gives these highways character. It's equally important. So, we can leave I-65 as our example of monotony and skip the other places.

### ★★★ THE CHAPTER IS NOT A TAXONOMY OF ROADS. IT IS AN ARGUMENT FOR VARIETY

**The closing pair is the spine and it is already in his own balanced two-clause form:** *"The architects of the Interstate system brought a kind of uniformity: excellent highways. That was very important. Nature gives these highways character. It's equally important."*

**Two layers, and the chapter needs both.** The engineered layer is uniform BY DESIGN and that uniformity is the achievement -- it is also, quietly, what made a 300-mile day in an 1,800-lb car possible at all, which ties ch.6 back to ch.5's baseline. **The natural layer is what the engineering cannot flatten**, and it is the entire reason one excellent highway is not interchangeable with another.

**★★ AND THE ARGUMENT IS THEME 10, IMMERSION OVER INSULATION, ARRIVING FROM A NEW DIRECTION.** *"If you don't get out and around, you might fall into the 'if you've seen one, you've seen them all' mentality."* The chapter is not complaining about a road. **It is making the case that the variety is the reason to go**, and the tree tunnel earns its place by being the one stretch where the variety is missing.

### ★★ TWO STANDING CONSTRAINTS FROM THIS RULING

1. **ONE example, not a survey. I-65 north in Alabama stands alone.** The candidate list of other stretches (Port Allen->Memphis, Atlanta->Murfreesboro, Charleston->Atlanta, Montgomery->Birmingham) is **CLOSED WON'T DO** -- see `deferred.md`. **This is Theme 13, subtraction, applied by Kim to his own chapter:** a second example adds weight without adding argument.
2. **NO BLAME. Alabama is not at fault and the text must not imply it.** Kim: *"That's just their combination of vegetation and topography."* The tree tunnel is a fact of the place, not a failure of it, and the driver's boredom is a fact about the driver.

### ★ AND THE CORRECTION IS WORTH KEEPING — the category is about SIGHTLINES

Kim accepted the reframing and named it a big difference. **A tree tunnel is not defined by vegetation; it is defined by what the driver can see past it.** Which is why the western counter-case belongs IN the definition rather than after it, and why the project's speed-based taxonomy was structurally unable to reach the category.

### MEASURED TAXONOMY, recomputed 2026-08-31 (median gross mph by trip)

Supersedes the figures in the old `the_roads.qmd` scaffold, which disagreed with the 2026-08-20 list in two places.

| trip | n | median gross mph | median leg |
|---|---|---|---|
| 2016 FallWinter (US-101 coastal) | 4 | **28.3** | 299 |
| 2017 February | 6 | 31.1 | 194 |
| 2013 Arctic | 18 | 31.7 | 253 |
| 2013-4 LA Expedition | 1 | 34.6 | 260 |
| 2012 May Arizona | 7 | 36.9 | 132 |
| 2015 Sedona | 1 | 39.0 | 150 |
| 2014 Penultimate State | 32 | 40.3 | 334 |
| 2011 NorCal | 2 | 40.6 | 306 |
| 2017 January | 3 | 41.2 | 313 |
| 2016 Fourth Crossing | 25 | 41.4 | 303 |
| 2012 Frostburg | 18 | 44.4 | 360 |
| 2011 StLouis | 15 | **47.6** | 339 |

**The two Dalton legs alone: 28.6 out, 22.6 back, median 25.6** -- the scaffold's "Dalton 31.7" was the whole Arctic trip, not the gravel.

**★ The scale separates ROAD ENGINEERING and nothing else.** Gravel and coast at the bottom, plains interstate at the top. **It cannot separate the Deep South from the Appalachians (40.3 vs 38.0, p = 0.42)** -- the two categories this chapter is actually about. *Vigilance has no column; neither does tedium.* **That null is the chapter's hinge, not a gap in it.**

---

## ★★★ TREE TUNNELS — Kim, 2026-08-31, verbatim. The concept, its provenance, and the one stretch he names

_For ch.6 `the_roads.qmd`. The deferred TASK said ask him to name them and do not infer them; this is the answer to that ask._

> I picked up the concept from my nephew who took the train from Siberia to Europe. Much of the route, he said, was through "tree tunnels." He added that there wasn't much to look at outside the train window. The concept stuck. Trees alongside the route block the view. A monotonous wall of green. Trees are important, of course. But when you need visual relief to stay alert, they seem to work against you.
>
> I first got the connection as I drove north on I-65 in Alabama. My definition of a tree tunnel expanded to include the route being nearly straight and nearly flat. This Interstate highway met those conditions. I wondered if the people who take this route as their primary drive have ever seen the contrast with driving in the West. There are certainly highways in the mountain and coastal states that are lined with trees. But these trees are rarely tall enough to hide the landscape beyond. Rolling hills. Sharp peaks. Dramatic ridgelines. The trees and the landscape work together. But that I-65 corridor had none of that. I was stuck on an excellent highway. Two lanes each way with a wide median. Easy driving. But I couldn't wait to get off of it. All the while I wished I could take every driver who's only seen this type of highway out West. It would change their life.

### ★★ THE DEFINITION IS A CONJUNCTION, NOT A DESCRIPTION OF TREES

Three conditions, and all three are required: **trees tall enough and close enough to BLOCK THE VIEW; nearly straight; nearly flat.** The western counter-case is the test that proves it -- those roads are also tree-lined, and they are not tree tunnels, because the trees *"are rarely tall enough to hide the landscape beyond"* and so **the trees and the landscape work together.** ★ **It is not a category about vegetation. It is a category about what the driver can see past it**, which is why the project's speed-based taxonomy cannot reach it.

**★★ THE PROVENANCE IS NOT AMERICAN AND NOT A ROAD.** The term came from his nephew describing the **train from Siberia to Europe** -- so a concept formed on the Trans-Siberian, on rails, gets carried to an Alabama interstate and fits. Worth keeping in the writing: it is the strongest evidence that the category is real and not a rationalisation of one bad afternoon.

**★ AND THE TENSION IS HIS OWN, WHICH IS WHY IT LANDS.** *"Trees are important, of course. But when you need visual relief to stay alert, they seem to work against you."* **A botanist writing about trees as an obstacle.** Do not smooth that out.

**★★ THE COMPLAINT IS NOT ABOUT ROAD QUALITY, AND HE SAYS SO EXPLICITLY.** *"I was stuck on an excellent highway. Two lanes each way with a wide median. Easy driving. But I couldn't wait to get off of it."* **That sentence is the chapter's argument in miniature: every measurable quality of that road is good, and the experience is bad.** It is the same shape as the Canadian Plains non-result and the Deep South / Appalachian null (40.3 vs 38.0, p = 0.42) -- *vigilance has no column; neither does tedium.*

### ★★★ THE STRETCH IS IN THE RECORD AND IT IS DATED

**I-65 northbound in Alabama = 2014-05-07 and 2014-05-08, on the Penultimate State expedition.** The fills place it exactly:

| date | fill | odo | tank miles | mpg |
|---|---|---|---|---|
| 2014-05-07 | New Orleans LA | 42,827 | 274 | 41.62 |
| 2014-05-07 | **Atmore AL** (I-65 exit 57) | 43,037 | 210 | 40.26 |
| 2014-05-08 | **Trussville AL** (Birmingham) | 43,266 | **229** | **33.67** |
| 2014-05-08 | Madisonville TN (the Appalachian climb) | 43,462 | 196 | **42.49** |

**The Atmore -> Trussville tank is almost purely the tree tunnel.** Atmore to Birmingham is I-65 the whole way, with the Montgomery overnight sitting inside the tank. **It reads 33.67 mpg, the lowest of the eight fills that week, against a lifetime mean of 39.53** -- and the very next tank, climbing into the mountains he had been waiting for, reads **42.49.**

**⚠ DO NOT PRINT THIS AS A FINDING.** It is one pair of tanks, temperature and speed are uncontrolled, and it sits inside the ~3 MPG southern deficit already ruled a SIGNAL THAT CANNOT BE SETTLED (`deferred.md`) -- **the sample is closed at 30 because Creamsicle has zero southern fills.** What the pair is good for is **illustration of the mechanism already hypothesised there:** flat straight divided highway invites steady high speed, and drag costs an 1,800-lb car more than hills do. **The road he could not wait to get off is the road the car worked hardest on, and the mountains he was longing for gave it back.** Write that as a nice coincidence in the record, explicitly not as evidence.

**⚠ ALSO: no 2014 fill times exist in `TwoRed_fuel_timetemp.csv`** (1 row for the whole year), so the within-day clock is unavailable for these two days. Same gap as the deferred TASK.

---

## ★★★ THE CALIBRATION PROBLEM AND THE LOGISTICS PARTNERSHIP — Kim, 2026-08-31, verbatim

_Registered before ch.6. This is not a long-day story; it is the missing account of **why the trip log exists at all**, and it names a second person's role that the record has been carrying without a label._

> Living in Hawaii, we obviously don't do much long distance driving. Except when we go other places. Then we might do a long drive. In our case, for years, our mainland "long" driving seemed to be along a single route: From LAX to LSM. Each way, exactly 100 miles from where we picked up the rental car to my mother's parking spot. Not exactly a long drive by mainland standards. When we got TwoRed and decided to take a long trip, we didn't know how far we could drive in a day. We didn't have any relevant experience. We looked at Smart car on-line discussions to get guidance, but the reported long trips were usually done by two drivers sharing the task. And for them, there was usually a distinct target destination that justified a very long day on the road. That wasn't going to be us. Single driver. A very long distance to the final destination. Avoid night driving. The same for rush hour traffic around an unfamiliar city. We had to learn on the fly, so to speak.
>
> And that made for an interesting situation. Much of the driving was solo, with Kim in the car and Nancy back in Honolulu, busy at work. Thanks to GPS and an ability to track another person, Nancy could see where Kim was at any time. As any particular day began to show the limits of driving, Nancy would scout ahead using the Internet. She'd find a place to stay, make a reservation, and then locate an appropriate restaurant that would be walking distance from the hotel or motel. It was long distance (very long distance) teamwork. Kim could focus on the driving and know there was a good stop ahead. It was an interesting and innovative use of emerging technology.
>
> Eventually, when Nancy was always on-board for the drives, the pattern persisted as Nancy would evaluate how much farther we would travel, then use the Internet, like before, to reserve a place for the night. That's a role that extends well beyond that of navigation. Think: logistics.

### ★★★ THE STATED RULES ARE VISIBLE IN THE RECORD AS A SHAPE

*Avoid night driving. Avoid rush hour around an unfamiliar city.* Those are falsifiable, and the log was not kept to score them.

**134 legs carry an arrival time. The median arrival is 16:12 and the 90th percentile is 18:55. The median departure is 08:11 and the LATEST departure in six years is 13:26.** Fourteen legs arrive after 19:00 and six after 20:00.

**★★ AND EVERY ONE OF THE SIX HAS A NAME.** Three are **Alaska and the Yukon in August**, where 21:00 is broad daylight and the rule is not violated at all (Coldfoot->Ester 21:03 on the Dalton, Destruction Bay->Ester, and the day off the Alaska ferry). One is **North Sydney NS 21:00, a ferry terminal with a boat to catch.** One is **St George 21:36, the Las Vegas break.** One is **Paso Robles 22:10, his mother.** The seventh-latest, Youngtown 20:41, is the leg whose arrival time is itself disputed.

**The rule is not stated anywhere in the log and it did not need to be. It is in the distribution.**

### ★★★ AND THERE IS NO LEARNING CURVE, WHICH IS THE FINDING

The obvious prediction from *we didn't know how far we could drive in a day* is that the days get longer as they learn. **They do not.**

| | n | median leg |
|---|---|---|
| first three logged trips (2011-05 to 2012-05) | 28 | 301 mi |
| everything after | 109 | 305 mi |

Wilcoxon **p = 0.44**. Trip medians run 305, 339, 132, 360, 253, 260, 334, 150, 303, 299, 313, 194, and the low ones are the short local trips, not early ones.

**★★ THE CALIBRATION HAPPENED ON THE 2010 CROSSING, WHICH HAS NO TRIP LOG.** The log opens in May 2011, a year after the driving started, and **it opens already knowing the answer.** So the record is not a search. It is a constant, and the constant is about 300 miles.

**★★★ WHICH REFRAMES WHAT SET THE DAY LENGTH.** It was never stamina, and the flatness is the evidence: an 84-year-old's day and a 68-year-old's day are the same length. **The four rules set it** -- one driver, no night driving, no unfamiliar rush hour, and a reservation someone had to be able to make -- and four constraints produce a 300-mile day immediately and forever. **A long day is therefore not a hard day. It is a day one of the four rules was suspended for**, which is exactly what ch.5 found from the other end without knowing this.

### ★★ NANCY'S ROLE IS A THIRD INSTRUMENT AND IT HAS NO COLUMN

The end city of a day was **chosen in real time, remotely, by someone watching a GPS track from 2,500 miles away.** The record shows the outcome (an arrival city, an arrival time) and nothing about the decision, so this joins the standing list of things the log holds the shadow of: the reason, the road character, the driver's experience, and now **the choosing.**

**Do not write this as "navigation."** Kim's own word is logistics, and the distinction is his: a navigator works inside the drive; this worked ahead of it, and it worked when she was not in the car at all.

**⚠ AND IT DATES ITSELF.** Consumer person-tracking and same-day online booking from a phone were new in 2010-2014. The arrangement is period-specific and worth writing as such, but **the specific apps and services are NOT in the record and must not be invented.** Ask Kim what he actually used.

---

## COLLECTED STORIES — Kim's accounts of the long days, verbatim (opened 2026-08-19)

### KIM KILLS AN ANALYSIS AND REPLACES IT WITH A BETTER ARGUMENT (2026-08-24)

> Doing a rental vs purchase/maintenance/insurance is **a futile exercise**. Instead, consider that
> there is something about driving your own car that resonates... **You build muscle memory.** And
> when you're going down a crowded LA freeway, that's a nice thing to have. -- Kim

**The scaffold item "economics as a COUNT, not a cost" is retired**, and not because the numbers
failed. Because the question was wrong. **An analysis can be sound and still not be the reason for
anything** -- worth remembering the next time a comparison looks available.

What replaces it, as `## Why not just rent one?`, closing chapter 3:

- the small practical part: *"A car you keep is, in a small way, a cupboard you can park."*
  (the big tripod and the heavy coat -- and the tripod is the **photography thread** surfacing again)
- **the real part: familiarity is a safety property.** Not just knowing how to work the car ("not
  hunting for the defroster while the windshield fogs over") but knowing how it drives.

**★★ THIS COMPLETES A TRIO THE BOOK BUILT WITHOUT PLANNING TO.** Chapter 2: *small and nimble are
components of safety*; then *attention is a component of safety too*. Chapter 3 now adds the third,
and the closing move is what makes it more than a list:

> **Familiarity is the third, and it is the only one of the three you cannot buy on the day you
> need it.** It accumulates, slowly, in one particular car -- which means it accumulates only if
> that car is waiting somewhere for you to come back to it. **Which is what the parking spaces
> were for.**

So the chapter's two halves join: the parking history is not logistics, and it is not sentiment
either. **A kept car is a known car, and knowing it is a safety property that only a parking space
can produce.** Chapter 3 ends on the same argument chapter 2 opened with, arrived at from the
opposite direction.

Chapter 3: **3,140 words, seven sections.** Callback verified against the actual chapter 2 headings.

### ★★ THE TORRANCE GARAGE, AND A CAR STATIONED BEFORE THE NEED ARRIVED (Kim, 2026-08-24)

> Nancy's cousin, living in Torrance, California, sort of had a spot for a small car. The problem
> was the space was filled with "stuff."... **She said that if we would help with the cleaning, we
> could use the spot.** ... **A practical necessity, a place to park a car, became a way to
> strengthen some family bonds.** ... The LSM pattern repeated. For the same reason. With the same
> result. -- Kim

**THE DESIGN RULE COMPLETES ITSELF HERE.** At LSM and Eugene the criterion was *minimal
inconvenience to the person providing the space*. Torrance goes past that to a **net benefit** --
she got a job done she had been putting off. That is why the arrangements lasted, and it is the
reason the parking history is a story about people rather than about logistics.

**AND THE SAME SECOND-ORDER EFFECT, TWICE.** At LSM the car was a standing message to his mother.
At Torrance the space became a social conduit -- the cousin, distant relatives across the region,
friends -- **and it has outlasted the car**, which went to Wisconsin and never came back. Kim:
*"The car became the link."* **Both ports produced a relationship the car was not bought for.**

**★★★ THE RECORD SHOWS THE PARKING COMING FIRST, LITERALLY.** Bought in Missouri 2021-09-15,
collected at Nixa 09-23 at odometer 30,290. Then driven **1,987 miles WEST to Torrance** --
away from Wisconsin, away from the thing it had been bought for -- arriving 09-28. **17 days**
in the garage while they flew home to Hawaii. Then back, and **2,217 miles EAST** to the first
Wisconsin fill on 10-22.

**And the need was still conditional when they bought it** (*"if he needed our offer"*). A car,
bought and stationed on the mainland, standing by for something that might not happen. Chapter 3
closes the section: *"That is not a strange way to own a car. It is the only way we ever owned one."*

Kim's "about four months" checks out: purchase to last Wisconsin fill is **4.1 months**.

**NAMING RULED:** no name for the niece or the St Louis car wash. The standing rule is now
complete -- **institutions with a public face may be named; individuals and small private firms
may not.** Towns stay (Mentone, Torrance).

Chapter 3 now runs **2,840 words in six sections.**

### CHAPTER 3 DRAFTED THROUGH (2026-08-24) -- 2,245 words, five sections

Order: **A stall that came free** (the human case) -> **What counts as a trip** (the definition) ->
**The shape of sixteen years, on one picture** (`@fig-regimes`) -> **What happens when the space
goes** -> **The one time it was actually parked**. Story, then method, then picture, then
consequence, then the exception that proves the definition.

**The chapter now sets up and pays off its own central number.** Section 1 ends *"Hold on to that,
because a number later in this chapter depends on it."* The chart section closes: *"A couple of
miles a day is what visiting your mother looks like, measured with an odometer."* **The 2.6 mi/day
stops being evidence about a definition and becomes the thing it was all along.**

**MOBOT resolves the St Louis discrepancy** (Kim confirmed): several days working at the Missouri
Botanical Garden, driving garden-to-hotel-to-meals, THEN the car wash garage, then the flight home.
So the 217 miles are real and precede the parking. The chapter says so, and draws the conclusion:
**the one genuinely stationary period in sixteen years is hidden twice** -- by the odometer, which
cannot tell stillness from motion after the fact, and by the definition, which files the whole
fortnight under travel.

**Botanical gardens are a through-line, not a detail.** MOBOT in 2011; the Flower Fields at
Carlsbad and four gardens across the LA basin for Creamsicle; hummingbirds at a garden in the
website stories. **Worth tracking as a thread** -- it is the recurring purpose behind excursions
in both cars.

⚠ **TWO RELOCATION FIGURES, both correct, different instruments.** 4,592 miles from the fuel log
(2016-09-22 fill onward); **4,638 from the trip log** (2016_FallWinter start, odo 66,645, to the
dock at 71,283). **The chapter prints 4,638**, computed inline, because chapter 3 takes its
boundaries from the trip log throughout. Earlier log entries and the Active Focus say 4,592.

### ★★★ THE STALL, AND WHY THE ERRANDS WERE THE POINT (Kim, 2026-08-24)

> She kept a car in her stall even after she had given up driving. That car, appropriately, went
> to my brother. **It left the stall open.** This was one of the few empty stalls among the
> hundreds that ringed the facility... And having our car there would mean a lot to us. Not just
> the convenience and likely cost saving. **But a continuing symbol for my mother; the car meant
> we'd be back.** Probably sooner rather than later. **Having an unusual car would reinforce this;
> she would recognize it every time she passed by.** ... The visits, when we used the car to run
> errands, weren't just haphazard. We supplied things, some essential but mostly treats, by
> buzzing around the neighboring area. **Mom never let us be gone long. These were her times with
> us.** -- Kim

**THIS RECONTEXTUALISES THE CENTRAL NUMBER OF THE CHAPTER.** The 2.6 miles a day I computed as
proof that "on station" is not stationary is not a residual, and it is not errand overhead.
**It is the visits.** Short by design, because she did not let them be long. The chapter can now
say what those miles were, and the measurement and the meaning arrive in the same sentence.

**The stall's provenance is a chain of small facts that produced 71,000 miles:** the apartment
came with a stall; she kept a car in it after she stopped driving; that car went to his brother;
the stall stayed empty; empty stalls in that area are rare. **A car was cheap to keep only because
somebody else had already stopped needing the space.**

**THE DESIGN RULE FOR EVERY PORT, in Kim's words:** *"What we needed was a place that would be a
minimal inconvenience for the person providing a space."* That is the criterion behind Mentone,
Eugene, Torrance and the car wash, and it should be stated once and then left to do its work.

**Eugene was accepted as a downgrade, knowingly:** short visits would mean renting in SoCal again,
*"That's OK as TwoRed had served its purpose well."* Then one more SoCal run when his mother's
health fell away steeply -- car out of storage, driven fast, and kept there through her final days
and the wrapping up. ⚠ Handle per the standing note: **adjacent facts, separate causes.**

**THE ST LOUIS CAR WASH -- the one true parking event, and the record cannot see it.**
Kim: two mainland meetings, fly home to Hawaii between them, so leave the car near the airport
rather than drive back to LSM. A car wash in a former large gas station: small wash, big empty
mechanics' garage. *"The owner was amused with my suggestion... in the end, gave me a car wash."*
*"Would I do that again? Maybe not. But at the time, I had no obvious alternative."*

The trip log has it: **a 9-day hole inside 2011_StLouis, 2011-07-05 to 2011-07-14**, car left at
St Louis (Fenton) MO and resumed from St Louis MO. **But the odometer runs 16,516 -> 16,733 =
217 miles across it, 24.1 mi/day** -- squarely in the on-station band. **The one period in sixteen
years that was genuinely parked in the ordinary sense reads, in the record, as ordinary local
driving.** And because it sits INSIDE a trip it never becomes a between-trip interval, so it is
not on `@fig-regimes` at all. **The exception is hidden twice over: once by the odometer and once
by the definition.**

⚠ **OPEN:** a fuel fill at University City MO on 2011-07-12, odometer 16,703 -- 196 of those 217
miles fall between arrival and that fill. If the car was garaged from 7/5, where did they come
from? Likely the car was driven around St Louis for some days BEFORE being parked. **ASK KIM;
do not write the passage until he says.**

### CHAPTER 3 HAS ITS FIRST PROSE, BUILT AROUND THE REGIME CHART (2026-08-24)

748 words in `the_anchor.qmd`, two sections: **`## What counts as a trip`** and
**`## The shape of sixteen years, on one picture`**. The scaffold is preserved beneath, trimmed
to what is still unwritten.

**The explanation strategy Kim approved: do not explain the chart. Ask a question, then walk the
reader across it.** Question first (*what is a trip?*), one sentence on the axes, then the single
sentence that unlocks the field ", a diagonal is a line of constant pace ", and only then four
observations, ordered by how much they surprised me.

The four beats: the clouds do not touch (no trip under 20 mi/day, only 5 intervals over it);
those 5 strays are unlogged crossings, so **the record is telling you where it failed to keep
itself**; Wisconsin alone in the gap; and last, **the empty floor** ", nothing below one mile a
day, in twenty years of calendar across two cars.

**Ending on the absence is the whole rhetorical move.** *"That empty region is where parked would
live, if the word meant what people take it to mean. It has no points in it, because that is not
what the cars were doing."* The operational-definition argument delivered as a picture rather than
a claim.

**Kim's own reading of the chart checked out on all four counts** ", TwoRed took the big trips
(5 of hers beat Creamsicle's largest), both cars did middling ones (Creamsicle more of them: 11
to 6), TwoRed held the longest intervals (414 days vs 260), and Creamsicle drove more in the
short ones (34.7 vs 18.0 mi/day). **The fourth is the fragile one and I told him so:** her short
intervals run 7-17 days and one hits 82.6 mi/day, which is almost certainly a real trip that my
7-day gap rule cut in half. **The derived definition manufacturing a pattern the measured one
cannot** ", exactly where the asymmetry was predicted to bite.

New files: `book/R/regimes_data.R` (one row per span, both cars, with the asymmetry documented in
the header), `book/R/fig_regimes.R`, `data/regimes_points.csv`, `book/figures/regimes.png`.

⚠ **I overwrote the scaffold when writing the chapter and had to restore it from context.**
Nothing was lost, but the near-miss is the lesson: **a scaffold is content. Append prose above it;
never rebuild a file from scratch while it still holds unwritten material.**

### ★★ A TRIP IS WHAT HE DECIDED TO RECORD (Kim, 2026-08-24)

> A trip consists of a multi-day affair in addition to a lot of miles. **When those two
> characteristics were present, we did the log recording.** So, I guess that a Creamsicle trip is
> actually operationally defined by a multi-day, long distance drive **that is recorded in the log.**

**The circularity is the honest part and it should be stated in the book.** The criteria -- multi-day,
long distance -- are the rule he applied at the time; the log is the record of the decision.
**So "trip" has perfect precision and unknown recall.** Everything in the log is a trip. Whether
everything that met the criteria got in is a separate question, and for TwoRed the answer is no.

**COVERAGE MEASURED:**

| | logged legs | lifetime | in the trip log |
|---|---|---|---|
| TwoRed | 41,163 | 71,279 | **58%** |
| Creamsicle | 22,723 | 28,697 | **79%** |
| both | 63,886 | 99,976 | **64%** |

**36,090 miles -- 36% of both cars' lives -- are outside the trip logs entirely.**

⚠ **Do not read 58% vs 79% as "TwoRed did more excursions".** TwoRed has 12,371 miles of clearly
out-of-state travel in three gaps nobody logged. Net of those, the non-trip driving is ~7.1 mi/day
for TwoRed and ~5.3 for Creamsicle -- much closer. **The gap is mostly recording behaviour, not
driving behaviour.**

**THE TWO INSTRUMENTS HAVE COMPLEMENTARY BLINDNESS**, which is the summary chapter 13 needs:
**the fuel log sees every mile and no purpose; the trip log sees purpose but only 64% of the miles.**

**FOUR PORTS, FOUR CHEAP-FUEL STOPS** -- LSM (station beside the spot), Signal Hill (Costco two
blocks from the shop), Sun Prairie (Costco, brother's house between it and Madison), **Torrance
(garage, Costco ~3 miles away -- confirmed by Kim as the SoCal home port, and my inference from
8 of 51 fills).** So fill clusters DO mark the home ports -- **by way of fuel price, not position.**
The inference survives; the reason must be stated rather than assumed.

### EXCURSIONS -- AND WHY CREAMSICLE'S ARE HARDER TO SEE THAN TwoRED'S (Kim, 2026-08-24)

> Some of the SoCal travel was to Carlsbad to view Flower Fields. Many other trips were across the
> LA basin to visit the four botanical gardens that we try to regularly see, particularly the
> Huntington Garden. **Those drives are not "trips" but local excursions, much as replenishing
> mom's supplies were earlier excursions.** ... Costco (think: cheap gas) is in Sun Prairie and
> Nancy's brother's house was sort of between Madison and this gas stop. -- Kim

**"EXCURSION" IS A BETTER CATEGORY THAN MY ERRAND/SERVICE SPLIT**, because it is defined by shape
-- a day out and back from the home port -- and not by motive. It unifies the two cars: fetching
his mother's supplies and driving to the Huntington are the same *kind* of driving. Purpose
differs; form does not. **Three kinds now: trip, excursion, errand.** "On station" and "standing
by" describe the STATE; excursions are what happens during it.

**THE COSTCO POINT CHECKED, AND IT SURVIVES.** Wisconsin fills sit **136 miles apart (median),
every 5-7 days** -- far beyond a fuel run. So Costco explains *where* he filled, not *how far* he
drove; the 18.3 mi/day of Wisconsin service driving stands. **But it does damage something else:
11 of 14 Wisconsin fills are Sun Prairie because the gas was cheap there.** A fill location is a
PRICE DECISION, not a position report. That partly undercuts my LSM-cluster mapping -- which
survives only because Kim confirmed the LSM station was beside the parking spot.

**★★ AND THE MEASUREMENT PROBLEM IS WORSE FOR CREAMSICLE THAN FOR TwoRED.**

At Lake San Marcos the invisible driving was a few miles at a time -- **too small to see**, so it
was absorbed into the next long leg. In the LA basin an excursion is a crossing of the basin:
post-Wisconsin California legs run **104 to 237 miles, median 168**. A garden day is the same size
as a travel leg. **So Creamsicle's excursions do not hide beneath the resolution -- they
masquerade as travel.** Absence below the noise floor is one problem; a confusable signal is a
harder one, and no threshold fixes it. **Only the narrative separates them.** Chapter 13.

**Torrance is the top post-Wisconsin California fill city (8 of 51)** -- the others are almost all
singletons on travel routes. Plausibly the SoCal home port. **ASK KIM.**

### ★★★ TWENTY-FOUR MILES SHORT OF A HUNDRED THOUSAND (2026-08-24)

**Kim: "Did you look at Creamsicle_trip_clean.csv?"** I had -- as `cream_legs`, for its legs --
and had missed the two rows that carry no miles at all: **`Start Mileage 30290.0` (2021-09-23)**
and **`Final Mileage 58987.0` (2024-10-20)**. Odometer stamps, sitting in the city/state columns.

They change the headline number of chapter 2.

| | fuel log | odometer | missed |
|---|---|---|---|
| TwoRed | 71,177 | **71,279** | 102 |
| Creamsicle | 28,613 | **28,697** | 84 |
| total | 99,790 | **99,976** | **186** |

**The two odometers stop 24 miles short of a hundred thousand.**

**And the 186 miles the fuel record misses are not random.** TwoRed's last fill was 102 miles
short of the Matson terminal; Creamsicle's was 84 miles short of the handover. **Each car's final
journey is precisely the one its fuel log cannot see** -- the drive to the ship and the drive to
the new owner. Finding 041 for the fourth time: *a fill is a transaction, not a state.*

Chapter 2 now reads: *"Add the two odometers together and they stop `r short` miles short of a
hundred thousand. That is not a rounded figure, and it is not the fuel log's figure either -- a
fill is a transaction, not the end of a life, and the last drive each car ever made is one neither
fuel log can see."* Guard updated to `tw + cs == 99976, short == 24`; the table caption now says
the trip logs supply the boundaries.

**How close this came to being wrong.** The chapter said *"Over a hundred thousand documented
miles"* until 2026-08-22. On the fuel figures that was false by 210 miles. On the true figures it
is false by 24. **A claim can be wrong, get corrected, and still be wrong for a different reason** --
and the only thing that caught it was Kim asking whether I had actually read a file I had loaded.

⚠ Creamsicle's Final Mileage is stamped 2024-10-20 while the handover photograph is 2024-10-22.
Any miles driven on those two days are outside the record. The text says the odometers *stop* 24
miles short, which is exactly true of the record and makes no claim about the car.

### ★★★ "ON STATION" vs "STANDING BY" -- THE RECORD SEES THE CHANGE BUT NOT THE PURPOSE (2026-08-24)

**Kim proposes two terms:** *on station* = parked and in service of a person (TwoRed at LSM for his
mother; Creamsicle in Wisconsin); *standing by* = parked and waiting for the next long trip
(Creamsicle in SoCal, after Wisconsin, for pleasure travel). **A conceptual distinction that can be
tested**, because service driving should leave miles on the odometer and waiting should not.

Tested on between-trip intervals of 60+ days, odometer read from the fuel log at each boundary:

| | days | miles | mi/day |
|---|---|---|---|
| Creamsicle, Wisconsin | 90 | 1,646 | **18.3** |
| Creamsicle, after Wisconsin | 882 | 2,849 | **3.2** |
| TwoRed, on station at LSM | 374 | 962 | **2.6** |
| (on a trip, either car) | | | **~230** |

**HALF CONFIRMED, AND THE HALF THAT FAILS IS THE INTERESTING ONE.**

1. **Wisconsin is unmistakable: 18.3 mi/day, 7x TwoRed's on-station rate.** Kim described doctor
   visits and food shopping there; Sun Prairie to Madison is a far longer errand than anything
   around Lake San Marcos. **The record corroborates the intensity of that service independently.**
2. **But on-station and standing-by are NOT separable by rate: 2.6 vs 3.2 mi/day.** A car waiting
   to help someone and a car waiting for a holiday look identical to an odometer.

**So the instrument can see WHEN the job changed, and never WHY.** The rate drops 5.7x when
Creamsicle leaves Wisconsin -- the change of function is measurable even though the function is not.
**That is the exact boundary between the data layer and the testimony layer**, drawn by the data
itself, and it is the strongest argument yet for Kim's three-layer architecture.

**THREE REGIMES, NOT TWO** -- and Wisconsin is the middle one, which neither of us predicted:
~3 mi/day (waiting) -> ~18 (intensive local service) -> ~230 (travelling). The graphic should show
three, and the ambiguous short intervals besides.

**Adopt both terms**, with the text stating plainly that the distinction between them is testimony
rather than measurement -- except at Wisconsin, where it is both.

⚠ Method caveat: Creamsicle has **no trip log boundaries and no odometers in her leg table**; trips
are DERIVED from a 7-day date-gap rule and odometers borrowed from the fuel log. Intervals shorter
than 60 days are contaminated by driving the rule failed to catch (one 7-day "interval" runs at
82.6 mi/day). **A derived definition wearing the same word as a measured one -- label it in the text.**

### ★★★ "ON STATION" IS AN OPERATIONAL DEFINITION, AND IT NEEDED THE OTHER LOG (2026-08-24)

**Kim: "It is the trip log that defines when a trip begins and ends... For the 'on station'
definition to work, it must be based on the trip log, not the fuel log."** He is right, and I had
been arguing about operational definitions while using the wrong instrument. Every "parked period"
I had computed was a gap between *fuel purchases*.

**THE DEFINITION.** On station = the interval between the last leg of one logged trip and the
first leg of the next, **with the odometer used to confirm no travel happened inside it.** The
validity check is part of the definition, which is the whole point.

`twored_legs` gives **13 logged trips, 139 legs, 190 trip-days, 43,624 miles (61% of lifetime).**
Twelve intervals sit between them. Sorting by miles accrued:

- **5 clean on-station intervals** (<300 mi): 44, 15, 111, 100, 104 days.
- **4 ambiguous** (300-1500 mi) -- probably short unlogged runs.
- **3 that must contain trips nobody wrote down** (>1500 mi): 5,408 / 4,789 / 2,174 miles.

**THE NUMBER THAT MAKES THE CHAPTER:**

| | days | miles | per day |
|---|---|---|---|
| on station | 374 | 962 | **2.6** |
| on a trip | 190 | 43,624 | **230** |

**89 to 1.** And 2.6 miles a day is not zero -- **"on station" is emphatically not stationary.**
That is precisely the errand driving Kim described at Lake San Marcos: fetching things for his
mother, a couple of miles at a time. **The car moved on most days. It just did not go anywhere.**
The fuel log could never have shown this; the odometer between trip logs shows it exactly.

**THE THRESHOLD IS A CHOICE AND THE BOOK MUST SAY SO.** 300 miles is my line, not a fact. Four
intervals sit in the ambiguous band. Reporting all three bands rather than a clean binary is the
honest form -- and it is the operational-definition lesson demonstrating itself.

**Consequence for the graphic:** this is not one right-skewed distribution. It is **two regimes**,
and the axis is miles per day between trip-log boundaries, not days between fills.

**Kim also wants the concept named explicitly somewhere.** Chapter 1 has the width and depth
cases; chapter 3 has this one; chapter 9 generalises. And **"on station" is adopted** as the term.

### THE BOOT IS MEASURED, AND THE VOLUME IS DELIBERATELY ABSENT (2026-08-24)

Kim measured TwoRed with a tape: **41 in wide, 27 in high, 24 in deep** -- depth taken back to the
driver's seat *in the position he drives in*. The pasted figures are retired
(27.5 x 39.5-41 x 21-23 in; 7.8 / 12 cu ft): no source, and **their depth was an inch short of
what he measures**, because they were describing the opening and he was describing what fits.

**That is the mirror-width finding for the second time in one chapter.** Two measurements of the
same object disagreeing because they answer different questions -- published width across folded
mirrors vs the carrier's body measurement, and now published depth vs usable depth. **Worth
watching for a third; two is a coincidence, three is a section.**

**NO VOLUME IS RECORDED, on Kim's reasoning, and it is better than mine.** I offered a bounding
box (41 x 27 x 24 = 15.4 cu ft, 28% above the pasted "to the roof" figure). He rejected the whole
idea: *"the volume is meaningless because if you fill it, you can't see out the back."*
**The binding constraint was never cubic feet. It was the rear-view mirror.** The chapter now says
so: *"I could multiply those together and give you a volume. It would be a useless number... the
limit was never how much will go in. It is how much will go in and still leave the mirror working."*

**COSTCO REWRITTEN FOR RECOGNITION.** Was: "a full cart, top rack and bottom, paper goods and
all". Now the specific awkward object -- *the bundle of toilet paper, the bundle of paper towels,
both in the same trip if that is the week* -- because Kim's point is that **he never hesitates over
the big item**, and a reader knows exactly what that bundle looks like in a trolley. A category
("paper goods") asks the reader to imagine; **a specific object lets them remember.**

`boot_dim` in `book_setup.R` is now three measured numbers and a note on what the depth is
measured to. Chapter 1: 2,468 words.

### ★★★ THE POINT OF THE CAR WAS HAVING IT THERE (Kim, 2026-08-22) -- CHAPTER 3 REFRAMED

> **Having a car at the right location was the point of having the car. It wasn't that we wanted
> to drive. The drives were an additional feature.** ... A parked car had value as peace of mind.
> ... The car was like insurance; it was there if it was needed. ... We could mobilize quickly, if
> needed, and get to the car. -- Kim

**This is not "parking as hidden infrastructure". It is bigger.** The chapter's claim is that the
function of the car was *location*, and driving was the by-product. In a book about 100,000 miles,
the central chapter says the miles were not the point. **The dormancy statistic stops being a
curiosity and becomes the thesis: a parked car was doing its job.**

225 logged driving days out of 2,495 -- **91% of TwoRed's mainland life it did not move.**
Creamsicle: 89%. Two cars, two home ports, the same function. The Foreword already says *"parked,
in that spot, waiting"* -- it was closer to right than I knew when I wrote it.

**THE LAST EIGHT MONTHS ARE THE ARGUMENT IN MINIATURE, AND THEY ARE DATED.**

| | | miles |
|---|---|---|
| 2016-09-22 -> 09-27 | SoCal to Oregon, the relocation | 1,102 |
| 2016-12-29 -> 2017-01-07 | Oregon back to SoCal, to help | 982 |
| 2017-02-02 -> 02-06 | SoCal to Oregon again | 558 |
| 2017-05-20 -> 05-22 | Oregon to the Seattle dock | 232 |

**4,592 miles -- 6% of the car's entire mainland life -- in eight months, and not one of those
miles was travel.** Every one was generated by the car being in the wrong place after the LSM
space was lost. Two round trips between Oregon and Southern California. **The chapter does not
need to argue its thesis; it can just print this table.**

And the dates corroborate the earlier account exactly: his mother moved out of the LSM facility
in **August 2016**; the car went north on **2016-09-22**.

**KIM'S CORRECTION TO MY GEOGRAPHY, ACCEPTED:** San Marcos, Lake San Marcos and Carlsbad are one
place -- the covered spot and its nearby filling stations. So the 19 long stops collapse into a
single anchor, and Barstow / Yuma / Parker are simply the last drink before arriving at it.
**A fuel log marks where a car drank, never where it slept.**

**THE SEQUENCE OF PORTS:** LSM (mother's covered spot; TwoRed sat there *under a cover* while they
were in Hawaii) -> space lost when she sold the apartment -> **Mentone briefly** -> **Eugene** ->
the realisation that Eugene was too far from her to be useful, so drive back down -> **a motel in
SoCal** -> the dock. Photos of the covered spot exist: `2010_TwoRed_covered.jpg`,
`2016_TwoRed_at_LSM.jpg`, `2016_TwoRed_in_San_Marcos.jpg`.

**THE SHIFT, AND THE ENDING.** Only late in Creamsicle's life, with nobody needing attention, did
travel become the primary reason for the car -- *"and that ended when another person needed the
car more than we did."* Then the closing beat, which was not available until tonight:

> **TwoRed is the backup for Bordeaux.** We consider having an ICE car, which can store a lot of
> fuel, as a desirable companion to Bordeaux which gets only short runs on its battery. If we
> lose power in the city, TwoRed will get us around after Bordeaux's charge is depleted.
> *(written days after a major tropical storm knocked out power across the island)*

**Sixteen years later the car is still insurance.** That is the Afterword's last line.

### ★★★ THE WIDE-TIRE DEBT IS PAID, BY PRINTING THE INSTABILITY (2026-08-22)

**Kim chose option two: make the instability the finding.** *"It is cleaner and keeps the tone of
the book."* The `NUMBER NOT YET PRINTABLE` comment is gone from `is_it_safe.qmd`, and with it the
sentence that described a confidence interval the chapter declined to show.

**The specification is now the chunk.** `#| label: wheels` carries the exclusion rule, the four
models and the table. Nothing is typed; the numbers are whatever the code produces at render, so
the reproducibility problem that blocked this for four days is dissolved rather than solved --
**the book cannot disagree with itself, because the book is the run.**

Today, from 271 fill-ups (52 narrow / 219 wide, winter-tire interval excluded):

| how the question is asked | effect |
|---|---|
| raw difference | +1.8% [-3.2, +6.9] |
| controlling for leg length | +3.8% [-1.1, +8.7] |
| leg length and odometer trend | -1.0% [-7.5, +5.6] |
| local window +/-12,000 mi | -1.7% [-6.4, +3.1] |

**+ + - -.** Close to the 2026-08-18 run (+1.7, +3.6, +1.6, -1.8) and confirming its conclusion,
which the 2026-08-20 run had obscured. The sign flips; every interval spans zero.

The chapter now says why: **52 rows against 219, and the 52 are not a sample of ordinary driving
-- they are the car's first ten months, one crossing, one season, one part of the country.**
And the line that makes it a lesson rather than a shrug: *"I could have picked one. Any single
row of that table, printed on its own, would have looked like an answer. That is exactly why the
table is here instead."*

Retained, because the table does support it: **a large effect is ruled out.** Nothing is
consistent with a ten per cent cost.

**Also dropped: the unsourced "usually put somewhere between one and three per cent."** A theory
range with no citation, in the paragraph arguing for evidentiary discipline. Now the directional
claim only -- the effect ought to be small, and it ought to be there.

**Chapter 2 stands at 3,260 words and Kim has passed it.** Chapter 1 at 2,416.

### CHAPTER 1 GAINS ITS MISSING ANSWER; A SPEC IS REJECTED ON GOOD GROUNDS (2026-08-22)

**Kim rejected the turning circle**, and the reasoning generalises: *"When you use this tight
radius, you're going very, very slowly (think: parking lot)."* Chapter 2 is about highway
hazards; a turning circle is exercised in car parks. **A specification earns its place only if it
operates in the situation under discussion.** I had reached for it because it was sourced and
available -- which is not the same as relevant.

**Caption error caught by Kim:** `@fig-day-one` said "I'm six feet tall, which gives you the
scale" while the body text, corrected earlier the same day, said five foot seven. **A figure
caption is text too, and my contraction/height sweep never looked inside one.** Fixed. Worth
remembering that captions sit outside most of the passes I run.

**"Why a Smart specifically?" -- answered, and the standing comment retired.** Kim:

> It was emotional, in part, as we'd seen them all over Europe. People were having fun with them.
> The right price, too. And there was the "ecological economy" sort of thing; we just didn't see
> the need for a large car. There were a few alternatives. None hit those selection criteria
> quite as well as a Smart.

Drafted as `## Why a Smart, and not something else`. **The emotional reason is placed first and
named as such**, which matches how the chapter already handles *cute*: the feeling arrives before
the justification, and pretending otherwise would be false to the record and duller besides.

### THE SHOP IS INFRASTRUCTURE, AND THE FUEL LOG PROVES IT (2026-08-22)

**PRIVACY RULING, Kim 2026-08-22: "We don't need to put Art's name in."** The draft already
named no individual, so nothing changed. Generalised as a standing rule: **in this book the
businesses may be named -- Matson, Smart Madness / Madness Autoworks -- but the people who work
in them may not.** That sits alongside the Eugene ruling (a person as collaborator, yes; as a
location, no) and completes the pattern: **institutions are nameable, individuals are not.**

> In 2010, and for a few more years, Smart cars were often tricked out. Unusual paint, custom
> accessories, engine modifications. Sort of the hot-rodder's car of choice for the period. We
> did some of that, too, besides the tires. **The importance is that we got into a good
> relationship with expert Smart mechanics.** The alternative was the Mercedes dealer... We always
> took TwoRed and Creamsicle to Smart Madness/Madness Autoworks unless we were in need of help
> far away (once in Wisconsin, as I recall). -- Kim, 2026-08-22

Drafted as `## The people who knew the car`, placed immediately before the modification section,
and the vague "I discussed it with some experts" now refers back to it. **This is the same theme
as chapter 3's parking: the car ran on relationships, not just on fuel.** Worth a deliberate
echo between the two chapters when chapter 3 gets written.

**SIGNAL HILL CONFIRMED, AND SHARPENED.** Kim: the fills are a Costco two blocks up the street,
a standard stop after service because a ~100-mile run to Lake San Marcos followed. So the seven
Signal Hill fills are not incidental -- they are a deliberate post-service habit, which makes
them a reliable service marker.

**But the brand shifted, and his memory kept the pattern rather than the particular.** Chevron:
2011-10-14, 2011-10-23, 2012-05-24, **2013-09-06** (the tire re-install). CostCo: 2016-04-20,
2017-01-07. Last one blank. **The 2013 fill was Chevron, not Costco.** The practice is exactly as
he describes; only the station changed partway through. The chapter text says "a filling station
two blocks up the street" and names no brand.

**Tire pressure resolved: it went TO 36 psi** (Kim), which he notes is high for a Smart. Higher
pressure lowers rolling resistance and *raises* economy -- so it is one more reason the X-Ice
group's 44.2 mpg cannot be read as a tire-size effect. Recorded in `wheel_states.csv`.

**The Wisconsin repair is almost certainly Creamsicle, not TwoRed.** TwoRed's only Wisconsin
fills are a single day, 2012-06-11 (Madison, then Hudson). Creamsicle has **14 Wisconsin rows**,
clustered Sun Prairie/Madison from 2021-10-22 to 2022-01-18 on a residence-like cadence --
which is the period covered by the ⚠ NOT FOR PUBLICATION family reason. **Handle with care:**
the repair anecdote is publishable, the reason that car was in Wisconsin is not.

⚠ **The invoice is not visible under `Smart_Car` from the R bridge.** Kim moved it to a
"TwoRed_logs" folder; no such folder exists in the project and no file matching `30K|maintenance|
wheels_June` is anywhere under `Smart_Car`. Either Drive is still syncing or it landed outside
the project tree. **Re-check before relying on it.**

### ★★★ THE TIRE INVOICE CLOSES THE ALASKA INTERVAL AT BOTH ENDS (2026-08-22)

Kim supplied Madness Autoworks receipt #5951, 6/18/2013, four pages. Far more than a tire size.

**What it establishes.** Work order: 2010 smart, **model 451**, VIN matching the Matson receipt,
mileage **34,190** (pages 3 and 4 agree; the page-1 scrawl reads ambiguously as 34120/34190 --
*a slashed-digit case in the wild*). Parts: 2 Pure wheels front, 2 rear, plus 1 front wheel and
tire as a spare. Tires: **4 x 185/55/15 Michelin X-Ice** and 1 x 175/55/15 Kumho. Tread depth
recorded as "Nw" on all four corners. Also 30K service, Denso Iridium plugs, both serpentine
belts as spares, TPMS sensor set, tow hook, car bra. **$2,500.89 to prepare for the Dalton.**

**And page 2 carries the other end: "Friday Sept 6th to re-install tires."** The fuel log --
which knows nothing of this receipt -- records a fill at **Signal Hill, California on 2013-09-06,
odometer 39,739**. Signal Hill is where Madness Autoworks is. **Two records that never referred
to each other, agreeing to the day.**

So the winter-tire interval is **34,190 to 39,739 -- 5,549 miles, 22 fuel rows, documented at
both ends**, and can now be excised precisely instead of by a date guess. Written to
`data/TwoRed/wheel_states.csv` with a source string per interval.

**A general finding worth more than this one interval: the fuel log contains a hidden service
history.** Signal Hill appears 7 times (2011-10-14, 2011-10-23, 2012-05-24, 2013-09-06,
2016-04-20, 2017-01-07, 2017-01-18). Each is very likely a shop visit. **A fuel log is also a
record of where the car was taken care of.**

**ANSWERING KIM'S QUESTION -- would bigger tires make a difference?** Directionally yes, and
against economy. But **size is the smallest of the three tire changes on this invoice.** X-Ice is
a studless WINTER tire -- soft compound, heavily siped -- and compound costs far more economy
than 10 mm of section width. The service sheet also records a **front tire-pressure change (29
and 36 psi both appear, one struck through; the scan does not settle the direction)**, and
pressure is itself an economy lever. Three tire variables moved at once, inside a single trip.

**Which makes the interval a perfect teaching case rather than a measurement.** The X-Ice group
returns the HIGHEST mean economy of the three states -- **44.2 mpg against 39.7 on the wide set
and 39.0 narrow.** Read naively that says winter tires on Dalton gravel improve economy by 11%.
It is of course the driving: lower speeds, cooler air, a different road. **The tires cannot be
separated from the trip, and no specification will fix that.** Chapter 13.

⚠ Receipt carries home address, cell, email, VIN and plate. **Redact before any figure.**

### TWO DOCUMENTS, EIGHT INCHES APART, AND NEITHER IS WRONG (2026-08-22)

**RESOLVED same day, by Kim, from the manual's own footnote: the width is measured with the
mirrors folded out.** The eight inches was never a discrepancy; it was two objects being measured.
Chapter 1 now cites the footnote instead of inferring from the arithmetic -- and the passage is stronger for it, because the resolution is a document rather than a plausible sum.

Kim supplied the **2010 owner's manual, "Main dimensions (model passion)"**. Against the
Matson receipt:

| | manual | carrier | diff |
|---|---|---|---|
| length | 106.1 in | 106 in | +0.1 |
| height | 60.7 in | 60 in | +0.7 |
| **width** | **69.0 in** | **61 in** | **+8.0** |

Length and height agree to a rounding tick. Width differs by **exactly 8.0 in -- 4 in a side,
which is what mirrors add.** The manual describes the car you drive; the clerk measured the car
you stow. **This is the book's whole thesis arriving in Chapter 1 as a two-sentence example**,
and it is now in the text: *which width you want depends on whether you are parking it or
putting it on a boat.* ** KIM TO CONFIRM the manual quotes width across the mirrors. **

It also **broke a line I had written.** "Very nearly as tall as it is wide" is 0.98 on the
carrier's body figures and only 0.88 on the manual's. Now qualified: *across the body*. A claim
that was true became ambiguous the moment a second source arrived -- exactly the failure mode
chapter 9 is about.

**New from the manual, used:** wheelbase 73.5 in = **69% of overall length**, leaving ~16 in of
car past each axle. That is the evidence for "a passenger box with the mechanical parts pushed
to the ends", which had been assertion. **Not yet used:** track front 50.5 / rear 54.5 (rear
4 in wider -- relevant to the crosswind and wide-tyre material) and **turning circle 28.7 ft**,
which belongs in chapter 2's "small and nimble are components of safety". Held back because
Kim is reading chapter 2 right now.

**Kim's calls:** keep the honest just-under-100K; **drop TwoFer's row** from the exposure table.
Done -- table is now two rows totalling **99,790**, matching the prose, with the `stopifnot`
guard passing. TwoFer's 1,209 Honolulu miles are errands, not exposure, and the chunk says so.

**Boot figures are PROVISIONAL.** No source Kim would believe, so he measures the compartment
himself 2026-08-23. `boot_dim` is marked NOT YET SOURCED. Creamsicle dimensions still absent;
if none surface, the text stays specific to TwoRed, where the numbers will be real.

**Tooling note:** replacing a multi-line binding by matching only its FIRST line left an orphan
continuation and broke `book_setup.R` at source time. Caught immediately because the very next
action was `source()`. **Match the whole binding, and source after every edit to a sourced file.**

### KIM'S CORRECTIONS TO THE FIRST THREE PIECES (2026-08-22)

Seventeen edits, all applied and verified by content. The substantive ones:

- **Foreword: forty-five states -> forty-nine** (fifty counting the one it was shipped to), and
  **ten provinces + the Yukon Territory**, not "provinces and territories". Finding 043 had one
  survivor, spelled out in words, which is why the numeric sweep missed it. **Sweep spelled-out
  numbers too.**
- **Chapter 2 exposure prose said "three of the cars" while the fill count beside it was already
  two-car (467 = 294 + 173).** Internally inconsistent and neither of us had caught it. Now
  "just under a hundred thousand miles across the two cars that did the travelling" =
  **99,790**, and the closing "Over a hundred thousand" became "Close to". A `stopifnot` in the
  exposure chunk now guards both spelled-out figures so a data change breaks the build.
- **Chronology fixed: the Yukon pothole came BEFORE the Dalton Highway.** The text implied the
  reverse. Now "Before heading to Alaska, where the car would meet the challenges of the Dalton
  Highway, the cute wheels came off", and the flag road is named as **the highway through
  Canada's Yukon Territory**.
- **The on-ramp story: three things, not two.** "quick action, some luck, **and a small car** --
  there was not room on that shoulder for a big one to have stopped without hitting the guard
  rail." That converts the anecdote into an instance of the chapter's thesis instead of a near
  miss that happened to end well.
- "the way **a lifetime** of driving had taught me" (was: sixteen years). "Traffic on **an
  on-ramp goes one way**" (was: a ramp goes down). "I pulled the **steering** wheel";
  "**TwoRed** slid to a stop" -- it was ambiguous whether the police car stopped.
- **The @fig-day-one paragraph was premature.** It jumped to the safety cell inside the section
  about *cute*. Rewritten as cute-only; the figure reference moved to where the pointing
  actually happens, in "The answer I give".

**PARKING, SETTLED BY KIM:** they park **side by side**; nose to nose the pair *would* fit one
space with room to spare. Both the Foreword and Chapter 1 now say that. My "nose to tail"
reading of the 2021 photo was right about that photo and wrong as a present-tense claim.

**THE REAR COMPARTMENT, described properly at last.** The shelf sits on top of the engine; you
swing the rear window up and drop the solid part of the hatch down. 27.5 in high, 39.5 in wide
at the floor widening to 41 in, 21-23 in deep depending on seat position; **7.8 cu ft (220 L) to
the window line, ~12 cu ft (340 L) stacked to the roof.** In `book_setup.R` as `boot_dim`.
**PROVENANCE UNCONFIRMED** -- which car, and measured or published? Flagged in `deferred.md`.

Kim is **5 ft 7 in**, which is now in Chapter 1: he stands taller than the car, which is 5 ft 0 in
by the carrier's tape. The standing KIM comment asking for the physical experience is retired --
every part of it has been answered.

### THE CARRIER MEASURED THE CAR, AND IT CORRECTED CHAPTER 1 (2026-08-21)

Kim: companies may be named (Matson; Smart Madness, later Madness Autoworks). Page 2 of the
shipping receipt is the Unit Details screen for unit 11907531 and it carries dimensions taken
by Matson **for stowage**: **8 ft 10 in x 5 ft 1 in x 5 ft 0 in, 1,808 lb.** A third-party
measurement made because somebody had to fit the car on a ship -- a better source for this book
than a manufacturer brochure. Bound in `book_setup.R` as `twored_dim`; Chapter 1 prints it inline.

**Height 5 ft 0 in against width 5 ft 1 in.** The car is very nearly as tall as it is wide, which
carries the "you sit high / it is not streamlined" claim with no external comparison needed --
so no unsourced sedan spec has to enter the book.

**And it caught an error of mine.** Chapter 1 said TwoRed and Bordeaux sit *side by side* in one
stall. Two of them abreast is 10 ft 2 in, which no ordinary stall takes.
`images/Bordeaux/2021_Bordeaux_and_TwoRed_in_one_space.jpg` shows them **nose to tail**, and
2 x 8 ft 10 in = **17 ft 8 in**, which is why it works. Corrected. Kim's 2026-08-20 phrase
"side by side" may describe the present arrangement rather than that photo -- **ask him.**

Also removed a **duplicated luggage claim** -- the boot-on-end description was made twice, in
"how small" and again in "The Costco test". Kim had flagged that it was "stated earlier". He was right.

Creamsicle is a different car (453, not 451) and the manifest does not cover it. **No sourced
dimensions for Creamsicle or Bordeaux yet.**

### STAYING ALERT IS A SAFETY SYSTEM -- KIM, 2026-08-21 (Chapter 2)

> When Nancy was along, we'd talk, mostly. That works. But alone? I listened to audio books.
> Captivating stories. These kept me on the edge of the seat... There were days when I'd arrive
> at my destination and not want to stop. I had to hear more of the book! I mixed the audio books
> with Radio Lab episodes... I got to the point where I wanted to drive so I could listen to
> something interesting. **Consider that I wasn't being interrupted as I drove. That meant I could
> pay attention to the story. And that, in turn, kept me very alert.**

Drafted as `## Attention is a component of safety too`, placed last before the caveat and worded
to mirror `## Small and nimble are components of safety` -- the same inversion moved from the car
to the driver. The generalisable claim is the absence of interruption, not the audio book.

**A correlation checked and deliberately NOT used.** Legs of 300+ miles covered in <= 1 day, as a
share of all such legs: 2010 13%, 2011 4%, 2012 12%, 2013 17%, 2014 8%, **2016 23%**. The rate
roughly doubles in the last full year, which would be a tempting fit for "the habit made him want
to drive further". It does not survive: n is small and 2016 is dominated by the two relocation
crossings, where long days are the plan rather than a by-product. Not attributable, not printed.

### THE FUEL LOG HAS A FLOOR, AND THE TANK SETS IT (2026-08-21)

Kim on the gearbox: TwoRed's automated manual is rough in town, irrelevant on the
highway, and Creamsicle's was much better. Tried to test it against economy and found
the record **cannot referee the claim at all**:

- TwoRed: 293 usable legs, **shortest 102 mi**, zero under 100.
- Creamsicle: 172 usable legs, **shortest 70 mi**, seven under 100.
- Largest fill in the whole TwoRed record: **8.7 gal** (the tank).

A leg is not a trip. **A leg is a tankful.** Town driving is not missing from the log --
it is *absorbed*: a week of errands then a highway day arrive at the pump as one leg with
one number. The instrument has a resolution and the tank sets it. Urban economy, and the
gearbox penalty with it, are unmeasurable by this instrument. **Chapter 13 material**,
generated by a Chapter 1 story -- the editorial rule working as designed.

### THE SHIPPING PAPERWORK DATES BOTH ENDS OF THE CROSSING (2026-08-21)

Receipt SEA -> HON, voyage 377. Drop-off **2017-05-22** at Seattle Terminal 25; front page
carries **ESTIMATED AVAILABILITY 06/09/2017** at Honolulu. So **18 days at sea**, documented
at both ends. `images/TwoRed/2017_TwoRed_Matson_dropoff.jpg` (EXIF 2017-05-22 13:09:41,
renamed by Kim from `_pickup`) shows the car on the apron -- and the last mainland fill,
Toledo WA odometer 71,181, is the same morning, 110 miles south. **The final row of 294
fills is the drive to the pier.**

The 20-day white spacer I had drawn at TwoRed's seam purely for visual separation turned
out to be the voyage almost exactly to scale. Cosmetic gap replaced by the real one.

**Kim's ruling: the shipping document is SOURCE ONLY.** Its facts are book material; the
document is not, at any level of redaction. Logged in `deferred.md`.

### CREAMSICLE'S END DATE WAS WRONG -- FINDING 041, THIRD INSTANCE (2026-08-21)

Had 2024-10-20, which is the **last fuel fill**. The handover is photographed
**2024-10-22 15:58**: Nancy's brother holding CA 8YEL786, Wisconsin AVW-1727 already fitted.
The day before, 10-21, Nancy stands beside it still on California plates.

Third time a fuel row has been read as a state boundary (TwoFer's lease, TwoRed's
shipping, now this). Promoting it from a finding to a **standing rule: a fill is a
transaction. An ownership date needs a document.** Corrected in `fleet_ownership.csv`
and `fleet_residency.csv`.

### FLEET TIMELINE BUILT; PHOTO PLATE SURVEYED (2026-08-21)

`book/R/fig_fleet_timeline.R` -> `fig-fleet-timeline`, now in Chapter 1. Horizontal spans,
one row per car, colour = which ocean. **Mainland took the warm slot and Hawaii the cool
one** because Creamsicle is literally orange and never went to Hawaii -- the Foreword photo
plate would have collided with the chart legend. Kim's idea exposed the bug.

What the colouring shows that durations alone do not: TwoRed is the only bar that changes
colour (6.8 mainland / 9.2 Hawaii); the Hawaii strand has been unbroken since March 2014;
the mainland strand has a **4 yr 3 mo hole**; and TwoFer's entire life sits inside TwoRed's
mainland phase, which *is* the explanation for TwoFer.

Photo survey for the Foreword plate (Kim wants a matched front-right three-quarter):

- **TwoRed** -- only 2 of 22 qualify, both compromised (Arctic Circle, mud-caked on steel
  rims; San Diego dealership, Kim and two other smarts in frame).
- **TwoFer** -- `2014_TwoFer_University_Ave.jpg`, clean, 2205x1653, the highest-resolution
  frame in the fleet. Settled.
- **Bordeaux** -- none exist.
- **Creamsicle** -- `PXL_20241021_173419870` best; both candidates date from her last month.
- `Creamsicle_profile.jpg` is **533x400**. A thumbnail despite the name. Do not build on it.

Kim will photograph TwoRed and Bordeaux in the building garage (2026-08-22, possibly after
a wash). Rule for the plate: **photograph the two still here; take the two that are gone
from the record.**

### ★★★ The Florida corner — a photograph, with coordinates (Kim, 2026-08-21)

> If you look at this location in Google Maps Street View, you'll see the same street sign: 30.983391913439764, -87.57131185084037. I did, indeed, take a photo of the corner where I stopped with TwoRed in Florida. I had forgotten that evidence.

### TwoFer had no logs (Kim, 2026-08-21)

> Re TwoFer and fuel. We didn't do any logs of this leased car. It was only used in Honolulu for very short trips. It was, basically, a fill in for TwoRed until we brought TwoRed to Hawaii.


### ★★★ Styx River Road — the Florida confirmation (Kim, 2026-08-21)

> Here is an unusual Florida confirmation. I have a friend who lives in Alaska on Styx River Road. There is only one other road in the US with this name. I remember seeing it (Huh? Another one???) in Alabama, just after leaving Florida. It is less than 10 miles from the Florida border. How would I have known that except by a visit?


### ★★★ South Dakota, and the storm chasers (Kim, 2026-08-21)

> The South Dakota side trip is real. I knew this would be a hard state to get. I believe I was in Nebraska when I told myself to do the trip north just to get SD and return. I had the time. It is memorable because while I was going on a narrow, rural road toward SD, I was met by a convoy of storm chaser vehicles coming the other way. I thought "maybe I shouldn't be going there" (because of the weather). I drove just far enough to cross the state line into SD, then turned around and left. It was definitely a side trip across a rural landscape.


### ★★★ Where the car actually slept — and why they live 2,500 miles away (Kim, 2026-08-20)

> The list of "unsettled" places only has one of any significance: Signal Hill. The other places are simply hotel/motels we stopped at along the way. They may repeat (like Brookings) as they are convenient stopping points. Signal Hill is where Smart Madness, a very helpful garage and after-market vendor, is located. We depended on them to help equip and maintain both TwoRed and Creamsicle. That's why there are frequent visits. One place you didn't list is Mentone. That's where my niece lives. She kept TwoRed for that five weeks while as I was making other arrangements. Eugene seems like an unlikely place, but a close colleague (Will McClatchey) has a farm with a huge garage. He made space for us. We continue to work together so it was logical to keep the car there as we visit Will several times each year.
>
> Although I'm sure you know, but we might need to mention that we live in Hawaii. If you didn't know that you might wonder why we didn't just drive to my mother's place. It also helps explain, in part, why we were interested in driving on the mainland. You don't do much driving in Hawaii (think: downtown Honolulu). Driving on the mainland was something different for us.
>
> The place the car was held on the first trip was in St Louis, quite near the airport. I saw a hand carwash business that had a large garage that they didn't seem to be using. I asked if they would keep the car for a reasonable fee. They were happy to do so. And I got a car wash, too.


### ★★★ Why the car left California — parking (Kim, 2026-08-20)

> The reason the car was relocated to Eugene is that as my mother neared her 104th year, she could no longer stay in her assisted living facility in LSM. She moved to a more secure facility in August and that place didn't have parking for TwoRed. Parking is a big issue and we've been fortunate that friends and family have helped at critical times.


### ★★★ THE OPENING — why there was a car at all (Kim, 2026-08-20)

> The overriding fact was we needed a car in Lake San Marcos. We were visiting my mother quite frequently. Each time we'd rent a car. That was getting expensive. Smart cars, it seemed to us at the time, we reasonably priced. And there was a parking spot available at my mom's place. Getting a Smart was a decision based, in part, on economics. Convenience, too. But this story is not about using a Smart for local suburban travel. It's about the long, cross country drives. This conflict is resolved by the familiar family dynamic of kids needing to visit parents, but not staying too long. In our case, we'd visit for a few days and then go off to a meeting (which wasn't optional, either). We'd drive back and visit again. Two visits separated by the time needed to do some work. The car served both purposes. That added to the value.


### The 2010 loop, corrected and complete (2026-08-20)

> This was the first big drive and it was complex. I went first for a short stop in Ft Worth, TX at BRIT (Botanical Research Institute of Texas). The on to St Louis where I did some work at the Botanical Society of America headquarters (and MOBOT, the big botanical garden). Nancy flew in and joined me in St Louis. We drove to Washington, DC, where she had a meeting. After that, we took a trip north to see friends in MA. After that, we did some driving around the region. Eventually, we got Nancy back to St Louis and she took a plan back to HNL. I stayed long enough to get the car stored (at a Car Wash). I returned to HNL for a short stay. Then I returned to St Louis and got the car (it was OK) and drove to Pittsburgh for a meeting (Gigapan camera robots). After that, I drove to meet with colleagues who were part of an NSF grant. They were in places like South Carolina. I then headed West until I got back to Lake San Marcos. Most of the trip was for Nancy and me to get to scientific meetings. We did add on a bit of driving so we could see areas of the country neither of us had visited. That, incidentally, added to the total number of states TwoRed visited and, in a way, became the basis of the challenge to visit the remaining states.

### The Penultimate State was Vermont, and there was a reason to go (2026-08-20)

> The penultimate state was Vermont. It wasn't just a drive to meet the challenge. I was working with a lawyer who has an office in NH, but lives nearby in Vermont. I drove to his house.

### The Texas on-ramp — location withheld (2026-08-20)

> I don't know the freeway on-ramp location in Texas where there was the police car incident. And for personal safety, I wouldn't reveal it either. Near Ft Worth is sufficiently close.

### ★★★ Road character — and a new category, TREE TUNNELS (2026-08-20)

> Finally, the Barboursville and Summersville visits that led to some of the most interesting drives. I had said it was the same highway. Looking at the map and the routes to where I was headed on the two trip, I'm not thinking that these were different highways. What they have in common is that they run through the same type of countryside; rolling, tree-covered hills, a winding highway, small villages tucked in the valleys. That was a relief from driving miles along nearly straight freeways lined by commerce, billboards and wall-to-wall housing. If I might add another highway category, it would be "tree tunnels". These are the very long (miles and miles) of straight divided highway lined by a dense thicket of trees. Flat. Monotonous. Where are these found? In the South.


### ★★★ IS IT SAFE? — the safety question, and the Texas on-ramp (2026-08-19)

> When people see the Smart cars, their reaction has to do with the size. These are small cars! So the question is: Is it safe? The preconception is that it isn't safe. Just too small. My explanation involves Mercedes (the designer) and the safety cell (like a race car). It say how it is safe. Do they believe it? Maybe. Maybe not. What the trips have shown me is that with prudent driving, it has been safe. Granted, no crash testing. But the cars have handled well and this, in part, keeps them out of dangerous situations. Were there close calls? Yes, I've mentioned one. It was the unmarked pothole in the Yukon that would have eaten the car. I was nimble enough to avoid the hole. A bigger car might not have been able to do that. The hole was big enough to eat a big car, too.
>
> The other close call, which I haven't mentioned happened in Texas. It was with TwoRed. I was heading East on the Interstate, not too far from Ft. Worth. I left the Interstate to drive through a small town. Just curious. No need to stop. Getting back on the Interstate involved going on an overpass across the freeway and then taking the road in a sweeping left turn down the freeway on ramp. I was doing that and just before the final down hill section, a police car came up the ramp, full speed, no lights, no siren. I pulled the steering wheel hard to the right and hit the brakes hard. I slid to a stop on the side of the road inches away from hitting the metal guard rail. I was stunned. Was I going the wrong way? I was in a near state of shock. So I waited. And while I waited, I watched several cars go down the on ramp, just as I had been doing. It was the police car that was going the wrong direction. I missed being hit head on by quick action and some luck. Did the police stop? Of course not. This was Texas.
>
> Small and nimble are components of safety, I believe. That's maybe counter intuitive.


### The St Louis car wash, and the 2010 loop (2026-08-19)

> I don't remember Summersville. But the loop that was part of was a bit complicated. I had been to a meeting in Frostburg and drove back after the meeting to St Louis. I left my car in a car wash facility (sounds strange, but it worked). I left the mainland and came back to St Louis, got the car. Nancy joined me and we went to her meeting (Boston?). After that, we drove around a bit, Nancy left and I continued the drive. I visited colleagues at a number of universities on the way back West. This route took me mostly through the South. I eventually got to California. By leaving the car in St Louis, I avoided having to drive back to California and then return soon after over the route I'd have just taken.

### The three layers — the architecture, given 2026-08-19

> The Smart Cars are the "hook" for the story. An overriding theme. The two aspects of performance, car and human, is the fabric for the story. The data become the real issue. The complexities and difficulties in the process of data collection, transcription, and cleaning on one end. At the other end, the opportunities for interesting, and perhaps unique, ways to analyze and display the results. This makes, in my mind, three layers. People see the unusual cars (and have preconceived notions). The drives make interesting stories. The data give satisfying answers to questions, even those you didn't know you had.


### Wiseman, and the first snow (2026-08-19) — answers the 46 Dalton miles

> We did the drive from Coldfoot to Wiseman, just up the road. A tiny city. Several years earlier, our friends who were with us said that on that stretch, the road was so bad that their tires were shredded. That's why they brought their car as a "chase car" to make sure we were OK. The road had been improved by the time we were there. We did get to go to the museum and were shown around by one of the residents. It was there, at our farthest north point, that the snow (I believe the first of the season) began to fall. That told us it was time to leave. And that was right as the weather was soon bad.

### The Penultimate State was never Florida (2026-08-19)

> By getting to 49 states, it left Hawaii as the Ultimate State, something we thought might happen (which, of course, it did). So it wasn't Florida. The emphasis on Florida came from the fact that it was the only state in the region (SE US) that hadn't been visited by TwoRed. There were more along the East Coast (Delaware, for example). I think Vermont became the real "penultimate state" that was visited (if memory serves me right).

### The West Virginia pair (2026-08-19)

> The West Virginia pair came from two different trips as there were scientific meetings in the region. I found the route the first time as it was a direct way to the meeting site. The second time, I believe I went out of my way a bit to go on this beautiful highway.


### THE TWO NEAR-MISSES — Kim, 2026-08-19

> Driving in the Canadian Yukon. Virtually no traffic. Pretty good highways. When there is a pothole, someone has put a flag marker at the side of the road. An adequate warning if you're paying attention. Which I was. But there wasn't a flag at the car-sized pothole that I barely missed. That would have been a TwoRed ending event. Lucky I was paying a lot of attention.

> The other "nearly destroyed the car" event was going into New Brunswick, Canada. A nice freeway. But at the place where the highway met a bridge, there was an abrupt level change (perhaps 4 inches). Wham! I wondered if the two front wheels had been seriously damaged. Fortunately, TwoRed survived. But it was a wakeup for Canadian highway driving. We were plagued by potholes. We often slowed to avoid damage. This meant also looking in the rear view mirror to make sure we wouldn't be hit from the rear. Those miles, which were mostly across the Canadian Plains, were very stressful.

_Both legs are identified and both look completely ordinary in the data: the Yukon run is 2013-08-12 Haines AK -> Destruction Bay YT (221 mi, 38.1 mph) or the 08-13 return; the bridge is **2014-05-23 Lubec ME -> Moncton NB, 217 mi, 5.35 h, 40.6 mph** -- Lubec being the easternmost town in the United States. See `proj_Smart_Car.md` for what the test of the Canadian Plains claim actually found._

### THE FAVOURITE DRIVES — asked 2026-08-19, unprompted by any number

> People have wondered about my favorite drive. Of course, I love going through the mountains in the West. The drive through the Rockies is one of most beautiful anywhere. Going through the mountains down to the Oregon Coast is fantastic. In the East, I found it almost surreal to do a morning drive on the sweeping highway running through the West Virginia hills. Villages tucked into the valleys were covered with fog and smoke from chimneys rose toward the sky. I liked this so much, I drove it twice. The Dalton Highway, going where cars weren't intended, was a very memorable experience.

### THE DALTON, AND THE STEEP SECTION

> There was a bit of drama on that road as the car slid forward on the gravel roadbed as we were going down a very steep section. Would we be able to go back up this incline? We were.

### STUCK ON TRIBAL LAND, ARIZONA

> I did get stuck once. I was following Google Maps and crossing tribal lands in Arizona. This was on the route between Phoenix and Monument Valley. I was on a dirt road and making a right turn. I was too close to the edge and got stuck in powdery soil. Completely stuck. In the middle of nowhere. Fortunately, after a long wait, a truck with two men came by. They gave me a much needed push and TwoRed was free. The rest of the drive, until paved roads returned, was very stressful. These dirt roads were also very rough. Memo to self: stay on the main roads.



_Chapter source material. Each was checked against the log; the corroboration is summarised in `proj_Smart_Car.md` under THE LONG DAYS. Six of eight collected._

### 2012-05-31 — St Louis MO -> Columbus OH, 518 mi. THE NAVIGATION ERROR.

> My navigator lived in St. Louis and I picked him up there as we were going to a scientific meeting together. He was the executive director of the organization acting as support for the scientific society. So we had a lot to talk about on the drive. His assistant lived in Columbus and we were scheduled to stop at her house for dinner. I asked my friend to be the navigator. Off we went, chatting along the way and not paying too much attention to the travel details. As I ran low on fuel, I got off the freeway and realized that we were in Urbana, IL. I knew that wasn't on our route. It cost about 100 miles of backtracking and, by then, we were running behind schedule. We had dinner, a bit late, that evening. There were fireflies out, so eating outside in the dark was OK. I took over the navigation responsibilities for the next day's drive which got us to the meeting site.

### 2011-06-26 — Flagstaff -> Holbrook AZ, 100 mi, out at 04:30. THE NEPHEW.

> I was meeting my nephew at Holbrook. He was then a naturalist at Petrified Forest NP and I wanted a tour of the place that day. The early start gave me the hours I needed.

_Kim corrected this himself on 2026-08-19: he first said "Petroglyphs NP" and the park is **Petrified Forest NP**. Recorded because the data had already pointed the same way -- 70 miles of local driving at Holbrook matches the Petrified Forest park road, and Petroglyph National Monument is in Albuquerque, 300 miles east. The instruments agreed before he did._

### 2012-06-14 — Billings MT -> Pocatello ID, 449 mi at 65.5 mph gross. THE FASTEST DAY.

> The trip from Billings to Pocatello goes through familiar countryside for me. Frankly, it wasn't very interesting and I was anxious to be in a location that would fit the next day's drive. There aren't many places to stay between the two cities, other than truck stop motels, so Pocatello was an efficient straight drive on good freeways. Going fast was pretty easy.

### 2014-05-29 — Sydney NS -> Edmundston NB, 555 mi. THE FERRY DIVIDEND.

> The Sydney NS to Edmundston NB trip came after arriving from Newfoundland on the overnight ferry. That gave us an early start (no need to pack the car). We wanted to be positioned to get to Quebec the next day, so we pushed on to Edmundston, even though it was a really long day.

### 2017-01-05/06/07 — Eugene -> Brookings -> Paso Robles -> Vista, 562 mi on the middle day. HIS MOTHER.

> I was keeping TwoRed at a friend's house in Eugene. I got the word that my mother, who had just turned 104 years old, was having problems. I took the next flight to the mainland and got to Eugene mid-day and picked up the car. I drove to Brookings, as far as I could on little sleep (I'd taken the red-eye from Honolulu). The next day, I continued south with the intention of stopping in Santa Rosa. But on my arrival there, the rain was very heavy and it looked like there would be flooding. I had to get to SoCal, so I decided to push on. The logic was to get as far south as possible for a one-day drive from where I'd be stopping would get me to San Marcos. I envisioned stopping in San Luis Obispo, but driving at night in rainy weather was very tiring and I had to quit a little short of my destination. It was OK, as I got to San Marcos the next day and was able to spend some time with my mother before she passed.

### 2014-05-05 — El Paso TX -> San Antonio TX, 531 mi. THE FLORIDA RUN.

> This was the trip where I wanted to finish the goal of driving in all 49 mainland states. One that remained was Florida. That became my goal at the start of the trip. That meant a southern route across the US. I'd previously driven across Texas near the middle (Ft. Worth and Dallas). This time, I'd take the route to the south by going through San Antonio and Houston. I was concerned with getting to Florida as soon as possible as I had a meeting to attend in Cherokee, NC. There weren't many interesting places along the route between El Paso and San Antonio and I was motivated to drive as far as possible. It was a long day.

> **[Florida, told 2026-08-19]** I got to Florida. I aimed at the panhandle. I drove just barely (a few miles) into what I thought was Florida. I stopped at a neighborhood intersection and got the attention of another driver. "Is this Florida?" "Yes." That's all I needed. Back in the car and I was out of the state as quickly as I had entered. Next goal: The Tail of the Dragon. That was on the way to my meeting and it was a not-to-be-missed drive.

### 2013-08-31 — Bellingham WA -> Grants Pass OR, 488 mi. NANCY AT THE DOCK.

> The Bellingham to Grants Pass, OR happened because Nancy decided to surprise me. She took a red-eye flight from Honolulu to Seattle and then boarded the train to Bellingham. She timed this to meet me at the dock when I arrived on the ferry from Alaska. When we met up, it was early afternoon. She told me we had reservations at Grants Pass. I reminded her that this was a long way away! That was OK with her as she had another long drive planned for the next day. We'd go all the way to San Francisco so she could fly home. Yikes! Two big driving days. So off we went. I remember the drive as being particularly enjoyable.

### 2012-05-24 — Lake San Marcos CA -> St George UT, 492 mi in 15.6 h. THE LAS VEGAS BREAK.

> The LSM to St George trip was before I was recording why I took time off during a drive. Las Vegas is between LSM and St George and we have friends who live in Las Vegas. We stopped to spend time with them and then pushed on later in the day to St George. A long day with a nice break to enjoy the company of our friends. The highway for the Las Vegas to St George leg is not challenging. That made it practical to push on to our destination.

---
### 2016-06-19 — Richmond MO -> Denver CO, 640 mi. THE LONGEST DAY. (collected 2026-08-31)

> My brother lives in Richmond. A short day to get there was all that was needed. After a visit, I faced the short trip remaining across MO, then the "flat" drive across KS and the part of CO leading up to the Rockies. There aren't a lot of interesting places to stop. I just wanted to get over this section of highway. I-70 through the CO mountains is one of the most beautiful drives in the US. I had some hope for Mt. Evans (which, we need to note has since been renamed Mount Blue Sky), but that wasn't the motivation. Getting back into roads that wind through the mountain valleys, often alongside the Colorado River, was what I longed for.

**★★ THE MOUNTAIN HAS BEEN RENAMED.** Mount Evans is now **Mount Blue Sky**. Applied to `expeditions.qmd` in two places 2026-08-31 (the extremes table and the section opening) and re-rendered. Any future mention takes the new name with the old one alongside, because every map Kim drove by said Evans.

**★ AND THE MOTIVATION IS THE OPPOSITE OF THE OBVIOUS ONE.** The 640 sits the day before the Mount Evans recovery, so the tempting reading is that the plains were crossed to reach the mountain. Kim rules that out himself: the mountain was hope, not motive. **He drove the longest day in the record to get a boring stretch of highway behind him.** The next day is what he wanted, and it is not the summit either, it is the Colorado River road.

### 2013-08-04 — Lake San Marcos CA -> Carson City NV, 487 mi. THE SMOKE. (collected 2026-08-31)

> That was a period when there were raging fires in the mountains. Smoke covered Hwy 395 as it runs up the east side of the Sierras. I couldn't stay farther south, even though I intended to stop well short of Carson City. It was the smoke that determined my miles on that day.

**★★ THE ROUTE CORROBORATES IT WITHOUT BEING ASKED.** The two fills that day are **Kramer Junction 10:40** and **Bridgeport CA 16:34**, and both are US-395 towns; Bridgeport leaves 77 miles still to run into Carson City. He fuelled inside the smoke and kept going. **The fill times were not in the record before this session** (see below).

### 2015-07-07 — Carlsbad CA -> Sedona AZ, 575 mi, out at 04:05. THE UNPAVED ROAD. (collected 2026-08-31)

> Carlsbad is next to LSM, so I was effectively starting at my base. A friend lived in Sedona and we agreed to meet up part way (I believe it was Phoenix) and we'd caravan to his house in Sedona. That plan mostly worked, but near the end as we were close to Sedona, he chose a route that was a serious challenge. He wanted me to get a good view of our destination, but to get to his house we needed to take an unpaved road for what seemed to be quite a long stretch. I was following him and he had a 4WD vehicle with lots of ground clearance. Not me. I crept along at less than 1 MPH, weaving my way around huge rocks. There was no turning back, although I'd have done it if I could. This was exceedingly risky as I could have gotten stuck. But I made it. And in doing so, I told myself (and TwoRed) to never do anything like that again. Otherwise, it was a nice visit. Vistas worth seeing.

**★ THIS IS PROBABLY WHY THE END ODOMETER WAS NEVER WRITTEN.** The leg carries `miles_written` 575 and no end reading, and the sheet note already said the start-time cell was overwritten. **A day that ends with the driver crawling around rocks in the dark is not a day the log gets filled in.** Not asserted in the text; offered to Kim.

### 2013-08-31 — Bellingham WA -> Grants Pass OR, 488 mi. THE SECOND TELLING. (collected 2026-08-31)

> I might have told the story before, but briefly, this was Nancy's having made the reservation in Grants Pass. I was just off the ferry from AK and she had flown in for a brief ride with me as I completed the Arctic Circle expedition. I think she hadn't quite thought about the length of the drive and that we were starting fairly late in the day. It was a grin and bare it drive. Having Nancy along made it work as we could share stories about the expedition. But it was, indeed, a long drive.

**★★★ THE CONFLICT IS RESOLVED, AND BY A NUMBER THAT WAS NEVER TRANSCRIBED.** Kim has said twice that the day started late; the sheet says **06:49**. The arithmetic rules out a genuine afternoon departure (488 mi by 20:18 needs about 67 mph gross, above the fastest day in the record). **The Alaska trip's FILL TIMES had never been entered** -- `TwoRed_fuel_timetemp.csv` held 3 rows for 2013 against 40 for 2016 -- so there was nothing between the two ends of the day. Transcribed from `2013_TwoRed_Fuel_Trip_Logs_Alaska.pdf` (22 rows, every odometer key gated against the fuel log on the same date, 0 unmatched, 0 date mismatches), the day splits:

| | clock | odo | miles | hours | mph |
|---|---|---|---|---|---|
| Bellingham | 06:49 | 38,285 | | | |
| Lakewood WA | 12:52 | 38,407 | 122 | 6.05 | **20.2** |
| Rice Hill OR | 18:36 | 38,683 | 276 | 5.73 | 48.2 |
| Grants Pass | 20:18 | 38,773 | 90 | 1.70 | 52.9 |

**The first 122 miles took six hours; the rest of the day ran at 50.** About four hours are unaccounted for between Bellingham and Tacoma, which is the size of a ferry docking and unloading, a train arriving from Seattle, and two people finding each other. **The sheet recorded when the car came off the boat. Kim remembers when the driving started. Neither is wrong.** Written into ch.5 that way; **Kim has not yet confirmed the reading.**

**★★ METHOD: the conflict was between two records only because a third had never been read.** Both accounts had been checked against each other for a fortnight. The instrument that settled it was sitting in the same PDF as the leg, one table higher up the page.

---


# Smart_Car -- project log

## ARCHIVE -- moved out of proj_Smart_Car.md 2026-08-18 to hold the size budget
_Verbatim. Narrative material for the document, plus one superseded status table._

### ★★ THE YUKON RIVER CAMP STORY -- and why the claim is stronger than an anecdote (Kim, 2026-08-18)

**August 17-18, 2013, Dalton Highway.** While Kim was filling the car at Yukon River Camp, the woman
running the small concession in the parking area ran over, excited: **they had never seen a car like
it before.** Kim reads this as confirmation that TwoRed was **the first Smart car to make the Arctic
Circle run.** On the way back the weather turned, and **the highway closed shortly after they were
off it.**

**★ THE INFERENCE IS UNUSUALLY WELL-SUPPORTED FOR A TRAVELLER'S ANECDOTE, AND THE FUEL DATA IS WHY.**
Yukon River Camp is **the only fuel between Fairbanks and Coldfoot** -- which is exactly why the log
shows Kim buying there **twice, northbound (ODO 36,852) and southbound (37,114)**. Anyone driving the
Dalton must stop there. **So the observation post is a CHOKE POINT, and a negative observation at a
choke point is worth far more than the same observation anywhere else** -- she was positioned to have
seen every vehicle that made the run. It remains testimony rather than proof, and should be written
as *the only fuel stop on the road had never seen one*, which is both defensible and stronger-sounding
than a bare claim of primacy.

**★★ AND IT IS THE SECOND INSTANCE OF THE SAME UNDERLYING FACT.** In Alpine, Texas a stranger walked
over because he mistook the Smart for **a specific friend's car**. At Yukon River Camp a stranger ran
over because she had **never seen one at all**. Same cause -- the car was rare -- producing opposite
reactions according to where it was parked. **Two independent strangers approaching the car in two
years is a PATTERN, not a pair of anecdotes**, and it is evidence for the document's thesis that no
fuel statistic can supply: the vehicle was conspicuous in exactly the places the urban-commuter
assumption says it should never have been.

**Margin of safety, from the data:** the Coldfoot round trip was **550 miles over two days** in a car
with roughly a 330-mile range, refuelling at the single station in both directions, and the road shut
behind them. Kim: *there were more adventures.*

### ★★ THE ALPINE STORY -- for the Expeditions chapter (Kim, 2026-08-18)

**February 2012.** Kim had met a faculty member from the university in Alpine, Texas while in Fort
Worth, and drove out to visit him -- a **408-mile straight-line detour** into Big Bend country. The
campus looked deserted. Casting about for the right building, he saw a single person walking toward
the parking lot where he had stopped. The man came over to the car. **He was the very person Kim
had driven there to see -- and he had walked over because he mistook the Smart for a friend's car.**
Two coincidences in one empty car park.

**★ Why it belongs in a document about the CAR and not just the trip:** the coincidence is only
possible because a Smart in Alpine, Texas in 2012 was distinctive enough that a passer-by assumed it
belonged to the one person he knew who drove one. **The car was legible as an individual.** That is
a fact about what it was like to run this vehicle long-distance in that era, and no statistic in the
fuel log carries it.

**★ AND THE STORY DOES ANALYTICAL WORK.** It confirms the route, which turns the missing fill-up
from a suspicion into a certainty: Ft Worth -> Alpine is 475 recorded miles against a ~331-mile tank
range, so **a fill-up exists that was never written down** (errata L18). It also explains why the
row is the messiest in the file -- **the log was written up at the end of a memorably disorienting
day.** Kim's own reading: *that's enough to get me confused.*
**This is the pattern worth repeating: the narrative and the data each explain a gap in the other.**

**Photographs of the cars in interesting places** are a first-class element, not decoration.
They are also the natural join to `Photo_Locations` and `timelinesr`: a geotagged photo and a
geocoded fuel stop are the same kind of record, and the fuel log already supplies a route to
hang them on.

**ICE and EV are kept SEPARATE (Kim, 2026-08-12).** Statistics run across the three gas
cars; Bordeaux is described qualitatively. **A $/mile axis spanning gasoline and electricity
was considered and declined** — it would force a comparison the charging data may not
support. Revisit only if kWh and charging-cost records turn up.

## SCAN COVERAGE AND WHAT IS TRANSCRIBED (2026-08-18)

**Trip logs transcribed -- 67 legs, one CSV per trip in `data/`:**

| Trip | Legs | Miles | Agreement with the written distances |
|---|---|---|---|
| 2011 St. Louis | 15 | 4,635 | 12 of 14 within 2.5 mi |
| 2013 Arctic | 18 | 5,401 logged (Kim's 5,470 counts from the first fuel stop) | **18 of 18** |
| 2014 Penultimate State | 32 | **10,907 -- Kim's own margin total, EXACT** | 31 of 32 |

**Fuel-log scan coverage: 140 of 293 rows (48%) now have verified paper behind them.**
6 of 14 distinct scans opened; **8 remain unopened**: 2011 STL, 2011 fuel log, 2012 Frostburg,
2012 May Arizona, 2013-4 LA Expedition, 2015 Sedona, 2016 fall-winter, 2017 January.

**★ TWO PERIODS MAY HAVE NO SHEET AT ALL, and one of them matters:**
- **2016 May-Dec, 39 rows** -- the only remaining 2016 file is *fall-winter*. **This is exactly where
  the fill-drag contamination sits**, so if no May-2016 sheet exists the AMEX is the only route to the
  true LSM and Blythe gallons and costs.
- **2017 Jan-May, 13 rows** -- the only 2017 file is *January*, against a run ending 2017-05-22.


---

_Split from proj_Smart_Car.md on 2026-08-18. Verbatim; nothing edited._
_Live project file: `../proj_Smart_Car.md`_

---

## Log
### 2026-08-17 (the paper trip logs; the fractal scope boundary; a fuel-log audit)

**Kim scanned a set of 2011 field sheets and asked whether I could read them. I can.** Four pages,
handwritten, fuel log above and trip log below. **The trip half had never been typed** -- which is
the exact gap that made TwoRed's Trip Log "7 rows, a fragment not a dataset" on 2026-08-12.

**Transcribed: 15 legs, 4,635 driving miles, odometer 13,689 -> 18,789.** Written to
`data/TwoRed_2011_StLouis_trip_log.csv`.

**★ The odometer is a free QC gate, and it works.** 12 of 14 written distances match the odometer
delta within 2.5 mi. Of the two that did not: 7/05 read as 298.7 against an odometer delta of 289
-- **re-read as 289.7, and the odometer corrected my transcription**; 7/04 remains 392.1 written
against 397, unresolved and flagged in the file rather than smoothed. **This matters for scale:
every leg self-checks, so bulk transcription of the remaining sheets is trustworthy rather than
OCR-and-hope.**

**★ THE FUEL AUDIT, and the finding is the DISTINCTION not the fixes.** Testing whether
`gallons x $/gal` reproduces the recorded cost failed on 4 of 23 rows in the 2011 window. **The paper
splits them into two kinds:** 6/23 San Marcos ($/gal typed **3.000**, paper says **3.999**) and 6/25
Ash Fork (gallons typed **7.624**, paper says **7.264**, which reproduces the cost exactly, and the
paper itself shows the total struck and corrected) are **TRANSCRIPTION errors the scans repair**.
6/25 Ludlow and 7/02 Spring TX are **inconsistent on the paper too -- FIELD errors that predate the
spreadsheet** and can only be settled from a receipt, or left flagged. **The scans do not merely add
data; they let a transcription error be told apart from a field error.** Neither fix applied yet --
editing Kim's data file is his call.

**★ KIM: THE SCOPE BOUNDARY IS FRACTAL.** The 4,635 logged miles against 5,100 odometer miles is
city driving, and *we're laser focused on the long drives, not the city stuff*. **The same rule
appears at fleet, car and trip level, excluding the same thing each time -- so the gaps are
DEFINITIONAL, not missing.** See the section above; it is now an analysis rule.

**KIM: a complete set of TwoRed trip logs likely exists.** If so, TwoRed stops being a fuel spine
with a 7-row fragment and becomes a **true parallel spine to Creamsicle**.

**KIM: temperature recording was DROPPED** -- not worth the effort against everything else happening
at departure and arrival. **So temperature is a BOUNDED EARLY SUBSET of the TwoRed record, not a
column that runs through it.** Scope any thermal analysis to the years that carry it; establish the
cut-off from the sheets as they arrive rather than assuming one.

**⚠ METHOD TRAP for the TwoRed-vs-Creamsicle comparison.** Creamsicle's `Miles/Hour` is computed
**after** subtracting a `Stop` column; the TwoRed paper sheets have no stop column, so their mph is
**gross**. Verified on Creamsicle's Nixa->Kansas City leg. **Compared naively, Creamsicle wins by
construction.** Use Creamsicle's raw `Duration` for any speed comparison.

### 2026-08-16 (Kim's rulings, second half of session)

**Context: Hurricane Lala.** Hawai`i was narrowly missed but damaged across all islands -- nearly
**200,000 homes without power**, bridges washed out, communities isolated. Kim and Nancy are safe
and their Honolulu apartment kept power; he had been reluctant to use the computer at all in case
it dropped. **Recorded because it explains the shape of the next few sessions, not as colour.**
Recovery expected to begin 2026-08-17.

**1. The fleet splits 2x2 by DISTANCE ROLE** -- see the section above. Supersedes the ICE/EV axis.

**2. `TwoRed_fuel_June_2014` IS the last fuel log for TwoRed.** Kim: he logged fuel while the car
was used primarily for long trips; Honolulu trips are all short, and the receipts exist but add
nothing to a document about long-trip performance. **★ This dissolves what the PKM had filed as a
gap: the log stopping at 71,181 while the car reached ~75,000 is not missing data, it is the
project's SCOPE BOUNDARY showing up in its own record.** Consequence for the document: cite *log
miles* and *odometer miles* as two different quantities and say why they differ, rather than
reconciling them.

**3. The Origin Story confidentiality question is ADJUDICATED -- Kim is content with the text as
it stands.** He gives away neither the person nor the condition, which he judges within the spirit
of the 2026-08-12 conditional. **Closed. Do not re-raise; do not re-derive the detail.**

**4. The `Creamsicle` doc ending is BY DESIGN, not truncation.** The countries/states list is a
summary reminder that place analysis is coming; the actual places live in the trip log. **The
open question raised earlier today is closed -- and refusing to call it an absence was correct.**

**5. The spreadsheet needs a cleanup.** Kim's own account: calculations were put "here and there"
to feed figures into the story. Filed as a TASK.

**6. The photo layer.** See Intended analysis.

### 2026-08-16 (the Creamsicle data found; project unblocked)

**Focus chosen by Kim at session open.** The block was discharged in one search, and the reason it
had held for months is worth more than the data: **every prior sweep was a filesystem sweep, and a
Google-native document has no bytes on disk.** `G:` reported `Final Creamsicle Logs.gsheet` at 176
bytes; `readBin` returned 0. The card's ground-truth rule predicted exactly this.

**Found:** `Final Creamsicle Logs` (gas log + the project's first real trip log), the `Creamsicle`
narrative doc (9 trips, drafted), `Creamsicle_July_Fuel_Log_update` (with lat/long), and
`Creamsicle Inventory`. **28,697 miles, 1,123 days, 9,845 mi/yr, 18 states + Canada.**

**Two side findings.** `TwoFer Gas Log` is car #2's record -- 7 fill-ups, 1,209 miles, **all
Honolulu** -- which the PKM had as "one line of text". Kim ruled both names were used: Two4Two
canonical in prose, TwoFer recorded as the log's title so a future session does not "correct" it.
**★ It also sharpens the thesis rather than padding it: the one car that WAS a pure urban commuter
is the one that was leased and given back.** And `TwoRed_fuel` is a second, richer TwoRed sheet
carrying ambient temperature in its Notes.

**One hypothesis raised and killed by data.** 2016 is Creamsicle's model year, so
`2016_Fourth_Crossing_Analysis.xlsx` looked like it might be Creamsicle's. It is **TwoRed's** --
odometer opens at 58,214 in May 2016, five years before Creamsicle was bought at 30,290.

**Not claimed:** no Creamsicle fill-ups past 2024-07-02 appeared in the read, though trip legs run
to 2024-10-20. Filed as an open question, not as an absence (Findings 018/019/020).

Set **Active / Ready** at Kim's direction.
### 2026-08-12 (intake gap closed; reframed from one car to four; focus lowered)

Filed as a project after the 2026-08-11 session identified it as a document mis-scoped as
a story. **Kim confirmed that reading and went further:** the largest section of the source
material is the Arctic Circle Challenge, which is already a posted story -- so the
remaining substance is the data, not the narrative.

**The reframing is his:** four Smart cars, not one. Two still owned. Deepest data on the
first, TwoRed.

Materials copied to `Projects/Smart_Car` under `data/`, `source/`, `images/`. Nine files,
**all nine verified byte-identical**, 20.56 MB both sides.

**Reading the data rather than the charter changed three claims** -- the Gas Log runs to
2017 not June 2014, the odometer tops out at 71,181 not 75,000, and the Trip Log is 7 rows
rather than a dataset. Recorded above rather than carried forward as fact.

Set **Active + Blocked** at Kim's direction so it leaves the active worklist while staying
findable, with the blocker named as his own data recovery.

## Chapter architecture (PROVISIONAL — inherited from the one-car charter)
1. **Foreword** — origin (Paris to the US mainland) and the urban-myth thesis.
2. **The Canvas** — the geocoded constellation of every recorded fuel stop.
3. **The Expeditions** — fill-ups classified into trips via the master dictionary.
4. **The 4th Crossing** — daily friction: temperature against mileage, true average speed.
5. **The Extremes** — highest (Mount Evans), lowest (Death Valley), furthest.
6. **The Fleet** — NEW, and the reframing's payload: four cars, sixteen years.

Old Chapter 5 (Arctic Circle embedded) is deleted; see intentions item 2.



## What the data ACTUALLY contains

Read directly rather than taken from the charter, 2026-08-12. **Three of the charter's
claims do not survive contact with the files, and one filename actively misleads.**

| Asset | Charter said | What is actually there |
|---|---|---|
| `TwoRed_fuel_June_2014.xlsx`, sheet *Gas Log* | "nearly 300 fill-ups" | **293 fill-ups, and the range is 2010-07-23 to 2017-05-22** -- nearly three years past what the filename claims. **Rename deferred until Kim confirms.** |
| same, odometer | "75,000 miles" | Tops out at 71,181 in the file. **RESOLVED 2026-08-12 by Kim: TwoRed is ~20 miles short of 75,000** -- the log stops before the car did. The charter was right; my open question rested on the spreadsheet alone. Kim is filling in the remaining miles. |
| same, *State* column | "49 states and 10 provinces" | **52 distinct values.** California 96 fill-ups, then Arizona 24, Texas 21. Needs normalising before any count is claimed. |
| same, sheet *Trip Log* | "precise daily driving intervals" | **7 rows.** This is a fragment, not a dataset. |
| same, sheet *Canada2014* | not mentioned | **24 rows in litres and Canadian dollars.** A unit-normalisation job the charter did not anticipate. |
| `2016_Fourth_Crossing_Analysis.xlsx` | "a highly refined subset" | **Accurate -- and it is TwoRED, not Creamsicle. RULED 2026-08-16 by odometer, against the tempting coincidence that 2016 is Creamsicle's model year:** the file opens at **58,214 in May 2016**, inside TwoRed's trajectory and five years before Creamsicle was bought at 30,290. Carries `am_temp` / `pm_temp` as well. 35 rows, with `time_zone`, `raw_hours`, `activity_time`, `corrected_hrs`, `miles_per_hour` already derived. The best-prepared asset in the set. |
| `Smart_Car_master_dictionary.pdf` | expedition names and date ranges | Present, 2.0 MB. Not yet parsed. |

**SUPERSEDED 2026-08-16 -- the sentence below was written when the on-disk sweep was the only
search that had been run. Creamsicle and Two4Two/TwoFer both have machine-readable records; they
are Google-native and therefore invisible to a filesystem sweep. Bordeaux remains uninventoried.**

_Superseded:_ **The other three cars are now NAMED and DATED (see The fleet above), but only Two4Two has
a machine-readable record** -- `leased_smart.txt`, one line. **Creamsicle is the important
gap:** Kim has substantial cross-country data for it, and finding those files is what turns
this from a one-car document into a two-spine one. Bordeaux is not yet inventoried.



## ★ THE AMEX STATEMENTS ARE A THIRD INDEPENDENT RECORD (2026-08-18)

Kim kept scans of the old credit-card statements. **BRAND and COST are the invariants** -- they
anchor a row to a real transaction, so where the log's CITY is wrong the statement names the town.
**Four cities corrected this way, every one confirmed independently by geography:**

| Logged | Actually | Ratio before -> after |
|---|---|---|
| Austinburg, OH (Sunoco $22.46) | **Waterloo, NY** | 0.65 -> 1.17 |
| Warren, OH (Flying J $17.74) | **Austinburg, OH** | 6.34 -> 1.08 |
| Matfield Green, KS ($21.59) | **Lenexa, KS** | 0.88 -> 1.25, and inbound 2.30 -> 1.15 |
| Big Springs, TX / Fina ($23.57) | **Alpine, TX / Stripes** | 1.95 & 0.83 -> 1.17 & 1.13 |



### ★★ A HYPOTHESIS OF MINE WAS REFUTED, AND THE REFUTATION IS THE LESSON

I proposed that ONE bad odometer reading at 'Big Springs' explained both its anomalies -- an
impossible 76.2 MPG on the way in and an impossible geometry on the way out. It was elegant: too
high inflates the inbound leg and shortens the outbound one, and two independent estimates of the
corrected value agreed to within 45 miles. **It was also wrong.** The town was **Alpine**, 183 miles
away, and the odometer had been right all along.

**The row held TWO UNRELATED FAULTS: a mislabelled city AND a missing fill-up.** The geographic fix
resolves the first and leaves the second untouched -- 475 mi on 6.237 gal is still 76.2 MPG.
**Rule: parsimony is a preference, not evidence. Two tests firing on one row may be finding two
faults, and collapsing them into one story is how a plausible answer replaces a true one.** This is
the sharpest form of the disjoint-audit-families result: **two errors, adjacent columns, one row.**

### ★★ TWO MORE OF MY OWN CORRECTIONS WERE CORRECTED (2026-08-18)

**1. The row was MERGED, not mislabelled.** Kim's paper log, confirmed against AMEX, has THREE
fill-ups where the sheet has two. The survivor is a **chimera**: `date / city / brand` from the
**Big Spring** row, `$per gal / odometer / gallons / cost` from the **Alpine** row -- an eye
tracking across a paper log and dropping a line partway over. **My 'relabel it Alpine' fix was
directionally right and structurally wrong; the row needed SPLITTING.**

**★ AND IT PASSES THE ARITHMETIC TEST PERFECTLY** -- 6.237 x 3.779 = 23.57 exactly -- **because all
four numeric fields came from ONE source row, so the pump identity survived the merge.** **A
collapsed row can be flawlessly self-consistent. That is the arithmetic test's blind spot, and only
the economy and geography tests saw it.** Restored, the three legs give ratios 0.96 / 1.31 / 1.13
and MPG 35.4 / 38.6 / 36.3 -- all normal.

**2. ERRATA MUST BE KEYED TO A ROW, NOT TO A LABEL.** I withdrew a gazetteer fix on 2026-08-18
believing the 2012 row proved `Big Springs, Texas` was never a real stop. **That withdrawal was
wrong.** The label appears in three rows and means three different things:

| Row | Truth |
|---|---|
| 2010-11-21 | **Big Spring, TX** -- a spelling slip; genuinely mis-geocoded to Nebraska |
| 2012-02-06 | **Big Spring TX + Alpine TX** -- two fill-ups merged into one row |
| 2016-05-30 | **Big Springs, NEBRASKA** -- a real, different town; no error at all |

**One logged label, three resolutions. A correction scoped to a NAME will silently mis-apply to
every other row carrying that name.** The gazetteer entry is reinstated with row-level scope.

### ★ ALL FIVE FERRIES ARE NOW IDENTIFIED

Every geographically impossible leg in seven years is now explained or is a boat. **The remaining
five ARE the boats:** Alaska Marine Highway twice (Bellingham->Haines Junction, 1,018 SL / 160 odo;
Homer->Lakewood, 1,455 / 336), Newfoundland twice, and **Lake Michigan** (Jackson MI -> Madison WI,
260 / 239 -- the Muskegon-Milwaukee crossing, identified by Kim). **A data-quality test built to
find typing errors located every water crossing of the record instead.**



## ★ THREE AUDIT FAMILIES, AND THEY ARE NEARLY DISJOINT (2026-08-17)

**The single most useful methodological result so far.** Two independent tests were run over all
292 TwoRed fill-ups. **They overlap on only 2 rows out of 34.**

| Test | Catches | Blind to |
|---|---|---|
| **Arithmetic** -- `gallons x $/gal = cost` | typed digits in price, gallons, cost | city, state, date, odometer |
| **Economy** -- implied MPG per leg | partial fills; **MISSING rows** (MPG too high) | anything self-consistent |
| **Geographic** -- straight-line vs odometer | wrong city/state, mis-geocodes, **odometer digits** | errors that stay on the route |

**Rule: one test finds one error CLASS. A clean pass on the arithmetic says nothing about the
geography.** 21 arithmetic suspects, 15 geographic, **2 in common, 31 distinct rows needing a scan.**

### ★ The geographic test, and the thing it found that is not an error

If the straight-line distance between consecutive fill-ups **exceeds** the odometer change, the leg
is impossible -- you cannot drive less than the straight line. 15 legs fail. **They fall into three
kinds, and the third is a feature of the record rather than a fault in it:**

- **4 GEOCODE errors, from 2 cities.** **`Deming` is logged as ARIZONA; Deming is in NEW MEXICO**
  (twice, 2010 and 2014). **`Big Springs, Texas`** is mis-placed -- the town is **Big Spring**, no `s`,
  and the gazetteer appears to have taken it to Big Springs, Nebraska (twice, 2010 and 2012).
- **7 ODOMETER suspects** -- straight line exceeds the recorded distance with no other explanation.
  **This is exactly the error class the arithmetic test cannot see.** Needs the scans.
- **★ 4 FERRY LEGS -- NOT ERRORS.** Bellingham WA -> Haines Junction YT (1,018 straight-line miles
  against 160 on the odometer) and Homer AK -> Lakewood WA (1,455 vs 336) are the **Alaska Marine
  Highway**; Sydney Mines NS -> Corner Brook NL and Port aux Basques NL -> Aulac NB are the
  **Newfoundland ferry**. **The car crossed water while the odometer stood still.** The test detected
  both great water crossings of the TwoRed record automatically. **Do not 'correct' these** -- and
  they are worth the document: getting a Smart to Alaska and Newfoundland involved boats.

**A fourth, free test: the JOIN ITSELF.** Matching fill-ups to the gazetteer fails on 47 distinct
locations, one of which is **`Lake San Marcos, Callifornia`** -- a spelling error surfaced with no
test written for it.



## ★★ THE SCAN SWEEP -- ALL 15 SCANS NOW READ (2026-08-18)

Eighteen pages across seven files, read to the transcribe-once rule: every column, not just distance.

**Trip legs 69 -> 107** (101 with usable times). New trip logs: 2012 Frostburg (18 legs), 2012 May Arizona (7), 2015 Sedona (3), 2017 January (3), 2011 N. California Roadtrip (6, reconstructed), 2013-4 LA Expedition (1).
**Fuel rows with a TIME AND TEMPERATURE stamped on the fill: 0 -> 95** (32% of the log), 38-102 degF.

### ★ The 2011 St. Louis file was a pure duplicate -- and that is the finding

`2011_TwoRed_fuel_and_trip_log_STL.pdf` and `..._travel_and_fuel_log_June.pdf` differ by md5 and are the SAME four pages rescanned. **Zero new legs.** But those pages carry Time and Temp columns in the FUEL table that were never taken, because the first pass went looking for distance. **The re-open cost a full pass and returned 23 fuel-row temperatures.** This is the transcribe-once rule proved on the first file it was applied to.

### ★★★ THE WHEEL CHANGE IS DATED. It is written in the margin: NEW WHEELS @ 13510 miles

So the before/after cut is no longer an assumption. **The wheels went on 179 miles before the 2011 St. Louis departure**, which puts the narrow-tire group at exactly 2010-07-23 to 2011-05-11 -- the first crossing plus local driving, precisely matching Kim's account.

**And the estimate is still not significant, in either direction.** Raw +1.7%; +leg length +3.6%; +leg length and odometer trend +1.6%; **local window +/-12,000 miles -1.8% [-6.6%, +3.0%]**; with temperature also controlled -1.5% [-8.9%, +5.9%]. **The sign FLIPS with specification. That is what an underpowered comparison looks like, and it is the honest headline** -- not any single one of those numbers.

### ★★ TEMPERATURE IS NOT NULL -- THE EARLIER TEST USED THE WRONG INSTRUMENT

MPG is computed PER FILL. A temperature stamped on the fill belongs to that quantity; a temperature at a leg endpoint belongs to a different unit of analysis. Once the fill-stamped temperatures existed, a signal appeared:

| specification | MPG per degF | 95% CI | p |
|---|---|---|---|
| temperature only | -0.084 | -0.159, -0.009 | 0.028 |
| + leg length | -0.068 | -0.135, -0.002 | 0.045 |
| + leg length + odometer | -0.078 | -0.147, -0.009 | 0.027 |
| + leg length + era fixed effects | -0.069 | -0.138, +0.001 | 0.053 |

Fills at 80 degF and above average **36.76 MPG** against **38.87** below it -- a **2.1 MPG, 5.4%** gap on n=94.

**State it as a signal, not a settled result.** p sits ON the 0.05 boundary and crosses it under era fixed effects. The sign is counterintuitive (warm air is thinner, and should help), so the likely mechanism is **air-conditioning load on a 1.0-litre engine** -- but that mechanism is INFERRED, not measured, and nothing in the data distinguishes it from hot-weather routes being different routes. **I over-claimed on the wheels once already; this one gets the same discipline.**

### ★★ THE SLASHED ZERO GENERATED THREE MORE CORRECTIONS, AND THE CONTROL HELD

Systematic test over the **44 rows that fail the pump identity**: does a single-digit substitution in the COST make the row balance exactly?

| substitution | mechanism | rows fixed |
|---|---|---|
| **8 -> 0** | **permitted** (a slashed 0 reads as an 8) | **4** |
| 0 -> 8 | forbidden (an 8 does not read as a 0) | 1 -- and it is Deming, already flagged wrong-direction |
| 3/5, 5/3, 1/7, 7/1, 6/0, 9/4 | none | **0 of 6** |

New: **L59** San Marcos 2010-11-29 19.28 -> 19.20 (**the first fill in the entire record already carries the signature**); **L60** San Marcos 2011-06-23 32.48 -> 32.40, **the SAME ROW as L01**, where a 3.000/3.999 slip was already proven -- two slips in one row, exactly the queue-pressure mechanism Kim described; **L61** Champaign 2012-05-31 29.68 -> 29.60. All three HYPOTHESIS tier: **the scan is not evidence for this class**, because the scan is where the illusion lives. Confirm from AMEX.

### Gross speed separates by ROAD, across 107 legs

2011 St. Louis (interstate) **47.6** | 2012 Frostburg **43.5** | 2017 January 41.2 | 2011 N. California 40.6 | 2014 Penultimate State 39.7 | 2015 Sedona 39.0 | 2012 May Arizona 36.9 | 2013-4 LA 34.6 | 2013 Arctic (Dalton) **30.9** | 2016 fall-winter (US-101 coastal) **28.3**. Same car throughout.

**Longest days found:** 6/14/2012 Billings -> Pocatello **448 mi in 6.85 h, 65.4 mph gross**; 5/31/2012 St Louis -> Columbus **517 mi**; 1/6/2017 Brookings -> Paso Robles **562 mi**; 7/7/2015 Carlsbad -> Sedona **575 mi**, departing **04:05**.

### ★★★ KIM REMEMBERS EVERY ONE OF THE LONG DAYS (2026-08-18)

On being shown the four longest days, his reply was immediate: *I remember why I drove each of those. One was a navigation error; we went 100 miles off course and we were almost late for a dinner appointment.* And: *for me, a lot of this is memory lane material.*

**This is the strongest possible evidence for the TWO LOGS, TWO SUBJECTS frame, and it arrived unprompted.** A 575-mile day is a number in the fuel spine. It is an EVENT in the human spine -- it has a cause, a consequence, and a person who can still tell you both fifteen years later.

**Consequence for the document, and it changes the writing order:** the trip-log outliers are not anomalies to be explained away, they are **chapter hooks with a living source**. **Ask Kim for the story behind each long day BEFORE writing the analysis chapter**, because the analysis will otherwise describe a distribution where the reader wants a reason. The four to ask about:

| date | leg | miles | note |
|---|---|---|---|
| 2015-07-07 | Carlsbad CA -> Sedona AZ | **575** | departed 04:05; routed via Palo Verde and Seligman, far off the direct road |
| 2017-01-06 | Brookings OR -> Paso Robles CA | **562** | arrived 22:10 |
| 2012-05-31 | St Louis MO -> Columbus OH | **517** | |
| 2012-06-14 | Billings MT -> Pocatello ID | 448 | **65.4 mph gross -- the fastest day in the record** |

**★ The 575-mile day is the leading candidate for the navigation error** -- its routing is the one that cannot be explained by the map. Do not assert that; ask him.

**And a methodological note worth keeping.** The 100-miles-off-course day is a case where the odometer is RIGHT and the route is wrong. Every geographic test in the audit toolkit assumes road distance >= straight line; a navigation error inflates the ratio without any error in the data. **A high GMaps/SL ratio is not always a defect. Sometimes it is a story.**



## FLORIDA AND THE DRAGON — moved from proj 2026-08-19 (summary kept there; rules in Finding 036)

### ★★★ FLORIDA — I CONCLUDED HE NEVER GOT THERE. HE DID, AND THE RECORD CANNOT SHOW IT

**My inference, 2026-08-19: Florida appears in no fuel stop of 294 and no leg endpoint of 107, therefore TwoRed never reached it. WRONG.** Kim's account:

> I aimed at the panhandle. I drove just barely (a few miles) into what I thought was Florida. I stopped at a neighborhood intersection and got the attention of another driver. "Is this Florida?" "Yes." That's all I needed. Back in the car and I was out of the state as quickly as I had entered.

**★★★ THE GENERAL LESSON, and it is the most important methodological point in the project.** **A RECORD'S RESOLUTION SETS THE FLOOR ON WHAT ITS SILENCES CAN MEAN.** This log resolves to two events: BUYING FUEL and ENDING A DAY. Kim did neither in Florida, deliberately -- the whole point was to touch the state and leave. **So the visit is not faintly recorded, it is UNRECORDABLE, and no amount of care with the data would have found it.** The card's ABSENCE CLAIMS rule says never assert something is missing without proving it; I proved only that no FILL-UP and no OVERNIGHT happened there, and then asserted something about a JOURNEY.

**And the geographic test confirms it is beyond reach.** The dip hangs off the New Orleans -> Atmore stretch: **Atmore, Alabama is about 12 road miles from the Florida line at Century**, and it is a fuel stop on exactly the right day. Road-to-straight-line for that stretch is **1.23 against a trip median of 1.22 (IQR 1.11-1.39)**. **A ~25-mile out-and-back on 210 miles is indistinguishable from ordinary routing.** The instrument has a floor and this sits under it.

**So the trip DID complete the 49 mainland states**, and the name *Penultimate State* must mean something else -- ask him. **The chapter beat is better than the one I invented:** not a goal lost to a calendar, but **a state claimed in a few minutes at a neighbourhood intersection, on the word of a stranger.** The cheapest possible acquisition of the hardest remaining item. And the record he kept so carefully for sixteen years has no idea it happened.

### ★★ THE TAIL OF THE DRAGON — and a second piece of my reasoning that was wrong

Kim, next goal after Florida: *The Tail of the Dragon. That was on the way to my meeting and it was a not-to-be-missed drive.* US-129 at Deals Gap on the NC/TN line.

**I had argued the Montgomery -> Cherokee leg had no room for a detour: 407 logged against ~400 direct. That reasoning was worthless, because the route was never the direct one.** The fuel stops give the waypoints: **Montgomery 43,159 -> Trussville AL (Birmingham) 43,266 -> Madisonville TN 43,462 -> Cherokee 43,566.** Madisonville is in EAST TENNESSEE. The leg went north through Birmingham, Chattanooga and Knoxville -- **which is how you get to Deals Gap** -- and not east through Atlanta at all.

**The last stretch settles it: Madisonville -> Cherokee is 104 odometer miles.** Direct is about 75. Via US-129 over the Dragon and down through Robbinsville is about 105-115. **The Dragon is in the odometer.**

**★★ RULE: A MATCHING TOTAL DOES NOT MEAN A MATCHING ROUTE.** Two quite different paths totalled within seven miles of each other and I read the agreement as proof. **Check the intermediate fuel stops before inferring anything about a route from its endpoints** -- they are the only waypoints this record has.



## ★★ THE CORRECTED DATASET EXISTS (2026-08-18)

**`twored_ingest.R`** (in `Projects\Smart_Car`) reads the UNTOUCHED xlsx plus a machine-readable
corrections table and emits **`data/TwoRed_fuel_clean.csv`** -- 294 rows, 16 columns, provenance on
every change. Nothing is edited in place; re-running reproduces it from the sources.

| Test | before | after | with hypotheses |
|---|---|---|---|
| pump identity fails | 15 | **5** | **2** |
| MPG > 60 (non-partial) | 5 | **0** | 0 |
| MPG < 22 (non-partial) | 1 | **0** | 0 |

**Three things the build forced that the errata could not express:** a **ROW INSERT** (the merged
Big Spring/Alpine row -- a whole fill-up was missing, not a wrong field); **EXPLICIT FLAGS** (Woody
Point is 3.74 gal, just over an arbitrary 3.5 threshold, so partial fills now come from the errata
rather than a cutoff); and **A GUARD THAT REFUSES** -- every correction must find the value it claims
to replace. It refused a date correction because the sheet stores Excel serials, and it caught two of
my odometer keys pointing at the wrong rows. **Finding 032 is written into the code:** the script
asserts rows may be ADDED but never silently lost, and prints the count.

**The two survivors are honest ones:** Deming (arithmetic wants 20.85 but the slashed-zero DIRECTION
is wrong, so it is flagged not applied) and Haines Junction -- **not a typo but a UNITS design flaw
my own L32 fix created**: a USD cost against a CAD-derived price. That row needs a CURRENCY column.



## ★★ THE CARD COVERS THE FLEET; THE LOG COVERS ONE CAR (2026-08-18)

Kim's **AMEX fuel summary for 2015** -- 16 charges. **Eight match the TwoRed log to the cent.
Eight do not, and those eight are the OTHER CARS.** Seven are Hawai`i (six Costco Honolulu, one
Tesoro Hilo); one is a 7-Eleven in **Orlando, Florida**, where TwoRed never was -- almost certainly
a rental. **Every mainland-west charge matches. The card is a FLEET-level record and the fuel log is
a SINGLE-CAR record, and the difference between them is itself data.**

### ★★ The scope boundary appears a FOURTH time -- and this time an outside source proves it

**AMEX 01/10/2015 COSTCO HONOLULU $19.74 matches TwoFer's final logged fill EXACTLY** (1/10/2015,
9:19 AM, Costco, ODO 1,209, 6.93 gal, $19.74). **And then the card keeps going where the log stops:**
six further Hawai`i fuel charges from February to October 2015.

At TwoFer's own logged averages (6.675 gal/fill, 31.3 MPG) those six fills are **roughly 1,254 miles
-- against the 1,209 the log records. The log captures about HALF of 2015 use.** *(ESTIMATE ONLY: the
card gives a count of charges, not gallons or odometers. Do not print this as a measurement.)*

**Why it matters.** The fractal-scope section already showed the same rule at fleet, car and trip
level, inferred each time from the record's own shape. **This is the first time an INDEPENDENT source
has confirmed it**: the log stopping is demonstrably not the car stopping. It is the exact pattern of
TwoRed's 71,181 against ~75,000, now visible in a second car and a second document.
**And it does not complicate the 2x2 role split -- it strengthens it.** Every one of those unlogged
fills is in Honolulu or Hilo. **TwoFer stayed a short-haul car even in the miles nobody wrote down.**



## ★★★ THE FAVOURITE DRIVES — and what the odometer says about them (2026-08-19)

Kim's own list, offered unprompted by any number. **Verbatim in `logs/proj_Smart_Car_log.md`.** The Rockies; the mountains down to the Oregon coast; **a morning on the sweeping highway through the West Virginia hills, villages fogged in the valleys and chimney smoke rising** -- *I liked this so much, I drove it twice*; and the Dalton, *going where cars weren't intended*.

**★ West Virginia twice is in the record, and the second pass is SLOWER.** Morgantown WV is a fill on **2012-06-01 at 12:33 (66 degF)** outbound to Frostburg, and again on **2012-06-08 at 08:58 (60 degF)** on the way back. **The morning pass is the one he describes**, and its leg runs **33.9 mph gross against 45.5 outbound**, over a slightly longer distance. **A drive being savoured shows up as slowness.** Gross speed cannot tell pleasure from a traffic jam -- but paired with the account it reads cleanly, and that pairing is the whole method.

**★★ The Dalton return is the slowest long day in the record: 298 mi in 13.2 h, 22.6 mph**, out at 07:52 into **38 degF**, in at 21:03; outbound the day before was 28.6. **Gravel is worth six miles an hour.**

**★★★ AND THERE ARE 46 MILES ON THAT ROAD THAT NOBODY HAS EXPLAINED.** Ester -> Coldfoot is **252** odometer miles; Coldfoot -> Ester the next day is **298**. Same road, 46 miles more coming back. Kim's drama -- *the car slid forward on the gravel roadbed going down a very steep section; would we be able to go back up? We were* -- belongs NORTH of Coldfoot, where the Dalton climbs to Atigun Pass. **23 miles up and back is 46.** **ASK HIM: did you push north of Coldfoot on the morning of 18 August before turning round?** If so the odometer holds the drama and nothing else in the record mentions it.

**★★ THE STUCK-IN-ARIZONA CORRIDOR IS IDENTIFIED, AND THE EPISODE IS INVISIBLE.** *Following Google Maps across tribal lands, a dirt road, a right turn too close to the edge, powdery soil, completely stuck, then a truck with two men gave me a push.* **Route: 2016-05-27/28, Winslow AZ 58,746 -> Monticello UT 59,013 -- 267 odometer miles north through the Navajo Nation, the road past Monument Valley.** Phoenix sits on the leg before (Blythe -> Winslow, 331 mi). **This is the Fourth Crossing, the one stretch with NO trip-log sheet**, so there is no departure time, no arrival time, no note. **Finding 036 again: the unit of observation is the fill-up, and hours stuck in powdery soil do not generate one.**

**★ One flag, not a claim.** The 2016 fills at Winslow, Gypsum and Big Springs read **52.2, 50.2 and 56.0 MPG** -- three consecutive values in the top 3%, in exactly the stretch rebuilt from pump receipts. Long legs do raise economy (+4.61 MPG per 100 mi) and 15 full fills exceed 48 MPG across sixteen years, so this is **not** evidence on its own. **But Kim placing Phoenix on the 331-mile Blythe -> Winslow leg is an independent reason to look for an unrecorded fill there.** Re-check against the AMEX before the Fourth Crossing is written up.

**★★ And a note for the toolkit.** *Memo to self: stay on the main roads.* **Following a routing app onto unpaved tribal roads produces exactly the signature the geographic test hunts** -- excess road miles over the straight line, plus low economy from rough surface. **It is not an error. It is a wrong turn a machine recommended.** Third case now where a high ratio wants a story rather than an errata entry.



## ★★ FIRST ANALYSIS ON CLEAN DATA -- SIX RESULTS (2026-08-18)

**1. THE URBAN-COMMUTER CLAIM IS REFUTED, AND THE NUMBER SURVIVES THE OBVIOUS OBJECTION.**
**Median distance between fill-ups: 251 miles**; 5th percentile 159; **87% of logged miles in legs
of 200+.** The objection -- *he only logged long trips* -- fails on arithmetic: the log spans **71,177
miles of a car that reached ~75,000, so ~95% of the odometer is in the sample.** It is not a
subsample, it is nearly the population.

**2. AN INDEPENDENT CHECK AGREES.** Lifetime **39.44 MPG**, at the HIGHWAY end of the 2010 Fortwo's
own 33/41 EPA range -- what a car averaging 251 miles between stops should show, and not a commuter.

**3. LEG LENGTH DOMINATES ECONOMY: +4.61 MPG per 100 extra miles between fills** (p<0.0001).
The city-vs-highway penalty, measured from Kim's own tank rather than quoted from a manufacturer.

**4. THE CAR DID NOT DEGRADE.** Controlling for route mix, MPG **ROSE +0.30 per 10,000 miles**
(p=0.030) -- about **+2 MPG across its life.** Not the expected direction over 71,000 miles.

**5. FUEL COST.** $6,663 total, **$0.0936 per mile lifetime**, yearly range $0.069-$0.108. Price paid
peaked 4.199 (2013), bottomed 2.769 (2017) -- a 34% fall tracking the real 2014-15 collapse.

**6. NO TEMPERATURE EFFECT DETECTED -- and the reason is actionable.** +0.20 MPG per 10F, p=0.75,
n=58, over a range of only **38-94F**. The large cold-weather penalty lives near freezing.
**The data to test it is on the paper and was never transcribed** (see deferred.md).



## ★ THE ERRATA ARCHITECTURE, AND THE RULE THAT DRIVES IT (2026-08-17)

**Nothing is ever overwritten. Corrections live beside the sources and are applied as a DERIVED
LAYER at read time.** Three files in `data/`:

| File | Holds |
|---|---|
| `TwoRed_log_errata.csv` | 11 corrections to the FUEL LOG, each with basis, evidence and status |
| `TwoRed_gazetteer_errata.csv` | 4 corrections to the COORDINATES -- a different artefact, different fixes |
| `TwoRed_leg_distances.csv` | all 292 legs with `distance_basis` (measured / disputed / unresolved) and `distance_source` |

**★ THE ADJUDICATION RULE, and it came from Kim's own GMaps checks: A ROAD DISTANCE CAN NEVER BE
SHORTER THAN THE STRAIGHT LINE. So when GMaps comes in BELOW the great-circle, the COORDINATE (or
the city name behind it) is wrong -- not the odometer.** That one test says which END to fix, and
it is automatable. Applied to Kim's four checks, ratios of 0.61 / 0.75 / 0.69 -- all physically
impossible -- became **1.21 / 1.08 / 1.18** once the real towns were used. **In three of four cases
the odometer had been right all along.**

**★ THE LINE THAT MUST NOT BE CROSSED: reconstruct DISTANCES, never ODOMETER READINGS.** A distance
is an estimate and can be labelled one. An odometer value is a claim about what the car said, and
inventing one propagates a false measurement into the MPG of the fills on either side. Where the
reading was never written (Waynesburg PA, 2010-11-07) the odometer stays **blank** and the distance
carries GMaps 227 as `reconstructed`. Kim, 2026-08-17: *documenting the procedure rather than
inventing data.*

**GMaps is a DATED INSTRUMENT** -- recorded as `gmaps_2026`, because 2026 roads are not 2010 roads.
Same discipline as the temperature and trip-log-onset rulings.

**Impossible legs 15 -> 10 after corrections; 4 of those are the ferries, so 6 are genuinely open.**
Big Spring TX improved from ratio 0.37 to 0.83 -- still impossible, so it has graduated from
geocoding artefact to real odometer suspect.

**★ THE DEFENSIBLE HEADLINE, reproducible from the file rather than asserted:**
**69,689 miles across 285 measured legs. 1,488 miles (2.1%) sit in disputed legs and are excluded.
97.9% of the logged distance rests on undisputed odometer readings.** This tightens as scans arrive.



## ★★ THE AUDIT TOOLKIT -- FIVE INSTRUMENTS, NONE REDUNDANT (2026-08-18)

| # | Test | Catches | Blind to |
|---|---|---|---|
| 1 | **pump identity** `gallons x price = cost` | typed digits in the money/volume fields | anything self-consistent -- including a MERGED row |
| 2 | **economy** implied MPG between fills | missing rows, partial fills | rows that balance |
| 3 | **geography** straight line vs odometer | wrong city/state, mis-geocodes, odometer digits | errors that stay on the route |
| 4 | **contiguity** repeated values in neighbouring rows | spreadsheet FILL-DRAG (correlated, not independent) | isolated typos |
| 5 | **price family / same pump** | prices out of regional, seasonal or per-seller family | volumes and odometers |

**Every major error found on 2026-08-18 was caught by exactly ONE of these, and several needed TWO
to be pinned down.** The decisive combination proved to be **contiguity + arithmetic**: when two
adjacent rows share a value, **the row that BALANCES is the source and the row that FAILS is the copy.**
Neither reaches that alone -- contiguity cannot tell contamination from coincidence, and arithmetic
cannot say where a bad value came from.

**★ A SIXTH INSTRUMENT, WHICH IS KIM'S HANDWRITING.** Four typos across 2011-2015 shared one shape:
a ZERO recorded as an EIGHT. Kim named the cause -- **he writes slashed zeros**, and a slashed 0 scans
as an 8. Run as a search generator it found two further candidates from residuals previously dismissed
as rounding; **then the mechanism REJECTED one of them**, because the error is DIRECTIONAL. Control:
0<->8 scored 2 hits in 15 substitutions; 1<->7 scored 0 in 19; 3<->5 scored 0 in 20. **Finding 033.**

**⚠ ITS LIMIT: for the 0/8 class, SCANS ARE NOT EVIDENCE.** Coarse Gold appears to read 7.385; a
7.305 written with a slashed zero looks identical. **The scan is where the illusion lives**, so only
arithmetic, a card or a receipt can adjudicate. Recorded because it would have been easy to 'confirm'
the wrong value by looking harder.



## ★ THE SCOPE BOUNDARY IS FRACTAL (2026-08-17)

The same rule operates at three levels of the data, and at every level the excluded thing is the
same: **city driving.**

| Level | Logged | Not logged |
|---|---|---|
| **Fleet** | TwoRed, Creamsicle | Two4Two/TwoFer, Bordeaux -- the Honolulu cars |
| **Car** | TwoRed while it was doing long trips | the Honolulu years; `TwoRed_fuel_June_2014` IS the last log |
| **Trip** | 15 legs, 4,635 mi (2011 St. Louis Trip) | **465 mi, 9%** -- local driving in St Louis, Moab, Fort Worth |

Kim, 2026-08-17: *we're laser focused on the long drives, not the city stuff.*

**★ CONSEQUENCE, AND IT IS A RULE FOR THE ANALYSIS: these gaps are DEFINITIONAL, NOT MISSING DATA.**
Never impute them, never fill them, never caveat them as incompleteness. **The dataset's absences
encode the thesis** -- a record that omits city miles is the artefact of a person who considered
only long-distance driving worth recording, which is precisely what the document argues a Smart
was used for. A completeness check that flags these has misunderstood the project.



## ★ THE FLEET SPLITS 2x2 -- BY DISTANCE ROLE, NOT POWERTRAIN (Kim, 2026-08-16)

**This supersedes the 2026-08-12 axis of "three ICE + one electric".** The organising split is
what each car was FOR:

| Role | Cars |
|---|---|
| **Long-distance** -- the document's subject | **TwoRed**, **Creamsicle** |
| **Honolulu short-haul** -- deliberately minor | **Two4Two / TwoFer**, **Bordeaux** (electric) |

**Why this is better than the powertrain axis:** it cuts across it (one Honolulu car is ICE, the
other electric) and it matches how the data was actually GENERATED -- Kim logged fuel while a car
was doing long trips and stopped when it wasn't.

**★ It also makes the thesis more honest, and therefore stronger.** "A Smart is not an urban
commuter" was never quite true -- **two of the four were exactly that.** The defensible claim is
that the SAME owner ran the SAME marque both ways for sixteen years, and only the long-distance
half was worth logging. **The Honolulu pair is not filler; it is the control that makes the
contrast measurable instead of asserted.**



## ★ THE CHAPTER ARCHITECTURE IS NOW THE WEAKEST PART (2026-08-16)

Stated plainly so a future session does not inherit it by default. The project now has a
quantitative spine on two cars, a drafted narrative on one, a photo layer that joins to both, and
a defined minor role for the Honolulu pair. **The architecture below has none of that in view --
it was written for one car and one trip.** Redesign it before writing prose. Live candidates: the
2x2 role split as the top-level frame, and the two long-distance cars as parallel spines rather
than one primary plus supplements.



## ★★ THE SCAN SWEEP, 2026-08-18 — full write-up in the log; the four results kept here

All 15 scans read: 18 pages, 7 files, every column. **Trip legs 69 -> 107** (101 with usable times); **fuel rows with a time and temperature stamped ON THE FILL 0 -> 95** (32%). The 2011 St. Louis file was a pure duplicate -- zero new legs -- but re-opening it returned 23 fuel-row temperatures the first pass had walked past. **Detail in `logs/proj_Smart_Car_log.md`.** What must not be lost:

**1. The wheel change is DATED: `NEW WHEELS @ 13510 miles`, Kim's margin, 179 mi before the 2011 departure.** So the narrow-tire group is exactly 2010-07-23 to 2011-05-11. **The estimate FLIPS SIGN with specification** -- raw +1.7%, +leg length +3.6%, +odometer trend +1.6%, local +/-12,000 mi -1.8%, +temperature -1.5%. **That is the finding. Not any one of those numbers.** The CONDITIONAL in `deferred.md` governs.

**2. Temperature is not null once measured ON THE FILL** (the earlier test used leg endpoints, the wrong unit). n=94: **-0.068 MPG/degF, p=0.045**, stable -0.068 to -0.084 across four specifications; fills at 80 degF+ average **36.76** against **38.87**. **A SIGNAL, NOT A FINDING** -- p crosses 0.05 under era fixed effects, and the counterintuitive sign points at A/C load, which is inferred and not measured.

**3. The slashed zero produced three more corrections and the control held.** Over the 44 rows failing the pump identity, a single-digit substitution in the cost: **permitted 8->0 fixes 4; forbidden 0->8 fixes 1** (Deming, already flagged wrong-direction); **six control substitutions fix 0.** New L59-L61; errata at 61.

**4. Gross speed separates by ROAD, across 107 legs.** 2011 interstate **47.6** | 2012 Frostburg 43.5 | 2017 January 41.2 | 2011 N. California 40.6 | 2014 Penultimate State 39.7 | 2015 Sedona 39.0 | 2012 May Arizona 36.9 | 2013-4 LA 34.6 | 2013 Dalton Highway **30.9** | 2016 US-101 coastal **28.3**. Same car throughout. **And see THE LONG DAYS above: the tails are set by lodging geography and ferry timetables, not by the road alone.**



## ★★★ THE FOURTH CROSSING LOG IS FOUND — 9 pages, 25 legs, and the reconstruction was RIGHT (2026-08-19)

Kim scanned `2016_Fourth_Crossing_Log.pdf` the same afternoon he was asked for it. **It is the trip we had rebuilt from AMEX statements and pump receipts because the paper was believed lost.**

| | before | after |
|---|---|---|
| trip legs | 107 | **132** (126 with usable times) |
| fuel rows with time + temperature | 99 | **127** (43% of the log) |
| fuel rows sitting under a trip log | 140 (48%) | **169 (57%)** |
| temperature observations | 146 | **382**, range **32-107 degF** |
| errata | 61 | 65 |

### ★★★ THE RECONSTRUCTION HELD. All 29 paper rows balance the pump identity (max residual half a cent), and **25 of 29 are identical to the corrected dataset on brand, price, gallons and cost.**

**The L11 and L38 values recovered from card statements and pump receipts match the paper EXACTLY on gallons and cost.** LSM 3.641/$10.92, Blythe 4.531/$14.04, Winslow $15.48 -- every one confirmed by a source that did not exist when they were derived. **That is as strong a validation as this project can produce: an independent record, arrived at afterwards, agreeing to the thousandth of a gallon.**

The four differences are all mine and all minor. **L62 Blythe and L63 Winslow: I had written the AMEX MERCHANT NAME into the Brand field** (`Quick Check West`, `Hallum Store`) because the card was the only source; the paper gives the actual brands, **Valero** and **Conoco**. **L64 Burlington `Hy-Vse` -> `Hy-Vee`**, a plain typo. **L65 Cherokee gallons 6.002 -> 6.003** -- both satisfy the pump identity, so arithmetic cannot separate them and the PAPER is the source. **Lesson: when a field is filled from a substitute source, record WHICH source, because a merchant string is not a brand.**

### ★★ AND THERE IS NO PHOENIX FILL

The 5/25-5/27 fuel table reads LSM -> Blythe -> Winslow with **nothing between them.** **The missing-fill hypothesis I raised and then withdrew on three statistical grounds is now settled on documentary ones.** The withdrawal was right; the reasoning that produced it was right; and it took a piece of paper to make it certain.

### ★★★ THE STUCK DAY IS FULLY RECOVERED

**2016-05-27, Youngtown AZ (a Phoenix suburb, where he had overnighted) -> Monument Valley UT.** Out at **06:40 in 72 degF**, in at **17:17**, **362 odometer miles**, 9.62 h once the Arizona-to-Utah zone change is applied, **37.6 mph gross against the trip's own median of 41.4.**

**Youngtown to Monument Valley is about 320 road miles. He drove 362. The dirt-road detour is 42 miles, and the day is 4 mph slower than his own average for the trip.** Both the excess and the slowness are exactly what *following Google Maps onto unpaved tribal land, then getting stuck in powdery soil* should look like. **The episode was invisible yesterday because the record's unit of observation is the fill-up (Finding 036). It is visible today because the unit changed.**

### ★★ A NEW LONGEST DAY, BY EIGHTY MILES

**2016-06-19: Richmond MO -> Denver CO, 640 miles.** Out 06:57, in 16:53, 10.93 h with the Central-to-Mountain change, **58.6 mph gross**. Three fills en route -- Junction City 10:09, Oakley 13:43, Watkins 16:35 -- and each segment independently runs 57-60 mph. **I-70 across Kansas is the fastest road in the record and this is what it permits.** The previous longest was 562.

**Also new: 107 degF arriving St George on 6/21**, the hottest reading in sixteen years, and **101 degF into Grand Junction the day before.**

### ★ TWO THINGS TO PUT TO KIM

**1. A time conflict on 5/26.** The Blythe fill reads **6:08P** at odometer 58,415; the arrival at Youngtown reads **7:41P** at 58,559. That is 144 miles in about 1.5 hours -- **93 mph, impossible.** Either the fill is 4:08P or the arrival is 9:41P; **both give 41 mph and nothing in the data separates them.** He holds the original.

**2. West Virginia, driven twice -- there are now TWO candidate pairs.** The 2012 Morgantown pair (I-68, out 06-01 and back 06-08), or **the 2016 pair: Huntington WV -> Richmond VA on 6/12 and Richmond -> Morehead City NC on 6/13, both on I-64 through the Greenbrier hills, on consecutive days** -- with the Lewisburg WV fill sitting on the eastbound run. **The 2016 pair is the better fit for *I liked this so much, I drove it twice*: same road, out and back, one day apart.** Ask him which.



## ★★ TWO RELOCATIONS, AND A TRIP NAME THAT SURVIVED IN ONLY ONE SCAN (2026-08-19)

Three more scans arrived, six of eight pages duplicates. **A duplicate page carried an annotation the earlier scan of the same page did not show: `Relocation  1141 miles`.** The 2016 fall-winter legs run odometer **66,645 -> 67,786 = 1,141. Exact.**

**So September 2016 was not a tour. It was the one-way relocation of TwoRed to Oregon** -- which is why the car was at a friend's house in Eugene when the January 2017 call came about his mother. **And February 2017 is a SECOND relocation** (new, from 2017 pp.2-3): Mentone -> Long Beach -> Santa Maria -> S. San Francisco -> Point Arena -> Brookings -> **Eugene**, after which the car sits until 20 May.

**★ That is the shape of the record's last year, and it was invisible until now: the car stops touring and starts COMMUTING BETWEEN TWO HOMES.** The fuel log's own ending -- Eugene 2017-05-20, Toledo WA 2017-05-22 -- is the third northbound run, and it simply stops. **The scope boundary appears one final time: the log ends when the long-distance role ends.**

**★★ METHOD NOTE: two scans of the same page are not the same evidence.** A marginal annotation can survive in one and be lost in the other -- to cropping, to threshold, to the fold. **When a duplicate turns up, diff it rather than discarding it.** This one yielded a trip name, a verified total, and the frame for the project's final chapter.



## ★ THE AMEX STATEMENTS ARE A THIRD INDEPENDENT RECORD (2026-08-18) — detail moved to the log

Full write-up verbatim in `logs/proj_Smart_Car_log.md`. **The card statements are independent of both the paper and the spreadsheet, which is what makes them decisive.** The four things worth carrying forward:

1. **An elegant single-cause hypothesis of mine was REFUTED by one line of Kim's statement** -- the town was    Alpine, not Big Spring. Two independent estimates agreeing within 45 miles, and still wrong.
2. **The merged row was a CHIMERA and needed a SPLIT, not a relabel** -- labels from one stop, all four    numeric fields from another, which is exactly why it passes the arithmetic test perfectly.
3. **Errata key to a ROW, never a LABEL.** `Big Springs, Texas` appears three times and means three    different places.
4. **All five ferries are identified** (Alaska Marine Highway x2, Newfoundland x2, Lake Michigan x1) -- and    the Lake Michigan crossing is now confirmed a second time, in Kim's own hand on the Frostburg-3 sheet.



## Current Status
**★ UNBLOCKED 2026-08-16 -- THE CREAMSICLE DATA IS FOUND, AND IT WAS NEVER A FILE.**
Every earlier search looked on disk for spreadsheets. Creamsicle's records are **Google-native
documents at the root of `G:\My Drive`**, which Drive Stream presents as zero-byte placeholder
stubs: `file.info()` reports 176 bytes for `Final Creamsicle Logs.gsheet` and `readBin` returns
**0**. The ground-truth rule caught the lie; the Google Drive connector read straight through it.
**The generalisable lesson, and the reason this sat blocked for months: a filesystem sweep cannot
see a Google-native document. Search the Drive API by title before concluding data does not exist.**

**The reversal:** TwoRed's Trip Log is 7 rows; **Creamsicle's is the real one** -- dozens of daily
legs, 2021-09-23 to 2024-10-20, with departure/arrival times and cities, Miles, Duration, Stop time,
Adjusted Duration and Miles/Hour already derived. The **average-speeds analysis Kim named is the
readiest in the project, and it lives on the car the PKM had filed as the gap.** Creamsicle also
arrives with a **drafted 9-trip narrative**, not raw material.

Intake completed 2026-08-12. **Development is now Ready.**

_Superseded (2026-08-12):_ **Intake completed; development BLOCKED on Kim's data recovery.** Materials
moved out of `kimbridges-stories/underway/` (where they had been mis-filed as a story
since 2026-05-06) into `Projects/Smart_Car`. No code written yet, by design: the data
cannot support the reframed scope until Kim finds the paperwork on the other three cars.
He will do that in miscellaneous time, not in a focused session, which is why this file
reads Blocked rather than Ready.

**This was the third intake gap of the Jones / vouchr shape** -- real project materials,
a written charter, no `proj_*.md` and no index row, dormant three months.



## ARCHIVE — moved from proj_Smart_Car.md 2026-08-19 (budget trim)

Pointers stand in the project file. Verbatim originals follow.

### [archived] ★★ THE WHEELS WERE NEVER ABOUT FUEL (Kim, 2026-08-18)

The first crossing ran on the stock narrow "city" tires. On open highway the car was blown around by crosswind and the handling was difficult. Smart Madness -- Kim's mechanics -- prescribed WIDE tires; fancy rims came along with them, because this is a car that is fun to drive and fun to be seen in. It worked. Handling became very good.

**The purpose was handling, not economy.** That reframes what the fuel data can say. Wider tires carry a real theoretical cost -- more rolling resistance, more frontal area -- usually put at 1-3%. So the question the data answers is not "did the wheels help?" (they did, on the axis they were bought for) but "what did that help cost?"

**Answer, stated honestly:** before/after the change, the difference in economy is not distinguishable from zero, with a 95% interval of **-3.7% to +4.9%**. The theoretically expected 1-3% penalty sits INSIDE that interval. So the correct claim is the narrow one:

> The data rules out a LARGE fuel penalty from the wide tires. It is too small a sample to detect the modest penalty theory predicts. Absence of a detected effect is not absence of an effect.

I first wrote the stronger version ("rules out a penalty worse than 3.7%") and had to withdraw it in the same turn. Logged because it is the same failure mode as Finding 032: a number that looked like a bound was actually one end of an interval that straddles zero.

**For the story:** this is a clean example of the document's recurring shape -- a decision made for one reason (safety and pleasure in a crosswind at 70 mph in a 1,800-lb car), then measured on a different axis (fuel), and the measurement's job is to say what the decision cost, not whether it was right. Kim already knew it was right; he drove it.


### [archived] ★★★ KIM'S FRAME: TWO LOGS, TWO SUBJECTS (2026-08-18)

His words: *the fuel log is more about the CAR'S performance, while the trip log shows the HUMAN performance -- how far and fast can you expect to drive in a day, something I had no idea about until I started doing these drives.*

**This is the strongest organising idea the project has produced, and it should be the top frame of the chapter architecture** -- which has been the named weak point since 2026-08-16 precisely because it was inherited from a one-car charter and had no thesis under it.

**Why it is more than a nice phrasing:**

- **It explains why neither log substitutes for the other.** The fuel log records STOPS; the trip   log records LEGS. They are not two views of one thing, they are measurements of two different   subjects that happen to share an odometer. The odometer is the JOIN, not the topic.
- **It tells us which instrument answers which question.** Economy, degradation, cost per mile,   the wide-tire question -- car. Daily range, departure discipline, gross speed, the length of a   driving day -- human. **Mixing them is how you get a meaningless average.**
- **It makes the temperature decision obvious.** Temperature stamped on a FILL belongs to the car's   question; temperature at a leg endpoint belongs to the human's. Same word, two instruments.
- **★ It supplies the missing NARRATIVE thesis.** Kim did not know the answer before he drove it.   So the human half is not a summary statistic -- it is a **finding he made about himself by doing   the thing**, sixteen years of it, and the data is the record of the learning. The 3-bar refuelling   rule adopted at Deming in 2010 is exactly this: a behaviour CHANGED by a near-miss, and visible   in the numbers afterwards.
- **And it explains the collection history rather than apologising for it.** Trip logging started   LATER than fuel logging (Kim's ruling, 2026-08-17). Of course it did: **the car's question was   the obvious one to ask first. The human question is the one the driving itself taught him to ask.**

**First evidence that the human axis is measuring something real:** across 69 legs, median gross speed separates by ROAD, not by car -- 2011 interstate **47.6 mph**, 2014 mixed **39.7**, 2013 Dalton Highway **30.9**, 2016 US-101 coastal **28.3**. The car was the same car throughout.


### [archived] ★★★ WHY THIS IS NOT FINDING 036

**Finding 036 was about events that generated NO observation** -- Florida, being stuck in powdery soil. Nothing was recorded because nothing recordable happened.

**This is the opposite. These miles generated a FULL set of observations -- distance, elapsed time, fuel, temperature, both endpoints -- and every one of them is normal.** The record is not silent. It is answering a different question, at a resolution that cannot reach the answer.

**★★★ THE FUEL LOG AND THE TRIP LOG BOTH MEASURE OUTPUT. NEITHER MEASURES COST TO THE DRIVER.** Miles, hours, gallons, degrees -- all of it is what the car and the day PRODUCED. **Vigilance has no column.** A driver can buy an ordinary 44 mph day at an extraordinary price and the log will record the 44.

**This sharpens Kim's own frame rather than contradicting it.** He said the trip log shows *the human performance -- how far and fast can you expect to drive in a day*. True, and now bounded: **it measures what the human ACHIEVED, never what it COST him.** The second quantity exists, it varies enormously across these sixteen years, and **the only instrument that ever recorded it is his memory.**

**Consequence for the document, and it is a strong one.** Where the analysis chapters can only report output, **the stories are not colour around the data -- they are the sole record of an entire dimension the data cannot reach.** A chapter that presents 44.5 mph across Saskatchewan without saying what those miles felt like is not being neutral. It is reporting one axis of a two-axis thing.


### [archived, condensed in proj] KIM'S CORRECTION INVERTS THE LOGIC — original

★★★ KIM'S CORRECTION INVERTS THE LOGIC — the data does not fail to corroborate him, it IS his mechanism

He revised his own words the moment he saw the table: *I should have said "abruptly slowed, then quickly speeded up". The problem was that I couldn't go slow as big vehicles kept moving at highway speeds. Hence the rear view mirror checks.*

**That changes everything about how the null reads.** I had treated *no speed effect* as the record failing to support his memory. **His account PREDICTS no speed effect.** He was not free to drive slowly -- trucks were closing at highway speed behind him -- so the average had to stay up. **The high gross speed is not evidence against the stress. It is the mechanism OF the stress.** Being forced to hold 45 mph through a road you want to crawl is exactly what made those miles cost something.

**★★★ AND IT NAMES THE MISSING QUANTITY PRECISELY: WITHIN-LEG SPEED VARIANCE.** Brake hard for a hole, accelerate back to seventy, check the mirror, repeat. **A trip log samples the day TWICE -- once at departure, once at arrival. Everything between the two samples is averaged away BY CONSTRUCTION.** No quantity derived from two endpoint readings can see variance, and variance is the whole of what he is describing.

**So the earlier statement was right but blunt.** *The log measures output, not cost to the driver* is true. **The sharper version: the log records MEANS and cannot record VARIANCE, and the cost lived entirely in the variance.**

**I did look**, because his correction points at economy rather than speed -- repeated decel/accel cycles should show there if anywhere. Canadian 2014 residual **SD 4.87 (n=18)** against the US **4.73 (n=268)**, F-test **p = 0.79**. **Nothing.** And it could not have been anything: **those rows were converted from LITRES and Canadian dollars, and unit-normalising that sheet is still an OPEN item** -- a per-row conversion inflates spread by itself, so the test cannot separate rough-road behaviour from arithmetic. **Recorded as a non-result, not a null.**




## ★★★ THREE ANSWERS FROM KIM, CHECKED (2026-08-19) — summary in proj

### 1. The 46 Dalton miles: the fuel log splits them 32 / 14, and only the 32 is the Dalton

The gap was Ester→Coldfoot **252** against Coldfoot→Ester **298**. Both legs are odometer-continuous (Aug 17 ends 36967, Aug 18 starts 36967), so all 46 miles sit inside the return leg. **But TwoRed fuelled at Yukon River Crossing in BOTH directions, and that intermediate fix splits the leg into two independently comparable halves:**

| segment | north | south | difference |
|---|---|---|---|
| Ester ↔ Yukon River Crossing | 137 | 151 | **+14** |
| Yukon River Crossing ↔ Coldfoot | 115 | 147 | **+32** |
| | 252 | 298 | +46 |

**The 32 miles are north of the Yukon River — the Dalton segment. Coldfoot is Dalton mile 175; the Wiseman village spur is about 16 road miles further. Out and back is 32.** Kim's account and the odometer agree to the mile. The other 14 are at the Fairbanks end and have nothing to do with the excursion.

**★★ And the same leg is the strongest thing in the record on two other instruments, both of which his story now explains:**

- **It is the SLOWEST leg of 200+ miles in sixteen years — 298 miles in 13.18 hours, 22.6 mph gross.** Nothing else under 24. The outbound run over the identical road the day before made 28.6. **The difference is not the road; the road was the same. It is the museum tour, the village, and the turnaround.** This is FIVE THINGS #5 in its purest form — a long elapsed time is not a slow day — and it is the case where the difference can be measured against the SAME road driven the day before.
- **38 degF at the 07:52 departure, tied for the second-coldest start in 136 timed legs.** Coldfoot read **64 degF** at 18:26 the previous evening. **A 26-degree overnight drop at the farthest north point the car ever reached**, on the morning Kim says the season's first snow began. The instrument corroborates the weather turning, at the exact hour.

**Note what closed this.** Two fills at one location, six hours of driving apart, converted an unexplained total into two separately attributable differences. **A matching total does not mean a matching route (the Dragon); a SPLIT total localises the discrepancy.** Same instrument, used the other way round.

### 2. The Penultimate State was never Florida — and the record can only partly follow

**Kim's ruling:** 49 mainland states leaves Hawaii as the Ultimate State. **The penultimate is the 49th mainland state, i.e. the last one reached.** Florida mattered for a different reason — the only unvisited state in the SE — and there were more gaps up the East Coast.

**What the record holds:** 45 of the 49 mainland states appear, across the fuel log and 139 trip legs. **The last new states in the record all fall on the 2014 trip Kim himself named Penultimate State:** Alabama 5/7, New Jersey 5/16, **Vermont 5/18 (Hartland)**, **New Hampshire 5/20 (Lebanon)**, **Maine 5/22 (Lubec)**. Kim remembers Vermont; **the record's last new state is Maine, four days later, arriving at Lubec — the easternmost point of the continental United States.** Not resolved here; Kim is the better instrument and the two readings are three legs apart.

**Vermont does carry a mark the others do not:** the trip stops dead there. Hartland VT on 5/18 at odo 44746, and the next logged leg opens at Lebanon NH on 5/20 at 44805 — **two nights, and 59 odometer miles for a drive that is 18 miles direct.** About 41 miles of local driving in the Upper Valley. Whatever happened in Vermont was not a pass-through.

### ★★★ 3. DELAWARE IS INVISIBLE AS A LABEL AND PROVABLE AS A ROW

Four mainland states never appear anywhere: **Florida, Delaware, Rhode Island, South Dakota.** Florida is already understood — Kim drove a few miles into the panhandle and turned around, and a log that samples at fill-ups cannot see it (Finding 036). **Delaware is the same class of silence, and here the geography instrument breaks it.**

2014-05-16, Henderson NC → Bellmawr NJ, with an intermediate fill at **Colonial Heights VA**. From that fill to Bellmawr the odometer reads **264 miles** against a great-circle of 219 — a ratio of 1.21, ordinary for interstate. **Every road between those two points that is anywhere near 264 miles passes through Delaware:** I-95 through Baltimore and the Delaware Turnpike is ~262; US-13 up the Delmarva is ~285. **The only Delaware-free route — I-83 to York PA, then US-30 east — is about 305 miles, some 40 miles more than the odometer permits.**

**So the record does contain Delaware. It contains it as a DISTANCE, not as a name** — which is exactly the errata architecture's own rule read in the other direction: **key to a ROW, never to a LABEL.** The same reasoning that placed the Tail of the Dragon by intermediate fills places Delaware by exclusion.

**And a charter claim gets settled while we are here.** The 2026-08-12 intake audit flagged *49 states and 10 provinces* as unverified. **The provinces are exactly right: Alberta, Manitoba, New Brunswick, Newfoundland, Nova Scotia, Ontario, PEI, Quebec, Saskatchewan, Yukon — ten, all present.** The states stand at 45 documented, 46 with Delaware by inference, plus Florida on Kim's testimony. **Rhode Island and South Dakota are the only two with neither a record nor a story.**

### 4. West Virginia — the trips are identified, the ROAD is not, and one question settles it

Kim: two different trips, scientific meetings in the region, direct the first time, a deliberate detour the second. **The record holds four West Virginia touches and they fall on two different highways 150 miles apart.**

**I-68, northern West Virginia — the 2012 Frostburg trip.** Morgantown WV fills on both 6/1 and 6/8. Columbus OH → **Frostburg MD** 6/1 (241 mi, arriving 14:37) is the direct route to the meeting; Frostburg MD → Streetsboro OH 6/8 departs **07:31**, which puts I-68 westbound through the hills in the first hour of the morning. **Fits *direct to the meeting site* exactly — but it is one trip, out and back, not two.**

**I-64, southern West Virginia — 2010 and 2016.** Barboursville WV fill on 2010-09-30 (Huntington, on I-64) and Summersville WV on 2010-11-14 — **two separate trips six weeks apart.** Then 2016-06-12, **Huntington WV departing 08:58** → Lewisburg WV fill → Richmond VA, 359 miles at 49.9 mph, the fastest leg of that week. **And the 2016 route is plainly out of its way:** Atlanta → Dandridge TN → *north to Huntington WV* → Richmond VA → *back south* to Morehead City NC and Charleston SC. **He slept at Huntington to start the Greenbrier Valley in the morning.** That is *I went out of my way a bit* in the odometer.

**The record contains exactly two MORNING drives through the West Virginia hills: 2012-06-08 westbound on I-68, and 2016-06-12 eastbound on I-64.** They are different roads. **The question for Kim is one word: I-68 (Morgantown → Frostburg) or I-64 (Huntington → Lewisburg → White Sulphur Springs)?** Route inference has been wrong twice in this project and is not being trusted with a third.

### ★★★ AND KIM'S HINT MOVED IT — the second meeting was PINE MOUNTAIN KY (2026-08-19)

**The record holds the meeting.** Bowling Green KY → **Pine Mountain KY** 6/4, and nothing until the 07:34 departure on **6/9**. Five days. He arrived from the WEST, through Kentucky — **no West Virginia on the way in.** So the WV driving is entirely AFTER the meeting, which already makes it a choice rather than a route.

**And the detour is large.** Pine Mountain → Atlanta 6/9, then Atlanta → Richmond over three days. **Direct is ~525 road miles. He drove 895** (odometer 61,450 → 62,345), against a great circle of 470. **~370 extra miles, +70%.** Three fills pin the shape and none of it is inference: **Cherokee NC** 6/10 (the Smokies), **Pikeville KY** 6/11 (US-23 up the eastern-Kentucky coalfields), **Lewisburg WV** 6/12.

**The Huntington departure is EASTBOUND, and the fill proves it.** Lewisburg sits at I-64 exit 169, and it splits the 6/12 leg into **155 miles to the fill and 204 after**. I-64's own markers give ~161 from Huntington to Lewisburg and ~205 from Lewisburg to Richmond. **Both halves match. That is I-64 across the width of West Virginia — Charleston, the New River, Sandstone Mountain, the Greenbrier Valley — 359 miles at 49.9 mph, the fastest leg of the trip, out of Huntington at 08:58 in the morning.**

### ★★ KIM'S SECOND HINT — *we drove south out of Huntington* — POINTS AT A REAL DRIVE, SIX YEARS EARLIER

There is no southbound departure from Huntington in 2016. **But there is one in 2010, and it is the project's very first West Virginia mile.** Fuel at **Barboursville WV** (a Huntington suburb) on **2010-09-30, odometer 3,310** — the car was ten weeks old — then **Hillsville VA** on 10-01 at 3,507. **197 odometer miles against a 142-mile great circle, ratio 1.38.** That is I-64 east to Beckley and then **I-77 SOUTH** through the mountains — Flat Top, Camp Creek, the East River Mountain Tunnel. **A southbound run out of the Huntington area through the West Virginia hills, exactly as he describes it.**

**★★★ AND THE TWO RUNS SHARE A ROAD.** 2010 and 2016 both begin at Huntington and both take **I-64 east through Charleston to Beckley — about 120 miles.** 2010 turns south there onto I-77; 2016 stays on I-64 into the Greenbrier Valley. **So *I liked this so much, I drove it twice* has a documented referent after all — it is the Huntington → Charleston → Beckley stretch of I-64, driven in 2010 and again in 2016.** What the record cannot support is that the pair is Frostburg-and-Pine-Mountain: **Frostburg 2012 is I-68, pinned by two Morgantown fills (the 6/1 fill sits 65 miles short of Frostburg against I-68's ~63), and I-68 does not touch the Huntington road at any point.**

**Five West Virginia fills, and they fall on three different highways:**

| date | fill | odometer | road |
|---|---|---|---|
| 2010-09-30 | Barboursville | 3,310 | I-64 east → **I-77 south** |
| 2010-11-14 | Summersville | 7,531 | **US-19**, the New River Gorge corridor |
| 2012-06-01 | Morgantown | 28,900 | **I-68** east to Frostburg |
| 2012-06-08 | Morgantown | 29,109 | **I-68** west, departing 07:31 |
| 2016-06-12 | Lewisburg | 62,141 | **I-64** east, Huntington → Richmond |

**Note the 2010 pair is itself two separate trips six weeks apart, and neither has been accounted for by a story.** Summersville is on US-19 between I-79 and Beckley — the New River Gorge Bridge road. **Three scenic West Virginia highways, five fills, and the memory of one.** Kim to adjudicate; the geometry is offered, not asserted.

### ✓✓✓ SETTLED BY KIM, 2026-08-19 — I-64, CHARLESTON TO BECKLEY

He checked it on Street View: **the Charleston → Beckley run on I-64 is the road he remembers.** That closes it, and the closure is unusually clean.

**★★★ The record puts TwoRed on that stretch on exactly two days in sixteen years — 2010-10-01 and 2016-06-12 — and *twice* is the number he gave before anyone counted.** His memory produced the road and the count independently of the data, and both survive.

**And the behaviour is identical six years apart, which is the part no one was looking for.**

| | 2010 | 2016 |
|---|---|---|
| arrive Huntington | **Barboursville** fill closes a 275-mi day at odo **3,310** — the car was ten weeks old | in at **14:54**, from Dandridge TN |
| overnight | yes | yes |
| the morning drive | 197 mi to Hillsville VA: I-64 east through Charleston to Beckley, then **I-77 south** | out at **08:58**, 359 mi to Richmond at **49.9 mph**, the trip's fastest leg |
| the check | 197 against a 142-mi great circle, ratio **1.38** | **Lewisburg** fill splits it **155 + 204** against I-64's markers of ~161 and ~205 |

**Both times he stopped short of the mountains, slept, and started the beautiful part in the morning.** That is a decision, made twice, six years apart, and it is legible in nothing but arrival and departure times.

**★★ WHAT THE MEMORY GOT WRONG IS INSTRUCTIVE, AND IT IS NOT THE ROAD.** He named the pair as Frostburg (2012) and Pine Mountain (2016). **The road and the count are right; one of the two occasions is wrong.** Frostburg is **I-68**, pinned by two Morgantown fills — the 6/1 fill sits 65 miles short of Frostburg against I-68's ~63 — and **I-68 never touches the Charleston-Beckley road at any point.** The first drive was **2010-10-01**, in the car's first ten weeks, on a trip he has not told a story about.

**The error has a shape worth naming.** He remembered the ROAD (verifiable, and verified), the COUNT (verifiable, and verified), and the CATEGORY of occasion — *a scientific meeting in the region* — which is true of both 2012 and 2016. **What slipped is the BINDING between the road and one of its occasions**, and it slipped toward the occasion that shares the category. **This is the mirror image of Finding 036:** there, the record was silent and the memory carried the fact; here the memory carries the fact and the record supplies the index. **Neither instrument is reliable alone, and their failure modes are different, which is exactly why the pair works.**

**Still open: the two 2010 West Virginia trips have no stories.** 2010-09-30 Barboursville (which we now know is the first drive) and 2010-11-14 Summersville, on **US-19, the New River Gorge Bridge road** — six weeks apart, both in the car's first four months, both unaccounted for.




## [archived] GOOGLE-NATIVE DATA INVENTORY — moved from proj 2026-08-19

- Code: `G:\My Drive\Projects\Smart_Car` (bucket 2 -- code-as-source)
- **★ GOOGLE-NATIVE DATA, root of `G:\My Drive` (found 2026-08-16).** NOT reachable by any
  filesystem read -- `G:` shows zero-byte stubs. Read via the Google Drive connector by title.
  | Title | Kind | Holds |
  |---|---|---|
  | `Final Creamsicle Logs` | Sheet | gas log 2021-09→2023-09 (odo 30,290→51,345) + trip log 2021-09→2024-10 + summary |
  | `Creamsicle` | Doc | the 9-trip narrative, ~4,500 words, per-trip distances |
  | `Creamsicle_July_Fuel_Log_update` | Sheet | Jan–Jul 2024, odo 52,656→55,743, **lat/long** |
  | `Creamsicle Inventory` | Doc | Jun 2023 packing manifest + departure/arrival checklists |
  | `TwoFer Gas Log` | Sheet | car #2: 7 fill-ups, 2014-03→2015-01, 1,209 mi, all Honolulu |
  | `TwoRed_fuel` | Sheet | richer early TwoRed record: cumulative cost, $/mile, MPG-last-5, **ambient temperature in Notes** |
  | `TwoRed_fuel_June_2014` | Sheet | live original of the exported `.xlsx` |
  | `Travel/2016 Fourth Crossing Analysis` | Sheet | live original; `Travel/4th Crossing Fuel Stops` is a **My Map** |
- **Fuel receipt scans:** `CS_Fuel_Receipts_2021.pdf` (5.7 MB) and `2022_fuel_receipts_Jan-Feb.pdf`
  (6.5 MB) on Drive -- the primary sources behind the Creamsicle log's first two trips.
- **Existing analysis code:** `G:\My Drive\Projects\Photo_Mapping\Fuel_Analysis.Rmd` (2022).
  Predates this project and was written against the fuel data; read before writing new ingestion.
- Data: `G:\My Drive\Projects\Smart_Car\data`
- Source docs: `G:\My Drive\Projects\Smart_Car\source`
- Images: `G:\My Drive\Projects\Smart_Car\images`
- Docs/output: not yet; destination is kimbridges-documents
- GitHub: not yet
- **Superseded:** `G:\My Drive\kimbridges-stories\underway\Smart_car\` -- the original
  mis-filing. Copies still there; neither bridge deletes, so removal is Kim's.




## ★★★ THE 2010 LOOP, AND THE ONLY TIME THE CAR SLEPT EAST OF THE ROCKIES (2026-08-19)

Kim volunteered the Summersville trip as *a bit complicated*, apologising for not remembering the town. **The loop is in the fuel log end to end, and it explains the single largest structural anomaly in sixteen years of dormancy — an anomaly nobody had looked for.**

### The car wash is in the odometer

| | |
|---|---|
| last fill before | **Altamont IL**, 2010-10-11, odo **5,730** |
| first fill after | **Effingham IL**, 2010-11-05, odo **5,957** |
| elapsed | **25 days** |
| driven between them | **227 miles** |

**Altamont and Effingham are seventeen miles apart on I-70 in central Illinois.** St Louis is ~85 miles west of one and ~100 west of the other. **In (85) plus out (~100) is 185; the remaining ~42 is local driving at each end.** The arithmetic is exactly a car driven into St Louis, left for three and a half weeks, and collected. **This is the only gap in the whole 2010 record with that shape.**

### ★★★ AND IT IS THE ONLY ONE IN THE WHOLE RECORD

Asking *where does this car sleep?* — a question nobody had put to the data — produces a result that stands on its own:

- **TwoRed's fuel log spans 2,495 days. 2,147 of them — 86% — fall inside a dormancy of two weeks or more.** The car was parked for the overwhelming majority of the sixteen years, because its owner lived 2,500 miles away.
- **There are 35 such dormancies. Thirty of them are in California; two Arizona, two Oregon.** That is the home base, and it maps a SECOND geography — not the driving constellation but the parking constellation.
- **★★★ Exactly ONE is east of the Rockies: Altamont IL, 2010-10-11 to 2010-11-05, 25 days.** The car wash.

**So the story does not merely survive the check. It is the sole explanation of the only anomaly in a distribution of 35.** And the logic Kim gives is the whole point: *by leaving the car in St Louis, I avoided having to drive back to California and then return soon after over the route I'd have just taken.* **A rational choice, made once in sixteen years, and it is visible in the record as a single outlier.**

### The rest of the loop, and one order that does not match

**Confirmed by the fills:** the westward return *mostly through the South* is unmistakable — **Summersville WV 11/14 → Bessemer NC → Villa Rica GA → Tupelo MS → Bryant AR → Mt Pleasant TX → Carlsbad NM → Ruidoso → Willcox AZ → Dateland → El Cajon CA 11/24.** And *visited colleagues at a number of universities* is equally visible in the four days before it: **Springfield OH 11/6, Waynesburg PA 11/7, Middleton PA 11/8, Newburg PA 11/9, Pittsburgh PA 11/10** — five fills, five short legs, one state.

**★★ But the order differs from the memory in one step.** Kim's sequence is *Frostburg → park at St Louis → fly out → return → Nancy → Boston → universities → South*. **The record puts New England BEFORE the parking, not after:** Gettysburg PA and Danbury CT on 10/7, **Charlton MA on 10/9** (on I-90 between Worcester and Sturbridge), Waterloo NY 10/10, then Ohio and Altamont IL on 10/11 — and after the 25-day gap there is no New England at all. **The Frostburg meeting fits the 5-day gap of 10/2 to 10/7** (Waynesboro VA → Gettysburg PA, 369 miles for a ~290-mile route, the excess being local driving at a conference).

**This is the West Virginia failure mode again, one day later and in a different story.** The COMPONENTS are all correct and independently confirmed — the Frostburg meeting, the car wash, Nancy, the New England meeting, the university tour, the southern return. **What slipped is the ORDER of two of them.** Do not treat this as a correction to Kim; treat it as the expected error profile of the instrument. **Ask him whether Nancy joined in October rather than November.**



## ★★★ THE THREE LAYERS — THE CHAPTER ARCHITECTURE, SOLVED (Kim, 2026-08-19)

**His formulation is in COLLECTED STORIES, verbatim.** What follows is the development, and why it closes a weak point that has been named since 2026-08-16.

### Why TWO LOGS, TWO SUBJECTS was necessary but not sufficient

That frame answered *which instrument answers which question* — economy and degradation belong to the car, daily range and departure discipline to the human. **It is an excellent SORTING rule and a useless ORDERING rule.** It never said what a reader meets first, or why they keep going. **Three layers answers both, and the two compose rather than compete: the car/human fabric runs THROUGH all three. It is the weave, not a chapter.**

### The layers are three DEPTHS of one material, and each is bought by the one above

1. **The car.** People see an unusual object and arrive with a preconception — *that thing is a city runabout*. **The preconception is an ASSET, not an obstacle.** It is the only reason layer 2 is surprising.
2. **The drives.** The stories are surprising BECAUSE of the preconception, and they raise questions they cannot answer. *How far can you actually go in a day? What did those miles cost?*
3. **The data.** It answers them — **including questions the reader never thought to ask.**

**Remove any layer and the one below it loses its force.** Without the preconception the drives are just travel. Without the drives the numbers have no question attached. Without the numbers the stories are anecdote. **That mutual dependence is what makes this an architecture rather than a table of contents.**

### ★★ *Questions you didn't know you had* is the load-bearing phrase, and it is already proven

Every one of these came out of this project in the last three days, and **not one was asked before the data was made to answer it:**

- *What does a day OFF the highway look like in an odometer?* — **70 miles at Holbrook**, a park tour with a nephew, sitting in the gap between an arrival reading and the next departure.
- *How much of a "speed" is living rather than driving?* — **7.5 mph**, from Creamsicle's stopped-time column.
- *Can a record contain a state it never names?* — **Delaware**, by 264 odometer miles against a 305-mile Delaware-free alternative.
- *Where does a car sleep?* — **86% of the record's elapsed days are dormancy; 34 of the 35 long ones are in California, Arizona or Oregon, and the single exception is the St Louis car wash.**

**That last one is the strongest possible demonstration, because it arrived the same day the architecture did.** Kim told a story to apologise for not remembering a town. **The story turned out to be the sole explanation of the only outlier in a distribution nobody had computed.** Layer 2 generated the question; layer 3 answered it; neither could have done it alone.

### ★★ The DIFFICULTY end is a third narrative, not a methods appendix

Kim named the data layer as having two ends — collection, transcription and cleaning at one; analysis and display at the other. **The first end is usually exiled to an appendix and that would be a mistake here, because it has the same shape as the driving stories: a problem, a mechanism, a resolution.** The inventory is already substantial:

- **The slashed zero** — a handwriting habit that predicts the DIRECTION of an error, not just its presence, and whose control group holds.
- **The crossbar that was not a correction** — a bitonal-thresholding artifact in a scan; the original settles it, the scan cannot.
- **The pump identity** — three numbers that must multiply, and 277 of 294 rows that do.
- **The intermediate fill** — a total cannot place a route; a SPLIT total localises a discrepancy to the mile (the Dragon, then Wiseman).
- **The backup with two gates**, each blind to the other, reporting success while carrying nothing.

**These are stories about the record with real suspense in them. Write them; do not bury them.**

### ★ An editorial rule falls out, and it is testable against today's inventory

**An analysis earns a place in the ANALYSIS strand only if it answers a question the drives raised.** A result with no story to attach to is not a failure — **it belongs to the DIFFICULTY strand instead, where its subject is the record rather than a drive.** Three current results sort themselves immediately: **the retired temperature effect** (a result destroyed by more data), **the wide-tire interval that straddles zero**, and **the Canadian non-result** (blocked on unit normalisation). **All three are the data being honest about what it cannot say — which is a good story, told in the right strand.**

### The three layers are the three instruments

**Preconception, memory, record.** This session has been nothing but those three checking each other, and they fail differently: the record is silent where its resolution cannot reach (Finding 036); the memory keeps roads and counts but mis-binds occasions (West Virginia, then the 2010 loop, one day apart); the preconception is simply wrong, which is the point of the book. **The reading structure and the working structure are the same structure. That is a good sign for an architecture and it should be said out loud in the Foreword.**



## ★★★ THE SAFETY THESIS — LAYER ONE'S CONTENT, AND THE BEST WORKED EXAMPLE THE ARCHITECTURE HAS (2026-08-19)

**Kim's account is verbatim in COLLECTED STORIES.** It arrived hours after the three-layer architecture and it supplies the thing the architecture was missing: **what the preconception actually IS.**

### It is not a category error, it is a question with stakes

*That thing is a city runabout* is a shrug. **IS IT SAFE?** is not. **The preconception has a fear inside it, and that is why layer 1 can carry a whole book.** A reader who merely thinks the car is impractical has no reason to turn the page; a reader who thinks it is dangerous wants to know what happened.

### The answer has three parts and only the third is the thesis

**1. The engineering answer.** Mercedes designed it; the safety cell is race-car logic. **Kim's own verdict on how that lands is the honest part and must survive into the writing: *Do they believe it? Maybe. Maybe not.*** An engineering answer does not persuade against a visual impression. **The document should say so rather than pretend the spec sheet settles it.**

**2. The empirical answer.** Sixteen years, prudent driving, nothing happened.

**3. ★★★ THE THESIS — SMALL AND NIMBLE ARE COMPONENTS OF SAFETY.** This is the move that makes the chapter worth writing, because **it inverts the preconception instead of rebutting it.** Size stops being a liability to be excused and becomes the mechanism of the escape. Both close calls support it directly:

- **The Yukon pothole** — unflagged, and by his account *big enough to eat a big car too*. **The hazard was size-blind; the escape was not.** *I was nimble enough to avoid the hole. A bigger car might not have been able to do that.*
- **The Texas on-ramp** — a police car coming UP an on-ramp at full speed, no lights, no siren. Hard right, hard brakes, a slide to a stop inches short of the guard rail. **He then sat and watched several cars take the ramp exactly as he had, which is how he learned it was the police car going the wrong way.** *I missed being hit head on by quick action and some luck.*

**Note the structure of the second one.** The hazard was external, unlawful and unpredictable — nothing about prudence prevents it. **What was available to him was steering and braking inside a very short distance.** That is a handling argument, and handling is measurable in a way a crash test is not.

### ★★★ AND THE ARGUMENT CANNOT BE MADE FROM ONE LAYER — WHICH IS THE POINT

**Layer 3 has the denominator, and it is a real number:**

| | miles |
|---|---|
| TwoRed, documented | **71,177** |
| Creamsicle, documented | **28,613** |
| Two4Two / TwoFer | **1,209** |
| **total documented** | **100,999** |
| with TwoRed's implied Honolulu miles | ~105,000 |

**467 fill-ups. 225 logged legs. 45 states, 10 provinces. Gravel on the Dalton, frost heaves across the Canadian Plains, Deals Gap, US-101, the Trans-Canada. No crash.**

**Layer 2 has the numerator, and nothing else does.** **A crash avoided buys no fuel, ends no leg, covers a few hundred feet and takes under a minute.** It is invisible to this record by construction — Finding 036's resolution rule and the means-not-variance rule operating together. **The two near-misses exist only because Kim remembers them.**

**Neither half is an argument.** 101,000 miles without the near-misses is an absence of evidence — it shows nothing happened, not that the car did anything. The near-misses without the miles are two anecdotes. **Together they are a rate and a mechanism, which is what a safety claim requires.** **This is the chapter to write first, because it demonstrates the architecture on the project's own central question.**

### ★★ IT ALSO CLOSES THE WIDE-TIRE LOOP, OPEN SINCE 2026-08-18

The only modification TwoRed ever received was made for **safety**: crosswind pushed the car around on the stock narrow tires at highway speed, Smart Madness prescribed wide ones, and handling became very good. **Kim's own sentence tonight makes the link explicit — *the cars have handled well and this, in part, keeps them out of dangerous situations.*** So the fuel data's job was never to judge the modification; **it was to say what the safety cost. Answer: indistinguishable from zero, 95% interval -3.7% to +4.9%.** A layer-3 answer to a layer-1 question, and the answer is that **the safety modification was free.**

### ⚠ TWO DISCIPLINES, both of which belong in the DIFFICULTY strand

**1. *Granted, no crash testing.* Kim's own caveat, and it is the right one.** The record cannot answer a counterfactual. **What would have happened in the crash that did not occur is outside every instrument this project has**, and saying so plainly is stronger than hedging.

**2. The 101,000 crash-free miles must not be oversold.** One driver, prudent by disposition, mostly interstate, mostly daylight, almost no urban commuting — **a low-exposure profile before the car is considered at all.** The honest claim: **the miles show the car did not prevent sixteen years of safe driving; the near-misses are where the car actively contributed.** A crash-rate comparison would need a SOURCED per-mile figure, and intentions item 4 forbids printing one until it exists.

### The Texas incident cannot be located in the record, and that is the third demonstration

There are four eastbound approaches to the Fort Worth area in the whole log: **2010-09-23 Abilene → Flower Mound** (I-20, 284 mi over 2 days), **2011-06-29 Wichita Falls → Fort Worth** (US-287, 111 mi, 07:41–09:38, no room for a detour), **2012-02-05 Colorado City → Ft. Worth** (I-20, 261 mi over 6 days) and **2014-08-06 Colorado City → Ft. Worth** (I-20, 217 mi over 3 days). **The 2012 and 2014 legs are the same city pair and differ by 44 miles — but both span multiple days, so local driving explains the spread and the geographic instrument cannot discriminate.** Put the three I-20 candidates to Kim; do not infer. **The near-miss itself is unrecoverable, exactly as the thesis predicts.**


## ★★★ FOUR ANSWERS, 2026-08-20 — and one of them corrects ME

### 1. The 2010 loop, in the right order at last — and the DC gap was mine to get wrong

**Kim's corrected sequence maps onto the fuel log leg for leg, and it resolves the order problem Finding 039 predicted.** Last night he placed the car wash BEFORE Nancy's meeting; **the record put New England first, and he now agrees — Nancy joined at St Louis, and the parking came after she flew home.** The content was never wrong; only the index was.

| his account | the record |
|---|---|
| short stop at **BRIT**, Fort Worth | **Flower Mound TX** fill, 2010-09-23, odo 1,939 |
| **BSA headquarters + MOBOT**, St Louis | **St. Louis MO** 09-29, odo 2,744, after a 5-day gap |
| **Nancy joins; drive to Washington DC** for her meeting | Dale IN → Barboursville WV → Hillsville VA → Waynesboro VA, then **a 5-day gap, 10-02 to 10-07** |
| north **to see friends in MA** | Gettysburg PA → Danbury CT → **Charlton MA**, 10-09 |
| **driving around the region** | Waterloo NY → Austinburg OH, 10-10 |
| **Nancy back to St Louis, flies to HNL** | Dayton OH → **Altamont IL**, 10-11, odo 5,730 |
| **car stored at the car wash; he flies to HNL** | **25-day gap**, to Effingham IL 11-05, odo 5,957 |
| back for the car; **Pittsburgh, Gigapan robots** | Springfield OH → Waynesburg → Middleton → Newburg → **Pittsburgh PA**, 11-10 |
| **NSF colleagues, places like South Carolina** | Summersville WV → **Bessemer NC** 11-15 → Villa Rica GA 11-16 |
| **headed west to Lake San Marcos** | Tupelo → Bryant AR → Texas → New Mexico → Arizona → **El Cajon CA 11-24** |

**★★ I PUT FROSTBURG IN THAT GAP AND IT WAS WASHINGTON DC.** Yesterday I read the 10-02 to 10-07 hole as a Frostburg meeting because the distances fitted and because Frostburg was a meeting I already knew about. **That is Finding 039's failure mode exactly — mis-binding an occasion toward one that shares the category — and I committed it while writing the finding up.** The arithmetic works for DC and always did: Waynesboro VA → Washington ~120 road miles, Washington → Gettysburg ~80, against **369 driven over five days**, leaving ~169 for a week of local driving at a meeting. **A gap that admits several stories is not evidence for the one you already have in hand.**

**★ And note what the detour tells us.** *We did add on a bit of driving so we could see areas of the country neither of us had visited.* The St Louis → DC run went via **Barboursville WV, then I-64 east to Beckley, then I-77 SOUTH to Hillsville VA** — a long way south of any direct line — and then **Hillsville → Waynesboro, 170 odometer miles against a 135-mile great circle (ratio 1.26)**. I-81 direct is ~150; the Blue Ridge Parkway between those two points is ~180. **The number sits between them, so the record cannot say which — but it can say the route was not the direct one.** And this is the drive Kim now names as the first of the two Appalachian ones.

**★★★ AND IT NAMES THE ORIGIN OF THE STATES CHALLENGE.** *That, incidentally, added to the total number of states TwoRed visited and, in a way, became the basis of the challenge to visit the remaining states.* **The challenge was not a plan the car was bought for. It was a by-product of scenic detours on scientific-meeting trips, noticed after the fact.** That belongs in the writing: **the sixteen-year project began as an accident of two people adding a bit of driving.**

### 2. The Penultimate State is Vermont — settled, and the anomaly is explained

**Kim rules Vermont, and supplies the reason the record had already flagged without being able to read it:** *I was working with a lawyer who has an office in NH, but lives nearby in Vermont. I drove to his house.*

**That is precisely the shape of the anomaly.** The 2014 trip stops dead at **Hartland VT, 5-18, odo 44,746**, and the next logged leg opens at **Lebanon NH, 5-20, odo 44,805** — two nights and **59 odometer miles for a drive that is eighteen miles direct.** **Lebanon NH sits across the Connecticut River from Hartland VT: the office on one bank, the house on the other.** The 41 excess miles are commuting between them. **The gap-as-day-off-the-highway instrument (FIVE THINGS #2) reads it exactly right, and only the story says whose house it was.**

**★ One record fact left standing, and it is a definitional question, not a contradiction.** Maine first appears **2014-05-22, four days after Vermont**, and there is no earlier Maine anywhere in TwoRed's log. **So if the count is TWORED'S states, Maine is later; if the count is KIM'S states, Vermont can be the 49th with Maine already driven in some earlier car.** The record only ever knew the first. **The likely resolution — and it should be stated in the writing rather than smoothed over — is that TwoRed's state list and Kim's state list are two different quantities**, which is also why the log holds 45 states against a challenge that speaks of 49.

### 3. The Texas on-ramp — CLOSED BY REQUEST, and not to be narrowed

*I don't know the freeway on-ramp location... And for personal safety, I wouldn't reveal it either. Near Ft Worth is sufficiently close.*

**Standing constraint, effective 2026-08-20.** The three I-20 candidate legs I assembled yesterday have been REMOVED from `deferred.md`. **No future session should attempt to localise this incident, and no published text may place it more precisely than *near Fort Worth*.** The record cannot pin it in any case — which was the point — but the constraint stands independently of that: **the ask is not about feasibility.**


### 4. ★★★ ROAD CHARACTER — Kim revises the West Virginia answer, and it makes Finding 039 sharper

**He looked at the map and withdrew the claim himself:** *I had said it was the same highway... I'm not thinking that these were different highways. What they have in common is that they run through the same type of countryside; rolling, tree-covered hills, a winding highway, small villages tucked in the valleys.*

**So the thing that persisted for sixteen years was not a ROAD. It was a LANDSCAPE TYPE.** Yesterday's reading — one highway, two occasions, one binding wrong — was itself too generous to the index. **The correct statement is stronger and stranger: the memory retained a CATEGORY, and *twice* counted instances of the category, not passes over one piece of pavement.** The two 2010 drives are I-64/I-77 south out of Barboursville and US-19 through the New River Gorge; different roads, one country.

**This upgrades Finding 039 rather than contradicting it.** Content survives, index slips — and now: **the CONTENT that survives is more abstract than the words used to report it.** He said *highway*; he meant *this kind of country*. **When a witness names a specific, check whether the specific is standing in for a class.**

### ★★ AND A NEW CATEGORY THE PROJECT DID NOT HAVE: TREE TUNNELS

*The very long (miles and miles) of straight divided highway lined by a dense thicket of trees. Flat. Monotonous. Where are these found? In the South.*

**This is a road taxonomy built from EXPERIENCE, and the project's existing one is built from SPEED.** They are not the same axis and both are needed:

| Kim's category | character | where |
|---|---|---|
| **rolling wooded hills** | winding, villages in the valleys | Appalachia — *the relief* |
| **tree tunnels** | straight, flat, divided, walled with trees | the South — *the monotony* |
| **commercial freeway** | straight, billboards, wall-to-wall housing | everywhere — *the thing both are a relief from* |
| (already measured) | gravel, coastal, mountain West, Canadian Plains | |

### ★★★ AND THE DATA CANNOT SEE IT, WHICH IS THE POINT

Gross speed was the obvious test and it returns nothing: **Deep South median 40.3 mph (n=10) against Appalachian 38.0 (n=6), Wilcoxon p = 0.42.**

**That null is EXPECTED, not disappointing, and it completes a pair.** The Canadian Plains were the most STRESSFUL miles of the crossing and read as an unremarkable fast run. The tree tunnels are the most MONOTONOUS and read the same way. **The record is blind to the driver's experience at BOTH ends of the scale — terror and boredom produce identical numbers.** *Vigilance has no column; neither does tedium.* **Write that sentence down: it is the cleanest one-line case for why layer 2 is load-bearing.**

### ⚠ A SIGNAL IN THE ECONOMY, AND IT CANNOT BE SETTLED

Testing the same split on FUEL rather than speed does produce something, and it needs handling with the discipline that retired the temperature effect.

| model | South coefficient | p |
|---|---|---|
| `mpg ~ leg_miles + group` (n=30) | **-3.18 MPG** | 0.023 |
| `+ era` | **-2.61** | 0.065 |
| `+ temp_F`, on the 16 rows carrying a fill-stamped temperature | **-5.81** | 0.009 |

**A deficit of roughly 3 MPG on southern fills relative to Appalachian ones, and it is NOT heat:** temperature enters at **+0.108, p = 0.39**, and the group term grows rather than shrinks when it is included. **The plausible mechanism is the opposite of the intuition — a flat straight divided highway invites steady high speed, and aerodynamic drag costs a 1,800-lb car more than climbing hills does.** *The road he finds monotonous may be the road where the car does worst.*

**But it is a SIGNAL, not a finding, and three things say so.** The coefficient is **unstable across subsamples** (-2.6 to -5.8), which is the classic shape of noise. **n = 30, and 16 for the temperature model.** And temperature is **confounded with group** (median 87.5 degF South against 76.5), so a null on temperature at n=16 proves very little.

**★★ AND UNLIKE THE TEMPERATURE EFFECT, THIS ONE CANNOT BE RESOLVED BY WAITING FOR MORE DATA.** Creamsicle would have been the natural replication — a different car over the same ground — but **Creamsicle has ZERO fills in any southern state.** Its routes are California↔Wisconsin through the central corridor and the West. **The sample is closed at 30 and will not grow.**

**So this belongs to the DIFFICULTY strand, not the analysis strand** — by the editorial rule adopted yesterday. **It is a good story about a record: a question the data raises, answers suggestively, and is structurally unable to settle.** Do not print the coefficient as a result. **Print the fact that it cannot be settled.**



## [archived from deferred.md] SMART_CAR ITEMS CLOSED 2026-08-19/20

Moved out of `deferred.md` on 2026-08-20 so that file reads as OPEN work again. Verbatim; the index in `deferred.md` points here.

### ✓✓ CREAMSICLE IS INGESTED, 2026-08-19 — the second spine exists

Three Google exports (`2024_Creamsicle_fuel_log.xlsx`, `2024_Creamsicle_trip_log.xlsx`, `2024_Creamsicle.md`) ingested by `creamsicle_ingest.R`, which skips interleaved summary rows programmatically and REPORTS the skip counts: Fuel_Log 196→173, Trip_Log 119→86, Pickup 10→6. Odometer 30,290→58,903, strictly increasing. **143 of 170 US rows balance the pump identity to under half a cent; exactly three fail by ≥2¢** and all three are now errata (C01 Oxnard, C02 Miranda, C03 Hays). Outputs: `Creamsicle_fuel_clean.csv` (173×19), `Creamsicle_trip_clean.csv` (86×15), `Creamsicle_log_errata.csv`.

**The result that matters:** Creamsicle logs STOPPED time, so it measures what TwoRed structurally cannot. Across 84 timed legs, **median gross 43.5 mph against median NET 51.0 — a 7.5 mph gap.** That is the first empirical size for the driving-vs-living conflation named in FIVE THINGS #5, and it calibrates every TwoRed gross-speed number in the project as a CEILING roughly 7–8 mph below actual driving speed.


### ✓✓ THE RECORD IS CLOSED AT BOTH ENDS, 2026-08-19

`2017_TwoRed_last_mainland_fuel.pdf`: two final fills, DAILY TRAVEL blank, and on the BACK of the sheet,
circled -- **`5/22/17  71,283  LV Seattle @ Matson`.** Kim: *there is no travel log. We got on a plane and
left TwoRed at the dock for shipping.*

**The record ends at 71,283 in Seattle, not 71,181 in Toledo.** Last mainland miles: Toledo (fuelled 10:09)
-> Seattle = **102**, against ~100 road miles. **Both odometer readings documented; nothing reconstructed.**
Filed as `data/TwoRed_2017_LastMainlandMiles_trip_log.csv`, arrival time NA because none was ever written.

**★★★ THIS CLOSES THE PROJECT'S FIRST OPEN QUESTION (2026-08-12).** Charter ~75,000; log stopped 71,181;
Kim: *about 20 miles short of 75,000*. **Mainland = 71,283; implied Honolulu miles after shipping ~3,697.**
**The gap was never missing data -- it is the SCOPE BOUNDARY, quantified at the terminus.**

**★★ AND THE LAST TWO MPG VALUES ARE NOT ECONOMY.** 52.4 and 93.0 (the highest in the record) come from
fills of **4.333 and 2.496 gallons** against a lifetime mean of 6.24. **Matson requires a low tank on
delivery** -- these are a tank being run DOWN for shipping. **RULE: the first and last rows of any record
are the least trustworthy, because they are taken while the measuring is being started or stopped.** The
first fill carries a slashed-zero error (L59); the last two are shipping artifacts. **Trim the ends before
quoting an extreme.**

**Coverage final: 139 legs (132 timed), 174 of 294 fuel rows under a trip log (59%), 134 fill time+temp (46%).**


### ✓ THREE MORE SCANS, 2026-08-19 — mostly redundant, and the redundancy paid twice

Kim scanned `2015_TwoRed_April-May_travel_log.pdf`, `2016_TwoRed_September_travel_log.pdf` and
`2017_TwoRed_travel_logs.pdf`, warning they might overlap. **Six of the eight pages ARE duplicates** --
the 2015 file is the Sedona sheet plus Fourth Crossing May p1 (its filename is wrong; there is no April-May
2015 content in it), the September file is the fall-winter sheet, and 2017 p1 is the January sheet. p4 is blank.

**★★★ BUT A 'DUPLICATE' PAGE CARRIED A TRIP NAME THE OTHER SCAN DID NOT SHOW: `Relocation  1141 miles`.**
The fall-winter legs run odometer **66,645 -> 67,786 = 1,141 miles. Exact.** So the September 2016 trip is
not a tour -- **it is the one-way RELOCATION of TwoRed to Oregon**, which is why the car was at a friend's
house in Eugene when the January 2017 call came about his mother. **Two scans of the same page are not the
same evidence: a marginal annotation can survive in one and not the other.**

**★★ AND 2017 pp.2-3 ARE GENUINELY NEW -- a whole trip nobody knew was logged.** New file
`data/TwoRed_2017_February_trip_log.csv`, **6 legs**, plus 5 fill times and temperatures. **All 5 fuel rows
matched the dataset EXACTLY on date, gallons and cost, and all balance the pump identity within half a cent.**

**The February 2017 trip is a SECOND relocation**: Mentone -> Long Beach -> Santa Maria -> S. San Francisco
-> Point Arena -> Brookings -> **Eugene**, and the car then sits until 2017-05-20. **Its gross speeds are the
slowest sustained run in the record -- 19.6, 21.1, 21.2 mph on the Highway 1 legs** (Long Beach->Santa Maria,
S.SF->Point Arena), against 41 on the inland ones. **Trip median 31.1 mph, second-slowest of the twelve trips
after the fall-winter coastal run at 28.3.** The road-type ordering holds and now has its extreme case.

**Coverage after all three: legs 132 -> 138 (132 timed); miles inside a leg 41,061 = 58% of lifetime; fuel
rows under a trip log 169 -> 173 (59%); fill time+temp 127 -> 132 (45%).**

**★ STILL UNCOVERED at the tail: 70,923 -> 71,181** (the last two fills, Eugene 2017-05-20 and Toledo WA
2017-05-22 -- the end of the record). And the early period 2010-07 to 2011-03 remains DEFINITIONALLY
uncovered per Kim's ruling.


### ✓ THE 46 DALTON MILES ARE EXPLAINED, 2026-08-19 — Wiseman

Kim: Coldfoot → Wiseman and back, the museum, a resident's tour, and the season's first snow. **The two Yukon River Crossing fills split the 46 into 32 north of the river (the Wiseman round trip, to the mile) and 14 at the Fairbanks end.** Closed. Full working in the log.


### ✓✓✓ THE PENULTIMATE STATE IS VERMONT — CLOSED 2026-08-20, with a reason

Kim: *It wasn't just a drive to meet the challenge. I was working with a lawyer who has an office in NH, but lives nearby in Vermont. I drove to his house.* **That is exactly the anomaly the record had flagged and could not read:** Hartland VT 5-18 at odo 44,746, next leg opens Lebanon NH 5-20 at 44,805 — **two nights and 59 odometer miles for an eighteen-mile drive.** **Lebanon NH is across the Connecticut River from Hartland VT: office one bank, house the other.**

**★ ONE DEFINITIONAL POINT FOR THE WRITING, not a contradiction.** Maine first appears **2014-05-22, four days after Vermont**, with no earlier Maine in TwoRed's log. **TwoRed's state list and KIM'S state list are two different quantities** — which is also why the record holds 45 states against a challenge that counts to 49. **Say so in the text rather than smoothing it over.**


### ✓✓✓ WEST VIRGINIA IS CLOSED, 2026-08-19 — I-64, Charleston to Beckley

Kim checked Street View and confirmed the road. **The record puts TwoRed on that stretch on exactly two days in sixteen years — 2010-10-01 and 2016-06-12 — and *twice* is the count he gave before anyone looked.** Both times: arrive Huntington late, sleep, drive the hills in the morning (2010: Barboursville fill at odo 3,310 closing a 275-mi day, then 197 mi to Hillsville VA, ratio 1.38, I-64 east then I-77 south. 2016: in 14:54, out 08:58, 359 mi at 49.9 mph, Lewisburg fill splitting it 155 + 204 against I-64's ~161 and ~205).

**The memory got the road and the count right and mis-bound one occasion:** he named Frostburg 2012, which is **I-68** (two Morgantown fills; the 6/1 fill sits 65 mi short of Frostburg against I-68's ~63) and never touches this road. The first drive was 2010, in the car's first ten weeks. **Full write-up and the failure-mode analysis in the log.**


### ✓✓ THE 2010 LOOP HAS ITS STORY, 2026-08-19 — and it explained an outlier nobody had looked for

Kim gave the Summersville trip unprompted: a Frostburg meeting, then **a car left in a St Louis car wash for three and a half weeks** while he flew home, then Nancy, a New England meeting, a university tour and a southern return to California. **All of it is in the fuel log.** The parking is **Altamont IL 2010-10-11 (odo 5,730) → Effingham IL 2010-11-05 (5,957) — 25 days, 227 miles, between two towns seventeen miles apart.**

**★★★ And it is the only dormancy east of the Rockies in sixteen years.** 2,147 of 2,495 elapsed days (86%) fall inside a spell of two weeks or more; there are 35 such spells and **30 are California, 2 Arizona, 2 Oregon, 1 Illinois.** His story is the sole explanation of the single outlier. **New analysis queued: THE PARKING CONSTELLATION** — where the car sleeps, mapped against where it drives.

**★ One open question for Kim (Finding 039):** he places the parking BEFORE Nancy's New England meeting; the record puts New England on **10/7–10/10, before the 25-day gap**, and the university tour on **11/6–11/10, after it**. Every component checks out; only the order differs. **Ask whether Nancy joined in October rather than November.** Do not treat this as a correction — it is the expected error profile of the instrument.

**Still open: the OTHER 2010 West Virginia trip.** 2010-09-30 Barboursville is now known to be the first of the I-64 pair. **2010-11-14 Summersville is on US-19, the New River Gorge Bridge road**, and sits inside this loop's return — but the road itself has no story.


### ✓ DELAWARE IS RECOVERED BY GEOGRAPHY, 2026-08-19

Never appears as a label. **The Colonial Heights VA fill → Bellmawr NJ reads 264 odometer miles (great-circle 219, ratio 1.21); the only Delaware-free road is ~305 miles.** The record holds Delaware as a DISTANCE. **State tally: 45 documented, 46 with Delaware, plus Florida on testimony; Rhode Island and South Dakota have neither. Provinces confirmed at exactly 10 — the charter's claim, verified.**



## ★★★ THE ANCHOR — KIM'S OPENING IS TESTABLE, AND THE RECORD GOES FURTHER THAN HE DID (2026-08-20)

His opening (verbatim in COLLECTED STORIES) makes a structural claim: **a car was needed at Lake San Marcos because visits to his mother were frequent and rentals were adding up; there was a parking spot at her place; and the apparent contradiction — a city car with 71,283 mainland miles on it — is resolved by the family dynamic. *We'd visit for a few days and then go off to a meeting... We'd drive back and visit again. Two visits separated by the time needed to do some work. The car served both purposes.***

**Every part of that is in the data, and the data says something stronger than *both purposes*.**

### 1. The parking spot is the structural centre of the entire record

| | |
|---|---|
| long dormancies (14+ days) in the whole record | **35** |
| of those, at San Marcos / Lake San Marcos / Carlsbad | **22** |
| dormant DAYS at the anchor | **1,333 of 2,147 — 62%** |
| median stay | **52 days** |
| longest | **184 days**, 2012-06-20 to 2012-12-21 |
| anchor span | **2010-07-26 to 2016-08-02 — six years exactly** |

**The car spent more of its life parked at that one address than doing anything else, including driving.**

### 2. ★★★ EVERY COMPLETE TRIP IS A LOOP FROM IT — until the loop breaks

Of thirteen logged trips, **eight begin and end at Lake San Marcos.** The exceptions are not exceptions to the pattern; they are its ending:

| trip | from → to | |
|---|---|---|
| 2011 NorCal Roadtrip | LSM → LSM | **loop** |
| 2011 St Louis | LSM → LSM | **loop** |
| 2012 Frostburg | LSM → LSM | **loop** |
| 2012 May Arizona | LSM → LSM | **loop** |
| 2013-4 LA Expedition | LSM → LSM | **loop** |
| 2013 Arctic | LSM → LSM | **loop** |
| 2014 Penultimate State | LSM → LSM | **loop** |
| 2015 Sedona | Carlsbad → Brawley | partial log, 3 legs |
| **2016 Fourth Crossing** | LSM → LSM | **loop — the last one** |
| 2016 Fall/Winter | San Marcos → **Eugene OR** | the relocation |
| 2017 January | Eugene → Vista CA | |
| 2017 February | Mentone → Eugene | second relocation |
| 2017 Last Mainland Miles | Toledo WA → **Matson, Seattle** | |

**Every complete trip from 2011 through the Fourth Crossing is a round trip from the parking spot at his mother's place. The Arctic Circle run is a loop from it. So is the crossing that reached Florida and the Tail of the Dragon. So is the fourth crossing.** **The long-distance driving is not a departure from the local-errand purchase — it is structurally hung off it.** That is the resolution of Kim's conflict, stated in the geometry: **there was never a choice between the two uses, because every long drive began and ended in the same parking space.**

### 3. ★★ The economics are visible as a COUNT, not a cost

Kim's reason was rental expense. **A rental must be returned; a car in a parking space does not.** The record holds that difference as a number: **22 long dormancies at the anchor** means **the car was left there and picked up again twenty-two times in six years** — twenty-two rentals not taken out, before any shorter stay is counted. **The saving is not in the fuel column. It is in the dormancy column, which is the one nobody thinks to read.** *(A dollar comparison needs a sourced rental rate; intentions item 4 forbids printing one until it exists.)*

### 4. ★★★ AND THE RECORD IS BRACKETED BY HIS MOTHER

**Last fill at the anchor: 2016-08-02.** The September 2016 trip is the one-way **relocation to Oregon**, and the car never returns to Lake San Marcos. **In January 2017 it is in Eugene when the call comes** — the Brookings → Paso Robles run, 562 miles, the coldest start in the record, racing to his mother at 104. She died shortly after. **The car ships from the Matson dock on 2017-05-22, four months later.**

**So the mainland record opens because a parking spot was available at her place and closes within months of her death.** ⚠ **The sequence is documented; the CAUSATION is not.** The loop broke in September 2016, BEFORE she died — so the relocation was not a consequence of it. **Ask Kim why the car moved to Oregon when it did.** Do not write the arc until he says.

### For the writing

**This is the Foreword's spine and it is layer-3 material arriving in service of layer 1.** The preconception is *that car is for errands*. The origin story says *yes — that is exactly why we bought it*. **And then the record shows that the errand car's parking space is the origin of every expedition in the book.** The document does not have to argue the reader out of the preconception; **it can agree with it and then show where it leads.**


## ★★★ PARKING IS THE HIDDEN INFRASTRUCTURE — AND THE RECORD IS A MAP OF IT (Kim, 2026-08-20)

> **⚠ CORRECTED THE SAME DAY — READ FINDING 041 FIRST.** The THEME below is Kim's and stands. **The MAP below does not.** I attributed each dormancy to the city of the preceding fill; Kim's correction is that most of those cities are *hotel/motels we stopped at along the way*, and that the five-week hold I gave to Carlsbad was actually at **Mentone**, at his niece's. **A fill records where fuel was BOUGHT, not where the car came to REST.** The corrected account follows this section under **WHERE THE CAR ACTUALLY SLEPT**. The text below is preserved as the record of what was concluded before the correction.


**Kim answered the September 2016 question and the answer is not the one the sequence suggested.** *As my mother neared her 104th year, she could no longer stay in her assisted living facility in LSM. She moved to a more secure facility in August and that place didn't have parking for TwoRed.* **The car did not leave California because she died. It left because the parking spot did.**

**And he generalised it into a theme the project did not have:** *Parking is a big issue and we've been fortunate that friends and family have helped at critical times.*

### The handoff is in the odometer, to the month

| date | fill | odo | |
|---|---|---|---|
| 2016-07-18 | San Marcos | 66,007 | |
| **2016-08-02** | **San Marcos** | **66,242** | **the last fill ever at the anchor** |
| 2016-08-17 | **Carlsbad** | 66,373 | 131 miles later — the car has moved towns |
| 2016-09-22 | Carlsbad | 66,589 | **after a 36-day stay** |
| 2016-09-24 → 09-27 | Goleta → Santa Cruz → Piercy → **Coos Bay OR** | 67,691 | the relocation run up the coast |

**She moved in August. The last fill at Lake San Marcos is 2016-08-02.** Then **somebody in Carlsbad held the car for five weeks** while a new home was found for it, and it went to a friend's house in Eugene. **Six years of anchorage end inside a fortnight, and the cause is a facility's parking policy.**

### ★★★ THE DORMANCY MAP *IS* THE FAVOUR MAP

Read the 35 long dormancies again with Kim's sentence in hand and they stop being a distribution and become **a list of people who let a car sit**:

| where | spells | days | |
|---|---|---|---|
| **San Marcos** | 11 | 578 | his mother's facility |
| **Lake San Marcos** | 7 | 421 | the same anchor |
| **Carlsbad** | 4 | 334 | incl. the 36-day handoff of Aug-Sept 2016 |
| Signal Hill | 2 | 141 | |
| Brookings OR | 1 | 103 | the last one |
| Barstow | 2 | 102 | |
| Parker AZ | 1 | 94 | |
| Coos Bay OR | 1 | 93 | the first Oregon one |
| Yuma AZ | 1 | 83 | |
| Lancaster, Laguna Hills, Hesperia, South Pasadena | 1 each | 173 | |
| **Altamont IL** | **1** | **25** | **the car wash** |

**★★★ AND THE CAR WASH IS THE EXCEPTION THAT PROVES THE THEME.** Thirty-four of the thirty-five long dormancies are in California, Arizona or Oregon — **inside the network of family, friends and a facility.** **Exactly one is outside it, and it is the only time in sixteen years he had to BUY the service.** Two thousand miles from anyone who could hold the car, the substitute for a favour was a commercial car wash in central Illinois. *Sounds strange, but it worked.*

**That reframes the car-wash story a second time.** On 2026-08-19 it explained the only outlier in the dormancy distribution. **Now it explains WHY it is the outlier: not an unusual trip, but the single failure of the parking network.** The logistics reason Kim gave — *I avoided having to drive back to California and then return soon after* — is the motive; **the reason it had to be a car wash rather than a driveway is the theme.**

### For the writing — this belongs in the Foreword beside the anchor

**The hidden infrastructure of sixteen years of cross-country driving in a small car was not fuel, and not roads. It was people willing to let a car sit.** The fuel log is a record of movement; **the gaps between its rows are a record of hospitality**, and they occupy **86% of the elapsed days**. *We've been fortunate that friends and family have helped at critical times* is not a courtesy — **it is the enabling condition, and it is measurable.**

**★ And it closes the arc without needing the death to do the work.** The mainland record opens because a parking space was available at his mother's place and closes when that space is withdrawn — **a facility's policy, not a bereavement.** She died five months later, in January 2017, with the car already in Oregon; that is why it was in Eugene when the call came. **The two facts are adjacent and separate, and the writing should keep them so.**

### ⚠ ONE ASK BEFORE ANY OF THIS IS PUBLISHED

**The table above names towns, and the theme requires knowing whose driveway each was.** San Marcos, Lake San Marcos and Carlsbad are accounted for. **Barstow (102 days), Parker AZ (94), Yuma (83), Signal Hill (141), Lancaster, Laguna Hills, Hesperia, South Pasadena, Coos Bay and Brookings are not.** **Ask Kim to annotate the list — and note that a chapter naming private individuals and addresses needs his ruling on what may be published**, as with the Texas on-ramp. Do not publish the table as it stands.


## ★★★ WHERE THE CAR ACTUALLY SLEPT — THE CORRECTED ACCOUNT (Kim, 2026-08-20)

**Three holdings, all named by Kim, none of them recoverable from the fuel log:**

| place | who | when |
|---|---|---|
| **Lake San Marcos / San Marcos** | his mother's assisted living facility | **2010-07-26 to 2016-08-02**, 18 spells, 999 days — the anchor |
| **Mentone CA** | **his niece** | the five weeks of Aug-Sept 2016, while other arrangements were made |
| **Eugene OR** | **Will McClatchey**, a close colleague — *a farm with a huge garage. He made space for us.* | from Sept 2016; *we visit Will several times each year, so it was logical to keep the car there* |
| **St Louis** (near the airport) | a hand car wash with an unused garage | 25 days, Oct-Nov 2010 — **the only PAID holding in sixteen years** |

**And one waypoint that is not a holding but matters more than any of them:**

**★★ SIGNAL HILL IS SMART MADNESS.** *A very helpful garage and after-market vendor... We depended on them to help equip and maintain both TwoRed and Creamsicle.* **Seven fills across the record — 2011-10-14, 2011-10-23, 2012-05-24, 2013-09-06, 2016-04-20, 2017-01-07, 2017-01-18 — and they sit at the seams of expeditions.** The 2012-05-24 fill at 25,795 falls 81 miles into the first day of the Frostburg trip (LSM 25,714 that morning). **The 2013-09-06 fill at 39,739 falls inside the final leg of the Arctic trip, Carpinteria → Lake San Marcos: the car came off the Dalton Highway and stopped at the shop on the way home.** **The wide-tire decision — the only modification the car ever received, made for handling and therefore for safety — has an address, and the address is in the fuel log.**

### ★★★ AND THE ST LOUIS CAR WASH IS BETTER THAN THE INFERENCE WAS

*The place the car was held on the first trip was in St Louis, quite near the airport. I saw a hand carwash business that had a large garage that they didn't seem to be using. I asked if they would keep the car for a reasonable fee. They were happy to do so. And I got a car wash, too.*

**Near the airport is the whole mechanism** — the car had to be within reach of a flight home, because the owners live 2,500 miles away. **And the solution was improvised on sight: an unused garage, a question asked, a fee agreed.** It is the only paid holding in the record and it is not a transaction he went looking for. **This is the parking theme in one paragraph: the network is people, and where there are no people there is improvisation.**

### ★★★ THEY LIVE IN HAWAII — AND IT HAS TO BE SAID EARLY

*Although I'm sure you know, but we might need to mention that we live in Hawaii. If you didn't know that you might wonder why we didn't just drive to my mother's place.*

**He is right, and it is more than a clarification. It is load-bearing three times over:**

1. **It explains the dormancies.** 86% of elapsed days inside a long gap is not a car sitting idle — **it is a car waiting 2,500 miles from its owners while they are at home.** Every dormancy is a flight.
2. **It explains the scope boundary.** The ~3,700 implied Honolulu miles the record deliberately excludes are the ONLY miles driven where they live. **The log is a record of driving that happens somewhere else.**
3. **★★★ AND IT INVERTS LAYER ONE A SECOND TIME.** *You don't do much driving in Hawaii (think: downtown Honolulu). Driving on the mainland was something different for us.* **The preconception says a Smart car is a city car. These owners LIVE in a city — and bought one to do the opposite of city driving.** The car that looks built for Honolulu was used to escape it. **That belongs beside the safety inversion in the Foreword: two counter-intuitive turns, one after the other, and both are true.**


## ★★★ THE CHAPTER LIST — FIRST DRAFT AGAINST THE THREE LAYERS (2026-08-20)

**Drafted for Kim to correct, not to approve.** The charter's six-chapter list is retired by this. One structural argument is made below and flagged so it can be rejected cleanly.

### ★★ THE ONE ARGUMENT: DO NOT QUARANTINE THE DIFFICULTY STRAND AT THE BACK

Kim named the data layer as having two ends — **collection/transcription/cleaning** at one, **analysis and display** at the other — and said the first is usually exiled to an appendix. **If the difficulty chapters all sit at the back, they read as an appendix no matter what they are called.**

**The fix is to interleave them, and there is an argument for it beyond variety: the difficulty chapters are what EARN the analysis chapters.** A reader cannot believe *$0.0939 per mile* until they know how the cost column was audited. **Put the audit before the economy chapter and the number is credible; put it after and it reads as a defence.** So each analysis chapter is preceded by the difficulty story that made it possible.

---

### FOREWORD — Why there was a car at all

The mother in Lake San Marcos, the frequent visits, the rentals adding up, **the parking spot at her place.** *We'd visit for a few days and then go off to a meeting. We'd drive back and visit again.* **And early, because nothing works without it: they live in Hawaii.** *You don't do much driving in Hawaii — think: downtown Honolulu. Driving on the mainland was something different for us.* Ends on the promise: **an errand car, and 71,283 mainland miles.**

### PART ONE — THE CAR *(the layer everyone arrives with)*

**1. These are small cars!** The fleet — four cars, sixteen years, three ICE and one electric, **the choice made again three times after the first.** Mercedes, the tridion safety cell, race-car logic. **And the honest admission that the engineering answer only half-lands:** *Do they believe it? Maybe. Maybe not.*

**2. Is it safe?** ★ **The thesis chapter, and the one to write first.** *Small and nimble are components of safety* — the inversion. The Yukon pothole, *big enough to eat a big car too*. The Texas on-ramp (**never located beyond *near Fort Worth***). **The denominator: 100,999 documented miles across three cars, 467 fills, 45 states, 10 provinces, no crash.** The wide tires bought for handling — **and what that safety cost: nothing measurable.** Closes on Kim's own caveat: *granted, no crash testing.*

### PART TWO — THE DRIVES *(what actually happened)*

**3. The anchor.** Every complete trip is a loop from one parking space. **Parking as the hidden infrastructure** — the mother's facility, the niece, the colleague's garage, the improvised car wash near the St Louis airport. *We've been fortunate that friends and family have helped at critical times.*

**4. The expeditions.** The crossings, trip by trip, 2010 to 2017. **The Arctic Circle Challenge is CROSS-REFERENCED, never re-told** (intentions item 2). Ends with the last year's shape: two relocations, then the Matson dock.

**5. The long days.** Eight of them, and **why each happened** — a navigation error and fireflies, a nephew at the Petrified Forest, Montana having nowhere to stop, a red-eye flight to Bellingham, a mother at 104.

**6. The roads.** Kim's taxonomy, built from experience rather than speed: **rolling wooded hills** (the relief), **tree tunnels** (the monotony, in the South), the commercial freeway both are a relief from, gravel, coast.

**7. What the driving cost.** The near-misses and the stressful miles. **The Canadian Plains read as an unremarkable fast run and were the worst miles of the crossing.** ★ **This chapter exists to establish that the record cannot see the driver — it is the hinge into Part Three.**

### PART THREE — THE DATA *(both ends, interleaved)*

**8. Sixteen years of paper.** *(difficulty)* The field sheets, the handwriting, **the slashed zero that predicts the DIRECTION of an error.** The scans, the AMEX statements as a third independent record, **the crossbar that turned out to be a scanning artifact.**

**9. How you know a number is wrong.** *(difficulty)* **The pump identity.** The six audit instruments. The errata architecture — corrections beside the source, never in it, **keyed to a ROW and never to a LABEL.**

**10. What the car cost.** *(analysis — now believable)* Economy, cost per mile, **no degradation in sixteen years**, leg length as the strongest predictor. The two cars side by side, **with the fuel-price caveat stated rather than buried.**

**11. What a day in a Smart actually looks like.** *(analysis)* Daily distance, **where the beds are**, departure discipline, gross speed by road — **and the ceiling: Creamsicle's stopped-time column puts driving 7.5 mph above the gross.**

**12. The two constellations.** *(analysis, and the payoff chapter)* Where it drove, and **where it slept** — the map nobody thinks to draw.

**13. What the record cannot say.** *(difficulty, and the closing argument)* **Resolution and silence** — Florida, a few minutes in the panhandle, invisible. **Delaware, present as a distance and absent as a name.** The retired temperature effect. **The southern economy signal that cannot be settled because the sample is closed at thirty.** And **the witness as an instrument with its own error profile** — content reliable, index not.

### AFTERWORD — The choice made again

Four cars, a lease returned, a car sold to family, **an electric one in the driveway now.** What sixteen years of making the same decision means, and what the record could not have told you without the stories.

---

### Notes on the draft

- **The fabric runs through everything.** Car performance and human performance are not chapters; **Part One is mostly the car, Part Two mostly the human, and Part Three separates them explicitly.** That is the two-subjects frame doing its job as the weave.
- **Chapter 7 is the hinge and is deliberately placed.** It ends Part Two by proving the stories carry something the numbers cannot, which is what licenses Part Three to be honest about its own limits in chapter 13.
- **★ A LINE THAT MUST BE HELD: the difficulty strand is about THE RECORD, not about the analyst.** Kim's handwriting, the paper, the reconstruction, the resolution limits — **all book material.** The PKM's own tooling failures (a write function that inflated a file, a negative index that duplicated one) are **hygiene, not narrative.** They stay in `pkm_findings.md`.
- **13 chapters plus front and back matter.** If that is too many, chapters 8 and 9 merge, and 10 and 11 could.
- **Retired by this draft:** the charter's *Foreword / The Canvas / The Expeditions / The 4th Crossing / The Extremes / The Fleet*. The Canvas survives as chapter 12, The Expeditions as chapter 4, The Fleet as chapter 1 plus the Afterword. **The 4th Crossing and The Extremes do not survive as chapters** — they were one-car framing, and their content is distributed.


## ★★★ SOUTH DAKOTA IS IN THE RECORD AFTER ALL — AND I TESTED THE WRONG HYPOTHESIS (2026-08-21)

Yesterday I reported that **no leg in the record has room for South Dakota.** That was wrong, and the way it was wrong is the useful part.

### The segment

**2012-05-27, Casper WY → Ogallala NE, 408 odometer miles**, with two intermediate fills. Split by them:

| segment | odometer | direct road |
|---|---|---|
| Casper → **Douglas WY** fill | 62 | ~50 |
| **Douglas WY → Bridgeport NE** fill | **255** | **~175** |
| Bridgeport → Ogallala | 91 | ~90 |

**All of the slack — about 80 miles — is in one segment, and the great-circle ratio there is 1.83.** For scale, ordinary interstate runs about 1.15 and the Tail of the Dragon day reached roughly 1.4. **This is the most indirect stretch the audit has turned up in sixteen years, and it produced no correction, because there was nothing arithmetically wrong with it.**

### Where 255 miles goes

- **Direct:** Douglas → Lusk WY → NE-71 south → Bridgeport. **~175 miles.** The odometer rules it out.
- **North:** Douglas → Lusk → **US-20 EAST across the Nebraska panhandle to CHADRON** → US-385 south → Bridgeport. **~245 miles.**
- **North, plus a run to the line:** **Chadron NE sits twelve miles from the South Dakota border.** Out and back adds ~24.

**Logged: 255.** Road estimates carry ±15 miles easily, so this does not pin the exact turn-around point — **but it decisively excludes the direct route and places the car on the only road in the region from which the state line is a short dash.**

**And the corroboration is not only geometric.** Kim: *a narrow, rural road toward SD*, *a side trip across a rural landscape*, and **a convoy of storm chaser vehicles coming the other way.** **Late May, the High Plains — that is the season and the country for it.** The date, the region, the road type and the eighty unexplained miles all agree.

### ★★★ WHY I MISSED IT: THE TEST WAS SOUND AND THE HYPOTHESIS WAS NOT

My check yesterday read: *the only slack is ~80 miles, and a Black Hills dip needs ~110, therefore no room.* **The arithmetic was right. The hypothesis was wrong.** I had assumed that visiting South Dakota meant going somewhere in South Dakota — Rapid City, the Black Hills, a town with a fuel pump. **Kim's goal was the LINE.** *I drove just far enough to cross the state line into SD, then turned around and left.*

**Rule. A negative result is only as strong as the hypothesis it tested, and a null carries the hypothesis's assumptions invisibly inside it.** I reported *no leg has room for it* when the honest statement was *no leg has room for the trip I imagined.* **Before concluding that a record cannot contain something, state what you assumed the something looks like** — because that assumption, not the data, is usually what fails.

**This also completes the state picture.** All four states the log never names now have an account, and **three of the four are corroborated by geometry**: Delaware by exclusion, Rhode Island by a fill on the Providence road, South Dakota by eighty miles of detour on the right day in the right country. **Only Florida rests on testimony alone — and Finding 036 already explains exactly why it must.**


## ★★★ FLORIDA IS PHOTOGRAPHED — AND FINDING 036 WAS RIGHT ABOUT THE WRONG INSTRUMENT (2026-08-21)

**Kim produced a photograph of the corner where he stopped, with coordinates: 30.983392, -87.571312.** A rural crossroads — **N Pineville Rd × Rease Seales Rd** — a DEAD END sign, a wooden farm mailbox lettered *SEALES FARM*, hay bales, open fields.

### The geometry is exact

| | |
|---|---|
| the AL/FL boundary in Escambia County | the 31st parallel |
| the photograph's latitude | **30.98339 N** |
| **distance inside Florida** | **1.15 miles** |
| distance from the **Atmore AL** fill (2014-05-07, odo 43,037) | **5.4 miles** |
| Atmore's own distance north of the line | 1.7 miles |

**So the entire Florida visit is about eleven miles of driving hung off a fuel stop** — down across the line, stop at a crossroads, ask a passing driver, turn around. **And that is exactly the size of the slack already sitting in the record:** the New Orleans → Atmore segment reads **210 odometer miles against ~195 direct.**

**Three independent kinds of evidence now agree**, and they were acquired in the reverse order of their strength:

1. **Testimony** (2026-08-18) — *is this Florida?* **Unfalsifiable.**
2. **Incidental knowledge** (2026-08-21) — Styx River Road. **Falsifiable, and it survives.** Finding 044.
3. **A geotagged photograph** (2026-08-21) — **documentary, checkable against Street View, 1.15 miles inside the state.**

### ★★★ FINDING 036 WAS RIGHT, AND IT WAS RIGHT ABOUT ONE INSTRUMENT ONLY

The rule reads: **a record's RESOLUTION sets the floor on what its silences can mean.** The fuel log samples at fill-ups and overnights; **the Florida visit produced neither, so the log cannot see it. All of that is still true.**

**What the rule does not license is the leap I made from it — that the visit was therefore UNRECORDABLE.** It was not unrecordable. **It was unrecordable BY THAT LOG.** Kim was carrying a second instrument that samples on a completely different trigger — whenever something is worth looking at — and it caught the thing the first instrument structurally could not.

**Rule. When a record cannot reach an event, the next question is not *is it lost* but *what ELSE was running at the time?*** Every silence in this project has been treated as a property of the fuel log. **Some of them are only a property of which record we happened to consult.**

**And note the shape of the recovery:** *I had forgotten that evidence.* **Content reliable, index unreliable, again (Finding 039)** — he did not misremember the corner, he misremembered that he had proof of it.

### ★★★ THE QUESTION THIS OPENS, AND IT MAY BE THE BIGGEST ONE LEFT

**Creamsicle has 37 geotagged, timestamped photographs that join to its logs on date and local time with no timezone reconstruction.** We knew that. **What we did not ask is whether the TwoRed years have an equivalent archive.**

**If they do, the project gains a second trip-record that samples where the fuel log cannot** — at viewpoints, at borders, at the moments worth stopping for, rather than at fill-ups and hotels. **That is precisely the complement of what the fuel log records**, and it would bear directly on chapter 12 (the constellations) and on every silence chapter 13 discusses. **ASK KIM. This is the highest-value open question in the project.**


## ★★★ THE OWNERSHIP DOCUMENTS — EVERY DATE IS NOW SOURCED, AND TWO WERE WRONG (2026-08-21)

Kim gathered purchase, lease and sale paperwork into `data/<car>/`. **Read, and written to `data/fleet_ownership.csv`, which `book_setup.R` now loads — so no ownership date in the book is typed.**

| car | acquired | ended | document |
|---|---|---|---|
| **TwoRed** | **2010-07-23**, odometer **4**, Smart Center San Diego, NEW | **still owned**, in Honolulu | Vehicle/Vessel Transfer and Reassignment |
| **Two4Two / TwoFer** | **2014-03-22**, odometer **25**, Mercedes-Benz of Honolulu, NEW, **36-month lease** | **2017-03-22** (statement 04-08, paid 04-20) | Hawaii Motor Vehicle Lease Agreement + Lease End Statement |
| **Creamsicle** | **2021-09-15**, **USED** (a 2016 ForTwo), Modern Motorcars, DocuSign 4:59 PM CDT | **2024-10-20**, sold to family | purchase paperwork; sale by the licence-plate photograph |
| **Bordeaux** | **2019-04-01**, 2018 model, **leased then bought out** | **still owned** | Temporary Registration Certificate |

### ★★ TWO OF KIM'S DATES ARE OFF, AND BOTH ARE FINDING 039 EXACTLY

**Creamsicle: he said *a 2016 model we bought in 2018*. The DocuSign envelope is timestamped 2021-09-15, signed by him at 4:59 PM CDT**, and the fuel log's first fill follows **eight days later** — 2021-09-23, Nixa MO, odometer 30,290. **Content right (used, a 2016 model, from a dealer); index wrong by three years.**

**TwoFer: I wrote *leased for about ten months in 2014 and 2015* in chapter 1. The lease agreement says 36 months, 2014-03-22 to 2017-03-22.** I had read the last logged fill (2015-01-10) as the end of the lease.

**★★★ THAT ONE IS MINE, NOT HIS, AND IT IS FINDING 041 AGAIN.** *A fuel row is a TRANSACTION, not a STATE.* **The last fill is not the end of ownership**, any more than a fill city is where the car slept. **I flagged Kim's account as a discrepancy — *the lease ends January 2015 and TwoRed didn't ship until May 2017, what covered the gap?* — and the answer was that nothing needed to: the lease covered it.** He was right and the query was mine to withdraw.

### ★★★ AND THE HANDOFF IS EXACT

*It was, basically, a fill in for TwoRed until we brought TwoRed to Hawaii.*

**TwoFer's lease ends 22 March 2017. TwoRed leaves the Matson dock in Seattle on 22 May 2017. Sixty-one days.** The stand-in was returned two months before the car it stood in for arrived. **Kim's sentence is not approximate; it is a description of the actual schedule.**

### ★★★ A GAP NOBODY HAD NOTICED: FOUR YEARS WITH NO MAINLAND CAR

**Last mainland mile: 2017-05-22. Creamsicle bought: 2021-09-15. Four years and four months.**

**This changes what Creamsicle IS.** I had been calling it a replacement for TwoRed. **It is not a replacement — TwoRed was never replaced, they still have it.** It is the **resumption** of mainland driving after a four-year interruption, and it starts in Missouri rather than California because the Lake San Marcos anchor was gone by then.

**Two things follow for the writing.** The fleet is not a relay of one car handing to the next; **it is TwoRed continuously since 2010, with a Honolulu stand-in inside it, a mainland successor four years after the pause, and an electric car alongside.** And **the four-year gap wants an explanation** — it spans the pandemic, but that is an assumption, not a finding. **ASK KIM.**

### ⚠ PRIVACY — THESE DOCUMENTS CANNOT BE REPRODUCED AS FIGURES WITHOUT REDACTION

They carry, between them: **a home street address and apartment number**; a mainland mailing address; **two driver's licence numbers**; a Mercedes-Benz Financial **account number**; **four VINs**; an email address; Nancy's full legal name; and signatures. **If any document becomes a figure, redact first.** Kim has been shown photographs as figures already, so this is live, not hypothetical.

### ★ One more fact from the lease, useful and bounded

TwoFer's mileage allowance was **22,500 miles over 36 months**, and the Lease End Statement charges **$0.00 excess wear and no excess mileage at all** — only the flat $395 turn-in fee. **So TwoFer went well under 22,500 miles in three years**, which is the only lifetime bound the record supports. **The 1,209-mile figure covers seven fills between March 2014 and January 2015 and is NOT a lifetime total** — chapter 1 must not say it is.
