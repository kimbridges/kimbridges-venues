# ==============================================================================
# render_map.R -- PubMaps step 5: RENDER
# Draws exactly what plan_map() decided: no geometry decisions are made here.
# Drawing code adapted from generate_publication_map() (pubmap_tools.r, K. W. Bridges).
# ==============================================================================

ROLE_STYLE <- data.frame(
  role  = c("study_site", "sampling_point", "reference_town", "natural_feature", "other"),
  label = c("Study site", "Sampling point", "Town", "Natural feature", "Other place"),
  shape = c(21, 24, 22, 17, 23),
  fill  = c("#d95f02", "#d95f02", "#1b4965", "#4d4d4d", "#9a9a9a"),
  size  = c(2.8, 2.2, 2.2, 2.6, 2.4),
  face  = c("bold", "plain", "italic", "plain", "plain"),
  stringsAsFactors = FALSE)

nice_step <- function(span) {
  s <- c(0.01, 0.02, 0.05, 0.1, 0.2, 0.25, 0.5, 1, 2, 5, 10)
  s[which.min(abs(span / s - 4))]
}

hillshade_layer <- function(ext_ll, crs, span_deg) {
  z <- max(6, min(12, round(log2(360 / span_deg)) + 2))
  box <- data.frame(x = ext_ll[c(1, 3)], y = ext_ll[c(2, 4)])
  dem <- tryCatch(terra::rast(elevatr::get_elev_raster(box, prj = "EPSG:4326", z = z,
                    clip = "bbox", verbose = FALSE)), error = function(e) NULL)
  if (is.null(dem)) return(NULL)
  dem <- terra::project(dem, crs$wkt)
  if (max(dim(dem)[1:2]) > 900) dem <- terra::aggregate(dem, ceiling(max(dim(dem)[1:2]) / 900))
  sl <- terra::terrain(dem * 2.2, "slope", unit = "radians")
  as <- terra::terrain(dem * 2.2, "aspect", unit = "radians")
  hs <- terra::shade(sl, as, angle = 35, direction = 315)
  v <- terra::values(hs, na.rm = TRUE); q <- stats::quantile(v, c(0.015, 0.985))
  hs <- (terra::clamp(hs, q[1], q[2]) - q[1]) / (q[2] - q[1])
  m <- terra::as.matrix(hs, wide = TRUE)
  col <- matrix(scales::col_numeric(c("#2a2a2a", "#6e6e6e", "#a8a8a8", "#dadada", "#ffffff"),
                                    c(0, 1), na.color = "#dce7eb")(m), nrow(m))
  e <- terra::ext(dem)
  annotation_raster(col, xmin = e$xmin, xmax = e$xmax, ymin = e$ymin, ymax = e$ymax,
                    interpolate = TRUE)
}

# ------------------------------------------------------------------------------
# Labels (2026-10-25). Point names and area names are placed together, so they
# push away from each other. The editor can override any name without moving the
# place: label_pos = N/NE/E/SE/S/SW/W/NW (fixed side), "none" (hidden), or
# label_lon/label_lat (exact position; points get a thin leader line).
# ------------------------------------------------------------------------------
LABEL_DIRS <- list(N = c(0, 1), NE = c(1, 1), E = c(1, 0), SE = c(1, -1),
                   S = c(0, -1), SW = c(-1, -1), W = c(-1, 0), NW = c(-1, 1))

