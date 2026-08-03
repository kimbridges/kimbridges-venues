# Vegetation Profile Diagram System - Core Components
# L-System Engine and Crown Envelope Functions

library(ggplot2)
library(dplyr)

# =============================================================================
# PART 1: L-SYSTEM ENGINE
# =============================================================================

#' Expand an L-system string through n iterations
#' 
#' @param axiom Starting string
#' @param rules Named list of production rules (e.g., list(F = "F[+F][-F]F"))
#' @param n Number of iterations
#' @return Expanded string
lsys_expand <- function(axiom, rules, n) {
  string <- axiom
  for (i in seq_len(n)) {
    new_string <- ""
    for (char in strsplit(string, "")[[1]]) {
      if (char %in% names(rules)) {
        new_string <- paste0(new_string, rules[[char]])
      } else {
        new_string <- paste0(new_string, char)
      }
    }
    string <- new_string
  }
  string
}

#' Interpret an L-system string as turtle graphics
#' 
#' Commands:
#'   F = move forward, drawing a line
#'   f = move forward, no line
#'   + = turn right by angle
#'   - = turn left by angle
#'   [ = push state (position + angle) onto stack
#'   ] = pop state from stack
#'
#' @param string L-system string to interpret
#' @param start_x Starting x position
#' @param start_y Starting y position
#' @param start_angle Starting angle in degrees (0 = up, 90 = right)
#' @param length Initial segment length
#' @param angle Turning angle in degrees
#' @param length_decay Multiplicative factor applied to length each generation
#' @return Data frame with columns: x, y, xend, yend, generation
lsys_turtle <- function(string, 
                        start_x = 0, 
                        start_y = 0, 
                        start_angle = 0,
                        length = 1, 
                        angle = 25,
                        length_decay = 0.7) {
  
  # Convert angle to radians, adjust so 0 = up
  angle_rad <- angle * pi / 180
  
  # Current state
  x <- start_x
  y <- start_y
  current_angle <- (90 - start_angle) * pi / 180  # Convert so 0° = up
  current_length <- length
  generation <- 0
  
  # Stack for branching
  stack <- list()
  
  # Collect segments
  segments <- list()
  
  for (char in strsplit(string, "")[[1]]) {
    if (char == "F") {
      # Move forward, draw line
      xend <- x + current_length * cos(current_angle)
      yend <- y + current_length * sin(current_angle)
      segments <- append(segments, list(data.frame(
        x = x, y = y, xend = xend, yend = yend, generation = generation
      )))
      x <- xend
      y <- yend
    } else if (char == "f") {
      # Move forward, no line
      x <- x + current_length * cos(current_angle)
      y <- y + current_length * sin(current_angle)
    } else if (char == "+") {
      # Turn right (clockwise)
      current_angle <- current_angle - angle_rad
    } else if (char == "-") {
      # Turn left (counter-clockwise)
      current_angle <- current_angle + angle_rad
    } else if (char == "[") {
      # Push state
      stack <- append(stack, list(list(
        x = x, y = y, angle = current_angle, 
        length = current_length, generation = generation
      )))
      current_length <- current_length * length_decay
      generation <- generation + 1
    } else if (char == "]") {
      # Pop state
      if (length(stack) > 0) {
        state <- stack[[length(stack)]]
        stack <- stack[-length(stack)]
        x <- state$x
        y <- state$y
        current_angle <- state$angle
        current_length <- state$length
        generation <- state$generation
      }
    }
  }
  
  if (length(segments) == 0) {
    return(data.frame(x = numeric(), y = numeric(), 
                      xend = numeric(), yend = numeric(),
                      generation = integer()))
  }
  
  bind_rows(segments)
}

