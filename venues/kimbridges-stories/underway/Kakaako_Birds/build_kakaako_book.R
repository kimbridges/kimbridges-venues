# build_kakaako_book.R
# ---------------------------------------------------------------------------
# One-call build for the Kaka`ako Birds photo book.
#
# WORKFLOW: edit the chapter files in Stories/*.md (the source of truth),
# then run build_kakaako_book(). The build ALWAYS re-assembles the manuscript
# from the current Stories/*.md first, so your latest edits are always included
# — there is no separate "re-assemble" step to remember.
#
# Book metadata (title, cover file, output name, spread suffix) is read from
# the project config.yaml, so edits there are honored.
#
# Steps:
#   1. Re-assemble Kakaako_Birds_manuscript.md from Stories/*.md
#      (ordered by each file's `order:` field; YAML front-matter and [V:] tags
#      stripped; the "Interactive map" footer removed).
#   2. Copy manuscript + cover + Images to a LOCAL temp folder (fast disk).
#   3. Render chapter PDFs (markdown_to_chapters) at the chosen font size.
#   4. Assemble cover + text + Event-matched photos (build_book).
#   5. Copy the finished PDF back into the book folder.
#
# Requires the (rebuilt) photobookr package installed.
# ---------------------------------------------------------------------------

library(photobookr)

`%||%` <- function(a, b) if (is.null(a) || length(a) == 0 || (length(a) == 1 && is.na(a))) b else a

## Re-assemble a single manuscript .md from a folder of per-chapter .md files.
assemble_manuscript <- function(stories_dir, out_md) {
  files <- list.files(stories_dir, pattern = "\\.md$", full.names = TRUE)
  parse_one <- function(f) {
    L <- readLines(f, encoding = "UTF-8", warn = FALSE)
    ord <- NA_integer_; bstart <- 1
    fm <- which(L == "---")
    if (length(fm) >= 2 && fm[1] == 1) {
      y  <- L[(fm[1] + 1):(fm[2] - 1)]
      ov <- sub("^order:\\s*", "", y[grepl("^order:", y)])
      if (length(ov)) ord <- as.integer(ov[1])
      bstart <- fm[2] + 1
    }
    body <- paste(L[bstart:length(L)], collapse = "\n")
    body <- gsub("\\s*\\[V:[^]]*\\]", "", body, perl = TRUE)                       # strip [V:] tags
    body <- gsub("(?s)<!--.*?-->", "", body, perl = TRUE)                          # strip HTML comments
    body <- gsub("\\n---\\n\\s*\\*Interactive map:[^\\n]*\\*\\s*", "\n", body, perl = TRUE) # drop map footer
    body <- trimws(gsub("\\n{3,}", "\n\n", body, perl = TRUE))
    list(order = ord, body = body, file = basename(f))
  }
  docs <- lapply(files, parse_one)
  ords <- sapply(docs, function(d) d$order)
  if (any(is.na(ords))) warning("Files missing an `order:` field: ",
                                paste(sapply(docs[is.na(ords)], `[[`, "file"), collapse = ", "))
  docs <- docs[order(ords)]
  manuscript <- paste(sapply(docs, function(d) d$body), collapse = "\n\n\n")
  con <- file(out_md, open = "w", encoding = "UTF-8"); writeLines(manuscript, con); close(con)
  invisible(list(path = out_md, n = length(docs)))
}

## Full build.
build_kakaako_book <- function(
    book_dir  = "G:/My Drive/kimbridges-stories/underway/Kakaako_Birds",
    body_size = 17) {                       # 10/11/12/14/17/20 supported

  stories <- file.path(book_dir, "Stories")
  manu    <- file.path(book_dir, "Kakaako_Birds_manuscript.md")

  ## read project metadata
  pcfg        <- yaml::read_yaml(file.path(book_dir, "config.yaml"))
  book_name   <- pcfg$book_name      %||% "The Birds Around Kaka`ako"
  output_name <- pcfg$output_pdf     %||% "Kakaako_Birds_Book.pdf"
  cover_name  <- pcfg$cover_file     %||% "Kakaako_Birds_cover.pdf"
  spread_sfx  <- pcfg$spread$suffix  %||% "_2W"

  ## 1. re-assemble manuscript from the current Stories/*.md
  a <- assemble_manuscript(stories, manu)
  message("Re-assembled manuscript from ", a$n, " files in Stories/.")

  ## 2. stage inputs on a fast local disk
  work <- file.path(tempdir(), paste0("kb_build_", as.integer(Sys.time())))
  dir.create(file.path(work, "Images"),   recursive = TRUE, showWarnings = FALSE)
  dir.create(file.path(work, "chapters"), showWarnings = FALSE)
  dir.create(file.path(work, "kml"),      showWarnings = FALSE)
  file.copy(manu, file.path(work, "manuscript.md"), overwrite = TRUE)
  file.copy(file.path(book_dir, cover_name), file.path(work, "cover.pdf"), overwrite = TRUE)
  imgs <- list.files(file.path(book_dir, "Images"),
                     pattern = "\\.(jpg|JPG|jpeg|JPEG|png|PNG)$", full.names = TRUE)
  imgs <- imgs[!dir.exists(imgs)]
  file.copy(imgs, file.path(work, "Images"), overwrite = TRUE)

  owd <- setwd(work); on.exit(setwd(owd), add = TRUE)

  ## 3. render chapters
  markdown_to_chapters("manuscript.md", output_folder = "chapters",
                       clear_folder = TRUE, body_size = body_size)

  ## 4. assemble cover + text + Event-matched photos
  cfg <- list(book_name = book_name, cover_file = "cover.pdf",
              folders = list(stories = "chapters", images = "Images", kml = "kml"),
              output_pdf = output_name,
              spread = list(suffix = spread_sfx),
              verification = list(enabled = FALSE))
  yaml::write_yaml(cfg, "config.yaml")
  build_book("config.yaml", verification = FALSE)

  ## 5. copy result back to the book folder
  out  <- file.path(work, output_name)
  dest <- file.path(book_dir, output_name)
  if (file.exists(out)) {
    file.copy(out, dest, overwrite = TRUE)
    message("Done: ", dest, "  (", pdftools::pdf_info(out)$pages, " pages, ",
            round(file.info(out)$size / 1024^2, 1), " MB)")
  } else {
    stop("Build did not produce ", output_name)
  }
  invisible(dest)
}

# To build:  source("build_kakaako_book.R"); build_kakaako_book()
