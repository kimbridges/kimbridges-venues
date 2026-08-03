# Declare bare column names used in non-standard evaluation (dplyr/ggplot2),
# so R CMD check does not flag them as undefined global variables.
globalVariables(c(
  "institutionCode", "catalogNumber", "species", "collector", "year", "recordedBy",
  "eventDate", "decimalLatitude", "decimalLongitude", "scientificName", "recordNumber",
  "genus", "family", "class", "lifeform", "lifeform_source", "rank", "key", "scientificName2",
  "institution", "accepted_name", "status", "status_f", "verbatim_names", "sciname",
  "first_year", "cum_taxa", "new_taxa", "taxa", "events", "sd",
  "n", "n_collectors", "total_taxa", "unique_taxa", "specimens", "native_pct",
  "fy", "tot", "clab", "first", "last", "span_yrs", "grp", "institutions", "event",
  "coordinateUncertaintyInMeters", "records", "med_year", "hs", "x", "y",
  "n_dets", "determinations", "codes", "dets",
  ".tax", ".cat", ".score", ".pref", ".rn"
))
