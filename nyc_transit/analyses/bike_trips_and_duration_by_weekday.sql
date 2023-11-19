--count & total time of bikes trips by weekday
SELECT
    WEEKDAY(started_at_ts) AS weekday, --Find weekday
    COUNT(*) AS total_trips, --Calculate total number of trips
    SUM(duration_sec) AS total_duration_sec --Calculate total time of trips
FROM {{ ref('mart__fact_all_bike_trips')}}
GROUP BY ALL --Display total for each weekday
