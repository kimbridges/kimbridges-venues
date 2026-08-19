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
  d$raw_hours     <- round(hm(d$end_time) - hm(d$start_time), 2)
  d$elapsed_hours <- round(d$raw_hours - d$tz_shift_hr, 2)
  d$odo_miles     <- ifelse(is.na(d$odo_miles), d$end_odo - d$start_odo, d$odo_miles)
  d$gross_mph     <- round(d$odo_miles / d$elapsed_hours, 1)
  d
}
