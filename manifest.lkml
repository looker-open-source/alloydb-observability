project_name: "operational-intelligence-alloy-db"

# --------------------------------------------------------------------------
# Constants
# --------------------------------------------------------------------------

# The name of the Looker connection to the AlloyDB instance
constant: CONNECTION_NAME {
  value: "alloydb"
  export: override_optional
}

# The database name to monitor by default (e.g., 'postgres' or your app db)
constant: DATABASE_NAME {
  value: "database"
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
