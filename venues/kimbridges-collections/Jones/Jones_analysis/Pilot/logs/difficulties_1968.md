# Difficulties Log: 1968

## Report files
- report 1968.pdf (42 pages, 18 MB)
- Coverage: January 1 - December 31, 1968

## Weather Data Recovery

- Records: 12 monthly summaries
- All HIGH confidence (clean Weather Bureau tabulation)
- Source: U.S. Weather Bureau, page 5

### Weather Format Differences from 1964

The 1968 weather table differs from 1964 in two ways:

1. **No separate Rain column**: 1964 had Rain, Sleet/Snow, and Water Equiv. 1968 has only Sleet/Snow and Water Equiv. Rain must be inferred as Water_Equiv minus Snow_Water_Equiv during non-snow months.
2. **No Peak Gust**: 1964 had Wind Max, Avg, and Peak Gust. 1968 has only Wind Max and Avg.

This means the monthly weather schema must use the intersection of columns common across all years, or carry year-specific nullable fields.

### Built-in Verification

The 1968 table includes comparison rows for 1964-1967. The 1964 comparison row matches our independently extracted 1964 data exactly (snow=52.5, water=26.51), providing cross-validation of both extractions.

### Notable Weather

- February min of -1F (coldest in 5-year comparison)
- July max of 72F (warmest in 5-year comparison)
- Total snow of 61.7 inches (second highest in 5 years; 1965 had 76.3)

## Black Brant Data Recovery

- Annual records: 7
- Multi-year comparison table: 6 years (1963-1968)
- High confidence: 5, Medium: 2

### Key Findings

1. **Multi-year table (Table 1)**: Provides 6-year comparison of age-ratio counts. This is the single most valuable data table encountered in the pilot, as it provides a retrospective summary that can cross-validate data from individual year reports.

2. **1964 data discrepancy**: Table 1 in the 1968 report lists the 1964 census as Adults=10,727, Juv=4,532, Total=15,259, %Juv=29.21. However, the 1964 report itself (page 17) gave grand totals of Adults=14,548, Juv=5,122, Total=19,688, %Juv=26.01. The 1968 table likely uses the 'representative period' subset (Sept 25-Oct 27) rather than the full-season grand total, but even those numbers differ slightly from page 18 of the 1964 report. This discrepancy needs resolution.

3. **1966 anomaly**: 40.3% juvenile is exceptionally high. Jones discusses this in the context of reproductive success variability but the number stands out.

4. **Population estimate context**: Sept 3 estimate of 150,000 brant in Izembek Lagoon vs. the census sample of 21,278 = roughly 14% sample rate, consistent with Jones's earlier claim of ~10% sampling.

5. **Migration route observation**: May 31 sighting of brant arriving from open sea at Ohio Point rather than following the coast is a significant ecological observation.

### OCR Notes

The 1968 scans are the cleanest of the three pilot years (0.4 MB/page vs 3.0 for 1950). All text is clearly legible. Tesseract OCR was still poor but the vision-AI reading encountered no significant difficulties.

### Multi-year Table Math Verification

- 1963: 3859+1243=5102 (report: 5012) [OFF by 90]. Calc %Juv=24.8 (report: 23)
- 1964: 10727+4532=15259 (report: 15259) [OK]. Calc %Juv=29.7 (report: 29.21)
- 1965: 26796+7262=34058 (report: 34058) [OK]. Calc %Juv=21.3 (report: 21.3)
- 1966: 12647+8587=21234 (report: 21234) [OK]. Calc %Juv=40.4 (report: 40.3)
- 1967: 15964+3398=19362 (report: 19362) [OK]. Calc %Juv=17.5 (report: 17.5)
- 1968: 17537+3741=21278 (report: 21278) [OK]. Calc %Juv=17.6 (report: 17.6)
