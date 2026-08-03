# =============================================================================
# visualization.R
# Graphical representations for cold/warm temperature analysis
# =============================================================================

library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)
library(patchwork)

# --- Color palette ---
cold_color <- "#2166AC"
warm_color <- "#B2182B"
neutral_color <- "#D9D9D9"

#' Stripe plot for a single cold season
#'
#' Shows each day as a colored stripe: blue for cold, red for warm.
#'
#' @param season_data Data frame with date and is_cold columns
#' @param season_label Character label for the season
#' @param threshold Threshold temperature for subtitle
#' @return ggplot object
plot_season_stripes <- function(season_data, season_label, threshold) {
  season_data %>%
    mutate(day_type = ifelse(is_cold, "Cold", "Warm")) %>%
    ggplot(aes(x = date, y = 1, fill = day_type)) +
    geom_tile(width = 1, height = 1) +
    scale_fill_manual(values = c("Cold" = cold_color, "Warm" = warm_color),
                      name = "Day Type") +
    labs(title = paste("Cold Season", season_label),
         subtitle = paste("Threshold:", threshold, "°F"),
         x = "Date", y = NULL) +
    theme_minimal() +
    theme(axis.text.y = element_blank(),
          axis.ticks.y = element_blank(),
          panel.grid = element_blank(),
          legend.position = "bottom")
}


#' Multi-year stripe plot showing all seasons stacked
#'
#' @param analysis_result Output from run_site_analysis()
#' @return ggplot object
plot_all_seasons_stripes <- function(analysis_result) {
  if (nrow(analysis_result$seasons) == 0) return(NULL)
  
  all_data <- list()
  for (i in seq_len(nrow(analysis_result$seasons))) {
    s <- analysis_result$seasons[i, ]
    sdata <- s$season_data[[1]] %>%
      mutate(season_label = s$season_label,
             # Normalize dates to a common axis (day-of-season)
             day_of_season = as.integer(date - min(date)) + 1)
    all_data[[i]] <- sdata
  }
  
  combined <- bind_rows(all_data)
  
  combined %>%
    mutate(day_type = ifelse(is_cold, "Cold", "Warm")) %>%
    ggplot(aes(x = day_of_season, y = season_label, fill = day_type)) +
    geom_tile(height = 0.8) +
    scale_fill_manual(values = c("Cold" = cold_color, "Warm" = warm_color),
                      name = "Day Type") +
    labs(title = "Cold Season Patterns Across Years",
         subtitle = paste("Threshold:", analysis_result$threshold, "°F"),
         x = "Day of Cold Season", y = "Season") +
    theme_minimal() +
    theme(panel.grid = element_blank(),
          legend.position = "bottom")
}


#' Distribution plots for stretch lengths
#'
#' Side-by-side histograms of cold and warm stretch lengths aggregated
#' across all seasons.
#'
#' @param analysis_result Output from run_site_analysis()
#' @return ggplot object
plot_stretch_distributions <- function(analysis_result) {
  cold_lengths <- c()
  warm_lengths <- c()
  
  for (sd in analysis_result$stretch_details) {
    cold_lengths <- c(cold_lengths, sd$cold_stretches$length)
    warm_lengths <- c(warm_lengths, sd$warm_stretches$length)
  }
  
  stretch_df <- bind_rows(
    tibble(length = cold_lengths, type = "Cold Stretch"),
    tibble(length = warm_lengths, type = "Warm Stretch")
  )
  
  if (nrow(stretch_df) == 0) return(NULL)
  
  ggplot(stretch_df, aes(x = length, fill = type)) +
    geom_histogram(binwidth = 1, position = "dodge", alpha = 0.8, color = "white") +
    scale_fill_manual(values = c("Cold Stretch" = cold_color, "Warm Stretch" = warm_color)) +
    labs(title = "Distribution of Stretch Lengths",
         subtitle = paste("Threshold:", analysis_result$threshold, "°F |",
                          "All seasons aggregated"),
         x = "Stretch Length (days)", y = "Frequency", fill = NULL) +
    theme_minimal() +
    theme(legend.position = "bottom")
}


#' Cold-Warm stretch pair heatmap
#'
#' Heatmap showing the frequency of (cold stretch length, subsequent warm
#' stretch length) pairs across all seasons.
#'
#' @param analysis_result Output from run_site_analysis()
#' @param stats_by_season Named list of statistical results per season
#' @return ggplot object
plot_stretch_pair_heatmap <- function(analysis_result, stats_by_season) {
  all_pairs <- list()
  for (sname in names(stats_by_season)) {
    pairs <- stats_by_season[[sname]]$joint_dist$cold_warm_pairs
    if (!is.null(pairs) && nrow(pairs) > 0) {
      all_pairs[[sname]] <- pairs
    }
  }
  
  if (length(all_pairs) == 0) return(NULL)
  
  combined <- bind_rows(all_pairs) %>%
    group_by(cold_length, warm_length) %>%
    summarize(frequency = sum(frequency), .groups = "drop")
  
  ggplot(combined, aes(x = factor(cold_length), y = factor(warm_length), fill = frequency)) +
    geom_tile(color = "white") +
    geom_text(aes(label = frequency), size = 3) +
    scale_fill_gradient(low = "#F7F7F7", high = cold_color) +
    labs(title = "Cold → Warm Stretch Pair Frequencies",
         subtitle = paste("Threshold:", analysis_result$threshold, "°F"),
         x = "Cold Stretch Length (days)",
         y = "Subsequent Warm Stretch Length (days)",
         fill = "Count") +
    theme_minimal()
}


