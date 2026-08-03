# collector_tools.R — examine a herbarium-record checklist by COLLECTOR and DATE
# Part of the `checklists` project (seed of a future `checklistr`). Built + verified
# live in RStudio on the Kīpuka Puaulu flowering-plant records, 2026-07-05.
#
# Pipeline:  fetch_specimens_gbif() -> add_primary_collector() ->
#            collector_profile() / plot_collecting_history() / plot_collector_activity()
#
# Dependencies: rgbif, dplyr, stringr, tidyr, ggplot2, forcats

suppressPackageStartupMessages({
  library(rgbif); library(dplyr); library(stringr)
  library(tidyr); library(ggplot2); library(forcats)
})

# ---- geometry helper: CCW WKT circle of radius r_km around (lon, lat) -----------
circle_wkt <- function(lon, lat, r_km = 2, n = 60) {
  th   <- seq(0, 2*pi, length.out = n + 1)
  dlat <- (r_km / 111.32) * sin(th)
  dlon <- (r_km / (111.32 * cos(lat * pi/180))) * cos(th)
  paste0("POLYGON((",
         paste(sprintf("%.6f %.6f", lon + dlon, lat + dlat), collapse = ", "), "))")
}

# ---- fetch preserved-specimen (herbarium) records for a place --------------------
# taxon: a GBIF backbone name (default flowering plants). Returns a tidy data frame.
fetch_specimens_gbif <- function(lon, lat, r_km = 2,
                                 taxon = "Magnoliopsida", rank = "class",
                                 kingdom = "Plantae") {
  key <- name_backbone(name = taxon, rank = rank, kingdom = kingdom)$usageKey
  wkt <- circle_wkt(lon, lat, r_km)
  n   <- occ_search(taxonKey = key, geometry = wkt,
                    basisOfRecord = "PRESERVED_SPECIMEN", limit = 0)$meta$count
  res <- occ_search(taxonKey = key, geometry = wkt,
                    basisOfRecord = "PRESERVED_SPECIMEN", limit = max(n, 1))
  want <- c("key","scientificName","species","family","genus","recordedBy","recordNumber",
            "eventDate","year","month","day","catalogNumber","institutionCode",
            "collectionCode","decimalLatitude","decimalLongitude")
  res$data %>% select(any_of(want))
}

# ---- extract the PRIMARY collector's surname from a messy recordedBy string ------
# Handles "Surname, Initials" and "Given ... Surname", co-collector teams (; & and),
# annotations (State ESP team, et al.), and a leading particle (Van/von/de).
primary_collector <- function(s) {
  if (is.na(s) || !nzchar(str_squish(s))) return(NA_character_)
  s  <- str_squish(str_replace_all(s, regex("state esp team|esp team|et\\s*al\\.?",
                                            ignore_case = TRUE), ""))
  s1 <- str_squish(str_split(s, ";|&|\\band\\b", n = 2)[[1]][1])
  m  <- str_match(s1, "^([A-Z][A-Za-z'’-]+),\\s*[A-Z]\\.?")
  if (!is.na(m[1,1])) return(m[1,2])
  toks <- str_split(s1, "\\s+")[[1]]; toks <- toks[nzchar(toks)]
  toks <- toks[!str_detect(toks, regex("^(jr|sr|ii|iii|iv|2nd|3rd)[.,]*$", ignore_case = TRUE))] # drop suffixes
  if (!length(toks)) return(NA_character_)
  last <- toks[length(toks)]
  if (length(toks) >= 2 && str_detect(toks[length(toks)-1], "^([Vv]an|[Vv]on|[Dd]e|[Dd]el)$"))
    last <- paste(toks[length(toks)-1], last)
  str_squish(str_replace_all(last, "[^A-Za-z'’ -]", ""))
}
add_primary_collector <- function(df)
  df %>% mutate(collector = vapply(recordedBy, primary_collector, character(1)))

