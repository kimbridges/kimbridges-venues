# reader_assembler.R
# -----------------------------------------------------------------------------
# The reader / assembler -- the second half of "capture once, project two views".
#
# From a field photo's decoded QR cards + its EXIF (GPS + time), assemble ONE
# structured record, then project TWO views that cannot disagree (they are views
# of the same record): a herbarium LABEL (per specimen) and a field-LOG row
# (per trip).
#
#   photo --[decode]-- QR card strings --.
#         --[EXIF]---- lat, lon, datetime -+--> assemble_record() --> record
#                                                    |--> make_label()   (one specimen)
#                                                    '--> make_log_row() (one trip row)
#
# The assembler core (parse/assemble/label/log) is tool-free and dependency-free.
# The decode + EXIF adapters wrap external tools (reticulate + OpenCV/pyzbar;
# exiftool via exiftoolr) and check for their dependencies at call time.
#
# Encoding convention (settled): every card's QR carries self-describing
# "Field: value" text, INCLUDING the identity card ("Number: KWB 1324",
# "Collectors: K.W. Bridges"), so the reader parses all cards uniformly.
# -----------------------------------------------------------------------------

`%||%` <- function(a, b) if (is.null(a) || length(a) == 0 || (length(a) == 1 && is.na(a))) b else a

#' Parse self-describing "Field: value" cards
#'
#' Split decoded QR strings of the form `"Field: value"` into a named list. Blank
#' and malformed entries are dropped; leading/trailing whitespace is trimmed.
#'
#' @param codes Character vector of decoded QR strings.
#' @return A named list mapping field names to values.
#' @examples
#' parse_cards(c("Life Form: Tree", "Phenology: Flowering"))
#' @export
parse_cards <- function(codes) {
  codes <- codes[!is.na(codes) & nzchar(trimws(codes))]
  m <- regmatches(codes, regexec("^\\s*([^:]+?)\\s*:\\s*(.+)$", codes))
  fields <- list()
  for (x in m) if (length(x) == 3 && nzchar(trimws(x[3]))) fields[[trimws(x[2])]] <- trimws(x[3])
  fields
}

#' Assemble one record from cards, coordinate, and time
#'
#' Build a single structured record from decoded cards plus the photo's
#' coordinate and time. When `derive = TRUE`, the fixed spatial variables (terrain,
#' substrate, place) are pulled from the coordinate via [site_extract()],
#' [site_substrate()], and [site_place()] -- so the "hard" spatial context comes
#' from the coordinate, not the collector's hand. Derivation is wrapped so a
#' missing dependency or a failed network call simply omits those fields.
#'
#' @param codes Character vector of decoded QR strings.
#' @param lat,lon Latitude and longitude in decimal degrees (WGS84).
#' @param datetime Collection date-time (character or `POSIXct`); optional.
#' @param photo Photo identifier (e.g. file name); optional.
#' @param place Locality string; if `""` and `derive = TRUE`, filled by reverse geocode.
#' @param derive Logical; derive fixed site variables from the coordinate.
#' Identity fields are lifted out of the cards and kept separate from
#' observations. The collector is read from any of `"Collectors"`, `"Collector"`,
#' `"Collected by"` or `"Collected By"`; the determiner from `"Determined by"`,
#' `"Determined By"`, `"Determiner"`, `"Det by"` or `"Det"`. `determined_by` is a
#' first-class field, not an observation: an observation card records what the
#' collector SAW, while a determination records WHO ASSERTED the identification,
#' carries an authority, and can be revised later without disturbing anything
#' observed in the field.
#'
#' @return A named list record: identity (`collection_number`, `collectors`,
#'   `determined_by`), `observed` fields, coordinate/time, and (when derived)
#'   `terrain`, `geology`, `soil`, and `place`.
#' @export
assemble_record <- function(codes, lat, lon, datetime = NA, photo = NA,
                            place = "", derive = TRUE) {
  obs <- parse_cards(codes)
  number     <- obs[["Number"]] %||% obs[["Collection"]] %||% NA

  # The deck CSV writes the collector card as "Collected by: ...", which is the
  # right wording for a label but is not what this function originally looked
  # for. Found 2026-07-28 by running the assembler on a real field photo: the
  # label printed "Collector: NA" while the name sat in `observed`. Accept every
  # spelling a deck might carry rather than reprint cards to match the code.
  collector_keys <- c("Collectors", "Collector", "Collected by", "Collected By")
  collectors <- NA
  for (.k in collector_keys)
    if (is.na(collectors)) collectors <- obs[[.k]] %||% NA

  # DETERMINED BY is a first-class field, not an observation. An observation card
  # records what the collector SAW; the determination records WHO ASSERTED the
  # identification. Herbarium practice keeps them apart because a determination
  # carries an authority and can be revised by a later worker without disturbing
  # anything observed in the field.
  determiner_keys <- c("Determined by", "Determined By", "Determiner", "Det by", "Det")
  determined_by <- NA
  for (.k in determiner_keys)
    if (is.na(determined_by)) determined_by <- obs[[.k]] %||% NA

  id_keys    <- c("Number", "Collection", collector_keys, determiner_keys)
  # identity tag written as a collector-code card, e.g. "KWB: 1239"
  if (is.na(number)) {
    cc <- names(obs)[grepl("^[A-Z]{2,5}$", names(obs))]
    if (length(cc)) {
      number     <- paste(cc[1], obs[[cc[1]]])
      collectors <- collectors %||% cc[1]
      id_keys    <- c(id_keys, cc[1])
    }
  }
  rec <- list(
    collection_number = number,
    collectors        = collectors,
    determined_by     = determined_by,
    observed          = obs[setdiff(names(obs), id_keys)],
    latitude = lat, longitude = lon, datetime = datetime,
    photo = photo, place = place)
  if (isTRUE(derive)) {
    se <- tryCatch(site_extract(place, lat, lon), error = function(e) NULL)
    if (!is.null(se)) rec$terrain <- se$values[c("elevation_m", "slope_deg", "aspect_compass", "flow_dir")]
    sub <- tryCatch(site_substrate(lat, lon), error = function(e) NULL)
    if (!is.null(sub)) { rec$geology <- sub$geology; rec$soil <- sub$soil }
    if (identical(place, "")) {                       # free reverse-geocode
      p <- tryCatch(site_place(lat, lon), error = function(e) NA_character_)
      if (!is.na(p) && nzchar(p)) rec$place <- p
    }
  }
  rec
}

