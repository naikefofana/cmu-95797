-- Write a query to compare an individual fare to the zone, borough and overall average fare using the fare_amount in yellow taxi trip data.

SELECT 
    borough,
    zone,
    fare_amount,
    AVG(fare_amount) OVER (PARTITION BY zone) AS avg_zone, --Calculate the average fare of zone
    AVG(fare_amount) OVER (PARTITION BY borough) AS avg_borough, --Calculate the average fare of borough
    AVG(fare_amount) AS avg_overall, --Calculate the overall average fare
FROM {{ ref('stg__yellow_tripdata')}} AS yellow
LEFT JOIN {{ ref('mart__dim_locations')}} AS locations
ON yellow.pulocationid = locations.locationid