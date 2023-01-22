
1) User Repeat Rate:

Assumptions:
- I assume that purchases means orders, as there is no billing table in our greenery project.
- My SQL query looks at the monthly repeat rate (even if we have only one month in our database), the code will work and would give us the 
average monthly repeat rate even with more months in our table

``` 
with user_order_table as 
    (select concat(extract(month, created_at),'-',extract(year, created_at)) as month_year, user_id, count(order_id) as cnt_orders
    from DEV_DB.DBT_SCHREYEREVAGMAILCOM.STG_ORDERS
    group by 1,2),
    
monthly_repeat_rate as     
    (select month_year, count_if(cnt_orders >=2)/count(*) as monthly_user_repeat_rate
    from user_order_table
    group by 1)
select avg(monthly_user_repeat_rate) as avg_monthly_repeat_rate
from monthly_repeat_rate 
```

2) What are good indicators of a user who will likely purchase again? 
What about indicators of users who are likely NOT to purchase again? 
If you had more data, what features would you want to look into to answer this question?

I think a good indicator is a combination of recency and frequency of purchases. So not only how probable it is that a user purchases per month, but also 
when the user last purchased. As we have only one month of data its difficult to build this. 

Indicators of users that are likely not to buy again are if this usual buying pattern breaks - e.g if they usually 
buy 2 items a month and then they stop buying for 3 months, its quite likely that they will not buy again.

