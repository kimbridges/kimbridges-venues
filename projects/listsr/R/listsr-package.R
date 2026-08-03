#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom rlang .data
## usethis namespace: end
NULL

## Quiet R CMD check on the bare column names used inside ggplot2::aes() and the
## tidyverse verbs ported from the original analysis script.
utils::globalVariables(c(
  "Site", "Item", "n", "present", "x", "y", "xend", "yend",
  "Var1", "Var2", "Freq", "label", "txt", "site", "group",
  "recruit_height", "season", "month", "produce", "status"
))
