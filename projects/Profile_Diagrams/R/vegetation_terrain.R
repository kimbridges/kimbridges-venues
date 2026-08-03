# Vegetation Profile System - Version 4
# Terrain Integration

library(ggplot2)
library(dplyr)

# Source previous work
# source('R/vegetation_profile_core.R')
# source('R/branching_refined.R')
# source('R/vegetation_v3.R')

# =============================================================================
# TERRAIN FUNCTIONS
# =============================================================================

#' Create terrain from control points
#' 
#' Takes a set of x, elevation pairs and interpolates a smooth terrain surface
#' 
#' @param x Vector of x positions (control points)
#' @param elevation Vector of elevations at each x position
#' @param resolution Number of points in the output terrain
#' @param method Interpolation method: "spline" (smooth) or "linear"
#' @return Data frame with x, y columns for the terrain surface
make_terrain <- function(x, elevation, resolution = 200, method = "spline") {
  
  # Ensure sorted by x
 ord <- order(x)
  x <- x[ord]
  elevation <- elevation[ord]
  
  # Create fine-grained x positions
  x_fine <- seq(min(x), max(x), length.out = resolution)
  
  if (method == "spline" && length(x) >= 4) {
    # Smooth spline interpolation
    spl <- smooth.spline(x, elevation, spar = 0.4)
    y_fine <- predict(spl, x_fine)$y
  } else {
    # Linear interpolation
    y_fine <- approx(x, elevation, x_fine)$y
  }
  
  data.frame(x = x_fine, y = y_fine)
}


#' Get elevation at a specific x position from terrain
#' 
#' @param terrain Data frame from make_terrain()
#' @param x_pos X position(s) to query
#' @return Elevation(s) at the given position(s)
get_elevation <- function(terrain, x_pos) {
  approx(terrain$x, terrain$y, x_pos)$y
}


#' Create a terrain polygon for filled rendering
#' 
#' @param terrain Data frame from make_terrain()
#' @param base_y Y value for the bottom of the fill (below ground)
#' @return Data frame suitable for geom_polygon
terrain_polygon <- function(terrain, base_y = NULL) {
  if (is.null(base_y)) {
    base_y <- min(terrain$y) - (max(terrain$y) - min(terrain$y)) * 0.3
  }
  
  # Close the polygon: terrain line + bottom edge
  data.frame(
    x = c(terrain$x, rev(terrain$x)),
    y = c(terrain$y, rep(base_y, nrow(terrain)))
  )
}


#' Add soil horizon lines below terrain
#' 
#' @param terrain Data frame from make_terrain()
#' @param depths Vector of depths below surface for each horizon
#' @return List of data frames, one per horizon
make_soil_horizons <- function(terrain, depths = c(0.5, 1.5)) {
  
  horizons <- lapply(depths, function(d) {
    data.frame(
      x = terrain$x,
      y = terrain$y - d,
      depth = d
    )
  })
  
  names(horizons) <- paste0("horizon_", seq_along(depths))
  horizons
}


# =============================================================================
# TERRAIN-AWARE VEGETATION PLACEMENT
# =============================================================================
#' Place a tree on terrain
#' 
#' @param terrain Terrain data frame
#' @param x X position for tree
#' @param ... Other arguments passed to make_tree_v4
#' @return Tree list with adjusted ground_y
place_tree <- function(terrain, x, ...) {
  ground_y <- get_elevation(terrain, x)
  make_tree_v4(x = x, ground_y = ground_y, ...)
}


#' Place a shrub on terrain
#' 
#' @param terrain Terrain data frame
#' @param x X position for shrub
#' @param ... Other arguments passed to make_shrub
#' @return Shrub list with adjusted ground_y
place_shrub <- function(terrain, x, ...) {
  ground_y <- get_elevation(terrain, x)
  make_shrub(x = x, ground_y = ground_y, ...)
}


# =============================================================================
# GRASS/HERB LAYER
# =============================================================================

