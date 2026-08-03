# --- Load the Toolkit ---
source("R/ingest_data.R")
source("R/process_locations.R")
source("R/write_exif.R")

# --- 1. Configuration ---
timeline_file <- "Timelines/Timeline.json"
photo_folder  <- "Photos"
time_zone     <- "Pacific/Honolulu" # Camera time setting

# --- 2. Ingest ---
message("--- Step 1: Ingest ---")
raw_json      <- fromJSON(timeline_file)
clean_signals <- clean_timeline_signals(raw_json)
clean_visits  <- clean_semantic_history(raw_json)
photo_data    <- get_photo_timestamps(photo_folder, tz_offset = time_zone)

# --- 3. Process ---
message("--- Step 2: Processing ---")
final_map <- fuse_data(photo_data, clean_signals, clean_visits)

# Print Summary
summary_stats <- final_map |> group_by(method) |> tally()
print(summary_stats)

# --- 4. Write ---
message("--- Step 3: Writing to Files ---")
csv_file <- write_gps_manifest(final_map)
apply_gps_to_images(csv_file, photo_folder)

message("Done! Check your map.")
