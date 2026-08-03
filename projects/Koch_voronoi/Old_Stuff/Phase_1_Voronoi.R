
## Install and load the necessary packages
if (!require(deldir)) install.packages("deldir")
if (!require(sp)) install.packages("sp")
library(deldir)
library(sp)
library(tidyverse)
library(gt)

## Set the dimensions of the area and the number of anchors
seed <- 674  ## For reproducibility
n_points <- 5
area_size <- 10
min_distance <- 2  ## Minimum distance between anchors

## Set the number of sample points
## Use the same seed
n_samples <- 50

## Set the seed for random number generation
set.seed(seed) 
seed_notice <- paste("Source: seed",seed)

## Function to generate random points with a minimum distance
generate_overdispersed_points <- function(n, area_size, min_distance) {
  points <- tibble(x = numeric(0), y = numeric(0))
  
  while (nrow(points) < n) {
    new_point <- tibble(x = runif(1, 0, area_size), y = runif(1, 0, area_size))
    
    ## Calculate the distance from the new point to all existing points
    if (nrow(points) == 0 || all(dist(rbind(points, new_point))[-1] >= min_distance)) {
      points <- bind_rows(points, new_point)
    }
  }
  
  return(points)
}

## Generate the anchors
vtest_anchors <- generate_overdispersed_points(n_points, area_size, min_distance)

## Save the anchors to a CSV file
write_csv(vtest_anchors, "vtest_anchors.csv")

## Plot the points using ggplot2
ggplot(vtest_anchors, aes(x = x, y = y)) +
  geom_point(size = 4, color = "blue") +
  xlim(0, area_size) + ylim(0, area_size) +
  theme_minimal() +
  labs(title = "Overdispersed Points in a 10x10 Area",
       x = "X Coordinate", y = "Y Coordinate")

## Generate random sample points within the 10x10 area
vtest_samples <- tibble(
  x = runif(n_samples, 0, area_size),
  y = runif(n_samples, 0, area_size)
)

## Save the sample points to a CSV file
write_csv(vtest_samples, "vtest_samples.csv")

## Plot both the anchors (in red) and samples (in black)
ggplot() +
  ## Plot the anchors
  geom_point(data = vtest_anchors, aes(x = x, y = y), size = 4, color = "red") +
  ## Plot the samples
  geom_point(data = vtest_samples, aes(x = x, y = y), size = 2, color = "black") +
  xlim(0, area_size) + ylim(0, area_size) +
  theme_minimal() +
  labs(title = "Anchors (red) and Samples (black) in a 10x10 Area",
       x = "X Coordinate", y = "Y Coordinate")


## Compute the Voronoi tessellation based on the anchor points
voronoi_result <- deldir(vtest_anchors$x, vtest_anchors$y, rw = c(0, area_size, 0, area_size))

## Extract the Voronoi edges (polygon boundaries)
voronoi_edges <- voronoi_result$dirsgs

## Convert Voronoi edges to a data frame for plotting
voronoi_df <- tibble(
  x1 = voronoi_edges$x1, y1 = voronoi_edges$y1,
  x2 = voronoi_edges$x2, y2 = voronoi_edges$y2
)

## Plot the Voronoi polygons, anchor points (red), and sample points (black)
ggplot() +
  ## Plot the Voronoi edges
  geom_segment(data = voronoi_df, aes(x = x1, y = y1, xend = x2, yend = y2), color = "blue") +
  ## Plot the anchor points
  geom_point(data = vtest_anchors, aes(x = x, y = y), size = 4, color = "red") +
  ## Plot the sample points
  geom_point(data = vtest_samples, aes(x = x, y = y), size = 2, color = "black") +
  xlim(0, area_size) + ylim(0, area_size) +
  theme_minimal() +
  labs(title = "Voronoi Tessellation with Anchors (red) and Samples (black)",
       x = "X Coordinate", y = "Y Coordinate")

## Extract Voronoi tiles as polygons
voronoi_tiles <- tile.list(voronoi_result)

## Function to close the polygon (first point == last point)
close_polygon <- function(x, y) {
  if (x[1] != x[length(x)] || y[1] != y[length(y)]) {
    x <- c(x, x[1])
    y <- c(y, y[1])
  }
  return(list(cbind(x, y)))
}

## Convert Voronoi tiles to polygons, ensuring they are closed
voronoi_polygons <- lapply(voronoi_tiles, function(tile) {
  close_polygon(tile$x, tile$y)
})

## Function to check which polygon contains each sample point
get_polygon_for_sample <- function(sample_x, sample_y, voronoi_polygons) {
  for (i in seq_along(voronoi_polygons)) {
    polygon <- voronoi_polygons[[i]][[1]]
    inside <- point.in.polygon(sample_x, sample_y, polygon[,1], polygon[,2])
    if (inside == 1) {  ## The point is inside this polygon
      return(i)  ## Return the index of the polygon
    }
  }
  return(NA)  ## If no polygon contains the point, return NA
}

## Apply the function to all sample points
vtest_samples$polygon <- mapply(get_polygon_for_sample, vtest_samples$x, vtest_samples$y, MoreArgs = list(voronoi_polygons = voronoi_polygons))

## Count the number of sample points in each Voronoi polygon
polygon_counts <- vtest_samples %>%
  group_by(polygon) %>%
  summarize(count = n()) %>%
  right_join(tibble(polygon = seq_along(voronoi_polygons)), by = "polygon") %>%
  replace_na(list(count = 0))

## Add the count to each Voronoi polygon for labeling
voronoi_labels <- tibble(
  polygon = seq_along(voronoi_polygons),
  x = sapply(voronoi_polygons, function(polygon) mean(polygon[[1]][,1])),
  y = sapply(voronoi_polygons, function(polygon) mean(polygon[[1]][,2])),
  count = polygon_counts$count
)

## Plot the Voronoi polygons, anchor points (red), sample points (black), and count labels
ggplot() +
  ## Plot the Voronoi polygons
  geom_polygon(data = do.call(rbind, lapply(seq_along(voronoi_polygons), function(i) {
    tibble(
      x = voronoi_polygons[[i]][[1]][,1],
      y = voronoi_polygons[[i]][[1]][,2],
      polygon = i
    )
  })), aes(x = x, y = y, group = polygon), fill = NA, color = "blue") +
  ## Plot the anchor points
  geom_point(data = vtest_anchors, aes(x = x, y = y), color = "red", size = 4) +
  ## Plot the sample points
  geom_point(data = vtest_samples, aes(x = x, y = y), color = "black", size = 2) +
  ## Add the count labels inside each polygon
  geom_text(data = voronoi_labels, aes(x = x, y = y, label = count), color = "blue", size = 5) +
  theme_minimal() +
  labs(title = "Voronoi Tessellation with Sample Counts",
       x = "X Coordinate", y = "Y Coordinate")


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


