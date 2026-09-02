## stops_data.R -- the fuel-stop point map. Where the tanks actually fell.
##
## A choropleth shows EXTENT. This shows CADENCE: how far apart the stops are,
## which across the Canadian plains is what a three-hundred-mile day looks like
## when you draw it instead of tabulating it.
##
## GEOCODING IS OFFLINE AND REPRODUCIBLE, from three sources in priority order:
##   1. All_gas_stations_csv.csv   -- the project's own gazetteer, 212 stops
##   2. TwoRed_gazetteer_errata.csv -- 8 corrected placements, keyed BOTH by the
##      corrected name and by the spelling the fuel log actually carries
##   3. maps::us.cities / canada.cities / world.cities, the last tagged to a
##      state by point-in-polygon against data/na_states.rds
## ⛔ NO NETWORK GEOCODER. A figure function must never make a network call.
##
## ⚠ COVERAGE IS NOT EQUAL BETWEEN THE CARS AND THE FIGURE MUST SAY SO.
## The gazetteer was built for TwoRed. Creamsicle's small towns are largely absent
## from every offline source tried, so its map would show sparse driving that did
## not happen. `stops_data()` reports coverage per car and the caller decides.

.stop_key <- function(city, st)
  toupper(gsub("[^A-Z0-9]", "", paste0(toupper(trimws(city)), toupper(trimws(st)))))

.stop_pool <- function() {
  gz <- utils::read.csv(file.path(SC_DIR, "All_gas_stations_csv.csv"),
                        stringsAsFactors = FALSE)
  p <- data.frame(k = .stop_key(gz$City, norm_state(gz$State)),
                  lat = gz$latitude, lon = gz$longitude, src = "gazetteer",
                  stringsAsFactors = FALSE)

  ge <- utils::read.csv(file.path(SC_DIR, "TwoRed_gazetteer_errata.csv"),
                        stringsAsFactors = FALSE)
  ge <- ge[is.finite(ge$lat_correct), ]
  if (nrow(ge)) {
    p <- rbind(p, data.frame(k = .stop_key(ge$city_correct, norm_state(ge$state_correct)),
                             lat = ge$lat_correct, lon = ge$lon_correct, src = "errata",
                             stringsAsFactors = FALSE))
    sp <- strsplit(ge$key_logged, "\\|")
    p <- rbind(p, data.frame(
      k = .stop_key(vapply(sp, `[`, "", 1), norm_state(vapply(sp, `[`, "", 2))),
      lat = ge$lat_correct, lon = ge$lon_correct, src = "errata",
      stringsAsFactors = FALSE))
  }

  utils::data("us.cities", package = "maps", envir = environment())
  utils::data("canada.cities", package = "maps", envir = environment())
  mc <- rbind(
    data.frame(nm = sub(" [A-Z]{2}$", "", us.cities$name), st = us.cities$country.etc,
               lat = us.cities$lat, lon = us.cities$long, stringsAsFactors = FALSE),
    data.frame(nm = sub(" [A-Z]{2}$", "", canada.cities$name), st = canada.cities$country.etc,
               lat = canada.cities$lat, lon = canada.cities$long, stringsAsFactors = FALSE))
  p <- rbind(p, data.frame(k = .stop_key(mc$nm, mc$st), lat = mc$lat, lon = mc$lon,
                           src = "maps", stringsAsFactors = FALSE))

  wc <- file.path("data", "wc_tagged.rds")
  if (file.exists(wc)) {
    w <- readRDS(wc)
    p <- rbind(p, data.frame(k = .stop_key(w$name, w$postal), lat = w$lat, lon = w$long,
                             src = "maps", stringsAsFactors = FALSE))
  }
  p[!duplicated(p$k) & is.finite(p$lat) & is.finite(p$lon), ]
}

stops_data <- function() {
  pool <- .stop_pool()
  mk <- function(d, city, st, car) {
    z <- data.frame(car = car, date = as.Date(d$date),
                    city = d[[city]], st = norm_state(d[[st]]),
                    stringsAsFactors = FALSE)
    z$k <- .stop_key(z$city, z$st)
    z <- merge(z, pool[, c("k", "lat", "lon")], by = "k", all.x = TRUE)
    z[order(z$date), ]
  }
  tw <- mk(twored_fuel, "City", "State", "TwoRed")
  cr <- mk(cream_fuel,  "city", "state", "Creamsicle")
  all <- rbind(tw, cr)

  cov <- do.call(rbind, lapply(split(all, all$car), function(d) data.frame(
    car = d$car[1], fills = nrow(d), placed = sum(is.finite(d$lat)),
    pct = 100 * mean(is.finite(d$lat)),
    cities = length(unique(d$k)),
    cities_placed = length(unique(d$k[is.finite(d$lat)])),
    stringsAsFactors = FALSE)))
  rownames(cov) <- NULL

  list(all = all, pts = all[is.finite(all$lat), ], cov = cov,
       unplaced = sort(unique(paste0(all$city[!is.finite(all$lat)], ", ",
                                     all$st[!is.finite(all$lat)]))))
}