label_layers <- function(pts, d, plan, crs, bb) {
  getc <- function(x, col, default) if (is.null(x[[col]])) rep(default, nrow(x)) else x[[col]]
  L <- data.frame(x = numeric(0), y = numeric(0), text = character(0), face = character(0),
                  colour = character(0), size = numeric(0), kind = character(0), pos = character(0),
                  lx = numeric(0), ly = numeric(0), stringsAsFactors = FALSE)
  if (nrow(pts)) {
    xy <- st_coordinates(pts)
    L <- data.frame(x = xy[, 1], y = xy[, 2], text = d$name, face = pts$face,
                    colour = "#1a1a1a", size = 3, kind = "point",
                    pos = getc(d, "label_pos", ""), lx = getc(d, "label_lon", NA_real_),
                    ly = getc(d, "label_lat", NA_real_), stringsAsFactors = FALSE)
  }
  if (!is.null(plan$areas) && nrow(plan$areas)) {
    ar <- plan$areas
    a_xy <- st_coordinates(suppressWarnings(st_point_on_surface(st_geometry(ar))))
    L <- rbind(L, data.frame(x = a_xy[, 1], y = a_xy[, 2], text = ar$name, face = "italic",
                             colour = ifelse(ar$role == "protected_area", "#3d6b30", "#555555"),
                             size = 2.6, kind = "area", pos = getc(ar, "label_pos", ""),
                             lx = getc(ar, "label_lon", NA_real_), ly = getc(ar, "label_lat", NA_real_),
                             stringsAsFactors = FALSE))
  }
  if (!is.null(plan$rivers) && nrow(plan$rivers)) {
    rv <- plan$rivers
    r_xy <- do.call(rbind, lapply(st_geometry(rv), river_label_point))
    L <- rbind(L, data.frame(x = r_xy[, 1], y = r_xy[, 2], text = rv$name, face = "italic",
                             colour = "#2f6690", size = 2.6, kind = "area", pos = getc(rv, "label_pos", ""),
                             lx = getc(rv, "label_lon", NA_real_), ly = getc(rv, "label_lat", NA_real_),
                             stringsAsFactors = FALSE))
  }
  # name-only places (include = name): text, no symbol; regions in capitals
  pp <- plan$points
  inc <- if (is.null(pp$include)) rep("", nrow(pp)) else tolower(trimws(ifelse(is.na(pp$include), "", pp$include)))
  nm <- pp[inc == "name", , drop = FALSE]
  if (nrow(nm)) {
    llx <- getc(nm, "label_lon", NA_real_); lly <- getc(nm, "label_lat", NA_real_)
    gx <- ifelse(!is.na(nm$lon), nm$lon, getc(nm, "gaz_lon", NA_real_))
    gy <- ifelse(!is.na(nm$lat), nm$lat, getc(nm, "gaz_lat", NA_real_))
    ax <- ifelse(!is.na(llx) & !is.na(lly), llx, gx); ay <- ifelse(!is.na(llx) & !is.na(lly), lly, gy)
    ok <- !is.na(ax) & !is.na(ay)
    if (any(ok)) {
      nm <- nm[ok, , drop = FALSE]
      nxy <- st_coordinates(st_transform(st_as_sf(data.frame(x = ax[ok], y = ay[ok]), coords = c("x", "y"), crs = 4326), crs))
      txt <- ifelse(!is.na(getc(nm, "label", NA)) & nzchar(getc(nm, "label", "")), nm$label, nm$name)
      region <- nm$role %in% c("administrative_unit", "protected_area")
      L <- rbind(L, data.frame(x = nxy[, 1], y = nxy[, 2], text = ifelse(region, toupper(txt), txt),
                               face = "italic", colour = "#4a4a4a", size = ifelse(region, 3.4, 3),
                               kind = "name", pos = getc(nm, "label_pos", ""), lx = NA_real_, ly = NA_real_,
                               stringsAsFactors = FALSE))
    }
  }
  L$pos <- toupper(trimws(ifelse(is.na(L$pos), "", L$pos)))
  L <- L[L$pos != "NONE", ]
  out <- list()
  # exact positions
  ex <- L[!is.na(L$lx) & !is.na(L$ly), ]
  if (nrow(ex)) {
    exy <- st_coordinates(st_transform(st_as_sf(ex, coords = c("lx", "ly"), crs = 4326), crs))
    ex$lx <- exy[, 1]; ex$ly <- exy[, 2]
    sg <- ex[ex$kind == "point", ]
    if (nrow(sg)) out <- c(out, list(geom_segment(data = sg, aes(x = x, y = y, xend = lx, yend = ly),
                                                  colour = "#555555", linewidth = 0.3)))
    out <- c(out, list(geom_label(data = ex, aes(x = lx, y = ly, label = text, fontface = face,
                                                 colour = colour, size = size),
                                  fill = "white", label.size = 0, label.padding = grid::unit(0.08, "lines"))))
  }
  # fixed side
  mm <- (bb[3] - bb[1]) / plan$panel_mm[1]           # map units per mm
  fx <- L[(is.na(L$lx) | is.na(L$ly)) & L$pos %in% names(LABEL_DIRS), ]
  if (nrow(fx)) {
    v <- do.call(rbind, LABEL_DIRS[fx$pos])
    off <- ifelse(fx$kind == "point", 2.2, 0) * mm
    fx$tx <- fx$x + v[, 1] * off; fx$ty <- fx$y + v[, 2] * off
    fx$hj <- ifelse(v[, 1] > 0, 0, ifelse(v[, 1] < 0, 1, 0.5))
    fx$vj <- ifelse(v[, 2] > 0, 0, ifelse(v[, 2] < 0, 1, 0.5))
    out <- c(out, list(geom_label(data = fx, aes(x = tx, y = ty, label = text, fontface = face,
                                                 colour = colour, size = size, hjust = hj, vjust = vj),
                                  fill = "white", label.size = 0, label.padding = grid::unit(0.08, "lines"))))
  }
  # automatic: points and areas repel each other
  au <- L[(is.na(L$lx) | is.na(L$ly)) & !L$pos %in% names(LABEL_DIRS), ]
  if (nrow(au)) {
    au$seg <- ifelse(au$kind == "point", "#555555", NA)
    au$psize <- ifelse(au$kind == "point", 1.5, 0)
    out <- c(out, list(geom_text_repel(data = au,
      aes(x = x, y = y, label = text, fontface = face, colour = colour, size = size,
          segment.colour = seg, point.size = psize),
      bg.color = "white", bg.r = 0.15, max.overlaps = Inf, box.padding = 0.35,
      point.padding = 0.3, min.segment.length = 0, segment.size = 0.3, seed = 1)))
  }
  c(out, list(scale_colour_identity(aesthetics = c("colour", "segment.colour")),
              scale_size_identity()))
}

