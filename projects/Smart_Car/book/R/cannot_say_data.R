## cannot_say_data.R -- ch.14. Where the proof lives.
## Built 2026-09-02.
##
## Kim's thesis, 2026-09-02: "We've shown the things people focus on: MPG, miles per
## day, number of states visited. What people don't see is the superstructure that
## holds these values. They are equally important because this is where trust lies...
## We generally know where to put the expected data. The number of states visited has
## a place in a headline. But where do you put the Florida confirmation data?"
##
## So the chapter's central measurement is the SHAPE of the two kinds of table: the
## one that holds answers, and the one that holds evidence. The first has a column
## for everything expected. In the second, three columns have collapsed into prose,
## because proof cannot be schematised in advance.

.SOUTH_STATED <- c("AL", "MS", "LA", "GA", "SC", "FL")          # ch.6's stated group
.SOUTH_WIDE   <- c(.SOUTH_STATED, "AR", "TN", "NC")             # a defensible alternative

.gc_mi <- function(la1, lo1, la2, lo2) {
  R <- 3958.7613; d <- base::pi / 180
  2 * R * asin(pmin(1, sqrt(sin((la2 - la1) * d / 2)^2 +
      cos(la1 * d) * cos(la2 * d) * sin((lo2 - lo1) * d / 2)^2)))
}

