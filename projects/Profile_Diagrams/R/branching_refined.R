# Refined Branching Strategies - Version 2
# Stricter clipping, reduced density

library(ggplot2)
library(dplyr)

# Source the core functions
# source('R/vegetation_profile_core.R')

# =============================================================================
# IMPROVED CLIPPING: Clip segments to crown boundary
# =============================================================================

#' Clip a line segment to polygon boundary
#' 
#' If segment crosses boundary, truncate at intersection
#' 
#' @param x1, y1 Start point
#' @param x2, y2 End point
#' @param poly_x, poly_y Polygon vertices
#' @return List with clipped coordinates or NULL if fully outside
clip_segment_to_polygon <- function(x1, y1, x2, y2, poly_x, poly_y) {
  
  n <- length(poly_x)
  
  # Check if points are inside
 start_inside <- point_in_polygon(x1, y1, poly_x, poly_y)
  end_inside <- point_in_polygon(x2, y2, poly_x, poly_y)
  
  # Both inside - keep as is
 if (start_inside && end_inside) {
    return(list(x = x1, y = y1, xend = x2, yend = y2))
  }
  
  # Both outside - discard
  if (!start_inside && !end_inside) {
    return(NULL)
  }
  
  # One inside, one outside - find intersection and clip
  # Check intersection with each polygon edge
  for (i in 1:n) {
    j <- if (i == n) 1 else i + 1
    
    # Polygon edge
    px1 <- poly_x[i]; py1 <- poly_y[i]
    px2 <- poly_x[j]; py2 <- poly_y[j]
    
    # Find intersection using parametric form
    denom <- (x1 - x2) * (py1 - py2) - (y1 - y2) * (px1 - px2)
    if (abs(denom) < 1e-10) next  # Parallel
    
    t <- ((x1 - px1) * (py1 - py2) - (y1 - py1) * (px1 - px2)) / denom
    u <- -((x1 - x2) * (y1 - py1) - (y1 - y2) * (x1 - px1)) / denom
    
    # Check if intersection is within both segments
    if (t >= 0 && t <= 1 && u >= 0 && u <= 1) {
      ix <- x1 + t * (x2 - x1)
      iy <- y1 + t * (y2 - y1)
      
      if (start_inside) {
        return(list(x = x1, y = y1, xend = ix, yend = iy))
      } else {
        return(list(x = ix, y = iy, xend = x2, yend = y2))
      }
    }
  }
  
  # Fallback: keep if start is inside
  if (start_inside) {
    return(list(x = x1, y = y1, xend = x2, yend = y2))
  }
  
  return(NULL)
}

#' Strictly clip all branches to crown envelope
#' 
#' Clips each segment at the crown boundary rather than just filtering
#' 
#' @param branches Data frame with x, y, xend, yend
#' @param crown Data frame with x, y defining polygon
#' @return Clipped branches data frame
clip_branches_strict <- function(branches, crown) {
  if (nrow(branches) == 0) return(branches)
  
  clipped <- list()
  
  for (i in 1:nrow(branches)) {
    result <- clip_segment_to_polygon(
      branches$x[i], branches$y[i],
      branches$xend[i], branches$yend[i],
      crown$x, crown$y
    )
    
    if (!is.null(result)) {
      row <- branches[i, ]
      row$x <- result$x
      row$y <- result$y
      row$xend <- result$xend
      row$yend <- result$yend
      clipped <- append(clipped, list(row))
    }
  }
  
  if (length(clipped) == 0) {
    return(branches[0, ])  # Empty with same structure
  }
  
  bind_rows(clipped)
}


# =============================================================================
# REFINED BRANCHING STRATEGIES - Reduced Density
# =============================================================================

