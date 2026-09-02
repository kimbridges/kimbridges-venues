## day_data.R -- ch.12. What a day was made of.
## Built 2026-09-01. Creamsicle is the only record with a STOPPED-TIME column and
## a free-text COMMENT column, so it is the only one that can answer this at all.

## My categories, not Kim's. He wrote free text; the grouping below is mine and is
## stated so a reader can disagree with it. The raw comments are printed verbatim
## in the figure, typos included.
## A comment naming two things ("Ferry, Costco") is filed under the FIRST match
## in the order below, and the order is part of the claim.
DAY_CATS <- list(
  "somebody to see"       = c("Tom","Cindy","Madness \\+ Cindy","Meet Lan"),
  "something to eat"      = c("[Ll]unch","Brunch","coffee","Starbucks"),
  "something to look at"  = c("Cranes","Birds","Founders Grove","White Sands","Caverns",
                              "Desert Mus","slot canyon","Aquarium","photos","Port Alberni"),
  "the ferry"             = c("Ferry"),
  "an errand"             = c("Costco","Shopping","Post Office","Misc","park, shop"),
  "the clock"             = c("[Tt]ime ?[Zz]one","Mountain Time","Pacific Time"),
  "weather, or a wreck"   = c("Accident","hail","rain"))

day_data <- function() {
  L <- twored_legs
  C <- cream_legs
  C$comment <- trimws(C$comment)
  C$has <- C$comment != "" & !is.na(C$comment)
  ok <- is.finite(C$stop_hours) & is.finite(C$raw_hours)
  Co <- C[ok, ]

  cat_of <- function(x) {
    for (nm in names(DAY_CATS))
      if (any(vapply(DAY_CATS[[nm]], function(p) grepl(p, x), logical(1)))) return(nm)
    "something else"
  }
  Co$kind <- vapply(Co$comment, function(x) if (x == "") NA_character_ else cat_of(x), character(1))

  d <- Co[Co$has, ]
  d$drive_h <- d$raw_hours - d$stop_hours
  d <- d[order(d$stop_hours, d$raw_hours), ]

  tab <- as.data.frame(table(Co$kind[Co$has]), stringsAsFactors = FALSE)
  names(tab) <- c("Why the day stopped", "Days"); tab <- tab[order(-tab$Days), ]

  list(
    tw_legs = nrow(L), tw_med = median(L$odo_miles, na.rm = TRUE),
    cr_legs = nrow(Co), cr_med = median(Co$miles, na.rm = TRUE),
    n_comment = sum(Co$has), pct_comment = 100 * mean(Co$has),
    med_stop = median(Co$stop_hours), med_raw = median(Co$raw_hours),
    n_zero = sum(Co$stop_hours == 0),
    stop_share_all = 100 * sum(Co$stop_hours) / sum(Co$raw_hours),
    med_stop_comment = median(Co$stop_hours[Co$has]),
    med_stop_silent  = median(Co$stop_hours[!Co$has]),
    zero_comment = sum(Co$stop_hours[Co$has] == 0),
    zero_silent  = sum(Co$stop_hours[!Co$has] == 0),
    p_comment = suppressWarnings(wilcox.test(Co$stop_hours[Co$has],
                                             Co$stop_hours[!Co$has]))$p.value,
    share_of_stopped = 100 * sum(Co$stop_hours[Co$has]) / sum(Co$stop_hours),

    ## The three-way test. If the comment column were marking a different KIND
    ## of day, the miles would differ. They do not. If it were marking slower
    ## driving, the net speed would differ. It does not. The whole of the
    ## difference is time the car spent standing still.
    mi_comment = median(Co$miles[Co$has]),
    mi_silent  = median(Co$miles[!Co$has]),
    p_miles = suppressWarnings(wilcox.test(Co$miles[Co$has],
                                           Co$miles[!Co$has]))$p.value,
    gross_comment = median(Co$gross_mph[Co$has]),
    gross_silent  = median(Co$gross_mph[!Co$has]),
    p_gross = suppressWarnings(wilcox.test(Co$gross_mph[Co$has],
                                           Co$gross_mph[!Co$has]))$p.value,
    net_comment = median(Co$net_mph[Co$has]),
    net_silent  = median(Co$net_mph[!Co$has]),
    p_net = suppressWarnings(wilcox.test(Co$net_mph[Co$has],
                                         Co$net_mph[!Co$has]))$p.value,
    gap_gross = median(Co$gross_mph[!Co$has]) - median(Co$gross_mph[Co$has]),
    gap_net   = median(Co$net_mph[!Co$has])   - median(Co$net_mph[Co$has]),

    ## The ordinary day, both cars, as a quartile spread rather than a point.
    hr_med = median(Co$raw_hours), hr_q = quantile(Co$raw_hours, c(.25, .75)),
    mi_q   = quantile(Co$miles, c(.25, .75)),
    tw_q   = quantile(L$odo_miles, c(.25, .75), na.rm = TRUE),
    tw_hr  = median(L$elapsed_hours, na.rm = TRUE),

    ## What the FIRST form cannot be asked. TwoRed's sheet has no stopped-time
    ## column, so the question ch.12 answers can only ever be put to the later
    ## car. This is the measurable cost of designing the sheet before thinking
    ## through the analysis, and it does not shrink: those years are closed.
    tw_no_stop = nrow(L), all_legs = nrow(L) + nrow(Co),
    pct_unaskable = 100 * nrow(L) / (nrow(L) + nrow(Co)),

    ## HOW FAST THE CATEGORIES SATURATE. Walk the commented legs in date order
    ## and count how many distinct categories have been seen. This is the test of
    ## Kim's "run the data early" rule: if the grouping is visible after a handful
    ## of comments, the structured column could have been added years earlier.
    cat_total = length(unique(d$kind)),
    cat_at10  = length(unique(d$kind[order(as.Date(d$date))][1:10])),
    cat_all_by = which(sapply(seq_len(nrow(d)), function(i)
                   length(unique(d$kind[order(as.Date(d$date))][1:i]))) ==
                   length(unique(d$kind)))[1],

    ## The names. A category list holds "somebody to see"; it does not hold Tom.
    ## Verbatim, in the order the legs run.
    names_seen = d$comment[d$kind == "somebody to see"],

    ## The four commented legs with no stopped time at all. Three of them are
    ## notes about the clock, which is the column being used for a second
    ## purpose, and the fourth is a stop that never got a number.
    zero_rows = d[d$stop_hours == 0, c("date", "lv_city", "ar_city",
                                       "miles", "raw_hours", "comment")],
    tab = tab, bars = d)
}
