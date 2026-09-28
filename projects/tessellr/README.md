# tessellr

Voronoi tessellations for vegetation, ecology and geography.

A Voronoi tessellation divides an area into tiles, one around each point, so that every place in a tile is closer to its point than to any other. Give each point a category and you have the simplest map that can be made from samples, and anyone with the same points gets the same map. tessellr builds those maps and puts them to work: it measures the tiles, counts records inside them, weights the points, and, most usefully for vegetation mapping, lets a canopy height map decide where the boundaries go.

The package is the companion to the document [*The Map That Never Got Drawn*](https://kimbridges-documents.netlify.app/voronoi/), which develops each idea with worked examples at Kīpuka Puaulu, Hawaiʻi Volcanoes National Park.

## Installation

```r
# install.packages("remotes")
remotes::install_github("kimbridges/tessellr")
```

## A first map

The twelve demonstration points from the document come with the package.

```r
library(tessellr)

## the points, and the study area they sit in
pts   <- sf::st_as_sf(kipuka_releves, coords = c("easting", "northing"), crs = 32605)
frame <- kipuka_frame()

## a plain Voronoi map, and what its tiles say
tiles <- tile_points(pts, frame)
tile_measures(tiles, frame)
merge_tiles(tiles, "vegetation")
boundary_bands(tiles, "vegetation", frame)$edges

## let canopy height draw the boundaries
canopy  <- get_canopy_height(frame)
classes <- structure_classes(canopy)
veg     <- constrained_voronoi(pts, "vegetation", classes)
terra::plot(veg$type)
```

`get_canopy_height()` reads the global 1 m canopy height map from Meta and the World Resources Institute (Tolan et al. 2024) for any area, over the web, with no account or key.

## The functions

| Group | Function | What it does |
|---|---|---|
| Tiles | `tile_points()` | Tiles around points, trimmed to a frame, optionally clipped to a meaningful boundary |
| | `tile_measures()` | Area, border, nearest and farthest border, neighbors, shared border, edge tiles |
| | `tile_pattern()` | Even, random or clustered, judged against random points in the same frame |
| | `merge_tiles()` | Merge neighboring tiles of the same category into patches |
| | `boundary_bands()` | Uncertainty bands half the sample spacing wide |
| Containers | `count_in_tiles()` | Counts per tile against area, with a counting frame, location uncertainty and Poisson tests |
| Weights | `weighted_areas()` | Service areas by distance divided by weight |
| Canopy | `get_canopy_height()` | Canopy height for any area |
| | `structure_classes()` | Smoothing, height classes and a minimum mapping unit |
| | `trace_patch()` | The outline of a patch of tall canopy, such as a kīpuka |
| | `constrained_voronoi()` | Plain or structure-constrained Voronoi map |
| Checking | `map_agreement()` | Area and boundary agreement with a reference map |

## Authors

Kim Bridges and Claude (Anthropic). The counting and testing in `count_in_tiles()` follows a Voronoi analysis for epidemiological data developed with Tom Koch.

## Reference

Tolan, J., et al. 2024. Very high resolution canopy height maps from RGB imagery using self-supervised vision transformer and convolutional decoder trained on aerial lidar. *Remote Sensing of Environment* 300: 113888. <https://doi.org/10.1016/j.rse.2023.113888>

## License

MIT
