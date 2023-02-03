
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

order_item_table as (
    select 
        product_id,
        order_id
    from {{ ref('stg_order_items')}}
),

event_table as (
    select 
        user_id, session_id, event_type, coalesce(e.product_id, oi.product_id) as product_id, date(created_at) as date
    from {{ ref('stg_events')}} e
    inner join order_item_table oi using(product_id)
)
select
    product_id, 
    name as product_name, 
    session_id, 
    user_id,
    date, 
    count_if(event_type = 'page_view') as page_view,
    count_if(event_type = 'add_to_cart') as add_to_cart,
    count_if(event_type = 'checkout') as checkout
    from event_table
    inner join product_info_table using(product_id)
group by 1,2,3,4,5
order by 1