#' Refined whorled branching - fewer, cleaner branches
branching_whorled_v2 <- function(trunk_x = 0,
                                  trunk_top_y = 4,
                                  crown_top_y = 10,
                                  n_whorls = 4,
                                  branch_length = 1.5,
                                  style = "sparse",
                                  iterations = 2,
                                  angle = 30,
                                  length_decay = 0.6,
                                  upward_bias = 20,
                                  seed = NULL) {
  
  if (!is.null(seed)) set.seed(seed)
  
  crown_height <- crown_top_y - trunk_top_y
  
  # Fewer whorls, more spread out
 whorl_positions <- seq(trunk_top_y + crown_height * 0.15,
                         crown_top_y - crown_height * 0.15,
                         length.out = n_whorls)
  
  # Branch length decreases toward top
  length_factors <- seq(1, 0.5, length.out = n_whorls)
  
  all_branches <- list()
  
  # Simpler rule for cleaner branches
  rules <- list(F = "F[+F][-F]")
  
  for (i in seq_along(whorl_positions)) {
    y_pos <- whorl_positions[i]
    len <- branch_length * length_factors[i]
    
    height_ratio <- (y_pos - trunk_top_y) / crown_height
    base_angle_offset <- 90 - (upward_bias + height_ratio * 25)
    
    for (side in c(-1, 1)) {
      start_angle <- side * base_angle_offset
      
      expanded <- lsys_expand("F", rules, iterations)
      
      branches <- lsys_turtle(
        expanded,
        start_x = trunk_x,
        start_y = y_pos,
        start_angle = start_angle,
        length = len,
        angle = angle,
        length_decay = length_decay
      )
      
      if (nrow(branches) > 0) {
        branches$whorl <- i
        all_branches <- append(all_branches, list(branches))
      }
    }
  }
  
  if (length(all_branches) == 0) {
    return(data.frame(x = numeric(), y = numeric(),
                      xend = numeric(), yend = numeric(),
                      generation = integer()))
  }
  
  bind_rows(all_branches)
}


#' Refined radial branching - sparser fill
branching_radial_v2 <- function(trunk_x = 0,
                                 crown_base_y = 4,
                                 crown_top_y = 10,
                                 crown_width = 6,
                                 n_levels = 4,
                                 rays_per_level = 2,
                                 branch_length = NULL,
                                 iterations = 2,
                                 angle = 28,
                                 length_decay = 0.65,
                                 seed = NULL) {
  
  if (!is.null(seed)) set.seed(seed)
  
  crown_height <- crown_top_y - crown_base_y
  if (is.null(branch_length)) branch_length <- crown_width * 0.22
  
  levels <- seq(crown_base_y + crown_height * 0.2,
                crown_top_y - crown_height * 0.15,
                length.out = n_levels)
  
  all_branches <- list()
  rules <- list(F = "F[+F][-F]")
  
  for (i in seq_along(levels)) {
    y_pos <- levels[i]
    height_ratio <- (y_pos - crown_base_y) / crown_height
    
    # Longest at middle
    len_factor <- 1 - 1.5 * abs(height_ratio - 0.45)
    len <- branch_length * max(0.4, len_factor)
    
    # Angle spread
    angle_spread <- 75 * (1 - height_ratio * 0.4)
    angles <- c(-angle_spread, angle_spread)
    
    for (ang in angles) {
      expanded <- lsys_expand("F", rules, iterations)
      
      branches <- lsys_turtle(
        expanded,
        start_x = trunk_x,
        start_y = y_pos,
        start_angle = ang,
        length = len,
        angle = angle,
        length_decay = length_decay
      )
      
      if (nrow(branches) > 0) {
        branches$level <- i
        all_branches <- append(all_branches, list(branches))
      }
    }
  }
  
  bind_rows(all_branches)
}


