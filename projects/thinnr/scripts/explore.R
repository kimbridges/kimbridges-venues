# thinnr/scripts/explore.R
# Exploratory analysis script for understanding image collection patterns
# Updated to use shot-level analysis and Sony SequenceNumber

library(tidyverse)
library(gt)
library(exifr)
library(lubridate)

# Source the extraction functions
source(here::here("R", "extract.R"))


# ============================================================================
# CONFIGURATION - Set your folder path here
# ============================================================================

# Replace this with the full path to your test folder
photo_folder <- "J:/trim_test"  # <-- EDIT THIS


# ============================================================================
# EXTRACT AND CONSOLIDATE
# ============================================================================

# Step 1: Extract raw EXIF data (one row per file)
exif_data <- extract_exif(photo_folder)

# Step 2: Consolidate to shots (one row per JPG+RAW pair)
shots <- consolidate_to_shots(exif_data)

# Step 3: Identify burst sequences using SequenceNumber
shots_with_bursts <- identify_bursts(shots)

# Quick look at what we got
glimpse(shots_with_bursts)


# ============================================================================
# BASIC SUMMARY STATISTICS
# ============================================================================

# How many files of each type?
exif_data |>
  count(file_type, file_ext) |>
  gt() |>
  tab_header(
    title = "File Type Distribution",
    subtitle = attr(exif_data, "source_folder")
  )


# ============================================================================
# JPG/RAW PAIRING CHECK
# ============================================================================

# Verify that JPG and RAW files are properly paired
pairing_check <- shots |>
  count(file_types, name = "n_shots")

pairing_check |>
  gt() |>
  tab_header(
    title = "JPG/RAW Pairing Summary",
    subtitle = "Each shot should ideally have JPG + RAW"
  )


# ============================================================================
# TIME GAP ANALYSIS (now correctly deduplicated)
# ============================================================================

# Distribution of time gaps between consecutive shots
time_gap_summary <- shots |>
  filter(!is.na(time_gap)) |>
  summarize(
    n_gaps = n(),
    min_gap = min(time_gap),
    q25_gap = quantile(time_gap, 0.25),
    median_gap = median(time_gap),
    q75_gap = quantile(time_gap, 0.75),
    max_gap = max(time_gap),
    gaps_under_0.15s = sum(time_gap < 0.15),  # Within burst at 10fps
    gaps_under_0.5s = sum(time_gap < 0.5),
    gaps_under_2s = sum(time_gap < 2)
  )

time_gap_summary |>
  pivot_longer(everything(), names_to = "Metric", values_to = "Value") |>
  gt() |>
  tab_header(title = "Time Gap Distribution Summary (Shot Level)") |>
  fmt_number(columns = Value, decimals = 3)


# ============================================================================
# TIME GAP VISUALIZATION
# ============================================================================

# Histogram of short gaps (under 5 seconds) - this is where bursts live
p_short_gaps <- shots |>
  filter(!is.na(time_gap), time_gap < 5) |>
  ggplot(aes(x = time_gap)) +
  geom_histogram(binwidth = 0.05, fill = "steelblue", color = "white") +
  geom_vline(xintercept = 0.1, color = "red", linetype = "dashed",
             linewidth = 1) +
  annotate("text", x = 0.15, y = Inf, label = "0.1s (10fps)",
           vjust = 2, hjust = 0, color = "red", size = 3) +
  labs(
    title = "Distribution of Time Gaps Between Consecutive Shots",
    subtitle = "Gaps under 5 seconds (where burst sequences appear)",
    x = "Time gap (seconds)",
    y = "Count"
  ) +
  theme_minimal()

print(p_short_gaps)


# Log-scale view of ALL gaps (to see the full distribution)
p_all_gaps <- shots |>
  filter(!is.na(time_gap), time_gap > 0) |>
  ggplot(aes(x = time_gap)) +
  geom_histogram(bins = 50, fill = "steelblue", color = "white") +
  scale_x_log10(
    breaks = c(0.1, 0.5, 1, 5, 10, 60, 300, 3600),
    labels = c("0.1s", "0.5s", "1s", "5s", "10s", "1min", "5min", "1hr")
  ) +
  labs(
    title = "Distribution of All Time Gaps (Log Scale)",
    subtitle = "Full picture of shooting patterns",
    x = "Time gap (log scale)",
    y = "Count"
  ) +
  theme_minimal()

print(p_all_gaps)


# ============================================================================
# BURST SEQUENCE ANALYSIS (using SequenceNumber)
# ============================================================================

