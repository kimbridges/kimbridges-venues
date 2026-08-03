# Vegetation Profile System - Version 3
# Central leaders, multi-stem shrubs, refined scattered fill

library(ggplot2)
library(dplyr)

# Source previous work
# source('vegetation_profile_core.R')
# source('branching_refined.R')

# =============================================================================
# CENTRAL LEADER FUNCTIONS
# =============================================================================

#' Generate a central leader line through the crown
#' 
#' @param trunk_x X position
#' @param crown_base_y Y of crown base
#' @param crown_top_y Y of crown top (or apex)
#' @param taper If TRUE, leader gets thinner toward top
#' @return Data frame with segment(s) for the leader
make_central_leader <- function(trunk_x, crown_base_y, crown_top_y, 
                                 n_segments = 1) {
  
  if (n_segments == 1) {
    return(data.frame(
      x = trunk_x,
      y = crown_base_y,
      xend = trunk_x,
      yend = crown_top_y,
      is_leader = TRUE,
      generation = 0
    ))
  }
  
  # Multiple segments for tapered appearance
  y_positions <- seq(crown_base_y, crown_top_y, length.out = n_segments + 1)
  
  data.frame(
    x = trunk_x,
    y = y_positions[1:n_segments],
    xend = trunk_x,
    yend = y_positions[2:(n_segments + 1)],
    is_leader = TRUE,
    generation = seq(0, n_segments - 1) / n_segments  # For tapering
  )
}


# =============================================================================
# MULTI-STEM SHRUB SYSTEM
# =============================================================================

#' Generate a multi-stemmed shrub
#' 
#' @param x Center x position
#' @param ground_y Ground level
#' @param width Total shrub width
#' @param height Total shrub height
#' @param n_stems Number of main stems
#' @param branch_iterations L-system iterations for stem branches
#' @param irregular Add irregularity to crown
#' @param seed Random seed
#' @return List with stems, branches, crown components
make_shrub <- function(x = 0,
                       ground_y = 0,
                       width = 3,
                       height = 2.5,
                       n_stems = 4,
                       branch_iterations = 2,
                       irregular = TRUE,
                       roughness = 0.1,
                       seed = NULL) {
  
  if (!is.null(seed)) set.seed(seed)
  
  # Generate crown envelope (shrub shape, ground-based)
  crown <- crown_shrub(x, ground_y, width, height, lobes = 3, seed = seed)
  
  if (irregular) {
    # Only apply irregularity to the upper portion
    crown <- crown_irregular(crown, roughness = roughness, seed = seed)
  }
  
  # Generate multiple stems from near ground level
  # Stems fan out from a central base point
  stem_spread <- width * 0.4
  stem_origins_x <- seq(x - stem_spread/2, x + stem_spread/2, length.out = n_stems)
  
  # Add slight randomness to stem positions
  stem_origins_x <- stem_origins_x + runif(n_stems, -width * 0.05, width * 0.05)
  
  all_stems <- list()
  all_branches <- list()
  
  for (i in seq_len(n_stems)) {
    stem_x <- stem_origins_x[i]
    
    # Stem angle: outer stems lean outward, inner stems more vertical
    center_offset <- (stem_x - x) / (stem_spread / 2)
    lean_angle <- center_offset * 25  # Max 25 degrees outward lean
    
    # Stem height varies - outer stems shorter
    stem_height_factor <- 1 - 0.3 * abs(center_offset)
    stem_top_y <- ground_y + height * stem_height_factor * runif(1, 0.6, 0.85)
    
    # Calculate stem endpoint with lean
    lean_rad <- lean_angle * pi / 180
    stem_length <- stem_top_y - ground_y
    stem_end_x <- stem_x + stem_length * sin(lean_rad)
    stem_end_y <- ground_y + stem_length * cos(lean_rad)
    
    # Main stem
    stem <- data.frame(
      x = stem_x,
      y = ground_y,
      xend = stem_end_x,
      yend = stem_end_y,
      stem_id = i,
      is_stem = TRUE,
      generation = 0
    )
    all_stems <- append(all_stems, list(stem))
    
    # Branches from this stem
    # Generate 1-2 branch points along each stem
    n_branch_points <- sample(1:2, 1)
    branch_heights <- runif(n_branch_points, 0.3, 0.7)
    
    for (bh in branch_heights) {
      # Position along stem
      bp_x <- stem_x + (stem_end_x - stem_x) * bh
      bp_y <- ground_y + (stem_end_y - ground_y) * bh
      
      # Branch angles - spread outward
      base_angle <- lean_angle + sign(center_offset + 0.01) * runif(1, 30, 60)
      
      # Simple L-system branch
      expanded <- lsys_expand("F", list(F = "F[+F][-F]"), branch_iterations)
      
      branches <- lsys_turtle(
        expanded,
        start_x = bp_x,
        start_y = bp_y,
        start_angle = base_angle,
        length = height * 0.25,
        angle = 28,
        length_decay = 0.6
      )
      
      if (nrow(branches) > 0) {
        branches$stem_id <- i
        branches$is_stem <- FALSE
        all_branches <- append(all_branches, list(branches))
      }
    }
  }
  
  stems <- bind_rows(all_stems)
  branches <- bind_rows(all_branches)
  
  # Clip branches to crown
  if (nrow(branches) > 0) {
    branches <- clip_branches_strict(branches, crown)
  }
  
  list(
    stems = stems,
    branches = branches,
    crown = crown
  )
}


