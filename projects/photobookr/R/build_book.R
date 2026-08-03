#' Build a photo book
#'
#' Assembles a photo book by combining chapter PDFs with matched images.
#' Images are matched to chapters via their EXIF Event tag.
#'
#' @param config_file Path to YAML configuration file (default: "config.yaml")
#' @param verification Logical. Generate a verification table? (default: TRUE)
#'
#' @return Invisibly returns a list with paths to created files
#' @export
#'
#' @details
#' The function reads chapter PDFs from the Stories folder, then for each
#' chapter, finds images whose EXIF Event tag matches the chapter name
#' (case-insensitive). Images are rendered as single pages, or as two-page
#' spreads if their filename ends with the spread suffix (default "_2W").
#'
#' Configuration is read from a YAML file. Use `photobookr_example_config()`
#' to create a template.
#'
#' @examples
#' \dontrun{
#' # Basic usage with default config.yaml
#' build_book()
#'
#' # With custom config file
#' build_book("my_project.yaml")
#'
#' # Without verification table
#' build_book(verification = FALSE)
#' }
build_book <- function(config_file = "config.yaml", verification = TRUE) {

  ## Read config
  cfg <- read_config(config_file)

  book_name <- cfg$book_name
  cover_file <- cfg$cover_file
  stories_folder <- cfg$folders$stories
  images_folder <- cfg$folders$images
  kml_folder <- cfg$folders$kml
  output_pdf <- cfg$output_pdf
  spread_suffix <- cfg$spread$suffix %||% "_2W"
  verification_enabled <- verification && (cfg$verification$enabled %||% TRUE)
  verification_file <- cfg$verification$output_file %||% "Photo_Book_verification.pdf"

  ## Pre-flight checks
  if (!dir.exists(stories_folder)) {
    stop("Stories folder not found: ", stories_folder)
  }
  if (!dir.exists(images_folder)) {
    stop("Images folder not found: ", images_folder)
  }
  if (!dir.exists(kml_folder)) {
    dir.create(kml_folder, recursive = TRUE)
  }

  ## Discover and order stories by numeric prefix
  story_files <- list.files(stories_folder, pattern = "\\.pdf$", full.names = TRUE)
  if (length(story_files) == 0) {
    stop("No story PDFs found in: ", stories_folder)
  }

  story_tbl <- data.frame(file = story_files, stringsAsFactors = FALSE)
  story_tbl$parsed <- lapply(story_tbl$file, parse_story_filename)
  story_tbl$order <- sapply(story_tbl$parsed, function(x) x$order)
  story_tbl$stem <- sapply(story_tbl$parsed, function(x) x$stem)
  story_tbl <- story_tbl[order(story_tbl$order, story_tbl$stem), ]

  ## Load images list
  image_files <- list.files(images_folder, pattern = "\\.jpg$",
                            ignore.case = TRUE, full.names = TRUE)

  ## Initialize
  pages_to_combine <- c()
  temp_pdf_pages <- c()
  verification_rows <- list()
  matched_fullpaths <- c()
  matched_basenames <- c()

  ## Add cover if present
  if (!is.null(cover_file) && nzchar(cover_file) && file.exists(cover_file)) {
    pages_to_combine <- c(pages_to_combine, cover_file)
    message("Added cover: ", cover_file)
  }

  message("Building: ", book_name)
  message("Spread suffix: ", spread_suffix)

  ## Process each story/chapter
  for (i in seq_len(nrow(story_tbl))) {
    story_path <- story_tbl$file[i]
    story_stem <- story_tbl$stem[i]

    message("\n--- Chapter ", i, "/", nrow(story_tbl), ": '", story_stem, "' ---")
    pages_to_combine <- c(pages_to_combine, story_path)

    ## Find matching images
    this_story_kml <- c()

    for (img in image_files) {
      exif <- safe_read_exif(img, c("Event", "Description", "Location",
                                    "Sub-location", "City",
                                    "GPSLatitude", "GPSLongitude"))
      if (is.null(exif)) next

      event_val <- safe_get_exif(exif, "Event")
      if (is.null(event_val) || is.na(event_val)) next
      if (!eq_ci(event_val, story_stem)) next

      ## Route to spread or single-page
      if (is_two_page_spread(img, spread_suffix)) {
        new_pdf <- sub("\\.jpg$", "_spread.pdf", img, ignore.case = TRUE)
        create_spread_pdf(image_path = img, output_path = new_pdf)
        message("  [SPREAD] ", basename(img))
      } else {
        new_pdf <- image_pdf(image_file = img)
        message("  [single] ", basename(img))
      }

      matched_fullpaths <- c(matched_fullpaths, img)
      matched_basenames <- c(matched_basenames, basename(img))
      pages_to_combine <- c(pages_to_combine, new_pdf)
      temp_pdf_pages <- c(temp_pdf_pages, new_pdf)

      ## Get location
      location_val <- safe_get_exif(exif, "Location") %||% "NA"

      ## Verification row
      verification_rows[[length(verification_rows) + 1]] <- data.frame(
        File = basename(img),
        Event = event_val,
        Description = safe_get_exif(exif, "Description") %||% "NA",
        Location = location_val,
        City = safe_get_exif(exif, "City") %||% "NA",
        GPS = ifelse(!is.null(safe_get_exif(exif, "GPSLatitude")), "Yes", "No"),
        Spread = ifelse(is_two_page_spread(img, spread_suffix), "Yes", "No"),
        stringsAsFactors = FALSE
      )

      ## KML placemark
      lat <- safe_get_exif(exif, "GPSLatitude")
      lon <- safe_get_exif(exif, "GPSLongitude")
      if (!is.null(lat) && !is.null(lon)) {
        placemark_name <- safe_get_exif(exif, "Description") %||% basename(img)
        coords <- paste(lon, lat, 0, sep = ",")
        this_story_kml <- c(this_story_kml, paste0(
          "    <Placemark>\n",
          "      <name>", placemark_name, "</name>\n",
          "      <Point><coordinates>", coords, "</coordinates></Point>\n",
          "    </Placemark>"
        ))
      }
    }

    ## Write KML for this chapter
    if (length(this_story_kml) > 0) {
      kml_path <- file.path(kml_folder, paste0(story_stem, ".kml"))
      kml_doc <- c(
        '<?xml version="1.0" encoding="UTF-8"?>',
        '<kml xmlns="http://www.opengis.net/kml/2.2">',
        '  <Document>',
        paste0('    <name>', story_stem, '</name>'),
        this_story_kml,
        '  </Document>',
        '</kml>'
      )
      writeLines(kml_doc, kml_path)
      message("  + KML: ", kml_path)
    }
  }

  ## Build verification table as separate PDF
  if (verification_enabled && length(verification_rows) > 0) {
    message("\nGenerating verification table...")
    verification_df <- do.call(rbind, verification_rows)

    gt_tbl <- gt::gt(verification_df) |>
      gt::tab_header(title = "Photo Book Verification Table") |>
      gt::tab_options(
        table.border.top.color = "black",
        column_labels.border.bottom.color = "black",
        table.width = gt::pct(95)
      ) |>
      gt::tab_style(
        style = gt::cell_text(size = "smaller", v_align = "top"),
        locations = gt::cells_body(columns = gt::everything())
      )

    gt::gtsave(gt_tbl, filename = verification_file)
    message("Verification table: ", verification_file)
  }

  ## Combine book
  if (length(pages_to_combine) > 0) {
    message("\nCombining ", length(pages_to_combine), " pages...")
    pdftools::pdf_combine(input = pages_to_combine, output = output_pdf)
    message("\nSuccess! Created: ", output_pdf)
  } else {
    message("\nNo pages to combine.")
  }

  ## Cleanup temp files
  if (length(temp_pdf_pages) > 0) {
    message("Cleaning up ", length(temp_pdf_pages), " temporary files...")
    file.remove(temp_pdf_pages)
  }

  ## Return info
  invisible(list(
    book = output_pdf,
    verification = if (verification_enabled) verification_file else NULL,
    pages = length(pages_to_combine),
    images = length(matched_basenames)
  ))
}


#' Parse story filename for ordering
#' @param fname Filename like "07_paris.pdf"
#' @return List with order and stem
#' @noRd
parse_story_filename <- function(fname) {
  base <- tools::file_path_sans_ext(basename(fname))
  m <- regmatches(base, regexec("^(\\d+)_(.+)$", base))[[1]]
  if (length(m) == 3) {
    list(order = as.integer(m[2]), stem = m[3])
  } else {
    list(order = Inf, stem = base)
  }
}
