
**DBT Snapshots - which orders changed since last time?**

Somehow I don't see any changes - maybe because I snapshotted irregularly in the week between as I had to set it up new.
The query that I did use is 

select distinct order_id
from  DEV_DB.DBT_SCHREYEREVAGMAILCOM.ORDERS_SNAPSHOT
where dbt_updated_at = '2023-02-03'

To present something these are the order_ids that had the latest change in my snapshot table:
- c0873253-7827-4831-aa92-19c38372e58d
- 29d20dcd-d0c4-4bca-a52d-fc9363b5d7c6
- e2729b7d-e313-4a6f-9444-f7f65ae8db9a

**Modelling Challenge for a Product Funnel**
To be able to not only see our product funnel overall but also by certain dates I need to create a model that contains the following info:
- product_id
- product_name
- session_id
- user_id
- created_at as date
- page_view yes/no
- add_to_cart yes/no
- checkout_yes/no
for that I create a new table **fact_product_funnel_data** within the marketing folder with some tests for logic

This is the query I created then in snowflake to get the funnel info:
select 
    product_name, 
    (select count(distinct(session_id)) from DEV_DB.DBT_SCHREYEREVAGMAILCOM.fact_product_funnel_data) as overall_sessions,
    sum(page_view) as page_views,
    sum(add_to_cart) as add_to_carts,
    sum(checkout) as checkouts
from DEV_DB.DBT_SCHREYEREVAGMAILCOM.fact_product_funnel_data
group by 1
(I was not able to create a funnel in Sigma ...)





