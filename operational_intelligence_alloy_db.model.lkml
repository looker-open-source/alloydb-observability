# Define the database connection using the manifest constant
connection: "@{CONNECTION_NAME}"

# Include the Refined Views (which automatically include the raw views via refinement)
include: "/views/refined/*.view.lkml"

# Include explores and dashboards
include: "/explores/*.explore.lkml"
include: "/dashboards/*.dashboard.lookml"
include: "/dashboards/*.dashboard"

# --------------------------------------------------------------------------
# Datagroups for Incremental PDTs
# --------------------------------------------------------------------------
datagroup: daily_snapshot_trigger {
  # Triggers once a day at midnight.
  sql_trigger: SELECT EXTRACT(DAY FROM CURRENT_TIMESTAMP) ;;
  max_cache_age: "24 hours"
}

explore: navigation_bar {
  hidden: yes
  persist_for: "0 seconds"
}
