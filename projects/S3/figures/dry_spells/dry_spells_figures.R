# dry_spells_figures.R -- figures for S3 ch.2 from dry_spells.R output. Kim + Claude, 2026-11-27.
# ds_fig_strip(x, sp, from, to, file): daily rain, five operations, agreement band.
# ds_fig_operations(x, sp, file): days per year in a spell by operation; year-by-year series.
library(ggplot2); library(patchwork)
ds_lv <- c("strict run", "gap tolerance (2 d)", "hysteresis (exit 5 mm)", "window (31-d total < 10 mm)", "state model (HMM)")
ds_short <- c("Strict run", "Gap tolerance", "Hysteresis", "Window", "State model")
ds_cols <- setNames(c("#8c510a", "#bf812d", "#c7a252", "#35978f", "#01665e"), ds_short)
ds_th <- theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10))
ds_fig_strip <- function(x, sp, from, to, file, station = "Honolulu airport", src = "NOAA GHCN-Daily, Honolulu Intl Airport (USW00022521)") {
  lab <- c("Strict run\nany wet day ends it", "Gap tolerance\nforgives 2 wet days", "Hysteresis\nonly 5 mm ends it", "Window\n31-day total < 10 mm", "State model\nhidden dry regime")
  M <- ds_daymask(x, sp)[, ds_lv]; x$agree <- rowSums(M); k <- x$date >= from & x$date <= to; xw <- x[k, ]; Mw <- M[k, ]
  seg <- do.call(rbind, lapply(seq_along(ds_lv), function(j) { r <- ds_runs(Mw[, j]); if (!nrow(r)) return(NULL); data.frame(m = ds_short[j], lab = lab[j], s = xw$date[r$s], e = xw$date[r$e] + 1) }))
  seg$lab <- factor(seg$lab, levels = rev(lab)); seg$m <- factor(seg$m, levels = ds_short)
  xs <- scale_x_date(limits = c(from, to + 1), date_breaks = "1 month", date_labels = "%b\n%Y", expand = c(0, 0)); th <- ds_th + theme(axis.title.x = element_blank())
  pR <- ggplot(xw, aes(date, mm)) + geom_col(fill = "#2c5c8f", width = 1) + geom_hline(yintercept = 1, color = "grey40", linetype = "dashed", linewidth = 0.3) +
    scale_y_sqrt(breaks = c(1, 5, 25, 50, 100), name = "mm (sqrt scale)") + xs + labs(title = paste0("A.  Daily rain at ", station), subtitle = "Dashed line: 1 mm, the dry-day threshold") + th + theme(axis.text.x = element_blank())
  pS <- ggplot(seg) + geom_rect(aes(xmin = s, xmax = e, ymin = as.numeric(lab) - 0.38, ymax = as.numeric(lab) + 0.38, fill = m)) +
    scale_y_continuous(breaks = seq_along(lab), labels = rev(lab), expand = c(0.02, 0.02), name = NULL) + scale_fill_manual(values = ds_cols, guide = "none") + xs +
    labs(title = "B.  Five operations, one word: where each finds a 'dry spell' (at least 15 days)") + th + theme(axis.text.x = element_blank(), panel.grid.major.y = element_blank(), axis.text.y = element_text(size = 9.5, hjust = 0))
  pA <- ggplot(xw, aes(date, 1, fill = factor(agree, levels = 0:5))) + geom_tile(width = 1, height = 1) +
    scale_fill_manual(values = c("#ffffff", "#f0e6d2", "#dcc59a", "#c09a5b", "#93632b", "#543005"), name = "operations\nthat agree", drop = FALSE) + xs + scale_y_continuous(breaks = NULL, name = NULL) +
    labs(title = "C.  Agreement: how many of the five call each day part of a dry spell", subtitle = "Dark: all five agree, the word is safe. Pale: they split, and one word covers several concepts.") + th +
    theme(legend.position = "bottom", legend.key.width = unit(1, "cm")) + guides(fill = guide_legend(nrow = 1, label.position = "bottom"))
  fig <- pR / pS / pA + plot_layout(heights = c(1.1, 1.6, 0.45)) + plot_annotation(caption = paste0("Data: ", src, ", through ", format(max(x$date)), ". Dry day: under 1 mm. Code: dry_spells.R."), theme = theme(plot.caption = element_text(size = 9, color = "grey40")))
  ragg::agg_png(file, width = 13, height = 9, units = "in", res = 110, background = "white"); print(fig); dev.off(); invisible(table(factor(xw$agree, 0:5))) }
