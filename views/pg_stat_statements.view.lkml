view: pg_stat_statements {
  sql_table_name: public.pg_stat_statements ;;

  # --------------------------------------------------------------------------
  # Dimensions
  # --------------------------------------------------------------------------

  dimension: queryid {
    primary_key: yes
    type: number
    description: "Internal hash code computed from the statement's parse tree."
    sql: ${TABLE}.queryid ;;
  }

  dimension: userid {
    type: number
    hidden: yes
    sql: ${TABLE}.userid ;;
  }

  dimension: dbid {
    type: number
    hidden: yes
    sql: ${TABLE}.dbid ;;
  }

  dimension: query {
    type: string
    description: "The SQL statement text."
    sql: ${TABLE}.query ;;
  }

  # --------------------------------------------------------------------------
  # Measures
  # --------------------------------------------------------------------------

  measure: total_calls {
    type: sum
    description: "Total number of times the query was executed."
    sql: ${TABLE}.calls ;;
  }

  measure: total_execution_time_ms {
    type: sum
    description: "Total time spent executing the query, in milliseconds."
    value_format_name: decimal_2
    sql: ${TABLE}.total_exec_time ;;
  }

  measure: average_execution_time_ms {
    type: number
    description: "Average execution time per call, in milliseconds."
    value_format_name: decimal_2
    sql: 1.0 * ${total_execution_time_ms} / NULLIF(${total_calls}, 0) ;;
  }

  measure: max_execution_time_ms {
    type: max
    description: "Maximum execution time for the query, in milliseconds."
    value_format_name: decimal_2
    sql: ${TABLE}.max_exec_time ;;
  }
}
