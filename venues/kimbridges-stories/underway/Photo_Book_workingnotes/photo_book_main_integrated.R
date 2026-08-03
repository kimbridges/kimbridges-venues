## --- Photo Book (integrated with two-page spreads) ---
## Images ending in "_2W" before extension span two pages
## All other images get single-page treatment

## 0. Libraries
suppressPackageStartupMessages({
  library(tidyverse)
  library(readr)
  library(stringr)
  library(exifr)
  library(pdftools)
  library(gt)
  library(magick)
  library(exiftoolr)  # needed for spread_pdf
})

## 1. Source the page-creation functions
source("photo_image_function.R")   # provides image_pdf()
source("spread_pdf.R")             # provides create_spread_pdf()

## 2. Helpers
`%||%` <- function(a, b) if (is.null(a)) b else a

read_config <- function(path = "config.csv") {
  if (!file.exists(path)) stop("Config not found: ", path)
  cfg <- read_csv(path, col_names = c("key","value"), show_col_types = FALSE, progress = FALSE)
  setNames(as.list(cfg$value), cfg$key)
}

matched_fullpaths <- character(0)
matched_basenames <- character(0)

## Check if filename ends with "_2W" (case-insensitive, before extension)
is_two_page_spread <- function(filepath) {
  base <- tools::file_path_sans_ext(basename(filepath))
  str_detect(base, regex("_2W$", ignore_case = TRUE))
}

## Parse story filename like "07_paris.pdf" -> list(order = 7, stem = "paris")
parse_story_filename <- function(fname) {
  base <- tools::file_path_sans_ext(basename(fname))
  m <- str_match(base, "^(\\d+)_(.+)$")
  if (is.na(m[1,1])) {
    list(order = Inf, stem = base)
  } else {
    list(order = as.integer(m[1,2]), stem = m[1,3])
  }
}

## Case-insensitive equality with trimming
eq_ci <- function(a, b) {
  str_trim(str_to_lower(a)) == str_trim(str_to_lower(b))
}

## Safe EXIF read for a single file (only needed tags)
safe_read_exif <- function(path, tags) {
  tryCatch(read_exif(path, tags = tags), error = function(e) NULL)
}

## 3. Load configuration
cfg <- read_config("config.csv")

book_name       <- cfg$book_name      %||% "Untitled Photo Book"
cover_file      <- cfg$cover_file     %||% "cover.pdf"
stories_folder  <- cfg$stories_folder %||% "Stories"
images_folder   <- cfg$images_folder  %||% "Keepers"
kml_folder      <- cfg$kml_folder     %||% "KML"
output_pdf      <- cfg$output_pdf     %||% "Photo_Book.pdf"
make_map        <- tolower(cfg$make_map %||% "false") == "true"
map_html        <- cfg$map_html       %||% "Interactive_Event_Map.html"
use_gt_mods     <- tolower(cfg$use_gt_mods %||% "false") == "true"
gt_mods_file    <- cfg$gt_mods_file   %||% "gt_mods.R"

## 4. Pre-flight checks
if (!dir.exists(stories_folder)) stop("Stories folder not found: ", stories_folder)
if (!dir.exists(images_folder))  stop("Images folder not found: ", images_folder)
if (!dir.exists(kml_folder))     dir.create(kml_folder, recursive = TRUE)

if (use_gt_mods && file.exists(gt_mods_file)) {
  source(gt_mods_file)
}

## 5. Discover and order stories by numeric prefix
story_files <- list.files(stories_folder, pattern = "\\.pdf$", full.names = TRUE)
if (length(story_files) == 0) stop("No story PDFs found in: ", stories_folder)

story_tbl <- tibble(file = story_files) %>%
  mutate(parsed = map(file, ~parse_story_filename(.x)),
         order  = map_int(parsed, "order"),
         stem   = map_chr(parsed, "stem")) %>%
  arrange(order, stem)

## 6. Load images list once
image_files <- list.files(images_folder, pattern = "\\.jpg$", ignore.case = TRUE, full.names = TRUE)

## 7. Build book
pages_to_combine <- c()
temp_pdf_pages   <- c()
verification_rows <- list()

## Add cover first if present
if (!is.na(cover_file) && nzchar(cover_file) && file.exists(cover_file)) {
  pages_to_combine <- c(pages_to_combine, cover_file)
  message("Added cover: ", cover_file)
} else {
  message("No cover added (missing or blank in config).")
}

message("Starting to build: ", book_name)

