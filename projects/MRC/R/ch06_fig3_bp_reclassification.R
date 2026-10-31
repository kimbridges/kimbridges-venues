# ch06_fig3_bp_reclassification.R -- MRC chapter 6, figure 3
# The boundary moves; the readings stand still. The SAME NHANES 2017-2018 blood-pressure
# readings classified by JNC7 (2003) and by the 2017 ACC/AHA guideline.
# Measured BP only (treatment status ignored); mean of available readings 1-3;
# adults 18+; weighted by WTMEC2YR (MEC exam weights). Thresholds verified 2026-10-30.
library(ggplot2)
dd <- "G:/My Drive/Projects/MRC/data"
bp <- haven::read_xpt(file.path(dd, "BPX_J.xpt"))
de <- haven::read_xpt(file.path(dd, "DEMO_J.xpt"))
x  <- merge(bp, de[, c("SEQN", "RIDAGEYR", "WTMEC2YR")], by = "SEQN")
x  <- x[x$RIDAGEYR >= 18, ]
sy <- as.matrix(x[, c("BPXSY1", "BPXSY2", "BPXSY3")])
di <- as.matrix(x[, c("BPXDI1", "BPXDI2", "BPXDI3")]); di[di == 0] <- NA   # 0 = not recordable
x$sbp <- rowMeans(sy, na.rm = TRUE); x$dbp <- rowMeans(di, na.rm = TRUE)
x  <- x[is.finite(x$sbp) & is.finite(x$dbp) & x$WTMEC2YR > 0, ]

jnc <- with(x, ifelse(sbp >= 160 | dbp >= 100, 4, ifelse(sbp >= 140 | dbp >= 90, 3,
            ifelse(sbp >= 120 | dbp >= 80, 2, 1))))
acc <- with(x, ifelse(sbp >= 140 | dbp >= 90, 4, ifelse(sbp >= 130 | dbp >= 80, 3,
            ifelse(sbp >= 120, 2, 1))))
lab_j <- c("normal", "prehypertension", "stage 1", "stage 2")
lab_a <- c("normal", "elevated", "stage 1", "stage 2")
w <- x$WTMEC2YR / sum(x$WTMEC2YR)
fl <- aggregate(w, by = list(from = jnc, to = acc), FUN = sum); names(fl)[3] <- "p"

# --- stacked bars + ribbons (manual alluvial) ---
xl <- 1; xr <- 2; bw <- 0.14
segL <- aggregate(p ~ from, fl, sum); segL$top <- cumsum(segL$p); segL$bot <- segL$top - segL$p
segR <- aggregate(p ~ to,   fl, sum); segR$top <- cumsum(segR$p); segR$bot <- segR$top - segR$p
fl <- fl[order(fl$from, fl$to), ]
fl$l0 <- NA; fl$r0 <- NA
for (i in unique(fl$from)) { k <- fl$from == i; fl$l0[k] <- segL$bot[segL$from == i] + c(0, head(cumsum(fl$p[k]), -1)) }
o <- order(fl$to, fl$from)
for (j in unique(fl$to)) { k <- which(fl$to == j); k <- k[order(fl$from[k])]; fl$r0[k] <- segR$bot[segR$to == j] + c(0, head(cumsum(fl$p[k]), -1)) }
sig <- function(t) (1 - cos(pi * t)) / 2
tt <- seq(0, 1, length.out = 60)
rib <- do.call(rbind, lapply(seq_len(nrow(fl)), function(i) {
  f <- fl[i, ]; xs <- (xl + bw/2) + tt * ((xr - bw/2) - (xl + bw/2))
  lo <- f$l0 + sig(tt) * (f$r0 - f$l0); hi <- lo + f$p
  data.frame(id = i, x = c(xs, rev(xs)), y = c(lo, rev(hi)), moved = f$from != f$to)
}))
fill4 <- c("#c9d6e3", "#e9d8a6", "#ee9b00", "#ae2012")
bars <- rbind(data.frame(x = xl, cat = segL$from, bot = segL$bot, top = segL$top, lab = lab_j[segL$from]),
              data.frame(x = xr, cat = segR$to,   bot = segR$bot, top = segR$top, lab = lab_a[segR$to]))
bars$pct <- sprintf("%s  %.0f%%", bars$lab, 100 * (bars$top - bars$bot))
htn_j <- sum(fl$p[fl$from >= 3]); htn_a <- sum(fl$p[fl$to >= 3])
moved_23 <- sum(fl$p[fl$from == 2 & fl$to == 3]); moved_all <- sum(fl$p[fl$from != fl$to])

g <- ggplot() +
  geom_polygon(data = rib, aes(x, y, group = id, fill = moved), colour = NA, alpha = 0.55) +
  scale_fill_manual(values = c(`FALSE` = "grey85", `TRUE` = "#ee9b00"), guide = "none") +
  geom_rect(data = bars, aes(xmin = x - bw/2, xmax = x + bw/2, ymin = bot, ymax = top),
            fill = fill4[bars$cat], colour = "white", linewidth = 0.6) +
  geom_text(data = bars[bars$x == xl, ], aes(x = x - bw/2 - 0.02, y = (bot + top)/2, label = pct), hjust = 1, size = 3.2) +
  geom_text(data = bars[bars$x == xr, ], aes(x = x + bw/2 + 0.02, y = (bot + top)/2, label = pct), hjust = 0, size = 3.2) +
  annotate("text", x = xl, y = 1.07, label = "JNC7 (2003)", fontface = "bold", size = 3.6) +
  annotate("text", x = xr, y = 1.07, label = "ACC/AHA (2017)", fontface = "bold", size = 3.6) +
  annotate("text", x = xl, y = -0.06, size = 3.1, colour = "grey25", label = sprintf("hypertension: %.0f%%", 100 * htn_j)) +
  annotate("text", x = xr, y = -0.06, size = 3.1, colour = "grey25", label = sprintf("hypertension: %.0f%%", 100 * htn_a)) +
  annotate("label", x = 1.5, y = -0.2, size = 3, hjust = 0.5, fill = "white", colour = "grey15",
           label = sprintf("How to read: each band is the same group of adults on both sides. Their readings did not change,\nso the bands run straight across -- only the names and boundaries changed. Orange bands (%.0f%% of adults)\nchanged label; the larger one (%.0f%%) was 'prehypertension' in 2003 and 'stage 1 hypertension' in 2017.", 100 * moved_all, 100 * moved_23)) +
  scale_x_continuous(limits = c(0.45, 2.55)) +
  scale_y_continuous(limits = c(-0.3, 1.12)) +
  theme_void(base_size = 11) +
  theme(plot.margin = margin(8, 8, 8, 8), plot.background = element_rect(fill = "white", colour = NA))

out <- "G:/My Drive/Projects/MRC/figures"
ggsave(file.path(out, "ch06_fig3_bp_reclassification.png"), g, width = 7.5, height = 5.8, dpi = 300, bg = "white")
ggsave(file.path(out, "ch06_fig3_bp_reclassification.pdf"), g, width = 7.5, height = 5.8, device = cairo_pdf)
attr(g, "stats") <- list(n = nrow(x), htn_j = htn_j, htn_a = htn_a, moved_23 = moved_23, moved_all = moved_all, flows = fl[, c("from","to","p")])
g