#' Refined scattered branching - fewer points, cleaner
branching_scattered_v2 <- function(crown,
                                    trunk_x = 0,
                                    n_points = 6,
                                    branch_length = 0.6,
                                    iterations = 2,
                                    angle = 32,
                                    length_decay = 0.6,
                                    seed = NULL) {
  
  if (!is.null(seed)) set.seed(seed)
  
  x_range <- range(crown$x)
  y_range <- range(crown$y)
  
  # Generate and filter points
  points <- data.frame(
    x = runif(n_points * 4, x_range[1] * 0.8, x_range[2] * 0.8),
    y = runif(n_points * 4, y_range[1], y_range[2] * 0.9)
  )
  
  inside <- point_in_polygon(points$x, points$y, crown$x, crown$y)
  points <- points[inside, ][1:min(n_points, sum(inside)), ]
  
  if (nrow(points) == 0) return(data.frame())
  
  all_branches <- list()
  rules <- list(F = "F[+F][-F]")
  
  for (i in seq_len(nrow(points))) {
    px <- points$x[i]
    py <- points$y[i]
    
    # Point outward from trunk
    dx <- px - trunk_x
    base_angle <- sign(dx) * (70 + runif(1, -20, 20))
    
    expanded <- lsys_expand("F", rules, iterations)
    
    branches <- lsys_turtle(
      expanded,
      start_x = px,
      start_y = py,
      start_angle = base_angle,
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


#' Refined conifer branching - cleaner whorls
branching_conifer_v2 <- function(trunk_x = 0,
                                  crown_base_y = 4,
                                  crown_top_y = 12,
                                  crown_width = 5,
                                  n_whorls = 6,
                                  iterations = 2,
                                  seed = NULL) {
  
  if (!is.null(seed)) set.seed(seed)
  
  crown_height <- crown_top_y - crown_base_y
  
  whorl_y <- seq(crown_base_y + crown_height * 0.08,
                 crown_top_y - crown_height * 0.12,
                 length.out = n_whorls)
  
  all_branches <- list()
  
  for (i in seq_along(whorl_y)) {
    y <- whorl_y[i]
    height_ratio <- (y - crown_base_y) / crown_height
    
    # Conical: shorter toward top
    max_len <- (crown_width / 2) * (1 - height_ratio * 0.85) * 0.9
    
    # Slight droop at bottom
    droop <- 12 * (1 - height_ratio)
    
    for (side in c(-1, 1)) {
      start_angle <- side * (90 + droop)
      
      expanded <- lsys_expand("F", list(F = "F[+F][-F]"), iterations)
      
      branches <- lsys_turtle(
        expanded,
        start_x = trunk_x,
        start_y = y,
        start_angle = start_angle,
        length = max_len * 0.45,
        angle = 22,
        length_decay = 0.6
      )
      
      if (nrow(branches) > 0) {
        branches$whorl <- i
        all_branches <- append(all_branches, list(branches))
      }
    }
  }
  
  bind_rows(all_branches)
}


# =============================================================================
# UPDATED TREE BUILDER
# =============================================================================

make_tree_v3 <- function(x = 0,
                         ground_y = 0,
                         height = 10,
                         trunk_height = 4,
                         crown_width = 6,
                         crown_height = NULL,
                         crown_shape = "elliptical",
                         crown_exponent = 2.5,
                         branching_strategy = "whorled",
                         branch_iterations = 2,
                         irregular = TRUE,
                         roughness = 0.08,
                         seed = NULL) {
  
  if (!is.null(seed)) set.seed(seed)
  
  if (is.null(crown_height)) {
    crown_height <- height - trunk_height
  }
  
  # Trunk
  trunk <- data.frame(
    x = x,
    y = ground_y,
    xend = x,
    yend = ground_y + trunk_height
  )
  
  # Crown envelope
  crown_cy <- ground_y + trunk_height + crown_height / 2
  
  crown <- switch(crown_shape,
    conical = crown_conical(x, ground_y + trunk_height, crown_width, crown_height),
    elliptical = crown_elliptical(x, crown_cy, crown_width, crown_height),
    superellipse = crown_superellipse(x, crown_cy, crown_width, crown_height, crown_exponent),
    flat_topped = crown_flat_topped(x, crown_cy, crown_width, crown_height * 0.8),
    stop("Unknown crown shape")
  )
  
  if (irregular) {
    crown <- crown_irregular(crown, roughness = roughness, seed = seed)
  }
  
  crown_base_y <- ground_y + trunk_height
  crown_top_y <- ground_y + height
  
  # Generate branches with refined strategies
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
    scattered = branching_scattered_v2(
      crown = crown,
      trunk_x = x,
      n_points = 6,
      branch_length = crown_width * 0.12,
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
  
  # Strict clipping to crown
  branches <- clip_branches_strict(branches, crown)
  
  list(
    trunk = trunk,
    branches = branches,
    crown = crown
  )
}


# =============================================================================
# DEMOS
# =============================================================================

demo_refined_comparison <- function() {
  
  strategies <- c("whorled", "radial", "scattered", "conifer")
  shapes <- c("elliptical", "elliptical", "elliptical", "conical")
  
  trees <- lapply(seq_along(strategies), function(i) {
    tree <- make_tree_v3(
      x = (i - 1) * 10,
      height = 10,
      trunk_height = 3,
      crown_width = 6,
      crown_shape = shapes[i],
      branching_strategy = strategies[i],
      branch_iterations = 2,
      seed = 42
    )
    tree$strategy <- strategies[i]
    tree
  })
  
  trunks <- bind_rows(lapply(trees, function(t) t$trunk))
  
  branches <- bind_rows(lapply(seq_along(trees), function(i) {
    if (nrow(trees[[i]]$branches) > 0) {
      trees[[i]]$branches$strategy <- strategies[i]
      trees[[i]]$branches
    }
  }))
  
  crowns <- bind_rows(lapply(seq_along(trees), function(i) {
    trees[[i]]$crown$strategy <- strategies[i]
    trees[[i]]$crown
  }))
  
  branches <- branches %>%
    mutate(weight = 1 / (generation + 1))
  
  ggplot() +
    geom_polygon(data = crowns, aes(x, y, group = strategy),
                 fill = "darkgreen", alpha = 0.12) +
    geom_ribbon(data = data.frame(x = c(-5, 40), ymin = -1.5, ymax = 0),
                aes(x = x, ymin = ymin, ymax = ymax), fill = "tan4", alpha = 0.3) +
    geom_segment(data = trunks, aes(x = x, y = y, xend = xend, yend = yend),
                 color = "saddlebrown", linewidth = 1.5) +
    geom_segment(data = branches,
                 aes(x = x, y = y, xend = xend, yend = yend, linewidth = weight),
                 color = "saddlebrown") +
    scale_linewidth_continuous(range = c(0.2, 1), guide = "none") +
    geom_polygon(data = crowns, aes(x, y, group = strategy),
                 fill = NA, color = "darkgreen", linewidth = 0.5) +
    facet_wrap(~ strategy, nrow = 1) +
    coord_equal() +
    labs(title = "Refined Branching Strategies",
         subtitle = "Reduced density, strict clipping to crown envelope") +
    theme_minimal() +
    theme(axis.text = element_blank(),
          axis.title = element_blank(),
          panel.grid = element_blank(),
          strip.text = element_text(size = 11, face = "bold"))
}


demo_refined_mixed <- function() {
  
  trees <- list(
    # Broadleaf - radial
    make_tree_v3(x = 0, height = 11, trunk_height = 4, crown_width = 7,
                 crown_shape = "elliptical", branching_strategy = "radial",
                 branch_iterations = 2, seed = 1),
    # Tall conifer
    make_tree_v3(x = 8, height = 14, trunk_height = 3, crown_width = 5,
                 crown_shape = "conical", branching_strategy = "conifer",
                 branch_iterations = 2, seed = 2),
    # Small shrubby tree
    make_tree_v3(x = 13, height = 5, trunk_height = 1.2, crown_width = 3.5,
                 crown_shape = "elliptical", branching_strategy = "scattered",
                 branch_iterations = 2, seed = 3),
    # Flat-topped
    make_tree_v3(x = 19, height = 8, trunk_height = 4.5, crown_width = 9,
                 crown_shape = "flat_topped", branching_strategy = "whorled",
                 branch_iterations = 2, seed = 4),
    # Small conifer
    make_tree_v3(x = 27, height = 9, trunk_height = 2, crown_width = 4,
                 crown_shape = "conical", branching_strategy = "conifer",
                 branch_iterations = 2, seed = 5)
  )
  
  trunks <- bind_rows(lapply(trees, function(t) t$trunk))
  branches <- bind_rows(lapply(trees, function(t) {
    if (nrow(t$branches) > 0) t$branches
  }))
  crowns <- bind_rows(lapply(seq_along(trees), function(i) {
    trees[[i]]$crown$tree_id <- i
    trees[[i]]$crown
  }))
  
  branches <- branches %>%
    mutate(weight = 1 / (generation + 1))
  
  ggplot() +
    geom_polygon(data = crowns, aes(x, y, group = tree_id),
                 fill = "darkgreen", alpha = 0.12) +
    geom_ribbon(data = data.frame(x = c(-4, 32), ymin = -1.5, ymax = 0),
                aes(x = x, ymin = ymin, ymax = ymax), fill = "tan4", alpha = 0.3) +
    geom_segment(data = trunks, aes(x = x, y = y, xend = xend, yend = yend),
                 color = "saddlebrown", linewidth = 1.5) +
    geom_segment(data = branches,
                 aes(x = x, y = y, xend = xend, yend = yend, linewidth = weight),
                 color = "saddlebrown") +
    scale_linewidth_continuous(range = c(0.15, 0.9), guide = "none") +
    geom_polygon(data = crowns, aes(x, y, group = tree_id),
                 fill = NA, color = "darkgreen", linewidth = 0.5) +
    coord_equal() +
    labs(title = "Mixed Vegetation Profile (Refined)",
         subtitle = "Broadleaf | Conifer | Shrub | Flat-topped | Conifer") +
    theme_minimal() +
    theme(axis.text = element_blank(),
          axis.title = element_blank(),
          panel.grid = element_blank())
}


# Different iteration counts to show density control
demo_density_comparison <- function() {
  
  iterations <- c(1, 2, 3)
  
  trees <- lapply(seq_along(iterations), function(i) {
    tree <- make_tree_v3(
      x = (i - 1) * 10,
      height = 10,
      trunk_height = 3,
      crown_width = 6,
      crown_shape = "elliptical",
      branching_strategy = "radial",
      branch_iterations = iterations[i],
      seed = 42
    )
    tree$iterations <- paste0("iterations = ", iterations[i])
    tree
  })
  
  trunks <- bind_rows(lapply(trees, function(t) t$trunk))
  branches <- bind_rows(lapply(seq_along(trees), function(i) {
    if (nrow(trees[[i]]$branches) > 0) {
      trees[[i]]$branches$iterations <- trees[[i]]$iterations
      trees[[i]]$branches
    }
  }))
  crowns <- bind_rows(lapply(seq_along(trees), function(i) {
    trees[[i]]$crown$iterations <- trees[[i]]$iterations
    trees[[i]]$crown
  }))
  
  branches <- branches %>%
    mutate(weight = 1 / (generation + 1))
  
  ggplot() +
    geom_polygon(data = crowns, aes(x, y, group = iterations),
                 fill = "darkgreen", alpha = 0.12) +
    geom_ribbon(data = data.frame(x = c(-5, 30), ymin = -1.5, ymax = 0),
                aes(x = x, ymin = ymin, ymax = ymax), fill = "tan4", alpha = 0.3) +
    geom_segment(data = trunks, aes(x = x, y = y, xend = xend, yend = yend),
                 color = "saddlebrown", linewidth = 1.5) +
    geom_segment(data = branches,
                 aes(x = x, y = y, xend = xend, yend = yend, linewidth = weight),
                 color = "saddlebrown") +
    scale_linewidth_continuous(range = c(0.2, 1), guide = "none") +
    geom_polygon(data = crowns, aes(x, y, group = iterations),
                 fill = NA, color = "darkgreen", linewidth = 0.5) +
    facet_wrap(~ iterations, nrow = 1) +
    coord_equal() +
    labs(title = "Branch Density Control via L-System Iterations",
         subtitle = "Same base structure, increasing detail") +
    theme_minimal() +
    theme(axis.text = element_blank(),
          axis.title = element_blank(),
          panel.grid = element_blank(),
          strip.text = element_text(size = 11, face = "bold"))
}


# Run demos
cat("Refined strategy comparison...\n")
print(demo_refined_comparison())

cat("\nRefined mixed stand...\n")
print(demo_refined_mixed())

cat("\nDensity comparison...\n")
print(demo_density_comparison())
