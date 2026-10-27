library(sf)
library(ggplot2)
library(rnaturalearth)
library(rnaturalearthdata)
library(patchwork)
library(ggspatial)
library(ggrepel)
library(terra)
library(elevatr)



clean_geo_text <- function(txt) {
  if (length(txt) == 0) return(character(0))
  txt_clean <- iconv(txt, to = "ASCII//TRANSLIT")
  txt_clean <- gsub("['`^~]", "", tolower(trimws(txt_clean)))
  txt_clean[is.na(txt_clean)] <- ""
  return(txt_clean)
}

auto_utm_crs <- function(lon, lat) {
  zone <- floor((lon + 180) / 6) + 1
  if (lat >= 0) return(32600 + zone) else return(32700 + zone)
}

generate_publication_map <- function(country_name, 
                                     subdivision_name = NULL, 
                                     study_bbox_wgs84, 
                                     main_bbox_wgs84  = NULL,
                                     sites_df         = NULL, 
                                     inset_corner     = "tr",
                                     relief           = FALSE,
                                     output_pdf       = "study_map.pdf") {
  
  # 1. Base geometries & Country Lookup
  world_wgs84 <- ne_countries(scale = "medium", returnclass = "sf")
  
  target_country_clean <- clean_geo_text(country_name)
  world_clean_names    <- clean_geo_text(world_wgs84$name)
  world_clean_admin    <- clean_geo_text(world_wgs84$admin)
  
  matched_country_idx  <- which(world_clean_names == target_country_clean | 
                                  world_clean_admin == target_country_clean)
  
  country_query_name <- if (length(matched_country_idx) > 0) world_wgs84$name[matched_country_idx[1]] else country_name
  country_wgs84      <- tryCatch(ne_states(country = country_query_name, returnclass = "sf"),
                                 error = function(e) world_wgs84[matched_country_idx, ])
  
  if (is.null(country_wgs84) || nrow(country_wgs84) == 0) {
    country_wgs84 <- world_wgs84[matched_country_idx, ]
  }
  
  # 2. Reconcile Main Bounding Box (Safe minimum span: >= 0.30 deg)
  bb_raw <- if (!is.null(main_bbox_wgs84)) main_bbox_wgs84 else study_bbox_wgs84
  xmin <- bb_raw[1]; ymin <- bb_raw[2]; xmax <- bb_raw[3]; ymax <- bb_raw[4]
  
  if (!is.null(sites_df) && nrow(sites_df) > 0) {
    xmin <- min(xmin, min(sites_df$lon, na.rm = TRUE))
    xmax <- max(xmax, max(sites_df$lon, na.rm = TRUE))
    ymin <- min(ymin, min(sites_df$lat, na.rm = TRUE))
    ymax <- max(ymax, max(sites_df$lat, na.rm = TRUE))
  }
  
  span_x <- max(xmax - xmin, 0.30)
  span_y <- max(ymax - ymin, 0.30)
  x_mid  <- (xmin + xmax) / 2
  y_mid  <- (ymin + ymax) / 2
  
  dx <- span_x * 0.20
  dy <- span_y * 0.20
  main_lims_wgs84 <- c(xmin = (x_mid - span_x/2) - dx,
                       ymin = (y_mid - span_y/2) - dy,
                       xmax = (x_mid + span_x/2) + dx,
                       ymax = (y_mid + span_y/2) + dy)
  
  # 3. Dynamic UTM Projection & Spatial Pre-Cropping
  local_crs <- auto_utm_crs(x_mid, y_mid)
  
  regional_clip_box <- st_as_sfc(st_bbox(c(
    xmin = max(-180, main_lims_wgs84["xmin"] - 8),
    ymin = max(-85,  main_lims_wgs84["ymin"] - 8),
    xmax = min(180,  main_lims_wgs84["xmax"] + 8),
    ymax = min(85,   main_lims_wgs84["ymax"] + 8)
  ), crs = 4326))
  
  suppressWarnings({
    regional_land_wgs84 <- st_crop(world_wgs84, regional_clip_box)
  })
  
  world_proj   <- st_transform(regional_land_wgs84, local_crs)
  country_proj <- st_transform(country_wgs84, local_crs)
  
  # Study bounding polygon
  study_poly_wgs84 <- st_as_sfc(st_bbox(setNames(
    c(min(study_bbox_wgs84[1], study_bbox_wgs84[3] - 0.05),
      min(study_bbox_wgs84[2], study_bbox_wgs84[4] - 0.05),
      max(study_bbox_wgs84[3], study_bbox_wgs84[1] + 0.05),
      max(study_bbox_wgs84[4], study_bbox_wgs84[2] + 0.05)),
    c("xmin", "ymin", "xmax", "ymax")), crs = 4326))
  study_proj <- st_transform(study_poly_wgs84, local_crs)
  
  # 4. Topographic Shaded Relief Layer (Enhanced Physiographic Contrast)
  hillshade_matrix <- NULL
  hillshade_ext    <- NULL
  
  if (relief) {
    message("Fetching elevation raster and generating high-contrast hillshade...")
    target_box_df <- data.frame(
      x = c(main_lims_wgs84["xmin"], main_lims_wgs84["xmax"]),
      y = c(main_lims_wgs84["ymin"], main_lims_wgs84["ymax"])
    )
    
    dem_raw <- tryCatch({
      elev_sp <- elevatr::get_elev_raster(
        locations = target_box_df, 
        prj = "EPSG:4326", 
        z = 8,  # Bump to z = 8 for crisper terrain definition on smaller extents
        clip = "bbox", 
        verbose = FALSE
      )
      terra::rast(elev_sp)
    }, error = function(e) {
      warning("Elevation download failed: ", conditionMessage(e))
      NULL
    })
    
    if (!is.null(dem_raw)) {
      dem_proj <- terra::project(dem_raw, paste0("EPSG:", local_crs))
      
      max_dim <- 750
      if (ncol(dem_proj) > max_dim || nrow(dem_proj) > max_dim) {
        fact <- ceiling(max(ncol(dem_proj), nrow(dem_proj)) / max_dim)
        dem_proj <- terra::aggregate(dem_proj, fact = fact, fun = "mean")
      }
      
      # 1. Apply Vertical Exaggeration (2.2x multiplier)
      dem_enhanced <- dem_proj * 2.2
      
      # 2. Steeper sun angle (35 degrees) for deeper cast shadows
      slope  <- terra::terrain(dem_enhanced, "slope", unit = "radians")
      aspect <- terra::terrain(dem_enhanced, "aspect", unit = "radians")
      hs     <- terra::shade(slope, aspect, angle = 35, direction = 315)
      
      # 3. Dynamic contrast stretch (clip outlier extremes)
      hs_vals <- terra::values(hs, na.rm = TRUE)
      q_low   <- stats::quantile(hs_vals, 0.015)
      q_high  <- stats::quantile(hs_vals, 0.985)
      
      hs_clamped <- terra::clamp(hs, lower = q_low, upper = q_high)
      hs_norm    <- (hs_clamped - q_low) / (q_high - q_low)
      
      # 4. Expanded tonal gradient (from deep shadow #1a1a1a to bright ridge #ffffff)
      hs_mat <- terra::as.matrix(hs_norm, wide = TRUE)
      hillshade_matrix <- matrix(
        scales::col_numeric(
          palette = c("#1a1a1a", "#555555", "#8c8c8c", "#cccccc", "#ffffff"), 
          domain = c(0, 1)
        )(hs_mat),
        nrow = nrow(hs_mat), ncol = ncol(hs_mat)
      )
      hillshade_ext <- terra::ext(dem_proj)
    }
  }
  
  # 5. Smart Collision-Free Inset Selection
  inset_corner <- "tr"
  if (!is.null(sites_df) && nrow(sites_df) > 0) {
    tl_pts <- sum(sites_df$lon < x_mid & sites_df$lat > y_mid)
    tr_pts <- sum(sites_df$lon >= x_mid & sites_df$lat > y_mid)
    bl_pts <- sum(sites_df$lon < x_mid & sites_df$lat <= y_mid)
    br_pts <- sum(sites_df$lon >= x_mid & sites_df$lat <= y_mid)
    quad_counts  <- c(tl = tl_pts, tr = tr_pts, bl = bl_pts, br = br_pts)
    inset_corner <- names(which.min(quad_counts))[1]
  }
  
  north_arrow_loc <- if (grepl("t", inset_corner)) {
    if (grepl("l", inset_corner)) "tr" else "tl"
  } else {
    if (grepl("l", inset_corner)) "br" else "bl"
  }
  
  # 6. Build Main Plot
  p_main <- ggplot()
  
  if (!is.null(hillshade_matrix)) {
    p_main <- p_main +
      annotation_raster(
        raster = hillshade_matrix,
        xmin = hillshade_ext$xmin, xmax = hillshade_ext$xmax,
        ymin = hillshade_ext$ymin, ymax = hillshade_ext$ymax,
        interpolate = TRUE
      ) +
      geom_sf(data = world_proj, fill = NA, color = "#949494", linewidth = 0.25) +
      geom_sf(data = country_proj, fill = NA, color = "#525252", linewidth = 0.4)
  } else {
    p_main <- p_main +
      geom_sf(data = world_proj, fill = "#ebebeb", color = "#d4d4d4", linewidth = 0.2) +
      geom_sf(data = country_proj, fill = "#f5f5f5", color = "#b0b0b0", linewidth = 0.35)
  }
  
  p_main <- p_main +
    geom_sf(data = study_proj, fill = "#c9dfec", alpha = 0.40, color = "#1b4965", linewidth = 0.8)
  
  if (!is.null(sites_df) && nrow(sites_df) > 0) {
    sites_sf <- st_as_sf(sites_df, coords = c("lon", "lat"), crs = 4326) |> st_transform(local_crs)
    p_main <- p_main +
      geom_sf(data = sites_sf, aes(shape = type, color = type), size = 2.8, show.legend = FALSE) +
      geom_text_repel(
        data = sites_sf, aes(label = name, geometry = geometry),
        stat = "sf_coordinates", size = 3.0, fontface = "bold",
        bg.color = "white", bg.r = 0.15,
        max.overlaps = Inf, box.padding = 0.35, point.padding = 0.25,
        min.segment.length = 0, segment.color = "#555555", segment.size = 0.3
      ) +
      scale_color_manual(values = c("Study Site" = "#d95f02", "Market Town" = "#1b4965")) +
      scale_shape_manual(values = c("Study Site" = 16, "Market Town" = 17))
  }
  
  lon_span <- unname(main_lims_wgs84["xmax"] - main_lims_wgs84["xmin"])
  lat_span <- unname(main_lims_wgs84["ymax"] - main_lims_wgs84["ymin"])
  lon_step <- if (lon_span <= 0.6) 0.2 else if (lon_span <= 1.5) 0.5 else if (lon_span <= 3.5) 1.0 else 2.0
  lat_step <- if (lat_span <= 0.6) 0.2 else if (lat_span <= 1.5) 0.5 else if (lat_span <= 3.5) 1.0 else 2.0
  
  lon_breaks <- seq(floor(main_lims_wgs84["xmin"] / lon_step) * lon_step,
                    ceiling(main_lims_wgs84["xmax"] / lon_step) * lon_step, by = lon_step)
  lat_breaks <- seq(floor(main_lims_wgs84["ymin"] / lat_step) * lat_step,
                    ceiling(main_lims_wgs84["ymax"] / lat_step) * lat_step, by = lat_step)
  
  p_main <- p_main +
    coord_sf(
      crs = local_crs,
      default_crs = sf::st_crs(4326),
      xlim = c(main_lims_wgs84["xmin"], main_lims_wgs84["xmax"]),
      ylim = c(main_lims_wgs84["ymin"], main_lims_wgs84["ymax"]),
      expand = FALSE
    ) +
    scale_x_continuous(breaks = lon_breaks) +
    scale_y_continuous(breaks = lat_breaks) +
    annotation_scale(location = "br", width_hint = 0.20, style = "ticks", line_col = "#2b2b2b") +
    annotation_north_arrow(location = north_arrow_loc, which_north = "true",
                           height = unit(1.0, "cm"), width = unit(0.8, "cm"),
                           style = north_arrow_minimal(line_col = "#2b2b2b")) +
    theme_bw(base_size = 10) +
    theme(
      panel.background = element_rect(fill = "#dce7eb"),
      panel.grid.major = element_line(color = "#ffffff", linetype = "dotted", linewidth = 0.35),
      axis.title = element_blank(),
      axis.text = element_text(size = 8.5, color = "#333333"),
      plot.margin = margin(3, 3, 5, 3, "mm")
    )
  
  # 7. National Inset with Open Study Frame
  cntry_bb <- st_bbox(country_wgs84)
  p_inset <- ggplot() +
    geom_sf(data = world_wgs84, fill = "#fafafa", color = "#dcdcdc", linewidth = 0.2) +
    geom_sf(data = country_wgs84, fill = "#c5c5c5", color = "#7a7a7a", linewidth = 0.3) +
    geom_sf(data = study_poly_wgs84, fill = "#d95f02", alpha = 0.18, 
            color = "#d95f02", linewidth = 0.9, linetype = "solid") +
    coord_sf(
      xlim = c(cntry_bb["xmin"] - 0.5, cntry_bb["xmax"] + 0.5),
      ylim = c(cntry_bb["ymin"] - 0.5, cntry_bb["ymax"] + 0.5),
      datum = NA, expand = FALSE
    ) +
    theme_void() +
    theme(
      panel.background = element_rect(fill = "#f2f7f9", color = NA),
      panel.border = element_rect(color = "#2b2b2b", fill = NA, linewidth = 0.5)
    )
  
  inset_pos <- switch(
    inset_corner,
    "tr" = list(left = 0.66, bottom = 0.55, right = 0.98, top = 0.98),
    "tl" = list(left = 0.02, bottom = 0.55, right = 0.34, top = 0.98),
    "br" = list(left = 0.66, bottom = 0.02, right = 0.98, top = 0.45),
    "bl" = list(left = 0.02, bottom = 0.02, right = 0.34, top = 0.45)
  )
  
  p_final <- p_main +
    inset_element(p_inset, 
                  left = inset_pos$left, bottom = inset_pos$bottom, 
                  right = inset_pos$right, top = inset_pos$top, 
                  align_to = "panel")
  
  ggsave(output_pdf, plot = p_final, width = 170, height = 130, units = "mm", device = cairo_pdf)
}

