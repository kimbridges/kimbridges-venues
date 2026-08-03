#' Fuse Visits and Raw Locations into a Single Track
#'
#' Combines semantic visits and raw GPS paths into a single, chronologically
#' sorted dataframe. Filters out low-confidence GPS points.
#'
#' @param timeline_data The list object returned by read_timeline().
#' @param max_accuracy Maximum allowed uncertainty radius in meters.
#'                     Points with a higher value are dropped. Defaults to 300.
#' @return A dataframe representing the continuous track.
#' @export
fuse_layers <- function(timeline_data, max_accuracy = 300) {

  require(dplyr)
  require(tibble)

  message("Fusing timeline layers...")

  # 1. Process Raw Locations (The Blue Dots)
  if (!is.null(timeline_data$raw_locations) && nrow(timeline_data$raw_locations) > 0) {

    # Check if the accuracy column exists (Google sometimes changes their JSON schema)
    has_accuracy <- "accuracy" %in% names(timeline_data$raw_locations)

    paths <- timeline_data$raw_locations |>
      tibble::as_tibble() |>
      dplyr::select(any_of(c("timestamp", "lat", "lon", "accuracy"))) |>
      dplyr::mutate(type = "path")

    # Apply the Accuracy Filter!
    if (has_accuracy) {
      initial_rows <- nrow(paths)
      paths <- paths |>
        # Keep points with good accuracy, or points where accuracy is missing (just in case)
        dplyr::filter(is.na(accuracy) | accuracy <= max_accuracy)

      dropped <- initial_rows - nrow(paths)
      message("Dropped ", dropped, " low-accuracy GPS points (threshold: ", max_accuracy, "m).")
    }

  } else {
    paths <- tibble::tibble()
  }

  # 2. Process Semantic Visits (The Red Anchors)
  if (!is.null(timeline_data$visits) && nrow(timeline_data$visits) > 0) {
    visits <- timeline_data$visits |>
      tibble::as_tibble() |>
      dplyr::select(any_of(c("timestamp", "lat", "lon"))) |>
      dplyr::mutate(
        type = "visit",
        accuracy = 0 # We assume semantic visits are highly accurate anchors
      )
  } else {
    visits <- tibble::tibble()
  }

  # 3. Combine and Sort
  fused_track <- dplyr::bind_rows(paths, visits) |>
    dplyr::arrange(timestamp) |>
    # Drop rows with missing coordinates
    dplyr::filter(!is.na(lat), !is.na(lon))

  message("Fusion complete. Total points: ", nrow(fused_track))

  return(fused_track)
}
