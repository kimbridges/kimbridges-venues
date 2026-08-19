# trip_logs_read.R -- read every TwoRed trip-log CSV into ONE canonical schema.
# Two schemas exist on disk: the 2011/2016 form (start_time/start_temp_F/start_odo/start_city ...)
# and the 2013/2014 form (start/tempA/odoA/from ...). This normalises both; it does not edit them.
trip_logs_read <- function(dir) {
  canon <- c("trip","date","start_time","start_temp_F","start_odo","start_city",
             "end_time","end_temp_F","end_odo","end_city","miles_written",
             "odo_miles","tz_shift_hr","source_page","note")
  map_b <- c(start_time="start", start_temp_F="tempA", start_odo="odoA", start_city="from",
             end_time="finish", end_temp_F="tempB", end_odo="odoB", end_city="to",
             odo_miles="odo_delta")
  fs <- list.files(dir, pattern="^TwoRed_.*trip_log\\.csv$", full.names=TRUE)
  out <- lapply(fs, function(f) {
    z <- utils::read.csv(f, stringsAsFactors=FALSE)
    if (!"start_time" %in% names(z)) for (k in names(map_b)) if (map_b[[k]] %in% names(z)) z[[k]] <- z[[map_b[[k]]]]
    z$trip <- sub("^TwoRed_(.*)_trip_log\\.csv$", "\\1", basename(f))
    for (k in canon) if (!k %in% names(z)) z[[k]] <- NA
    z$schema <- if (any(c("odoA") %in% names(z))) "B(2013/2014)" else "A(2011/2016)"
    z[, c(canon, "schema")]
  })
  d <- do.call(rbind, out)
  hm <- function(s) { s <- trimws(s); ifelse(is.na(s) | !grepl(":", s), NA_real_,
          vapply(strsplit(s, ":"), function(p) as.numeric(p[1]) + as.numeric(p[2])/60, 1)) }
  d$tz_shift_hr[is.na(d$tz_shift_hr)] <- 0
  d$tz_stored <- d$tz_shift_hr
  # TIME ZONES AS A DERIVED LAYER (added 2026-08-19). Kim records LOCAL clock time at each
  # end of a leg, so a leg that crosses a zone has a raw elapsed time that is wrong by the
  # offset. Only the 2011 file ever carried the correction by hand; 16 of 107 legs were wrong.
  # The shift is COMPUTED from a city -> IANA-zone table, not stored per leg, so DST, the
   # Arizona and Saskatchewan no-DST rules and Newfoundland's half hour all fall out for free.
  ctf <- file.path(dir, "TwoRed_city_timezones.csv")
  if (file.exists(ctf)) {
    ct <- utils::read.csv(ctf, stringsAsFactors = FALSE)
    o2h <- function(x) { s <- sign(x); a <- abs(x); s * (a %/% 100 + (a %% 100) / 60) }
    off <- function(city, date) {
      z <- ct$tz[match(city, ct$city)]
      if (is.na(z) || is.na(date)) return(NA_real_)
      o2h(as.numeric(format(as.POSIXct(paste(date, "12:00:00"), tz = z), "%z")))
    }
    calc <- round(mapply(function(a, b, dt) off(b, dt) - off(a, dt),
                         d$start_city, d$end_city, d$date), 2)
    d$tz_computed <- calc
    d$tz_shift_hr <- ifelse(is.na(calc), d$tz_stored, calc)
  } else {
    d$tz_computed <- NA_real_
    warning("no TwoRed_city_timezones.csv -- tz_shift_hr left as stored; cross-zone legs will be wrong")
  }
  d$raw_hours     <- round(hm(d$end_time) - hm(d$start_time), 2)
  d$elapsed_hours <- round(d$raw_hours - d$tz_shift_hr, 2)
  d$odo_miles     <- ifelse(is.na(d$odo_miles), d$end_odo - d$start_odo, d$odo_miles)
  d$gross_mph     <- round(d$odo_miles / d$elapsed_hours, 1)
  d
}
