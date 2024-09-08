SELECT spend_2019, spend_2022,
round((spend_2022-spend_2019)/spend_2019*100,1) AS percent_change
FROM pct_change
ORDER BY percent_change;

-- Library data
SELECT sum(pls18.visits) AS visits_2018,
sum(pls17.visits) AS visits_2017,
sum(pls16.visits) AS visits_2016
FROM pls_fy2018_libraries pls18
JOIN pls_fy2017_libraries pls17
ON pls18.fscskey = pls17.fscskey
JOIN pls_fy2016_libraries pls16
ON pls18.fscskey = pls16.fscskey
WHERE 
pls18.visits >= 0 AND
pls17.visits >= 0 AND
pls16.visits >= 0;

--summing wifi sessions

SELECT sum(pls18.wifisess) AS wifi_2018,
sum(pls17.wifisess) AS wifi_2017,
sum(pls16.wifisess) AS wifi_2016
FROM pls_fy2018_libraries pls18
JOIN pls_fy2017_libraries pls17
ON pls18.fscskey = pls17.fscskey
JOIN pls_fy2016_libraries pls16
ON pls18.fscskey = pls16.fscskey
WHERE
pls18.wifisess >= 0 AND
pls17.wifisess >= 0 AND
pls16.wifisess >= 0;

-- Using group by to track percentage change in library visits by state

SELECT pls18.stabr,
sum(pls18.visits) AS visits_2018,
sum(pls17.visits) AS visits_2017,
round((CAST(sum(pls18.visits) AS decimal(10,1))-sum(pls17.visits)) /
	 sum(pls17.visits) * 100,2) AS pct_change
FROM pls_fy2018_libraries pls18
JOIN pls_fy2017_libraries pls17
ON pls18.fscskey = pls17.fscskey
WHERE pls18.visits >= 0
AND pls17.visits >= 0
GROUP BY pls18.stabr
ORDER BY pct_change DESC;

-- using group by to track percent change in library visits by state - challenge 2

SELECT
pls18.stabr,
sum(pls18.visits) AS visits_2018,
sum(pls17.visits) AS visits_2017,
sum(pls16.visits) AS visits_2016,
round(((CAST(sum(pls18.visits) AS numeric(10,1)) - sum(pls17.visits)) / sum(pls17.visits)) * 100, 1) AS pct_change_2018_2017,
round((sum(pls17.visits)::decimal(10,1)-sum(pls16.visits))/sum(pls16.visits)*100,1) AS pct_change_2017_2016
FROM pls_fy2018_libraries AS pls18
JOIN pls_fy2017_libraries AS pls17
ON pls18.fscskey = pls17.fscskey
JOIN pls_fy2016_libraries AS pls16
ON pls18.fscskey = pls16.fscskey
WHERE pls18.visits>=0
AND pls17.visits>=0
AND pls16.visits>=0
GROUP BY pls18.stabr
ORDER BY pct_change_2017_2016;

SELECT * FROM pls_fy2018_libraries;

SELECT stabr, count(libname) AS number_of_libraries
FROM pls_fy2018_libraries
GROUP BY stabr
ORDER BY count(libname) DESC;

SELECT count(libname)
FROM pls_fy2018_libraries;

-- Using having clause to filter the result of an aggregate 


-- INSPECTING AND MODIFYING DATA
SELECT * FROM meat_poultry_egg_establishments;

CREATE INDEX company_idx ON meat_poultry_egg_establishments(company);

SELECT COUNT(*) FROM meat_poultry_egg_establishments;

-- this query tells us where we have the same company listed multiple times at the same address
-- or rather, the query finds multiple companies at the same address
SELECT company, street, city, st, count(*) AS address_count
FROM meat_poultry_egg_establishments
GROUP BY company, street, city, st
HAVING count(*) > 1
ORDER BY company, street, city, st;

-- example 2 - checking for missing values
-- let's ask some basic questions that helps us write queries that tell meaningful stories
-- 1. how many of the meat, poultry, and egg processing companies are in each state
SELECT st, count(*) as st_count
from meat_poultry_egg_establishments
group by st
order by st;

