## Data for Chapter 8 (Adding What the Points Don't Know): canopy height for the
## Kipuka Puaulu study area, from the Meta / World Resources Institute global
## 1 m canopy height map (Tolan et al. 2024), averaged to 5 m cells.
## Run once from the project root:  source("R/make_kipuka_canopy_data.R")
## Needs internet access; no key is required.

library(tidyverse)
library(terra)

## the study area rectangle (UTM zone 5N), as in Chapter 2
corners <- read_csv("data/kipuka_puaulu_study_area.csv", show_col_types = FALSE)
xmin <- corners$easting[1];  xmax <- corners$easting[2]
ymin <- corners$northing[1]; ymax <- corners$northing[2]

## the Meta / WRI tile that covers Kipuka Puaulu (quadkey 022300033), read over the web
url  <- paste0("/vsicurl/https://dataforgood-fb-data.s3.amazonaws.com/forests/v1/",
               "alsgedi_global_v6_float/chm/022300033.tif")
tile <- rast(url)

## crop to the study area plus 50 m, in the tile's own projection
area_50 <- vect(ext(xmin - 50, xmax + 50, ymin - 50, ymax + 50), crs = "EPSG:32605")
chm1    <- crop(tile, ext(project(area_50, crs(tile))))

## average the 1 m cells into 5 m cells on the study-area grid
grid5 <- rast(ext(xmin, xmax, ymin, ymax), resolution = 5, crs = "EPSG:32605")
chm5  <- project(chm1, grid5, method = "average")
names(chm5) <- "canopy_height_m"

## save, rounded to 0.1 m
chm5 <- round(chm5, 1)
writeRaster(chm5, "data/kipuka_puaulu_canopy_height.tif", overwrite = TRUE,
            datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE"))
