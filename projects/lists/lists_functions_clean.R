## lists — cleaned, generalised functions (rebuilt 2026-06-15; verified live on the fish-market toy)
##
## Changes from the 2022 lists_functions.R:
##  - generalised past the hard-coded spp1..spp5 (now works for any number of items per site)
##  - whitespace stripped once, at read time (no more leading-space item names)
##  - one dendrogram function for items OR sites, with distance + linkage as explicit arguments
##    (the "linkage chapter" varies these; defaults are binary distance + average/UPGMA linkage)
##  - plot caption passed in (no global `data_source` dependency)
##  - terminology generalised to "item" (vs the 2022 "species"); OPEN: confirm item vs species
##
## Requires: tidyverse, ggdendro.  dendro_theme() is included here.

dendro_theme <- function() {
  ggplot2::theme(
    axis.title.y = ggplot2::element_blank(),
    axis.text.y  = ggplot2::element_blank(),
    axis.ticks.y = ggplot2::element_blank(),
    panel.grid.major.y = ggplot2::element_blank(),
    panel.grid.minor.y = ggplot2::element_blank(),
    panel.grid.major.x = ggplot2::element_line(linewidth = .3, color = "gray75"),
    panel.grid.minor.x = ggplot2::element_line(linewidth = .3, color = "gray75"),
    panel.background   = ggplot2::element_rect(fill = "lightsteelblue1", color = "black"))
}

## read the ragged "Site, item, item, ..." text into a wide Site + item1..N frame
read_lists <- function(data_rows) {
  d <- utils::read.table(header = FALSE, sep = ",", fill = TRUE,
                         stringsAsFactors = FALSE, text = data_rows)
  d[] <- lapply(d, trimws)                                    # strip whitespace everywhere
  colnames(d) <- c("Site", paste0("item", seq_len(ncol(d) - 1)))
  d
}

## wide -> tidy long (one row per item-in-a-site); drops the empty ragged cells
to_long <- function(data) {
  data |>
    tidyr::pivot_longer(cols = -Site, values_to = "Item") |>
    dplyr::filter(Item != "")
}

## the distinct items seen, sorted (a confirmation table)
item_list <- function(data) to_long(data) |> dplyr::distinct(Item) |> dplyr::arrange(Item)

## tidy long -> wide binary two-way table (items as rows, sites as columns)
data_to_2way <- function(data) {
  to_long(data) |>
    dplyr::mutate(present = 1) |>
    dplyr::select(Site, Item, present) |>
    tidyr::pivot_wider(names_from = Site, values_from = present, values_fill = 0) |>
    dplyr::arrange(Item)
}

## a quick frequency scan: how many sites carry each item
item_freq_plot <- function(data, caption = NULL) {
  to_long(data) |> dplyr::count(Item) |>
    ggplot2::ggplot(ggplot2::aes(x = stats::reorder(Item, n), y = n)) +
    ggplot2::geom_col(fill = "darkgoldenrod2", color = "black") +
    ggplot2::coord_flip() +
    ggplot2::labs(x = "item", y = "number of sites", caption = caption) +
    ggplot2::theme(panel.background = ggplot2::element_rect(fill = "lightblue", color = "black"))
}

## a quick frequency scan: how many items each site holds
site_freq_plot <- function(data, caption = NULL) {
  to_long(data) |> dplyr::count(Site) |>
    ggplot2::ggplot(ggplot2::aes(x = stats::reorder(Site, n), y = n)) +
    ggplot2::geom_col(fill = "darkgoldenrod2", color = "black") +
    ggplot2::coord_flip() +
    ggplot2::labs(x = "site", y = "number of items", caption = caption) +
    ggplot2::theme(panel.background = ggplot2::element_rect(fill = "lightblue", color = "black"))
}

## a presence/absence picture of the two-way table (filled = present, blank = absent)
two_way_plot <- function(data_2way, caption = NULL) {
  long <- data_2way |>
    tidyr::pivot_longer(-Item, names_to = "Site", values_to = "present")
  ggplot2::ggplot(long, ggplot2::aes(x = Site,
                                     y = forcats::fct_rev(factor(Item)),
                                     fill = factor(present))) +
    ggplot2::geom_tile(color = "gray70") +
    ggplot2::scale_fill_manual(values = c("0" = "white", "1" = "darkgoldenrod2"), guide = "none") +
    ggplot2::coord_equal() +
    ggplot2::labs(x = NULL, y = NULL, caption = caption) +
    ggplot2::theme_minimal() +
    ggplot2::theme(panel.grid = ggplot2::element_blank())
}

## --- from the two-way table to a tree, as two visible steps ---

## pairwise dissimilarities between items (default) or sites, from the two-way table
## (binary distance: 0 = identical lists, 1 = nothing in common)
dissimilarity <- function(data_2way, what = c("item", "site"), method = "binary") {
  what <- match.arg(what)
  m <- as.matrix(data_2way[, -1, drop = FALSE]); rownames(m) <- data_2way$Item
  if (what == "site") m <- t(m)
  d <- stats::dist(m, method = method); d[is.na(d)] <- 0
  d
}

