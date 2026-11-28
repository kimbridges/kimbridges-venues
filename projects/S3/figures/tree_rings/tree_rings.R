# tree_rings.R -- measuring rings, not counting them: ring widths record the weather of each growing season (S3, ch.5 recorders; ch.3 event year).
# Kim + Claude, 2026-11-27. Kim: 'many people think of counting the rings, not doing measurements.'
# Data: Schulman Old Tree No. 1, Mesa Verde, Colorado (Douglas-fir, 35 cores, 1176-1963; ITRDB co021, shipped with dplR; Schulman 1963).
#       Precipitation: GHCN-Daily USC00055531 (Mesa Verde NP), from 1922. Detrending: dplR::detrend(method = "ModNegExp"); chronology: dplR::chron().
library(ggplot2); library(patchwork); library(dplR)
tr_prep <- function(prcp_csv = "C:/temp/treerings/USC00055531.csv") {
  data(co021, package = "dplR", envir = environment()); rw <- co021; yrs <- as.integer(rownames(rw))
  rwi <- detrend(rw, method = "ModNegExp"); cr <- chron(rwi); cr$year <- as.integer(rownames(cr))
  g <- read.csv(prcp_csv, stringsAsFactors = FALSE); g$date <- as.Date(g$DATE); g$mm <- g$PRCP / 10; g$y <- as.integer(format(g$date, "%Y")); g$m <- as.integer(format(g$date, "%m"))
  mo <- aggregate(cbind(mm = mm, n = !is.na(mm)) ~ y + m, g, function(v) sum(v, na.rm = TRUE), na.action = na.pass); mo$ok <- mo$n >= 25
  win <- function(prev, cur, Y) { a <- mo[(mo$y == Y - 1 & mo$m %in% prev) | (mo$y == Y & mo$m %in% cur), ]; if (nrow(a) == length(prev) + length(cur) && all(a$ok)) sum(a$mm) else NA }
  W <- list(`calendar year (Jan-Dec)` = list(integer(0), 1:12), `water year (Oct-Sep)` = list(10:12, 1:9), `Sep-Jul` = list(9:12, 1:7), `Oct-Jun` = list(10:12, 1:6))
  P <- data.frame(year = 1923:max(yrs)); for (k in names(W)) P[[k]] <- sapply(P$year, function(Y) win(W[[k]][[1]], W[[k]][[2]], Y))
  P <- merge(P, cr[, c("year", "std")]); rr <- sapply(names(W), function(k) c(r = cor(P[[k]], P$std, use = "complete"), n = sum(!is.na(P[[k]]))))
  list(rw = rw, yrs = yrs, rwi = rwi, cr = cr, P = P, rr = rr) }
