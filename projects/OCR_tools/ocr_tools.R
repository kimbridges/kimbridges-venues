# =====================================================================
# ocr_tools.R  —  olmOCR (vision-language OCR) via DeepInfra, from R
# ---------------------------------------------------------------------
# Kim Bridges & Claude (Anthropic), October 2026.
# Descends from jones_ocr_pipeline.py (Jones refuge reports, April 2026),
# rewritten in R and revised after the Diamond "Ethnobiologist's Dilemma"
# test (Oct 2026), where whole-page olmOCR invented numbers and looped on
# curved book pages, while half-page crops came back exact.
#
# Quick start:
#   source("G:/My Drive/Projects/OCR_tools/ocr_tools.R")
#   log <- olmocr_pdf("path/to/scan.pdf")                # all pages, split mode
#   log <- olmocr_pdf("scan.pdf", pages = 3:5, prompt = "typescript")
#   chk <- ocr_crosscheck("scan.pdf", page = 2)          # olmOCR vs Tesseract
#
# Needs: httr2, magick, pdftools, base64enc (tesseract for cross-checks)
# Key:   DEEPINFRA_API_KEY in ~/.Renviron
# =====================================================================

suppressPackageStartupMessages({
  library(httr2)
  library(magick)
})

OLMOCR_MODEL <- "allenai/olmOCR-2-7B-1025"
OLMOCR_URL   <- "https://api.deepinfra.com/v1/openai/chat/completions"

olmocr_prompts <- list(
  book = paste(
    "Below is an image of a page from a printed book or journal.",
    "Please extract ALL text from this page exactly as written, preserving paragraph structure.",
    "Include running heads, page numbers, and footnotes. Ignore marginal line or paragraph numbers.",
    "Join words hyphenated across line breaks only when the hyphen is a line-break hyphen.",
    "Do not correct spelling or grammar; transcribe errors as printed.",
    "If any text is illegible, indicate with [illegible]. Do not add commentary or interpretation, just transcribe."),
  typescript = paste(
    "Below is an image of a page from a typed document (typewriter era).",
    "Please extract ALL text from this page exactly as written, preserving the original layout,",
    "spacing, and structure as much as possible. For tabular data, maintain column alignment using spaces.",
    "Transcribe numbers carefully: accuracy is critical for scientific data.",
    "Do not correct spelling or grammar; transcribe errors as typed.",
    "If any text is illegible, indicate with [illegible]. Do not add commentary or interpretation, just transcribe.")
)

# ---------------------------------------------------------------------
# Page rendering: ~target_px on the long side, whatever the PDF page size
# ---------------------------------------------------------------------
ocr_render_page <- function(pdf, page, target_px = 3000) {
  ps  <- pdftools::pdf_pagesize(pdf)[page, ]
  dpi <- target_px / (max(ps$width, ps$height) / 72)
  image_read(pdftools::pdf_render_page(pdf, page = page, dpi = dpi))
}

# Row (y) of lightest band near `target` (fraction of height): a gap between text lines
.light_row <- function(img, target, window = 0.03) {
  g  <- image_convert(image_scale(img, "x1000"), colorspace = "gray")
  a  <- as.integer(g[[1]])[, , 1]                     # height x width
  rm <- rowMeans(a)
  rm <- stats::filter(rm, rep(1 / 5, 5), sides = 2)   # smooth across ~5 rows
  n  <- length(rm)
  lo <- max(1, floor((target - window) * n)); hi <- min(n, ceiling((target + window) * n))
  y  <- lo - 1 + which.max(rm[lo:hi])                 # brightest = emptiest row
  y / n
}

# Split a page image into `n` horizontal strips that overlap by `overlap`,
# with every cut snapped to whitespace between text lines.
ocr_split_page <- function(img, n = 2, overlap = 0.05) {
  info <- image_info(img); w <- info$width; h <- info$height
  cuts <- seq(0, 1, length.out = n + 1)
  lapply(seq_len(n), function(k) {
    top <- if (k == 1) 0 else .light_row(img, cuts[k] - overlap)
    bot <- if (k == n) 1 else .light_row(img, cuts[k + 1] + overlap)
    image_crop(img, sprintf("%dx%d+0+%d", w, round((bot - top) * h), round(top * h)))
  })
}