# =============================================================================
# UPDATED BRANCHING WITH BETTER SCATTERED STRATEGY
# =============================================================================

#' Improved scattered branching - more points, better distribution
branching_scattered_v3 <- function(crown,
                                    trunk_x = 0,
                                    crown_base_y,
                                    crown_top_y,
                                    n_points = 10,
                                    branch_length = 0.8,
                                    iterations = 2,
                                    angle = 30,
                                    length_decay = 0.6,
                                    seed = NULL) {
  
  if (!is.null(seed)) set.seed(seed)
  
  x_range <- range(crown$x)
  y_range <- range(crown$y)
  crown_width <- diff(x_range)
  crown_height <- diff(y_range)
  
  # Better point distribution: stratified random sampling
  # Divide crown into vertical zones and place points in each
  n_zones <- ceiling(n_points / 2)
  zone_height <- crown_height / n_zones
  
  points <- data.frame(x = numeric(), y = numeric())
  
  for (z in 1:n_zones) {
    zone_bottom <- y_range[1] + (z - 1) * zone_height
    zone_top <- y_range[1] + z * zone_height
    
    # 2 points per zone, one on each side of trunk
    for (side in c(-1, 1)) {
      px <- trunk_x + side * runif(1, crown_width * 0.15, crown_width * 0.4)
      py <- runif(1, zone_bottom, zone_top)
      points <- rbind(points, data.frame(x = px, y = py))
    }
  }
  
  # Filter to those inside crown
  inside <- point_in_polygon(points$x, points$y, crown$x, crown$y)
  points <- points[inside, ]
  
  if (nrow(points) == 0) return(data.frame())
  
  all_branches <- list()
  rules <- list(F = "F[+F][-F]")
  
  for (i in seq_len(nrow(points))) {
    px <- points$x[i]
    py <- points$y[i]
    
    # Angle points outward from trunk
    dx <- px - trunk_x
    outward_angle <- sign(dx) * runif(1, 50, 80)
    
    # Add some upward bias for upper points
    height_ratio <- (py - crown_base_y) / (crown_top_y - crown_base_y)
    upward_adjustment <- height_ratio * 15
    start_angle <- outward_angle - sign(dx) * upward_adjustment
    
    expanded <- lsys_expand("F", rules, iterations)
    
    branches <- lsys_turtle(
      expanded,
      start_x = px,
      start_y = py,
      start_angle = start_angle,
      length = branch_length,
      angle = angle,
      length_decay = length_decay
    )
    
    if (nrow(branches) > 0) {
      all_branches <- append(all_branches, list(branches))
    }
  }
  
  bind_rows(all_branches)
}


# =============================================================================
# VERSION 4 TREE BUILDER - WITH CENTRAL LEADERS
# =============================================================================

