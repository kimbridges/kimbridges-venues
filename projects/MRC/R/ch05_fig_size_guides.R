# ch05_fig_size_guides.R -- MRC: one label, many boundaries. Men's/unisex T-shirt size guides
# (BODY chest girth) for S, M, L across brands, markets and two national standards.
# Data: data/size_guides_tshirts.csv, compiled 2026-11-01 from published size guides (see source_url column).
library(ggplot2)
d <- read.csv("G:/My Drive/Projects/MRC/data/size_guides_tshirts.csv", stringsAsFactors = FALSE)
b <- d[d$measure_type == "body" & d$size %in% c("S","M","L") & !is.na(d$chest_min_cm), ]
b$brand <- sub("ASOS \\(substitute for M&S\\)", "ASOS (UK)", b$brand)
b$brand <- sub("Nike \\(Asian sizing chart\\)", "Nike Asian-fit", b$brand)
b$brand <- sub("STANDARD: JIS L 4004:2023 \\(range sizes\\)", "JIS L 4004 (standard)", b$brand)
b$brand <- sub("STANDARD: EN 13402-3", "EN 13402-3 (standard)", b$brand)
b$grp <- ifelse(b$region == "Japan", "Japan market", ifelse(grepl("^Europe", b$region), "Europe", ifelse(b$region == "Asia-Pacific", "Japan market", "US")))
b$lab <- ifelse(b$brand %in% c("Nike","Under Armour","Uniqlo"), paste0(b$brand, " (", ifelse(b$region=="Japan","Japan","US"), ")"), b$brand)
b$std <- grepl("standard", b$lab)
# a single published value gets a small visible width
w0 <- b$chest_max_cm - b$chest_min_cm < 0.5; b$chest_min_cm[w0] <- b$chest_min_cm[w0] - 0.4; b$chest_max_cm[w0] <- b$chest_max_cm[w0] + 0.4
mm <- aggregate(cbind(lo = chest_min_cm, hi = chest_max_cm) ~ lab + grp, b[b$size == "M", ], mean)
mm$mid <- (mm$lo + mm$hi) / 2
ord <- mm$lab[order(mm$mid)]
b$lab <- factor(b$lab, levels = rev(ord))
b$grp <- factor(b$grp, levels = c("Japan market", "Europe", "US"))
b$size <- factor(b$size, levels = c("S","M","L"))
pal <- c(S = "#9ecae1", M = "#d1495b", L = "#3a3a3a")
g <- ggplot(b) +
  annotate("rect", xmin = 96, xmax = 101.6, ymin = -Inf, ymax = Inf, fill = "#fbf3ee") +
  geom_segment(aes(x = chest_min_cm, xend = chest_max_cm, y = lab, yend = lab, colour = size), linewidth = 3.2, alpha = 0.85) +
  scale_colour_manual(values = pal, name = "size label") +
  scale_x_continuous(breaks = seq(76, 116, 4), limits = c(76, 116), expand = c(0, 0)) +
  facet_grid(grp ~ ., scales = "free_y", space = "free_y") +
  labs(x = "body chest girth (cm)", y = NULL,
       caption = "How to read: each row is one size guide; the bars give the body chest it assigns to S, M and L.\nFollow the shaded column down: a man with a 96\u2013101 cm (38\u201340 in) chest is an M at Hanes and Gildan\nbut an L at Uniqlo Japan and Muji -- same body, same letters, different boundaries.\nSources: published size guides, compiled 2026-11-01 (data/size_guides_tshirts.csv).") +
  theme_minimal(base_size = 10.5) + theme(axis.text.y = element_text(colour = "grey20")) +
  theme(panel.grid.minor = element_blank(), panel.grid.major.y = element_blank(), legend.position = "top",
        legend.justification = "left", strip.text.y = element_text(angle = 0, face = "bold", hjust = 0), plot.caption = element_text(hjust = 0, size = 8.5, colour = "grey20", lineheight = 1.1))
out <- "G:/My Drive/Projects/MRC/figures"
ggsave(file.path(out, "ch05_fig_size_guides.png"), g, width = 7.5, height = 7.0, dpi = 300, bg = "white")
ggsave(file.path(out, "ch05_fig_size_guides.pdf"), g, width = 7.5, height = 7.0, device = cairo_pdf)
g
