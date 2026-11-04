# MRC verify list
_Consolidated 2026-11-03 from ideas_three_documents.md (rounds 2-5) and chapter notes. Status: OPEN / CONFIRMED / CORRECTED / UNCLEAR, with source._

## A. Data and figures (checked by Claude in R)
- [x] Eugene precipitation shift -- **LIKELY INSTRUMENTAL, NOT CLIMATE (2026-11-03).** Compared with Salem (USW00024232) and
  Corvallis (USC00351862), GHCN-Daily: period means Eugene 107 / 131 / 91 cm (1940-69 / 1970-99 / 2000-25) vs Salem 104 / 103 / 98
  and Corvallis 99 / 113 / 106. Eugene / neighbour ratio drifts UP from ~1.0 (1950s) to 1.42 (1990-94), then STEPS DOWN to
  1.0 (1995-99) and ~0.9 since. Timing fits an instrument change at the airport in the mid-1990s (automated station?) --
  verify Eugene ASOS commissioning date. Consequence: Eugene's strip in ch07_fig1 shows a GAUGE, not a forest under stress.
  (An MRC lesson in itself: the category changed because the measuring operation changed -- Bridgman; and S3's 'a changing
  network breaks a baseline'.)
- [x] WBGT approximation vs Japan MOE -- **CORRECTION NEEDED (2026-11-03).** MOE API (getSurveyData; needs a browser
  user-agent) gives MEASURED hourly WBGT for Tokyo 44132 (Koishikawa); Haneda is not a WBGT point. Saved:
  data/moe_wbgt_tokyo44132_JunSep_2021_2025.csv. Same 610 days: daily-max WBGT MOE mean 28.8 vs our BoM approx (Haneda)
  31.9; r = 0.92 but the approx runs ~3 C HIGH (median; 10-90%: 1.4-4.9). 'Danger' days: official 223 vs approx 391;
  'Almost safe' days: official 13 vs approx 0. (Different sites: coastal airport vs botanical garden.) The ch07_fig2
  WBGT panel overstates. Kim's point survives with official data: same Tokyo summers -- US heat index 'Danger' 162 days,
  Japan WBGT 'Danger' 223; heat index 'below 80' 143 days vs WBGT 'Almost safe' 13.
- [~] NWS heat index limits -- commonly published Caution 80-90, Extreme caution 90-103, Danger 103-124, Extreme danger 125+ F (NWS chart is an
  image; sources differ by a degree at the edges, e.g. 91-103 / 126+). Figure uses 80/90/103/125. Rothfusz regression standard (NWS).
- [x] 2013 UK stamp duty -- CONFIRMED (gov.uk, rates 25 Mar 2012-23 Mar 2014): 0% to 125,000; 1% 125,001-250,000; 3% 250,001-500,000; 4%; 5%; 7%;
  charged 'on the whole amount' (slab). Slab system ended 4 Dec 2014. Note: 125,000 = 0% -> 1% (+1,250); 250,000 = 1% -> 3% (2,500 -> 7,500+).
- [x] Age thresholds -- Tobacco 21 federal law 20 Dec 2019 (CONFIRMED); RMD 70.5 to 2019, 72 from 2020, 73 from 2023, 75 from 2033 (CONFIRMED, Ascensus;
  note a drafting error leaves people born in 1959 with both 73 and 75); drinking age 1984, ACA age 26 (2010), Medicare 1965, 26th Amendment 1971 --
  standard dates, not re-fetched; Social Security dates CONFIRMED earlier (CRS).
- [ ] Saffir-Simpson category limits (mph) (ch08_fig1)
- [x] Heat deaths -- **CORRECTED with official data:** Tokyo Medical Examiner's Office, 23 wards, summer 2024 (Jun-Sep, final): **306** heatstroke deaths
  (July **199** -- the 123 reported in early August was a preliminary count; Aug 90); 291 of 306 INDOORS; of the indoor dead, 63.6% had an air
  conditioner but were not using it, 22.0% had none; 227 of 291 lived alone. Earlier summers: 239 (2020), 58 (2021), 251 (2022), 192 (2023).
  Source: hokeniryo.metro.tokyo.lg.jp r6fixed-heatstroke_20250526.pdf. Maricopa 602 (2024), 645 (2023) as before.

## B. Facts for the text (research helpers)
- 38.0 C fever threshold; 2017 ACC/AHA hypertension 130/80
- Metrology guard bands (ILAC G8, JCGM 106)
- Beaufort: original sail-based definitions; change to wind speed
- Alps 4000ers: 82 (UIAA)
- USDA soil texture classes (12); Braun-Blanquet classes (r, +, 1-5)
- Acclimatization to heat/cold; 'thin blood' as Hawai'i usage
- Civil twilight duration by latitude; ~60.5 N all-night civil twilight
- Headlight statutes ('30 minutes after sunset'); hunting hours; 14 CFR 1.1 'night'
- Hawai'i DST exemption (Uniform Time Act 1966)
- NWS local criteria for wind chill / heat advisories
- Kona 'coffee vacation': years, scope, months
- Origin of the summer school break (agrarian myth vs heat/urban)
- Hawaiian surf scale; NWS Honolulu move to face height (when, why)
- Hawaiian wind names (Wind Gourd of La'amaomao); Hanau ka Ua (done)
- Boas 1911; Pullum 1989; Winawer et al. 2007; Berlin & Kay 1969; Berlin 1992
- Hokule'a: Mau Piailug (Satawal), 1976 voyage, PVS 1973, Nainoa Thompson's star compass, Sharp 1956, Ben Finney's role, Alingano Maisu as a gift to Mau
- Anthropocene GSSP rejection (2024)
- Smudge pots: later restricted for air pollution; wind machines; California frost-warning service
- Hat sizes: US = circumference / pi; UK ~1/8 smaller; EU = cm
- JIS men's sizing; ready-to-wear sizing history
- NWS hazard simplification -- current status; Japan heat-stroke alert thresholds (WBGT 33 / 35?)
- Saffir-Simpson 2010 change to wind only; 'Category 6' proposal (2024)
- JMA special warnings (2013); Hawai'i tsunami tiers
- Zone System (Adams & Archer, ~11 zones, ~1940)
- Raunkiaer life forms (classes, single trait, biological spectrum)
- APG IV family count
- DMV road-test scoring: critical driving error = fail (California)
- Attwood et al. 2012 (curved glasses); Wansink 2005 BMJ bartender study status
- Fuel gauges deliberately non-linear
- Newton's seven rainbow colours (musical analogy)
- Allen, Dechow, Pope & Wu (marathon bunching, 9.5 million times) (done); NY Regents bunching at 65 (Dee et al. 2019)

## C. Ask Kim
- [x] Item statistic -- ANSWERED: 'Item Analysis' with reliability (UH ITS/MIS OMR form, Report 5/6; Kim's kept form). See ch06_argument.md.

## B1. Results -- research batch 1 (2026-11-03)
- CONFIRMED: fever 38.0 C / 100.4 F (CDC); 2017 ACC/AHA 130/80 (ACC press release); guard bands JCGM 106:2012 + ILAC G8; Alps 82 4000ers (UIAA 1994);
  USDA 12 texture classes (NRCS SSM ch.3); Braun-Blanquet r,+,1-5 (r >0-0.1%, + 0.1-1%, 1 1-5%, 2 5-25%, 3 25-50%, 4 50-75%, 5 75-100%; caveat: Dengler &
  Dembicz 2023 -- B-B never published the pure-cover 7-step form; 9-step variant splits 2 into 2m/2a/2b);
  civil twilight: equator ~21 min, ~40 N ~28 min, ~60 N ~43 min at equinox; all-night civil twilight 60 deg 33 min N to polar circle (timeanddate);
  headlights '30 minutes after sunset' e.g. Vermont 23 VSA 1243 (~26 states + DC incl. Hawai'i -- secondary count); 14 CFR 1.1 night = civil twilight;
  Hawai'i opted out of DST 1967 (Act 4, SLH 1967); summer break agrarian myth (Kenneth Gold, School's In); Wind Gourd of La'amaomao (Nakuina 1902;
  English 1992 -- check translator credit); Boas 1911, Pullum 1989 NLLT 7:275-281, Winawer et al. 2007 PNAS 104:7780-7785, Berlin & Kay 1969,
  Berlin 1992 (Princeton); Newton's seven colours (orange and indigo added as 'semitones'; Opticks 1704).
- CORRECTED: Beaufort 1805 = SAILS ONLY (not sea state; sea-state wording 1874 or 1916); wind-speed equivalents Simpson 1906 (Met Office), IMC 1926,
  IMC 1946 (not WMO -- WMO dates from 1950) (KNMI). Kona coffee vacation 1932-1969 (ended with four-quarter calendar, Sept 1969); 1935 Legislature
  recognised the 'Konawaena Coffee Vacation Plan'; mostly tied to KONAWAENA School; months vary by source (Aug-Oct / mid-Aug-early Nov / Sep-Nov).
- ADDED: NWS Honolulu switched to full-face surf heights on 9 April 2001 (safety, standardisation; Star-Bulletin 2001-03-31); Hawaiian scale ~half
  the face height for moderate surf (Caldwell).
- Sources disagree: Beaufort dates; Kona months/scope/end year (Wikipedia 1966 vs others 1969); headlight state count.

## B2. Results -- research batch 2 (2026-11-03)
- CONFIRMED: PVS 1973 (Finney first president; with Kane, Holmes); 1976 voyage navigated by Mau Piailug of Satawal (captain Kawika Kapahulehua);
  Nainoa Thompson's Hawaiian star compass BASED ON Mau's Micronesian compass; Sharp 1956 accidental settlement. Finney's role on board: UNCLEAR.
  Anthropocene: SQS voted it down (4-12-3, Feb-Mar 2024); ICS and IUGS UPHELD (say 'upheld', not 'voted'). Hat sizes: US = circumference/pi,
  nearest 1/8; UK 1/8 smaller; EU = cm (definitions vary). Japan Heat Stroke Alert: forecast daily-max WBGT >= 33 at any station in the area;
  Special alert (from 24 Apr 2024): ALL stations in a prefecture >= 35, issued the day before. Saffir-Simpson wind-only 2010; 2012 limits
  74-95 / 96-110 / 111-129 / 130-156 / 157+ mph (figure correct); 'Category 6' >192 mph hypothetical (Wehner & Kossin 2024, not a proposal).
  JMA Emergency Warnings 30 Aug 2013; US tsunami tiers Warning/Advisory/Watch/Information Statement. Zone System: Adams & Archer, Art Center
  School LA, 1939-40; 11 zones one stop apart. Raunkiaer 1904 talk / 1907 Danish / 1934 English; biological spectrum reflects climate.
  APG IV 64 orders, 416 families. CA DMV: any critical driving error fails; >15 errors fails (DL 955). Attwood et al. 2012 PLoS ONE 7:e43007
  (lager ~60% slower from straight glass; no effect with soft drink or half-full glass). Fuel gauges deliberately calibrated with a 'full
  reserve' and fuel below E (Ford engineer, Autoblog) -- though some say it is just tank geometry (both apply: martini glass = geometry).
  Regents: Dee et al. 2019 AEJ:Applied 11(3):382-423 -- bunching above 65 AND 55; ~40% of scores just below a cutoff raised by teachers
  grading their own school's students; bunching largely VANISHED after re-scoring ended (2011) and grading was centralized (2012-13).
- CORRECTED: Alingano Maisu built at Kawaihae (Na Kalai Wa'a) as a gift to Mau; sailed with Hokule'a through Micronesia to Palau 2007, then
  returned to Yap and stayed with Mau -- it did NOT go to Japan. Frost warnings: FEDERAL (U.S. Weather Bureau Fruit Frost Service, broadcast
  evenings on KNX, later KFI; began 1918 or 1922; ended 1996). Smudging restricted GRADUALLY (1947 state law, 1950 first district rule, 1957 ban).
  NWS hazard simplification: 'Advisory' headlines to be REPLACED by plain language (decided Aug 2023; 'no earlier than 2025'; no effective date
  found); Watch and Warning kept; 'Excessive Heat' -> 'Extreme Heat' (Mar 2025).
- UNCLEAR: Wansink & van Ittersum 2005 BMJ -- no notice found on the BMJ page; not fully ruled out. JIS L 4004:2023 S chest range (only copy garbled).
- Remaining OPEN: Eugene ASOS date; Tokyo heat deaths official source; age-threshold dates; 2013 UK stamp duty rates; NWS heat index limits;
  'thin blood' usage; acclimatization; NWS local criteria; Hawai'i heat/cold; ready-to-wear history; item statistic (ask Kim).

- [x] Eugene station history -- CONFIRMED (Kim's research + NWS Portland, Climate Book Eugene pg1; NWS Oregon Weather Bureau history; FAA
  weathercams): records from Oct 1890 (U of O coop); airpark 1928/1937; Mahlon Sweet Field from Dec 1942; NWS moved up to the old control tower
  (2nd floor) 1987-1995; staffed operations ended Aug 1995 and ASOS became fully operational on 1 SEPTEMBER 1995 (44.133 N, 123.216 W); ASOS
  cannot measure snowfall. The 1995 automation coincides with the step down in Eugene's rainfall relative to Salem and Corvallis (ratio 1.42 in
  1990-94 -> 1.00 in 1995-99). NWS does not describe a specific rain-gauge change; the earlier upward DRIFT (1950s-1994) remains unexplained.
- [x] 'Thin blood' -- a WIDESPREAD MYTH of warm places (Kim; his link: Bradenton Herald, article55581325 -- site blocked to Claude). Checked:
  First Coast News 'Verify' (Florida): a heart specialist (Dr. Andre Dias, Baptist Heart Hospital) calls it a myth -- blood does not thin or thicken
  with where you live; what changes is ACCLIMATIZATION (vessels in the skin dilate and sweating increases in heat; they constrict in cold). Florida's
  version: 'Cold Wimp Syndrome' (mysuncoast, Nov 2025). For MRC: the folk label names a real shift in a PERSONAL SCALE with a false mechanism --
  the category is real, the explanation is not.
- Still OPEN (minor): NWS local criteria; ready-to-wear sizing history; JIS S chest range (official text); Wansink 2005 status.
- [x] Ben Finney -- CONFIRMED (Kim + Hawaii Magazine, Christine Hitt, 1 May 2017, 'Hokule'a's first crew members reflect...'): UH Manoa
  anthropologist (Harvard PhD), co-founder and first president of PVS (with Kane and Holmes), crew on the first voyage Hawai'i -> Tahiti (1976);
  came to it from the academic question of how Polynesians settled the Pacific. His specific duty on board is not described.
