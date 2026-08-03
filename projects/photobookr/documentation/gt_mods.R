# gt_mods.R
# Custom gt table styling for verification table
# This defines a function to be called after verification_df is created

#' Create styled verification table
#' @param verification_df Data frame with verification data
#' @return A gt table object
create_verification_table <- function(verification_df) {
  gt(verification_df) %>%
    tab_header(title = "Data Verification Table") %>%
    tab_options(
      table.border.top.color = "black",
      column_labels.border.bottom.color = "black",
      table.width = pct(95)
    ) %>%
    tab_style(
      style = cell_text(size = "smaller", v_align = "top"),
      locations = cells_body(columns = everything())
    )
}