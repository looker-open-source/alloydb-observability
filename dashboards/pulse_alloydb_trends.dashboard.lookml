---
- dashboard: pulse_alloydb_trends
  title: Pulse AlloyDB Trends
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: 0RLuJhEcdPVLJJLtyjfkgZ
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
  - title: Compute Load (Secs)
    name: Compute Load (Secs)
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_trends
    type: single_value
    fields: [pg_stat_daily_trends.daily_execution_time_seconds]
    sorts: [pg_stat_database_daily_snapshot.snapshot_date desc]
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
    hidden_pivots: {}
    show_view_names: false
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: The total amount of CPU execution time consumed by all queries during
      the selected period.
    listen:
      Is Primary Database (Yes / No): pg_stat_daily_trends.is_primary_database
      Date: pg_stat_daily_trends.snapshot_date
      Database Name: pg_stat_daily_trends.datname
    row: 2
    col: 4
    width: 5
    height: 2
    tab_name: ''
  - title: Transaction Volume
    name: Transaction Volume
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_trends
    type: single_value
    fields: [pg_stat_daily_trends.daily_transactions]
    sorts: [pg_stat_database_daily_snapshot.snapshot_date desc]
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
    hidden_pivots: {}
    show_view_names: false
    defaults_version: 1
    note_state: collapsed
    note_display: above
    note_text: The total number of Commits and Rollbacks processed, representing the
      overall volume of database traffic.
    listen:
      Is Primary Database (Yes / No): pg_stat_daily_trends.is_primary_database
      Date: pg_stat_daily_trends.snapshot_date
      Database Name: pg_stat_daily_trends.datname
    row: 2
    col: 9
    width: 5
    height: 2
    tab_name: ''
  - title: Data Processed
    name: Data Processed
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_trends
    type: single_value
    fields: [pg_stat_daily_trends.daily_data_processed_gb]
    sorts: [pg_stat_database_daily_snapshot.snapshot_date desc]
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
    hidden_pivots: {}
    show_view_names: false
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: The total volume of data read from memory or physical disk by executing
      queries.
    listen:
      Is Primary Database (Yes / No): pg_stat_daily_trends.is_primary_database
      Date: pg_stat_daily_trends.snapshot_date
      Database Name: pg_stat_daily_trends.datname
    row: 2
    col: 14
    width: 5
    height: 2
    tab_name: ''
  - title: Cache Hit Ratio
    name: Cache Hit Ratio
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_trends
    type: single_value
    fields: [pg_stat_daily_trends.daily_cache_hit_ratio]
    sorts: [pg_stat_database_daily_snapshot.snapshot_date desc]
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
    hidden_pivots: {}
    show_view_names: false
    defaults_version: 1
    note_state: collapsed
    note_display: above
    note_text: The percentage of data blocks successfully read from RAM rather than
      requiring a physical disk read.
    listen:
      Is Primary Database (Yes / No): pg_stat_daily_trends.is_primary_database
      Date: pg_stat_daily_trends.snapshot_date
      Database Name: pg_stat_daily_trends.datname
    row: 2
    col: 19
    width: 5
    height: 2
    tab_name: ''
  - title: 'CPU Attribution: Looker vs Application'
    name: 'CPU Attribution: Looker vs Application'
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_trends
    type: looker_area
    fields: [pg_stat_statements.is_looker_query, pg_stat_daily_trends.snapshot_date,
      pg_stat_daily_trends.daily_execution_time_seconds]
    pivots: [pg_stat_statements.is_looker_query]
    fill_fields: [pg_stat_statements.is_looker_query, pg_stat_daily_trends.snapshot_date]
    sorts: [pg_stat_statements.is_looker_query, pg_stat_database_daily_snapshot.snapshot_date
        desc]
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
    hidden_pivots: {}
    defaults_version: 1
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    note_state: collapsed
    note_display: hover
    note_text: The distribution of database CPU load, categorized by queries originating
      from Looker BI versus other applications.
    listen:
      Is Primary Database (Yes / No): pg_stat_daily_trends.is_primary_database
      Date: pg_stat_daily_trends.snapshot_date
      Database Name: pg_stat_daily_trends.datname
    row: 7
    col: 0
    width: 24
    height: 6
    tab_name: ''
  - title: Temporary Space Spill (GB)
    name: Temporary Space Spill (GB)
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_trends
    type: looker_area
    fields: [pg_stat_daily_trends.snapshot_date, pg_stat_daily_trends.daily_temp_spill_gb]
    fill_fields: [pg_stat_daily_trends.snapshot_date]
    sorts: [pg_stat_database_daily_snapshot.snapshot_date desc]
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
    hidden_pivots: {}
    defaults_version: 1
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    note_state: collapsed
    note_display: hover
    note_text: The volume of data written to temporary disk files because query operations
      (like sorts or joins) exceeded allocated working memory.
    listen:
      Is Primary Database (Yes / No): pg_stat_daily_trends.is_primary_database
      Date: pg_stat_daily_trends.snapshot_date
      Database Name: pg_stat_daily_trends.datname
    row: 13
    col: 0
    width: 24
    height: 6
    tab_name: ''
  - name: ''
    type: text
    title_text: ''
    body_text: '[{"type":"h2","children":[{"text":"📈 Executive Summary"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 4
    width: 20
    height: 2
    tab_name: ''
  - name: " (2)"
    type: text
    title_text: ''
    body_text: '[{"type":"h2","children":[{"text":"🔍 Workload Attribution & Resource
      Trends"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 5
    col: 0
    width: 24
    height: 2
    tab_name: ''
  - title: " "
    name: " "
    model: operational_intelligence_alloy_db
    explore: navigation_bar
    type: single_value
    fields: [navigation_bar.vertical_navigation_bar]
    filters:
      navigation_bar.datname: "%%"
    sorts: [navigation_bar.vertical_navigation_bar]
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
    show_view_names: false
    font_size_main: ''
    orientation: auto
    show_title_navigation_bar.tabbed_navigation_bar: false
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    listen: {}
    row: 0
    col: 0
    width: 4
    height: 5
    tab_name: ''
  - title: Daily Data Processed
    name: Daily Data Processed
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_trends
    type: looker_area
    fields: [pg_stat_daily_trends.snapshot_date, pg_stat_daily_trends.daily_data_processed_gb]
    fill_fields: [pg_stat_daily_trends.snapshot_date]
    sorts: [pg_stat_daily_trends.snapshot_date desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: pg_stat_statements_daily_snapshot.overall_daily_data_processed_gb,
            id: pg_stat_statements_daily_snapshot.overall_daily_data_processed_gb,
            name: Overall Daily Data Processed (GB)}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    series_colors:
      pg_stat_statements_daily_snapshot.overall_daily_data_processed_gb: "#e8710a"
      pg_stat_daily_trends.daily_data_processed_gb: "#f9ab00"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Is Primary Database (Yes / No): pg_stat_daily_trends.is_primary_database
      Date: pg_stat_daily_trends.snapshot_date
      Database Name: pg_stat_daily_trends.datname
    row: 4
    col: 14
    width: 5
    height: 1
    tab_name: ''
  - title: 'Daily Compute Load (Secs) '
    name: 'Daily Compute Load (Secs) '
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_trends
    type: looker_area
    fields: [pg_stat_daily_trends.snapshot_date, pg_stat_daily_trends.daily_execution_time_seconds]
    fill_fields: [pg_stat_daily_trends.snapshot_date]
    sorts: [pg_stat_database_daily_snapshot.snapshot_date desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: pg_stat_statements_daily_snapshot.overall_daily_execution_time_seconds,
            id: pg_stat_statements_daily_snapshot.overall_daily_execution_time_seconds,
            name: Overall Daily Execution Time (Secs)}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Is Primary Database (Yes / No): pg_stat_daily_trends.is_primary_database
      Date: pg_stat_daily_trends.snapshot_date
      Database Name: pg_stat_daily_trends.datname
    row: 4
    col: 4
    width: 5
    height: 1
    tab_name: ''
  - title: Cache Hit Ratio (Copy)
    name: Cache Hit Ratio (Copy)
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_trends
    type: looker_area
    fields: [pg_stat_daily_trends.snapshot_date, pg_stat_daily_trends.daily_cache_hit_ratio]
    fill_fields: [pg_stat_daily_trends.snapshot_date]
    sorts: [pg_stat_daily_trends.snapshot_date desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: pg_stat_database_daily_snapshot.daily_cache_hit_ratio,
            id: pg_stat_database_daily_snapshot.daily_cache_hit_ratio, name: Daily
              Cache Hit Ratio}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    series_colors:
      pg_stat_database_daily_snapshot.daily_cache_hit_ratio: "#1e8e3e"
      pg_stat_daily_trends.daily_cache_hit_ratio: "#1e8e3e"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Is Primary Database (Yes / No): pg_stat_daily_trends.is_primary_database
      Date: pg_stat_daily_trends.snapshot_date
      Database Name: pg_stat_daily_trends.datname
    row: 4
    col: 19
    width: 5
    height: 1
    tab_name: ''
  - title: Daily Transaction Volume
    name: Daily Transaction Volume
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_trends
    type: looker_area
    fields: [pg_stat_daily_trends.snapshot_date, pg_stat_daily_trends.daily_transactions]
    fill_fields: [pg_stat_daily_trends.snapshot_date]
    sorts: [pg_stat_daily_trends.snapshot_date desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: pg_stat_database_daily_snapshot.daily_transactions,
            id: pg_stat_database_daily_snapshot.daily_transactions, name: Daily Transactions}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    series_colors:
      pg_stat_database_daily_snapshot.daily_transactions: "#d93025"
      pg_stat_daily_trends.daily_transactions: "#d93025"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Is Primary Database (Yes / No): pg_stat_daily_trends.is_primary_database
      Date: pg_stat_daily_trends.snapshot_date
      Database Name: pg_stat_daily_trends.datname
    row: 4
    col: 9
    width: 5
    height: 1
    tab_name: ''
  filters:
  - name: Is Primary Database (Yes / No)
    title: Is Primary Database (Yes / No)
    type: field_filter
    default_value: 'Yes'
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_toggles
      display: inline
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_trends
    listens_to_filters: []
    field: pg_stat_daily_trends.is_primary_database
  - name: Database Name
    title: Database Name
    type: field_filter
    default_value: "%%"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_trends
    listens_to_filters: [Is Primary Database (Yes / No)]
    field: pg_stat_daily_trends.datname
  - name: Date
    title: Date
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_trends
    listens_to_filters: []
    field: pg_stat_daily_trends.snapshot_date
