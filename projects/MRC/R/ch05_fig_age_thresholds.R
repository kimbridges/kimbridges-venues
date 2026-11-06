# ch05_fig_age_thresholds.R -- MRC: one measurement (age), many boundaries. US thresholds, with changes over time,
# and where people place 'old' (Pew Research Center 2009, n = 2,969). Data: data/us_age_thresholds.csv.
library(ggplot2)
a <- read.csv("G:/My Drive/Projects/MRC/data/us_age_thresholds.csv", stringsAsFactors = FALSE)
a$item[a$item == "US Representative / Senator / President"] <- "Hold federal office (House / Senate / President)"
a$item <- factor(a$item, levels = unique(a$item[order(-a$new)]))
a$group <- factor(a$group, levels = unique(a$group))
a$changed <- !is.na(a$old)
a$lab <- ifelse(a$changed, paste0(sub("\\.5$", "\u00BD", format(a$old, drop0trailing = TRUE)), " \u2192 ", a$new, "  (", a$year, ")"),
                ifelse(nzchar(a$year), paste0(a$new, "  (", a$year, ")"), as.character(a$new)))
a$lab <- trimws(sub("^ *", "", a$lab))
fo <- data.frame(item = factor("Hold federal office (House / Senate / President)", levels = levels(a$item)),
                 group = factor("Rights and permissions", levels = levels(a$group)), x = c(30, 35))
a$lab[a$item == "Hold federal office (House / Senate / President)"] <- "25, 30, 35 (1787)"
a$lab[a$item == "Required retirement-account withdrawals"] <- "70\u00BD \u2192 72 \u2192 73; 75 in 2033"
rmd <- data.frame(item = factor("Required retirement-account withdrawals", levels = levels(a$item)),
                  group = factor("Money and benefits", levels = levels(a$group)), x = 72)
col_new <- "#d1495b"
a$lx <- pmax(a$new, ifelse(is.na(a$old), 0, a$old))
a$lx[a$item == "Hold federal office (House / Senate / President)"] <- 35
a$lx[a$item == "Required retirement-account withdrawals"] <- 73
g <- ggplot(a, aes(y = item)) +
  annotate("rect", xmin = 18, xmax = 21, ymin = -Inf, ymax = Inf, fill = "#f4f7fa") +
  geom_segment(data = a[a$changed, ], aes(x = old, xend = new, yend = item), colour = "grey55", linewidth = 0.5,
               arrow = arrow(length = unit(5, "pt"), type = "closed")) +
  geom_point(data = a[a$changed, ], aes(x = old), shape = 21, fill = "white", colour = "grey45", size = 2.4) +
  geom_point(aes(x = new, fill = group == "When is one old?"), shape = 21, colour = "grey15", size = 2.6) +
  geom_point(data = fo, aes(x = x), shape = 21, fill = "grey25", colour = "grey15", size = 2.6) +
  geom_point(data = rmd, aes(x = x), shape = 21, fill = "white", colour = "grey45", size = 2.2) +
  scale_fill_manual(values = c(`FALSE` = "grey25", `TRUE` = col_new), guide = "none") +
  geom_text(aes(x = lx + 1.6, label = lab), hjust = 0, size = 2.8, colour = "grey25") +
  facet_grid(group ~ ., scales = "free_y", space = "free_y") +
  scale_x_continuous(breaks = seq(10, 90, 10), limits = c(12, 100), expand = c(0, 0)) +
  labs(x = "age (years)", y = NULL,
       caption = "How to read: each row is one US age boundary. A white dot and arrow show where the line used to be and where it\nmoved (with the year). Between 18 and 21 (shaded) a young adult crosses three lines; in 1984 and 2019 two of them moved\nup, after the voting age had moved down in 1971. Red dots: where people say 'old' begins: 60 if you are 18-29, 74 if\nyou are over 65 (Pew Research Center, 2009). My grandmother put it at 50.") +
  theme_minimal(base_size = 10.5) + theme(axis.text.y = element_text(colour = "grey20")) +
  theme(panel.grid.minor = element_blank(), panel.grid.major.y = element_blank(),
        strip.text.y = element_text(angle = 0, face = "bold", hjust = 0),
        plot.caption = element_text(hjust = 0, size = 8.5, colour = "grey20", lineheight = 1.1))
out <- "G:/My Drive/Projects/MRC/figures"
ggsave(file.path(out, "ch05_fig_age_thresholds.png"), g, width = 8, height = 6.4, dpi = 300, bg = "white")
ggsave(file.path(out, "ch05_fig_age_thresholds.pdf"), g, width = 8, height = 6.4, device = cairo_pdf)
g
