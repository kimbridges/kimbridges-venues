## book_setup.R -- one source of truth for every chapter.
## Sourced by the `setup` chunk at the top of each .qmd.
## Reads ONLY the corrected datasets; the source workbooks are never touched here.

SC_DIR <- normalizePath(file.path(dirname(getwd()), "data"), mustWork = FALSE)
if (!dir.exists(SC_DIR)) SC_DIR <- "G:/My Drive/Projects/Smart_Car/data"

## ---- TwoRed ---------------------------------------------------------------
twored_fuel <- utils::read.csv(file.path(SC_DIR, "TwoRed_fuel_clean.csv"), stringsAsFactors = FALSE)
twored_fuel$date <- as.Date(twored_fuel$date)
twored_fuel <- twored_fuel[order(twored_fuel$Odometer), ]

source(file.path(dirname(SC_DIR), "trip_logs_read.R"))
twored_legs <- trip_logs_read(SC_DIR)   ## 139 legs; tz_shift COMPUTED, never stored (Finding 035)

twored_errata   <- utils::read.csv(file.path(SC_DIR, "TwoRed_log_errata.csv"), stringsAsFactors = FALSE)
twored_timetemp <- utils::read.csv(file.path(SC_DIR, "TwoRed_fuel_timetemp.csv"), stringsAsFactors = FALSE)

## ---- Creamsicle -----------------------------------------------------------
cream_fuel <- utils::read.csv(file.path(SC_DIR, "Creamsicle_fuel_clean.csv"), stringsAsFactors = FALSE)
cream_legs <- utils::read.csv(file.path(SC_DIR, "Creamsicle_trip_clean.csv"), stringsAsFactors = FALSE)

## ---- Fleet ownership ------------------------------------------------------
## Every date here comes from a document in data/<car>/ -- bill of sale, lease
## agreement, lease-end statement, purchase paperwork, registration. NOT from memory.
fleet <- utils::read.csv(file.path(SC_DIR, "fleet_ownership.csv"), stringsAsFactors = FALSE)
fleet$start <- as.Date(fleet$start)
fleet$end   <- as.Date(fleet$end)          ## NA = still owned
fleet$end_eff <- fleet$end; fleet$end_eff[is.na(fleet$end_eff)] <- Sys.Date()
fleet$years <- round(as.numeric(fleet$end_eff - fleet$start) / 365.25, 1)

## ---- Figure defaults ------------------------------------------------------
## A STARTING POINT, not a decision. Change freely -- the only thing that matters
## is that every figure in the book uses the same one, so the set reads as a system.
if (requireNamespace("ggplot2", quietly = TRUE)) {
  theme_smartcar <- function(base_size = 12) {
    ggplot2::theme_minimal(base_size = base_size) +
      ggplot2::theme(
        panel.grid.minor = ggplot2::element_blank(),
        plot.title.position = "plot",
        plot.caption.position = "plot",
        plot.caption = ggplot2::element_text(hjust = 0)
      )
  }
  ggplot2::theme_set(theme_smartcar())
}

## ---- Guards ---------------------------------------------------------------
## Any number printed in the book should come from these objects, not be typed.
stopifnot(nrow(twored_fuel) == 294, nrow(cream_fuel) == 173, nrow(cream_legs) == 86)
