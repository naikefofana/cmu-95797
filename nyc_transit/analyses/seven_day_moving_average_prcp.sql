--Write a query to calculate the 7 day moving average precipitation for every day in the weather data.

SELECT 
    date,
    AVG(prcp) OVER seven_days as avg_prcp_7_day_moving --calculate average precipitation over 3 dqys prior and 3 days after
FROM {{ ref('stg__central_park_weather')}}

WINDOW seven_days AS (
    ORDER BY date ASC
    RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND
    INTERVAL 3 DAYS FOLLOWING)