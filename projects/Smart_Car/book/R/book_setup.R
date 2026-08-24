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

## ---- Fleet residency -----------------------------------------------------
## One row per (car, residency phase). Only TwoRed has two phases: it was bought
## in San Diego and shipped to Honolulu in May 2017. Every start/end is sourced
## in the `source` column of the CSV. NA end = still ours.
residency <- utils::read.csv(file.path(SC_DIR, "fleet_residency.csv"),
                             stringsAsFactors = FALSE)
residency$start   <- as.Date(residency$start)
residency$end     <- as.Date(residency$end)
residency$ongoing <- is.na(residency$end)
residency$end_eff <- residency$end
residency$end_eff[residency$ongoing] <- Sys.Date()
residency$years   <- as.numeric(residency$end_eff - residency$start) / 365.25
## row order: cars top-to-bottom by acquisition date -> reverse for ggplot y
.ord <- fleet$car[order(fleet$start)]
residency$label <- factor(residency$label,
  levels = rev(c("TwoRed","TwoFer","Bordeaux","Creamsicle")))
## the interval with no car on the mainland
mainland_gap <- c(start = max(residency$end_eff[residency$where == "Mainland" &
                                                residency$start < as.Date("2018-01-01")]),
                  end   = min(residency$start[residency$where == "Mainland" &
                                              residency$start > as.Date("2018-01-01")]))

## TwoRed crossed the Pacific once, and both ends of the crossing are on the
## Matson shipping receipt (BK 9811942, voyage 377, vessel MHI, SEA -> HON).
## The far end is an ESTIMATED availability date, not a record of pickup.
voyage <- c(depart = as.Date("2017-05-22"), available = as.Date("2017-06-09"))
voyage_days <- as.integer(voyage[["available"]] - voyage[["depart"]])

## ---- TwoRed, as measured -------------------------------------------------
## TWO SOURCES, AND THEY DISAGREE ON ONE DIMENSION.
## (a) Matson shipping receipt, unit 11907531 -- the carrier measured the BODY for
##     stowage, rounded to whole inches.
## (b) 2010 smart fortwo owner's manual, "Main dimensions (model passion)" -- supplied
##     by Kim 2026-08-22.
## Length and height agree to within a rounding tick. Width differs by exactly 8.0 in,
## 4 in a side. RESOLVED 2026-08-22 (Kim, from the manual): the manual footnotes its
## width as measured WITH THE MIRRORS FOLDED OUT. Both figures are correct; they are
## measuring different objects. Use twored_dim (body) for anything about fitting the
## car into a space, twored_manual for the car as specified.
twored_dim <- c(length_in = 8 * 12 + 10, width_in = 5 * 12 + 1,
                height_in = 5 * 12 + 0, weight_lb = 1808)          ## (a) carrier, body
twored_manual <- c(length_in = 106.1, width_in = 69.0, height_in = 60.7,
                   wheelbase_in = 73.5, track_front_in = 50.5,
                   track_rear_in = 54.5, turning_circle_ft = 28.7)  ## (b) owner's manual
twored_overhang_in <- twored_manual[["length_in"]] - twored_manual[["wheelbase_in"]]
twored_pair_ft <- (2 * twored_dim[["length_in"]]) %/% 12
twored_pair_in <- (2 * twored_dim[["length_in"]]) %%  12

## ---- Rear compartment ----------------------------------------------------
## MEASURED BY KIM ON TwoRed WITH A TAPE, 2026-08-24. These are the PRACTICAL
## dimensions -- what actually fits -- not the size of the rear opening. Depth is
## taken back to the driver's seat in the position he drives in, so it is a usable
## figure rather than a specification.
##
## NO VOLUME IS RECORDED, deliberately. Fill the compartment and the rear window is
## blocked, so cubic feet is not the binding constraint -- the mirror is. The earlier
## pasted figures (27.5 x 39.5-41 x 21-23 in; 7.8 / 12 cu ft) are RETIRED: they had no
## source, and their depth was an inch short of what Kim measures.
boot_dim <- list(width_in = 41, height_in = 27, depth_in = 24,
                 depth_ref = "to the driver's seat, in the position he drives in")

## ---- Figure functions ----------------------------------------------------
## Every R/fig_*.R defines one fig_<name>() returning a ggplot. Chapters call them.
for (.f in list.files(file.path(dirname(SC_DIR), "book/R"), pattern = "^fig_.*[.]R$",
                      full.names = TRUE)) source(.f)
rm(.f)

## ---- Guards ---------------------------------------------------------------
## Any number printed in the book should come from these objects, not be typed.
stopifnot(nrow(twored_fuel) == 294, nrow(cream_fuel) == 173, nrow(cream_legs) == 86)
