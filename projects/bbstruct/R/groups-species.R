#' Derive species groups (including ungrouped)
#'
#' @param x Either a `bb_tbl` or a `bb_reorder()` result (list with `$bb`).
#' @param method Grouping method identifier (default "stub").
#' @param ungrouped_label Label used for species not assigned to a group.
#' @param ... Reserved for future parameters.
#'
#' @return A tibble with columns: group, species, membership.
#'   Overlaps are supported by allowing a species to appear in multiple rows.
#' @export
bb_species_groups <- function(
    x,
    method = "stub",
    ungrouped_label = "Ungrouped species",
    ...
) {
  bb <- bb_extract_bb_(x)
  bb_validate(bb)
  
  ## Stub behavior: everything is ungrouped with membership 1
  tibble::tibble(
    group = rep(ungrouped_label, length(bb$species)),
    species = bb$species,
    membership = rep(1, length(bb$species)),
    method = rep(method, length(bb$species))
  )
}

