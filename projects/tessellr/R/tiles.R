# Tiles: build Voronoi tiles and read what they say.

## ---- internal helpers --------------------------------------------------------

## stop unless x has a projected (meter-based) coordinate system
check_projected <- function(x, what = "points") {
  if (is.na(sf::st_crs(x))) {
    stop("`", what, "` has no coordinate system. Set one with sf::st_set_crs().", call. = FALSE)
  }
  if (sf::st_is_longlat(x)) {
    stop("`", what, "` uses longitude and latitude. Transform it to a projected ",
         "system in meters (for example a UTM zone) with sf::st_transform().", call. = FALSE)
  }
  invisible(TRUE)
}

## a single polygon geometry (sfc) from an sf, sfc or bbox frame
as_frame <- function(frame) {
  if (inherits(frame, "bbox")) frame <- sf::st_as_sfc(frame)
  sf::st_union(sf::st_geometry(frame))
}

## the points behind a set of tiles made by tile_points()
tile_centers <- function(tiles) {
  if (!all(c("point_x", "point_y") %in% names(tiles))) {
    stop("`tiles` must come from tile_points(), which records each tile's point.", call. = FALSE)
  }
  sf::st_as_sf(sf::st_drop_geometry(tiles)[, c("point_x", "point_y")],
               coords = c("point_x", "point_y"), crs = sf::st_crs(tiles))
}

## tiles that share a stretch of border (not just a corner)
shared_border <- function(tiles) {
  sf::st_relate(tiles, tiles, pattern = "F***1****")
}

## ---- tile_points -------------------------------------------------------------

#' Build Voronoi tiles around points
#'
#' Builds one tile around each point: every place inside a tile is closer to
#' that tile's point than to any other point. The tiles are trimmed to a frame,
#' and each tile carries the attributes of its point.
#'
#' A Voronoi tessellation has no natural edge, so the frame matters. A frame of
#' convenience (a rectangle around the points) says nothing about the land, and
#' the size of the tiles along it depends on where it was drawn. A meaningful
#' boundary (the edge of a wetland, a kipuka or an ahupua'a) can be given as
#' `clip`, in one of two ways:
#' \describe{
#'   \item{`clip_mode = "all"`}{Tessellate all the points, then cut the tiles to
#'     the boundary. Points outside the boundary still claim part of it.}
#'   \item{`clip_mode = "inside"`}{Use only the points inside the boundary, and
#'     let their tiles fill it. Points outside have no say.}
#' }
#'
#' @param points An `sf` object of points in a projected coordinate system
#'   (meters). No two points may share a location.
#' @param frame The study area: an `sf`/`sfc` polygon or a `bbox`. If `NULL`,
#'   the bounding box of the points, enlarged by `expand` on every side.
#' @param clip Optional polygon (`sf` or `sfc`) of a meaningful boundary.
#' @param clip_mode `"all"` or `"inside"`; see Details.
#' @param expand Fraction of the points' extent added on every side when
#'   `frame` is `NULL`.
#' @return An `sf` polygon object with one row per tile, in the order of
#'   `points` (points outside the frame, or outside `clip` with
#'   `clip_mode = "inside"`, get no tile). Columns:
#'   `tile_id` (the row of the point in `points`), the point's attributes,
#'   `point_x` and `point_y` (its coordinates), `area_m2`, and the geometry.
#' @seealso [tile_measures()], [merge_tiles()], [boundary_bands()]
#' @examples
#' pts <- sf::st_as_sf(kipuka_releves, coords = c("easting", "northing"), crs = 32605)
#' tiles <- tile_points(pts, kipuka_frame())
#' tiles[, c("releve", "vegetation", "area_m2")]
#' @export
tile_points <- function(points, frame = NULL, clip = NULL,
                        clip_mode = c("all", "inside"), expand = 0.05) {
  clip_mode <- match.arg(clip_mode)
  if (!inherits(points, "sf")) stop("`points` must be an sf object.", call. = FALSE)
  if (!all(sf::st_geometry_type(points) == "POINT")) {
    stop("`points` must contain POINT geometries only.", call. = FALSE)
  }
  check_projected(points)
  xy <- sf::st_coordinates(points)
  if (anyDuplicated(xy)) stop("Two or more points share a location; remove the duplicates first.", call. = FALSE)

  ## the frame
  if (is.null(frame)) {
    bb <- sf::st_bbox(points)
    pad <- expand * max(bb["xmax"] - bb["xmin"], bb["ymax"] - bb["ymin"])
    bb[c("xmin", "ymin")] <- bb[c("xmin", "ymin")] - pad
    bb[c("xmax", "ymax")] <- bb[c("xmax", "ymax")] + pad
    frame <- bb
  }
  frame <- as_frame(frame)
  if (sf::st_crs(frame) != sf::st_crs(points)) frame <- sf::st_transform(frame, sf::st_crs(points))

  ## keep track of each point, and record its coordinates
  pts <- points
  pts$tile_id <- seq_len(nrow(pts))
  pts$point_x <- xy[, 1]
  pts$point_y <- xy[, 2]

  ## with clip_mode = "inside", only the points inside the boundary take part
  if (!is.null(clip)) {
    clip <- as_frame(clip)
    if (sf::st_crs(clip) != sf::st_crs(points)) clip <- sf::st_transform(clip, sf::st_crs(points))
    if (clip_mode == "inside") {
      pts   <- pts[lengths(sf::st_intersects(pts, clip)) > 0, ]
      if (nrow(pts) == 0) stop("No points fall inside `clip`.", call. = FALSE)
      frame <- clip
    }
  }

  ## the three steps: tessellate, split into polygons, trim to the frame
  if (nrow(pts) == 1) {
    polys <- frame
  } else {
    envelope <- sf::st_as_sfc(sf::st_bbox(frame))
    polys <- sf::st_collection_extract(sf::st_voronoi(sf::st_union(sf::st_geometry(pts)), envelope = envelope))
  }
  polys <- suppressWarnings(sf::st_intersection(polys, frame))
  tiles <- sf::st_sf(geometry = polys)

  ## attach each tile to its point (points outside the frame get no tile)
  tiles <- sf::st_join(tiles, pts, join = sf::st_intersects, left = FALSE)
  tiles <- tiles[!duplicated(tiles$tile_id), ]

  ## with clip_mode = "all", cut the finished tiles to the boundary
  if (!is.null(clip) && clip_mode == "all") {
    tiles <- suppressWarnings(sf::st_intersection(tiles, clip))
  }
  tiles <- tiles[order(tiles$tile_id), ]
  tiles$area_m2 <- as.numeric(sf::st_area(tiles))
  row.names(tiles) <- NULL
  tiles
}

