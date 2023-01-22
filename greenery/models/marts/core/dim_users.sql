{{
  config(
    materialized='table'
  )
}}

with user_address_table as (
    select distinct 
        user_id
        ,first_name
        ,last_name
        ,email
        ,phone_number
        ,created_at
        ,updated_at
        ,address_id
        ,address
        ,zipcode
        ,state
        ,country
    from {{ ref('int_users')}} 
),

order_intel_table as (
    select 
        user_id
        ,cnt_orders
        ,total_order_value
    from {{ ref('int_order_intel_per_user')}} 
)

select 
    u.*
    , cnt_orders
    , total_order_value
from user_address_table u 
left join order_intel_table o using(user_id)