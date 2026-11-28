# envelope_folk.R -- this year against the envelope, labeled with the folk words for the odds (S3, ch.6; Kim: '"average," "intense," and "historic" ... are the folk terms for the odds').
# Kim + Claude, 2026-11-27. Input: daily rain data.frame(date, mm). Water year Oct-Sep (the boundary sits in the dry-season trough).
library(ggplot2); library(patchwork)
ef_prep <- function(p, start = "1974-10-01") {
  x <- data.frame(date = seq(as.Date(start), max(p$date), by = "day")); x <- merge(x, p[!duplicated(p$date), c("date", "mm")], all.x = TRUE); x <- x[order(x$date), ]
  x$wy <- as.integer(format(x$date, "%Y")) + (as.integer(format(x$date, "%m")) >= 10); x$wd <- as.integer(x$date - as.Date(sprintf("%d-10-01", x$wy - 1))) + 1
  x$mm0 <- ifelse(is.na(x$mm), 0, x$mm); x$cum <- ave(x$mm0, x$wy, FUN = cumsum); x }
ef_fig <- function(x, ref = 1975:2025, yr = 2026, file, station = "Honolulu airport", events = NULL, src = "") {
  h <- x[x$wy %in% ref & x$wd <= 365, ]; q <- do.call(rbind, lapply(split(h$cum, h$wd), function(v) quantile(v, c(0, .1, .25, .5, .75, .9, 1)))); q <- data.frame(wd = 1:365, q); names(q) <- c("wd", "q0", "q10", "q25", "q50", "q75", "q90", "q100")
  d0 <- as.Date(sprintf("%d-10-01", yr - 1)); q$date <- d0 + q$wd - 1; y <- x[x$wy == yr, ]; y2 <- x[x$wy == yr + 1, ]; y2$date2 <- d0 + y2$wd - 1
  tot <- aggregate(mm0 ~ wy, h, sum); rk <- rank(-c(tot$mm0, sum(y$mm0)))[nrow(tot) + 1]; n <- length(ref)
  top <- max(q$q100, y$cum) * 1.08; e <- q[365, ]
  bands <- data.frame(lab = c("record dry", "unusually dry", "drier than usual", "about average", "wetter than usual", "unusually wet", "record wet"),
    odds = c(sprintf("below all %d years", n), "1 year in 10", "1 year in 7", "half of all years", "1 year in 7", "1 year in 10", sprintf("beyond all %d years", n)),
    lo = c(0, e$q0, e$q10, e$q25, e$q75, e$q90, e$q100), hi = c(e$q0, e$q10, e$q25, e$q75, e$q90, e$q100, top))
  bands$mid <- (bands$lo + bands$hi) / 2; bands$mid[1] <- e$q0 * 0.55; bands$mid[7] <- e$q100 + (top - e$q100) * 0.45
  fill <- c("#e9eef3", "#c9d6e3", "#a7bcd2")
  xl <- d0 + 365; th <- theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10), axis.title.x = element_blank())
  pA <- ggplot(q, aes(date)) + geom_ribbon(aes(ymin = q0, ymax = q100), fill = fill[1]) + geom_ribbon(aes(ymin = q10, ymax = q90), fill = fill[2]) + geom_ribbon(aes(ymin = q25, ymax = q75), fill = fill[3]) +
    geom_line(aes(y = q50), color = "grey30", linetype = "dashed", linewidth = 0.5) +
    geom_line(data = y2, aes(date2, cum), color = "#b2182b", linewidth = 0.6, linetype = "dotted") +
    geom_line(data = y, aes(date, cum), color = "#b2182b", linewidth = 1.3) +
    geom_segment(data = bands, aes(x = xl + 4, xend = xl + 4, y = pmax(lo, 0) + top * 0.004, yend = hi - top * 0.004), color = "grey55", linewidth = 0.4) +
    geom_text(data = bands, aes(x = xl + 9, y = mid, label = lab), hjust = 0, size = 4, fontface = "bold", color = "grey15") +
    geom_text(data = bands, aes(x = xl + 9, y = mid - top * 0.028, label = odds), hjust = 0, size = 3.2, color = "grey40") +
    annotate("text", x = d0 + 300, y = e$q50 * 0.93, label = "the average year (median)", size = 3.3, color = "grey30", hjust = 0.5, vjust = 1) +
    annotate("text", x = max(y$date) - 5, y = max(y$cum), label = sprintf("%d-%02d: %.0f mm,\n%s of %d years", yr - 1, yr %% 100, sum(y$mm0), c("the wettest", "2nd wettest", "3rd wettest", "4th wettest", "5th wettest", "6th wettest", "7th wettest", "8th wettest", "9th wettest", "10th wettest")[min(rk, 10)], n + 1),
             hjust = 1, vjust = -0.3, size = 3.5, color = "#b2182b", fontface = "bold") +
    scale_x_date(date_breaks = "1 month", date_labels = "%b", expand = c(0, 0), limits = c(d0, d0 + 470)) + scale_y_continuous(name = "rain since October 1 (mm)", limits = c(0, top), expand = c(0, 0)) +
    labs(title = sprintf("A.  This year against the envelope: rain at %s, water year %d-%02d", station, yr - 1, yr %% 100),
         subtitle = sprintf("Bands: the range of %d past years (%d-%d), every day of the year. The folk words name the bands; the odds say what they mean. Dotted: %d-%02d so far.", n, min(ref), max(ref), yr, (yr + 1) %% 100)) + th
  am <- aggregate(mm0 ~ wy, h, max); lv <- data.frame(y = c(median(am$mm0), quantile(am$mm0, .9), max(am$mm0)),
    lab = c("heavy: a typical year's wettest day", "intense: a 1-in-10-year day", sprintf("record: wettest day in %d years (%d)", n, am$wy[which.max(am$mm0)])))
  big <- y[y$mm0 >= lv$y[2], ]
  pB <- ggplot(y, aes(date, mm0)) + geom_col(fill = "#2c5c8f", width = 1) + geom_segment(data = lv, aes(x = d0, xend = d0 + 365, y = y, yend = y), color = c("grey50", "#d6604d", "#b2182b"), linetype = c("dashed", "dashed", "solid"), linewidth = 0.5) +
    geom_text(data = lv, aes(x = d0 + 369, y = y, label = sprintf("%s\n%.0f mm", lab, y)), hjust = 0, vjust = 0.5, size = 3.4, color = c("grey30", "#b2182b", "#b2182b")) +
    geom_text(data = big, aes(date, mm0, label = sprintf("%s: %.0f mm", format(date, "%b %d"), mm0)), vjust = -0.5, size = 3.3, fontface = "bold", color = "#b2182b") +
    scale_x_date(date_breaks = "1 month", date_labels = "%b", expand = c(0, 0), limits = c(d0, d0 + 470)) + scale_y_continuous(name = "daily rain (mm)", limits = c(0, max(lv$y) * 1.15), expand = c(0, 0)) +
    labs(title = "B.  The same words for a single day", subtitle = "Daily rain this water year, against the wettest day of each past year") + th
  if (!is.null(events)) pB <- pB + geom_vline(data = events, aes(xintercept = date), color = "grey60", linetype = "dotted") + geom_text(data = events, aes(x = date, y = max(lv$y) * 0.85, label = name), size = 3, color = "grey35", angle = 90, hjust = 1, vjust = -0.4)
  fig <- pA / pB + plot_layout(heights = c(1.7, 1)) + plot_annotation(caption = src, theme = theme(plot.caption = element_text(size = 9, color = "grey40")))
  ragg::agg_png(file, width = 14, height = 10, units = "in", res = 110, background = "white"); print(fig); dev.off(); invisible(list(rank = rk, total = sum(y$mm0), levels = lv)) }
# Run 2026-11-27: HNL (USW00022521), water years 1975-2025 (one site: Observatory Annex from Jan 1974) vs 2025-26.
