view: pg_stat_statements_daily_snapshot {
  derived_table: {
    datagroup_trigger: daily_snapshot_trigger
    increment_key: "snapshot_date"
    increment_offset: 0
    indexes: ["snapshot_date", "queryid"]
    sql:
      SELECT
        CURRENT_DATE AS snapshot_date,
        queryid,
        calls,
        total_exec_time,
        blk_read_time,
        blk_write_time,
        temp_blks_read,
        temp_blks_written,
        shared_blks_hit,
        shared_blks_read,
        wal_bytes
      FROM @{STATEMENTS_SCHEMA}.pg_stat_statements
      WHERE dbid = (SELECT datid FROM pg_catalog.pg_stat_database WHERE datname = '@{DATABASE_NAME}')
    ;;
  }

  dimension: snapshot_date {
    type: date
    description: "The date this daily snapshot was taken."
    sql: ${TABLE}.snapshot_date ;;
  }

  dimension: query_hash {
    type: string
    description: "String representation of the internal query hash code."
    sql: CAST(${TABLE}.queryid AS VARCHAR) ;;
  }

  # Primary Key combining date and query hash
  dimension: snapshot_query_pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${snapshot_date}, '-', ${query_hash}) ;;
  }

  # --- Cumulative Facts (Hidden from UI) ---
  dimension: cumulative_calls {
    type: number
    hidden: yes
    sql: ${TABLE}.calls ;;
  }

  dimension: cumulative_total_exec_time {
    type: number
    hidden: yes
    sql: ${TABLE}.total_exec_time ;;
  }

  dimension: cumulative_temp_blks_written {
    type: number
    hidden: yes
    sql: ${TABLE}.temp_blks_written ;;
  }

  # ==========================================================================
  # 1. OVERALL TRENDS (Use these for high-level daily charts)
  # ==========================================================================

  measure: overall_daily_execution_time_seconds {
    type: number
    label: "Overall Daily Execution Time (Secs)"
    description: "The total execution time consumed by ALL queries on this day. Use this for high-level daily trends."
    value_format: "#,##0.00 \"s\""
    sql: 
      SUM(${cumulative_total_exec_time} / 1000.0) 
      - 
      COALESCE(LAG(SUM(${cumulative_total_exec_time} / 1000.0)) OVER (ORDER BY ${snapshot_date}), 0)
    ;;
  }

  measure: overall_daily_calls {
    type: number
    label: "Overall Daily Calls"
    description: "The total number of query calls across ALL queries on this day."
    value_format_name: decimal_0
    sql: 
      SUM(${cumulative_calls}) 
      - 
      COALESCE(LAG(SUM(${cumulative_calls})) OVER (ORDER BY ${snapshot_date}), 0)
    ;;
  }

  # ==========================================================================
  # 2. QUERY-LEVEL FORENSICS (Use these to see if a specific query got worse)
  # ==========================================================================

  measure: query_daily_execution_time_seconds {
    type: number
    label: "Query-Level Daily Execution Time (Secs)"
    description: "The execution time consumed by a specific query. (Automatically groups by Query Hash)."
    value_format: "#,##0.00 \"s\""
    required_fields: [query_hash]
    sql: 
      SUM(${cumulative_total_exec_time} / 1000.0) 
      - 
      COALESCE(LAG(SUM(${cumulative_total_exec_time} / 1000.0)) OVER (PARTITION BY ${query_hash} ORDER BY ${snapshot_date}), 0)
    ;;
  }

  measure: query_daily_calls {
    type: number
    label: "Query-Level Daily Calls"
    description: "The number of calls for a specific query. (Automatically groups by Query Hash)."
    value_format_name: decimal_0
    required_fields: [query_hash]
    sql: 
      SUM(${cumulative_calls}) 
      - 
      COALESCE(LAG(SUM(${cumulative_calls})) OVER (PARTITION BY ${query_hash} ORDER BY ${snapshot_date}), 0)
    ;;
  }
}
