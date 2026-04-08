include: "/views/raw/pg_stat_statements.view.lkml"

view: +pg_stat_statements {
  
  # --------------------------------------------------------------------------
  # Refined Dimensions
  # --------------------------------------------------------------------------

  dimension: queryid {
    primary_key: yes
    type: number
    description: "Internal hash code computed from the statement's parse tree."
    group_label: "Query Identification"
    sql: ${TABLE}.queryid ;;
  }

  dimension: userid {
    type: number
    hidden: yes
    description: "OID of user who executed the statement."
    group_label: "Query Identification"
    sql: ${TABLE}.userid ;;
  }

  dimension: dbid {
    type: number
    hidden: yes
    description: "OID of database in which the statement was executed."
    group_label: "Query Identification"
    sql: ${TABLE}.dbid ;;
  }

  dimension: query {
    type: string
    description: "The raw SQL statement text."
    group_label: "Query Details"
    sql: ${TABLE}.query ;;
  }

  # --------------------------------------------------------------------------
  # Looker Workload Identification
  # --------------------------------------------------------------------------

  dimension: is_looker_query {
    type: yesno
    description: "Identifies if the query originated from Looker by checking for Looker's signature SQL comments."
    group_label: "Traffic Analysis"
    sql: ${query} LIKE '%-- Looker%' OR ${query} LIKE '%-- looker%' ;;
  }

  dimension: query_formatted {
    type: string
    description: "The SQL statement text with monospace code formatting for easy reading."
    group_label: "Query Details"
    sql: ${query} ;;
    html: <div style="font-family: monospace; white-space: pre-wrap;">{{ value }}</div> ;;
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
    description: "Cumulative time spent executing the query, converted to seconds for easier reading."
    group_label: "Execution Metrics"
    value_format: "#,##0.00 \"s\""
    sql: ${total_exec_time} / 1000.0 ;;
  }

  measure: workload_share {
    type: percent_of_total
    direction: "column"
    description: "The percentage of total database execution time consumed by this specific grouping."
    group_label: "Traffic Analysis"
    sql: ${total_execution_time_seconds} ;;
  }

  measure: average_execution_time_ms {
    type: number
    description: "Average execution time per call, in milliseconds."
    group_label: "Execution Metrics"
    value_format: "#,##0.00 \"ms\""
    sql: 1.0 * SUM(${total_exec_time}) / NULLIF(SUM(${calls}), 0) ;;
    drill_fields: [query_formatted, total_calls, average_execution_time_ms, max_execution_time_ms]
  }

  measure: max_execution_time_ms {
    type: max
    description: "Maximum execution time recorded for the query, in milliseconds."
    group_label: "Execution Metrics"
    value_format: "#,##0.00 \"ms\""
    sql: ${max_exec_time} ;;
  }
}
