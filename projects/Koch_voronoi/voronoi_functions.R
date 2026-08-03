# voronoi_functions.R
# ============================================================
# Core engine for Voronoi Tessellation Analysis
# Phase 1: Simulated data  |  Phase 2: Real data (future)
# ============================================================

# --- Package management ---
required_pkgs <- c("deldir", "sf", "tidyverse", "kableExtra", "rmarkdown")
missing <- required_pkgs[!sapply(required_pkgs, requireNamespace, quietly = TRUE)]
if (length(missing) > 0) {
  message("Installing missing packages: ", paste(missing, collapse = ", "))
  install.packages(missing, quiet = TRUE)
}

suppressPackageStartupMessages({
  library(deldir)
  library(sf)
  library(tidyverse)
  library(kableExtra)
})

# Check for LaTeX (needed for PDF output)
if (!requireNamespace("tinytex", quietly = TRUE)) {
  message("Package 'tinytex' not found. Installing...")
  install.packages("tinytex", quiet = TRUE)
}
if (!tinytex::is_tinytex() && Sys.which("pdflatex") == "") {
  message("No LaTeX installation detected. Installing TinyTeX...")
  tinytex::install_tinytex()
}


# ============================================================
# 1. ANCHOR GENERATION
# ============================================================

generate_anchors <- function(n, area_size, min_distance, max_attempts = 50000) {
  ## Overdispersed points via rejection sampling.
  ## Returns tibble with x, y, anchor_id.
  points <- tibble(x = numeric(0), y = numeric(0))
  attempts <- 0L

  while (nrow(points) < n && attempts < max_attempts) {
    cx <- runif(1, 0, area_size)
    cy <- runif(1, 0, area_size)
    attempts <- attempts + 1L

    if (nrow(points) == 0) {
      points <- add_row(points, x = cx, y = cy)
    } else {
      dists <- sqrt((points$x - cx)^2 + (points$y - cy)^2)
      if (all(dists >= min_distance)) {
        points <- add_row(points, x = cx, y = cy)
      }
    }
  }

  if (nrow(points) < n) {
    warning(sprintf(
      "Generated %d of %d anchors after %d attempts. Reduce min_distance or n.",
      nrow(points), n, max_attempts
    ))
  }

  points %>% mutate(anchor_id = row_number())
}


# ============================================================
# 2. SAMPLE GENERATION
# ============================================================

generate_samples <- function(n_total, area_size, mode = "random",
                             cluster_params = list()) {
  ## mode: "random" | "clustered" | "mixed"
  ##
  ## cluster_params (used for clustered/mixed):
  ##   n_clusters       – number of clusters
  ##   avg_spread       – mean spatial SD of point scatter within a cluster
  ##   spread_sd        – variability of spread across clusters
  ##   size_sd_frac     – SD of cluster size as fraction of mean size (default 0.3)
  ##   cluster_fraction – fraction of points in clusters, for "mixed" mode (default 0.7)

  if (mode == "random") {
    return(tibble(
      x = runif(n_total, 0, area_size),
      y = runif(n_total, 0, area_size),
      cluster = NA_integer_
    ))
  }

  # Determine clustered vs random counts
  if (mode == "clustered") {
    n_clustered <- n_total
    n_random    <- 0L
  } else if (mode == "mixed") {
    frac        <- cluster_params$cluster_fraction %||% 0.7
    n_clustered <- round(n_total * frac)
    n_random    <- n_total - n_clustered
  } else {
    stop("mode must be 'random', 'clustered', or 'mixed'")
  }

  clustered_pts <- .generate_clusters(n_clustered, area_size, cluster_params)

  if (n_random > 0) {
    random_pts <- tibble(
      x = runif(n_random, 0, area_size),
      y = runif(n_random, 0, area_size),
      cluster = NA_integer_
    )
    samples <- bind_rows(clustered_pts, random_pts)
  } else {
    samples <- clustered_pts
  }

  samples
}


