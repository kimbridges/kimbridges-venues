#| label: Initialize_Function
#| message: false
#| echo: false
#| warning: false

# It's good practice to load libraries at the start of your script or ensure
# they are loaded before the function is called.
# For a function intended for a package or wider distribution, you'd use
# roxygen2 directives like @importFrom dplyr filter
library(exifr)
library(dplyr)
library(xml2)

process_photo_locations <- function(folder_path,
                                   output_gpx_file = "photo_track.gpx",
                                   recursive_search = TRUE,
                                   create_gpx = TRUE,
                                   quiet_exif = TRUE) {

  # --- 0. Initialize Stats Variables ---
  stats <- list(
    total_images_found = 0,
    images_with_exif_read = 0,
    images_with_gps_data = 0,
    earliest_datetime_original = NA,
    latest_datetime_original = NA,
    earliest_geotagged_time_utc = NA,
    latest_geotagged_time_utc = NA,
    gpx_output_file = NA_character_ # Using NA_character_ for character NAs
  )

  # --- 1. Extract EXIF Data ---
  message("Extracting EXIF data from photos in: ", folder_path)

  image_files <- list.files(
    path = folder_path,
    pattern = "\\.jpg$|\\.jpeg$|\\.heic$",
    full.names = TRUE,
    recursive = recursive_search
  )

  stats$total_images_found <- length(image_files)

  if (stats$total_images_found == 0) {
    warning("No image files found in '", folder_path, "'. Check path and pattern.")
    # Return early with current stats if no files found
    return(list(summary_stats = stats, gpx_data = NULL, gpx_file_path = NA_character_))
  }

  # Read EXIF data.
  exif_data_raw <- read_exif(
    path = image_files,
    tags = c("SourceFile", "DateTimeOriginal", "GPSLatitude", "GPSLongitude", "GPSAltitude", "CreateDate"), # Added CreateDate as potential fallback
    quiet = quiet_exif
  )

  if (nrow(exif_data_raw) == 0) {
      message("No EXIF data could be read from the found images.")
      # Update stats and return
      stats$images_with_exif_read <- 0
      return(list(summary_stats = stats, gpx_data = NULL, gpx_file_path = NA_character_))
  }
  
  stats$images_with_exif_read <- nrow(exif_data_raw)
  message("EXIF data extraction complete. Found data for ", stats$images_with_exif_read, " out of ", stats$total_images_found, " images.")

  # --- Calculate initial date/time statistics from raw EXIF data ---
  # Use coalesce to try DateTimeOriginal first, then CreateDate
  # Ensure dates are POSIXct for min/max operations
  datetime_values <- coalesce(
      as.POSIXct(exif_data_raw$DateTimeOriginal, format = "%Y:%m:%d %H:%M:%S", tz = "UTC"), # exifr often standardizes to this format if TZ is known
      as.POSIXct(exif_data_raw$CreateDate, format = "%Y:%m:%d %H:%M:%S", tz = "UTC")
  )
  
  if(any(!is.na(datetime_values))) {
      stats$earliest_datetime_original <- min(datetime_values, na.rm = TRUE)
      stats$latest_datetime_original <- max(datetime_values, na.rm = TRUE)
  }


  # --- 2. Process and Clean Data ---
  gps_data <- exif_data_raw %>%
    filter(!is.na(GPSLatitude) & !is.na(GPSLongitude)) %>%
    mutate(
      # Prioritize DateTimeOriginal, then CreateDate for the timestamp
      time_str = coalesce(DateTimeOriginal, CreateDate),
      # Convert time to POSIXct. GPX requires UTC.
      # The original script assumed DateTimeOriginal was already in a format for as.POSIXct with UTC.
      # ExifTool (used by exifr) attempts to convert times to UTC if the original timezone is specified in EXIF.
      # If not, it might be local time. Forcing UTC here is standard for GPX.
      time = as.POSIXct(time_str, format = "%Y:%m:%d %H:%M:%S", tz = "UTC")
    ) %>%
    filter(!is.na(time)) %>%
    arrange(time) %>%
    select(SourceFile, time, GPSLatitude, GPSLongitude, GPSAltitude) # Keep SourceFile for potential later use

  stats$images_with_gps_data <- nrow(gps_data)

  if (stats$images_with_gps_data == 0) {
    message("No photos with valid GPS and time data found. Cannot create a GPX track.")
    # No GPX data, but we have some stats, so return them
    return(list(summary_stats = stats, gpx_data = gps_data, gpx_file_path = NA_character_))
  }

  message("Found ", stats$images_with_gps_data, " photos with valid GPS and time data.")

  # --- Calculate statistics for geo-tagged data ---
  stats$earliest_geotagged_time_utc <- min(gps_data$time, na.rm = TRUE)
  stats$latest_geotagged_time_utc <- max(gps_data$time, na.rm = TRUE)

  # --- 3. Create GPX XML Structure (Conditional) ---
  if (create_gpx) {
    message("Creating GPX file: ", output_gpx_file)

    gpx_root <- xml_new_root("gpx",
                             version = "1.1",
                             creator = "R-Photo-Location-Processor",
                             namespaces = c(
                               gpx = "http://www.topografix.com/GPX/1/1",
                               xsi = "http://www.w3.org/2001/XMLSchema-instance",
                               "xsi:schemaLocation" = "http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd"
                             ))

    track_node <- xml_add_child(gpx_root, "trk")
    xml_add_child(track_node, "name", paste0("Photo Track - ", basename(folder_path)))
    xml_add_child(track_node, "desc", paste("GPS track generated from", stats$images_with_gps_data, "photos in folder", folder_path, "on", Sys.Date()))

    trackseg_node <- xml_add_child(track_node, "trkseg")

    for (i in 1:nrow(gps_data)) {
      trkpt_node <- xml_add_child(trackseg_node, "trkpt",
                                  lat = as.character(gps_data$GPSLatitude[i]),
                                  lon = as.character(gps_data$GPSLongitude[i]))

      if (!is.na(gps_data$GPSAltitude[i])) {
        xml_add_child(trkpt_node, "ele", as.character(round(gps_data$GPSAltitude[i], 2)))
      }
      xml_add_child(trkpt_node, "time", format(gps_data$time[i], format = "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"))
    }

    # --- 4. Write the GPX File ---
    write_xml(gpx_root, file = output_gpx_file, options = c("format", "no_declaration"))
    stats$gpx_output_file <- normalizePath(output_gpx_file) # Store the full path
    message("GPX file '", stats$gpx_output_file, "' created successfully!")
  } else {
    message("GPX file creation skipped as per 'create_gpx = FALSE'.")
    stats$gpx_output_file <- NA_character_
  }

  # --- 5. Return Results ---
  message("Processing complete.")
  # Convert POSIXct times in stats to character for cleaner display if not further computed
  stats$earliest_datetime_original <- as.character(stats$earliest_datetime_original)
  stats$latest_datetime_original <- as.character(stats$latest_datetime_original)
  stats$earliest_geotagged_time_utc <- as.character(stats$earliest_geotagged_time_utc)
  stats$latest_geotagged_time_utc <- as.character(stats$latest_geotagged_time_utc)


  return(list(
    summary_stats = stats,
    gpx_data = gps_data, # This contains the data used for GPX points
    gpx_file_path = stats$gpx_output_file
  ))
}