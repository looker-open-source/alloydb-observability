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
}