# Summary of burst groups
burst_summary <- shots_with_bursts |>
  group_by(burst_group) |>
  summarize(
    burst_size = first(burst_size),
    start_time = min(timestamp_precise),
    duration_sec = as.numeric(
      difftime(max(timestamp_precise), min(timestamp_precise), units = "secs")
    ),
    method = first(burst_method),
    .groups = "drop"
  ) |>
  filter(burst_size > 1)  # Only show actual bursts, not singletons

# Detection method used
shots_with_bursts |>
  distinct(burst_method) |>
  gt() |>
  tab_header(title = "Burst Detection Method")

# How many burst sequences of each size?
burst_size_dist <- burst_summary |>
  count(burst_size, name = "n_bursts") |>
  arrange(burst_size)

burst_size_dist |>
  gt() |>
  tab_header(
    title = "Burst Sequence Size Distribution",
    subtitle = paste(sum(burst_size_dist$n_bursts), "burst sequences found")
  ) |>
  cols_label(
    burst_size = "Shots in Burst",
    n_bursts = "Number of Bursts"
  )


# Visualization of burst sizes
p_burst_sizes <- burst_size_dist |>
  ggplot(aes(x = factor(burst_size), y = n_bursts)) +
  geom_col(fill = "darkorange") +
  labs(
    title = "Burst Sequence Sizes",
    subtitle = "Number of bursts of each size",
    x = "Number of shots in burst",
    y = "Number of burst sequences"
  ) +
  theme_minimal()

print(p_burst_sizes)


# ============================================================================
# SEQUENCE NUMBER VALIDATION
# ============================================================================

# If we have SequenceNumber, let's see how it correlates with time gaps
if ("SequenceNumber" %in% names(shots_with_bursts) &&
    !all(is.na(shots_with_bursts$SequenceNumber))) {

  # Time gaps within bursts (SequenceNumber > 1) vs between bursts
  gap_by_position <- shots_with_bursts |>
    filter(!is.na(time_gap)) |>
    mutate(
      gap_type = ifelse(SequenceNumber == 1, "Between bursts", "Within burst")
    )

  gap_by_position |>
    group_by(gap_type) |>
    summarize(
      n = n(),
      min_gap = min(time_gap),
      median_gap = median(time_gap),
      max_gap = max(time_gap),
      .groups = "drop"
    ) |>
    gt() |>
    tab_header(
      title = "Time Gaps: Within Burst vs Between Bursts",
      subtitle = "Validates that SequenceNumber aligns with timing"
    ) |>
    fmt_number(columns = c(min_gap, median_gap, max_gap), decimals = 3)

  # Distribution comparison
  p_gap_comparison <- gap_by_position |>
    filter(time_gap < 10) |>
    ggplot(aes(x = time_gap, fill = gap_type)) +
    geom_histogram(binwidth = 0.1, position = "dodge", alpha = 0.7) +
    scale_fill_manual(values = c("Within burst" = "steelblue",
                                  "Between bursts" = "darkorange")) +
    labs(
      title = "Time Gap Distribution by Position Type",
      subtitle = "Within-burst gaps should cluster near 0.1s for 10fps",
      x = "Time gap (seconds)",
      y = "Count",
      fill = "Gap Type"
    ) +
    theme_minimal()

  print(p_gap_comparison)
}


# ============================================================================
# POTENTIAL THINNING IMPACT
# ============================================================================

# If we kept only 1 shot per burst, how many could we thin?
thinning_potential <- shots_with_bursts |>
  summarize(
    total_shots = n(),
    singleton_shots = sum(burst_size == 1),
    shots_in_bursts = sum(burst_size > 1),
    num_bursts = n_distinct(burst_group[burst_size > 1]),
    potential_keepers = singleton_shots + num_bursts,
    potential_thinned = total_shots - potential_keepers,
    thinning_pct = round(100 * potential_thinned / total_shots, 1)
  )

thinning_potential |>
  pivot_longer(everything(), names_to = "Metric", values_to = "Value") |>
  gt() |>
  tab_header(
    title = "Potential Thinning Impact",
    subtitle = "If we kept 1 shot per burst sequence"
  )


# Storage impact
storage_impact <- shots_with_bursts |>
  summarize(
    total_size_gb = sum(total_file_size) / 1e9,
    singleton_size_gb = sum(total_file_size[burst_size == 1]) / 1e9,
    burst_size_gb = sum(total_file_size[burst_size > 1]) / 1e9,
    # Estimate: keep first shot of each burst
    keeper_size_gb = singleton_size_gb +
      sum(total_file_size[burst_position == 1 & burst_size > 1]) / 1e9,
    potential_savings_gb = total_size_gb - keeper_size_gb,
    savings_pct = round(100 * potential_savings_gb / total_size_gb, 1)
  )

