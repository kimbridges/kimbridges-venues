#' Render a Braun-Blanquet table with color scaling and optional metadata rows
#'
#' @description
#' Creates a \pkg{gt} table from a wide Braun-Blanquet matrix (species x sites),
#' applying a compact theme-based color scale to the site columns. Optional
#' metadata rows (e.g., elevation) can be inserted above the species rows and
#' styled distinctly to emphasize gradient context.
#'
#' @param data A data frame with one stub column (species names) and one or more
#'   site columns.
#' @param stub_col Name of the stub column containing species (or row labels).
#' @param meta Optional named list of metadata rows. Each list element must be a
#'   vector with length equal to the number of site columns. Example:
#'   \code{list(elevation = c(...), aspect = c(...))}.
#' @param theme A named theme/palette identifier (e.g., \code{"sage"}) or a
#'   custom vector of colors (light to dark).
#' @param meta_bg Background color for metadata rows.
#' @param domain Numeric domain for color scaling. Default \code{NULL} uses the
#'   observed range of values in the site columns.
#' @param na_color Color used for missing/blank cells.
#' @param show_colnames Logical; if \code{FALSE}, hides the site column labels.
#'
#' @return A \code{gt_tbl} object.
#'
#' @export
#'
#' @examples
#' ## Basic example (wide table: species + site_* columns)
#' bb_gt_table(bb_ex, theme = "sage")
#'
#' ## Add a metadata row (e.g., elevation) to emphasize a gradient context
#' bb_gt_table(
#'   bb_ex,
#'   meta = list(elevation = c(50, 150, 300, 450, 650, 850)),
#'   theme = "sage"
#' )
#'
#' ## Alternative palette
#' bb_gt_table(bb_ex, theme = "mono")



## bb_gt_table() ---------------------------------------------------------------
## Render a BB table (wide) with optional metadata row(s) and a simple theme choice.

bb_gt_table <- function(data,
                        stub_col = "species",
                        meta = NULL,
                        theme = c("sage", "blue", "mono"),
                        meta_bg = "#f6f1cf",
                        domain = NULL,
                        na_color = "white",
                        show_colnames = TRUE) {
  

  theme <- match.arg(theme)

  ## Basic validation (lightweight, user-friendly)
  stopifnot(is.data.frame(data))
  stopifnot(stub_col %in% names(data))

  site_cols <- setdiff(names(data), stub_col)

  ## If metadata provided, bind rows at top (under column headers)
  ## meta should be: list(name1 = vector length = length(site_cols), name2 = ...)
  if (!is.null(meta)) {
    stopifnot(is.list(meta))
    for (nm in names(meta)) {
      v <- meta[[nm]]
      stopifnot(length(v) == length(site_cols))
    }

    meta_df <- do.call(
      rbind,
      lapply(names(meta), function(nm) {
        row <- as.list(meta[[nm]])
        names(row) <- site_cols
        c(stats::setNames(list(nm), stub_col), row)
      })
    ) |> as.data.frame(stringsAsFactors = FALSE)

    ## Coerce data to character to avoid type conflicts (common with BB tables)
    data2 <- data
    data2[site_cols] <- lapply(data2[site_cols], as.character)

    data2 <- rbind(meta_df, data2)
  } else {
    data2 <- data
  }

  ## Convert site cols to numeric where possible (for coloring), keep blanks as NA
  data3 <- data2
  data3[site_cols] <- lapply(data3[site_cols], function(x) suppressWarnings(as.numeric(x)))

  ## Theme palettes (gt wants a vector of colors)
  pal <- switch(
    theme,
    "sage" = c("#f2f5ea", "#d7e3c4", "#a9c18a", "#6f8f3f", "#3f5f1f"),
    "blue" = c("#f0f6ff", "#cfe3ff", "#97c0ff", "#4f8eea", "#1f5fbf"),
    "mono" = c("#f7f7f7", "#d9d9d9", "#bdbdbd", "#969696", "#636363")
  )
  
  ## Determine domain for color scaling
  if (is.null(domain)) {
    ## use observed range from site columns
    vals <- unlist(data3[site_cols], use.names = FALSE)
    vals <- vals[is.finite(vals)]
    domain_vec <- if (length(vals)) range(vals) else c(0, 1)
  } else {
    domain_vec <- domain
  }
  
  ## Build gt
  gt_tbl <- gt::gt(data3, rowname_col = stub_col)

  if (!show_colnames) {
    gt_tbl <- gt_tbl |> gt::tab_options(column_labels.hidden = TRUE)
  }

  ## If we added metadata rows, style them
  if (!is.null(meta)) {
    meta_rows <- names(meta)  ## these are the stub values

    gt_tbl <- gt_tbl |>
      gt::tab_style(
        style = gt::cell_fill(color = meta_bg),
        locations = gt::cells_body(
          rows = .data[[stub_col]] %in% meta_rows
        )
      ) |>
      gt::tab_style(
        style = gt::cell_text(weight = "bold"),
        locations = gt::cells_body(
          columns = stub_col,
          rows = .data[[stub_col]] %in% meta_rows
        )
      )
  }

  ## Color numeric BB scores (assumes 1–4; adjust domain if you use 0–9 etc.)
  gt_tbl <- gt_tbl |>
    gt::data_color(
      columns = gt::all_of(site_cols),
      fn = scales::col_numeric(
        palette = pal,
        domain  = domain_vec,
        na.color = na_color
      )
    ) |>
    gt::sub_missing(columns = gt::all_of(site_cols), missing_text = "")|>
    gt::cols_align(align = "center", columns = gt::all_of(site_cols)) |>
    gt::cols_align(align = "left", columns = gt::all_of(stub_col))

  gt_tbl
}
