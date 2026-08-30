## expeditions_data.R -- chapter 4. Two lists of the same sixteen years, and they disagree.
##
## KIM'S LIST  data/TwoRed_expeditions.csv, transcribed from the master dictionary he wrote
##             around 2015. Fourteen named expeditions through 2015, with his own mileages.
## THE LOG     twored_legs, 13 trips, 139 legs, 2011-2017.
##
## They are NOT the same set, and that is the chapter. Seven of Kim's fourteen have no trip
## log at all -- including the first crossing -- and one (Sedona) is logged as a fragment.
## The gap is DEFINITIONAL, never missing data (the fractal scope boundary): the trip log
## records the long driving, and it was started a year after the driving was.

expeditions_data <- function() {
  stopifnot(exists("twored_legs"), exists("twored_fuel"))

  kim <- utils::read.csv(file.path(SC_DIR, "TwoRed_expeditions.csv"), stringsAsFactors = FALSE)

  L <- twored_legs; L$date <- as.Date(L$date)
  log <- do.call(rbind, lapply(split(L, L$trip), function(z) data.frame(
    trip  = z$trip[1], legs = nrow(z),
    first = min(z$date), last = max(z$date),
    miles_logged = sum(z$odo_miles, na.rm = TRUE),
    ## which fields the record carries for this trip, as a count of legs
    has_time = sum(!is.na(z$start_time)   & !is.na(z$end_time)),
    has_temp = sum(!is.na(z$start_temp_F) & !is.na(z$end_temp_F)),
    has_odo  = sum(!is.na(z$start_odo)    & !is.na(z$end_odo)),
    has_written = sum(!is.na(z$miles_written)),
    stringsAsFactors = FALSE)))
  log <- log[order(log$first), ]; rownames(log) <- NULL
  for (v in c("time","temp","odo","written"))
    log[[paste0("pct_", v)]] <- log[[paste0("has_", v)]] / log$legs

  kim$logged <- !is.na(kim$trip) & nzchar(kim$trip)
  kim <- merge(kim, log[, c("trip","legs","miles_logged")], by = "trip", all.x = TRUE)
  kim <- kim[order(kim$year, kim$name), ]; rownames(kim) <- NULL

  ## the 2010 crossing, which exists ONLY as fuel
  f <- twored_fuel[order(twored_fuel$Odometer), ]
  f$dt <- as.Date(f$date)
  x   <- f[format(f$dt, "%Y") == "2010", ]
  out2010 <- x[x$dt >= as.Date("2010-09-19") & x$dt <= as.Date("2010-11-29"), ]

  list(kim = kim, log = log,
       n_kim = nrow(kim), n_logged = sum(kim$logged), n_unlogged = sum(!kim$logged),
       first_fills   = nrow(out2010),
       first_odo_out = min(out2010$Odometer), first_odo_in = max(out2010$Odometer),
       first_miles   = max(out2010$Odometer) - min(out2010$Odometer),
       first_states  = length(unique(out2010$State)),
       first_days    = as.numeric(max(out2010$dt) - min(out2010$dt)),
       bought_odo    = min(f$Odometer))
}