tr_fig <- function(D, file, strip = 1900:1963, pick = NULL) {
  rw <- D$rw; yrs <- D$yrs; cr <- D$cr
  ok <- names(rw)[sapply(rw, function(v) all(!is.na(v[yrs %in% strip])))]
  if (is.null(pick)) { cm <- cor(rw[yrs %in% strip, ok]); diag(cm) <- NA; mn <- colMeans(rw[yrs %in% strip, ok]); i <- which(cm == max(cm, na.rm = TRUE), arr.ind = TRUE)[1, ]; pick <- ok[i] }
  crs <- cr[cr$year %in% strip, ]; nar <- head(crs$year[order(crs$std)], 5)
  th <- theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10))
  core <- do.call(rbind, lapply(seq_along(pick), function(j) { w <- rw[yrs %in% strip, pick[j]]; e <- cumsum(w); data.frame(core = j, year = strip, w = w, x0 = e - w, x1 = e) }))
  core$y <- 2.6 - (core$core - 1) * 1.6; core$nar <- core$year %in% nar
  lab <- core[core$nar, ]; lab <- lab[order(lab$core, lab$x1), ]; lab$dy <- ave(lab$x1, lab$core, FUN = function(v) c(0, ifelse(diff(v) < 0.8, 0.28, 0))); lnk <- reshape(lab[, c("year", "core", "x1")], idvar = "year", timevar = "core", direction = "wide")
  pA <- ggplot(core) + geom_rect(aes(xmin = x0, xmax = x1, ymin = y - 0.45, ymax = y + 0.45), fill = "#f1dfb8", color = NA) +
    geom_rect(aes(xmin = x1 - pmin(0.3 * w, 0.12), xmax = x1, ymin = y - 0.45, ymax = y + 0.45), fill = "#8c5a2b", color = NA) +
    geom_rect(data = lab, aes(xmin = x0, xmax = x1, ymin = y - 0.45, ymax = y + 0.45), fill = NA, color = "#b2182b", linewidth = 0.5) +
    geom_segment(data = lnk, aes(x = x1.1, xend = x1.2, y = 2.6 - 0.47, yend = 1.0 + 0.47), linetype = "dashed", color = "#b2182b", linewidth = 0.4) +
    geom_text(data = lab[lab$core == 1, ], aes(x = x1, y = y + 0.52 + dy, label = year), vjust = 0, size = 3.3, color = "#b2182b", fontface = "bold") +
    geom_text(data = core[core$core == 1 & core$year %% 10 == 0, ], aes(x = x0, y = y - 0.52, label = year), vjust = 1, size = 2.9, color = "grey35") +
    geom_text(data = core[core$core == 2 & core$year %% 10 == 0, ], aes(x = x0, y = y - 0.52, label = year), vjust = 1, size = 2.9, color = "grey35") +
    annotate("text", x = -0.3, y = c(2.6, 1.0), label = sprintf("core %s", pick), hjust = 1, size = 3.3) +
    annotate("text", x = max(core$x1), y = 3.62, label = "toward the bark (1963) -->", hjust = 1, size = 3.2, color = "grey30") +
    scale_x_continuous(name = sprintf("distance along the core from the %d ring (mm, measured)", min(strip)), limits = c(-3.2, max(core$x1) * 1.01), expand = c(0, 0)) +
    scale_y_continuous(limits = c(0.2, 3.7), breaks = NULL, name = NULL) +
    labs(title = sprintf("A.  Two cores from the same stand, %d-%d, drawn to their measured widths", min(strip), max(strip)),
         subtitle = sprintf("Dark bands: latewood, the end of each year. Red: the five narrowest years of the stand (%s). The trees grew at different rates,\nso the narrow years fall at different distances -- but in the same pattern. Matching that pattern (crossdating) is measurement; counting alone cannot do it.", paste(sort(nar), collapse = ", "))) +
    th + theme(panel.grid = element_blank())
  s1 <- names(rw)[which.max(colSums(!is.na(rw)))]; v <- rw[[s1]]; k <- !is.na(v); vv <- v[k]; names(vv) <- yrs[k]
  fit <- detrend.series(vv, method = "ModNegExp", make.plot = FALSE, return.info = TRUE)$curves
  b1 <- data.frame(year = yrs[k], w = vv, fit = as.numeric(fit)); z0 <- b1[b1$w == 0, ]
  pB1 <- ggplot(b1, aes(year)) + geom_line(aes(y = w), color = "grey35", linewidth = 0.3) + geom_line(aes(y = fit), color = "#1b7837", linewidth = 1.1) +
    annotate("text", x = min(b1$year) + 15, y = max(b1$w) * 0.95, label = "the expected width: rings narrow as the trunk grows (fitted curve)", hjust = 0, size = 3.2, color = "#1b7837", fontface = "bold") +
    geom_segment(data = z0, aes(x = year, xend = year, y = -0.12, yend = -0.02), color = "#b2182b", linewidth = 0.6) +
    annotate("text", x = 1560, y = max(b1$w) * 0.62, label = sprintf("red ticks: %d years with NO ring along this radius (locally absent).\nA count of this core comes up %d years short; crossdating with other cores finds them.", nrow(z0), nrow(z0)), hjust = 0, size = 3.3, color = "#b2182b", fontface = "bold") +
    scale_y_continuous(name = "ring width (mm)") + scale_x_continuous(limits = range(cr$year[cr$samp.depth >= 5]), name = NULL) +
    labs(title = sprintf("B.  From widths to weather: one core (%s, %d years), then the whole stand", s1, nrow(b1)),
         subtitle = "Top: raw widths and the growth curve the tree would follow in steady weather. Below: each year's width divided by the expected width, averaged over the cores --\nthe ring-width index. 1.0 is an ordinary year; below 1, a hard one.") + th
  c5 <- cr[cr$samp.depth >= 5, ]; c5$sm <- as.numeric(stats::filter(c5$std, rep(1 / 21, 21), sides = 2))
  pB2 <- ggplot(c5, aes(year)) + annotate("rect", xmin = 1276, xmax = 1299, ymin = -Inf, ymax = Inf, fill = "#e8c27a", alpha = 0.5) +
    annotate("text", x = 1301, y = max(c5$std) * 0.97, label = "1276-1299: the 'Great Drought' Douglass read in Mesa Verde timbers", hjust = 0, size = 3.2, color = "#8c6d1f", fontface = "bold") +
    geom_hline(yintercept = 1, color = "grey40") + geom_line(aes(y = std), color = "grey45", linewidth = 0.3) + geom_line(aes(y = sm), color = "#8c5a2b", linewidth = 1) +
    scale_x_continuous(limits = range(c5$year), name = NULL) + scale_y_continuous(name = "ring-width index") +
    annotate("text", x = max(c5$year), y = min(c5$std), label = "brown: 21-year running mean", hjust = 1, vjust = 0, size = 3.1, color = "#8c5a2b") + th
  P <- D$P; z <- function(v) (v - mean(v, na.rm = TRUE)) / sd(v, na.rm = TRUE)
  pc <- data.frame(year = rep(P$year, 2), val = c(z(P$`Oct-Jun`), z(P$std)), what = rep(c("Oct-Jun rain, Mesa Verde NP gauge", "ring-width index"), each = nrow(P)))
  rr <- D$rr; rtx <- paste(sprintf("%-24s r = %.2f", colnames(rr), rr["r", ]), collapse = "\n")
  pC <- ggplot(pc, aes(year, val, color = what)) + geom_hline(yintercept = 0, color = "grey50") + geom_line(linewidth = 0.9) + geom_point(size = 1.4) +
    scale_color_manual(values = c("#2c5c8f", "#8c5a2b"), name = NULL) +
    annotate("label", x = min(P$year) + 0.5, y = 4.6, label = paste0("Rain in which months?\n", rtx), hjust = 0, vjust = 1, size = 3.1, family = "mono", fill = "white", label.size = 0.2) +
    scale_y_continuous(name = "standardized (0 = average)", limits = c(-2.3, 4.7), breaks = -2:3) + scale_x_continuous(name = NULL) +
    labs(title = "C.  The check: the tree against the rain gauge", subtitle = sprintf("%d-%d. The tree reads the cool-season moisture before growth (Oct-Jun), not the calendar year: the event year again.", min(P$year), max(P$year))) +
    th + theme(legend.position = "top", legend.justification = "left")
  txt <- paste("Where this works, and where it doesn't",
    "",
    strwrap("Annual rings need an annual pause: a cold winter or a long dry season that stops growth and starts it again. Temperate trees like this Douglas-fir lay down one ring a year, and drought-limited ones write the rain into its width.", 66) |> paste(collapse = "\n"),
    "",
    strwrap("Most of the tropics -- Hawai'i included -- lack that pause. Growth runs year-round, boundaries are faint or missing, and a ring is not reliably a year. Some tropical trees with a strong dry season do form usable rings; most do not.", 66) |> paste(collapse = "\n"),
    "",
    strwrap("A measure works only where the process that makes it works. (Compare the seasonality measures in Seasonalityr.)", 66) |> paste(collapse = "\n"), sep = "\n")
  pD <- ggplot() + annotate("rect", xmin = 0, xmax = 1, ymin = -0.2, ymax = 1, fill = "#eef1f6", color = "#4a6fa5") +
    annotate("text", x = 0.04, y = 0.95, label = txt, hjust = 0, vjust = 1, size = 3.25, lineheight = 1.05) + xlim(0, 1) + ylim(-0.2, 1) +
    labs(title = "D.  A geographically limited measure") + theme_void(base_size = 12) + theme(plot.title = element_text(face = "bold", size = 12))
  fig <- pA / pB1 / pB2 / (pC | pD + plot_layout(widths = c(1.6, 1))) + plot_layout(heights = c(1, 0.8, 0.8, 1.15)) + plot_annotation(
    caption = "Data: Schulman Old Tree No. 1, Mesa Verde, Colorado -- Douglas-fir, 35 cores, 1176-1963 (Schulman 1963; International Tree-Ring Data Bank co021, distributed with the R package dplR). Index years shown where 5+ cores.\nPrecipitation: NOAA GHCN-Daily USC00055531 (Mesa Verde NP); months with fewer than 25 days reported are excluded. Detrending: dplR detrend(ModNegExp); chronology: chron(). Code: tree_rings.R.",
    theme = theme(plot.caption = element_text(size = 9, color = "grey40", hjust = 0)))
  ragg::agg_png(file, width = 15, height = 15, units = "in", res = 110, background = "white"); print(fig); dev.off(); invisible(list(pick = pick, nar = nar)) }
