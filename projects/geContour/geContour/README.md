# geContour

An R package to create contour plots and apply them as Google Earth overlays.

## Overview

The `geContour` package provides tools to create contour plots from sparse spatial data and export them as Google Earth overlays. This makes it easy to visualize spatial data patterns in a geographically accurate context.

## Installation

You can install the development version from GitHub:

```r
# install.packages("devtools")
devtools::install_github("kimbridges/geContour")
```

## Features

- Create contour plots from latitude, longitude, and value data
- Interpolate sparse data using akima or thin plate spline methods
- Export as transparent PNG overlays
- Automatically generate KML files for Google Earth
- Bundle outputs into KMZ files for easy sharing
- Customize contour colors, breaks, and transparency

## Usage

### Basic Example

```r
library(geContour)

# Create sample data (in real usage, load your own data)
data <- data.frame(
  lat = runif(100, 30, 35),
  lon = runif(100, -120, -115),
  value = runif(100, 0, 100)
)

# Create and export to Google Earth
result <- contour_to_google_earth(
  data = data,
  output_name = "my_contour_overlay"
)

# View the contour plot in R
print(result$plot)

# The result includes paths to the created files
result$png  # Path to PNG image
result$kml  # Path to KML file
result$kmz  # Path to KMZ file (if create_kmz = TRUE)
```

### Customized Example

```r
library(geContour)
library(viridis)  # For color palettes

# Create and export with custom settings
result <- contour_to_google_earth(
  data = data,
  output_name = "custom_overlay",
  contour_breaks = 8,                      # Number of contour levels
  fill_colors = viridis::inferno(8),       # Custom color palette
  alpha = 0.6,                             # Semi-transparent
  buffer_percent = 5,                      # Add 5% buffer around data extent
  include_legend = TRUE,                   # Include legend in the overlay
  interpolate = TRUE,                      # Interpolate sparse data
  interp_method = "tps"                    # Use thin plate spline interpolation
)
```

## Viewing Results

To view the results:

1. Open Google Earth Pro
2. Use File > Open to open the generated KML or KMZ file
3. The contour overlay will be displayed over the geographic area

## Requirements

- R (>= 4.0.0)
- Required packages:
  - ggplot2
  - viridis (optional, for color palettes)
  - akima (for interpolation)
  - zip (for KMZ creation)
  - fields (for thin plate spline interpolation)

## License

MIT