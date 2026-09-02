## fig_constellations.R -- ch.13. The two constellations.
##
## FORM, figure 1 (driving): a choropleth, NOT a scatter of fill points. The
## gazetteer places 85% of TwoRed's fills and 40% of Creamsicle's, so a point map
## would show the second car as sparse because of a gazetteer gap rather than
## because of anything the car did. State-level coverage is complete for both, so
## that is the finest grain the record honestly supports.
##
## COLOUR: an ordered two-step ramp of the book's hue, dark for the states both
## cars filled in and light for the ones only TwoRed did. The two silent classes
## take no fill at all, because the figure's subject is the absence: an unfilled
## state is a hole in the map and should look like one. Validated: #2a78d6 against
## #bcd8f2 is dE 31.7 normal, 29.8 protan, 28.0 tritan. The light step sits below
## 3:1 against the surface, which obligates relief -- supplied here as direct
## labels on every silent state plus the table in the chapter.
##
## FORM, figure 2 (parking): a timeline, not a map (Finding 041). The named
## holdings come from Kim's testimony and there are only a handful of them. What
## the record can place is WHEN the car was not moving, and for how long, so the
## honest figure puts the driving days and the gaps on one shared date axis and
## lets the emptiness of the top row carry the finding.

.SC_HUE  <- "#2a78d6"
.SC_LITE <- "#bcd8f2"
.SC_INK  <- list(primary = "#33322f", secondary = "#52514e", muted = "#898781",
                 grid = "#e1e0d9", surface = "#ffffff", quiet = "#d6d9de")

## North America Albers. Keeps Alaska and Newfoundland in one honest projection.
.SC_CRS <- paste("+proj=aea +lat_1=20 +lat_2=60 +lat_0=40 +lon_0=-96",
                 "+x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs")

fig_driving <- function(K, path = "figures/driving.png") {
  stopifnot(requireNamespace("sf", quietly = TRUE))
  g <- readRDS("data/na_states.rds")            # cached; the build never uses the network
  g <- g[!(g$postal %in% c("HI")), ]            # the car's home, not somewhere it drove

  ## THE SUBJECT IS TRAVEL, NOT TRANSACTIONS. An earlier version of this figure
  ## outlined the six states the fuel log never saw, and the outlines drew the eye
  ## so hard that the map appeared to be ABOUT the gaps. It is not. Whether a
  ## particular state got a fill is an accident of how far apart the tanks fell;
  ## where the cars went is the thing worth drawing. So every jurisdiction either
  ## car reached is filled, by whichever cars reached it, and the six no-fill
  ## states are carried in the chapter's table instead.
  tw <- unique(norm_state(twored_fuel$State))
  cr <- unique(norm_state(cream_fuel$state))
  ## TwoRed also reached, without ever buying a tank there: the six states of
  ## SILENT_STATES, and British Columbia (one road north out of Haines, plus a
  ## second clip of the corner off the Canadian plains).
  tw <- union(tw, c(K$silent$state, "BC"))

  both <- intersect(tw, cr)
  one  <- setdiff(union(tw, cr), both)

  g$cls <- ifelse(g$postal %in% both, "both cars went here",
           ifelse(g$postal %in% one,  "one car went here", NA))
  g$cls <- factor(g$cls, levels = c("both cars went here", "one car went here"))
  g <- sf::st_transform(g, .SC_CRS)

  p <- ggplot2::ggplot(g) +
    ggplot2::geom_sf(ggplot2::aes(fill = cls), colour = .SC_INK$surface,
                     linewidth = 0.28) +
    ggplot2::scale_fill_manual(
      values = c("both cars went here" = .SC_HUE,
                 "one car went here"   = .SC_LITE),
      na.value = "#f4f3ef", drop = FALSE, na.translate = FALSE, name = NULL) +
    ggplot2::coord_sf(expand = FALSE) +
    ggplot2::theme_void(base_size = 11) +
    ggplot2::theme(
      legend.position = "top", legend.justification = "left",
      legend.text = ggplot2::element_text(colour = .SC_INK$secondary, size = 9),
      legend.key.size = ggplot2::unit(9, "pt"),
      plot.margin = ggplot2::margin(2, 2, 2, 2))

  ggplot2::ggsave(path, p, width = 7.4, height = 5.4, dpi = 200, bg = .SC_INK$surface)
  invisible(p)
}

fig_parking <- function(K, path = "figures/parking.png") {
  os <- K$os
  os$band2 <- factor(
    ifelse(grepl("^on station", os$band), "on station",
    ifelse(grepl("^ambiguous",  os$band), "ambiguous", "an unlogged trip")),
    levels = c("on station", "ambiguous", "an unlogged trip"))

  L <- twored_legs; L$date <- as.Date(L$date)
  days <- data.frame(date = sort(unique(L$date)))

  ## the four gaps worth naming, by length
  top <- os[order(-os$days), ][1:4, ]
  top$mid <- top$on_station_from + (top$to - top$on_station_from) / 2
  ## label ink follows the fill: white on the two dark bands, primary ink on the tint
  top$ink <- ifelse(top$band2 == "ambiguous", .SC_INK$primary, .SC_INK$surface)

  p <- ggplot2::ggplot() +
    ## row 1: every day the car is known to have been driven
    ggplot2::geom_segment(data = days,
      ggplot2::aes(x = date, xend = date, y = 1.72, yend = 2.04),
      colour = .SC_HUE, linewidth = 0.42) +
    ## row 2: the gaps between logged trips
    ggplot2::geom_rect(data = os,
      ggplot2::aes(xmin = on_station_from, xmax = to, ymin = 0.72, ymax = 1.28,
                   fill = band2), colour = .SC_INK$surface, linewidth = 0.8) +
    ggplot2::geom_text(data = top,
      ggplot2::aes(x = mid, y = 1.0, label = paste0(days, " days"), colour = I(ink)),
      size = 2.9, fontface = "bold") +
    ggplot2::scale_fill_manual(
      values = c("on station" = .SC_HUE, "ambiguous" = .SC_LITE,
                 "an unlogged trip" = .SC_INK$secondary), name = NULL) +
    ggplot2::scale_y_continuous(
      breaks = c(1.88, 1.0), limits = c(0.55, 2.3),
      labels = c(sprintf("driven\n%d days", K$leg_days),
                 sprintf("between trips\n%d days", K$gap_days))) +
    ggplot2::scale_x_date(date_breaks = "1 year", date_labels = "%Y",
                          expand = ggplot2::expansion(mult = 0.01)) +
    ggplot2::labs(x = NULL, y = NULL) +
    ggplot2::theme(
      legend.position = "top", legend.justification = "left",
      legend.text = ggplot2::element_text(colour = .SC_INK$secondary, size = 9),
      legend.key.size = ggplot2::unit(9, "pt"),
      panel.grid.major.y = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_line(colour = .SC_INK$grid, linewidth = 0.3),
      axis.text.y = ggplot2::element_text(colour = .SC_INK$secondary, size = 9,
                                          hjust = 1, lineheight = 1.05),
      axis.text.x = ggplot2::element_text(colour = .SC_INK$secondary, size = 9),
      plot.margin = ggplot2::margin(2, 6, 2, 2))

  ggplot2::ggsave(path, p, width = 7.4, height = 2.5, dpi = 200, bg = .SC_INK$surface)
  invisible(p)
}
