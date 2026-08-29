## dwell_data.R -- one row per interval between two CONSECUTIVE FILLS, both cars.
##
## A FINER INSTRUMENT THAN regimes_data(). That one works at the trip level (50
## spans); this one works at the fill level (~350 intervals), which is the only
## resolution at which the SHAPE of the standing time is visible.
##
## ⚠ WHAT AN INTERVAL ACTUALLY MEASURES. It is bounded by fills, so it is time
## between DRINKS, not time ASLEEP. A car that drove 300 miles on the last day of
## a 60-day interval still reads as 60 days here. The miles column is carried so
## that can be checked rather than assumed.
##
## Same-day fills give days = 0 and are DROPPED, not merged: they are refuelling
## within one driving day and carry no standing time. The count dropped is
## reported in attr(, "same_day") per Finding 032 -- a skip count is never silent.

dwell_data <- function() {
  stopifnot(exists("twored_fuel"), exists("cream_fuel"))

  one <- function(d, odo, car) {
    keep <- !is.na(d$date) & !is.na(odo)
    d <- d[keep, ]; o <- odo[keep]
    i <- order(d$date, o); d <- d[i, ]; o <- o[i]
    data.frame(car   = car,
               from  = head(d$date, -1),
               to    = tail(d$date, -1),
               days  = as.numeric(diff(d$date)),
               miles = as.numeric(diff(o)),
               stringsAsFactors = FALSE)
  }

  tw <- one(twored_fuel, twored_fuel$Odometer, "TwoRed")
  cf <- cream_fuel; cf$date <- as.Date(cf$date)
  cs <- one(cf, cf$odometer, "Creamsicle")

  out  <- rbind(tw, cs)
  same <- tapply(out$days == 0, out$car, sum)
  ## ODOMETER-AS-CLOCK GUARD (added 2026-08-28). Sorted by DATE, the odometer must
  ## increase. One Creamsicle row fails: Ely NV dated 2023-04-14 sits 1,410 miles
  ## BELOW a fill dated 2023-03-26, so its date cannot be right. The two intervals
  ## that touch it are meaningless, so they are dropped and the count is reported
  ## rather than silently absorbed (Finding 032). NOT a correction -- the source is
  ## never edited here; see Creamsicle_log_errata.csv once Kim has ruled on it.
  bad <- out$miles < 0
  attr_bad <- sum(bad)
  out <- out[!bad, ]

  out  <- out[is.finite(out$days) & out$days > 0, ]
  out$car    <- factor(out$car, levels = c("TwoRed", "Creamsicle"))
  out$mi_day <- out$miles / out$days
  rownames(out) <- NULL
  attr(out, "same_day") <- same
  attr(out, "backward")  <- attr_bad
  out
}
