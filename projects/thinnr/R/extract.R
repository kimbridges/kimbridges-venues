# thinnr/R/extract.R
# Functions for extracting EXIF metadata from image files

#' Extract EXIF metadata from images in a folder
#'
#' Reads EXIF data from all JPG and RAW files in the specified folder,
#' computes precise timestamps, and calculates time gaps between consecutive shots.
#'
#' @param folder_path Character string specifying the full path to the image folder
#' @param extensions Character vector of file extensions to include (case-insensitive)
#'
#' @return A tibble with one row per image file, sorted by timestamp, including
#'   computed fields for precise timestamp and gap to previous shot
#'
#' @examples
#' \dontrun{
#' exif_data <- extract_exif("D:/Photos/2024/wildlife_trip")
#' }
#'
#' @export
extract_exif <- function(folder_path,
                         extensions = c("jpg", "jpeg", "arw", "raw", "cr2", "cr3", "nef")) {

  # Validate folder exists
  if (!dir.exists(folder_path)) {
    stop("Folder does not exist: ", folder_path)
  }

  # Build pattern for file matching (case-insensitive)
  pattern <- paste0("\\.(",
                    paste(extensions, collapse = "|"),
                    ")$")

  # Get list of image files
  image_files <- list.files(
    path = folder_path,
    pattern = pattern,
    ignore.case = TRUE,
    full.names = TRUE
  )

  if (length(image_files) == 0) {
    warning("No image files found in: ", folder_path)
    return(tibble::tibble())
  }

  message("Found ", length(image_files), " image files. Extracting EXIF data...")

  # Define fields to extract
  # Core fields plus Sony-specific fields that may or may not be present
  exif_tags <- c(
    # File info
    "FileName",
    "FileType",
    "FileSize",

    # Timestamps
    "DateTimeOriginal",
    "SubSecTimeOriginal",

    # Exposure
    "ExposureTime",
    "FNumber",
    "ISO",
    "ExposureCompensation",
    "ExposureMode",
    "ExposureProgram",

    # Focus and framing
    "FocalLength",
    "FocusMode",
    "FocusDistance2",
    "ImageWidth",
    "ImageHeight",
    "Orientation",

    # Lens and camera
    "LensModel",
    "Model",

    # Potentially useful Sony fields (may not be present)
    "DriveMode",
    "ReleaseMode2",
    "SequenceNumber",
    "FocusStatus",
    "AFPointSelected"
  )

  # Extract EXIF data
  exif_raw <- exifr::read_exif(
    path = image_files,
    tags = exif_tags
  )

  # Process into clean tibble
  exif_data <- exif_raw |>
    tibble::as_tibble() |>
    dplyr::mutate(
      # Extract base filename without extension for pairing JPG/RAW
      base_name = tools::file_path_sans_ext(FileName),
      file_ext = tolower(tools::file_ext(FileName)),

      # Classify as JPG or RAW
      file_type = dplyr::case_when(
        file_ext %in% c("jpg", "jpeg") ~ "JPG",
        TRUE ~ "RAW"
      ),

      # Parse subseconds (may be missing)
      subsec = as.numeric(
        dplyr::coalesce(as.character(SubSecTimeOriginal), "0")
      ),

      # Create precise timestamp
      # DateTimeOriginal is typically "YYYY:MM:DD HH:MM:SS"
      # SubSecTimeOriginal is typically centiseconds
      timestamp_precise = lubridate::ymd_hms(DateTimeOriginal) +
        lubridate::milliseconds(subsec * 10)
    ) |>
    dplyr::arrange(timestamp_precise, base_name, file_type) |>
    dplyr::select(
      # Reorder columns for readability
      FileName,
      base_name,
      file_type,
      file_ext,
      timestamp_precise,
      SequenceNumber,
      dplyr::everything(),
      -SourceFile
    )

  message("Extraction complete. ", nrow(exif_data), " file records returned.")

  # Attach folder path as attribute for reference
  attr(exif_data, "source_folder") <- folder_path

  exif_data
}


