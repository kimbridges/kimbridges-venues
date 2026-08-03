# Difficulties Log: 1964

## Report files
- report 1964.pdf (60 pages, 42 MB)
- Coverage: January 1 - December 31, 1964

## Weather Data Recovery Summary

- Total monthly records recovered: 12
- All records: HIGH confidence
- Weather table: page 6
- Source: U.S. Weather Bureau

## CRITICAL FINDING: Data Granularity Change

**The 1964 weather data is monthly summaries, not daily records.**

In 1950, Jones reported daily weather observations from the Air Force weather station at Thornbrough AFB. By 1964, the report uses monthly climatological summaries from the U.S. Weather Bureau. This is a fundamentally different data granularity.

Key implications for the long-term dataset:

1. The weather CSV schema must accommodate both daily and monthly records
2. Two files are generated for 1964:
   - `weather_1964_monthly.csv` - Native format with full Weather Bureau fields (separate rain/snow/water equiv, wind data)
   - `weather_1964.csv` - Daily-schema-compatible summary for cross-year queries
3. When performing long-term analyses, the granularity must be harmonized to monthly before comparing across years
4. The 1964 monthly data includes wind information that 1950 daily data lacks

## Additional Weather Fields in 1964

The 1964 format separates precipitation into Rain, Sleet/Snow, and Water Equivalent. It also includes wind data (max, avg, peak gust in mph). The 1950 daily format had only prevailing character and total precipitation. This means the monthly format is actually richer in some dimensions.

## Scan Quality

The 1964 scan is notably cleaner than 1950 (0.7 MB/page vs 3.0 MB/page). The typewriter quality is better and the table formatting is very clear. All values were read with high confidence.

## Data Verification

The report includes an annual totals row which provides a built-in verification:
- Rain: calculated=20.47, reported=20.47 MATCH
- Snow: calculated=52.5, reported=52.5 MATCH
- Water equiv: calculated=26.51, reported=26.51 MATCH

## Anomalies Noted

1. October max temperature of 69F is the annual maximum - unusual for October in Cold Bay
2. November peak gust of 84 mph is the annual maximum
3. November snow of 16.2 inches is by far the heaviest snow month

## Black Brant Data Recovery

- Total records recovered: 31
- High confidence: 15
- Medium confidence: 16
- Low confidence: 0
- Source pages: 8-9 (migration), 12-13 (spring counts), 15-18 (census table)

### Key Findings

1. **Systematic census program**: By 1964, Jones had established a formal age-ratio census using telescope counts from multiple stations around Izembek Bay. This is a dramatic improvement over the narrative-only data in 1950.

2. **Total population estimate**: ~200,000 black brant using Izembek Range during fall staging.

3. **Spring migration data**: 98,000 counted on May 19 peak; 53,000 at ice edge May 28.

4. **Age-ratio table**: 19,688 birds sampled across Sept 17 - Nov 13. Overall 26.01% juvenile. Representative period (Sept 25 - Oct 27) showed 29.23% juvenile.

5. **Nesting ground comparison**: Only 2.3% juvenile in 2,064 brant at Clarence Rhode Range vs 23% in whole population - suggesting external recruitment.

### OCR/Reading Issues

1. **Operl Island**: Place name uncertain. Appears in census table as count station; may be a local name not found on standard maps. Need to verify against other Jones reports.

2. **Sept 17 juvenile count**: Image appears to show 302 but math verification (Adult + Juv = Total) requires 320. Entered as 320 with the math-verified total of 2226 and %Juv of 14.38. This demonstrates the value of internal consistency checks.

3. **Grand total discrepancy**: Sum of Adult (14,548) + Juv (5,122) = 19,670, but report states total of 19,688 (difference of 18). Minor but noted.

4. **Oct 23 Applegate Cove total**: Difficult to read; entered as 2618 but uncertain. Math check with %Juv would resolve.

5. **Page 18 summary figures**: The representative-period subtotals are partially obscured. Entered best reading with medium confidence.

### Data Structure Evolution

The 1964 brant data is fundamentally different from 1950:
- 1950: 10 narrative observations, 1 specific count (25,000-30,000 residual)
- 1964: 30+ structured census records with adult/juvenile breakdowns, population estimates, spring and fall data, and nesting ground comparisons

This evolution in data quality and quantity must be accounted for in any long-term trend analysis. Pre-census years (roughly 1948-1955) will have sparse, narrative data; census years (roughly 1956+) will have structured counts.
