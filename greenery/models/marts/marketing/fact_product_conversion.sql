{{
  config(
    materialized='table'
  )
}}

with product_info_table as (
    select distinct 
        product_id, 
        name
    from {{ ref('dim_products')}}    
),

product_view_table as (
    select 
    product_id, 
    count(distinct(session_id)) as cnt_product_views
from {{ref ('stg_events')}}
where product_id is not null
group by 1
),

product_purchase_table as (
    select 
        o.product_id, count(distinct(session_id)) as cnt_product_purchase_sessions
from {{ ref('stg_events')}} e
inner join {{ ref('stg_order_items')}} o on e.order_id = o.order_id
group by 1
)

select 
    product_id,
    name, 
    cnt_product_views,
    cnt_product_purchase_sessions
from product_info_table
inner join product_view_table using(product_id)
inner join product_purchase_table using(product_id)