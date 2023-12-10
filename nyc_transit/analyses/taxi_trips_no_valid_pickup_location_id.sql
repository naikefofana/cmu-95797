--Make a query which finds taxi trips which don’t have a pick up location_id in the locations table.

SELECT * 
FROM {{ ref('mart__fact_all_taxi_trips')}} AS taxi
LEFT JOIN {{ ref('mart__dim_locations')}} AS location
ON taxi.pulocationid = location.locationid 
WHERE locationid is NULL;