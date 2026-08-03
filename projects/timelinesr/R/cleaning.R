#' Clean Track Data of GPS Anomalies
#'
#' Removes GPS points that require impossible travel speeds or exactly duplicate
#' previous coordinates (symptoms of cell-tower triangulation ping-pong).
#'
#' @param track_df The dataframe returned by fuse_layers().
#' @param max_speed_mph Maximum physically possible speed in mph. Defaults to 80.
#' @return A cleaned dataframe with anomalies removed.
#' @export
clean_track <- function(track_df, max_speed_mph = 80) {
  
  require(dplyr)
  
  message("Scanning track for cell-tower anomalies...")
  
  # Internal helper to calculate true distance on the Earth's surface in meters
  calc_dist_m <- function(lon, lat) {
    rad <- pi / 180
    a1 <- lat * rad
    a2 <- dplyr::lag(lat) * rad
    b1 <- lon * rad
    b2 <- dplyr::lag(lon) * rad
    
    dlon <- b2 - b1
    dlat <- a2 - a1
    
    a <- (sin(dlat/2))^2 + cos(a1) * cos(a2) * (sin(dlon/2))^2
    c <- 2 * atan2(sqrt(a), sqrt(1 - a))
    return(6378137 * c) 
  }
  
  initial_rows <- nrow(track_df)
  
  cleaned_df <- track_df |>
    dplyr::arrange(timestamp) |>
    dplyr::mutate(
      # 1. Calculate physics
      delta_hrs = as.numeric(difftime(timestamp, dplyr::lag(timestamp), units = "hours")),
      dist_miles = calc_dist_m(lon, lat) / 1609.34,
      speed_mph = dist_miles / delta_hrs,
      
      # 2. Flag Impossible Speeds
      flag_speed = ifelse(!is.na(speed_mph) & speed_mph > max_speed_mph, TRUE, FALSE),
      
      # 3. Flag Duplicate Anchors (Cell Towers)
      coord_hash = paste(round(lat, 5), round(lon, 5), sep = "_"),
      flag_duplicate = duplicated(coord_hash) | duplicated(coord_hash, fromLast = TRUE)
    ) |>
    
    # 4. THE PURGE: Keep only the good points!
    # (We also safely ignore these rules for semantic 'visits', which are reliable)
    dplyr::filter((flag_speed == FALSE & flag_duplicate == FALSE) | type == "visit") |>
    
    # 5. Clean up the temporary math columns
    dplyr::select(-delta_hrs, -dist_miles, -speed_mph, -flag_speed, -coord_hash, -flag_duplicate)
  
  dropped_rows <- initial_rows - nrow(cleaned_df)
  message("Successfully purged ", dropped_rows, " anomalous GPS points.")
  
  return(cleaned_df)
}