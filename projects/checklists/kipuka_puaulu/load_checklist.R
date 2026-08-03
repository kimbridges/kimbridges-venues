# Kīpuka Puaulu herbarium checklist — quick load & summaries
library(dplyr); library(ggplot2); library(readr)

cl  <- read_csv("kipuka_puaulu_checklist.csv", show_col_types = FALSE)
raw <- read_csv("kipuka_puaulu_gbif_rawnames.csv", show_col_types = FALSE)

status_lab <- c(E="Endemic", I="Indigenous", Pol="Polynesian",
                Nat="Naturalized", Cult="Cultivated", `?`="Uncertain")
cl <- cl |> mutate(status_full = status_lab[status])

# taxa per status
cl |> count(status_full, sort = TRUE) |> print()

# native vs alien species richness by family (native = E or I)
cl |> filter(rank == "species") |>
  mutate(origin = ifelse(status %in% c("E","I"), "Native", "Alien/planted")) |>
  count(family, origin) |>
  ggplot(aes(reorder(family, n, sum), n, fill = origin)) +
  geom_col() + coord_flip() +
  labs(x = NULL, y = "Species (herbarium specimens)",
       title = "Kīpuka Puaulu vascular flora by family",
       subtitle = "GBIF preserved specimens within 2 km") +
  theme_minimal()

# best-collected taxa
cl |> arrange(desc(n_records)) |> select(accepted_name, family, status, n_records) |> head(15) |> print()
