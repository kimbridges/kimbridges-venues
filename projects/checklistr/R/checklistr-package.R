#' checklistr: regional plant checklists and collecting analytics from herbarium records
#'
#' Build regional plant checklists from GBIF preserved-specimen (herbarium) records
#' and examine a collecting location through several lenses: collector/date profiles,
#' species accumulation and inventory completeness, determination conflicts between
#' duplicate specimens, and the native/alien composition of each collector's work.
#'
#' A typical pipeline:
#' \preformatted{
#' sp <- fetch_specimens_gbif(lon = -155.296, lat = 19.437, r_km = 2) |>
#'         add_primary_collector() |>
#'         dedup_specimens(level = "institution")
#' collector_profile(sp)
#' richness_estimate(sp)
#' plot_species_discovery(sp, place = "Kipuka Puaulu")
#' }
#'
#' @keywords internal
"_PACKAGE"

#' @import dplyr
#' @import ggplot2
#' @importFrom rlang .data
#' @importFrom stats setNames
#' @importFrom stringr str_squish str_replace str_replace_all str_extract str_detect str_split str_trim str_match regex fixed
#' @importFrom utils globalVariables
NULL

#' Pipe operator
#'
#' Re-exported from \pkg{magrittr}. See \code{magrittr::\link[magrittr:pipe]{\%>\%}}.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#' @return The result of calling `rhs(lhs)`.
NULL
