---
- dashboard: bottleneck_analysis
  title: Query Performance & Bottleneck Analysis
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: kOT2ysYLQ3TEj8bIwA0cQK
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
  - title: ''
    name: ''
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
    height: 4
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
    note_state: collapsed
    note_display: hover
    note_text: The complete master ledger of all queries. Click any Query Hash to
      drill down into latency trends and top users for that specific statement.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 27
    col: 0
    width: 24
    height: 7
    tab_name: ''
  - title: Top 25 Slowest Queries
    name: Top 25 Slowest Queries
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: looker_grid
    fields: [pg_stat_statements.query_formatted, pg_stat_statements.average_execution_time_ms]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
    sorts: [pg_stat_statements.average_execution_time_ms desc 0]
    limit: 25
    column_limit: 50
    show_view_names: true
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
    show_value_labels: true
    font_size: 12
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
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
    defaults_version: 1
    range_max:
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: Ranked by Average Execution Time. These queries have the worst latency
      and degrade user experience.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 5
    col: 0
    width: 10
    height: 12
    tab_name: ''
  - title: High CPU / High Frequency
    name: High CPU / High Frequency
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: looker_scatter
    fields: [pg_stat_statements.query_formatted, pg_stat_statements.total_execution_time_seconds,
      pg_stat_statements.total_calls]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
    sorts: [pg_stat_statements.total_execution_time_seconds desc 0]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
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
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    y_axes: [{label: Execution Time (Secs), orientation: left, series: [{axisId: pg_stat_statements.total_execution_time_seconds,
            id: pg_stat_statements.total_execution_time_seconds, name: Pg Stat Statements
              Total Execution Time (Secs)}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: Total Calls
    size_by_field: pg_stat_statements.total_calls
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: false
    font_size: '12'
    trellis_rows: 2
    series_colors:
      pg_stat_statements.total_execution_time_seconds: "#1A73E8"
    series_labels: {}
    cluster_points: false
    quadrants_enabled: true
    quadrant_properties:
      '0':
        color: "#fffee8"
        label: The Slow Explorers
      '1':
        color: "#ffb394"
        label: The CPU Burners
      '2':
        color: "#b4d965"
        label: The Efficient Queries
      '3':
        color: "#fff3c7"
        label: The Busy Bees
    custom_quadrant_point_x: 5
    custom_quadrant_point_y: 5
    custom_x_column: pg_stat_statements.total_calls
    custom_y_column: pg_stat_statements.total_execution_time_seconds
    custom_value_label_column: ''
    series_tooltip_options:
      pg_stat_statements.total_execution_time_seconds:
        custom_tooltips_enabled: false
        style:
          font_size: 12
          font_family: Roboto, 'Noto Sans', 'Noto Sans JP', 'Noto Sans CJK KR', 'Noto
            Sans Arabic UI', 'Noto Sans Devanagari UI', 'Noto Sans Hebrew', 'Noto
            Sans Thai UI', Helvetica, Arial, sans-serif
          font_color: "#FFFFFF"
          background_color: "#262D33"
          border_radius: 16
          border_color: transparent
          box_shadow: none
          align: left
        template: |-
          <div style="padding: 5px 0;">
                <div>Pg Stat Statements Total Execution Time (Secs)</div>
                <div style="font-weight: bold;">{{ pg_stat_statements.total_execution_time_seconds }}</div>
              </div>
    hidden_fields: [pg_stat_statements.query_formatted]
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
    show_null_labels: true
    note_state: collapsed
    note_display: hover
    note_text: The Top-Right quadrant shows queries that are both slow AND run frequently.
      Optimizing these yields the highest CPU savings.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 5
    col: 10
    width: 14
    height: 12
    tab_name: ''
  - title: The Query Inspector Table
    name: The Query Inspector Table (2)
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: looker_grid
    fields: [pg_stat_statements.query_formatted, pg_stat_statements.is_looker_query,
      pg_stat_statements.total_calls, pg_stat_statements.average_execution_time_ms,
      pg_stat_statements.total_execution_time_seconds, pg_stat_statements.max_execution_time_ms]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
    sorts: [pg_stat_statements.total_calls desc 0]
    limit: 20
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
    series_labels: {}
    series_cell_visualizations:
      pg_stat_statements.total_calls:
        is_active: true
      pg_stat_statements.average_execution_time_ms:
        is_active: false
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
    conditional_formatting: [{type: along a scale..., value: !!null '', fields: [
          pg_stat_statements.average_execution_time_ms], apply_formatting_to_row: false,
        cell_format: {background_color: "#1A73E8", font_color: !!null '', color_application: {
            collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2, palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab,
            options: {steps: 5, mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, row_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, field: pg_stat_statements.total_calls,
        apply_to: selectFields}, {type: along a scale..., value: !!null '', fields: [
          pg_stat_statements.total_execution_time_seconds], apply_formatting_to_row: false,
        cell_format: {background_color: "#1A73E8", font_color: !!null '', color_application: {
            collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2, palette_id: f0077e50-e03c-4a7e-930c-7321b2267283,
            options: {steps: 5, mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, row_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, field: pg_stat_statements.total_calls,
        apply_to: selectFields}, {type: along a scale..., value: !!null '', fields: [
          pg_stat_statements.max_execution_time_ms], apply_formatting_to_row: false,
        cell_format: {background_color: "#1A73E8", font_color: !!null '', color_application: {
            collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2, custom: {id: 0fb36fba-7cf8-c5a4-cd7f-8b3f2bf831b7,
              label: Custom, type: continuous, stops: [{color: "#FFFFFF", offset: 0},
                {color: "#1ba626", offset: 100}]}, options: {steps: 5, mirror: false,
              reverse: false, stepped: false}}, font_style: {bold: false, italic: false,
            strikethrough: false}}, row_format: {background_color: "#1A73E8", font_color: !!null '',
          color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, field: pg_stat_statements.total_calls,
        apply_to: selectFields}]
    series_tooltip_options:
      pg_stat_statements.total_execution_time_seconds:
        custom_tooltips_enabled: false
        style:
          font_size: 12
          font_family: Roboto, 'Noto Sans', 'Noto Sans JP', 'Noto Sans CJK KR', 'Noto
            Sans Arabic UI', 'Noto Sans Devanagari UI', 'Noto Sans Hebrew', 'Noto
            Sans Thai UI', Helvetica, Arial, sans-serif
          font_color: "#FFFFFF"
          background_color: "#262D33"
          border_radius: 16
          border_color: transparent
          box_shadow: none
          align: left
        template: |-
          <div style="padding: 5px 0;">
                <div>Pg Stat Statements Total Execution Time (Secs)</div>
                <div style="font-weight: bold;">{{ pg_stat_statements.total_execution_time_seconds }}</div>
              </div>
    x_axis_gridlines: false
    y_axis_gridlines: false
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
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    y_axes: [{label: Execution Time (Secs), orientation: left, series: [{axisId: pg_stat_statements.total_execution_time_seconds,
            id: pg_stat_statements.total_execution_time_seconds, name: Pg Stat Statements
              Total Execution Time (Secs)}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: Total Calls
    size_by_field: pg_stat_statements.total_calls
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: false
    font_size: '12'
    trellis_rows: 2
    series_colors:
      pg_stat_statements.total_execution_time_seconds: "#1A73E8"
    cluster_points: false
    quadrants_enabled: true
    quadrant_properties:
      '0':
        color: "#fce6e3"
        label: The Slow Explorers
      '1':
        color: "#ffb394"
        label: The CPU Burners
      '2':
        color: "#b4d965"
        label: The Efficient Queries
      '3':
        color: "#fce6e3"
        label: The Busy Bees
    custom_quadrant_point_x: 5
    custom_quadrant_point_y: 5
    custom_x_column: pg_stat_statements.total_calls
    custom_y_column: pg_stat_statements.total_execution_time_seconds
    custom_value_label_column: ''
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
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    range_max:
    hidden_pivots: {}
    show_null_labels: true
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 17
    col: 0
    width: 24
    height: 10
    tab_name: ''
  - title: I/O Overhead Ratio
    name: I/O Overhead Ratio
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: looker_grid
    fields: [pg_stat_statements.query_formatted, pg_stat_statements.io_overhead_ratio]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
      pg_stat_statements.io_overhead_ratio: NOT NULL
    sorts: [pg_stat_statements.io_overhead_ratio desc 0]
    limit: 20
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
    header_font_size: '12'
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels: {}
    series_cell_visualizations:
      pg_stat_statements.total_calls:
        is_active: true
      pg_stat_statements.average_execution_time_ms:
        is_active: false
      pg_stat_statements.io_overhead_ratio:
        is_active: true
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
    conditional_formatting: [{type: along a scale..., value: !!null '', fields: [],
        apply_formatting_to_row: false, cell_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab, options: {steps: 5,
              mirror: false, reverse: false, stepped: false}}, font_style: {bold: false,
            italic: false, strikethrough: false}}, row_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, field: pg_stat_statements.total_calls,
        apply_to: selectFields}, {type: along a scale..., value: !!null '', fields: [],
        apply_formatting_to_row: false, cell_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            palette_id: f0077e50-e03c-4a7e-930c-7321b2267283, options: {steps: 5,
              mirror: false, reverse: false, stepped: false}}, font_style: {bold: false,
            italic: false, strikethrough: false}}, row_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, field: pg_stat_statements.total_calls,
        apply_to: selectFields}, {type: along a scale..., value: !!null '', fields: [],
        apply_formatting_to_row: false, cell_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            custom: {id: 0fb36fba-7cf8-c5a4-cd7f-8b3f2bf831b7, label: Custom, type: continuous,
              stops: [{color: "#FFFFFF", offset: 0}, {color: "#1ba626", offset: 100}]},
            options: {steps: 5, mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, row_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, field: pg_stat_statements.total_calls,
        apply_to: selectFields}]
    series_tooltip_options:
      pg_stat_statements.total_execution_time_seconds:
        custom_tooltips_enabled: false
        style:
          font_size: 12
          font_family: Roboto, 'Noto Sans', 'Noto Sans JP', 'Noto Sans CJK KR', 'Noto
            Sans Arabic UI', 'Noto Sans Devanagari UI', 'Noto Sans Hebrew', 'Noto
            Sans Thai UI', Helvetica, Arial, sans-serif
          font_color: "#FFFFFF"
          background_color: "#262D33"
          border_radius: 16
          border_color: transparent
          box_shadow: none
          align: left
        template: |-
          <div style="padding: 5px 0;">
                <div>Pg Stat Statements Total Execution Time (Secs)</div>
                <div style="font-weight: bold;">{{ pg_stat_statements.total_execution_time_seconds }}</div>
              </div>
    x_axis_gridlines: false
    y_axis_gridlines: false
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
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    y_axes: [{label: Execution Time (Secs), orientation: left, series: [{axisId: pg_stat_statements.total_execution_time_seconds,
            id: pg_stat_statements.total_execution_time_seconds, name: Pg Stat Statements
              Total Execution Time (Secs)}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: Total Calls
    size_by_field: pg_stat_statements.total_calls
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: false
    font_size: '12'
    trellis_rows: 2
    series_colors:
      pg_stat_statements.total_execution_time_seconds: "#1A73E8"
    cluster_points: false
    quadrants_enabled: true
    quadrant_properties:
      '0':
        color: "#fce6e3"
        label: The Slow Explorers
      '1':
        color: "#ffb394"
        label: The CPU Burners
      '2':
        color: "#b4d965"
        label: The Efficient Queries
      '3':
        color: "#fce6e3"
        label: The Busy Bees
    custom_quadrant_point_x: 5
    custom_quadrant_point_y: 5
    custom_x_column: pg_stat_statements.total_calls
    custom_y_column: pg_stat_statements.total_execution_time_seconds
    custom_value_label_column: ''
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
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    range_max:
    hidden_pivots: {}
    show_null_labels: true
    note_state: collapsed
    note_display: hover
    note_text: Queries spending the highest percentage of their time waiting on Disk
      Reads/Writes. Usually indicates missing indexes.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 34
    col: 0
    width: 16
    height: 8
    tab_name: ''
  - title: Temporary Space Spill (GB)
    name: Temporary Space Spill (GB)
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: single_value
    fields: [pg_stat_database.total_temp_bytes_gb, pg_stat_statements.total_temp_blocks_written]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
    limit: 20
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
    comparison_label: Blocks Writen
    conditional_formatting: [{type: along a scale..., value: !!null '', fields: [],
        apply_formatting_to_row: false, cell_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab, options: {steps: 5,
              mirror: false, reverse: false, stepped: false}}, font_style: {bold: false,
            italic: false, strikethrough: false}}, row_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, field: pg_stat_statements.total_calls,
        apply_to: selectFields}, {type: along a scale..., value: !!null '', fields: [],
        apply_formatting_to_row: false, cell_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            palette_id: f0077e50-e03c-4a7e-930c-7321b2267283, options: {steps: 5,
              mirror: false, reverse: false, stepped: false}}, font_style: {bold: false,
            italic: false, strikethrough: false}}, row_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, field: pg_stat_statements.total_calls,
        apply_to: selectFields}, {type: along a scale..., value: !!null '', fields: [],
        apply_formatting_to_row: false, cell_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            custom: {id: 0fb36fba-7cf8-c5a4-cd7f-8b3f2bf831b7, label: Custom, type: continuous,
              stops: [{color: "#FFFFFF", offset: 0}, {color: "#1ba626", offset: 100}]},
            options: {steps: 5, mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, row_format: {background_color: "#1A73E8",
          font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
            options: {mirror: false, reverse: false, stepped: false}}, font_style: {
            bold: false, italic: false, strikethrough: false}}, field: pg_stat_statements.total_calls,
        apply_to: selectFields}]
    series_tooltip_options:
      pg_stat_statements.total_execution_time_seconds:
        custom_tooltips_enabled: false
        style:
          font_size: 12
          font_family: Roboto, 'Noto Sans', 'Noto Sans JP', 'Noto Sans CJK KR', 'Noto
            Sans Arabic UI', 'Noto Sans Devanagari UI', 'Noto Sans Hebrew', 'Noto
            Sans Thai UI', Helvetica, Arial, sans-serif
          font_color: "#FFFFFF"
          background_color: "#262D33"
          border_radius: 16
          border_color: transparent
          box_shadow: none
          align: left
        template: |-
          <div style="padding: 5px 0;">
                <div>Pg Stat Statements Total Execution Time (Secs)</div>
                <div style="font-weight: bold;">{{ pg_stat_statements.total_execution_time_seconds }}</div>
              </div>
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_labels: {}
    series_cell_visualizations:
      pg_stat_statements.total_calls:
        is_active: true
      pg_stat_statements.average_execution_time_ms:
        is_active: false
      pg_stat_statements.io_overhead_ratio:
        is_active: true
    table_theme: white
    limit_displayed_rows: false
    table_show_footer: false
    table_enable_pagination: false
    table_page_size_options: 20, 50, 100
    table_column_hover_highlight_enable: false
    table_show_headers: true
    header_text_alignment: left
    header_font_bold: false
    header_font_italic: false
    header_font_size: '12'
    cell_font_size: '12'
    cell_font_weight: ''
    cell_font_style: ''
    cell_text_alignment: ''
    table_custom_border_enable: false
    table_custom_border_width:
    table_custom_border_color: "#dde2eb"
    table_custom_border_style: solid
    x_axis_gridlines: false
    y_axis_gridlines: false
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
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    y_axes: [{label: Execution Time (Secs), orientation: left, series: [{axisId: pg_stat_statements.total_execution_time_seconds,
            id: pg_stat_statements.total_execution_time_seconds, name: Pg Stat Statements
              Total Execution Time (Secs)}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: Total Calls
    size_by_field: pg_stat_statements.total_calls
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: false
    font_size: '12'
    trellis_rows: 2
    series_colors:
      pg_stat_statements.total_execution_time_seconds: "#1A73E8"
    cluster_points: false
    quadrants_enabled: true
    quadrant_properties:
      '0':
        color: "#fce6e3"
        label: The Slow Explorers
      '1':
        color: "#ffb394"
        label: The CPU Burners
      '2':
        color: "#b4d965"
        label: The Efficient Queries
      '3':
        color: "#fce6e3"
        label: The Busy Bees
    custom_quadrant_point_x: 5
    custom_quadrant_point_y: 5
    custom_x_column: pg_stat_statements.total_calls
    custom_y_column: pg_stat_statements.total_execution_time_seconds
    custom_value_label_column: ''
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
    defaults_version: 1
    range_max:
    hidden_pivots: {}
    hide_totals: false
    hide_row_totals: false
    rows_font_size: 12
    show_null_labels: true
    note_state: collapsed
    note_display: hover
    note_text: Total gigabytes spilled to disk because queries required more memory
      than 'work_mem' allowed. Look for unoptimized JOINs or ORDER BYs.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 37
    col: 16
    width: 8
    height: 2
    tab_name: ''
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h2","children":[{"text":"🚨 Real-Time Bottlenecks "}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 5
    width: 18
    height: 1
    tab_name: ''
  - name: " (3)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h2","children":[{"text":"🗄️ Historical Query Performace"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 4
    col: 0
    width: 24
    height: 1
    tab_name: ''
  - title: Stuck Sessions (Locks)
    name: Stuck Sessions (Locks)
    model: operational_intelligence_alloy_db
    explore: alloydb_real_time_activity
    type: single_value
    fields: [pg_stat_activity.stuck_session_count]
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
    note_state: collapsed
    note_display: hover
    note_text: Real-time count of queries currently blocked by database locks. >0
      requires immediate attention.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 1
    col: 4
    width: 9
    height: 2
    tab_name: ''
  - title: Longest Running Active Query (Secs)
    name: Longest Running Active Query (Secs)
    model: operational_intelligence_alloy_db
    explore: alloydb_real_time_activity
    type: single_value
    fields: [pg_stat_activity.max_query_age_seconds]
    filters:
      pg_stat_database.is_primary_database: 'Yes'
      pg_stat_activity.application_name: "-%Postgresql%,-%PostgreSQL%"
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
    note_state: collapsed
    note_display: hover
    note_text: The age (in seconds) of the oldest query currently executing. Watch
      for "Zombie" queries.
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 1
    col: 14
    width: 10
    height: 2
    tab_name: ''
  - title: Looker's Workload Share
    name: Looker's Workload Share
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: looker_grid
    fields: [pg_stat_statements.workload_share]
    filters:
      pg_stat_database.is_primary_database: ''
      pg_stat_statements.is_looker_query: ''
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
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 44
    col: 0
    width: 12
    height: 6
    tab_name: ''
  - title: Database Load Attribution
    name: Database Load Attribution
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
    type: looker_pie
    fields: [pg_stat_statements.is_looker_query, pg_stat_statements.total_execution_time_seconds]
    fill_fields: [pg_stat_statements.is_looker_query]
    filters:
      pg_stat_database.is_primary_database: ''
    sorts: [pg_stat_statements.total_execution_time_seconds desc 0]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: pg_stat_statements.workload_share,
            id: pg_stat_statements.workload_share, name: Workload Share}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: pg_stat_statements.total_execution_time_seconds,
            id: pg_stat_statements.total_execution_time_seconds, name: Total Execution
              Time (Secs)}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
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
    font_size: 12
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
    listen:
      Is Primary Database (Yes / No): pg_stat_database.is_primary_database
      Database Name: pg_stat_database.datname
    row: 44
    col: 13
    width: 11
    height: 6
    tab_name: ''
  - name: " (4)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h2","children":[{"text":"Looker Attribution"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 42
    col: 0
    width: 24
    height: 2
    tab_name: ''
  - name: " (5)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: ''
    row: 34
    col: 16
    width: 8
    height: 3
    tab_name: ''
  filters:
  - name: Is Primary Database (Yes / No)
    title: Is Primary Database (Yes / No)
    type: field_filter
    default_value: 'Yes'
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    model: operational_intelligence_alloy_db
    explore: alloydb_historical_statements
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
    explore: alloydb_historical_statements
    listens_to_filters: [Is Primary Database (Yes / No)]
    field: pg_stat_database.datname
