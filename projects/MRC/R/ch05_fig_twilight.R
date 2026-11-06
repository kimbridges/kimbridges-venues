# ch05_fig_twilight.R -- MRC chapter 5: civil twilight is fixed in sun angle (6 degrees below the horizon);
# headlight statutes fix it in clock time (30 minutes after sunset). The two agree only at mid latitudes.
# Geometry: standard hour-angle formula; sunset at -0.833 deg (refraction + solar radius), civil dusk at -6 deg.
library(ggplot2)
ha <- function(h, phi, dec) { r <- pi/180; c <- (sin(h*r) - sin(phi*r)*sin(dec*r)) / (cos(phi*r)*cos(dec*r)); ifelse(abs(c) > 1, NA, acos(c)/r) }
dur <- function(phi, dec) (ha(-6, phi, dec) - ha(-0.833, phi, dec)) / 15 * 60   # minutes
lat <- seq(0, 68, by = 0.1)
seas <- c('June solstice' = 23.44, 'Equinoxes' = 0, 'December solstice' = -23.44)
d <- do.call(rbind, lapply(names(seas), function(s) data.frame(season = s, lat = lat, min = dur(lat, seas[[s]]))))
d$season <- factor(d$season, levels = names(seas)); d$min[d$min > 96] <- NA
cols <- c('June solstice' = '#E69F00', 'Equinoxes' = '#009E73', 'December solstice' = '#0072B2')
cities <- data.frame(name = c('Honolulu', 'Los Angeles', 'Chicago', 'Seattle', 'Anchorage', 'Fairbanks'),
                     lat = c(21.3, 34.1, 41.9, 47.6, 61.2, 64.8))
allnight <- 90 - 23.44 - 6   # 60.56 N
lab <- data.frame(season = factor(c('June solstice', 'December solstice', 'Equinoxes'), levels = names(seas)), y = c(86, 78, 70))
g <- ggplot(d, aes(lat, min, colour = season)) +
  geom_vline(data = cities, aes(xintercept = lat), colour = 'grey85', linewidth = 0.4) +
  geom_text(data = cities, aes(x = lat, y = 119, label = name), inherit.aes = FALSE, angle = 90, hjust = 1, vjust = -0.4, size = 3, colour = 'grey35') +
  annotate('rect', xmin = allnight, xmax = 68, ymin = 0, ymax = 120, fill = '#E69F00', alpha = 0.07) +
  annotate('text', x = 64.3, y = 12, label = 'June: twilight\nlasts all night\n(north of 60.6\u00B0 N)', size = 2.9, colour = '#9A6A00', lineheight = 0.95) +
  geom_hline(yintercept = 30, linetype = 'dashed', colour = 'grey20', linewidth = 0.5) +
  annotate('text', x = 0.5, y = 31.5, label = 'Headlight law: "30 minutes after sunset"', hjust = 0, vjust = 0, size = 3.2, colour = 'grey15') +
  geom_line(linewidth = 1.1, na.rm = TRUE) +
  geom_segment(data = lab, aes(x = 1.5, xend = 5.5, y = y, yend = y), linewidth = 1.1) + geom_text(data = lab, aes(x = 6.5, y = y, label = season), hjust = 0, size = 3.3, fontface = 'bold', show.legend = FALSE) +
  scale_colour_manual(values = cols, guide = 'none') +
  scale_x_continuous(breaks = seq(0, 70, 10), labels = function(x) paste0(x, '\u00B0 N'), expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0, 90, 15), limits = c(0, 120), expand = c(0, 0)) +
  coord_cartesian(xlim = c(0, 68), clip = 'off') +
  labs(x = 'Latitude', y = 'Minutes from sunset to the end of civil twilight',
       caption = paste0('How to read: each curve gives how long civil twilight lasts after sunset (the sun sinking to 6\u00B0 below the horizon). Find Seattle: in June\n',
         'twilight lasts about 41 minutes, so a driver who switches on headlights at the legal 30 minutes does so while the sky is still bright. In Honolulu\n',
         'twilight ends after about 25 minutes, and the law allows five more minutes in a darker sky. North of 60.6\u00B0 the June sky never gets that dark.')) +
  theme_minimal(base_size = 11) +
  theme(panel.grid.minor = element_blank(), panel.grid.major.x = element_blank(),
        plot.caption = element_text(hjust = 0, size = 8.2, colour = 'grey20', lineheight = 1.1),
        plot.background = element_rect(fill = 'white', colour = NA), plot.margin = margin(10, 14, 8, 8))
out <- 'G:/My Drive/Projects/MRC/figures'
ggsave(file.path(out, 'ch05_fig_twilight.png'), g, width = 9.5, height = 6, dpi = 300, bg = 'white')
ggsave(file.path(out, 'ch05_fig_twilight.pdf'), g, width = 9.5, height = 6, device = cairo_pdf)
g
