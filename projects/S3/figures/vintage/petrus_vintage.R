# petrus_vintage.R -- the market's own operation: Petrus 'on' and 'off' vintages, with Bordeaux weather as a possible explanation (S3, ch.8 backward; vintage).
# Kim + Claude, 2026-11-27. Kim: 'I like the Petrus example as they have already identified, by their standard (Bridgman again), what they call an "on" vintage.'
# Prices: Liv-ex Petrus brand sheet (April 2025), EUR per bottle, vintages 2008-2023 (petrus_livex_2025.csv). 'On' = priced in the upper band (EUR 3,500+), which holds
# every vintage Liv-ex itself named 'on' in the window (2009, 2010, 2015, 2016). Weather: GHCN-Daily FR000007510 (Bordeaux-Merignac, ~35 km from Pomerol), 1951-2026.
# Weather variables follow Ashenfelter (Bordeaux equation): growing-season mean temperature (Apr-Sep), harvest rain (Aug-Sep), winter rain (Oct-Mar before the vintage).
library(ggplot2); library(patchwork)
pv_read <- function(csv) { pr <- read.csv(csv, comment.char = "#"); pr$livex_named_on <- as.logical(pr$livex_named_on); pr }
pv_weather <- function(csv = "C:/temp/treerings/FR000007510.csv") {
  g <- read.csv(csv, stringsAsFactors = FALSE); g$date <- as.Date(g$DATE); g$t <- (g$TMAX + g$TMIN) / 20; g$p <- g$PRCP / 10
  g$y <- as.integer(format(g$date, "%Y")); g$m <- as.integer(format(g$date, "%m")); g <- g[g$y >= 1950, ]
  do.call(rbind, lapply(1951:max(g$y[g$m == 9]), function(V) data.frame(vintage = V,
    agst = mean(g$t[g$y == V & g$m %in% 4:9], na.rm = TRUE), harvest = sum(g$p[g$y == V & g$m %in% 8:9], na.rm = TRUE),
    winter = sum(g$p[(g$y == V - 1 & g$m %in% 10:12) | (g$y == V & g$m %in% 1:3)], na.rm = TRUE)))) }
