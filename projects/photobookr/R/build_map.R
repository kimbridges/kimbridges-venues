#' Build an interactive map from photo locations
#'
#' Creates an interactive HTML map showing photo locations, grouped by Event.
#' Requires the leaflet and htmlwidgets packages.
#'
#' @param config_file Path to YAML configuration file (default: "config.yaml")
#' @param used_images_only If TRUE, only map images that were used in the book
#'   (requires running build_book first to generate used_images.csv). 
#'   Default FALSE maps all images with GPS data.
#'
#' @return Invisibly returns the path to the created HTML file
#' @export
#'
#' @examples
#' \dontrun{
#' # Map all images with GPS coordinates
#' build_map()
#'
#' # Map only images used in the book
#' build_book()
#' build_map(used_images_only = TRUE)
#' }
build_map <- function(config_file = "config.yaml", used_images_only = FALSE) {
  
  ## Check for required packages

  if (!requireNamespace("leaflet", quietly = TRUE)) {
    stop("Package 'leaflet' is required for map generation. ",
         "Install with: install.packages('leaflet')")
  }
  if (!requireNamespace("htmlwidgets", quietly = TRUE)) {
    stop("Package 'htmlwidgets' is required for map generation. ",
         "Install with: install.packages('htmlwidgets')")
  }
  
  ## Read config
  cfg <- read_config(config_file)
  images_folder <- cfg$folders$images
  output_map <- cfg$map$output_file %||% "Photo_Book_map.html"
  
  message("Map config: images_folder = ", images_folder, " | output = ", output_map)
  
  ## Get image list
  all_images <- list.files(images_folder, pattern = "\\.jpg$", 
                           ignore.case = TRUE, full.names = TRUE)
  
  ## Optionally filter to used images
  if (used_images_only) {
    used_csv <- "used_images.csv"
    if (file.exists(used_csv)) {
      message("Filtering to images used in book...")
      used_df <- tryCatch(
        utils::read.csv(used_csv, stringsAsFactors = FALSE),
        error = function(e) NULL
      )
      if (!is.null(used_df) && "FullPath" %in% names(used_df)) {
        keep_set <- normalizePath(used_df$FullPath, winslash = "/", mustWork = FALSE)
        all_images <- normalizePath(all_images, winslash = "/", mustWork = FALSE)
        all_images <- intersect(all_images, keep_set)
      }
    } else {
      message("Note: used_images.csv not found. Mapping all images.")
    }
  }
  
  if (length(all_images) == 0) {
    message("No images to map.")
    return(invisible(NULL))
  }
  
  ## Extract GPS data
  photo_rows <- list()
  
  for (img in all_images) {
    exif <- tryCatch(
      exifr::read_exif(img, tags = c("Event", "GPSLatitude", "GPSLongitude", "Description")),
      error = function(e) NULL
    )
    if (is.null(exif)) next
    
    ev <- safe_get_exif(exif, "Event")
    lat <- suppressWarnings(as.numeric(safe_get_exif(exif, "GPSLatitude")))
    lon <- suppressWarnings(as.numeric(safe_get_exif(exif, "GPSLongitude")))
    desc <- safe_get_exif(exif, "Description")
    
    if (!is.null(ev) && !is.na(lat) && !is.na(lon)) {
      photo_rows[[length(photo_rows) + 1]] <- data.frame(
        Event = ev,
        Lat = lat,
        Lon = lon,
        Description = if (is.null(desc) || is.na(desc)) "No description" else desc,
        FileName = basename(img),
        stringsAsFactors = FALSE
      )
    }
  }
  
  if (length(photo_rows) == 0) {
    message("No photos with Event + GPS data found. Skipping map creation.")
    return(invisible(NULL))
  }
  
  photo_data <- do.call(rbind, photo_rows)
  message("Found ", nrow(photo_data), " mappable photos")
  
  ## Build map
  unique_events <- sort(unique(photo_data$Event))
  pal <- leaflet::colorFactor(palette = grDevices::rainbow(length(unique_events)), 
                               domain = unique_events)
  
  m <- leaflet::leaflet(photo_data) |>
    leaflet::addProviderTiles(leaflet::providers$OpenStreetMap, group = "Street Map") |>
    leaflet::addProviderTiles(leaflet::providers$Esri.WorldImagery, group = "Satellite") |>
    leaflet::addProviderTiles(leaflet::providers$OpenTopoMap, group = "Topographic")
  
  for (ev in unique_events) {
    ev_data <- photo_data[photo_data$Event == ev, ]
    m <- leaflet::addCircleMarkers(
      m,
      data = ev_data,
      lng = ~Lon, lat = ~Lat,
      popup = ~paste0("<b>", Description, "</b><br>", FileName),
      radius = 6, 
      color = ~pal(Event), 
      stroke = TRUE, 
      fillOpacity = 0.8,
      group = ev
    )
  }
  
  m <- leaflet::addLayersControl(
    m,
    baseGroups = c("Street Map", "Satellite", "Topographic"),
    overlayGroups = unique_events,
    options = leaflet::layersControlOptions(collapsed = FALSE)
  )
  
  ## Save map
  htmlwidgets::saveWidget(m, file = output_map, selfcontained = TRUE)
  message("Map created: ", output_map)
  
  invisible(output_map)
}
