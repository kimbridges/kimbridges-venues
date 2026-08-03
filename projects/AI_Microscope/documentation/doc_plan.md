# Preview & Review — document plan
_Working title: **Preview & Review**_
_Subtitle (draft): Rebuilding a 1989 learning environment with the tools it was waiting for_
_Status: outline approved 2026-07-22 · drafting next session_

## What this is
The document for the **AI Microscope** reconstruction (proj_AI_Microscope.md).
Same style as the checklistr book: a **multichapter Quarto book**, conceptual-
dominant, **first-person**, human-anchored, **jointly bylined** (K. W. Bridges and
Claude, Anthropic), deployed to **kimbridges-documents**. Not a user manual — the
account of an *exploration of the process*.

Title rationale: "Preview & Review" names the tool's role (alongside the lab, not
instead of it) and avoids the replacement reading the 1989 paper likely invited.

## Spine / thesis
- An **exploration of the process** of carrying a strong 1989 teaching idea to
  today's leading-edge tech — feeling the era's constraints lift — **not**
  product-building (ai_microscope_ideas.md).
- **A tool, not a spy** — the 1989 ethic that had to survive: supportive,
  unobtrusive, student-in-control; **no game, no grading**.
- The **bookends** pedagogy — preview before the real lab, review after: **remove
  friction, induce review**.
- **Pronunciation as friction** — a rarely-named barrier; the term explorer and the
  pronunciation table; the 1989 "names pronounced, meanings shown," revived.

## Human anchors (the checklistr-style "why")
- Kim's **1989 co-authorship** (Itoga, Bridges, Frederick & Uyeda) and the **37-year
  arc** — a neglected nugget pulled forward.
- **Cecil Johnson's** technique: learn a name by introducing it — *"This is my good
  friend, Hibiscadelphus giffardianus."* Front door to the pronunciation chapter.
- The **two readers** (the student; the teacher/adopter).

## Outline
- **Preface** — the 37-year reach-back; the 1989 co-authorship; a neglected nugget
  pulled forward; the two kinds of reader.
- **1 · The idea that was too early** — the 1989 AI Microscope, its design and
  intent; a tool, not a spy; what the Itoga paper reached for (voiced names,
  meanings shown, cards, images over text).
- **2 · The constraints of the era** — storage (~1.25 MB/slide), the C/Prolog
  hardware split, the serial cable, canned text; a strong idea barely touched by its
  technology.
- **3 · Rebuilding, to feel the constraints lift** — the reconstruction as process,
  not product; the modern stack (browser HTML/CSS/JS; OpenAI, Gemini, ElevenLabs);
  the thesis.
- **4 · A tool, not a spy** — the philosophy that had to survive: no game, no
  grading; supportive, unobtrusive, student-in-control; why the rejections matter
  (Will McClatchey's review as the test).
- **5 · Teaching the machine to be honest** — the color-map story: the flaw
  (name-derived anchors, a blended non-categorical map), the **measurement**
  (359k colours; phantom categories; force-assignment), the categorical rebuild
  (exact-match; honest "unclassified"/"outside"; abundance as a *hint*, on the leaf
  footprint). Diagnosed and fixed in an afternoon — the thesis in miniature.
- **6 · The names** — pronunciation as friction (Cecil Johnson); the term explorer
  (say-it, plain-English gloss, etymology); Greek/Latin **roots as a comprehension
  engine** (shared -enchyma, -phyll, epi-/derma…); the **pronunciation table** and
  its *useful* variability (kept deliberately — it dramatises the friction);
  IPA/CMU, the Cambridge UK/US split.
- **7 · The bookends** — preview, real lab, review; remove friction + induce review;
  the **teacher's view** (complements, non-threatening, optional before/after
  homework on a phone) and the **student's view** (dissolves the start-of-lab quiz
  dread; the lab as reward). The win-win.
- **8 · Audio, and the frontier** — audio as the showcase (Kim's TTS interest); live
  vs. stored (chosen live); on-device TTS and conversational agents ahead.
- **9 · What the rebuild taught** — feeling the constraints lift; the transferable
  method (measure, fix, iterate); neglected nuggets across the work; the tool's
  place in the curriculum.
- **Appendix · How it's built** — the **table-driven** materials (slide manifest,
  botanical_lore, slides.json + the launch intro as data), the secure git→Netlify
  deploy loop, how to add a slide (root/stem/species); for the practically minded.

## Decisions to carry into the prose
- App is **frozen / feature-complete** pending external (plant-anatomist) review.
- Pronunciation **variability is a FEATURE**, not a bug — do not seed it away; it
  motivates the pronunciation table (Ch. 6).
- Everything student-facing is **data, not code** (easy updating) — a point worth
  making in Ch. 9 / the appendix.
- Live Gemini polish **kept** (Kim's call) — the double AI call is accepted.

## Production notes (later)
- Quarto book scaffold in a `documentation/` folder; render offline end-to-end
  before drafting content (checklistr pattern).
- Live worked examples / figures: the color_audit figure, the tissue/abundance maps,
  the overlay, the term explorer, a before/after of the pronunciation test.
- Cover + logo; a read-through; deploy to kimbridges-documents.
- Draft **chapter by chapter**, Kim reviews each (checklistr cadence).
