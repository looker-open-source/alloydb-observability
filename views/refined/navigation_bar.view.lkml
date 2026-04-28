view: navigation_bar {

  # --------------------------------------------------------------------------
  # Navigation Bar View
  # This view serves as a dummy table to hold the dynamic navigation HTML.
  # It identifies the active dashboard via Liquid and styles links accordingly.
  # --------------------------------------------------------------------------


  derived_table: {
    sql:
    SELECT
      {% assign raw_filter = _filters['datname'] | replace: '%', '' | replace: '^', '' %}
      {{ raw_filter | sql_quote }} as datname
    ;;
  }

  dimension: datname {
    hidden: no
    sql: ${TABLE}.datname ;;
  }

  dimension: horizontal_navigation_bar {
    label: "Pill Navigation Bar"
    description: "A dynamic, pill-style navigation bar to switch between AlloyDB dashboards."
    # type: string
    sql: '' ;;
    html:
    <div style="background: #ffffff; font-family: 'Google Sans', Arial, sans-serif; border-bottom: 1px solid #e0e0e0; padding: 6px 12px; display: flex; align-items: center; justify-content: flex-start; gap: 10px;">

      {%- assign style_inactive = "display: inline-block; color: #5F6368; padding: 5px 12px; text-decoration: none; font-size: 17px; border-radius: 16px; border: 1px solid #DADCE0;" -%}
      {%- assign style_active = "display: inline-block; background-color: #E8F0FE; color: #1967D2; padding: 5px 12px; font-weight: bold; border-radius: 16px; text-decoration: none; font-size: 17px; border: 1px solid #1967D2; pointer-events: none; cursor: default;" -%}

      <!-- Dashboard 1: Performance Overview -->
      {% if _explore._dashboard_url contains 'alloydb_performance_overview' %}
        <span style="{{ style_active }}">📊 Performance Overview</span>
      {% else %}
        <a style="{{ style_inactive }}" href="/embed/dashboards/operational_intelligence_alloy_db::alloydb_performance_overview?Database+Name={{ _filters['datname']  | url_encode }}">📊 Performance Overview</a>
      {% endif %}

      <!-- Dashboard 2: Bottlenecks -->
      {% if _explore._dashboard_url contains 'bottleneck_analysis' %}
        <span style="{{ style_active }}">🔍 Bottleneck Analysis</span>
      {% else %}
        <a style="{{ style_inactive }}" href="/embed/dashboards/operational_intelligence_alloy_db::bottleneck_analysis?Database+Name={{ _filters['datname'] | url_encode }}">🔍 Bottleneck Analysis</a>
      {% endif %}

      <!-- Dashboard 3: Pulse AlloyDB Trends -->
      {% if _explore._dashboard_url contains 'pulse_alloydb_trends' %}
        <span style="{{ style_active }}">📈 Pulse AlloyDB Trends</span>
      {% else %}
        <a style="{{ style_inactive }}" href="/embed/dashboards/operational_intelligence_alloy_db::pulse_alloydb_trends">📈 Pulse AlloyDB Trends</a>
      {% endif %}

    </div> ;;
  }

  dimension: tabbed_navigation_bar {
    label: "Tabbed Navigation Bar"
    description: "An ultra-minimal tab navigation bar to switch between AlloyDB dashboards with no extra spacing."
    sql: '' ;;
    html:
    <div style="font-family: 'Google Sans', Arial, sans-serif; display: flex; align-items: flex-end; justify-content: flex-start; gap: 24px; margin: 0; padding: 0; line-height: 1;">

      {%- assign style_inactive = "display: inline-block; color: #5F6368; padding-bottom: 2px; text-decoration: none; font-size: 17px; border-bottom: 2px solid transparent; font-weight: 500;" -%}
      {%- assign style_active = "display: inline-block; color: #1A73E8; padding-bottom: 2px; font-weight: bold; text-decoration: none; font-size: 17px; border-bottom: 2px solid #1A73E8; pointer-events: none; cursor: default;" -%}

      <!-- Dashboard 1: Performance Overview -->
      {% if _explore._dashboard_url contains 'alloydb_performance_overview' %}
        <span style="{{ style_active }}">📊 Performance Overview</span>
      {% else %}
        <a style="{{ style_inactive }}" href="/embed/dashboards/operational_intelligence_alloy_db::alloydb_performance_overview?Database+Name={{ _filters['datname']  | url_encode }}">📊 Performance Overview</a>
      {% endif %}

      <!-- Dashboard 2: Bottlenecks -->
      {% if _explore._dashboard_url contains 'bottleneck_analysis' %}
        <span style="{{ style_active }}">🔍 Bottleneck Analysis</span>
      {% else %}
        <a style="{{ style_inactive }}" href="/embed/dashboards/operational_intelligence_alloy_db::bottleneck_analysis?Database+Name={{ _filters['datname'] | url_encode }}">🔍 Bottleneck Analysis</a>
      {% endif %}

      <!-- Dashboard 3: Pulse AlloyDB Trends -->
      {% if _explore._dashboard_url contains 'pulse_alloydb_trends' %}
        <span style="{{ style_active }}">📈 Pulse AlloyDB Trends</span>
      {% else %}
        <a style="{{ style_inactive }}" href="/embed/dashboards/operational_intelligence_alloy_db::pulse_alloydb_trends">📈 Pulse AlloyDB Trends</a>
      {% endif %}

    </div> ;;
  }

  dimension: vertical_navigation_bar {
    label: "Vertical Navigation Bar"
    description: "A vertical sidebar navigation menu to switch between AlloyDB dashboards."
    sql: '' ;;
    html:
    <div style="font-family: 'Google Sans', Arial, sans-serif; display: flex; flex-direction: column; align-items: flex-start; justify-content: flex-start; gap: 16px; margin: 0; padding: 12px 0;">

      {%- assign style_inactive = "display: block; color: #5F6368; text-decoration: none; font-size: 17px; font-weight: 500; border-left: 3px solid transparent; padding-left: 8px;" -%}
      {%- assign style_active = "display: block; color: #1A73E8; font-weight: bold; text-decoration: none; font-size: 17px; border-left: 3px solid #1A73E8; padding-left: 8px; pointer-events: none; cursor: default;" -%}

      <!-- Dashboard 1: Performance Overview -->
      {% if _explore._dashboard_url contains 'alloydb_performance_overview' %}
        <span style="{{ style_active }}">📊 Performance Overview</span>
      {% else %}
        <a style="{{ style_inactive }}" href="/embed/dashboards/operational_intelligence_alloy_db::alloydb_performance_overview?Database+Name={{ _filters['datname']  | url_encode }}">📊 Performance Overview</a>
      {% endif %}

      <!-- Dashboard 2: Bottlenecks -->
      {% if _explore._dashboard_url contains 'bottleneck_analysis' %}
        <span style="{{ style_active }}">🔍 Bottleneck Analysis</span>
      {% else %}
        <a style="{{ style_inactive }}" href="/embed/dashboards/operational_intelligence_alloy_db::bottleneck_analysis?Database+Name={{ _filters['datname'] | url_encode }}">🔍 Bottleneck Analysis</a>
      {% endif %}

      <!-- Dashboard 3: Pulse AlloyDB Trends -->
      {% if _explore._dashboard_url contains 'pulse_alloydb_trends' %}
        <span style="{{ style_active }}">📈 Pulse AlloyDB Trends</span>
      {% else %}
        <a style="{{ style_inactive }}" href="/embed/dashboards/operational_intelligence_alloy_db::pulse_alloydb_trends">📈 Pulse AlloyDB Trends</a>
      {% endif %}

    </div> ;;
  }
}
