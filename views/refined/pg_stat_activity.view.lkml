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
    timeframes: [raw, time, minute, hour, date]
    sql: ${TABLE}.query_start ;;
  }

  # --------------------------------------------------------------------------
  # Instance Utilization (Primary vs Read Pool)
  # --------------------------------------------------------------------------

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

  # --------------------------------------------------------------------------
  # Looker Workload Identification (Enhanced Logic)
  # --------------------------------------------------------------------------

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

  # --------------------------------------------------------------------------
  # LIVE FORENSICS: Waiting & Blocking
  # --------------------------------------------------------------------------

  dimension: is_waiting {
    type: yesno
    description: "Identifies if the session is currently stuck waiting for an event (e.g., a Lock)."
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
    description: "Identifies if this PID is a parallel worker process spawned by a leader query."
    group_label: "Connection Details"
    sql: ${TABLE}.leader_pid IS NOT NULL ;;
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

  measure: stuck_session_count {
    type: count
    label: "Stuck Sessions (Locks)"
    description: "Number of sessions currently waiting on a database lock. Spikes indicate severe performance bottlenecks."
    group_label: "Connection Metrics"
    filters: [is_blocked_by_lock: "yes"]
    drill_fields: [pid, usename, wait_event_type, query]
  }

  measure: max_query_age_seconds {
    type: max
    description: "The age of the longest-running active query in the database."
    group_label: "Execution Metrics"
    sql: ${query_age_seconds} ;;
    filters: [state: "active"]
  }

  # KPI 4: Connection Saturation %
  measure: connection_saturation_pct {
    type: number
    label: "Connection Saturation (%)"
    description: "Percentage of maximum allowed connections currently in use. Calculated as current connections / MAX_CONNECTIONS constant."
    group_label: "Connection Metrics"
    value_format_name: percent_1
    sql:
      1.0 * ${total_connections} /
      NULLIF(@{MAX_CONNECTIONS}, 0) ;;
  }

  # KPI 8: Idle-in-Transaction Age
  measure: max_idle_in_transaction_age_seconds {
    type: max
    label: "Max Idle-in-Transaction Age (Secs)"
    description: "The age of the longest-running session that is currently in the 'idle in transaction' state. These sessions are dangerous as they hold locks while doing nothing for extended periods. Official PostgreSQL Documentation: pg_stat_activity.state_change."
    group_label: "Execution Metrics"
    value_format_name: decimal_0
    sql: EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - ${TABLE}.state_change)) ;;
    filters: [state: "idle in transaction"]
  }

  # KPI 10 Fix: Snapshot/Peak Concurrency
  measure: current_active_connections {
    type: count
    label: "Active Connections (Snapshot)"
    description: "The number of active connections at the exact moment of the query. Represents the 'Peak' in real-time dashboards."
    group_label: "Connection Metrics"
    filters: [state: "active"]
    value_format_name: decimal_0
  }
}
