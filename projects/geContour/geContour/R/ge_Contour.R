#' @title geContour: Functions to create contour plots to apply them as Google Earth overlays
#' @description Tools for building custom contour plots from sparse data and then
#' automatically aligning them as overlays on Google Earth.
#'
#' @import ggplot2
#' @importFrom viridis viridis
#' @importFrom akima interp
#' @importFrom zip zip
#' @importFrom fields Tps
#' @name geContour
#' @aliases geContour-package
"_PACKAGE"

#' @title Create a contour plot from lat/lon/value data
#' @description Creates a ggplot-based contour plot from spatial data containing latitude, longitude, and values.
#'
#' @param data A data frame with columns 'lat', 'lon', and 'value'
#' @param fill_colors Vector of colors for contour fill (default: viridis palette)
#' @param contour_breaks Number of contour breaks or vector of specific breaks
#' @param alpha Transparency of the contour fill (0-1)
#' @param title Optional title for the contour plot (only for display, not included in export)
#' @param interpolate Whether to interpolate sparse data (TRUE) or use raw data (FALSE)
#' @param interp_grid_res Resolution of interpolation grid (only used when interpolate=TRUE)
#' @param interp_method Interpolation method: "akima" (default) or "tps" (thin plate spline)
#' @return A ggplot object containing the contour plot
#' @export
create_contour_plot <- function(data,
                                fill_colors = NULL,
                                contour_breaks = 10,
                                alpha = 0.7,
                                title = NULL,
                                interpolate = TRUE,
                                interp_grid_res = 100,
                                interp_method = "akima") {
   # Check required libraries
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is needed. Please install it.")
  }

  # Check that data has required columns
  required_cols <- c("lat", "lon", "value")
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols) > 0) {
    stop("Data must contain columns: ", paste(missing_cols, collapse = ", "))
  }

  # Set default colors if not provided
  if (is.null(fill_colors)) {
    if (requireNamespace("viridis", quietly = TRUE)) {
      fill_colors <- viridis::viridis(10)
    } else {
      fill_colors <- colorRampPalette(c("blue", "cyan", "yellow", "red"))(10)
    }
  }

  # Interpolate sparse data if requested
  if (interpolate && nrow(data) < 200) {  # Only interpolate if data is sparse
    # Check if we have enough points for interpolation (need at least 4)
    if (nrow(data) < 4) {
      warning("Not enough data points for interpolation. Using raw data.")
      plot_data <- data
    } else {
      if (interp_method == "akima") {
        # Check if akima package is available
        if (!requireNamespace("akima", quietly = TRUE)) {
          stop("Package 'akima' is needed for interpolation. Please install it.")
        }

        # Use akima interpolation
        interp_result <- with(data,
          akima::interp(
            x = lon,
            y = lat,
            z = value,
            xo = seq(min(lon), max(lon), length.out = interp_grid_res),
            yo = seq(min(lat), max(lat), length.out = interp_grid_res),
            linear = TRUE,     # linear interpolation
            extrap = FALSE     # don't extrapolate beyond data range
          )
        )

        # Convert interpolation result to a data frame for ggplot
        plot_data <- data.frame(
          lon   = rep(interp_result$x, each = interp_grid_res),
          lat   = rep(interp_result$y, times = interp_grid_res),
          value = as.vector(interp_result$z)
        )

        # Remove any NAs (locations that couldn't be interpolated)
        plot_data <- na.omit(plot_data)

      } else if (interp_method == "tps") {
        # Check if fields package is available
        if (!requireNamespace("fields", quietly = TRUE)) {
          stop("Package 'fields' is needed for TPS interpolation. Please install it.")
        }

        # Create a fine grid for interpolation
        lat_seq <- seq(min(data$lat), max(data$lat), length.out = interp_grid_res)
        lon_seq <- seq(min(data$lon), max(data$lon), length.out = interp_grid_res)
        interp_grid <- expand.grid(lat = lat_seq, lon = lon_seq)

        # Fit a thin plate spline model
        tps_model <- fields::Tps(
          x = data[, c("lat", "lon")],
          Y = data$value
        )

        # Predict values on the grid
        interp_grid$value <- predict(tps_model, interp_grid[, c("lat", "lon")])

        plot_data <- interp_grid
      } else {
        stop("Unknown interpolation method. Use 'akima' or 'tps'.")
      }
    }
  } else {
    # Use raw data
    plot_data <- data
  }

  # Create the plot
  contour_plot <- ggplot2::ggplot(plot_data,
                                  ggplot2::aes(x = lon, y = lat, z = value)) +
    ggplot2::geom_contour_filled(bins = contour_breaks, alpha = alpha) +
    ggplot2::scale_fill_manual(values = fill_colors) +
    ggplot2::coord_fixed() # Important for accurate geographic proportions

  # Add title only for display version - won't be used in export
  if (!is.null(title)) {
    contour_plot <- contour_plot + ggplot2::ggtitle(title)
  }

  return(contour_plot)
}