# ---- DEDUP: apply EARLY, right after add_primary_collector -----------------------
# Two levels of herbarium duplication:
#   "institution" (default) — same physical specimen recorded under synonymous museum
#      codes (BISH & BPBM are both Bishop Museum). Pure artifact; always safe to remove.
#   "gathering" — additionally collapse duplicate SHEETS of one collection event,
#      distributed across herbaria, keyed by collector + recordNumber + year. Use when
#      you want collection EVENTS rather than physical sheets.
# On Kīpuka Puaulu flowering plants this took 249 raw -> 167 (institution) -> 149 (gathering);
# BISH/BPBM double-entry alone nearly doubled some collector counts (Cuddihy 99 -> 50).

normalize_institution <- function(x) dplyr::recode(x, BPBM = "BISH")  # both = Bishop Museum

clean_record_number <- function(x){                 # collector's field number = gathering key
  x <- tolower(ifelse(is.na(x), "", x))
  x <- str_replace_all(x, "collector number:|collector no\\.?:?|coll\\.? no\\.?:?|number:|no\\.:?", " ")
  num <- str_extract(str_squish(x), "\\d+\\s*[a-z]?")
  num <- str_replace_all(num, "\\s", "")
  num <- str_replace(num, "^0+(?=\\d)", "")         # 082 -> 82
  ifelse(is.na(num) | num == "", NA_character_, num)
}

dedup_specimens <- function(df, level = c("institution","gathering"), verbose = TRUE){
  level <- match.arg(level); n0 <- nrow(df)
  scols <- intersect(c("eventDate","recordNumber","species","decimalLatitude"), names(df))
  df$.score <- Reduce(`+`, lapply(scols, function(c){ v <- df[[c]]; as.integer(!is.na(v) & as.character(v) != "") }))
  df$institution <- normalize_institution(df$institutionCode)
  df$.cat  <- ifelse(is.na(df$catalogNumber) | df$catalogNumber == "", NA, df$catalogNumber)
  df$.pref <- df$institutionCode == "BISH"          # prefer the Index Herbariorum code
  A  <- df %>% filter(!is.na(.cat)) %>% group_by(institution, .cat) %>%
        arrange(desc(.score), desc(.pref)) %>% slice(1) %>% ungroup()
  df <- bind_rows(A, df %>% filter(is.na(.cat)))
  if (level == "gathering"){
    df$.rn <- clean_record_number(df$recordNumber)
    K  <- df %>% filter(!is.na(.rn) & !is.na(collector)) %>%
          group_by(collector, .rn, year) %>%
          arrange(desc(.score), desc(.pref)) %>% slice(1) %>% ungroup()
    df <- bind_rows(K, df %>% filter(is.na(.rn) | is.na(collector))) %>% select(-.rn)
  }
  df <- df %>% select(-.cat, -.score, -.pref)
  if (verbose) message(sprintf("dedup(%s): %d -> %d rows (removed %d)", level, n0, nrow(df), n0 - nrow(df)))
  df
}

# ---- DETERMINATION CONFLICTS -----------------------------------------------------
# Find single physical sheets carrying >1 distinct species determination (e.g. the
# same Bishop catalogNumber databased differently under BISH vs BPBM). These are one
# specimen with conflicting IDs — important for the checklist: a taxon whose only
# support is the losing side of a conflict may be spurious. Returns one row per sheet.
# NOTE the species->accepted-taxon mapping for flagging the checklist still needs a
# human/authority check (GBIF genus reassignments, e.g. Eriocapitella = Anemone,
# Leptopetalum = Hedyotis, can hide or expose a conflict).
detect_det_conflicts <- function(df){
  has_col <- function(n) n %in% names(df)
  df %>% mutate(institution = normalize_institution(institutionCode)) %>%
    filter(!is.na(catalogNumber), catalogNumber != "", !is.na(species), species != "") %>%
    group_by(institution, catalogNumber) %>%
    filter(n() > 1, n_distinct(species) > 1) %>%
    summarise(collector = if (has_col("collector")) paste(unique(collector), collapse = "/") else NA_character_,
              year  = if (has_col("year")) paste(unique(year), collapse = "/") else NA_character_,
              codes = paste(institutionCode, collapse = "+"),
              n_dets = n_distinct(species),
              determinations = paste(sort(unique(species)), collapse = " | "),
              .groups = "drop") %>%
    arrange(desc(n_dets), catalogNumber)
}

