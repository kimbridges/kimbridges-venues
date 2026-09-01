## long_days_data.R -- the chapter-5 table of long driving days.
## Built 2026-08-31. Every figure is DERIVED from twored_legs / twored_fuel,
## never typed. The `story` column records whether Kim has given an account of
## the day; the accounts themselves live in logs/proj_Smart_Car_log.md, verbatim.

long_days_data <- function(threshold = 450) {
  L <- twored_legs
  L$date <- as.Date(L$date)

  ## DISTANCE: prefer the odometer, fall back to what Kim wrote on the sheet.
  ## 2015-07-07 has no end odometer -- 575 is his own written figure, and the
  ## trip margin total checks against it (575 + 316 + 150 = 1,041).
  L$miles <- ifelse(is.na(L$odo_miles), L$miles_written, L$odo_miles)
  L$miles_src <- ifelse(is.na(L$odo_miles), "written", "odometer")

  d <- L[!is.na(L$miles) & L$miles >= threshold, ]
  d <- d[order(-d$miles), ]
  d$rank <- seq_len(nrow(d))

  ## fills made on the day itself -- the only within-day instrument there is
  F <- twored_fuel; F$date <- as.Date(F$date)
  d$fills <- vapply(d$date, function(x) sum(F$date == x), integer(1))

  d[, c("rank","date","trip","start_city","end_city","start_time","end_time",
        "miles","miles_src","elapsed_hours","gross_mph","start_temp_F",
        "end_temp_F","fills","note")]
}

## The early day. 100 miles, out at 04:30, and it belongs in this chapter for a
## reason no distance threshold can see: a long day is a long day by the CLOCK.
long_day_early <- function() {
  L <- twored_legs; L$date <- as.Date(L$date)
  r <- L[L$date == as.Date("2011-06-26"), ]
  stopifnot(nrow(r) == 1)
  r
}

## Within-day segments. The only instrument the record has for what happened
## INSIDE a driving day: the fills, with their times, between the two ends of
## the leg. `tz_gain` is hours gained crossing westward, applied to the segment
## that contains the change.
day_segments <- function(d, tz_gain = 0, tz_seg = NA_integer_) {
  d <- as.Date(d)
  L <- twored_legs; L$date <- as.Date(L$date)
  r <- L[L$date == d, ][1, ]
  stopifnot(!is.na(r$start_odo), !is.na(r$end_odo))
  tt <- twored_timetemp; tt$date <- as.Date(tt$date)
  f <- tt[tt$date == d & !is.na(tt$fill_time), ]
  f <- f[order(f$odometer_key), ]
  pts <- data.frame(
    where = c(r$start_city, f$city, r$end_city),
    time  = c(r$start_time, f$fill_time, r$end_time),
    odo   = c(r$start_odo, f$odometer_key, r$end_odo),
    stringsAsFactors = FALSE)
  hm <- function(x) { p <- as.numeric(strsplit(x, ":")[[1]]); p[1] + p[2] / 60 }
  h <- vapply(pts$time, hm, 0)
  pts$miles <- c(NA, diff(pts$odo))
  pts$hours <- c(NA, round(diff(h), 2))
  if (!is.na(tz_seg)) pts$hours[tz_seg + 1] <- pts$hours[tz_seg + 1] + tz_gain
  pts$mph   <- round(pts$miles / pts$hours, 1)
  pts
}
