# =============================================================================
# analysis_core.R
# Core analysis functions for cold/warm temperature cycling
# =============================================================================

library(dplyr)
library(lubridate)

#' Classify days as cold or warm based on threshold
#'
#' @param df Data frame with columns: date, tmin (daily minimum temp in F)
#' @param threshold Threshold temperature in Fahrenheit
#' @return df with added column: is_cold (logical)
classify_days <- function(df, threshold) {
  df %>%
    mutate(is_cold = tmin < threshold)
}

#' Identify cold seasons spanning October-March
#'
#' A cold season is labeled by its starting year. For example, cold season 2015
#' spans roughly October 2015 through March 2016. The season boundaries are
#' defined by the first qualifying cluster (>= minimum_start consecutive cold
#' days) and last qualifying cluster (>= minimum_end consecutive cold days).
#'
#' @param df Data frame with columns: date, is_cold
#' @param minimum_start Minimum consecutive cold days to start a season
#' @param minimum_end Minimum consecutive cold days to end a season
#' @return List with: seasons (data frame), excluded (data frame)
identify_cold_seasons <- function(df, minimum_start = 2, minimum_end = 1) {
  
  # Define candidate windows: July 1 of year Y to June 30 of year Y+1
  # This ensures any Oct-Mar cold season falls within one window
  years <- sort(unique(year(df$date)))
  
  seasons_list <- list()
  excluded_list <- list()
  
  for (y in years) {
    # Window: Jul 1 of year y to Jun 30 of year y+1
    window_start <- as.Date(paste0(y, "-07-01"))
    window_end   <- as.Date(paste0(y + 1, "-06-30"))
    
    window_df <- df %>%
      filter(date >= window_start & date <= window_end) %>%
      arrange(date)
    
    if (nrow(window_df) == 0) next
    
    # Find all cold days in this window
    cold_days <- window_df %>% filter(is_cold)
    if (nrow(cold_days) == 0) next
    
    # Compute runs of consecutive cold days
    cold_runs <- find_runs(window_df$is_cold, window_df$date)
    cold_only_runs <- cold_runs %>% filter(value == TRUE)
    
    if (nrow(cold_only_runs) == 0) next
    
    # Find first qualifying cluster (>= minimum_start consecutive cold days)
    qualifying_start <- cold_only_runs %>% filter(length >= minimum_start)
    if (nrow(qualifying_start) == 0) next
    season_start_date <- qualifying_start$start_date[1]
    
    # Find last qualifying cluster (>= minimum_end consecutive cold days)
    qualifying_end <- cold_only_runs %>% filter(length >= minimum_end)
    if (nrow(qualifying_end) == 0) next
    season_end_date <- qualifying_end$end_date[nrow(qualifying_end)]
    
    # The season end must be after the season start
    if (season_end_date < season_start_date) next
    
    # Extract the cold season
    season_df <- window_df %>%
      filter(date >= season_start_date & date <= season_end_date)
    
    season_length <- as.integer(season_end_date - season_start_date) + 1
    
    # Identify excluded cold/warm days outside season boundaries but in window
    # These are cold days before qualifying start or after qualifying end
    excluded_before <- window_df %>%
      filter(is_cold & date < season_start_date) %>%
      mutate(reason = "before qualifying start")
    
    excluded_after <- window_df %>%
      filter(is_cold & date > season_end_date) %>%
      mutate(reason = "after qualifying end")
    
    excluded <- bind_rows(excluded_before, excluded_after)
    
    if (nrow(excluded) > 0) {
      # Group excluded days into stretches
      excluded_stretches <- summarize_excluded(excluded)
      excluded_stretches$season_label <- paste0(y, "-", y + 1)
      excluded_list[[length(excluded_list) + 1]] <- excluded_stretches
    }
    
    seasons_list[[length(seasons_list) + 1]] <- tibble(
      season_label  = paste0(y, "-", y + 1),
      start_date    = season_start_date,
      end_date      = season_end_date,
      season_length = season_length,
      season_data   = list(season_df)
    )
  }
  
  seasons <- bind_rows(seasons_list)
  excluded <- bind_rows(excluded_list)
  
  list(seasons = seasons, excluded = excluded)
}


#' Find runs (stretches) of consecutive identical values
#'
#' @param values Logical vector
#' @param dates Date vector corresponding to values
#' @return Data frame with: value, start_date, end_date, length
find_runs <- function(values, dates) {
  if (length(values) == 0) return(tibble(value = logical(), start_date = as.Date(character()),
                                          end_date = as.Date(character()), length = integer()))
  
  rle_result <- rle(values)
  n <- length(rle_result$lengths)
  
  end_positions <- cumsum(rle_result$lengths)
  start_positions <- c(1, end_positions[-n] + 1)
  
  tibble(
    value      = rle_result$values,
    start_date = dates[start_positions],
    end_date   = dates[end_positions],
    length     = rle_result$lengths
  )
}