# ---- SPECIES ACCUMULATION & COMPLETENESS -----------------------------------------
# Two views everyone wants for a collecting location:
#   species_discovery()  — cumulative distinct taxa by year first collected (history).
#   richness_estimate()  — observed richness + completeness estimators (is it fully collected?).
#   plot_species_discovery() / plot_accumulation() — the two figures.
#
# IMPORTANT caveats (state them whenever you report the numbers):
#   (1) Herbarium collecting is deliberate (≈ one sheet per taxon), which inflates the
#       singleton count and makes abundance-based Chao1 (and incidence Chao2) tend to
#       OVER-estimate unseen richness. Trust the direction, not the exact digits.
#   (2) GBIF holds only DIGITIZED specimens; published floras and the local research
#       herbarium usually hold more. So this measures completeness OF THE GBIF RECORD,
#       which is a useful "how well is this site documented online" flag — not the flora.
species_discovery <- function(df){
  df %>% filter(!is.na(species), species != "", !is.na(year)) %>%
    group_by(species) %>% summarise(first_year = min(year), .groups = "drop") %>%
    count(first_year, name = "new_taxa") %>% arrange(first_year) %>%
    mutate(cum_taxa = cumsum(new_taxa))
}

richness_estimate <- function(df){
  ab  <- df %>% filter(!is.na(species), species != "") %>% count(species, name = "n")
  eab <- vegan::estimateR(setNames(ab$n, ab$species))
  ev  <- df %>% filter(!is.na(species), species != "", !is.na(eventDate), eventDate != "") %>%
         mutate(event = paste(collector, eventDate)) %>% distinct(event, species)
  m <- table(ev$event, ev$species); m[m > 1] <- 1
  sp2  <- vegan::specpool(m); Sobs <- nrow(ab)
  tibble::tibble(
    S_obs = Sobs, singletons = sum(ab$n == 1), doubletons = sum(ab$n == 2),
    singleton_pct = round(100 * mean(ab$n == 1)), events = sp2$n,
    Chao1 = round(eab["S.chao1"]), Chao1_pct = round(100 * Sobs / eab["S.chao1"]),
    Chao2 = round(sp2$chao),       Chao2_pct = round(100 * Sobs / sp2$chao),
    jack1 = round(sp2$jack1),      jack1_pct = round(100 * Sobs / sp2$jack1))
}

plot_species_discovery <- function(df, place = ""){
  d <- species_discovery(df)
  ggplot(d, aes(first_year, cum_taxa)) +
    geom_step(direction = "hv", linewidth = 0.9, color = "#1b7837") +
    geom_point(data = subset(d, new_taxa >= 5), aes(size = new_taxa), color = "#1b7837") +
    scale_size_area(max_size = 8, guide = "none") +
    scale_x_continuous(breaks = seq(1900, 2030, 10)) +
    labs(title = paste(place, "— species accumulation (discovery curve)"),
         subtitle = paste0("cumulative distinct taxa by year first collected; ", max(d$cum_taxa), " taxa"),
         x = NULL, y = "cumulative taxa known") +
    theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank())
}

