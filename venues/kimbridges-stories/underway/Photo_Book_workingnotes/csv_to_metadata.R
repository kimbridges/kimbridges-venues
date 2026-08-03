## --- csv_to_metadata.R ---
## Apply edited CSV metadata back to image files
## Requires: exiftoolr (wraps ExifTool for writing)
## First-time setup: exiftoolr::install_exiftool()

suppressPackageStartupMessages({
  library(exiftoolr)
})

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
#' @return Invisibly returns a summary data frame of changes made
#'
csv_to_metadata <- function(csv_file,
                            images_folder,
                            backup = TRUE,
                            backup_folder = "originals_backup",
                            dry_run = FALSE) {
  
  ## Validate inputs
  if (!file.exists(csv_file)) {
    stop("CSV file not found: ", csv_file)
  }
  if (!dir.exists(images_folder)) {
    stop("Images folder not found: ", images_folder)
  }
  
  ## Read CSV
  csv_data <- read.csv(csv_file, stringsAsFactors = FALSE, na.strings = "")
  
  ## Check required columns
  required_cols <- c("FileName")
  if (!all(required_cols %in% names(csv_data))) {
    stop("CSV must contain column: FileName")
  }
  
  ## Metadata columns we can write (others ignored)
  writable_cols <- c("Event", "Description", "Location", "City", 
                     "GPSLatitude", "GPSLongitude")
  present_cols <- intersect(writable_cols, names(csv_data))
  
  if (length(present_cols) == 0) {
    stop("CSV contains no writable metadata columns. Expected some of: ",
         paste(writable_cols, collapse = ", "))
  }
  
  message("CSV loaded: ", nrow(csv_data), " rows")
  message("Writable columns found: ", paste(present_cols, collapse = ", "))
  
  ## Create backup if requested
  if (backup && !dry_run) {
    backup_path <- file.path(images_folder, backup_folder)
    if (!dir.exists(backup_path)) {
      dir.create(backup_path, recursive = TRUE)
      message("Created backup folder: ", backup_path)
    }
  }
  
  ## Track changes
  change_log <- list()
  
  ## Process each row
  for (i in seq_len(nrow(csv_data))) {
    row <- csv_data[i, ]
    fname <- row$FileName
    
    if (is.na(fname) || nchar(fname) == 0) {
      message("  Row ", i, ": Skipping (empty filename)")
      next
    }
    
    img_path <- file.path(images_folder, fname)
    
    if (!file.exists(img_path)) {
      message("  Row ", i, " [", fname, "]: File not found, skipping")
      next
    }
    
    ## Build list of fields to update (only non-empty values)
    updates <- list()
    
    for (col in present_cols) {
      val <- row[[col]]
      if (!is.na(val) && nchar(trimws(as.character(val))) > 0) {
        updates[[col]] <- trimws(as.character(val))
      }
    }
    
    if (length(updates) == 0) {
      message("  Row ", i, " [", fname, "]: No changes (all fields empty)")
      next
    }
    
    ## Report what we're doing
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
      ## Backup the file first
      if (backup) {
        backup_dest <- file.path(images_folder, backup_folder, fname)
        if (!file.exists(backup_dest)) {
          file.copy(img_path, backup_dest)
        }
      }
      
      ## Build exiftool arguments
      ## Map our field names to EXIF/IPTC tags
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
        
        ## GPS needs special handling for reference direction
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
      
      ## Also write Description to XMP for broader compatibility
      if ("Description" %in% names(updates)) {
        args <- c(args, paste0("-XMP:Description=", updates$Description))
      }
      
      args <- c(args, img_path)
      
      ## Execute exiftool
      result <- tryCatch({
        exif_call(args = args, quiet = TRUE)
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
  
  ## Summary
  if (length(change_log) > 0) {
    summary_df <- do.call(rbind, change_log)
    n_success <- sum(summary_df$Action == "success")
    n_dry <- sum(summary_df$Action == "dry_run")
    n_error <- sum(grepl("^ERROR", summary_df$Action))
    
    message("\n--- Summary ---")
    if (dry_run) {
      message("DRY RUN: ", n_dry, " files would be modified")
    } else {
      message("Updated: ", n_success, " files")
      if (n_error > 0) message("Errors: ", n_error, " files")
      if (backup) message("Backups in: ", file.path(images_folder, backup_folder))
    }
    
    invisible(summary_df)
  } else {
    message("\nNo changes made.")
    invisible(data.frame())
  }
}


# =============================================================================
# USAGE EXAMPLES
# =============================================================================
#
# # First-time setup (only needed once):
# # install.packages("exiftoolr")
# # exiftoolr::install_exiftool()
#
# # Preview changes without writing (recommended first step):
# csv_to_metadata("metadata.csv", "Keepers", dry_run = TRUE)
#
# # Apply changes with automatic backup:
# csv_to_metadata("metadata.csv", "Keepers")
#
# # Apply without backup (if you have your own backup):
# csv_to_metadata("metadata.csv", "Keepers", backup = FALSE)
#
# # Custom backup folder name:
# csv_to_metadata("metadata.csv", "Keepers", backup_folder = "pre_edit_backup")
