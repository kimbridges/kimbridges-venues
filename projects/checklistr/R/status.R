# internal: collapse any status vocabulary to native / introduced for agreement tests
status_native <- function(x) {
  x <- tolower(as.character(x))
  out <- rep(NA_character_, length(x))
  out[grepl("endem|indig|native|^e$|^i$", x)]            <- "native"
  out[grepl("natural|introduc|alien|cult|^n$|^nat$", x)] <- "introduced"
  out
}

#' Add native/alien status to a checklist (regional overlay)
#'
#' Native vs alien is not a property of a species -- it is a relation between a
#' species and a **place**. A taxon native in one region is introduced in
#' another. So `checklistr` provides the *mechanism* for attaching status, not a
#' baked-in table: you supply a status source appropriate to the site's region.
#'
#' There is deliberately no global default here, because "native" only means
#' something relative to a region and an authority. A general, coarse
#' native/introduced signal can be derived from a region-keyed distribution
#' database (e.g. WCVP/POWO by TDWG region, or GIFT), and richer regional
#' categories (for Hawai'i: endemic / indigenous / Polynesian / naturalized /
#' cultivated) come from a regional authority (e.g. Wagner, Herbst & Sohmer).
#' Whatever the source, status is a **claim about a place** and should be
#' reported with the region and authority made explicit.
#'
#' @param checklist A checklist (from [build_checklist()]); needs `accepted_name`.
#' @param source Either a data frame with columns `accepted_name` and `status`,
#'   or a function taking the checklist and returning such a data frame.
#' @param quiet If `FALSE` (default), messages the match rate, since taxonomic
#'   name mismatches between the checklist (GBIF backbone) and the status source
#'   (often a regional authority) are the main reason for unmatched taxa.
#' @param verify_against Optional second status source (same form as `source`).
#'   When given, its status is attached as `status_check` and a `status_agree`
#'   flag marks where the two sources disagree (after `normalize`) — the taxa
#'   worth an expert's eye (e.g. a global default vs a regional authority).
#' @param normalize Function collapsing raw status values before the agreement
#'   test. Default coarsens to native / introduced (robust across vocabularies);
#'   pass `identity` or your own to compare finer categories.
#' @return `checklist` with an added `status` column (`NA` where unmatched), plus
#'   `status_check` and `status_agree` when `verify_against` is supplied.
#' @examples
#' \dontrun{
#' overlay <- data.frame(accepted_name = c("Acacia koa", "Psidium guajava"),
#'                       status = c("E", "Nat"))
#' cl <- build_checklist(raw) |> add_status(overlay)
#' }
#' @export
add_status <- function(checklist, source, verify_against = NULL,
                       normalize = status_native, quiet = FALSE) {
  get_src <- function(s) {
    x <- if (is.function(s)) s(checklist) else s
    stopifnot(is.data.frame(x), "accepted_name" %in% names(x), "status" %in% names(x))
    x[!duplicated(x$accepted_name), c("accepted_name", "status")]
  }
  out <- dplyr::left_join(checklist, get_src(source), by = "accepted_name")
  ndis <- NA
  if (!is.null(verify_against)) {
    chk <- get_src(verify_against); names(chk)[names(chk) == "status"] <- "status_check"
    out <- dplyr::left_join(out, chk, by = "accepted_name")
    a <- normalize(out$status); b <- normalize(out$status_check)
    out$status_agree <- ifelse(is.na(a) | is.na(b), NA, a == b)
    ndis <- sum(out$status_agree == FALSE, na.rm = TRUE)
  }
  if (!quiet)
    message(sprintf("add_status: %d/%d taxa matched (%.0f%%)%s.",
                    sum(!is.na(out$status)), nrow(out), 100 * mean(!is.na(out$status)),
                    if (!is.na(ndis)) sprintf("; %d disagree with the verify source", ndis) else ""))
  out
}

#' A GIFT-derived status source (endemic / indigenous / introduced, by region)
#'
#' Builds a coarse, general status lookup from GIFT regional checklists, for use
#' as the `source` in [add_status()]. Given a region's "all-species" GIFT list
#' (carrying the native flag) and, optionally, its endemic list, it returns
#' endemic / indigenous / introduced per species.
#'
#' This is the *global default* layer. Two honesty caveats: (1) it is in GIFT's
#' taxonomy, so it may need a name crosswalk to a GBIF-backbone checklist; (2) a
#' global source can disagree with a regional authority -- on the Hawaiian flora,
#' GIFT tends to under-call fern endemism and to flag some pantropical natives
#' (e.g. *Dodonaea viscosa*) as introduced. **Treat disagreements as taxa to
#' verify**, and prefer a regional-authority overlay where one exists.
#'
#' Find the `list_ID`s for a region with `GIFT::GIFT_lists()` filtered to the
#' region's `entity_ID` (from `GIFT::GIFT_regions()`). For the Hawaiian Islands:
#' all = 12927, endemic = 16075.
#'
#' @param all_list_ID GIFT `list_ID` of the region's all-species list.
#' @param endemic_list_ID Optional GIFT `list_ID` of the region's endemic list.
#' @param cache_dir Optional directory to cache the downloaded lists as `.rds`.
#' @return A data frame with `accepted_name` (in GIFT taxonomy) and `status`.
#' @export
status_gift <- function(all_list_ID, endemic_list_ID = NULL, cache_dir = NULL) {
  rd <- function(id) {
    f <- if (!is.null(cache_dir)) file.path(cache_dir, paste0("gift_list_", id, ".rds")) else NULL
    if (!is.null(f) && file.exists(f)) return(readRDS(f))
    if (!requireNamespace("GIFT", quietly = TRUE)) stop("Package 'GIFT' is needed.")
    x <- GIFT::GIFT_checklists_raw(list_ID = id)
    if (!is.null(f)) saveRDS(x, f)
    x
  }
  allsp <- rd(all_list_ID)
  end_sp <- if (!is.null(endemic_list_ID)) rd(endemic_list_ID)$work_species else character(0)
  em <- allsp$work_species %in% end_sp |
        (!is.na(allsp$endemic_list) & allsp$endemic_list == 1)
  st <- ifelse(em, "endemic",
        ifelse(!is.na(allsp$native) & allsp$native == 1, "indigenous", "introduced"))
  data.frame(accepted_name = allsp$work_species, status = st, stringsAsFactors = FALSE)
}

#' Resolve a status source's names to the GBIF backbone
#'
#' A checklist from [build_checklist()] is in GBIF-backbone taxonomy, but a
#' status source (regional authority, or GIFT) is usually in a different one, so
#' a plain name join misses synonyms. This runs the source's names through
#' `rgbif::name_backbone_checklist()` and replaces `accepted_name` with the
#' GBIF-accepted species, so it joins more completely in [add_status()]. It is
#' not perfect -- GBIF's own occurrence field and its name matcher can disagree
#' -- but it closes much of the gap.
#'
#' @param df A data frame with a name column and a `status` column.
#' @param name_col Column holding the names to resolve (default `accepted_name`).
#' @return `df` with `accepted_name` set to the GBIF-accepted species; rows that
#'   do not resolve to a species are dropped.
#' @export
crosswalk_gbif <- function(df, name_col = "accepted_name") {
  if (!requireNamespace("rgbif", quietly = TRUE)) stop("Package 'rgbif' is needed.")
  m <- rgbif::name_backbone_checklist(df[[name_col]])
  df$accepted_name <- m$species
  df[!is.na(df$accepted_name) & df$accepted_name != "", , drop = FALSE]
}
