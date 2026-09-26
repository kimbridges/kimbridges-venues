## Chapter 1 figure: the simple Voronoi map of Kipuka Puaulu.
## Uses the same data and steps as Chapter 2, so the two chapters show the same map.
## Run from the project root:  source("R/fig_ch1_voronoi.R")

library(tidyverse)
library(sf)

## the vegetation colors used throughout the document (Okabe-Ito)
veg_colors <- c("Kīpuka forest"     = "#009E73",
                "Koa-ʻōhiʻa forest" = "#0072B2",
                "ʻŌhiʻa forest"     = "#56B4E9",
                "ʻŌhiʻa scrub"      = "#E69F00",
                "Grass and savanna" = "#F0E442")

## the twelve sample points and the study area's two corners
releves      <- read_csv("data/kipuka_puaulu_releves.csv", show_col_types = FALSE)
area_corners <- read_csv("data/kipuka_puaulu_study_area.csv", show_col_types = FALSE)

## points in UTM zone 5N (EPSG 32605), coordinates in meters
releve_points <- st_as_sf(releves, coords = c("easting", "northing"), crs = 32605)

## the study area as a rectangle
study_box  <- st_bbox(c(xmin = area_corners$easting[1],  ymin = area_corners$northing[1],
                        xmax = area_corners$easting[2],  ymax = area_corners$northing[2]),
                      crs = st_crs(32605))
study_area <- st_as_sfc(study_box)

## tiles: build, split into polygons, trim to the study area, attach each point's data
tiles_all <- st_voronoi(st_union(releve_points), envelope = study_area)
tiles     <- st_collection_extract(tiles_all)
tiles     <- st_intersection(tiles, study_area)
tiles     <- st_join(st_sf(geometry = tiles), releve_points)

fig <- ggplot() +
  geom_sf(data = tiles, aes(fill = vegetation), color = "white", linewidth = 0.6) +
  geom_sf(data = releve_points, shape = 21, fill = "white", color = "black", size = 2.4) +
  scale_fill_manual(values = veg_colors, breaks = names(veg_colors), name = NULL) +
  coord_sf(datum = NA, expand = FALSE) +
  theme_void(base_size = 13) +
  theme(legend.position = "bottom")

ggsave("images/ch1_voronoi_kipuka.png", fig, width = 9, height = 8.2, dpi = 150, bg = "white")
