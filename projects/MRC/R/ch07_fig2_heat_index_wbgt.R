# ch07_fig2_heat_index_wbgt.R -- MRC chapter 7: two measurements collapsed into one index, then categorised --
# and two countries collapse them DIFFERENTLY (a Bridgman example).
# Data: Iowa Environmental Mesonet ASOS/METAR archive, Phoenix Sky Harbor (PHX) and Tokyo Haneda (RJTT), Jun-Sep 2021-2025.
# For each day, the hour with the highest US heat index. Heat index: NWS (Rothfusz regression with NWS adjustments; Steadman
# simple formula below 80 F). WBGT: Australian Bureau of Meteorology approximation for average daytime conditions
# (0.567 T + 0.393 e + 3.94; T in C, e vapour pressure in hPa) -- an APPROXIMATION of the shade-free WBGT Japan reports.
library(ggplot2); library(patchwork)
hi_nws <- function(T, RH) { s <- 0.5 * (T + 61 + (T - 68) * 1.2 + RH * 0.094); hi <- (s + T) / 2
  r <- -42.379 + 2.04901523*T + 10.14333127*RH - 0.22475541*T*RH - 6.83783e-3*T^2 - 5.481717e-2*RH^2 + 1.22874e-3*T^2*RH + 8.5282e-4*T*RH^2 - 1.99e-6*T^2*RH^2
  a1 <- ifelse(RH < 13 & T >= 80 & T <= 112, ((13 - RH) / 4) * sqrt(pmax(0, (17 - abs(T - 95)) / 17)), 0)
  a2 <- ifelse(RH > 85 & T >= 80 & T <= 87, ((RH - 85) / 10) * ((87 - T) / 5), 0)
  ifelse(hi >= 80, r - a1 + a2, hi) }
wbgt_bom <- function(Tf, RH) { Tc <- (Tf - 32) * 5/9; e <- RH / 100 * 6.105 * exp(17.27 * Tc / (237.7 + Tc)); 0.567 * Tc + 0.393 * e + 3.94 }
hx <- read.csv("G:/My Drive/Projects/MRC/data/iem_hourly_PHX_RJTT_JunSep_2021_2025.csv", stringsAsFactors = FALSE)
hx <- hx[is.finite(hx$tmpf) & is.finite(hx$relh), ]
hx$hi <- hi_nws(hx$tmpf, hx$relh)
hx$tz <- ifelse(hx$station == "PHX", "America/Phoenix", "Asia/Tokyo")
hx$day <- mapply(function(v, z) format(as.POSIXct(v, tz = "UTC"), "%Y-%m-%d", tz = z), hx$valid, hx$tz)
pk <- do.call(rbind, lapply(split(hx, paste(hx$station, hx$day)), function(d) d[which.max(d$hi), ]))
pk$city <- ifelse(pk$station == "PHX", "Phoenix", "Tokyo")
pk$wbgt <- wbgt_bom(pk$tmpf, pk$relh)
gr <- expand.grid(T = seq(70, 120, 0.25), RH = seq(2, 100, 0.5))
gr$hi <- hi_nws(gr$T, gr$RH); gr$wb <- wbgt_bom(gr$T, gr$RH)
gr$hic <- cut(gr$hi, c(-Inf, 80, 90, 103, 125, Inf), right = FALSE, labels = c("below 80", "Caution", "Extreme caution", "Danger", "Extreme danger"))
gr$wbc <- cut(gr$wb, c(-Inf, 21, 25, 28, 31, Inf), right = FALSE, labels = c("Almost safe", "Caution", "Warning", "Severe warning", "Danger"))
pal5 <- c("#f4f1ea", "#fbe3a2", "#f6b26b", "#e06c4f", "#a8233a")
pts <- function() list(geom_point(data = pk, aes(tmpf, relh, shape = city), size = 0.9, stroke = 0.3, colour = "grey15", fill = "white", alpha = 0.7),
  scale_shape_manual(values = c(Phoenix = 16, Tokyo = 24), name = "daily peak hour"),
  scale_x_continuous(limits = c(70, 120), expand = c(0, 0), breaks = seq(70, 120, 10)),
  scale_y_continuous(limits = c(2, 100), expand = c(0, 0)),
  labs(x = "air temperature (\u00B0F)", y = "relative humidity (%)"),
  theme_minimal(base_size = 10.5), theme(legend.text = element_text(size = 8), panel.grid.minor = element_blank()))