ds_fig_operations <- function(x, sp, file, src = "NOAA GHCN-Daily, Honolulu Intl Airport (USW00022521), 1974-01-10 (move to the Observatory Annex) to 2026-11-22") {
  M <- ds_daymask(x, sp)[, ds_lv]; colnames(M) <- ds_short; x$yr <- as.integer(format(x$date, "%Y"))
  y0 <- min(x$yr) + 1; y1 <- max(x$yr) - 1; ay <- aggregate(M, list(yr = x$yr), sum); ay <- ay[ay$yr >= y0 & ay$yr <= y1, ]
  long <- do.call(rbind, lapply(ds_short, function(s) data.frame(yr = ay$yr, m = s, d = ay[[s]]))); long$m <- factor(long$m, levels = ds_short)
  cm <- cor(ay[, ds_short]); yrs <- as.numeric(diff(range(x$date))) / 365.25
  sm <- do.call(rbind, lapply(seq_along(ds_lv), function(j) { z <- sp[sp$method == ds_lv[j], ]; data.frame(m = ds_short[j], days = sum(z$days) / yrs, n = nrow(z) / yrs, len = mean(z$days)) })); sm$m <- factor(sm$m, levels = ds_short)
  pB <- ggplot(sm, aes(days, reorder(m, days), fill = m)) + geom_col(width = 0.7) + geom_text(aes(label = sprintf("%.0f days  (%.1f spells, mean %.0f d)", days, n, len)), hjust = -0.05, size = 3.5) +
    scale_fill_manual(values = ds_cols) + scale_x_continuous(limits = c(0, 640), breaks = seq(0, 365, 60), name = "days per year inside a dry spell") + labs(y = NULL,
    title = "A.  How dry is Honolulu? It depends on the operation", subtitle = sprintf("Same record (%d-%d), same 1 mm dry day, same 15-day minimum", min(x$yr), max(x$yr))) + ds_th + theme(legend.position = "none")
  pT <- ggplot(long, aes(yr, d, color = m)) + geom_line(linewidth = 0.7) + facet_wrap(~m, ncol = 1, strip.position = "left") + scale_color_manual(values = ds_cols) +
    scale_y_continuous(breaks = c(0, 180, 365), limits = c(0, 366), name = NULL) + scale_x_continuous(breaks = seq(1975, 2025, 10), name = NULL) +
    labs(title = "B.  Days in a dry spell, year by year", subtitle = sprintf("The operations agree on which years are dry (median correlation r = %.2f) but not on how dry", median(cm[upper.tri(cm)]))) + ds_th +
    theme(legend.position = "none", strip.text.y.left = element_text(angle = 0, hjust = 1, size = 10), strip.placement = "outside", panel.spacing = unit(0.3, "lines"))
  fig <- (pB | pT) + plot_layout(widths = c(1, 1.1)) + plot_annotation(caption = paste0("Data: ", src, ". Code: dry_spells.R."), theme = theme(plot.caption = element_text(size = 9, color = "grey40")))
  ragg::agg_png(file, width = 14, height = 6.8, units = "in", res = 110, background = "white"); print(fig); dev.off(); invisible(list(summary = sm, cor = cm)) }
# Example: source("dry_spells.R"); source("dry_spells_figures.R"); sp <- ds_all(x)
# ds_fig_strip(x, sp, as.Date("2025-11-23"), as.Date("2026-11-22"), "hnl_dry_spell_disagreement.png"); ds_fig_operations(x, sp, "hnl_dry_spell_operations.png")
