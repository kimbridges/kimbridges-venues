#' Build a counter-clockwise WKT circle
#'
#' Approximates a circle of a given radius around a point as a WKT `POLYGON`,
#' suitable for GBIF geometry queries.
#'
#' @param lon,lat Centre longitude/latitude in decimal degrees.
#' @param r_km Radius in kilometres.
#' @param n Number of polygon vertices (more = smoother).
#' @return A length-one character WKT `POLYGON` string.
#' @examples
#' circle_wkt(-155.296, 19.437, 2)
#' @export
circle_wkt <- function(lon, lat, r_km = 2, n = 60) {
  th   <- seq(0, 2 * pi, length.out = n + 1)
  dlat <- (r_km / 111.32) * sin(th)
  dlon <- (r_km / (111.32 * cos(lat * pi / 180))) * cos(th)
  paste0("POLYGON((",
         paste(sprintf("%.6f %.6f", lon + dlon, lat + dlat), collapse = ", "), "))")
}

#' Fetch herbarium (preserved-specimen) records from GBIF
#'
#' Queries the GBIF occurrence API for preserved specimens of a taxon within a
#' circular area, returning a tidy tibble. Only preserved specimens (herbarium
#' sheets) are returned.
#'
#' @param lon,lat Centre coordinates in decimal degrees.
#' @param r_km Search radius in kilometres.
#' @param taxon A GBIF backbone name to restrict to. Default `"Magnoliopsida"`
#'   (flowering plants); use `"Tracheophyta"` for all vascular plants or
#'   `"Plantae"` for all plants (includes bryophytes).
#' @param rank Rank of `taxon`, e.g. `"class"`, `"phylum"`, `"kingdom"`.
#' @param kingdom Kingdom passed to [rgbif::name_backbone()] to disambiguate `taxon`.
#' @return A tibble of preserved-specimen records, one row per GBIF occurrence,
#'   with columns including `scientificName`, `species`, `family`, `recordedBy`,
#'   `recordNumber`, `eventDate`, `year`, `catalogNumber`, `institutionCode`,
#'   and coordinates (subset to those present).
#' @examples
#' \dontrun{
#' sp <- fetch_specimens_gbif(-155.296, 19.437, 2, taxon = "Tracheophyta", rank = "phylum")
#' }
#' @export
fetch_specimens_gbif <- function(lon, lat, r_km = 2,
                                 taxon = "Magnoliopsida", rank = "class",
                                 kingdom = "Plantae") {
  key <- rgbif::name_backbone(name = taxon, rank = rank, kingdom = kingdom)$usageKey
  wkt <- circle_wkt(lon, lat, r_km)
  n   <- rgbif::occ_search(taxonKey = key, geometry = wkt,
                           basisOfRecord = "PRESERVED_SPECIMEN", limit = 0)$meta$count
  res <- rgbif::occ_search(taxonKey = key, geometry = wkt,
                           basisOfRecord = "PRESERVED_SPECIMEN", limit = max(n, 1))
  want <- c("key", "scientificName", "species", "family", "genus", "class", "recordedBy",
            "recordNumber", "eventDate", "year", "month", "day", "catalogNumber",
            "institutionCode", "collectionCode", "decimalLatitude", "decimalLongitude",
            "coordinateUncertaintyInMeters")
  dplyr::select(res$data, dplyr::any_of(want))
}
