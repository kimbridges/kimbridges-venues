# Canopy: add what the points don't know.

## ---- internal helpers --------------------------------------------------------

## the Meta / WRI canopy height tiles are named by zoom-9 quadkeys (Web Mercator)
meta_chm_url <- "https://dataforgood-fb-data.s3.amazonaws.com/forests/v1/alsgedi_global_v6_float/chm/"

## quadkey of the tile holding a longitude and latitude, at a zoom level
quadkey <- function(lon, lat, zoom = 9) {
  lat <- max(min(lat, 85.05112878), -85.05112878)
  n <- 2^zoom
  x <- floor((lon + 180) / 360 * n)
  y <- floor((1 - log(tan(lat * pi / 180) + 1 / cos(lat * pi / 180)) / pi) / 2 * n)
  x <- min(max(x, 0), n - 1)
  y <- min(max(y, 0), n - 1)
  digits <- vapply(zoom:1, function(i) {
    mask <- 2^(i - 1)
    ((x %/% mask) %% 2) + 2 * ((y %/% mask) %% 2)
  }, numeric(1))
  paste(digits, collapse = "")
}

## all the zoom-9 quadkeys that cover a frame
quadkeys_for <- function(frame, zoom = 9) {
  bb <- sf::st_bbox(sf::st_transform(frame, 4326))
  ## step at a quarter of a tile's width so no tile is skipped
  step_lon <- 360 / 2^zoom / 4
  lons <- unique(c(seq(bb["xmin"], bb["xmax"], by = step_lon), bb["xmax"]))
  lat_range <- c(bb["ymin"], bb["ymax"])
  lats <- unique(c(seq(lat_range[1], lat_range[2], by = step_lon * cos(mean(lat_range) * pi / 180)), lat_range[2]))
  grid <- expand.grid(lon = lons, lat = lats)
  unique(mapply(quadkey, grid$lon, grid$lat, MoreArgs = list(zoom = zoom)))
}

## the number of cells in a square window about `meters` wide (odd, at least 1)
window_cells <- function(meters, cell) {
  k <- max(1, round(meters / cell))
  if (k %% 2 == 0) k <- k + 1
  k
}

## smooth a raster with a moving average over a square window
smooth_raster <- function(r, meters) {
  if (is.null(meters) || meters <= 0) return(r)
  k <- window_cells(meters, terra::res(r)[1])
  if (k == 1) return(r)
  terra::focal(r, w = matrix(1, k, k) / (k * k), na.rm = TRUE)
}

## ---- get_canopy_height -------------------------------------------------------

#' Get canopy height for any area
#'
#' Reads the global 1 m canopy height map released by Meta and the World
#' Resources Institute (Tolan et al. 2024) for a frame, and averages it onto a
#' grid of `resolution` meters in the frame's coordinate system. The map is
#' read over the web from its public storage; no account or key is needed. It
#' is modeled from satellite images and calibrated against airborne lidar, so
#' its edges are softer than lidar's.
#'
#' The map is stored as tiles named by Web Mercator quadkeys. The function
#' works out which tiles cover the frame, reads only the part of each it needs,
#' and joins them.
#'
#' @param frame The area: an `sf`/`sfc` polygon or a `bbox`, in a projected
#'   coordinate system (meters).
#' @param resolution Cell size of the result, in meters.
#' @param pad Extra meters read around the frame before averaging, so cells at
#'   the edge are complete.
#' @return A `terra` SpatRaster of canopy height in meters, named
#'   `canopy_height_m`, on a grid of `resolution` meters covering the frame.
#' @references Tolan, J. et al. 2024. Very high resolution canopy height maps
#'   from RGB imagery using self-supervised vision transformer and
#'   convolutional decoder trained on aerial lidar. Remote Sensing of
#'   Environment 300: 113888. \doi{10.1016/j.rse.2023.113888}
#' @seealso [structure_classes()], [trace_patch()]
#' @examples
#' \dontrun{
#' canopy <- get_canopy_height(kipuka_frame())
#' terra::plot(canopy)
#' }
#' @export
get_canopy_height <- function(frame, resolution = 5, pad = 50) {
  frame <- as_frame(frame)
  check_projected(frame, "frame")
  crs <- sf::st_crs(frame)

  ## the tiles that cover the frame, read only where they overlap it
  keys <- quadkeys_for(sf::st_buffer(frame, pad))
  area_3857 <- terra::vect(sf::st_transform(sf::st_buffer(frame, pad), 3857))
  pieces <- list()
  for (k in keys) {
    tile <- tryCatch(terra::rast(paste0("/vsicurl/", meta_chm_url, k, ".tif")), error = function(e) NULL)
    if (is.null(tile)) next
    area <- terra::project(area_3857, terra::crs(tile))
    if (is.null(terra::intersect(terra::ext(tile), terra::ext(area)))) next
    pieces[[length(pieces) + 1]] <- terra::crop(tile, area)
  }
  if (length(pieces) == 0) stop("No canopy height tiles cover this frame (or they could not be read).", call. = FALSE)
  chm <- if (length(pieces) == 1) pieces[[1]] else do.call(terra::merge, unname(pieces))

  ## average onto the frame's own grid
  bb <- sf::st_bbox(frame)
  grid <- terra::rast(terra::ext(bb["xmin"], bb["xmax"], bb["ymin"], bb["ymax"]),
                      resolution = resolution, crs = crs$wkt)
  out <- terra::project(chm, grid, method = "average")
  names(out) <- "canopy_height_m"
  out
}