#' Consolidate file-level EXIF data to shot-level records
#'
#' Takes the raw EXIF data (one row per file) and consolidates JPG+RAW pairs
#' into single shot records. This eliminates double-counting when analyzing
#' timing and burst sequences.
#'
#' @param exif_data Tibble returned by extract_exif()
#'
#' @return A tibble with one row per shot (unique base_name), including
#'   information about which file types exist for each shot and time gaps
#'   between consecutive shots
#'
#' @export
consolidate_to_shots <- function(exif_data) {

  shots <- exif_data |>
    dplyr::group_by(base_name) |>
    dplyr::summarize(
      # Take first value for fields that should be identical across JPG/RAW
      timestamp_precise = dplyr::first(timestamp_precise),
      SequenceNumber = dplyr::first(SequenceNumber),
      DateTimeOriginal = dplyr::first(DateTimeOriginal),
      subsec = dplyr::first(subsec),

      # Exposure settings
      ExposureTime = dplyr::first(ExposureTime),
      FNumber = dplyr::first(FNumber),
      ISO = dplyr::first(ISO),
      ExposureCompensation = dplyr::first(ExposureCompensation),
      ExposureMode = dplyr::first(ExposureMode),
      ExposureProgram = dplyr::first(ExposureProgram),

      # Focus and framing
      FocalLength = dplyr::first(FocalLength),
      FocusMode = dplyr::first(FocusMode),
      FocusDistance2 = dplyr::first(FocusDistance2),
      Orientation = dplyr::first(Orientation),

      # Lens and camera
      LensModel = dplyr::first(LensModel),
      Model = dplyr::first(Model),

      # Sony-specific
      ReleaseMode2 = dplyr::first(ReleaseMode2),

      # Track which file types exist for this shot
      has_jpg = any(file_type == "JPG"),
      has_raw = any(file_type == "RAW"),
      file_types = paste(sort(unique(file_type)), collapse = "+"),

      # Sum file sizes for total storage per shot
      total_file_size = sum(FileSize, na.rm = TRUE),

      .groups = "drop"
    ) |>
    dplyr::arrange(timestamp_precise) |>
    dplyr::mutate(
      # Shot sequence number within this dataset
      shot_seq = dplyr::row_number(),

      # Calculate time gap to previous shot (in seconds)
      time_gap = as.numeric(
        difftime(timestamp_precise,
                 dplyr::lag(timestamp_precise),
                 units = "secs")
      )
    ) |>
    dplyr::select(
      shot_seq,
      base_name,
      timestamp_precise,
      time_gap,
      SequenceNumber,
      file_types,
      has_jpg,
      has_raw,
      total_file_size,
      dplyr::everything()
    )

  message("Consolidated to ", nrow(shots), " unique shots.")

  # Preserve source folder attribute
  attr(shots, "source_folder") <- attr(exif_data, "source_folder")

  shots
}


