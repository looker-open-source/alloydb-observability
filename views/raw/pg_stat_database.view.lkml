view: pg_stat_database {
  sql_table_name: pg_catalog.pg_stat_database ;;

  # --------------------------------------------------------------------------
  # Dimensions (1:1 Mapping with Database)
  # --------------------------------------------------------------------------

  dimension: datid {
    primary_key: yes
    type: number
    sql: ${TABLE}.datid ;;
  }

  dimension: datname {
    type: string
    sql: ${TABLE}.datname ;;
  }

  dimension: xact_commit {
    type: number
    sql: ${TABLE}.xact_commit ;;
  }

  dimension: xact_rollback {
    type: number
    sql: ${TABLE}.xact_rollback ;;
  }

  dimension: blks_read {
    type: number
    sql: ${TABLE}.blks_read ;;
  }

  dimension: blks_hit {
    type: number
    sql: ${TABLE}.blks_hit ;;
  }

  dimension: tup_inserted {
    type: number
    sql: ${TABLE}.tup_inserted ;;
  }

  dimension: tup_updated {
    type: number
    sql: ${TABLE}.tup_updated ;;
  }

  dimension: tup_deleted {
    type: number
    sql: ${TABLE}.tup_deleted ;;
  }

  dimension: tup_fetched {
    type: number
    sql: ${TABLE}.tup_fetched ;;
  }

  dimension: deadlocks {
    type: number
    sql: ${TABLE}.deadlocks ;;
  }

  dimension: temp_bytes {
    type: number
    sql: ${TABLE}.temp_bytes ;;
  }

  dimension: stats_reset {
    type: date_time
    sql: ${TABLE}.stats_reset ;;
  }
}
