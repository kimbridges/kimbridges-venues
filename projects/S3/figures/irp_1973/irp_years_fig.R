# irp_years_fig.R -- Kim's IRP weekly rain 1971-1975: each site's years overlaid, and what the gauges did (S3, ch.9, ch.6, ch.2). Kim + Claude, 2026-11-27.
library(ggplot2); library(patchwork)
irp_read <- function(f) { d <- read.csv(f, colClasses = c(date = "character")); d$date <- as.Date(paste0("19", d$date), "%Y%m%d"); d[order(d$site, d$date), ] }
irp_best <- function(d) { d$best <- d$am; k <- is.na(d$best) & !is.na(d$tru); d$best[k] <- d$tru[k]
  fix <- d$site == "K54" & format(d$date, "%Y%m%d") %in% c("19730312", "19750106"); d$best[fix] <- d$overall[fix]; d }
irp_years_fig <- function(d, file) {
  d <- irp_best(d); d$yr <- as.integer(format(d$date, "%Y")); d$doy <- as.integer(format(d$date, "%j"))
  d$cum <- ave(ifelse(is.na(d$best), 0, d$best), d$site, d$yr, FUN = cumsum)
  full <- aggregate(doy ~ site + yr, d, function(v) min(v) <= 10 & max(v) >= 355); full <- full[full$doy, c("site", "yr")]
  tot <- merge(aggregate(cum ~ site + yr, d, max), full)
  tot <- do.call(rbind, lapply(split(tot, tot$site), function(z) { z <- z[order(z$cum), ]; z$ly <- z$cum; if (nrow(z) > 1) for (i in 2:nrow(z)) z$ly[i] <- max(z$ly[i], z$ly[i - 1] + 75); z }))
  lab <- c(K54 = "K54  Kilauea Rain Forest, 5,400 ft", M42 = "M42  Mauna Loa Road, 4,200 ft", M54 = "M54  Mauna Loa Road, ~5,300 ft", M66 = "M66  Mauna Loa Road, ~6,700 ft")
  d$lab <- factor(lab[d$site], levels = lab); tot$lab <- factor(lab[tot$site], levels = lab)
  ycol <- c(`1971` = "#8c510a", `1972` = "#d8b365", `1973` = "#5ab4ac", `1974` = "#01665e", `1975` = "#b2182b")
  d$year <- factor(d$yr); tot$year <- factor(tot$yr)
  th <- theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10))
  mb <- as.integer(format(as.Date(sprintf("2001-%02d-01", c(1, 4, 7, 10))), "%j"))
  pA <- ggplot(d, aes(doy, cum, color = year)) + geom_step(linewidth = 0.9) + facet_wrap(~lab, nrow = 1) +
    geom_text(data = tot, aes(x = 368, y = ly, label = sprintf("%.0f", cum)), hjust = 0, size = 3.1, show.legend = FALSE) +
    scale_color_manual(values = ycol, name = NULL) + scale_x_continuous(breaks = mb, labels = c("Jan", "Apr", "Jul", "Oct"), limits = c(1, 420), name = NULL) +
    scale_y_continuous(name = "rain since January 1 (mm)") +
    labs(title = "A.  The same place, different years: rain through each year at Kim's four IRP sites, 1971 to mid-1975",
         subtitle = "Standard gauge (M66 before June 1972: its single Tru-Check gauge). Numbers: complete-year totals. Big steps are single storm weeks.") +
    th + theme(legend.position = "bottom", strip.text = element_text(face = "bold", size = 10))
  ov <- d[d$site %in% c("K54", "M54"), ]; ov$cum1 <- ave(ifelse(is.na(ov$best), 0, ov$best), ov$site, FUN = cumsum); ov$cum2 <- ave(ifelse(is.na(ov$overall), 0, ov$overall), ov$site, FUN = cumsum)
  lo <- rbind(data.frame(lab = ov$lab, date = ov$date, cum = ov$cum1, what = "standard gauge"), data.frame(lab = ov$lab, date = ov$date, cum = ov$cum2, what = "mean of all gauges (up to 16)"))
  lo$lab <- droplevels(lo$lab)
  pB <- ggplot(lo, aes(date, cum, linetype = what)) + geom_step(linewidth = 0.8, color = "grey20") + facet_wrap(~lab, nrow = 1) +
    scale_linetype_manual(values = c(`standard gauge` = "solid", `mean of all gauges (up to 16)` = "22"), name = NULL) +
    scale_x_date(date_breaks = "1 year", date_labels = "%Y") + scale_y_continuous(name = "mm since Jan 1, 1971") +
    labs(title = "B.  Same site, same weeks, different gauges: the instrument decides the total",
         subtitle = "Storm weeks: the small gauges overflowed (Tru-Check cap 152.4 mm, metric 231.0 mm). Between storms the gauges disagree in opposite directions at the two sites.") +
    th + theme(legend.position = "bottom", strip.text = element_text(face = "bold"), axis.title.x = element_blank())
  fig <- pA / pB + plot_layout(heights = c(1.25, 1)) + plot_annotation(caption = "Data: Bridges and Carey, IBP Island Ecosystems IRP Technical Reports 22 (Suppl. 1), 38, 59, 70 (1972-75), weekly rain record tables; transcribed and checked 2026.\nM42 and M66 begin Oct 25, 1971. K54 standard gauge faulty Mar 12, 1973 and Jan 6, 1975 (gauge mean used). Code: irp_years_fig.R.",
    theme = theme(plot.caption = element_text(size = 9, color = "grey40")))
  ragg::agg_png(file, width = 16, height = 10, units = "in", res = 110, background = "white"); print(fig); dev.off()
  invisible(tot[order(tot$site, tot$yr), c("site", "yr", "cum")]) }
