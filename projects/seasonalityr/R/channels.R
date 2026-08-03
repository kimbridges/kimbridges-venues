## The daylength (photoperiod) channel — a pure function of latitude.

## Mid-month day-of-year values used to sample the annual photoperiod cycle.
midmonth_doy <- c(15,46,74,105,135,166,196,227,258,288,319,349)

#' Daylight hours for a latitude and day-of-year
#'
#' @param lat_deg Latitude in degrees (vectorised).
#' @param doy Day of year (1-365).
#' @return Hours of daylight (0-24); clamped at the poles for polar day/night.
#' @export
daylength_hours <- function(lat_deg, doy){
  phi  <- lat_deg*pi/180
  decl <- 23.45*pi/180 * sin(2*pi*(284+doy)/365)   # solar declination (rad)
  x    <- pmin(pmax(-tan(phi)*tan(decl), -1), 1)    # clamp -> polar day/night
  24*acos(x)/pi
}

#' Daylength channel for a latitude
#'
#' @param lat Latitude in degrees.
#' @return A list with `daylamp` (half the annual photoperiod range, hours) and
#'   `peak_month` (month of the longest day). `daylamp` is ~0 at the equator and
#'   grows monotonically poleward — the spine's "universal metronome" cue.
#' @export
daylength_channel <- function(lat){
  dl <- sapply(midmonth_doy, function(d) daylength_hours(lat, d))
  list(daylamp = (max(dl)-min(dl))/2, peak_month = which.max(dl))
}

#' Add the daylength channel to an indices table
#'
#' @param d A data frame of indices that includes a `lat` column.
#' @return `d` with `daylamp` and `dl_peakmon` columns added.
#' @export
add_daylength <- function(d){
  dlc <- lapply(d$lat, daylength_channel)
  d$daylamp    <- sapply(dlc, `[[`, "daylamp")
  d$dl_peakmon <- sapply(dlc, `[[`, "peak_month")
  d
}
