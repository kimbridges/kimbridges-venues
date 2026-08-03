#' Read a species-by-site table from CSV
#'
#' @param path Path to CSV.
#' @param species_col Name of the species column, if present (default "species").
#' @return A `bb_tbl` object.
#' @export
bb_read_csv <- function(path, species_col = "species") {
  old <- options(readr.show_col_types = FALSE)
  on.exit(options(old), add = TRUE)
  
  df <- readr::read_csv(path)
  
  if (species_col %in% names(df)) {
    species <- df[[species_col]]
    df[[species_col]] <- NULL
    x <- as.matrix(df)
    rownames(x) <- species
  } else {
    x <- as.matrix(df)
  }
  
  storage.mode(x) <- "numeric"
  
  out <- list(
    x = x,
    species = rownames(x),
    sites = colnames(x),
    meta = list(source = path)
  )
  class(out) <- "bb_tbl"
  out
}

