#' Set up photobookr dependencies
#'
#' Checks for and installs required external tools (ExifTool and TinyTeX)
#' that are needed for full functionality.
#'
#' @param install_exiftool Logical. Install ExifTool if missing? Default TRUE.
#' @param install_tinytex Logical. Install TinyTeX if missing? Default TRUE.
#' @param install_latex_packages Logical. Install required LaTeX packages? Default TRUE.
#'
#' @return Invisibly returns TRUE if all setup completed successfully.
#' @export
#'
#' @examples
#' \dontrun{
#' photobookr_setup()
#' }
photobookr_setup <- function(install_exiftool = TRUE,
                              install_tinytex = TRUE,
                              install_latex_packages = TRUE) {
  
  message("=== photobookr setup ===\n")
  all_ok <- TRUE
  
  ## Check ExifTool
  message("Checking ExifTool...")
  exiftool_ok <- tryCatch({
    exiftoolr::exif_version()
    TRUE
  }, error = function(e) FALSE)
  
  if (exiftool_ok) {
    message("  ExifTool: OK")
  } else if (install_exiftool) {
    message("  ExifTool: Not found. Installing...")
    tryCatch({
      exiftoolr::install_exiftool()
      message("  ExifTool: Installed successfully")
    }, error = function(e) {
      message("  ExifTool: Installation failed - ", e$message)
      all_ok <- FALSE
    })
  } else {
    message("  ExifTool: Not found (skipping install)")
    all_ok <- FALSE
  }
  
  ## Check TinyTeX
  message("\nChecking TinyTeX...")
  tinytex_ok <- tryCatch({
    tinytex::is_tinytex()
  }, error = function(e) FALSE)
  
  if (tinytex_ok) {
    message("  TinyTeX: OK")
  } else if (install_tinytex) {
    message("  TinyTeX: Not found. Installing (this may take a few minutes)...")
    tryCatch({
      tinytex::install_tinytex()
      message("  TinyTeX: Installed successfully")
    }, error = function(e) {
      message("  TinyTeX: Installation failed - ", e$message)
      all_ok <- FALSE
    })
  } else {
    message("  TinyTeX: Not found (skipping install)")
    all_ok <- FALSE
  }
  
  ## Install LaTeX packages needed for extended font sizes
  if (install_latex_packages && tinytex_ok) {
    message("\nChecking LaTeX packages...")
    packages_needed <- c("extsizes", "geometry")
    for (pkg in packages_needed) {
      tryCatch({
        tinytex::tlmgr_install(pkg)
        message("  ", pkg, ": OK")
      }, error = function(e) {
        message("  ", pkg, ": Failed to install")
      })
    }
  }
  
  ## Summary
  message("\n=== Setup complete ===")
  if (all_ok) {
    message("All dependencies are ready. You can now use photobookr!")
  } else {
    message("Some dependencies may be missing. Check messages above.")
  }
  

  invisible(all_ok)
}
