
-- DEBUG: confirm dataset resolution at compile-time
-- select '{{ target.database }}' as project, '{{ target.schema }}' as schema

{{ config(materialized='table') }}

with booking as (
    select
        BookingID,
        PassengerID,
        FlightID,
        BookingDate,
        record_source
    from {{ ref('stg_airindia_booking_details') }}
),

passenger as (
    select
        PassengerID,
        FirstName,
        LastName,
        DOB,
        Email,
        MobileNumber,
        record_source as passenger_record_source
    from (
      select * except(MobileNumber) from {{ ref('stg_airindia_passenger_details') }}
      left join (select PassengerID as pid, MobileNumber from {{ ref('stg_spicejet_passenger_details') }}) using(pid)
    )
)

select
    b.BookingID,
    b.PassengerID,
    b.FlightID,
    b.BookingDate as order_date,
    b.record_source,
    -- optionally enrich from passenger:
    p.FirstName,
    p.LastName,
    p.DOB,
    p.Email,
    p.MobileNumber,
    p.passenger_record_source,
    current_timestamp() as load_datetime
from booking b
left join passenger p
  on b.PassengerID = p.PassengerID
