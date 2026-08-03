#' Extract metadata from images to CSV
#'
#' Scans all JPG files in a folder, extracts key metadata fields to a CSV,
#' and generates a visual proof sheet (PDF or HTML) for reference while editing.
#'
#' @param images_folder Path to folder containing JPG images
#' @param output_csv Path for output CSV file (default: "metadata.csv")
#' @param proof_format Either "pdf", "html", or "both" (default: "pdf")
#' @param proof_file Base name for proof sheet (extension added automatically)
#' @param thumb_width Thumbnail width in pixels for proof sheet (default: 300)
#'
#' @return Invisibly returns the metadata data frame
#' @export
#'
#' @examples
#' \dontrun{
#' # Extract with PDF proof sheet
#' metadata_to_csv("Images")
#'
#' # With HTML proof sheet (clickable thumbnails)
#' metadata_to_csv("Images", proof_format = "html")
#'
#' # Generate both formats
#' metadata_to_csv("Images", proof_format = "both")
#' }
metadata_to_csv <- function(images_folder,
                            output_csv = "metadata.csv",
                            proof_format = "pdf",
                            proof_file = "proof_sheet",
                            thumb_width = 300) {

  if (!dir.exists(images_folder)) {
    stop("Folder not found: ", images_folder)
  }
  proof_format <- tolower(proof_format)
  if (!proof_format %in% c("pdf", "html", "both")) {
    stop("proof_format must be 'pdf', 'html', or 'both'")
  }

  image_files <- list.files(images_folder,
                            pattern = "\\.jpe?g$",
                            ignore.case = TRUE,
                            full.names = TRUE)

  if (length(image_files) == 0) {
    stop("No JPG files found in: ", images_folder)
  }

  image_files <- image_files[order(basename(image_files))]
  message("Found ", length(image_files), " images in ", images_folder)
  message("Extracting metadata...")

  tags_to_read <- c("Event", "Description", "Sub-location", "Location", "City",
                    "GPSLatitude", "GPSLongitude")

  rows <- list()
  for (i in seq_along(image_files)) {
    img_path <- image_files[i]
    fname <- basename(img_path)

    exif <- tryCatch(
      exifr::read_exif(img_path, tags = tags_to_read),
      error = function(e) NULL
    )

    get_val <- function(field) {
      if (is.null(exif) || !field %in% names(exif)) return(NA_character_)
      val <- exif[[field]]
      if (is.null(val) || length(val) == 0) return(NA_character_)
      as.character(val)
    }

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

  utils::write.csv(metadata_df, output_csv, row.names = FALSE, na = "")
  message("CSV written: ", output_csv)

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


#' Apply metadata from CSV back to image files
#'
#' Reads an edited CSV and writes the metadata fields back to the corresponding
#' JPG files. Creates a backup of original files before modifying.
#'
#' @param csv_file Path to the edited CSV file
#' @param images_folder Path to folder containing the JPG images
#' @param backup If TRUE (default), copy originals to a backup subfolder first
#' @param backup_folder Name of backup subfolder (default: "originals_backup")
#' @param dry_run If TRUE, report what would change without writing (default: FALSE)
#'
#' @return Invisibly returns a summary data frame of changes made
#' @export
#'
#' @examples
#' \dontrun{
#' # Preview changes first
#' csv_to_metadata("metadata.csv", "Images", dry_run = TRUE)
#'
#' # Apply changes with automatic backup
#' csv_to_metadata("metadata.csv", "Images")
#'
#' # Apply without backup (use your own backup strategy)
#' csv_to_metadata("metadata.csv", "Images", backup = FALSE)
#' }
csv_to_metadata <- function(csv_file,
                            images_folder,
                            backup = TRUE,
                            backup_folder = "originals_backup",
                            dry_run = FALSE) {

  if (!file.exists(csv_file)) {
    stop("CSV file not found: ", csv_file)
  }
  if (!dir.exists(images_folder)) {
    stop("Images folder not found: ", images_folder)
  }

  csv_data <- utils::read.csv(csv_file, stringsAsFactors = FALSE, na.strings = "")

  if (!"FileName" %in% names(csv_data)) {
    stop("CSV must contain column: FileName")
  }

  writable_cols <- c("Event", "Description", "Location", "City",
                     "GPSLatitude", "GPSLongitude")
  present_cols <- intersect(writable_cols, names(csv_data))

  if (length(present_cols) == 0) {
    stop("CSV contains no writable metadata columns.")
  }

  message("CSV loaded: ", nrow(csv_data), " rows")
  message("Writable columns: ", paste(present_cols, collapse = ", "))

  if (backup && !dry_run) {
    backup_path <- file.path(images_folder, backup_folder)
    if (!dir.exists(backup_path)) {
      dir.create(backup_path, recursive = TRUE)
      message("Created backup folder: ", backup_path)
    }
  }

  change_log <- list()

  for (i in seq_len(nrow(csv_data))) {
    row <- csv_data[i, ]
    fname <- row$FileName

    if (is.na(fname) || nchar(fname) == 0) next

    img_path <- file.path(images_folder, fname)
    if (!file.exists(img_path)) {
      message("  Row ", i, " [", fname, "]: File not found, skipping")
      next
    }

    updates <- list()
    for (col in present_cols) {
      val <- row[[col]]
      if (!is.na(val) && nchar(trimws(as.character(val))) > 0) {
        updates[[col]] <- trimws(as.character(val))
      }
    }

    if (length(updates) == 0) next

    change_summary <- paste(names(updates), "=",
                            sapply(updates, function(x) substr(x, 1, 30)),
                            collapse = "; ")

    if (dry_run) {
      message("  Row ", i, " [", fname, "]: WOULD SET ", change_summary)
      change_log[[length(change_log) + 1]] <- data.frame(
        Row = i, FileName = fname, Action = "dry_run", Fields = change_summary,
        stringsAsFactors = FALSE
      )
    } else {
      if (backup) {
        backup_dest <- file.path(images_folder, backup_folder, fname)
        if (!file.exists(backup_dest)) {
          file.copy(img_path, backup_dest)
        }
      }

      tag_map <- list(
        Event = "-XMP:Event",
        Description = "-IPTC:Caption-Abstract",
        Location = "-IPTC:Sub-location",
        City = "-IPTC:City",
        GPSLatitude = "-GPSLatitude",
        GPSLongitude = "-GPSLongitude"
      )

      args <- c("-overwrite_original")

      for (field in names(updates)) {
        tag <- tag_map[[field]]
        val <- updates[[field]]

        if (field == "GPSLatitude") {
          lat <- as.numeric(val)
          ref <- if (lat >= 0) "N" else "S"
          args <- c(args, paste0("-GPSLatitude=", abs(lat)))
          args <- c(args, paste0("-GPSLatitudeRef=", ref))
        } else if (field == "GPSLongitude") {
          lon <- as.numeric(val)
          ref <- if (lon >= 0) "E" else "W"
          args <- c(args, paste0("-GPSLongitude=", abs(lon)))
          args <- c(args, paste0("-GPSLongitudeRef=", ref))
        } else {
          args <- c(args, paste0(tag, "=", val))
        }
      }

      if ("Description" %in% names(updates)) {
        args <- c(args, paste0("-XMP:Description=", updates$Description))
      }

      args <- c(args, img_path)

      result <- tryCatch({
        exiftoolr::exif_call(args = args, quiet = TRUE)
        "success"
      }, error = function(e) {
        paste("ERROR:", e$message)
      })

      message("  Row ", i, " [", fname, "]: ",
              ifelse(result == "success", "Updated", result))

      change_log[[length(change_log) + 1]] <- data.frame(
        Row = i, FileName = fname, Action = result, Fields = change_summary,
        stringsAsFactors = FALSE
      )
    }
  }

  if (length(change_log) > 0) {
    summary_df <- do.call(rbind, change_log)
    n_success <- sum(summary_df$Action == "success")
    n_dry <- sum(summary_df$Action == "dry_run")

    message("\n--- Summary ---")
    if (dry_run) {
      message("DRY RUN: ", n_dry, " files would be modified")
    } else {
      message("Updated: ", n_success, " files")
      if (backup) message("Backups in: ", file.path(images_folder, backup_folder))
    }

    invisible(summary_df)
  } else {
    message("\nNo changes made.")
    invisible(data.frame())
  }
}


# --- Internal proof sheet functions ---

#' Generate PDF proof sheet
#' @noRd
generate_proof_pdf <- function(image_files, metadata_df, output_path, thumb_width) {

  cols <- 2
  rows_per_page <- 3
  per_page <- cols * rows_per_page

  page_w <- 8.5
  page_h <- 11
  margin <- 0.5

  usable_w <- page_w - (2 * margin)
  usable_h <- page_h - (2 * margin)
  cell_w <- usable_w / cols
  cell_h <- usable_h / rows_per_page

  grDevices::pdf(output_path, width = page_w, height = page_h)

  n_images <- length(image_files)
  n_pages <- ceiling(n_images / per_page)

  for (page in seq_len(n_pages)) {
    graphics::par(mar = c(0, 0, 0, 0))
    graphics::plot(0, 0, type = "n", xlim = c(0, page_w), ylim = c(0, page_h),
                   axes = FALSE, xlab = "", ylab = "", asp = 1)

    start_idx <- (page - 1) * per_page + 1
    end_idx <- min(page * per_page, n_images)

    for (idx in start_idx:end_idx) {
      pos_on_page <- idx - start_idx
      col <- pos_on_page %% cols
      row <- pos_on_page %/% cols

      x_left <- margin + col * cell_w
      y_top <- page_h - margin - row * cell_h

      img <- tryCatch(
        magick::image_orient(magick::image_read(image_files[idx])),
        error = function(e) NULL
      )

      if (!is.null(img)) {
        img_thumb <- magick::image_resize(img, paste0(thumb_width, "x"))
        info <- magick::image_info(img_thumb)

        text_space <- 0.5
        max_img_h <- cell_h - text_space
        max_img_w <- cell_w - 0.2

        img_w_in <- info$width / 72
        img_h_in <- info$height / 72

        scale <- min(max_img_w / img_w_in, max_img_h / img_h_in, 1)
        display_w <- img_w_in * scale
        display_h <- img_h_in * scale

        x_center <- x_left + cell_w / 2
        img_x <- x_center - display_w / 2
        img_y <- y_top - 0.3 - display_h

        graphics::rasterImage(img_thumb,
                              img_x, img_y,
                              img_x + display_w, img_y + display_h,
                              interpolate = TRUE)

        graphics::text(x_center, y_top - 0.15,
                       labels = paste0("[", idx, "]"),
                       cex = 1.2, font = 2)

        graphics::text(x_center, img_y - 0.1,
                       labels = metadata_df$FileName[idx],
                       cex = 0.7)

        if (!is.na(metadata_df$Event[idx]) && nchar(metadata_df$Event[idx]) > 0) {
          graphics::text(x_center, img_y - 0.25,
                         labels = paste0("Event: ", metadata_df$Event[idx]),
                         cex = 0.6, col = "gray40")
        }
      }
    }
  }

  grDevices::dev.off()
}


#' Generate HTML proof sheet
#' @noRd
generate_proof_html <- function(image_files, metadata_df, output_path, thumb_width) {

  abs_paths <- normalizePath(image_files, winslash = "/")

  html_escape <- function(text) {
    text <- gsub("&", "&amp;", text)
    text <- gsub("<", "&lt;", text)
    text <- gsub(">", "&gt;", text)
    text <- gsub('"', "&quot;", text)
    text
  }

  html_lines <- c(
    '<!DOCTYPE html>',
    '<html lang="en">',
    '<head>',
    '  <meta charset="UTF-8">',
    '  <title>Proof Sheet</title>',
    '  <style>',
    '    body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;',
    '           margin: 20px; background: #f5f5f5; }',
    '    .grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; max-width: 900px; }',
    '    .cell { background: white; padding: 15px; border-radius: 8px;',
    '            box-shadow: 0 2px 4px rgba(0,0,0,0.1); text-align: center; }',
    '    .row-num { font-size: 1.4em; font-weight: bold; margin-bottom: 8px; }',
    '    .thumb { max-width: 100%; cursor: pointer; border: 1px solid #ddd; }',
    '    .thumb:hover { border-color: #007acc; }',
    '    .filename { font-size: 0.85em; color: #555; margin-top: 8px; }',
    '    .event { font-size: 0.75em; color: #888; margin-top: 4px; }',
    '  </style>',
    '</head>',
    '<body>',
    '  <h1>Proof Sheet</h1>',
    '  <p>Click any thumbnail to view full size.</p>',
    '  <div class="grid">'
  )

  for (i in seq_along(image_files)) {
    fname <- metadata_df$FileName[i]
    event_text <- if (!is.na(metadata_df$Event[i]) && nchar(metadata_df$Event[i]) > 0) {
      paste0('    <div class="event">Event: ', html_escape(metadata_df$Event[i]), '</div>')
    } else {
      ''
    }

    file_url <- paste0("file://", abs_paths[i])

    cell_html <- c(
      '    <div class="cell">',
      paste0('      <div class="row-num">[', i, ']</div>'),
      paste0('      <a href="', file_url, '" target="_blank">'),
      paste0('        <img class="thumb" src="', file_url, '" width="', thumb_width, '">'),
      '      </a>',
      paste0('      <div class="filename">', html_escape(fname), '</div>'),
      event_text,
      '    </div>'
    )

    html_lines <- c(html_lines, cell_html)
  }

  html_lines <- c(html_lines, '  </div>', '</body>', '</html>')
  writeLines(html_lines, output_path)
}
