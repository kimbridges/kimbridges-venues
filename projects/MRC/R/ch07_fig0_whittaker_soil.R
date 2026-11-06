# ch07_fig0_whittaker_soil.R -- MRC chapter 7: two partitioned measurement spaces, shown in full before they are used.
# (a) Whittaker biome diagram (whittakerr: Whittaker_biomes, Ricklefs_colors); (b) USDA soil texture triangle
# (class polygons from the USDA data set shipped with ggtern; projected here to plain x-y so ggplot2 alone draws it).
library(ggplot2); library(patchwork); library(whittakerr)
wb <- Whittaker_biomes
cen <- do.call(rbind, lapply(split(wb, wb$biome), function(d) { a <- d$temp_c; b <- d$precp_cm; a2 <- c(a[-1], a[1]); b2 <- c(b[-1], b[1])
  cr <- a * b2 - a2 * b; A <- sum(cr) / 2; data.frame(biome = d$biome[1], x = sum((a + a2) * cr) / (6 * A), y = sum((b + b2) * cr) / (6 * A)) }))
cen$lab <- c('Boreal\nforest', 'Subtropical\ndesert', 'Temperate grassland/desert', 'Temperate\nrain forest', 'Temperate\nseasonal forest',
             'Tropical\nrain forest', 'Tropical seasonal\nforest/savanna', 'Tundra', 'Woodland/shrubland')[match(cen$biome, sort(unique(wb$biome)))]
cen$y[cen$biome == 'Temperate grassland/desert'] <- 16; cen$x[cen$biome == 'Temperate grassland/desert'] <- 4
cen$y[cen$biome == 'Woodland/shrubland'] <- 58; cen$x[cen$biome == 'Woodland/shrubland'] <- 6
ga <- ggplot() +
  geom_polygon(data = wb, aes(temp_c, precp_cm, group = biome_id, fill = biome), colour = 'white', linewidth = 0.4) +
  scale_fill_manual(values = Ricklefs_colors, guide = 'none') +
  geom_text(data = cen, aes(x, y, label = lab), size = 2.8, lineheight = 0.9, colour = 'grey10') +
  annotate('point', x = 10, y = 100, shape = 21, size = 3, fill = 'black', colour = 'white', stroke = 0.8) +
  annotate('segment', x = 10, y = 100, xend = 0, yend = 330, colour = 'grey20', linewidth = 0.3) +
  annotate('text', x = -15, y = 360, hjust = 0, size = 2.7, lineheight = 0.95, colour = 'grey15',
           label = 'How to read: find a place by its mean\nannual temperature and rainfall. 10 \u00B0C\nand 100 cm: temperate seasonal forest.') +
  scale_x_continuous(breaks = seq(-15, 30, 5)) +
  coord_cartesian(xlim = c(-16, 31), ylim = c(0, 450), expand = FALSE) +
  labs(x = 'mean annual temperature (\u00B0C)', y = 'annual precipitation (cm)', tag = 'a', title = 'Biomes (Whittaker)') +
  theme_minimal(base_size = 10) + theme(panel.grid.minor = element_blank(), plot.title = element_text(size = 10.5, face = 'bold'))
