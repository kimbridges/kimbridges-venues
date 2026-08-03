## bb_reorder_blind.R
## Baseline blind reorder (v0): deterministic and simple

bb_reorder_blind <- function(bb, ...) {
  bb_validate(bb)
  
  X <- bb$x
  stopifnot(is.matrix(X), is.numeric(X))
  
  ## Column order: descending column sums (stable tie-breaker)
  cs <- colSums(X, na.rm = TRUE)
  site_order <- order(cs, colnames(X), decreasing = TRUE)
  
  ## Row order: descending row sums after column ordering (stable tie-breaker)
  X2 <- X[, site_order, drop = FALSE]
  rs <- rowSums(X2, na.rm = TRUE)
  species_order <- order(rs, rownames(X2), decreasing = TRUE)
  
  bb2 <- bb
  bb2$x <- X2[species_order, , drop = FALSE]
  bb2$species <- rownames(bb2$x)
  bb2$sites <- colnames(bb2$x)
  
  list(
    bb = bb2,
    species_order = species_order,
    site_order = site_order,
    diagnostics = list(method = "blind", note = "baseline sum-ordering")
  )
}
