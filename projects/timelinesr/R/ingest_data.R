#' Clean Timeline Raw Signals (Plan A)
#'
#' Extracts high-precision GPS points ("Raw Signals") from the Google Timeline JSON.
#' These are the distinct blue dots on a map, useful for linear interpolation.
#'
#' @param raw_json_data The list object returned by jsonlite::fromJSON().
#' @return A tibble with columns: raw_timestamp, lat, lon, accuracy, altitude, timestamp_utc.
#' @export
clean_timeline_signals <- function(raw_json_data) {
  if (!"rawSignals" %in% names(raw_json_data)) return(NULL)

  tibble::as_tibble(raw_json_data$rawSignals) |>
    jsonlite::flatten() |>
    dplyr::filter(!is.na(position.LatLng)) |>
    dplyr::select(
      raw_timestamp = position.timestamp,
      latlng_string = position.LatLng,
      accuracy      = position.accuracyMeters,
      altitude      = position.altitudeMeters
    ) |>
    mutate(latlng_clean = str_remove_all(latlng_string, "[° ]")) |>
    tidyr::separate(latlng_clean, into = c("lat", "lon"), sep = ",", convert = TRUE) |>
    dplyr::mutate(timestamp_utc = ymd_hms(raw_timestamp)) |>
    dplyr::arrange(timestamp_utc)
}

#' Clean Semantic History (Plan B)
#'
#' Extracts "Place Visits" from the Google Timeline JSON.
#' robustly handles missing place names or addresses.
#'
#' @param raw_json_data The list object returned by jsonlite::fromJSON().
#' @return A tibble with columns: start_utc, end_utc, lat, lon, place_name, place_address.
#' @export
clean_semantic_history <- function(raw_json_data) {
  if (!"semanticSegments" %in% names(raw_json_data)) return(NULL)

  sem_df <- tibble::as_tibble(raw_json_data$semanticSegments)
  if (!"visit" %in% names(sem_df)) return(NULL)

  # Extract the nested "topCandidate" dataframe
  candidates <- sem_df$visit$topCandidate

  # --- SAFETY BLOCK START ---
  # Handle cases where placeLocation or its sub-columns are missing entirely

  # 1. Get the 'placeLocation' data frame safely
  if ("placeLocation" %in% names(candidates)) {
    loc_data <- candidates$placeLocation
  } else {
    # Create a dummy DF if missing
    loc_data <- tibble::tibble(latLng = rep(NA, nrow(candidates)))
  }

  # 2. Extract columns safely (fill with NA if missing)
  # We check if the column exists; if not, return NA
  safe_lat <- if("latLng" %in% names(loc_data)) loc_data$latLng else NA
  safe_name <- if("name" %in% names(loc_data)) loc_data$name else NA
  safe_addr <- if("address" %in% names(loc_data)) loc_data$address else NA
  # --- SAFETY BLOCK END ---

  sem_df |>
    dplyr::mutate(
      place_lat     = safe_lat,
      place_name    = safe_name,
      place_address = safe_addr
    ) |>
    dplyr::filter(!is.na(place_lat)) |>
    dplyr::mutate(latlng_clean = str_remove_all(place_lat, "[° ]")) |>
    tidyr::separate(latlng_clean, into = c("lat", "lon"), sep = ",", convert = TRUE) |>
    dplyr::mutate(
      start_utc = ymd_hms(startTime),
      end_utc   = ymd_hms(endTime),
      duration_m = as.numeric(difftime(end_utc, start_utc, units = "mins"))
    ) |>
    dplyr::select(start_utc, end_utc, duration_m, lat, lon, place_name, place_address) |>
    dplyr::arrange(start_utc)
}

#' Extract and Standardize Photo Timestamps
#'
#' Reads EXIF data and uses 'OffsetTimeOriginal' to accurately
#' convert the local shutter time to True UTC to match Google Location History.
#'
#' @param photo_dir Character string of the directory containing images.
#' @return A dataframe with SourceFile, local_time, and timestamp.
#' @export
get_photo_timestamps <- function(photo_dir) {

  require(exifr)
  require(dplyr)
  require(lubridate)
  require(stringr)

  files <- list.files(photo_dir, full.names = TRUE, pattern = "(?i)\\.(jpg|jpeg|arw|tiff)$")
  if (length(files) == 0) stop("No photos found.")

  tags <- exifr::read_exif(files, tags = c("SourceFile", "DateTimeOriginal", "OffsetTimeOriginal"))

  results <- tags |>
    dplyr::mutate(
      clean_time = stringr::str_replace(DateTimeOriginal, "^(\\d{4}):(\\d{2}):(\\d{2})", "\\1-\\2-\\3"),
      safe_offset = ifelse(is.na(OffsetTimeOriginal), "+00:00", OffsetTimeOriginal),
      full_time_str = paste0(clean_time, safe_offset),
      local_time = lubridate::ymd_hms(full_time_str),
      timestamp = lubridate::with_tz(local_time, tzone = "UTC")
    ) |>
    dplyr::select(SourceFile, local_time, timestamp)

  return(results)
}

#' Clean Raw Location History (Plan C)
#'
#' Extracts raw GPS pings from the 'LatLng' string column.
#' Adapted for your specific JSON format where lat/lon are combined.
#'
#' @param raw_json_data The list object returned by jsonlite::fromJSON().
#' @return A tibble with columns: timestamp, lat, lon, accuracy_m.
#' @export
clean_raw_history <- function(raw_json_data) {
  # 1. Check existence
  if (!"rawSignals" %in% names(raw_json_data)) return(NULL)

  raw_df <- tibble::as_tibble(raw_json_data$rawSignals)

  # 2. Extract the 'position' dataframe
  if (!"position" %in% names(raw_df) || !is.data.frame(raw_df$position)) {
    return(NULL)
  }
  pos_df <- raw_df$position

  # 3. Check for the specific "LatLng" column we found
  if (!"LatLng" %in% names(pos_df)) {
    return(NULL)
  }

  # 4. Process and Split
  pos_df |>
    transmute(
      # Parse the timestamp inside the position df
      timestamp = ymd_hms(timestamp),

      # Clean the string: remove '°' and spaces, leaving "21.3,-157.8"
      clean_str = str_remove_all(LatLng, "[° ]"),

      accuracy_m = if("accuracyMeters" %in% names(pos_df)) as.numeric(accuracyMeters) else NA
    ) |>
    # Split into two numeric columns
    tidyr::separate(clean_str, into = c("lat", "lon"), sep = ",", convert = TRUE) |>
    dplyr::filter(!is.na(lat), !is.na(lon)) |>
    dplyr::select(timestamp, lat, lon, accuracy_m) |>
    dplyr::arrange(timestamp)
}
