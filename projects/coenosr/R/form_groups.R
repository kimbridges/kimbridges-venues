#' Form differential species groups
#'
#' Forms differential species--relevé groups from a two-way table, the central
#' step COENOS performed. The engine implements the published density-block
#' method of Bruelheide & Flintrop (1994) together with the *outside criterion*
#' of Ceska & Roemer (1971), the rule that distinguishes the COENOS approach.
#'
#' @details
#' The search is the masking method of Bruelheide & Flintrop (1994). Starting
#' from the full table of *eligible* species (see [classify_species()]), it
#' repeatedly removes the species or relevé of lowest density -- the fraction of
#' the current submatrix it occupies -- until every remaining row and column
#' exceeds the threshold `x`. The dense submatrix that remains is a block. Its
#' species are then eliminated and the search repeats on the rest, yielding
#' groups of gradually decreasing size.
#'
#' To this Bruelheide block the *outside criterion* of Ceska & Roemer is
#' applied: a species is kept in the group only if it occurs in at most
#' `ceiling(y * n)` of the relevés *outside* the block, where `n` is the total
#' number of relevés. This is the rule Bruelheide & Flintrop explicitly omit,
#' and the one Mueller-Dombois & Ellenberg (1974) name as Rule I of the COENOS
#' algorithm. It is what makes a group *differential* -- present inside, largely
#' absent outside -- rather than merely dense.
#'
#' The masking search is deterministic and, unlike a seed-and-grow refinement,
#' cannot bloom: it only ever *removes* species, never re-admits them from the
#' full pool. This is why it succeeds where a literal alternation of the two
#' rules does not. The price is fidelity: the engine reproduces COENOS's
#' strong, well-separated groups exactly, but recovers the subtler differential
#' groups only approximately, because COENOS's exact group boundaries depended
#' on an internal tie-break and seed order that were never published and did not
#' survive in the compiled program. See the package vignette for the quantified
#' comparison against the original COENOS output.
#'
#' COENOS used three threshold levels in turn -- 40/10, 50/20, and 66/33 for
#' `x`/`y` as percentages -- choosing a level per group. `form_groups()` forms
#' groups at a single level; pass `x` and `y` to select it. The default,
#' `x = 0.5`, `y = 0.2`, is the middle level.
#'
#' @param rel A `coenos_rel` table from [read_rel()].
#' @param x Inside threshold, the minimum within-block density a species or
#'   relevé must exceed, as a fraction. Default `0.5`.
#' @param y Outside threshold, the maximum fraction of outside relevés a group
#'   species may occupy. Default `0.2`.
#' @param min_species Minimum species for a group to be reported. Default `4`.
#' @param min_releves Minimum relevés for a group to be reported. Default `2`.
#'
#' @return A `coenos_groups` object: a list of groups, each a list with
#'   character vectors `species` and `releves`. The source table and the
#'   thresholds are attached as attributes.
#'
#' @references
#' Bruelheide, H. & Flintrop, T. (1994) Arranging phytosociological tables by
#' species--relevé groups. *Journal of Vegetation Science* 5: 311--316.
#'
#' Ceska, A. & Roemer, H. (1971) A computer program for identifying
#' species--relevé groups in vegetation studies. *Vegetatio* 23: 255--277.
#'
#' Mueller-Dombois, D. & Ellenberg, H. (1974) *Aims and Methods of Vegetation
#' Ecology.* Wiley, New York.
#'
#' @seealso [classify_species()], [read_rel()]
#'
#' @examples
#' rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
#' g <- form_groups(rel)
#' g
#'
#' @export
form_groups <- function(rel, x = 0.5, y = 0.2,
                        min_species = 4L, min_releves = 2L) {
  if (!inherits(rel, "coenos_rel")) {
    stop("`rel` must be a coenos_rel table from read_rel().", call. = FALSE)
  }
  if (x <= 0 || x >= 1 || y < 0 || y >= 1) {
    stop("`x` must be in (0, 1) and `y` in [0, 1).", call. = FALSE)
  }

  ## presence matrix: species (rows) by relevé (columns)
  M <- table(rel$species, rel$releve) > 0
  n <- ncol(M)

  ## COENOS trims the ubiquitous and rare species before forming groups; the
  ## masking search runs on the eligible species only.
  cl <- classify_species(rel)
  elig <- as.character(cl$species[cl$status == "eligible"])

  ## extract dense blocks by masking, then keep only differential species
  blocks <- .coenos_blocks(M[elig, , drop = FALSE], x)
  groups <- list()
  for (b in blocks) {
    outside_cols <- setdiff(colnames(M), b$releves)
    ## outside criterion: a kept species sits in <= ceiling(y * n) outside relevés
    keep <- b$species[vapply(b$species, function(s) {
      sum(M[s, outside_cols]) <= ceiling(y * n)
    }, logical(1))]
    if (length(keep) >= min_species && length(b$releves) >= min_releves) {
      groups[[length(groups) + 1L]] <- list(
        species = sort(keep),
        releves = sort(b$releves)
      )
    }
  }

  structure(
    groups,
    class = "coenos_groups",
    rel = rel, x = x, y = y,
    min_species = min_species, min_releves = min_releves
  )
}

## Extract dense blocks from a presence matrix by the Bruelheide masking search.
## Returns a list of blocks, each list(species, releves), of decreasing size.
.coenos_blocks <- function(M, thr) {
  blocks <- list()
  avail_sp <- rownames(M)
  repeat {
    b <- .mask_block(M[avail_sp, , drop = FALSE], thr)
    if (is.null(b) || length(b$species) < 2L || length(b$releves) < 2L) break
    blocks[[length(blocks) + 1L]] <- b
    avail_sp <- setdiff(avail_sp, b$species)   # eliminate this block, search the rest
    if (length(avail_sp) < 2L) break
  }
  blocks
}

## Mask the lowest-density species/relevé until all densities exceed thr.
## Tie-break (Bruelheide & Flintrop): smallest density first; among ties take the
## one furthest down (species) or right (relevé); a species before a relevé.
.mask_block <- function(M, thr) {
  asp <- rep(TRUE, nrow(M))
  arl <- rep(TRUE, ncol(M))
  repeat {
    si <- which(asp); rj <- which(arl)
    if (length(si) < 2L || length(rj) < 2L) return(NULL)
    sub <- M[si, rj, drop = FALSE]
    dsp <- rowSums(sub) / length(rj)   # species density within the submatrix
    drl <- colSums(sub) / length(si)   # relevé density within the submatrix
    if (all(dsp > thr) && all(drl > thr)) break
    msp <- min(dsp); mrl <- min(drl)
    if (msp <= mrl) {
      asp[max(si[dsp == msp])] <- FALSE   # mask the weakest species
    } else {
      arl[max(rj[drl == mrl])] <- FALSE   # mask the weakest relevé
    }
  }
  list(species = rownames(M)[asp], releves = colnames(M)[arl])
}

#' @export
print.coenos_groups <- function(x, ...) {
  xx <- attr(x, "x"); yy <- attr(x, "y")
  cat(sprintf("<coenos_groups>  %d group%s at level %.0f/%.0f\n",
              length(x), if (length(x) == 1L) "" else "s", xx * 100, yy * 100))
  if (length(x) == 0L) {
    cat("  (no groups met the size thresholds)\n")
    return(invisible(x))
  }
  for (i in seq_along(x)) {
    cat(sprintf("  group %d: %d species x %d releves -- %s\n",
                i, length(x[[i]]$species), length(x[[i]]$releves),
                paste(x[[i]]$species, collapse = ", ")))
  }
  invisible(x)
}
