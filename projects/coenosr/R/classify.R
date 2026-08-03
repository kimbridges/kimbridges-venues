#' Classify species by constancy for COENOS group formation
#'
#' COENOS divides species into three constancy classes before it forms
#' differential groups. This function reproduces that split, which is the
#' trimming step preceding group formation.
#'
#' @details
#' Let `n` be the number of relevés. A species' constancy is the number of
#' relevés in which it occurs (see [constancy()]). The classes are:
#' \describe{
#'   \item{`rare`}{constancy `< 3` -- too infrequent to define a group. These
#'     are the species COENOS lists in the "low constancy" table footnote.}
#'   \item{`ubiquitous`}{constancy `>= floor(2 * n / 3)` -- too widespread to be
#'     diagnostic. These become high-constancy companions, excluded from group
#'     formation.}
#'   \item{`eligible`}{everything in between -- the candidates from which
#'     differential species groups are formed. An eligible species that does
#'     not end up in any group is reported as an ordinary companion.}
#' }
#' The `floor(2 * n / 3)` ceiling is the integer form of the help file's
#' "constancy higher than 66%". It was recovered exactly from the COENOS
#' restart files for three datasets (n = 18, 25, 63); the integer floor, not the
#' percentage, is what the program uses (for n = 25 it excludes a species
#' present in 16 of 25 relevés, i.e. 64%).
#'
#' @param rel A `coenos_rel` table from [read_rel()].
#'
#' @return A data frame with columns `species`, `constancy`, and `status` (a
#'   factor with levels `eligible`, `ubiquitous`, `rare`), in first-appearance
#'   order. The number of relevés and the ceiling are attached as attributes
#'   `n_releve` and `ceiling`.
#'
#' @seealso [constancy()], [read_rel()]
#'
#' @examples
#' rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
#' cl <- classify_species(rel)
#' table(cl$status)
#' attr(cl, "ceiling")  # floor(2 * 18 / 3) = 12
#'
#' @export
classify_species <- function(rel) {
  if (!inherits(rel, "coenos_rel")) {
    stop("`rel` must be a coenos_rel table from read_rel().", call. = FALSE)
  }
  n <- nlevels(rel$releve)
  ceil <- (2L * n) %/% 3L
  con <- constancy(rel, sort = FALSE)
  st <- ifelse(con$constancy < 3L, "rare",
        ifelse(con$constancy >= ceil, "ubiquitous", "eligible"))
  con$status <- factor(st, levels = c("eligible", "ubiquitous", "rare"))
  attr(con, "n_releve") <- n
  attr(con, "ceiling")  <- ceil
  con
}
