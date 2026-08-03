#' Reorder a bb_tbl
#'
#' @param bb A bb_tbl
#' @param method Character. One of "default", "blind", "blind_pca", "truth"
#' @param ... Passed to the method implementation (e.g., k, diff_min)
#' @return A list with bb (bb_tbl), species_order, site_order, diagnostics
#' @export
bb_reorder <- function(bb, method = "default", ...) {
  
  bb_validate(bb)
  
  ## Allow alias from ... if you used order_method elsewhere
  dots <- list(...)
  if (!is.null(dots$order_method) && identical(method, "default")) {
    method <- dots$order_method
  }
  
  ## Make default meaningful
  if (identical(method, "default")) method <- "blind"
  
  switch(
    method,
    blind = bb_reorder_blind(bb, ...),
    pca   = bb_reorder_pca(bb, ...),
    stop("Unknown method: ", method)
  )
}



