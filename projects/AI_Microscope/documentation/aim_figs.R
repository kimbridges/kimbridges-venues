# ---------------------------------------------------------------
# Preview & Review -- data figures
# K. W. Bridges / Claude.  Written 2026-07-25.
#
# Three figures for the AI Microscope document.
#   aim_8_storage_cost.svg   Ch.2  what a slide cost to store, 1989-2026
#   aim_9_color_smear.svg    Ch.5  colours found where there should be one
#   aim_10_abundance.svg     Ch.5  how much of the leaf each tissue fills
#
# Okabe-Ito palette.  Nothing is carried by colour alone; every bar and
# point is also labelled with its value.
# ---------------------------------------------------------------

library(ggplot2)
library(scales)

OUT  <- "G:/My Drive/Projects/AI_Microscope/documentation/figures"
BLUE <- "#0072B2"   # Okabe-Ito blue
ORNG <- "#E69F00"   # Okabe-Ito orange
GREY <- "#666666"

base_theme <- theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor   = element_blank(),
    panel.grid.major.y = element_blank(),
    axis.title.y       = element_blank(),
    axis.ticks         = element_blank(),
    plot.title         = element_text(face = "bold", size = 13),
    plot.subtitle      = element_text(colour = GREY, size = 10.5,
                                      margin = margin(b = 12)),
    plot.caption       = element_text(colour = GREY, size = 8.5, hjust = 0,
                                      margin = margin(t = 12)),
    plot.title.position = "plot",
    plot.caption.position = "plot"
  )

# =================================================================
# FIGURE 1 (Ch.2) -- the price of holding one picture
# =================================================================
# Cost per megabyte of hard-disk storage.  1989 anchored on a real
# retail drive (Seagate ST-225, 20 MB, $230), cross-checked against
# the standard cost-per-gigabyte series.  A single Syringa slide was
# about 1.25 MB.

storage <- data.frame(
  year      = c(1989, 1990, 1995, 2000, 2005, 2009, 2017, 2022, 2026),
  usd_per_mb = c(11.50, 8.79, 0.879, 0.0107, 0.000586,
                 0.000111, 0.0000293, 0.0000137, 0.0000146)
)
storage$usd_per_slide <- storage$usd_per_mb * 1.25

y_breaks <- c(10, 1, 0.1, 0.01, 0.001, 1e-4, 1e-5)
y_labels <- c("$10", "$1", "$0.10", "$0.01", "$0.001", "$0.0001", "$0.00001")

p1 <- ggplot(storage, aes(year, usd_per_slide)) +
  geom_line(colour = BLUE, linewidth = 0.9) +
  geom_point(colour = BLUE, size = 2.6) +
  geom_point(data = storage[storage$year == 1989, ],
             colour = ORNG, size = 4.2) +
  annotate("text", x = 1989.6, y = 14.4 * 1.9,
           label = "1989: about $14 to store one slide",
           hjust = 0, size = 3.5, colour = ORNG, fontface = "bold") +
  annotate("text", x = 1999, y = 3.2,
           label = paste("A 20 MB disk of the day held 16 slides,",
                         "\nand nothing else."),
           hjust = 0, vjust = 1, size = 3.1, colour = GREY) +
  annotate("text", x = 2025.4, y = 0.0000183 * 3.4,
           label = "2026: two hundredths\nof a cent",
           hjust = 1, vjust = 0, size = 3.1, colour = GREY) +
  scale_y_log10(labels = y_labels, breaks = y_breaks) +
  scale_x_continuous(breaks = c(1989, 1995, 2000, 2005, 2010, 2015, 2020, 2026)) +
  labs(
    title = "What it cost to store one microscope slide",
    subtitle = paste("A single Syringa leaf section was about 1.25 megabytes.",
                     "The cost of holding it fell\nby a factor of roughly 800,000."),
    x = NULL,
    caption = paste0(
      "Hard-disk cost per megabyte, log scale. 1989 from a retail Seagate ST-225 ",
      "(20 MB, $230); later\npoints from the standard cost-per-gigabyte series and ",
      "Backblaze's drive-cost reporting. The 2026\nfigure reflects a mid-year market ",
      "in which drive prices rose rather than fell.")
  ) +
  base_theme +
  theme(panel.grid.major.y = element_line(colour = "grey92"))

ggsave(file.path(OUT, "aim_8_storage_cost.svg"), p1,
       width = 7.5, height = 4.8, device = svglite::svglite)

# =================================================================
# FIGURE 2 (Ch.5) -- the smear, measured
# =================================================================
# The clean categorical map defines where each tissue truly is.  Both
# maps are 1672 x 941 and pixel-aligned, so we can ask what the old
# blended map was carrying inside each of those regions.  A categorical
# map should carry exactly one colour per tissue.

