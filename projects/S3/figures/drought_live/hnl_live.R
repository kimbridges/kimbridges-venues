# hnl_live.R -- a LIVE figure: the forward call made now, judged backward at the end of the wet season (S3, ch.8 forward/backward; drought). Kim + Claude, 2026-11-27.
# Kim: 'I like that forward statement vs judging it backward at the end.' HNL chosen by Kim.
# Rerun live_update() through the winter: data refresh, the figure redraws; the forward call is FROZEN in forward_call_wy2027.rds and never recomputed.
# Data: GHCN-Daily USW00022521 (Honolulu Intl Airport; PRCP tenths of mm), 1974-10-01 on (after the Jan 1974 instrument move, as in ch.2). CPC ONI (ERSST v5).
# Wet season = Oct 1 - Apr 30 (water year starts in the dry-season trough). ENSO class of a wet season = ONI for DJF of that season.
library(ggplot2); library(patchwork)
live_get <- function(tmp = "C:/temp/drought_live") {
  dir.create(tmp, showWarnings = FALSE)
  download.file("https://www.ncei.noaa.gov/data/global-historical-climatology-network-daily/access/USW00022521.csv", file.path(tmp, "USW00022521.csv"), mode = "wb", quiet = TRUE)
  download.file("https://www.cpc.ncep.noaa.gov/data/indices/oni.ascii.txt", file.path(tmp, "oni.txt"), mode = "wb", quiet = TRUE)
  g <- read.csv(file.path(tmp, "USW00022521.csv"), stringsAsFactors = FALSE); g$date <- as.Date(g$DATE); g$mm <- g$PRCP / 10
  x <- g[g$date >= as.Date("1974-10-01") & !is.na(g$mm), c("date", "mm")]
  x$wy <- as.integer(format(x$date, "%Y")) + (as.integer(format(x$date, "%m")) >= 10)
  x$wd <- as.integer(x$date - as.Date(sprintf("%d-10-01", x$wy - 1))) + 1
  x <- x[as.integer(format(x$date, "%m")) %in% c(10:12, 1:4), ]; x <- x[order(x$date), ]; x$cum <- ave(x$mm, x$wy, FUN = cumsum)
  list(x = x, oni = read.table(file.path(tmp, "oni.txt"), header = TRUE)) }
live_season <- function(L, ref = 1975:2026) {
  t <- aggregate(mm ~ wy, L$x[L$x$wy %in% ref, ], sum); d <- L$oni[L$oni$SEAS == "DJF", c("YR", "ANOM")]; names(d) <- c("wy", "oni")
  t <- merge(t, d); t$pct <- 100 * t$mm / median(t$mm); t$en <- t$oni >= 0.5; t$strong <- t$oni >= 1.5
  t$lab <- sprintf("%d-%02d", t$wy - 1, t$wy %% 100); t }
live_call <- function(L, t, yr = 2027, file, when = Sys.Date()) {   # writes the forward call ONCE; afterwards it is only read
  if (file.exists(file)) return(readRDS(file))
  o <- tail(L$oni, 1); en <- t[t$en, ]; st <- t[t$strong, ]
  cl <- list(made = when, yr = yr, oni = o$ANOM, oni_seas = paste(o$SEAS, o$YR), n_en = nrow(en), below_en = sum(en$pct < 100), n_st = nrow(st), below_st = sum(st$pct < 100),
             n_ot = sum(!t$en), below_ot = sum(t$pct[!t$en] < 100), median_mm = median(t$mm), ref = range(t$wy),
             call = "below the median: a dry wet season is favored, about 3 chances in 4")
  saveRDS(cl, file); cl }
