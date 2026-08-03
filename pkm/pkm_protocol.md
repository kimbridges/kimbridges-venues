# PKM Operating Protocol
_Created: 2026-05-07_
_Status: Active_

## Purpose

This file defines how the PKM system is operated across Cowork
sessions. It is the answer to the question: "given that all these
files exist, how do Kim and Claude actually use them so that the
system stays current and the work stays connected?"

The protocol exists because the system without it failed in a
specific, diagnosable way. The Jones Collection — a substantial,
deployed body of work — was built across sessions without ever
acquiring a proj_*.md file. The PKM was extensively updated on the
same day the collection went live, and still the gap was not
caught. The diagnosis: there was no intake mechanism for new
projects and no end-of-session check to surface what had been
created.

The protocol below is the structural fix. Five reinforcing
mechanisms, each addressing a specific failure mode.

---

## Mechanism 1: Intake Protocol

A new project's first artifact is its proj_*.md file.

When Kim and Claude begin work on something that does not yet have
a proj_*.md file in Projects_Index/, the first action is creating
that file. A two-paragraph stub is sufficient:

- **Objective** — one paragraph naming what the project is for.
- **Current Status** — one paragraph stating where things stand.

Locations, key files, and architecture can be filled in as work
proceeds. The point is that the file exists from minute one, so
that subsequent work updates a real PKM record rather than working
around the absence of one.

This is the hardest gate. Time pressure and "we'll write it up
later" are exactly the conditions under which intake gets skipped,
and exactly the conditions that produced the Jones gap. The rule:
no deep work on a new project until the proj_*.md stub exists.

### Track decision (venue / language) — added 2026-07-17
At intake, also decide the project's VENUE/LANGUAGE track. The friction is the VENUE (which machine the code runs on),
not the language.
- **R on Kim's machine** (via the ClaudeR / r-studio bridge) — for ECOSYSTEM work: anything that builds on or feeds the
  connected R-package family (checklistr, whittakerr, seasonalityr, coenosr, listsr, photobookr, ...), needs Kim's
  G:/Drive data or cached resources (WorldClim, GIFT), or is destined for his documentation / published outputs. Gets
  direct G:/PKM/cache/package access; outputs land in Projects folders.
- **Python in Claude's cloud sandbox** — for STANDALONE EXPLORATORY work: self-contained one-offs whose value is the
  insight + a delivered artifact, NOT extending the R ecosystem and NOT destined for his documentation. No R server to
  start, no bridge / stale-session friction; results delivered via SendUserFile. **Exemplar: Tom Koch public-health /
  mapping questions** (proj_Koch_voronoi + future Koch questions).
- **Test at intake:** does this touch the package ecosystem or Kim's documentation? YES -> R on his machine. NO ->
  Python in the cloud.
Rationale + collaboration framing: proj_briefing_book.md (2026-07-17 discussion) and concept_80pct_tool.md.

---

## Mechanism 2: Session-Start Protocol

Each Cowork session begins with the same THREE reads (the third added
2026-07-31, Tier 3):

1. **pkm_card.md** — the one-page operating card (~4 KB). The ground-truth
   rule, a table of which finding applies to what you are about to do, the
   four surfaces and what each cannot do, and the five storage buckets.
2. **project_index.md** — the master dashboard, which carries the Active
   Focus pointer (Mechanism 3).
3. **proj_PKM.md** — the PKM's own status and next steps.

Total cost is roughly 40 KB. The card is read FIRST and deliberately: on
2026-07-31 two rules already written in pkm_findings.md were broken within
three days of being written, because 66 KB of findings had nothing
connecting a moment of risk to the note covering it. **Reading a rule at
the start of a session is what makes it available at the moment it is
needed.** The card is the trigger; pkm_findings.md is the archive behind
it. See Finding 020, and deferred.md's own framing: *the trigger is the
mechanism, not the list.*

After those reads, Claude states what the active focus appears to be and
asks Kim to confirm or redirect: "We're continuing X" or "We're starting
something new" or "We're switching to Y."

If the answer is "starting something new," the Intake Protocol fires
before any other work. If switching to existing work, Claude reads the
relevant proj_*.md before proceeding.

Reading the session_log.md (Mechanism 4) for the most recent entries is
also useful when context has been interrupted.

### The project-touch rule — added 2026-07-29

Session-start loads the system. There is a second, narrower read that
loads a *project*: **before doing real work on any project, read that
project's section in `deferred.md` (Mechanism 6).** Those items were
filed precisely because they are cheap to do when the file is already
open and pointless to do at any other time. If they are not read at
that moment they are not read at all.

---

## Mechanism 3: Active Focus Pointer

