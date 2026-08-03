#' Render a bb table as a gt object
#'
#' @param x A bb_tbl or a bb_reorder() result (list containing $bb).
#' @param title,subtitle Optional table title/subtitle.
#' @param blank_zeros Logical. If TRUE, display zeros as blanks (implemented as NA).
#' @param font_px Numeric. Base font size for the table.
#' @return A gt_tbl object.
#' @export
bb_gt <- function(x,
                  title = NULL,
                  subtitle = NULL,
                  blank_zeros = TRUE,
                  font_px = 12) {
  
  if (!requireNamespace("gt", quietly = TRUE)) {
    stop("Package 'gt' is required. Install it first.")
  }
  
  ## Accept either bb_tbl or bb_reorder result
  bb <- x
  if (is.list(x) && !is.null(x$bb) && !is.null(x$bb$x)) {
    bb <- x$bb
  }
  
  if (is.null(bb$x)) stop("Input does not contain a table matrix in $x.")
  X <- bb$x
  df <- as.data.frame(X, stringsAsFactors = FALSE)
  
  ## Blank zeros without converting to character
  if (isTRUE(blank_zeros)) {
    df[] <- lapply(df, function(v) {
      v <- as.numeric(v)
      v[v == 0] <- NA_real_
      v
    })
  }
  
  gt_tbl <- gt::gt(df, rownames_to_stub = TRUE)
  
  if (!is.null(title) || !is.null(subtitle)) {
    gt_tbl <- gt_tbl |>
      gt::tab_header(
        title = if (!is.null(title)) title else "",
        subtitle = subtitle
      )
  }
  
  ## Show NA as blank if blank_zeros was used
  if (isTRUE(blank_zeros)) {
    gt_tbl <- gt_tbl |>
      gt::sub_missing(columns = gt::everything(), missing_text = "")
  }
  
  gt_tbl |>
    gt::tab_options(table.font.size = gt::px(font_px))
}

