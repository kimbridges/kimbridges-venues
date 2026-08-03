#' Arrange a sorted two-way table from differential groups
#'
#' Assembles the sorted two-way table COENOS produced: species arranged by the
#' differential group they belong to, relevés arranged so that relevés sharing a
#' group signature stand together, and the ungrouped species gathered below.
#' This is the final step of the COENOS pipeline, run on the output of
#' [form_groups()].
#'
#' @details
#' The ordering follows the reciprocal-averaging construction described in the
#' COENOS help file. Each relevé is given a *signature* -- the set of groups
#' whose relevé-set it belongs to. An *asterisk table* of species groups (rows)
#' by distinct signatures (columns) is built, and correspondence analysis
#' (reciprocal averaging) is run on it. The first axis orders the groups; the
#' relevés are then ordered by their signature's axis scores, ties broken by the
#' second axis and then by relevé number, with signature-less relevés placed
#' last.
#'
#' Species are ordered by group, in that same group order, and within each group
#' by decreasing constancy. Ungrouped species follow, also by decreasing
#' constancy, so high-constancy companions come first and the low-constancy
#' footnote species last. The order among species of *equal* constancy within a
#' group is a fine detail that did not survive in the original program; it is
#' broken here by first-appearance order, deterministically.
#'
#' Correspondence-analysis axes are defined only up to sign, so a table and its
#' left-right reflection are phytosociologically identical. By default the
#' orientation places the first-formed (largest) group at the left; set
#' `reflect = TRUE` to flip it.
#'
#' @param x A `coenos_groups` object from [form_groups()].
#' @param cover Logical. If `TRUE` (default) cells carry the recorded cover
#'   value; if `FALSE` they carry `"x"` for presence. Absent cells are `""`.
#' @param reflect Logical. Flip the relevé/group ordering left-to-right.
#'   Default `FALSE`.
#'
#' @return A `coenos_table`: a data frame with a `species` column followed by
#'   the relevés in sorted order. The per-species block label (`"1"`, `"2"`,
#'   ..., `"companion"`, `"rare"`), the group order, and the relevé order are
#'   attached as attributes `block`, `group_order`, and `releve_order`.
#'
#' @seealso [form_groups()], [classify_species()]
#'
#' @examples
#' rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
#' tab <- coenos_table(form_groups(rel))
#' tab
#'
#' @export
coenos_table <- function(x, cover = TRUE, reflect = FALSE) {
  if (!inherits(x, "coenos_groups")) {
    stop("`x` must be a coenos_groups object from form_groups().", call. = FALSE)
  }
  rel <- attr(x, "rel")
  releves <- levels(rel$releve)
  species <- levels(rel$species)
  con <- constancy(rel, sort = FALSE)
  con_v <- stats::setNames(con$constancy, as.character(con$species))

  ## --- group order via reciprocal averaging on the asterisk table ----------
  ng <- length(x)
  ## each relevé's signature: which groups' relevé-sets contain it
  sig <- lapply(releves, function(r) which(vapply(x, function(g) r %in% g$releves, logical(1))))
  names(sig) <- releves
  sig_key <- vapply(sig, function(s) paste(s, collapse = "."), character(1))

  group_order <- seq_len(ng)
  g_axis1 <- rep(0, ng); g_axis2 <- rep(0, ng)
  type_keys <- unique(sig_key[sig_key != ""])
  if (ng >= 2L && length(type_keys) >= 2L) {
    ## asterisk table: groups (rows) x signature-types (columns)
    A <- vapply(type_keys, function(k) {
      gs <- as.integer(strsplit(k, ".", fixed = TRUE)[[1]])
      as.numeric(seq_len(ng) %in% gs)
    }, numeric(ng))
    A <- matrix(A, nrow = ng, dimnames = list(NULL, type_keys))
    keep <- rowSums(A) > 0 & TRUE
    ca <- .coenos_ca(A)
    g_axis1 <- ca$row[, 1]; g_axis2 <- ca$row[, 2]
    t_axis1 <- stats::setNames(ca$col[, 1], type_keys)
    t_axis2 <- stats::setNames(ca$col[, 2], type_keys)
    ## orient so the first-formed (largest) group leads at the left
    if (xor(g_axis1[1] > stats::median(g_axis1), reflect)) {
      g_axis1 <- -g_axis1; t_axis1 <- -t_axis1
    }
    group_order <- order(g_axis1, g_axis2)
  } else {
    t_axis1 <- stats::setNames(rep(0, length(type_keys)), type_keys)
    t_axis2 <- t_axis1
    if (reflect) group_order <- rev(group_order)
  }

  ## --- relevé order ----------------------------------------------------------
  rel_a1 <- ifelse(sig_key == "", Inf, t_axis1[sig_key])
  rel_a2 <- ifelse(sig_key == "", Inf, t_axis2[sig_key])
  rel_num <- match(releves, releves)
  releve_order <- releves[order(rel_a1, rel_a2, rel_num)]

  ## --- species order ---------------------------------------------------------
  grouped <- character(0); block <- character(0)
  for (gi in group_order) {
    sp <- x[[gi]]$species
    sp <- sp[order(-con_v[sp], match(sp, species))]   # decreasing constancy, then first-appearance
    grouped <- c(grouped, sp)
    block <- c(block, rep(as.character(gi), length(sp)))
  }
  ungrouped <- setdiff(species, grouped)
  ungrouped <- ungrouped[order(-con_v[ungrouped], match(ungrouped, species))]
  ub <- ifelse(con_v[ungrouped] < 3L, "rare", "companion")
  species_order <- c(grouped, ungrouped)
  block_all <- c(block, ub)

  ## --- assemble the wide table ----------------------------------------------
  cell <- if (cover) as.character(rel$cover) else rep("x", nrow(rel))
  cmap <- stats::setNames(cell, paste(rel$species, rel$releve, sep = "\r"))
  mat <- vapply(releve_order, function(r) {
    unname(mapvalues_default(cmap[paste(species_order, r, sep = "\r")], ""))
  }, character(length(species_order)))
  out <- data.frame(species = species_order, mat, check.names = FALSE,
                    stringsAsFactors = FALSE)
  names(out)[-1] <- releve_order

  structure(out, class = c("coenos_table", "data.frame"),
            block = block_all, group_order = group_order,
            releve_order = releve_order,
            groups = lapply(seq_along(x), function(i)
              list(species = x[[i]]$species, releves = x[[i]]$releves)),
            row.names = seq_along(species_order))
}

