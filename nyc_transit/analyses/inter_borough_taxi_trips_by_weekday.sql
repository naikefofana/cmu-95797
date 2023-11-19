-- by weekday, count of total trips, trips starting and ending in a different borough, and percentage w/ different start/end

WITH trips_renamed AS
(
    SELECT
        WEEKDAY(pickup_datetime) AS weekday,
        pulocationid,
        dolocationid,
        pulocation.borough AS borough_pu,
        dolocation.borough AS borough_do
        IF(pulocation.borough != dolocation.borough, 1, 0) AS is_different
    FROM {{ ref('mart__fact_all_taxi_trips') }} AS taxi_trips
    JOIN {{ ref('mart__dim_locations') }} AS pulocation ON pulocationid = locationid
    JOIN {{ ref('mart__dim_locations') }} AS dolocation ON dolocationid = locationid

)

SELECT
    weekday,
    COUNT(*) AS trips,
    SUM(is_different) AS different_borough,
    (SUM(is_different)/COUNT(*))*100 AS perc_diff_borough
FROM trips_renamed
GROUP BY ALL --Display total for each weekday