-- using IS NULL to find missing values in the st column
select establishment_number,company,city,st,zip
from meat_poultry_egg_establishments
where st is null;

-- scanning the unduplicated values to spot variations in spelling of names of companies and other attributes
-- using GROUP BY and COUNT() to find inconsistent company names
select company, count(*) as company_count
from meat_poultry_egg_establishments
group by company
order by company asc;

-- using length() and count() to test the zip column
select length(zip), count(*) as length_count
from meat_poultry_egg_establishments
group by length(zip)
order by length(zip) asc;

-- Filtering with length() to find short zip values
select st, count(*) as st_count
from meat_poultry_egg_establishments
where length(zip) < 5
group by st
order by st asc;

-- creating a back up table
create table meat_poultry_egg_establishments_backup as
select * from meat_poultry_egg_establishments;

-- check the number of records
select * from meat_poultry_egg_establishments_backup;

select 
(select count(*) from meat_poultry_egg_establishments) as original,
(select count(*) from meat_poultry_egg_establishments_backup) as backup;

-- Creating and filling the st_copy column with ALTER TABLE and UPDATE
ALTER TABLE meat_poultry_egg_establishments ADD COLUMN st_copy text;
select * from meat_poultry_egg_establishments;
UPDATE meat_poultry_egg_establishments
SET st_copy=st;

alter table meat_poultry_egg_establishments
alter column st_copy type varchar(2);

-- checking values in the st and st_copy columns
-- 1. scroll down as you check
select st, st_copy
from meat_poultry_egg_establishments
order by st;

-- 2. alternatively
select st, st_copy
from meat_poultry_egg_establishments
where st is distinct from st_copy
order by st;

-- updating the st column for 3 establishments
update meat_poultry_egg_establishments
set st = 'MN'
where establishment_number = 'V18677A'

UPDATE meat_poultry_egg_establishments
SET st = 'AL'
WHERE establishment_number = 'M45319+P45319';

UPDATE meat_poultry_egg_establishments
SET st = 'WI'
WHERE establishment_number = 'M263A+P263A+V263A'
RETURNING establishment_number, company, city, st, zip; -- this clause returns the specified columns from the updated row(s).

-- This query will return the columns of interest for all the rows you updated in your previous UPDATE statements.
SELECT establishment_number, company, city, st, zip
FROM meat_poultry_egg_establishments
WHERE establishment_number IN ('V18677A', 'M45319+P45319', 'M263A+P263A+V263A');

-- Creating and filling the company_standard column
ALTER TABLE meat_poultry_egg_establishments
ADD COLUMN company_standard varchar(100);

UPDATE meat_poultry_egg_establishments
SET company_standard = company;

select company, company_standard
from meat_poultry_egg_establishments
where company is distinct from company_standard
order by company;

-- Using an UPDATE statement to modify column values that match a string
UPDATE 	meat_poultry_egg_establishments
SET company_standard = 'Armour-Eckrich Meats'
WHERE company LIKE 'Armour%'
RETURNING company, company_standard;

-- query to retrieve the rows that were updated
select company, company_standard
from meat_poultry_egg_establishments
where company ILIKE 'armour%';

-- repairing zip codes using concatenation
select *
from meat_poultry_egg_establishments
where length(zip)<5
order by length(zip);

-- Creating and filling the zip_copy column
ALTER TABLE meat_poultry_egg_establishments
ADD COLUMN zip_copy varchar(5);

UPDATE meat_poultry_egg_establishments
SET zip_copy = zip;

select zip, zip_copy
from meat_poultry_egg_establishments
where zip is distinct from zip_copy;

-- Modify codes in the zip column missing two leading zeros
UPDATE meat_poultry_egg_establishments
SET zip='0'||zip
WHERE st IN ('CT', 'MA', 'ME', 'NJ', 'RI', 'VT')
AND length(zip)=4;

UPDATE meat_poultry_egg_establishments
SET zip = '0' || zip
WHERE st = 'NH'
AND length(zip) = 4;

