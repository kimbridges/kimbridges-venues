#' Validate a species-by-site table
#'
#' @param bb A `bb_tbl` object.
#' @param allow_negative Logical.
#' @return Invisibly returns `bb` if valid.
#' @export
bb_validate <- function(bb, allow_negative = FALSE) {
  if (!inherits(bb, "bb_tbl")) rlang::abort("Input must be a `bb_tbl`.")
  x <- bb$x
  
  if (!is.matrix(x)) rlang::abort("`bb$x` must be a matrix.")
  if (is.null(rownames(x)) || any(rownames(x) == "")) rlang::abort("Species names (rownames) required.")
  if (is.null(colnames(x)) || any(colnames(x) == "")) rlang::abort("Site names (colnames) required.")
  if (anyNA(x)) rlang::abort("Missing values not allowed. Impute or drop first.")
  
  if (!allow_negative && any(x < 0, na.rm = TRUE)) {
    rlang::abort("Negative values found but `allow_negative = FALSE`.")
  }
  
  invisible(bb)
}

