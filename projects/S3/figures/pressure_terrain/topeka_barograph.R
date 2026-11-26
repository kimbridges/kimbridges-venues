# topeka_barograph.R -- a station's view of the moving landscape (S3). Kim + Claude, 2026-11-25.
# A: 500 hPa height at the station from GFS analyses (the terrain under it);
# B: observed hourly sea-level pressure (ASOS via Iowa Environmental Mesonet) with GFS points;
# C: observed hourly temperature. Times in HST to match the z500 animation.
library(terra); library(ggplot2); library(patchwork)

baro_gfs <- function(gribs, lonlat) do.call(rbind, lapply(gribs, function(f) { r <- rast(f)
  data.frame(utc = time(r[["HGT_50000-ISBL"]]), z500 = extract(r[["HGT_50000-ISBL"]], lonlat)[[1]],
             slp = extract(r[["PRMSL_0-MSL"]], lonlat)[[1]] / 100) }))

baro_asos <- function(station, from, to) {         # from/to: POSIXct UTC
  f <- function(x, p) as.integer(format(x, p, tz = "UTC"))
  u <- paste0("https://mesonet.agron.iastate.edu/cgi-bin/request/asos.py?station=", station, "&data=mslp&data=tmpf",
              "&year1=", f(from, "%Y"), "&month1=", f(from, "%m"), "&day1=", f(from, "%d"), "&hour1=", f(from, "%H"),
              "&year2=", f(to, "%Y"), "&month2=", f(to, "%m"), "&day2=", f(to, "%d"), "&hour2=", f(to, "%H"),
              "&tz=Etc%2FUTC&format=onlycomma&latlon=no&missing=M&trace=T&report_type=3")
  o <- read.csv(u, stringsAsFactors = FALSE)
  data.frame(utc = as.POSIXct(o$valid, format = "%Y-%m-%d %H:%M", tz = "UTC"),
             mslp = suppressWarnings(as.numeric(o$mslp)), tc = (suppressWarnings(as.numeric(o$tmpf)) - 32) * 5 / 9)
}

baro_plot <- function(g, o, place = "Topeka", station = "KTOP", tz_offset_h = -10, tz_label = "HST") {
  sh <- function(x) x + tz_offset_h * 3600
  g$t <- sh(g$utc); g$dam <- g$z500 / 10; o$t <- sh(o$utc)
  lim <- range(c(g$t, o$t)); xs <- scale_x_datetime(limits = lim, date_breaks = "1 day", date_labels = "%a %b %d", expand = c(0.01, 0))
  th <- theme_minimal(base_size = 13) + theme(panel.grid.minor = element_blank(), panel.grid.major.x = element_line(color = "grey88"),
    plot.title = element_text(size = 12.5, face = "bold"), plot.subtitle = element_text(size = 10.5, color = "grey35"), axis.title.x = element_blank())
  p1 <- ggplot(g, aes(t, dam)) + geom_line(color = "#2c5c8f", linewidth = 0.9) + geom_point(color = "#2c5c8f", size = 1.6) +
    labs(title = paste0("A.  The terrain under ", place, ": height of the 500 hPa surface"),
         subtitle = "GFS analyses every 6 h; valleys passing overhead are troughs", y = "dam") + xs + th
  p2 <- ggplot(o, aes(t, mslp)) + geom_line(color = "grey20", linewidth = 0.7) + geom_point(data = g, aes(t, slp), color = "#a8452e", size = 1.8) +
    labs(title = paste0("B.  The barograph: sea-level pressure at ", place),
         subtitle = paste0("Line: hourly observations (", station, "). Dots: GFS at the same point"), y = "hPa") + xs + th
  p3 <- ggplot(o, aes(t, tc)) + geom_line(color = "#a8452e", linewidth = 0.7) +
    labs(title = paste0("C.  Air temperature at ", place), subtitle = paste0("Hourly observations (", station, ")"), y = "\u00B0C") + xs + th
  (p1 / p2 / p3) + plot_annotation(caption = paste0("Times in ", tz_label, ". Data: NOAA GFS via NOMADS; ASOS via Iowa Environmental Mesonet."),
    theme = theme(plot.caption = element_text(size = 9.5, color = "grey40")))
}
# g <- baro_gfs(sort(list.files("frames", "\\.grb2$", full.names = TRUE)), cbind(-95.62, 39.07))
# o <- baro_asos("TOP", as.POSIXct("2026-11-19 12:00", tz = "UTC"), as.POSIXct("2026-11-25 23:00", tz = "UTC"))
# ggsave("topeka_barograph_nov19-25.png", baro_plot(g, o), width = 11, height = 10, dpi = 130, bg = "white")
