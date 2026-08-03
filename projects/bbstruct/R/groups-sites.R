#' Derive site groups (overlap allowed)
#'
#' @param x Either a `bb_tbl` or a `bb_reorder()` result (list with `$bb`).
#' @param method Grouping method identifier (default "stub").
#' @param ... Reserved for future parameters.
#'
#' @return A tibble with columns: group, site, membership.
#'   Overlaps are supported by allowing a site to appear in multiple rows.
#' @export
bb_site_groups <- function(x, method = "stub", ...) {
  bb <- bb_extract_bb_(x)
  bb_validate(bb)
  
  ## Stub behavior: one group containing all sites
  tibble::tibble(
    group = rep("Site Group 1", length(bb$sites)),
    site = bb$sites,
    membership = rep(1, length(bb$sites)),
    method = rep(method, length(bb$sites))
  )
}

#' Summarize site-group overlap
#'
#' @param site_groups Tibble returned by `bb_site_groups()`.
#'
#' @return A tibble with site-level overlap counts.
#' @export
bb_site_group_summary <- function(site_groups) {
  needed <- c("group", "site", "membership")
  if (!all(needed %in% names(site_groups))) {
    rlang::abort("`site_groups` must have columns: group, site, membership.")
  }
  
  site_groups |>
    dplyr::group_by(.data$site) |>
    dplyr::summarise(
      n_groups = dplyr::n_distinct(.data$group),
      total_membership = sum(.data$membership, na.rm = TRUE),
      .groups = "drop"
    ) |>
    dplyr::arrange(dplyr::desc(.data$n_groups), .data$site)
}

