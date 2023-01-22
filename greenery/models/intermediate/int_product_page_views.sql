
{{
  config(
    materialized='table'
  )
}}

with 
product_table as (
    select 
        product_id,
        name, 
        price,
        inventory
    from {{ ref('stg_products') }}
),

events_table as (
    SELECT
        event_id,
        session_id,
        user_id,
        event_type,
        page_url,
        created_at,
        order_id,
        product_id
    from {{ ref('stg_events')}}
)

select 
    p.product_id
    , p.name
    , p.price
    , inventory 
    , count(distinct e.event_id) as cnt_events
    , count(distinct session_id) as cnt_sessions
    , count(distinct page_url) as cnt_pages
from product_table p 
left join events_table e using(product_id)
group by 1,2,3,4

