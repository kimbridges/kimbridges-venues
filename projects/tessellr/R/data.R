#' Twelve demonstration points at Kipuka Puaulu
#'
#' The twelve sample points used throughout *The Map That Never Got Drawn*.
#' They were placed for demonstration, three in each of four classes of canopy
#' structure, and each takes the vegetation type that the 1974 vegetation map of
#' Hawai'i Volcanoes National Park (Mueller-Dombois and Fosberg 1974) shows at
#' that spot. They are not field releves.
#'
#' @format A data frame with 12 rows and 4 columns:
#' \describe{
#'   \item{releve}{Point ID, `R01` to `R12`.}
#'   \item{easting, northing}{Coordinates in meters, WGS 84 / UTM zone 5N
#'     (EPSG:32605).}
#'   \item{vegetation}{Vegetation type from the 1974 map (five types, in
#'     Hawaiian orthography).}
#' }
#' @source Points placed by the authors; types from Mueller-Dombois, D. and
#'   F. R. Fosberg. 1974. Vegetation map of Hawaii Volcanoes National Park (at
#'   1:52,000). Technical Report 4, Cooperative National Park Resources Studies
#'   Unit, University of Hawaii, Honolulu.
#' @seealso [kipuka_frame()] for the matching study area.
"kipuka_releves"

#' The Kipuka Puaulu study area
#'
#' Returns the 3.2 by 2.6 km study-area rectangle used with [kipuka_releves],
#' as a polygon in WGS 84 / UTM zone 5N (EPSG:32605).
#'
#' @return An `sfc` polygon.
#' @examples
#' kipuka_frame()
#' @export
kipuka_frame <- function() {
  box <- c(xmin = 256666.9, ymin = 2149895.3, xmax = 259866.9, ymax = 2152495.3)
  sf::st_as_sfc(sf::st_bbox(box, crs = sf::st_crs(32605)))
}
