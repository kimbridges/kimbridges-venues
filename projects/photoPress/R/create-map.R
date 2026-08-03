#' Create an Interactive Map
#'
#' Generates an interactive Leaflet map from photo GPS data.
#' @param output_map_file The name of the final HTML map file.
#' @param image_folder The directory containing the JPG images.
#' @export
create_map <- function(output_map_file = "Interactive_Event_Map.html", image_folder = "Keepers") {
  all_images <- list.files(image_folder, pattern = "\\.jpg$", ignore.case = TRUE)
  photo_data_list <- list()
  cat("Gathering metadata from all images for map...\n")
  for (image_file in all_images) {
    full_path <- file.path(image_folder, image_file)
    tags_to_read <- c("Event", "GPSLatitude", "GPSLongitude", "Description")
    exif_data <- exifr::read_exif(full_path, tags = tags_to_read)
    if (!is.null(exif_data$Event) && !is.null(exif_data$GPSLatitude)) {
      photo_data_list[[length(photo_data_list) + 1]] <- data.frame(
        Event = exif_data$Event, Lat = exif_data$GPSLatitude, Lon = exif_data$GPSLongitude,
        Description = ifelse(!is.null(exif_data$Description), exif_data$Description, "No description."),
        FileName = image_file
      )
    }
  }
  photo_data <- do.call(rbind, photo_data_list)
  cat(paste("Found", nrow(photo_data), "photos with complete GPS and Event data.\n"))
  unique_events <- unique(photo_data$Event)
  rainbow_colors <- grDevices::rainbow(length(unique_events))
  pal <- leaflet::colorFactor(palette = rainbow_colors, domain = unique_events)
  event_map <- leaflet::leaflet(data = photo_data) %>%
    leaflet::addProviderTiles(leaflet::providers$OpenStreetMap, group = "Street Map") %>%
    leaflet::addProviderTiles(leaflet::providers$Esri.WorldImagery, group = "Satellite") %>%
    leaflet::addProviderTiles(leaflet::providers$OpenTopoMap, group = "Topographic")
  cat("Building map layers for each event category...\n")
  for (event_cat in unique_events) {
    category_data <- photo_data[photo_data$Event == event_cat, ]
    event_map <- event_map %>%
      leaflet::addCircleMarkers(
        data = category_data, lng = ~Lon, lat = ~Lat, popup = ~paste0("<b>", Description, "</b><br>", FileName),
        radius = 6, color = ~pal(Event), stroke = TRUE, fillOpacity = 0.8, group = event_cat
      )
  }
  event_map <- event_map %>%
    leaflet::addLayersControl(
      baseGroups = c("Street Map", "Satellite", "Topographic"),
      overlayGroups = unique_events, options = leaflet::layersControlOptions(collapsed = FALSE)
    )
  for(event_cat in unique_events) { event_map <- event_map %>% leaflet::hideGroup(event_cat) }
  htmlwidgets::saveWidget(event_map, file = output_map_file, selfcontained = TRUE)
  cat(paste0("\nSuccess! Your interactive map has been created:\n", output_map_file, "\n"))
}
