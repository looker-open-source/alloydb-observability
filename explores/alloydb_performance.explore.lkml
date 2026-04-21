include: "/views/refined/*.view.lkml"

# --------------------------------------------------------------------------
# Original Combined Explore (Kept for backwards compatibility)
# --------------------------------------------------------------------------
explore: alloydb_performance {
  label: "AlloyDB Performance Monitoring (Combined)"
  description: "The central hub for all AlloyDB metrics: Query execution, live connections, and database health. Warning: Joining historical statements with real-time activity can cause filtering artifacts if date filters are applied."

  view_name: pg_stat_statements

  join: pg_stat_activity {
    type: left_outer
    relationship: one_to_many
    sql_on: ${pg_stat_statements.userid} = ${pg_stat_activity.usesysid}
        AND ${pg_stat_statements.dbid} = ${pg_stat_activity.datid}
        AND ${pg_stat_statements.query} = ${pg_stat_activity.query} ;;
  }

  join: pg_stat_database {
    type: left_outer
    relationship: many_to_one
    sql_on: ${pg_stat_statements.dbid} = ${pg_stat_database.datid} ;;
  }
}

# --------------------------------------------------------------------------
# Option B: Dedicated Real-Time Explore
# --------------------------------------------------------------------------
explore: alloydb_real_time_activity {
  label: "AlloyDB Real-Time Activity (Live Forensics)"
  description: "Focuses exclusively on real-time, live forensics of the database. Use this Explore to monitor currently active connections, identify blocked sessions, and see exactly what is executing right now."

  view_name: pg_stat_activity

  join: pg_stat_database {
    type: left_outer
    relationship: many_to_one
    sql_on: ${pg_stat_activity.datid} = ${pg_stat_database.datid} ;;
  }

  # Encourage users to only look at the primary monitored database by default
  # This prevents the explore from pulling in noise from internal system databases
  always_filter: {
    filters: [pg_stat_database.is_primary_database: "Yes"]
  }
}

# --------------------------------------------------------------------------
# Option B: Dedicated Historical Explore
# --------------------------------------------------------------------------
explore: alloydb_historical_statements {
  label: "AlloyDB Historical Statements (All-Time)"
  description: "Focuses exclusively on historical analysis of query performance. Use this Explore to find the heaviest queries, highest I/O overhead, and cache efficiency since the last statistics reset. Does NOT contain time-series data."

  view_name: pg_stat_statements

  join: pg_stat_database {
    type: left_outer
    relationship: many_to_one
    sql_on: ${pg_stat_statements.dbid} = ${pg_stat_database.datid} ;;
  }

  # Encourage users to only look at the primary monitored database by default
  always_filter: {
    filters: [pg_stat_database.is_primary_database: "Yes"]
  }
}

# --------------------------------------------------------------------------
# Time-Series Trend Explore (Requires PDTs)
# --------------------------------------------------------------------------
explore: alloydb_historical_trends {
  label: "AlloyDB Historical Trends (Time-Series)"
  description: "Tracks database health and query performance over time using daily snapshots. Requires Persistent Derived Tables (PDTs) to be enabled on the database connection."

  view_name: pg_stat_database_daily_snapshot


  join: pg_stat_statements_daily_snapshot {
    type: left_outer
    relationship: one_to_many
    sql_on: ${pg_stat_database_daily_snapshot.snapshot_date} = ${pg_stat_statements_daily_snapshot.snapshot_date} ;;
  }

  join: pg_stat_statements {
    type: left_outer
    relationship: many_to_one
    sql_on: ${pg_stat_statements_daily_snapshot.query_hash} = CAST(${pg_stat_statements.queryid} AS VARCHAR) ;;

    fields: [pg_stat_statements.query_formatted, pg_stat_statements.query_pii_masked, pg_stat_statements.is_looker_query]
  }
}
