## fig_day.R -- what the days with something in them were made of.
##
## FORM: one horizontal bar per commented leg, elapsed time split into driving and
## stopped, ordered by stopped time, with Kim's own words printed at the end of the
## bar. The comment is the label because the comment IS the finding: a free-text
## column nobody was required to fill turns out to mark the days that were not
## only driving.
##
## COLOUR: the hue (#2a78d6, the book's slot) carries STOPPED time, which is the
## quantity in question; driving time is a recessive neutral, so the eye reads the
## blue as the subject rather than as one of two competing series. Legend present
## because there are two segments. 2px surface gap between them per the mark spec.

fig_day <- function(D) {
  FILL <- "#2a78d6"
  INK  <- list(secondary = "#52514e", muted = "#898781", grid = "#e1e0d9",
               surface = "#ffffff", quiet = "#d6d9de")
  d <- D$bars
  d$lab <- factor(seq_len(nrow(d)))
  long <- rbind(
    data.frame(lab = d$lab, part = "driving", hours = d$drive_h),
    data.frame(lab = d$lab, part = "stopped", hours = d$stop_hours))
  long$part <- factor(long$part, levels = c("driving", "stopped"))

  txt <- data.frame(lab = d$lab, x = d$raw_hours + 0.25, t = d$comment)

  ggplot2::ggplot() +
    ggplot2::geom_col(data = long, ggplot2::aes(hours, lab, fill = part),
                      width = 0.68, colour = INK$surface, linewidth = 0.5) +
    ggplot2::geom_text(data = txt, ggplot2::aes(x, lab, label = t),
                       hjust = 0, size = 2.5, colour = INK$secondary) +
    ggplot2::scale_fill_manual(values = c(driving = INK$quiet, stopped = FILL),
                               name = NULL) +
    ggplot2::scale_x_continuous(limits = c(0, 21), breaks = seq(0, 12, 3),
                                expand = c(0, 0)) +
    ggplot2::scale_y_discrete(breaks = NULL, expand = ggplot2::expansion(add = 0.6)) +
    ggplot2::labs(x = "hours from leaving to arriving", y = NULL) +
    ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(
      legend.position = "top", legend.justification = "left",
      legend.margin = ggplot2::margin(b = -4), legend.key.size = ggplot2::unit(9, "pt"),
      legend.text = ggplot2::element_text(colour = INK$secondary, size = 8),
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_line(colour = INK$grid, linewidth = 0.3),
      axis.text = ggplot2::element_text(colour = INK$muted),
      axis.title = ggplot2::element_text(colour = INK$secondary, size = 9),
      plot.background = ggplot2::element_rect(fill = INK$surface, colour = NA),
      panel.background = ggplot2::element_rect(fill = INK$surface, colour = NA),
      plot.margin = ggplot2::margin(6, 10, 4, 6))
}
