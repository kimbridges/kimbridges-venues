#' Fish-market toy list
#'
#' A small designed example: seven market stalls and the seafood each sells.
#' Two clean families (finfish and shellfish), plus one mixed stall that reaches
#' across the divide. Used throughout the *lists* document as the running toy.
#'
#' @format A data frame of 7 stalls (rows) with a `Site` column and `item1` ..
#'   `item6` columns; ragged rows are padded with empty strings. Read with
#'   [read_lists()] from the raw text.
#' @source A designed teaching example.
"fish_market"

#' Madison seasonal-produce list
#'
#' What an open-air market in Madison, Wisconsin sells in each month of the year,
#' and whether each item is sold fresh or from storage. Used in the *lists*
#' document to demonstrate assessment lines against the common-sense
#' four-seasons hypothesis.
#'
#' @format A tibble of 214 rows and 3 columns:
#' \describe{
#'   \item{month}{Month of the market year (April through the following March).}
#'   \item{produce}{The kind of produce on sale.}
#'   \item{status}{`"fresh"` or `"stored"`.}
#' }
#' @source Transcribed from a regional seasonal-produce guide at
#'   <https://www.thespruceeats.com>.
"madison_produce"
