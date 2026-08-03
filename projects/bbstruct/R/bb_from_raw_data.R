## bb_from_raw_data.R
## Stage 2: Convert inspected raw data into Braun–Blanquet table format (bb_tbl)

#' Convert inspected raw data to a Braun–Blanquet table format
#'
#' Takes a data frame where one column contains species identifiers and the
#' remaining columns are sites (numeric values). Returns a bb_tbl object.
#'
#' @param raw_data A data.frame containing a species column and one or more site columns.
#' @param species_col Integer or character. Which column contains species identifiers.
#'        Default is 1 (first column).
#' @param site_metadata Optional data.frame of site attributes (reserved for later stages).
#'        Stored in bb$meta$site_metadata; not used by ordering/metrics at this stage.
#' @param na_to_zero Logical. If TRUE, convert NA values in site columns to 0.
#'        Default FALSE (conservative).
#' @param name Optional character label for provenance (e.g., study name).
#' @return An object of class "bb_tbl" with fields x, species, sites, meta.
#' @export
bb_from_raw_data <- function(
    raw_data,
    species_col = 1,
    site_metadata = NULL,
    na_to_zero = FALSE,
    name = NULL
) {
  
  ## Basic checks
  if (!is.data.frame(raw_data)) {
    stop("`raw_data` must be a data.frame.")
  }
  if (ncol(raw_data) < 2) {
    stop("`raw_data` must have at least 2 columns: species + at least one site column.")
  }
  
  ## Resolve species column index
  if (is.character(species_col)) {
    if (!species_col %in% names(raw_data)) {
      stop("`species_col` ('", species_col, "') is not a column in `raw_data`.")
    }
    sp_idx <- match(species_col, names(raw_data))
  } else if (is.numeric(species_col) && length(species_col) == 1) {
    sp_idx <- as.integer(species_col)
    if (sp_idx < 1 || sp_idx > ncol(raw_data)) {
      stop("`species_col` is out of range for `raw_data`.")
    }
  } else {
    stop("`species_col` must be a single integer index or a single column name.")
  }
  
  ## Extract species identifiers
  species <- raw_data[[sp_idx]]
  species <- as.character(species)
  
  if (anyNA(species) || any(trimws(species) == "")) {
    stop("Species identifiers contain missing/blank values. Please fix before conversion.")
  }
  if (anyDuplicated(species)) {
    dups <- unique(species[duplicated(species)])
    stop("Duplicate species identifiers found: ", paste(dups, collapse = ", "))
  }
  
  ## Site columns are all columns except species_col
  site_idxs <- setdiff(seq_len(ncol(raw_data)), sp_idx)
  sites <- names(raw_data)[site_idxs]
  
  if (anyNA(sites) || any(trimws(sites) == "")) {
    stop("Site column names contain missing/blank values. Please fix before conversion.")
  }
  if (anyDuplicated(sites)) {
    stop("Duplicate site column names found: ", paste(unique(sites[duplicated(sites)]), collapse = ", "))
  }
  
  ## Extract site data and coerce to numeric safely
  site_df <- raw_data[, site_idxs, drop = FALSE]
  
  ## Helper: coerce a single column to numeric with informative errors
  coerce_numeric <- function(v, colname) {
    if (is.numeric(v)) return(as.numeric(v))
    
    ## Allow integer, logical, factor, character; coerce carefully
    if (is.factor(v)) v <- as.character(v)
    if (is.logical(v)) v <- as.integer(v)
    
    if (is.character(v)) {
      ## Strip common spreadsheet formatting (commas)
      v2 <- gsub(",", "", v, fixed = TRUE)
      suppressWarnings(num <- as.numeric(v2))
      ## as.numeric() returns NA for non-numeric strings
      bad <- which(!is.na(v2) & trimws(v2) != "" & is.na(num))
      if (length(bad) > 0) {
        examples <- unique(v[bad])
        examples <- utils::head(examples, 5)
        stop(
          "Non-numeric values found in site column '", colname, "'. ",
          "Examples: ", paste(examples, collapse = ", "), "."
        )
      }
      return(num)
    }
    
    stop("Unsupported column type in site column '", colname, "': ", class(v)[1])
  }
  
  site_mat <- sapply(seq_along(sites), function(j) {
    coerce_numeric(site_df[[j]], sites[j])
  })
  
  ## Ensure matrix with correct dimnames
  site_mat <- as.matrix(site_mat)
  if (nrow(site_mat) != nrow(raw_data)) {
    ## sapply can transpose in edge cases; fix orientation if needed
    site_mat <- t(site_mat)
  }
  
  rownames(site_mat) <- species
  colnames(site_mat) <- sites
  
  ## NA handling policy
  if (!na_to_zero && anyNA(site_mat)) {
    stop("NA values found in site columns. Fix them or set `na_to_zero = TRUE` to convert NAs to 0.")
  }
  if (na_to_zero && anyNA(site_mat)) {
    site_mat[is.na(site_mat)] <- 0
  }
  
  ## Build bb_tbl object
  meta <- list(
    name = name,
    created_from = "raw_data",
    species_col = if (is.character(species_col)) species_col else sp_idx,
    na_to_zero = na_to_zero,
    site_metadata = site_metadata
  )
  
  bb <- list(
    x = site_mat,
    species = species,
    sites = sites,
    meta = meta
  )
  class(bb) <- "bb_tbl"
  
  ## Optional: validate if you have bb_validate()
  if (exists("bb_validate", mode = "function")) {
    bb_validate(bb)
  }
  
  return(bb)
}
