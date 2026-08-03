#!/usr/bin/env python3
"""
Jones Refuge Report OCR Pipeline
=================================
Extracts text from scanned PDF pages of Robert D. Jones Jr.'s
Izembek/Cold Bay Refuge Narrative Reports (1948-1974) using
olmOCR-2-7B-1025 via DeepInfra API.

Usage:
    python jones_ocr_pipeline.py --reports-dir ./Reports --output-dir ./Pilot
    python jones_ocr_pipeline.py --reports-dir ./Reports --output-dir ./Pilot --file "report 1950.pdf"
    python jones_ocr_pipeline.py --reports-dir ./Reports --output-dir ./Pilot --file "report 1950.pdf" --pages 10-15

Requirements:
    pip install requests pdf2image Pillow

    Also requires poppler-utils (for pdf2image):
        macOS:   brew install poppler
        Ubuntu:  sudo apt-get install poppler-utils
        Windows: download from https://github.com/osconnell/poppler-windows/releases

Environment:
    Set DEEPINFRA_API_KEY or pass --api-key on the command line.

Author: Kim Bridges / Claude (Anthropic)
"""

import argparse
import base64
import json
import os
import sys
import time
from io import BytesIO
from pathlib import Path

try:
    import requests
except ImportError:
    sys.exit("ERROR: 'requests' not installed. Run: pip install requests")

try:
    from pdf2image import convert_from_path
except ImportError:
    sys.exit("ERROR: 'pdf2image' not installed. Run: pip install pdf2image")

try:
    from PIL import Image
except ImportError:
    sys.exit("ERROR: 'Pillow' not installed. Run: pip install Pillow")


# ============================================================
# Configuration
# ============================================================
DEEPINFRA_API_URL = "https://api.deepinfra.com/v1/openai/chat/completions"
MODEL = "allenai/olmOCR-2-7B-1025"
DPI = 300          # scan resolution for OCR
MAX_TOKENS = 4096  # max response tokens
JPEG_QUALITY = 85  # quality for base64-encoded images sent to API

# olmOCR prompt - instructs the model to do faithful text extraction
OLMOCR_PROMPT = (
    "Below is an image of a page from a typed government wildlife refuge report "
    "(1940s-1970s era). Please extract ALL text from this page exactly as written, "
    "preserving the original layout, spacing, and structure as much as possible. "
    "For tabular data, maintain column alignment using spaces or tabs. "
    "Transcribe numbers carefully — accuracy is critical for scientific data. "
    "If any text is illegible, indicate with [illegible]. "
    "Do not add commentary or interpretation — just transcribe."
)


def image_to_base64(image: Image.Image, quality: int = JPEG_QUALITY) -> str:
    """Convert a PIL Image to a base64-encoded JPEG string."""
    buffer = BytesIO()
    image.save(buffer, format="JPEG", quality=quality)
    return base64.b64encode(buffer.getvalue()).decode("utf-8")


def call_olmocr(api_key: str, image_b64: str, prompt: str = OLMOCR_PROMPT,
                max_retries: int = 3, timeout: int = 120) -> dict:
    """
    Send an image to olmOCR via DeepInfra API and return the response.

    Returns dict with keys: 'text', 'usage', 'error'
    """
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {api_key}",
    }

    payload = {
        "model": MODEL,
        "messages": [
            {
                "role": "user",
                "content": [
                    {"type": "text", "text": prompt},
                    {
                        "type": "image_url",
                        "image_url": {
                            "url": f"data:image/jpeg;base64,{image_b64}"
                        }
                    }
                ]
            }
        ],
        "max_tokens": MAX_TOKENS,
        "temperature": 0.0,  # deterministic output for reproducibility
    }

    for attempt in range(max_retries):
        try:
            response = requests.post(
                DEEPINFRA_API_URL,
                headers=headers,
                json=payload,
                timeout=timeout
            )

            if response.status_code == 200:
                data = response.json()
                text = data["choices"][0]["message"]["content"]
                usage = data.get("usage", {})
                return {"text": text, "usage": usage, "error": None}

            elif response.status_code == 429:
                # Rate limited — wait and retry
                wait = 2 ** (attempt + 1)
                print(f"    Rate limited. Waiting {wait}s...")
                time.sleep(wait)
                continue

            elif response.status_code == 401:
                return {"text": "", "usage": {}, "error": "Authentication failed. Check API key."}

            else:
                error_msg = f"HTTP {response.status_code}: {response.text[:200]}"
                if attempt < max_retries - 1:
                    time.sleep(2)
                    continue
                return {"text": "", "usage": {}, "error": error_msg}

        except requests.exceptions.Timeout:
            if attempt < max_retries - 1:
                print(f"    Timeout on attempt {attempt+1}. Retrying...")
                continue
            return {"text": "", "usage": {}, "error": "Request timed out after all retries"}

        except requests.exceptions.RequestException as e:
            return {"text": "", "usage": {}, "error": str(e)}

    return {"text": "", "usage": {}, "error": "Max retries exceeded"}


