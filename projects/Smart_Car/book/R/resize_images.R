## resize_images.R -- web-size the book photographs.
##
## BUILD STEP, not a source edit. It rewrites images IN PLACE in whatever
## directory it is pointed at, so point it at the SCRATCH BUILD TREE
## (C:/temp/Smart_Car_book_<date>/images), never at the project on G:.
## The full-resolution originals stay in the project untouched.
##
## Re-runnable: files already at or below long_edge are SKIPPED rather than
## re-encoded, so running it twice does not degrade anything.
##
##   source("R/resize_images.R")
##   r <- resize_book_images("C:/temp/Smart_Car_book_2026-09-03/images")

resize_book_images <- function(dir, long_edge = 1800, quality = 88, dry_run = FALSE) {

  library(magick)

  files <- list.files(dir, recursive = TRUE, full.names = TRUE,
                      pattern = "\\.(jpg|jpeg|JPG|JPEG)$")

  rows <- vector("list", length(files))

  for (k in seq_along(files)) {
    p       <- files[k]
    before  <- file.info(p)$size
    a       <- image_info(image_read(p))
    longest <- max(a$width, a$height)

    ## already small enough: leave the bytes exactly as they are
    if (longest <= long_edge) {
      rows[[k]] <- data.frame(file = basename(p), w = a$width, h = a$height,
                              beforeMB = round(before / 1e6, 3),
                              afterMB  = round(before / 1e6, 3),
                              action   = "skipped", stringsAsFactors = FALSE)
      next
    }

    if (!dry_run) {
      ## the ">" suffix means shrink-only, aspect ratio preserved
      out <- image_resize(image_read(p), sprintf("%dx%d>", long_edge, long_edge))
      image_write(out, p, quality = quality)
    }

    after <- if (dry_run) before else file.info(p)$size
    rows[[k]] <- data.frame(file = basename(p), w = a$width, h = a$height,
                            beforeMB = round(before / 1e6, 3),
                            afterMB  = round(after / 1e6, 3),
                            action   = "resized", stringsAsFactors = FALSE)
  }

  report <- do.call(rbind, rows)

  ## verify by READING THE FILES BACK, not by trusting the writes
  check <- vapply(files, function(p) {
    a <- image_info(image_read(p)); max(a$width, a$height) }, numeric(1))

  list(report      = report,
       n_resized   = sum(report$action == "resized"),
       n_skipped   = sum(report$action == "skipped"),
       beforeMB    = round(sum(report$beforeMB), 1),
       afterMB     = round(sum(report$afterMB), 1),
       max_long_px = max(check),
       long_edge   = long_edge,
       quality     = quality)
}