#' Generate grass tufts along terrain
#' 
#' @param terrain Terrain data frame
#' @param x_positions Vector of x positions for grass tufts
#' @param height_range Range of tuft heights (min, max)
#' @param width_range Range of tuft widths (min, max)
#' @param seed Random seed
#' @return List with crowns (polygons) component
make_grass_layer <- function(terrain, 
                              x_positions,
                              height_range = c(0.3, 0.6),
                              width_range = c(0.3, 0.5),
                              seed = NULL) {
  
  if (!is.null(seed)) set.seed(seed)
  
  all_crowns <- list()
  
  for (i in seq_along(x_positions)) {
    x_pos <- x_positions[i]
    ground_y <- get_elevation(terrain, x_pos)
    
    h <- runif(1, height_range[1], height_range[2])
    w <- runif(1, width_range[1], width_range[2])
    
    grass <- crown_grass(x_pos, ground_y, w, h, seed = seed + i)
    grass$tuft_id <- i
    
    all_crowns <- append(all_crowns, list(grass))
  }
  
  list(crowns = bind_rows(all_crowns))
}


# =============================================================================
# COMPLETE PROFILE BUILDER
# =============================================================================

#' Build a complete vegetation profile with terrain
#' 
#' @param terrain Terrain data frame from make_terrain()
#' @param trees List of tree specifications (each a list with x and parameters)
#' @param shrubs List of shrub specifications
#' @param grass_x Vector of x positions for grass tufts (or NULL)
#' @return List with all components ready for plotting
build_profile <- function(terrain, 
                          trees = list(), 
                          shrubs = list(),
                          grass_x = NULL,
                          grass_seed = 42) {
  
  # Process trees
  tree_objects <- lapply(trees, function(spec) {
    do.call(place_tree, c(list(terrain = terrain), spec))
  })
  
  # Process shrubs
  shrub_objects <- lapply(shrubs, function(spec) {
    do.call(place_shrub, c(list(terrain = terrain), spec))
  })
  
  # Process grass
  if (!is.null(grass_x) && length(grass_x) > 0) {
    grass <- make_grass_layer(terrain, grass_x, seed = grass_seed)
  } else {
    grass <- list(crowns = data.frame())
  }
  
  # Combine tree components
  if (length(tree_objects) > 0) {
    tree_trunks <- bind_rows(lapply(tree_objects, function(t) t$trunk))
    tree_leaders <- bind_rows(lapply(tree_objects, function(t) t$leader))
    tree_branches <- bind_rows(lapply(tree_objects, function(t) {
      if (nrow(t$branches) > 0) t$branches
    }))
    tree_crowns <- bind_rows(lapply(seq_along(tree_objects), function(i) {
      tree_objects[[i]]$crown$veg_id <- paste0("tree_", i)
      tree_objects[[i]]$crown
    }))
  } else {
    tree_trunks <- data.frame()
    tree_leaders <- data.frame()
    tree_branches <- data.frame()
    tree_crowns <- data.frame()
  }
  
  # Combine shrub components
  if (length(shrub_objects) > 0) {
    shrub_stems <- bind_rows(lapply(seq_along(shrub_objects), function(i) {
      shrub_objects[[i]]$stems$veg_id <- paste0("shrub_", i)
      shrub_objects[[i]]$stems
    }))
    shrub_branches <- bind_rows(lapply(seq_along(shrub_objects), function(i) {
      if (nrow(shrub_objects[[i]]$branches) > 0) {
        shrub_objects[[i]]$branches$veg_id <- paste0("shrub_", i)
        shrub_objects[[i]]$branches
      }
    }))
    shrub_crowns <- bind_rows(lapply(seq_along(shrub_objects), function(i) {
      shrub_objects[[i]]$crown$veg_id <- paste0("shrub_", i)
      shrub_objects[[i]]$crown
    }))
  } else {
    shrub_stems <- data.frame()
    shrub_branches <- data.frame()
    shrub_crowns <- data.frame()
  }
  
  # Grass crowns
  if (nrow(grass$crowns) > 0) {
    grass_crowns <- grass$crowns
    grass_crowns$veg_id <- paste0("grass_", grass_crowns$tuft_id)
  } else {
    grass_crowns <- data.frame()
  }
  
  list(
    terrain = terrain,
    tree_trunks = tree_trunks,
    tree_leaders = tree_leaders,
    tree_branches = tree_branches,
    tree_crowns = tree_crowns,
    shrub_stems = shrub_stems,
    shrub_branches = shrub_branches,
    shrub_crowns = shrub_crowns,
    grass_crowns = grass_crowns
  )
}