.generate_clusters <- function(n, area_size, params) {
  ## Internal: generate n points distributed among clusters.
  n_clusters   <- params$n_clusters   %||% 3
  avg_spread   <- params$avg_spread   %||% (area_size * 0.05)
  spread_sd    <- params$spread_sd    %||% (avg_spread * 0.3)
  size_sd_frac <- params$size_sd_frac %||% 0.3

  # Distribute n points among clusters with variability
  avg_size      <- n / n_clusters
  size_sd       <- avg_size * size_sd_frac
  cluster_sizes <- pmax(1L, round(rnorm(n_clusters, avg_size, size_sd)))

  # Reconcile to exact total
  shortfall <- n - sum(cluster_sizes)
  if (shortfall != 0) {
    for (j in seq_len(abs(shortfall))) {
      idx <- if (shortfall > 0) sample(n_clusters, 1) else which.max(cluster_sizes)
      cluster_sizes[idx] <- cluster_sizes[idx] + sign(shortfall)
    }
    cluster_sizes <- pmax(1L, cluster_sizes)
  }
  # Final safety
  if (sum(cluster_sizes) != n) {
    cluster_sizes[which.max(cluster_sizes)] <-
      cluster_sizes[which.max(cluster_sizes)] + (n - sum(cluster_sizes))
  }

  # Cluster centres (uniform random in the area)
  cx <- runif(n_clusters, 0, area_size)
  cy <- runif(n_clusters, 0, area_size)

  pts <- bind_rows(lapply(seq_len(n_clusters), function(i) {
    sp <- max(0.01, rnorm(1, avg_spread, spread_sd))
    tibble(
      x = rnorm(cluster_sizes[i], cx[i], sp),
      y = rnorm(cluster_sizes[i], cy[i], sp),
      cluster = i
    )
  }))

  # Clip to study area
  pts %>%
    mutate(x = pmax(0, pmin(area_size, x)),
           y = pmax(0, pmin(area_size, y)))
}


# ============================================================
# 3. VORONOI TESSELLATION
# ============================================================

compute_voronoi <- function(anchors, area_size) {
  ## Returns list: deldir object, tiles, sf polygons with areas.
  vor   <- deldir(anchors$x, anchors$y,
                  rw = c(0, area_size, 0, area_size))
  tiles <- tile.list(vor)

  polys <- lapply(tiles, function(tile) {
    coords <- cbind(tile$x, tile$y)
    if (!all(coords[1, ] == coords[nrow(coords), ]))
      coords <- rbind(coords, coords[1, ])
    st_polygon(list(coords))
  })

  voronoi_sf <- st_sf(
    cell_id  = seq_along(tiles),
    geometry = st_sfc(polys)
  )
  voronoi_sf$cell_area <- as.numeric(st_area(voronoi_sf))

  list(deldir = vor, tiles = tiles, sf = voronoi_sf)
}


# ============================================================
# 4. CELL ASSIGNMENT  (nearest-anchor ≡ Voronoi membership)
# ============================================================

assign_to_cells <- function(samples, anchors) {
  ## Guaranteed correct: closest anchor defines the Voronoi cell.
  dist_mat <- sqrt(
    outer(samples$x, anchors$x, "-")^2 +
    outer(samples$y, anchors$y, "-")^2
  )
  samples$cell_id <- apply(dist_mat, 1, which.min)
  samples
}


# ============================================================
# 5. STATISTICAL TESTING
# ============================================================

compute_cell_statistics <- function(samples, voronoi_sf, n_samples, area_size) {
  ## Poisson test per cell + chi-squared goodness-of-fit overall.
  total_area       <- area_size^2
  expected_density <- n_samples / total_area

  obs <- samples %>%
    count(cell_id, name = "observed") %>%
    right_join(tibble(cell_id = voronoi_sf$cell_id), by = "cell_id") %>%
    replace_na(list(observed = 0L)) %>%
    arrange(cell_id)

  cell_stats <- voronoi_sf %>%
    left_join(obs, by = "cell_id") %>%
    mutate(
      expected = cell_area * expected_density,
      p_value  = mapply(function(o, a) {
        poisson.test(x = o, T = a, r = expected_density)$p.value
      }, observed, cell_area),
      significant = p_value < 0.05,
      direction = case_when(
        significant & observed > expected ~ "Elevated",
        significant & observed < expected ~ "Depleted",
        TRUE ~ "NS"
      )
    )

  # Chi-squared goodness-of-fit (Monte Carlo if expected counts are small)
  props    <- cell_stats$cell_area / total_area
  chi_test <- tryCatch(
    chisq.test(cell_stats$observed, p = props),
    warning = function(w) {
      chisq.test(cell_stats$observed, p = props,
                 simulate.p.value = TRUE, B = 10000)
    }
  )

  list(
    cell_stats       = cell_stats,
    chi_squared      = chi_test,
    expected_density = expected_density,
    total_area       = total_area
  )
}


