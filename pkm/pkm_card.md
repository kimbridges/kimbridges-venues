# PKM Card

_The one page read at EVERY session start. Created 2026-07-31 (Tier 3)._
_Budget: 6 KB. If it outgrows that, the surplus belongs in pkm_findings.md._

Full detail lives in `pkm_findings.md` (001-034). This card exists because that file
passed 66 KB with **nothing firing it**. *The trigger is the mechanism, not the list.*

---

## THE GROUND-TRUTH RULE
_Replaces Findings 001, 005, 013, 015 and the second half of 020._

**A `G:` path can report a correct name and size while the bytes are absent, stale,
or not yet materialised. Every surface except the R bridge can be lied to.**

- sandbox bash WRITES never reach Drive (001)
- sandbox bash READS lag Drive contents (005)
- `device_stage_files` can serve a STALE copy (013); staged copies are READ-ONLY and
  do NOT refresh on re-stage -- `rm -rf` the staged folder first (015)
- the browser upload in a Netlify drag-deploy SKIPS unmaterialised large files (008)
- `file.info()` size read straight after a write is unreliable (020)

**Rule.** For ground truth on any `G:` file -- existence, content or size -- read it
through the **R bridge**. Verify a write by reading **CONTENT** back (line count,
headings, known strings), never by reading size.

---

## STOP AND READ, BY SITUATION

| If you are about to... | read |
|---|---|
| **write a date** | **029 -- BIND IT ONCE, AT SESSION START.** `TODAY <- format(Sys.time(), "%Y-%m-%d", tz="Pacific/Honolulu")`, then write `TODAY` everywhere. Session clock is UTC and runs a day ahead from 14:00 HST. **Failed 3x as a reminder; a binding cannot drift mid-session.** |
| say a file, page, entry or site is MISSING or GONE | **018, 019, 020** |
| verify a write you just made | 020 |
| render Quarto | 012, 016, 017 |
| deploy to Netlify | **DEPLOY TARGETS below** -- drag output-dir, never the root; then 008, 011 |
| use git, or run anything shell-like, via the bridge | 009, 014 |
| open a project for real work | that project's section in `deferred.md` |
| add a new project, venue or work | `template.md` field definitions |
| sync or mirror two folders | 021 -- reconcile COUNTS after; case-only renames delete |
| render one format of a book | 021 -- it clears the other formats from output-dir |
| write a `grep` to locate a line | 022 -- `fixed=TRUE` ignores `^`; ALWAYS check the match count before using the index |
| push, or trust a tool's "success" | **028** -- verify against the REMOTE, not the return value |
| **see a TIMEOUT, or check that a job ran** | **031** -- a bridge timeout is NOT a failure; READ the function, then check the artifact it actually writes |
| commit anything to a repo | **027** -- `pkm_secret_scan()` first, with `stopifnot` |
| create a folder or scratch tree | **026** -- `C:\temp` ONLY; the bridge cannot rmdir |
| conclude a document has NO SOURCE | **025** -- read the PDF's producer string first |

---

## ABSENCE CLAIMS

**Never assert something is missing without proving it.** An absence written into
the PKM becomes load-bearing: the next session reads the note instead of re-checking.

- Before declaring a log gap: grep the WHOLE file, at EVERY heading level (019).
- Before calling a site dead: retry, vary user-agent, check DNS, try http/https and
  bare/www. **A live site can return 403 to curl** -- exposure.co does (020).
- Untried? The honest statement is **"could not reach it"**, not "it is gone".

---

## RENAMES: forward pointers move, history does not

Adopted 2026-07-31 (Kim). **Update every pointer that tells a future session where to
go; leave every record of what was true at the time.** The test: *is this sentence
telling someone where to go, or telling them what happened?* Move the first, preserve
the second. A stale instruction sends the next session to a path that is gone; a
rewritten log entry falsifies the past.

---

## THE FOUR SURFACES

| Surface | Sees | Cannot |
|---|---|---|
| **R bridge** (ClaudeR) | all of Kim's machine; GROUND TRUTH for `G:` | run shell commands -- and the guard scans SOURCE TEXT, so the blocked names trip it even inside a string |
| **device bridge** (stage/commit/list) | granted folders only | delete anything; staged copies are read-only |
| **device_bash** | Kim's machine, granted folders | see `G:` AT ALL; delete anything |
| **sandbox bash** | the cloud container only | see Kim's disk; reach netlify.app |

Folder grants are per-folder and **asymmetric**: `G:\My Drive\Projects_Index` and
`C:\temp` grant; `C:\Users\kim\OneDrive\Documents` REFUSES while its
`ai_microscope` subfolder grants.

---

## DEPLOY TARGETS

**Drag the folder named in the project's `output-dir` (`_site`). Never the project
root. Never a subfolder.** Netlify Drop REPLACES the entire site with whatever is
dropped -- on 2026-07-31 dragging `kimbridges-documents/plainmaps/` 404'd all twenty
documents.

The trap is structural: document folders live at the project ROOT (where you edit)
and are copied into `_site` as declared `resources:` (where you deploy), so both
places hold folders with the same names.

Before dragging anything large: right-click -> **Available offline**, wait for the
solid green check, then drag. Verify the biggest asset by URL afterwards (Finding 008).

---

## WHERE THINGS LIVE -- five buckets

| # | Location | Holds |
|---|---|---|
| 1 | `G:\My Drive\kimbridges-*` | publication venues (Status: Standing) |
| 2 | `G:\My Drive\Projects\<name>` | code-as-source projects |
| 3 | `G:\My Drive\Projects_Index\` | the PKM and its machinery |
| 4 | `C:\temp\<name>_<date>` | **BUILD SCRATCH** -- regenerable, never a source |
| 5 | `C:\repos\<name>` | **GIT WORKING CLONES** |

**Bucket 4 retention:** delete once the deploy is verified live; `pkm_health()` flags
scratch older than 14 days. The bridge cannot delete recursively, so overwriting in
place drags stale files along (008).

**Bucket 5:** NOT Drive, NOT OneDrive -- a syncing folder serves placeholders and git
reads them as corrupt or empty (2026-07-31).

---

## RUN AT SESSION CLOSE

`source("G:/My Drive/Projects_Index/pkm_health.R"); pkm_health(); pkm_backup()`
