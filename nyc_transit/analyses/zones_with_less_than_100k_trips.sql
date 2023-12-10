--Write a query which finds all the Zones where there are less than 100000 trips.

SELECT 
    zone, 
    COUNT(*) AS total_trips, 
FROM {{ ref('mart__fact_all_taxi_trips')}} AS taxi
LEFT JOIN {{ ref('mart__dim_locations')}} AS location 
ON taxi.pulocationid = location.locationid 
GROUP BY zone 
HAVING total_trips < 100000