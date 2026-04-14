view: pg_stat_statements {
  sql_table_name: @{STATEMENTS_SCHEMA}.pg_stat_statements ;;

  # --------------------------------------------------------------------------
  # Dimensions (1:1 Mapping with Database)
  # --------------------------------------------------------------------------

  dimension: queryid {
    primary_key: yes
    type: number
    sql: ${TABLE}.queryid ;;
  }

  dimension: userid {
    type: number
    sql: ${TABLE}.userid ;;
  }

  dimension: dbid {
    type: number
    sql: ${TABLE}.dbid ;;
  }

  dimension: query {
    type: string
    sql: ${TABLE}.query ;;
  }

  dimension: calls {
    type: number
    sql: ${TABLE}.calls ;;
  }

  dimension: total_exec_time {
    type: number
    sql: ${TABLE}.total_exec_time ;;
  }

  dimension: max_exec_time {
    type: number
    sql: ${TABLE}.max_exec_time ;;
  }

  dimension: rows {
    type: number
    sql: ${TABLE}.rows ;;
  }

  dimension: shared_blks_hit {
    type: number
    sql: ${TABLE}.shared_blks_hit ;;
  }

  dimension: shared_blks_read {
    type: number
    sql: ${TABLE}.shared_blks_read ;;
  }

  dimension: shared_blks_dirtied {
    type: number
    sql: ${TABLE}.shared_blks_dirtied ;;
  }

  dimension: shared_blks_written {
    type: number
    sql: ${TABLE}.shared_blks_written ;;
  }

  dimension: blk_read_time {
    type: number
    sql: ${TABLE}.blk_read_time ;;
  }

  dimension: blk_write_time {
    type: number
    sql: ${TABLE}.blk_write_time ;;
  }

  dimension: temp_blks_read {
    type: number
    sql: ${TABLE}.temp_blks_read ;;
  }

  dimension: temp_blks_written {
    type: number
    sql: ${TABLE}.temp_blks_written ;;
  }

  dimension: wal_bytes {
    type: number
    sql: ${TABLE}.wal_bytes ;;
  }
}
