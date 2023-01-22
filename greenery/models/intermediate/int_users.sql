

{{
  config(
    materialized='table'
  )
}}

with 
user_table as (
    select 
        user_id
        ,first_name
        ,last_name
        ,email
        ,phone_number
        ,created_at
        ,updated_at
        ,address_id
    from {{ ref('stg_users') }}
), 
address_table as (
    select
        address_id
        ,address
        ,zipcode
        ,state
        ,country 
    from {{ ref('stg_addresses') }}
)

SELECT distinct
        u.*
        ,a.address
        ,zipcode
        ,state
        ,country

    from user_table u
    left join address_table a using(address_id)


