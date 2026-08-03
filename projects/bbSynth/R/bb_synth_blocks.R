## bb_synth_blocks.R
## Synthetic block-structured two-way table (BB-ish ordinal values)

#' Generate a synthetic block-structured table
#'
#' Produces a species × site table with latent block structure.
#' Values are ordinal in [0, scale_max] (default 0..7) and biased so that
#' within-block presences are mostly 3..scale_max, while spillover/noise
#' uses mostly 1..2 (and occasional 3).
#'
#' Output is a raw data.frame with first column 'species' and site columns
#' named S01.. (or with a user-specified prefix), ready for bb_from_raw_data().
#'
#' @param n_species Number of species (rows). Default 20.
#' @param n_sites Number of sites (columns). Default 12.
#' @param n_row_groups Number of species groups (row blocks). Default 3.
#' @param n_col_groups Number of site groups (column blocks). Default 3.
#' @param scale_max Maximum ordinal value (default 7).
#' @param n_ubiq Integer. Number of ubiquitous species (default 2).
#' @param ubiq_presence_prob Probability a ubiquitous species is present at a site (default 0.85).
#' @param rare_frac Fraction of rare species (default 0.25).
#' @param bleed Spillover probability into adjacent site groups (default 0.10).
#' @param noise Background noise probability for low-level presences (default 0.05).
#' @param seed Optional integer seed for reproducibility.
#' @param site_prefix Site ID prefix (default "S").
#' @param species_prefix Species ID prefix (default "sp_").
#' @param verbose Diagnostic distribution data (default FALSE).
#' @return data.frame with first col 'species' and remaining cols as site IDs.
#' @export
bb_synth_blocks <- function(
    n_species = 20,
    n_sites = 12,
    n_row_groups = 3,
    n_col_groups = 3,
    scale_max = 7,
    n_ubiq = 2,
    ubiq_presence_prob = 0.85,
    rare_frac = 0.25,
    bleed = 0.10,
    noise = 0.05,
    seed = 1,
    site_prefix = "S",
    species_prefix = "sp_",
    verbose = FALSE
) {
  if (!is.null(seed)) set.seed(seed)

  ## Validate
  stopifnot(n_species >= 3, n_sites >= 3)
  stopifnot(n_row_groups >= 1, n_col_groups >= 1)
  stopifnot(scale_max >= 3)               ## because we use 3..scale_max for core signal
  stopifnot(n_ubiq >= 0 && n_ubiq <= n_species)
  stopifnot(ubiq_presence_prob >= 0 && ubiq_presence_prob <= 1)
  stopifnot(rare_frac >= 0 && rare_frac <= 1)
  stopifnot(bleed >= 0 && bleed <= 1)
  stopifnot(noise >= 0 && noise <= 1)

  ## IDs
  sites <- bb_make_site_ids(n_sites, site_prefix)
  species <- bb_make_species_ids(n_species, species_prefix)

  ## Assign each site to a site-group (balanced sequence)
  col_group <- rep(seq_len(n_col_groups), length.out = n_sites)

  ## Assign each species to a species-group (balanced sequence)
  row_group <- rep(seq_len(n_row_groups), length.out = n_species)

  ## Choose ubiquitous and rare species
  idx_all <- seq_len(n_species)
  n_ubiq_use <- min(n_ubiq, n_species)
  ubiq_idx <- if (n_ubiq_use > 0) sample(idx_all, n_ubiq_use) else integer(0)

  n_rare <- as.integer(round(n_species * rare_frac))
  rare_candidates <- setdiff(idx_all, ubiq_idx)
  n_rare_use <- min(n_rare, length(rare_candidates))
  rare_idx <- if (n_rare_use > 0) sample(rare_candidates, n_rare_use) else integer(0)

  ## Define ordinal value distributions
  ## Home block: mostly 3..scale_max, emphasizing mid-high values
  home_levels <- 3:scale_max
  home_prob <- rep(1, length(home_levels))
  home_prob[home_levels %in% c(4, 5, 6)] <- 3
  home_prob <- home_prob / sum(home_prob)

  ## Spillover: mostly 1..2, occasional 3
  spill_levels <- 1:3
  spill_prob <- c(0.55, 0.30, 0.15)

  ## Ubiquitous: moderate values 2..5
  ubiq_levels <- 2:min(5, scale_max)
  if (length(ubiq_levels) == 1) {
    ubiq_prob <- 1
  } else {
    ## emphasize middle of 2..5
    ubiq_prob <- rep(1, length(ubiq_levels))
    if (2 %in% ubiq_levels) ubiq_prob[ubiq_levels == 2] <- 1
    if (3 %in% ubiq_levels) ubiq_prob[ubiq_levels == 3] <- 3
    if (4 %in% ubiq_levels) ubiq_prob[ubiq_levels == 4] <- 3
    if (5 %in% ubiq_levels) ubiq_prob[ubiq_levels == 5] <- 1
    ubiq_prob <- ubiq_prob / sum(ubiq_prob)
  }

  ## Initialize matrix
  X <- matrix(0L, nrow = n_species, ncol = n_sites,
              dimnames = list(species, sites))

  ## Build each species row
  for (i in seq_len(n_species)) {

    ## U species: present in most sites with moderate values
    if (i %in% ubiq_idx) {
      present <- bb_rbern(n_sites, p = ubiq_presence_prob)
      vals <- rep(0L, n_sites)
      if (sum(present) > 0) {
        vals[present == 1] <- sample(ubiq_levels, sum(present), replace = TRUE, prob = ubiq_prob)
      }
      ## enforce at least one presence
      if (sum(vals > 0) == 0) {
        j <- sample(seq_len(n_sites), 1)
        vals[j] <- sample(ubiq_levels, 1, prob = ubiq_prob)
      }
      X[i, ] <- vals
      next
    }

    ## Rare species: 1–2 presences, mostly 1 (occasionally 2)
    if (i %in% rare_idx) {
      vals <- rep(0L, n_sites)
      k <- sample(1:2, 1, prob = c(0.75, 0.25))
      pos <- sample(seq_len(n_sites), k)
      vals[pos] <- sample(1:2, k, replace = TRUE, prob = c(0.85, 0.15))
      X[i, ] <- vals
      next
    }

    ## Differential species: strong in home group, low spill/noise elsewhere
    rg <- row_group[i]
    home_cg <- ((rg - 1) %% n_col_groups) + 1

    vals <- rep(0L, n_sites)

    for (j in seq_len(n_sites)) {
      cg <- col_group[j]
      is_home <- (cg == home_cg)
      is_adjacent <- (cg == home_cg - 1) || (cg == home_cg + 1)

      if (is_home) {
        vals[j] <- sample(home_levels, 1, prob = home_prob)

      } else if (is_adjacent && bb_rbern(1, bleed) == 1) {
        vals[j] <- sample(spill_levels, 1, prob = spill_prob)

      } else if (bb_rbern(1, noise) == 1) {
        vals[j] <- sample(1:2, 1, prob = c(0.85, 0.15))
      }
    }

    ## Enforce at least one presence for differential species
    if (sum(vals > 0) == 0) {
      home_sites <- which(col_group == home_cg)
      j <- sample(home_sites, 1)
      vals[j] <- sample(home_levels, 1, prob = home_prob)
    }

    X[i, ] <- vals
  }

  ## Final safety: prevent all-zero rows (should be redundant, but safe)
  zero_rows <- which(rowSums(X) == 0)
  if (length(zero_rows) > 0) {
    for (i in zero_rows) {
      j <- sample(seq_len(n_sites), 1)
      X[i, j] <- 1L
    }
  }

  ## Return raw_data
  raw_data <- data.frame(species = species, X, check.names = FALSE)

  if (isTRUE(verbose)) {
    cat("\nValue distribution (0..", scale_max, "):\n", sep = "")
    print(table(factor(unlist(X), levels = 0:scale_max)))

    cat("\nRow diagnostics:\n")
    cat("  All-zero rows:", sum(rowSums(X) == 0), "\n")

    if (exists("rare_idx")) {
      cat("  Rare species:", length(rare_idx), "\n")
    }
    if (exists("ubiq_idx")) {
      cat("  Ubiquitous species:", length(ubiq_idx), "\n")
    }
    cat("\n")
  }

  raw_data
}
