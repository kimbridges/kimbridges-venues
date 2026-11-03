# ch08_fig1_unequal_categories.R -- MRC chapter 8: categories that LOOK equal but cover unequal amounts.
# (a) US Air Quality Index for PM2.5, 2024 breakpoints (EPA fact sheet, Feb 2024): the index is piecewise-linear, so equal
#     50-point bands stand for very unequal concentration ranges. Official AQI colours. Previous (pre-2024) breakpoints as ticks.
# (b) Saffir-Simpson hurricane wind scale (sustained wind, mph).
library(ggplot2); library(patchwork)
bp <- data.frame(cat = c("Good", "Moderate", "Unhealthy for\nsensitive groups", "Unhealthy", "Very unhealthy"),
                 clo = c(0, 9.0, 35.4, 55.4, 125.4), chi = c(9.0, 35.4, 55.4, 125.4, 225.4),
                 alo = c(0, 50, 100, 150, 200), ahi = c(50, 100, 150, 200, 300),
                 col = c("#00e400", "#ffff00", "#ff7e00", "#ff0000", "#8f3f97"))
bp$cat <- factor(bp$cat, levels = bp$cat)
old <- c(12.0, 35.4, 55.4, 150.4, 250.4)
ga <- ggplot(bp) +
  geom_rect(aes(xmin = clo, xmax = chi, ymin = alo, ymax = ahi, fill = cat), colour = "white", alpha = 0.9) +
  geom_segment(aes(x = clo, xend = chi, y = alo, yend = ahi), colour = "grey15", linewidth = 0.6) +
  geom_rect(aes(xmin = clo, xmax = chi, ymin = -22, ymax = -6, fill = cat), colour = "white") +
  geom_text(aes(x = (clo + chi) / 2, y = -14, label = sprintf("%.0f", chi - clo)), size = 2.8) +
  annotate("segment", x = old, xend = old, y = -38, yend = -25, colour = "grey20", linewidth = 0.6) +
  annotate("text", x = 258, y = -32, hjust = 1, size = 2.5, colour = "grey35", label = "ticks: boundaries before 2024") +
  geom_text(aes(x = ifelse(cat == "Very unhealthy", (clo + chi) / 2, chi + 2), y = (alo + ahi) / 2 + ifelse(cat == "Very unhealthy", 25, 0), label = cat), hjust = ifelse(bp$cat == "Very unhealthy", 0.5, 0), size = 2.8, lineheight = 0.9, colour = ifelse(bp$cat == "Very unhealthy", "white", "grey10")) +
  scale_fill_manual(values = setNames(bp$col, bp$cat), guide = "none") +
  scale_x_continuous(limits = c(0, 262), breaks = c(0, 50, 100, 150, 200, 250), expand = c(0, 0)) +
  scale_y_continuous(limits = c(-40, 305), breaks = seq(0, 300, 50), expand = c(0, 0)) +
  annotate("label", x = 4, y = 298, hjust = 0, vjust = 1, size = 2.8, fill = "white", label.r = unit(0, "pt"), lineheight = 1.05,
           label = "How to read: the AQI on your phone moves in equal\n50-point steps (left axis), but each step stands for a\ndifferent amount of fine particles (bottom). The\nnumbers in the strip are the widths: 'Good' covers\n9 micrograms per cubic metre; 'Unhealthy' covers 70.\nEqual-looking bars over unequal amounts -- like a\nfuel gauge.") +
  labs(x = "fine particles, PM2.5 (\u00B5g/m\u00B3)", y = "Air Quality Index", tag = "a") +
  theme_minimal(base_size = 10.5) + theme(panel.grid.minor = element_blank())
ss <- data.frame(cat = factor(paste("Category", 1:5), levels = paste("Category", 1:5)), lo = c(74, 96, 111, 130, 157), hi = c(95, 110, 129, 156, 185))
ss$w <- c(ss$hi[1:4] - ss$lo[1:4] + 1, NA)
gb <- ggplot(ss) +
  geom_rect(aes(xmin = lo, xmax = hi + 1, ymin = 0, ymax = 1, fill = cat), colour = "white") +
  geom_text(aes(x = (lo + pmin(hi, 175) + 1) / 2, y = 0.5, label = ifelse(is.na(w), "Cat 5\n157 and up", sprintf("Cat %d\n%d mph wide", 1:5, w))), size = 2.8, colour = c("grey10", "grey10", "white", "white", "white"), lineheight = 0.95) +
  scale_fill_manual(values = c("#fdd49e", "#fdbb84", "#ef6548", "#d7301f", "#7f0000"), guide = "none") +
  scale_x_continuous(limits = c(70, 186), breaks = c(74, 96, 111, 130, 157), expand = c(0, 0)) +
  scale_y_continuous(breaks = NULL) +
  labs(x = "sustained wind (mph)", y = NULL, tag = "b", subtitle = "Saffir-Simpson hurricane categories: unequal, and not even in order -- Category 2 is the narrowest.") +
  theme_minimal(base_size = 10.5) + theme(panel.grid = element_blank(), plot.subtitle = element_text(size = 8.5, colour = "grey25"))
g <- ga / gb + plot_layout(heights = c(4, 1))
out <- "G:/My Drive/Projects/MRC/figures"
ggsave(file.path(out, "ch08_fig1_unequal_categories.png"), g, width = 7.5, height = 7.2, dpi = 300, bg = "white")
ggsave(file.path(out, "ch08_fig1_unequal_categories.pdf"), g, width = 7.5, height = 7.2, device = cairo_pdf)
g
