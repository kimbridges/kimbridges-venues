# PKM Findings

> **READ `pkm_card.md` FIRST.** This file is the archive: 20 findings, ~66 KB, read
> ON DEMAND. The card is the ~4 KB page read at every session start, and it carries
> the ground-truth rule plus a table telling you which finding applies to what you
> are about to do. This split exists because on 2026-07-31 two rules written in THIS
> file were broken within three days of being written -- the knowledge was here and
> nothing fired it (Finding 020).

_Created: 2026-05-12_
_Status: Active — append-only_

## Purpose

This file is the durable home for observations about the PKM
system itself: weaknesses surfaced during real work, infrastructure
behaviors that affect how the system can be operated, conventions
that emerge from doing the work. Distinct from `system_audit.md`,
which is the housekeeping-audit working doc, and from per-project
log entries, which record project work.

The audience is future Claude instances and Kim. The intent is
that reading this file from top to bottom gives a current
operating picture of where the PKM is sharp, where it is dull,
and what rules have been adopted to keep it functional.

Findings are append-only and dated. Operating rules adopted from
each finding are highlighted so they can be lifted into
`pkm_protocol.md` if they merit elevation.

---

## Finding 001 — Bash mount does not write to Drive (2026-05-12)

_**Consolidated 2026-07-31 into THE GROUND-TRUTH RULE in `pkm_card.md`.** Kept here for the detail and the diagnosis; the card is what gets read. See Finding 020._

### Context

The 2026-05-10 session migrated four kimbridges-* folders from
C: to G:\My Drive\ using bash mkdir + rsync. Each migration's
in-session verification (source file count == destination file
count) passed. The session log recorded the migrations as
complete, four proj_*.md files were updated to declare canonical
locations on G:, system_audit.md was updated to reflect the
migrated state.

On 2026-05-12, while working on a different project (whittakerr),
Drive MCP searches incidentally revealed that two of the
"migrated" folders (kimbridges-documents and kimbridges-collections)
did not exist in Drive cloud at all, and that the kimbridges-stories
folder remained the original April 2026 version with no rename
applied. The PKM had described a state that wasn't real.

### Investigation

A controlled diagnostic resolved the question. A small test file
was written via bash to the `/sessions/upbeat-beautiful-pascal/mnt/My Drive/`
path. Three independent checks were then run:

- Bash itself saw the file at the expected path with the expected
  content and 36-byte size.
- Drive MCP search for the file's name across the user's Drive
  returned no results.
- Glob via the file tools (which use the actual `G:\My Drive\...`
  path) also returned no results.

The bash-written file exists only in the sandbox-local mount. It
is not propagated to Drive cloud. Other tools — including those
running on the same system inside the same session — cannot see it.

### Root cause

Cowork exposes Drive content through two distinct mount paths:

- The file tools (Read, Write, Edit, Grep, Glob) use the real
  Windows path `G:\My Drive\...`. Operations on this path go
  through Google Drive for Desktop, which handles
  bidirectional sync with Drive cloud. Writes propagate.

- The bash tool uses a Linux-style path
  `/sessions/<session-id>/mnt/My Drive/...`. This mount appears
  in the sandbox filesystem but is not routed through Drive for
  Desktop. Writes here land in the sandbox; they are not seen
  by the Drive Stream client and never reach Drive cloud.

The bash-mount path looks correct (it has "My Drive" in the
name), so it is easy to assume it is the same as the file-tool
path. The session-start mount message from `request_cowork_directory`
does mention that bash uses a different path, but the implication
that this path does not propagate to Drive was not previously
documented or tested.

### Why prior verification failed to catch it

The 2026-05-10 migrations verified by comparing source file
counts against destination file counts using `find ... | wc -l`
in bash. Both source and destination were measured from the
bash view of the filesystem. The destination directory existed
in the sandbox (bash mkdir made it there), the destination files
existed in the sandbox (bash rsync wrote them there), and the
counts matched. The verification was internally consistent but
sandbox-vs-sandbox; it could not have detected the
sandbox-vs-Drive discrepancy.

The earlier "bash mount staleness" observation in system_audit.md
Section 7 was a related but narrower finding — that bash sees a
cached view of Drive content that may lag actual Drive state for
reads. The 2026-05-12 finding is the deeper one: the bash mount
does not read from or write to Drive at all. The lag observed
earlier was a symptom of a sandbox-local mount that occasionally
gets refreshed from Drive but is not synchronously connected to
it.

### Recovery

On 2026-05-12, Kim re-did the four migrations via Windows
Explorer copy-paste. Each was verified via Drive MCP queries
that go directly to Drive cloud, not through any local mount.
All four now genuinely exist in Drive cloud with their contents
propagating. The previously written PKM descriptions of the
migrations were corrected via Edit tool (which uses the file
tools and propagates correctly) in the same session.

### Operating rule adopted

**For any operation that must reach Drive cloud, do not use bash
on the `/sessions/.../mnt/My Drive/...` path. Use Read, Write,
or Edit on the `G:\My Drive\...` path; or use the Drive MCP
connector (search_files, create_file, read_file_content); or
have Kim perform the action via Windows Explorer on G:\. Bash is
acceptable for reading data that is already real in Drive (and
even there, the staleness caveat from system_audit.md Section 7
applies) and for computation that does not need to land on Drive.**

