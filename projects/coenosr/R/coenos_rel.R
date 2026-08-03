#' Build a coenos_rel object from releve / species / cover vectors
#'
#' Internal constructor shared by the reader functions ([read_rel()],
#' [read_lists()], [read_2way()]) so that all of them produce an identical
#' `coenos_rel` object: a long table with one row per relevé-by-species
#' occurrence, releve and species as factors in first-appearance order, and a
#' species that appears twice in one relevé keeping its last cover value.
#'
#' @param releve,species,cover Character vectors of equal length.
#' @return A data frame with S3 class `"coenos_rel"`.
#' @keywords internal
#' @noRd
new_coenos_rel <- function(releve, species, cover) {
  df <- data.frame(
    releve  = as.character(releve),
    species = as.character(species),
    cover   = as.character(cover),
    stringsAsFactors = FALSE
  )
  # a species repeated within a relevé keeps its LAST cover value
  key <- paste(df$releve, df$species, sep = "\r")
  df <- df[!duplicated(key, fromLast = TRUE), , drop = FALSE]
  df$releve  <- factor(df$releve,  levels = unique(df$releve))
  df$species <- factor(df$species, levels = unique(df$species))
  rownames(df) <- NULL
  class(df) <- c("coenos_rel", "data.frame")
  df
}
