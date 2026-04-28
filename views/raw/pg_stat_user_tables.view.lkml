view: pg_stat_user_tables {
  sql_table_name: pg_catalog.pg_stat_user_tables ;;

  dimension: relid {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.relid ;;
  }

  dimension: schemaname {
    type: string
    description: "Name of the schema that this table is in."
    group_label: "Table Details"
    sql: ${TABLE}.schemaname ;;
  }

  dimension: relname {
    type: string
    label: "Table Name"
    description: "Name of this table."
    group_label: "Table Details"
    sql: ${TABLE}.relname ;;
  }

  measure: seq_scan {
    type: sum
    label: "Sequential Scans"
    description: "Number of sequential scans initiated on this table. High numbers suggest missing indexes."
    group_label: "Scan Metrics"
    sql: ${TABLE}.seq_scan ;;
  }

  measure: seq_tup_read {
    type: sum
    label: "Sequential Rows Read"
    description: "Number of live rows fetched by sequential scans."
    group_label: "Scan Metrics"
    sql: ${TABLE}.seq_tup_read ;;
  }

  measure: idx_scan {
    type: sum
    label: "Index Scans"
    description: "Number of index scans initiated on this table."
    group_label: "Scan Metrics"
    sql: ${TABLE}.idx_scan ;;
  }

  measure: idx_tup_fetch {
    type: sum
    label: "Index Rows Fetched"
    description: "Number of live rows fetched by index scans."
    group_label: "Scan Metrics"
    sql: ${TABLE}.idx_tup_fetch ;;
  }

  measure: n_tup_ins {
    type: sum
    label: "Rows Inserted"
    description: "Number of rows inserted."
    group_label: "DML Activity"
    sql: ${TABLE}.n_tup_ins ;;
  }

  measure: n_tup_upd {
    type: sum
    label: "Rows Updated"
    description: "Number of rows updated."
    group_label: "DML Activity"
    sql: ${TABLE}.n_tup_upd ;;
  }

  measure: n_tup_del {
    type: sum
    label: "Rows Deleted"
    description: "Number of rows deleted."
    group_label: "DML Activity"
    sql: ${TABLE}.n_tup_del ;;
  }

  measure: n_live_tup {
    type: sum
    label: "Live Rows"
    description: "Estimated number of live rows."
    group_label: "Table Size"
    sql: ${TABLE}.n_live_tup ;;
  }

  measure: n_dead_tup {
    type: sum
    label: "Dead Rows (Bloat)"
    description: "Estimated number of dead rows waiting for VACUUM."
    group_label: "Table Size"
    sql: ${TABLE}.n_dead_tup ;;
  }
}