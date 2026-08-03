# deck_discovery.R
# -----------------------------------------------------------------------------
# Discover the deck archetypes for a taxon / collector community from herbarium
# records. The DELIVERABLE IS THE METHOD; the decks are just its output for one
# taxon, region, and era.
#
# Method (Kim & Claude, 2026-07-01):
#   1. scope a Darwin Core pull (taxon / region / recent decades)
#   2. consolidate `recordedBy` to a primary collector
#   3. compute each collector's field-signature (occupancy + a few content flags)
#   4. cluster collectors  ->  clusters are candidate discipline "deck profiles"
#   5. fields empty across ALL clusters (e.g. phenology) = cross-cutting decks
#
# Usage:
#   source("deck_discovery.R")
#   res <- discover_decks(taxonKey = 3185258, country = "US", years = "1985,2026")
#   res$plot                # the signature heatmap
#   res$profiles            # per-cluster members + defining fields
#   # or pass an already-pulled data frame:  discover_decks(data = mydf)
# -----------------------------------------------------------------------------

suppressPackageStartupMessages({library(rgbif); library(ggplot2)})

# primary collector surname from a messy recordedBy string
first_collector <- function(s) {
  if (is.na(s) || !nzchar(trimws(s))) return(NA_character_)
  s <- sub("\\s*\\(.*?\\)", "", s)                 # drop (ORCID ...)
  s <- trimws(sub("([;&|]| and ).*$", "", s))      # first collector only
  before <- trimws(sub(",.*$", "", s))
  if (!grepl("\\s", before) && nchar(before) > 1) return(before)   # "Wood, K.R." -> Wood
  sub("^.*\\s", "", trimws(sub(",.*$", "", s)))     # else last word = surname
}

.nz <- function(x) !is.na(x) & nzchar(trimws(as.character(x)))

# per-record signature features: presence of key fields + a few content flags
signature_features <- function(d) {
  g <- function(c) if (c %in% names(d)) d[[c]] else rep(NA, nrow(d))
  hab_occ <- paste(g("habitat"), g("occurrenceRemarks"))
  rem_fn  <- paste(g("occurrenceRemarks"), g("fieldNotes"))
  data.frame(
    habitat       = .nz(g("habitat")),
    substrate     = grepl("soil|lava|pahoehoe|a`?a\\b|basalt|cinder|\\bash\\b|substrate|rocky|clay|sand", hab_occ, ignore.case = TRUE),
    associates    = .nz(g("associatedTaxa")) | grepl("associat|dominant|with [A-Z][a-z]+|communit", hab_occ, ignore.case = TRUE),
    # ecological CONTENT: community / cover / moisture / disturbance in the free text
    eco_content   = grepl("associat|dominant|codominant|communit|understor|canopy|\\bforest\\b|shrubland|grassland|\\bscrub\\b|\\bcover\\b|\\bopen\\b|\\bclosed\\b|mesic|\\bwet\\b|\\bdry\\b|\\bbog\\b|rain ?forest|disturb|graz|cut-?over|secondary|\\balien\\b|invasiv|\\bweed", hab_occ, ignore.case = TRUE),
    occ_remarks   = .nz(g("occurrenceRemarks")),
    # taxonomic CONTENT: floral parts / indument / variety / measurements
    tax_content   = grepl("stamen|petal|corolla|calyx|sepal|anther|\\bstyle\\b|pistil|filament|glabrous|pubescen|tomentos|villous|pilose|glaucous|\\bhairy\\b|\\bvar\\.|variety|\\bforma?\\b|\\bmorph|dbh|diam|[0-9] ?cm|[0-9] ?mm|[0-9](\\.[0-9])? ?m (tall|high)", rem_fn, ignore.case = TRUE),
    phenology     = .nz(g("reproductiveCondition")),
    vbt_elev      = .nz(g("verbatimElevation")),
    coord_uncert  = .nz(g("coordinateUncertaintyInMeters")),
    coll_number   = .nz(g("recordNumber")),
    identified_by = .nz(g("identifiedBy")),
    type_status   = .nz(g("typeStatus")))
}

