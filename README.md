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

### Dashboard Extensions & Navigation
- **Dynamic Navigation Bar**: A centralized navigation view provides a consistent, Google-styled header across all dashboards.
- **Dashboard Inheritance**: All dashboards utilize `extends: navbaralloydb`, ensuring shared filters (like Database Name) and navigation state persist as users move between views.

---

## Core Components

### Views
- **`pg_stat_statements`**: The Query Inspector. Tracks the execution details, I/O wait times, and memory spills of all SQL statements.
- **`pg_stat_activity`**: The Real-time Pulse. Provides a snapshot of active connections, wait events (locks), and session ages.
- **`pg_stat_database`**: Instance Health. Monitors database-wide metrics including transaction success rates and buffer cache efficiency.

### Explores
- **AlloyDB Performance Monitoring**: The unified central hub for all metrics. It intelligently joins query history with real-time session activity and instance health.

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

## Advanced Analytical Features

### 1. Robust Traffic Attribution
Accurately identifies **"Looker BI"** traffic using a three-pronged strategy:
- Explicit `application_name` matching (e.g., 'Looker').
- Driver identification (e.g., 'PostgreSQL JDBC Driver').
- SQL Signature parsing (auto-generated comments like `-- Looker`).

### 2. Live Forensic Intelligence
- **Query & Transaction Age**: Monitors the duration of active sessions to kill "Zombie" queries before they exhaust resources.
- **Lock Detection**: Real-time visibility into sessions stuck waiting for database locks.
- **Parallel Worker Identification**: Tracks multi-threaded query execution to validate instance thread utilization.

### 3. Instance Role Awareness
- **Primary vs. Read Pool**: Automatically detects if a query is running on the Primary (Write) instance or an AlloyDB Read Pool using `pg_is_in_recovery()`.

### 4. Enterprise Security & UX
- **PII Masking**: Centralized logic to redact sensitive information from SQL text across all dashboards with a single constant change.
- **Monospace Formatting**: Renders raw SQL in a clean, code-block format for efficient technical review.
- **Contextual Drilling**: Enables seamless navigation from high-level latency spikes to the exact SQL and I/O metrics causing them.

---

## Installation and Configuration

### 1. Database Preparation
As a superuser, execute the following command in the target database:
```sql
CREATE EXTENSION IF NOT EXISTS pg_stat_statements SCHEMA public;
```
Configure the following AlloyDB instance flags in the Google Cloud Console:
- `pg_stat_statements.track = all`
- `track_io_timing = on`
- `pg_stat_statements.max = 10000`

### 2. User Permissions
Create a dedicated service account for Looker with the following minimal privileges:
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
In the Looker Admin panel, create a new connection using the **Google Cloud AlloyDB for PostgreSQL** dialect. Ensure the `search_path` is set to `public,pg_catalog`.