## ---- tile_measures -----------------------------------------------------------

#' Measure each tile
#'
#' Six measures for each tile, from *The Map That Never Got Drawn*, Chapter 5:
#' its area, the length of its border, the distance from its point to the
#' nearest and to the farthest part of that border, the number of neighbors it
#' shares a border with, and how much of its border is shared with neighbors
#' rather than lying on the frame. Tiles that touch the frame are flagged:
#' their size depends on where the frame was drawn, so statistics based on area
#' should report them separately.
#'
#' @param tiles Tiles from [tile_points()].
#' @param frame The frame the tiles were trimmed to. If `NULL`, the outline of
#'   the tiles themselves.
#' @return A data frame, one row per tile, with `tile_id`, `area_ha`,
#'   `border_m`, `nearest_m`, `farthest_m`, `neighbors`, `shared_pct` and
#'   `edge` (`TRUE` for tiles that touch the frame).
#' @seealso [tile_pattern()]
#' @examples
#' pts <- sf::st_as_sf(kipuka_releves, coords = c("easting", "northing"), crs = 32605)
#' tiles <- tile_points(pts, kipuka_frame())
#' tile_measures(tiles, kipuka_frame())
#' @export
tile_measures <- function(tiles, frame = NULL) {
  centers <- tile_centers(tiles)
  frame <- if (is.null(frame)) sf::st_union(sf::st_geometry(tiles)) else as_frame(frame)
  frame_edge <- sf::st_boundary(frame)
  borders <- sf::st_boundary(sf::st_geometry(tiles))

  ## area and border length
  area_ha  <- as.numeric(sf::st_area(tiles)) / 10000
  border_m <- as.numeric(sf::st_length(borders))

  ## nearest: point to its own tile's border; farthest: point to the tile's corners
  nearest_m  <- as.numeric(sf::st_distance(centers, borders, by_element = TRUE))
  farthest_m <- vapply(seq_len(nrow(tiles)), function(i) {
    corners <- sf::st_cast(borders[i], "POINT")
    max(as.numeric(sf::st_distance(centers[i, ], corners)))
  }, numeric(1))

  ## neighbors, and the share of border that is not on the frame
  neighbors <- lengths(shared_border(tiles))
  on_frame_m <- vapply(seq_len(nrow(tiles)), function(i) {
    piece <- suppressWarnings(sf::st_intersection(borders[i], frame_edge))
    if (length(piece) == 0) 0 else sum(as.numeric(sf::st_length(piece)))
  }, numeric(1))
  shared_pct <- 100 * ((border_m - on_frame_m) / border_m)

  data.frame(tile_id    = tiles$tile_id,
             area_ha    = area_ha,
             border_m   = border_m,
             nearest_m  = nearest_m,
             farthest_m = farthest_m,
             neighbors  = neighbors,
             shared_pct = shared_pct,
             edge       = on_frame_m > 0)
}