# pull all PreservedSpecimen records for a taxon within scope (paged)
fetch_records <- function(taxonKey, country = "US", years = "1985,2026") {
  n <- occ_search(taxonKey = taxonKey, basisOfRecord = "PRESERVED_SPECIMEN",
                  country = country, year = years, limit = 0)$meta$count
  message(sprintf("  pulling %d records...", n))
  pages <- lapply(seq(0, max(0, n - 1), by = 500), function(s)
    occ_search(taxonKey = taxonKey, basisOfRecord = "PRESERVED_SPECIMEN",
               country = country, year = years, limit = 500, start = s, fields = "all")$data)
  dplyr::bind_rows(pages)
}

# faceted signature heatmap; clusters labelled generically (naming = the analyst's job)
signature_heatmap <- function(Mm, cl, counts, label = "") {
  cmean <- tapply(rowMeans(Mm), cl, mean)               # order clusters, richest first
  clab  <- setNames(paste("Cluster", rank(-cmean, ties.method = "first")), names(cmean))
  long <- data.frame(collector = rep(rownames(Mm), ncol(Mm)),
                     feature = factor(rep(colnames(Mm), each = nrow(Mm)), levels = colnames(Mm)),
                     frac = as.vector(Mm))
  long$cluster <- factor(clab[as.character(cl[long$collector])],
                         levels = paste("Cluster", seq_along(cmean)))
  long$n   <- as.integer(counts[long$collector])
  long$lab <- sprintf("%s (%d)", long$collector, long$n)
  ord <- unique(long[order(long$cluster, -long$n), c("lab", "cluster")])
  long$lab <- factor(long$lab, levels = rev(ord$lab))
  long$txt <- ifelse(long$frac > 0.55, "white", "grey30")
  ggplot(long, aes(feature, lab, fill = frac)) +
    geom_tile(color = "white", linewidth = 0.4) +
    geom_text(aes(label = round(frac * 100), color = txt), size = 2.4) +
    facet_grid(cluster ~ ., scales = "free_y", space = "free_y") +
    scale_fill_gradient(low = "#f7fcf5", high = "#00441b", labels = scales::percent, name = "% of records") +
    scale_color_identity() + scale_x_discrete(position = "top") +
    labs(title = paste0("Collector signatures → deck archetypes",
                        if (nzchar(label)) paste0(" — ", label) else ""),
         x = NULL, y = NULL,
         caption = "Cell = % of that collector's specimens carrying the field.  Ward.D2 clustering.") +
    theme_minimal(base_size = 10) +
    theme(axis.text.x = element_text(angle = 40, hjust = 0),
          strip.text.y = element_text(angle = 0, face = "bold"),
          panel.grid = element_blank(), plot.title = element_text(face = "bold"))
}

# main entry point
discover_decks <- function(taxonKey = NULL, data = NULL, country = "US",
                           years = "1985,2026", min_records = 10, k = 4,
                           plot = TRUE, label = "") {
  d <- if (is.null(data)) fetch_records(taxonKey, country, years) else data
  d$coll_key <- tolower(vapply(as.character(d$recordedBy), first_collector, character(1)))
  counts <- sort(table(d$coll_key), decreasing = TRUE)
  big <- names(counts)[counts >= min_records]
  if (length(big) < k) stop("Fewer qualifying collectors than clusters; lower k or min_records.")
  feat <- signature_features(d); feat$coll <- d$coll_key
  fb <- feat[feat$coll %in% big, ]
  M  <- aggregate(fb[, setdiff(names(fb), "coll")], list(coll = fb$coll), mean)
  rownames(M) <- M$coll; Mm <- as.matrix(M[, -1])
  hc <- hclust(dist(Mm), "ward.D2"); cl <- cutree(hc, k)
  # candidate deck profile per cluster: fields whose cluster-mean clears the global mean and 50%
  gm <- colMeans(Mm)
  profiles <- lapply(sort(unique(cl)), function(g) {
    cm <- colMeans(Mm[cl == g, , drop = FALSE])
    list(members = names(cl)[cl == g],
         defining_fields = names(sort(cm[cm > pmax(gm, 0.5)], decreasing = TRUE)))
  })
  res <- list(data = d, n = nrow(d), signatures = Mm, clusters = cl,
              counts = counts[big], profiles = profiles, hc = hc)
  if (plot) res$plot <- signature_heatmap(Mm, cl, counts, label)
  res
}
