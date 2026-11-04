# ch02_llm_elicit.R -- MRC chapter 2: eliciting tacit temperature scales from three AI models (2026-11-03).
# For 24 cities, ask each model where long-time residents start to call the weather 'cold', 'chilly', 'warm' and 'hot' (deg F).
# Climate from the whittakerr WorldClim 2.1 cache (2.5 arc-min): bio1 annual mean, bio10 warmest quarter, bio11 coldest quarter.
# Results are saved one file per model x city in C:/temp/llm/ so an interrupted run can resume; combine with combine_llm().
suppressPackageStartupMessages({ library(ellmer); library(terra) })
options(ellmer_timeout_s = 120)
cities <- data.frame(
  city = c('Fairbanks','Anchorage','Reykjavik','Helsinki','Moscow','Ulaanbaatar','Minneapolis','Chicago','Denver','Seattle','London','Madrid',
           'Tokyo','San Diego','Phoenix','Houston','Cairo','Dubai','Miami','Honolulu','Mumbai','Singapore','Lima','Sydney'),
  country = c('USA','USA','Iceland','Finland','Russia','Mongolia','USA','USA','USA','USA','UK','Spain','Japan','USA','USA','USA','Egypt','UAE',
              'USA','USA','India','Singapore','Peru','Australia'),
  lat = c(64.84,61.22,64.15,60.17,55.76,47.92,44.98,41.88,39.74,47.61,51.51,40.42,35.68,32.72,33.45,29.76,30.04,25.20,25.76,21.31,19.08,1.35,-12.05,-33.87),
  lon = c(-147.72,-149.90,-21.94,24.94,37.62,106.92,-93.27,-87.63,-104.99,-122.33,-0.13,-3.70,139.69,-117.16,-112.07,-95.37,31.24,55.27,-80.19,
          -157.86,72.88,103.82,-77.04,151.21), stringsAsFactors = FALSE)
add_climate <- function(cities) {
  cdir <- 'G:/My Drive/Projects/whittakerr/cache/worldclim_cache/climate/wc2.1_2.5m'
  r <- rast(file.path(cdir, paste0('wc2.1_2.5m_bio_', c(1, 10, 11), '.tif'))); names(r) <- c('mean', 'warmq', 'coldq')
  getv <- function(lon, lat) { for (d in c(0, 0.05, 0.1, 0.2, 0.3)) for (dx in c(0, -d, d)) for (dy in c(0, -d, d)) {
    v <- unlist(extract(r, vect(cbind(lon + dx, lat + dy), crs = 'EPSG:4326'))[1, -1]); if (all(is.finite(v))) return(v) }
    c(mean = NA, warmq = NA, coldq = NA) }
  cbind(cities, t(mapply(getv, cities$lon, cities$lat))) }
ty <- type_object(cold_below = type_number("Outdoor air temperature in degrees F below which long-time residents call the weather 'cold'"),
                  chilly_below = type_number("Below this temperature in F they call it 'chilly' or 'cool' (above 'cold')"),
                  warm_above = type_number("Above this temperature in F they call it 'warm'"),
                  hot_above = type_number("Above this temperature in F they call it 'hot'"))
prompt <- function(city, country) sprintf(paste("Think about ordinary people who have lived in %s, %s for many years. In everyday conversation,",
  "at what outdoor air temperatures (daytime, in degrees Fahrenheit) do they start to describe the weather as 'cold', 'chilly', 'warm' and 'hot'?",
  "Give typical local thresholds, as whole numbers, for their own sense of the words -- not a universal standard."), city, country)
models <- list(claude = function() chat_anthropic(model = 'claude-sonnet-5-5', echo = 'none'),
               gpt = function() chat_openai(model = 'gpt-5-mini', echo = 'none'),
               gemini = function() chat_google_gemini(model = 'gemini-3.8-flash', echo = 'none'))
run_model <- function(m, reps = 3, dir = 'C:/temp/llm') {
  dir.create(dir, showWarnings = FALSE, recursive = TRUE)
  for (i in seq_len(nrow(cities))) {
    f <- file.path(dir, sprintf('%s_%s.csv', m, gsub(' ', '_', cities$city[i]))); if (file.exists(f)) next
    rows <- lapply(seq_len(reps), function(k) { res <- tryCatch(models[[m]]()$chat_structured(prompt(cities$city[i], cities$country[i]), type = ty), error = function(e) NULL)
      data.frame(city = cities$city[i], model = m, rep = k, cold = if (is.null(res)) NA else res$cold_below, chilly = if (is.null(res)) NA else res$chilly_below,
                 warm = if (is.null(res)) NA else res$warm_above, hot = if (is.null(res)) NA else res$hot_above, when = format(Sys.time())) })
    write.csv(do.call(rbind, rows), f, row.names = FALSE) } }
combine_llm <- function(dir = 'C:/temp/llm') {
  el <- do.call(rbind, lapply(list.files(dir, pattern = '\\.csv$', full.names = TRUE), read.csv, stringsAsFactors = FALSE))
  merge(el, add_climate(cities), by = 'city') }
