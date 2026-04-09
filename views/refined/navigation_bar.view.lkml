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

  # dimension: data_date {
  #   type: date
  #   # hidden: yes
  #   sql: ${TABLE}.data_date ;;
  # }

  dimension: datname {
    hidden: no
    sql: ${TABLE}.datname ;;
  }

  dimension: horizontal_navigation_bar {
    label: "Navigation Bar"
    description: "A dynamic navigation bar to switch between AlloyDB dashboards."
    # type: string
    sql: '' ;;
    html:
    <div style="background: #ffffff; font-family: 'Google Sans', Arial, sans-serif; border-bottom: 1px solid #e0e0e0; padding: 12px; display: flex; align-items: center; justify-content: flex-start; gap: 15px;">

      {%- assign style_inactive = "display: inline-block; color: #5F6368; padding: 10px 20px; text-decoration: none; font-size: 16px; border-radius: 20px; border: 1px solid #DADCE0;" -%}
      {%- assign style_active = "display: inline-block; background-color: #E8F0FE; color: #1967D2; padding: 10px 20px; font-weight: bold; border-radius: 20px; text-decoration: none; font-size: 16px; border: 1px solid #1967D2; pointer-events: none; cursor: default;" -%}

      <!-- Dashboard 1: Executive Health -->
      {% if _explore._dashboard_url contains 'alloydb_performance_overview' %}
        <span style="{{ style_active }}">📊 Executive Health</span>
      {% else %}
        <a style="{{ style_inactive }}" href="/dashboards/operational_intelligence_alloy_db::alloydb_performance_overview?Database+Name={{ _filters['datname']  | url_encode }}">📊 Executive Health</a>
      {% endif %}

      <!-- Dashboard 2: Bottlenecks -->
      {% if _explore._dashboard_url contains 'bottleneck_analysis' %}
        <span style="{{ style_active }}">🔍 Bottleneck Analysis</span>
      {% else %}
        <a style="{{ style_inactive }}" href="/dashboards/operational_intelligence_alloy_db::bottleneck_analysis?Database+Name={{ _filters['datname'] | url_encode }}">🔍 Bottleneck Analysis</a>
      {% endif %}

      <!-- Dashboard 3: Looker Impact -->
      {% if _explore._dashboard_url contains 'looker_impact' %}
        <span style="{{ style_active }}">🎯 Looker Impact</span>
      {% else %}
        <a style="{{ style_inactive }}" href="/dashboards/operational_intelligence_alloy_db::looker_impact?Database+Name={{ _filters['datname'] | url_encode }}">🎯 Looker Impact</a>
      {% endif %}

    </div> ;;
  }
}
