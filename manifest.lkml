project_name: "operational-intelligence-alloy-db"

# --------------------------------------------------------------------------
# Constants
# --------------------------------------------------------------------------

constant: CONNECTION_NAME {
  value: "cymbal-gadgets-alloydb"
  export: override_optional
}

constant: DATABASE_NAME {
  value: "global_gadgets_demo"
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
# Note: The JSON below is heavily escaped to survive Looker's Liquid parser
# and URL encoding process. 

constant: DRILL_LINE_VIZ {
  value: "{% assign vis_config = '{\\\"type\\\": \\\"looker_line\\\", \\\"x_axis_gridlines\\\": false, \\\"y_axis_gridlines\\\": true, \\\"show_view_names\\\": false, \\\"show_y_axis_labels\\\": true, \\\"show_y_axis_ticks\\\": true, \\\"show_x_axis_label\\\": true, \\\"show_x_axis_ticks\\\": true, \\\"interpolation\\\": \\\"linear\\\", \\\"show_null_points\\\": true, \\\"x_axis_zoom\\\": true, \\\"y_axis_zoom\\\": true}' %}"
}

constant: DRILL_COLUMN_VIZ {
  value: "{% assign vis_config = '{\\\"type\\\": \\\"looker_column\\\", \\\"x_axis_gridlines\\\": false, \\\"y_axis_gridlines\\\": true, \\\"show_view_names\\\": false, \\\"show_y_axis_labels\\\": true, \\\"show_y_axis_ticks\\\": true, \\\"show_x_axis_label\\\": true, \\\"show_x_axis_ticks\\\": true, \\\"stacking\\\": \\\"\\\", \\\"show_value_labels\\\": true}' %}"
}

constant: DRILL_PIE_VIZ {
  value: "{% assign vis_config = '{\\\"type\\\": \\\"looker_pie\\\", \\\"value_labels\\\": \\\"legend\\\", \\\"label_type\\\": \\\"labPer\\\", \\\"inner_radius\\\": 50, \\\"show_view_names\\\": false}' %}"
}

constant: DRILL_AREA_VIZ {
  value: "{% assign vis_config = '{\\\"type\\\": \\\"looker_area\\\", \\\"stacking\\\": \\\"normal\\\", \\\"x_axis_gridlines\\\": false, \\\"y_axis_gridlines\\\": true, \\\"show_y_axis_labels\\\": true, \\\"show_x_axis_label\\\": true, \\\"interpolation\\\": \\\"monotone\\\", \\\"point_style\\\": \\\"none\\\", \\\"show_view_names\\\": false}' %}"
}

constant: DRILL_SCATTER_VIZ {
  value: "{% assign vis_config = '{\\\"type\\\": \\\"looker_scatter\\\", \\\"x_axis_gridlines\\\": false, \\\"y_axis_gridlines\\\": true, \\\"show_y_axis_labels\\\": true, \\\"show_x_axis_label\\\": true, \\\"point_style\\\": \\\"circle\\\", \\\"cluster_points\\\": false, \\\"show_view_names\\\": false}' %}"
}

constant: DRILL_SINGLE_VALUE_VIZ {
  value: "{% assign vis_config = '{\\\"type\\\": \\\"single_value\\\", \\\"show_single_value_title\\\": true, \\\"show_comparison\\\": false}' %}"
}
