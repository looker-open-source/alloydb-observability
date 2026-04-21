view: pg_stat_database_daily_snapshot {
  derived_table: {
    datagroup_trigger: daily_snapshot_trigger
    increment_key: "snapshot_date"
    increment_offset: 0
    indexes: ["snapshot_date", "datid"]
    sql:
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
      FROM pg_catalog.pg_stat_database
      WHERE datname = '@{DATABASE_NAME}'
    ;;
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
      COALESCE(LAG(SUM(${cumulative_xact_commit} + ${cumulative_xact_rollback})) OVER (ORDER BY ${snapshot_date}), 0)
    ;;
  }

  measure: daily_deadlocks {
    type: number
    description: "Total deadlocks detected on this specific day."
    sql: 
      SUM(${cumulative_deadlocks}) 
      - 
      COALESCE(LAG(SUM(${cumulative_deadlocks})) OVER (ORDER BY ${snapshot_date}), 0)
    ;;
  }
}