#' Project a record to a herbarium label (one specimen)
#'
#' A `Det.:` line is appended when the record carries a determiner, and omitted
#' when it does not.
#'
#' @param rec A record from [assemble_record()].
#' @return A single character string: the multi-line label text.
#' @export
make_label <- function(rec) {
  soil <- if (!is.null(rec$soil)) (rec$soil$order %||% rec$soil$component) else NULL
  ln <- c(
    sprintf("Collector: %s    No. %s", rec$collectors, rec$collection_number),
    if (nzchar(rec$place)) sprintf("Locality: %s", rec$place),
    sprintf("Coordinates: %.5f, %.5f", rec$latitude, rec$longitude),
    if (!is.null(rec$terrain))
      sprintf("Elevation %s m; slope %s deg; aspect %s",
              rec$terrain$elevation_m, rec$terrain$slope_deg, rec$terrain$aspect_compass),
    if (!is.null(rec$geology))
      sprintf("Substrate: %s%s", rec$geology$lithology,
              if (!is.null(soil)) sprintf("; soil %s", soil) else ""),
    if (length(rec$observed))
      paste(names(rec$observed), unlist(rec$observed), sep = ": ", collapse = "; "),
    sprintf("Date: %s", rec$datetime),
    if (!is.na(rec$determined_by %||% NA)) sprintf("Det.: %s", rec$determined_by))
  paste(ln, collapse = "\n")
}

#' Project a record to one field-log row (one trip)
#'
#' Produce a one-row data frame for a specimen. Fixed columns (identity,
#' coordinate, derived terrain/substrate) are always present; the specimen's
#' observed fields are appended as their own columns, with their names preserved
#' verbatim (`check.names = FALSE`), so `"Life Form"` stays `"Life Form"`.
#'
#' Because observed fields vary between specimens, the rows of a trip are ragged.
#' Combine them into one log with [dplyr::bind_rows()] (or another NA-filling
#' binder), which aligns columns by name and fills gaps with `NA`; a plain
#' `rbind()` will not work across specimens with different observed fields.
#'
#' @param rec A record from [assemble_record()].
#' @return A one-row `data.frame`.
#' @export
make_log_row <- function(rec) {
  base <- list(
    number = rec$collection_number, collectors = rec$collectors,
    determined_by = rec$determined_by %||% NA,
    lat = rec$latitude, lon = rec$longitude, datetime = as.character(rec$datetime),
    place = rec$place,
    elevation_m = rec$terrain$elevation_m %||% NA,
    slope_deg   = rec$terrain$slope_deg %||% NA,
    aspect      = rec$terrain$aspect_compass %||% NA,
    bedrock     = rec$geology$lithology %||% NA,
    soil        = (if (!is.null(rec$soil)) rec$soil$order %||% rec$soil$component else NA) %||% NA,
    photo       = rec$photo)
  as.data.frame(c(base, rec$observed), stringsAsFactors = FALSE, check.names = FALSE)
}

