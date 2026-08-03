#' Pairwise dissimilarities from a two-way table
#'
#' Compute pairwise dissimilarities between items (default) or between sites from
#' a binary two-way table. The default `"binary"` distance is the Jaccard
#' measure: `0` for identical lists, `1` for nothing in common.
#'
#' @param data_2way A two-way table from [data_to_2way()].
#' @param what Compute distances among `"item"`s (default) or `"site"`s.
#' @param method A distance method passed to [stats::dist()]; defaults to
#'   `"binary"` (Jaccard).
#' @return A [stats::dist] object.
#' @examples
#' tw <- data_to_2way(read_lists("S1, a, b\nS2, b, c\nS3, a, b"))
#' dissimilarity(tw, what = "site")
#' @export
dissimilarity <- function(data_2way, what = c("item", "site"), method = "binary") {
  what <- match.arg(what)
  m <- as.matrix(data_2way[, -1, drop = FALSE])
  rownames(m) <- data_2way$Item
  if (what == "site") m <- t(m)
  d <- stats::dist(m, method = method)
  d[is.na(d)] <- 0
  d
}

#' Draw a dissimilarity matrix as a heatmap
#'
#' @param d A dissimilarity object from [dissimilarity()].
#' @param caption Optional plot caption.
#' @return A ggplot tile heatmap, paler where two things are more alike, with the
#'   values printed in the cells.
#' @examples
#' tw <- data_to_2way(read_lists("S1, a, b\nS2, b, c\nS3, a, b"))
#' dissimilarity_plot(dissimilarity(tw, what = "site"))
#' @export
dissimilarity_plot <- function(d, caption = NULL) {
  long <- as.data.frame(as.table(as.matrix(d)))
  ggplot2::ggplot(long, ggplot2::aes(.data$Var2, forcats::fct_rev(.data$Var1),
                                     fill = .data$Freq)) +
    ggplot2::geom_tile(color = "gray70") +
    ggplot2::geom_text(ggplot2::aes(label = round(.data$Freq, 2)), size = 2.8) +
    ggplot2::scale_fill_gradient(low = "white", high = "darkgoldenrod2",
                                 guide = "none") +
    ggplot2::coord_equal() +
    ggplot2::labs(x = NULL, y = NULL, caption = caption) +
    ggplot2::theme_minimal() +
    ggplot2::theme(panel.grid = ggplot2::element_blank())
}
