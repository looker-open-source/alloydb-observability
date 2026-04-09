- dashboard: navigation_bar
  title: navigation_bar
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: NavBar
    name: NavBar
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    type: single_value
    fields: [navigation_bar.horizontal_navigation_bar]
    sorts: [navigation_bar.horizontal_navigation_bar]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    listen:
      Database Name: pg_stat_database.datname
    row: 0
    col: 0
    width: 24
    height: 2

  filters:
  - name: Database Name
    title: Database Name
    type: field_filter
    default_value: "postgres"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    listens_to_filters: []
    field: pg_stat_database.datname
