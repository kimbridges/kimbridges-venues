# ---------------------------------------------------------------
# Behind the Curtain -- the briefing book chain figure
# K. W. Bridges / Claude.  Written 2026-07-26.
#
#   briefing_chain.svg   the four-stage chain, person at both ends
#
# Okabe-Ito palette.  Nothing is carried by colour alone: each stage
# also names its actor in the header, and the two engine stages use a
# dotted border where the two person stages use a solid one.
# ---------------------------------------------------------------

library(ggplot2)

OUT   <- "G:/My Drive/kimbridges-collections/Behind_the_Curtain/images"
BLUE  <- "#0072B2"   # Okabe-Ito blue
ORNG  <- "#E69F00"   # Okabe-Ito orange
GREY  <- "#666666"
BLUEF <- "#DCEAF4"   # tints, for fill only
ORNGF <- "#FBEEDA"
X0 <- 2; X1 <- 81

B <- data.frame(x0 = X0, x1 = X1,
                y0 = c(87, 49, 21, 3),
                y1 = c(99, 83, 45, 17),
                who = c("person", "engine", "engine", "person"))
B$fill <- ifelse(B$who == "person", ORNGF, BLUEF)
B$col  <- ifelse(B$who == "person", ORNG,  BLUE)
B$lty  <- ifelse(B$who == "person", "solid", "22")

hd <- data.frame(
  x = 3.5, y = c(96.0, 80.0, 42.0, 14.0),
  lab = c("THE PERSON STARTS IT", "THE ENGINE ASSEMBLES",
          "THE ENGINE RENDERS",   "THE PERSON READS IT"),
  col = c(ORNG, BLUE, BLUE, ORNG))

bd <- data.frame(
  x = 3.5, y = c(92.3, 89.3, 10.3, 7.1),
  lab = c("One coordinate. One page of site knowledge.",
          "Why this place, how you get in, what is known to be there, what matters culturally.",
          "Field judgment. Corrections. The next question.",
          "What the record cannot say, and what someone who has walked the site can."),
  sz  = c(3.7, 2.9, 3.7, 2.9),
  col = c("black", GREY, "black", GREY))

st <- data.frame(
  x = 5, y = c(75.5, 71.0, 66.5, 62.0, 57.5, 53.0, 38.0, 33.5, 29.0, 24.5),
  lab = c("pull the occurrence records", "remove the duplicate entries",
          "join family and lifeform", "fetch conservation status",
          "pull the climate data", "extract an elevation for every record",
          "generate every figure", "typeset the tables to one standard",
          "lay out the pages", "bind the set into one document"))

ar  <- data.frame(x = 41, xe = 41, y = c(87, 49, 21), ye = c(83.8, 45.8, 17.8))
brk <- data.frame(x = c(84, 87, 87, 84), y = c(83, 83, 21, 21))

p <- ggplot() +
  geom_rect(data = B, aes(xmin = x0, xmax = x1, ymin = y0, ymax = y1),
            fill = B$fill, colour = B$col, linewidth = 0.6, linetype = B$lty) +
  geom_segment(data = ar, aes(x = x, xend = xe, y = y, yend = ye),
               arrow = arrow(length = unit(2.4, "mm"), type = "closed"),
               colour = GREY, linewidth = 0.5) +
  geom_text(data = hd, aes(x = x, y = y, label = lab), hjust = 0,
            size = 2.9, fontface = "bold", colour = hd$col) +
  geom_text(data = bd, aes(x = x, y = y, label = lab), hjust = 0,
            size = bd$sz, colour = bd$col) +
  geom_text(data = st, aes(x = x, y = y, label = lab), hjust = 0,
            size = 3.3, colour = "black") +
  geom_path(data = brk, aes(x = x, y = y), colour = GREY, linewidth = 0.5) +
  annotate("text", x = 88.5, y = 52, label = "no person\nin between",
           hjust = 0, size = 3.2, colour = GREY, lineheight = 1.05) +
  scale_x_continuous(limits = c(0, 102)) +
  scale_y_continuous(limits = c(0, 102)) +
  labs(title = "From a coordinate to a bound book",
       subtitle = "The briefing book chain. The person is at both ends and nowhere in between.",
       caption = "Every step depends on the one before it. Earlier work on this site ran the same kind of chain one step at a time,\nwith a person looking at each result before asking for the next.") +
  theme_void(base_size = 12) +
  theme(plot.title    = element_text(face = "bold", size = 13, margin = margin(b = 3)),
        plot.subtitle = element_text(colour = GREY, size = 10.5, margin = margin(b = 10)),
        plot.caption  = element_text(colour = GREY, size = 8.5, hjust = 0,
                                     margin = margin(t = 10)),
        plot.title.position = "plot", plot.caption.position = "plot",
        plot.margin = margin(10, 10, 10, 10))

ggsave(file.path(OUT, "briefing_chain.svg"), p,
       width = 7.5, height = 7.0, device = svglite::svglite)
ggsave(file.path(OUT, "_proof.png"), p, width = 7.5, height = 7.0, dpi = 120)
