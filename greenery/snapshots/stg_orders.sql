{{
  config(
    target_database = dev_db,
    target_schema = dbt_schreyerevagmailcom,
    strategy='check',
    unique_key='order_id',
    check_cols=['status'],
   )
}}