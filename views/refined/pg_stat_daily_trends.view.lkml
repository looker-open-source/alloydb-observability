view: pg_stat_daily_trends {
  derived_table: {
    datagroup_trigger: daily_snapshot_trigger
    indexes: ["snapshot_date", "queryid"]
    # This is a Cascading PDT. It builds directly from the permanent history tables created by the Tier 1 PDTs.
    sql:
      SELECT
        db.snapshot_date,
        db.datname,
        stmt.queryid as queryid,
        
        CASE WHEN LAG(db.snapshot_date) OVER (PARTITION BY stmt.queryid, db.datid ORDER BY db.snapshot_date) IS NULL THEN 0 
             WHEN stmt.total_exec_time < LAG(stmt.total_exec_time) OVER (PARTITION BY stmt.queryid, db.datid ORDER BY db.snapshot_date) THEN stmt.total_exec_time
             ELSE (stmt.total_exec_time - LAG(stmt.total_exec_time) OVER (PARTITION BY stmt.queryid, db.datid ORDER BY db.snapshot_date))
        END AS daily_exec_time_ms,

        CASE WHEN LAG(db.snapshot_date) OVER (PARTITION BY stmt.queryid, db.datid ORDER BY db.snapshot_date) IS NULL THEN 0 
             WHEN stmt.calls < LAG(stmt.calls) OVER (PARTITION BY stmt.queryid, db.datid ORDER BY db.snapshot_date) THEN stmt.calls
             ELSE (stmt.calls - LAG(stmt.calls) OVER (PARTITION BY stmt.queryid, db.datid ORDER BY db.snapshot_date))
        END AS daily_calls,

        CASE WHEN LAG(db.snapshot_date) OVER (PARTITION BY stmt.queryid, db.datid ORDER BY db.snapshot_date) IS NULL THEN 0 
             WHEN stmt.shared_blks_hit < LAG(stmt.shared_blks_hit) OVER (PARTITION BY stmt.queryid, db.datid ORDER BY db.snapshot_date) THEN stmt.shared_blks_hit
             ELSE (stmt.shared_blks_hit - LAG(stmt.shared_blks_hit) OVER (PARTITION BY stmt.queryid, db.datid ORDER BY db.snapshot_date))
        END AS daily_shared_blks_hit,

        CASE WHEN LAG(db.snapshot_date) OVER (PARTITION BY stmt.queryid, db.datid ORDER BY db.snapshot_date) IS NULL THEN 0 
             WHEN stmt.shared_blks_read < LAG(stmt.shared_blks_read) OVER (PARTITION BY stmt.queryid, db.datid ORDER BY db.snapshot_date) THEN stmt.shared_blks_read
             ELSE (stmt.shared_blks_read - LAG(stmt.shared_blks_read) OVER (PARTITION BY stmt.queryid, db.datid ORDER BY db.snapshot_date))
        END AS daily_shared_blks_read,

        CASE WHEN LAG(db.snapshot_date) OVER (PARTITION BY db.datid ORDER BY db.snapshot_date) IS NULL THEN 0 
             WHEN db.xact_commit < LAG(db.xact_commit) OVER (PARTITION BY db.datid ORDER BY db.snapshot_date) THEN db.xact_commit
             ELSE (db.xact_commit - LAG(db.xact_commit) OVER (PARTITION BY db.datid ORDER BY db.snapshot_date))
        END AS daily_xact_commit,

        CASE WHEN LAG(db.snapshot_date) OVER (PARTITION BY db.datid ORDER BY db.snapshot_date) IS NULL THEN 0 
             WHEN db.xact_rollback < LAG(db.xact_rollback) OVER (PARTITION BY db.datid ORDER BY db.snapshot_date) THEN db.xact_rollback
             ELSE (db.xact_rollback - LAG(db.xact_rollback) OVER (PARTITION BY db.datid ORDER BY db.snapshot_date))
        END AS daily_xact_rollback,

        CASE WHEN LAG(db.snapshot_date) OVER (PARTITION BY db.datid ORDER BY db.snapshot_date) IS NULL THEN 0 
             WHEN db.temp_bytes < LAG(db.temp_bytes) OVER (PARTITION BY db.datid ORDER BY db.snapshot_date) THEN db.temp_bytes
             ELSE (db.temp_bytes - LAG(db.temp_bytes) OVER (PARTITION BY db.datid ORDER BY db.snapshot_date))
        END AS daily_temp_bytes

      FROM ${pg_stat_database_daily_snapshot.SQL_TABLE_NAME} db
      LEFT JOIN ${pg_stat_statements_daily_snapshot.SQL_TABLE_NAME} stmt 
             ON db.snapshot_date = stmt.snapshot_date 
    ;;
  }

  dimension: snapshot_date {
    type: date
    description: "The date of the metric."
    sql: ${TABLE}.snapshot_date ;;
  }

  dimension: datname {
    type: string
    description: "The database name."
    sql: ${TABLE}.datname ;;
  }

  dimension: is_primary_database {
    type: yesno
    description: "Identifies if this database matches the DATABASE_NAME constant."
    sql: ${datname} = '@{DATABASE_NAME}' ;;
  }

  dimension: query_hash {
    type: string
    description: "The unique query identifier."
    sql: CAST(${TABLE}.queryid AS VARCHAR) ;;
  }

  # --- Measures (Pre-Calculated Deltas) ---

  measure: daily_execution_time_seconds {
    type: sum
    label: "Daily Execution Time (Secs)"
    description: "Total CPU time burned on this day. (Pivot-safe)"
    value_format: "#,##0.00 \"s\""
    sql: ${TABLE}.daily_exec_time_ms / 1000.0 ;;
  }

  measure: daily_calls {
    type: sum
    label: "Daily Calls"
    description: "Total number of queries executed on this day. (Pivot-safe)"
    value_format_name: decimal_0
    sql: ${TABLE}.daily_calls ;;
  }

  measure: daily_data_processed_gb {
    type: sum
    label: "Daily Data Processed (GB)"
    description: "Total data read from disk or cache on this day. (Matches BQ Bytes Processed). (Pivot-safe)"
    value_format: "#,##0.00 \" GB\""
    sql: (${TABLE}.daily_shared_blks_hit + ${TABLE}.daily_shared_blks_read) * 8192.0 / (1024.0 * 1024.0 * 1024.0) ;;
  }

  measure: daily_transactions {
    type: sum
    label: "Daily Transactions"
    description: "Total Commits + Rollbacks processed on this day."
    value_format_name: decimal_0
    # Because transactions are at the DB level, we only sum them if we aren't fanning out by query
    sql: ${TABLE}.daily_xact_commit + ${TABLE}.daily_xact_rollback ;;
  }

  measure: daily_cache_hit_ratio {
    type: number
    label: "Daily Cache Hit Ratio"
    description: "Percentage of data read from memory rather than disk on this specific day."
    value_format_name: percent_2
    sql: 
      CASE WHEN SUM(${TABLE}.daily_shared_blks_hit + ${TABLE}.daily_shared_blks_read) = 0 THEN NULL
      ELSE 1.0 * SUM(${TABLE}.daily_shared_blks_hit) / SUM(${TABLE}.daily_shared_blks_hit + ${TABLE}.daily_shared_blks_read) END ;;
  }

  measure: daily_temp_spill_gb {
    type: sum
    label: "Daily Temporary Space Spill (GB)"
    description: "Total gigabytes spilled to disk on this day. (Matches BQ Spills-to-Disk)"
    value_format: "#,##0.00 \" GB\""
    sql: ${TABLE}.daily_temp_bytes / (1024.0 * 1024.0 * 1024.0) ;;
  }
}