stand <- function(dep) if (abs(dep) < 5) "right at the typical year" else if (dep < 0) sprintf("%.0f mm behind the typical year", -dep) else sprintf("%.0f mm ahead of the typical year", dep)
spread <- function(y, gap) { o <- order(y); z <- y[o]; for (i in seq_along(z)[-1]) z[i] <- max(z[i], z[i - 1] + gap); z <- z - (mean(z) - mean(y[o])); r <- y; r[o] <- z; r }
live_fig <- function(L, t, cl, file, yr = 2027) {
  x <- L$x; d0 <- as.Date(sprintf("%d-10-01", yr - 1)); end <- 212
  h <- x[x$wy %in% t$wy & x$wd <= end, ]; q50 <- tapply(h$cum, h$wd, median)
  h$dep <- h$cum - q50[as.character(h$wd)]; h$en <- h$wy %in% t$wy[t$en]
  bd <- do.call(rbind, lapply(split(h, list(h$en, h$wd)), function(z) data.frame(en = z$en[1], wd = z$wd[1], lo = quantile(z$dep, .25), mid = median(z$dep), hi = quantile(z$dep, .75))))
  bd$date <- d0 + bd$wd - 1; bd$grp <- ifelse(bd$en, sprintf("%d El Nino wet seasons", cl$n_en), sprintf("%d other wet seasons", cl$n_ot))
  s <- h[h$wy %in% t$wy[t$strong], ]; s$date <- d0 + s$wd - 1; s$lab <- t$lab[match(s$wy, t$wy)]
  sl <- s[s$wd == ave(s$wd, s$wy, FUN = max), ]; sl$ylab <- spread(sl$dep, 16)
  y <- x[x$wy == yr & x$wd <= end, ]; y$dep <- y$cum - q50[as.character(y$wd)]; y$date <- d0 + y$wd - 1; last <- tail(y, 1)
  done <- nrow(y) > 0 && max(y$wd) >= end - 1
  cols <- c("#d9822b", "#4a6fa5"); names(cols) <- c(sprintf("%d El Nino wet seasons", cl$n_en), sprintf("%d other wet seasons", cl$n_ot))
  th <- theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10))
  rng <- range(c(bd$lo, bd$hi, s$dep, y$dep)); jd <- d0 + end
  pA <- ggplot(bd, aes(date)) + geom_hline(yintercept = 0, color = "grey30") +
    geom_ribbon(aes(ymin = lo, ymax = hi, fill = grp), alpha = 0.22) + geom_line(aes(y = mid, color = grp), linetype = "dashed", linewidth = 0.7) +
    geom_line(data = s, aes(date, dep, group = wy), color = "#a0522d", linewidth = 0.45, alpha = 0.8) +
    geom_text(data = sl, aes(date + 3, ylab, label = lab), hjust = 0, size = 3.1, color = "#a0522d") +
    geom_vline(xintercept = jd, color = "#b2182b", linetype = "dotted") +
    annotate("text", x = jd - 2, y = rng[2], label = "judge here:\nMay 1, 2027", hjust = 1, vjust = 1, size = 3.4, color = "#b2182b", fontface = "bold") +
    annotate("text", x = d0 + 150, y = 4, label = "typical (median) rain to date", hjust = 0, vjust = 0, size = 3.2, color = "grey30") +
    scale_fill_manual(values = cols, name = NULL) + scale_color_manual(values = cols, name = NULL) +
    scale_x_date(date_breaks = "1 month", date_labels = "%b", limits = c(d0, d0 + end + 28), expand = c(0, 0)) +
    scale_y_continuous(name = "rain ahead of (+) or behind (-) the typical year (mm)") +
    labs(title = sprintf("A.  The wet season so far: Honolulu airport, %d-%02d against %d past wet seasons", yr - 1, yr %% 100, nrow(t)),
         subtitle = sprintf("Bands: middle half of El Nino and other wet seasons (%d-%d); dashed: their medians. Thin brown: the strong El Nino seasons. Black: this season, data to %s.", cl$ref[1] - 1, cl$ref[2], format(last$date, "%b %d, %Y")), x = NULL) +
    th + theme(legend.position = c(0.02, 0.04), legend.justification = c(0, 0), legend.background = element_rect(fill = "white", color = NA))
  t$lab2 <- t$lab; ew <- t$wy[t$strong & t$pct >= 100]; for (w in ew) { z <- s[s$wy == w, ]; k <- which.max(c(0, diff(z$dep))); pk <- z[k, ]; zz <- x[x$wy == w, ]; mx <- zz[which.max(zz$mm), ]
    t$lab2[t$wy == w] <- sprintf("%s: one storm,\n%s (%.0f mm)", t$lab[t$wy == w], format(mx$date, "%b %d"), mx$mm) }
  em <- bd[bd$en & bd$wd == 165, ]
  pA <- pA + annotate("label", x = em$date, y = em$mid - 14, label = "El Nino dryness arrives after New Year", hjust = 0.5, vjust = 1, size = 3.3, color = "#a0522d", fontface = "bold", fill = "white", label.size = 0)
  if (nrow(y)) pA <- pA + geom_line(data = y, aes(date, dep), color = "black", linewidth = 1.4) + geom_point(data = last, aes(date, dep), size = 2.6) +
    annotate("text", x = last$date + 4, y = last$dep, label = sprintf("%d-%02d so far: %.0f mm, %s", yr - 1, yr %% 100, last$cum, stand(last$dep)), hjust = 0, vjust = -0.6, size = 3.5, fontface = "bold")
  t$grp <- ifelse(t$en, names(cols)[1], names(cols)[2])
  pB <- ggplot(t, aes(oni, pct, color = grp)) + annotate("rect", xmin = 0.5, xmax = Inf, ymin = -Inf, ymax = Inf, fill = "#d9822b", alpha = 0.06) +
    geom_hline(yintercept = 100, color = "grey30") + geom_vline(xintercept = 0.5, color = "grey60", linetype = "dashed") + geom_point(size = 2.6) +
    geom_text(data = t[t$strong, ], aes(label = lab2, vjust = ifelse(oni == max(oni), 0.5, -0.5), hjust = ifelse(oni == max(oni), -0.2, 0.5)), lineheight = 0.9, size = 3.1, color = "#a0522d") +
    geom_vline(xintercept = cl$oni, color = "black", linewidth = 0.9) +
    annotate("label", x = cl$oni, y = max(t$pct) * 0.97, label = sprintf("%d-%02d:\nONI now %+.2f\n(%s)", yr - 1, yr %% 100, cl$oni, cl$oni_seas), size = 3.2, fontface = "bold", label.size = 0, fill = "white") +
    annotate("text", x = -1.9, y = 12, label = sprintf("other: %d of %d below median", cl$below_ot, cl$n_ot), hjust = 0, size = 3.4, color = cols[2], fontface = "bold") +
    annotate("text", x = 0.58, y = 12, label = sprintf("El Nino: %d of %d below median\n(strong, ONI 1.5 or more: %d of %d)", cl$below_en, cl$n_en, cl$below_st, cl$n_st), hjust = 0, size = 3.4, color = "#a0522d", fontface = "bold") +
    scale_color_manual(values = cols, guide = "none") + scale_x_continuous(limits = c(-2, 3.2), name = "ONI for Dec-Feb of that wet season (C)") +
    scale_y_continuous(limits = c(0, max(t$pct) * 1.05), name = "wet-season rain (% of median)") +
    labs(title = "B.  The basis for the call: El Nino and Honolulu's wet season", subtitle = sprintf("Each dot: one wet season (Oct-Apr), %d-%d. Median %.0f mm.", cl$ref[1] - 1, cl$ref[2], cl$median_mm)) + th
  bk <- if (done) { tot <- last$cum; pc <- 100 * tot / cl$median_mm; rk <- sum(t$mm < tot) + 1
      sprintf("Result: %.0f mm, %.0f%% of median (rank %d of %d, driest = 1).\nThe call was %s.", tot, pc, rk, nrow(t) + 1, ifelse(pc < 100, "RIGHT", "WRONG -- the odds were not the outcome")) } else
      sprintf("Not yet. Rerun live_update() after April 30, 2027.\nToday's standing (data to %s): %.0f mm, %s.", format(last$date, "%b %d"), last$cum, stand(last$dep))
  fw <- sprintf("Made %s. ONI %+.2f (%s): a very strong El Nino.\nHistory at HNL: %d of %d El Nino wet seasons ended below the median; %d of %d strong ones.\nThe call: %s.", format(cl$made, "%b %d, %Y"), cl$oni, cl$oni_seas, cl$below_en, cl$n_en, cl$below_st, cl$n_st, cl$call)
  pC <- ggplot() + xlim(0, 2) + ylim(0, 1) +
    annotate("rect", xmin = 0.01, xmax = 0.99, ymin = 0.3, ymax = 0.95, fill = "#fdf0e3", color = "#d9822b") + annotate("rect", xmin = 1.01, xmax = 1.99, ymin = 0.3, ymax = 0.95, fill = "#eef1f6", color = "#4a6fa5") +
    annotate("text", x = 0.04, y = 0.85, label = "FORWARD: the call (frozen)", hjust = 0, fontface = "bold", size = 4.2, color = "#a0522d") +
    annotate("text", x = 0.04, y = 0.74, label = paste(strwrap(gsub("\n", " ", fw), 46), collapse = "\n"), hjust = 0, vjust = 1, size = 3.4, lineheight = 1.1) +
    annotate("text", x = 1.04, y = 0.85, label = "BACKWARD: the judgment", hjust = 0, fontface = "bold", size = 4.2, color = "#4a6fa5") +
    annotate("text", x = 1.04, y = 0.74, label = paste(strwrap(gsub("\n", " ", bk), 46), collapse = "\n"), hjust = 0, vjust = 1, size = 3.4, lineheight = 1.1) +
    labs(title = "C.  The loop: a statement about the future, judged later by the record") + theme_void(base_size = 12) + theme(plot.title = element_text(face = "bold", size = 12))
  fig <- (pA / (pB | pC + plot_layout())) + plot_layout(heights = c(1.35, 1)) + plot_annotation(
    caption = "Data: NOAA GHCN-Daily USW00022521 (Honolulu Intl Airport), wet seasons 1974-75 to 2025-26 (after the 1974 instrument move); CPC Oceanic Nino Index (ERSST v5). El Nino wet season: Dec-Feb ONI 0.5 C or more.\nThe forward call is stored in forward_call_wy2027.rds when first made and is never recomputed. The odds favor; they do not promise. Code: hnl_live.R.",
    theme = theme(plot.caption = element_text(size = 9, color = "grey40", hjust = 0)))
  ragg::agg_png(file, width = 15, height = 11.5, units = "in", res = 110, background = "white"); print(fig); dev.off(); invisible(fig) }
live_update <- function(dir = "G:/My Drive/Projects/S3/figures/drought_live", yr = 2027) {
  L <- live_get(); t <- live_season(L); cl <- live_call(L, t, yr, file.path(dir, sprintf("forward_call_wy%d.rds", yr)))
  saveRDS(L$x, file.path(dir, "hnl_wetseason_daily.rds")); live_fig(L, t, cl, file.path(dir, sprintf("hnl_live_wy%d.png", yr)), yr); list(t = t, cl = cl) }
