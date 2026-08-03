#' coenosr: Reconstruction of the 1991 COENOS Braun-Blanquet table-sorting method
#'
#' COENOS (Ceska & Roemer, 1991) was a compiled-Pascal program for numerical
#' phytosociology in the Braun-Blanquet tradition, implementing the table-sorting
#' method Ceska & Roemer first published in 1971. It sorted a raw
#' species-by-releve table into a structured two-way table of differential
#' species groups, forming groups by inside/outside frequency rules and ordering
#' them by reciprocal averaging. The original source is lost. **coenosr** is a
#' faithful reconstruction of that method in R, developed and validated against
#' tables the original program produced (preserved as bundled example data and
#' decoded ground-truth oracles).
#'
#' @section Status:
#' This release provides the input readers — [read_rel()] (COENOS files),
#' [read_lists()] (the ragged "site, then its species" form), and [read_2way()]
#' (the wide species-by-sites matrix) — all returning the same `coenos_rel`
#' object, plus [constancy()] and the trim step [classify_species()]. Group
#' formation and reciprocal-averaging ordering are the next components.
#'
#' @section Bundled data:
#' `inst/extdata` carries example relevé files in several forms: the COENOS
#' `DIEREN.REL`, `ELLEN.REL`, and `SET1.DAT`, plus a small 15-species x 10-site
#' demonstration set in three shapes (`simple_10x15_simplified.txt` ragged,
#' `simple_10x15_input.txt` wide, `simple_10x15_cover.txt` ragged with covers).
#' Three decoded ground-truth tables
#' (`dieren_s00_species.csv`, `ellen_s00_species.csv`, `set1_s00_species.csv`)
#' give each species' constancy, role, and group membership as produced by the
#' original COENOS run, and serve as the test suite's validation oracles.
#'
#' @keywords internal
"_PACKAGE"
