# fire_return.R -- the fire return interval is set by accumulation (S3, ch.4, ch.10). Kim + Claude, 2026-11-27.
# Kim: 'For a forest fire, the fuel is lost in the fire. It can take years for there to be enough accumulation for a similar fire to occur.
#       It's the biological process that extends the return, sometimes beyond a human's memory.'
# Panel A is a MODEL (illustration, not data): the same ignitions (snaps) and dry spells (spells) fall on two kinds of vegetation;
# fuel accumulates logistically (the stretch); a fire happens only when an ignition meets a dry spell while fuel exceeds a threshold;
# the fire resets the fuel. Panel B: historical fire regime groups (LANDFIRE) against human time spans.
library(ggplot2); library(patchwork)
fire_sim <- function(years = 300, seed = 1973, p_dry = 0.25, lambda_ign = 1.5, thr = 0.6, f0 = 0.03,
                     rates = c(`native forest (slow regrowth)` = 0.08, `invasive grass (fast regrowth)` = 2.5)) {
  set.seed(seed); dry <- runif(years) < p_dry; ign <- rpois(years, lambda_ign) > 0
  out <- do.call(rbind, lapply(names(rates), function(nm) { r <- rates[[nm]]; F <- numeric(years); f <- 0.5; fire <- logical(years)
    for (t in seq_len(years)) { f <- f + r * f * (1 - f); f <- min(f, 1); if (dry[t] && ign[t] && f > thr) { fire[t] <- TRUE; F[t] <- f; f <- f0 } else F[t] <- f }
    data.frame(veg = nm, year = seq_len(years), fuel = F, fire = fire) }))
  list(d = out, dry = dry, ign = ign, thr = thr) }
