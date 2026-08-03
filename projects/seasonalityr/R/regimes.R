## The cue-regime classifier (v2): a water-balance-gated, stated-rule typology.

## Thresholds (internal; documented in the seasonality document).
RAIN_SI_PRED  <- 0.40   # predictive rain needs clear seasonality
RAIN_SI_REACT <- 0.30   # reactive (arid): lower bar; rain is the operative trigger
ARID_TOTAL    <- 80     # mm/yr; with m<0, below this = hyper-arid (rain negligible)
TEMP_STRONG   <- 8.0    # deg C half-range
TEMP_MOD      <- 4.0
DAY_STRONG    <- 3.0    # hours half-amplitude
DAY_MOD       <- 1.5
TROPIC_LAT    <- 25     # |lat| <= 25: cool_frac inverts -> treat as "tropical"
WINTER_RAIN   <- 0.60   # cool_frac threshold for winter-rain (extratropics)

## CVD-safe colour for each regime (Okabe-Ito based).
REGIME_PAL <- c(
  "cue-poor (aseasonal/everwet)"        = "#999999",
  "hyper-arid (cue-poor)"               = "#000000",
  "rainfall-cued (tropical wet-dry)"    = "#0072B2",
  "rainfall-cued (extratropical)"       = "#44AA99",
  "reactive-rain (arid desert)"         = "#D55E00",
  "reactive-rain (arid tropical/Sahel)" = "#E69F00",
  "winter-rain (Mediterranean)"         = "#CC79A7",
  "thermal + summer-rain (reinforced)"  = "#009E73",
  "temperature-cued (continental)"      = "#56B4E9",
  "daylength-cued (maritime)"           = "#F0E442",
  "mixed/other"                         = "#DDDDDD")

## Rainfall mode from water balance m, total, and seasonality (internal).
rain_mode <- function(m, totP, SI){
  if(m < 0 && totP < ARID_TOTAL) "hyper-arid"
  else if(m < 0 && SI >= RAIN_SI_REACT) "reactive"
  else if(m >= 0 && SI >= RAIN_SI_PRED) "predictive"
  else "aseasonal"
}

#' Classify sites into cue regimes
#'
#' The v2 classifier: aridity is gated on the water balance `m = mean(P - 2T)`
#' (not raw rainfall total), so hot deserts read as reactive-rain while cold-dry
#' continental sites do not. Returns the input with `rain_mode`, `phase`, and
#' `regime` columns added.
#'
#' @param d A data frame of indices with columns `m_mean`, `totP`, `SI`, `Tamp`,
#'   `daylamp`, `cool_frac`, `bimod`, `lat` (see [compute_indices()],
#'   [add_daylength()]).
#' @return `d` with `rain_mode`, `phase`, and `regime` columns added.
#' @export
classify_v2 <- function(d){
  reg <- phz <- rmd <- character(nrow(d))
  for(i in seq_len(nrow(d))){
    m<-d$m_mean[i]; tot<-d$totP[i]; SI<-d$SI[i]; Tamp<-d$Tamp[i]; dal<-d$daylamp[i]
    cf<-d$cool_frac[i]; bim<-d$bimod[i]; trop<-abs(d$lat[i])<=TROPIC_LAT
    rm<-rain_mode(m,tot,SI); rmd[i]<-rm
    tl<-if(Tamp>=TEMP_STRONG)"strong" else if(Tamp>=TEMP_MOD)"mod" else "weak"
    dl<-if(dal>=DAY_STRONG)"strong" else if(dal>=DAY_MOD)"mod" else "weak"
    ph<-if(rm %in% c("reactive","predictive")){
          if(bim>=0.9 && SI>=0.40) "bimodal"
          else if(trop) "tropical-wet"
          else if(cf>=WINTER_RAIN) "winter"
          else if(cf<=0.35) "summer" else "mixed"
        } else "none"
    phz[i]<-ph
    reg[i]<-
      if(rm=="hyper-arid") "hyper-arid (cue-poor)"
      else if(!trop && cf>=WINTER_RAIN && tl %in% c("mod","strong") && tot>=ARID_TOTAL && m> -15)
              "winter-rain (Mediterranean)"
      else if(rm=="reactive") (if(trop) "reactive-rain (arid tropical/Sahel)" else "reactive-rain (arid desert)")
      else if(rm=="predictive" && trop) "rainfall-cued (tropical wet-dry)"
      else if(rm=="predictive" && tl=="strong") "thermal + summer-rain (reinforced)"
      else if(rm=="predictive") "rainfall-cued (extratropical)"
      else if(rm=="aseasonal" && tl=="strong") "temperature-cued (continental)"
      else if(rm=="aseasonal" && tl=="mod" && dl=="strong") "daylength-cued (maritime)"
      else if(rm=="aseasonal" && tl=="weak" && dl=="weak") "cue-poor (aseasonal/everwet)"
      else paste0("mixed (rain:",rm," T:",tl," D:",dl,")")
  }
  d$rain_mode<-rmd; d$phase<-phz; d$regime<-reg; d
}

#' The cue-regime colour palette
#'
#' @return A named character vector of CVD-safe colours, one per regime.
#' @export
regime_palette <- function() REGIME_PAL