#' Generate L-system branches with preset styles
#' 
#' @param style One of: "monopodial", "sympodial", "excurrent", "decurrent", "sparse", "palm"
#' @param iterations Number of L-system iterations
#' @param ... Additional arguments passed to lsys_turtle
#' @return Data frame of branch segments
lsys_branches <- function(style = "sympodial", 
                          iterations = 4,
                          length = 1,
                          angle = NULL,
                          length_decay = NULL,
                          ...) {
  
  # Preset rules and parameters for different branching styles
  presets <- list(
    monopodial = list(
      axiom = "F",
      rules = list(F = "F[+F]F[-F]F"),
      angle = 25,
      length_decay = 0.6
    ),
    sympodial = list(
      axiom = "F",
      rules = list(F = "F[+F][-F]"),
      angle = 30,
      length_decay = 0.75
    ),
    excurrent = list(
      axiom = "F",
      rules = list(F = "FF[++F][+F][-F][--F]"),
      angle = 22,
      length_decay = 0.55
    ),
    decurrent = list(
      axiom = "F",
      rules = list(F = "F[-F][+F]F[--F][++F]"),
      angle = 28,
      length_decay = 0.65
    ),
    sparse = list(
      axiom = "F",
      rules = list(F = "F[+F][-F]"),
      angle = 35,
      length_decay = 0.8
    ),
    palm = list(
      axiom = "F",
      rules = list(F = "F[+F][-F][++F][--F][+++F][---F]"),
      angle = 15,
      length_decay = 0.9
    )
  )
  
  if (!style %in% names(presets)) {
    stop("Unknown style. Choose from: ", paste(names(presets), collapse = ", "))
  }
  
  preset <- presets[[style]]
  
  # Allow overrides
  if (is.null(angle)) angle <- preset$angle
  if (is.null(length_decay)) length_decay <- preset$length_decay
  
  # Expand and interpret
  expanded <- lsys_expand(preset$axiom, preset$rules, iterations)
  lsys_turtle(expanded, length = length, angle = angle, 
              length_decay = length_decay, ...)
}


# =============================================================================
# PART 2: CROWN ENVELOPE FUNCTIONS
# =============================================================================

#' Generate a conical crown envelope
#' 
#' @param cx Center x position
#' @param cy Base y position (bottom of crown)
#' @param width Crown width at base
#' @param height Crown height
#' @param n Number of points for polygon
#' @return Data frame with x, y columns
crown_conical <- function(cx = 0, cy = 0, width = 2, height = 3, n = 50) {
  # Simple triangle with slightly curved sides
  t <- seq(0, 1, length.out = n %/% 2)
  
  # Left side (bottom to apex)
  left_x <- cx - (width/2) * (1 - t)^1.2
  left_y <- cy + height * t
  
 # Right side (apex to bottom)
  right_x <- cx + (width/2) * t^1.2
  right_y <- cy + height * (1 - t)
  
  data.frame(
    x = c(left_x, right_x),
    y = c(left_y, right_y)
  )
}

#' Generate an elliptical crown envelope
#' 
#' @param cx Center x position
#' @param cy Center y position
#' @param width Crown width
#' @param height Crown height
#' @param n Number of points
#' @return Data frame with x, y columns
crown_elliptical <- function(cx = 0, cy = 0, width = 3, height = 2, n = 100) {
  theta <- seq(0, 2 * pi, length.out = n)
  data.frame(
    x = cx + (width / 2) * cos(theta),
    y = cy + (height / 2) * sin(theta)
  )
}

#' Generate a superellipse crown envelope
#' 
#' The superellipse |x/a|^n + |y/b|^n = 1 allows smooth transitions:
#'   n = 2: regular ellipse
#'   n > 2: more rectangular (flat-topped)
#'   n < 2: more diamond-shaped (pinched)
#'
#' @param cx Center x position  
#' @param cy Center y position
#' @param width Crown width
#' @param height Crown height
#' @param exponent Shape exponent (2 = ellipse, >2 = rectangular, <2 = pinched)
#' @param n Number of points
#' @return Data frame with x, y columns
crown_superellipse <- function(cx = 0, cy = 0, width = 3, height = 2, 
                                exponent = 2.5, n = 100) {
  theta <- seq(0, 2 * pi, length.out = n)
  a <- width / 2
  b <- height / 2
  
  # Superellipse parametric form
  x <- a * sign(cos(theta)) * abs(cos(theta))^(2/exponent)
  y <- b * sign(sin(theta)) * abs(sin(theta))^(2/exponent)
  
  data.frame(x = cx + x, y = cy + y)
}

#' Generate a flat-topped (umbrella/acacia) crown envelope
#' 
#' @param cx Center x position
#' @param cy Base y position
#' @param width Crown width
#' @param height Crown height
#' @param flat_ratio Proportion of width that is flat on top (0-1)
#' @param n Number of points
#' @return Data frame with x, y columns
crown_flat_topped <- function(cx = 0, cy = 0, width = 4, height = 1.5, 
                               flat_ratio = 0.6, n = 100) {
  # Use superellipse with high exponent for top, blend to rounded bottom
  theta <- seq(0, 2 * pi, length.out = n)
  a <- width / 2
  b <- height / 2
  
  # Variable exponent: high on top (flat), lower on bottom (rounded)
  # Map theta so top is flat
  exp_top <- 4
  exp_bottom <- 2
  
  # Blend based on y position
  blend <- (sin(theta) + 1) / 2  # 0 at bottom, 1 at top
  exponent <- exp_bottom + (exp_top - exp_bottom) * blend^2
  
  x <- a * sign(cos(theta)) * abs(cos(theta))^(2/exponent)
  y <- b * sign(sin(theta)) * abs(sin(theta))^(2/exponent)
  
  data.frame(x = cx + x, y = cy + y)
}

