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
  sty <- ROLE_STYLE[ROLE_STYLE$role %in% d$role, ]
  p <- p +
    geom_sf(data = pts, aes(shape = label, fill = label), colour = "#1a1a1a",
            size = pts$size, stroke = 0.35, show.legend = legend) +
    geom_text_repel(data = pts, aes(label = name, geometry = geometry),
                    stat = "sf_coordinates", size = 3, fontface = pts$face,
                    bg.color = "white", bg.r = 0.15, max.overlaps = Inf,
                    box.padding = 0.35, point.padding = 0.3, min.segment.length = 0,
                    segment.colour = "#555555", segment.size = 0.3, seed = 1) +
    scale_shape_manual(NULL, values = setNames(sty$shape, sty$label)) +
    scale_fill_manual(NULL, values = setNames(sty$fill, sty$label))

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
