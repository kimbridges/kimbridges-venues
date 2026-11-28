# return_periods.R -- what "a 100-year event" means over a span of years and across many places (S3, ch.10). Kim + Claude, 2026-11-27.
# P(at least one event in n years) = 1 - (1 - 1/T)^n for return period T (annual exceedance probability 1/T, independent years).
# P(at least one of M independent places passes its own T-year line in a year) = 1 - (1 - 1/T)^M.
library(ggplot2); library(patchwork)
rp_p <- function(T, n) 1 - (1 - 1 / T)^n
rp_fig <- function(file, Ts = c(10, 50, 100, 500, 1000), spans = c(`one year` = 1, `a 30-year mortgage` = 30, `a lifetime (80 years)` = 80), M_mark = c(19, 182)) {
  cols <- setNames(c("#fdae61", "#f46d43", "#d73027", "#a50026", "#5e0018"), paste0(Ts, "-year"))
  d <- expand.grid(T = Ts, n = 1:100); d$p <- rp_p(d$T, d$n); d$lab <- factor(paste0(d$T, "-year"), levels = names(cols))
  mk <- expand.grid(T = Ts, n = spans); mk$p <- rp_p(mk$T, mk$n); mk$lab <- factor(paste0(mk$T, "-year"), levels = names(cols))
  th <- theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10), legend.position = "none")
  endl <- d[d$n == 100, ]
  pA <- ggplot(d, aes(n, p, color = lab)) + geom_vline(xintercept = spans, color = "grey80", linetype = "dashed") +
    geom_line(linewidth = 1.1) + geom_point(data = mk, size = 2.3) +
    geom_text(data = mk[(mk$T == 100) | (mk$T == 10 & mk$n == 30) | (mk$T == 1000 & mk$n == 80) | (mk$T == 50 & mk$n == 80), ], aes(label = sprintf("%.0f%%", 100 * p)), hjust = -0.25, vjust = 1.3, size = 3.5, fontface = "bold", show.legend = FALSE) +
    geom_text(data = endl, aes(x = 101, label = sprintf("%s event", lab)), hjust = 0, size = 3.6, fontface = "bold") +
    annotate("label", x = spans, y = 1.09, label = names(spans), size = 3.4, color = "grey30", label.size = 0, fill = "white", hjust = c(0, 0.5, 0.5)) +
    scale_color_manual(values = cols) + scale_x_continuous(breaks = c(1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100), limits = c(0, 122), name = "span of years") +
    scale_y_continuous(labels = scales::percent, breaks = seq(0, 1, 0.2), limits = c(0, 1.12), name = "chance of at least one") +
    labs(title = "A.  'A 100-year event' is a 1% chance each year, not a schedule",
         subtitle = "Chance of seeing at least one event of each size over a span of years. A 100-year flood has a 26% chance during a 30-year mortgage, 55% in a lifetime.") + th
  dm <- expand.grid(T = c(100, 1000), M = 1:400); dm$p <- rp_p(dm$T, dm$M); dm$lab <- factor(paste0(dm$T, "-year"), levels = names(cols))
  mm <- expand.grid(T = c(100, 1000), M = M_mark); mm$p <- rp_p(mm$T, mm$M); mm$lab <- factor(paste0(mm$T, "-year"), levels = names(cols))
  pB <- ggplot(dm, aes(M, p, color = lab)) + geom_line(linewidth = 1.1) + geom_vline(xintercept = M_mark, color = "grey80", linetype = "dashed") + geom_point(data = mm, size = 2.3) +
    geom_text(data = mm, aes(label = sprintf("%.0f%%", 100 * p)), hjust = -0.25, vjust = 1.2, size = 3.4, fontface = "bold") +
    geom_text(data = dm[dm$M == 400, ], aes(x = 405, label = sprintf("%s line", lab)), hjust = 0, size = 3.6, fontface = "bold") +
    annotate("text", x = M_mark, y = 1.04, label = c("19 gauges", "182 gauges"), size = 3.4, color = "grey30") +
    scale_color_manual(values = cols) + scale_x_continuous(limits = c(0, 490), breaks = seq(0, 400, 100), name = "number of rain gauges, each with its own record") +
    scale_y_continuous(labels = scales::percent, breaks = seq(0, 1, 0.2), limits = c(0, 1.06), name = "chance that at least one passes its line this year") +
    labs(title = "B.  Many gauges: somewhere, someone's 100-year line is crossed",
         subtitle = "Curves assume independent gauges: then about 1 gauge in 1,000 would pass its 1,000-year line in a year.\nIn Jan-Feb 1969 Southern California reported 19 stations beyond the 1,000-year storm -- big storms reach many gauges at once.") + th
  fig <- pA / pB + plot_annotation(caption = "Annual exceedance probability = 1 / return period (USGS: the '100-year flood' is the 1-percent AEP flood). Years and gauges treated as independent; storms within one wet season are not,\nwhich is how 'a 100-year event' can come twice in a month (Southern California, January and February 1969).\nSources: USGS Water Science School; NWS 'Significant California Floods'; Orange County / Santa Ana flood histories. Code: return_periods.R.",
    theme = theme(plot.caption = element_text(size = 9, color = "grey40", hjust = 0)))
  ragg::agg_png(file, width = 13, height = 11, units = "in", res = 110, background = "white"); print(fig); dev.off()
  invisible(mk) }
