# PROJECT: sake_brewery
_Last updated: 2026-09-05_
_Status: Complete_
_Focus readiness: Not applicable_

## Type
Content project — illustrated fiction ("based on a true visit"), with a series of small infographics. First native fiction piece built for the kimbridges-fiction venue.

## Objective
A first-person narrative, *Three Ways to Let Go of the Rice*, built from Kim and Nancy's 2025-05-19 Wabunka tour of Sasaki Shuzō (Nishijin, Kyoto — the last sake brewery in Rakuchū). The dialogue is reconstructed, not transcribed: it is what the four people (Kim, Nancy, the production manager, the interpreter Naomi) would have said given the background reading Kim assembled before the trip. The educational aim is to show how sake production maps onto the scale of sake quality, with the brewery's own three-way extraction tasting (drip / centrifuge / press, everything else held constant) as the climax. Deliverable: an illustrated piece (22 photographs + 11 infographics, ~6,150 words) published to the Fiction site as a flipbook PDF, with the web page as a companion.

## Current Status
**Story COMPLETE and approved by Kim 2026-09-05** ("It is just like what happened on that day"). Built in one Cowork session as a deliberate Claude Fable 5.1 trial (the first piece of work on this model; the PKM was kept closed until the experiment succeeded). Web version published as a Claude artifact and saved as a self-contained HTML (photos embedded) beside the images. **Fiction-site build DONE 2026-09-05:** flipbook PDF (40 pp, 6×9 in, 3.5 MB) in `pdfs/`, cover thumbnail in `images/`, stub in `works/`. Cover and front matter carry the standing joint byline ("Kim Bridges · with Claude (Anthropic)"). **PUBLISHED 2026-09-05 (same session): Kim rendered and deployed; live at https://kimbridges-fiction.netlify.app/works/three-ways-to-let-go-of-the-rice.html, reachable from kimbridges.info → Fiction.** Complete / Not applicable.

## Locations
- Source of record: `G:\My Drive\Projects\sake_brewery\` (bucket 2, Kim's ruling 2026-09-05; the venue only cross-posts the finished PDF)
- Photographs: `G:\My Drive\Projects\sake_brewery\images\` (34 Pixel JPGs, 2025-05-19; also the Google Photos album *2025 Kyoto Sake Brewery*)
- Web page: `G:\My Drive\Projects\sake_brewery\three-ways-to-let-go-of-the-rice.html` (self-contained, ~5.7 MB); Claude artifact "Three Ways to Let Go of the Rice"
- PDF copy: `G:\My Drive\Projects\sake_brewery\Three_Ways_to_Let_Go_of_the_Rice.pdf` (same file as the venue copy)
- Fiction venue: `G:\My Drive\kimbridges-fiction\` → `pdfs/Three_Ways_to_Let_Go_of_the_Rice.pdf`, `images/Three_Ways_to_Let_Go_of_the_Rice.jpg`, `works/three-ways-to-let-go-of-the-rice.qmd`
- Background reading (Google Docs, April 2025): *Sake in Kyoto*, *Discussing Sake*, *Kyoto Sake Rice Sourcing*, *Rice Milling and Sake Quality*, *Kyoto Water and Sake Quality*, *A Focus on Kyoto's Sake Breweries*, *Wabunka Sake Tour* (booking confirmation)
- Visit notes: `brewery_visit.txt` (uploaded to the session; Kim's diary entry for 2025-05-19)
- GitHub: not yet (source-recovery mirror picks up `Projects\sake_brewery` on the next `pkm_backup()`)

## Key Files
- three-ways-to-let-go-of-the-rice.html — the finished illustrated web version (photos as data URIs; infographics inline SVG; light/dark)
- Three_Ways_to_Let_Go_of_the_Rice.pdf — the flipbook PDF (40 pp, 6×9 in) as staged on the Fiction site
- images/ — the 34 tour photographs (source; 22 used)
- Build (Cowork sandbox, not on Drive): `story_part1-4.html` (prose), `infographics.py` (11 SVGs), `style.css`, `assemble.py` (photo placement + page), `print.css`/`build_pdf.py` (flipbook PDF)

## Facts settled from primary sources (so nobody re-derives them)
- Tasting slide (photo PXL_20250519_031553000): 1 Pure Craft 16% / +2.5 / 40% / Yamada Nishiki / 1801 / drip; 2 Revolution Neo same / centrifuge; 3 Limited Edition same / press; 4 Extra Premium 17% / +4.0 / 40% / YN / 1801 (alcohol added); 5 Koto Origarami 17% / +4.5 / 50% / Kyō no Kagayaki / 221.
- Koji-room sign (PXL_20250519_023517427): above 35 °C, humidity below 60%, three days. **Kim's notes read 40 °F / 35% RH — a transcription slip; the sign governs.**
- Brewery: founded 1893; Akira Sasaki, 4th generation; southern edge of Jurakudai; wells Kinmeisui/Ginmeisui; list prices 2025: Pure Craft ¥20,000, Revolution Neo ¥10,000, Jurakudai Junmai Daiginjō ¥3,800 (720 ml).
- Kim's notes say "walked east" from Gyoen; the brewery is west of the palace. The story gives no direction.
- The production manager is unnamed in the notes; the story calls him "Hayashi-san" and says so in its opening note. Naomi (interpreter) and the owner are real names. The interpreter intern is present and silent, as he was.

## Related Projects
- proj_kimbridges_fiction.md — the venue (Standing). Workflow: PDF in pdfs/, thumbnail in images/, stub in works/, `quarto render`, drag `_site` to Netlify.
- proj_Trip_Log.md / proj_storylines.md — the Kyoto trip's non-fiction side (Kyoto_1 example).
- proj_audio.md — a possible sequel: four-voice narration (Kim, Nancy, Hayashi-san, Naomi) is the obvious TTS follow-on; not scheduled.

## Next Steps
None. Published 2026-09-05; the deliverable is the live piece. Real-but-not-now items (none yet) would go to `deferred.md`. Possible follow-ons, unscheduled and Kim's call: the same method applied to other trip stories; a four-voice narration (proj_audio.md).

## Collaborators / Dependencies
Nancy (co-protagonist; the labeling contest winner). Sasaki Shuzō staff and Wabunka's interpreter, as characters. No external blockers.

## Blockers
None.

---
## Log
### 2026-09-05
Project created at intake (Mechanism 1), after the fact: the whole piece was drafted, illustrated and approved in this session with the PKM deliberately closed as a Fable 5.1 experiment. Kim opened the PKM once the experiment succeeded. Inputs: `brewery_visit.txt`, seven Google Docs, the Google Photos album (34 originals staged from `Projects\sake_brewery\images`). Two corrections found by reading the photographs rather than the notes (koji-room climate; the SMV of glass 4, which the story turns into a lesson). One photo fix from Kim (bottles-after-labeling moved to §9; final pair dropped). Rulings: source of record stays in `Projects\sake_brewery`; venue is kimbridges-fiction; real names for Kim, Nancy, Naomi, Akira Sasaki; manager's name invented and declared.

### 2026-09-05 (later — PUBLISHED; Complete)
Kim rendered and deployed the Fiction site; the piece is live as its third work. Kim's close: "It was an experiment, and it was very successful... This shows there is a new, and maybe better, way to produce stories that document our past trips." Joint byline confirmed by Kim. Status set Complete / Not applicable (deployed = Complete, per the 2026-07-28 rule). Close: `pkm_health()` re-run and `pkm_backup()` pushed (verified against the remote).