# ------------------------------------------------------------------------------
# What is on the map (2026-10-26): one record used for the legend strip under the
# figure AND for the text key the editor copies into the caption, so the two
# always agree with what was drawn.
# ------------------------------------------------------------------------------
map_layers <- function(plan, states = FALSE) {
  d <- plan$points[plan$points$drawn, ]
  d$role[!d$role %in% ROLE_STYLE$role] <- "other"
  n <- table(factor(d$role, levels = ROLE_STYLE$role))
  ar <- plan$areas
  nm <- function(x) if (is.null(x) || !nrow(x)) character() else x$name
  list(roles = n[n > 0],
       parks = nm(if (!is.null(ar)) ar[ar$role == "protected_area", ]),
       districts = nm(if (!is.null(ar)) ar[ar$role != "protected_area", ]),
       rivers = nm(plan$rivers),
       states = isTRUE(states),
       countries = plan$inset$countries)
}

# the legend strip: drawn in millimetres, wrapped to a second row if needed
LEGEND_TEXT <- 2.8                                  # ~8 pt
legend_strip <- function(layers, width_mm) {
  it <- data.frame(label = character(), kind = character(), role = character(), stringsAsFactors = FALSE)
  for (r in names(layers$roles))
    it[nrow(it) + 1, ] <- list(ROLE_STYLE$label[ROLE_STYLE$role == r], "point", r)
  if (length(layers$parks))     it[nrow(it) + 1, ] <- list("Park or reserve", "park", "")
  if (length(layers$districts)) it[nrow(it) + 1, ] <- list("District boundary", "district", "")
  if (length(layers$rivers))    it[nrow(it) + 1, ] <- list("River", "river", "")
  if (layers$states)            it[nrow(it) + 1, ] <- list("State or province boundary", "state", "")
  if (!nrow(it)) return(NULL)
  gw <- 5; gap <- 1.5; sep <- 5; ch <- 1.45       # glyph, glyph-text gap, item spacing, mm per character
  it$w <- gw + gap + nchar(it$label) * ch
  it$row <- 1; it$x0 <- 0
  row <- 1; used <- 0
  for (i in seq_len(nrow(it))) {
    if (used > 0 && used + sep + it$w[i] > width_mm) { row <- row + 1; used <- 0 }
    it$row[i] <- row; it$x0[i] <- used + if (used > 0) sep else 0
    used <- it$x0[i] + it$w[i]
  }
  rows <- max(it$row); row_h <- 5
  for (r in seq_len(rows)) {                      # centre each row
    k <- it$row == r; off <- (width_mm - max(it$x0[k] + it$w[k])) / 2
    it$x0[k] <- it$x0[k] + off
  }
  it$y <- (rows - it$row + 0.5) * row_h
  g <- ggplot() + theme_void() +
    ggplot2::coord_cartesian(xlim = c(0, width_mm), ylim = c(0, rows * row_h), expand = FALSE)
  pt <- merge(it[it$kind == "point", ], ROLE_STYLE[, c("role", "shape", "fill", "size")], by = "role")
  if (nrow(pt)) g <- g + ggplot2::geom_point(data = pt, aes(x = x0 + gw / 2, y = y), shape = pt$shape,
                                             fill = pt$fill, size = pt$size, colour = "#1a1a1a", stroke = 0.35)
  pk <- it[it$kind == "park", ]
  if (nrow(pk)) g <- g + ggplot2::geom_rect(data = pk, aes(xmin = x0, xmax = x0 + gw, ymin = y - 1.3, ymax = y + 1.3),
                                            fill = "#d4e8c8", colour = "#5a8a4a", linewidth = 0.4, alpha = 0.75)
  ln <- function(k, col, lw, lt) {
    z <- it[it$kind == k, ]
    if (nrow(z)) ggplot2::geom_segment(data = z, aes(x = x0, xend = x0 + gw, y = y, yend = y),
                                       colour = col, linewidth = lw, linetype = lt, lineend = "butt")
  }
  g <- g + ln("district", "#6b6b6b", 0.45, "42") + ln("river", "#5b8db8", 0.7, "solid") +
    ln("state", "#9a9a9a", 0.25, "22") +
    ggplot2::geom_text(data = it, aes(x = x0 + gw + gap, y = y, label = label), hjust = 0,
                       size = LEGEND_TEXT, colour = "#1a1a1a")
  attr(g, "height_mm") <- rows * row_h + 1
  g
}

