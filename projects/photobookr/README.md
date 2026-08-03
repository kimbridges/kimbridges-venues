# photobookr

Create photo books that integrate text chapters with images. Images are matched to chapters via EXIF metadata tags, with support for two-page spreads, custom fonts, and interactive maps.

## Installation

```r
# Install from GitHub
devtools::install_github("kimbridges/photobookr")

# First-time setup (installs ExifTool and TinyTeX)
library(photobookr)
photobookr_setup()
```

## Quick Start

### 1. Set up your project folder

```
my_photo_book/
├── config.yaml          # Configuration file
├── cover.pdf            # Optional cover page
├── book_text.md         # Your narrative (markdown)
├── Images/              # Photos with EXIF metadata
│   ├── photo1.jpg
│   ├── panorama_2W.jpg  # _2W suffix = two-page spread
│   └── ...
└── Stories/             # Generated chapter PDFs
```

### 2. Create a config file

```r
library(photobookr)
photobookr_example_config()  # Creates config.yaml template
```

### 3. Write your chapters in markdown

```markdown
## Paris

Our journey began in the City of Light...

### The Eiffel Tower

We visited on a cloudy morning...

## Amsterdam

The canals were beautiful...
```

Each `## Header` becomes a chapter. The header text matches images via their EXIF Event tag.

### 4. Set image metadata

```r
# Extract current metadata to CSV
metadata_to_csv("Images", proof_format = "both")

# Edit metadata.csv (use proof sheet for reference)
# Set Event = "Paris" for Paris photos, etc.

# Apply changes back to images
csv_to_metadata("metadata.csv", "Images")
```

### 5. Build the book

```r
# Generate chapter PDFs from markdown
markdown_to_chapters("book_text.md", body_size = 17, font_family = "helvetica")

# Assemble the book
build_book()
```

## Main Functions

| Function | Purpose |
|----------|---------|
| `photobookr_setup()` | Install required external tools |
| `photobookr_example_config()` | Create a template config.yaml |
| `metadata_to_csv()` | Extract image metadata to spreadsheet |
| `csv_to_metadata()` | Write edited metadata back to images |
| `markdown_to_chapters()` | Convert markdown to chapter PDFs |
| `build_book()` | Assemble chapters and images into final PDF |
| `build_map()` | Create interactive map of photo locations |

## Configuration (config.yaml)

```yaml
book_name: "My Photo Book"
output_pdf: "Photo_Book.pdf"
cover_file: "cover.pdf"        # Optional

folders:
  stories: "Stories"           # Chapter PDFs
  images: "Images"             # Source images
  kml: "KML"                   # Generated KML files

spread:
  suffix: "_2W"                # Images ending with this span two pages

verification:
  enabled: true
  output_file: "Photo_Book_verification.pdf"

map:
  output_file: "Photo_Book_map.html"
```

## Two-Page Spreads

For panoramic or wide landscape images, add `_2W` before the file extension:

- `sunset.jpg` → single page
- `sunset_2W.jpg` → two-page spread

The suffix is configurable in config.yaml.

## Font Options for Chapters

```r
markdown_to_chapters("book.md", 
                     body_size = 17,        # 10, 11, 12, 14, 17, or 20
                     font_family = "helvetica")  # or palatino, charter, default
```

For phone/tablet viewing, 17pt helvetica works well.

## Workflow Options

**Option A: Markdown-driven** (recommended)
1. Write all text in one markdown file
2. Run `markdown_to_chapters()` to generate PDFs
3. Run `build_book()` to assemble

**Option B: Manual PDFs**
1. Create chapter PDFs manually (Google Docs, etc.)
2. Name them with numeric prefixes: `01_paris.pdf`, `02_amsterdam.pdf`
3. Place in Stories folder
4. Run `build_book()` to assemble

Both approaches use the same book assembly engine.

## License

MIT
