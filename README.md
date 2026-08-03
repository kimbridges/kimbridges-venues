# kimbridges-venues

Source-of-record mirror for Kim Bridges' five publication venues.

## What this is

The venues themselves live on Google Drive at `G:\My Drive\kimbridges-*`, which is
where Kim edits and where each site's `_site` is built for the Netlify drag. This
repository holds **only the text source** needed to rebuild those sites — `.qmd`,
`_quarto.yml`, `.css`, `.html` helpers. It is a mirror, not a working tree.

## Why a mirror

Before 2026-08-03 the source for all 79 published works existed in exactly one place:
Google Drive. No version history, no second copy. That is the same single-point-of-
failure the 2026 legacy-platform migration spent four sessions removing from *other
people's* platforms.

Putting `.git` inside the venues was rejected. The venues sit on Drive Stream, and a
syncing folder can serve placeholders that git reads as corrupt or empty. A probe on
2026-08-03 confirmed gert can init and commit on `G:` — but that shows git *operates*
there, not that a repo *survives* Drive's sync lifecycle. One probe is not a clearance.

## What is deliberately NOT here

PDFs, images, audio and built output. Those stay on Drive and Netlify. GitHub holds
everything needed to REBUILD a site, not a byte-for-byte copy of it — `kimbridges-`
`documents` alone is ~393 MB and grows with every scan, and plain git keeps every
version of every binary forever.

## Refreshing

```r
source("G:/My Drive/Projects_Index/pkm_health.R")
pkm_mirror_venue("kimbridges-fiction")   # copies tracked files, prunes orphans
```

Then commit. The refresh is one-way: Drive is the source, this repo is the record.
Editing here does not change the site.
