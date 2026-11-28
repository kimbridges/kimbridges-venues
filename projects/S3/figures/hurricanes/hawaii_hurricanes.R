# hawaii_hurricanes.R -- hurricane tracks near Hawai'i by ENSO phase, with the current season against the envelope (S3, ch.6 and ch.10).
# Kim + Claude, 2026-11-27. Data: NOAA IBTrACS v04r01 (EP list + last3years for the current season), CPC ONI and RONI.
library(ggplot2); library(patchwork); library(sf)
hh_islands <- data.frame(lon = c(-159.5, -157.97, -156.3, -155.5), lat = c(22.05, 21.45, 20.8, 19.6))   # Kaua'i, O'ahu, Maui, Hawai'i
hh_get <- function(dir, season_now = 2026) {
  base <- "https://www.ncei.noaa.gov/data/international-best-track-archive-for-climate-stewardship-ibtracs/v04r01/access/csv/"
  for (f in c("ibtracs.EP.list.v04r01.csv", "ibtracs.last3years.list.v04r01.csv")) download.file(paste0(base, f), file.path(dir, f), mode = "wb", quiet = TRUE)
  download.file("https://www.cpc.ncep.noaa.gov/data/indices/oni.ascii.txt", file.path(dir, "oni.txt"), mode = "wb", quiet = TRUE)
  rd <- function(f) { h <- names(read.csv(file.path(dir, f), nrows = 1)); z <- read.csv(file.path(dir, f), skip = 2, header = FALSE, stringsAsFactors = FALSE, na.strings = c("", " ")); names(z) <- h
    z[z$BASIN == "EP", c("SID", "SEASON", "NAME", "SUBBASIN", "ISO_TIME", "LAT", "LON", "USA_WIND")] }
  ep <- rd("ibtracs.EP.list.v04r01.csv"); l3 <- rd("ibtracs.last3years.list.v04r01.csv")
  tr <- rbind(ep[ep$SEASON < season_now, ], l3[l3$SEASON == season_now, ]); for (v in c("LAT", "LON", "USA_WIND", "SEASON")) tr[[v]] <- suppressWarnings(as.numeric(tr[[v]]))
  tr$LON <- ifelse(tr$LON > 0, tr$LON - 360, tr$LON); tr <- tr[!is.na(tr$LAT), ]; tr <- tr[order(tr$SID, tr$ISO_TIME), ]
  hav <- function(a, b, c, d) { r <- base::pi / 180; 6371 * 2 * asin(sqrt(sin((c - a) * r / 2)^2 + cos(a * r) * cos(c * r) * sin((d - b) * r / 2)^2)) }
  tr$dmin <- apply(sapply(seq_len(nrow(hh_islands)), function(i) hav(tr$LAT, tr$LON, hh_islands$lat[i], hh_islands$lon[i])), 1, min)
  oni <- read.table(file.path(dir, "oni.txt"), header = TRUE); en <- oni[oni$SEAS == "ASO", c("YR", "ANOM")]; names(en) <- c("SEASON", "oni")
  en$cls <- ifelse(en$oni >= 0.5, "El Nino", "other"); list(tr = tr, en = en) }
