create table superstore_sales (
	row_id bigserial primary key,
	order_id varchar(50),
	order_date text,
	ship_date text,
	ship_mode varchar(50),
	customer_id varchar(50),
	customer_name varchar(50),
	segment varchar(100),
	country varchar(100),
	city varchar(100),
	state_name varchar(50),
	postal_code text,
	region varchar(50),
	product_id varchar(50),
	category varchar(50),
	subcategory varchar(50),
	product_name text,
	sales numeric(10,2)
);

select * from superstore_sales;

copy superstore_sales
from 'C:\Users\user\Documents\DATA_ANALYSIS\SQL\CSV\superstore_sales.csv'
with(format csv, header);

ALTER TABLE superstore_sales 
ALTER COLUMN order_date TYPE timestamptz USING to_timestamp(order_date, 'DD/MM/YYYY'),
ALTER COLUMN ship_date TYPE timestamptz USING to_timestamp(ship_date, 'DD/MM/YYYY');

select * from super_store_sales;

select count(order_id) from super_store_sales;

select sum(sales) as sales_amount from super_store_sales;

select round(avg(sales),2) as average_sales from super_store_sales;
-- Total sales by region
select
	region,
	sum(sales) as total_sales
from super_store_sales
group by region
order by total_sales desc;
-- Total sales by state
select
	state_name as states,
	sum(sales) as total_sales
from super_store_sales
group by states
order by total_sales desc;
-- Top selling products
select
	product_name as product,
	sum(sales) as total_sales
from super_store_sales
group by product
order by total_sales desc
limit 10;
-- Total number of distinct products
select
	count(distinct product_name)
from super_store_sales;
-- Monthly sales trend
select
	extract(month from order_date) as month,
	to_char(order_date, 'Month') as month_name,
	sum(sales) as monthly_sales
from super_store_sales
group by
	extract(month from order_date),
	to_char(order_date, 'Month')
order by 1;
-- shipping delay
select
	ship_mode,
	round(avg(ship_date - order_date),2) as avg_shipping_days,
	count(*) as total_orders
from super_store_sales
group by ship_mode
order by avg_shipping_days;
-- customer order frequency distribution
with customer_orders as (
	select
		customer_id,
		segment,
		count(distinct order_id) as total_distinct_orders
	from super_store_sales
	group by 1,2
)
select
	segment,
	total_distinct_orders,
	count(customer_id) as customer_count
from customer_orders
group by segment, total_distinct_orders
order by segment, total_distinct_orders;
-- most common category combination
select
	a.category as product_a,
	b.category as product_b,
	count(distinct a.order_id) as times_purchased_together
from super_store_sales a
join super_store_sales b
	on a.order_id = b.order_id
	and a.category < b.category
group by a.category, b.category
order by times_purchased_together desc;