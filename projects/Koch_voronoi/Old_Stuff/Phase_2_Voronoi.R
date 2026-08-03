
## Install and load the necessary packages for Part 2
if (!require(deldir)) install.packages("deldir")
if (!require(sf)) install.packages("sf")
library(deldir)
library(sf)
library(tidyverse)
library(gt)

source("Phase_1_Voronoi.R")

## Calculate the total area of the study region
total_area <- area_size * area_size  # Should be 100 for a 10x10 area

## Convert Voronoi tiles to sf polygons with appropriate CRS
voronoi_sf <- st_sf(
  ID = sapply(voronoi_tiles, function(tile) tile$ptNum),
  geometry = st_sfc(lapply(voronoi_tiles, function(tile) {
    st_polygon(close_polygon(tile$x, tile$y))
  }), crs = st_crs(NA))  # Use st_crs(NA) for a missing CRS
)

## Compute area of each polygon
voronoi_sf$area <- st_area(voronoi_sf)

## Calculate expected number of cases per polygon under null hypothesis
total_cases <- nrow(vtest_samples)  # Total number of sample points (e.g., 50)
expected_density <- total_cases / total_area  # Cases per unit area
voronoi_sf$expected_cases <- as.numeric(voronoi_sf$area) * expected_density

## Merge observed counts from previous steps
# Assuming 'polygon_counts' data frame contains 'polygon' and 'count' columns
voronoi_sf$observed_cases <- polygon_counts$count

## Perform Poisson tests
voronoi_sf$p_value <- mapply(function(observed, area) {
  poisson.test(x = observed, T = as.numeric(area), r = expected_density)$p.value
}, observed = voronoi_sf$observed_cases, area = voronoi_sf$area)

## Identify significant polygons (e.g., p-value < 0.05)
voronoi_sf$significant <- voronoi_sf$p_value < 0.05

voronoi_table <- as.data.frame(voronoi_sf) |>
  dplyr::select(ID,area,expected_cases,
                observed_cases,p_value,significant)

gt(voronoi_table) |>
  ## Title on the table
  tab_header(
    title = "Poisson Test ")|>
  ## Source Information
  tab_source_note(
    source_note = seed_notice) |>
  ## Positioning data in the cells
  ## Format the values
  fmt_number(columns = c(area,expected_cases), decimals = 1) |>
  fmt_number(columns = p_value, decimals = 3)


