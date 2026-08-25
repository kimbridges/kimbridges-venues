## regimes_data.R -- one row per span of time, both cars, for fig_regimes().
## A SPAN is either a trip or the interval between two consecutive trips.
##
## THE TWO CARS ARE NOT MEASURED THE SAME WAY, and the chapter says so:
##   TwoRed     -- trips are NAMED in her trip log; odometers at both ends of every leg.
##   Creamsicle -- her leg table has no trip names and no odometers, so trips are
##                 DERIVED from a 7-day gap between logged legs, and the interval
##                 odometers are borrowed from the fuel log.

regimes_data <- function(gap_days = 7) {
  stopifnot(exists("twored_legs"), exists("cream_legs"), exists("cream_fuel"))

  ## ---- TwoRed: trips are given ------------------------------------------
  tl <- twored_legs; tl$date <- as.Date(tl$date)
  tb <- do.call(rbind, lapply(split(tl, tl$trip), function(x) data.frame(
    label = x$trip[1], from = min(x$date), to = max(x$date),
    odo_from = min(x$start_odo, na.rm = TRUE), odo_to = max(x$end_odo, na.rm = TRUE),
    stringsAsFactors = FALSE)))
  tb <- tb[order(tb$from), ]
  tw_trip <- data.frame(car = "TwoRed", kind = "trip", label = tb$label,
    days = as.numeric(tb$to - tb$from) + 1, miles = tb$odo_to - tb$odo_from,
    stringsAsFactors = FALSE)
  tw_btwn <- data.frame(car = "TwoRed", kind = "between",
    label = paste("after", head(tb$label, -1)),
    days  = as.numeric(tail(tb$from, -1) - head(tb$to, -1)),
    miles = tail(tb$odo_from, -1) - head(tb$odo_to, -1), stringsAsFactors = FALSE)

  ## ---- Creamsicle: trips must be derived --------------------------------
  cl <- cream_legs; cl$date <- as.Date(cl$date)
  cl <- cl[is.finite(cl$miles) & !is.na(cl$date), ]; cl <- cl[order(cl$date), ]
  grp <- cumsum(c(0, as.numeric(diff(cl$date))) >= gap_days)
  cb <- do.call(rbind, lapply(split(cl, grp), function(x) data.frame(
    from = min(x$date), to = max(x$date), miles = sum(x$miles), stringsAsFactors = FALSE)))
  cb <- cb[order(cb$from), ]
  cs_trip <- data.frame(car = "Creamsicle", kind = "trip", label = format(cb$from),
    days = as.numeric(cb$to - cb$from) + 1, miles = round(cb$miles), stringsAsFactors = FALSE)

  cf <- cream_fuel; cf$date <- as.Date(cf$date); cf <- cf[order(cf$date), ]
  odo_at <- function(dt, side) {
    i <- if (side == "before") suppressWarnings(max(which(cf$date <= dt)))
         else                  suppressWarnings(min(which(cf$date >= dt)))
    if (is.finite(i)) cf$odometer[i] else NA_real_
  }
  f <- head(cb$to, -1); t <- tail(cb$from, -1)
  cs_btwn <- data.frame(car = "Creamsicle", kind = "between", label = format(f),
    days  = as.numeric(t - f),
    miles = vapply(t, odo_at, 0, "after") - vapply(f, odo_at, 0, "before"),
    stringsAsFactors = FALSE)

  out <- rbind(tw_trip, tw_btwn, cs_trip, cs_btwn)
  out <- out[is.finite(out$days) & is.finite(out$miles) & out$days > 0 & out$miles > 0, ]
  out$mi_day <- out$miles / out$days
  rownames(out) <- NULL
  out
}