# ============================================================
# 6. INTERPRETATION
# ============================================================

generate_interpretation <- function(stats_result) {
  ## Returns a markdown-formatted string of interpretive statements.
  cs  <- stats_result$cell_stats %>% st_drop_geometry()
  chi <- stats_result$chi_squared

  lines <- vapply(seq_len(nrow(cs)), function(i) {
    r <- cs[i, ]
    switch(r$direction,
      "Elevated" = sprintf(
        "Cell %d: Significantly elevated (observed %d, expected %.1f, p = %.3f)",
        r$cell_id, r$observed, r$expected, r$p_value),
      "Depleted" = sprintf(
        "Cell %d: Significantly depleted (observed %d, expected %.1f, p = %.3f)",
        r$cell_id, r$observed, r$expected, r$p_value),
      sprintf(
        "Cell %d: No significant departure (observed %d, expected %.1f, p = %.3f)",
        r$cell_id, r$observed, r$expected, r$p_value)
    )
  }, character(1))

  n_sig <- sum(cs$significant)

  # Chi-squared summary (handle Monte Carlo variant)
  if (is.na(chi$parameter)) {
    chi_line <- sprintf(
      "Chi-squared test (Monte Carlo, B = 10,000): X² = %.2f, p = %.4f",
      chi$statistic, chi$p.value)
  } else {
    chi_line <- sprintf(
      "Chi-squared test: X² = %.2f, df = %d, p = %.4f",
      chi$statistic, chi$parameter, chi$p.value)
  }

  summary_lines <- c(
    "",
    sprintf("**Overall:** %d of %d cells show significant departures (%s = 0.05).",
            n_sig, nrow(cs), "alpha"),
    chi_line
  )

  if (any(cs$expected < 5)) {
    summary_lines <- c(summary_lines,
      "*Note: Some cells have expected counts < 5; chi-squared approximation may be unreliable.*")
  }

  paste(c(lines, summary_lines), collapse = "  \n")
}


# ============================================================
# 7. PLOTTING
# ============================================================

plot_voronoi_analysis <- function(anchors, samples, voronoi, stats_result,
                                  area_size, title = NULL, seed = NULL) {
  ## Annotated Voronoi plot with significance shading.
  cs    <- stats_result$cell_stats %>% st_drop_geometry()
  tiles <- voronoi$tiles

  # Polygon data
  poly_df <- bind_rows(lapply(seq_along(tiles), function(i) {
    tile <- tiles[[i]]
    tibble(x = c(tile$x, tile$x[1]),
           y = c(tile$y, tile$y[1]),
           cell_id = i)
  })) %>%
    left_join(cs %>% select(cell_id, direction), by = "cell_id")

  # Centroid labels
  label_df <- cs %>% mutate(
    cx    = sapply(seq_along(tiles), function(i) mean(tiles[[i]]$x)),
    cy    = sapply(seq_along(tiles), function(i) mean(tiles[[i]]$y)),
    label = sprintf("n=%d\n(e=%.1f)", observed, expected)
  )

  fill_vals <- c("Elevated" = "#D32F2F", "Depleted" = "#1976D2", "NS" = "#E0E0E0")
  fill_labs <- c("Elevated" = "Elevated", "Depleted" = "Depleted", "NS" = "Not significant")

  sub_text <- if (!is.null(seed)) paste("Seed:", seed) else NULL

  ggplot() +
    geom_polygon(data = poly_df,
                 aes(x = x, y = y, group = cell_id, fill = direction),
                 alpha = 0.3, color = "grey30", linewidth = 0.4) +
    scale_fill_manual(values = fill_vals, labels = fill_labs, name = "Status") +
    geom_point(data = samples, aes(x = x, y = y),
               size = 1.2, color = "black", alpha = 0.5) +
    geom_point(data = anchors, aes(x = x, y = y),
               shape = 18, size = 5, color = "#D32F2F") +
    geom_label(data = label_df, aes(x = cx, y = cy, label = label),
               size = 2.8, alpha = 0.75, label.size = 0) +
    coord_fixed(xlim = c(0, area_size), ylim = c(0, area_size), expand = FALSE) +
    theme_minimal(base_size = 10) +
    theme(panel.grid.minor = element_blank(),
          legend.position   = "bottom") +
    labs(title    = title %||% "Voronoi Tessellation Analysis",
         subtitle = sub_text,
         x = "X", y = "Y")
}


