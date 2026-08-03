## bb_metrics_tbl.R
## Stage 5 helper: produce a comparison table of key structural metrics

#' Create a compact metrics comparison table across orderings
#'
#' @param bb A bb_tbl object (unordered or ordered; orderings can be applied here).
#' @param orderings Named list of ordering specifications. Each element should be a list
#'   with fields method and (optionally) args (a named list passed to bb_reorder).
#' @param metrics_keep Character vector of metric names to keep (rows).
#' @param metric_rename Optional named character vector to rename metrics for display.
#' @param decimals Integer, number of decimals to round numeric values.
#' @return A data.frame with a 'metric' column and one column per ordering.
#' @export
bb_metrics_tbl <- function(
    bb,
    orderings = list(
      blind = list(method = "blind", args = list()),
      pca = list(method = "pca", args = list()),
      pca_sites_fixed = list(method = "pca", args = list(reorder_sites = FALSE))
    ),
    metrics_keep = c(
      "adjacent_col_smoothness",
      "adjacent_col_smoothness_norm",
      "adjacent_row_smoothness",
      "adjacent_row_smoothness_norm",
      "contrast",
      "density_nonzero"
    ),
    metric_rename = c(
      adjacent_col_smoothness = "Adjacent column smoothness",
      adjacent_col_smoothness_norm = "Adjacent column smoothness (norm)",
      adjacent_row_smoothness = "Adjacent row smoothness",
      adjacent_row_smoothness_norm = "Adjacent row smoothness (norm)",
      contrast = "Contrast",
      density_nonzero = "Nonzero density"
    ),
    decimals = 3
) {
  
  bb_validate(bb)
  
  ## Helper: flatten metrics to named numeric vector
  flatten_numeric <- function(metrics_obj) {
    x <- unlist(metrics_obj, recursive = TRUE, use.names = TRUE)
    
    ## Keep only numeric entries
    suppressWarnings(num <- as.numeric(x))
    ok <- !is.na(num)
    num <- num[ok]
    names(num) <- names(x)[ok]
    num
  }
  
  ## Helper: retrieve first matching metric by exact name or suffix match
  ## This tolerates nested names like "smoothness$adjacent_col_smoothness"
  pick_metric <- function(v, target) {
    if (target %in% names(v)) return(v[[target]])
    hits <- grep(paste0("(^|\\.|\\$)", target, "$"), names(v), value = TRUE)
    if (length(hits) >= 1) return(v[[hits[[1]]]])
    NA_real_
  }
  
  ## Compute per-ordering vectors
  vals_by_ord <- lapply(orderings, function(spec) {
    method <- spec$method
    args <- spec$args %||% list()
    
    res <- do.call(bb_reorder, c(list(bb = bb, method = method), args))
    m <- bb_metrics(res)
    v <- flatten_numeric(m)
    
    ## Extract curated metrics
    out <- vapply(metrics_keep, function(k) pick_metric(v, k), numeric(1))
    out
  })
  
  ## Build table (metrics as rows, orderings as columns)
  tbl <- data.frame(
    metric = metrics_keep,
    check.names = FALSE,
    stringsAsFactors = FALSE
  )
  
  for (nm in names(vals_by_ord)) {
    tbl[[nm]] <- vals_by_ord[[nm]]
  }
  
  ## Round for readability
  num_cols <- setdiff(names(tbl), "metric")
  tbl[num_cols] <- lapply(tbl[num_cols], function(x) round(x, decimals))
  
  ## Friendly labels if provided
  if (!is.null(metric_rename)) {
    tbl$metric <- ifelse(tbl$metric %in% names(metric_rename),
                         unname(metric_rename[tbl$metric]),
                         tbl$metric)
  }
  
  tbl
}

## small helper (keeps dependencies minimal)
`%||%` <- function(a, b) if (!is.null(a)) a else b


