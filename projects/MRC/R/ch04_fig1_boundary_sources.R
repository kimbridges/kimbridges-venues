# ch04_fig1_boundary_sources.R -- MRC chapter 4: where boundaries come from, crossed with the two uses (describe / act).
# A matrix of examples used in this document. Text figure; Okabe-Ito accents.
library(ggplot2)
src <- c('Nature', 'Convention', 'Agreement', 'Comparison', 'Model', 'History and rank', 'The person', 'Purpose and economy', 'Human capacity')
what <- c('the world has a joint', 'a round number, chosen', 'experts set a line', 'the competitors set it', 'a theory or formula sets it',
          'the record sets it, and it moves', 'one person draws it', 'the job to be done sets it', 'how many we can tell apart')
des <- c('tree line; freezing point', '"fourteeners" (14,000 ft)', 'soil texture classes', 'first, second, third place', 'Holdridge life zones',
         'season home-run record', 'my sense of "chilly"', 'S, M, L for mass-made shirts', 'Braun-Blanquet cover classes')
act <- c('frost: cover the plants', 'headlights 30 minutes after sunset', 'fever at 38.0 \u00B0C; hypertension 130/80', 'win or lose the game',
         'heat index "Danger"', 'a top-10 list always has ten', 'my fuel-gauge ladder; "old" at 50', 'Kona coffee vacation', 'four to six rungs on a warning scale')
d <- data.frame(y = rev(seq_along(src)), src, what, des, act)
x0 <- 0; x1 <- 2.9; x2 <- 6.1; x3 <- 10
g <- ggplot(d) +
  geom_rect(aes(xmin = x0, xmax = x3, ymin = y - 0.46, ymax = y + 0.46), fill = ifelse(d$y %% 2 == 0, '#F2F2F2', '#FFFFFF'), colour = NA) +
  geom_text(aes(x = x0 + 0.08, y = y + 0.13, label = src), hjust = 0, size = 3.4, fontface = 'bold', colour = 'grey10') +
  geom_text(aes(x = x0 + 0.08, y = y - 0.2, label = what), hjust = 0, size = 2.7, colour = 'grey35', fontface = 'italic') +
  geom_text(aes(x = x1 + 0.1, y = y, label = des), hjust = 0, size = 3, colour = '#0072B2') +
  geom_text(aes(x = x2 + 0.1, y = y, label = act), hjust = 0, size = 3, colour = '#B35C00') +
  annotate('text', x = c(x0 + 0.08, x1 + 0.1, x2 + 0.1), y = max(d$y) + 0.95, hjust = 0, size = 3.6, fontface = 'bold',
           label = c('Where the boundary comes from', 'Used to DESCRIBE', 'Used to ACT'), colour = c('grey10', '#0072B2', '#B35C00')) +
  annotate('segment', x = x0, xend = x3, y = max(d$y) + 0.55, yend = max(d$y) + 0.55, colour = 'grey40', linewidth = 0.4) +
  scale_x_continuous(limits = c(x0, x3), expand = c(0, 0)) + scale_y_continuous(limits = c(0.4, max(d$y) + 1.3), expand = c(0, 0)) +
  labs(caption = paste0('How to read: each row is one source of boundaries; each example is a category from this document. Read across a row: the same source\n',
    'can draw a line that only describes (blue) or a line that tells us to act (orange). Freezing is nature\'s boundary; covering the plants is what we do with it.')) +
  theme_void(base_size = 10.5) + theme(plot.caption = element_text(hjust = 0, size = 8, colour = 'grey20', lineheight = 1.1),
        plot.background = element_rect(fill = 'white', colour = NA), plot.margin = margin(8, 10, 8, 10))
out <- 'G:/My Drive/Projects/MRC/figures'
ggsave(file.path(out, 'ch04_fig1_boundary_sources.png'), g, width = 9.5, height = 6.2, dpi = 300, bg = 'white')
ggsave(file.path(out, 'ch04_fig1_boundary_sources.pdf'), g, width = 9.5, height = 6.2, device = cairo_pdf)
g