#################################

generate_map_pair <- function(config) {
  base_stem <- tools::file_path_sans_ext(config$output_pdf)
  sites_df  <- if (!is.null(config$sites)) do.call(rbind, lapply(config$sites, as.data.frame)) else NULL
  
  # 1. Standard Vector Version
  pdf_vec <- paste0(base_stem, "_vector.pdf")
  message("Generating Vector: ", pdf_vec)
  generate_publication_map(
    country_name     = config$country_name,
    subdivision_name = config$subdivision_name,
    study_bbox_wgs84 = unlist(config$study_bbox_wgs84),
    main_bbox_wgs84  = unlist(config$main_bbox_wgs84),
    sites_df         = sites_df,
    inset_corner     = config$inset_corner,
    relief           = FALSE,
    output_pdf       = pdf_vec
  )
  
  # 2. Topographic Shaded Relief Version
  pdf_dem <- paste0(base_stem, "_relief.pdf")
  message("Generating Relief: ", pdf_dem)
  generate_publication_map(
    country_name     = config$country_name,
    subdivision_name = config$subdivision_name,
    study_bbox_wgs84 = unlist(config$study_bbox_wgs84),
    main_bbox_wgs84  = unlist(config$main_bbox_wgs84),
    sites_df         = sites_df,
    inset_corner     = config$inset_corner,
    relief           = TRUE,
    output_pdf       = pdf_dem
  )
}

