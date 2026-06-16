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