# ---------------------------------------------------------------------
# One API call
# ---------------------------------------------------------------------
olmocr_image <- function(img, prompt = olmocr_prompts$book, partial = FALSE,
                         max_tokens = 4096, maxdim = 1800, frequency_penalty = 0.3,
                         api_key = Sys.getenv("DEEPINFRA_API_KEY")) {
  if (!nzchar(api_key)) stop("DEEPINFRA_API_KEY not set (add it to ~/.Renviron, then readRenviron('~/.Renviron'))")
  if (partial) prompt <- paste(prompt, "This image is part of a page; transcribe only what is visible.")
  img <- image_resize(img, paste0(maxdim, "x", maxdim, ">"))
  tf  <- tempfile(fileext = ".jpg"); on.exit(unlink(tf))
  image_write(img, tf, format = "jpeg", quality = 90)
  body <- list(
    model = OLMOCR_MODEL, max_tokens = max_tokens, temperature = 0,
    frequency_penalty = frequency_penalty,
    messages = list(list(role = "user", content = list(
      list(type = "text", text = prompt),
      list(type = "image_url", image_url = list(
        url = paste0("data:image/jpeg;base64,", base64enc::base64encode(tf))))))))
  resp <- request(OLMOCR_URL) |>
    req_auth_bearer_token(api_key) |>
    req_body_json(body) |>
    req_timeout(180) |>
    req_retry(max_tries = 3, is_transient = function(r) resp_status(r) %in% c(429, 500, 502, 503)) |>
    req_error(body = function(r) paste("DeepInfra:", resp_body_string(r))) |>
    req_perform()
  j <- resp_body_json(resp)
  list(text = j$choices[[1]]$message$content,
       tokens_in = j$usage$prompt_tokens %||% NA, tokens_out = j$usage$completion_tokens %||% NA)
}
`%||%` <- function(a, b) if (is.null(a)) b else a

# ---------------------------------------------------------------------
# Join overlapping strips: find where the end of `a` reappears in `b`
# ---------------------------------------------------------------------
.tok  <- function(x) regmatches(x, gregexpr("\\S+\\s*", x))[[1]]
.norm <- function(t) tolower(gsub("[^[:alnum:]]", "", t))

ocr_stitch <- function(a, b, window = 8, search_words = 400) {
  ta <- .tok(a); tb <- .tok(b)
  na <- .norm(ta); nb <- .norm(tb)
  keep_a <- nzchar(na); keep_b <- nzchar(nb)
  ia <- which(keep_a); ib <- which(keep_b)
  wa <- na[ia]; wb <- nb[ib]
  window <- min(window, length(wa), length(wb))
  if (window < 3) return(list(text = paste0(a, "\n[[SEAM: strip too short to align]]\n", b), seam = "unmatched"))
  lim <- min(length(wb), search_words)
  # slide the window back from the end of a (the last line of a strip is often cut)
  for (back in 0:min(40, length(wa) - window)) {
    end <- length(wa) - back; pat <- wa[(end - window + 1):end]
    for (s in seq_len(max(0, lim - window + 1))) {
      if (identical(wb[s:(s + window - 1)], pat)) {
        cut_a <- ia[end]                  # keep a through the matched words
        cut_b <- ib[s + window - 1]       # drop b through the matched words
        rest  <- if (cut_b < length(tb)) paste0(tb[(cut_b + 1):length(tb)], collapse = "") else ""
        head  <- paste0(ta[1:cut_a], collapse = "")
        if (nzchar(rest) && !grepl("\\s$", head)) head <- paste0(head, " ")   # keep a word gap at the seam
        return(list(text = paste0(head, rest), seam = "ok"))
      }
    }
  }
  list(text = paste0(a, "\n[[SEAM: overlap not found, check for duplicated or missing lines]]\n", b),
       seam = "unmatched")
}

# ---------------------------------------------------------------------
# Quality flags: looping / duplicated phrases
# ---------------------------------------------------------------------
ocr_flags <- function(txt, n = 8) {
  w <- .norm(.tok(txt)); w <- w[nzchar(w)]
  if (length(w) < n * 2) return(character())
  sh <- vapply(seq_len(length(w) - n + 1), function(i) paste(w[i:(i + n - 1)], collapse = " "), "")
  tab <- table(sh); mx <- max(tab)
  flags <- character()
  if (mx >= 4) flags <- c(flags, sprintf("LOOP (an %d-word phrase repeats %dx)", n, mx))
  else if (mx >= 2) flags <- c(flags, sprintf("dup phrase: '%s'", names(tab)[which.max(tab)]))
  flags
}

