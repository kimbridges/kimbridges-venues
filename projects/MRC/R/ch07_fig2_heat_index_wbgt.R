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
  scale_shape_manual(values = c(Phoenix = 21, Tokyo = 24), name = "daily peak hour"),
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
gb <- ggplot() + geom_raster(data = gr, aes(T, RH, fill = wbc)) + scale_fill_manual(values = pal5, name = "Japan WBGT\n(Ministry of the\nEnvironment levels)") + pts() +
  annotate("segment", x = ex$T, y = ex$RH, xend = c(112, 84), yend = c(33, 82), colour = "#1b6ca8", linewidth = 0.4) +
  annotate("point", x = ex$T, y = ex$RH, shape = 23, size = 3, fill = "#1b6ca8", colour = "white", stroke = 0.8) +
  annotate("label", x = c(112, 84), y = c(38, 88), hjust = 0.5, size = 2.8, colour = "#1b6ca8", fontface = "bold", fill = "white", label.r = unit(0, "pt"),
           label = sprintf("%s: WBGT %.1f", ex$city, ex$wb)) + labs(tag = "b",
  caption = sprintf("How to read: each symbol is one summer day's hottest hour (Jun-Sep 2021-2025); the colours are the categories each country's index assigns to\nevery combination of temperature and humidity. The two blue diamonds are both 'Extreme caution' to the US heat index (a), but Japan's WBGT\nputs the dry Phoenix afternoon at %.1f ('%s') and the humid Tokyo one at %.1f ('%s') (b) -- same goal, different measurement, different category.\nWBGT here is an approximation (Australian Bureau of Meteorology formula); data: Iowa Environmental Mesonet, airport observations.",
    ex$wb[1], as.character(cut(ex$wb[1], c(-Inf,21,25,28,31,Inf), right = FALSE, labels = levels(gr$wbc))), ex$wb[2], as.character(cut(ex$wb[2], c(-Inf,21,25,28,31,Inf), right = FALSE, labels = levels(gr$wbc))))) +
  theme(plot.caption = element_text(hjust = 0, size = 8, colour = "grey20"))
gb <- gb + guides(shape = "none")
g <- ga / gb
out <- "G:/My Drive/Projects/MRC/figures"
ggsave(file.path(out, "ch07_fig2_heat_index_wbgt.png"), g, width = 8, height = 9, dpi = 300, bg = "white")
ggsave(file.path(out, "ch07_fig2_heat_index_wbgt.pdf"), g, width = 8, height = 9, device = cairo_pdf)
attr(g, "stats") <- list(ex = ex, ndays = table(pk$city),
  hi_tab = table(pk$city, cut(pk$hi, c(-Inf, 80, 90, 103, 125, Inf), right = FALSE, labels = levels(gr$hic))),
  wb_tab = table(pk$city, cut(pk$wbgt, c(-Inf, 21, 25, 28, 31, Inf), right = FALSE, labels = levels(gr$wbc))))
g
