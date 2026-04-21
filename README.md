# Operational Intelligence - AlloyDB Performance Block

The AlloyDB Performance Block provides a comprehensive observability suite for monitoring the health, performance, and real-time activity of Google Cloud AlloyDB for PostgreSQL instances. By connecting Looker directly to internal system tables, this block surfaces metrics typically hidden from standard BI tools, enabling proactive database optimization and resource management.

---

## Architecture and Design Patterns

This project adheres to Google's recommended design patterns for modular and scalable LookML development.

### Two-Layer Refinement
- **Raw Layer (`/views/raw/`)**: Contains base views that are 1:1 mappings of the AlloyDB system tables. These files remain untouched by business logic to ensure ease of maintenance and schema alignment.
- **Refined Layer (`/views/refined/`)**: Implements Looker refinements (`+view_name`) to layer on business logic, descriptive metadata, and advanced measures without modifying the underlying schema mapping.

### Global Configuration (Marketplace Ready)
The project utilizes a `manifest.lkml` file with several constants for plug-and-play deployment:
- **`CONNECTION_NAME`**: The name of the Looker connection.
- **`DATABASE_NAME`**: The primary application database to monitor.
- **`STATEMENTS_SCHEMA`**: The schema where the `pg_stat_statements` extension is installed.
- **`PII_QUERY_TEXT`**: A security toggle (`SHOW`/`HIDE`) to mask sensitive SQL text.
- **`MAX_CONNECTIONS`**: Used for Connection Saturation KPI calculations.

### Advanced Drilling & Visualization Library
The `manifest.lkml` also includes a set of highly optimized, triple-escaped JSON constants (e.g., `DRILL_LINE_VIZ`, `DRILL_PIE_VIZ`). These constants define exact Looker visualization configurations. When injected into the `url` parameter of a LookML `link` along with `toggle=vis`, they completely bypass the default data table, instantly rendering a polished chart (like an Area Trend or Donut Breakdown) for the user during a drill-down.

### Dashboard Extensions & Navigation
- **Dynamic Navigation Bar**: A centralized navigation view provides a consistent, Google-styled header across all dashboards. Available styles include Pill, Tabbed, and Vertical Sidebar.
- **Dashboard Inheritance**: All dashboards utilize `extends: navbaralloydb`, ensuring shared filters (like Database Name) and navigation state persist as users move between views.

---

## Core Components

### Views
- **`pg_stat_statements`**: The Query Inspector. Tracks the execution details, I/O wait times, and memory spills of all SQL statements.
- **`pg_stat_activity`**: The Real-time Pulse. Provides a snapshot of active connections, wait events (locks), and session ages.
- **`pg_stat_database`**: Instance Health. Monitors database-wide metrics including transaction success rates and buffer cache efficiency.
- **Daily Snapshot PDTs**: `pg_stat_database_daily_snapshot` and `pg_stat_statements_daily_snapshot` use Looker's Incremental PDT feature to track daily performance changes.

### Explores

When monitoring PostgreSQL/AlloyDB system views, it is critical to separate cumulative historical data from real-time snapshot data to avoid "Fact-to-Fact" join fan-outs and filtering artifacts. This block provides specialized explores for each paradigm:

- **AlloyDB Historical Statements (All-Time)**: Focuses on the `pg_stat_statements` "Odometer". This cumulative ledger records total execution time, calls, and I/O wait times since the last stats reset. **Date filters cannot be applied to this explore** because the database does not record timestamps for historical queries. Use this to find the heaviest queries and worst I/O offenders of all time.
- **AlloyDB Real-Time Activity (Live Forensics)**: Focuses on the `pg_stat_activity` "Speedometer". This provides a real-time snapshot of currently open connections, active queries, and stuck sessions. **Date filters are supported** here, as it tracks the `query_start` timestamp of live connections.
- **AlloyDB Historical Trends (Time-Series)**: Uses Incremental Persistent Derived Tables (PDTs) to take a daily snapshot of the cumulative historical tables. By calculating the daily delta (the difference between today's total and yesterday's total using window functions like `LAG()`), this explore allows for true time-series analysis (e.g., daily CPU usage or TPS trends) that standard PostgreSQL tables cannot support natively.
- **AlloyDB Performance Monitoring (Combined)**: Kept for backward compatibility. *Warning:* Joining historical statements with real-time activity can cause filtering artifacts (returning 0 rows) if date filters are inadvertently applied to historical metrics.

---

## Principal KPIs

| KPI Name | Strategic Value | Operational Metric |
| :--- | :--- | :--- |
| **Cache Hit Ratio** | **Capacity Planning** | % of requests served from RAM (Target: >99%). Identifies memory pressure. |
| **Looker Workload Share** | **Attribution** | % of total CPU time consumed specifically by Looker-generated queries. |
| **Average Latency** | **User Experience** | Mean execution time per SQL call; primary indicator of slowness. |
| **Disk Wait Time** | **Forensics** | Cumulative time spent waiting for physical disk I/O. Signals missing indexes. |
| **Temp Blocks Written** | **Memory Health** | Detects memory "spills" to disk. Indicates `work_mem` is too small for Looker queries. |
| **Stuck Sessions (Locks)** | **Stability** | Count of queries currently blocked by other processes. Early warning for deadlocks. |
| **Transaction Failure Rate**| **App Stability** | Ratio of Rollbacks vs. Commits. Identifies backend application bugs. |

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

### 5. Enable Persistent Derived Tables (PDTs) for Time-Series Tracking
The `alloydb_historical_trends` explore requires Looker to create daily snapshot tables. Because the underlying PostgreSQL tables (`pg_stat_statements`) act like "odometers" (constantly increasing cumulative totals without timestamps), Looker must use Incremental PDTs to capture the total each day. It then calculates the exact amount of work done *that day* (the "Delta") by subtracting yesterday's snapshot from today's snapshot using SQL window functions (`LAG()`).

For Looker to build these daily snapshot tables, the database user configured in Looker (`looker_monitor`) must have permission to write to a scratch schema inside the **`postgres`** database. As a superuser connected to `postgres`, run:

```sql
-- 1. Ensure the scratch schema exists (Looker uses temp_looker_schema by default)
CREATE SCHEMA IF NOT EXISTS temp_looker_schema;

-- 2. Give the Looker user permission to create tables in it
GRANT USAGE, CREATE ON SCHEMA temp_looker_schema TO looker_monitor;

-- 3. Give the Looker user permission to manage the tables it creates
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA temp_looker_schema TO looker_monitor;

-- 4. Ensure future tables created in this schema automatically grant permissions
ALTER DEFAULT PRIVILEGES IN SCHEMA temp_looker_schema GRANT ALL ON TABLES TO looker_monitor;
```

*Note: If your strict enterprise security policies do not allow write access for the Looker service account, the Time-Series explore will not function, but the Live and All-Time explores will continue to work perfectly.*