#' Plot a complete vegetation profile
#' 
#' @param profile Output from build_profile()
#' @param title Plot title
#' @param show_horizons Show soil horizon lines
#' @param horizon_depths Depths for soil horizons
#' @return ggplot object
plot_profile <- function(profile, 
                         title = "Vegetation Profile",
                         subtitle = NULL,
                         show_horizons = FALSE,
                         horizon_depths = c(0.5, 1.5),
                         terrain_fill = "tan4",
                         terrain_alpha = 0.4) {
  
  terrain <- profile$terrain
  
  # Calculate base for terrain fill
  y_range <- range(c(terrain$y, 
                     if(nrow(profile$tree_crowns) > 0) profile$tree_crowns$y else NULL,
                     if(nrow(profile$shrub_crowns) > 0) profile$shrub_crowns$y else NULL))
  base_y <- min(terrain$y) - diff(y_range) * 0.15
  
  # Terrain polygon
  terrain_poly <- terrain_polygon(terrain, base_y)
  
  # Combine all vegetation crowns
  all_crowns <- bind_rows(
    profile$tree_crowns,
    profile$shrub_crowns,
    profile$grass_crowns
  )
  
  # Combine trunk systems
  if (nrow(profile$tree_trunks) > 0 && nrow(profile$tree_leaders) > 0) {
    tree_system <- bind_rows(profile$tree_trunks, profile$tree_leaders)
  } else if (nrow(profile$tree_trunks) > 0) {
    tree_system <- profile$tree_trunks
  } else {
    tree_system <- data.frame()
  }
  
  # Combine all branches
  all_branches <- bind_rows(profile$tree_branches, profile$shrub_branches)
  if (nrow(all_branches) > 0) {
    all_branches <- all_branches %>%
      mutate(weight = 1 / (generation + 1))
  }
  
  # Build plot
  p <- ggplot()
  
  # Soil horizons (if requested)
  if (show_horizons) {
    horizons <- make_soil_horizons(terrain, horizon_depths)
    for (h in horizons) {
      p <- p + geom_line(data = h, aes(x = x, y = y), 
                         color = "tan4", linetype = "dashed", alpha = 0.5)
    }
  }
  
  # Terrain fill
  p <- p + geom_polygon(data = terrain_poly, aes(x = x, y = y),
                        fill = terrain_fill, alpha = terrain_alpha)
  
  # Terrain surface line
  p <- p + geom_line(data = terrain, aes(x = x, y = y),
                     color = "saddlebrown", linewidth = 0.8)
  
  # Vegetation crowns (background fill)
  if (nrow(all_crowns) > 0) {
    p <- p + geom_polygon(data = all_crowns, aes(x = x, y = y, group = veg_id),
                          fill = "darkgreen", alpha = 0.12)
  }
  
  # Tree trunks and leaders
  if (nrow(tree_system) > 0) {
    p <- p + geom_segment(data = tree_system, 
                          aes(x = x, y = y, xend = xend, yend = yend),
                          color = "saddlebrown", linewidth = 1.5)
  }
  
  # Shrub stems
  if (nrow(profile$shrub_stems) > 0) {
    p <- p + geom_segment(data = profile$shrub_stems,
                          aes(x = x, y = y, xend = xend, yend = yend),
                          color = "saddlebrown", linewidth = 1)
  }
  
  # All branches
  if (nrow(all_branches) > 0) {
    p <- p + geom_segment(data = all_branches,
                          aes(x = x, y = y, xend = xend, yend = yend, 
                              linewidth = weight),
                          color = "saddlebrown") +
      scale_linewidth_continuous(range = c(0.12, 0.8), guide = "none")
  }
  
  # Crown outlines
  if (nrow(all_crowns) > 0) {
    p <- p + geom_polygon(data = all_crowns, aes(x = x, y = y, group = veg_id),
                          fill = NA, color = "darkgreen", linewidth = 0.5)
  }
  
  # Final styling
  p <- p + 
    coord_equal() +
    labs(title = title, subtitle = subtitle) +
    theme_minimal() +
    theme(axis.text = element_blank(),
          axis.title = element_blank(),
          panel.grid = element_blank())
  
  p
}


