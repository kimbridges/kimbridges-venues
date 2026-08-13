# PKM -- project log
_Split from proj_PKM.md on 2026-07-28. Verbatim; nothing edited._
_Live project file: `../proj_PKM.md`_

---

## Log
### 2026-06-24 (working-pattern observation — AI drafts, the human finishes: the craft contribution is first-class)
Surfaced while illustrating "My Name Is Nike" with OpenAI's image generator (capability + technical rule in
**pkm_findings.md Finding 010**). The generator is excellent at *atmosphere, place, object, light, symbol*
but unreliable at two things: a **specific face** (it repaints it — Nike's blue eyes turned brown) and a
**specific supplied pattern** (it gave generic dots, not Kim's bar-and-dash tattoo diagrams). After a dozen
failing generative passes plus a fiddly deterministic-composite attempt by Claude, **Kim finished the image
by hand in minutes** — placing the real face on the screen and drawing each tattoo with a **Wacom tablet**.

The principle: **in human–AI creative work, the human's specialized craft (compositing an exact likeness,
tablet retouching, the trained eye for "clean") is a first-class part of the loop, not a fallback for when
the AI fails.** The right move is not to force the model to do what it's bad at, but to **route each task to
whoever does it well** — AI drafts the world; the human sets the things that must be exact. Kim named his
own contribution explicitly ("I touch up AI artwork… I've got specialized tools… this is something I can
contribute"), which is the point: the collaboration has a division of labor in *both* directions, and the
human half is craft the model cannot supply.

This sharpens meta-observation #2 (collaborative development): not only does drafting-then-reacting shape the
work, but **production itself is split by competence** — and recognizing what to *stop* asking the AID for
(and hand to the human) is part of the skill. A companion to the transmissibility note below: the method
that's becoming teachable includes *knowing the tool's edges.*

### 2026-06-24 (working-pattern observation — the collaborative method is becoming transmissible)
Kim noted at the close of a very large, productive session (Kaka‘ako Birds shipped to the Stories site
in the morning; in the afternoon the seasonality project went from a resume note to a daylength channel,
a water-balance insight, **four validated continental cue-regime maps**, a deliverable plan, and a
**built, checked, and GitHub-published companion package, `seasonalityr`**) that he had **shown a former
student — newly graduated with his PhD — how he and Claude work collaboratively**, with the explicit aim
of getting the student "brave enough to do this on his own." He believes he made progress.

The principle: **the human–AI collaborative working method is no longer just *how Kim works* — it is
becoming something he can demonstrate and teach.** This extends meta-observation #2 (collaborative
development beats independent specification) and the 2026-06-06 close ("we've established a writing style
and upgraded the tools") from *practiced* to *transmissible*. A method that can be shown to a third party,
and that a third party can be encouraged to adopt independently, has crossed from personal craft toward
shared practice. The day itself was the demonstration material: a non-trivial software artifact
(`seasonalityr`) and a publishable scientific result (the cue-regime maps) produced in one session through
the draft-then-react loop, with the PKM carrying state across the whole arc.

Two notes for the deep review. (a) The barrier Kim is helping the student over is **bravery/confidence**,
not capability — consistent with the blank-page observation (2026-05-15): the hard part is starting, and a
concrete demonstration lowers that cost for an onlooker just as a concrete prompt lowers it for the work.
(b) There may be a future artifact here — a short, honest account of *how to work this way* (the method, the
PKM, the draft-then-react loop, the verification discipline), aimed at researchers like the student. Not
scoped; flagged. Joins the queued meta-observations; closest in spirit to #2 and to the 2026-05-28 "the PKM
is an interface, it should not be static."

### 2026-06-04 (working-pattern observation — the first-person material is the highest-value contribution)

A meta-observation Kim named explicitly during the stories-realm session and
asked to retain. Drafting the first three Kaka‘ako Birds chapters, Kim
reflected: *"I didn't envision that these would be so personal, but work on
other projects, particularly whittakerr, showed me that these are the most
valuable contributions."*

The principle: **in collaborative writing, the first-person material — what
Kim has seen, done, and wondered — is the highest-value content, and it is not
predictable in advance.** Each of the three chapters turned on a personal
anchor that no literature search could supply: the campus ritual of nodding at
a mynah pair and getting a nod back; the dated 2002 absence of the saffron
finch from a bird list, which makes "I watched it arrive" evidentiary; being
present at the Kahuku prawn-pond dedication. The literature verifies and
enriches; the personal material is what makes the story worth reading, and
what only Kim can provide.

Why it matters for the PKM. It sharpens the collaborative-development pattern
(meta-observation #2, 2026-05-15): the draft-then-react loop is not only how
the prose gets shaped, it is the mechanism by which the personal material
*surfaces* — Kim rarely volunteers these stories cold, but a drafted chapter
pulls them out (the mynah story, the talking-star memory, the 2002 list all
arrived in reaction to a draft or a prompt, not before). It also argues for a
deliberate capture discipline: the per-chapter `background/` notes file exists
partly to hold first-person beats the moment they are told, before they cool.
This is the practical reason the stories realm is built on collaboration
rather than Kim-writes-then-Claude-formats.

This joins the whittakerr-era working-practice observations queued for the PKM
deep review (the eight named through 2026-05-23 plus the 2026-05-28 "PKM as a
thinking tool"). It is the first named through the stories work rather than
whittakerr, and it is closest in spirit to #2 (collaborative development) and
#6 (purpose-finding after capability lands).

**Extension (2026-06-05).** The Kakaako_Birds book was completed in draft at 19
species, and the observation held at full scale: not one chapter is a plumage
catalogue; every one is a story of the bird's relationship with people and
place. Kim named this as the project's defining, unexpected achievement —
"talking about the birds is also talking about ourselves… we avoided the trap
of repeating taxonomic descriptions. This is quite unique." Two corollaries
worth carrying into the deep review: (a) the **method is generative, not just
descriptive** — the per-species draft-then-react loop repeatedly pulled out
first-person material Kim would not have volunteered cold (the campus mynah
ritual, the 2002 saffron-finch list, the white-flock pigeons, the kōlea named
as a friend); and (b) the **verification discipline earns its keep twice** —
as correction (waxbill "most common bird," bulbul date, koloa hybrid-purity)
and as enrichment (moa hybrid genetics, the kōlea ʻōlelo noʻeau and navigation,
the Java sparrow's at-home endangerment mirroring the koloa). The `[V:]` tag
system and the per-chapter background/manifest structure are the concrete
mechanisms that made a 19-chapter, fully-sourced, deeply personal book
assemble without drift.

**Corollary (2026-06-06) — the tool follows the proven method.** Assembling the
book exposed that Kim's own `photobookr` package was built for his *earlier*
plan (write every chapter solo, one self-contained block per bird) and does not
fit the collaborative narrative structure that turned out better. Kim's
decision: **rebuild the software to fit the method, not bend the method to the
software.** This is meta-observation #6 (purpose/capability precedes its
articulation) applied to tooling — build the tool, discover a better way of
working through use, then re-cut the tool to it. Carry into the PKM deep review
as a named principle: *let proven practice drive tool design; expect to rebuild
tools once the method clarifies.* (See proj_photobookr.md 2026-06-06.)
**Executed same day:** photobookr was rebuilt + installed to fit the new
structure, and the first full photo-integrated book was built — the principle
acted on, not just named. Kim's close: "We've done more than create a good draft
of the book. We've established a writing style and upgraded the tools needed to
make it efficient."

### 2026-04-05
System designed in claude.ai session. Key decisions: append-only logs,
living header, per-project files, Google Drive storage, Claude Desktop
as write interface. Four initial files created: projects_index,
proj_Koch_voronoi, proj_milestones, proj_PKM.

### 2026-05-07
Major PKM update after multi-session website build. Created four new
project files: proj_kimbridges_stories, proj_kimbridges_documents,
proj_kimbridges_collections, proj_kimbridges_info. Updated
project_index.md with Website Projects section. Updated
design_publishing_workflow.md to reflect Netlify as primary platform,
self-hosted PDF.js viewer, and four-site architecture. Updated PKM
project file with current locations and interface (Cowork mode).
Preparing for transition from Opus 4.6 to Opus 4.7.

### 2026-05-07 (Opus 4.7 — system integration)
Transition to Opus 4.7 complete. First substantive review of the
PKM exposed a gap: the Jones Collection (published 2026-05-05;
substantial in scope) had no proj_*.md file, even though the PKM
had been extensively updated on 2026-05-07. Diagnosed the
structural cause: no intake protocol for projects starting
mid-stream, no end-of-session check to surface what had been
created. Designed and adopted the Operating Protocol — five
reinforcing mechanisms documented in pkm_protocol.md. Created
session_log.md as system-wide working log. Added Active Focus
pointer to project_index.md. Exercised the new protocol on the
Jones backfill: created proj_jones_collection.md, updated
proj_kimbridges_collections.md, updated project_index.md.

### 2026-05-08 (Opus 4.7 — storage migration)
Migration to Google Drive completed. Old Google Drive
Projects_Index (frozen April snapshot) renamed to
Projects_Index_archive_2026-04. New Google Drive Projects_Index
created and populated with all 29 current files from OneDrive.
Verified by file count and content sampling. Locations section
of this file updated to reflect Google Drive canonical. OneDrive
copy slated for deletion after a verification period. D: drive
mirror to be retired via "Stream" mode switch in Google Drive
for Desktop. Git repo status remains open (no .git folder visible
in Projects_Index — needs Kim's clarification). Google Drive MCP
connector confirmed as primary Claude access mechanism.

### 2026-05-10
Operating Protocol exercised on audio project intake. Session-start
protocol, intake protocol, and end-of-session checklist run through
on a small contained scope (TTS workflow integration after the
ElevenLabs MCP smoke test). proj_audio.md created. Confirms the
mechanisms work on non-Jones material — the protocol is not just a
Jones-specific fix.

### 2026-05-10 (storage migration completion)
Drive for Desktop switched from Mirror to Stream. D: drive mirror
retired. G:\My Drive\Projects_Index mounted in Cowork as the new
Claude filesystem access path. Verified end-to-end: prior D: edits
visible via G: (D:→Drive→G: sync chain whole), Read works, Write
works (this very edit is the proof). The MCP connector's
Shared-Drive-subfolder write limitation no longer constrains
operations — direct filesystem read/write replaces the
manual-file-manager-copy workaround documented in 2026-05-08.
Storage architecture is now: Drive canonical, G: Stream-mounted
for Claude, Kim accesses via Drive web or Drive for Desktop.
Full sequence in session_log.md 2026-05-10 entry.

### 2026-05-10 (kimbridges-* folder migrations + architecture decision)
All four kimbridges-* project folders migrated from C: to G:
using the clean-slate pattern: kimbridges-stories (174 files,
rename of stale Drive copy to backup), kimbridges-documents (712
files, greenfield), kimbridges-collections (144 files,
greenfield), kimbridges-info (10 files, greenfield). Total ~1040
files copied via rsync; build artifacts and Windows shell
symlinks excluded. File counts match source-to-destination in
every case. All four proj_kimbridges_*.md files updated with new
Locations and 2026-05-10 log entries. The storage architecture
rule above was decided in the same session after Kim flagged
that mixing deployment-oriented website folders with code-heavy
project folders under one Projects/ umbrella created a
heterogeneous bucket. Full sequence in session_log.md 2026-05-10
entry.

### 2026-05-28 (Projects_Archive retired; Status / Focus readiness fields adopted)

Two structural changes at the close of the housekeeping cycle,
arising from a strategy chat about how to elevate the role of
proj_*.md in daily Active Focus selection.

**Projects_Archive retired.** With only one project (milestones)
in it, the archive was structural debt — a second location to
remember, a special case in path conventions, very little
benefit. Kim moved the milestones folder back into
G:\My Drive\Projects\milestones\ and deleted the empty
Projects_Archive folder. The previous storage architecture
rule (proj_PKM.md Design Decisions, 2026-05-10) implicitly
allowed an archive location; the practical experience of
maintaining it argued against. Completion is now signaled by
the proj_*.md Status field, not by folder location.

**Status and Focus readiness fields adopted.** template.md
gained two structured header fields:
- `Status: Active | Dormant | Reference | Complete`
- `Focus readiness: Ready | Blocked | Exploring | Not applicable`

Field definitions added to template.md. The intent is to make
the proj_*.md collection scannable for Active Focus selection
— a project marked Active + Ready is a stronger candidate
than one marked Active + Blocked or Dormant. The two fields
are deliberately orthogonal; a project can be Active+Blocked,
Dormant+Ready, and so on.

pkm_protocol.md Mechanism 5 (End-of-Session Checklist) was
sharpened: item 2 now explicitly requires reviewing Status
and Focus readiness for every project touched in the session,
with the header fields updated and a log entry added when
they change. A per-project closing-protocol variant was
added for sessions that are deep work on a single project.
Item 7 (Active Focus) now notes that the Focus readiness
fields across proj_*.md are the natural input when choosing
the next Active Focus.

proj_milestones.md is the first proj_*.md carrying the new
fields (Status: Complete, Focus readiness: Not applicable).
Back-fill across the other ~33 proj_*.md is queued as a
small focused exercise, not yet scheduled; new proj_*.md
will carry the fields from creation. The
project_index.md Completed / Archived Projects section may
be retired entirely once the back-fill is done and the
section becomes a derived view.

**Working-pattern meta-observation worth carrying into the
PKM deep review.** This conversation itself was an example of
the PKM as a thinking tool rather than a record-keeping tool.
Kim surfaced the structural question (does Projects_Archive
still earn its keep?), the chat surfaced the elevation idea
(use proj_*.md to guide Active Focus), and the work to
implement followed. Kim's framing at the close: "Chatting
about the PKM is an *essential* part of the PKM. The PKM is
one of the ways you and I have an interface. It should not
be static." This belongs alongside the eight whittakerr-era
meta-observations queued for the PKM deep review — and is
itself the ninth such observation, the first not derived
from whittakerr work directly.

### 2026-05-28 (deprecated OneDrive PKM deleted; housekeeping continuation)

Two days of housekeeping work — 2026-05-27 (Desktop
consolidation) and 2026-05-28 (PKM catch-up plus a long
afternoon of additional moves) — produced substantial PKM
state changes recorded in session_log.md for both dates and
in priorities.md. Two PKM-system-level items worth pulling
forward into this Log:

**Deprecated OneDrive PKM deleted.** Kim deleted
C:\Users\kim\OneDrive\Desktop\Projects_Index on 2026-05-28.
This was the pre-Drive PKM location, working through
2026-05-07, superseded by the Google Drive migration on
2026-05-08, confirmed out of date on 2026-05-10, and
preserved through a long verification period during which
the G: PKM was used continuously for project work,
multi-chapter document drafting (whittakerr), and these
housekeeping sessions. The verification period closed; the
deprecated copy is gone. Locations section above updated to
retire the corresponding bullet.

**Finding 005 captured in pkm_findings.md (2026-05-27,
written up 2026-05-28).** Bash sync visibility through the
Cowork sandbox mount can hide populated Drive subfolders in
Stream mode — the read-direction companion to Finding 001's
write-direction issue. Operating rule adopted: for any G:
visibility check, use the file tools (Glob, Read) on the
`G:\My Drive\...` path or Windows `dir` listings. Bash via
the sandbox mount is not trustworthy for folder existence or
contents on G:. See pkm_findings.md Finding 005 for the
durable record.

The remainder of the 2026-05-27 / 2026-05-28 housekeeping
work — 18 new proj_*.md files across the two days, four
project clusters made explicit (book assembly,
Braun-Blanquet, plus a likely LLM+R sibling pair and two
Braun-Blanquet satellites), the "Projects Referenced but
Not Yet Filed" backlog retired, the Tom Koch / Cranes
mix-up resolved, the four C:\Users\kim\kimbridges-*
deletions and the two OneDrive deletions — is recorded in
session_log.md and project_index.md. The PKM is materially
healthier than at the start of this housekeeping work.

### 2026-05-23 (working-pattern observation — layers of learning: an example that teaches its domain, not just the tool)

Eighth meta-observation from the whittakerr work, named by
Kim while deciding the worked example for the Beyond a Map
chapter.

The Beyond a Map chapter could have continued with the Oahu
map of the previous chapter. Kim instead proposed Kenya, and
in arguing for it he named a principle about what a worked
example is for. His framing: too many examples in technical
documentation are fabricated synthetic mockups, each built
to isolate a single feature. An example like that teaches
the tool and nothing else. An interesting example — a real
country, a real climate, a real pattern — teaches the tool
just as well and teaches the reader something true about
the world at the same time.

The principle: **a worked example carries two layers, and a
good one is chosen so both are full. The tool layer shows
how the function is used. The domain layer is a real fact
about the world that the reader keeps after the software is
forgotten.** Kim's test of it: "The document isn't about
Kenya, but everyone reading it will come away knowing more
about Kenya. That's the point." Venezuela in Build a Map and
Kenya in Beyond a Map are the examples that do this — their
biome diversity and spatial patterning are worth knowing in
themselves, not only as inputs to a function call.

Why it matters. It lifts the document above a user guide. A
reader's time spent working through an example yields
knowledge with a longer half-life than the API. It also
disciplines example selection: a synthetic mockup built to
isolate one feature is a warning sign, not a convenience.

This is the eighth working-practice observation named
through the whittakerr work:

1. Document method (2026-05-15).
2. Collaborative development beats independent
   specification (2026-05-15).
3. Tool-to-concept editorial principle (2026-05-15).
4. Verification as test-case-selection (2026-05-16).
5. Technical obstacles as conceptual camouflage
   (2026-05-17).
6. Purpose-finding after capability lands (2026-05-18).
7. Redundant representations as a verification asset
   (2026-05-22).
8. **Layers of learning: an example that teaches its
   domain, not just the tool (2026-05-23).**

Number 8 joins number 4 as a criterion for choosing
examples. Number 4 asks whether an example's result can be
independently checked. Number 8 asks whether working
through the example leaves the reader knowing something
real. Together they are a fuller rubric: a strong worked
example is verifiable, and it is instructive about its
domain and not only its tool.

Queued for the PKM deep review with the other seven.

### 2026-05-22 (working-pattern observation — redundant representations as a verification asset)

Seventh meta-observation from the whittakerr work,
surfaced this time by a bug hunt rather than named in the
abstract.

A real bug was found in `plot_biome_map()`: when a map
held only some of the biome categories, terra's plotting
shifted the palette and drew biomes in the wrong colors.
The fault had been present for days and had survived
several maps. What exposed it was Kim checking one
representation of the classification against another. The
whittakerr document renders the same nine-biome
classification twice: as the Whittaker diagram in
temperature-precipitation space, and as the biome map in
geographic space. Both use the same palettes. The map drew
woodland/shrubland tan; the diagram drew it red-orange;
the two could not both be right.

The principle: **when a system maintains two independent
representations of the same underlying truth, a
disagreement between them is a bug detector that costs
nothing to run.** The redundancy is not waste. The Color
chapter makes a related argument at the scale of a single
figure — color and a text label are a redundant pair, and
the redundancy is the accessibility design, not a
violation of Tufte's data-ink economy. This observation
lifts the same idea to the scale of the whole document:
the diagram and the map are a redundant pair, and their
agreement is a continuous, free correctness check. Their
one disagreement found a real fault.

A companion note from the same session. Kim also flagged
a suspected cm/mm unit error, and a careful audit found
no bug — the data was sound and the chart he had seen was
stale. A check that finds nothing is still verification:
it converts a worry into a ruled-out hypothesis. The
audit was not wasted effort; it was the cost of being
sure, and Kim's standing principle is that being sure is
worth that cost.

This is the seventh working-practice observation named
through the whittakerr work:

1. Document method (2026-05-15).
2. Collaborative development beats independent
   specification (2026-05-15).
3. Tool-to-concept editorial principle (2026-05-15).
4. Verification as test-case-selection (2026-05-16).
5. Technical obstacles as conceptual camouflage
   (2026-05-17).
6. Purpose-finding after capability lands (2026-05-18).
7. **Redundant representations as a verification asset
   (2026-05-22).**

Number 7 is a companion to number 4. Number 4 says a good
test case has independent paths to check its result.
Number 7 says a system can be built so that two of its
parts check each other continuously, with no separate
test case at all. Both are about making correctness
observable.

Queued for the PKM deep review with the other six.

### 2026-05-18 (working-pattern observation — purpose-finding after capability lands)

Sixth meta-observation from the whittakerr project. The
chapter prose drafting session this morning surfaced a
pattern worth recording.

The whittakerr project's central purpose became visible
only after the toolkit was built. Yesterday's reframing
(mapping as the goal, not an add-on) and today's
(subjective-to-objective verification as the document's
thesis) both happened AFTER the technical artifacts
existed. Neither reframing could have been articulated in
advance from a specification. The mapping was supposed to
be a chapter; building it revealed it was the document's
spine. The verification was supposed to be one application;
running the tools revealed it was the document's
contribution.

The pattern: **purpose-finding happens after capability
lands**. You can plan a project's scope and you can plan
its outputs, but you often can't plan what the project is
FOR until you've built enough of it to see what's now
possible. Some forms of architectural truth are
post-implementation discoveries.

This is the sixth meta-observation Kim has named through
the whittakerr work:

1. Document method (2026-05-15) — chapters as the working
   scaffold.
2. Collaborative development beats independent
   specification (2026-05-15).
3. Tool-to-concept editorial principle (2026-05-15).
4. Verification as test-case-selection (2026-05-16).
5. Technical obstacles as conceptual camouflage
   (2026-05-17).
6. **Purpose-finding after capability lands**
   (2026-05-18).

Note that #5 and #6 are companions. #5 says: an unsolved
technical problem can disguise the architecture's true
shape. #6 says: even after the technical problem is
solved, the architecture's purpose may not be visible
immediately — you have to use the capability before its
significance becomes articulable. Both observations point
at the same underlying structure: doing precedes
understanding, in projects of any depth.

This is also visible in the style of collaboration that
emerged today. Kim's reactions to first drafts have been
chapter-shaping repeatedly in this session: "you've got
the deeper thing wrong; here's what it actually is." The
first draft surfaced what the chapter is about; Kim's
reaction named it. The note about this pattern has been
added to `kim_association_index.md` under Writing
Collaborator notes. It connects to meta-observation #2
(collaborative development) at a more granular level —
within a single chapter's drafting, not just across a
project's life.

Queued for the PKM deep review alongside the other five.
The accelerating rate of meta-observation emergence (six
in six working days) is itself the substantive feedback
the PKM is generating; the deep review should treat this
as a class of activity worth supporting deliberately.

### 2026-05-17 (working-pattern observation — technical obstacles as conceptual camouflage; cross-machine continuity test)

Two PKM-relevant items from the 2026-05-17 whittakerr session.

**Cross-machine continuity test (passed).** Kim resumed work
from a different machine than the prior whittakerr sessions
(laptop → desktop transition). The session-start protocol —
mount `G:\My Drive\Projects_Index`, read `project_index.md`
and `proj_PKM.md`, state Active Focus — carried the full
project state across without information loss. Kim's framing:
the test was both of his own machine setup and of whether the
PKM files are genuinely machine-independent. Both passed.

This is the first explicit cross-machine continuity validation
since the storage migration to G: in May. The PKM design
goal — "persistent memory system shared between Kim and
Claude... accessible from any device" (per this file's
Objective) — is now demonstrated in practice, not just in
principle. The file edits in this session also happened from
the new machine; the test extended from read-side continuity
to write-side continuity.

**Fifth meta-observation from whittakerr: technical obstacles
as conceptual camouflage.** Kim's framing on 2026-05-17:

> "We didn't anticipate doing mapping. But now, I believe
> that this was the goal. We just didn't see it. Likely, it
> was the technical issue of linking a spatial database of
> temperature and precipitation to the overall coding system
> that made a kind of mental block."

The principle: an unsolved technical problem can disguise the
architectural shape of a project. Until the obstacle is
cleared, the work it enables looks ancillary or optional;
once the obstacle is cleared, the work moves from "extension"
to "destination" and the project's earlier structure reads
differently in retrospect.

The whittakerr case: mapping was treated as a queued
refinement throughout May 12–14. The mental block was the
spatial-database-to-classifier linkage (which WorldClim raster
to use, how to crop and mask, how to apply `name_biome()`
per cell efficiently, how to render the result). Once
`map_biomes()` ran end-to-end on 2026-05-16 and produced the
Oahu subtropical desert finding, the architecture became
visible: the diagram-side work was the intermediate step
toward the geographic output that was the project's real
goal.

**Implications for project-level practice:**

- **When a project has a technical obstacle blocking a
  potentially-central capability, the obstacle is doing
  conceptual work as well as technical work.** It's
  hiding the architecture's true shape. Resolving the
  obstacle is more than implementation — it's potentially
  re-orienting.
- **Periodic check: what's the unsolved technical problem in
  this project, and what would the project look like if it
  were solved?** This is a different question from "what's
  the next deliverable?" It targets the obstacle's hidden
  shaping function, not the visible roadmap.
- **The reframing typically comes AFTER the obstacle is
  cleared, not BEFORE.** Trying to predict the reframing
  ahead of time is hard because the obstacle is, by
  definition, obscuring the view. The honest practice is to
  expect that some technical work will turn out to have been
  architectural work and to budget time for the re-orientation
  that follows.

**Candidate for elevation in the PKM deep review:** like the
other four meta-observations, this is a working-practice
principle that could be elevated to a Projects_Index-level
note. Possible home: a "working-practice principles" section
in proj_PKM.md, or a standalone file alongside
pkm_findings.md.

This is the **fifth** meta-level working-practice observation
Kim has named through the whittakerr work, following:

1. Document method (2026-05-15)
2. Collaborative development beats independent specification
   (2026-05-15)
3. Tool-to-concept editorial principle (2026-05-15)
4. Verification as test-case-selection (2026-05-16)
5. Technical obstacles as conceptual camouflage (2026-05-17)

The rate of meta-observation emergence continues to be high.
Five distinct working-practice principles named in five
working days. The deep review will need to handle this as a
class of activity worth supporting deliberately rather than as
a series of isolated insights. The whittakerr project's role
as PKM test bed is producing exactly the kind of feedback the
system was designed to generate.

See proj_whittakerr.md 2026-05-17 log entry and session_log.md
2026-05-17 entry.

### 2026-05-16 (working-pattern observation — verification as test-case-selection)
Another methodological principle named by Kim during the
whittakerr work. On reviewing the successful Oahu mapping
result, Kim flagged: "Choosing the right test case is part
of the verification process. By your choice of Oahu as the
test site, I was able to verify the map (I know the island
and I am actually looking out at one of the subtropical
desert locations). You were also able to verify the map by
knowing about the Mueller-Dombois paper."

The principle:

- **Running code that produces output isn't verification.**
- **Producing output whose correctness can be independently
  checked IS verification.**
- **A test case's verification surface — how many
  independent paths exist to check its results — is part
  of what makes it a good test case.**
- **Two independent verification paths agreeing produces
  strong confidence. One path is moderate. Zero paths is
  just output.**

The Oahu case had two paths: Kim's direct knowledge (lived
experience on the island) and the published literature
(Mueller-Dombois on Hawaiian dry zones). The convergence
made the subtropical desert finding strongly verified
rather than merely surprising.

**Implications for project-level practice:**

- When designing tests for a new feature, prefer test
  cases where the operator has direct knowledge AND
  external documentation exists. This is a selection
  criterion, not just a convenience.
- When selecting worked examples for a document chapter,
  prefer cases with strong verification surfaces — the
  chapter can show not just what the toolkit produces
  but that what it produces is right.
- When debugging produces unexpected output, the test
  case's verification surface determines whether the
  surprise is informative (verifiable surprise → real
  finding) or just noise (unverifiable surprise →
  could be a bug, could be reality, can't tell).

**Candidate for elevation in the PKM deep review:** like
the tool-to-concept principle, the collaborative-development
pattern, and the chapter-ideation pattern, this is a
working-practice observation that could be elevated to a
Projects_Index-level note. Possible home: a new
"verification principles" section in proj_PKM.md, or a
standalone file. Deferred to the deep review.

This is also the FOURTH meta-level working-practice
observation Kim has named through the whittakerr work
(after document-method, collaborative-development,
tool-to-concept, and now verification-as-test-case-selection).
The pattern of meta-observations emerging from the project
is itself the substantive feedback the PKM is generating —
and the rate is accelerating. The deep review will need to
look at this as a class of activity worth supporting
deliberately rather than as a series of isolated insights.

### 2026-05-15 (working-style observation — collaborative development beats independent specification)
Kim observed mid-session that the project's effective working
mode is "collaborative, not provided as an independently
developed starting statement (as I did earlier)" — referring
to his initial detailed user-preferences block. The
collaborative mode goes: prompt (e.g., "suggest chapter
titles") → attempt → reaction → refinement. The contrast is
the specification-then-implementation mode where a complete
framework is handed over upfront and executed against.

Kim's insight: concrete invitations with low attempt-cost
generate work; standing frameworks shape work once it
appears but don't generate it. "Suggest chapter titles" is
the canonical example — small specific output, low cost of
being wrong, the reaction often more informative than the
right answer would have been.

This is methodological PKM-level guidance worth recording
for future projects:

- **The blank-page problem is solved by concrete starting
  prompts, not by upfront framework completeness.** A
  project that starts with "suggest 5 chapter titles" or
  "draft a one-paragraph project pitch" has overcome the
  blank-paper barrier and generated working material to
  react to.
- **Preferences and requirements give orientation; they
  don't generate work.** They constrain what reactions
  to attempts will look like, but they don't themselves
  produce attempts.
- **The reaction to a wrong attempt is often more
  informative than the right attempt would have been.**
  Wrong attempts make implicit preferences explicit by
  forcing them into the open.

Candidate for elevation in the PKM deep review: a
"starting-mode" note at Projects_Index level (perhaps a
short section in proj_PKM.md or a new file) that captures
this working pattern so it's available to all future
projects, not only to whittakerr's history.

### 2026-05-15 (whittakerr as active PKM test bed — Kim's flag)
During an intensive multi-session run on the whittakerr
project (2026-05-13 through 2026-05-15), Kim explicitly
flagged that the project is serving as a test bed for the
PKM and that this was "one of the overriding goals."
Status check: he is "pretty happy with it so far" but
notes this is "something we need to look at quite deeply"
in a focused future session.

Observations worth carrying into that focused review (from
the working sessions themselves, not yet synthesized):

- The PKM is supporting an asymmetric capture ratio that's
  working in the project's favor — short conversational
  contributions from Kim (5 minutes of speaking) are
  resulting in structured durable artifacts (200+ lines of
  organized capture). Both parties have observed this
  pattern in real time and named it.
- The `background/` folder convention (introduced
  2026-05-12 with whittakerr's `Whittakerr Notes.md`) is
  doing real work. Multiple substantive files now live
  there: design_classification_to_mapping.md (nine threads),
  chapter_what_is_a_biome_ideas.md (chapter ideation),
  island_ecosystems_context.md (research-context),
  ibp_desert_biome_context.md (second research-context),
  example_ideas.md (working catalog), open_questions.md
  (registered questions). The boundary between
  authoritative project status (proj_*.md) and working
  notes (background/) holds and is useful.
- The Operating Protocol's session-start and session-log
  mechanisms are being used at every session boundary and
  are catching things they were designed to catch.
- The tool-to-concept editorial principle (design file
  Thread 6) emerged as a meta-observation about the
  project itself and is now articulable — an example of
  the PKM surfacing implicit patterns in Kim's
  working method.
- Open question for the deep review: are there PKM-level
  conventions worth promoting out of whittakerr-specific
  practice into Projects_Index-level guides? Candidates:
  example_ideas.md as a template for any tool-centered
  project; open_questions.md as a per-project convention;
  the tool-to-concept principle as a style-guide-level
  editorial commitment.

No system-level edits made tonight on the basis of these
observations. The pattern is to do the work, observe what
works, then formalize in a focused review session — not to
formalize speculatively while still in the working flow.
Status: queued for deep review.

### 2026-05-12 (bash-mount finding; migration recovery; PKM correction)
The 2026-05-10 migrations did not actually propagate to Drive
cloud. Diagnosed during a whittakerr system-test exercise: bash
operations on the Cowork sandbox mount path do not route through
Drive for Desktop and so do not reach Drive cloud. The file
tools (Edit/Write/Read) use a different path that does
propagate, which is why all the proj_*.md edits from 2026-05-10
ARE real on Drive — the misleading content of those edits is
the problem, not the propagation. Recovery: Kim re-did the four
migrations via Windows Explorer copy-paste, all verified via
Drive MCP. All four proj_kimbridges_*.md files corrected with
2026-05-12 entries; system_audit.md Section 3 and 9 corrected
plus new Section 7 finding; new pkm_findings.md created as the
durable home for system-test findings, with the bash-mount
finding as Finding 001. Full sequence in session_log.md
2026-05-12 entry. Operating rule adopted: bash writes to G:
paths must not be trusted; use file tools, Drive MCP, or Windows
Explorer.

### 2026-05-30 (Status / Focus-readiness back-fill across all proj_*.md; Paused status and Tags field added; five recovered documents filed)

The Status / Focus-readiness fields adopted 2026-05-28 (then carried
only by proj_milestones.md) were back-filled across the entire
proj_*.md collection in one reviewed pass. Method followed the
collaborative draft-then-react pattern: Claude read every proj_*.md
and proposed a Status + Focus-readiness value with a one-line
rationale; Kim reviewed the full table in a single pass and
corrected it; the agreed values were written to every file with a
per-file log entry (the Mechanism-5 step).

**Template changes (template.md):**
- **Paused** added to the Status vocabulary — deliberately suspended
  awaiting a specific known trigger, distinct from Dormant (on hold,
  no trigger). Applied to Koch_voronoi (awaiting Tom Koch), audio
  (awaiting TTS maturity), and accessOAI (early tool, superseded).
- **Tags** added as an optional free-text header field for work-type
  markers that sharpen the worklist without expanding the
  Status/Focus vocabularies. Two tags in use: *finishing* (working
  tool needing packaging to the standard structure — photothumbsr,
  labelextractr) and *update* (posted project needing a functional
  refresh — sitemaps).

**Posted-on-website Complete rule (Kim, 2026-05-30):** any project
with a posted entry on the kimbridges.info / kimbridges-documents
site is Complete by default — the published version is the
deliverable; further polish is optional. This removes the need for a
separate archive (the folder stays in Projects/, the Status field
carries "done"). The posted set was determined by reading the live
kimbridges-documents index (14 documents). Projects set Complete by
this rule: jones_collection, gePoints, citations, whittakerr,
storylines, Colors_of_the_Year, LLM_Creates_R, R_Basics (plus
milestones, already Complete). The Colors_of_the_Year, LLM_Creates_R,
and R_Basics proj files had recorded deployment as "TBD" but were in
fact already live — the PKM was stale on their deployment status.

**Outcome (43 proj_*.md total):** Complete 14 (the nine above plus
the five newly filed posted documents below); Paused 3 (Koch_voronoi,
audio, accessOAI); Reference 1 (Ceska); Active 25, split across Focus
readiness Ready / Exploring, with two Active+Ready carrying the
`finishing` tag and one (sitemaps) the `update` tag.

**Five recovered documents filed (intake).** The five posted
kimbridges-documents that had no proj_*.md (priorities.md item 5)
were hunted down by Kim and filed: proj_Deconstructing_a_Flora.md,
proj_Pedigree_diagrams.md, proj_Photo_Locations.md,
proj_Plainmaps.md, proj_LLM_API_R.md — all Complete / Not applicable.
The search recovered buried work: Photo Locations had been embedded
inside the timelinesr package (extracted to Projects\Photo_Locations\),
and LLM-API-R was hidden inside another folder (only its rendered
output was recovered; its .qmd source is still to be located).

**Findings carried out of the session:**
- **timelinesr needs documentation of its own** — it had been
  carrying the Photo Locations application document instead of
  package docs (added to proj_timelinesr.md Next Steps and
  priorities.md).
- **accessOAI is NOT the posted LLM-API-R document** (Kim) —
  accessOAI is an earlier, separate R tool (now Paused); LLM-API-R is
  its own project. An earlier conflation in the back-fill draft was
  corrected.
- **Folder / slug / proj-name mismatches** are the root of recurring
  confusion (Colors_of_the_Year↔colors, LLM_Creates_R↔using_an_llm,
  R_Basics↔r-basics, accessOAI↔llm-api-r). Kim asked for a
  folder-rename standardization — captured as priorities.md item 6.
- **papers and zundert_2025** removed from project_index.md (no proj
  files existed; zundert will return later as a story).

See session_log.md 2026-05-30 for the session narrative and
project_index.md for the updated tables.

### 2026-05-30 (late evening — new interface modality: live R execution via ClaudeR)

A new interface modality between Kim and Claude landed tonight, in
an unplanned side session. Via the **ClaudeR** package (a Python
`uvx` MCP bridge plus an RStudio add-in), Claude can now execute R
code directly in Kim's *live* RStudio session — reading his
objects, capturing plots, installing packages — rather than only in
the isolated Cowork sandbox. The PKM has said since its Objective
that it is "one of the ways you and I have an interface" and "should
not be static"; this is a concrete extension of that interface from
shared-file memory to shared live computation. Startup ritual:
`library(ClaudeR); claudeAddin()` → **Start Server**. Full setup
account, the three obstacles cleared, and the operating rules are in
**pkm_findings.md Finding 006**; session narrative in session_log.md
2026-05-30 (late evening). Directly resources the next Active Focus
(the stories realm, built on photobookr): Claude can now drive that
R harness in Kim's session rather than handing code back for manual
runs.

### 2026-07-17 (meta-observation — "the 80% tool": tools that give data, not the answer)
A briefing_book design conversation crystallized a working-method concept Kim asked to stash and build on (tag: **80%
tool**). An 80% tool produces the DATA (~80%) but not the ANSWER — the interpretation (~20%) is where the value
concentrates and is irreducibly collaborative. It reframes the tools as instruments FOR THE COLLABORATION to use (AI
wields + drafts the first-pass reading; human supplies ground truth + judgment), not 'tools for the R user to apply'.
Design consequence: the report-emitter should be a scaffold the collaboration fills, not a push-button (the code
generalizes; the reading does not). This is likely the clearest statement yet of the collaborative-method thread — the
whittakerr-era meta-observations queued for the PKM deep review. Full note: **concept_80pct_tool.md** (Projects_Index).

### 2026-07-17 (design decision — two-track VENUE/LANGUAGE rule at intake)
Added to the Intake Protocol (pkm_protocol.md, Mechanism 1). New projects pick a track at intake: ECOSYSTEM work
(builds on / feeds the connected R packages, needs G:/cached data, or is destined for documentation) runs in **R on
Kim's machine** via the ClaudeR bridge; STANDALONE EXPLORATORY work (self-contained, not documentation-bound, not
extending the R ecosystem — e.g. **Tom Koch public-health / mapping questions**) can run in **Python in Claude's cloud
sandbox** (no bridge; delivered via SendUserFile). The friction is the VENUE, not the language. Arose from a 2026-07-17
discussion (Kim: 'is R holding us back?'). Rationale in proj_briefing_book.md; collaboration framing in
concept_80pct_tool.md.

### 2026-07-28 (session_log.md ordering repaired -- two conventions, 25 misfiled entries, and FINDING 019)
**The structural fact.** session_log.md carries TWO ordering conventions. Entries from 2026-06-07 (evening) onward
are PREPENDED at the top, newest-first. The block below the horizontal rule, 2026-05-07 through 2026-06-07, is the
original APPEND-order log and is left that way deliberately. Some sessions between 06-25 and 07-25 used the old
convention by mistake, and their 25 entries landed at the bottom of the file, below 7,000 lines of May and June
material. A later session read the top of the file, saw 07-26 followed by 07-09, and wrote a LOG GAP marker asserting
the entries had never been written. They had been.

**Repaired 2026-07-28.** All 25 misfiled entries were moved into reverse-chronological position; content verbatim,
verified line-for-line, with only h3 headings promoted to h2 and separators normalized. The false marker was replaced
with an ORDERING NOTE. The top block is now 91 entries strictly newest-first, 2026-07-26 back to 2026-06-07. File:
9278 lines after this session's own entry.

**The rule this establishes for the log, and it is now Finding 019.** New entries go at the TOP, at h2, always.
Before declaring anything missing from this file, grep the WHOLE file for the date at every heading level; do not
read a region and infer. And never write a gap marker without proving the gap, because a marker asserting absence
becomes load-bearing -- the next session reads the note instead of the file. If a gap is only suspected, say so and
name the search actually run. Finding 018 says a write-up is not a record; this says a note ABOUT the record is not
the record either.

**Cost of the near-miss, worth remembering.** Five replacement entries were reconstructed from the proj files before
the misfiling was noticed, and reverted. One had already gone wrong: the ʻIliau Loop briefing book recorded at 12 pp,
the figure proj_briefing_book.md preserves, where the contemporaneous log entry says 14 pp after Kim's review. A
reconstruction inherits whichever version of a fact its source happens to keep, and cannot know what it lost.

### 2026-08-12 (the card gains a date rule; Findings 029 and 030, both written from my own errors)

**Kim's ask:** *make a card line for the date problem. It seems to creep in too often.*

**The mechanism.** The assistant's environment supplies a date in its session header, and
that date is **UTC**. Honolulu is UTC-10 with no daylight saving, so **from 14:00 HST onward
the supplied date is a full day ahead — every day.** Kim works evenings often, so this is
the default condition for a large share of working hours, not an edge case. The value is
never malformed and never prompts a check. It is simply, silently, tomorrow.

**It fired on 2026-08-12 itself:** every dated line written that session initially read the
13th, across five files plus a bucket-4 scratch folder name. **Mechanism 4 had said *dates
are HONOLULU LOCAL* since 2026-07-28, was read at session start, and did not fire.**
`pkm_health()` caught it — its report is stamped from the machine clock and landed directly
beneath entries dated a day later. **The only participant that could not be fooled was the
one not taking the date on trust.**

**A BUDGET DECISION, worth recording because the card is designed to force it.** The first
version of the row ran the card to 6.28 KB against its hard 6 KB budget — which
`pkm_budget()` enforces and would have flagged. Rather than quietly exceed it, the card's
own rule was applied: **trigger on the card, surplus to `pkm_findings.md`.** The row was cut
to 108 bytes pointing at **Finding 029**, which carries the diagnosis. Card now sits at
**6158 bytes = 6.0 KB**, exactly at budget and unflagged. A stray duplicated line at the top
of the card, present since it was created, was removed in the same pass.

**★ The 6 KB budget did its job precisely as designed** — it did not prevent a needed rule,
it forced the rule to be *stated at card length* and the reasoning to go where reasoning
belongs. A soft budget would have absorbed 300 bytes without complaint, and then the next
300.

**Finding 030, from a second error the same session.** Replacing a section of
`priorities.md` by string boundaries, the end marker did not match; `regexpr` returned -1;
`substr(s, -1 + 66, ...)` silently became `substr(s, 65, ...)`; and the write produced
**prefix + replacement + almost the entire original file** — 12,824 to 15,848 bytes, two
`## Purpose` sections, a word split at the seam. **The precondition check was already
written, already ran, and already printed `end found: FALSE` in the same call that then
wrote the file.** The information was not missing; it had no teeth.

Rule: **a precondition must `stopifnot()`, not `cat()`.** And prefer LINE INDICES to string
boundaries for section surgery — markdown sections have unambiguous line boundaries; their
prose wraps and gains emphasis markers and is a poor thing to pattern-match on.

Recovered exactly: the damage was deterministic, the original reconstructed and confirmed at
**12,824 bytes**, then one damaged header line repaired by name. **Structure proved it clean,
not size** — `## Purpose` back to one occurrence, `### 1.` back to one, full heading list
matching. A size check alone would have accepted several wrong answers.

**Both guards then earned their keep within the hour.** Two later edits were HALTED by
`stopifnot` — once because I misremembered my own wording, once because an em-dash is three
bytes and a `..` pattern spans two. Both would have been silent corruptions that morning.

**Standing caution restated.** The PKM has no version control. Today's corruption was
reversible in memory. **A destructive splice will not always be.**
