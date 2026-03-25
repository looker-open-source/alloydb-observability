view: pg_stat_activity {
  sql_table_name: pg_catalog.pg_stat_activity ;;

  # --------------------------------------------------------------------------
  # Dimensions
  # --------------------------------------------------------------------------

  dimension: pid {
    primary_key: yes
    type: number
    description: "Process ID of this backend."
    sql: ${TABLE}.pid ;;
  }

  dimension: usesysid {
    type: number
    hidden: yes
    sql: ${TABLE}.usesysid ;;
  }

  dimension: datid {
    type: number
    hidden: yes
    sql: ${TABLE}.datid ;;
  }

  dimension: usename {
    type: string
    label: "User Name"
    description: "Name of the user logged into this backend."
    sql: ${TABLE}.usename ;;
  }

  dimension: datname {
    type: string
    label: "Database Name"
    description: "Name of the database this backend is connected to."
    sql: ${TABLE}.datname ;;
  }

  dimension: state {
    type: string
    description: "Current overall state of this backend."
    sql: ${TABLE}.state ;;
  }

  dimension: wait_event_type {
    type: string
    description: "The type of event for which the backend is waiting, if any."
    sql: ${TABLE}.wait_event_type ;;
  }

  dimension: query {
    type: string
    label: "Current Query"
    description: "Text of this backend's most recent query."
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
      minute10,
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
  # Measures
  # --------------------------------------------------------------------------

  measure: total_connections {
    type: count
    description: "Total number of connections, regardless of state."
  }

  measure: active_connections {
    type: count
    description: "Number of currently active query connections."
    filters: [state: "active"]
  }

  measure: idle_connections {
    type: count
    description: "Number of idle connections."
    filters: [state: "idle"]
  }
}
