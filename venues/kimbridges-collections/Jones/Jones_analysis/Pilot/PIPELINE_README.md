# Jones OCR Pipeline — Quick Start

## Setup (one-time)

```bash
pip install requests pdf2image Pillow
```

On macOS, also install poppler: `brew install poppler`

## Set your API key

```bash
export DEEPINFRA_API_KEY="PUjWbzW8ltpzWkGH6gSO9p2PDTuiXH4o"
```

## Usage

### List all reports
```bash
python jones_ocr_pipeline.py --reports-dir ../Reports --output-dir . --list
```

### Process a single report (all pages)
```bash
python jones_ocr_pipeline.py --reports-dir ../Reports --output-dir . --file "report 1950.pdf"
```

### Process specific pages only
```bash
python jones_ocr_pipeline.py --reports-dir ../Reports --output-dir . --file "report 1950.pdf" --pages 10-15
```

### Process ALL 38 reports
```bash
python jones_ocr_pipeline.py --reports-dir ../Reports --output-dir .
```

## What it produces

For each PDF, the pipeline creates:
```
ocr_text/
  report 1950/
    page_001.txt      # raw OCR text for each page
    page_002.txt
    ...
    _combined.txt     # all pages concatenated with page markers
    _summary.json     # processing stats
```

## Resume support

If the script is interrupted, rerun the same command — it skips pages that already have non-empty text files. To reprocess a page, delete its .txt file first.

## Next steps after OCR

The raw OCR text files need to be parsed into structured CSVs using the schemas in `data/weather/SCHEMA.md` and `data/brant/SCHEMA.md`. This parsing step can be done collaboratively in a follow-up session.
