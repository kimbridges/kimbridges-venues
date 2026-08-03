# Black Brant Data Schema

## Source
Robert D. Jones Jr., Refuge Narrative Reports, Cold Bay / Aleutian Islands NWR / Izembek NWR

## File naming
brant_YYYY.csv (one file per report year)

## Columns

| Column | Type | Units | Description |
|--------|------|-------|-------------|
| year | integer | | Calendar year of observation |
| month | integer | 1-12 | Month of observation |
| day | integer | 1-31 | Day (if specific date given; NA for period summaries) |
| date | string | YYYY-MM-DD | ISO date (constructed; NA for ranges) |
| date_start | string | YYYY-MM-DD | Start of observation period (for range observations) |
| date_end | string | YYYY-MM-DD | End of observation period (for range observations) |
| location | string | | Location name (Izembek Bay, Izembek Lagoon, Cold Bay, Moffet Lagoon, etc.) |
| count | integer | | Number of birds observed/estimated |
| count_type | string | | One of: census, estimate, survey, sample, banding_total, recovery |
| method | string | | Observation method: aerial, ground, boat, telescope, visual_estimate |
| age_class | string | | adult, juvenile, mixed, unknown |
| pct_juvenile | numeric | percent | Percentage of juveniles in sample (from age-ratio studies) |
| sample_size | integer | | Sample size for age-ratio observations |
| activity | string | | What birds were doing: staging, migrating, feeding, nesting, molting |
| direction | string | | Migration direction if applicable: arriving, departing, N, S, E, W |
| banding_new | integer | | Number of new birds banded (banding events only) |
| banding_recapture | integer | | Number of recaptured banded birds |
| band_recoveries | integer | | Number of band recoveries reported |
| source_page | integer | | PDF page number in source file |
| ocr_confidence | string | high/medium/low | Assessment of OCR reliability |
| notes | string | | Context, corrections, ambiguities, original wording if unclear |

## Conventions
- Counts may be exact (census) or estimated; count_type distinguishes these
- Jones began systematic age-ratio studies of brant around 1963; earlier years have less structured data
- Location names standardized to: Izembek Lagoon, Izembek Bay, Cold Bay, Moffet Lagoon, Applegate Cove, Kinzarof Lagoon, Grant Point, other (specify in notes)
- When Jones gives a range (e.g., "3,000-5,000"), record the midpoint in count and note the range in notes
- Multiple observations on the same date at different locations get separate rows
- Narrative observations (e.g., "brant began arriving in late September") recorded with best date estimate and notes field preserving original language
