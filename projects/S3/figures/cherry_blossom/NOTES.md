# cherry_blossom -- Kim's DC cherry-blossom phenology analysis

Kim's R Markdown of 2022-03-09 (`cherry_blossom.Rmd`) and its four plots, filed
here for S3 on 2026-11-25. Data: NPS phase dates for the Tidal Basin Yoshino
cherries, 2004-2021 (End values estimated).

- `cherry_plot1.png` -- phases as stacked bars per year, days from Feb 15
- `cherry_plot2.png` -- mean length of each phase
- `cherry_plot3.png` -- boxplot of phase lengths
- `cherry_plot4.png` -- dotplot of phase lengths

## Known code issues (found 2026-11-25; the Rmd is kept as written)

- plot2 uses `phase_levels` and `phase_limits` before they are defined;
  a fresh knit errors there. Move their definitions above plot2.
- `fun.y = "mean"` is deprecated in ggplot2; use `fun = "mean"`.
- The 2010 data row lacks its trailing comma (one field short).
- plot3 is saved as `cheery_plot3.png` (typo).
- The last chunk ("start stuff") is unfinished.
- Data could be extended 2022-2026 from NPS.

Observations from the data are in `Projects_Index/ideas_three_documents.md`
(S3, 2026-11-25).
