# run_phase1.R
# ============================================================
# USER CONTROL SCRIPT — Phase 1 Voronoi Tessellation Analysis
#
# Edit the 'runs' list below to define your analysis scenarios.
# Then source this file or run it in RStudio: the PDF report
# will be generated automatically.
#
# Files required in the working directory:
#   voronoi_functions.R
#   phase1_report.Rmd
#   _run_section.Rmd
# ============================================================

source("voronoi_functions.R")

# ============================================================
# DEFINE YOUR RUNS
# ============================================================
# Each run is a list with these fields:
#
#   label         – descriptive name (appears in the report)
#   seed          – for reproducibility
#   n_anchors     – number of anchor points
#   area_size     – side length of the square study area
#   min_distance  – minimum distance between anchors
#   n_samples     – total number of sample points
#   sample_mode   – "random", "clustered", or "mixed"
#   cluster_params (optional, for clustered/mixed modes):
#     n_clusters       – number of clusters
#     avg_spread       – mean spatial SD of each cluster
#     spread_sd        – variability in spread across clusters
#     size_sd_frac     – SD of cluster size as fraction of mean (default 0.3)
#     cluster_fraction – fraction in clusters, for "mixed" mode (default 0.7)
# ============================================================

runs <- list(

  # --- Run 1: Baseline random ---
  list(
    label        = "Random samples (baseline)",
    seed         = 674,
    n_anchors    = 5,
    area_size    = 10,
    min_distance = 2,
    n_samples    = 50,
    sample_mode  = "random"
  ),

  # --- Run 2: Tightly clustered ---
  list(
    label        = "Clustered samples — 3 tight clusters",
    seed         = 674,
    n_anchors    = 5,
    area_size    = 10,
    min_distance = 2,
    n_samples    = 50,
    sample_mode  = "clustered",
    cluster_params = list(
      n_clusters   = 3,
      avg_spread   = 0.4,
      spread_sd    = 0.12,
      size_sd_frac = 0.3
    )
  ),

  # --- Run 3: Loose clusters ---
  list(
    label        = "Clustered samples — 3 diffuse clusters",
    seed         = 674,
    n_anchors    = 5,
    area_size    = 10,
    min_distance = 2,
    n_samples    = 50,
    sample_mode  = "clustered",
    cluster_params = list(
      n_clusters   = 3,
      avg_spread   = 1.5,
      spread_sd    = 0.4,
      size_sd_frac = 0.3
    )
  ),

  # --- Run 4: Mixed — 70% clustered, 30% random ---
  list(
    label        = "Mixed: 70% clustered, 30% random",
    seed         = 674,
    n_anchors    = 5,
    area_size    = 10,
    min_distance = 2,
    n_samples    = 50,
    sample_mode  = "mixed",
    cluster_params = list(
      n_clusters       = 3,
      avg_spread       = 0.5,
      spread_sd        = 0.15,
      size_sd_frac     = 0.3,
      cluster_fraction = 0.7
    )
  ),

  # --- Run 5: Scaled up — more anchors, bigger area ---
  list(
    label        = "Scaled: 10 anchors, 20×20 area, 200 samples",
    seed         = 674,
    n_anchors    = 10,
    area_size    = 20,
    min_distance = 3,
    n_samples    = 200,
    sample_mode  = "clustered",
    cluster_params = list(
      n_clusters   = 5,
      avg_spread   = 1.0,
      spread_sd    = 0.3,
      size_sd_frac = 0.4
    )
  ),

  # --- Run 6: Many small clusters ---
  list(
    label        = "6 small clusters, high variability",
    seed         = 674,
    n_anchors    = 7,
    area_size    = 15,
    min_distance = 2.5,
    n_samples    = 120,
    sample_mode  = "clustered",
    cluster_params = list(
      n_clusters   = 6,
      avg_spread   = 0.6,
      spread_sd    = 0.3,
      size_sd_frac = 0.5
    )
  )
)


# ============================================================
# RUN ALL ANALYSES
# ============================================================

cat(sprintf("Running %d analyses...\n", length(runs)))
all_results <- lapply(seq_along(runs), function(i) {
  cat(sprintf("  [%d/%d] %s\n", i, length(runs), runs[[i]]$label))
  run_voronoi_analysis(runs[[i]])
})

# Save results (Rmd loads this file)
saveRDS(all_results, "phase1_results.rds")
cat("Results saved to phase1_results.rds\n")


# ============================================================
# GENERATE PDF REPORT
# ============================================================

cat("Generating PDF report...\n")
rmarkdown::render(
  input       = "phase1_report.Rmd",
  params      = list(results_file = "phase1_results.rds"),
  output_file = "phase1_report.pdf",
  quiet       = TRUE
)
cat("Done! Report saved as: phase1_report.pdf\n")
