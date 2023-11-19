SELECT
    type,
    DATE_TRUNC('day', started_at_ts)::date AS date,
    COUNT(*) AS trips,
    AVG(duration_min) AS average_trip_duration_min
FROM {{ ref('mart__fact_all_trips')}}
GROUP BY ALL