# pubmaps

Study-site maps for journal editors. PubMaps turns a manuscript into a
publication-ready study-site map with a locator inset:

- **a language model reads** the manuscript and lists every mappable place, with the page and sentence that mention it;
- **gazetteers locate** them (GeoNames and OpenStreetMap), each position recorded with its source and match quality;
- **code decides the geometry**: projection, frame, inset, scale bar, north arrow, parks and districts as areas;
- **the editor checks and corrects** everything on a review page, through one table, `points.csv`.

## Install

```r
remotes::install_github("kimbridges/pubmaps")
```

Put your keys in `.Renviron` (`usethis::edit_r_environ()`):

```
OPENAI_API_KEY=...        # or ANTHROPIC_API_KEY
GEONAMES_USERNAME=...     # a free account at geonames.org, web services enabled
```

## Use

```r
library(pubmaps)
pubmap("Medley_et_al_2010.pdf")                  # writes review/Medley_et_al_2010/
# ...check review.html, edit points.csv...
pubmap_rerender("review/Medley_et_al_2010")
```

The Editor's Guide explains the review page and every correction.

## Authors

K. W. Bridges and Claude (Anthropic). The tool grew from Will McClatchey's
years of redrawing authors' maps as a journal editor.
