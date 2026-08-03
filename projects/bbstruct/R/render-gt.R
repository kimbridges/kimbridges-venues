#' Render the reordered table as a gt object
#'
#' @param bb A `bb_tbl`.
#' @param title Title string.
#' @param source_note Source note string.
#' @return A gt table.
#' @export
bb_render_gt <- function(bb, title = "Reordered table", source_note = NULL) {
  bb_validate(bb)
  
  df <- as.data.frame(bb$x)
  df <- tibble::rownames_to_column(df, var = "species")
  
  gt_tbl <- gt::gt(df) |>
    gt::tab_header(title = title)
  
  if (!is.null(source_note)) {
    gt_tbl <- gt::tab_source_note(gt_tbl, source_note = gt::md(source_note))
  }
  
  gt_tbl
}

