#' Compute diagnostics for a species-by-site table
#'
#' @param x Either a `bb_tbl` or a `bb_reorder()` result (list with `$bb`).
#' @param na_rm Logical; whether to remove NA values. Default FALSE (NA not expected).
#' @param ... Reserved for future parameters.
#'
#' @return A named list of metrics.
#' @export
bb_metrics <- function(x, na_rm = FALSE, ...) {
  bb <- bb_extract_bb_(x)
  bb_validate(bb)
  
  m <- bb$x
  storage.mode(m) <- "numeric"
  
  ## Basic summaries
  n_species <- nrow(m)
  n_sites   <- ncol(m)
  total     <- sum(m, na.rm = na_rm)
  mean_all  <- mean(m, na.rm = na_rm)
  sd_all    <- stats::sd(as.vector(m), na.rm = na_rm)
  density_nonzero <- mean(m != 0, na.rm = na_rm)
  
  ## Contrast: average absolute deviation from global mean, scaled by mean
  ## (Works well for showing "patchiness" increasing as blocks sharpen.)
  mad_all <- mean(abs(m - mean_all), na.rm = na_rm)
  contrast <- if (isTRUE(all.equal(mean_all, 0))) NA_real_ else mad_all / (abs(mean_all) + 1e-12)
  
  ## Adjacent smoothness on margins: smaller is smoother
  col_sums <- colSums(m, na.rm = na_rm)
  row_sums <- rowSums(m, na.rm = na_rm)
  
  adjacent_diff <- function(v) {
    if (length(v) < 2) return(NA_real_)
    mean(abs(diff(v)), na.rm = TRUE)
  }
  
  adjacent_col_smoothness <- adjacent_diff(col_sums)
  adjacent_row_smoothness <- adjacent_diff(row_sums)
  
  ## Normalized variants (optional but handy for comparisons across tables)
  norm_adjacent <- function(v) {
    if (length(v) < 2) return(NA_real_)
    denom <- mean(abs(v), na.rm = TRUE)
    if (isTRUE(all.equal(denom, 0))) return(NA_real_)
    mean(abs(diff(v)), na.rm = TRUE) / (denom + 1e-12)
  }
  
  adjacent_col_smoothness_norm <- norm_adjacent(col_sums)
  adjacent_row_smoothness_norm <- norm_adjacent(row_sums)
  
  list(
    n_species = n_species,
    n_sites = n_sites,
    total = total,
    mean = mean_all,
    sd = sd_all,
    density_nonzero = density_nonzero,
    
    contrast = contrast,
    
    col_sums = col_sums,
    row_sums = row_sums,
    
    adjacent_col_smoothness = adjacent_col_smoothness,
    adjacent_row_smoothness = adjacent_row_smoothness,
    adjacent_col_smoothness_norm = adjacent_col_smoothness_norm,
    adjacent_row_smoothness_norm = adjacent_row_smoothness_norm
  )
}

## Internal helper: accept either bb_tbl or bb_reorder result
bb_extract_bb_ <- function(x) {
  if (inherits(x, "bb_tbl")) return(x)
  if (is.list(x) && !is.null(x$bb) && inherits(x$bb, "bb_tbl")) return(x$bb)
  rlang::abort("Expected a `bb_tbl` or a `bb_reorder()` result with `$bb`.")
}