#' Generate an irregular crown envelope by adding noise to a base shape
#' 
#' @param base_shape Data frame with x, y from a base crown function
#' @param roughness Standard deviation of noise relative to crown size
#' @param frequency Number of bumps around perimeter
#' @param seed Random seed for reproducibility
#' @return Data frame with x, y columns
crown_irregular <- function(base_shape, roughness = 0.1, frequency = 8, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)
  
  n <- nrow(base_shape)
  
  # Calculate center
  cx <- mean(base_shape$x)
  cy <- mean(base_shape$y)
  
  # Convert to polar
  dx <- base_shape$x - cx
  dy <- base_shape$y - cy
  r <- sqrt(dx^2 + dy^2)
  theta <- atan2(dy, dx)
  
  # Add smooth noise using sum of sinusoids
  noise <- numeric(n)
  for (f in 1:3) {
    phase <- runif(1, 0, 2 * pi)
    noise <- noise + rnorm(1, 0, roughness/f) * sin(frequency * f * theta + phase)
  }
  
  # Scale noise by local radius
  r_noisy <- r * (1 + noise)
  
  data.frame(
    x = cx + r_noisy * cos(theta),
    y = cy + r_noisy * sin(theta)
  )
}

#' Generate a shrub envelope (multi-lobed, ground-based)
#' 
#' @param cx Center x position
#' @param cy Base y position (ground level)
#' @param width Total width
#' @param height Total height
#' @param lobes Number of crown lobes
#' @param seed Random seed
#' @return Data frame with x, y columns
crown_shrub <- function(cx = 0, cy = 0, width = 2, height = 1.5, 
                         lobes = 3, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)
  
  n <- 200
  theta <- seq(0, pi, length.out = n)  # Only top half
  
  a <- width / 2
  b <- height
  
  # Base ellipse (top half only)
  base_r <- sqrt((a * cos(theta))^2 + (b * sin(theta))^2) / 
            sqrt((cos(theta))^2 + (sin(theta))^2 + 0.001)
  
  # Add lobes
  lobe_amp <- 0.15 * height
  lobe_variation <- lobe_amp * sin(lobes * theta) * sin(theta)
  
  # Add some noise
  noise <- runif(n, -0.05, 0.05) * height
  
  r <- b * sin(theta) + lobe_variation + noise
  r <- pmax(r, 0.05)  # Keep positive
  
  x <- a * cos(theta)
  y <- r
  
  # Close the polygon along the ground
  data.frame(
    x = cx + c(x, rev(x)[1], x[1]),
    y = cy + c(y, 0, 0)
  )
}

#' Generate a grass/herb tuft envelope
#' 
#' @param cx Center x position
#' @param cy Base y position
#' @param width Tuft width
#' @param height Tuft height
#' @param seed Random seed
#' @return Data frame with x, y columns
crown_grass <- function(cx = 0, cy = 0, width = 0.5, height = 0.8, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)
  
  # Simple mound shape
  n <- 50
  theta <- seq(0, pi, length.out = n)
  
  x <- (width / 2) * cos(theta)
  y <- height * sin(theta)^1.5  # Slightly more peaked
  
  # Add subtle noise
  noise <- runif(n, -0.05, 0.05) * height
  y <- y + noise * sin(theta)
  
  data.frame(
    x = cx + c(x, x[1]),
    y = cy + c(y, 0)
  )
}


# =============================================================================
# PART 3: CLIPPING BRANCHES TO CROWN
# =============================================================================

#' Test if points are inside a polygon
#' 
#' Uses ray casting algorithm
#' 
#' @param px Vector of x coordinates to test
#' @param py Vector of y coordinates to test
#' @param poly_x Polygon x coordinates
#' @param poly_y Polygon y coordinates
#' @return Logical vector
point_in_polygon <- function(px, py, poly_x, poly_y) {
  n <- length(poly_x)
  inside <- logical(length(px))
  
  for (i in seq_along(px)) {
    x <- px[i]
    y <- py[i]
    
    j <- n
    c <- FALSE
    
    for (k in 1:n) {
      if (((poly_y[k] > y) != (poly_y[j] > y)) &&
          (x < (poly_x[j] - poly_x[k]) * (y - poly_y[k]) / (poly_y[j] - poly_y[k]) + poly_x[k])) {
        c <- !c
      }
      j <- k
    }
    inside[i] <- c
  }
  
  inside
}

