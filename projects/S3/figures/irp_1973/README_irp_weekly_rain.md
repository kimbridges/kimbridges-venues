# IRP weekly rain, January 1971 to June 1975 (transcribed 2026-11-27)

Sources (Kim's copies, scanned): Bridges, K. W. and G. V. Carey. Island Ecosystems IRP, U.S. International Biological
Program. Technical Report 22, Supplement 1 (1971-72 data; 'Climate data for the IBP sites on Mauna Loa'),
Technical Report 38 (May 1974; 1973), Technical Report 59 (April 1975; 1974), Technical Report 70 (August 1975;
January-June 1975). Tables "Weekly rain record in mm".

Sites (Kim): K54 = Kilauea Rain Forest site (Kilauea Forest Reserve on Mauna Loa's windward flank), 5,400 ft, away from
the main transect; M42, M54, M66 = Mauna Loa (Strip) Road transect (TR22 S1 annual-rain figure plots them at about
4,200, 5,250 and 6,700 ft). M42 and M66 begin 1971-10-25.

Gauges: K54 and M54: 2 Tru-Check + 1 standard + 4 metric until 1971-03-01, then 11 + 1 + 4. M42: standard gauge only.
M66: one Tru-Check gauge 1971-10-25 to 1972-05-29, standard gauge from 1972-06-05.

File irp_weekly_rain_1971_1975.csv: site, date (YYMMDD collection date; usually 7-day intervals, some records span
2-3 weeks), am (standard gauge mm), tru, met (means of Tru-Check and metric gauges), overall (mean of all gauges,
K54 and M54), ntru and nmet (gauge counts), source, note (flags).

Checks
- Every multi-gauge row (364) satisfies overall = (ntru*tru + am + nmet*met)/(ntru+1+nmet) within rounding; the check
  caught 9 misreads, each corrected from the page image.
- Annual totals match the reports' own figures: 1972 K54 1,740 and M54 1,274 (overall), M42 1,459, M66 1,151;
  1973 M42 1,391, M66 1,657, K54 1,588 (overall); 1974 K54 1,989, M54 1,185 (overall), M42 1,777, M66 1,346.
- Overflow: Tru-Check gauges cap at 152.4 mm (6 in), metric at 231.0 mm; in the largest storm weeks every one of
  them read its cap, so the overall mean understates those weeks. The standard gauge did not overflow.
- Between storms the standard gauge and the gauge mean differ systematically, in opposite directions at the two
  sites (1973-75: M54 standard +27%, K54 standard -9% relative to the mean).
- Flags in 'note': K54 730312 and 750106 standard-gauge faults; M66 duplicate printed date (July 1972).
