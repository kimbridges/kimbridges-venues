# OCR_tools

These tools read scanned documents with **olmOCR-2-7B** (Allen AI's vision-language OCR model), called through DeepInfra from R.

## Setup (one time)

- The packages needed are `httr2`, `magick`, `pdftools` and `base64enc`. `tesseract` is optional; it's only used for cross-checks.
- `~/.Renviron` must contain `DEEPINFRA_API_KEY=...`. After editing it, run `readRenviron("~/.Renviron")`.
- If a run fails with **HTTP 402 Payment Required**, the DeepInfra account needs credit.

## Use

```r
source("G:/My Drive/Projects/OCR_tools/ocr_tools.R")

log <- olmocr_pdf("path/to/scan.pdf")                         # all pages, half-page strips
log <- olmocr_pdf("scan.pdf", pages = 3:5, prompt = "typescript")
log <- olmocr_pdf("scan.pdf", mode = "auto")                  # whole page; retries in strips if it loops

chk <- ocr_crosscheck("scan.pdf", page = 2)                   # olmOCR vs Tesseract
chk[chk$number, ]                                             # disagreements involving numbers
```

`olmocr_pdf()` writes into `<pdfname>_olmocr/`, next to the PDF:

- `page_NNN.txt`: one file per page.
- `_combined.txt`: all pages in one file.
- `_log.csv`: for each page, the mode, character count, how the halves were joined, timing, and any warnings.

If you rerun it, pages that are already finished are skipped. Use `overwrite = TRUE` to redo them.

## Lessons behind the defaults

These come from the Jones reports (April 2026) and the Diamond essay (October 2026).

1. **Split each page into halves by default.** On curved or dense book pages, whole-page olmOCR got stuck repeating one sentence about 20,000 characters' worth, dropped a final paragraph, and invented text. The same page read as two overlapping halves came back exact. The script cuts at the whitespace between lines and joins the halves by matching the overlapping words. If the halves can't be matched, it inserts a visible `[[SEAM...]]` marker instead of guessing.
2. **olmOCR is a language model, so check its numbers.** On whole pages it changed 137 to 139 and "eight" to "eighteen", and silently corrected printer's errors. `ocr_disagreements()` / `ocr_crosscheck()` mark any disagreement involving digits or number words.
3. **Looping is detected automatically.** Any 8-word phrase that repeats 4 or more times is flagged as a loop. A split page that still loops is retried in thirds. A phrase that repeats twice is flagged as a possible duplicate.
4. **Tesseract is a useful second reader on flat pages.** Its mistakes, such as misread letters, are different from olmOCR's, which are fluent but invented text. Where they agree, the text is almost certainly right.
5. **Splitting doesn't fix every misread.** In the live test of the split mode, a curved page still came back with "came" read as "come" and "that" read as "this". On curved or faded pages, run `ocr_crosscheck()` or have Claude compare the text against the page images.
6. **Hyphens at line ends are rejoined.** Text from half-page strips keeps its line breaks, so "appar-↵ent" becomes "apparent". A real compound broken at a line end ("twenty-↵five") would also be joined, so every joined word is listed in the `joined` column of `_log.csv` for checking. Use `dehyphenate = FALSE` to turn this off.
7. **Pages are rendered at about 3,000 px on the long side whatever the PDF's page size**, then reduced to 1,800 px before sending. DeepInfra charges roughly the same per image regardless of size.

## History

- `jones_ocr_pipeline.py` (Python, whole pages, 300 DPI) is in `kimbridges-collections/Jones/Jones_analysis/`.
- The first R version and test outputs from the Diamond essay are in `Jones_analysis/Diamond_OCR/`.
