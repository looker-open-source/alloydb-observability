include: "/views/raw/pg_stat_activity.view.lkml"

view: +pg_stat_activity {

  # --------------------------------------------------------------------------
  # PERIOD OVER PERIOD LOGIC (Integrated)
  # --------------------------------------------------------------------------

  filter: date_filter {
    view_label: "_PoP"
    label: "Comparison Date Filter"
    description: "Use this date filter in combination with the timeframes dimension for dynamic date filtering."
    type: date
    default_value: "7 days"
  }

  dimension: data_date {
    hidden: yes
    type: date
    sql: CAST(${TABLE}.query_start AS DATE) ;;
  }

  dimension_group: filter_start_date {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: CASE WHEN {% date_start date_filter %} IS NULL THEN '1970-01-01' ELSE CAST({% date_start date_filter %} AS DATE) END;;
  }

  dimension_group: filter_end_date {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: CASE WHEN {% date_end date_filter %} IS NULL THEN CURRENT_DATE ELSE CAST({% date_end date_filter %} AS DATE) END;;
  }

  dimension: interval {
    hidden: yes
    type: number
    sql: DATE_PART('day', ${filter_end_date_date}::timestamp - ${filter_start_date_date}::timestamp) ;;
  }

  dimension: previous_start_date {
    hidden: yes
    type: date
    sql: CAST(${filter_start_date_date}::timestamp - (${interval} * INTERVAL '1 day') AS DATE) ;;
  }

  dimension: is_current_period {
    hidden: yes
    type: yesno
    sql: ${data_date} > ${filter_start_date_date} AND ${data_date} <= ${filter_end_date_date} ;;
  }

  dimension: is_previous_period {
    hidden: yes
    type: yesno
    sql: ${data_date} > ${previous_start_date} AND ${data_date} <= ${filter_start_date_date} ;;
  }

  dimension: timeframes {
    hidden: no
    view_label: "_PoP"
    label: "Comparison Period"
    type: string
    case: {
      when: {
        sql: ${is_current_period} = true;;
        label: "Selected Period"
      }
      when: {
        sql: ${is_previous_period} = true;;
        label: "Previous Period"
      }
      else: "Not in time period"
    }
  }

  # --------------------------------------------------------------------------
  # Period-Over-Period (PoP) MEASURES
  # --------------------------------------------------------------------------

  measure: selected_period_active_connections {
    view_label: "_PoP"
    label: "Active Connections (Selected Period)"
    type: count_distinct
    sql: ${pid} ;;
    filters: [is_current_period: "yes", state: "active"]
    value_format_name: decimal_0
  }

  measure: previous_period_active_connections {
    view_label: "_PoP"
    label: "Active Connections (Previous Period)"
    type: count_distinct
    sql: ${pid} ;;
    filters: [is_previous_period: "yes", state: "active"]
    value_format_name: decimal_0
  }

  measure: selected_period_looker_connections {
    view_label: "_PoP"
    label: "Looker Connections (Selected Period)"
    type: count_distinct
    sql: ${pid} ;;
    filters: [is_current_period: "yes", state: "active", traffic_source: "Looker BI"]
    value_format_name: decimal_0
  }

  measure: previous_period_looker_connections {
    view_label: "_PoP"
    label: "Looker Connections (Previous Period)"
    type: count_distinct
    sql: ${pid} ;;
    filters: [is_previous_period: "yes", state: "active", traffic_source: "Looker BI"]
    value_format_name: decimal_0
  }

  # --------------------------------------------------------------------------
  # Refined Dimensions
  # --------------------------------------------------------------------------

  dimension: pid {
    primary_key: yes
    type: number
    description: "Process ID of this backend connection."
    group_label: "Connection Details"
    sql: ${TABLE}.pid ;;
  }

  dimension: usename {
    type: string
    label: "User Name"
    description: "Name of the user logged into this backend connection."
    group_label: "Connection Details"
    sql: ${TABLE}.usename ;;
  }

  dimension: datname {
    type: string
    label: "Database Name"
    description: "Name of the database this backend is connected to."
    group_label: "Connection Details"
    sql: ${TABLE}.datname ;;
  }

  dimension: application_name {
    type: string
    description: "Name of the application that is connected to this backend."
    group_label: "Connection Details"
    sql: ${TABLE}.application_name ;;
  }

  dimension: state {
    type: string
    description: "Current overall state of this backend."
    group_label: "Connection Status"
    sql: ${TABLE}.state ;;
  }

  dimension: wait_event_type {
    type: string
    description: "The type of event for which the backend is waiting, if any."
    group_label: "Connection Status"
    sql: ${TABLE}.wait_event_type ;;
  }

  dimension: query {
    type: string
    label: "Current Query Text"
    description: "Text of this backend's most recent query. If state is active, this is the currently executing query."
    group_label: "Query Information"
    sql: ${TABLE}.query ;;
  }

  # --------------------------------------------------------------------------
  # Dimension Groups
  # --------------------------------------------------------------------------

  dimension_group: query_start {
    type: time
    description: "Time when the currently active query was started."
    timeframes: [
      raw,
      time,
      minute,
      hour,
      date
    ]
    sql: ${TABLE}.query_start ;;
  }

  # --------------------------------------------------------------------------
  # Looker Workload Identification (Three-Pronged)
  # --------------------------------------------------------------------------

  dimension: traffic_source {
    type: string
    description: "Categorizes the connection as originating from Looker or another application."
    group_label: "Traffic Analysis"
    sql: CASE 
            WHEN ${application_name} LIKE '%Looker%' 
                 OR ${application_name} = 'PostgreSQL JDBC Driver' 
                 OR ${query} LIKE '%-- Looker%' THEN 'Looker BI'
            ELSE 'Other Application'
         END ;;
  }

  # --------------------------------------------------------------------------
  # Advanced Measures
  # --------------------------------------------------------------------------

  measure: total_connections {
    type: count
    description: "Total number of connections, regardless of their current state."
    group_label: "Connection Metrics"
  }

  measure: total_active_connections {
    type: count
    description: "Number of currently active query connections across all applications."
    group_label: "Connection Metrics"
    filters: [state: "active"]
    drill_fields: [pid, usename, application_name, query, query_start_time]
  }
}
