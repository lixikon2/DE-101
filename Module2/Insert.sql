

-- insert module2.customer_dim 
insert into module2.customer_dim 
select distinct customer_id,customer_name 
from public.orders --793 rows
	--check result
select count(distinct concat(customer_id,customer_name))
from orders 

-- insert module2.geography_dim

ALTER TABLE module2.geography_dim  --to fix error
ALTER COLUMN state TYPE VARCHAR(50);

insert into module2.geography_dim 
select 100+row_number() over() as geo_id
,country
,region 
,state 
,city 
,case when postal_code::varchar is null then 'null'
else postal_code::varchar 
end as postal_code 
,person as person_manager 
from
(select distinct country,o.region,person,state,city,postal_code,count(*)
from public.orders o left join people p on o.region =p.region
group by country,o.region,person,state,city,postal_code)tab1 ; --623 rows

	--simple check
select distinct postal_code  from orders o where postal_code::varchar not in (select distinct postal_code from module2.geography_dim gd)  

--insert module2.product_dim

ALTER TABLE module2.product_dim --to fix error
ALTER COLUMN subcategory TYPE VARCHAR(80);

ALTER TABLE module2.product_dim --to fix error
ALTER COLUMN segment TYPE VARCHAR(80);

ALTER TABLE module2.product_dim --to fix error,segment later go to the fact_table called sales_fact
DROP COLUMN segment;

ALTER TABLE module2.product_dim --to fix error of duplicating key value product_id: for one product_id can be more than 1 product_name
DROP COLUMN product_name; --will add to the fact table using key product_id+product_name

insert into module2.product_dim
select product_id,category,subcategory
from orders o 
group by category,subcategory,product_id;

--insert module2.calendar_dim
insert into module2.calendar_dim

select case when order_date is not null then order_date
else '1900-01-01' --to avoid null constraint for PK
end as order_date 
,case when ship_date is not null then ship_date 
else '1900-01-01' --to avoid null constraint for PK
end as ship_date
,case when order_date is not null then extract (YEAR FROM order_date)
else extract (YEAR FROM ship_date)
end as year
,case when order_date is not null then extract(QUARTER FROM order_date)
else extract (QUARTER FROM ship_date)
end as quarter
,case when order_date is not null then extract (MONTH FROM order_date)
else extract (MONTH FROM ship_date)
end as month
,case when order_date is not null then extract (WEEK FROM order_date)
else extract (WEEK FROM ship_date)
end as week
,case when order_date is not null then extract (day FROM order_date)
else extract (day FROM ship_date)
end as week_day

from
(select case when mark_order='1' then date
else null
end as order_date
,case when mark_ship='1' then date
else null
end as ship_date

from
(select distinct date,mark_ship,mark_order from
(
select distinct ship_date as date, '1' as mark_ship,null as mark_order from orders o 
union all 
select distinct order_date as date,null as mark_ship , '1' as mark_order from orders o 
)tab1
)tab2
)tab3

--insert module2.shipping_dim
insert into module2.shipping_dim(ship_mode,ship_id)
select ship_mode,100+row_number() over() as ship_id
from (
select distinct ship_mode from orders)tab1


--insert module2.sales_fact
ALTER TABLE module2.sales_fact  
ADD COLUMN product_name VARCHAR(130);


ALTER TABLE module2.sales_fact  
DROP COLUMN quantity;

ALTER TABLE module2.sales_fact  
ADD COLUMN quantity int;



insert into module2.sales_fact
select row_id 
,o.order_id 
,sales 
,discount 
,profit 
,case when r.order_id is not null then 'Yes'
else 'No' 
end as returned
,pd.product_id 
,s.ship_id
,cd.customer_id 
,geo.geo_id 
,cd_o.order_date 
,cd_s.ship_date 
,product_name 
,quantity
from 
orders o 
inner join module2.shipping_dim s on o.ship_mode=s.ship_mode 
inner join module2.geography_dim geo on (o.state=geo.state and o.city=geo.city and o.postal_code::varchar=geo.postal_code) or (o.state=geo.state and o.city=geo.city and geo.postal_code='null')
inner join module2.calendar_dim cd_o on o.order_date=cd_o.order_date --order_date
inner join module2.calendar_dim cd_s on o.ship_date =cd_s.ship_date --ship_date
inner join module2.customer_dim cd on o.customer_id = cd.customer_id 
inner join module2.product_dim pd  on o.product_id = pd.product_id 
left join (select distinct order_id from "returns")r on o.order_id = r.order_id ;

select count(distinct row_id)
from module2.sales_fact sf  --9994 rows as in excel





