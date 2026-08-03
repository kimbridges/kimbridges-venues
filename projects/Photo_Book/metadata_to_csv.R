## --- metadata_to_csv.R ---
## Extract image metadata to CSV with companion proof sheet for reference
## Requires: exifr, magick, and optionally base64enc for HTML

suppressPackageStartupMessages({
  library(exifr)
  library(magick)
})

#' Extract metadata from images to CSV with proof sheet
#'
#' Scans all JPG files in a folder, extracts key metadata fields to a CSV,
#' and generates a visual proof sheet (PDF or HTML) for reference while editing.
#'
#' @param images_folder Path to folder containing JPG images
#' @param output_csv Path for output CSV file (default: "metadata.csv")
#' @param proof_format Either "pdf", "html", or "both" (default: "pdf")
#' @param proof_file Base name for proof sheet (extension added automatically)
#' @param thumb_width Thumbnail width in pixels for proof sheet (default: 300)
#' @return Invisibly returns the metadata data frame
#'
metadata_to_csv <- function(images_folder,
                            output_csv = "metadata.csv",
                            proof_format = "pdf",
                            proof_file = "proof_sheet",
                            thumb_width = 300) {
  
  
  ## Validate inputs
  if (!dir.exists(images_folder)) {
    stop("Folder not found: ", images_folder)
  }
  proof_format <- tolower(proof_format)
  if (!proof_format %in% c("pdf", "html", "both")) {
    stop("proof_format must be 'pdf', 'html', or 'both'")
  }
  
  ## Find all JPGs
  image_files <- list.files(images_folder, 
                            pattern = "\\.jpe?g$", 
                            ignore.case = TRUE, 
                            full.names = TRUE)
  
  if (length(image_files) == 0) {
    stop("No JPG files found in: ", images_folder)
  }
  
  ## Sort alphabetically by filename
  image_files <- image_files[order(basename(image_files))]
  
  message("Found ", length(image_files), " images in ", images_folder)
  
  ## Extract metadata
  message("Extracting metadata...")
  
  ## Note: IPTC uses "Sub-location" for what we call "Location"
  tags_to_read <- c("Event", "Description", "Sub-location", "Location", "City", 
                    "GPSLatitude", "GPSLongitude")
  
  rows <- list()
  for (i in seq_along(image_files)) {
    img_path <- image_files[i]
    fname <- basename(img_path)
    
    exif <- tryCatch(
      read_exif(img_path, tags = tags_to_read),
      error = function(e) NULL
    )
    
    ## Build row with safe extraction
    get_val <- function(field) {
      if (is.null(exif) || !field %in% names(exif)) return(NA_character_)
      val <- exif[[field]]
      if (is.null(val) || length(val) == 0) return(NA_character_)
      as.character(val)
    }
    
    ## Try Sub-location first (IPTC standard), fall back to Location
    location_val <- get_val("Sub-location")
    if (is.na(location_val)) location_val <- get_val("Location")
    
    rows[[i]] <- data.frame(
      Row = i,
      FileName = fname,
      Event = get_val("Event"),
      Description = get_val("Description"),
      Location = location_val,
      City = get_val("City"),
      GPSLatitude = get_val("GPSLatitude"),
      GPSLongitude = get_val("GPSLongitude"),
      stringsAsFactors = FALSE
    )
  }
  
  metadata_df <- do.call(rbind, rows)
  
  ## Write CSV
  write.csv(metadata_df, output_csv, row.names = FALSE, na = "")
  message("CSV written: ", output_csv)
  
  ## Generate proof sheet(s)
  if (proof_format %in% c("pdf", "both")) {
    pdf_path <- paste0(tools::file_path_sans_ext(proof_file), ".pdf")
    generate_proof_pdf(image_files, metadata_df, pdf_path, thumb_width)
    message("PDF proof sheet: ", pdf_path)
  }
  
  if (proof_format %in% c("html", "both")) {
    html_path <- paste0(tools::file_path_sans_ext(proof_file), ".html")
    generate_proof_html(image_files, metadata_df, html_path, thumb_width)
    message("HTML proof sheet: ", html_path)
  }
  
  message("\nDone! Edit ", output_csv, " and use proof sheet for reference.")
  invisible(metadata_df)
}


