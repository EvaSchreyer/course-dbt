
{{
  config(
    materialized='table'
  )
}}

select distinct
    product_id
    , name
    , price
    , inventory 
    , cnt_events
    , cnt_sessions
    , cnt_pages

from {{ ref('int_product_page_views')}}