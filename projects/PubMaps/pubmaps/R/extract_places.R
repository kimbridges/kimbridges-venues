# ==============================================================================
# extract_places.R -- PubMaps step 1: EXTRACT
# Read a whole manuscript and return every mappable place it mentions, as a typed
# table. The LLM reads; it does NOT locate. Coordinates are kept only when the
# manuscript itself states them (stated_lat / stated_lon), never estimated.
# ==============================================================================

# ------------------------------------------------------------------------------
# Manuscript text, page-tagged so evidence can be traced back
# ------------------------------------------------------------------------------
manuscript_text <- function(path) {
  ext <- tolower(tools::file_ext(path))
  if (ext == "pdf") {
    pg <- pdftools::pdf_text(path)
    paste0("=== PAGE ", seq_along(pg), " ===\n", pg, collapse = "\n")
  } else {
    paste(readLines(path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
  }
}

# ------------------------------------------------------------------------------
# The schema: what the LLM must return
# ------------------------------------------------------------------------------
PLACE_ROLES <- c("study_site", "sampling_point", "reference_town",
                 "protected_area", "natural_feature", "administrative_unit",
                 "relative_location", "other")

place_type <- function() type_object(
  name = type_string("Place name exactly as spelled in the manuscript."),
  role = type_enum(
    values = PLACE_ROLES,
    description = paste(
      "study_site = village/locality where fieldwork happened;",
      "sampling_point = plot, transect, station or collection point;",
      "reference_town = town/city given as geographic context or access;",
      "protected_area = park, reserve, forest reserve;",
      "natural_feature = mountain, river, lake, island, valley;",
      "administrative_unit = district, county, province, municipality;",
      "relative_location = a position described relative to named places",
      "(e.g. 'ridge above Makwasinyi village'); not itself a place name.")),
  country = type_string("Country the place is in.", required = FALSE),
  admin1  = type_string("State/province/region, if stated in the manuscript.",
                        required = FALSE),
  stated_lat = type_number(paste(
    "Latitude in decimal degrees, ONLY if the manuscript states coordinates",
    "for THIS place. South is negative. Otherwise leave empty. Never estimate."),
    required = FALSE),
  stated_lon = type_number(paste(
    "Longitude in decimal degrees, ONLY if stated in the manuscript.",
    "West is negative. Otherwise leave empty. Never estimate."),
    required = FALSE),
  coord_text = type_string(
    "The coordinate string exactly as written, if any (e.g. 3 deg 49 min S).",
    required = FALSE),
  elevation_m = type_number("Elevation in metres, if stated.", required = FALSE),
  page = type_integer("PDF page where the place is best described.",
                      required = FALSE),
  evidence = type_string(
    "A short verbatim phrase (under 20 words) from the manuscript naming the place.")
)

manuscript_type <- function() type_object(
  study_countries = type_array(items = type_string(),
    description = "Countries containing the fieldwork (usually one)."),
  study_area_summary = type_string(
    "One sentence: where the fieldwork took place."),
  stated_extent = type_string(paste(
    "Any overall extent the manuscript states (e.g. 'between 1.5-3.5 S and",
    "101-102 E'), verbatim; empty if none."), required = FALSE),
  places = type_array(items = place_type(), description = "Every mappable place, one entry each.")
)

EXTRACT_SYSTEM <- "You are assisting a journal editor who must draw a study-site
map for a manuscript. Read the WHOLE manuscript and list every place that belongs
on that map: fieldwork villages and localities, plots, transects and collection
points, protected areas, and the towns, mountains, rivers or districts the authors
use to locate the study.

Rules:
- Include a place only if it relates to THIS study's fieldwork or its geographic
  setting. Exclude places mentioned only in the reference list, author
  affiliations, acknowledgements, or as locations of other studies cited.
- One entry per place. Use the manuscript's spelling, and give each its FULL
  name: 'Tsavo East and West National Parks' is two entries, 'Tsavo East
  National Park' and 'Tsavo West National Park'.
- A plot or site described only by its position relative to named places is a
  relative_location; put the description in name and keep it short.
- Skip generic phrases that name no particular place ('the forest reserve',
  'the ecosystem') unless the manuscript identifies which one.
- Coordinates: report them ONLY when the manuscript states them for that place,
  converting degrees-minutes-seconds to signed decimal degrees and copying the
  original string to coord_text. If no coordinates are stated, leave them empty.
  NEVER estimate or recall coordinates from your own knowledge.
- Look everywhere: methods, study-area sections, tables, figure captions."

# ------------------------------------------------------------------------------
# Chat constructor: provider is a parameter, so the model is a test variable
# ------------------------------------------------------------------------------
pubmaps_chat <- function(provider = c("anthropic", "openai", "gemini"),
                         model = NULL) {
  provider <- match.arg(provider)
  ex <- getNamespaceExports("ellmer")
  # ellmer 0.1.x names: chat_claude / chat_gemini; >= 0.2: chat_anthropic / chat_google_gemini
  fname <- switch(provider,
    anthropic = if ("chat_anthropic" %in% ex) "chat_anthropic" else "chat_claude",
    openai    = "chat_openai",
    gemini    = if ("chat_google_gemini" %in% ex) "chat_google_gemini" else "chat_gemini")
  f <- getExportedValue("ellmer", fname)
  args <- list(system_prompt = EXTRACT_SYSTEM, echo = "none")
  if (!is.null(model)) args$model <- model
  if ("max_tokens" %in% names(formals(f))) args$max_tokens <- 16000
  do.call(f, args)
}

# ------------------------------------------------------------------------------
# Raw list -> data frame; empty / NULL fields become NA (models differ in how
# they leave an optional field empty)
# ------------------------------------------------------------------------------
PLACE_FIELDS <- list(name = NA_character_, role = NA_character_,
                     country = NA_character_, admin1 = NA_character_,
                     stated_lat = NA_real_, stated_lon = NA_real_,
                     coord_text = NA_character_, elevation_m = NA_real_,
                     page = NA_integer_, evidence = NA_character_)

places_to_df <- function(lst) {
  rows <- lapply(lst, function(p) {
    out <- PLACE_FIELDS
    for (k in names(out)) {
      v <- p[[k]]
      if (!is.null(v) && length(v) == 1 && !(is.character(v) && !nzchar(v)))
        out[[k]] <- methods::as(v, class(out[[k]]))
    }
    as.data.frame(out, stringsAsFactors = FALSE)
  })
  do.call(rbind, rows)
}

#' Extract the mappable places from a manuscript
#'
#' A language model reads the whole manuscript and returns every place that
#' belongs on a study-site map, with its role, page and supporting sentence.
#' Coordinates are kept only when the manuscript states them; the model is told
#' never to estimate a position.
#'
#' @param path Path to the manuscript: a PDF (read page by page) or a text file.
#' @param provider `"anthropic"`, `"openai"` or `"gemini"`.
#' @param model Model name, or `NULL` for the provider's default.
#' @return A data frame with one row per place. Attributes `study` (countries,
#'   one-sentence summary, stated extent) and `provider`.
#' @seealso [pubmap()], which runs the whole pipeline.
#' @export
extract_places <- function(path, provider = "anthropic", model = NULL) {
  txt  <- manuscript_text(path)
  chat <- pubmaps_chat(provider, model)
  prompt <- paste0("MANUSCRIPT (", basename(path), "):\n\n", txt)
  res <- if ("chat_structured" %in% names(chat)) {
    chat$chat_structured(prompt, type = manuscript_type(), convert = FALSE)
  } else {
    chat$extract_data(prompt, type = manuscript_type(), convert = FALSE)
  }
  places <- places_to_df(res$places)
  places$coord_source <- ifelse(!is.na(places$stated_lat) &
                                !is.na(places$stated_lon), "text", NA)
  attr(places, "study") <- res[c("study_countries", "study_area_summary",
                                 "stated_extent")]
  attr(places, "provider") <- paste(provider, if (is.null(model)) "default" else model)
  places
}
