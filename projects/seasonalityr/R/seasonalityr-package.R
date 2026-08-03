#' seasonalityr: climate seasonality as cue regimes
#'
#' Derive a climate-viewed seasonality from monthly temperature and rainfall:
#' per-site indices, a daylength (photoperiod) channel, a water-balance-gated
#' cue-regime classifier (temperature-, rainfall-, daylength-cued, reactive-rain,
#' cue-poor), and regional regime maps from WorldClim. Companion to the
#' \emph{seasonality} document.
#'
#' @keywords internal
"_PACKAGE"

## Quiet R CMD check for ggplot2 aes() variables and dplyr NSE names.
utils::globalVariables(c(
  "x","y","regime","Tamp","SI","totP","daylamp","cool_frac","m_mean",
  "name","zone","month","tavg","prec","lat","lon"))
