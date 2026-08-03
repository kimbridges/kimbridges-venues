#' Render metrics comparison as a gt table
#' @export
bb_metrics_gt <- function(metrics_tbl,
                          title = "Structural metrics comparison",
                          subtitle = "Values are intended for relative comparison") {
  if (!requireNamespace("gt", quietly = TRUE)) {
    stop("Package 'gt' is required.")
  }
  
  gt::gt(metrics_tbl, rowname_col = "metric") |>
    gt::tab_header(title = title, subtitle = subtitle) |>
    gt::tab_options(table.font.size = gt::px(12))
}
