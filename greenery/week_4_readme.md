
**DBT Snapshots - which orders changed since last time?**

Somehow I don't see any changes - maybe because I snapshotted irregularly in the week between as I had to set it up new.
The query that I did use is 

select distinct order_id
from  DEV_DB.DBT_SCHREYEREVAGMAILCOM.ORDERS_SNAPSHOT
where dbt_updated_at = '2023-02-03'

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
for that I create a new table **fact_product_funnel_data** within the marketing folder




