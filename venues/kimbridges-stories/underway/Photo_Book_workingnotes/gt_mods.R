# Create a gt table object
  gt_table <- gt(verification_df) %>%
    # Add a title to the table
    tab_header(title = "Data Verification Table") %>%
    # Apply standard table styling options
    tab_options(
      table.border.top.color = "black",
      column_labels.border.bottom.color = "black",
      table.width = pct(95)) %>%
    tab_style(style = cell_text(size = "smaller",
                                v_align = "top"),
              locations = cells_body(columns = everything()))