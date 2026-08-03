#' Create a PDF page from a JPG image
#'
#' An internal helper function to create a single PDF page from an image.
#'
#' @param image_file Path to the input JPG file.
#' @param ... Other arguments passed to the function.
#' @noRd
image_pdf <- function(image_file, main_caption_field = "Description", sub_caption_fields = c("Location", "City"),
                      page_margin_inches = 0.5, image_scale_factor = 1.0, main_caption_size = 1.2, sub_caption_size = 0.9) {
  if (!file.exists(image_file)) { stop("File not found: ", image_file) }
  exif_data <- exifr::read_exif(image_file)
  img <- magick::image_read(image_file)
  main_caption_text <- ""
  if (!is.null(exif_data[[main_caption_field]])) {
    is_date <- grepl("date", main_caption_field, ignore.case = TRUE)
    if (is_date) {
      date_val <- as.Date(exif_data[[main_caption_field]], format = "%Y:%m:%d")
      main_caption_text <- format(date_val, "%B %e, %Y")
    } else {
      main_caption_text <- exif_data[[main_caption_field]]
    }
  }
  sub_caption_parts <- sapply(sub_caption_fields, function(field) { exif_data[[field]] })
  sub_caption_text <- paste(Filter(Negate(is.null), sub_caption_parts), collapse = ", ")
  pdf_path <- sub("\\.jpg$", ".pdf", image_file, ignore.case = TRUE)
  grDevices::pdf(file = pdf_path, width = 8.5, height = 11)
  on.exit(grDevices::dev.off())
  caption_lines <- c(main_caption_text, sub_caption_text)
  caption_lines <- caption_lines[caption_lines != "" & caption_lines != " "]
  bottom_margin <- page_margin_inches + (length(caption_lines) * 0.5)
  graphics::par(mai = c(bottom_margin, page_margin_inches, page_margin_inches, page_margin_inches))
  graphics::plot(0:1, 0:1, type = "n", axes = FALSE, xlab = "", ylab = "")
  plot_dims <- graphics::par("pin")
  plot_aspect <- plot_dims[1] / plot_dims[2]
  img_info <- magick::image_info(img)
  img_aspect <- img_info$width / img_info$height
  xleft <- 0; ybottom <- 0; xright <- 1; ytop <- 1
  if (img_aspect > plot_aspect) {
    new_height <- plot_aspect / img_aspect; ybottom <- (1 - new_height) / 2; ytop <- ybottom + new_height
  } else {
    new_width <- img_aspect / plot_aspect; xleft <- (1 - new_width) / 2; xright <- xleft + new_width
  }
  graphics::rasterImage(img, xleft, ybottom, xright, ytop, interpolate = TRUE)
  if (nchar(main_caption_text) > 1) { graphics::mtext(main_caption_text, side = 1, line = 0, adj = 0, cex = main_caption_size) }
  if (nchar(sub_caption_text) > 1) { graphics::mtext(sub_caption_text, side = 1, line = 2, adj = 0, cex = sub_caption_size) }
  cat("PDF created successfully at:", pdf_path, "\n")
  invisible(pdf_path)
}

`%||%` <- function(a, b) if (is.null(a)) b else a
