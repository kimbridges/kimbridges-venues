# twored_ingest.R -- build the corrected TwoRed fuel dataset
# Reads the SOURCE xlsx and the machine-readable corrections; writes a clean dataset
# with provenance. NEVER edits the source. Built 2026-08-18.

suppressMessages(library(readxl))
BASE <- 'G:/My Drive/Projects/Smart_Car/data'

twored_ingest <- function(apply_hypotheses = FALSE, verbose = TRUE) {
  say <- function(...) if (verbose) cat(...)

  ## 1. SOURCE ---------------------------------------------------------------
  G <- as.data.frame(read_excel(file.path(BASE,'TwoRed_fuel_June_2014.xlsx'), sheet='Gas Log'))
  G <- G[!is.na(G$Odometer) & !is.na(G$Gallons), ]
  n_src <- nrow(G)
  say('source rows: ', n_src, '\n')

  ## 2. CORRECTIONS ----------------------------------------------------------
  X <- read.csv(file.path(BASE,'TwoRed_corrections_machine.csv'), stringsAsFactors=FALSE)
  X <- X[X$tier != 'already_applied', ]
  if (!apply_hypotheses) X <- X[X$tier == 'confirmed', ]
  say('corrections to apply: ', nrow(X), ' (', paste(names(table(X$tier)), table(X$tier), collapse=', '), ')\n')

  ## 3. PROVENANCE COLUMNS ---------------------------------------------------
  G$corrections <- ''; G$corr_source <- ''

  ## 4. APPLY, WITH A GUARD ON EVERY ONE --------------------------------------
  applied <- 0; refused <- character()
  for (i in seq_len(nrow(X))) {
    r <- which(G$Odometer == X$odometer[i])
    if (length(r) != 1) { refused <- c(refused, paste0(X$errata[i],' (odometer matched ',length(r),' rows)')); next }
    cur <- G[[X$field[i]]][r]
    to_date <- function(v) { n <- suppressWarnings(as.numeric(v))
      if (!is.na(n)) return(as.Date(n, origin='1899-12-30'))
      tryCatch(as.Date(as.character(v)), error = function(e) as.Date(NA)) }
    ok <- if (X$field[i] == 'Timestamp') {
            a <- to_date(cur); b <- to_date(X$old_value[i])
            (!is.na(a) && !is.na(b) && a == b) || identical(trimws(as.character(cur)), X$old_value[i])
          } else if (X$field[i] %in% c('City','State','Brand'))
            identical(trimws(as.character(cur)), X$old_value[i])
          else isTRUE(abs(as.numeric(cur) - as.numeric(X$old_value[i])) < 0.0005)
    if (!ok) { refused <- c(refused, paste0(X$errata[i],' (old_value mismatch: sheet has ',cur,')')); next }
    G[[X$field[i]]][r] <- if (X$field[i] %in% c('City','State','Brand','Timestamp'))
                            X$new_value[i] else as.numeric(X$new_value[i])
    G$corrections[r] <- trimws(paste(G$corrections[r], paste0(X$errata[i],':',X$field[i])))
    G$corr_source[r] <- trimws(paste(G$corr_source[r], X$source[i], sep='; '))
    applied <- applied + 1
  }
  say('applied: ', applied, ' | REFUSED: ', length(refused), '\n')
  if (length(refused)) for (m in refused) say('   refused -> ', m, '\n')
  stopifnot(applied + length(refused) == nrow(X))

  ## 4b. INSERTS -- rows the sheet lost entirely (e.g. a merged row being split) -------
  I <- read.csv(file.path(BASE,'TwoRed_inserts.csv'), stringsAsFactors=FALSE, check.names=FALSE)
  for (k in seq_len(nrow(I))) {
    if (I$Odometer[k] %in% G$Odometer) { say('insert ', I$errata[k], ' SKIPPED (already present)\n'); next }
    nr <- G[1, ]; nr[1, ] <- NA
    for (f in c('Timestamp','City','State','Brand','Price/Gallon','Odometer','Gallons','Price'))
      nr[[f]] <- I[[f]][k]
    nr$corrections <- paste0(I$errata[k],':ROW_INSERTED'); nr$corr_source <- I$source[k]
    G <- rbind(G, nr); say('inserted row: ', I$City[k], ' @ ', I$Odometer[k], '\n')
  }

  ## 4c. EXPLICIT FLAGS -- judgements that are not field edits ------------------------
  FL <- read.csv(file.path(BASE,'TwoRed_flags.csv'), stringsAsFactors=FALSE)

  ## 5. DERIVED FIELDS --------------------------------------------------------
  G$date <- as.Date(as.numeric(G$Timestamp), origin='1899-12-30')
  G$date[is.na(G$date)] <- as.Date(G$Timestamp[is.na(G$date)])
  G <- G[order(G$Odometer), ]                       # ORDER BY THE COUNTER (Finding 032)
  G$leg_miles <- c(NA, diff(G$Odometer))
  G$mpg       <- round(G$leg_miles / G$Gallons, 2)
  G$pump_resid<- round(G$Price - G$Gallons * G$`Price/Gallon`, 2)
  G$partial_fill <- (G$Gallons < 3.5 & G$`Price/Gallon` > 0) |
                    G$Odometer %in% FL$odometer[FL$flag=='partial_fill']

  ## 6. FLAGS THAT ARE NOT CORRECTIONS ----------------------------------------
  G$odometer_unsourced <- G$Odometer == 6469        # L21: no value on the paper
  G$units_caution      <- G$date >= as.Date('2014-05-24') & G$date <= as.Date('2014-06-07')  # L28

  say('rows out: ', nrow(G), ' (in ', n_src, ')\n')
  say(paste0('  (', n_src, ' source + ', nrow(G)-n_src, ' inserted)\n'))
  stopifnot(nrow(G) >= n_src)              # rows may be ADDED, never silently lost (Finding 032)
  G
}
