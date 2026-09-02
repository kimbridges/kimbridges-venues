## paper_data.R -- ch.9, the physical record.
##
## THE SLASHED-ZERO TEST IS RUN HERE, NOT QUOTED. It reads the SOURCE workbook,
## which the errata architecture never edits, so the test is reproducible by
## anyone with the file. Built 2026-09-01.
##
## FINDING 033 REPRODUCES, in the form it was actually stated: a SUBSTITUTION-rate
## test over digit pairs. Original: 0<->8 two hits in 15 substitutions (13.3%),
## controls 1<->7 0/19, 3<->5 0/20, 4<->9 1/39. Re-run here over all failing rows:
## 0<->8 seven hits in 45 (15.6%), and all three controls 0. Same rate, cleaner
## controls. What did NOT reproduce was a PARAPHRASE of it in a planning note
## ("4 of 44 failing rows"), which is a different framing on a different row set.
SC_SOURCE_XLSX <- file.path(SC_DIR, "TwoRed_fuel_June_2014.xlsx")

## Digit-substitution search. A recorded value is re-read with ONE digit changed
## and the pump identity is retested. Substitutions use the value AS RECORDED --
## never a zero-padded rendering of it, which would invent digits that were never
## written and let the mirror test cheat on trailing zeros.
.sub_fixes <- function(rows, from, to) {
  hit <- character(0)
  for (i in seq_len(nrow(rows))) {
    r <- rows[i, ]
    for (f in c("PPG", "Gallons", "Price")) {
      s <- as.character(r[[f]])
      pos <- gregexpr(from, s, fixed = TRUE)[[1]]
      if (pos[1] == -1) next
      for (p in pos) {
        s2 <- s; substr(s2, p, p) <- to
        v <- suppressWarnings(as.numeric(s2)); if (is.na(v)) next
        r2 <- r; r2[[f]] <- v
        if (abs(r2$PPG * r2$Gallons - r2$Price) < 0.01)
          hit <- c(hit, paste(r$City, r$Odometer))
      }
    }
  }
  length(unique(hit))
}

## Finding 033 in its own form: how often does a substitution of this digit PAIR
## repair a row? A pair with a physical story should beat pairs without one.
.pair_rate <- function(rows, a, b) {
  att <- 0; hit <- 0
  for (i in seq_len(nrow(rows))) {
    r <- rows[i, ]
    for (f in c("PPG", "Gallons", "Price")) {
      s <- as.character(r[[f]])
      for (dir in list(c(a, b), c(b, a))) {
        pos <- gregexpr(dir[1], s, fixed = TRUE)[[1]]
        if (pos[1] == -1) next
        for (p in pos) {
          att <- att + 1
          s2 <- s; substr(s2, p, p) <- dir[2]
          v <- suppressWarnings(as.numeric(s2)); if (is.na(v)) next
          r2 <- r; r2[[f]] <- v
          if (abs(r2$PPG * r2$Gallons - r2$Price) < 0.01) hit <- hit + 1
        }
      }
    }
  }
  c(hits = hit, subs = att)
}

paper_data <- function() {
  ## ---- the paper itself ------------------------------------------------
  dir <- file.path(SC_DIR, "Fuel_and_Trip_Logs")
  pdfs <- list.files(dir, pattern = "[.]pdf$", full.names = TRUE)
  pages <- vapply(pdfs, function(p)
             tryCatch(pdftools::pdf_info(p)$pages, error = function(e) NA_integer_),
             integer(1))

  ## ---- the corrected dataset -------------------------------------------
  F <- twored_fuel
  resid <- abs(F$Gallons * F$Price.Gallon - F$Price)

  ## ---- the source workbook, untouched ----------------------------------
  g <- as.data.frame(readxl::read_excel(SC_SOURCE_XLSX, sheet = "Gas Log"))
  names(g)[names(g) == "Price/Gallon"] <- "PPG"
  g <- g[!is.na(g$Odometer) & !is.na(g$Gallons) & !is.na(g$Price) &
         !is.na(g$PPG) & g$Price > 0, ]
  bad <- g[abs(g$Gallons * g$PPG - g$Price) >= 0.01, ]

  controls <- c("1","3","4","5","7","9")
  ctl <- vapply(controls, function(dd) .sub_fixes(bad, dd, "0"), integer(1))

  ## ---- the errata ------------------------------------------------------
  E <- twored_errata
  b <- ifelse(grepl("^(CONFIRMED|RESOLVED|CLOSED|CLEARED|APPLIED|FULLY RESOLVED)", E$status), "settled",
       ifelse(grepl("^(HYPOTHESIS|PROBABLE|PROPOSED)", E$status), "hypothesis",
       ifelse(grepl("^OPEN", E$status), "open",
       ifelse(grepl("^(WITHDRAWN|REJECTED)", E$status), "withdrawn", "documented"))))

  pairs <- rbind(
    `0 and 8` = .pair_rate(bad, "0", "8"),
    `1 and 7` = .pair_rate(bad, "1", "7"),
    `3 and 5` = .pair_rate(bad, "3", "5"),
    `4 and 9` = .pair_rate(bad, "4", "9"))

  list(n_pdf = length(pdfs), n_pages = sum(pages, na.rm = TRUE),
       first = min(as.Date(F$date)), last = max(as.Date(F$date)),
       odo_lo = min(F$Odometer), odo_hi = max(F$Odometer),
       n_rows = nrow(F), n_balance = sum(resid < 0.01), n_fail = sum(resid >= 0.01),
       src_rows = nrow(g), src_fail = nrow(bad),
       permitted = .sub_fixes(bad, "8", "0"),
       forbidden = .sub_fixes(bad, "0", "8"),
       controls_n = length(controls), controls_fix = sum(ctl),
       errata = table(b), pairs = pairs)
}
