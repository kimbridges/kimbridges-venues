## fig_cost.R -- one measurement, two questions, and only one of them answers.
##
## SAME GRAMMAR AS fig_roads: a shared y axis (mpg) across two panels, so the eye
## compares a real slope against a flat one instead of taking my word for it.
## LEFT: economy against how far the tank was driven -- the effect that exists.
## RIGHT: economy against the odometer, i.e. against the age of the car -- the
## effect everybody expects and the data does not show.
##
## ONE HUE (#2a78d6, the slot the other figures use). No colour split: there is
## one series here, and the second panel is the same series asked a second question.

fig_cost <- function(K) {
  FILL <- "#2a78d6"
  INK  <- list(secondary = "#52514e", muted = "#898781", grid = "#e1e0d9",
               surface = "#ffffff")
  d <- K$tw

  p1 <- ggplot2::ggplot(d, ggplot2::aes(leg_miles, mpg)) +
    ggplot2::geom_point(colour = FILL, size = 1.6, stroke = 0, alpha = 0.55) +
    ggplot2::geom_smooth(method = "lm", formula = y ~ x, se = TRUE,
                         colour = INK$secondary, fill = INK$grid, linewidth = 0.6) +
    ggplot2::labs(title = sprintf("how far the tank was driven: +%.2f mpg per 100 miles",
                                  K$len_per100),
                  x = "miles on the tank", y = "miles per gallon")

  p2 <- ggplot2::ggplot(d, ggplot2::aes(Odometer / 1000, mpg)) +
    ggplot2::geom_point(colour = FILL, size = 1.6, stroke = 0, alpha = 0.55) +
    ggplot2::geom_smooth(method = "lm", formula = y ~ x, se = TRUE,
                         colour = INK$secondary, fill = INK$grid, linewidth = 0.6) +
    ggplot2::labs(title = sprintf("the age of the car: %+.2f mpg per 10,000 miles, p = %.2f",
                                  K$age_per10k, K$age_p),
                  x = "odometer (thousands of miles)", y = NULL)

  th <- ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(colour = INK$grid, linewidth = 0.3),
      axis.text  = ggplot2::element_text(colour = INK$muted),
      axis.title = ggplot2::element_text(colour = INK$secondary, size = 9),
      plot.title = ggplot2::element_text(colour = INK$secondary, size = 9, hjust = 0,
                                         margin = ggplot2::margin(b = 6)),
      plot.title.position = "plot",
      plot.background  = ggplot2::element_rect(fill = INK$surface, colour = NA),
      panel.background = ggplot2::element_rect(fill = INK$surface, colour = NA),
      plot.margin = ggplot2::margin(6, 14, 4, 6))

  patchwork::wrap_plots(p1 + th, p2 + th, nrow = 1)
}