# ---------------------------------------------------------------------
# One page: split (default), whole, or auto (whole, fall back to split)
# ---------------------------------------------------------------------
olmocr_page <- function(pdf, page, mode = c("split", "whole", "auto"), strips = 2,
                        prompt = "book", dehyphenate = TRUE, ...) {
  mode <- match.arg(mode)
  pr  <- if (prompt %in% names(olmocr_prompts)) olmocr_prompts[[prompt]] else prompt
  img <- ocr_render_page(pdf, page)
  run_split <- function(nst) {
    parts <- lapply(ocr_split_page(img, nst), olmocr_image, prompt = pr, partial = TRUE, max_tokens = 2048, ...)
    txt <- parts[[1]]$text; seams <- character()
    for (k in seq_along(parts)[-1]) { s <- ocr_stitch(txt, parts[[k]]$text); txt <- s$text; seams <- c(seams, s$seam) }
    list(text = txt, seams = paste(seams, collapse = ","),
         tokens_out = sum(vapply(parts, function(p) as.numeric(p$tokens_out), 0)))
  }
  if (mode == "whole" || mode == "auto") {
    r <- olmocr_image(img, prompt = pr, ...)
    res <- list(text = r$text, seams = "", tokens_out = r$tokens_out, mode = "whole")
    if (mode == "auto" && any(grepl("LOOP", ocr_flags(r$text)))) mode <- "split" else return(c(res, list(flags = ocr_flags(r$text))))
  }
  res <- run_split(strips); res$mode <- paste0("split", strips)
  if (any(grepl("LOOP", ocr_flags(res$text))) && strips < 3) {   # one escalation: thirds
    res <- run_split(3); res$mode <- "split3"
  }
  res$joined <- ""
  if (dehyphenate) {
    dh <- ocr_dehyphenate(res$text)
    res$joined <- paste(attr(dh, "joined"), collapse = " ")
    res$text <- as.vector(dh)
  }
  res$flags <- ocr_flags(res$text)
  res
}

# Strips come back with their line breaks, so rejoin words split by a
# line-end hyphen ("appar-\nent" -> "apparent"). Only lowercase-to-lowercase
# joins; a true compound broken at a line end ("twenty-\nfive") will also be
# joined, so the joined words are reported in the log for checking.
ocr_dehyphenate <- function(txt) {
  rx <- "([[:lower:]])-[ \t]*\r?\n[ \t]*([[:lower:]])"
  hits <- regmatches(txt, gregexpr(paste0("[[:alpha:]]+-[ \t]*\r?\n[ \t]*[[:lower:]]+"), txt))[[1]]
  out <- gsub(rx, "\\1\\2", txt)
  attr(out, "joined") <- gsub("\\s+", "", hits)
  out
}

# ---------------------------------------------------------------------
# Whole PDF: per-page text files, combined file, and a log. Resumable.
# ---------------------------------------------------------------------
olmocr_pdf <- function(pdf, out_dir = NULL, pages = NULL, mode = "split",
                       prompt = "book", overwrite = FALSE, ...) {
  stem <- tools::file_path_sans_ext(basename(pdf))
  if (is.null(out_dir)) out_dir <- file.path(dirname(pdf), paste0(stem, "_olmocr"))
  dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
  n <- pdftools::pdf_info(pdf)$pages
  if (is.null(pages)) pages <- seq_len(n)
  log_path <- file.path(out_dir, "_log.csv")
  log <- if (file.exists(log_path)) utils::read.csv(log_path, stringsAsFactors = FALSE) else NULL
  for (p in pages) {
    f <- file.path(out_dir, sprintf("page_%03d.txt", p))
    if (file.exists(f) && file.size(f) > 0 && !overwrite) { message("page ", p, ": done, skipping"); next }
    t0 <- Sys.time()
    r <- tryCatch(olmocr_page(pdf, p, mode = mode, prompt = prompt, ...),
                  error = function(e) list(text = "", mode = mode, seams = "", tokens_out = NA,
                                           flags = paste("ERROR:", conditionMessage(e))))
    if (nzchar(r$text)) writeLines(r$text, f, useBytes = TRUE)
    row <- data.frame(page = p, mode = r$mode, chars = nchar(r$text), seams = r$seams,
                      tokens_out = r$tokens_out, seconds = round(as.numeric(Sys.time() - t0, units = "secs"), 1),
                      flags = paste(r$flags, collapse = "; "), joined = r$joined %||% "",
                      when = format(Sys.time()))
    if (!is.null(log)) for (cn in setdiff(names(row), names(log))) log[[cn]] <- rep("", nrow(log))
    log <- rbind(log[log$page != p, names(row), drop = FALSE], row)
    utils::write.csv(log[order(log$page), ], log_path, row.names = FALSE)
    message(sprintf("page %d: %s, %d chars, %.0fs %s", p, r$mode, nchar(r$text), row$seconds,
                    if (nzchar(row$flags)) paste("FLAG:", row$flags) else ""))
  }
  files <- file.path(out_dir, sprintf("page_%03d.txt", seq_len(n)))
  comb  <- unlist(lapply(seq_len(n), function(p) if (file.exists(files[p]))
    c(sprintf("\n======== PAGE %d ========\n", p), readLines(files[p], warn = FALSE, encoding = "UTF-8"))))
  writeLines(comb, file.path(out_dir, "_combined.txt"), useBytes = TRUE)
  invisible(log[order(log$page), ])
}