#' Clip branch segments to a crown envelope
#' 
#' Keeps segments where both endpoints are inside the crown,
#' or where at least the endpoint is inside (for segments originating from trunk)
#' 
#' @param branches Data frame with x, y, xend, yend columns
#' @param crown Data frame with x, y columns defining polygon
#' @param keep_partial If TRUE, keep segments where at least endpoint is inside
#' @return Filtered data frame of branches
clip_branches_to_crown <- function(branches, crown, keep_partial = TRUE) {
  if (nrow(branches) == 0) return(branches)
  
  # Test all endpoints
  start_inside <- point_in_polygon(branches$x, branches$y, crown$x, crown$y)
  end_inside <- point_in_polygon(branches$xend, branches$yend, crown$x, crown$y)
  
  if (keep_partial) {
    # Keep if either end is inside
    keep <- start_inside | end_inside
  } else {
    # Keep only if both ends are inside
    keep <- start_inside & end_inside
  }
  
  branches[keep, ]
}


# =============================================================================
# PART 4: TREE ASSEMBLY FUNCTION
# =============================================================================

#' Generate a complete tree with trunk and branches
#' 
#' @param x X position of tree base
#' @param ground_y Y position of ground at tree location
#' @param height Total tree height
#' @param trunk_height Height of trunk (below crown)
#' @param crown_width Width of crown
#' @param crown_height Height of crown
#' @param crown_shape One of: "conical", "elliptical", "superellipse", "flat_topped"
#' @param branch_style Branching style for L-system
#' @param branch_iterations L-system iterations
#' @param irregular Add irregularity to crown?
#' @param seed Random seed for reproducibility
#' @return List with components: trunk, branches, crown
make_tree <- function(x = 0,
                      ground_y = 0,
                      height = 10,
                      trunk_height = 4,
                      crown_width = 6,
                      crown_height = NULL,
                      crown_shape = "elliptical",
                      crown_exponent = 2.5,  # For superellipse
                      branch_style = "sympodial",
                      branch_iterations = 4,
                      branch_angle = NULL,
                      branch_decay = NULL,
                      irregular = TRUE,
                      roughness = 0.08,
                      seed = NULL) {
  
  if (!is.null(seed)) set.seed(seed)
  
  # Default crown height if not specified
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
  
  # Crown center position
  crown_cy <- ground_y + trunk_height + crown_height / 2
  
  # Generate crown envelope
  crown <- switch(crown_shape,
    conical = crown_conical(x, ground_y + trunk_height, crown_width, crown_height),
    elliptical = crown_elliptical(x, crown_cy, crown_width, crown_height),
    superellipse = crown_superellipse(x, crown_cy, crown_width, crown_height, crown_exponent),
    flat_topped = crown_flat_topped(x, crown_cy, crown_width, crown_height * 0.8),
    stop("Unknown crown shape")
  )
  
  # Add irregularity if requested
  if (irregular) {
    crown <- crown_irregular(crown, roughness = roughness, seed = seed)
  }
  
  # Generate branches
  # Start from top of trunk, scale length to crown
  branch_length <- crown_height * 0.4
  
  branches <- lsys_branches(
    style = branch_style,
    iterations = branch_iterations,
    start_x = x,
    start_y = ground_y + trunk_height,
    length = branch_length,
    angle = branch_angle,
    length_decay = branch_decay
  )
  
  # Clip branches to crown
  branches <- clip_branches_to_crown(branches, crown)
  
  list(
    trunk = trunk,
    branches = branches,
    crown = crown
  )
}


# =============================================================================
# PART 5: DEMONSTRATION
# =============================================================================

# Demo: Show different crown shapes
demo_crowns <- function() {
  
  crowns <- bind_rows(
    crown_conical(0, 0, 2, 3) %>% mutate(shape = "Conical"),
    crown_elliptical(4, 1.5, 3, 2) %>% mutate(shape = "Elliptical"),
    crown_superellipse(8, 1.5, 3, 2, exponent = 3) %>% mutate(shape = "Superellipse (n=3)"),
    crown_flat_topped(12, 1.5, 4, 1.5) %>% mutate(shape = "Flat-topped"),
    crown_shrub(16, 0, 2.5, 2) %>% mutate(shape = "Shrub"),
    crown_grass(19, 0, 0.8, 1) %>% mutate(shape = "Grass")
  )
  
  ggplot(crowns, aes(x, y)) +
    geom_polygon(aes(fill = shape), alpha = 0.3, color = "darkgreen") +
    coord_equal() +
    labs(title = "Crown Envelope Shapes", fill = "Shape") +
    theme_minimal() +
    theme(legend.position = "bottom")
}

