# Specimen Labels — Design Notes

_An informal, running design narrative kept alongside the code. Thinking-writing,
not polished publication: it's where ideas get worked out before they go into the
software, and it will become the raw material for the eventual document. Append as
we go. Started 2026-06-29._

## Method (decided 2026-06-29)
**Interleave code and writing**, informally. Because the design here is still being
*discovered* (unlike the recent code-then-docs projects, where the construct was
settled before documenting), describing what we're doing is a design instrument, not
just a record. Write the "what and why" of each piece as we build it. Keep two
registers separate: this narrative + worked examples run tight against the code; the
polished Quarto document/vignette lags until pieces stabilize, to avoid churn.

## The spine (one line)
Photograph a small set of QR-coded cards, **keyed by the specimen's collection number**, at the moment of
collection, so one small field act yields two co-equal products with no transcription: the herbarium
**label** and an archivable **field log**. The specimen stays bagged; the **number is its stand-in**.
(Full concept: `proj_specimen_labels.md`. Refined 2026-07-02 — see "The photograph is of the cards, not the
specimen" below; earlier "photograph the cards *with the specimen*" phrasing is superseded.)

## Encoding scheme (settled)
- A card's QR carries the **full, self-describing text** (`Life Form: Tree`), so a scan
  reads finished label text with **no codebook**. Phrases are short enough to encode in
  full *and* run high error correction (`ecl = "H"`). A code+lookup table is reserved
  only for decks whose values get long.
- **Redundancy / graceful degradation:** each card prints value + field name *and* the
  QR — three copies of one fact. A card that won't scan still reads to the eye. This
  mirrors the collection photo's three independent layers (printed number, QR, EXIF
  location): the data survives partial failure by design.
- The `<Field>:` prefix also **namespaces** the codes, so the reader can sort the cards
  found in one photo.

## Three deck families (agreed 2026-06-29)
Balanced in importance, different in role. The reader/assembler treats each differently.
1. **Identity / determination** — the collection number (the key), and target-species
   cards (pre-determine a known target). Identify or determine the specimen.
2. **Observation** — controlled-vocabulary categories: Life Form, Abundance, Phenology.
   Fill their named fields.
3. **Free-text** — the Comment card. The **universal fallback**: write what no deck
   anticipated, or what conditions won't let you card. Looks minor; load-bearing in the
   hard cases.

## The friction trade — the honest center (discussed 2026-06-29)
We remove a **large, delayed, data-losing** friction (transcribing field notes weeks or
years later) but add a **small, immediate** one (handling cards in the field). The system
only wins if the new friction stays *below* the old. So **simplicity is the survival
condition, not a nicety**: if managing cards is slower than scribbling, we've lost.

**Card risks (physical, real):** cards get dirty, dropped, or blow away; fumbling among
many decks with cold, wet hands in bad conditions.

**Mitigations (situation-dependent — no single prescribed kit):**
- Carry **few decks** — only what the day and discipline need.
- **Bind each deck on a ring** — one object you fan to pick a card, not loose cards that
  scatter or blow away; **tether** the ring to the vest so a drop just dangles.
- Durable, **laminated** stock.
- Redundancy already covers dirt: a smeared QR still reads to the eye; high ECC tolerates
  partial occlusion.
- **One photo, many cards:** lay the relevant cards by the specimen and take a single
  shot (the multi-card decode we validated), not a photo per attribute.

**The graceful-degradation floor (key design move):** the non-negotiable minimum is the
**number card + the photo** — identity, location, and date secured. Category decks are
*optional enrichment* added only when conditions allow. In a gale, drop the number card,
one shot, move on; the collection is still safe. The comment card is the fallback above
that floor for anything you can't card in the moment.

## Physical handling design (2026-06-29) — form matches the data semantics
The handling design and the data model line up, family by family:
- **Observation decks = screw-post stacks.** Cards bound on little screw posts with a
  **color-coded plastic top/bottom cover** (yellow = phenology, as built 2026-07-28). You **rotate exactly
  one card into view** and photograph it. The affordance *enforces the semantics*: an
  observation field is mutually exclusive (flowering **or** not), and the deck can only
  show one card, so you can't record two values. The colored cover is field identity you
  read before reading (grab the right deck by color in bad light) — a friction reducer and
  one more redundant layer. You never detach an observation card.
- **Identity + free-text = business-card holders.** These you *detach* (a number card onto
  a specimen) or *write on* (a comment), so a loose holder fits better than a bound stack.
- The whole kit fits in a **vest pocket** — the friction floor made real.

## How many observation decks? (open — survey pending)
A field deserves a deck only if it is all three: an **observation** (not derivable), and
**categorical** (small closed vocabulary, not a measurement), and **chosen in the field**
(not at the desk). Most herbarium-label fields fail the filter:
- date / lat-long / elevation / much locality → **free from the photo** (EXIF + GPS).
- determination / family / formatted locality → **desk work** (except target species = an
  identity deck).
- habitat / associated species / prose → **comment cards**.
Deck candidates that survive: **life form/habit, abundance, phenology** (have these) + a few
discipline-dependent maybes (substrate, habitat/vegetation type, flower color, coarse size
class). Likely answer: a **small set, ~3–6**, membership varying by discipline. **To settle
it empirically (Kim's call):** survey standard herbarium-label fields + real examples (Track
B), sort each field into deck / auto / desk / free-text; the deck count and each deck's
controlled vocabulary fall out. Pending: run the survey vs. use Kim's references.

## "Why QR codes?" — the conceptual hurdle (early-discussion topic, 2026-06-29)
The foundational communication problem (Kim). To most people a QR code = "a link you scan
to open a website." We use it very differently, and if the reframe doesn't land **first**,
the whole approach looks pointless — worse, the reader's instinct fights us (they scan a
card, no website opens, they conclude it's broken). This is the **curse of knowledge**: we
forget our mental model of a QR isn't the common one. It's the document's *opening* move
(cf. the seasonality book opening by redefining seasonality). Two misconceptions to clear,
kept separate:
1. **What a QR holds.** It's a 2D barcode storing a short string — URLs *by convention*
   only. Ours holds a field datum: the machine-readable twin of the printed words, not a
   secret link.
2. **Scan vs photograph.** Familiar use is *interactive* (one code, scan, act now). Ours is
   *passive capture*: photograph specimen + cards (GPS/time ride along for free), then
   **batch-decode every code from every photo later**. The phone QR reader is the wrong
   tool — built for one-code-act-now, not many-codes-capture-later-with-location.

**A vindication of the self-describing encoding:** because the QR carries readable text, a
naive phone-scan of our card shows `Life Form: Tree` — sensible, not a broken link or a
cryptic token. Short codes + codebook would have shown `PH:FL` and deepened the confusion.
The robust choice is also the newcomer-friendly one.

**Demonstrate, don't explain** (Kim's "concept is the bottleneck" → show a working example).
Three small demos, placed at the very front of the document:
1. **Scan this, get text** — one card the reader scans now to see plain words pop up, not a
   website. Dissolves "QR = link" in one scan.
2. **One photo, many codes** — a multi-card photo decoded to several strings at once;
   passive batch capture; the camera, not the scanner, is the tool.
3. **Two workflows side by side** — scan-to-open vs photograph-to-capture, as a diagram.

## Deriving the fixed data — terrain from coordinates, and a *second* kind of friction (2026-06-30)

Two threads met today: the Track B survey (what collectors actually record) and the
resurrection of the 2020 terrain-extraction code. Together they add a whole class of label
data *and* sharpen the friction argument.

**A second kind of friction — attention, not transcription.** The spine named
*transcription friction*: the delayed, data-losing chore of writing labels up later. Kim
named a distinct one today — **attention friction**. In the field, slope, aspect, drainage,
roughness, substrate — genuinely useful site descriptors — are routinely *overlooked* in
classical notetaking. Not because they're unimportant, but because **attention is finite and
the collecting moment is crowded**: so much is going on at the specimen that these get
skipped. The failure is neither motivation nor transcription; it's that the field pulls your
attention elsewhere and the secondary-but-important things never get written.

**The resolution: derive the fixed things in post-processing.** These variables share a
property — they are **fixed**. A spot's elevation, slope, and aspect don't change between the
moment of collection and the desk. So recording them in the field spends scarce attention for
*no gain*: they can be reconstructed exactly later from the coordinate the phone already
stamped. This is the derive-vs-observe partition seen from the friction side:
- **Fixed + derivable → post-process** (terrain, place-name hierarchy, geology/soil, climate).
  Hand-recording them wastes field attention.
- **Ephemeral + observation-only → capture now** (phenology, the plant's state, associated
  species). These *cannot* be recovered later — they are exactly what field attention should
  be reserved for.

So the terrain engine isn't a mere convenience: it **protects field attention** for the things
only a human standing at the plant can supply. The decks and the derive-engine are two halves
of one friction strategy.

**The terrain engine (`site_extract.R`).** Resurrected from the 2020 prototype, cleaned, and
rebuilt with a **DEM source switch**: `source="aws"` (default) uses free, keyless, global
elevation tiles that are automatically fine-resolution over the US (3DEP/lidar); `source=
"google"` keeps the old method as a fallback. From `name + lat/long` it returns elevation,
slope, aspect, roughness, local relief, and drainage direction — each tagged with its source,
native resolution, and analysis scale.