def parse_page_range(page_str: str) -> list:
    """Parse a page range string like '10-15' or '1,5,10-20' into a list of page numbers."""
    pages = []
    for part in page_str.split(","):
        part = part.strip()
        if "-" in part:
            start, end = part.split("-", 1)
            pages.extend(range(int(start), int(end) + 1))
        else:
            pages.append(int(part))
    return sorted(set(pages))


def process_pdf(pdf_path: str, output_dir: str, api_key: str,
                page_range: list = None, dpi: int = DPI):
    """
    Process a single PDF file:
    1. Convert pages to images
    2. Send each to olmOCR
    3. Save raw OCR text per page
    4. Save a combined text file

    Returns a summary dict.
    """
    pdf_path = Path(pdf_path)
    pdf_name = pdf_path.stem  # e.g., "report 1950"

    # Create output directories
    text_dir = Path(output_dir) / "ocr_text" / pdf_name
    text_dir.mkdir(parents=True, exist_ok=True)

    print(f"\n{'='*60}")
    print(f"Processing: {pdf_path.name}")
    print(f"Output:     {text_dir}")
    print(f"{'='*60}")

    # Convert PDF to images
    print(f"  Converting PDF to images at {dpi} DPI...")
    try:
        images = convert_from_path(str(pdf_path), dpi=dpi)
    except Exception as e:
        print(f"  ERROR converting PDF: {e}")
        return {"file": pdf_path.name, "pages": 0, "errors": [str(e)]}

    total_pages = len(images)
    print(f"  Total pages: {total_pages}")

    # Filter to requested pages
    if page_range:
        # page_range is 1-indexed
        selected = [(i, img) for i, img in enumerate(images, 1) if i in page_range]
        print(f"  Processing pages: {[p for p, _ in selected]}")
    else:
        selected = [(i, img) for i, img in enumerate(images, 1)]

    # Process each page
    results = []
    errors = []
    total_input_tokens = 0
    total_output_tokens = 0

    for page_num, image in selected:
        out_file = text_dir / f"page_{page_num:03d}.txt"

        # Skip if already processed (resume support)
        if out_file.exists() and out_file.stat().st_size > 0:
            print(f"  Page {page_num}/{total_pages}: already processed, skipping")
            results.append({"page": page_num, "status": "skipped"})
            continue

        print(f"  Page {page_num}/{total_pages}: sending to olmOCR...", end="", flush=True)

        # Convert to base64
        img_b64 = image_to_base64(image)

        # Call API
        t0 = time.time()
        response = call_olmocr(api_key, img_b64)
        elapsed = time.time() - t0

        if response["error"]:
            print(f" ERROR: {response['error']}")
            errors.append({"page": page_num, "error": response["error"]})
            # Write error marker so we know this page failed
            out_file.write_text(f"[OCR ERROR: {response['error']}]\n")
            results.append({"page": page_num, "status": "error", "error": response["error"]})
            continue

        # Save text
        text = response["text"]
        out_file.write_text(text, encoding="utf-8")

        usage = response["usage"]
        in_tok = usage.get("prompt_tokens", 0)
        out_tok = usage.get("completion_tokens", 0)
        total_input_tokens += in_tok
        total_output_tokens += out_tok

        text_preview = text[:60].replace("\n", " ")
        print(f" OK ({elapsed:.1f}s, {len(text)} chars) [{text_preview}...]")

        results.append({
            "page": page_num,
            "status": "ok",
            "chars": len(text),
            "time": elapsed,
            "input_tokens": in_tok,
            "output_tokens": out_tok,
        })

        # Small delay to be nice to the API
        time.sleep(0.3)

    # Write combined text file
    combined_path = text_dir / "_combined.txt"
    with open(combined_path, "w", encoding="utf-8") as f:
        for page_num in range(1, total_pages + 1):
            page_file = text_dir / f"page_{page_num:03d}.txt"
            if page_file.exists():
                f.write(f"\n{'='*40} PAGE {page_num} {'='*40}\n\n")
                f.write(page_file.read_text(encoding="utf-8"))
                f.write("\n")

    # Summary
    ok_count = sum(1 for r in results if r.get("status") == "ok")
    skip_count = sum(1 for r in results if r.get("status") == "skipped")
    err_count = sum(1 for r in results if r.get("status") == "error")

    summary = {
        "file": pdf_path.name,
        "total_pages": total_pages,
        "processed": ok_count,
        "skipped": skip_count,
        "errors": err_count,
        "total_input_tokens": total_input_tokens,
        "total_output_tokens": total_output_tokens,
    }

    print(f"\n  Summary: {ok_count} processed, {skip_count} skipped, {err_count} errors")
    print(f"  Tokens: {total_input_tokens} input, {total_output_tokens} output")

    # Save summary JSON
    summary_path = text_dir / "_summary.json"
    with open(summary_path, "w") as f:
        json.dump(summary, f, indent=2)

    return summary


