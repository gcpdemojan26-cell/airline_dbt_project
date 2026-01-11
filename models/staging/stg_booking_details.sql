
{{ config(materialized='table') }}
select * from {{ ref('stg_airindia_booking_details') }}
union all
select * from {{ ref('stg_spicejet_booking_details') }}