UPDATE meat_poultry_egg_establishments
SET zip='00'||zip
WHERE st IN ('PR', 'VI') AND length(zip)=3;

-- query that will return all the rows that were affected, by both the update statements

SELECT establishment_number, company, city, st, zip
FROM meat_poultry_egg_establishments
WHERE 
    -- First update: States with 4-digit zip codes prepended with '0'
    (st IN ('CT', 'MA', 'ME', 'NJ', 'RI', 'VT', 'NH') AND length(zip) = 5 AND zip LIKE '0%')
    OR
    -- Second update: Territories with 3-digit zip codes prepended with '00'
    (st IN ('PR', 'VI') AND length(zip) = 5 AND zip LIKE '00%');
	
-- alternatively
SELECT establishment_number, company, city, st, zip
FROM meat_poultry_egg_establishments
WHERE st IN ('CT','MA','ME','NH','NJ','RI','VT','PR','VI');


select length(zip_copy), count(*) as length_count
from meat_poultry_egg_establishments
group by length(zip_copy)
order by length(zip_copy) asc;

select length(zip), count(*) as length_count
from meat_poultry_egg_establishments
group by length(zip)
order by length(zip) asc;

-- Creating and filling a state_regions table
CREATE TABLE state_regions (
	st varchar(2) CONSTRAINT st_key PRIMARY KEY,
	region varchar(20) NOT NULL
);

COPY state_regions
FROM 'C:\Users\user\Documents\DATA_ANALYSIS\SQL\practical-sql-2-main\Chapter_10\state_regions.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM state_regions;

-- Adding and updating an inspection_deadline column
ALTER TABLE meat_poultry_egg_establishments
ADD COLUMN inspection_deadline timestamp with time zone;

UPDATE meat_poultry_egg_establishments establishments
SET inspection_deadline = '2024-12-01 00:00 EAT'
WHERE EXISTS (SELECT state_regions.region
			  FROM state_regions
			  WHERE establishments.st = state_regions.st
			  AND state_regions.region = 'New England'
			  );

select st, region
from state_regions
where region = 'New England'
group by st, region
order by st;

SELECT st, inspection_deadline
FROM meat_poultry_egg_establishments
GROUP BY st, inspection_deadline
ORDER BY st;

SELECT st, inspection_deadline
FROM meat_poultry_egg_establishments
WHERE inspection_deadline IS NOT NULL
GROUP BY st, inspection_deadline
ORDER BY st;

select st, inspection_deadline
from meat_poultry_egg_establishments
where inspection_deadline is not null
order by st;

select est.st, est.inspection_deadline, stat_es.st, stat_es.region
from meat_poultry_egg_establishments est
join state_regions stat_es
on est.st = stat_es.st
order by est.st;

select est.st, est.inspection_deadline, stat_es.st, stat_es.region
from meat_poultry_egg_establishments est
join state_regions stat_es
on est.st = stat_es.st
where est.inspection_deadline is not null
order by est.st;

select est.st, est.inspection_deadline, stat_es.st, stat_es.region
from meat_poultry_egg_establishments est
join state_regions stat_es
on est.st = stat_es.st
where est.inspection_deadline is not null
group by est.st, est.inspection_deadline, stat_es.st, stat_es.region
order by est.st;

-- Deleting rows matching an expression
select st
from meat_poultry_egg_establishments
where st  = 'PR' or st='VI'
order by st;

delete from meat_poultry_egg_establishments
where st in ('PR', 'VI');

select count(*) from meat_poultry_egg_establishments --6201 from 6287

-- Removing a column from a table using DROP
alter table meat_poultry_egg_establishments
drop column zip_copy

-- Demonstrating a transaction block

-- Start transaction and perform update
START TRANSACTION;

UPDATE meat_poultry_egg_establishments
SET company = 'AGRO Merchantss Oakland LLC'
WHERE company = 'AGRO Merchants Oakland, LLC';

-- view changes
SELECT company
FROM meat_poultry_egg_establishments
WHERE company LIKE 'AGRO%'
ORDER BY company;