#' Annual summary time series plots
#'
#' Shows season length, number of stretches, and mean stretch lengths over time.
#'
#' @param analysis_result Output from run_site_analysis()
#' @return ggplot object (patchwork composite)
plot_annual_trends <- function(analysis_result) {
  df <- analysis_result$annual_summary
  if (nrow(df) == 0) return(NULL)
  
  p1 <- ggplot(df, aes(x = season_label, y = season_length, group = 1)) +
    geom_line(color = cold_color, linewidth = 1) +
    geom_point(color = cold_color, size = 2) +
    labs(title = "Cold Season Length", y = "Days", x = NULL) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7))
  
  p2 <- ggplot(df, aes(x = season_label, group = 1)) +
    geom_line(aes(y = n_cold_stretches, color = "Cold"), linewidth = 1) +
    geom_point(aes(y = n_cold_stretches, color = "Cold"), size = 2) +
    geom_line(aes(y = n_warm_stretches, color = "Warm"), linewidth = 1) +
    geom_point(aes(y = n_warm_stretches, color = "Warm"), size = 2) +
    scale_color_manual(values = c("Cold" = cold_color, "Warm" = warm_color)) +
    labs(title = "Number of Stretches per Season", y = "Count", x = NULL, color = NULL) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7),
          legend.position = "bottom")
  
  p3 <- ggplot(df, aes(x = season_label, group = 1)) +
    geom_line(aes(y = cold_mean_length, color = "Cold"), linewidth = 1) +
    geom_point(aes(y = cold_mean_length, color = "Cold"), size = 2) +
    geom_line(aes(y = warm_mean_length, color = "Warm"), linewidth = 1) +
    geom_point(aes(y = warm_mean_length, color = "Warm"), size = 2) +
    scale_color_manual(values = c("Cold" = cold_color, "Warm" = warm_color)) +
    labs(title = "Mean Stretch Length", y = "Days", x = NULL, color = NULL) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7),
          legend.position = "bottom")
  
  p1 / p2 / p3 +
    plot_annotation(
      title = "Annual Trends",
      subtitle = paste("Threshold:", analysis_result$threshold, "°F")
    )
}


#' Threshold sensitivity plot
#'
#' Shows how key measures change across a sweep of threshold temperatures.
#'
#' @param sweep_results Output from run_threshold_sweep()
#' @return ggplot object
plot_threshold_sensitivity <- function(sweep_results) {
  summary_rows <- list()
  for (thresh_name in names(sweep_results)) {
    res <- sweep_results[[thresh_name]]
    if (nrow(res$annual_summary) > 0) {
      summary_rows[[thresh_name]] <- tibble(
        threshold          = res$threshold,
        mean_season_length = mean(res$annual_summary$season_length, na.rm = TRUE),
        mean_n_cold        = mean(res$annual_summary$n_cold_stretches, na.rm = TRUE),
        mean_n_warm        = mean(res$annual_summary$n_warm_stretches, na.rm = TRUE),
        mean_cold_stretch  = mean(res$annual_summary$cold_mean_length, na.rm = TRUE),
        mean_warm_stretch  = mean(res$annual_summary$warm_mean_length, na.rm = TRUE)
      )
    }
  }
  
  df <- bind_rows(summary_rows)
  if (nrow(df) == 0) return(NULL)
  
  df_long <- df %>%
    pivot_longer(-threshold, names_to = "measure", values_to = "value") %>%
    mutate(measure = recode(measure,
      mean_season_length = "Mean Season Length (days)",
      mean_n_cold = "Mean # Cold Stretches",
      mean_n_warm = "Mean # Warm Stretches",
      mean_cold_stretch = "Mean Cold Stretch Length",
      mean_warm_stretch = "Mean Warm Stretch Length"
    ))
  
  ggplot(df_long, aes(x = threshold, y = value)) +
    geom_line(color = cold_color, linewidth = 1) +
    geom_point(color = cold_color, size = 2) +
    facet_wrap(~ measure, scales = "free_y", ncol = 2) +
    labs(title = "Threshold Temperature Sensitivity",
         x = "Threshold Temperature (°F)", y = "Value") +
    theme_minimal()
}


#' Markov transition probability plot across seasons
#'
#' @param stats_by_season Named list of statistical results per season
#' @param threshold Threshold temperature for title
#' @return ggplot object
plot_markov_trends <- function(stats_by_season, threshold) {
  rows <- list()
  for (sname in names(stats_by_season)) {
    mkv <- stats_by_season[[sname]]$markov$summary
    if (!is.null(mkv)) {
      mkv$season_label <- sname
      rows[[sname]] <- mkv
    }
  }
  
  if (length(rows) == 0) return(NULL)
  
  df <- bind_rows(rows)
  
  ggplot(df, aes(x = season_label, y = probability, color = transition, group = transition)) +
    geom_line(linewidth = 1) +
    geom_point(size = 2) +
    scale_color_manual(values = c(
      "Cold -> Cold" = cold_color,
      "Cold -> Warm" = "#92C5DE",
      "Warm -> Cold" = "#F4A582",
      "Warm -> Warm" = warm_color
    )) +
    labs(title = "Markov Transition Probabilities Across Seasons",
         subtitle = paste("Threshold:", threshold, "°F"),
         x = NULL, y = "Probability", color = "Transition") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7),
          legend.position = "bottom")
}
