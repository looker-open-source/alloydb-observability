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

  dimension: stats_reset_time {
    type: date_time
    label: "Last Statistics Reset"
    description: "The time at which database-wide statistics were last reset."
    group_label: "Database Info"
    sql: ${TABLE}.stats_reset ;;
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

  # KPI 1: Transaction Throughput (TPS)
  measure: total_transactions {
    type: sum
    hidden: yes
    description: "Cumulative count of all committed and rolled back transactions."
    sql: ${xact_commit} + ${xact_rollback} ;;
  }

  measure: tps {
    type: number
    label: "Transaction Throughput (TPS)"
    description: "Average number of transactions per second since the last statistics reset. Calculated as (Commits + Rollbacks) / Time."
    group_label: "Performance Metrics"
    value_format_name: decimal_2
    sql:
      1.0 * ${total_transactions} /
      NULLIF(EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - MIN(${TABLE}.stats_reset))), 0) ;;
  }

  # KPI 3: Database DML Intensity
  measure: total_dml_writes {
    type: sum
    label: "Total DML Writes (I/U/D)"
    description: "The sum of all rows inserted, updated, and deleted. Represents the write-intensity of the workload."
    group_label: "DML Activity"
    value_format_name: decimal_0
    sql: ${TABLE}.tup_inserted + ${TABLE}.tup_updated + ${TABLE}.tup_deleted ;;
  }

  measure: total_dml_reads {
    type: sum
    label: "Total DML Reads (Fetched)"
    description: "Total number of rows fetched by queries. Represents the read-intensity of the workload."
    group_label: "DML Activity"
    value_format_name: decimal_0
    sql: ${TABLE}.tup_fetched ;;
  }

  measure: dml_read_write_ratio {
    type: number
    label: "Read/Write DML Ratio"
    description: "Ratio of rows fetched (Reads) vs rows modified (Inserts/Updates/Deletes). High values indicate a read-mostly workload."
    group_label: "Performance Ratios"
    value_format_name: decimal_2
    sql: 1.0 * ${total_dml_reads} / NULLIF(${total_dml_writes}, 0) ;;
  }

  # KPI 5: Deadlock Frequency
  measure: total_deadlocks {
    type: sum
    label: "Total Deadlocks"
    description: "Total number of deadlocks detected in this database. Deadlocks occur when two or more transactions hold locks that the others need, requiring the database to terminate one. Official PostgreSQL Documentation: pg_stat_database.deadlocks."
    group_label: "Performance Metrics"
    value_format_name: decimal_0
    sql: ${TABLE}.deadlocks ;;
  }

  # KPI 7: Temporary Space Spill
  measure: total_temp_bytes_gb {
    type: sum
    label: "Total Temp Space Spill (GB)"
    description: "Total amount of data written to temporary files by queries, converted to Gigabytes. This occurs when an internal sort or join operation needs more memory than work_mem allowed. Official PostgreSQL Documentation: pg_stat_database.temp_bytes."
    group_label: "Memory & I/O"
    value_format_name: decimal_2
    sql: ${TABLE}.temp_bytes / (1024.0 * 1024.0 * 1024.0) ;;
  }
}
