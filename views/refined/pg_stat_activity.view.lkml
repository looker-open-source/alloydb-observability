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

  measure: selected_period_active_connections {
    view_label: "_PoP"
    label: "Active Connections (Selected Period)"
    type: count_distinct
    description: "Count of distinct process IDs active during the selected period."
    sql: ${pid} ;;
    filters: [is_current_period: "yes", state: "active"]
    value_format_name: decimal_0
  }

  measure: previous_period_active_connections {
    view_label: "_PoP"
    label: "Active Connections (Previous Period)"
    type: count_distinct
    description: "Count of distinct process IDs active during the previous comparison period."
    sql: ${pid} ;;
    filters: [is_previous_period: "yes", state: "active"]
    value_format_name: decimal_0
  }

  measure: selected_period_looker_connections {
    view_label: "_PoP"
    label: "Looker Connections (Selected Period)"
    type: count_distinct
    description: "Count of distinct Looker process IDs active during the selected period."
    sql: ${pid} ;;
    filters: [is_current_period: "yes", state: "active", traffic_source: "Looker BI"]
    value_format_name: decimal_0
  }

  measure: previous_period_looker_connections {
    view_label: "_PoP"
    label: "Looker Connections (Previous Period)"
    type: count_distinct
    description: "Count of distinct Looker process IDs active during the previous comparison period."
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
    # drill_fields: [application_name, state, total_connections]

    # link: {
    #   label: "🍩 User's Application Share (Pie)"
    #   url: "@{DRILL_PIE_VIZ}{{ link }}&fields=pg_stat_activity.application_name,pg_stat_activity.total_connections&f[pg_stat_activity.usename]={{ value | url_encode }}&sorts=pg_stat_activity.total_connections+desc&limit=10&toggle=vis"
    # }

    # link: {
    #   label: "📊 User's Connection States (Bar)"
    #   url: "@{DRILL_COLUMN_VIZ}{{ link }}&fields=pg_stat_activity.state,pg_stat_activity.total_connections&f[pg_stat_activity.usename]={{ value | url_encode }}&sorts=pg_stat_activity.total_connections+desc&limit=10&toggle=vis"
    # }
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

    # link: {
    #   label: "🍩 User Distribution for this App (Pie)"
    #   url: "@{DRILL_PIE_VIZ}{{ link }}&fields=pg_stat_activity.usename,pg_stat_activity.total_connections&f[pg_stat_activity.application_name]={{ value | url_encode }}&sorts=pg_stat_activity.total_connections+desc&limit=10&toggle=vis"
    # }
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

    # link: {
    #   label: "🍩 Current Wait Event Distribution (Pie)"
    #   url: "@{DRILL_PIE_VIZ}{{ link }}&fields=pg_stat_activity.wait_event_type,pg_stat_activity.total_active_connections&f[pg_stat_activity.is_waiting]=yes&sorts=pg_stat_activity.total_active_connections+desc&limit=10&toggle=vis"
    # }
  }

  dimension: query {
    type: string
    label: "Current Query Text"
    description: "Text of this backend's most recent query."
    group_label: "Query Information"
    sql: ${TABLE}.query ;;
  }

  dimension_group: query_start {
    type: time
    description: "Time when the currently active query was started."
    timeframes: [raw, time, minute, hour, date]
    sql: ${TABLE}.query_start ;;
  }

  dimension: instance_role {
    type: string
    description: "Identifies if the query is running on the Primary Instance or an AlloyDB Read Pool."
    group_label: "Traffic Analysis"
    sql:
      CASE
        WHEN pg_is_in_recovery() THEN 'Read Pool'
        ELSE 'Primary Instance'
      END ;;
  }

  dimension: traffic_source {
    type: string
    description: "Categorizes the connection as originating from Looker or another application."
    group_label: "Traffic Analysis"
    sql: CASE
            WHEN ${application_name} LIKE '%Looker%'
                 OR ${application_name} LIKE '%PostgreSQL JDBC Driver%'
                 OR ${application_name} LIKE '%Looker-MCP%'
                 OR ${query} LIKE '%-- Looker%'
                 OR ${query} LIKE '%-- looker%' THEN 'Looker BI'
            ELSE 'Other Application'
         END ;;
  }

  dimension: is_waiting {
    type: yesno
    description: "Identifies if the session is currently stuck waiting for an event."
    group_label: "Connection Status"
    sql: ${wait_event_type} IS NOT NULL ;;
  }

  dimension: is_blocked_by_lock {
    type: yesno
    description: "Identifies if the session is specifically stuck waiting for a database lock."
    group_label: "Connection Status"
    sql: ${wait_event_type} = 'Lock' ;;
  }

  dimension: query_age_seconds {
    type: number
    description: "The number of seconds the current query has been running."
    group_label: "Execution Metrics"
    sql: EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - ${query_start_raw})) ;;
  }

  dimension: transaction_age_seconds {
    type: number
    description: "The number of seconds the current transaction has been open."
    group_label: "Execution Metrics"
    sql: EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - ${TABLE}.xact_start)) ;;
  }

  dimension: is_parallel_worker {
    type: yesno
    description: "Identifies if this PID is a parallel worker process."
    group_label: "Connection Details"
    sql: ${TABLE}.leader_pid IS NOT NULL ;;
  }

  # --------------------------------------------------------------------------
  # Advanced Measures
  # --------------------------------------------------------------------------

  measure: total_connections {
    type: count
    description: "Total number of connections."
    group_label: "Connection Metrics"
  }

  measure: total_active_connections {
    type: count
    description: "Number of currently active query connections."
    group_label: "Connection Metrics"
    filters: [state: "active"]
    # drill_fields: [application_name, usename, wait_event_type, total_active_connections]

    # link: {
    #   label: "📊 Active Connections by Application (Bar)"
    #   url: "@{DRILL_COLUMN_VIZ}{{ link }}&fields=pg_stat_activity.application_name,pg_stat_activity.usename,pg_stat_activity.total_active_connections&sorts=pg_stat_activity.total_active_connections+desc&limit=10&toggle=vis"
    # }

    # link: {
    #   label: "📈 Active Connection Trend (Area)"
    #   url: "@{DRILL_AREA_VIZ}{{ link }}&fields=pg_stat_activity.query_start_minute,pg_stat_activity.total_active_connections&pivots=pg_stat_activity.traffic_source&sorts=pg_stat_activity.query_start_minute+asc&limit=500&toggle=vis"
    # }

    # link: {
    #   label: "🍩 Current Wait Event Distribution (Pie)"
    #   url: "@{DRILL_PIE_VIZ}{{ link }}&fields=pg_stat_activity.wait_event_type,pg_stat_activity.total_active_connections&f[pg_stat_activity.is_waiting]=yes&sorts=pg_stat_activity.total_active_connections+desc&limit=10&toggle=vis"
    # }
  }

  measure: stuck_session_count {
    type: count
    label: "Stuck Sessions (Locks)"
    description: "Number of sessions currently waiting on a database lock."
    group_label: "Connection Metrics"
    filters: [is_blocked_by_lock: "yes"]
    drill_fields: [pid, usename, wait_event_type, query]
  }

  measure: max_query_age_seconds {
    type: max
    description: "The age of the longest-running active query."
    group_label: "Execution Metrics"
    sql: ${query_age_seconds} ;;
    filters: [state: "active"]
  }

  measure: connection_saturation_pct {
    type: number
    label: "Connection Saturation (%)"
    description: "Percentage of maximum allowed connections currently in use."
    group_label: "Connection Metrics"
    value_format_name: percent_1
    sql: 1.0 * ${total_connections} / NULLIF(@{MAX_CONNECTIONS}, 0) ;;
    # drill_fields: [query_start_time, state, connection_saturation_pct, total_connections]

    # link: {
    #   label: "📈 Saturation Trend (Area)"
    #   url: "@{DRILL_AREA_VIZ}{{ link }}&fields=pg_stat_activity.query_start_time,pg_stat_activity.state,pg_stat_activity.connection_saturation_pct&pivots=pg_stat_activity.state&sorts=pg_stat_activity.query_start_time+asc&limit=500&toggle=vis"
    # }

    # link: {
    #   label: "🍩 Current State Distribution (Pie)"
    #   url: "@{DRILL_PIE_VIZ}{{ link }}&fields=pg_stat_activity.state,pg_stat_activity.total_connections&sorts=pg_stat_activity.total_connections+desc&limit=10&toggle=vis"
    # }
  }

  measure: max_idle_in_transaction_age_seconds {
    type: max
    label: "Max Idle-in-Transaction Age (Secs)"
    description: "The age of the longest-running session that is currently in the 'idle in transaction' state."
    group_label: "Execution Metrics"
    value_format_name: decimal_0
    sql: EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - ${TABLE}.state_change)) ;;
    filters: [state: "idle in transaction"]
  }

  measure: current_active_connections {
    type: count
    label: "Active Connections (Snapshot)"
    description: "The number of active connections at the exact moment of the query."
    group_label: "Connection Metrics"
    filters: [state: "active"]
    value_format_name: decimal_0
    # drill_fields: [application_name, usename, current_active_connections]

    # link: {
    #   label: "📊 Active Connections by Application (Bar)"
    #   url: "@{DRILL_COLUMN_VIZ}{{ link }}&fields=pg_stat_activity.application_name,pg_stat_activity.usename,pg_stat_activity.current_active_connections&sorts=pg_stat_activity.current_active_connections+desc&limit=10&toggle=vis"
    # }
  }
}