# the same information in words, for the figure caption
symbol_key <- function(layers, inset_small = FALSE) {
  role_txt <- list(study_site = c("orange circle", "study site"),
                   sampling_point = c("orange triangle", "sampling point"),
                   reference_town = c("dark blue square", "town"),
                   natural_feature = c("black triangle", "natural feature"),
                   other = c("grey diamond", "other place"))
  pl <- function(x, n) if (n > 1) paste0(x, "s") else x
  and <- function(x) if (length(x) <= 1) x else paste(paste(x[-length(x)], collapse = ", "), "and", x[length(x)])
  parts <- character()
  for (r in names(layers$roles)) {
    n <- layers$roles[[r]]
    parts <- c(parts, paste0(pl(role_txt[[r]][1], n), ", ", pl(role_txt[[r]][2], n)))
  }
  if (length(layers$parks))
    parts <- c(parts, paste0("pale green shading, ", and(layers$parks)))
  if (length(layers$districts)) {
    nd <- length(layers$districts)
    parts <- c(parts, paste0(if (nd > 1) "dark grey dashed lines, district boundaries" else
                               "dark grey dashed line, district boundary", " (", and(layers$districts), ")"))
  }
  if (length(layers$rivers))
    parts <- c(parts, paste0("blue ", pl("line", length(layers$rivers)), ", ", and(layers$rivers)))
  if (layers$states) parts <- c(parts, "fine grey dashes, state or province boundaries")
  key <- if (length(parts)) paste0(paste(parts, collapse = "; "), ".") else ""
  key <- paste0(toupper(substr(key, 1, 1)), substr(key, 2, nchar(key)))
  inset <- paste0("Inset: location of the map area (orange ", if (inset_small) "dot" else "box",
                  ") in ", and(layers$countries), ".")
  trimws(paste(key, inset))
}

