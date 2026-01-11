
{{ config(materialized='table', tags=['dv','sat']) }}
select
  {{ bq_hash_key(["cast(FlightID as string)"]) }} as flight_hk,
  cast(FlightID as string) as flight_id,
  FlightNumber,
  timestamp(ScheduledDepartureDateTime) as scheduled_departure_ts,
  timestamp(ActualDepartureDateTime) as actual_departure_ts,
  timestamp(ArrivalDateTime) as arrival_ts,
  TIMESTAMP_DIFF(timestamp(ActualDepartureDateTime), timestamp(ScheduledDepartureDateTime), MINUTE) as departure_delay_minutes,
  0 as arrival_delay_minutes,
  OriginAirportCode as origin,
  DestinationAirportCode as destination,
  current_timestamp() as load_ts,
  {{ bq_hashdiff(["FlightNumber","scheduled_departure_ts","actual_departure_ts","arrival_ts","origin","destination"]) }} as hashdiff,
  record_source
from {{ ref('stg_flight_details') }}
