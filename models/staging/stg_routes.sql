
{{ config(materialized='table') }}
select distinct
  OriginAirportCode as origin,
  DestinationAirportCode as destination,
  record_source,
  current_timestamp() as load_datetime
from {{ ref('stg_flight_details') }}
where OriginAirportCode is not null and DestinationAirportCode is not null