## ---- structure_classes -------------------------------------------------------

#' Classes of canopy structure
#'
#' Turns canopy heights into a few classes of structure in three steps, each an
#' explicit choice (*The Map That Never Got Drawn*, Chapter 8):
#' \enumerate{
#'   \item Smooth: each cell takes the average height of the square window
#'     around it, so a single tall tree on open ground doesn't make a patch of
#'     forest.
#'   \item Break the heights into classes. The defaults (2, 5 and 10 m) give
#'     open, low, woodland and forest; 5 m is the line between scrub and forest
#'     used on the 1974 vegetation map of Hawai'i Volcanoes National Park.
#'   \item Set a minimum mapping unit: patches smaller than `mmu_ha` join their
#'     neighbors. This is the scale of the map.
#' }
#'
#' @param canopy A SpatRaster of canopy height in meters, such as from
#'   [get_canopy_height()].
#' @param breaks Heights (m) that separate the classes.
#' @param labels Class names, one more than `breaks`.
#' @param smooth Width (m) of the smoothing window; 0 for none.
#' @param mmu_ha Minimum mapping unit in hectares; 0 for none.
#' @return A categorical SpatRaster named `structure`, with classes numbered
#'   from 1 (lowest) and labeled with `labels`.
#' @seealso [constrained_voronoi()]
#' @examples
#' r <- terra::rast(nrows = 60, ncols = 60, xmin = 0, xmax = 300, ymin = 0, ymax = 300,
#'                  crs = "EPSG:32605", vals = rep(c(0.5, 12), each = 1800))
#' structure_classes(r, mmu_ha = 0.5)
#' @export
structure_classes <- function(canopy, breaks = c(2, 5, 10),
                              labels = c("open", "low", "woodland", "forest"),
                              smooth = 25, mmu_ha = 2) {
  if (length(labels) != length(breaks) + 1) stop("`labels` needs one more entry than `breaks`.", call. = FALSE)
  sm <- smooth_raster(canopy[[1]], smooth)
  edges <- c(-Inf, breaks, Inf)
  cls <- terra::classify(sm, cbind(edges[-length(edges)], edges[-1], seq_along(labels)))
  if (mmu_ha > 0) {
    cells <- round((mmu_ha * 10000) / prod(terra::res(cls)))
    cls <- terra::sieve(cls, threshold = cells, directions = 8)
  }
  names(cls) <- "structure"
  levels(cls) <- data.frame(id = seq_along(labels), structure = labels)
  cls
}

## ---- trace_patch -------------------------------------------------------------

