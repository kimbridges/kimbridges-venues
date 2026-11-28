# irp_eventyear_fig.R -- the same IRP rain, framed two ways: calendar year vs event year starting in the dry trough (S3, ch.3). Kim + Claude, 2026-11-27.
# Kim: 'When shown starting at January, it almost forces you to see two wet periods (early and late) spanning a relatively dry middle.'
library(ggplot2); library(patchwork)
irp_read <- function(f) { d <- read.csv(f, colClasses = c(date = "character")); d$date <- as.Date(paste0("19", d$date), "%Y%m%d"); d[order(d$site, d$date), ] }
irp_frame <- function(d, start_month = 1) {
  d$best <- d$am; k <- is.na(d$best) & !is.na(d$tru); d$best[k] <- d$tru[k]
  fix <- d$site == "K54" & format(d$date, "%Y%m%d") %in% c("19730312", "19750106"); d$best[fix] <- d$overall[fix]
  y <- as.integer(format(d$date, "%Y")); m <- as.integer(format(d$date, "%m")); d$fy <- if (start_month == 1) y else ifelse(m >= start_month, y, y - 1)
  y0 <- as.Date(sprintf("%d-%02d-01", d$fy, start_month)); d$day <- as.integer(d$date - y0) + 1
  d$cum <- ave(ifelse(is.na(d$best), 0, d$best), d$site, d$fy, FUN = cumsum)
  d$ylab <- if (start_month == 1) as.character(d$fy) else sprintf("%d-%02d", d$fy, (d$fy + 1) %% 100); d }
irp_frames_fig <- function(d, file, start_month = 7) {
  lab <- c(K54 = "K54  Kilauea Rain Forest, 5,400 ft", M42 = "M42  Mauna Loa Road, 4,200 ft", M54 = "M54  Mauna Loa Road, ~5,300 ft", M66 = "M66  Mauna Loa Road, ~6,700 ft")
  th <- theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10), strip.text = element_text(face = "bold", size = 10), legend.position = "right")
  one <- function(sm, title, sub, pal) { z <- irp_frame(d, sm); z$lab <- factor(lab[z$site], levels = lab)
    mo <- (sm - 1 + c(0, 3, 6, 9)) %% 12 + 1; br <- as.integer(as.Date(sprintf("2001-%02d-01", mo)) - as.Date(sprintf("2001-%02d-01", sm))) %% 365 + 1
    ggplot(z, aes(day, cum, color = ylab)) + geom_step(linewidth = 0.85) + facet_wrap(~lab, nrow = 1) +
      scale_color_manual(values = pal, name = NULL) + scale_x_continuous(breaks = br, labels = month.abb[mo], limits = c(1, 366), name = NULL) +
      scale_y_continuous(name = "mm since start of year") + labs(title = title, subtitle = sub) + th }
  pA <- one(1, "A.  Calendar year (starts January 1)", "Two steep stretches -- January-April and November-December -- seem to frame a dry middle: the wet season is cut in two.",
            c(`1971` = "#8c510a", `1972` = "#d8b365", `1973` = "#5ab4ac", `1974` = "#01665e", `1975` = "#b2182b"))
  pB <- one(start_month, sprintf("B.  Event year (starts %s 1, in the dry trough)", month.name[start_month]), "The same weeks rearranged: one wet season, one steep slope (November-April), then the dry plateau. The boundary sits where little happens.",
            c(`1970-71` = "#8c510a", `1971-72` = "#d8b365", `1972-73` = "#5ab4ac", `1973-74` = "#01665e", `1974-75` = "#b2182b"))
  fig <- pA / pB + plot_annotation(title = "Where the year begins changes what you see: the same IRP rain, framed two ways",
    caption = "Data: Kim's IRP weekly rain records, Bridges and Carey, IBP Island Ecosystems IRP Technical Reports 22 (Suppl. 1), 38, 59, 70; standard gauge (M66 before June 1972: single Tru-Check).\nDriest eight weeks across sites and years: early June to late July (about 6-9 mm a week vs 69 in January and 95 in November). Partial years shown where records begin or end. Code: irp_eventyear_fig.R.",
    theme = theme(plot.title = element_text(face = "bold", size = 14), plot.caption = element_text(size = 9, color = "grey40")))
  ragg::agg_png(file, width = 16, height = 10, units = "in", res = 110, background = "white"); print(fig); dev.off() }
