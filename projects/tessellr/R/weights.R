# Weights: service areas when points pull with different strengths.

#' Weighted service areas
#'
#' Divides a frame among sites that pull with different strengths. Each place
#' goes to the site with the smallest distance divided by weight: a site with
#' twice the weight seems half as far away (*The Map That Never Got Drawn*,
#' Chapter 7). With all weights equal this is an ordinary Voronoi map.
#'
#' Weighted boundaries are curves, not straight lines. Around a weaker site
#' the boundary closes into a circle, and the strongest site always wins far
#' enough away, in any direction, even past its rivals. A weight is a theory
#' about why people choose; the map shows what that theory implies.
#'
#' The areas are built on a grid of `cell` meters, then turned into polygons,
#' so their edges are accurate to about one cell.
#'
#' @param sites An `sf` object of points in a projected coordinate system.
#' @param weights Positive numbers, one per site, or the name of a column in
#'   `sites`. Use 1 for all sites for an unweighted map.
#' @param frame The area to divide (`sf`, `sfc` or `bbox`); it can be an
#'   irregular shape such as land only.
#' @param cell Grid cell size in meters.
#' @return An `sf` polygon object, one row per site that wins any ground, with
#'   the site's attributes, `weight`, and `area_km2`.
#' @seealso [tile_points()] for unweighted tiles as exact polygons.
#' @examples
#' sites <- sf::st_as_sf(data.frame(name = c("big", "small"), x = c(1000, 3000), y = c(2000, 2000),
#'                                  size = c(3, 1)), coords = c("x", "y"), crs = 32605)
#' frame <- sf::st_as_sfc(sf::st_bbox(c(xmin = 0, ymin = 0, xmax = 4000, ymax = 4000),
#'                                    crs = sf::st_crs(32605)))
#' areas <- weighted_areas(sites, "size", frame, cell = 50)
#' areas[, c("name", "weight", "area_km2")]
#' @export
weighted_areas <- function(sites, weights, frame, cell = 500) {
  if (!inherits(sites, "sf")) stop("`sites` must be an sf object of points.", call. = FALSE)
  check_projected(sites, "sites")
  w <- if (is.character(weights) && length(weights) == 1) sites[[weights]] else weights
  w <- rep(as.numeric(w), length.out = nrow(sites))
  if (any(is.na(w) | w <= 0)) stop("Weights must be positive numbers.", call. = FALSE)
  frame <- as_frame(frame)
  if (sf::st_crs(frame) != sf::st_crs(sites)) frame <- sf::st_transform(frame, sf::st_crs(sites))

  ## a grid of cells covering the frame
  grid <- terra::rast(terra::ext(terra::vect(frame)), resolution = cell, crs = sf::st_crs(sites)$wkt)
  grid <- terra::rasterize(terra::vect(frame), grid, touches = TRUE)
  in_frame <- which(!is.na(terra::values(grid)[, 1]))
  if (!length(in_frame)) stop("The frame holds no whole grid cells; try a smaller `cell`.", call. = FALSE)
  xy <- terra::xyFromCell(grid, in_frame)

  ## the winner of every cell: smallest distance divided by weight
  sxy <- sf::st_coordinates(sites)
  score <- vapply(seq_len(nrow(sxy)), function(i) {
    sqrt(((xy[, 1] - sxy[i, 1])^2) + ((xy[, 2] - sxy[i, 2])^2)) / w[i]
  }, numeric(nrow(xy)))
  if (is.null(dim(score))) score <- matrix(score, nrow = 1)
  winner <- max.col(-score, ties.method = "first")

  ## the cells as polygons, one per site
  won <- terra::rast(grid)
  terra::values(won) <- NA
  won[in_frame] <- winner
  names(won) <- "site"
  areas <- sf::st_as_sf(terra::as.polygons(won))
  sf::st_crs(areas) <- sf::st_crs(sites)
  areas <- suppressWarnings(sf::st_intersection(areas, frame))
  attrs <- sf::st_drop_geometry(sites)
  attrs$weight <- w
  areas <- sf::st_sf(attrs[areas$site, , drop = FALSE], geometry = sf::st_geometry(areas))
  areas$area_km2 <- as.numeric(sf::st_area(areas)) / 1e6
  row.names(areas) <- NULL
  areas
}
