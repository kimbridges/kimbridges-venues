## ============================================================
## Synthetic block-structured table (12 sites x 24 species)
## Exports CSV in display order for documentation rendering.
## ============================================================

## ---- packages ----
suppressPackageStartupMessages({
  library(tidyverse)
})

## ---- settings ----
set.seed(20251215)

out_dir <- "data"   ## adjust if you prefer "data/" or "data-raw/output/"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

n_sites   <- 12
n_species <- 24

## Define block structure:
##  - 3 site groups of 4 sites each
##  - 3 species groups of 7 species each (21 species)
##  - 3 "background" species (cosmopolitan / low frequency) to soften perfection
site_groups   <- rep(c("S1", "S2", "S3"), each = 4)              ## length 12
species_groups <- c(rep(c("S1","S2","S3"), each = 7), rep("BG", 3))  ## length 24

site_ids   <- sprintf("Site_%02d", 1:n_sites)
species_ids <- sprintf("Sp_%02d", 1:n_species)

## ---- helper: generate ordinal BB-like values ----
## Values are integers 0..5 (0 = absent, 1..5 increasing cover/abundance)
## We'll generate by group-specific probability and then map to ordinal values.
make_bb_values <- function(n, p_present, probs_when_present) {
  present <- rbinom(n, size = 1, prob = p_present)
  vals <- integer(n)
  if (any(present == 1)) {
    vals[present == 1] <- sample(
      x = 1:5,
      size = sum(present == 1),
      replace = TRUE,
      prob = probs_when_present
    )
  }
  vals
}

## ---- generate matrix ----
## Strong within-block presence; weak off-block presence; BG species modest everywhere.
## You can tune these three knobs if needed:
p_in_block  <- 0.95
p_off_block <- 0.25
p_bg        <- 0.60

## When present, distribution over 1..5 (skewed moderate-high in block)
probs_in_block  <- c(0.05, 0.10, 0.25, 0.30, 0.30)
probs_off_block <- c(0.55, 0.25, 0.12, 0.06, 0.02)
probs_bg        <- c(0.40, 0.25, 0.18, 0.10, 0.07)

mat <- matrix(0L, nrow = n_species, ncol = n_sites,
              dimnames = list(species_ids, site_ids))

for (i in seq_len(n_species)) {
  sp_grp <- species_groups[i]
  
  ## Fill the whole row first
  for (j in seq_len(n_sites)) {
    st_grp <- site_groups[j]
    
    if (sp_grp == "BG") {
      mat[i, j] <- make_bb_values(1, p_present = p_bg, probs_when_present = probs_bg)
    } else {
      same_block <- (sp_grp == st_grp)  ## G1 aligns with S1, etc.
      if (same_block) {
        mat[i, j] <- make_bb_values(1, p_present = p_in_block, probs_when_present = probs_in_block)
      } else {
        mat[i, j] <- make_bb_values(1, p_present = p_off_block, probs_when_present = probs_off_block)
      }
    }
  }
  
  ## Now enforce: at least one occurrence per species row
  if (sum(mat[i, ]) == 0) {
    if (sp_grp == "BG") {
      j_fix <- sample(seq_len(n_sites), 1)
    } else {
      j_fix <- which(site_groups == sp_grp)[1]
    }
    mat[i, j_fix] <- sample(1:3, 1)
  }
}

min_richness <- 15

for (j in seq_len(n_sites)) {
  safety <- 0L
  while (sum(mat[, j] > 0) < min_richness) {
    safety <- safety + 1L
    if (safety > 5000L) stop("min_richness loop did not converge; check constraints.")
    
    target_group <- site_groups[j]
    
    ## Prefer adding species from the matching block that are still absent in this site
    in_block_absent <- which(species_groups == target_group & mat[, j] == 0)
    
    if (length(in_block_absent) > 0) {
      i_fix <- sample(in_block_absent, 1)
    } else {
      ## Fallback: add any absent species (including BG / other blocks)
      any_absent <- which(mat[, j] == 0)
      if (length(any_absent) == 0) break
      i_fix <- sample(any_absent, 1)
    }
    
    mat[i_fix, j] <- sample(1:3, 1)
  }
}



## ---- build tidy + wide for export ----
tbl_wide <- as_tibble(mat, rownames = "species")

## Add a light label row for site group (optional; you may omit for the doc table)
## We'll export metadata separately instead of embedding it in the main CSV.
site_meta <- tibble(
  site = site_ids,
  site_group = site_groups
)

species_meta <- tibble(
  species = species_ids,
  species_group = species_groups
)

## ---- export ----
block_csv <- file.path(out_dir, "synthetic_block_12x24.csv")
write_csv(tbl_wide, block_csv)

write_csv(site_meta,    file.path(out_dir, "synthetic_block_12x24_sites.csv"))
write_csv(species_meta, file.path(out_dir, "synthetic_block_12x24_species.csv"))

message("Wrote: ", block_csv)

