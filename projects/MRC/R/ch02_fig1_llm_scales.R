# ch02_fig1_llm_scales.R -- MRC chapter 2: where 'cold', 'chilly', 'warm' and 'hot' begin, by city, as elicited from three AI models,
# plotted against each city's climate; with the ASHRAE-55 adaptive comfort model as an independent, field-based yardstick.
# Data: data/llm_comfort_thresholds_24cities.csv (from R/ch02_llm_elicit.R). Climate: WorldClim 2.1 (bio1, annual mean).
# ASHRAE 55 adaptive model: neutral T = 0.31 * prevailing mean outdoor T + 17.8 C, valid 10-33.5 C, 80% band +/- 3.5 C.
# CAVEAT: the adaptive model is for naturally ventilated buildings and uses a running mean of recent outdoor temperature;
# annual mean is used here only as an approximation.
library(ggplot2); library(patchwork)
el <- read.csv('G:/My Drive/Projects/MRC/data/llm_comfort_thresholds_24cities.csv', stringsAsFactors = FALSE)
f2c <- function(f) (f - 32) * 5/9; c2f <- function(c) c * 9/5 + 32
el$meanF <- c2f(el$mean)
long <- do.call(rbind, lapply(c('cold', 'chilly', 'warm', 'hot'), function(w) data.frame(city = el$city, model = el$model, meanF = el$meanF, word = w, t = el[[w]])))
pm <- aggregate(t ~ city + model + word + meanF, long, median)                      # one value per model (median of repeats)
pc <- do.call(data.frame, aggregate(t ~ city + word + meanF, pm, function(v) c(avg = mean(v), lo = min(v), hi = max(v))))
names(pc)[4:6] <- c('avg', 'lo', 'hi')
pc$word <- factor(pc$word, levels = c('hot', 'warm', 'chilly', 'cold'))
fits <- do.call(rbind, lapply(levels(pc$word), function(w) { m <- lm(avg ~ meanF, pc[pc$word == w, ]); data.frame(word = w, slope = coef(m)[2], int = coef(m)[1]) }))
ash <- data.frame(x = seq(c2f(10), c2f(33.5), length.out = 50)); ash$n <- c2f(0.31 * f2c(ash$x) + 17.8); ash$lo <- ash$n - 3.5 * 9/5; ash$hi <- ash$n + 3.5 * 9/5
pal <- c(hot = '#b0172a', warm = '#f4a261', chilly = '#7fb3d5', cold = '#1b4f8a')
lab_c <- c('Fairbanks', 'Moscow', 'London', 'Tokyo', 'Phoenix', 'Honolulu', 'Singapore')
ex <- pc[pc$word == 'cold' & pc$city %in% c('Fairbanks', 'Honolulu'), ]
g <- ggplot() +
  geom_ribbon(data = ash, aes(x, ymin = lo, ymax = hi), fill = 'grey80', alpha = 0.6) +
  geom_line(data = ash, aes(x, n), colour = 'grey35', linewidth = 0.6, linetype = '22') +
  annotate('segment', x = 88, xend = 85, y = 52, yend = 70, colour = 'grey45', linewidth = 0.3) +
  annotate('label', x = 92.5, y = 50, hjust = 1, vjust = 1, size = 2.6, colour = 'grey25', lineheight = 0.95, fill = 'white', label.r = unit(0, 'pt'),
           label = 'comfortable indoors, from field studies\n(ASHRAE 55 adaptive model, 80% band)') +
  geom_abline(data = fits, aes(slope = slope, intercept = int, colour = word), linewidth = 0.5, alpha = 0.7) +
  geom_linerange(data = pc, aes(meanF, ymin = lo, ymax = hi, colour = word), linewidth = 0.4, alpha = 0.6) +
  geom_point(data = pc, aes(meanF, avg, colour = word), size = 1.9) +
  geom_text(data = unique(pc[pc$city %in% lab_c, c('city', 'meanF')]), aes(meanF, -8, label = city), angle = 90, hjust = 0, size = 2.6, colour = 'grey30') +
  scale_colour_manual(values = pal, name = 'the word begins at', labels = c(hot = "'hot' above", warm = "'warm' above", chilly = "'chilly' below", cold = "'cold' below")) +
  labs(x = 'the city\'s annual mean temperature (\u00B0F)', y = 'where the word begins (\u00B0F)',
       tag = 'a', caption = sprintf(paste0('How to read (a): each dot is one city, the average of three AI models (vertical line: their range). In Fairbanks, "cold" begins below %.0f\u00B0F; in\n',
         'Honolulu, below %.0f\u00B0F. For every 10\u00B0F warmer the climate, "cold" starts about %.0f\u00B0F higher but "hot" only about %.0f\u00B0F higher: the words crowd together where\n',
         'the climate is warm. Grey band: comfortable INDOOR temperatures from field studies (ASHRAE 55 adaptive model) -- a different measurement, for comparison.'),
         ex$avg[ex$city == 'Fairbanks'], ex$avg[ex$city == 'Honolulu'], 10 * fits$slope[fits$word == 'cold'], 10 * fits$slope[fits$word == 'hot'])) +
  scale_x_continuous(breaks = seq(20, 90, 10)) + scale_y_continuous(breaks = seq(-10, 110, 10)) +
  theme_minimal(base_size = 10.5) + theme(panel.grid.minor = element_blank(), legend.position = 'right',
        plot.caption = element_text(hjust = 0, size = 8, colour = 'grey20', lineheight = 1.1))
