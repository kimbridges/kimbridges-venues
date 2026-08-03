# Pilot Program Summary: Jones Refuge Narrative Reports Data Recovery

## Scope

Three reports processed from a corpus of 38 PDF files (1948-1974): - **1950** (66 pages, 196 MB) — early period, daily weather data - **1964** (60 pages, 42 MB) — mid period, monthly weather data - **1968** (42 pages, 18 MB) — late period, monthly weather with multi-year comparison

## Outputs Produced

### Weather Data

| Year | Records    | Granularity         | Confidence           |
|------|------------|---------------------|----------------------|
| 1950 | 243 daily  | Daily (Jan-Aug)     | 71% high, 29% medium |
| 1964 | 12 monthly | Monthly (full year) | 100% high            |
| 1968 | 12 monthly | Monthly (full year) | 100% high            |

### Black Brant Data

| Year | Records | Data Type | Confidence |
|----|----|----|----|
| 1950 | 10 | Narrative observations | 40% high, 40% medium, 20% low |
| 1964 | 31 | Structured census + narrative | 48% high, 52% medium |
| 1968 | 7 + 6 multi-year | Census totals + 6-year comparison | 71% high |

## Critical Findings

### 1. Tesseract OCR is Inadequate

Tesseract 4.1.1 produced garbled or empty output on all three reports. The combination of typewriter fonts, scan degradation, and paper aging defeated automated OCR entirely. **Vision-AI direct reading was the only viable method for data extraction.** This is the single most important finding for scaling up.

### 2. Weather Data Granularity Changes Over Time

-   **1948-\~1955**: Daily records from Air Force weather station at Thornbrough AFB
-   **\~1956-1974**: Monthly summaries from U.S. Weather Bureau

The schema must accommodate both. Additionally, the monthly format itself changed: - 1964: Rain, Sleet/Snow, Water Equiv, Temp (Max/Min/Avg), Wind (Max/Avg/Peak Gust) - 1968: Sleet/Snow, Water Equiv, Temp (Max/Min/Avg), Wind (Max/Avg) — no separate rain, no peak gust

### 3. Brant Data Quality Evolves Dramatically

-   **1950**: Almost entirely narrative. One specific count (25,000-30,000 residual). No census methodology.
-   **1964**: Systematic age-ratio census with telescope counts from multiple stations. 19,688 birds sampled. Population estimated at \~200,000.
-   **1968**: Mature census program. Multi-year comparison table (1963-1968) with 6 years of adult/juvenile/total/% data. This table is the single most valuable data product found in the pilot.

### 4. Internal Consistency Checks Are Essential

Math verification (Adult + Juvenile = Total, then % = Juv/Total) caught at least one OCR misread (Sept 17, 1964: "302" should be "320"). The 1968 multi-year table cross-validated the 1964 weather extraction perfectly (snow=52.5, water=26.51). However, the 1968 table's 1964 brant figures differ from the 1964 report's own figures, revealing that Jones may have revised his counts retrospectively.

### 5. Scan Quality Varies Systematically

| Period | MB/page | Quality | OCR Feasibility |
|----|----|----|----|
| 1948-1957 | 2.5-3.1 | Poor (high scan, degraded type) | Vision-AI only |
| 1958-1963 | 1.5-3.1 | Mixed | Vision-AI only |
| 1964-1974 | 0.3-0.9 | Good (clean scans) | Vision-AI primary, Tesseract marginal |

## Schema Recommendations for Full Corpus

### Weather

Maintain two parallel file types per year: 1. **Native format**: daily or monthly as found in source, with all available fields 2. **Harmonized monthly**: standardized columns for cross-year analysis

Minimum harmonized columns: year, month, temp_max_f, temp_min_f, temp_avg_f, precip_water_equiv_in, precip_snow_in

### Brant

The schema as designed accommodates the full range from narrative (1950) to structured census (1968). Key addition needed: a **summary table** that extracts one annual row per year with: total_census_count, pct_juvenile, estimated_population, first_arrival_date, peak_count_date, departure_date.

## Effort Estimate for Full Corpus

Based on pilot timing: - Weather: \~15 minutes per year (monthly) or \~45 minutes per year (daily) - Brant: \~20 minutes per year (narrative) to \~40 minutes per year (census tables) - Difficulties log: \~10 minutes per year

Estimated total for 38 documents: 25-35 hours of processing time. The multi-part years (e.g., 1959a/b/c) will add complexity.

## Recommended Next Steps

1.  **Process all remaining years**, working chronologically to track format changes
2.  **Build the annual summary table** as a master CSV spanning 1948-1974
3.  **Cross-validate** using the 1968 multi-year table and any similar retrospective tables in other reports
4.  **Create visualizations** once the full dataset is assembled
5.  **Determine the daily-to-monthly transition year** by examining reports from 1955-1958
