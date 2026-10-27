# ------------------------------------------------------------------------------
# Test Harness: Automated Benchmark Runner for Reference Maps
# ------------------------------------------------------------------------------
library(yaml)
library(tools)

run_test_suite <- function(input_dir  = "test_suite/inputs",
                           config_dir = "test_suite/configs",
                           output_dir = "test_suite/outputs") {
  
  dir.create(config_dir, showWarnings = FALSE, recursive = TRUE)
  dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)
  
  test_files <- list.files(input_dir, pattern = "\\.txt$", full.names = TRUE)
  if (length(test_files) == 0) stop("No test files found in ", input_dir)
  
  results <- data.frame(
    file        = character(),
    country     = character(),
    status      = character(),
    error_msg   = character(),
    stringsAsFactors = FALSE
  )
  
  for (f in test_files) {
    base_name <- file_path_sans_ext(basename(f))
    cat("\n==================================================\n")
    cat("Testing:", base_name, "\n")
    
    txt_content <- paste(readLines(f, warn = FALSE), collapse = "\n")
    yaml_path   <- file.path(config_dir, paste0(base_name, ".yaml"))
    pdf_path    <- file.path(output_dir, paste0(base_name, ".pdf"))
    
    status <- "SUCCESS"
    err    <- ""
    country_name <- NA
    
    # 1. Query LLM & Cache YAML
    tryCatch({
      config <- query_llm_yaml(txt_content)
      config$output_pdf <- pdf_path  # Override target path to test output directory
      write_yaml(config, yaml_path)
      country_name <- config$country_name
      cat("  -> YAML generated for country:", country_name, "\n")
    }, error = function(e) {
      status <<- "LLM_ERROR"
      err <<- conditionMessage(e)
    })
    
    # 2. Render Map if YAML was created
    if (status == "SUCCESS") {
      tryCatch({
        sites_df <- do.call(rbind, lapply(config$sites, as.data.frame))
        generate_publication_map(
          country_name     = config$country_name,
          subdivision_name = config$subdivision_name,
          study_bbox_wgs84 = unlist(config$study_bbox_wgs84),
          main_bbox_wgs84  = unlist(config$main_bbox_wgs84),
          sites_df         = sites_df,
          inset_corner     = config$inset_corner,
          output_pdf       = config$output_pdf
        )
        cat("  -> Map successfully rendered:", pdf_path, "\n")
      }, error = function(e) {
        status <<- "RENDER_ERROR"
        err <<- conditionMessage(e)
      })
    }
    
    results <- rbind(results, data.frame(
      file = base_name, country = country_name, status = status, error_msg = err
    ))
  }
  
  cat("\n==================================================\n")
  cat("Test Suite Execution Summary:\n")
  print(results)
  write.csv(results, file.path(output_dir, "test_results.csv"), row.names = FALSE)
  return(results)
}

################

run_test_suite()
