# =============================================================================
# run_analysis.R
# Launcher script for the Cold/Warm Temperature Analysis System
#
# Usage:
#   1. Set parameters below
#   2. Run: source("run_analysis.R")
#   Or from terminal: Rscript -e "rmarkdown::render('analysis_report.Rmd', params=list(...))"
# =============================================================================

# --- Required packages (install once) ---
required_packages <- c("dplyr", "lubridate", "ggplot2", "tidyr", "patchwork",
                        "knitr", "kableExtra", "rmarkdown")

missing <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]
if (length(missing) > 0) {
  cat("Installing missing packages:", paste(missing, collapse = ", "), "\n")
  install.packages(missing)
}

# Optional: install rnoaa for live NOAA data access
# install.packages("rnoaa")

# --- Analysis parameters ---
# Modify these to analyze different sites and conditions

params <- list(
  # Site identification
  site_name      = "Eugene, Oregon, USA",
  station_id     = "USW00024221",       # GHCN station ID
  
  # Threshold and edge case parameters
  threshold      = 32,                   # degrees F
  minimum_start  = 2,                    # consecutive cold days to start season
  minimum_end    = 1,                    # consecutive cold days to end season
  
  # Threshold sensitivity sweep
  sweep_from     = 28,                   # start of sweep range (F)
  sweep_to       = 34,                   # end of sweep range (F)
  sweep_by       = 2,                    # increment (F)
  
  # Data source
  use_synthetic  = TRUE,                 # TRUE for synthetic, FALSE for real data
  data_start_year = 2013,
  data_end_year   = 2024,
  data_file       = NULL                 # path to CSV if using pre-downloaded data
)

# --- Render the report ---
cat("=== Cold/Warm Temperature Analysis System ===\n")
cat("Site:", params$site_name, "\n")
cat("Threshold:", params$threshold, "°F\n")
cat("Sweep:", params$sweep_from, "to", params$sweep_to, "by", params$sweep_by, "°F\n")
cat("Data source:", ifelse(params$use_synthetic, "Synthetic", "GHCN-Daily"), "\n")
cat("=============================================\n\n")

output_file <- paste0("report_",
                       gsub("[^a-zA-Z0-9]", "_", params$site_name), "_",
                       params$threshold, "F.html")

rmarkdown::render(
  input       = "analysis_report.Rmd",
  output_file = output_file,
  params      = params,
  envir       = new.env(parent = globalenv()),
  quiet       = FALSE
)

cat("\n\nReport saved to:", output_file, "\n")
