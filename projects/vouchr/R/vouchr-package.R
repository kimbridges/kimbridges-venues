#' vouchr: Field-Capture Toolkit for Herbarium Voucher Labels and Field Logs
#'
#' One field photograph of QR-coded cards becomes two co-equal products with no
#' transcription -- a herbarium specimen label and a field-log row. Category data
#' is captured on modular QR-card decks; fixed environmental variables are derived
#' from the photograph's GPS coordinate using open, keyless data sources; and the
#' decks a discipline needs can be discovered from aggregated herbarium records.
#'
#' The package is organised as three pillars plus an assembler:
#' \describe{
#'   \item{Capture}{[make_qr_cards()] builds printable QR-card decks and
#'     [make_number_cards()] builds collection-number identity cards, both laid
#'     out at true [avery_5371] positions; [qr_calibration_sheet()] proves the
#'     alignment on plain paper first and [validate_qr_engine()] refuses to write
#'     a PDF unless the codes are structurally valid.}
#'   \item{Derive}{[site_extract()], [site_substrate()], [site_place()] compute
#'     fixed site variables from a coordinate.}
#'   \item{Discover}{[discover_decks()] finds deck archetypes from herbarium records.}
#'   \item{Assemble}{[read_capture()] / [read_photo()] turn cards + coordinate + time
#'     into a record, then project a label and a log row.}
#' }
#'
#' Card making needs only `qrcode` and `grid`. The Derive, Discover, and
#' photo-reading features rely on packages listed under `Suggests`; each function
#' checks for its dependencies at call time.
#'
#' @keywords internal
#' @importFrom qrcode qr_code
#' @importFrom grid viewport pushViewport popViewport grid.layout unit gpar
#' @importFrom grid grid.raster grid.text grid.rect grid.circle grid.segments
#' @importFrom grid grid.newpage convertWidth grobWidth textGrob
#' @importFrom grDevices pdf dev.off as.raster grey
#' @importFrom stats hclust dist cutree aggregate sd setNames
#' @importFrom utils read.csv write.csv
"_PACKAGE"
