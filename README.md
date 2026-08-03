# kimbridges-venues

Source-of-record mirror for Kim Bridges' published work.

```
venues/    the five publication sites' own source  (197 files)
projects/  the source behind the published work    (683 files)
```

## What this is

The working copies live on Google Drive — `G:\My Drive\kimbridges-*` for the venues,
`G:\My Drive\Projects\<name>` for everything else. That is where Kim edits and where
each site is built for its Netlify deploy. This repository holds **only hand-authored
source**, and is a mirror rather than a working tree.

## Why it exists

Before 2026-08-03 the source for all 79 published works existed in exactly one place:
Google Drive. No version history, no second copy. That is the same single-point-of-
failure a four-session migration had just finished removing from *other people's*
platforms — so leaving it in place on Kim's own storage made no sense.

## Why the venues are not enough on their own

`kimbridges-documents` contains 22 document folders, but they are **rendered output
copied in** — the real source of each lives in `Projects/<name>`. Mirroring the venue
alone would back up the shelf and not the books: you would recover a listing page with
nothing behind it. Hence `projects/`, which is the larger and more irreplaceable half.

## What is deliberately excluded

Kim, 2026-08-03: *"We should not be storing derived output. That simply wastes space
and is not the intent of this backup protection."*

Selection is a **whitelist**, not an ignore list. An earlier blacklist attempt missed
`_output/` — the output-dir every Quarto book uses — and admitted 2,018 files of Jones
research data plus 278 rendered pages. A blacklist must anticipate every kind of junk;
a whitelist only has to know what source looks like.

- **Kept:** `.qmd .rmd .R .yml .yaml .css .scss .bib .py .js .md`, plus `viewer.html`
  by name.
- **Dropped:** PDFs, images, audio, data (`.txt .csv .json .docx`), anything under
  `_site _book _output _freeze .quarto site_libs .Rproj.user`, and `_backup*` folders.
- **`.html` is not a source extension.** A first pass admitted 12.5 MB of rendered
  output living outside any build folder — R Notebook renders, htmlwidget maps, loose
  Quarto pages. Only hand-authored helpers are allowlisted by name.

## Known limit

This is a **source-recovery** repo, not a full-rebuild repo. Sites also need PDFs and
images that live only on Drive — fiction's two works reference four such assets. The
repo restores what cannot be regenerated; it does not reconstitute a finished site
unaided.

## Refreshing

```r
source("G:/My Drive/Projects_Index/pkm_health.R")
pkm_mirror_venue("kimbridges-stories")
pkm_mirror_project("plainmaps")
```

One-way: Drive is the source, this repo is the record. Editing here changes no site.
Each call prunes files that are no longer tracked, comparing lowercased names on both
sides — a case-only rename is one file on Windows, and a case-sensitive check deletes
the file it just wrote.
