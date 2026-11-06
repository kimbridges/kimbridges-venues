# ch09_fig1_shindo.R -- MRC chapter 9: a category scale that grew where disasters showed it too coarse.
# Japan Meteorological Agency seismic intensity (shindo): 1884 four levels; 1898 seven (0-6); 1949 eight (7 added after the
# 1948 Fukui earthquake); 1996 ten (5 and 6 split into lower/upper after Sanriku 1994 and Kobe 1995; measured by instruments).
library(ggplot2)
lv <- list(`1884` = c('faint', 'weak', 'strong', 'violent'), `1898` = as.character(0:6), `1949` = as.character(0:7),
           `1996` = c('0', '1', '2', '3', '4', '5 lower', '5 upper', '6 lower', '6 upper', '7'))
d <- do.call(rbind, lapply(names(lv), function(y) { n <- length(lv[[y]]); data.frame(yr = y, i = seq_len(n), n = n, lab = lv[[y]]) }))
d$x <- match(d$yr, names(lv))
## stack each era over the same height so a level's share of the range is visible
d$h <- 10 / d$n; d$y0 <- (d$i - 1) * d$h; d$y1 <- d$i * d$h
d$sev <- (d$i - 0.5) / d$n
new <- (d$yr == '1949' & d$lab == '7') | (d$yr == '1996' & grepl('lower|upper', d$lab))
g <- ggplot(d) +
  geom_rect(aes(xmin = x - 0.32, xmax = x + 0.32, ymin = y0, ymax = y1, fill = sev), colour = 'white', linewidth = 0.8) +
  geom_rect(data = d[new, ], aes(xmin = x - 0.32, xmax = x + 0.32, ymin = y0, ymax = y1), fill = NA, colour = 'black', linewidth = 0.9) +
  geom_text(aes(x = x, y = (y0 + y1) / 2, label = lab, colour = sev > 0.55), size = 3.1) +
  scale_fill_gradient(low = '#FFF1C9', high = '#8C1C13', guide = 'none') +
  scale_colour_manual(values = c(`FALSE` = 'grey15', `TRUE` = 'white'), guide = 'none') +
  annotate('text', x = 1:4, y = 10.55, label = paste(sapply(lv, length), 'levels'), size = 3.2, colour = 'grey25') +
  annotate('text', x = 3, y = -0.95, size = 2.9, colour = 'grey20', lineheight = 0.95,
           label = 'intensity 7 added after\nthe 1948 Fukui earthquake', hjust = 0.5) +
  annotate('text', x = 4, y = -0.95, size = 2.9, colour = 'grey20', lineheight = 0.95,
           label = '5 and 6 split after the 1994 and\n1995 earthquakes; now measured', hjust = 0.5) +
  scale_x_continuous(breaks = 1:4, labels = names(lv), limits = c(0.55, 4.95)) +
  scale_y_continuous(limits = c(-1.7, 10.9)) +
  labs(x = NULL, y = NULL, caption = paste0('How to read: each column is the scale as it stood from that year, stacked from least to most intense. Columns are drawn\n',
    'the same height to compare how finely each divided the range, not to measure shaking. Black outlines mark new levels. The 1898 "6"\n',
    'covered everything from severe shaking up; since 1996 that range is split among 6 lower, 6 upper and 7.')) +
  theme_minimal(base_size = 10.5) + theme(panel.grid = element_blank(), axis.text.y = element_blank(), axis.text.x = element_text(size = 11, face = 'bold'),
        plot.caption = element_text(hjust = 0, size = 8.2, colour = 'grey20', lineheight = 1.1), plot.background = element_rect(fill = 'white', colour = NA))
out <- 'G:/My Drive/Projects/MRC/figures'
ggsave(file.path(out, 'ch09_fig1_shindo.png'), g, width = 8, height = 5.4, dpi = 300, bg = 'white')
ggsave(file.path(out, 'ch09_fig1_shindo.pdf'), g, width = 8, height = 5.4, device = cairo_pdf)
g
