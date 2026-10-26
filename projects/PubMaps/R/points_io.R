# ==============================================================================
# points_io.R -- PubMaps step 4 (part): the editor's points table
# points.csv is the one file the editor touches. Columns the editor may change:
#   include  -- blank = let PubMaps decide | yes = always draw | no = never draw |
#               name = print the name only, no symbol (e.g. a state or region)
#   label    -- text printed on the map (defaults to the manuscript's name)
#   label_pos -- where the NAME goes, without moving the place (2026-10-25):
#                blank = automatic | N NE E SE S SW W NW = that side of the symbol |
#                none = no name printed
#   label_lon, label_lat -- put the NAME exactly here (decimal degrees); the place
#                stays where it is (a thin leader line joins name and symbol)
#   lon, lat -- decimal degrees; a typed or changed value becomes source "editor"
#   note     -- free text, kept but not used
# Everything else is information. The original is kept in points_original.rds so an
# edit can be recognised as an edit.
# ==============================================================================

EDITOR_COLS <- c("id", "include", "label", "label_pos", "label_lon", "label_lat", "name", "role", "lon", "lat",
                 "coord_source", "match", "status", "gaz_name", "gaz_type",
                 "page", "evidence", "note")

write_points_csv <- function(points, dir, plan = NULL) {
  p <- points
  p$id <- seq_len(nrow(p))
  if (is.null(p$include)) p$include <- ""
  if (is.null(p$label)) p$label <- p$name
  if (is.null(p$note)) p$note <- ""
  if (is.null(p$label_pos)) p$label_pos <- ""
  if (is.null(p$label_lon)) p$label_lon <- NA_real_
  if (is.null(p$label_lat)) p$label_lat <- NA_real_
  p$status <- if (!is.null(plan)) {
    d <- plan$points
    ifelse(d$drawn, "on map", d$reason)
  } else ""
  out <- p[, intersect(EDITOR_COLS, names(p))]
  utils::write.csv(out, file.path(dir, "points.csv"), row.names = FALSE, na = "",
                   fileEncoding = "UTF-8")
  saveRDS(points, file.path(dir, "points_original.rds"))
  invisible(file.path(dir, "points.csv"))
}

read_points_csv <- function(dir) {
  orig <- readRDS(file.path(dir, "points_original.rds"))
  ed <- utils::read.csv(file.path(dir, "points.csv"), stringsAsFactors = FALSE,
                        na.strings = c("", "NA"), fileEncoding = "UTF-8")
  # added rows (editor adds a place): id blank -> new place, role default study_site
  new <- is.na(ed$id)
  if (any(new)) {
    add <- orig[rep(1, sum(new)), ]; add[] <- NA
    add$name <- ifelse(is.na(ed$name[new]), ed$label[new], ed$name[new])
    add$role <- ifelse(is.na(ed$role[new]), "study_site", ed$role[new])
    add$flag <- ""; add$match <- "none"; add$coord_source <- "none"
    orig <- rbind(orig, add)
    ed$id[new] <- nrow(orig) - rev(seq_len(sum(new))) + 1
  }
  p <- orig
  i <- ed$id
  p$include <- ""; p$label <- p$name; p$note <- ""
  p$include[i] <- tolower(trimws(ifelse(is.na(ed$include), "", ed$include)))
  p$label[i]   <- ifelse(is.na(ed$label), p$name[i], ed$label)
  p$note[i]    <- ifelse(is.na(ed$note), "", ed$note)
  p$label_pos <- ""; p$label_lon <- NA_real_; p$label_lat <- NA_real_
  if ("label_pos" %in% names(ed))
    p$label_pos[i] <- toupper(trimws(ifelse(is.na(ed$label_pos), "", ed$label_pos)))
  if (all(c("label_lon", "label_lat") %in% names(ed))) {
    p$label_lon[i] <- suppressWarnings(as.numeric(ed$label_lon))
    p$label_lat[i] <- suppressWarnings(as.numeric(ed$label_lat))
  }
  if ("role" %in% names(ed)) p$role[i] <- ifelse(is.na(ed$role), p$role[i], ed$role)
  changed <- !is.na(ed$lon) & !is.na(ed$lat) &
             (is.na(p$lon[i]) | is.na(p$lat[i]) |
              abs(ed$lon - ifelse(is.na(p$lon[i]), Inf, p$lon[i])) > 1e-6 |
              abs(ed$lat - ifelse(is.na(p$lat[i]), Inf, p$lat[i])) > 1e-6)
  j <- i[changed]
  p$lon[j] <- ed$lon[changed]; p$lat[j] <- ed$lat[changed]
  p$coord_source[j] <- "editor"; p$match[j] <- "editor"
  p$flag[j] <- ""
  cleared <- is.na(ed$lon) & !is.na(p$lon[i])        # editor deleted a position
  k <- i[cleared]
  p$lon[k] <- NA; p$lat[k] <- NA; p$coord_source[k] <- "none"; p$match[k] <- "none"
  attributes(p)[c("study", "anchor", "far_km")] <- attributes(orig)[c("study", "anchor", "far_km")]
  p
}
