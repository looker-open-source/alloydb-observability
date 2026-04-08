include: "/views/raw/pg_stat_activity.view.lkml"

view: +pg_stat_activity {
  label: "Stat Activity"

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

  dimension: usesysid {
    type: number
    hidden: yes
    description: "OID of the user logged into this backend."
    group_label: "Connection Details"
    sql: ${TABLE}.usesysid ;;
  }

  dimension: datid {
    type: number
    hidden: yes
    description: "OID of the database this backend is connected to."
    group_label: "Connection Details"
    sql: ${TABLE}.datid ;;
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
    description: "Current overall state of this backend (e.g., active, idle, idle in transaction)."
    group_label: "Connection Status"
    sql: ${TABLE}.state ;;
  }

  dimension: wait_event_type {
    type: string
    description: "The type of event for which the backend is waiting, if any (e.g., Lock, IO)."
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

  dimension_group: state_change {
    type: time
    description: "Time when the state was last changed."
    timeframes: [
      raw,
      time,
      minute,
      hour,
      date
    ]
    sql: ${TABLE}.state_change ;;
  }

  # --------------------------------------------------------------------------
  # Looker Workload Identification
  # --------------------------------------------------------------------------

  dimension: traffic_source {
    type: string
    description: "Categorizes the connection as originating from Looker or another application based on the application_name."
    group_label: "Traffic Analysis"
    sql: CASE
            WHEN ${application_name} LIKE '%Looker%' THEN 'Looker BI'
            ELSE 'Other Application'
         END ;;
  }

  dimension: connection_state {
    type: string
    description: "Current overall state of this backend."
    group_label: "Connection Status"
    sql: ${state} ;;
  }

  # --------------------------------------------------------------------------
  # Advanced Measures
  # --------------------------------------------------------------------------

  measure: total_connections {
    type: count
    description: "Total number of connections, regardless of their current state."
    group_label: "Connection Metrics"
  }

  measure: active_looker_connections {
    type: count
    description: "Number of currently active connections originating specifically from Looker."
    group_label: "Connection Metrics"
    filters: [state: "active", traffic_source: "Looker BI"]
    drill_fields: [pid, usename, query, query_start_time, connection_state]
  }

  measure: total_active_connections {
    type: count
    description: "Number of currently active query connections across all applications."
    group_label: "Connection Metrics"
    filters: [state: "active"]
    drill_fields: [pid, usename, application_name, query, query_start_time, connection_state]
  }
}
