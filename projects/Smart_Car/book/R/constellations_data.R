## constellations_data.R -- ch.13. Where it drove, and where it slept.
## Built 2026-09-01.
##
## TWO DELIBERATE DESIGN DECISIONS, both to stop the figure claiming more than
## the record holds:
##
## 1. THE DRIVING MAP IS STATE-LEVEL, NOT A SCATTER OF FILL POINTS. The project
##    gazetteer places 78% of TwoRed's fills and only 17% of Creamsicle's, and
##    even after folding in maps::us.cities and maps::canada.cities it is 85%
##    and 40%. A point map drawn from that would show Creamsicle as sparse
##    because of a GAZETTEER gap, not because of anything the car did. The
##    state column is complete for both cars, so state-level coverage is the
##    finest grain the record actually supports.
##
## 2. THE PARKING FIGURE IS A TIMELINE, NOT A MAP (Finding 041). The named
##    holdings -- Eugene, St Louis, Torrance, Mentone -- come from Kim's
##    testimony, not from the data, and there are only a handful. What the
##    record CAN place is when the car was not moving, and for how long.

norm_state <- function(x) {
  x <- toupper(trimws(x)); x[!nzchar(x)] <- NA
  us <- setNames(state.abb, toupper(state.name))
  ca <- c("ALBERTA"="AB", "BRITISH COLUMBIA"="BC", "MANITOBA"="MB",
          "NEW BRUNSWICK"="NB", "NEWFOUNDLAND"="NL",
          "NEWFOUNDLAND AND LABRADOR"="NL", "NOVA SCOTIA"="NS",
          "NORTHWEST TERRITORIES"="NT", "NUNAVUT"="NU", "ONTARIO"="ON",
          "PRINCE EDWARD ISLAND"="PE", "QUEBEC"="QC",
          "SASKATCHEWAN"="SK", "SASKATCHWAN"="SK", "YUKON"="YT")
  lut <- c(us, ca, "DISTRICT OF COLUMBIA"="DC")
  known <- c(state.abb, "DC", unname(ca))
  out <- ifelse(x %in% known, x, lut[x])
  unname(out)
}

CA_PROV <- c("AB","BC","MB","NB","NL","NS","NT","NU","ON","PE","QC","SK","YT")

## The disposition of every state the FUEL log never saw. Each line records HOW
## the state is known, not just that it is. The trip-log entries are the ones
## that only exist because of the scanning experiment in ch.9.
SILENT_STATES <- data.frame(
  state = c("MD", "VT", "DE", "HI", "FL", "RI", "SD"),
  how   = c("trip log", "trip log", "arithmetic", "home", "none", "none", "none"),
  evidence = c(
    "Frostburg, on the sheet photographed earlier in this book",
    "Hartland, on the Penultimate State sheet",
    "a leg too short for any road that avoids it",
    "where the car lives; no mainland log applies",
    "nothing in either log", "nothing in either log", "nothing in either log"),
  stringsAsFactors = FALSE)

constellations_data <- function() {
  tw <- twored_fuel; cr <- cream_fuel
  tw$st <- norm_state(tw$State); cr$st <- norm_state(cr$state)
  stopifnot(!any(is.na(tw$st)), !any(is.na(cr$st)))

  ## ---- the driving constellation -------------------------------------------
  tw_us <- sort(intersect(unique(tw$st), state.abb))
  cr_us <- sort(intersect(unique(cr$st), state.abb))
  us    <- sort(union(tw_us, cr_us))
  prov  <- sort(intersect(unique(c(tw$st, cr$st)), CA_PROV))

  fills <- rbind(data.frame(car = "TwoRed",     st = tw$st, stringsAsFactors = FALSE),
                 data.frame(car = "Creamsicle", st = cr$st, stringsAsFactors = FALSE))
  by_st <- as.data.frame(table(fills$st), stringsAsFactors = FALSE)
  names(by_st) <- c("st", "fills")

  silent <- SILENT_STATES
  silent$fills <- 0L

  ## ---- the parking constellation -------------------------------------------
  os <- read.csv(file.path(SC_DIR, "TwoRed_on_station.csv"), stringsAsFactors = FALSE)
  os$on_station_from <- as.Date(os$on_station_from); os$to <- as.Date(os$to)

  L <- twored_legs
  L$date <- as.Date(L$date)
  first <- min(L$date); last <- max(L$date)
  span <- as.numeric(last - first) + 1
  leg_days <- length(unique(L$date))

  list(
    ## driving
    n_us = length(us), n_tw_us = length(tw_us), n_cr_us = length(cr_us),
    cr_new = setdiff(cr_us, tw_us),          # empty: the second car added nothing
    n_prov = length(prov), prov = prov,
    by_st = by_st, us = us,
    silent = silent,
    n_silent = nrow(silent),
    n_recovered = sum(silent$how %in% c("trip log", "arithmetic")),
    n_never = sum(silent$how == "none"),
    never = silent$state[silent$how == "none"],
    reach = length(us) + sum(silent$how %in% c("trip log", "arithmetic")),

    ## parking
    os = os, n_gaps = nrow(os),
    span = span, first = first, last = last,
    leg_days = leg_days, pct_driving = 100 * leg_days / span,
    gap_days = sum(os$days), pct_parked = 100 * sum(os$days) / span,
    longest_gap = max(os$days), longest_after = os$after[which.max(os$days)],
    gap_miles = sum(os$miles), leg_miles = round(sum(L$odo_miles, na.rm = TRUE)),
    bands = as.data.frame(table(os$band), stringsAsFactors = FALSE),
    n_unlogged = sum(os$band == "unlogged trip (>1500)"),
    unlogged_miles = sum(os$miles[os$band == "unlogged trip (>1500)"]))
}
