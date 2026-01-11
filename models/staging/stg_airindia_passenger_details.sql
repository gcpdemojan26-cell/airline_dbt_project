
{{ config(materialized='table', tags=['staging']) }}

select
  *,
  'AirIndia' as record_source,
  current_timestamp() as load_datetime
from {{ ref('Airindia_passenger_details') }}
