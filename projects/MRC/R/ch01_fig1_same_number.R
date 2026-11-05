# ch01_fig1_same_number.R -- MRC chapter 1: one number, 38, read on seven scales.
# Sources: fever >= 38.0 C (CDC); Honolulu and Chicago temperature words: median of three AI models (ch.2 data);
# Beaufort forces 5-9 in mph (NWS Miami); chest sizes: Hanes and Uniqlo Japan size guides (ch.5 data); AQI (EPA).
library(ggplot2)
seg <- function(row, unit, lo, hi, labs, br) data.frame(row = row, unit = unit, lo = lo, hi = hi, cat = labs, a = br[-length(br)], b = br[-1])
rows <- rbind(
  seg('Body temperature', '\u00B0C', 35, 41, c('no fever', 'fever'), c(35, 38, 41)),
  seg('Outdoor air, Honolulu', '\u00B0F', 20, 100, c('cold', 'chilly', 'pleasant', 'warm', 'hot'), c(20, 65, 72, 82, 88, 100)),
  seg('Outdoor air, Chicago', '\u00B0F', 20, 100, c('cold', 'chilly', 'pleasant', 'warm', 'hot'), c(20, 35, 55, 70, 85, 100)),
  seg('Wind (Beaufort)', 'mph', 19, 54, c('5 fresh breeze', '6 strong breeze', '7 near gale', '8 gale', '9 severe gale'), c(19, 25, 32, 39, 47, 54)),
  seg('Chest, Hanes (US)', 'in', 33, 45, c('S', '', 'M', '', 'L'), c(34, 36, 38, 40, 42, 44)),
  seg('Chest, Uniqlo (Japan)', 'in', 31, 42, c('S', 'M', 'L'), c(31.5, 34.6, 37.8, 40.9)),
  seg('Air Quality Index', '', 0, 150, c('Good', 'Moderate', 'Unhealthy for\nsensitive groups'), c(0, 50, 100, 150)))
rows$row <- factor(rows$row, levels = rev(unique(rows$row))); rows$y <- as.numeric(rows$row)
W <- 10   # every row is drawn W units wide; the value 38 sits at x = 0 on every row
sc <- aggregate(cbind(lo, hi) ~ row, rows, function(v) v[1]); names(sc)[2:3] <- c('rlo', 'rhi'); rows <- merge(rows, sc, by = 'row')
rows$x0 <- (rows$a - 38) / (rows$rhi - rows$rlo) * W; rows$x1 <- (rows$b - 38) / (rows$rhi - rows$rlo) * W
rows$hit <- rows$a <= 38 & 38 < rows$b | (rows$b == 38 & rows$cat %in% c('7 near gale'))
rows$hit[rows$row == 'Body temperature'] <- rows$cat[rows$row == 'Body temperature'] == 'fever'
rows$hit[rows$row == 'Chest, Hanes (US)'] <- rows$cat[rows$row == 'Chest, Hanes (US)'] == 'M'
rows <- rows[nzchar(rows$cat), ]
ticks <- unique(rbind(data.frame(row = rows$row, y = rows$y, v = rows$a, x = rows$x0), data.frame(row = rows$row, y = rows$y, v = rows$b, x = rows$x1)))
g <- ggplot(rows) +
  geom_rect(aes(xmin = x0, xmax = x1, ymin = y - 0.32, ymax = y + 0.32, fill = hit), colour = 'white', linewidth = 0.6) +
  scale_fill_manual(values = c(`FALSE` = 'grey88', `TRUE` = '#E69F00'), guide = 'none') +
  geom_text(aes(x = (x0 + x1) / 2, y = y, label = cat), size = 2.7, lineheight = 0.85, colour = 'grey15') +
  geom_text(data = ticks, aes(x = x, y = y - 0.45, label = format(v, drop0trailing = TRUE)), size = 2.3, colour = 'grey40', vjust = 1) +
  geom_text(data = unique(rows[, c('row', 'y', 'unit')]), aes(x = -6.6, y = y, label = paste0(row, ifelse(nzchar(unit), paste0(' (', unit, ')'), ''))), hjust = 1, size = 3, colour = 'grey15') +
  geom_vline(xintercept = 0, colour = '#0072B2', linewidth = 0.9) +
  annotate('label', x = 0, y = max(rows$y) + 0.85, label = '38', colour = 'white', fill = '#0072B2', fontface = 'bold', size = 4.2, label.r = unit(0, 'pt')) +
  scale_x_continuous(limits = c(-12.5, 8.6), expand = c(0, 0)) + scale_y_continuous(limits = c(0.3, max(rows$y) + 1.2), expand = c(0, 0)) +
  labs(x = NULL, y = NULL, caption = paste0('How to read: each row is a different scale, slid sideways so that the value 38 lines up on the blue line. The orange box is the category 38 falls in.\n',
    '38 is a fever, a cold day in Honolulu but only a chilly one in Chicago, a near gale, a medium shirt at Hanes but a large at Uniqlo in Japan, and good air.\n',
    'On four of these scales 38 sits right on a boundary. Temperature words for Honolulu and Chicago are the median of three AI models (Chapter 2).')) +
  theme_void(base_size = 10.5) + theme(plot.caption = element_text(hjust = 0, size = 8, colour = 'grey20', lineheight = 1.1), plot.margin = margin(8, 8, 8, 8),
                                      plot.background = element_rect(fill = 'white', colour = NA))
out <- 'G:/My Drive/Projects/MRC/figures'
ggsave(file.path(out, 'ch01_fig1_same_number.png'), g, width = 9, height = 5.2, dpi = 300, bg = 'white')
ggsave(file.path(out, 'ch01_fig1_same_number.pdf'), g, width = 9, height = 5.2, device = cairo_pdf)
g
