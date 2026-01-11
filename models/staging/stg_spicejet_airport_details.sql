
{{ config(materialized='table', tags=['staging']) }}

select
  *,
  'SpiceJet' as record_source,
  current_timestamp() as load_datetime
from {{ ref('SpiceJet_airport_details') }}
