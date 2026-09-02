## cost_data.R -- ch.11. What it cost, and what actually moved the number.
## Built 2026-09-01. Partial fills are excluded throughout: a tank that was not
## filled to the top gives a distance over the wrong denominator, and the record
## flags them. The last TwoRed fill (92.95 mpg on 2.496 gal) is one of these -- a
## tank deliberately run down before the car went on a ship.

cost_data <- function() {
  F <- twored_fuel; C <- cream_fuel
  tw <- F[!F$partial_fill & is.finite(F$mpg) & is.finite(F$leg_miles), ]
  cr <- C[!as.logical(C$canada) & is.finite(C$mpg) & is.finite(C$leg_miles), ]

  ## LIFETIME economy is total miles over total gallons. It is not the mean of the
  ## per-tank figures and it is not their median; a big tank should count for more
  ## than a small one, and only this form does that.
  life <- function(mi, gal) sum(mi, na.rm = TRUE) / sum(gal, na.rm = TRUE)
  tw_life <- life(F$leg_miles, F$Gallons)
  cr_life <- life(C$leg_miles, C$gallons)

  ## COST PER MILE decomposes exactly: (price actually paid per gallon) / (mpg).
  ## That is what lets the chapter say which half of the difference is the car.
  dec <- data.frame(
    car   = c("TwoRed", "Creamsicle"),
    years = c(paste(format(range(as.Date(F$date)), "%Y"), collapse = "-"),
              paste(format(range(as.Date(C$date)), "%Y"), collapse = "-")),
    mpg   = c(tw_life, cr_life),
    paid  = c(sum(F$Price, na.rm = TRUE) / sum(F$Gallons, na.rm = TRUE),
              sum(C$cost,  na.rm = TRUE) / sum(C$gallons, na.rm = TRUE)),
    stringsAsFactors = FALSE)
  dec$per_mile <- dec$paid / dec$mpg

  ## the three questions
  m_len  <- lm(mpg ~ leg_miles, data = tw)
  m_age  <- lm(mpg ~ Odometer,  data = tw)
  m_both <- lm(mpg ~ leg_miles + Odometer, data = tw)

  ## the wheels. The winter-tyre interval changes size, compound AND pressure at
  ## once, so it is dropped rather than modelled.
  w <- tw
  w$wheels <- ifelse(w$Odometer < 13510, "narrow",
              ifelse(w$Odometer >= 34190 & w$Odometer <= 39739, "xice", "wide"))
  w <- w[w$wheels != "xice", ]; w$wide <- as.integer(w$wheels == "wide")
  m_w <- lm(mpg ~ wide + leg_miles, data = w)
  base <- mean(w$mpg[w$wide == 0])
  wpct <- 100 * c(coef(m_w)[["wide"]], confint(m_w)["wide", ]) / base

  list(
    tw = tw, cr = cr, dec = dec,
    tw_n = nrow(tw), cr_n = nrow(cr),
    tw_miles = sum(F$leg_miles, na.rm = TRUE), tw_fuel = sum(F$Price, na.rm = TRUE),
    cr_miles = sum(C$leg_miles, na.rm = TRUE), cr_fuel = sum(C$cost, na.rm = TRUE),
    ratio_cost = dec$per_mile[2] / dec$per_mile[1],
    ratio_paid = dec$paid[2] / dec$paid[1],
    ratio_mpg  = dec$mpg[2] / dec$mpg[1],
    len_per100 = 100 * coef(m_len)[["leg_miles"]],
    len_p = summary(m_len)$coefficients["leg_miles", "Pr(>|t|)"],
    len_r2 = summary(m_len)$adj.r.squared,
    age_per10k = 1e4 * coef(m_age)[["Odometer"]],
    age_p = summary(m_age)$coefficients["Odometer", "Pr(>|t|)"],
    age_adj_per10k = 1e4 * coef(m_both)[["Odometer"]],
    age_adj_p = summary(m_both)$coefficients["Odometer", "Pr(>|t|)"],
    w_n_narrow = sum(w$wide == 0), w_n_wide = sum(w$wide == 1), w_pct = wpct)
}
