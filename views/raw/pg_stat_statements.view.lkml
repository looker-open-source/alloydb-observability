view: pg_stat_statements {
  sql_table_name: public.pg_stat_statements ;;

  # --------------------------------------------------------------------------
  # Dimensions (1:1 Mapping with Database)
  # --------------------------------------------------------------------------

  dimension: queryid {
    primary_key: yes
    type: number
    sql: ${TABLE}.queryid ;;
  }

  dimension: userid {
    type: number
    sql: ${TABLE}.userid ;;
  }

  dimension: dbid {
    type: number
    sql: ${TABLE}.dbid ;;
  }

  dimension: query {
    type: string
    sql: ${TABLE}.query ;;
  }

  dimension: calls {
    type: number
    sql: ${TABLE}.calls ;;
  }

  dimension: total_exec_time {
    type: number
    sql: ${TABLE}.total_exec_time ;;
  }

  dimension: max_exec_time {
    type: number
    sql: ${TABLE}.max_exec_time ;;
  }
}
