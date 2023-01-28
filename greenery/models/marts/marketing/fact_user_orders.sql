
{{
  config(
    materialized='table'
  )
}}

with user_table as (
    select distinct
        user_id
        , zipcode
        , state
        , country
    from {{ ref('int_users')}}
),

order_intel_table as (
    select 
        user_id
        , cnt_orders
        , total_order_value
        , avg_order_value
        , total_order_value_shipping_incl

    from {{ ref('int_order_intel_per_user')}}
)

select 
    user_id
    , zipcode
    , state
    , country
    , cnt_orders
    , total_order_value
    , avg_order_value
    , total_order_value_shipping_incl
from user_table
inner join order_intel_table using(user_id)