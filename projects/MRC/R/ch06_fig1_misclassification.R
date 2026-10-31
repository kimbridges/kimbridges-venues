# ch06_fig1_misclassification.R -- MRC chapter 6, figure 1
# The misclassification curve: probability that ONE reading lands in a different
# category from the true value, as a function of the true value.
# Boundaries and error SDs are ILLUSTRATIVE (verify list: 38.0 C fever; high-fever line).
library(ggplot2)

boundaries <- c(38.0, 39.5)                 # deg C: normal | fever | high fever
cats       <- c("normal", "fever", "high fever")
sigmas     <- c(0.1, 0.2, 0.3)              # SD of a single reading, deg C
truth      <- seq(36.5, 41.0, by = 0.005)

# P(reading falls outside the true value's category). Intervals are left-closed:
# a reading of exactly 38.0 counts as fever (argument step 2: the on-the-line rule).
p_wrong <- function(t, b, s) {
  edges <- c(-Inf, b, Inf)
  k  <- findInterval(t, b)
  lo <- edges[k + 1]; hi <- edges[k + 2]
  1 - (pnorm((hi - t) / s) - pnorm((lo - t) / s))
}

d <- expand.grid(truth = truth, sigma = sigmas)
d$p <- mapply(p_wrong, d$truth, MoreArgs = list(b = boundaries), s = d$sigma)
d$sigma_lab <- factor(sprintf("\u00B1%.1f \u00B0C", d$sigma), levels = sprintf("\u00B1%.1f \u00B0C", sigmas))

# Width of the zone where a single reading is wrong more than 5% of the time
z5   <- qnorm(0.95)         # one-sided: P(wrong side) > 5% when |t - b| < 1.645 sigma
band <- data.frame(b = boundaries, half = z5 * 0.2)

bands <- data.frame(xmin = c(min(truth), boundaries), xmax = c(boundaries, max(truth)), cat = cats)
bands$mid <- (bands$xmin + bands$xmax) / 2

pal <- c("#1b6ca8", "#d1495b", "#3a3a3a")

g <- ggplot() +
  geom_rect(data = bands, aes(xmin = xmin, xmax = xmax, ymin = -Inf, ymax = Inf),
            fill = c("#f4f7fa", "#fbf3ee", "#f8ecec"), colour = NA) +
  geom_rect(data = band, aes(xmin = b - half, xmax = b + half, ymin = -Inf, ymax = Inf),
            fill = "grey60", alpha = 0.18, colour = NA) +
  geom_vline(xintercept = boundaries, linetype = "22", colour = "grey35", linewidth = 0.4) +
  geom_hline(yintercept = 0.05, linetype = "13", colour = "grey45", linewidth = 0.35) +
  geom_line(data = d, aes(truth, p, colour = sigma_lab), linewidth = 0.8) +
  geom_text(data = bands, aes(x = mid, y = 0.56, label = cat), colour = "grey25", size = 3.6, fontface = "italic") +
  annotate("text", x = 36.55, y = 0.058, label = "5%", hjust = 0, size = 3, colour = "grey40") +
  annotate("point", x = 37.8, y = 1 - pnorm(1), size = 2.2, colour = pal[2]) +
  annotate("segment", x = 37.0, xend = 37.77, y = 0.30, yend = 1 - pnorm(1) + 0.01, colour = "grey45", linewidth = 0.3) +
  annotate("text", x = 36.6, y = 0.335, hjust = 0, size = 3, colour = "grey20",
           label = sprintf("How to read: true temperature 37.8 \u00B0C, a \u00B10.2 \u00B0C thermometer --\n%.0f%% of single readings will say 'fever'.", 100 * (1 - pnorm(1)))) +
  scale_colour_manual(values = pal, name = "reading error (1 SD)") +
  scale_y_continuous(labels = function(x) paste0(round(100 * x), "%"), limits = c(0, 0.6),
                     breaks = seq(0, 0.5, 0.1), expand = c(0, 0)) +
  scale_x_continuous(breaks = seq(36.5, 41, 0.5), expand = c(0, 0)) +
  labs(x = "true body temperature (\u00B0C)",
       y = "chance a single reading lands in the wrong category") +
  theme_minimal(base_size = 11) +
  theme(panel.grid.minor = element_blank(), panel.grid.major.x = element_blank(),
        legend.position = "top", legend.justification = "left",
        plot.margin = margin(8, 14, 8, 8))

out <- "G:/My Drive/Projects/MRC/figures"
ggsave(file.path(out, "ch06_fig1_misclassification.png"), g, width = 7.5, height = 4.6, dpi = 300, bg = "white")
ggsave(file.path(out, "ch06_fig1_misclassification.pdf"), g, width = 7.5, height = 4.6, device = cairo_pdf)
g
