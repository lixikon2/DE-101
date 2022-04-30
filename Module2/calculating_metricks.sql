
--example of product metricks
	--sales by product category over years

select --extract(year from order_date) as year, another variant
date_part('year',order_date) as year
,category
,sum(sales)::bigint as total_sales
from orders o 
group by year,category 
order by year,category  asc;

--example of customer analysis
	--top 5 customers by total_sales amount
select customer_name 
,sum(sales)::bigint as total_sales
from orders o 
group by customer_name  
order by total_sales desc
limit 5;

--example of overview metricks
	--adhoc from marketing: which cities of Illinois have average discount more than 60%?
select 
avg(discount) as avg_discount
,state
,city
from orders o 
where state='Illinois'
group by state,city 
having avg(discount)>=0.6
order by avg_discount desc;

