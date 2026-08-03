#' Read a relevé file in "site, then its species" (ragged) form
#'
#' Read vegetation (or any site-by-item) data recorded as one line per site: a
#' site code followed by the species found there. Lines need not be the same
#' length — each site lists only what was present — which makes this the natural
#' form for field recording (for example, dictating species into a recorder and
#' transcribing). It is a close, modern cousin of the COENOS `.REL` format read
#' by [read_rel()].
#'
#' @details
#' Each non-blank line is split on commas. The first field is the **site
#' (relevé) code**; the remaining fields are species. Cover values are
#' **detected automatically**: within a species field, a trailing token that
#' looks like a cover value — a Braun-Blanquet symbol (`+`, `R`) or a single
#' digit — is taken as the cover, and the rest of the field is the species name.
#' A field with no such trailing token is a species marked present (with the
#' `present` value as its cover). So both of these read correctly, with and
#' without cover:
#'
#' ```
#' 1, G, L, M, C            # presence only
#' 1, G 4, L 2, M +, C 3    # with Braun-Blanquet covers
#' ```
#'
#' Multi-word species names are supported (`Carex lyngbyei 5` reads as the
#' species `"Carex lyngbyei"` with cover `"5"`). Lines containing `&&` are
#' treated as comments and ignored. If a species is listed twice for one site,
#' the last cover wins. Unlike [read_rel()], the full site code is kept (it is
#' not truncated to six characters).
#'
#' @param path Path to the data file.
#' @param present Cover value assigned to a species given without a cover.
#'   Defaults to `"1"`, matching the presence marker of a 1/0 wide table.
#' @param encoding File encoding passed to [readLines()].
#'
#' @return A `coenos_rel` table (see [read_rel()]): columns `releve`, `species`,
#'   `cover`, ready for [constancy()], [classify_species()], and the rest of the
#'   workflow.
#'
#' @seealso [read_2way()] for the wide-matrix form, [read_rel()] for COENOS files.
#'
#' @examples
#' rel <- read_lists(system.file("extdata", "simple_10x15_simplified.txt",
#'                               package = "coenosr"))
#' nlevels(rel$releve)   # 10 sites
#' nlevels(rel$species)  # 15 species
#'
#' @export
read_lists <- function(path, present = "1", encoding = "latin1") {
  if (!file.exists(path)) {
    stop("File not found: ", path, call. = FALSE)
  }
  lines <- readLines(path, encoding = encoding, warn = FALSE)
  lines <- lines[nzchar(trimws(lines)) & !grepl("&&", lines, fixed = TRUE)]

  rel_l <- list(); sp_l <- list(); cv_l <- list(); k <- 0L
  for (ln in lines) {
    tok <- trimws(strsplit(ln, ",")[[1]])
    tok <- tok[nzchar(tok)]
    if (length(tok) < 2L) next          # a site with no species
    site <- tok[1]
    for (entry in tok[-1]) {
      parts <- strsplit(entry, "\\s+")[[1]]
      if (length(parts) >= 2L && is_cover(parts[length(parts)])) {
        species <- paste(parts[-length(parts)], collapse = " ")
        cover   <- parts[length(parts)]
      } else {
        species <- entry
        cover   <- present
      }
      k <- k + 1L
      rel_l[[k]] <- site; sp_l[[k]] <- species; cv_l[[k]] <- cover
    }
  }

  new_coenos_rel(
    unlist(rel_l, use.names = FALSE),
    unlist(sp_l,  use.names = FALSE),
    unlist(cv_l,  use.names = FALSE)
  )
}

#' Does a token look like a cover value?
#'
#' A Braun-Blanquet symbol (`+`, `R`/`r`) or a single digit. Used by
#' [read_lists()] to tell a trailing cover from part of a species name.
#'
#' @param x Character vector.
#' @return Logical vector.
#' @keywords internal
#' @noRd
is_cover <- function(x) {
  x %in% c("+", "R", "r") | grepl("^[0-9]$", x)
}
