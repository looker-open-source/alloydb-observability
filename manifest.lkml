project_name: "operational-intelligence-alloy-db"

# --------------------------------------------------------------------------
# Constants
# --------------------------------------------------------------------------

constant: CONNECTION_NAME {
  value: "alloydb_connection_name"
  export: override_optional
}

constant: DATABASE_NAME {
  value: "main_database"
  export: override_optional
}

constant: STATEMENTS_SCHEMA {
  value: "public"
  export: override_optional
}

constant: SCRATCH_SCHEMA {
  value: "temp_looker_schema"
  export: override_optional
}

constant: PII_QUERY_TEXT {
  value: "SHOW"
  export: override_optional
}

constant: MAX_CONNECTIONS {
  value: "1000"
  export: override_optional
}

# --------------------------------------------------------------------------
# Advanced Drilling & Visualization Configurations Library
# --------------------------------------------------------------------------

constant: DRILL_LINE_VIZ {
  value: "{% assign vis_config = '{
    \"type\": \"looker_line\",
    \"x_axis_gridlines\": false,
    \"y_axis_gridlines\": true,
    \"show_view_names\": false,
    \"show_y_axis_labels\": true,
    \"show_y_axis_ticks\": true,
    \"show_x_axis_label\": true,
    \"show_x_axis_ticks\": true,
    \"interpolation\": \"linear\",
    \"show_null_points\": true,
    \"x_axis_zoom\": true,
    \"y_axis_zoom\": true
  }' %}"
}

constant: DRILL_COLUMN_VIZ {
  value: "{% assign vis_config = '{
    \"type\": \"looker_column\",
    \"x_axis_gridlines\": false,
    \"y_axis_gridlines\": true,
    \"show_view_names\": false,
    \"show_y_axis_labels\": true,
    \"show_y_axis_ticks\": true,
    \"show_x_axis_label\": true,
    \"show_x_axis_ticks\": true,
    \"stacking\": \"\",
    \"show_value_labels\": true
  }' %}"
}

constant: DRILL_PIE_VIZ {
  value: "{% assign vis_config = '{
    \"type\": \"looker_pie\",
    \"value_labels\": \"legend\",
    \"label_type\": \"labPer\",
    \"inner_radius\": 50,
    \"show_view_names\": false
  }' %}"
}

constant: DRILL_AREA_VIZ {
  value: "{% assign vis_config = '{
    \"type\": \"looker_area\",
    \"stacking\": \"normal\",
    \"x_axis_gridlines\": false,
    \"y_axis_gridlines\": true,
    \"show_y_axis_labels\": true,
    \"show_x_axis_label\": true,
    \"interpolation\": \"monotone\",
    \"point_style\": \"none\",
    \"show_view_names\": false
  }' %}"
}

constant: DRILL_SCATTER_VIZ {
  value: "{% assign vis_config = '{
    \"type\": \"looker_scatter\",
    \"x_axis_gridlines\": false,
    \"y_axis_gridlines\": true,
    \"show_y_axis_labels\": true,
    \"show_x_axis_label\": true,
    \"point_style\": \"circle\",
    \"cluster_points\": false,
    \"show_view_names\": false
  }' %}"
}

constant: DRILL_SINGLE_VALUE_VIZ {
  value: "{% assign vis_config = '{
    \"type\": \"single_value\",
    \"show_single_value_title\": true,
    \"show_comparison\": false
  }' %}"
}

constant: DRILL_TEMP_SPILL_VIZ {
  value: "{% assign vis_config = '{
    \"show_view_names\": false,
    \"show_row_numbers\": true,
    \"transpose\": false,
    \"truncate_text\": false,
    \"hide_totals\": false,
    \"hide_row_totals\": false,
    \"size_to_fit\": true,
    \"table_theme\": \"white\",
    \"limit_displayed_rows\": false,
    \"enable_conditional_formatting\": false,
    \"header_text_alignment\": \"left\",
    \"header_font_size\": \"12\",
    \"rows_font_size\": \"12\",
    \"conditional_formatting_include_totals\": false,
    \"conditional_formatting_include_nulls\": false,
    \"show_sql_query_menu_options\": false,
    \"show_totals\": true,
    \"show_row_totals\": true,
    \"truncate_header\": false,
    \"minimum_column_width\": 75,
    \"series_cell_visualizations\": {
      \"pg_stat_statements.total_temp_blocks_written\": {
        \"is_active\": true
      },
      \"pg_stat_database.total_temp_bytes_gb\": {
        \"is_active\": true,
        \"palette\": {
          \"palette_id\": \"03c21747-ee8c-e279-3c17-aca55ab4d1e6\",
          \"collection_id\": \"looker-blocks\",
          \"custom_colors\": [
            \"#fce5b0\",
            \"#e8630e\"
          ]
        }
      }
    },
    \"table_show_footer\": false,
    \"table_enable_pagination\": false,
    \"table_page_size_options\": \"20, 50, 100\",
    \"table_column_hover_highlight_enable\": false,
    \"table_show_headers\": true,
    \"header_font_bold\": false,
    \"header_font_italic\": false,
    \"cell_font_weight\": \"\",
    \"cell_font_style\": \"\",
    \"cell_text_alignment\": \"\",
    \"table_custom_border_enable\": false,
    \"table_custom_border_width\": null,
    \"table_custom_border_style\": \"solid\",
    \"type\": \"looker_grid\",
    \"defaults_version\": 1
  }' %}"
}
