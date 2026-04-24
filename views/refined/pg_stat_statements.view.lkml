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

    # link: {
    #   label: "🎯 Query Performance Signature (Single Value)"
    #   url: "@{DRILL_SINGLE_VALUE_VIZ}{{ link }}&fields=pg_stat_statements.average_execution_time_ms&f[pg_stat_statements.query_formatted]={{ value | url_encode }}&toggle=vis"
    # }

    # link: {
    #   label: "📈 Historical Latency Trend (Line)"
    #   url: "@{DRILL_LINE_VIZ}{{ link }}&fields=pg_stat_activity.query_start_date,pg_stat_statements.average_execution_time_ms&f[pg_stat_statements.query_formatted]={{ value | url_encode }}&sorts=pg_stat_activity.query_start_date+asc&toggle=vis"
    # }
  }

  dimension: is_looker_query {
    type: yesno
    description: "Identifies if the query originated from Looker."
    group_label: "Traffic Analysis"
    sql: ${TABLE}.query LIKE '%-- Looker%' OR ${TABLE}.query LIKE '%-- looker%' ;;
  }

  dimension: query_hash {
    type: string
    description: "String representation of the internal query hash code."
    group_label: "Query Identification"
    sql: CAST(${queryid} AS VARCHAR) ;;

    # link: {
    #   label: "🍩 Who runs this query? (Top Users Pie)"
    #   url: "@{DRILL_PIE_VIZ}{{ link }}&fields=pg_stat_activity.usename,pg_stat_statements.total_calls&f[pg_stat_statements.query_hash]={{ value | url_encode }}&sorts=pg_stat_statements.total_calls+desc&limit=10&toggle=vis"
    # }

    # link: {
    #   label: "📈 Database Load - specific query (Line)"
    #   url: "@{DRILL_LINE_VIZ}{{ link }}&fields=pg_stat_activity.query_start_minute,pg_stat_statements.total_execution_time_seconds&f[pg_stat_statements.query_hash]={{ value | url_encode }}&sorts=pg_stat_activity.query_start_minute+asc&limit=500&toggle=vis"
    # }

    link: {
      label: "⏱️ Query Latency Trend (Line)"
      url: "@{DRILL_LINE_VIZ}{{ link }}&fields=pg_stat_activity.query_start_minute,pg_stat_statements.average_execution_time_ms&f[pg_stat_statements.query_hash]={{ value | url_encode }}&sorts=pg_stat_activity.query_start_minute+asc&limit=500&toggle=vis"
    }
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
    description: "Cumulative time spent executing the query."
    group_label: "Execution Metrics"
    value_format: "#,##0.00 \"s\""
    sql: ${total_exec_time} / 1000.0 ;;
    # drill_fields: [query_formatted, total_execution_time_seconds]

    # link: {
    #   label: "📊 View Top Heavy Queries (Bar)"
    #   url: "@{DRILL_COLUMN_VIZ}{{ link }}&fields=pg_stat_statements.query_formatted,pg_stat_statements.total_execution_time_seconds&sorts=pg_stat_statements.total_execution_time_seconds+desc&limit=10&toggle=vis"
    # }

    # link: {
    #   label: "📈 Execution Time Trend (Area)"
    #   url: "@{DRILL_AREA_VIZ}{{ link }}&fields=pg_stat_activity.query_start_date,pg_stat_statements.total_execution_time_seconds&pivots=pg_stat_activity.instance_role&sorts=pg_stat_activity.query_start_date+asc&limit=500&toggle=vis"
    # }
  }

  measure: average_execution_time_ms {
    type: number
    description: "Average execution time per call, in milliseconds."
    group_label: "Execution Metrics"
    value_format: "#,##0.00 \"ms\""
    sql: 1.0 * SUM(${total_exec_time}) / NULLIF(SUM(${calls}), 0) ;;
    # drill_fields: [query_hash, query_formatted, total_calls, average_execution_time_ms, max_execution_time_ms, total_disk_read_time_seconds, total_temp_blocks_written]

    # link: {
    #   label: "📊 Top 10 Slowest Queries (Bar)"
    #   url: "@{DRILL_COLUMN_VIZ}{{ link }}&fields=pg_stat_statements.query_formatted,pg_stat_statements.average_execution_time_ms&sorts=pg_stat_statements.average_execution_time_ms+desc&limit=10&toggle=vis"
    # }

    # link: {
    #   label: "🎯 Latency vs Volume Correlation (Scatter)"
    #   url: "@{DRILL_SCATTER_VIZ}{{ link }}&fields=pg_stat_statements.query_hash,pg_stat_statements.total_calls,pg_stat_statements.average_execution_time_ms&sorts=pg_stat_statements.total_calls+desc&limit=50&toggle=vis"
    # }
  }

  measure: max_execution_time_ms {
    type: max
    description: "Maximum execution time recorded for the query."
    group_label: "Execution Metrics"
    value_format: "#,##0.00 \"ms\""
    sql: ${max_exec_time} ;;
  }

  measure: average_rows_returned {
    type: number
    description: "Average number of rows sent back to the application per execution."
    group_label: "Execution Metrics"
    value_format_name: decimal_0
    sql: 1.0 * SUM(${TABLE}.rows) / NULLIF(SUM(${calls}), 0) ;;
  }

  measure: total_disk_read_time_seconds {
    type: sum
    label: "Total Disk Read Wait Time (Secs)"
    description: "Total time spent waiting for physical disk reads."
    group_label: "Memory & I/O"
    value_format: "#,##0.00 \"s\""
    sql: ${blk_read_time} / 1000.0 ;;
  }

  measure: total_disk_write_time_seconds {
    type: sum
    label: "Total Disk Write Wait Time (Secs)"
    description: "Total time spent waiting for physical disk writes."
    group_label: "Memory & I/O"
    value_format: "#,##0.00 \"s\""
    sql: ${blk_write_time} / 1000.0 ;;
  }

  measure: total_temp_blocks_read {
    type: sum
    description: "Number of temporary disk blocks read."
    group_label: "Memory & I/O"
    value_format_name: decimal_0
    sql: ${temp_blks_read} ;;
  }

  measure: total_temp_blocks_written {
    type: sum
    description: "Number of temporary disk blocks written."
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

  measure: total_data_processed_gb {
    type: sum
    label: "Total Data Processed (GB)"
    description: "The total amount of data read from disk or cache by these queries. Equivalent to BQ Bytes Processed."
    group_label: "Execution Metrics"
    value_format: "#,##0.00 \" GB\""
    # Postgres blocks are 8KB (8192 bytes). We convert to GB.
    sql: (${TABLE}.shared_blks_hit + ${TABLE}.shared_blks_read) * 8192.0 / (1024.0 * 1024.0 * 1024.0) ;;
  }

  measure: average_data_processed_mb_per_call {
    type: number
    label: "Avg Data Processed per Call (MB)"
    description: "The average amount of data scanned each time this query runs. High numbers indicate poor index usage."
    group_label: "Execution Metrics"
    value_format: "#,##0.00 \" MB\""
    # Convert blocks to MB and divide by total calls
    sql: SUM((${TABLE}.shared_blks_hit + ${TABLE}.shared_blks_read) * 8192.0 / (1024.0 * 1024.0)) / NULLIF(SUM(${calls}), 0) ;;
  }

  measure: total_wal_generation_mb {
    type: sum
    label: "Total WAL Generated (MB)"
    description: "The total amount of Write-Ahead Log (WAL) generated by the statements."
    group_label: "Memory & I/O"
    value_format_name: decimal_2
    sql: ${wal_bytes} / (1024.0 * 1024.0) ;;
  }

  measure: io_overhead_ratio {
    type: number
    label: "I/O Overhead Ratio"
    description: "Percentage of total execution time spent waiting on Disk I/O (Read + Write)."
    group_label: "Performance Ratios"
    value_format_name: percent_2
    sql: 1.0 * (SUM(${blk_read_time} + ${blk_write_time})) / NULLIF(SUM(${total_exec_time}), 0) ;;
    # drill_fields: [query_formatted, io_overhead_ratio]

    # link: {
    #   label: "🔍 Queries with High I/O Overhead (Bar)"
    #   url: "@{DRILL_COLUMN_VIZ}{{ link }}&fields=pg_stat_statements.query_formatted,pg_stat_statements.io_overhead_ratio&sorts=pg_stat_statements.io_overhead_ratio+desc&limit=10&toggle=vis"
    # }

    # link: {
    #   label: "🍩 Total Disk Wait Time by Query (Pie)"
    #   url: "@{DRILL_PIE_VIZ}{{ link }}&fields=pg_stat_statements.query_formatted,pg_stat_statements.total_disk_read_time_seconds&sorts=pg_stat_statements.total_disk_read_time_seconds+desc&limit=10&toggle=vis"
    # }
  }

  measure: statement_cache_hit_ratio {
    type: number
    label: "Statement Cache Hit Ratio"
    description: "Ratio of shared blocks found in the buffer cache vs total shared blocks read."
    group_label: "Memory & I/O"
    value_format_name: percent_2
    sql: 1.0 * SUM(${TABLE}.shared_blks_hit) / NULLIF(SUM(${TABLE}.shared_blks_hit + ${TABLE}.shared_blks_read), 0) ;;
  }

  measure: average_concurrency_estimate {
    type: number
    label: "Average Concurrency (Steady State)"
    description: "Estimated average number of concurrent queries based on cumulative execution time."
    group_label: "Execution Metrics"
    value_format_name: decimal_2
    sql: ${total_execution_time_seconds} / NULLIF(EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - (SELECT MIN(stats_reset) FROM pg_catalog.pg_stat_database WHERE datname = '@{DATABASE_NAME}'))), 0) ;;
  }
}
