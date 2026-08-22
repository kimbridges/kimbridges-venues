## fig_fleet_timeline.R -- the fleet as spans of time, coloured by which ocean
## Requires book_setup.R (supplies `fleet`, `residency`, `mainland_gap`).
## Palette: dataviz categorical slots 1 (blue) and 2 (orange). Validated all-pairs
## on a white surface: CVD dE 24.7, normal-vision dE 33.6, both >= 3:1 contrast.

fig_fleet_timeline <- function() {
  stopifnot(exists("residency"), exists("fleet"), exists("mainland_gap"),
            exists("voyage"), exists("voyage_days"))
  PAL <- c(Mainland = "#eb6834", Hawaii = "#2a78d6")
  INK <- list(primary = "#0b0b0b", secondary = "#52514e", muted = "#898781",
              grid = "#e1e0d9", axis = "#c3c2b7", surface = "#ffffff")

  d <- residency; d$y <- as.numeric(d$label); BH <- 0.30
  tot <- fleet[order(fleet$start), ]
  tot$lab <- c("TwoRed", "TwoFer", "Bordeaux", "Creamsicle")
  ylab <- stats::setNames(sprintf("%s\n%.1f yr", tot$lab, tot$years), tot$lab)

  ## carets mark the two cars we still own -- the bar has no right end
  NOW <- max(d$end_eff)
  tri <- do.call(rbind, lapply(which(d$ongoing), function(i) {
    yy <- d$y[i]; x0 <- NOW + 55
    data.frame(g = i, x = c(x0, x0, x0 + 150),
               y = c(yy - BH * 0.8, yy + BH * 0.8, yy))
  }))
  tri$x <- as.Date(tri$x, origin = "1970-01-01")

  gs <- as.Date(mainland_gap["start"]); ge <- as.Date(mainland_gap["end"])
  mo <- length(seq(gs, ge, by = "month")) - 1L
  gap_txt <- sprintf("%d years %d months with no car on the mainland",
                     mo %/% 12, mo %% 12)

  sea_txt <- sprintf("%d days at sea", voyage_days)
  seam    <- voyage[["depart"]] + voyage_days / 2

  ytop <- 4 + BH + 0.30
  X0 <- as.Date("2010-01-01"); X1 <- NOW + 320
  brk <- seq(X0, as.Date("2026-01-01"), by = "2 years")

  ggplot2::ggplot() +
    ## drawn first, so the bars occlude them: the guides show only in empty time
    ggplot2::annotate("segment", x = c(gs, ge), xend = c(gs, ge),
                      y = 0.55, yend = ytop,
                      colour = INK$grid, linewidth = 0.35, linetype = "22") +
    ggplot2::geom_rect(data = d,
      ggplot2::aes(xmin = start, xmax = end_eff,
                   ymin = y - BH, ymax = y + BH, fill = where)) +
    ggplot2::geom_polygon(data = tri,
      ggplot2::aes(x = x, y = y, group = g), fill = PAL[["Hawaii"]]) +
    ## the seam in TwoRed bar is not a spacer: it is the crossing, to scale
    ggplot2::annotate("segment", x = seam, xend = seam,
                      y = 4 - BH - 0.03, yend = 3.52,
                      colour = INK$muted, linewidth = 0.3) +
    ggplot2::annotate("text", x = seam + 90, y = 3.52, label = sea_txt,
                      hjust = 0, vjust = 0.4, size = 2.9, colour = INK$secondary) +
    ggplot2::annotate("segment", x = gs, xend = ge, y = ytop, yend = ytop,
      colour = INK$muted, linewidth = 0.3,
      arrow = ggplot2::arrow(ends = "both", length = ggplot2::unit(4, "pt"),
                             type = "closed")) +
    ggplot2::annotate("text", x = gs + (ge - gs) / 2, y = ytop + 0.15,
                      label = gap_txt, size = 3, colour = INK$secondary) +
    ggplot2::scale_fill_manual(values = PAL, name = NULL,
                               breaks = c("Mainland", "Hawaii")) +
    ggplot2::scale_x_date(limits = c(X0, X1), breaks = brk,
                          date_labels = "%Y", expand = c(0, 0)) +
    ggplot2::scale_y_continuous(breaks = 1:4, labels = ylab[rev(tot$lab)],
                                limits = c(0.55, ytop + 0.36), expand = c(0, 0)) +
    ggplot2::labs(x = NULL, y = NULL) +
    ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(
      panel.grid = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_line(colour = INK$grid, linewidth = 0.3),
      axis.text.y = ggplot2::element_text(colour = INK$primary, hjust = 0,
                                          lineheight = 1.3,
                                          margin = ggplot2::margin(r = 8)),
      axis.text.x = ggplot2::element_text(colour = INK$muted),
      axis.line.x = ggplot2::element_line(colour = INK$axis, linewidth = 0.3),
      legend.position = "top", legend.justification = "left",
      legend.direction = "horizontal",
      legend.key.size = ggplot2::unit(9, "pt"),
      legend.text = ggplot2::element_text(colour = INK$secondary, size = 9),
      legend.margin = ggplot2::margin(b = 2),
      plot.margin = ggplot2::margin(6, 14, 6, 6),
      plot.background = ggplot2::element_rect(fill = INK$surface, colour = NA),
      panel.background = ggplot2::element_rect(fill = INK$surface, colour = NA))
}
