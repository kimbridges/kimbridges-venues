## --- parse_book_markdown.R ---
## Parse a markdown file into chapter sections based on ## headers

#' Parse markdown file into chapter sections
#'
#' Reads a markdown file and splits it into sections based on level-2 
#' headers (## Header). Each section becomes a potential chapter.
#' Lower-level headers (###, ####) are kept within their parent section.
#'
#' @param md_file Path to markdown file (.md or .Rmd)
#' @return A list of sections, each containing:
#'   - order: numeric position (1, 2, 3, ...)
#'   - header: the header text (without ##)
#'   - body: all text following the header until the next ## header
#'   - slug: URL-safe version of header for filenames
#'
parse_book_markdown <- function(md_file) {
  
  if (!file.exists(md_file)) {
    stop("File not found: ", md_file)
  }
  
  ## Read all lines
  lines <- readLines(md_file, warn = FALSE)
  
  ## Remove YAML front matter if present (between --- lines)
  if (length(lines) > 0 && lines[1] == "---") {
    yaml_end <- which(lines[-1] == "---")[1] + 1
    if (!is.na(yaml_end)) {
      lines <- lines[(yaml_end + 1):length(lines)]
    }
  }
  
  ## Find lines that start with "## " (level-2 headers only)
  ## Must be exactly two #, not ### or more
  header_pattern <- "^## +(.+)$"
  header_indices <- grep(header_pattern, lines)
  
  if (length(header_indices) == 0) {
    warning("No ## headers found in: ", md_file)
    return(list())
  }
  
  ## Extract sections
  sections <- list()
  
  for (i in seq_along(header_indices)) {
    start_line <- header_indices[i]
    
    ## Section ends at next ## header or end of file
    if (i < length(header_indices)) {
      end_line <- header_indices[i + 1] - 1
    } else {
      end_line <- length(lines)
    }
    
    ## Extract header text (remove the ## prefix)
    header_text <- sub(header_pattern, "\\1", lines[start_line])
    header_text <- trimws(header_text)
    
    ## Extract body (everything after header line until next section)
    if (start_line < end_line) {
      body_lines <- lines[(start_line + 1):end_line]
      ## Trim leading/trailing blank lines from body
      while (length(body_lines) > 0 && body_lines[1] == "") {
        body_lines <- body_lines[-1]
      }
      while (length(body_lines) > 0 && body_lines[length(body_lines)] == "") {
        body_lines <- body_lines[-length(body_lines)]
      }
      body_text <- paste(body_lines, collapse = "\n")
    } else {
      body_text <- ""
    }
    
    ## Create filename-safe slug from header
    slug <- tolower(header_text)
    slug <- gsub("[^a-z0-9]+", "_", slug)  # replace non-alphanumeric with underscore
    slug <- gsub("^_|_$", "", slug)         # trim leading/trailing underscores
    slug <- gsub("_+", "_", slug)           # collapse multiple underscores
    
    sections[[i]] <- list(
      order = i,
      header = header_text,
      body = body_text,
      slug = slug
    )
  }
  
  message("Parsed ", length(sections), " sections from: ", md_file)
  return(sections)
}


#' Print summary of parsed sections (for testing)
#' @param sections List returned by parse_book_markdown
print_sections_summary <- function(sections) {
  if (length(sections) == 0) {
    message("No sections to display.")
    return(invisible(NULL))
  }
  
  for (s in sections) {
    body_preview <- substr(s$body, 1, 60)
    if (nchar(s$body) > 60) body_preview <- paste0(body_preview, "...")
    
    cat(sprintf("\n[%d] %s\n", s$order, s$header))
    cat(sprintf("    slug: %s\n", s$slug))
    cat(sprintf("    body: %s\n", body_preview))
  }
}


# =============================================================================
# USAGE / TESTING
# =============================================================================
#
 source("parse_book_markdown.R")
 sections <- parse_book_markdown("Garden.Rmd")
 print_sections_summary(sections)
#
# Expected output for Garden.Rmd:
#
# [1] Statue
#     slug: statue
#     body: There are a few statues in the garden. Not many, but t...
#
# [2] Flower
#     slug: flower
#     body: There are a lot of different flowers, even though it ...