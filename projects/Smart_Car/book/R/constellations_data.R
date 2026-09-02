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
## the state is known, and every one of them IS known: the project settled all six
## before this chapter was written, and the detail belongs to the closing chapter
## rather than to this one. NOTHING HERE IS DERIVED FROM THE FUEL LOG -- these are
## the other instruments, which is the whole point.
##
## Kim's rule, stated 2026-09-01, and it governs this table:
##   "I believe in being strict with the data, but circumstances that are clearly
##    explained do count, too."
## Every absence below has a MECHANISM, not an excuse: a stretch too short to need
## fuel, a drive with no station on it, a dash to a line and back.
SILENT_STATES <- data.frame(
  state = c("MD", "VT", "DE", "RI", "SD", "FL"),
  how   = c("the trip log", "two of them", "arithmetic", "arithmetic",
            "arithmetic", "a photograph"),
  evidence = c(
    "Frostburg, on the sheet photographed earlier in this book",
    "Hartland on the sheet, and a restaurant bill in Quechee",
    "a leg too short for any road that avoids it",
    "a leg on the Providence road, ending five miles from the line",
    "the most indirect stretch in sixteen years, out to the line and back",
    "the car, at a named crossroads a mile inside the state"),
  stringsAsFactors = FALSE)

constellations_data <- function() {
  tw <- twored_fuel; cr <- cream_fuel
  tw$st <- norm_state(tw$State); cr$st <- norm_state(cr$state)
  stopifnot(!any(is.na(tw$st)), !any(is.na(cr$st)))

  ## ---- the driving constellation -------------------------------------------
  tw_us <- sort(intersect(unique(tw$st), state.abb))
  cr_us <- sort(intersect(unique(cr$st), state.abb))
  us    <- sort(union(tw_us, cr_us))
  ## Provinces reached, not merely filled in. BC: one road north out of Haines,
  ## plus a second clip of the corner off the Canadian plains (Kim, 2026-09-01).
  ## PE: entered over the Confederation Bridge and left by ferry to Pictou, with a
  ## motel bill at Murray Harbour and the ferry booking both on a VISA statement.
  prov_fill <- sort(intersect(unique(c(tw$st, cr$st)), CA_PROV))
  prov <- sort(union(prov_fill, c("BC", "PE")))

  fills <- rbind(data.frame(car = "TwoRed",     st = tw$st, stringsAsFactors = FALSE),
                 data.frame(car = "Creamsicle", st = cr$st, stringsAsFactors = FALSE))
  by_st <- as.data.frame(table(fills$st), stringsAsFactors = FALSE)
  names(by_st) <- c("st", "fills")

  silent <- SILENT_STATES

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
    n_prov_fill = length(prov_fill), prov_fill = prov_fill,
    by_st = by_st, us = us,
    silent = silent,
    n_silent = nrow(silent),
    ## every drivable state. 48 contiguous + Alaska = 49; Hawaii is where the car
    ## lives and it went there by ship, so it is not a state this car drove to.
    reach = length(us) + nrow(silent),
    n_drivable = 49,
    complete = (length(us) + nrow(silent)) == 49,

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
