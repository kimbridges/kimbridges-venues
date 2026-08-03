#' Extract the differential table for display
#'
#' Pulls the display-ready differential table out of a sorted [coenos_table()]:
#' the grouped species, the relevés they characterise, and a group label for
#' each species. This is the *preparation* step behind a printed Braun-Blanquet
#' table -- it does the row and column selection so you do not have to, and
#' returns a plain data frame you can render with any table tool.
#'
#' @details
#' By default (`include = "core"`) the result holds only the species that fell
#' into a differential group and only the relevés that belong to at least one
#' group -- the differential core, the part of the table that carries the
#' pattern. With `include = "full"` every species and relevé is returned in
#' sorted order, the ungrouped species labelled `"companion"` or `"rare"`.
#'
#' Columns are a `group` label, the `species`, and then the relevés in sorted
#' order. Absent cells are empty strings. The relevé columns keep their full
#' names; see [coenos_gt()] to render them with shortened headers.
#'
#' @param x A `coenos_table` from [coenos_table()], or a `coenos_groups` object
#'   from [form_groups()] (which is arranged first).
#' @param include `"core"` (default) for the grouped species and their relevés,
#'   or `"full"` for the whole sorted table.
#'
#' @return A data frame with columns `group`, `species`, and one column per
#'   relevé, in sorted order.
#'
#' @seealso [coenos_table()], [coenos_gt()]
#'
#' @examples
#' rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
#' differential_table(form_groups(rel))
#'
#' @export
differential_table <- function(x, include = c("core", "full")) {
  include <- match.arg(include)
  if (inherits(x, "coenos_groups")) x <- coenos_table(x)
  if (!inherits(x, "coenos_table")) {
    stop("`x` must be a coenos_table or coenos_groups object.", call. = FALSE)
  }

  block <- attr(x, "block")
  releve_order <- attr(x, "releve_order")
  groups <- attr(x, "groups")
  label <- ifelse(block %in% c("companion", "rare"), block, paste("Group", block))

  if (include == "core") {
    keep_row <- !block %in% c("companion", "rare")
    in_group <- unique(unlist(lapply(groups, `[[`, "releves")))
    keep_col <- releve_order[releve_order %in% in_group]
  } else {
    keep_row <- rep(TRUE, nrow(x))
    keep_col <- releve_order
  }

  out <- data.frame(
    group = label[keep_row],
    species = x$species[keep_row],
    x[keep_row, keep_col, drop = FALSE],
    check.names = FALSE, stringsAsFactors = FALSE
  )
  rownames(out) <- NULL
  out
}

#' Render a differential table with gt
#'
#' A one-call convenience that turns a sorted [coenos_table()] into a formatted
#' \pkg{gt} table -- the differential species groups across their relevés, with
#' the groups as labelled row sections. It is a thin wrapper over
#' [differential_table()] for people who want the publication-ready table
#' without writing the rendering code.
#'
#' @details
#' Requires the \pkg{gt} package (in Suggests). Relevé headers are shortened by
#' default -- a leading non-numeric prefix and its zeros are dropped, so
#' `"BILL04"` shows as `"4"` -- unless that would make two headers collide, in
#' which case the full names are kept.
#'
#' @param x A `coenos_table` from [coenos_table()], or a `coenos_groups` object
#'   from [form_groups()].
#' @param include Passed to [differential_table()]: `"core"` (default) or
#'   `"full"`.
#' @param shorten Logical; shorten the relevé headers for display. Default
#'   `TRUE`.
#' @param title,subtitle Optional table header text. `NULL` for none.
#'
#' @return A `gt_tbl` object.
#'
#' @seealso [differential_table()], [coenos_table()]
#'
#' @examples
#' \dontrun{
#' rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
#' coenos_gt(form_groups(rel))
#' }
#'
#' @export
coenos_gt <- function(x, include = c("core", "full"), shorten = TRUE,
                      title = NULL, subtitle = NULL) {
  if (!requireNamespace("gt", quietly = TRUE)) {
    stop("coenos_gt() needs the 'gt' package; install it with install.packages(\"gt\").",
         call. = FALSE)
  }
  d <- differential_table(x, include = match.arg(include))
  releves <- setdiff(names(d), c("group", "species"))

  g <- gt::gt(d, rowname_col = "species", groupname_col = "group")
  if (!is.null(title)) {
    g <- gt::tab_header(g, title = title, subtitle = subtitle)
  }
  if (isTRUE(shorten)) {
    short <- sub("^[A-Za-z]+0*", "", releves)
    if (!any(duplicated(short)) && !any(short == "")) {
      g <- gt::cols_label(g, .list = stats::setNames(as.list(short), releves))
    }
  }
  gt::tab_options(g, table.font.size = gt::px(11), data_row.padding = gt::px(2))
}