# ---------------------------------------------------------------------
# Cross-check: word-level disagreements between two readings (LCS diff).
# Differences involving digits or number words are marked — those are the
# ones vision-language OCR is most likely to invent.
# ---------------------------------------------------------------------
ocr_disagreements <- function(a, b, label_a = "A", label_b = "B") {
  wa <- .tok(a); wb <- .tok(b); na <- .norm(wa); nb <- .norm(wb)
  wa <- trimws(wa[nzchar(na)]); wb <- trimws(wb[nzchar(nb)]); na <- na[nzchar(na)]; nb <- nb[nzchar(nb)]
  m <- length(na); n <- length(nb)
  L <- matrix(0L, m + 1, n + 1)
  for (i in rev(seq_len(m))) for (j in rev(seq_len(n))) L[i, j] <- if (na[i] == nb[j]) L[i + 1, j + 1] + 1L else max(L[i + 1, j], L[i, j + 1])
  i <- 1; j <- 1; out <- list(); ba <- bb <- character(); ctx <- ""
  flush <- function() if (length(ba) || length(bb)) out[[length(out) + 1]] <<-
    data.frame(context = ctx, a = paste(ba, collapse = " "), b = paste(bb, collapse = " "))
  while (i <= m || j <= n) {
    if (i <= m && j <= n && na[i] == nb[j]) {
      flush(); ba <- bb <- character()
      ctx <- paste(tail(c(strsplit(ctx, " ")[[1]], wa[i]), 5), collapse = " ")
      i <- i + 1; j <- j + 1
    } else if (j <= n && (i > m || L[i, j + 1] >= L[i + 1, j])) { bb <- c(bb, wb[j]); j <- j + 1
    } else { ba <- c(ba, wa[i]); i <- i + 1 }
  }
  flush()
  d <- if (length(out)) do.call(rbind, out) else data.frame(context = character(), a = character(), b = character())
  numrx <- "[0-9]|\\b(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|teen|twenty|thirty|forty|fifty|hundred|thousand)"
  d$number <- grepl(numrx, d$a, ignore.case = TRUE) | grepl(numrx, d$b, ignore.case = TRUE)
  names(d)[2:3] <- c(label_a, label_b)
  d
}

# olmOCR (from a finished run) vs a fresh Tesseract read of the same page
ocr_crosscheck <- function(pdf, page, olm_dir = NULL) {
  stem <- tools::file_path_sans_ext(basename(pdf))
  if (is.null(olm_dir)) olm_dir <- file.path(dirname(pdf), paste0(stem, "_olmocr"))
  olm <- paste(readLines(file.path(olm_dir, sprintf("page_%03d.txt", page)), warn = FALSE, encoding = "UTF-8"), collapse = "\n")
  tf  <- tempfile(fileext = ".png"); on.exit(unlink(tf))
  image_write(ocr_render_page(pdf, page), tf, format = "png")
  tes <- tesseract::ocr(tf)
  ocr_disagreements(olm, tes, "olmOCR", "Tesseract")
}