**A correctness lesson worth keeping (for the document).** Checking the old code against finer
DEMs taught something honest: *the old technique was right about the robust variables and
misleading about the fragile one.* Elevation and aspect were stable across every data source;
but the 2020 coarse 3×3 over a 76 m DEM **overestimated slope** (40° vs a true ~31°), and
**roughness is scale-dependent** (it shrinks as cells shrink — 9.7 at 76 m down to ~2 at 4.5 m).
The fix: make the **analysis scale an explicit parameter in metres**, independent of the DEM's
resolution, and carry source + resolution + scale with every value. The lesson generalizes past
terrain: *a derived datum must state the scale and source it was derived at, or it isn't
trustworthy.* What surfaced it was redundant cross-checking — two DEMs, and two sites (Koko,
and Fuji against its known south-facing slope).

### Canopy from coordinates — a test, and its ceiling (2026-06-30)

Follow-on to the terrain engine: if a **DSM** (surface / canopy-top) minus a **DTM** (bare earth)
gives canopy height, then a *biotic, habitat-type* descriptor is also **derivable from the
coordinate** — pushing the derive-vs-observe line further into vegetation. Canopy changes slowly,
so it sits on the fixed/derivable side: post-processable, attention-sparing, and speaking to the
"habitat" field the *Metrosideros* dump showed collectors record so unevenly.

**The test (Kilauea, control design).** ALOS AW3D30 (DSM, 30 m) minus AWS/3DEP (bare earth),
sampled as a mean within 45 m. The grassland is the **control** — its canopy should read ~0, so
whatever it shows is the baseline offset between the two layers, and *forest − grassland* isolates
the real signal.
- **Grassland 0.6 m** → control passes; the DEM offset is negligible, so the method is sound.
- **Mid-height ʻōhiʻa forest 7.5 m** → matches ground truth; and the CHM map put the point right on
  the visible forest edge, fence line resolved even at 30 m.
- **Kīpuka Puaulu (tall mixed ʻōhiʻa–koa) 8.0 m** → **wrong.** This stand is ~20 m tall; the method
  reports 8. Not noise — a **ceiling**.

**What the ceiling means.** The cheap DSM−DTM difference is a good canopy *detector* (open vs
forested, roughly right for short-to-mid canopy) but **saturates over tall closed forest**. Likely
causes, both about the coarse global layers: ALOS at 30 m smooths tall crowns, and — probably bigger
— dense Hawaiian forest may have **no true lidar bare-earth**, so the "DTM" is itself partly a
surface and the difference collapses. **Design decision:** use the difference only as a coarse
"forested? / short or tall?" flag; for a trustworthy canopy-height *value*, use a purpose-built
GEDI-derived product (ETH 10 m, Meta 1 m).

**Verification lesson (again).** Kim's ground knowledge — Kīpuka Puaulu is a *tall* forest — caught
the method's ceiling. The disagreement *is* the finding, and it re-proves the standing rule: a
derived datum must carry not just its scale and source but its **limits**. A control site (the
grassland) and a known-tall site (the kīpuka) together bracket what the method can and can't do.

**Confirmation — the dedicated GEDI layer clears the ceiling (Meta 1 m).** Cross-checked the three
sites against the Meta/WRI **1 m** GEDI-calibrated canopy map, streamed **keyless** from the public
AWS bucket via `/vsicurl` (`tiles.geojson` → quadkey → `chm/{quadkey}.tif`; no special package). Result,
mean within 45 m: grassland **0.0 m** (agrees), ʻōhiʻa edge **4.3 m** (agrees, low-mid), and **Kīpuka
Puaulu 15.8 m** — against the DSM−DTM's saturated **8.0 m**. The 1 m map resolves individual ʻōhiʻa/koa
crowns and the gaps between them. So the ceiling is confirmed: the cheap DSM−DTM difference is a
*detector* (open vs forested, short-vs-tall); the purpose-built GEDI product is the *measure*. **Decision:**
if canopy height ever becomes a derived label field, use the Meta 1 m (or ETH 10 m) GEDI-calibrated
product — and note it streams keyless from open AWS, so it fits the "derive from coordinates" model cleanly.

## Physiognomy, scope, and rendering — three axes for every variable (2026-06-30)

The canopy work surfaced a **major addition**: a **physiognomic description** of the vegetation —
the *structural* half of a habitat description (canopy height class, closure/cover, vertical
heterogeneity, gappiness) — is **quantifiable and derivable from the coordinate**. Read blind, the
Kīpuka canopy raster gave "moderately tall, largely closed, uneven-aged montane forest, canopy ~10–20 m,
emergents to 25 m, ~12% gaps" — no species needed. This directly addresses the "habitat" field the
*Metrosideros* dump showed collectors record so poorly, and it does so on the derive side.

Kim's framing named two distinctions we had been running together. They give **three orthogonal axes**
that now organize every candidate variable:

1. **Derive vs observe** — can the landscape supply it (terrain, place, climate, canopy *structure*),
   or must a human at the plant judge it (phenology, the individual's attributes, floristic identity)?
2. **Per-specimen vs collection-spanning** *(new)* — does the variable belong to the individual sheet
   (taxon, phenology, this plant's habit), or does it describe the **site / stand / collecting event**
   and apply to *every* specimen from it? The physiognomic forest description, the site terrain, and the
   expedition narrative ("a protected koa/ʻōhiʻa forest with a number of interesting additional canopy
   trees we were able to collect") are **collection-spanning**: they live at the field-log / site level
   and are stamped onto each label as needed.
3. **Label-summary vs field-note-detail** *(new)* — the same datum often projects **two renderings at
   two granularities**: a compact token for the **label** ("closed montane forest, canopy ~15 m") and the
   **full detail** for the **field notes** (height distribution, cover %, gap fraction, the CHM figure).
   This is "capture once, project two views" applied to a *derived* variable — the label gets the
   abstract, the log keeps the evidence.

**Canopy physiognomy is the clean worked example:** *derived* · *collection-spanning* · *label-summary +
field-note-detail*. The canopy-tree **species** narrative (koa/ʻōhiʻa + the notable additional canopy
trees) is the companion on the *observe* side — expedition-narrative, collection-spanning, and part of
the sampling *strategy* (you go to target those canopy trees). Noted and deferred; likely a
collection-spanning field-note variable, not a per-label one.

## The deck-discovery methodology — the real deliverable (2026-07-01)

**The reframe (Kim).** We are *not* producing "here are the decks you need." We are producing **a
methodology for discovering what decks are needed.** The method is the contribution; any particular
deck set is just its output for one community, taxon, and era. This is the more important thing.

**Framing for the document's opening (Kim, 2026-07-01).** Collecting, identifying, preserving, and
labelling plant specimens was one of the first *crowd-sourced* scientific projects — two centuries of
collectors, and, equally, the aggregators (herbaria) who keep the sheets, sometimes for hundreds of
years. Those old sheets are early relics of scientific history. Yet the core process — collect, press,
annotate — has stayed remarkably the *same*; we've added databases that replicate the label, but
"sameness" dominates. That immense, consistent, crowd-sourced corpus is exactly what the methodology
*mines*: the latent structure of *who records what* was never written down, and now it can be
extracted.

**The procedure.** For any collector community / discipline / taxon:
1. Pull the aggregated records (GBIF / Darwin Core), scoped by taxon, region, and **recent decades**
   (last ~40 yr, to catch ecological practice without drowning in older taxonomic collecting).
2. Consolidate `recordedBy` to a **primary collector**.
3. Compute each collector's **field-signature** — the fraction of their records carrying each kind of
   datum (field occupancy + a few content flags: substrate, morphology, associated species).
4. **Cluster** collectors by signature.
5. Each cluster's characteristic fields = that discipline's **deck profile**; fields empty across *all*
   clusters but worth capturing (e.g. phenology) = **cross-cutting / universal decks**.

**Proof of concept (worked).** *Metrosideros*, US, PreservedSpecimen, 1985–2026: n = 1,144
(`label_survey/metrosideros_US_1985_2026_fulldwc.csv`). 413 raw collector strings → 126 primary
collectors; 20 with ≥10 records (74% of the data). Ward clustering of the signatures recovered **four
archetypes from the data alone**:
- **① Describers (taxonomic/monographic)** — morphology + determination-by-specialist + type status +
  elevation (Takeuchi, Stemmermann, Stacy, Johansen, Oppenheimer, James…). Record is *about the plant*.
- **② Place-recorders (ecological / rare-plant survey)** — habitat + substrate + associated species +
  own collection numbers, self-determined (Wood [202 records], Walsh, Wolkis, Tangalin, Ramp…). Record
  is *about the site*.
- **③ Terse** — little in any notes field. Tell: **John Dawson, the *Metrosideros* monographer, is the
  tersest** — his expertise lives in the *determination*, not the field notes; and Percy (a psyllid
  researcher) logs habitat but no plant morphology, because her subject is the insect.
- **④ Machine (NEON)** — everything templated to 100%, but no collection number and no phenology. Not a
  human deck; an automated protocol.

**Two results.** (a) Decks should be **discipline *profiles*** and the data tells us their contents — a
taxonomist picks morphology/flower/determination cards, an ecologist picks habitat/substrate/associates
cards; the "modular by discipline" instinct is now empirically grounded. (b) **Phenology is the
universal gap** — near-zero for every archetype — so the phenology deck is *cross-cutting*, the one deck
that belongs in every profile.

**Why the method beats a fixed list.** Deck sets are discipline- and taxon-specific and drift over time;
any prescribed list is wrong for someone and stale by next decade. The method is general, reusable, and
self-updating; it turns deck design from *opinion* into *measurement*, and it legitimizes the controlled
vocabularies by grounding them in what a community actually records. It also answers the old open
question ("how many observation decks, what's on each?") **structurally** — not with a number, but with a
procedure that yields the number for any context. And it is *transmissible* — a thing others can run on
their own corpus.

### Anecdote — the 161-column spreadsheet (Kim, 2026-07-01)
The friction with a face. A student asked the herbarium curator which fields to fill when submitting
voucher sheets. The answer: use the spreadsheet with **all ~161 columns**, keep every header *exactly*,
and fill one row per specimen — cells often long. Just *handling* that sheet was nearly overwhelming.
This is why people wait; and when curation is *forced* (no spreadsheet → no accessioning), they resent
the wasted time. The irony worth keeping for the document: those ~161 columns are the very Darwin Core
fields our GBIF pull returned (**161**), the same schema the deck-discovery method mines — what
overwhelms one collector at submission is, aggregated across a community, exactly what reveals the few
cards each discipline needs. The current system asks the **human to be the database**; the QR-card method
**inverts** it — capture at the source, let the database assemble itself.

### Anecdote — the 1970s field kit *was* the derive engine (Kim, 2026-07-01)
The tools a collector carried in the 1970s (and long before): a **barometric altimeter** (set it before
you leave or it's worthless) → *elevation*; a **clinometer** → *slope*; a **compass** → *aspect* +
wayfinding; a **topographic map** → *place names, distances, terrain*. Plus the write-in-the-rain
notebook, pencils and a knife to sharpen them, plastic bags, garden shears, and a label-maker for the
tags. A lot of technology — simple but not cheap (altimeters especially), and most people didn't own the
basics; you **checked the gear out of the stockroom before it closed on Friday**. So add
**equipment / access friction** to the list. The point for the document: **that entire instrument kit
measured exactly the variables we now derive from one coordinate** — altimeter + clinometer + compass +
map = `site_extract()`. The 1970s answer to the fixed/derivable variables was to carry four instruments
and calibrate them; the phone-GPS-plus-post-processing answer removes the instruments, the calibration,
*and* the stockroom trip — leaving the collector's scarce attention for what only a human can record.

## Method validation — a second taxon, a different deck landscape (*Pueraria montana*, 2026-07-01)

Ran the formalized `discover_decks()` on **kudzu** (*Pueraria montana*, US PreservedSpecimen 1985–2026,
n = 911, taxonKey 2977636) as the contrasting test. It produced archetypes clearly **different** from
Hawaiian *Metrosideros* — which is exactly the point that proves this is a *method*, not a one-off result.
Kudzu brings three constituencies *Metrosideros* lacked (taxonomists over the variety/species question,
invasion ecologists, conservation/management), and the signatures shifted accordingly:

- **What vanished — the taxonomic-describer archetype.** `type_status` is **0 for every** kudzu collector
  and `identified_by` is near-zero for most: an unmistakable weed isn't sent for specialist determination
  or typified. The morphology/determination apparatus that *defined* the *Metrosideros* taxonomic cluster
  is simply absent.
- **What appeared — a georeferencing / monitoring signature.** One cluster (Ebinger, **Mehrhoff**,
  Sullivan) is defined by **coordinate uncertainty (80–84%)** — the invasion-mapping stream. Les Mehrhoff
  ran the Invasive Plant Atlas of New England; precise, mappable locations are the point when tracking a
  spreading invader. Nothing like it in *Metrosideros*.
- **What shifted — phenology.** A universal *zero* in *Metrosideros*, phenology is actually recorded by
  several kudzu collectors (Diamond 73%, Mehrhoff 65%, Ebinger 33%) — flowering/fruiting matters for a
  management target. And the records are **sparser overall**: invasive-weed vouchering is fast and thin.

So the *same* method yields, for a native taxonomically-interesting tree, **describers + ecological
place-recorders + a machine**; and for an invasive weed, **fast vouchers + habitat/phenology ecologists +
a coordinate-precise monitoring/conservation stream**. Different community, different purpose, different
decks — the deliverable (the method) demonstrated.

**Honest caveat.** The variety/species *taxonomic* interest we expected for kudzu isn't prominent in this
≥1985, ≥10-record slice — variety delimitation is done by a few specialists, often on older material or
via morphometrics that never reach routine label fields. Surfaceable by dropping the year filter or
lowering the record threshold.

Figures: `label_survey/collector_signatures_heatmap.png` (*Metrosideros*) and
`label_survey/collector_signatures_kudzu.png` (*Pueraria*) — a side-by-side that carries the whole
argument.

### The stance — peering over the shoulder of experts (Kim, 2026-07-01)
The epistemic move at the heart of the method. Instead of *prescribing* what to record (a textbook, a
teacher), we **observe what experts actually chose to do** — and at a scale that reveals *patterns*,
not one person's habit. Collector-signatures are a way of looking through each expert's binoculars to
see the specs they trust. Kim's memory of where the feeling comes from: lunch under a tree high in the
South American Andes, among several prominent ornithologists of the day, condors visible through
binoculars in the distance. He asked each of them to let him look through *their* binoculars — not for
the birds, but to see **which tool each expert had chosen** — and bought his own on ornithologist-specs
on the way home. Deck-discovery does exactly that for field botany: it reads the experts' recording
choices out of the aggregated record and hands the newcomer the experts' specs. (Ties the crowd-source
framing to the transmissible-method theme: the corpus is a store of expert practice; the method makes
that practice *legible and learnable* — you rarely get to see what the experts consider essential.)

### The two-taxa stress test — facets travel, value-sets are local (2026-07-01)
The question: on a trip yielding **both** *Metrosideros* and kudzu, does the ecologist deck hold up?
Answer: its **structure** does; its **values** only partly — and the crack is instructive.

- **Facets generalize** — they describe the *site*, not the plant. Cover, Moisture, Disturbance, and
  Associated-species work for an ʻōhiʻa forest or a kudzu thicket alike. (This is also why the ecologist
  deck is naturally **collection-spanning**: describe each site once and it covers every specimen from
  it — both taxa, if both grow there.)
- **Value-sets are local** (from the data): lava/volcanic substrate terms appear in 4% of *Metrosideros*
  records but **0%** of kudzu — my drafted `ʻaʻā` / `pāhoehoe` / `ash` values are meaningless on the
  mainland, which wants soil / alluvium / roadside-fill / limestone. And roadside/disturbed-site terms run
  2% (*Metrosideros*) vs **25%** (kudzu) — kudzu wants *roadside / old-field / fencerow* values the deck
  lacks.

**So a "deck" has two layers:** the **facet** (which generalizes — the method's output) and the
**value-set** (which is local — tuned per region and flora). One ecologist deck; its cards get re-lettered
per flora.

**The elegant resolution:** the facet whose values break — **substrate** — is exactly the one we'd
already flagged as **derivable** from a geology/soil map at the coordinate. The fix is not a second
substrate deck; it's to **move substrate off the cards and onto the derive engine**, where it's
automatically correct in Hawaii or Georgia with no region-specific vocabulary. So the stress test sharpens
the card-vs-derive rule: **facets with region-local value-sets are prime candidates to derive rather than
card.** (Reminder logged: build the geology/soil-map derive as a `site_extract` extension.)

**Milestone — "discovering decks" is complete for now:** method built (`deck_discovery.R`), validated on
two contrasting taxa, concrete deck files produced (`decks/`) and stress-tested. Remaining is refinement
(the card *values*, Kim's ongoing judgment), the kudzu variety signal (widen the year window), and the
substrate-derive (its own thread).

### The decks as a field checklist — the Checklist Manifesto (Kim, 2026-07-01)
Kim's connection, worth its own place in the document. Gawande's *The Checklist Manifesto* documents how
a simple checklist transformed disciplines (surgery, aviation) by forcing attention to the essential few
items — *especially under stress and fatigue*, when the trained mind quietly drops things. The QR-card
decks are exactly a **physical checklist** for field collecting: tired, hungry, and once it has started
to rain, you forget to record the colour or nature of the leaves. The deck forces the focus — laying down
the right cards *is* running the checklist. This grounds the decks in a proven methodology literature and
sharpens the attention-friction thesis: the win is not only removing the *transcription* friction later,
it is **protecting the essential observations from being dropped in the moment**. (Frame: the deck is a
checklist; the checklist literature is the precedent.)

### Retroactive enhancement of legacy collections (Kim, 2026-07-01)
A corollary of the derive engine that reaches far beyond new collecting. Because we offload the
fixed/derivable variables to the **coordinate + external sources**, the *same* derivation applies to
**any existing specimen that already carries good coordinates**. So the enormous georeferenced backlog in
the herbarium databases can be **retroactively enriched** — bringing the derived features we've built
(elevation, slope, aspect, roughness, drainage, canopy structure, bedrock geology, soil, climate) to
older collections that have coordinates but never recorded those fields. The crowd-sourced corpus gains
value *backwards*, not only forward. Ties straight to the crowd-source framing: the aggregators' centuries
of kept sheets become newly informative the moment a coordinate meets modern layers. Place in the document
near the "capture once / derive" material as the **"and it works backwards, too"** note. Candidate future
capability: a batch `enrich()` over a GBIF download — feed it occurrences with coordinates, get back the
full derived feature set. (Once people are taken through the whole process, this is the pointer to "now
apply it to what already exists.")

### Substrate derive — sources validated (geology + soil), 2026-07-01
Tested how developed the substrate databases are, at three US points (Kīlauea *Metrosideros*, Georgia
kudzu, Koko Crater).

- **Bedrock — Macrostrat** (global, keyless, fast): nailed it. Kīlauea = *Kau Basalt / lava flows*
  (0–2.6 Ma); Georgia = *biotite gneiss / mica schist / amphibolite* (Piedmont, 250–1000 Ma). One API,
  correct and region-appropriate everywhere. Production-ready.
- **Soil — two tiers.**
  - *SoilGrids* (global, 250 m ML, WRB class via REST): works, but slow, rate-limited, 503-prone, and
    **coarse/uncertain on young volcanic** — at Kīlauea it guessed *Cambisols* (Andosols only 14%).
  - *SSURGO* (USDA, US-detailed, via `soilDB` SDA): sharp, confident, robust. Kīlauea = Haa–Keamoku
    complex, **Andisols** (correct volcanic-ash soil — **corrects SoilGrids**); Georgia = Gwinnett clay
    loam, **Ultisols**, *"eroded"* (Piedmont — and the erosion flag marks the disturbed old-field land
    kudzu invades); Koko = **Rock land / Entisols** (dry rocky tuff cone). Each ecologically apt and
    matching the site's physiognomy.
- **Principle confirmed (mirrors 3DEP-over-Google for DEMs):** use the detailed *regional* source
  (SSURGO) inside its coverage; fall back to the *global* product (Macrostrat bedrock everywhere;
  SoilGrids soil) elsewhere. The substrate facet is **fully derivable**.
- **Reliability lesson:** SoilGrids' flaky live REST argues for **batch/cached** derives, not per-specimen
  live calls — which also serves the legacy-enrichment batch idea above.

Remaining for task #19: wire `site_geology()` (Macrostrat) + `site_soil()` (SSURGO in US / SoilGrids
global) into `site_extract` as the substrate-derive extension.

### Why a deck beats free recall — choose-from-a-list vs think-it-up (Kim, 2026-07-01)
A cognitive argument that reinforces both the decks and the discovery method. There are two opposite ways
to record a category in the field. **Think-it-up** (generate the value from memory): the mind fixates on a
vivid instance — *"orange! that unusual orange-flowered tree in Waimea…"* — and wanders off the task; one
term gets stuck and won't let go. **Choose-from-a-list** (a deck of possibilities in hand): you *select*
without the fixation and move on. The two may converge in simple cases, but for anything rich the
think-it-up approach fails relative to choose-from-a-list. This is exactly what a deck provides — **a
curated list to choose from, not a blank to fill in** — and it is a *second* reason decks work, beyond the
Checklist Manifesto "don't forget" argument: they replace fallible **recall** with reliable
**recognition/selection** (a well-known cognitive-ergonomics principle — recognition over recall). It also
justifies the discovery method: the *right* list to choose from is the one the experts converged on. So
the two threads meet — the method finds the list; the list defeats fixation. (For the document, sits with
the method-not-decks and checklist material.)

### Card-format uniformity, free place-names, and the decode engine (2026-07-02)
- **Identity card → "Number:" header.** Kim: the collector tag ("KWB: 1239") should carry its own
  `Number:` header so *every* card shares the self-describing `Field: value` format — simpler for both the
  reader and the collector, and it removes the special case. Adopted; future identity cards read
  `Number: KWB 1239`. The reader keeps a *legacy fallback* that still recognises the old collector-code
  form.
- **Place without a paid API.** The empty `place` field was because we'd deliberately avoided Google's
  *billed* reverse-geocoder. Wired **`site_place()` on OpenStreetMap Nominatim — free, keyless** —
  consistent with the all-free derive stack (AWS / Macrostrat / SSURGO). It now fills automatically: the
  test photo → *"Kaka‘ako, East Honolulu, Honolulu County, Hawaii."* Nominatim's policy limit (~1 req/s)
  means batch/cache for bulk — the same lesson as SoilGrids, and it serves the legacy-enrichment batch.
- **The decode engine (could it be all-R?).** R has **no maintained native QR *decoder*** (ZBar has no R
  binding). The decode step needs an external engine, reached either via **reticulate + pyzbar/OpenCV**
  (self-contained wheels, cross-platform — what works now, and the *union* of the two got 4/4 where each
  alone got ~1) or via the **`zbarimg` CLI** through `system2()` (keeps the code R-native but needs ZBar
  installed as a system tool — it wasn't on PATH). Everything *else* is already R (exiftoolr → exiftool;
  derive and assemble are pure R). So it's a packaging trade-off — a heavier Python dependency vs a
  system-tool dependency — to settle when we package.

### Urban reverse-geocode: compose from reliable levels; decoder settled (2026-07-02)
- **Urban geocode fix.** Kim caught two errors in the first place-name (wrong `city` "East Honolulu";
  ZIP 96850). Diagnosis: in dense urban areas OSM's **`city` field and `postcode` are erratic** (the ZIP
  is even zoom-dependent — wrong at zoom 14, correct 96813 at zoom 16), while **neighbourhood/suburb,
  county, state, country are reliable**. Fix: `site_place()` now queries zoom 16 and **composes the
  locality from the reliable levels only, skipping `city` and postcode**. Verified: photo → *"Hawaii
  Capital Historic District, Honolulu County, Hawaii, United States"* (correct — the district across
  Kim's street); Kīlauea → *"Hawaiʻi County, Hawaii"* (graceful rural fallback, no neighbourhood);
  Georgia → *"Jackson County, Georgia."* Reaffirms the standing principle: **the coordinates are the
  authoritative locality; the reverse-geocoded name is a human-readable convenience/redundancy** — so an
  imperfect urban admin label is a cosmetic issue, not a data-integrity one. (One line for the document:
  derived place names are reliable at the coarse and fine levels but soft in the middle, in cities.)
- **Decoder settled.** Kim confirmed **ZBar is not on CRAN**, so the all-R route via a system binding is
  out. Decision: keep **reticulate + pyzbar (+ OpenCV), unioned** — the reticulate route is the packaging
  choice for the decode step. (exiftool for EXIF is already a system exe Kim has; everything else is R.)

### Motivation & appendix — leaving complete data in the host country (Kim, 2026-07-02)
The project's **founding purpose**, and material for an appendix (likely threading into the opening too).

In joint international field projects, a complete copy of the primary data — **including a set of voucher
specimens** — should remain in the **host country**, ready for curation. But vouchers only reach a local
herbarium curation-ready if they arrive with **proper labels**. The common failure is *"I'll send the
labels once I'm home and have transcribed the data"* — inadequate and wrong; too often the data comes late
or never. The honest alternative — **stay in-country until the labels are finished** — is expensive and
often infeasible.

Kim named the deeper pattern without euphemism: such studies have frequently been **colonial**, resting on
a **power and technology mismatch** between local hosts and foreign visitors. *Seeing this happen was the
original idea for the project* — a long-held wish to **level the playing field**. Two things now make that
possible: (1) everyone holds the **same capture technology** — a cell phone (no expensive altimeter /
instrument kit that not everyone can afford — cf. the 1970s-kit and stockroom-access frictions); and (2)
thanks to **open-access information** (GBIF / Darwin Core, plus the free, keyless derive sources — AWS
elevation, Macrostrat, SSURGO, OSM/Nominatim), **all collaborators have the same metadata**, not gated by
who can pay for an API.

How the architecture *operationalizes* the ethic:
- The label **and** field log are produced **on site, before anyone leaves** — so a complete,
  curation-ready copy of the primary data stays in the host herbarium **by default**. The friction the
  system removes (transcription + attention) is exactly the friction behind "I'll send it later"; remove
  it and the deferral has no excuse.
- The deliberate **free / open / keyless data stack** (our avoidance of paid Google APIs) is not merely
  convenience — it is the **equity commitment in technical form**: the host team runs the identical
  derive with no cost barrier.
- The **deck-discovery method** lets a local community derive *its own* discipline's decks from the shared
  record — so **expertise is shared, not just tools**.

This is the project's *purpose-found-after-capability* moment (cf. the PKM meta-observations): the
capability — capture + derive + assemble, on a phone, from open data — now reveals what it was **for**. In
Kim's words, if it works, it is a **small payback to his overseas collaborators**.

## The introduction's frame — friction is the thread, system thinking is the key (2026-07-02)

Worked out the document's opening logic (this becomes the Introduction, with the field-capture system as
Ch. 2 and QR pushed much farther back).

**Two problems open the document, joined by one thread.** They are *not* the same problem: the **lost field
log** (labels delayed for months or years, the field log discarded — the mechanism-level failure) and
**data inequity** (a complete, labeled copy of the primary data not staying with the host country — the
stakes). What binds them is **friction**: the lost log is friction between the field and the herbarium;
inequity is friction between collaborators who don't share the same tools or metadata. Same enemy, two
faces — so the introduction carries both without having to choose which leads.

**The thesis line: the solution isn't technology — it's a system.** This pre-empts the "why QR?" reflex
(reader sees a QR code, thinks *tech gimmick, scan-a-link*): we tell them up front not to look for a gadget.
And the sharper correction (Kim, 2026-07-02): **QR isn't even the "key" — it's just a good mechanism. The
key is *system thinking*.** If the solution is a system, the key cannot be any single component; it has to
be the mode of thought that *produces* the system. So the introduction names **system thinking** as the
key, QR is never crowned, and the QR reveal is deferred until the decks create a genuine need for it.

**What the document is really about.** On the surface, specimen capture. Underneath, a worked demonstration
of **system thinking**, with specimen labels as the vehicle (cf. the "an example teaches its domain, not
just the tool" principle — here the domain taught is a *way of thinking*). Every pillar is the same systems
move in a different costume, and none of them is about QR:
- **capture once, project two views** = a single source of truth (label and log can't disagree — one record);
- **derive, don't card** = don't capture what you can compute (separate observed from derivable);
- **discover the decks** = let the system's own accumulated data reveal its structure;
- **printed value + QR + EXIF** = graceful degradation designed in.

**The mechanisms are a *set*, each matched to a friction (Kim, 2026-07-02).** Not one hero technology — a
small set, each dissolving a *particular* kind of friction, and it is the **arrangement** that makes a
system:
- **Camera (the photograph)** → the friction of *making a record at all*: the photo *is* the record,
  captured passively.
- **GPS** → *georeferencing* friction: location with no instrument to read and no coordinate to write.
- **QR code** → *transcription* friction: a chosen category captured without handwriting.
- **API / open data** → *attention + equipment* friction: the fixed, derivable variables (terrain,
  substrate, place) never have to be noticed in the field or carried as instruments — they are computed
  later from the coordinate.
- **The cell phone = the integrator** → *reconciliation* friction: camera, GPS, and clock fire in **one
  act**, so everything binds into a single record with nothing to stitch together afterward. The phone is
  the physical embodiment of the systems key — integration made hardware.

The **API line is the hinge**: it is simultaneously the **derive** pillar (compute what you'd otherwise
measure) and the **data-equity** lever (open + keyless → every collaborator has the same metadata). One
mechanism, both payoffs.

**Historical rhyme (for Ch. 2).** The **1970s field kit was the *disintegrated* version of exactly this** —
altimeter, clinometer, compass, map, notebook, each a separate instrument with its own friction, and the
human forced to be the integrator, reconciling them all by hand. The phone collapses that whole kit into
one act. The kit is the "before"; the phone is the "after." (Connects to the 1970s-kit anecdote above,
which now pays off twice — motivating decks *and* the integrator idea.)

### Anecdote — the write-in-the-rain notebook (Kim, 2026-07-02)
The friction point that has bothered Kim most, in the flesh: the **write-in-the-rain notebook** with
**broken pencils**, a **knife to sharpen them**, and **handwriting made illegible because you hold the book
in one hand and write on the unsupported page**. Even the "field-proof" notebook doesn't remove the
friction — it just relocates it to the pencil, the sharpening, the unsupported hand, and the smeared,
unreadable result read back later. The camera retires this whole cluster at once: no writing surface, no
pencil, no legibility problem — you photograph, you don't write.

### Alternatives people have tried — and why they fall short (2026-07-02)
A passage for the document: others have attacked field-note friction, and their fixes *help* — but each
addresses only **one point** on the friction span, not the whole of it.
- **Dictate the notes** (voice memo): removes the *writing* friction, but transcription friction survives
  (merely deferred to audio), and it captures nothing structured — no controlled vocabulary, no binding to
  location or time.
- **A phone app with drop-down menus**: adds structure and a controlled vocabulary (genuinely good —
  recognition over recall, the same virtue as the decks), but it puts you **heads-down in a screen** in the
  field (attention friction), fumbling a touchscreen with cold wet hands (a *new* handling friction), and
  it still touches neither the derive side nor the reconciliation-into-one-record problem.

**The systems point:** each alternative is a **point-fix**; none covers the **span**. Our system is not a
better point-fix — it is an *arrangement* that removes transcription, attention, georeferencing, equipment,
*and* reconciliation friction together, because it was designed at the level of the whole field-to-herbarium
flow rather than at one step in it. That is what "system thinking, not technology" means, made concrete —
and it is the clean argument against every single-tool alternative.

## The deep tradition and the expanding role of the specimen (2026-07-02)

Material for the Introduction / early stakes — the *why it matters*, in both directions of time. (QR stays
out of the introduction, pushed back to where the decks create a need for it — reconfirmed.)

**Backward — we crowdsource into an old and important tradition.** Collecting, pressing, and labeling plants
traces to the **origins of botanical science — one of the first sciences**, born alongside medicine. The
herbarium sheet and the field notebook are among that science's oldest instruments, and the practice has
been a **crowd-sourced enterprise for centuries**: countless collectors, and the herbaria that keep the
sheets — sometimes for hundreds of years. A record we make today **joins that lineage.** (Extends the
crowd-source framing already banked under the deck-discovery section. *Verify when drafting:* earliest
herbaria — Luca Ghini, ~1540s; the Linnaean standardization of naming; a defensible "centuries"/"~500 years"
figure.)

**Forward — the record may outlive us and answer questions we can't yet imagine.** A specimen collected now
might last **hundreds of years** and be read for a purpose no one today has conceived. Not speculation: old
sheets gathered merely to fix identity are now mined for things their collectors never recorded on purpose —
DNA, historical phenology, pollution and heavy-metal baselines, climate signals. The lesson runs one way:
**capture context richly now, because you cannot know what future science will ask of it.** This is the
deepest justification for the whole system — not convenience but **future-proofing an irreplaceable
record** — and it ties straight to the *retroactive-enrichment* note above (old sheets gain value backward
the moment a coordinate meets modern layers). (*Verify when drafting:* concrete documented "unimagined use"
cases — herbarium phenology vs climate; heavy-metal/pollution records in specimens; herbarium DNA.)

**The expanding role of plants — from resource to indicator.** Early labels were **sparse** because the job
was **identification**: what is it, who found it, roughly where. Plants were valued as **medicine, food,
building materials**, and the label served that. Today the role has **widened**: plants are **indicators** —
of climate, certainly, but also of pollution, land-use change, disturbance, and more. An indicator's value
lives in its **context** — *when* it flowered, *what* the site was, *how* the population stood — exactly the
data the identification era discarded and the lost field log still throws away. So the modern role *demands*
the richer, contextual capture this system is built to preserve: **the historical arc is itself an argument
for the project.**

**The division of epistemic labor (Kim's line): the voucher label is where data first land; the field notes
are the context.** The **label** is the primary datum — structured, bound to the specimen, the first place a
fact is recorded. The **field notes / log** are the **context** that make the datum interpretable and
re-usable for purposes not yet imagined. This is why the two products are genuinely **co-equal**: the label
anchors, the notes interpret; strip the notes and a future indicator-question has nothing to stand on. It
also re-reads the derive-vs-observe partition — much of that context (site, terrain, substrate, climate) can
now be **derived and attached automatically**, so the field log becomes richer than any handwritten notebook
ever was.

### The personal anchor — standing in Linnaeus' room (Kim, 2026-07-02)
First-person material, captured before it cools; likely the document's emotional spine and its circle-closer.
Kim traveled **half a globe deliberately to stand in this room** — not an accidental stop on a tour, but the
reason for the trip. He had to pause and collect his breath. His words: *"The room retains the energy of the
historical change that occurred here… This is why I came. I was not disappointed. You stand there and ask
yourself, how can I properly respect what was done here?"*

That question — **how do you properly respect what was done here?** — is the document's true stake, and the
whole document is its answer. The answer we've been building without naming it: you don't respect a
systematizer by admiring him; you respect him by **continuing the work in its own spirit** — carrying the
same habit of mind (system thinking) into the tools of our own moment, and removing the friction that would
let the tradition keep losing its record. **The reverence and the engineering are one gesture.** The
pilgrimage and the package are the same act.

For the structure: this is the seasonality "whale-call" equivalent — a strong first-person anchor that
should **open** the document (Kim in the room, the question) and **return transformed at the close** (the
system is the form the respect takes). Complete-the-circle. Possibly first-person for the opening beat, to be
decided with Kim.

### The photograph is of the CARDS, not the specimen (Kim, 2026-07-02) — a real simplification
Surfaced while drafting Chapter 3. Earlier phrasing (including the old spine one-liner) said "photograph the
cards **with the specimen**." **Correction: the specimen is never in the frame.** By the time you record, the
plant is already **bagged**. You photograph a **small set of cards laid out somewhere flat and well lit**;
one of them is the **collection-number card**, and that number is the **stand-in for the specimen** (the ID
tag from the Ch. 2 "three things"). It is all the link the photograph needs.

Why this is better, not just simpler:
- **Removes the framing friction** — no wrestling a wet, drippy, sticky, pokey specimen into the shot; hands
  are free; you arrange dry cards on any flat surface.
- **Improves decode reliability** — the fragile step is decoding (the union pyzbar+OpenCV work; no single
  decoder got >3/4 on the real busy-background photo). Cards **flat and well lit read cleanly**; codes
  propped against a specimen do not.
- **Matches what we actually tested** — the real-photo end-to-end demo (2026-07-02 cont. 4) was **four cards
  on a table, no plant**. The system already worked this way; we just hadn't stated it.

Corrected the one-liner here and the "photograph the specimen with cards" phrasing in `proj_specimen_labels.md`
(Objective) and `project_index.md` (Active Focus). Any remaining older narrative descriptions of "photograph
the specimen together with the cards" are superseded by this note.

### What you carry home, and cheap redundant capture (Kim, 2026-07-02)
Two notes.

- **The return state (good Ch. 4 bridge material).** Coming back from the field you hold **two matched
  collections**: a set of **pressed specimens, each with its unique numbered tag**, and on the phone a set of
  **photographs, one per tagged specimen**. The **collection number is the join** between them, so every
  specimen has its picture and every picture knows its specimen. The reading then happens at the desk, dry and
  unhurried, in the good conditions the field never offers.
- **Cheap redundant capture (backup) — "someplace, not really here" (Kim).** Because the photograph *is* the
  record and costs nothing to repeat, the capture is **trivially made redundant**: have **several people
  photograph the laid-out cards independently, on different phones**. Independent copies on independent
  devices are a clean backup against a lost phone, a bad frame, or a code that didn't decode in one shot.
  Placement: **not Chapter 4** (Kim) — fits the **graceful-degradation / robustness** material (with the
  decks' handling design, or in "Limits and the Frontier").

### The label is data first (Darwin Core); two new chapters (Kim, 2026-07-02)
From the Chapter 8 discussion. Two structural decisions.

**The label is data, not a printed artifact (accuracy fix).** A well-established herbarium prints its own
labels (archival acid-free stock, its own format); what it wants is the **data as a file, in Darwin Core
headers**, not a finished label. So the "label" projection is really the specimen's **Darwin Core record**;
printing is downstream and optional. A **provisional printed label** is the fallback rendering, valuable
exactly where a herbarium can't print its own (a regional school, an under-resourced herbarium in a
developing country) — so the bifurcation carries the **equity** theme in the plumbing. It also makes the two
products symmetric (both Darwin Core data views of one record) and closes a loop: **the schema we mine in
"Discovering the Decks" is the schema we emit.** Applied as a light touch to Ch. 4 and Ch. 8; full treatment
in the new Workflow chapter.

**Two new chapters (Kim).**
- **"The Workflow"** — placed **after "Purpose."** The practical adopt-it arc: print your decks
  (`make_qr_cards`), the field routine, then photos-into-a-folder → batch process → a **Darwin Core file** +
  optional **provisional labels**. The user-guide portion; home for the runnable deck-printing and batch code.
- **A short fragility chapter near the end** (working title **"How It Holds Up"**) — answers the conservative
  reader's worry that the system is fragile because a QR code can fail to scan. The graceful-degradation
  floor: a card that won't decode still **reads as printed text in the photo**; **two people photograph the
  cards** (redundancy); **chimp it** (check the shot in the field); **drop a set of cards, carry two**. Ties
  back to **friction**: watching fewer things means the few you watch work better. (Absorbs the multi-phone
  redundancy note parked earlier, and the graceful-degradation beat moved out of Ch. 8.)

**Revised chapter order:** Intro · 2 Field-Capture System · 3 Mechanisms · 4 Capture Once · 5 Decks · 6 Derive
· 7 Discovering · 8 Closing the Loop · 9 Purpose · 10 The Workflow · 11 How It Holds Up (fragility) · 12 Limits
& the Frontier · Appendix. (Fragility-vs-Limits order still to confirm with Kim.)

### The Field Log becomes the CLOSING CHALLENGE chapter (Kim, 2026-07-02)
Refines the field-log-as-context note above. Decisions:

- **Placement: the END.** The **label is security** — non-negotiable, must be right, and now automatic. The
  **field log is the new thing** — with the phone + open data + the derive tools we now hold context field
  botanists never had ("we literally have data that weren't previously available"). So the Field Log is the
  book's **finale**, and it **folds in the former "Limits and the Frontier"** (it *is* the frontier; honest
  limits like the canopy ceiling are already spoken where they arise). Tail order now: Purpose · The Workflow
  · How It Holds Up · **The Field Log** · Appendix.
- **The circle closes.** The Introduction opens on the field log as a thing that goes *missing* (a recent
  problem); the book ends on the field log *reborn* as the frontier. The lost artifact becomes the most
  promising one. (Kim's treasured complete-the-circle move.)
- **Stance: a challenge, not a prescription.** "How should a contemporary field botanist build a field log?"
  A generative invitation (fits path-not-destination + the voyage close). "We've just been handed the tools.
  What should we do with them?" — the last line's spirit.
- **Aim:** a **digital record kept adjacent to the specimens** that lets us and **future researchers
  visualize what was done** (ties to the intro's records-outlive-us / indicator theme).
- **Ideas (suggestive, not exhaustive — start with what we have):**
  - collections plotted on the derived **hillshade**; **scale** from local terrain out to familiar features;
  - **where you sampled and where you did NOT** — absence as information ("they didn't sample that valley,
    that's why the species wasn't found"); sampling coverage/effort is data herbaria rarely capture well;
  - **specimen scans just before closing the plant press** — a visual record that also **backs up a dropped
    tag** (reinforces the fragility/redundancy chapter);
  - **★ a physiognomic description of the forest**, read *blind* from the canopy raster (height class,
    closure/cover, vertical heterogeneity, gappiness) — **derived, collection-spanning, no species needed**;
    the structural half of a habitat description (Kim, 2026-07-02: "that description blew me away. Really.");
  - **biome** (whittakerr); **seasonality cues + the past year's weather** (seasonalityr); the collection
    **ordered in time**.
- **Ecosystem convergence:** the Field Log is where site_extract (terrain/hillshade), whittakerr (biome), and
  seasonalityr (seasonality) all pay off in one place; the most visual chapter (Master Themes 4 & 12).
- **Two products, refined roles:** label = the secured floor; field log = the expanding frontier. Both from
  one record; different jobs in the argument.

### Illustration convention — "caption as door" (Kim, 2026-07-03)
Figures in the document are explained **only in their caption**, and the caption is written to **state the
result AND name how it was obtained** (a method-pointer), so each illustration **motivates the reader to hunt
down the methodology** rather than spelling it out in the body. The body prose stays suggestive; the captions
carry the pointers. This fits the whole book's **path-not-destination** stance and the finale's "each is a
door." Applies across all the figures (hillshade-with-collections, `discover_decks` heatmap, the derived site,
the canopy physiognomy). **Canonical example — the canopy physiognomy figure:** a canopy/satellite image; the
caption gives the physiognomic reading (height class, closure, vertical structure) and notes it was obtained
**by putting the image to an AI vision model**, the coordinate pair that fetched the image having come from one
field photograph. (Consider promoting this to `style_multichapter_doc.md` §6 as a general figure convention.)


## The system proved in the hand — and where the real difficulty lies (Kim, 2026-07-28)

The first working decks were assembled, handled, and photographed on 2026-07-28. Kim's assessment
after using them, recorded in his own words because it is the design argument for the whole
approach:

> "Now that we have real decks, and I've been handling them, I'm impressed with how well they
> work. They are compact. They take little room. Having the categories makes decisions quick.
> There are ways to 'weather proof' the cards in the deck, but that's beyond our concerns. The
> point is that a printer with a few sheets of Avery Business Cards paper, an inexpensive paper
> punch, some inexpensive screw posts and a few plastic report covers provides a robust system to
> simplify the recording of information associated with the specimen collection.
>
> The more difficult part, perhaps, is the planning. What are the categories that need to be used?
> What do the cards say for each category? This is not a prescriptive system. Choose the content
> for the purpose of the collection."

**Three claims worth separating, because they are the spine of the deck chapter.**

**1. The bill of materials is the argument.** Printer, Avery business-card stock, a paper punch,
screw posts, plastic report covers. Nothing bespoke, nothing that needs a supplier, nothing that
breaks in a way a field botanist cannot fix. This is the FRICTION thesis made concrete at the
level of procurement: a method that requires an instrument will be adopted by the people who can
buy the instrument, and a method assembled from stationery can be adopted by anyone who reads the
paper. It is also why the *format* had to be right — the whole system rests on a sheet of stock
that any office printer can feed.

**2. "Having the categories makes decisions quick" is the observation-side payoff, and it is not
the same claim as "no transcription."** The no-transcription argument is about what happens AFTER
the field. This is about what happens IN it: a controlled vocabulary laid out physically turns an
open question ("what should I write about the phenology?") into a closed one ("which of these four
cards applies?"). Recognition is faster than recall and far faster than composition, and it happens
at the moment when time and conditions are worst. The decks reduce field friction and lab friction
by two different mechanisms, and the document should not blur them.

**3. The hard part is the deck design, not the machinery — and it is deliberately not
prescriptive.** The code is finished in a way the vocabularies never will be. Which categories a
collection needs, and what each card says, is a function of the collection's PURPOSE, so the
system cannot ship a canonical deck without becoming a different and worse thing: a standard that
tells a systematist and an ecologist to record the same variables. "Choose the content for the
purpose of the collection" is the design rule.

**What this does NOT mean: that the user is left with a blank page.** The empirical work already
in this project is exactly the answer to "how would I know what to put on the cards?" — the
deck-discovery methodology (2026-07-01), the collector-signature analysis, the derive-vs-observe
partition. Those do not prescribe a deck; they show a collector how to DERIVE one from what
collectors in their own discipline actually record. The honest framing is: the system is not
prescriptive about content, and it is not silent about method either. That distinction is the
chapter.

**Deliberately out of scope: weatherproofing.** Kim: "There are ways to 'weather proof' the cards
in the deck, but that's beyond our concerns." Lamination, synthetic stock and waterproof papers all
exist; naming the problem and leaving it to the reader keeps the bill of materials at the
stationery level, which is the point of claim 1.

**Also settled 2026-07-28: "Determined by" is a FIRST-CLASS field, not an observation.** An
observation card records what the collector SAW; a determination records WHO ASSERTED the
identification. Herbarium practice keeps them apart because a determination carries an authority
and can be revised by a later worker without disturbing anything observed in the field.
`assemble_record()` now promotes it alongside collection number and collector, and the label
carries a `Det.:` line. (Found by running the assembler on a real photo — see the 2026-07-28 log.)


## ★ DOCUMENTATION DIRECTIVE — "you do not start from a blank slate" must be a BOOK-level claim (Kim, 2026-07-28)

Kim: *"You are right about not needing to start with a blank slate when establishing categories and
values. That's been an important discovery in this project and it needs to be emphasized in the
documentation."*

**First, what is ALREADY written — checked before assuming a gap.** The argument exists and is well
made:

- `decks.qmd` closes by withholding the decks *on purpose*, and names the reason: "There isn't one
  right set… Handing you my decks would be handing you a destination. The path is worth more: a way
  to find the decks your own work needs. That way exists, and it reads its answer out of the
  accumulated record of your field, but it belongs to a later chapter."
- `discovering-decks.qmd` opens by delivering it: "the decks a field needs are already written in"
  the record — then gives the procedure (pull records for a group in a region over recent decades,
  reduce to fill-signatures, cluster, and read the groups as disciplines exposed by their habits).
- The facet/value-set distinction in `decks.qmd` already does related work: *you inherit the
  questions, you write the answers for where you work.*

**So the gap is NOT a missing argument. It is EMPHASIS and PLACEMENT.** Three specific problems:

1. **It is a chapter payoff, not a book claim.** A reader who skims, or who stops early, comes away
   with "this system won't tell me what to record" and never reaches the answer. The
   non-prescriptive stance is stated in chapter 5; the reassurance lands in chapter 7.
2. **Two chapters separate the promise from the delivery.** Book order is decks → **derive** →
   discovering-decks. The promise is made in the final paragraph of `decks.qmd`, and the reader then
   passes through the whole derive chapter before it is honoured. That is the longest possible gap
   between an anxiety and its resolution.
3. **The idea has no name.** Named ideas travel; unnamed ones get paraphrased away. "Capture once,
   project two views" and "caption as door" already carry their own weight in this project. This one
   does not have a handle yet.

**What to do in the production pass (not yet done):**

- **Surface it in `index.qmd`** as one of the book's headline claims, beside no-transcription and the
  co-equal field log. One or two sentences: the system is not prescriptive about *content*, and it is
  not silent about *method* — the decks a discipline needs can be read out of what its collectors
  have already recorded.
- **Give it a name and use the name in both chapters** so the promise in `decks.qmd` and the delivery
  in `discovering-decks.qmd` are visibly the same object. Candidates: *"the decks are already
  written"*; *"inherit the questions, write the answers"* (already half-present as the facet/value
  distinction); *"a path, not a destination"* (Kim's own framing in `decks.qmd`).
- **Consider tightening the gap.** Either move `derive.qmd` before `decks.qmd`, or add a forward
  pointer strong enough to carry the reader across it. Deferring is a legitimate structural choice —
  the point is that the deferral must not read as evasion.
- **Frame it as a DISCOVERY, which is what Kim calls it.** It was not obvious at the start of this
  project that "what should the cards say?" had a non-arbitrary answer. That it does — and that the
  answer is empirical, recoverable from two centuries of accumulated sheets — is a genuine finding of
  the work, not a design convenience. The document should say so plainly.

**Why this matters beyond tidiness.** The non-prescriptive stance is the system's greatest strength
and its greatest adoption risk. A collector told "choose the content for the purpose of the
collection" and nothing more has been handed a design problem they did not ask for, at exactly the
moment they were deciding whether to try the method at all. The deck-discovery methodology is the
answer to that objection, and an answer that arrives two chapters late does not answer it.

## The documentation reconciliation — what the decks in hand say that the chapters did not (2026-07-29)

The printing upgrade was folded into `vouchr` on 07-28; this is the pass that made the written
description agree with the object. Four things were found, and only one of them was the drift we
went looking for.

### 1. The clearance figure in the record measured the wrong thing

`One_deck.jpg` was measured directly, scaling off the card's known 3.5 x 2.0in edges (621.6 px/in,
consistent on both axes to 0.2 %). The layout is right where the layout was checked:

| Quantity | Predicted | Measured on the photograph |
|---|---|---|
| QR right edge, from card's left edge | 3.008in | **3.013in** |
| QR left edge, from card's left edge | 1.872in | **1.930in** |
| Cover's occluding edge | assumed 1.5in (`bind_left`) | **1.804in** |
| Clearance, QR left edge to cover | 0.372in (claimed) | **0.127in** |
| Punched hole, from card's left edge | 0.375in (`punch_x`) | **0.788in** |
| Punched hole, from card's top edge | 1.000in | **1.016in** |

**The 0.372in figure was never clearance against the cover. It was clearance against the 1.5in
assumption**, and the cover overran that assumption by 0.30in. The real margin in the hand is
about an eighth of an inch. The deck decodes — `Phenology: No Flowers` came straight out of this
frame — so nothing is broken, but the recorded safety margin was three times the actual one, and
that is the kind of number that gets quoted later as if it had been measured. It is now corrected
in `make_qr_cards.R` and stated honestly in `decks.qmd`.

The hole is 0.41in further in than `punch_x` draws it, which is what a hand punch does and is
probably the whole explanation for the overrun: the pivot moved right, so the cover's reach moved
right with it. `punch_x` only drives the guide sheet, so the mismatch is cosmetic in the code and
misleading on paper — the guide will not show a collector where their own punch lands.

**Decision (Kim, 2026-07-29): correct the record, leave the code.** The cards print and read;
widening `bind_left` costs QR size. If a deck ever fails to decode with the stack fanned, `bind_left`
is the first number to raise. ★ **The rule this adds to Finding 020's family: a verified number must
name what it was measured AGAINST.** "0.372in of clearance" and "0.127in of clearance" are both true
of the same deck, and only one of them is about the object.

### 2. The built kit has a FOURTH card kind — attribution

Example_1.jpg carries six decoded cards, and two of them fit none of the three kinds `decks.qmd`
named. `Collected by: KW Bridges, YH Lau` (teal) and `Determined by: KW Bridges` (purple) are built
as bound screw-post decks with coloured covers, exactly like the observation decks — but a collector
and a determiner are not observations, not the collection number, and not free text. The 07-28
decision that `Determined by` is FIRST-CLASS already implied this; the physical kit made it
unavoidable.

**Adopted: four kinds — identity, attribution, observation, comment.** Attribution cards have their
own handling signature, which is why they earn the separation rather than being filed under identity:
**their value does not change from plant to plant.** You set them once in the morning and photograph
the same card beside every specimen all day. Identity changes per specimen, observation changes per
specimen, attribution changes per trip. Written into `decks.qmd`.

### 3. The printed decks are NOT the decks in `decks/`

The kit Kim printed, carried and photographed came from **`QR_field_notes.csv`** (rendered to
`QR_field_notes_cards.pdf` at 16:56 HST on 07-28), not from the three files in `decks/`. Confirmed by
artifact chain, not inference: every payload decoded out of Example_1 appears in that CSV, including
the two labels — `Abundant Flowers`, `Scattered Flowers` — that broke the narrowed clear zone and
forced the auto-shrink fix.

So the project has been carrying **two phenology decks that disagree**:

- `QR_field_notes.csv` (printed, photographed): Abundant Flowers / Scattered Flowers / No Flowers
- `decks/deck_universal.csv` (deck-discovery output, never printed): Vegetative / Bud / Flower / Fruit / Fl+Fr

and `decks/` has **no Abundance deck at all**, though the kit has one (Dominant / Common / Occasional / Rare).

**Decision (Kim, 2026-07-29): the printed set is canonical** for the book's prose and figures, so the
figures agree with the photographs. `decks/deck_universal.csv` phenology rows were replaced to match.
★ **Recorded because the change overwrote a discovery output:** the five superseded phenophase values
are listed above verbatim and are recoverable from Drive revision history (Finding 019 — do not quietly
rewrite a record). **Still open:** whether `decks/` should carry the Abundance deck, and more generally
whether the discovery outputs and the working printed deck should be one file or two clearly-labelled
ones. They are currently two files with no label saying which is which, which is how this drift lasted
a month.

### 4. The cover colour scheme was one-sixth documented

The kit runs five coded covers — **yellow phenology, grey abundance, pink life form, teal collectors,
purple determination**. Only yellow had ever been written down, in a project whose own argument is that
you find the deck by colour before you read a word. All five are now recorded here and named in
`decks.qmd` **as one collector's choices, not a standard**, which is the non-prescriptive stance applied
to the hardware.

**Unresolved, flagged not guessed:** `decks.qmd` said "a colored cover top and bottom." In `One_deck.jpg`
the second cover reads white, and the photographs cannot settle whether the backing is coloured, plain,
or clear. The chapter now says "under a stiff colored cover" and claims nothing about the back. Kim to
confirm what the decks actually carry.

### What the binding finding became in the book

Written into `decks.qmd` as a design finding rather than a repair, with `One_deck.jpg` as its figure
under the caption-as-door convention (the caption states the two clearances AND that both were measured
off the photograph, and that the same frame decodes). The argument: **a layout drawn for an object in
isolation can be exactly correct and still fail the moment the object is used, because use adds
constraints the drawing never saw.** The binding was invisible in the design file and decisive in the
hand — an argument for building a rough deck early instead of perfecting one on screen. `the-workflow.qmd`
gained the practical consequence: punch every card of a deck in the same place, stay inside the reserved
band, and assemble-and-photograph one deck before punching the rest.

## Kim's answers to the reconciliation questions — and a failure mode nobody had named (2026-07-29)

### The cover construction: the ORIGINAL claim was right, and there is more to it

Kim: *"All the decks have the same plastic cover on the front and back. I have inserted a blank card at
the start and end of each deck to offer both protection and to block seeing a QR code when the cover
materials are not completely opaque."*

So `decks.qmd`'s "a colored cover top and bottom" was accurate, and softening it was the wrong call. The
white surface measured in `One_deck.jpg` was the **blank end card**, not a white backing cover. Restored,
and stated more fully than before: **two matching coloured covers, front and back, with a blank card just
inside each.**

★ **The blank card is not padding — it closes a failure mode the whole document had missed.** Every
robustness argument in the book so far is about **losing** a reading: a code that won't scan, a dropped
deck, a dead phone, and the answer is always redundancy plus a graceful-degradation floor. The
show-through case is the **opposite** failure — **gaining a reading that was never chosen.** A code
belonging to the card beneath, read faintly through a cover that isn't fully opaque, decodes into the
record as though the collector had laid that card down.

**And it is the worse failure of the two, for a structural reason worth keeping:** redundancy cannot
help. Redundancy recovers what was lost; it does nothing about what was never true. A lost reading
announces itself (a blank field, a card you can still read with your eyes); a false reading is
indistinguishable from a real one downstream. **This is Finding 020's shape again in a third place** — a
pipeline that cannot tell a real artifact from a plausible-looking one. First it was a stubbed QR engine,
then a clearance figure measured against the wrong reference, now a code that decodes correctly and means
nothing.

**Kim's fix is the right kind: designed out, not detected.** The blank card makes the false reading
impossible rather than making it findable afterward. Cheaper than any validator, and it needs no
discipline in the field. Written into `decks.qmd` (the deck's physical form) and into `on-fragility.qmd`,
which had treated only the lost-reading direction and is stronger for naming both.

### The determination card does two jobs, not one

Kim: *"Doing this is not only assigning responsibility, but also simplifying data entry later."*

The 07-28 decision established the determination as a first-class field on an **epistemic** argument (an
observation is what the collector saw; a determination is who asserted the identification). Kim adds the
**operational** half: photographing it assigns the responsibility *while the collection is being made*
rather than leaving it to be remembered, **and** the field arrives already filled, so nobody types the
same determiner a hundred times at assembly. Both reasons now in `decks.qmd`. Worth noting the pattern:
this is the same double payoff as "having the categories makes decisions quick" (field-side) versus
no-transcription (lab-side) — the system's moves tend to pay twice, and the document should keep saying
which payoff is which rather than blurring them.

### ★ THE TITLE IS SETTLED: **"Voucher Labels"** (Kim, 2026-07-29)

Closes **Open Question #1 (naming)**, whose last unresolved part had been deferred to the read-through.
Kim's reasoning: *"It is properly descriptive and it spans the vouchr package and the label writeup."*
That span is the point — the project has always had two halves with two names (`vouchr` the package,
`specimen_labels` the folder and PKM record), and the title is the thing that has to cover both. Set in
`_quarto.yml`, replacing the `vouchr` placeholder. **The cover art files were already named `voucher_*`**,
which now reads as deliberate rather than as the filename mismatch it looked like this morning; no rename
needed. And because the art carries no baked-in title, nothing has to be reshot — the AI_Microscope
coupling that this session was watching for never applied.

Naming state, complete: package `vouchr` · folder / PKM `specimen_labels` · book **Voucher Labels**.

### The Abundance mismatch: keep it, but LABEL the files

Kim: *"I'm not sure how to handle the 'abundance' deck. Perhaps a slight mismatch is OK?"*

**It is more than OK — the mismatch is the book's own thesis in the filesystem.** `decks/*.csv` are what
`discover_decks()` returned for a corpus; `QR_field_notes.csv` is one collector's working kit. The book
argues at length that these are *supposed* to differ: facets travel, value-sets are local, the method
hands back your community's answer and not mine. Forcing the two into agreement would quietly contradict
the argument, and it would also destroy a discovery output to make a working deck look canonical.

**So the defect was never the mismatch. It was that nothing said which file was which** — two sets of
deck CSVs sitting in one project with no provenance marker, which is exactly how the phenology drift
survived a month unnoticed. The cheap, correct fix is a provenance note in `decks/`, not a reconciliation
of contents.

★ **This also reverses part of this morning's decision, and the reversal is recorded rather than quietly
applied.** The earlier call replaced `deck_universal.csv`'s five phenophase values (Vegetative / Budding /
Flowering / Fruiting / Flowering & fruiting) with the printed three, on the reasoning that the printed set
is canonical. The *book* half of that still holds — prose and figures use the printed vocabulary so they
match the photographs. The *file* half does not: a discovery output should keep what the method returned.
**RESTORED (Kim confirmed, 2026-07-29).** `deck_universal.csv` carries the five phenophase values again.
`decks/README.md` now states the provenance of every file in that folder, names the two expected
differences from the printed kit (phenology vocabulary, and the presence of an abundance deck), and sets
the rule for any future deck files: **do not reconcile the contents, keep the provenance legible.** The
net of the two decisions is the right split — the **book** uses the printed vocabulary so prose and
figures match the photographs, and the **files** each keep what they actually are.

★ **Worth keeping as a process note.** This morning's decision was made from a menu that bundled "the book
uses the printed set" together with "so correct the CSV," and the second half did not follow from the
first. The tell was that applying it required overwriting a discovery output and recording the loss — when
carrying out a decision obliges you to preserve what it destroys, the decision is probably two decisions
wearing one label.

## Open / next
- **★ Most likely next task — collector-signature decks (Kim, 2026-06-30).** The herbarium notes'
  messiness is **structured by collector, not random** — a few Hawaiian *Metrosideros* collectors
  account for the rich environmental notes, and taxonomist vs ecologist signatures separate even when
  anonymized (already visible in our 182: ecological "ōhiʻa dieback / soil / community" vs taxonomic
  "Race C; pubescent/glabrous, stamen colour, height" vs NEON/NZ protocol templates vs terse
  locality-only). **Move:** group real records by `recordedBy` (+ location), compute each collector's
  field fill-signature, then cluster — the clusters are the **deck archetypes** (the empirical answer to
  "how many decks / what's on each"). **Sample window: last ~40 years** (eventDate ≥ ~1985) to catch
  ecological studies and not be swamped by older taxonomic collecting. Rides on the full-scale `rgbif`
  pull. Confounds (era / institution / taxon) are partly isolated by sorting within location + the date
  window. *Noted but out of scope now:* **date as its own axis** — how the recorded data-types have
  transitioned through the decades.
- **Target-species deck** (an identity deck): fits the existing CSV; `copies` already
  handles collecting the same species several times on a trip.
- **Reader / assembler:** scan a photo → decode every card + read EXIF → emit a label row
  and a log row ("capture once, project two views").
- ~~Precise **Avery-5371** alignment for the maker.~~ **DONE 2026-07-28** (true card geometry,
  binding-clearance band, printer-offset knob; decks + number cards printed and verified).
- **Deck-content survey** of herbarium practice + literature (Track B) to ground/legitimize
  the vocabularies.
