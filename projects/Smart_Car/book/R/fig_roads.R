## fig_roads.R -- ONE instrument, two questions, one shared axis.
##
## THE FORM IS THE ARGUMENT. Both panels are gross mph on the SAME x scale, so the
## reader runs one eye down one axis: the top panel separates cleanly and the
## bottom panel does not. Two charts on different scales would let the comparison
## off the hook; sharing the axis is what makes the null visible.
##
## ONE HUE ONLY (#2a78d6, dataviz categorical slot 1, the same slot fig_dwell uses
## so the book reads as a system; validated light-mode -- lightness, chroma and
## contrast all PASS). The bottom panel deliberately does NOT colour its two
## groups differently: identity is carried by ROW POSITION and a direct label,
## because two hues would assert a distinction the data cannot make.
##
## Leg counts ride in the y labels. Three trips rest on one or two legs and a
## reader is entitled to see that without hunting for it.

fig_roads <- function(R) {
  FILL <- "#2a78d6"
  INK  <- list(secondary = "#52514e", muted = "#898781", grid = "#e1e0d9",
               surface = "#ffffff")
  XLIM <- c(21, 62)

  pretty_trip <- function(x) {
    x <- sub("_", " ", x)
    x <- gsub("([a-z])([A-Z])", "\\1 \\2", x)
    sub("LAExpedition", "LA Expedition", x)
  }
  tr <- R$trips
  tr$row <- sprintf("%s  (%d leg%s)", pretty_trip(tr$trip), tr$n,
                    ifelse(tr$n == 1, "", "s"))
  tr$row <- factor(tr$row, levels = tr$row)          ## already sorted ascending
  ends <- tr[c(1, nrow(tr)), ]

  gp <- R$groups
  gp$row <- factor(gp$group, levels = c("Appalachia", "Deep South"))
  med <- data.frame(
    row = factor(c("Deep South", "Appalachia"), levels = c("Appalachia", "Deep South")),
    x   = c(R$med_south, R$med_appal),
    n   = c(R$n_south, R$n_appal))
  med$lab <- sprintf("median %.1f, n = %d", med$x, med$n)

  base <- function(p) p +
    ggplot2::scale_x_continuous(limits = XLIM, breaks = seq(25, 60, 5),
                                expand = c(0, 0)) +
    ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(
      panel.grid.minor   = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_line(colour = INK$grid, linewidth = 0.3),
      axis.text          = ggplot2::element_text(colour = INK$muted),
      axis.text.y        = ggplot2::element_text(colour = INK$secondary, hjust = 0),
      axis.title         = ggplot2::element_text(colour = INK$secondary, size = 9),
      plot.title         = ggplot2::element_text(colour = INK$secondary, size = 9,
                            face = "plain", hjust = 0,
                            margin = ggplot2::margin(b = 6)),
      plot.title.position = "plot",
      plot.background    = ggplot2::element_rect(fill = INK$surface, colour = NA),
      panel.background   = ggplot2::element_rect(fill = INK$surface, colour = NA),
      plot.margin        = ggplot2::margin(6, 18, 4, 6))

  top <- base(
    ggplot2::ggplot(tr) +
      ggplot2::geom_segment(ggplot2::aes(x = XLIM[1], xend = median_mph,
                                         y = row, yend = row),
                            colour = INK$grid, linewidth = 0.5) +
      ggplot2::geom_point(ggplot2::aes(median_mph, row), colour = FILL,
                          size = 3, stroke = 0) +
      ggplot2::geom_text(data = ends,
        ggplot2::aes(median_mph, row, label = sprintf("%.1f", median_mph)),
        hjust = -0.5, size = 2.7, colour = INK$secondary) +
      ggplot2::labs(title = "How the road was BUILT: the median day of each trip",
                    x = NULL, y = NULL)) +
    ggplot2::theme(axis.text.x = ggplot2::element_blank())

  bot <- base(
    ggplot2::ggplot(gp) +
      ggplot2::geom_point(ggplot2::aes(gross_mph, row), colour = FILL, fill = FILL,
                          shape = 21, size = 3, stroke = 0.75, alpha = 0.85) +
      ggplot2::geom_point(data = med, ggplot2::aes(x, row), shape = 124,
                          size = 6, colour = INK$secondary) +
      ggplot2::geom_text(data = med, ggplot2::aes(x, row, label = lab),
                         vjust = -1.9, hjust = 0.5, size = 2.6, colour = INK$muted) +
      ggplot2::scale_y_discrete(expand = ggplot2::expansion(add = c(0.6, 0.95))) +
      ggplot2::labs(
        title = sprintf(paste("What the road was LIKE: every leg in two kinds of",
                              "country, and the same instrument cannot separate",
                              "them (p = %s)"), format(R$p)),
        x = "gross speed for the whole day, stops and all (mph)", y = NULL))

  patchwork::wrap_plots(top, bot, ncol = 1, heights = c(nrow(tr), 3.6))
}
