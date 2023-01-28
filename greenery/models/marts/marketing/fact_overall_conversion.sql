{{
  config(
    materialized='table'
  )
}}

with 

session_info as (
    select 
    date_trunc(day, created_at) date, 
    {{ grouped_event_types('event_type')}}, count(distinct(session_id)) as cnt_sessions
from {{ ref('stg_events')}}
group by 1, 2
order by date    
)

select *
from session_info