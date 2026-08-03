#' Convert markdown file to chapter PDFs
#'
#' Parses a markdown file and creates numbered PDF files for each level-2
#' header (## Header). Output files are named to work with the photo book
#' assembly system.
#'
#' @param md_file Path to markdown file (.md or .Rmd)
#' @param output_folder Folder for output PDFs (default: "Stories")
#' @param margin Page margin in inches (default: 0.75)
#' @param body_size Font size in points: 10, 11, 12, 14, 17, or 20 (default: 12)
#' @param font_family Font: "palatino", "helvetica", "bookman", "charter", or "default"
#' @param clear_folder If TRUE, remove existing PDFs in output folder first (default: FALSE)
#'
#' @return Invisibly returns vector of created PDF paths
#' @export
#'
#' @details
#' The markdown file is split on level-2 headers (## Header). Each section
#' becomes a separate PDF chapter. The header text is used as the chapter
#' title and to generate the filename (e.g., ## Paris becomes 01_paris.pdf).
#' 
#' Level-3 and lower headers (###, ####) are kept within their parent section.
#'
#' Font options:
#' \itemize{
#'   \item "default": Computer Modern (standard LaTeX font)
#'   \item "palatino": Elegant serif, very readable
#'   \item "bookman": Larger x-height, good for screens
#'   \item "charter": Clean, modern serif
#'   \item "helvetica": Sans-serif, clean and modern
#' }
#'
#' For phone/screen viewing, try body_size = 17 with font_family = "helvetica"
#'
#' @examples
#' \dontrun{
#' # Basic usage
#' markdown_to_chapters("book_text.md")
#'
#' # Phone-friendly formatting
#' markdown_to_chapters("book_text.md", body_size = 17, font_family = "helvetica")
#'
#' # Clear old chapters first
#' markdown_to_chapters("book_text.md", clear_folder = TRUE)
#' }
markdown_to_chapters <- function(md_file,
                                  output_folder = "Stories",
                                  margin = 0.75,
                                  body_size = 12,
                                  font_family = "default",
                                  clear_folder = FALSE) {
  
  sections <- parse_book_markdown(md_file)
  
  if (length(sections) == 0) {
    stop("No sections found in: ", md_file)
  }
  
  message("Found ", length(sections), " chapters in: ", md_file)
  message("Settings: ", body_size, "pt, font = ", font_family)
  
  if (!dir.exists(output_folder)) {
    dir.create(output_folder, recursive = TRUE)
    message("Created folder: ", output_folder)
  }
  
  if (clear_folder) {
    existing <- list.files(output_folder, pattern = "\\.pdf$", full.names = TRUE)
    if (length(existing) > 0) {
      file.remove(existing)
      message("Cleared ", length(existing), " existing PDFs from ", output_folder)
    }
  }
  
  output_paths <- character(length(sections))
  
  for (s in sections) {
    pdf_name <- sprintf("%02d_%s.pdf", s$order, s$slug)
    pdf_path <- file.path(output_folder, pdf_name)
    
    message("  [", s$order, "/", length(sections), "] ", s$header, " -> ", pdf_name)
    
    render_section_pdf(s, pdf_path, margin = margin, body_size = body_size,
                       font_family = font_family)
    output_paths[s$order] <- pdf_path
  }
  
  message("\nCreated ", length(sections), " chapter PDFs in: ", output_folder)
  invisible(output_paths)
}


