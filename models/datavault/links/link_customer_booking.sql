
{{ config(materialized='table', tags=['dv','link']) }}
with base as (
  select
    cast(PassengerID as string) as customer_id,
    cast(BookingID as string) as booking_id,
    cast(FlightID as string) as flight_id,
    date(BookingDate) as order_date
  from {{ ref('stg_booking_details') }}
  where PassengerID is not null and BookingID is not null
)
select
  {{ bq_hash_key(["customer_id","booking_id"]) }} as customer_booking_hk,
  {{ bq_hash_key(["customer_id"]) }} as customer_hk,
  {{ bq_hash_key(["booking_id"]) }} as booking_hk,
  {{ bq_hash_key(["flight_id"]) }} as flight_hk,
  order_date,
  current_timestamp() as load_ts,
  'union.stg_booking_details' as record_source
from base
