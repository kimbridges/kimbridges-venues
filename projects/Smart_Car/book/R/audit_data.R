## audit_data.R -- ch.10. The pump identity, with a tolerance that is DERIVED
## from the recorded precision rather than chosen. Built 2026-09-01.
##
## THE BOUND. Cost is printed to the cent, so the product can differ from it by
## up to half a cent by construction. Gallons and $/gal are each recorded to three
## decimals, so each contributes up to 0.0005 of its partner. Per row:
##     bound = 0.005 + gallons*0.0005 + ppg*0.0005
## A residual inside that is arithmetic. A residual outside it is not.
## ⚠ This SUPERSEDES the flat "under half a cent" rule used during the audit. It
## gives the same TwoRed count (281) and it gives it for a reason.

audit_bound <- function(gal, ppg) 0.005 + gal * 0.0005 + ppg * 0.0005

audit_data <- function() {
  F <- twored_fuel
  F$resid <- abs(F$Gallons * F$Price.Gallon - F$Price)
  F$bound <- audit_bound(F$Gallons, F$Price.Gallon)
  F$fails <- F$resid > F$bound

  C <- cream_fuel
  C <- C[!as.logical(C$canada) & is.finite(C$gallons) & is.finite(C$ppg) & is.finite(C$cost), ]
  C$resid <- abs(C$gallons * C$ppg - C$cost)
  C$bound <- audit_bound(C$gallons, C$ppg)
  C$fails <- C$resid > C$bound

  ## the separation: the largest residual that is still arithmetic, against the
  ## smallest one that is not. If those two are close, the instrument is blunt.
  gap <- c(largest_ok = max(F$resid[!F$fails]), smallest_bad = min(F$resid[F$fails]))

  strip <- rbind(
    data.frame(car = "TwoRed", resid = F$resid, bound = F$bound, fails = F$fails),
    data.frame(car = "Creamsicle", resid = C$resid, bound = C$bound, fails = C$fails))

  ## ---- the geography instrument ------------------------------------------
  ## Odometer miles against the great-circle distance between the two towns.
  ## A great-circle distance is a FLOOR: you cannot drive less than it. Every row
  ## here is below its own floor, which is impossible, and the work is deciding
  ## WHY each one is impossible.
  G <- utils::read.csv(file.path(SC_DIR, "TwoRed_geographic_audit.csv"),
                       stringsAsFactors = FALSE)
  G$kind <- ifelse(grepl("^NOT AN ERROR", G$class), "the car did not drive it (a ferry)",
            ifelse(grepl("^GEOCODE", G$class), "the gazetteer put a town in the wrong place",
                   "the odometer reading is suspect"))
  geo <- as.data.frame(table(G$kind), stringsAsFactors = FALSE)
  names(geo) <- c("What it turned out to be", "Rows")
  geo <- geo[order(-geo$Rows), ]

  list(geo = geo, geo_n = nrow(G),
    tw_n = nrow(F), tw_ok = sum(!F$fails), tw_bad = sum(F$fails),
    cr_n = nrow(C), cr_ok = sum(!C$fails), cr_bad = sum(C$fails),
    bound_lo = min(F$bound), bound_hi = max(F$bound), bound_med = median(F$bound),
    gap = gap, ratio = unname(gap[["smallest_bad"]] / gap[["largest_ok"]]),
    tw_fail = F[F$fails, ], cr_fail = C[C$fails, ], strip = strip,
    errata_tw = nrow(twored_errata),
    errata_cr = nrow(utils::read.csv(file.path(SC_DIR, "Creamsicle_corrections_machine.csv"),
                                     stringsAsFactors = FALSE)))
}