#' Trace the outline of a patch of tall canopy
#'
#' Traces the kind of outline a person once drew by hand from an air photo:
#' the edge of the connected patch of tall canopy that holds a seed point
#' (*The Map That Never Got Drawn*, Chapter 8, where it traces Kipuka Puaulu).
#' Heights are smoothed, cells taller than `height` are kept, the patch that
#' holds `seed` is chosen (cells touching by edges, not corners), its outline
#' is softened by a buffer out and back in, and small openings inside it are
#' filled so that glades belong to the patch.
#'
#' @param canopy A SpatRaster of canopy height in meters.
#' @param seed A point inside the patch: an `sf`/`sfc` point, or a numeric
#'   `c(x, y)` in the raster's coordinates.
#' @param height Canopy height (m) that defines the patch.
#' @param smooth Width (m) of the smoothing window.
#' @param soften Buffer distance (m), out and back in, that softens the
#'   stair-steps of the cells.
#' @param fill_holes Keep only the outer ring, so openings inside belong to the
#'   patch?
#' @return An `sf` object with one polygon and its `area_ha`.
#' @seealso [get_canopy_height()], [tile_points()] (whose `clip` can use the
#'   outline)
#' @examples
#' ## a round stand of tall trees on open ground
#' r <- terra::rast(nrows = 100, ncols = 100, xmin = 0, xmax = 500, ymin = 0, ymax = 500,
#'                  crs = "EPSG:32605")
#' xy <- terra::xyFromCell(r, seq_len(terra::ncell(r)))
#' terra::values(r) <- ifelse(sqrt((xy[, 1] - 250)^2 + (xy[, 2] - 250)^2) < 150, 15, 1)
#' trace_patch(r, c(250, 250))
#' @export
trace_patch <- function(canopy, seed, height = 8, smooth = 25, soften = 20, fill_holes = TRUE) {
  crs <- sf::st_crs(terra::crs(canopy))
  if (is.numeric(seed)) seed <- sf::st_sfc(sf::st_point(seed[1:2]), crs = crs)
  seed <- sf::st_geometry(seed)
  if (sf::st_crs(seed) != crs) seed <- sf::st_transform(seed, crs)

  ## smoothed heights, tall cells, and their connected patches
  sm <- smooth_raster(canopy[[1]], smooth)
  tall <- terra::ifel(sm > height, 1, NA)
  pieces <- terra::patches(tall, directions = 4)
  id <- terra::extract(pieces, terra::vect(seed))[1, 2]
  if (is.na(id)) stop("The seed point is not in canopy taller than ", height, " m.", call. = FALSE)

  ## the chosen patch as a polygon, softened
  patch <- sf::st_as_sf(terra::as.polygons(terra::ifel(pieces == id, 1, NA)))
  patch <- sf::st_buffer(sf::st_buffer(sf::st_geometry(patch), soften), -soften)
  parts <- sf::st_cast(sf::st_union(patch), "POLYGON")
  largest <- parts[[which.max(sf::st_area(parts))]]
  if (fill_holes) largest <- sf::st_polygon(list(largest[[1]]))
  out <- sf::st_sf(geometry = sf::st_sfc(largest, crs = crs))
  out$area_ha <- as.numeric(sf::st_area(out)) / 10000
  out
}

## ---- constrained_voronoi -----------------------------------------------------

