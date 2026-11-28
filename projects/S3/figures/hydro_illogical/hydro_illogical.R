# hydro_illogical.R -- the hydro-illogical cycle measured: concern ends with the first heavy rain (a snap); the deficit (a stretch) ends much later (S3, ch.8/ch.10).
# Kim + Claude, 2026-11-27. Cycle: D. A. Wilhite, National Drought Mitigation Center (drought -> awareness -> concern -> panic -> rain -> apathy).
# Operations (Bridgman): drought episode = 12-month rain below thr% of the median for min_days+; 'first inch' = first day >= 25.4 mm after the episode's low point;
# 'back to median' = first day after the low when the 12-month total reaches the median; apathy gap = back_to_median - first_inch. Episodes whose recovery overlaps the next are merged.
# Data: GHCN-Daily USW00022521 (Honolulu Intl Airport), from 1974-10-01 (after the Jan 1974 instrument move). 12-month total: trailing 365 days.
library(ggplot2); library(patchwork)
hi_daily <- function(csv = "C:/temp/drought_live/USW00022521.csv", start = "1974-10-01") {
  g <- read.csv(csv, stringsAsFactors = FALSE); g$date <- as.Date(g$DATE); g$mm <- g$PRCP / 10
  x <- data.frame(date = seq(as.Date(start), max(g$date[!is.na(g$mm)]), by = "day")); x <- merge(x, g[, c("date", "mm")], all.x = TRUE)
  x$miss <- is.na(x$mm); x$mm[x$miss] <- 0; x$r12 <- as.numeric(stats::filter(x$mm, rep(1, 365), sides = 1))
  attr(x, "med12") <- median(x$r12, na.rm = TRUE); x$pct <- 100 * x$r12 / attr(x, "med12"); x }
hi_episodes <- function(x, thr = 70, min_days = 90, heavy = 25.4) {
  dr <- !is.na(x$pct) & x$pct < thr; r <- rle(dr); e <- cumsum(r$lengths); s <- e - r$lengths + 1
  ep <- data.frame(s = s[r$values], e = e[r$values]); ep <- ep[ep$e - ep$s + 1 >= min_days, ]
  rec_of <- function(s, e) { b <- s - 1 + which.min(x$pct[s:e]); b - 1 + which(x$pct[b:nrow(x)] >= 100)[1] }
  m <- list(); i <- 1
  while (i <= nrow(ep)) { s0 <- ep$s[i]; e0 <- ep$e[i]; rc <- rec_of(s0, e0)
    while (i < nrow(ep) && !is.na(rc) && ep$s[i + 1] <= rc) { i <- i + 1; e0 <- ep$e[i]; rc <- rec_of(s0, e0) }
    m[[length(m) + 1]] <- c(s0, e0); i <- i + 1 }
  do.call(rbind, lapply(m, function(v) { s <- v[1]; e <- v[2]; b <- s - 1 + which.min(x$pct[s:e]); rc <- b - 1 + which(x$pct[b:nrow(x)] >= 100)[1]
    hv <- b - 1 + which(x$mm[b:nrow(x)] >= heavy)[1]; nh <- if (is.na(rc)) NA else sum(x$mm[hv:rc] >= heavy)
    data.frame(start = x$date[s], end_dry = x$date[e], low = x$date[b], low_pct = x$pct[b], first_inch = x$date[hv], back = x$date[rc],
               gap = as.integer(x$date[rc] - x$date[hv]), n_heavy = nh) })) }