smear <- data.frame(
  tissue = c("Midrib ground-tissue parenchyma", "Spongy mesophyll",
             "Bundle sheath and vascular tissue", "Xylem",
             "Palisade mesophyll", "Phloem", "Lower epidermis",
             "Upper epidermis", "Cuticle"),
  colours   = c(109783, 70557, 55755, 42213, 35200, 28412, 24862, 15798, 6043),
  region_px = c(374978, 157305,  64085, 66432,  99714, 34036, 39039, 32306,  9504)
)
smear <- smear[order(smear$colours), ]
smear$hl <- smear$tissue == "Phloem"

# Phloem is the case the chapter argues from, so it is named on the axis as
# well as coloured.  Nothing here is carried by colour alone.
smear$label <- ifelse(smear$hl, "Phloem: no blue to match", smear$tissue)
smear$label <- factor(smear$label, levels = smear$label)

# Axis text colours run bottom to top, in the same order as the rows.
axis_cols <- ifelse(smear$hl, ORNG, "grey30")

p2 <- ggplot(smear, aes(colours, label)) +
  geom_segment(aes(x = 1, xend = colours, yend = label, colour = hl),
               linewidth = 0.8, show.legend = FALSE) +
  geom_point(aes(colour = hl), size = 3.2, show.legend = FALSE) +
  geom_text(aes(label = comma(colours)), hjust = -0.28,
            size = 3.2, colour = GREY) +
  geom_vline(xintercept = 1, colour = "grey35", linewidth = 0.5) +
  annotate("text", x = 1.35, y = 0.45,
           label = "1 = what a clean categorical map holds",
           hjust = 0, vjust = 0.5, size = 3.1, colour = "grey35") +
  scale_colour_manual(values = c(`FALSE` = BLUE, `TRUE` = ORNG)) +
  scale_x_log10(labels = comma,
                breaks = c(1, 10, 100, 1000, 10000, 100000),
                limits = c(1, 900000)) +
  expand_limits(y = c(0.2, 9.6)) +
  labs(
    title = "Colours found where there should have been one",
    subtitle = paste("Each tissue's region is defined by the rebuilt map.",
                     "The count is what the old blended\nmap was actually carrying inside it."),
    x = "Distinct colours in the region (log scale)",
    caption = paste0(
      "Measured from color_layer.png against color_layer_clean.png, both 1672 x 941 and ",
      "pixel-aligned.\nThe old map held 359,791 distinct colours in total; the rebuilt map ",
      "holds 10. In phloem's region the\nsingle most common colour covers 0.05 percent of ",
      "the area, so there was no dominant shade to key on.")
  ) +
  base_theme +
  theme(axis.text.y = element_text(colour = axis_cols))

ggsave(file.path(OUT, "aim_9_color_smear.svg"), p2,
       width = 7.5, height = 5.0, device = svglite::svglite)

# =================================================================
# FIGURE 3 (Ch.5) -- how much of the leaf each tissue fills
# =================================================================
# Straight from slide_syringa.json, the manifest the running app reads.
# Percentages are of the clickable leaf footprint, interior partitioned
# to the nearest tissue.

ab <- data.frame(
  tissue = c("Midrib ground-tissue parenchyma", "Spongy mesophyll",
             "Palisade mesophyll", "Xylem",
             "Bundle sheath and vascular tissue", "Lower epidermis",
             "Phloem", "Upper epidermis", "Cuticle"),
  pct = c(42.7, 17.9, 11.4, 7.6, 7.3, 4.4, 3.9, 3.7, 1.1)
)
ab <- ab[order(ab$pct), ]
ab$tissue <- factor(ab$tissue, levels = ab$tissue)

p3 <- ggplot(ab, aes(pct, tissue)) +
  geom_col(fill = BLUE, width = 0.62) +
  geom_text(aes(label = sprintf("%.1f%%", pct)), hjust = -0.22,
            size = 3.2, colour = GREY) +
  scale_x_continuous(limits = c(0, 49), expand = c(0, 0)) +
  labs(
    title = "How much of the leaf each tissue fills",
    subtitle = paste("The number the microscope offers when you land somewhere,",
                     "so you know whether you\nare hunting for something common or something rare."),
    x = "Percent of the clickable leaf footprint",
    caption = paste0(
      "From slide_syringa.json, the manifest the running app reads. Percentages are of the ",
      "leaf footprint\nwith the interior partitioned to the nearest tissue, a basis recorded ",
      "in the file itself rather than\nin a notebook. Sclerenchyma is absent: the rebuilt map ",
      "found no region for it.")
  ) +
  base_theme +
  theme(panel.grid.major.x = element_line(colour = "grey92"))

ggsave(file.path(OUT, "aim_10_abundance.svg"), p3,
       width = 7.5, height = 4.6, device = svglite::svglite)

cat("done\n")
for (f in c("aim_8_storage_cost.svg", "aim_9_color_smear.svg", "aim_10_abundance.svg"))
  cat(sprintf("  %-26s %8.0f bytes\n", f, file.info(file.path(OUT, f))$size))
