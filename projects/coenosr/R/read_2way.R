#' Read a wide two-way table (a species-by-sites matrix)
#'
#' Read data held as a rectangular two-way table: species down the rows, sites
#' across the columns, and a value in each cell. This is the familiar
#' spreadsheet form, the way many people store co-occurrence data. The cell may
#' be a cover value or a simple presence/absence flag (`1`/`0`).
#'
#' @details
#' The file is read with [utils::read.csv()]. The **first column** holds the row
#' identifiers (species, by default) and its header is ignored; the remaining
#' **column names** are the site identifiers. Each cell that is not an "absent"
#' marker becomes one occurrence, carrying the cell's value as its cover. By
#' default a cell counts as absent if it is `0`, blank, or `NA`, so a 1/0 matrix
#' and a cover matrix (covers in the filled cells, blanks elsewhere) both read
#' correctly.
#'
#' Set `transpose = TRUE` if your table is the other way round — sites down the
#' rows and species across the columns.
#'
#' @param path Path to a CSV-style file.
#' @param absent Character vector of cell values that mean "absent" and are
#'   dropped. Defaults to `c("0", "", "NA")`. `NA` cells are always dropped.
#' @param transpose Logical; if `TRUE`, rows are sites and columns are species.
#'   Defaults to `FALSE` (rows are species, columns are sites — the COENOS table
#'   orientation).
#' @param encoding File encoding passed to [utils::read.csv()].
#' @param ... Further arguments passed to [utils::read.csv()].
#'
#' @return A `coenos_rel` table (see [read_rel()]), identical in form to what the
#'   other readers produce.
#'
#' @seealso [read_lists()] for the ragged "site, then its species" form,
#'   [read_rel()] for COENOS files.
#'
#' @examples
#' rel <- read_2way(system.file("extdata", "simple_10x15_input.txt",
#'                              package = "coenosr"))
#' nlevels(rel$releve)   # 10 sites
#' nlevels(rel$species)  # 15 species
#'
#' @export
read_2way <- function(path, absent = c("0", "", "NA"), transpose = FALSE,
                      encoding = "latin1", ...) {
  if (!file.exists(path)) {
    stop("File not found: ", path, call. = FALSE)
  }
  w <- utils::read.csv(path, stringsAsFactors = FALSE, check.names = FALSE,
                       strip.white = TRUE, fileEncoding = encoding, ...)
  if (ncol(w) < 2L) {
    stop("A two-way table needs an id column plus at least one data column.",
         call. = FALSE)
  }
  names(w) <- trimws(names(w))
  rowids <- trimws(as.character(w[[1]]))
  colids <- names(w)[-1]

  mat <- as.matrix(w[, -1, drop = FALSE])
  storage.mode(mat) <- "character"
  mat <- trimws(mat)

  rel_l <- list(); sp_l <- list(); cv_l <- list(); k <- 0L
  for (i in seq_along(rowids)) {
    for (j in seq_along(colids)) {
      val <- mat[i, j]
      if (is.na(val) || !nzchar(val) || val %in% absent) next
      if (transpose) {
        site <- rowids[i]; species <- colids[j]
      } else {
        site <- colids[j]; species <- rowids[i]
      }
      k <- k + 1L
      rel_l[[k]] <- site; sp_l[[k]] <- species; cv_l[[k]] <- val
    }
  }

  new_coenos_rel(
    unlist(rel_l, use.names = FALSE),
    unlist(sp_l,  use.names = FALSE),
    unlist(cv_l,  use.names = FALSE)
  )
}
