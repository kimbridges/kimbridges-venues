#' Validation city set
#'
#' 21 cities with well-known seasonality, used to validate the indices and the
#' cue-regime classifier. Includes the US Southwest desert trio — Las Vegas
#' (Mojave, winter rain), Tucson (Sonoran, bimodal), El Paso (Chihuahuan, summer
#' rain) — plus equatorial, tropical, Mediterranean, continental, and high-latitude
#' anchors.
#'
#' @format A data frame with 21 rows and 4 columns:
#' \describe{
#'   \item{name}{City name}
#'   \item{zone}{Broad climate-zone label}
#'   \item{lat}{Latitude (degrees)}
#'   \item{lon}{Longitude (degrees)}
#' }
#' @source City coordinates; climatology from WorldClim 2.1.
"cities"