make_tree_v4 <- function(x = 0,
                         ground_y = 0,
                         height = 10,
                         trunk_height = 4,
                         crown_width = 6,
                         crown_height = NULL,
                         crown_shape = "elliptical",
                         crown_exponent = 2.5,
                         branching_strategy = "whorled",
                         branch_iterations = 2,
                         show_leader = TRUE,
                         irregular = TRUE,
                         roughness = 0.08,
                         seed = NULL) {
  
  if (!is.null(seed)) set.seed(seed)
  
  if (is.null(crown_height)) {
    crown_height <- height - trunk_height
  }
  
  crown_base_y <- ground_y + trunk_height
  crown_top_y <- ground_y + height
  
  # Trunk (below crown)
  trunk <- data.frame(
    x = x,
    y = ground_y,
    xend = x,
    yend = crown_base_y,
    is_leader = FALSE,
    generation = 0
  )
  
  # Central leader through crown
  if (show_leader) {
    # For conical crowns, leader goes to apex
    # For rounded crowns, leader goes to ~80% of crown height
    if (crown_shape == "conical") {
      leader_top <- crown_top_y
    } else {
      leader_top <- crown_base_y + crown_height * 0.75
    }
    
    leader <- make_central_leader(x, crown_base_y, leader_top)
  } else {
    leader <- data.frame(x = numeric(), y = numeric(), 
                         xend = numeric(), yend = numeric(),
                         is_leader = logical(), generation = numeric())
  }
  
  # Crown envelope
  crown_cy <- crown_base_y + crown_height / 2
  
  crown <- switch(crown_shape,
    conical = crown_conical(x, crown_base_y, crown_width, crown_height),
    elliptical = crown_elliptical(x, crown_cy, crown_width, crown_height),
    superellipse = crown_superellipse(x, crown_cy, crown_width, crown_height, crown_exponent),
    flat_topped = crown_flat_topped(x, crown_cy, crown_width, crown_height * 0.8),
    stop("Unknown crown shape")
  )
  
  if (irregular) {
    crown <- crown_irregular(crown, roughness = roughness, seed = seed)
  }
  
  # Generate branches
  branches <- switch(branching_strategy,
    whorled = branching_whorled_v2(
      trunk_x = x,
      trunk_top_y = crown_base_y,
      crown_top_y = crown_top_y,
      n_whorls = 4,
      branch_length = crown_width * 0.28,
      iterations = branch_iterations,
      seed = seed
    ),
    radial = branching_radial_v2(
      trunk_x = x,
      crown_base_y = crown_base_y,
      crown_top_y = crown_top_y,
      crown_width = crown_width,
      n_levels = 4,
      iterations = branch_iterations,
      seed = seed
    ),
    scattered = branching_scattered_v3(
      crown = crown,
      trunk_x = x,
      crown_base_y = crown_base_y,
      crown_top_y = crown_top_y,
      n_points = 10,
      branch_length = crown_width * 0.15,
      iterations = branch_iterations,
      seed = seed
    ),
    conifer = branching_conifer_v2(
      trunk_x = x,
      crown_base_y = crown_base_y,
      crown_top_y = crown_top_y,
      crown_width = crown_width,
      n_whorls = 6,
      iterations = branch_iterations,
      seed = seed
    ),
    stop("Unknown branching strategy")
  )
  
  # Add is_leader column to branches for consistent structure
  if (nrow(branches) > 0) {
    branches$is_leader <- FALSE
  }
  
  # Clip branches to crown
  branches <- clip_branches_strict(branches, crown)
  
  list(
    trunk = trunk,
    leader = leader,
    branches = branches,
    crown = crown
  )
}


# =============================================================================
# DEMOS
# =============================================================================