# =============================================================================
# DEMOS
# =============================================================================

demo_terrain_types <- function() {
  
  # Flat terrain
  flat <- make_terrain(
    x = c(0, 40),
    elevation = c(0, 0)
  )
  
  # Gentle slope
  slope <- make_terrain(
    x = c(0, 40),
    elevation = c(0, 4)
  )
  
  # Ridge
  ridge <- make_terrain(
    x = c(0, 10, 20, 30, 40),
    elevation = c(0, 2, 5, 3, 1)
  )
  
  # Valley
  valley <- make_terrain(
    x = c(0, 10, 20, 30, 40),
    elevation = c(3, 1, 0, 1, 4)
  )
  
  # Complex undulating
  complex <- make_terrain(
    x = c(0, 8, 15, 22, 28, 35, 40),
    elevation = c(1, 3, 1.5, 4, 2, 3.5, 2)
  )
  
  # Plot each
  terrains <- list(flat = flat, slope = slope, ridge = ridge, 
                   valley = valley, complex = complex)
  
  plots <- lapply(names(terrains), function(name) {
    t <- terrains[[name]]
    poly <- terrain_polygon(t, min(t$y) - 1.5)
    
    ggplot() +
      geom_polygon(data = poly, aes(x, y), fill = "tan4", alpha = 0.4) +
      geom_line(data = t, aes(x, y), color = "saddlebrown", linewidth = 1) +
      coord_equal() +
      labs(title = name) +
      theme_minimal() +
      theme(axis.text = element_blank(), axis.title = element_blank(),
            panel.grid = element_blank())
  })
  
  # Arrange in grid (using patchwork-style if available, otherwise just return list)
  gridExtra::grid.arrange(grobs = plots, ncol = 3)
}


demo_slope_profile <- function() {
  
  # Create sloping terrain
  terrain <- make_terrain(
    x = c(0, 12, 25, 40),
    elevation = c(0, 2, 5, 8),
    method = "spline"
  )
  
  # Define vegetation
  trees <- list(
    list(x = 5, height = 10, trunk_height = 3.5, crown_width = 6,
         crown_shape = "elliptical", branching_strategy = "radial",
         branch_iterations = 2, seed = 1),
    list(x = 15, height = 12, trunk_height = 3, crown_width = 5,
         crown_shape = "conical", branching_strategy = "conifer",
         branch_iterations = 2, seed = 2),
    list(x = 28, height = 8, trunk_height = 4, crown_width = 9,
         crown_shape = "flat_topped", branching_strategy = "whorled",
         branch_iterations = 2, seed = 3),
    list(x = 36, height = 11, trunk_height = 2.5, crown_width = 5,
         crown_shape = "conical", branching_strategy = "conifer",
         branch_iterations = 2, seed = 4)
  )
  
  shrubs <- list(
    list(x = 10, width = 2.5, height = 2, n_stems = 3, seed = 10),
    list(x = 22, width = 3, height = 2.5, n_stems = 4, seed = 11)
  )
  
  # Build and plot
  profile <- build_profile(terrain, trees, shrubs)
  
  plot_profile(profile, 
               title = "Vegetation Profile - Hillslope",
               subtitle = "Showing vegetation zonation along elevation gradient")
}


