#' Read a ragged list into a wide table
#'
#' Read ragged `"Site, item, item, ..."` text -- one site per line, any number
#' of items per line -- into a wide data frame. Whitespace around every field is
#' stripped at read time, so leading spaces after commas do no harm.
#'
#' @param data_rows A single character string: one site per line, fields
#'   separated by commas, the first field on each line the site name.
#' @return A data frame with a `Site` column and `item1` .. `itemN` columns,
#'   ragged lines padded with empty strings.
#' @examples
#' read_lists("Stall1, Crab, Clams\nStall2, Clams, Tuna, Crab")
#' @export
read_lists <- function(data_rows) {
  d <- utils::read.table(header = FALSE, sep = ",", fill = TRUE,
                         stringsAsFactors = FALSE, text = data_rows)
  d[] <- lapply(d, trimws)
  colnames(d) <- c("Site", paste0("item", seq_len(ncol(d) - 1)))
  d
}

#' Tidy a wide list into long form
#'
#' Turn the wide frame from [read_lists()] into tidy long form, one row per
#' item-in-a-site, dropping the empty cells left by ragged lines.
#'
#' @param data A wide list frame from [read_lists()].
#' @return A tibble with columns `Site` and `Item`.
#' @examples
#' to_long(read_lists("S1, a, b\nS2, b"))
#' @export
to_long <- function(data) {
  data |>
    tidyr::pivot_longer(cols = -tidyselect::all_of("Site"), values_to = "Item") |>
    dplyr::filter(.data$Item != "")
}

#' The distinct items in a list
#'
#' @param data A wide list frame from [read_lists()].
#' @return A one-column tibble of the distinct items, sorted -- a quick
#'   confirmation that the list read in as intended.
#' @examples
#' item_list(read_lists("S1, a, b\nS2, b, c"))
#' @export
item_list <- function(data) {
  to_long(data) |> dplyr::distinct(.data$Item) |> dplyr::arrange(.data$Item)
}

#' Build the binary two-way table
#'
#' Pivot a list into the binary two-way table at the centre of the analysis:
#' items as rows, sites as columns, `1` for present and `0` for absent.
#'
#' @param data A wide list frame from [read_lists()].
#' @return A tibble with an `Item` column followed by one column per site.
#' @examples
#' data_to_2way(read_lists("S1, a, b\nS2, b, c"))
#' @export
data_to_2way <- function(data) {
  to_long(data) |>
    dplyr::mutate(present = 1) |>
    dplyr::select("Site", "Item", "present") |>
    tidyr::pivot_wider(names_from = "Site", values_from = "present",
                       values_fill = 0) |>
    dplyr::arrange(.data$Item)
}
