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
  # Looker Workload Identification & Liquid Formatting
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
  # Custom Measures & Drills
  # --------------------------------------------------------------------------

  measure: total_calls {
    type: sum
    description: "Total number of times the query was executed across all sessions."
    group_label: "Execution Metrics"
    sql: ${calls} ;;
  }

  measure: total_execution_time_ms {
    type: sum
    description: "Total time spent executing the query, in milliseconds."
    group_label: "Execution Metrics"
    value_format_name: decimal_2
    sql: ${total_exec_time} ;;
  }

  measure: average_execution_time_ms {
    type: number
    description: "Average execution time per call, in milliseconds."
    group_label: "Execution Metrics"
    value_format_name: decimal_2
    sql: 1.0 * ${total_execution_time_ms} / NULLIF(${total_calls}, 0) ;;
    drill_fields: [query_formatted, total_calls, average_execution_time_ms, max_execution_time_ms]
  }

  measure: max_execution_time_ms {
    type: max
    description: "Maximum execution time recorded for the query, in milliseconds."
    group_label: "Execution Metrics"
    value_format_name: decimal_2
    sql: ${max_exec_time} ;;
  }
}
