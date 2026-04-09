---
- dashboard: bottleneck_analysis
  title: Query Performance & Bottleneck Analysis
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: HLdzFwhlM12o3z1I8g3LoZ
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
  - title: Top 10 Slowest Queries
    name: Top 10 Slowest Queries
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: looker_grid
    fields: [pg_stat_statements.query_formatted, pg_stat_statements.average_execution_time_ms]
    sorts: [pg_stat_statements.average_execution_time_ms desc 0]
    limit: 15
    column_limit: 50
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
    listen: {}
    row: 3
    col: 0
    width: 10
    height: 9
    tab_name: ''
  - title: High CPU / High Frequency
    name: High CPU / High Frequency
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: looker_scatter
    fields: [pg_stat_statements.query_formatted, pg_stat_statements.total_execution_time_seconds,
      pg_stat_statements.total_calls]
    sorts: [pg_stat_statements.total_execution_time_seconds desc 0]
    limit: 10
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
    x_axis_zoom: true
    y_axis_zoom: true
    cluster_points: false
    quadrants_enabled: true
    quadrant_properties:
      '0':
        color: "#ebf2ff"
        label: The Slow Explorers
      '1':
        color: "#fce6e3"
        label: The CPU Burners
      '2':
        color: "#effff1"
        label: The Efficient Queries
      '3':
        color: "#fff3c7"
        label: The Busy Bees
    custom_quadrant_point_x: 5
    custom_quadrant_point_y: 5
    custom_x_column: ''
    custom_y_column: ''
    custom_value_label_column: ''
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
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [pg_stat_statements.query_formatted]
    hidden_pivots: {}
    listen: {}
    row: 3
    col: 10
    width: 14
    height: 9
    tab_name: ''
  - title: The Query Inspector Table
    name: The Query Inspector Table
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: looker_grid
    fields: [pg_stat_statements.query_formatted, pg_stat_statements.is_looker_query,
      pg_stat_statements.total_calls, pg_stat_statements.average_execution_time_ms,
      pg_stat_statements.total_execution_time_seconds, pg_stat_statements.max_execution_time_ms]
    sorts: [pg_stat_statements.total_calls desc 0]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      pg_stat_statements.total_calls:
        is_active: true
      pg_stat_statements.total_execution_time_seconds:
        is_active: true
        value_display: true
    table_show_footer: false
    table_enable_pagination: false
    table_page_size_options: 20, 50, 100
    table_column_hover_highlight_enable: false
    table_show_headers: true
    header_font_bold: false
    header_font_italic: false
    cell_font_size: '12'
    cell_font_weight: ''
    cell_font_style: ''
    cell_text_alignment: ''
    table_custom_border_enable: false
    table_custom_border_width:
    table_custom_border_color: "#dde2eb"
    table_custom_border_style: solid
    conditional_formatting: [{type: greater than, value: 1, fields: [pg_stat_statements.average_execution_time_ms],
        apply_formatting_to_row: false, cell_format: {background_color: "#ebbbb9",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {mirror: false,
              reverse: false, stepped: false}}, font_style: {bold: false, italic: false,
            strikethrough: false}}, row_format: {background_color: "#1A73E8", font_color: !!null '',
          color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, field: pg_stat_statements.total_calls,
        apply_to: selectFields}, {type: greater than, value: 99, fields: [pg_stat_statements.max_execution_time_ms],
        apply_formatting_to_row: false, cell_format: {background_color: "#e8bae4",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {mirror: false,
              reverse: false, stepped: false}}, font_style: {bold: false, italic: false,
            strikethrough: false}}, row_format: {background_color: "#1A73E8", font_color: !!null '',
          color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, field: pg_stat_statements.total_calls,
        apply_to: selectFields}]
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    defaults_version: 1
    listen: {}
    row: 12
    col: 0
    width: 24
    height: 7
    tab_name: ''
  - title: _
    name: _
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: single_value
    fields: [navigation_bar.horizontal_navigation_bar]
    filters:
      pg_stat_activity.query_start_date: 7 days
      pg_stat_database.datname: '"global_gadgets_demo"'
    sorts: [navigation_bar.horizontal_navigation_bar]
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
    hidden_pivots: {}
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 3
    tab_name: ''
