# sf_small_addition.R -- a small addition, a large impact: San Francisco tide gauge, threshold view (S3).
# Kim + Claude, 2026-11-25. NOAA CO-OPS station 9414290; datum MHHW; flood levels converted from station datum (ft).
library(ggplot2); library(patchwork); library(jsonlite)

sa_get <- function(station = "9414290", begin = "20261118", end = "20261125") {
  base <- paste0("https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?application=kimbridges_S3&format=json",
                 "&units=metric&time_zone=lst_ldt&datum=MHHW&station=", station, "&begin_date=", begin, "&end_date=", end)
  wl <- fromJSON(paste0(base, "&product=water_level"))$data; pr <- fromJSON(paste0(base, "&product=predictions&interval=6"))$predictions
  o <- data.frame(t = as.POSIXct(wl$t, tz = "America/Los_Angeles"), obs = as.numeric(wl$v))
  p <- data.frame(t = as.POSIXct(pr$t, tz = "America/Los_Angeles"), pred = as.numeric(pr$v))
  m <- merge(p, o, by = "t", all.x = TRUE); m$res <- m$obs - m$pred
  fl <- fromJSON(paste0("https://api.tidesandcurrents.noaa.gov/mdapi/prod/webapi/stations/", station, "/floodlevels.json"))
  dt <- fromJSON(paste0("https://api.tidesandcurrents.noaa.gov/mdapi/prod/webapi/stations/", station, "/datums.json"))
  mhhw <- dt$datums$value[dt$datums$name == "MHHW"]; f2m <- function(x) (x - mhhw) * 0.3048
  list(m = m, nws = f2m(fl$nws_minor), nos = f2m(fl$nos_minor), rec = f2m(dt$max), rec_date = dt$maxdate)
}

sa_plot <- function(d, place = "San Francisco") {
  m <- d$m; nws <- d$nws; nos <- d$nos; rec <- d$rec; m$top <- pmax(m$obs, nws)
  hrs <- function(x, th) sum(x > th, na.rm = TRUE) * 0.1
  th_ <- theme_minimal(base_size = 13) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12.5),
    plot.subtitle = element_text(size = 10.5, color = "grey35"), axis.title.x = element_blank())
  xs <- scale_x_datetime(date_breaks = "1 day", date_labels = "%a %b %d", expand = c(0.005, 0))
  pA <- ggplot(m, aes(t)) + geom_ribbon(aes(ymin = nws, ymax = top), fill = "#a8452e", alpha = 0.55, na.rm = TRUE) +
    geom_line(aes(y = pred), color = "grey55", linewidth = 0.6) + geom_line(aes(y = obs), color = "#1f4e79", linewidth = 0.6, na.rm = TRUE) +
    geom_hline(yintercept = c(nws, nos), color = "#a8452e", linetype = c("dashed", "solid"), linewidth = 0.6) +
    geom_hline(yintercept = rec, color = "grey20", linetype = "dotted", linewidth = 0.6) +
    annotate("text", x = min(m$t), y = c(nws, nos, rec) + 0.07, hjust = 0, size = 3.4, color = c("#a8452e", "#a8452e", "grey20"),
             label = c(sprintf("NWS minor flood (%.2f m)", nws), sprintf("NOAA minor flood (%.2f m)", nos),
                       sprintf("station record, %s (%.2f m)", format(as.Date(d$rec_date, "%Y%m%d"), "%b %d %Y"), rec))) +
    coord_cartesian(ylim = c(min(m$pred) - 0.05, rec + 0.15)) +
    labs(title = paste0("A.  ", place, " tide gauge: predicted tide (grey) and observed water (blue)"),
         subtitle = sprintf("Red: the tips above the flood line. Predicted alone: %.1f h above the NWS line. Observed: %.1f h (%.1f h above NOAA's)",
                            hrs(m$pred, nws), hrs(m$obs, nws), hrs(m$obs, nos)), y = "m above mean higher high water") + xs + th_
  pB <- ggplot(m, aes(t, res)) + geom_hline(yintercept = 0, color = "grey60") +
    geom_area(fill = "#1f4e79", alpha = 0.25, na.rm = TRUE) + geom_line(color = "#1f4e79", linewidth = 0.6, na.rm = TRUE) +
    labs(title = "B.  The bit of height: observed minus predicted",
         subtitle = sprintf("Median %+.2f m -- everything that is not tide: raised sea level (El Ni\u00F1o), storm surge, wind, runoff", median(m$res, na.rm = TRUE)),
         y = "m") + xs + th_
  off <- seq(0, 0.7, by = 0.01); med <- median(m$res, na.rm = TRUE)
  ex <- data.frame(off = off, nws = sapply(off, function(a) hrs(m$pred + a, nws)), nos = sapply(off, function(a) hrs(m$pred + a, nos)))
  pC <- ggplot(ex, aes(off)) + geom_line(aes(y = nws), color = "#a8452e", linetype = "dashed", linewidth = 0.9) +
    geom_line(aes(y = nos), color = "#a8452e", linewidth = 0.9) + geom_vline(xintercept = med, color = "#1f4e79", linewidth = 0.6) +
    annotate("text", x = med + 0.01, y = max(ex$nws) * 0.92, hjust = 0, size = 3.5, color = "#1f4e79", label = sprintf("this week's addition\n(%+.2f m)", med)) +
    annotate("text", x = 0.62, y = ex$nws[ex$off == 0.62] + 3, size = 3.3, color = "#a8452e", label = "NWS line") +
    annotate("text", x = 0.66, y = ex$nos[ex$off == 0.66] - 4, size = 3.3, color = "#a8452e", label = "NOAA line") +
    labs(title = "C.  A small addition, a large impact: hours above the flood line vs height added to the predicted tide",
         subtitle = "The predicted week, raised uniformly. Nothing happens until the tips reach the line; then the hours climb steeply",
         x = "height added to the predicted tide (m)", y = "hours above line") +
    theme_minimal(base_size = 13) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12.5), plot.subtitle = element_text(size = 10.5, color = "grey35"))
  (pA / pB / pC) + plot_layout(heights = c(1.5, 0.7, 1)) +
    plot_annotation(caption = "NOAA CO-OPS 6-min data (preliminary); local time. Thresholds from NOAA station flood levels.",
                    theme = theme(plot.caption = element_text(size = 9.5, color = "grey40")))
}
# d <- sa_get(); ggsave("sf_small_addition_nov18-25.png", sa_plot(d), width = 12, height = 12, dpi = 125, bg = "white")
