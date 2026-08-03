## seasonality_harness.R
## WorldClim point climatologies + seasonality indices (the real-data harness).
## Data: WorldClim 2.1 monthly normals (tavg °C, prec mm) via the geodata package,
## downloaded once to wc_cache/ and reused. Runs on Kim's machine (sanctioned path).
##
## Usage (once the ClaudeR bridge is live):
##   source("G:/My Drive/Projects/seasonality/seasonality_harness.R")
##   clim <- get_climate(cities)          # downloads on first call, caches after
##   idx  <- indices_table(clim)
##   plot_channel(idx)                    # the temperature-vs-rainfall channel view
##
## Add cities by appending name/lat/lon rows to `cities`.

suppressMessages({
  library(geodata); library(terra); library(tidyverse)
})

WC_RES <- 10                                              # arc-minutes (~18 km); plenty for city typing
CACHE  <- "G:/My Drive/Projects/seasonality/wc_cache"

## ---- starter city set (our validation set, real coordinates) ----
cities <- tribble(
  ~name,          ~zone,          ~lat,    ~lon,
  "Tucson",       "subtropical",  32.22, -110.97,   # Sonoran  (bimodal)
  "Las Vegas",    "subtropical",  36.17, -115.14,   # Mojave   (winter rain)
  "El Paso",      "subtropical",  31.76, -106.49,   # Chihuahuan (summer rain)
  "Singapore",    "equatorial",    1.35,  103.82,
  "Manaus",       "equatorial",   -3.10,  -60.02,
  "Nairobi",      "equatorial",   -1.29,   36.82,
  "Mumbai",       "tropical",     19.08,   72.88,
  "Niamey",       "tropical",     13.51,    2.11,
  "Darwin",       "tropical",    -12.46,  130.84,
  "Cairo",        "subtropical",  30.04,   31.24,
  "Rome",         "mid",          41.90,   12.50,
  "Los Angeles",  "mid",          34.05, -118.24,
  "Atlanta",      "mid",          33.75,  -84.39,
  "Tokyo",        "mid",          35.68,  139.69,
  "Beijing",      "mid",          39.90,  116.40,
  "Bergen",       "temperate",    60.39,    5.32,
  "London",       "temperate",    51.51,   -0.13,
  "Chicago",      "temperate",    41.88,  -87.63,
  "Moscow",       "temperate",    55.76,   37.62,
  "Ulaanbaatar",  "temperate",    47.89,  106.91,
  "Fairbanks",    "subarctic",    64.84, -147.72
)

## ---- WorldClim retrieval: cities -> tidy monthly normals ----
get_climate <- function(cities) {
  dir.create(CACHE, showWarnings = FALSE, recursive = TRUE)
  tavg <- geodata::worldclim_global("tavg", res = WC_RES, path = CACHE)
  prec <- geodata::worldclim_global("prec", res = WC_RES, path = CACHE)
  pts  <- cbind(cities$lon, cities$lat)
  Tm <- terra::extract(tavg, pts)        # one row per city, 12 month columns
  Pm <- terra::extract(prec, pts)
  purrr::map_dfr(seq_len(nrow(cities)), function(i) {
    tibble(name = cities$name[i], zone = cities$zone[i], month = 1:12,
           tavg = as.numeric(Tm[i, ]), prec = as.numeric(Pm[i, ]))
  })
}

## ---- the seasonality indices (ported from the sandbox prototypes) ----
## Tamp     : temperature seasonality = half the annual range (deg C)
## SI       : Walsh-Lawler rainfall seasonality index (0 = uniform .. ~1.83 = all in one month)
## cool_frac: fraction of rain in the 6 coldest months (Mediterranean high; monsoon/continental low)
##            NOTE: only meaningful where temperature is sun-driven (inverts in the cloudy tropics)
## bimod    : 2nd/1st rainfall-harmonic ratio (gated to 0 below the SI floor) -> two wet seasons
## totP     : annual rainfall (mm) -- gates whether rainfall seasonality is "real" (aridity)
## m_mean   : mean of the Walter-Lieth moisture curve P - 2T (aridity / water-balance overlay)
SI_FLOOR <- 0.40
compute_indices <- function(P, T) {
  P <- as.numeric(P); T <- as.numeric(T); R <- sum(P)
  SI   <- sum(abs(P - R / 12)) / R
  Tamp <- (max(T) - min(T)) / 2
  cold6 <- order(T)[1:6]
  cool_frac <- sum(P[cold6]) / R
  ft <- stats::fft(P); A1 <- Mod(ft[2]); A2 <- Mod(ft[3])
  bimod <- if (A1 > 1e-9 && SI >= SI_FLOOR) A2 / A1 else 0
  tibble(Tamp = Tamp, SI = SI, cool_frac = cool_frac, bimod = bimod,
         totP = R, m_mean = mean(P - 2 * T))
}

indices_table <- function(clim) {
  clim |> arrange(name, month) |>
    group_by(name, zone) |>
    summarise(compute_indices(prec, tavg), .groups = "drop")
}

## ---- the channel view: temperature seasonality vs rainfall seasonality ----
plot_channel <- function(idx, file = "G:/My Drive/Projects/seasonality/channel_real.png") {
  g <- ggplot(idx, aes(Tamp, SI)) +
    geom_hline(yintercept = SI_FLOOR, linetype = "dotted", color = "gray60") +
    geom_point(aes(fill = cool_frac, size = totP), shape = 21, color = "black") +
    ggrepel::geom_text_repel(aes(label = name), size = 3, max.overlaps = 20) +
    scale_fill_gradient2(low = "#D55E00", mid = "#EEEEEE", high = "#0072B2",
                         midpoint = 0.5, limits = c(0, 1), name = "cool-season rain") +
    scale_size_area(max_size = 11, name = "annual rain (mm)") +
    labs(x = "temperature seasonality (deg C)", y = "rainfall seasonality (SI)",
         title = "Seasonality channels from WorldClim normals",
         subtitle = "colour = rain phase (blue = winter/Mediterranean) | size = annual rainfall") +
    theme_minimal()
  ggsave(file, g, width = 9.5, height = 6.8, dpi = 110)
  message("saved ", file)
  g
}

## run:
##   clim <- get_climate(cities); idx <- indices_table(clim); print(idx, n = 40); plot_channel(idx)
