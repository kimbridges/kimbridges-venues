# creamsicle_ingest.R -- read the exported Google Sheet and emit clean, tidy data.
# Same architecture as twored_ingest.R: the SOURCE IS NEVER EDITED. Kim keeps running totals and
# averages interleaved inside the data region between trip segments; those rows are SKIPPED here,
# programmatically, and the count of what was skipped is REPORTED (Finding 032 -- any filter that
# drops rows must say how many).
creamsicle_ingest <- function(path, apply_hypotheses = FALSE, verbose = TRUE) {
  say <- function(...) if (verbose) cat(...)
  rd  <- function(sh) { z <- suppressMessages(readxl::read_excel(path, sheet = sh,
                          col_names = FALSE, .name_repair = "minimal"))
                        z <- as.data.frame(z, stringsAsFactors = FALSE)
                        names(z) <- paste0("c", seq_len(ncol(z))); z }
  ser <- function(v) { n <- suppressWarnings(as.numeric(v))
                       ifelse(!is.na(n) & n > 40000 & n < 50000,
                              format(as.Date(n, origin = "1899-12-30"), "%Y-%m-%d"), NA_character_) }
  hm  <- function(v) { n <- suppressWarnings(as.numeric(v))
                       ok <- !is.na(n) & n >= 0 & n < 1
                       out <- ifelse(ok, sprintf("%02d:%02d", floor(n*24), round((n*24 %% 1)*60)), NA)
                       # some cells are already text like "9:30"
                       txt <- grepl("^\\d{1,2}:\\d{2}", trimws(v))
                       out[is.na(out) & txt] <- sub("^(\\d{1,2}):(\\d{2}).*$", "\\1:\\2", trimws(v[is.na(out) & txt]))
                       out }
  nm  <- function(v) suppressWarnings(as.numeric(v))

  ## ---- FUEL ----------------------------------------------------------------
  F <- rd("Fuel_Log"); nF <- nrow(F)
  F$date <- ser(F$c1)
  keep <- !is.na(F$date)
  say("Fuel_Log: ", nF, " rows read | ", sum(keep), " data | ", nF - sum(keep),
      " skipped (headers, totals, averages, blanks)\n", sep = "")
  fuel <- data.frame(
    date = F$date[keep], fill_time = hm(F$c2[keep]), city = trimws(F$c3[keep]),
    state = trimws(F$c4[keep]), odometer = nm(F$c5[keep]), brand = trimws(F$c6[keep]),
    gallons = nm(F$c7[keep]), ppg = nm(F$c8[keep]), cost = nm(F$c9[keep]),
    distance_sheet = nm(F$c10[keep]), mpg_sheet = nm(F$c11[keep]),
    litres = nm(F$c15[keep]), cad_per_l = nm(F$c16[keep]), cad = nm(F$c17[keep]),
    stringsAsFactors = FALSE)

  ## ---- CORRECTIONS ---------------------------------------------------------
  ## Added 2026-08-28. The SOURCE IS NEVER EDITED: corrections live beside it in
  ## Creamsicle_corrections_machine.csv and are applied here, with the same guard
  ## twored_ingest() uses -- a correction that cannot find its row is a BUG, not a
  ## no-op. Entries key to the ODOMETER, never to a label. Only tier == "confirmed"
  ## is applied by default; the arithmetic hypotheses (C01-C03) stay documented and
  ## UNAPPLIED until a card or receipt settles them.
  fuel$corrections <- ""; fuel$corr_source <- ""
  mp <- file.path(dirname(path), "..", "Creamsicle_corrections_machine.csv")
  if (!file.exists(mp)) mp <- file.path(dirname(dirname(path)), "Creamsicle_corrections_machine.csv")
  applied <- 0L; refused <- character()
  if (file.exists(mp)) {
    X <- utils::read.csv(mp, stringsAsFactors = FALSE, colClasses = "character")
    if (!apply_hypotheses) X <- X[X$tier == "confirmed", , drop = FALSE]
    for (i in seq_len(nrow(X))) {
      r <- which(fuel$odometer == as.numeric(X$odometer[i]))
      if (length(r) != 1) {
        refused <- c(refused, sprintf("%s (odometer matched %d rows)", X$errata[i], length(r))); next }
      cur <- fuel[[X$field[i]]][r]
      ok <- if (X$field[i] %in% c("date", "fill_time", "city", "state", "brand"))
              identical(trimws(as.character(cur)), X$old_value[i])
            else isTRUE(abs(as.numeric(cur) - as.numeric(X$old_value[i])) < 0.0005)
      if (!ok) {
        refused <- c(refused, sprintf("%s (old_value mismatch: sheet has %s)", X$errata[i], cur)); next }
      fuel[[X$field[i]]][r] <- if (X$field[i] %in% c("date","fill_time","city","state","brand"))
                                 X$new_value[i] else as.numeric(X$new_value[i])
      fuel$corrections[r] <- trimws(paste(fuel$corrections[r], paste0(X$errata[i], ":", X$field[i])))
      fuel$corr_source[r] <- trimws(paste(fuel$corr_source[r], X$source[i], sep = "; "))
      applied <- applied + 1L
    }
    say("corrections: ", applied, " applied | ", length(refused), " REFUSED\n")
    for (m in refused) say("   refused -> ", m, "\n")
    stopifnot(applied + length(refused) == nrow(X))
  }

  fuel <- fuel[order(fuel$odometer), ]                       # ORDER BY THE COUNTER (Finding 032)
  fuel$leg_miles <- c(NA, diff(fuel$odometer))
  fuel$mpg  <- round(fuel$leg_miles / fuel$gallons, 2)
  fuel$pump_resid <- round(fuel$gallons * fuel$ppg - fuel$cost, 3)
  fuel$canada <- !is.na(fuel$litres)
  stopifnot(nrow(fuel) == sum(keep))

  ## ---- INSTRUMENT 7: THE ODOMETER AS A CLOCK -------------------------------
  ## Added 2026-08-28. Sorted by DATE, the odometer must increase. The other six
  ## instruments take the date as GIVEN, so none of them can see a wrong date --
  ## and note that the sort on line above is BY ODOMETER, which masks this class
  ## by construction. Found the Ely 2023-04-14 typo (C04). Reported, never silent.
  ord  <- order(as.Date(fuel$date), fuel$odometer)
  back <- which(diff(fuel$odometer[ord]) < 0)
  if (length(back)) {
    say("*** ODOMETER-AS-CLOCK: ", length(back), " backward step(s) -- a DATE is wrong\n")
    for (k in back) say("    ", fuel$date[ord][k+1], " ", fuel$city[ord][k+1],
                        " odo ", fuel$odometer[ord][k+1], "\n")
  } else say("odometer-as-clock: clean\n")
  attr(fuel, "backward_dates") <- length(back)

  ## ---- TRIP (Trip_Log + Pickup) --------------------------------------------
  one <- function(sh) { T <- rd(sh); T$date <- ser(T$c1); k <- !is.na(T$date)
    say(sh, ": ", nrow(T), " rows read | ", sum(k), " data | ", nrow(T) - sum(k), " skipped\n", sep = "")
    data.frame(date = T$date[k], lv_time = hm(T$c2[k]), lv_city = trimws(T$c3[k]),
               lv_state = trimws(T$c4[k]), ar_time = hm(T$c5[k]), ar_city = trimws(T$c6[k]),
               ar_state = trimws(T$c7[k]), miles = nm(T$c8[k]),
               stop_sheet = if (ncol(T) >= 10) trimws(T$c10[k]) else NA,
               mph_sheet  = if (ncol(T) >= 13) nm(T$c13[k]) else NA,
               comment    = if (ncol(T) >= 14) trimws(T$c14[k]) else NA,
               sheet = sh, stringsAsFactors = FALSE) }
  trip <- do.call(rbind, lapply(c("Pickup", "Trip_Log"), one))
  trip <- trip[!duplicated(paste(trip$date, trip$lv_time, trip$lv_city)), ]
  trip <- trip[order(trip$date, trip$lv_time), ]
  h <- function(s) { p <- suppressWarnings(as.numeric(strsplit(s, ":")[[1]])); p[1] + p[2]/60 }
  trip$raw_hours <- round(mapply(function(a, b)
                     if (is.na(a) || is.na(b)) NA_real_ else h(b) - h(a), trip$lv_time, trip$ar_time), 2)
  list(fuel = fuel, trip = trip)
}
