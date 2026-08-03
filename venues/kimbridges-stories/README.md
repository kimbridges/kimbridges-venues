# kimbridges-stories

Stories site for [kimbridges-stories.netlify.app](https://kimbridges-stories.netlify.app)

## Folder Structure

```
kimbridges-stories/
├── _quarto.yml              # Quarto site configuration
├── _site/                   # Rendered site (output of quarto render)
├── index.qmd                # Home page / stories grid listing
├── custom.css               # Card thumbnail styling
├── viewer.html              # PDF.js flipbook viewer
├── stories_inventory_v2.xlsx # Master spreadsheet — source of truth
├── add_stories.py           # Script to generate .qmd files and thumbnails
├── update_stories_qmd.py    # Script to update existing .qmd files from spreadsheet
├── pdfs/                    # Published story PDFs
├── images/                  # Thumbnail JPGs (first page of each PDF)
├── stories/                 # .qmd files (one per story)
├── updates/                 # Staging area for new PDFs before processing
└── underway/                # PDFs still being worked on (not yet ready)
```

## Adding New Stories

1. **Build the PDF** (typically in InDesign) and place it in `updates/`.

2. **Add a row to `stories_inventory_v2.xlsx`** with:
   - Title, Pages, Category (slash-separated, e.g. "Travel / Japan / Asia")
   - Card Subtitle (short, shown on grid cards, max ~90 characters)
   - Full Description (longer, shown on the story page)
   - PDF Filename (must match the filename in `updates/` exactly)

3. **Run the add script** from a command prompt in this folder:
   ```
   python add_stories.py --dry-run    # preview what will happen
   python add_stories.py              # generate thumbnails, create .qmd files, move PDFs
   ```
   The script will:
   - Generate a thumbnail (first page → JPG) in `images/`
   - Create a `.qmd` file in `stories/` using the spreadsheet metadata
   - Move the PDF from `updates/` to `pdfs/`

4. **Render the site:**
   ```
   quarto render
   ```

5. **Deploy to Netlify:**
   - Go to https://app.netlify.com/projects/kimbridges-stories/deploys
   - Drag and drop the `_site` folder onto the deploy drop zone

## Updating Existing Stories

To update subtitles or descriptions for existing stories from the spreadsheet:

```
python update_stories_qmd.py
```

Then re-render and deploy (steps 4–5 above).

## Notes

- The `underway/` folder holds PDFs that need further editing before they are ready. Move them to `updates/` when complete.
- Thumbnails are generated at 150 DPI from the first page of each PDF.
- Card subtitles are truncated to 90 characters on the grid cards; the full description appears on the story page.
- The site uses a custom PDF.js viewer (`viewer.html`) with two-page spread display.
- Categories in the spreadsheet use slash separators (e.g. "Travel / Food / Japan") which become Quarto category tags for filtering.