cannot_say_data <- function() {
  ## The book's headline economy figure comes from cost_data(), which is where ch.11
  ## derives it. Do NOT recompute it here: two derivations of one number is exactly
  ## the drift this book is about, and ch.14 opened by printing it as a literal.
  tw_mpg <- { .K <- cost_data(); .K$dec$mpg[.K$dec$car == "TwoRed"] }

  er <- utils::read.csv(file.path(SC_DIR, "TwoRed_log_errata.csv"), stringsAsFactors = FALSE)
  fu <- utils::read.csv(file.path(SC_DIR, "TwoRed_fuel_clean.csv"), stringsAsFactors = FALSE)

  ## ---- the shape of the two tables ----------------------------------------
  ## The point is not that the errata file is untidy. It is that a STATUS column,
  ## which in any ordinary schema is an enum of about five values, holds 48
  ## distinct sentences in 65 rows. Nobody designs that. It happens because the
  ## alternative is losing the reason.
  shape <- data.frame(
    table = c("the answers", "the evidence"),
    file  = c("TwoRed_fuel_clean.csv", "TwoRed_log_errata.csv"),
    rows  = c(nrow(fu), nrow(er)), cols = c(ncol(fu), ncol(er)),
    stringsAsFactors = FALSE)

  free <- sapply(fu, function(c) is.character(c) && length(unique(c)) / length(c) > 0.8)
  prose <- data.frame(
    column = c("basis", "status", "field"),
    distinct = c(length(unique(trimws(er$basis))), length(unique(trimws(er$status))),
                 length(unique(trimws(er$field)))),
    of_rows = nrow(er), stringsAsFactors = FALSE)

  ## which instrument each correction leaned on. My grouping, stated so it can be
  ## disagreed with; the raw `basis` text is in the file.
  kinds <- list("the scans" = "scan|paper",
                "a card statement" = "AMEX|VISA|statement|card",
                "arithmetic" = "arithmetic|identity|pump|=",
                "geography" = "geograph|great.circle|distance|GMaps|gazetteer",
                "Kim's memory" = "Kim|memory|recall",
                "the odometer" = "odometer|odo\\b|clock",
                "spelling" = "spelling")
  cls <- rep(NA_character_, nrow(er))
  for (nm in names(kinds))
    cls[is.na(cls) & grepl(kinds[[nm]], er$basis, ignore.case = TRUE)] <- nm
  cls[is.na(cls)] <- "an argument written out"
  src <- as.data.frame(table(cls), stringsAsFactors = FALSE)
  names(src) <- c("what settled it", "entries")
  src <- src[order(-src$entries), ]

  ## ---- the geography, re-derived from the completed geocode ----------------
  S <- stops_data()
  pool <- unique(S$all[is.finite(S$all$lat), c("k", "lat", "lon")])
  pool <- pool[!duplicated(pool$k), ]
  m <- twored_fuel
  m$st <- norm_state(m$State)
  m$k <- toupper(gsub("[^A-Z0-9]", "", paste0(toupper(m$City), toupper(m$st))))
  m <- merge(m, pool, by = "k", all.x = TRUE, sort = FALSE)
  m <- m[order(m$Odometer), ]
  n <- nrow(m)
  legs <- data.frame(
    from = paste0(m$City[-n], ", ", m$st[-n]), to = paste0(m$City[-1], ", ", m$st[-1]),
    date = m$date[-1], odo = m$Odometer[-1] - m$Odometer[-n],
    straight = .gc_mi(m$lat[-n], m$lon[-n], m$lat[-1], m$lon[-1]),
    stringsAsFactors = FALSE)
  legs$ratio <- legs$odo / legs$straight
  legs <- legs[is.finite(legs$ratio) & legs$straight > 5 & legs$odo > 0, ]

  pick <- function(f, t) legs[legs$from == f & legs$to == t, ][1, ]
  de <- pick("Colonial Heights, VA", "Bellmawr, NJ")
  ri <- pick("Bellmawr, NJ", "Douglas, MA")
  sd <- pick("Douglas, WY", "Bridgeport, NE")
  fl <- pick("New Orleans, LA", "Atmore, AL")

  ## the 2014 trip's own routing distribution, which is what Florida hides inside
  L <- twored_legs; L$date <- as.Date(L$date)
  win <- range(L$date[L$trip == "2014_PenultimateState"])
  trip <- legs[legs$date >= win[1] & legs$date <= win[2], ]

  ## South Dakota: the honest argument is SLACK, not indirectness.
  ## ⛔ The 2026-08-21 claim that this was "the most indirect stretch in sixteen
  ## years" is FALSE and must not be printed: it ranks 60th of 270 legs, and never
  ## first at any straight-line threshold. What survives is that the odometer has
  ## room for the northern road through Chadron AND a dash to the line.
  CHADRON <- c(42.8294, -103.0002)
  D <- c(m$lat[m$City == "Douglas" & m$st == "WY"][1], m$lon[m$City == "Douglas" & m$st == "WY"][1])
  B <- c(m$lat[m$City == "Bridgeport" & m$st == "NE"][1], m$lon[m$City == "Bridgeport" & m$st == "NE"][1])
  via <- .gc_mi(D[1], D[2], CHADRON[1], CHADRON[2]) + .gc_mi(CHADRON[1], CHADRON[2], B[1], B[2])

  ## Florida: the corner, and how far inside the state it is.
  FL_PT <- c(30.983392, -87.571312); FL_LINE <- 31.0
  atmore <- c(m$lat[m$City == "Atmore"][1], m$lon[m$City == "Atmore"][1])

  ## ---- the two statistics that did NOT reproduce ---------------------------
  tt <- twored_timetemp
  Q <- twored_fuel[!twored_fuel$partial_fill & is.finite(twored_fuel$mpg) &
                     is.finite(twored_fuel$leg_miles), ]
  d <- merge(Q, tt[, c("odometer_key", "temp_F")], by.x = "Odometer",
             by.y = "odometer_key", all.x = TRUE)
  d <- d[is.finite(d$temp_F), ]
  d <- d[order(d$date), ]
  temp <- do.call(rbind, lapply(c(94, 125, nrow(d)), function(k) {
    dd <- d[seq_len(min(k, nrow(d))), ]
    a <- summary(stats::lm(mpg ~ temp_F, data = dd))$coefficients[2, ]
    b <- summary(stats::lm(mpg ~ temp_F + leg_miles, data = dd))$coefficients[2, ]
    data.frame(n = nrow(dd), slope = a[1], p = a[4],
               slope_adj = b[1], p_adj = b[4], stringsAsFactors = FALSE) }))
  rownames(temp) <- NULL

  Q$st <- norm_state(Q$State)
  south <- do.call(rbind, lapply(list(stated = .SOUTH_STATED, wide = .SOUTH_WIDE), function(g) {
    Q$south <- Q$st %in% g
    b <- summary(stats::lm(mpg ~ south + leg_miles, data = Q))$coefficients["southTRUE", ]
    data.frame(n_south = sum(Q$south), coef = b[1], p = b[4], stringsAsFactors = FALSE) }))
  south$definition <- c("the six states this book groups as southern",
                        "a wider reading, nine states")
  rownames(south) <- NULL
  cr <- cream_fuel; cr$st <- norm_state(cr$state)

  list(
    tw_mpg = tw_mpg,
    shape = shape, free_text_in_answers = sum(free), prose = prose, src = src,
    er_med_chars = median(nchar(er$basis)), er_max_chars = max(nchar(er$basis)),
    er_over80 = sum(nchar(er$basis) > 80), er_n = nrow(er),
    de = de, ri = ri, sd = sd, fl = fl,
    trip_med = median(trip$ratio), trip_iqr = quantile(trip$ratio, c(.25, .75)),
    rec_med = median(legs$ratio), n_legs = nrow(legs),
    sd_rank = which(order(-legs$ratio) == which(legs$from == "Douglas, WY" &
                                                  legs$to == "Bridgeport, NE")[1]),
    sd_pct = 100 * mean(legs$ratio <= sd$ratio),
    sd_via = via, sd_slack = sd$odo - via,
    chadron_to_line = .gc_mi(CHADRON[1], CHADRON[2], FL_LINE * 0 + 43.0, CHADRON[2]),
    fl_inside = .gc_mi(FL_PT[1], FL_PT[2], FL_LINE, FL_PT[2]),
    fl_from_fill = .gc_mi(FL_PT[1], FL_PT[2], atmore[1], atmore[2]),
    temp = temp, south = south, cr_south = sum(cr$st %in% .SOUTH_WIDE))
}
