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

    link: {
      label: "📈 Transaction Trend (Area)"
      url: "@{DRILL_AREA_VIZ}{{ link }}&fields=pg_stat_activity.query_start_minute,pg_stat_database.total_transactions&f[pg_stat_database.datname]={{ value | url_encode }}&sorts=pg_stat_activity.query_start_minute+asc&limit=500&toggle=vis"
    }

    link: {
      label: "🍩 Write Activity Share (Pie)"
      url: "@{DRILL_PIE_VIZ}{{ link }}&fields=pg_stat_statements.query_hash,pg_stat_database.total_dml_writes&f[pg_stat_database.datname]={{ value | url_encode }}&sorts=pg_stat_database.total_dml_writes+desc&limit=10&toggle=vis"
    }
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
    description: "Percentage of total transactions that resulted in a rollback."
    group_label: "Performance Ratios"
    value_format_name: percent_2
    sql: 1.0 * ${total_rollbacks} / NULLIF((${total_commits} + ${total_rollbacks}), 0) ;;

    link: {
      label: "🔍 Errors by Traffic Source (Bar)"
      url: "@{DRILL_COLUMN_VIZ}{{ link }}&fields=pg_stat_activity.traffic_source,pg_stat_database.total_rollbacks&sorts=pg_stat_database.total_rollbacks+desc&toggle=vis"
    }
  }

  measure: cache_hit_ratio {
    type: number
    description: "Ratio of disk blocks found already in the buffer cache to total blocks read."
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
    description: "Average number of transactions per second since the last statistics reset."
    group_label: "Performance Metrics"
    value_format_name: decimal_2
    sql:
      1.0 * ${total_transactions} /
      NULLIF(EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - MIN(${TABLE}.stats_reset))), 0) ;;
    drill_fields: [pg_stat_activity.query_start_date, pg_stat_activity.traffic_source, tps]

    link: {
      label: "📈 TPS Trend by Source (Line)"
      url: "@{DRILL_LINE_VIZ}{{ link }}&fields=pg_stat_activity.query_start_date,pg_stat_activity.traffic_source,pg_stat_database.tps&pivots=pg_stat_activity.traffic_source&sorts=pg_stat_activity.query_start_date+asc&limit=500&toggle=vis"
    }

    link: {
      label: "🍩 DML Breakdown by Database (Pie)"
      url: "@{DRILL_PIE_VIZ}{{ link }}&fields=pg_stat_database.datname,pg_stat_database.total_dml_writes,pg_stat_database.total_dml_reads&toggle=vis"
    }
  }

  # KPI 3: Database DML Intensity
  measure: total_dml_writes {
    type: sum
    label: "Total DML Writes (I/U/D)"
    description: "The sum of all rows inserted, updated, and deleted."
    group_label: "DML Activity"
    value_format_name: decimal_0
    sql: ${TABLE}.tup_inserted + ${TABLE}.tup_updated + ${TABLE}.tup_deleted ;;
  }

  measure: total_dml_reads {
    type: sum
    label: "Total DML Reads (Fetched)"
    description: "Total number of rows fetched by queries."
    group_label: "DML Activity"
    value_format_name: decimal_0
    sql: ${TABLE}.tup_fetched ;;
  }

  measure: dml_read_write_ratio {
    type: number
    label: "Read/Write DML Ratio"
    description: "Ratio of rows fetched (Reads) vs rows modified (Inserts/Updates/Deletes)."
    group_label: "Performance Ratios"
    value_format_name: decimal_2
    sql: 1.0 * ${total_dml_reads} / NULLIF(${total_dml_writes}, 0) ;;
  }

  # KPI 5: Deadlock Frequency
  measure: total_deadlocks {
    type: sum
    label: "Total Deadlocks"
    description: "Total number of deadlocks detected in this database."
    group_label: "Performance Metrics"
    value_format_name: decimal_0
    sql: ${TABLE}.deadlocks ;;
  }

  # KPI 7: Temporary Space Spill
  measure: total_temp_bytes_gb {
    type: sum
    label: "Total Temp Space Spill (GB)"
    description: "Total amount of data written to temporary files by queries, converted to Gigabytes."
    group_label: "Memory & I/O"
    value_format_name: decimal_2
    sql: ${TABLE}.temp_bytes / (1024.0 * 1024.0 * 1024.0) ;;
    drill_fields: [pg_stat_statements.query_formatted, total_temp_bytes_gb]

    link: {
      label: "📊 Top Spilling Queries (Bar)"
      url: "@{DRILL_COLUMN_VIZ}{{ link }}&fields=pg_stat_statements.query_formatted,pg_stat_database.total_temp_bytes_gb&sorts=pg_stat_database.total_temp_bytes_gb+desc&limit=10&toggle=vis"
    }

    link: {
      label: "🍩 DML Load Distribution (Pie)"
      url: "@{DRILL_PIE_VIZ}{{ link }}&fields=pg_stat_activity.traffic_source,pg_stat_database.total_temp_bytes_gb&toggle=vis"
    }
  }
}