A single field at the top of project_index.md names the current
working project (or projects). Updated each session.

Format:

```
**Active Focus (YYYY-MM-DD):** [project name] — [one-line
description of the current thread].
```

The active focus is what should be growing. If a session ends
and the Active Focus proj_*.md has not changed, that is a flag.
If a session creates work that does not match the Active Focus,
that is a flag — either the focus has changed (update it) or
work has drifted (note it).

---

## Mechanism 4: Session Log

A system-wide session_log.md file. One dated entry per Cowork
session. Distinct from the per-project session_notes.md described
in design_publishing_workflow.md (which is project-scoped and
documentation-oriented).

Each entry captures:

- **Date** and approximate duration if relevant.
- **Active focus** at the start of the session.
- **What was worked on** — projects touched, files changed.
- **Key decisions** — any structural or design choices made.
- **What's queued** — what should happen next session.
- **Notes** — anything that doesn't fit elsewhere but should not
  be lost.

The session log is the connective tissue. When time-sensitive
work interrupts a thread, the log captures it. When the
interrupted thread resumes, the log helps reconstruct context. A
new model instance can read the last few entries and have a
working picture of recent activity.

### Where entries go — added 2026-07-28

New entries go at the TOP of session_log.md, as an h2 heading
(`## `), newest first. Never append to the bottom.

The file holds two blocks. Everything from 2026-06-07 (evening)
onward sits above the horizontal rule in reverse-chronological
order. Below the rule, 2026-05-07 through 2026-06-07 is the
original append-order archive and is left that way
deliberately. The mixed convention is historical, not a choice
offered to new sessions.

**Before declaring any entry missing, grep the WHOLE file for
the date, at every heading level.** Do not read the top of the
file and infer. On 2026-07-28 a LOG GAP marker was found to be
false: 25 entries had been appended to the bottom by sessions
that used the old convention, and some carried h3 headings, so
both a region read and a heading-level scan missed them.

**Never write a gap marker without proving the gap.** A marker
asserting absence becomes load-bearing — the next session reads
the note instead of the file and builds on it. If a gap is only
suspected, say so in those words and name the search that was
actually run, so the next reader knows what has and has not
been checked. See Finding 019.

Reconstructing a lost entry from the proj files is a last
resort, not a repair. A reconstruction inherits whichever
version of a fact its source happens to preserve and cannot
know what it lost. Label any reconstruction as one.


### Dates and times are HONOLULU LOCAL — adopted 2026-07-28

**Kim's rule (2026-07-28):** "I expect to do most of my work from home (Honolulu). It makes
sense for the PKM to record the date/time as the local values. Photos, too, for this project
certainly, should be the local time/date."

**Every date written into the PKM is Pacific/Honolulu local (UTC-10, no DST.)** That includes
`_Last updated:` headers, Active Focus blocks, session_log headings, proj log entries, and
Finding dates. When the session environment reports a UTC date, convert before writing: after
14:00 HST the UTC date is already tomorrow, so roughly the last ten hours of every Honolulu day
will report a UTC date one day ahead. **This is the single most likely way a wrong date enters
the PKM**, and it is silent.

**Why this had to be written down: the convention was NOT previously uniform.** Checked against
file mtimes, which are independent of what any entry claims:

| Entry as labelled | Files actually written (HST) | Which date it used |
|---|---|---|
| proj_specimen_labels.md log `2026-07-03` | 2026-07-03 15:48 | local (correct) |
| session_log `2026-07-28 (evening)` | 2026-07-27 20:04–21:49 | **UTC (one day ahead)** |

So the same log carries both conventions, and the 2026-07-28 entry is internally inconsistent —
its heading is the UTC date while its "(evening)" qualifier describes Honolulu local evening.

**Known boundary anomaly, deliberately NOT rewritten.** Under the local rule the session headed
`## 2026-07-28 (evening)` in session_log.md belongs to **2026-07-27 (evening)**, and its Active
Focus block (now in logs/focus_history.md) is likewise labelled 2026-07-28 with a "NEXT
(2026-07-29)" plan that in local terms meant 2026-07-28. Those strings are left exactly as
written, because other files cross-reference them by date and because Finding 019's rule holds:
do not quietly rewrite a record. This note is the correction. Anyone reconciling that boundary
should read it here rather than infer.

**No retroactive re-dating beyond this.** It cannot be done honestly: an mtime records only the
LAST time a file was touched, not when each individual entry was written, so for most historical
entries there is no evidence of which convention was used. Do not attempt a sweep. Treat any
pre-2026-07-28 date as possibly UTC-shifted by one day, and say so rather than guessing.

