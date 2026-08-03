#' Download (and cache) GIFT growth-form data
#'
#' Pulls the global growth-form trait (GIFT trait 1.2.1; values herb / shrub /
#' tree) from the GIFT database. The download is large, so caching to an RDS is
#' recommended -- pass `cache` and it is fetched once, then reused.
#'
#' @param cache Optional path to an `.rds` cache file. If it exists, it is read;
#'   otherwise the data is downloaded and (if a path is given) written there.
#' @return A data frame of species-level growth form (as returned by
#'   `GIFT::GIFT_traits()`), with a `work_species` column and a `trait_value_1.2.1`.
#' @export
gift_growthform <- function(cache = NULL) {
  if (!is.null(cache) && file.exists(cache)) return(readRDS(cache))
  if (!requireNamespace("GIFT", quietly = TRUE))
    stop("Package 'GIFT' is needed to download growth form, or pass a cached table to add_lifeform().")
  g <- GIFT::GIFT_traits(trait_IDs = "1.2.1", agreement = 0.66,
                         bias_ref = FALSE, bias_deriv = FALSE)
  if (!is.null(cache)) saveRDS(g, cache)
  g
}

#' Add growth form (lifeform) to a checklist
#'
#' Assigns each taxon a lifeform on a controlled vocabulary
#' (`fern`, `graminoid`, `tree`, `shrub`, `herb`, `unknown`), a natural
#' organising field for a flora. Growth form for seed plants comes from GIFT
#' (species match, else the modal value of the genus); ferns/lycophytes and
#' graminoids (Poaceae, Cyperaceae, Juncaceae, ...) are assigned from the clade,
#' overriding GIFT. A `lifeform_source` column records how each value was derived
#' (`gift-species`, `gift-genus`, `clade`, `none`).
#'
#' Growth form is a *typical* habit and can be plastic (e.g. *Metrosideros
#' polymorpha* ranges from prostrate shrub to tree); treat it as indicative.
#'
#' @param checklist A checklist from [build_checklist()] (needs `accepted_name`,
#'   `genus`, `family`, `class`).
#' @param growthform GIFT growth-form table from [gift_growthform()].
#' @return `checklist` with added `lifeform` and `lifeform_source` columns.
#' @seealso [add_status()] for the native/alien field.
#' @export
add_lifeform <- function(checklist, growthform) {
  vcol   <- grep("trait_value", names(growthform), value = TRUE)[1]
  ok     <- growthform[[vcol]] %in% c("herb", "shrub", "tree")
  sp_lut <- stats::setNames(growthform[[vcol]][ok], growthform$work_species[ok])
  gen    <- sub(" .*", "", growthform$work_species[ok])
  gen_lut <- tapply(growthform[[vcol]][ok], gen,
                    function(v) names(sort(table(v), decreasing = TRUE))[1])
  fern_cl  <- c("Polypodiopsida", "Lycopodiopsida", "Marattiopsida", "Psilotopsida", "Equisetopsida")
  gram_fam <- c("Poaceae", "Cyperaceae", "Juncaceae", "Restionaceae", "Typhaceae")

  sp <- checklist$accepted_name; gn <- checklist$genus
  fm <- checklist$family;        cl <- checklist$class
  lf  <- unname(sp_lut[sp]); src <- ifelse(!is.na(lf), "gift-species", NA_character_)
  na  <- is.na(lf)
  lf[na] <- unname(gen_lut[gn[na]]); src[na & !is.na(lf)] <- "gift-genus"
  g <- !is.na(fm) & fm %in% gram_fam; lf[g] <- "graminoid"; src[g] <- "clade"
  f <- !is.na(cl) & cl %in% fern_cl;  lf[f] <- "fern";      src[f] <- "clade"
  src[is.na(lf)] <- "none"; lf[is.na(lf)] <- "unknown"
  checklist$lifeform <- lf; checklist$lifeform_source <- src
  checklist
}
