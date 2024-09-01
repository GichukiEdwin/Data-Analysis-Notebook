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
