
# airline_dbt_project (Complete)

This project includes uploaded source CSVs as **dbt seeds**, staging models (including your requested `stg_*` unions), simplified **Data Vault** structures, and **KPI marts** for BigQuery. Seeds are typed per `metadata.csv`.

## Quick start
```bash
pip install dbt-bigquery
cp profiles-example.yml ~/.dbt/profiles.yml
# edit project, dataset, and keyfile

dbt deps
dbt seed --full-refresh
dbt run --select tag:dv
dbt run --select tag:kpi
dbt test
```

## Variables
- `start_date`, `end_date` control KPI windows
- `top_n` controls frequent flyers
