# Operational Intelligence - AlloyDB Performance Block

The AlloyDB Performance Block provides a comprehensive observability suite for monitoring the health, performance, and real-time activity of Google Cloud AlloyDB for PostgreSQL instances. By connecting Looker directly to internal system tables, this block surfaces metrics typically hidden from standard BI tools, enabling proactive database optimization and resource management.

---

## Architecture and Design Patterns

This project adheres to Google's recommended design patterns for modular and scalable LookML development.

### Two-Layer Refinement
- **Raw Layer (`/views/raw/`)**: Contains base views that are 1:1 mappings of the AlloyDB system tables. These files remain untouched by business logic to ensure ease of maintenance and schema alignment.
- **Refined Layer (`/views/refined/`)**: Implements Looker refinements (`+view_name`) to layer on business logic, descriptive metadata, and advanced measures without modifying the underlying schema mapping.

### Global Configuration
- **Manifest Constants**: The project utilizes a `manifest.lkml` file with a `CONNECTION_NAME` constant. This allows for seamless deployment across different environments by defining the connection string in a single location.

---

## Core Components

### Views
- **`pg_stat_statements`**: The Query Inspector. Tracks the execution details of all SQL statements to identify bottlenecks and resource-intensive patterns.
- **`pg_stat_activity`**: The Real-time Pulse. Provides a snapshot of active connections, current wait events, and executing query text.
- **`pg_stat_database`**: Instance Health. Monitors high-level database metrics including transaction success rates and buffer cache efficiency.

### Explores
- **AlloyDB Performance Metrics**: The primary analytics interface that joins query-level data with database-wide health metrics.
- **AlloyDB Live Connections**: A dedicated interface for real-time monitoring of concurrent users and session states.

---

## Principal KPIs

| KPI Name | LookML Measure | Operational Metric |
| :--- | :--- | :--- |
| **Cache Hit Ratio** | `cache_hit_ratio` | Percentage of data served from RAM vs. Disk (Target: >99%). |
| **Looker Workload Share** | `workload_share` | Percentage of CPU time consumed specifically by Looker-generated queries. |
| **Average Latency** | `average_execution_time_ms` | Mean execution time per query call; primary indicator of user experience. |
| **Total Database Load** | `total_execution_time_ms` | Cumulative time spent by the database engine processing queries. |
| **Active Connections** | `active_connections` | Count of concurrent query executions occurring in real-time. |
| **Transaction Stability** | `total_commits` vs `total_rollbacks` | Ratio of successful vs. failed operations; identifies application-level instability. |

---

## Advanced Analytical Features

- **Looker Workload Identification**: Automatically categorizes queries originating from Looker dashboards or explores via SQL comment parsing.
- **Monospace SQL Formatting**: Renders raw SQL strings in a clean, code-block format within Looker tables for efficient technical review.
- **Contextual Drilling**: Enables seamless navigation from high-level performance KPIs directly to the underlying SQL statements via Liquid-based drill paths.
- **Logical Grouping**: Organizes dimensions and measures into intuitive UI folders such as *Execution Metrics* and *Traffic Analysis*.

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
- Add the Looker Egress IP addresses to the **Authorized Networks** list.

### 4. Looker Connection
In the Looker Admin panel, create a new connection using the **Google Cloud AlloyDB for PostgreSQL** dialect. Ensure the `search_path` is set to `public,pg_catalog`.

### 5. Deployment
Validate the LookML within the project and deploy to production to enable the observability suite.