# Demo: Show different branching styles
demo_branches <- function() {
  
  styles <- c("monopodial", "sympodial", "excurrent", "decurrent", "sparse")
  
  all_branches <- lapply(seq_along(styles), function(i) {
    branches <- lsys_branches(styles[i], iterations = 4, 
                              start_x = (i - 1) * 4, length = 1.5)
    branches$style <- styles[i]
    branches
  }) %>% bind_rows()
  
  # Add line weight based on generation
  all_branches <- all_branches %>%
    mutate(weight = 1 / (generation + 1))
  
  ggplot(all_branches, aes(x = x, y = y, xend = xend, yend = yend)) +
    geom_segment(aes(linewidth = weight), color = "saddlebrown") +
    scale_linewidth_continuous(range = c(0.2, 1.5), guide = "none") +
    facet_wrap(~ style, nrow = 1) +
    coord_equal() +
    labs(title = "L-System Branching Styles") +
    theme_minimal() +
    theme(axis.text = element_blank(), axis.title = element_blank())
}

# Demo: Complete trees
demo_trees <- function() {
  
  # Create several trees with different characteristics
  tree1 <- make_tree(x = 0, height = 12, trunk_height = 4, crown_width = 7,
                     crown_shape = "elliptical", branch_style = "decurrent", 
                     seed = 42)
  
  tree2 <- make_tree(x = 10, height = 15, trunk_height = 6, crown_width = 5,
                     crown_shape = "conical", branch_style = "excurrent",
                     seed = 123)
  
  tree3 <- make_tree(x = 18, height = 8, trunk_height = 3, crown_width = 10,
                     crown_shape = "flat_topped", branch_style = "decurrent",
                     seed = 456)
  
  # Combine all elements
  trunks <- bind_rows(tree1$trunk, tree2$trunk, tree3$trunk)
  branches <- bind_rows(
    tree1$branches %>% mutate(tree = 1),
    tree2$branches %>% mutate(tree = 2),
    tree3$branches %>% mutate(tree = 3)
  )
  crowns <- bind_rows(
    tree1$crown %>% mutate(tree = 1),
    tree2$crown %>% mutate(tree = 2),
    tree3$crown %>% mutate(tree = 3)
  )
  
  # Add line weight
  branches <- branches %>%
    mutate(weight = 1 / (generation + 1))
  
  # Ground line
  ground <- data.frame(x = c(-5, 25), y = c(0, 0))
  
  ggplot() +
    # Crown fill (light)
    geom_polygon(data = crowns, aes(x, y, group = tree), 
                 fill = "darkgreen", alpha = 0.15) +
    # Ground
    geom_ribbon(data = data.frame(x = c(-5, 25), ymin = -2, ymax = 0),
                aes(x = x, ymin = ymin, ymax = ymax), fill = "tan4", alpha = 0.3) +
    # Trunks
    geom_segment(data = trunks, aes(x = x, y = y, xend = xend, yend = yend),
                 color = "saddlebrown", linewidth = 2) +
    # Branches
    geom_segment(data = branches, 
                 aes(x = x, y = y, xend = xend, yend = yend, linewidth = weight),
                 color = "saddlebrown") +
    scale_linewidth_continuous(range = c(0.1, 1.2), guide = "none") +
    # Crown outline
    geom_polygon(data = crowns, aes(x, y, group = tree), 
                 fill = NA, color = "darkgreen", linewidth = 0.5) +
    coord_equal() +
    labs(title = "Vegetation Profile - Three Tree Types",
         subtitle = "Rounded broadleaf | Conical conifer | Flat-topped acacia-type") +
    theme_minimal() +
    theme(axis.text = element_blank(), 
          axis.title = element_blank(),
          panel.grid = element_blank())
}

# Run demos
cat("Running crown shape demo...\n")
print(demo_crowns())

cat("\nRunning branching styles demo...\n")
print(demo_branches())

cat("\nRunning complete trees demo...\n")
print(demo_trees())

cat("\n\nCore functions available:\n")
cat("  Crown envelopes: crown_conical(), crown_elliptical(), crown_superellipse(),\n")
cat("                   crown_flat_topped(), crown_shrub(), crown_grass()\n")
cat("  Irregularity:    crown_irregular()\n")
cat("  L-system:        lsys_expand(), lsys_turtle(), lsys_branches()\n")
cat("  Clipping:        clip_branches_to_crown()\n")
cat("  Assembly:        make_tree()\n")
