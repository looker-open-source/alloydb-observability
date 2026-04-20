---
- dashboard: alloydb_performance_overview
  title: AlloyDB Performance Overview
  extends: navbaralloydb
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: Xfoj3N2CrGFVnCBeKDnsCv
  layout: newspaper
  elements:
  - title: Total Compute Load
    name: Total Compute Load
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: single_value
    fields: [pg_stat_statements.total_execution_time_seconds]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
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
    listen: {}
    row: 0
    col: 0
    width: 6
    height: 3
     
  - title: Cache Hit Ratio
    name: Cache Hit Ratio
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: marketplace_viz_radial_gauge::radial_gauge-marketplace
    fields: [pg_stat_database.cache_hit_ratio]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
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
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 0
    range_max:
    title_hidden: true
    listen: {}
    row: 3
    col: 0
    width: 7
    height: 6
     
  - title: Transaction Failure Rate
    name: Transaction Failure Rate
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: single_value
    fields: [pg_stat_database.transaction_failure_rate]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
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
    defaults_version: 1
    range_max:
    hidden_pivots: {}
    listen: {}
    row: 0
    col: 12
    width: 6
    height: 3
     
  - title: Transaction Throughput (TPS)
    name: Transaction Throughput (TPS)
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: single_value
    fields: [pg_stat_database.tps]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
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
    defaults_version: 1
    range_max:
    hidden_pivots: {}
    listen: {}
    row: 0
    col: 6
    width: 6
    height: 3
     
  - title: Connection Saturation (%)
    name: Connection Saturation (%)
    model: operational_intelligence_alloy_db
    explore: alloydb_real_time_activity
    type: single_value
    fields: [pg_stat_activity.connection_saturation_pct, pg_stat_activity.total_connections]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    smart_single_value_size: false
    comparison_label: Active Connections
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Query Start Time: pg_stat_activity.query_start_time
    row: 0
    col: 18
    width: 6
    height: 3
     
  - title: Query Volume
    name: Query Volume
    model: operational_intelligence_alloy_db
    explore: alloydb_real_time_activity
    type: looker_area
    fields: [pg_stat_activity.total_connections, pg_stat_activity.query_start_time]
    filters:
      pg_stat_database.is_primary_database: ''
      pg_stat_activity.query_start_date: NOT NULL
      pg_stat_activity.total_connections: NOT NULL
    sorts: [pg_stat_activity.query_start_time desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Active Connections
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Query Start Time: pg_stat_activity.query_start_time
    row: 3
    col: 8
    width: 16
    height: 6
     
  - title: Live Traffic Breakdown
    name: Live Traffic Breakdown
    model: operational_intelligence_alloy_db
    explore: alloydb_real_time_activity
    type: looker_pie
    fields: [pg_stat_activity.total_connections, pg_stat_activity.traffic_source]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
    sorts: [pg_stat_activity.total_connections desc 0]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: false
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Active Connections
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    show_null_points: true
    interpolation: linear
    listen:
      Query Start Time: pg_stat_activity.query_start_time
    row: 12
    col: 0
    width: 12
    height: 7
     
  - title: WAL Generation Rate
    name: WAL Generation Rate
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: single_value
    fields: [pg_stat_statements.total_wal_generation_mb]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
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
    defaults_version: 1
    range_max:
    hidden_pivots: {}
    listen: {}
    row: 9
    col: 6
    width: 5
    height: 3
     
  - title: Deadlock Frequency
    name: Deadlock Frequency
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: single_value
    fields: [pg_stat_database.total_deadlocks]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
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
    defaults_version: 1
    range_max:
    hidden_pivots: {}
    listen: {}
    row: 9
    col: 13
    width: 5
    height: 3
     
  - title: Database DML Intensity
    name: Database DML Intensity
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: looker_donut_multiples
    fields: [pg_stat_database.total_dml_reads, pg_stat_database.total_dml_writes]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
    limit: 500
    column_limit: 50
    show_value_labels: true
    font_size: 12
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
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    range_max:
    hidden_pivots: {}
    listen: {}
    row: 12
    col: 12
    width: 12
    height: 7
     
  filters:
  - name: Query Start Time
    title: Query Start Time
    type: field_filter
    default_value: 1 hour
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: operational_intelligence_alloy_db
    explore: alloydb_real_time_activity
    listens_to_filters: []
    field: pg_stat_activity.query_start_time
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