#' Draw a planned map
#'
#' Draws exactly what [plan_map()] decided and saves it as a PDF (vector) and,
#' optionally, a PNG preview.
#'
#' @param plan A `pubmap_plan` from [plan_map()].
#' @param out_stem Output path without extension; `"_vector"` or `"_relief"`
#'   and the extension are added.
#' @param relief Draw shaded relief instead of the plain land fill (needs the
#'   `elevatr`, `terra` and `scales` packages).
#' @param png Also save a PNG preview.
#' @param legend Draw the legend strip under the map. Turn it off when the
#'   journal explains the symbols in the caption (see the symbol key on the
#'   review page).
#' @param inset_label Print the country name on the inset map.
#' @return The PDF path, invisibly, with attribute `layers` (what was drawn).
#' @export
render_map <- function(plan, out_stem, relief = FALSE, png = TRUE, legend = TRUE, inset_label = TRUE) {
  if (relief) for (pk in c("elevatr", "terra", "scales"))
    if (!requireNamespace(pk, quietly = TRUE)) stop("relief = TRUE needs the '", pk, "' package.")
  crs <- plan$crs; bb <- plan$bbox; ell <- plan$extent_lonlat
  span_deg <- max(ell[3] - ell[1], ell[4] - ell[2])
  scale_ne <- if (span_deg < 6) "large" else 50
  clip <- st_as_sfc(st_bbox(c(xmin = ell[1] - 2, ymin = ell[2] - 2,
                              xmax = ell[3] + 2, ymax = ell[4] + 2), crs = 4326))
  land <- suppressWarnings(suppressMessages(
    st_crop(st_make_valid(ne_countries(scale = scale_ne, returnclass = "sf")), clip)))
  states <- tryCatch(suppressWarnings(suppressMessages(st_crop(st_make_valid(
    ne_states(iso_a2 = plan$inset$iso_a2, returnclass = "sf")), clip))), error = function(e) NULL)
  study <- land[land$iso_a2 %in% plan$inset$iso_a2 | land$name %in% plan$inset$countries, ]

  d <- plan$points[plan$points$drawn, ]
  d$role[!d$role %in% ROLE_STYLE$role] <- "other"
  if (!is.null(d$label) && any(!is.na(d$label) & nzchar(d$label)))
    d$name <- ifelse(is.na(d$label) | !nzchar(d$label), d$name, d$label)
  d$label <- NULL
  d <- merge(d, ROLE_STYLE, by = "role", sort = FALSE)
  d$label <- factor(d$label, levels = ROLE_STYLE$label[ROLE_STYLE$role %in% d$role])
  # (an area-framed study can have no points; sf warns about the empty bounding box)
  pts <- st_transform(suppressWarnings(st_as_sf(d, coords = c("lon", "lat"), crs = 4326)), crs)

  p <- ggplot()
  if (relief) {
    hs <- hillshade_layer(ell, crs, span_deg)
    p <- p + hs + geom_sf(data = land, fill = NA, colour = "#8a8a8a", linewidth = 0.25)
  } else {
    p <- p + geom_sf(data = land, fill = "#ebebeb", colour = "#c8c8c8", linewidth = 0.2) +
             geom_sf(data = study, fill = "#f7f7f5", colour = "#9a9a9a", linewidth = 0.35)
  }
  if (!is.null(states) && nrow(states))
    p <- p + geom_sf(data = states, fill = NA, colour = "#9a9a9a", linewidth = 0.25,
                     linetype = "22")
  # areas (2026-10-25): parks/reserves pale green fill, districts dashed outline
  if (!is.null(plan$areas) && nrow(plan$areas)) {
    ar <- plan$areas
    pa <- ar[ar$role == "protected_area", ]; ad <- ar[ar$role != "protected_area", ]
    if (nrow(pa)) p <- p + geom_sf(data = pa, fill = "#d4e8c8", colour = "#5a8a4a",
                                   linewidth = 0.4, alpha = 0.75)
  }
  # rivers (2026-10-26): above park fills, beneath district outlines and points
  if (!is.null(plan$rivers) && nrow(plan$rivers))
    p <- p + geom_sf(data = plan$rivers, colour = "#5b8db8", linewidth = 0.7, lineend = "round")
  if (!is.null(plan$areas) && nrow(plan$areas)) {
    ad <- plan$areas[plan$areas$role != "protected_area", ]
    if (nrow(ad)) p <- p + geom_sf(data = ad, fill = NA, colour = "#6b6b6b",
                                   linewidth = 0.45, linetype = "42")
  }
  sty <- ROLE_STYLE[ROLE_STYLE$role %in% d$role, ]
  if (nrow(pts)) p <- p +
    geom_sf(data = pts, aes(shape = label, fill = label), colour = "#1a1a1a",
            size = pts$size, stroke = 0.35, show.legend = FALSE) +
    scale_shape_manual(NULL, values = setNames(sty$shape, sty$label)) +
    scale_fill_manual(NULL, values = setNames(sty$fill, sty$label))

  p <- p + label_layers(pts, d, plan, crs, bb)
  stp <- nice_step(span_deg)
  p <- p +
    coord_sf(crs = crs, xlim = bb[c(1, 3)], ylim = bb[c(2, 4)], expand = FALSE,
             default_crs = NULL) +
    scale_x_continuous(breaks = seq(floor(ell[1] / stp) * stp, ceiling(ell[3] / stp) * stp, stp)) +
    scale_y_continuous(breaks = seq(floor(ell[2] / stp) * stp, ceiling(ell[4] / stp) * stp, stp)) +
    annotation_scale(location = plan$scale_bar, width_hint = 0.2, style = "ticks",
                     line_col = "#2b2b2b", text_cex = 0.7) +
    annotation_north_arrow(location = plan$north_arrow, which_north = "true",
                           height = grid::unit(0.9, "cm"), width = grid::unit(0.7, "cm"),
                           style = north_arrow_minimal(line_col = "#2b2b2b", text_size = 8)) +
    theme_bw(base_size = 9) +
    theme(panel.background = element_rect(fill = "#dce7eb"),
          panel.grid.major = element_line(colour = "white", linetype = "dotted", linewidth = 0.3),
          axis.title = element_blank(), axis.text = element_text(size = 7.5, colour = "#333333"),
          legend.position = "none", plot.margin = margin(2, 3, 2, 2, "mm"))

  # inset ------------------------------------------------------------------
  ins <- plan$inset
  world <- st_make_valid(ne_countries(scale = 50, returnclass = "sf"))
  ib <- ins$bbox
  frame <- st_transform(st_as_sfc(st_bbox(setNames(bb, c("xmin", "ymin", "xmax", "ymax")),
                                          crs = crs)), ins$crs)
  fb <- st_bbox(frame)
  small <- (fb[3] - fb[1]) < 0.04 * (ib[3] - ib[1])
  q <- ggplot() +
    geom_sf(data = world, fill = "#ffffff", colour = "#b8b8b8", linewidth = 0.15) +
    geom_sf(data = world[world$name %in% ins$countries, ], fill = "#c5c5c5",
            colour = "#7a7a7a", linewidth = 0.25)
  q <- if (small) q + geom_sf(data = st_centroid(frame), shape = 21, size = 2.6,
                              fill = "#d95f02", colour = "#1a1a1a", stroke = 0.4)
       else q + geom_sf(data = frame, fill = "#d95f02", alpha = 0.2, colour = "#d95f02",
                        linewidth = 0.7)
  # country name (2026-10-26): inside the country, never over the orange marker.
  # Candidate spots on a grid across the country; the name's box (estimated from its
  # length) must not touch the marker; of those, the one nearest the country's centre.
  if (inset_label) {
    cl <- world[world$name %in% ins$countries, ]
    if (nrow(cl)) {
      W <- ib[3] - ib[1]; mm <- W / 50                          # inset is ~50 mm wide
      marker <- st_buffer(if (small) st_centroid(frame) else frame, 1.2 * mm + if (small) 1.3 * mm else 0)
      lp <- do.call(rbind, lapply(seq_len(nrow(cl)), function(i) {
        parts <- suppressWarnings(st_cast(st_transform(st_geometry(cl[i, ]), ins$crs), "POLYGON"))
        big <- parts[which.max(as.numeric(st_area(parts)))]
        txt <- toupper(cl$name[i])
        hw <- nchar(txt) * 0.75 * mm; hh <- 1.3 * mm             # half width / height of the name
        home <- st_coordinates(suppressWarnings(st_point_on_surface(big)))[1, 1:2]
        g <- st_coordinates(suppressWarnings(st_intersection(
               st_make_grid(big, n = c(25, 25), what = "centers"), big)))[, 1:2, drop = FALSE]
        g <- rbind(home, g)
        ok <- vapply(seq_len(nrow(g)), function(k) {
          r <- st_as_sfc(st_bbox(c(xmin = g[k, 1] - hw, ymin = g[k, 2] - hh,
                                   xmax = g[k, 1] + hw, ymax = g[k, 2] + hh), crs = ins$crs))
          !lengths(st_intersects(r, marker))
        }, TRUE)
        best <- if (any(ok)) {
          c2 <- g[ok, , drop = FALSE]
          c2[which.min((c2[, 1] - home[1])^2 + (c2[, 2] - home[2])^2), ]
        } else home
        data.frame(x = best[1], y = best[2], text = txt)
      }))
      q <- q + ggplot2::geom_text(data = lp, aes(x = x, y = y, label = text), size = 2.3,
                                  colour = "#3a3a3a", fontface = "bold")
    }
  }
  q <- q + coord_sf(crs = ins$crs, xlim = ib[c(1, 3)], ylim = ib[c(2, 4)],
                    expand = FALSE, default_crs = NULL, datum = NA) +
    theme_void() +
    theme(panel.background = element_rect(fill = "#cfe0e8", colour = NA),
          panel.border = element_rect(colour = "#2b2b2b", fill = NA, linewidth = 0.5))
  fr <- plan$inset_frac; cb <- corner_box(plan$inset_corner, fr)
  out <- p + inset_element(q, left = cb[1] + 0.01 * (cb[1] == 0) - 0.01 * (cb[3] == 1),
                           bottom = cb[2] + 0.015 * (cb[2] == 0) - 0.015 * (cb[4] == 1),
                           right = cb[3] + 0.01 * (cb[1] == 0) - 0.01 * (cb[3] == 1),
                           top = cb[4] + 0.015 * (cb[2] == 0) - 0.015 * (cb[4] == 1),
                           align_to = "panel")
  layers <- map_layers(plan, states = !is.null(states) && nrow(states) > 0)
  attr(layers, "inset_small") <- small
  if (legend) {
    strip <- legend_strip(layers, plan$page_mm[1] - 10)
    if (!is.null(strip))
      out <- out / strip + patchwork::plot_layout(heights = grid::unit(c(1, attr(strip, "height_mm")), c("null", "mm")))
  }
  pdf <- paste0(out_stem, if (relief) "_relief" else "_vector", ".pdf")
  ggsave(pdf, out, width = plan$page_mm[1], height = plan$page_mm[2], units = "mm",
         device = grDevices::cairo_pdf)
  if (png) ggsave(sub("\\.pdf$", ".png", pdf), out, width = plan$page_mm[1],
                  height = plan$page_mm[2], units = "mm", dpi = 200, bg = "white")
  invisible(structure(pdf, layers = layers))
}