#' Summarize excluded cold days into contiguous stretches
#'
#' @param excluded_df Data frame of excluded days with date and reason columns
#' @return Data frame with stretch start, end, duration, reason
summarize_excluded <- function(excluded_df) {
  if (nrow(excluded_df) == 0) return(tibble())
  
  excluded_df <- excluded_df %>% arrange(date)
  
  # Group into contiguous stretches
  excluded_df <- excluded_df %>%
    mutate(gap = c(0, diff(date)),
           group = cumsum(gap > 1))
  
  excluded_df %>%
    group_by(group, reason) %>%
    summarize(
      start_date = min(date),
      end_date   = max(date),
      duration   = n(),
      .groups = "drop"
    ) %>%
    select(-group)
}


#' Analyze stretches within a cold season
#'
#' @param season_data Data frame for one cold season (date, tmin, is_cold)
#' @return List with cold_stretches and warm_stretches summary data frames
analyze_stretches <- function(season_data) {
  runs <- find_runs(season_data$is_cold, season_data$date)
  
  cold_stretches <- runs %>% filter(value == TRUE)
  warm_stretches <- runs %>% filter(value == FALSE)
  
  cold_summary <- if (nrow(cold_stretches) > 0) {
    tibble(
      n_stretches = nrow(cold_stretches),
      min_length  = min(cold_stretches$length),
      max_length  = max(cold_stretches$length),
      mean_length = round(mean(cold_stretches$length), 1)
    )
  } else {
    tibble(n_stretches = 0, min_length = NA, max_length = NA, mean_length = NA)
  }
  
  warm_summary <- if (nrow(warm_stretches) > 0) {
    tibble(
      n_stretches = nrow(warm_stretches),
      min_length  = min(warm_stretches$length),
      max_length  = max(warm_stretches$length),
      mean_length = round(mean(warm_stretches$length), 1)
    )
  } else {
    tibble(n_stretches = 0, min_length = NA, max_length = NA, mean_length = NA)
  }
  
  list(
    cold_summary     = cold_summary,
    warm_summary     = warm_summary,
    cold_stretches   = cold_stretches,
    warm_stretches   = warm_stretches,
    all_runs         = runs
  )
}


#' Run full analysis for a single site and threshold
#'
#' @param df Data frame with date and tmin columns
#' @param threshold Threshold temperature in F
#' @param minimum_start Min consecutive cold days to start season
#' @param minimum_end Min consecutive cold days to end season
#' @return List with all analysis results
run_site_analysis <- function(df, threshold, minimum_start = 2, minimum_end = 1) {
  
  # Classify days
  df <- classify_days(df, threshold)
  
  # Identify cold seasons
  season_result <- identify_cold_seasons(df, minimum_start, minimum_end)
  
  if (nrow(season_result$seasons) == 0) {
    return(list(
      threshold      = threshold,
      minimum_start  = minimum_start,
      minimum_end    = minimum_end,
      classified_data = df,
      seasons        = tibble(),
      excluded       = tibble(),
      annual_summary = tibble(),
      stretch_details = list()
    ))
  }
  
  # Analyze each season
  annual_rows <- list()
  stretch_details <- list()
  
  for (i in seq_len(nrow(season_result$seasons))) {
    s <- season_result$seasons[i, ]
    sdata <- s$season_data[[1]]
    
    stretches <- analyze_stretches(sdata)
    stretch_details[[s$season_label]] <- stretches
    
    annual_rows[[i]] <- tibble(
      season_label       = s$season_label,
      start_date         = s$start_date,
      end_date           = s$end_date,
      season_length      = s$season_length,
      n_cold_stretches   = stretches$cold_summary$n_stretches,
      cold_min_length    = stretches$cold_summary$min_length,
      cold_max_length    = stretches$cold_summary$max_length,
      cold_mean_length   = stretches$cold_summary$mean_length,
      n_warm_stretches   = stretches$warm_summary$n_stretches,
      warm_min_length    = stretches$warm_summary$min_length,
      warm_max_length    = stretches$warm_summary$max_length,
      warm_mean_length   = stretches$warm_summary$mean_length
    )
  }
  
  annual_summary <- bind_rows(annual_rows)
  
  list(
    threshold       = threshold,
    minimum_start   = minimum_start,
    minimum_end     = minimum_end,
    classified_data = df,
    seasons         = season_result$seasons,
    excluded        = season_result$excluded,
    annual_summary  = annual_summary,
    stretch_details = stretch_details
  )
}


#' Run threshold sensitivity sweep
#'
#' @param df Data frame with date and tmin columns
#' @param thresholds Vector of threshold temperatures
#' @param minimum_start Min consecutive cold days to start season
#' @param minimum_end Min consecutive cold days to end season
#' @return List of analysis results, one per threshold
run_threshold_sweep <- function(df, thresholds, minimum_start = 2, minimum_end = 1) {
  results <- list()
  for (thresh in thresholds) {
    cat("  Analyzing threshold:", thresh, "F\n")
    results[[as.character(thresh)]] <- run_site_analysis(df, thresh, minimum_start, minimum_end)
  }
  results
}
