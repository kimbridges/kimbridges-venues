## seasonality_cue_regimes.R
## The daylength (photoperiod) channel + the cue-regime classifier.
## Companion to seasonality_harness.R — read the spine in proj_seasonality.md.
##
## STATUS: v2 (2026-06-24). Graded, m-gated rainfall channel + explicit
## arid/reactive-rain regime. The v1 hard-aridity-gate (which erased the desert
## trio's rain signal and split the Mediterranean) is REPLACED. Open tunables are
## listed in NOTES at the bottom; the reliability/interannual axis is still deferred.
##
## Usage:
##   source("G:/My Drive/Projects/seasonality/seasonality_harness.R")
##   clim <- get_climate(cities); idx <- indices_table(clim)
##   idx  <- dplyr::left_join(idx, cities[,c("name","lat","lon")], by="name")
##   source("G:/My Drive/Projects/seasonality/seasonality_cue_regimes.R")
##   idx  <- add_daylength(idx)
##   idx  <- classify_v2(idx)
##   plot_regime_map(idx)

## ---- daylength (photoperiod) channel: a pure function of latitude ----
## daylamp = half the annual range of daylength (hours); ~0 at the equator,
## growing monotonically poleward (Fairbanks ~8.9 h). The spine's "universal
## metronome": free, perfectly reliable, available only where it has amplitude.
## Diverges from temperature where the ocean damps the thermal swing (maritime
## high-lat: London/Bergen have big daylamp but only moderate Tamp).
midmonth_doy <- c(15,46,74,105,135,166,196,227,258,288,319,349)

daylength_hours <- function(lat_deg, doy){
  phi  <- lat_deg*pi/180
  decl <- 23.45*pi/180 * sin(2*pi*(284+doy)/365)   # solar declination (rad)
  x    <- pmin(pmax(-tan(phi)*tan(decl), -1), 1)    # clamp -> polar day/night
  24*acos(x)/pi                                      # hours of daylight (0..24)
}
daylength_channel <- function(lat){
  dl <- sapply(midmonth_doy, function(d) daylength_hours(lat, d))
  list(daylamp = (max(dl)-min(dl))/2, peak_month = which.max(dl))
}
add_daylength <- function(d){
  dlc <- lapply(d$lat, daylength_channel)
  d$daylamp    <- sapply(dlc, `[[`, "daylamp")
  d$dl_peakmon <- sapply(dlc, `[[`, "peak_month")
  d
}

## ---- v2 graded rainfall channel, gated on WATER BALANCE m = mean(P - 2T) ----
## Key fix vs v1: aridity = rainfall relative to evaporative demand (m), NOT raw
## total. m<0 = water-limited (rain is REACTIVE, a trigger); m>=0 = water-sufficient
## (rain can be PREDICTIVE). This restores the SW desert trio to a rain regime,
## quarantines hyper-arid Cairo, and keeps cold-dry continental (Ulaanbaatar/
## Fairbanks, low total but m>0) out of the desert class.
RAIN_SI_PRED  <- 0.40   # predictive rain needs clear seasonality
RAIN_SI_REACT <- 0.30   # reactive (arid): lower bar; rain is the operative trigger
ARID_TOTAL    <- 80     # mm; m<0 & below this = hyper-arid (rain negligible)
TEMP_STRONG <- 8.0; TEMP_MOD <- 4.0
DAY_STRONG  <- 3.0; DAY_MOD  <- 1.5
TROPIC_LAT  <- 25       # |lat|<=25: cool_frac inverts -> treat as "tropical"
WINTER_RAIN <- 0.60     # cool_frac: winter-rain (extratropics only)

rain_mode <- function(m, totP, SI){
  if(m < 0 && totP < ARID_TOTAL) "hyper-arid"
  else if(m < 0 && SI >= RAIN_SI_REACT) "reactive"
  else if(m >= 0 && SI >= RAIN_SI_PRED) "predictive"
  else "aseasonal"
}

classify_v2 <- function(d){
  reg<-phz<-rmd<-character(nrow(d))
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
        } else "—"
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

## ---- the regime map (three channels in one view) ----
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

plot_regime_map <- function(d, file="G:/My Drive/Projects/seasonality/cue_regime_map_v2.png"){
  d$regime <- factor(d$regime, levels=names(REGIME_PAL))
  g <- ggplot2::ggplot(d, ggplot2::aes(Tamp, SI)) +
    ggplot2::geom_hline(yintercept=0.40, linetype="dotted", color="gray70") +
    ggplot2::geom_point(ggplot2::aes(fill=regime, size=daylamp), shape=21, color="gray20", stroke=0.5) +
    ggrepel::geom_text_repel(ggplot2::aes(label=name), size=3, max.overlaps=20, seg.color="gray75") +
    ggplot2::scale_fill_manual(values=REGIME_PAL, name="cue regime (v2)") +
    ggplot2::scale_size_area(max_size=11, name="daylength channel\ndaylamp (h)") +
    ggplot2::labs(x="temperature channel — Tamp (deg C, half-range)",
                  y="rainfall channel — SI (seasonality index)",
                  title="Cue-regime map (v2): three channels in one view",
                  subtitle="x = temperature | y = rainfall | bubble = daylength | colour = regime") +
    ggplot2::theme_minimal(base_size=12)
  ggplot2::ggsave(file, g, width=11.5, height=7.4, dpi=120); message("saved ", file); g
}

## ============================ NOTES — v2 status =============================
## FIXED vs v1 (all verified on the 21-site set, 2026-06-24):
##  - Desert trio reunited under "reactive-rain (arid desert)" (Las Vegas/El Paso/
##    Tucson), with phase the within-regime distinction (Mojave winter / Chihuahuan
##    summer / Sonoran bimodal) — the validation anchor holds.
##  - Mediterranean unified: Los Angeles + Rome both "winter-rain (Mediterranean)"
##    (detected from cool-season phase, not gated on SI — fixes the v1 Rome split).
##  - Cairo quarantined as "hyper-arid (cue-poor)"; Ulaanbaatar/Fairbanks correctly
##    "thermal + summer-rain (reinforced)" (m>0 keeps them out of the desert class).
##  - "daylength-cued (maritime)" (London, Bergen) stands on its own — the new channel.
##
## STILL TUNABLE (small):
##  1. Phase thresholds: Las Vegas (cool_frac 0.58) reads "mixed" though Mojave is
##     winter-rain — the 0.60 winter cut is a hair high; consider ~0.55.
##  2. Mediterranean sites get phase "—" (phase only computed for reactive/predictive
##     rain_mode; Rome's SI<0.40 -> aseasonal). Compute a phase label for Mediterranean too.
##  3. Manaus (SI 0.438, just over the predictive floor) reads tropical wet-dry though
##     it's near-everwet — borderline; fine for now.
##  4. Bimodality (Nairobi, Tucson/Sonoran) is captured in `phase` but not as its own
##     regime; revisit if a double-rain regime is wanted.
##
## DEFERRED (the second axis): a reliability/interannual weighting of each cue —
## needs year-by-year data (CRU TS / ERA5 / CHELSA), beyond WorldClim's climatology.
## ==========================================================================
