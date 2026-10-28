# pubmaps

Study-site maps for journal editors. PubMaps turns a manuscript into a
publication-ready study-site map with a locator inset:

- **a language model reads** the manuscript and lists every mappable place, with the page and sentence that mention it;
- **gazetteers locate** them (GeoNames and OpenStreetMap), each position recorded with its source and match quality;
- **code decides the geometry**: projection, frame, inset, scale bar and north arrow; parks and districts drawn as areas, rivers as lines;
- **the editor checks and corrects** everything on a review page, through one table, `points.csv`.

The map is written as vector graphics (`map_vector.pdf`), so lines and names stay sharp at any size.

**Editor's Guide:** <https://kimbridges-documents.netlify.app/pubmaps/>

## Install

```r
install.packages("remotes")
remotes::install_github("kimbridges/pubmaps")
```

Put your keys and folders in `.Renviron` (`usethis::edit_r_environ()`), then restart R:

```
OPENAI_API_KEY=...        # or ANTHROPIC_API_KEY
GEONAMES_USERNAME=...     # a free account at geonames.org, with web services enabled
PUBMAPS_REVIEW=C:/maps/review
```

## Use

```r
library(pubmaps)
pubmap("Medley_et_al_2010.pdf")          # writes a review folder, prints the path of review.html
# ...check review.html, edit points.csv...
pubmap_rerender("Medley_et_al_2010")     # redraws from your corrections
pubmap_rerender("Medley_et_al_2010", legend = FALSE)   # symbols explained in the caption instead
```

The review page also drafts the query to the author and gives a symbol key, ready to copy into the figure caption.

## Authors

K. W. Bridges and Claude (Anthropic). The tool grew from Will McClatchey's
years of redrawing authors' maps as a journal editor.
