
{{ config(materialized='table', tags=['dv','hub']) }}
select
  {{ bq_hash_key(["cast(origin as string)", "cast(destination as string)"]) }} as route_hk,
  origin,
  destination,
  current_timestamp() as load_ts,
  record_source as record_source
from {{ ref('stg_routes') }}
