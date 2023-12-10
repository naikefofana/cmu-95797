--Calculate the number of trips and average duration by borough and zone

SELECT 
    borough, 
    zone, 
    COUNT(*) AS total_trips, 
    AVG(duration_min) AS avg_duration_time,
FROM {{ ref('mart__fact_all_taxi_trips')}} AS taxi
    LEFT JOIN {{ ref('mart__dim_locations')}} AS location
    ON taxi.pulocationid = location.locationid 
GROUP BY borough, zone,
ORDER BY borough;