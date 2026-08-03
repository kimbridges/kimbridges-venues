## Per-site seasonality indices from monthly temperature + rainfall.

## Rainfall-seasonality floor below which timing/modality are not meaningful.
SI_FLOOR <- 0.40

#' Retrieve WorldClim monthly normals at points
#'
#' Downloads (once, then caches) WorldClim 2.1 monthly mean temperature and
#' precipitation and extracts them at each site's coordinates.
#'
#' @param cities A data frame with columns `name`, `zone`, `lat`, `lon`.
#' @param res WorldClim resolution in arc-minutes (default 10).
#' @param path Cache directory for the downloaded rasters.
#' @return A tidy tibble with `name`, `zone`, `month` (1-12), `tavg`, `prec`.
#' @importFrom terra extract
#' @export
get_climate <- function(cities, res = 10, path = file.path(tempdir(), "wc_cache")) {
  dir.create(path, showWarnings = FALSE, recursive = TRUE)
  tavg <- geodata::worldclim_global("tavg", res = res, path = path)
  prec <- geodata::worldclim_global("prec", res = res, path = path)
  pts  <- cbind(cities$lon, cities$lat)
  Tm <- terra::extract(tavg, pts)
  Pm <- terra::extract(prec, pts)
  purrr::map_dfr(seq_len(nrow(cities)), function(i) {
    tibble::tibble(name = cities$name[i], zone = cities$zone[i], month = 1:12,
                   tavg = as.numeric(Tm[i, ]), prec = as.numeric(Pm[i, ]))
  })
}

#' Seasonality indices for one site
#'
#' @param P Numeric length-12 vector of monthly precipitation (mm).
#' @param T Numeric length-12 vector of monthly mean temperature (deg C).
#' @return A one-row tibble: `Tamp` (temperature seasonality, half annual range),
#'   `SI` (Walsh-Lawler rainfall seasonality index), `cool_frac` (fraction of rain
#'   in the 6 coldest months), `bimod` (gated 2nd/1st rainfall-harmonic ratio),
#'   `totP` (annual rainfall), `m_mean` (mean Walter-Lieth moisture curve P - 2T).
#' @export
compute_indices <- function(P, T) {
  P <- as.numeric(P); T <- as.numeric(T); R <- sum(P)
  SI   <- sum(abs(P - R / 12)) / R
  Tamp <- (max(T) - min(T)) / 2
  cold6 <- order(T)[1:6]
  cool_frac <- sum(P[cold6]) / R
  ft <- stats::fft(P); A1 <- Mod(ft[2]); A2 <- Mod(ft[3])
  bimod <- if (A1 > 1e-9 && SI >= SI_FLOOR) A2 / A1 else 0
  tibble::tibble(Tamp = Tamp, SI = SI, cool_frac = cool_frac, bimod = bimod,
                 totP = R, m_mean = mean(P - 2 * T))
}

#' Index table for many sites
#'
#' @param clim A tidy climate tibble from [get_climate()].
#' @return One row of indices per site (see [compute_indices()]).
#' @export
indices_table <- function(clim) {
  clim |> dplyr::arrange(name, month) |>
    dplyr::group_by(name, zone) |>
    dplyr::summarise(compute_indices(prec, tavg), .groups = "drop")
}