def main():
    parser = argparse.ArgumentParser(
        description="OCR pipeline for Jones Refuge Reports using olmOCR via DeepInfra"
    )
    parser.add_argument("--reports-dir", required=True,
                        help="Directory containing the PDF report files")
    parser.add_argument("--output-dir", required=True,
                        help="Base output directory for OCR results")
    parser.add_argument("--api-key", default=None,
                        help="DeepInfra API key (or set DEEPINFRA_API_KEY env var)")
    parser.add_argument("--file", default=None,
                        help="Process a single file (filename only, not path)")
    parser.add_argument("--pages", default=None,
                        help="Page range to process, e.g. '10-15' or '1,5,10-20'")
    parser.add_argument("--dpi", type=int, default=DPI,
                        help=f"Scan resolution (default: {DPI})")
    parser.add_argument("--list", action="store_true",
                        help="List all PDF files and exit")

    args = parser.parse_args()

    reports_dir = Path(args.reports_dir)
    if not reports_dir.exists():
        sys.exit(f"ERROR: Reports directory not found: {reports_dir}")

    # List mode
    pdf_files = sorted(reports_dir.glob("*.pdf"), key=lambda p: p.name.lower())
    if not pdf_files:
        # Also try case-insensitive
        pdf_files = sorted(reports_dir.glob("*.PDF"), key=lambda p: p.name.lower())

    if args.list:
        print(f"Found {len(pdf_files)} PDF files in {reports_dir}:")
        for f in pdf_files:
            size_mb = f.stat().st_size / (1024 * 1024)
            print(f"  {f.name:40s} ({size_mb:.0f} MB)")
        return

    # Get API key
    api_key = args.api_key or os.environ.get("DEEPINFRA_API_KEY")
    if not api_key:
        sys.exit("ERROR: No API key. Use --api-key or set DEEPINFRA_API_KEY env var.")

    # Parse page range
    page_range = None
    if args.pages:
        page_range = parse_page_range(args.pages)

    # Select files to process
    if args.file:
        target = reports_dir / args.file
        if not target.exists():
            # Try case-insensitive match
            matches = [f for f in pdf_files if f.name.lower() == args.file.lower()]
            if matches:
                target = matches[0]
            else:
                sys.exit(f"ERROR: File not found: {target}")
        files_to_process = [target]
    else:
        files_to_process = pdf_files
        if page_range:
            print("WARNING: --pages is ignored when processing all files")
            page_range = None

    # Process
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    print(f"olmOCR Pipeline for Jones Refuge Reports")
    print(f"Reports: {reports_dir} ({len(files_to_process)} files)")
    print(f"Output:  {output_dir}")
    print(f"DPI:     {args.dpi}")
    if page_range:
        print(f"Pages:   {page_range}")

    all_summaries = []
    for pdf_file in files_to_process:
        summary = process_pdf(pdf_file, output_dir, api_key,
                              page_range=page_range, dpi=args.dpi)
        all_summaries.append(summary)

    # Final report
    print(f"\n{'='*60}")
    print(f"PIPELINE COMPLETE")
    print(f"{'='*60}")
    total_processed = sum(s.get("processed", 0) for s in all_summaries)
    total_errors = sum(s.get("errors", 0) for s in all_summaries)
    total_in = sum(s.get("total_input_tokens", 0) for s in all_summaries)
    total_out = sum(s.get("total_output_tokens", 0) for s in all_summaries)
    print(f"Files:     {len(all_summaries)}")
    print(f"Pages OK:  {total_processed}")
    print(f"Errors:    {total_errors}")
    print(f"Tokens:    {total_in:,} input, {total_out:,} output")

    # Save global summary
    global_summary_path = output_dir / "ocr_pipeline_summary.json"
    with open(global_summary_path, "w") as f:
        json.dump({"runs": all_summaries, "total_input_tokens": total_in,
                    "total_output_tokens": total_out}, f, indent=2)
    print(f"Summary:   {global_summary_path}")


if __name__ == "__main__":
    main()