SELECT 
    borough,
    COUNT(*) AS total_taxi_trips
FROM {{ ref('mart__fact_all_taxi_trips')}} AS trips
LEFT JOIN {{ ref('mart__dim_locations')}} AS locations
ON trips.pulocationid = locations.locationid
GROUP BY ALL