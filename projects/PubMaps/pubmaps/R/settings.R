# ==============================================================================
# settings.R -- where PubMaps keeps its data. The code lives in the package; the
# gazetteer cache and the review folders live wherever the editor says.
# Each setting: an R option, else an environment variable (.Renviron), else a default.
# ==============================================================================

setting <- function(option, env, default) {
  v <- getOption(option)
  if (is.null(v) || !nzchar(v)) v <- Sys.getenv(env)
  if (!nzchar(v)) v <- default
  v
}

#' Where PubMaps keeps its data
#'
#' `pubmaps_cache_dir()` is the folder of cached gazetteer answers and park and
#' district outlines. Repeat lookups come from here, so a second run of a
#' manuscript is quick. `pubmaps_review_dir()` is where [pubmap()] puts review
#' folders when no `dir` is given.
#'
#' Each is set, in order of precedence, by an R option, an environment variable
#' (put it in `.Renviron`), or a default:
#'
#' | Setting | Option | Environment variable | Default |
#' |---|---|---|---|
#' | cache | `pubmaps.cache` | `PUBMAPS_CACHE` | `tools::R_user_dir("pubmaps", "cache")` |
#' | review folders | `pubmaps.review` | `PUBMAPS_REVIEW` | `review` in the working directory |
#'
#' @return A folder path.
#' @examples
#' pubmaps_cache_dir()
#' pubmaps_review_dir()
#' @export
pubmaps_cache_dir <- function()
  setting("pubmaps.cache", "PUBMAPS_CACHE", tools::R_user_dir("pubmaps", "cache"))

#' @rdname pubmaps_cache_dir
#' @export
pubmaps_review_dir <- function()
  setting("pubmaps.review", "PUBMAPS_REVIEW", "review")
