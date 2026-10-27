# ==============================================================================
# pubmap.R -- the whole pipeline
#   pubmap("paper.pdf")          manuscript -> review folder (map, points.csv,
#                                review.html, recipe.yaml)
#   pubmap_rerender(dir)         rebuild after the editor has edited points.csv
# ==============================================================================

pubmaps_home <- function() {
  d <- getOption("pubmaps.home", "G:/My Drive/Projects/PubMaps")
  if (!dir.exists(d)) stop("Set options(pubmaps.home = <PubMaps folder>)")
  d
}
PUBMAPS_MODULES <- c("extract_places", "locate_places", "plan_map", "plan_areas", "render_map",
                     "points_io", "review_report")
# (2026-10-25) pubmap() and pubmap_rerender() reload the modules on every run, so an
# R session that sourced PubMaps earlier never runs out-of-date code.
pubmaps_load <- function()
  for (f in PUBMAPS_MODULES) source(file.path(pubmaps_home(), "R", paste0(f, ".R")))
pubmaps_load()

write_recipe <- function(plan, dir, manuscript, provider) {
  d <- plan$points[plan$points$drawn, ]
  r <- list(
    manuscript = manuscript, made = format(Sys.time(), "%Y-%m-%d %H:%M"),
    read_by = provider,
    projection = if (!is.na(plan$crs$epsg)) paste0("EPSG:", plan$crs$epsg) else plan$crs$input,
    extent_lonlat = round(plan$extent_lonlat, 5), page_mm = plan$page_mm,
    inset = list(corner = plan$inset_corner, countries = plan$inset$countries,
                 widened_for_inset = plan$widened_for_inset),
    north_arrow = plan$north_arrow, scale_bar = plan$scale_bar,
    points = lapply(seq_len(nrow(d)), function(i) list(
      name = if (!is.null(d$label) && !is.na(d$label[i]) && nzchar(d$label[i])) d$label[i] else d$name[i],
      role = d$role[i], lon = round(d$lon[i], 5), lat = round(d$lat[i], 5),
      source = d$coord_source[i], match = d$match[i])))
  yaml::write_yaml(r, file.path(dir, "recipe.yaml"))
}

build_outputs <- function(points, dir, manuscript, provider, relief = FALSE) {
  plan <- withCallingHandlers(plan_map(points), warning = function(w) {
    message("PLAN: ", conditionMessage(w)); invokeRestart("muffleWarning") })
  stem <- file.path(dir, "map")
  render_map(plan, stem, relief = FALSE)
  if (relief) render_map(plan, stem, relief = TRUE, png = FALSE)
  saveRDS(plan, file.path(dir, "plan.rds"))
  write_points_csv(plan$points, dir, plan)
  write_recipe(plan, dir, manuscript, provider)
  review_report(plan, dir, manuscript, png = paste0(stem, "_vector.png"), provider = provider)
  invisible(plan)
}

pubmap <- function(manuscript, dir = NULL, provider = "openai", model = "gpt-6.1-sol",
                   backends = c("geonames", "nominatim"), places = NULL, relief = FALSE) {
  pubmaps_load()
  stem <- tools::file_path_sans_ext(basename(manuscript))
  if (is.null(dir)) dir <- file.path(pubmaps_home(), "review", stem)
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  if (is.null(places)) places <- extract_places(manuscript, provider, model)
  saveRDS(places, file.path(dir, "places_extracted.rds"))
  pts <- locate_places(places, backends = backends,
                       cache_dir = file.path(pubmaps_home(), "cache", "gazetteer"))
  provider_txt <- attr(places, "provider") %||% paste(provider, model)
  saveRDS(provider_txt, file.path(dir, "provider.rds"))
  build_outputs(pts, dir, basename(manuscript), provider_txt, relief)
  message("Review: ", file.path(dir, "review.html"))
  invisible(dir)
}

pubmap_rerender <- function(dir, relief = FALSE) {
  pubmaps_load()
  pts <- read_points_csv(dir)
  places <- readRDS(file.path(dir, "places_extracted.rds"))
  prov <- if (file.exists(file.path(dir, "provider.rds"))) readRDS(file.path(dir, "provider.rds")) else ""
  build_outputs(pts, dir, attr(places, "manuscript") %||% basename(dir), prov, relief)
  message("Review: ", file.path(dir, "review.html"))
  invisible(dir)
}