hi_fig <- function(x, ep, file, zoom = c("1997-10-01", "2002-12-31")) {
  med <- attr(x, "med12"); ep$lab <- ifelse(format(ep$start, "%Y") == format(ep$back, "%Y"), format(ep$start, "%Y"), paste0(format(ep$start, "%Y"), "-", format(ep$back, "%y")))
  cB <- c(low = "#b2182b", inch = "#2c5c8f", back = "#1b7837", gap = "#d9822b")
  th <- theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10))
  xa <- x[!is.na(x$pct), ]; top <- max(xa$pct) * 1.04
  pA <- ggplot(xa, aes(date, pct)) +
    geom_rect(data = ep, aes(xmin = start, xmax = end_dry, ymin = -Inf, ymax = Inf), inherit.aes = FALSE, fill = "#e8c27a", alpha = 0.35) +
    geom_hline(yintercept = c(70, 100), linetype = c("dashed", "solid"), color = c("#b2182b", "grey30"), linewidth = 0.4) +
    geom_line(linewidth = 0.45, color = "grey20") +
    geom_segment(data = ep, aes(x = first_inch, xend = back, y = -12, yend = -12), inherit.aes = FALSE, color = cB["gap"], linewidth = 3) +
    geom_point(data = ep, aes(low, low_pct), inherit.aes = FALSE, color = cB["low"], size = 2.4) +
    geom_point(data = ep, aes(first_inch, x$pct[match(first_inch, x$date)]), inherit.aes = FALSE, color = cB["inch"], shape = 17, size = 2.8) +
    geom_point(data = ep, aes(back, 100), inherit.aes = FALSE, color = cB["back"], shape = 15, size = 2.6) +
    geom_text(data = ep, aes(x = start + (back - start) / 2, y = top, label = lab), inherit.aes = FALSE, size = 3.2, vjust = 1, fontface = "bold", color = "grey25") +
    annotate("label", fill = "white", label.size = 0, label.padding = unit(0.1, "lines"), x = min(xa$date) + 60, y = c(103, 73), label = c(sprintf("median 12-month rain (%.0f mm)", med), "drought: below 70% of median"), hjust = 0, vjust = 0, size = 3.2, color = c("grey30", "#b2182b")) +
    annotate("text", x = max(xa$date), y = -12, label = "orange bar: the apathy gap", hjust = 1, vjust = -1.2, size = 3.2, color = cB["gap"], fontface = "bold") +
    scale_x_date(date_breaks = "5 years", date_labels = "%Y", expand = c(0.01, 0)) + scale_y_continuous(limits = c(-20, top), breaks = c(0, 50, 100, 150, 200, 250), name = "rain in the past 12 months (% of median)") +
    labs(title = "A.  Fifty years of droughts at Honolulu airport, and how long each one really lasted",
         subtitle = "Each drought: its low point (red dot), the first 1-inch rain after it (blue triangle: concern ends), and the day the 12-month total got back to median (green square: the deficit ends).", x = NULL) + th
  z0 <- as.Date(zoom[1]); z1 <- as.Date(zoom[2]); xz <- x[x$date >= z0 & x$date <= z1, ]; ez <- ep[ep$first_inch >= z0 & ep$first_inch <= z1, ][1, ]
  hv <- xz[xz$mm >= 25.4, ]; nb <- sum(hv$date >= ez$first_inch & hv$date <= ez$back)
  vl <- data.frame(d = c(ez$low, ez$first_inch, ez$back), k = c("low", "inch", "back"))
  pB1 <- ggplot(xz, aes(date, pct)) + geom_hline(yintercept = c(70, 100), linetype = c("dashed", "solid"), color = c("#b2182b", "grey30"), linewidth = 0.4) +
    annotate("rect", xmin = ez$first_inch, xmax = ez$back, ymin = -Inf, ymax = Inf, fill = cB["gap"], alpha = 0.12) +
    geom_vline(data = vl, aes(xintercept = d), color = cB[vl$k], linewidth = 0.7) + geom_line(linewidth = 0.8, color = "grey15") +
    annotate("text", x = ez$low, y = 140, label = sprintf("low point\n%s: %.0f%%", format(ez$low, "%b %Y"), ez$low_pct), color = cB["low"], hjust = 1.05, size = 3.2, fontface = "bold") +
    annotate("text", x = ez$first_inch, y = 140, label = sprintf("first inch\n%s", format(ez$first_inch, "%b %d, %Y")), color = cB["inch"], hjust = -0.05, size = 3.2, fontface = "bold") +
    annotate("text", x = ez$back, y = 140, label = sprintf("back to median\n%s", format(ez$back, "%b %Y")), color = cB["back"], hjust = 1.05, size = 3.2, fontface = "bold") +
    annotate("text", x = ez$first_inch + as.numeric(ez$back - ez$first_inch) / 2, y = 15, label = sprintf("the apathy gap: %d days (%.1f years)", ez$gap, ez$gap / 365.25), color = "#a0522d", size = 3.6, fontface = "bold") +
    scale_x_date(limits = c(z0, z1), date_breaks = "1 year", date_labels = "%Y", expand = c(0, 0)) + scale_y_continuous(limits = c(0, 160), name = "12-month rain\n(% of median)") +
    labs(title = sprintf("B.  Close-up: the %s drought -- the stretch (above) and the snaps (below)", ez$lab), subtitle = "The 12-month total is the state of the water account. Daily rain is what people see and remember.", x = NULL) + th + theme(axis.text.x = element_blank())
  pB2 <- ggplot(xz, aes(date, mm)) + annotate("rect", xmin = ez$first_inch, xmax = ez$back, ymin = -Inf, ymax = Inf, fill = cB["gap"], alpha = 0.12) +
    geom_col(width = 1, fill = "grey55") + geom_col(data = hv, width = 3, fill = cB["inch"]) + geom_hline(yintercept = 25.4, linetype = "dotted", color = cB["inch"]) +
    annotate("text", x = z0 + 20, y = 25.4, label = "1 inch", hjust = 0, vjust = -0.4, size = 3.1, color = cB["inch"]) +
    annotate("text", x = ez$first_inch + as.numeric(ez$back - ez$first_inch) / 2, y = max(xz$mm) * 0.92, label = sprintf("%d days of an inch or more (the first included) fell in the gap; the deficit stayed", nb), size = 3.3, color = cB["inch"], fontface = "bold") +
    scale_x_date(limits = c(z0, z1), date_breaks = "1 year", date_labels = "%Y", expand = c(0, 0)) + scale_y_continuous(name = "daily rain (mm)") + labs(x = NULL) + th
  ph <- c("apathy", "drought", "awareness", "concern", "panic", "rain"); ang <- pi / 2 - (0:5) * 2 * pi / 6
  cy <- data.frame(ph = ph, x = cos(ang), y = sin(ang)); cy$nx <- c(cy$x[-1], cy$x[1]); cy$ny <- c(cy$y[-1], cy$y[1])
  cy$col <- c("grey45", "#c7a252", "#d9822b", "#d6604d", "#b2182b", "#2c5c8f")
  pC <- ggplot(cy) + geom_curve(aes(x = x * 0.86 + (nx - x) * 0.12, y = y * 0.86 + (ny - y) * 0.12, xend = nx * 0.86 - (nx - x) * 0.12, yend = ny * 0.86 - (ny - y) * 0.12),
      curvature = -0.25, arrow = arrow(length = unit(0.22, "cm")), color = "grey40", linewidth = 0.6) +
    geom_point(aes(x * 0.86, y * 0.86), size = 21, color = cy$col) + geom_text(aes(x * 0.86, y * 0.86, label = ph), color = "white", fontface = "bold", size = 3.0) +
    annotate("text", x = 1.28, y = 0.05, label = "the STRETCH:\nthe deficit builds\nfor months to years;\nconcern grows with it", hjust = 0, size = 3.2, color = "#a0522d") +
    annotate("text", x = -1.12, y = 0.43, label = "the SNAP:\none wet day", hjust = 1, size = 3.2, color = "#2c5c8f", fontface = "bold") +
    annotate("text", x = -0.55, y = 1.12, label = "concern ends;\nthe deficit does not\n(the apathy gap)", hjust = 1, size = 3.2, color = "grey30") +
    coord_equal(xlim = c(-2.3, 2.3), ylim = c(-1.25, 1.25)) +
    labs(title = "C.  The hydro-illogical cycle (Wilhite, NDMC)", subtitle = "People judge a stretch by a snap.") + theme_void(base_size = 12) +
    theme(plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10))
  ep2 <- ep[!is.na(ep$gap), ]; ep2$lab2 <- sprintf("%s (low %.0f%%)", ep2$lab, ep2$low_pct); ep2$lab2 <- factor(ep2$lab2, levels = ep2$lab2[order(ep2$gap)])
  rf <- data.frame(d = c(7, 91, 365, 730), lab = c("a week", "a season", "a year", "two years"))
  pD <- ggplot(ep2, aes(pmax(gap, 1), lab2)) + geom_vline(data = rf, aes(xintercept = d), linetype = "dotted", color = "grey45") +
    geom_text(data = rf, aes(x = d, y = nrow(ep2) + 0.75, label = lab), hjust = -0.08, size = 3.1, color = "grey30") +
    geom_segment(aes(x = 1, xend = pmax(gap, 1), yend = lab2), color = cB["gap"], linewidth = 4) +
    geom_text(aes(label = sprintf("%d days; %d one-inch rain days came and went", gap, n_heavy)), hjust = -0.05, size = 3.1, color = "grey20") +
    scale_x_log10(limits = c(1, 4000), breaks = c(1, 7, 30, 91, 365, 730), labels = c("1", "7", "30", "91", "365", "730"), name = "apathy gap: days from the first 1-inch rain to the end of the deficit (log scale)") +
    scale_y_discrete(expand = expansion(add = c(0.6, 1.2)), name = NULL) +
    labs(title = "D.  The apathy gap, drought by drought", subtitle = "Deep droughts tend to have the longest gaps: the deficit outlives the rain that ends the worry by a season, a year, or more.") + th + theme(panel.grid.major.y = element_blank())
  fig <- pA / ((pB1 / pB2 + plot_layout(heights = c(1.3, 1))) | pC) / pD + plot_layout(heights = c(1.15, 1.25, 0.95)) + plot_annotation(
    caption = sprintf("Data: NOAA GHCN-Daily USW00022521 (Honolulu Intl Airport), 1974-10-01 to %s; trailing 365-day totals. Drought: 12-month rain below 70%% of median for 90+ days; overlapping episodes merged. First inch: first day of 25.4 mm or more after the low point.\nCycle: D. A. Wilhite, National Drought Mitigation Center (University of Nebraska-Lincoln). Code: hydro_illogical.R.", format(max(x$date), "%b %d, %Y")),
    theme = theme(plot.caption = element_text(size = 9, color = "grey40", hjust = 0)))
  ragg::agg_png(file, width = 15, height = 15, units = "in", res = 110, background = "white"); print(fig); dev.off(); invisible(fig) }