#' Generate PDF proof sheet (internal)
#' @noRd
generate_proof_pdf <- function(image_files, metadata_df, output_path, thumb_width) {
  
  ## Layout: 2 columns x 3 rows = 6 per page
  cols <- 2
  rows_per_page <- 3
  per_page <- cols * rows_per_page
  
  ## Page setup (8.5 x 11 inches)
  page_w <- 8.5
  page_h <- 11
  margin <- 0.5
  
  ## Calculate cell dimensions
  usable_w <- page_w - (2 * margin)
  usable_h <- page_h - (2 * margin)
  cell_w <- usable_w / cols
  cell_h <- usable_h / rows_per_page
  
  ## Open PDF device
  pdf(output_path, width = page_w, height = page_h)
  
  n_images <- length(image_files)
  n_pages <- ceiling(n_images / per_page)
  
  for (page in seq_len(n_pages)) {
    ## Set up blank plot
    par(mar = c(0, 0, 0, 0))
    plot(0, 0, type = "n", xlim = c(0, page_w), ylim = c(0, page_h),
         axes = FALSE, xlab = "", ylab = "", asp = 1)
    
    ## Which images on this page
    start_idx <- (page - 1) * per_page + 1
    end_idx <- min(page * per_page, n_images)
    
    for (idx in start_idx:end_idx) {
      ## Position in grid (0-indexed)
      pos_on_page <- idx - start_idx
      col <- pos_on_page %% cols
      row <- pos_on_page %/% cols
      
      ## Cell coordinates (top-left origin, but R plots from bottom)
      x_left <- margin + col * cell_w
      y_top <- page_h - margin - row * cell_h
      
      ## Load and resize image (apply EXIF orientation for portrait images)
      img <- tryCatch(
        image_orient(image_read(image_files[idx])),
        error = function(e) NULL
      )
      
      if (!is.null(img)) {
        img_thumb <- image_resize(img, paste0(thumb_width, "x"))
        info <- image_info(img_thumb)
        
        ## Scale to fit cell (leave room for text)
        text_space <- 0.5  # inches for row number and filename
        max_img_h <- cell_h - text_space
        max_img_w <- cell_w - 0.2
        
        img_w_in <- info$width / 72  # assuming 72 dpi for screen
        img_h_in <- info$height / 72
        
        scale <- min(max_img_w / img_w_in, max_img_h / img_h_in, 1)
        display_w <- img_w_in * scale
        display_h <- img_h_in * scale
        
        ## Center image in cell
        x_center <- x_left + cell_w / 2
        img_x <- x_center - display_w / 2
        img_y <- y_top - 0.3 - display_h  # 0.3" from top for row number
        
        ## Draw image
        rasterImage(img_thumb, 
                    img_x, img_y, 
                    img_x + display_w, img_y + display_h,
                    interpolate = TRUE)
        
        ## Row number (prominent, top of cell)
        text(x_center, y_top - 0.15, 
             labels = paste0("[", idx, "]"),
             cex = 1.2, font = 2)
        
        ## Filename (below image)
        text(x_center, img_y - 0.1,
             labels = metadata_df$FileName[idx],
             cex = 0.7)
        
        ## Event if present (smaller, below filename)
        if (!is.na(metadata_df$Event[idx]) && nchar(metadata_df$Event[idx]) > 0) {
          text(x_center, img_y - 0.25,
               labels = paste0("Event: ", metadata_df$Event[idx]),
               cex = 0.6, col = "gray40")
        }
      }
    }
  }
  
  dev.off()
}