for (i in seq_len(nrow(story_tbl))) {
  story_path <- story_tbl$file[i]
  story_stem <- story_tbl$stem[i]
  
  message("\n--- Story ", i, " / ", nrow(story_tbl), " | '", basename(story_path), "' ---")
  pages_to_combine <- c(pages_to_combine, story_path)
  
  ## Match images whose EXIF$Event == story_stem (ci)
  this_story_kml <- c()
  for (img in image_files) {
    exif <- safe_read_exif(img, c("Event","Description","Location","City","GPSLatitude","GPSLongitude"))
    if (is.null(exif)) next
    event_val <- exif$Event %||% NA
    if (is.na(event_val)) next
    if (!eq_ci(event_val, story_stem)) next
    
    ## ---------------------------------------------------------
    ## KEY INTEGRATION: route to spread or single-page function
    ## ---------------------------------------------------------
    if (is_two_page_spread(img)) {
      ## Two-page spread for "_2W" images
      new_pdf <- sub("\\.jpg$", "_spread.pdf", img, ignore.case = TRUE)
      create_spread_pdf(image_path = img, output_path = new_pdf)
      message("  - [2-PAGE SPREAD] ", basename(img))
    } else {
      ## Standard single-page treatment
      new_pdf <- image_pdf(image_file = img)
      message("  - [single page] ", basename(img))
    }
    
    matched_fullpaths <- c(matched_fullpaths, img)
    matched_basenames <- c(matched_basenames, basename(img))
    pages_to_combine <- c(pages_to_combine, new_pdf)
    temp_pdf_pages   <- c(temp_pdf_pages, new_pdf)
    
    ## Verification row
    verification_rows[[length(verification_rows)+1]] <-
      tibble(
        File        = basename(img),
        Event       = exif$Event %||% "NA",
        Description = exif$Description %||% "NA",
        Location    = exif$Location %||% "NA",
        City        = exif$City %||% "NA",
        GPS         = ifelse(!is.null(exif$GPSLatitude) && !is.null(exif$GPSLongitude), "Yes", "No"),
        Spread      = ifelse(is_two_page_spread(img), "Yes", "No")
      )
    
    ## KML placemark if coords exist
    if (!is.null(exif$GPSLatitude) && !is.null(exif$GPSLongitude)) {
      placemark_name <- (exif$Description %||% basename(img))
      coords <- paste(exif$GPSLongitude, exif$GPSLatitude, 0, sep = ",")
      this_story_kml <- c(
        this_story_kml,
        paste0(
          "    <Placemark>\n",
          "      <n>", placemark_name, "</n>\n",
          "      <Point><coordinates>", coords, "</coordinates></Point>\n",
          "    </Placemark>"
        )
      )
    }
  }
  
  ## Write per-story KML if any points
  if (length(this_story_kml) > 0) {
    kml_path <- file.path(kml_folder, paste0(story_stem, ".kml"))
    kml_doc <- c(
      '<?xml version="1.0" encoding="UTF-8"?>',
      '<kml xmlns="http://www.opengis.net/kml/2.2">',
      '  <Document>',
      paste0('    <n>', story_stem, '</n>'),
      this_story_kml,
      '  </Document>',
      '</kml>'
    )
    writeLines(kml_doc, kml_path)
    message("  + KML created: ", kml_path)
  }
}

## 8. Verification table page (gt)
if (length(verification_rows) > 0) {
  message("\nGenerating verification table...")
  verification_df <- list_rbind(verification_rows)
  
  table_pdf_path <- "temp_verification_table.pdf"
  
  gt_tbl <- gt(verification_df) %>%
    tab_header(title = "Data Verification Table") %>%
    tab_options(
      table.border.top.color = "black",
      column_labels.border.bottom.color = "black",
      table.width = pct(95)
    ) %>%
    tab_style(
      style = cell_text(size = "smaller", v_align = "top"),
      locations = cells_body(columns = everything())
    )
  
  gtsave(gt_tbl, filename = table_pdf_path)
  pages_to_combine <- c(pages_to_combine, table_pdf_path)
  temp_pdf_pages   <- c(temp_pdf_pages, table_pdf_path)
}

## 9. Combine
if (length(pages_to_combine) > 0) {
  message("\nCombining into final PDF...")
  pdf_combine(input = pages_to_combine, output = output_pdf)
  message("\nSuccess! Created: '", output_pdf, "'")
} else {
  message("\nNothing to combine.")
}

## 10. Cleanup
if (length(temp_pdf_pages) > 0) {
  message("Cleaning temporary pages...")
  file.remove(temp_pdf_pages)
}

## 11. Optional map
if (make_map) {
  message("\nMap requested in config; running make_map.R ...")
  used_csv <- "used_images.csv"
  if (length(matched_fullpaths) > 0) {
    readr::write_csv(
      tibble::tibble(FileName = matched_basenames, FullPath = matched_fullpaths),
      used_csv
    )
    Sys.setenv(PB_USED_IMAGES_CSV = normalizePath(used_csv))
  } else {
    Sys.unsetenv("PB_USED_IMAGES_CSV")
  }
  
  Sys.setenv(PB_IMAGES_FOLDER = images_folder)
  Sys.setenv(PB_MAP_HTML     = map_html)
  source("make_map.R")
} else {
  message("\nMap disabled by config (make_map = false).")
}
