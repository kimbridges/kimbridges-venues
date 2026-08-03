#' Process Photo EXIF Data to Extract Locations and Create GPX Track
#'
#' This function scans a folder of images, extracts EXIF metadata (GPS location, timestamps),
#' generates summary statistics about the photos, and optionally creates a GPX file
#' representing a track of the photo locations.
#'
#' @param folder_path Character string: The path to the folder containing image files.
#' @param output_gpx_file Character string: The name (and path) for the output GPX file.
#'        Defaults to "photo_track.gpx".
#' @param recursive_search Logical: If TRUE, searches for images in subfolders of `folder_path`.
#'        Defaults to TRUE.
#' @param create_gpx Logical: If TRUE, a GPX file will be created. If FALSE, only
#'        statistics and data are returned. Defaults to TRUE.
#' @param quiet_exif Logical: Passed to `exifr::read_exif()`. If TRUE, suppresses
#'        messages from the ExifTool call. Defaults to TRUE.
#'
#' @return A list containing three elements:
#'   \item{summary_stats}{A list of summary statistics (e.g., number of images, date ranges).}
#'   \item{gpx_data}{A data frame of the processed GPS points and times used for the GPX track.}
#'   \item{gpx_file_path}{A character string with the absolute path to the created GPX file,
#'          or NA if `create_gpx` is FALSE or no data was available.}
#'
#' @importFrom exifr read_exif
#' @importFrom dplyr filter mutate arrange select %>%
#' @importFrom xml2 xml_new_root xml_add_child write_xml
#' @importFrom utils head
#'
#' @examples
#' \dontrun{
#' # Ensure libraries are loaded first
#' # library(exifr)
#' # library(dplyr)
#' # library(xml2)
#'
#' # Create a dummy folder with some JPEGs for testing
#' # dir.create("my_photos")
#' # # (Add some photos with GPS data to "my_photos")
#'
#' results <- process_photo_locations(
#'   folder_path = "my_photos",
#'   output_gpx_file = "MyTrip.gpx"
#' )
#' print(results$summary_stats)
#'
#' # To only get stats:
#' stats_only <- process_photo_locations("my_photos", create_gpx = FALSE)
#' print(stats_only$summary_stats)
#' }
#' @export
process_photo_locations <- function(...) { /* ... as above ... */ }