#' Normalise synonymous institution codes
#'
#' Some herbaria appear under more than one Index Herbariorum code; most
#' importantly `BISH` and `BPBM` are both the Bernice P. Bishop Museum. This
#' folds known synonyms to a single code so that duplicate records of one
#' physical specimen can be detected.
#'
#' @param x A character vector of institution codes.
#' @return The vector with synonymous codes folded (currently `BPBM` -> `BISH`).
#' @export
normalize_institution <- function(x) dplyr::recode(x, BPBM = "BISH")

#' Clean a collector's field number (the gathering key)
#'
#' Extracts the core collection number from a noisy `recordNumber` value
#' (e.g. `"Collector Number: 561"` -> `"561"`, `"082"` -> `"82"`), for use as a
#' gathering key when collapsing duplicate sheets across herbaria.
#'
#' @param x A character vector of `recordNumber` values.
#' @return A character vector of cleaned numbers, `NA` where none is present.
#' @examples
#' clean_record_number(c("Collector Number: 561", "082", "s.n."))
#' @export
clean_record_number <- function(x) {
  x <- tolower(ifelse(is.na(x), "", x))
  x <- str_replace_all(x, "collector number:|collector no\\.?:?|coll\\.? no\\.?:?|number:|no\\.:?", " ")
  num <- str_extract(str_squish(x), "\\d+\\s*[a-z]?")
  num <- str_replace_all(num, "\\s", "")
  num <- str_replace(num, "^0+(?=\\d)", "")
  ifelse(is.na(num) | num == "", NA_character_, num)
}

#' Deduplicate herbarium records
#'
#' Herbarium occurrence data contains two kinds of duplication. Apply this
#' \emph{early}, before any counting.
#'
#' \describe{
#'   \item{`level = "institution"` (default)}{Collapses records of the same
#'     physical specimen entered under synonymous museum codes (e.g. the same
#'     Bishop Museum sheet databased as both `BISH` and `BPBM`). A pure artifact;
#'     always safe to remove, no information lost.}
#'   \item{`level = "gathering"`}{Additionally collapses duplicate \emph{sheets}
#'     of one collection event distributed across herbaria, keyed by collector +
#'     cleaned `recordNumber` + year. Use when you want collection events rather
#'     than physical sheets.}
#' }
#' When collapsing, the most complete row is kept (preferring the `BISH` code).
#'
#' @param df A specimen data frame (with `institutionCode`, `catalogNumber`,
#'   `species`; and, for `"gathering"`, `collector`, `recordNumber`, `year`).
#' @param level Deduplication level, `"institution"` or `"gathering"`.
#' @param verbose If `TRUE`, message the row counts removed.
#' @return `df` deduplicated, with an added normalised `institution` column.
#' @examples
#' \dontrun{
#' sp <- fetch_specimens_gbif(-155.296, 19.437, 2) |>
#'         add_primary_collector() |>
#'         dedup_specimens("institution")
#' }
#' @export
dedup_specimens <- function(df, level = c("institution", "gathering"), verbose = TRUE) {
  level <- match.arg(level); n0 <- nrow(df)
  scols <- intersect(c("eventDate", "recordNumber", "species", "decimalLatitude"), names(df))
  df$.score <- Reduce(`+`, lapply(scols, function(c) as.integer(!is.na(df[[c]]) & as.character(df[[c]]) != "")))
  df$institution <- normalize_institution(df$institutionCode)
  df$.cat  <- ifelse(is.na(df$catalogNumber) | df$catalogNumber == "", NA, df$catalogNumber)
  df$.pref <- df$institutionCode == "BISH"
  A  <- df %>% dplyr::filter(!is.na(.cat)) %>% dplyr::group_by(institution, .cat) %>%
        dplyr::arrange(dplyr::desc(.score), dplyr::desc(.pref)) %>% dplyr::slice(1) %>% dplyr::ungroup()
  df <- dplyr::bind_rows(A, dplyr::filter(df, is.na(.cat)))
  if (level == "gathering") {
    df$.rn <- clean_record_number(df$recordNumber)
    K  <- df %>% dplyr::filter(!is.na(.rn) & !is.na(collector)) %>%
          dplyr::group_by(collector, .rn, year) %>%
          dplyr::arrange(dplyr::desc(.score), dplyr::desc(.pref)) %>% dplyr::slice(1) %>% dplyr::ungroup()
    df <- dplyr::bind_rows(K, dplyr::filter(df, is.na(.rn) | is.na(collector))) %>% dplyr::select(-.rn)
  }
  df <- dplyr::select(df, -.cat, -.score, -.pref)
  if (verbose) message(sprintf("dedup(%s): %d -> %d rows (removed %d)", level, n0, nrow(df), n0 - nrow(df)))
  df
}
