# spread_pdf.R
# Create two-page PDF spreads from landscape images with EXIF captions
# Requires: library(magick), library(exiftoolr), library(pdftools)
# On first use, run: exiftoolr::install_exiftool()

library(magick)
library(exiftoolr)
library(pdftools)

#' Create a two-page spread PDF from a landscape image
#'
#' @param image_path Path to input image (JPG)
#' @param output_path Path for output PDF
#' @param page_width Page width in inches (default 8.5)
#' @param page_height Page height in inches (default 11)
#' @param margin Outside margin in inches (default 0.5)
#' @param font_size Caption font size in points (default 42)
#' @param dpi Output resolution (default 300)
#' @return Invisible NULL, creates PDF file
create_spread_pdf <- function(image_path, 
                              output_path,
                              page_width = 8.5,
                              page_height = 11,
                              margin = 0.5,
                              font_size = 42,
                              dpi = 300) {
  
  # Create output directory if needed
  out_dir <- dirname(output_path)
  if (!dir.exists(out_dir) && nchar(out_dir) > 0 && out_dir != ".") {
    dir.create(out_dir, recursive = TRUE)
  }
  
  # Page dimensions in pixels
  page_w_px <- page_width * dpi
  page_h_px <- page_height * dpi
  
  # Extract EXIF data using exiftoolr
  exif_data <- exif_read(image_path, tags = c("Caption-Abstract", "Sub-location", 
                                              "City"))
  
  # Safely extract values (returns NA if missing)
  get_field <- function(df, field) {
    if (field %in% names(df)) {
      val <- df[[field]]
      if (!is.na(val) && nchar(val) > 0) return(val)
    }
    return('')
  }
  
  caption_text <- get_field(exif_data, 'Caption-Abstract')
  location <- get_field(exif_data, 'Sub-location')
  city <- get_field(exif_data, 'City')
  
  # Build caption lines - use filename as fallback for line 1
  if (nchar(caption_text) == 0) {
    line1 <- tools::file_path_sans_ext(basename(image_path))
  } else {
    line1 <- caption_text
  }
  
  # Build line 2 from location/city (may be empty)
  location_parts <- c(location, city)
  location_parts <- location_parts[location_parts != '']
  line2 <- paste(location_parts, collapse = ', ')
  
  # Determine if we have one or two caption lines
  has_line2 <- nchar(line2) > 0
  
  # Read the image
  img <- image_read(image_path)
  info <- image_info(img)
  
  # Reserve space for caption
  caption_height_in <- if (has_line2) 0.6 else 0.4
  usable_width_per_page <- page_width - margin
  usable_height <- page_height - (2 * margin) - caption_height_in
  combined_width <- usable_width_per_page * 2
  
  # Calculate scaling
  img_aspect <- info$width / info$height
  spread_aspect <- combined_width / usable_height
  
  if (img_aspect > spread_aspect) {
    target_width_in <- combined_width
    target_height_in <- combined_width / img_aspect
  } else {
    target_height_in <- usable_height
    target_width_in <- usable_height * img_aspect
  }
  
  target_width_px <- round(target_width_in * dpi)
  target_height_px <- round(target_height_in * dpi)
  
  # Resize image
  img_resized <- image_resize(img, paste0(target_width_px, 'x', target_height_px, '!'))
  
  # Split into halves
  half_w_px <- round(target_width_px / 2)
  left_half <- image_crop(img_resized, paste0(half_w_px, 'x', target_height_px, '+0+0'))
  right_half <- image_crop(img_resized, paste0(half_w_px, 'x', target_height_px, '+', half_w_px, '+0'))
  
  # Vertical offset - center in available space above caption
  y_offset <- round((page_h_px - target_height_px - (caption_height_in * dpi)) / 2)
  
  # Create blank white pages
  page1 <- image_blank(page_w_px, page_h_px, color = 'white')
  page2 <- image_blank(page_w_px, page_h_px, color = 'white')
  
  # Page 1: left half, flush to RIGHT edge (binding)
  x_offset_page1 <- page_w_px - half_w_px
  page1 <- image_composite(page1, left_half, offset = paste0('+', x_offset_page1, '+', y_offset))
  
  # Add caption(s) to bottom of page 1
  x_caption <- round(margin * dpi)
  line_spacing <- 50
  
  if (has_line2) {
    line2_y <- page_h_px - round(margin * dpi) - 10
    line1_y <- line2_y - line_spacing
    
    page1 <- image_annotate(page1, line1, 
                            size = font_size, 
                            color = 'black',
                            location = paste0('+', x_caption, '+', line1_y),
                            font = 'DejaVu-Sans')
    
    page1 <- image_annotate(page1, line2, 
                            size = font_size, 
                            color = 'black',
                            location = paste0('+', x_caption, '+', line2_y),
                            font = 'DejaVu-Sans')
  } else {
    line1_y <- page_h_px - round(margin * dpi) - 10
    
    page1 <- image_annotate(page1, line1, 
                            size = font_size, 
                            color = 'black',
                            location = paste0('+', x_caption, '+', line1_y),
                            font = 'DejaVu-Sans')
  }
  
  # Page 2: right half, flush to LEFT edge (binding)
  page2 <- image_composite(page2, right_half, offset = paste0('+0+', y_offset))
  
  # Combine pages and write PDF
  combined <- image_join(page1, page2)
  image_write(combined, output_path, format = 'pdf', density = dpi)
  
  invisible(NULL)
}


