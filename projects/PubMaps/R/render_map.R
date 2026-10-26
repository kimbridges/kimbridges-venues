# ==============================================================================
# render_map.R -- PubMaps step 5: RENDER
# Draws exactly what plan_map() decided: no geometry decisions are made here.
# Drawing code adapted from Kim's generate_publication_map() (pubmap_tools.r).
# ==============================================================================

suppressPackageStartupMessages({
  library(sf); library(ggplot2); library(ggrepel); library(ggspatial)
  library(patchwork); library(rnaturalearth)
})

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
  xy <- st_coordinates(pts)
  L <- data.frame(x = xy[, 1], y = xy[, 2], text = d$name, face = pts$face,
                  colour = "#1a1a1a", size = 3, kind = "point",
                  pos = getc(d, "label_pos", ""), lx = getc(d, "label_lon", NA_real_),
                  ly = getc(d, "label_lat", NA_real_), stringsAsFactors = FALSE)
  if (!is.null(plan$areas) && nrow(plan$areas)) {
    ar <- plan$areas
    a_xy <- st_coordinates(suppressWarnings(st_point_on_surface(st_geometry(ar))))
    L <- rbind(L, data.frame(x = a_xy[, 1], y = a_xy[, 2], text = ar$name, face = "italic",
                             colour = ifelse(ar$role == "protected_area", "#3d6b30", "#555555"),
                             size = 2.6, kind = "area", pos = getc(ar, "label_pos", ""),
                             lx = getc(ar, "label_lon", NA_real_), ly = getc(ar, "label_lat", NA_real_),
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
                                  fill = "white", label.size = 0, label.padding = unit(0.08, "lines"))))
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
                                  fill = "white", label.size = 0, label.padding = unit(0.08, "lines"))))
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

render_map <- function(plan, out_stem, relief = FALSE, png = TRUE, legend = TRUE) {
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
  pts <- st_transform(st_as_sf(d, coords = c("lon", "lat"), crs = 4326), crs)

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
    if (nrow(ad)) p <- p + geom_sf(data = ad, fill = NA, colour = "#6b6b6b",
                                   linewidth = 0.45, linetype = "42")
  }
  sty <- ROLE_STYLE[ROLE_STYLE$role %in% d$role, ]
  p <- p +
    geom_sf(data = pts, aes(shape = label, fill = label), colour = "#1a1a1a",
            size = pts$size, stroke = 0.35, show.legend = legend) +
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
                           height = unit(0.9, "cm"), width = unit(0.7, "cm"),
                           style = north_arrow_minimal(line_col = "#2b2b2b", text_size = 8)) +
    theme_bw(base_size = 9) +
    theme(panel.background = element_rect(fill = "#dce7eb"),
          panel.grid.major = element_line(colour = "white", linetype = "dotted", linewidth = 0.3),
          axis.title = element_blank(), axis.text = element_text(size = 7.5, colour = "#333333"),
          legend.position = "bottom", legend.key = element_blank(),
          legend.text = element_text(size = 8), legend.margin = margin(0, 0, 0, 0),
          plot.margin = margin(2, 3, 2, 2, "mm"))

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
  pdf <- paste0(out_stem, if (relief) "_relief" else "_vector", ".pdf")
  ggsave(pdf, out, width = plan$page_mm[1], height = plan$page_mm[2], units = "mm",
         device = cairo_pdf)
  if (png) ggsave(sub("\\.pdf$", ".png", pdf), out, width = plan$page_mm[1],
                  height = plan$page_mm[2], units = "mm", dpi = 200, bg = "white")
  invisible(pdf)
}