plot_accumulation <- function(df, place = "", permutations = 200){
  ev <- df %>% filter(!is.na(species), species != "", !is.na(eventDate), eventDate != "") %>%
        mutate(event = paste(collector, eventDate)) %>% distinct(event, species)
  m <- table(ev$event, ev$species); m[m > 1] <- 1
  sa <- vegan::specaccum(m, method = "random", permutations = permutations)
  d  <- data.frame(events = sa$sites, taxa = sa$richness, sd = sa$sd)
  re <- richness_estimate(df)
  ggplot(d, aes(events, taxa)) +
    geom_ribbon(aes(ymin = taxa - 1.96*sd, ymax = taxa + 1.96*sd), fill = "#1b7837", alpha = 0.15) +
    geom_line(linewidth = 1, color = "#1b7837") +
    geom_hline(yintercept = re$Chao2, linetype = "dashed", color = "grey40") +
    geom_hline(yintercept = re$jack1, linetype = "dotted", color = "grey40") +
    labs(title = paste(place, "— sample-based accumulation"),
         subtitle = paste0(re$S_obs, " taxa over ", re$events, " collecting events; ",
                          re$singleton_pct, "% singletons"),
         x = "collecting events (collector × date)", y = "taxa accumulated") +
    theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank())
}

# ---- COLLECTOR x TAXA ------------------------------------------------------------
# add_checklist_status(): tag each specimen with its checklist accepted taxon + status by
#   matching scientificName to the checklist's verbatim names (ASCII-folded to survive
#   diacritic differences). This is the inverse of how the facet checklist was built, so
#   it matches ~100%. Needs a checklist CSV with accepted_name/status/verbatim_names.
add_checklist_status <- function(df, checklist_path){
  cl <- readr::read_csv(checklist_path, show_col_types = FALSE, na = character())
  f  <- function(x) stringi::stri_trans_general(x, "Latin-ASCII")
  lut <- cl %>% select(accepted_name, status, verbatim_names) %>%
    tidyr::separate_rows(verbatim_names, sep = "; ") %>%
    mutate(key = f(str_squish(str_replace(verbatim_names, "\\s*\\[\\d+\\]$", "")))) %>%
    filter(key != "") %>% distinct(key, accepted_name, status)
  df %>% mutate(key = f(str_squish(scientificName))) %>% left_join(lut, by = "key") %>% select(-key)
}

# plot_collector_composition(): native/alien makeup of each collector's specimens
# (needs a `status` column, e.g. from add_checklist_status).
plot_collector_composition <- function(df, min_specimens = 5, place = ""){
  pal <- c(Endemic="#1b7837", Indigenous="#7fbf7b", Naturalized="#f1a340",
           Cultivated="#b35806", Uncertain="grey70")
  lab <- c(E="Endemic", I="Indigenous", Nat="Naturalized", Cult="Cultivated", `?`="Uncertain")
  keep <- df %>% filter(!is.na(collector)) %>% count(collector) %>% filter(n >= min_specimens) %>% pull(collector)
  d <- df %>% filter(collector %in% keep, !is.na(status)) %>%
    group_by(collector) %>% mutate(fy = min(year, na.rm = TRUE), tot = n()) %>% ungroup() %>%
    mutate(status_f = factor(lab[status], levels = names(pal)))
  o <- d %>% distinct(collector, fy, tot) %>% arrange(fy) %>%
    mutate(clab = paste0(collector, " (", fy, ", n=", tot, ")"))
  d <- d %>% left_join(o, by = c("collector","fy","tot")) %>% mutate(clab = factor(clab, levels = rev(o$clab)))
  ggplot(d, aes(y = clab, fill = status_f)) + geom_bar(position = "fill", width = 0.8) +
    scale_fill_manual(values = pal, name = NULL) + scale_x_continuous(labels = scales::percent) +
    labs(title = paste(place, "— what each collector collected (by origin)"),
         x = "share of specimens", y = NULL) +
    theme_minimal(base_size = 12) + theme(panel.grid = element_blank(), legend.position = "bottom")
}

