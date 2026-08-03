# time_tools.R -- Time & phenology lenses for herbarium checklists
# Companion to collector_tools.R (checklists project). Built live 2026-07-16.
#
# Two lenses over DATED preserved-specimen records, both built to be HONEST about
# the core caveat of opportunistic herbarium data: a specimen's date/month records
# WHEN A COLLECTOR VISITED, not when a plant flowered or first arrived.
#
#   specimen_phenology(df, group=, min_records=)  collection-month distributions +
#        a collecting-calendar confound diagnostic (circular concentration, per-taxon
#        campaign_dominance). At a thin/ campaign-driven site it correctly reports
#        that phenology is NOT extractable and shows the collecting calendar instead.
#   specimen_recency(df, checklist=, ref_year=)   per-taxon first/last year, span,
#        years_since_last; joins native/alien status so first-DETECTION (not arrival)
#        curves and 'not seen recently' taxa can be read by origin.
#   plot_phenology(), plot_arrival_curve(), plot_recency_segments()  the figures.
#
# Deps: dplyr, tidyr, ggplot2. Circular stats inline (no 'circular' dependency).

suppressMessages({library(dplyr); library(tidyr); library(ggplot2)})

## ---- circular helpers (months as angles) ---------------------------------
.month_angle <- function(m) 2*pi*(m - 0.5)/12
.circ_stats <- function(months) {
  months <- months[!is.na(months)]; n <- length(months)
  if (n == 0) return(list(n=0, mean_month=NA_real_, r=NA_real_))
  a <- .month_angle(months); C <- mean(cos(a)); S <- mean(sin(a))
  r <- sqrt(C^2 + S^2)                        # resultant length 0=spread..1=one month
  mm <- ((atan2(S, C)/(2*pi))*12) %% 12; mm <- ifelse(mm==0, 12, mm)
  list(n=n, mean_month=mm, r=r)
}
.month_name <- function(m) {
  if (length(m) != 1) return(vapply(m, .month_name, character(1)))
  if (is.na(m)) return(NA_character_)
  c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")[((round(m)-1) %% 12) + 1]
}
.MLEV <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")

## ---- 1. PHENOLOGY ---------------------------------------------------------
specimen_phenology <- function(df, species_col="species", month_col="month",
                               year_col="year", group=NULL, min_records=5) {
  d <- df
  d$.sp  <- d[[species_col]]
  d$.mon <- suppressWarnings(as.integer(d[[month_col]]))
  d$.yr  <- suppressWarnings(as.integer(d[[year_col]]))
  d$.grp <- if (!is.null(group) && group %in% names(df)) df[[group]] else NA
  d <- d[!is.na(d$.mon) & d$.mon>=1 & d$.mon<=12, , drop=FALSE]

  monthly <- as.data.frame(table(month=factor(d$.mon, levels=1:12)))
  names(monthly) <- c("month","n"); monthly$month <- as.integer(as.character(monthly$month))
  monthly_grp <- NULL
  if (!all(is.na(d$.grp))) {
    monthly_grp <- as.data.frame(table(month=factor(d$.mon,levels=1:12), group=d$.grp))
    names(monthly_grp)[names(monthly_grp)=="Freq"] <- "n"
    monthly_grp$month <- as.integer(as.character(monthly_grp$month))
  }
  cal <- .circ_stats(d$.mon)
  taxa <- d %>% filter(!is.na(.sp)) %>% count(.sp, name="n_rec")
  keep <- taxa$.sp[taxa$n_rec >= min_records]
  by_taxon <- lapply(keep, function(s) {
    sub <- d[d$.sp==s & !is.na(d$.sp), ]; cs <- .circ_stats(sub$.mon)
    yrs <- sub$.yr[!is.na(sub$.yr)]
    tdom <- if (length(yrs)) max(table(yrs))/length(yrs) else NA_real_
    data.frame(species=s, n_rec=cs$n, mean_month=round(cs$mean_month,1),
               peak=.month_name(cs$mean_month), concentration=round(cs$r,2),
               campaign_dominance=round(tdom,2))
  })
  by_taxon <- if (length(by_taxon)) bind_rows(by_taxon) %>% arrange(desc(concentration)) else data.frame()
  diagnostics <- list(n_dated=nrow(d), n_taxa_dated=nrow(taxa),
                      singleton_frac=mean(taxa$n_rec==1), n_analyzable=length(keep),
                      calendar_concentration=cal$r, calendar_peak=.month_name(cal$mean_month))
  structure(list(monthly=monthly, monthly_grp=monthly_grp, by_taxon=by_taxon,
                 diagnostics=diagnostics), class="specimen_phenology")
}
print.specimen_phenology <- function(x, ...) {
  d <- x$diagnostics
  cat("Specimen phenology (collection-month) lens\n")
  cat(sprintf("  dated records: %d across %d taxa\n", d$n_dated, d$n_taxa_dated))
  cat(sprintf("  singletons: %.0f%%  |  taxa analyzable (>= min_records): %d\n",
              100*d$singleton_frac, d$n_analyzable))
  cat(sprintf("  collecting-calendar concentration r=%.2f (peak %s)\n",
              d$calendar_concentration, d$calendar_peak))
  cat("  NOTE: aggregate months track WHEN COLLECTORS VISITED, not flowering.\n")
  invisible(x)
}
plot_phenology <- function(ph, by_era=FALSE, title="The collecting calendar") {
  if (by_era && !is.null(ph$monthly_grp)) {
    g <- ph$monthly_grp; g$mlab <- factor(.month_name(g$month), levels=.MLEV)
    p <- ggplot(g, aes(mlab, n, fill=group)) + geom_col(width=1, colour="white") +
      scale_fill_brewer(palette="Set1", name=NULL)
  } else {
    mm <- ph$monthly; mm$mlab <- factor(.month_name(mm$month), levels=.MLEV)
    p <- ggplot(mm, aes(mlab, n)) + geom_col(width=1, fill="#2c7fb8", colour="white")
  }
  p + coord_polar(start=0) +
    labs(title=title, subtitle="Herbarium collection months -- a calendar of visits, not of flowering",
         x=NULL, y="specimens") +
    theme_minimal(base_size=12) +
    theme(axis.text.x=element_text(face="bold"), panel.grid.minor=element_blank(),
          legend.position="bottom")
}

