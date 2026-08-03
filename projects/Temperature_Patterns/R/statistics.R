# =============================================================================
# statistics.R
# Statistical tests: Runs test, Markov transition analysis
# =============================================================================

library(dplyr)

#' Wald-Wolfowitz Runs Test
#'
#' Tests whether the sequence of cold/warm days is random.
#' Implemented directly to avoid external package dependencies.
#'
#' @param binary_seq Logical vector (TRUE = cold, FALSE = warm)
#' @return List with: n_runs, n_cold, n_warm, expected_runs, sd_runs, z_stat, p_value
runs_test <- function(binary_seq) {
  n <- length(binary_seq)
  if (n < 2) return(list(n_runs = NA, z_stat = NA, p_value = NA))
  
  n1 <- sum(binary_seq)      # cold days
  n0 <- sum(!binary_seq)     # warm days
  
  if (n1 == 0 || n0 == 0) {
    return(list(n_runs = 1, n_cold = n1, n_warm = n0,
                expected_runs = NA, sd_runs = NA,
                z_stat = NA, p_value = NA,
                interpretation = "All days are the same type; runs test not applicable."))
  }
  
  # Count runs
  runs <- 1 + sum(binary_seq[-1] != binary_seq[-n])
  
  # Expected runs and standard deviation under randomness
  expected <- (2 * n1 * n0) / n + 1
  variance <- (2 * n1 * n0 * (2 * n1 * n0 - n)) / (n^2 * (n - 1))
  sd_runs  <- sqrt(variance)
  
  # Z statistic (continuity corrected)
  z <- (runs - expected) / sd_runs
  p_value <- 2 * pnorm(-abs(z))
  
  interpretation <- if (p_value < 0.05) {
    if (z < 0) {
      "Significantly fewer runs than expected: days tend to cluster (non-random pattern)."
    } else {
      "Significantly more runs than expected: days tend to alternate (non-random pattern)."
    }
  } else {
    "No significant departure from randomness detected."
  }
  
  list(
    n_runs        = runs,
    n_cold        = n1,
    n_warm        = n0,
    expected_runs = round(expected, 2),
    sd_runs       = round(sd_runs, 2),
    z_stat        = round(z, 3),
    p_value       = round(p_value, 4),
    interpretation = interpretation
  )
}


#' Markov Transition Analysis
#'
#' Computes transition probabilities for the four transition types:
#' cold->cold, cold->warm, warm->cold, warm->warm
#'
#' @param binary_seq Logical vector (TRUE = cold, FALSE = warm)
#' @return List with transition_matrix, transition_counts, and summary
markov_analysis <- function(binary_seq) {
  n <- length(binary_seq)
  if (n < 2) return(list(transition_matrix = NULL, summary = "Insufficient data."))
  
  # Count transitions
  from <- binary_seq[-n]
  to   <- binary_seq[-1]
  
  cc <- sum(from & to)        # cold -> cold
  cw <- sum(from & !to)       # cold -> warm
  wc <- sum(!from & to)       # warm -> cold
  ww <- sum(!from & !to)      # warm -> warm
  
  counts <- matrix(c(ww, wc, cw, cc), nrow = 2, byrow = TRUE,
                   dimnames = list(From = c("Warm", "Cold"),
                                   To   = c("Warm", "Cold")))
  
  # Row-normalize to get probabilities
  row_sums <- rowSums(counts)
  probs <- counts
  probs[1, ] <- if (row_sums[1] > 0) counts[1, ] / row_sums[1] else c(NA, NA)
  probs[2, ] <- if (row_sums[2] > 0) counts[2, ] / row_sums[2] else c(NA, NA)
  probs <- round(probs, 3)
  
  list(
    transition_counts = counts,
    transition_probs  = probs,
    summary = tibble(
      transition   = c("Warm -> Warm", "Warm -> Cold", "Cold -> Warm", "Cold -> Cold"),
      count        = c(ww, wc, cw, cc),
      probability  = c(probs[1, 1], probs[1, 2], probs[2, 1], probs[2, 2])
    )
  )
}


#' Joint Distribution of Consecutive Stretch Pairs
#'
#' Characterizes how cold stretches and warm stretches pair together
#' sequentially (cold stretch of length X followed by warm stretch of length Y).
#'
#' @param all_runs Data frame from find_runs() with value, length columns
#' @return Data frame of stretch pair frequencies
joint_stretch_distribution <- function(all_runs) {
  if (nrow(all_runs) < 2) return(tibble())
  
  pairs <- list()
  for (i in seq_len(nrow(all_runs) - 1)) {
    current <- all_runs[i, ]
    next_run <- all_runs[i + 1, ]
    
    pairs[[i]] <- tibble(
      from_type   = ifelse(current$value, "Cold", "Warm"),
      from_length = current$length,
      to_type     = ifelse(next_run$value, "Cold", "Warm"),
      to_length   = next_run$length
    )
  }
  
  pairs_df <- bind_rows(pairs)
  
  # Frequency table of cold->warm pairs (most relevant for sap flow)
  cold_warm_pairs <- pairs_df %>%
    filter(from_type == "Cold" & to_type == "Warm") %>%
    group_by(cold_length = from_length, warm_length = to_length) %>%
    summarize(frequency = n(), .groups = "drop") %>%
    arrange(desc(frequency))
  
  list(
    all_pairs       = pairs_df,
    cold_warm_pairs = cold_warm_pairs
  )
}


#' Run all statistical analyses for a single season
#'
#' @param season_data Data frame for one cold season
#' @param stretch_detail Output from analyze_stretches()
#' @return List of statistical results
run_season_statistics <- function(season_data, stretch_detail) {
  binary_seq <- season_data$is_cold
  
  list(
    runs_test   = runs_test(binary_seq),
    markov      = markov_analysis(binary_seq),
    joint_dist  = joint_stretch_distribution(stretch_detail$all_runs)
  )
}
