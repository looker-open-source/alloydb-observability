include: "/views/raw/pg_stat_statements.view.lkml"

view: +pg_stat_statements {

  # --------------------------------------------------------------------------
  # Refined Dimensions
  # --------------------------------------------------------------------------

  dimension: query_pii_masked {
    label: "SQL Statement (PII Sensitive)"
    type: string
    description: "The SQL statement text. Masked if PII_QUERY_TEXT constant is set to HIDE."
    group_label: "Query Details"
    sql:
      CASE
        WHEN '@{PII_QUERY_TEXT}' = 'HIDE' THEN '--- MASKED FOR PII ---'
        ELSE ${TABLE}.query
      END ;;
  }

  dimension: query_formatted {
    type: string
    description: "The SQL statement text with monospace code formatting for easy reading."
    group_label: "Query Details"
    sql: ${query_pii_masked} ;;
    html: <div style="font-family: monospace; white-space: pre-wrap;">{{ value }}</div> ;;
  }

  dimension: is_looker_query {
    type: yesno
    description: "Identifies if the query originated from Looker by checking for Looker's signature SQL comments."
    group_label: "Traffic Analysis"
    sql: ${TABLE}.query LIKE '%-- Looker%' OR ${TABLE}.query LIKE '%-- looker%' ;;
  }

  dimension: query_hash {
    type: string
    description: "String representation of the internal query hash code, useful for exact filtering."
    group_label: "Query Identification"
    sql: CAST(${queryid} AS VARCHAR) ;;
  }

  # --------------------------------------------------------------------------
  # Custom Measures & Formatting
  # --------------------------------------------------------------------------

  measure: total_calls {
    type: sum
    description: "Total number of times the query was executed across all sessions."
    group_label: "Execution Metrics"
    value_format_name: decimal_0
    sql: ${calls} ;;
  }

  measure: total_execution_time_seconds {
    type: sum
    label: "Total Execution Time (Secs)"
    description: "Cumulative time spent executing the query, converted to seconds for easier reading."
    group_label: "Execution Metrics"
    value_format: "#,##0.00 \"s\""
    sql: ${total_exec_time} / 1000.0 ;;
  }

  measure: average_execution_time_ms {
    type: number
    description: "Average execution time per call, in milliseconds."
    group_label: "Execution Metrics"
    value_format: "#,##0.00 \"ms\""
    sql: 1.0 * SUM(${total_exec_time}) / NULLIF(SUM(${calls}), 0) ;;
    # Upgraded drill fields for deeper forensics
    drill_fields: [
      query_hash,
      query_formatted,
      total_calls,
      average_execution_time_ms,
      max_execution_time_ms,
      total_disk_read_time_seconds,
      total_temp_blocks_written
    ]
  }

  measure: max_execution_time_ms {
    type: max
    description: "Maximum execution time recorded for the query, in milliseconds."
    group_label: "Execution Metrics"
    value_format: "#,##0.00 \"ms\""
    sql: ${max_exec_time} ;;
  }

  measure: average_rows_returned {
    type: number
    description: "Average number of rows sent back to the application per execution. High numbers with high latency suggest unoptimized scans."
    group_label: "Execution Metrics"
    value_format_name: decimal_0
    sql: 1.0 * SUM(${TABLE}.rows) / NULLIF(SUM(${calls}), 0) ;;
  }

  measure: total_disk_read_time_seconds {
    type: sum
    label: "Total Disk Read Wait Time (Secs)"
    description: "Total time spent waiting for physical disk reads. High values indicate missing indexes or poor cache hit ratio. Official PostgreSQL Documentation: pg_stat_statements.blk_read_time."
    group_label: "Memory & I/O"
    value_format: "#,##0.00 \"s\""
    sql: ${blk_read_time} / 1000.0 ;;
  }

  measure: total_disk_write_time_seconds {
    type: sum
    label: "Total Disk Write Wait Time (Secs)"
    description: "Total time spent waiting for physical disk writes. High values suggest I/O subsystem saturation or high checkpoint volume. Official PostgreSQL Documentation: pg_stat_statements.blk_write_time."
    group_label: "Memory & I/O"
    value_format: "#,##0.00 \"s\""
    sql: ${blk_write_time} / 1000.0 ;;
  }

  measure: total_temp_blocks_read {
    type: sum
    description: "Number of temporary disk blocks read. High values indicate the query is spilling to disk because it exceeds RAM (work_mem)."
    group_label: "Memory & I/O"
    value_format_name: decimal_0
    sql: ${temp_blks_read} ;;
  }

  measure: total_temp_blocks_written {
    type: sum
    description: "Number of temporary disk blocks written. This is a critical indicator of memory pressure (work_mem exhaustion)."
    group_label: "Memory & I/O"
    value_format_name: decimal_0
    sql: ${temp_blks_written} ;;
  }

  measure: workload_share {
    type: percent_of_total
    direction: "column"
    description: "The percentage of total database execution time consumed by this specific grouping."
    group_label: "Traffic Analysis"
    sql: ${total_execution_time_seconds} ;;
  }

  # KPI 2: WAL Generation Rate
  measure: total_wal_generation_mb {
    type: sum
    label: "Total WAL Generated (MB)"
    description: "The total amount of Write-Ahead Log (WAL) generated by the statements, converted to Megabytes. This tracks the 'Write Volume' of the database. Official PostgreSQL Documentation: pg_stat_statements.wal_bytes."
    group_label: "Memory & I/O"
    value_format_name: decimal_2
    sql: ${wal_bytes} / (1024.0 * 1024.0) ;;
  }

  # KPI 6: I/O Overhead Ratio
  measure: io_overhead_ratio {
    type: number
    label: "I/O Overhead Ratio"
    description: "Percentage of total execution time spent waiting on Disk I/O (Read + Write). Values > 0.5 suggest the database is Disk-Bound rather than CPU-Bound."
    group_label: "Performance Ratios"
    value_format_name: percent_2
    sql: 1.0 * (SUM(${blk_read_time} + ${blk_write_time})) / NULLIF(SUM(${total_exec_time}), 0) ;;
  }

  # KPI 9: Cache Efficiency Ratio (General, to be filtered for Looker)
  measure: statement_cache_hit_ratio {
    type: number
    label: "Statement Cache Hit Ratio"
    description: "Ratio of shared blocks found in the buffer cache vs total shared blocks read. High values (> 0.95) indicate effective caching for these queries. Official PostgreSQL Documentation: pg_stat_statements.shared_blks_hit."
    group_label: "Memory & I/O"
    value_format_name: percent_2
    sql: 1.0 * SUM(${TABLE}.shared_blks_hit) / NULLIF(SUM(${TABLE}.shared_blks_hit + ${TABLE}.shared_blks_read), 0) ;;
  }

  # KPI 10 Improvement: Steady State Concurrency Estimate
  measure: average_concurrency_estimate {
    type: number
    label: "Average Concurrency (Steady State)"
    description: "Estimated average number of concurrent queries based on cumulative execution time divided by time since statistics reset. Does not return NULL even if no queries are active now."
    group_label: "Execution Metrics"
    value_format_name: decimal_2
    sql: ${total_execution_time_seconds} / NULLIF(EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - ${pg_stat_database.stats_reset_time})), 0) ;;
  }
}