# collector_contributions(): breadth (distinct taxa) vs uniqueness (taxa collected by no
#   one else). Taxon unit = accepted_name if present, else GBIF species.
collector_contributions <- function(df){
  df$.tax <- if ("accepted_name" %in% names(df)) df$accepted_name else df$species
  d  <- df %>% filter(!is.na(collector), !is.na(.tax), .tax != "") %>% distinct(collector, .tax)
  nc <- d %>% count(.tax, name = "n_collectors")
  d %>% left_join(nc, by = ".tax") %>% group_by(collector) %>%
    summarise(total_taxa = n(), unique_taxa = sum(n_collectors == 1), .groups = "drop") %>%
    arrange(desc(unique_taxa))
}

# ---- LENS 1: collector profile ---------------------------------------------------
collector_profile <- function(df) {
  df %>% filter(!is.na(collector)) %>%
    group_by(collector) %>%
    summarise(specimens = n(),
              taxa      = n_distinct(species, na.rm = TRUE),
              first     = min(year, na.rm = TRUE),
              last      = max(year, na.rm = TRUE),
              span_yrs  = last - first,
              institutions = paste(sort(unique(institutionCode)), collapse = ","),
              .groups = "drop") %>%
    arrange(desc(specimens))
}

# ---- LENS 2a: collecting history (specimens per year, top collectors highlighted)
plot_collecting_history <- function(df, n_top = 6, place = "") {
  prof <- collector_profile(df)
  top  <- prof %>% slice_max(specimens, n = n_top) %>% pull(collector)
  yr <- df %>% filter(!is.na(year)) %>%
    mutate(grp = ifelse(collector %in% top, collector, "other collectors"))
  ggplot(yr, aes(year, fill = fct_relevel(factor(grp), "other collectors", after = Inf))) +
    geom_histogram(binwidth = 1, color = "grey20", linewidth = 0.1) +
    scale_x_continuous(breaks = seq(1900, 2030, 10)) +
    scale_fill_brewer(palette = "Set2", name = "primary collector") +
    labs(title = paste(place, "— herbarium collecting history"),
         subtitle = paste(nrow(df), "preserved specimens"),
         x = NULL, y = "specimens collected") +
    theme_minimal(base_size = 12) +
    theme(panel.grid.minor = element_blank(), legend.position = "bottom")
}

# ---- LENS 2b: collector activity chart (who collected, when, how much) -----------
plot_collector_activity <- function(df, min_specimens = 2, place = "") {
  p <- collector_profile(df) %>% filter(specimens >= min_specimens) %>%
       mutate(collector = fct_reorder(collector, first))
  ggplot(p, aes(y = collector)) +
    geom_segment(aes(x = first, xend = last, yend = collector),
                 linewidth = 0.6, color = "grey60") +
    geom_point(aes(x = first, size = specimens, color = taxa)) +
    geom_point(aes(x = last,  size = specimens, color = taxa)) +
    scale_size_area(max_size = 9, name = "specimens") +
    scale_color_viridis_c(option = "C", end = 0.9, name = "distinct taxa") +
    scale_x_continuous(breaks = seq(1900, 2030, 10)) +
    labs(title = paste(place, "— who collected, and when"),
         subtitle = "point size = specimens, color = distinct taxa",
         x = NULL, y = NULL) +
    theme_minimal(base_size = 12) +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major.y = element_line(linewidth = 0.2))
}

# ---- worked example: Kīpuka Puaulu, HAVO ----------------------------------------
if (FALSE) {
  sp   <- fetch_specimens_gbif(lon = -155.296, lat = 19.437, r_km = 2) |>
            add_primary_collector() |>
            dedup_specimens(level = "institution")   # <-- fix BISH/BPBM early
  prof <- collector_profile(sp); print(prof, n = 20)
  plot_collecting_history(sp, place = "Kīpuka Puaulu")
  plot_collector_activity(sp, min_specimens = 2, place = "Kīpuka Puaulu")
}