**Photographs.** Same rule, and the EXIF supports it directly: Kim's phone writes
`DateTimeOriginal` in local time plus `OffsetTimeOriginal` (-10:00), and separately a UTC
`GPSDateTime`. Read `DateTimeOriginal` with its offset for anything user-facing; the UTC stamp is
available when an absolute instant is needed. Verified on photos/Example_1.jpg and Example_2.jpg
(2026-07-28 16:01:56 -10:00, GPS 2026-07-29 02:01:06Z — the same moment).

**A tooling note that mostly protects itself.** `Sys.Date()` and `Sys.time()` in R on Kim's own
machine already return Honolulu local, so anything generated there (e.g. the `printed` column in
`number_cards_ledger.csv`) is correct by default. Output generated in Claude's cloud sandbox is
UTC and must be converted before it is written into the PKM or into a dated artifact.

---

## Mechanism 5: End-of-Session Checklist

Before sign-off, Claude runs through a fixed list and reports
findings to Kim:

1. **New projects without proj_*.md files?** If yes, intake
   protocol fires now.
2. **For every project touched in this session — review the
   header Status and Focus readiness fields.** Has Status
   changed (Active / Dormant / Reference / Complete)? Has
   Focus readiness changed (Ready / Blocked / Exploring / Not
   applicable)? If yes to either, update the header line and
   add a log entry recording the change. Also update the
   prose Current Status section so it matches. See
   `template.md` for the field definitions.
3. **New files added to the system or to project folders?**
   Reflect them in Key Files of the relevant proj_*.md.
4. **Cross-references to update?** project_index.md (status,
   dates, Active Focus), inventory_all_projects.md (new platforms
   or sites), related proj_*.md files (when projects depend on
   each other).
5. **Decisions or open questions worth logging?** Add to the
   relevant proj_*.md log or to the session log.
6. **Update the session log entry** for this session.
7. **Update Active Focus** if the next session's focus is known.
   The Focus readiness fields across the proj_*.md files are
   the natural input here — a project marked Active + Ready
   is a stronger Active Focus candidate than one marked
   Active + Blocked.
8. **File anything real but not urgent into `deferred.md`**
   (Mechanism 6), and clear it out of Next Steps. Added
   2026-07-29. This is the item that keeps Next Steps honest:
   if a thing is worth remembering but there is no reason to
   do it now, it does not belong in front of the work.
9. **Close the small remainders.** Adopted 2026-07-31 (Kim). If a task is
   small enough to finish now, finish it now rather than carrying it. A
   remainder is NOT a reason to hold a project Active. This is the
   companion to item 8: item 8 files what should wait, item 9 finishes what
   should not. Between them, nothing sits in Next Steps by default.
