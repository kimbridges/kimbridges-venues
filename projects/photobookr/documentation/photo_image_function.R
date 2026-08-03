# Load the required libraries
if (!requireNamespace("magick", quietly = TRUE))
  stop("Package 'magick' must be installed.")
library(magick)
library(exifr)

#' Create a PDF from a JPG with EXIF Captions (v4)
#'
#' This function creates a PDF page from a JPG, preserving the image's
#' original aspect ratio to prevent distortion. Handles EXIF orientation
#' for proper display of portrait images.
#'
#' @param image_file Path to the input JPG file.
#' @param main_caption_field A single string naming the EXIF field for the main caption.
#' @param sub_caption_fields A character vector of EXIF field names for the sub-caption.
#' @param page_margin_inches Numeric. The size of the whitespace margin in inches.
#' @param image_scale_factor Numeric. Scales the image within the margins (1.0 = fill).
#' @param main_caption_size Numeric. The type size for the main caption.
#' @param sub_caption_size Numeric. The type size for the sub-caption.
#' @return Invisibly returns the path to the created PDF.
#'
image_pdf <- function(image_file,
                      main_caption_field = "Description",
                      sub_caption_fields = c("Location", "City"),
                      page_margin_inches = 0.5,
                      image_scale_factor = 1.0,
                      main_caption_size = 1.2,
                      sub_caption_size = 0.9) {
  
  # --- 1. Validate Input and Read Data ---
  if (!file.exists(image_file)) {
    stop("File not found: ", image_file)
  }
  exif_data <- read_exif(image_file)
  img <- image_read(image_file)
  
  # Apply EXIF orientation to correctly display portrait images
  img <- image_orient(img)
  
  # --- 2. Process Captions ---
  # Helper to safely get EXIF field (returns NULL if missing)
  # Handles field aliases (e.g., "Location" -> "Sub-location" in IPTC)
  safe_get_exif <- function(df, field) {
    # Define aliases for common field name variations
    aliases <- list(
      "Location" = c("Location", "Sub-location")
    )
    
    # Get list of fields to try
    fields_to_try <- if (field %in% names(aliases)) aliases[[field]] else field
    
    for (f in fields_to_try) {
      if (f %in% names(df)) {
        val <- df[[f]]
        if (!is.null(val) && length(val) > 0 && !is.na(val[1])) {
          return(val[1])
        }
      }
    }
    return(NULL)
  }
  
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
  
  # --- 3. Create PDF and Set Layout ---
  pdf_path <- sub("\\.jpg$", ".pdf", image_file, ignore.case = TRUE)
  pdf(file = pdf_path, width = 8.5, height = 11)
  
  caption_lines <- c(main_caption_text, sub_caption_text)
  caption_lines <- caption_lines[caption_lines != "" & caption_lines != " "]
  bottom_margin <- page_margin_inches + (length(caption_lines) * 0.5)
  
  par(mai = c(bottom_margin, page_margin_inches, page_margin_inches, page_margin_inches))
  plot(0:1, 0:1, type = "n", axes = FALSE, xlab = "", ylab = "")
  
  # --- 4. Place Image (with Aspect Ratio Correction) ---
  
  # Get the aspect ratio of the plotting area (inside margins) and the image itself
  plot_dims <- par("pin") # Plot area dimensions in inches (width, height)
  plot_aspect <- plot_dims[1] / plot_dims[2]
  
  img_info <- image_info(img)
  img_aspect <- img_info$width / img_info$height
  
  # Set default coordinates to fill the plot area
  xleft <- 0
  ybottom <- 0
  xright <- 1
  ytop <- 1
  
  # Adjust coordinates based on which is the limiting dimension (width or height)
  if (img_aspect > plot_aspect) {
    # Image is WIDER than the plot area, so height must be adjusted
    new_height <- plot_aspect / img_aspect
    ybottom <- (1 - new_height) / 2
    ytop <- ybottom + new_height
  } else {
    # Image is TALLER than the plot area, so width must be adjusted
    new_width <- img_aspect / plot_aspect
    xleft <- (1 - new_width) / 2
    xright <- xleft + new_width
  }
  
  # Draw the image using the newly calculated, non-distorting coordinates
  rasterImage(img, xleft, ybottom, xright, ytop, interpolate = TRUE)
  
  
  # --- 5. Add Captions ---
  if (nchar(main_caption_text) > 1) {
    mtext(main_caption_text, side = 1, line = 0, adj = 0, cex = main_caption_size)
  }
  if (nchar(sub_caption_text) > 1) {
    mtext(sub_caption_text, side = 1, line = 2, adj = 0, cex = sub_caption_size)
  }
  
  # --- 6. Finalize ---
  dev.off()
  cat("PDF created successfully at:", pdf_path, "\n")
  invisible(pdf_path)
}
