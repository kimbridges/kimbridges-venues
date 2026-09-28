#' tessellr: Voronoi tessellations for vegetation, ecology and geography
#'
#' Build Voronoi tessellations from category data at points and put them to
#' work. The functions follow the document *The Map That Never Got Drawn*
#' (Bridges and Claude, 2026), which develops each idea with worked examples at
#' Kipuka Puaulu, Hawai'i Volcanoes National Park.
#'
#' The functions come in five groups:
#' \describe{
#'   \item{Tiles}{[tile_points()], [tile_measures()], [tile_pattern()],
#'     [merge_tiles()], [boundary_bands()]}
#'   \item{Containers}{`count_in_tiles()`}
#'   \item{Weights}{`weighted_areas()`}
#'   \item{Canopy}{`get_canopy_height()`, `structure_classes()`,
#'     `trace_patch()`, `constrained_voronoi()`}
#'   \item{Checking}{`map_agreement()`}
#' }
#'
#' A typical start:
#' \preformatted{
#' pts   <- sf::st_as_sf(kipuka_releves, coords = c("easting", "northing"), crs = 32605)
#' frame <- kipuka_frame()
#' tiles <- tile_points(pts, frame)
#' tile_measures(tiles, frame)
#' }
#'
#' @keywords internal
"_PACKAGE"
