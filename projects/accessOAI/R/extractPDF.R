#' Supply a PDF that has text and retrieve the text for all or specific pages.
#' @param pdf_path The file and its location on the local computer.
#' @param start_page Optional value of the page number for the start of the extraction.
#' @param start_page Value of the page number for the end of the extraction if a start_page specified.
#' @keywords PDF, extract text, text range
#' @export
#' @examples
extractPDF <- function (pdf_path, 
                        start_page = NULL, 
                        end_page = NULL){

## Extract the text from the PDF.
extracted_text <- pdf_text(pdf_path)

## Keep specific pages.

## If the first page is not given, make it the first page.
if (is.null(start_page)) {start_page <- 1}

## Find the document length (in pages).
n_pages <- length(extracted_text) ## Total number of pages extracted.

## If the end page is not given, make it the last page.
if (is.null(end_page)) {end_page <- n_pages}

## Extract the range of pages (from the start to end pages).
analysis_text <- extracted_text[start_page:end_page]

return(analysis_text)
} ## End function extractPDF
