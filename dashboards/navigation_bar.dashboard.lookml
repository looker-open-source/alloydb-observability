---
- dashboard: navbaralloydb
  title: NavBarAlloyDB
  preferred_viewer: dashboards-next
  description: ''
  layout: newspaper
  elements:
  - title: ''
    name: ''
    model: operational_intelligence_alloy_db
    explore: navigation_bar
    type: single_value
    fields: [navigation_bar.horizontal_navigation_bar]
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
      Database Name: navigation_bar.datname
    row: 0
    col: 0
    width: 24
    height: 3
  filters:
  - name: Database Name
    title: Database Name
    type: field_filter
    default_value: "%postgres%"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: operational_intelligence_alloy_db
    explore: alloydb_performance
    listens_to_filters: []
    field: pg_stat_database.datname