storage_impact |>
  pivot_longer(everything(), names_to = "Metric", values_to = "GB") |>
  gt() |>
  tab_header(
    title = "Potential Storage Savings",
    subtitle = "If we kept 1 shot per burst sequence"
  ) |>
  fmt_number(columns = GB, decimals = 2)


# ============================================================================
# EXPOSURE CONSISTENCY (for panorama detection)
# ============================================================================

# Look at exposure settings within burst groups
# Panoramas often have locked/consistent exposure across the sequence
exposure_consistency <- shots_with_bursts |>
  filter(burst_size > 1) |>
  group_by(burst_group) |>
  summarize(
    burst_size = first(burst_size),
    n_unique_aperture = n_distinct(FNumber),
    n_unique_shutter = n_distinct(ExposureTime),
    n_unique_iso = n_distinct(ISO),
    n_unique_focal = n_distinct(FocalLength),
    focal_length = first(FocalLength),
    exposure_locked = n_unique_aperture == 1 &
      n_unique_shutter == 1 &
      n_unique_iso == 1,
    .groups = "drop"
  )

exposure_consistency |>
  count(exposure_locked, name = "n_bursts") |>
  gt() |>
  tab_header(title = "Exposure Consistency in Burst Sequences")


# ============================================================================
# DETAILED VIEW OF BURST SEQUENCES
# ============================================================================

# Show details of a few burst sequences for manual inspection
burst_details <- shots_with_bursts |>
  filter(burst_size > 1) |>
  select(burst_group, burst_position, burst_size, base_name,
         timestamp_precise, time_gap, SequenceNumber,
         FocalLength, FNumber, ISO) |>
  arrange(burst_group, burst_position)

# Show first 30 rows
burst_details |>
  head(30) |>
  gt() |>
  tab_header(
    title = "Sample Burst Sequence Details",
    subtitle = "First 30 shots from burst sequences for inspection"
  ) |>
  fmt_number(columns = time_gap, decimals = 3)


# ============================================================================
# VALIDATE BURST INTEGRITY
# ============================================================================

# First, show breakdown by burst type (if available)
if ("burst_type" %in% names(shots_with_bursts)) {
  burst_type_summary <- shots_with_bursts |>
    filter(burst_size > 1) |>
    distinct(burst_group, burst_type, burst_size) |>
    group_by(burst_type) |>
    summarize(
      n_groups = n(),
      total_shots = sum(burst_size),
      avg_size = round(mean(burst_size), 1),
      .groups = "drop"
    )

  burst_type_summary |>
    gt() |>
    tab_header(
      title = "Grouping Types",
      subtitle = "continuous_burst = camera burst mode; quick_succession = rapid single shots"
    )
}

# Check whether each burst is complete (all shots present) or partial (some missing)
# Only meaningful for continuous_burst type; quick_succession is always "complete"
burst_completeness <- shots_with_bursts |>
  filter(burst_size > 1) |>
  group_by(burst_group) |>
  summarize(
    burst_type = first(burst_type),
    shots_present = n(),
    min_seq = min(burst_position, na.rm = TRUE),
    max_seq = max(burst_position, na.rm = TRUE),
    n_unique_seq = n_distinct(burst_position),
    is_complete = first(burst_complete),
    original_size = first(burst_original_size),
    shots_missing = original_size - shots_present,
    .groups = "drop"
  )

completeness_summary <- burst_completeness |>
  summarize(
    total_bursts = n(),
    complete_bursts = sum(is_complete),
    partial_bursts = sum(!is_complete),
    pct_complete = round(100 * complete_bursts / total_bursts, 1),
    total_missing_shots = sum(pmax(shots_missing, 0))  # Ignore negative values
  )

completeness_summary |>
  pivot_longer(everything(), names_to = "Metric", values_to = "Value") |>
  gt() |>
  tab_header(
    title = "Burst Completeness Summary",
    subtitle = "Complete = all shots present; Partial = some shots previously removed"
  )

# Show partial bursts for context (only continuous_burst type, not quick_succession)
partial_bursts <- burst_completeness |>
  filter(!is_complete, burst_type == "continuous_burst")

if (nrow(partial_bursts) > 0) {
  message("\nPartial bursts (some shots missing):\n")

  partial_bursts |>
    select(burst_group, shots_present, original_size, shots_missing, min_seq, max_seq) |>
    arrange(desc(shots_missing)) |>
    head(15) |>
    gt() |>
    tab_header(
      title = "Partial Burst Details",
      subtitle = "Continuous bursts where some shots have been previously removed"
    ) |>
    cols_label(
      burst_group = "Burst",
      shots_present = "Shots Present",
      original_size = "Original Size",
      shots_missing = "Missing",
      min_seq = "First Seq#",
      max_seq = "Last Seq#"
    )
} else {
  message("\nAll continuous bursts are complete — no shots have been previously removed.\n")
}