#' Cards + coordinate -> record and both views
#'
#' Convenience wrapper: [assemble_record()] then both projections.
#'
#' @inheritParams assemble_record
#' @return A list with `record`, `label`, and `log_row`.
#' @examples
#' cap <- read_capture(c("Number: KWB 1", "Collectors: X", "Life Form: Tree"),
#'                     19.4, -155.3, "2026-01-01", derive = FALSE)
#' cat(cap$label)
#' @export
read_capture <- function(codes, lat, lon, datetime = NA, photo = NA, place = "", derive = TRUE) {
  rec <- assemble_record(codes, lat, lon, datetime, photo, place, derive)
  list(record = rec, label = make_label(rec), log_row = make_log_row(rec))
}

# --- input adapters ----------------------------------------------------------

#' Decode every QR code in one photo
#'
#' Real field photos (rotated codes, busy backgrounds) defeat any single decoder,
#' so this unions `pyzbar` (ZBar) over a few preprocessings with OpenCV's
#' multi-detector. Requires `reticulate` plus the Python modules `cv2`
#' (opencv-python) and `pyzbar`.
#'
#' @param photo Path to an image file.
#' @return A sorted character vector of the decoded QR strings.
#' @export
decode_qr <- function(photo) {
  if (!requireNamespace("reticulate", quietly = TRUE))
    stop("decode_qr() needs the 'reticulate' package plus Python 'opencv-python' and 'pyzbar'.")
  reticulate::py_run_string(sprintf("
from pyzbar.pyzbar import decode as _zdec
import cv2
_img  = cv2.imread(r'%s')
_gray = cv2.cvtColor(_img, cv2.COLOR_BGR2GRAY)
_found = set()
def _addz(im):
    for d in _zdec(im): _found.add(d.data.decode('utf-8'))
_addz(_gray)
_, _o = cv2.threshold(_gray, 0, 255, cv2.THRESH_BINARY+cv2.THRESH_OTSU); _addz(_o)
_addz(cv2.adaptiveThreshold(_gray,255,cv2.ADAPTIVE_THRESH_MEAN_C,cv2.THRESH_BINARY,51,10))
_addz(cv2.resize(_gray,None,fx=1.5,fy=1.5,interpolation=cv2.INTER_CUBIC))
_ok,_info,_pts,_ = cv2.QRCodeDetector().detectAndDecodeMulti(_img)
for _c in _info:
    if _c: _found.add(_c)
qr_result = sorted(_found)
", gsub("\\\\", "/", photo)))
  unlist(reticulate::py$qr_result)
}

#' GPS and datetime from a photo's EXIF
#'
#' Read latitude, longitude, and original date-time from a photo via `exiftoolr`
#' (which wraps the external `exiftool`).
#'
#' @param photo Path to an image file.
#' @return A list with `lat`, `lon`, and `datetime`.
#' @export
read_exif <- function(photo) {
  if (!requireNamespace("exiftoolr", quietly = TRUE))
    stop("read_exif() needs the 'exiftoolr' package (and the external 'exiftool').")
  ex <- exiftoolr::exif_read(photo, tags = c("GPSLatitude", "GPSLongitude", "DateTimeOriginal"))
  list(lat = as.numeric(ex$GPSLatitude %||% NA),
       lon = as.numeric(ex$GPSLongitude %||% NA),
       datetime = ex$DateTimeOriginal %||% NA)
}

#' Full pipeline: photo -> decode + EXIF -> record + both products
#'
#' @param photo Path to a field photo of QR cards.
#' @param place Locality string; if `""` and `derive = TRUE`, filled by reverse geocode.
#' @param derive Logical; derive fixed site variables from the coordinate.
#' @return A list with `record`, `label`, and `log_row` (see [read_capture()]).
#' @export
read_photo <- function(photo, place = "", derive = TRUE) {
  codes <- decode_qr(photo)
  ex    <- read_exif(photo)
  read_capture(codes, ex$lat, ex$lon, ex$datetime,
               photo = basename(photo), place = place, derive = derive)
}
