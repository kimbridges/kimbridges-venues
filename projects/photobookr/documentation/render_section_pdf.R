## --- render_section_pdf.R ---
## Render a single markdown section to a PDF page
## Requires: rmarkdown (and tinytex or a LaTeX installation)

library(rmarkdown)

#' Render a single section to PDF
#'
#' Takes a section (from parse_book_markdown) and renders it to a 
#' formatted PDF page matching photo book dimensions.
#'
#' @param section A list with: header, body (and optionally order, slug)
#' @param output_path Path for the output PDF file
#' @param margin Margin in inches (default: 0.75)
#' @param body_size Font size for body text (default: 12pt)
#' @return Invisibly returns the output path
#'
render_section_pdf <- function(section,
                               output_path,
                               margin = 0.75,
                               body_size = 12) {
  
  ## Build markdown content
  yaml_header <- paste0(
    '---
output: pdf_document
geometry: margin=', margin, 'in
fontsize: ', body_size, 'pt
---

')
  
  md_content <- paste0(
    yaml_header,
    "# ", section$header, "\n\n",
    section$body
  )
  
  ## Create temp Rmd in current working directory
  temp_name <- paste0("temp_render_", Sys.getpid())
  temp_rmd <- paste0(temp_name, ".Rmd")
  temp_pdf <- paste0(temp_name, ".pdf")
  
  writeLines(md_content, temp_rmd)
  
  ## Render (PDF will be created as temp_name.pdf in same directory)
  result <- tryCatch({
    rmarkdown::render(temp_rmd, quiet = TRUE)
    TRUE
  }, error = function(e) {
    message("Render error: ", e$message)
    FALSE
  })
  
  ## Clean up Rmd
  if (file.exists(temp_rmd)) unlink(temp_rmd)
  
  if (!result || !file.exists(temp_pdf)) {
    stop("PDF rendering failed. Is tinytex installed?")
  }
  
  ## Move PDF to desired location
  if (file.exists(output_path)) unlink(output_path)
  file.rename(temp_pdf, output_path)
  
  message("Created: ", output_path)
  invisible(output_path)
}


#' Test rendering with a simple section
test_render <- function(output_path = "test_section.pdf") {
  test_section <- list(
    header = "Test Chapter",
    body = "This is a test paragraph with **bold** and *italic* text.
    
### A Subheading

More content here."
  )
  render_section_pdf(test_section, output_path)
}