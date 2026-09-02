## fig_audit.R -- what an audit actually looks like.
##
## FORM: one point per fill, residual on a LOG axis, because the interesting
## structure spans three orders of magnitude and a linear axis buries the wall of
## rounding noise against the origin. The shaded band is the DERIVED tolerance,
## not a chosen threshold -- and the point of the figure is the EMPTY SPACE just
## to the right of it. Nothing sits in the doubtful zone.
##
## ONE HUE (#2a78d6, the slot fig_dwell and fig_roads use), with failures shown by
## an open ring rather than a second colour: they are the same measurement, not a
## second series.

fig_audit <- function(A) {
  FILL <- "#2a78d6"
  INK  <- list(secondary = "#52514e", muted = "#898781", grid = "#e1e0d9",
               surface = "#ffffff", band = "#eef3fa")
  d <- A$strip
  d$resid_c <- 100 * pmax(d$resid, 0.0004)   ## floor so exact zeros stay on a log axis
  d$car <- factor(d$car, levels = c("Creamsicle", "TwoRed"))
  set.seed(4)
  d$y <- as.integer(d$car) + runif(nrow(d), -0.28, 0.28)

  lab <- data.frame(
    car = factor(c("TwoRed", "Creamsicle"), levels = levels(d$car)),
    x = 0.05,
    txt = c(sprintf("TwoRed  %d fills, %d outside", A$tw_n, A$tw_bad),
            sprintf("Creamsicle  %d US fills, %d outside", A$cr_n, A$cr_bad)))
  lab$y <- as.integer(lab$car) + 0.42

  ggplot2::ggplot() +
    ggplot2::annotate("rect", xmin = 0.04, xmax = 100 * A$bound_med,
                      ymin = 0.5, ymax = 2.5, fill = INK$band) +
    ggplot2::annotate("text", x = 100 * A$bound_med * 0.93, y = 0.63,
                      label = "arithmetic: inside the precision the pump prints  ",
                      hjust = 1, size = 2.6, colour = INK$muted) +
    ggplot2::geom_point(data = d[!d$fails, ], ggplot2::aes(resid_c, y),
                        colour = FILL, size = 1.9, stroke = 0, alpha = 0.7) +
    ggplot2::geom_point(data = d[d$fails, ], ggplot2::aes(resid_c, y),
                        shape = 21, colour = FILL, fill = INK$surface,
                        size = 2.8, stroke = 0.9) +
    ggplot2::geom_text(data = lab, ggplot2::aes(x, y, label = txt),
                       hjust = 0, size = 2.9, colour = INK$secondary) +
    ggplot2::scale_x_log10(
      breaks = c(0.05, 0.1, 0.5, 1, 5, 10, 50, 100, 200),
      labels = c("0.05", "0.1", "0.5", "1", "5", "10", "50", "100", "200"),
      limits = c(0.04, 300), expand = c(0, 0)) +
    ggplot2::scale_y_continuous(limits = c(0.5, 2.7), breaks = NULL, expand = c(0, 0)) +
    ggplot2::labs(x = "how far the row misses gallons × price per gallon = cost (cents)",
                  y = NULL) +
    ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_line(colour = INK$grid, linewidth = 0.3),
      axis.text = ggplot2::element_text(colour = INK$muted),
      axis.title = ggplot2::element_text(colour = INK$secondary, size = 9),
      plot.background = ggplot2::element_rect(fill = INK$surface, colour = NA),
      panel.background = ggplot2::element_rect(fill = INK$surface, colour = NA),
      plot.margin = ggplot2::margin(8, 16, 6, 6))
}
