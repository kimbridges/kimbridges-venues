# ch08_fig0_braun_blanquet.R -- MRC chapter 8: a category scale recorded INSTEAD of a measurement.
# Braun-Blanquet cover-abundance classes (standard definitions: r, +, 1 <5%, 2 5-25%, 3 25-50%, 4 50-75%, 5 75-100%).
library(ggplot2)
d <- data.frame(cls = c('1', '2', '3', '4', '5'), lo = c(0, 5, 25, 50, 75), hi = c(5, 25, 50, 75, 100))
d$mid <- (d$lo + d$hi) / 2
fills <- c('#DCEBC4', '#B5D58F', '#86B95E', '#5A9A3A', '#336F22')
g <- ggplot() +
  annotate('rect', xmin = -22, xmax = -14, ymin = 0, ymax = 1, fill = 'grey92', colour = 'white') +
  annotate('rect', xmin = -13, xmax = -5, ymin = 0, ymax = 1, fill = 'grey85', colour = 'white') +
  annotate('text', x = c(-18, -9), y = 0.5, label = c('r', '+'), size = 5, fontface = 'bold', colour = 'grey20') +
  annotate('text', x = -13.5, y = -0.32, label = 'one or a few plants:\ncounted, not measured', size = 2.8, lineheight = 0.95, colour = 'grey30') +
  geom_rect(data = d, aes(xmin = lo, xmax = hi, ymin = 0, ymax = 1, fill = cls), colour = 'white', linewidth = 0.8) +
  scale_fill_manual(values = setNames(fills, d$cls), guide = 'none') +
  geom_text(data = d, aes(x = mid, y = 0.5, label = cls), size = 5, fontface = 'bold', colour = c('grey15', 'grey15', 'white', 'white', 'white')) +
  geom_text(data = d, aes(x = mid, y = 1.18, label = paste0(lo, '-', hi, '%')), size = 3, colour = 'grey25') +
  annotate('segment', x = 0, xend = 100, y = -0.08, yend = -0.08, colour = 'grey40', linewidth = 0.3) +
  annotate('text', x = seq(0, 100, 25), y = -0.2, label = paste0(seq(0, 100, 25), '%'), size = 2.8, colour = 'grey35') +
  annotate('text', x = 50, y = -0.45, label = 'cover: share of the ground the species covers, seen from above', size = 3, colour = 'grey25') +
  scale_x_continuous(limits = c(-24, 105), expand = c(0, 0)) + scale_y_continuous(limits = c(-0.6, 1.35)) +
  labs(caption = paste0('How to read: an observer looks at each species in a plot and records one symbol, not a percentage. Classes 3, 4 and 5 each span\n',
    '25 points of cover; class 1 spans only 5; and r and + are not cover classes at all, but counts. The scale is finest at low cover,\n',
    'where most species in a plot fall, and coarsest where only a few dominant species ever reach.')) +
  theme_void(base_size = 10.5) + theme(plot.caption = element_text(hjust = 0, size = 8.2, colour = 'grey20', lineheight = 1.1),
        plot.background = element_rect(fill = 'white', colour = NA), plot.margin = margin(10, 12, 8, 12))
out <- 'G:/My Drive/Projects/MRC/figures'
ggsave(file.path(out, 'ch08_fig0_braun_blanquet.png'), g, width = 8, height = 2.9, dpi = 300, bg = 'white')
ggsave(file.path(out, 'ch08_fig0_braun_blanquet.pdf'), g, width = 8, height = 2.9, device = cairo_pdf)
g
