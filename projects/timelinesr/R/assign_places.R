#' Assign Named Places (Hybrid Spatial & Chronological)
#'
#' Uses spatial Voronoi logic for photos with good GPS, and falls back to
#' chronological semantic matching for photos in GPS dead zones.
#'
#' @param tagged_df Dataframe of geotagged photos.
#' @param track_df The cleaned GPS track dataframe.
#' @param places_csv Path to the CSV containing 'Place', 'lat', 'lon'.
#' @param spatial_max_m Max distance for spatial Voronoi (meters). Defaults to 2000.
#' @param anchor_max_m Max distance for a track point to be an "anchor". Defaults to 500.
#' @return The tagged dataframe with 'Place' and rescued coordinates.
#' @export
assign_places <- function(tagged_df, track_df, places_csv, spatial_max_m = 2000, anchor_max_m = 500) {
  
  require(sf)
  require(dplyr)
  require(readr)
  require(lubridate)
  
  places <- readr::read_csv(places_csv, show_col_types = FALSE)
  places_sf <- sf::st_as_sf(places, coords = c("lon", "lat"), crs = 4326)
  
  # --- 1. BUILD THE SEMANTIC ANCHOR TRACK ---
  # Find all track points confidently within 500m of a known Place
  valid_track <- track_df |> dplyr::filter(!is.na(lon), !is.na(lat))
  track_sf <- sf::st_as_sf(valid_track, coords = c("lon", "lat"), crs = 4326)
  
  track_nearest <- sf::st_nearest_feature(track_sf, places_sf)
  track_dist <- sf::st_distance(track_sf, places_sf[track_nearest, ], by_element = TRUE)
  
  semantic_anchors <- valid_track |>
    dplyr::mutate(
      Place = places$Place[track_nearest],
      Place_Lat = places$lat[track_nearest],
      Place_Lon = places$lon[track_nearest],
      Anchor_Dist = as.numeric(track_dist)
    ) |>
    dplyr::filter(Anchor_Dist <= anchor_max_m) |>
    dplyr::arrange(timestamp)
  
  # --- 2. SEPARATE PHOTOS ---
  # Good photos have coordinates. Bad photos fell into a GPS gap.
  good_photos <- tagged_df |> dplyr::filter(!is.na(lat) & !is.na(lon))
  bad_photos <- tagged_df |> dplyr::filter(is.na(lat) | is.na(lon))
  
  # --- 3. SPATIAL PASS (Good Photos) ---
  if (nrow(good_photos) > 0) {
    photos_sf <- sf::st_as_sf(good_photos, coords = c("lon", "lat"), crs = 4326)
    p_nearest <- sf::st_nearest_feature(photos_sf, places_sf)
    p_dist <- sf::st_distance(photos_sf, places_sf[p_nearest, ], by_element = TRUE)
    
    good_photos <- good_photos |>
      dplyr::mutate(
        Place = places$Place[p_nearest],
        Distance_m = as.numeric(p_dist),
        Assign_Method = "Spatial_Voronoi"
      )
    good_photos$Place[good_photos$Distance_m > spatial_max_m] <- NA
  } else {
    good_photos <- good_photos |> dplyr::mutate(Place = NA_character_, Distance_m = NA_real_, Assign_Method = NA_character_)
  }
  
  # --- 4. CHRONOLOGICAL PASS (Bad Photos) ---
  if (nrow(bad_photos) > 0 && nrow(semantic_anchors) > 0) {
    message("Attempting to rescue ", nrow(bad_photos), " photos using chronological matching...")
    
    bad_times <- as.numeric(bad_photos$timestamp)
    anchor_times <- as.numeric(semantic_anchors$timestamp)
    
    # Find the single closest confirmed location in time
    closest_indices <- sapply(bad_times, function(bt) {
      which.min(abs(anchor_times - bt))
    })
    
    bad_photos <- bad_photos |>
      dplyr::mutate(
        Place = semantic_anchors$Place[closest_indices],
        lat = semantic_anchors$Place_Lat[closest_indices], # RESCUE COORDINATES
        lon = semantic_anchors$Place_Lon[closest_indices], # RESCUE COORDINATES
        geotag_status = "rescued_chronological",
        Distance_m = NA_real_,
        Assign_Method = "Time_Fallback"
      )
  } else {
    bad_photos <- bad_photos |> dplyr::mutate(Place = NA_character_, Distance_m = NA_real_, Assign_Method = NA_character_)
  }
  
  # --- 5. RECOMBINE ---
  results <- dplyr::bind_rows(good_photos, bad_photos) |>
    dplyr::arrange(timestamp)
  
  message("Successfully assigned places to ", sum(!is.na(results$Place)), " photos.")
  return(results)
}