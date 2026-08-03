#' Add a BB-style color overlay to a gt table
#'
#' Works for ordinary BB tables and tables that include a metadata row, because
#' it colors only values that match the BB scale (0..max_val). Everything else
#' (text, units, metadata) is left white by default.
#'
#' @param gt_tbl A gt table (typically output of bb_gt() or bb_gt_with_site_attribute()).
#' @param max_val Integer. Maximum BB cover/abundance value (default 7).
#' @param low,high Colors for the ramp.
#' @param overflow_color Color used for out-of-range numeric values; default "white" (safe).
#'        Set to "red" for diagnostic mode.
#' @return A gt table with color applied.
#' @export
bb_gt_color <- function(
    gt_tbl,
    max_val = 7,
    low = "white",
    high = "honeydew4",
    overflow_color = "white"
) {
  if (!requireNamespace("gt", quietly = TRUE)) stop("Package 'gt' is required.")
  if (!requireNamespace("dplyr", quietly = TRUE)) stop("Package 'dplyr' is required.")
  
  ## Build mapping for 0..max_val
  pal <- grDevices::colorRampPalette(c(low, high))(max_val + 1)
  map <- stats::setNames(pal, as.character(0:max_val))
  
  gt::data_color(
    gt_tbl,
    columns = gt::everything(),  ## user can restrict later if desired
    fn = function(x) {
      x_chr <- as.character(x)
      
      ## Normalize blanks
      x_chr[is.na(x_chr)] <- "0"
      x_chr[x_chr == ""] <- "0"
      x_chr[x_chr == " "] <- "0"
      
      ## Base mapping: only exact tokens 0..max_val get colored
      out <- map[x_chr]
      out[is.na(out)] <- map[["0"]]
      
      ## Optional diagnostic: flag out-of-range numeric tokens
      suppressWarnings(x_num <- as.numeric(x_chr))
      over <- !is.na(x_num) & (x_num < 0 | x_num > max_val)
      out[over] <- overflow_color
      
      out
    }
  )
}
