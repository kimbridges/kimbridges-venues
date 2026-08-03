# listsr

*Find pattern in the lists you already collect.*

`listsr` is a small R toolkit for turning the ragged, everyday lists people
already keep — sites, and the items found at each (market stalls and their
produce, months and what is in season, plots and the plants in them) — into
reproducible groups.

It runs one short, legible workflow:

1. **Read** a ragged `"Site, item, item, ..."` list — `read_lists()`.
2. **Look** at it — `item_freq_plot()`, `site_freq_plot()`, `two_way_plot()`.
3. **Lay it flat** into a binary two-way table — `data_to_2way()`.
4. **Measure** it — `dissimilarity()` (Jaccard), `dissimilarity_plot()`.
5. **Draw the tree** — `dendrogram_plot()`, or colour the leaves by external
   metadata with `dendrogram_meta_plot()`.
6. **Cut it by a rule** — `recruit_heights()` and `assessment_cut()` implement
   the "most variable site sets the line" assessment-line method.

The point is not the tree but the discipline: groups become *reproducible
constructs* you can state a rule for, defend, and link to metadata — not proofs
of natural kinds.

## Install

```r
# remotes::install_github("kimbridges/listsr")
```

## A quick look

```r
library(listsr)

fish <- read_lists(
  "Stall1, Mussels, Crab, Lobster, Shrimp, Oysters, Clams
   Stall2, Clams, Mussels, Shrimp, Crab
   Stall3, Oysters, Crab, Lobster, Clams
   Stall4, Mackerel, Cod, Tuna, Snapper, Salmon")

two_way <- data_to_2way(fish)
d  <- dissimilarity(two_way, what = "site")
dendrogram_plot(d)

hc  <- hclust(d, method = "average")
assessment_cut(hc)
```

## Lineage

`listsr` shares its origins with [`coenosr`](https://github.com/kimbridges/coenosr),
the engine that recovers the 1991 COENOS Braun-Blanquet table-sorting program.
Where `coenosr` reads releve *files* and sorts a two-way table, `listsr` reads
ragged list *text* and takes the dendrogram path to groups.
