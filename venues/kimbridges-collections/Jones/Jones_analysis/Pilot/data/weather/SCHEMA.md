# Weather Data Schema

## Source
Robert D. Jones Jr., Refuge Narrative Reports, Cold Bay / Aleutian Islands NWR / Izembek NWR
Data from Air Force weather station at Thornbrough Air Force Base, Cold Bay, Alaska

## File naming
weather_YYYY.csv (one file per report year)

## Columns

| Column | Type | Units | Description |
|--------|------|-------|-------------|
| year | integer | | Calendar year |
| month | integer | 1-12 | Month |
| day | integer | 1-31 | Day of month |
| date | string | YYYY-MM-DD | ISO date (constructed) |
| temp_max_f | numeric | degrees F | Maximum temperature |
| temp_min_f | numeric | degrees F | Minimum temperature |
| precip_type | string | | Prevailing character: Rain, Snow, Drizzle, Rain & Drizzle, Snow Showers, Blowing Snow, etc. Use "--" for no observation |
| precip_total_in | numeric | inches | Total precipitation. Use 0 for none, NA for missing. "Trace" recorded as 0.001 |
| snow_on_ground_in | numeric | inches | Snow depth on ground. "Trace" recorded as 0.001 |
| source_page | integer | | PDF page number in source file |
| ocr_confidence | string | high/medium/low | Assessment of OCR reliability for this row |
| notes | string | | Any anomalies, corrections, or ambiguities |

## Conventions
- "Trace" precipitation or snow: encoded as 0.001 to distinguish from 0 (none) and NA (missing)
- Ditto marks in original: resolved to the value being repeated
- Missing data: NA
- Temperature values occasionally illegible due to scan quality; flagged in notes
- Source station: Thornbrough AFB / Cold Bay Airport (consistent across all years)