## the dissimilarity matrix as a heatmap (paler = more alike)
dissimilarity_plot <- function(d, caption = NULL) {
  long <- as.data.frame(as.table(as.matrix(d)))   # Var1, Var2, Freq
  ggplot2::ggplot(long, ggplot2::aes(Var2, forcats::fct_rev(Var1), fill = Freq)) +
    ggplot2::geom_tile(color = "gray70") +
    ggplot2::geom_text(ggplot2::aes(label = round(Freq, 2)), size = 2.8) +
    ggplot2::scale_fill_gradient(low = "white", high = "darkgoldenrod2", guide = "none") +
    ggplot2::coord_equal() +
    ggplot2::labs(x = NULL, y = NULL, caption = caption) +
    ggplot2::theme_minimal() +
    ggplot2::theme(panel.grid = ggplot2::element_blank())
}

## a dendrogram drawn from a dissimilarity object, with explicit linkage
dendrogram_plot <- function(d, linkage = "average", caption = NULL) {
  hc  <- stats::hclust(d, method = linkage)
  hcd <- ggdendro::dendro_data(hc, type = "rectangle")
  ggplot2::ggplot() +
    ggplot2::geom_segment(data = ggdendro::segment(hcd),
                          ggplot2::aes(x, y, xend = xend, yend = yend)) +
    ggplot2::geom_text(data = ggdendro::label(hcd),
                       ggplot2::aes(x, y, label = label, hjust = 0), size = 3) +
    ggplot2::coord_flip() +
    ggplot2::scale_y_reverse(expand = c(0.2, 0)) +
    ggplot2::labs(y = "dissimilarity", caption = caption) +
    dendro_theme()
}

## convenience: table -> tree in one call (the two steps above, chained)
make_dendrogram <- function(data_2way, what = c("item", "site"),
                            dist_method = "binary", linkage = "average", caption = NULL)
  dendrogram_plot(dissimilarity(data_2way, what, dist_method), linkage, caption)

## a dendrogram whose leaves are coloured by EXTERNAL metadata (the "linking metadata" chapter).
## d      : a dissimilarity object (from dissimilarity())
## info   : a data frame holding the metadata; one column matches the leaf labels
## by     : name of that matching column in `info` (e.g. "Site" or "Item")
## key    : name of the metadata column to colour by (e.g. "heritage", "origin")
## extra  : optional column shown in parentheses after each label (e.g. "owner")
## palette: optional named colour vector (e.g. Okabe-Ito values)
dendrogram_meta_plot <- function(d, info, by, key, linkage = "average",
                                 extra = NULL, palette = NULL, caption = NULL) {
  hc   <- stats::hclust(d, method = linkage)
  hcd  <- ggdendro::dendro_data(hc, type = "rectangle")
  labs <- dplyr::left_join(ggdendro::label(hcd), info,
                           by = stats::setNames(by, "label"))
  labs$txt <- if (is.null(extra)) paste0("  ", labs$label) else
    paste0("  ", labs$label, " (", labs[[extra]], ")")
  g <- ggplot2::ggplot() +
    ggplot2::geom_segment(data = ggdendro::segment(hcd),
                          ggplot2::aes(x, y, xend = xend, yend = yend)) +
    ggplot2::geom_point(data = labs,
                        ggplot2::aes(x, y, color = .data[[key]]), size = 2.6) +
    ggplot2::geom_text(data = labs,
                       ggplot2::aes(x, y, label = txt, color = .data[[key]]),
                       hjust = 0, size = 3.2, fontface = "bold", show.legend = FALSE) +
    ggplot2::coord_flip() +
    ggplot2::scale_y_reverse(expand = c(0.35, 0)) +
    ggplot2::labs(y = "dissimilarity", color = key, caption = caption) +
    dendro_theme() +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::guides(color = ggplot2::guide_legend(override.aes = list(size = 4)))
  if (!is.null(palette)) g <- g + ggplot2::scale_color_manual(values = palette)
  g
}

## --- assessment lines (the "most variable site sets the cut" design) ---

## how far out each site sits: the dissimilarity at which it is first recruited
## into ANY cluster. A large value marks a variable / atypical site; the most
## variable site is the one that sets the assessment line. Returned high -> low.
recruit_heights <- function(hc) {
  h <- vapply(seq_along(hc$labels), function(i) {
    step <- which(apply(hc$merge, 1, function(r) any(r == -i)))[1]
    hc$height[step]
  }, numeric(1))
  tibble::tibble(site = hc$labels, recruit_height = round(h, 3)) |>
    dplyr::arrange(dplyr::desc(recruit_height))
}

## cut a dendrogram by the "most variable site sets the line" rule.
##  oddball = FALSE (line A): the most variable site sets the cut height.
##  oddball = TRUE  (line B): that site is set aside and the next-most-variable
##                  site sets a tighter cut, leaving the oddball as its own group.
## Returns the cut height, the most variable site, the group of each site, and
## the recruitment-height table the decision rests on.
assessment_cut <- function(hc, oddball = FALSE, eps = 1e-4) {
  rh    <- recruit_heights(hc)
  cut_h <- if (oddball) rh$recruit_height[2] else rh$recruit_height[1]
  g     <- stats::cutree(hc, h = cut_h + eps)
  structure(
    list(cut_height    = cut_h,
         most_variable = rh$site[1],
         n_groups      = length(unique(g)),
         groups        = tibble::tibble(site = names(g), group = unname(g)),
         recruit       = rh),
    class = "assessment_cut")
}
