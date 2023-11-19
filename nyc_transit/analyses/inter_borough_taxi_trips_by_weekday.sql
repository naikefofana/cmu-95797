-- by weekday, count of total trips, trips starting and ending in a different borough, and percentage w/ different start/end

WITH trips_renamed AS
(
    
    SELECT
        WEEKDAY(pickup_datetime) AS weekday,
        pulocationid,
        dolocationid,
        pulocation.borough AS borough_pu,
        dolocation.borough AS borough_do,
        IF(pulocation.borough != dolocation.borough, 1, 0) AS is_different
    FROM mart__fact_all_taxi_trips AS taxi_trips
    JOIN mart__dim_locations AS pulocation ON pulocationid == pulocation.locationid
    JOIN mart__dim_locations AS dolocation ON dolocationid == dolocation.locationid

)

SELECT
    weekday,
    COUNT(*) AS trips, --Calculate total trips
    SUM(is_different) AS different_borough, --Calculate total trips starting and ending at different borough
    (SUM(is_different)/COUNT(*))*100 AS perc_diff_borough --Calculate % of total trips starting and ending at different borough
FROM trips_renamed
GROUP BY ALL --Display total for each weekday