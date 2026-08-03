# reader_assembler.R
# -----------------------------------------------------------------------------
# The reader / assembler — the second half of "capture once, project two views".
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
# The assembler core (below) is tool-free and testable with the decoded strings.
# The decode + EXIF adapters wrap external tools (ZBar's `zbarimg`; `exiftool`)
# and are stubbed pending a real field photo.
#
# Encoding convention (settled): every card's QR carries self-describing
# "Field: value" text, INCLUDING the identity card ("Number: KWB 1324",
# "Collectors: K.W. Bridges"), so the reader parses all cards uniformly.
#
# Needs site_extract.R loaded for the derive step (site_extract, site_substrate).
# -----------------------------------------------------------------------------

`%||%` <- function(a, b) if (is.null(a) || length(a) == 0 || (length(a) == 1 && is.na(a))) b else a

# --- parse the self-describing "Field: value" cards --------------------------
parse_cards <- function(codes) {
  codes <- codes[!is.na(codes) & nzchar(trimws(codes))]
  m <- regmatches(codes, regexec("^\\s*([^:]+?)\\s*:\\s*(.+)$", codes))
  fields <- list()
  for (x in m) if (length(x) == 3 && nzchar(trimws(x[3]))) fields[[trimws(x[2])]] <- trimws(x[3])
  fields
}

# --- assemble ONE record from cards + coordinate + time ----------------------
# derive = TRUE pulls the fixed variables from the coordinate (needs
# site_extract.R loaded). All the "hard" spatial context comes from here, not
# from the collector's hand.
assemble_record <- function(codes, lat, lon, datetime = NA, photo = NA,
                            place = "", derive = TRUE) {
  obs <- parse_cards(codes)
  number     <- obs[["Number"]] %||% obs[["Collection"]] %||% NA
  # The deck CSV writes the collector card as "Collected by: ...", which is the
  # right wording for a label but is NOT what this function originally looked
  # for ("Collectors" / "Collector"). Found 2026-07-28 by running the assembler
  # on a real field photo: the label printed "Collector: NA" while the collector
  # name sat in `observed`. Accept every spelling the decks might carry rather
  # than reprint cards to match the code.
  collector_keys <- c("Collectors", "Collector", "Collected by", "Collected By")
  collectors <- NA
  for (.k in collector_keys)
    if (is.na(collectors)) collectors <- obs[[.k]] %||% NA

  # DETERMINED BY is a first-class field, not an observation (Kim, 2026-07-28).
  # An observation card records what the collector SAW; the determination records
  # WHO ASSERTED the identification, and herbarium practice keeps them apart --
  # a determination carries an authority and can be revised by a later worker
  # without touching anything that was observed in the field.
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
  if (isTRUE(derive) && exists("site_extract")) {
    se <- tryCatch(site_extract(place, lat, lon), error = function(e) NULL)
    if (!is.null(se)) rec$terrain <- se$values[c("elevation_m", "slope_deg", "aspect_compass", "flow_dir")]
    if (exists("site_substrate")) {
      sub <- tryCatch(site_substrate(lat, lon), error = function(e) NULL)
      if (!is.null(sub)) { rec$geology <- sub$geology; rec$soil <- sub$soil }
    }
    if (identical(place, "") && exists("site_place")) {   # free reverse-geocode
      p <- tryCatch(site_place(lat, lon), error = function(e) NA_character_)
      if (!is.na(p) && nzchar(p)) rec$place <- p
    }
  }
  rec
}

# --- projection 1: the herbarium label (one specimen) ------------------------
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

# --- projection 2: one field-log row (one trip) ------------------------------
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
  as.data.frame(c(base, rec$observed), stringsAsFactors = FALSE)
}

# --- convenience: cards + coordinate -> record + both views ------------------
read_capture <- function(codes, lat, lon, datetime = NA, photo = NA, place = "", derive = TRUE) {
  rec <- assemble_record(codes, lat, lon, datetime, photo, place, derive)
  list(record = rec, label = make_label(rec), log_row = make_log_row(rec))
}

# --- input adapters ----------------------------------------------------------

# decode_qr(): every QR string in one photo. Real field photos (rotated codes,
# busy backgrounds) defeat any single decoder, so we UNION pyzbar (ZBar) over a
# few preprocessings with OpenCV's multi-detector. Needs reticulate + the python
# modules cv2 and pyzbar  (reticulate::py_install(c("opencv-python","pyzbar"))).
decode_qr <- function(photo) {
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

# read_exif(): GPS + datetime from the phone photo, via exiftool.
read_exif <- function(photo) {
  ex <- exiftoolr::exif_read(photo, tags = c("GPSLatitude", "GPSLongitude", "DateTimeOriginal"))
  list(lat = as.numeric(ex$GPSLatitude %||% NA),
       lon = as.numeric(ex$GPSLongitude %||% NA),
       datetime = ex$DateTimeOriginal %||% NA)
}

# --- full pipeline: photo -> decode + EXIF -> assemble -> two products --------
read_photo <- function(photo, place = "", derive = TRUE) {
  codes <- decode_qr(photo)
  ex    <- read_exif(photo)
  read_capture(codes, ex$lat, ex$lon, ex$datetime,
               photo = basename(photo), place = place, derive = derive)
}

# --- example -----------------------------------------------------------------
# source("site_extract.R"); source("reader_assembler.R")
# codes <- c("Number: KWB 1324", "Collectors: K.W. Bridges",
#            "Life Form: Tree", "Phenology: Flowering", "Flower Color: Red")
# cap <- read_capture(codes, 19.435731, -155.336334, "2026-07-01 10:15",
#                     photo = "IMG_0001.jpg", place = "Kilauea, Hawaii Island")
# cat(cap$label)
# str(cap$log_row)
