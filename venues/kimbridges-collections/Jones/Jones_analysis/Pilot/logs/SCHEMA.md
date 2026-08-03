# Difficulties Log Schema

## File naming
difficulties_YYYY.md (one file per report year)

## Structure

Each log entry records:

### Header
- Report file(s): which PDF file(s) cover this year
- Pages processed: total page count
- Date range covered by report

### Summary statistics
- Total weather records recovered
- Total brant records recovered
- Pages with OCR difficulties (count and percentage)
- Overall quality assessment

### Issue categories

#### 1. OCR Failures
- Page number, region description
- What was illegible or misread
- How resolved (visual inspection, context inference, left as NA)
- Confidence in resolution

#### 2. Structural Ambiguities
- Ditto marks that were ambiguous
- Table alignment issues (columns shifted in scan)
- Page breaks splitting data rows

#### 3. Data Interpretation Issues
- Unclear units or abbreviations
- Contradictory values (e.g., temp max < temp min)
- Values outside plausible range for Cold Bay climate
- Narrative counts that are ambiguous (does "several thousand" mean 2000? 5000?)

#### 4. Missing Data
- Gaps in weather record and likely cause (station down, report gap, page missing)
- Periods with no brant observations and likely reason (seasonal, off-refuge)

#### 5. Source Document Issues
- Missing pages, out-of-order pages
- Photographs or maps blocking text
- Handwritten annotations
- Damaged/stained areas
