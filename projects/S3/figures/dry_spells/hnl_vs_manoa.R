# hnl_vs_manoa.R -- the same five dry-spell operations at two gauges 13 km apart (S3, ch.2: does the vocabulary travel?). Kim + Claude, 2026-11-27.
# Needs dry_spells.R and dry_spells_figures.R. R = list(X = list(A = df, B = df), SP = list(A = spells, B = spells), summ = per-method summary).
library(ggplot2); library(patchwork)
ds_fig_two <- function(R, nmz, w0, w1, file, totals_note, src) {
  X <- R$X; SP <- R$SP; summ <- R$summ
  rain <- do.call(rbind, lapply(names(X), function(k) { z <- X[[k]][X[[k]]$date >= w0 & X[[k]]$date <= w1, ]; z$stn <- nmz[k]; z })); rain$stn <- factor(rain$stn, levels = nmz)
  seg <- do.call(rbind, lapply(names(X), function(k) { M <- ds_daymask(X[[k]], SP[[k]])[, ds_lv]; z <- X[[k]]; kk <- z$date >= w0 & z$date <= w1
    do.call(rbind, lapply(seq_along(ds_lv), function(j) { r <- ds_runs(M[kk, j]); if (!nrow(r)) return(NULL); data.frame(stn = nmz[k], m = ds_short[j], s = z$date[kk][r$s], e = z$date[kk][r$e] + 1) })) }))
  rows <- data.frame(m = rep(ds_short, 2), stn = rep(nmz, each = 5), y = c(12:8, 5:1)); seg <- merge(seg, rows); seg$m <- factor(seg$m, levels = ds_short)
  xs <- scale_x_date(limits = c(w0, w1 + 1), date_breaks = "1 month", date_labels = "%b\n%Y", expand = c(0, 0)); th <- ds_th + theme(axis.title.x = element_blank())
  pR <- ggplot(rain, aes(date, mm)) + geom_col(fill = "#2c5c8f", width = 1) + facet_wrap(~stn, ncol = 1) + geom_hline(yintercept = 1, linetype = "dashed", color = "grey40", linewidth = 0.3) +
    scale_y_sqrt(breaks = c(1, 10, 50, 100), name = "mm (sqrt)") + xs + labs(title = "A.  Same twelve months, two rain gauges 13 km apart", subtitle = sprintf("Daily rain, %s to %s", format(w0, "%B %Y"), format(w1, "%B %Y"))) + th +
    theme(axis.text.x = element_blank(), strip.text = element_text(face = "bold", hjust = 0))
  pS <- ggplot(seg) + geom_rect(aes(xmin = s, xmax = e, ymin = y - 0.38, ymax = y + 0.38, fill = m)) +
    scale_y_continuous(breaks = rows$y, labels = rows$m, name = NULL, limits = c(0.5, 13.4)) + scale_fill_manual(values = ds_cols, guide = "none") + xs +
    annotate("text", x = w0 + 2, y = c(12.85, 5.85), label = nmz, hjust = 0, size = 3.6, fontface = "bold") + annotate("segment", x = w0, xend = w1, y = 6.6, yend = 6.6, color = "grey75") +
    labs(title = "B.  Where each of the five operations finds a dry spell (at least 15 days)") + th + theme(panel.grid.major.y = element_blank(), axis.text.y = element_text(size = 9.5, hjust = 0))
  s2 <- summ; s2$stn <- factor(nmz[s2$stn], levels = rev(nmz)); s2$m <- factor(s2$m, levels = rev(ds_short))
  pB <- ggplot(s2, aes(days, m, fill = stn)) + geom_col(position = position_dodge(width = 0.75), width = 0.7) +
    geom_text(aes(label = round(days)), position = position_dodge(width = 0.75), hjust = -0.2, size = 3.3) +
    scale_fill_manual(values = setNames(c("#c7a252", "#35978f"), nmz), breaks = unname(nmz), name = NULL) + scale_x_continuous(limits = c(0, 400), breaks = seq(0, 360, 60), name = "days per year inside a dry spell") + labs(y = NULL,
    title = "C.  Cross the valley and the 'dry spell' nearly vanishes", subtitle = totals_note) + ds_th + theme(legend.position = "bottom")
  fig <- ((pR / pS) + plot_layout(heights = c(1, 1.6)) | pB) + plot_layout(widths = c(1.7, 1)) + plot_annotation(caption = src, theme = theme(plot.caption = element_text(size = 9, color = "grey40")))
  ragg::agg_png(file, width = 16, height = 8.8, units = "in", res = 110, background = "white"); print(fig); dev.off() }
# Run 2026-11-27: HNL (USW00022521, 2 m) vs Manoa (USC00516122, 73 m), 1983-2022, window Nov 2021-Oct 2022.
# Results: 422 vs 1,602 mm/yr; 46 vs 189 wet days/yr; strict-run spell days 196 vs 9 per year; window 127 vs 1; P(Manoa wet | airport dry) = 0.49;
# when the airport is in a strict-run spell, Manoa is too on 4% of those days; all five agree on 30% of airport days, 0% of Manoa days.
