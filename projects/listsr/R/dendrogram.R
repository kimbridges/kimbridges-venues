#' Shared ggplot theme for dendrograms
#'
#' @return A [ggplot2::theme()] object: clean leaf axis, lightly gridded
#'   dissimilarity axis, pale panel.
#' @export
dendro_theme <- function() {
  ggplot2::theme(
    axis.title.y = ggplot2::element_blank(),
    axis.text.y  = ggplot2::element_blank(),
    axis.ticks.y = ggplot2::element_blank(),
    panel.grid.major.y = ggplot2::element_blank(),
    panel.grid.minor.y = ggplot2::element_blank(),
    panel.grid.major.x = ggplot2::element_line(linewidth = .3, color = "gray75"),
    panel.grid.minor.x = ggplot2::element_line(linewidth = .3, color = "gray75"),
    panel.background   = ggplot2::element_rect(fill = "lightsteelblue1", color = "black"))
}

#' Draw a dendrogram from a dissimilarity object
#'
#' @param d A dissimilarity object from [dissimilarity()].
#' @param linkage The agglomeration method passed to [stats::hclust()];
#'   defaults to `"average"` (UPGMA).
#' @param caption Optional plot caption.
#' @return A ggplot dendrogram (dissimilarity on the horizontal axis).
#' @examples
#' tw <- data_to_2way(read_lists("S1, a, b\nS2, b, c\nS3, a, b"))
#' dendrogram_plot(dissimilarity(tw, what = "site"))
#' @export
dendrogram_plot <- function(d, linkage = "average", caption = NULL) {
  hc  <- stats::hclust(d, method = linkage)
  hcd <- ggdendro::dendro_data(hc, type = "rectangle")
  ggplot2::ggplot() +
    ggplot2::geom_segment(data = ggdendro::segment(hcd),
                          ggplot2::aes(x, y, xend = xend, yend = yend)) +
    ggplot2::geom_text(data = ggdendro::label(hcd),
                       ggplot2::aes(x, y, label = label, hjust = 0), size = 3) +
    ggplot2::coord_flip() +
    ggplot2::scale_y_reverse(expand = c(0.2, 0)) +
    ggplot2::labs(y = "dissimilarity", caption = caption) +
    dendro_theme()
}

#' Two-way table to tree in one call
#'
#' Convenience wrapper chaining [dissimilarity()] into [dendrogram_plot()].
#'
#' @param data_2way A two-way table from [data_to_2way()].
#' @param what Cluster `"item"`s (default) or `"site"`s.
#' @param dist_method Distance method for [dissimilarity()]; default `"binary"`.
#' @param linkage Linkage for [dendrogram_plot()]; default `"average"`.
#' @param caption Optional plot caption.
#' @return A ggplot dendrogram.
#' @examples
#' make_dendrogram(data_to_2way(read_lists("S1, a, b\nS2, b, c\nS3, a, b")),
#'                 what = "site")
#' @export
make_dendrogram <- function(data_2way, what = c("item", "site"),
                            dist_method = "binary", linkage = "average",
                            caption = NULL) {
  dendrogram_plot(dissimilarity(data_2way, what, dist_method), linkage, caption)
}

#' Dendrogram with leaves coloured by external metadata
#'
#' Draw a dendrogram whose leaves are coloured by a column held in a *separate*
#' metadata table -- the move that lets a grouping be corroborated by, or
#' contrasted against, facts the analysis never saw.
#'
#' @param d A dissimilarity object from [dissimilarity()].
#' @param info A data frame of metadata; one column matches the leaf labels.
#' @param by Name of the column in `info` that matches the leaf labels.
#' @param key Name of the metadata column to colour by.
#' @param linkage Linkage passed to [stats::hclust()]; default `"average"`.
#' @param extra Optional column in `info` printed in parentheses after each label.
#' @param palette Optional named colour vector for the `key` values.
#' @param caption Optional plot caption.
#' @return A ggplot dendrogram with a colour legend.
#' @examples
#' tw  <- data_to_2way(read_lists("S1, a, b\nS2, b, c\nS3, a, b"))
#' inf <- data.frame(Site = c("S1", "S2", "S3"),
#'                   kind = c("x", "y", "x"))
#' dendrogram_meta_plot(dissimilarity(tw, what = "site"),
#'                      info = inf, by = "Site", key = "kind")
#' @export
dendrogram_meta_plot <- function(d, info, by, key, linkage = "average",
                                 extra = NULL, palette = NULL, caption = NULL) {
  hc   <- stats::hclust(d, method = linkage)
  hcd  <- ggdendro::dendro_data(hc, type = "rectangle")
  labs <- dplyr::left_join(ggdendro::label(hcd), info,
                           by = stats::setNames(by, "label"))
  labs$txt <- if (is.null(extra)) paste0("  ", labs$label) else
    paste0("  ", labs$label, " (", labs[[extra]], ")")
  g <- ggplot2::ggplot() +
    ggplot2::geom_segment(data = ggdendro::segment(hcd),
                          ggplot2::aes(x, y, xend = xend, yend = yend)) +
    ggplot2::geom_point(data = labs,
                        ggplot2::aes(x, y, color = .data[[key]]), size = 2.6) +
    ggplot2::geom_text(data = labs,
                       ggplot2::aes(x, y, label = txt, color = .data[[key]]),
                       hjust = 0, size = 3.2, fontface = "bold", show.legend = FALSE) +
    ggplot2::coord_flip() +
    ggplot2::scale_y_reverse(expand = c(0.35, 0)) +
    ggplot2::labs(y = "dissimilarity", color = key, caption = caption) +
    dendro_theme() +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::guides(color = ggplot2::guide_legend(override.aes = list(size = 4)))
  if (!is.null(palette)) g <- g + ggplot2::scale_color_manual(values = palette)
  g
}
