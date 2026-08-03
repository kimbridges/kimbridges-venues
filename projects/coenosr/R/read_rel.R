#' Read a COENOS releve file (`.REL`)
#'
#' Parse a COENOS-format releve file into a tidy long table of
#' releve / species / cover records. The format is the ASCII input read by the
#' 1991 COENOS program: each releve begins with a code line, followed by one
#' species per line (four-character genus, a space, four-character species
#' epithet, then a one-character cover estimate), and ends with a `$` on its
#' own line.
#'
#' @details
#' Parsing follows the rules documented in the original COENOS help file:
#' \itemize{
#'   \item Only the **six rightmost characters** of a releve code are kept
#'     (codes may be longer; only the tail is significant).
#'   \item A species is identified by an 8-character key formed from the genus
#'     (columns 1--4) and the epithet (columns 6--9). The key is treated as an
#'     opaque token, so non-standard entries (a trailing-digit epithet such as
#'     `"380 "`, an `x` in a genus, a `?` in an epithet) are preserved verbatim
#'     rather than rejected.
#'   \item The cover estimate is the first non-blank character after the epithet
#'     field. A line with **no** cover estimate is ignored (this is how the
#'     releve code line and stray text are skipped within a releve).
#'   \item If a species is listed more than once in one releve, the **last**
#'     cover value is kept.
#'   \item Lines containing `&&` are comments and are ignored; blank lines are
#'     skipped.
#'   \item Reading is case-sensitive (`CARE AQUA` and `CARE aqua` differ).
#' }
#' Cover values are returned verbatim as single characters, so both the
#' Braun-Blanquet symbolic scale (`5 4 3 2 1 + R`) and numeric cover scales are
#' supported. Cover is recorded for display and is not interpreted here.
#'
#' @param path Path to a `.REL` file.
#' @param encoding File encoding passed to [readLines()]. Defaults to
#'   `"latin1"`; the bundled example data uses single-byte characters.
#'
#' @return A data frame (with S3 class `"coenos_rel"`) carrying one row per
#'   releve-by-species occurrence, with columns:
#'   \describe{
#'     \item{`releve`}{releve code, a factor in file order.}
#'     \item{`species`}{8-character COENOS species key, a factor in
#'       first-appearance order.}
#'     \item{`cover`}{cover estimate, a single character.}
#'   }
#'
#' @seealso [constancy()] for per-species occurrence counts.
#'
#' @examples
#' rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
#' nlevels(rel$releve)   # 18 releves
#' nlevels(rel$species)  # 116 species
#' head(rel)
#'
#' @export
read_rel <- function(path, encoding = "latin1") {
  if (!file.exists(path)) {
    stop("File not found: ", path, call. = FALSE)
  }
  lines <- readLines(path, encoding = encoding, warn = FALSE)

  rel_l <- vector("list", length(lines))
  sp_l  <- vector("list", length(lines))
  cv_l  <- vector("list", length(lines))
  n <- 0L
  current <- NA_character_
  expect_code <- TRUE

  for (raw in lines) {
    line <- sub("[ \t\r\n]+$", "", raw)          # strip trailing whitespace
    if (grepl("&&", line, fixed = TRUE)) next     # comment line
    if (!nzchar(trimws(line))) next               # blank line
    if (trimws(line) == "$") {                    # end of releve
      expect_code <- TRUE
      next
    }
    if (expect_code) {                            # releve code line
      code <- trimws(line)
      current <- substr(code, max(1L, nchar(code) - 5L), nchar(code))
      expect_code <- FALSE
      next
    }
    genus   <- substr(line, 1L, 4L)               # columns 1-4
    epithet <- substr(line, 6L, 9L)               # columns 6-9
    cov <- substr(trimws(substr(line, 10L, nchar(line))), 1L, 1L)
    if (!nzchar(cov)) next                         # no cover estimate -> ignore
    n <- n + 1L
    rel_l[[n]] <- current
    sp_l[[n]]  <- paste0(genus, epithet)
    cv_l[[n]]  <- cov
  }

  df <- data.frame(
    releve  = unlist(rel_l[seq_len(n)], use.names = FALSE),
    species = unlist(sp_l[seq_len(n)],  use.names = FALSE),
    cover   = unlist(cv_l[seq_len(n)],  use.names = FALSE),
    stringsAsFactors = FALSE
  )

  # A species repeated within a releve keeps its LAST cover value.
  key <- paste(df$releve, df$species, sep = "\r")
  df <- df[!duplicated(key, fromLast = TRUE), , drop = FALSE]

  df$releve  <- factor(df$releve,  levels = unique(df$releve))
  df$species <- factor(df$species, levels = unique(df$species))
  rownames(df) <- NULL
  class(df) <- c("coenos_rel", "data.frame")
  df
}

#' @export
print.coenos_rel <- function(x, ...) {
  cat(sprintf("<coenos_rel> %d releves x %d species, %d occurrences\n",
              nlevels(x$releve), nlevels(x$species), nrow(x)))
  print(utils::head(as.data.frame(x)), ...)
  if (nrow(x) > 6L) cat(sprintf("... (%d more rows)\n", nrow(x) - 6L))
  invisible(x)
}

#' Per-species constancy
#'
#' Constancy is the number of releves in which a species occurs. This is the
#' quantity COENOS uses to decide which species are eligible for group
#' formation and which fall to the low-constancy footnote.
#'
#' @param rel A `coenos_rel` table from [read_rel()].
#' @param sort Logical; if `TRUE` (default) return in order of decreasing
#'   constancy, otherwise in first-appearance order.
#'
#' @return A data frame with columns `species` and `constancy`.
#'
#' @examples
#' rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
#' head(constancy(rel))
#'
#' @export
constancy <- function(rel, sort = TRUE) {
  if (!inherits(rel, "coenos_rel")) {
    stop("`rel` must be a coenos_rel table from read_rel().", call. = FALSE)
  }
  tab <- table(rel$species)
  out <- data.frame(
    species   = names(tab),
    constancy = as.integer(tab),
    stringsAsFactors = FALSE
  )
  if (sort) out <- out[order(-out$constancy, out$species), , drop = FALSE]
  rownames(out) <- NULL
  out
}
