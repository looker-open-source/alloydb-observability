include: "/views/raw/pg_stat_database.view.lkml"

view: +pg_stat_database {
  label: "Stat Database"

  # --------------------------------------------------------------------------
  # Refined Dimensions
  # --------------------------------------------------------------------------

  dimension: is_primary_database {
    type: yesno
    description: "Identifies if this database matches the DATABASE_NAME constant."
    group_label: "Database Info"
    sql: ${datname} = '@{DATABASE_NAME}' ;;
  }

  dimension: datid {
    primary_key: yes
    type: number
    hidden: yes
    description: "OID of a database."
    group_label: "Database Info"
    sql: ${TABLE}.datid ;;
  }

  dimension: datname {
    type: string
    label: "Database Name"
    description: "Name of this database."
    group_label: "Database Info"
    sql: ${TABLE}.datname ;;
  }

  dimension: xact_commit {
    type: number
    hidden: yes
    description: "Number of transactions in this database that have been committed."
    group_label: "Transaction Stats"
    sql: ${TABLE}.xact_commit ;;
  }

  dimension: xact_rollback {
    type: number
    hidden: yes
    description: "Number of transactions in this database that have been rolled back."
    group_label: "Transaction Stats"
    sql: ${TABLE}.xact_rollback ;;
  }

  dimension: blks_read {
    type: number
    hidden: yes
    description: "Number of disk blocks read in this database."
    group_label: "Block Stats"
    sql: ${TABLE}.blks_read ;;
  }

  dimension: blks_hit {
    type: number
    hidden: yes
    description: "Number of times disk blocks were found already in the buffer cache."
    group_label: "Block Stats"
    sql: ${TABLE}.blks_hit ;;
  }

  # --------------------------------------------------------------------------
  # Advanced Measures & KPIs
  # --------------------------------------------------------------------------

  measure: total_commits {
    type: sum
    description: "Total number of transactions in this database that have been successfully committed."
    group_label: "Transaction Metrics"
    sql: ${xact_commit} ;;
  }

  measure: total_rollbacks {
    type: sum
    description: "Total number of transactions in this database that have been rolled back due to failures."
    group_label: "Transaction Metrics"
    sql: ${xact_rollback} ;;
  }

  measure: transaction_failure_rate {
    type: number
    label: "Transaction Failure Rate"
    description: "Percentage of total transactions that resulted in a rollback. High rates indicate deadlocks or app errors."
    group_label: "Performance Ratios"
    value_format_name: percent_2
    sql: 1.0 * ${total_rollbacks} / NULLIF((${total_commits} + ${total_rollbacks}), 0) ;;
  }

  measure: cache_hit_ratio {
    type: number
    description: "Ratio of disk blocks found already in the buffer cache to total blocks read. High is better (> 0.99)."
    group_label: "Performance Metrics"
    value_format_name: percent_2
    sql: 1.0 * SUM(${blks_hit}) / NULLIF(SUM(${blks_hit} + ${blks_read}), 0) ;;
  }
}
