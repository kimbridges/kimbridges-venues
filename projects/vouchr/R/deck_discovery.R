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
# The Discover pillar's packages (rgbif, ggplot2, dplyr, scales) are in Suggests;
# each entry point checks for them at call time.
# -----------------------------------------------------------------------------

#' Primary collector surname from a messy recordedBy string
#'
#' Extract the first collector's surname from a Darwin Core `recordedBy` string,
#' dropping parentheticals (e.g. ORCIDs) and any co-collectors.
#'
#' @param s A single `recordedBy` string.
#' @return The primary collector surname, or `NA`.
#' @examples
#' first_collector("Wood, K.R.")
#' first_collector("K. R. Wood, J. Lau & M. Wood")
#' @export
first_collector <- function(s) {
  if (is.na(s) || !nzchar(trimws(s))) return(NA_character_)
  s <- sub("\\s*\\(.*?\\)", "", s)                 # drop (ORCID ...)
  s <- trimws(sub("([;&|]| and ).*$", "", s))      # first collector only
  before <- trimws(sub(",.*$", "", s))
  if (!grepl("\\s", before) && nchar(before) > 1) return(before)   # "Wood, K.R." -> Wood
  sub("^.*\\s", "", trimws(sub(",.*$", "", s)))     # else last word = surname
}

.nz <- function(x) !is.na(x) & nzchar(trimws(as.character(x)))

#' Per-record signature features
#'
#' Compute a per-record feature frame: presence of key Darwin Core fields plus a
#' few content flags (substrate, ecological content, taxonomic content) derived
#' from the free-text fields.
#'
#' @param d A data frame of Darwin Core records (e.g. from [fetch_records()]).
#' @return A logical data frame with one row per input record and one column per
#'   signature feature.
#' @export
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

#' Pull PreservedSpecimen records for a taxon (paged)
#'
#' Fetch all GBIF PreservedSpecimen records for a taxon within a country and year
#' range, paging through the API. Requires `rgbif`.
#'
#' @param taxonKey GBIF taxon key.
#' @param country Two-letter country code.
#' @param years Year range as a GBIF string, e.g. `"1985,2026"`.
#' @return A data frame of records (all Darwin Core fields).
#' @export
fetch_records <- function(taxonKey, country = "US", years = "1985,2026") {
  if (!requireNamespace("rgbif", quietly = TRUE) ||
      !requireNamespace("dplyr", quietly = TRUE))
    stop("fetch_records() needs the 'rgbif' and 'dplyr' packages.")
  n <- rgbif::occ_search(taxonKey = taxonKey, basisOfRecord = "PRESERVED_SPECIMEN",
                  country = country, year = years, limit = 0)$meta$count
  message(sprintf("  pulling %d records...", n))
  pages <- lapply(seq(0, max(0, n - 1), by = 500), function(s)
    rgbif::occ_search(taxonKey = taxonKey, basisOfRecord = "PRESERVED_SPECIMEN",
               country = country, year = years, limit = 500, start = s, fields = "all")$data)
  dplyr::bind_rows(pages)
}

#' Signature heatmap of collectors by feature
#'
#' Build a faceted heatmap of collector field-signatures, grouped by cluster.
#' Clusters are labelled generically ("Cluster 1" ...) -- naming the archetypes
#' is the analyst's job. Requires `ggplot2` (and `scales`).
#'
#' @param Mm Numeric matrix of collector (rows) by feature (cols) occupancy.
#' @param cl Named integer cluster assignment per collector.
#' @param counts Named record counts per collector.
#' @param label Optional taxon/scope label for the title.
#' @return A `ggplot` object.
#' @export
signature_heatmap <- function(Mm, cl, counts, label = "") {
  if (!requireNamespace("ggplot2", quietly = TRUE))
    stop("signature_heatmap() needs the 'ggplot2' package.")
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
  ggplot2::ggplot(long, ggplot2::aes(feature, lab, fill = frac)) +
    ggplot2::geom_tile(color = "white", linewidth = 0.4) +
    ggplot2::geom_text(ggplot2::aes(label = round(frac * 100), color = txt), size = 2.4) +
    ggplot2::facet_grid(cluster ~ ., scales = "free_y", space = "free_y") +
    ggplot2::scale_fill_gradient(low = "#f7fcf5", high = "#00441b",
                                 labels = scales::percent, name = "% of records") +
    ggplot2::scale_color_identity() + ggplot2::scale_x_discrete(position = "top") +
    ggplot2::labs(title = paste0("Collector signatures -> deck archetypes",
                        if (nzchar(label)) paste0(" -- ", label) else ""),
         x = NULL, y = NULL,
         caption = "Cell = % of that collector's specimens carrying the field.  Ward.D2 clustering.") +
    ggplot2::theme_minimal(base_size = 10) +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 40, hjust = 0),
          strip.text.y = ggplot2::element_text(angle = 0, face = "bold"),
          panel.grid = ggplot2::element_blank(),
          plot.title = ggplot2::element_text(face = "bold"))
}

#' Discover deck archetypes for a collector community
#'
#' Run the deck-discovery method end to end: scope a Darwin Core pull (or accept
#' a supplied data frame), consolidate collectors, compute each one's field
#' signature, cluster them, and read the clusters as candidate discipline "deck
#' profiles". Fields empty across all clusters are cross-cutting decks.
#'
#' @param taxonKey GBIF taxon key (used when `data` is `NULL`).
#' @param data Optional pre-pulled Darwin Core data frame; skips the GBIF fetch.
#' @param country Two-letter country code for the fetch.
#' @param years Year range as a GBIF string, e.g. `"1985,2026"`.
#' @param min_records Minimum specimens for a collector to be included.
#' @param k Number of clusters.
#' @param plot Logical; attach the signature heatmap (needs `ggplot2`).
#' @param label Optional scope label for the plot title.
#' @return A list with `data`, `n`, `signatures`, `clusters`, `counts`,
#'   `profiles` (per-cluster members + defining fields), `hc`, and, if requested, `plot`.
#' @export
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
