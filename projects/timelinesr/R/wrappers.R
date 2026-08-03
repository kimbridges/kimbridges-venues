#' Read Google Timeline JSON
#'
#' High-level wrapper to ingest Google Location History data.
#' Returns both Semantic (Place) visits and Raw GPS signals.
#'
#' @param json_path Path to the JSON file (e.g., "Timelines/History.json").
#' @return A list containing two tibbles: $visits (Semantic) and $raw_locations (GPS).
#' @export
read_timeline <- function(json_path) {
  if (!file.exists(json_path)) stop("File not found: ", json_path)

  message("Reading Timeline JSON (this may take a moment)...")
  raw_json <- jsonlite::fromJSON(json_path)

  # Process Plan B (Semantic Places)
  visits_df <- clean_semantic_history(raw_json)

  # Process Plan C (Raw GPS)
  raw_df <- clean_raw_history(raw_json)

  list(
    visits = visits_df,
    raw_locations = raw_df
  )
}

#' Write Geotags to Image Files
#'
#' Uses ExifTool to write the calculated latitude and longitude back into the
#' original image files.
#'
#' @param tagged_df The dataframe returned by geotag_photos().
#' @export
write_geotags <- function(tagged_df) {

  # 1. Filter to only successful tags
  to_write <- tagged_df |>
    dplyr::filter(!is.na(lat), !is.na(lon))

  if (nrow(to_write) == 0) {
    message("No geotagged photos to write.")
    return(NULL)
  }

  message("Writing EXIF tags to ", nrow(to_write), " images...")

  # 2. Iterate and Write (using exifr/exiftool)
  # We use a loop here for safety, though batch commands are possible.
  for (i in 1:nrow(to_write)) {
    row <- to_write[i, ]

    # Construct the command directly for exiftool is often safest,
    # but let's use the package wrapper if you prefer.
    # Here is a robust system command approach that works on Mac/Linux/Windows:

    cmd <- sprintf(
      'exiftool -overwrite_original -GPSLatitude="%s" -GPSLongitude="%s" -GPSLatitudeRef="%s" -GPSLongitudeRef="%s" "%s"',
      abs(row$lat), abs(row$lon),
      ifelse(row$lat >= 0, "N", "S"),
      ifelse(row$lon >= 0, "E", "W"),
      row$SourceFile
    )

    system(cmd, ignore.stdout = TRUE, ignore.stderr = TRUE)
  }

  message("Done!")
}


#' Geotag Photos using Hybrid Track with Confidence Thresholds
#'
#' @param track_df The dataframe returned by fuse_layers().
#' @param photos_df A dataframe of photos.
#' @param max_gap_mins Maximum allowed time (in minutes) gap. Defaults to 60.
#' @export
geotag_photos <- function(track_df, photos_df, max_gap_mins = 60) {

  # 1. Standardize Photo Column Names
  if ("timestamp_utc" %in% names(photos_df) && !"timestamp" %in% names(photos_df)) {
    photos_df <- photos_df |> dplyr::rename(timestamp = timestamp_utc)
  }

  # 2. THE BOUNCER: Strip NAs and force strict chronological sorting
  track_df <- track_df |>
    dplyr::filter(!is.na(timestamp), !is.na(lat), !is.na(lon)) |>
    dplyr::arrange(timestamp)

  # Also protect against photos that failed to read EXIF dates
  photos_df <- photos_df |>
    dplyr::filter(!is.na(timestamp))

  if (nrow(track_df) == 0) stop("Track data has no valid timestamps or coordinates.")
  if (nrow(photos_df) == 0) stop("No valid photo timestamps found.")

  track_time <- as.numeric(track_df$timestamp)
  photo_time <- as.numeric(photos_df$timestamp)

  # 3. Base Interpolation
  lat_interp <- approx(x = track_time, y = track_df$lat, xout = photo_time, rule = 1)$y
  lon_interp <- approx(x = track_time, y = track_df$lon, xout = photo_time, rule = 1)$y

  # 4. Gap Checking
  idx <- findInterval(photo_time, track_time)
  min_dist_sec <- rep(Inf, length(photo_time))
  valid_idx <- idx > 0 & idx < length(track_time)

  dist_prev <- photo_time[valid_idx] - track_time[idx[valid_idx]]
  dist_next <- track_time[idx[valid_idx] + 1] - photo_time[valid_idx]
  min_dist_sec[valid_idx] <- pmin(dist_prev, dist_next)

  exact_last <- idx == length(track_time) & photo_time == track_time[length(track_time)]
  min_dist_sec[exact_last] <- 0

  # 5. Apply Threshold
  max_gap_sec <- max_gap_mins * 60
  invalid_mask <- min_dist_sec > max_gap_sec

  lat_interp[invalid_mask] <- NA
  lon_interp[invalid_mask] <- NA

  # 6. Merge Results
  results <- photos_df |>
    dplyr::mutate(
      lat = lat_interp,
      lon = lon_interp,
      geotag_status = dplyr::case_when(
        !is.na(lat) ~ "geotagged",
        invalid_mask ~ "gap_too_large",
        TRUE ~ "out_of_range"
      )
    )

  return(results)
}
