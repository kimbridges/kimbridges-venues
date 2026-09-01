## ferries_data.R -- the five sea passages, and what the odometer made of them.
## Built 2026-08-31. Every odometer figure is READ FROM THE RECORD; the water
## distances are Kim's own and are marked as such, because nothing in the fuel
## or trip log measures them.

ferries_data <- function() {
  L <- twored_legs; L$date <- as.Date(L$date)
  d <- data.frame(
    passage = c("Lake Michigan", "Alaska Marine Highway, north",
                "Newfoundland, out", "Newfoundland, back",
                "Alaska Marine Highway, south"),
    from = c("Ludington MI", "Bellingham WA", "North Sydney NS",
             "Port aux Basques NL", "Whittier AK"),
    to   = c("Milwaukee WI", "Haines AK", "Port aux Basques NL",
             "Sydney NS", "Bellingham WA"),
    date = as.Date(c("2012-06-10","2013-08-09","2014-05-25",
                     "2014-05-28","2013-08-27")),
    odo_in  = c(NA, 35979, 46036, 46625, 38284),
    odo_out = c(NA, 35989, 46037, 46625, 38285),
    nights  = c(0, 3, 0, 0, 4),
    stringsAsFactors = FALSE)
  d$odo_miles <- d$odo_out - d$odo_in
  ## the Lake Michigan crossing has no odometer pair: Kim wrote "(ferry)" beside
  ## Milwaukee and the leg's 160 miles are the drive to the Michigan shore.
  d$odo_miles[d$passage == "Lake Michigan"] <- 0
  d <- d[order(d$date), ]
  list(passages = d, n = nrow(d), total_odo = sum(d$odo_miles),
       nights = sum(d$nights))
}

## The tank that contains an ocean. The fill at Lakewood WA after the southbound
## crossing opens in Homer, Alaska: one tank, two coasts, and a Gulf of Alaska in
## the middle of it that cost no fuel at all.
ferry_tank <- function() {
  F <- twored_fuel; F$date <- as.Date(F$date)
  i <- match(38407, F$Odometer); j <- match(38071, F$Odometer)
  stopifnot(!is.na(i), !is.na(j))
  list(open = F[j, c("date","City","State","Odometer")],
       close = F[i, c("date","City","State","Odometer","leg_miles","Gallons","mpg")],
       days = as.integer(F$date[i] - F$date[j]))
}