## ---- tile_pattern ------------------------------------------------------------

#' Read the pattern of the points from their tiles
#'
#' The coefficient of variation (CV) of tile area describes how the points are
#' spread. Only interior tiles are used, because the size of an edge tile
#' depends on the frame. For points scattered at random, the CV comes out close
#' to 0.5. Well below that, the points are more even than chance; well above
#' it, they're clustered, and the largest tiles mark the gaps between clusters.
#'
#' Rather than rely on a textbook value, the function can compare the points
#' with random points in the same frame: `trials` sets of the same number of
#' points are placed at random, and the range of their CVs is reported.
#'
#' @param tiles Tiles from [tile_points()].
#' @param frame The frame the tiles were trimmed to. If `NULL`, the outline of
#'   the tiles.
#' @param trials Number of random comparison sets; 0 to skip.
#' @param seed Random seed for the comparison sets, or `NULL`.
#' @return A one-row data frame: `tiles`, `interior`, `cv`, `random_low` and
#'   `random_high` (the range of the random CVs; `NA` if `trials = 0`), and
#'   `reading` (`"more even than random"`, `"about random"` or `"clustered"`).
#' @examples
#' pts <- sf::st_as_sf(kipuka_releves, coords = c("easting", "northing"), crs = 32605)
#' tiles <- tile_points(pts, kipuka_frame())
#' tile_pattern(tiles, kipuka_frame(), trials = 10, seed = 1)
#' @export
tile_pattern <- function(tiles, frame = NULL, trials = 20, seed = NULL) {
  frame <- if (is.null(frame)) sf::st_union(sf::st_geometry(tiles)) else as_frame(frame)
  edge <- sf::st_boundary(frame)
  interior_cv <- function(tl) {
    inside <- lengths(sf::st_intersects(tl, edge)) == 0
    a <- as.numeric(sf::st_area(tl))[inside]
    if (length(a) < 3) return(NA_real_)
    stats::sd(a) / mean(a)
  }
  n_inside <- sum(lengths(sf::st_intersects(tiles, edge)) == 0)
  cv <- interior_cv(tiles)
  if (is.na(cv)) warning("Fewer than three interior tiles; the CV is not meaningful.", call. = FALSE)

  ## random points in the same frame, for comparison
  low <- high <- NA_real_
  if (trials > 0) {
    if (!is.null(seed)) set.seed(seed)
    random_cv <- vapply(seq_len(trials), function(k) {
      rp <- sf::st_sf(geometry = sf::st_sample(frame, nrow(tiles), type = "random"))
      interior_cv(tile_points(rp, frame))
    }, numeric(1))
    low  <- min(random_cv, na.rm = TRUE)
    high <- max(random_cv, na.rm = TRUE)
  }

  ## the reading: against the random range if there is one, otherwise against 0.5
  lo <- if (is.na(low)) 0.35 else low
  hi <- if (is.na(high)) 0.70 else high
  reading <- if (is.na(cv)) NA_character_ else if (cv < lo) "more even than random" else if (cv > hi) "clustered" else "about random"

  data.frame(tiles = nrow(tiles), interior = n_inside, cv = cv,
             random_low = low, random_high = high, reading = reading)
}

## ---- merge_tiles -------------------------------------------------------------

