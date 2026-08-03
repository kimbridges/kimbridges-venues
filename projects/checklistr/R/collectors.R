#' Extract the primary collector's surname from a messy `recordedBy` string
#'
#' Herbarium `recordedBy` values are inconsistent: `"Surname, Initials"` vs
#' `"Given Surname"`, co-collector teams joined by `;`, `&` or `and`, annotations
#' such as `"State ESP team"`, name particles (`Van`, `von`, `de`), and
#' generational suffixes (`Jr`, `Sr`, `II`). This returns the surname of the
#' first (primary) collector.
#'
#' @param s A single `recordedBy` string (length one).
#' @return The primary collector's surname, or `NA` if none can be parsed.
#' @examples
#' primary_collector("Cuddihy, L.W.; State ESP team")
#' primary_collector("E. O. Guerrant, Jr.")
#' primary_collector("C. Van Riper")
#' @export
primary_collector <- function(s) {
  if (is.na(s) || !nzchar(str_squish(s))) return(NA_character_)
  s  <- str_squish(str_replace_all(s, regex("state esp team|esp team|et\\s*al\\.?",
                                            ignore_case = TRUE), ""))
  s1 <- str_squish(str_split(s, ";|&|\\band\\b", n = 2)[[1]][1])
  m  <- str_match(s1, "^([A-Z][A-Za-z'\u2019-]+),\\s*[A-Z]\\.?")
  if (!is.na(m[1, 1])) return(m[1, 2])
  toks <- str_split(s1, "\\s+")[[1]]; toks <- toks[nzchar(toks)]
  toks <- toks[!str_detect(toks, regex("^(jr|sr|ii|iii|iv|2nd|3rd)[.,]*$", ignore_case = TRUE))]
  if (!length(toks)) return(NA_character_)
  last <- toks[length(toks)]
  if (length(toks) >= 2 && str_detect(toks[length(toks) - 1], "^([Vv]an|[Vv]on|[Dd]e|[Dd]el)$"))
    last <- paste(toks[length(toks) - 1], last)
  str_squish(str_replace_all(last, "[^A-Za-z'\u2019 -]", ""))
}

#' Add a consolidated `collector` column
#'
#' Applies [primary_collector()] to every `recordedBy` value.
#'
#' @param df A data frame with a `recordedBy` column (e.g. from
#'   [fetch_specimens_gbif()]).
#' @return `df` with an added `collector` column.
#' @export
add_primary_collector <- function(df) {
  dplyr::mutate(df, collector = vapply(.data$recordedBy, primary_collector, character(1), USE.NAMES = FALSE))
}
