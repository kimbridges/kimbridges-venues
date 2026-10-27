# ------------------------------------------------------------------------------
# Generic Reference Map Engine
# ------------------------------------------------------------------------------
library(sf)
library(ggplot2)
library(rnaturalearth)
library(rnaturalearthdata)
library(patchwork)
library(ggspatial)
library(ggrepel)
library(yaml)

auto_utm_crs <- function(lon, lat) {
  # Automatically select local UTM zone EPSG code
  zone <- floor((lon + 180) / 6) + 1
  if (lat >= 0) {
    return(32600 + zone) # Northern Hemisphere
  } else {
    return(32700 + zone) # Southern Hemisphere
  }
}

generate_publication_map <- function(country_name, 
                                     subdivision_name = NULL, 
                                     study_bbox_wgs84, 
                                     main_bbox_wgs84  = NULL,
                                     sites_df         = NULL, 
                                     inset_corner     = "tr",
                                     output_pdf       = "study_map.pdf") {
  
  # 1. Coordinate projection setup
  center_lon <- mean(study_bbox_wgs84[c(1, 3)])
  center_lat <- mean(study_bbox_wgs84[c(2, 4)])
  local_crs  <- auto_utm_crs(center_lon, center_lat)
  
  # 2. Base geometries
  world_wgs84   <- ne_countries(scale = "medium", returnclass = "sf")
  country_wgs84 <- ne_states(country = country_name, returnclass = "sf")
  
  # Optional subdivision highlight
  focal_admin <- NULL
  if (!is.null(subdivision_name) && subdivision_name != "") {
    focal_admin <- subset(country_wgs84, 
                          tolower(name) == tolower(subdivision_name) | 
                            tolower(name_en) == tolower(subdivision_name))
  }
  
  # Study bounding polygon
  study_poly_wgs84 <- st_as_sfc(st_bbox(setNames(study_bbox_wgs84, c("xmin", "ymin", "xmax", "ymax")), crs = 4326))
  study_proj       <- st_transform(study_poly_wgs84, local_crs)
  country_proj     <- st_transform(country_wgs84, local_crs)
  
  # 3. Determine extent for the Main Map
  if (!is.null(main_bbox_wgs84)) {
    # Custom regional window
    main_poly_wgs84 <- st_as_sfc(st_bbox(setNames(main_bbox_wgs84, c("xmin", "ymin", "xmax", "ymax")), crs = 4326))
    main_limits     <- st_bbox(st_transform(main_poly_wgs84, local_crs))
  } else if (!is.null(focal_admin) && nrow(focal_admin) > 0) {
    # Fallback to subdivision boundary
    focal_proj  <- st_transform(focal_admin, local_crs)
    focal_bb    <- st_bbox(focal_proj)
    x_pad       <- (focal_bb["xmax"] - focal_bb["xmin"]) * 0.08
    y_pad       <- (focal_bb["ymax"] - focal_bb["ymin"]) * 0.08
    main_limits <- c(xmin = focal_bb["xmin"] - x_pad, ymin = focal_bb["ymin"] - y_pad,
                     xmax = focal_bb["xmax"] + x_pad, ymax = focal_bb["ymax"] + y_pad)
  } else {
    # Default buffer of 80 km around the study site
    buf         <- st_buffer(st_centroid(study_proj), dist = 80000)
    main_limits <- st_bbox(buf)
  }
  
  # 4. Main Plot
  p_main <- ggplot() +
    geom_sf(data = country_proj, fill = "#f5f5f5", color = "#b8b8b8", linewidth = 0.3)
  
  if (!is.null(focal_admin) && nrow(focal_admin) > 0) {
    p_main <- p_main + geom_sf(data = st_transform(focal_admin, local_crs), 
                               fill = "#e8eef2", color = "#5c6b73", linewidth = 0.6)
  }
  
  p_main <- p_main +
    geom_sf(data = study_proj, fill = "#c9dfec", alpha = 0.55, color = "#1b4965", linewidth = 0.8)
  
  if (!is.null(sites_df)) {
    sites_sf <- st_as_sf(sites_df, coords = c("lon", "lat"), crs = 4326) |> st_transform(local_crs)
    p_main <- p_main +
      geom_sf(data = sites_sf, aes(shape = type, color = type), size = 2.8) +
      geom_text_repel(
        data = sites_sf, aes(label = name, geometry = geometry),
        stat = "sf_coordinates", size = 3.3, fontface = "bold",
        bg.color = "white", bg.r = 0.15
      ) +
      scale_color_manual(values = c("Study Site" = "#d95f02", "Market Town" = "#1b4965")) +
      scale_shape_manual(values = c("Study Site" = 16, "Market Town" = 17))
  }
  
  p_main <- p_main +
    coord_sf(
      xlim = c(main_limits["xmin"], main_limits["xmax"]),
      ylim = c(main_limits["ymin"], main_limits["ymax"]),
      expand = FALSE
    ) +
    annotation_scale(location = "br", width_hint = 0.22, style = "ticks", line_col = "#2b2b2b") +
    annotation_north_arrow(location = "tl", which_north = "true",
                           height = unit(1.0, "cm"), width = unit(0.8, "cm"),
                           style = north_arrow_minimal(line_col = "#2b2b2b")) +
    theme_bw(base_size = 10) +
    theme(
      legend.position = c(0.18, 0.14),
      legend.title = element_blank(),
      legend.background = element_rect(fill = alpha("white", 0.9), color = "#cccccc", linewidth = 0.3),
      panel.grid.major = element_line(color = "#e5e5e5", linetype = "dotted", linewidth = 0.3),
      axis.title = element_blank()
    )
  
  # 5. National Overview Inset
  cntry_bb <- st_bbox(country_wgs84)
  p_inset <- ggplot() +
    geom_sf(data = world_wgs84, fill = "#fafafa", color = "#dcdcdc", linewidth = 0.2) +
    geom_sf(data = country_wgs84, fill = "#ebebeb", color = "#b0b0b0", linewidth = 0.2)
  
  if (!is.null(focal_admin) && nrow(focal_admin) > 0) {
    p_inset <- p_inset + geom_sf(data = focal_admin, fill = "#62b6cb", color = "#1b4965", linewidth = 0.35)
  }
  
  p_inset <- p_inset +
    geom_sf(data = study_poly_wgs84, fill = "#d95f02", color = "#d95f02", linewidth = 0.8) +
    coord_sf(
      xlim = c(cntry_bb["xmin"] - 0.5, cntry_bb["xmax"] + 0.5),
      ylim = c(cntry_bb["ymin"] - 0.5, cntry_bb["ymax"] + 0.5),
      datum = NA, expand = FALSE
    ) +
    theme_void() +
    theme(
      panel.background = element_rect(fill = "#ffffff", color = NA),
      panel.border = element_rect(color = "#2b2b2b", fill = NA, linewidth = 0.5)
    )
  
  # 6. Assembly
  inset_pos <- switch(
    inset_corner,
    "tr" = list(left = 0.69, bottom = 0.57, right = 0.98, top = 0.98),
    "tl" = list(left = 0.02, bottom = 0.57, right = 0.31, top = 0.98),
    "br" = list(left = 0.69, bottom = 0.02, right = 0.98, top = 0.43),
    "bl" = list(left = 0.02, bottom = 0.02, right = 0.31, top = 0.43)
  )
  
  p_final <- p_main +
    inset_element(p_inset, 
                  left = inset_pos$left, bottom = inset_pos$bottom, 
                  right = inset_pos$right, top = inset_pos$top, 
                  align_to = "panel")
  
  ggsave(output_pdf, plot = p_final, width = 170, height = 130, units = "mm", device = cairo_pdf)
}

############################################################

# Read the YAML configuration
config <- yaml::read_yaml("nepal_study_params.yaml")

# Convert the sites list into a standard data frame
sites_df <- do.call(rbind, lapply(config$sites, as.data.frame))

# Pass unpacked parameters into the map generator function
generate_publication_map(
  country_name     = config$country_name,
  subdivision_name = config$subdivision_name,
  study_bbox_wgs84 = unlist(config$study_bbox_wgs84),
  main_bbox_wgs84  = unlist(config$main_bbox_wgs84),
  sites_df         = sites_df,
  inset_corner     = config$inset_corner,
  output_pdf       = config$output_pdf
)

