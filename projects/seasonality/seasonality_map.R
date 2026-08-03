## seasonality_map.R
## Regional cue-regime maps — the whittakerr payoff (classify every grid cell, map it).
## Per-cell indices from cached WorldClim 10' + the v2 cue-regime classifier.
##
## Requires (source first):
##   source("G:/My Drive/Projects/seasonality/seasonality_harness.R")       # CACHE, SI_FLOOR
##   source("G:/My Drive/Projects/seasonality/seasonality_cue_regimes.R")   # constants, daylength, REGIME_PAL
##
## Usage:
##   r <- regime_map_region(-25,45,35,71, "NW Europe & high latitudes",
##          "G:/My Drive/Projects/seasonality/cue_regime_map_EU.png", anchors=eu_cities)
##
## Validated first on western North America (2026-06-24): the desert trio, the
## Pacific Mediterranean strip, the continental interior, and the Mexican monsoon
## all came out as coherent spatial zones with the validation cities in the right
## regimes. See proj_seasonality.md.

suppressMessages({library(terra); library(geodata); library(dplyr); library(ggplot2)})

## ---- per-cell regime grid for a geographic extent ----
compute_regime_grid <- function(xmin, xmax, ymin, ymax){
  tavg <- worldclim_global("tavg", res=10, path=CACHE)
  prec <- worldclim_global("prec", res=10, path=CACHE)
  reg  <- ext(xmin,xmax,ymin,ymax); Tr <- crop(tavg,reg); Pr <- crop(prec,reg)
  Tm <- values(Tr); Pm <- values(Pr); xy <- crds(Tr, na.rm=FALSE)
  ok <- stats::complete.cases(Tm) & stats::complete.cases(Pm)
  Tm <- Tm[ok,,drop=FALSE]; Pm <- Pm[ok,,drop=FALSE]; lon <- xy[ok,1]; lat <- xy[ok,2]

  totP <- rowSums(Pm); totP[totP==0] <- 1e-6
  SI   <- rowSums(abs(Pm - totP/12))/totP
  Tamp <- (apply(Tm,1,max) - apply(Tm,1,min))/2
  m_mean <- rowMeans(Pm - 2*Tm)
  thr6 <- apply(Tm,1,function(v) sort(v)[6])          # 6th-coldest month temp
  cool_frac <- rowSums(Pm*(Tm<=thr6))/totP
  k <- 0:11
  A1 <- sqrt((Pm%*%cos(2*pi*k/12))^2 + (Pm%*%sin(2*pi*k/12))^2)
  A2 <- sqrt((Pm%*%cos(2*pi*2*k/12))^2 + (Pm%*%sin(2*pi*2*k/12))^2)
  bimod <- ifelse(SI>=SI_FLOOR & as.numeric(A1)>1e-9, as.numeric(A2)/as.numeric(A1), 0)
  dlm <- sapply(midmonth_doy, function(dd) daylength_hours(lat,dd))
  daylamp <- (apply(dlm,1,max) - apply(dlm,1,min))/2

  rm <- dplyr::case_when(
    m_mean<0 & totP<ARID_TOTAL ~ "hyper-arid",
    m_mean<0 & SI>=RAIN_SI_REACT ~ "reactive",
    m_mean>=0 & SI>=RAIN_SI_PRED ~ "predictive", TRUE ~ "aseasonal")
  trop <- abs(lat)<=TROPIC_LAT
  tlS<-Tamp>=TEMP_STRONG; tlM<-Tamp>=TEMP_MOD & Tamp<TEMP_STRONG
  dlS<-daylamp>=DAY_STRONG; dlM<-daylamp>=DAY_MOD & daylamp<DAY_STRONG
  regime <- dplyr::case_when(
    rm=="hyper-arid" ~ "hyper-arid (cue-poor)",
    !trop & cool_frac>=WINTER_RAIN & (tlM|tlS) & totP>=ARID_TOTAL & m_mean> -15 ~ "winter-rain (Mediterranean)",
    rm=="reactive" & trop ~ "reactive-rain (arid tropical/Sahel)",
    rm=="reactive" ~ "reactive-rain (arid desert)",
    rm=="predictive" & trop ~ "rainfall-cued (tropical wet-dry)",
    rm=="predictive" & tlS ~ "thermal + summer-rain (reinforced)",
    rm=="predictive" ~ "rainfall-cued (extratropical)",
    rm=="aseasonal" & tlS ~ "temperature-cued (continental)",
    rm=="aseasonal" & tlM & dlS ~ "daylength-cued (maritime)",
    rm=="aseasonal" & !tlS & !tlM & !dlS & !dlM ~ "cue-poor (aseasonal/everwet)",
    TRUE ~ "mixed/other")
  data.frame(x=lon, y=lat, regime=regime)
}

## ---- compute + render a regional regime map ----
regime_map_region <- function(xmin, xmax, ymin, ymax, title, file,
                              anchors=NULL, width=10, height=10){
  mapdf <- compute_regime_grid(xmin,xmax,ymin,ymax)
  mapdf$regime <- factor(mapdf$regime, levels=names(REGIME_PAL))
  g <- ggplot(mapdf, aes(x,y,fill=regime)) + geom_raster() +
    scale_fill_manual(values=REGIME_PAL, name="cue regime (v2)", drop=FALSE) +
    coord_quickmap(expand=FALSE) +
    labs(x=NULL, y=NULL, title=title,
         subtitle="Per-cell cue regime from temperature + rainfall + daylength | WorldClim 10'") +
    theme_minimal(base_size=12) + theme(panel.grid=element_blank())
  if(!is.null(anchors)){
    g <- g +
      geom_point(data=anchors, aes(lon,lat), inherit.aes=FALSE, shape=21,
                 fill="white", color="black", size=2.2, stroke=0.7) +
      ggrepel::geom_text_repel(data=anchors, aes(lon,lat,label=name), inherit.aes=FALSE,
                 size=3.2, fontface="bold", box.padding=0.5, seg.color="black", max.overlaps=40)
  }
  ggsave(file, g, width=width, height=height, dpi=130); message("saved ", file)
  invisible(list(mapdf=mapdf, plot=g,
                 counts=sort(table(as.character(mapdf$regime)), decreasing=TRUE)))
}
