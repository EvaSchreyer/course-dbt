

Readme file to answer the questions for week 1 project

    how many users do we have?

    I assume we mean distinct users, so I run this query

select count(distinct(user_id)) as cnt_users from DEV_DB.DBT_SCHREYEREVAGMAILCOM.STG_users

Answer: we have 130 users

    On average, how many orders do we receive per hour? This is the code I use:

with orders_per_hour as (select date_trunc('hour', created_at) as hour, count(distinct(order_id)) cnt from DEV_DB.DBT_SCHREYEREVAGMAILCOM.STG_ORDERS group by hour)

select avg(cnt) from orders_per_hour

Answer: 7.5 orders per hour on average

    How many users have only made one purchase? Two purchases? Three+ purchases? this is the code I use:

with orders_per_user as

  (select user_id, count(distinct(order_id)) as cnt_orders
  from DEV_DB.DBT_SCHREYEREVAGMAILCOM.STG_ORDERS
  group by 1)

select case when cnt_orders >= 3 then 3 else cnt_orders end as number_of_orders_grouped, count(user_id) as cnt_users from orders_per_user group by 1 order by 1

Answer is: 25 users had 1 order 28 had 2 orders 71 had 3 or more

    On average, how many unique sessions do we have per hour? I use this code:

with sessions_per_hour as (select date_trunc('hour', created_at) as hour, count(distinct(session_id)) as cnt_sessions from DEV_DB.DBT_SCHREYEREVAGMAILCOM.STG_EVENTS group by 1)

select avg(cnt_sessions) as avg_sessions_per_hour from sessions_per_hour

Answer: We have 16.3 unique sessions per hour
