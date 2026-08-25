## fig_regimes.R -- every interval and every trip, both cars, on one log-log field.
## The diagonals are constant miles-per-day, so a regime is a BAND, not a threshold.
## Palette: dataviz categorical slots 1 and 2, validated all-pairs on white
## (CVD dE 24.7, normal-vision 33.6, both >= 3:1 contrast).

fig_regimes <- function(dat) {
  stopifnot(all(c("car","kind","days","miles") %in% names(dat)))
  PAL <- c("Between trips" = "#2a78d6", "On a trip" = "#eb6834")
  INK <- list(secondary = "#52514e", muted = "#898781", grid = "#e1e0d9",
              surface = "#ffffff")
  d <- dat[is.finite(dat$days) & is.finite(dat$miles) & dat$days > 0 & dat$miles > 0, ]
  d$kind <- factor(ifelse(d$kind == "trip", "On a trip", "Between trips"),
                   levels = names(PAL))
  d$car  <- factor(d$car, levels = c("TwoRed", "Creamsicle"))

  xr <- c(0.9, 620); yr <- c(45, 17000)
  iso <- data.frame(rate = c(1, 10, 100),
                    lab  = c("1 mile a day", "10 miles a day", "100 miles a day"),
                    x    = c(520, 520, 130))
  iso$y <- iso$rate * iso$x
  ann <- data.frame(days  = c(414, 90, 289),
                    miles = c(2174, 1646, 5408),
                    txt   = c("414 days in California", "Wisconsin", "unlogged crossing"))
  set.seed(7)

  ggplot2::ggplot(d, ggplot2::aes(days, miles)) +
    lapply(iso$rate, function(r)
      ggplot2::geom_function(fun = function(x) r * x,
                             colour = INK$grid, linewidth = 0.35)) +
    ggplot2::geom_text(data = iso,
      ggplot2::aes(x = x, y = y, label = lab), inherit.aes = FALSE,
      hjust = 1, vjust = -0.55, size = 2.7, colour = INK$muted) +
    ggplot2::geom_point(ggplot2::aes(fill = kind, shape = car),
      size = 2.9, stroke = 0.6, colour = "white") +
    ggrepel::geom_text_repel(data = ann,
      ggplot2::aes(x = days, y = miles, label = txt), inherit.aes = FALSE,
      size = 2.7, colour = INK$secondary, segment.colour = INK$muted,
      segment.size = 0.3, box.padding = 0.9, point.padding = 0.45,
      min.segment.length = 0, max.overlaps = Inf, seed = 7,
      nudge_x = c(-0.30, -0.28, -0.45), nudge_y = c(-0.28, -0.30, 0.22)) +
    ggplot2::scale_fill_manual(values = PAL, name = NULL) +
    ggplot2::scale_shape_manual(values = c(TwoRed = 21, Creamsicle = 24), name = NULL) +
    ggplot2::scale_x_log10(limits = xr, breaks = c(1, 3, 10, 30, 100, 300),
                           labels = c("1","3","10","30","100","300"), expand = c(0, 0)) +
    ggplot2::scale_y_log10(limits = yr, breaks = c(100, 300, 1000, 3000, 10000),
                           labels = c("100","300","1,000","3,000","10,000"), expand = c(0, 0)) +
    ggplot2::labs(x = "days", y = "miles") +
    ggplot2::guides(
      fill  = ggplot2::guide_legend(order = 1, override.aes = list(shape = 21, size = 3.2)),
      shape = ggplot2::guide_legend(order = 2, override.aes = list(fill = INK$muted, size = 3.2))) +
    ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(colour = INK$grid, linewidth = 0.3),
      axis.text  = ggplot2::element_text(colour = INK$muted),
      axis.title = ggplot2::element_text(colour = INK$secondary, size = 9),
      legend.position = "top", legend.justification = "left",
      legend.box = "horizontal",
      legend.text = ggplot2::element_text(colour = INK$secondary, size = 9),
      legend.key.size = ggplot2::unit(10, "pt"),
      legend.margin = ggplot2::margin(b = 2),
      plot.background  = ggplot2::element_rect(fill = INK$surface, colour = NA),
      panel.background = ggplot2::element_rect(fill = INK$surface, colour = NA),
      plot.margin = ggplot2::margin(6, 16, 6, 6))
}