#' Save a contour plot for Google Earth overlay
#'
#' @param plot A ggplot object, typically created with create_contour_plot()
#' @param filename The base filename to use (without extension)
#' @param width Width of the output image in inches
#' @param height Height of the output image in inches
#' @param dpi Resolution of the output image
#' @param include_legend Whether to include the legend in the export
#' @return The filename of the saved PNG
#' @export
#'
save_contour_for_overlay <- function(plot,
                                   filename = "contour_overlay",
                                   width = 10,
                                   height = 8,
                                   dpi = 300,
                                   include_legend = FALSE) {

  # Create a version of the plot suitable for overlay
  overlay_plot <- plot +
    ggplot2::theme_void() +
    ggplot2::theme(
      panel.background = ggplot2::element_rect(fill = "transparent", color = NA),
      plot.background = ggplot2::element_rect(fill = "transparent", color = NA),
      plot.margin = ggplot2::margin(0, 0, 0, 0)
    )

  # Remove legend if specified
  if (!include_legend) {
    overlay_plot <- overlay_plot + ggplot2::theme(legend.position = "none")
  }

  # Save the plot
  png_filename <- paste0(filename, ".png")
  ggplot2::ggsave(
    png_filename,
    overlay_plot,
    width = width,
    height = height,
    dpi = dpi,
    bg = "transparent"
  )

  return(png_filename)
}

