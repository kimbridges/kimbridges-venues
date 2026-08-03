## bb_synth_gradient.R
## Synthetic gradient-structured two-way table (BB-ish ordinal values)

#' Generate a synthetic gradient table (BB-ish ordinal values)
#'
#' Produces a species × site table with latent 1D gradient structure.
#' Values are ordinal in [0, scale_max] (default 0..7). Core presences are
#' biased toward 3..scale_max. Values 1..2 are used primarily for rare species,
#' outliers, and tails.
#'
#' Output is a raw data.frame with first column 'species' and site columns
#' named S01.. (or user-specified prefix), ready for bb_from_raw_data().
#'
#' @param n_species Number of species (rows). Default 20.
#' @param n_sites Number of sites (columns). Default 12.
#' @param scale_max Maximum ordinal value (default 7).
#' @param steepness Controls turnover sharpness (higher -> narrower peaks). Default 1.0.
#' @param plateau_frac Fraction of non-rare species that are plateau-like. Default 0.25.
#' @param disjunct_frac Fraction of non-rare species that are disjunct (two peaks). Default 0.10.
#' @param rare_frac Fraction of rare species. Default 0.30.
#' @param outlier_frac Fraction of non-rare species with one extra outlier presence. Default 0.10.
#' @param seed Optional integer seed for reproducibility.
#' @param site_prefix Site ID prefix (default "S").
#' @param species_prefix Species ID prefix (default "sp_").
#' @param verbose Diagnostic distribution data (default FALSE).
#' @return data.frame with first col 'species' and remaining cols as site IDs.
#' @export
bb_synth_gradient <- function(
    n_species = 20,
    n_sites = 12,
    scale_max = 7,
    steepness = 1.0,
    plateau_frac = 0.25,
    disjunct_frac = 0.10,
    rare_frac = 0.30,
    outlier_frac = 0.10,
    seed = 1,
    site_prefix = "S",
    species_prefix = "sp_",
    verbose = FALSE
    ) {
  if (!is.null(seed)) set.seed(seed)

  ## Validate
  stopifnot(n_species >= 3, n_sites >= 3)
  stopifnot(scale_max >= 5)  ## we want a meaningful 3..scale_max range
  stopifnot(steepness > 0)
  stopifnot(plateau_frac >= 0 && plateau_frac <= 1)
  stopifnot(disjunct_frac >= 0 && disjunct_frac <= 1)
  stopifnot(rare_frac >= 0 && rare_frac <= 1)
  stopifnot(outlier_frac >= 0 && outlier_frac <= 1)

  sites <- bb_make_site_ids(n_sites, site_prefix)
  species <- bb_make_species_ids(n_species, species_prefix)

  ## Site positions along gradient (0..1)
  t <- seq(0, 1, length.out = n_sites)

  ## Choose rare/disjunct sets
  idx_all <- seq_len(n_species)
  n_rare <- as.integer(round(n_species * rare_frac))
  rare_idx <- if (n_rare > 0) sample(idx_all, min(n_rare, n_species)) else integer(0)

  nonrare <- setdiff(idx_all, rare_idx)
  n_disj <- as.integer(round(length(nonrare) * disjunct_frac))
  disj_idx <- if (n_disj > 0) sample(nonrare, min(n_disj, length(nonrare))) else integer(0)

  ## Response bump helper
  bump <- function(t, mu, sigma, height) height * exp(-0.5 * ((t - mu) / sigma)^2)

  ## Discretization helper: map continuous y (0..scale_max) to ordinal 0..scale_max
  ## with bias: most nonzero values become 3..scale_max; 1..2 reserved for tails.
  y_to_ord <- function(y, scale_max) {
    ## clamp
    y <- pmax(0, pmin(scale_max, y))

    ## bins:
    ## Make 1 rare and 2 more common:
    ## 0: y < 1.7
    ## 1: 1.7..1.9   (very narrow)
    ## 2: 1.9..2.5   (wider)
    ## 3..scale_max: y >= 2.5
    out <- rep(0L, length(y))
    out[y >= 1.7 & y < 1.9] <- 1L
    out[y >= 1.9 & y < 2.5] <- 2L
    hi <- which(y >= 2.5)

    ## Map y >= 2.5 into 3..scale_max
    z <- (y[hi] - 2.5) / max(1e-9, (scale_max - 2.5))
    out[hi] <- as.integer(round(3 + z * (scale_max - 3)))
    out[hi] <- pmax(3L, pmin(as.integer(scale_max), out[hi]))

    out
  }

  ## Base matrix
  X <- matrix(0L, nrow = n_species, ncol = n_sites,
              dimnames = list(species, sites))

  ## Generate rows
  for (i in seq_len(n_species)) {

    ## Rare species: 1–2 presences, mostly 1 (occasionally 2)
    if (i %in% rare_idx) {
      vals <- rep(0L, n_sites)
      k <- sample(1:2, 1, prob = c(0.75, 0.25))
      pos <- sample(seq_len(n_sites), k)
      vals[pos] <- sample(1:2, k, replace = TRUE, prob = c(0.85, 0.15))
      X[i, ] <- vals
      next
    }

    ## Choose peak location and width
    mu <- runif(1, 0, 1)
    sigma <- max(0.08, 0.25 / steepness)

    ## Height biased high so core values land in 3..scale_max
    height <- runif(1, 0.75, 1.0) * scale_max

    y <- bump(t, mu, sigma, height)

    ## Plateau species: flatten top
    if (runif(1) < plateau_frac) {
      y <- pmin(y, runif(1, 0.65, 0.85) * scale_max)
    }

    ## Disjunct species: add second bump far away
    if (i %in% disj_idx) {
      mu2 <- (mu + runif(1, 0.35, 0.6)) %% 1
      y <- y + bump(t, mu2, sigma * 0.9, height * runif(1, 0.55, 0.75))
      y <- pmin(y, scale_max)
    }

    ## Add mild noise (kept small to avoid creating many 1–2s)
    y <- y + stats::rnorm(n_sites, mean = 0, sd = 0.15)

    ## Discretize with BB bias
    vals <- y_to_ord(y, scale_max)

    ## Enforce: if species is non-rare, it should have at least one presence >=3
    if (max(vals, na.rm = TRUE) < 3) {
      j <- which.max(y)
      vals[j] <- sample(3:scale_max, 1, prob = {
        p <- rep(1, length(3:scale_max))
        if (4 %in% 3:scale_max) p[which(3:scale_max == 4)] <- 3
        if (5 %in% 3:scale_max) p[which(3:scale_max == 5)] <- 3
        p / sum(p)
      })
    }

    X[i, ] <- vals
  }

  ## Outlier presences (“friends”): add a low (1–2) presence in a zero cell
  n_out <- as.integer(round(outlier_frac * length(nonrare)))
  if (n_out > 0) {
    out_species <- sample(nonrare, min(n_out, length(nonrare)))
    for (i in out_species) {
      zero_pos <- which(X[i, ] == 0)
      if (length(zero_pos) > 0) {
        j <- sample(zero_pos, 1)
        X[i, j] <- sample(1:2, 1, prob = c(0.85, 0.15))
      }
    }
  }

  ## Safety: no all-zero rows
  zero_rows <- which(rowSums(X) == 0)
  if (length(zero_rows) > 0) {
    for (i in zero_rows) {
      j <- sample(seq_len(n_sites), 1)
      X[i, j] <- 1L
    }
  }

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