## ---- 2. RECENCY / TURNOVER ------------------------------------------------
specimen_recency <- function(df, checklist=NULL, species_col="species",
                             year_col="year", status_col="wagner_status", ref_year=NULL) {
  d <- df
  d$.sp <- d[[species_col]]; d$.yr <- suppressWarnings(as.integer(d[[year_col]]))
  d <- d[!is.na(d$.sp) & !is.na(d$.yr), , drop=FALSE]
  if (is.null(ref_year)) ref_year <- max(d$.yr, na.rm=TRUE)
  rec <- d %>% group_by(species=.sp) %>%
    summarise(n_records=n(), first_year=min(.yr), last_year=max(.yr),
              span_years=max(.yr)-min(.yr), n_years=n_distinct(.yr), .groups="drop") %>%
    mutate(years_since_last = ref_year - last_year)
  if (!is.null(checklist)) {
    key <- if ("accepted_name" %in% names(checklist)) "accepted_name" else species_col
    st <- as.data.frame(checklist)[, c(key, status_col)]; names(st) <- c("species","status")
    rec <- left_join(rec, st, by="species")
    rec$native <- dplyr::recode(rec$status, E="native", I="native",
                                Nat="alien", Cult="cultivated", `?`="uncertain",
                                .default=NA_character_)
  }
  attr(rec, "ref_year") <- ref_year
  rec %>% arrange(first_year)
}
# cumulative first-DETECTION curve by origin. NOTE: first detection != arrival;
# the shape reflects collector intent (which taxa were sought when), not biology.
plot_arrival_curve <- function(rec, classes=c("native","alien"), title=NULL) {
  if (!"native" %in% names(rec)) stop("run specimen_recency() with a status checklist")
  a <- rec %>% filter(native %in% classes) %>% arrange(first_year) %>%
    group_by(native) %>% mutate(cum_taxa = row_number()) %>% ungroup()
  cols <- c(native="#1b9e77", alien="#d95f02", cultivated="#7570b3", uncertain="grey60")
  ggplot(a, aes(first_year, cum_taxa, colour=native)) +
    geom_step(linewidth=1.1) + scale_colour_manual(values=cols, name=NULL) +
    labs(title=title %||% "First detection of each taxon over time",
         subtitle="Cumulative taxa by year first collected (detection, not arrival)",
         x="year first collected", y="cumulative taxa") +
    theme_minimal(base_size=13) + theme(panel.grid.minor=element_blank())
}
`%||%` <- function(a,b) if (is.null(a)) b else a
# collection-span segments: one row per taxon, first_year..last_year, coloured by origin.
plot_recency_segments <- function(rec, classes=c("native","alien","cultivated"), title=NULL) {
  a <- rec %>% filter(native %in% classes) %>% arrange(first_year) %>%
    mutate(rank=row_number())
  cols <- c(native="#1b9e77", alien="#d95f02", cultivated="#7570b3", uncertain="grey60")
  ggplot(a, aes(y=rank, colour=native)) +
    geom_segment(aes(x=first_year, xend=last_year, yend=rank), linewidth=0.5) +
    geom_point(aes(x=first_year), size=0.7) + geom_point(aes(x=last_year), size=0.7) +
    scale_colour_manual(values=cols, name=NULL) +
    labs(title=title %||% "Collection span of each taxon (first to last record)",
         subtitle="Single points = taxa collected only once (the singleton wall)",
         x="year", y="taxa (ordered by first record)") +
    theme_minimal(base_size=12) +
    theme(axis.text.y=element_blank(), panel.grid.minor=element_blank())
}

## ---- worked example (Kipuka Puaulu) ---------------------------------------
# library(checklistr)
# raw <- fetch_specimens_gbif(-155.296, 19.437, 2, "Tracheophyta", "phylum", "Plantae")
# sp  <- dedup_specimens(raw, level="institution")
# gen <- readr::read_csv("kipuka_puaulu/kipuka_puaulu_checklist_generated.csv")
# sp$era <- ifelse(sp$year %in% c(1979,1980), "1979-80 survey", "other years")
# ph  <- specimen_phenology(sp, group="era"); print(ph); plot_phenology(ph, by_era=TRUE)
# rec <- specimen_recency(sp, checklist=gen, ref_year=2026)
# plot_arrival_curve(rec); plot_recency_segments(rec)

