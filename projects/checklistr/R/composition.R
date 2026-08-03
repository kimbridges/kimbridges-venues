#' Tag specimens with checklist accepted taxon and status
#'
#' Joins each specimen to its accepted taxon and biogeographic `status` from a
#' checklist CSV, by matching the specimen `scientificName` to the checklist's
#' `verbatim_names` (ASCII-folded so diacritics in authorship do not break the
#' match). This is the inverse of how a facet-based checklist is built, so the
#' match rate is typically ~100%.
#'
#' @param df A specimen data frame with a `scientificName` column.
#' @param checklist_path Path to a checklist CSV with columns `accepted_name`,
#'   `status`, and `verbatim_names` (the `"Name [n]; Name [n]"` form).
#' @return `df` with added `accepted_name` and `status` columns.
#' @export
add_checklist_status <- function(df, checklist_path) {
  cl <- readr::read_csv(checklist_path, show_col_types = FALSE, na = character())
  f  <- function(x) stringi::stri_trans_general(x, "Latin-ASCII")
  lut <- cl %>% dplyr::select(accepted_name, status, verbatim_names) %>%
    tidyr::separate_rows(verbatim_names, sep = "; ") %>%
    dplyr::mutate(key = f(str_squish(str_replace(verbatim_names, "\\s*\\[\\d+\\]$", "")))) %>%
    dplyr::filter(key != "") %>% dplyr::distinct(key, accepted_name, status)
  df %>% dplyr::mutate(key = f(str_squish(scientificName))) %>%
    dplyr::left_join(lut, by = "key") %>% dplyr::select(-key)
}

#' Plot each collector's native/alien composition
#'
#' Stacked proportion bars of specimens by biogeographic origin for each
#' collector, ordered by first year. Requires a `status` column (from
#' [add_checklist_status()]) using codes `E`, `I`, `Nat`, `Cult`, `?`.
#'
#' @param df A specimen data frame with `collector`, `year`, `status`.
#' @param min_specimens Minimum specimens for a collector to be shown.
#' @param place Place name for the title.
#' @return A ggplot object.
#' @export
plot_collector_composition <- function(df, min_specimens = 5, place = "") {
  pal <- c(Endemic = "#1b7837", Indigenous = "#7fbf7b", Naturalized = "#f1a340",
           Cultivated = "#b35806", Uncertain = "grey70")
  lab <- c(E = "Endemic", I = "Indigenous", Nat = "Naturalized", Cult = "Cultivated", `?` = "Uncertain")
  keep <- df %>% dplyr::filter(!is.na(collector)) %>% dplyr::count(collector) %>%
          dplyr::filter(n >= min_specimens) %>% dplyr::pull(collector)
  d <- df %>% dplyr::filter(collector %in% keep, !is.na(status)) %>%
    dplyr::group_by(collector) %>% dplyr::mutate(fy = min(year, na.rm = TRUE), tot = dplyr::n()) %>% dplyr::ungroup() %>%
    dplyr::mutate(status_f = factor(lab[status], levels = names(pal)))
  o <- d %>% dplyr::distinct(collector, fy, tot) %>% dplyr::arrange(fy) %>%
    dplyr::mutate(clab = paste0(collector, " (", fy, ", n=", tot, ")"))
  d <- d %>% dplyr::left_join(o, by = c("collector", "fy", "tot")) %>%
    dplyr::mutate(clab = factor(clab, levels = rev(o$clab)))
  ggplot2::ggplot(d, ggplot2::aes(y = clab, fill = status_f)) +
    ggplot2::geom_bar(position = "fill", width = 0.8) +
    ggplot2::scale_fill_manual(values = pal, name = NULL) +
    ggplot2::scale_x_continuous(labels = scales::percent) +
    ggplot2::labs(title = paste(place, "- what each collector collected (by origin)"),
                  x = "share of specimens", y = NULL) +
    ggplot2::theme_minimal(base_size = 12) +
    ggplot2::theme(panel.grid = ggplot2::element_blank(), legend.position = "bottom")
}

#' Collector contributions: breadth vs uniqueness
#'
#' For each collector, the number of distinct taxa collected and the number
#' collected by no one else (unique contributions). The taxon unit is
#' `accepted_name` if present, else GBIF `species`.
#'
#' @param df A specimen data frame with `collector` and `accepted_name` or `species`.
#' @return A tibble with `collector`, `total_taxa`, `unique_taxa`, ordered by
#'   unique contributions.
#' @export
collector_contributions <- function(df) {
  df$.tax <- if ("accepted_name" %in% names(df)) df$accepted_name else df$species
  d  <- df %>% dplyr::filter(!is.na(collector), !is.na(.tax), .tax != "") %>% dplyr::distinct(collector, .tax)
  nc <- d %>% dplyr::count(.tax, name = "n_collectors")
  d %>% dplyr::left_join(nc, by = ".tax") %>% dplyr::group_by(collector) %>%
    dplyr::summarise(total_taxa = dplyr::n(), unique_taxa = sum(n_collectors == 1), .groups = "drop") %>%
    dplyr::arrange(dplyr::desc(unique_taxa))
}