#' Identify burst groups using DateTimeOriginal as burst identifier
#'
#' Sony cameras (and likely others) use the same DateTimeOriginal timestamp for
#' all shots in a burst — it represents the burst start time. This approach
#' correctly handles interleaved bursts that occur when shooting rapid successive
#' bursts (e.g., action photography) where the buffer write order to the card
#' differs from the capture order.
#'
#' The SequenceNumber field provides position within each burst.
#'
#' Falls back to time-gap-based detection if DateTimeOriginal grouping isn't
#' available or appropriate.
#'
#' @param shots Tibble returned by consolidate_to_shots()
#' @param fallback_threshold_seconds Numeric. If DateTimeOriginal-based detection
#'   isn't available, use this time gap threshold. Default is 0.3 seconds.
#'
#' @return The input tibble with additional columns:
#'   - burst_group: unique identifier for each burst sequence
#'   - burst_id: the DateTimeOriginal value identifying this burst
#'   - burst_size: number of shots in this burst
#'   - burst_position: position within the burst (from SequenceNumber)
#'   - burst_method: "datetime_original" or "time_gap" indicating detection method
#'
#' @export
identify_bursts <- function(shots, fallback_threshold_seconds = 0.3) {

  # Check if we have the fields needed for DateTimeOriginal-based detection
  has_datetime_original <- "DateTimeOriginal" %in% names(shots) &&
    !all(is.na(shots$DateTimeOriginal))

  has_sequence_number <- "SequenceNumber" %in% names(shots) &&
    !all(is.na(shots$SequenceNumber))

  if (has_datetime_original && has_sequence_number) {
    message("Using DateTimeOriginal as burst identifier (handles interleaved bursts).")

    # Each unique DateTimeOriginal represents a distinct burst or grouping
    shots <- shots |>
      dplyr::mutate(
        burst_id = DateTimeOriginal,
        burst_method = "datetime_original"
      ) |>
      dplyr::group_by(burst_id) |>
      dplyr::mutate(
        burst_size = dplyr::n(),
        # Check if SequenceNumber is meaningful (not all zeros)
        has_valid_sequence = any(SequenceNumber > 0, na.rm = TRUE)
      ) |>
      dplyr::ungroup()

    # Handle two cases: valid SequenceNumber vs all-zeros
    shots <- shots |>
      dplyr::group_by(burst_id) |>
      dplyr::mutate(
        # If SequenceNumber is valid, use it; otherwise assign position by subsec timing
        burst_position = dplyr::if_else(
          has_valid_sequence,
          as.integer(SequenceNumber),
          dplyr::row_number(subsec)  # Order by subsecond within group
        ),
        # Determine original size and completeness based on whether sequence is valid
        burst_original_size = dplyr::if_else(
          has_valid_sequence,
          max(SequenceNumber, na.rm = TRUE),
          burst_size  # If no valid sequence, assume what we have is complete
        ),
        burst_complete = dplyr::if_else(
          has_valid_sequence,
          # Valid sequence: check if all shots 1..max are present
          min(SequenceNumber, na.rm = TRUE) == 1L &
            max(SequenceNumber, na.rm = TRUE) == burst_size &
            dplyr::n_distinct(SequenceNumber) == burst_size,
          # No valid sequence (all zeros): treat as complete quick-succession shots
          TRUE
        ),
        # Flag the type of grouping
        burst_type = dplyr::if_else(
          has_valid_sequence,
          "continuous_burst",
          "quick_succession"
        )
      ) |>
      dplyr::ungroup() |>
      # Create numeric burst_group based on first appearance order
      dplyr::mutate(
        burst_group = as.integer(factor(burst_id, levels = unique(burst_id)))
      ) |>
      dplyr::select(-has_valid_sequence)

  } else {
    message("DateTimeOriginal/SequenceNumber not available. ",
            "Falling back to time gap detection (threshold: ",
            fallback_threshold_seconds, "s).")

    shots <- shots |>
      dplyr::mutate(
        # New burst starts when gap exceeds threshold
        new_burst = is.na(time_gap) | time_gap > fallback_threshold_seconds,
        burst_group = cumsum(new_burst),
        burst_id = as.character(burst_group),  # Placeholder ID
        burst_method = "time_gap"
      ) |>
      dplyr::group_by(burst_group) |>
      dplyr::mutate(
        burst_position = dplyr::row_number(),
        burst_size = dplyr::n(),
        burst_original_size = burst_size,  # Assumed complete for time-gap method
        burst_complete = TRUE,
        burst_type = "time_grouped"  # Unknown if true burst or quick succession
      ) |>
      dplyr::ungroup() |>
      dplyr::select(-new_burst)
  }

  # Summary message
  n_bursts <- dplyr::n_distinct(shots$burst_group[shots$burst_size > 1])
  n_complete <- dplyr::n_distinct(shots$burst_group[shots$burst_size > 1 & shots$burst_complete])
  n_singletons <- sum(shots$burst_size == 1)
  total_in_bursts <- sum(shots$burst_size > 1)
  
  # Count by burst type if available
  if ("burst_type" %in% names(shots)) {
    type_counts <- shots |>
      dplyr::filter(burst_size > 1) |>
      dplyr::distinct(burst_group, burst_type) |>
      dplyr::count(burst_type)
    type_summary <- paste(type_counts$n, type_counts$burst_type, collapse = ", ")
    message("Identified ", n_bursts, " groupings (", total_in_bursts, " shots): ",
            type_summary, ". ",
            n_complete, " complete, ", n_bursts - n_complete, " partial. ",
            n_singletons, " singletons.")
  } else {
    message("Identified ", n_bursts, " burst sequences (",
            total_in_bursts, " shots): ",
            n_complete, " complete, ", n_bursts - n_complete, " partial. ",
            n_singletons, " singletons.")
  }

  shots
}


#' Get filenames for a shot (both JPG and RAW if present)
#'
#' Utility function to retrieve the original filenames associated with a shot,
#' useful when applying actions (tagging, moving, etc.) to both files.
#'
#' @param exif_data Original tibble from extract_exif() (file-level)
#' @param shot_base_name Character. The base filename to look up.
#'
#' @return Character vector of filenames (e.g., c("IMG_1234.JPG", "IMG_1234.ARW"))
#'
#' @export
get_shot_files <- function(exif_data, shot_base_name) {
  exif_data |>
    dplyr::filter(base_name == shot_base_name) |>
    dplyr::pull(FileName)
}
