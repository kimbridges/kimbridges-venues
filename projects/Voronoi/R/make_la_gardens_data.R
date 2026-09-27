## Data for Chapter 7 (Weighted Voronoi): five Los Angeles basin botanical gardens,
## the land frame, and 2020 census tract populations.
## Run once from the project root:  source("R/make_la_gardens_data.R")
## Needs internet access and a Census API key (tidycensus::census_api_key()).

library(tidyverse)
library(sf)
library(tigris)
library(tidycensus)
options(tigris_use_cache = TRUE)

## --- the five gardens --------------------------------------------------------

gardens <- tibble(
  garden  = c("LA County Arboretum", "Descanso Gardens", "The Huntington",
              "South Coast Botanic Garden", "California Botanic Garden"),
  city    = c("Arcadia", "La Cañada Flintridge", "San Marino",
              "Palos Verdes Peninsula", "Claremont"),
  query   = c(NA, "Descanso Gardens, La Canada Flintridge", "Huntington Library, San Marino",
              "South Coast Botanic Garden", "California Botanic Garden, Claremont"),
  article = c("Los_Angeles_County_Arboretum_and_Botanic_Garden", "Descanso_Gardens",
              "Huntington_Library", "South_Coast_Botanic_Garden", "California_Botanic_Garden"),
  ## garden area in acres (Wikipedia; matches the whittakerr garden table)
  acres   = c(127, 150, 120, 87, 86))

## locations from OpenStreetMap (Nominatim); the Arboretum from its Wikipedia coordinates
locate <- function(q) {
  Sys.sleep(1.1)
  url <- paste0("https://nominatim.openstreetmap.org/search?format=json&limit=1&q=", URLencode(q))
  hit <- jsonlite::fromJSON(url)
  c(as.numeric(hit$lat[1]), as.numeric(hit$lon[1]))
}
loc <- t(sapply(gardens$query, function(q) if (is.na(q)) c(34.1415392, -118.0540609) else locate(q)))
gardens$latitude  <- round(loc[, 1], 5)
gardens$longitude <- round(loc[, 2], 5)

## Wikipedia pageviews for each garden's article, calendar year 2024 (users only)
pageviews <- function(article) {
  url <- sprintf(paste0("https://wikimedia.org/api/rest_v1/metrics/pageviews/per-article/",
                        "en.wikipedia/all-access/user/%s/monthly/2024010100/2024123100"), article)
  sum(jsonlite::fromJSON(url)$items$views)
}
gardens$pageviews_2024 <- sapply(gardens$article, pageviews)

write_csv(select(gardens, garden, city, acres, latitude, longitude, article, pageviews_2024),
          "data/la_gardens.csv")

## --- the land frame ----------------------------------------------------------

counties_ca <- counties(state = "CA", cb = TRUE, year = 2020, progress_bar = FALSE)
counties_la <- filter(counties_ca, NAME %in% c("Los Angeles", "Orange", "San Bernardino", "Riverside", "Ventura"))
counties_la <- st_transform(counties_la, 32611)
box   <- st_as_sfc(st_bbox(c(xmin = -118.75, ymin = 33.55, xmax = -117.45, ymax = 34.45), crs = st_crs(4326)))
box   <- st_transform(box, 32611)
land  <- st_union(st_intersection(st_geometry(counties_la), box))
land  <- st_sf(name = "Los Angeles basin frame (land only)", geometry = land)
if (file.exists("data/la_land_frame.geojson")) file.remove("data/la_land_frame.geojson")
st_write(st_transform(land, 4326), "data/la_land_frame.geojson", quiet = TRUE)

## --- 2020 census tract populations ------------------------------------------

tracts <- get_decennial(geography = "tract", variables = "P1_001N", year = 2020, state = "CA",
                        county = c("Los Angeles", "Orange", "San Bernardino", "Riverside", "Ventura"),
                        geometry = TRUE, progress_bar = FALSE)
tracts <- st_transform(tracts, 32611)
## one representative point per tract, inside the tract
points <- st_point_on_surface(tracts)
points <- points[lengths(st_intersects(points, land)) > 0, ]
points <- st_transform(points, 4326)
tract_table <- tibble(geoid      = points$GEOID,
                      population = points$value,
                      longitude  = round(st_coordinates(points)[, 1], 5),
                      latitude   = round(st_coordinates(points)[, 2], 5))
write_csv(tract_table, "data/la_tracts_2020.csv")
