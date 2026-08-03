# Example Usage:
# Ensure the libraries are loaded first:
# library(exifr)
# library(dplyr)
# library(xml2)

# results <- process_photo_locations(
#   folder_path = "Kyoto_1", # Your photo folder
#   output_gpx_file = "Kyoto_Trip.gpx",
#   recursive_search = TRUE
# )

# Access the results:
# print(results$summary_stats)
# print(head(results$gpx_data))
# if (!is.na(results$gpx_file_path)) {
#   cat("GPX file created at:", results$gpx_file_path, "\n")
# }

# Example: Only get statistics, don't create GPX
# stats_only <- process_photo_locations(
#   folder_path = "Kyoto_1",
#   create_gpx = FALSE
# )
# print(stats_only$summary_stats)