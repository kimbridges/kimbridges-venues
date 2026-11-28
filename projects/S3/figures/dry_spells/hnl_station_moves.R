# hnl_station_moves.R -- does a station move show in the rain record? (S3, ch.2 and ch.9). Kim + Claude, 2026-11-27.
# Ratio of the target's yearly wet-day count (>= 1 mm) to each neighbor's, scaled to 1 in a common period, with site periods marked.
# Inputs: A = named list of annual tables (yr, tot, wet) from GHCN-D (years with >= 330 days); first element the target.
library(ggplot2)
sm_ratio <- function(A, target = "HNL", nb = c(EWA = "Ewa Plantation", MAN = "Manoa", KAL = "Kalihi", PAL = "Palolo"), scale_years = 1963:1973)
  do.call(rbind, lapply(names(nb), function(k) { m <- merge(A[[target]], A[[k]], by = "yr"); m <- m[m$wet.y > 0, ]
    z <- data.frame(yr = m$yr, ref = nb[k], r = m$wet.x / m$wet.y); z$rel <- z$r / median(z$r[z$yr %in% scale_years]); z }))
sm_fig <- function(rr, per, file, title = "The station moved, and the record noticed") {
  per$med <- sapply(seq_len(nrow(per)), function(i) median(rr$rel[rr$yr >= per$a[i] & rr$yr <= per$b[i]])); pmed <- aggregate(rel ~ yr, rr, median)
  p <- ggplot() + geom_rect(data = per, aes(xmin = a - 0.5, xmax = b + 0.5, ymin = -Inf, ymax = Inf, fill = lab), alpha = 0.35) +
    geom_point(data = rr, aes(yr, rel, shape = ref), color = "grey50", size = 1.5) + geom_line(data = pmed, aes(yr, rel), color = "grey20", linewidth = 0.5) +
    geom_segment(data = per, aes(x = a - 0.5, xend = b + 0.5, y = med, yend = med), color = "#b23a1e", linewidth = 1.4) +
    geom_text(data = per, aes(x = (a + b) / 2, y = 1.62, label = lab), size = 3.4, lineheight = 0.9) +
    geom_text(data = per, aes(x = (a + b) / 2, y = med - 0.06, label = sprintf("median %.2f", med)), size = 3.3, color = "#b23a1e") +
    scale_fill_manual(values = c("#ece4d4", "#f6efe2", "#e3e8ee"), guide = "none") + scale_shape_manual(values = c(16, 17, 15, 3), name = "neighbor") +
    scale_y_continuous(limits = c(0.35, 1.7), breaks = seq(0.4, 1.6, 0.2), name = "target wet days / neighbor's\n(1 = the scaling period)") + scale_x_continuous(breaks = seq(1940, 2020, 10), name = NULL) +
    labs(title = title, subtitle = "Yearly count of wet days (>= 1 mm) relative to neighbors; red: median for each observing site") + theme_minimal(base_size = 12) +
    theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10), legend.position = "bottom")
  ragg::agg_png(file, width = 11, height = 5.6, units = "in", res = 110, background = "white"); print(p); dev.off(); invisible(per) }
# HNL site periods (NWS Honolulu history): first site 1940-08-14; Administration Building 1962-10-11; Observatory Annex 1974-01-10.
# per <- data.frame(a = c(1941, 1963, 1974), b = c(1962, 1973, 2025), lab = c("First site\n1940-62", "Administration Building\n1962-74", "Observatory Annex\n1974-"))
# Result 2026-11-27: medians 0.89 (first site), 1.00 (Admin Bldg), 0.77 (Annex).
