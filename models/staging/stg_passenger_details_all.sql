
{{ config(materialized='table') }}
select * from {{ ref('stg_airindia_passenger_details') }}
union all
select * from {{ ref('stg_spicejet_passenger_details') }}
