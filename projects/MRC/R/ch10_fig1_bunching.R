# ch10_fig1_bunching.R -- MRC chapter 10: categories reshape the measurements.
# (a) Boston Marathon official finishing times 2001-2014 (llimllib/bostonmarathon on GitHub, from BAA results).
# (b) England & Wales house sales 2013 (HM Land Registry Price Paid Data, standard 'A' transactions; OGL).
#     2013 stamp duty was a SLAB tax: 1% of the WHOLE price up to 250,000, 3% of the whole price above it.
library(ggplot2); library(patchwork)
bm <- readRDS("G:/My Drive/Projects/MRC/data/boston_marathon_2001_2014.rds")
bm <- bm[bm$min >= 150 & bm$min < 330, ]
h <- as.data.frame(table(m = floor(bm$min))); h$m <- as.integer(as.character(h$m))
h$mark <- h$m %in% c(179, 209, 239, 269, 299)
k <- floor(bm$min); dr <- round(100 * (1 - sum(k == 240) / sum(k == 239)))
ga <- ggplot(h, aes(m, Freq, fill = mark)) +
  geom_col(width = 1, colour = NA) +
  scale_fill_manual(values = c(`FALSE` = "grey70", `TRUE` = "#d1495b"), guide = "none") +
  geom_vline(xintercept = c(180, 210, 240, 270, 300), linetype = "22", colour = "grey30", linewidth = 0.35) +
  scale_x_continuous(breaks = c(150, 180, 210, 240, 270, 300, 330), labels = c("2:30","3:00","3:30","4:00","4:30","5:00","5:30"), expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  annotate("label", fill = "white", label.r = unit(0, "pt"), x = 328, y = max(h$Freq) * 0.98, hjust = 1, vjust = 1, size = 3, colour = "grey15", lineheight = 1.05,
           label = sprintf("How to read: each bar counts runners finishing in one\nminute (14 races, %s finishers). Red bars are\nthe last minute before each half hour. At 4:00, %d%% fewer\nrunners finish in the minute after the line\nthan in the minute before it.", format(nrow(bm), big.mark = ","), dr)) +
  labs(x = "official finishing time (h:mm)", y = "runners per minute", tag = "a") +
  theme_minimal(base_size = 11) + theme(panel.grid.minor = element_blank(), panel.grid.major.x = element_blank())

pp <- readRDS("G:/My Drive/Projects/MRC/data/uk_pricepaid_2013_prices.rds")
q <- pp$price[pp$price >= 200000 & pp$price < 300000]
hb <- as.data.frame(table(b = floor((q - 1) / 1000) * 1000 + 1000)); hb$b <- as.numeric(as.character(hb$b))
hb$mark <- hb$b == 250000
n250 <- sum(pp$price == 250000); n_above <- sum(pp$price > 250000 & pp$price <= 252500)
gb <- ggplot(hb, aes(b / 1000, Freq, fill = mark)) +
  geom_col(width = 1, colour = NA) +
  scale_fill_manual(values = c(`FALSE` = "grey70", `TRUE` = "#d1495b"), guide = "none") +
  geom_vline(xintercept = 250.5, linetype = "22", colour = "grey30", linewidth = 0.35) +
  scale_x_continuous(breaks = seq(200, 300, 10), labels = function(x) paste0("\u00A3", x, "k"), expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  annotate("label", fill = "white", label.r = unit(0, "pt"), x = 299.3, y = max(hb$Freq) * 0.98, hjust = 1, vjust = 1, size = 3, colour = "grey15", lineheight = 1.05,
           label = sprintf("How to read: each bar counts 2013 house sales in one \u00A31,000 band.\nStamp duty jumped from 1%% to 3%% of the WHOLE price above \u00A3250,000\n(\u00A32,500 vs \u00A37,500+). %s sales were at exactly \u00A3250,000 (red);\nonly %d sold for \u00A3250,001\u2013252,500.", format(n250, big.mark = ","), n_above)) +
  labs(x = "sale price (\u00A31,000 bands; each bar is the band ending at that price)", y = "sales", tag = "b") +
  theme_minimal(base_size = 11) + theme(panel.grid.minor = element_blank(), panel.grid.major.x = element_blank())

g <- ga / gb
out <- "G:/My Drive/Projects/MRC/figures"
ggsave(file.path(out, "ch10_fig1_bunching.png"), g, width = 7.5, height = 8, dpi = 300, bg = "white")
ggsave(file.path(out, "ch10_fig1_bunching.pdf"), g, width = 7.5, height = 8, device = cairo_pdf)
attr(g, "stats") <- list(dr = dr, n250 = n250, n_above = n_above)
g
