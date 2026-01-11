
{{ config(materialized='table') }}
select Airport_Code, Airport_Name, record_source, load_datetime from {{ ref('stg_airindia_airport_details') }}
union distinct
select Airport_Code, Airport_Name, record_source, load_datetime from {{ ref('stg_spicejet_airport_details') }}
