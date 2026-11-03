# ch08_fig2_martini_glass.R -- MRC chapter 8: we read the LEVEL, the quantity is the VOLUME.
# A V-shaped (conical) glass holds volume in proportion to height cubed; a straight-sided glass in proportion to height.
library(ggplot2); library(patchwork)
h <- seq(0, 1, 0.005)
d <- rbind(data.frame(h = h, v = h^3, glass = "martini glass (cone)"), data.frame(h = h, v = h, glass = "straight-sided glass"))
pal <- c(`martini glass (cone)` = "#b0172a", `straight-sided glass` = "grey45")
ga <- ggplot(d, aes(h, v, colour = glass)) +
  annotate("segment", x = 0.5, xend = 0.5, y = 0, yend = 0.5, linetype = "22", colour = "grey55", linewidth = 0.35) +
  annotate("segment", x = 1, xend = 0.5, y = 0.125, yend = 0.125, linetype = "22", colour = "#b0172a", linewidth = 0.35) +
  annotate("segment", x = 0.794, xend = 0.794, y = 0, yend = 0.5, linetype = "22", colour = "#b0172a", linewidth = 0.35) +
  annotate("segment", x = 1, xend = 0.5, y = 0.5, yend = 0.5, linetype = "22", colour = "grey55", linewidth = 0.35) +
  geom_line(linewidth = 1.1) +
  annotate("point", x = c(0.5, 0.794), y = c(0.125, 0.5), colour = "#b0172a", size = 2.6) +
  scale_colour_manual(values = pal, name = NULL) +
  scale_x_reverse(breaks = c(1, 0.794, 0.5, 0.25, 0), labels = c("full", "79%", "half", "25%", "empty"), expand = c(0.01, 0)) +
  scale_y_continuous(breaks = c(0, 0.125, 0.25, 0.5, 0.75, 1), labels = c("0", "1/8", "1/4", "1/2", "3/4", "all"), expand = c(0.01, 0)) +
  annotate("label", x = 0.56, y = 0.99, hjust = 0, vjust = 1, size = 2.9, fill = "white", label.r = unit(0, "pt"), lineheight = 1.05,
           label = "How to read: drinking moves you left\nto right as the level falls. In a martini\nglass (red), half the drink is gone when\nthe level has dropped only to 79% of its\nheight; at half height, only one-eighth\nis left. In a straight glass (grey), half\nheight means half the drink.") +
  labs(x = "level of the drink (share of the glass's height)", y = "drink remaining", tag = "a") +
  theme_minimal(base_size = 10.5) + theme(legend.position = "bottom", panel.grid.minor = element_blank())
# glass silhouettes at half height
cone_out <- data.frame(x = c(-1, 0, 1), y = c(2, 0, 2)); cone_in <- data.frame(x = c(-0.5, 0, 0.5), y = c(1, 0, 1))
stem <- data.frame(x = c(0, 0), y = c(0, -0.9)); foot <- data.frame(x = c(-0.55, 0.55), y = c(-0.9, -0.9))
cyl_out <- data.frame(x = c(2.2, 2.2, 3.4, 3.4), y = c(2, -0.9, -0.9, 2)); cyl_in <- data.frame(x = c(2.2, 2.2, 3.4, 3.4), y = c(0.55, -0.9, -0.9, 0.55))
gb <- ggplot() +
  geom_polygon(data = cone_in, aes(x, y), fill = "#e9c46a", alpha = 0.85) +
  geom_polygon(data = cone_out, aes(x, y), fill = NA, colour = "grey25", linewidth = 0.7) +
  geom_path(data = stem, aes(x, y), colour = "grey25", linewidth = 0.7) + geom_path(data = foot, aes(x, y), colour = "grey25", linewidth = 0.7) +
  geom_polygon(data = cyl_in, aes(x, y), fill = "#e9c46a", alpha = 0.85) +
  geom_path(data = cyl_out, aes(x, y), colour = "grey25", linewidth = 0.7) +
  annotate("text", x = 0, y = -1.25, label = "half height:\none-eighth left", size = 2.9, colour = "#b0172a", lineheight = 0.95, vjust = 1) +
  annotate("text", x = 2.8, y = -1.25, label = "half height:\nhalf left", size = 2.9, colour = "grey30", lineheight = 0.95, vjust = 1) +
  coord_equal(xlim = c(-1.3, 3.7), ylim = c(-2.1, 2.2)) + labs(tag = "b") + theme_void(base_size = 10.5)
g <- ga + gb + plot_layout(widths = c(2.2, 1))
out <- "G:/My Drive/Projects/MRC/figures"
ggsave(file.path(out, "ch08_fig2_martini_glass.png"), g, width = 8, height = 4.6, dpi = 300, bg = "white")
ggsave(file.path(out, "ch08_fig2_martini_glass.pdf"), g, width = 8, height = 4.6, device = cairo_pdf)
g
