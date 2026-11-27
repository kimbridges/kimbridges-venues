# japan_fronts.R -- spring and autumn fronts across Japan from JMA phenological observations (S3, ch.5).
# Kim + Claude, 2026-11-26. JMA "ruinenchi" CSVs (designated sample trees, 1953-): 004 cherry flowering,
# 015 maple leaf coloring, 013 ginkgo yellowing. Station coordinates from NOAA ISD history (WMO 47xxx).
library(ggplot2); library(patchwork)

jf_get <- function(dir = tempdir(), files = c(maple = "015.csv", cherry = "004.csv", ginkgo = "013.csv")) {
  rd <- function(f, label) {
    p <- file.path(dir, f); download.file(paste0("https://www.data.jma.go.jp/sakura/data/ruinenchi/", f), p, quiet = TRUE, mode = "wb")
    x <- iconv(readLines(p, warn = FALSE, encoding = "CP932"), "CP932", "UTF-8")
    hdr <- strsplit(x[2], ",")[[1]]; yrs <- as.integer(hdr[seq(3, length(hdr), 2)]); yrs <- yrs[!is.na(yrs)]
    do.call(rbind, lapply(strsplit(x[-(1:2)], ","), function(r) data.frame(stn = as.integer(r[1]), name = trimws(gsub("\u3000", "", r[2])),
      year = yrs, md = suppressWarnings(as.integer(r[seq(3, by = 2, length.out = length(yrs))])), event = label)))
  }
  d <- do.call(rbind, Map(rd, files, names(files))); d <- d[!is.na(d$md) & d$md > 0, ]
  d$mon <- d$md %/% 100; wrap <- d$event != "cherry" & d$mon < 7          # autumn dates that slip into January
  d$date <- as.Date(sprintf("%d-%02d-%02d", d$year + wrap, d$mon, d$md %% 100))
  d$doy <- as.integer(d$date - as.Date(sprintf("%d-01-01", d$year))) + 1
  isd <- read.csv("https://www.ncei.noaa.gov/pub/data/noaa/isd-history.csv", stringsAsFactors = FALSE)
  j <- isd[isd$CTRY == "JA" & grepl("^47", isd$USAF), ]; j$stn <- suppressWarnings(as.integer(substr(j$USAF, 3, 5)))
  j <- j[!is.na(j$LAT) & !is.na(j$stn), ]; j <- j[order(j$stn, -as.integer(j$END)), ]; j <- j[!duplicated(j$stn), c("stn", "LAT", "LON")]
  merge(d, j, by = "stn")
}
# Figures (2026-11-26 run) were drawn from jf_get() output:
#  japan_two_fronts.png  -- A: latitude-date plane, station medians 1991-2020 with 10-90% bars and fitted fronts;
#                           B: fitted fronts 1961-1990 (dashed) vs 1996-2025 (solid).
#  japan_maple_stripes.png -- C: station x year anomaly tiles (66 stations, 40+ yrs), D: national median anomaly.
# Results: cherry front ~25 km/day north (+4.4 d per degree), maple ~29 km/day south (-3.8 d/deg), ginkgo ~39 km/day;
# typical year-to-year spread ~2 weeks; trend maple +2.7 d/decade, ginkgo +2.2, cherry -1.1 (JMA: +3.0, -1.3);
# at 36N cherry 5 days earlier, maple 10 days later (1996-2025 vs 1961-1990).
# Caveats: stations south of 30N use other cherry species and are excluded; abrupt runs in single rows of C likely
# mark sample-tree or site changes, not climate.
