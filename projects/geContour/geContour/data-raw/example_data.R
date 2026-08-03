# Create example dataset
example_contour_data <- data.frame(
  lat = runif(100, 30, 35),
  lon = runif(100, -120, -115),
  value = runif(100, 0, 100)
)

# Save to data/ directory
usethis::use_data(example_contour_data, overwrite = TRUE)