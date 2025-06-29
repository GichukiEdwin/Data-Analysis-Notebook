CREATE TABLE customers (
	customer_code VARCHAR(45),
	customer_name VARCHAR(45),
	customer_type VARCHAR(45)
);

CREATE TABLE dates (
	da_te DATE,
	cy_date DATE,
	ye_ar SMALLINT,
	month_name VARCHAR(45),
	date_yy_mmmmm VARCHAR(45)
);

CREATE TABLE markets (
	market_code VARCHAR(45),
	market_name VARCHAR(45),
	zo_ne VARCHAR(45)
);

CREATE TABLE products (
	product_code VARCHAR(45),
	product_type VARCHAR(45)
);

CREATE TABLE transactions (
	product_code VARCHAR(45),
	customer_code VARCHAR(45),
	market_code VARCHAR(45),
	order_date DATE,
	sales_qty SMALLINT,
	sales_amount NUMERIC(10,1),
	currency VARCHAR(45)
);

COPY customers
FROM 'C:\Users\user\Documents\DATA_ANALYSIS\DataAnalysisProjects\1_SalesInsights\customer.csv'
WITH (FORMAT CSV, HEADER);

SELECT count(*) FROM dates;

select *
from transactions
inner join dates
on transactions.order_date = dates.da_te
where dates.ye_ar=2020;

select sum(sales_amount)
from transactions
inner join dates
on transactions.order_date = dates.da_te
where dates.ye_ar=2020 and transactions.market_code='Mark001';
