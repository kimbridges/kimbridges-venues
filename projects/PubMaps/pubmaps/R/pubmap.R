# ==============================================================================
# pubmap.R -- the whole pipeline
#   pubmap("paper.pdf")          manuscript -> review folder (map, points.csv,
#                                review.html, recipe.yaml)
#   pubmap_rerender(dir)         rebuild after the editor has edited points.csv
# ==============================================================================

write_recipe <- function(plan, dir, manuscript, provider) {
  d <- plan$points[plan$points$drawn, ]
  r <- list(
    manuscript = manuscript, made = format(Sys.time(), "%Y-%m-%d %H:%M"),
    read_by = provider, pubmaps_version = as.character(utils::packageVersion("pubmaps")),
    projection = if (!is.na(plan$crs$epsg)) paste0("EPSG:", plan$crs$epsg) else plan$crs$input,
    extent_lonlat = round(plan$extent_lonlat, 5), page_mm = plan$page_mm,
    framed_by = if (isTRUE(plan$framed_by_areas)) "study districts and parks" else "points",
    inset = list(corner = plan$inset_corner, countries = plan$inset$countries,
                 widened_for_inset = plan$widened_for_inset),
    north_arrow = plan$north_arrow, scale_bar = plan$scale_bar,
    points = lapply(seq_len(nrow(d)), function(i) list(
      name = if (!is.null(d$label) && !is.na(d$label[i]) && nzchar(d$label[i])) d$label[i] else d$name[i],
      role = d$role[i], lon = round(d$lon[i], 5), lat = round(d$lat[i], 5),
      source = d$coord_source[i], match = d$match[i])))
  yaml::write_yaml(r, file.path(dir, "recipe.yaml"))
}

# display choices (legend strip, inset country name) are kept per review folder,
# so a redraw keeps what the editor chose last time
DISPLAY_DEFAULT <- list(legend = TRUE, inset_label = TRUE)
display_settings <- function(dir, legend = NULL, inset_label = NULL) {
  f <- file.path(dir, "display.rds")
  d <- if (file.exists(f)) utils::modifyList(DISPLAY_DEFAULT, readRDS(f)) else DISPLAY_DEFAULT
  if (!is.null(legend)) d$legend <- isTRUE(legend)
  if (!is.null(inset_label)) d$inset_label <- isTRUE(inset_label)
  saveRDS(d, f)
  d
}

build_outputs <- function(points, dir, manuscript, provider, relief = FALSE, display = DISPLAY_DEFAULT) {
  plan <- withCallingHandlers(plan_map(points), warning = function(w) {
    message("PLAN: ", conditionMessage(w)); invokeRestart("muffleWarning") })
  stem <- file.path(dir, "map")
  pdf <- render_map(plan, stem, relief = FALSE, legend = display$legend, inset_label = display$inset_label)
  if (relief) render_map(plan, stem, relief = TRUE, png = FALSE, legend = display$legend,
                         inset_label = display$inset_label)
  layers <- attr(pdf, "layers")
  key <- symbol_key(layers, inset_small = isTRUE(attr(layers, "inset_small")))
  writeLines(key, file.path(dir, "symbol_key.txt"), useBytes = TRUE)
  saveRDS(plan, file.path(dir, "plan.rds"))
  write_points_csv(plan$points, dir, plan)
  write_recipe(plan, dir, manuscript, provider)
  review_report(plan, dir, manuscript, png = paste0(stem, "_vector.png"), provider = provider,
                key = key, legend = display$legend)
  invisible(plan)
}

# the model used when pubmap() is not given one (provider -> model name)
DEFAULT_MODEL <- list(openai = "gpt-6.1-sol", anthropic = "claude-sonnet-5-5")

