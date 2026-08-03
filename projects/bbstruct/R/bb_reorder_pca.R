## bb_reorder_pca.R
## PCA-based reorder with optional fixed site/species order

bb_reorder_pca <- function(
    bb,
    reorder_sites = TRUE,
    reorder_species = TRUE,
    center = TRUE,
    scale. = FALSE,
    ...
) {
  bb_validate(bb)
  
  X <- bb$x
  stopifnot(is.matrix(X), is.numeric(X))
  
  ## ---- Determine site order ----
  if (isTRUE(reorder_sites)) {
    ## PCA on sites: make sites the "observations"
    pc_c <- stats::prcomp(t(X), center = center, scale. = scale.)
    s_c <- pc_c$x[, 1]
    
    ## Stable tie-break on site names
    site_order <- order(s_c, colnames(X))
  } else {
    site_order <- seq_len(ncol(X))
  }
  
  ## Apply site ordering (or keep fixed)
  X2 <- X[, site_order, drop = FALSE]
  
  ## ---- Determine species order ----
  if (isTRUE(reorder_species)) {
    ## PCA on species (rows), after site order has been applied/fixed
    pc_r <- stats::prcomp(X2, center = center, scale. = scale.)
    s_r <- pc_r$x[, 1]
    
    ## Stable tie-break on species names
    species_order <- order(s_r, rownames(X2))
  } else {
    species_order <- seq_len(nrow(X2))
  }
  
  ## Build reordered bb_tbl
  bb2 <- bb
  bb2$x <- X2[species_order, , drop = FALSE]
  bb2$species <- rownames(bb2$x)
  bb2$sites <- colnames(bb2$x)
  
  list(
    bb = bb2,
    species_order = species_order,
    site_order = site_order,
    diagnostics = list(
      method = "pca",
      note = "PCA ordering (PC1)",
      reorder_sites = reorder_sites,
      reorder_species = reorder_species,
      center = center,
      scale = scale.
    )
  )
}

