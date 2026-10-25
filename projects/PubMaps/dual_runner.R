
source("pubmap_tools.R")


# ------------------------------------------------------------------------------
# Batch Dual-Mode Runner
# ------------------------------------------------------------------------------
run_dual_test_suite <- function(config_dir = "test_suite/configs", 
                                output_dir = "test_suite/outputs") {
  
  yaml_files <- list.files(config_dir, pattern = "\\.yaml$", full.names = TRUE)
  if (length(yaml_files) == 0) stop("No YAML configurations found in ", config_dir)
  
  cat("Running Dual-Mode Map Generation across", length(yaml_files), "configs...\n")
  
  for (yf in yaml_files) {
    bname <- tools::file_path_sans_ext(basename(yf))
    cat("\n--------------------------------------------------\n")
    cat("Processing Case:", bname, "\n")
    
    cfg <- tryCatch(yaml::read_yaml(yf), error = function(e) NULL)
    if (is.null(cfg)) {
      warning("Failed to parse YAML: ", yf)
      next
    }
    
    # Ensure output paths point to output_dir
    cfg$output_pdf <- file.path(output_dir, paste0(bname, ".pdf"))
    
    tryCatch({
      generate_map_pair(cfg)
      cat("✓ Finished pair for:", bname, "\n")
    }, error = function(e) {
      cat("✗ Execution error on", bname, ":", conditionMessage(e), "\n")
    })
  }
  cat("\n==================================================\n")
  cat("Batch export complete. Inspect outputs in:", output_dir, "\n")
}

# Execute batch run
run_dual_test_suite()