#' Generate HTML proof sheet (internal)
#' @noRd
generate_proof_html <- function(image_files, metadata_df, output_path, thumb_width) {
  
  ## We'll create thumbnails as base64 or link to files
  ## For portability with full-size click, we'll reference original files
  
  ## Get absolute paths for the images
  abs_paths <- normalizePath(image_files, winslash = "/")
  
  ## Build HTML
  html_lines <- c(
    '<!DOCTYPE html>',
    '<html lang="en">',
    '<head>',
    '  <meta charset="UTF-8">',
    '  <title>Proof Sheet</title>',
    '  <style>',
    '    body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; ',
    '           margin: 20px; background: #f5f5f5; }',
    '    h1 { color: #333; }',
    '    .grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; max-width: 900px; }',
    '    .cell { background: white; padding: 15px; border-radius: 8px; ',
    '            box-shadow: 0 2px 4px rgba(0,0,0,0.1); text-align: center; }',
    '    .row-num { font-size: 1.4em; font-weight: bold; color: #333; margin-bottom: 8px; }',
    '    .thumb { max-width: 100%; height: auto; cursor: pointer; border: 1px solid #ddd; }',
    '    .thumb:hover { border-color: #007acc; }',
    '    .filename { font-size: 0.85em; color: #555; margin-top: 8px; word-break: break-all; }',
    '    .event { font-size: 0.75em; color: #888; margin-top: 4px; }',
    '    .instructions { background: #fff; padding: 15px; margin-bottom: 20px; ',
    '                    border-left: 4px solid #007acc; max-width: 900px; }',
    '  </style>',
    '</head>',
    '<body>',
    '  <h1>Proof Sheet</h1>',
    '  <div class="instructions">',
    '    <strong>Instructions:</strong> Use the [row number] to match images to your CSV spreadsheet. ',
    '    Click any thumbnail to view full size.',
    '  </div>',
    '  <div class="grid">'
  )
  
  for (i in seq_along(image_files)) {
    fname <- metadata_df$FileName[i]
    event_text <- if (!is.na(metadata_df$Event[i]) && nchar(metadata_df$Event[i]) > 0) {
      paste0('    <div class="event">Event: ', htmlEscape(metadata_df$Event[i]), '</div>')
    } else {
      ''
    }
    
    ## Use file:// protocol for local viewing
    file_url <- paste0("file://", abs_paths[i])
    
    cell_html <- c(
      '    <div class="cell">',
      paste0('      <div class="row-num">[', i, ']</div>'),
      paste0('      <a href="', file_url, '" target="_blank">'),
      paste0('        <img class="thumb" src="', file_url, '" width="', thumb_width, '">'),
      '      </a>',
      paste0('      <div class="filename">', htmlEscape(fname), '</div>'),
      event_text,
      '    </div>'
    )
    
    html_lines <- c(html_lines, cell_html)
  }
  
  html_lines <- c(html_lines,
                  '  </div>',
                  '</body>',
                  '</html>'
  )
  
  writeLines(html_lines, output_path)
}


#' Simple HTML escape (internal)
#' @noRd
htmlEscape <- function(text) {
  text <- gsub("&", "&amp;", text)
  text <- gsub("<", "&lt;", text)
  text <- gsub(">", "&gt;", text)
  text <- gsub('"', "&quot;", text)
  text
}


# =============================================================================
# USAGE EXAMPLES
# =============================================================================
#
# # Extract metadata with PDF proof sheet (default):
# metadata_to_csv("Keepers")
#
# # With HTML proof sheet:
# metadata_to_csv("Keepers", proof_format = "html")
#
# # Generate both PDF and HTML:
# metadata_to_csv("Keepers", proof_format = "both")
#
# # Custom output names:
# metadata_to_csv("Keepers", 
#                 output_csv = "my_photos.csv",
#                 proof_file = "my_contact_sheet",
#                 proof_format = "both")