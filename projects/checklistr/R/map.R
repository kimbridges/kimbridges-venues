#' Map specimen localities
#'
#' Plots the distinct georeferenced localities of a specimen set within the query
#' circle, with points sized by how many records stack on each locality and
#' coloured by median collection year. Optionally draws a hillshade backdrop
#' (needs the suggested packages \pkg{elevatr} and \pkg{terra}).
#'
#' Herbarium georeferencing is often nominal -- many records share one gazetteer
#' point -- and imprecise, so this shows the \emph{georeferencing pattern} within
#' the site, not fine-scale sampling. Records with no coordinates are absent from
#' a geometry-based pull entirely, a bias worth remembering.
#'
#' @param df Specimen records with `decimalLatitude`/`decimalLongitude` (and
#'   optionally `coordinateUncertaintyInMeters`, `year`).
#' @param lon,lat,r_km Centre and radius of the query circle (as used in the fetch).
#' @param basemap If `TRUE`, attempt a hillshade backdrop via elevatr/terra.
#' @param place Place name for the title.
#' @return A ggplot object.
#' @examples
#' \dontrun{
#' sp <- fetch_specimens_gbif(-155.296, 19.437, 2, taxon = "Tracheophyta", rank = "phylum")
#' map_specimens(sp, -155.296, 19.437, 2, place = "Kipuka Puaulu")
#' }
#' @export
map_specimens <- function(df, lon, lat, r_km = 2, basemap = TRUE, place = "") {
  g <- df %>% dplyr::filter(!is.na(decimalLatitude), !is.na(decimalLongitude))
  if (!nrow(g)) stop("No georeferenced records to map.")
  pts <- g %>% dplyr::group_by(decimalLongitude, decimalLatitude) %>%
    dplyr::summarise(records  = dplyr::n(),
                     med_year = if ("year" %in% names(g)) stats::median(year, na.rm = TRUE) else NA_real_,
                     .groups = "drop")
  th   <- seq(0, 2 * pi, length.out = 91)
  circ <- data.frame(x = lon + (r_km / (111.32 * cos(lat * pi / 180))) * cos(th),
                     y = lat + (r_km / 111.32) * sin(th))

  hsdf <- NULL
  if (isTRUE(basemap) && requireNamespace("elevatr", quietly = TRUE) &&
      requireNamespace("terra", quietly = TRUE)) {
    hsdf <- tryCatch({
      bb  <- data.frame(x = lon + c(-1, 1) * r_km / 85, y = lat + c(-1, 1) * r_km / 111)
      dem <- terra::rast(elevatr::get_elev_raster(bb, prj = 4326, z = 12, clip = "bbox", verbose = FALSE))
      hs  <- terra::shade(terra::terrain(dem, "slope",  unit = "radians"),
                          terra::terrain(dem, "aspect", unit = "radians"),
                          angle = 40, direction = 315)
      h <- as.data.frame(hs, xy = TRUE); names(h)[3] <- "hs"; h
    }, error = function(e) NULL)
  }

  cu  <- if ("coordinateUncertaintyInMeters" %in% names(g)) g$coordinateUncertaintyInMeters else NA
  cap <- sprintf(
    "%d records at %d distinct points (top = %d). Georeferencing often nominal; %s. Non-georeferenced sheets are excluded by a geometry query.",
    nrow(g), nrow(pts), max(pts$records),
    if (any(!is.na(cu)))
      sprintf("stated uncertainty ~%.0f m median (%d%% of records)",
              stats::median(cu, na.rm = TRUE), round(100 * mean(!is.na(cu))))
    else "coordinate uncertainty rarely stated")

  p <- ggplot2::ggplot()
  if (!is.null(hsdf)) p <- p +
    ggplot2::geom_raster(data = hsdf, ggplot2::aes(x, y, fill = hs), show.legend = FALSE) +
    ggplot2::scale_fill_gradient(low = "grey35", high = "grey92")
  p +
    ggplot2::geom_path(data = circ, ggplot2::aes(x, y), color = "grey20",
                       linewidth = 0.4, linetype = "dashed") +
    ggplot2::geom_point(data = pts, ggplot2::aes(decimalLongitude, decimalLatitude,
                        size = records, color = med_year), alpha = 0.85) +
    ggplot2::annotate("point", x = lon, y = lat, shape = 3, size = 3, stroke = 1, color = "black") +
    ggplot2::scale_size_area(max_size = 11, name = "records") +
    ggplot2::scale_color_viridis_c(option = "D", name = "median year") +
    ggplot2::coord_fixed(ratio = 1 / cos(lat * pi / 180), expand = FALSE) +
    ggplot2::labs(title = paste(place, "- specimen localities"), x = NULL, y = NULL, caption = cap) +
    ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(plot.caption = ggplot2::element_text(hjust = 0, size = 8, color = "grey40"))
}
