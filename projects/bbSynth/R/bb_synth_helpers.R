## bb_synth_helpers.R
## Utilities shared by bbSynth generators

## Make compact site IDs: S01, S02, ...
bb_make_site_ids <- function(n_sites = 12, site_prefix = "S") {
  stopifnot(n_sites >= 1)
  width <- nchar(as.character(n_sites))
  paste0(site_prefix, stringr::str_pad(seq_len(n_sites), width = width, pad = "0"))
}

## Make species IDs: sp_01, sp_02, ...
bb_make_species_ids <- function(n_species = 20, species_prefix = "sp_") {
  stopifnot(n_species >= 1)
  width <- nchar(as.character(n_species))
  paste0(species_prefix, stringr::str_pad(seq_len(n_species), width = width, pad = "0"))
}

## Clamp numeric to [0, scale_max] then round to integer
bb_clamp_round <- function(x, scale_max = 7) {
  x <- pmax(0, pmin(scale_max, x))
  as.integer(round(x))
}

## Simple Bernoulli sampler helper
bb_rbern <- function(n, p) stats::rbinom(n = n, size = 1, prob = p)
