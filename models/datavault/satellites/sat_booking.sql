
{{ config(materialized='table', tags=['dv','sat']) }}
with b as (
  select * from {{ ref('stg_booking_details') }}
), f as (
  select FlightID, OriginAirportCode as origin, DestinationAirportCode as destination from {{ ref('stg_flight_details') }}
), p as (
  select PaymentID, Amount from {{ ref('stg_payment_details') }}
)
select
  {{ bq_hash_key(["cast(b.BookingID as string)"]) }} as booking_hk,
  cast(b.BookingID as string) as booking_id,
  cast(b.PassengerID as string) as customer_id,
  cast(b.FlightID as string) as flight_id,
  date(b.BookingDate) as order_date,
  p.Amount as ticket_price,
  f.origin,
  f.destination,
  current_timestamp() as load_ts,
  {{ bq_hashdiff(["customer_id","flight_id","order_date","ticket_price","origin","destination"]) }} as hashdiff,
  'union.stg_booking_details' as record_source
from b
left join f on b.FlightID = f.FlightID
left join p on b.PaymentID = p.PaymentID
