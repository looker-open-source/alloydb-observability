- dashboard: looker_workload_impact
  title: Looker Workload Impact
  extends: navbaralloydb
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: 6x4RslgyN7HjZXSbZkKzLB
  layout: newspaper
  elements:
  - title: Workload Attribution
    name: Workload Attribution
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: looker_pie
    fields: [pg_stat_activity.traffic_source, pg_stat_activity.total_active_connections]
    sorts: [pg_stat_activity.total_active_connections desc 0]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 0
    col: 0
    width: 12
    height: 7
     
  - title: Concurrency & Stress Correlation
    name: Concurrency & Stress Correlation
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: looker_line
    fields: [pg_stat_activity.total_active_connections, pg_stat_activity.query_start_date,
      pg_stat_statements.average_execution_time_ms]
    fill_fields: [pg_stat_activity.query_start_date]
    filters:
      pg_stat_activity.query_start_date: NOT NULL
    sorts: [pg_stat_activity.total_active_connections desc 0]
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
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields:
    listen: {}
    row: 7
    col: 12
    width: 12
    height: 6
     
  - title: 'Resource Burn: Primary vs Read Pool'
    name: 'Resource Burn: Primary vs Read Pool'
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: looker_bar
    fields: [pg_stat_activity.usename, pg_stat_statements.total_execution_time_seconds]
    filters:
      pg_stat_activity.query_start_date: NOT NULL
    sorts: [pg_stat_statements.total_execution_time_seconds desc 0]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields:
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    listen: {}
    row: 0
    col: 12
    width: 12
    height: 7
     
  - title: Looker Cache Efficiency Ratio
    name: Looker Cache Efficiency Ratio
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: single_value
    fields: [pg_stat_statements.statement_cache_hit_ratio]
    filters:
      pg_stat_statements.is_looker_query: 'Yes'
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
    row: 7
    col: 0
    width: 12
    height: 6
     
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