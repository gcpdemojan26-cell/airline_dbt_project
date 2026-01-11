
{{ config(materialized='table') }}
select * from {{ ref('stg_airindia_payment_details') }}
union all
select * from {{ ref('stg_spicejet_payment_details') }}
