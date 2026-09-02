## fig_stops.R -- every fuel stop, placed.
##
## FORM: points on land, no route lines. The project's standing rule is that a
## claim made from geometry beats a claim made from a guessed route, and joining
## consecutive fills with a line would draw roads nobody recorded. The spacing
## between the dots is the finding; it needs no line to be visible.
##
## COLOUR: one hue, one mark size. Every point is the same kind of event, so
## nothing here is categorical and nothing needs a ramp. The land beneath is a
## near-neutral so the dots carry all the ink.

fig_stops <- function(S, car = "TwoRed", path = "figures/stops.png") {
  stopifnot(requireNamespace("sf", quietly = TRUE))
  g <- readRDS("data/na_states.rds")
  g <- g[g$postal != "HI", ]
  g <- sf::st_transform(g, .SC_CRS)

  d <- S$pts[S$pts$car == car, ]
  p <- sf::st_transform(
    sf::st_as_sf(d, coords = c("lon", "lat"), crs = 4326), .SC_CRS)

  gg <- ggplot2::ggplot() +
    ggplot2::geom_sf(data = g, fill = "#eeede8", colour = .SC_INK$surface,
                     linewidth = 0.3) +
    ggplot2::geom_sf(data = p, colour = .SC_HUE, size = 1.5, alpha = 0.9,
                     stroke = 0) +
    ggplot2::coord_sf(expand = FALSE) +
    ggplot2::theme_void(base_size = 11) +
    ggplot2::theme(plot.margin = ggplot2::margin(2, 2, 2, 2))

  ggplot2::ggsave(path, gg, width = 7.4, height = 5.4, dpi = 200,
                  bg = .SC_INK$surface)
  invisible(gg)
}
