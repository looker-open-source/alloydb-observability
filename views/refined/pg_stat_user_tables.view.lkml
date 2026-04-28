include: "/views/raw/pg_stat_user_tables.view.lkml"

view: +pg_stat_user_tables {
  
  measure: index_usage_ratio {
    type: number
    label: "Index Usage Ratio"
    description: "Percentage of scans that used an index rather than a full sequential scan."
    group_label: "Health Ratios"
    value_format_name: percent_2
    sql: 1.0 * SUM(${TABLE}.idx_scan) / NULLIF(SUM(${TABLE}.idx_scan + ${TABLE}.seq_scan), 0) ;;
  }

  measure: dead_row_ratio {
    type: number
    label: "Dead Row Ratio (Bloat %)"
    description: "Percentage of the table that consists of dead rows waiting to be vacuumed."
    group_label: "Health Ratios"
    value_format_name: percent_2
    sql: 1.0 * SUM(${TABLE}.n_dead_tup) / NULLIF(SUM(${TABLE}.n_dead_tup + ${TABLE}.n_live_tup), 0) ;;
  }
}