#' Process all images in a folder to create spread PDFs
#'
#' @param input_folder Path to folder containing JPG images
#' @param output_folder Path to folder for output PDFs (created if needed)
#' @param combine If TRUE, also create a single combined PDF of all spreads
#' @param combined_name Filename for combined PDF (default "combined_spreads.pdf")
#' @param ... Additional arguments passed to create_spread_pdf
#' @return Character vector of created PDF paths (invisible)
process_folder <- function(input_folder, 
                           output_folder,
                           combine = FALSE,
                           combined_name = "combined_spreads.pdf",
                           ...) {
  
  # Create output folder if needed
  if (!dir.exists(output_folder)) {
    dir.create(output_folder, recursive = TRUE)
  }
  
  # Find all JPG files (case insensitive)
  image_files <- list.files(input_folder, 
                            pattern = '\\.(jpg|jpeg)$', 
                            full.names = TRUE,
                            ignore.case = TRUE)
  
  if (length(image_files) == 0) {
    message('No JPG files found in ', input_folder)
    return(invisible(character(0)))
  }
  
  # Process each image
  output_paths <- character(length(image_files))
  
  for (i in seq_along(image_files)) {
    img_path <- image_files[i]
    img_name <- tools::file_path_sans_ext(basename(img_path))
    out_path <- file.path(output_folder, paste0(img_name, '_spread.pdf'))
    
    create_spread_pdf(img_path, out_path, ...)
    output_paths[i] <- out_path
  }
  
  # Combine all PDFs if requested
  if (combine && length(output_paths) > 1) {
    combined_path <- file.path(output_folder, combined_name)
    
    # Use pdftools to merge PDFs (no Ghostscript required)
    pdf_combine(output_paths, output = combined_path)
  }
  
  invisible(output_paths)
}


# =============================================================================
# USAGE EXAMPLES
# =============================================================================
#
# # First time setup (only need to do once):
# install.packages("exiftoolr")
# install.packages("pdftools")
# exiftoolr::install_exiftool()
#
# # Process a single image:
# create_spread_pdf("path/to/image.jpg", "output/image_spread.pdf")
#
# # Process all images in a folder:
# process_folder("path/to/images", "path/to/output")
#
# # Process folder and create combined PDF:
# process_folder("path/to/images", "path/to/output", combine = TRUE)
#
# # With custom options:
# process_folder("path/to/images", "path/to/output", 
#                combine = TRUE,
#                combined_name = "my_photo_book.pdf",
#                font_size = 36,
#                margin = 0.75)