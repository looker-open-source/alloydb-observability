---
- dashboard: alloydb_performance_overview
  title: AlloyDB Performance Overview
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: ldQeUnMqPyUvKdfdew23B1
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
  - name: ''
    type: text
    title_text: ''
    body_text: '[{"type":"h1","children":[{"text":"🏛️ Cumulative Instance Health
      (All-Time)"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 2
    col: 0
    width: 24
    height: 2
    tab_name: ''
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
    smart_single_value_size: false
    conditional_formatting: [{type: not null, value: !!null '', fields: !!null '',
        apply_formatting_to_row: false, cell_format: {background_color: "#1a73e8",
          font_color: !!null '', color_application: {collection_id: looker-blocks,
            palette_id: looker-blocks-sequential-0, options: {mirror: false, reverse: false,
              stepped: false}}, font_style: {bold: false, italic: false, strikethrough: false}},
        row_format: {background_color: "#1a73e8", font_color: !!null '', color_application: {
            collection_id: looker-blocks, options: {mirror: false, reverse: false,
              stepped: false}}, font_style: {bold: false, italic: false, strikethrough: false}},
        apply_to: allNumericFields}]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Total seconds of CPU time burned across all queries since stats reset.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 4
    col: 0
    width: 5
    height: 2
    tab_name: ''
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
    value_label_type: value
    value_label_font: 12
    value_label_padding: 45
    target_source: 'off'
    target_label_type: both
    target_label_font: 3
    label_font_size: 3
    spinner_type: needle
    fill_color: "#0092E5"
    background_color: "#70596b"
    spinner_color: "#282828"
    range_color: "#282828"
    gauge_fill_type: segment
    fill_colors: ["#d93025", "#f9ab00", "#1e8e3e"]
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
    note_state: collapsed
    note_display: hover
    note_text: Target > 99%. Percentage of data read from memory rather than disk.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 6
    col: 2
    width: 8
    height: 6
    tab_name: ''
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
    smart_single_value_size: false
    conditional_formatting: [{type: not null, value: !!null '', fields: !!null '',
        apply_formatting_to_row: false, cell_format: {background_color: "#f9ab00",
          font_color: !!null '', color_application: {collection_id: looker-blocks,
            palette_id: looker-blocks-sequential-0, options: {mirror: false, reverse: false,
              stepped: false}}, font_style: {bold: false, italic: false, strikethrough: false}},
        row_format: {background_color: "#1a73e8", font_color: !!null '', color_application: {
            collection_id: looker-blocks, options: {mirror: false, reverse: false,
              stepped: false}}, font_style: {bold: false, italic: false, strikethrough: false}},
        apply_to: allNumericFields}]
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
    note_state: collapsed
    note_display: hover
    note_text: Percentage of transactions resulting in a rollback.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 4
    col: 5
    width: 5
    height: 2
    tab_name: ''
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
    smart_single_value_size: false
    conditional_formatting: [{type: not null, value: !!null '', fields: !!null '',
        apply_formatting_to_row: false, cell_format: {background_color: "#12b5cb",
          font_color: !!null '', color_application: {collection_id: looker-blocks,
            palette_id: looker-blocks-sequential-0, options: {mirror: false, reverse: false,
              stepped: false}}, font_style: {bold: false, italic: false, strikethrough: false}},
        row_format: {background_color: "#1a73e8", font_color: !!null '', color_application: {
            collection_id: looker-blocks, options: {mirror: false, reverse: false,
              stepped: false}}, font_style: {bold: false, italic: false, strikethrough: false}},
        apply_to: allNumericFields}]
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
    note_state: collapsed
    note_display: hover
    note_text: Average transactions committed or rolled back per second.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 4
    col: 15
    width: 5
    height: 2
    tab_name: ''
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
    note_state: collapsed
    note_display: hover
    note_text: Percentage of maximum allowed connections currently in use.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
      Query Start Time: pg_stat_activity.query_start_time
    row: 20
    col: 0
    width: 7
    height: 6
    tab_name: ''
  - title: Query Volume
    name: Query Volume
    model: operational_intelligence_alloy_db
    explore: alloydb_real_time_activity
    type: looker_area
    fields: [pg_stat_activity.total_connections, pg_stat_activity.query_start_hour]
    filters:
      pg_stat_database.is_primary_database: ''
      pg_stat_activity.query_start_date: NOT NULL
      pg_stat_activity.total_connections: NOT NULL
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
    note_state: collapsed
    note_display: hover
    note_text: Count of active queries that began executing within the selected timeframe
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
      Query Start Time: pg_stat_activity.query_start_time
    row: 14
    col: 0
    width: 24
    height: 6
    tab_name: ''
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
    note_state: collapsed
    note_display: hover
    note_text: Real-time distribution of open connections grouped by originating application.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
      Query Start Time: pg_stat_activity.query_start_time
    row: 20
    col: 15
    width: 9
    height: 6
    tab_name: ''
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
    smart_single_value_size: false
    conditional_formatting: [{type: not null, value: !!null '', fields: !!null '',
        apply_formatting_to_row: false, cell_format: {background_color: "#681da8",
          font_color: !!null '', color_application: {collection_id: looker-blocks,
            palette_id: looker-blocks-sequential-0, options: {mirror: false, reverse: false,
              stepped: false}}, font_style: {bold: false, italic: false, strikethrough: false}},
        row_format: {background_color: "#1a73e8", font_color: !!null '', color_application: {
            collection_id: looker-blocks, options: {mirror: false, reverse: false,
              stepped: false}}, font_style: {bold: false, italic: false, strikethrough: false}},
        apply_to: allNumericFields}]
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
    note_state: collapsed
    note_display: hover
    note_text: Total megabytes written to the Write-Ahead Log. Indicates write-heavy
      workloads.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 4
    col: 20
    width: 4
    height: 2
    tab_name: ''
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
    smart_single_value_size: false
    conditional_formatting: [{type: not null, value: !!null '', fields: !!null '',
        apply_formatting_to_row: false, cell_format: {background_color: "#1e8e3e",
          font_color: !!null '', color_application: {collection_id: looker-blocks,
            palette_id: looker-blocks-sequential-0, options: {mirror: false, reverse: false,
              stepped: false}}, font_style: {bold: false, italic: false, strikethrough: false}},
        row_format: {background_color: "#1a73e8", font_color: !!null '', color_application: {
            collection_id: looker-blocks, options: {mirror: false, reverse: false,
              stepped: false}}, font_style: {bold: false, italic: false, strikethrough: false}},
        apply_to: allNumericFields}]
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
    note_state: collapsed
    note_display: hover
    note_text: Total deadlocks detected. High numbers indicate application transaction
      conflicts.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 4
    col: 10
    width: 5
    height: 2
    tab_name: ''
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
    series_colors:
      pg_stat_database.total_dml_writes: "#f9ab00"
    series_labels: {}
    hidden_fields: []
    hidden_points_if_no: []
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
    note_state: collapsed
    note_display: hover
    note_text: Ratio of Rows Fetched (Reads) vs. Rows Modified (Writes).
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 6
    col: 12
    width: 12
    height: 6
    tab_name: ''
  - name: " (2)"
    type: text
    title_text: ''
    body_text: '[{"type":"h1","children":[{"text":"⚡ Live Traffic Pulse (Filtered
      by Time)"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 12
    col: 0
    width: 24
    height: 2
    tab_name: ''
  - title: Current Wait Event Distribution
    name: Current Wait Event Distribution
    model: operational_intelligence_alloy_db
    explore: alloydb_real_time_activity
    type: looker_pie
    fields: [pg_stat_activity.wait_event_type, pg_stat_activity.total_active_connections]
    filters:
      pg_stat_database.is_primary_database: ''
      pg_stat_activity.is_waiting: 'Yes'
    sorts: [pg_stat_activity.total_active_connections desc 0]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    inner_radius: 50
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
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
      Query Start Time: pg_stat_activity.query_start_time
    row: 20
    col: 7
    width: 8
    height: 6
    tab_name: ''
  - title: " "
    name: " "
    model: operational_intelligence_alloy_db
    explore: navigation_bar
    type: single_value
    fields: [navigation_bar.tabbed_navigation_bar]
    filters:
      navigation_bar.datname: "%postgres%"
    sorts: [navigation_bar.tabbed_navigation_bar]
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
    width: 24
    height: 2
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
    explore: alloydb_real_time_activity
    listens_to_filters: []
    field: pg_stat_database.is_primary_database
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
    explore: alloydb_performance
    listens_to_filters: [Is Primary Database (Yes / No)]
    field: pg_stat_database.datname
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