hh_fig <- function(D, file, y0 = 1971, y1 = 2025, now = 2026, radius = 500, bx = c(-181, -139, 8, 30), highlight = list(c("INIKI", 1992, "Iniki 1992"), c("IWA", 1982, "Iwa 1982"))) {
  tr <- merge(D$tr, D$en[, c("SEASON", "cls")], all.x = TRUE); tr <- tr[order(tr$SID, tr$ISO_TIME), ]
  st <- do.call(rbind, lapply(split(tr, tr$SID), function(z) data.frame(SID = z$SID[1], SEASON = z$SEASON[1], cls = z$cls[1], near = min(z$dmin) <= radius,
    hur = any(z$dmin <= radius & !is.na(z$USA_WIND) & z$USA_WIND >= 64))))
  cnt <- merge(D$en[D$en$SEASON >= y0 & D$en$SEASON <= y1, ], aggregate(cbind(n = near, h = hur) ~ SEASON, st, sum), all.x = TRUE); cnt[is.na(cnt)] <- 0
  mn <- aggregate(cbind(n, h) ~ cls, cnt, mean); nn <- table(cnt$cls); pw <- wilcox.test(n ~ cls, cnt)$p.value
  sn <- st[st$SEASON == now, ]; n_now <- sum(sn$near); h_now <- sum(sn$hur)
  inbox <- unique(tr$SID[tr$LON >= bx[1] & tr$LON <= bx[2] & tr$LAT >= bx[3] & tr$LAT <= bx[4]])
  seg <- do.call(rbind, lapply(split(tr[tr$SID %in% inbox, ], tr$SID[tr$SID %in% inbox]), function(z) { n <- nrow(z); if (n < 2) return(NULL)
    data.frame(SID = z$SID[1], SEASON = z$SEASON[1], NAME = z$NAME[1], cls = z$cls[1], x = z$LON[-n], y = z$LAT[-n], xe = z$LON[-1], ye = z$LAT[-1], w = z$USA_WIND[-n]) }))
  seg$cat <- cut(seg$w, c(-Inf, 33, 63, Inf), labels = c("below storm strength", "tropical storm", "hurricane")); seg$cat[is.na(seg$cat)] <- "below storm strength"
  land <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf"); land <- suppressWarnings(st_crop(st_make_valid(land), xmin = bx[1], xmax = bx[2], ymin = bx[3], ymax = bx[4]))
  ring <- st_transform(st_union(st_buffer(st_transform(st_as_sf(hh_islands, coords = c("lon", "lat"), crs = 4326), 3857), radius * 1000 / cos(21 * base::pi / 180))), 4326)
  segcol <- c(`below storm strength` = "grey70", `tropical storm` = "#e0a030", hurricane = "#b2182b")
  mapp <- function(d, title, sub, lw = 0.35, alpha = 0.7, lab = NULL, hl = NULL, legend = FALSE) {
    p <- ggplot() + geom_sf(data = ring, fill = "#2c5c8f", alpha = 0.06, color = "#2c5c8f", linetype = "dashed", linewidth = 0.3)
    if (!is.null(hl)) p <- p + geom_segment(data = hl, aes(x, y, xend = xe, yend = ye), linewidth = 2.2, color = "black", lineend = "round")
    p <- p + geom_segment(data = d, aes(x, y, xend = xe, yend = ye, color = cat), linewidth = lw, alpha = alpha, lineend = "round") +
      geom_sf(data = land, fill = "grey35", color = NA) + scale_color_manual(values = segcol, name = NULL, drop = FALSE, guide = if (legend) guide_legend(override.aes = list(linewidth = 1.2, alpha = 1)) else "none") +
      coord_sf(xlim = bx[1:2] + c(1, -1), ylim = bx[3:4], expand = FALSE) + labs(title = title, subtitle = sub, x = NULL, y = NULL) + theme_minimal(base_size = 11) +
      theme(plot.title = element_text(face = "bold", size = 11.5), plot.subtitle = element_text(color = "grey35", size = 9.5), legend.position = "bottom", panel.grid = element_line(color = "grey92"))
    if (!is.null(lab)) p <- p + geom_label(data = lab, aes(x, y, label = NAME), size = 3, label.size = 0, fill = scales::alpha("white", 0.85), label.padding = unit(0.1, "lines"), fontface = "bold")
    p }
  hlab <- function(d, h) { z <- d[d$NAME == h[1] & d$SEASON == as.numeric(h[2]), ]; if (!nrow(z)) return(NULL); k <- which.min((z$x + 159.5)^2 + (z$y - 22)^2); list(seg = z, lab = data.frame(NAME = h[3], x = z$x[k] - 3, y = z$y[k] + 0.9)) }
  sA <- seg[seg$SEASON >= y0 & seg$SEASON <= y1 & seg$cls == "other", ]; sB <- seg[seg$SEASON >= y0 & seg$SEASON <= y1 & seg$cls == "El Nino", ]; sC <- seg[seg$SEASON == now, ]
  hA <- hlab(sA, highlight[[1]]); hB <- hlab(sB, highlight[[2]])
  labC <- do.call(rbind, lapply(split(sC, sC$NAME), function(z) { k <- which.min((z$x + 157.5)^2 + (z$y - 20.5)^2); data.frame(NAME = paste0(substr(z$NAME[1], 1, 1), tolower(substring(z$NAME[1], 2))), x = z$x[k], y = z$y[k], d = min((z$x + 157.5)^2 + (z$y - 20.5)^2)) }))
  labC <- labC[labC$NAME %in% c(tools::toTitleCase(tolower(sn$SID[0])), labC$NAME[labC$d < 150]), ]
  hn <- paste(tools::toTitleCase(tolower(unique(tr$NAME[tr$SID %in% sn$SID[sn$hur]]))), collapse = ", ")
  pA <- mapp(sA, sprintf("A.  Other seasons (%d), %d-%d", nn[["other"]], y0, y1), sprintf("%.1f storms a season within %d km (dashed); %.2f at hurricane strength", mn$n[mn$cls == "other"], radius, mn$h[mn$cls == "other"]), lab = hA$lab, hl = hA$seg, legend = TRUE)
  pB <- mapp(sB, sprintf("B.  El Nino seasons (%d), %d-%d", nn[["El Nino"]], y0, y1), sprintf("%.1f storms a season within %d km; %.2f at hurricane strength", mn$n[mn$cls == "El Nino"], radius, mn$h[mn$cls == "El Nino"]), lab = hB$lab, hl = hB$seg)
  pC <- mapp(sC, sprintf("C.  %d: a very strong El Nino", now), sprintf("%d storms within %d km; %d at hurricane strength (%s)", n_now, radius, h_now, hn), lw = 0.9, alpha = 0.95, lab = labC)
  cnt$cls2 <- factor(ifelse(cnt$cls == "El Nino", "El Nino seasons", "Other seasons"), levels = c("Other seasons", "El Nino seasons"))
  pD <- ggplot(cnt, aes(cls2, n)) + geom_jitter(width = 0.14, height = 0, color = "grey45", size = 1.8) + stat_summary(fun = mean, geom = "crossbar", width = 0.45, color = "#2c5c8f", linewidth = 0.5) +
    annotate("point", x = 2.38, y = n_now, size = 3.5, color = "#b2182b") + annotate("text", x = 2.46, y = n_now, label = now, hjust = 0, color = "#b2182b", fontface = "bold", size = 3.6) +
    geom_text(data = cnt[cnt$n >= 5, ], aes(label = SEASON), nudge_x = 0.22, size = 3, color = "grey30") +
    scale_y_continuous(breaks = 0:10, name = sprintf("storms within %d km of the islands", radius)) + labs(x = NULL, title = sprintf("D.  Storms near Hawai'i, season by season (%d-%d)", y0, y1),
    subtitle = sprintf("Blue bar: mean. El Nino loads the dice, but seasons vary widely\n(difference in means not significant, p = %.2f)", pw)) + theme_minimal(base_size = 11) +
    theme(plot.title = element_text(face = "bold", size = 11.5), plot.subtitle = element_text(color = "grey35", size = 9.5), panel.grid.minor = element_blank()) + coord_cartesian(xlim = c(0.5, 2.9))
  fig <- (pA | pB) / (pC | pD) + plot_annotation(title = sprintf("Hurricane tracks near Hawai'i: El Nino seasons against the rest, and %d against both", now),
    caption = "Data: NOAA IBTrACS v04r01 (eastern/central Pacific; current season provisional, last3years file). El Nino season: ONI (Aug-Oct) >= 0.5 C (CPC). Intensity: USA agency winds (TS >= 34 kt, hurricane >= 64 kt).\nBlack: Iniki (1992, not an El Nino year) and Iwa (1982, El Nino).",
    theme = theme(plot.title = element_text(face = "bold", size = 14), plot.caption = element_text(size = 9, color = "grey40")))
  ragg::agg_png(file, width = 15, height = 11, units = "in", res = 110, background = "white"); print(fig); dev.off(); invisible(list(cnt = cnt, means = mn, p = pw, now = c(n = n_now, h = h_now))) }
# Run 2026-11-27: D <- hh_get(dir); hh_fig(D, "hawaii_hurricanes_enso.png").
# Results (1971-2025, within 500 km): El Nino 1.8 storms/season (0.50 hurricanes), other 1.4 (0.34); p = 0.65. 2026: 5 storms, 3 hurricanes (Lala, Lowell, Nolo).
# El Nino storms reaching the islands formed farther south (median 11.6 vs 13.2 N, p = 0.005), not farther west (p = 0.64).