#' Create a KML file for the contour overlay
#'
#' @param data The original data used to create the plot
#' @param png_filename The filename of the PNG to use in the KML
#' @param output_filename The filename for the KML (without extension)
#' @param buffer_percent Optional buffer percentage to add around the data extent
#' @return The filename of the created KML
#' @export
#'
create_contour_kml <- function(data,
                             png_filename = "contour_overlay.png",
                             output_filename = "contour_overlay",
                             buffer_percent = 0) {

  # Calculate geographical bounds with optional buffer
  data_bounds <- list(
    west = min(data$lon, na.rm = TRUE),
    east = max(data$lon, na.rm = TRUE),
    south = min(data$lat, na.rm = TRUE),
    north = max(data$lat, na.rm = TRUE)
  )

  # Add buffer if requested
  if (buffer_percent > 0) {
    lon_range <- data_bounds$east - data_bounds$west
    lat_range <- data_bounds$north - data_bounds$south

    buffer_lon <- (lon_range * buffer_percent) / 100
    buffer_lat <- (lat_range * buffer_percent) / 100

    data_bounds$west <- data_bounds$west - buffer_lon
    data_bounds$east <- data_bounds$east + buffer_lon
    data_bounds$south <- data_bounds$south - buffer_lat
    data_bounds$north <- data_bounds$north + buffer_lat
  }

  # Create the KML content
  kml_content <- paste0('<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <GroundOverlay>
    <name>Contour Plot Overlay</name>
    <description>Created from R contour data</description>
    <Icon>
      <href>', png_filename, '</href>
    </Icon>
    <LatLonBox>
      <north>', data_bounds$north, '</north>
      <south>', data_bounds$south, '</south>
      <east>', data_bounds$east, '</east>
      <west>', data_bounds$west, '</west>
      <rotation>0</rotation>
    </LatLonBox>
  </GroundOverlay>
</kml>')

  # Write the KML file
  kml_filename <- paste0(output_filename, ".kml")
  writeLines(kml_content, kml_filename)

  return(kml_filename)
}

#' Create a KMZ file bundling the PNG and KML
#'
#' @param kml_filename The KML file to include
#' @param png_filename The PNG file to include
#' @param output_filename The filename for the KMZ (without extension)
#' @return The filename of the created KMZ
#' @export
#'
create_contour_kmz <- function(kml_filename,
                             png_filename,
                             output_filename = "contour_overlay") {

  # Check if zip package is available
  if (!requireNamespace("zip", quietly = TRUE)) {
    stop("Package 'zip' is needed for KMZ creation. Please install it.")
  }

  # Create KMZ (zip file with KML and PNG)
  kmz_filename <- paste0(output_filename, ".kmz")
  zip::zip(kmz_filename, files = c(kml_filename, png_filename))

  return(kmz_filename)
}

#' Complete workflow to create a Google Earth overlay from lat/lon/value data
#'
#' @param data A data frame with columns 'lat', 'lon', and 'value'
#' @param output_name Base name for output files
#' @param contour_breaks Number of contour breaks or vector of specific breaks
#' @param fill_colors Vector of colors for contour fill (default: viridis palette)
#' @param alpha Transparency of the contour fill (0-1)
#' @param buffer_percent Optional buffer percentage to add around the data extent
#' @param include_legend Whether to include the legend in the export
#' @param create_kmz Whether to create a KMZ file in addition to KML/PNG
#' @param interpolate Whether to interpolate sparse data (TRUE) or use raw data (FALSE)
#' @param interp_grid_res Resolution of interpolation grid (only used when interpolate=TRUE)
#' @param interp_method Interpolation method: "akima" (default) or "tps" (thin plate spline)
#' @return A list with the paths to created files
#' @export
#'
contour_to_google_earth <- function(data,
                                  output_name = "contour_overlay",
                                  contour_breaks = 10,
                                  fill_colors = NULL,
                                  alpha = 0.7,
                                  buffer_percent = 2,
                                  include_legend = FALSE,
                                  create_kmz = TRUE,
                                  interpolate = TRUE,
                                  interp_grid_res = 100,
                                  interp_method = "akima") {

  # Create the contour plot
  contour_plot <- create_contour_plot(
    data = data,
    fill_colors = fill_colors,
    contour_breaks = contour_breaks,
    alpha = alpha,
    interpolate = interpolate,
    interp_grid_res = interp_grid_res,
    interp_method = interp_method
  )

  # Save as PNG
  png_file <- save_contour_for_overlay(
    plot = contour_plot,
    filename = output_name,
    include_legend = include_legend
  )

  # Create KML
  kml_file <- create_contour_kml(
    data = data,
    png_filename = png_file,
    output_filename = output_name,
    buffer_percent = buffer_percent
  )

  result <- list(
    plot = contour_plot,
    png = png_file,
    kml = kml_file
  )

  # Create KMZ if requested
  if (create_kmz) {
    kmz_file <- create_contour_kmz(
      kml_filename = kml_file,
      png_filename = png_file,
      output_filename = output_name
    )
    result$kmz <- kmz_file
  }

  return(result)
}

# Example usage:
#
# # Load your data
# data <- read.csv("my_data.csv")  # Should have lat, lon, value columns
#
# # Create and export to Google Earth
# result <- contour_to_google_earth(data,
#                                  output_name = "my_contour_overlay",
#                                  interpolate = TRUE,
#                                  interp_method = "akima")
#
# # Open in Google Earth Pro
# # Simply double-click on the KMZ file or use File > Open in Google Earth Pro
