# irp_rain_fig.R -- Kim's IRP weekly rain, Mauna Loa transect and Kilauea Rain Forest, 1973 to June 1975 (S3, ch.9 and ch.2). Kim + Claude, 2026-11-27.
library(ggplot2); library(patchwork)
irp_read <- function(f) { d <- read.csv(f); d$date <- as.Date(sprintf("19%06d", d$date), "%Y%m%d"); d[order(d$site, d$date), ] }
irp_fig <- function(d, file) {
  d$best <- d$am; fix <- d$site == "K54" & format(d$date, "%Y%m%d") %in% c("19730312", "19750106"); d$best[fix] <- d$overall[fix]   # standard gauge faulty those weeks
  d$cum <- ave(ifelse(is.na(d$best), 0, d$best), d$site, FUN = cumsum)
  lab <- c(K54 = "K54  Kilauea Rain Forest", M42 = "M42  Mauna Loa Road", M54 = "M54  Mauna Loa Road", M66 = "M66  Mauna Loa Road")
  cols <- c(K54 = "#1b7837", M42 = "#2c5c8f", M54 = "#c7a252", M66 = "#b2182b"); d$lab <- factor(lab[d$site], levels = lab)
  ev <- data.frame(date = as.Date(c("1973-11-26", "1974-12-16", "1975-01-06")), name = c("Nov 1973 storm", "Dec 1974", "Jan 1975 storm"))
  th <- theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10), axis.title.x = element_blank())
  yb <- data.frame(x = as.Date(c("1973-01-01", "1974-01-01", "1975-01-01")))
  endl <- do.call(rbind, lapply(split(d, d$site), function(z) z[nrow(z), ]))
  pA <- ggplot(d, aes(date, cum, color = lab)) + geom_vline(data = yb, aes(xintercept = x), color = "grey85") +
    geom_vline(data = ev, aes(xintercept = date), color = "grey60", linetype = "dotted") +
    geom_text(data = ev, aes(x = date, y = 5200, label = name), inherit.aes = FALSE, angle = 90, hjust = 1, vjust = -0.4, size = 3.2, color = "grey35") +
    geom_step(linewidth = 1) + geom_text(data = endl, aes(label = sprintf("%s  %.0f mm", site, cum)), hjust = -0.1, size = 3.5, fontface = "bold", show.legend = FALSE) +
    scale_color_manual(values = setNames(cols, lab), name = NULL) + scale_x_date(date_breaks = "3 months", date_labels = "%b\n%Y", expand = c(0.01, 0), limits = as.Date(c("1973-01-01", "1975-10-15"))) +
    scale_y_continuous(name = "rain since January 1, 1973 (mm)", limits = c(0, 5300)) +
    labs(title = "A.  Two and a half years of rain on Kim's transect: standard gauge, every site",
         subtitle = "Weekly readings, January 1973 to June 1975. The steps are storms: a few weeks carry much of each year.") + th + theme(legend.position = "bottom")
  ov <- d[d$site %in% c("K54", "M54"), ]; ov$cum_ov <- ave(ifelse(is.na(ov$overall), 0, ov$overall), ov$site, FUN = cumsum)
  lo <- rbind(data.frame(site = ov$site, date = ov$date, cum = ov$cum, what = "standard gauge"), data.frame(site = ov$site, date = ov$date, cum = ov$cum_ov, what = "mean of all 16 gauges"))
  lo$lab <- factor(lab[lo$site], levels = lab)
  pB <- ggplot(lo, aes(date, cum, linetype = what, color = lab)) + geom_step(linewidth = 0.9) + facet_wrap(~lab, nrow = 1) +
    geom_vline(data = ev, aes(xintercept = date), color = "grey60", linetype = "dotted") +
    scale_color_manual(values = setNames(cols, lab), guide = "none") + scale_linetype_manual(values = c(`standard gauge` = "solid", `mean of all 16 gauges` = "22"), name = NULL) +
    scale_x_date(date_breaks = "6 months", date_labels = "%b %Y") + scale_y_continuous(name = "mm since Jan 1, 1973") +
    labs(title = "B.  The instrument decided the total: same site, same weeks, different gauges",
         subtitle = "Jumps: in the big storms every Tru-Check gauge read its cap (152.4 mm) and every metric gauge its cap (231.0 mm); only the standard gauge caught the storm.\nBetween storms the gauges also disagree, in opposite directions: at M54 the standard gauge caught 27% more than the 16-gauge mean, at K54 9% less.") + th + theme(legend.position = "bottom", strip.text = element_text(face = "bold"))
  fig <- pA / pB + plot_layout(heights = c(1.5, 1)) + plot_annotation(caption = "Data: Bridges and Carey, IBP Island Ecosystems IRP Technical Reports 38, 59, 70 (1974-75), weekly rain record tables; transcribed 2026. K54 standard gauge faulty two weeks (Mar 12, 1973; Jan 6, 1975): 16-gauge mean used. Code: irp_rain_fig.R.",
    theme = theme(plot.caption = element_text(size = 9, color = "grey40")))
  ragg::agg_png(file, width = 14, height = 11, units = "in", res = 110, background = "white"); print(fig); dev.off()
  invisible(endl[, c("site", "cum")]) }
