
{{ config(materialized='table') }}
select * from {{ ref('stg_airindia_flight_details') }}
union all
select * from {{ ref('stg_spicejet_flight_details') }}