pv_fig <- function(pr, w, file, cut = 3500, ref = 1991:2020) {
  pr$on <- pr$eur >= cut; d <- merge(pr, w); d$cls <- ifelse(d$on, "'on' vintage", "'off' vintage")
  cols <- c(`'on' vintage` = "#7b1f3a", `'off' vintage` = "#9a9a9a")
  th <- theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10))
  lo <- max(pr$eur[!pr$on]); hi <- min(pr$eur[pr$on])
  pA <- ggplot(d, aes(vintage, eur, fill = cls)) + annotate("rect", xmin = -Inf, xmax = Inf, ymin = lo, ymax = hi, fill = "#f3e6c8", alpha = 0.7) +
    geom_col(width = 0.75) +
    annotate("text", x = 2010.6, y = (lo + hi) / 2, label = sprintf("the gap: no vintage\npriced EUR %s-%s", format(lo, big.mark = ","), format(hi, big.mark = ",")), hjust = 0, size = 3.2, color = "#8c6d1f", fontface = "bold") + geom_text(aes(label = format(eur, big.mark = ",")), vjust = -0.4, size = 3.1) +
    geom_point(data = d[d$livex_named_on, ], aes(y = 150), shape = 8, size = 2.5, color = "white", show.legend = FALSE) +
    scale_fill_manual(values = cols, name = NULL) + scale_x_continuous(breaks = d$vintage, expand = c(0.01, 0)) + scale_y_continuous(name = "Market Price (EUR per bottle)", limits = c(0, max(d$eur) * 1.08), expand = c(0, 0)) + labs(x = NULL,
      title = "A.  The market's operation: Petrus 'on' and 'off' vintages, 2008-2023",
      subtitle = "Liv-ex Market Price per bottle (April 2025). The prices fall into two bands. White stars: vintages Liv-ex itself named 'on'. The newest vintages (2022, 2023) may carry a youth premium.") +
    th + theme(legend.position = c(0.01, 0.98), legend.justification = c(0, 1), panel.grid.major.x = element_blank())
  wr <- w[w$vintage %in% ref, ]; vars <- c(agst = "growing season, Apr-Sep: mean temperature (C)", harvest = "harvest, Aug-Sep: rain (mm)", winter = "winter before, Oct-Mar: rain (mm)")
  L <- do.call(rbind, lapply(names(vars), function(v) data.frame(var = vars[[v]], vintage = d$vintage, val = d[[v]], cls = d$cls)))
  R <- do.call(rbind, lapply(names(vars), function(v) data.frame(var = vars[[v]], q25 = quantile(wr[[v]], .25), q50 = median(wr[[v]]), q75 = quantile(wr[[v]], .75))))
  L$var <- factor(L$var, levels = vars); R$var <- factor(R$var, levels = vars)
  S <- do.call(rbind, lapply(names(vars), function(v) data.frame(var = factor(vars[[v]], levels = vars), lab = sprintf("mean: on %.1f, off %.1f", mean(d[[v]][d$on]), mean(d[[v]][!d$on])))))
  pB <- ggplot(L, aes(vintage, val)) + geom_rect(data = R, aes(xmin = -Inf, xmax = Inf, ymin = q25, ymax = q75), inherit.aes = FALSE, fill = "#e6ecf3") +
    geom_hline(data = R, aes(yintercept = q50), color = "#4a6fa5", linetype = "dashed") + geom_line(color = "grey80") + geom_point(aes(color = cls), size = 3) +
    geom_text(data = S, aes(x = 2007.6, y = Inf, label = lab), inherit.aes = FALSE, hjust = 0, vjust = 1.4, size = 3.2, color = "grey25") +
    facet_wrap(~var, ncol = 3, scales = "free_y") + scale_color_manual(values = cols, guide = "none") + scale_x_continuous(breaks = seq(2008, 2023, 3), name = NULL) + labs(y = NULL,
      title = "B.  The weather of each vintage, Bordeaux-Merignac", subtitle = sprintf("Blue band: middle half of %d-%d; dashed: median. The weather variables of Ashenfelter's Bordeaux equation.", min(ref), max(ref))) +
    th + theme(strip.text = element_text(face = "bold", hjust = 0))
  hist <- w[w$vintage < min(d$vintage), ]
  pC <- ggplot() + geom_vline(xintercept = median(wr$agst), color = "#4a6fa5", linetype = "dashed") + geom_hline(yintercept = median(wr$harvest), color = "#4a6fa5", linetype = "dashed") +
    geom_point(data = hist, aes(agst, harvest), color = "grey85", size = 1.8) +
    geom_point(data = d, aes(agst, harvest, color = cls), size = 3.4) + ggrepel::geom_text_repel(data = d, aes(agst, harvest, label = vintage, color = cls), size = 3.2, show.legend = FALSE, min.segment.length = 0.2, seed = 1) +
    annotate("text", x = max(w$agst), y = min(w$harvest), label = "warm and dry at harvest", hjust = 1, vjust = 0, size = 3.5, fontface = "bold", color = "#7b1f3a") +
    annotate("text", x = min(w$agst), y = max(w$harvest), label = "cool and wet at harvest", hjust = 0, vjust = 1, size = 3.5, fontface = "bold", color = "grey40") +
    scale_color_manual(values = cols, guide = "none") + labs(x = "growing-season mean temperature, Apr-Sep (C)", y = "harvest rain, Aug-Sep (mm)",
      title = "C.  Temperature against harvest rain", subtitle = sprintf("Grey: vintages %d-%d (no prices here), for context. Dashed: %d-%d medians.", min(hist$vintage), max(hist$vintage), min(ref), max(ref))) + th
  ct <- with(d, c(on_warm = sum(on & agst > median(wr$agst)), n_on = sum(on), off_warm = sum(!on & agst > median(wr$agst)), n_off = sum(!on)))
  txt <- paste("Reading the chart", "",
    paste(strwrap("The market drew the line, not a critic's scale: the prices split into two bands with a gap between them. That is an operational definition of a good year (Bridgman), made by people paying for it.", 60), collapse = "\n"), "",
    paste(strwrap(sprintf("The weather offers a possible explanation: %d of %d 'on' vintages had a growing season warmer than the 1991-2020 median; %d of %d 'off' vintages did.", ct["on_warm"], ct["n_on"], ct["off_warm"], ct["n_off"]), 60), collapse = "\n"), "",
    paste(strwrap("Possible, not proven: 16 vintages, one estate, one weather station, and much of the window is warmer than the old normal. Ashenfelter fitted the same variables to many vintages of many chateaux. Here the point is the scale: a vintage is one growing season -- a stretch -- judged long afterward.", 60), collapse = "\n"), sep = "\n")
  pD <- ggplot() + annotate("rect", xmin = 0, xmax = 1, ymin = -0.1, ymax = 1, fill = "#f7f0f2", color = "#7b1f3a") + annotate("text", x = 0.04, y = 0.95, label = txt, hjust = 0, vjust = 1, size = 3.3, lineheight = 1.08) +
    xlim(0, 1) + ylim(-0.1, 1) + labs(title = "D.  A good year, defined by those who pay for it") + theme_void(base_size = 12) + theme(plot.title = element_text(face = "bold", size = 12))
  fig <- pA / pB / (pC | pD) + plot_layout(heights = c(1, 0.85, 1.25)) + plot_annotation(
    caption = "Prices: Liv-ex, Petrus brand sheet (April 2025), Market Price EUR per 75 cl bottle; Liv-ex 'on-vintages' named in its Petrus profile (2005, 2009, 2010, 2015, 2016). 'On' here: EUR 3,500 or more.\nWeather: NOAA GHCN-Daily FR000007510 (Bordeaux-Merignac). Variables after Ashenfelter, Ashmore and Lalonde (1995), 'Bordeaux wine vintage quality and the weather', Chance 8(4). Code: petrus_vintage.R.",
    theme = theme(plot.caption = element_text(size = 9, color = "grey40", hjust = 0)))
  ragg::agg_png(file, width = 15, height = 14, units = "in", res = 110, background = "white"); print(fig); dev.off(); invisible(d) }
