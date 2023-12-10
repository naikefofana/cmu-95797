--Write a query to calculate the 7 day moving min, max, avg, sum for precipitation and snow for every day in the weather data, defining the window only once.

SELECT 
    date,
    MIN(prcp) OVER seven_days as min_prcp,
    MAX(prcp) OVER seven_day as max_prcp,
    AVG(prcp) OVER seven_days as avg_prcp,
    MIN(snow) OVER seven_days as min_snow,
    MAX(snow) OVER seven_day as max_snow,
    AVG(snow) OVER seven_days as avg_snow,
FROM {{ ref('stg__central_park_weather')}}

--One definition of window to use with all the aggregates
WINDOW seven_days AS (
    ORDER BY date ASC
    RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND
    INTERVAL 3 DAYS FOLLOWING)