## replace NA with a default (small local helper, avoids a dependency)
mapvalues_default <- function(v, default) {
  v[is.na(v)] <- default
  v
}

## Correspondence analysis (reciprocal averaging) of a table; returns the first
## two non-trivial axis scores for rows and columns.
.coenos_ca <- function(N) {
  P <- N / sum(N)
  r <- rowSums(P); c <- colSums(P)
  S <- diag(1 / sqrt(r)) %*% (P - outer(r, c)) %*% diag(1 / sqrt(c))
  sv <- svd(S)
  k <- min(2L, ncol(sv$u))
  row <- diag(1 / sqrt(r)) %*% sv$u[, seq_len(k), drop = FALSE]
  col <- diag(1 / sqrt(c)) %*% sv$v[, seq_len(k), drop = FALSE]
  if (k < 2L) { row <- cbind(row, 0); col <- cbind(col, 0) }
  list(row = row, col = col)
}

#' @export
print.coenos_table <- function(x, ...) {
  blk <- attr(x, "block")
  cat(sprintf("<coenos_table>  %d species x %d releves\n",
              nrow(x), ncol(x) - 1L))
  bt <- blk[!blk %in% c("companion", "rare")]
  cat(sprintf("  groups: %d  |  companions: %d  |  footnote: %d\n",
              length(unique(bt)), sum(blk == "companion"), sum(blk == "rare")))
  print.data.frame(utils::head(as.data.frame(x), 12), ...)
  if (nrow(x) > 12) cat(sprintf("  ... %d more species\n", nrow(x) - 12))
  invisible(x)
}
