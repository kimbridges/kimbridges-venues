## --- make_map.R (refactor) ---
suppressPackageStartupMessages({
  library(tidyverse)
  library(readr)
  library(exifr)
  library(leaflet)
  library(htmlwidgets)
})

images_folder <- Sys.getenv("PB_IMAGES_FOLDER", unset = "Keepers")
output_map    <- Sys.getenv("PB_MAP_HTML", unset = "Interactive_Event_Map.html")

message("Map config: images_folder = ", images_folder, " | output = ", output_map)

all_images <- list.files(images_folder, pattern = "\\.jpg$", ignore.case = TRUE, full.names = TRUE)

used_csv <- Sys.getenv("PB_USED_IMAGES_CSV", unset = "")
if (nzchar(used_csv) && file.exists(used_csv)) {
  message("Limiting map to images used in the book: ", used_csv)
  used_df <- tryCatch(readr::read_csv(used_csv, show_col_types = FALSE), error = function(e) NULL)
  if (!is.null(used_df)) {
    # Prefer FullPath if present, otherwise fall back to FileName matching
    if ("FullPath" %in% names(used_df)) {
      keep_set <- normalizePath(used_df$FullPath, winslash = "/", mustWork = FALSE)
      all_images <- normalizePath(all_images, winslash = "/", mustWork = FALSE)
      all_images <- intersect(all_images, keep_set)
    } else if ("FileName" %in% names(used_df)) {
      bn <- basename(all_images)
      all_images <- all_images[bn %in% used_df$FileName]
    }
  }
}


# helper to safely extract a single value from a data.frame
get_field <- function(x, nm) {
  if (is.null(x) || !nzchar(nm) || !(nm %in% names(x))) return(NA)
  # return the first row if multiple
  val <- x[[nm]][1]
  if (length(val) == 0) return(NA)
  val
}

photo_rows <- list()
for (img in all_images) {
  exif <- tryCatch(
    read_exif(img, tags = c("Event","GPSLatitude","GPSLongitude","Description")),
    error = function(e) NULL
  )
  if (is.null(exif)) next
  
  ev  <- get_field(exif, "Event")
  lat <- suppressWarnings(as.numeric(get_field(exif, "GPSLatitude")))
  lon <- suppressWarnings(as.numeric(get_field(exif, "GPSLongitude")))
  desc <- get_field(exif, "Description")
  
  # require Event + numeric lat/lon
  if (!is.na(ev) && !is.na(lat) && !is.na(lon)) {
    photo_rows[[length(photo_rows)+1]] <- tibble::tibble(
      Event = ev,
      Lat   = lat,
      Lon   = lon,
      Description = ifelse(is.na(desc) || desc == "", "No description.", desc),
      FileName    = basename(img)
    )
  }
}


if (length(photo_rows) == 0) {
  message("No mappable photos (need Event + GPS). Skipping map creation.")
} else {
  photo_data <- list_rbind(photo_rows)
  unique_events <- sort(unique(photo_data$Event))
  pal <- colorFactor(palette = rainbow(length(unique_events)), domain = unique_events)
  
  m <- leaflet(photo_data) %>%
    addProviderTiles(providers$OpenStreetMap, group = "Street Map") %>%
    addProviderTiles(providers$Esri.WorldImagery, group = "Satellite") %>%
    addProviderTiles(providers$OpenTopoMap, group = "Topographic")
  
  for (ev in unique_events) {
    m <- m %>%
      addCircleMarkers(
        data = filter(photo_data, Event == ev),
        lng = ~Lon, lat = ~Lat,
        popup = ~paste0("<b>", Description, "</b><br>", FileName),
        radius = 6, color = ~pal(Event), stroke = TRUE, fillOpacity = 0.8,
        group = ev
      )
  }
  
  m <- m %>%
    addLayersControl(
      baseGroups = c("Street Map", "Satellite", "Topographic"),
      overlayGroups = unique_events,
      options = layersControlOptions(collapsed = FALSE)
    )
  
  ## Start with layers hidden (optional UX)
  for (ev in unique_events) m <- hideGroup(m, ev)
  
  saveWidget(m, file = output_map, selfcontained = TRUE)
  message("Map created: ", output_map)
}
