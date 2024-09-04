-- energy analysis project
CREATE TABLE energy_analysis (
	hour_of_day smallint,
	datetime_start timestamp,
	solar_generation_kwh numeric(10,8),
	electricity_usage_kwh numeric(10,8)
);
select * from energy_analysis;

alter table energy_analysis
alter column electricity_usage_kwh
type numeric(20,8);

alter table energy_analysis
alter column solar_generation_kwh
type numeric(20,8);

COPY energy_analysis
FROM 'C:\Users\user\Documents\DATA_ANALYSIS\SQL\CSV\energy_analysis_data.csv'
WITH (FORMAT CSV, HEADER);

-- How much solar electricity is generated each day?
SELECT 
    DATE_TRUNC('day', datetime_start) AS day,
    SUM(solar_generation_kwh) AS total_solar_generation
FROM 
    energy_analysis
GROUP BY 
    DATE_TRUNC('day', datetime_start)
ORDER BY 
    day;

-- How does electricity usage vary throughout the day?
SELECT 
    hour_of_day,
    AVG(electricity_usage_kwh) AS avg_usage
FROM 
    energy_analysis
GROUP BY 
    hour_of_day
ORDER BY 
    hour_of_day;

-- How much excess solar electricity is available for storage?
SELECT 
    DATE_TRUNC('day', datetime_start) AS day,
    SUM(solar_generation_kwh - electricity_usage_kwh) AS excess_solar
FROM 
    energy_analysis
GROUP BY 
    DATE_TRUNC('day', datetime_start)
ORDER BY 
    day;

-- What are the potential savings or benefits from using a battery storage system?
SELECT 
    DATE_TRUNC('day', datetime_start) AS day,
    SUM(CASE 
            WHEN solar_generation_kwh > electricity_usage_kwh THEN electricity_usage_kwh
            ELSE solar_generation_kwh
        END) AS energy_used_directly,
    SUM(CASE 
            WHEN solar_generation_kwh > electricity_usage_kwh THEN solar_generation_kwh - electricity_usage_kwh
            ELSE 0
        END) AS energy_stored_in_battery
FROM 
    energy_analysis
GROUP BY 
    DATE_TRUNC('day', datetime_start)
ORDER BY 
    day;
