#' Recruitment height of each site
#'
#' For a fitted tree, the dissimilarity at which each site is first recruited
#' into any cluster -- its *recruitment height*. A large value marks a variable,
#' atypical site; the most variable site is the one that sets the assessment
#' line. This is the variability measure behind [assessment_cut()].
#'
#' @param hc An [stats::hclust] object.
#' @return A tibble of `site` and `recruit_height`, ordered high to low.
#' @examples
#' tw <- data_to_2way(read_lists("S1, a, b\nS2, b, c\nS3, a, b\nS4, d"))
#' recruit_heights(hclust(dissimilarity(tw, what = "site"), method = "average"))
#' @export
recruit_heights <- function(hc) {
  h <- vapply(seq_along(hc$labels), function(i) {
    step <- which(apply(hc$merge, 1, function(r) any(r == -i)))[1]
    hc$height[step]
  }, numeric(1))
  tibble::tibble(site = hc$labels, recruit_height = round(h, 3)) |>
    dplyr::arrange(dplyr::desc(.data$recruit_height))
}

#' Cut a tree by the assessment-line rule
#'
#' Cut a dendrogram into groups by the "most variable site sets the line" rule.
#' With `oddball = FALSE` (line A) the most variable site sets the cut height, so
#' a group may be as loose as its loosest clear member. With `oddball = TRUE`
#' (line B) that site is set aside and the next-most-variable site sets a tighter
#' cut, leaving the oddball as its own one-member group.
#'
#' Unlike the paired-replicate design -- where replicate sites known to belong
#' together must not be split -- this design lets the data's own most variable
#' site establish the tolerance. Either way the rule is stated in advance, so the
#' groups are reproducible: anyone applying the same rule to the same tree gets
#' the same groups.
#'
#' @param hc An [stats::hclust] object.
#' @param oddball If `TRUE`, set the single most variable site aside and let the
#'   next-most-variable site set the (tighter) cut.
#' @param eps A tiny amount added to the cut height so the chosen join is
#'   included by [stats::cutree()].
#' @return An object of class `assessment_cut`: a list with the `cut_height`, the
#'   `most_variable` site, the number of groups `n_groups`, a `groups` tibble
#'   (`site`, `group`), and the `recruit` table the decision rests on.
#' @examples
#' tw <- data_to_2way(read_lists("S1, a, b\nS2, b, c\nS3, a, b\nS4, d"))
#' hc <- hclust(dissimilarity(tw, what = "site"), method = "average")
#' assessment_cut(hc)
#' assessment_cut(hc, oddball = TRUE)
#' @export
assessment_cut <- function(hc, oddball = FALSE, eps = 1e-4) {
  rh    <- recruit_heights(hc)
  cut_h <- if (oddball) rh$recruit_height[2] else rh$recruit_height[1]
  g     <- stats::cutree(hc, h = cut_h + eps)
  structure(
    list(cut_height    = cut_h,
         most_variable = rh$site[1],
         n_groups      = length(unique(g)),
         groups        = tibble::tibble(site = names(g), group = unname(g)),
         recruit       = rh),
    class = "assessment_cut")
}

#' @export
print.assessment_cut <- function(x, ...) {
  cat(sprintf("<assessment_cut> %d groups, cut at dissimilarity %.3f\n",
              x$n_groups, x$cut_height))
  cat(sprintf("most variable site: %s\n\n", x$most_variable))
  grouped <- x$groups |>
    dplyr::arrange(.data$group, .data$site) |>
    dplyr::group_by(.data$group) |>
    dplyr::summarise(sites = paste(.data$site, collapse = ", "), .groups = "drop")
  print(grouped, n = nrow(grouped))
  invisible(x)
}
