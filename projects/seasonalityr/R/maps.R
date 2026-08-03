## Plots: the channel scatter, the regime scatter, and regional regime maps.

#' Temperature-vs-rainfall channel scatter
#'
#' @param idx An indices table from [indices_table()].
#' @param file Optional path to save a PNG; if `NULL`, the plot is only returned.
#' @return A ggplot object (invisibly saved if `file` is given).
#' @import ggplot2
#' @importFrom ggrepel geom_text_repel
#' @export
plot_channel <- function(idx, file = NULL) {
  g <- ggplot(idx, aes(Tamp, SI)) +
    geom_hline(yintercept = SI_FLOOR, linetype = "dotted", color = "gray60") +
    geom_point(aes(fill = cool_frac, size = totP), shape = 21, color = "black") +
    ggrepel::geom_text_repel(aes(label = name), size = 3, max.overlaps = 20) +
    scale_fill_gradient2(low = "#D55E00", mid = "#EEEEEE", high = "#0072B2",
                         midpoint = 0.5, limits = c(0, 1), name = "cool-season rain") +
    scale_size_area(max_size = 11, name = "annual rain (mm)") +
    labs(x = "temperature seasonality (deg C)", y = "rainfall seasonality (SI)") +
    theme_minimal()
  if (!is.null(file)) ggsave(file, g, width = 9.5, height = 6.8, dpi = 110)
  g
}

#' Cue-regime scatter: three channels in one view
#'
#' @param d A classified indices table (output of [classify_v2()]).
#' @param file Optional path to save a PNG.
#' @return A ggplot object.
#' @import ggplot2
#' @importFrom ggrepel geom_text_repel
#' @export
plot_regime_map <- function(d, file = NULL){
  d$regime <- factor(d$regime, levels = names(REGIME_PAL))
  g <- ggplot(d, aes(Tamp, SI)) +
    geom_hline(yintercept = 0.40, linetype = "dotted", color = "gray70") +
    geom_point(aes(fill = regime, size = daylamp), shape = 21, color = "gray20", stroke = 0.5) +
    ggrepel::geom_text_repel(aes(label = name), size = 3, max.overlaps = 20, seg.color = "gray75") +
    scale_fill_manual(values = REGIME_PAL, name = "cue regime") +
    scale_size_area(max_size = 11, name = "daylength (h)") +
    labs(x = "temperature channel - Tamp (deg C)", y = "rainfall channel - SI") +
    theme_minimal()
  if (!is.null(file)) ggsave(file, g, width = 11.5, height = 7.4, dpi = 120)
  g
}

#' Per-cell cue-regime grid for a geographic extent
#'
#' Crops cached WorldClim to the extent, computes the indices and daylength per
#' land cell, and classifies each cell with the v2 rules.
#'
#' @param xmin,xmax,ymin,ymax Extent in degrees longitude/latitude.
#' @param res WorldClim resolution in arc-minutes (default 10).
#' @param path Cache directory for the rasters.
#' @return A data frame with `x`, `y`, `regime`.
#' @export
compute_regime_grid <- function(xmin, xmax, ymin, ymax, res = 10,
                                 path = file.path(tempdir(), "wc_cache")){
  tavg <- geodata::worldclim_global("tavg", res = res, path = path)
  prec <- geodata::worldclim_global("prec", res = res, path = path)
  reg  <- terra::ext(xmin,xmax,ymin,ymax)
  Tr <- terra::crop(tavg,reg); Pr <- terra::crop(prec,reg)
  Tm <- terra::values(Tr); Pm <- terra::values(Pr); xy <- terra::crds(Tr, na.rm=FALSE)
  ok <- stats::complete.cases(Tm) & stats::complete.cases(Pm)
  Tm <- Tm[ok,,drop=FALSE]; Pm <- Pm[ok,,drop=FALSE]; lon <- xy[ok,1]; lat <- xy[ok,2]

  totP <- rowSums(Pm); totP[totP==0] <- 1e-6
  SI   <- rowSums(abs(Pm - totP/12))/totP
  Tamp <- (apply(Tm,1,max) - apply(Tm,1,min))/2
  m_mean <- rowMeans(Pm - 2*Tm)
  thr6 <- apply(Tm,1,function(v) sort(v)[6])
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

#' Compute and render a regional cue-regime map
#'
#' @param xmin,xmax,ymin,ymax Extent in degrees.
#' @param title Plot title.
#' @param file Path to save the PNG.
#' @param anchors Optional data frame of labelled sites (`name`, `lat`, `lon`).
#' @param res,path Passed to [compute_regime_grid()].
#' @param width,height PNG size in inches.
#' @return Invisibly, a list with `mapdf`, `plot`, and regime `counts`.
#' @import ggplot2
#' @importFrom ggrepel geom_text_repel
#' @export
regime_map_region <- function(xmin, xmax, ymin, ymax, title, file, anchors = NULL,
                              res = 10, path = file.path(tempdir(), "wc_cache"),
                              width = 10, height = 10){
  mapdf <- compute_regime_grid(xmin,xmax,ymin,ymax, res=res, path=path)
  mapdf$regime <- factor(mapdf$regime, levels = names(REGIME_PAL))
  g <- ggplot(mapdf, aes(x,y,fill=regime)) + geom_raster() +
    scale_fill_manual(values = REGIME_PAL, name = "cue regime", drop = FALSE) +
    coord_quickmap(expand = FALSE) +
    labs(x = NULL, y = NULL, title = title,
         subtitle = "Per-cell cue regime from temperature + rainfall + daylength | WorldClim") +
    theme_minimal(base_size = 12) + theme(panel.grid = element_blank())
  if (!is.null(anchors)){
    g <- g +
      geom_point(data = anchors, aes(lon,lat), inherit.aes = FALSE, shape = 21,
                 fill = "white", color = "black", size = 2.2, stroke = 0.7) +
      ggrepel::geom_text_repel(data = anchors, aes(lon,lat,label=name), inherit.aes = FALSE,
                 size = 3.2, fontface = "bold", box.padding = 0.5, seg.color = "black",
                 max.overlaps = 40)
  }
  ggsave(file, g, width = width, height = height, dpi = 130)
  invisible(list(mapdf = mapdf, plot = g,
                 counts = sort(table(as.character(mapdf$regime)), decreasing = TRUE)))
}
