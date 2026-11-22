# rain_periods.R -- periods of rain at a ladder of gap tolerances
# S3 (Spells, Stretches and Snaps) figure tool. Kim + Claude, 2026-11-18.
#
# Idea: a storm "event" is defined by a minimum inter-event time (IETD):
# dry gaps shorter than the tolerance merge the rain on either side into one
# event. Applying growing tolerances to ONE hourly record yields each row of a
# wet-weather timescale ladder (shower -> period of rain -> spell -> unsettled
# pattern -> wet regime -> season). Top panel: periods. Bottom: daily amounts.
#
# The tolerances are the critical assumption -- an MRC-style boundary choice.
# Base R only; no package dependencies.

# ---- core: events at one gap tolerance ------------------------------------
# time: POSIXct, regular hourly; amount: numeric (NA treated as 0); gap_h: hours
rp_events <- function(time, amount, gap_h, wet_min = 0) {
  amount[is.na(amount)] <- 0
  w <- which(amount > wet_min)
  if (!length(w)) return(data.frame(start = time[0], end = time[0], hours = numeric(), total = numeric()))
  brk <- c(TRUE, diff(w) - 1 > gap_h)          # dry hours between wet hours
  id  <- cumsum(brk)
  s <- tapply(w, id, min); e <- tapply(w, id, max)
  data.frame(start = time[s], end = time[e], hours = e - s + 1,
             total = mapply(function(a, b) sum(amount[a:b]), s, e))
}

# ---- the default ladder (labels follow the Gemini table; VERIFY) ---------
rp_ladder <- data.frame(
  name  = c("Passing shower", "Period of rain", "Rain spell",
            "Unsettled pattern", "Wet regime", "Rainy season"),
  gap_h = c(1, 6, 24, 96, 240, 720),
  label = c("gap \u2264 1 hr", "\u2264 6 hr", "\u2264 1 day",
            "\u2264 4 days", "\u2264 10 days", "\u2264 30 days"))

# ---- plot -----------------------------------------------------------------
rain_periods_plot <- function(time, amount, ladder = rp_ladder, title = NULL,
                              units = "Daily amount", file = NULL,
                              width = 12, height = 6.2, res = 150) {
  if (!is.null(file)) { png(file, width = width, height = height, units = "in", res = res); on.exit(dev.off()) }
  t0 <- as.numeric(min(time)); day <- function(x) (as.numeric(x) - t0) / 86400
  span <- day(max(time)) + 1/24
  pal <- colorRampPalette(c("#9ecae1", "#08306b"))(100)
  ev <- lapply(ladder$gap_h, function(g) rp_events(time, amount, g))
  maxlog <- max(unlist(lapply(ev, function(e) log1p(e$total))), 1)
  op <- par(no.readonly = TRUE); on.exit(par(op), add = TRUE)
  layout(matrix(1:2), heights = c(3, 1.2))
  par(mar = c(1, 11, 3, 1), xaxs = "i")
  n <- nrow(ladder)
  plot(NA, xlim = c(0, span), ylim = c(0.4, n + 0.6), axes = FALSE, xlab = "", ylab = "")
  for (r in seq_len(n)) {
    y <- n - r + 1; e <- ev[[r]]
    if (nrow(e)) {
      col <- pal[pmax(1, ceiling(100 * log1p(e$total) / maxlog))]
      x0 <- day(e$start); x1 <- pmax(day(e$end) + 1/24, x0 + 0.15)
      rect(x0, y - 0.35, x1, y + 0.35, col = col, border = NA)
    }
    mtext(paste0(ladder$name[r], "\n(", ladder$label[r], ")"), side = 2, at = y,
          las = 1, line = 0.5, cex = 0.8, adj = 1)
  }
  if (is.null(title)) title <- "Periods of rain at a ladder of gap tolerances"
  mtext(title, side = 3, line = 1, adj = 0, cex = 1)
  mtext("Bar shade = event total (darker = wetter). Dry gaps shorter than the tolerance merge into one event.",
        side = 1, line = 0, adj = 1, cex = 0.65, col = "grey35")
  # daily amounts
  dkey <- floor(day(time)); daily <- tapply(ifelse(is.na(amount), 0, amount), dkey, sum)
  par(mar = c(3, 11, 0.5, 1))
  plot(NA, xlim = c(0, span), ylim = c(0, max(daily, 1)), axes = FALSE, xlab = "", ylab = "")
  rect(as.numeric(names(daily)), 0, as.numeric(names(daily)) + 1, daily, col = "#4a6fa5", border = NA)
  axis(2, las = 1, cex.axis = 0.8); mtext(units, side = 2, line = 3, cex = 0.8)
  mo <- seq(as.Date(format(min(time), "%Y-%m-01")), as.Date(max(time)), by = "month")
  mo <- mo[mo >= as.Date(min(time))]
  axis(1, at = day(as.POSIXct(mo, tz = attr(time, "tzone") %||% "UTC")) + 15,
       labels = substr(format(mo, "%b"), 1, 1), tick = FALSE, cex.axis = 0.85)
  invisible(ev)
}
`%||%` <- function(a, b) if (is.null(a) || !nzchar(a)) b else a

# ---- synthetic demo (illustration only) -----------------------------------
rp_synthetic_year <- function(seed = 7, year = 2025) {
  set.seed(seed); H <- 365 * 24; t <- (0:(H - 1)) / 24
  season <- 0.5 * (1 + cos(2 * base::pi * (t - 15) / 365))
  reg <- numeric(H); k <- 1
  while (k <= H) { L <- sample(7:27, 1) * 24; reg[k:min(H, k + L - 1)] <- runif(1) < 0.35 + 0.4 * season[k]; k <- k + L }
  sys <- numeric(H); k <- 1
  while (k <= H) { k <- k + round(rexp(1, 1 / (24 * if (reg[k]) 3 else 14))); if (k > H) break
                   L <- sample(12:119, 1); sys[k:min(H, k + L - 1)] <- 1; k <- k + L }
  p_on <- 0.003 + 0.25 * sys * (0.4 + 0.6 * season) + 0.02 * reg
  wet <- logical(H); s <- FALSE
  for (h in 1:H) { s <- runif(1) < (if (s) 0.55 else p_on[h]); wet[h] <- s }
  amt <- ifelse(wet, rgamma(H, 0.8, 1 / 1.5), 0)
  data.frame(time = as.POSIXct(sprintf("%d-01-01", year), tz = "UTC") + (0:(H - 1)) * 3600, amount = amt)
}

if (sys.nframe() == 0) {   # run as a script: draw the demo
  d <- rp_synthetic_year()
  rain_periods_plot(d$time, d$amount,
    title = "Periods of rain at six gap tolerances \u2014 one synthetic year (illustration only)",
    file = "rain_periods_synthetic.png")
}

# ---- usage with real data -------------------------------------------------
# d <- read.csv("station_hourly.csv")        # columns: time, amount (hourly)
# d$time <- as.POSIXct(d$time, tz = "Pacific/Honolulu")
# rain_periods_plot(d$time, d$amount, title = "Station X, water year 2025",
#                   units = "Daily rain (mm)", file = "stationX_2025.png")
