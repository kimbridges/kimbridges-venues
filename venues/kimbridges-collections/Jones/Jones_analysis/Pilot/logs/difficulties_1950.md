# Difficulties Log: 1950

## Report files
- report 1950.pdf (66 pages, 196 MB)
- Coverage: January 1 - August 31, 1950

## Weather Data Recovery Summary

- Total daily records recovered: 243
- High confidence: 173 (71%)
- Medium confidence: 70 (29%)
- Low confidence: 0 (0%)
- Weather pages: 10-15 (6 pages)

## OCR Method

Tesseract 4.1.1 was run first but produced garbled/empty output on all weather table pages. The typewriter font combined with scan degradation and paper aging defeated automated OCR entirely. All weather data was recovered via direct visual reading of 300dpi page images (vision-AI method). This is a critical finding for scaling to the full 38-document corpus.

## Systemic Issues

1. **Typewriter ribbon degradation**: Earlier months (Jan-Feb) show more character degradation than later months, suggesting the typewriter ribbon was changed or the scanning quality varies.
2. **Ditto marks**: The original report uses '--' for clear/no-precipitation days. In some cases it is ambiguous whether '--' means 'same as above' or 'no data'.
3. **Punch holes**: Three-hole punch marks on left margin occasionally obscure data in the Date and Max temperature columns.
4. **Decimal points**: Typewriter period characters are sometimes indistinguishable from scan artifacts, making temperatures like '40.1' vs '40 1' ambiguous.
5. **Scan edge clipping**: Left margin of several pages is slightly clipped.

## Page-by-Page Notes

### Page 10 (January)
Page 10 (January): Left margin partially obscured by scan edge and punch holes. Days 1, 12-13, 16, 18 have uncertain readings. Day 18 max of 47.4F is anomalously high; may be a misread of 37.4F. Precip column alignment varies row-to-row making some totals uncertain.

### Page 11 (February)
Page 11 (February): Day 11-12 show sharp temperature drop (Min 10F); values verified from image but unusual. Day 21 precipitation type difficult to read - appears to say 'Water Showers' but this is likely 'Snow Showers'. Snow on ground column shows Trace for days 11-17 approximately.

### Pages 11-12 (March)
Pages 11-12 (March): Table spans page break. Day 5 shows snow_on_ground=8 inches which seems like a large jump; may be misread. Day 8 precip total uncertain between .20 and .30.

### Page 12 (April)
Page 12 (April): Day 11 precipitation type is hard to read. Day 20 and 27 precip totals uncertain. Snow on ground shows Trace for late month.

### Pages 12-13 (May)
Pages 12-13 (May): Table spans page break. Day 30-31 appear to have identical values; the second row may be using ditto marks that were read as the same values. Day 30 Min of 40.1 is unusually close to Max of 43.4.

### Page 13 (June)
Page 13 (June): Generally clearer than January pages. Day 8 precip total uncertain - .41 seems high for a single day but possible for Cold Bay. Several precip totals in the .09-.20 range are partially obscured.

### Page 14 (July)
Page 14 (July): Clearer scan than earlier months. Day 28 precip total of .23 may be misread as .03. Highest temps of year in this month (56F on day 17).

### Pages 14-15 (August)
Pages 14-15 (August): Generally good quality. Table spans page break. Day 12 precip of 1.30 inches is the highest daily total in the record. Day 19 Min of 47.7 seems high but plausible for August. Page 15 also contains a note: 'The snow on the ground reading in mile at 0035.'

## Black Brant Data Status

Black brant data extraction pending - see separate processing step.

## Recommendations for Second Pass

1. All 'medium confidence' temperature readings should be verified against climatological norms for Cold Bay (NOAA historical records)
2. Day 18 January (47.4F max) should be cross-checked; likely a misread
3. Precipitation totals in the .01-.10 range are the most uncertain category
4. February temperature records should be checked against known Cold Bay cold events for 1950

## Black Brant Data Recovery

- Total records recovered: 10
- High confidence: 4
- Medium confidence: 4
- Low confidence: 2
- Source pages: 42-45

### Key Issues

1. The 1950 report represents Jones's first full year at the refuge. Black brant data is almost entirely narrative with very few specific counts. The main quantitative data point is the estimated 25,000-30,000 residual brant after the first major departure in mid-October. No systematic census or age-ratio data was collected this year.

2. '750 were gone by the 20th of November' - This is the most problematic reading. The '750' could be: (a) literally 750 birds remaining, (b) 75% of birds departed (percent sign unclear), or (c) a garbled reading of another figure. Context suggests percentage is most likely.

3. The departure date 'by the 12th all were gone' lacks a clear month reference. The preceding text discusses November events. This could be November 12 or December 12. Assigned Dec 12 based on the phrase 'much later than the year previously' but this needs verification against the 1949 report.

4. No total population estimate is given for 1950. Jones describes the concentration as covering 'a 30 mile long water area in Izembek and Moffet Bay' but provides no numerical estimate of the total staging population. Later years provide census-based estimates.