demo_with_leaders <- function() {
  
  trees <- list(
    # Broadleaf - radial with leader
    make_tree_v4(x = 0, height = 11, trunk_height = 4, crown_width = 7,
                 crown_shape = "elliptical", branching_strategy = "radial",
                 branch_iterations = 2, show_leader = TRUE, seed = 1),
    # Tall conifer with leader to apex
    make_tree_v4(x = 9, height = 14, trunk_height = 3, crown_width = 5,
                 crown_shape = "conical", branching_strategy = "conifer",
                 branch_iterations = 2, show_leader = TRUE, seed = 2),
    # Improved scattered tree
    make_tree_v4(x = 15, height = 6, trunk_height = 2, crown_width = 4,
                 crown_shape = "elliptical", branching_strategy = "scattered",
                 branch_iterations = 2, show_leader = TRUE, seed = 3),
    # Flat-topped with leader
    make_tree_v4(x = 22, height = 8, trunk_height = 4.5, crown_width = 9,
                 crown_shape = "flat_topped", branching_strategy = "whorled",
                 branch_iterations = 2, show_leader = TRUE, seed = 4),
    # Another conifer
    make_tree_v4(x = 31, height = 10, trunk_height = 2, crown_width = 4,
                 crown_shape = "conical", branching_strategy = "conifer",
                 branch_iterations = 2, show_leader = TRUE, seed = 5)
  )
  
  # Combine components
  trunks <- bind_rows(lapply(trees, function(t) t$trunk))
  leaders <- bind_rows(lapply(trees, function(t) t$leader))
  branches <- bind_rows(lapply(trees, function(t) {
    if (nrow(t$branches) > 0) t$branches
  }))
  crowns <- bind_rows(lapply(seq_along(trees), function(i) {
    trees[[i]]$crown$tree_id <- i
    trees[[i]]$crown
  }))
  
  # Combine trunk and leader segments
  trunk_system <- bind_rows(trunks, leaders)
  
  branches <- branches %>%
    mutate(weight = 1 / (generation + 1))
  
  ggplot() +
    geom_polygon(data = crowns, aes(x, y, group = tree_id),
                 fill = "darkgreen", alpha = 0.12) +
    geom_ribbon(data = data.frame(x = c(-5, 38), ymin = -1.5, ymax = 0),
                aes(x = x, ymin = ymin, ymax = ymax), fill = "tan4", alpha = 0.3) +
    # Trunk and leader
    geom_segment(data = trunk_system, aes(x = x, y = y, xend = xend, yend = yend),
                 color = "saddlebrown", linewidth = 1.5) +
    # Branches
    geom_segment(data = branches,
                 aes(x = x, y = y, xend = xend, yend = yend, linewidth = weight),
                 color = "saddlebrown") +
    scale_linewidth_continuous(range = c(0.15, 0.9), guide = "none") +
    geom_polygon(data = crowns, aes(x, y, group = tree_id),
                 fill = NA, color = "darkgreen", linewidth = 0.5) +
    coord_equal() +
    labs(title = "Trees with Central Leaders",
         subtitle = "Broadleaf | Conifer | Scattered | Flat-topped | Conifer") +
    theme_minimal() +
    theme(axis.text = element_blank(),
          axis.title = element_blank(),
          panel.grid = element_blank())
}


demo_shrubs <- function() {
  
  # Create several shrubs with different characteristics
  shrubs <- list(
    make_shrub(x = 0, width = 3, height = 2.5, n_stems = 4, seed = 1),
    make_shrub(x = 5, width = 4, height = 3, n_stems = 5, seed = 2),
    make_shrub(x = 11, width = 2.5, height = 2, n_stems = 3, seed = 3),
    make_shrub(x = 15, width = 3.5, height = 2.8, n_stems = 5, seed = 4)
  )
  
  # Combine components
  stems <- bind_rows(lapply(seq_along(shrubs), function(i) {
    shrubs[[i]]$stems$shrub_id <- i
    shrubs[[i]]$stems
  }))
  
  branches <- bind_rows(lapply(seq_along(shrubs), function(i) {
    if (nrow(shrubs[[i]]$branches) > 0) {
      shrubs[[i]]$branches$shrub_id <- i
      shrubs[[i]]$branches
    }
  }))
  
  crowns <- bind_rows(lapply(seq_along(shrubs), function(i) {
    shrubs[[i]]$crown$shrub_id <- i
    shrubs[[i]]$crown
  }))
  
  # Weight for branch thickness
  if (nrow(branches) > 0) {
    branches <- branches %>%
      mutate(weight = 1 / (generation + 1))
  }
  
  ggplot() +
    geom_polygon(data = crowns, aes(x, y, group = shrub_id),
                 fill = "darkgreen", alpha = 0.12) +
    geom_ribbon(data = data.frame(x = c(-3, 20), ymin = -0.8, ymax = 0),
                aes(x = x, ymin = ymin, ymax = ymax), fill = "tan4", alpha = 0.3) +
    # Stems (thicker)
    geom_segment(data = stems, aes(x = x, y = y, xend = xend, yend = yend),
                 color = "saddlebrown", linewidth = 1) +
    # Branches (thinner)
    geom_segment(data = branches,
                 aes(x = x, y = y, xend = xend, yend = yend, linewidth = weight),
                 color = "saddlebrown") +
    scale_linewidth_continuous(range = c(0.15, 0.6), guide = "none") +
    geom_polygon(data = crowns, aes(x, y, group = shrub_id),
                 fill = NA, color = "darkgreen", linewidth = 0.5) +
    coord_equal() +
    labs(title = "Multi-Stem Shrubs",
         subtitle = "Each shrub has multiple stems originating near ground level") +
    theme_minimal() +
    theme(axis.text = element_blank(),
          axis.title = element_blank(),
          panel.grid = element_blank())
}


