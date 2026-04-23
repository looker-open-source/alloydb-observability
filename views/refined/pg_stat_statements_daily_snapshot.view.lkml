view: pg_stat_statements_daily_snapshot {
  derived_table: {
    datagroup_trigger: daily_snapshot_trigger
    create_process: {
      sql_step:
        CREATE TABLE IF NOT EXISTS @{SCRATCH_SCHEMA}.alloydb_stat_statements_history (
          snapshot_date DATE,
          queryid BIGINT,
          calls BIGINT,
          total_exec_time DOUBLE PRECISION,
          blk_read_time DOUBLE PRECISION,
          blk_write_time DOUBLE PRECISION,
          temp_blks_read BIGINT,
          temp_blks_written BIGINT,
          shared_blks_hit BIGINT,
          shared_blks_read BIGINT,
          wal_bytes NUMERIC
        ) ;;
      sql_step:
        DELETE FROM @{SCRATCH_SCHEMA}.alloydb_stat_statements_history WHERE snapshot_date = CURRENT_DATE ;;
      sql_step:
        INSERT INTO @{SCRATCH_SCHEMA}.alloydb_stat_statements_history
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
        WHERE dbid = (SELECT datid FROM pg_catalog.pg_stat_database WHERE datname = '@{DATABASE_NAME}') ;;
      sql_step:
        CREATE TABLE ${SQL_TABLE_NAME} AS
        SELECT * FROM @{SCRATCH_SCHEMA}.alloydb_stat_statements_history ;;
    }
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

  dimension: cumulative_shared_blks_hit {
    type: number
    hidden: yes
    sql: ${TABLE}.shared_blks_hit ;;
  }

  dimension: cumulative_shared_blks_read {
    type: number
    hidden: yes
    sql: ${TABLE}.shared_blks_read ;;
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
      COALESCE(LAG(SUM(${cumulative_total_exec_time} / 1000.0)) OVER (ORDER BY MAX(${snapshot_date})), 0)
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
      COALESCE(LAG(SUM(${cumulative_calls})) OVER (ORDER BY MAX(${snapshot_date})), 0)
    ;;
  }

  measure: overall_daily_data_processed_gb {
    type: number
    label: "Overall Daily Data Processed (GB)"
    description: "The total data read from disk or cache on this day."
    value_format: "#,##0.00 \" GB\""
    sql: 
      SUM((${cumulative_shared_blks_hit} + ${cumulative_shared_blks_read}) * 8192.0 / (1024.0 * 1024.0 * 1024.0))
      - 
      COALESCE(LAG(SUM((${cumulative_shared_blks_hit} + ${cumulative_shared_blks_read}) * 8192.0 / (1024.0 * 1024.0 * 1024.0))) OVER (ORDER BY MAX(${snapshot_date})), 0)
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
      COALESCE(LAG(SUM(${cumulative_total_exec_time} / 1000.0)) OVER (PARTITION BY ${query_hash} ORDER BY MAX(${snapshot_date})), 0)
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
      COALESCE(LAG(SUM(${cumulative_calls})) OVER (PARTITION BY ${query_hash} ORDER BY MAX(${snapshot_date})), 0)
    ;;
  }
}