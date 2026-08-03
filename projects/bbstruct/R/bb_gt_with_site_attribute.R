## bb_gt_with_site_attribute.R
## Render a bb table with one site attribute row above species

#' Render a bb table with a site attribute row
#'
#' @param x A bb_tbl or a bb_reorder() result (list containing $bb).
#' @param site_metadata data.frame with an id column matching site names in the bb table.
#' @param attr Character. Column name in site_metadata to display (e.g., "elevation", "soil").
#' @param attr_label Character. Label shown for the attribute row stub (default uses attr).
#' @param id_col Character. Column name in site_metadata holding site IDs (default "id").
#' @param title,subtitle Optional gt title/subtitle.
#' @param blank_zeros Logical. If TRUE, display zeros in species rows as blanks.
#' @param font_px Numeric. Base font size.
#' @return A gt_tbl.
#' @export
bb_gt_with_site_attribute <- function(
    x,
    site_metadata,
    attr,
    attr_label = NULL,
    id_col = "id",
    title = NULL,
    subtitle = NULL,
    blank_zeros = TRUE,
    font_px = 12
) {
  if (!requireNamespace("gt", quietly = TRUE)) {
    stop("Package 'gt' is required.")
  }
  
  ## Resolve bb_tbl
  bb <- x
  if (is.list(x) && !is.null(x$bb) && !is.null(x$bb$x)) {
    bb <- x$bb
  }
  if (is.null(bb$x)) stop("Input does not contain a table matrix in $x.")
  
  X <- bb$x
  sites <- colnames(X)
  
  ## Validate metadata
  if (!is.data.frame(site_metadata)) stop("`site_metadata` must be a data.frame.")
  if (!id_col %in% names(site_metadata)) stop("`site_metadata` must contain column: ", id_col)
  if (!attr %in% names(site_metadata)) stop("`site_metadata` does not contain attribute column: ", attr)
  
  ## Match metadata rows to current site order
  md <- site_metadata
  md[[id_col]] <- as.character(md[[id_col]])
  
  idx <- match(sites, md[[id_col]])
  if (anyNA(idx)) {
    missing <- sites[is.na(idx)]
    stop("Some site IDs are missing from site_metadata: ", paste(missing, collapse = ", "))
  }
  md2 <- md[idx, , drop = FALSE]
  
  ## Build display data.frame:
  ## First row = attribute values as character
  attr_vals <- md2[[attr]]
  attr_vals <- as.character(attr_vals)
  
  df <- as.data.frame(X, stringsAsFactors = FALSE)
  
  ## Blank zeros in species rows (keep numeric for future color overlays if needed)
  ## Here we convert species rows to character for display simplicity, but we can also
  ## keep numeric and format; for now, keep it consistent with your current output.
  if (isTRUE(blank_zeros)) {
    df[] <- lapply(df, function(v) {
      v <- as.numeric(v)
      ifelse(v == 0, "", as.character(v))
    })
  } else {
    df[] <- lapply(df, as.character)
  }
  
  ## Prepend attribute row
  disp <- rbind(setNames(as.list(attr_vals), sites), df)
  rownames(disp) <- c(if (!is.null(attr_label)) attr_label else attr, rownames(df))
  
  ## Render
  gt_tbl <- gt::gt(disp, rownames_to_stub = TRUE)
  
  if (!is.null(title) || !is.null(subtitle)) {
    gt_tbl <- gt_tbl |>
      gt::tab_header(title = if (!is.null(title)) title else "", subtitle = subtitle)
  }
  
  gt_tbl |>
    gt::tab_options(table.font.size = gt::px(font_px))
}
