#' Species discovery over calendar time
#'
#' Cumulative count of distinct taxa by the year each was first collected -- the
#' historical picture of when a site's flora became known.
#'
#' @param df A specimen data frame with `species` and `year`.
#' @return A tibble with `first_year`, `new_taxa` and `cum_taxa`.
#' @export
species_discovery <- function(df) {
  df %>% dplyr::filter(!is.na(species), species != "", !is.na(year)) %>%
    dplyr::group_by(species) %>% dplyr::summarise(first_year = min(year), .groups = "drop") %>%
    dplyr::count(first_year, name = "new_taxa") %>% dplyr::arrange(first_year) %>%
    dplyr::mutate(cum_taxa = cumsum(new_taxa))
}

#' Observed richness and inventory completeness
#'
#' Observed taxon richness plus completeness estimators from \pkg{vegan}:
#' abundance-based Chao1 (from specimen counts per taxon) and incidence-based
#' Chao2 / first-order jackknife (from a collecting-event by taxon matrix).
#'
#' \strong{Caveats -- report them.} (1) Herbarium collecting is deliberate
#' (about one sheet per taxon), which inflates the singleton count and makes
#' these estimators tend to \emph{over}-estimate unseen richness; trust the
#' direction, not the exact digits. (2) GBIF holds only digitised specimens, so
#' this measures completeness \emph{of the GBIF record}, not of the flora -- a
#' useful flag for how well a site is documented online.
#'
#' @param df A specimen data frame with `species`, `collector`, `eventDate`.
#' @return A one-row tibble of observed richness, singleton/doubleton counts, and
#'   Chao1/Chao2/jackknife estimates with their implied completeness percentages.
#' @export
richness_estimate <- function(df) {
  ab  <- df %>% dplyr::filter(!is.na(species), species != "") %>% dplyr::count(species, name = "n")
  eab <- vegan::estimateR(setNames(ab$n, ab$species))
  ev  <- df %>% dplyr::filter(!is.na(species), species != "", !is.na(eventDate), eventDate != "") %>%
         dplyr::mutate(event = paste(collector, eventDate)) %>% dplyr::distinct(event, species)
  m <- table(ev$event, ev$species); m[m > 1] <- 1
  sp2  <- vegan::specpool(m); Sobs <- nrow(ab)
  tibble::tibble(
    S_obs = Sobs, singletons = sum(ab$n == 1), doubletons = sum(ab$n == 2),
    singleton_pct = round(100 * mean(ab$n == 1)), events = sp2$n,
    Chao1 = round(eab["S.chao1"]), Chao1_pct = round(100 * Sobs / eab["S.chao1"]),
    Chao2 = round(sp2$chao),       Chao2_pct = round(100 * Sobs / sp2$chao),
    jack1 = round(sp2$jack1),      jack1_pct = round(100 * Sobs / sp2$jack1))
}

#' Plot the species discovery curve
#'
#' @param df A specimen data frame with `species` and `year`.
#' @param place Place name for the title.
#' @return A ggplot object.
#' @export
plot_species_discovery <- function(df, place = "") {
  d <- species_discovery(df)
  ggplot2::ggplot(d, ggplot2::aes(first_year, cum_taxa)) +
    ggplot2::geom_step(direction = "hv", linewidth = 0.9, color = "#1b7837") +
    ggplot2::geom_point(data = subset(d, new_taxa >= 5), ggplot2::aes(size = new_taxa), color = "#1b7837") +
    ggplot2::scale_size_area(max_size = 8, guide = "none") +
    ggplot2::scale_x_continuous(breaks = seq(1900, 2030, 10)) +
    ggplot2::labs(title = paste(place, "- species accumulation (discovery curve)"),
                  subtitle = paste0("cumulative distinct taxa by year first collected; ", max(d$cum_taxa), " taxa"),
                  x = NULL, y = "cumulative taxa known") +
    ggplot2::theme_minimal(base_size = 12) + ggplot2::theme(panel.grid.minor = ggplot2::element_blank())
}

#' Plot sample-based accumulation with completeness references
#'
#' Randomised accumulation of taxa over collecting events (with a confidence
#' band), and dashed/dotted lines at the Chao2 and jackknife richness estimates.
#'
#' @param df A specimen data frame with `species`, `collector`, `eventDate`.
#' @param place Place name for the title.
#' @param permutations Number of permutations for [vegan::specaccum()].
#' @return A ggplot object.
#' @export
plot_accumulation <- function(df, place = "", permutations = 200) {
  ev <- df %>% dplyr::filter(!is.na(species), species != "", !is.na(eventDate), eventDate != "") %>%
        dplyr::mutate(event = paste(collector, eventDate)) %>% dplyr::distinct(event, species)
  m <- table(ev$event, ev$species); m[m > 1] <- 1
  sa <- vegan::specaccum(m, method = "random", permutations = permutations)
  d  <- data.frame(events = sa$sites, taxa = sa$richness, sd = sa$sd)
  re <- richness_estimate(df)
  ggplot2::ggplot(d, ggplot2::aes(events, taxa)) +
    ggplot2::geom_ribbon(ggplot2::aes(ymin = taxa - 1.96 * sd, ymax = taxa + 1.96 * sd),
                         fill = "#1b7837", alpha = 0.15) +
    ggplot2::geom_line(linewidth = 1, color = "#1b7837") +
    ggplot2::geom_hline(yintercept = re$Chao2, linetype = "dashed", color = "grey40") +
    ggplot2::geom_hline(yintercept = re$jack1, linetype = "dotted", color = "grey40") +
    ggplot2::labs(title = paste(place, "- sample-based accumulation"),
                  subtitle = paste0(re$S_obs, " taxa over ", re$events, " collecting events; ",
                                   re$singleton_pct, "% singletons"),
                  x = "collecting events (collector x date)", y = "taxa accumulated") +
    ggplot2::theme_minimal(base_size = 12) + ggplot2::theme(panel.grid.minor = ggplot2::element_blank())
}
