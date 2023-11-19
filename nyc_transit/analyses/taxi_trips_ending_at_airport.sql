-- total number of trips ending in service_zones 'Airports' or 'EWR'

SELECT 
    COUNT(*) AS taxi_trips_ending_at_airports
FROM {{ ref('mart__fact_all_taxi_trips')}}
JOIN {{ ref('mart__dim_locations') }}
ON dolocationid = locationid
WHERE service_zone == 'Airports' OR service_zone == 'EWR'