## ============================================================
## Synthetic gradient-structured table (12 sites x 24 species)
## Exports CSV in display order for documentation rendering.
## ============================================================

suppressPackageStartupMessages({
  library(tidyverse)
})

set.seed(20251215)

out_dir <- "data"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

n_sites   <- 12
n_species <- 24

site_ids   <- sprintf("Site_%02d", 1:n_sites)
species_ids <- sprintf("Sp_%02d", 1:n_species)

x <- seq_len(n_sites)  ## gradient coordinate

## ---- role design ----
roles <- c(rep("early", 6),
           rep("mid", 6),
           rep("late", 6),
           rep("ubiq", 3),
           rep("rare", 3))

## Randomize within role so Sp_01..Sp_24 isn't too “perfect”
roles <- unlist(lapply(split(roles, roles), sample), use.names = FALSE)

species_meta <- tibble(
  species = species_ids,
  role = roles
)

## ---- response curves ----
gauss <- function(x, mu, sigma, amp = 1) amp * exp(-0.5 * ((x - mu) / sigma)^2)

## knobs
sigma_band <- 2.8       ## wider -> more overlap / smoother gradient
p_floor    <- 0.08      ## baseline chance everywhere (prevents harsh cutoffs)
p_ubiq     <- 0.70      ## ubiquitous presence probability
p_rare     <- 0.12      ## rare presence probability

## ---- abundance draw ----
make_bb_values <- function(n, p_present, probs_when_present) {
  present <- rbinom(n, size = 1, prob = p_present)
  vals <- integer(n)
  if (any(present == 1)) {
    vals[present == 1] <- sample(1:5, size = sum(present == 1), replace = TRUE,
                                 prob = probs_when_present)
  }
  vals
}

probs_band <- c(0.10, 0.15, 0.25, 0.25, 0.25)   ## when present in band
probs_ubiq <- c(0.25, 0.25, 0.20, 0.18, 0.12)   ## ubiquitous usually moderate
probs_rare <- c(0.65, 0.20, 0.10, 0.04, 0.01)   ## rare mostly low when present

## ---- generate matrix ----
mat <- matrix(0L, nrow = n_species, ncol = n_sites,
              dimnames = list(species_ids, site_ids))

for (i in seq_len(n_species)) {
  role <- roles[i]
  
  ## pick peak location for this species based on role
  mu <- switch(role,
               early = runif(1, 2.0, 4.0),
               mid   = runif(1, 5.0, 8.0),
               late  = runif(1, 9.0, 11.0),
               ubiq  = NA_real_,
               rare  = NA_real_
  )
  
  ## presence probability across sites
  p_vec <- switch(role,
                  early = pmin(0.98, p_floor + gauss(x, mu = mu, sigma = sigma_band, amp = 0.85)),
                  mid   = pmin(0.98, p_floor + gauss(x, mu = mu, sigma = sigma_band, amp = 0.85)),
                  late  = pmin(0.98, p_floor + gauss(x, mu = mu, sigma = sigma_band, amp = 0.85)),
                  ubiq  = rep(p_ubiq, n_sites),
                  rare  = rep(p_rare, n_sites)
  )
  
  ## generate row
  for (j in seq_len(n_sites)) {
    if (role %in% c("early","mid","late")) {
      mat[i, j] <- make_bb_values(1, p_present = p_vec[j], probs_when_present = probs_band)
    } else if (role == "ubiq") {
      mat[i, j] <- make_bb_values(1, p_present = p_vec[j], probs_when_present = probs_ubiq)
    } else {
      mat[i, j] <- make_bb_values(1, p_present = p_vec[j], probs_when_present = probs_rare)
    }
  }
  
  ## ensure at least one occurrence per species
  if (sum(mat[i, ]) == 0) {
    j_fix <- sample(seq_len(n_sites), 1)
    mat[i, j_fix] <- sample(1:3, 1)
  }
}

## ---- enforce minimum richness per site (safe) ----
min_richness <- 10

for (j in seq_len(n_sites)) {
  safety <- 0L
  while (sum(mat[, j] > 0) < min_richness) {
    safety <- safety + 1L
    if (safety > 5000L) stop("min_richness loop did not converge; check constraints.")
    
    absent <- which(mat[, j] == 0)
    if (length(absent) == 0) break
    
    ## bias: add band species more often than rare
    weights <- ifelse(roles[absent] == "rare", 0.3,
                      ifelse(roles[absent] == "ubiq", 0.8, 1.0))
    i_fix <- sample(absent, size = 1, prob = weights)
    
    mat[i_fix, j] <- sample(1:3, 1)
  }
}

tbl_wide <- as_tibble(mat, rownames = "species")

## ---- export ----
gradient_csv <- file.path(out_dir, "synthetic_gradient_12x24.csv")
write_csv(tbl_wide, gradient_csv)
write_csv(species_meta, file.path(out_dir, "synthetic_gradient_12x24_species.csv"))

message("Wrote: ", gradient_csv)