10. **Account for anything written OUTSIDE `G:`.** Adopted 2026-07-31. The
   PKM's containment rules were Drive-scoped until the R bridge arrived on
   2026-05-30 and could write anywhere on the machine; two stray artifacts
   (226 MB of build scratch in `C:\temp`, a git clone under OneDrive) were
   the result. Any write to bucket 4 or bucket 5 -- see `pkm_card.md` -- is
   named here, with its retention: scratch goes once the deploy is verified
   live, clones are permanent and belong in `C:\repos\`.
11. **Run `pkm_health()`** and report the summary. Adopted 2026-07-31.
   `source("G:/My Drive/Projects_Index/pkm_health.R"); pkm_health()`
   This is the mechanical half of the checklist -- the part that does not
   depend on anyone remembering. It regenerates the works register and
   reports reconciliation failures, broken pointers, drift, size budgets,
   consolidation status and the pre-deletion gate. **Where a claim can be
   checked by the tool, the tool's answer is the record** -- not anyone's
   recollection, and not a note written in an earlier session.

The checklist is the explicit close-the-loop step. Running it
takes a few minutes. Skipping it is what produces silent drift.

### Per-project closing protocol (variant of item 2)

When a session is deep work on a single project, the item 2
review becomes the project's closing protocol: before sign-off
on that project for this session, explicitly answer

- *Has the Status changed?*
- *Has the Focus readiness changed?*
- *If Focus readiness is now Blocked, is the blocker named in
  Next Steps or Blockers?*
- *If the project is now Complete, are Next Steps appropriately
  closed and is the Log entry adequate as a final record?*

This is the same check as item 2, written as a one-project
discipline rather than a sweep across all projects touched.
Either form satisfies the protocol.

---

## Mechanism 6: Deferred Work

Adopted 2026-07-29, after the specimen_labels publication left a
handful of items that were real, worth remembering, and had no reason
to be done that day.

The first five mechanisms cover new projects, loading context, pointing
at the active work, recording what happened, and closing the loop. None
of them handles **work that is real but not now.** Such items had
nowhere to go but Next Steps, where they either manufactured urgency on
a finished project or were quietly dropped. The Jones gap is what
dropping looks like; a Next Steps list nobody believes any more is the
other failure, and it is the one this mechanism addresses.

A single file, `deferred.md`, with a section per project.

**The trigger is the mechanism, not the list.** A deferred item is
worthless unless something guarantees it is read when it becomes cheap
to act on. That guarantee is the project-touch rule in Mechanism 2:
open a project, read its section first. Without it the file is a
write-only archive, which is worse than no file, because it launders
the guilt of not doing the thing.

**Two kinds of entry, kept apart.** A **TASK** waits for an occasion —
the next revision, release or render. A **CONDITIONAL** is not a task
at all: it surfaces only if a named thing happens, and its value is
arriving at the bad moment with the answer already written. Mixed
together the conditionals are buried, and the bad moment is exactly
when nobody reads a long list.

**Item shape.** What, where, why it was deferred, and who raised it,
dated. Attribution matters: colleague reviews are expected to be a
main source of entries, and when a colleague asks whether their note
landed the answer should be *yes, and here it is*.

**Two rules.** An item may be closed as **WON'T DO** with the reason
kept, because a list that only grows is a list that dies. And
**deferred must mean "no occasion yet", never "unpleasant"** — the
hardcoded Google key sat as an open item for weeks and that was not
for want of an occasion.

**Where it goes when it grows.** One file with per-project sections
until a section becomes unwieldy, then `deferred/<name>.md` with a
pointer — the same path the per-project logs took to `logs/` on
2026-07-28. Thirty near-empty files are harder to keep honest than one
file with thirty short sections.

---

## How the Mechanisms Reinforce Each Other

- **Intake** creates the proj file.
- **Session-start** ensures it is read before work resumes.
- **Active focus** keeps it visible at the top of the dashboard.
- **Session log** records the work against it.
- **Checklist** closes the loop and surfaces gaps.
- **Deferred work** holds what is real but not now, so the
  other five stay believable.

Removing any one of these weakens the others. The Jones gap
happened because intake was skipped; with intake skipped, the
checklist had no proj file to remind Kim and Claude about, the
session log did not yet exist, and the active focus pointer did
not yet exist. The protocol is the structural fix for all of it.

---

## Phase 2: PKM Health Check (Planned)

A small R script that scans Projects_Index/, compares each
proj_*.md modification time against file system / git activity in
the named code locations, and flags drift. Run on demand.

This surfaces staleness automatically rather than relying on
memory. It is supportive, not foundational — the protocol matters
more than the tooling.

Status: not yet built. Planned for after the protocol has been
exercised on real material.

---

## Log

### 2026-07-29
**Mechanism 6 (Deferred Work) adopted**, with `deferred.md` created and seeded
from the specimen_labels publication. Mechanism 2 gains the **project-touch rule**
(read a project's deferred section before working on it) and Mechanism 5 gains
**item 8** (file the non-urgent, clear it out of Next Steps). The design point worth
keeping: the file is the easy half, the trigger is the mechanism. Also settled — one
file with per-project sections rather than a file per project, splitting to
`deferred/<name>.md` only when a section earns it, mirroring how the per-project
logs moved to `logs/` on 07-28. Kim's framing: these are the "nice to do them when
there is a reason to update" items, and keeping them out of the active lists stops
them muddying projects with unnecessary reminders. Colleague reviews are expected to
be the main source.

### 2026-05-07
Document created. Five mechanisms specified after the Jones
Collection gap exposed the absence of intake and end-of-session
checks. Adopted in the same session, with the Jones backfill as
the first exercise of the protocol.

### 2026-07-28 (later)
Mechanism 4 gained a "Dates and times are HONOLULU LOCAL" subsection after a UTC/local
mismatch was found: the 2026-07-28 (evening) session entry is headed with the UTC date
while its files were written 2026-07-27 20:04-21:49 HST. Kim ruled that the PKM records
local values. Today's entries were re-dated 2026-07-29 -> 2026-07-28; the historical
boundary entry was annotated, not rewritten (Finding 019). No retroactive sweep: mtimes
record only last-touch, so most historical entries have no evidence either way.

### 2026-07-28
Mechanism 4 gained a "Where entries go" subsection after a
false LOG GAP marker in session_log.md was traced to 25 entries
appended to the bottom of the file instead of prepended.
Codifies: new entries at the top at h2; grep the whole file at
every heading level before declaring anything missing; never
write a gap marker without proving the gap. Finding 019.
