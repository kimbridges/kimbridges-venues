# AI Microscope — Top-to-Bottom Audit
_Reviewer: Claude · 2026-07-22 · a second opinion on the reconstructed build_

Scope: `index.html` (the whole app), `netlify/functions/narrate.js` + `speak.js`,
`slide_syringa.json`, `botanical_lore.json`. Reviewed across correctness, efficiency /
API use, the live-LLM question, multi-image extensibility, maintainability, UX /
accessibility, robustness, and security.

## What's solid (worth stating first)
The core is genuinely sound now. Identification is manifest-driven and **exact-match**,
with honest "unclassified" / "outside" instead of forced guesses; abundances are on the
leaf footprint; the overlay verifier, the validator + CI, and the git→Netlify deploy loop
all work; the API keys are off the client; and the term explorer is a clean addition.
The findings below are refinements and one real design decision — not a broken app.

---

## Headline decision: the live Gemini "tone polish" (efficiency + accuracy + latency)
**Severity: high — but it's a design call, not a bug.**

On every **Navigation** and **Submission**, the app sends the already-composed feedback
to Gemini to rephrase it (`narrate`), *then* sends the result to ElevenLabs (`speak`).
Consequences, all on every click:
- **Latency:** two network round-trips in series before Rachel speaks. The student waits
  for Gemini *and* ElevenLabs, sequentially.
- **Cost / dependence:** doubles the paid-API calls on those actions.
- **Nondeterminism vs. accuracy:** it rewrites your carefully authored, accurate lore
  each time. "Do not invent facts" is a soft instruction, not a guarantee — the same
  drift you heard in the pronunciation, but on the *content*.

The deterministic lore is already good. **Recommendation:** drop the live polish, or gate
it behind an explicit "tell me more" affordance. This single change improves latency,
cost, accuracy, and determinism at once — and it resolves the "live-LLM" question we
parked. (It also shortens the audio chain, which helps the mobile issue below.)

---

## Correctness / UX
- **Overlapping audio on rapid interactions.** _Medium._ Every trigger makes a new
  `Audio` and plays it; nothing stops the previous clip or cancels an in-flight request,
  so quick clicks stack voices on top of each other. Fix: hold one `currentAudio`, stop
  it before playing the next, and use a generation counter so a superseded request's
  audio is discarded.
- **Mobile audio-gesture fragility.** _Medium._ `Audio.play()` runs after the async
  fetch chain; on iOS Safari a play that lands outside the original tap's gesture window
  can be blocked. It works on your phone, but isn't guaranteed across iOS. Shortening the
  chain (dropping the Gemini call) reduces the risk; a fuller fix pre-creates/uses one
  unlocked `Audio` element.

## Multi-image extensibility (the stated next direction)
- **Single hardcoded slide.** _Medium._ The app does `fetch("slide_syringa.json")` — no
  slide index or picker. A second species needs a small `slides.json` (or a list) plus a
  selector; the manifest/lore model already supports it, so this is UI + one fetch.
- **Zoom/crop geometry assumes landscape.** _Medium._ `cropSize` uses `masterWidth*0.5`
  at 4x and `min(W,H)/zoom` otherwise; for a portrait or square slide the clamp can
  behave oddly. Make the crop geometry aspect-ratio-safe before adding differently-shaped
  images.

## Pedagogy-facing details
- **Magnification labels aren't calibrated.** _Low–medium._ 4x/10x/40x map to zoom
  0.5/2/6 — ratios of 1:4:12, not 4:10:40. Fine as flavor, but a student comparing to a
  real scope will find them arbitrary. Either calibrate the steps or relabel
  "Low / Medium / High."
- **"Wall Density Profile" view is mislabeled.** _Low._ It's a grayscale + 200%-contrast
  pass over the micrograph (canvas composited onto itself); it does not measure wall
  density. Relabel honestly ("High-contrast view") or remove — it's a build-era leftover
  of unclear value.

## Maintainability
- **Duplicated zoom/crop math.** _Low–medium._ The zoom mapping and crop computation live
  in both `redrawViewport` and the canvas click handler — they will drift. Factor a single
  `cropGeometry(turret)` helper.
- **`innerHTML` for the etymology.** _Low._ `termEtym.innerHTML = "<b>Roots:</b> " + m.etymology`
  injects data via innerHTML. Safe now (lore is authored), but if lore ever becomes
  user-supplied, switch to a fixed label element + `textContent`.
- **One ~600-line file.** _Low._ Still manageable, and externalizing the manifest/lore was
  the right instinct; if the JS keeps growing, split it to its own file.

## Accessibility (a quiet strength, with gaps)
- **Strength:** the feedback text is always shown on screen (`audio-status`), so the
  experience is never audio-only — good for deaf/HoH users and true to the supportive
  ethic.
- **Gaps.** _Low–medium._ The canvas is click/tap-only (no keyboard navigation); tissue
  cues are color-only; and the status text isn't an ARIA live region, so a screen reader
  won't announce updates. Worth a small pass, since inclusivity is on-philosophy.

## Robustness / error handling — OK
Load failures surface in the status badge; a failed `narrate` falls back to the
deterministic lore; a failed `speak` still leaves the on-screen text (not audio-only).
Reasonable. Minor: an audio failure gives no explicit cue, but the text is present.

## Security — confirmed, no regression
Keys are server-side in both functions; the origin check is present; `speak.js` now has a
**model allowlist** (prevents a caller forcing an arbitrary/expensive model). The function
endpoints remain public (accepted, and capped). Solid.

---

## Suggested priority order
1. **Decide the Gemini polish** (drop or gate) — biggest single win: latency, cost,
   accuracy, determinism.
2. **Audio management** — stop-previous + supersede in-flight (fixes overlap; helps mobile).
3. **Extensibility prep** — `slides.json` + picker, and aspect-safe crop geometry — when
   the second species is on the horizon.
4. **Honesty/relabel** — magnification labels and the "Wall Density Profile" view.
5. **Maintainability + a11y** — factor the crop helper; add an ARIA live region; the rest
   as convenient.

None of these block the current app; they're the difference between "works" and "clean."
