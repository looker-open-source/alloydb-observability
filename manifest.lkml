project_name: "operational-intelligence-alloy-db"

# --------------------------------------------------------------------------
# Constants
# --------------------------------------------------------------------------

# The name of the Looker connection to the AlloyDB instance
constant: CONNECTION_NAME {
  value: "cymbal-gadgets-alloydb"
  export: override_optional
}

# The database name to monitor by default (e.g., 'postgres' or your app db)
constant: DATABASE_NAME {
  value: "global_gadgets_demo"
  export: override_optional
}

# The schema where the pg_stat_statements extension is installed (usually 'public')
constant: STATEMENTS_SCHEMA {
  value: "public"
  export: override_optional
}

# Security setting to mask query text. Valid values: 'SHOW' or 'HIDE'
constant: PII_QUERY_TEXT {
  value: "SHOW"
  export: override_optional
}

# The maximum connections allowed by the AlloyDB instance (for saturation KPI)
constant: MAX_CONNECTIONS {
  value: "1000"
  export: override_optional
}