#' Merge neighboring tiles that share a category
#'
#' Tiles of the same category are merged into patches, which removes the
#' boundaries between them and leaves only the boundaries between categories.
#' A category can still fall into separate pieces; each piece is a patch. The
#' number of points in each patch shows how much of the map rests on a single
#' sample.
#'
#' @param tiles Tiles from [tile_points()].
#' @param by Name of the column that holds the category.
#' @return An `sf` polygon object, one row per patch, with the category, the
#'   number of points in the patch (`points`), and `area_ha`.
#' @examples
#' pts <- sf::st_as_sf(kipuka_releves, coords = c("easting", "northing"), crs = 32605)
#' tiles <- tile_points(pts, kipuka_frame())
#' merge_tiles(tiles, "vegetation")
#' @export
merge_tiles <- function(tiles, by) {
  if (!by %in% names(tiles)) stop("Column `", by, "` is not in `tiles`.", call. = FALSE)
  centers <- tile_centers(tiles)
  groups <- split(seq_len(nrow(tiles)), tiles[[by]])
  pieces <- lapply(names(groups), function(g) {
    merged <- sf::st_union(sf::st_geometry(tiles)[groups[[g]]])
    parts  <- sf::st_cast(sf::st_cast(merged, "MULTIPOLYGON"), "POLYGON")
    out <- sf::st_sf(category = rep(g, length(parts)), geometry = parts)
    names(out)[1] <- by
    out
  })
  patches <- do.call(rbind, pieces)
  patches$points  <- lengths(sf::st_intersects(patches, centers))
  patches$area_ha <- as.numeric(sf::st_area(patches)) / 10000
  row.names(patches) <- NULL
  patches
}

## ---- boundary_bands ----------------------------------------------------------

#' Uncertainty bands around the boundaries between categories
#'
#' A boundary between two tiles of different categories lies halfway between
#' their two points, but the real edge could be anywhere between them. Each
#' boundary gets a band half the distance between its two points wide on
#' either side (square-ended, so bands don't bulge past the ends of their
#' edges). Closer samples give narrower bands.
#'
#' @param tiles Tiles from [tile_points()].
#' @param by Name of the column that holds the category.
#' @param frame Optional frame; the bands are trimmed to it.
#' @return A list of three:
#' \describe{
#'   \item{edges}{`sf` lines, one per boundary, with `side_a`, `side_b`,
#'     `spacing_m` (distance between the two points) and `plus_minus_m` (half
#'     of it).}
#'   \item{bands}{`sf` polygons, one band per boundary.}
#'   \item{zone}{All the bands as one polygon (`sfc`).}
#' }
#' @examples
#' pts <- sf::st_as_sf(kipuka_releves, coords = c("easting", "northing"), crs = 32605)
#' tiles <- tile_points(pts, kipuka_frame())
#' bb <- boundary_bands(tiles, "vegetation", kipuka_frame())
#' bb$edges
#' @export
boundary_bands <- function(tiles, by, frame = NULL) {
  if (!by %in% names(tiles)) stop("Column `", by, "` is not in `tiles`.", call. = FALSE)
  centers <- tile_centers(tiles)

  ## every pair of neighbors whose categories differ
  nb <- shared_border(tiles)
  pairs <- do.call(rbind, lapply(seq_along(nb), function(i) if (length(nb[[i]])) cbind(i, nb[[i]])))
  if (is.null(pairs)) stop("No tiles share a border.", call. = FALSE)
  pairs <- pairs[pairs[, 1] < pairs[, 2], , drop = FALSE]
  pairs <- pairs[tiles[[by]][pairs[, 1]] != tiles[[by]][pairs[, 2]], , drop = FALSE]
  if (nrow(pairs) == 0) stop("No neighboring tiles differ in `", by, "`.", call. = FALSE)

  ## the shared edge and the spacing of the two points, for each pair
  geom <- sf::st_geometry(tiles)
  edges <- lapply(seq_len(nrow(pairs)), function(k) {
    i <- pairs[k, 1]; j <- pairs[k, 2]
    edge <- suppressWarnings(sf::st_intersection(geom[i], geom[j]))
    edge <- sf::st_union(suppressWarnings(sf::st_collection_extract(edge, "LINESTRING")))
    spacing <- as.numeric(sf::st_distance(centers[i, ], centers[j, ]))
    sf::st_sf(side_a = as.character(tiles[[by]][i]), side_b = as.character(tiles[[by]][j]),
              spacing_m = spacing, plus_minus_m = spacing / 2, geometry = edge)
  })
  edges <- do.call(rbind, edges)

  ## square-ended bands, trimmed to the frame
  bands <- sf::st_buffer(edges, edges$plus_minus_m, endCapStyle = "FLAT")
  if (!is.null(frame)) bands <- suppressWarnings(sf::st_intersection(bands, as_frame(frame)))
  row.names(edges) <- NULL
  row.names(bands) <- NULL
  list(edges = edges, bands = bands, zone = sf::st_union(sf::st_geometry(bands)))
}
