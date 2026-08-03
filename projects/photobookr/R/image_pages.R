# Image page rendering functions for photobookr
# Internal functions for creating PDF pages from images

#' Create a single-page PDF from an image
#'
#' @param image_file Path to input JPG file
#' @param main_caption_field EXIF field for main caption (default "Description")
#' @param sub_caption_fields EXIF fields for sub-caption
#' @param page_margin_inches Margin size in inches
#' @param main_caption_size Font size multiplier for main caption
#' @param sub_caption_size Font size multiplier for sub-caption
#' @return Path to created PDF (invisibly)
#' @noRd
image_pdf <- function(image_file,
                      main_caption_field = "Description",
                      sub_caption_fields = c("Location", "City"),
                      page_margin_inches = 0.5,
                      main_caption_size = 1.2,
                      sub_caption_size = 0.9) {
  
  if (!file.exists(image_file)) {
    stop("File not found: ", image_file)
  }
  
  exif_data <- exifr::read_exif(image_file)
  img <- magick::image_read(image_file)
  img <- magick::image_orient(img)
  
  ## Process captions
  main_caption_text <- ""
  main_val <- safe_get_exif(exif_data, main_caption_field)
  if (!is.null(main_val)) {
    is_date <- grepl("date", main_caption_field, ignore.case = TRUE)
    if (is_date) {
      date_val <- as.Date(main_val, format = "%Y:%m:%d")
      main_caption_text <- format(date_val, "%B %e, %Y")
    } else {
      main_caption_text <- main_val
    }
  }
  
  sub_caption_parts <- sapply(sub_caption_fields, function(field) {
    safe_get_exif(exif_data, field)
  })
  sub_caption_text <- paste(Filter(Negate(is.null), sub_caption_parts), collapse = ", ")
  
  ## Create PDF
  pdf_path <- sub("\\.jpg$", ".pdf", image_file, ignore.case = TRUE)
  grDevices::pdf(file = pdf_path, width = 8.5, height = 11)
  
  caption_lines <- c(main_caption_text, sub_caption_text)
  caption_lines <- caption_lines[caption_lines != "" & caption_lines != " "]
  bottom_margin <- page_margin_inches + (length(caption_lines) * 0.5)
  
  graphics::par(mai = c(bottom_margin, page_margin_inches, page_margin_inches, page_margin_inches))
  graphics::plot(0:1, 0:1, type = "n", axes = FALSE, xlab = "", ylab = "")
  
  ## Place image with aspect ratio correction
  plot_dims <- graphics::par("pin")
  plot_aspect <- plot_dims[1] / plot_dims[2]
  
  img_info <- magick::image_info(img)
  img_aspect <- img_info$width / img_info$height
  
  xleft <- 0
  ybottom <- 0
  xright <- 1
  ytop <- 1
  
  if (img_aspect > plot_aspect) {
    new_height <- plot_aspect / img_aspect
    ybottom <- (1 - new_height) / 2
    ytop <- ybottom + new_height
  } else {
    new_width <- img_aspect / plot_aspect
    xleft <- (1 - new_width) / 2
    xright <- xleft + new_width
  }
  
  graphics::rasterImage(img, xleft, ybottom, xright, ytop, interpolate = TRUE)
  
  ## Add captions
  if (nchar(main_caption_text) > 1) {
    graphics::mtext(main_caption_text, side = 1, line = 0, adj = 0, cex = main_caption_size)
  }
  if (nchar(sub_caption_text) > 1) {
    graphics::mtext(sub_caption_text, side = 1, line = 2, adj = 0, cex = sub_caption_size)
  }
  
  grDevices::dev.off()
  invisible(pdf_path)
}


#' Create a two-page spread PDF from a landscape image
#'
#' @param image_path Path to input image
#' @param output_path Path for output PDF
#' @param page_width Page width in inches
#' @param page_height Page height in inches
#' @param margin Outside margin in inches
#' @param font_size Caption font size in points
#' @param dpi Output resolution
#' @return Invisible NULL
#' @noRd
create_spread_pdf <- function(image_path,
                               output_path,
                               page_width = 8.5,
                               page_height = 11,
                               margin = 0.5,
                               font_size = 42,
                               dpi = 300) {
  
  out_dir <- dirname(output_path)
  if (!dir.exists(out_dir) && nchar(out_dir) > 0 && out_dir != ".") {
    dir.create(out_dir, recursive = TRUE)
  }
  
  page_w_px <- page_width * dpi
  page_h_px <- page_height * dpi
  
  ## Extract EXIF data
  exif_data <- exiftoolr::exif_read(image_path, 
                                    tags = c("Caption-Abstract", "Sub-location", "City"))
  
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
  
  ## Build caption lines
  if (nchar(caption_text) == 0) {
    line1 <- tools::file_path_sans_ext(basename(image_path))
  } else {
    line1 <- caption_text
  }
  
  location_parts <- c(location, city)
  location_parts <- location_parts[location_parts != '']
  line2 <- paste(location_parts, collapse = ', ')
  
  has_line2 <- nchar(line2) > 0
  
  ## Read and process image
  img <- magick::image_read(image_path)
  info <- magick::image_info(img)
  
  caption_height_in <- if (has_line2) 0.6 else 0.4
  usable_width_per_page <- page_width - margin
  usable_height <- page_height - (2 * margin) - caption_height_in
  combined_width <- usable_width_per_page * 2
  
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
  
  img_resized <- magick::image_resize(img, paste0(target_width_px, 'x', target_height_px, '!'))
  
  ## Split into halves
  half_w_px <- round(target_width_px / 2)
  left_half <- magick::image_crop(img_resized, paste0(half_w_px, 'x', target_height_px, '+0+0'))
  right_half <- magick::image_crop(img_resized, paste0(half_w_px, 'x', target_height_px, '+', half_w_px, '+0'))
  
  y_offset <- round((page_h_px - target_height_px - (caption_height_in * dpi)) / 2)
  
  ## Create pages
  page1 <- magick::image_blank(page_w_px, page_h_px, color = 'white')
  page2 <- magick::image_blank(page_w_px, page_h_px, color = 'white')
  
  x_offset_page1 <- page_w_px - half_w_px
  page1 <- magick::image_composite(page1, left_half, offset = paste0('+', x_offset_page1, '+', y_offset))
  
  ## Add captions to page 1
  x_caption <- round(margin * dpi)
  line_spacing <- 50
  
  if (has_line2) {
    line2_y <- page_h_px - round(margin * dpi) - 10
    line1_y <- line2_y - line_spacing
    
    page1 <- magick::image_annotate(page1, line1, size = font_size, color = 'black',
                                    location = paste0('+', x_caption, '+', line1_y),
                                    font = 'DejaVu-Sans')
    page1 <- magick::image_annotate(page1, line2, size = font_size, color = 'black',
                                    location = paste0('+', x_caption, '+', line2_y),
                                    font = 'DejaVu-Sans')
  } else {
    line1_y <- page_h_px - round(margin * dpi) - 10
    page1 <- magick::image_annotate(page1, line1, size = font_size, color = 'black',
                                    location = paste0('+', x_caption, '+', line1_y),
                                    font = 'DejaVu-Sans')
  }
  
  page2 <- magick::image_composite(page2, right_half, offset = paste0('+0+', y_offset))
  
  ## Combine and write
  combined <- magick::image_join(page1, page2)
  magick::image_write(combined, output_path, format = 'pdf', density = dpi)
  
  invisible(NULL)
}
