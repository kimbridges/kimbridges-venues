# Containers: count records inside tiles.

#' Count records inside tiles
#'
#' Treats tiles as containers. Each record (a specimen, a case, a sighting) is
#' counted in the tile it falls in, and each tile's count is compared with what
#' its area alone would predict.
#'
#' Three cautions from *The Map That Never Got Drawn*, Chapter 6, are built in:
#' \describe{
#'   \item{A counting frame.}{Records come from somewhere: a query circle, a
#'     survey area. Tiles and records should both be cut to the area where
#'     records could have been found. Pass it as `frame`.}
#'   \item{Location precision.}{A record can only be counted in a tile if its
#'     location error is small compared with the tile. Give each record's
#'     uncertainty (meters) with `uncertainty`. Rounded coordinates otherwise
#'     pile up in whichever tile holds the rounded point. What happens to a
#'     record whose uncertainty circle crosses a tile border is set by
#'     `allocation`:
#'     \itemize{
#'       \item `"exclude"` (the default, and the rule in the document): the
#'         record is left out of the counts and reported in the `excluded`
#'         column.
#'       \item `"proportional"`: the record is shared among the tiles its
#'         circle overlaps, in proportion to the overlap. Counts become
#'         fractional; any part of a circle outside the tiles (beyond the
#'         frame) is not counted, and that share is reported in `excluded`.
#'     }}
#'   \item{Counts measure the recorders as well as the thing recorded.}{A high
#'     ratio can mean a place is rich, or that a trail runs through it.}
#' }
#'
#' With `test = TRUE`, each tile gets a Poisson test of its count against the
#' overall density, and the whole set gets a chi-squared goodness-of-fit test
#' (simulated when expected counts are small). This follows the Voronoi
#' analysis developed with Tom Koch for epidemiological data. P-values are
#' adjusted for the number of tiles tested (Holm, by default).
#'
#' @param tiles An `sf` polygon object, such as tiles from [tile_points()] or
#'   patches from [merge_tiles()].
#' @param records An `sf` object of points. Transformed to the coordinate
#'   system of `tiles` if needed.
#' @param frame Optional counting frame (`sf`, `sfc` or `bbox`). Tiles and
#'   records are cut to it.
#' @param uncertainty Optional location uncertainty in meters: the name of a
#'   numeric column in `records`, or a single number for all of them.
#' @param allocation `"exclude"` or `"proportional"`: how records whose
#'   uncertainty circle crosses a tile border are handled. See Details.
#' @param by Optional name of a column in `tiles`. Tiles with the same value are
#'   merged before counting, giving counts by category (for example by
#'   vegetation type).
#' @param test Add Poisson and chi-squared tests?
#' @param p_adjust Method passed to [stats::p.adjust()].
#' @param alpha Significance level for the `direction` column.
#' @return An `sf` object, one row per tile (or category), with the tile's
#'   attributes and `area_ha`, `records`, `excluded` (records left out for
#'   location uncertainty), `expected`, `ratio`, and with `test = TRUE` also
#'   `p_value`, `p_adjusted` and `direction` (`"elevated"`, `"depleted"` or
#'   `"as expected"`). With `test = TRUE` the chi-squared test is attached as
#'   the attribute `"chisq"`. With `allocation = "proportional"`, `records`
#'   and `excluded` can be fractional, and the tests use rounded counts.
#' @seealso [tile_points()], [merge_tiles()]
#' @examples
#' pts   <- sf::st_as_sf(kipuka_releves, coords = c("easting", "northing"), crs = 32605)
#' tiles <- tile_points(pts, kipuka_frame())
#' set.seed(1)
#' recs <- sf::st_sf(geometry = sf::st_sample(kipuka_frame(), 60))
#' counts <- count_in_tiles(tiles, recs)
#' sf::st_drop_geometry(counts)[, c("releve", "records", "expected", "ratio", "direction")]
#' @export
count_in_tiles <- function(tiles, records, frame = NULL, uncertainty = NULL,
                           allocation = c("exclude", "proportional"), by = NULL,
                           test = TRUE, p_adjust = "holm", alpha = 0.05) {
  allocation <- match.arg(allocation)
  if (!inherits(tiles, "sf")) stop("`tiles` must be an sf object.", call. = FALSE)
  if (!inherits(records, "sf")) stop("`records` must be an sf object of points.", call. = FALSE)
  check_projected(tiles, "tiles")
  if (sf::st_crs(records) != sf::st_crs(tiles)) records <- sf::st_transform(records, sf::st_crs(tiles))

  ## location uncertainty for every record (0 when not given)
  if (is.null(uncertainty)) {
    unc <- rep(0, nrow(records))
  } else if (is.character(uncertainty)) {
    if (!uncertainty %in% names(records)) stop("Column `", uncertainty, "` is not in `records`.", call. = FALSE)
    unc <- as.numeric(records[[uncertainty]])
  } else {
    unc <- rep(as.numeric(uncertainty), length.out = nrow(records))
  }
  unc[is.na(unc)] <- 0

  ## merge tiles by category, if asked
  if (!is.null(by)) {
    if (!by %in% names(tiles)) stop("Column `", by, "` is not in `tiles`.", call. = FALSE)
    groups <- split(seq_len(nrow(tiles)), tiles[[by]])
    geoms <- do.call(c, lapply(groups, function(g) sf::st_union(sf::st_geometry(tiles)[g])))
    tiles <- sf::st_sf(category = names(groups), geometry = geoms)
    names(tiles)[1] <- by
  }

  ## the counting frame: cut tiles and records to it
  if (!is.null(frame)) {
    frame <- as_frame(frame)
    if (sf::st_crs(frame) != sf::st_crs(tiles)) frame <- sf::st_transform(frame, sf::st_crs(tiles))
    tiles <- suppressWarnings(sf::st_intersection(tiles, frame))
    keep <- lengths(sf::st_intersects(records, frame)) > 0
    records <- records[keep, ]
    unc <- unc[keep]
  }

  ## which tile each record falls in
  n_tiles <- nrow(tiles)
  hit <- sf::st_intersects(records, tiles)
  tile_of <- vapply(hit, function(h) if (length(h)) h[1] else NA_integer_, integer(1))
  counted  <- numeric(n_tiles)
  excluded <- numeric(n_tiles)

  ## records with no uncertainty count whole, in the tile they fall in
  exact <- which(unc <= 0 & !is.na(tile_of))
  counted <- counted + tabulate(tile_of[exact], nbins = n_tiles)

  ## records with uncertainty: how much of each circle falls in each tile
  fuzzy <- which(unc > 0 & !is.na(tile_of))
  if (length(fuzzy)) {
    circles <- sf::st_sf(rec = fuzzy, geometry = sf::st_buffer(sf::st_geometry(records)[fuzzy], unc[fuzzy]))
    circle_area <- as.numeric(sf::st_area(circles))
    geom_tiles <- sf::st_sf(tile = seq_len(n_tiles), geometry = sf::st_geometry(tiles))
    pieces <- suppressWarnings(sf::st_intersection(circles, geom_tiles))
    share <- matrix(0, nrow = length(fuzzy), ncol = n_tiles)
    if (nrow(pieces)) {
      piece_share <- as.numeric(sf::st_area(pieces)) / circle_area[match(pieces$rec, fuzzy)]
      for (k in seq_len(nrow(pieces))) {
        r <- match(pieces$rec[k], fuzzy)
        share[r, pieces$tile[k]] <- share[r, pieces$tile[k]] + piece_share[k]
      }
    }
    share[share > 1] <- 1
    if (allocation == "exclude") {
      ## whole only if the circle lies (all but a sliver) inside the record's own tile
      whole <- share[cbind(seq_along(fuzzy), tile_of[fuzzy])] >= 1 - 1e-6
      counted  <- counted  + tabulate(tile_of[fuzzy][whole],  nbins = n_tiles)
      excluded <- excluded + tabulate(tile_of[fuzzy][!whole], nbins = n_tiles)
    } else {
      counted <- counted + colSums(share)
      ## the part of each circle outside every tile, booked to the record's own tile
      lost <- pmax(0, 1 - rowSums(share))
      excluded <- excluded + vapply(seq_len(n_tiles), function(i) sum(lost[tile_of[fuzzy] == i]), numeric(1))
    }
  }

  ## the counts expected from area alone
  area_m2  <- as.numeric(sf::st_area(tiles))
  total    <- sum(counted)
  expected <- total * (area_m2 / sum(area_m2))

  tiles$area_ha  <- area_m2 / 10000
  tiles$records  <- counted
  tiles$excluded <- excluded
  tiles$expected <- expected
  tiles$ratio    <- ifelse(expected > 0, counted / expected, NA_real_)

  ## Poisson test per tile, and a chi-squared test over all tiles
  if (test && total > 0) {
    density <- total / sum(area_m2)
    p <- vapply(seq_len(n_tiles), function(i) {
      stats::poisson.test(x = round(counted[i]), T = area_m2[i], r = density)$p.value
    }, numeric(1))
    p_adj <- stats::p.adjust(p, method = p_adjust)
    tiles$p_value    <- p
    tiles$p_adjusted <- p_adj
    tiles$direction  <- ifelse(p_adj < alpha & counted > expected, "elevated",
                        ifelse(p_adj < alpha & counted < expected, "depleted", "as expected"))
    shares <- area_m2 / sum(area_m2)
    obs <- round(counted)
    chisq <- tryCatch(stats::chisq.test(obs, p = shares),
                      warning = function(w) stats::chisq.test(obs, p = shares,
                                                              simulate.p.value = TRUE, B = 10000))
    attr(tiles, "chisq") <- chisq
  }
  row.names(tiles) <- NULL
  tiles
}
