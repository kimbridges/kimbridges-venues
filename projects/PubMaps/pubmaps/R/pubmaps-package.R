#' pubmaps: study-site maps for journal editors
#'
#' PubMaps turns a manuscript into a publication-ready study-site map with a
#' locator inset. A language model reads the manuscript and lists its places;
#' two gazetteers, GeoNames and OpenStreetMap, locate them; fixed rules plan the
#' map; and the editor checks and corrects everything on a review page, through
#' one table, `points.csv`.
#'
#' Start with [pubmap()]; after editing `points.csv`, run [pubmap_rerender()].
#' The Editor's Guide explains the whole process.
#'
#' @keywords internal
#' @importFrom ellmer type_object type_string type_enum type_number type_integer type_array
#' @importFrom httr2 request req_user_agent req_url_query req_retry req_error req_perform
#'   resp_status resp_body_json req_body_form req_timeout resp_content_type
#' @importFrom countrycode countrycode
#' @importFrom sf st_crs st_as_sf st_coordinates st_transform st_bbox st_as_sfc
#'   st_nearest_feature st_centroid st_union st_cast st_make_valid st_geometry st_sf
#'   st_area st_distance st_read st_sfc st_point st_intersection st_is_empty
#'   st_simplify st_write st_crop st_point_on_surface st_linestring st_length
#'   st_line_sample st_collection_extract st_buffer st_make_grid st_intersects
#' @importFrom rnaturalearth ne_countries ne_states
#' @importFrom ggplot2 ggplot aes geom_sf geom_segment geom_label annotation_raster
#'   scale_colour_identity scale_size_identity scale_shape_manual scale_fill_manual
#'   coord_sf scale_x_continuous scale_y_continuous theme_bw theme theme_void
#'   element_rect element_line element_blank element_text margin ggsave
#' @importFrom ggrepel geom_text_repel
#' @importFrom ggspatial annotation_scale annotation_north_arrow north_arrow_minimal
#' @importFrom patchwork inset_element
#' @importFrom stats median setNames
#' @importFrom utils adist
"_PACKAGE"

# columns referred to inside ggplot2 aes()
utils::globalVariables(c("x", "y", "lx", "ly", "label", "text", "face", "colour",
                         "size", "tx", "ty", "hj", "vj", "seg", "psize", "x0", "ps"))
