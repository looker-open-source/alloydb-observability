# Operational Intelligence - AlloyDB Performance Block

The AlloyDB Performance Block provides a comprehensive observability suite for monitoring the health, performance, and real-time activity of Google Cloud AlloyDB for PostgreSQL instances. By connecting Looker directly to internal system tables, this block surfaces metrics typically hidden from standard BI tools, enabling proactive database optimization and resource management.

---

## Architecture and Design Patterns

This project adheres to Google's recommended design patterns for modular and scalable LookML development.

### Two-Layer Refinement
- **Raw Layer (`/views/raw/`)**: Contains base views that are 1:1 mappings of the AlloyDB system tables. These files remain untouched by business logic to ensure ease of maintenance and schema alignment.
- **Refined Layer (`/views/refined/`)**: Implements Looker [refinements](https://cloud.google.com/looker/docs/reference/param-explore-view-name) (`+view_name`) to layer on business logic, descriptive metadata, and advanced measures without modifying the underlying schema mapping.

### Global Configuration (Marketplace Ready)
The project utilizes a `manifest.lkml` file with several [constants](https://cloud.google.com/looker/docs/reference/param-manifest-constant) for plug-and-play deployment:
- **`CONNECTION_NAME`**: The name of the Looker connection.
- **`DATABASE_NAME`**: The primary application database to monitor.
- **`STATEMENTS_SCHEMA`**: The schema where the `pg_stat_statements` extension is installed.
- **`SCRATCH_SCHEMA`**: The scratch schema name for self-managed history PDTs.
- **`PII_QUERY_TEXT`**: A security toggle (`SHOW`/`HIDE`) to mask sensitive SQL text.
- **`MAX_CONNECTIONS`**: Used for Connection Saturation KPI calculations.

### Advanced Drilling & Visualization Library
The `manifest.lkml` also includes a set of highly optimized, triple-escaped JSON constants (e.g., `DRILL_LINE_VIZ`, `DRILL_PIE_VIZ`). These constants define exact Looker visualization configurations. When injected into the `url` parameter of a LookML `link` along with `toggle=vis`, they completely bypass the default data table, instantly rendering a polished chart (like an Area Trend or Donut Breakdown) for the user during a drill-down. [See Looker Liquid HTML Documentation](https://cloud.google.com/looker/docs/reference/param-field-html).

### Dashboard Extensions & Navigation
- **Dynamic Navigation Bar**: A centralized navigation view provides a consistent, Google-styled header across all dashboards. Available styles include Pill, Tabbed, and Vertical Sidebar.
- **Dashboard Inheritance**: All dashboards utilize `extends: navbaralloydb`, ensuring shared filters (like Database Name) and navigation state persist as users move between views.

---

## Core Components

### Views
- **[`pg_stat_statements`](https://www.postgresql.org/docs/current/pgstatstatements.html)**: The Query Inspector. Tracks the execution details, I/O wait times, and memory spills of all SQL statements.
- **[`pg_stat_activity`](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW)**: The Real-time Pulse. Provides a snapshot of active connections, wait events (locks), and session ages.
- **[`pg_stat_database`](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-DATABASE-VIEW)**: Instance Health. Monitors database-wide metrics including transaction success rates and buffer cache efficiency.
- **[`pg_stat_user_tables`](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-USER-TABLES-VIEW)**: Table Health. Monitors the volume of sequential vs. index scans, row modifications, and "Dead Row" bloat for every table in the database.
- **Daily Snapshot PDTs**: `pg_stat_database_daily_snapshot` and `pg_stat_statements_daily_snapshot` use Looker's [`create_process`](https://cloud.google.com/looker/docs/reference/param-view-create-process) to maintain a permanent history of daily snapshots.
- **Cascading Trends PDT**: `pg_stat_daily_trends` builds upon the snapshot PDTs using defensive SQL math to provide clean, pivot-safe daily deltas for the Pulse dashboard.

### Explores

When monitoring PostgreSQL/AlloyDB system views, it is critical to separate cumulative historical data from real-time snapshot data to avoid "Fact-to-Fact" join fan-outs and filtering artifacts. This block provides specialized explores for each paradigm:

- **AlloyDB Historical Statements (All-Time)**: Focuses on the `pg_stat_statements` "Odometer". This cumulative ledger records total execution time, calls, and I/O wait times since the last stats reset. **Date filters cannot be applied to this explore** because the database does not record timestamps for historical queries. Use this to find the heaviest queries and worst I/O offenders of all time.
- **AlloyDB Real-Time Activity (Live Forensics)**: Focuses on the `pg_stat_activity` "Speedometer". This provides a real-time snapshot of currently open connections, active queries, and stuck sessions. **Date filters are supported** here, as it tracks the `query_start` timestamp of live connections.
- **AlloyDB Historical Trends (Time-Series)**: Relies on the `pg_stat_daily_trends` Cascading PDT. This explore allows for true time-series analysis (e.g., day-over-day CPU usage or TPS trends) and safe pivoting by converting the "Odometer" totals into daily deltas natively in the database.
- **AlloyDB Table Health**: Focuses on `pg_stat_user_tables`. Use this to identify tables that are suffering from missing indexes (high sequential scans) or require vacuuming (high dead row bloat).
- **AlloyDB Performance Monitoring (Combined)**: Kept for backward compatibility. *Warning:* Joining historical statements with real-time activity can cause filtering artifacts (returning 0 rows) if date filters are inadvertently applied to historical metrics.

---

## Principal KPIs & Authoritative References

| KPI Name | Strategic Value | Operational Metric | Official Documentation |
| :--- | :--- | :--- | :--- |
| **Cache Hit Ratio** | **Capacity Planning** | % of requests served from RAM (Target: >99%). Identifies memory pressure. | [PostgreSQL Buffer Cache](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-DATABASE-VIEW) |
| **Looker Workload Share** | **Attribution** | % of total CPU time consumed specifically by Looker-generated queries. | [Google Cloud Performance Optimization](https://cloud.google.com/sql/docs/postgres/optimize-cpu-usage) |
| **Average Latency** | **User Experience** | Mean execution time per SQL call; primary indicator of slowness. | [pg_stat_statements Docs](https://www.postgresql.org/docs/current/pgstatstatements.html) |
| **Disk Wait Time** | **Forensics** | Cumulative time spent waiting for physical disk I/O. Signals missing indexes. | [PostgreSQL I/O Timing](https://www.postgresql.org/docs/current/runtime-config-statistics.html#GUC-TRACK-IO-TIMING) |
| **Temp Blocks Written** | **Memory Health** | Detects memory "spills" to disk. Indicates `work_mem` is too small. | [PostgreSQL Temp Files](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-DATABASE-VIEW) |
| **Stuck Sessions (Locks)** | **Stability** | Count of queries currently blocked by other processes. | [PostgreSQL Lock Monitoring](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW) |
| **Idle in Transaction Age** | **Risk Mitigation** | Detects abandoned sessions blocking VACUUM. High risk for Table Bloat. | [TXID Wraparound & Stuck Transactions](https://cloud.google.com/sql/docs/postgres/txid-wraparound#check-for-stuck-txid) |
| **Transaction Failure Rate**| **App Stability** | Ratio of Rollbacks vs. Commits. Identifies backend application bugs. | [PostgreSQL Stats Collector](https://www.postgresql.org/docs/current/monitoring-stats.html) |

### Justification for the "Idle in Transaction" KPI
The **`idle in transaction`** state ([Official Definition](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW)) is a critical health indicator for PostgreSQL/AlloyDB. It occurs when an application starts a transaction but fails to send a `COMMIT` or `ROLLBACK`. 

**Why it matters:**
1. **Blocks VACUUM:** Prevents the cleanup of dead rows, leading to massive **Table Bloat**.
2. **Transaction ID Exhaustion:** Risk of hitting the 2-billion ID limit ([Wraparound Protection](https://cloud.google.com/sql/docs/postgres/txid-wraparound)), which can force a database shutdown.
3. **Resource Leakage:** Consumes backend process slots and memory without performing work.

---

## Installation and Configuration: The "Decoupled" Architecture

To adhere to enterprise security best practices, this Looker Block uses a "Decoupled" architecture. Looker **does not** connect directly to your production application database (e.g., `global_gadgets_demo`). Instead, Looker connects to the administrative `postgres` database. 

Because `pg_stat_statements` natively tracks metrics for the *entire cluster*, Looker pulls all metrics from the admin database and uses LookML filters to silently isolate the data for your specific application database. This keeps your production application database completely free of Looker users, extensions, and temp tables.

### 1. Database Preparation (Run in the `postgres` database)
Connect your SQL client to your AlloyDB primary instance, specifically connecting to the **`postgres`** database as a superuser. Execute the following command:
```sql
CREATE EXTENSION IF NOT EXISTS pg_stat_statements SCHEMA public;
```
Configure the following AlloyDB instance flags in the Google Cloud Console:
- `pg_stat_statements.track = all`
- `track_io_timing = on`
- `pg_stat_statements.max = 10000`

### 2. User Permissions (Run in the `postgres` database)
Create a dedicated service account for Looker with minimal privileges inside the **`postgres`** database:
```sql
CREATE USER looker_monitor WITH ENCRYPTED PASSWORD 'your_password';
GRANT CONNECT ON DATABASE postgres TO looker_monitor;
GRANT USAGE ON SCHEMA public, pg_catalog TO looker_monitor;
GRANT SELECT ON public.pg_stat_statements TO looker_monitor;
GRANT SELECT ON pg_catalog.pg_stat_activity, pg_catalog.pg_stat_database TO looker_monitor;
GRANT SELECT ON pg_catalog.pg_stat_user_tables TO looker_monitor;
```

### 3. Network Configuration
- Enable **Public IP** on the AlloyDB instance (or configure VPC Peering).
- Add the Looker Egress IP addresses (e.g., `35.237.190.234`) to the **Authorized Networks** list.

### 4. Looker Connection
In the Looker Admin panel, create a new connection using the **Google Cloud AlloyDB for PostgreSQL** dialect. Configure it exactly as follows:
*   **Database:** `postgres` *(Crucial: Do not put your application database here)*
*   **Username:** `looker_monitor`
*   **Additional Params:** `search_path=public,pg_catalog` *(Ensure this matches your `STATEMENTS_SCHEMA` constant)*
*   **Persistent Derived Tables:** Enable this and set the Temp Database to `temp_looker_schema`.

After saving the connection, update the `manifest.lkml` file in this Looker project to route the data correctly:
```lookml
constant: CONNECTION_NAME { value: "cymbal-gadgets-alloydb" } # Match your Looker connection name
constant: DATABASE_NAME { value: "your_application_db" } # The ACTUAL database you want to monitor
```

### 5. Enable Time-Series Tracking (Self-Managed History PDTs)
The `alloydb_historical_trends` explore requires Looker to maintain a permanent history of daily snapshots. Because the underlying PostgreSQL tables (`pg_stat_statements` and `pg_stat_database`) act like "odometers" (constantly increasing cumulative totals without timestamps), standard incremental PDTs suffer from a "sliding window" issue where they only retain the latest day.

**The Solution Architecture:**
1. **Tier 1 (Collectors):** Looker uses the [`create_process`](https://cloud.google.com/looker/docs/reference/param-view-create-process) feature to run a multi-step SQL script inside the scratch schema. This builds a permanent table (e.g., `alloydb_stat_database_history`) and inserts the live cumulative snapshot every night at midnight.
2. **Tier 2 (Cascading Trends):** A secondary PDT (`pg_stat_daily_trends`) cascades from the Tier 1 collectors. It uses SQL window functions to calculate the daily deltas natively in the database (`Today - Yesterday`).
3. **Defensive Math:** Because `pg_stat_statements` actively [evicts older queries to stay under the `max` limit](https://www.postgresql.org/docs/current/pgstatstatements.html#PGSTATSTATEMENTS-CONFIG-PARAMS) (resetting their counters to 0), the Tier 2 PDT employs "Defensive Math" using `CASE` statements. If a query counter drops below yesterday's value (indicating an eviction or reset), the SQL automatically ignores the previous day to prevent negative deltas.

**Configuration:**
For Looker to build these self-managed history tables, the database user configured in Looker (`looker_monitor`) must have permission to write to a scratch schema inside the **`postgres`** database. The schema name is configurable via the `SCRATCH_SCHEMA` constant in `manifest.lkml` (defaults to `temp_looker_schema`). As a superuser connected to `postgres`, run:

```sql
-- 1. Ensure the scratch schema exists
CREATE SCHEMA IF NOT EXISTS temp_looker_schema;

-- 2. Give the Looker user permission to create tables in it
GRANT USAGE, CREATE ON SCHEMA temp_looker_schema TO looker_monitor;

-- 3. Give the Looker user permission to manage the tables it creates
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA temp_looker_schema TO looker_monitor;

-- 4. Ensure future tables created in this schema automatically grant permissions
ALTER DEFAULT PRIVILEGES IN SCHEMA temp_looker_schema GRANT ALL ON TABLES TO looker_monitor;
```

*Note: If your strict enterprise security policies do not allow write access for the Looker service account, the Time-Series explore will not function, but the Live, Table Health, and All-Time explores will continue to work perfectly.*