# ============================================================
# 8. DISPLAY HELPERS  (used by the Rmd report)
# ============================================================

display_param_table <- function(result) {
  ## Render a nicely formatted parameter table for the PDF report.
  p <- result$params

  param_df <- tibble(
    Parameter = c("Seed", "Area size", "Anchors", "Min. anchor distance",
                  "Sample points", "Sample mode"),
    Value = as.character(c(p$seed, p$area_size, p$n_anchors, p$min_distance,
                           p$n_samples, p$sample_mode))
  )

  if (p$sample_mode != "random") {
    cp <- p$cluster_params
    extra <- tibble(
      Parameter = c("Clusters", "Avg. spread", "Spread SD", "Size SD fraction"),
      Value = as.character(c(
        cp$n_clusters %||% 3,
        cp$avg_spread %||% (p$area_size * 0.05),
        cp$spread_sd  %||% ((cp$avg_spread %||% (p$area_size * 0.05)) * 0.3),
        cp$size_sd_frac %||% 0.3
      ))
    )
    param_df <- bind_rows(param_df, extra)

    if (p$sample_mode == "mixed") {
      param_df <- add_row(param_df,
        Parameter = "Cluster fraction",
        Value     = as.character(cp$cluster_fraction %||% 0.7))
    }
  }

  kable(param_df, format = "latex", booktabs = TRUE, linesep = "") %>%
    kable_styling(position = "center", latex_options = "hold_position",
                  full_width = FALSE)
}


display_stats_table <- function(result) {
  ## Render the cell statistics table for the PDF report.
  stats_df <- result$stats$cell_stats %>%
    st_drop_geometry() %>%
    select(cell_id, cell_area, expected, observed, p_value, direction) %>%
    rename(Cell = cell_id, Area = cell_area, Expected = expected,
           Observed = observed, `p-value` = p_value, Status = direction) %>%
    mutate(Status = recode(Status, "NS" = "—", "Elevated" = "↑ Elevated",
                           "Depleted" = "↓ Depleted"))

  sig_rows <- which(stats_df$Status != "—")

  kt <- kable(stats_df, format = "latex", booktabs = TRUE, linesep = "",
              digits = c(0, 1, 1, 0, 3, NA),
              align = c("c", "r", "r", "r", "r", "l")) %>%
    kable_styling(position = "center", latex_options = "hold_position",
                  full_width = FALSE)

  # Bold significant rows
  for (r in sig_rows) {
    kt <- row_spec(kt, r, bold = TRUE)
  }

  kt
}


# ============================================================
# 9. MASTER RUN FUNCTION
# ============================================================

run_voronoi_analysis <- function(params) {
  ## Execute a complete analysis for one parameter set.
  ## Returns a list with all components needed for reporting.
  set.seed(params$seed)

  anchors <- generate_anchors(
    n            = params$n_anchors,
    area_size    = params$area_size,
    min_distance = params$min_distance
  )

  samples <- generate_samples(
    n_total        = params$n_samples,
    area_size      = params$area_size,
    mode           = params$sample_mode,
    cluster_params = params$cluster_params %||% list()
  )

  voronoi <- compute_voronoi(anchors, params$area_size)
  samples <- assign_to_cells(samples, anchors)

  stats <- compute_cell_statistics(
    samples, voronoi$sf, params$n_samples, params$area_size
  )

  plt <- plot_voronoi_analysis(
    anchors, samples, voronoi, stats,
    area_size = params$area_size,
    title     = params$label,
    seed      = params$seed
  )

  interp <- generate_interpretation(stats)

  list(
    params         = params,
    anchors        = anchors,
    samples        = samples,
    voronoi        = voronoi,
    stats          = stats,
    plot           = plt,
    interpretation = interp
  )
}
