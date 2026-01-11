
{{ config(materialized='table', tags=['dv','hub']) }}
select
  {{ bq_hash_key(["cast(PassengerID as string)"]) }} as customer_hk,
  cast(PassengerID as string) as customer_id,
  current_timestamp() as load_ts,
  record_source as record_source
from {{ ref('stg_passenger_details') }}
where PassengerID is not null
