view: pg_stat_database_daily_snapshot {
  derived_table: {
    datagroup_trigger: daily_snapshot_trigger
    create_process: {
      sql_step:
        CREATE TABLE IF NOT EXISTS @{SCRATCH_SCHEMA}.alloydb_stat_database_history (
          snapshot_date DATE,
          datid BIGINT,
          datname VARCHAR,
          xact_commit BIGINT,
          xact_rollback BIGINT,
          blks_read BIGINT,
          blks_hit BIGINT,
          deadlocks BIGINT,
          tup_returned BIGINT,
          tup_fetched BIGINT,
          tup_inserted BIGINT,
          tup_updated BIGINT,
          tup_deleted BIGINT,
          temp_bytes BIGINT
        ) ;;
      sql_step:
        DELETE FROM @{SCRATCH_SCHEMA}.alloydb_stat_database_history WHERE snapshot_date = CURRENT_DATE ;;
      sql_step:
        INSERT INTO @{SCRATCH_SCHEMA}.alloydb_stat_database_history
        SELECT
          CURRENT_DATE AS snapshot_date,
          datid,
          datname,
          xact_commit,
          xact_rollback,
          blks_read,
          blks_hit,
          deadlocks,
          tup_returned,
          tup_fetched,
          tup_inserted,
          tup_updated,
          tup_deleted,
          temp_bytes
        FROM pg_catalog.pg_stat_database ;;
      sql_step:
        CREATE TABLE ${SQL_TABLE_NAME} AS
        SELECT * FROM @{SCRATCH_SCHEMA}.alloydb_stat_database_history ;;
    }
  }

  dimension: snapshot_date {
    type: date
    primary_key: yes
    description: "The date this daily snapshot was taken."
    sql: ${TABLE}.snapshot_date ;;
  }

  dimension: datid {
    type: number
    hidden: yes
    sql: ${TABLE}.datid ;;
  }

  dimension: datname {
    type: string
    hidden: yes
    sql: ${TABLE}.datname ;;
  }

  # --- Cumulative Facts (Hidden from UI) ---
  dimension: cumulative_xact_commit {
    type: number
    hidden: yes
    sql: ${TABLE}.xact_commit ;;
  }

  dimension: cumulative_xact_rollback {
    type: number
    hidden: yes
    sql: ${TABLE}.xact_rollback ;;
  }

  dimension: cumulative_blks_read {
    type: number
    hidden: yes
    sql: ${TABLE}.blks_read ;;
  }

  dimension: cumulative_blks_hit {
    type: number
    hidden: yes
    sql: ${TABLE}.blks_hit ;;
  }

  dimension: cumulative_deadlocks {
    type: number
    hidden: yes
    sql: ${TABLE}.deadlocks ;;
  }

  dimension: cumulative_temp_bytes {
    type: number
    hidden: yes
    sql: ${TABLE}.temp_bytes ;;
  }

  # --- Delta Calculations (The "Work Done Today") ---

  measure: snapshot_commits {
    type: sum
    hidden: yes
    sql: ${cumulative_xact_commit} ;;
  }

  measure: snapshot_rollbacks {
    type: sum
    hidden: yes
    sql: ${cumulative_xact_rollback} ;;
  }

  measure: daily_transactions {
    type: number
    description: "Total transactions (Commits + Rollbacks) performed on this specific day."
    sql: 
      (SUM(${cumulative_xact_commit} + ${cumulative_xact_rollback})) 
      - 
      COALESCE(LAG(SUM(${cumulative_xact_commit} + ${cumulative_xact_rollback})) OVER (ORDER BY MAX(${snapshot_date})), 0)
    ;;
  }

  measure: daily_deadlocks {
    type: number
    description: "Total deadlocks detected on this specific day."
    sql: 
      SUM(${cumulative_deadlocks}) 
      - 
      COALESCE(LAG(SUM(${cumulative_deadlocks})) OVER (ORDER BY MAX(${snapshot_date})), 0)
    ;;
  }

  measure: daily_cache_hit_ratio {
    type: number
    label: "Daily Cache Hit Ratio"
    description: "Percentage of data read from memory rather than disk on this specific day. (Matches BQ Query Cache Rate)"
    value_format_name: percent_2
    sql: 
      CASE 
        WHEN (SUM(${cumulative_blks_hit} + ${cumulative_blks_read}) - COALESCE(LAG(SUM(${cumulative_blks_hit} + ${cumulative_blks_read})) OVER (ORDER BY MAX(${snapshot_date})), 0)) = 0 THEN NULL
        ELSE 
          1.0 * (SUM(${cumulative_blks_hit}) - COALESCE(LAG(SUM(${cumulative_blks_hit})) OVER (ORDER BY MAX(${snapshot_date})), 0)) 
          / 
          (SUM(${cumulative_blks_hit} + ${cumulative_blks_read}) - COALESCE(LAG(SUM(${cumulative_blks_hit} + ${cumulative_blks_read})) OVER (ORDER BY MAX(${snapshot_date})), 0))
      END
    ;;
  }

  measure: daily_temp_spill_gb {
    type: number
    label: "Daily Temporary Space Spill (GB)"
    description: "Total gigabytes spilled to disk on this specific day because queries exceeded work_mem. (Matches BQ Spills-to-Disk)"
    value_format: "#,##0.00 \" GB\""
    sql: 
      (SUM(${cumulative_temp_bytes}) - COALESCE(LAG(SUM(${cumulative_temp_bytes})) OVER (ORDER BY MAX(${snapshot_date})), 0)) / (1024.0 * 1024.0 * 1024.0)
    ;;
  }
}