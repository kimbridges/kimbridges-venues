# ch03_fig1_color_ladders.R -- MRC chapter 3: the colors of warning and rating scales, side by side, ordered by concern.
# Colors: AQI from EPA's published RGB (2018 TAD); UV Index as approximate screen equivalents of WHO's Pantone references
# (PMS 375, 102, 151, 032, 265); the others are the NAMED colors in each scheme, drawn with standard screen colors.
# Sources: EPA; WHO 2002; Japan Ministry of the Environment; ANSI Z535; CHEMM (START triage); NIFC (US fire danger sign);
# NSW Government (Australian Fire Danger Rating, 2022); DHS (Homeland Security Advisory System, 2002-2011); avalanche.org / EAWS.
# Panel (b): the same ladders as seen with deuteranopia (red-green color blindness), simulated with colorspace::deutan().
library(ggplot2); library(patchwork); library(colorspace)
col <- c(green = '#2E9E44', yellow = '#F2D024', orange = '#F28C28', red = '#D62828', blue = '#1F6FB2', sky = '#7FC8F8', purple = '#7B3FA0',
         black = '#222222', white = '#F4F4F4', maroon = '#7E0023')
L <- function(scale, names, colors) data.frame(scale = scale, level = seq_along(names), name = names, fill = colors)
d <- rbind(
  L('Air Quality\nIndex (US)', c('Good', 'Moderate', 'Unhealthy for\nsens. groups', 'Unhealthy', 'Very\nunhealthy', 'Hazardous'),
    c('#00E400', '#FFFF00', '#FF7E00', '#FF0000', '#8F3F97', '#7E0023')),
  L('UV Index\n(WHO)', c('Low', 'Moderate', 'High', 'Very high', 'Extreme'), c('#97D700', '#FCE300', '#FF8200', '#EF3340', '#9063CD')),
  L('Heat stress,\nWBGT (Japan)', c('Almost safe', 'Caution', 'Warning', 'Severe\nwarning', 'Danger'), col[c('blue', 'sky', 'yellow', 'orange', 'red')]),
  L('Safety signs\n(ANSI)', c('NOTICE', 'CAUTION', 'WARNING', 'DANGER'), col[c('blue', 'yellow', 'orange', 'red')]),
  L('Fire danger\n(US sign)', c('Low', 'Moderate', 'High', 'Very high', 'Extreme'), col[c('green', 'blue', 'yellow', 'orange', 'red')]),
  L('Fire danger\n(Australia, 2022)', c('Moderate', 'High', 'Extreme', 'Catastrophic'), col[c('green', 'yellow', 'orange', 'red')]),
  L('Terror alert\n(US, 2002-11)', c('Low', 'Guarded', 'Elevated', 'High', 'Severe'), col[c('green', 'blue', 'yellow', 'orange', 'red')]),
  L('Avalanche\n(N. America)', c('Low', 'Moderate', 'Consid-\nerable', 'High', 'Extreme'), col[c('green', 'yellow', 'orange', 'red', 'black')]),
  L('Triage tags\n(START)', c('Minor', 'Delayed', 'Immediate', 'Expectant'), col[c('green', 'yellow', 'red', 'black')]))
d$scale <- factor(d$scale, levels = unique(d$scale)); d$x <- as.numeric(d$scale)
lum <- function(h) { r <- grDevices::col2rgb(h) / 255; 0.299 * r[1, ] + 0.587 * r[2, ] + 0.114 * r[3, ] }
panel <- function(dd, title, tag) ggplot(dd) +
  geom_tile(aes(x, level, fill = I(fill)), width = 0.92, height = 0.92, colour = 'white') +
  geom_text(aes(x, level, label = name, colour = I(ifelse(lum(fill) < 0.5, 'white', 'grey10'))), size = 2.35, lineheight = 0.85) +
  scale_x_continuous(breaks = seq_along(levels(d$scale)), labels = levels(d$scale), position = 'top', expand = c(0.01, 0)) +
  scale_y_continuous(breaks = 1:6, labels = c('least\nconcern', '', '', '', '', 'most\nconcern'), expand = c(0.01, 0)) +
  labs(x = NULL, y = NULL, tag = tag, subtitle = title) +
  theme_minimal(base_size = 9.5) + theme(panel.grid = element_blank(), axis.text.x = element_text(size = 7.6, lineheight = 0.9, colour = 'grey15'),
        axis.text.y = element_text(size = 7.5, colour = 'grey35'), plot.subtitle = element_text(size = 9, face = 'bold', colour = 'grey20'))
ga <- panel(d, 'As designed', 'a')
db <- d; db$fill <- deutan(db$fill)
gb <- panel(db, 'As seen with red-green color blindness (simulated)', 'b') +
  labs(caption = paste0('How to read: each column is one scale, with its levels stacked from least concern (bottom) to most (top). Most scales climb the same ladder,\n',
    'green to yellow to orange to red, so the order of concern is carried by color. The exceptions stand out: blue for "moderate" fire danger and\n',
    '"guarded" terror risk, blue for "almost safe" heat in Japan, and four different colors at the top. Panel (b) shows what about one man in twelve\n',
    'of European descent sees: green, yellow and orange draw close, and green and red can be confused. Names, position and order carry the message too.\n',
    'AQI colors are EPA\'s published values; UV colors approximate WHO\'s Pantone references; the rest are the named colors of each scheme.')) +
  theme(plot.caption = element_text(hjust = 0, size = 7.8, colour = 'grey20', lineheight = 1.1))
g <- ga / gb
out <- 'G:/My Drive/Projects/MRC/figures'
ggsave(file.path(out, 'ch03_fig1_color_ladders.png'), g, width = 9.5, height = 8.6, dpi = 300, bg = 'white')
ggsave(file.path(out, 'ch03_fig1_color_ladders.pdf'), g, width = 9.5, height = 8.6, device = cairo_pdf)
g