This rule is significant enough to be lifted into pkm_protocol.md
as an operating principle, possibly as a Mechanism 6 ("infrastructure
rules") or as an addendum to Mechanism 4 (session log) since the
verification gap that hid this for a day is itself a kind of
session-log integrity issue.

### What this finding implies more broadly

A class of system test failures — operations that locally appear
to succeed but never persist — is hard to detect with in-session
verification. The only reliable check is querying the persistent
destination through an independent path. For Drive operations,
that means querying via Drive MCP or via Drive web from a
separate device. Where possible, in-session verification should
include such an independent check for any operation whose
correctness depends on remote persistence.

The PKM's append-only log convention preserved this discrepancy
diagnostically: yesterday's session log recorded a false
"successful migration" state precisely enough that today's
investigation could prove the discrepancy. Mutable status fields
would have been overwritten by the recovery and left no trail.
Append-only logs are not just convention; they are how
diagnostic timelines stay reconstructable.

### What this finding does not affect

The proj_*.md and PKM file edits made via the Edit tool on the
G: path during the 2026-05-10 session DID propagate to Drive
cloud correctly. The misleading content of those edits (claiming
successful migrations) is the problem, not the propagation
mechanism. Edit tool writes to G: paths are reliable.

Manual file moves via Windows Explorer also propagate correctly.

Drive MCP create_file presumably also propagates (writes via the
Drive API directly). Not exercised in the recovery but listed
here for completeness.

---

## Format conventions for this file

Each finding gets a numbered ID (Finding 001, 002, ...) and a
short noun-phrase title. Findings are dated by discovery, not by
when they were written up. Operating rules adopted from a finding
are highlighted in bold so they can be scanned. Findings link to
related entries in system_audit.md, pkm_protocol.md, and proj_PKM.md
when applicable.

Append new findings at the end of this file. Do not rewrite
existing findings; if an earlier finding is superseded, append a
new finding that explicitly references the prior one and explains
what changed.

Findings need not be infrastructure failures. They can also be
pattern crystallizations, convention adoptions, or observations
about how the system behaves under real use. Finding 001 is a
heavy infrastructure-failure finding; Findings 002 and 003 below
are lighter pattern observations. The format accommodates both.

---

## Finding 002 — System test as productive loop (2026-05-12)

### Context

The whittakerr project was deliberately framed as a system test
for the PKM (per session_log.md 2026-05-12 entries). The
hypothesis was that real work on a contained project would
exercise the system and surface weaknesses for repair. Today's
session was the first concrete pass through this loop.

### Observation

The loop worked as intended and at a productive pace. Each
weakness surfaced during the work generated a structural
improvement that became part of the system going forward:

- Multi-chapter documents had no PKM tracking pattern. Invented
  the Chapter Status table in proj_*.md (first used in
  proj_whittakerr.md).
- Working notes (Whittakerr Notes Google Doc) had no PKM home.
  Adopted `background/` folder convention system-wide.
- Source location for non-R-package documents was undocumented.
  Applied the storage architecture rule (Projects/<name>/) to
  storylines (retrospectively) and whittakerr (prospectively).
- Style for multi-chapter documents was implicit. Codified as
  style_multichapter_doc.md.
- Content image storage had no convention. Added the `images/`
  subfolder pattern (Section 6 of the style guide).
- Image attribution practice was undocumented. Added a brief
  attribution convention to the style guide.

None of these improvements were on the day's task list at
session start. They were generated by doing real work in the
PKM's company.

### Operating rule adopted

**System tests are not a separate category of testing activity.
Real work on a contained project, with deliberate attention to
surfaced weaknesses, IS the system test. The PKM gets better
fastest when it's being used for production work and someone is
paying attention to where it creaks.**

Structural consequences: (a) future "system test" framings should
be real projects, not abstract evaluations; (b) protocol-driven
attention to surfacing weaknesses is part of the work, not
overhead; (c) the PKM's evolution is continuous and tied to the
projects that exercise it.

### Implications for future findings

The pattern observed here — exercise → surface gap → update
PKM/style guide → continue — should keep producing
pkm_findings.md entries as long as real work continues. The
finding format accommodates pattern crystallizations like this
one alongside infrastructure failures like Finding 001.

---

## Finding 003 — Document source preservation resolved via Projects/ convention (2026-05-12)

### Context

Before today, the source qmds for kimbridges-documents items
lived in Kim's local desktop folders and were not on Drive. The
proj_kimbridges_documents.md description noted that R-package
documentation source lives in each package's GitHub repo, but
left non-R-package documents (like storylines) with an
underdocumented source location.

This was visible during the storylines template survey: rendered
HTML in `kimbridges-documents/storylines/` on Drive, no qmd
source anywhere on Drive that the file tools or Drive MCP could
find.

### Resolution

The storage architecture rule adopted 2026-05-10 (in proj_PKM.md
Design Decisions) provides the canonical answer for both
code-heavy projects and document-source storage:
`G:\My Drive\Projects\<name>\`. Today the rule was applied
concretely to two documents in the same session:

- storylines source qmds copied by Kim from desktop to
  `G:\My Drive\Projects\storylines\` (retrospective application).
- whittakerr project assembled at `G:\My Drive\Projects\whittakerr\`
  from the start: existing Whittakerr_stuff.Rmd, the new
  `background/` folder with Whittakerr Notes.md, the new
  `data/` folder with Bot_Garden_Geocode_CSV.csv, the new
  `images/` folder with Vegetation_no_legend.png and
  Vegetation.png, the cover image whittakerr_cover_art_text.png,
  the logo image whittakerr_logo_art.png, and the first chapter
  history.qmd (prospective application).

The rule applied retrospectively and prospectively in the same
session, on different documents. Both now have their source on
Drive in the canonical location.

### Operating rule adopted

**For multi-chapter documents deployed to kimbridges-documents,
the source qmd files and supporting subfolders (`background/`,
`data/`, `images/`) live at `G:\My Drive\Projects\<name>\` from
the start of the project. The `kimbridges-documents/<name>/`
location is the deployment target (rendered HTML), not the
source. This separation is documented in style_multichapter_doc.md
Sections 1 and 7.**

### Implications for the next deployment

When whittakerr is first rendered and deployed, the chain will be:

1. Source: `G:\My Drive\Projects\whittakerr\` (canonical, on
   Drive).
2. Render: Quarto produces an `_output/` subfolder.
3. Deploy: Copy `_output/` contents to
   `G:\My Drive\kimbridges-documents\whittakerr\`.
4. Listing stub: Create
   `G:\My Drive\kimbridges-documents\docs\whittakerr.qmd`.

If this chain works cleanly, the source-preservation gap is
permanently resolved and the deployment workflow is the visible
pattern other documents can follow. If something breaks at any
step, that becomes the next finding.

---

## Finding 004 — Stale .RData functions shadow the installed package (2026-05-21)

### Context

While Kim tested the whittakerr document's code chapters chunk
by chunk, two installed package functions misbehaved in ways
that looked like package bugs. `get_climate()` at 30-arcsecond
resolution downloaded WorldClim's entire 9.9 GB global grid
instead of a small tile. Later, `plot_biomes()` failed with
`could not find function "ggplot"`, then rejected the
`total_ppt_cm` argument and drew the precipitation axis in mm.
Each time, the installed package, inspected with
`whittakerr::function`, was confirmed current.

### Root cause

Older, notebook-era copies of `get_climate` and `plot_biomes`
were sitting in the R global environment, left from when those
functions were defined inline in `Whittakerr_stuff.Rmd` and
similar notebooks. R scoping searches the global environment
before attached packages, so a bare `get_climate(...)` or
`plot_biomes(...)` call ran the stale global copy, not the
package's. `library(whittakerr)` does not override a
global-environment definition, and the `whittakerr::function`
diagnostic looked correct because the `::` qualifier bypasses
the shadow.

The stale copies survived an R restart because RStudio, by
default, restores a saved `.RData` workspace at startup. A
`.RData` file in `G:\My Drive\Projects\whittakerr\` held the
old functions and reloaded them into the global environment on
every restart.

### Operating rule adopted

**When developing an R package whose functions were once
defined inline in notebooks, disable RStudio's `.RData`
auto-restore (Tools, Global Options, General: uncheck "Restore
.RData into workspace at startup"; set "Save workspace to
.RData on exit" to Never) and delete any existing `.RData`
from the project folder. Restarting R is not sufficient on its
own while `.RData` restore is on. Diagnose shadowing with
`environmentName(environment(fn))`: a result of "R_GlobalEnv"
means a stale copy is shadowing the package.** `.RData` was
added to the whittakerr `.gitignore` and `.Rbuildignore`.

### Implications

A diagnostic that uses `pkg::function` can report a function
as current while a shadowed bare call runs the stale version.
When an installed and verified function misbehaves, check the
global environment, not just the package. This finding cost
real time across two functions before the common cause was
identified; naming it here should make the next instance quick
to spot.

---

## Finding 005 — Bash mount visibility lags Drive Stream contents (2026-05-27)

_**Consolidated 2026-07-31 into THE GROUND-TRUTH RULE in `pkm_card.md`.** Kept here for the detail and the diagnosis; the card is what gets read. See Finding 020._

### Context

The 2026-05-27 housekeeping survey relied initially on bash
via the Cowork sandbox mount (`/sessions/.../mnt/My Drive/`)
to enumerate G: folders and their contents. Several folders
appeared empty when listed via bash even though Kim confirmed
they held substantial content. Examples surfaced during the
session:

- `Projects/gePoints` and `Projects/whittakerr` shown as
  empty folder shells by bash, but full R-package contents
  (R/, DESCRIPTION, NAMESPACE, .git/, data/, etc.) seen by
  the file tools via Glob.
- `kimbridges-documents/whittakerr/` not visible at all in
  the bash listing of the parent folder, even though the
  whittakerr publication had been verified live the prior
  session and all 15 chapter HTML files were really present.
- `Projects/` itself: bash showed two subfolders (gePoints,
  whittakerr), but Kim's Windows `dir` listing showed
  fourteen, every one populated.

Different bash queries against the same parent could return
different sets of children. Top-level folder names were
sometimes visible and sometimes not; subfolder contents were
often invisible even when the parent appeared.

### Investigation

Three independent paths confirmed the discrepancy:

- The file tools (Glob, Read) using the `G:\My Drive\...`
  path see populated folders correctly.
- Kim-supplied Windows `dir` listings (native, not through
  the sandbox) match the file-tool view.
- Bash via the sandbox mount path returns inconsistent and
  partial views of the same underlying Drive content.

Kim caught the discrepancy early in the session: when bash
reported `Projects/gePoints` and `Projects/whittakerr` as
empty, he flagged "those folders are full of files, I think
you're seeing a sync problem." A re-check with Glob
confirmed his reading and exposed the broader pattern.

### Root cause

Drive for Desktop in Stream mode materializes folders and
files on demand. The Cowork sandbox mount sees only what has
been materialized into the local cache at query time.
Recently-touched or recently-streamed folders are present;
older or recently-renamed ones not yet pulled into the cache
return as absent or empty.

The file tools route through the Windows `G:\` path, which
triggers Drive for Desktop's on-demand fetch when accessed.
The sandbox mount does not trigger that fetch — it sees the
materialized cache directly, with no pull-down. The cache is
loosely refreshed in the background but not synchronously
connected to live Drive state.

This is the read-direction companion to Finding 001 (which
covered the write direction: bash writes to the sandbox
mount do not propagate to Drive cloud). Together the two
findings describe the bash mount as a sandbox-local view
that is only loosely connected to Drive, not a transparent
path to Drive content in either direction.

### Operating rule adopted

**For any G: visibility check — what folders exist, what
files are inside, what the file counts are — use the file
tools (Glob, Read) on the `G:\My Drive\...` path, or have
Kim provide a Windows `dir` listing. Do not trust bash
readings of folder existence or contents on the sandbox
mount path. Bash is acceptable for reading files that have
already been confirmed to exist via the file tools or
Drive MCP, with the staleness caveat from system_audit.md
Section 7 applying.**

### Why this matters for the housekeeping work

The 2026-05-27 housekeeping survey nearly acted on incorrect
data. Bash showed `Projects/gePoints` and
`Projects/whittakerr` as empty shells, which would have
suggested those folders needed their R-package contents
migrated in from somewhere else. Kim's intervention and the
file-tool re-check prevented an early plan to "consolidate
empty Projects shells" from generating bogus moves.

The same pattern surfaced when bash claimed
kimbridges-documents had no whittakerr subfolder, after the
whittakerr publication had been verified the prior session.
A bash-only survey would have flagged the publication as
incomplete and chased a non-existent gap.

After the rule was adopted mid-session, the rest of the
survey used Kim-supplied `dir` listings as the authoritative
view, with Glob confirming specific folders on demand. The
remainder of the work proceeded cleanly.

### Relationship to Finding 001

Finding 001 (2026-05-12) established that bash writes to the
sandbox mount do not propagate to Drive cloud. Finding 005
(2026-05-27) establishes the read-side analogue: bash reads
from the sandbox mount may not see what is actually in
Drive. Together, they justify the broader operating rule:
the bash mount is a sandbox-local artifact, not a
transparent path to Drive in either direction.

The file tools, the Drive MCP connector, Windows Explorer,
and Kim-supplied `dir` listings remain the trustworthy
paths for any operation that depends on Drive state.

### What this finding does not affect

The file tools (Read, Write, Edit, Glob, Grep) on
`G:\My Drive\...` paths work correctly for both reads and
writes, and propagate to Drive cloud. Operations performed
via the file tools during this and prior sessions are
reliable. The new rule restricts bash, not the file tools.

Drive MCP queries also remain reliable for direct
verification of Drive cloud state.

---

## Finding 006 — Live RStudio↔Claude execution bridge via ClaudeR (2026-05-30)

### Context

Until tonight, Claude's only way to run R was the Cowork Linux
sandbox: an isolated environment with none of Kim's data, packages,
plots, or working state. Code run there is throwaway. The question
Kim raised was whether an MCP server could let Claude execute R in
his *live* RStudio session — the same environment he works in, with
his objects in memory and plots rendering in the Plots pane. The
answer is yes, and a working bridge is now in place. This is a new
interface modality between Kim and Claude, captured here because it
carries durable operating rules and because the setup path crossed
real obstacles worth recording so the next setup (new machine, R
upgrade, or a future instance) is quick.

### Two candidate tools; ClaudeR chosen

- **Posit `mcptools`** (first-party, on CRAN) was tried first. It
  connects a client to a running R session via `mcp_session()` plus
  an `Rscript -e "mcptools::mcp_server()"` server entry. But the
  bare server surfaces no tools useful for running code — it needs
  a tool provider, and the recommended one is the `btw` package.
  `btw`'s dependency chain (via `ellmer`) demanded compilation from
  source, pulling in Rust and Visual Studio Build Tools. On Kim's
  Windows R that was a wall, not worth scaling tonight.
- **ClaudeR** (`IMNMV/ClaudeR`, GitHub) was the pivot and the
  keeper. Its MCP server is **Python**, run through `uvx`, which
  downloads a prebuilt package — so it routes around the R
  compilation chain entirely. The only R-side install is ClaudeR
  itself plus pure-R / binary dependencies (Shiny, jsonlite,
  rstudioapi). It is purpose-built for an RStudio data-science loop:
  `execute_r`, `execute_r_with_plot` (captures plots), async
  execution, reading the active document, installing packages.

### The path through the complexity (three obstacles, each resolved)

1. **`nanonext` version mismatch (mcptools path).**
   `mcptools::mcp_session()` failed with
   `unused argument (fail = "none")`. The `fail` argument to
   `nanonext::listen()` was added in **nanonext 1.6.0**; the
   installed copy predated it. Fixed by `install.packages("nanonext")`
   then a full R restart (Session → Restart R unloads the old DLL).
   `mcp_session()` then ran clean. (This obstacle belongs to the
   mcptools route, which we ultimately set aside, but the session
   is left opted-in and does no harm.)

2. **`uvx` not on R's PATH.** After installing `uv`/`uvx` and
   getting a version from the shell, `install_clauder()` still
   errored: `uvx was not found on your system`. RStudio's R process
   had been launched with an older environment that lacked the
   installer's PATH addition, and **Session → Restart R does not
   reload it** — only a full RStudio quit (or reboot) does.
   Confirmed with `Sys.which("uvx")` returning `""`. Fixed for the
   session with
   `Sys.setenv(PATH = paste(Sys.getenv("PATH"), "C:/Users/kim/.local/bin", sep = ";"))`,
   then made permanent in `.Renviron`
   (`PATH="${PATH};C:/Users/kim/.local/bin"`). `uvx` resolved to
   `C:\Users\kim\.local\bin\uvx.exe` (shown as the 8.3 short form
   `LOCAL~1`, which is fine).

3. **The add-in server is a separate "Start Server" click.**
   `claudeAddin()` prints `Listening on http://127.0.0.1:4099` —
   that is only the add-in's own UI panel loading in the Viewer
   pane. The actual connection server (default port 8787) does not
   start until the **Start Server** button is clicked. Before the
   click, tool calls returned
   `RStudio addin is not running`. After it, the loop went live and
   Claude executed code in the session (verified: R 4.3.3 ucrt on
   Windows 10, 486 packages, `2 + 2 = 4`).

Note: the desktop app picked up the new MCP server the moment Start
Server was clicked — no app restart was needed, despite the
configuration step suggesting one.

### Operating rule adopted

**The start-of-session sequence to bring the live R bridge up is:
(1) in RStudio, `library(ClaudeR); claudeAddin()`; (2) click
**Start Server** in the Viewer-pane panel and leave it running.
That is the whole ritual once `.Renviron` carries the uv bin path.
If the bridge ever fails to come up after a new machine or an R
upgrade: re-check `Sys.which("uvx")` (a `""` means PATH again — a
full RStudio quit or the `.Renviron` line fixes it), confirm
`nanonext` ≥ 1.6.0, and re-run `install_clauder()` to refresh the
MCP path (per ClaudeR's own R-upgrade note).**

### Guardrails (by design)

ClaudeR blocks Claude-executed code from calling `system()`,
`system2()`, `shell()`, and file-deletion functions (`unlink()`,
`file.remove()`, and `rm`-bearing system calls). Kim's own
manually-run code is unaffected. So if a task genuinely needs one
of those, Claude will say so and Kim runs it himself. This is a
sensible least-privilege boundary, not a defect.

### Why this matters

This is the read/write companion to Findings 001 and 005, but in
the opposite direction: those established that the *bash* sandbox
mount is only loosely connected to Drive. This finding establishes
a *new, tightly-connected* execution path — into Kim's live R
session, where the objects, packages, and plots actually are.

For the immediate roadmap it is more than infrastructure. The next
Active Focus is the stories realm, built collaboratively on
`photobookr`; that work is R-heavy (EXIF-driven folder/chapter
structure, photo placement, rendering). With the bridge up, Claude
can drive and debug that R harness directly in Kim's session
instead of handing code back for manual runs — Kim's framing at
close: "an even better way to build the stories, as you can handle
the harness now." The same applies to the book-assembly cluster
parity testing. The capability arrived as an unplanned side thread
(parallel to the 2026-05-10 audio intake); the stories focus is
unchanged, now better resourced.

See session_log.md 2026-05-30 (late evening) for the session
narrative and proj_PKM.md for the interface-modality log note.

---

## Finding 007 — Long R calls via ClaudeR exceed the Cowork tool window; render one network call per execute_r (2026-06-03)

### Context

The Audio project's R harness renders dialog by calling the ElevenLabs
Text-to-Dialogue API from Kim's live R session over the ClaudeR bridge.
Each render is a network round trip of roughly ten to thirty seconds.
The Cowork `execute_r` tool has a response window of about 45 seconds.

### What was observed

- A single `execute_r` call that issued **two** API renders (the
  `el_assemble_wav` end-to-end function rendering both chunks of a dialog)
  reliably exceeded the window: the MCP request returned
  `Request timed out`, and on the heavier calls the ClaudeR add-in
  connection dropped (`RStudio addin is not running`), needing a
  **Start Server** restart in RStudio.
- Single-render calls (one chunk, one API call per `execute_r`) returned
  cleanly every time. The first test's three MP3 parts, rendered one per
  call, never timed out.

### The key distinction

**An MCP timeout is a failure of the response channel, not of the work.**
The R code keeps running in the session after the tool call returns; in
both timeout cases the output file (`nike_full.wav`, an earlier MP3 part)
was found complete afterward. So: on a timeout, do not assume failure and
re-run — first verify the output with the host file tools (Glob/Read on
the `G:\…` path, per Finding 005), because a re-run wastes a paid render
and can collide with the still-running call.

### Operating rule adopted

**Keep each `execute_r` call to one network render so it returns inside
the tool window.** Render a multi-part dialog one part per call (fast,
clean, observable), then do the local-only assembly (silence splice, WAV
write — no network) in a separate quick call. Do not bundle multiple
renders into a single call. The harness's `el_assemble_wav` is convenient
but renders all parts internally, so it is the one function that trips
this; the fix is to render the PCM parts in separate calls and pass them
to the assembler, or to add a "render parts separately" path to it. The
≤1,900-char chunking already keeps any single render comfortably inside
the window.

### Why this matters

This is the operational companion to Finding 006. The bridge made live R
execution possible; this finding makes the *autonomous* loop reliable —
Claude can render and iterate without Kim babysitting each step, provided
the work is sliced so each call is a single round trip. It generalises
beyond audio to any network-bound R work over the bridge (web pulls, API
calls, long model fits): one slow operation per `execute_r`, verify
output on timeout rather than retrying blind.

### Update (2026-06-03 evening)

Even a **single** render can overrun the tool window — render time scales
with output audio duration, and a ~4-minute dialog (the recast Nike_challenge)
overran on each part. So "one network render per call" is necessary but not
sufficient. The pattern that worked reliably: **fire the render (accept the
MCP timeout), then poll for the result object in a quick follow-up call, then
do the local-only assembly.** While R is mid-render the ClaudeR add-in is
unresponsive and may report "addin is not running"; that is the render
blocking, not a crash — wait and poll again rather than asking for a restart.
The proper fix is **asynchronous rendering** via ClaudeR's `execute_r_async`
/ `get_async_result`, queued for the harness; it removes the blocking and the
spurious timeouts entirely. (Also noted this session: PCM at 44.1 kHz needs a
higher ElevenLabs tier; the WAV path falls back to 24 kHz.)

See session_log.md 2026-06-03 (afternoon and evening) and proj_audio.md for
the session narrative.

---

## Finding 008 — Two gotchas in the stories-site deploy: render scope and Drive-stream upload (2026-06-23)

### Context

Kaka‘ako Birds was the **first deploy to the kimbridges-stories site since the
collaborative-story era began** (and the first since `Photo_Book_workingnotes`
was filed into `underway/` during the 2026-05-27 housekeeping). Two distinct
problems surfaced in sequence during the `quarto render` → Netlify drag-deploy.
Both are companions to Findings 001/005 (the bash-mount/Drive-stream behaviors),
but on the publish path rather than the housekeeping path.

### Gotcha 1 — `quarto render` walks `underway/` and chokes on working files

`quarto render` with no `render:` scope renders **every** `.qmd` in the project
tree except `_`-prefixed ones. The stories site keeps in-progress material in
`underway/<story>/`, which contains working `.qmd` files (here
`underway/Photo_Book_workingnotes/Photo_2_PDF.qmd`, plus Cranes and others).
The render dove into one and failed on an R chunk that reads an image:
`NoDecodeDelegateForThisImageFormat 'QMD'`. It had never bitten before only
because the stories site had not been rendered since those folders landed.

**Operating rule adopted: scope the stories-site render to the published pages.**
`_quarto.yml` now carries:

```
project:
  render:
    - "*.qmd"        # root (index.qmd)
    - "stories/*.qmd"
    - "!underway/"
```

This renders only `index.qmd` + `stories/*.qmd` and never descends into
`underway/`. Any future working `.qmd` parked in `underway/` is now inert to the
build. (The site lists from `stories/` via the listing in `index.qmd`, so the
inventory spreadsheet is NOT needed at render time — see Gotcha note below.)

### Gotcha 2 — Netlify drag-deploy from a Drive-stream folder skips large unmaterialized files

After a clean render, Kim dragged `_site/` onto the Netlify drop zone. The site
came up with the **cover thumbnail showing but the PDF failing to load**.
Diagnosis: locally, `_site/pdfs/Kakaako_Birds.pdf` was a complete, real 10.14 MB
`%PDF` file; on Netlify it was absent (the URL returned the HTML fallback, not a
PDF). The 117 KB cover JPG — already materialized — uploaded fine; the 10 MB PDF
was almost certainly still a **Google Drive stream placeholder** at drag time
(the same all-zeros condition seen on the inventory `.xlsx` this session), so the
browser upload skipped it. Reading the file through R forced Drive to
materialize it; a re-drag then carried the real bytes, and the PDF went live.
(There is also normal Netlify/Drive propagation lag — the first re-check looked
empty until it finished; patience resolved the last step.)

**Operating rule adopted: before drag-deploying `_site/` from a Drive-stream
folder, force the large binaries to materialize.** Right-click `_site` (or at
least `_site/pdfs`) → **Available offline** in Drive for Desktop and wait for the
solid green check (not the cloud icon) before dragging; or copy `_site/` to a
local non-Drive folder (Desktop, `C:\temp`) and drag *that*. After deploy, verify
the large asset directly (open `…netlify.app/pdfs/<file>.pdf`) rather than
trusting that the page "looks" deployed because the thumbnail rendered.

### Relationship to prior findings

Findings 001 (bash writes don't reach Drive) and 005 (bash reads lag Drive) are
about the **sandbox mount**. This finding is about a third surface: **a host-side
application (the browser upload) reading a Drive-stream folder gets placeholders
for not-yet-materialized files.** The through-line across all three: a Drive
stream path can present a file as "there" (correct name, correct size metadata)
while the real bytes are not locally present. Any operation whose correctness
depends on the bytes — bash propagation, bash listing, or a browser upload —
must first force materialization (read via the file tools / R) and then verify at
the independent destination.

### Note for the next stories deploy

The kimbridges-stories site renders its grid from `stories/*.qmd` (the `listing:`
in `index.qmd`), not from `stories_inventory_v2.xlsx`. So a story can be
published with just three artifacts in place — `pdfs/<name>.pdf`,
`images/<name>.jpg`, and `stories/<slug>.qmd` — which is the route used here
(the artifacts were staged directly via R + the file tools, bypassing
`add_stories.py` because the inventory `.xlsx` was an unmaterialized placeholder).
The inventory remains the human "source of truth" and should get the row when
convenient, but it is not on the render critical path.

See session_log.md 2026-06-23 and proj_kimbridges_stories.md.

---

## Finding 009 — Pushing a new package to GitHub via ClaudeR: stale `gh` toolchain + the gert token-in-URL push (2026-06-24)

### Context
Publishing the new `seasonalityr` package to GitHub from Kim's live R session (ClaudeR).
The local git work was easy; the GitHub-API and HTTPS-auth steps each needed a workaround.
Recorded because the next package push will hit the same two walls.

### What happened
1. **`gh` (the GitHub API client) was stale and broke in a cascade.** `gh::gh_whoami()` and
   even `gh::gh("GET /user")` failed with `could not find function "check_string"`; after
   updating `gh`/`cli`/`rlang` it then failed with `'curl_modify_url' is not an exported
   object from 'namespace:curl'`. The fix was to update the **whole chain** —
   `install.packages(c("gh","cli","rlang","curl","httr2"), type="binary")` — done
   **non-interactively via `execute_r_async`** (Finding 007: interactive installs hang the
   bridge), then run the API calls in a **fresh async process** so it loads the repaired
   packages (the main session keeps the broken `gh` loaded until restart).
2. **`gert::git_push(password = token)` failed with "HTTPS Authentication failure".** Passing
   the PAT as `password` alone does not pair with a username, so libgit2's handshake fails.
   **The reliable push:** temporarily set the remote URL to embed credentials —
   `https://<login>:<PAT>@github.com/<owner>/<repo>.git` via `gert::git_remote_set_url()` —
   `git_push(set_upstream=TRUE)`, then **reset the remote to the clean URL** so the token is
   not left in `.git/config`. Repo creation itself: `gh::gh("POST /user/repos", name=...)`
   (worked once the toolchain was repaired). Token retrieved with `gh::gh_token()`.

### Operating rule adopted
**To push a package to GitHub over ClaudeR: (1) do local git with `gert` (`git_init`/`git_add`/
`git_commit`); (2) if `gh` errors, update `gh`+`cli`+`rlang`+`curl`+`httr2` via
`execute_r_async`, then create the repo with `gh::gh("POST /user/repos", ...)` in a fresh
async process; (3) push with `gert` using a credential-embedded remote URL, then reset the
remote to the clean URL.** `system2`/`shell` git is blocked by ClaudeR (Finding 006), so the
gert/gh route is the path. Result: `seasonalityr` is live at github.com/kimbridges/seasonalityr.

See session_log.md 2026-06-24, proj_seasonalityr.md.

---

## Finding 010 — OpenAI image drafting via R (gpt-image-1), and the AI-drafts / human-finishes division of labor (2026-06-24)

### Context
Illustrating the short story "My Name Is Nike" surfaced a **new, reusable capability** (image drafting via
OpenAI) and, more importantly, a **clear working rule** about what to send the generator and what to finish
by hand. Kim: this is "a big step forward… a capability that we'll probably use quite often."

### The capability
Claude can **generate and edit images via OpenAI `gpt-image-1`** from Kim's live RStudio session over
ClaudeR, using **httr2** — the image cousin of the ElevenLabs audio harness (`elevenlabs_dialogue.R`).
Run **async** (Finding 007); decode the returned base64 with `openssl::base64_decode()` → `writeBin()`.
- **Text-to-image:** `POST https://api.openai.com/v1/images/generations`, JSON body
  `{model:"gpt-image-1", prompt, size:"1536x1024", quality:"high", n:1}`,
  `req_auth_bearer_token(Sys.getenv("OPENAI_API_KEY"))`; image at `body$data[[1]]$b64_json`.
- **Image-to-image / edit:** `POST /v1/images/edits`, **multipart** — single image via
  `req_body_multipart(model="gpt-image-1", image=curl::form_file(path), prompt=..., size=..., quality=...)`,
  or **multiple reference images** by repeating the field name `image[]`:
  `do.call(req_body_multipart, list(req, model=..., prompt=..., size=..., quality=..., `image[]`=form_file(a), `image[]`=form_file(b), ...))`.
- Cost ~pennies/image. Key in `.Renviron` (`OPENAI_API_KEY`); the account needs **billing headroom** (the
  first call hit a hard limit; Kim funded it). The `curl`/`httr2`/`gh` toolchain was updated this session
  (Finding 009), which is what makes the httr2 image calls work.

### The division of labor (the rule — this is the durable lesson)
- **OpenAI excels at ATMOSPHERE, PLACE, OBJECTS, LIGHT, and SYMBOL** — any scene with no fidelity
  constraint. The camu-camu berry tray, Jones's lamplit office, and the two yellow birds each landed in
  one or two passes and were keepers.
- **OpenAI is UNRELIABLE for two things:** (a) a **specific face** — it reinterprets every pass (Nike's
  blue eyes turned brown, her forehead lettering scrambled); and (b) reproducing a **specific supplied
  pattern** — given Kim's bar-and-dash tattoo diagrams it kept defaulting to generic dot clusters.
- **Those two go to the HUMAN.** Kim composites the exact face and draws the exact patterns in Photoshop /
  with a **Wacom tablet** — minutes by hand versus a dozen failing generative passes. The finished
  satellite-call image (`ch7_satellite_call_FINAL.png`) was produced this way: Kim placed the real Nike
  portrait on the laptop screen and drew each elder's distinct forehead tattoo himself.

**RULE adopted: draft scenes/atmosphere/objects/symbols with OpenAI; do exact faces and exact supplied
patterns by hand. Never send a must-match-this-face or must-match-this-pattern job to the generator.**
(Claude's deterministic `magick` perspective-composite of the exact face is possible but fiddly and came out
inferior to Kim's Photoshop finish — don't reach for it when Kim can retouch.)

### Working-practice note
The human's specialized craft — compositing an exact likeness, tablet retouching — is a **first-class part
of the collaborative loop, not a fallback.** AI drafts; Kim finishes. (Cross-ref the proj_PKM.md
meta-observation of the same date.) Recorded because it generalizes to all future illustrated work.

See proj_audio.md 2026-06-24 (Nike illustration thread) and session_log.md 2026-06-24.


## Finding 011 — Netlify's "Add new project" now routes a typed description into an AI agent builder; bypass with Netlify Drop (2026-06-26)

**What happened.** Publishing the new kimbridges-fiction site, Kim went to add a new Netlify project and typed a brief description of the site. Netlify's current onboarding treats that description as a prompt for its **Agent Runners** and spun up an AI coding agent (a Claude Code session) that *generated* a placeholder site and deployed it — not the `_site` Kim intended to drag. The result was an unexpected landing page and a junk project.

**Why.** Netlify rolled out AI/agent-based site creation across 2025–2026 (netlify.new; "Create new project with an AI agent"; Agent Runners in the dashboard). The default 'Add new project' path now favors generate-from-prompt, not manual upload.

**Operating rule (manual deploy — what we actually want):**
- To create a site from a finished build, use **https://app.netlify.com/drop** (or the drag-and-drop dropzone at the bottom of the team's Projects page). Drag the `_site` folder (or its contents) — no prompt, no agent.
- To UPDATE an existing site, drag onto that site's **Deploys** tab dropzone. The AI flow is only the *new-project* path, so updates never hit it.
- Then rename the Drop site (Project configuration -> Change site name) to the desired subdomain.
- Delete any junk project the agent flow created.

**Companion clarification to Finding 008.** For Netlify **drag-and-drop**, dropping the `_site` *folder* is fine — Netlify uses the dropped folder's contents as the site root. The "deploy the contents, not the folder" caution in Finding 008 was specific to the **R `file.copy`** deploy (copying `_output/` into a folder nested it and caused a 404); it does not apply to the drag-and-drop landing pad.

**Side capability used here.** Ghostscript is available in the Cowork sandbox: `gs -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -dColorImageResolution=150 -dGrayImageResolution=150 ...` compressed the 19 MB illustrated Nike PDF to 0.61 MB with the fine two-column journal text still legible — a quick web-compression path when Acrobat isn't at hand.

## Finding 012 — Quarto renders via ClaudeR time out the MCP request but complete in-session; verify on disk (2026-06-29)

**What happened.** Shipping the seasonality book, both `quarto::quarto_render()` calls through ClaudeR (the book, then the documents website) returned `MCP error -32001: Request timed out`. Both renders had in fact **completed successfully** in Kim's R session — the error only meant the Cowork tool stopped waiting, not that the render failed.

**Why.** A full Quarto render runs longer than the ClaudeR/Cowork tool window (the same window behind Finding 007). The R process keeps executing after the MCP request is abandoned. Compounding it, the rendered output lands on a `G:` Drive-Stream path, so the **host file tools (Glob) briefly do not see the new files** while Drive syncs (Finding 005, read-direction) — the first few `Glob`s returned "No files found" even though the render was done.

**Operating rule.**
- After a `quarto_render` (or any long R call) times out at the MCP layer, **do not assume failure**. Wait, then **verify on disk**: query the **R session itself** (`file.exists`/`list.files` via a fresh short `execute_r`) — the live R session sees `G:` directly and immediately, unlike the sandbox and ahead of the Drive-sync lag that delays the host file tools.
- For renders specifically, confirm success by the **artifacts**, not the return value: `_output/*.html` (book) or `_site/<name>/index.html` (site), plus a grep of the HTML for chunk-error strings (`could not find function`, `Error in`, `Quitting from`).
- Prerequisite worth remembering: Quarto renders in a **fresh R session**, so a GitHub package used by the document must be **installed** (`devtools::install(local_path)` or `install_github`), not merely `load_all`'d in the interactive session.
- Keep heavy per-cell work (e.g. continental `regime_map_region` maps) **out of the render** — pre-generate to PNG and embed — so the render stays light and the timeout is only a waiting artifact, never a real compute risk.

### Finding 013 (2026-07-17) — Trust the R bridge for G: file state; the device staging bridge can serve STALE copies in Stream mode

_**Consolidated 2026-07-31 into THE GROUND-TRUTH RULE in `pkm_card.md`.** Kept here for the detail and the diagnosis; the card is what gets read. See Finding 020._
On session restart, the device file-staging bridge (`device_stage_files`) returned STALE copies of PKM files: project_index.md
read as _Last updated 2026-07-09_ (no briefing_book at all) and proj_briefing_book.md as _2026-07-16_ (missing the 2026-07-17
entries) — even though both had been written and read back consistently the day before via the R bridge (RStudio/ClaudeR on G:).
Reading the same files through the **R bridge** showed them fully current (07-17, all content present). So the staged copies were a
Drive **Stream-mode sync/caching lag** — the same class of issue as Finding 005 (bash mount visibility), now seen in the
file-staging bridge too. **Operating rule:** for ground-truth on any `G:\My Drive\...` file, read via the R bridge
(`readLines`/`file.info` in the RStudio session), NOT the device-staged copy. Do not rewrite PKM files from a staged view —
you could clobber newer on-disk content or spawn Drive conflict copies. (No data was lost in this instance.)
### Finding 014 (2026-07-25) — The RStudio MCP blocks `system()`; use R's own file functions
`execute_r` refuses shell-outs. `system("quarto --version")` returns *"R Error: Security restriction: System command
execution is not allowed"*, and the same guard applies to `system2` and `shell`. This is a hard boundary of the bridge,
not a transient failure, so there is no point retrying or quoting around it.

**Operating rule.** Everything the bridge is actually needed for has a pure-R equivalent, and those are not blocked:
`Sys.which()` to locate an executable, `file.exists()` / `file.info()` to check state and mtimes, `file.copy()` /
`file.remove()` / `file.rename()` to move things, `readLines()` / `writeLines()` to inspect and edit. For Quarto
specifically, the R `quarto` package (`quarto::quarto_render()`) is installed on Kim's machine and runs renders without
a shell — and note Finding 012, which says such a render will time out at the MCP layer while succeeding in-session.

**Why it matters.** The R bridge remains the ground truth for `G:` file state (Finding 013) and the only way to reach
anything outside the connected folders. Knowing its shape saves a failed call each session.

### Finding 015 (2026-07-25) — Two file-transport traps: the Downloads destination, and read-only staged copies

_**Consolidated 2026-07-31 into THE GROUND-TRUTH RULE in `pkm_card.md`.** Kept here for the detail and the diagnosis; the card is what gets read. See Finding 020._
Both bit during the AI Microscope documentation build, and both are recurrences of a class rather than one-offs.

**The Downloads trap.** When Kim edits a project file through a browser-based tool and saves it, the result lands in
`C:/Users/kim/Downloads`, not in the project folder on Drive. It has now happened twice: once with chapter files, once
with `_quarto.yml`. The symptom is confusing rather than obvious — Kim reports having made an edit, and the file on
Drive genuinely does not have it, so the natural read is that the edit was lost. **Rule:** when a Kim-reported edit is
missing from Drive, check `C:/Users/kim/Downloads` via the R bridge before concluding anything. Diff the two copies
(`readLines` both, compare), copy Downloads → Drive with `file.copy(overwrite = TRUE)`, and then **`file.remove()` the
Downloads copy** so it cannot cause the same confusion a third time. Downloads is not reachable from the device bridge
(it is not a connected folder), so R is the only route to it.

**Staged copies are read-only and do not refresh.** Files brought over by `device_stage_files` land in
`/mnt/user-data/uploads/<folder>/` **read-only**, and calling `device_stage_files` again on the same path does **not**
overwrite the existing copy. So after Kim edits a file mid-session, a re-stage silently returns the old content — which
looks exactly like Finding 013's Drive-sync staleness but has a completely different cause and a completely different
fix. **Rule:** the container runs as root, so `rm -f` (or `rm -rf` the staged folder) **before** re-staging. Used three
times this session, and it works every time. When in doubt about which staleness you are looking at, read the file
through the R bridge, which is ground truth either way.

### Finding 016 (2026-07-25) — Render, serve, and screenshot in the sandbox: a verification loop for Quarto documents
**What it is.** Quarto is not preinstalled in the cloud sandbox, but it installs cleanly:

```
curl -sL -o q.deb https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.43/quarto-1.6.43-linux-amd64.deb
dpkg -i q.deb
```

With a working copy of the book source in the container, `quarto render` produces `_output/`, `python3 -m http.server`
serves it on a local port, and Playwright (already available) screenshots any page at any scroll position. The whole
loop runs without touching Kim's machine and without a Netlify deploy.

**Why it earns its keep.** A figure anchored mid-paragraph in `honest.qmd` made Quarto treat the image as inline: no
number, no caption, and the paragraph split around it. **`quarto render` exited clean.** Nothing in the build output
suggested a problem. The only thing that caught it was a screenshot of the rendered page. The general rule this
supports: for anything with a visual result, the exit code is not the artifact — look at the output. Once the loop
exists, looking costs one tool call.

**Corollaries.** Normalize line endings to LF in the container working copy. Keep the container copy and the Drive copy
explicitly synced (edit in one place, commit back with an `expectedMtimeMs` guard) rather than drifting between them.
And the sandbox network is allowlisted: github.com clones fine, but the deployed site (aimicroscope.netlify.app) is
**not** reachable, so screenshots of the live app must come from a local clone served locally.

### Finding 017 (2026-07-25) - Quarto CAN be driven through the R bridge; do not set QUARTO_PATH

Finding 014 records that the shell-execution functions are blocked in the RStudio MCP. That made it
look as though Quarto could not be run from the bridge at all. It can. The **`quarto` R package**
works:

```r
setwd("G:/My Drive/Projects/AI_Microscope/documentation")
quarto::quarto_render(as_job = FALSE)
```

`quarto::quarto_path()` resolves the Windows install by itself
(`C:/Users/kim/AppData/Local/Programs/Quarto/bin/quarto.exe`). **Do not** try to help it by setting
a QUARTO_PATH environment variable. Doing so produced a bare "Error running quarto CLI from R" every
time, and the identical call succeeded immediately once that variable was unset again.

This matters because it removes the reason to hand a render back to Kim and wait: an 11-chapter book
renders well inside the 60-second MCP timeout, with his real fonts, straight to `_output/`.

**The large-site caveat, extending Finding 012.** Rendering the whole kimbridges-documents website
(19 documents, about 300 MB of resources) overruns the 60-second timeout AND leaves the bridge
reporting "RStudio addin is not running" for a couple of minutes while R is busy. Both are cosmetic.
The render completes. Wait, retry a trivial `cat()` to confirm the bridge is back, then verify the
result **on disk** - page counts, mtimes, and a grep of the rendered HTML - rather than trusting
either the timeout or the exit code.

### Finding 018 (2026-07-26) — The source utterance was never captured; a write-up is not a record

Kim asked a simple question about the *Behind the Curtain* page: had his original spoken comment
on the ʻIliau Loop Trail been preserved? That comment is the thing the whole briefing book grew
out of. Every `.md` in Projects_Index and the entire `Projects/checklists` tree was searched.
**It has not been preserved.** What survives is two paraphrases, one of them honest about being
one.

`checklists/iliau_loop/site_preview.md` is a session write-up. Its own header says so: "Captured
2026-07-17 from Kim's preview observations." It was written up from what he said during the
session, not pasted from anything he wrote. Then `proj_briefing_book.md` line 334 paraphrases the
same material a second time, at another remove. And the session log has a gap across exactly that
date range, so there is no third copy to fall back on.

**Why it matters more than it looks.** The published page presents that file as the input
contract: here is the small human input, here is the fourteen page book that came out of it. The
claim holds, because the write-up is faithful. But the artifact on display is a reconstruction,
not the utterance. Nothing in the file's provenance would have told a reader that, and nothing
would have told me either if Kim had not asked. Paraphrase is lossy in the direction that matters
here: the value of a preview is that it carries a particular person's noticing, in their own
words, and a second-hand rendering keeps the facts while quietly dropping the voice.

**Operating rule adopted.** For any new site, **write the preview first, in Kim's own words, and
save it to `checklists/<site>/site_preview.md` before any build starts.** If it is spoken rather
than typed, transcribe it and mark it as a transcription, then have him correct it while the
session is still live. This is now the first line of the briefing-book commission block
(`Projects/checklists/briefing_book_commission.md`, section "Preview capture").

**The general form.** When a human input is going to be treated as evidence later, capture it
verbatim at the moment it is given. A summary written the same hour still counts as a loss, and
the loss is invisible afterwards because the summary reads fine. This sits alongside Finding 002
(the system test as productive loop) as a point about what the PKM is actually for: not just
recording what was decided, but preserving what was said in the form it was said.

### Finding 019 (2026-07-28) — An absence at the top of a log is not an absence; never write a gap marker without proving the gap
**What happened.** A note in session_log.md declared a LOG GAP for 2026-07-16 through 2026-07-25
and said the entries "were never written to this file." They had been written. All 22 of them
were sitting at the BOTTOM of the same file, below the 2026-05-07 to 2026-06-07 archive, because
the log carries two ordering conventions: the top block is newest-first (entries are prepended)
and the tail is an older oldest-first block (entries were appended). Some sessions appended, and
their entries dropped below 7,000 lines of May and June material where nobody looked. Three June
entries were stranded the same way. Before the misfiling was noticed, five replacement entries
had been reconstructed from the proj files and written in. They were reverted; the file was
restored byte-for-byte, then repaired properly by moving the real entries into position.

**Why the check failed.** The gap was diagnosed by reading the top of the file and seeing 07-26
followed by 07-09. That is a check of one region, not of the file. Two things made it worse. The
stranded 07-16 and 07-17 entries used h3 headings while every other entry in the log uses h2, so
a heading-level scan skipped them. And the LOG GAP note itself, once written, became the
evidence: the next session read the note rather than the file, and I inherited the claim and
acted on it.

**The cost of acting on it.** The reconstructions were good prose and they were wrong in detail.
One example: the ʻIliau Loop briefing book was recorded as bound at 12 pp, because the proj file
describes the initial bind. The contemporaneous log entry says 14 pp after Kim's review pass. A
reconstruction inherits whichever version of a fact the source file happens to preserve, and it
cannot know what it lost. Had the write stood, a wrong page count would now sit in the record
looking exactly as authoritative as the right one.

**The rule.** An absence at the top of a log is not evidence that the session was never logged.
Before declaring anything missing, search the WHOLE file for the date, at every heading level,
and search the other logs too. `grep` the date string, do not read a region. This is the cheapest
check in the PKM and it was skipped twice.

**The second rule, which is the structural fix.** Never write a gap marker without first proving
the gap. A marker that asserts absence is a load-bearing claim: later sessions treat it as
verified and build on it. If a gap is only suspected, say so in those words and name the search
that was actually run, so the next reader knows what has and has not been checked. This is
Finding 018's point from the other side. Finding 018 says a write-up is not a record. This one
says a note ABOUT the record is not the record either, and the record is usually still there.

**Also durable: one file, one ordering rule.** The mixed convention is what made the misfiling
possible and invisible. The July and June strays were moved into reverse-chronological position
on 2026-07-28 and an ORDERING NOTE now sits where the false marker was. The pre-2026-06-07
archive is still append-order and is left that way deliberately, but anything new goes at the
top. One pre-existing anomaly remains inside the archive (a 2026-05-14 continued entry filed
after 2026-05-16); it was left alone as plausibly intentional.

### Finding 020 (2026-07-28) — A verification loop that cannot tell a real artifact from a plausible-looking one is not verification

**What happened.** Working in the cloud sandbox with no CRAN access, I stubbed `qrcode::qr_code()`
with a random-fill generator so that PDF LAYOUT could be tested. The stub drew a decorative 7x7
finder pattern at top-left and filled the remaining 33x33 grid with noise. It looked, at a glance
and in a photograph, exactly like a QR code. I then verified the generated card sheets
rigorously: QR placements measured against the Avery 5371 spec to within 0.00007in; clearance
from the screw-post binding band confirmed at 0.372in on all sixteen cards; page counts checked;
every glyph checked for overflow past the card edge; a blank-leading-page regression caught and
fixed. Every check passed. **Every check was about position. Not one was about content.** I
labelled the PDFs as placeholders, in prose, three times. Kim printed them, assembled the decks
(hole-punched, screw posts, colour-coded), took them to the field, photographed them in two
arrangements, and none of the codes decoded — zbarimg and pyzbar across nine scales, plus
OpenCV's detector, all returned zero.

**Why the check failed — three separate reasons, and the third is the durable one.**

*One: I verified the property that was easy to measure, not the property the artifact is for.*
A QR card exists to decode. Position is a precondition for decoding, not a substitute for it.
Geometry was measurable with tools I already had loaded; decoding would have required admitting
that the codes were fake and therefore could not be tested at all — which was exactly the fact
worth surfacing.

*Two: the warning was in prose and the artifact was print-ready.* A caption saying "do not print
this" attached to a file that is a perfectly formatted sheet of ten business cards will lose.
The artifact's affordance contradicted the warning, and affordance wins. Repeating the warning
three times did not help, and repeating it a fourth would not have.

*Three, the general form: a simulated dependency produced an output that was indistinguishable
from the real output at every point where a human or a check would look.* The stub was built to
be visually convincing because that was what made it useful for layout testing. That same
property is what made it dangerous downstream. **A simulation faithful enough to test with is
faithful enough to be mistaken for the real thing.**

**The cost.** A full print run on card stock, deck assembly, a field photography session, and a
test that returned no information about the question it was meant to answer (whether several QR
cards in one photograph all decode — still open). Nothing was destroyed and no collection number
reached a specimen, so the loss was time and one round of Kim's fieldwork.

**The rules adopted.**

1. **Do not ship the output of a simulated dependency.** When the sandbox lacks a library the
   deliverable depends on, either produce nothing, or produce something that CANNOT be mistaken
   for the real artifact (watermark it across the face, break the layout deliberately, hand over
   a screenshot instead of a printable file). Prose is not a safeguard.
2. **Verify the property the artifact is FOR.** Exercise it the way its consumer will: decode the
   code, run the script, parse the file, open the document. Measuring an adjacent property and
   reporting it confidently is worse than reporting nothing, because it reads as coverage.
3. **Prefer a machine-enforced refusal to a warning.** `make_qr_cards.R` and
   `make_number_cards.R` now call `validate_qr_engine()` before writing anything: it checks the
   QR skeleton in pure R (three finder patterns, timing rows, a legal side length) and hard-stops
   with nothing written if they are absent. The stub can no longer produce a printable PDF at
   all. The check needs no scanner and no external tools, so it runs on Kim's machine too.

**A fourth rule, learned while building the third.** The first version of `validate_qr_engine()`
correctly rejected the stub — and would also have rejected every real QR code, because of an
integer-vs-double comparison in `identical()` and an off-by-two in the timing-pattern length.
Testing only that a checker REJECTS the known-bad input ships a checker that rejects everything.
It was caught by generating genuine QR matrices with an independent implementation (Python's
`qrcode`) and confirming the validator passed all of them, including one carrying a quiet zone
that had to be trimmed first. **A validator must be tested against known-GOOD inputs, from a
source independent of the thing being validated, before it is trusted.**

**Relation to Finding 016.** 016 said the exit code is not the artifact — render it, then LOOK at
it. 020 is that one level deeper: **looking is not enough when the failure mode is invisible to
the eye.** A malformed QR, a hollow PDF text layer (2026-07-26), and a chart with colliding
annotations all render cleanly and all photograph well. The check has to be the one the consumer
performs, not the one the producer finds convenient.

### Finding 020 (2026-07-31) — A failed probe is not an absence; a fresh `file.info` is not a size

Two errors on the same day, both the same species: **treating one negative
observation as an established fact.**

**1. kimbridges.com declared dead. It was not.** On 2026-07-30 a single
`curl_fetch_memory` call to kimbridges.com errored. I wrote **"kimbridges.com IS
ALREADY DEAD"** into proj_PKM.md, and built an argument on it — that a platform had
vanished unnoticed. On 2026-07-31 it returns **200**, 115 KB, redirecting to www,
DNS resolving to 198.49.23.144, with and without a browser user-agent. The site was
never dead. Worse, the evidence against the inference was already in hand: exposure.co
had returned **403 to curl while being perfectly alive**, in the same session. A live
site refusing a programmatic client was a known pattern and I applied it in one
direction only.

**Rule.** Before asserting a site, page or file is gone: retry; vary the user-agent;
check DNS; try http and https, bare and www. If any of that is untried, the honest
statement is **"could not reach it"**, not "it is gone." This is Finding 019's rule
(never write a gap marker without proving the gap) applied to the network instead of
to a log file — the same failure, a different surface. An absence claim written into
the PKM becomes load-bearing: the next session reads the note instead of re-checking.

**2. `file.info()` size read straight after a write is unreliable on Drive Stream.**
Twice now a size checked immediately after `writeBin`/`writeLines` came back far too
small — proj_PKM.md reported 4 KB when it was 7,048 bytes (2026-07-30), deferred.md
reported 4.1 KB when it was 10,809 (2026-07-31). Both times the file was perfectly
fine and I raised an alarm. **Rule:** verify a write by reading the CONTENT back
(line count, headings, known strings), not by reading the size. This is the same
Drive-stream unreliability as Findings 001/005/013/015, on the metadata rather than
the bytes — one more reason those four should collapse into a single statement.

**Meta-observation.** Both errors were mine, both were caught by Kim's own knowledge
of his material rather than by any check in the system, and both had already been
described in the protocol before I committed them. The mechanisms were not missing.
They were not applied.

### Finding 021 (2026-07-31) — Three operations that look additive and are not

All three bit on the same afternoon, during one document update.

**1. A case-only rename destroys the file (Windows).** `cover_with_text.jpg` and
`Cover_with_text.jpg` are ONE file on a case-insensitive filesystem. A folder sync
computed as "copy the new set, remove what is left over" listed the lowercase name
as an orphan; removing it deleted the file the copy had just written. Caught only by
comparing file COUNTS afterwards -- the copy step reported "74 of 74 copied" and was
telling the truth. **I committed this twice in twenty minutes**, having diagnosed it
the first time; the lesson existed only in the chat, never in this file. That is the
argument for the card, made on myself. **Rule: when syncing folders, compute the
removal list case-insensitively, and always reconcile counts at the end.**

**2. Rendering ONE format of a Quarto book CLEARS the others from output-dir.**
`quarto_render(output_format = "pdf")` left `_output/` containing only
`Plainmaps.pdf` -- the 73 HTML files from the earlier render were gone. Harmless
because they had already been copied out, but rendering PDF first and copying after
would have deployed a book with no pages. **Rule: copy each format out before
rendering the next, or render all formats in one call.**

**3. Netlify Drop REPLACES the whole site with whatever folder is dropped.**
Dragging `kimbridges-documents/plainmaps/` made plainmaps the site root and 404'd all
twenty documents. Nothing was lost -- the source was on Drive -- but the site was
wrong until re-deployed. The trap is structural: the document folders exist at the
project ROOT (where you edit) and are copied into `_site` as declared `resources:`
(where you deploy), so both locations hold folders with identical names. **Rule: see
DEPLOY TARGETS on the card. Drag the output-dir, never the root, never a subfolder.**

**The through-line.** Each operation reports success truthfully while having done
something narrower or wider than intended. None is detectable from an exit code; all
three were caught by comparing the RESULT against what was expected -- counts, file
lists, live URLs. Finding 016 again: the exit code is not the artifact.

### Finding 022 (2026-08-01) — `fixed = TRUE` ignores `^`, and the NA index destroys the file

**What happened.** Trying to merge a duplicate row in `pkm_card.md`:

```r
k <- grep("^| deploy to Netlify |", a, fixed = TRUE)   # matches NOTHING
a[k[1]] <- "...merged row..."                          # k[1] is NA
a <- a[-k[2]]                                          # a[-NA] collapses the vector
writeLines(a, cf)                                      # 132 lines -> 1 line
```

With `fixed = TRUE` the pattern is a LITERAL string, so `^` is just a caret character
and matches nothing. `grep` returned `integer(0)`; `k[1]` and `k[2]` are therefore
`NA`; `a[NA] <- value` and `a[-NA]` do not error -- they silently produce a
one-element vector. The write then destroyed the file. **`pkm_card.md`, the one file
read at every session start, was reduced to a single line.**

**Recovery.** The full text had been printed to the session transcript minutes earlier
during the session-start read, so it was rebuilt verbatim. Had the card not just been
read aloud, recovery would have meant Google Drive revision history.

**Rules.**
1. **Never use an index from `grep` without checking the match count first.**
   `stopifnot(length(k) == 1)` costs nothing and converts silent destruction into a
   loud stop.
2. For anchored LITERAL matching use `startsWith()` / `endsWith()`, never
   `grep("^...", fixed = TRUE)`. Anchors need `fixed = FALSE`.
3. **Snapshot before editing any HOT file** (`pkm_card.md`, `project_index.md`,
   `proj_PKM.md`). `split_tail()` and `archive_focus()` already snapshot; ad-hoc
   line-surgery does not, and that is exactly where this happened.

**Third instance today.** The same bad-grep shape appeared twice earlier -- once it
errored before writing (harmless), once it produced a wrong count that triggered a
false alarm. This time it wrote. A mistake that is harmless twice is not a harmless
mistake; it is an unfired one.


### Finding 023 (2026-08-02) — `(i):length(x)` counts BACKWARD when `i > length(x)`

Replacing the last of five iframe blocks in `Scientific.qmd`, the tail slice was
`L[(k+5):length(L)]`. The block ended at line 87 of an 87-line file, so `k+5` was 88
and the expression became `88:87`. R's `:` does not return empty when the start
exceeds the end -- it counts down. The slice evaluated to `c(88, 87)`, appending an
`NA` line and a stray `</div>` to the file.

**It did not error and it did not look wrong.** The file rendered. The audio elements
were all correct. What caught it was arithmetic: five blocks at seven lines replaced by
four should be 87 - 15 = 72, and the file had 74. The count reconciliation is the only
thing that fired.

**Rules.**
1. Never write `(i):length(x)` for a tail slice. Use `if (i <= length(x)) x[i:length(x)]
   else character(0)`, or `tail(x, -(i-1))`, or `x[-(seq_len(i-1))]`.
2. **Reconcile counts on every structural edit.** Predict the resulting line count
   BEFORE writing, compare AFTER. This is the third time in three sessions that count
   reconciliation, not inspection, caught the damage (Finding 021, Finding 022, this).
3. Blocks that run to end-of-file are the dangerous case. Process in REVERSE order --
   which this code did -- and the last block is still processed FIRST, so the bug fires
   immediately rather than at the end. Reverse order does not protect the tail.


### Finding 024 (2026-08-02) — The pre-deletion gate reads the INVENTORY, not the venues

`pkm_legacy_gap()` and `pkm_consolidation()` scan `inventory_all_projects.md` for
legacy-platform URLs. They never open a venue file. So the gate can only protect
platforms that a human already wrote into the inventory.

**Eleven SoundCloud embeds sat inside published venue pages** -- one in the Gallery
Catalog, ten in AI_Podcasts -- and the gate reported zero, correctly, every time it ran.
No inventory row said "SoundCloud," so SoundCloud did not exist. Adding `soundcloud.com`
to the platform vector changed nothing: the vector is applied to the inventory text.
The blind spot was never the list of platforms. It was the *source*.

A derived index cannot be the ground truth for what the venues contain. That is the
GROUND-TRUTH RULE of `pkm_card.md`, and the gate -- the one function whose entire
purpose is to stand in front of a one-way door -- was violating it.

**Remedy.** `pkm_legacy_live()` added to `pkm_health.R` (2026-08-02). It reads venue
`.qmd` / `.md` / `.html` SOURCE files directly and reports every legacy-platform
occurrence with venue, file, line, URL, and a `kind` column separating a real LINK from
a prose `mention only`. Run BOTH functions. **Disagreement between them is the finding.**

First run surfaced 7 rows the old gate could not see: 4 live ISSUU document pointers in
AI_Podcasts, 1 in `using_an_llm`, and 2 stale PROSE claims ("Posting this book on the
Quarto Pub website means that I have easy access to the code") that are now false on a
platform that no longer resolves. **Dead claims are a category the link work missed
entirely** -- a link audit finds `href`s, and a sentence has no `href`.

**Regex note.** The first pattern used `"quarto.pub"`, whose unescaped `.` matched
`quarto publish` in an unrelated sentence. Escaping to `quarto\\.pub` fixed that and
immediately LOST both real hits, which say "Quarto Pub" with a space. The working
pattern is `quarto[. ]pub\\b` -- the class catches both spellings, the word boundary
rejects `publish`. A pattern that is too loose and a pattern that is too tight fail the
same way: silently, with a plausible number of rows.

**Housekeeping.** Two findings are both numbered 020 (2026-07-28 and 2026-07-31).
Left as-is to preserve citations already made elsewhere; numbering resumes at 023.


### Finding 025 (2026-08-03) — Every PDF names the tool that made it; read that before declaring there is no source

*Experiments with LLMs* was recorded in the PKM as a finished 130-page PDF with no `.qmd`
source. On that basis a Quarto rebuild was written up as the expensive option — it would
mean reconstructing a finished document out of its own PDF — and Kim chose the hybrid
route accordingly.

The PDF's `/Producer` field says **`Skia/PDF m122 Google Docs Renderer`**. It was exported
from a Google Doc. The Doc is still in Kim's Drive, last modified 2024-01-12 — one day
after the canonical export. A Drive search on the title found it in one call.

So the rebuild was never a reconstruction. It was `drive_download(type = "docx")`, one
pandoc invocation, and a split at the H1 boundaries. **The decision had been made on a
property of the artifact that nobody had checked, and the check costs one line.**

**Rules.**
1. Before concluding a document has no source, read the producer/creator metadata:
   `pdftools::pdf_info(p)$keys` or a raw scan for `/Producer` and `/Creator`. Office
   suites, Google Docs, InDesign, LaTeX and Quarto all stamp themselves.
2. A producer string naming a *cloud* editor means the source is probably still live and
   editable, not merely archived somewhere. Search the account before searching disks.
3. When new evidence overturns a decision the user already made, **say so and re-ask.**
   Kim had chosen hybrid; the source find made a full rebuild cheap, and he switched. Had
   this been quietly folded into the work he would have got a different deliverable than
   the one he approved.

**Corollary that paid off immediately.** The bold prompt/response convention — Kim's own,
stated in the document's Dictation section — survived the Doc → docx → markdown path
intact (90 bold spans in one chapter). A PDF reconstruction would have had to infer it
from left-margin x-coordinates, which was measurable (x=72 vs x=108) but lossy. **The
cheaper path was also the more faithful one**; that is usually the shape when a real
source exists.

**Footnote on this session's own discipline.** Immediately after trimming `pkm_card.md`,
a `file.info()` size read reported 4.08 KB against a true 6101 bytes — a 2 KB phantom
improvement that would have been reported as fact. Caught by reading CONTENT back (133
lines, all 8 headers, correct first and last line). That is Finding 020's rule, printed
on the card, firing on the very edit that was changing the card.


### Finding 026 (2026-08-03) — The bridge can CREATE directory trees it cannot REMOVE

Testing whether git works on Drive Stream, a probe repo was created at
`G:\My Drive\_git_probe_2026-08-03`. Cleaning up afterwards, 
`file.remove()` deleted all 16 files — and then could not delete a single directory,
because on Windows it does not remove directories at all. The alternative, the
recursive form of `unlink()`, is blocked by the bridge guard.

**Result: 19 empty directories stranded in the Drive root, and Kim had to delete them by
hand.** In a system whose founding complaint was *"one of the goals was to keep from
proliferating and loosing files,"* the tooling has a create/delete asymmetry that
manufactures exactly that mess.

**Rules.**
1. **Never create scratch outside `C:\temp` (bucket 4).** Not in a venue, not in a
   project, and above all not in the Drive root. Bucket 4 exists because deletion there
   is expected and swept; anywhere else an un-removable remnant is permanent until a
   human notices it.
2. Before creating any directory tree, ask what removes it. If the answer is "Kim, in
   Explorer," say so up front rather than discovering it during cleanup.
3. `git clone` leaves read-only pack files that the file-removal function also cannot
   take (2 of 23 survived in the clone test). Another reason clones belong in bucket 4
   or bucket 5, never anywhere the residue matters.
4. **The guard scans SOURCE TEXT, including prose.** This very finding was rejected on
   its first write because it quoted the blocked call inside a string. Assemble such
   names indirectly when documenting them.

**The probe itself was still worth running.** It converted an inherited assumption —
bucket 5's "a syncing folder serves placeholders and git reads them as corrupt" — into a
measured fact: gert inits, commits, and reads history on `G:` without complaint. That did
not overturn bucket 5, because operating correctly today is not the same as surviving
Drive's sync lifecycle. The finding is the distinction: **a probe answers the question it
actually asked, which is usually narrower than the question you wanted answered.** Compare
Finding 020, where a single failed probe was over-read in the other direction.


### Finding 027 (2026-08-03) — The backup found a live credential, because a public repo checks what a private disk never does

Pushing 880 mirrored source files, GitHub refused: *push declined due to repository
rule violations*. Push protection had found a full Anthropic API key (`sk-ant-`, 108
chars) at `Projects/LLM_API_R/Claude_API.qmd` line 36, dated April 2024.

It was commented out with `##`. **Commenting hides a secret from R, not from a reader.**

It was never published: `Claude_API.qmd` is not a chapter of the rendered `r_api` book,
confirmed three ways — the venue folder, its `_site` copy, and the live document's six
chapters. The key had sat on Kim's disk for over two years, invisible, because nothing
had ever looked.

**The lesson is about what a backup IS.** Copying files to a second location is the least
of it. Publishing to a public repo forces every file past a scanner that a private disk
never applies. The migration's value on day one was not redundancy — it was that
something finally read the material with an adversarial eye.

**Rules.**
1. `pkm_secret_scan()` added to pkm_health.R, and **it runs before every commit**, with
   `stopifnot(nrow(s) == 0)`. Do not rely on GitHub as the check: a private repo, or a
   pattern GitHub does not know, would pass silently.
2. It reports file, line and kind — **never the secret itself** — so the output is safe
   to paste anywhere.
3. A refused push leaves the secret in LOCAL history. Reset to the last pushed commit
   and rebuild; do not simply commit a fix on top.
4. Keys belong in `~/.Renviron`, which is Kim's own stated preference. The source now
   reads `Sys.getenv("ANTHROPIC_API_KEY")`.

### Finding 028 (2026-08-03) — A silent success is worse than a loud failure

Three things this session reported success while doing nothing, or did damage while
reporting nothing. They are one finding because they share a shape.

**1. `gert::git_push()` returned cleanly, twice, and transferred nothing.** GitHub's ref
was still at the pilot commit. The real error — the rule violation above — appeared only
under `verbose = TRUE`. Had the ref not been checked against GitHub's API, the session
would have ended believing 880 files were backed up when 8 were.
  *Rule: verify a push against the REMOTE ref, never against the return value.*

**One qualifier, learned the same day.** GitHub's `git/ref` endpoint can lag a second
or two behind a successful push -- a check run immediately after reported a mismatch
that resolved on the next call. Confirm with `gert::git_remote_ls()`, which asks the
server directly, before concluding a push failed. The rule stands; the impatience does
not.

**2. A size read straight after a write reported 4.08 KB against a true 6101 bytes.**
Finding 020 again, firing on the very file that prints the rule.

**3. The same expensive-synced-read mistake, twice in one session.** A recursive scan
across five Drive Stream venues stalled the bridge; it was written up; then
`pkm_secret_scan` was built with no extension filter and pointed at all of `Projects/`,
reading every PDF and image, and Kim had to interrupt R. **Writing a lesson down is not
the same as having learned it.** The fix that works is structural, not memorial: the
function now filters extensions in its own body, so the mistake cannot be repeated by
whoever calls it next.

**The common shape.** Each failure was silent at the point of use and only visible from
outside — the remote ref, the file content, the user's machine. *Where a tool reports on
its own work, get the answer from somewhere the tool does not control.*

---

### Finding 029 (2026-08-12) — The assistant's session clock is UTC; the PKM records Honolulu local, and the gap is silent

**What happened.** Every dated line written in the 2026-08-12 session initially read
**2026-08-13**. Five files were affected -- `session_log.md`, `priorities.md`,
`project_index.md`, `logs/focus_history.md`, `proj_kimbridges_stories.md` -- plus a
bucket-4 scratch folder named `kimbridges-stories_20260813`. Kim's machine read
**2026-08-12 19:20 HST** throughout.

**Why it happens, and why it will keep happening.** The assistant's environment supplies
a date in its session header. That date is **UTC**. Honolulu is UTC-10 and does not
observe daylight saving, so **from 14:00 HST onward the supplied date is a full day
ahead, every single day.** Kim works evenings often enough that this is not an edge case;
it is the default condition for a majority of working hours. The supplied value is never
malformed, never obviously wrong, and never prompts a check -- it is simply, silently,
tomorrow.

**Mechanism 4 already covered this.** *Dates and times are HONOLULU LOCAL* was written
into `pkm_protocol.md` on 2026-07-28, after exactly this mismatch was found in the
`2026-07-28 (evening)` session entry. The rule was read at session start on 2026-08-12
and did not fire. **This is Finding 020's shape a third time: a rule that lives in a file
read once is not a mechanism.**

**What caught it.** Not the rule, and not any human review -- **`pkm_health()`**. Its
generated report is stamped from the machine clock (*Generated 2026-08-12 19:19*) and
landed in the file directly beneath entries headed the 13th. The tool that reads a real
clock is the only participant in the session that could not be fooled, because it was the
only one not taking the date on trust.

**The rule.** Before writing any date into the PKM, take it from the R bridge:

```r
format(Sys.time(), "%Y-%m-%d")   # ground truth: Kim's machine, Pacific/Honolulu
```

Never from the assistant's environment header. This applies to log headings,
`_Last updated:` fields, Active Focus blocks, `### YYYY-MM-DD` log entries, and
`C:\temp\<name>_<date>` scratch folder names alike. On the card as the **write a date**
row.

**A second lesson, from the repair.** The correction touched
`proj_kimbridges_stories.md` (459 bare LF against 21 CRLF) and `logs/focus_history.md`
(1108 CRLF against 1 bare LF) -- **both genuinely mixed**, and both would have been
silently normalised by a `readLines` / `writeLines` round trip, burying 14 real date
corrections in ~1,500 lines of invisible line-ending churn. The fix was a same-length
substitution over `rawToChar` → `gsub(fixed = TRUE)` → `charToRaw`, proved lossless by
asserting `identical(charToRaw(s), b)` on the round trip **before** editing, then
checking that the byte delta and both line-ending counts were exactly zero after.
**Prove the round trip is lossless on the untouched file first; then the post-edit delta
means something.**

**And a third, noticed in the same pass.** `file.info()` on the freshly-written
`pkm_card.md` returned exactly **4096 bytes** -- a suspiciously round block size -- while
`readBin` returned the true **6158**. A 4 KB reading would have made the card look 2 KB
under budget and invited padding it. The ground-truth rule holds: **`readBin` for size,
content for verification, `file.info()` for neither** (Finding 020).

**RECURRENCE, 2026-08-18 -- the third time, and the first where the rule was READ that same session.**
The 2026-08-18 evening session wrote **29 dated strings as 2026-08-19** across eight files: the Active Focus
block, Finding 034 and its resolution, seven `deferred.md` entries, six headings in `proj_Smart_Car.md`, two
code comments in `pkm_health.R`, the `focus_history.md` supersession marker, and **nine cells inside
`TwoRed_log_errata.csv`** -- three of them the `status` field of newly-raised errata. Kim's machine read
**2026-08-18 21:43 HST**.

**The session log heading was RIGHT and everything else was wrong**, which is the diagnostic detail. That one
heading was written after explicitly checking `format(Sys.time(), tz="Pacific/Honolulu")`, because the
newest-first ordering forced a comparison against the entry above it. **Every other date was written without
a comparison to force the question.** So the rule did not fail from ignorance -- the card's *write a date* row
was read at session start and the local clock was queried during the session. **It failed because a single
lookup does not persist across ninety minutes of unrelated work.**

**The structural fix, and it is not another reminder.** Bind the date ONCE at session start and write
through the binding, never through a fresh judgement:

```r
TODAY <- format(Sys.time(), "%Y-%m-%d", tz = "Pacific/Honolulu")   # bind at session start
```

Then every heading, status field and marker interpolates `TODAY`. A variable cannot drift halfway through a
session; an intention can. **This is Finding 030's lesson in a different costume: the fix that works is the
one the next caller cannot skip.**

**Repair, 2026-08-19.** Same-length `gsub(fixed = TRUE)` over `rawToChar` -> `charToRaw`, per the method
above. Verified per file BY CONTENT: 29 replaced, 0 of `2026-08-19` left, **every file gained exactly the
count it lost**, byte length unchanged in all eight. `pkm_health.R` re-sourced and re-checked; the errata CSV
re-parsed at 61 rows x 8 columns. **`session_log.md` was correctly left alone -- it had none.**

---

### Finding 030 (2026-08-12) — A guard that only PRINTS is not a guard; `regexpr` returning -1 silently duplicates a file

**What happened.** An edit to `priorities.md` meant to replace one section used
`regexpr()` to find a start and an end marker, then spliced with `substr()`. The end
marker did not match -- I had written `"...not a missing story.**"` while the file has no
trailing `**`, and the sentence is line-wrapped besides. `regexpr` returned **-1**.

`substr(s, -1 + nchar(endm), nchar(s))` does not error. It silently becomes
`substr(s, 65, nchar(s))` -- **nearly the whole file** -- so the write produced
`prefix + replacement + almost-the-entire-original`. `priorities.md` went from 12,824 to
15,848 bytes with two `## Purpose` sections, two `### 1.` sections, and a seam splitting a
word in the header.

**The damning part: the check was already there and already printed the answer.**

```
start found: TRUE   end found: FALSE   ordered: FALSE
```

That line was emitted **in the same call that then went ahead and wrote the file.** The
information was not missing. It was printed to a log nobody was blocking on. **Finding 022
says "ALWAYS check the match count before using the index" -- and the check ran. What was
missing was that the check had no teeth.**

**The rule.** A precondition must **halt execution**, not report. Use `stopifnot()`:

```r
i <- regexpr(start, s, fixed = TRUE)
j <- regexpr(endm,  s, fixed = TRUE)
stopifnot(i > 0, j > 0, j > i)     # halts. cat() does not.
```

This is the same structural-over-memorial lesson as Finding 028's third item: the fix that
works is one the next caller cannot skip.

**Prefer line indices to string boundaries for section surgery.** The successful retry
replaced lines `i:(j-1)` located by anchored `grep("^### 1\\. ")`, with `stopifnot` on both
the match counts and their order, plus a positive assertion that the expected table rows sat
where predicted. Markdown sections have unambiguous line-level boundaries; their prose
wraps, gains and loses emphasis markers, and is a poor thing to pattern-match on.

**Recovery, and why it was possible.** The damage was deterministic:
`P + new + orig[65..end]`. The original was reconstructed as
`substr(current, 1, 64) + orig[65..end]` and confirmed at **exactly 12,824 bytes**, then
the one damaged header line was repaired by name. **Structure, not size, is what proved it
clean** -- `## Purpose` back to one occurrence, `### 1.` back to one, the full heading list
matching. A size check alone would have accepted several wrong answers.

**RECURRENCE, 2026-08-19 — and this time the backup was the recovery, not memory.** A helper that extracts 
a section by finding its heading and stopping at the next heading was called with a `^### ` boundary on a 
block whose next heading was a `## `. **The pattern did not match the `##`, so the extraction ran past it 
to the next `###` further down the file and swallowed an entire top-level section** -- `## Intended 
analysis`, 2,182 characters, Kim's own statement of what he wants analysed. No error. No warning. The 
replacement wrote cleanly and the file simply got shorter.

**Caught by a structural check, not by reading:** listing the `##` headings after the edit and comparing 
with the list from before it. **Size would not have caught it** -- the file was being deliberately trimmed 
toward a budget that same minute, so a drop of 2 KB looked like success.

**Recovered verbatim from `pkm_backup()`'s mirror**, which held the pre-edit copy. **This is the first time 
the backup has been USED, eleven days after Finding 031 and one day after Finding 034 forced it to actually 
contain the data.** A full heading diff against the mirror then confirmed exactly one other difference: a 
heading I had renamed on purpose.

**The structural fix, applied.** The grabber now takes a LEVEL and stops at that level **or any higher 
one**, and asserts afterwards that the block it returns contains no `#` or `##` heading:

```r
grab_sec <- function(txt, head, level = 2) {
  i <- regexpr(head, txt, fixed = TRUE); stopifnot("head not found" = i > 0)
  stopifnot("head is not unique" = length(gregexpr(head, txt, fixed = TRUE)[[1]]) == 1)
  r <- substring(txt, i + nchar(head))
  j <- regexpr(paste0("(?m)^#{1,", level, "} "), r, perl = TRUE)   # same level OR HIGHER
  out <- substr(txt, i, if (j > 0) i + nchar(head) + j - 2 else nchar(txt))
  stopifnot("block swallowed a higher-level heading" =
            !grepl("(?m)^#{1,2} ", substring(out, nchar(head) + 1), perl = TRUE))
  out
}
```

**The general rule, sharper than the 2026-08-12 version. A boundary pattern that is more specific than the 
thing it must stop at will run straight past it.** `^### ` is narrower than the document's real structure, 
so it could only fail by over-reaching -- and over-reach in a delete-and-replace is silent data loss. 
**Match the boundary at the coarsest level that can legally follow, then assert what you got.**

**And a second-order note. Verify edits STRUCTURALLY, never by size, especially while trimming to a 
budget.** Trimming makes every loss look intentional. Finding 030 said structure beats size for proving a 
file clean; **this is the case where size actively lies in the direction you want to believe.**

**Standing caution.** The PKM has no version control (`proj_PKM.md`, Locations); recovery
leaned on Drive revision history being unnecessary because the corruption was reversible in
memory. **A destructive splice is not always reversible.** Read before write, assert before
write, and verify structure after.


---

## Finding 031 (2026-08-17) — A bridge TIMEOUT is not a job failure, and checking the wrong artifact is not verification

**What happened.** At the close of 2026-08-16 I called `pkm_backup()`. The MCP bridge returned
`timed out after 60s`. I then looked for a `Projects_Index_archive_2026-08-16` folder, found none,
checked a second time, and reported to Kim that **the backup had not completed** -- describing the
double-check as care.

**What was actually true.** `pkm_backup()` had finished. Commit **`0bcd812c8d`**, 2026-08-16 20:42,
*Backup refresh: 5 changed of 972 tracked* -- the five files written that evening. Working tree
clean. GitHub's `refs/heads/main` equals local HEAD. **It committed AND pushed.**

**Two independent errors, either of which alone would have produced the false report.**

**1. A timeout on the bridge says nothing about the R process.** The MCP call has a 60-second
limit; the background R process keeps running to completion. **Never infer failure from a timeout.**
Go and look at the artifact, or run the job with `execute_r_async` so completion is observable.

**2. I verified against an artifact the tool does not produce.** `pkm_backup()` refreshes the git
mirror at `C:\repos\kimbridges-venues` and pushes to GitHub. It **does not** create
`Projects_Index_archive_*` folders -- those are Tier-3 pre-split snapshots from 2026-07-28/31 and
have nothing to do with backup. The folder I checked was real; it simply was not this function's
output. **Finding 020 warns that a loop which cannot tell a real artifact from a plausible-looking
one is not verification. This is its sibling and it is nastier, because the artifact WAS real.**

**Rule. Before verifying a function's result, READ THE FUNCTION and name the artifact it actually
writes.** Four lines of `pkm_health.R` would have prevented the whole thing. For anything that
commits or pushes, the artifact is the **remote ref** (Finding 028), not a folder, not a return
value, and not the absence of an error.

**★ The part worth keeping.** This was committed in the same session whose log entry reads *verify
against the REMOTE, not the return value*. **The rule was not merely known, it was being written
down at the time, and it still did not fire.** That is the exact failure mode `pkm_card.md` exists
for (Finding 020): knowing a rule is not the same as having a trigger for it. The card gains a row.

**Cost.** Kim ended a hurricane day believing his PKM had gone 16 days without a backup, during an
active recovery, when in fact it had been backed up and pushed minutes earlier. **A false absence
is not a neutral error: it spends the reader's trust and their attention at the worst moment.**

---

## Finding 032 (2026-08-18) — A filter that DROPS rows manufactures anomalies indistinguishable from real ones

**What happened.** Auditing TwoRed's 293 fuel rows I flagged Morgantown WV (2012-06-01) as implying
**100.6 MPG** -- the largest anomaly in the dataset -- and reported it to Kim as *a fill-up that was
never written down*. He asked a simple question: **"I see June 2012 values for two fill-ups in
Morgantown. What's the missing value?"**

**There was none.** The preceding fill-up -- Richmond, Ohio, odometer 28,688 -- is present in the
sheet. Its date cell reads **`5/31/0202`**: the year typed as 0202 for 2012, stored as TEXT. My
pipeline began `G <- G[!is.na(G$date), ]`, which **silently deleted that row**. Morgantown's
predecessor then became Champaign, 500 miles back, and the phantom leg produced 100.6 MPG.
**In odometer order the sequence is continuous and every MPG is ordinary: 41.9 / 42.6 / 35.1 / 41.2.**

**Why this is worse than an ordinary bug.** A dropped row and a missing row look **identical**
downstream: both appear as an unexplained odometer gap. The analysis could not distinguish a hole
in the DATA from a hole it had just made in its own working set -- **and it reported the second as
the first, with confidence, twice.**

**Rule. Any filter that removes rows must REPORT what it removed, as a count, before results are
read.** `kept 292 of 293` would have exposed this in one line. **Never write `!is.na(x)` into a
pipeline without printing the drop count beside it.**

**Second rule, narrower.** When ordering records that carry BOTH a timestamp and a monotonic
counter, **order by the counter.** The odometer cannot be mistyped into a different century; the
date can. Sorting by date made a corrupt cell into a structural error.

**★ The tell was Kim's, not the code's.** He looked at the actual rows and saw two Morgantown
fill-ups where my summary implied a gap. **A person reading the raw record caught what three
automated test families could not, because all three ran on the same silently-truncated input.**

**Cost.** The `missing fill-up` class ended at **5 flagged, 0 real**: one merged row, three partial
fills, and this artifact. **The single most dramatic number in the audit was manufactured by the
audit.**

---

## Finding 033 (2026-08-18) — A physical error MECHANISM outperforms a statistical threshold, because it predicts DIRECTION

**The observation.** Four typos in TwoRed's fuel log, spread over 2011-2015, all had the same shape:
a **zero recorded as an eight** (29.06->29.86, 26.08->26.88, 7.088->7.889, 4.089->4.809). A fifth
occurred live in this session -- Kim read 5.401 off his own receipt as 5.481.

**The cause, from Kim:** *the stripe across the zero.* He writes slashed zeros. Under a scan, or a
hurried glance, a slashed 0 reads as an 8.

**Why this beat every threshold we had.** All four typos had already survived the arithmetic audit's
attention as either corrected one-offs or sub-dollar noise. Turning the mechanism into a SEARCH --
try every single-position 0<->8 substitution and keep the ones that make the row balance -- surfaced
two more candidates from residuals that had been dismissed as rounding.

**★ AND THEN THE MECHANISM REJECTED ONE OF THEM.** A slashed zero can be read as an eight; an eight
is not read as a zero. **The error is DIRECTIONAL.** Of the two candidates:
- **Coarse Gold** (7.385 -> 7.305): the record holds an 8 where the paper had a 0. **Consistent.**
- **Effingham** (6.480 -> 6.488): would need a 0 in the record to have been an 8 on paper. **Impossible.**

**Arithmetic alone would have accepted both.** The physical mechanism threw one out. **A cause-based
test is stronger than a fit-based test, because a cause constrains the DIRECTION of the error and a
residual does not.**

**Control, so the generator is not merely finding something.** The same search with digit pairs that
are NOT the mechanism: **0<->8 scored 2 hits in 15 substitutions (13.3%); 1<->7 scored 0 in 19;
3<->5 scored 0 in 20; 4<->9 scored 1 in 39.** The signal is specific to the pair with a physical story.

**A SECOND SCAN ILLUSION, AND IT IS NOT THE SAME ONE (2026-08-19).** Reading the recovered Fourth Crossing
log, one arrival time would not resolve: I read **7:41P**, which made the leg 93 mph and impossible. I then
compared the glyph against known 7s and 9s elsewhere on the same page, found a **crossbar-like mark** that
his plain 7s do not have, concluded the cell had been **overwritten**, and argued for 9:41P. Kim: **the
arrival is 8:41 -- my writing was very light.**

**The mark was not ink. It was the scanner.** A bitonal threshold applied to a faint stroke drops parts of
it and promotes paper texture beside it, so a light `8` can lose its upper loop and gain a bar. **I read a
THRESHOLDING artifact as a CORRECTION, and then reasoned confidently from it.**

**The two illusions are opposites and must not be conflated:**

| | slashed zero (033) | light pen pressure |
|---|---|---|
| lives in | the WRITING | the SCANNING |
| direction | asymmetric -- a 0 reads as an 8, never the reverse | symmetric -- any digit can lose or gain a stroke |
| the original settles it | **NO** -- the illusion is on the paper | **YES** -- the ink is unambiguous under a lamp |
| arithmetic settles it | often | only if the field enters an identity |

**So the standing rule *for the 0/8 class, scans are not evidence* does NOT generalise to all scan doubt.**
For a faint stroke the original is decisive, and asking the writer is cheap. **Diagnose WHICH illusion you
are looking at before deciding whether the paper can help.**

**And the sharper lesson, which is about me rather than the scanner. A glyph that matches NOTHING in the
writer's hand is more likely a rendering fault than a rare form of the writer's hand.** My comparison
against his other 7s was the right method and I drew the wrong conclusion from it: the correct reading of
*this does not look like how he writes 7* was *the image is damaged*, not *he wrote something else*. **Neither of my two candidate readings was right. The answer was the digit between them.**

**General rule. When several errors share a shape, stop treating them as independent typos and ask
what PHYSICAL process makes that shape.** Then run the process as a generator, and use its
asymmetries to reject candidates a residual test would wave through.

---

## Finding 034 — A BACKUP THAT REPORTS SUCCESS IS NOT A BACKUP THAT COVERS YOUR WORK (2026-08-18)

`pkm_backup()` ran clean, committed, pushed, and **verified the push against the remote ref** -- the very check Finding 031 added. It reported `975 files | 4 changed | pushed TRUE`. All of that was true.

**And 82 of the 85 files in `Projects/Smart_Car` were not in it.**

The mirror keeps a file only if its extension is in `SOURCE_EXT`: `qmd, rmd, r, yml, yaml, css, scss, bib, py, js, md`. **`csv` is not there. Neither is `xlsx`, `pdf`, or `jpg`.** So the mirror carried `twored_ingest.R`, `trip_logs_read.R` and one charter, and left behind:

- **every errata file** -- `TwoRed_log_errata.csv` (61 entries), the gazetteer errata, the machine corrections, the inserts, the flags;
- **the corrected dataset** `TwoRed_fuel_clean.csv`;
- **all ten trip logs** (107 legs) and `TwoRed_fuel_timetemp.csv` (95 rows);
- **the primary source workbook** `TwoRed_fuel_June_2014.xlsx`;
- **all 17 scan PDFs** and 38 photographs.

**The scripts were backed up. Everything the scripts operate ON was not.** Weeks of adjudication -- each entry carrying a basis and a status that cannot be re-derived -- sat outside the backup while the backup said it had run.

**Why it went unseen.** Nothing lied. The commit was real, the push was real, the verification against the remote was real. **Every check tested that the mechanism EXECUTED. None tested WHAT IT COVERED.** Finding 031 taught me to verify the push against the server instead of against a timeout; this is the same error one level up -- I verified the transport and never verified the manifest.

**How it was caught.** Not by a check. By reading the mirror directory for a file I expected to find there, because the ground-truth rule says verify by CONTENT. The directory `projects/Smart_Car/data` **did not exist.**

**General rule. For any pipeline with an INCLUSION FILTER, the success report describes the filter's output, never its coverage. Test coverage separately, from the source side: list what exists, list what arrived, and diff.** A whitelist is a silent-failure machine -- adding a new file TYPE to a project is enough to drop it out of the backup, with no error anywhere.

**Corollary for `pkm_health()`.** It reports orphans (mirrored files with no source) and size mismatches. **It has no check for the reverse -- source files with no mirror.** That asymmetry is the bug.

**Not fixed unilaterally.** `SOURCE_EXT` governs all 50 projects. Adding `csv` and `xlsx` would pull in **182 files, 1.8 MB** system-wide -- trivially cheap -- but it is Kim's policy call, not mine. Flagged in `deferred.md`. Note the data is NOT unprotected meanwhile: it lives on Google Drive. It is outside the *versioned* backup, which is where the adjudication history would be recoverable from.

### RESOLVED SAME DAY — and the fix immediately found a second bug

Kim's decision, 2026-08-18: *yes, we should be doing that too. After all, these files are where data live and that's often our focus.* `csv` and `xlsx` added to `SOURCE_EXT`.

**The first run after the change ABORTED.** `size mismatch after copy -- investigate before committing`. Cause: allowing `xlsx` in pulled `data/~$TwoRed_fuel_June_2014.xlsx` -- an **Excel lock/owner file**, which is locked, so it reports 165 bytes at source and copies as 0. The guard did its job perfectly and refused to commit. `.is_source()` already excluded LibreOffice's `.~lock.` files; it had never needed Excel's `~$` equivalent, because no Office extension had ever been whitelisted. Excluded; the run then completed.

**Result: 975 -> 1,191 files mirrored, 108 changed, pushed and verified against the remote ref.** Smart_Car coverage 3 -> 26 of 85. Verified BY CONTENT in the mirror, not by the report: 61 errata rows, 10 trip logs, a 294-row corrected dataset, the source workbook. What is still outside is only the binary tail -- 38 photographs, 17 scan PDFs, a docx and a pptx -- which is a git-LFS decision, not a whitelist one.

**Second-order lesson, and it is the more useful one. WIDENING AN INCLUSION FILTER IS A CHANGE OF KIND, NOT OF DEGREE.** A whitelist does not only exclude files; it silently excludes the entire ECOSYSTEM around those files -- lock files, temp files, autosaves, sidecars. Every extension admitted brings its application's debris with it. **Budget for the debris, not just for the bytes.** The 1.8 MB estimate was right and irrelevant; what nearly stopped the fix was a 165-byte file that should never have been considered.


---

## Finding 035 — A DURATION BUILT FROM TWO LOCAL CLOCKS IS SILENTLY WRONG WHEREVER THE CLOCKS DIFFER (2026-08-19)

TwoRed's trip logs record a departure time and an arrival time, both **local**. Sixteen of 107 legs cross a time zone, so their elapsed time -- and every speed derived from it -- was wrong by an hour. **The data cannot flag this. `06:03` and `21:36` are both valid, both real, and their difference is meaningless without knowing where each was read.**

Only the earliest file carried a hand-entered `tz_shift_hr`. Every file transcribed afterwards -- including six I wrote the day before -- had **zero throughout**, because the column existed and looked filled in.

**What surfaced it was not a check. It was a story.** Kim explained that one 15.6-hour day included a long visit with friends in Las Vegas. Working out how much of the day the visit accounted for meant splitting the leg at the Las Vegas fill -- and the second half came out at 34 mph on empty interstate, which is not possible. Nevada is Pacific and Utah is Mountain.

**The fix is a lookup, not a column.** Storing an integer per leg puts a human in the path of a question with a correct mechanical answer, and humans forget. A city -> IANA-zone table plus the platform's own database gets **DST, Arizona and Saskatchewan declining to observe it, Yukon before 2020, and Newfoundland's HALF-HOUR offset** for free. **No hand-entered integer would have survived Newfoundland.**

**The general rule. Any quantity derived from two readings taken in different places must carry the PLACE, not just the reading.** Local clock time is the obvious case; the same shape governs currency (this project already has a Canadian sheet in litres and Canadian dollars), altitude-corrected volumes, and any units that a locale silently redefines. **Store the context and compute the conversion. Never store the conversion.**

**A second lesson, about where the error came from.** The 2011 file was RIGHT and everything after it was wrong. Whoever transcribed 2011 met a leg that obviously crossed a zone and dealt with it; later transcriptions saw a populated column and inherited its zeros. **A field that is correct in the first instance and defaulted thereafter is worse than an absent field**, because absence prompts a question and a plausible default does not. **If a value cannot be determined at transcription time, leave it NA and let the reader fail loudly.**

**Scale.** 16 legs corrected, up to 6 mph each. Trip medians moved 0 to +0.9 mph and the ordering by road type was unchanged, so no published claim was wrong -- **but that is luck, not vindication.** The single leg that prompted the whole investigation moved 31.6 -> 33.8, and the one next to it 60.9 -> 53.0.


---

## Finding 036 — A RECORD'S RESOLUTION SETS THE FLOOR ON WHAT ITS SILENCES CAN MEAN (2026-08-19)

I searched TwoRed's whole record for Florida: **no fuel stop in 294, no leg endpoint in 107.** I wrote that the car never reached the state, and built a chapter beat on it -- *a goal declared at the departure and lost to a calendar.*

**Kim had been to Florida.** He aimed at the panhandle, drove a few miles in, stopped at a neighbourhood intersection, asked a passing driver *is this Florida?*, was told yes, turned around and left. **Minutes.**

**The record could not have shown it.** This log resolves to exactly two kinds of event: **buying fuel** and **ending a day.** He did neither in Florida, on purpose -- the entire point was to touch the state and leave. So the visit is not faintly recorded or hard to find. **It is UNRECORDABLE.** No amount of care with the data would have produced it.

**And the geographic instrument is under its own floor here.** The dip hangs off the New Orleans -> Atmore stretch (Atmore AL is ~12 road miles from the line at Century FL, and is a fuel stop on the right day). Road-to-straight-line for that stretch: **1.23, against a trip median of 1.22, IQR 1.11-1.39.** A ~25-mile out-and-back on 210 miles is **indistinguishable from ordinary routing**.

**Where the reasoning actually went wrong.** The card's ABSENCE CLAIMS rule says never assert something is missing without proving it, and I did run the search. **But I proved a statement about FILL-UPS and OVERNIGHTS, and then asserted a statement about a JOURNEY.** Those are different objects. The search was exhaustive over the wrong universe.

**The rule, and it generalises past this project.** Before reading a silence as an absence, **write down what the record's UNIT OF OBSERVATION is, and ask whether the thing you are looking for would have generated one.** A fuel log observes purchases. A trip log observes days. A photograph observes a moment someone chose to keep. **Each is blind to everything that happens between its units, and that blindness is a property of the instrument, not a gap in the data.** Findings 018-020 covered *searched badly*; this is *searched perfectly, in a record that cannot answer the question.*

**A second error the same day, same shape.** I argued the Montgomery -> Cherokee leg had no room for a detour -- 407 logged against ~400 direct -- and therefore no Tail of the Dragon. **The route was never the direct one.** The intermediate fuel stops are Trussville AL (Birmingham) and **Madisonville, east Tennessee**: the leg ran north through Chattanooga and Knoxville, not east through Atlanta, and Madisonville -> Cherokee is **104 miles against ~75 direct** -- the Deals Gap route. **A matching TOTAL does not mean a matching ROUTE.** Two different paths agreed within seven miles and I read the agreement as proof. **Endpoints constrain a route far less than they appear to; the intermediate stops are the only waypoints this record has, and they were sitting there unread.**

**Standing note.** Kim's recollections have now corrected the analysis four times in two days: the road/straight-line audit rule, the time zones, Florida, and this route inference. **Where a human witness to the data exists, treat them as an INSTRUMENT with its own error profile -- not as colour to be checked against the numbers.** So far the witness has the better record.


## Finding 037 — A WRITE TOOL CAN INFLATE A FILE WITHOUT CHANGING A WORD (2026-08-19)

**Mechanism.** `writeLines(x, path, useBytes=TRUE)` opens a TEXT connection. On Windows that connection translates every `\n` to `\r\n` — including the `\n` inside an already-CRLF string. Text that arrived as `\r\n` leaves as `\r\r\n`. Every subsequent read-modify-write adds another `\r`.

**How it surfaced.** `proj_Smart_Car.md` was trimmed by 4,045 characters of prose and `pkm_budget()` still reported it OVER the 45 KB budget — then reported it 0.4 KB LARGER after a rewrite of byte-identical content. The line endings were `0d 0d 0d 0a`.

**Why it evaded every existing check.** The ground-truth rule says verify by CONTENT, never by size — and content verification PASSED at every step, correctly. Word-for-word the file was exactly what I intended. The corruption lives in the whitespace, which is the one part of the content no content check looks at. **A rule written to defeat stale sizes cannot see a bug whose only symptom IS the size.**

**Rules.**

1. Never write text with `writeLines()`. Use a binary connection: `con <- file(path, open="wb"); writeBin(charToRaw(enc2utf8(txt)), con); close(con)`.
2. Normalise on read: `gsub("\r+\n", "\n", x)`. One line ending per line, chosen deliberately.
3. Add whitespace to the verification: after any write, assert `!grepl("\r\r", txt)` alongside the content check.
4. **When a size does not move the way an edit predicts, that discrepancy is itself the observation.** Both this and Finding 030 were caught by a number that failed to match an expectation, not by an error.

**Scope check run.** 89 markdown files in the PKM; exactly ONE was affected — `proj_Smart_Car_log.md`, 909 stray CRs, all written by me this session. Not a pre-existing condition. Both files normalised, verified word-identical.


## Finding 038 — FIXING THE INSTANCE IS NOT FIXING THE CLASS (2026-08-19)

**Finding 034 (2026-08-18):** `pkm_backup()` reported success while 82 of 85 files in `Projects/Smart_Car` were outside the backup, because `SOURCE_EXT` had no `csv`. I added `csv` and `xlsx` and verified the fix — the CSVs and workbooks are in the mirror, confirmed today against the remote ref.

**Today, checking the mirror by hand rather than by report:** `Smart_Car` has **39 files in the mirror and 22 PDFs on disk that are in none of them.** Those PDFs are the SCANS — Kim's paper fuel and trip logs, 2010 to 2017. They are the primary sources behind all 65 errata rows, the only physical evidence for the pump-identity audit, and **the only artifacts in this project that cannot be regenerated from anything else.**

**The failure is not the extension list. It is the shape of the repair.** I fixed the extensions I had just been burned by. **I never asked the general question — *what else on disk is not in the mirror?* — which is one line of code and would have returned the answer immediately.** A repair scoped to the observed instance leaves the class untouched, and the verification I ran afterwards passed, because it tested the instance too.

**Rule.** After changing what a backup INCLUDES, do not verify the change. **Verify the complement: enumerate what is on disk and not in the mirror, by count and by extension, and read that list.** The question a backup must answer is never "did my fix work" but "what is still outside".

**Second-order note.** The same shape appears in Finding 037 filed an hour earlier: a content check that passed correctly while the file was corrupt, because the check was scoped to what I already suspected. **Two instances in one session of a verification that inherits the blind spot of the thing it verifies.**

### The complement check, run properly, broke my own proposed fix

I then did what the rule says and enumerated the complement across all of `Projects`. Three things fell out, and the FIRST of them invalidates the repair I had just proposed.

**1. ★★★ THE MIRROR HAS TWO GATES AND EACH IS BLIND TO THE OTHER.** `SOURCE_EXT` decides what gets COPIED into the mirror. The mirror's own `.gitignore` decides what gets COMMITTED — and it carries `*.pdf`, `*.jpg`, `*.png`, `*.tif`, `*.mp3`, `*.mp4`, `images/`, `pdfs/`. **Adding `pdf` to `SOURCE_EXT` would have copied all 22 scans into the mirror and committed none of them, and `pkm_backup()` would have reported success.** A file can pass gate one and be dropped silently at gate two. **This is the same failure as Finding 034 one layer down, and I proposed a fix that would have hit it.** Any change to what the backup carries must be verified at the COMMIT, by `git_ls()`, never at the copy.

**2. `.txt` was classified as DATA and a large share of it is authored prose.** The 2026-08-18 comment reads *NOT .txt/.csv/.json/.docx -- those are DATA*. The complement contains `LLM_Creates_R/Preface_text.txt`, `Chapter_13.txt`, `Scripting_Discovery/Research_Introduction.txt`, `storylines/full_story.txt`, `Audio/Nike_challenge_canonical.txt`, five `mRNA/Slide_N.txt`, and a dozen `*_guidelines.txt` prompt documents. **These are manuscript text, canonical narration scripts and authored prompts — the least reproducible things in the PKM — and they are outside the backup because of a one-word guess about an extension.** Also outside: `Smart_Car/source/Smart_Car.docx` and `Smart_Car_2016.pptx`.

**3. ⚠ AND A BLANKET `txt` WOULD PUBLISH A CREDENTIAL.** The same complement holds `Photo_Locations/extra_code/auth_token.txt` (96 bytes) and `plainmaps/API_Information/How_to_store_and_use_API_keys.txt`. The mirror pushes to `github.com/kimbridges/kimbridges-venues`. **Nothing is exposed today — those files are outside the mirror — but the obvious repair would expose them.** Precondition on any extension change: audit the complement for secrets FIRST, and confirm the repo's visibility.

**4. The 8.5 GB is not the problem and should not be treated as one.** Outside the mirror across `Projects`: 903 jpg (3.7 GB), 48 tif (1.4 GB), 9 arw (596 MB), 15 wav (398 MB), 4 mp4 (331 MB). **Git is the wrong instrument for these and their absence is a design decision, not a defect.** The defect is only where an authored, irreproducible, small file sits outside because of a misclassification.

**Status: OPEN — a policy decision for Kim, and the naive version of it is now known to be wrong.** See `deferred.md`.



## Finding 039 — A MEMORY'S ERROR PROFILE: ROADS AND COUNTS SURVIVE, BINDINGS SLIP (2026-08-19)

**Two instances in one evening, in unrelated stories, with the identical shape.**

**West Virginia.** Kim named a beautiful highway he had *driven twice*, and paired it with two scientific meetings — Frostburg 2012 and Pine Mountain 2016. **The road is right** (I-64, Charleston to Beckley — he confirmed it on Street View). **The count is right** (the record puts the car on that stretch on exactly two days in sixteen years). **The category of occasion is right** (a scientific meeting in the region, true of both trips). **The BINDING is wrong:** the first drive was 2010, not 2012. Frostburg is I-68, pinned by two Morgantown fills, and I-68 never touches that road.

**The 2010 loop.** Kim gave a sequence: Frostburg meeting → park at St Louis → fly home → return → Nancy joins → her meeting in Boston → university visits → south to California. **Every COMPONENT is independently confirmed in the fuel log**, including the parking (25 days and 227 miles between two Illinois towns seventeen miles apart) and the southern return. **The ORDER of two of them is inverted:** New England is 10/7–10/10, BEFORE the parking; the university tour is 11/6–11/10, after.

**★★ The rule.** **A human witness to their own past is a reliable instrument for CONTENT and an unreliable one for INDEX.** Roads, counts, distances, reasons, categories — these survive decades. **What slips is the attachment of a remembered thing to a particular occasion, and it slips TOWARD occasions that share the category.** Frostburg and Pine Mountain were both meetings; October and November were both parts of one loop.

**Operationally:** when a story and the record disagree, **do not ask which is right — ask WHICH PART disagrees.** In both cases here the content was correct and only the index was wrong, and in both cases the record supplied the missing index without touching the content. **Treat the memory as the source of WHAT and the record as the source of WHEN.**

**★★ AMENDED 2026-08-20 — THE CONTENT THAT SURVIVES IS MORE ABSTRACT THAN THE WORDS USED TO REPORT IT.** Kim looked at a map and withdrew his own West Virginia claim: the two drives were **different highways**, and what they shared was *the same type of countryside; rolling, tree-covered hills, a winding highway, small villages tucked in the valleys.* **So the memory did not retain a ROAD with one occasion mis-bound. It retained a LANDSCAPE TYPE, and *twice* counted instances of the category.** He said *highway*; he meant *this kind of country*. **Operational rule: when a witness names a specific, test whether the specific is standing in for a class before treating a mismatch as an error.** The count was still right — two instances — which is the pattern holding.

**★★ AND THE FAILURE IS NOT THE WITNESS'S ALONE.** Writing this finding up on 2026-08-19 I read a five-day gap in the 2010 record as a Frostburg meeting, because the distances fitted and Frostburg was a meeting already in hand. **It was Washington DC.** Same mechanism, same evening, committed by the analyst rather than the witness. **A gap that admits several stories is not evidence for the one you happen to be holding.**

**And note the complement, because this is not a demotion.** Finding 036 is the opposite case: the record was silent where its resolution could not reach, and the memory carried a fact the data could never have produced. **The two instruments fail in different places, which is exactly why the pair works, and it is why the stories are load-bearing rather than decorative.** See also the three-layer architecture (2026-08-19): preconception, memory and record are the three instruments AND the three reading layers.


## Finding 040 — A NEGATIVE INDEX SILENTLY RETURNS THE WHOLE STRING (2026-08-20)

**What happened.** Slicing a section out of `proj_Smart_Car.md` by two anchors, I checked the START anchor and not the END one. The end anchor did not exist, so `regexpr()` returned **-1**. Then:

- `substr(x, i, -2)` returned **""** — no error, no warning.
- `substr(x, -1, nchar(x))` returned **the entire string** — R clamps a negative start to 1.

`paste0(prefix, new, whole_string)` wrote a file containing a duplicate of everything. **45.7 KB became 60.4 KB, and the only thing that noticed was `pkm_budget()`.**

**Why the existing guard did not fire.** Finding 022 already says *ALWAYS check the match count before using the index*, and `grab_sec()` enforces it with `stopifnot`. **But I bypassed `grab_sec()` for a two-anchor slice and hand-rolled `regexpr()` twice, checking one of them.** The helper was correct; I stepped around it.

**Rules.**

1. **Never hand-roll a two-anchor slice.** Use `grab_sec()`. If a slice genuinely needs two anchors, `stopifnot()` BOTH match counts before either index is used.
2. **Treat a negative index as a bug, never as a boundary.** R's `substr` accepts nonsense silently in both directions.
3. **Add a length assertion to every structural rewrite:** after building the new text, `stopifnot(abs(nchar(new) - nchar(old)) < nchar(old)/2)` before writing. A rewrite that doubles a file is never intended.

**★★ SECOND INSTANCE THE SAME DAY, DIFFERENT MECHANISM.** Replacing a `##` section with `grab_sec()` at its default `level=2` **silently removes every `###` child inside it.** That is the helper working as documented — its `stopifnot` only guards against swallowing a HIGHER-level heading — but it is a trap, and it cost five nested sections from `proj_Smart_Car.md` before a heading count caught it. **Rule: count headings before AND after every structural rewrite, and diff the list, not the number.** I did exactly that earlier in the session (41 → 41), stopped doing it, and lost content within the hour. **A check that is only run when you remember it is not a check.**

**Recovery, and the reason it was instant.** The pre-edit content was still bound to `x` in the session, so the fix was `wbin(P, x)` and a confirmation that the restored text was `identical()` to it. **Holding the pre-edit string in a named variable turned a data-loss incident into a one-line undo** — this is the second time (see Finding 030, where the backup mirror was needed instead). **Bind the old text before every surgery; it is free.**

**And note the detection path, which is the same as Finding 037's.** Nobody read the corrupted file. **A size that moved the wrong way was the entire signal.** Third time in two days that an arithmetic which refused to work was the only witness to a bug the content checks could not see.


## Finding 041 — THE LAST FILL BEFORE A GAP IS NOT WHERE THE CAR SLEPT (2026-08-20)

**What I built.** From 35 dormancies of 14+ days I assembled a "favour map" — attributing each spell to the CITY OF THE PRECEDING FILL and concluding that **34 of 35 sat inside a network of family, friends and a facility, with the St Louis car wash the lone exception.** It was a satisfying result and it was mostly wrong.

**Kim's correction.** *The other places are simply hotel/motels we stopped at along the way. They may repeat (like Brookings) as they are convenient stopping points.* **Barstow, Yuma, Parker, Lancaster, Hesperia, Laguna Hills, Coos Bay and Brookings are waypoints, not driveways.** And the five-week hold I attributed to **Carlsbad** was actually at **Mentone**, at his niece's — **Carlsbad is merely where he last bought fuel, ninety miles short of where the car came to rest.**

**The rule. A fill records where fuel was BOUGHT, not where the car came to REST.** The two coincide only when the resting place is also the refuelling place — true at the Lake San Marcos anchor, where he fuelled locally before flying home, and false at every waypoint on a travelling day.

**This is the same class of error as *a matching TOTAL does not mean a matching ROUTE*.** Both attribute to a row a property the row does not carry. **A fuel row is a TRANSACTION, not a STATE.** It says a purchase happened at a place and a time; it says nothing about what the car did next, and a long gap after it is evidence about DURATION only.

**What survives the correction, and it is not nothing.**

- **The durations are real** — they are gaps between fills and need no location. **86% of elapsed days inside a 14+ day dormancy stands.**
- **The anchor stands**, because Kim's own account confirms it independently: San Marcos / Lake San Marcos, 18 spells, 999 days, his mother's facility.
- **Signal Hill stands, and gains meaning:** it is **Smart Madness**, the garage and after-market vendor that equipped and maintained BOTH cars. **7 fills across the record, 2011 to 2017.** The wide-tire decision has an address.
- **The THEME stands, on Kim's testimony rather than on my map:** *Parking is a big issue and we've been fortunate that friends and family have helped at critical times.* **Mentone (his niece), Eugene (a colleague's farm with a huge garage), the St Louis car wash — three named holdings, none of which the fill locations would have given me.**

**★★ AND THE CORRECTED RESULT IS BETTER THAN THE MAP WOULD HAVE BEEN.** Layer 3 produced a map; layer 2 corrected it; **and the correction says the map cannot be built from the data at all.** Where a car was allowed to sit is exactly the kind of fact a fuel log cannot hold — **only the witness can name it.** That is Finding 036's resolution rule arriving from a new direction, and it makes the parking chapter dependent on the stories in a way that can be stated rather than asserted.

**Operational guard.** Before attributing any dormancy to a place, ask: **was this a place he would refuel, or a place he would stop?** If the odometer moves materially between the pre-gap and post-gap fills (Carlsbad → Carlsbad, 216 miles across 36 days), **the car went somewhere in between and the fill city is not the answer.**


## Finding 042 — A CHECK THAT MEASURES ONE LINE OF A SEVEN-PARAGRAPH BLOCK (2026-08-20)

**What happened.** The Active Focus block in `project_index.md` had always been a single long paragraph, so `pkm_focus_size()` measured it with `nchar(a[i])` — the one line beginning `**Active Focus`. On 2026-08-19 I rewrote the block into seven paragraphs because it had become unreadable. **The next health report said the Active Focus block was 0.1 KB against a 6 KB budget.** It was 4.8.

**And the same assumption was load-bearing somewhere worse.** `archive_focus()` moves the block to `focus_history.md` with `block <- sp$get(i, i)` and rejoins the file from `i + 1`. **Run against a multi-paragraph block it would archive the first line and leave the remaining six paragraphs orphaned in the index.** Nobody ran it — **but I did exactly that by hand this evening**, anchoring on the first `\n\n`, archiving one paragraph of yesterday's block and leaving 3.4 KB of stale focus sitting under the new one. Found by printing the lines rather than trusting the replacement.

**The general shape, and it is the third instance this week.** Finding 038: a backup verified by re-testing the fix instead of enumerating the complement. Finding 040: a slice whose end anchor was never checked. **Here: a measurement whose definition of its own subject silently stopped matching the subject.** In all three, **the check kept returning a confident answer about something it was no longer looking at.**

**The distinguishing feature of this one: nothing was wrong with the code.** It was correct for the document it was written against. **The DOCUMENT changed, and the code had no way to notice.** A hand-written parser and the thing it parses drift apart silently, and the drift is invisible precisely because the parser still returns a number.

**Fixes applied.**

1. **An explicit end marker.** `project_index.md` now carries `<!-- /active-focus -->`. Both functions measure to it and fall back to the single line when it is absent, so the change is backward compatible.
2. **`archive_focus()` moves the whole block** (`sp$get(i, last)`, rejoining from `last + 1`), and its dry-run now reports the line range.
3. **A flag left in the code, not silently fixed:** those writes still assume CRLF and `project_index.md` is now LF (Finding 037). **It is `dry_run = TRUE` by default and must be reconciled before anyone runs it for real.**

**Rule. When a structural convention changes, grep for the code that depends on it.** The block became multi-paragraph in one edit; two functions encoded the old shape and neither complained. **A convention is an interface, and changing it is a breaking change even when nothing throws.**


## Finding 043 — A DERIVED COUNT INHERITS THE RECORD'S RESOLUTION, AND I KEPT REPORTING IT AS A FACT (2026-08-21)

**Kim's correction.** *There is an important count that's not in the fuel or trip logs for TwoRed. That's the state visit total. Some states, like Florida, didn't have a fuel stop or a stop at night. So they aren't in the data... Take my word for it: TwoRed did, indeed, go to the 49 mainland states and the 10 Canadian provinces.*

**What I had been writing, for three days, in four files:** *TwoRed's state list and Kim's state list are two different quantities — 45 documented against a challenge counting to 49.* **That framing is wrong, and it is wrong in a way worth naming.** It treats a shortfall caused by the instrument's RESOLUTION as though it were a disagreement between two claims. **There was never a second quantity. There is one number, 49, and a log that can only witness 45 of it.**

**Why the error was easy to make.** Every other number in this project comes from the data and is checked against it, and that discipline is right. **But a state count is not measured by a fuel log. It is INFERRED from one** — a state appears only if the car happened to buy fuel or end a day inside it. **A derived count inherits every limitation of the record it is derived from, and it does so silently, because the count itself looks like an ordinary number.**

**The distinguishing test, and it generalises past this case.** Ask: **could the record have registered this even in principle?** Miles, gallons, dates and odometer readings — yes, that is what it is for. **A state boundary crossed between two fill-ups is not an event the instrument samples at all.** Where the answer is no, the record's total is a FLOOR, never a value, and it must be labelled as one.

**The four missing states are three different kinds of silence, which is why the case is a good one for the book (ch.13).**

| state | status |
|---|---|
| **Delaware** | **recoverable by geometry** — 264 odometer miles where the only Delaware-free road is ~305 |
| **Rhode Island** | **strongly indicated** — the Douglas MA fill sits on MA-146, the Providence road, and 287 mi fits the coastal route (~285) better than the inland one (~265) |
| **Florida** | **unrecoverable; testimony only.** Finding 036 |
| **South Dakota** | **RECOVERED 2026-08-21 by geometry.** 2012-05-27, the Douglas WY → Bridgeport NE segment reads **255 odometer miles against ~175 direct** — ratio **1.83**, the most indirect stretch in the record. The northern road through **Chadron NE, twelve miles from the line**, accounts for it |

**Rule.** **A count derived from a record is a floor unless every member of the class generates an observation.** Say *the log witnesses 45* and not *45 states*, and put the witness's number in the text. **And when a witness corrects a derived count, check the derivation before the memory** — here the derivation was the thing at fault, and the memory was right.

**★★★ AMENDED 2026-08-21 — AND MY NEGATIVE RESULT ON SOUTH DAKOTA WAS WRONG.** I reported *no leg in the record has room for it*, reasoning that the only regional slack was ~80 miles and a Black Hills dip needs ~110. **The arithmetic was correct. The hypothesis was not.** I had assumed visiting South Dakota meant going somewhere IN South Dakota. Kim: *I drove just far enough to cross the state line into SD, then turned around and left.* **His goal was the LINE**, and from Chadron NE that is a twenty-four-mile round trip inside eighty miles of detour.

**Rule. A negative result is only as strong as the hypothesis it tested, and a null carries that hypothesis's assumptions invisibly inside it.** The honest statement was never *no leg has room for it* but *no leg has room for the trip I imagined.* **Before concluding a record cannot contain something, state what you assumed the something looks like** — that assumption, not the data, is usually what fails. **Note the symmetry with the finding above: there I mistook an instrument's floor for a fact; here I mistook my own premise for the instrument's limit. Both dress an assumption up as a measurement.**

**Cross-reference:** this is Finding 036's rule (*a record's RESOLUTION sets the floor on what its silences can mean*) applied to an aggregate rather than an event, and Finding 041's (*a fuel row is a TRANSACTION, not a STATE*) applied to a total rather than a location. **Three faces of one thing: the record answers the question it was built for, and every other question is asked at its mercy.**


## Finding 044 — INCIDENTAL KNOWLEDGE IS EVIDENCE OF PRESENCE, AND IT IS FALSIFIABLE (2026-08-21)

**Kim, offering a Florida confirmation unprompted:** *I have a friend who lives in Alaska on Styx River Road. There is only one other road in the US with this name. I remember seeing it (Huh? Another one???) in Alabama, just after leaving Florida. It is less than 10 miles from the Florida border. **How would I have known that except by a visit?***

**This is a form of evidence the project did not have, and it is stronger than the testimony it supplements.**

### What makes it work

**1. The fact is USELESS, which is exactly why it is credible.** Nobody memorises an obscure county road name in order to prove, twelve years later, that they were once nearby. **A detail with no argumentative purpose cannot have been manufactured for one.** Its irrelevance is the guarantee.

**2. It is FALSIFIABLE, and the earlier Florida testimony was not.** *I asked a stranger "Is this Florida?" and he said yes* is unfalsifiable — there is no way to check it and no way it could fail. **"There is a Styx River Road in Alabama within ten miles of the Florida line" can be looked up, and if it were not there the claim would collapse.** It is a claim about the WORLD rather than about a memory, and it survives.

**3. It has a documented encoding mechanism.** He did not retain the name for its own sake. He retained it because it **collided** with something already in his head — a friend's address in Alaska — and produced surprise. *Huh? Another one???* **Surprise is the hook, and a proper noun welded to a spike of surprise is the most durable content memory carries.**

**4. It is CONTENT, not INDEX (Finding 039).** He is not claiming a date, a route, an order or an occasion — every one of which has slipped at least once in this project. **He is claiming a name.** That is precisely the register in which this witness has been reliable throughout.

### And it runs the other way from everything else here

**Normally the record corroborates the memory, or fails to.** Here the memory holds a fact the record could never hold — a fuel log has no column for a road sign — **and the fact is checkable against the world rather than against the log.** That makes it a genuinely independent source, the way the AMEX statements were independent of the paper sheets.

**The route supports it.** 2014-05-07, Gonzales LA → Montgomery AL: the **New Orleans → Atmore** segment reads **210 odometer miles against ~195 direct** (great-circle ratio **1.23** against a trip median of **1.22** — the Florida dip is invisible in the aggregate, exactly as Finding 036 says it must be). **Atmore sits nine miles from the Florida line**, and the road from New Orleans runs through **Baldwin County, Alabama, where the Styx River flows into the Perdido — and the Perdido IS the Alabama-Florida boundary.** A road named for the Styx sits in precisely the corridor he describes, on precisely the route his fills document.

**Rule. When a record cannot reach an event, ask the witness not what happened but what they LEARNED there.** Testimony about the event is unfalsifiable; **incidental knowledge acquired at the event is checkable, and its very uselessness is what certifies it.** Look for facts the witness had no reason to want.

**Status of the four unwitnessed states, now complete.** Delaware — geometry. Rhode Island — geometry. South Dakota — geometry. **Florida — testimony, and now incidental knowledge, which is a different and better thing.**
