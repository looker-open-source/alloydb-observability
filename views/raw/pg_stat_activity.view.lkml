view: pg_stat_activity {
  sql_table_name: pg_catalog.pg_stat_activity ;;

  # --------------------------------------------------------------------------
  # Dimensions (1:1 Mapping with Database)
  # --------------------------------------------------------------------------

  dimension: pid {
    primary_key: yes
    type: number
    sql: ${TABLE}.pid ;;
  }

  dimension: usesysid {
    type: number
    sql: ${TABLE}.usesysid ;;
  }

  dimension: datid {
    type: number
    sql: ${TABLE}.datid ;;
  }

  dimension: usename {
    type: string
    sql: ${TABLE}.usename ;;
  }

  dimension: datname {
    type: string
    sql: ${TABLE}.datname ;;
  }

  dimension: application_name {
    type: string
    sql: ${TABLE}.application_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: backend_type {
    type: string
    sql: ${TABLE}.backend_type ;;
  }

  dimension: wait_event_type {
    type: string
    sql: ${TABLE}.wait_event_type ;;
  }

  dimension: query {
    type: string
    sql: ${TABLE}.query ;;
  }

  dimension_group: query_start {
    type: time
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
    timeframes: [
      raw,
      time,
      minute,
      hour,
      date
    ]
    sql: ${TABLE}.state_change ;;
  }
}
