#' @importFrom stats setNames
#' @importFrom utils head
NULL

#' Create a Photo Book PDF
#'
#' Builds a multi-page PDF book from images, story pages, and metadata.
#' @param output_filename The name of the final PDF book file.
#' @param cover_file Path to the PDF file to be used as the cover.
#' @param category_file Path to a text file listing the 'Event' categories.
#' @param image_folder Path to the directory containing the JPG images.
#' @param stories_folder Path to the directory containing story PDFs.
#' @param kml_folder Path to the directory where KML files will be saved.
#' @export
create_book <- function(output_filename = "Photo_Book.pdf",
                        cover_file = "cover.pdf",
                        category_file = "category_list.txt",
                        image_folder = "Keepers",
                        stories_folder = "Stories",
                        kml_folder = "KML") {

  if (!dir.exists(kml_folder)) { dir.create(kml_folder) }
  categories <- readLines(category_file)
  all_images <- list.files(image_folder, pattern = "\\.jpg$", ignore.case = TRUE)
  pages_to_combine <- c(cover_file)
  temp_files_to_delete <- c()
  verification_data_list <- list()
  cat("Starting to build book...\n")

  for (category in categories) {
    cat(paste0("\n--- Processing Category: '", category, "' ---\n"))
    story_pdf_path <- file.path(stories_folder, paste0(category, ".pdf"))
    if (file.exists(story_pdf_path)) {
      pages_to_combine <- c(pages_to_combine, story_pdf_path)
      cat(paste0("  + Found and added story page: ", story_pdf_path, "\n"))
    }
    kml_placemarks <- c()
    for (image_file in all_images) {
      full_path <- file.path(image_folder, image_file)
      tags_to_read <- c("Event", "Description", "Location", "City", "GPSLatitude", "GPSLongitude")
      exif_data <- exifr::read_exif(full_path, tags = tags_to_read)
      if (!is.null(exif_data$Event) && tolower(exif_data$Event) == tolower(category)) {
        cat(paste0("  - Found match: ", image_file, "\n"))
        new_pdf_path <- image_pdf(image_file = full_path)
        pages_to_combine <- c(pages_to_combine, new_pdf_path)
        temp_files_to_delete <- c(temp_files_to_delete, new_pdf_path)
        verification_data_list[[length(verification_data_list) + 1]] <- data.frame(
          File = image_file, Event = exif_data$Event %||% "NA", Description = exif_data$Description %||% "NA",
          Location = exif_data$Location %||% "NA", City = exif_data$City %||% "NA",
          GPS = ifelse(!is.null(exif_data$GPSLatitude), "Yes", "No")
        )
        if (!is.null(exif_data$GPSLatitude) && !is.null(exif_data$GPSLongitude)) {
          placemark_name <- exif_data$Description %||% image_file
          coordinates <- paste(exif_data$GPSLongitude, exif_data$GPSLatitude, 0, sep = ",")
          placemark_xml <- paste0("    <Placemark>\n      <name>", placemark_name, "</name>\n      <Point>\n        <coordinates>", coordinates, "</coordinates>\n      </Point>\n    </Placemark>")
          kml_placemarks <- c(kml_placemarks, placemark_xml)
        }
      }
    }
    if (length(kml_placemarks) > 0) {
      kml_filename <- file.path(kml_folder, paste0(category, ".kml"))
      kml_content <- c('<?xml version="1.0" encoding="UTF-8"?>', '<kml xmlns="http://www.opengis.net/kml/2.2">', '  <Document>', paste0('    <name>', category, '</name>'), kml_placemarks, '  </Document>', '</kml>')
      writeLines(kml_content, kml_filename)
      cat(paste0("  + Successfully created KML file: ", kml_filename, "\n"))
    }
  }

  if (length(verification_data_list) > 0) {
    cat("\nGenerating data verification table with gt...\n")
    verification_df <- do.call(rbind, verification_data_list)
    table_pdf_path <- "temp_table_page.pdf"
    gt_table <- gt::gt(verification_df) %>%
      gt::tab_header(title = "Data Verification Table") %>%
      gt::tab_options(table.border.top.color = "black", column_labels.border.bottom.color = "black", table.width = gt::pct(95)) %>%
      gt::tab_style(style = gt::cell_text(size = "smaller", v_align = "top"), locations = gt::cells_body(columns = tidyselect::everything()))
    gt::gtsave(gt_table, filename = table_pdf_path)
    pages_to_combine <- c(pages_to_combine, table_pdf_path)
    temp_files_to_delete <- c(temp_files_to_delete, table_pdf_path)
  }

  if (length(pages_to_combine) > 1) {
    cat("\nAll sections processed. Combining PDFs into the final book...\n")
    pdftools::pdf_combine(input = pages_to_combine, output = output_filename)
    if (length(temp_files_to_delete) > 0) {
      cat("Cleaning up temporary files...\n")
      file.remove(temp_files_to_delete)
    }
    cat(paste0("\nSuccess! Your book has been created: '", output_filename, "'\n"))
  } else {
    cat("\n--- No matching images or stories were found to create pages. ---\n")
  }
}