## soil triangle: sand at lower left, silt at lower right, clay at the top
e <- new.env(); data('USDA', package = 'ggtern', envir = e); u <- e$USDA
tx <- function(sand, silt, clay) data.frame(x = silt + clay / 2, y = clay * sqrt(3) / 2)
u <- cbind(u, tx(u$Sand * 100, u$Silt * 100, u$Clay * 100))
uc <- aggregate(cbind(x, y) ~ Label, u, mean)
uc$lab <- sub(' ', '\n', as.character(uc$Label)); uc$lab[uc$Label == 'Sandy Clay Loam'] <- 'Sandy clay\nloam'; uc$lab[uc$Label == 'Silty Clay Loam'] <- 'Silty clay\nloam'
uc$lab <- sub('\nClay', '\nclay', sub('\nLoam', '\nloam', sub('\nSand', '\nsand', uc$lab)))
uc$y[uc$Label == 'Sand'] <- 3.2; uc$x[uc$Label == 'Sand'] <- 6.5; uc$y[uc$Label == 'Loamy Sand'] <- 9.5; uc$x[uc$Label == 'Loamy Sand'] <- 16
uc$y[uc$Label == 'Silt'] <- 4.5; uc$x[uc$Label == 'Silt'] <- 90
grid <- do.call(rbind, lapply(seq(20, 80, 20), function(v) rbind(
  data.frame(g = paste0('c', v), rbind(tx(100 - v, 0, v), tx(0, 100 - v, v))),
  data.frame(g = paste0('s', v), rbind(tx(0, v, 100 - v), tx(100 - v, v, 0))),
  data.frame(g = paste0('a', v), rbind(tx(v, 0, 100 - v), tx(v, 100 - v, 0))))))
pal12 <- c('#E8D5B5', '#D9C29A', '#CDB083', '#E6CF9E', '#F0E0B0', '#F6EBC8', '#C9A97A', '#DDC9A2', '#E3D7B8', '#C7B08F', '#D3BE9C', '#EADFC6')
ex <- tx(40, 40, 20)
gb <- ggplot() +
  geom_polygon(data = u, aes(x, y, group = Label, fill = Label), colour = 'white', linewidth = 0.6) +
  geom_line(data = grid, aes(x, y, group = g), colour = 'grey55', linewidth = 0.2, linetype = 'dotted') +
  scale_fill_manual(values = setNames(pal12, levels(u$Label)), guide = 'none') +
  geom_text(data = uc, aes(x, y, label = lab), size = 2.6, lineheight = 0.9, colour = 'grey10') +
  annotate('text', x = seq(20, 80, 20) / 2 - 3.5, y = seq(20, 80, 20) * sqrt(3) / 2, label = seq(20, 80, 20), size = 2.4, colour = 'grey40') +
  annotate('text', x = 50 + seq(20, 80, 20) / 2 + 3.5, y = (100 - seq(20, 80, 20)) * sqrt(3) / 2, label = seq(20, 80, 20), size = 2.4, colour = 'grey40') +
  annotate('text', x = 100 - seq(20, 80, 20), y = -3.5, label = seq(20, 80, 20), size = 2.4, colour = 'grey40') +
  annotate('text', x = 14, y = 50, label = 'percent clay', angle = 60, size = 3, colour = 'grey25') +
  annotate('text', x = 86, y = 50, label = 'percent silt', angle = -60, size = 3, colour = 'grey25') +
  annotate('text', x = 50, y = -9, label = 'percent sand', size = 3, colour = 'grey25') +
  annotate('point', x = ex$x, y = ex$y, shape = 21, size = 3, fill = 'black', colour = 'white', stroke = 0.8) +
  annotate('segment', x = ex$x, y = ex$y, xend = 16, yend = 78, colour = 'grey20', linewidth = 0.3) +
  annotate('text', x = -5, y = 84, hjust = 0, size = 2.7, lineheight = 0.95, colour = 'grey15',
           label = 'How to read: 40% sand,\n40% silt and 20% clay\nis a loam.') +
  coord_equal(xlim = c(-6, 106), ylim = c(-12, 92), expand = FALSE) +
  labs(tag = 'b', title = 'Soil texture classes (USDA)') + theme_void(base_size = 10) +
  theme(plot.title = element_text(size = 10.5, face = 'bold'), plot.tag = element_text(face = 'bold'))
g <- ga + gb + plot_layout(widths = c(1, 1.05))
out <- 'G:/My Drive/Projects/MRC/figures'
ggsave(file.path(out, 'ch07_fig0_whittaker_soil.png'), g, width = 9.5, height = 5, dpi = 300, bg = 'white')
ggsave(file.path(out, 'ch07_fig0_whittaker_soil.pdf'), g, width = 9.5, height = 5, device = cairo_pdf)
g