demo_complete_profile <- function() {
  
  # Mixed vegetation: trees and shrubs together
  trees <- list(
    make_tree_v4(x = 0, height = 12, trunk_height = 4.5, crown_width = 8,
                 crown_shape = "elliptical", branching_strategy = "radial",
                 branch_iterations = 2, show_leader = TRUE, seed = 10),
    make_tree_v4(x = 10, height = 15, trunk_height = 3, crown_width = 5.5,
                 crown_shape = "conical", branching_strategy = "conifer",
                 branch_iterations = 2, show_leader = TRUE, seed = 20),
    make_tree_v4(x = 26, height = 9, trunk_height = 5, crown_width = 11,
                 crown_shape = "flat_topped", branching_strategy = "whorled",
                 branch_iterations = 2, show_leader = TRUE, seed = 40),
    make_tree_v4(x = 36, height = 11, trunk_height = 2.5, crown_width = 5,
                 crown_shape = "conical", branching_strategy = "conifer",
                 branch_iterations = 2, show_leader = TRUE, seed = 50)
  )
  
  shrubs <- list(
    make_shrub(x = 17, width = 3, height = 3, n_stems = 4, seed = 100),
    make_shrub(x = 21, width = 2.5, height = 2, n_stems = 3, seed = 101)
  )
  
  # Combine tree components
  tree_trunks <- bind_rows(lapply(trees, function(t) t$trunk))
  tree_leaders <- bind_rows(lapply(trees, function(t) t$leader))
  tree_branches <- bind_rows(lapply(trees, function(t) {
    if (nrow(t$branches) > 0) t$branches
  }))
  tree_crowns <- bind_rows(lapply(seq_along(trees), function(i) {
    trees[[i]]$crown$veg_id <- paste0("tree_", i)
    trees[[i]]$crown
  }))
  
  # Combine shrub components
  shrub_stems <- bind_rows(lapply(seq_along(shrubs), function(i) {
    shrubs[[i]]$stems$veg_id <- paste0("shrub_", i)
    shrubs[[i]]$stems
  }))
  shrub_branches <- bind_rows(lapply(seq_along(shrubs), function(i) {
    if (nrow(shrubs[[i]]$branches) > 0) {
      shrubs[[i]]$branches$veg_id <- paste0("shrub_", i)
      shrubs[[i]]$branches
    }
  }))
  shrub_crowns <- bind_rows(lapply(seq_along(shrubs), function(i) {
    shrubs[[i]]$crown$veg_id <- paste0("shrub_", i)
    shrubs[[i]]$crown
  }))
  
  # All crowns
  all_crowns <- bind_rows(tree_crowns, shrub_crowns)
  
  # All woody structure (trunks, leaders, stems)
  tree_system <- bind_rows(tree_trunks, tree_leaders)
  
  # All branches
  all_branches <- bind_rows(tree_branches, shrub_branches)
  if (nrow(all_branches) > 0) {
    all_branches <- all_branches %>%
      mutate(weight = 1 / (generation + 1))
  }
  
  ggplot() +
    geom_polygon(data = all_crowns, aes(x, y, group = veg_id),
                 fill = "darkgreen", alpha = 0.12) +
    geom_ribbon(data = data.frame(x = c(-5, 42), ymin = -2, ymax = 0),
                aes(x = x, ymin = ymin, ymax = ymax), fill = "tan4", alpha = 0.3) +
    # Tree trunks and leaders
    geom_segment(data = tree_system, aes(x = x, y = y, xend = xend, yend = yend),
                 color = "saddlebrown", linewidth = 1.5) +
    # Shrub stems
    geom_segment(data = shrub_stems, aes(x = x, y = y, xend = xend, yend = yend),
                 color = "saddlebrown", linewidth = 1) +
    # All branches
    geom_segment(data = all_branches,
                 aes(x = x, y = y, xend = xend, yend = yend, linewidth = weight),
                 color = "saddlebrown") +
    scale_linewidth_continuous(range = c(0.12, 0.8), guide = "none") +
    geom_polygon(data = all_crowns, aes(x, y, group = veg_id),
                 fill = NA, color = "darkgreen", linewidth = 0.5) +
    coord_equal() +
    labs(title = "Complete Vegetation Profile",
         subtitle = "Trees and shrubs with central leaders and multi-stem structure") +
    theme_minimal() +
    theme(axis.text = element_blank(),
          axis.title = element_blank(),
          panel.grid = element_blank())
}


# Run demos
cat("Trees with central leaders...\n")
print(demo_with_leaders())

cat("\nMulti-stem shrubs...\n")
print(demo_shrubs())

cat("\nComplete vegetation profile...\n")
print(demo_complete_profile())
