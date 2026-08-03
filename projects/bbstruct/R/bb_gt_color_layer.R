#' Apply a numeric color layer to a bb_gt table
#'
#' @param gt_tbl A gt table object (typically output of bb_gt()).
#' @param bb A bb_tbl or bb_reorder() result (list containing $bb).
#' @param cell_color_ramp Character. Darkest color for ramp.
#' @param include_zero Logical. If TRUE, include 0 in the domain (usually FALSE if zeros are blanked).
#' @return A gt_tbl object with coloring applied.
#' @export
bb_gt_color_layer <- function(
    gt_tbl,
    bb,
    cell_color_ramp = "darkolivegreen4",
    include_zero = FALSE
) {
  if (!requireNamespace("gt", quietly = TRUE)) {
    stop("Package 'gt' is required.")
  }
  
  ## Resolve bb_tbl
  if (is.list(bb) && !is.null(bb$bb) && !is.null(bb$bb$x)) {
    bb <- bb$bb
  }
  if (is.null(bb$x)) stop("Input does not contain a table matrix in $x.")
  
  X <- bb$x
  sites <- colnames(X)
  max_value <- suppressWarnings(max(X, na.rm = TRUE))
  
  if (!is.finite(max_value) || max_value <= 0) {
    return(gt_tbl)  ## nothing to color
  }
  
  domain <- if (isTRUE(include_zero)) c(0, max_value) else c(1, max_value)
  
  gt::data_color(
    gt_tbl,
    columns = sites,
    method = "numeric",
    domain = domain,
    palette = c("white", cell_color_ramp)
  )
}
