## driving_cost_data.R -- the hinge chapter. THREE DAYS THE RECORD CANNOT SEE,
## and the second car's proof that the gap is real rather than assumed.
## Built 2026-09-01. Every figure derived; nothing typed.

CANADIAN_PRAIRIE <- as.Date(c("2014-06-04","2014-06-05","2014-06-06"))

driving_cost_data <- function() {
  L <- twored_legs; L$date <- as.Date(L$date)
  med <- round(median(L$gross_mph, na.rm = TRUE), 1)

  prairie <- L[L$date %in% CANADIAN_PRAIRIE, ]
  stopifnot(nrow(prairie) == 3)

  ## the three days, one per kind of experience the record misses
  pick <- function(d) L[L$date == as.Date(d), ][1, ]
  three <- rbind(
    cbind(what = "stress -- potholes on the Canadian prairie", pick("2014-06-05")),
    cbind(what = "tedium -- the I-65 tree tunnel",             pick("2014-05-08")),
    cbind(what = "pleasure -- the Nebraska frontage road",     pick("2012-05-28")))

  ## ---- the second car measures what the first cannot -------------------
  ## Creamsicle's sheets carry STOPPED time, so gross and net can be compared.
  ## The gap is the size of what a two-point trip log averages away.
  C <- cream_legs
  C <- C[is.finite(C$gross_mph) & is.finite(C$net_mph), ]
  cranes <- C[grepl("rane", C$comment), ][1, ]

  list(med_gross = med,
       prairie = prairie, prairie_med = round(median(prairie$gross_mph), 1),
       three = three,
       n_cream = nrow(C),
       cream_gross = round(median(C$gross_mph), 1),
       cream_net   = round(median(C$net_mph), 1),
       cream_gap   = round(median(C$net_mph) - median(C$gross_mph), 1),
       stop_share  = round(100 * median(C$stop_hours / C$raw_hours, na.rm = TRUE)),
       cranes = cranes)
}
