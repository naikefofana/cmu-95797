-- Find the average time between taxi pick ups per zone

WITH date_diff AS (
    SELECT
        pulocationid,
        pickup_datetime - LAG(pickup_datetime,1) OVER (PARTITION BY zone ORDER BY date) AS diff --Find difference between current and next trip per zone
    FROM {{ ref('mart__fact_all_taxi_trips')}}
)

SELECT
    zone,
    AVG(diff) AS avg_time_between_pickups, --Calculate average time between pick ups
FROM date_diff
LEFT JOIN {{ ref('mart__dim_locations')}} AS locations
ON date_diff.pulocationid = locations.locationid