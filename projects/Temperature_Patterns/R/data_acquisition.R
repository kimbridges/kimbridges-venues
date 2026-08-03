# =============================================================================
# data_acquisition.R
# Functions to acquire temperature data from NOAA GHCN-Daily or generate
# synthetic data for testing
# =============================================================================

library(dplyr)
library(lubridate)

#' Fetch GHCN-Daily data from NOAA
#'
#' Requires the `rnoaa` package and a NOAA API token.
#' Token can be obtained at: https://www.ncdc.noaa.gov/cdo-web/token
#'
#' @param station_id GHCN station ID (e.g., "USW00024221" for Eugene, OR)
#' @param start_date Start date as "YYYY-MM-DD"
#' @param end_date End date as "YYYY-MM-DD"
#' @param token NOAA API token
#' @return Data frame with columns: date, tmin (in Fahrenheit)
fetch_ghcn_daily <- function(station_id, start_date, end_date, token) {
  if (!requireNamespace("rnoaa", quietly = TRUE)) {
    stop("Package 'rnoaa' is required. Install with: install.packages('rnoaa')")
  }

  cat("Fetching GHCN-Daily data for station:", station_id, "\n")
  cat("Date range:", start_date, "to", end_date, "\n")

  # GHCN-Daily stores TMIN in tenths of degrees Celsius
  raw <- rnoaa::ncdc(
    datasetid  = "GHCND",
    stationid  = paste0("GHCND:", station_id),
    datatypeid = "TMIN",
    startdate  = start_date,
    enddate    = end_date,
    limit      = 1000,
    token      = token
  )

  # rnoaa may require pagination for long records
  # For > 1000 days, loop in annual chunks
  all_data <- list()
  start <- as.Date(start_date)
  end   <- as.Date(end_date)

  current_start <- start
  while (current_start <= end) {
    current_end <- min(current_start + years(1) - days(1), end)

    result <- tryCatch({
      rnoaa::ncdc(
        datasetid  = "GHCND",
        stationid  = paste0("GHCND:", station_id),
        datatypeid = "TMIN",
        startdate  = as.character(current_start),
        enddate    = as.character(current_end),
        limit      = 1000,
        token      = token
      )
    }, error = function(e) {
      warning("Error fetching data for ", current_start, " to ", current_end, ": ", e$message)
      NULL
    })

    if (!is.null(result) && !is.null(result$data)) {
      all_data[[length(all_data) + 1]] <- result$data
    }

    current_start <- current_end + days(1)
  }

  if (length(all_data) == 0) stop("No data retrieved.")

  combined <- bind_rows(all_data) %>%
    transmute(
      date = as.Date(date),
      tmin_c = value / 10,                  # tenths of C to C
      tmin   = round(tmin_c * 9/5 + 32, 1)  # convert to F
    ) %>%
    select(date, tmin) %>%
    distinct(date, .keep_all = TRUE) %>%
    arrange(date)

  cat("Retrieved", nrow(combined), "daily records.\n")
  combined
}


#' Alternative: Read GHCN-Daily from a pre-downloaded CSV
#'
#' If you have downloaded data from NOAA Climate Data Online
#' (https://www.ncdc.noaa.gov/cdo-web/), this function reads it.
#'
#' @param filepath Path to CSV file
#' @param tmin_col Name of the TMIN column (default "TMIN")
#' @param date_col Name of the date column (default "DATE")
#' @param unit "C" or "F" — the unit of the TMIN values in the file
#' @return Data frame with columns: date, tmin (in Fahrenheit)
read_ghcn_csv <- function(filepath, tmin_col = "TMIN", date_col = "DATE", unit = "F") {
  raw <- read.csv(filepath, stringsAsFactors = FALSE)

  df <- raw %>%
    transmute(
      date = as.Date(.data[[date_col]]),
      tmin = as.numeric(.data[[tmin_col]])
    ) %>%
    filter(!is.na(tmin))

  if (toupper(unit) == "C") {
    df$tmin <- round(df$tmin * 9/5 + 32, 1)
  }

  df %>% arrange(date)
}


#' Generate synthetic temperature data for testing
#'
#' Produces realistic daily minimum temperatures for a Pacific Northwest site.
#' Uses a sinusoidal annual cycle with noise, calibrated to approximate
#' Eugene, Oregon conditions.
#'
#' @param start_year First year of data
#' @param end_year Last year of data
#' @param base_winter_min Mean winter minimum temp (F), default 33 (Eugene-like)
#' @param base_summer_max Mean summer minimum temp (F), default 52
#' @param noise_sd Standard deviation of daily noise (F), default 5
#' @param seed Random seed for reproducibility
#' @return Data frame with columns: date, tmin
generate_synthetic_data <- function(start_year = 2013, end_year = 2024,
                                     base_winter_min = 33, base_summer_max = 52,
                                     noise_sd = 5, seed = 42) {
  set.seed(seed)

  dates <- seq(as.Date(paste0(start_year, "-01-01")),
               as.Date(paste0(end_year, "-12-31")),
               by = "day")

  n <- length(dates)
  day_of_year <- yday(dates)

  # Annual sinusoidal cycle: coldest around Jan 15 (day 15), warmest around Jul 15
  amplitude <- (base_summer_max - base_winter_min) / 2
  mean_temp <- (base_summer_max + base_winter_min) / 2

  # Cosine peaks at 0, so shift to peak cold at day 15
  annual_cycle <- mean_temp - amplitude * cos(2 * pi * (day_of_year - 15) / 365.25)

  # Add autocorrelated noise (weather persistence)
  noise <- numeric(n)
  noise[1] <- rnorm(1, 0, noise_sd)
  for (i in 2:n) {
    noise[i] <- 0.6 * noise[i-1] + rnorm(1, 0, noise_sd * 0.8)
  }

  # Occasional cold snaps (extra cold events in winter)
  cold_snap <- rbinom(n, 1, prob = ifelse(month(dates) %in% c(11, 12, 1, 2, 3), 0.05, 0.001))
  cold_snap_effect <- cold_snap * rnorm(n, -8, 3)

  tmin <- round(annual_cycle + noise + cold_snap_effect, 1)

  tibble(date = dates, tmin = tmin)
}


#' List common GHCN stations along the WA-OR transect
#'
#' Reference table for station selection.
#' @return Data frame of station IDs, names, and approximate coordinates
list_transect_stations <- function() {
  tibble::tribble(
    ~station_id,     ~name,                          ~state, ~lat,   ~lon,
    "USW00024217",   "Seattle-Tacoma Intl AP",       "WA",   47.449, -122.314,
    "USW00024227",   "Olympia Airport",              "WA",   46.969, -122.902,
    "USC00354003",   "Centralia",                    "WA",   46.716, -122.954,
    "USW00024242",   "Portland Intl AP",             "OR",   45.596, -122.609,
    "USW00024232",   "Salem McNary Field",           "OR",   44.905, -123.001,
    "USW00024221",   "Eugene Mahlon Sweet Field",    "OR",   44.121, -123.213,
    "USW00024225",   "Roseburg Regional AP",         "OR",   43.236, -123.355,
    "USW00024284",   "Medford Rogue Valley AP",      "OR",   42.374, -122.874
  )
}
