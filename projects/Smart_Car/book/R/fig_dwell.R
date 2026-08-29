## fig_dwell.R -- where the days actually went.
##
## THE FORM IS TIME-WEIGHTED ON PURPOSE. An unweighted frequency diagram of the
## same intervals is dominated by a spike at one day (57% of all intervals) and
## the standing time -- the thing the chapter is about -- is invisible behind it.
## Counting DAYS instead of INTERVALS asks the question the chapter asks: not how
## often did the car stand, but how much of its life did it spend standing.
##
## Y IS A SHARE, not a count, because the two records are different lengths
## (TwoRed ~2,500 covered days, Creamsicle ~1,100). Shares compare; counts do not.
##
## Palette: dataviz categorical slot 1 (#2a78d6), validated on this surface
## (lightness, chroma and >= 3:1 contrast all PASS; no pairs to separate --
## one series per panel, and the car is carried by the facet strip, not by hue).
## INK tokens are the same ones fig_regimes() uses, so the two read as a system.

fig_dwell <- function(dat, break_days = 30) {
  stopifnot(all(c("car", "days") %in% names(dat)))
  FILL <- "#2a78d6"
  INK  <- list(secondary = "#52514e", muted = "#898781", grid = "#e1e0d9",
               surface = "#ffffff")

  d <- dat[is.finite(dat$days) & dat$days > 0, ]
  ## share of each car's OWN covered days, so the panels are comparable
  tot <- tapply(d$days, d$car, sum)
  d$w <- d$days / as.numeric(tot[as.character(d$car)])

  ## facet strips carry the record window, because the two are not the same length,
  ## and the headline share, so the panel says what it shows. Built by LEVEL ORDER
  ## so the cars stay in acquisition order however the rows arrive.
  cars <- levels(d$car)
  labs <- vapply(cars, function(cc) {
    z <- d[as.character(d$car) == cc, ]
    sprintf("%s   %s–%s   %s%% of its days in stretches of a month or more",
            cc, format(min(z$from), "%Y"), format(max(z$to), "%Y"),
            round(100 * sum(z$w[z$days >= break_days])))
  }, character(1))
  d$panel <- factor(labs[as.character(d$car)], levels = labs)

  brk <- 10^seq(0, log10(200), length.out = 13)
  trough <- data.frame(panel = factor(labs[[1]], levels = labs), x = 5.5, y = 0.135,
                       lab = "hardly any of the car's life\nis spent in the middle")

  ggplot2::ggplot(d, ggplot2::aes(days, weight = w)) +
    ggplot2::geom_histogram(breaks = brk, fill = FILL,
                            colour = INK$surface, linewidth = 0.45) +
    ggplot2::geom_text(data = trough, ggplot2::aes(x = x, y = y, label = lab),
      inherit.aes = FALSE, hjust = 0.5, vjust = 0.5, lineheight = 1.05,
      size = 2.6, colour = INK$muted) +
    ggplot2::scale_x_log10(
      breaks = c(1, 2, 7, 30, 90, 180),
      labels = c("1 day", "2", "a week", "a month", "3 months", "6 months"),
      limits = c(0.95, 205), expand = c(0, 0)) +
    ggplot2::scale_y_continuous(labels = function(z) paste0(round(100 * z), "%"),
                                expand = ggplot2::expansion(mult = c(0, 0.22))) +
    ggplot2::facet_wrap(~panel, ncol = 1) +
    ggplot2::labs(x = "how long the car stood between one fill and the next",
                  y = "share of the days the log covers") +
    ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_line(colour = INK$grid, linewidth = 0.3),
      axis.text  = ggplot2::element_text(colour = INK$muted),
      axis.title = ggplot2::element_text(colour = INK$secondary, size = 9),
      strip.text = ggplot2::element_text(colour = INK$secondary, size = 9,
                                         hjust = 0, margin = ggplot2::margin(b = 3)),
      panel.spacing = ggplot2::unit(14, "pt"),
      plot.background  = ggplot2::element_rect(fill = INK$surface, colour = NA),
      panel.background = ggplot2::element_rect(fill = INK$surface, colour = NA),
      plot.margin = ggplot2::margin(6, 16, 6, 6))
}
