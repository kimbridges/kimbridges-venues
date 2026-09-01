## roads_data.R -- ch.6. Two views of ONE instrument: gross mph.
## Built 2026-08-31. Group definitions are stated here rather than stored, so the
## chapter can print the rule it used. Deep South = EITHER endpoint in the six
## Gulf/Atlantic states; Appalachian = BOTH endpoints in the five ridge states.
## Those are the definitions that produced 40.3 vs 38.0, p = 0.42.

ROADS_SOUTH <- c("AL","MS","LA","GA","SC","FL")
ROADS_APPAL <- c("WV","KY","TN","NC","VA")

roads_data <- function() {
  L <- twored_legs
  L$date <- as.Date(L$date)
  L <- L[is.finite(L$gross_mph), ]
  st <- function(x) sub(".* ", "", x)
  L$s <- st(L$start_city); L$e <- st(L$end_city)

  ## (1) the trips, which differ by how the road was BUILT
  tr <- do.call(rbind, lapply(split(L, L$trip), function(d) data.frame(
    trip = d$trip[1], first = min(d$date), n = nrow(d),
    median_mph = round(median(d$gross_mph), 1),
    median_mi  = median(d$odo_miles, na.rm = TRUE),
    stringsAsFactors = FALSE)))
  tr <- tr[order(tr$median_mph), ]

  ## (2) the two kinds of country, which differ by what the road was LIKE
  south <- L[L$s %in% ROADS_SOUTH | L$e %in% ROADS_SOUTH, ]
  appal <- L[L$s %in% ROADS_APPAL & L$e %in% ROADS_APPAL, ]
  grp <- rbind(
    data.frame(group = "Deep South", south[, c("date","start_city","end_city","gross_mph")]),
    data.frame(group = "Appalachia", appal[, c("date","start_city","end_city","gross_mph")]))

  w <- suppressWarnings(wilcox.test(south$gross_mph, appal$gross_mph))
  list(trips = tr, groups = grp,
       n_south = nrow(south), n_appal = nrow(appal),
       med_south = round(median(south$gross_mph), 1),
       med_appal = round(median(appal$gross_mph), 1),
       p = round(w$p.value, 2),
       slow = tr[1, ], fast = tr[nrow(tr), ])
}

## The I-65 tank. Kim dates the tree tunnel to 2014-05-07/08 and the fills place it:
## Atmore AL sits on I-65 at exit 57, and the Atmore -> Trussville tank is I-65 the
## whole way to Birmingham, with the Montgomery overnight inside it.
## ILLUSTRATION ONLY -- one uncontrolled pair inside a signal already ruled
## unsettleable. No coefficient is computed here and none should be.
roads_tanks <- function() {
  F <- twored_fuel; F$date <- as.Date(F$date)
  keys <- c(neworleans = 42827, atmore = 43037, trussville = 43266,
            madisonville = 43462)
  z <- F[match(keys, F$Odometer), c("date","City","State","Odometer","leg_miles","mpg")]
  rownames(z) <- names(keys)
  stopifnot(!any(is.na(z$Odometer)))
  z$mpg <- round(z$mpg, 2)
  week <- F[F$date >= as.Date("2014-05-05") & F$date <= as.Date("2014-05-08"), ]
  list(t = z, n_week = nrow(week),
       lifetime = round(mean(F$mpg[!F$partial_fill & is.finite(F$mpg)], na.rm = TRUE), 2),
       is_lowest = z["trussville","mpg"] == round(min(week$mpg, na.rm = TRUE), 2))
}

## The two Dalton Highway legs, the gravel end of the engineering scale.
roads_dalton <- function() {
  L <- twored_legs; L$date <- as.Date(L$date)
  d <- L[L$date %in% as.Date(c("2013-08-17","2013-08-18")), ]
  stopifnot(nrow(d) == 2)
  d[, c("date","start_city","end_city","odo_miles","elapsed_hours","gross_mph")]
}