ex <- data.frame(city = c("Phoenix", "Tokyo"), T = c(108, 91), RH = c(9, 60))
ex$hi <- round(hi_nws(ex$T, ex$RH)); ex$wb <- round(wbgt_bom(ex$T, ex$RH), 1)
ga <- ggplot() + geom_raster(data = gr, aes(T, RH, fill = hic)) + scale_fill_manual(values = pal5, name = "US heat index\n(NWS)") + pts() +
  annotate("segment", x = ex$T, y = ex$RH, xend = c(112, 84), yend = c(33, 82), colour = "#1b6ca8", linewidth = 0.4) +
  annotate("point", x = ex$T, y = ex$RH, shape = 23, size = 3, fill = "#1b6ca8", colour = "white", stroke = 0.8) +
  annotate("label", x = c(112, 84), y = c(38, 88), hjust = 0.5, size = 2.8, colour = "#1b6ca8", fontface = "bold", fill = "white", label.r = unit(0, "pt"),
           label = sprintf("%s %d\u00B0F, %d%%:\nheat index %d", ex$city, ex$T, ex$RH, ex$hi)) + labs(tag = "a")
# (b) Tokyo only, official data: the same summer days under the US heat index (Haneda airport hourly obs, daily peak hour)
#     and Japan's MEASURED WBGT (Ministry of the Environment, Tokyo station 44132, daily maximum) -- rebuilt 2026-11-03.
mo <- read.csv("G:/My Drive/Projects/MRC/data/moe_wbgt_tokyo44132_JunSep_2021_2025.csv", stringsAsFactors = FALSE)
mo$day <- gsub("/", "-", substr(mo$t, 1, 10)); dmo <- aggregate(wo ~ day, mo[is.finite(mo$wo), ], max)
tk <- merge(pk[pk$city == "Tokyo", c("day", "hi")], dmo, by = "day")
hl <- cut(tk$hi, c(-Inf, 80, 90, 103, 125, Inf), right = FALSE, labels = levels(gr$hic))
wl <- cut(tk$wo, c(-Inf, 21, 25, 28, 31, Inf), right = FALSE, labels = levels(gr$wbc))
bb <- rbind(data.frame(scale = "US heat index", lev = levels(hl), k = 1:5, n = as.vector(table(hl))),
            data.frame(scale = "Japan WBGT (measured)", lev = levels(wl), k = 1:5, n = as.vector(table(wl))))
bb$scale <- factor(bb$scale, levels = c("Japan WBGT (measured)", "US heat index"))
bb <- bb[order(bb$scale, -bb$k), ]; bb$end <- ave(bb$n, bb$scale, FUN = cumsum); bb$mid <- bb$end - bb$n / 2
gb <- ggplot(bb) + geom_col(aes(x = n, y = scale, fill = factor(k)), width = 0.62, colour = "white", position = position_stack(reverse = FALSE)) +
  scale_fill_manual(values = setNames(pal5, 1:5), guide = "none") +
  geom_text(data = bb[bb$n >= 40, ], aes(x = mid, y = scale, label = paste0(lev, "\n", n)), size = 2.6, lineheight = 0.9,
            colour = ifelse(bb$k[bb$n >= 40] >= 4, "white", "grey15")) +
  scale_x_continuous(expand = c(0, 0)) +
  labs(x = sprintf("Tokyo summer days, June-September 2021-2025 (%d days)", nrow(tk)), y = NULL, tag = "b",
       caption = sprintf("How to read (b): the same %d Tokyo summer days, sorted by each country's scale. The US heat index calls %d of\nthem 'Danger' and puts %d below its first warning level; Japan's measured WBGT calls %d 'Danger' and only %d 'Almost safe'.\nSame air, same goal; different measurement, different categories.\n(a): each symbol is one summer day's hottest hour; colors are the US heat-index categories. Data: Iowa Environmental Mesonet\n(Phoenix, Tokyo Haneda airport observations); Japan Ministry of the Environment, measured WBGT, Tokyo station.",
         nrow(tk), sum(hl %in% c("Danger", "Extreme danger")), sum(hl == "below 80"), sum(wl == "Danger"), sum(wl == "Almost safe"))) +
  theme_minimal(base_size = 10.5) + theme(panel.grid = element_blank(), axis.text.x = element_blank(), plot.caption = element_text(hjust = 0, size = 8, colour = "grey20"))
g <- ga / gb + plot_layout(heights = c(3, 1))
out <- "G:/My Drive/Projects/MRC/figures"
ggsave(file.path(out, "ch07_fig2_heat_index_wbgt.png"), g, width = 8, height = 7.6, dpi = 300, bg = "white")
ggsave(file.path(out, "ch07_fig2_heat_index_wbgt.pdf"), g, width = 8, height = 7.6, device = cairo_pdf)
attr(g, "stats") <- list(n = nrow(tk), hl = table(hl), wl = table(wl))
g
