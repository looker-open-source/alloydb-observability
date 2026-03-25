# Operational Intelligence - AlloyDB Performance Block

This Looker project provides a comprehensive observability suite for monitoring the health, performance, and real-time activity of a Google Cloud AlloyDB for PostgreSQL instance.

## Overview
By connecting Looker directly to your AlloyDB instance, this project surfaces internal system metrics that are typically hidden or difficult to access. This allows database administrators and developers to identify bottlenecks, optimize queries, and monitor database health in real-time.

---

## Core Dashboards

### 1. Executive Health Overview
High-level view of database stability. Includes active connections, cache hit ratio, and 7-day query volume.

### 2. Query Performance & Bottleneck Analysis
Identify slow queries impacting Looker or your application. Features the **Query Inspector** table with monospace SQL formatting.

### 3. Looker Workload Impact
Correlate Looker's BI traffic to AlloyDB's system performance. Identifies queries originating specifically from Looker vs. other applications.

---

## Key Components & Architecture

### Raw vs. Refined Views
This project follows Google's best practices for Looker Blocks using the **Refinement Pattern**:
- **`views/raw/`**: Contains base views that are 1:1 mappings with the database schema. No business logic or formatting is applied here.
- **`views/refined/`**: Extends the raw views using the `+` refinement syntax. This is where we add:
    - Business logic and custom measures (e.g., Cache Hit Ratio).
    - Descriptive `label`, `group_label`, and `description` tags for every field.
    - **Liquid HTML Formatting**: Color-coded severity indicators for latency and status.
    - **Drill Fields**: Deep-dive paths from high-level KPIs to raw SQL statements.

### Looker Workload Identification
Refined views include logic to identify queries originating from Looker dashboard refreshes and explores, allowing for precise attribution of database load.

---

## Project Structure
- **Model**: `operational_intelligence_alloy_db.model.lkml` - The entry point for the project.
- **`manifest.lkml`**: Contains global constants for easy connection management.
- **`views/`**: Organized into `raw` and `refined` folders.
- **`explores/`**: Contains the `alloydb_performance` and `pg_stat_activity` Explore definitions.
- **`dashboards/`**: Includes pre-built LookML dashboards.

---

## Setup & Customer Journey

### Phase 1: AlloyDB Preparation
1. Ensure your AlloyDB cluster has the `pg_stat_statements` extension enabled.
2. Set database flags (`log_statement=all` and `log_min_duration_statement=0`) to ensure logs are populated.

### Phase 2: User Permissions
1. Create a dedicated `looker_monitor` user in AlloyDB.
2. Grant `SELECT` permissions on `public.pg_stat_statements` and the `pg_catalog` schema.

### Phase 3: Looker Connection
1. Add a connection in Looker named `alloydb` (or update the constant in `manifest.lkml`).
2. Authorize Looker's IP addresses in your AlloyDB instance "Authorized Networks" settings.

### Phase 4: Installation
1. Install this Block via the Looker Marketplace or clone the repository.
2. Provide your connection name during the setup flow.

---

## Maintenance & Support
1. **Validate LookML**: Ensure no errors are reported in the Looker IDE.
2. **Deploy**: Push changes to production to enable the monitoring suite for your organization.
