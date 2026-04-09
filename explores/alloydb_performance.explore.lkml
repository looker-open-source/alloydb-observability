include: "/views/refined/*.view.lkml"

explore: alloydb_performance {
  label: "AlloyDB Performance Monitoring"
  description: "The central hub for all AlloyDB metrics: Query execution, live connections, and database health."

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