-- Revert changes
ROLLBACK;

-- Alternately, commit changes at the end:
START TRANSACTION;

UPDATE meat_poultry_egg_establishments
SET company = 'AGRO Merchants Oakland LLC'
WHERE company = 'AGRO Merchants Oakland, LLC';

COMMIT;


-- How many of the plants in the table process meat (using the 'activities' column
select count(company) as meat_processing_plants
from meat_poultry_egg_establishments
where activities ILIKE '%meat%';

-- How many of the plants in the table process poultry (using the 'activities' column)
select count(company) as poultry_processing_plants
from meat_poultry_egg_establishments
where activities ILIKE '%poultry%';

-- Creating two new boolean columns called 'meat_processing' and 'poultry_processing'
alter table meat_poultry_egg_establishments
add column meat_processing boolean,
add column poultry_processing boolean;

-- Updating the 'meat_processing' column to TRUE for companies involved in meat processing
update meat_poultry_egg_establishments
set meat_processing=True
where activities ilike '%meat%';

-- Updating the 'poultry_processing' column to TRUE for companies involved in poultry processing
update meat_poultry_egg_establishments
set poultry_processing=True
where activities ilike '%poultry%';

-- Counting how many companies process meat using the newly created 'meat_processing' column
select count(*) as meat_processing_plants
from meat_poultry_egg_establishments
where meat_processing=true;

-- Counting how many companies process poultry using the newly created 'poultry_processing' column
select count(*) as poultry_processing_plants
from meat_poultry_egg_establishments
where poultry_processing=true;

-- Creating a new column to identify companies that process both meat and poultry
ALTER TABLE meat_poultry_egg_establishments
ADD COLUMN meat_and_poultry_processing BOOLEAN;

-- Updating the 'meat_and_poultry_processing' column to TRUE if the company processes both meat and poultry
update meat_poultry_egg_establishments
set meat_and_poultry_processing=(meat_processing=true and poultry_processing=true);

-- Selecting activities and the newly added columns for all companies
select activities, meat_processing, poultry_processing, meat_and_poultry_processing
from meat_poultry_egg_establishments;

-- Counting how many companies process both meat and poultry based on the 'activities' column
select count(company) as meat_and_poultry_processing_count
from meat_poultry_egg_establishments
where activities ilike '%meat%'
and activities ilike '%poultry%';

-- Alternatively, counting how many companies process both meat and poultry using the 'meat_and_poultry_processing' column
select count(*) as meat_and_poultry_processing_count
from meat_poultry_egg_establishments
where meat_and_poultry_processing=true;

-- Selecting rows where 'meat_and_poultry_processing' is NULL (indicating companies that do neither meat nor poultry processing)
select activities, meat_processing, poultry_processing, meat_and_poultry_processing
from meat_poultry_egg_establishments
where meat_and_poultry_processing is null;

-- Counting how many companies do neither meat nor poultry processing (where 'meat_and_poultry_processing' is NULL)
select count(*) as none_meat_and_none_poultry_processing
from meat_poultry_egg_establishments
where meat_and_poultry_processing is null;

-- Selecting rows where both 'meat_processing' and 'poultry_processing' are NULL
-- This indicates companies that neither process meat nor poultry, and might do something else
select activities, meat_processing, poultry_processing, meat_and_poultry_processing
from meat_poultry_egg_establishments
where meat_processing is null
and poultry_processing is null;

-- The questions on how many companies engage in meat processing and how many engage in poultry processing could  have been answered pretty easily without the need for extra columns but there is value in having dedicated boolean columns for clear and consistent analysis

-- these additional columns have several other benefits
-- 1. clear classification: we now have astructures way to filter companies that do meat processing, poultry processing, or both, without worrying about inconsistent or irrellevant data in the `activities` column.

-- 2. Handling NULL values: With boolean columns, I have easily differentiated rows that do not have either activity or even null values in the `activities`

-- 3. Better performance: querying boolean columns for true/false is often more efficient than repeatedly using text based filters like ilike
