# Utility functions for photobookr
# These are internal functions, not exported

#' Null coalescing operator
#' @noRd
`%||%` <- function(a, b) if (is.null(a)) b else a

#' Read and validate config file
#' @param config_file Path to YAML config file
#' @return List of configuration values with defaults applied
#' @noRd
read_config <- function(config_file = "config.yaml") {
  if (!file.exists(config_file)) {
    stop("Config file not found: ", config_file, 
         "\nUse photobookr_example_config() to create a template.")
  }
  
  cfg <- yaml::read_yaml(config_file)
  
  ## Apply defaults
  defaults <- list(
    book_name = "Photo Book",
    output_pdf = "Photo_Book.pdf",
    cover_file = NULL,
    folders = list(
      stories = "Stories",
      images = "Images",
      kml = "KML"
    ),
    spread = list(
      suffix = "_2W"
    ),
    verification = list(
      enabled = TRUE,
      output_file = "Photo_Book_verification.pdf"
    ),
    map = list(
      output_file = "Photo_Book_map.html"
    )
  )
  
  ## Merge with defaults (config values override defaults)
  cfg <- merge_lists(defaults, cfg)
  
  return(cfg)
}


#' Recursively merge two lists (b overrides a)
#' @noRd
merge_lists <- function(a, b) {
  if (is.null(b)) return(a)
  if (!is.list(a) || !is.list(b)) return(b)
  
  for (name in names(b)) {
    if (name %in% names(a) && is.list(a[[name]]) && is.list(b[[name]])) {
      a[[name]] <- merge_lists(a[[name]], b[[name]])
    } else {
      a[[name]] <- b[[name]]
    }
  }
  return(a)
}


#' Check if filename indicates a two-page spread
#' @param filepath Path to image file
#' @param suffix The suffix to check for (default "_2W")
#' @return Logical
#' @noRd
is_two_page_spread <- function(filepath, suffix = "_2W") {
  base <- tools::file_path_sans_ext(basename(filepath))
  grepl(paste0(suffix, "$"), base, ignore.case = TRUE)
}


#' Safe EXIF read for a single file
#' @param path Path to image
#' @param tags Character vector of tags to read
#' @return Data frame or NULL on error
#' @noRd
safe_read_exif <- function(path, tags) {
  tryCatch(
    exifr::read_exif(path, tags = tags),
    error = function(e) NULL
  )
}


#' Safely get EXIF field value
#' Handles field aliases (e.g., Location/Sub-location)
#' @param df Data frame from read_exif
#' @param field Field name to get
#' @return Value or NULL
#' @noRd
safe_get_exif <- function(df, field) {
  aliases <- list(
    "Location" = c("Location", "Sub-location")
  )
  
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


#' Case-insensitive string equality with trimming
#' @noRd
eq_ci <- function(a, b) {
  gsub("[^a-z0-9]+", "", tolower(trimws(a))) == gsub("[^a-z0-9]+", "", tolower(trimws(b)))
}


#' Copy example config to working directory
#' 
#' @param filename Name for the config file (default "config.yaml")
#' @param overwrite Overwrite existing file? Default FALSE.
#' @return Path to created file (invisibly)
#' @export
#'
#' @examples
#' \dontrun{
#' photobookr_example_config()
#' }
photobookr_example_config <- function(filename = "config.yaml", overwrite = FALSE) {
  example_path <- system.file("examples", "config.yaml", package = "photobookr")
  
  if (example_path == "") {
    stop("Example config not found in package installation.")
  }
  
  if (file.exists(filename) && !overwrite) {
    stop("File already exists: ", filename, "\nUse overwrite = TRUE to replace.")
  }
  
  file.copy(example_path, filename, overwrite = overwrite)
  message("Created config file: ", filename)
  message("Edit this file to customize your photo book settings.")
  
  invisible(filename)
}
