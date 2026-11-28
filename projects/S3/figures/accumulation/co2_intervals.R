# co2_intervals.R -- 'A little number times a big number is always a big number' (Kim): the Mauna Loa CO2 record seen at four sampling intervals (S3, ch.4). Kim + Claude, 2026-11-27.
# Data: NOAA Global Monitoring Laboratory, Mauna Loa Observatory: daily in situ means (1974-), monthly means (1958-), annual means (1959-).
library(ggplot2); library(patchwork)
co2_read <- function(dir) {
  rd <- function(f, nm) { l <- readLines(file.path(dir, f)); l <- l[!grepl("^#", l)]; z <- read.csv(text = paste(l, collapse = "\n"), header = !grepl("^[0-9]", l[1])); if (!is.null(nm)) names(z) <- nm; z }
  d <- rd("co2_daily_mlo.csv", c("year", "month", "day", "decimal", "ppm")); d$date <- as.Date(sprintf("%d-%02d-%02d", d$year, d$month, d$day))
  m <- rd("co2_mm_mlo.csv", NULL); m <- m[m$average > 0, ]; m$date <- as.Date(sprintf("%d-%02d-15", m$year, m$month))
  a <- rd("co2_annmean_mlo.csv", NULL); list(d = d, m = m, a = a) }
co2_changes <- function(X) {
  d <- X$d; gap <- as.integer(diff(d$date)); dd <- diff(d$ppm)[gap == 1]
  m <- X$m; mg <- (m$year[-1] * 12 + m$month[-1]) - (m$year[-nrow(m)] * 12 + m$month[-nrow(m)]); mm <- diff(m$average)[mg == 1]
  a <- X$a; ya <- diff(a$mean)[diff(a$year) == 1]
  dec <- sapply(seq_len(nrow(a)), function(i) { j <- which(a$year == a$year[i] - 10); if (length(j)) a$mean[i] - a$mean[j] else NA }); dec <- dec[!is.na(dec)]
  data.frame(interval = rep(c("day to next day", "month to next month", "year to next year", "decade to next decade"), c(length(dd), length(mm), length(ya), length(dec))), change = c(dd, mm, ya, dec)) }
co2_fig <- function(X, file) {
  ch <- co2_changes(X); lv <- c("day to next day", "month to next month", "year to next year", "decade to next decade"); ch$interval <- factor(ch$interval, levels = rev(lv))
  s <- do.call(rbind, lapply(split(ch, ch$interval), function(z) data.frame(interval = z$interval[1], n = nrow(z), up = mean(z$change > 0), dn = mean(z$change < 0), med = median(z$change), sd = sd(z$change))))
  s$lab <- sprintf("%s changes;  %.0f%% up, %.0f%% down, %.0f%% unchanged;  typical change %+.2f ppm", format(s$n, big.mark = ","), 100 * s$up, 100 * s$dn, 100 * (1 - s$up - s$dn), s$med)
  d1 <- min(X$d$date); d2 <- max(X$d$date); per_day <- (tail(X$d$ppm, 1) - X$d$ppm[1]) / as.numeric(d2 - d1)
  th <- theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank(), plot.title = element_text(face = "bold", size = 12), plot.subtitle = element_text(color = "grey35", size = 10))
  m <- X$m; a <- X$a
  pA <- ggplot(m, aes(date, average)) + geom_line(color = "#b2182b", linewidth = 0.4) + geom_point(data = transform(a, date = as.Date(sprintf("%d-07-01", year))), aes(date, mean), size = 0.9, color = "black") +
    scale_x_date(date_breaks = "10 years", date_labels = "%Y") + scale_y_continuous(name = "CO2 (ppm)") +
    annotate("text", x = as.Date("1962-01-01"), y = 415, hjust = 0, size = 3.6, label = sprintf("Mauna Loa Observatory, %d to %s\n(above the IRP transect on the same mountain)\nred: monthly means; black: annual means", min(m$year), format(max(X$d$date), "%B %d, %Y"))) +
    labs(title = "A.  The Keeling curve: the same record, before it is cut into intervals", x = NULL) + th
  pB <- ggplot(ch, aes(change, interval)) + geom_vline(xintercept = 0, color = "grey50") +
    geom_jitter(height = 0.18, size = 0.5, alpha = 0.25, color = "#2c5c8f") +
    geom_point(data = s, aes(med, interval), shape = 23, size = 3.5, fill = "#b2182b", color = "black") +
    geom_text(data = s, aes(x = 27, y = interval, label = lab), hjust = 1, vjust = -1.4, size = 3.4, color = "grey20") +
    scale_x_continuous(name = "change in CO2 over the interval (ppm)", breaks = seq(-10, 30, 5), limits = c(-8, 27)) + labs(y = NULL,
      title = "B.  A little number times a big number: the same rise, sampled four ways",
      subtitle = sprintf("Day to day the record goes up about as often as down -- the rise (%.3f ppm a day) is buried in the scatter. Month to month the seasonal cycle dominates.\nYear to year it goes up every time. Decade to decade the change is unmistakable. Red diamonds: typical (median) change.", per_day)) +
    th + theme(axis.text.y = element_text(size = 11, face = "bold"))
  fig <- pA / pB + plot_layout(heights = c(1, 1.25)) + plot_annotation(caption = "Data: NOAA Global Monitoring Laboratory, Mauna Loa (daily in situ means 1974-, monthly means 1958-, annual means 1959-); changes between consecutive days, months, years, and years ten apart.\nDarwin's worms the same way: 0.22 inch of soil a year is about 0.0006 inch a day (invisible), 2.2 inches a decade, 7 inches in 29 years. Code: co2_intervals.R.",
    theme = theme(plot.caption = element_text(size = 9, color = "grey40")))
  ragg::agg_png(file, width = 13, height = 11, units = "in", res = 110, background = "white"); print(fig); dev.off(); invisible(list(summary = s, per_day = per_day)) }