#' Parse markdown file into chapter sections
#' @param md_file Path to markdown file
#' @return List of sections
#' @noRd
parse_book_markdown <- function(md_file) {
  
  if (!file.exists(md_file)) {
    stop("File not found: ", md_file)
  }
  
  lines <- readLines(md_file, warn = FALSE)
  
  ## Remove YAML front matter if present
  if (length(lines) > 0 && lines[1] == "---") {
    yaml_end <- which(lines[-1] == "---")[1] + 1
    if (!is.na(yaml_end)) {
      lines <- lines[(yaml_end + 1):length(lines)]
    }
  }
  
  header_pattern <- "^# +(.+)$"
  header_indices <- grep(header_pattern, lines)
  
  if (length(header_indices) == 0) {
    warning("No # (chapter) headers found in: ", md_file)
    return(list())
  }
  
  sections <- list()
  
  for (i in seq_along(header_indices)) {
    start_line <- header_indices[i]
    end_line <- if (i < length(header_indices)) header_indices[i + 1] - 1 else length(lines)
    
    header_text <- trimws(sub(header_pattern, "\\1", lines[start_line]))
    
    if (start_line < end_line) {
      body_lines <- lines[(start_line + 1):end_line]
      while (length(body_lines) > 0 && body_lines[1] == "") body_lines <- body_lines[-1]
      while (length(body_lines) > 0 && body_lines[length(body_lines)] == "") {
        body_lines <- body_lines[-length(body_lines)]
      }
      body_text <- paste(body_lines, collapse = "\n")
    } else {
      body_text <- ""
    }
    
    slug <- tolower(header_text)
    slug <- gsub("[^a-z0-9]+", "_", slug)
    slug <- gsub("^_|_$", "", slug)
    slug <- gsub("_+", "_", slug)
    
    sections[[i]] <- list(order = i, header = header_text, body = body_text, slug = slug)
  }
  
  return(sections)
}


#' Render a single section to PDF
#' @param section Section list
#' @param output_path Output path
#' @param margin Margin in inches
#' @param body_size Font size
#' @param font_family Font family
#' @noRd
render_section_pdf <- function(section, output_path, margin = 0.75,
                                body_size = 12, font_family = "default") {
  
  standard_sizes <- c(10, 11, 12)
  extended_sizes <- c(14, 17, 20)
  all_sizes <- c(standard_sizes, extended_sizes)
  
  if (!body_size %in% all_sizes) {
    warning("body_size should be one of: ", paste(all_sizes, collapse = ", "), ". Using 12.")
    body_size <- 12
  }
  
  use_extarticle <- body_size %in% extended_sizes
  
  font_cmd <- switch(font_family,
    "palatino"  = "\\usepackage{palatino}",
    "helvetica" = "\\usepackage{helvet}\\renewcommand{\\familydefault}{\\sfdefault}",
    "bookman"   = "\\usepackage{bookman}",
    "charter"   = "\\usepackage{charter}",
    "default"   = "",
    ""
  )
  
  if (use_extarticle) {
    yaml_header <- paste0(
'---
documentclass: extarticle
output:
  pdf_document:
    latex_engine: xelatex
mainfont: "Cambria"
fontsize: ', body_size, 'pt
geometry: margin=', margin, 'in
header-includes:
  - \\pagestyle{empty}
  - ', font_cmd, '
---

')
  } else {
    yaml_header <- paste0(
'---
output:
  pdf_document:
    latex_engine: xelatex
mainfont: "Cambria"
fontsize: ', body_size, 'pt
geometry: margin=', margin, 'in
header-includes:
  - \\pagestyle{empty}
  - ', font_cmd, '
---

')
  }
  
  md_content <- paste0(yaml_header, "# ", section$header, "\n\n", section$body)
  
  temp_name <- paste0("temp_render_", Sys.getpid())
  temp_rmd <- paste0(temp_name, ".Rmd")
  temp_pdf <- paste0(temp_name, ".pdf")
  
  writeLines(md_content, temp_rmd)
  
  result <- tryCatch({
    rmarkdown::render(temp_rmd, quiet = TRUE)
    TRUE
  }, error = function(e) {
    message("Render error: ", e$message)
    FALSE
  })
  
  if (result && file.exists(temp_rmd)) unlink(temp_rmd)
  
  if (!result || !file.exists(temp_pdf)) {
    stop("PDF rendering failed for: ", section$header)
  }
  
  if (file.exists(output_path)) unlink(output_path)
  file.rename(temp_pdf, output_path)
  
  invisible(output_path)
}
