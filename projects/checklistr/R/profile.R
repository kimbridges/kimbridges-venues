#' Summarise collectors
#'
#' One row per primary collector: number of specimens, distinct taxa, first/last
#' year, active span, and the herbaria that hold their material.
#'
#' @param df A specimen data frame with a `collector` column (from
#'   [add_primary_collector()]).
#' @return A tibble ordered by specimen count.
#' @export
collector_profile <- function(df) {
  df %>% dplyr::filter(!is.na(collector)) %>%
    dplyr::group_by(collector) %>%
    dplyr::summarise(
      specimens = dplyr::n(),
      taxa      = dplyr::n_distinct(species, na.rm = TRUE),
      first     = min(year, na.rm = TRUE),
      last      = max(year, na.rm = TRUE),
      span_yrs  = last - first,
      institutions = paste(sort(unique(institutionCode)), collapse = ","),
      .groups = "drop") %>%
    dplyr::arrange(dplyr::desc(specimens))
}

#' Plot the collecting history (specimens per year)
#'
#' A yearly histogram of specimens, with the top collectors highlighted.
#'
#' @param df A specimen data frame with `collector` and `year`.
#' @param n_top Number of top collectors to colour individually.
#' @param place Place name for the title.
#' @return A ggplot object.
#' @export
plot_collecting_history <- function(df, n_top = 6, place = "") {
  prof <- collector_profile(df)
  top  <- prof %>% dplyr::slice_max(specimens, n = n_top) %>% dplyr::pull(collector)
  yr <- df %>% dplyr::filter(!is.na(year)) %>%
    dplyr::mutate(grp = ifelse(collector %in% top, collector, "other collectors"))
  ggplot2::ggplot(yr, ggplot2::aes(year, fill = forcats::fct_relevel(factor(grp), "other collectors", after = Inf))) +
    ggplot2::geom_histogram(binwidth = 1, color = "grey20", linewidth = 0.1) +
    ggplot2::scale_x_continuous(breaks = seq(1900, 2030, 10)) +
    ggplot2::scale_fill_brewer(palette = "Set2", name = "primary collector") +
    ggplot2::labs(title = paste(place, "- herbarium collecting history"),
                  subtitle = paste(nrow(df), "preserved specimens"),
                  x = NULL, y = "specimens collected") +
    ggplot2::theme_minimal(base_size = 12) +
    ggplot2::theme(panel.grid.minor = ggplot2::element_blank(), legend.position = "bottom")
}

#' Plot collector activity (who collected, when, how much)
#'
#' Each collector's active span as a segment, with points sized by specimens and
#' coloured by distinct taxa.
#'
#' @param df A specimen data frame with `collector` and `year`.
#' @param min_specimens Minimum specimens for a collector to be shown.
#' @param place Place name for the title.
#' @return A ggplot object.
#' @export
plot_collector_activity <- function(df, min_specimens = 2, place = "") {
  p <- collector_profile(df) %>% dplyr::filter(specimens >= min_specimens) %>%
       dplyr::mutate(collector = forcats::fct_reorder(collector, first))
  ggplot2::ggplot(p, ggplot2::aes(y = collector)) +
    ggplot2::geom_segment(ggplot2::aes(x = first, xend = last, yend = collector),
                          linewidth = 0.6, color = "grey60") +
    ggplot2::geom_point(ggplot2::aes(x = first, size = specimens, color = taxa)) +
    ggplot2::geom_point(ggplot2::aes(x = last,  size = specimens, color = taxa)) +
    ggplot2::scale_size_area(max_size = 9, name = "specimens") +
    ggplot2::scale_color_viridis_c(option = "C", end = 0.9, name = "distinct taxa") +
    ggplot2::scale_x_continuous(breaks = seq(1900, 2030, 10)) +
    ggplot2::labs(title = paste(place, "- who collected, and when"),
                  subtitle = "point size = specimens, color = distinct taxa", x = NULL, y = NULL) +
    ggplot2::theme_minimal(base_size = 12) +
    ggplot2::theme(panel.grid.minor = ggplot2::element_blank(),
                   panel.grid.major.y = ggplot2::element_line(linewidth = 0.2))
}