# ============================================================================
# PANORAMA SEQUENCE EXPLORATION
# ============================================================================

message("\n========== PANORAMA SEQUENCE EXPLORATION ==========\n")

# First, let's understand orientation distribution
# Orientation values: 1 = landscape, 6 = portrait (rotated 90° CW), 8 = portrait (rotated 90° CCW)
orientation_summary <- shots_with_bursts |>
  mutate(
    orientation_type = case_when(
      Orientation %in% c(6, 8) ~ "Portrait",
      Orientation == 1 ~ "Landscape",
      TRUE ~ paste0("Other (", Orientation, ")")
    )
  ) |>
  count(orientation_type, name = "n_shots")

orientation_summary |>
  gt() |>
  tab_header(title = "Shot Orientation Distribution") |>
  print()


# Extract numeric portion of filename for ordering
# This handles patterns like "A1205704", "R5_09785", "DSC01234", etc.
shots_with_bursts <- shots_with_bursts |>
  mutate(
    file_number = as.integer(str_extract(base_name, "\\d+$"))
  )

# Filter to panorama candidates: portrait orientation, focal length <= 135mm
pano_candidates <- shots_with_bursts |>
  mutate(
    is_portrait = Orientation %in% c(6, 8),
    focal_ok = FocalLength <= 135
  ) |>
  filter(is_portrait & focal_ok)

message("Panorama candidates (portrait + focal ≤ 135mm): ", nrow(pano_candidates), " shots")

