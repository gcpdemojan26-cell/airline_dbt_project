
{{ config(materialized='table', tags=['dv','sat']) }}
select
  {{ bq_hash_key(["cast(PassengerID as string)"]) }} as customer_hk,
  cast(PassengerID as string) as customer_id,
  FirstName,
  LastName,
  DOB,
  Email,
  current_timestamp() as load_ts,
  {{ bq_hashdiff(["FirstName","LastName","DOB","Email"]) }} as hashdiff,
  record_source
from {{ ref('stg_passenger_details') }}
