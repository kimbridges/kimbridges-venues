# ch07_fig1_whittaker_years.R -- MRC chapter 7: two measurements, one category, read year by year.
# Each year's mean temperature and total precipitation placed on the Whittaker biome diagram (whittakerr 0.2.0),
# against the long-term mean. Data: GHCN-Daily (NCEI) -- Denver Central Park USW00023062 (1948-2025),
# Corvallis State University USC00351862 (1896-2024; replaced Eugene 2026-11-03 -- Eugene's gauge record has an instrument shift). Years with >= 330 days of both TMAX/TMIN and PRCP; precip scaled to 365 days.
library(ggplot2); library(patchwork); library(whittakerr)
rd <- function(id) { x <- read.csv(file.path("G:/My Drive/Projects/MRC/data", paste0("GHCND_", id, ".csv")), stringsAsFactors = FALSE)
  x$yr <- as.integer(substr(x$DATE, 1, 4)); tm <- (x$TMAX + x$TMIN) / 20
  a <- do.call(rbind, lapply(split(seq_len(nrow(x)), x$yr), function(i) data.frame(yr = x$yr[i[1]],
       nT = sum(!is.na(tm[i])), nP = sum(!is.na(x$PRCP[i])), T = mean(tm[i], na.rm = TRUE), P = sum(x$PRCP[i], na.rm = TRUE) / 100)))
  a <- a[a$nT >= 330 & a$nP >= 330, ]; a$P <- a$P * 365 / a$nP; a$biome <- mapply(name_biome, a$T, a$P); a }
den <- rd("USW00023062_Denver"); den$site <- "Denver"
eug <- rd("USC00351862_Corvallis"); eug$site <- "Corvallis"
yy <- rbind(den, eug)
mn <- aggregate(cbind(T, P) ~ site, yy, mean)
nd <- c(Denver = sum(den$biome != name_biome(mean(den$T), mean(den$P))), Corvallis = sum(eug$biome != name_biome(mean(eug$T), mean(eug$P))))
wb <- Whittaker_biomes
cols <- Ricklefs_colors
ga <- ggplot() +
  geom_polygon(data = wb, aes(temp_c, precp_cm, group = biome_id, fill = biome), colour = "white", linewidth = 0.3) +
  scale_fill_manual(values = cols, name = NULL, breaks = c("Temperate rain forest", "Temperate seasonal forest", "Woodland/shrubland", "Temperate grassland/desert", "Subtropical desert", "Tropical seasonal forest/savanna", "Boreal forest")) +
  geom_label(data = data.frame(x = c(5.6, 5.6, 17.3, 17.6), y = c(192, 132, 85, 10),
             l = c('Temperate rain forest', 'Temperate seasonal forest', 'Woodland/shrubland', 'Subtropical desert')),
             aes(x, y, label = l), hjust = c(0, 0, 1, 1), size = 2.7, label.size = 0, fill = alpha('white', 0.7), colour = 'grey10', label.padding = unit(0.12, 'lines')) +
  geom_label(aes(x = 5.6, y = 10, label = 'Temperate grassland/desert'), hjust = 0, size = 2.7, label.size = 0, fill = alpha('white', 0.7), colour = 'grey10', label.padding = unit(0.12, 'lines')) +
  geom_point(data = yy, aes(T, P, shape = site), size = 1.5, colour = "grey10", fill = "white", stroke = 0.4) +
  geom_point(data = mn, aes(T, P), shape = 21, size = 4.2, stroke = 1.3, colour = "white", fill = "#b0172a") +
  annotate("segment", x = mn$T, xend = c(14.6, 14.6), y = mn$P, yend = ifelse(mn$site == "Denver", 30, 165), colour = "#b0172a", linewidth = 0.4) +
  annotate("text", x = 14.75, y = ifelse(mn$site == "Denver", 30, 165), hjust = 0, size = 3.2, colour = "#b0172a", fontface = "bold", label = paste0(mn$site, " mean")) +
  scale_shape_manual(values = c(Denver = 16, Corvallis = 24), name = "one year") +
  coord_cartesian(xlim = c(4, 19), ylim = c(0, 200), expand = FALSE) +
  labs(x = "mean annual temperature (\u00B0C)", y = "annual precipitation (cm)", tag = "a",
       caption = sprintf("How to read: each symbol is one year, placed by that year's mean temperature and total rainfall; the red dot is the long-term mean.\nDenver's mean sits in temperate grassland/desert, but %d of its %d years fall in woodland/shrubland. Corvallis's mean is temperate\nseasonal forest, but %d of its %d years are not.", nd[["Denver"]], nrow(den), nd[["Corvallis"]], nrow(eug))) +
  theme_minimal(base_size = 10.5) + theme(legend.position = "right", legend.text = element_text(size = 8), panel.grid.minor = element_blank(), plot.caption = element_text(hjust = 0, size = 8, colour = "grey20"))
yy$site <- factor(yy$site, levels = c("Corvallis", "Denver"))
gb <- ggplot(yy, aes(yr, site, fill = biome)) + geom_tile(height = 0.8, colour = "white", linewidth = 0.2) +
  scale_fill_manual(values = cols, guide = "none") +
  scale_x_continuous(breaks = seq(1900, 2020, 20), expand = c(0.005, 0)) +
  labs(x = NULL, y = NULL, tag = "b", subtitle = "The same years in order: each stripe is one year, colored by its biome. Gaps are incomplete years.") +
  theme_minimal(base_size = 10.5) + theme(panel.grid = element_blank(), plot.subtitle = element_text(size = 8.5, colour = "grey25"))
g <- ga / gb + plot_layout(heights = c(4, 1))
out <- "G:/My Drive/Projects/MRC/figures"
ggsave(file.path(out, "ch07_fig1_whittaker_years.png"), g, width = 8, height = 7.2, dpi = 300, bg = "white")
ggsave(file.path(out, "ch07_fig1_whittaker_years.pdf"), g, width = 8, height = 7.2, device = cairo_pdf)
attr(g, "stats") <- list(nd = nd, n = c(nrow(den), nrow(eug)), mn = mn)
g