demo_ridge_profile <- function() {
  
  # Ridge terrain
  terrain <- make_terrain(
    x = c(0, 10, 18, 25, 32, 40),
    elevation = c(0, 3, 6, 5, 2, 0),
    method = "spline"
  )
  
  trees <- list(
    # Lower slope - broadleaf
    list(x = 5, height = 9, trunk_height = 3, crown_width = 6,
         crown_shape = "elliptical", branching_strategy = "radial",
         branch_iterations = 2, seed = 1),
    # Mid slope - mixed
    list(x = 12, height = 10, trunk_height = 2.5, crown_width = 4.5,
         crown_shape = "conical", branching_strategy = "conifer",
         branch_iterations = 2, seed = 2),
    # Ridge top - stunted
    list(x = 18, height = 5, trunk_height = 1.5, crown_width = 4,
         crown_shape = "elliptical", branching_strategy = "scattered",
         branch_iterations = 2, seed = 3),
    # Other side
    list(x = 25, height = 8, trunk_height = 2, crown_width = 4,
         crown_shape = "conical", branching_strategy = "conifer",
         branch_iterations = 2, seed = 4),
    list(x = 35, height = 11, trunk_height = 4, crown_width = 7,
         crown_shape = "elliptical", branching_strategy = "radial",
         branch_iterations = 2, seed = 5)
  )
  
  shrubs <- list(
    list(x = 8, width = 2, height = 1.5, n_stems = 3, seed = 20),
    list(x = 16, width = 2.5, height = 2, n_stems = 4, seed = 21),
    list(x = 21, width = 2, height = 1.8, n_stems = 3, seed = 22),
    list(x = 30, width = 2.5, height = 2, n_stems = 4, seed = 23)
  )
  
  grass_x <- c(3, 15, 19, 23, 28, 33, 37)
  
  profile <- build_profile(terrain, trees, shrubs, grass_x, grass_seed = 100)
  
  plot_profile(profile,
               title = "Vegetation Profile - Ridge Transect",
               subtitle = "Vegetation structure varies with topographic position")
}


demo_with_horizons <- function() {
  
  # Undulating terrain
  terrain <- make_terrain(
    x = c(0, 10, 20, 30, 40),
    elevation = c(1, 2.5, 1.5, 3, 2),
    method = "spline"
  )
  
  trees <- list(
    list(x = 6, height = 10, trunk_height = 3.5, crown_width = 6,
         crown_shape = "elliptical", branching_strategy = "radial",
         branch_iterations = 2, seed = 1),
    list(x = 16, height = 8, trunk_height = 2, crown_width = 4,
         crown_shape = "conical", branching_strategy = "conifer",
         branch_iterations = 2, seed = 2),
    list(x = 28, height = 11, trunk_height = 4, crown_width = 8,
         crown_shape = "elliptical", branching_strategy = "whorled",
         branch_iterations = 2, seed = 3),
    list(x = 36, height = 7, trunk_height = 2, crown_width = 4,
         crown_shape = "conical", branching_strategy = "conifer",
         branch_iterations = 2, seed = 4)
  )
  
  shrubs <- list(
    list(x = 11, width = 2.5, height = 2, n_stems = 4, seed = 10),
    list(x = 22, width = 2, height = 1.5, n_stems = 3, seed = 11)
  )
  
  profile <- build_profile(terrain, trees, shrubs)
  
  plot_profile(profile,
               title = "Vegetation Profile with Soil Horizons",
               subtitle = "Dashed lines indicate approximate soil horizon boundaries",
               show_horizons = TRUE,
               horizon_depths = c(0.8, 2))
}


# Run demos
cat("Installing gridExtra for demo layout...\n")
if (!require(gridExtra, quietly = TRUE)) {
  install.packages("gridExtra", repos = "http://cran.rstudio.com/", quiet = TRUE)
  library(gridExtra)
}

cat("\nTerrain types demo...\n")
demo_terrain_types()

cat("\nSlope profile...\n")
print(demo_slope_profile())

cat("\nRidge profile...\n")
print(demo_ridge_profile())

cat("\nProfile with soil horizons...\n")
print(demo_with_horizons())