#' Make a study-site map from a manuscript
#'
#' Reads the manuscript with a language model, locates every place in the
#' gazetteers, plans and draws the map, and writes a review folder: the map
#' (`map_vector.pdf`, `map_vector.png`), the review page (`review.html`), the
#' editor's table (`points.csv`) and a record of what was drawn (`recipe.yaml`).
#'
#' @param manuscript Path to the manuscript, a PDF or a text file.
#' @param dir Review folder to write. By default a folder named after the
#'   manuscript inside [pubmaps_review_dir()].
#' @param provider Which language model provider reads the manuscript:
#'   `"openai"`, `"anthropic"` or `"gemini"`. Its API key must be in `.Renviron`.
#' @param model Model name. `NULL` (the default) uses PubMaps' choice for the
#'   provider: `"gpt-6.1-sol"` for OpenAI, `"claude-sonnet-5-5"` for Anthropic.
#'   The model used is recorded on the review page.
#' @param backends Gazetteers to search, `"geonames"` and/or `"nominatim"`.
#' @param places Optional: a place table already made by [extract_places()],
#'   to skip the reading step.
#' @param relief Also draw `map_relief.pdf`, with shaded relief.
#' @param legend Draw the legend strip under the map. Set `FALSE` for a journal
#'   that explains the symbols in the caption; the review page and
#'   `symbol_key.txt` give the key as text either way.
#' @param inset_label Print the country name on the inset map.
#'   For both, `NULL` (the default) keeps the review folder's last choice; a new
#'   folder starts with both on.
#' @return The review folder path, invisibly.
#' @seealso [pubmap_rerender()] to redraw after editing `points.csv`.
#' @examples
#' \dontrun{
#' pubmap("Medley_et_al_2010.pdf")
#' pubmap("paper.pdf", provider = "anthropic")
#' }
#' @export
pubmap <- function(manuscript, dir = NULL, provider = "openai", model = NULL,
                   backends = c("geonames", "nominatim"), places = NULL, relief = FALSE,
                   legend = NULL, inset_label = NULL) {
  if (is.null(model)) model <- DEFAULT_MODEL[[provider]]
  stem <- tools::file_path_sans_ext(basename(manuscript))
  if (is.null(dir)) dir <- file.path(pubmaps_review_dir(), stem)
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  if (is.null(places)) places <- extract_places(manuscript, provider, model)
  saveRDS(places, file.path(dir, "places_extracted.rds"))
  pts <- locate_places(places, backends = backends,
                       cache_dir = file.path(pubmaps_cache_dir(), "gazetteer"))
  provider_txt <- attr(places, "provider") %||% paste(provider, model)
  saveRDS(provider_txt, file.path(dir, "provider.rds"))
  build_outputs(pts, dir, basename(manuscript), provider_txt, relief,
                display_settings(dir, legend, inset_label))
  message("Review: ", normalizePath(file.path(dir, "review.html"), winslash = "/", mustWork = FALSE))
  invisible(dir)
}

# a review folder from a full path, a folder name, or a manuscript name (with or
# without .pdf) -- looked for first as given, then inside pubmaps_review_dir()
resolve_review_dir <- function(dir) {
  if (file.exists(file.path(dir, "points.csv"))) return(dir)
  stem <- tools::file_path_sans_ext(basename(dir))
  alt <- file.path(pubmaps_review_dir(), stem)
  if (file.exists(file.path(alt, "points.csv"))) return(alt)
  stop("No review folder found for \"", dir, "\".\n",
       "  Review folders are in ", normalizePath(pubmaps_review_dir(), winslash = "/", mustWork = FALSE), ".\n",
       "  Give the manuscript's name, e.g. pubmap_rerender(\"", stem, "\"),\n",
       "  or copy the line under 'Making corrections' on the review page.", call. = FALSE)
}

#' Redraw a map after corrections
#'
#' Reads the editor's corrections from `points.csv` in a review folder and
#' redraws the map and review page. The manuscript is not read again and no
#' gazetteer lookups are repeated.
#'
#' @param dir The review folder: its full path, or just the manuscript's name
#'   (with or without `.pdf`), which is looked for in [pubmaps_review_dir()].
#' @param relief Also draw `map_relief.pdf`, with shaded relief.
#' @param legend,inset_label `TRUE` or `FALSE` to change the legend strip or the
#'   inset's country name; `NULL` (the default) keeps the folder's last choice.
#' @return The review folder path, invisibly.
#' @examples
#' \dontrun{
#' pubmap_rerender("Medley_et_al_2010")
#' pubmap_rerender("Medley_et_al_2010", legend = FALSE)   # key goes in the caption
#' pubmap_rerender("C:/maps/review/Medley_et_al_2010")
#' }
#' @export
pubmap_rerender <- function(dir, relief = FALSE, legend = NULL, inset_label = NULL) {
  dir <- resolve_review_dir(dir)
  pts <- read_points_csv(dir)
  places <- readRDS(file.path(dir, "places_extracted.rds"))
  prov <- if (file.exists(file.path(dir, "provider.rds"))) readRDS(file.path(dir, "provider.rds")) else ""
  build_outputs(pts, dir, attr(places, "manuscript") %||% basename(dir), prov, relief,
                display_settings(dir, legend, inset_label))
  message("Review: ", normalizePath(file.path(dir, "review.html"), winslash = "/", mustWork = FALSE))
  invisible(dir)
}
