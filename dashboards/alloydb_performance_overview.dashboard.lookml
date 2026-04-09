---
- dashboard: alloydb_performance_overview
  title: AlloyDB Performance Overview
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: Xfoj3N2CrGFVnCBeKDnsCv
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
  - title: Global Cache Hit Ratio
    name: Global Cache Hit Ratio
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: marketplace_viz_radial_gauge::radial_gauge-marketplace
    fields: [pg_stat_database.cache_hit_ratio]
    filters:
      pg_stat_activity.date_filter: 7 days
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    arm_length: 9
    arm_weight: 48
    spinner_length: 153
    spinner_weight: 25
    target_length: 10
    target_gap: 10
    target_weight: 8
    range_min: 0
    value_label_type: both
    value_label_font: 12
    value_label_padding: 45
    target_source: 'off'
    target_label_type: both
    target_label_font: 3
    label_font_size: 3
    spinner_type: needle
    fill_color: "#0092E5"
    background_color: "#CECECE"
    spinner_color: "#282828"
    range_color: "#282828"
    gauge_fill_type: segment
    fill_colors: ["#EE7772", "#ffed6f", "#7FCDAE"]
    viz_trellis_by: none
    trellis_rows: 2
    trellis_cols: 2
    angle: 90
    cutout: 30
    range_x: 1
    range_y: 1
    target_label_padding: 1.06
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 0
    hidden_pivots: {}
    title_hidden: true
    listen:
      Database Name: pg_stat_database.datname
      Date: pg_stat_activity.query_start_date
    row: 0
    col: 8
    width: 8
    height: 4
    tab_name: ''
  - title: Transaction Failure Rate
    name: Transaction Failure Rate
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: single_value
    fields: [pg_stat_database.transaction_failure_rate]
    filters:
      pg_stat_activity.date_filter: 7 days
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    arm_length: 9
    arm_weight: 48
    spinner_length: 153
    spinner_weight: 25
    target_length: 10
    target_gap: 10
    target_weight: 8
    range_min: 0
    value_label_type: both
    value_label_font: 12
    value_label_padding: 45
    target_source: 'off'
    target_label_type: both
    target_label_font: 3
    label_font_size: 3
    spinner_type: needle
    fill_color: "#0092E5"
    background_color: "#CECECE"
    spinner_color: "#282828"
    range_color: "#282828"
    gauge_fill_type: segment
    fill_colors: ["#EE7772", "#ffed6f", "#7FCDAE"]
    viz_trellis_by: none
    trellis_rows: 2
    trellis_cols: 2
    angle: 90
    cutout: 30
    range_x: 1
    range_y: 1
    target_label_padding: 1.06
    smart_single_value_size: false
    defaults_version: 1
    hidden_fields: []
    hidden_points_if_no: []
    hidden_pivots: {}
    series_labels: {}
    show_view_names: true
    listen:
      Database Name: pg_stat_database.datname
      Date: pg_stat_activity.query_start_date
    row: 0
    col: 16
    width: 8
    height: 4
    tab_name: ''
  - title: Total Compute Load
    name: Total Compute Load
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: single_value
    fields: [pg_stat_statements.total_execution_time_seconds]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Database Name: pg_stat_database.datname
      Date: pg_stat_activity.query_start_date
    row: 0
    col: 0
    width: 8
    height: 4
    tab_name: ''
  - title: Query Volume
    name: Query Volume
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: looker_area
    fields: [pg_stat_activity.total_connections, pg_stat_activity.query_start_date]
    fill_fields: [pg_stat_activity.query_start_date]
    filters:
      pg_stat_activity.date_filter: 7 days
      pg_stat_activity.query_start_date: NOT NULL
    sorts: [pg_stat_activity.query_start_date desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    trellis_rows: 2
    series_labels: {}
    hidden_fields: []
    hidden_points_if_no: []
    arm_length: 9
    arm_weight: 48
    spinner_length: 153
    spinner_weight: 25
    target_length: 10
    target_gap: 10
    target_weight: 8
    range_min: 0
    value_label_type: both
    value_label_font: 12
    value_label_padding: 45
    target_source: 'off'
    target_label_type: both
    target_label_font: 3
    label_font_size: 3
    spinner_type: needle
    fill_color: "#0092E5"
    background_color: "#CECECE"
    spinner_color: "#282828"
    range_color: "#282828"
    gauge_fill_type: segment
    fill_colors: ["#EE7772", "#ffed6f", "#7FCDAE"]
    viz_trellis_by: none
    trellis_cols: 2
    angle: 90
    cutout: 30
    range_x: 1
    range_y: 1
    target_label_padding: 1.06
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    range_max:
    listen:
      Database Name: pg_stat_database.datname
      Date: pg_stat_activity.query_start_date
    row: 4
    col: 0
    width: 14
    height: 6
    tab_name: ''
  - title: Live Traffic Breakdown
    name: Live Traffic Breakdown
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: looker_pie
    fields: [pg_stat_activity.total_connections, pg_stat_activity.traffic_source]
    filters:
      pg_stat_activity.date_filter: 7 days
      pg_stat_activity.query_start_date: NOT NULL
    sorts: [pg_stat_activity.total_connections desc 0]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    trellis_rows: 2
    point_style: none
    series_labels: {}
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    hidden_points_if_no: []
    arm_length: 9
    arm_weight: 48
    spinner_length: 153
    spinner_weight: 25
    target_length: 10
    target_gap: 10
    target_weight: 8
    range_min: 0
    value_label_type: both
    value_label_font: 12
    value_label_padding: 45
    target_source: 'off'
    target_label_type: both
    target_label_font: 3
    label_font_size: 3
    spinner_type: needle
    fill_color: "#0092E5"
    background_color: "#CECECE"
    spinner_color: "#282828"
    range_color: "#282828"
    gauge_fill_type: segment
    fill_colors: ["#EE7772", "#ffed6f", "#7FCDAE"]
    viz_trellis_by: none
    trellis_cols: 2
    angle: 90
    cutout: 30
    range_x: 1
    range_y: 1
    target_label_padding: 1.06
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    range_max:
    listen:
      Database Name: pg_stat_database.datname
      Date: pg_stat_activity.query_start_date
    row: 4
    col: 14
    width: 10
    height: 6
    tab_name: ''
  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    listens_to_filters: []
    field: pg_stat_activity.query_start_date
  - name: Database Name
    title: Database Name
    type: field_filter
    default_value: postgres
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    listens_to_filters: []
    field: pg_stat_database.datname
