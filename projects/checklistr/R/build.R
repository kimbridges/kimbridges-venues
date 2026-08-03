#' Build a regional checklist from herbarium records
#'
#' Turns a set of GBIF specimen records into a checklist of accepted species.
#' Names are resolved to accepted species by GBIF's own backbone (the `species`
#' field), which collapses synonyms and infraspecific taxa automatically -- no
#' hand-normalisation. Records are institution-deduplicated for honest counts
#' (see [dedup_specimens()]), and determination conflicts are detected on the raw
#' records (see [detect_det_conflicts()]) and flagged.
#'
#' The result carries `accepted_name`, `family`, `genus`, `class`, `n_records`,
#' `rank`, and `det_conflict`. Add growth form with [add_lifeform()] and, for a
#' region with a status authority, native/alien status with [add_checklist_status()].
#'
#' @param df Raw specimen records (from [fetch_specimens_gbif()], ideally with
#'   [add_primary_collector()]); do NOT pre-deduplicate -- this function handles it.
#' @return A tibble, one row per accepted taxon, ordered by family then name.
#' @examples
#' \dontrun{
#' raw <- fetch_specimens_gbif(-155.296, 19.437, 2, taxon = "Tracheophyta", rank = "phylum") |>
#'          add_primary_collector()
#' cl <- build_checklist(raw)
#' }
#' @export
build_checklist <- function(df) {
  first_ne <- function(x) { x <- x[!is.na(x) & x != ""]; if (length(x)) x[1] else NA_character_ }
  conf    <- detect_det_conflicts(df)
  conf_sp <- if (nrow(conf)) unique(unlist(strsplit(conf$determinations, " \\| "))) else character(0)
  d <- dedup_specimens(df, "institution", verbose = FALSE)

  sp <- d %>% dplyr::filter(!is.na(species), species != "") %>%
    dplyr::group_by(accepted_name = species) %>%
    dplyr::summarise(genus = first_ne(genus), family = first_ne(family),
                     class = first_ne(class), n_records = dplyr::n(), .groups = "drop") %>%
    dplyr::mutate(rank = "species",
                  det_conflict = ifelse(accepted_name %in% conf_sp, "conflict", ""))

  gonly <- d %>% dplyr::filter((is.na(species) | species == ""), !is.na(genus), genus != "") %>%
    dplyr::group_by(accepted_name = paste(genus, "sp.")) %>%
    dplyr::summarise(genus = first_ne(genus), family = first_ne(family),
                     class = first_ne(class), n_records = dplyr::n(), .groups = "drop") %>%
    dplyr::mutate(rank = "genus", det_conflict = "")

  dplyr::bind_rows(sp, gonly) %>% dplyr::arrange(family, accepted_name)
}
