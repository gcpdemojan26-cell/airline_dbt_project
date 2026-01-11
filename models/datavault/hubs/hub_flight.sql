
{{ config(materialized='table', tags=['dv','hub']) }}
select
  {{ bq_hash_key(["cast(FlightID as string)"]) }} as flight_hk,
  cast(FlightID as string) as flight_id,
  current_timestamp() as load_ts,
  record_source as record_source
from {{ ref('stg_flight_details') }}
where FlightID is not null