# (b) the span of the words vs the span of the seasons
sp <- do.call(data.frame, aggregate(cbind(cold, hot) ~ city + model + warmq + coldq, el, median))
sp$words <- sp$hot - sp$cold; sp$seasons <- (sp$warmq - sp$coldq) * 9/5
spc <- do.call(data.frame, aggregate(words ~ city + seasons, sp, function(v) c(avg = mean(v), lo = min(v), hi = max(v)))); names(spc)[3:5] <- c('avg', 'lo', 'hi')
r_sp <- cor(spc$avg, spc$seasons); fit_sp <- coef(lm(avg ~ seasons, spc))
lab2 <- spc[spc$city %in% c('Singapore', 'Honolulu', 'London', 'Phoenix', 'Fairbanks', 'Ulaanbaatar', 'Tokyo', 'Minneapolis'), ]
gb <- ggplot(spc, aes(seasons, avg)) + geom_abline(slope = fit_sp[2], intercept = fit_sp[1], colour = 'grey50', linewidth = 0.5) +
  geom_linerange(aes(ymin = lo, ymax = hi), colour = 'grey60', linewidth = 0.4) + geom_point(size = 2, colour = '#3a3a3a') +
  ggrepel::geom_text_repel(data = lab2, aes(label = city), size = 2.6, colour = 'grey25', min.segment.length = 0, seed = 1, box.padding = 0.4) +
  labs(x = 'seasonal range: warmest minus coldest quarter (\u00B0F)', y = "span from 'cold' to 'hot' (\u00B0F)", tag = 'b',
       caption = sprintf(paste0('How to read (b): each dot is one city. Where the seasons are nearly the same (Singapore), the whole vocabulary from "cold" to "hot" fits in\n',
         'about %.0f\u00B0F; where they differ greatly (Fairbanks, Ulaanbaatar), it stretches past 70\u00B0F. Across the 24 cities the two spans move together (r = %.2f).\n',
         'Models: Claude Sonnet 5.5, GPT-5-mini, Gemini 3.8 Flash, each asked 3 times (Nov 2026). Climate: WorldClim 2.1.'), spc$avg[spc$city == 'Singapore'], r_sp)) +
  theme_minimal(base_size = 10.5) + theme(panel.grid.minor = element_blank(), plot.caption = element_text(hjust = 0, size = 8, colour = 'grey20', lineheight = 1.1))
g <- g / gb + plot_layout(heights = c(1.5, 1))
out <- 'G:/My Drive/Projects/MRC/figures'
ggsave(file.path(out, 'ch02_fig1_llm_scales.png'), g, width = 8.5, height = 10, dpi = 300, bg = 'white')
ggsave(file.path(out, 'ch02_fig1_llm_scales.pdf'), g, width = 8.5, height = 10, device = cairo_pdf)
attr(g, 'stats') <- list(fits = fits, pc = pc, r_sp = r_sp, fit_sp = fit_sp, spc = spc)
g
