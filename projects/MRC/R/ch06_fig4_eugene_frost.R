# ch06_fig4_eugene_frost.R -- MRC chapter 6, figure 4
# Freezing as a boundary, with real data: Eugene, Oregon (GHCN-Daily USW00024221, Eugene Airport).
# TMIN is stored in tenths of deg C; observations were made in whole deg F, so round() recovers them.
# Cold season = Oct-Apr, seasons 1995/96-2024/25 (labelled by autumn year). Last spring frost: Jan-Jun, 1996-2025.
library(ggplot2); library(patchwork)
x <- read.csv("G:/My Drive/Projects/MRC/data/GHCND_USW00024221_Eugene.csv", stringsAsFactors = FALSE)
x$date <- as.Date(x$DATE); x$tmin <- round(x$TMIN / 10 * 9/5 + 32); x <- x[!is.na(x$tmin), ]
x$yr <- as.integer(format(x$date, "%Y")); x$mo <- as.integer(format(x$date, "%m"))
x$season <- ifelse(x$mo >= 7, x$yr, x$yr - 1)
cs <- x[x$mo %in% c(10:12, 1:4) & x$season >= 1995 & x$season <= 2024, ]
nseas <- length(unique(cs$season))

# ---- panel a: the value ON the line ----
h <- as.data.frame(table(tmin = cs$tmin)); h$tmin <- as.integer(as.character(h$tmin)); h <- h[h$tmin >= 18 & h$tmin <= 46, ]
h$grp <- ifelse(h$tmin == 32, "on", ifelse(h$tmin %in% c(31, 33), "near", "other"))
pct32 <- 100 * mean(cs$tmin == 32)
le <- sum(cs$tmin <= 32) / nseas; lt <- sum(cs$tmin < 32) / nseas
ga <- ggplot(h, aes(tmin, Freq / nseas, fill = grp)) +
  annotate("rect", xmin = -Inf, xmax = 32, ymin = -Inf, ymax = Inf, fill = "#f4f7fa") +
  geom_col(width = 0.82) +
  annotate("segment", x = 32, xend = 32, y = 0, yend = 12.2, linetype = "22", colour = "grey35", linewidth = 0.4) +
  scale_fill_manual(values = c(on = "#d1495b", near = "#e9a3ab", other = "grey72"), guide = "none") +
  annotate("text", x = 18.5, y = 19.6, hjust = 0, vjust = 1, size = 3, colour = "grey15", lineheight = 1.05,
           label = sprintf("How to read: each bar counts nights per winter with that whole-degree\nminimum. The red bar -- %.0f%% of all cold-season nights -- sits exactly\non 32 \u00B0F. Count it as frost (\u2264 32) and Eugene has %.0f frost nights a\nwinter; don't (< 32) and it has %.0f. The rule for the line decides.", pct32, le, lt)) +
  scale_x_continuous(breaks = seq(18, 46, 2), expand = c(0.01, 0)) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 20), breaks = seq(0, 15, 5)) +
  labs(x = "nightly minimum temperature (\u00B0F), October\u2013April", y = "nights per winter", tag = "a") +
  theme_minimal(base_size = 11) + theme(panel.grid.minor = element_blank(), panel.grid.major.x = element_blank())

# ---- panel b: the boundary in time ----
sp <- x[x$mo <= 6 & x$yr >= 1996 & x$yr <= 2025, ]
lf <- do.call(rbind, lapply(c(31, 32, 33), function(th) {
  r <- do.call(rbind, lapply(split(sp, sp$yr), function(d) { k <- which(d$tmin <= th)
    data.frame(yr = d$yr[1], doy = if (length(k)) as.integer(format(d$date[max(k)], "%j")) else NA_integer_) }))
  r$th <- th; r }))
lf$th_lab <- factor(sprintf("\u2264 %d \u00B0F", lf$th), levels = sprintf("\u2264 %d \u00B0F", c(31, 32, 33)))
rng <- aggregate(doy ~ yr, lf, range); rng <- data.frame(yr = rng$yr, lo = rng$doy[, 1], hi = rng$doy[, 2])
w <- reshape(lf[, c("yr", "th", "doy")], idvar = "yr", timevar = "th", direction = "wide")
w$s <- w$doy.33 - w$doy.32; big <- w[which.max(w$s), ]; med <- median(abs(w$s), na.rm = TRUE)
pal <- c("#1b6ca8", "#d1495b", "#3a3a3a")
brk <- as.integer(format(as.Date(c("2001-03-01", "2001-04-01", "2001-05-01", "2001-06-01")), "%j"))
gb <- ggplot() +
  geom_segment(data = rng, aes(x = yr, xend = yr, y = lo, yend = hi), colour = "grey70", linewidth = 0.5) +
  annotate("segment", x = big$yr, xend = big$yr, y = big$doy.31, yend = big$doy.33, colour = "grey25", linewidth = 1.1) +
  geom_point(data = lf, aes(yr, doy, colour = th_lab), size = 1.8) +
  scale_colour_manual(values = pal, name = "last spring night at or below") +
  annotate("text", x = 1995.3, y = 216, hjust = 0, vjust = 1, size = 3, colour = "grey15", lineheight = 1.05,
           label = sprintf("How to read: each column is one spring; the grey line spans the last-frost dates given by the three\nthresholds. In most years moving the line from 32 to 33 \u00B0F moves the last frost %g days (median);\nin %d (dark line) it moves it %d days.", med, big$yr, big$s)) +
  scale_y_continuous(limits = c(NA, 217), breaks = brk, labels = c("1 Mar", "1 Apr", "1 May", "1 Jun")) +
  scale_x_continuous(breaks = seq(1996, 2024, 4)) +
  labs(x = NULL, y = "date of last spring frost", tag = "b") +
  theme_minimal(base_size = 11) + theme(panel.grid.minor = element_blank(), legend.position = "top", legend.justification = "left")

g <- ga / gb + plot_layout(heights = c(1, 1.05))
out <- "G:/My Drive/Projects/MRC/figures"
ggsave(file.path(out, "ch06_fig4_eugene_frost.png"), g, width = 7.5, height = 8.2, dpi = 300, bg = "white")
ggsave(file.path(out, "ch06_fig4_eugene_frost.pdf"), g, width = 7.5, height = 8.2, device = cairo_pdf)
attr(g, "stats") <- list(pct32 = pct32, le = le, lt = lt, big = big, med = med, nseas = nseas)
g
