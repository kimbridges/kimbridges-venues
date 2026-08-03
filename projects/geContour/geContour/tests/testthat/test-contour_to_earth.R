test_that("create_contour_plot works", {
  # Create sample data
  test_data <- data.frame(
    lat = runif(20, 30, 35),
    lon = runif(20, -120, -115),
    value = runif(20, 0, 100)
  )
  
  # Test with minimal parameters
  plot <- create_contour_plot(test_data)
  expect_s3_class(plot, "ggplot")
})