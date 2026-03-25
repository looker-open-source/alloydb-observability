view: pg_stat_database {
  sql_table_name: pg_catalog.pg_stat_database ;;

  # --------------------------------------------------------------------------
  # Dimensions
  # --------------------------------------------------------------------------

  dimension: datid {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.datid ;;
  }

  dimension: datname {
    type: string
    label: "Database Name"
    description: "Name of this database."
    sql: ${TABLE}.datname ;;
  }

  # --------------------------------------------------------------------------
  # Measures
  # --------------------------------------------------------------------------

  measure: total_commits {
    type: sum
    description: "Number of transactions in this database that have been committed."
    sql: ${TABLE}.xact_commit ;;
  }

  measure: total_rollbacks {
    type: sum
    description: "Number of transactions in this database that have been rolled back."
    sql: ${TABLE}.xact_rollback ;;
  }

  measure: blocks_read {
    type: sum
    hidden: yes
    sql: ${TABLE}.blks_read ;;
  }

  measure: blocks_hit {
    type: sum
    hidden: yes
    sql: ${TABLE}.blks_hit ;;
  }

  measure: cache_hit_ratio {
    type: number
    description: "Ratio of disk blocks found already in the buffer cache to total blocks read. High is better (> 0.99)."
    value_format_name: percent_2
    sql: 1.0 * ${blocks_hit} / NULLIF((${blocks_hit} + ${blocks_read}), 0) ;;
  }
}
