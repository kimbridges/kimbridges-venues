## Data for Chapter 9 (Good Enough?): the 1974 vegetation map of Mueller-Dombois
## and Fosberg, as vegetation classes on the study-area grid.
## Run once from the project root:  source("R/make_mdf1974_data.R")
## Needs the canopy file from R/make_kipuka_canopy_data.R (for the grid) and the
## digitized map in expert_map/ (sheets 12 and 13, traced from the report's PDF by
## expert_map/mdf_georef.py and coded by expert_map/mdf_codes.py).

library(tidyverse)
library(terra)

## the digitized map: class and region number for each cell, in Old Hawaiian Datum
classes <- rast("expert_map/mdf1974_classes_ohd.asc")
regions <- rast("expert_map/mdf1974_regions_ohd.asc")
set.crs(classes, "EPSG:4135")
set.crs(regions, "EPSG:4135")

## move them onto the study-area grid (PROJ shifts Old Hawaiian to WGS 84, about 285 m E and 345 m S)
grid5   <- rast("data/kipuka_puaulu_canopy_height.tif")
classes <- project(classes, grid5, method = "near")
regions <- project(regions, grid5, method = "near")

## Kipuka Ki's outline is open in the scan, so its region was never coded; leave it blank
classes <- mask(classes, regions, maskvalues = 900003)
names(classes) <- "mdf1974_class"

writeRaster(classes, "data/mdf1974_classes.tif", overwrite = TRUE,
            datatype = "INT1U", gdal = c("COMPRESS=DEFLATE"))

## the class names, in the spelling used in this document
tibble(class_id   = 1:7,
       vegetation = c("Kīpuka forest", "Koa-ʻōhiʻa forest", "ʻŌhiʻa forest", "ʻŌhiʻa scrub",
                      "Grass and savanna", "Open lava and ash", "Modified and other")) |>
  write_csv("data/mdf1974_classes.csv")
