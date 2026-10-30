# PubMaps service (Phase A: concierge) -- 2026-10-29
# Folders under G:/My Drive/Projects/PubMaps/service/
#   inbox/      submissions land here (PDF), by Duet or by hand
#   work/<id>/  full pubmap() run -- REVIEW AND EDIT points.csv HERE
#   outbox/<id>/ APPROVED results only: map PDF + PNG, points.csv, review.html,
#               symbol_key.txt, reply_draft.txt -- what Duet attaches to the reply
#   processed/  submissions after a successful run (renamed <id>.pdf)
#   failed/     submissions that errored, with <id>_error.txt
#   service_log.csv  one row per action
#
# Use:
#   source("G:/My Drive/Projects/PubMaps/service/pubmap_service.R")
#   process_inbox()          # run every PDF in inbox/ -> work/<id>/
#   rerender_submission(id)  # after editing work/<id>/points.csv
#   approve_submission(id)   # copy deliverables to outbox/<id>/ (the send gate)
#   service_check()          # one-line status; run at every PKM session start
#
# Operator description: SERVICE.md in this folder.

suppressMessages(library(pubmaps))
SVC <- "G:/My Drive/Projects/PubMaps/service"
DELIVER <- c("map_vector.pdf", "map_vector.png", "points.csv",
             "review.html", "symbol_key.txt")

.svc <- function(...) file.path(SVC, ...)

# Write text as CRLF in binary -- never writeLines() on G: (PKM Finding 037)
.svc_write <- function(lines, file)
  writeBin(charToRaw(enc2utf8(paste0(paste(lines, collapse = "\r\n"), "\r\n"))), file)

.svc_log <- function(id, file, action, status, n_points = NA, seconds = NA, note = "") {
  row <- data.frame(time = format(Sys.time(), "%Y-%m-%d %H:%M:%S"), id = id,
                    file = file, action = action, status = status,
                    n_points = n_points, seconds = seconds, note = note)
  f <- .svc("service_log.csv")
  write.table(row, f, sep = ",", row.names = FALSE, qmethod = "double",
              col.names = !file.exists(f), append = file.exists(f))
}

.svc_id <- function(file) {
  stem <- tools::file_path_sans_ext(basename(file))
  stem <- gsub("[^A-Za-z0-9_-]+", "_", stem)
  stem <- substr(gsub("^_+|_+$", "", stem), 1, 40)
  id <- paste0(format(Sys.Date(), "%Y%m%d"), "_", stem)
  base <- id; k <- 1
  while (dir.exists(.svc("work", id))) { k <- k + 1; id <- paste0(base, "_", k) }
  id
}

.n_points <- function(id) {
  p <- .svc("work", id, "points.csv")
  if (file.exists(p)) nrow(utils::read.csv(p)) else NA
}

process_inbox <- function(provider = "openai", model = NULL) {
  pdfs <- list.files(.svc("inbox"), pattern = "\\.pdf$", ignore.case = TRUE,
                     full.names = TRUE)
  if (!length(pdfs)) { message("Inbox empty."); return(invisible(character())) }
  ids <- character()
  for (f in pdfs) {
    id <- .svc_id(f); t0 <- Sys.time()
    message("Processing ", basename(f), " -> ", id)
    ok <- tryCatch({
      pubmap(f, dir = .svc("work", id), provider = provider, model = model)
      TRUE
    }, error = function(e) {
      .svc_write(c(basename(f), conditionMessage(e)),
                 .svc("failed", paste0(id, "_error.txt")))
      FALSE
    })
    secs <- round(as.numeric(difftime(Sys.time(), t0, units = "secs")))
    dest <- .svc(if (ok) "processed" else "failed", paste0(id, ".pdf"))
    file.copy(f, dest); if (file.exists(dest)) file.remove(f)
    .svc_log(id, basename(f), "process", if (ok) "ok" else "FAILED",
             if (ok) .n_points(id) else NA, secs)
    if (ok) {
      message("  Review: ", .svc("work", id, "review.html"))
      ids <- c(ids, id)
    } else message("  FAILED -- see failed/", id, "_error.txt")
  }
  invisible(ids)
}

rerender_submission <- function(id, ...) {
  t0 <- Sys.time()
  pubmap_rerender(.svc("work", id), ...)
  .svc_log(id, "", "rerender", "ok", .n_points(id),
           round(as.numeric(difftime(Sys.time(), t0, units = "secs"))))
  message("Review: ", .svc("work", id, "review.html"))
  invisible(id)
}

approve_submission <- function(id, note = "") {
  src <- .svc("work", id); out <- .svc("outbox", id)
  stopifnot(dir.exists(src))
  dir.create(out, showWarnings = FALSE)
  have <- DELIVER[file.exists(file.path(src, DELIVER))]
  file.copy(file.path(src, have), out, overwrite = TRUE)
  n <- .n_points(id)
  .svc_write(c(
    "Subject: PubMaps results",
    "",
    "Thank you for trying PubMaps. Attached are the results for your manuscript:",
    "",
    "  map_vector.pdf  - the map, vector (for print or further editing)",
    "  map_vector.png  - the same map as an image",
    paste0("  points.csv      - the ", n, " located places with coordinates and their sources"),
    "  review.html     - the review page: open it in a browser to check each place",
    "  symbol_key.txt  - a symbol key you can paste into a caption",
    "",
    "The places were found by an AI reading of the text and then located in",
    "gazetteers. Please check them against what you know of the sites. If any",
    "are wrong, correct points.csv (or simply tell us which) and we will",
    "redraw the map.",
    if (nzchar(note)) c("", note),
    "",
    "Kim Bridges"), file.path(out, "reply_draft.txt"))
  .svc_log(id, "", "approve", "ok", n, NA, note)
  message("Approved: ", out, " (", length(have) + 1, " files)")
  invisible(out)
}

service_status <- function() {
  f <- .svc("service_log.csv")
  list(inbox = list.files(.svc("inbox"), pattern = "\\.pdf$", ignore.case = TRUE),
       awaiting_review = setdiff(list.files(.svc("work")), list.files(.svc("outbox"))),
       approved = list.files(.svc("outbox")),
       log = if (file.exists(f)) utils::tail(utils::read.csv(f), 10) else NULL)
}


service_check <- function() {
  inbox <- list.files(.svc("inbox"), pattern = "\\.pdf$", ignore.case = TRUE)
  awaiting <- setdiff(list.files(.svc("work")), list.files(.svc("outbox")))
  failed <- list.files(.svc("failed"), pattern = "_error\\.txt$")
  msg <- sprintf("PubMaps service: %d in inbox, %d awaiting review, %d failed (all time).",
                 length(inbox), length(awaiting), length(failed))
  message(msg)
  invisible(list(inbox = inbox, awaiting_review = awaiting, failed = failed, summary = msg))
}
