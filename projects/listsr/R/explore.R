#' How many sites carry each item
#'
#' @param data A wide list frame from [read_lists()].
#' @param caption Optional plot caption.
#' @return A ggplot bar chart of item frequency.
#' @examples
#' item_freq_plot(read_lists("S1, a, b\nS2, b, c\nS3, b"))
#' @export
item_freq_plot <- function(data, caption = NULL) {
  to_long(data) |> dplyr::count(.data$Item) |>
    ggplot2::ggplot(ggplot2::aes(x = stats::reorder(.data$Item, .data$n), y = .data$n)) +
    ggplot2::geom_col(fill = "darkgoldenrod2", color = "black") +
    ggplot2::coord_flip() +
    ggplot2::labs(x = "item", y = "number of sites", caption = caption) +
    ggplot2::theme(panel.background =
                     ggplot2::element_rect(fill = "lightblue", color = "black"))
}

#' How many items each site holds
#'
#' @param data A wide list frame from [read_lists()].
#' @param caption Optional plot caption.
#' @return A ggplot bar chart of site richness.
#' @examples
#' site_freq_plot(read_lists("S1, a, b\nS2, b, c\nS3, b"))
#' @export
site_freq_plot <- function(data, caption = NULL) {
  to_long(data) |> dplyr::count(.data$Site) |>
    ggplot2::ggplot(ggplot2::aes(x = stats::reorder(.data$Site, .data$n), y = .data$n)) +
    ggplot2::geom_col(fill = "darkgoldenrod2", color = "black") +
    ggplot2::coord_flip() +
    ggplot2::labs(x = "site", y = "number of items", caption = caption) +
    ggplot2::theme(panel.background =
                     ggplot2::element_rect(fill = "lightblue", color = "black"))
}

#' Draw the two-way table as a presence/absence picture
#'
#' @param data_2way A two-way table from [data_to_2way()].
#' @param caption Optional plot caption.
#' @return A ggplot tile plot: filled where present, blank where absent.
#' @examples
#' two_way_plot(data_to_2way(read_lists("S1, a, b\nS2, b, c")))
#' @export
two_way_plot <- function(data_2way, caption = NULL) {
  long <- data_2way |>
    tidyr::pivot_longer(-tidyselect::all_of("Item"),
                        names_to = "Site", values_to = "present")
  ggplot2::ggplot(long, ggplot2::aes(x = .data$Site,
                                     y = forcats::fct_rev(factor(.data$Item)),
                                     fill = factor(.data$present))) +
    ggplot2::geom_tile(color = "gray70") +
    ggplot2::scale_fill_manual(values = c("0" = "white", "1" = "darkgoldenrod2"),
                               guide = "none") +
    ggplot2::coord_equal() +
    ggplot2::labs(x = NULL, y = NULL, caption = caption) +
    ggplot2::theme_minimal() +
    ggplot2::theme(panel.grid = ggplot2::element_blank())
}