if (nrow(pano_candidates) > 0) {

  # Focal length distribution for candidates
  pano_candidates |>
    count(FocalLength, name = "n_shots") |>
    arrange(FocalLength) |>
    gt() |>
    tab_header(title = "Focal Lengths in Panorama Candidates") |>
    print()


  # Sort by FILE NUMBER (not timestamp) to preserve actual shooting order
  pano_candidates <- pano_candidates |>
    arrange(file_number) |>
    mutate(
      # Gap in file numbers to previous candidate
      file_number_gap = file_number - lag(file_number),
      # Time gap (for reference, but not used for grouping)
      pano_time_gap = as.numeric(
        difftime(timestamp_precise, lag(timestamp_precise), units = "secs")
      )
    )

  # File number gap distribution
  pano_gap_summary <- pano_candidates |>
    filter(!is.na(file_number_gap)) |>
    summarize(
      n_gaps = n(),
      consecutive = sum(file_number_gap == 1),
      gap_of_2 = sum(file_number_gap == 2),
      gap_of_3_plus = sum(file_number_gap >= 3),
      pct_consecutive = round(100 * consecutive / n_gaps, 1)
    )

  pano_gap_summary |>
    pivot_longer(everything(), names_to = "Metric", values_to = "Value") |>
    gt() |>
    tab_header(
      title = "File Number Gaps Between Panorama Candidates",
      subtitle = "Consecutive = gap of 1 (immediately following file number)"
    ) |>
    print()


  # ============================================================================
  # IDENTIFY CANDIDATE PANORAMA SEQUENCES (using filename order)
  # ============================================================================

  # Group consecutive panorama candidates by file number
  # Allow small gaps (e.g., gap of 2) to handle occasional non-portrait shot mid-sequence
  max_file_gap <- 2  # Maximum gap in file numbers to consider part of same panorama

  pano_sequences <- pano_candidates |>
    arrange(file_number) |>
    mutate(
      # New panorama sequence starts when file number gap exceeds threshold
      new_pano_seq = is.na(file_number_gap) | file_number_gap > max_file_gap,
      pano_group = cumsum(new_pano_seq)
    ) |>
    group_by(pano_group) |>
    mutate(
      pano_seq_size = n(),
      pano_position = row_number(),
      first_file = min(file_number),
      last_file = max(file_number)
    ) |>
    ungroup()

  # Filter to sequences of 3+ shots (likely panoramas)
  likely_panos <- pano_sequences |>
    filter(pano_seq_size >= 3)

  message("Found ", n_distinct(likely_panos$pano_group),
          " candidate panorama sequences (3+ shots)")


  # Summary of candidate panorama sequences
  pano_seq_summary <- pano_sequences |>
    filter(pano_seq_size >= 3) |>
    group_by(pano_group) |>
    summarize(
      n_shots = n(),
      file_range = paste0(min(file_number), "-", max(file_number)),
      # Exposure consistency
      n_unique_shutter = n_distinct(ExposureTime),
      n_unique_aperture = n_distinct(FNumber),
      n_unique_iso = n_distinct(ISO),
      exposure_locked = n_unique_shutter == 1 & n_unique_aperture == 1,
      iso_range = paste0(min(ISO), "-", max(ISO)),
      focal_length = first(FocalLength),
      .groups = "drop"
    )

  pano_seq_summary |>
    arrange(desc(n_shots)) |>
    select(pano_group, n_shots, file_range, focal_length,
           exposure_locked, iso_range) |>
    gt() |>
    tab_header(
      title = "Candidate Panorama Sequences (by filename order)",
      subtitle = paste("Portrait orientation, focal ≤ 135mm, 3+ consecutive files")
    ) |>
    cols_label(
      pano_group = "Seq#",
      n_shots = "Shots",
      file_range = "File Range",
      focal_length = "Focal",
      exposure_locked = "Exp Locked",
      iso_range = "ISO Range"
    ) |>
    print()


  # ============================================================================
  # CHECK FOR GROUND SHOTS (orientation change after panorama)
  # ============================================================================

  # Look for landscape shots immediately following panorama sequences
  # These could be the "end marker" ground shots

  pano_end_files <- pano_sequences |>
    filter(pano_seq_size >= 3) |>
    group_by(pano_group) |>
    summarize(last_file = max(file_number), .groups = "drop")

  # Find shots that immediately follow panorama sequences
  # Check each panorama's end file against all shots
  potential_ground_shots <- pano_end_files |>
    rowwise() |>
    mutate(
      ground_shots = list(
        shots_with_bursts |>
          filter(file_number > last_file & file_number <= last_file + 2) |>
          filter(Orientation == 1) |>
          select(base_name, file_number, Orientation, FocalLength, ISO)
      )
    ) |>
    unnest(ground_shots, keep_empty = FALSE) |>
    ungroup()

  if (nrow(potential_ground_shots) > 0) {
    potential_ground_shots |>
      select(pano_group, last_file, file_number, base_name, FocalLength, ISO) |>
      gt() |>
      tab_header(
        title = "Potential Ground Shots After Panoramas",
        subtitle = "Landscape orientation shots within 2 files of panorama end"
      ) |>
      cols_label(
        pano_group = "Pano Seq",
        last_file = "Pano Ends At",
        file_number = "Ground Shot",
        base_name = "Filename",
        FocalLength = "Focal",
        ISO = "ISO"
      ) |>
      print()
  } else {
    message("No potential ground shots detected after panorama sequences.")
  }


  # ============================================================================
  # DETAILED VIEW OF LARGEST PANORAMA SEQUENCES
  # ============================================================================

  if (n_distinct(likely_panos$pano_group) > 0) {
    message("\nDetailed view of largest candidate panorama sequences:\n")

    # Get the groups with the most shots
    largest_pano_groups <- pano_seq_summary |>
      arrange(desc(n_shots)) |>
      head(3) |>
      pull(pano_group)

    likely_panos |>
      filter(pano_group %in% largest_pano_groups) |>
      arrange(desc(pano_seq_size), pano_group, pano_position) |>
      select(pano_group, pano_position, base_name, file_number,
             FocalLength, ExposureTime, FNumber, ISO) |>
      gt() |>
      tab_header(
        title = "Largest Panorama Sequence Details",
        subtitle = "Sorted by file number (actual shooting order)"
      ) |>
      print()
  }


  # Exposure consistency breakdown
  exposure_consistency_pano <- pano_seq_summary |>
    count(exposure_locked, name = "n_sequences")

  exposure_consistency_pano |>
    gt() |>
    tab_header(
      title = "Exposure Consistency in Candidate Panoramas",
      subtitle = "Locked = same shutter speed AND aperture throughout"
    ) |>
    print()

} else {
  message("No panorama candidates found (no portrait shots with focal ≤ 135mm)")
}


# ============================================================================
# SAVE EXTRACTED DATA FOR FURTHER ANALYSIS
# ============================================================================

# Save the full extracted data (file level) as CSV
output_file1 <- here::here("data", "exif_extract.csv")
write_csv(exif_data, output_file1)
message("Full EXIF data saved to: ", output_file1)

# Save the consolidated shots
output_file2 <- here::here("data", "shots.csv")
write_csv(shots, output_file2)
message("Shot-level data saved to: ", output_file2)

# Save the shots-with-bursts analysis
output_file3 <- here::here("data", "shots_with_bursts.csv")
write_csv(shots_with_bursts, output_file3)
message("Burst analysis saved to: ", output_file3)
