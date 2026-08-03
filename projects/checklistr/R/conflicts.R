#' Detect determination conflicts on single specimens
#'
#' Finds single physical sheets that carry more than one distinct species
#' determination -- most often the same Bishop Museum sheet databased with
#' different identifications under `BISH` and `BPBM`. Each such sheet is one
#' specimen with conflicting names, which matters for a checklist: a taxon whose
#' only support is the losing side of a conflict may be a phantom.
#'
#' The mapping of each conflicting GBIF name to an accepted checklist taxon still
#' needs a human/authority check, because GBIF genus reassignments can hide a
#' conflict (e.g. \emph{Eriocapitella} = \emph{Anemone},
#' \emph{Leptopetalum} = \emph{Hedyotis}).
#'
#' \strong{Run this on the raw pull, before [dedup_specimens()].} Deduplication
#' collapses the duplicate rows that carry the conflicting determinations, so
#' running it on deduplicated data returns nothing.
#'
#' @param df Raw (pre-dedup) specimen records with `institutionCode`,
#'   `catalogNumber` and `species` (optionally `collector`, `year`).
#' @return A tibble with one row per conflicting sheet: `institution`,
#'   `catalogNumber`, `collector`, `year`, `codes`, `n_dets` and the
#'   `determinations` joined by `" | "`.
#' @export
detect_det_conflicts <- function(df) {
  has_col <- function(nm) nm %in% names(df)
  df %>%
    dplyr::mutate(institution = normalize_institution(institutionCode)) %>%
    dplyr::filter(!is.na(catalogNumber), catalogNumber != "", !is.na(species), species != "") %>%
    dplyr::group_by(institution, catalogNumber) %>%
    dplyr::filter(dplyr::n() > 1, dplyr::n_distinct(species) > 1) %>%
    dplyr::summarise(
      collector = if (has_col("collector")) paste(unique(collector), collapse = "/") else NA_character_,
      year      = if (has_col("year")) paste(unique(year), collapse = "/") else NA_character_,
      codes     = paste(institutionCode, collapse = "+"),
      n_dets    = dplyr::n_distinct(species),
      determinations = paste(sort(unique(species)), collapse = " | "),
      .groups = "drop") %>%
    dplyr::arrange(dplyr::desc(n_dets), catalogNumber)
}
