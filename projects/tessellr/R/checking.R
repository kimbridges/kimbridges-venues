# Checking: how well does a map agree with another?

## the category of every cell, as text (labels for a categorical raster)
cell_labels <- function(r) {
  v <- terra::values(r[[1]])[, 1]
  ct <- terra::cats(r[[1]])[[1]]
  if (!is.null(ct) && nrow(ct) > 0) {
    lab <- as.character(ct[[2]][match(v, ct[[1]])])
  } else {
    lab <- as.character(v)
  }
  lab
}

## boundary cells of a map of labels, and the distance from every cell to them
boundary_cells <- function(template, labels) {
  codes <- match(labels, unique(stats::na.omit(labels)))
  r <- terra::setValues(terra::rast(template), codes)
  edges <- terra::boundaries(r, classes = TRUE, directions = 4)
  on_edge <- terra::values(edges)[, 1] == 1
  dist <- terra::values(terra::distance(terra::classify(edges, cbind(0, NA))))[, 1]
  list(on_edge = on_edge, dist = dist)
}

#' Agreement between a map and a reference map
#'
#' Two ways to ask whether two maps of categories agree (*The Map That Never
#' Got Drawn*, Chapter 9):
#' \describe{
#'   \item{Area agreement}{The share of the ground that has the same category
#'     on both maps. Only cells with a category on the reference are used.}
#'   \item{Boundary agreement}{Whether the lines fall in the same places.
#'     `boundary_found` is the share of the reference's boundary that lies
#'     within `tolerance` meters of a boundary on the map: how much of the
#'     reference's line work the map found. `boundary_on_reference` runs the
#'     other way: the share of the map's boundary that lies within `tolerance`
#'     of a reference line.}
#' }
#' A reference is not necessarily the truth. An old map records an older
#' landscape, and disagreement can be change as well as error.
#'
#' Categories are compared by their labels when the rasters are categorical
#' (as from [constrained_voronoi()]), so the two maps need not number their
#' categories the same way; otherwise by their values.
#'
#' @param map A SpatRaster of categories.
#' @param reference A SpatRaster of categories. Resampled to the grid of `map`
#'   (nearest cell) if the grids differ.
#' @param tolerance Distance (m) within which two boundaries count as the same
#'   line.
#' @return A one-row data frame: `area_agreement`, `boundary_found`,
#'   `boundary_on_reference` (shares from 0 to 1), and `map_boundary_km` and
#'   `reference_boundary_km` (approximate lengths, counted in cells).
#' @seealso [constrained_voronoi()]
#' @examples
#' r <- terra::rast(nrows = 50, ncols = 50, xmin = 0, xmax = 500, ymin = 0, ymax = 500,
#'                  crs = "EPSG:32605")
#' xy <- terra::xyFromCell(r, seq_len(terra::ncell(r)))
#' ref <- terra::setValues(r, ifelse(xy[, 1] < 250, 1, 2))
#' map <- terra::setValues(r, ifelse(xy[, 1] < 270, 1, 2))
#' map_agreement(map, ref, tolerance = 25)
#' @export
map_agreement <- function(map, reference, tolerance = 50) {
  if (!terra::compareGeom(map, reference, stopOnError = FALSE)) {
    reference <- terra::resample(reference, map, method = "near")
  }
  m <- cell_labels(map)
  r <- cell_labels(reference)
  coded <- !is.na(r)
  cell_km <- terra::res(map)[1] / 1000

  ## area agreement, on the ground the reference covers
  area <- mean(!is.na(m[coded]) & m[coded] == r[coded])

  ## boundaries of each map, and distances to them
  mb <- boundary_cells(map[[1]], m)
  rb <- boundary_cells(map[[1]], ifelse(coded, r, NA))
  found <- mean(mb$dist[which(rb$on_edge)] <= tolerance, na.rm = TRUE)
  on_ref <- mean(rb$dist[which(mb$on_edge & coded)] <= tolerance, na.rm = TRUE)

  data.frame(area_agreement = area,
             boundary_found = found,
             boundary_on_reference = on_ref,
             map_boundary_km = sum(mb$on_edge, na.rm = TRUE) * cell_km,
             reference_boundary_km = sum(rb$on_edge, na.rm = TRUE) * cell_km)
}
