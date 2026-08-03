# PROJECT: [Name]
_Last updated: YYYY-MM-DD_
_Status: Active | Paused | Dormant | Reference | Standing | Complete_
_Focus readiness: Ready | Blocked | Exploring | Not applicable_
_Tags: (optional; free-text work-type markers, e.g. finishing, update)_

## Type
[R package | R tool | R exploration | Content project | Analysis | Reference | etc.]

## Objective
[One clear paragraph.]

## Current Status
[Plain prose statement of where things stand. Complements the
Status header field above with the why and what-next narrative.]

## Locations
- Code: [path]
- Data: [path]
- Docs/output: [path]
- GitHub: [repo URL or "not yet"]

## Key Files
- [filename] — [what it does]

## Related Projects
[If this project belongs to a cluster or has siblings, name them
and link to their proj_*.md. Omit if not applicable.]

## Next Steps
1. [Most immediate concrete action]
2. ...

## Collaborators / Dependencies
[Names, institutions, or external blockers]

## Blockers
[What's stopping progress, if anything]

---
## Log
### YYYY-MM-DD
[Append-only session notes here]

---

## Field definitions

Brief reference for the two structured header fields. Keep these
current — Mechanism 5 of pkm_protocol.md asks for a review at
end of every session that touched this project.

**Status** — the project's overall state.
- *Active* — under development; current Active Focus candidate.
- *Paused* — deliberately suspended awaiting a specific known
  event (an external reply, a dependency, a maturing capability).
  Distinct from Dormant: a Paused project has a named trigger that
  would resume it (e.g., Koch_voronoi awaiting Tom Koch; audio
  awaiting TTS maturity).
- *Dormant* — on hold with no specific trigger; can be reactivated
  when conditions change.
- *Reference* — preserved as ground truth or read-only material.
  Not under development by design (e.g., Ceska, the 1991 COENOS
  reference).
- *Complete* — finished; no further development planned. A project
  with a posted entry on the kimbridges.info / kimbridges-documents
  site is Complete by default (the published version is the
  deliverable; further polish is optional). The folder stays in
  Projects/ alongside active work; the Status field carries the
  "this is done" signal, which removes the need for a separate
  archive.
  A deployed project is Complete even while an external review is
  outstanding; a pending review does not hold a project Active unless
  Kim explicitly says to keep it active (rule adopted 2026-07-28).
- *Standing* — a publication venue or piece of infrastructure that
  receives work continuously and is never finished. The five
  kimbridges_* files are the cases: four venues (stories, documents,
  fiction, collections) plus the site build (info). A Standing file's
  Next Steps concern the venue itself — a new section, a redesign, a
  listing fix — never an individual work published into it. Individual
  works are tracked in the generated register, not as proj_*.md files;
  a work earns a proj_*.md only when it acquires development (code, a
  package, a method, a multi-session build).

**Focus readiness** — whether the project is a sensible Active
Focus candidate right now.
- *Ready* — clear next step, no blocker, would benefit from
  focused work soon.
- *Blocked* — waiting on an external event, decision, or
  dependency. Note the blocker in Next Steps or Blockers.
- *Exploring* — active but pre-direction; needs thinking time
  before focused work. Often the early phase of a project.
- *Not applicable* — Reference or Complete projects; or any
  project where the question does not apply.

The two fields are deliberately separate. A project can be
Active+Blocked (currently developed but stuck), Active+Exploring
(currently developed and finding shape), Dormant+Ready (paused
but would be productive if reopened), and so on. Reading Status
and Focus readiness together gives a quick scan of where each
project really sits.

**Tags** (optional) — free-text, comma-separated work-type markers
that sharpen a project's place on the worklist without expanding
the Status / Focus-readiness vocabularies. Tags in use so far:
- *finishing* — a working tool whose remaining work is packaging /
  reformatting to the standard project structure; a near-complete
  quick win (e.g., photothumbsr, labelextractr).
- *update* — a posted/published project that needs a functional
  refresh (e.g., sitemaps: the Google Maps API code needs updating).
Omit the field entirely when a project needs no tag.