#' Plain or structure-constrained Voronoi map on a grid
#'
#' Assigns every cell of a grid to a point. With `constrained = FALSE`, each
#' cell takes the category of its nearest point: an ordinary Voronoi map,
#' drawn in cells. With `constrained = TRUE`, each cell takes the category of
#' the nearest point *in the same structure class*; a point in a different
#' kind of canopy counts as infinitely far away (*The Map That Never Got
#' Drawn*, Chapter 8). The canopy then decides where the boundaries go, and the
#' points still decide what the tiles are called.
#'
#' Each point's structure class is read from `classes` at its location, unless
#' `point_class` names a column that records it. A field team records the
#' structure at the plot, and that record should win over a smoothed map.
#'
#' Patches of a structure class that hold no point take their category from a
#' point elsewhere in the class. The second layer, `sampled`, marks the cells
#' in patches that do hold a point, so extended labels can be shown as such.
#'
#' @param points An `sf` object of points.
#' @param type Name of the column in `points` that holds the category.
#' @param classes A SpatRaster of structure classes, such as from
#'   [structure_classes()]. It also sets the grid.
#' @param constrained Use the structure rule?
#' @param point_class Optional name of a column in `points` with each point's
#'   own structure class (as numbers matching `classes`).
#' @param mmu_ha Minimum mapping unit (ha) applied to the finished constrained
#'   map; 0 for none.
#' @return A SpatRaster with two layers: `type` (categorical, labeled with the
#'   categories in `points[[type]]`; cells whose class holds no point are `NA`)
#'   and `sampled` (1 where the cell's structure patch holds a point, 0
#'   elsewhere; all 1 for a plain map).
#' @seealso [structure_classes()], [map_agreement()]
#' @examples
#' ## two kinds of canopy, a point of each kind on each side
#' r <- terra::rast(nrows = 40, ncols = 40, xmin = 0, xmax = 400, ymin = 0, ymax = 400,
#'                  crs = "EPSG:32605")
#' xy <- terra::xyFromCell(r, seq_len(terra::ncell(r)))
#' terra::values(r) <- ifelse(xy[, 2] > 200, 2, 1)
#' pts <- sf::st_as_sf(data.frame(x = c(100, 300, 100, 300), y = c(100, 100, 300, 300),
#'                                veg = c("A", "B", "C", "D")),
#'                     coords = c("x", "y"), crs = 32605)
#' terra::plot(constrained_voronoi(pts, "veg", r, mmu_ha = 0)$type)
#' @export
constrained_voronoi <- function(points, type, classes, constrained = TRUE,
                                point_class = NULL, mmu_ha = 2) {
  if (!type %in% names(points)) stop("Column `", type, "` is not in `points`.", call. = FALSE)
  crs <- sf::st_crs(terra::crs(classes))
  if (sf::st_crs(points) != crs) points <- sf::st_transform(points, crs)
  ## the class numbers, without any category labels
  cls <- terra::setValues(terra::rast(classes[[1]]), terra::values(classes[[1]])[, 1])

  ## categories as numbers, and each point's structure class
  cats <- sort(unique(as.character(points[[type]])))
  point_type <- match(as.character(points[[type]]), cats)
  pxy <- sf::st_coordinates(points)
  pclass <- if (!is.null(point_class)) as.numeric(points[[point_class]]) else
    as.numeric(terra::extract(cls, terra::vect(points), ID = FALSE)[, 1])
  if (constrained && anyNA(pclass)) stop("Some points fall outside `classes` or on NA cells.", call. = FALSE)

  ## the nearest point for every cell, with or without the structure rule
  cell_xy <- terra::xyFromCell(cls, seq_len(terra::ncell(cls)))
  cell_class <- as.numeric(terra::values(cls)[, 1])
  best <- rep(Inf, nrow(cell_xy))
  out  <- rep(NA_integer_, nrow(cell_xy))
  for (i in seq_len(nrow(pxy))) {
    d <- ((cell_xy[, 1] - pxy[i, 1])^2) + ((cell_xy[, 2] - pxy[i, 2])^2)
    if (constrained) d[is.na(cell_class) | cell_class != pclass[i]] <- Inf
    closer <- d < best
    best[closer] <- d[closer]
    out[closer]  <- point_type[i]
  }

  ## the map, with the mapping unit applied to a constrained map
  type_map <- terra::setValues(terra::rast(cls), out)
  if (constrained && mmu_ha > 0) {
    cells <- round((mmu_ha * 10000) / prod(terra::res(type_map)))
    type_map <- terra::sieve(type_map, threshold = cells, directions = 8)
  }
  names(type_map) <- "type"
  levels(type_map) <- data.frame(id = seq_along(cats), type = cats)

  ## which structure patches hold a point
  sampled <- terra::setValues(terra::rast(cls), 1L)
  if (constrained) {
    patch_id <- terra::rast(cls)
    terra::values(patch_id) <- NA
    offset <- 0
    for (k in sort(unique(stats::na.omit(cell_class)))) {
      pk <- terra::patches(terra::ifel(cls == k, 1, NA), directions = 8)
      patch_id <- terra::cover(patch_id, pk + offset)
      offset <- offset + terra::global(pk, "max", na.rm = TRUE)[1, 1]
    }
    held <- unique(terra::extract(patch_id, terra::vect(points), ID = FALSE)[, 1])
    sampled <- terra::setValues(sampled, as.integer(terra::values(patch_id)[, 1] %in% held))
  }
  names(sampled) <- "sampled"
  c(type_map, sampled)
}
