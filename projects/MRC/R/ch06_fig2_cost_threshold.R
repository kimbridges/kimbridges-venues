# ch06_fig2_cost_threshold.R -- MRC chapter 6, figure 2
# Cost moves the boundary. A single reading x (error SD sigma) must be called
# 'fever' or 'normal'. Calling fever costs C_f if wrong; calling normal costs C_m if wrong.
# Best rule: call fever when P(true >= 38 | x) > C_f / (C_f + C_m).
# With a flat prior, P(true >= 38 | x) = pnorm((x - 38) / sigma), so the best threshold is
#   x* = 38 + sigma * qnorm(C_f / (C_f + C_m))
# Key point: with sigma = 0 cost changes nothing -- cost moves the line only BECAUSE of error.
# Values ILLUSTRATIVE; flat prior is a simplification.
library(ggplot2)

b      <- 38.0
sigmas <- c(0.1, 0.2, 0.3)
ratio  <- exp(seq(log(1/20), log(20), length.out = 400))   # how many times worse a MISS is than a false alarm

d <- expand.grid(ratio = ratio, sigma = sigmas)
d$thr <- b + d$sigma * qnorm(1 / (1 + d$ratio))            # C_f/(C_f+C_m) with C_f = 1, C_m = ratio
d$sigma_lab <- factor(sprintf("\u00B1%.1f \u00B0C", d$sigma), levels = sprintf("\u00B1%.1f \u00B0C", sigmas))

ex <- data.frame(ratio = 5, thr = b + 0.2 * qnorm(1/6))
pal <- c("#1b6ca8", "#d1495b", "#3a3a3a")

g <- ggplot() +
  annotate("rect", xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = b, fill = "#f4f7fa") +
  annotate("rect", xmin = -Inf, xmax = Inf, ymin = b, ymax = Inf, fill = "#fbf3ee") +
  geom_hline(yintercept = b, linetype = "22", colour = "grey35", linewidth = 0.4) +
  geom_vline(xintercept = 1, linetype = "13", colour = "grey55", linewidth = 0.35) +
  geom_line(data = d, aes(ratio, thr, colour = sigma_lab), linewidth = 0.8) +
  geom_point(data = ex, aes(ratio, thr), size = 2.2, colour = pal[2]) +
  annotate("segment", x = 5, xend = 5, y = 38.27, yend = ex$thr + 0.025, colour = "grey45", linewidth = 0.3) +
  annotate("text", x = 5, y = 38.31, hjust = 0.5, size = 3, colour = "grey25",
           label = sprintf("miss 5\u00D7 worse: call fever at %.2f \u00B0C", ex$thr)) +
  annotate("text", x = 1/19, y = b + 0.015, hjust = 0, vjust = 0, size = 3, colour = "grey30",
           label = "nominal boundary 38.0 \u00B0C") +
  annotate("text", x = 1/19, y = 37.47, hjust = 0, size = 3.2, colour = "grey30", fontface = "italic",
           label = "\u2190 a false alarm is worse") +
  annotate("text", x = 19, y = 37.47, hjust = 1, size = 3.2, colour = "grey30", fontface = "italic",
           label = "a miss is worse \u2192") +
  annotate("text", x = 1.08, y = 38.52, hjust = 0, size = 3, colour = "grey40", label = "equal costs") +
  scale_x_log10(breaks = c(1/20, 1/10, 1/5, 1/2, 1, 2, 5, 10, 20),
                labels = c("1/20", "1/10", "1/5", "1/2", "1", "2", "5", "10", "20"), expand = c(0, 0)) +
  scale_y_continuous(limits = c(37.4, 38.6), breaks = seq(37.4, 38.6, 0.2), expand = c(0, 0)) +
  scale_colour_manual(values = pal, name = "reading error (1 SD)") +
  labs(x = "cost of a missed fever \u00F7 cost of a false alarm (log scale)",
       y = "best reading at which to call 'fever' (\u00B0C)") +
  theme_minimal(base_size = 11) +
  theme(panel.grid.minor = element_blank(), legend.position = "top", legend.justification = "left",
        plot.margin = margin(8, 14, 8, 8))

out <- "G:/My Drive/Projects/MRC/figures"
ggsave(file.path(out, "ch06_fig2_cost_threshold.png"), g, width = 7.5, height = 4.6, dpi = 300, bg = "white")
ggsave(file.path(out, "ch06_fig2_cost_threshold.pdf"), g, width = 7.5, height = 4.6, device = cairo_pdf)
g