fire_fig <- function(S, file, show = 1:150) {
  d <- S$d[S$d$year %in% show, ]; ev <- data.frame(year = show, dry = S$dry[show], ign = S$ign[show])
  ri <- sapply(split(S$d, S$d$veg), function(z) mean(diff(z$year[z$fire])))
  d$veg <- factor(d$veg, levels = unique(S$d$veg)); lev <- levels(d$veg)
  cols <- setNames(c("#1b7837", "#c7a252"), lev)
  th <- theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10))
  pW <- ggplot(ev) + geom_tile(data = ev[ev$dry, ], aes(year, 1, width = 0.9, height = 1), fill = "#e8c27a") +
    geom_point(data = ev[ev$ign, ], aes(year, 1.75), shape = 17, size = 1.6, color = "#b2182b") +
    annotate("text", x = min(show) - 2, y = c(1, 1.75), label = c("dry spell (the load)", "ignition: lightning or a spark (the snap)"), hjust = 1, size = 3.3) +
    scale_x_continuous(limits = c(min(show) - 55, max(show) + 1), expand = c(0, 0)) + scale_y_continuous(limits = c(0.4, 2.2), breaks = NULL) +
    labs(title = "A.  Same weather, different biology: a model of fuel, dry spells and ignitions", subtitle = "Top: the same random dry spells and ignitions fall on both landscapes. Below: fuel accumulates after each fire (the stretch); a fire happens only when an ignition meets a dry spell\nwhile fuel is above the threshold, and the fire resets the fuel. The weather sets the chances; regrowth sets the return interval.", x = NULL, y = NULL) +
    th + theme(axis.text.x = element_blank(), panel.grid = element_blank())
  pF <- ggplot(d, aes(year, fuel, color = veg)) + geom_hline(yintercept = S$thr, linetype = "dashed", color = "grey40") +
    geom_line(linewidth = 0.8) + geom_point(data = d[d$fire, ], aes(year, fuel), shape = 8, size = 2.6, color = "#b2182b", stroke = 1) +
    facet_wrap(~veg, ncol = 1, labeller = labeller(veg = function(v) sprintf("%s:  %s, mean return interval about %.0f years", v, ifelse(grepl("forest", v), "fuel-limited (waits for fuel)", "weather-limited (waits for a dry spell)"), ri[v]))) +
    annotate("text", x = min(show) - 2, y = S$thr, label = "fuel needed to carry a fire", hjust = 1, vjust = -0.5, size = 3.2, color = "grey30") +
    scale_color_manual(values = cols, guide = "none") + scale_x_continuous(limits = c(min(show) - 55, max(show) + 1), expand = c(0, 0), breaks = seq(0, max(show), 25), name = "years (model time)") +
    scale_y_continuous(breaks = c(0, 0.5, 1), labels = c("none", "", "full"), name = "fuel") + th + theme(strip.text = element_text(face = "bold", hjust = 0))
  sp <- data.frame(lab = c("a year", "a generation (~25 y)", "a lifetime (~80 y)", "written records in Hawai'i (~200 y)"), y = c(1, 25, 80, 200))
  fr <- data.frame(g = c("Regimes I-II", "Regimes III-IV", "Regime V"), lo = c(1, 35, 200), hi = c(35, 200, 1000), row = 3:1,
                   lab = c("Fire Regimes I-II: return interval 35 years or less", "Fire Regimes III-IV: 35 to 200 years", "Fire Regime V: more than 200 years"))
  pT <- ggplot() + geom_vline(data = sp, aes(xintercept = y), linetype = "dotted", color = "grey40") + geom_rect(data = fr, aes(xmin = lo, xmax = hi, ymin = row - 0.35, ymax = row + 0.35), fill = c("#fdae61", "#d7191c", "#7b3294"), alpha = 1) +
    geom_text(data = fr, aes(x = sqrt(lo * hi), y = row, label = lab), size = 3.4, color = "white", fontface = "bold") +
    geom_segment(aes(x = 12, xend = 525, y = 0.15, yend = 0.15), linewidth = 1.6, color = "#1b7837") +
    annotate("text", x = sqrt(12 * 525), y = -0.15, label = "Hawai'i's native settings, historical mean fire return intervals: 12 to 525 years (LANDFIRE models, via FEIS)", size = 3.3, color = "#1b7837") +
    annotate("segment", x = 300, xend = 2.2, y = -0.6, yend = -0.6, arrow = arrow(length = unit(0.25, "cm")), linewidth = 0.9, color = "#c7a252") +
    annotate("text", x = 26, y = -0.85, label = "the grass/fire cycle: nonnative grasses regrow fuel fast and pull the return interval toward a few years", size = 3.3, color = "#8c6d1f") +
    geom_text(data = sp, aes(x = y, y = 4.0, label = lab), angle = 0, hjust = 0, nudge_x = 0.02, size = 3.2, color = "grey25") +
    scale_x_log10(breaks = c(1, 3, 10, 30, 100, 300, 1000), limits = c(1, 1000), name = "years between fires (log scale)") + scale_y_continuous(limits = c(-1.1, 4.3), breaks = NULL, name = NULL) +
    labs(title = "B.  How often places burn, against how long people remember", subtitle = "Many forests burn on intervals longer than a lifetime, so each fire arrives as a surprise. Fast fuels shorten the interval -- and change what the landscape is.") + th
  fig <- (pW / pF / pT) + plot_layout(heights = c(0.55, 1.6, 1.25)) + plot_annotation(
    caption = "Panel A is a model, not data: logistic fuel regrowth (rate 0.08 vs 2.5 per year), dry spells in 25% of years, ignitions in 78% of years, fuel threshold 0.6; the same random weather for both rows (seed 1973). Code: fire_return.R.\nPanel B: LANDFIRE Fire Regime Groups (USGS); Hawai'i mean fire return intervals from the USFS Fire Effects Information System (Hawai'i fire regimes); grass/fire cycle: Hughes, Vitousek and Tunison 1991; D'Antonio and Vitousek 1992.",
    theme = theme(plot.caption = element_text(size = 9, color = "grey40", hjust = 0)))
  ragg::agg_png(file, width = 14, height = 12, units = "in", res = 110, background = "white"); print(fig); dev.off(); invisible(ri) }
